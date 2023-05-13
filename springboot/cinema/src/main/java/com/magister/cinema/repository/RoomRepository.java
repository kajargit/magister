package com.magister.cinema.repository;

import com.magister.cinema.domain.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room, Long> {

    Room findRoomById(long roomId);
}
