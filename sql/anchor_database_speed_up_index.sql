select * from ci_at_mv_isshowed_shs_until
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00'; 

select * from ci_at_mv_isshowed_shs_until
where ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' and  
ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00'; 

select * from ci_at_mv_isshowed_shs_until
where ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59'; 

CREATE TABLE IF NOT EXISTS public.CI_at_MV_isShowed_SHS_until_index (
    CI_ID_at integer not null, 
    MV_ID_isShowed integer not null, 
    SHS_ID_until integer not null,
    CI_at_MV_isShowed_SHS_until_ChangedAt timestamp not null,
    constraint CI_at_MV_isShowed_SHS_until_index_fkCI_at foreign key (
        CI_ID_at
    ) references public.CI_Cinema(CI_ID), 
    constraint CI_at_MV_isShowed_SHS_until_index_fkMV_isShowed foreign key (
        MV_ID_isShowed
    ) references public.MV_Movie(MV_ID), 
    constraint CI_at_MV_isShowed_SHS_until_index_fkSHS_until foreign key (
        SHS_ID_until
    ) references public.SHS_ShowingState(SHS_ID),
    constraint pkCI_at_MV_isShowed_SHS_until_index primary key (
        CI_ID_at ,
        MV_ID_isShowed ,
        CI_at_MV_isShowed_SHS_until_ChangedAt 
    )
)

insert into public.ci_at_mv_isshowed_shs_until_index(ci_id_at,mv_id_isshowed,shs_id_until, ci_at_mv_isshowed_shs_until_changedat) 
SELECT ci_id_at,mv_id_isshowed,shs_id_until, ci_at_mv_isshowed_shs_until_changedat FROM ci_at_mv_isshowed_shs_until;

select count(*) from public.ci_at_mv_isshowed_shs_until_index

CREATE INDEX CI_at_MV_isShowed_SHS_until_index_change_at ON CI_at_MV_isShowed_SHS_until_index (CI_at_MV_isShowed_SHS_until_ChangedAt);	

analyze public.ci_at_mv_isshowed_shs_until_index;

select * from CI_at_MV_isShowed_SHS_until_index
where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';

select * from CI_at_MV_isShowed_SHS_until_index
where ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' and  
ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';

select * from CI_at_MV_isShowed_SHS_until_index
where ci_at_mv_isshowed_shs_until_changedat = '2021-12-31 23:59:59';