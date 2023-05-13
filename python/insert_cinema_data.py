#!/usr/bin/env python3

import psycopg2
from datetime import datetime
import time

def insert_data():
   
   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   # cinema

   print("process cinema data insert start at ", datetime.fromtimestamp(time.time()))
   
   cursor.execute("call generate_cinema(5000)")

   print("process cinema data insert end at %s", datetime.fromtimestamp(time.time()))


   # room

   print("process room data insert start at ", datetime.fromtimestamp(time.time()))

   cursor.execute("call generate_cinema_room(10)")

   print("process room data insert end at ", datetime.fromtimestamp(time.time()))
   

   # room_name_history

   print("process room_name_history data insert start at ", datetime.fromtimestamp(time.time()))
   
   cursor.execute("call generate_room_name_history(10)")

   print("process room_name_history data insert end at ", datetime.fromtimestamp(time.time()))

   
   conn.commit()
   
   conn.close()

   