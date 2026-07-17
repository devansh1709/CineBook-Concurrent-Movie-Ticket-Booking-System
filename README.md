# 🎬 CineBook — Concurrent Movie Ticket Booking System

A backend system for movie ticket booking built with **Spring Boot 4** and **Java 21**.
Focuses on correctness under concurrency, JWT-secured APIs, and clean layered architecture.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 21 |
| Framework | Spring Boot 4.0.3 |
| Security | Spring Security 7 · JWT (jjwt 0.12.6) |
| Database | MySQL · Spring Data JPA · Hibernate |
| Validation | Spring Validation · Bean Validation 3 |
| Testing | JUnit 5 · Mockito |
| Documentation | Swagger UI · SpringDoc OpenAPI 3 |
| Build | Maven |

---

## Key Engineering Decisions

### 1. Pessimistic Locking — eliminates double-booking
Concurrent seat selection is handled with `@Lock(LockModeType.PESSIMISTIC_WRITE)` on the seat query.
When two users try to book the same seat simultaneously, the second transaction waits for the first to
complete — preventing double-booking at the database level.

```java
@Lock(LockModeType.PESSIMISTIC_WRITE)
@Query("SELECT s FROM ShowSeat s WHERE s.id IN :seatIds")
List<ShowSeat> findSeatsForBooking(@Param("seatIds") List<Long> seatIds);
```

### 2. Three-state seat lifecycle
Seats move through a controlled lifecycle modelled as a Java enum:

```
AVAILABLE → LOCKED → BOOKED
```

On cancellation: `BOOKED → AVAILABLE` (seat released back, booking reference cleared).

### 3. BigDecimal for all monetary values
`totalAmount` and `price` use `BigDecimal` — never `double` or `float` — to prevent floating-point
precision errors in financial calculations.

### 4. JWT Authentication
Stateless authentication via Bearer tokens. Passwords stored as BCrypt hashes.
Public endpoints: movie browsing, auth. Protected endpoints: booking operations.

### 5. Global Exception Handling
All errors return consistent JSON via `@ControllerAdvice`:
```json
{
  "timestamp": "2026-01-15T10:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Seat A1 is not available",
  "path": "/api/bookings"
}
```

---

## Domain Model

```
Theater (1) ──── (N) Screen (1) ──── (N) Show
                                          │
Movie (1) ────────────────────────────────┘
                                          │
                              Show (1) ── (N) ShowSeat ── (N) Seat
                                          │
                              Booking (1) ─── (1) Payment
                                   │
                              User (1) ── (N) Booking
```

**9 JPA entities:** Movie · Theater · Screen · Show · Seat · ShowSeat · Booking · Payment · User

---

## API Reference

> ⚠️ **Only the endpoints below are actually wired up.** `ShowService`, `TheaterService`, and
> `UserService` exist in the codebase and contain real logic (e.g. show lookup, seat availability
> computation), but none of them are currently backed by a `@RestController`. There is no way to
> create a `Show` or `Theater` through the API today — `bookingRequest.getShowId()` must reference a
> row inserted directly into the database (e.g. via `docker/mysql/init.sql` seed data or a manual
> insert). If you need working `/api/shows` and `/api/theaters` endpoints, that's the next thing to
> build — see [Roadmap](#roadmap).

### Auth — Public
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/register` | Register new user, returns JWT |
| POST | `/api/auth/login` | Login, returns JWT |

**Register request:**
```json
{
  "name": "Devansh Gupta",
  "email": "devansh@example.com",
  "password": "password123",
  "phoneNumber": "9555979103"
}
```
**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "email": "devansh@example.com",
  "name": "Devansh Gupta"
}
```

---

### Movies — Public
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/movies` | Add a movie |
| GET | `/api/movies/{id}` | Get movie by ID |
| GET | `/api/movies` | Get all movies |

---

### Bookings — Requires JWT
All booking endpoints require an `Authorization: Bearer <token>` header.

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/bookings` | Create booking (pessimistic lock on seats) |
| GET | `/api/bookings/{id}` | Get booking by ID |
| GET | `/api/bookings/number/{bookingNumber}` | Get booking by booking number |
| GET | `/api/bookings/user/{userId}` | Get all bookings for a user |
| DELETE | `/api/bookings/{id}` | Cancel booking (releases seats, refunds payment) |

**Create booking request:**
```json
{
  "userId": 1,
  "showId": 1,
  "seatIds": [1, 2],
  "paymentMethod": "CARD"
}
```

**Response includes:** booking number · seat list · payment info.

---

## Setup & Running

### Prerequisites
- Java 21
- MySQL 8+
- Maven 3.9+

### 1. Clone the repository
```bash
git clone https://github.com/devansh1709/CineBook-Concurrent-Movie-Ticket-Booking-System.git
cd CineBook-Concurrent-Movie-Ticket-Booking-System
```

### 2. Create MySQL database
```sql
CREATE DATABASE bms_db;
```

### 3. Set environment variables
```bash
# Linux / Mac
export DB_PASSWORD=your_mysql_password
export JWT_SECRET=bms_super_secret_key_minimum_256_bits_long_use_a_real_secret

# Windows (Command Prompt)
set DB_PASSWORD=your_mysql_password
set JWT_SECRET=bms_super_secret_key_minimum_256_bits_long_use_a_real_secret
```

### 4. Run the application
```bash
mvn spring-boot:run
```

Server starts at: `http://localhost:8080` (default Spring Boot port — no `server.port` override is
set in `application.properties`, and both `Dockerfile` and `docker-compose.yml` also expose `8080`).

### 5. Run with Docker Compose
```bash
docker compose up --build
```
This starts a MySQL 8.4 container plus the backend container, wired together with a healthcheck so the
app waits for MySQL to be ready before starting.

---

## Swagger UI

Once the app is running, access interactive API documentation at:

```
http://localhost:8080/swagger-ui/index.html
```

Use `/api/auth/login` first, copy the token, then click **Authorize** in Swagger and paste
`Bearer <token>`.

---

## Testing

**7 unit tests** for `BookingService` using JUnit 5 + Mockito:

| Test | Scenario |
|---|---|
| `createBooking_success_returnsBookingDto` | Happy path — booking created, seats LOCKED → BOOKED |
| `createBooking_seatAlreadyBooked_throwsSeatUnavailableException` | Seat not AVAILABLE — exception thrown, no booking saved |
| `createBooking_userNotFound_throwsResourceNotFoundException` | Invalid userId — fails fast, show never queried |
| `cancelBooking_success_setsStatusCancelledAndReleasesSeats` | Booking cancelled, seats → AVAILABLE, payment → REFUNDED |
| `cancelBooking_bookingNotFound_throwsResourceNotFoundException` | Invalid bookingId — exception thrown |
| `getBookingById_success_returnsBookingDto` | Booking fetched and mapped to DTO |
| `getBookingById_notFound_throwsResourceNotFoundException` | Missing ID — exception thrown |

Run tests:
```bash
mvn test
```

---

## Project Structure

```
src/main/java/com/cfs/bms/
├── controller/
│   ├── AuthController.java         POST /api/auth/**
│   ├── BookingController.java      /api/bookings/**
│   └── MoviesController.java       /api/movies/**
├── service/
│   ├── AuthService.java            register + login logic
│   ├── BookingService.java         core booking + cancel logic
│   ├── MovieService.java
│   ├── ShowService.java            show lookup/creation logic — not yet exposed via a controller
│   ├── TheaterService.java         theater/screen logic — not yet exposed via a controller
│   └── UserService.java            user lookup logic — not yet exposed via a controller
├── security/
│   ├── JwtService.java             token generation + validation
│   ├── JwtAuthFilter.java          Bearer token interceptor
│   ├── SecurityConfig.java         route permissions + stateless session
│   └── UserDetailsServiceImpl.java Spring Security user loading
├── model/                          9 JPA entities
├── dto/                            13 request/response DTOs
├── repository/                     JPA repositories
├── exception/
│   ├── GlobalExceptionHandler.java @ControllerAdvice
│   ├── ResourceNotFoundException.java
│   └── SeatUnavailableException.java
└── enums/
    ├── SeatStatus.java             AVAILABLE · LOCKED · BOOKED
    ├── BookingStatus.java          CONFIRMED · CANCELLED
    └── PaymentStatus.java          SUCCESS · FAILED · REFUNDED
```

---

## Postman Testing Flow

1. **Register** — `POST /api/auth/register` → copy the token from response
2. **Add a Movie** — `POST /api/movies`
3. **Seed a Show manually** — no `/api/shows` endpoint exists yet, so insert a `Show`/`ShowSeat` row
   directly into MySQL (or via `docker/mysql/init.sql`) to get a `showId` and seat IDs to book against
4. **Book tickets** — `POST /api/bookings` with `Authorization: Bearer <token>`
5. **Cancel booking** — `DELETE /api/bookings/{id}` with `Authorization: Bearer <token>`

---

## Roadmap

- [ ] Expose `ShowController` and `TheaterController` so shows/screens/showtimes can be created and
      queried through the API instead of seeded directly in the database
- [ ] Expose a read-only `UserController` endpoint (`GET /api/users/{id}`) — `UserService` already has
      the logic
- [ ] Auto-expire `LOCKED` seats that are never paid for (currently nothing releases a seat stuck in
      `LOCKED` if a booking is abandoned mid-flow)
- [ ] Pagination on `GET /api/movies`

---

## Author

**Devansh Gupta**  
B.Tech CSE 2027 · Pranveer Singh Institute of Technology, Kanpur  
[LinkedIn](https://www.linkedin.com/in/devansh-gupta-720960285/) · [GitHub](https://github.com/devansh1709) · [LeetCode](https://leetcode.com/devansh1709)
