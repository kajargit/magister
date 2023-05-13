--algsed päringud

--tavaline baas
SELECT 
	se.session_id, 
	se.time AS session_time, 
	se.price AS session_price,
	mv.name AS movie_name
FROM session se
LEFT JOIN movie mv ON se.movie_id = mv.movie_id
WHERE mv.name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY se.price ASC
select * from se_session

--ankurmudeliga baas
explain(analyze, buffers)
SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lse_session ses
LEFT JOIN se_at_mv_isshowed ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN lmv_movie mv ON ishowed.mv_id_isshowed = mv.mv_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC

drop index se_pri_session_price_idx
create index mv_nam_movie_name_idx on mv_nam_movie_name(mv_nam_movie_name);

drop index mv_nam_movie_name_idx
create index mv_nam_movie_name_idx on mv_nam_movie_name(mv_nam_movie_name);
drop index mv_rat_movie_rating_idx
create index mv_rat_movie_rating_idx on mv_rat_movie_rating(mv_rat_changedat);

vacuum analyze

--päring tavalise andmebaasi vastu rating
SELECT 
	se.session_id, 
	se.time AS session_time, 
	se.price AS session_price,
	mv.name AS movie_name,
	rtt.name AS rating
FROM session se
LEFT JOIN movie mv ON se.movie_id = mv.movie_id
LEFT JOIN rating_type rtt ON mv.raiting_type_id = rtt.rating_type_id
WHERE mv.name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY se.price ASC


--testi algsed päringud


--ilma lmv_movie vaateta
SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mvname.mv_nam_movie_name AS movie_name
FROM lse_session ses
LEFT JOIN se_at_mv_isshowed ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN mv_movie mv ON ishowed.mv_id_isshowed = mv.mv_id
LEFT JOIN mv_nam_movie_name mvname ON mv.mv_id = mvname.mv_id
WHERE 
	mvname.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC

--- katsetame materialiseeritud vaatega
CREATE materialized VIEW public.lmv_movie_mat
 AS
 SELECT mv.mv_id,
    nam.mv_nam_movie_name,
    kger.typ_genretype,
    ger.typ_id,
    ath.mv_ath_movie_author,
    rat.mv_rat_changedat,
    krat.rtt_ratingtype,
    rat.rtt_id
   FROM mv_movie mv
     LEFT JOIN mv_nam_movie_name nam ON nam.mv_id = mv.mv_id
     LEFT JOIN mv_ger_movie_gerne ger ON ger.mv_id = mv.mv_id
     LEFT JOIN typ_genretype kger ON kger.typ_id = ger.typ_id
     LEFT JOIN mv_ath_movie_author ath ON ath.mv_id = mv.mv_id
     LEFT JOIN lmv_rat_movie_rating rat ON rat.mv_id = mv.mv_id
     LEFT JOIN rtt_ratingtype krat ON krat.rtt_id = rat.rtt_id;
	 
	 

CREATE materialized VIEW public.lse_session_mat
 AS
 SELECT se.se_id,
    pri.se_pri_changedat,
    pri.se_pri_session_price,
    tim.se_tim_session_time
   FROM se_session se
     LEFT JOIN lse_pri_session_price pri ON pri.se_id = se.se_id
     LEFT JOIN se_tim_session_time tim ON tim.se_id = se.se_id;	 


SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lse_session_mat ses
LEFT JOIN se_at_mv_isshowed ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN lmv_movie_mat mv ON ishowed.mv_id_isshowed = mv.mv_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC

SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lse_session ses
LEFT JOIN se_at_mv_isshowed ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN lmv_movie mv ON ishowed.mv_id_isshowed = mv.mv_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC