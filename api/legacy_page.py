from app import app
from flask import jsonify,send_file, request
from db import DB
import os
@app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
@app.route('/getlegacies/<int:parent_id>', methods=['GET'])
def get_legacy_records(parent_id):
    try:
        results = DB.get_instance().getLegacies(parent_id)
        legacies = jsonify(results)
        return legacies
    except Exception as e:
        return jsonify(str(e)), 500
    
@app.route('/legacy/download/<int:file_id>', methods=['GET'])
def download_file(file_id):
    path = DB.get_instance().get_download_legacy_path(file_id)
    return send_file(path, mimetype='application/pdf')

@app.route('/change/file/name', methods=['POST'])
def changeFileName():
    fileID = request.form.get('fileID')
    fileName = request.form.get('FileName')
    try:
        DB.get_instance().update_legacy_name(fileName, fileID)
    except Exception as e:
        return 'failed', 404
    return 'success', 200

@app.route('/upload', methods=['POST', 'OPTIONS'])
def upload_file():
    if request.method == 'OPTIONS' or len(request.form.keys()) == 0:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type'
        }
        return ('', 204, headers)
    data = request.files
    path_to_save = request.form.get('path_to_save')
    parent_id = request.form.get('parent_id')
    

    for key in data.keys():
        file_storage = data.get(key)
        #filename = file_storage.filename
        content_type = file_storage.content_type
        path_to_save = path_to_save
        content_type = content_type.split("/")[1]
        try:
            #data[key].save(f'./{path_to_save}/' + filename)
            file_storage.filename = key
            file_storage.save(f'./{path_to_save}/' + key + '.' + content_type) 
            DB.addLegacy(key, path_to_save, file_storage.filename, content_type, parent_id)
        except Exception as e:
            return 'File uploading failed', 400
        print(f"File {file_storage.filename} with content type {content_type} uploaded with key '{key}'")
    return 'File uploaded successfully'


@app.route('/delete/file', methods=['POST'])
def delete():
    fileID = request.form.get('fileID')
    try:
        deleted_row = DB.delete_legacy(fileID)
        path = deleted_row['path']
        if os.path.exists(path):
            os.remove(path)
            return 'successfully deleted', 200
        else:
            return 'failed', 404
    except Exception as e:
        return 'error', 400