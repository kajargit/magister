SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lse_session ses
LEFT JOIN se_at_mv_isshowed_test ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN lmv_movie mv ON ishowed.mv_id_isshowed = mv.mv_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
ORDER BY ses.se_pri_session_price ASC

SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name,
	
FROM lmv_movie mv
LEFT JOIN se_at_mv_isshowed_test ishowed ON mv.mv_id = ishowed.mv_id_isshowed
LEFT JOIN lse_session ses ON ishowed.se_id_at = ses.se_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC

--Successfully run. Total query runtime: 27 secs 291 msec.
--604 rows affected.

SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lmv_movie mv,
 se_at_mv_isshowed ishowed,
 lse_session ses
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ses.se_id = ishowed.se_id_at
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
ORDER BY ses.se_pri_session_price ASC

SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mvname.mv_nam_movie_name AS movie_name
FROM 
 mv_nam_movie_name_index mvname,
 se_at_mv_isshowed ishowed,
 lse_session ses
WHERE 
	  mvname.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND mvname.mv_id = ishowed.mv_id_isshowed
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
  AND ses.se_id = ishowed.se_id_at
ORDER BY ses.se_tim_session_time desc

select count(*) from mv_rat_movie_rating
drop index mv_nam_movie_name_idx
create index mv_nam_movie_name_idx on mv_nam_movie_name(mv_nam_movie_name);

vacuum analyze

--Successfully run. Total query runtime: 1 secs 597 msec.
--604 rows affected.

-------------------------------------------------------------------------------------------------

drop index mv_nam_movie_name_idx
create index mv_nam_movie_name_idx on mv_nam_movie_name(mv_nam_movie_name);

vacuum analyze


-- kuna me vastuses kino kohta tahame vaid teada nime, siis eemaldame katsetuseks päringust lmv_movie vaate
-- kasutamise, sest see tegelab ka ajaloolise atribuudi mv_rat_movie_rating viimase väärtuse arvutamisega, mida meil ei ole vaja.
-- lmv_movie ansendame tabelitega mv_movie ja mv_nam_movie_name

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


SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mvname.mv_nam_movie_name AS movie_name
FROM mv_movie mv
LEFT JOIN mv_nam_movie_name mvname ON mv.mv_id = mvname.mv_id
LEFT JOIN se_at_mv_isshowed ishowed ON mv.mv_id = ishowed.mv_id_isshowed
LEFT JOIN lse_session ses ON ishowed.se_id_at = ses.se_id
WHERE 
	mvname.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY ses.se_pri_session_price ASC

--tulemus paranes koht tunduvalt


--teeme lmv_movie vaatele sarnase materialiseeritud vaate

CREATE MATERIALIZED VIEW public.lmv_movie_mat
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
	 
CREATE MATERIALIZED VIEW public.lse_session_mat
 AS
 SELECT se.se_id,
    --pri.se_pri_changedat,
    --pri.se_pri_session_price,
    tim.se_tim_session_time
   FROM se_session se
     LEFT JOIN lse_pri_session_price pri ON pri.se_id = se.se_id
     LEFT JOIN se_tim_session_time tim ON tim.se_id = se.se_id;	 

--asendame algses päringus lmv_movie vaatega lmv_movie_mat

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


--kaks vaadet, mida uurida lmv_movie ja lse_session

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
     LEFT JOIN rtt_ratingtype krat ON krat.rtt_id = rat.rtt_id
   WHERE nam.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'	
   
SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name
FROM lse_session ses
LEFT JOIN se_at_mv_isshowed ishowed ON ses.se_id = ishowed.se_id_at
LEFT JOIN lmv_movie mv ON ishowed.mv_id_isshowed = mv.mv_id
WHERE mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
ORDER BY ses.se_pri_session_price ASC
   

