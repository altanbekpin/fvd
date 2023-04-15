# -*- coding: utf-8 -*-
import pymysql
from app import app
# from config import mysql
from flask import jsonify
from flask import request
import json
# @app.route('/getlegacies/', defaults={'parent_id': None}, methods=['GET'])
# @app.route('/getlegacies/<int:parent_id>', methods=['GET'])
# def get_legacy_records(parent_id):
#     try:
#         cur = mysql.get_db().cursor(pymysql.cursors.DictCursor)
#         if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
#             cur.execute("SELECT id as `key`, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN  is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL")
#         else:  # В противном случае выбираем записи с указанным parent_id
#             cur.execute("SELECT  id as `key`, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN  is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s", [parent_id])

#         results = cur.fetchall()
#         legacies = jsonify(results)
#         return legacies

#     except Exception as e:
#         return jsonify(str(e)), 500

# @app.route('/legacy/download/<int:file_id>', methods=['GET'])
# def download_file(file_id):
#     cur = mysql.get_db().cursor()
#     cur.execute("SELECT path from legacy WHERE id = %s",[file_id])
#     results = cur.fetchall()
#     for row in results:
#         path = row[0]
#     print(path)
#     return send_file(path, as_attachment=True)
# @app.after_request
# def after_request(response):
#   response.headers.add('Access-Control-Allow-Origin', '*')


@app.route('/getontology/<lang>/', methods=['GET'])
def getontology(lang):
    s = MyOwlReady()
    owls = s.GetJson(lang=lang)
    return jsonify(owls)

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
    print(request.data.decode('utf-8'))
    temp = json.loads(request.data.decode('utf-8'))
    
    question = temp['question']
    print('#####################')
    print(question)
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
    # descriptor = re.search('<b>Дескриптор: </b>(.*?)<br/>', s).group(1)
    # uniturk = re.search('<b>UniTurk: </b>(.*?)<br/>', s).group(1)
    # hyperonym = re.findall('<a href="javascript:DoSubmit\(\'(.*?)\',\'kz\'\);">.*?</a>', s)
    # print(hyperonym)
    # try:
    #     individ = re.search('<b>Индивид: </b><p.*?>(.*?)</p>', s).group(1)
    # except:
    #     individ = ''
    # if len(hyperonym) >= 2:
    #     result = [descriptor, uniturk, hyperonym[0], hyperonym[1:], individ]
    # else:
    #     result = [descriptor, uniturk, hyperonym[0], hyperonym[:1], individ]
    # print(result)
    return jsonify(s)

if __name__ == "__main__":
    from models import MyOwlReady
    s = MyOwlReady() ## class initialized, but object not created
    #print("Object created", MyOwlReady.getInstance()) # Object gets created here
    app.config['JSON_AS_ASCII'] = False
    app.run(port=5001, debug=True)    