import csv
import sqlite3
import os
import re
from db import DB
from word import Word
from synomizer_page import remove_extra_spaces, merge_some_elements_of_string_array, is_person_name, getHtml
from morphology_api.morphology import Lemms

i=0


# import nltk
# import ssl

# try:
#     _create_unverified_https_context = ssl._create_unverified_context
# except AttributeError:
#     pass
# else:
#     ssl._create_default_https_context = _create_unverified_https_context

# nltk.download()

def syncheck(data):
    synomized_count = 0
    synomized_words = []
    data = remove_extra_spaces(data)
    words = re.findall(r"[\w']+|[.,!?;() ]", data)
    output_words = []
    data_id = 0
    index = 0
    globalIndex = 0
    # сөз тіркестерін іздейміз
    while globalIndex<len(words):
        index = len(words)
        found = False
        while (index>globalIndex):
            # if words[index-1] in [",", ".", "!", "?", ";", "-", "\"", "`", "$", "^", "*", "+", "(", ")"] or index==len(words):
            wordForSearch = remove_extra_spaces(' '.join(words[globalIndex:index]))
            while len(wordForSearch)>1:
                if wordForSearch[-1]==" ":
                    break
                ret = wordForSearch
                # екі немесе 4 сөзден тұратын сөзтіркестерін базадан іздейміз
                count = len(wordForSearch.split(' '))
                if count > 1 and count < 4:
                    ret = DB.get_instance().findsyn(wordForSearch, 0, [])[0]
                if ret != wordForSearch:
                    words = merge_some_elements_of_string_array(words, globalIndex, index-globalIndex)
                    found = True
                    break
                wordForSearch = wordForSearch[:-1]
                wordForSearch = wordForSearch[:-1] + Lemms.change_syngor(Lemms, wordForSearch[-1])
            if found:
                break
            index-=1
        globalIndex+=1
    for index, word in enumerate(words):

        if word not in [",", ".", "!", "?", ";", "-", "\"", "`", "$", "^", "*", "+", "(", ")"] and word.strip() and not is_person_name(word, data, index == 0):
            isWordUpper = word[0].isupper()
            word_instance = Word(word.lower(), synomized_count, synomized_words)
            word_instance.look_for_synonym()
            word_instance.first_synonym = ''.join(word_instance.first_synonym)
            if isWordUpper: 
                if len(word_instance.first_synonym)>0:
                    word_instance.first_synonym = word_instance.first_synonym.capitalize()
                    print(word_instance.first_synonym)
                elif word_instance.has_synonym():
                    word_instance.capitalize_synonym()
            if word_instance.has_synonym() and word_instance.is_correct():
                word_instance.set_synonym(word_instance.get_synonym() + word_instance.get_trash_part())
                translated_word = getHtml(word_instance.get_first_part(), word_instance.find_extra_chars(word_instance.get_first_part(), word), data_id, f"{word_instance.get_first_synonym()} {word_instance.get_synonym()}", word_instance.get_family())
                data_id += 1
            else:
                translated_word = word
            synomized_count = word_instance.synomized_count
            output_words.append(translated_word) 
        else:
            output_words.append(word)
    return [output_words, synomized_words]

# Open the CSV file for reading
with open(os.path.join(os.path.dirname(__file__), "asd.csv"), 'r') as csvfile:
    csvreader = csv.reader(csvfile)
    
    # Iterate through each row
    for row in csvreader:
        if len(row) >= 6:  # Ensure the row has at least 6 columns
            value_in_6th_column = row[5]  # Index 5 corresponds to the 6th column (0-based indexing)
            # print(value_in_6th_column)
            if value_in_6th_column == "":
                continue
            if value_in_6th_column == "Сall орталықтың тынысымен танысу мақсатында дін мамандарымен тілдескен едік.":
                print("##############################")
                print(value_in_6th_column)
                print(syncheck(value_in_6th_column))
                print("##############################")
            i += 1
print(i)


# con = sqlite3.connect("tutorial.db")
# cur = con.cursor()
# # cur.execute("CREATE TABLE movie(title, year, score)")
# res = cur.execute("SELECT name FROM sqlite_master")
# result = res.fetchone()
# print(result)
