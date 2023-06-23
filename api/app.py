# -*- coding: utf-8 -*-
from flask import Flask
from flask_cors import CORS, cross_origin
from flask_jwt_extended import JWTManager


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:magzhan2005@db/userdb'
app.config['JSON_AS_ASCII'] = False
app.config["JWT_SECRET_KEY"] = "@Remote2022" 
CORS(app, origins=['http://localhost:8080', 'http://kazlangres.enu.kz'])
CORS(app)