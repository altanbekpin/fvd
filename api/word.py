
from morphology_api.morphology import Lemms, is_soft
from nltk.tokenize import sent_tokenize as st
from db import DB
from morphology_api.appendix import Suffix, Septik, Jiktik, Taueldik, Koptik
class Finder:
    def __init__(self, _stcs,_length, word) -> None:
        self.word = word
        self._stcs = _stcs
        self._length = _length
        self._trash_part = ""
    solid = ['а', 'о', 'ы', 'у', 'я']
    soft = ['ә', 'ө', 'і', 'е', 'и', 'э', 'ү']
    
    def get_addition(self, part, founded=[]):
        if self.isResearchable() and len(self._stcs[0][self._length])>3:
            parts = self._stcs[0][self._length][2]
            for index, i in enumerate(parts):
                if (i[1] in part) and not(index in founded):
                    founded.append(index)
                    return i[0]
        return ''
    
    def get_family(self):
        if self.isResearchable():
            return self._stcs[0][0][1]
        return ''

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
        Barys = ["ға", "ге", "қа", "ке", "на", "не", "а", "е"]
        result = self.get_addition(symbol, founded)
        is_soft = self.is_soft(word)
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))):
            return result
        index = Barys.index(result)
        if is_soft:
            result = Barys[index+1]
        else:
            result = Barys[index-1]
        return result
        


    def get_taueldy(self, depence, word):
        additions = [ "м", "ым", "ім", "ымыз", "іміз", "ң", "ың", "ің", "ңыз", "ыңыз", "іңіз", "сы", "сі", "ы", "і"]
        is_soft = self.is_soft(word)
        if (is_soft and self.is_soft(depence) or ((not is_soft) and (not self.is_soft(depence)))):
            return depence
        index = additions.index(depence)
        if is_soft:
            depence = additions[index+1]
        else:
            depence = additions[index-1]
        return depence

    def get_suffix(self, symbol, word, founded):
        print("symbol:", symbol)
        is_soft = self.is_soft(word)
        result = self.get_addition(symbol, founded)
        # suffix = Suffix.AdjectivesToNoun + Suffix.NamesToNoun + Suffix.MimicsToNoun + Suffix.VerbsToNoun + Suffix.VWFI + Suffix.NounsToAdjective + Suffix.VerbsToAdjective +Suffix.NamesToVerbs + Suffix.VerbsToVerbs +Suffix.Kosemshe+Suffix.Esimshe +Suffix.KosemsheEsimshePlusTaueldik+Suffix.VerbsToEsimshe
        suffix = self.suffix_helper(symbol)
        if len(result) == 1 and result != 'а' and result != 'е':
            return result
        index = suffix.index(result)
        noise = self.solid + self.soft
        if (word[-1] in noise) and (result[0] in noise):
            for i in range(index, len(suffix)):
                if suffix[i][0] not in noise:
                    return suffix[i]
        if (is_soft and self.is_soft(result) or ((not is_soft) and (not self.is_soft(result)))) and result != word[-1]:
            return result
        if is_soft:
            result = suffix[index+1]
        else:
            result = suffix[index-1]
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
        tyti = ['б', 'в', 'г' ,'д', 'к' ,'қ' ,'п' ,'с' ,'т' ,'х' ,'ц' ,'ч','ф']
        nyni = ['а', 'о', 'ы', 'і', 'е', 'я']
        dydi = ['ж' ,'з', 'й', 'м', 'н', 'ң', 'л', 'у', 'р', 'ю']
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
        jiktik = self.get_addition(ending, [])
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
        ending = word.strip()[-1]
        consonantsounds = ['л', 'м', 'н', 'ң', 'з']
        tarter = ['п', 'ф', 'к', 'қ', 'т', 'с', 'ш', 'щ', 'х', 'ц', 'ч' ,'һ']
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
        for i in word:
            if i in self.soft:
                soft_count += 1
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
        print("remainder:", remainder)
        print("self.get_family:", self.get_family())
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
        print("definition:", definition)
        print("name:", name)
        if(name == ""):
            self.set_trash_part(remainder)
        self._stcs[0][self._length][2].append([remainder, definition, name])
        self._stcs[0][self._length][4] = self._stcs[0][self._length][4] + f"{definition}."
        print("self._stcs:", self._stcs)
        

            
    

class Word(Finder):
    def __init__(self, word, synomized_count, synonyms) -> None:
        self.word = word.lower()
        sentences = st(word)
        self._stcs = Lemms.get_instance().get_kaz_lemms(sentences)
        print("self._stcs:".upper(), self._stcs)
        self._length = self.get_length()
        self.synomized_count = synomized_count
        self._synonyms = synonyms
        self._ending = word[-1]
        self.first_part = ''
        self._synonym = ''
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
        return self._search_property('POSS.1SG')
    
    suffix_symbols = ['AdjectivesToNoun', 'NamesToNoun', 'MimicsToNoun', 'VerbsToNoun', 'NounsToAdjective', 'VerbsToAdjective', 'NamesToVerbs', 'VerbsToVerbs', 'Kosemshe', 'Esimshe', 'KosemsheEsimshePlusTaueldik', 'VerbsToEsimshe']
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
        return researhed_part
    
    def add_parts_to_synonym(self):
        parts = self.get_parts()
        jiktik = ['P1SG1', 'P1PL1', 'P2SG1', 'P2SG.P1', 'P3SG']
        founded = []
        if self.isResearchable() and self.has_second_part:
            print("parts:".upper(), parts)
            synonym = self.get_synonym()
            #if len(parts) >0 and parts[0]:
            app = ""
            for i in parts:
                if i == 'Gen':
                   app += self.get_ilik(self.get_synonym())
                elif i == 'PL':
                    app+= self.get_plural(self.get_synonym())
                elif 'POSS' in i:
                    app+= self.get_taueldy(self.get_depence(), self.get_synonym())
                elif i == 'Dir':
                    app+= self.get_barys(self.get_synonym(), 'Dir', founded)
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
                        print(synonym[-1] + "QQQQQQQQQ")
                self.set_synonym(synonym + app)
            
    # def add_parts_to_word(self, word):
    def isResearchable(self):
        return (not (len(self._stcs) == 0)) and (len(self._stcs[0][0]) > 2) and not(" " in self.word.strip())
    def has_second_part(self) -> bool:
        
        get_first_part = self.get_first_part().lower()
        word = self.word.lower()
        
        
        return get_first_part != word
    def get_first_part(self) -> str:
        if self.isResearchable():
            self.first_part = self._stcs[0][self._length][3]
            
        else:
            self.first_part = self.word
        return self.first_part.strip()
    
    def get_parts(self):
        if self.isResearchable() and len(self._stcs[0][self._length])>3:
            parts = self._stcs[0][self._length][4].split('.')
            return parts[:len(parts)-1]
        return None

    def get_second_part(self):
        second = ''
        # if self.has_second_part():
        #     print("******************************************************************")
        #     print("self.get_researhed_part():",self.get_researhed_part())
        #     print("******************************************************************")
        #     remainder = Word.find_extra_chars(self.get_researhed_part(), self.word)
        #     if remainder != '':
        #         self.add_correct_remainder(remainder)
        return second
    
    def get_first_synonym(self):
        return self.first_synonym

    def look_for_synonym(self):
        if self.isResearchable():
            family = self.get_family()
            first_part= self.get_first_part()
            synonym, synomized_count = DB.get_instance().findsyn(first_part, self.synomized_count, self._synonyms, Word.get_pos_names(family))
            if len(synonym.split(" "))>1:
                syn_temp = synonym.split(" ")[len(synonym.split(" "))-1]
                self.first_synonym = synonym.split(" ")[:len(synonym.split(" "))-1]
                temp = ""
                for i in self.first_synonym:
                    temp = temp + " " + i
                self.first_synonym = temp
                synonym = syn_temp
                print("synonym:".upper(), synonym)
            if synomized_count != self.synomized_count:
                self.synomized_count = synomized_count
                self.set_synonym(synonym.lower() + self.get_second_part())
                self.add_parts_to_synonym()
        else:
            synonym, synomized_count = DB.get_instance().findsyn(self.word, self.synomized_count, self._synonyms)
            if synomized_count != self.synomized_count:
                self.synomized_count = synomized_count
                self.set_synonym(synonym.lower())

    def has_synonym(self):
        return self.get_synonym() != ''
    
    def _search_property(self, property):
        if self.isResearchable() and self.has_second_part:
            for i in self.get_parts():
                if i == property:
                    return True
        return False

    def get_synonym(self):
        return self._synonym
    
    def set_synonym(self, new_synonym):
        self._synonym = new_synonym

    def capitalize_synonym(self):
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
        

        
