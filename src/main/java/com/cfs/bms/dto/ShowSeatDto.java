package com.cfs.bms.dto;

import com.cfs.bms.enums.SeatStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShowSeatDto {

    private Long id;
    private SeatDto seat;
    private SeatStatus status;
    private BigDecimal price;
}
