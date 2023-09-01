from app import app
from datetime import timedelta
from flask_jwt_extended import create_access_token, current_user, jwt_required, create_refresh_token
from flask import request, jsonify 
from db import User, UserRole, Role, DB
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import JWTManager
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(hours=10)

jwt = JWTManager(app)

@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id

@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    return User.query.filter_by(id=identity).one_or_none()

@app.route("/", methods=["GET"])
def initialRoute():
    return "success", 200

@app.route('/login/', methods=['POST'])
def login():
    data = request.json['data']
    email = data["email"]
    password = data["password"]
    if not DB.get_instance().isUserExist(email):
        return jsonify("Тіркелмеген"), 401
    user = DB.get_instance().check_credentials(email, password)
    if user is None: 
        return jsonify("Қате логин немесе пароль"), 400
    if not DB.get_instance().isUserActivated(user):
        return jsonify(message="Сіздің тіркелу сұранысыңыз қабылданбаған"), 400
    access_token = create_access_token(identity=user)
    refresh_token = create_refresh_token(identity=user)
    return jsonify(message="Сәтті жүзеге асырылды",access_token=access_token, refresh_token=refresh_token)

@app.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    identity = get_jwt_identity()
    access_token = create_access_token(identity=identity)
    return jsonify(access_token=access_token)

@app.route("/who_am_i/", methods=["GET"])
@jwt_required()
def protected():
    results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
    role_ids = [result[0] for result in results]
    roles = []
    for i in role_ids:
        roles.append(Role.query.filter_by(role_id=i).one_or_none().name)
    return jsonify(
        roles = roles,
        id=current_user.id,
        email=current_user.email,
    )

