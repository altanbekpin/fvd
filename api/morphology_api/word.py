from .appendix import Appendix, Suffix, Ending, Koptik, Jiktik, Taueldik, Septik, MOOD
class Word:
    Root = ""
    AppendixPart = ""
    Appendixes = []
    CurrentPOS = -1
    HasValue = False
    def __init__(self, root, pos, appendixPart, hasValue):
        self.Root = root
        self.AppendixPart = appendixPart
        self.CurrentPOS = pos
        self.Appendixes = []
        self.HasValue = hasValue
    def IsEsimshe(self):
        if (self.CurrentPOS != Suffix.POS_VERB):
            return False
        if (len(self.Appendixes) == 0):
            return False
        for app in self.Appendixes:
            if (app.AppName == "VerbsToEsimshe"):
                return True
        return False
    def IsKosemshe(self):
        if (self.CurrentPOS != Suffix.POS_VERB):
            return False
        if (len(self.Appendixes) == 0):
            return False
        for app in self.Appendixes:
            if (app.AppName == "Kosemshe"):
                return True
        return False
    def IsTuyiqEtistik(self):
        if (self.CurrentPOS != Suffix.POS_VERB):
            return False
        if (len(self.Appendixes) == 0):
            return False
        for app in self.Appendixes:
            if (app.AppName == "VerbsToVerbs") and app.AppendixString == 'у':
                return True
        return False
    def GetAppendixes(self):
            appendix = Ending
            if (len(self.AppendixPart) == 0):
                return
            appendixPart = self.AppendixPart
            # алдымен жұрнақтарды қарап аламыз
            while (len(appendixPart) > 0):
                appendix = Suffix
                appendix.AppName = ""
                appendix.AppendixString = ""
                #print("app=" + appendixPart)
                if (appendix.CheckForDefinition(Suffix,self.CurrentPOS, appendixPart) != ""):
                    self.Appendixes.append(Suffix(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                    appendixPart = self.AppendixPart[len(appendixPart):]
                    self.AppendixPart = appendixPart
                    if ("Kosemshe" in appendix.AppName):
                        break
                    if ("ToNoun" in appendix.AppName):
                        self.CurrentPOS = Suffix.POS_NOUN
                    if ("ToAdjective" in appendix.AppName):
                        self.CurrentPOS = Suffix.POS_ADJECTIVE
                    if ("ToVerbs" in appendix.AppName or "VWFI" in appendix.AppName):
                        self.CurrentPOS = Suffix.POS_VERB
                    if ("ToVerbs" in appendix.AppName):
                        self.CurrentPOS = Suffix.POS_VERB
                else:
                    appendixPart = appendixPart[:-1]

            # енді жалғауларға көштік
            if (len(self.AppendixPart) == 0):
                return
            appendixPart = self.AppendixPart
            while (len(appendixPart) > 0):
                if (self.CurrentPOS in [Suffix.POS_NOUN, Suffix.POS_ADJECTIVE, Suffix.POS_PRONOUN, Suffix.POS_NUMERAL] or (self.CurrentPOS == Suffix.POS_VERB and self.IsEsimshe())):
                    appendix = Koptik
                    appendix.AppName = ""
                    appendix.AppendixString = ""
                    appendix.AppName = appendix.CheckForDefinition(Koptik, appendixPart)
                    if (appendix.AppName != ""):
                        self.Appendixes.append(Koptik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                        appendixPart = self.AppendixPart[len(appendixPart):]
                        self.AppendixPart = appendixPart
                        continue
                    appendix = Taueldik
                    appendix.AppName = ""
                    appendix.AppendixString = ""
                    appendix.AppName = appendix.CheckForDefinition(Taueldik, appendixPart)
                    if (appendix.AppName != ""):
                        self.Appendixes.append(Taueldik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                        appendixPart = self.AppendixPart[len(appendixPart):]
                        self.AppendixPart = appendixPart
                        continue
                    appendix = Septik
                    appendix.AppName = ""
                    appendix.AppendixString = ""
                    appendix.AppName = appendix.CheckForDefinition(Septik, appendixPart)
                    if (appendix.AppName != ""):
                        self.Appendixes.append(Septik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                        appendixPart = self.AppendixPart[len(appendixPart):]
                        self.AppendixPart = appendixPart
                        continue
                    appendix = Jiktik
                    appendix.AppName = ""
                    appendix.AppendixString = ""
                    appendix.AppName = appendix.CheckForDefinition(Jiktik, appendixPart)
                    if (appendix.AppName != ""):
                        self.Appendixes.append(Jiktik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                        appendixPart = self.AppendixPart[len(appendixPart):]
                        self.AppendixPart = appendixPart
                        continue
                else:
                    if (self.CurrentPOS == Suffix.POS_VERB):
                        appendix = Taueldik
                        appendix.AppName = ""
                        appendix.AppendixString = ""
                        appendix.AppName = appendix.CheckForDefinition(Taueldik,appendixPart)
                        if (appendix.AppName != ""):
                            self.Appendixes.append(Taueldik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                            appendixPart = self.AppendixPart[len(appendixPart):]
                            self.AppendixPart = appendixPart
                            continue
                        appendix = Jiktik
                        appendix.AppName = ""
                        appendix.AppendixString = ""
                        appendix.AppName = appendix.CheckForDefinition(Jiktik, appendixPart)
                        if (appendix.AppName != ""):
                            self.Appendixes.append(Jiktik(appendix.AppendixString, appendix.AppName, appendix.ToString()))
                            appendixPart = self.AppendixPart[len(appendixPart):]
                            self.AppendixPart = appendixPart
                            continue
                        if (len(self.Appendixes) > 0):
                            if (self.IsEsimshe() or (self.Appendixes[-1].AppendixString !="у")):
                                appendix = Septik
                                appendix.AppName = ""
                                appendix.AppendixString = ""
                                appendix.AppName = appendix.CheckForDefinition(Septik, appendixPart)
                appendixPart = appendixPart[:-1]
            self.CorrectAnalyze()
    def CorrectAnalyze(self): 
        if len(self.Appendixes) > 1:
            if self.Appendixes[-1].AppName == "POSS.2SG" and self.Appendixes[-2].AppName == "NounsToAdjective":
                ilikAppendix = Septik
                ilikAppendix.AppendixString = self.Appendixes[-2].AppendixString + self.Appendixes[-1].AppendixString
                ilikAppendix.AppName = ilikAppendix.CheckForDefinition(Septik, ilikAppendix.AppendixString)
                if (ilikAppendix.AppName != ""):
                    self.Appendixes = self.Appendixes[:-2]
                    self.Appendixes.append(Septik(ilikAppendix.AppendixString, ilikAppendix.AppName, ilikAppendix.ToString()))
        if (len(self.Appendixes)==1):
            if self.CurrentPOS == Suffix.POS_VERB and self.Appendixes[0].AppName == "POSS.2PL":
                imprvAppendix = MOOD
                imprvAppendix.AppendixString = self.Appendixes[0].AppendixString
                imprvAppendix.AppName = imprvAppendix.CheckForDefinition(MOOD, imprvAppendix.AppendixString)
                if (imprvAppendix.AppName != ""):
                    self.Appendixes = self.Appendixes[:-1]
                    self.Appendixes.append(MOOD(imprvAppendix.AppendixString, imprvAppendix.AppName, imprvAppendix.ToString()))

        