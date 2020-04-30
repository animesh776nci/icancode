# -*- coding: utf-8 -*-
"""
Created on Fri Oct 18 10:06:53 2019

@author: anime
"""

import psycopg2
try:
    dbConnection = psycopg2.connect(
            user = "dap",
            password = "dap",
            host = "192.168.56.30",
            port = "5432",
            database = "postgres")
    dbConnection.set_isolation_level(0) # AUTOCOMMIT
    dbCursor = dbConnection.cursor()
    dbCursor.execute('CREATE DATABASE animals_db;')
    dbCursor.close()
except (Exception , psycopg2.Error) as dbError :
    print ("Error while connecting to PostgreSQL", dbError)
finally:
    if(dbConnection): dbConnection.close()