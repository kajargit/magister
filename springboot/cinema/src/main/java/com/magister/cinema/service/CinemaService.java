package com.magister.cinema.service;

import com.magister.cinema.domain.Cinema;
import com.magister.cinema.repository.CinemaRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CinemaService {

    @Autowired
    private CinemaRepository cinemaRepository;

    /***
     * Create cinema.
     * @param cinema
     * @return
     */
    public Cinema createCinema(Cinema cinema){

       return cinemaRepository.save(cinema);

    }

    /***
     * Cinema update.
     * @param cinema
     */
    public void updateCinema(Cinema cinema){

        var existingCinema = cinemaRepository.findCinemaById(cinema.getId());

        existingCinema.setName(cinema.getName());
        existingCinema.setAddress(cinema.getAddress());

        cinemaRepository.save(existingCinema);

    }

}
