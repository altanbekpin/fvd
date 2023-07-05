# -*- coding: utf-8 -*-
from flask.cli import load_dotenv
from app import app
# from config import mysql
from flask import jsonify 
from flask import request
import json
import psycopg2
from flask_jwt_extended import current_user, jwt_required
import psycopg2.extras
import os
from db import *
import random
import school_termin_page
import legacy_page
import synomizer_page
import login_page

# app = Flask(__name__)
# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:magzhan2005@localhost/userdb'

confirmation_code = None

@app.route('/getontology/<lang>/', methods=['GET'])
def getontology(lang):
    from models import MyOwlReady
    print("/getontology/<lang>/")
    s = MyOwlReady()
    owls = s.GetJson(lang=lang)
    return jsonify(owls)

@app.route('/getontology/ask/', methods=['POST'])
def send_question():
    from models import MyOwlReady
    nation_to_lang = {
        'qazaq': 'kz',
        'qyrgyz': 'kg',
        'tatar': 'tatar',
        'turik': 'tr',
        'uzbek': 'uz'
    }
    descriptor_to_lang =  {
        'kz': 'Дескриптор',
        'kg': 'Дескриптор',
        'tatar': 'Дескриптор',
        'tr': 'Descriptor',
        'uz': 'Deskriptor'
    }
    descriptor_to_def =  {
        'kz': 'Анықтамасы',
        'kg': 'Аныктамасы',
        'tatar': 'Билгеләмә',
        'tr': 'Açıklaması',
        'uz': 'Ta’rif'
    }
    descriptor_to_question =  {
        'kz': 'Сұрағы',
        'kg': 'Суроо',
        'tatar': 'Сорау',
        'tr': 'Soru',
        'uz': 'Savoli'
    }
    descriptor_to_gyperonim =  {
        'kz': 'Гипероним',
        'kg': 'Гипероним',
        'tatar': 'Гипероним',
        'tr': 'Hiperonim',
        'uz': 'Giperonim'
    }
    descriptor_to_gyponim =  {
        'kz': 'Гипоним',
        'kg': 'Гипоним',
        'tatar': 'Гипоним',
        'tr': 'Hiponim',
        'uz': 'Giponim'
    }
    temp = json.loads(request.data.decode('utf-8'))
    
    question = temp['question']
    lang = 'kz'

    g = MyOwlReady().TurkOnto

    s= ''
    quest = '''
        PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>
        SELECT ?subject ?label WHERE {{ ?subject rdfs:label "''' + question + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))} union { ?subject rdfs:label "''' + question.capitalize() + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))}}'
    qres = g.query(quest)
    for row in qres:
        words = row[0].split('#')
        s = '<b>' + descriptor_to_lang[lang]+': </b>' + row[1]
        word = words[len(words)-1]
        s = s + "<br/><b>UniTurk: </b>" + word
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select * WHERE { kazont:' + word+ ''' kazont:definition ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), " ''' + lang + '")) }'
        defres = g.query(quest)
        for def_row in defres:
            s = s + '<br/> <b>' + descriptor_to_def[lang]+': </b>' + def_row[0]
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select * WHERE { kazont:' + word+ ''' kazont:question ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), "''' + lang + '")) }'
        defres = g.query(quest)
        for def_row in defres:
            s = s + '<br/> <b>' + descriptor_to_question[lang]+': </b>' + def_row[0]

        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select ?label WHERE {kazont:' + word+ ''' rdfs:subClassOf  ?s . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyperonim[lang]+': </b>'
        for def_row in defres:
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] + "</a>"

        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select ?label WHERE {?s rdfs:subClassOf kazont:' + word+ '''  . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyponim[lang]+': </b>'
        for def_row in defres:
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] +  "</a>"
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> SELECT ?subject ?label WHERE { ?subject rdf:type kazont:'+word+' . ?subject rdfs:label ?label FILTER(LANG(?label) = "' + lang + '" )}'
        defres = g.query(quest)
        s = s + "<br/><b>Индивид: </b>"
        instance_count = 0
        for def_row in defres:
            instance_count = instance_count + 1
            s = s + '<p style="color:red; margin-bottom:0">&emsp;' + def_row[1] +'</p>'
        if instance_count == 0 and lang == 'kz':
            quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> SELECT ?subject WHERE { ?subject rdf:type kazont:'+word+'}'
            defres = g.query(quest)
            instance_count = 0
            s = s +'<p style="color:red; padding-left:15" class="m-0">'
            for def_row in defres:
                instance_count = instance_count + 1
                s = s + def_row[0].split('#')[1] +', '
            s = s + '</p>'
        s = s + '<br/><p style="color:red; margin-bottom:0">In other language:</p>'
        for key, value in nation_to_lang.items():
            if (value==lang):
                continue
            quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>  SELECT ?label WHERE { kazont:' + word + ' rdfs:label ?label FILTER(LANG(?label) = "'+value+'")}'
            def_qres = g.query(quest)
            for row in def_qres:
                s =s + '<p class="m-0">&emsp;<i>'+ key+ '</i>: ' + "<a href=\"javascript:DoSubmit('" + row[0] +"', '"+ value +"');\">" + row[0] + '</a></p>'
    return jsonify(s)





@app.route('/editPost/', methods = ['POST'])
@jwt_required()
def edit_post():
    results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
    role_ids = [result[0] for result in results]
    roles = []
    for i in role_ids:
        roles.append(Role.query.filter_by(role_id=i).one_or_none().name)
    if not 'admin' in roles:
        return jsonify("you don't have enough permission"), 500
    data = request.json
    conn = DB.get_db_connection()
    method = data.get('method').get('_value')
    cursor = conn.cursor()
    if method == 'delete':
        id = str(data.get('id'))
        cursor.execute("DELETE FROM termin WHERE id = %s", (id,))
    elif method == 'create':
        name = data.get('name').get('_value')
        descrpition = data.get('description').get('_value')
        example = data.get('example').get('_value')
        cursor.execute("INSERT INTO termin (name, description, examples) VALUES (%s, %s, %s)", (name, descrpition, example))
    try:
        conn.commit()
    except Exception as e:
        return jsonify(e), 500
    return jsonify('successful'), 200

@app.route('/delete/file', methods=['POST'])
def delete():
    fileID = request.form.get('fileID')
    try:
        conn = DB.get_db_connection()
        cur = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        cur.execute('DELETE FROM legacy WHERE id = %s RETURNING *;', (fileID,))
        deleted_row = cur.fetchone()
        path = deleted_row['path']
        if os.path.exists(path):
            os.remove(path)
            conn.commit()
            return 'successfully deleted', 200
        else:
            return 'failed', 404
    except Exception as e:
        return 'error', 400

@app.route('/change/file/name', methods=['POST'])
def changeFileName():
    fileID = request.form.get('fileID')
    fileName = request.form.get('FileName')
    try:
        conn = DB.get_db_connection()
        cur = conn.cursor()
        cur.execute('UPDATE legacy SET name = %s WHERE id = %s', (fileName, fileID))
        conn.commit()
    except Exception as e:
        return 'failed', 404
    return 'success', 200


@app.route('/upload', methods=['POST', 'OPTIONS'])
def upload_file():
    if request.method == 'OPTIONS' or len(request.form.keys()) == 0:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type'
        }
        return ('', 204, headers)
    data = request.files
    path_to_save = request.form.get('path_to_save')
    parent_id = request.form.get('parent_id')
    

    for key in data.keys():
        file_storage = data.get(key)
        #filename = file_storage.filename
        content_type = file_storage.content_type
        path_to_save = path_to_save
        content_type = content_type.split("/")[1]
        try:
            #data[key].save(f'./{path_to_save}/' + filename)
            file_storage.filename = key
            file_storage.save(f'./{path_to_save}/' + key + '.' + content_type) 
            db = DB.get_db_connection()
            cur = db.cursor()
            cur.execute('ALTER SEQUENCE legacy_id_seq RESTART WITH 100;')
            cur.execute("INSERT INTO legacy (name, path, parent_id, is_file) VALUES (%s, %s, %s, %s);", (key, path_to_save + "/" + file_storage.filename + '.' + content_type, parent_id, 1))
            db.commit()
            cur.close()
            db.close()
        except Exception as e:
            return 'File uploading failed', 400
        print(f"File {file_storage.filename} with content type {content_type} uploaded with key '{key}'")
    return 'File uploaded successfully'

@app.route('/classification/', methods=['POST'])
def get_classification():
    conn = DB.get_db_connection()
    data = request.json

    first = data.get("first")
    if data.get("page") != None:
        first = data.get("page")
    rows = data.get("rows")
    cursor = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
    offset = first * rows  # вычисляем смещение
    if data.get('filters').get("global").get("value") != None:
    
        search_text = data.get('filters').get("global").get("value") 
        cursor.execute("SELECT * FROM termin WHERE name LIKE %s or description LIKE %s or examples LIKE %s LIMIT %s OFFSET %s",
            ('%' + search_text + '%','%' + search_text + '%','%' + search_text + '%',rows,offset))
    else:
        cursor.execute("SELECT * FROM termin LIMIT %s OFFSET %s",(rows,offset,))        
    # Execute a SQL query to find the user and password combination

    
    rows = cursor.fetchall()


    return rows

@app.route('/search/book/', methods=['POST'])
def searchBook():
    cur = DB.get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)
    data = request.json['_rawValue']['global']
    cur.execute("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name LIKE %s;", ('%' + data + '%',))
    results = cur.fetchall()
    legacies = jsonify(results)
    return legacies, 200

@app.route('/search/book/file/', methods=['POST'])
def searchFile():
    cur = DB.get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)
    data = request.json['global']
    cur.execute("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name ILIKE %s;", ('%' + data + '%',))
    results = cur.fetchall()
    legacies = jsonify(results)
    return legacies, 200

@app.route('/register', methods=['POST'])
def register():
    global confirmation_code  # Access the global variable
    
    email = request.json['email']
    confirmation_code = generate_confirmation_code()
    
    # Rest of the code to send the confirmation email
    
    return jsonify({'message': 'Confirmation code sent successfully'})

@app.route('/confirm', methods=['POST'])
def confirm():
    global confirmation_code  # Access the global variable
    
    email = request.json['email']
    code = request.json['code']
    
    if confirmation_code and code == confirmation_code:
        # Code validation successful
        return jsonify({'message': 'Confirmation successful'})
    else:
        # Code validation failed
        return 400, jsonify({'message': 'Invalid confirmation code'})

def generate_confirmation_code():
    # Generate and return a random confirmation code
    # You can use your own logic here
    return random.randint(100000, 999999)

if __name__ == "__main__":
    from models import MyOwlReady
    load_dotenv()
    s = MyOwlReady()
    app.run(port=5001, debug=True, host=os.environ.get("API_URL"))    


