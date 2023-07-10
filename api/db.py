from flask_sqlalchemy import SQLAlchemy
import psycopg2
from app import app
import os, hashlib
from sqlalchemy import func


db = SQLAlchemy(app)

class DBConfig:
    def __init__(self, password) -> None:
        self.password = password
        self.connection = self.get_db_connection()
    def get_db_connection(self, dbname='userdb', host='db', user="postgres"):
        
        conn = psycopg2.connect(
            host=host,
            dbname=dbname,
            user=user,
            password=self.password,
            )
        self.cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        return conn

class DatabaseOperations(DBConfig):
        instance = None
        def __init__(self, password) -> None:
            super().__init__(password)

        def insert_query(self, query, data=None):
            if self.cursor.closed:
                self.delete_instance()
                self = self.get_instance()
            try:
                self.cursor.execute(query, data)
            except Exception as e:
                print("ERROR:", e)
                self.connection.rollback()
        def commit_db(self):
            self.connection.commit()

        def close_db(self):
            self.commit_db()
            self.connection.close()
            self.cursor.close()
            self.delete_instance()
        def fetchone(self):
            return self.cursor.fetchone()
        
        def fetchall(self):
            return self.cursor.fetchall()
        
        def select_all_query(self, query, data=None):
            if self.cursor.closed:
                self.delete_instance()
                self = self.get_instance()
            self.cursor.execute(query, data)
            return self.cursor.fetchall()
        
        def select_one_query(self, query, data=None):
            if self.cursor.closed:
                self.delete_instance()
                self = self.get_instance()
            try:
                print("self.cursor.closed:", self.cursor.closed)
                self.cursor.execute(query, data)
            except Exception as e:
                print("An execption occured:", str(e))
                self.connection.rollback()
            return self.cursor.fetchone()
        
        def execute(self,query):
            if self.cursor.closed:
                self.delete_instance()
                self = self.get_instance()
            self.cursor.execute(query)

        @classmethod
        def delete_instance(cls):
            cls.instance = None

        @classmethod
        def get_instance(cls):
            password = app.config['DB_PASSWORD']
            if cls.instance is None:
                cls.instance = DB(password)
            return cls.instance
        
class StaticOperatioins:
    @staticmethod
    def generate_salt():
        salt = os.urandom(16).hex()
        return salt
    
    @staticmethod
    def hash_password(password, salt):
        password_salt = password + salt
        password_hash = StaticOperatioins.hash_code(password_salt)
        return password_hash
    
    @staticmethod
    def hash_code(code):
        return hashlib.sha256(str(code).encode()).hexdigest()

class DB(DatabaseOperations):
    def addWord(self, word, family, meaning, pos):
        self.insert_query("""INSERT INTO synamizer (words, words_family, meaning, pos, status)
        VALUES (%s, %s, %s, %s, 'омоним') RETURNING id""", (word, family, meaning, pos))
        row_id = self.fetchone()
        self.close_db()
        return row_id
    
    def add_Synonyms(self, synonym, word_id):
        
        insert_synonyms = "INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id"
        self.insert_query(insert_synonyms, (synonym, ))
        
        syn_id = self.fetchone()['id']
        


        insert_syn_word = "INSERT INTO synonym_word (word_id, synonym_id) VALUES(%s, %s)"
        self.insert_query(insert_syn_word, (word_id, syn_id))
        self.close_db()

    def add_Paraphrases(self, paraphrase, word_id):
        
        query = "INSERT INTO paraphrases (paraphrase) VALUES (%s) RETURNING id"
        self.insert_query(query, (paraphrase, ))
        par_id = self.fetchone()['id']
        
        query = "INSERT INTO paraphrase_word (word_id, paraphrase_id) VALUES(%s, %s)"
        self.insert_query(query, (word_id, par_id))
        self.close_db()
    
    def findsyn(self, word, synomized_count, synomized_words):
        query = "SELECT s.synonym FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(REPLACE(z.words, ' ', '')) = LOWER(%s);"
        synonym = self.select_one_query(query, (word,))
        if synonym == None:
            return [word, synomized_count]
        synomized_count += 1
        synomized_words.append(synonym.get('synonym'))
        return [synonym.get('synonym'), synomized_count]
        

    
    def findsyn_with_family(self, word, family):
        if family != '':
            query = ''' SELECT s.synonym, z.words 
            FROM synonyms s 
            INNER JOIN synonym_word sw ON s.id = sw.synonym_id 
            INNER JOIN synamizer z ON z.id = sw.word_id 
            WHERE LOWER(TRIM(z.words)) = LOWER(%s) AND LOWER(TRIM(z.words_family)) = LOWER(%s)
            AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id);'''
            data = (word,family)
            
        else:
            query = '''SELECT s.synonym, z.words 
            FROM synonyms s 
            INNER JOIN synonym_word sw ON s.id = sw.synonym_id 
            INNER JOIN synamizer z ON z.id = sw.word_id 
            WHERE LOWER(TRIM(z.words)) = LOWER(%s)
            AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id);'''
            data = (word,)
        synonyms = self.select_all_query(query, data)
        return synonyms
    
    def getSchoolTermins(self, first, filters, word):
        second = first + 10
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
            conditions.append("(termin ILIKE %s OR definition ILIKE %s)")
            params.append(f"{word}%")
            params.append(f"{word}%")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        query += " OFFSET %s LIMIT %s;"

        params.extend([first, second])
        
        data = self.select_all_query(query, params)
        return data

        
    def countSchoolTermins(self):
        count = self.select_one_query("SELECT COUNT(*) FROM school_termins")
        return count
    
    def getLegacies(self, parent_id):
        if parent_id == None:
            query = "SELECT id AS key, name AS label, path AS data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL;"
            results = self.select_all_query(query)
        else: 
            query = "SELECT id as key, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s"
            data = [parent_id]
            results = self.select_all_query(query, data)
        return results
    
    def get_download_legacy_path(self, file_id):
        results = self.select_all_query("SELECT path from legacy WHERE id = %s",[file_id])
        for row in results:
            
            path = row.get('path')
        return path
    
    def addTag(self, definition_id, file_id):
        self.insert_query("INSERT INTO tag_legacy (tag_id, legacy_id) VALUES (%s, %s);", (definition_id, file_id))
        self.close_db()
        
    
    
    def addTermin(self, termin, subject_id, definition, school_class):
        self.insert_query("INSERT INTO school_termins (termin, definition, subject_id, class) VALUES (%s, %s, %s, %s)", (termin, definition, subject_id, school_class))
        self.close_db()
        
    def get_subject_id(self, subject): 
        subject_id = self.select_one_query("SELECT id FROM subjects WHERE subject = %s", (subject,))[0]
        return subject_id
    
    def get_subjects(self):
        subjects = self.select_all_query("SELECT * FROM subjects")
        return subjects

    def add_subject(self, subject):
        self.insert_query("INSERT INTO subjects (subject) VALUES(%s)", (subject,))
        self.close_db()
    
    def findword(self, data, family=None):
        if family is None:
            query = 'SELECT DISTINCT id, words_family, status, meaning, words, pos FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s));'
            temp_families = self.select_all_query(query, (data,))
            return temp_families
        query = 'SELECT DISTINCT id, status,words_family, meaning, words FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));'
        return self.select_all_query(query, (data, family))

    def find_similarword(self, data):
        all_words = self.select_all_query("SELECT DISTINCT words FROM synamizer WHERE LOWER(TRIM(words)) LIKE LOWER(TRIM(%s)) LIMIT 3;", (data + "%", ) )
        return all_words
    
    def find_paraphrase_by_word(self, word):
        paraphrase = self.select_all_query("SELECT s.paraphrase FROM paraphrases s INNER JOIN paraphrase_word sw ON s.id = sw.paraphrase_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(TRIM(z.words)) = LOWER(%s);", (word,))
        return paraphrase
    def update_legacy_name(self, fileName, fileID):
        self.insert_query('UPDATE legacy SET name = %s WHERE id = %s', (fileName, fileID))

    def addLegacy(self, key, path_to_save, filename, content_type, parent_id):
        self.execute('ALTER SEQUENCE legacy_id_seq RESTART WITH 100;')
        self.insert_query("INSERT INTO legacy (name, path, parent_id, is_file) VALUES (%s, %s, %s, %s);", (key, path_to_save + "/" + filename + '.' + content_type, parent_id, 1))
        self.close_db()

    def delete_legacy(self, fileID):
        self.insert_query('DELETE FROM legacy WHERE id = %s RETURNING *;', (fileID,))
        deleted_row = self.fetchone()
        self.close_db()
        return deleted_row
    
    def search_book(self, data):
        results = self.select_all_query("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name ILIKE %s;", ('%' + data + '%',))
        return results
    
    def find_user(self,current_user):
        results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
        return results
    
    def get_role(self, role_id):
        temp = Role.query.filter_by(role_id=role_id).one_or_none()
        return temp
    def delete_post(self, id):
        self.insert_query("DELETE FROM termin WHERE id = %s", (id,))
        self.close_db()

    def create_post(self, name, descrpition, example):
        self.insert_query("INSERT INTO termin (name, description, examples) VALUES (%s, %s, %s)", (name, descrpition, example))
        self.close_db()

    def search_classification(self, search_text, rows,offset):
        found = self.select_all_query("SELECT * FROM termin WHERE name LIKE %s or description LIKE %s or examples LIKE %s LIMIT %s OFFSET %s",
            ('%' + search_text + '%','%' + search_text + '%','%' + search_text + '%',rows,offset))
        return found
    
    def get_classification(self, rows,offset):
        termins = self.select_all_query("SELECT * FROM termin LIMIT %s OFFSET %s",(rows,offset,))
        return termins
    
    def isUserAdmin(self, current_user):
        results = DB.get_instance().find_user(current_user)
        role_ids = [result[0] for result in results]
        roles = []
        for i in role_ids:
            roles.append(DB.get_instance().get_role(i).name)
        return 'admin' in roles
    
    def save_user(self, email, password, confirmation_code, full_name):
        salt = StaticOperatioins.generate_salt()
        password_hash = StaticOperatioins.hash_password(password, salt)
        confirmation_code_hash = StaticOperatioins.hash_code(confirmation_code)
        max_id = db.session.query(func.max(User.id)).scalar() or 0
        new_id = max_id + 1
        user = User(id=new_id,email=email, password_salt=salt, password_hash=password_hash, is_verified=False, confirmation_code_hash = confirmation_code_hash, full_name = full_name)
        existing_user = self.get_user_by_email(email)
        if not (existing_user is None):
            is_verified = existing_user.is_verified
            if is_verified:
                if not self.is_offer_activated(id=user.existing_user.id):
                    return ValueError('Сұранысыңыз әлі қабылданбады')
                raise ValueError('Қолданушы базада бұрыннан бар!')
            else:
                db.session.delete(existing_user)
                db.session.commit()
        db.session.add(user)
        db.session.commit()
    def check_credentials(self, email, password):
        user = User.query.filter_by(email=email).one_or_none()
        if not user.is_verified:
            return None
        if not StaticOperatioins.hash_password(password, user.password_salt) == user.password_hash:
            return None
        return user
    def get_conf_code(self, email):
        user = self.get_user_by_email(email)
        return user.confirmation_code_hash
    def check_code(self, code, conf_code):
        return StaticOperatioins.hash_code(code) == conf_code
    def verify_user(self, email):
        user = self.get_user_by_email(email)
        user.is_verified = True
        db.session.commit()
        return user
    def isUserExist(self, email):
        user = self.get_user_by_email(email)
        return user is not None
    def get_user_by_email(self, email):
        return User.query.filter_by(email=email).one_or_none()
    def is_offer_activated(self, id):
        return Offers.query.filter_by(offer_id=id).one_or_none().activated
    def isUserActivated(self, user):
        return Offers.query.filter_by(offer_id=user.id, activate_type=2).one_or_none().activated
    
    def getOffers(self):
        self.execute('''
            SELECT o.*, s.*, u.*
            FROM offers o
            LEFT JOIN synamizer s ON o.activate_type = 1 AND s.id = o.offer_id
            LEFT JOIN users u ON o.activate_type = 2 AND u.id = o.user_id;
        ''')
        return self.fetchall()
    
    def activate_offer(self, offer_id, activate_type):
        print("activate_type:", activate_type)
        print("id:", offer_id)
        try:
            offer = Offers.query.filter_by(offer_id=offer_id, activate_type=activate_type).one_or_none()
            if activate_type == 2:
                userRole = UserRole(user_id=offer_id, role_id = 1)
                db.session.add(userRole)
            offer.activated = True
            db.session.commit()
        except Exception as e:
            print("An error occurred:", str(e))


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(80), unique=True, nullable=False)
    password_salt = db.Column(db.String(120), nullable=False)
    password_hash = db.Column(db.String(120), nullable=False)
    is_verified = db.Column(db.Boolean, nullable=False, default=False)
    full_name = db.Column(db.String(120), nullable=False)
    confirmation_code_hash = db.Column(db.String(120))

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
class Offers(db.Model):
    __tablename__ = 'offers'
    id = db.Column(db.Integer, primary_key=True)
    offer_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    activate_type = db.Column(db.Integer)
    activated = db.Column(db.Boolean, nullable=False, default=False)

class ActivateTypes(db.Model):
    __tablename__ = 'activate_types'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)