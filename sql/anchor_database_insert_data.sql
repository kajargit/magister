CREATE EXTENSION IF NOT EXISTS dblink;

/* classifiers */

insert into public.typ_genretype(typ_id, typ_genretype)
SELECT genre_type_id, name FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.genre_type') AS tb2(genre_type_id int, name text);

insert into public.rtt_ratingtype(rtt_id, rtt_ratingtype)
SELECT rating_type_id, name FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.rating_type') AS tb2(rating_type_id int, name text);

insert into public.shs_showingstate(shs_id, shs_showingstate)
SELECT showing_state_id, name FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.showing_state') AS tb2(showing_state_id int, name text);

/* room */
insert into public.rm_room(rm_id)
SELECT room_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.room') AS tb2(room_id int, name text, num_of_seats int, cinema_id int);

insert into public.rm_nam_room_name(rm_id, rm_nam_room_name, rm_nam_changedat)
SELECT room_id, name, changed_at FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT room_id, name, changed_at FROM public.room_name_history') AS tb2(room_id int, name text, changed_at timestamp);

insert into public.rm_nos_room_numofseats(rm_id, rm_nos_room_numofseats)
SELECT room_id, num_of_seats FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.room') AS tb2(room_id int, name text, num_of_seats int, cinema_id int);

/* cinema */

insert into public.ci_cinema(CI_ID)
SELECT cinema_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.cinema') AS tb2(cinema_id int, name text, address text);

insert into public.CI_NAM_Cinema_Name(CI_ID, CI_NAM_Cinema_Name)
SELECT cinema_id, name FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.cinema') AS tb2(cinema_id int, name text, address text);

insert into public.CI_ADR_Cinema_Address(CI_ID, CI_ADR_Cinema_Address)
SELECT cinema_id, address FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.cinema') AS tb2(cinema_id int, name text, address text);

insert into public.ci_has_rm_the(CI_ID_has, rm_id_the)
SELECT cinema_id, room_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.room') AS tb2(room_id int, name text, num_of_seats int, cinema_id int);

/* movie */

insert into public.mv_movie(mv_id)
SELECT movie_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.movie') AS tb2(movie_id int, name text, author text, genre_type_id int, rating_type_id int);

insert into public.mv_nam_movie_name(mv_id, mv_nam_movie_name)
SELECT movie_id, name FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.movie') AS tb2(movie_id int, name text, author text, genre_type_id int, rating_type_id int);

insert into public.mv_ath_movie_author(mv_id, mv_ath_movie_author)
SELECT movie_id, author FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.movie') AS tb2(movie_id int, name text, author text, genre_type_id int, rating_type_id int);

insert into public.mv_ger_movie_gerne(mv_id, typ_id)
SELECT movie_id, genre_type_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.movie') AS tb2(movie_id int, name text, author text, genre_type_id int, rating_type_id int);

insert into public.mv_rat_movie_rating(mv_id, rtt_id, mv_rat_changedat)
SELECT movie_id, rating_type_id, changed_at FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT movie_id, rating_type_id, changed_at FROM public.movie_rating_history') AS tb2(movie_id int, rating_type_id smallint, changed_at timestamp);

insert into public.ci_at_mv_isshowed_shs_until(ci_id_at, mv_id_isshowed, shs_id_until, ci_at_mv_isshowed_shs_until_changedat)
SELECT cinema_id, movie_id, showing_state_id, changed_at FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT cinema_id, movie_id, showing_state_id, changed_at FROM public.showing') AS tb2(cinema_id int, movie_id int, showing_state_id smallint, changed_at timestamp);

/* session */

insert into public.se_session(se_id)
SELECT session_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.session') AS tb2(session_id int, movie_id int, time timestamp, price double precision);

insert into public.se_at_mv_isshowed(se_id_at, mv_id_isshowed)
SELECT session_id, movie_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.session') AS tb2(session_id int, movie_id int, time timestamp, price double precision);

insert into public.se_pri_session_price(se_id, se_pri_session_price, se_pri_changedat)
SELECT session_id, price, changed_at FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT session_id, price, changed_at FROM public.session_price_history') AS tb2(session_id int, price double precision, changed_at timestamp);

insert into public.se_tim_session_time(se_id, se_tim_session_time)
SELECT session_id, time FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.session') AS tb2(session_id int, movie_id int, time timestamp, price double precision);

insert into public.rm_in_se_takesplace(rm_id_in, se_id_takesplace)
SELECT room_id, session_id FROM dblink('dbname=magister port=5432 host=localhost user=postgres password=postgres','SELECT * FROM public.session_room') AS tb2(session_room_id int, room_id int, session_id int);
