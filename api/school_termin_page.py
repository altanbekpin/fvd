from app import app
from db import DB, UserRole
from flask import request
import json
from flask_jwt_extended import current_user, jwt_required

@app.route("/getTermins", methods=['POST', "GET"])
def getTermins():
    data = request.json['data']['data']
    print("data:",json.dumps(data, indent=2))
    first = data['first']
    filters = data["filters"]
    word = data.get("word", "")
    schoolTermins = DB.getSchoolTermins(first, filters, word)
    return schoolTermins

@app.route("/countTermins", methods=['GET'])
def countTermins():
    amoung = DB.countSchoolTermins()
    return amoung

@app.route("/add/termin", methods=['POST'])
def addTermin():
    data = request.json['data']
    print("data:", data)
    termin = data['termin']
    definition = data['definition']
    subject_id = data['subject']['id']
    school_class = data['school_class']
    try:
        DB.addTermin(termin=termin, definition=definition, subject_id=subject_id, school_class=school_class)
    except Exception as e:
        return 400, e
    return "success", 200

@app.route("/get/class/subject", methods=['GET'])
def get_subject_class():
    return DB.get_subjects()

@app.route("/add/subject", methods=['POST'])
@jwt_required()
def addSubject():
    roles = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
    print("roles:", roles)
    data = request.json['data']
    subject = data['subject']
    try:
        DB.add_subject(subject)
    except Exception as e:
        return "Bad request", 400
    return 'success', 200


