import os
from django.db import models
from django.conf import settings
from django.db.models.deletion import CASCADE
try:
    # Django 3.1 and above
    from django.utils.functional import classproperty
except ImportError:
    from django.utils.decorators import classproperty
import rdflib
from rdflib.serializer import Serializer
from rdflib.namespace import RDF, RDFS, OWL
from owlready import *

OT_Class = 0
OT_Individ = 1
OT_Relation = 2
OT_Prefix = "\"http://www.semanticweb.org/enu/qaztaxexpert#"
OT_NamedPrefix = 'PREFIX qaztax: <http://www.semanticweb.org/enu/qaztaxexpert#>'
OT_CleanPrefix = "http://www.semanticweb.org/enu/qaztaxexpert#"
# Create your models here.
class MyOwlReady:

    __instance = None
    _onto = None
    _turkOnto = None
    _dw = None
    _owl = None
    def __init__(self):
        _onto = None
        if not MyOwlReady.__instance:
            print(" __init__ method called..")
            ont = Ontotext.objects.get(name="taxexpert")
            ont.savetofile()
            _onto = get_ontology("file:taxexpert.owl").load()
            _onto.sync_reasoner()
            _turkOnto = rdflib.Graph()
            _turkOnto.parse ('owl/Akhmettanu.owl')
            

        else:
            print("Instance already created:", self.getInstance())
            print(self.Onto)

    @classmethod
    def getInstance(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        return cls.__instance
    @classmethod
    def ReloadTurkOnto(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        print("TurkOntology loading...")
        cls._turkOnto = rdflib.Graph()
        cls._turkOnto.parse('owl/Akhmettanu.owl')
    @classmethod
    def SyncReasoner(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        print("Sync reasoner...")
        cls._onto.sync_reasoner()
    @classproperty
    def Onto(cls):
        if cls._onto == None:
            print("Ontology loading...")
            ont = Ontotext.objects.get(name="taxexpert")
            ont.savetofile()
            cls._onto = rdflib.Graph()
            cls._onto.parse ('taxexpert.owl')
            #cls._onto = get_ontology("file:taxextpert.owl").load()

        return cls._onto
    @classproperty
    def TurkOnto(cls):
        if cls._turkOnto == None:
            print("TurkOntology loading...")
            cls._turkOnto = rdflib.Graph()
            cls._turkOnto.parse('owl/Akhmettanu.owl')

        return cls._turkOnto
    @classproperty
    def DefWorld(cls):
        if cls._onto == None:
            print("Ontology loading...")
            ont = Ontotext.objects.get(name="taxexpert")
            ont.savetofile()
            onto_path.append(os.getcwd())
            cls._onto = get_ontology("taxexpert.owl").load()

            print(cls._onto)

        return cls._onto

class Topic(models.Model):
    create_date = models.DateTimeField(auto_now=True, verbose_name='Құрылған уақыты')
    name = models.CharField(max_length=200, verbose_name='Атауы')
    text = models.TextField(blank = True, verbose_name='Мәтіні')
    author = models.ForeignKey(settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE)
    
class Question(models.Model):
    text = models.TextField(blank = True, verbose_name='Мәтіні')
    qtype = models.IntegerField(verbose_name='Сұрақ түрі')
    level = models.IntegerField(default=0, verbose_name='Деңгейі')
    answer = models.TextField(blank=True, verbose_name='Жауабы')
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
class MyOntology(models.Model):
    create_date = models.DateTimeField(auto_now=True, verbose_name='Құрылған уақыты')
    name = models.CharField(max_length=200, verbose_name='Атауы')
    language = models.CharField(max_length=50,verbose_name='Тілі')
    text = models.TextField(blank = True, verbose_name='Мәтіні')
    author = models.ForeignKey(settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE)
    def savetofile(self):
        f = open( 'owl/Akhmettanu.owl', 'w',encoding='utf-8')

        f.write(self.text)
        f.close()
        s = MyOwlReady()
        s.ReloadTurkOnto()
    def GetJson(self,lang):
        res=''
        self.savetofile()
        g = rdflib.Graph()
        g.parse('owl/Akhmettanu.owl')
        quest = 'SELECT ?label WHERE { ?subject rdfs:subClassOf ?object . ?subject rdfs:label ?label FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "' + lang + '")) } order by ?label '
        qres = g.query(quest)
        for row in qres:
            res = res + "<br/>&emsp; <a href=\"javascript:DoSubmit('" + row[0] +"');\">" + row[0] + "</a>"
        return res


    def __str__(self):
        return '%s' % (self.name)
    class Meta:
        verbose_name = 'Жоба'
        verbose_name_plural = 'Жобалар'
class Ontotext(models.Model):
    text = models.TextField(blank = True, verbose_name = 'Мәтіні')
    owl = models.TextField(blank = True, verbose_name = 'Owl мәтіні')
    json = models.TextField(blank = True, verbose_name = 'Json мәтіні')
    name = models.CharField(max_length=200, verbose_name='Атауы')
    def savetofile(self):
        f = open( 'taxexpert.owl', 'w',encoding='utf-8')
        f.write(self.owl)
        f.close()
class Ontothing:
    def __init__(self, child, name, type, id, parent = None):
        if (parent == None) :
            self.name = name
            self.type = type
            self.id = id[0]
            self.childs = []
            return
        if (type == OT_Class):
            #print("c=",child, " p=", name)
            self.name = name
            self.type = type
            self.id = id[0]
            self.childs = []
            id[0] = id[0] + 1
            child1 = Ontothing("", child, type, id)
            child2 = parent.findChild(name)
            if child2 == None:
                self.childs.append(child1)
                parent.childs.append(self)
            else:
                child2.childs.append(child1)
        elif (type == OT_Individ):
            self.type = type
            self.name = child
            self.id = id[0]
            self.childs = []
            tclass = parent.findChild(name)
            if tclass == None:
                id[0]+=1
                tclass = Ontothing("", name,OT_Individ, id)
                parent.childs.append(tclass)
            tclass.childs.append(self)
        elif (type == OT_Relation):
            self.type = type
            childs = child.split(">")
            print(childs)
            self.childs = []
            self.name = childs[0]
            self.domain = name
            self.id = id[0]
            id[0]+=1
            self.relatedTo = childs[1]
            predicate = parent.findChild(name)
            if predicate == None:
                predicate = Ontothing("",name, OT_Class, id)
                parent.childs.append(predicate)
            predicate.childs.append(self)
            #self.childs.append(Ontothing("", childs[1], OT_Class, id))

    def findChild(self, name):
        if len(self.childs)<=0:
            return None
        for child in self.childs:
            if child.name == name:
                return child
        for child in self.childs:
            child2 = child.findChild(name)
            if child2 != None:
                return child2
        return None
    def print(self):
        print(self.name + " " + str(self.id))
        print(len(self.childs))
        for child in self.childs:
            child.print()
    # OWL синтаксисіндегі мәтінін қайтару
    def getOwl(self, parentName):
        result = ""
        if self.type == OT_Class:
            if self.name == "thing":
                result += """<?xml version=\"1.0\"?>
<rdf:RDF xmlns=\"http://www.semanticweb.org/enu/qaztaxexpert#\"
  xml:base=\"http://www.semanticweb.org/enu/qaztaxexpert\"
  xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"
  xmlns:owl=\"http://www.w3.org/2002/07/owl#\"
  xmlns:xml=\"http://www.w3.org/XML/1998/namespace\"
  xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"
  xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\">
    <owl:Ontology rdf:about=\"http://www.semanticweb.org/enu/qaztaxexpert\"/>
"""
            else:
                #print("class===" + self.name)
                result += "\t<owl:Class rdf:about=" + OT_Prefix + self.name + "\">\n"
                if parentName != "thing":
                    result += "\t\t<rdfs:subClassOf rdf:resource=" + OT_Prefix + parentName + "\"/>\n"
                for child in self.childs:
                    if child.type == OT_Relation:
                        result += """
            <owl:equivalentClass>
            <owl:Restriction>
                    <owl:onProperty rdf:resource=\"http://www.semanticweb.org/enu/qaztaxexpert#""" + child.name + """\"/>
                        <owl:someValuesFrom rdf:resource=\"http://www.semanticweb.org/enu/qaztaxexpert#"""  + child.relatedTo +"""\"/>
                </owl:Restriction>
            </owl:equivalentClass>
"""
                result += "\t</owl:Class>\n"
            for child in self.childs:
                result += child.getOwl(self.name)
        elif (self.type == OT_Individ):
            result +="\t<owl:NamedIndividual rdf:about=" + OT_Prefix + self.name + "\">\n"
            result +="\t\t<rdf:type rdf:resource=" + OT_Prefix + parentName + "\"/>\n"
            result += "\t</owl:NamedIndividual>\n"
        if self.name == "thing":
           result +="\n</rdf:RDF>"

        return result
    def GetJSON(self):
        result = ""
        if self.name == "thing":
            result+= "["

        result += """
    {
        \"text\": \"""" + self.name + """\",
        \"icon\": \"""" + ("fa fa-circle" if self.type == OT_Class else "fa fa-info-circle") + "\""
        if (len(self.childs)>0):
            result +=""",
        \"nodes\":
            ["""
            childs = filter(lambda ch: ch.type != OT_Relation, self.childs)
            for child in childs:
                if (self.childs.index(child)>0):
                    result +=", "
                result += child.GetJSON()
            if self.name == "thing":
                props = self.GetProperties()
                if len(props)>0:
                    result += """\t\t,{
            \"text\": \"properties\",
            \"icon\": \"fa fa-code-fork\",
            \"nodes\":
                ["""
                    for prop in props:
                        if props.index(prop)>0:
                            result +=","
                        result += """\t\t\t{
                \"text\": \"""" + prop.name + """\",
                \"icon\": \"fa fa-link\",
                \"nodes\":
                    [{
                        \"text\": \"""" + prop.domain + """\",
                        \"icon\": \"fa fa-bullseye\"
                    },
                    {
                        \"text\": \"""" + prop.relatedTo + """\",
                        \"icon\": \"fa fa-crosshairs\"
                    }
                    ]}"""


                    result +="]}"
            result +="\t\t\t]"



        result+= "\t}"

        if self.name == "thing":
            result+= "]"




        return result
    def GetProperties(self):
        props = []
        for child in self.childs:
            if child.type == OT_Relation:
                props.append(child)
            elif child.type == OT_Class:
                props = props + child.GetProperties()
        return props

#fa-code-fork
#fa-link
#fa-crosshairs
#fa-dot-circle-o