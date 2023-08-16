# -*- coding: utf-8 -*-
from flask.cli import load_dotenv
from tokenizers import Tokenizer
from app import app
import os
from db import *
import school_termin_page, login_page, legacy_page, tagger, synomizer_page, ontology_page, termin_definition, enter_page, register, admin_page
from db import db
if __name__ == "__main__":
    from models import MyOwlReady
    load_dotenv()
    app.s = MyOwlReady()
    app.tokenizer = Tokenizer.from_file("kazakh-bpe.tokenizer.json")
    app.run(port=5001, debug=True, host=os.environ.get("API_URL"))    


