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
    def add_Synonyms(cur, synonym, word_id):
        cur.execute("INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id", (synonym, ))
        syn_id = cur.fetchone()['id']
        cur.execute("INSERT INTO synonym_word (word_id, synonym_id) VALUES(%s, %s)", (word_id, syn_id))

    @staticmethod
    def add_Paraphrases(cur, paraphrase, word_id):
        cur.execute("INSERT INTO paraphrases (paraphrase) VALUES (%s) RETURNING id", (paraphrase, ))
        par_id = cur.fetchone()['id']
        cur.execute("INSERT INTO paraphrase_word (word_id, paraphrase_id) VALUES(%s, %s)", (word_id, par_id))

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