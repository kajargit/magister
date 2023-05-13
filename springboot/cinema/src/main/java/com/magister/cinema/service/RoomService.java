package com.magister.cinema.service;

import com.magister.cinema.domain.Room;
import com.magister.cinema.dto.RoomDTO;
import com.magister.cinema.repository.RoomRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class RoomService {

    @Autowired
    private RoomRepository roomRepository;

    /***
     * Room cinema.
     * @param room
     * @return
     */
    public Room createRoom(Room room){

       return roomRepository.save(room);

    }

    /***
     *
     * @param room
     * @return
     */
    public Room createRoom(RoomDTO room){

        var newRoom = Room.builder().name(room.getName()).numOfSeats(room.getNumOfSeats());

        return roomRepository.save(newRoom.build());

    }

    /***
     * Room update.
     * @param room
     */
    public void updateRoom(RoomDTO room){

        var existingRoom = roomRepository.findRoomById(room.getId());

        existingRoom.setName(room.getName());
        existingRoom.setNumOfSeats(room.getNumOfSeats());

        roomRepository.save(existingRoom);

    }

    /***
     * Room update.
     * @param room
     */
    public void updateRoom(Room room){

        roomRepository.save(room );

    }

}
