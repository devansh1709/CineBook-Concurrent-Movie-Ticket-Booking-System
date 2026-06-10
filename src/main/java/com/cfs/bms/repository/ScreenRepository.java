package com.cfs.bms.repository;

import com.cfs.bms.model.Screen;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ScreenRepository extends JpaRepository<Screen, Long> {

    Optional<Screen> findByTheaterId(Long theaterId);
}
