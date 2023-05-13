-- View: public.lse_pri_session_price

-- DROP VIEW public.lse_pri_session_price;

CREATE OR REPLACE VIEW public.lse_pri_session_price
 AS
 SELECT DISTINCT ON (se_pri_session_price.se_id) se_pri_session_price.se_id,
    se_pri_session_price.se_pri_session_price,
    se_pri_session_price.se_pri_changedat
   FROM se_pri_session_price
  ORDER BY se_pri_session_price.se_id DESC, se_pri_session_price.se_pri_changedat DESC;
  
CREATE materialized VIEW public.lse_pri_session_price_mat
 AS
 SELECT DISTINCT ON (se_pri_session_price.se_id) se_pri_session_price.se_id,
    se_pri_session_price.se_pri_session_price,
    se_pri_session_price.se_pri_changedat
   FROM se_pri_session_price
  ORDER BY se_pri_session_price.se_id DESC, se_pri_session_price.se_pri_changedat DESC;  

ALTER TABLE public.lse_pri_session_price
    OWNER TO postgres;
	
	
select count(*) from se_pri_session_price	

create table se_pri_session_price_cluster as select * from se_pri_session_price
create index idx_

DROP INDEX idx_CI_at_MV_isShowed_SHS_until_indexed_changet_at;
CREATE INDEX idx_se_pri_session_price_cluster_changet_at ON se_pri_session_price_cluster (se_id DESC, se_pri_changedat DESC);	

CLUSTER se_pri_session_price_cluster USING idx_se_pri_session_price_cluster_changet_at;

vacuum analyze

--14525	6.0000	"2021-08-25 10:20:43"
select * from se_pri_session_price
where se_id = 14525
order by se_pri_changedat DESC

select * from lse_pri_session_price
where se_id = 14525

select * from lse_pri_session_price_mat
where se_id = 14525

SELECT DISTINCT ON (spc.se_id) spc.se_id,
    spc.se_pri_session_price,
    spc.se_pri_changedat
   FROM se_pri_session_price_cluster spc
where spc.se_id = 14525


select * from SE_PRI_Session_Price_cluster 	  
where SE_PRI_ChangedAt between '2020-01-01 00:00:00' and '2021-01-01 00:00:00'

select * from SE_PRI_Session_Price
where SE_PRI_ChangedAt between '2020-01-01 00:00:00' and '2021-01-01 00:00:00'

select * from lse_pri_session_price_mat
where SE_PRI_ChangedAt between '2020-01-01 00:00:00' and '2021-01-01 00:00:00'

select * from lse_pri_session_price
where SE_PRI_ChangedAt between '2020-01-01 00:00:00' and '2021-01-01 00:00:00'
