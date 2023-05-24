from enum import Enum
from .enums import Alphabet


class TextHelper:
    #жұрнақтар
    NamesToNoun = "есімдерден зат есім"
    MimicsToNoun = "елікеуіштен зат есім"
    VerbsToNoun = "етістіктен зат есім"
    NounsToAdjective = "зат есімнен сын есім"
    VerbsToAdjectives = "етістіктен сын есім"
    NamesToVerbs = "есімдерден етістік"
    VerbsToVerbs = "етістіктен етістік"
    #үндестікке байланысты түзетулер
    VerbsFromVerbs = "етістіктен жасалған етістіктер"
    AdjectivesFromNouns = "зат есімнен жасалған сын есімдер"
    Taueldik = "ттәуелдік жалғауы жалғануына байланысты"
    #жалғаулар
    FirstStepJiktik = "І-жақ жіктік"
    SecondStepJiktik = "ІІ-жақ жіктік"
    ThirdStepJiktik = "ІІІ-жақ жіктік"
    FirstStepTaueldik = "І-жақ тәуелдік"
    SecondStepTaueldik = "ІІ-жақ тәуелдік"
    ThirdStepTaueldik = "ІІІ-жақ тәуелдік"

    class JikteuEsimdikteri(Enum):
        мен = 1
        сен = 2
        сіз = 3
        ол = 4
        біз = 5
        сендер = 6
        сіздер = 7
        олар = 8
    class Kosemshe:
        ып = 1 
        іп= 2 
        п= 2 
        а=3
        е=4
        й=5
        ғалы =6  
        гелі = 7
        қалы = 8
        келі = 9 
        ғанша = 10
        генше = 11
        қанша = 12
        кенше = 13
        майынша =14
        мейінше = 15

    Undefined = "анықталмады"

    #<summary>
    #Мәтінді сөздерге бөлу
    #</summary>
    #<param name="text">Мәтін</param>
    #<returns>Сөздер тізбегі</returns>
    @staticmethod
    def GetWords(text):
        # Split the text into words based on punctuation marks and separators
        punctuation_marks = ['.', '!', '"', ';', ':', '/', '?', ',', '@', ' ', '-']
        words = [word for word in text.split() if word not in punctuation_marks]

        # Remove any empty strings from the list of words
        words = list(filter(None, words))

        # Return the list of words
        return words

    # <summary>
    # Мәтінді сөйлемдерге бөлу
    # </summary>
    # <param name="text">Мәтін</param>
    # <returns>Сөйлемдер тізбегі</returns>
    @staticmethod
    def GetSentences(text):
        # Split the text into sentences based on the period ('.') delimiter
        sentences = [sentence for sentence in text.split('.') if sentence]

        # Return the list of sentences
        return sentences
    @staticmethod
    def GetSyllable(words):
        syllables = []
        for word in words:
            w = []
            s = ''
            char_index = 0
            for c in word:
                if char_index == 0:
                    s += c
                    if len(word) == 1:
                        w.append(s)
                else:
                    if char_index < len(word) - 1:
                        if TextHelper.IsVowel(c):
                            if TextHelper.IsHasVowel(s):
                                w.append(s)
                                s = c
                            else:
                                s += c
                        else:
                            if TextHelper.IsHasVowel(s):
                                next_c = word[char_index + 1]
                                if TextHelper.IsVowel(next_c):
                                    w.append(s)
                                    s = c
                                else:
                                    s += c
                            else:
                                s += c
                    elif len(word) - 1 == char_index:
                        if TextHelper.IsVowel(c) and TextHelper.IsHasVowel(s):
                            w.append(s)
                            w.append(c)
                        w.append(s + c)
                        s = ''
                char_index += 1
            syllables.append(w)

        for syllable in syllables:
            if len(syllable) == 1:
                continue
            taueldik_index = len(syllable)
            s = syllable[-1]
            ex = ExceptionAppendixes()
            septik = Septik()
            if septik.CheckForDefinition(s) != TextHelper.Undefined:
                if TextHelper.IsVowel(syllable[taueldik_index - 2][-1]):
                    taueldik_index -= 1
                s = syllable[taueldik_index - 1]
            if ex.CheckForDefinition(s) == TextHelper.Undefined:
                continue
            if s[0] == 'с' or s == "лы" or s == "лі":
                soz = ''.join(syllable[:taueldik_index - 1])
                conn = DataExecute.CreateConnection()
                query = "SELECT DISTINCT soz FROM WordBase WHERE soz = '" + soz + "' and zat_esim = 1"
                data_reader = DataExecute.GetData(query, conn)
                if data_reader.Read():
                    continue
            if ex.CheckForDefinition(s) == TextHelper.VerbsFromVerbs:
                soz = ''.join(syllable[:taueldik_index - 1]) + ReplaceChar(s[0])
                conn = DataExecute.CreateConnection()
                query = "SELECT DISTINCT soz FROM WordBase WHERE soz = '" + soz + "' and etistik = 1"
                data_reader = DataExecute.GetData(query, conn)
                if not data_reader.Read():
                    continue
            if ex.CheckForDefinition(s) == TextHelper.Taueldik:
                syllable[taueldik_index - 2] += s[0:2]
                syllable[taueldik_index - 1] = s[2:]
                continue
            syllable[taueldik_index - 2] += ReplaceChar(s[0])
            syllable[taueldik_index - 1] = s[1:]

        return syllables
    @staticmethod
    def ToString(c):
        return str(c)
    
    @staticmethod
    def replace_char(in_char):
        if in_char == 'г':
            return 'к'
        # elif in_char == 'ғ':
        #     return 'қ'
        elif in_char == 'б':
            return 'п'
        else:
            return TextHelper.ToString(in_char)
    @staticmethod 
    def replace_char1(in_char):
        if in_char == 'г':
            return 'к'
        elif in_char == 'ғ':
            return 'қ'
        elif in_char == 'б':
            return 'п'
        elif in_char == 'к':
            return 'г'
        elif in_char == 'қ':
            return 'ғ'
        elif in_char == 'п':
            return 'б'
        else:
            return TextHelper.ToString(in_char)



    #<summary>
    #Әріптің дауысты дыбыс екендігін анықтайды
    #</summary>
    #<param name="c">Әріп</param>
    #<returns>Егер әріп дауысты дыбыс болса true мәні қайтарылады</returns>
    @staticmethod
    def IsVowel(c):
        vowels = ['а', 'ә', 'е', 'и', 'о', 'ө','ұ','ү', 'у', 'ы', 'і', 'э']
        return c.lower() in vowels
    
    #<summary>
    #Әріптер тіркесінде дауысты дыбыстың бар жоғын анықтайды
    #</summary>
    #<param name="syllable">Әріптер тіркесі</param>
    #<returns>егер дауысты дабыс бар болса true мәні қайтарылады</returns>

    @staticmethod
    def IsHasVowel(syllable):
        return any(TextHelper.IsVowel(char) for char in syllable)
    @staticmethod
    def IsException(c):
        return Alphabet.Exceptions[c.lower()] in Alphabet.Exceptions.__members__
    
    @staticmethod
    def isCatan(c):
        return c.lower() in [char.value.lower() for char in Alphabet.Catan]
    @staticmethod
    def isUyan(c):
        return c.lower() in [char.value.lower() for char in Alphabet.Uyan]
    
    @staticmethod
    def isUndi(c):
        return c.lower() in [char.value.lower() for char in Alphabet.Undi]
    
    @staticmethod
    def isJuan(c):
        return c.lower() in [char.value.lower() for char in Alphabet.JuanDauysty]
    
    @staticmethod
    def isHasJuan(soz):
        return any(TextHelper.isJuan(c) for c in soz)
    
    @staticmethod
    def restoreReductions(text):
        text = text.replace("#t", "...")
        return text

    def replaceReductions(text):
        text = text.replace("т.б.", "тағы басқа")
        text = text.replace("...", "#t.")
        text = text.replace("т.с.с.", "тағы сол сияқты")
        text = text.replace(".", "*.")
        text = text.replace("!", "!.")
        text = text.replace("?", "?.")
        text = text.replace(";", ";.")
        return text










