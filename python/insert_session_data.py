#!/usr/bin/env python3

import psycopg2
from datetime import datetime
import time

def insert_session():
   
   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   # session

   print("process session data insert start at ", datetime.fromtimestamp(time.time()))
   
   cursor.execute("call generate_session()")

   print("process session data insert end at ", datetime.fromtimestamp(time.time()))


   # session_price_history

   print("process session_price_history data insert start at ", datetime.fromtimestamp(time.time()))

   cursor.execute("call generate_session_price_history(15)")

   print("process session_price_history data insert end at ", datetime.fromtimestamp(time.time()))

   
   conn.commit()
   
   conn.close()


def insert_session_room():
   
   conn = psycopg2.connect(
      database="magister", user='postgres', password='postgres', host='127.0.0.1', port= '5432'
   )

   cursor = conn.cursor()

   # session_room

   print("process session_room data insert start at ", datetime.fromtimestamp(time.time()))
   
   cursor.execute("call generate_session_room()")

   print("process session_room data insert end at ", datetime.fromtimestamp(time.time()))


   conn.commit()
   
   conn.close()

   