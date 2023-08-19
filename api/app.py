# -*- coding: utf-8 -*-
from flask import Flask
from flask_cors import CORS, cross_origin
from flask_mail import Mail
app = Flask(__name__)
app.config['DB_PASSWORD'] = "magzhan2005"
password = app.config['DB_PASSWORD']
# app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://postgres:{password}@db/userdb'
app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://postgres:{password}@localhost:5435/userdb'
# app.config['JSON_AS_ASCII'] = False
app.config["JWT_SECRET_KEY"] = "@Remote2022" 
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'enu201309@gmail.com'
app.config['MAIL_PASSWORD'] = 'zbtjzkncpdtbiczn'
mail = Mail(app)
CORS(app, origins=['http://localhost:8080', 'http://kazlangres.enu.kz'])
CORS(app)