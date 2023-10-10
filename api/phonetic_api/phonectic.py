class Phonetic:
    # жуан дауыстылар
    thick_vowels = ["а","ю", "о", "ұ", "у", "и", "ы", "я", "э"]
    # жіңіщке дауыстылар
    thin_vowels = ["ә", "е", "ө", "ө", "і", "ү"]
    # дауыстылар
    vowels = thin_vowels + thick_vowels
   
    def is_soft(word) : 
        """
        Сөздің жіңішкелігін анықтайды
        """
        for s in word[::-1]:
            if s in Phonetic.thin_vowels:
                return True
            if s in Phonetic.thick_vowels:
                return False
        return False
    def is_vowel(sound):
        """
        Әріптің (дыбыстың) дауысты екендігін анықтайды
        """
        return sound in Phonetic.vowels
    # қатан дауыссыздар
    strict_consonants = ["к", "қ", "п", "с", "т", "ф", "х", "ц", "ч", "ш", "щ", "һ"]
    # ұяң дыбыстар
    voiced_consonants = ["б","в", "г", "ғ", "д", "ж", "з"]
    # үнді дыбыстар
    sonorat_consonants = [ "й", "р", "л", "м", "н", "ң", "у"]
    def is_strict(sound): 
        """
        Дауыссыз дыбыстың қатаң екенін анықтайды
        """
        return sound in Phonetic.strict_consonants
    def is_strict_consonant(sound): 
        """
        Дауыссыз дыбыстың қатаң екенін анықтайды
        """
        return sound in Phonetic.strict_consonants
    def is_voiced_consonant(sound): 
        """
        Дауыссыз дыбыстың ұяң екенін анықтайды
        """
        return sound in Phonetic.voiced_consonants
    def is_sonorat_consonant(sound): 
        """
        Дауыссыз дыбыстың үнді екенін анықтайды
        """
        return sound in Phonetic.sonorat_consonants
 