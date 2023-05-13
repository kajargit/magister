-- Table: public.se_tim_session_time

-- DROP TABLE IF EXISTS public.se_tim_session_time;

CREATE TABLE IF NOT EXISTS public.se_tim_session_time_part
(
    se_id integer NOT NULL,
    se_tim_session_time timestamp without time zone NOT NULL,
    CONSTRAINT pkse_tim_session_time_part PRIMARY KEY (se_id, se_tim_session_time),
    CONSTRAINT fkse_tim_session_time_part FOREIGN KEY (se_id)
        REFERENCES public.se_session (se_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
PARTITION BY RANGE (se_tim_session_time);

DROP TABLE se_tim_session_time_part_2020;
CREATE TABLE se_tim_session_time_part_2020 PARTITION OF public.se_tim_session_time_part
    FOR VALUES FROM ('2020-01-01 00:00:00') TO ('2021-01-01 00:00:00');	
	
DROP TABLE se_tim_session_time_part_2021;
CREATE TABLE se_tim_session_time_part_2021 PARTITION OF public.se_tim_session_time_part
    FOR VALUES FROM ('2021-01-01 00:00:00') TO ('2022-01-01 00:00:00');

DROP TABLE se_tim_session_time_part_2022;
CREATE TABLE se_tim_session_time_part_2022 PARTITION OF public.se_tim_session_time_part
    FOR VALUES FROM ('2022-01-01 00:00:00') TO ('2023-01-01 00:00:00');
	
DROP TABLE se_tim_session_time_part_2023;
CREATE TABLE se_tim_session_time_part_2023 PARTITION OF public.se_tim_session_time_part
    FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2024-01-01 00:00:00');
	
	
insert into public.se_tim_session_time_part SELECT * FROM se_tim_session_time;	