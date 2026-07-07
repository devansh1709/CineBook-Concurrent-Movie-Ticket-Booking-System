use bms_db;

DELETE FROM show_seats;
DELETE FROM payments;
DELETE FROM bookings;
DELETE FROM shows;
DELETE FROM seats;
DELETE FROM screens;
DELETE FROM theaters;
DELETE FROM movies;
DELETE FROM users;

INSERT INTO users (id, name, email, password, phone_number, role) VALUES
(1,  'Aarav Sharma',      'aarav.sharma@gmail.com',   '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9876543210', 'USER'),
(2,  'Priya Verma',       'priya.verma@gmail.com',    '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9823456781', 'USER'),
(3,  'Rohit Mehta',       'rohit.mehta@outlook.com',  '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9712345678', 'USER'),
(4,  'Sneha Kapoor',      'sneha.kapoor@yahoo.com',   '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9654321987', 'USER'),
(5,  'Vikram Nair',       'vikram.nair@gmail.com',    '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9567890123', 'USER'),
(6,  'Ananya Singh',      'ananya.singh@gmail.com',   '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9445678901', 'USER'),
(7,  'Karan Malhotra',    'karan.m@icloud.com',       '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9334567892', 'USER'),
(8,  'Divya Pillai',      'divya.pillai@gmail.com',   '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9223456783', 'USER'),
(9,  'Admin User',        'admin@bookmyshow.com',      '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9000000001', 'ADMIN'),
(10, 'Test User',         'test@test.com',             '$2a$12$TqDPNIJZfzIv5QjLjJ9X4.lVq3Yc0JhkHFbS1OT3OyGqkR9Pk/3i', '9000000002', 'USER');

INSERT INTO movies (id, title, description, language, genre, duration_mins, release_date, poster_url) VALUES
(1,  'Stree 2',
     'Stree returns with a bigger supernatural threat to Chanderi. The gang must face their fears one more time in this hit horror-comedy sequel.',
     'Hindi', 'Horror-Comedy', 143, '2024-08-15',
     'https://m.media-amazon.com/images/M/MV5BMzljOTgzMDYtNTUyZi00NzZkLTk5NmUtMzYwZmI1M2ZmM2FmXkEyXkFqcGc@.jpg'),

(2,  'Kalki 2898 AD',
     'A sci-fi mythological epic set in a dystopian future where the final avatar of Vishnu is prophesied to be born.',
     'Telugu', 'Sci-Fi/Action', 181, '2024-06-27',
     'https://upload.wikimedia.org/wikipedia/en/5/57/Kalki_2898_AD.jpg'),

(3,  'Pushpa: The Rule',
     'The red sandalwood smuggler Pushpa Raj expands his empire and faces the ultimate showdown with SP Bhanwar Singh Shekawat.',
     'Telugu', 'Action-Drama', 210, '2024-12-05',
     'https://upload.wikimedia.org/wikipedia/en/b/b4/Pushpa_The_Rule_Part_2_poster.jpg'),

(4,  'Deadpool & Wolverine',
     'Wade Wilson teams up with Wolverine in the MCU multiverse for the most irreverent superhero film ever made.',
     'English', 'Superhero/Comedy', 128, '2024-07-26',
     'https://upload.wikimedia.org/wikipedia/en/c/c6/Deadpool_and_Wolverine_poster.jpg'),

(5,  'Dune: Part Two',
     'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family.',
     'English', 'Sci-Fi/Epic', 166, '2024-03-01',
     'https://upload.wikimedia.org/wikipedia/en/5/52/Dune_Part_Two_poster.jpg'),

(6,  'Chandu Champion',
     'The extraordinary true story of India''s first Paralympic gold medalist, Murlikant Petkar, brought to life with stunning performances.',
     'Hindi', 'Biographical-Drama', 135, '2024-06-14',
     'https://upload.wikimedia.org/wikipedia/en/a/ab/Chandu_Champion_poster.jpg'),

(7,  'Alien: Romulus',
     'A group of young space colonisers stumble upon a derelict space station and come face-to-face with the most terrifying life form in the universe.',
     'English', 'Sci-Fi/Horror', 119, '2024-08-16',
     'https://upload.wikimedia.org/wikipedia/en/f/f8/Alien_Romulus_poster.jpg'),

(8,  'Singham Again',
     'DCP Bajirao Singham launches a massive manhunt to rescue his wife Avni while battling the formidable demon king Danger Lanka.',
     'Hindi', 'Action', 170, '2024-11-01',
     'https://upload.wikimedia.org/wikipedia/en/8/87/Singham_Again_poster.jpg');

     INSERT INTO theaters (id, name, address, city, total_screens) VALUES
(1,  'PVR Cinemas – Phoenix Palassio',    'Phoenix Palassio Mall, Sultanpur Road',         'Lucknow',  '7'),
(2,  'INOX – Lulu Mall',                  'Lulu Mall, Amar Shaheed Path',                  'Lucknow',  '5'),
(3,  'Cinepolis – Eldeco Centre',         'Eldeco Centre, Raibareli Road',                 'Lucknow',  '4'),
(4,  'PVR IMAX – Select Citywalk',        'Select CITYWALK Mall, Saket',                   'Delhi',    '11'),
(5,  'INOX – Nehru Place',                'DLF Promenade, Vasant Kunj',                    'Delhi',    '8'),
(6,  'PVR Cinemas – Phoenix Marketcity', 'Phoenix Marketcity, Kurla West',                'Mumbai',   '12'),
(7,  'IMAX Wadala – PVR',                 'R-City Mall, Ghatkopar West',                   'Mumbai',   '6'),
(8,  'PVR Cinemas – Forum Mall',          'Forum Mall, Koramangala',                       'Bengaluru','9'),
(9,  'INOX – Garuda Mall',                'Magrath Road, Ashok Nagar',                     'Bengaluru','5'),
(10, 'Cinepolis – VR Chennai',            'Grand Southern Trunk Road, Guindy',             'Chennai',  '6');

 INSERT INTO screens (id, name, total_seats, theater_id) VALUES
-- Theater 1  (Lucknow – PVR Palassio)
(1,  'Audi 1 – IMAX',    280, 1),
(2,  'Audi 2 – 4DX',     140, 1),
(3,  'Audi 3 – Standard',180, 1),
-- Theater 2  (Lucknow – INOX Lulu)
(4,  'Screen 1 – Gold',  120, 2),
(5,  'Screen 2 – Prime', 160, 2),
(6,  'Screen 3 – Club',  200, 2),
-- Theater 3  (Lucknow – Cinepolis)
(7,  'Hall A – VIP',     100, 3),
(8,  'Hall B – Standard',150, 3),
(9,  'Hall C – Budget',  200, 3),
-- Theater 4  (Delhi – PVR IMAX Saket)
(10, 'IMAX Platinum',    300, 4),
(11, 'Screen 2 – Luxe',  160, 4),
(12, 'Screen 3 – Std',   200, 4),
-- Theater 5  (Delhi – INOX)
(13, 'Sapphire – Gold',  120, 5),
(14, 'Emerald – Std',    200, 5),
(15, 'Ruby – Budget',    180, 5),
-- Theater 6  (Mumbai – PVR Phoenix)
(16, 'Screen 1 – IMAX',  320, 6),
(17, 'Screen 2 – 4DX',   150, 6),
(18, 'Screen 3 – Prm',   200, 6),
-- Theater 7  (Mumbai – IMAX Wadala)
(19, 'IMAX Screen',      400, 7),
(20, 'Audi 2 – Std',     200, 7),
(21, 'Audi 3 – Std',     200, 7),
-- Theater 8  (Bengaluru – PVR Forum)
(22, 'Screen 1 – Gold',  140, 8),
(23, 'Screen 2 – Std',   200, 8),
(24, 'Screen 3 – Std',   180, 8),
-- Theater 9  (Bengaluru – INOX Garuda)
(25, 'Hall 1 – Prime',   150, 9),
(26, 'Hall 2 – Std',     200, 9),
(27, 'Hall 3 – Budget',  220, 9),
-- Theater 10 (Chennai – Cinepolis VR)
(28, 'Cine 1 – VIP',     120, 10),
(29, 'Cine 2 – Std',     200, 10),
(30, 'Cine 3 – Budget',  240, 10);

INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',750.00,1),('A2','RECLINER',750.00,1),('A3','RECLINER',750.00,1),('A4','RECLINER',750.00,1),('A5','RECLINER',750.00,1),
('B1','PREMIUM',450.00,1),('B2','PREMIUM',450.00,1),('B3','PREMIUM',450.00,1),('B4','PREMIUM',450.00,1),('B5','PREMIUM',450.00,1),
('B6','PREMIUM',450.00,1),('B7','PREMIUM',450.00,1),('B8','PREMIUM',450.00,1),('B9','PREMIUM',450.00,1),('B10','PREMIUM',450.00,1),
('C1','ECONOMY',250.00,1),('C2','ECONOMY',250.00,1),('C3','ECONOMY',250.00,1),('C4','ECONOMY',250.00,1),('C5','ECONOMY',250.00,1),
('C6','ECONOMY',250.00,1),('C7','ECONOMY',250.00,1),('C8','ECONOMY',250.00,1),('C9','ECONOMY',250.00,1),('C10','ECONOMY',250.00,1);

 INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',900.00,2),('A2','RECLINER',900.00,2),('A3','RECLINER',900.00,2),('A4','RECLINER',900.00,2),('A5','RECLINER',900.00,2),
('B1','PREMIUM',600.00,2),('B2','PREMIUM',600.00,2),('B3','PREMIUM',600.00,2),('B4','PREMIUM',600.00,2),('B5','PREMIUM',600.00,2),
('C1','ECONOMY',350.00,2),('C2','ECONOMY',350.00,2),('C3','ECONOMY',350.00,2),('C4','ECONOMY',350.00,2),('C5','ECONOMY',350.00,2);

 INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',500.00,3),('A2','RECLINER',500.00,3),('A3','RECLINER',500.00,3),('A4','RECLINER',500.00,3),('A5','RECLINER',500.00,3),
('B1','PREMIUM',300.00,3),('B2','PREMIUM',300.00,3),('B3','PREMIUM',300.00,3),('B4','PREMIUM',300.00,3),('B5','PREMIUM',300.00,3),
('C1','ECONOMY',180.00,3),('C2','ECONOMY',180.00,3),('C3','ECONOMY',180.00,3),('C4','ECONOMY',180.00,3),('C5','ECONOMY',180.00,3);

INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',800.00,4),('A2','RECLINER',800.00,4),('A3','RECLINER',800.00,4),('A4','RECLINER',800.00,4),('A5','RECLINER',800.00,4),
('B1','PREMIUM',500.00,4),('B2','PREMIUM',500.00,4),('B3','PREMIUM',500.00,4),('B4','PREMIUM',500.00,4),('B5','PREMIUM',500.00,4),
('C1','ECONOMY',280.00,4),('C2','ECONOMY',280.00,4),('C3','ECONOMY',280.00,4),('C4','ECONOMY',280.00,4),('C5','ECONOMY',280.00,4);

INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',650.00,5),('A2','RECLINER',650.00,5),('A3','RECLINER',650.00,5),('A4','RECLINER',650.00,5),('A5','RECLINER',650.00,5),
('B1','PREMIUM',380.00,5),('B2','PREMIUM',380.00,5),('B3','PREMIUM',380.00,5),('B4','PREMIUM',380.00,5),('B5','PREMIUM',380.00,5),
('C1','ECONOMY',200.00,5),('C2','ECONOMY',200.00,5),('C3','ECONOMY',200.00,5),('C4','ECONOMY',200.00,5),('C5','ECONOMY',200.00,5);

INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',1100.00,10),('A2','RECLINER',1100.00,10),('A3','RECLINER',1100.00,10),('A4','RECLINER',1100.00,10),('A5','RECLINER',1100.00,10),
('B1','PREMIUM', 650.00,10),('B2','PREMIUM', 650.00,10),('B3','PREMIUM', 650.00,10),('B4','PREMIUM', 650.00,10),('B5','PREMIUM', 650.00,10),
('B6','PREMIUM', 650.00,10),('B7','PREMIUM', 650.00,10),('B8','PREMIUM', 650.00,10),('B9','PREMIUM', 650.00,10),('B10','PREMIUM',650.00,10),
('C1','ECONOMY', 350.00,10),('C2','ECONOMY', 350.00,10),('C3','ECONOMY', 350.00,10),('C4','ECONOMY', 350.00,10),('C5','ECONOMY', 350.00,10),
('C6','ECONOMY', 350.00,10),('C7','ECONOMY', 350.00,10),('C8','ECONOMY', 350.00,10),('C9','ECONOMY', 350.00,10),('C10','ECONOMY',350.00,10);

 INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',1200.00,16),('A2','RECLINER',1200.00,16),('A3','RECLINER',1200.00,16),('A4','RECLINER',1200.00,16),('A5','RECLINER',1200.00,16),
('B1','PREMIUM', 700.00,16),('B2','PREMIUM', 700.00,16),('B3','PREMIUM', 700.00,16),('B4','PREMIUM', 700.00,16),('B5','PREMIUM', 700.00,16),
('C1','ECONOMY', 400.00,16),('C2','ECONOMY', 400.00,16),('C3','ECONOMY', 400.00,16),('C4','ECONOMY', 400.00,16),('C5','ECONOMY', 400.00,16);

INSERT INTO seats (seat_number, seat_type, base_price, screen_id) VALUES
('A1','RECLINER',900.00,22),('A2','RECLINER',900.00,22),('A3','RECLINER',900.00,22),('A4','RECLINER',900.00,22),('A5','RECLINER',900.00,22),
('B1','PREMIUM',520.00,22),('B2','PREMIUM',520.00,22),('B3','PREMIUM',520.00,22),('B4','PREMIUM',520.00,22),('B5','PREMIUM',520.00,22),
('C1','ECONOMY',290.00,22),('C2','ECONOMY',290.00,22),('C3','ECONOMY',290.00,22),('C4','ECONOMY',290.00,22),('C5','ECONOMY',290.00,22);

INSERT INTO shows (id, start_time, end_time, movie_id, screen_id) VALUES
(1,  '2025-07-01 10:00:00', '2025-07-01 12:23:00', 1, 1),
(2,  '2025-07-01 14:00:00', '2025-07-01 16:23:00', 1, 1),
(3,  '2025-07-01 19:00:00', '2025-07-01 21:23:00', 1, 1),
(4,  '2025-07-01 11:00:00', '2025-07-01 13:23:00', 1, 2),
(5,  '2025-07-01 16:00:00', '2025-07-01 18:23:00', 1, 2),

(6,  '2025-07-01 09:30:00', '2025-07-01 12:31:00', 2, 3),
(7,  '2025-07-01 13:30:00', '2025-07-01 16:31:00', 2, 3),
(8,  '2025-07-01 18:30:00', '2025-07-01 21:31:00', 2, 3),

(9,  '2025-07-01 09:00:00', '2025-07-01 12:30:00', 3, 4),
(10, '2025-07-01 14:00:00', '2025-07-01 17:30:00', 3, 4),
(11, '2025-07-01 19:00:00', '2025-07-01 22:30:00', 3, 5),

(12, '2025-07-01 11:00:00', '2025-07-01 13:08:00', 4, 10),
(13, '2025-07-01 15:00:00', '2025-07-01 17:08:00', 4, 10),
(14, '2025-07-01 20:00:00', '2025-07-01 22:08:00', 4, 10),

(15, '2025-07-01 10:30:00', '2025-07-01 13:16:00', 5, 11),
(16, '2025-07-01 16:30:00', '2025-07-01 19:16:00', 5, 11),

(17, '2025-07-01 12:00:00', '2025-07-01 14:08:00', 4, 16),
(18, '2025-07-01 17:30:00', '2025-07-01 19:38:00', 4, 16),
(19, '2025-07-01 21:00:00', '2025-07-01 23:08:00', 4, 16),

(20, '2025-07-01 11:00:00', '2025-07-01 13:50:00', 8, 17),
(21, '2025-07-01 16:00:00', '2025-07-01 18:50:00', 8, 17),

(22, '2025-07-01 09:00:00', '2025-07-01 12:01:00', 2, 22),
(23, '2025-07-01 14:00:00', '2025-07-01 17:01:00', 2, 22),
(24, '2025-07-01 19:00:00', '2025-07-01 22:01:00', 2, 22),

(25, '2025-07-02 10:00:00', '2025-07-02 12:15:00', 6, 23),
(26, '2025-07-02 15:00:00', '2025-07-02 17:15:00', 6, 23),

(27, '2025-07-02 11:00:00', '2025-07-02 12:59:00', 7, 29),
(28, '2025-07-02 14:30:00', '2025-07-02 16:29:00', 7, 29),
(29, '2025-07-02 19:00:00', '2025-07-02 20:59:00', 7, 29),

(30, '2025-07-02 10:00:00', '2025-07-02 12:23:00', 1, 1);

 INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 1, s.id,
       CASE WHEN s.seat_number IN ('A1','A2','B3','B4','C5')
            THEN 'BOOKED'
            ELSE 'AVAILABLE'
       END,
       s.base_price * 1.18,
       NULL
FROM seats s
WHERE s.screen_id = 1;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 2, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 1;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 3, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 1;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 4, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 2;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 9, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 4;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 12, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 10;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 17, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 16;

INSERT INTO show_seats (show_id, seat_id, status, price, booking_id)
SELECT 22, s.id, 'AVAILABLE', s.base_price * 1.18, NULL
FROM seats s
WHERE s.screen_id = 22;

INSERT INTO payments (id, transaction_id, amount, payment_time, payment_method, status) VALUES
(1, 'TXN20250630001', 1062.00, '2025-06-30 11:22:15', 'UPI',        'SUCCESS'),
(2, 'TXN20250630002', 531.00,  '2025-06-30 13:45:00', 'CREDIT_CARD','SUCCESS'),
(3, 'TXN20250629003', 2124.00, '2025-06-29 20:11:33', 'DEBIT_CARD', 'SUCCESS'),
(4, 'TXN20250628004', 708.00,  '2025-06-28 15:30:00', 'NET_BANKING','SUCCESS'),
(5, 'TXN20250628005', 1770.00, '2025-06-28 18:55:22', 'UPI',        'SUCCESS'),
(6, 'TXN20250627006', 354.00,  '2025-06-27 10:02:44', 'WALLET',     'FAILED'),
(7, 'TXN20250627007', 2655.00, '2025-06-27 21:30:10', 'CREDIT_CARD','SUCCESS'),
(8, 'TXN20250626008', 885.00,  '2025-06-26 16:17:05', 'UPI',        'SUCCESS');

INSERT INTO bookings (id, booking_number, booking_time, user_id, show_id, status, total_amount, payment_id) VALUES
(1, 'BMS-2025-000001', '2025-06-30 11:20:00', 1, 1, 'CONFIRMED', 1062.00, 1),
(2, 'BMS-2025-000002', '2025-06-30 13:43:00', 2, 1, 'CONFIRMED',  531.00, 2),
(3, 'BMS-2025-000003', '2025-06-29 20:09:00', 3, 3, 'CONFIRMED', 2124.00, 3),
(4, 'BMS-2025-000004', '2025-06-28 15:28:00', 4, 9, 'CONFIRMED',  708.00, 4),
(5, 'BMS-2025-000005', '2025-06-28 18:53:00', 5, 12,'CONFIRMED', 1770.00, 5),
(6, 'BMS-2025-000006', '2025-06-27 10:00:00', 6, 4, 'CANCELLED',  354.00, 6),
(7, 'BMS-2025-000007', '2025-06-27 21:28:00', 7, 12,'CONFIRMED', 2655.00, 7),
(8, 'BMS-2025-000008', '2025-06-26 16:15:00', 8, 17,'CONFIRMED',  885.00, 8);

UPDATE show_seats
SET booking_id = 1, status = 'BOOKED'
WHERE show_id = 1
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 1
    AND seat_number IN ('A1', 'A2')
);

UPDATE show_seats
SET booking_id = 2, status = 'BOOKED'
WHERE show_id = 1
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 1
    AND seat_number = 'B3'
);

UPDATE show_seats
SET booking_id = 3, status = 'BOOKED'
WHERE show_id = 3
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 1
    AND seat_number IN ('A3', 'A4', 'B5', 'B6')
);

UPDATE show_seats
SET booking_id = 4, status = 'BOOKED'
WHERE show_id = 9
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 4
    AND seat_number IN ('B3', 'B4')
);

UPDATE show_seats
SET booking_id = 5, status = 'BOOKED'
WHERE show_id = 12
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 10
    AND seat_number IN ('A3', 'A4', 'A5')
);

UPDATE show_seats
SET booking_id = 7, status = 'BOOKED'
WHERE show_id = 12
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 10
    AND seat_number IN ('B5', 'B6', 'B7', 'B8', 'B9')
);

UPDATE show_seats
SET booking_id = 8, status = 'BOOKED'
WHERE show_id = 17
AND seat_id IN (
    SELECT id
    FROM seats
    WHERE screen_id = 16
    AND seat_number IN ('B1', 'B2')
);
