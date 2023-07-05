from app import app
from morphology_api.morphology import Lemms
from flask import request, jsonify 
import re
from nltk.tokenize import sent_tokenize as st
from db import DB
import psycopg2

def split_string(first_string, second_string):
    index = second_string.find(first_string)
    if index != -1:
        first_part = second_string[:index]
        second_part = second_string[index + len(first_string):]
        return first_part, second_part
    else:
        return "", ""
    
def getHtml(first_part, second_part, data_id, translated_word):
    # return '<span class="temp_testing_div2" type="button" style="color: green;"' + 'href="' +first_part+  '"' + 'second_part="' + second_part + '"' + 'id="' + "span-"+str(data_id) + '"' + '>' + translated_word +'</span>'
    return  f'<span class="temp_testing_div2" type="button" style="color: green;" href="{first_part}"  second_part="{second_part}" id="span-{str(data_id)}"> {translated_word}</span>'

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
            isWordUpper = word[0].isupper()
            translated_word, synomized_count = DB.findsyn(word.lower(), synomized_count, synomized_words)
            translated_word = translated_word.lower()
            first_part = word.lower()
            sentences = st(translated_word) # тексттен сөйлемдерді бөліп аламыз
            stcs = Lemms.get_kaz_lemms(Lemms,sentences)
            if (not (len(stcs) == 0)) and (len(stcs[0][0]) > 2) and not(" " in translated_word.strip()):
                length = len(stcs[0]) - 1
                if len(stcs[0][0][2]) == 0:
                    _, second_part = split_string(translated_word, stcs[0][length][3])
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.findsyn(stcs[0][length][3], synomized_count, synomized_words)
                    translated_word = translated_word +second_part 
                else:
                    _, second_part = split_string(stcs[0][length][3].lower(), translated_word)
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.findsyn(stcs[0][length][3], synomized_count, synomized_words)
                    translated_word =  translated_word +second_part
            if isWordUpper:
                translated_word = translated_word.capitalize()
            if word != translated_word:
                translated_word = getHtml(first_part, second_part, data_id, translated_word)
                data_id += 1
            output_words.append(translated_word) 
        else:
            output_words.append(word)
    return jsonify([output_words, synomized_count, synomized_words]), 200

@app.route('/search/synonyms/only', methods=['POST'])
def searchsyn():
    data = request.json['value']
    second_part = request.json['second_part']
    cur = DB.get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    synonyms = DB.looking_for_synonym(cur, data, '')
    for i in range(0, len(synonyms)):
         synonyms[i]['synonym'] = synonyms[i]['synonym'] + second_part
    return synonyms

@app.route('/add/tag', methods=['POST'])
def addTag():
    definition_id = request.json['definition_id']
    file_id = request.json['file_id']
    DB.addTag(definition_id, file_id)
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
    paraphrase = cur.fetchall()
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
    try:
        row = DB.addWord(word, family, meaning, pos)
    except Exception as e:
        return e, 400
    word_id = row['id']
    if len(synonyms) > 0:
        for i in synonyms:
            try:
                DB.add_Synonyms( i, word_id)
            except Exception as e:
                return e, 400
    if len(paraphrases) > 0:
        for i in paraphrases:
            try:
                DB.add_Paraphrases( paraphrase=i, word_id=word_id)
            except Exception as e:
                return e, 400
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
    con = DB.get_db_connection()
    cur = con.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    paraphrases = request.json['paraphrases']
    word = request.json['word']
    family = request.json['family']['family']
    cur.execute('SELECT id FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));', (word, family))
    word_id = cur.fetchone()['id']
    for i in paraphrases:
        DB.add_Paraphrases(cur, i, word_id)
    con.commit()
    cur.close()
    con.close()
    return 'success', 200
