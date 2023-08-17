# -*- coding: utf-8 -*-
import os
import sqlite3
import mysql.connector

config = {
  'user': 'remoteuser',
  'password': '@Remote2022',
  'host': '10.255.140.4',
  'port': '33066',
  'database': 'quotes_db',
  'raise_on_warnings': True,
  'auth_plugin':'mysql_native_password'
}

cnx = mysql.connector.connect(**config)

# Путь к директории, которую нужно просканировать
directory = os.path.join('Мұрасы')

# Создаем базу данных для хранения структуры директории
c = cnx.cursor()
c.execute('DROP TABLE IF EXISTS legacy')
c.execute('''CREATE TABLE legacy (
   id int NOT NULL AUTO_INCREMENT,
   name varchar(255) DEFAULT NULL,
   path varchar(255) DEFAULT NULL,
   parent_id int DEFAULT NULL,
   is_file int DEFAULT NULL,
  PRIMARY KEY (id)
);
''')


# Рекурсивная функция для сканирования директории и записи информации в базу данных
def scan_directory(path, parent_id=None):
    # print(path)
    for name in os.listdir(path):
        if name == '.DS_Store':
            continue
        full_path = os.path.join(path, name)
        is_file = os.path.isfile(full_path)
        # Добавляем запись в базу данных
        c.execute('''INSERT INTO legacy (name, path, parent_id, is_file) VALUES (%s, %s, %s, %s)''', (name, full_path, parent_id, is_file))
        # Получаем ID последней добавленной записи
        id = c.lastrowid
        # Если это директория, рекурсивно вызываем эту же функцию для сканирования этой директории
        if not is_file:
            scan_directory(full_path, id)

# Запускаем функцию для сканирования директории
scan_directory(directory)
cnx.commit()

# Закрываем базу данных
c.close()
cnx.close()

def get_folders(parent_id=None):
    c.fetchall()
