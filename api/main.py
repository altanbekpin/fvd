# -*- coding: utf-8 -*-
from flask.cli import load_dotenv
from app import app
import os
from db import *
# from models import MyOwlReady
import school_termin_page, login_page, legacy_page, tagger, synomizer_page, ontology_page, termin_definition, enter_page, register, admin_page, intelect, syntez
from db import db
if __name__ == "__main__":
    load_dotenv()
    app.run(port=5001, debug=True, host=os.environ.get("API_URL"))
