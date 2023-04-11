from django.db import reset_queries


class RelationType:
    Name = ''
    InMath = ''
    NameInKaz = ''
    def __init__(self, name, nameInKaz, inMath):
        self.Name = name
        self.NameInKaz = nameInKaz
        self.InMath = inMath
Relaions = [
        RelationType("isEqual","тең", "="),
        RelationType("isGreater","үлкен", ">"),
        RelationType("isGreater","үлкен", ">"),
        RelationType("isGreater","үлкен", ">")
    ]
class Task:
    Variables = []
    Target = RelationType
    TargetValue = -1
    IsSolved = False
    def Solve(self, sentences):
        result = ""
        if len(sentences)==0:
            result = "Есеп мәтіні берлімеген"
        result += "<div id=\"resultdiv\">"
        
        for sentence in sentences:
            result += str(sentences.index(sentence)) +"-сөйлем. <br/>"
            self.FindConditions(self,sentence)
        return result
    def FindConditions(self, sentence):
        index = 0
        for word in sentence:
            relation = self.CheckToRelation(word.Root)
            if relation:
                print(relation)
            index+=1
    def CheckToRelation(word):
        for relation in Relaions:
            if word == relation.NameInKaz:
                return relation.Name
        return None