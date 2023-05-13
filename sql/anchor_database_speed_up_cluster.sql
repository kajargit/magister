CREATE OR REPLACE VIEW public.lrm_nam_room_name
 AS
 explain (analyze, buffers)
 SELECT DISTINCT ON (rm_nam_room_name.rm_id) rm_nam_room_name.rm_id,
    rm_nam_room_name.rm_nam_room_name,
    rm_nam_room_name.rm_nam_changedat
   FROM rm_nam_room_name
  ORDER BY rm_nam_room_name.rm_id DESC, rm_nam_room_name.rm_nam_changedat DESC;

 explain analyze
 SELECT DISTINCT ON (rm_nam_room_name.rm_id) rm_nam_room_name.rm_id,
    rm_nam_room_name.rm_nam_room_name,
    rm_nam_room_name.rm_nam_changedat
   FROM rm_nam_room_name
  ORDER BY rm_nam_room_name.rm_id DESC, rm_nam_room_name.rm_nam_changedat DESC;


ALTER TABLE public.lrm_nam_room_name
    OWNER TO postgres;

--teeme koopia tabelist
CREATE TABLE rm_nam_room_name_cluster AS
SELECT * FROM rm_nam_room_name;

--teeme indexi, desc
DROP INDEX IF EXISTS idx_rm_nam_room_name_cluster;
CREATE INDEX idx_rm_nam_room_name_cluster ON rm_nam_room_name_cluster (rm_id desc, rm_nam_changedat desc);

--klasterdame tabeli

ALTER TABLE rm_nam_room_name_cluster SET WITHOUT CLUSTER;

CLUSTER rm_nam_room_name_cluster USING idx_rm_nam_room_name_cluster;

VACUUM ANALYZE;

--EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)

explain (analyze, buffers)
select *  from lrm_nam_room_name
where rm_id = 27532

explain (analyze, buffers)
SELECT DISTINCT ON (rmname.rm_id) rmname.rm_id,
    rmname.rm_nam_room_name,
    rmname.rm_nam_changedat
   FROM rm_nam_room_name_cluster rmname
   where rm_id = 27532
  --ORDER BY rmname.rm_id DESC, rmname.rm_nam_changedat DESC;