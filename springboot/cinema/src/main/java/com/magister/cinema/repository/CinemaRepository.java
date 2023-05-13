package com.magister.cinema.repository;

import com.magister.cinema.domain.Cinema;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CinemaRepository extends JpaRepository<Cinema, Long> {

    Cinema findCinemaById(long cinemaId);
}
