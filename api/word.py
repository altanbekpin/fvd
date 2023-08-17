
from morphology_api.morphology import Lemms, is_soft
from nltk.tokenize import sent_tokenize as st
from db import DB
from morphology_api.appendix import Suffix, Septik, Jiktik, Taueldik, Koptik
import math
class Finder:
    def __init__(self, _stcs,_length, word) -> None:
        self.word = word
        self._stcs = _stcs
        self._length = _length
        self._trash_part = ""
        self._synonym = ""
    solid = ['а', 'о', 'ы',  'я', 'ұ']
    soft = ['ә', 'ө', 'і', 'е', 'и', 'э', 'ү']
    
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
    # def get_word(self):
    #     print("self.word:", self.word)
    #     return self.word
    
    def get_synonym(self):
        return self._synonym
    
    def set_synonym(self, new_synonym):
        print("new_synonym:", new_synonym)
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
        print("GET BARYS")
        Barys = ["ға", "ге", "қа", "ке", "на", "не", "а", "е"]
        result = self.get_addition(symbol, founded)
        is_soft = self.is_soft(word)
        if word[-1] in self.solid + self.soft and result[0] in self.solid +self.soft:
            return "й"
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))):
            return result
        index = Barys.index(result)
        if is_soft:
            result = Barys[index+1]
        else:
            result = Barys[index-1]
        print(word)
        print(result)
        return result

    def get_taueldy(self, depence, word):
        print("word:", word)
        print("depence:", depence)
        additions = [ "м", "ым", "ім", "ымыз", "іміз", "ң", "ың", "ің", "ңыз", "ыңыз", "іңіз", "сы", "сі", "ы", "і"]
        is_soft = self.is_soft(word)
        print("is_soft:", is_soft)
        print("is_soft(depence):", self.is_soft(depence))
        index = additions.index(depence)
        if depence in ['ы', 'і'] and word[-1] not in self.solid + self.soft:
            if is_soft:
                return 'і'
            return 'ы'
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
        print("DEPENCE:".upper(), depence)
        if (word[-1] in self.soft + self.solid + ["я"] and depence[0] in self.soft + self.solid):
            i = 0
            print("HEREEE")
            while(index-i != -1):
                i += 1
                depence = additions[index-i]
                print("depence:", depence)
                if (is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))) and depence not in self.solid + self.soft:
                    return depence
        print("is_soft(depence):", self.is_soft(depence))
        print("is_soft:", is_soft)
        if not(is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))):
            print("I;m here")
            if is_soft:
                depence = additions[index+1]
            else:
                depence = additions[index-1]
        if word[-1] == "қ":
            i = 0
            while(not(depence in self.soft + self.solid) and index+i != len(additions)-1):
                print(i)
                depence = additions[index+i]
                i += 1
            print("self.get_synonym()[:-1]:", self.get_synonym()[:-1]+"ғ")
            self.set_synonym(self.get_synonym()[:-1]+"ғ")
            print("self.get_synonym():", self.get_synonym())
        print("AT THE END")
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
        if char == 'т':
            return 'д'
        if char == 'д':
            return 'т'
        if char == 'з':
            return 'с'
        if char == 'щ':
            return 'ж'
        if char == 'ж':
            return 'ш'
        return char
    def get_suffix(self, symbol, word, founded):
        print(word)
        is_soft = self.is_soft(word)
        result = self.get_addition(symbol, founded)
        suffix = self.suffix_helper(symbol)
        index = suffix.index(result)
        noise = self.solid + self.soft
        if word[-1] == "р" and result == "та":
            if is_soft:
                return "ле"
            return "ла"
        if symbol == "VerbsToEsimshe":
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
            print("NOISE")
            for i in range(index, len(suffix)):
                if suffix[i][0] not in noise:
                    return suffix[i]
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))) and result != word[-1] and not(word[-1] in ["і", 'р'] and result[0] in ['т', 'н']):
            if (self.get_synonym()[-1] in ['т'] and result[0] in ['д']) or (self.get_synonym()[-1] in ['д'] and result[0] in ['т']):
                if result[0] in ['д']:
                    result = "т" + result[1:]
                elif result[0] in ['т']:
                    result = "д" + result[1:]
            print("RETURNING:", result)
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
        print("word:", word[-1])
        print("result:", result[0])
        if word[-1] in ["і", 'р'] and result[0] in ['т', 'н', 'ы']:
            i = 0
            print("fuck".upper())
            while(result[0] in ['т', 'н'] or not(is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result))))):
                i += 1
                result = suffix[index + i]
        # couples = [ 'п','б', 'ф','в', 'к','г', 'қ','ғ', 'т','д', 'с','з', 'ш','ж']
        # if word[-1] in couples and result[0] in couples:
        #     result = self.get_couple(result[0]) + result[1:]
        print("word2:", word)
        print("result2:", result)
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
        print("WORD:", word)
        print(ending)
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
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))):
            return result
        index = Jatys.index(result)
        if is_soft:
            result = Jatys[index+1]
        else:
            result = Jatys[index-1]
        return result
    
    def get_shygys(self, word):
        nannen = ['м','н', 'ң']
        danden = ['а', 'ә', 'о', 'ө', 'е', 'ы', 'і', 'ұ', 'ү', 'и', 'э', 'р', 'у', 'й', 'л', 'з', 'ж']
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
        print("***************")
        jiktik = self.get_addition(ending, [])
        print("WORD:", word)
        print(jiktik)
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
        print("INSIDE PLURAL")
        if word.strip() == "":
            return ""
        ending = word.strip()[-1]
        consonantsounds = ['л', 'м', 'н', 'ң', 'з']
        tarter = ['п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч' ,'һ', 'д']
        larler = ['й', 'р', 'а', 'ә', 'о', 'ө', 'е', 'ы', 'і', 'ұ', 'ү' ,'и' ,'э', 'б']
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
        soft_count = 0
        solid_count = 0
        for k,i in enumerate(word):
            if i in self.soft:
                soft_count += 1
            elif i == 'у':
                if word[k-1] not in self.solid + self.soft:
                    solid_count += 1
            elif i in self.solid:
                solid_count += 1
        return soft_count >= solid_count
    
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
        self._stcs = Lemms.get_instance().get_kaz_lemms_test(sentences, self.get_length())
        if not(self._stcs[0][0][1] == -1) and len(self._stcs[0][0][2]) == 0:
            self._stcs = temp
        self._length = self.get_length()
        self.synomized_count = synomized_count
        self._synonyms = synonyms
        self._ending = word[-1]
        self.first_part = ''
        self._plural = ''
        self.first_synonym = ''
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
        print("researhed_part:", researhed_part)
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
        print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
        parts = self.get_parts()
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
        print("parts:", parts)
        print(self.count_matching_elements(['Dir', 'Acc','Loc','Abl','Inst'], parts))
        if self.count_matching_elements(['Dir', 'Acc','Loc','Abl','Inst'], parts):
            print("SCR")
            self.set_synonym("")
            return
        if self.find_extra_chars(first_part, self.word) in Koptik.koptik:
            self.set_synonym(self.get_synonym() + self.get_plural(self.get_synonym()))
            return
        if first_part[-1] == synonym[-1] and ((is_word_soft and is_synonym_soft) or (not is_word_soft and not is_synonym_soft)):
            # if "POSS" not in parts or ("POSS" not in parts or synonym[-1] not in ['к' , 'п']):
                print("I'M HERE")
                second_part = self.get_second_part()
                if first_part[-1] == 'я':
                    self.set_synonym(self.get_synonym() + second_part)
                    return 
                print(second_part)
                if not self.has_depend() and not((self.is_soft(synonym) and self.is_soft(second_part)) or (not(self.is_soft(synonym)) and not(self.is_soft(second_part)))):
                    if self.is_soft(synonym):
                        temp = ''
                        for i in second_part:
                            if i in self.solid:
                                temp += self.make_soft(i)
                            else:
                                temp += i
                        second_part = temp
                    else:
                        temp = ''
                        for i in second_part:
                            if i in self.soft:
                                temp += self.make_solid(i)
                            else:
                                temp += i
                        second_part = temp
                self.set_synonym(synonym + second_part) 
                return
        if self.isResearchable() and self.has_second_part:
            print("HELE")
            for i in parts:
                print(i)
                if i not in researcheableParts:
                    print("AAAAAAAAAAAAAA1")
                    continue
                if (i in researcheableParts) and ((is_word_soft and is_synonym_soft) or (not is_word_soft and not is_synonym_soft)) and self.get_first_part()[-1] == self.get_synonym()[-1]:
                    print("AAAAAAAAAAAAAA2")
                    print(self.get_synonym()[:-1])
                    addition = self.get_addition(i, [])
                    if self.get_synonym()[-1] in ['с'] and addition[0] == self.get_synonym()[-1]:
                        self.set_synonym(self.get_synonym()[:-1]) 
                    word = word + addition
                    print(self.get_first_part())
                    syn = self.get_synonym() + addition
                    self.set_synonym(syn)
                    print(syn)
                    continue
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
                    if self.get_synonym()[-1] in ['т'] and app[0] in ['ғ']:
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
                    if synonym[-1] in ['к', 'қ','п'] and is_soft(app[0]):
                        synonym = synonym[:-1] + Lemms.change_syngor_reverse(Lemms,synonym[-1])
                print("APP:", app)
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
                    if self.get_synonym()[-1] in ['м', 'у', 'с'] and app[0] in ['с']:
                        app = app.replace(app[0], "")
                    print("self.get_synonym() + app:", self.get_synonym() + app)
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
                    print("self.get_synonym() + app:", self.get_synonym() + app)
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
        return (not (len(self._stcs) == 0)) and (len(self._stcs[0][0]) > 2) and not(" " in self.word.strip())
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
        app = ""
        if self._stcs[0][0][1] == -1:
            return False
        for i in self._stcs[0][0][2]:
            app += i[0]
        print("first_aprt=",self.get_first_part() )
        print("self.word=",self.word )
        # Егер сөз түбірі табылған болса және сөз түбірі негізгі сөзге тең емес, әрі нақты анықталған жалғау жоқ болса онда түрлендірудің жалғастырып керек емес
        if app == "" and self.get_first_part() + app != self.word:
            return False
        print("&&&&&&&&&&&&&")
        print(self.get_first_part() + app)
        print(self.word)
        # return self.get_first_part() + app == self.word
        return True

            

    
    def get_parts(self):
        if self.isResearchable() and len(self._stcs[0][self._length])>3:
            parts = self._stcs[0][self._length][4].split('.')
            return parts[:len(parts)-1]
        return None

    def get_second_part(self):
        remainder = ''
        if self.has_second_part():
            print("self.word:", self.word)
            print(self.get_first_part())
            remainder = Word.find_extra_chars(self.get_first_part(), self.word)
        return remainder
    
    def get_first_synonym(self):
        return self.first_synonym

    def look_for_synonym(self):
        if self.isResearchable():
            family = self.get_family()
            first_part= self.get_first_part()
            synonym, synomized_count = DB.get_instance().findsyn(first_part, self.synomized_count, self._synonyms, Word.get_pos_names(family))
            synonym = synonym.strip()
            print(synonym)
            if len(synonym.split(" "))>1:
                syn_temp = synonym.split(" ")[len(synonym.split(" "))-1]
                self.first_synonym = synonym.split(" ")[:len(synonym.split(" "))-1]
                print("syn_temp:", syn_temp)
                if family == "N":
                    t = Lemms.get_instance().get_kaz_lemms(st(syn_temp))
                    print(t)
                    if (not (len(t) == 0)) and (len(t[0][0]) > 2) and not len(t[0][0][2]) == 0:
                        print("Not len:", t[0][0][2][0][2])
                        if 'POSS' in t[0][0][2][0][1]:
                            print(len(t[0][0][2][0][2]))
                            l = len(t[0][0][2][0])
                            syn_temp = syn_temp[:len(syn_temp)-l+1]
                temp = ""
                for i in self.first_synonym:
                    temp = temp + " " + i
                self.first_synonym = temp
                synonym = syn_temp
            if synomized_count != self.synomized_count:
                self.synomized_count = synomized_count
                self.set_synonym(synonym.lower())
                self.add_parts_to_synonym()
        else:
            synonym, synomized_count = DB.get_instance().findsyn(self.word, self.synomized_count, self._synonyms)
            print("synonym:", synonym)
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
        print("capitalize_synonym:",self.get_first_part())
        if len(self.get_synonym().split(" "))>1:
            self.set_synonym(self.get_first_part().capitalize() + self.get_synonym())
            return
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
        

        
