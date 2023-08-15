class Appendix:
    AppendixString = ""
    AppName = ""
    PosName = ""
    def __init__(self, app, name, posName):
        self.AppendixString = app
        self.AppName = name
        self.PosName = posName
    def Appendix(self):
        self.AppendixString = ""

    def Appendix(self, syllable):
        self.AppendixString = syllable

    def CheckForDefinition(self, ending):
        return "undefined"

    def CheckForDefinition(self, POS, appendixPart):
        return "undefined"

    def ToString():
        return "қосымша"

# Жалғаулар
class Ending(Appendix):
    def ToString():
        return "жалғау"
class Suffix(Appendix):
    POS_NOUN = 1 # Зат есім
    POS_ADJECTIVE = 2 # Сын есім
    POS_NUMERAL = 3 # Сан есім
    POS_PRONOUN = 4 # Есімдік
    POS_VERB = 5 # Етістік
    POS_MIMIC = 6 # Еліктеуіш
    POS_INTERJECTION = 7 # Одағай
    POS_CONJUCTION = 8 # Шылау
    POS_ADVERB = 9 # Үстеу
    AdjectivesToNoun = [ "лық", "лік"]
	# есімдерден зат есім тудырушы
    NamesToNoun = ["шы", "ші","дық", "дік", "тық", "тік", "лас", "лес", "дас", "дес", "тас", "тес", "ша", "ше", "шық", "шік", "шылық", "шілік"]
	# еліктеуіштерден зат есім тудырушы
    MimicsToNoun = ["ыл", "іл", "л"]
	# етістіктен зат есім тудырушы
    VerbsToNoun = ["ма", "ме", "ба", "бе", "па", "пе", "ыс", "іс", "с", "қ", "к","ғы", "гі", "ақ", "ек", "ғыш", "гіш", "қыш", "кіш", "ыш", "іш", "уыш", "уіш", "ман", "мен"] # //ым", "ім", "м"]
    # Жедел өткен шақ
    VWFI = ["ды", "ді", "ты", "ті"]
	# зат есімнен сын есім
    NounsToAdjective = ["лы", "лі", "ды", "ді", "ты", "ті", "лық", "лік", "тық", "тік", "сыз", "сіз", "қы", "кі", "ғы", "гі", "шыл", "шіл","лай","лей", "дай", "дей", "тай", "тей", "шаң", "шең", "и", "қой", "қор", "паз", 'тын','тін']
	# етістіктен сын есім
    VerbsToAdjective = [
    #"қ", "к", "ық", "ік",
        "қақ", "ғақ", "гек", "кек","ақ", "ек",
        "қыш", "кіш", "ғыш", "гіш", "қы", "гі", "ғылықты", "кілікті",
        "қыр", "кір", "ғыр", "гір",
        "шақ", "шек",
        "ңқы", "ңкі", "ыңқы", "іңкі",
        "нды", "нді", #"ынды", "інді",
        "малы", "мелі", "палы", "пелі", "балы", "белі",
        "ымды", "імді", "мды", "мді",
        "аған", "еген",
        "улы", "улі",
        "ма", "ме", "ба", "бе", "па", "пе",
    ]
	# есімдерден етістік тудырушы жұрнақтар
    NamesToVerbs = [
        "лан", "лен", "лас", "лес", "дас", "дес", "тас", "тес", "лат", "лет", "дат", "дет", "тат", "тет", " ар", "ер", "р", "ай", "ей", "ақ", "ік","та", "те", "ла", "ле", "да", "де", #"тан", "тен", "дан", "ден", "а", "е", " й", "та", "те", "ла", "ле"
    ]
	# етістіктен етістік тудырушы жұрнақтар
    VerbsToVerbs = [
        "ын", "ін", "н", "ыл", "іл", "л", "дыр", "дір", "тыр", "тір",  "қыз", "кіз", "ғыз", "гіз", "ыс", "іс",
        "ма", "ме", "ба", "бе", "па", "пе",
        "ғанша", "генше", "қанша", "кенше", "майынша", "мейінше", "қан", "кен", "ған", "ген", "ар", "ер", "р", "с",
        "тын", "тін", "ушы", "уші", "мақ", "мек", "бақ", "бек", "пақ", "пек", "у"
    ]
    YryqsyzEtis = ["ын", "ін", "н", "ыл", "іл", "л"]
    Kosemshe = ["а", "е", "й", "ып", "іп", "п", "ғалы", "гелі", "қалы", "келі"]
    Esimshe = ["ған", "ген", "қан", "кен", "ар", "ер", "р", "с", "тын", "тін", "ушы", "уші", "мақ", "мек", "бақ", "бек", "пақ", "пек"]
    KosemsheEsimshePlusTaueldik = ["амыз", "еміз", "ймыз", "йміз"]
    VerbsToEsimshe = ["қан", "кен", "ған", "ген", "атын", "етін", "йтын", "йтін", " ар", "ер", "р", "с", "тын", "тін", "ушы", "уші", "мақ", "мек", "бақ", "бек", "пақ", "пек"]

    def CheckForDefinition(self, ending): 
        if ending in self.AdjectivesToNoun:
            self.AppName = "AdjectivesToNoun"
        if ending in self.NamesToNoun:
            self.AppName = "NamesToNoun"
        if ending in self.MimicsToNoun:
            self.AppName = "MimicsToNoun"
        if ending in self.VerbsToNoun:
            self.AppName = "VerbsToNoun"
        if ending in self.VerbsToVerbs:
            self.AppName = "VerbsToVerbs"
        if ending in self.NounsToAdjective:
            self.AppName = "NounsToAdjective"
        if ending in self.VerbsToAdjective:
            self.AppName = "VerbsToAdjective"
        if ending in self.NamesToVerbs:
            self.AppName = "NamesToVerbs"
        if ending in self.Kosemshe:
            self.AppName = "Kosemshe"
        if ending in self.Esimshe:
            self.AppName = "Esimshe"
        if ending in self.KosemsheEsimshePlusTaueldik:
            self.AppName = "KosemsheEsimshePlusTaueldik"
        if ending in self.VerbsToEsimshe:
            self.AppName = "VerbsToEsimshe"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    
    def CheckForDefinition2(self, ending):
        if ending in self.AdjectivesToNoun:
            self.AppName = "AdjectivesToNoun"
        if ending in self.NamesToNoun:
            self.AppName = "NamesToNoun"
        if ending in self.MimicsToNoun:
            self.AppName = "MimicsToNoun"
        if ending in self.VerbsToNoun:
            self.AppName = "VerbsToNoun"
        if ending in self.NounsToAdjective:
            self.AppName = "NounsToAdjective"
        if ending in self.VerbsToVerbs:
            self.AppName = "VerbsToVerbs"
        if ending in self.VerbsToAdjective:
            self.AppName = "VerbsToAdjective"
        if ending in self.NamesToVerbs:
            self.AppName = "NamesToVerbs"
        if ending in self.Kosemshe:
            self.AppName = "Kosemshe"
        if ending in self.Esimshe:
            self.AppName = "Esimshe"
        if ending in self.KosemsheEsimshePlusTaueldik:
            self.AppName = "KosemsheEsimshePlusTaueldik"
        if ending in self.VerbsToEsimshe:
            self.AppName = "VerbsToEsimshe"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    
    def CheckForDefinition(self, pos, ending, lastappendix =''):
        #print("SELF POS SUFFIX=", pos)
        if (pos == self.POS_VERB and self.AppName =="" and lastappendix != 'у'):
            for ve in self.VerbsToEsimshe:
                if ve == ending and self.AppName == "":
                    self.AppName = "VerbsToEsimshe"
                    break
            for ve in self.Kosemshe:
                if ve == ending and self.AppName == "":
                    self.AppName = "Kosemshe"
                    break
            for ve in self.VerbsToVerbs:
                if ve == ending and self.AppName == "":
                    self.AppName = "VerbsToVerbs"
                    break
            for ve in self.VerbsToNoun:
                if ve == ending and self.AppName == "":
                    self.AppName = "VerbsToNoun"
                    break
            for ve in self.VerbsToAdjective:
                if ve == ending and self.AppName == "":
                    self.AppName = "VerbsToAdjective"
                    break
            for ve in self.VWFI:
                if ve == ending and self.AppName == "":
                    self.AppName = "VWFI"
                    break
        if (pos == self.POS_NOUN or (pos == self.POS_VERB and lastappendix == 'у')):
            print("HERE")
            for ve in self.NamesToNoun:
                if ve == ending and self.AppName == "":
                    self.AppName = "NamesToNoun"
                    break
            for ve in self.NamesToVerbs:
                if ve == ending and self.AppName == "":
                    self.AppName = "NamesToVerbs"
                    break
            for ve in self.NounsToAdjective:
                if ve == ending and self.AppName == "":
                    self.AppName = "NounsToAdjective"
                    break
        if (pos == self.POS_MIMIC):
            for ve in self.MimicsToNoun:
                if ve == ending and self.AppName == "":
                    self.AppName = "MimicsToNoun"
                    break
        if (pos == self.POS_ADJECTIVE):
            for ve in self.AdjectivesToNoun:
                if ve == ending and self.AppName == "":
                    self.AppName = "AdjectivesToNoun"
                    break
        if (pos == self.POS_NUMERAL):
            for ve in self.NamesToNoun:
                if ve == ending and self.AppName == "":
                    self.AppName = "NamesToNoun"
                    break
            for ve in self.NamesToVerbs:
                if ve == ending and self.AppName == "":
                    self.AppName = "NamesToVerbs"
                    break
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "жұрнақ"

class ExceptionAppendixes(Suffix):
    AdjectivesFromNouns = [
        "ғы", "ғың", "ғым", "ғын", "гі", "гің", "гім",
        "рі", "рің", "рім", "ры", "рың", "рым",
        "зы", "зың", "зым", "зі", "зің", "зім",
        "лі", "лің", "лім", "лы", "лың", "лым",
        "мы", "мі", "мың", "мің", "мым", "мім",
        "бы", "бі", "бым", "бім", "бың", "бің",
        "сы", "cім", "сын", "сін", "сың", "сің", "шым", "шім", "жым", "жім"]
    Taueldik = [
        "бам", "бем", "мам", "мем", "лем", "лам", "ғам", "гем", "шам", "шем", "там", "тем", "дам", "дем",
        "нам", "нем", "рам", "рем", "зам", "зем", "сам", "сем", "кем", "қам", "жам", "жем", "йем", "йам", "пам", "пем"
    ]
    VerbvsFromVerbs = [
        "рып", "ріп", "лып", "ліп", "тып", "тіп", "ғып", "гіп", "лап", "леп", "ғап", "геп", "ру", "ту", "ғу", "гу"
    ]
    def CheckForDefinition(self, ending):
        if ending in self.AdjectivesFromNouns:
            self.AppName = "AdjectivesFromNouns"
        if ending in self.Taueldik:
            self.AppName = "Taueldik"
        if ending in self.VerbvsFromVerbs:
            self.AppName = "VerbvsFromVerbs"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "ережеден тыс жұрнақ"
# Етістіктің райлары
class MOOD(Ending):
    # бұйрық рай
    Imprv = ["йін", "сін", "ейін", "йын", "ыңыз", "сын", "ңіз", "іңіз", "ңыз"]
    def CheckForDefinition(self, ending):
        if ending in self.Imprv:
            self.AppName = "Imprv"
        return self.AppName
    def ToString():
        return "Рай: " + Ending.ToString()
# Септік
class Septik(Ending):
    Atau = []
    Ilik = ["ның", "нің", "дың", "дің", "тың", "тің"]
    Barys = ["ға", "ге", "қа", "ке", "на", "не", "а", "е"]
    Tabys = ["ны", "ні", "ды", "ді", "ты", "ті", "н"]
    Jatys = ["дағы", "дегі", "таға", "тегі", "да", "де", "та", "те", "нда", "нде", ]
    Shygys = ["нан", "нен", "дан", "ден", "тан", "тен"]
    Komektes = ["мен", "бен", "пен", "пенен", "менен", "бенен"]

    def CheckForDefinition(self, ending):
        if ending in self.Ilik:
            self.AppName = "Gen"
        if ending in self.Barys:
            self.AppName = "Dir"
        if ending in self.Tabys:
            self.AppName = "Acc"
        if ending in self.Jatys:
            self.AppName = "Loc"
        if ending in self.Shygys:
            self.AppName = "Abl"
        if ending in self.Komektes:
            self.AppName = "Inst"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "Cептік " + Ending.ToString()

# Жіктік
class Jiktik(Ending):
    FirstStepSingular = [ "мын", "мін", "пын", "пін", "дым", "дім"]
    FirstStepPlural = [ "мыз", "міз", "быз", "біз", "пыз", "піз", "дік", "дық"]
    SecondStepSingular = [ "сың", "сің", "дың", "дің" ]
    SecondStepFormal = [ "сіз", "сыз" ]
    ThirdStep = [ "ды", "ді", "ты", "ті" ]

    def CheckForDefinition(self, ending):
        if ending in self.FirstStepSingular:
            self.AppName = "P1SG1"
        if ending in self.FirstStepPlural:
            self.AppName = "P1PL1"
        if ending in self.SecondStepSingular:
            self.AppName = "P2SG1"
        if ending in self.SecondStepFormal:
            self.AppName = "P2SG.P1"
        if ending in self.ThirdStep:
            self.AppName = "P3SG"
        if (self.AppName != ""):
            self.AppendixString = ending
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "Жіктік жалғау"

# Тәуелдік
class Taueldik(Ending):
    FirstStepSingular = [ "м", "ым", "ім"]
    FirstStepPlural = [ "ымыз", "іміз"]
    SecondStepSingular = [ "ң", "ың", "ің" ]
    SecondStepPlural = [ "ңыз", "ыңыз", "іңіз"]
    ThirdStep = [ "сы", "сі", "ы", "і"]

    def CheckForDefinition(self, ending):
        if ending in self.FirstStepSingular:
            self.AppName = "POSS.1SG"
        if ending in self.FirstStepPlural:
            self.AppName = "POSS.1PL"
        if ending in self.SecondStepSingular:
            self.AppName = "POSS.2SG"
        if ending in self.SecondStepPlural:
            self.AppName = "POSS.2PL"
        if ending in self.ThirdStep:
            self.AppName = "POSS.3SG"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "Тәуелдік жалғау"
# Көптік
class Koptik(Ending):
    koptik = [ "лар", "лер", "дар", "дер", "тар", "тер"]

    def CheckForDefinition(self, ending):
        if ending in self.koptik:
            self.AppName = "PL"
        if (self.AppName != ""):
            self.AppendixString = ending
        return self.AppName
    def ToString():
        return "Көптік жалғау"
