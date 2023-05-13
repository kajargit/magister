#!/usr/bin/env python3

import psycopg2
from datetime import datetime
import time

query_execution_count = 5
print_results = False
queries = [ """select * from ci_at_mv_isshowed_shs_until
                where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';""",
            """select * from ci_at_mv_isshowed_shs_until_indexed
                where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';""",
            """select * from ci_at_mv_isshowed_shs_until_cluster
                where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';""",
            """select * from ci_at_mv_isshowed_shs_until_part
                where ci_at_mv_isshowed_shs_until_changedat < '2022-01-01 00:00:00';""",

            """select * from ci_at_mv_isshowed_shs_until
                where 
	                 ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
                 and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';""",
            """select * from ci_at_mv_isshowed_shs_until_indexed
                where 
	                 ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
                 and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';""",                 
            """select * from ci_at_mv_isshowed_shs_until_cluster
                where 
	                 ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
                 and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';""",                                  
            """select * from ci_at_mv_isshowed_shs_until_part
                where 
	                 ci_at_mv_isshowed_shs_until_changedat > '2021-12-31 00:00:00' 
                 and ci_at_mv_isshowed_shs_until_changedat < '2023-01-01 00:00:00';""",   

            """select * from ci_at_mv_isshowed_shs_until
                where ci_at_mv_isshowed_shs_until_changedat = '2022-11-16 13:24:48';""",
            """select * from ci_at_mv_isshowed_shs_until_indexed
                where ci_at_mv_isshowed_shs_until_changedat = '2022-11-16 13:24:48';""",
            """select * from ci_at_mv_isshowed_shs_until_cluster
                where ci_at_mv_isshowed_shs_until_changedat = '2022-11-16 13:24:48';""",                
            """select * from ci_at_mv_isshowed_shs_until_part
                where ci_at_mv_isshowed_shs_until_changedat = '2022-11-16 13:24:48';""", 
                                               
            """select * from ci_at_mv_isshowed_shs_until
                where 
                    ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
                and ci_at_mv_isshowed_shs_until_changedat < '2021-12-31 00:00:00';""",
           """select * from ci_at_mv_isshowed_shs_until_indexed
                where 
                    ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
                and ci_at_mv_isshowed_shs_until_changedat < '2021-12-31 00:00:00';""",
           """select * from ci_at_mv_isshowed_shs_until_cluster
                where 
                    ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
                and ci_at_mv_isshowed_shs_until_changedat < '2021-12-31 00:00:00';""",
            """select * from ci_at_mv_isshowed_shs_until_part
                where 
                    ci_at_mv_isshowed_shs_until_changedat > '2021-01-01 00:00:00'
                and ci_at_mv_isshowed_shs_until_changedat < '2021-12-31 00:00:00';"""                ]

queries_test_1 = [ """SELECT 
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
AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
ORDER BY ses.se_pri_session_price ASC
""",
            """ SELECT 
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
""",
            """ SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mvname.mv_nam_movie_name AS movie_name
FROM mv_movie mv,
 mv_nam_movie_name_index mvname,
 se_at_mv_isshowed ishowed,
 lse_session ses
WHERE 
	  mv.mv_id = mvname.mv_id
  AND mvname.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ses.se_id = ishowed.se_id_at
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
ORDER BY ses.se_pri_session_price ASC
""" ]


queries_test_2 = [ """SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mvname.mv_nam_movie_name AS movie_name,
	lrm.rm_nam_room_name,
	lci.ci_nam_cinema_name
FROM mv_movie mv,
 	 mv_nam_movie_name mvname,
 	 se_at_mv_isshowed ishowed,
 	 lse_session ses,
 	 rm_in_se_takesplace rmst,
 	 lrm_room lrm,
  	 ci_has_rm_the chrm,
 	 lci_cinema lci
WHERE  
	  mv.mv_id = mvname.mv_id
  AND mvname.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ishowed.se_id_at = ses.se_id
  AND ses.se_id = rmst.se_id_takesplace
  AND rmst.rm_id_in = lrm.rm_id
  AND lrm.rm_id = chrm.rm_id_the
  AND chrm.ci_id_has = lci.ci_id
ORDER BY ses.se_pri_session_price ASC
""",
"""SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name,
	lrm.rm_nam_room_name AS room_name,
	lci.ci_nam_cinema_name AS cinema_name
FROM lmv_movie mv, 
	 se_at_mv_isshowed ishowed, 
 	 lse_session_part ses, 
 	 rm_in_se_takesplace rmst, 
 	 lrm_room lrm, 
  	 ci_has_rm_the chrm,
 	 lci_cinema lci 
WHERE  
	mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ishowed.se_id_at = ses.se_id
  AND ses.se_id = rmst.se_id_takesplace
  AND rmst.rm_id_in = lrm.rm_id
  AND lrm.rm_id = chrm.rm_id_the
  AND chrm.ci_id_has = lci.ci_id
ORDER BY ses.se_pri_session_price ASC
""",
"""SELECT 
	ses.se_id AS session_id, 
	ses.se_tim_session_time AS session_time, 
	ses.se_pri_session_price AS session_price,
	mv.mv_nam_movie_name AS movie_name,
	lrm.rm_nam_room_name AS room_name,
	lci.ci_nam_cinema_name AS cinema_name
FROM lmv_movie_mat mv, 
	 se_at_mv_isshowed ishowed, 
 	 lse_session_mat ses, 
 	 rm_in_se_takesplace rmst, 
 	 lrm_room_mat lrm, 
  	 ci_has_rm_the chrm,
 	 lci_cinema lci 
WHERE  
	mv.mv_nam_movie_name = 'Movie Name f86ffeeb6f3de9e1fc8d34395946d022'
  AND ses.se_tim_session_time between '2023-01-01' and '2023-01-31'
  AND mv.mv_id = ishowed.mv_id_isshowed
  AND ishowed.se_id_at = ses.se_id
  AND ses.se_id = rmst.se_id_takesplace
  AND rmst.rm_id_in = lrm.rm_id
  AND lrm.rm_id = chrm.rm_id_the
  AND chrm.ci_id_has = lci.ci_id
ORDER BY ses.se_pri_session_price ASC
"""]

def main():

    print("process start at ", datetime.fromtimestamp(time.time()))

    f = open("results.txt", "a")

    for query in queries_test_2:

        execution_times = []

        records_count = 0

        for x in range(query_execution_count):
            
            start_time = int(time.time()*1000.0)

            conn = psycopg2.connect(
                database="magister_anchor_master", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
            )

            cursor = conn.cursor()
            
            cursor.execute(query)

            conn.close()   

            end_time = int(time.time()*1000.0)
        
            records_count = cursor.rowcount
            time_diff = end_time - start_time

            execution_times.append(time_diff)

        average = sum(execution_times)/len(execution_times)

        if print_results:
            print("Query ", query)
            print("Execution times ", query_execution_count)
            print("Records ", records_count)
            print("Average execution time in seconds", average / 1000)

        f.write('Päring ' + query + '\n')
        f.write('Käivitamiste arv ' + str(query_execution_count) + '\n')
        f.write('Kirjeid ' +  str(records_count) + '\n')
        f.write('Keskmine päringu käivitamise aeg (sekundites) ' + str(average / 1000) + '\n\n\n')
        
    f.close()

    print("process end at ", datetime.fromtimestamp(time.time()))

main()