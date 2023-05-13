package com.magister.cinema.domain;

import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name= "lrm_room")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Room {

    @Id
    @GeneratedValue(
            strategy = GenerationType.IDENTITY
    )
    @Column(name = "rm_id")
    private Long id;

    @Column(name = "rm_nam_room_name")
    private String name;

    @Column(name = "rm_nos_room_numofseats")
    private Integer numOfSeats;

    @Column(name = "rm_nam_changedat")
    private Timestamp changedAt;

}
