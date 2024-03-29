
from morphology_api.morphology import Lemms
from nltk.tokenize import sent_tokenize as st
from db import DB
from morphology_api.appendix import Suffix, Septik, Jiktik, Taueldik, Koptik
from phonetic_api.phonectic import Phonetic
from app import app
class Finder:
    def __init__(self, _stcs,_length, word) -> None:
        self.word = word
        self._stcs = _stcs
        self._length = _length
        self._trash_part = ""
        self._synonym = ""
        self.consonantsounds = ['л', 'м', 'н', 'ң', 'з']
        self.appendixes = []
    solid = ['а', 'о', 'ы',  'я', 'ұ']
    soft = ['ә', 'ө', 'і', 'е', 'и', 'э', 'ү']
    def is_vowel(self, word):
        return word[-1] in self.solid or word[-1] in self.soft
    def get_addition(self, part, founded=[]):
        if self.isResearchable() and len(self._stcs[0][self._length])>3:
            parts = self._stcs[0][self._length][2]
            if len(part) <= 2:
                return ""
            for index, i in enumerate(parts):
                if (part in i[1]) and not(index in founded):
                    founded.append(index)
                    return i[0]
        return ''
    
    def isResearchable(self):
        return (not (len(self._stcs) == 0)) and (len(self._stcs[0][0]) > 2) and not(" " in self.word.strip())
    def get_first_part(self) -> str:
        if self.isResearchable():
            self.first_part = self._stcs[0][self._length][3]
        else:
            self.first_part = self.word
        return self.first_part.strip()
    
    def get_synonym(self):
        return self._synonym
    
    def set_synonym(self, new_synonym):
        self._synonym = new_synonym
    
    def get_family(self):
        if self.isResearchable():
            return self._stcs[0][0][1]
        return ''
    def get_buyryk(self, word):
        ending = self.get_addition("Imprv", [])
        endings = ["йын","йін", "сын","сін", "ейін",  "ңыз",   "ңіз", "ыңыз","іңіз",]
        index = endings.index(ending)
        is_soft = self.is_soft(word)
        if (is_soft and self.is_soft(ending)) or (not is_soft and not self.is_soft(ending)):
            return ending
        if is_soft:
            return endings[index+1]
        else:
            return endings[index-1]
    def get_ilik(self, word):
        ending = word[-1]
        tyntin = ['б', 'в', 'г', 'д', 'к', 'қ', 'п', 'с', 'т', 'х', 'ц', 'ч']
        nynnin = ['а', 'о', 'ы', 'і', 'е', 'я', 'м', 'н', 'ң']
        dyndin = ['ж', 'з', 'и', 'й', 'л', 'у', 'р', 'ю']
        if ending in tyntin:
            if self.is_soft(word):
                return 'тің'
            return 'тың'
        if ending in nynnin:
            if self.is_soft(word):
                return 'нің'
            return 'ның'
        if ending in dyndin:
            if self.is_soft(word):
                return 'дің'
            return 'дың'
        return self.get_addition('Gen')
    
    def isResearchable(self):
        return (not (len(self._stcs) == 0)) and (len(self._stcs[0][0]) > 2) and not(" " in self.word.strip())
        

    def get_barys(self, word, symbol, founded):
        #print("GET BARYS")
        Barys = ["ға", "ге", "қа", "ке", "на", "не", "а", "е"]
        result = self.get_addition(symbol, founded)
        is_soft = Phonetic.is_soft(word)
        if result in ["ға", "ге", "қа", "ке"]:
            if Phonetic.is_strict_consonant(word[-1]):
                if is_soft:
                    return "ке"
                else:
                    return "қа"
            else:
                if is_soft:
                    return "ге"
                else:
                    return "ға"
        if word[-1] in self.solid + self.soft and result[0] in self.solid +self.soft:
            return "й"
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))):
            return result
        index = Barys.index(result)
        if is_soft:
            result = Barys[index+1]
        else:
            result = Barys[index-1]
        #print(word)
        #print(result)
        return result

    def get_taueldy(self, depence, word):
        #print("word:", word)
        # print("depence:", depence)
        additions = [ "м", "ым", "ім", "ымыз", "іміз", "ң", "ың", "ің", "ңыз", "ыңыз", "іңіз", "сы", "сі", "ы", "і"]
        is_soft = self.is_soft(word)
        #print("is_soft:", is_soft)
        #print("is_soft(depence):", self.is_soft(depence))
        index = additions.index(depence)
        if depence in ["м"]: 
            if self.is_vowel(word[-1]):
                return "м"
        if depence in ["сы", "сі"] and self:
            if not(self.is_vowel(word)):
                   if self.is_soft(word):
                       return "і" 
                   else:
                       return "ы"
            
        if depence in ['ы', 'і'] and word[-1] not in self.solid + self.soft:
            if self.is_soft(word):
                return 'і'
            return 'ы'
        if depence in ["ың", "ің", "ң"]:
            if Phonetic.is_vowel(word[-1]):
                return "ң"
            else:
                if Phonetic.is_soft(word):
                    return "ің"
                else:
                    return "ың"
        
        if not(word[-1] in self.soft + self.solid + ["я"] and depence[0] in self.soft + self.solid) and (is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))):
            if self.get_synonym()[-1] in ['к'] and depence[0] in ['і']:
                self.set_synonym(self.get_synonym()[:-1] + "г")
            return depence
        if (word[-1] in self.soft + self.solid + ["я"] and depence[0] in self.soft + self.solid):
            i = 0
            while(index+i != len(additions)-1):
                i += 1
                depence = additions[index+i]
                if (is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))) and depence not in self.solid + self.soft:
                    return depence
        #print("DEPENCE:".upper(), depence)
        if (word[-1] in self.soft + self.solid + ["я"] and depence[0] in self.soft + self.solid):
            i = 0
            #print("HEREEE")
            while(index-i != -1):
                i += 1
                depence = additions[index-i]
                #print("depence:", depence)
                if (is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))) and depence not in self.solid + self.soft:
                    return depence
        #print("is_soft(depence):", self.is_soft(depence))
        #print("is_soft:", is_soft)
        if not(is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))):
            #print("I;m here")
            if is_soft:
                depence = additions[index+1]
            else:
                depence = additions[index-1]
        if word[-1] == "қ":
            i = 0
            while(not(depence in self.soft + self.solid) and index+i != len(additions)-1):
                #print(i)
                depence = additions[index+i]
                i += 1
            #print("self.get_synonym()[:-1]:", self.get_synonym()[:-1]+"ғ")
            self.set_synonym(self.get_synonym()[:-1]+"ғ")
            #print("self.get_synonym():", self.get_synonym())
        #print("AT THE END")
        # print(depence)
        return depence
    def get_couple(self, char):
        if char == 'п':
            return 'б'
        if char == 'б':
            return 'п'
        if char == 'ф':
            return 'в'
        if char == 'в':
            return 'ф'
        if char == 'к':
            return 'г'
        if char == 'г':
            return 'к'
        if char == 'қ':
            return 'ғ'
        if char == 'ғ':
            return 'қ'
        # if char == 'т':
        #     return 'д'
        if char == 'д':
            return 'т'
        if char == 'з':
            return 'с'
        if char == 'щ':
            return 'ж'
        if char == 'ж':
            return 'ш'
        return char
    def get_yryqsyz_etis(self, suffix_name, suffix):
        # л - анықтал, жүктел, қамал, 
        # ыд - жабыл, табыл, соғыл, 
        # іл - төгіл, сөгіл, көсіл, шешіл
        # н - белгілен, сабалан, таран
        return suffix_name == "VerbsToVerbs" and suffix in Suffix.YryqsyzEtis
    def get_suffix(self, symbol, word, founded):
        is_soft = self.is_soft(word)
        result = self.get_addition(symbol, founded)
        suffix = self.suffix_helper(symbol)
        index = suffix.index(result)
        noise = self.solid + self.soft
        if word[-1] == "р" and result == "та":
            if is_soft:
                return "ле"
            return "ла"
        # print(result)
       
        if symbol == "NamesToVerbs":
            if result in ["да", "де", "та", "те"]:
                if word[-1] in self.consonantsounds:
                    if self.is_soft(word):
                        return "де"
                    else:
                        return "да"
                elif Phonetic.is_vowel(word[-1]):
                    if self.is_soft(word):
                        return "ле"
                    else:
                        return "ла"
                else:
                    if self.is_soft(word):
                        return "те"
                    else:
                        return "та"
            if result in ["лан", "лен"]:
                if self.is_vowel(word[-1]):
                    if self.is_soft(word):
                        return "лен"
                    else:
                        return "лан"
                elif word[-1] in self.consonantsounds:
                    if self.is_soft(word):
                        return "ден"
                    else:
                        return "дан"
                else:
                    if self.is_soft(word):
                        return "тен"
                    else:
                        return "тан"
        if (symbol == "NounsToAdjective" and result in ["ды", "ді", "ты", "ті"]):
            if Phonetic.is_vowel(word[-1]):
                if self.is_soft(word):
                    return "ні"
                else:
                    return "ны"
            if word[-1] in Phonetic.strict_consonants:
                if self.is_soft(word):
                    return "ті"
                else:
                    return "ты"
            else:
                if self.is_soft(word):
                    return "ді"
                else:
                    return "ды"
        if self.get_yryqsyz_etis(symbol,result):
            if result == "л":
                if len(word)>2 and word[-2] in ["д"] and self.is_vowel(word[-1]):
                    return "н"
                if self.is_vowel(word[-1]):
                    return "л" 
                elif Phonetic.is_soft(word[-1]):
                    return app.is_exists_in_vocab(word, ["ін", "іл"])
                else:
                    return app.is_exists_in_vocab(word, ["ын", "ыл"])
                    
                    
            if result == "н" and word[-1] in ['а','е']  and word [-2] in ['т', 'м']:
                return "л"
            elif not(Phonetic.is_vowel(word[-1])): 
                if Phonetic.is_soft(word[-1]):
                    return "іл"
                else: 
                    return "ыл"
            if result == "н" and word [-1] in ['т']:
                if self.is_soft(word):
                    return "іл"
                else: return "ыл"
        if symbol == "NamesToNoun":
            if result in ["дық", "дік", "тық", "тік"] and self.is_vowel(word[-1]):
                if self.is_soft(word):
                    return "лік" 
                else:
                    return "лық" 
        if symbol == "VerbsToEsimshe":
            if result in ["қан", "кен"]:
                if word[-1] in self.consonantsounds:
                    if self.is_soft(word):
                        return "ген" 
                    else:
                        return "ған"
            if result in ["атын", "етін"]:
                if self.is_vowel(word[-1]):
                    if self.is_soft(word):
                        return "йтын" 
                    else:
                        return "йтін" 
            if result in ["йтын", "йтін"]:
                if not(self.is_vowel(word[-1])):
                    if self.is_soft(word):
                        return "етін" 
                    else:
                        return "атын" 
            if is_soft and self.is_soft(result) or (not is_soft and not self.is_soft(result)):
                return result
            else:
                if is_soft:
                    return suffix[suffix.index(result)+1]
                return suffix[suffix.index(result)-1]
        if self.get_first_part()[-1] == word[-1] and ((self.is_soft(self.get_first_part()) and is_soft) or (not self.is_soft(self.get_first_part()) and not is_soft)):
            return result
        if result in Suffix.NounsToAdjective and word[-1] == "м":
            if is_soft:
                return 'дік'
            return 'дық'
        if result == "у":
            return "у"
        
        if (word[-1] in noise) and (result[0] in noise):
            #print("NOISE")
            for i in range(index, len(suffix)):
                if suffix[i][0] not in noise:
                    return suffix[i]
        # синонимнің соңғы әрібі мен қосымшаның басқы әрібі дауыссыздар болса
        if not(self.is_vowel(result[0]) or self.is_vowel(word[-1])):
            if not(result[0] in self.consonantsounds and word[-1] in self.consonantsounds):
                if result[0] in 'л' and word[-1] in ['қ']:
                    result = "т" + result[1:]
                    if result[-1] == 'к':
                        result = result[:-1] + "қ"
                    return result
            if result[0] in self.consonantsounds and word[-1] in ['т','п']:
                return self.get_couple(result[0]) + result[1:]
            if word[-1] in self.consonantsounds and result[0] in ['т','п']:
                return self.get_couple(result[0]) + result[1:]
        if result in ["ба", "бе"] and word[-1] in ['л', 'р']:
            return'м' + result[1:]

        if result in ["ма", "ме", "па", "пе"] and word[-1] in ['з']:
                result = 'б' + result[1:]
        if symbol == "Kosemshe":
            if result in ["а", "е", "й"]:
                if Phonetic.is_vowel(word[-1]):
                    return "й"
                elif  Phonetic.is_soft(word):
                    return "e"
                else: 
                    return "а"
            if result in ["ып", "іп", "п"]:
                if Phonetic.is_vowel(word[-1]):
                    return "п"
                elif Phonetic.is_soft(word):
                    return "іп"
                else: 
                    return "ып"
            if result in ["ғалы", "гелі", "қалы", "келі"]:
                if Phonetic.is_strict_consonant(word[-1]):
                    if Phonetic.is_soft(word):
                        return "келі"
                    else: 
                        return "қалы"
                else:
                    if Phonetic.is_soft(word):
                        return "гелі"
                    else: 
                        return "ғалы"
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))) and result != word[-1] and not(word[-1] in ["і", 'р'] and result[0] in ['т', 'н']):
            if (self.get_synonym()[-1] in ['т'] and result[0] in ['д']) or (self.get_synonym()[-1] in ['д'] and result[0] in ['т']):
                if result[0] in ['д']:
                    result = "т" + result[1:]
                elif result[0] in ['т']:
                    result = "д" + result[1:]
            #print("RETURNING:", result)
            return result
        
        
        if symbol == "VerbsToVerbs":
            return result
        if is_soft and index+1<len(suffix):
            result = suffix[index+1]
        elif not(is_soft):
            result = suffix[index-1]
        if result[0] == "й" and word[-1] not in self.solid + self.soft:
            i = 0
            while(not(is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))) or result[0] == "й") and index - i != -1:
                i += 1
                result = suffix[index - i]
        #print("word:", word[-1])
        #print("result:", result[0])

        if word[-1] in ["і", 'р'] and result[0] in ['т', 'н', 'ы']:
            i = 0
            #print("fuck".upper())
            while(result[0] in ['т', 'н'] or not(is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result))))):
                i += 1
                result = suffix[index + i]
        # couples = [ 'п','б', 'ф','в', 'к','г', 'қ','ғ', 'т','д', 'с','з', 'ш','ж']
        # if word[-1] in couples and result[0] in couples:
        #     result = self.get_couple(result[0]) + result[1:]
        #print("word2:", word)
        #print("result2:", result)
        return result
    
    def suffix_helper(self, symbol):
        if symbol == "AdjectivesToNoun":
            return Suffix.AdjectivesToNoun
        if symbol == "NamesToNoun":
            return Suffix.NamesToNoun
        if symbol == "MimicsToNoun":
            return Suffix.MimicsToNoun
        if symbol == "VerbsToNoun":
            return Suffix.VerbsToNoun
        if symbol == "VWFI":
            return Suffix.VWFI
        if symbol == "NounsToAdjective":
            return Suffix.NounsToAdjective
        if symbol == "VerbsToAdjective":
            return Suffix.VerbsToAdjective
        if symbol == "NamesToVerbs":
            return Suffix.NamesToVerbs
        if symbol == "VerbsToVerbs":
            return Suffix.VerbsToVerbs
        if symbol == "Kosemshe":
            return Suffix.Kosemshe
        if symbol == "Esimshe":
            return Suffix.Esimshe
        if symbol == "KosemsheEsimshePlusTaueldik":
            return Suffix.KosemsheEsimshePlusTaueldik
        if symbol == "VerbsToEsimshe":
            return Suffix.VerbsToEsimshe
    def get_tabys(self, word):
        ending = word[-1]
        #print("WORD:", word)
        #print(ending)
        tyti = ['б', 'в', 'г' ,'д', 'к' ,'қ' ,'п' ,'с' ,'т' ,'х' ,'ц' ,'ч','ф']
        nyni = ['а', 'о', 'ы', 'і',  'я', 'е']
        dydi = ['ж' ,'з', 'й', 'м', 'н', 'ң', 'л', 'у', 'р', 'ю', ]
        second_form = self.get_second_form()
        if second_form == 'POSS.3SG':
            return 'н'
        if ending in tyti:
            if self.is_soft(word):
                return 'ті'
            return 'ты'
        if ending in nyni:
            if self.is_soft(word):
                return 'ні'
            return 'ны'
        if ending in dydi:
            if self.is_soft(word):
                return 'ді'
            return 'ды'
        
        return self.get_addition('Acc')
        
    def get_jatys(self, word, founded):
        symbol = 'Loc'
        Jatys = Septik.Jatys
        result = self.get_addition(symbol, founded)
        is_soft = self.is_soft(word)
        if result in ["да", "де", "та", "те"]:
            if Phonetic.is_strict_consonant(word[-1]):
                if self.is_soft(word):
                    return "те"
                else:
                    return "та"
            else: 
                if self.is_soft(word):
                    return "де"
                else:
                    return "да"    
        if result in ["нда", "нде"]:
            if not(Phonetic.is_vowel(word[-1])):
                if Phonetic.is_soft(word):
                    return "інде"
                else:
                    return "ында"
                    
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))):
            return result
        index = Jatys.index(result)
        if is_soft:
            result = Jatys[index+1]
        else:
            result = Jatys[index-1]
        return result
    
    def get_shygys(self, word):
        nannen = ['м','н', 'ң','ы', 'і']
        danden = ['а', 'ә', 'о', 'ө', 'е',  'ұ', 'ү', 'и', 'э', 'р', 'у', 'й', 'л', 'з', 'ж']
        tanten = ['б','в','г','д', 'п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч', 'һ']
        is_soft = self.is_soft(word)
        ending = word[-1]
        if ending in nannen:
            if is_soft:
                return 'нен'
            return 'нан'
        if ending in danden:
            if is_soft:
                return 'ден'
            return 'дан'
        if ending in tanten:
            if is_soft:
                return 'тен'
            return 'тан'
        
        return self.get_addition('Abl')

    def get_komektes(self, word):
        ending = word[-1]
        men = ['а', 'ә', 'о', 'ө', 'е', 'ы', 'і', 'ұ', 'ү', 'и', 'э', 'р', 'л', 'й', 'у', 'м', 'н', 'ң']
        ben = ['з', 'ж']
        pen = [ 'п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч', 'һ', 'б','в','г','д' ]
        if ending in men:
            return 'мен'
        if ending in ben:
            return 'бен'
        if ending in pen:
            return 'пен'
        return self.get_addition('Inst')
        
    def get_jiktik(self, word, ending):
        #print("***************")
        jiktik = self.get_addition(ending, [])
        #print("WORD:", word)
        #print(jiktik)
        if self.is_soft(word) and self.is_soft(jiktik):
            return jiktik
        if (not self.is_soft(word)) and (not self.is_soft(jiktik)):
            return jiktik
        additions = Jiktik.FirstStepSingular + Jiktik.FirstStepPlural + Jiktik.SecondStepSingular + Jiktik.SecondStepFormal + Jiktik.ThirdStep
        index = additions.index(jiktik)
        if self.is_soft(word):
            return additions[index+1]
        else:
            return additions[index-1]
        
        
    def get_plural(self, word):
        #print("INSIDE PLURAL")
        if word.strip() == "":
            return ""
        ending = word.strip()[-1]
        consonantsounds = ['л', 'м', 'н', 'ң', 'з']
        tarter = ['п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч' ,'һ', 'д']
        larler = ['й', 'р', 'а', 'ә', 'о', 'ө', 'е', 'ы', 'і', 'ұ', 'ү' ,'и' ,'э', 'б', 'я', 'ю']
        if ending in larler:
             if self.is_soft(word):
                return 'лер'
             return 'лар'
        elif ending in tarter:
             if self.is_soft(word):
                return 'тер'
             return 'тар'
        elif ending in consonantsounds:
             if self.is_soft(word):
                return 'дер'
             return 'дар'
        return ''
        
    def is_soft(self, word):
        # soft_count = 0
        # solid_count = 0
        # for k,i in enumerate(word):
        #     if i in self.soft:
        #         soft_count += 1
        #     elif i == 'у':
        #         if word[k-1] not in self.solid + self.soft:
        #             solid_count += 1
        #     elif i in self.solid:
        #         solid_count += 1
        # return soft_count >= solid_count
        for item in word[::-1]:
            if item in self.soft:
                return True
            if item in self.solid:
                return False
        return False
    
    def get_trash_part(self):
        return self._trash_part
    
    def set_trash_part(self, trash):
        self._trash_part = trash
    
    def get_second_form(self):
        for i in self._stcs[0][self._length][2]:
            if 'POSS' in i[1]:
                return i[1]
        return ''
    
    def have_part(self, symbol):
        return symbol in self._stcs[0][self._length][4].split('.')
    
    def add_correct_remainder(self, remainder):
        definition = ''
        name = ''
        suffix = Suffix.AdjectivesToNoun + Suffix.NamesToNoun + Suffix.MimicsToNoun + Suffix.VerbsToNoun + Suffix.VWFI + Suffix.NounsToAdjective + Suffix.VerbsToAdjective +Suffix.NamesToVerbs + Suffix.VerbsToVerbs +Suffix.Kosemshe+Suffix.Esimshe +Suffix.KosemsheEsimshePlusTaueldik+Suffix.VerbsToEsimshe
        if remainder in suffix:
            definition = Suffix.CheckForDefinition(Suffix,ending=remainder, pos=Word.get_pos_names(self.get_family()))
            if definition == "":
                definition = Suffix.CheckForDefinition2(Suffix,ending=remainder)
            name = 'жұрнақ'
        septik = Septik.Ilik +Septik.Barys + Septik.Atau + Septik.Jatys + Septik.Komektes + Septik.Shygys + Septik.Tabys
        if remainder in septik:
            definition = Septik.CheckForDefinition(Septik,ending=remainder)
            name = 'Cептік'
        jiktik =Jiktik.FirstStepSingular + Jiktik.FirstStepPlural + Jiktik.SecondStepSingular + Jiktik.SecondStepFormal + Jiktik.ThirdStep
        if remainder in jiktik:
            definition = Jiktik.CheckForDefinition(Jiktik,ending=remainder)
            name = 'Жіктік жалғау'
        taueldik = Taueldik.FirstStepSingular + Taueldik.FirstStepPlural + Taueldik.SecondStepSingular + Taueldik.SecondStepPlural + Taueldik.ThirdStep
        if remainder in taueldik:
            definition = Taueldik.CheckForDefinition(Taueldik,remainder)
            name = 'Тәуелдік жалғау'
        koptik = Koptik.koptik
        if remainder in koptik:
            definition = Koptik.CheckForDefinition(Koptik,remainder)
            name = 'Көптік жалғау'
        if(name == ""):
            self.set_trash_part(remainder)
        self._stcs[0][self._length][2].append([remainder, definition, name])
        self._stcs[0][self._length][4] = self._stcs[0][self._length][4] + f"{definition}."
        

            
    

class Word(Finder):
    def __init__(self, word, synomized_count, synonyms) -> None:
        self.word = word.lower()
        sentences = st(word)
        temp = Lemms.get_instance().get_kaz_lemms(sentences)
        self._stcs = temp
        # self._stcs = Lemms.get_instance().get_kaz_lemms_test(sentences, self.get_length(),temp)
        # if not(self._stcs[0][0][1] == -1) and len(self._stcs[0][0][2]) == 0:
        #     self._stcs = temp
        self._length = self.get_length()
        self.synomized_count = synomized_count
        self._synonyms = synonyms
        self._ending = word[-1]
        self.first_part = ''
        self._plural = ''
        self.first_synonym = ''
        self.is_in_possesive = False
        self.possesive = []
        super().__init__(self._stcs, self._length, self.word)

    def get_ending_first_part(self):
        return self.get_first_part()[-1]

    def has_plural(self):
        return self._search_property('PL')
    def has_Gen(self):
        return self._search_property('Gen')
    
    def has_depend(self):
        return self._search_property('POSS')
    
    suffix_symbols = ['AdjectivesToNoun', 'NamesToNoun', 'MimicsToNoun', 'VerbsToNoun', 'NounsToAdjective', 'VerbsToAdjective', 'NamesToVerbs', 'VerbsToVerbs', 'Kosemshe', 'Esimshe', 'KosemsheEsimshePlusTaueldik', 'VerbsToEsimshe', "VWFI"]
    def get_researhed_part(self, researhed_part=None):
        jiktik = ['P1SG1', 'P1PL1', 'P2SG1', 'P2SG.P1', 'P3SG']
        founded = []
        if researhed_part is None:
            researhed_part = self.get_first_part()
        if self.isResearchable() and self.has_second_part:
            for i in self.get_parts():
                if i == 'Gen':
                    researhed_part += self.get_ilik(researhed_part)
                elif i == 'PL':
                    researhed_part += self.get_plural(researhed_part)
                elif 'POSS' in i:
                    researhed_part += self.get_taueldy(self.get_depence(), researhed_part)
                elif i == 'Dir':
                    researhed_part += self.get_barys(researhed_part, 'Dir', founded)
                elif i == 'Acc':
                    researhed_part += self.get_tabys(researhed_part)
                elif i == 'Loc':
                    researhed_part += self.get_jatys(researhed_part, [])
                elif i == 'Abl':
                    researhed_part += self.get_shygys(researhed_part)
                elif i == 'Inst':
                    researhed_part += self.get_komektes(researhed_part)
                elif i in jiktik:
                    researhed_part += self.get_jiktik(researhed_part, i)
                elif i in self.suffix_symbols:
                    researhed_part += self.get_suffix(i, researhed_part, founded)
        #print("researhed_part:", researhed_part)
        return researhed_part

    def count_matching_elements(self, list1, list2):
        count = 0
        for item1 in list1:
            for item2 in list2:
                if item1 == item2:
                    count += 1
                    if count >= 2:
                        return True
        return False

    def add_parts_to_synonym(self):
        #print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
        self.correct_analyze()
        parts = self.get_parts()
        # print("parts=",parts)
        jiktik = ['P1SG1', 'P1PL1', 'P2SG1', 'P2SG.P1', 'P3SG', 'P2SG', 'POSS', ]
        catan = ['п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч', 'һ']
        uyan  = ['б', 'в', 'г', 'ғ', 'д', 'ж', 'з' ]
        un = ['р', 'л', 'й', 'у', 'м', 'н', 'ң']
        couples = [ 'п','б', 'ф','в', 'к','г', 'қ','ғ', 'т','д', 'с','з', 'ш','ж']
        founded = []
        first_part = self.get_first_part()
        word = first_part
        synonym = self.get_synonym()
        is_word_soft = self.is_soft(first_part)
        is_synonym_soft = self.is_soft(synonym)
        researcheableParts= ["Imprv",'Gen','PL','Dir', 'Acc','Loc','Abl','Inst'] + jiktik + self.suffix_symbols
        #print("parts:", parts)
        #print(self.count_matching_elements(['Dir', 'Acc','Loc','Abl','Inst'], parts))

        if self.count_matching_elements(['Dir', 'Acc','Loc','Abl','Inst'], parts):
            #print("SCR")
            self.set_synonym("")
            return
        
        # if self.find_extra_chars(first_part, self.word) in Koptik.koptik:
        #     self.set_synonym(self.get_synonym() + self.get_plural(self.get_synonym()))
        #     return
        # if first_part[-1] == synonym[-1] and ((is_word_soft and is_synonym_soft) or (not is_word_soft and not is_synonym_soft)):
        #     # if "POSS" not in parts or ("POSS" not in parts or synonym[-1] not in ['к' , 'п']):
        #         #print("I'M HERE")
        #         second_part = self.get_second_part()
        #         if first_part[-1] == 'я':
        #             self.set_synonym(self.get_synonym() + second_part)
        #             return 
        #         if second_part != "" and second_part[0] in ['г'] and self.get_synonym()[-1] in ['к']:
        #             # print("self.get_synonym()[:-1]:", self.get_synonym()[:-1])
        #             self.set_synonym(self.get_synonym()[:-1] + second_part)
        #             return

        #         if not self.has_depend() and not((self.is_soft(synonym) and self.is_soft(second_part)) or (not(self.is_soft(synonym)) and not(self.is_soft(second_part)))):
        #             if self.is_soft(synonym):
        #                 temp = ''
        #                 for i in second_part:
        #                     if i in self.solid:
        #                         temp += self.make_soft(i)
        #                     else:
        #                         temp += i
        #                 second_part = temp
        #             else:

        #                 temp = ''
        #                 for i in second_part:
        #                     if i in self.soft:
        #                         temp += self.make_solid(i)
        #                     else:
        #                         temp += i
        #                 second_part = temp
                
        #         if len(second_part)>0 and len(synonym)>0:
        #             if (synonym[-1]=="қ" and second_part[0] == "ғ") or (synonym[-1]=="к" and second_part[0] == "г"):
        #                 synonym=synonym[:-1]
                
        #         self.set_synonym(synonym + second_part) 
        #         return
        
        if self.isResearchable() and self.has_second_part:
            for i in parts:
                #print(i)
                if i not in researcheableParts:
                    
                    
                    #print("AAAAAAAAAAAAAA1")
                    continue

                # if (i in researcheableParts) and ((is_word_soft and is_synonym_soft) or (not is_word_soft and not is_synonym_soft)) and self.get_first_part()[-1] == self.get_synonym()[-1]:
                #     print(i)
                #     #print("AAAAAAAAAAAAAA2")
                #     #print(self.get_synonym()[:-1])
                #     addition = self.get_addition(i, [])
                #     if self.get_synonym()[-1] in ['с'] and addition[0] == self.get_synonym()[-1]:
                #         self.set_synonym(self.get_synonym()[:-1]) 
                #     word = word + addition
                #     #print(self.get_first_part())
                #     syn = self.get_synonym() + addition
                #     self.set_synonym(syn)
                #     #print(syn)
                #     continue

                app = ""
                if i == "Imprv":
                    app += self.get_buyryk(self.get_synonym())
                if i == 'Gen':
                   app += self.get_ilik(self.get_synonym())
                elif i == 'PL':
                    app+= self.get_plural(self.get_synonym())
                elif 'POSS' in i:
                    app+= self.get_taueldy(self.get_depence(), self.get_synonym())
                elif i == 'Dir':
                    app+= self.get_barys(self.get_synonym(), 'Dir', founded)
                    if (self.get_synonym()[-1] in ['т'] and app[0] in ['ғ']) or (self.get_synonym()[-1] in ['р', 'л'] + self.consonantsounds  and app[0] in ['к']):

                        app = self.get_couple(app[0]) + app[1:]
                elif i == 'Acc':
                    app+= self.get_tabys(self.get_synonym())
                elif i == 'Loc':
                    app+= self.get_jatys(self.get_synonym(), [])
                elif i == 'Abl':
                    app+= self.get_shygys(self.get_synonym())
                elif i == 'Inst':
                    app+= self.get_komektes(self.get_synonym())
                elif i in jiktik:
                    app+= self.get_jiktik(self.get_synonym(), i)
                elif i in self.suffix_symbols:
                    app+= self.get_suffix(i, self.get_synonym(), founded)
                if parts.index(i) == 0 and len(app)>0:
                    if synonym[-1] in ['к', 'қ','п'] and Phonetic.is_soft(app[0]):
                        self._synonym = synonym[:-1] + Lemms.change_syngor_reverse(Lemms,synonym[-1])
                #print("APP:", app)
                if self.get_synonym()[-1] in [ 'п', 'ф', 'к', 'қ', 'т', 'с', 'ш'] and app[0] in self.solid:
                    self.set_synonym(self.get_synonym()[:-1] + self.get_couple(self.get_synonym()[-1]))
                if (self.get_synonym()[-1] in [ 'п', 'ф', 'к', 'қ', 'т', 'с', 'ш'] and app[0] not in self.solid+self.solid and app[0] not in [ 'п', 'ф', 'к', 'қ', 'т', 'с', 'ш']) and len(app)>1:
                    app = self.get_couple(app[0]) + app[1:]

                # if (i in researcheableParts) and ((is_word_soft and is_synonym_soft) or (not is_word_soft and not is_synonym_soft)) and ((word[-1] in uyan and self.get_synonym()[-1] in uyan) or (word[-1] in catan and self.get_synonym()[-1] in catan) or (word[-1] in un and self.get_synonym()[-1] in un)):
                #     word = word + self.get_addition(i, [])
                #     self.set_synonym(self.get_synonym() + self.get_addition(i, []))
                #     continue
                if (len(app)>1 or app in self.solid + self.soft) and (self.is_soft(self.get_synonym()) and self.is_soft(app)) or ((not self.is_soft(self.get_synonym())) and (not self.is_soft(app))) or (app in ["мен", "бен", "пен", "пенен", "менен", "бенен"]):
                    addition = self.get_addition(i, [])
                    word = word + addition
                    if app == "":
                        app = addition
                    if len(app)>0 and self.get_synonym()[-1] in ['м', 'у', 'с'] and app[0] in ['с']:
                        app = app.replace(app[0], "")
                    #print("self.get_synonym() + app:", self.get_synonym() + app)
                    if self.get_synonym()[-1] in ['к'] and app[0] in self.soft:
                        self.set_synonym(self.get_synonym()[:-1] + self.get_couple(self.get_synonym()[-1]))
                    if not((self.is_soft(self.get_synonym()) and self.is_soft(app)) or ((not self.is_soft(self.get_synonym())) and not (self.is_soft(app)))) and app not in ["мен", "бен", "пен", "пенен", "менен", "бенен"]:
                        temp = ""
                        for i in app:
                            if self.is_soft(self.get_synonym()):
                                temp += self.make_soft(i)    
                            elif i not in self.solid + self.soft:
                                temp += self.make_solid(i)
                            else:
                                temp += self.make_solid(i)
                        app = temp
                    #print("self.get_synonym() + app:", self.get_synonym() + app)
                    self.set_synonym(self.get_synonym() + app)
                else:
                    for _, val in enumerate(app):
                        temp = val
                        if val in self.solid + self.soft:
                            if self.is_soft(val):
                                val = self.make_solid(val)
                                app = app.replace(temp, val)
                                break
                            else:
                                val = self.make_soft(val)
                                app = app.replace(temp, val)
                                break
                    word = word + self.get_addition(i, [])
                    self.set_synonym(self.get_synonym() + app)

    def make_solid(self, val):
        if val == 'і':  
            return 'ы'
        if val == 'е':
            return 'а'
        if val == 'г':
            return 'ғ'
        return val
    def make_soft(self, val):
        if val == 'ы':
            return 'і'
        if val == 'а':
            return 'е'
        if val == 'ғ':
            return 'г' 
        return val

    def isResearchable(self):
        return (not (len(self._stcs) == 0)) and (len(self._stcs[0][0]) > 2) #and not(" " in self.word.strip())
    def get_first_part(self) -> str:
        if self.isResearchable():
            self.first_part = self._stcs[0][self._length][3]
        else:
            self.first_part = self.word
        return self.first_part.strip()
    def has_second_part(self) -> bool:
        
        get_first_part = self.get_first_part().lower()
        word = self.word.lower()
        
        
        return get_first_part != word
    def is_correct(self):
        if len(self.word.strip().split(" ")) > 1:
            return True
        app = ""
        if self._stcs[0][0][1] == -1:
            return False
        for i in self._stcs[0][0][2]:
            app += i[0]
        #print("first_aprt=",self.get_first_part() )
        #print("self.word=",self.word )
        # Егер сөз түбірі табылған болса және сөз түбірі негізгі сөзге тең емес, әрі нақты анықталған жалғау жоқ болса онда түрлендірудің жалғастырып керек емес
        if app == "" and self.get_first_part() + app != self.word:
            return False
        #print("&&&&&&&&&&&&&")
        #print(self.get_first_part() + app)
        #print(self.word)
        # return self.get_first_part() + app == self.word
        return True

            

    def correct_analyze(self):
        # барлық қосымшаларды сөздікке сақтап аламыз
        appIndex = 0
        for app in self._stcs[0][0][2]:
            appIndex+=1
            if app[0] == "ын": 
                if len(self._stcs[0][0][2])> appIndex:
                    if self._stcs[0][0][2][appIndex][0] in ["ың", "ің"]:
                        self._stcs[0][0][2][appIndex-1][1] = "POSS.3SG"
                        self._stcs[0][0][2][appIndex-1][0] = "ы"
                        self._stcs[0][0][2][appIndex][0] += self._stcs[0][0][2][appIndex][0]
                        self._stcs[0][0][2][appIndex][1] = "Gen"
                        self._stcs[0][0][2][appIndex][2] = "жалғау"
                        app = self._stcs[0][0][2][appIndex-1]
                        self.appendixes.append({"name": app[1], "appendix": app[0]})
                        continue
                elif len(self._stcs[0][0][2])== appIndex:
                    self._stcs[0][0][2][appIndex-1][1] = "POSS.3SG"
                    self._stcs[0][0][2][appIndex-1][0] = "ы"
                    self._stcs[0][0][2].append(["н", "Acc", "жалғау"])
            if app[1] == "NamesToVerbs" and app[0] in ['да', 'де', 'та', 'те', 'ла','ле']:
                if len(self._stcs[0][0][2])> appIndex:
                    if self._stcs[0][0][2][appIndex][0] == "р":
                        self._stcs[0][0][2][appIndex-1][0] += self._stcs[0][0][2][appIndex][0]
                        self._stcs[0][0][2][appIndex-1][1] = "PL"
                        self._stcs[0][0][2][appIndex-1][2] = "жалғау"
                        app = self._stcs[0][0][2][appIndex-1]
                        del self._stcs[0][0][2][appIndex]
                        if len(self._stcs[0][0][2])> appIndex:
                            if self._stcs[0][0][2][appIndex][1] == "VWFI":
                                self._stcs[0][0][2][appIndex][1] = "Acc"
                                self._stcs[0][0][2][appIndex][2] = "жалғау"
                        self.appendixes.append({"name": app[1], "appendix": app[0]})
                        continue
            if app[1] == "NamesToVerbs" and app[0] in ['да', 'де', 'та', 'те']:
                # if self.first_part[-1] in ["й"] or len(self._stcs[0][0][2]) == 1:
                app[1] = self._stcs[0][0][2][appIndex-1][1] = "Loc"
            self.appendixes.append({"name": app[1], "appendix": app[0]})
        # Жатыс септігімен есімдерді етістікке айналдырушы жұрнақтарды шатыстырмас үшін жқмыс жасаймыз
        if len(self.appendixes)==2 and self.appendixes[0]["name"] == "NamesToVerbs" and self.appendixes[1]["name"] == "VerbsToVerbs" and self.appendixes[0]["appendix"] + self.appendixes[1]["appendix"] in Septik.Shygys:
            self._stcs[0][0][2] = [self.appendixes[0]["appendix"] + self.appendixes[1]["appendix"], "Abl", "жалғау"]
            self._stcs[0][self._length][4] = "Abl"
        i = 0
        if (len(self.appendixes)>3): 
            while i < len(self.appendixes) - 3:
                app = self.appendixes[i+1]["appendix"] + self.appendixes[i+2]["appendix"] +self.appendixes[i+3]["appendix"]
                if self.appendixes[i]["name"] == "VerbsToEsimshe" and app in ["нан", "нен"]:

                    self._stcs[0][0][2][i+1]=[app, "Abl", "жұрнақ"]
                    self.appendixes[i+1]["name"]="Abl"
                    self.appendixes[i+1]["appendix"] = app
                    del self._stcs[0][0][2][i+2:i+4]
                    del self.appendixes[i+2:i+4]
                    break
                i+=1
               # егер сөзтіркесінен тұрса және соңғы сөз тәуелдік болса
        if self.is_in_possesive:
            insertIndex = 0
            index = next((i for i, item in enumerate(self._stcs[0][0][2]) if item[1] == 'PL'), None)
            if index is not None:
                insertIndex = index +1
            if not "POSS." in self._stcs[0][0][4]:
                self._stcs[0][0][2].insert(insertIndex,self.possesive)
                self.appendixes.insert(insertIndex,{"name": self.possesive[1], "appendix": self.possesive[0]})
                if len(self._stcs[0][0][2])> insertIndex+1:
                    if self._stcs[0][0][2][insertIndex+1][1] == "NounsToAdjective" and self._stcs[0][0][2][insertIndex+1][0] in ["ды", "ді", "ты","ті"]:
                        self._stcs[0][0][2][insertIndex+1][1] = "Acc"
                        self._stcs[0][0][2][insertIndex+1][2] = "жалғау"
                        self.appendixes[insertIndex+1]["name"] = "Acc"
        
        
        
    def get_parts(self):
        if self.isResearchable() and len(self._stcs[0][self._length])>3:
            parts = []
            for item in self.appendixes:
                name = item['name']
                if '.' in name:
                    parts.extend(name.split('.'))
                else:
                    parts.append(name)
            return parts
        return None

    def get_second_part(self):
        remainder = ''
        if self.has_second_part():
            #print("self.word:", self.word)
            #print(self.get_first_part())
            remainder = Word.find_extra_chars(self.get_first_part(), self.word)
        return remainder
    
    def get_first_synonym(self):
        return self.first_synonym

    def look_for_synonym(self):
        if len(self.word.split(" "))>1:
            synonym, synomized_count = DB.get_instance().findsyn(self._stcs[0][0][3], self.synomized_count, self._synonyms)
            if synomized_count != self.synomized_count:
                first_part= self.get_first_part()
                self.synomized_count = synomized_count
                self.set_synonym(synonym)
                self.add_parts_to_synonym()
            # try:
            #     self.first_part = Lemms.get_instance().get_kaz_lemms(st(self.word))[0][len(' '.join(self.word.split()).split(' '))-1][3]
            # except:
            #     print("self.first_part = Lemms.get_instance().get_kaz_lemms(st(self.word))[0][len(' '.join(self.word.split()).split(' '))-1][3]")
            # print("findsyn2=",' '.join(' '.join(self.word.split()).split(' ')[:-1]) + " " + self.first_part)
            # print(self._synonyms)


            # synonym, synomized_count = DB.get_instance().findsyn(' '.join(' '.join(self.word.split()).split(' ')[:-1]) + " " + self.first_part, self.synomized_count, self._synonyms)
            # if synomized_count != self.synomized_count:
            #     self.synomized_count = synomized_count
            #     print(self.find_extra_chars( self.first_part,  ' '.join(self.word.split()).split(' ')[-1]))
            #     self.set_synonym(synonym + self.find_extra_chars( self.first_part,  ' '.join(self.word.split()).split(' ')[-1]))
            
            # return self
            # if synomized_count != self.synomized_count:
            #     self.synomized_count = synomized_count
            #     self.set_synonym(synonym.lower())
                
            return self
        if self.isResearchable():
            family = self.get_family()
            first_part= self.get_first_part()
            synonym, synomized_count = DB.get_instance().findsyn(first_part, self.synomized_count, self._synonyms, Word.get_pos_names(family))
            synonym = synonym.strip()
            #print(synonym)
            if len(synonym.split(" "))>1:
                syn_temp = synonym.split(" ")[len(synonym.split(" "))-1]
                self.first_synonym = synonym.split(" ")[:len(synonym.split(" "))-1]
                if family == "N":
                    t = Lemms.get_instance().get_kaz_lemms(st(syn_temp))
                    #print(t)
                    if (not (len(t) == 0)) and (len(t[0][0]) > 2) and not len(t[0][0][2]) == 0:
                        #print("Not len:", t[0][0][2][0][2])
                        if 'POSS' in t[0][0][2][0][1]:
                            #print(len(t[0][0][2][0][2]))
                            self.is_in_possesive = True
                            self.possesive = t[0][0][2][-1]
                            syn_temp = t[0][0][3]#syn_temp[:len(syn_temp)-l+1]
                
                
                synonym = syn_temp
            if synomized_count != self.synomized_count:
                self.synomized_count = synomized_count
                self.set_synonym(synonym.lower())
                self.add_parts_to_synonym()
        else:
            synonym, synomized_count = DB.get_instance().findsyn(self.word, self.synomized_count, self._synonyms)
            #print("synonym:", synonym)
            if synomized_count != self.synomized_count:
                self.synomized_count = synomized_count
                self.set_synonym(synonym.lower())

    def has_synonym(self):
        return self.get_synonym() != ''
    
    def _search_property(self, property):
        if self.isResearchable() and self.has_second_part:
            for i in self.get_parts():
                if property in i:
                    return True
        return False

    def capitalize_synonym(self):
        #print("capitalize_synonym:",self.get_first_part())
       
        self.set_synonym(self.get_synonym().capitalize())

    @staticmethod
    def split_string(first_string, second_string):
        index = second_string.find(first_string)
        if index != -1:
            first_part = second_string[:index]
            second_part = second_string[index + len(first_string):]
            return first_part, second_part
        else:
            return first_string, ""
        
    @staticmethod
    def find_extra_chars(string1, string2):
        extra_chars = ''
        char_count = {}
        for char in string1:
            char_count[char] = char_count.get(char, 0) + 1
        for char in string2:
            if char not in char_count or char_count[char] == 0:
                extra_chars += char
            else:
                char_count[char] -= 1
        
        return extra_chars
    
    def get_length(self):
        max = 0
        for i in range(0, len(self._stcs[0])):
            if self.isResearchable() and len(self._stcs[0][max][3]) < len(self._stcs[0][i][3]):
                max = i
        return max



    
    @staticmethod
    def get_pos_names(pos):
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
        
    def get_depence(self):
        for i in self._stcs[0][self._length][2]:
            if 'POSS' in i[1]:
                return i[0]
        return ''
        

        
