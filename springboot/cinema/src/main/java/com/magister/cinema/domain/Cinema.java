package com.magister.cinema.domain;

import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name= "lci_cinema")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Cinema {

    @Id
    @GeneratedValue(
            strategy = GenerationType.IDENTITY
    )
    @Column(name = "ci_id")
    private Long id;

    @Column(name = "ci_nam_cinema_name")
    private String name;

    @Column(name = "ci_adr_cinema_address")
    private String address;

}
