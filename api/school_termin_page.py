from app import app
from db import DB
from flask import request
import json
from flask_jwt_extended import current_user, jwt_required

@app.route("/getTermins", methods=['POST', "GET"])
def getTermins():
    data = request.json['data']['data']
    # print("data:",json.dumps(data, indent=2))
    first = data['first']
    filters = data["filters"]
    word = data.get("word", "")
    isChildren = data.get("isChildren", "")
    schoolTermins = DB.get_instance().getSchoolTermins(first, filters, word, isChildren)
    return schoolTermins

@app.route("/countTermins", methods=['GET'])
def countTermins():
    # print("/countTermins")
    amoung = DB.get_instance().countSchoolTermins()
    return amoung

@app.route("/countChildrenTermins", methods=['GET'])
def countChildrenTermins():
    # print("/countChildrenTermins")
    amoung = DB.get_instance().countSchoolTermins(isChildren=True)
    return amoung

@app.route("/add/termin", methods=['POST'])
@jwt_required()
def addTermin():
    # print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return "don't have enough permission", 500
    data = request.json['data']
    # print("data:", data)
    termin = data['termin']
    definition = data['definition']
    subject_id = data['subject']['id']
    school_class = data['school_class']
    try:
        DB.get_instance().addTermin(termin=termin, definition=definition, subject_id=subject_id, school_class=school_class)
    except Exception as e:
        return 400, e
    return "success", 200

@app.route("/get/class/subject", methods=['GET'])
def get_subject_class():
    # print("/get/class/subject")
    try:
        subjects = DB.get_instance().get_subjects()
    except Exception as e:
        print(e)
    return subjects

@app.route("/add/subject", methods=['POST'])
@jwt_required()
def addSubject():
    if not DB.isUserAdmin(current_user):
        return "don't have enough permission", 500
    data = request.json['data']
    subject = data['subject']
    try:
        DB.get_instance().add_subject(subject)
    except Exception as e:
        return "Bad request", 400
    return 'success', 200


