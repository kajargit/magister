/* classifiers */

insert into genre_type(genre_type_id, name)
values(1, 'horror'),
  	  (2, 'drama'),
	  (3, 'comedy');
	  
select * from genre_type	  
	  
insert into rating_type(rating_type_id, name)
values(1, 'good'),
  	  (2, 'bad');	  
	  
select * from rating_type	  	  
	  
insert into showing_state(showing_state_id, name)
values(1, 'on'),
  	  (2, 'off');	  
	  
select * from showing_state	  	  

/* cinema */

create or replace PROCEDURE generate_cinema(num_of_cinemas integer)
language plpgsql as
$$
begin

	for cnt in 1..num_of_cinemas loop

		insert into cinema(name, address)
		values('Cinema Name ' ||md5(random()::text), 'Cinema Addressr ' ||md5(random()::text));

	end loop;
	
end;
$$

/* generate_cinema_room() */

create or replace PROCEDURE generate_cinema_room(max_num_of_rooms integer)
language plpgsql as
$$
declare
    cinema_record record;
	inserted_id integer;
	room_name text;
	count_of_rooms integer;
begin

    for cinema_record in select cinema_id from cinema loop 
	
		count_of_rooms := floor((random() * max_num_of_rooms) + 1);
		
		for cnt in 1..count_of_rooms loop
		
			room_name := 'Room Name ' || md5(random()::text);
			
			insert into room(name, cinema_id, num_of_seats)
			values(room_name, cinema_record.cinema_id, floor((random()*250)+1)) returning room_id into inserted_id;
			
			insert into room_name_history(room_id, name, changed_at)
			values(inserted_id, room_name, (timestamp '2020-01-01 00:00:00' + random() * (localtimestamp(0) - timestamp '2020-01-01 00:00:00'))::timestamp(0));
		
		end loop;
 		
    end loop;
end;
$$

/* generate_room_name_history() */

create or replace PROCEDURE generate_room_name_history(max_history_rows integer)
language plpgsql
as
$$
declare
    room_name_history record;
	count_of_history_rows integer;
begin

   for room_name_history in select * from room_name_history loop 
   
   		count_of_history_rows := floor((random() * max_history_rows) + 1);
   		
		for cnt in 1..count_of_history_rows loop
			insert into room_name_history(room_id, name, changed_at)
			values(room_name_history.room_id ,
		   		   'Room Name ' || md5(random()::text),
				   (timestamp '2020-01-01 00:00:00' + random() * (room_name_history.changed_at  - timestamp '2020-01-01 00:00:00'))::timestamp(0)
		  	);
		end loop;

   end loop;
end;
$$;

/* movie */

create or replace PROCEDURE generate_movie(num_of_movies integer)
language plpgsql as
$$
declare
	inserted_id integer;
	rating_id integer;
begin

	for cnt in 1..num_of_movies loop

		rating_id := floor((random()*2)+1);

		insert into movie(name, author, genre_type_id, rating_type_id)
		values('Movie Name ' ||md5(random()::text), 'Movie Author ' ||md5(random()::text),  floor((random()*3)+1), rating_id) returning movie_id into inserted_id;

		insert into movie_rating_history(movie_id, rating_type_id, changed_at)
		values(inserted_id, rating_id, (timestamp '2020-01-01 00:00:00' + random() * (localtimestamp(0) - timestamp '2020-01-01 00:00:00'))::timestamp(0));

	end loop;
	
end;
$$

/* movie_rating_history */

create or replace PROCEDURE generate_movie_rating_history(max_history_rows integer)
language plpgsql
as
$$
declare
    movie_rating_history record;
	count_of_history_rows integer;
begin

   for movie_rating_history in select * from movie_rating_history loop 
   
   		count_of_history_rows := floor((random() * max_history_rows) + 1);
   		
		for cnt in 1..count_of_history_rows loop
		
			insert into movie_rating_history(movie_id, rating_type_id, changed_at)
			values(movie_rating_history.movie_id ,
			   		floor((random()*2)+1),
					(timestamp '2020-01-01 00:00:00' + random() * (movie_rating_history.changed_at - timestamp '2020-01-01 00:00:00'))::timestamp(0)
				   );
		end loop;

   end loop;
end;
$$;

/* showing */

create or replace PROCEDURE generate_showing()
language plpgsql as
$$
declare
    movie_record record;
	max_showing integer;
	count_showing integer;
begin

    select count(cinema_id) into max_showing from cinema;

    for movie_record in select movie_id from movie loop 
	
		count_showing := floor((random() * max_showing) + 1);
		
		for cnt in 1..count_showing loop
			insert into showing(movie_id, cinema_id, showing_state_id, changed_at)
			values(movie_record.movie_id, (select cinema_id from cinema order by random()  limit 1), floor((random()*2)+1), (timestamp '2020-01-01 00:00:00' + random() * (localtimestamp(0) - timestamp '2020-01-01 00:00:00'))::timestamp(0) );
		end loop;
	
    end loop;
end;
$$

/* session */

create or replace PROCEDURE generate_session()
language plpgsql as
$$
declare
    movie_record record;
	num_of_sessions integer;
	max_number_of_sessions integer;
	session_price integer;
	inserted_id integer;
begin

    for movie_record in select movie_id from movie loop 
	
		select count(distinct(cinema_id)) into max_number_of_sessions from showing where movie_id = movie_record.movie_id;
	
		num_of_sessions := floor((random() * max_number_of_sessions) + 1);
		
		for cnt in 1..num_of_sessions loop
		
			session_price := floor((random()*15)+1);
			
			insert into session(movie_id, time, price)
			values(movie_record.movie_id,
				   (timestamp '2020-01-01 00:00:00' + random() * (localtimestamp(0) - timestamp '2020-01-01 00:00:00'))::timestamp(0),
			   		session_price) returning session_id into inserted_id;
					
		    insert into session_price_history(session_id, price, changed_at)
		    values(inserted_id, session_price, (timestamp '2020-01-01 00:00:00' + random() * (localtimestamp(0) - timestamp '2020-01-01 00:00:00'))::timestamp(0));
			
		end loop;
		
    end loop;
end;
$$

/* session_price_history*/

CREATE OR REPLACE PROCEDURE public.generate_session_price_history(
	IN max_history_rows integer)
LANGUAGE 'plpgsql'
AS $BODY$
declare
    se_session record;
	count_of_history_rows integer;
begin

   count_of_history_rows := floor((random() * max_history_rows) + 1);
   
   for se_session in select * from session loop 
   
		for cnt in 1..count_of_history_rows loop
		
			insert into session_price_history(session_id, price, changed_at)
			values(se_session.session_id ,
			   		floor((random()*15)+1),
					(timestamp '2020-01-01 00:00:00' + random() * (se_session.time - timestamp '2020-01-01 00:00:00'))::timestamp(0)
				   );
		end loop;

   end loop;
end;
$BODY$;

/* session_room*/

create or replace PROCEDURE generate_session_room()
language plpgsql
as
$$
declare
    session_record record;
	cinemaid integer;
begin

   for session_record in select movie_id, session_id from session loop 
   
   		select cinema_id into cinemaid from showing where movie_id = session_record.movie_id order by random() limit 1;
		
		insert into session_room(room_id, session_id)
		values((select room_id from room where cinema_id = cinemaid order by random()  limit 1),
			   session_record.session_id);
    end loop;
end;
$$;
