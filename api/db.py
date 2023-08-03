from flask_sqlalchemy import SQLAlchemy
import psycopg2
from app import app
import os, hashlib
from sqlalchemy import func
from datetime import datetime
# from middleware import Middleware

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

        def _insert_query(self, query, data=None):
            if self.cursor.closed:
                self._delete_instance()
                self = self.get_instance()
            try:
                self.cursor.execute(query, data)
            except Exception as e:
                print("ERROR:", e)
                self.connection.rollback()
        def _commit_db(self):
            self.connection.commit()

        def _close_db(self):
            self._commit_db()
            self.connection.close()
            self.cursor.close()
            self._delete_instance()
        def fetchone(self):
            return self.cursor.fetchone()
        
        def fetchall(self):
            return self.cursor.fetchall()
        
        def _select_all_query(self, query, data=None):
            if self.cursor.closed:
                self._delete_instance()
                self = self.get_instance()
            self.cursor.execute(query, data)
            return self.cursor.fetchall()
        
        def _select_one_query(self, query, data=None):
            if self.cursor.closed:
                self._delete_instance()
                self = self.get_instance()
            try:
                self.cursor.execute(query, data)
            except Exception as e:
                print("An execption occured:", str(e))
                self.connection.rollback()
            try:
                return self.cursor.fetchone()
            except:
                return None
        
        def execute(self,query, data = None):
            if self.cursor.closed:
                self._delete_instance()
                self = self.get_instance()
            self.cursor.execute(query, data)

        @classmethod
        def _delete_instance(cls):
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
    def addWord(self, word, family, meaning, pos, example, user_id):
        self._insert_query("""INSERT INTO synamizer (words, words_family, meaning, pos, example, status)
        VALUES (%s, %s, %s, %s, %s,'бірмағыналы') RETURNING id""", (word, family, meaning, pos, example))
        row_id = self.fetchone()['id']
        self._insert_query('''INSERT INTO offers (offer_id, user_id, activate_type) VALUES(%s, %s, 1)''', (row_id, user_id))
        self._close_db()
        return row_id
    
    def add_Synonyms(self, synonym, word_id, user_id):
        print("inside add_Synonyms:")
        insert_synonyms = "INSERT INTO synonyms (synonym) VALUES (%s) RETURNING id"
        self._insert_query(insert_synonyms, (synonym, ))
        syn_id = self.fetchone()['id']
        print("syn_id:", syn_id)
        insert_syn_word = "INSERT INTO synonym_word (word_id, synonym_id) VALUES(%s, %s)"
        self._insert_query(insert_syn_word, (word_id, syn_id))
        self._insert_query('''INSERT INTO offers (offer_id, user_id, activate_type) VALUES(%s, %s, 3)''', (syn_id, user_id))
        self._close_db()

    def add_Paraphrases(self, paraphrase, word_id, user_id):
        query = "INSERT INTO paraphrases (paraphrase) VALUES (%s) RETURNING id"
        self._insert_query(query, (paraphrase, ))
        par_id = self.fetchone()['id']
        query = "INSERT INTO paraphrase_word (word_id, paraphrase_id) VALUES(%s, %s)"
        self._insert_query(query, (word_id, par_id))
        self._insert_query('''INSERT INTO offers (offer_id, user_id, activate_type) VALUES(%s, %s, 3)''', (par_id, user_id))
        self._close_db()
    
    def findsyn(self, word, synomized_count, synomized_words, pos = None):
        if pos is None:
            query = '''SELECT s.synonym FROM synonyms s 
            INNER JOIN synonym_word sw ON s.id = sw.synonym_id 
            INNER JOIN synamizer z ON z.id = sw.word_id 
            INNER JOIN offers o ON o.offer_id = sw.synonym_id
            WHERE LOWER(REPLACE(z.words, ' ', '')) = LOWER(TRIM(%s))
            AND o.activated = true;'''
            param = (word,)
        else:
            param = (word,pos)
            query = "SELECT s.synonym FROM synonyms s INNER JOIN synonym_word sw ON s.id = sw.synonym_id INNER JOIN synamizer z ON z.id = sw.word_id WHERE LOWER(REPLACE(z.words, ' ', '')) = LOWER(TRIM(%s)) AND z.pos = %s;"
        synonym = self._select_one_query(query, param)
        if synonym == None:
            return [word, synomized_count]
        synomized_count += 1
        synomized_words.append(synonym.get('synonym'))
        print("synonym.get('synonym'):".upper(), synonym.get('synonym'))
        return [synonym.get('synonym'), synomized_count]
        

    
    def findsyn_with_family(self, word, family):
        if family != '':
            query = ''' SELECT s.synonym, z.words, s.id
            FROM synonyms s 
            INNER JOIN synonym_word sw ON s.id = sw.synonym_id 
            INNER JOIN synamizer z ON z.id = sw.word_id 
            INNER JOIN offers o ON sw.synonym_id = o.offer_id
            WHERE LOWER(TRIM(z.words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(z.words_family)) = LOWER(TRIM(%s))
            AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id)
            AND o.activated = true;'''
            data = (word,family)
            
        else:
            query = '''SELECT s.synonym, z.words 
            FROM synonyms s 
            INNER JOIN synonym_word sw ON s.id = sw.synonym_id 
            INNER JOIN synamizer z ON z.id = sw.word_id 
            INNER JOIN offers o ON sw.synonym_id = o.offer_id
            WHERE LOWER(TRIM(z.words)) = LOWER(TRIM(%s))
            AND sw.word_id IN (SELECT word_id FROM synonym_word WHERE synonym_id = sw.synonym_id)
            AND o.activated = true;'''
            data = (word,)
        synonyms = self._select_all_query(query, data)
        if synonyms is None:
            return synonyms
        return synonyms
    
    def getSchoolTermins(self, first, filters, word,isChildren=False):
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
        
        if not school_class and isChildren:
            conditions.append("class <= 4")

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
        print("QUERY:", query)
        data = self._select_all_query(query, params)
        return data

        
    def countSchoolTermins(self, isChildren=False):
        if isChildren:
            count = self._select_one_query("SELECT COUNT(*)FROM school_termins WHERE class <= 4")
        else:
            count = self._select_one_query("SELECT COUNT(*) FROM school_termins")
        return count
    
    def getLegacies(self, parent_id):
        if parent_id == None:
            query = "SELECT id AS key, name AS label, path AS data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id IS NULL;"
            results = self._select_all_query(query)
        else: 
            query = "SELECT id as key, name as label, path as data, parent_id, is_file, concat('pi pi-fw ', CASE WHEN is_file = 1 THEN 'pi-file' ELSE 'pi-folder' END) as icon FROM legacy WHERE parent_id=%s"
            data = [parent_id]
            results = self._select_all_query(query, data)
        return results
    
    def get_download_legacy_path(self, file_id):
        results = self._select_all_query("SELECT path from legacy WHERE id = %s",[file_id])
        for row in results:
            path = row.get('path')
        return path
    
    def addTag(self, definition_id, file_id):
        self._insert_query("INSERT INTO tag_legacy (tag_id, legacy_id) VALUES (%s, %s);", (definition_id, file_id))
        self._close_db()
        
    
    
    def addTermin(self, termin, subject_id, definition, school_class):
        self._insert_query("INSERT INTO school_termins (termin, definition, subject_id, class) VALUES (%s, %s, %s, %s)", (termin, definition, subject_id, school_class))
        self._close_db()
        
    def get_subject_id(self, subject): 
        subject_id = self._select_one_query("SELECT id FROM subjects WHERE subject = %s", (subject,))[0]
        return subject_id
    
    def get_subjects(self):
        subjects = self._select_all_query("SELECT * FROM subjects")
        return subjects

    def add_subject(self, subject):
        self._insert_query("INSERT INTO subjects (subject) VALUES(%s)", (subject,))
        self._close_db()
    
    def findword(self, data, family=None):
        if family is None:
            query = 'SELECT DISTINCT id, words_family, status, meaning, words, pos, example FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s));'
            temp_families = self._select_all_query(query, (data,))
            return temp_families
        query = 'SELECT DISTINCT id, status,words_family, meaning, words FROM synamizer WHERE LOWER(TRIM(words)) = LOWER(TRIM(%s)) AND LOWER(TRIM(words_family)) = LOWER(TRIM(%s));'
        return self._select_all_query(query, (data, family))

    def find_similarword(self, data):
        all_words = self._select_all_query("SELECT DISTINCT words FROM synamizer WHERE LOWER(TRIM(words)) LIKE LOWER(TRIM(%s)) LIMIT 3;", (data + "%", ) )
        return all_words
    
    def find_paraphrase_by_word(self, word):
        paraphrase = self._select_all_query('''SELECT s.paraphrase, s.id FROM paraphrases s 
                                           INNER JOIN paraphrase_word sw ON s.id = sw.paraphrase_id 
                                           INNER JOIN synamizer z ON z.id = sw.word_id 
                                           INNER JOIN offers o ON o.offer_id = sw.paraphrase_id
                                           WHERE LOWER(TRIM(z.words)) = LOWER(TRIM(%s))
                                           AND o.activated = true;''', (word,))
        return paraphrase
    def update_legacy_name(self, fileName, fileID):
        self._insert_query('UPDATE legacy SET name = %s WHERE id = %s', (fileName, fileID))

    def addLegacy(self, key, path_to_save, filename, content_type, parent_id):
        self.execute('ALTER SEQUENCE legacy_id_seq RESTART WITH 100;')
        self._insert_query("INSERT INTO legacy (name, path, parent_id, is_file) VALUES (%s, %s, %s, %s);", (key, path_to_save + "/" + filename + '.' + content_type, parent_id, 1))
        self._close_db()

    def delete_legacy(self, fileID):
        self._insert_query('DELETE FROM legacy WHERE id = %s RETURNING *;', (fileID,))
        deleted_row = self.fetchone()
        self._close_db()
        return deleted_row
    
    def search_book(self, data):
        results = self._select_all_query("SELECT l.id as key , l.name as label, l.path as data, l.parent_id, l.is_file FROM tag t JOIN tag_legacy tl ON t.id = tl.tag_id JOIN legacy l ON l.id = tl.legacy_id WHERE t.name ILIKE %s;", ('%' + data + '%',))
        return results
    
    def find_user(self,current_user):
        results = UserRole.query.filter_by(user_id=current_user.id).with_entities(UserRole.role_id).all()
        return results
    
    def get_role(self, role_id):
        temp = Role.query.filter_by(role_id=role_id).one_or_none()
        return temp
    def delete_post(self, id):
        self._insert_query("DELETE FROM termin WHERE id = %s", (id,))
        self._close_db()

    def update_post(self,id, name, descrpition, example ):
        self._insert_query("UPDATE termin SET name = %s, description = %s, examples = %s WHERE id = %s", (name, descrpition,example, id))
        self._close_db()

    def create_post(self, name, descrpition, example):
        self._insert_query("INSERT INTO termin (name, description, examples) VALUES (%s, %s, %s)", (name, descrpition, example))
        self._close_db()

    def search_classification(self, search_text, rows,offset):
        found = self._select_all_query("SELECT * FROM termin WHERE name LIKE %s or description LIKE %s or examples LIKE %s LIMIT %s OFFSET %s",
            ('%' + search_text + '%','%' + search_text + '%','%' + search_text + '%',rows,offset))
        return found
    
    def get_classification(self, rows,offset):
        termins = self._select_all_query("SELECT * FROM termin LIMIT %s OFFSET %s",(rows,offset,))
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
        offer =  Offers.query.filter_by(offer_id=user.id, activate_type=2).one_or_none()
        return offer and offer.activated
    
    def getOffers(self, first, rows, status):
        if status is '':
            self.execute('''
                SELECT o.*, sr.*, u.*, s.synonym, p.paraphrase, sr2.words as syn_word, sr3.words as par_word
                FROM offers o
                LEFT JOIN synamizer sr ON o.activate_type = 1 AND sr.id = o.offer_id
                LEFT JOIN users u ON o.activate_type = 2 AND u.id = o.offer_id
                LEFT JOIN synonyms s ON o.activate_type = 3 AND s.id = o.offer_id
                LEFT JOIN paraphrases p ON o.activate_type = 4 AND p.id = o.offer_id
                LEFT JOIN synonym_word sw1 ON sw1.synonym_id = s.id
                LEFT JOIN synamizer sr2 ON sr2.id = sw1.word_id
                LEFT JOIN paraphrase_word pw1 ON pw1.paraphrase_id = p.id
                LEFT JOIN synamizer sr3 ON sr3.id = pw1.word_id
                OFFSET %s LIMIT %s;
            ''', (first, first + rows))
        else:
            activated = status == "Қабылданғандар"
            self.execute('''
                SELECT o.*, sr.*, u.*, s.synonym, p.paraphrase, sr2.words as syn_word, sr3.words as par_word
                FROM offers o
                LEFT JOIN synamizer sr ON o.activate_type = 1 AND sr.id = o.offer_id
                LEFT JOIN users u ON o.activate_type = 2 AND u.id = o.offer_id
                LEFT JOIN synonyms s ON o.activate_type = 3 AND s.id = o.offer_id
                LEFT JOIN paraphrases p ON o.activate_type = 4 AND p.id = o.offer_id
                LEFT JOIN synonym_word sw1 ON sw1.synonym_id = s.id
                LEFT JOIN synamizer sr2 ON sr2.id = sw1.word_id
                LEFT JOIN paraphrase_word pw1 ON pw1.paraphrase_id = p.id
                LEFT JOIN synamizer sr3 ON sr3.id = pw1.word_id
                WHERE o.activated = %s
                OFFSET %s LIMIT %s;
            ''', (activated, first, first + rows))

        return self.fetchall()
    
    def activate_offer(self, offer_id, activate_type):
        try:
            offer = Offers.query.filter_by(offer_id=offer_id, activate_type=activate_type).one_or_none()
            if activate_type == 2:
                userRole = UserRole(user_id=offer_id, role_id = 1)
                db.session.add(userRole)
            offer.activated = True
            db.session.commit()
        except Exception as e:
            print("An error occurred:", str(e))

    def get_amount_offers(self):
        count = self._select_one_query("SELECT COUNT(*) FROM offers;")
        today_offers = self._select_one_query('SELECT COUNT(*) FROM offers WHERE created_at::date = CURRENT_DATE;')
        return count, today_offers
    
    def get_amount_words(self):
        words_count = self._select_one_query('SELECT COUNT(*) FROM synamizer')
        words_count_activated = self._select_one_query('''
                                            SELECT COUNT(*) FROM synamizer s
                                            INNER JOIN offers o ON s.id = o.offer_id
                                            WHERE o.activated = true AND o.activate_type = 1;''')

        return words_count, words_count_activated
    
    def get_amount_users(self):
        users = self._select_one_query("SELECT COUNT(*) FROM users u INNER JOIN offers o ON o.offer_id = u.id WHERE o.activated = true AND o.activate_type = 2;")
        admins = self._select_one_query("SELECT COUNT(*) FROM users u INNER JOIN offers o ON o.offer_id = u.id INNER JOIN user_role ur ON ur.user_id = u.id WHERE o.activated = true AND ur.role_id = 2 AND o.activate_type = 2;")
        return users['count'], admins['count']
    
    def get_amount_synparaphrases(self):
        amount = self._select_one_query("SELECT ( (SELECT COUNT(*) FROM synonyms) + (SELECT COUNT(*) FROM paraphrases) ) AS amount;")
        activated_amount = self._select_one_query('''SELECT (
            (SELECT COUNT(*) FROM synonyms s
            INNER JOIN offers o ON o.offer_id = s.id
            WHERE o.activated = true AND o.activate_type = 3)
            +
            (SELECT COUNT(*) FROM paraphrases p
            INNER JOIN offers o ON o.offer_id = p.id
            WHERE o.activated = true AND o.activate_type = 4)
            ) AS total_row_count;
            ''')
        amount.update(activated_amount)
        return amount
    
    def get_inf_for_table(self, start):
        query= '''SELECT u.email, u.full_name, u.id, r.name FROM users u
            INNER JOIN offers o ON o.offer_id = u.id
            INNER JOIN user_role ur ON ur.user_id = u.id
            INNER JOIN role r ON r.role_id = ur.role_id
            WHERE o.activated = true AND o.activate_type = 2'''
        data = None
        if start != "":
            data = (start+"%",)
            query = query + " AND u.full_name ILIKE %s;"
        result = self._select_all_query(query, data)
        return result
    
    def word_view(self, date):
        result = self._select_one_query("SELECT COUNT(*) FROM synamizer WHERE DATE(created_at) = %s", (date,))
        return result
    def user_table(self):
        users_results = self._select_all_query('''SELECT COUNT(*), u.id, u.full_name, u.email FROM synamizer s
            INNER JOIN offers o ON o.offer_id = s.id
            INNER JOIN users u ON o.user_id = u.id
            WHERE o.activated = true AND o.activate_type = 1
            AND u.id = o.user_id
            GROUP BY u.id
            LIMIT 6
                        ''')
        return users_results
    def last_news(self):
        results = self._select_all_query('''SELECT *
        FROM offers o
        INNER JOIN users u ON o.user_id = u.id
        ORDER BY o.id DESC
        LIMIT 2''') 
        return results
    
    def delete_user(self, id):
        print("DELETE:", id)
        query = '''DELETE FROM offers WHERE activate_type = 2 AND offer_id = %s'''
        self._insert_query(query, (id, ))
        query = '''DELETE FROM user_role WHERE user_id = %s'''
        self._insert_query(query, (id, ))
        query = '''DELETE FROM users WHERE id = %s'''
        self._insert_query(query, (id, ))
        self._close_db()
    
    def up_user_role(self, id):
        print('user up:', id)
        max_id = db.session.query(func.max(UserRole.id)).scalar() or 0
        query = '''INSERT INTO user_role(user_id, role_id, id) VALUES(%s, 2, %s)'''
        self._insert_query(query, (id,max_id+1))
        self._close_db()

    def delete_syn(self, synonym_id):
        param = (synonym_id, )
        query = '''DELETE FROM synonyms WHERE id = %s'''
        self._insert_query(query, param)
        query = '''DELETE FROM synonym_word WHERE synonym_id = %s'''
        self._insert_query(query, param)
        query = '''DELETE FROM offers WHERE activate_type = 3 AND offer_id = %s'''
        self._insert_query(query, param)
        self._close_db()

    def delete_par(self, paraphrase_id):
        param = (paraphrase_id, )
        query = '''DELETE FROM paraphrases WHERE id = %s'''
        self._insert_query(query, param)
        query = '''DELETE FROM paraphrase_word WHERE paraphrase_id = %s'''
        self._insert_query(query, param)
        query = '''DELETE FROM offers WHERE activate_type = 4 AND offer_id = %s'''
        self._insert_query(query, param)
        self._close_db()

    def delete_family(self, word_id):
        param = (word_id, )
        query = '''DELETE FROM synamizer WHERE id = %s'''
        self._insert_query(query, param)
        self._close_db()


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
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class ActivateTypes(db.Model):
    __tablename__ = 'activate_types'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)