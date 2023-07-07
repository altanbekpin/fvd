from app import app
from flask import jsonify, request
from db import DB

@app.route('/search/book/', methods=['POST'])
def searchBook():
    data = request.json['_rawValue']['global']
    results = DB.get_instance().search_book(data)
    legacies = jsonify(results)
    return legacies, 200

@app.route('/search/book/file/', methods=['POST'])
def searchFile():
    data = request.json['global']
    results = DB.get_instance().search_book(data)
    legacies = jsonify(results)
    return legacies, 200
