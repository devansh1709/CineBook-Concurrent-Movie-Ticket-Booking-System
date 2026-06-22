package com.cfs.bms.dto;

import com.cfs.bms.enums.PaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentDto {
    private Long id;
    private String transactionId;
    private BigDecimal amount;
    private LocalDateTime paymentTime;
    private String paymentMethod;
    private PaymentStatus status;
}
