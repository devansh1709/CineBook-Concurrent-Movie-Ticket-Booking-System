package com.cfs.bms.dto;

import com.cfs.bms.enums.BookingStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookingDto {

    private Long id;
    private String bookingNumber;
    private LocalDateTime bookingTime;
    private UserDto user;
    private ShowDto show;
    private BookingStatus status;
    private BigDecimal totalAmount;
    private List<ShowSeatDto> seats;
    private PaymentDto payment;






}
