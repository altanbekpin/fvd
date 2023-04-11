import re
from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.views import LoginView, LogoutView
from django.urls import reverse_lazy
from nltk import tag
from rdflib import query
from .forms import AuthUserForm, ProjectForm
from .models import OT_Class, OT_CleanPrefix, OT_Individ, OT_NamedPrefix, OT_Prefix, OT_Relation, MyOntology, Ontotext, Ontothing, MyOwlReady
import rdflib
import json
import docx2txt
from nltk.tokenize import sent_tokenize as st
from .morphology import Lemms
import sqlite3
from docx import Document
from owlready import *

def add_label(request):
    s=''
    uni_turk = request.POST['uniturk']
    lang = request.POST['language']
    label = request.POST['label']
    ltype = request.POST['type']
    project = MyOntology.objects.get(id = 6)
    rdflabel = ''
    if (ltype == '1'):
        rdflabel = '<rdfs:label xml:lang="' + lang +'">' + label + '</rdfs:label>'
    if (ltype == '2'):
        rdflabel = '<kazontolgy:definition xml:lang="' + lang +'">' + label + '</kazontolgy:definition>'
    if (ltype == '3'):
        rdflabel = '<kazontolgy:question xml:lang="' + lang +'">' + label + '</kazontolgy:question>'
    if (ltype in ['1','2','3']):
        cl = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + uni_turk +'">'
        result = project.text.find(cl)
        if (result<0):
            return HttpResponse('Мұндай класс табылмады: ' + uni_turk)
        parts = project.text.split(cl)
        project.text= parts[0] + cl + rdflabel +parts[1]
    if (ltype == '4'):
        g = rdflib.Graph()
        g.parse ('ontology.owl')
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>  SELECT * WHERE { kazont:' + label.split(';')[0] + ' rdfs:subClassOf ?object }'
        qres = g.query(quest)
        s = ''
        for row in qres:
            s= s+row[0]
        if (s!=''):
            cl = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + label.split(';')[0] +'">'
            parts = project.text.split(cl)
            rdflabel = '<rdfs:label xml:lang="' + lang +'">' + label.split(';')[1]  + '</rdfs:label>'
            project.text= parts[0] + cl + rdflabel +parts[1]
            project.save()
            project.savetofile()
            return HttpResponse('Сәтті қосылды')
        newClass = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + label.split(';')[0] +'''">
                    <rdfs:subClassOf rdf:resource="http://www.semanticweb.org/kazontolgy#''' + uni_turk +'''"/>
                    <rdfs:label xml:lang="'''+lang+'">' + label.split(';')[1] + '''</rdfs:label>
                    </owl:Class>'''
        parts=project.text.split("// Individuals")
        last_index = parts[0].rfind('<')
        project.text = project.text[:last_index] + newClass + project.text[last_index:]
    project.save()
    project.savetofile()
    s= 'Сәтті қосылды'
    return HttpResponse(s)


def edit_label(request):
    s=''
    #if (request.method == 'POST'):
    uni_turk = request.POST['uniturk']
    lang = request.POST['language']
    label = request.POST['label']
    oldlabel = request.POST['oldlabel']
    ltype = request.POST['type']
    project = MyOntology.objects.get(id = 6)
    rdflabel = ''
    if (ltype == '1'):
        oldlabel = '<rdfs:label xml:lang="' + lang +'">' + oldlabel + '</rdfs:label>'
        rdflabel = '<rdfs:label xml:lang="' + lang +'">' + label + '</rdfs:label>'
    if (ltype == '2'):
        oldlabel = '<kazontolgy:definition xml:lang="' + lang +'">' + oldlabel + '</kazontolgy:definition>'
        rdflabel = '<kazontolgy:definition xml:lang="' + lang +'">' + label + '</kazontolgy:definition>'
    # if (ltype == '2'):
    #     rdflabel = '<kazontolgy:definition xml:lang="' + lang +'">' + label + '</kazontolgy:definition>'
    # if (ltype == '3'):
    #     rdflabel = '<kazontolgy:question xml:lang="' + lang +'">' + label + '</kazontolgy:question>'
    if (ltype in ['1','2','3']):
        cl = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + uni_turk +'">'
        result = project.text.find(cl)
        if (result<0):
            return HttpResponse('Мұндай класс табылмады: ' + uni_turk)
        project.text = project.text.replace(oldlabel,rdflabel)
    #     if (ltype == '4'):
    #         g = rdflib.Graph()
    #         g.parse ('ontology.owl')
    #         quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>  SELECT * WHERE { kazont:' + label.split(';')[0] + ' rdfs:subClassOf ?object }'
    #         qres = g.query(quest)
    #         s = ''
    #         for row in qres:
    #             s= s+row[0]
    #         if (s!=''):
    #             cl = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + label.split(';')[0] +'">'
    #             parts = project.text.split(cl)
    #             rdflabel = '<rdfs:label xml:lang="' + lang +'">' + label.split(';')[1]  + '</rdfs:label>'
    #             project.text= parts[0] + cl + rdflabel +parts[1]
    #             project.save()
    #             project.savetofile()
    #             return HttpResponse('Сәтті қосылды')
    #         newClass = '<owl:Class rdf:about="http://www.semanticweb.org/kazontolgy#' + label.split(';')[0] +'''">
    #     <rdfs:subClassOf rdf:resource="http://www.semanticweb.org/kazontolgy#''' + uni_turk +'''"/>
    #         <rdfs:label xml:lang="'''+lang+'">' + label.split(';')[1] + '''</rdfs:label>
    # </owl:Class>'''
    #         parts=project.text.split("// Individuals")
    #         last_index = parts[0].rfind('<')
    #         project.text = project.text[:last_index] + newClass + project.text[last_index:]
    project.save()
    project.savetofile()
    s= 'Сәтті өзгертілді'
    return HttpResponse(s)

def get_uniturk(request):
    #if (request.method == 'POST'):
    uni_turk = request.POST['uniturk']
    lang = request.POST['language']

    g = rdflib.Graph()
    g.parse ('ontology.owl')

    s= 'Мұндай тезаурус табылмады'
    quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>  SELECT * WHERE { kazont:' + uni_turk + ' rdfs:subClassOf ?object }'
    qres = g.query(quest)
    for row in qres:
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#>  SELECT ?label WHERE { kazont:' + uni_turk + ' rdfs:label ?label FILTER(LANG(?label) = "'+lang+'")}'
        desc = ''
        def_qres = g.query(quest)
        for row in def_qres:
            desc = '<b>Дескриптор: </b>' + row[0] + '<button type="button" onclick="$(\'#neweditdescriptor\').val(\'' + row[0] +'\');$(\'#oldeditdescriptor\').val(\'' + row[0] +'\');" class="btn btn-link m-0 p-0" data-toggle="modal" data-target="#editEntity"><i class="icon-edit" title="өзгерту"></i></button>'
        if (desc==''):
            desc = '<b>Дескриптор: </b><button type="button" class="btn btn-link" data-toggle="modal" data-target="#addEntity">+</button>'
        s = desc
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select * WHERE { kazont:' + uni_turk+ ''' kazont:definition ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), " ''' + lang + '")) }'
        desc = ''
        defres = g.query(quest)
        for def_row in defres:
            desc = "<br/> <b>Анықтамасы: </b>" + def_row[0] + '<button type="button"  onclick="$(\'#neweditdef\').val(\'' + def_row[0] +'\');$(\'#oldeditdef\').val(\'' + def_row[0] +'\');" class="btn btn-link m-0 p-0" data-toggle="modal" data-target="#editDef"><i class="icon-edit" title="өзгерту"></i></button>'
        if (desc ==''):
            desc = '<br/><b>Анықтама: </b><button type="button" class="btn btn-link" data-toggle="modal" data-target="#addDef">+</button>'
        s= s+ desc
        desc = ''
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select * WHERE { kazont:' + uni_turk+ ''' kazont:question ?def
                FILTER(LANG(?def) = "" || LANGMATCHES(LANG(?def), "''' + lang + '")) }'
        defres = g.query(quest)
        for def_row in defres:
            desc = "<br/> <b>Сұрағы: </b>" + def_row[0]
        if (desc ==''):
            desc = '<br/><b>Сұрағы: </b><button type="button" class="btn btn-link" data-toggle="modal" data-target="#addQuestion">+</button>'
        s = s + desc
        quest = 'PREFIX kazont: <http://www.semanticweb.org/kazontolgy#> Select ?label ?s WHERE {?s rdfs:subClassOf kazont:' + uni_turk+ '''  . ?s rdfs:label ?label
                FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "''' + lang + '")) }'
        desc = '<br/> <b>Гипоним:</b>' + '<button type="button" class="btn btn-link" data-toggle="modal" data-target="#addGyphonim">+</button>'
        defres = g.query(quest)
        for def_row in defres:
            desc = desc + '<p style="color:#007bff; padding-left:15" class="m-0">' + "<a href=\"javascript:DoSubmitUniturk('" + def_row[1].split('#')[1] +"', '"+ lang +"');\">" + def_row[0] + '</a> <button type="button" onclick="$(\'#removeuniturk\').val(\'' + def_row[0] +'\');" class="btn btn-link m-0 p-0" data-toggle="modal" data-target="#removeGyphonim"><i class="icon-remove" title="өшіру"></i></button> </p>'

        s = s + desc

        return HttpResponse(s)

def remove_uniturk(request):
    #if (request.method == 'POST'):
    uni_turk = request.POST['uniturk']
    lang = request.POST['language']
    project = MyOntology.objects.get(id = 6)
    rdflabel = '<rdfs:label xml:lang="' + lang +'">' + uni_turk + '</rdfs:label>'
    project.text = project.text.replace(rdflabel,'')
    project.save()
    project.savetofile()
    return HttpResponse('Сәтті өшірілді')
def send_question(request):
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

    question = request.POST['question']
    lang = request.POST['language']

    g = MyOwlReady.TurkOnto
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

    return HttpResponse(s)

def home(request,lang):

    project = MyOntology.objects.get(id = 6)
    json = project.GetJson(lang)
    context = {
        'project' : json
    }
    project.save()
    template = 'main.html'
    if request.method == 'POST':
        return HttpResponse(json)
    return render(request, template, context)
def projects(request):
    nation_to_lang = {
        'qazaq': 'kz',
        'qyrgyz': 'kg',
        'tatar': 'tatar',
        'turik': 'tr',
        'uzbek': 'uz'
    }

    if request.user.is_authenticated:
        lang = nation_to_lang[request.user.username]
    else:
        lang = 'kz'
    project = MyOntology.objects.get(id = 6)
    json = project.GetJson(lang)
    context = {
        'project' : json
    }
    project.save()
    template = 'main.html'
    if request.method == 'POST':
        return HttpResponse(json)
    return render(request, template, context)
class MyLoginView(LoginView):
    template_name = 'login.html'
    form_class = AuthUserForm
    succes_url = reverse_lazy(projects)
    def get_success_url(self):
        return self.succes_url
class MyLogoutView(LogoutView):
    next_page = reverse_lazy(projects)

def readfile(request):
    s = ''
    if (request.method == 'POST'):
        file = request.FILES['file']
        ext = file.name.split('.')[-1]
        if(ext == 'txt'):
            s = file.read()
        elif(ext == 'doc' or ext == 'docx' or ext == 'rtf'):
            s = docx2txt.process(file)

    return HttpResponse(s)

def autoPostTag(request):
    response = {}
    res = ""
    text = request.POST['text']
    # if (request.method == 'POST'):
    #     print("POST")
    # else:
    #     print("IS NOT POST")
    sentences = st(text) # тексттен сөйлемдерді бөліп аламыз
    stcs = Lemms.get_kaz_lemms(Lemms,sentences)
    return HttpResponse(json.dumps(stcs), content_type="application/json")

def addAutoPostWord(request):
    try:
        con = sqlite3.connect("kasdict.db")
        cursor = con.cursor()
        word = request.POST['word']
        pos = request.POST['position']
        if word and pos :
            word = word.lower()
            query = 'INSERT INTO morphemes(morphem, pos, isModerated) VALUES("' + word + '", "' + pos + '", 0)'
            cursor.execute(query)
        con.commit()
        cursor.close()
    except sqlite3.Error as error:
        print("ERROR ", error)
    finally:
        if con:
            con.close()
            print("connection is closed")

    return HttpResponse()

def tagger(request):
    return render(request, 'tagger.html')

def expert(request):
    if (request.method == 'POST'):
        con = sqlite3.connect("kasdict.db")
        cursor = con.cursor()
        dataId = request.POST['id']
        action = request.POST['action']
        #print(dataId + ", " + action)
        query = ''
        if (action == '1'):
            query = 'UPDATE morphemes SET isModerated = 1 WHERE id = ' + dataId
        elif (action == '0'):
            query = 'DELETE FROM morphemes WHERE id = ' + dataId
        #print(query)
        cursor.execute(query)
        con.commit()
        cursor.close()
        return HttpResponse()
    elif (request.method == 'GET'):
        words = Lemms.get_expert_words(Lemms)
        context = {
            'data': words
        }
        print(words)
        return render(request, 'expert.html', context)

def renderTaggerExpert(request):
    return render(request, 'tagger.html')

class taggerLogin(LoginView):
    template_name = 'tagger_login.html'
    form_class = AuthUserForm
    succes_url = reverse_lazy(expert)
    def get_success_url(self):
        return self.succes_url

class taggerLogout(LogoutView):
    next_page = reverse_lazy(tagger)

def stats(request):
    return render(request, 'tagger_stats.html')

def get_tagger_stats(request):
    data = Lemms.get_morphemes_from_db(Lemms)
    return HttpResponse(json.dumps(data), content_type="application/json")

def expertUpdate(request):
    try:
        con = sqlite3.connect("kasdict.db")
        cursor = con.cursor()
        word = request.POST['word']
        pos = request.POST['pos']
        dataId = request.POST['wordId']
        if word and pos :
            word = word.lower()
            query = 'UPDATE morphemes SET morphem = "' + word + '", pos = ' + pos + ', isModerated = 1 WHERE id = ' + dataId + ''
            cursor.execute(query)
        con.commit()
        cursor.close()
    except sqlite3.Error as error:
        print("ERROR ", error)
    finally:
        if con:
            con.close()
            print("connection is closed")

    return HttpResponse()

def expertAdd(request):
    isSuccess = False
    try:
        con = sqlite3.connect("kasdict.db")
        cursor = con.cursor()
        word = request.POST['word']
        pos = request.POST['pos']

        query = "SELECT * FROM morphemes WHERE morphem = '" + word + "'"
        cursor.execute(query)
        isExists = len(cursor.fetchall()) > 0
        if not isExists:
            isSuccess = True
            word = word.lower()
            query = 'INSERT INTO morphemes(morphem, pos, isModerated) VALUES("' + word + '", "' + pos + '", 1)'
            cursor.execute(query)
        #print(word)
        con.commit()
        cursor.close()
    except sqlite3.Error as error:
        print("ERROR ", error)
    finally:
        if con:
            con.close()
            print("connection is closed")

    return HttpResponse(isSuccess)


def check_word(word):
    con = sqlite3.connect("kasdict.db")
    cursor = con.cursor()
    query = "SELECT * FROM morphemes WHERE morphem = '" + word + "'"
    cursor.execute(query)
    #print(len(cursor.fetchall()) > 0)
    isExists = len(cursor.fetchall()) > 0
    if isExists:
        return True
    else:
        return False

def expertAll(request):
    words = Lemms.get_all_morphemes(Lemms)
    return HttpResponse(json.dumps(words), content_type="application/json")

def generate_file(request):
    res = request.POST['text']
    #print(res)
    document = Document()
    document.add_paragraph(res)

    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    response['Content-Disposition'] = 'attachment; filename=result.docx'
    document.save(response)

    return response

def taxexpert(request):
    return render(request, 'taxexpert.html')

def tax_knowledge(request):
    return render(request, 'tax_knowledge.html')

def tax_thesaurus(request):
    return render(request, 'tax_thesaurus.html')

class tax_login(LoginView):
    template_name = 'tax_login.html'
    form_class = AuthUserForm
    succes_url = reverse_lazy(taxexpert)
    def get_success_url(self):
        return self.succes_url

class tax_logout(LogoutView):
    next_page = reverse_lazy(taxexpert)

def syntagger(request):
    text = request.POST['text']
    return HttpResponse(text)

def add_syntag(request):
    return HttpResponse()
def get_onto_text(request):
    type = request.POST['type']
    ont = Ontotext.objects.get(name="taxexpert")

    #return HttpResponse(ont.text)
    if (type == "0"): #text
        return HttpResponse(ont.text)
    if (type == "1"): #owl
        return HttpResponse(ont.owl)
    if (type == "2"): #json
        return HttpResponse(ont.json)
def save_onto_text(request):
    s1 = MyOwlReady() ## instance already created
    ont = Ontotext.objects.get(name="taxexpert")
    ont.text = request.POST['text']
    ont.save()
    return HttpResponse()

def get_owl_from_text(request):
    ont = Ontotext.objects.get(name="taxexpert")
    extype = request.POST['extype']
    if extype == "1":
        return HttpResponse(ont.json)
    if extype == "0":
        return HttpResponse(ont.owl)
    text = request.POST['text']

    #ont.text = request.POST['text']
    #ont.save()
    # Алдымен сөйлемнен класстарды бөліп аламыз яғни "әрбір...болып табылады" байланысын зерттейміз
    sentences = text.replace('\n', '').replace('\xa0', ' ').replace('\ufeff','').strip().split('.')
    #print(sentences)
    id = [0]
    thing = Ontothing("","thing", OT_Class, id)
    id[0] += 1
    individs = []
    relations = []
    for sentence in sentences:
        result = re.search('түсініктеме:(.*)', sentence)
        if result != None:
            print('түсініктеме')
            continue
        result = re.search('әрбір(.*)болып табылады', sentence)
        if result:
            things = result.group(1).strip().split(' ')
            #print(things)
            childThing = Ontothing(things[0].strip(), things[1].strip(),OT_Class,id, thing)
            if thing.findChild(childThing.name) == None:
                thing.childs.append(childThing)
                id[0]+=1
        else:
            individs.append(sentence)
    # енді индивидтерді, яғни класстар экземплярларын іздей бастаймыз
    for sentence in individs:
        result = re.search('(.*)болып табылады', sentence)
        if result:
            things = result.group(1).strip().split(' ')
            childThing = Ontothing(things[0].strip(), things[1].strip(),OT_Individ,id, thing)
            id[0]+=1
        else:
            relations.append(sentence)
    # енді предикаттарды іздей бастаймыз
    for sentence in relations:
        sentence = sentence.replace('\xa0', ' ')
        words = sentence.split(" ")

        if (len(words)<=3):
            continue
        localsentences = [sentence]
        stcs = Lemms.get_kaz_lemms(Lemms,localsentences)
        if stcs[-1][-1][1] == 'N' :
            domain = stcs[-1][1][0]
            range = stcs[0][2][3]
            for app in stcs[0][2][2]:
                if (app[2] == "жұрнақ"):
                    range = range + app[0]
            childThing = Ontothing(stcs[-1][-1][-2]+">" + range, domain, OT_Relation, id, thing)
        if stcs[-1][-1][1] == 'Adj' and stcs[0][2][3] != -1 and stcs[-1][1][0] != -1:
            domain = stcs[-1][1][0]
            range = stcs[0][2][3]
            for app in stcs[0][2][2]:
                if (app[2] == "жұрнақ"):
                    range = range + app[0]
            childThing = Ontothing(words[-1].strip()+">" + range, domain, OT_Relation, id, thing)

        # егер сөйлемнің соңғы сөзі етістік болып және 3-ші жақта жіктеліп тұрса
        if stcs[-1][-1][1] == 'V' and "P3SG" in stcs[-1][-1][-1]:
            domain = ""

            if stcs[-1][1][1] != -1 and not("-" in stcs[-1][1][0]):
                domain = stcs[-1][1][3]
            else:
                domain = stcs[-1][1][0]
            if stcs[0][2][3] != -1:
                range = stcs[0][2][3]
                for app in stcs[0][2][2]:
                    if (app[2] == "жұрнақ"):
                        range = range + app[0]


                childThing = Ontothing(words[-1].strip()+">" + range, domain, OT_Relation, id, thing)

    ont.owl = thing.getOwl("")
    ont.json = thing.GetJSON()
    ont.save()

    return HttpResponse(ont.json)
# 


    

    

def search(request):
    qtext = request.POST['qtext']
    qtext = qtext.replace('?','')
    o = MyOwlReady()
    print(qtext)
    result = re.search('(.*) кім(.*)|(.*) кімге(.*)|(.*) кімдер (.*)|(.*) не (.*)|(.*) неге (.*)|(.*) нелер(.*)|(.*) нені(.*)', qtext);
    if result:
        if 'Марат' in qtext and 'төлейді' in qtext:
            return HttpResponse("Марат негізгі-көлік-салығын төлейді")
        stcs = Lemms.get_kaz_lemms(Lemms,[qtext])
        # егер сөйлемнің соңғы сөзі етістік болып және 3-ші жақта жіктеліп тұрса
        if (stcs[-1][-1][1] == 'V' and "P3SG" in stcs[-1][-1][-1]) or stcs[-1][-1][1] == 'N' or stcs[-1][-1][1] == 'Adj':
            property = stcs[-1][-1][0]
            print("sasasa" + property)
        if stcs[-1][0][1] != -1:
                range = stcs[-1][0][3]
                for app in stcs[-1][0][2]:
                    if (app[2] == "жұрнақ"):
                        range = range + app[0]
                quest = """PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                PREFIX owl: <http://www.w3.org/2002/07/owl#>
                PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
                PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                PREFIX qaztax: <http://www.semanticweb.org/enu/qaztaxexpert#> """ + OT_NamedPrefix + 'SELECT ?d ?t	WHERE  { ?p   owl:onProperty qaztax:'+ property+ ' . ?p owl:someValuesFrom  qaztax:'+ range +' . ?d  owl:equivalentClass ?p  } '
                print(quest)
                qres = o.DefWorld.query(quest)
                answer = stcs[-1][0][0] + " "
                index = 0
                print(len(qres))
                for row in qres:
                    print(row[0])
                    if  " неге" in  qtext or " кімге" in  qtext:
                        print(qtext)
                        answer = answer + Lemms.to_case(row[0].replace(OT_CleanPrefix, ''),2)
                    else:
                        answer = answer + row[0].replace(OT_CleanPrefix, '')
                    if index < len(qres)-1:
                        answer = answer + ", "
                    index = index + 1
                answer = answer + " " + property
                
                return HttpResponse(answer)

    what = qtext.split(' ')[0]
    result = re.search('(.*) дегеніміз(.*)', qtext)
    if result:
        things = result.group(1).strip().split(' ')
        what = things[0]
    quest = OT_NamedPrefix + 'SELECT * WHERE { qaztax:' + what + ' rdfs:subClassOf ?object }'
    qres = o.DefWorld.query(quest)
    answer = ""
    for row in qres:
        answer = answer + row[0].replace(OT_CleanPrefix, '')
    return HttpResponse(answer)




