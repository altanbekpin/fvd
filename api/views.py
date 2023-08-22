from db import Db
import os
import io
import struct

import requests
from flask import request, send_file
from flask_restful import Resource



from google.cloud import speech
from google.protobuf.json_format import MessageToDict
from google.cloud import translate_v2
from google.cloud import texttospeech


class Speech(Resource):
    def __init__(self):
        os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r"key.json"
        # self.speechClient = speech.SpeechClient.from_service_account_file('key.json')
        self.speechClient = speech.SpeechClient()
        self.translateClient = translate_v2.Client()
        self.target = "ru"
        self.source = "kk"


    def post(self):
        files = request.files

        speechFile = files.get('speech')
        speechFile.stream.seek(0)
        riff, size, fformat = struct.unpack('<4sI4s', speechFile.read(12))
        print("Riff: %s, Chunk Size: %i, format: %s" % (riff, size, fformat))
        chunk_header = speechFile.read(8)
        subchunkid, subchunksize = struct.unpack('<4sI', chunk_header)
        channels = 1
        samplerate = 44100 
        if (subchunkid == b'fmt '):
            aformat, channels, samplerate, byterate, blockalign, bps = struct.unpack('HHIIHH', speechFile.read(16))
            bitrate = (samplerate * channels * bps) / 1024
            print("Format: %i, Channels %i, Sample Rate: %i, Kbps: %i" % (aformat, channels, samplerate, bitrate))
        speechFile.stream.seek(0)
        audio = speechFile.read()
      
        #Read header
       
        audio_file = speech.RecognitionAudio(content=audio)
        print("chunk_header")
        print(chunk_header)
        # print(audio_file)
        config = speech.RecognitionConfig(
            sample_rate_hertz=samplerate,
            enable_automatic_punctuation=True,
            # language_code='en-GB'
            language_code='kk-KZ',
            audio_channel_count =  channels
        )
        response = self.speechClient.recognize(
            config=config,
            audio=audio_file
        )
        if response.results and len(response.results)>0: 
            if response.results[0].alternatives and len(response.results[0].alternatives)>0:
                text = response.results[0].alternatives[0].transcript
                translated = self.translateClient.translate(text, source_language = self.source, target_language=self.target)
                return {
                    'text': response.results[0].alternatives[0].transcript,
                    'translatedText': translated["translatedText"]
                }
            else:
                abort(403, error_message='text not found')
class TextToSpeech(Resource):
    def __init__(self):
        os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r"key.json"
        # self.speechClient = speech.SpeechClient.from_service_account_file('key.json')
        self.textToSpeechClient = texttospeech.TextToSpeechClient()
        self.target = "ru-RU"
    def post(self):
        content = request.json
        text = content["text"]
        request4 = requests.post(self.api_url_tt_to_speech, data={'text':text})
        if request4.status_code == 200:
            return send_file(
                io.BytesIO(request4.content),
                download_name='speech.wav',
                mimetype='audio/wav'
            )
