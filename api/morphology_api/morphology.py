Seperators = [' ', '+', '-', '×', '*', '/', '=', '≠', '<', '≤', '>', '≥', '˄', '˅', '⁒', '→', '≈']
Punctuations = ['.', ',', ':', ';', '?', '!', '…']
SentenceSeperators = ['. ', '! ', '? ', '; ', '... ']
OpeningBrackets = ['(',  '[',  '{',  '<',  '‘', '«',  '“']
ClosingBrackets = [')', ']', '}', '>', '’', '»', '”']
Parentheses = ['(', ')', '[', ']', '{', '}', '<', '>', '‘', '’', '«', '»', '“', '”']
kaz_stop_words = []

import copy
from nltk.tokenize import word_tokenize
from pprint import pprint

from numpy import true_divide

from .ilsmodels import Task
from .appendix import Septik, Ending, Appendix
from .phonetic import phonetic
import json
import re
import sqlite3
from .word import Word
import psycopg2

def get_db_connection():
    conn = psycopg2.connect(
            host="localhost",
            database="userdb",
            user='postgres',
            password='magzhan2005')
    return conn


def is_soft(word) : 
    for s in word:
        if s in phonetic.soft_voewls:
            return True
    return False
def is_vowel(c):
    return c in phonetic.soft_voewls or c in phonetic.hard_vowels 

class Lemms:
       
    def to_case(word, case_num):
        app = ""
        if case_num == 2 :
            if is_soft(word) and is_vowel(word[-1]):
                return "ге"
            if not(is_soft(word)) and is_vowel(word[-1]):
                return "ға"
            vowel = 'а'
            cons = 'ғ'
            if not(is_vowel(word[-1])):
                if word[-1] in ['т', 'к', 'п','ш', 'c']:
                    cons = 'к' 
                else:
                    cons = 'г'
            if is_soft(word):
                vowel = 'е'
            app = cons + vowel
        return word + app

    def init(self):
        super._init_(self)

    def is_number(s):
        try:
            float(s.encode('ascii', 'ignore'))
            return True
        except ValueError:
            return False
    def has_value(s):
        return s in [u'аудан', u'ұзындық', u'периметр', u'ен']


    class Descriptions:
        INT = 'INT'
        REAL = 'REAL'
        WORD = 'WORD'
        FAM = 'FAM'


    def IsInteger(number):
        return number.isdigit()


    def IsReal(number):
        number = number.replace(',', '.')
        try:
            float(number)
            return True
        except ValueError:
            return False


    def IsFam(token):
        #ToDo
        return False


    def IsAlphanumericChain(number):
        if re.match("^[A-Za-z0-9]*$", number):
            return True
        return False


    def getTokens(sentenceText):
        description = 'description'
        sentence = 'sentence'
        result = {}
        result['sentence'] = []
        splitTemplate = ' | '.join(Seperators)
        notProcessedTokens = re.split(splitTemplate, sentenceText)

        for token in notProcessedTokens:
            word = {}
            word['token'] = token
            word[description] = Descriptions.WORD
            if (IsInteger(token)):
                word[description] = Descriptions.INT
                result[sentence].append(word)
                continue
            if (IsReal(token)):
                word[description] = Descriptions.REAL
                result[sentence].append(word)
                continue
            if (IsFam(token)):
                word[description] = Descriptions.FAM
                result[sentence].append(word)
                continue
            result[sentence].append(word)
        return result


    def getSentences(paragraphText):
        paragraph = 'paragraph'
        result = {}
        result[paragraph] = []

        splitTemplate = ' | '.join(SentenceSeperators)
        notProcessedSentences = re.split(splitTemplate, paragraphText)
        for sentenceText in notProcessedSentences:
            result[paragraph].append(getTokens(sentenceText))
        return result


    def getParagraphes(mainText):
        text = 'text'
        result = {}
        result[text] = []

        splitTemplate = '\n'
        notProcessedText = re.split(splitTemplate, mainText)
        for paragraphText in notProcessedText:
            if len(paragraphText) > 0:
                result[text].append(getSentences(paragraphText))
        return result


    def cleanText(text):
        return text.replace('\ufeff', '')


    def change_syngor(self, symbol):
        if symbol == 'г':
            return u'к'
        if symbol == 'ғ':
            return u'қ'
        if symbol == 'б':
            return u'п'
        if symbol == u'ю':
            return u'й'
        return symbol

    def get_pos_names(self, pos):
        PosName = ""
        if pos == 1:
            PosName = "N"
        elif pos == 2:
            PosName = "Adj"
        elif pos == 3:
            PosName = "NUM"
        elif pos == 4:
            PosName = "Prnn"
        elif pos == 5:
            PosName = "V"
        elif pos == 6:
            PosName = "Onmt"
        elif pos == 7:
            PosName = "INTERJ"
        elif pos == 8:
            PosName = "FW"
        elif pos == 9:
            PosName = "ADV"
        return PosName

    def get_pos_tag_names(self, pos):
        PosName = ""
        if pos == 1:
            PosName = "Зат есім"
        elif pos == 2:
            PosName = "Сын есім"
        elif pos == 3:
            PosName = "Сан есім"
        elif pos == 4:
            PosName = "Есімдік"
        elif pos == 5:
            PosName = "Етістік"
        elif pos == 6:
            PosName = "Еліктеуіш"
        elif pos == 7:
            PosName = "Одағай"
        elif pos == 8:
            PosName = "Шылау"
        elif pos == 9:
            PosName = "Үстеу"
        return PosName

    def get_kaz_lemms(self, sentences):
        con = get_db_connection()
        cur = con.cursor()
        token_list = []
        lemms_list = []
        for sentence in sentences:
            #sentence = sentence.replace("-", " ")
            lemms = []
            tok = []
            words = []
            tokens = word_tokenize(sentence)
            print('word_tokenize:', tokens)
            for token in tokens:
                #print(token)
                token = token.lower()
                if token == "оның":
                    token = "олның"
                if token == "сенің":
                    token = "сеннің"
                if token == "менің":
                    token = "меннің"
                if (token in [u'.', u',']):
                    continue
                sttoken = token
                if self.is_number(sttoken):
                    tok.append(u"".join(sttoken))
                    lemms.append([u"".join(sttoken), self.get_pos_names(self,3),[],u"".join(sttoken), ''])
                    continue
                token_found = False
                token = token.lower()
                while len(token) > 0:
                    token = token[:-1] + self.change_syngor(self, token[-1:])
                    cur.execute("SELECT words, pos FROM synamizer WHERE words = %s", (token,))
                    for result in cur.fetchall():
                        if (not(token in kaz_stop_words)):
                            tok.append(u"".join(result[0]))
                            app = Septik
                            appendix = sttoken[len(token):]
                            # print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;')
                            # print('result, ' + str(result[1]))
                            words.append(Word(result[0], int(result[1]), appendix, False))
                            words[-1].GetAppendixes()
                            endings = []
                            endsStr = ""
                            for app in words[-1].Appendixes:

                                endings.append([app.AppendixString, app.AppName, app.PosName])
                                endsStr += app.AppName + "."
                            lemms.append(
                                [sttoken, self.get_pos_names(self, int(result[1])), endings.copy(), result[0], endsStr])
                            endings.clear()
                            token_found = True
                            break

                    token = token[:len(token)-1]
                if not(token_found):
                    if (not(sttoken in kaz_stop_words) & (sttoken != u'.')):
                        lemms.append([u"".join(sttoken), -1])
                        tok.append(u"".join(sttoken))
            token_list.append(copy.copy(tok))
            lemms_list.append(copy.copy(lemms))
        con.close()
        print('lemms_list: ', lemms_list)
        return lemms_list
    def solve_math_task(self, sentences):
        con = get_db_connection()
        cur = con.cursor()
        token_list = []
        lemms_list = []
        sentences_list = []
        for sentence in sentences:
            #sentence = sentence.replace("-", " ")
            lemms = []
            tok = []
            words = []
            
            tokens = word_tokenize(sentence)
            for token in tokens:
                #print(token)
                token = token.lower()
                if token == "оның":
                    token = "олның"
                if token == "сенің":
                    token = "сеннің"
                if token == "менің":
                    token = "меннің"
                if (token in [u'.', u',']):
                    continue

                sttoken = token
                if self.is_number(sttoken):
                    tok.append(u"".join(sttoken))
                    lemms.append([u"".join(sttoken), self.get_pos_names(self,3),[],u"".join(sttoken), ''])
                    words.append(Word(u"".join(sttoken),3,u'', False))
                    continue
                token_found = False
                token = token.lower()
                while len(token) > 0:
                    token = token[:-1] + self.change_syngor(self, token[-1:])
                    cur.execute("Select morphem, pos from morphemes where morphem = %s", (token,))
                    for result in cur.fetchall():

                        if (not(token in kaz_stop_words)):
                            tok.append(u"".join(result[0]))
                            app = Septik
                            appendix = sttoken[len(token):]
                            words.append(Word(result[0], int(result[1]), appendix, self.has_value(result[0])))
                            words[-1].GetAppendixes()
                            endings = []
                            endsStr = ""
                            for app in words[-1].Appendixes:

                                endings.append([app.AppendixString, app.AppName, app.PosName])
                                endsStr += app.AppName + "."
                            lemms.append(
                                [sttoken, self.get_pos_names(self, int(result[1])), endings.copy(), result[0], endsStr])
                            endings.clear()
                            token_found = True
                            break

                    token = token[:len(token)-1]
                if not(token_found):
                    if (not(sttoken in kaz_stop_words) & (sttoken != u'.')):
                        lemms.append([u"".join(sttoken), -1])
                        tok.append(u"".join(sttoken))
            sentences_list.append(words)
            token_list.append(copy.copy(tok))
            lemms_list.append(copy.copy(lemms))
        con.close()
        task = Task
        task.Solve(task,sentences_list)
        return lemms_list
    def get_expert_words(self):
        list = []
        con = get_db_connection()
        cursor = con.cursor()
        query = 'SELECT id, morphem, pos FROM morphemes WHERE isModerated = 0'
        cursor.execute(query)
        for result in cursor.fetchall():
            pos = self.get_pos_names(self, result[2])
            list.append([result[0], result[1], pos])

        return list

    def get_morphemes_from_db(self):
        arr = {}
        list = []
        posCountList = []
        con = get_db_connection()
        cursor = con.cursor()
        query = 'SELECT * FROM morphemes'
        cursor.execute(query)
        for result in cursor.fetchall():
            pos = ""
            if (result[2]):
                pos = self.get_pos_tag_names(self, result[2])
            list.append([result[0], result[1], result[2], pos])
        query1 = 'SELECT * FROM morphemes WHERE isModerated = 1'
        query2 = 'SELECT * FROM morphemes WHERE isModerated = 0'
        for x in range(1, 9):
            query3 = 'SELECT count(*) FROM morphemes WHERE pos = ' + str(x)
            posName = self.get_pos_tag_names(self, x)
            cursor.execute(query3)
            for res in cursor.fetchall():
                posCountList.append([posName, res[0]])

        arr['all'] = list
        arr['posCount'] = posCountList
        return arr

    def get_all_morphemes(self):
        arr = {}
        list = []
        con = get_db_connection()
        cursor = con.cursor()
        query = 'SELECT * FROM morphemes ORDER BY morphem DESC'
        cursor.execute(query)
        for result in cursor.fetchall():
            pos = self.get_pos_names(self, result[2])
            list.append([result[0], result[1], pos, result[0]])

        arr['data'] = list
        return list


