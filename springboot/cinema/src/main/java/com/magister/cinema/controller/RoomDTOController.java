package com.magister.cinema.controller;

import com.magister.cinema.domain.Room;
import com.magister.cinema.dto.RoomDTO;
import com.magister.cinema.repository.RoomRepository;
import com.magister.cinema.service.RoomService;
import com.magister.cinema.service.mapper.BaseMapper;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roomdto")
@Api(tags = {"Room controller with DTO mapping"}, description = " ")
public class RoomDTOController {

    @Autowired
    private BaseMapper modelMapper;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private RoomService roomService;

    @GetMapping(value="/rooms")
    public @ResponseBody
    List<RoomDTO> getRooms(){
        return modelMapper.mapList(roomRepository.findAll(), RoomDTO.class);
    }

    @GetMapping(value="/rooms/{id}")
    public @ResponseBody
    RoomDTO getRoomById(@PathVariable long id){
       return  modelMapper.map(roomRepository.findRoomById(id), RoomDTO.class);
    }

    @PostMapping(value="/rooms")
    public @ResponseBody
    RoomDTO createRoom(@ModelAttribute RoomDTO room){
        return modelMapper.map(roomService.createRoom(room), RoomDTO.class);
    }

    @PutMapping(value = "/rooms")
    @ResponseStatus(HttpStatus.OK)
    public void updateRoom(@ModelAttribute RoomDTO room){
        roomService.updateRoom(room);
    }

}
