from ast import literal_eval
from app import app
from morphology_api.morphology import Lemms
from flask import request, jsonify 
import re
from nltk.tokenize import sent_tokenize as st
from db import DB
from flask_jwt_extended import current_user, jwt_required
from word import Word
def split_string(first_string, second_string):
    index = second_string.find(first_string)
    if index != -1:
        first_part = second_string[:index]
        second_part = second_string[index + len(first_string):]
        return first_part, second_part
    else:
        return "", ""
    
def getTense(family):
    if family == "N":
        return "Зат есім"
    elif family == "Adj":
        return "Сын есім"
    elif family == 'NUM':
        return "Сан есім"
    elif family == 'Prnn':
        return "Есімдік"
    elif family == 'V':
        return "Етістік"
    elif family == "Onmt":
        return "Еліктеуіш"
    elif family == 'INTERJ':
        return "Одағай"
    elif family == 'FW':
        return "Шылау"
    elif family == 'ADV':
        return "Үстеу"
    
def get_pos_names( pos):
    if pos == "N":
        return 1
    elif pos == "Adj":
        return 2
    elif pos == "NUM":
        return 3
    elif pos == "Prnn":
        return 4
    elif pos == "V":
        return 5
    elif pos == "Onmt":
        return 6
    elif pos == "INTERJ":
        return 7
    elif pos == "FW":
        return 8
    elif pos == "ADV":
        return 9
def getHtml(first_part, second_part, data_id, translated_word, family):
    return  f'<span class="temp_testing_div2" type="button" style="color: green;" href="{first_part}"  second_part="{second_part}" family="{family}" id="span-{str(data_id)}"> {translated_word}</span>'

def is_person_name(word, sentence):
    reversed_sentence = sentence[::-1]
    index = reversed_sentence.find(word[::-1])
    if index != -1:
        for char in reversed_sentence[index:]:
            if char == '.':
                return False
            elif char == ' ':
                continue
            else:
                break
    return word[0].isupper()

@app.route('/search/word/', methods=['POST'])
def searchWord():
    synomized_count = 0
    data = request.json['value']
    synomized_words = []
    words = re.findall(r"[\w']+|[.,!?; ]", data)
    output_words = []
    data_id = 0
    for word in words:
        if word not in [",", ".", "!", "?", ";", "-"] and word.strip() and not is_person_name(word, data):
            isWordUpper = word[0].isupper()
            word_instance = Word(word.lower(), synomized_count, synomized_words)
            word_instance.look_for_synonym()
            if isWordUpper and word_instance.has_synonym():
                word_instance.capitalize_synonym()
            if word_instance.has_synonym():
                print("*********************************")
                print(f"{word_instance.get_first_synonym()} {word_instance.get_synonym()}")
                print("*********************************")
                word_instance.set_synonym(word_instance.get_synonym() + word_instance.get_trash_part())
                translated_word = getHtml(word_instance.get_first_part(), word_instance.find_extra_chars(word_instance.get_first_part(), word), data_id, f"{word_instance.get_first_synonym()} {word_instance.get_synonym()}", word_instance.get_family())
                data_id += 1
            else:
                translated_word = word
            synomized_count = word_instance.synomized_count
            output_words.append(translated_word) 
        else:
            output_words.append(word)
    return jsonify([output_words, synomized_count, synomized_words]), 200

@app.route('/search/synonyms/only', methods=['POST'])
def searchsyn():
    print("request.json:", request.json)
    data = request.json['value']
    second_part = request.json['second_part']
    family = request.json['family']
    secondary = request.json['secondary']
    print("secondary:", secondary)
    synonyms = []
    synonyms = DB.get_instance().findsyn_with_family(data, getTense(family))
    print("synonyms:", synonyms)
    if len(synonyms) == 0:
        synonyms = DB.get_instance().findsyn_with_family(secondary, '')
        print("synonyms2:", synonyms)
    for i in range(0, len(synonyms)):
         synonyms[i]['synonym'] = synonyms[i]['synonym']
    synonyms.insert(0, {"words":data, "synonym": data+second_part})
    print(synonyms)
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
    data = request.json['value']
    family = request.json['words_family']
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
    if found_data[0].get('temp_word') is not None:
        temp = found_data[0]['words']
        found_data[0]['words'] = found_data[0].get('temp_word')
        for key, val in enumerate(synonyms):
            print("val['synonym']:", val['synonym'])
            if val['synonym'] == found_data[0].get('temp_word'):
                synonyms[key]['synonym'] = temp
                print(synonyms[key])
    return jsonify([found_data[0], synonyms, paraphrase, all_words, all_families])

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
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    print("add word")
    print("user:", current_user.id)
    synonyms = request.json['synonyms']
    print("synonyms:", synonyms)
    example = request.json['example']
    paraphrases = request.json['paraphrases']
    print("paraphrases:", paraphrases)
    meaning = request.json['meaning']
    word = request.json['word']
    family = request.json['family']['name']
    pos = switch_case(family)
    try:
        row_id = DB.get_instance().addWord(word, family, meaning, pos, example, current_user.id)
    except Exception as e:
        return str(e), 400
    word_id = row_id
    if len(synonyms) > 0:
        for i in synonyms:
            try:
                DB.get_instance().add_Synonyms( synonym=i, word_id=word_id,user_id=current_user.id)
            except Exception as e:
                return str(e), 400
    if len(paraphrases) > 0:
        for i in paraphrases:
            try:
                DB.get_instance().add_Paraphrases( paraphrase=i, word_id=word_id, user_id=current_user.id)
            except Exception as e:
                return str(e), 400
    return 'success', 200

@app.route('/add/synonym/', methods=['POST'])
@jwt_required()
def addSynonym():
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    synonyms = request.json['synonyms']
    word = request.json['word']
    family = request.json['family']['family']
    word_id = DB.get_instance().findword(word, family)[0].get('id')
    for i in synonyms:
        DB.get_instance().add_Synonyms(i, word_id, current_user.id)
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
        DB.get_instance().add_Paraphrases(i, word_id, current_user.id)
    return 'success', 200

@app.route("/research/",methods=['POST'])
def research():
    data = request.json['value']
    word = request.json['word']
    instance = Word(data, 0, [])
    print("instance.get_researhed_part(word):", instance.get_researhed_part(word))
    return instance.get_researhed_part(word)

@app.route("/delete/synonym", methods=['DELETE'])
@jwt_required()
def delete_syn():
    synonym_id = request.args.get('synonym_id')
    print("synonym_id:", synonym_id)
    synonym_id = literal_eval(synonym_id)
    print("synonym_id:", synonym_id)
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    DB.get_instance().delete_syn(synonym_id)
    return "success", 200

@app.route("/delete/paraphrase", methods=['DELETE'])
@jwt_required()
def delete_par():
    paraphrase_id = request.args.get('paraphrase_id')
    print("paraphrase_id:", paraphrase_id)
    paraphrase_id = literal_eval(paraphrase_id)
    print("paraphrase_id:", paraphrase_id)
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    DB.get_instance().delete_par(paraphrase_id)
    return "success", 200

@app.route("/delete/family", methods=['DELETE'])
@jwt_required()
def delete_family():
    word_id = request.args.get('word_id')
    print("word_id:", word_id)
    word_id = literal_eval(word_id)
    print("word_id:", word_id)
    if not DB.get_instance().isUserAdmin(current_user):
        return "don't have enough permission", 500
    DB.get_instance().delete_family(word_id)
    return "success", 200