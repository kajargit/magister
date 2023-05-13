/* ci_at_mv_isshowed_shs_until */

select 
	cinema.ci_nam_cinema_name
	--movie.mv_nam_movie_name
from lci_cinema cinema, 
	 ci_at_mv_isshowed_shs_until showed, 
	 lmv_movie movie
where 
	cinema.ci_id = showed.ci_id_at
and showed.mv_id_isshowed = movie.mv_id
--and showed.ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59';
  and showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00'   
  limit 1000000
--and movie.mv_id = 1;

/* ci_at_mv_isshowed_shs_until_part */

select 
	cinema.ci_nam_cinema_name
	--movie.mv_nam_movie_name
from lci_cinema cinema, 
	 ci_at_mv_isshowed_shs_until_part showed, 
	 lmv_movie movie
where 
	cinema.ci_id = showed.ci_id_at
and showed.mv_id_isshowed = movie.mv_id
--and showed.ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59';
  and showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00'  
  limit 1000000
--and movie.mv_id = 1;


/* ci_at_mv_isshowed_shs_until_index */

select 
	cinema.ci_nam_cinema_name
	--movie.mv_nam_movie_name
from lci_cinema cinema, 
	 ci_at_mv_isshowed_shs_until_index showed, 
	 lmv_movie movie
where 
	cinema.ci_id = showed.ci_id_at
and showed.mv_id_isshowed = movie.mv_id
--and showed.ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59';
  and showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00'  
   limit 1000000
--and movie.mv_id = 1;


/* ci_at_mv_isshowed_shs_until_cluster */

select
	  cinema.ci_nam_cinema_name
	--movie.mv_nam_movie_name
from lci_cinema cinema, 
	 ci_at_mv_isshowed_shs_until_cluster showed, 
	 lmv_movie movie
where 
	cinema.ci_id = showed.ci_id_at
and showed.mv_id_isshowed = movie.mv_id
--and showed.ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59';
  and showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00'  
limit 1000000
--and movie.mv_id = 1;

