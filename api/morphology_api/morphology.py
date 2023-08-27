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
from Morphological_analyser_based_on_CSE.Morf_analysis_for_Kazakh import GodsHelp
from numpy import true_divide

from phonetic_api.phonectic import Phonetic
# from appendix import *
from .appendix import *
from .ilsmodels import Task
from .appendix import Septik
import re
from .word import Word
from db import *

def clear_word(input_string):
    pattern = r'\*(.*?)<'
    matches = re.findall(pattern, input_string)
    new_array = [input_string.split('+')[0]]+matches
    return new_array


class Morphology:
    def change_conjunction(preceding_word, conjuction):
        """
        жалғаулық алдыңғы сөздің аяқталуына орай шылауды ауыстырады
        """
        if conjuction in ["мен", "бен", "пен"]:
            if Phonetic.is_vowel(preceding_word[-1]) or Phonetic.is_sonorat_consonant((preceding_word[-1])) :
                return "мен"
            elif preceding_word[-1] in ["ж", "з"]:
                return "бен"
            elif Phonetic.is_strict_consonant(preceding_word[-1]):
                return "пен"
        return conjuction
class Lemms:
    instance = None
    @classmethod
    def get_instance(cls):
        if cls.instance is None:
            cls.instance = Lemms()
        return cls.instance
    def to_case(word, case_num):
        app = ""
        if case_num == 2 :
            if Phonetic.is_soft(word) and Phonetic.is_vowel(word[-1]):
                return "ге"
            if not(Phonetic.is_soft(word)) and Phonetic.is_vowel(word[-1]):
                return "ға"
            vowel = 'а'
            cons = 'ғ'
            if not(Phonetic.is_vowel(word[-1])):
                if word[-1] in ['т', 'к', 'п','ш', 'c']:
                    cons = 'к' 
                else:
                    cons = 'г'
            if Phonetic.is_soft(word):
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
    def change_syngor_reverse(self, symbol):
        if symbol == 'к':
            return u'г'
        if symbol == 'қ':
            return u'ғ'
        if symbol == 'п':
            return u'б'
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
    
    @staticmethod
    def get_pos_names_custom(pos):
        if pos is None:
            return pos
        if pos == "N":
            return 1
        elif pos == "Adj":
            return 2
        elif pos == "NUM":
            return 3
        elif pos == "Prnn":
            return 4
        elif pos == "V":
            return 5
        elif pos == "Onmt":
            return 6
        elif pos == "INTERJ":
            return 7
        elif pos == "FW":
            return 8
        elif pos == "ADV":
            return 9
        
    def get_kaz_lemms_test(self, sentences, length, ml):
        main_list = copy.deepcopy(ml)
        # print("mд=",main_list)

        if main_list[0][0][1] == -1:
            return main_list
        main_list[0][0][2] = []
        morph_reult = GodsHelp.morphogay(sentences[0])
        list_of_parts = clear_word(morph_reult)
        # pos = Lemms.get_pos_names_custom(main_list[0][0][1])
        main_list[0][length][3] = list_of_parts[0]
        main_list[0][length][4] = ""
        endings = list_of_parts[1:]
        for ending in endings:
            definition = ""
            name = ""
            if ending in Jiktik.FirstStepSingular + Jiktik.FirstStepPlural + Jiktik.SecondStepSingular + Jiktik.SecondStepFormal + Jiktik.ThirdStep:
                definition = Jiktik.CheckForDefinition(Jiktik, ending)
                name = 'Жіктік жалғау'
            elif ending in Septik.Ilik +Septik.Barys + Septik.Atau + Septik.Jatys + Septik.Komektes + Septik.Shygys + Septik.Tabys:
                definition = Septik.CheckForDefinition(Septik, ending)
                name = 'Cептік'
            elif ending in Taueldik.FirstStepSingular + Taueldik.FirstStepPlural + Taueldik.SecondStepSingular + Taueldik.SecondStepPlural + Taueldik.ThirdStep:
                definition = Taueldik.CheckForDefinition(Taueldik, ending)
                name = 'Тәуелдік жалғау'
            elif ending in Koptik.koptik:
                definition = Koptik.CheckForDefinition(Koptik, ending)
                name = 'Көптік жалғау'
            elif ending in Suffix.AdjectivesToNoun + Suffix.NamesToNoun + Suffix.MimicsToNoun + Suffix.VerbsToNoun + Suffix.VWFI + Suffix.NounsToAdjective + Suffix.VerbsToVerbs +Suffix.VerbsToAdjective +Suffix.NamesToVerbs  +Suffix.Kosemshe+Suffix.Esimshe +Suffix.KosemsheEsimshePlusTaueldik+Suffix.VerbsToEsimshe:
                if definition == "":
                    definition = Suffix.CheckForDefinition2(Suffix,ending=ending)
                    # print("definition2:", definition)
                name = 'жұрнақ'
            main_list[0][length][2].append([ending, definition, name])
            main_list[0][length][4] = main_list[0][length][4] +  f"{definition}."
        return main_list
            
    def get_kaz_lemms(self, sentences):
        db = DB.get_instance()
        con = db.get_db_connection()
        cur = con.cursor()
        token_list = []
        lemms_list = []
        for sentence in sentences:
            lemms = []
            tok = []
            words = []
            tokens = word_tokenize(sentence)
            for token in tokens:
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
                if Lemms.is_number(sttoken):
                    tok.append(u"".join(sttoken))
                    lemms.append([u"".join(sttoken), self.get_pos_names(3),[],u"".join(sttoken), ''])
                    continue
                token_found = False
                token = token.lower()
                while len(token) > 1 and not(token_found):
                    # print(len(token) > 0 and not(token_found))
                    token = token[:-1] + self.change_syngor( token[-1:])
                    cur.execute("SELECT words, pos FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s))", (token,))
                    data = cur.fetchall()
                    if not len(data) >= 1:
                        cur.execute('''SELECT ss.synonym AS words,s.pos FROM synonyms ss
                                            INNER JOIN synonym_word sw ON ss.id = sw.synonym_id
                                            INNER JOIN synamizer s ON s.id = sw.word_id
                                            WHERE LOWER(TRIM(ss.synonym)) = LOWER(TRIM(%s))''', (token,))
                        data = cur.fetchall()
                    for result in data:
                        if (not(token in kaz_stop_words)):
                            tok.append(u"".join(result[0]))
                            app = Septik
                            appendix = sttoken[len(token):]
                            words.append(Word(result[0], int(result[1]), appendix, False))
                            words[-1].GetAppendixes()
                            # print(token)
                            # print(appendix)
                            endings = []
                            endsStr = ""
                            for app in words[-1].Appendixes:
                                endings.append([app.AppendixString, app.AppName, app.PosName])
                                endsStr += app.AppName + "."
                            lemms.append(
                                [sttoken, self.get_pos_names(int(result[1])), endings.copy(), result[0], endsStr])
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
        return lemms_list
    def solve_math_task(self, sentences):
        con = DB.get_instance().get_db_connection()
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
                    lemms.append([u"".join(sttoken), self.get_pos_names(3),[],u"".join(sttoken), ''])
                    words.append(Word(u"".join(sttoken),3,u'', False))
                    continue
                token_found = False
                token = token.lower()
                while len(token) > 0:
                    token = token[:-1] + self.change_syngor( token[-1:])
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
                                [sttoken, self.get_pos_names( int(result[1])), endings.copy(), result[0], endsStr])
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
        con = DB.get_instance().get_db_connection()
        cursor = con.cursor()
        query = 'SELECT id, morphem, pos FROM morphemes WHERE isModerated = 0'
        cursor.execute(query)
        for result in cursor.fetchall():
            pos = self.get_pos_names( result[2])
            list.append([result[0], result[1], pos])

        return list

    def get_morphemes_from_db(self):
        arr = {}
        list = []
        posCountList = []
        con = DB.get_instance().get_db_connection()
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
        con = DB.get_instance().get_db_connection()
        cursor = con.cursor()
        query = 'SELECT * FROM morphemes ORDER BY morphem DESC'
        cursor.execute(query)
        for result in cursor.fetchall():
            pos = self.get_pos_names( result[2])
            list.append([result[0], result[1], pos, result[0]])

        arr['data'] = list
        return list


