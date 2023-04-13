from marshmallow import Schema, fields
from werkzeug.security import generate_password_hash, check_password_hash

import os
import rdflib
from rdflib.serializer import Serializer
from rdflib.namespace import RDF, RDFS, OWL
from owlready import *
    
class LegacySchema(Schema):
    id = fields.Int(dump_to='ID')
    name = fields.Str(dump_to='name')
    path = fields.Str(dump_to='path')
    parent_id = fields.Int(dump_to='parentID')
    is_file = fields.Bool(dump_to='isFile')
class OWLClass(Schema):
    name =  fields.Str(dump_to="name")


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
        if not MyOwlReady.__instance:
            print(" __init__ method called..")

            _turkOnto = rdflib.Graph()
            _turkOnto.parse ('ontology.owl')
            

        else:
            print("Instance already created:", self.getInstance())
            print(self.Onto)
    @classmethod
    def getInstance(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        return cls.__instance
    def ReloadTurkOnto(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        print("TurkOntology loading...")
        cls._turkOnto = rdflib.Graph()
        cls._turkOnto.parse('ontology.owl')
    def SyncReasoner(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        print("Sync reasoner...")
        cls._onto.sync_reasoner()
    def Onto(cls):
        if cls._onto == None:
            print("Ontology loading...")
            ont = Ontotext.objects.get(name="taxexpert")
            ont.savetofile()
            cls._onto = rdflib.Graph()
            cls._onto.parse ('taxexpert.owl')
            #cls._onto = get_ontology("file:taxextpert.owl").load()

        return cls._onto
    @classmethod
    def GetJson(cls):
        lang = "kz"
        res= ""
        g = rdflib.Graph()
        g.parse('ontology.owl')
        quest = 'SELECT ?label WHERE { ?subject rdfs:subClassOf ?object . ?subject rdfs:label ?label FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "' + lang + '")) } order by ?label '
        qres = g.query(quest)
        owlclasses = []
        
        for row in qres:
            owl = {
                'name':row[0]
            }
            owlclasses.append(owl)
            #print(row)
        return owlclasses
    @property
    def TurkOnto(cls):
        if cls._turkOnto == None:
            print("TurkOntology loading...")
            cls._turkOnto = rdflib.Graph()
            cls._turkOnto.parse('ontology.owl')

        return cls._turkOnto
    @property
    def DefWorld(cls):
        if cls._onto == None:
            print("Ontology loading...")
            ont = Ontotext.objects.get(name="taxexpert")
            ont.savetofile()
            onto_path.append(os.getcwd())
            cls._onto = get_ontology("taxexpert.owl").load()

            print(cls._onto)

        return cls._onto


    

class MyOntology():
    name = fields.Str()
    language = fields.Str()
    text = fields.Str()
    
        
    def savetofile(self):
        f = open( 'ontology.owl', 'w',encoding='utf-8')

        f.write(self.text)
        f.close()
        s = MyOwlReady()
        s.ReloadTurkOnto()
    


    def __str__(self):
        return '%s' % (self.name)
    class Meta:
        verbose_name = 'Жоба'
        verbose_name_plural = 'Жобалар'


#fa-code-fork
#fa-link
#fa-crosshairs
#fa-dot-circle-o