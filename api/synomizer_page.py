from app import app
from morphology_api.morphology import Lemms
from flask import request, jsonify 
import re
from nltk.tokenize import sent_tokenize as st
from db import DB
from flask_jwt_extended import current_user, jwt_required
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
            first_part = word.lower()
            translated_word, synomized_count = DB.get_instance().findsyn(first_part, synomized_count, synomized_words)
            translated_word = translated_word.lower()
            
            sentences = st(translated_word) # тексттен сөйлемдерді бөліп аламыз
            stcs = Lemms.get_kaz_lemms(Lemms,sentences)
            if (not (len(stcs) == 0)) and (len(stcs[0][0]) > 2) and not(" " in translated_word.strip()):
                length = len(stcs[0]) - 1
                if len(stcs[0][0][2]) == 0:
                    _, second_part = split_string(translated_word, stcs[0][length][3])
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.get_instance().findsyn(stcs[0][length][3], synomized_count, synomized_words)
                    translated_word = translated_word +second_part 
                else:
                    _, second_part = split_string(stcs[0][length][3].lower(), translated_word)
                    first_part = stcs[0][length][3]
                    translated_word, synomized_count = DB.get_instance().findsyn(stcs[0][length][3], synomized_count, synomized_words)
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
    synonyms = DB.get_instance().findsyn_with_family(data, '')
    for i in range(0, len(synonyms)):
         synonyms[i]['synonym'] = synonyms[i]['synonym'] + second_part
    return synonyms

@app.route('/add/tag', methods=['POST'])
@jwt_required()
def addTag():
    if not DB.isUserAdmin(current_user):
        return "don't have enough permission", 500
    definition_id = request.json['definition_id']
    file_id = request.json['file_id']
    DB.get_instance().addTag(definition_id, file_id)
    return 'success', 200

@app.route('/word/synomize/', methods=['POST'])
def synomizing():
    print('JSON:', jsonify(request.json))
    data = request.json['value']
    family = request.json['words_family']
    print("data:", data)
    print("family:", family)
    temp_families = []
    if family == "":
        found_data = DB.get_instance().findword(data)
    else:
        temp_families = DB.get_instance().findword(data)
        found_data = DB.get_instance().findword(data, family)
    all_families = []
    if len(temp_families) < len(found_data):
        for i in found_data:
            all_families.append({"family" : i.get("words_family")})
    else:
        for i in temp_families:
            all_families.append({"family" : i.get("words_family")})
    all_words = DB.get_instance().find_similarword(data)
    if (len(all_words) == 1) and (all_words[0].get('words') == data):
        all_words = []
    try:
        word = found_data[0].get('words')
    except Exception as e:
        return 'bad request', 400
    if family == '':
        synonyms = DB.get_instance().findsyn_with_family(word, found_data[0].get('words_family'))
    else:
        found_data[0]['words_family'] = family
        synonyms = DB.get_instance().findsyn_with_family(word, family)
    paraphrase = DB.get_instance().find_paraphrase_by_word(word)
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
@jwt_required()
def addWord():
    print("addWord")
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    synonyms = request.json['synonyms']
    paraphrases = request.json['paraphrases']
    meaning = request.json['meaning']
    word = request.json['word']
    family = request.json['family']['name']
    pos = switch_case(family)
    try:
        row = DB.get_instance().addWord(word, family, meaning, pos)
    except Exception as e:
        print("ERROR 154 line:", e)
        return str(e), 400
    print("WORD ADDED")
    print("row['id']:", row['id'])
    word_id = row['id']
    if len(synonyms) > 0:
        for i in synonyms:
            print("SYNONYM:", i)
            try:
                DB.get_instance().add_Synonyms( i, word_id)
            except Exception as e:
                print(e)
                return str(e), 400
    if len(paraphrases) > 0:
        for i in paraphrases:
            print("paraphrases:".upper(), i)
            try:
                DB.get_instance().add_Paraphrases( paraphrase=i, word_id=word_id)
            except Exception as e:
                print(e)
                return str(e), 400
    print('success')
    return 'success', 200

@app.route('/add/synonym/', methods=['POST'])
@jwt_required()
def addSynonym():
    print("addSynonym")
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    synonyms = request.json['synonyms']
    word = request.json['word']
    family = request.json['family']['family']
    word_id = DB.get_instance().findword(word, family)[0].get('id')
    print("word_id:", word_id)
    for i in synonyms:
        DB.get_instance().add_Synonyms(i, word_id)
    return 'success', 200

@app.route('/add/paraphrase/', methods=['POST'])
@jwt_required()
def addParaphrase():
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    paraphrases = request.json['paraphrases']
    word = request.json['word']
    family = request.json['family']['family']
    word_id = DB.get_instance().findword(word, family)[0].get('id')
    for i in paraphrases:
        DB.get_instance().add_Paraphrases(i, word_id)
    return 'success', 200

