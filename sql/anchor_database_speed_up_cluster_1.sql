--teen tabeli ja järjestan info
CREATE TABLE showed_test_ordered AS
	SELECT * FROM ci_at_mv_isshowed_shs_until ORDER BY ci_at_mv_isshowed_shs_until_changedat ASC

CREATE INDEX idx_showed_test_ordered ON showed_test_ordered (ci_at_mv_isshowed_shs_until_changedat);

--teen tabeli ja ajan kirjed sassi
CREATE TABLE showed_test_random AS
	SELECT * FROM showed_test_ordered ORDER BY random()
	
CREATE INDEX idx_showed_test_random ON showed_test_random (ci_at_mv_isshowed_shs_until_changedat);

--teen tabeli ja ajan kirjed sassi ja sellel panen hiljem cluster
CREATE TABLE showed_test_random_cluster AS
	SELECT * FROM showed_test_ordered ORDER BY random()
	
CREATE INDEX idx_showed_test_random_cluster ON showed_test_random_cluster (ci_at_mv_isshowed_shs_until_changedat);

CLUSTER showed_test_random_cluster USING idx_showed_test_random_cluster;	  

CLUSTER;

VACUUM ANALYZE;

--algne tabel, indexit ei ole
explain (analyze, buffers) 
SELECT * fROM ci_at_mv_isshowed_shs_until showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';  
	  
explain (analyze, buffers)	  
SELECT * fROM ci_at_mv_isshowed_shs_until showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat = '2021-06-25 14:02:41';	  


--sorted ja index olemas
explain (analyze, buffers)	  
SELECT * fROM showed_test_ordered showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';  

explain (analyze, buffers)	  
SELECT * fROM showed_test_ordered showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat = '2021-06-25 14:02:41';	  


--random not clustered, not sorted, index olemas
explain (analyze, buffers)	  
SELECT * fROM showed_test_random showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	  
	  
explain (analyze, buffers) 
SELECT * fROM showed_test_random showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat = '2021-06-25 14:02:41';	  


--random clustered, index olemas
explain (analyze, buffers) 
SELECT * fROM showed_test_random_cluster showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	
	  
SELECT * fROM showed_test_random_cluster showed 
WHERE showed.ci_at_mv_isshowed_shs_until_changedat = '2021-06-25 14:02:41';	  
	  






explain (analyze, buffers) SELECT * fROM showed_test showed 
	WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
	  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
	  
explain (analyze, buffers)	  
SELECT ci.ci_id,
    nam.ci_nam_cinema_name,
    adr.ci_adr_cinema_address
   FROM ci_cinema ci
     LEFT JOIN ci_nam_cinema_name nam ON nam.ci_id = ci.ci_id
     LEFT JOIN ci_adr_cinema_address adr ON adr.ci_id = ci.ci_id
	 LEFT JOIN showed_test_ordered st ON st.ci_id_at = ci.ci_id
	 INNER JOIN mv_movie mv ON st.mv_id_isshowed = mv.mv_id
WHERE st.ci_at_mv_isshowed_shs_until_changedat >= '2021-12-01 00:00:00'
	  and st.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	 
	
	explain (analyze, buffers)		
SELECT ci.ci_id,
    nam.ci_nam_cinema_name,
    adr.ci_adr_cinema_address
   FROM ci_cinema ci
     LEFT JOIN ci_nam_cinema_name nam ON nam.ci_id = ci.ci_id
     LEFT JOIN ci_adr_cinema_address adr ON adr.ci_id = ci.ci_id
	 LEFT JOIN showed_test_random st ON st.ci_id_at = ci.ci_id
	 INNER JOIN mv_movie mv ON st.mv_id_isshowed = mv.mv_id
WHERE st.ci_at_mv_isshowed_shs_until_changedat >= '2021-12-01 00:00:00'
	  and st.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	 
	  
	  
	explain (analyze, buffers)	
SELECT ci.ci_id,
    nam.ci_nam_cinema_name,
    adr.ci_adr_cinema_address
   FROM ci_cinema ci
     LEFT JOIN ci_nam_cinema_name nam ON nam.ci_id = ci.ci_id
     LEFT JOIN ci_adr_cinema_address adr ON adr.ci_id = ci.ci_id
	 LEFT JOIN showed_test_random_cluster st ON st.ci_id_at = ci.ci_id
	 INNER JOIN mv_movie mv ON st.mv_id_isshowed = mv.mv_id
WHERE st.ci_at_mv_isshowed_shs_until_changedat >= '2021-12-01 00:00:00'
	  and st.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	 	
	  

explain (analyze, buffers) SELECT * fROM showed_test_random showed 
	WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
	  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	
	  
	  
SELECT ci.ci_id,
    nam.ci_nam_cinema_name,
    adr.ci_adr_cinema_address
   FROM ci_cinema ci
     LEFT JOIN ci_nam_cinema_name nam ON nam.ci_id = ci.ci_id
     LEFT JOIN ci_adr_cinema_address adr ON adr.ci_id = ci.ci_id
	 LEFT JOIN showed_test_random st ON st.ci_id_at = ci.ci_id
	 INNER JOIN mv_movie mv ON st.mv_id_isshowed = mv.mv_id	  
	  
explain (analyze, buffers) SELECT * fROM showed_test_random_1 showed 
	WHERE showed.ci_at_mv_isshowed_shs_until_changedat >= '2021-01-01 00:00:00'
	  and showed.ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';	  
	  
SELECT ci.ci_id,
    nam.ci_nam_cinema_name,
    adr.ci_adr_cinema_address
   FROM ci_cinema ci
     LEFT JOIN ci_nam_cinema_name nam ON nam.ci_id = ci.ci_id
     LEFT JOIN ci_adr_cinema_address adr ON adr.ci_id = ci.ci_id
	 LEFT JOIN showed_test_random_1 st ON st.ci_id_at = ci.ci_id
	 INNER JOIN mv_movie mv ON st.mv_id_isshowed = mv.mv_id	  	  
	  
