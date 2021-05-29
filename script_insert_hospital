from googleapiclient.discovery import build
from google.oauth2 import service_account
import psycopg2
from datetime import datetime
import sys

def insert_hospital(hosp_data):  
    try:
        connection = psycopg2.connect(user="postgres",
                                      password="admin",
                                      host="localhost",
                                      port="5432",
                                      database="proyectoFinal")
        cursor = connection.cursor()
    
        postgres_insert_query = """ INSERT INTO hospital (moph_number, hospital_name, district, province, hospital_type, longitude, latitude, altitude, creation_date, personal_vm_id,num_doctors, num_staff, type_) values (CAST(%s AS NUMERIC),%s,%s,%s,%s,CAST(%s AS FLOAT),CAST(%s AS FLOAT),CAST(%s AS FLOAT),TO_TIMESTAMP(%s, 'YYYY-MM-DD hh24:mi:ss')::timestamp,CAST(%s AS NUMERIC),CAST(%s AS NUMERIC),CAST(%s AS NUMERIC),CAST(%s AS BPCHAR))"""
        
        record_to_insert = hosp_data                             
        cursor.execute(postgres_insert_query, record_to_insert)
        
    
        connection.commit()
        count = cursor.rowcount
        #print(count, "Record inserted successfully into mobile table")
        
        return count

    except (Exception, psycopg2.Error) as error:
        print(error)
    
    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            #print("PostgreSQL connection is closed")

def main():
    a=[]
    
    
    for arg in sys.argv[1:]:
        if(arg!="date"):
            a.append(arg)
        else:
            now = datetime.now()
            dt_string = now.strftime("%Y/%m/%d %H:%M:%S")
            a.append(dt_string)
            
    h_data = tuple(a)
    insert_hospital(h_data)
    
if __name__ == "__main__":
    main()
