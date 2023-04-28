# -*- coding: utf-8 -*-
from flask import Flask
from flask_cors import CORS, cross_origin


app = Flask(__name__)
CORS(app)

# from models import LegacySchema
# from flask import request
# from flask import Flask, abort, jsonify
# from flask_cors import CORS
# from flask_restful import Api
# from flaskext.mysql import MySQL
# from marshmallow import ValidationError

# mysql = MySQL()
# app = Flask(__name__)
# app.config['MYSQL_DATABASE_HOST'] = '10.255.140.4'
# app.config['MYSQL_DATABASE_USER'] = 'remoteuser'
# app.config['MYSQL_DATABASE_PASSWORD'] = '@Remote2022'
# app.config['MYSQL_DATABASE_DB'] = 'quotes_db'
# app.config['MYSQL_DATABASE_PORT'] = 33066


# mysql.init_app(app)
# conn = mysql.connect()

# CORS(app)
# api = Api(app)





# @app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
# @app.route('/getlegacies/<int:parent_id>', methods=['GET'])
# def get_legacy_records(parent_id):
#     try:
       
#         cur = mysql.get_db().cursor()
#         if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
#             cur.execute("SELECT id, name FROM legacy WHERE parent_id IS NULL")
#         else:  # В противном случае выбираем записи с указанным parent_id
#             cur.execute("SELECT * FROM legacy WHERE parent_id=%s", [parent_id])

#         results = cur.fetchall()
#         legacy_schema = LegacySchema(many=True)
#         legacies = legacy_schema.dump(results)
#         print(legacies)
#         print(results)
#         return jsonify(legacies)
#     except ValidationError as err:
#         return jsonify(err.messages), 400
#     except Exception as e:
#         return jsonify(str(e)), 500



# if __name__ == "__main__":
#     app.run(port=5001, debug=True)    