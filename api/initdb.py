import csv
import psycopg2
conn = psycopg2.connect(database="userdb", user="postgres", password="magzhan2005", host="localhost", port="5432")
cur = conn.cursor()
csv_file_path = '/Users/magzhanzhumabaev/Downloads/synonym.csv'

def get_pos_tag_names(pos):
    PosName = ""
    if len(pos.split('/')) > 1:
        pos = pos.split('/')[0]
    pos = pos.strip().lower()
    if pos == "Зат есім".strip().lower():
        PosName = 1
    elif pos == "Сын есім".strip().lower():
        PosName = 2
    elif pos == "Сан есім".strip().lower():
        PosName = 3
    elif pos == "Есімдік".strip().lower():
        PosName = 4
    elif pos == "Етістік".strip().lower():
        PosName = 5
    elif pos == 'Еліктеуіш'.strip().lower():
        PosName = 6
    elif pos == "Одағай".strip().lower():
        PosName = 7
    elif pos == "Шылау".strip().lower():
        PosName = 8
    elif pos == "Үстеу".strip().lower():
        PosName = 9
    return PosName
def insert_synonym(synonym, id):
    if synonym == "":
        return
    query = 'INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id;'
    cur.execute(query, (synonym,))
    synonym_id = cur.fetchone()[0]
    query = 'INSERT INTO synonym_word (word_id, synonym_id) VALUES (%s, %s);'
    cur.execute(query, (id, synonym_id))

def insert_paraphrase(paraphrase, id):
    if paraphrase == "":
        return
    query = 'INSERT INTO paraphrases (paraphrase) VALUES (%s) RETURNING id;'
    cur.execute(query, (paraphrase,))
    paraphrase_id = cur.fetchone()[0]
    query = 'INSERT INTO paraphrase_word (word_id, paraphrase_id) VALUES (%s, %s)'
    cur.execute(query, (id, paraphrase_id))
with open(csv_file_path, 'r') as file:
    csv_reader = csv.reader(file, delimiter=';')
    next(csv_reader)
    for row in csv_reader:
        print("ROW:", row)
        words = row[0]
        words_family = row[1]
        status = row[2]
        meaning = row[3]
        example = row[4]
        synonym1 = row[5]
        synonym2 = row[6]
        synonym3 = row[7]
        synonym4 = row[8]
        synonym5 = row[9]
        synonym6 = row[10]
        synonym7 = row[11]
        paraphrase1 = row[12]
        paraphrase2 = row[13]
        paraphrase3 = row[14]
        paraphrase4 = row[15]
        paraphrase5 = row[16]
        paraphrase6 = row[17]
        if(words_family is ""):
            continue
        insert_query = "INSERT INTO synamizer (words, words_family, status, meaning,example, pos) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id;"
        data = (words, words_family, status, meaning,example, get_pos_tag_names(words_family))
        cur.execute(insert_query, data)
        id = cur.fetchone()[0]
        insert_synonym(synonym1, id)
        insert_synonym(synonym2, id)
        insert_synonym(synonym3, id)
        insert_synonym(synonym4, id)
        insert_synonym(synonym5, id)
        insert_synonym(synonym6, id)
        insert_synonym(synonym7, id)
        insert_paraphrase(paraphrase1, id)
        insert_paraphrase(paraphrase2, id)
        insert_paraphrase(paraphrase3, id)
        insert_paraphrase(paraphrase4, id)
        insert_paraphrase(paraphrase5, id)
        insert_paraphrase(paraphrase6, id)
conn.commit()
cur.close()
conn.close()
