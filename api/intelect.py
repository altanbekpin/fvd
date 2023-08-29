from app import app
from flask import jsonify, request
import json
from db import DB
from word import Word

@app.route('/getontology/ask/test', methods=['POST'])
def send_question_test():
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
    tempq = question
    ending = question.split(' ')[-1].lower()
    instatnce = Word(ending, 0, [])
    # instatnce.look_for_synonym()
    ending = instatnce.get_first_part()
    print("ending:", ending)
    if ending in ['дескриптор', 'гипоним', 'uniturk', 'гипероним', 'индивид']:
        question = " ".join(question.split(' ')[:-1]).capitalize()
    lang = 'kz'
    g = DB.get_instance().get_onto().TurkOnto
    s= ''
    data = {}
    
    quest = '''
        PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>
        SELECT ?subject ?label WHERE {{ ?subject rdfs:label "''' + question + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))} union { ?subject rdfs:label "''' + question.capitalize() + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))}}'
    qres = g.query(quest)
    for row in qres:
        words = row[0].split('#')
        data['дескриптор'] = row[1]
        s = '<b>' + descriptor_to_lang[lang]+': </b>' + row[1]
        word = words[len(words)-1]
        s = s + "<br/><b>UniTurk: </b>" + word
        data['uniturk'] = word
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
        data['гипероним'] = def_row[0]
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select ?label WHERE {?s rdfs:subClassOf kazont:' + word+ '''  . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyponim[lang]+': </b>'
        for def_row in defres:
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] +  "</a>"
            data['гипоним'] = def_row[0]
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> SELECT ?subject ?label WHERE { ?subject rdf:type kazont:'+word+' . ?subject rdfs:label ?label FILTER(LANG(?label) = "' + lang + '" )}'
        defres = g.query(quest)
        s = s + "<br/><b>Индивид: </b>"
        instance_count = 0
        for def_row in defres:
            instance_count = instance_count + 1
            s = s + '<p style="color:red; margin-bottom:0">&emsp;' + def_row[1] +'</p>'
            data['индивид'] = def_row[1]
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
    try:
        print("#####################")
        print("result:", data)
        print("#####################")
        result = data[ending]
    except:
        result = tempq + ' ' + 'табылмады'
        if len(data)>0:
            result = ''
            for key, val in data.items():
                result += f'{key}: {val}\n' 
    return jsonify(result)

@app.route('/getontology/ask/test2', methods=['POST'])
def send_question2():
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
    parents = []
    children = []
    lang = 'kz'
    g = DB.get_instance().get_onto().TurkOnto
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
            parents.append(def_row[0])


        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select ?label WHERE {?s rdfs:subClassOf kazont:' + word+ '''  . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyponim[lang]+': </b>'
        for def_row in defres:
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] +  "</a>"
            children.append(def_row[0])
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
    print("parents:", parents)
    print("children:", children)
    return jsonify({"parent":parents, "items":children})
