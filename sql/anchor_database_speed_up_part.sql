--part table
DROP TABLE CI_at_MV_isShowed_SHS_until_part;
CREATE TABLE IF NOT EXISTS public.CI_at_MV_isShowed_SHS_until_part (
    CI_ID_at integer not null, 
    MV_ID_isShowed integer not null, 
    SHS_ID_until integer not null,
    CI_at_MV_isShowed_SHS_until_ChangedAt timestamp not null,
    constraint CI_at_MV_isShowed_SHS_until_part_fkCI_at foreign key (
        CI_ID_at
    ) references public.CI_Cinema(CI_ID), 
    constraint CI_at_MV_isShowed_SHS_until_part_fkMV_isShowed foreign key (
        MV_ID_isShowed
    ) references public.MV_Movie(MV_ID), 
    constraint CI_at_MV_isShowed_SHS_until_part_fkSHS_until foreign key (
        SHS_ID_until
    ) references public.SHS_ShowingState(SHS_ID),
    constraint pkCI_at_MV_isShowed_SHS_until_part primary key (
        CI_ID_at ,
        MV_ID_isShowed ,
        CI_at_MV_isShowed_SHS_until_ChangedAt 
    )
) PARTITION BY RANGE (CI_at_MV_isShowed_SHS_until_ChangedAt);

DROP TABLE CI_at_MV_isShowed_SHS_until_part_2020;
CREATE TABLE CI_at_MV_isShowed_SHS_until_part_2020 PARTITION OF public.CI_at_MV_isShowed_SHS_until_part
    FOR VALUES FROM ('2020-01-01 00:00:00') TO ('2021-01-01 00:00:00');	
	
DROP TABLE CI_at_MV_isShowed_SHS_until_part_2021;
CREATE TABLE CI_at_MV_isShowed_SHS_until_part_2021 PARTITION OF public.CI_at_MV_isShowed_SHS_until_part
    FOR VALUES FROM ('2021-01-01 00:00:00') TO ('2022-01-01 00:00:00');

DROP TABLE CI_at_MV_isShowed_SHS_until_part_2022;
CREATE TABLE CI_at_MV_isShowed_SHS_until_part_2022 PARTITION OF public.CI_at_MV_isShowed_SHS_until_part
    FOR VALUES FROM ('2022-01-01 00:00:00') TO ('2023-01-01 00:00:00');
	
DROP TABLE CI_at_MV_isShowed_SHS_until_part_2023;
CREATE TABLE CI_at_MV_isShowed_SHS_until_part_2023 PARTITION OF public.CI_at_MV_isShowed_SHS_until_part
    FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2024-01-01 00:00:00');	
	
insert into public.ci_at_mv_isshowed_shs_until_part(ci_id_at,mv_id_isshowed,shs_id_until, ci_at_mv_isshowed_shs_until_changedat) 
SELECT ci_id_at,mv_id_isshowed,shs_id_until, ci_at_mv_isshowed_shs_until_changedat FROM ci_at_mv_isshowed_shs_until;

DROP INDEX idx_CI_at_MV_isShowed_SHS_until_part_changet_at;
CREATE INDEX idx_CI_at_MV_isShowed_SHS_until_part_changet_at ON CI_at_MV_isShowed_SHS_until_part (CI_at_MV_isShowed_SHS_until_ChangedAt DESC);	

--indexed table
create table ci_at_mv_isshowed_shs_until_indexed as
select * from ci_at_mv_isshowed_shs_until

DROP INDEX idx_CI_at_MV_isShowed_SHS_until_indexed_changet_at;
CREATE INDEX idx_CI_at_MV_isShowed_SHS_until_indexed_changet_at ON CI_at_MV_isShowed_SHS_until_indexed (CI_at_MV_isShowed_SHS_until_ChangedAt DESC);	

--cluster table

create table ci_at_mv_isshowed_shs_until_cluster as
select * from ci_at_mv_isshowed_shs_until

DROP INDEX idx_CI_at_MV_isShowed_SHS_until_cluster_changet_at;
CREATE INDEX idx_CI_at_MV_isShowed_SHS_until_cluster_changet_at ON CI_at_MV_isShowed_SHS_until_cluster (CI_at_MV_isShowed_SHS_until_ChangedAt DESC);	

CLUSTER ci_at_mv_isshowed_shs_until_cluster USING idx_CI_at_MV_isShowed_SHS_until_cluster_changet_at;

VACUUM ANALYZE;

--1
explain (analyze, buffers)
select * from ci_at_mv_isshowed_shs_until
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--10 secs 842 msec
--7588612 rows affected

select * from ci_at_mv_isshowed_shs_until_indexed
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--9 secs 269 msec
--7588612 rows affected

select * from ci_at_mv_isshowed_shs_until_cluster
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--8 secs 537 msec.
--7588612 rows affected

select * from ci_at_mv_isshowed_shs_until_part
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--7 secs 121 msec
--7588612 rows affected

--2
select * from ci_at_mv_isshowed_shs_until
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';  
--8 secs 838 msec
--3799827 rows affected

select * from ci_at_mv_isshowed_shs_until_indexed
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';  
--6 secs 42 msec
--3799827 rows affected

select * from ci_at_mv_isshowed_shs_until_cluster
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';  
--4 secs 54 msec.
--3799827 rows affected

select * from ci_at_mv_isshowed_shs_until_part
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';   
--4 secs 758 msec
--3799827 rows affected

--3
select * from ci_at_mv_isshowed_shs_until
where ci_at_mv_isshowed_shs_until_changedat =  '2022-09-10 12:55:03';  
--3 secs 203 msec.
--2 rows affected

select * from ci_at_mv_isshowed_shs_until_indexed
where ci_at_mv_isshowed_shs_until_changedat =  '2022-09-10 12:55:03';  
--107 msec.
--2 rows affected

select * from ci_at_mv_isshowed_shs_until_cluster
where ci_at_mv_isshowed_shs_until_changedat =  '2022-09-10 12:55:03';  
--94 msec
--2 rows affected

select * from ci_at_mv_isshowed_shs_until_part
where ci_at_mv_isshowed_shs_until_changedat =  '2022-09-10 12:55:03'; 
--98 msec
--2 rows affected

--4
select * from ci_at_mv_isshowed_shs_until
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
and ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--10 secs 351 msec
--3778347 rows affected

select * from ci_at_mv_isshowed_shs_until_indexed
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
and ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--10 secs 549 msec
--3778347 rows affected

select * from ci_at_mv_isshowed_shs_until_cluster
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
and ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--8 secs 206 msec
--3778347 rows affected

explain(analyze, buffers)
select * from ci_at_mv_isshowed_shs_until_part
where 
	ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
and ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';
--6 secs 750 msec
--3778347 rows affected