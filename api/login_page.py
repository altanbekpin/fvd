from app import app
from flask_jwt_extended import create_access_token, current_user, jwt_required
from flask import request, jsonify 
from db import User, UserRole, Role
from flask_jwt_extended import JWTManager
import random
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
    # Get the user and password from the request body
    email = request.json.get("email", None)
    password_hash = request.json.get("password", None)
    user = User.query.filter_by(email=email, password_hash=password_hash).one_or_none()
    if not user:
        return jsonify("Wrong username or password"), 401
    access_token = create_access_token(identity=user)
    return jsonify(access_token=access_token)

@app.route("/who_am_i/", methods=["GET"])
@jwt_required()
def protected():
    # We can now access our sqlalchemy User object via `current_user`.
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

@app.route('/register', methods=['POST'])
def register():
    global confirmation_code  # Access the global variable
    
    email = request.json['email']
    confirmation_code = generate_confirmation_code()
    
    # Rest of the code to send the confirmation email
    
    return jsonify({'message': 'Confirmation code sent successfully'})

@app.route('/confirm', methods=['POST'])
def confirm():
    global confirmation_code  # Access the global variable
    
    email = request.json['email']
    code = request.json['code']
    
    if confirmation_code and code == confirmation_code:
        # Code validation successful
        return jsonify({'message': 'Confirmation successful'})
    else:
        # Code validation failed
        return 400, jsonify({'message': 'Invalid confirmation code'})

def generate_confirmation_code():
    # Generate and return a random confirmation code
    # You can use your own logic here
    return random.randint(100000, 999999)