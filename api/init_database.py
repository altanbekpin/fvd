import csv
import psycopg2
import re

conn = psycopg2.connect(
    host="localhost",
    database="userdb",
    user="postgres",
    password="magzhan2005"
)
cur = conn.cursor()

csv_file_path = "/Users/magzhanzhumabaev/Downloads/Школьные термины - Көркем Еңбек.csv"
table_name = "school_termins"

with open(csv_file_path, 'r') as file:
    csv_reader = csv.reader(file)
    next(csv_reader)
    i = 0
    for row in csv_reader:
        print("csv_reader:", row)
        termin = row[0]
        definition = row[1]
        class_val = row[2]
        temp = re.split(r"[,.]", row[3])
        sql = f"INSERT INTO {table_name} (subject_id, termin, definition, class) VALUES (14,%s, %s, %s);"
        if len(temp) > 1:
            for i in temp:
                if int(i.strip()) < 12:
                    try:
                        
                        cur.execute(sql, (termin, definition, i.strip()))
                    except Exception as e:
                        print("Error occurred:", e)
                        conn.rollback()  # Rollback the transaction
                        
        else:
            try:
                cur.execute(sql, (termin, definition, class_val))
            except Exception as e:
                print("Error occurred:", e)
                conn.rollback()  # Rollback the transaction

conn.commit()
