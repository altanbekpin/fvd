from app import app
from db import DB
from flask_jwt_extended import jwt_required, current_user
from flask import jsonify, request
from ast import literal_eval

@app.route('/offers', methods=['GET'])
@jwt_required()
def getOffers():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    lazy_event_str = request.args.get('lazyEvent')
    print("lazy_event_str:", lazy_event_str)
    lazy_event = literal_eval(lazy_event_str)
    first = lazy_event['first']
    rows = lazy_event['rows']
    status = lazy_event.get('filters', "")
    all_offers = DB.get_instance().getOffers(first,rows, status)
    return all_offers

@app.route("/activate", methods=['POST'])
@jwt_required()
def activateOffer():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    offer_id = request.json['offer_id']
    activate_type = request.json['activate_type']
    try:
        DB.get_instance().activate_offer(offer_id, activate_type)
    except Exception as e:
        return jsonify({"message":str(e)}), 400
    return jsonify({"message":"success"}), 200

@app.route("/offers/count", methods=['GET'])
@jwt_required()
def get_amount_offers():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        count, today_offers = DB.get_instance().get_amount_offers()
    except Exception as e:
        return jsonify({"message":str(e)}), 400  
    return {"count": count, "today_offers": today_offers}

@app.route("/offers/count/words", methods=['GET'])
@jwt_required()
def get_amount_words():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        words_count, words_count_activated = DB.get_instance().get_amount_words()
    except Exception as e:
        return jsonify({"message":str(e)}), 400
    return {"words_count": words_count, "words_count_activated": words_count_activated}

@app.route("/offers/count/users", methods=['GET'])
@jwt_required()
def get_amount_users():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        users, admins = DB.get_instance().get_amount_users()
    except Exception as e:
        return jsonify({'message': str(e)}), 400
    return {"users":users, "admins":admins}

@app.route("/offers/count/synphrase", methods=['GET'])
@jwt_required()
def get_amount_synphrases():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        amount = DB.get_instance().get_amount_synparaphrases()
    except Exception as e:
        return jsonify({'message': str(e)}), 400
    return amount

@app.route("/user/info", methods=['GET'])
@jwt_required()
def get_inf_for_table():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})   
    result = DB.get_instance().get_inf_for_table()
    return result


