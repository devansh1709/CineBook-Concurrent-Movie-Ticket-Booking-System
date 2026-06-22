package com.cfs.bms.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookingRequestDto {

    @NotNull(message = "userId is required")
    private Long userId;

    @NotNull(message = "showId is required")
    private Long showId;

    @NotEmpty(message = "seatIds cannot be empty")
    private List<Long> seatIds;

    @NotBlank(message = "paymentMethod is required")
    private String paymentMethod;

}
