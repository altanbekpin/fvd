from app import app
from db import DB
from flask_jwt_extended import jwt_required, current_user
from flask import jsonify, request
from ast import literal_eval

@app.route('/offers', methods=['GET'])
@jwt_required()
def getOffers():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    lazy_event_str = request.args.get('lazyEvent')
    lazy_event = literal_eval(lazy_event_str)
    first = lazy_event['first']
    rows = lazy_event['rows']
    status = lazy_event.get('filters', "")
    all_offers = DB.get_instance().getOffers(first,rows, status)
    return all_offers

@app.route("/activate", methods=['POST'])
@jwt_required()
def activateOffer():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
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
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        count, today_offers = DB.get_instance().get_amount_offers()
    except Exception as e:
        return jsonify({"message":str(e)}), 400  
    return {"count": count, "today_offers": today_offers}

@app.route("/offers/count/words", methods=['GET'])
@jwt_required()
def get_amount_words():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        words_count, words_count_activated = DB.get_instance().get_amount_words()
    except Exception as e:
        return jsonify({"message":str(e)}), 400
    return {"words_count": words_count, "words_count_activated": words_count_activated}

@app.route("/offers/count/users", methods=['GET'])
@jwt_required()
def get_amount_users():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        users, admins = DB.get_instance().get_amount_users()
    except Exception as e:
        return jsonify({'message': str(e)}), 400
    return {"users":users, "admins":admins}

@app.route("/offers/count/synphrase", methods=['GET'])
@jwt_required()
def get_amount_synphrases():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    try:
        amount = DB.get_instance().get_amount_synparaphrases()
    except Exception as e:
        return jsonify({'message': str(e)}), 400
    return amount

@app.route("/user/info", methods=['GET'])
@jwt_required()
def get_inf_for_table():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})   
    start = literal_eval(request.args.get('start'))
    result = DB.get_instance().get_inf_for_table(start)
    return result

@app.route("/word/overview", methods=['GET'])
@jwt_required()
def word_overview():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    dates = literal_eval(request.args.get('dates'))
    results = []
    for i in dates:
        results.append(DB.get_instance().word_view(i))
    return results

@app.route("/user/table", methods=['GET'])
@jwt_required()
def user_table():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    users_results = DB.get_instance().user_table()
    print("users_results:", users_results)
    return users_results


@app.route('/last/news')
@jwt_required()
def last_news():
    if not DB.get_instance().isUserAdmin(current_user) and not DB.get_instance().isUserExpert(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    results = DB.get_instance().last_news()
    return results

@app.route('/manage/user', methods=['DELETE', 'PUT'])
@jwt_required()
def delete_user():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    id = request.args.get('id')
    if request.method == 'DELETE':
        DB.get_instance().delete_user(id)
        return 'success', 200
    if request.method == 'PUT':
        print("HERERERERER")
        DB.get_instance().up_user_role(id)
        return 'success', 200
    return 'failed', 400

@app.route('/updateuser', methods=['POST'])
@jwt_required()
def update_user():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    data = request.json['data']
    email = data['email']
    full_name = data['full_name']
    id = data['id']
    DB.get_instance().update_user(email, full_name, id)
    return 'success', 200
    