#!/usr/bin/env python3

import psycopg2
from datetime import datetime
import time

def insert_data():
   
   print("process classifers data insert start at ", datetime.fromtimestamp(time.time()))

   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()
  
   cursor.execute("""insert into genre_type(genre_type_id, name)
                     values(1, 'horror'),
  	                       (2, 'drama'),
	                       (3, 'comedy')""");
   
   cursor.execute("""insert into raiting_type(raiting_type_id, name)
                     values(1, 'good'),
                            (2, 'bad')""");
	  
   cursor.execute("""insert into showing_state(showing_state_id, name)
                     values(1, 'on'),
  	                       (2, 'off')""");	

   conn.commit()
   
   conn.close()

   print("process classifers data insert end at ", datetime.fromtimestamp(time.time()))