import os
import io

import requests, re
from flask import request, send_file
from flask_restful import Resource


class TextToSpeech(Resource):
    def __init__(self):
       pass
    def post(self):
        self.api_url_tt_to_speech =  'http://kazlangres.enu.kz:7557/synthes'
        content = request.json
        text = content["text"]
        cleaned = re.sub(r'[^а-яА-ЯӘәІіҢңҒғҮүҰұҚқҺһa-zA-Z0-9.,!?;:]', '', text)

        request4 = requests.post(self.api_url_tt_to_speech, data={'text':cleaned})
        if request4.status_code == 200:
            return send_file(
                io.BytesIO(request4.content),
                download_name='speech.wav',
                mimetype='audio/wav'
            )
