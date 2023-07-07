from flask import request, jsonify
from app import app
from flask_jwt_extended import jwt_required, current_user
from db import DB

@app.route('/editPost/', methods = ['POST'])
@jwt_required()
def edit_post():
    results = DB.get_instance().find_user(current_user)
    role_ids = [result[0] for result in results]
    roles = []
    for i in role_ids:
        roles.append(DB.get_instance().get_role(i).name)
    if not isAdmin(roles):
        return jsonify("you don't have enough permission"), 500
    data = request.json
    method = data.get('method').get('_value')
    if method == 'delete':
        id = str(data.get('id'))
        DB.get_instance().delete_post(id)
    elif method == 'create':
        name = data.get('name').get('_value')
        descrpition = data.get('description').get('_value')
        example = data.get('example').get('_value')
        DB.get_instance().create_post(name, descrpition, example)
    return jsonify('successful'), 200

@app.route('/classification/', methods=['POST'])
def get_classification():
    data = request.json

    first = data.get("first")
    if data.get("page") != None:
        first = data.get("page")
    rows = data.get("rows")
    offset = first * rows  # вычисляем смещение
    if data.get('filters').get("global").get("value") != None:
        search_text = data.get('filters').get("global").get("value")
        rows = DB.get_instance().search_classification(search_text, rows,offset)
    else:
        rows = DB.get_instance().get_classification(rows,offset)
    
    return rows

def isAdmin(list):
    return 'admin' in list