from app import app
from flask import jsonify,send_file
from db import DB
@app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
@app.route('/getlegacies/<int:parent_id>', methods=['GET'])
def get_legacy_records(parent_id):
    try:
        results = DB.getLegacies(parent_id)
        legacies = jsonify(results)
        return legacies
    except Exception as e:
        return jsonify(str(e)), 500
    
@app.route('/legacy/download/<int:file_id>', methods=['GET'])
def download_file(file_id):
    cur = DB.get_db_connection().cursor()
    cur.execute("SELECT path from legacy WHERE id = %s",[file_id])
    results = cur.fetchall()
    for row in results:
        path = row[0]
    return send_file(path, mimetype='application/pdf')