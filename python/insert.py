#!/usr/bin/env python3

import insert_movie_data
import truncate_tables
import insert_cinema_data
import insert_classifiers
import insert_session_data

from datetime import datetime
import time

def main():

    print("insert start at ", datetime.fromtimestamp(time.time()))

    truncate_tables.truncate_all_tables()

    insert_classifiers.insert_data()
    
    insert_cinema_data.insert_data()
    
    insert_movie_data.insert_movies()
    insert_movie_data.insert_showing()

    insert_session_data.insert_session()
    insert_session_data.insert_session_room()
    
    print("insert end at ", datetime.fromtimestamp(time.time()))

main()