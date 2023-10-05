import string
from app import app
import random
from flask import jsonify, request
import concurrent.futures
import json
from db import DB
@app.route('/getontology/<lang>/', methods=['GET'])
def getontology(lang):
    owls = DB.get_instance().get_onto().GetJson(lang=lang)
    return jsonify(owls)

@app.route('/getontology/ask/', methods=['POST'])
def send_question():
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
    parent_key = temp['pkey']
    lang = 'kz'
  
    g = DB.get_instance().get_onto().TurkOnto(temp['id'])
    s= ''
    kazont = 'http://www.semanticweb.org/til_qural_baitursyn#'
    if temp['id']=='1':
        kazont = 'http://www.semanticweb.org/Til-qural_A.Baitursynuly#'
        if question == "Тіл-құрал":
            question = "Грамматика"
    quest = '''
        PREFIX kazont: <''' + kazont + '''>
        SELECT ?subject ?label WHERE {{ ?subject rdfs:label "''' + question + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))} union { ?subject rdfs:label "''' + question.capitalize() + '"@' + lang + ''' . ?subject rdfs:label  ?label
        FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '"))}}'
    qres = g.query(quest)
    childs = []
    for row in qres:
        words = row[0].split('#')
        s = '<b>' + descriptor_to_lang[lang]+': </b>' + row[1]
        word = words[len(words)-1]
        tag = "UniTurk"
        if temp['id']=='2':
            tag = "Тег"
        s = s + "<br/><b>" + tag + ": </b>" + word
        quest = 'PREFIX kazont: <'+ kazont +'> Select * WHERE { kazont:' + word+ ''' kazont:definition ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), " ''' + lang + '")) }'
        defres = g.query(quest)
        for def_row in defres:
            s = s + '<br/> <b>' + descriptor_to_def[lang]+': </b>' + def_row[0]
        quest = 'PREFIX kazont: <'+ kazont +'> Select * WHERE { kazont:' + word+ ''' kazont:question ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), "''' + lang + '")) }'
        defres = g.query(quest)
        for def_row in defres:
            s = s + '<br/> <b>' + descriptor_to_question[lang]+': </b>' + def_row[0]

        quest = 'PREFIX kazont: <'+ kazont +'> Select ?label WHERE {kazont:' + word+ ''' rdfs:subClassOf  ?s . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyperonim[lang]+': </b>'
        for def_row in defres:
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] + "</a>"

        quest = 'PREFIX kazont: <'+ kazont +'> Select ?label WHERE {?s rdfs:subClassOf kazont:' + word+ '''  . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        defres = g.query(quest)
        s = s + '<br/> <b>' + descriptor_to_gyponim[lang]+': </b>'
        childs = []
        key = 0
        for def_row in defres:
            childs.append({"key": str(parent_key) + "-" + str(key) , "label":  def_row[0].value, "leaf": False, "children": []})
            key+=1
            s = s + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + def_row[0] +"','"+ lang +"');\">" + def_row[0] +  "</a>"
        quest = 'PREFIX kazont: <'+ kazont +'> SELECT ?subject ?label WHERE { ?subject rdf:type kazont:'+word+' . ?subject rdfs:label ?label FILTER(LANG(?label) = "' + lang + '" )}'
        
        example = 'Индивид'
        example_index = 1
        if temp['id']=='2':
            quest = 'PREFIX kazont: <'+ kazont +'> Select * WHERE { kazont:' + word+ ''' kazont:example ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), " ''' + lang + '")) }'
            example = 'Мысалы'
            example_index = 0
        example = "<br/><b>" + example + ": </b>"
        defres = g.query(quest)
        instance_count = 0
        for def_row in defres:
            s = s + example
            example = ""
            instance_count = instance_count + 1
            s = s + '<p style="color:red; margin-bottom:0">&emsp;' + def_row[example_index] +'</p>'
        if instance_count == 0 and lang == 'kz':
            quest = 'PREFIX kazont: <'+ kazont +'> SELECT ?subject WHERE { ?subject rdf:type kazont:'+word+'}'
            defres = g.query(quest)
            instance_count = 0
            s = s +'<p style="color:red; padding-left:15" class="m-0">'
            for def_row in defres:
                instance_count = instance_count + 1
                s = s + def_row[0].split('#')[1] +', '
            s = s + '</p>'
        if temp['id'] == 1:
            s = s + '<br/><p style="color:red; margin-bottom:0">In other language:</p>'
            for key, value in nation_to_lang.items():
                if (value==lang):
                    continue
                quest = 'PREFIX kazont: <'+ kazont +'>  SELECT ?label WHERE { kazont:' + word + ' rdfs:label ?label FILTER(LANG(?label) = "'+value+'")}'
                def_qres = g.query(quest)
                for row in def_qres:
                    s =s + '<p class="m-0">&emsp;<i>'+ key+ '</i>: ' + "<a href=\"javascript:DoSubmit('" + row[0] +"', '"+ value +"');\">" + row[0] + '</a></p>'
    return jsonify({"txt": s, "childs": childs})
def get_question(lock, graph, kazont, query, question, answer, aslist):
    prefix = '''
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX owl: <http://www.w3.org/2002/07/owl#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
        PREFIX kazont: <'''+kazont+'>'
    answers = []
    with lock:
        rows = graph.query(prefix + query)
        if aslist:
            l = []
            for row in rows:
                l.append(row[0].replace(kazont,""))
            if len(l)>0: 
                answers.append({'answer': answer.format("" + ", ".join(l))})
        else:
            for row in rows:
                answers.append({'answer': answer.format(row[0].replace(kazont,""))})
        if len(answers)>0:
            return {'question': question, 'answers': answers}

@app.route('/getontology/questions/', methods=['POST'])
def get_questions():
    temp = json.loads(request.data.decode('utf-8'))
    question = temp['question'].strip()
    g = DB.get_instance().get_onto().TurkOnto(temp['id'])
    lock = DB.get_instance().get_onto_lock()
    results = []
    kazont = 'http://www.semanticweb.org/til_qural_baitursyn#'
    source = "Ахмет Байтұрсынұлы"
    if temp['id']=='1':
        kazont = 'http://www.semanticweb.org/Til-qural_A.Baitursynuly#'
        source = "қазіргі қазақ тілінің грамматикасы"    
  
    
    
    
    questions = [
        # Дегеніміз не деген сұрақтар формасы
        {  
            'question': random.choice(["{} дегеніміз не?", "{} деген не? "]).format(question),
            'query': '''
                SELECT ?olabel
                    WHERE { ?subject rdfs:subClassOf ?object .
                ?subject rdfs:label ?label .
                ?object rdfs:label ?olabel
                FILTER(STR(?label) = "''' + question + '" || STR(?label) = "' + question.capitalize() + '''") 

                }
            ''',
            'answer': question + " дегеніміз - {}",
            'aslist': False
        },

        {
            'question': random.choice([source +" бойынша {} анықтамасы", "{} анықтамасы ", "{} ұғымының анықтамасын айт"]).format(question),
            'query': '''
                SELECT ?object
                    WHERE { ?subject kazont:definition ?object .
                ?subject rdfs:label ?label .
                FILTER(
                    (STR(?label) = "''' + question + '" || STR(?label) = "' + question.capitalize() + '''")
                    && (LANG(?object) = "" || LANG(?object) = "kz" )) 

                }
            ''',
            'answer': question + " анықтамасы: {}",
            'aslist': False
        },
         {
            'question': random.choice(["{} үшін мысал келтір", source + " бойынша {} үшін қандай мысалдар келтірілген"]).format(question),
            'query': '''
            SELECT ?subject
            WHERE 
            { 
                {
                    ?subject rdf:type ?object .
                    ?object rdfs:label ?label .
                    FILTER(
                    (STR(?label) = "''' + question + '" || STR(?label) = "' + question.capitalize() + '''")
                        && (LANG(?label) = "" || LANG(?label) = "kz" )
                    ) 
                }
                union 
                {
                    ?object kazont:example ?subject . 
                    ?object rdfs:label ?label .
                    FILTER(
                    (STR(?label) = "''' + question + '" || STR(?label) = "' + question.capitalize() + '''")
                    && (LANG(?label) = "" || LANG(?label) = "kz" )
                    ) 

                }
            }
            ''',
            'answer': question + " үшін мысалдар: {}",
            'aslist': True
        },

        {
            'question': random.choice([question + " түрлері қандай?", "{} " + source + " бойынша қандай түрлерге бөлінеді"]).format(question),
            'query': '''
                SELECT ?slabel
                    WHERE { ?subject rdfs:subClassOf ?object .
                ?object rdfs:label ?label .
                ?subject rdfs:label ?slabel .
                FILTER((STR(?label) = "''' + question + '" || STR(?label) = "' + question.capitalize() + '''") && (LANG(?slabel) = "" || LANG(?slabel) = "kz" ) ) 
                }
            ''',
            'answer': question + " түрлері: {}",
            'aslist': True
        }
        
    ]
    
    
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future_to_question = {executor.submit(get_question, lock, g, kazont, q['query'], q['question'], q['answer'], q['aslist']): q for q in questions}
        for future in concurrent.futures.as_completed(future_to_question):
            question_data = future_to_question[future]
            try:
                result = future.result()
                if result is not None:
                    results.append(result)
            except Exception as e:
                print(f'Error processing question: {question_data}', str(e))

    response = jsonify({'data': results})
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    response.direct_passthrough = False
    return response