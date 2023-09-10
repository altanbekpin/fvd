from app import app
import os
from flask import request
from pathlib import Path
import json
import os
import sys

# Get the path to the current Python file
# current_file_path = os.path.abspath(__file__)

# Calculate the root directory by going up one level from the current file
# BASE_DIR = os.path.dirname(os.path.dirname(current_file_path))
BASE_DIR="/app"
UPLOAD_FOLDER = os.path.join(BASE_DIR, '')

@app.route("/folders", methods=['GET'])
def api_folders():
        folders = {}
        root_dir = BASE_DIR

        folders = get_folders(root_dir, "media")
        return folders

@app.route("/api/folders/files/", methods=['POST'])
def api_folders_files():
    root_dir = BASE_DIR
    data =json.loads(request.data.decode('utf-8'))
    folder = data['folder']
    data = {}
    dirs = os.listdir(os.path.join(root_dir, folder))
    files = []
    n = 0
    for d in sorted(dirs):
        d_path = os.path.join(root_dir, folder, d)
        if not os.path.isdir(d_path) \
            and (not d.startswith('.')) \
            and ( (d.split('.').pop() == 'wav') \
                or (d.split('.').pop() == 'txt') ):
            n = n + 1   
            sz = os.path.getsize(d_path)
            d_rel_path = os.path.join(folder, d)
            node = {
                'id': n, 
                'name': d, 
                'size': sz,
                'path': d_rel_path
            }
            files.append(node)

    data[folder] = files
    return data

@app.route("/api/file/get_transcript", methods=['POST'])
def api_file_get_transcript():
    root_dir = BASE_DIR
    data =json.loads(request.data.decode('utf-8'))
    filepath = data['path']
    data = {}
    fullpath = os.path.join(root_dir, filepath)
    text = ""
    if os.path.exists(fullpath):
        with open(fullpath) as ff:
            text = ff.read()

    data['transcript'] = text
    return data

@app.route("/api/file/update_transcript", methods=['POST'])
def api_file_update():
        root_dir = BASE_DIR
        data =json.loads(request.data.decode('utf-8'))
        filepath = data['path']
        filename = data['filename']
        text = data['transcript']
        folderpath = os.path.join(root_dir, filepath)
        fullpath = os.path.join(root_dir, filepath, filename)
        
        data = {}
        
        if os.path.exists(folderpath):
            with open(fullpath, 'w') as ff:
              text = ff.write(text)

            data['message'] = "Success"
        else:
            data['message'] = "Error: Folder does not exist"

        return data

@app.route("/api/file/delete", methods=['POST'])
def api_file_delete():
    root_dir = BASE_DIR
    data = json.loads(request.data.decode('utf-8'))
    filepath = data['path']
    fullpath = os.path.join(root_dir, filepath)
    
    data = {}
    if os.path.exists(fullpath):
        os.system("rm -r " + fullpath)

    data['message'] = "File successfully deleted."
    return data

@app.route("/api/file/upload", methods=['POST'])
def api_file_upload():
    root_dir = UPLOAD_FOLDER
    filepath = request.form['path']
    folder = request.form['folder']
    myfile = request.files['file']
    print()
    print("folder:", folder)
    # Ensure folder exists within the upload directory
    folder_path = os.path.join(root_dir, folder)
    os.makedirs(folder_path, exist_ok=True)

    data = {}
    if myfile:
        # Save the uploaded file to the specified folder
        file_path = os.path.join(folder_path, myfile.filename)
        myfile.save(file_path)

        data = {
            'message': "Successfully uploaded",
            'file_url': file_path  # You can return the full file path as the URL
        }
    else:
        data = {
            'message': "Failed to upload",
            'file_url': ""
        }

    return data




def get_folders(root, path):
    d = {
           'name': os.path.basename(path),
           'path': path
        }
    if os.path.isdir(os.path.join(root, path)):
        dirs_list = [get_folders(root, os.path.join(path, x)) \
                        if os.path.isdir(os.path.join(root, path, x)) \
                        else None \
                        for x in os.listdir(os.path.join(root, path))]
        dirs = filtered_list = list(filter(None, dirs_list))
        d['children'] = dirs

    return d