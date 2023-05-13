import psycopg2
from datetime import datetime
import time

def truncate_all_tables():
   
   print("process truncate tables start at ", datetime.fromtimestamp(time.time()))

   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   cursor.execute('TRUNCATE TABLE session_room RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE session_price_history RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE session RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE showing RESTART IDENTITY CASCADE')


   cursor.execute('TRUNCATE TABLE movie_raiting_history RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE movie RESTART IDENTITY CASCADE')

   cursor.execute('TRUNCATE TABLE room_name_history RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE room RESTART IDENTITY CASCADE')

   cursor.execute('TRUNCATE TABLE cinema RESTART IDENTITY CASCADE')

   cursor.execute('TRUNCATE TABLE showing_state RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE raiting_type RESTART IDENTITY CASCADE')
   cursor.execute('TRUNCATE TABLE genre_type RESTART IDENTITY CASCADE')


   conn.commit()
   
   conn.close()

   print("process truncate tables end at ", datetime.fromtimestamp(time.time()))