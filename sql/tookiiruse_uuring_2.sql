--tavaline baas
SELECT 
	se.session_id, 
	se.time AS session_time, 
	se.price AS session_price,
	mv.name AS movie_name,
	cm.name,
	rm.name
FROM session se
LEFT JOIN movie mv USING (movie_id)
LEFT JOIN session_room srm USING (session_id)
LEFT JOIN room rm USING (room_id)
LEFT JOIN cinema cm USING (cinema_id)
WHERE  se.time between '2023-01-01' and '2023-01-31' 
   and mv.name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
ORDER BY se.price ASC

SELECT 
	se.session_id, 
	se.time AS session_time, 
	se.price AS session_price,
	mv.name AS movie_name,
	cm.name,
	rm.name
FROM session se
LEFT JOIN movie mv ON se.movie_id = mv.movie_id and mv.name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
LEFT JOIN session_room srm ON se.session_id = srm.session_id
LEFT JOIN room rm ON srm.room_id = rm.room_id
LEFT JOIN cinema cm ON rm.cinema_id = cm.cinema_id
WHERE  se.time between '2023-01-01' and '2023-01-31' 
ORDER BY se.price ASC

SELECT 
	se.session_id, 
	se.time AS session_time, 
	se.price AS session_price,
	mv.name AS movie_name,
	cm.name AS cinema_name,
	rm.name AS room_name
FROM movie mv, session se, session_room srm, room rm, cinema cm 
WHERE mv.name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND se.time between '2023-01-01' and '2023-01-31'
  AND se.movie_id = mv.movie_id
  AND se.session_id = srm.session_id
  AND srm.room_id = rm.room_id
  AND rm.cinema_id = cm.cinema_id
ORDER BY se.price ASC



---ankur


SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name,
	lrm.rm_nam_room_name,
	lci.ci_nam_cinema_name
FROM lmv_movie mv,
 	 se_at_mv_isshowed ishowed,
 	 lse_session ses,
 	 rm_in_se_takesplace rmst,
 	 lrm_room lrm,
  	 ci_has_rm_the chrm,
 	 lci_cinema lci
WHERE 
	  mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ses.se_id = ishowed.se_id_at
  AND ses.se_id = rmst.se_id_takesplace
  AND rmst.rm_id_in = lrm.rm_id
  AND lrm.rm_id = chrm.rm_id_the
  AND chrm.ci_id_has = lci.ci_id
ORDER BY ses.se_pri_session_price ASC

