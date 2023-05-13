package com.magister.cinema.controller;

import com.magister.cinema.domain.Cinema;
import com.magister.cinema.repository.CinemaRepository;
import com.magister.cinema.service.CinemaService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@Api(tags = {"Cinema controller"}, description = " ")
public class CinemaController {

    @Autowired
    private CinemaRepository cinemaRepository;

    @Autowired
    private CinemaService cinemaService;

    @GetMapping(value="/cinemas")
    public @ResponseBody
    List<Cinema> getCinemas(){
        return cinemaRepository.findAll();
    }

    @GetMapping(value="/cinemas/{id}")
    public @ResponseBody
    Cinema getCinemaById(@PathVariable long id){
        return cinemaRepository.findCinemaById(id);
    }

    @PostMapping(value="/cinemas")
    public @ResponseBody
    Cinema createCinema(@ModelAttribute Cinema cinema){
        return cinemaService.createCinema(cinema);
    }

    @PutMapping(value = "/cinemas")
    @ResponseStatus(HttpStatus.OK)
    public void updateCinema(@ModelAttribute Cinema cinema){
        cinemaService.updateCinema(cinema);
    }

}
