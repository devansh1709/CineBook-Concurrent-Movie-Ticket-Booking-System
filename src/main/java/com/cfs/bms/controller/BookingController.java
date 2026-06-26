package com.cfs.bms.controller;

import com.cfs.bms.dto.BookingDto;
import com.cfs.bms.dto.BookingRequestDto;
import com.cfs.bms.service.BookingService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @PostMapping
    public ResponseEntity<BookingDto> createBooking(@Valid @RequestBody BookingRequestDto bookingRequest){

        return new ResponseEntity<>(bookingService.createBooking(bookingRequest), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookingDto> getBookingById(@PathVariable Long id)
    {
        return ResponseEntity.ok(bookingService.getBookingById(id));
    }

    @GetMapping("/number/{bookingNumber}")
    public ResponseEntity<BookingDto> getByNumber(
            @PathVariable String bookingNumber)
    {
        return ResponseEntity.ok(
                bookingService.getBookingByNumber(bookingNumber));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<BookingDto>> getByUser(
            @PathVariable Long userId)
    {
        return ResponseEntity.ok(bookingService.getBookingByUserId(userId));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BookingDto> cancelBooking(@PathVariable Long id) {
        return ResponseEntity.ok(bookingService.cancelBooking(id));
    }
}
