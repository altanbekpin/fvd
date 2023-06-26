# -*- coding: utf-8 -*-
from flask.cli import load_dotenv
from app import app
# from config import mysql
from flask import jsonify 
from flask import request,send_file
import json
import config
import psycopg2
from flask_jwt_extended import create_access_token, JWTManager, current_user, jwt_required
import psycopg2.extras
from flask_cors import CORS
import os
import re
from morphology_api.morphology import Lemms
import os
from db import *
from nltk.tokenize import sent_tokenize as st
print("######################################################################################################################################################")
# app = Flask(__name__)
# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:magzhan2005@localhost/userdb'

jwt = JWTManager(app)
@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id

@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    return User.query.filter_by(id=identity).one_or_none()

@app.route("/", methods=["GET"])
def initialRoute():
    return "success", 200

@app.route('/getontology/<lang>/', methods=['GET'])
def getontology(lang):
    from models import MyOwlReady
    print("/getontology/<lang>/")
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
    return jsonify(
        roles = roles,
        id=current_user.id,
        email=current_user.email,
    )


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

@app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
@app.route('/getlegacies/<int:parent_id>', methods=['GET'])
def get_legacy_records(parent_id):
    try:
        cur = DB.get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)#mysql.get_db().cursor(pymysql.cursors.DictCursor)#cur = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
            cur.execute("SELECT id AS key, name AS label, path AS data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL;")
        else:  # В противном случае выбираем записи с указанным parent_id
            cur.execute("SELECT id as key, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s", [parent_id])


        results = cur.fetchall()
        legacies = jsonify(results)
        return legacies

    except Exception as e:
        return jsonify(str(e)), 500

@app.route('/legacy/download/<int:file_id>', methods=['GET'])
def download_file(file_id):
    cur = DB.get_db_connection().cursor()
    cur.execute("SELECT path from legacy WHERE id = %s",[file_id])
    results = cur.fetchall()
    for row in results:
        path = row[0]
    return send_file(path, as_attachment=True)

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
# @app.route('/justPost', methods = ['POST'])
# def justPost():
#     return 'success'
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

def split_string(first_string, second_string):
    index = second_string.find(first_string)
    if index != -1:
        first_part = second_string[:index]
        second_part = second_string[index + len(first_string):]
        return first_part, second_part
    else:
        # "#######################")
        # first_string)
        # second_string)
        return "", ""
    

@app.route('/search/synonyms/only', methods=['POST'])
def searchsyn():
    cur = DB.get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    data = request.json['value']
    second_part = request.json['second_part']
    synonyms = DB.looking_for_synonym(cur, data, '')
    for i in range(0, len(synonyms)):
         synonyms[i]['synonym'] = synonyms[i]['synonym'] + second_part
    return synonyms

@app.route('/add/tag', methods=['POST'])
def addTag():
    definition_id = request.json['definition_id']
    file_id = request.json['file_id']
    connection = DB.get_db_connection()
    cursor = connection.cursor()
    cursor.execute("INSERT INTO tag_legacy (tag_id, legacy_id) VALUES (%s, %s);", (definition_id, file_id))
    connection.commit()
    cursor.close()
    connection.close()
    return 'success', 200

@app.route('/word/synomize/', methods=['POST'])
def synomizing():
    cur = DB.get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    data = request.json['value']
    family = request.json['words_family']
    temp_families = []
    # family)
    
    # cur.execute("SELECT DISTINCT CASE WHEN LOWER(TRIM(s.synonym)) LIKE LOWER(%s) THEN s.synonym ELSE z.words END as word, z.meaning, z.words_family,z.id, z.words FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(TRIM(z.words)) LIKE LOWER(%s) OR LOWER(TRIM(s.synonym)) = LOWER(%s);", ('%' + data + '%','%' + data + '%', '%' + data + '%'))
    # cur.execute("SELECT DISTINCT LOWER(TRIM(z.words)) AS word ,s.synonym, z.meaning,z.words_family,z.id FROM synamizer z INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synonyms s ON  z WHERE LOWER(TRIM(z.words)) LIKE LOWER(%s)", (data + "%",))
    if family == "":
        cur.execute('SELECT DISTINCT id, words_family, status, meaning, words FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s));', (data,))
    else:
        cur.execute('SELECT DISTINCT words_family FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s));', (data,))
        temp_families = cur.fetchall()
        cur.execute('SELECT DISTINCT id, status,words_family, meaning, words FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));', (data,family))
    found_data = cur.fetchall()
    # found_data)
    all_families = []
    if len(temp_families) < len(found_data):
        for i in found_data:
            all_families.append({"family" : i.get("words_family")})
    else:
        for i in temp_families:
            all_families.append({"family" : i.get("words_family")})
    cur.execute("SELECT DISTINCT words FROM synamizer WHERE LOWER(TRIM(words)) LIKE LOWER(TRIM(%s)) LIMIT 3;", (data + "%", ) )
    all_words = cur.fetchall()
    #all_words)
    if (len(all_words) == 1) and (all_words[0].get('words') == data):
        all_words = []
    try:
        word = found_data[0].get('words')
    except Exception as e:
        return 'bad request', 400
    if family == '':
        synonyms = DB.looking_for_synonym(cur, word, found_data[0].get('words_family'))
    else:
        found_data[0]['words_family'] = family
        synonyms = DB.looking_for_synonym(cur, word, family)
    cur.execute("SELECT s.paraphrase FROM paraphrases s INNER JOIN paraphrase_word sw ON s.id = sw.paraphrase_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(TRIM(z.words)) = LOWER(%s);", (word,))
    paraphrase = cur.fetchall()
    paraphrase = cur.fetchall()
    # print('all_words: ', all_words)
    # print(found_data[0]['words_family'] )
    
    paraphrase = cur.fetchall()    
    # print('all_words: ', all_words)
    # print(found_data[0]['words_family'] )
    
    return jsonify([found_data[0], synonyms, paraphrase, all_words, all_families]), 200

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
    

@app.route('/add/word/', methods=['POST'])
def addWord():
    synonyms = request.json['synonyms']
    paraphrases = request.json['paraphrases']
    meaning = request.json['meaning']
    word = request.json['word']
    family = request.json['family']['name']
    pos = switch_case(family)
    db = DB.get_db_connection()
    cur = db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    try:
        # cur.execute("""SELECT setval('synamizer_id_seq', 1172, true)""")
        cur.execute("""INSERT INTO synamizer (words, words_family, meaning, pos, status)
        VALUES (%s, %s, %s, %s, 'омоним') RETURNING id""", (word, family, meaning, pos))
        row = cur.fetchone()
    except Exception as e:
        return e, 400
    word_id = row['id']
    if len(synonyms) > 0:
        for i in synonyms:
            try:
                DB.add_Synonyms(cur, i, word_id)
            except Exception as e:
                return e, 400
    if len(paraphrases) > 0:
        for i in paraphrases:
            try:
                DB.add_Paraphrases(cur=cur, paraphrase=i, word_id=word_id)
            except Exception as e:
                return e, 400
    db.commit()
    return 'success', 200

@app.route('/add/synonym/', methods=['POST'])
def addSynonym():
    db = DB.get_db_connection()
    cur = db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    synonyms = request.json['synonyms']
    word = request.json['word']
    family = request.json['family']['family']
    cur.execute('SELECT id FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));', (word, family))
    word_id = cur.fetchone()['id']
    for i in synonyms:
        DB.add_Synonyms(cur, i, word_id)
    db.commit()
    return 'success', 200

@app.route('/add/paraphrase/', methods=['POST'])
def addParaphrase():
    db = DB.get_db_connection()
    cur = db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    paraphrases = request.json['paraphrases']
    word = request.json['word']
    family = request.json['family']['family']
    cur.execute('SELECT id FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));', (word, family))
    word_id = cur.fetchone()['id']
    for i in paraphrases:
        DB.add_Paraphrases(cur, i, word_id)
    db.commit()
    return 'success', 200


@app.route('/search/word/', methods=['POST'])
def searchWord():
    synomized_count = 0
    data = request.json['value']
    synomized_words = []
    sentences = st(data) # тексттен сөйлемдерді бөліп аламыз
    stcs = Lemms.get_kaz_lemms(Lemms,sentences)
    words = re.findall(r"[\w']+|[.,!?; ]", data)
    second_part = ''
    output_words = []
    data_id = 0
    for word in words:
        if word not in [",", ".", "!", "?", ";"]:
            translated_word, synomized_count = DB.findsyn(word, synomized_count, synomized_words)
            first_part = word
            sentences = st(translated_word) # тексттен сөйлемдерді бөліп аламыз
            stcs = Lemms.get_kaz_lemms(Lemms,sentences)
            if (not (len(stcs) == 0)) and (len(stcs[0][0]) > 2) and not(" " in translated_word.strip()):
                length = len(stcs[0]) - 1
                if len(stcs[0][0][2]) == 0:
                    _, second_part = split_string(translated_word, stcs[0][length][3])
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.findsyn(stcs[0][length][3], synomized_count, synomized_words)
                    translated_word =   translated_word +second_part 
                else:
                    _, second_part = split_string(stcs[0][length][3], translated_word)
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.findsyn(stcs[0][length][3], synomized_count, synomized_words)
                    translated_word =  translated_word +second_part
            if word != translated_word:
                translated_word = '<span class="temp_testing_div2" type="button" style="color: green;"' + 'href="' +first_part+  '"' + 'second_part="' + second_part + '"' + 'id="' + "span-"+str(data_id) + '"' + '>' + translated_word +'</span>'
                data_id += 1
            output_words.append(translated_word) 
        else:
            output_words.append(word)
    return jsonify([output_words, synomized_count, synomized_words]), 200
if __name__ == "__main__":
    from models import MyOwlReady
    load_dotenv()
    s = MyOwlReady()
    config.init_conf()
    app.run(port=os.environ.get("API_PORT"), debug=True, host=os.environ.get("API_URL"))    


