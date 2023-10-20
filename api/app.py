from datetime import timedelta
# -*- coding: utf-8 -*-
from flask import Flask
from flask_cors import CORS, cross_origin
from flask_mail import Mail
from tokenizers import Tokenizer
from models import MyOwlReady
from views import TextToSpeech
from flask_restful import Api
import threading

class MyExtendedFlaskApp(Flask):
    def __init__(self, *args, **kwargs):
        super(MyExtendedFlaskApp, self).__init__(*args, **kwargs)
        self.s = MyOwlReady()
        self.graph_lock = threading.Lock()
        self.tokenizer = Tokenizer.from_file("kazakh-bpe.tokenizer.json")
        self.vocabulary = self.tokenizer.get_vocab()
        
    def is_exists_in_vocab(self, word, endings):
        # Проход по всем токенам в словаре
        for token in self.vocabulary .keys():
            # Проверка наличия слова или подслова в токене
            for i in range(len(endings)):
                if word + endings[i] in token or token in word:
                    return endings[i]
        return endings[0]

app = MyExtendedFlaskApp(__name__)
# app.s = MyOwlReady()
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
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=3)
mail = Mail(app)
CORS(app, origins=['http://localhost:8080', 'http://kazlangres.enu.kz', "http://localhost:5173", "http://127.0.0.1:5173"])
CORS(app)
api = Api(app)
api.add_resource(TextToSpeech, '/ttspeech')