package com.cfs.bms.repository;

import com.cfs.bms.enums.SeatStatus;
import com.cfs.bms.model.ShowSeat;
import org.springframework.data.jpa.repository.JpaRepository;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ShowSeatRepository extends JpaRepository<ShowSeat, Long> {

    List<ShowSeat> findByShowId(Long movieId);

    List<ShowSeat> findByBookingId(Long bookingId);

    List<ShowSeat> findByShowIdAndStatus(Long showId, SeatStatus status);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("""
       SELECT s
       FROM ShowSeat s
       WHERE s.id IN :seatIds
       """)
    List<ShowSeat> findSeatsForBooking(@Param("seatIds") List<Long> seatIds);
}
