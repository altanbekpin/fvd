from app import app
from db import DB
from flask_jwt_extended import jwt_required, current_user
from flask import jsonify, request
@app.route('/offers', methods=['GET'])
@jwt_required()
def getOffers():
    if not DB.get_instance().isUserAdmin(current_user):
        return jsonify({"message":"Сізде құқық жеткіліксіз"})
    all_offers = DB.get_instance().getOffers()
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
        return jsonify({"message":str(e)}), 200  
    return jsonify({"message":"success"}), 200
    
