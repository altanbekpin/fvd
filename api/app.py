# -*- coding: utf-8 -*-
from flask import Flask
from flask_cors import CORS, cross_origin
from flask_mail import Mail


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:magzhan2005@db/userdb'
app.config['JSON_AS_ASCII'] = False
app.config["JWT_SECRET_KEY"] = "@Remote2022" 
# app.config['MAIL_SERVER'] = 'your_smtp_server'
# app.config['MAIL_PORT'] = 587
# app.config['MAIL_USE_TLS'] = True
# app.config['MAIL_USERNAME'] = 'your_email@example.com'
# app.config['MAIL_PASSWORD'] = 'your_email_password'

# mail = Mail(app)
CORS(app, origins=['http://localhost:8080', 'http://kazlangres.enu.kz'])
CORS(app)