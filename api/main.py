# -*- coding: utf-8 -*-
import pymysql
from app import app
# from config import mysql
from flask import jsonify, send_file
from flask import request
import json
import config
import psycopg2
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import create_access_token, JWTManager, current_user, jwt_required
import psycopg2.extras
import pandas as pd
from flask_cors import CORS
import os
import re
from morphology_api.morphology import Lemms
from nltk.tokenize import sent_tokenize as st




app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:magzhan2005@localhost/userdb'
CORS(app)
CORS(app, origins=['http://localhost:8080'])

jwt = JWTManager(app)
db = SQLAlchemy(app)
@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id

@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    return User.query.filter_by(id=identity).one_or_none()
class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(80), unique=True, nullable=False)
    password_salt = db.Column(db.String(120), nullable=False)
    password_hash = db.Column(db.String(120), nullable=False)

class UserRole(db.Model):
    __tablename__ = 'user_role'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer)
    role_id = db.Column(db.Integer)

class Role(db.Model):
    __tablename__ = 'role'
    role_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    description = db.Column(db.String(100), unique=True, nullable=False)
    

def get_db_connection():
    conn = psycopg2.connect(
            host="localhost",
            database="userdb",
            user='postgres',
            password='magzhan2005')
    return conn

@app.route('/getontology/<lang>/', methods=['GET'])
def getontology(lang):
    s = MyOwlReady()
    owls = s.GetJson(lang=lang)
    return jsonify(owls)

@app.route('/login/', methods=['POST'])
def login():
    # Get the user and password from the request body
    email = request.json.get("email", None)
    password_salt = request.json.get("password", None)
    user = User.query.filter_by(email=email, password_salt=password_salt).one_or_none()
    if not user:
        return jsonify("Wrong username or password"), 401
    access_token = create_access_token(identity=user)
    return jsonify(access_token=access_token)

@app.route("/who_am_i/", methods=["GET"])
@jwt_required()
def protected():
    # We can now access our sqlalchemy User object via `current_user`.
    results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
    role_ids = [result[0] for result in results]
    roles = []
    for i in role_ids:
        roles.append(Role.query.filter_by(role_id=i).one_or_none().name)
    #role_names = [role for role in roles]
    # print(roles)
    # print(role_ids)
    return jsonify(
        roles = roles,
        id=current_user.id,
        email=current_user.email,
    )


@app.route('/getontology/ask/', methods=['POST'])
def send_question():
    #print('send_question')
    #print(request)
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

    # question = request.POST['question']
    # lang = request.POST['language']
    #print(request.data.decode('utf-8'))
    temp = json.loads(request.data.decode('utf-8'))
    
    question = temp['question']
    #print('#####################')
    #print(question)
    # lang = request.POST['language']
    lang = 'kz'

    g = MyOwlReady().TurkOnto
    #g.parse ('ontology.owl')

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
    print(s)
    return jsonify(s)
@app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
@app.route('/getlegacies/<int:parent_id>', methods=['GET'])
def get_legacy_records(parent_id):
    print('get_legacy_records')
    try:
        cur = get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)#mysql.get_db().cursor(pymysql.cursors.DictCursor)#cur = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
            cur.execute("SELECT id AS key, name AS label, path AS data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL;")
        else:  # В противном случае выбираем записи с указанным parent_id
            cur.execute("SELECT id as key, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s", [parent_id])


        results = cur.fetchall()
        print(results)
        legacies = jsonify(results)
        return legacies

    except Exception as e:
        print('exeption')
        return jsonify(str(e)), 500

@app.route('/legacy/download/<int:file_id>', methods=['GET'])
def download_file(file_id):
    print('download_file')
    cur = get_db_connection().cursor()
    cur.execute("SELECT path from legacy WHERE id = %s",[file_id])
    print('SELECTING')
    results = cur.fetchall()
    for row in results:
        path = row[0]
    print(path)
    return send_file(path, as_attachment=True)
# Мұрасы/Тіл ғылымы/Әліппелер/Сауат ашқыш. Ересектерге арналған әліппе. Семей. 1926.pdf
# Мұрасы/Тіл ғылымы/Әліппелер
# @app.after_request
# def after_request(response):
#   response.headers.add('Access-Control-Allow-Origin', '*')
@app.route('/editPost/', methods = ['POST'])
@jwt_required()
def edit_post():
    print('edit_post')
    results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
    role_ids = [result[0] for result in results]
    roles = []
    for i in role_ids:
        roles.append(Role.query.filter_by(role_id=i).one_or_none().name)
    if not 'admin' in roles:
        return jsonify("you don't have enough permission"), 500
    data = request.json
    print('PRINTING DATA')
    print(data)

    conn = get_db_connection()
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

# @app.route(', methods=['DELETE'])
# def delete(row_id):
#     cur = conn.cursor()
#     cur.execute('DELETE FROM your_table_name WHERE id = %s RETURNING *', (row_id,))
#     deleted_row = cur.fetchone()
#     conn.commit()
#     cur.close()
#     return jsonify(deleted_row)

@app.route('/delete/file', methods=['POST'])
def delete():
    fileID = request.form.get('fileID')
    try:
        conn = get_db_connection()
        cur = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        cur.execute('DELETE FROM legacy WHERE id = %s RETURNING *;', (fileID,))
        deleted_row = cur.fetchone()
        path = deleted_row['path']
        print('deleted row:', deleted_row)
        print('path: ',path)
        print(fileID)
        if os.path.exists(path):
            print('file is found')
            os.remove(path)
            conn.commit()
            return 'successfully deleted', 200
        else:
            print('file is not found')
            return 'failed', 404
    except Exception as e:
        print(e)
        return 'error', 400
    # path_to_delete = request.form.get('path_to_delete')
    # if os.path.exists('api/' + path_to_delete):
    #     return 'exist', 200
    # else:
    #     return 'not found', 404

@app.route('/change/file/name', methods=['POST'])
def changeFileName():
    fileID = request.form.get('fileID')
    fileName = request.form.get('FileName')
    print(fileID)
    print(fileName)
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('UPDATE legacy SET name = %s WHERE id = %s', (fileName, fileID))
        conn.commit()
    except Exception as e:
        print(e)
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
    print('###########################################')
    print('formData: ', request.form.keys())
    path_to_save = request.form.get('path_to_save')
    parent_id = request.form.get('parent_id')
    

    for key in data.keys():
        file_storage = data.get(key)
        #filename = file_storage.filename
        content_type = file_storage.content_type
        print('File object', data)
        print('path to save: ', path_to_save)
        print('parent_id: ', parent_id)
        path_to_save = path_to_save
        content_type = content_type.split("/")[1]
        try:
            #data[key].save(f'./{path_to_save}/' + filename)
            file_storage.filename = key
            file_storage.save(f'./{path_to_save}/' + key + '.' + content_type) 
            db = get_db_connection()
            cur = db.cursor()
            cur.execute('ALTER SEQUENCE legacy_id_seq RESTART WITH 100;')
            cur.execute("INSERT INTO legacy (name, path, parent_id, is_file) VALUES (%s, %s, %s, %s);", (key, path_to_save + "/" + file_storage.filename + '.' + content_type, parent_id, 1))
            print(cur.rowcount)
            db.commit()
            cur.close()
            db.close()
        except Exception as e:
            print(e)
            return 'File uploading failed', 400
        print(f"File {file_storage.filename} with content type {content_type} uploaded with key '{key}'")
    print('###########################################')
    return 'File uploaded successfully'
# @app.route('/justPost', methods = ['POST'])
# def justPost():
#     return 'success'
@app.route('/classification/', methods=['POST'])
def get_classification():
    conn = get_db_connection()
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
    cur = get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)
    data = request.json['_rawValue']['global']
    print(data)
    cur.execute("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name LIKE %s;", ('%' + data + '%',))
    results = cur.fetchall()
    print(results)
    legacies = jsonify(results)
    return legacies, 200

@app.route('/search/book/file/', methods=['POST'])
def searchFile():
    cur = get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)
    data = request.json['global']
    print(data)
    cur.execute("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name ILIKE %s;", ('%' + data + '%',))
    results = cur.fetchall()
    print(results)
    legacies = jsonify(results)
    return legacies, 200


def looking_for_synonym(cur, word, family):
    cur.execute(
    "SELECT s.synonym, z.words "
    "FROM synonyms s "
    "INNER JOIN synonym_word sw ON s.id = sw.synonym_id "
    "INNER JOIN synamizer z ON z.id = sw.word_id "
    "WHERE LOWER(TRIM(z.words)) = LOWER(%s) AND LOWER(TRIM(z.words_family)) = LOWER(%s)"
    "AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id);",
    (word,family)
    )
    synonyms = cur.fetchall()
    print('synonym that was found: ',synonyms)
    return synonyms

@app.route('/word/synomize/', methods=['POST'])
def synomizing():
    cur = get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    data = request.json['value']
    print("$$$$$$$$$$$$$")
    # cur.execute("SELECT DISTINCT CASE WHEN LOWER(TRIM(s.synonym)) LIKE LOWER(%s) THEN s.synonym ELSE z.words END as word, z.meaning, z.words_family,z.id, z.words FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(TRIM(z.words)) LIKE LOWER(%s) OR LOWER(TRIM(s.synonym)) = LOWER(%s);", ('%' + data + '%','%' + data + '%', '%' + data + '%'))
    # cur.execute("SELECT DISTINCT LOWER(TRIM(z.words)) AS word ,s.synonym, z.meaning,z.words_family,z.id FROM synamizer z INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synonyms s ON  z WHERE LOWER(TRIM(z.words)) LIKE LOWER(%s)", (data + "%",))
    cur.execute('SELECT DISTINCT id, words_family, status, meaning, words FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s));', (data,))
    found_data = cur.fetchall()
    # print(found_data)
    cur.execute("SELECT DISTINCT words FROM synamizer WHERE LOWER(TRIM(words)) LIKE LOWER(TRIM(%s)) LIMIT 3;", (data + "%", ) )
    all_words = cur.fetchall()
    print(all_words)
    if (len(all_words) == 1) and (all_words[0].get('words') == data):
        all_words = []
    try:
        word = found_data[0].get('words')
    except Exception as e:
        print(found_data)
        print(e)
        return 'not found', 404
    # print(syn)
    synonyms = looking_for_synonym(cur, word, found_data[0].get('words_family'))
    # temp_synonyms = looking_for_synonym(cur, word)
    # synonyms.extend(temp_synonyms)
    # for i in range(0, len(synonyms)):
    #     temp_synonyms = looking_for_synonym(cur, synonyms[i].get('synonym'))
    #     synonyms.extend(temp_synonyms)
    #print('synonym that was found: ',synonyms[0].get('synonym'))
    cur.execute("SELECT s.paraphrase FROM paraphrases s INNER JOIN paraphrase_word sw ON s.id = sw.paraphrase_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(TRIM(z.words)) = LOWER(%s);", (word,))
    paraphrase = cur.fetchall()
    # print('all_words: ', all_words)

    return jsonify([found_data[0], synonyms, paraphrase, all_words]), 200

def switch_case(argument):
    if argument == 'зат есім':
        return 1
    elif argument == 'етістік':
        return 5
    elif argument == 'сын есім':
        return 2
    elif argument == 'сан есім':
        return 3
    elif argument == 'есімдік':
        return 4
    elif argument == 'еліктеуіш':
        return 6
    elif argument == 'одағай':
        return 7
    elif argument == 'шылау':
        return 8
    elif argument == 'үстеу':
        return 9


@app.route('/add/synonym/', methods=['POST'])
def addSynonym():
    synonyms = request.json['synonyms']
    meaning = request.json['meaning']
    word = request.json['word']
    family = request.json['family']['name']
    pos = switch_case(family)
    db = get_db_connection()
    cur = db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    try:
        # cur.execute("""SELECT setval('synamizer_id_seq', 1172, true)""")
        cur.execute("""INSERT INTO synamizer (words, words_family, meaning, pos, status)
        VALUES (%s, %s, %s, %s, 'омоним') RETURNING id""", (word, family, meaning, pos))
        row = cur.fetchone()
        print("ROW: ", row)
    except Exception as e:
        return e, 400
    word_id = row['id']
    for i in synonyms:
        try:
            cur.execute("INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id", (i, ))
            syn_id = cur.fetchone()['id']
            print("syn_id: ", syn_id)
            cur.execute("INSERT INTO synonym_word (word_id, synonym_id) VALUES(%s, %s)", (word_id, syn_id))
        except Exception as e:
            return e, 400
    db.commit()
    return 'success', 200


# SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file
# FROM tag t
# JOIN tag_legacy tl ON t.id = tl.tag_id
# JOIN legacy l ON l.id = tl.legacy_id
# WHERE t.name = 'Magzhan';
def findsyn(word, synomized_count, synomized_words):
    print('word that gives ', word)
    cur = get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute("SELECT s.synonym FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(REPLACE(z.words, ' ', '')) = LOWER(%s);", (word,))#LOWER(z.words)
    #print("#################################################")
    synonym = cur.fetchone()
    if synonym == None:
        return [word, synomized_count]
    print(synonym)
    #print("#################################################")
    synomized_count += 1
    synomized_words.append(synonym.get('synonym'))
    return [synonym.get('synonym'), synomized_count]


def split_string(first_string, second_string):
    index = second_string.find(first_string)
    if index != -1:
        first_part = second_string[:index]
        second_part = second_string[index + len(first_string):]
        return first_part, second_part
    else:
        # print("#######################")
        # print(first_string)
        # print(second_string)
        return "", ""
    

@app.route('/search/word/', methods=['POST'])
def searchWord():
    synomized_count = 0
    data = request.json['value']
    synpmized_words = []
    sentences = st(data) # тексттен сөйлемдерді бөліп аламыз
    stcs = Lemms.get_kaz_lemms(Lemms,sentences)
    print("$$$$$$$$$$$$$$$$$$")
    print('stcs are: ', stcs)
    print("$$$$$$$$$$$$$$$$$$")
    words = re.findall(r"[\w']+|[.,!?; ]", data)
    print(words)
    output_words = []
    for word in words:
        if word not in [",", ".", "!", "?", ";"]:
            translated_word, synomized_count = findsyn(word, synomized_count, synpmized_words)
            sentences = st(translated_word) # тексттен сөйлемдерді бөліп аламыз
            # if not word == translated_word:
            #     translated_word = word + "(синонимі: " + translated_word + ")"
            stcs = Lemms.get_kaz_lemms(Lemms,sentences)
            #print('stcs are: ', stcs)
            # if isinstance(stcs[0][0][1], str) or not stcs == []:
            if (not (len(stcs) == 0)) and (len(stcs[0][0]) > 2) and not(" " in translated_word.strip()):
                length = len(stcs[0]) - 1
                if len(stcs[0][0][2]) == 0:
                    _, second_part = split_string(translated_word, stcs[0][length][3])
                    translated_word, synomized_count = findsyn(stcs[0][length][3], synomized_count, synpmized_words)
                    translated_word =   translated_word +second_part 
                else:
                    _, second_part = split_string(stcs[0][length][3], translated_word)
                    translated_word, synomized_count = findsyn(stcs[0][length][3], synomized_count, synpmized_words)
                    translated_word =  translated_word +second_part
                    # for i in range(0, length+1):
                    #     translated_word = translated_word + "(" + stcs[0][i][2][0][0] + " - " + stcs[0][i][2][0][2] + ")"
            if word != translated_word:
                translated_word = '<span style="color: green;">' + translated_word + "</span>"
            output_words.append(translated_word) 
        else:
            output_words.append(word)
    #print('output_words: ', output_words)
    output_string = "".join(output_words)
    #print(output_string)
    return jsonify([output_string, synomized_count, synpmized_words]), 200
if __name__ == "__main__":
    # main()
    from models import MyOwlReady
    s = MyOwlReady()
    config.init_conf()
    app.run(port=5001, debug=True)    


