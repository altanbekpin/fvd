# -*- coding: utf-8 -*-
import pymysql
from app import app
from config import mysql
from flask import jsonify, send_file

@app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
@app.route('/getlegacies/<int:parent_id>', methods=['GET'])
def get_legacy_records(parent_id):
    try:
        cur = mysql.get_db().cursor(pymysql.cursors.DictCursor)
        if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
            cur.execute("SELECT id as `key`, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN  is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL")
        else:  # В противном случае выбираем записи с указанным parent_id
            cur.execute("SELECT  id as `key`, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN  is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s", [parent_id])

        results = cur.fetchall()
        legacies = jsonify(results)
        return legacies

    except Exception as e:
        return jsonify(str(e)), 500

@app.route('/legacy/download/<int:file_id>', methods=['GET'])
def download_file(file_id):
    cur = mysql.get_db().cursor()
    cur.execute("SELECT path from legacy WHERE id = %s",[file_id])
    results = cur.fetchall()
    for row in results:
        path = row[0]
    print(path)
    return send_file(path, as_attachment=True)



if __name__ == "__main__":
    app.run(port=5001, debug=True)    