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
    _tilQural = None
    _dw = None
    _owl = None
    def __init__(self, ontologies = None):
        if ontologies is not None: 
            for ontology in ontologies:
                ontology["graph"] = rdflib.Graph()
                ontology["graph"].parse(data = ontology["content"], format='xml')
            _onto = ontologies
        if not MyOwlReady.__instance:

            print(" __init__ method called..")
            _turkOnto = rdflib.Graph()
            _tilQural = rdflib.Graph()
            _turkOnto.parse ('owl/Akhmettanu.owl')
            _tilQural.parse ('owl/Tilqural25082023.owl')
            

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
        cls._turkOnto.parse('owl/Akhmettanu.owl')
        cls._tilQural = rdflib.Graph()
        cls._tilQural.parse ('owl/Tilqural25082023.owl')
    def SyncReasoner(cls):
        if not cls.__instance:
            cls.__instance = MyOwlReady()
        print("Sync reasoner...")
        cls._onto.sync_reasoner()
    @classmethod
    def GetJson(cls, lang):
        #lang = "kg"
        res= ""
        g = rdflib.Graph()
        g.parse('owl/Tilqural25082023.owl')
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
    @classmethod
    def Onto(cls, db):
       if cls._onto == None:
           db.load_ontologies()
       return cls._onto
    @classmethod
    def TurkOnto(cls, id):
        if cls._turkOnto == None:
            print("TurkOntology loading...")
            cls._turkOnto = rdflib.Graph()
            cls._turkOnto.parse('owl/Akhmettanu.owl')
            cls._tilQural = rdflib.Graph()
            cls._tilQural.parse ('owl/Tilqural25082023.owl')
        if id == '1':
            return cls._turkOnto
        else:
            return cls._tilQural
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
        f = open( 'owl/Tilqural25082023.owl', 'w',encoding='utf-8')

        f.write(self.text)
        f.close()
        # app.s = MyOwlReady()
        # app.s.ReloadTurkOnto()
    


    def __str__(self):
        return '%s' % (self.name)
    class Meta:
        verbose_name = 'Жоба'
        verbose_name_plural = 'Жобалар'
    


# from marshmallow import Schema, fields
# from werkzeug.security import generate_password_hash, check_password_hash

# import os
# import rdflib
# from rdflib.serializer import Serializer
# from rdflib.namespace import RDF, RDFS, OWL
# from owlready import *


# class LegacySchema(Schema):
#     id = fields.Int(dump_to='ID')
#     name = fields.Str(dump_to='name')
#     path = fields.Str(dump_to='path')
#     parent_id = fields.Int(dump_to='parentID')
#     is_file = fields.Bool(dump_to='isFile')
# class OWLClass(Schema):
#     name =  fields.Str(dump_to="name")


# OT_Class = 0
# OT_Individ = 1
# OT_Relation = 2
# OT_Prefix = "\"http://www.semanticweb.org/enu/qaztaxexpert#"
# OT_NamedPrefix = 'PREFIX qaztax: <http://www.semanticweb.org/enu/qaztaxexpert#>'
# OT_CleanPrefix = "http://www.semanticweb.org/enu/qaztaxexpert#"
# # Create your models here.
# class MyOwlReady:

#     __instance = None
#     _onto = None
#     _turkOnto = None
#     _dw = None
#     _owl = None
#     _is_new = True
#     def __init__(self):
#         if not MyOwlReady.__instance:
#             print(" __init__ method called..")
#             _turkOnto = rdflib.Graph()
#             if self._is_new:
#                 _turkOnto.parse ('owl/Tilqural25082023.owl')
#             else:
#                 _turkOnto.parse ('owl/Tilqural25082023.owl')
#         else:
#             print("Instance already created:", self.getInstance())
#             print(self.Onto)
#     @classmethod
#     def getInstance(cls):
#         if not cls.__instance:
#             cls.__instance = MyOwlReady()
#         return cls.__instance
#     def ReloadTurkOnto(cls):
#         if not cls.__instance:
#             cls.__instance = MyOwlReady()
#         print("TurkOntology loading...")
#         cls._turkOnto = rdflib.Graph()
#         if cls._is_new:
#             cls._turkOnto.parse('owl/Tilqural25082023.owl')
#         else:
#             cls._turkOnto.parse('owl/Tilqural25082023.owl')
#     def SyncReasoner(cls):
#         if not cls.__instance:
#             cls.__instance = MyOwlReady()
#         print("Sync reasoner...")
#         cls._onto.sync_reasoner()
#     def Onto(cls):
#         if cls._onto == None:
#             print("Ontology loading...")
#             ont = Ontotext.objects.get(name="taxexpert")
#             ont.savetofile(cls._is_new)
#             cls._onto = rdflib.Graph()
#             cls._onto.parse ('taxexpert.owl')
#             #cls._onto = get_ontology("file:taxextpert.owl").load()

#         return cls._onto
#     @classmethod
#     def GetJson(cls, lang, is_new=True):
#         #lang = "kg"
#         cls._is_new = is_new
#         res= ""
#         g = rdflib.Graph()
#         if is_new:
#             g.parse('owl/Tilqural25082023.owl')
#         else:
#             g.parse('owl/Tilqural25082023.owl')
#         quest = 'SELECT ?label WHERE { ?subject rdfs:subClassOf ?object . ?subject rdfs:label ?label FILTER(LANG(?label) = "" || LANGMATCHES(LANG(?label), "' + lang + '")) } order by ?label '
#         qres = g.query(quest)
#         owlclasses = []
        
#         for row in qres:
#             owl = {
#                 'name':row[0]
#             }
#             owlclasses.append(owl)
#             #print(row)
#         return owlclasses
#     @property
#     def TurkOnto(cls):
#         if cls._turkOnto == None:
#             print("TurkOntology loading...")
#             cls._turkOnto = rdflib.Graph()
#         if cls._is_new:
#             cls._turkOnto.parse('owl/Tilqural25082023.owl')
#         else:
#             cls._turkOnto.parse('owl/Tilqural25082023.owl')
            

#         return cls._turkOnto
#     @property
#     def DefWorld(cls):
#         if cls._onto == None:
#             print("Ontology loading...")
#             ont = Ontotext.objects.get(name="taxexpert")
#             ont.savetofile(cls._is_new)
#             onto_path.append(os.getcwd())
#             cls._onto = get_ontology("taxexpert.owl").load()

#             print(cls._onto)

#         return cls._onto
    


    

# class MyOntology():
#     name = fields.Str()
#     language = fields.Str()
#     text = fields.Str()
    
        
#     def savetofile(self, is_new):
        
#         if is_new:
#             f = open( 'owl/Tilqural25082023.owl', 'w',encoding='utf-8')
#         else:
#             f = open( 'owl/Tilqural25082023.owl', 'w',encoding='utf-8')

#         f.write(self.text)
#         f.close()
#         # app.s = MyOwlReady()
#         # app.s.ReloadTurkOnto()
    


#     def __str__(self):
#         return '%s' % (self.name)
#     class Meta:
#         verbose_name = 'Жоба'
#         verbose_name_plural = 'Жобалар'
    

