package com.magister.cinema.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class RoomDTO implements Serializable {

    private long id;
    private String name;
    private Integer numOfSeats;

}
