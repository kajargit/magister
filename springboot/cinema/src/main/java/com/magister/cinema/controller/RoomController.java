package com.magister.cinema.controller;

import com.magister.cinema.domain.Room;
import com.magister.cinema.repository.RoomRepository;
import com.magister.cinema.service.RoomService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@Api(tags = {"Room controller"}, description = " ")
public class RoomController {

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private RoomService roomService;

    @GetMapping(value="/rooms")
    public @ResponseBody
    List<Room> getRooms(){
        return roomRepository.findAll();
    }

    @GetMapping(value="/rooms/{id}")
    public @ResponseBody
    Room getRoomById(@PathVariable long id){
        return roomRepository.findRoomById(id);
    }

    @PostMapping(value="/rooms")
    public @ResponseBody
    Room createRoom(@ModelAttribute Room room){
        return roomService.createRoom(room);
    }

    @PutMapping(value = "/rooms")
    @ResponseStatus(HttpStatus.OK)
    public void updateRoom(@ModelAttribute Room room){
        roomService.updateRoom(room);
    }

}
