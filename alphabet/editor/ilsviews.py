import json
from django.shortcuts import render
from nltk.tokenize import sent_tokenize as st
from editor.morphology import Lemms
from .models import Topic, Question
from django.http import HttpResponse

def ils(request):
    return render(request, 'ils.html')
def teacher(request):
    return render(request, 'teacher.html')
def get_questions(request):
    topics = Topic.objects.all()
    result = "["
    topicSeperator = ""
    for topic in topics:
        result += topicSeperator + "{"
        topicSeperator = ","
        result += "\"text\": \"" + topic.name + "\","
        result += "\"nodes\": ["
        questions = Question.objects.filter(topic = topic)
        questSeperator = ""
        for question in questions:
            result += questSeperator + "{"
            questSeperator = ","
            result += "\"text\":\"" +  question.text + "\", \"type\":" + str(question.qtype) + ","
            result += "\"href\":" + "\"javascript:GetAnswer('" + question.text +"', " + str(question.qtype)  + ");\","
            result += "\"icon\":\"fa fa-question-circle\"" 
            result += "} "
        result += "]"
        result +="}"
    result +="]"
    return HttpResponse(result)
def get_answer(request):
    text = request.POST['text']
    sentences = st(text) # тексттен сөйлемдерді бөліп аламыз
    stcs = Lemms.solve_math_task(Lemms,sentences)
    return HttpResponse(json.dumps(stcs), content_type="application/json")