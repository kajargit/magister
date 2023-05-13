select * from lci_cinema;

select * from ci_nam_cinema_name;

select * from ci_adr_cinema_address;

insert into lci_cinema(ci_nam_cinema_name, ci_adr_cinema_address) values('Kino 1', 'Koidu 4');

update lci_cinema
set ci_nam_cinema_name = 'Kino Koidu', ci_id = 2
where ci_id = 1;

delete from lci_cinema
where ci_id = 1;

select * from lrm_room;

select * from rm_nam_room_name;

select * from rm_nos_room_numofseats;

insert into lrm_room(rm_nam_room_name, rm_nos_room_numofseats) values('Room 1', 150);
insert into lrm_room(rm_nam_room_name, rm_nos_room_numofseats) values('Room 2', 150);
insert into lrm_room(rm_nam_room_name, rm_nos_room_numofseats) values('Room 3', 150);

update lrm_room
set rm_nam_room_name = 'Room President Suite'
where rm_id = 1;

update lrm_room
set rm_nam_room_name = 'Room 3', rm_nos_room_numofseats = 16
where rm_id = 3;

update lrm_room
set rm_nam_room_name = null
where rm_id = 3;

delete from lrm_room
where rm_id = 3