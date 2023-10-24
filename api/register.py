from app import app, mail
from flask import request, jsonify
import random
from flask_mail import Message
from db import DB
import smtplib
from flask_jwt_extended import create_access_token
@app.route('/register', methods=['POST'])
def register():
    data = request.json['data']
    email = data['email']
    password = data['password']
    full_name = data['full_name']
    confirmation_code = generate_confirmation_code()
    try:
        send_code(email, confirmation_code)
        DB.get_instance().save_user(email, password, confirmation_code, full_name)
        data = {'message': 'Registration successful! Please check your email for verification'}
        return jsonify(data), 200
    except Exception as e:
        data =  {'message': 'Registration failed', 'error': str(e)}
        return jsonify(data), 400


@app.route('/confirm', methods=['POST'])
def confirm():
    data = request.json['data']
    email = data['email']
    code = data['code']
    confirmation_code = DB.get_instance().get_conf_code(email)
    if DB.get_instance().check_code(code, confirmation_code):
        DB.get_instance().verify_user(email)
        return jsonify({'message': 'Ұсынысыңыз жіберілді, күтіңіз'})
        # if DB.get_instance().isUserActivated(user):
        #     raise ValueError()
        # access_token = create_access_token(identity=user)
        # return jsonify({'message': 'Растау сәтті жүзеге асты', 'access_token':access_token})
    else:
        return jsonify({'message': 'Қате растау коды'}), 400

def generate_confirmation_code():
    return random.randint(100000, 999999)

def send_code(email, confirmation_code):
    sender = app.config['MAIL_USERNAME']
    print("sender:", sender) 
    msg = Message('Confirmation Code', recipients=[email],sender=sender)
    msg.body = f'Сіздің тіркелу кодыңыз: {confirmation_code}'
    try:
        mail.send(msg)
    except smtplib.SMTPAuthenticationError as e:
        raise ValueError('Қате логин')