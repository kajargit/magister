#!/usr/bin/env python3

import psycopg2
from datetime import datetime
import time

def insert_movies():
   
   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   # movie

   print("process movie data insert start at ", datetime.fromtimestamp(time.time()))

   cursor.execute("call generate_movie(5000)")

   print("process movie data insert end at ", datetime.fromtimestamp(time.time()))


   # movie_raiting_history

   print("process movie_raiting_history data insert start at ", datetime.fromtimestamp(time.time()))

   cursor.execute("call generate_movie_raiting_history(10)")

   print("process movie_raiting_history data insert end at ", datetime.fromtimestamp(time.time()))
   
  
   conn.commit()
   
   conn.close()
   

def insert_showing():
   
   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   # showing

   print("process showing data insert start at ", datetime.fromtimestamp(time.time()))

   cursor.execute("call generate_showing()")

   print("process showing data insert end at ", datetime.fromtimestamp(time.time()))
   
   conn.commit()
   
   conn.close()   