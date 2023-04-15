from datetime import date, datetime
from decimal import Decimal

from sqlalchemy import create_engine

import urllib.parse
import psycopg2

def initialize_database():
    conn = psycopg2.connect(
            host="localhost",
            database="userdb",
            user='postgres',
            password='magzhan2005')

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute('DROP TABLE IF EXISTS users;')
    cur.execute('CREATE TABLE users (id SERIAL PRIMARY KEY,'
                                    'email VARCHAR (150) NOT NULL,'
                                    'password TEXT NOT NULL,'
                                    'fullname VARCHAR (50) NOT NULL,'
                                    'date_added DATE DEFAULT CURRENT_TIMESTAMP);'
                                    )

    # Insert data into the table
    # cur.execute('INSERT INTO users (title, author, pages_num, review)'
    #             'VALUES (%s, %s, %s, %s)',
    #             ('A Tale of Two Cities',
    #             'Charles Dickens',
    #             489,
    #             'A great classic!')
    #             )


    # cur.execute('INSERT INTO books (title, author, pages_num, review)'
    #             'VALUES (%s, %s, %s, %s)',
    #             ('Anna Karenina',
    #             'Leo Tolstoy',
    #             864,
    #             'Another great classic!')
    #             )

    conn.commit()

    cur.close()
    conn.close()

initialize_database()








#password = urllib.parse.quote_plus("alhafizu")
#password = urllib.parse.quote_plus("@Remote2022")
# class Db():

#     def __init__(self):
#         #db_url = f'mysql+pymysql://root:{password}@10.1.1.161/quotes_db'

#         #engine = create_engine(f'mysql+pymysql://dbuser:{password}@db/quotes_db')
#         engine = create_engine(f'mysql+pymysql://root:{password}@10.1.1.161/quotes_db')
#         self.connection = engine.connect()

#     def __del__(self):
#         self.connection.close()
#     # Рекурсивная функция для сканирования директории и записи информации в базу данных
#     def scan_directory(path, parent_id=None):
#         print(path)
#         for name in os.listdir(path):
#             full_path = os.path.join(path, name)
#             is_file = os.path.isfile(full_path)

#             # Добавляем запись в базу данных
#             c.execute('''INSERT INTO directory_structure (name, path, parent_id, is_file) VALUES (?, ?, ?, ?)''', (name, full_path, parent_id, is_file))
#             conn.commit()

#             # Получаем ID последней добавленной записи
#             id = c.lastrowid

#             # Если это директория, рекурсивно вызываем эту же функцию для сканирования этой директории
#             if not is_file:
#                 scan_directory(full_path, id)
#     def clean_select_row(self, row, keys):
#         try:
#             clean_row = [str(field) if isinstance(field, datetime) or isinstance(
#                 field, Decimal) or isinstance(field, date) else field for field in list(row)]
#             current_row = {}
#             i = 0
#             for key in keys:
#                 current_row[key] = clean_row[i]
#                 i= i +1
#             return current_row
#         except:
#             return None

#     def clean_select_results(self, data, keys):
#         if len(data) == 0:
#             return {}
#         result_data = []
#         for row in data:
#             result_data.append(self.clean_select_row(row, keys))
#         return result_data