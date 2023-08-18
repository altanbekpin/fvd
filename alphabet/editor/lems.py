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
import json
import re
import sqlite3


class Lems:
    
    def _init_(self):
        super.__init__(self)

    def is_number(s):
        try:
            float(s.encode('ascii', 'ignore'))
            return True
        except ValueError:
            return False


    class Descriptions:
        INT = 'INT'
        REAL = 'REAL'
        WORD = 'WORD'
        FAM = 'FAM'


    def IsInteger(number):
        # print(number.isdigit())
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

    def get_kaz_lemms(self, sentences):
        print(self)
        con = sqlite3.connect("kasdict.db")
        cur = con.cursor()
        token_list = []
        lemms_list = []
        for sentence in sentences:
            sentence = sentence.replace(u"оның", u"олның")
            sentence = sentence.replace("-", " ")
            lemms = []
            tok = []
            tokens = word_tokenize(sentence)
            for token in tokens:
                token = token.lower()
                if (token in [u'.', u',']):
                    break
                sttoken = token
                if self.is_number(sttoken):
                    tok.append(u"".join(sttoken))
                    lemms.append([u"".join(sttoken), u'3'])
                    continue
                token_found = False
                token = token.lower()
                while len(token) > 0:
                    token = token[:-1] + self.change_syngor(self, token[-1:])

                    for result in cur.execute("Select morphem, pos from morphemes where morphem = ?", (token,)):

                        if (not(token in kaz_stop_words)):
                            tok.append(u"".join(result[0]))
                            lemms.append(
                                [u"".join(result[0]), result[1], sttoken[len(token):]])
                            token_found = True
                            break
                    if (token_found):
                        break
                    token = token[:len(token)-1]
                if not(token_found):
                    if (not(sttoken in kaz_stop_words) & (sttoken != u'.')):
                        lemms.append([u"".join(sttoken), -1])
                        tok.append(u"".join(sttoken))
            token_list.append(copy.copy(tok))
            lemms_list.append(copy.copy(lemms))
        con.close()
        return [lemms_list, token_list]
