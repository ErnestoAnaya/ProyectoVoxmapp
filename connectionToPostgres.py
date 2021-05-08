# -*- coding: utf-8 -*-
"""
Created on Fri Apr 23 22:44:15 2021

@author: javi2
"""


from __future__ import print_function
from googleapiclient.discovery import build
from google.oauth2 import service_account
import psycopg2

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']
SERVICE_ACCOUNT_FILE = 'keys.json' #Credenciales de Google Cloud

creds = None
creds = service_account.Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE, scopes=SCOPES)


# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = '1FvXedhjqj73MKXNi78o29VcIhmwWTleeumSDnS6IUY4' #ID de spreadsheet

service = build('sheets', 'v4', credentials=creds) #para llamar a la API de Google
sheet_range="Hoja1!B2:AH" #Rango a leer: leemos todos los registros, comenzamos con la columna B para omitir la fecha, dado que no es necesaria en esta prueba de conexión

# Call the Sheets API
sheet = service.spreadsheets()
result = sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID, 
                            range = sheet_range).execute()

values = result.get('values', []) #regresa los valores en una lista de listas
print(values)

respuestas = values#esta es la lista de listas

#Pasa toda la info del Google Sheets

for j in respuestas:
    
    for i in values:
        respuesta = i
    #en este try se establece la conexión con nuestra base de datos y se hacen las operaciones necesarias (insert, update, etc.). La idea es separar el programa en diferentes queries para actualizar las tablas correspondienes una vez definida la estructura de la base de datos
    try:
        #variable connection que contiene todos los datos de nuestra base de datos
        connection = psycopg2.connect(user="postgres",
                                      password="admin",
                                      host="localhost",
                                      port="5432",
                                      database="proyectoFinal")
        cursor = connection.cursor()
    
        #de momento, tenemos una sola tabla con 33 columnas en nuestra base de datos que recibe todos los registros tal cual están en el Google Sheets, por lo qe sólo insertamos en esa tabla
        postgres_insert_query = """ INSERT INTO encuesta (pregunta1,pregunta2,pregunta3,pregunta4,pregunta5,pregunta6,pregunta7,pregunta8,pregunta9,pregunta10,pregunta11,pregunta12,pregunta13,pregunta14,pregunta15,pregunta16,pregunta17,pregunta18,pregunta19,pregunta20,pregunta21,pregunta22,pregunta23,pregunta24,pregunta25,pregunta26,pregunta27,pregunta28,pregunta29,pregunta30,pregunta31,pregunta32,pregunta33) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
        
        
        tupla = tuple(respuesta)
        record_to_insert = tupla
        cursor.execute(postgres_insert_query, record_to_insert)
    
        connection.commit()
        count = cursor.rowcount
        print(count, "Record inserted successfully into mobile table")
    
    except (Exception, psycopg2.Error) as error:
        print("Failed to insert record into mobile table", error)
    
    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
            
            
