from flask_sqlalchemy import SQLAlchemy
import psycopg2
from app import app

db = SQLAlchemy(app)

class DB():
    @staticmethod
    def get_db_connection():
        conn = psycopg2.connect(
            host="db",
            dbname="userdb",
            user='postgres',
            password='magzhan2005')
        return conn

    
    
    @staticmethod
    def add_Synonyms(synonym, word_id):
        connection = DB.get_db_connection()
        cur = connection.cursor()
        cur.execute("INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id", (synonym, ))
        syn_id = cur.fetchone()['id']
        cur.execute("INSERT INTO synonym_word (word_id, synonym_id) VALUES(%s, %s)", (word_id, syn_id))
        cur.close()
        connection.commit()
        connection.close()

    @staticmethod
    def add_Paraphrases(paraphrase, word_id):
        connection = DB.get_db_connection()
        cur = connection.cursor()
        cur.execute("INSERT INTO paraphrases (paraphrase) VALUES (%s) RETURNING id", (paraphrase, ))
        par_id = cur.fetchone()['id']
        cur.execute("INSERT INTO paraphrase_word (word_id, paraphrase_id) VALUES(%s, %s)", (word_id, par_id))
        cur.close()
        connection.commit()
        connection.close()

    @staticmethod
    def findsyn(word, synomized_count, synomized_words):
        cur = DB.get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cur.execute("SELECT s.synonym FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(REPLACE(z.words, ' ', '')) = LOWER(%s);", (word,))#LOWER(z.words)
        synonym = cur.fetchone()
        if synonym == None:
            return [word, synomized_count]
        synomized_count += 1
        synomized_words.append(synonym.get('synonym'))
        return [synonym.get('synonym'), synomized_count]
    
    @staticmethod
    def looking_for_synonym(cur, word, family):
        if family != '':
            cur.execute(
            "SELECT s.synonym, z.words "
            "FROM synonyms s "
            "INNER JOIN synonym_word sw ON s.id = sw.synonym_id "
            "INNER JOIN synamizer z ON z.id = sw.word_id "
            "WHERE LOWER(TRIM(z.words)) = LOWER(%s) AND LOWER(TRIM(z.words_family)) = LOWER(%s)"
            "AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id);",
            (word,family)
            )
        else:
            cur.execute(
            "SELECT s.synonym, z.words "
            "FROM synonyms s "
            "INNER JOIN synonym_word sw ON s.id = sw.synonym_id "
            "INNER JOIN synamizer z ON z.id = sw.word_id "
            "WHERE LOWER(TRIM(z.words)) = LOWER(%s)"
            "AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id);",
            (word,))
        synonyms = cur.fetchall()
        return synonyms
    
    @staticmethod
    def getSchoolTermins(first, filters, word):
        second = first + 10
        connection = DB.get_db_connection()
        cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        school_class = filters["class"]["value"]
        subject = filters['subject']["value"]

        query = """
            SELECT st.termin, st.id, st.definition, st.class, s.subject AS subject
            FROM school_termins st
            LEFT JOIN subjects s ON st.subject_id = s.id
        """

        conditions = []
        params = []

        if school_class:
            conditions.append("class = %s")
            params.append(school_class)

        if subject:
            conditions.append("subject_id = %s")
            params.append(subject['id'])
        if word:
            conditions.append("termin ILIKE %s OR definition ILIKE %s")
            params.append(f"{word}%")
            params.append(f"{word}%")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        query += " OFFSET %s LIMIT %s;"

        params.extend([first, second])
        cursor.execute(query, params)
        data = cursor.fetchall()
        return data

        
    @staticmethod
    def countSchoolTermins():
        cursor = DB.get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        cursor.execute("SELECT COUNT(*) FROM school_termins")
        count = cursor.fetchone()
        return count
    
    @staticmethod
    def getLegacies(parent_id):
        cur = DB.get_db_connection().cursor(cursor_factory = psycopg2.extras.RealDictCursor)#mysql.get_db().cursor(pymysql.cursors.DictCursor)#cur = conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        if parent_id == None:  # Если parent_id равно 0, выбираем корневые записи
            cur.execute("SELECT id AS key, name AS label, path AS data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL;")
        else:  # В противном случае выбираем записи с указанным parent_id
            cur.execute("SELECT id as key, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s", [parent_id])


        results = cur.fetchall()
        return results
    
    @staticmethod
    def addTag(definition_id, file_id):
        connection = DB.get_db_connection()
        cursor = connection.cursor()
        cursor.execute("INSERT INTO tag_legacy (tag_id, legacy_id) VALUES (%s, %s);", (definition_id, file_id))
        connection.commit()
        cursor.close()
        connection.close()

    @staticmethod
    def addWord(word, family, meaning, pos):
        connection = DB.get_db_connection()
        cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cur.execute("""INSERT INTO synamizer (words, words_family, meaning, pos, status)
        VALUES (%s, %s, %s, %s, 'омоним') RETURNING id""", (word, family, meaning, pos))
        connection.commit()
        row = cur.fetchone()
        cur.close()
        connection.close()
        return row
    
    @staticmethod
    def addTermin(termin, subject_id, definition, school_class):
        connection = DB.get_db_connection()
        cur = connection.cursor()
        cur.execute("INSERT INTO school_termins (termin, definition, subject_id, class) VALUES (%s, %s, %s, %s)", (termin, definition, subject_id, school_class))
        connection.commit()
        cur.close()
        connection.close()

    @staticmethod
    def get_subject_id(subject):
        connection = DB.get_db_connection()
        cur = connection.cursor()
        cur.execute("SELECT id FROM subjects WHERE subject = %s", (subject,))
        subject_id = cur.fetchone()[0]
        return subject_id
    
    @staticmethod
    def get_subjects():
        cursor = DB.get_db_connection().cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cursor.execute("SELECT * FROM subjects")
        return cursor.fetchall()

    @staticmethod
    def add_subject(subject):
        connection = DB.get_db_connection()
        cursor = connection.cursor()
        cursor.execute("INSERT INTO subjects (subject) VALUES(%s)", (subject,))
        connection.commit()
        cursor.close()
        connection.close()


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(80), unique=True, nullable=False)
    password_salt = db.Column(db.String(120), nullable=False)
    password_hash = db.Column(db.String(120), nullable=False)

class UserRole(db.Model):
    __tablename__ = 'user_role'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer)
    role_id = db.Column(db.Integer)

class Role(db.Model):
    __tablename__ = 'role'
    role_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    description = db.Column(db.String(100), unique=True, nullable=False)