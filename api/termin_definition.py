from flask import request, jsonify
from app import app
from flask_jwt_extended import jwt_required, current_user
from db import DB

@app.route('/editPost/', methods = ['POST'])
@jwt_required()
def edit_post():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    data = request.json
    # print("data:", data)
    method = data.get('method').get('_value')
    if method == 'delete':
        for id in data.get('id'):
            DB.get_instance().delete_post(id)
    elif method == 'create':
        name = data.get('name').get('_value')
        descrpition = data.get('description').get('_value')
        example = data.get('example').get('_value')
        DB.get_instance().create_post(name, descrpition, example)
    elif method == "update":
        id = data.get('id').get('_value')
        name = data.get('name').get('_value')
        descrpition = data.get('description').get('_value')
        example = data.get('example').get('_value')
        DB.get_instance().update_post(id, name, descrpition, example)
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