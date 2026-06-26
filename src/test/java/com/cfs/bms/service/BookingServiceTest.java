package com.cfs.bms.service;

import com.cfs.bms.dto.BookingDto;
import com.cfs.bms.dto.BookingRequestDto;
import com.cfs.bms.enums.BookingStatus;
import com.cfs.bms.enums.PaymentStatus;
import com.cfs.bms.enums.SeatStatus;
import com.cfs.bms.exception.ResourceNotFoundException;
import com.cfs.bms.exception.SeatUnavailableException;
import com.cfs.bms.model.*;
import com.cfs.bms.repository.BookingRepository;
import com.cfs.bms.repository.ShowRepository;
import com.cfs.bms.repository.ShowSeatRepository;
import com.cfs.bms.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookingServiceTest {

    @Mock private UserRepository userRepository;
    @Mock private ShowRepository showRepository;
    @Mock private ShowSeatRepository showSeatRepository;
    @Mock private BookingRepository bookingRepository;

    @InjectMocks
    private BookingService bookingService;

    private User testUser;
    private Show testShow;
    private ShowSeat testShowSeat;
    private Booking testBooking;
    private BookingRequestDto bookingRequest;

    @BeforeEach
    void setUp() {

        testUser = new User();
        testUser.setId(1L);
        testUser.setName("Devansh Gupta");
        testUser.setEmail("devansh@test.com");
        testUser.setPhoneNumber("9555979103");
        testUser.setRole("USER");

        Movie movie = new Movie();
        movie.setId(1L);
        movie.setTitle("Inception");
        movie.setDescription("A mind-bending thriller");
        movie.setLanguage("English");
        movie.setGenre("Sci-Fi");
        movie.setDurationMins(148);
        movie.setReleaseDate("2010-07-16");
        movie.setPosterUrl("https://example.com/inception.jpg");

        Theater theater = new Theater();
        theater.setId(1L);
        theater.setName("PVR Cinemas");
        theater.setAddress("Mall Road");
        theater.setCity("Kanpur");
        theater.setTotalScreens("5");

        Screen screen = new Screen();
        screen.setId(1L);
        screen.setName("Screen 1");
        screen.setTotalSeats(100);
        screen.setTheater(theater);

        testShow = new Show();
        testShow.setId(1L);
        testShow.setStartTime(LocalDateTime.now().plusDays(1));
        testShow.setEndTime(LocalDateTime.now().plusDays(1).plusHours(2));
        testShow.setMovie(movie);
        testShow.setScreen(screen);

        Seat seat = new Seat();
        seat.setId(1L);
        seat.setSeatNumber("A1");
        seat.setSeatType("REGULAR");
        seat.setBasePrice(BigDecimal.valueOf(200));

        testShowSeat = new ShowSeat();
        testShowSeat.setId(1L);
        testShowSeat.setShow(testShow);
        testShowSeat.setSeat(seat);
        testShowSeat.setStatus(SeatStatus.AVAILABLE);
        testShowSeat.setPrice(BigDecimal.valueOf(250));

        Payment payment = new Payment();
        payment.setId(1L);
        payment.setAmount(BigDecimal.valueOf(250));
        payment.setPaymentMethod("CARD");
        payment.setPaymentTime(LocalDateTime.now());
        payment.setStatus(PaymentStatus.SUCCESS);
        payment.setTransactionId("txn-test-123");

        testBooking = new Booking();
        testBooking.setId(1L);
        testBooking.setBookingNumber("BMS-UUID-123");
        testBooking.setBookingTime(LocalDateTime.now());
        testBooking.setUser(testUser);
        testBooking.setShow(testShow);
        testBooking.setStatus(BookingStatus.CONFIRMED);
        testBooking.setTotalAmount(BigDecimal.valueOf(250));
        testBooking.setPayment(payment);

        bookingRequest = new BookingRequestDto();
        bookingRequest.setUserId(1L);
        bookingRequest.setShowId(1L);
        bookingRequest.setSeatIds(List.of(1L));
        bookingRequest.setPaymentMethod("CARD");
    }

    @Test
    void createBooking_success_returnsBookingDto() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));
        when(showRepository.findById(1L)).thenReturn(Optional.of(testShow));
        when(showSeatRepository.findSeatsForBooking(List.of(1L)))
                .thenReturn(List.of(testShowSeat));
        when(showSeatRepository.saveAll(anyList())).thenReturn(List.of(testShowSeat));
        when(bookingRepository.save(any(Booking.class))).thenReturn(testBooking);

        BookingDto result = bookingService.createBooking(bookingRequest);

        assertNotNull(result);
        assertEquals(BookingStatus.CONFIRMED, result.getStatus());
        assertEquals(0, BigDecimal.valueOf(250).compareTo(result.getTotalAmount()));
        assertEquals("Devansh Gupta", result.getUser().getName());

        verify(showSeatRepository, times(2)).saveAll(anyList());
        verify(bookingRepository, times(1)).save(any(Booking.class));
    }

    @Test
    void createBooking_seatAlreadyBooked_throwsSeatUnavailableException() {
        testShowSeat.setStatus(SeatStatus.BOOKED);

        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));
        when(showRepository.findById(1L)).thenReturn(Optional.of(testShow));
        when(showSeatRepository.findSeatsForBooking(List.of(1L)))
                .thenReturn(List.of(testShowSeat));

        SeatUnavailableException ex = assertThrows(
                SeatUnavailableException.class,
                () -> bookingService.createBooking(bookingRequest)
        );

        assertTrue(ex.getMessage().contains("A1"));
        verify(bookingRepository, never()).save(any());
    }

    @Test
    void createBooking_userNotFound_throwsResourceNotFoundException() {
        when(userRepository.findById(anyLong())).thenReturn(Optional.empty());

        ResourceNotFoundException ex = assertThrows(
                ResourceNotFoundException.class,
                () -> bookingService.createBooking(bookingRequest)
        );

        assertEquals("User Not Found", ex.getMessage());
        verify(showRepository, never()).findById(anyLong());
        verify(bookingRepository, never()).save(any());
    }

    @Test
    void cancelBooking_success_setsStatusCancelledAndReleasesSeats() {
        testShowSeat.setStatus(SeatStatus.BOOKED);
        testShowSeat.setBooking(testBooking);

        when(bookingRepository.findById(1L)).thenReturn(Optional.of(testBooking));
        when(showSeatRepository.findByBookingId(1L)).thenReturn(List.of(testShowSeat));
        when(bookingRepository.save(any(Booking.class))).thenReturn(testBooking);
        when(showSeatRepository.saveAll(anyList())).thenReturn(List.of(testShowSeat));

        BookingDto result = bookingService.cancelBooking(1L);

        assertEquals(BookingStatus.CANCELLED, testBooking.getStatus());

        assertEquals(SeatStatus.AVAILABLE, testShowSeat.getStatus());
        assertNull(testShowSeat.getBooking());

        assertEquals(PaymentStatus.REFUNDED, testBooking.getPayment().getStatus());

        assertNotNull(result);
        verify(showSeatRepository, times(1)).saveAll(anyList());
        verify(bookingRepository, times(1)).save(any(Booking.class));
    }

    @Test
    void cancelBooking_bookingNotFound_throwsResourceNotFoundException() {
        when(bookingRepository.findById(anyLong())).thenReturn(Optional.empty());

        ResourceNotFoundException ex = assertThrows(
                ResourceNotFoundException.class,
                () -> bookingService.cancelBooking(999L)
        );

        assertEquals("Booking Not found", ex.getMessage());
        verify(showSeatRepository, never()).findByBookingId(anyLong());
        verify(showSeatRepository, never()).saveAll(anyList());
    }

    @Test
    void getBookingById_success_returnsBookingDto() {
        when(bookingRepository.findById(1L)).thenReturn(Optional.of(testBooking));
        when(showSeatRepository.findByBookingId(1L)).thenReturn(List.of(testShowSeat));

        BookingDto result = bookingService.getBookingById(1L);

        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("BMS-UUID-123", result.getBookingNumber());
        assertEquals(BookingStatus.CONFIRMED, result.getStatus());
    }

    @Test
    void getBookingById_notFound_throwsResourceNotFoundException() {
        when(bookingRepository.findById(anyLong())).thenReturn(Optional.empty());

        ResourceNotFoundException ex = assertThrows(
                ResourceNotFoundException.class,
                () -> bookingService.getBookingById(999L)
        );

        assertEquals("Booking Not Found", ex.getMessage());
        verify(showSeatRepository, never()).findByBookingId(anyLong());
    }

}