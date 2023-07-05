--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-07-03 11:59:18 +06

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 18108)
-- Name: legacy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legacy (
    id integer NOT NULL,
    name character varying(255),
    path character varying(255),
    parent_id integer,
    is_file integer
);


ALTER TABLE public.legacy OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 18107)
-- Name: legacy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legacy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.legacy_id_seq OWNER TO postgres;

--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 214
-- Name: legacy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legacy_id_seq OWNED BY public.legacy.id;


--
-- TOC entry 239 (class 1259 OID 18348)
-- Name: morphemes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.morphemes (
    id integer NOT NULL,
    morphem character varying,
    pos integer,
    ismoderated integer
);


ALTER TABLE public.morphemes OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18347)
-- Name: morphemes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.morphemes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.morphemes_id_seq OWNER TO postgres;

--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 238
-- Name: morphemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.morphemes_id_seq OWNED BY public.morphemes.id;


--
-- TOC entry 222 (class 1259 OID 18146)
-- Name: termin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.termin (
    id bigint NOT NULL,
    name character varying(250),
    description text,
    examples text
);


ALTER TABLE public.termin OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18211)
-- Name: my_serial; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.my_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.my_serial OWNER TO postgres;

--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 226
-- Name: my_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.my_serial OWNED BY public.termin.id;


--
-- TOC entry 217 (class 1259 OID 18117)
-- Name: page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    content character varying(255),
    is_deleted boolean,
    is_hidden boolean
);


ALTER TABLE public.page OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 18116)
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO postgres;

--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 216
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;


--
-- TOC entry 237 (class 1259 OID 18322)
-- Name: paraphrase_word; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paraphrase_word (
    word_id integer,
    paraphrase_id integer
);


ALTER TABLE public.paraphrase_word OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18313)
-- Name: paraphrases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paraphrases (
    id integer NOT NULL,
    paraphrase character varying(255)
);


ALTER TABLE public.paraphrases OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18312)
-- Name: paraphrases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paraphrases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paraphrases_id_seq OWNER TO postgres;

--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 234
-- Name: paraphrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paraphrases_id_seq OWNED BY public.paraphrases.id;


--
-- TOC entry 219 (class 1259 OID 18126)
-- Name: quote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quote (
    id integer NOT NULL,
    quote character varying(512) NOT NULL,
    quote_by character varying(100),
    added_by character varying(100),
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated timestamp without time zone
);


ALTER TABLE public.quote OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18125)
-- Name: quote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quote_id_seq OWNER TO postgres;

--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 218
-- Name: quote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quote_id_seq OWNED BY public.quote.id;


--
-- TOC entry 223 (class 1259 OID 18160)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    name text,
    description text
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 19042)
-- Name: school_termins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_termins (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    termin character varying(255),
    definition text,
    class integer
);


ALTER TABLE public.school_termins OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 19041)
-- Name: school_termins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.school_termins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.school_termins_id_seq OWNER TO postgres;

--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 242
-- Name: school_termins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.school_termins_id_seq OWNED BY public.school_termins.id;


--
-- TOC entry 241 (class 1259 OID 19035)
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id integer NOT NULL,
    subject character varying(255)
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 19034)
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_id_seq OWNER TO postgres;

--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 240
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- TOC entry 231 (class 1259 OID 18297)
-- Name: synamizer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synamizer (
    id integer NOT NULL,
    words character varying(255),
    words_family character varying(255),
    status character varying(255),
    meaning text,
    pos integer
);


ALTER TABLE public.synamizer OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18296)
-- Name: synamizer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.synamizer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.synamizer_id_seq OWNER TO postgres;

--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 230
-- Name: synamizer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.synamizer_id_seq OWNED BY public.synamizer.id;


--
-- TOC entry 236 (class 1259 OID 18319)
-- Name: synonym_word; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synonym_word (
    word_id integer,
    synonym_id integer
);


ALTER TABLE public.synonym_word OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18306)
-- Name: synonyms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synonyms (
    id integer NOT NULL,
    synonym character varying(255)
);


ALTER TABLE public.synonyms OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18305)
-- Name: synonyms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.synonyms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.synonyms_id_seq OWNER TO postgres;

--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 232
-- Name: synonyms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.synonyms_id_seq OWNED BY public.synonyms.id;


--
-- TOC entry 227 (class 1259 OID 18285)
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    name character varying(255),
    id integer NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18288)
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 228
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- TOC entry 229 (class 1259 OID 18293)
-- Name: tag_legacy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag_legacy (
    tag_id integer NOT NULL,
    legacy_id integer NOT NULL
);


ALTER TABLE public.tag_legacy OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18185)
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    user_id integer,
    role_id integer,
    id integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18198)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq OWNER TO postgres;

--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- TOC entry 221 (class 1259 OID 18136)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    password_salt text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18135)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3537 (class 2604 OID 18111)
-- Name: legacy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legacy ALTER COLUMN id SET DEFAULT nextval('public.legacy_id_seq'::regclass);


--
-- TOC entry 3548 (class 2604 OID 18351)
-- Name: morphemes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.morphemes ALTER COLUMN id SET DEFAULT nextval('public.morphemes_id_seq'::regclass);


--
-- TOC entry 3538 (class 2604 OID 18120)
-- Name: page id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- TOC entry 3547 (class 2604 OID 18316)
-- Name: paraphrases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paraphrases ALTER COLUMN id SET DEFAULT nextval('public.paraphrases_id_seq'::regclass);


--
-- TOC entry 3539 (class 2604 OID 18129)
-- Name: quote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote ALTER COLUMN id SET DEFAULT nextval('public.quote_id_seq'::regclass);


--
-- TOC entry 3550 (class 2604 OID 19045)
-- Name: school_termins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_termins ALTER COLUMN id SET DEFAULT nextval('public.school_termins_id_seq'::regclass);


--
-- TOC entry 3549 (class 2604 OID 19038)
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- TOC entry 3545 (class 2604 OID 18300)
-- Name: synamizer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synamizer ALTER COLUMN id SET DEFAULT nextval('public.synamizer_id_seq'::regclass);


--
-- TOC entry 3546 (class 2604 OID 18309)
-- Name: synonyms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms ALTER COLUMN id SET DEFAULT nextval('public.synonyms_id_seq'::regclass);


--
-- TOC entry 3544 (class 2604 OID 18289)
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- TOC entry 3542 (class 2604 OID 18212)
-- Name: termin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termin ALTER COLUMN id SET DEFAULT nextval('public.my_serial'::regclass);


--
-- TOC entry 3543 (class 2604 OID 18199)
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- TOC entry 3541 (class 2604 OID 18139)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3722 (class 0 OID 18108)
-- Dependencies: 215
-- Data for Name: legacy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legacy (id, name, path, parent_id, is_file) FROM stdin;
1	Халық мұрасы	Мұрасы/Халық мұрасы	\N	0
3	Баталар	Мұрасы/Халық мұрасы/Баталар	1	0
4	Баталар.pdf	Мұрасы/Халық мұрасы/Баталар/Баталар.pdf	3	1
5	Жырлар	Мұрасы/Халық мұрасы/Жырлар	1	0
6	23 жоқтау.pdf	Мұрасы/Халық мұрасы/Жырлар/23 жоқтау.pdf	5	1
7	Ер Сайын.pdf	Мұрасы/Халық мұрасы/Жырлар/Ер Сайын.pdf	5	1
8	Әндер	Мұрасы/Халық мұрасы/Әндер	1	0
9	Әндері.pdf	Мұрасы/Халық мұрасы/Әндер/Әндері.pdf	8	1
10	Ғылымның басқа салалары	Мұрасы/Ғылымның басқа салалары	\N	0
11	Мақалалар	Мұрасы/Ғылымның басқа салалары/Мақалалар	10	0
12	Тәні саудың - жаны сау.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Тәні саудың - жаны сау.pdf	11	1
13	Қазақ жерін алу турасындағы низам.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ жерін алу турасындағы низам.pdf	11	1
14	Тағы да народный сот хақында. 1911 ж..pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Тағы да народный сот хақында. 1911 ж..pdf	11	1
15	Уақ қарыз.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Уақ қарыз.pdf	11	1
16	Аңдаспаған мәселе турасында.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Аңдаспаған мәселе турасында.pdf	11	1
17	Бас қосуға рұқсат берілмеді.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Бас қосуға рұқсат берілмеді.pdf	11	1
18	Көшпелі һәм отырықшы норма.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Көшпелі һәм отырықшы норма.pdf	11	1
19	Бас қосу турасында.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Бас қосу турасында.pdf	11	1
20	Губернатор өзгерілуі.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Губернатор өзгерілуі.pdf	11	1
21	В.Л. Буртсев.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/В.Л. Буртсев.pdf	11	1
22	Партия әм кеңес құрылысындағы рушылық әсері.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Партия әм кеңес құрылысындағы рушылық әсері.pdf	11	1
23	Досмайыл хажыға ашық хат.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Досмайыл хажыға ашық хат.pdf	11	1
24	Қазаққа ашық хат.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазаққа ашық хат.pdf	11	1
25	МОПР һәм күншығыс елдерінің еңбекшілері.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/МОПР һәм күншығыс елдерінің еңбекшілері.pdf	11	1
26	Шаруа жайынан.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Шаруа жайынан.pdf	11	1
27	Соғысушы патшалар.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Соғысушы патшалар.pdf	11	1
28	Жер жалдау жайынан.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Жер жалдау жайынан.pdf	11	1
29	Земство.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Земство.pdf	11	1
30	Ауру жайынан.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Ауру жайынан.pdf	11	1
31	Закон жобасының баяндамасы.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Закон жобасының баяндамасы.pdf	11	1
32	Қазақ һәм 4-ші Дума.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ һәм 4-ші Дума.pdf	11	1
33	5 мың десятина жер.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/5 мың десятина жер.pdf	11	1
34	Орынбор 13-нші октиабір.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Орынбор 13-нші октиабір.pdf	11	1
35	Орыс мейірманшылығы.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Орыс мейірманшылығы.pdf	11	1
36	ов туралы.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/ов туралы.pdf	11	1
37	Қазақстан дәуірінің жаңа құрылымы.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақстан дәуірінің жаңа құрылымы.pdf	11	1
38	Бұ заманның соғысы. 1914.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Бұ заманның соғысы. 1914.pdf	11	1
39	Лениннің елу жасы.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Лениннің елу жасы.pdf	11	1
40	Қазақ һәм түрлі мәселелер.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ һәм түрлі мәселелер.pdf	11	1
41	Қазақтың өкпесі.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақтың өкпесі.pdf	11	1
42	Егін егу.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Егін егу.pdf	11	1
43	Жәрдем комитеті. 1915.pdf	Мұрасы/Ғылымның басқа салалары/Мақалалар/Жәрдем комитеті. 1915.pdf	11	1
45	Тіл ғылымы	Мұрасы/Тіл ғылымы	\N	0
47	Әліппелер	Мұрасы/Тіл ғылымы/Әліппелер	45	0
48	Сауат ашқыш. Ересектерге арналған әліппе. Семей, 1926.pdf	Мұрасы/Тіл ғылымы/Әліппелер/Сауат ашқыш. Ересектерге арналған әліппе. Семей. 1926.pdf	47	1
49	Әліпби. Жаңа құрал. Қызылорда, 1926.pdf	Мұрасы/Тіл ғылымы/Әліппелер/Әліпби. Жаңа құрал. Қызылорда. 1926.pdf	47	1
50	Оқу құралы. Бірінші кітап. Балаларға арналған әліппе. Орынбор, 1912.pdf	Мұрасы/Тіл ғылымы/Әліппелер/Оқу құралы. Бірінші кітап. Балаларға арналған әліппе. Орынбор. 1912.pdf	47	1
51	Оқулықтар	Мұрасы/Тіл ғылымы/Оқулықтар	45	0
52	Оқулық. Тіл-құрал. 1-нші тіл танытқыш кітап. Қызылорда, 1925.pdf	Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 1-нші тіл танытқыш кітап. Қызылорда, 1925.pdf	51	1
53	Оқулық. Тіл-құрал. 3-жылдық. Қызылорда, 1925.pdf	Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 3-жылдық. Қызылорда, 1925.pdf	51	1
54	Оқулық. Тіл-құрал. 2-жылдық. Орынбор, 1915.pdf	Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 2-жылдық. Орынбор, 1915.pdf	51	1
55	Оқулық. Тіл-құрал 1-жылдық. Орынбор, 1914.pdf	Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал 1-жылдық. Орынбор, 1914.pdf	51	1
56	Мақалалар	Мұрасы/Тіл ғылымы/Мақалалар	45	0
57	Түрікшелер құрылтайы.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Түрікшелер құрылтайы.pdf	56	1
58	Тіл қисыны.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Тіл қисыны.pdf	56	1
59	Түзетілген әріп.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Түзетілген әріп.pdf	56	1
60	Емле туралы.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Емле туралы.pdf	56	1
61	Дыбыстарды жіктеу туралы.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Дыбыстарды жіктеу туралы.pdf	56	1
62	А.Байтұрсынұлының араб әліп-биін жақтаған баяндамасы.pdf	Мұрасы/Тіл ғылымы/Мақалалар/А.Байтұрсынұлының араб әліп-биін жақтаған баяндамасы.pdf	56	1
63	Жазу мәселесі.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Жазу мәселесі.pdf	56	1
64	Шаһзаман мырзаға.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Шаһзаман мырзаға.pdf	56	1
65	Жазу тәртібі.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Жазу тәртібі.pdf	56	1
66	Қазақша сөз жазушыларға.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Қазақша сөз жазушыларға.pdf	56	1
67	Сөз талғау.pdf	Мұрасы/Тіл ғылымы/Мақалалар/Сөз талғау.pdf	56	1
68	Әдебиет ғылымы	Мұрасы/Әдебиет ғылымы	\N	0
70	Аудармалар	Мұрасы/Әдебиет ғылымы/Аудармалар	68	0
71	Қырық мысал.pdf	Мұрасы/Әдебиет ғылымы/Аудармалар/Қырық мысал.pdf	70	1
72	Оқулық	Мұрасы/Әдебиет ғылымы/Оқулық	68	0
73	Әдебиет танытқыш.pdf	Мұрасы/Әдебиет ғылымы/Оқулық/Әдебиет танытқыш.pdf	72	1
74	Өлеңдер	Мұрасы/Әдебиет ғылымы/Өлеңдер	68	0
75	Маса.pdf	Мұрасы/Әдебиет ғылымы/Өлеңдер/Маса.pdf	74	1
76	Мақалалар	Мұрасы/Әдебиет ғылымы/Мақалалар	68	0
77	Қалам қайраткерлері жайынан.pdf	Мұрасы/Әдебиет ғылымы/Мақалалар/Қалам қайраткерлері жайынан.pdf	76	1
78	Қазақтың бас ақыны. №43.pdf	Мұрасы/Әдебиет ғылымы/Мақалалар/Қазақтың бас ақыны. №43.pdf	76	1
79	Әдістеме ғылымы	Мұрасы/Әдістеме ғылымы	\N	0
80	Оқу-әдістемелік құралдар	Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар	79	0
81	Баяншы. Қазан, 1920.pdf	Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Баяншы. Қазан, 1920.pdf	80	1
82	Тіл-жұмсар. 1-кітап. Қызылорда, 1928..pdf	Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Тіл-жұмсар. 1-кітап. Қызылорда, 1928..pdf	80	1
83	Оқу құралы. Хрестоматия. Қызылорда, 1927.pdf	Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Оқу құралы. Хрестоматия. Қызылорда, 1927.pdf	80	1
84	Мақалалар	Мұрасы/Әдістеме ғылымы/Мақалалар	79	0
85	Білім жарысы.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Білім жарысы.pdf	84	1
86	Орысша оқушылар.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Орысша оқушылар.pdf	84	1
87	Бастауыш мектеп. 1914.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Бастауыш мектеп. 1914.pdf	84	1
88	Қазақ арасында оқу жұмыстарын қалай жүргізу керек. 1923.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Қазақ арасында оқу жұмыстарын қалай жүргізу керек. 1923.pdf	84	1
89	Мектеп керектері.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Мектеп керектері.pdf	84	1
90	Шекіспей, бекіспейді.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Шекіспей, бекіспейді.pdf	84	1
91	Қай әдіс жақсы.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Қай әдіс жақсы.pdf	84	1
92	Оқыту жайынан.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Оқыту жайынан.pdf	84	1
93	Баулу мектебі.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Баулу мектебі.pdf	84	1
94	Жалқылау әдіс.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Жалқылау әдіс.pdf	84	1
95	Білім жарысы қақында.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Білім жарысы қақында.pdf	84	1
96	Жалқылаулы-жалпылау әдіс.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Жалқылаулы-жалпылау әдіс.pdf	84	1
97	Оқу жайы.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Оқу жайы.pdf	84	1
98	Қазақша оқу жайынан.pdf	Мұрасы/Әдістеме ғылымы/Мақалалар/Қазақша оқу жайынан.pdf	84	1
\.


--
-- TOC entry 3746 (class 0 OID 18348)
-- Dependencies: 239
-- Data for Name: morphemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.morphemes (id, morphem, pos, ismoderated) FROM stdin;
1	тау	1	1
2	шық	5	1
3	алматы	4	1
4	бар	5	1
5	тал	1	1
6	мал	1	1
7	қара	5	1
8	ауыл	1	1
9	кел	5	1
10	көрік	1	1
11	бер	5	1
12	жібер	5	1
13	қанағат	1	1
15	қазақ	1	1
16	бала	1	1
18	тұр	5	1
19	ұзақ	9	1
21	асқар	1	1
22	биік	2	1
23	мен	4	1
25	жүр	5	1
31	ой	8	1
32	құс	1	1
33	тас	1	1
34	су	1	1
35	шыны	1	1
36	адам	1	1
37	қол	1	1
38	жаңбыр	1	1
39	найзағай	1	1
40	сайлау	1	1
41	жүріс	1	1
42	ұғым	1	1
43	ақыл	1	1
44	сана	1	1
45	ағаш	1	1
46	ағаш	1	1
47	шөп	1	1
48	сүт	1	1
49	темір	1	1
50	шүберек	1	1
51	ықпал	1	1
52	әсер	1	1
53	пікір	1	1
54	кісі	1	1
55	оқу	1	1
56	білім	1	1
57	ұйым	1	1
58	апа	1	1
60	тал	1	1
61	қыз	1	1
62	нағашы	1	1
63	жиен	1	1
64	ән	1	1
65	ат	1	1
66	арба	1	1
67	егін	1	1
68	мал	1	1
69	еңбек	1	1
70	сурет	1	1
71	ғалым	1	1
72	мұғалім	1	1
73	құм	1	1
74	шаң	1	1
75	тас	1	1
76	темір	1	1
77	су	1	1
78	аспан	1	1
79	ақыл	1	1
80	әлем	1	1
81	жусан	1	1
82	аң	1	1
83	құс	1	1
84	шөп	1	1
85	ағаш	1	1
86	алма	1	1
87	жүзім	1	1
88	жиде	1	1
89	нан	1	1
90	ет	1	1
91	сүт	1	1
92	май	1	1
93	қымыз	1	1
94	жылқы	1	1
95	қой	1	1
96	ешкі	1	1
97	құлан	1	1
98	бөкен	1	1
99	киік	1	1
100	арқар	1	1
101	аю	1	1
102	қаз	1	1
103	бүркіт	1	1
104	шортан	1	1
105	сазан	1	1
106	көксерке	1	1
107	ара	1	1
108	сона	1	1
109	шыбын	1	1
110	дала	1	1
111	үй	1	1
112	қора	1	1
113	терезе	1	1
114	табақ	1	1
115	қасық	1	1
116	ас	1	1
117	арал	1	1
118	ер	1	1
119	кеңсе	1	1
120	күн	1	1
121	жер	1	1
122	ай	1	1
124	кісі	1	1
125	сөз	1	1
126	өмір	1	1
127	алтын	1	1
128	жел	1	1
129	шай	1	1
130	бу	1	1
131	азон	1	1
132	түтін	1	1
133	тұман	1	1
134	ұн	1	1
135	шаң	1	1
136	тозаң	1	1
137	шаш	1	1
138	кірпік	1	1
139	қола	1	1
140	боран	1	1
141	жаңбыр	1	1
142	қар	1	1
143	жел	1	1
144	аяқ	1	1
145	құлақ	1	1
146	етік	1	1
147	шаңғы	1	1
148	кітап	1	1
149	төбе	1	1
150	бота	1	1
151	лақ	1	1
152	сәуле	1	1
153	қуат	1	1
154	ел	1	1
155	жұрт	1	1
156	көкпар	1	1
157	белбеу	1	1
158	бәйтерек	1	1
159	бәйшешек	1	1
160	қолқанат	1	1
161	қолбасы	1	1
162	әдебиет	1	1
163	тарих	1	1
164	бас	1	1
166	сағат	1	1
167	бүгін	9	0
171	көлік	1	1
173	боса	5	0
174	тіктөртбұрыш	1	0
175	қабырға	1	0
176	ұзындық	1	0
177	метр	1	0
178	және	8	0
179	диагонал	1	0
180	тап	5	0
181	шаршы	1	0
182	аудан	1	0
183	см	1	0
184	кв	1	0
185	тең	2	0
186	жаңалық	1	0
188	тиесілі	2	1
189	тұлға	1	1
190	ие	1	1
191	мүлік	1	1
192	көлік-салығы	1	1
193	салық	1	1
194	сал	5	1
195	төле	5	1
\.


--
-- TOC entry 3724 (class 0 OID 18117)
-- Dependencies: 217
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page (id, name, parent_id, content, is_deleted, is_hidden) FROM stdin;
\.


--
-- TOC entry 3744 (class 0 OID 18322)
-- Dependencies: 237
-- Data for Name: paraphrase_word; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paraphrase_word (word_id, paraphrase_id) FROM stdin;
1	1
4	2
4	3
4	4
5	5
5	6
5	7
6	8
6	9
7	10
8	11
8	12
9	13
9	14
9	15
10	16
10	17
10	18
10	19
11	20
11	21
12	22
12	23
12	24
12	25
13	26
13	27
14	28
14	29
15	30
15	31
15	32
16	33
16	34
16	35
17	36
17	37
17	38
17	39
18	40
18	41
18	42
19	43
19	44
20	45
21	46
21	47
21	48
21	49
22	50
23	51
24	52
24	53
25	54
25	55
25	56
26	57
26	58
26	59
26	60
27	61
27	62
28	63
28	64
29	65
30	66
30	67
30	68
31	69
31	70
31	71
32	72
32	73
33	74
33	75
34	76
34	77
34	78
34	79
35	80
35	81
35	82
35	83
36	84
37	85
37	86
37	87
38	88
38	89
38	90
38	91
39	92
39	93
39	94
39	95
40	96
40	97
41	98
42	99
42	100
42	101
43	102
43	103
44	104
44	105
45	106
45	107
46	108
46	109
47	110
47	111
48	112
49	113
50	114
50	115
50	116
50	117
51	118
51	119
51	120
52	121
52	122
52	123
52	124
53	125
54	126
54	127
55	128
56	129
56	130
56	131
57	132
58	133
61	134
62	135
62	136
63	137
63	138
64	139
65	140
65	141
67	142
67	143
67	144
67	145
68	146
68	147
73	148
73	149
73	150
73	151
74	152
74	153
76	154
76	155
76	156
76	157
79	158
79	159
81	160
81	161
81	162
85	163
85	164
86	165
86	166
86	167
91	168
91	169
93	170
96	171
96	172
99	173
101	174
101	175
101	176
104	177
104	178
104	179
105	180
105	181
105	182
106	183
106	184
107	185
107	186
107	187
107	188
108	189
108	190
111	191
111	192
111	193
112	194
112	195
113	196
113	197
113	198
113	199
117	200
117	201
117	202
118	203
118	204
118	205
119	206
119	207
120	208
120	209
120	210
120	211
121	212
121	213
121	214
122	215
122	216
122	217
123	218
123	219
123	220
124	221
124	222
124	223
126	224
126	225
126	226
126	227
129	228
129	229
129	230
131	231
131	232
131	233
132	234
132	235
132	236
133	237
133	238
134	239
134	240
134	241
135	242
135	243
136	244
136	245
136	246
137	247
137	248
137	249
138	250
138	251
138	252
141	253
142	254
147	255
148	256
148	257
148	258
148	259
150	260
150	261
154	262
154	263
154	264
155	265
155	266
156	267
157	268
157	269
157	270
158	271
159	272
159	273
159	274
160	275
161	276
161	277
161	278
161	279
162	280
162	281
162	282
162	283
163	284
163	285
164	286
164	287
165	288
165	289
166	290
166	291
166	292
168	293
168	294
168	295
169	296
169	297
170	298
175	299
175	300
175	301
176	302
176	303
176	304
176	305
177	306
177	307
178	308
178	309
178	310
178	311
179	312
179	313
180	314
180	315
181	316
181	317
183	318
183	319
184	320
184	321
184	322
186	323
186	324
187	325
187	326
188	327
189	328
189	329
189	330
189	331
190	332
190	333
191	334
191	335
191	336
191	337
192	338
192	339
193	340
193	341
194	342
194	343
195	344
195	345
196	346
196	347
197	348
197	349
197	350
197	351
198	352
198	353
199	354
199	355
199	356
200	357
200	358
201	359
201	360
202	361
202	362
203	363
203	364
203	365
204	366
204	367
204	368
204	369
205	370
205	371
206	372
206	373
206	374
206	375
207	376
208	377
208	378
209	379
209	380
209	381
210	382
210	383
212	384
212	385
213	386
213	387
214	388
215	389
215	390
216	391
216	392
217	393
217	394
217	395
217	396
218	397
218	398
218	399
219	400
219	401
220	402
220	403
221	404
221	405
222	406
222	407
223	408
223	409
224	410
224	411
225	412
225	413
225	414
226	415
226	416
227	417
227	418
227	419
228	420
228	421
229	422
230	423
231	424
231	425
232	426
232	427
233	428
233	429
234	430
235	431
235	432
236	433
236	434
236	435
237	436
237	437
238	438
238	439
239	440
239	441
240	442
241	443
241	444
241	445
242	446
242	447
242	448
242	449
243	450
243	451
243	452
244	453
244	454
244	455
244	456
245	457
245	458
245	459
246	460
246	461
247	462
247	463
247	464
248	465
248	466
248	467
249	468
249	469
249	470
250	471
250	472
251	473
251	474
252	475
253	476
253	477
254	478
254	479
254	480
255	481
255	482
256	483
257	484
258	485
258	486
258	487
259	488
259	489
259	490
260	491
261	492
262	493
262	494
263	495
263	496
264	497
264	498
265	499
265	500
266	501
266	502
267	503
267	504
268	505
268	506
269	507
269	508
269	509
270	510
270	511
270	512
270	513
271	514
271	515
272	516
272	517
275	518
275	519
276	520
276	521
277	522
277	523
277	524
279	525
279	526
279	527
280	528
281	529
281	530
281	531
281	532
283	533
283	534
284	535
284	536
284	537
284	538
285	539
285	540
287	541
287	542
288	543
289	544
289	545
289	546
290	547
291	548
291	549
292	550
292	551
293	552
293	553
294	554
294	555
294	556
294	557
295	558
295	559
296	560
296	561
296	562
297	563
297	564
298	565
298	566
298	567
300	568
300	569
301	570
301	571
301	572
301	573
302	574
303	575
303	576
304	577
304	578
305	579
305	580
305	581
305	582
306	583
306	584
307	585
307	586
308	587
308	588
308	589
308	590
309	591
309	592
309	593
309	594
310	595
310	596
310	597
311	598
311	599
312	600
312	601
312	602
313	603
313	604
314	605
314	606
314	607
314	608
317	609
317	610
317	611
318	612
318	613
319	614
319	615
320	616
320	617
321	618
321	619
321	620
322	621
322	622
323	623
323	624
324	625
324	626
324	627
324	628
325	629
325	630
325	631
326	632
326	633
326	634
327	635
327	636
328	637
328	638
328	639
328	640
329	641
329	642
330	643
330	644
330	645
330	646
331	647
331	648
332	649
333	650
334	651
334	652
335	653
335	654
336	655
337	656
337	657
337	658
338	659
338	660
341	661
341	662
342	663
342	664
343	665
343	666
344	667
344	668
344	669
345	670
345	671
346	672
347	673
347	674
348	675
348	676
349	677
350	678
350	679
350	680
351	681
351	682
351	683
352	684
352	685
352	686
353	687
353	688
354	689
354	690
354	691
354	692
355	693
355	694
355	695
355	696
356	697
356	698
357	699
357	700
357	701
358	702
359	703
359	704
360	705
360	706
361	707
361	708
361	709
362	710
362	711
362	712
363	713
363	714
364	715
364	716
365	717
365	718
365	719
366	720
367	721
367	722
368	723
368	724
368	725
369	726
369	727
370	728
370	729
371	730
371	731
371	732
372	733
372	734
372	735
372	736
373	737
373	738
373	739
373	740
374	741
374	742
375	743
375	744
375	745
376	746
376	747
376	748
377	749
378	750
379	751
380	752
380	753
380	754
381	755
381	756
381	757
382	758
382	759
383	760
383	761
384	762
385	763
385	764
386	765
386	766
387	767
387	768
388	769
388	770
389	771
389	772
390	773
391	774
392	775
393	776
393	777
394	778
394	779
395	780
396	781
397	782
397	783
399	784
399	785
400	786
400	787
401	788
401	789
402	790
402	791
403	792
403	793
404	794
404	795
404	796
405	797
405	798
405	799
406	800
406	801
406	802
407	803
407	804
408	805
409	806
410	807
411	808
412	809
413	810
414	811
415	812
416	813
417	814
418	815
419	816
420	817
421	818
423	819
424	820
425	821
426	822
427	823
428	824
429	825
430	826
431	827
432	828
433	829
434	830
435	831
436	832
437	833
438	834
439	835
440	836
441	837
442	838
443	839
444	840
445	841
446	842
447	843
448	844
449	845
450	846
451	847
452	848
453	849
455	850
456	851
457	852
458	853
459	854
460	855
461	856
462	857
463	858
464	859
465	860
466	861
467	862
468	863
469	864
470	865
471	866
472	867
473	868
474	869
475	870
476	871
477	872
478	873
479	874
480	875
481	876
482	877
483	878
484	879
485	880
486	881
487	882
488	883
489	884
490	885
491	886
492	887
499	888
501	889
501	890
501	891
502	892
502	893
508	894
508	895
508	896
509	897
510	898
513	899
520	900
529	901
532	902
533	903
533	904
538	905
539	906
539	907
539	908
541	909
543	910
547	911
547	912
553	913
553	914
553	915
564	916
566	917
568	918
571	919
581	920
581	921
581	922
582	923
589	924
592	925
592	926
592	927
593	928
593	929
593	930
595	931
610	932
616	933
621	934
621	935
622	936
625	937
635	938
641	939
641	940
648	941
648	942
648	943
649	944
649	945
649	946
654	947
658	948
658	949
658	950
666	951
671	952
672	953
673	954
675	955
675	956
677	957
680	958
684	959
684	960
686	961
686	962
689	963
694	964
694	965
695	966
701	967
702	968
702	969
702	970
704	971
708	972
714	973
718	974
719	975
719	976
728	977
734	978
743	979
743	980
743	981
744	982
744	983
744	984
745	985
745	986
746	987
747	988
747	989
747	990
748	991
748	992
748	993
750	994
750	995
752	996
752	997
752	998
755	999
756	1000
756	1001
757	1002
758	1003
758	1004
761	1005
764	1006
764	1007
765	1008
765	1009
766	1010
770	1011
771	1012
771	1013
776	1014
776	1015
776	1016
778	1017
778	1018
778	1019
781	1020
785	1021
785	1022
785	1023
786	1024
786	1025
786	1026
788	1027
789	1028
789	1029
790	1030
796	1031
803	1032
803	1033
803	1034
816	1035
818	1036
819	1037
824	1038
824	1039
826	1040
826	1041
831	1042
834	1043
835	1044
840	1045
841	1046
842	1047
860	1048
863	1049
866	1050
872	1051
875	1052
887	1053
893	1054
894	1055
896	1056
896	1057
896	1058
897	1059
900	1060
901	1061
902	1062
902	1063
905	1064
906	1065
911	1066
912	1067
912	1068
915	1069
916	1070
917	1071
918	1072
918	1073
932	1074
932	1075
942	1076
946	1077
946	1078
954	1079
956	1080
956	1081
956	1082
962	1083
962	1084
972	1085
978	1086
979	1087
979	1088
979	1089
985	1090
985	1091
985	1092
989	1093
990	1094
990	1095
991	1096
991	1097
992	1098
1178	1099
\.


--
-- TOC entry 3742 (class 0 OID 18313)
-- Dependencies: 235
-- Data for Name: paraphrases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paraphrases (id, paraphrase) FROM stdin;
1	Көпшілік дауыс беру
2	басшы
3	ең бірінші басшы
4	жиналысты басқарушы ресми тұлға
5	әдейі
6	әдейілеп
7	арнайы
8	делегаттар тобы
9	Мемлекет я ұжым атынан сайланған ресми адамдар тобы.
10	Шығыс аймақ
11	әкімшілік-территориялық бөлік
12	аймақ
13	жолға шығу
14	жол жүру
15	алыс жол
16	баспана
17	шаңырақ
18	мекен
19	пана
20	мәдениет мекені
21	іс-шаралар өтетін жер
22	дәу
23	алып
24	ірі
25	мол
26	үлкен бөлме
27	қонақ бөлме
28	ірі елді мекен
29	шаһар
30	халық
31	ел-жұрт
32	қауым
33	Әңгіменің төркіні
34	мәні түйіні
35	жағдай
36	жұмбақсыз
37	астарсыз
38	жасырын емес
39	тұйық емес
40	анкета
41	сауал-сұрақ
42	сұхбат
43	жолығу
44	жүздесу
45	еркін дауыс беру
46	акт
47	бұйрық
48	заң
49	әмір
50	насихат
51	қаулы
52	елге билік жүргізші
53	ел басқарушы
54	нормативті-құқықтық акт
55	қаулы
56	жарғы
57	Ата Заң
58	Конституциялық жарғы
59	Конституциялық низам 
60	Конституциялық мизам
61	жетілдіру 
62	толтыру
63	қолданысқа кіргізу
64	тәжірбиеге пайдалану
65	проект
66	айтылған
67	хабарлаған
68	білдірген
69	ұсынылған
70	білдірілген
71	байқатылған
72	өтеусіз беру
73	айырбастау
74	Кәмелетке толып, ер жеткен адам
75	бір елдің азаматтығы бар адам
76	өз еркі өзінде
77	құқылы 
78	тәуелсіз
79	күштеусіз
80	ашық емес
81	құпия түрде
82	көзден таса
83	Қалтарысы бар\n
84	сайлау
85	арнайы
86	тіке
87	тұп-тура
88	айқындалады
89	бағдарланады
90	нақтыланады
91	дәлелденеді
92	билік
93	қожалық
94	төрелік
95	үстемдік
96	үн
97	дыбыс
98	тізбе
99	даярлау
100	дайындау
101	қамдау
102	адамдар жиынтығы
103	топ
104	аумаққа тән
105	аумаққа қатысты
106	Учаскеге тән
107	учаскеге қатысты
108	арнайы жиын
109	мәжіліс
110	мәлімдеу
111	жария ету
112	орын алу
113	аумақтық кеңістік
114	еңбек
115	іс
116	қарекет
117	қызмет
118	шақ
119	кезең
120	мезгіл
121	ақпарат
122	мағлұмат
123	дерек
124	хабар
125	сайланған
126	Аптаның жеті күнінің бірі
127	 Жиырма төрт сағатқа тең уақыт
128	кідіртпей
129	хабар
130	мәлімет
131	дерек
132	қолтаңба қою
133	ауытқу
134	қажет етушілік
135	қауымдастық
136	адамдардан тұратын топтар
137	талап
138	мақсат
139	жүзеге асыру 
140	Конституция
141	зағдар жинағы
142	адамның құқығы
143	саяси еркі
144	қоғамдық еркі
145	қақы
146	тармақ
147	бөлік
148	дарланған қызметкер
149	қолынан іс келетін
150	кәсіпқой
151	шебер
152	жиын
153	жиналыс
154	құн
155	парқы
156	көрсеткіш
157	бәс
158	өндіру
159	шығару
160	тілек
161	тілеу
162	мүдде
163	дәлдеу
164	болжау
165	қауырт қозғалыс
166	қарбалас
167	дер
168	мемлекет басшысы
169	елбасы
170	билеу
171	басқару
172	қожалық ету
173	құқықтылық
174	қызмет
175	бейне
176	маңыз
177	даңқ
178	абырой-атақ
179	дәреже
180	нығайту
181	күшейту
182	жақсарту
183	мемлекет
184	жұрт
185	жұмыс
186	қарекет
187	шаруа
188	қызмет
189	қатынасу
190	атсалысу
191	қолайлы жағдай
192	мұрша
193	мүмкіншілік
194	үлкейту
195	үлғайту
196	қамқорлық жасау
197	сақтау
198	жақтау
199	аялау
200	айла
201	әрекет
202	әдіс
203	меңгерту
204	дамыту
205	ілгерілету
206	ерекшелік
207	өзгешелік
208	көшірме
209	үлгі
210	негіз
211	жоба
212	ұсталмаған
213	бұрын болмаған
214	өңі кетпеген
215	терең сезіну
216	білу
217	ұғыну
218	салмақты 
219	сабырлы
220	байсалды
221	алға жылжу
222	қозғалу
223	ілгерілеу
224	ауыртпалық
225	кедергі
226	бөгет
227	тапшылық
228	ұрыну
229	душар ету
230	тудырту
231	айқын
232	дәл
233	шын мәніндегі
234	ақылға қонымды
235	түсінікті
236	ұғымды
237	дұрыстаулар
238	сәйкессіздікті жою
239	анық
240	тура
241	дәл
242	бөлім
243	тарау
244	сала
245	тарам
246	тарау
247	байқату
248	сездіру
249	білдіру
250	бір бөлігі
251	бөлшек
252	бөлім
253	Бөлшектерге ұсақталған
254	мөлшер
255	қысқаша мәлімет
256	көңіл толмайтын
257	қабілетсіз
258	мүгедек
259	кемтар
260	сайлау қағазы
261	хабарлама
262	танымал болды
263	белгілі болды
264	атақты болды
265	саналу
266	есепке алыну
267	ойдан табылған
268	орны
269	қадірі
270	мәні
271	түйсінеді
272	серт
273	уәде
274	уағда
275	көптен бері жауабын білгісі келіп жүрген сұрақ
276	тапсырылсын
277	артылсын
278	табысталсын
279	міндеттелсін
280	амал
281	тәсіл
282	айла
283	әрекет
284	пайдаға асыру үрдісі
285	пайдалану ісі
286	тұрғызылады
287	бой көтереді
288	тежегендік
289	тоқтам
290	шұғыл 
291	ерекше
292	айрықша
293	тұжырым
294	көзқарас
295	ой
296	білгісі келді
297	жауап күтті
298	қолтаңба қою
299	маңызы зор
300	мазмұнды
301	мәнді
302	байлам
303	бітім
304	түйін
305	ұйғарым
306	сездіру
307	байқату
308	айқын
309	ашық
310	жарық
311	анық
312	кескін-келбеті
313	бейне
314	түсінемін
315	есептеймін
316	ресми басқосу
317	ойын-той
318	пікір
319	ой
320	орындау
321	жасау
322	жүргізу
323	назар аударту
324	 атап-атап көрсету
325	көлемі көп
326	аумақты
327	жалпыхалықтық
328	бірауыздылық
329	тұтастық
330	ынтымақтық
331	татулық
332	ашық
333	айқын
334	дәл
335	айдын
336	шалқар
337	белгілі
338	пікір
339	бейне
340	аз уақыт
341	ұзақ емес
342	ауырлығы жоқ
343	күш жұмсаусыз
344	әрекет
345	қимыл
346	ауыс
347	той тойлау
348	атақты
349	мәлім
350	көрнекті
351	беделді
352	ауыс
353	мәселе
354	өзгеріс жасау
355	жақсарту
356	қайта құру
357	халықтың дауыс беруі
358	еркін сайлау
359	айырбастайды
360	сатады
361	Ұйымдастыра білушілік
362	жетекші
363	оқиға
364	адым
365	қадам
366	шымшытырық
367	маңызды
368	негізгі
369	басты
370	бақылау
371	қаржыландыру
372	жер
373	оралым
374	тәрбиелеу процесі
375	импорт
376	торшаның жұмыс жасауы
377	аластайтын
378	жолататын
379	табысы мол
380	қолайлы
381	жағдайлы
382	 әп-сәтте
383	шалт
384	қажеті болушылық
385	керектілік
386	бастытрқан
387	табылған
388	өтімді
389	сарапқа салушы
390	сыншы
391	мультимедиа
392	 медиапланттау
393	ерік
394	рух
395	қабілет
396	ақыл
397	ғылым
398	бөлік
399	тармақ
400	жүзеге асыру
401	орындау
402	қолданыс табу
403	іздеп табу
404	шыңырау
405	түбі жоқ
406	халықтың басқаруы
407	басқару жүйесі
408	жол
409	саяхат
410	мықты-басшылық   
411	супер-басшылық
412	билеп-төстеу
413	билеу
414	төрелік ету
415	бойында күші мол
416	алып күш
417	жол бермеу
418	тежеу
419	шек қою
420	оптимизациялау
421	іске асыру
422	орал
423	жұмыс
424	мән
425	маңызы
426	пайда болған
427	жүзеге асыру
428	теңдей етіп
429	бір дәреже
430	аяқтау
431	 сайлау кепілдігі
432	пассивті сайлау құқығы
433	график
434	эталон
435	конструкция
436	рәсімдеу
437	жазба
438	үрдіс
439	ғылым
440	тәуелсіздендіру
441	жүзеге асыру
442	Еуразия континентілік
443	бақылау
444	маркетинг
445	игеру
446	сараптама
447	сұрыптама
448	жекелік
449	даралық
450	басшы
451	шеф
452	бастық
453	орта тұсы
454	басты қала
455	негіз
456	күш
457	іске асырылатын
458	ұсынылатын
459	жаңғыртылатын
460	айтылған
461	есеп берілген
462	бола алатын
463	шығарылатын
464	жүргізілетін
465	жаңарту
466	жаңажаландыру
467	жасыру
468	одақ
469	қоғам
470	сот
471	басқарма
472	нұсқау
473	судья
474	әділ қазы
475	беремін
476	өтілсін
477	болсын
478	жасалынады
479	иньекция
480	егу
481	жарияға жар салынсын
482	бәрі естісін
483	түртеді
484	жасалды
485	ауыстыру
486	толтыру
487	сілтілеу
488	істеу
489	дүние-мүлік
490	жиһаз
491	туу
492	істей алмайды
493	іске асыру
494	ойнау
495	байқату
496	сездіру
497	түсінемін
498	есептеймін
499	алынды
500	жіберілді
501	мүмкін
502	болды
503	көмек
504	көрсетк
505	алынсын
506	тастасын
507	алады
508	келісті
509	рұқсат берді
510	қосылу
511	бас қосу
512	араласу
513	тоқайласу
514	болмайды
515	дұрыс емес
516	қою
517	орналастыру
518	көрсету
519	өсіру
520	өшірілді
521	жоғалды
522	үдеріс
523	кезең
524	жүйесі
525	айдайды
526	іске қосты
527	орындау
528	айтады
529	қолақ қою
530	көрсету
531	сездіру
532	байқату
533	тағайымдайды
534	жасады
535	ішіне кіреді
536	тұрмыс
537	жағдай
538	ыдырау
539	мақсатқа жету
540	іске асыру
541	тексерілу
542	байқалу
543	ұайтарымы беріледі
544	ұстатылу
545	ұсынылу
546	әперілу
547	айтылады
548	сынақ
549	саты
550	тартылады
551	ұлғайады
552	қоя алмайды
553	тағайынды емес
554	сәйкес емес
555	жанжал
556	соғысу
557	күресі
558	сәйкес келді
559	дұрысталды
560	бақылау
561	бағдарлау
562	қадағалау
563	анықтау
564	сипаттау
565	тысқа жеткізу
566	апару
567	жариялау
568	жасауға кірмес зат
569	қолдануға болмайды
570	алу
571	тазарту
572	қабылдау
573	тазалау
574	әсер етеді
575	жөнелту
576	жеткізу
577	үздіксіз
578	тұрақтылық
579	аман қалу
580	қорғау
581	қорға жинау
582	жол бермеу
583	ұштастыру
584	байланыстыру
585	аяқтау
586	тоқтату
587	хабар беру
588	мәлімдеу
589	мағлұмдау
590	жариялау
591	су көзі
592	тұма
593	жер
594	қабылдау
595	байланыс нүктелері
596	байланыс қалалары
597	өнеркәсіптік
598	шығару керек
599	өндіру керек
600	қоңырау шалды
601	жариялады
602	айтты
603	саяси шолушы
604	саяси комментатор
605	ыза
606	кейіс
607	реніш
608	араздық
609	жақсарту
610	жаңарту
611	қайта жаңғарту
612	жеке саласы
613	әскери топ
614	сауалнама
615	жалпыхалықтық сауалнама
616	бәсеке
617	сайыс
618	керегі
619	сапа
620	дереккөз
621	жаттығу
622	дайындық
623	басқарушы
624	төрешілер
625	көрермен
626	көпшілік
627	халық
628	қоғам
629	сайлау округі
630	сайлаушы
631	округ
632	маркетинг
633	игеру
634	түсіну
635	ақиқат
636	шыншыл
637	шапағат
638	қайырым
639	жақсылық
640	қадірлеу
641	тағайындау
642	міндеті
643	маңызды
644	шешуші
645	мәні бар
646	басты
647	тәртіп
648	заң
649	шешу
650	ақиқат
651	жүйелі
652	дәйекті
653	шақырды
654	түсіну
655	белгісі
656	өзгешелік
657	айрықшалық
658	өзіндік
659	хабарлады
660	білдірді
661	жиналыс
662	практикалық сабақтар
663	платформа
664	қосымша
665	қолдануға оңай
666	лайықты
667	анықтау
668	тергеу
669	жауап алу
670	жиынтығы
671	маркетинг атқарымы
672	жеке тұлға
673	тұру
674	қалдыру
675	хал-жағдай
676	тұрмыс
677	кеңес мүшелер
678	кемтар
679	жарымжан
680	кемтік
681	өткізді
682	сынақтан өту
683	міндеттеу
684	қолайлы
685	тиімді
686	оңтайлы
687	көп танылатын
688	дәуірлік
689	жария етті
690	хабарлады
691	бастырту
692	табу
693	ұран
694	дабыл
695	шақыру
696	бірдеме деу
697	мерзім
698	ай
699	сату
700	айырбастау
701	тиіп жіберу
702	іздестіру
703	әзір
704	дайын
705	алмастыру
706	орнын өзгерту
707	қоғам
708	көпшілік
709	адамдар
710	университет
711	ВУЗ
712	колледж
713	құқықтық
714	дипломатиялық
715	орган
716	лауазымды
717	жасау
718	қондыру
719	тұрғызады
720	құрылтайшылық
721	үлкейту
722	ұлғайту
723	қалаулы
724	элективті
725	электоральды
726	еркін
727	өзі
728	мүшесі
729	конгрессмен
730	сәйкестікті
731	кәсіптік
732	ұлттық
733	міндеттеме
734	тапсырма
735	уәкіл
736	ұйым
737	шектеседі
738	астасады
739	сабақтасады
740	тұтастасады
741	бойжеткен
742	жаңа өсіп келе жатқан
743	көсемдік
744	бастаушылық
745	басшылық
746	тыю
747	тоқтау қою
748	өшіру
749	тіркелуші
750	форум
751	жиналыс
752	үй
753	қора
754	шахта
755	мекен
756	республика
757	тәуелсіз
758	аралық фазасы
759	айқындалу формасы
760	сиреу
761	сілдіреу
762	пайда болу
763	стандартты
764	анықтамалық
765	мәселе
766	ой
767	аңғаршулық
768	байқаушылық
769	әйел адам
770	ер адам
771	шек 
772	меже
773	еріктілік
774	ұзындайды
775	байқамау
776	жанына бату
777	ауырсыну
778	жазалау
779	сазай
780	факт
781	парламент
782	жиналыс
783	палата
784	әрекет
785	бағынышты
786	өзекті
787	заманға сәйкес
788	демократия
789	президент
790	риза болып шаттану
791	 көңілдену
792	таңдау
793	іздеу
794	сити
795	орталық
796	мекен
797	көрінген
798	денсаулықты тексерткен
799	емделген
800	нұсқау
801	кешіру
802	жол беру
803	кепілдік беру
804	жабдықтау
805	артық
806	жерге қарай
807	сүйемелдеу
808	кіргізу
809	жаратпау
810	қайта жасау
811	өңір
812	түсіру
813	қажеті шамалы
814	кезде
815	еске алынатын
816	тыңдаушылар
817	әлемдік
818	ауқымды
819	төрағалық етуші
820	қайта өңдеу
821	арыздану
822	коворкинг
823	жүргізу
824	 іріктеу 
825	сұхбат
826	соттасу
827	жаттығу
828	ішінде
829	ойлану
830	палата
831	анықтама
832	вакцинация шаралары
833	көрсету
834	ұйымдасу
835	аяқтау
836	жылжыту
837	орган
838	нұсқа
839	 ұсыныс
840	ақша
841	жолыру
842	жылумен жабдықтау
843	регламенттеу
844	тоқу
845	ықпал
846	нығайту
847	кету
848	сұрыптау
849	шынайы 
850	шиеленіс
851	өнгелеу
852	бейнелеу
853	жаңа
854	сұранысқа ие
855	күтілетін
856	шет қақпайлау
857	терең
858	қадірлі
859	ер адам
860	көмек
861	төбелесу
862	шоғырланған
863	қарым
864	жәрдемімен
865	жіп
866	келісім
867	маман
868	президент
869	жол-жоба
870	айқындау
871	кемсіту
872	жоқ қылу
873	бас қолбасшы
874	төлеу
875	орынбасарлар
876	хат
877	табиғи ресурс
878	өзен
879	жасыл желектер
880	хайуанаттар бағы
881	 тіршілік
882	кідіру
883	эталон
884	жиынтық
885	өкілдік
886	араласып-құраласу
887	рапорт
888	жария емес
889	активті сайлау
890	жігерлі сайлау
891	үдемелі сайлау
892	ақырын сайлау
893	жай сайлау
894	Мерзімді ақпараттық басылымның түрі
895	Кандидаттардың аты-жөндері жазылған дауыс беруге арналған парақ
896	Қоғамдық маңызы бар істер, орын алған окиғалар туралы қысқаша ресми хабарлама
897	категория
898	жауапкершілікке алу
899	арнайы
900	қайтара дауыс беру
901	негіз
902	құқық
903	Нақтылы тілек
904	тұжырымды пікір
905	жиналыс
906	жазбалар жүргізетін тұлға
1033	жасырын
907	жиналыс нәтижесін жазатын тұлға
908	тапсырмалар орындауға жалданған тұлға
909	мәліметтерді ашық жариялауға арналған әлеуметтік мекеме
910	мәлімдеу
911	басты тұлғаның көмекшісі
912	Мекеме бастығының бірінші көмекшісі
913	қызметкер
914	бюро
915	механизм
916	әрекет етуші тұлға
917	бір нәрсенің таңбасы, өзіндік белгісі
918	өрел
919	жабду
920	басқарушы орган
921	ұйым басшысы
922	Мемлекеттік билік пен басқарудың атқарушы және өкім етуші орғандары; басқару аппараты
923	халайық
924	әлеуметтік желі ресурсы
925	жер
926	аумақ
927	аймақ
928	жер
929	аумақ
930	аймақ
931	ақпарат
932	жаңсақтық
933	ұйым немесе біреудің атынан  әрекет ету құқығын беретін құжат 
934	құжат
935	орындалған жұмыстар бойынша әзірленетін құжат
936	компания
937	бір топ адам бірлесіп іс басқару формасы
938	бейкоммерциялық
939	жазылған
940	жазу арқылы
941	әділетсіз
942	дұрыс емес
943	заңға қайшы
944	Палата
945	Сенат және Мәжіліс
946	мемлекеттік орган
947	ұлттық
948	жоғарғы өкімет билігі халықтың қолында болатын мемлекет құрылысы
949	қоғамды саяси ұйымдастыру формасы
950	белгілі бір ұжымды басқару әдісі
951	белгілі бір тәртіппен қабылданған нормативтік құқықтық актілердің жиынтығы
952	тек
953	қоғам
954	Коммуникация орнату құралы
955	ел
956	мемлекет
957	мемлекеттік
958	өзгерістер
959	мемлекеттік
960	ұлттық
961	жиналыс
962	жұмыс
963	іріктеу
964	жетекші орын
965	басқару органы
966	интернет ресурс
967	ашық аймақ
968	құпия алаң
969	жасырын алаң
970	ішкі алаң
971	көмектесу
972	орта
973	мемлекеттік
974	жорамал
975	біреудің уәкілдігін куәландыратын құжат
976	елді басқару үшін берілген құқық
977	халықаралық ұйым мүшелерінің жалпы жиналысы
978	тез
979	әділ
980	әділетті
981	тура
982	нұсқаулық
983	ереже
984	ескертпе
985	қаймана
986	басқа
987	шек қою
988	бұқаралық ақпарат құралдары редакциясы
989	газет редакциясы
990	бас редакция
991	қаралатын мәселе
992	жиын
993	тәртіп
994	адам басы
995	бір адам
996	ақиқат
997	оқиға
998	шындық
999	жынысы әр түрлі адамдар
1000	өзге ел
1001	шет аймақ
1002	республика
1003	қағида
1004	ұстаным
1005	өз алдына
1006	тұрғылықты жері
1007	тұратын орны
1008	қиыр
1009	шет жақ
1010	жеке меншік
1011	басқа мемлекет
1012	тұлға құқығы мен міндеттерінің жиынтығы
1013	мемлекет тарапынан тұлға құқығын қорғау
1014	әрекет
1015	қимыл
1016	көрсетілім
1017	қорғанысты қамтамасыз ету
1018	қорғау
1019	қамқорлық жасау
1020	дауыс бермеу
1021	негізгі ереже
1022	арна
1023	схема
1024	ерегіс
1025	тәжікелесу
1026	сөз таластыру
1027	шақ
1028	хабар тарату
1029	экраннан көріну
1030	жарияланым
1031	жазба
1032	құпия
1034	ішкі
1035	төңірек
1036	орындалатын қадамдар
1037	талдау жасайтын маман
1038	түзеу
1039	жаңадан жөндеу
1040	бөгет қою
1041	шектеу
1042	сұхбат беру
1043	Мекеме
1044	өзгерістер енгізуге бағытталған шара
1045	үміткер немесе партия сайлануы үшін сайлаушылардың көпшілік дауысын алуы қажет
1046	аралас
1047	деңгей
1048	құрамында емес
1049	әкесінің аты
1050	өкім шығарушы
1051	заң немесе құқық бұзушылықтар жасауға байланысты қойылатын төлемдер
1052	шалғай
1053	тұтас бір заттың бөлімдерінің өзара орналасуы
1054	талқандау
1055	ақша бөлу
1056	таңдау жасау
1057	жеребе салу
1058	жеребе тастау
1059	тиісінше
1060	қандай да бір ақпараттық материалдарды ілуге арналған құрал
1061	ақпаратты орналастыруға арналған зат
1062	қойғыш
1063	іргетас
1064	шама
1065	өшпендік
1066	өкім
1067	заңның орындалуын қадағалайтын мемлекеттік орган
1068	заңды бұзған кісілерді жауапқа тартатын мемлекеттік орган
1069	уақ
1070	ойластырылмаса
1071	дұрыс емес
1072	тұсында
1073	аймағында
1074	ұқсас
1075	құдды
1076	амандық-саулық жайы
1077	мемлекеттік мекеме
1078	үкіметбасы
1079	кіріс-шығыс ақша сметасы
1080	кему
1081	азаю
1082	өлке
1083	парламенттің немесе парламент палатасының төрағасы
1084	басшы
1085	әжептеуір
1086	мәжілісті жүргізуге 
1087	өзгерістер енгізу
1088	қайта жөндеу, түзеу
1089	түрлендіру
1090	шектелмеген
1091	шексіз
1092	бейпіл
1093	наразылық білдіру
1094	уәкілдік мекеме
1095	заң шығаратын мекеме
1096	заң шығаратын органның жоғары палатасының мүшесі
1097	сенат мүшесі
1098	мөлдір
1099	адам
\.


--
-- TOC entry 3726 (class 0 OID 18126)
-- Dependencies: 219
-- Data for Name: quote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quote (id, quote, quote_by, added_by, created, updated) FROM stdin;
1	Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.	Allan Kay	Sam	2022-08-04 17:04:32	\N
2	Мен қосып отырмын 	Altosh	Altosh	2022-08-05 11:46:28	\N
\.


--
-- TOC entry 3730 (class 0 OID 18160)
-- Dependencies: 223
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_id, name, description) FROM stdin;
1	user	user has minimal opportunities \n
2	admin	admin can change inforamtion in the site but not source code
\.


--
-- TOC entry 3750 (class 0 OID 19042)
-- Dependencies: 243
-- Data for Name: school_termins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_termins (id, subject_id, termin, definition, class) FROM stdin;
2	1	Scrath	анимациялық ертегілер, ойындар мен модельдерді құрастыруға арналған жаңа программалау ортасы	4
3	1	VideoPad	видеожазбалар жазуға, жазылған видеожазбаларды өңдеуге, дыбыс жазуға, сақтауға арналған редактор	4
4	1	Айнымалы	компьютердің уақытша жадында қандай да бір мәнді сақтайтын орын	4
5	1	Ақпарат	қоршаған ортада болып жатқан құбылыстар мен хабарлар туралы мәліметтер	3
6	1	Ақпарат көзі	қоршаған орта	3
7	1	Ақпаратты өңдеу	ақпараттың өзгерту үрдісі	3
8	1	Ақпараттық-коммуникациялық технологиялар	компьютер арқылы электрондық оқулықтарды, интерактивті тақтаны, ғаламторды қолдануға арналған қүрал	3
9	1	Анимация	нысандардың қозғалысыі	3
10	1	Анимациялау	нысандардың қозғалысын жасау үрдісі	3
11	1	Арифметикалық команда	мәндеері бүтін немесе нақты болатын сандармен жұмыс істейтін команда	4
12	1	Блокнот	мәтінмен жұмыс жасауға арналған ең карапайым програм	3
13	1	Браузер	Интернеттегі веб-парақшаларды, мәліметтерді оқуға, іздеуге арналған програм	4
14	1	Бума	компыотердегі файлдардың жинағы	3
15	1	Видеоақпарат	арнайы программаның көмегімен жазылатын электрондық ақпараттар, видеолар мен жазбалар.	4
16	1	Видеожазба	видео және аудио ақпаратты жазу.	4
17	1	Вирус	өздіпнен көбейе беретін зақымдаушы лрограмма	3
18	1	Гиперсілтеме	белгілі бір үлкен мәтінді тез табуға көмек беретін сілтеме	3
19	1	Графикалық редактор	графикалық бейнелерді салуға, сақтауға және өңдеуге арналған програм	3
20	1	Датчик	әртүрлі ақпаратты (температура, жылдамдық, сәуле, түс, дыбыс) өлшеуге арналған құрал.	4
21	1	Диаграмма	кез келген мәндердің өзара байланысын анық көрсететін графикалық кескін.	4
22	1	Дыбыстық адаптер	компьютерде дыбысген жұмыс істеуге мүмкіндік беретін құрылғы.	4
23	1	Дыбыстық редактор	дыбысты шығауға, сақтауға және өңдеуге арналған програм	3
24	1	Жанасу датчигі	батырманың басылғанын немесе басылмағанын дәл анықтайтын құрал.	4
25	1	Жұмыс үстелі	компьютер іске қосылғаннан кейінгі жүмыс істеуге дайын экран бейнес	3
26	1	Жүйелііблок құрамы	процессор жөне негізгі жады	3
27	1	Кегельринг	робототехникадағы жарыстардың бір түрі.	4
28	1	Кеңейтілген шындық	адамға өзінің сезімімен: көру, тыңдау, сенсорлық және басқалар арқылы жіберілетін техникалыққұрал.	4
29	1	Компьютер	ақпаратты қабылдайтын, өңдейтіг және сақтайтын электрондық қүрылғы	3
30	1	Компьютердің қосымшаі қүрылғылары	тінтуір, принтер, дыбыс колонкалары,	3
31	1	Компьютердің негізгі қүрылғылары	жүйелікблок, монитор, пернетақта	3
32	1	Компьютерлік сауаттылық	компьютерді пайдалана отырып, деректерді оқу, өңдеу, жазу және іздеу жолдары	3
33	1	Кірістірілген цикл	бір циклдің ішіне орналастырылған цикл	4
34	1	Лабиринт	түрлі өткелдер мені жолдар арқылы берілген, шатасқан, күрделі құрылым.	4
35	1	Логиикалық команда	мәндеері ақиқат немесе жалған болатын логикалық шамалармен жұмыс істейтін команда	4
36	1	Мәтін	әңгімелер, ертегілер, мақалалар, өлендер, хабарландырулар, қүттықтаулар, мәліметтер, тағы да басқа жазба ақпараттар	3
37	1	Мәтіндік редактор	мәтінді теруге, өшіруге, өңдеуге, көшірмесін алуға, сақтауға және басып шығаруға мүмкіндік беретін програм.	3
38	1	Модем	компьютерге телефон арқылы ғаламтор желісін қосуға мүмкіндік беретін қүрылғы	3
39	1	Монитор	ақпаратты экран бетіне шығару қүрылгысы	3
40	1	Операторлар блогы	командалары арифметикалык және логикалық болатын блок.	4
41	1	Пароль	қолданушының өзі туралы ақгаратты растауға арналған құгия сөзі немесе таңбалар жиынтығы.	4
42	1	Пернетақта	ақпаратты компьютерге енгізуге арналган қүрылғы	3
43	1	Презентация	ақпараттың қагазга корнекі түрде сурет, сызбалармен безендіріп, дайындалган көрсетілім	3
90	2	табиғат	бізді қоршаған орта. Табиғат жанды және жансыз табиғат болып бөлінеді	1
44	1	Програмдар терезесі	операциялык жүйесінде жүмыс жасауға арналған програмдар экранның жақтауларымен шектелген төртбұрышты аймак	3
45	1	Программдық қамтым	компьютерде сақталатын барлық програмlдар	3
46	1	Салыстыру операторы	екі мәннің өзара тең немесе бірі екіншісінен артық не кем екендіктерін анықтайтын оператор	4
47	1	Скрипт	блок командаларының көмегімен құрылатын сграйттардың іс-әрекет ретін көрсететін грограмма.	4
48	1	Слайд	грезентацияның әр беті.	4
49	1	Слайдтар арасындағы ауысу	бір слайдтың екінші слайдген ауысуы кезіндегі әсерлер жиыны.	4
50	1	Спрайт	Scrath программалау ортасының кейіпкері	4
51	1	Таңбаша	сол жақ төменгі бұрышында кішкене багыттаушысы бар нысан	3
52	1	Терезенің түрлері	бумалар терезесі, қосымшалар терезесі, сүхбаттық терезе, анықтама терезесі	3
53	1	Түс датчигі	түс немесе жарық жарықтылығын анықтай алатын сандық құрал.	4
54	1	Тінтуір	компьютер экранындагы меңзерді басқару қүрылгысы	3
55	1	Ультрадыбыс датчигі	дыбыс толқындарын жіберіп, қайтып келген сигналда_ 'ы оқитын және нысандарды тауып, оларға дейінгі қашықтықты есептейтін құрылғы	4
56	1	Файл	компьютер програмдарында сақталған құжат	3
57	1	Циклдік	командалардың іс-әрекеттері бірнеше рет қайталануы	4
58	1	Цмфплық қүрылгылар	цифрланған деректерді жинақтау, жеткізу, қабылдау, бақылау, сақтау, түрлендіру сияқты қызметтер атқаратын электрондық сұлбалардан тұратын құрылғылар	3
59	1	Іздеу жүйесі	мәліметті ғаламтордан іздеу мүмкіндігін ұсынатын веб-сайт	3
60	2	арамшөп	мәдени өсімдіктердің өсуіне кедергі келтіретін жабайы өсімдік	1
61	2	астроном	аспан әлемін зерттейтін ғалым	1
62	2	Астрономия	аспан денелері, олардың құрылысы, қозғалысы туралы ежелгі ғылым	1
63	2	астрономия	аспан денелерін, құрылысын, қозғалысын зерттейтін ғылым	1
64	2	ағаш	діңі, бұтағы, жапырағы бар көпжылдық өсімдік	1
65	2	Батарея	мөлшері жағынан шағын электр көзі	1
66	2	бақылау	таныпбілудің ең қарапайым әдісі. Бақылауды сырттай немесе тәжірибе жасау арқылы жүргізеді	1
67	2	боз ала таң	күн шапағының белгісі, таңның ағара бастауы	1
68	2	ботаник	өсімдіктер әлемін зерттейтін маман, ғалым	1
69	2	бұта	түп болып өсетін, ағаштан аласа өсімдік	1
70	2	гүл	сабақта не жанама бұтақ ұшында өседі. Гүлден жеміс пен тұқым дамиды	1
71	2	Дыбыс мүшесі	дыбыс шығаратын дене	1
72	2	жабайы жануарлар	табиғат аясында өз бетінше тіршілік ететін жануарлар	1
73	2	жабайы өсімдіктер	табиғатта өздігінен өседі. Бұл өсімдіктерге адам күтім жасамайды	1
74	2	жаратылыс	табиғи болмыс, табиғат	1
75	2	жарық көзі	жарық шығаратын дене	1
76	2	жасанды дыбыс	сыртқы күштің әсерінен дыбыс шығаратын денелер. Мысалы: музыкалық аспаптардың дыбысы, телефон шырылы, мәшиненің дабылы, қоңырау үні	1
77	2	жасанды жарық көзі	адам қолымен жасалған жарық көздері	1
78	2	Жер	өмір сүруге болатын жалғыз ғарыш денесі	1
79	2	жыл құстары	күзде жылы жаққа ұшып кететін құстар. Олар: бұлбұл, қарлығаш, шұбар шымшық, тырна тағы басқалар	1
80	2	зерттеуші	ғылыми жұмыс жүргізетін, зерттейтін адам	1
81	2	Каникул	оқушыларға тоқсан арасында және оқу жылының соңында берілетін демалыс мерзімі	1
82	2	кешқұрым	күн батқан кез	1
83	2	Күн	Жерге ең жақын жұлдыз	1
84	2	магнит	кейбір металдан жасалған денелерді тартады. Олар бірбіріне тартылады, кейде бірбірінен тебіледі	1
85	2	Магнит	металдан жасалған заттарды өзіне тартып алатын немесе тебетін қасиеті бар зат	1
86	2	мәдени өсімдік	адам күтіп өсіретін өсімдік	1
87	2	обсерватория	ғарыш әлемін зерттеуге арналған орталық	1
88	2	сәби	бір жасқа дейінгі нәресте	1
89	2	сәуле	бойында энергиясы бар сызық. Жарық адамдар, жануарлар мен өсімдіктердің тіршілігі үшін аса қажет	1
197	2	Ластану	қоршатан орта құрамының өзгеруі	3
91	2	табиғи дыбыс көздері	адамның дауысы, жапырақтың сыбдыры, судың сылдыры, найзағайдың күркіреуі т.б	1
92	2	табиғи жарық	табиғатта өздігінен жарық шығаратын денелер	1
93	2	Телескоп	аспан денелерін бақылауға арналған құрал	1
94	2	траектория	қозғалыстағы дененің қалдырған ізі	1
95	2	Траектория	дененің қозғалыс кезінде жасайтын сызығы	1
96	2	тәжірибе жасау	адамның мақсатына сәйкес ісәрекеті	1
97	2	электр	жарыққа, жылуға айналатын энергияның пайдалы түрі. Оны электр көздерінен алады	1
98	2	Электр	бар электр құралдарының, медициналық аппараттардың жұмыс істеуіне қажетті қуат көзі	1
99	2	қараңғы	жарық түспеуі, еш нәрсенің көрінбеуі	1
100	2	қозғалыс	қимыл, ісәрекет, жүрістұрыс	1
101	2	үй жануарлары	қолға үйретілген жануарлар. Олардың сүті, еті – тағам, жүні мен терісі – киім. Жылқы мен түйені көлік ретінде пайдаланады	1
102	2	Ай	Жердің табиғи серігі	2
103	2	Алып	өте үлкен мөлшердегі зат не нысан	2
104	2	Аман қалу	кез келген жағдайға қарамастан тіршілігін жалғастыру	2
105	2	Атмосфера	Жердің ауа қабаты	2
106	2	Аққыш	судың ағу қасиеті	2
107	2	Балықтар	суқоймаларды мекендейтін жануарлар тобы. Желбезегімен тыныс алады, жүзбеқанаттары мен құйрығының көмегімен қозғалады	2
108	2	Бауырымен жорғалаушылар	бауырымен қозғалатын жануарлар. Олардың денесі қабыршақтармен қапталған	2
109	2	Бекіту	затты құлап қалмау үшін орнаты	2
110	2	Бу	судың үш күйінің бірі	2
111	2	Бунақденелілер	денесі үш бунақтан: бас, кеуде және құрсақтан тұратын жануарлар	2
112	2	Бұлшық еттер	адамдар және жануарлардың дене мүшелері. Бұлшық еттер жіңішке талшықтардан тұрады да, сүйектерге бекітіледі	2
113	2	Градус	температураның өлшем бірлігі	2
114	2	Дария	суы мол өзен, көл, теңіз	2
115	2	Дене сымбаты	адамның отырғанда, тұрғанда, жатқанда денесін түзу ұстау қалпы	2
116	2	Жанартау	жер астынан атқылап шығатын балқыған тау жыныстары	2
117	2	Жануарлардың бүркеніш реңі	жануарлардың өзінің түсін өзгертіп, қоршаған ортаға сіңісіп кете алатындай қорғану әрекеті	2
118	2	Жол	зат не нысан жүріп өткен арақашықтық	2
119	2	Жылдамдық	уақыт бірлігі ішінде қанша жолды жүріп өткенін білдіретін шама	2
120	2	Жылу	заттың, дененің қызған қалпы	2
121	2	Жұлдыз	жанып тұрған шар түріндегі үлкен ғарыш денесі	2
122	2	Күн жүйесі	Күнді айнала қозғалатын барлық ғарыш денесі	2
123	2	Күш	заттың не нысанның басқаға әсер ету шамасы	2
124	2	Көбею	өсіп-өну, ұрпақ тарату	2
125	2	Масса	таразымен өлшеуге болатын шама	2
126	2	Материал	заттарды жасайтын нәрселер	2
127	2	Минут	уақыттың өлшем бірлігі. 1 сағатта 60 минут бар	2
128	2	Мұз	судың қатты күйі	2
129	2	Мұз тұманы	ауа температурасы -30С-тан төмендеген кезде, аяз күндері байқалатын табиғи құбылыс	2
130	2	Мөлдір зат	жарық өткізетін зат	2
131	2	Расытхана	ғарышты зерттеуге арналған құрылғылармен жабдықталған ғимарат	2
132	2	Рең	жануар денесінің түсі	2
133	2	Сіңіру	өзіне бір нәрсені тарту, мысалы, топырақтағы құнарлы заттарды бойына тарту	2
134	2	Сүйектер	қатты мүшелер, қаңқаның негізі	2
135	2	Сүтқоректілер	балаларын сүтімен асырайтын жануарлар	2
136	2	Тіршілік ортасы	тірі ағзалардың тіршілік ету аймағы	2
137	2	Тіс	тамақты тістеуге, шайнауға арналған ауыз қуысындағы мүше	2
138	2	Тісжегі	тістің бұзылуы	2
139	2	Табиғат ресурстары	адамдардың түрлі қажеттіліктеріне пайдаланатын табиғат бөлшектері	2
140	2	Таразы	заттардың массасын өлшейтін құрал	2
141	2	Температура	зат не нысанның қаншалық қызып тұрғанын көрсететін шама	2
142	2	Термометр	температураны өлшейтін құрал	2
143	2	Террариум	қосмекенділер мен бауырымен жорғалаушы жануарларды ұстауға арналған орын	2
198	2	Ластану	қоршаған орта құрамының өзгеруі	3
144	2	Уылдырық	балықтардың, қосмекенділер мен басқа да жануарлардың жұмыртқасы	2
145	2	Ыдыс	заттармен, сұйықтықтармен немесе майда нәрселермен толтыруға болатын заттар, түтіктер	2
146	2	Ылғалсүйгіш өсімдіктер	суды көп мөлшерде қажет ететін өсімдіктер	2
147	2	Эталон	өлшем бірліктерінің ең жоғарғы дәлдігінің баламасы	2
148	2	Ғаламшар	ғарыш денесі	2
149	2	Қаңқа	денені ұстап тұратын тірек. Ол ішкі мүшелерді қорғайды әрі денеге пішін береді	2
150	2	Қолдану саласы	әр нәрсені пайдалануға болатын шегі, орны	2
151	2	Қосмекенділер	суда да, құрлықта да тіршілік етуге бейімделген жануарлар	2
152	2	Қысқарту	неғұрлым қысқа ету	2
153	2	Құрғақшылыққа төзімді өсімдіктер	ылғал жетіспеушілігі мен жоғары температураға шыдамды өсімдіктер	2
154	2	Құстар	қанаттары, екі аяғы, тұмсығы мен құйрығы бар жануарлар. Олардың денесі қауырсындармен қапталған	2
155	2	Ұстау	тірек болу, құлатпау	2
156	2	Өнім	қандай да бір еңбек пен өңдеудің нәтижесі	2
157	2	Өткізу	өсімдіктің тамырынан жапырақтарына, гүлдері мен жемістеріне су мен құнарлы заттарды сіңіруі	2
158	2	Азот	ауа құрамына кіретін газ	3
159	2	Асқорыту	ағзаның асты сіңіруі	3
160	2	Асқорыту жүйесі	асқорыту мүшелері	3
161	2	Атмосфера	Жердің ауа кабығы	3
162	2	Ауатамырлар	тыныс алу жолдары	3
163	2	Ауызсу	ішуге жарамды су	3
164	2	Ауырлық күші	ғаламшардың денелерді өзіне тарту күші	3
165	2	Батпақтану	шалғынның, орман бөлігінің не көлдің орнында батпақ пайда болуы	3
166	2	Бейімделу	қоршаған ортаның әсеріне байланысты өсімдіктердің, жануарлардың өзгеріске түсуі	3
167	2	Биосфера	Жердің тіршілік қабаты	3
168	2	Борпылдақ топырақ	бос, арасында ауасы мол қопсытылған топырақ	3
169	2	Булану	1) судың суық күйден газға айналуы; 2) жапырақтан су буының бөлінуі	3
170	2	Бәсеке	ортақ ресурсты пайдаланудағы адамдар, жануарлар арасында болатын өзара күрес, талас	3
171	2	Газ тәрізді	зат күйінің бір түрі	3
172	2	Гидросфера	Жердің су қабаты	3
173	2	Гипотеза	зерттеу нәтижесін алдын ала болжау	3
174	2	Глюкоза	фотосинтез үдерісі кезінде түзілетін қоректік зат	3
175	2	Децибел	дыбыс қаттылығының өлшем бірлігі	3
176	2	Дыбыс толқындары	дыбыстың ауада, суда және қатты ортада таралуы	3
177	2	Егіншілік	өсімдік (астық, көгөніс, бау-бақша) өсірумен айналысатын шаруашылық	3
178	2	Жарықтың шағылуы	жарық сәулесінің денеден шағылу құбылысы	3
179	2	Жасанды бірлестіктер	адам қолымен өсірілген өсімдік бірлестігі	3
180	2	Жасанды серік	Жер орбитасы бойымен қозғалатын ғарыштық ұшу аппараты	3
181	2	Жойылып бара жатқан өсімдіктер	саны жағынан азайып бара жатқан өсімдіктер	3
182	2	Жүрек	қанайналым жүйесінің басты мүшесі	3
183	2	Зат	денені құраушы материал	3
184	2	Зымыран	ғарышкерлердің ғарышқа ұшуына арналған ұшу аппараты	3
185	2	Иммунитет	ағзаның түрлі инфекциядан қорғану қабілеті	3
186	2	Инфографика	қысқаша мәліметтер жазылған сызба немесе суреттер	3
187	2	Кеңірдек	адамның тыныс алу жүйесінің мүшесі	3
188	2	Кеңістік	қандай да бір заттар мен нысандардың арасы	3
189	2	Күй	заттың қасиеті: қатты, сұйық және газ тәрізді	3
190	2	Күннің батуы	күннің көкжиекке жасырынуы	3
191	2	Күннің шығуы	көкжиектен күннің көрінуі	3
192	2	Күретамыр	оттекке қаныққан қанды тасымалдайтын тамырлар	3
193	2	Көктамыр	көмірқышқыл газға қаныққан қанды тасымалдайтын тамырлар	3
194	2	Көлеңке	мөлдір емес заттардың артындағы жарық түспейтін кеңістіктегі бөлігі	3
195	2	Көмірсулар	тағамның құрамындағы ағзаға күш пен энергия беретін элементтер. Олар жай (қантта, тоқашта) және күрделі (дәнді дақылдарда, көгөністерде, балда) болып бөлінеді	3
196	2	Көмірқышқыл газ	жануарлардың, адамның тыныс алу үдерісінің өнімі, түссіз газ	3
199	2	Литосфера	Жердің қатты қабаты	3
200	2	Май	үйкелісті азайтатын зат	3
201	2	Май	үйкелісті азайтатын зат	3
202	2	Майлар	тағамның құрамдас бөлігі. Майлар жануарлар майы және өсімдік майы болып бөлінеді	3
203	2	Найзағай (жасын, жай)	күн күркірегенде атмосферадағы жарқыл түрінде пайда болатын электр разряды	3
204	2	Нәруыздар	тағамның құрамдас бөлігі. Сүттің және сүттен жасалған тағамдардың құрамында, ірімшік, сүзбе, асылған ет және жұмыртқаның құрамында болады	3
205	2	Омыртқалы жануарлар	ішкі қаңқасы болатын жануарлар	3
206	2	Омыртқасыз жануарлар	омыртқа жотасы жоқ жануарлар тобы	3
207	2	Орбиталық стансы	ғарышкерлердің ғарышта ұзақ уақыт бойы болуына арналған ұшу аппараты	3
208	2	Ось	Жер шарының полюстері арқылы өтетін ойша алынған сызық	3
209	2	Ось	жер шарының полюстері арқылы өтетін ойша алынған сызық	3
210	2	Оттек	барлық тірі ағзаның тыныс алуына және оттың жануына қажет түссіз, иіссіз газ	3
211	2	Парашют	ауадағы дененің козғалысын бәсеңдететін матадан жасалған құрылғы	3
212	2	Реактивті қозғалтқыш	зымыранды қозғалысқа келтіретін және оған қажет үлкен қозғалыс жылдамдығын қамтамасыз ететін қозғалтқыш	3
213	2	Селекция	егін ӨНІМІН арттыру үшін өсімдіктердің жаңа сорттарын алу жолын зерттентін ғылым	3
214	2	Серпімділік	әсер ету күші тоқтағаннан кейін дененің бастапқы пішініне келе алу кабілеті	3
215	2	Серпімділік	әсер ету күші тоқтағаннан кейін дененің бастапқы пішініне келе алу қабілеті	3
216	2	Сирек кездесетін өсімдіктер	саны жағынан аз кездесетін өсімдіктер	3
217	2	Су тасқыны	су қоймаларындағы судың кенеттен қатты көтерілуі	3
218	2	Сырғанау	белгілі бір дененің басқа бір дененің бетімен қозғалуы, жылжуы	3
219	2	Сүзгі	тазалауға арналған құрал. Мысалы, суды тазалау құралы	3
220	2	Тіршілік ету	белгілі бір аймақта ұзақ уақыт бойы өмір сүру	3
221	2	Табиғи өсімдік бірлестігі	бір жерде өсетін өсімдіктер тобы	3
222	2	Тамырдың соғуы	жүрек қозғалысына байланысты тамырдың серпінді соғуы	3
223	2	Темір	магниттелу қасиетіне ие металл	3
224	2	Тербеліс	дененің қайталанбалы қозғалыстары. Мысалы домбыра ішектерінің тербелістері	3
225	2	Тетік	күштің шамасы мен бағытын өзгертуге арналған құрылғы	3
226	2	Топырақ	жердің беткі құнарлы қабаты	3
227	2	Тыныс алу жиілігі	бір минуттағы тыныс алу мөлшері	3
228	2	Тыныс алу, тыныс шығару	тірі ағзаның (адамның) ауамен дем алу әрекеті	3
229	2	Тыныштықтағы күй (өсімдіктерде)	өсімдіктердің өсуі баяулайтын күйі	3
230	2	Тұщы су	тұзсыз, ішуге жарамды су	3
231	2	Фотосинтез	жарықтың әсерінен өсімдіктердің жапырағында оттек бөлінуі мен құнарлы заттардың түзілу үдерісі	3
232	2	Хлорофилл	өсімдік жапырақтарын жасыл түске ендіретін пигмент. Онсыз фотосинтез үдерісі жүзеге аспайды	3
233	2	Шіру	өсімдік пен жануар қалдығының бұзылуы	3
234	2	Ырғақ	қозғалыстардың қайталануы	3
235	2	Электр тізбегі	тұйықталған өткізгіш сым арқылы жасалған электр көзі мен электр энергиясын тұтынатын құралдар	3
236	2	Электр тогы	электр көзінен алынатын энергия. Соның көмегімен электрлік құралдар жұмыс істейді	3
237	2	Электр энергиясының көздері	түрлі энергия түрін электр энергиясына айналдыратын құрылғы	3
238	2	Электрлену	белгілі бір заттардың өзара үйкелісінен кейін өзіне қарай майда бөліктерді тарту қасиеті	3
239	2	Ғарышайлақ	зымыранды ғарышқа ұшыру алаңы	3
240	2	Қаратопырақ	қара түсті, құнарлылығы жоғары топырақ	3
241	2	Құрғақшылық	ыстық күндері ұзақ уақыт бойы жауын-шашынның болмауынан топырақтың құрғауы	3
242	2	Үйкеліс	қандай да бір дененің басқа бір дененің бетімен қозғалуына кедергі келтіретін күш	3
243	2	Үнемдеу	шығындарды азайту арқылы қор жинау тәсілі	3
244	2	Өкпе	басты тыныс алу мүшесі	3
245	2	Өрт	тұтанып, лапылдап жануы	3
246	2	Архимед	ежелгі грек ғалымы	4
247	2	Архимед заңы	Архимед атымен аталған денені кері итеруші күш туралы заң	4
248	2	Архимед күші	газ немесе сұйықтық тарапынан денені кері итеретін күш	4
249	2	Астероид	өз орбитасымен Күнді айнала қозғалатын кіші ғарыш денесі	4
250	2	Ауаның ластануы	зиянды және улы газ, шаң-тозаң, түтін сияқты заттардың атмосферамен араласуы	4
251	2	Ақ жарық	күннің сәулесі, ол қызыл, қызғылт сары, сары, жасыл, көгілдір, көк, күлгін түстерден құралады	4
252	2	Байыту	металдарды бос тау жыныстарынан ажырату әдісі	4
253	2	Балдыр	мүшелері болмайтын, төменгі сатыдағы өсімдік	4
254	2	Балқу	жоғары температурада қыздыру нәтижесінде заттың қатты күйден сұйық күйге айналуы	4
255	2	Балқыту	домна пештерінде кеннен метал алу үдерісі	4
256	2	Баррель	мұнайдың өлшем бірлігі, 1 мұнай баррелі шамамен 158 литр	4
257	2	Бағалы металл	табиғатта сирек кездесетін жылтыр металдар, оларды зергерлік бұйым жасауда қолданады	4
258	2	Болат	қара металл түрі	4
259	2	Бүйрек	зәр шығару жүйесіндегі зәр түзетін мүше	4
260	2	Бұршақ	жерге түйіршік мұз түрінде жауатын жауын-шашын	4
261	2	Бұрғылау	сұйық пайдалы қазба шоғырланған жерді үлкен бұрғымен тесу	4
262	2	Газ	сұйық пайдалы қазба және газтәрізді отын	4
263	2	Галактика	жұлдыздардан, ғарыш шаң-тозаңынан тұратын орасан зор ғарыш жүйелері	4
264	2	Галлактика	жұлдыздардан, ғарыш шаң-тозаңынан тұратын орасан зор ғарыш жүйелері	4
265	2	Дернәсіл	тірі ағзалардың жұмыртқадан дамитын ұрпағы	4
266	2	Дыбыстың шағылауы	дыбыс толқынының қандай да бір кедергіден кері қайтуы	4
267	2	Ерітінді	біртектес қоспа	4
268	2	Еріткіш	басқа заттарды ерітетін қасиеттері бар түрлі сұйық күйдегі заттар	4
269	2	Жазық	тегіс жер бедері	4
270	2	Жану	жарық пен жылу шығара жүретін құбылыс	4
271	2	Жанғыш пайдалы қазбалар	қазбалардың жанатын түрлері	4
272	2	Жарық көзі	жарық шығаратын денелер (табиғи, жасанды)	4
273	2	Жарық сәулесі	жарықтың таралу бағытын көрсететін сызық	4
274	2	Жатын	гүлдің дәл ортасында орналасқан бөлігі	4
275	2	Жауын-шашын	атмосфералық құбылыс	4
276	2	Жаңбыр	су тамшысы түрінде жауатын жауын-шашын	4
277	2	Жаңғырық	кедергіден шағылған және бақылаушы қабылдаған дыбыс	4
278	2	Жел	ауаның жер бетіндегі қозғалысы	4
279	2	Желдің бағыты	ауа қозғалысын білдіретін көрсеткіш	4
280	2	Желдің жылдамдығы	ауаның қозғалу жылдамдығы. Ол м/с, км/с деген бірліктермен беріледі7	4
281	2	Жер бедері	құрлықтағы жер бетінің ойлы-қырлы пішіндері	4
282	2	Жеңіл металл	жеңіл, пайдалануға қолайлы металдар	4
283	2	Жойылу қаупі	жануарлар санының азаюы	4
284	2	Жоғарғы сатыдағы өсімдіктер	барлық мүшелері (тамыры, сабағы, жапырағы, гүлі, жемісі) жетілген өсімдіктер	4
285	2	Жыл мезгілдері	Күн Жер бетін қыздыруына байланысты ауысатын жылдың төрт кезеңі	4
286	2	Жылуоқшаулағыш	жылуды өткізбейтін және нашар өткізетін дене	4
287	2	Жылуөткізгіш	дененің жылуды өткізу қасиеті	4
288	2	Жыртқыш	басқа жануармен (етпен) қоректенетін жануар	4
289	2	Жүйке жүйесі	ағзаның қызметін басқаратын, ми, жұлын және жүйкелерден тұратын жүйе	4
290	2	Жүйкелер	жүйке жүйесінің құрамдас бөлігі	4
291	2	Жұлдызқұрт	бунақ денелілердің дернәсілі	4
292	2	Жұлын	жүйке жүйесінің омыртқа өзегінде орналасқан мүшесі	4
293	2	Жұмыртқа	бунақ денелілердің даму кезеңінің алғашқы сатысы	4
294	2	Жұтылу	кедергіге жолыққанда дыбыстың азаюы, жарықтың әлсіреуі	4
295	2	Заряд	дененің электрлену қабілетін сипаттайтын шама	4
296	2	Заттың қасиеті	заттың басқа заттардан ерекшеленетін белгілері	4
297	2	Зәр шығару мүшелері	ағзадан су мен керексіз заттарды сыртқа шығаруға қатысатын мүшелер	4
298	2	Кібісе жыл	әр төртінші жылы қайталанатын, 366 күннен тұратын жыл	4
299	2	Карьер	пайдалы қазбаны ашық әдіспен өндіретін орын	4
300	2	Кедір-бұдыр бет	ұсақ немесе өте ұсақ ойыстары бар беттер	4
301	2	Кен	1. құрамында металы бар табиғи минералдар; 2. пайдалы қазбаның жалпы атауы	4
302	2	Кенсіз пайдалы қазбалар	құрамында металл болмайтын пайдалы қазбаның түрі	4
303	2	Кері итеруші күш	сұйыққа немесе газға батырылған кез келген денеге төменнен жоғары қарай әсер ететін күш	4
304	2	Комета	Күн жүйесінің мұздан тұратын, жарқыраған құйрығы бар кіші ғарыш денесі	4
305	2	Күлте жапырақша	гүлдің түрлі-түсті жапырақшалары	4
306	2	Магмалық тау жынысы	магманың суынуынан пайда болған қатты тау жынысы	4
307	2	Материк	Жер бетінің ірі құрлық жерлері. Оларды мұхит қоршап жатады	4
308	2	Метеорит	Жерге құлаған аспан денесі	4
309	2	Ми	жүйке жүйесінің орталық мүшесі	4
310	2	Минералды су	Құрамында еріген тұздар болатын табиғи су	4
311	2	Мұнай	қара түсті сұйық, қоймалжың пайдалы қазба	4
312	2	Мұнай	жер бетіндегі ірі, тұтас су қабаты	4
313	2	Несепағар	зәр шығару жүйесіндегі зәрді қуыққа өткізетін мүше	4
314	2	Ойыс	құрлықтың таза деңгейінен төмен жатқан нүктесі	4
315	2	Опырылу	пайдалы қазбаларды қазып алған жерлерде пайда болған жарықшақтар, қазбалар	4
316	2	Оттек балоны	оттек сақталатын баллон	4
317	2	Оттек жастықшасы	оттек толтырылған арнайы жастықша	4
318	2	Полиметалл	бірнеше түсті металдан тұратын табиғи құрам	4
319	2	Поляр күні	полюстер маңайында 24 сағат бойы күн батпайтын кезең	4
320	2	Поляр түні	полюстер маңайында 24 сағат бойы күн шықпайтын кезең	4
321	2	Призма	қарама-қарсы табандары бірдей және параллель көпбұрыштардан тұратын дене	4
322	2	Сарқылатын ресурстар	ресурстардың таусылатын түрі	4
323	2	Сарқылмайтын ресурстар	ресурстардың таусылмайтын түрі	4
324	2	Сезім мүшелері	қоршаған ортадан түскен ақпаратты қабылдайтын мүшелер	4
325	2	Симбиоз	тірі ағзалар арасындағы қарым-қатынас	4
326	2	Сипап сезу	айналадағы заттар мен құбылыстарды тері арқылы сезіну	4
327	2	Су айналымы	судың Жер бетіндегі үздіксіз айналу үдерісі	4
328	2	Су көтерілуі	Айдың тартылыс күшінің әсерінен мұхит пен теңіз суының молаю құбылысы	4
329	2	Су қайтуы	Айдың тартылыс күшінің әсерінен мұхит пен теңіз суының тартылу құбылысы	4
330	2	Судың ластануы	тұрмыстық, өндірістік қалдық, зиянды заттардың суға араласуы	4
331	2	Тіршілік кезеңі	тірі ағзалардың даму сатылары	4
332	2	Табиғи катаклизм	табиғатта аяқ астынан болатын апаттар	4
333	2	Таза зат	бір заттан құралатын, қасиеттері тұрақты зат	4
334	2	Таттану	сыртқы әсердің нәтижесінде темірдің бүлінуі, қасиетінің өзгеруі	4
335	2	Тау	жер бедерінің биік пішіндері	4
336	2	Тау жынысы	жер қыртысын толтырып тұрған минералдар	4
337	2	Террикон	пайдалы қазбаларды өндіруден қалған бос тау жыныстарының үйіндісі	4
338	2	Теңелу	тәуліктегі күн мен түн ұзақтығының теңесуі	4
339	2	Тозаң	әртүрлі заттардың ұнтақ түріндегі ұсақ бөлшектері, түйіршіктері	4
340	2	Тозаңдану	тозаңның жатынға түсуі	4
341	2	Тозаңқап	гүлдегі тозаң дамитын орын	4
342	2	Тостағанша жапырақша	гүлді сыртынан қоршап тұрған жасыл түсті жапырақшалар	4
343	2	Тоқырау	бір тәулікте күн немесе түннің ең ұзақ болатын кезі	4
344	2	Түсті металл	құрамында темір жоқ металдар	4
345	2	Тұмша	ірі өнеркәсіптердің, көліктердің түтінінен, орман өртінен түзілетін тұман	4
346	2	Тұқымның таралуы	өсімдіктің тұқым арқылы жаңа аумаққа таралуы	4
347	2	Тұқымның өнуі	тұқымнан өскіннің өсіп шығуы	4
348	2	Төменгі сатыдағы өсімдіктер	қатпаршақтан басқа мүшелері болмайтын өсімдіктер	4
349	2	Шіру	ағзаның ыдырауы	4
350	2	Шахта	терең жер қойнауында жатқан кенді жабық әдіспен қазып алатын орын	4
351	2	Шойын	темірден алынатын қара металл түрі	4
352	2	Шық	топыраққа, өсімдіктерге тұрып қалатын тамшы түріндегі жауын-шашын	4
353	2	Шөгінді тау жынысы	жердің бетіндегі заттардың жер астындағы қабаттарға шөгуінен пайда болған тау жынысы	4
354	2	Ығысу	жылжу, орын ауыстыру	4
355	2	Электр өткізу	дененің электр зарядын немесе электр тогын өткізу қасиеті	4
356	2	Электроскоп	дененің электрленуін анықтауға арналған құрал	4
357	2	Электроқшаулағыш	электр зарядын немесе электр тогын өткізбейтін дене	4
358	2	Электрөткізгіш	электр зарядын немесе электр тогын өткізетін дене	4
359	2	Қайнау	жоғары температурада қыздыру нәтижесінде суық заттың булану үдерісі	4
360	2	Қар	мұз қиыршықтары түріндегі жауын-шашын	4
361	2	Қара металл	темір мен оның қорытпалары (шойын мен болат)	4
362	2	Қатпаршақ	балдырдың денесі	4
363	2	Қор	жер қойнауындағы пайдалы қазбалардың мөлшері	4
364	2	Қоректік тізбек	қорек пен пайдаланатын ағзалар арасындағы байланыс	4
365	2	Қорық	сирек кездесетін немесе жойылу шегінде тұрған жануарлар мен өсімдіктерді арнайы өсіріп, санын көбейтетін, мемлекет тарапынан қорғалған аймақ	4
366	2	Қоспа	екі және одан да көп заттан құралатын заттар	4
367	2	Қуыршақ	бунақденелінің даму кезеңінің бір сатысы	4
368	2	Қуық	зәр шығару жүйесіндегі зәр жиналатын бұлшықетті қуыс мүше	4
369	2	Қырау	жер бетіне, шөпке, заттарға мұз қабыршақтары түрінде жанасатын жауын-шашын	4
370	2	Құс жолы	Күн жүйесі мен Жер ғаламшары орналасқан галлактика	4
371	2	Құтқару құралы	адамды құтқару үшін қолданылатын құралдар	4
372	2	Ұлттық саябақ	табиғаты өзгеріссіз сақталатын, мемлекет қорғауына алынған аумақ	4
373	2	Өсімдік мүшелері	түрлі қызмет атқаруға бейімделген өсімдік бөліктері	4
374	2	Өсімдікқоректі	өсімдік бөліктерімен қоректенетін ағзалар	4
375	2	Өскін	тұқымнан өнетін өсімдік бастамасы	4
376	3	азайтқыш	азайту амалындағы азайғыштан шегерілетін сан	1
377	3	азайту	«–» (минус) таңбасымен белгіленетін математикалық амал	1
378	3	Азайту	қосуға кері арифметикалық амал	4
379	3	Азайту	екі қосылғыштың қосындысы мен қосылғыштардың біреуі бойынша екінші қосылғышты табу амалы	6
380	3	Айнымалы	әртүрлі мәндер қабылдай алатын шама	4
381	3	Айнымалы шамалар	сан мәндері өзгеріп отыратын шамалар	6
382	3	Айнымалының мәні	айнымалы қабылдауы мүмкін сандық мән	4
383	3	айырма (айырманың мәні)	азайту амалының нәтижесі	1
384	3	ақиқат	пікір, дұрыс пікір	1
385	3	Алгебралық өрнектер	әріптерден, сандардан және амалдар таңбалары мен қажет болған жағдайда жақшалардан құрастырылған жазу	6
386	3	алдыңғы сан	бұл тікелей берілген санның алдында тұратын сан	1
387	3	Аликвоттық бөлшек	алымы 1-ге тең, бөлімі 1-ден өзге натурал сан	5
388	3	Ар	шамалар метрикалық жүйесіндегі ауданның өлшем бірлігі. Қабырғасының ұзындығы 10 м болатын шаршының ауданына тең: 1 ар = 10 м · 10 м = 100 м2	4
389	3	Аралас периодты ондық бөлшек	периодты ондық бөлшектің үтірі мен бірінші периодының аралығында бір немесе бірнеше қайталанбайтын цифрлар тобы болатын бөлшек	6
390	3	Аралас сан	натурал сан мен дұрыс бөлшектің қосындысына тең сан	4
391	3	Аралас сан	бүтін бөліктен және бөлшек бөліктен тұратын сан	5
392	3	Аралас сан	қосу таңбасынсыз жазылған натурал сан мен дұрыс бөлшектің қосындысы	5
393	3	Аралас сан	жазылуында бүтін және бөлшек бөлігі бар сан	5
394	3	азайғыш	азайту амалын орындау кезінде шамасы кемітілетін сан	1
395	3	Ауданның өлшем бірліктері	см2; дм2; м2	4
396	3	Әріпті өрнек	сандар мен таңбалардан басқа әріптері бар өрнек	4
397	3	Әріпті өрнектер	құрамында әріптері бар өрнектер	5
398	3	Әріптің мәндері	әріпті өрнектегі әріптің орнына алынатын сандар	5
399	3	баға	бір тауардың (заттың) құны	1
400	3	басқатырғыш	шешу үшін тапқырлықты талап ететін тапсырма	1
401	3	Бір айнымалысы бар сызықтық теңдеу	ax+b=0 (мұндағы х айнымалы, а және b қандай да бір сан) түріндегі теңдеу үлгісі	6
402	3	Бірлескен жұмыс	екі немесе одан да көп жұмысшы орындайтын жұмыстың көлемі. Екі жұмысшының берілген уақыт аралығындағы бірлескен жұмысын табу үшін олардың бірлескен жұмыс өнімділігін осы жұмысты орындауға жұмсалған уақытқа көбейту қажет. Абірл. = vбірл. · t, мұндағы vбірл. = v1 + v2 бірлескен жұмыс өнімділігі әрбір жұмысшының жұмыс өнімділігінің қосындысына тең	4
403	3	Бірлік кесінді	ұзындығы бірлік ұзындық ретінде алынатын кесінді	5
404	3	Бірліктер класы	санның жазылуындағы алғашқы үш разрядтың бір топқа біріктірілуі	5
405	3	Бірліктер класы немесе бірінші класс	бірінші үш разрядты құрайтын класс (санның соңынан бастап оңға қарай): бірліктер разряды; ондықтар разряды; жүздіктер разряды	4
406	3	біртаңбалы сан	жазылуына бір цифр пайдаланылатын сан	1
407	3	бос жиын	бірдебір элементі болмайтын жиын	1
408	3	Бос жиын	элементтері болмайтын жиын « » деп белгіленеді	4
409	3	Бос жиын	бір де бір элементі жоқ жиын	5
410	3	Бос жиын - кез келген жиынның ішкі жиыны		3
411	3	Бөлу	екі санның көбейтіндісінің мәні және көбейткіштердің біреуі арқылы екінші көбейткішті табу үшін қолданылатын амал	5
412	3	Бөлшек	алымы және бөлімі бүтіннің (үлестің) бір немесе бірнеше бөлігінен тұратын сан. Бөлшек сызықпен бөлінген екі санның алымы мен бөлімінің көмегімен жазылады. Бөлімі зат қанша бөлікке бөлінгенін, ал алымы қанша бөлігі алынғанын көрсетеді. Мысалы, 5 8 бөлшек, мұнда 5 алымы, 8 бөлімі	4
413	3	Бөлшектерді салыстыру	бөлімдері бірдей екі бөлшектің қайсысының алымы үлкен болса, сол бөлшек артық болады. Бөлімдері бірдей екі бөлшектің қайсысының алымы кіші болса, сол бөлшек кем болады	4
414	3	Бөлшекті қысқарту	бөлшектің алымын да, бөлімін де олардың 1-ден өзге ортақ бөлшегіне бөлу	5
415	3	Бөлшекті қысқарту	жай бөлшектің алымы мен бөлімін олардың бірден өзгеше ортақ бөлгішіне бөлу	5
416	3	Бөлшектің толықтауыш көбейткіші	жай бөлшектің алымы мен бөліміне көбейтілетін сан	5
417	3	Бүтін сандар	натурал сандыр, оларға қарама-қарсы сандыр мен 0 саны	6
418	3	Бұрыс бөлшек	алымы бөліміне қарағанда үлкен бөлшек	4
419	3	Бұрыс бөлшек	алымы бөлімінен үлкен не оған тең бөлшек	5
420	3	Бұрыс жай бөлшек	алымы бөлімінен үлкен немесе оған тең жай бөлшек	5
421	3	Бұрыш	бір нүктеден шыққан (бұрыштың төбесі) екі сәуледен (бұрыштың қабырғалары) жасалған фигура	4
422	3	Бұрыш	бір нүктеден шыққан (бұрыштың төбесі) екі сәуледен (бұрыштың қабырғалары) жасалған фигура	4
423	3	Бұрыш	бір нүктеден басталатын екі сәуледен құралған фигура	5
424	3	Бұрыштың градустық өлшемі	берілген бұрышта неше градустық бірлік бар екенін көрсететін сан	5
425	3	Вектор	АВ векторы деп бас нүктесі А нүктесі соңғы нүктесі В нүктесі болтын бағытталған кесінді. Жазықтықтың кез келген нүктесін нөлдік вектор деп атайды	6
426	3	Векторлық шама	сан мәнімен де, бағытымен де берілетін шама	6
427	3	Вертикаль бұрыштар	бір бұрыштың қабырғаларының әрқайсысы екінші бұрыштың қабырғаларыынң созындысы болатын екі бұрыш	6
428	3	Гектар	шамалар метрикалық жүйесіндегі ауданның өлшем бірлігі. Жер телімдерінің ауданын өлшеу үшін қолданылады. Қабырғаларының үзындығы 100 м болатын шаршының ауданына тең: 1 га=10О м * 100 м = 10 000 м2	4
429	3	Грамм	массаның өлшем бірлігі. 1 кг 1000 г. (г) әрпімен қысқартылып белгіленеді	4
430	3	График	қандай да бір шаманың басқа шамаға тәуелділігін көрнекі бейнелеу үшін қолданылатын сызба	4
431	3	График	қандайда бір шаманың басқа шамаға тәуелділігін көрнекі бейнелеу үшін қолданылатын сызба	4
432	3	Ғасыр	100 жылға тең уақыт бірлігі, (ғ.) әрпімен қысқартылып белгіленеді	4
433	3	Дециметр	ұзындықтың өлшем бірлігі. 1 дециметр 10 сантиметрге тең	1
434	3	Диагональ	көпбұрыштың көршілес емес екі төбесін қосатын кесінді	5
435	3	Диаграмма	сандық мәліметтерді төртбұрыштар мен шаршылардың көмегімен көрсетілетін сызба	1
436	3	диаграмма	ақпаратты баған, дөңгелек түрінде ұсыну тәсілі	1
437	3	Диаграмма	мәліметтердің графикалық түрде берілуі	4
438	3	диаметр (d)	шеңбердің центрі арқылы өтетін және шеңбердің екі нүктесін қосатын кесінді	3
439	3	Доғал бұрыш	градустық өлшемі 90° -тан артық, бірақ 180° -тан кем бұрыш	5
440	3	Доғалбұрышты үшбұрыш	бір бұрышы доғал үшбұрыш	4
441	3	Доллар	АҚШ, Канада, Австралия, Ливан, Эфиопия, т.б. бірқатар елдер ақшасының атауы 1 доллар 100 центке тең	4
442	3	Дөңгелек	барлық нүктелері центрден бірдей қашықтықта орналасқан, сызықпен шектелген жазық фигура	3
443	3	Дөңгелек	жазықтықтың шеңбердің өзімен қоса алғандағы шеңбердің ішіндегі бөлігі	5
444	3	Дөңгелек диаграмма	мәліметтер бөлігіне байланысты қатынасты көрсететін өлшемдегі секторларға бөлінген дөңгелек графиктер. Дөңгелек диаграмма бүтіннің бөлігінің салыстырмалы өлшемі үшін қызмет жасайды	4
445	3	Дөңгелек секторы	дөңгелектің екі радиусы мен осы радиустар арасындағы доғамен шектелген бөлігі	5
446	3	Дөңгелектеу	мәнін цифрлардың санын кеміту жолымен жуықтап көрсету. Жуықтау дәрежесі талап етілетін нақтылыққа тәуелді	4
447	3	Дұрыс бөлшек	алымы бөліміне қарағанда кіші бөлшек	4
448	3	Дұрыс бөлшек	алымы бөлімінен кіші бөлшек	5
449	3	Дұрыс жай бөлшек	алымы бөлімінен кіші жай бөлшек	5
450	3	Евро	Евроодақ елдерінің валютасы	4
451	3	екітаңбалы сан	жазылуына екі цифр пайдаланылатын сан	1
452	3	Ең кіші ортақ бөлімі	берілген бөлшектердің бөлімдерінің ең кіші ортақ еселігі	5
453	3	Ең кіші ортақ еселік	берілген натурал сандардың әрқайсысына еселік болатын ең кіші натурал сан	5
454	3	Ең кіші ортақ еселік (ЕКОЕ)	берілген натурал сандардың әрқайсысына ортақ еселік болатын ең кіші натурал сан	6
455	3	Ең үлкен ортақ бөлгіш	сол сандардың әрқайсысы бөлінетін ең үлкен натурал сан	5
456	3	Ең үлкен ортақ бөлгіш	а және b сандары бөлінетін ең үлкен натурал сан	5
457	3	Ең үлкен ортақ бөлгіш (ЕҮОБ)	берілген сандардың әрқайсысы бөлінетін ең үлкен натурал сан	6
458	3	есеп (математикалық мәтіндік)	белгілі бір білім, білік, ойлауды пайдаланып, есептеудің көмегімен шығаруды талап ететін өмірлік жағдай (шарты мен сұрағы)	1
459	3	Есептерді шығарудың алгебралық әдісі	есептерді теңдеу құру жолымен шығару	4
460	3	Есептерді шығарудың арифметикалық әдісі	есептерді арифметикалық амалдар арқылы шығару	4
461	3	Есептеудің тиімді тәсілі	шығарған кезде математикалық амалдарды қолдануға ыңғайлы болатындай етіп таңдалып алынатын немесе есепті шығару аз амалмен орындалатын тәсіл	4
462	3	Еуро	Еуропалық Одақтың бірыңғай валютасы	4
463	3	Жай сан	1 саны мен өзіне ғана бөлінетін сан	5
464	3	Жай сандар	1-ге және өзіне ғана бөлінетін сандар	6
465	3	Жақындау жылдамдығы	уақыт бірлігі ішінде нысандардың бірбіріне жақындау қашықтығы	4
466	3	жалған пікір	дұрыс емес пікір	1
467	3	жиын	бұл ортақ белгілері (қасиеттері) бойынша біріктірілген нысандардың тобы	1
468	3	Жиын	бір нәрсе біріктірген немесе қандай да бір ережеге бағынатын нысандардың тобы. Нысандардың әртүрлі топтары арасындағы қатынасты жиын арқылы көрсетуге болады	4
469	3	Жиын элементтері	жиынды құрайтын заттар мен оъектілер	5
470	3	Жиындардың бірігуі	егер жиындар атауында «НЕМЕСЕ» сөзі қолданылса, онда оның әрбір элементі кез келген екі жиынның бірінде орналасуы мүмкін. U жиындардың бірігу белгісі	4
471	3	Жиындардың қиылысуы	егер жиындардың атауында «ЖӘНЕ» сөзі қолданылса, онда оның әрбір элементі екі жиынның қиылысында (екі дөңгелектің ортақ бөлігінде) орналасуы тиіс. Λ жиындардың қиылысу белгісі	4
472	3	Жұп сандар	жұп цифраға аяқталатын сандар	5
473	3	Жылдамдық	уақыт бірлігінде қолданылған арақашықтық. Жылдамдықты табу үшін арақашықтықты уақытқа бөлу қажет: v = S : t	4
474	3	заңдылық	белгілі бір ереже бойынша құрылған тізбек	1
475	3	келесі сан	бұл тікелей берілген саннан кейін тұратын сан	1
476	3	кері есеп (өзара кері)	есептің шартындағы белгілі шама ізделінді шамаға айналатын есеп	1
477	3	Кері пропорционал тәуелсіздік	екі шаманың біреуін бірнеше есе арттырғанда (кеміткенде) екіншісі де сонша есе кемігенде (артқанда) пайда болатын тәуелділік	6
478	3	кесінді	түзудің екі нүктесінің аралығында жататын және осы екі нүктені де қамтитын бөлігі	1
479	3	Килограмм	массаның өлшем бірлігі	1
480	3	Километр	1000 метрге тең ұзындық өлшем бірлігі. Белгіленуі: км	4
481	3	Кіші бұрыш	градустық өлшемі кем бұрыш	5
482	3	Класс	санның жазылуында оң жағынан басталатын әрбір класта үш разряд бар	4
483	3	Комбинация	цифрларды немесе заттарды әртүрлі тәсілдермен құрастыру нәтижесі	1
484	3	Конус	көлемді фигура. Конустың табаны дөңгелек	1
485	3	Координаталық жазықтық	тік бұрышты координаталар жүйесі орналасқан жазықтық	6
486	3	Координаталық немесе сандық сәуле	сандық басы, берілген бірлік кесіндісі бар және бағыты көрсетілген сәуле	5
487	3	Координаталық сәуле	сәуленің 0 басталу нүктесі санақ басы ретінде алынған, бірлік кесіндісі берілген, бағыты белгіленген сәуле	5
488	3	Координаталық түзу	санақ басы болатын О нүктесі, оң бағыты көрсетілген және бірлік кесіндісі таңдап алынған түзу	6
489	3	Коэффицент	сан мен бір немесе бірнеше айнымалылардың немесе олардың дәрежелерінің көбейтіндісіндегі сан көбейткіш	6
490	3	Коэффициент	өрнек сан мен бір немесе бірнеше әріптің көбейтіндісі болатын сан	6
491	3	Коэффициэнт	бір немесе бірнеше әріп көбейткіштері бар көбейтінді түріндегі өрнектегі сан	5
492	3	Көпбұрыш	жай тұйықталған сынық сызық, жазық фигура	5
493	3	Көпбұрыштың периметрі (Р)	бұл тұйықталған сынық сызық ұзындықтарының немесе оның барлық қабырғалары ұзындықтарының қосындысы. P = a + b + c + d + e + f	2
494	3	Куб	барлық өлшемдері тең тік бұрышты параллелепипед	5
495	3	Куб	барлық өлшемдері өзара тең тік бұрышты параллелипипед	5
496	3	Күрделі теңдеу	екі немесе одан да көп амалдардан тұратын теңдеу	4
497	3	Қалып қою қозғалысы	екінші нысанның жылдамдығы бірінші нысанның жылдамдығынан кем болған жағдайдағы нысандардың бір бағыттағы қозғалысы: v2 < v1 . Нысандар жылдамдықтарының айырмасына тең жылдамдықпен қашықтайды: vқаш. = v2 v1	4
498	3	Қарама-қарсы сандар	модульдері тең, бір-бірімен таңбалары арқылы ғана ажыратылатын сандар	6
499	3	Қашықтау жылдамдығы	уақыт бірлігі ішінде нысандардың бірбірінен алыстау қашықтығы	4
500	3	Қос теңсіздік	бір жолға жазылған екі теңсіздік. Шешімі екі жиынның қиылысуы мен бірігуі болуы мүмкін	4
501	3	қосу	«+» (плюс) таңбасымен белгіленетін математикалық амал	1
502	3	Қосудың терімділік қасиеті	егер бірнеше қосылғыштарды қосқанда екі қосылғышты олардың қосындысымен ауыстырса, онда қосындының мәні өзгермейді. (a + b) + c = a + (b + c)	4
503	3	қосылғыш	бұл бірбіріне қосылатын сандардың атауы	1
504	3	қосынды (қосындының мәні)	қосу амалының нәтижесі	1
505	3	Қуып жету қозғалысы	екінші нысанның жылдамдығы бірінші нысанның жылдамдығынан артық болған жағдайдағы нысандардың бір бағыттағы қозғалысы: v2 > v1 . Нысандар бірбіріне жылдамдықтарының айырмасына тең жылдамдықпен жақындайды: vжақ. = v2 v1	4
506	3	құны	барлық сатып алынған заттарға төленетін ақша	1
507	3	Құрама сандар	екіден көп бөлгіштері бар натурал сандар	6
508	3	Қысқартылмайтын бөлшек	алымы мен бөлімі өзара жай сандар болатын бөлшек	5
509	3	Қысқартылмайтын бөлшектер	алымы мен бөлімі өзара жай сандардан болатын бөлшектер	5
510	3	Литр	көлемнің өлшем бірлігі	1
511	3	Масса	килограммен өлшенетін шама. Заттар массасы бойынша ауыр не жеңіл болады. Мысалы, қалам кітаптан жеңіл. Кітап қаламнан ауыр	1
512	3	Масштаб	картадағы кесінді ұзындығының оған сәйкес жер бетіндегі қашықтыққа қатынасы	6
513	3	Масштаб	картада (планда, сызбада, және т.б.) берілген арақашықтың нақты арақашықтықа сәйкестігі	6
552	3	Параллель түзулер	өзара қиылыспайтын түзулер	3
514	3	Математикалық заңдылық	берілген ережеге сәйкес элементтердің сандық немесе басқа қатарларда қайталануы немесе элементтерінің өзінің немесе қасиеттерінің өзгеруі бойынша белгілі бір ереже	4
515	3	Материал	белгілі бір нәрсені жасауға пайдаланылған зат. Мысалы, қағаз жасайтын материал ағаш	1
516	3	Мәндес теңдеулер	теңдеулердің біреуінің түбірі екіншісінің түбіріне тең болатын теңдеу	6
517	3	Мәндес теңсіздіктер	шешімдері бірдей теңсіздіктер	6
518	3	Медиана	сандар қатары өсу немесе кему ретімен орналасқан жағдайда және сандар қатары тақ болғанда, қатардың ортасындағы санға тең немесе жұп болғанда сандар қатарының ортасында орналасқан екі санның арифметикалық ортасына тең сан	6
519	3	Метеоролог	табиғат құбылыстарын зерттейтін маман	3
520	3	Метеорология	Жер атмосферасы және ондағы болатын құбылыстар туралы ғылым	3
521	3	Минут	60 секундқа тең уақыттың өлшем бірлігі	1
522	3	Мода	берілгендер қатарында ең көп қайталанатын сан немесе шама	6
523	3	Модель	жұмсақ немесе қатты қағаздан, сондай-ақ басқа материалдан жасалған фигураның үлгісі	1
524	3	Модуль	координаталар басынан координатасы а-ға тең нүктеге дейін қашықтықты көрсететін сан	6
525	3	Монета	металдан жасалған ақшаның түрі	1
526	3	монета	металл ақшатаңба	1
527	3	Мың	үш таңбалы 999 санынан кейінгі сан. Жазылуы: 1 000. Он жүздіктің қосындысы бір мыңдықты береді	4
528	3	Мыңдар класы немесе екінші класс	келесі үш разрядты құрайтын класс: бірлік мың; ондық мың; жүздік мың	4
529	3	Мыңдық	жаңа санау бірлігі. Мыңдықтармен де бірліктер сияқты санайды. Мыңдықтар, он мыңдықтар және жүз мыңдықтар екінші класты немесе мыңдықтар класын құрайды	3
530	3	Натурал сандар	бұл 1ден бастап заттарды санау кезінде алынған сандар. Мысалы: 1, 2, 3, 4, 5... . 1 ең кіші натурал сан. Ең үлкен натурал сан болмайды. Санауда нөл саны қолданылмайды. Нөл саны натурал сан деп есептелмейді	4
531	3	Натурал сандар	санау үшін пайдаланылатын сандар	5
532	3	Натурал сандар жиыны	шектелмеген жиын. Бұл жиын N әрпімен белгіленеді	5
533	3	Натурал сандар қатары	бұл барлық натурал сандар тізбегі: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ... Натурал сандар қатарында әрбір сан өзінің алдындағы саннан 1ге артық	4
534	3	Нүктенің координаталары	берілген нүктенің абсциссасы (х) мен ординатасы (у)	6
535	3	О нүктесі	дөңгелектің (шеңбердің) центрі	3
536	3	Осьтік симметрия	түзу сызыққа қатысты симметрия	6
537	3	Осьтік симметриялы фигура	түзу фигураны симметриялы екі түзуге бөлгенде пайда болатын фигура	6
538	3	Өзара жай сандар	1-ге тең бір ғана ортақ бөлгіші бар натурал сандар	5
539	3	Өзара жай сандар	ең үлкен ортақ бөлгіші 1-ге тең натурал сандар	5
540	3	Өзара кері сандар	көбейтіндісі 1-ге тең болатын екі сан	5
541	3	Өнімділік	уақыт бірлігінде орындалған жұмыс. v = A : t, мұндағы, А = v · t t уақыт ішінде орындалған жұмыс	4
542	3	Өрнек	бастапқы математикалық ұғым. Әріптер мен сандардың арифметикалық амалдар таңбаларымен біріктіріліп жазылуы. Сонымен қатар жақшалар пайдаланылуы мүмкін	4
543	3	Өрнекті түрлендіру (теңбе-тең түрлендіру)	өрнекті оған теңбе-тең өрнекпен алмастыру	6
544	3	Өрнекті ықшамдау	нәтижесінде қарапайым өрнек алынатын түрлендіру	4
545	3	Өрнекті ықшамдау	өрнектің мәнін өзгертпей, бірақ амалдар саны алғашқыдан аз болатындай етіп түрлендіру	5
546	3	Өрнектің мәні	сандық өрнегі көрсетілген барлық амалдарды орындау нәтижесінде шыққан сан	5
547	3	Пайыз	санның жүзден бір бөлшегі	5
548	3	Палетка	сантиметр квадратқа бөлінген мөлдір пленка. Онымен фигураның ауданын табуға болады	3
549	3	Параллелепипедтің жақтары	олардың бетін құрайтын тіктөртбұрыштар. Параллелепипедтің 6 жағы бар, бұған қоса бір-біріне қарама-қарсы орналасқан жақтары тең болады. Параллелепипедтің 12 қыры бар	3
550	3	Параллелепипедтің төбелері	оның қырларының қиылысу нүктесі	3
551	3	Параллель кесінділер - параллель түзулер бойындағы әр нүктеде бір-бірінен тең қашықтықта орналасқан кесінділер		3
553	3	Параллель түзулер	бір жазықтықта жататын, бір-бірімен қиылыспайтын түзулер	6
554	3	Периметр	жазықтықтағы геометриялық фигуралардың барлық қабырғалары ұзындықтарының қосындысы	5
555	3	Периметр	көпбұрыштың барлық қабырғалары ұзындықтарының қосындысы	5
556	3	Период	шексіз қайталанатын цифрлар тобы, шексіз периодты ондық бөлшектің периоды деп аталады	6
557	3	Периодты ондық бөлшек	ондық таңбаларында бір цифр немесе реті өзгермейтін цифрлар тобы қайталанатын шектеусіз ондық бөлшек	6
558	3	Перпендикуляр түзулер	тік бұрыш жасап қиылысатын түзулер	4
559	3	Перпендикуляр түзулер	бір-бірімен тік бұрыш жасап қиылысатын түзулер	6
560	3	Пиктограмма	қандай да бір кескіннің шартты түрде берілген шағын үлгісі	1
561	3	пиктограмма	ақпаратты арнайы суреттердің көмегімен ұсыну; бір нәрсені шартты белгілеу бейнесі	1
562	3	Пирамида	көлемді фигура. Пирамиданың табаны көпбұрыш, ал бүйір жақтары үшбұрыштар	1
563	3	пікір	мағынасы бар ойдың ақиқаттығы немесе жалғандығы туралы айтылатын хабарлы сөйлем санды өрнек сан мен амал таңбаларының көмегімен жазылған математикалық жазу	1
564	3	Пікір	ақиқат немесе жалғандығы туралы нақты айтуға болатын сөйлем	4
565	3	Пішін	заттың сыртынан қарағандағы түрі. Мысалы, футбол алаңы тіктөртбұрыш пішінді	1
566	3	Планның масштабы	пландағы кесінді ұзындығының оның нақты (жер бетіндегі) ұзындығына қатынасы	6
567	3	Позициялық (жергілікті) ондақ санау жүйесі	өзіндік мәне мен тұрған орны бар санауда пайдаланылатын сандар	5
568	3	Пропорция	екі қатынастың тура теңдігі	6
569	3	Пропорция	екі немесе бірнеше қатынастың (бөліндінің) тура теңдігі	6
570	3	Радиус (r)	шеңбердің центрін оның бойында жатқан кез келген нүктемен қосатын кесінді	3
571	3	Разряд	бұл сандарды жазудағы цифрдың орны	3
572	3	Разрядтық қосылғыштардың қосындысы	кез келген санның 123 = 100 + 20 + 3 түріндегі жазылуы санды разрядтық қосылғыштарға жіктеу немесе разрядтық қосылғыштардың қосындысы деп аталады	4
573	3	Рационал сандар	бүтін сандар, оң және теріс бөлшектер жиыны	6
574	3	ребус	ізделінді фигуралар, әріптер немесе таңбалар арқылы бейнеленген жұмбақ	1
575	3	Рубль	Ресей Федерациясының қазіргі валютасының атауы	4
576	3	салыстыру	заттардың саны немесе сапасы бойынша ұқсастығы мен айырмашылығын анықтау	1
577	3	Сан	бұл санау бірлігі. Сандардың көмегімен заттардың санын санауға және әртүрлі шамаларды (ұзындығы, ені, биіктігі және т.б.) анықтауға болады. Саңдарды жазу үшін арнайы таңбалар цифрлар пайдаланылады	4
578	3	Сан	бұл санау бірлігі. Сандардың көмегімен заттардың санын санауға және әртүрлі шамаларды (ұзындығы, ені, биіктігі және т.б.) анықтауға болады. Сандарды жазу үшін арнайы таңбалар цифрлар пайдаланылады	4
579	3	Сан аралықтарының бірігуі	А және В сан аралықтарының кем дегенде біреуіне тиісті сандар жиыны	6
580	3	Сан аралықтарының қиысуы	А және В сан аралықтарының ортақ бөлігін құрайтын сандар жиыны	6
581	3	Сан сәулеcі	натурал сандар нүктелермен бейнеленген сәуле. Нүктелердің арасындағы қашықтық шартты түрде берілген өлшем бірлікке (бірлік кесіндіге) тең. Әрбір нүктеге 1 санынан бастап сәйкес сан қойылады. Сәуленің басына сәйкесінше 0 қойылады. Сан сәулесі натурал сандарды салыстыруға мүмкіндік береді	4
582	3	санау	қандай да бір заттың санын немесе ретін анықтау	1
583	3	Сандар қатынасы	екі санның бөліндісі	6
584	3	Сандар меридианасы	берілген тақ сандардың дәл ортасындағы сан	6
585	3	Сандар модасы	берілген сандар арасындағы жиілігі ең көп сан	6
586	3	Санды дөңгелектеу	оның дәл мәніне жақын жуық мәнін табу	5
587	3	санды өрнектің мәні	барлық амалдарды орындағаннан кейін алынатын сан	1
588	3	Санды теңдік	өзара тең екі санды өрнектің теңдік «=» белгісі арқылы жазылуы	6
589	3	Санды теңсіздік	екі санды өрнектің теңсіздік (“>” немесе “<”) белгісімен жазылуы	6
715	5	Калория	жылу мөлшерін есептейтін бірлік	8
590	3	Санның арифметикалық ортасы	берілген сандардың қосындысын қосылғыштар санына бөлгенде шығатын бөліндісі	6
591	3	Санның квадраты	сол санның 2-ші дәрежесі	5
592	3	Санның кубы	сол санның 3-ші дәрежесі	5
593	3	санның құрамы	бұл қосындысы осы санды беретін қосылғыштар	1
594	3	Санның модулі	координаталық түзудегі координатасы сол санға тең нүктенің санақ басынан бірлік кесінді есебімен қашықтығы	6
595	3	Санның пайызы	бүтінге, бірлікке қабылданатын санның 1 100 үлесі. (%) таңбасымен белгіленеді. Санның пайызын есептеу үшін санды 100ге бөлу және бір бөлігін алу қажет	4
596	3	Санның разряды	санның жазылуында цифр тұратын орын	4
597	3	Санның үлесі	бүтіннің бөлігі. Үлестің жартысы, ширегі	4
598	3	сантиметр	ұзындықтың өлшем бірлігі (шама)	1
599	3	сантиметр квадрат (1см2)	ауданның өлшем бірлігі	3
600	3	сәуле	түзудің бір нүктесінен басталып, осы нүктенің бір жағында жататын және осы нүктені де қамтитын бөлігі	1
601	3	Секунд	минуттың 1 60 бөлігіне тең болатын уақыт бірлігі. Белгіленуі: с	4
602	3	Секунд	минуттың 1/60 бөлігіне тең болатын уақы бірлігі. Белгіленуі: с	4
603	3	Симметрия	фигура бөліктерінен, нүктеден немесе түзуден қарама-қарсы қабырғалары бойынша заттардың бірдей орналасуы	4
604	3	Симметрия осі	заттарды тең бөліктерге бөлетін сызық	4
605	3	симметрия осі - фигураны тең бөліктерге бөлетін түзу		3
606	3	Симметрия центрі	О нүктесі	6
607	3	Симметриялы - егер түзу сызық фигураны тең екі бөлікке бөлсе, бұл фигура түзуге қатысты симметриялы деп аталады.		3
608	3	Сүйір бұрыш	градустық өлшемі 90° -тан кем бұрыш	5
609	3	Сүйірбұрышты үшбұрыш	барлық бұрыштары сүйір болатын үшбұрыш	4
610	3	сынық сызықтың ұзындығы дегеніміз	оның барлық кесінділерінің ұзындығының қосындысы. Тұйықталған сынық сызық өзімен-өзі қиылыспай көпбұрыш құрайды	2
611	3	Таза периодты ондық бөлшек	периодты ондық бөлшектің пертоды үтірден кейін басталатын бөлшек	6
612	3	Тақ сандар	тақ цифраға аяқталатын сандар	5
613	3	Текше	барлық жақтары шаршы болып келетін көлемді фигура (дене), барлық өлшемдері тең тікбұрышты параллелепипед. Текшенің жақтары бір-біріне тең 6 шаршыдан тұрады	3
614	3	Текшенің қыры	шаршылардың қабырғалары. Текшенің 6 жағы, 12 қыры, 8 төбесі болады	3
615	3	Текшенің төбесі	шаршылардың төбесі	3
616	3	Тең бұрыштар	бір-бірімен беттесетін екі бұрыш	5
617	3	Тең жиындар	элементтер құрамы бірдей екі жиын	5
618	3	Тең құралған фигуралар	шаршының қиылған бөліктерінен шыққан фигуралар	5
619	3	Тең шамалас фигуралар	аудандары тең фигуралар	5
620	3	Теңбе-теңдік	айнымалылардың қабылдайтын мәндерінің кез келгенінде тура келетін теңдік	6
621	3	теңдеу	белгісізі бар теңдік	1
622	3	Теңдеу	құрамында әріппен белгіленген белгісіз саны бар теңдік	5
623	3	Теңдеуді шешу	оның барлық түрлерін табу немесе оның бірде-бір түбірі болмайтынына көз жеткізу	5
624	3	Теңдеуді шешу	теңдеудің барлық түбірлерін табу немесе түбірлері жоқ екенін көрсету	5
625	3	Теңдеудің графигі	координаталық жазықтықтағы координаталары екі айнымалысы бар сызықтық теңдеудің шешімдері болатын нүктелер жиыны	6
626	3	Теңдеудің түбірі	әріптік теңдеуді тура санды теңдікке айналдыратын мәні	5
627	3	Теңдеудің шешімі немесе түбірі	теңдеудегі әріптің орнына қойғанда оны дұрыс теңдікке айналдыратын сан	5
628	3	теңдік	арасына теңдік белгісі қойылған екі өрнектен құралған математикалық жазу	1
629	3	теңсіздік	екі санды «артық» немесе «кем» таңбалары бойынша байланыстыратын қатынас	1
630	3	тізбек	заттардың белгілі бір ретпен орналасуы	1
631	3	Тізбек	ерекше ереже бойынша тұжырымдалған сандар немесе фигуралар қатары. Егер бұл ереже берілмесе, онда оны тізбектің бірінші элементтері бойынша шығаруға болады	4
632	3	Тік бұрыш	градустық өлшемі 90° -қа тең бұрыш	5
5191	8	Тікелей реакция	өнімдердің түзілуіне бағытталған реакция.	9
633	3	Тік бұрышты координаталар жүйесі	санақ басы О нүктесінде қиылысатын өзара перпендикуляр, бірлік кесінділері бірдей екі координаталық түзу	6
634	3	Тікбұрышты параллелепипед	тіктөртбұрыш пішінді алты жағы бар кеңістіктік фигура. Тікбұрышты параллепипедтің ортақ ұшы бар үш қабырғасын оның өлшемі деп атайды. Тікбұрышты параллелепипедтің көлемін табуға арналған формула: V = a · b · c	4
635	3	Тікбұрышты үшбұрыш	бір бұрышы тік болатын үшбұрыш	4
636	3	Тіктөртбұрыш	бұл барлық бұрыштары тік болатын төртбұрыш	2
637	3	Тіктөртбұрыш	қарамақарсы қабырғалары бірбіріне параллель және тең, ал барлық бұрыштары тік болатын төртбұрыш	4
638	3	Толық бұрыш	дөңгелектің центрі болатын 0 нүктесін қоршаған бұрыштың градустық өлшемі екі жазыңқы бұрыштың градустық өлшеміне тең болатын бұрыш	5
639	3	Толықтауыш көбейткіш	бөлшекті жаңа бөлімге келтіру үшін оның алымын да, бөлімін де көбейтетін сан	5
640	3	Тонна	10 ц немесе 1000 кг-ға тең болатын массаның өлшем бірлігі. Белгіленуі: т	4
641	3	Транспортир	бұрыштарды тұрғызуға және өлшеуге арналған құрал. Бұрыштың шамасын градуспен өлшейді	4
642	3	Тура пропорционал тәуелсіздік	екі шаманың біреуін бірнеше есе арттырғанда (кеміткенде) екіншісі де сонша есе артқанда (кемігенде) пайда болатын тәуелділік	6
643	3	Тура пропорционал шамалар	екі шаманың біріншісін арттырғанда екінішісі де сонша есе артатын шамалар	6
644	3	Түсімділік	тоннамен, центнермен, килограммен аудан бірлігінен (ар, гектар, т.б.) жиналған өсімдіктер түсімінің массасы	4
645	3	Тұрақты сан	кері пропорционал шамалардың сәйкес мәндерінің көбейтіндісі	6
646	3	Үлес	бүтіннің бірнеше тең бөліктерінің әрқайсысы	5
647	3	Үлкен бұрыш	градустық өлшемі артық бұрыш	5
648	3	Үшбұрыш	үш төбеден және қабырғадан тұратын көпбұрыш	4
649	3	Фигура	заттың сыртқы пішіні, түрі. Мысалы, текше көлемді фигура, ал шаршы жазық фигура	1
650	3	Фигураның көлемі	үш өлшемді фигура қамтитын кеңістік шамасы	4
651	3	Формулалар	шамалар арасында өзара байланыс орнататын тура әріптік теңдіктер. Қалдықпен бөлуді тексеру формуласы: а = b · c + r, r < b. а бөлінгіш, b бөлгіш, с бөліндінің мәні, r қалдық	4
652	3	Центрлік симметрия	нүктеге қатысты симметрия	6
653	3	Центрлік симметриялы фигура	О нүктесі және оған қатысты симметриялы нүктелер өзінде, өз бойында жататын фигура	6
654	3	Цилиндр	көлемді фигура. Цилиндрдің табандары бірдей екі дөңгелек, ал бүйір беті тіктөртбұрыш болып келеді	1
655	3	Цифр	сандарды жазуға арналған таңбалар. Мысалы, 10 саны 1 және 0 цифрларының көмегімен жазылады	1
656	3	Шаршы	бұл барлық қабырғалары тең болатын тіктөрбұрыш	2
657	3	Шеңбер	дөңгелектің шегарасы	3
658	3	Шеңбер	барлық нүктелері шеңбердің центрі деп аталатын нүктеден бірдей қашықтықта жататын тұйық сызық	4
659	3	Шеңбер	барлық нүктелері бір жазықта және центрден (0 нүктесінен) бірдей қашықтықта жататын фигура	5
660	3	Шеңбердің диаметрі	шеңбердің екі нүктесін біріктіретін және центр арқылы өтетін кесінді. Белгіленуі: d	4
661	3	Шеңбердің доғасы	шеңбердің бойында жатқан екі нүкте арасындағы бөлігі	5
662	3	Шеңбердің радиусы	шеңбердің центрін оның қандай да бір нүктесімен қосатын кесінді. Белгіленуі: r	4
663	3	Эйлер	Венн диаграммасы ақпараттың дөңгелектер арқылы графикалық түрде берілуі	4
664	3	Элемент	жиынның құрамына кіретін бөлік	1
665	4	Абсалюттік қателік	дәл мән мен жуық мән айырмасының абсалют шамасы	7
666	4	Алгебра	математиканың түрлі өрнектерге амал қолданудың ортақ қасиеттерін оқытатын саласы	7
667	4	Алгебралық өрнектер	бүтін және бөлшек өрнектер	7
668	4	Бірмүшенің дәрежесі	бірмүше құрамындағы айнымалылардың дәреже көрсеткіштерінің қосындысы	7
669	4	Бірмүшенің коэфициенті	сан көбейткіш	7
670	4	Бірмүшенің стандарт түр	сан көбейткішке жалғастыра айнымалылар мен дәрежелері жазылған түрі	7
3560	7	Такт	қарапайым амалды орындауға қажетті уақыт аралығы.	8
671	4	Бүтін өрнек	қосу, азайту,көбейту және дәрежеге шығару амалдарының көмегімен сандар мен айнымалылардан құралған өрнек	7
672	4	Бөлшек өрнектер	бөлімінде де айнымалылар бар бөлшектер	7
673	4	Екі айнымалысы бар сызықтық теңдеу	ax+by=c түріндегі теңдеу	7
674	4	Көпмүше	бірмүшелердің қосындысы	7
675	4	Көпмүшенің дәрежесі	көпмүшенің құрамындағы бірмүше дәрежелерінің ең үлкені	7
676	4	Математикалық модель	теңсіздік, теңдеулер және олардың жүйесі	7
677	4	Мәндер облысы	y=f(x) функциясының барлық қабылдайтын мәндер жиыны	7
678	4	Нұсқалық	ығыспалы қатарда кездесетін әрбір мән	7
679	4	Салыстырмалы жиілік	нұсқалықтың абсалюттік жиілігін таңдама көлеміне бөлгенде шығатын сан	7
680	4	Салыстырмалы қателік	абсалюттік қателіктің жуық мән модуліне қатынасы	7
681	4	Сан тізбегі	шексіз жалғасып жазылатын сандар жиыны	7
682	4	Статистика	белгілі бір ортақ қасиеттермен сипатталатын мәліметтерді, деректі жинақтау және оның нәтижелерімен айналысатын ғылым	7
683	4	Тепе-теңдік	құрамындағы барлық айнымалылардың мүмкін мәндері жиынында ақиқат болатын теңдік	7
684	4	Теңбе-тең түрлендіру	өрнекті оған теңбе-тең өрнекпен алмастыру	7
6206	14	Автопортрет	суретшінің өзін бейнелеген туындысы	2
6207	14	Акварель бояулары	суда еритін мөлдір бояулар	2
6208	14	Анималист	жануарларды бейнелейтін суретші	2
6209	14	Аппликация	қағаз бетіне әртүрлі пішіндерді жапсыру	2
6210	14	Аппликация	қағаз бетіне әртүрлі пішіндерді жапсыру	2
6211	14	Бір бейнелі композиция	бір бейнеден тұратын композиция. Бір адамның портреті де бір бейнелі композиция деп саналады	2
6212	14	Баспа-таңба	қағаз парағына бояуы бар пішінді басу арқылы жасалған бейне	2
6213	14	График-суретші	графика туындыларын жасайтын суретші	2
6214	14	Графика	басты әсерлегіш құралдары сызық, пішін, ақ және қара түстері болатын бейнелеу өнерінің түрі	2
6215	14	Гуашь	суда еритін, қоймалжың бояулар және осы бояулармен орындалған туындылар	2
6216	14	Дизайн	заттарды әдемі әрі ыңғайлы етіп құрастырып, көркемдеу	2
6217	14	Жылы түстер	қызыл, қызғылт сары, сары түстер. Бұл түстер жылуды еске салады	2
6218	14	Зімпара қағазы	бұйымның бетін тегістеп, тазалауға арналған материал	2
6219	14	Кескіндеме	бояумен салынатын бейнелеу өнерінің түрі	2
6220	14	Кескіндемеші	суретші кескіндеме туындыларын жасайтын суретші	2
6221	14	Коллаж	қағаз бетіне түсі мен фактурасы өзгеше табиғи жөне жасанды материалдарды жабыстыру	2
6222	14	Композиция	суретті қағаз бетіне ойлаған тақырыпқа сай әсерлі етіп орналастыру. Әдетте тұтас туындыны «композиция» деп атайды	2
6223	14	Көлемді бейне	жан-жағынан қарауға болатын бейне	2
6224	14	Көп бейнелі композиция	екі немесе онан да көп бейнелерден тұратын композиция	2
705	5	Ампер	электр ток күшінің СИ жүйесіндегі өлшем бірлігі	8
706	5	Амперметр	электр тоғының күшін өлшеуге арналған құрал	8
707	5	Атом	химиялық элементтің қасиеттерін бойына сақтаған оның ең кіші бөлшегі	8
708	5	Ватт	қуат бірліктерінің халықаралық жүйесіндегі (СИ) әмбебап өлшем бірлігі	8
709	5	Вольт	электр тоғының кернеуін, потенциалдар айырмасын анықтайтын халықаралық өлшем	8
710	5	Газ	заттың атомдары мен молекулалары бір-бірімен әлсіз байланысы болған заттың күйі	8
711	5	Генератор	механикалық энергияны электр энергиясына айналдыратын құрал	8
712	5	Джоуль	энергияның өлшем бірлігі	8
713	5	Диффузия	бір заттың молекулаларының екінші заттың молекулааралық бос орындарына өзара өтуі	8
714	5	Калориметр	әр түрлі процестер кезінде денелерден бөлінетін немесе олардың қабылдайтын жылу мөлшерін өлшейтін аспап	8
6225	14	Көрініс	картинадағы заттардың лдыңғы және артқы қатарға орналасуы	2
6226	14	Матрица	таңба жасауға арналған пішін	2
6227	14	Мимика	адам бет әлпетінің өзгеруі	2
716	5	КилоВатт х сағ	электр энергиясының (жұмыстың) есебін анықтауға арналған өлшем бірлігі	8
717	5	Компас	жер бетін бағдарлауға, географиялық немесе магниттік меридианның бағытын анықтауға арналған аспап	8
718	5	Конвекция	сұйық немесе газ бөлшектерінің температурасындағы айырмашылықтар әсерінен туындайтын, сол бөлшектердің жоғары-төмен қозғалуымен сипатталатын ағым	8
719	5	Конденсатор	жұқа диэлектрик қабатымен бөлінген екі өткізгіштен тұратын жүйе	8
720	5	Конденсация	газдың немесе будың сұйық түрге айналуы	8
721	5	Коррозия	химиялық үрдіс зардабынан металдардың мұжылуы	8
722	5	Кулон	бірліктердің халықаралық жүйесіндегі электр мөлшерінің бірлігі	8
723	5	Магнит	магниттелушілік қасиеті бар, яғни магнит өрісін туғызатын дене	8
724	5	Молекула	заттың химиялық қасиеттерін бойына сақтаған оның ең кіші бөлшегі	8
725	6	абсолютті орналасу\n	Атап айтқанда орналасқан жері сияқты тор сілтеме арқылы көрсетуге болатын жер бетіндегі нүктенің ендік және бойлық	9
726	6	қол жетімділік	Басқа жерлердегілердің күшімен жетуге мүмкіндік беретін орналасу сипаттамасы	9
727	6	қол жетімділік ресурсы\n	Аймақтар арасындағы байланысты жеңілдететін табиғи түрде пайда болған ландшафт формасы	9
728	6	белсенді жанартау	A жанартау қазіргі уақытта атылып жатқан немесе соңғы 10 000 жыл ішінде атқылаған ( Голоцен) немесе жазылған тарих кезінде	9
729	6	ауылшаруашылық географиясы	Адамдар мен арасындағы кеңістіктік қатынастарды зерттейтін география пәні ауыл шаруашылығы және мәдени, саяси және қоршаған орта процестері, бұл Жер бетінің бөліктерін адамдар арқылы өзгертеді бастапқы сектор ауылшаруашылық ландшафттарындағы іс-шаралар	9
730	6	аллювиалды желдеткіш	Сумен тасымалданатын шөгінділердің ерекше үшбұрышты, желдеткіш тәрізді шөгінділері, көбінесе деп аталады аллювий. Аллювиалды желдеткіштер негізінен негізінен пайда болады таулар, мұнда жоғары жылдамдықты өзендер немесе ағындар салыстырмалы түрде тегіс ауданды қанағаттандырады және үлкен мөлшерде шөгінділерді тасымалдау үшін қажетті энергияны жоғалтады, бұл ақыр соңында барлық қол жетімді бағыттарға таралады. Олар құрғақ аймақтарда көбірек және айқынырақ болады.	9
731	6	аллювиалды жазық	Кең, тегіс, ақырын көлбеу жазық ұзақ мерзімді тұндыру арқылы жасалған аллювий бір немесе бірнеше өзендер ағып жатыр таулы аймақтар, және әдетте әртүрлі сипатталады флювиальды сияқты жер бедерінің формалары өрілген ағындар, террасалар, және meanders. Аллювиальды жазықтар өзендер өтетін үлкен аумақты қамтиды жайылма геологиялық уақыт арқылы ауысқан	9
732	6	аллювиалды топырақ	Қозғалыстағы судың әсерінен жиналған топырақ. Бұл топырақтар жетіспейді көкжиектер және әдетте өте құнарлы	9
733	6	антропизация	Ашық кеңістікті, ландшафттарды және табиғи ортаны адамның әрекеті арқылы өзгерту	9
5706	11	Ертегі	ерте замандардан бері ауыздан-ауызға тарап, бүгінгі күнге жетіп отырған ауыз әдебиетінің бір түрі	5
5707	11	Қиял-ғажайып ертегілер	ертедегі адамдар табиғат және оның құбылыстары  туралы, адам еңбегі, тіршілік көзі, кәсібі, дүниеге көз-қарасы, жаратылыс туралы неше түрлі керемет қиял-ғажайып ертегілер тудырған	5
5708	11	Хайуанаттар жайлы ертегілер	қазақ халқы ерте заманнан бері мал шаруашылығымен, аңшылықпен айналысып келе жатқандықтан, хайуанаттар жайлы әр алуан оқиғаларды ойлап тапқан	5
5709	11	Шыншыл ертегілер	қазақ ертегілерінің ең көп тараған түрі. Өмір шындығына жақындау болыа келеді	5
5710	11	Эпос	халық ауыз әдебиетінің бір саласы. Эпостың басты ерекшелігі  - өмір құбылыстарын кең көлемде қамтып, кейіпкер образын, күрделі оқиғаларды мейілінше мол беру арқылы суреттеу	5
5711	11	Батырлар жыры	ауыз әдебитіндегі ең бай да көне мұралардың бірі. Батырлар жыры халық өмірінің тұтас бір дәуірін жан-жақты қамти отырып, сол кезеңдегң батырлардың сыртқы жауларға қарсы ерліктерін бейнелеп береді.	5
5712	11	Риторикалық сқрақ	ойды, сезімді әсерлі жеткізу үшін жауабы өзінен-өзі айқын нәрсені әсерлі леппен, сұрау түрінде айту	5
6228	14	Мозаика	тас, шыны, қыш, ағаш сияқты әртүрлі материалдан жасалған бейне	2
5713	11	Қайталау	сөз әсерін күшейте отырып оқырман назарын айрықша аударғысы келген нәрсені не құбылысты бірнеше мәрте қайталап, айтар ойды, ұқтырар сырды ұғымға мұқият сіңіре түсу	5
5714	11	Эпифора (кезекті қайталау)	өлең тармақтарының соңында бір сөз тіркесінің қайталанып келуі	5
5715	11	Әңгіме	оқиғаны қарасөзбен баяндайтын шағын көркем шығарма жанры	5
5716	11	Композиция	көркем шығарманың құрылысы. Ол оқиғаның басталуы, байланысуы, шиеленісуі, шарықтау шегі мен шешімінен тұрады	5
5717	11	Өлең	ырғағы мен ұйқасы, шумағы мен бунағы белгілі бір тәртіпке бағынатын шағын көлемді поэзиялық шығарма	5
5718	11	Мысал	айтылатын өнегелі ойды тұспалдап жеткізетін, көбіне өлең түрінде келетін сюжеті шағын көркем шығарма. 	5
5719	11	Аллегория	оқырманның санасына, қиялына ерекше әсер ететіндей образ жасаудың бейнелеуші құралы, көркемдік тәсіл	5
5720	11	Эпитет	заттың яки құбылыстың ерекшелігін, сыр-сипатын бейнелі түрде танытатын айқындаушы сөз	5
5721	11	Портрет	әдеби кейіпкердің сырт көрінісін, кескін-кейпін, бой тұлғасын суреттеу	5
5722	11	Шығарманың кейіпкері	көркем шығармада суреттелетін оқиғаға қатысушы адам, әдеби образ. 	5
5723	11	Әдеби образ 	шығармадағы көркем бейне	5
5724	11	Шығарманың қаһарманы	көркем шығармада жан-жақты толық суреттелетін, негізгі тұлға басты кейіпкер болады	5
5725	11	Әдеби жанрлар	ауызша және жазбаша жазылған көркем шығармалардың түрі	5
5726	11	Шығарманың тақырыбы	көркем шығармаға енгіз, арқау болған өмір құбылыстарының түйіні	5
5727	11	Шығарманың идеясы	шығарманы жазған автордың айтайын деген негізгі ойы	5
5728	11	Шығарманың мазмұны	шығарманың шындыққа негізделген тақырыбы мен идеясы	5
5729	11	Шығарманың пішіні	әдеби қаһармандардың өзара қарым-қатынасына, өміріне, тағдыр тартысына негізделген сюжеті, көркем шығарманың тілі	5
5730	11	Шығарманың түрі	шығарманың жанрына қарай анықталуы	5
5731	11	Шығармадағы тартыс	өмірдегі қайшылықтардың шығармада берілуі	5
5732	11	Шығарманың сюжеті	шығармада баяндалатын оқиғалар тізбегі	5
5733	11	Шығарманың фабуласы	шығармадағы тұтас оқиғалар мазмұнын қысқаша баяндау	5
5734	11	Шығарманың композициясы	шығарманың құрылысы	5
5735	11	Шығарма сюжетіндегі композицияның өрбу кезеңдері	шығармада баяндалатын оқиғалар тізбегінің рет-ретімен орналасу ерекшелігі	5
5736	11	Эпос	көркем әдебиетте өмірді суреттеу тәсілі оқиғаны баяндап жеткізуге негізделетін шығармалар тобы	5
5737	11	Лирика	лирикалық шығармада жеке адамның көңіл күйі, сезімі суреттеледі	5
5738	11	Драма	сахнаға арналған оқиғаны, оған қатысушы кейіпкерлердің іс-әрекетін, көңіл күйін көрсету арқылы баяндайтын әдеби шығармалар	5
5739	11	Троп	сөздердің тура мағынада емес, ауыспалы түрде қолданылу тәсілі	5
5740	11	Теңеу	Екі затты не құбылысты салыстыра отырып, әдеби көркем түрде айту	5
5741	11	Эпитет	заттың немесе құбылыстың елестету үшін бейнелі түрде айтылуы	5
5742	11	Гипербола	затты, құбылысты ерекше ұлғайтып айту	5
5743	11	Литота	затты немесе құбылысты ерекше кішірейтіп айту	5
5744	11	Метафора	Бір зат пен екінші затты ұқсастығына байланысты ауыстырып айту	5
5745	11	Ауыспалы мағынадағы сөздер	сөздің мағыналарын ауыстырып, басқа мағынада қолдану	5
5746	11	Портрет	кейіпкердің бет әлпетін, жүріс-тұрысын суреттеу	5
5747	11	Типтік бейне	көркем шығармада адам өмірі, басқа адамдармен қарым-қатынасы, наным-сенімдері, ойы мен сезімдері, мінез-құлықтары суреттеледі.	5
5748	11	Прототип	шығармадағы кейіпкердің бейнесін жасауға тірек, негіз болатын, өмірде болған адам, яғни өмірде бар бастапқы, түпкі тұлға	5
5749	11	Аңыз	халық ауыз әдебиетінің жанры. Оқиғасы шындық өмірден алынады. Аңыз әңгімелер тарихта болған белгілі бір адамдардың атымен, іс-әрекетімен байланысты туады	5
5750	11	Аңыз	Аңыз-әңгімелер тарихта болған белгілі бір адамдардың атына, іс-әрекетіне байланысты айтылады. Ооқиға желісі күнделікті өмірде кездесетін қарапайым сюжетке құрылады	5
5751	11	Әпсана	халықтың наным-сенімінен, арман-қиялынан туады. Белгілі бір тарихи оқиға, атақты тұлға, я болмаса топоним жайында көркемдей баяндайтын әңгімелер	5
5752	11	Миф	көне аңыз, әңгіме. Ежелгі мифтер алғашқы адамдар тіршілігінің маңызды бөлігі болды, олардың мазмұны арқылы адам қоршаған ортаны игеріп, жете түсінеді	5
5753	11	Толғау	өмір туралы, қоғам, адам тіршілігі, жақсылық, жамандық, т.б. тақырыптарда ақыл-өсиет, насихаттық тұрғыда ой қозғайтын әдеби жанр. Толғаудың негізі - дидактикалық сарын. Толғау ауызша дамып, біздің заманымызға ауызша жетті	5
5754	11	Әңгіме	эпос жанрының шағын түрі. Әңгіменің жанрлық ерекшеліктері оқиғаны баяндау тәсілі, композициялық, сюжеттік құрылысы, көркемдік жүйесі арқылы айқындалады. 	5
5755	11	Мысал	шағын көлемді, оқиғалы, адамға сабақ боларлық тәрбиелік, тағылымдық мәні бар шығарма.	5
5756	11	Хикаят (повесть)	романнан кіші, әңгімеден үлкен шығарма. Ол баяндау түрінде қарасөзбен жазылады. Бұл - эпикалық проза жанрының бір түрі.	5
5757	11	Диалог	әдеби шығармада екі кейіпкердің немесе бірнеше адамның сөйлесуі	5
5758	11	Романтикалық образ	өмірдегі болған немесе бар деректен гөрі өмірде әзірше жоқ, бірақ болатын дерекке негізделеді	5
5759	11	Реалистік образ	атынан белгілі, шындыққа негізделген кейіпкерлер	5
5760	11	Мінездеу	жазушы шығарма кейіпкерінің сыртқы портретімен қатар ішкі мінез-құлқын, көңіл күйін, ой сырын, дүниеге көзқарасын суреттейді	5
6229	14	Монотипия	шыны немесе қатырма қағаздың бетіне салынатын түсті дақтардың таңбалары	2
6230	14	Натура	суретші қарап отырып салатын шынайы заттар	2
6231	14	Натюрморт	жансыз, қозғалмайтын заттар бейнеленген қылқалам туындысы	2
6232	14	Негізгі түстер	қызыл, сары, көк түстер. Осы түстерді араластыру арқылы құрама түстер алынады	2
6233	14	Оригами	қағазды бүктеу арқылы құрамақ жасау өнері	2
6234	14	Отбасылық портрет	отбасы мүшелері бейнеленген портрет	2
6235	14	Ою-өрнек	бұйымның бетіне түсірілген нақыш	2
6236	14	Пішім	сурет салынатын парақ өлшемі	2
6237	14	Пішін	суретшінің басты әсерлегіш құралдарының бірі. Заттың сыртқы кескіні	2
6238	14	Палитра	бояу араластыратын тақтайша	2
6239	14	Папье-маше	қағаз массасынан жасалған қатты нығыз бұйым	2
6240	14	Паспарту	суретті безендіруге арналған қағаз не қатырма қағаздан жасалған жақтау	2
6241	14	Пастель	түрлі түсті борлар. Ол құрғақ жөне майлы болады	2
6242	14	Пейзаж	бейнелеу өнерінің табиғатты бейнелейтін жанры	2
6243	14	Портрет	адамдарды бейнелеу өнері	2
6244	14	Реңк	бір түстің құбылған түрлері. Бір түстің бірнеше реңкі болады	2
6245	14	Суық түстер	көк, көгілдір түстер. Бұл түстер суықты еске салады. Жасыл және күлгін түс те суықты еске салады	2
6246	14	Сызық	суретшінің басты әсерлегіш құралдарының бірі. Сызық нүктеден басталады. Суретшілер суреттерінде әртүрлі сызықтарды қолданады	2
6247	14	Сұлба	заттың дақ тәрізді кескіні. Әдетте қара түсті болады	2
6248	14	Сәндік-қолданбалы өнер	тұрмысқа қажетті бұйымдарды жасау және әшекейлеу өнері	2
6249	14	Сәндеу	әртүрлі заттарды ою-өрнектермен әшекейлеу	2
6250	14	Топтық портрет	екі не бірнеше адам бейнеленген портрет	2
6251	14	Түс	суретшінің басты әсерлегіш құралдарының бірі. Суретші бояуларды араластыру арқылы алуан түрлі түстерді алады	2
6252	14	Түс үйлесімі	бірнеше түстің өзара сәйкес келуі	2
6253	14	Фактура	материалдың сыртқы қабаты	2
6254	14	Фактура	материалдың сыртқы қабаты	2
6255	14	Құрама түстер	қызғылт сары, жасыл, күлгін және басқалар.Бұл түстер негізгі түстерді араластыру арқылы алынады	2
6256	14	Акварель бояулары	суда еритін мөлдір бояулар	3
6257	14	Анфас портрет (қасбет)	адамды тура қаратын бейнелеу	3
6258	14	Аттракцион	ойын-сауыққа арналған құрылғы	3
6259	14	Бір бейнелі композиция	бір бейнеден тұратын композиция. Бір адамның портреті де бір бейнелі композиция деп саналады	3
6335	14	Анимация	кино өнерінің түрі, өнімі (мультфильм), технологиясы	6
5761	12	Тәртіп	орындалуы міндетті, барлығымызға ортақ ереже	1
5762	12	Парыз	төлемді, өтемді талап етпейтін, бірақ әркімнің адамгершілік қасиеттеріне байланысты өзі біліп атқаратын қасиетті борышы	1
5763	12	Ар-ұждан	адамдықтың белгісі	1
5764	12	Достық	сүйіспеншіліктен туындайды	1
5765	12	Дос болу	адамдардың бір-біріне шынайы тілектестігі, риясыз сүйіспеншілігі	1
5766	12	Жақсылық жасау	адамдарға, айнала қоршаған ортаға, табиғатқа деген қайырымдылық пен қамқорлық	1
5767	12	Жер	адамдар тіршілік ететін ғажап мекен. Жер - адам үшін жайлы қоныс, алтын бесік	1
5768	12	Отбасы	бұл ұлттың, елдің, әлемнің негізі	2
5769	12	Адалдық 	адам бойындағы таза ниет, ар-ұятқа сәйкес келетін әрекеттер, борышына жауапкершілікпен қарау	2
5770	12	Ақкөңілділік	жақсы қасиеттердің бірі. Аққөңіл адам өзгенің жетістігіне, өзінікіндей қуанады	2
5771	12	Кешірімді болу	айналаңа деген мейірімді болудың, ақылдың, өзара түсінісудің көрінісі	2
5772	12	Сүйіспеншілік	риясыз қызмет ету	2
5773	12	Адам	табиғаттың бір бөлшегі	2
5774	12	Кітап	алтын қазына, онда даналықтың асыл маржандары жинақталған	3
5775	12	Отбасы	тәлім-тәрбие мектебі	3
5776	12	Туған үйі	адамның өзін емін-еркін, ашық-жарқын, бақытты сезінетін ортасы	3
5777	12	Кеңпейілділік	ниеті түзулік, мінезі ашықтық, жүрегі жұмсақтық	3
5778	12	Жомарттық	көңіл байлығы. Жомарт болу үшін міндетті түрде бай, дәулетті болу қажет емес. 	3
5779	12	Жомарт адам	қолындағы барымен бөлісуге даяр, көңілі мөлдірдей таза адам	3
5780	12	Отан	адам үшін тек туылған жерімен ғана құнды емес, сонымен қатар орманымен, нуымен, суымен, топырағымен, ата-анасы, шаңырағы, тілімен құнды	3
5781	12	Отан	адамның туып-өскен жері, атамекені, ел-жұрты, табиғат байлықтары, халқы, қоғамдық және мемлекеттік құрылысы, тіл, мәдениет, тұрмыс-салт, әдет-ғұрып ерекшеліктері бар белгілі бір халықтың тарихи тұрағына айналған аумақ	3
5782	12	Өзіңді өзің тану	өзіңді өзің сезіну, түсіну, ұғыну	3
5783	12	Даналық	адамзат баласының сан ғасырлар бойы жинаған рухани байлығы	4
5784	12	Даналық	адамның ақыл-ойының, білімінің, тәжірибесінің жемісі	4
5785	12	Нақыл сөздер	дана, ойшыл, ғұлама адамдардың ұлағатты ой-пікірлері	4
5786	12	Аадм болу	бұл өзіңнің адамгершілік қасиеттеріңді іс жүзінде көрсете білу	4
5787	12	Адам болу	жағымды ойлау, бәрін жақсы көру, мінезіңді жақсарту, жақсылық жасау 	4
5788	12	Адалдық 	адамгершіліктің аса маңызды қасиеті. ол шыншылдық, әділдік, беріктік, сенімділік сияқты қасиеттерді қамтиды	4
5789	12	Кішіпейілділік	кісілік белгісі	4
5790	12	Кішіпейіл адам	барлық адамға құрметпен қарайды	4
5791	12	Ақкөңілділік	адамның ең бір жақсы қасиеті. Ақкөңіл адамның жүзі жайдары, көңілі ашық болады	4
5792	12	Жауапкершілік	адамның өз міндетін, тапсырылған істі орындап шығуы	4
5793	12	Табандылық	қиыншылықтар мен кедергілерге қарамастан мақсатқа қалайда жетуге бағытталған адамгершілік қасиет	4
5794	12	Ар	жақсылық пен зұлымдықты, шындық пен жалғандықты, әділддік пен әділетсіздікті және басқаларды анықтайтын адамгершілік ұғымы	4
5795	12	Азаматтық парыз	адамның өзге адамдар мен қоғам алдындағы жауапкершілігі, міндеті, борышы	4
5796	12	Азамат болу	өз жауапкершілігн сезіну, елінің өсіп-өркендеуіне өз үлесін қосу	4
5797	12	Өзін-өзі тану	рухани-адамгершілік білім беретін пән	4
5281	8	Электролит	ерітіндісі немесе балқымасы электр тогын өткізетін зат	9
5798	12	Адамзат	бүкіл адам баласы	4
5799	12	Адамгершілік	ізгілікті білдіретін ұғым, адами қасиеттердің жиынтығы. Адамның күнделікті өмірінде жетекші ішкі, рухани қасиеттері	4
5800	12	Ақиқат	шындықтың адам санасында дәлме-дәл бейнеленуі. Адам түсінігінің өмір шындығымен сәйкестігі. Заттар мен құбылыстардың анық бейнесі. Адамның шындықты дұрыс, әділ бейнелеуі, оны санаға өмірде қандай болса, сондай күйінде түсіруі	4
5801	12	Алғыс	өзіңе жасалған жақсылыққа ризашылық білдіру	4
5802	12	Ар 	адамның ең жоғары адамгершілік қасиеті. Кісінің халық пен қоғам, жеке адамдар алдында өз әрекеті үшін жауапкершілігін сезініп, саналы ұғынуы	4
5803	12	Ар-ұят	ізгілік пен мейірімділікті, имандылық пен инабаттылықты білдіретін ұғым. Адамның әдептілікті сақтап, іс-әрекеті мен мінез-құлқына баға беруімен байланысты туындайтын қасиет	4
5804	12	Әдептілік	адам бойындағы жағымыды қасиет, оның қоғамда қабылданған әдеп талаптарын мінсіз орындауы, мәдениеттіліктің белгісі. Әдептілік адамның жүріс-тұрысы, өзін-өзі ұстауы, қарым-қатынасының жалпы ережелері	4
5805	12	Әлем	бізді қоршап тұрған шексіз кең әрі мәңгі дүние	4
5806	12	Батылдық	адамның өз-өзіне сенімділігі, қорқынышты жеңе алуы, ешнәрседен тайынбай іс-қимыл жасауы, жылдам шешім қабылдай білуі	4
5807	12	Дербестік	өз алдына мақсат қоя білу және сол мақсатқа өзінің жетуі, өз бетінше таңдау жасай алу, шешім қабылдай білу, өзінің іс-әрекетіне және мінез-құлқына жауапкершілік	4
5808	12	Достық	адамдар арасындағы жеке риясыз қарым-қатынасты білдіреді. Достардың қызығушылықтары мен айналысатын істері ортақ болып келеді. Достар бір-бірін түсінеді, бір-біріне сенеді, өзара сыйласады, көмектеседі	4
5809	12	Жақсылық	адамдарға көмек көрсетуге ұмтылыс, адам жанының қалауы	4
5810	12	Жақсылық жасау	басқаларды қиыншыдықта қалдырмауға күш салу	4
5811	12	Жауапкершілік	адам бойындағы белгілі бір істі, өзіне тапсырылған міндетті орындап, жүзеге асыруынан байқалатын адамгершілік қасиет. Өмірге, іс-әрекетке ар-ұятпен, аса ұқыптылықпен қараудың белгісі.	4
5812	12	Кешірімділік	адам бойындағы жақсы қасиет. Адамдарға құрметпен, ізгілік тұрғыдан қарау. Адамның оқыс істері мен қоғамға зиянды іс-әрекет жасағаны анықталғанда, оған адами тұрғыдан кеңшілік жасап, залалды істерінің мән-жайын түсіндіру, кешірім сұруау	4
5813	12	Кішіпейілділік	ізеттілік пен әдептіліктің, құрмет пен сыйластықтың белгісі. Ол өзге адамдарды сыйлауды, олармен қарым-қатынас жасаудағы қарапайымдылықтан көрінеді	4
5814	12	Қайырымдылық	адамның асыл қасиеттерінің бірі. Кісінің айналасындағы адамдарға деген ықыласы мен көмегін, ізгі қарым-қатынастарын білдіреді	4
5815	12	Қамқорлық	адамға, табиғатқа, жан-жануарларға жақсылық істеу, көмек көрсету	4
5816	12	Қанағатшылдық	адамның барға риза болуын білдіретін ұғым. Қанағат ету - жетіспеушілікке, таршылыққа  төзіп шыдау емес, ақылға сүйеніп, өзін-өзі тежеп, құнығудан бас тарту. Қанағатшылдық - қолдағы барына, қол жеткізген табыстарына разы болу	4
5817	12	Қарапайымдылық	ақыл-парасатты іс-әрекетпен, ізетті мінезбен жұрттың сүйіспеншілігіне бөлену	4
5818	12	Мақсат	адамның қол жеткізуі тиіс нәтижеге алдын ала ниеттенуі. Мақсатқа жету үшін адам іс-қимылы мен күшін бағыттап, реттеп отырады	4
5819	12	Мейірімділік	жеке адамның жоғары адамгершілік белгісі болып табылады. Мейірімділік басқаларға тек жақсылық ойлау. Адамның бір-біріне жылылығын білдіріп, оның бүкіл тыныс-тіршілігін, жан дүниесін  жадырату, игі әрекет жасау	4
5820	12	Өзара түсіністік	достық пен сүйіспеншіліктің негізі. Адамдардың бір-бірін түсіне білуі және келісімге келуі	4
5821	12	Парыз	адамнның ел-жұрт, мемлекет пен қоғам алдындағы борышын білдіретін ұғым. Жақсы адам болу, жақсылық жасау  - басты парыз	4
5822	12	Патриот	өз Отанын, халқын, туған жерін, өскен елін шынайы сүйетін, халық мүддесі үшін бар күш-жігерін, қабілетін аямайтын адам	4
5823	12	Патриотизм	Отанға деген сүйіспеншілік, оған адалдық, оның өткені мен қазіргісіне деген мақтаныш, Отан мүддесін қорғауға құлшыныс. Туған жерін, ана тілін, әдет-ғұрпы мен салт-дәстүрін құрмет тұту	4
5824	12	Сұлулық	адамның сыртқы бейнесі мен ішкі әлемінің үйлесімділігі. Іші сұлу адамның сырты да нұрланып тұрады. Адам барлық жағынан әдемі, әсем, көркем болуға ұмтылуы керек	4
5825	12	Табандылық	өзінің әрекетін алдына қойған мақсатына бағындыру және кедергіні жеңе отырып, бастаған ісін аяқтап шығу. Алған мақсаттан қайтпайтын, қиыншылықты қажымай ығыстырып, мақсатқа жететін ерік күші. Мінез-құлықты ұзақ уақыт бойы белгілі бір мақсатқа сай бағыттап, бақылап отыру қабілетінен көрінетін жеке адамның қасиеті	4
5826	12	Ұжым	адамдардың ортық мақсатқа бірігуі. Жоғары нәтижеге қол жеткізу жолында топтасуы	4
5827	12	Ұқыптылық	тәртіптілікті, тыңғылықтылықты, дәлме-дәлдікті және жұмыста да жинақылықты көрсетеді. Сырт көрінісінде де тап-тұйнақтай, сайма-сай, мінсіз болудан көрінетін жеке бастың қасиеті	4
5828	12	Ұят	адамдардың қарым-қатынас мәдениетіндегі ненің жақсы, ненің жаман екендігін түсіну және ажырата білу. Ұят - адамның өзінің іс-әрекеті үшін жауапкершілік танытуы. Ұят - адамгершіліктің бір жемісі, сонымен қатар ар-намыстың қосшысы	4
5829	12	Шығармашылық	ақыл-ой арқылы мәдени, материалдық, жасампаздық игілік жасауға бағытталған адамның қызметі	4
5830	12	Шыдамдылық	қиындыққа шыдай білу, мінездегі төзімділік, сабырлылық, беріктік. Шыдамдылық жеке тұлғаның өзін-өзі тәрбиелеуі арқылы қалыптасады	4
5831	12	Шындық	табиғи және қоғамдық-тарихи құбылыстар жиынтығының нақтылығы	4
5832	12	Шыншылдық 	ындықты бағалай білу дәне шындықты айта білу. Адамның іс-әрекеті оның ойы мен сөзіне қайшы болмауы үшін өмір сүре білуі. Адалдық, турашылдық қасиеттерімен мәндес	4
6260	14	Баспа-таңба	қағаз парағына бояуы бар пішінді басу арқылы жасалған бейне	3
6261	14	Бейнелеу өнерінің жанрлары	бейнелеу өнерінің нені бейнелейтінін білдіретін бөлімі. Мысалы портрет жанрында адам, пейзажда табиғат бейнеленеді	3
6262	14	Бояу жағындысы	кескіндеменің әсерлегіш құралы. Қағаз бетіндегі бояулы қылқаламның ізі	3
6263	14	График-суретші	графика туындыларын жасайтын суретші	3
6264	14	Жылы түстер	қызыл, қызғылт сары, сары түстер. Бұл түстер жылуды еске салады	3
6265	14	Иллюстрация	мәтінді безендіретін суреттер	3
6266	14	Камералық портрет	адамды күнделікті қалпында бейнелеу	3
6267	14	Кескіндеме	бояумен салынатын бейнелеу өнерінің түрі	3
6268	14	Кескіндемеші	суретші кескіндеме туындыларын жасайтын суретші	3
6269	14	Көлемді бейне	жан-жағынан қарауға болатын бейне	3
6270	14	Көлемді дене	жан-жағынан қарауға болатын заттар. Шар, текше, конус және т.б. көлемді денелер	3
6271	14	Марина (теңіз пейзажы)	бейнелеу өнерінің теңіз бейнеленетін жанры	3
6272	14	Мүсін өнері	басты әсерлегіш құралдары көлем мен пішін болып табылатын бейнелеу өнерінің түрі	3
6273	14	Негізгі түстер	қызыл, сары, көк түстер. Осы түстерді араластыру арқылы құрама түстер алынады	3
6274	14	Отбасылық портрет	отбасы мүшелері бейнеленген портрет	3
6275	14	Пішім	сурет салынатын парақ өлшемі	3
6276	14	Пішін	суретшінің басты әсерлегіш құралдарының бірі. Заттың сыртқы кескіні	3
6277	14	Профиль	адамдарды қырынан қаратып бейнелеу. Пішім - сурет салынатын парақ өлшемі	3
6278	14	Пуантилизм	әртүрлі түстегі нүктелер мен ұсақ дақтарды пайдалану арқылы жасалатын кескіндеме өнерінің бағыты	3
6279	14	Салтанатты портрет	адамды салтанатты түрде бейнелеу	3
6280	14	Символ	белгілі бір түсінік пен құбылысты білдіруге арналған шартты белгі	3
6281	14	Симметрия	заттың оң жағы мен сол жағы бірдей болатын құбылыс	3
6282	14	Скрапбукинг	қолдан альбом жасау өнері	3
6283	14	Суық түстер	көк, көгілдір түстер. Бұл түстер суықты еске салады. Жасыл және күлгін түс те суықты еске салады	3
6284	14	Сызық	суретшінің басты әсерлегіш құралдарының бірі. Сызық нүктеден басталады. Суретшілер суреттерінде әртүрлі сызықтарды қолданады	3
6285	14	Сызықтық перспектива	алыстағы заттар көрерменге жақын заттардан кіші болып көрінетін құбылыс	3
6286	14	Сұлба	заттың дақ тәрізді кескіні. Әдетте қара түсті болады	3
6287	14	Сәндік-қолданбалы өнер	тұрмысқа қажетті бұйымдарды жасау және әшекейлеу өнері	3
6288	14	Сәндеу	әртүрлі заттарды ою-өрнектермен әшекейлеу	3
6289	14	Сәулет кешені	идеясы мен безендірілуі ортақ бірнеше ғимарат	3
6290	14	Сәулет өнері	ғимараттарды жоспарлап, жасау өнері	3
6291	14	Топтық портрет	екі не бірнеше адам бейнеленген портрет	3
6292	14	Түс	суретшінің басты әсерлегіш құралдарының бірі. Суретші бояуларды араластыру арқылы алуан түрлі түстерді алады	3
5833	13	Нормалар	жалпыға міндетті мінез-құлық ережесі. Әлеуметтік ережелер қоғамда туындайды, қоғам оны негізгі, қажетті ережелер деп қабылдайды және оны барлық адам сақтайды	9
5834	13	Құқық	заңмен бекітілген тәртіп  ережелері	9
5835	13	Мораль (адамгершілік)	жақсылық пен жамандық, әділеттік пен әділетсіздік, адалдық пен арсыздық туралы адамның түсінігі мен сеніміне негізделген, адамның іс-әрекетін реттеп отыратын нормалар мен ұстанымдар жүйесі	9
5836	13	Мораль 	қоғамдық қатынастардың ең сенімді және күшті реттеушісі	9
5837	13	Құқық	мемлекет орнатқан және оның күшімен қорғалатын, жалпыға бірдей қоғамдық қатынастарды реттейтін тәртіп нормаларының жиынтығы	9
5838	13	Діни ережелер	дін туралы деректерде қалыптасқан мінез-құлық ережелері.	9
5839	13	Құқықтың функциялары	құқық әрекетінің негізгі бағыты, қоғамдық қатынастарды реттеу үдерісіндегі құқықтың рөлін көрсетеді	9
5840	13	Этика	мораль туралы ғылым	9
5841	13	Құқықтық мемлекет	қоғам мен жекетұлғаның құқықтық қорғалуын өзінің басты мақсаты етіп қоятын мемлекет	9
5842	13	Құқықтық мемлекет	барлығы тең дәрежеде заңға бағынатын мемлекет. Мұнда бірінші орында адам, оның өмірі, құқығы мен бостандығы тұрады	9
5843	13	Құқықтық қорғалу	барлық адамдар өз құқығы мен бостандығын қорғау үшін мемлекеттік органдарға тең дәрежеде жүгіне алу ұстанымы. Тиісінше, мемлекеттік органдар адам мен азаматтың құқығы мен бостандығын қорғауға міндетті	9
5844	13	Азаматтық қоғам	жекетұлғалар мен топтардың мүддесін қанағаттандыратын адамгершілік, діни, ұлттық, әлеуметтік-экономикалық, отбасылық қатынастар мен институттардың жиынтығы	9
5845	13	Азаматтық қоғам	мемлекетке тәуелсіз, жекетұлғалар арасында болатын қоғамдық қатынастар	9
5846	13	Азаматтық қоғам институттары	адамдардың түрлі бірлестіктері	9
5847	13	Отбасы	туыстардан немесе ерлі-зайыптылар (әке, ана) мен олардың балаларынан (туған не асырап алған) тұратын адамдар тобы. Отбасы мүшелері бір-бірімен рухани байланысады, олардың өзара моральдық жауаптылықтары бар	9
5848	13	Конституциялық құқық	конституциялық құрылым негіздерін, жекетұлғаның құқықтық жағдайын, басқару түрі мен мемлекеттік құрылымды реттеп отыратын құқықтың жетекші саласы	9
5849	13	Адамның құқықтары мен бостандықтары	адамның мүдделерін қанағттандыруға бағытталған, заңмен қорғалатын ықтимал мінез-құлық өлшемі	9
5850	13	Референдум	аса маңызды мәселе бойынша бүкілхалықтық дауыс беру	9
5851	13	Конституциялық құрылым негіздері	мемлекеттің басты тірегі, оның мәнін бейнелейтін негізгі ұстанымдары	9
5852	13	Адам құқығы	жекетұлғаға тиісті мүмкіндіктер. Бұл мүмкіндіктер оның өміріне, азаматтық ар-намысына, іс-әрекет еркіндігіне кепілдік береді. Адам құқығы - туа салысымен пайда болатын, болжалды жүріс-тұрыс өлшемі. Бұл - өмір сүру құқығы, еркіндігі мен жеке өміріне қолсұқпаушылық тәрізді табиғи және ажырамас құқықтар мен бостандықтар жиынтығы. Адам құқығы оның қай мемлекеттің азаматы екендігіне байланысты емес, ол туа салысымен пайда болады.	9
5853	13	Адам мен азаматтың конституциялық (негізгі) құқықтары мен бостандықтары	жекетұлғаның мүмкін болатын жүріс-тұрыс өлшемі. Бұл құқықтар адам өмірге келгеннен бастап немесе азаматтығы нәтижесінде пайда болады. Мемлекет қорғайды, негізгі заң - Конституцияда бекітілген	9
5854	13	Конституциялық міндеттері	азаматтардың ҚР Конституциясында бекітілген қоғамдық қажетті мінез-құлықтары	9
5855	13	Адам құқығы туралы халықаралық Билль	адам құқығы туралы үш құжат: Адам құқықтарының жалпыға бірдей Декларациясы, Азаматтық және саяси құқықтар туралы Халықаралық Пакті және Экономикалық әлеуметтік және мәдени құқықтар туралы Халықаралық Пакті	9
5856	13	Адам құқығының шектелуі	адамның бостандығының шегі, мінез-құлқының шегарасы. Шектеулер нақты мақсатта белгіленеді	9
5857	13	Мемлекеттік билік органдарының жүйесі	заңшығарушы, атқарушы және сот билігінің жоғарғы және жергілікті органдарының жиынтығы	9
6293	14	Түс үйлесімі	бірнеше түстің өзара сәйкес келуі	3
6294	14	Штрих	қысқа сызықтар, график-суретшінің басты әсерлегіш құралдарының бірі	3
5858	13	Қазақстан Республикасының Президенті	мемлекеттің басшысы, мемлекеттің ішкі және сыртқы саясатының негізгі  бағыттарын айқындайтын, ел ішінде және халықаралық қатынастарда Қазақстанның атынан өкілеттік ететін ең жоғары лауазымды тұлға	9
5859	13	Қазақстан Республикасы Парламенті	жоғарғы өкілетті және заңшығарушы орган. Парламент екі палатадан: жоғарғы палата - Сенат және төменгі палата - Мәжілістен тұрады	9
5860	13	Қазақстан Республикасының Үкіметі	атқарушы билікті жүзеге асырады, Қазақстан Республикасының атқарушы органдарының жүйесін басқарады және олардың қызметіне басшылық жасайды	9
5861	13	Сот билігі	Жоғарғы сот басқаратын әділет жүйесі	9
5862	13	Жергілікті мемлекеттік басқару және өзін-өзі басқару	тиісті аумақтағы істердің жағдайына жауапты жергілікті өкілетті және атқарушы органдар: мәслихаттар, әкімдер, жергілікті өзін-өзі басқару органдары	9
5863	13	Сайлау	дауыс беру арқылы мемлекеттік органдарды, қоғамдық бірлестіктер мен азаматтардың басқа да ұйымдарын қалыптастыру әдісі	9
5864	13	Дауыс беру	сайлау үдерісінің кезеңі. Екі кезеңнен тұрады: дауыс беру және дауыстарды санау	9
5865	13	Сайлау құқығы	сайлау кезінде туындайтын қоғамдық қатынастарды  реттеп отыратын конституциялық-құқықтық нормалар жиынтығы	9
5866	13	Сайлау жүйесі	Конституцияда және Конституциялық актілерде қарастырылған Президент, Парламент және Мәслихат депутаттарын, жергілікті өзін-өзі басқару орагандарын сайлау тәртібі 	9
5867	13	Дауыс беру құқығы	ҚР-ның кәмелетке толған әр азаматы сайлау кезінде өз ойын білдіруге құқылы. Бұл дауыс беру құқығы деп аталады. Бір адамның бір дауысқа құқығы бар	9
5868	13	Азаматтық құқық	қоғамда экономикалық қатынастарды ұйымдастыру және азаматтық құқық субъектілерінің заңды мүддесін жүзеге асыру мақсатында мүліктік қатынастар мен мүліктік емес қатынастарды реттеп отыратын құқық нормалар жиынтығы	9
5869	13	Азаматтық құқық субъектілері	іс-әрекеттері азаматтық құқық нормаларымен реттеліп отырған азаматтық құқықтық қатынастарға қатысушылар	9
5870	13	Меншік	азаматтық құқықтық әртүрлі субъектілері арасындағы материалдық заттарға, мүлікке, бұйымға байланысты қатынастар. Бұл қатынастарда субъектілердің бірі бұл мүлікті өзінікі деп қараса, басқалары үшін ол бөтен	9
5871	13	Меншік құқығы	субъектінің өзіне тиесілі мүлкін пайдалануға және билік етуге, өз қалауынша иелік етуге құқығы заңнамалық актілер арқылы қорғалатын және мойындалатын жекеменшік құқығы	9
5872	13	Міндеттеме	бір тұлға (борышкер) басқа тұлғаның (несие берушінің) пайдасына жасауы тиіс нақты әрекеттер	9
5873	13	Міндеттерді қамтамасыз ету әдістері	міндеттемелерді орындау жөніндегі шаралар. Аталған шаралар міндеттемені орындамағаны немесе тиісінше орындамағаныүшін борышкерге қатысты қолданылады	9
5874	13	Тұтынушы 	жекебасына, отбасына, үй тұрмысына немесе басқа да қажеттеріне жарататын тауар сатып алатын, тапсырыс беретін немесе пайдаланатын жекетұлға	9
5875	13	Тұтынушы құқығы	тұтынушыларды қорғауды қамтамасыз етуге бағытталған ережелер мен нұсқаулар, нормалар жиынтығы	9
5876	13	Тұтынушылар құқығын қорғау	мемлекет пен қоғамдық қозғалыстар жүзеге асыратын шаралар жиынтығы. Олар тұтынушы мен кәсіпкерлік қызметпен айналысатын субъектінің - тұтынушылар құқығын бұзғаны үшін жауапкершілік сияқты міндеттемелерді өздеріне алғандар мен өндіруші, сатушы, орындаушының арасында туындайтын қатынастарды реттеуге бағытталған	9
5877	13	Еңбек құқығы	еңбек ету үдерісінде қоғамдық қатынастарды реттеп отыратын құқықтық нормалар жиынтығы	9
5878	13	Еңбек құқықтық қатынастары	жұмыс беруші мен жұмыскер арасындағы еңбек ету құқығы мен міндеттерінің пайда болуы. Бұл қоғамдық қатынастар еңбек құқығының мәні болып табылады 	9
5879	13	Конституциялық кепілдіктер 	Қазақстан Республикасының Конституциясында қарастырылған жағдайлар негізінде әрбір адам еркін еңбек етіп, кәсіп түрін таңдап, белгілі бір мамандыққа ие болып, еңбекақы ала алады	9
5880	13	Еңбек шарты	жұмыс беруші мен жұмыскердің арасындағы жазбаша келісім. Мұнда тараптардың міндеттемелері мен құқықтары, еңбек жағдайы мен демалыстары көрсетілген	9
5881	13	Еңбек бостандығы	әрекет түрін таңдау мүмкіндігі	9
5882	13	Жұмыс беруші	жұмыскермен еңбек қатынастарында тұрған жеке немесе заңды тұлға	9
5883	13	Жұмыскер	жұмыс берушімен еңбек қаынастарында тұрған жекетұлға және келісімшарт арқылы тікелей жұмыс атқарушы	9
5884	13	Еңбек даулары	Қазақстан РЕеспубликасы еңбек заңнамасын қолдану мәселелері бойынша жұмыскер мен жұмыс беруші арасында туындайтын, еңбек және ұжымдық келісімшарттарды, жұмыс берушінің актілерін орындау немесе өзгерту мәселелері бойынша келіспеушіліктер	9
5885	13	Еңбек жағдайлары	ақы төлеу, еңбек тәртібі, өз міндетін орындау, жұмыс күні мен тынығу уақыты тәртібі, мамандықтарды (қызметті) қоса атқару тәртібі, қызмет көрсету аясын кеңейту, уақытша орнында жоқ жұмыскердің міндетін атқару, еңбек пен еңбек қауіпсіздігін қорғау, техникалық, тұрмыстық-өндірістік жағдайлар, сонымен қатар басқа да екі жақтың келісімі бойынша туындаған еңбек шарттары	9
5886	13	Еңбекті қорғау	жұмыс барысында жұмыскерлердің өмірі мен денсаулығына қауіп төнбеуін қамтамасыз ету жүйесі	9
5887	13	Кәмелетке толмағандардың еңбегі	18 жасқа толмаған жұмыскерлер, еңбек қатынастары бойынша құқықтық жағынан кәмелет жасына толғандармен теңестіріледі. Еңбекті қорғау саласында, жұмыс уақыты, демалыс уақыты және басқа да еңбек жағдайларында қосымша кепілдіктерді пайдаланады	9
6295	14	Қарама-қарсылық (контраст)	үлкен мен кішінің, зұлым мен мейірімнің және т.б. қарама-қарсылығы	3
6296	14	Үлгі	алда жасайтын жұмыстың кішірейтілген нобайы	3
6297	14	Өлшем	қағаздың көлемі. Ол үлкен не кіші болады	3
5643	9	Ісқағаздар	жеке адамның, ұжымның, фирмалардың, мекемелердің атқаратын қызметіне байланысты жазбаша (ауызша) қарым-қатынас құралы	9
5644	9	Құрмалас сөйлемдер	жай сөйлемдердің негізінде қалыптасқан кейінгі құбылыс	9
5645	9	Түсіндірмелі салалас құрмалас сөйлем	Бірінші сөйлемде баяндалған оқиғаның мәні келесі сөйлемде айқындалып, түсіндіріліп отыратын сөйлем	9
5646	9	Талғаулы салалас құрмалас сөйлем	құрамындағы сөйлемдердегі іс-әрекет, жай-күйлер таңдалып, бірі болмаса бірі орындалатыны сұрыпталып берілетін құрмалас сөйлемдер	9
5647	9	Аралас құрмалас сөйлем	құрмаластың құрамындағы сөйлемдер саласа да, сабақтаса да байланысатын көпқұрамды құрмаластың түрі	9
5648	9	Конспект	тыңдалған немесе жазылған мәтіндегі ақпараттың барынша ықшамдалып, қысқартылып жазылуы	10
5649	9	Пауза	сөйлеу ағымында болатын үзіліс	10
5650	9	Тезис	мәтін абзацтарында баяндалған негізгі мәселелердің жинақталып, қысқаша тұжырымдалған жазба нұсқасы	10
5651	9	Орфография	сөөздерді дұрыс жазу ережелерінің жүйесі және оны қарастыратын тіл білімінің бір саласы	10
5652	9	Түйіндеме	белгілі бір қызметке тұру үшін жекетұлғаның өмірбаяны, білімі, мамандығы, кәсіби шеберлігі, біліктілігі жайлы қысқа да нұсқа мағлұмат беретін ісқағаздың бір түрі	10
5653	9	Сипаттау	адамды, затты немесе қоршаған ортадағы белгілі бір құбылысқа тән белгілерді санамалай отырып, сөзбен бейнелеп көрсететін тілдік тәсіл	10
5654	9	Сөзжасам	тіл білімінің жаңа мағыналы туынды сөздерінің қалыптасуы мен мағыналық дамуын, жасалу тәсілдерін зерттейтін саласы	10
5655	9	Сөзжасамдық норма	жаңа сөздің жасалу жолын реттейтін қалыптасқан жүйе	10
5656	9	Синтаксистік нормалар 	сөздерді дұрыс тіркестіріп, сөйлемді дұрыс құраудың заңдылықтары	10
5657	9	Мофологиялық принцип	сөздің морфологиялық құрамын ескеріп, морфемалар (сөз және қосымша) құрамында болатын дыбыс алмасуларын ескермей, бастапқы қалпын сақтап жазу	10
5658	9	Фонетикалық принцип	сөздер айтылуы бойынша жазылады, әрбір әріп фонеманы емес, дыбысты білдіреді	10
5659	9	Тарихи-дәстүрлі принцип	сөздің бір кезде жазылып қалыптасқан, дәчтүрге айналған түрін сақтап жазу	10
3494	7	Регистр	екілік кодта жазылған машиналық сөз сақталатын процессордың үяшығы.	9
5660	9	Баяндау	зат пен құбылыстың өзара байланысысөз болады	10
5282	8	Электролит	ерітіндісі немесе балқымасы электр тогын өткізетін зат	10
5661	9	Тілдік норма	тілдегі бірізділік, тіл материалдарын нормалау, белгілі бір тәртіпке, заңға бағындыру	10
5662	9	Грамматикалық норма	тіліміздегі грамматикалық тұлғалардың бір қалыпқа түсіп, дағдыға айналып жұмсалуы	10
5663	9	Сөзжасамдық норма	туынды сөздің тілдің қалыптасқан заңдылығына, амал-тәсілдеріне сай жасалуы	10
5664	9	Синтетикалық сөзжасамдық тәсіл	жаңа сөз жасаудағы негізгі тәсіл	10
5665	9	Негіз сөз	туынды сөздің лексикалық мағынасына арқау болатын сөз	10
5666	9	Аналитикалық сөзжасамдық тәсіл	тілімізде көне замандардан келе жатқан, тілімізді көптеген күрделі сөздермен толықтырған өнімді тәсіл	10
5667	9	Аналитикалық тәсіл	екі я одан да көп сөзден (сөздердің бірігуі, қосарлануы, тіркесуі, қысқаруы арқылы) бір лексикалық мағыналы сөздің жасалуы	10
5668	9	Күрделі сөздер	аналитикалық тәсіл арқылы жасалған туынды сөздер	10
5669	9	Конверсия	лексика-семантикалық тәсіл арқылы сөздің жаңа мағынаға көшуіне байланысты сөз бір сөз табынан екінші сөз табына ауысуы	10
5670	9	Сөйлем мүшелерінің орын тәртібі дегеніміз	синтаксистік бірліктердің дұрыс қолданылуы	10
5671	9	Ғылыми стиль	қазақ әдеби тілінің бір тармағы. Ғылыми стильде зерттеу нысаны болатын зат немесе құбылыс ғылыми негізде сипатталып, дәлелдеуді қажет етеді. 	11
5672	9	Ономастика	тіл білімінің жалқы есімдерді зерттейтін саласы	11
5673	9	Шешендік сөз	тауып айтылған тапқыр сөз, ақылға қозғау салып, ой түсіретін даналық сөз, қиялға әсер етіп, сезіміңді қозғайтын көрікті де әсерлі сөз, бұра тартпас дәлелімен тамсандырып, таңдай қақтыратын білгір білімді сөз, өтіп кеткен не өтіп жатқан оқиғаны жанды суреттей көз алдыңа алып келетін сөз, тоқсан ауыз сөздің тобықтай түйінін жеткізетін терең де мағыналы түйінді сөз	11
5674	9	Шешендік сөз	көпшілік алдында сөйленетін сөз	11
5675	9	Пікірталас	ойды, идеяны ортаға салу, қорғап сөйлеу	11
5676	9	Пікірталас	түрлі көзқарас, ой-пікірлерді салыстыра отырып өз көзқарасыңды дәлелдеу	11
5677	9	Ойталқы (диспут)	белгілі бір мәселені арнайы жиналған топтың алдында талқылаудың түрі	11
5678	9	Ауызекі сөйлеу тілі	тілдік қарым-қатынастың ауызша жүзеге асатын түрі	11
5679	9	Ойкөкпар (дебат)	пікірталастың бір түрі, көпшілік алдында белгілі бір мәселе төңірегінде пікір таластыру	11
5680	9	Сөзталас	пікірталастың бір түрі, қандай да бір мәселені көпшілік арасында талқылау	11
5681	9	Пікір алмасу	зерттеу, талқылау, талдау деген мағына береді	11
5682	9	Теңеу	суреттеуді неғұрлым көрнекті ету мақсатымен бір затты, ұғымды, күйді басқа бір заттармен, ұғымдармен малыстыруға негізделген көркемдеу тәсілі	11
5683	9	Метафора	ауыстыру, суреттеліп отырған затты не құбылысты өздеріне ұқсас өзге затқа не құбылысқа балау	11
5684	9	Публицистикалық стиль	қоғамдық-саяси, үгіт-насихаттық әдебиеттерде, бұқаралық ақпарат құралдарында, деректі фильмдерде қолданылатын функционалды стильдің бірі	11
5685	9	Көріктеу (эпитет)	заттың, құбылыстың айрықша сипатын, сапасын айқындайтын сөз мағынасын құбылтудың тәсілі.	11
5686	9	Алмастыру	арасында жақындығы бар екі нәрсенің атын ауыстырып, бірінің орнына бірін айту 	11
5687	9	Меңзеу (синекдоха)	алмастыру сияқты эмоционалды мәнерлі сөйлеудің құралы	11
5688	9	Символ	балама бейне, оған негізгі ойды, айтқалы отырған нәрсені, құбылысты сол балама бейне, сурет арқылы тұспалдап көрсету тән	11
5689	9	Әсерлілік құралы	айшықтаудың (фигураның) түрлерін арнайы пайдалану да шешендік сөздердің күнделікті ауызекі сөйлеу тілінен де, жазба үлгілер тілінен де ажыратылатын белгілерінің бірі болады	11
5690	9	Көркем әдебиет стилі	проза, поэзия, драматургия салаларында жазылған көркем шығармалардың тілі	11
5691	9	Ассонанс (үн қату)	дауысты дыбыстардың үндесе қайталануынан тұратын стилистикалық айшықтаудың түрі	11
5692	9	Аллитерация	дауыссыз дыбыстардың бірыңғай қайталануы	11
5693	9	Анафора	бір сөздің ен сөз орамының, өлең жолдарының сөйлемнің басында қайталануы болып табылатын стилистикалық айшықтау түрі	11
5694	9	Эпифора	өлең жолдарының соңында бір сөздің не сөз тіркесінің қайталанып келуі	11
5695	9	Дәлелдеу	шешендік сөзде белгілі бір тұжырымдардың жалғандығын не негізділігін нақты заттарды, құбылыстарды, жағдайларды келтіре отырып дәйектеуге негізделеді	11
5696	9	Сөз дәлдігі	сөз қолдану мәдениетінің маңызды өлшемдерінің бірі, айтайын деген ойды нақты білдіретін, дөп басып жеткізетін сөздерді қолданумен өлшенеді	11
5697	9	Рационалды стиль	айтылмақ ойдың қатаң тәртіппен, байыпты талдаумен, "салқындылықпен" ұсынылуы	11
5698	9	Темпераменттік/романтикалық бояулы ситль	аудиторияның сезіміне әсер ететін, белгілі бір ассоциациялар тудыратын көркемдеуіш-бейнелеуіш элементтер көбірек болады	11
5699	9	Орта/синтетикалық стиль	ретіне қарай жоғарыдағы екі стильдің де элементтері қолданылады	11
5700	9	Сыни пікір (рецензия)	жарыққа шығатын еңбектің кемшіліктерін болдырмау мақсатында кемшін, жетімсіз, қате пікір айтылған тұстары көрсетіле жазылады	11
5701	9	Көркемдеуіш элементтер 	эпитеттер мен теңіеулер, троптың түрлері (метафора, аллегория, метонимия, символ, гипербола т.б.) шешендік сөздерді жай сөзден ажыратып тұратын көркемдік белгілері болып саналады. 	11
5702	9	Эллипсис	сөйлемнің бір мүшесін алып тастау арқылы құрылған сөз үлгісі	11
5703	9	Тема	сөйлемнің (хабардың) бастапқы бөлігін жасаушы компонент	11
5704	9	Рема	сөйлемдегі жаңа нәрсе туралы хабарлайтын өзекті мүшелеу компоненті	11
5888	13	Еңбек шарты	жұмыс беруші мен жұмыскер арасындағы жазбаша келісім. Шартқа сәйкес жұмыскер белгіленген жұмысты атқаруды (еңбек қызметі аясын), еңбек тәртібін сақтауды міндетіне алады. Жұмыс беруші жұмыскерге шартты түрде белгіленген жұмысты беруге, еңбек жағдайларын қамтамасыз етуге, жұмыскерге уақытында және толық көлемде еңбекақысын төлеуге міндеттенеді	9
5889	13	Еңбек шарттарының мазмұны	тараптардың құқықтары мен міндеттері, негізгі шарттары	9
5890	13	Неке	отбасын құру мақсатында заңмен реттелген тәртіп бойынша өз еркімен және толықтай келісім арқылы бекітілген, ерлі-зайыптылар арасындағы мүліктік және мүліктік емес қатынастарды туындататын теңқұқықты одақ. Заң жағынан алғанда неке - құқықтық институт. Ол - ерлі-зайыптылардың өзара құқықтары мен міндеттерін, олардың бір-біріне, балаларына, ортық мүлкіне деген қатынасын реттеп отыратын мінез-құлықтың стандартты үлгісі, нормалар жиынтығы	9
5891	13	Отбасы	мүліктік және жеке мүліктік емес құқықтар мен міндеттемелер арқылы байланыста болатын тұлғалардың бір тобы. Олар неке табиғатынан, туысқандықтан, асырап алу немесе балаларды өз тәрбиесіне алудың басқа түрлерінен туындайды	9
5892	13	Отбасы құқықығы	отбасылық-некелік қатынастарды реттеп отыратын құқықтық нормалар жиынтығы	9
5893	13	Туыстық	бір-бірінен немесе ортақ атадан тарайтын ттұлғалардың қандық байланысы	9
5894	13	Некенің тоқтатылуы	ерлі-зайыптылардың жеке және мүліктік құқық қатынастарының тоқтатылуы. Неке заңда айқындалған белгілі бір жағдайлардың туындауына байланысты немесе ерлі-зайыптылардың біреуінің не екеуінің бірдей қалауымен тоқтатытлады. Некенің тоқтатылуы сот пен АХАТ оргындары арқылы жүзеге асады.	9
5895	13	Некенің бұзылуы (ажырасу)	некені сот арқылы бұзу. Ажырасу арқылы некелерінің бұзылуы ата-аналардың балаларына қатысты құқықтары мен міндеттерін тоқтатпайды	9
5896	13	Туысқандар	бір атадын тараған, туыстық байланыста болып отырған тұлғалар	9
5897	13	Неке шарты	некеге тұратын адамдардың немесе ерлі-зайыптылардың некеде тұрған кездегі немесе ажырасу жағдайындағы мүліктік құқықтары мен міндеттері туралы келісім	9
5898	13	Азаматтық неке	ер адам мен әйелдің некеге тұрмай-ақ бірге тұрып, ортақ шаруашылықты бірге жүргізуі	9
5899	13	Алимент	заңмен бекітілген жағдайларда отбасы мүшелерінің бірі екіншісінің пайдасына төлеуге міндетті белгіленген қаражат. Алименттік міндеттемелердің мақсаты - еңбекке қабілетсіз және мұқтаждық көріп отырған отбасы мүшелерін асырау	9
3493	7	Регистр	екілік кодта жазылған машиналық сөз сақталатын процессордың үяшығы.	8
5900	13	Балалар құқығы	баланың әрекет ету мүмкіндігі. Бұл мүмкіндіктер дүниеге келгенінен бастап пайда болады, заңмен бекітіледі, оған мемлекеттік кепілдік береді. 	9
5901	13	Баланың өз дербестігін сақтау құықығы	Баланың дербестік белгілеріне аты-жөні, тегіне ие болу құқығы жатады	9
5902	13	Бала құқығын қорғауды жүзеге асыру субъектілері	ата-аналар (асырап алушылар, бағып-қағуды міндетіне алғандар, қамқорлығына алғандар), бағып-қағуды міндетіне алған, қамқорлығына алған органдар, сот, прокурор	9
5903	13	Әкімшілік құқық	мемлекеттік билік органдарының басқару қызметі саласындағы қоғамдық қатынастарды реттеуші әкімшілік-құқықтық нормалар жиынтығы	9
5904	13	Әкімшілік-құқықтық нормалар	мемлекет басқару саласында, сонымен қатар мемлекеттік билікті жүзеге асыру барысында туындайтын басқару сипатындағы қатынастарды реттейтін, мемлекет белгілеген мінез-құлық ережелері	9
5905	13	Мемлекеттік басқару	реттеу, сақатау немесе қайта құру мақсатында мемлекеттің адамдардың қоғамдық өміріне ұйымдастырушы және реттеуші түрінде ықпал етуі	9
5906	13	Әкімшілік жауапкершілік	заңдық жауапкершілік түрі. Мемлекеттік органдар, лауазымды тұлғалар мемлкет белгіленген заңдарм мен ережелерді бұзғаны үшін азаматтарға, тиісті жағдайларда мекемелерге де мемлекет белгілеген әкімшілік шаралар қолдануда көрініс табады	9
5907	13	Әкімшілік құқықбұзушылық	жекетұлғаның құқыққа қарсы, кінәлі (қасақана немесе абайсызда жасаған) әрекеті не әрекетсіздігі немесе заңды тұлғаның құқыққа қарсы әрекеті немесе әрекетсіздігі. Бұл үшін Қазақстан Республикасының "Әкімшілік құқықбұзушылық туралы" Кодексінде әкімшілік жауаптылық көзделген	9
5908	13	Түнгі уақыт	кешкі 23:00 мен таңғы 6.00 аралығындағы уақыт. Бұл кезде адамдардың тыныштығы мен демалысын бұзуға болмайды. Басқаша айтқанда, бұл - демалыс уақыты	9
5909	13	Әкімшілік жаза	әкімшілік құқықты бұзғаны үшін өкілетті органдар - сот, мемлекеттік органдар (лауазымды тұлғалар) қолданатын мемлекеттік мәжбүрлеу шарасы	9
5910	13	Әкімшілік қамаққа алу	отыз тәулікке дейінгі мерзімде, ал ерекше жағдай режіміндегі талаптарды бұзғаны үшін қырық тәулікке дейінгі мерзімде қолданылады	9
6298	14	Граттаж	бояу жағылған қағазға өткір құралмен тырнау арқылы сурет салу әдісі	4
6299	14	Дүрия	жалтыраған жібек мата	4
3401	7	Мәтінді форматтау	шрифті редакциялау немесе түрлі эффектілерді немесе басқа құралдарды қолдану арқылы  мәтіннің түрін безендіру.	10
3402	7	Мәтіндік процессор	қарапайым және кешенді мәтіндік құжаттарды форматтауға, ретке келтіруге, енгізуге, сонымен қатар қағазға немесе экранға шығаруды басқаруға мүмкіндік беретін програмдар тобы.	7
3403	7	Мәтіндік процессор	қарапайым және кешенді мәтіндік құжаттарды форматтауға, ретке келтіруге, енгізуге, сонымен қатар қағазға немесе экранға шығаруды басқаруға мүмкіндік беретін програмдар тобы.	8
3404	7	Мәтіндік файл	компоненттері символдық деректер болып келетін файл.	7
3405	7	Мәтіндік файл	компоненттері символдық деректер болып келетін файл.	8
3406	7	Мәтіңдік процессор	мәтінді дайындау мен құрылымдау, мәтінге әртүрлі нысандарды (кестелерді, формулаларды, суреттерді және т.б.) кіріктіру мүмкіидіктері бар мәтіндік редактор.	10
3407	7	Микропроцессор	бөлектелген деректермен арифметикалық және логикалық амалдарды орындайтын  үлкен интегралды сұлбамен жүзеге асырылған жүйелік тақтаның ең маңызды құралы.	8
3408	7	Мобильді қосымшалардың ңұрастырушысы	бпайдаланушыларға жобалау элементтерін және ұсынылған функцияларды өз міндеттеріне бейімдеу арқылы қосымшалар жасауға мүмкіндік беретін кең ауқымды құралдары бар визуалды редактор.	11
3409	7	Модел	шынайы нысанның, құбылыстың,  үдерістің, оқиғаның  немесе жағдайдың маңызды ерекшеліктерін бейнелейтін белгілі бір жаңа нұсқа.	7
3410	7	Модел	шынайы нысанның, құбылыстың,  үдерістің, оқиғаның  немесе жағдайдың маңызды ерекшеліктерін бейнелейтін белгілі бір жаңа нұсқа.	8
3411	7	Модел	шынайы нысанның, құбылыстың,  үдерістің, оқиғаның  немесе жағдайдың маңызды ерекшеліктерін бейнелейтін белгілі бір жаңа нұсқа.	9
3412	7	Модел	шынайы нысанның, құбылыстың,  үдерістің, оқиғаның  немесе жағдайдың маңызды ерекшеліктерін бейнелейтін белгілі бір жаңа нұсқа.	10
3413	7	Моделдеу	нысандарды, құбылыстарды,  үдерістерді, оқиғаларды  немесе жағдайларды зерттеу, зерделеу үшін моделдерді құру үрдісі.	7
3414	7	Моделдеу	нысандарды, құбылыстарды,  үдерістерді, оқиғаларды  немесе жағдайларды зерттеу, зерделеу үшін моделдерді құру үрдісі.	8
3415	7	Модулдер	көп қолданылатын есепті шешуге арналған қандай-да бір програмдау тілінде жазылған програмдар.	9
3416	7	Моннтор	ақпаратты змрйңап көрсету қурылғысы.	10
3417	7	Мөлдірлік	артқы жағындағы графикалық нысандарды жасырмайтын экранда шығарылмайтын кескін бөлігі.	9
3418	7	Мультимеңиа	компьютерде мәтінді,  дыбысты, тұрақты жане қозғалыстағы бейнелерді біріктіріп көрсету үшін жинақталған компьютерлік технология.	10
3419	7	Мұғаліммен машиналық оқыту	машинаның алдын ала мұғалім көрсеткен нақты мысалдарға сүйеніп үйрену әдісі.	11
3420	7	Мұғалімсіз машиналық оқыту	машинаның өз бетімен белгісіз заңдылықтарды табу арқылы уйренуі.	11
3421	7	Нейрон	ақпаратты қабылдап, өңдеп бойға тарататын мидың негізгі құрылымдық-функционалдық бірлігі болатын талшық.	11
3422	7	Нейрондық желі	нейрондардың бір-бірімен синапстар арқылы біріктірілген белгілі бір жиыны.	10
3423	7	Нейрондық желі	нейрондардың бір-бірімен синапстар арқылы біріктірілген белгілі бір жиыны.	11
3424	7	Нигериялық хаттар	спамның пайда болуынан бері қарқынды дамыған алаяқтықтың түрі.	8
3425	7	Нодалды нүкге	оптикалық сәулелердің қиылысында орналвсқан объектив осіндегі нүкте.	11
3426	7	НТМL	компьютер экранында браузер програмы арқылы ашылатын құжаттардың сыртқы келбетін анықап, таңбалауға арналаған тіл.	10
3427	7	Нұсқама	құжат беттерінің соңында болатын мақаланы жазу кезінде қолданылған негізгі мәтіннен тыс ақпарат көзіне сілтеме немесе тұсініктеме.	6
3428	7	Нүктелік диаграмма	біреуінің деректері екіншісін анықтау үшін пайдаланатын, кем дегенде екі қатары бар диаграмма.	8
3429	7	Нысан	1) бір бүтін ретінде қарастырылатын коршаған әлемнің кейбір бөлігі;\n 2) деректер мен функциялар жиынынан тұратын бірыңғай конструкция немесе қасиеттер мен тәсілдер жиыны;\n 3) спрайттар арқылы визуалданатын  ойынның белсенді құрамдас бөлігі.	10
3430	7	Нысандардің қасиеті	объектіні басқа нысандарден айыруға болатын белгілерінің жиынтығы.	10
3431	7	Нысаннын күйі	нысанның. белсенді немесе пассивті іс-әрекет ету нәтижесі.	10
3432	7	Нысанның қасиеті	нысанды басқа нысандардан айыруға болатын белғілердіц жиынтығы.	10
3433	7	Ойын ортасы	ойындағы барлық нысандар мен олардың өзара байланысы және ойындағы өзгеріс заңдылықтарының жиынтығы.	9
3434	7	Оқиға	1) програмды орындау кезінде орын алатын жайт (мысалы, тінтуірдің жылжу оқиғасы, түймені басу немесе пернетақтадан енгізу);\n 2) ойын кезінде пайдаланушының әрекеті.	9
3435	7	Операциялық жүйе	1) жедел жадпен, процессормен, сыртқы құрылғылармен, файлдармен орындалатын іс-әрекеттерді басқаруды және пайдаланушы мен аппаратураны байланыстыратын програмдар жиынтығы;\n 2) компьютердің барлық басты әрекеттерін (пернелер тақтаны, экранды, диск-жетектерді) басқаратын тұрақты жадта сақталатын машиналық кодта жазылған програм.	6
3436	7	Операциялық жүйе	1) жедел жадпен, процессормен, сыртқы құрылғылармен, файлдармен орындалатын іс-әрекеттерді басқаруды және пайдаланушы мен аппаратураны байланыстыратын програмдар жиынтығы;\n 2) компьютердің барлық басты әрекеттерін (пернелер тақтаны, экранды, диск-жетектерді) басқаратын тұрақты жадта сақталатын машиналық кодта жазылған програм.	8
3437	7	Операциялық жүйе	1) жедел жадпен, процессормен, сыртқы құрылғылармен, файлдармен орындалатын іс-әрекеттерді басқаруды және пайдаланушы мен аппаратураны байланыстыратын програмдар жиынтығы;\n 2) компьютердің барлық басты әрекеттерін (пернелер тақтаны, экранды, диск-жетектерді) басқаратын тұрақты жадта сақталатын машиналық кодта жазылған програм.	10
3438	7	Ортақ бұлттар	көпшіліктің Интернетте еркін жұмыс істеуіне арналған инфрақұрылым.	9
3439	7	Орталық процессор	құрамына арифметикалық-логикалық құрылғы мен басқару құрылғысы, ал кейде алғашқы жад кіретін компьютердің негізгі жұмыстық элементі.	10
3440	7	Өңдеудің кіріктірілген ортасы	программдық қамтымды әзірлеу үшін програмдаушылар пайдаланатын програмдық құралдар жиынтығы.	9
3441	7	Өрлемелі тестілеу	Програмдық өнім төменнен жоғары тексеріліп жинастырылатын програмды тестілеу әдісі: алдымен төменгі модульдер жеке-жеке тексеріліп, олардың интерфейстері одан жоғарырақ деңгейдегі модульдермен бақыланады, содан соң осы деңгейдің модульдері тексеріледі және т.б.	8
3442	7	Өрнек	арифметикалык және логикалық амалдар белгілерімен біріктірілген айнымалы және цифрлық тұрақтылардың тізбегі.	6
3443	7	Пайдаланушы интерфейсі	пайдаланушының компьютермен өзара байланысы.	7
3444	7	Пайдаланушы интерфейсі	пайдаланушының компьютермен өзара байланысы.	8
3445	7	Панорамалық фотосурет	160° көлденең жане 75° тігінен адамның көру өрісін қамтитын, ал кейбір жағдайларда көлденең жазықтықта 360° бос орынды көрсететін үлкен көру бұрышы бар фотосурет.	11
3446	7	Параметр	мәні кейбір жиын элементтерін бір-бірінен ажырату үшін қолданылатын шама.	8
3447	7	Пәндік моделдер	құрамына глобус, кристалдық торлар, ғимараттар мен құрылыстар үлгісі және т.б. кіретін материалдық формада нысандардың геометриялық, физикалық және басқа да қасиеттері.	8
3448	7	Персептрон	қабылдау және танып-білу үдерісін моделдейтін жасанды нейронның қарапайым турі.	11
3449	7	Пиксель	компьютерде бейнені көрсетуге қабілетті экранда жарқырайтын ең кіші нүкте.	9
3450	7	Пиксель	компьютерде бейнені көрсетуге қабілетті экранда жарқырайтын ең кіші нүкте.	10
3451	7	Плагиат	басқа біреудің әдеби, ғылыми, өнер туындысын немесе өнертабысын рұқсатсыз иемденіп, өз еңбегінде авторын көрсетпей пайдалану.	6
3452	7	Плагиат	басқа біреудің әдеби, ғылыми, өнер туындысын немесе өнертабысын рұқсатсыз иемденіп, өз еңбегінде авторын көрсетпей пайдалану.	11
3453	7	Пошталық сервер	хабарламаны бір компьютерден басқасына жіберетін компьютерлік програм.	7
3454	7	Пошталық сервер	хабарламаны бір компьютерден басқасына жіберетін компьютерлік програм.	8
3455	7	Провайдер	пайдаланушыларға Интернетке қызметтерін атқаратын компания.	10
3456	7	Програм	компьютердің әрекеттерін басқарушы немесе қандай да бір есепті шешетін алгоритмді жүзеге асыратын техникалық тасымалдаушыда қабылданған синтаксиске сәйкестендіріп жазылған нұсқаулар (командалар) жиыны.	7
3457	7	Програм	компьютердің әрекеттерін басқарушы немесе қандай да бір есепті шешетін алгоритмді жүзеге асыратын техникалық тасымалдаушыда қабылданған синтаксиске сәйкестендіріп жазылған нұсқаулар (командалар) жиыны.	8
3458	7	Програм	компьютердің әрекеттерін басқарушы немесе қандай да бір есепті шешетін алгоритмді жүзеге асыратын техникалық тасымалдаушыда қабылданған синтаксиске сәйкестендіріп жазылған нұсқаулар (командалар) жиыны.	10
3459	7	Програм құру ортасы	програмдаушылар програмды әзірлеу үшін пайдаланатын аппаратық және программдық кешен.	6
3460	7	Програм құру ортасы	програмдаушылар програмды әзірлеу үшін пайдаланатын аппаратық және программдық кешен.	8
3461	7	Програм мәзірі	програмды даярлау және оны жұмыс істету үшін пайдаланатын әртүрлі опциялары бар экранда орналасқан терезе.	10
3462	7	Програмдау	компьютерлердің програмдық қамтымын әзірлеу бойынша кәсіби іс-әрекет.	10
3463	7	Програмдау	компьютерге арналган програмдарды құру үдерісі.	7
3464	7	Програмдау	компьютерге арналган програмдарды құру үдерісі.	8
3465	7	Програмдау жұйелері	жүйелік және қолданбалы програмдық қамтымды құрастыруға, ендіруге, баптауға және оперативті жадқа жүктеуге  мүмкіндік беретін програмдау тілдерінің трансляторлары, байланыс редакторлары және жүктегіштер.	7
3466	7	Програмдау жұйелері	жүйелік және қолданбалы програмдық қамтымды құрастыруға, ендіруге, баптауға және оперативті жадқа жүктеуге  мүмкіндік беретін програмдау тілдерінің трансляторлары, байланыс редакторлары және жүктегіштер.	8
3467	7	Програмдау тілі	алгоритм мен деректерді және олардың құрылымын жазу үшін қолданылатын синтаксисі мен семантикасы нақты анықталған формалды тіл.	7
3468	7	Програмды тестілеу	програмдағы қателерді табу мақсатында програмды орындау үрдісі.	8
3469	7	Програмдық басқару кұрылғысы	арифметикалық логикалық құрылғы мен оперативтік жады бар есептеуіш жүйедегі деректерді өңдеу мен осы жүйенің басқа бөліктерінің жумысын басқаратын құрылғы.	10
3470	7	Програмдық жүйелер	Програмдық өнімдерді дайындау, енгізу және орындау технологиясын қамтамасыз ететін (трансляторлар, байланыс редакторлары, програм құру ортасы, анықтамалық, програмдар кітапханасы және т.б.) програмдар жиынтығы.	8
3471	7	Програмдық интерфейс	әртүрлі програмдарының арасындағы өзара байланысты іске асыратын орта.	8
3472	7	Програмдық қамтым	пайдаланушының тапсырмаларын орындауды және аппараттық құралдардың жүмыс істеуін, ондағы ақпаратты өңдеу мен баптауды қамтамасыз ететін барлық програмдар жиынтығы.	8
3473	7	Програмдық қамтым	пайдаланушының тапсырмаларын орындауды және аппараттық құралдардың жүмыс істеуін, ондағы ақпаратты өңдеу мен баптауды қамтамасыз ететін барлық програмдар жиынтығы.	9
3474	7	Програмдық қамтым	пайдаланушының тапсырмаларын орындауды және аппараттық құралдардың жүмыс істеуін, ондағы ақпаратты өңдеу мен баптауды қамтамасыз ететін барлық програмдар жиынтығы.	10
3475	7	Програмдық тестілеу	тұтас компьютердің немесе оның жекелеген бөліктері мен програмдық қамтымдары жұмысның дұрыстығын анықтайтын үдеріс.	8
3476	7	Програмдық тестілеу	тұтас компьютердің немесе оның жекелеген бөліктері мен програмдық қамтымдары жұмысның дұрыстығын анықтайтын үдеріс.	9
3477	7	Проңедура	керектігіне қарай жұмыс істейгін програм ішінен алынатын және белгілі бір жумысты орындайтын програмның бөлігі.	10
3478	7	Проңессордың тактілік жиіліғі	бір секундта бір миллион такт жасауды көрсететін мегагерцпен өлшенетін бірлік.	10
3479	7	Процедура	ішкі програмдың алуан түрі. Әдеттегідей, пайдаланушылар стандарттық және жиі қайталанатын қандай да бір әрекеттерді атқару үшін бас программен шақырылады.	8
3480	7	Процессор	компьютердегі барлық нұсқауларды (командаларды)  оқып, декодтдтап орындайтын және барлық құрылғылардың жүмысын үйлестіретін микросұлбадан құралған құрылғы.	8
3481	7	Процессор	компьютердегі барлық нұсқауларды (командаларды)  оқып, декодтдтап орындайтын және барлық құрылғылардың жүмысын үйлестіретін микросұлбадан құралған құрылғы.	9
3482	7	Процессор	компьютердегі барлық нұсқауларды (командаларды)  оқып, декодтдтап орындайтын және барлық құрылғылардың жүмысын үйлестіретін микросұлбадан құралған құрылғы.	10
3483	7	Процессор разрядтылығы	процессордың бір уақытта өңдейтін биттер саны, ол 8, 16, 32, 64 бит бола алады.	8
3484	7	Процессор разрядтылығы	процессордың бір уақытта өңдейтін биттер саны, ол 8, 16, 32, 64 бит бола алады.	9
3485	7	Процессор разрядтылығы	процессордың бір уақытта өңдейтін биттер саны, ол 8, 16, 32, 64 бит бола алады.	10
3486	7	Пішім	деректер базасындағы жазбаларды енгізуді, қарауды және редакциялауды жеңілдететін  пайдаланушы интерфейсін ұйымдастыруға мүмкіндік беретін нысан.	9
3487	7	Пішім	деректер базасындағы жазбаларды енгізуді, қарауды және редакциялауды жеңілдететін  пайдаланушы интерфейсін ұйымдастыруға мүмкіндік беретін нысан.	10
3488	7	Пішін	деректерді енгізу, өңдеу және көрсетуге арналған жазба үлгісі.	9
3489	7	Пішін	деректерді енгізу, өңдеу және көрсетуге арналған жазба үлгісі.	10
3490	7	Разряд	1) позициялық санау жүйелеріндегі сандарды бейнелеудің құрылымдық элементі;\n 2) екілік кодта жазылған деректегі биттер саны.	10
3491	7	Разрядтылық	1) екілік кодта жазылған цифрдағы биттер саны;\n 2) құрылғының немесе шинаның осы құрылғымен бір уақытта өңделетін немесе осы шина арқылы берілетін екілік цифрларының (биттерінің) саны.	8
3492	7	Разрядтылық	1) екілік кодта жазылған цифрдағы биттер саны;\n 2) құрылғының немесе шинаның осы құрылғымен бір уақытта өңделетін немесе осы шина арқылы берілетін екілік цифрларының (биттерінің) саны.	1
3495	7	Рекурсивті функция	өзін тікелей немесе басқа функциялар арқылы шақыратын функция.	10
3496	7	Рекурсия	нысандарды немесе есептеу үдерістерін өзі арқылы сипаттаудың тәсілі.	10
3497	7	Рекурсия қадамы	рекурсивті шақырудағы базалық жағдайға жақындататын параметрдің өзгеше мәнімен функцияның өзін шақыратын қадам.	10
3498	7	Реляцнялық деректер базасы	ішкі деректері бағаналар (өрістер) және жолдардан (жазбалар) тұратын екі олшемді кесте түріцде берілген деректер базасы.	10
3499	7	Реттеуіш	програмды түзету жұмыстарына кедергі келтіретін програмдағы қатені іздеу мен түзету үрдісі.	8
3500	7	Реферат	қарастырылып отырған мәселете сәйкес турлі көзқарастарды талдау және оның мәнін айқындайтын өзіндік ғылыми-зерттеу жұмысы.	6
3501	7	Сайт	жекетұлға немесе заңды тұлға ие болатын, бір доменге (ІР-адреске) біріктірілген веб-құжаттардың (веб-парақшалардың) жиыны.	7
3502	7	Сайт	жекетұлға немесе заңды тұлға ие болатын, бір доменге (ІР-адреске) біріктірілген веб-құжаттардың (веб-парақшалардың) жиыны.	8
3503	7	Сайт	жекетұлға немесе заңды тұлға ие болатын, бір доменге (ІР-адреске) біріктірілген веб-құжаттардың (веб-парақшалардың) жиыны.	10
3504	7	Сайт дизайны	сайтта қолданылатын символдар,  графикалық элементтер мен түстер жиынтығы мен олардың өзара үйлесімділігі.	10
3505	7	Сайт конструкторлары	толық ресурстары бар сайтты онлайн құруға мүмкіндік беретін жүйелер.	10
3506	7	Сайт құрастырушы	сайт парақтарын програмдау тілін білмей-ақ құруға арналған күрделі жүйе.	10
3507	7	Сайт құрылымы	ақпараттық және көркемдік элементтер үшін қолданылатын көпмағыналы түсінік.	10
3508	7	Сайт құрылымын құру	сайттың мақсаты анықталғаннан кейінгі орындалатын әрекет.	10
3509	7	Сайт скрипті	ресурста іске асырылатын және порталдың функционалдығын кеңейтетін код.	10
3510	7	Сайтты насихаттау	сайт ресурстарын пайдаланушылар саны мен іздеу жүйелерінде сайт рейтингін арттыруға бағытталған әрекеттер кешені.	10
3511	7	Сайттың картасы	сайттың барлық бөлімдері, ішкі бөлімдері, сайттағы деректер көрсетілген жеке бет.	10
3512	7	Салыстырмалы сілтемелер	бір ұяшықтан басқа ұяшыққа формуланы көшіру кезіндегі сілтемелер.	8
3513	7	Салыстырмалық (релятивтік)	басқа құбылыстарға тәуелдік, байланыстық.	8
3514	7	Салыстырмалылы құбылыс	басқа құбылыстармен қатысы арқылы сипатталатын құбылыс.	8
3515	7	Санау жүйесі	сандарды жазуға арналған ережелер мен арифметикалық амалдарды орындау мүмкіндігін беретін арнайы сандар жиыны.	10
3516	7	Санау жүйесі	арнайы цифрлар жиынтығының көмегімен сандарды белгілеу тесілі.	10
3517	7	Санау жүйесінің әліпбиі	санау жүйесіндегі қолданылатын цифрлар жиыны.	10
3518	7	Сандық бедел	Интернеттегі пайдаланушылар туралы желідегі жағымды немесе жағымсыз деректер.	8
3519	7	Сандық бейнеақпарат	екілік бейнефайлдар түрінде үсынылған ақпарат.	8
3520	7	Сандық тип	сандардың мәндеріне байланысты анықталатын цифрлармен жазу пішімі.	8
3521	7	Сәйкестендіру	субъекгіні оның идентификаторы бойынша тану рәсімі.	10
3522	7	Серверлік програмдық қамтым	ақпараттық технологияларда белгілі бір ресурстарға немесе қызметтерге қолжетімдік беріп, тапсырыс берүшінің сұрауы бойынша сервистік функцияларды орындайтын есептеу жүйесінің програмдық компоненті.	9
3523	7	Сетикет	интернет-қоғамдастық көбі ұстанатын желідегі қарым-қатынас жасау, тәртіп сақтау ережесі, мәдениеті мен салт-дәстүрі.	10
3524	7	Символдық жол	көрші ұсяшықтардың жадында орналасқан символдар тізбегі.	10
3525	7	Символдың ақпараттық салмагы	әліпбидің бір символынан тұратын ақпарат саны.	10
3526	7	Символлардьщ стандартты кестесі	ақпарат алмасудағы америкалық стандартты кодтар негізінде даярланған символдардың стандарттық түрдегі кодтық кестесі.	10
3527	7	Симметриялық шифр	хабарды шифрлау мен шифрдан ашуда бір ғана кілт қолданылатынын білдіру.	10
3528	7	Синапс	әрқайсысы өз кіріс салмағының дәрежесіне ие нейрондар арасындағы байланыс.	10
3529	7	Синапс	әрқайсысы өз кіріс салмағының дәрежесіне ие нейрондар арасындағы байланыс.	11
3530	7	Синтаксис	әліпби әріптерінен құралған тілдің жазба бірліктерін анықтайтын ережелер жиыны.	7
3531	7	Синтаксис	әліпби әріптерінен құралған тілдің жазба бірліктерін анықтайтын ережелер жиыны.	8
3532	7	Скрипт	1. құжатты жүктеу кезінде немесе кейінірек орындалуы мүмкін клиенттік сценарийлерді қамтитын НТМL немесе XML сияқты тілдердегі жазба.\n 2. белгілі тапсырманы орындау үшін web-сервер бетінен келетін арнайы сұратым аркылы сервермен іске қосылуы орындалатын үдеріс.	9
3533	7	Скрипт	1. құжатты жүктеу кезінде немесе кейінірек орындалуы мүмкін клиенттік сценарийлерді қамтитын НТМL немесе XML сияқты тілдердегі жазба.\n 2. белгілі тапсырманы орындау үшін web-сервер бетінен келетін арнайы сұратым аркылы сервермен іске қосылуы орындалатын үдеріс.	10
3534	7	Соқтығыс	компьютерлік ойындарда, ойынның бір сипаты басқа кейіпкермен немесе кейбір экран нысанымен соқтығысатын жағдай.	9
3535	7	Соңғы шартты цикл операторы	repeat S until B қаңқасы бойынша орындалатын қайталау операторы, мұндағы гереаt (қайталау) және until (дейін) – көмекше сөздер, ал S - кез келген оператор, B – шартты анықтайтын логикалық өрнек.	8
3536	7	Спам	қалаусыз жарнамалық ақпараттың беймаза жіберілімі.	8
3537	7	Спам	қалаусыз жарнамалық ақпараттың беймаза жіберілімі.	9
3538	7	Спарклайн	бағалардың ауытқуын, сатылым көлемін сияқты деректер қатарын қадағалау үрдісі.	9
3539	7	Спарклайндар	деректердегі (бағалар тербелісі, сату көлемі) үдерістерді қадағалау.	8
3540	7	Спрайт	кейіпкер немесе компьютерлік ойындағы графикалық нысан.	9
3541	7	Стартап	ауқымды және тиімді бизнес-моделді табу үшін жасалған уақытша ұйым.	11
3542	7	Статистика	1)  бұқаралық әлеуметтік-экономикалық құбылыстар мен үдерістердің сандық және сапалық көрсеткіштерін зерделейтін ғылым; \n 2) қоғам өмірінің (экономиканың, саясаттың, т.б.) сандар заңдылықтарын олардың сапалық мазмұнымен ажырағысыз байланыста сипаттайтын ақпаратты жинап, өңдеуді, талдау мен жариялауды қамтитын практикалық қызмет саласы; \n 3) жарияланатын сандық деректердің, бақыланбалы нысанның сан немесе сапа тұлғасындағы күйін тиянақтайтын бақылау нәтижелерінің жиынтығы;\n 4) қоғам өмірінің сандық жақтарында болатын құбылыстарды меңгеретін ғылым немесе білім саласы.	8
3543	7	Статистикалық деректер	статистикалық зерттеулер (бақылау және ғылыми өңдеу) негізінде алынған сандық сипаттамалардың жиынтығы.	8
3544	7	Стек	уақытша деректерді немесе адрестерді сақтауға арналған “соңғы кіріп, бірінші щығу” принципімен үйымдастырылған жедел жады түрі.	10
3545	7	Стиль	құжаттың сыртқы келбетін жылдам өзгертуде қолданылатын пішімдеу ережелер жиынтығы.	10
3546	7	Сұраныс	белгілі бір ақпаратты алу мүмкіндігі.	10
3547	7	Сұратым	Деректер базасынан белгілі шартқа сәйкес жазбаларды іздеу .	9
3548	7	Сұратым	Деректер базасынан белгілі шартқа сәйкес жазбаларды іздеу .	10
3549	7	Сұрыптау	деректерді өсу немесе кему ретімен орналастыру.	9
3550	7	Сұрыптау	деректерді өсу немесе кему ретімен орналастыру.	10
3551	7	Сүзгілер	шартты немесе шарттар жиынтығын қанағаттандыратын жазбаларды таңдау.	9
3552	7	Сценарий	сюжет көрсетілетін пішім.	9
3553	7	Сызықты алгоритм	нұсқаулары жоғарыдан темен бірінен соң бірі тізбектеліп орындалатын алгоритм.	6
3554	7	Сызықты алгоритм	нұсқаулары жоғарыдан темен бірінен соң бірі тізбектеліп орындалатын алгоритм.	8
3555	7	Сымсыз жергілікті желі	қарапайым сымды желі стандартына толықтай сәйкес келетін  сымсыз радиотолқындық байланыс принципіне негізделген компьютерлік желі.	6
3556	7	Сымсыэ технология	сымсыз екі және одан да көп нүктелер арасындағы қашықтыққа ақпарат беруге қызмет ететін ақпараттық технологияның ішкі бөлігі.	6
3557	7	Сілтеме	формуланы жазу барысында қолданылатын нысан (ұяшықтар, жолдар, бағаналар, ұяшықтар диапазондары)  адресі.	8
3558	7	Сілтеме көрсеткІші	объект (мәтін немесе бейне үзіндісі).	6
3559	7	Сюжет	ойын тарихына қосылатын оқиғалар тізбегі.	9
3561	7	Тактілік жиілік	1) микропроцессордың командаларды орындау жылдамдығының көрсеткіші;\n 2) компьютер құрылғыларының арасындағы ақпаратты беру жылдамдығы.	8
3562	7	Тактілік жиілік	1) микропроцессордың командаларды орындау жылдамдығының көрсеткіші;\n 2) компьютер құрылғыларының арасындағы ақпаратты беру жылдамдығы.	9
3563	7	Таңбалық жол	нөл таңбасымен (’\\0’) аяқталатын таңбалар тізбегі.	10
3564	7	Таңбаның ақпараттық салмағы	бір таңбадағы ақпарат саны.	8
3565	7	Тег	бұрыштама жақшаға алынған HTML немесе ХML арқылы құжаттың белгілі злементін сипаттайтын код үзіндісі.	10
3566	7	Телекоммуникаңия	ауқымды (глобалды) желі бойынша ақпарат алмасу үрдісі.	8
3567	7	Теңдік	екі бөліктен тұратын және бір бірінен “=” таңбасымен айырылған ақпаратты формула.	8
3568	7	Терістеу	әрбір қарапайым тұжырым теріс болатындай құрама тұжырымды сәйкестендіретін логикалық амал.	10
3569	7	Техүдеріс	процессордағы транзистор өлшемі.	8
3570	7	Типографика	дизайндағы сөздердің орналасуы мен олардың көрінісі.	10
3571	7	Толық тестілеу	програмды немесе жүйені берілген деректердің барлық мүмкін комбинацияларын қолдану арқылы тестілеу.	8
3572	7	Трассировка	програмдағы қадамдарды (steр-by-step) приципі бойынша орындау үрдісі.	8
3573	7	Трассировка	програмдағы қадамдарды (steр-by-step) приципі бойынша орындау үрдісі.	9
3574	7	Троллинг	әлеуметтік арандатудың түрі немесе желілік қарым-қатынаста қорлаудың  виртуалды қарым-қатынас тәсілі.	8
3575	7	Троллинг	әлеуметтік арандатудың түрі немесе желілік қарым-қатынаста қорлаудың  виртуалды қарым-қатынас тәсілі.	9
3576	7	Тұрақты жад	өзгертулерді ешқашан талап етпейтін, деректерді сақтауға арналған, қуаттылыққа тәуелсіз жад.	7
3577	7	Тұрақты жад	өзгертулерді ешқашан талап етпейтін, деректерді сақтауға арналған, қуаттылыққа тәуелсіз жад.	8
3578	7	Тұтастық	ақпараттың сенімділігі мен толықтығын және оны өңдеу әдістерін қамтамасыз ету.	10
3579	7	Түйін	желіге қосылу мүмкіндігі бар кез келген құрылғы.	10
3580	7	Тізім	Руtһоп Програмдау тіліндегі тізбектер типтерінің бірі.	9
3581	7	Тізім	белгі немесе нөмірмен басталатын жеке сөйлемшелердің немесе сөйлемдердің өзара байланысты жиынтығы.	10
3582	7	Тілдің әліпбиі	осы тілдің мәтіндерінде қолданылуы мүмкін таңбалардың жиыны.	7
3583	7	Тілдің әліпбиі	осы тілдің мәтіндерінде қолданылуы мүмкін таңбалардың жиыны.	8
3584	7	Утилита	негізгі міндеті компьютерлік жүйені баптау, жөңдеу, тексеру, жетілдіру  және  кеңейту үшін қолданатын қызметтік програмдар.	10
3585	7	Ұтқырлық	програмдық қамтым бір ортадан екіншіге, атап айтқанда, бір компьютерден екіншісіне ауыстыру мүмкіндігі.	9
3586	7	Ұяшық	адресі немесе координатасы бағанның аты мен жолдың нөмірі арқылы анықталатын бағандар мен  жолдардың қиылысы.	8
3587	7	Үшөлшемді объект	үшөлшемді кеңістіктегі көлемді нысандар.	6
3588	7	Файл	1) операциялық жүйемен тіркелген, меншікті атауы бар байттардың тізбегі;\n 2) ақпаратты сақтауға арналған тұрақты немесе көмекші жадта аталған орын.	8
3589	7	Файл	1) операциялық жүйемен тіркелген, меншікті атауы бар байттардың тізбегі;\n 2) ақпаратты сақтауға арналған тұрақты немесе көмекші жадта аталған орын.	10
3590	7	Файлдарды бұлттық сақтау орны	бұлттық сақтау қызметін көрсететін, жеткізуші жабдықтарында орналасқан және Интернет желісіндегі қолжетімді ақпараттарды сақтайтын орын.	9
3591	7	Файлды жою	дискіде файлды орын алған аймағын басқа файлдармен пайдалану үшін босатып беру.	10
3592	7	Фишинг	желілік алаяқтық ретінде есептелетін пайдаланушылардың желідегі құпия деректерін, логин және құпия сөздерін ұрлайтын жаңа қауіп-қатер түрі.	8
3593	7	Флейм	әңгімеге қатысушылардың пікірін ескермей, жиі айтылған эмоционалдық ескертулер.	9
3594	7	Форматталған шығару	өлшемі және шығарылатын символдардың саны көрсетілген ақпаратты шығару.	6
3595	7	Форматтау	мәтіннің сыртқы түрін анықтайтын қасиеттерін өзгерту.	7
3596	7	Форматтау	мәтіннің сыртқы түрін анықтайтын қасиеттерін өзгерту.	8
3597	7	Функция	1) қызмет, міндет, жұмыс; \n 2) қатынастар жүйесіндегі қайсы бір нысан қасиеттерінің сыртқы көрінісі;\n 3) Мәндер параметріне тәуелді мәндерді қайтаруға болатын Ехсеl-дің құралы.	8
3598	7	Функцияны табуляциялау	белгілі бір қадаммен бастапқы мәннен соңғы мәнге дейінгі аргументті өзгерту арқылы функцияның мәнін есептеу.	8
3599	7	Функцияның кестемен берілуі	белгілі бір қадаммен кейбір бастапқы мәннен соңғы мәнге ауысканға дейін функцияның мәндерін есептеу.	9
3600	7	Хабарламаның ақпарат көлемі	хабардың ұзындығын, яғни хабарды жазу үшін пайдаланылған символдар санын айтады.	8
3601	7	Хаттама	белгілі ережелер, компьютерлер арасында ережелерге сәйкес ақпараттың алмасуы жүзеге асырылады.	10
3602	7	Хостинг	үнемі желіде болатын веб-серверде ақылы немесе ақысыз түрде сайтты (ақпаратты) орналастыру қызметі.	10
3603	7	Цикл	1. берілген нұсқаудың шарт ақиқат болып тұрғанша бірнеше рет қайталанып орындалуы;\n 2. берілген нұсқаудың шарт ақиқат болғанша бірнеше рет қайталанып орындалуы.	8
3604	7	Цикл есептегіші	осы циклдің өту саны сақталатын басқару айнымалысы.	8
3605	7	Цикл итерациясы	циклдің бір айналымы.	8
3606	7	Циклдік алгоритмдер	нұсқаулықтары бірнеше рет қайта- ланатын алгоритмдер	7
3607	7	Циклдік алгоритмдер	нұсқаулықтары бірнеше рет қайта- ланатын алгоритмдер	8
3608	7	Циклдік есептегіш	берілген циклдің өту санын сақтайтын басқару айнымалысы.	9
3609	7	Циклдің итерациясы	циклдің бір өту жолы.	9
3610	7	Циклдің қадамы	әрбір өту кезеңінде циклдің есептегіші ұлғайтылатын немесе азайтылатын мәні.	8
3611	7	Циклдің қадамы	әрбір өту кезеңінде циклдің есептегіші ұлғайтылатын немесе азайтылатын мәні.	9
3612	7	Цифрлық видео	кескіндер мен дыбыстарды жазуға, өңдеуге, тасымалдауға және сақтауға арналған технологиялардың жиынтығы. Видеоның сигналы мен дыбысы кодталады да цифрлық түрге түрлендіріледі.	10
3613	7	Цифрлық сауаттылық	күнделікті және кәсіби қызметтерде цифрлық технологияларды және Интернет ресурстарын тиімді пайдалана білу біліктігі.	11
3614	7	Чат-бот	адамның сөзін және дауысын уқсатып қайталайтын әңгімелесуші проғрамма.	11
3615	7	Чипсет	ұқсас міндет атқаратын микросұлбалар жиыны.	8
3616	7	Шинаның жиілігі	процессор мен жүйелік шина арасында дерек алмасуды жүзеге асыратын тактілік жиілік.	8
3617	7	Шифрлау кілті	хабарламаны жасыруға және ашуға мүкіндік беретін  шифрлау алгоритмінің параметрі.	10
3618	7	Шыгыс ақпарат	кіріс ақпаратты адам немесе құрылғының түрлендіруі нәтмжесінде алынған ақпарат.	10
3619	7	Шяқыру	ішкпрограмды іске қосу.	10
3620	7	Ықтималдық	белгілі бір оқиғаның басталу мүмкіндігінің деңгейі.	9
3621	7	Ықтималдылық теориясы	кездейсоқ бір оқиғаның ықтималдығы бойынша онымен қандай да бір байланыста болатын басқа бір кездейсоқ оқиға- ның ықтималдығын анықтауға мүмкіндік беретін математика ілімі.	8
3622	7	Іздеу	іздеу критерийлеріне сәйкес келетін деректер жиынтығын айқындау үшін белгілі бір деректер жиынтығын өңдеу.	9
3623	7	Ілеспелі процессор		8
3624	7	ІР адрес	Интернет протокол адресі әр құрылғыға (компьютер, принтер және т.б.) жеке-дара бекітілген нөмірлі белгі.	8
3625	7	ІР адрес	Интернет протокол адресі әр құрылғыға (компьютер, принтер және т.б.) жеке-дара бекітілген нөмірлі белгі.	10
3626	7	ІР-мекенжай	бір түйіннен екінші түйінге ақпаратты жіберу, алу, табу үшін қажетті бірегей мекенжай.	10
3627	7	Ішпрограм	атауы бар белгілі бір тапсырманы шешетін операторлар тобы, оны програмдың кез келген жерінде бірнеше рет атымен шақыру арқылы іске қосуға болады.	10
3628	7	Ішпрограмды шақыру	қажет кезінде ішпрограмды атымен шақыру.	10
3629	7	Эконамиканы және қоғамды «цифрландыру»	әлеуметтік-экономикалық салада иифрлық технологияларды жаппай енгіау арқылы ақпаратты іздеу, жасау, өңдеу және олармен жұмыс жасау.	11
3630	7	Эксабайт	1018 байтқа тең ақпарат санының өлшем бірлігі.	8
3631	7	Экспоненциалдық	өте үлкен (Жерден Күнге дейінгі арақашықтық) немесе өте кішкентай (сутек атомының килограммен берілген өлшемі) сандарды беруге ыңғайлы пішім.	8
3632	7	Электрмагниттік сәулелену	түрлі нысандарді сәулелендіруден туын- дайтын электрмагниттік толқындарды ұсынатын энергия түрі.	8
3633	7	Электромагниттік толқындар	байланыс тізбегін ңұрайтын екі сымның арасындағы электрлік және магниттік өрістер бір-бірімен белгілі бір электромагниттік энергия мөлшерінде байланыста болатын толқын.	8
3634	7	Электронды кесте функциялары	програм жадында сақталып тұрған арнайы формулалар.	8
3635	7	Электронды пошта	желіні пайдаланушылар арасында электронды хабар алмасу тәсілі (mаіl.ги, іnЬох.гu, gmаіl.соm, уаndex.ru және т.б.).	8
3636	7	Электрондық үкімет	мемлекет пен азаматтар және ақпараттық технологиялар арқылы олардың сәйкестігін қамтамәсыз ететін мемлекеттік органдар арасындағы өзара әрекеттесу механизмі.	11
3637	7	Электрондық цифрлық қолтаңба	электрондық құжаттың түпнұсқалығын, оның тиесілілігін және мазмұнының өзгерілмейтіндігін растайтын электрондық цифрлық символдар жиынтығын білдіретін жеке қолтаңба.	10
3638	7	Электрондық цифрлық қолтаңба	электрондық құжаттың түпнұсқалығын, оның тиесілілігін және мазмұнының өзгерілмейтіндігін растайтын электрондық цифрлық символдар жиынтығын білдіретін жеке қолтаңба.	11
3639	7	Электрондық цифрлық қолтаңба	құжаттың заңды құнын анықтау және растау құралы.	11
3640	7	Эргономика	жеке адамның немесе адамдар тобының техникалық құралдарды нақты жағдайда қолдану іс-әрекетін кешенді түрде зерттейтін ғылым.	6
3641	7	Этикет	тәртіптің негізгі нұсқауы және қоғамдағы тәртіп.	9
3642	7	Юиннод	есепгеу текникасында кодтарға қолданылатын техникалық және индустрия стандаргы, онымен қоса жазу жүйелері мен мәтіндерді компьютерлік құралдарда бейнелеудің стандарты.	10
5911	13	Әкімшілік құқықбұзушылықтың алдын-алу	құқықбұзушылыққа бару себептері мен шарттарын анықтау, жою немесе құқықбұзушылыққа жол бермеу мақсатында мемлекеттік органдар қолданатын шаралар	9
5912	13	Алдын алу жұмысын жүргізетін субъектілер	құқықбұзушылықты ескерту мақсатында объектіге жағымды ықпал ететін тұлға	9
5913	13	Құқықбұзушылықтың алдын алу объектілері	құқықбұзушылықты ескерту мақсатында субъекті ықпал ететін қоғамдық қатынастар мен байланыстар жүйесі	9
5914	13	Қылмыстық құқық	қоғамдық қатынастарды қылмыстық қолсұғушылықтардан қоғау және реттеу мақсатында мемлекет білгілеген қылмыстық құқықтық нормалар жүйесі	9
5915	13	Қылмыс деп тану	қылмыстық заңда іс-әрекетті қоғамға қауіпті деп тану және оны жазалауға жатады деп есептеу	9
5916	13	Қылмыс деп танымау	іс-әрекетті (қылмыстық заңдағы іс-әрекеттен басқасын) бұдан әрі қоғамға қауіпсіз және жазалауға жатпайды деп есептеу	9
5917	13	Құқықбұзушылық	деликтқабілетті жекетұлғаның мемлекет, қоғам мен жекетұлғаның мүддесіне зиян келтіретін құқыққа қарсы айыпты әрекеті (әрекетсіздігі)	9
5918	13	Қылмыс	жазалауға соқтыратын, заң жүзінде тыйым салынған, қоғамға ерекше қауіпті айыпты әрекет. Қылмыс қоғамның заңмен қорғалатын ерекше маңызды мүддесіне нұқсан келтіреді. Жасалған қылмыс үшін заң бас бостандығынан айыру, көлемді айппұл салу және т.б. қатаң жазаларды тағайындайды	9
5919	13	Қылмыстық теріс қылық	айыптының қылмыстық құқық нормаларын бұзған әрекеті (әрекетсіздігі). Қылмыстық теріс қылық қоғамға үлкен қауіп төндірмейді, болмашы зиян келтіреді немесе мемлекетке, қоғамға, ұйымға, жекетұлғаға сондай зиян келтіру қаупін тудырады. Қылмыстық теріс қылық үшін айыппұл, түзету жұмыстары, қоғамдық жұмыстарға тарту, қамаққа алу тәрізді жазалар тағайындалады. Қылмыстық теріс қылық жасағандар сотталмайды	9
5920	13	Жаза	қылмыстық құқықбұзушылық жасағаны үшін соттың шешімімен тағайындалатын мемлекеттік мәжбүрлеу шаралары	9
5921	13	Қылмыстық жауаптылық	айыптыға жаза түрінде қолданылатын мемлекеттік мәжбүрлеу шарасы, жасалған қылмыстың құқықтық салдары	9
5922	13	Қылмыстық жауаптылыққа тарту	қылмыс жасаған субъектіге қатысты сотқа дейінгі тергеудің басталуы, өндіріске алынуы, соттың істі қарауы	9
5923	13	Сыбайлас жемқорлық	жекебас пайдасы үшін мемлекеттік билікті асыра пайдалану	9
5924	13	Сыбайлас жемқорлық құқықбұзушылықтар	заңмен бекітілген тәртіптік, әкімшілік және қылмыстық жауапкершілікке алып келетін, жемқорлықтың туындауына жағдай жасайтын әрекет	9
5925	13	Пара	көрсеткен қызметі үшін субъектінің лауазымды тұлғаға ақша немесе құнды зат ұсынуы	9
5926	13	Ізгілік	құқықтық маңызы бар жағдайларда қоғм мүдделерін қорғайтын, құқықтың, бостандықтың, адам мен азаматтың ар-ұжданы мен намысын қорғайтын, адамды ең қымбат қазына деп тануды көздейтін, нормлармен бекітілген адамгершілік-құқықтық талаптар жүйесі	9
5927	13	Құқықтың қайнар көзі	мемлекет еркінің ресми құжатта заңды бекітілуі	10
5928	13	Құқықтың қайнар көзінің түрлері 	нормативтік-құқықтық акт, құқықтық әдет-ғұрып, сот прецеденті, нормативтік келісімшарт	10
5929	13	Құқық қағидаттары	құқықты арнайы реттеуші ретінде көрсететін және заңдылықты білдіретін ең бастапқы негізгі идеялар, ережелер, түпкі бастамалар	10
5930	13	Құқық функциялары	құқықтың қоғамдық қатынастарға ықпал етуінің негізгі бағыттары	10
5931	13	Құқықтыққатынас	субъектілер арасында құқық негізінде пайда болған байланыс, мемлекет қорғайды және кепілдік береді	10
5932	13	Эмансипация	кәмелетке толмағандарды толығымен әрекетке қабілетті деп тану	10
5933	13	Құқық субъектілігі	адамның құқық субъектісі бола алуы, осыдан туындайтын барлық салдар қабілеттілігі	10
5934	13	Заңды фактілер	құқық нормасы құқықтық қатынастардың пайда болуын, өзгеруін немесе тоқтатылуын байланыстыратын нақты өмірлік мән-жайлар	10
5935	13	Құқық жүйесі	құқықтың ішкі құрылымы, құқықтық элементтерге бөлінуі	10
5936	13	Құқық нормасы	мінез-құлықтың заңда бекітілген бірегей ережесі	10
5937	13	Құқық салалары	құқықтық нормалардың неғұрлым ірі бірлестіктері 	10
5938	13	Құқуқ саласы 	құқық нормаларының жиынтығы. Біркелкі қоғамдық қатынастарды реттейді. Әр саланың өз пәні, құқықтық реттеу әдісі бар	10
5939	13	Мемлекет	қоғамды басқару механизмі, саяси билік, саяси институт. Демократиялық мемлекеттің негізгі міндеті - адам құқығы мен қоғамдық тәртіпті сақтау және қорғау	10
5940	13	Құқықшығармашылық	арнайы мемлекеттік басқарушылық органдардың нормативтік-құқықтық актілерді әзірлеу, қайта өңдеу және басып шығару қызметі	10
5941	13	Мемлекеттің мәні	мемлекеттің кімге қызмет ететінін көрсететін ең негізгі міндеті	10
5942	13	Мемлекеттің функциясы	мемлекет қызметінің негізгі бағыты	10
5943	13	Мемлекет механизмі	мемлекеттің саясаты мен міндеттерін жүзеге асыратын мемлекеттік органдардың жиынтығы	10
5944	13	Мемлекеттік орган	мемлекет механизмінің элементі, оның өз құрылым бар, мемлекет функциясын жүзеге асыруға қатысу үшін оған белгілі бір өкілеттік берілген	10
5945	13	Мемлекет нысаны	үш элементтің жиынтығы. Олар: басқару нысаны, мемлекеттік құрылым нысаны, саяси режім нысаны	10
5946	13	Мемлекеттік құрылым нысаны	аймақтық құрылым, мемлекет бөлігінің орталықпен өзара қатынасы	10
5947	13	Саяси режім нысаны	қоғамды басқару тәсілдерінің жиынтығы, тұлғаның құқықтық жағдайы	10
5948	13	Құқықтық мемлекет	барлық адамдар заңға бірдей бағынатын мемлекет	10
5949	13	Билікті бөлу	билікті асыра пайдалануға кедергі келтіретін қағидат. Мемлекеттік билік үш тармаққа бөлінеді: заң шығарушы, атқарушы және сот төрелігі	10
5950	13	Теңгерім және тежемелік жүйесі	мемлекеттік билік тармақтары қатынастарында қолданылатын заңдық шектеулер жиынтығы: заң шығарушы, атқарушы, сот төрелігі. Олар вето институтын, сенімсіздік туралы дауыс беру жүйесін, мемлекеттік органдарды сайлау және тағайындау институтын, соттардың тәуелсіздігін қамтиды	10
5951	13	Вето	мемлекет басшысының заң шығарушы орган қабылдаған заңның қабылдануын тоқтату немесе болдырмау құқығы	10
5952	13	Консенус	қандай да бір мәселе бойынша ортақ шешімге келу. Келіссөздер барысында дауыс берусіз шешіледі	10
5953	13	Демократия	халық билігі	10
5954	13	Адам құқығы	заңмен қорғалатын ықтимал мінез-құлық өлшемі. Адам құқығын мемлекет қамтамасыз етеді және ол туғаннан беріледі. Өзінің құқығы арқылы  адам өз мүдделері мен қажеттіліктерін қанағттандырады	10
5955	13	Кепілдіктер	жекетұлғаның өз құқықтарын, бостандықтары мен мүдделерін жүзеге асыруға арналған тең мүмкіндіктер құратын әлеуметтік-экономикалық, саяси,  адамгершілік, құқықтық алғышарттар, құралдар мен амалдар жүйесі. "Кепілдік" түсінігі ізгілік, әділдік, заңдылық, мақсаттылық, теңдік сияқты іргелі қағидаттарға негізделген	10
5956	13	Сот төрелігі	заңдылықты, әділдікті және сот шешімінің жалпыға міндеттілігін қамтамасыз ететін заң талаптарын қатаң сақтай отырып, азаматтық және қылмыстық істерді қарау және шешу бойынша сот іске асыратын құқық қорғау әрекеті	10
5957	13	Сот төрелігі қағидаты	мемлекеттік қызметтің аталған түрінің неғұрлым мәнді жақтарын анықтайтын жалпы, жетекшілік етуші, алғашқы жағдайлары	10
5958	13	Адвокат 	азамттарға кәсіптік деңгейде құқықтық көмек көрсететін, міндетті түрде адвокаттық коллегияның мүшесі болып табылатын, адвокаттық қызметпен айналысуға құқық беретін лицензиясы бар жоғары құқықтық білімді Қазақстан Республикасының азаматы	10
5959	13	Прокуратура	мемлекеттік органдарды бақылау қызметін жүзеге асыратын орталықтандырылған мемлекеттік орган	10
5960	13	Сыбайлас жемқорлыққа қарсы қызмет	сыбайлас жемқорлық құқықбұзушылықты тексеру, ашу, жолын кесу, анықтау, ескерту функцияларын жүзеге асыратын мемлекеттік орган	10
5961	13	Ішкі істер органдары	құқық қорғаушы орган. Мақсаты - адам құқығы мен бостандығын, өмірін, денсаулығын, мемлекет пен қоғам мүдделерін құқыққа қарсы әрекеттерден қорғау, қоғамдық тәртіпті сақтау, қоғамдық қауіпсіздікті қамтамасыз ету	10
5962	13	Полиция	қоғамдық тәртіпті сақтау жөніндегі мемлекеттік органдар мен қызметтер жүйесі	10
5963	13	Конституциялық құқық	қоғамдық және мемлекеттік құрылым ненгіздері, адам мен азамат мәртебесінің негізі. Ол - адам құқығының орындалуын қамтамасыз ететін, мемлекеттік үкімет органдары мен олардың қызметтік қағидаларының түзілуін реттейтін және бекітетін құқық саласы	10
5964	13	Конституциялық құқықтық нормалар 	конституциялық құқық пәнін құрайтын, қоғамдық қатынастарды реттеуші нормалар	10
5965	13	Конституциялық-құқықтық қатынастар	қатысушылары конституциялық құқық нормаларындағы міндеттермен және құқықтармен өзара байланыста болатын қоғамдық қатынастар	10
5966	13	Конституциялық құқықтың қайнар көздері	конституциялық құқық пәнін құрайтын, қоғамдық қатынастың негізгі кешенін реттейтін құқықтық нормаларды (әрекеттегі нормативтік актілер) білдіру әдісінің заңды түрі	10
5967	13	Конституция	қоғамның әлеуметтік-экономикалық және саяси ұйымдарының маңызды қағидаттары мен ұстанымдарын бекітетін Негізгі заң немесе мемлекеттік заңдар тобы; мемлекет құрылымы мен жекетұлғаның қоғам мен мемлекет орны	10
5968	13	Президент	республикалық немесе аралас басқару нысаны енгізілген елдерде сайланған мемлекет басшысы. Президент белгілі бір мерзімге сайланады	10
5969	13	Парламент	заң шығарушы жоғары өкілеттік орган	10
5970	13	Үкімет	мемлекеттік басқарудың жоғарғы алқалы атқарушы органы. Үкімет - мемлекеттік басқарудың жалпы жүйесі	10
5971	13	Жергілікті өзін-өзі басқару	тиісті әкімшілік-аймақтық бөліністегі аймақ тұрғындарының (аймақтық ұжым) билігі	10
5972	13	Әкімшілік	әкім басқаратын жергілікті атқарушы орган	10
5973	13	Мәслихат	халық сайлайтын жергілікті өкілетті орган	10
5974	13	Әділ сот	азаматтық және қылмыстық істерді қарастыру және шешу арқылы сот іске асыратын мемлекеттік қызметтің түрі. Ол сот шешімдерінің заңдылығын, негізділігін, әділдігі мен жалпыға міндеттілігін қамтамасыз етеді. Сот билігі мен сот әділдігі демократиялық ұстанымдарға негізделеді	10
5975	13	Конституциялық бақылау	құқық қорғау қызметінің ерекше түрі. Мақсаты - өкілеттігі бар тұлғалардың (ҚР Конституциялық кеңесі, Президент, Парламент, Сот, Прокуратура) жүгінуі негізінде НКА ҚР Конституциясына сәйкестігін тексеру	10
5976	13	Медиация	таласты бейтарап үшінші жақтың - медиатордың реттеу әдісі. Медиатор тараптарды ортық шешімге келуге шақырады. Медиаторлық еркіндік, құпиялылық, тараптардың теңдігі, медиатордың бейтараптығы, сонымен қатар іс барысына араласуға жол бермеу тәрізді ұстанымдарға негізделеді	10
5977	13	Мемлекеттік қызметші	мемлекеттік органда мемлекеттік бюджеттен еңбекақы төленетін және мемлекет міндеттері мен атқаратын қызметін іске асыру мақстында қызметтік өкілдігін жүзеге асыратын ҚР азаматы	10
5978	13	Мемлекеттік басқару	мемлекеттік қызмет түрі. Ол заңға тәуелді, атқарушы-басқарушылық сипатта болады. Экономикалық, әлеуметтік-мәдени және әкімшілік-саяси үдерістерді реттеуде мемлекеттің қызметі мен міндеттерін жүзеге асыруға бағыталған	10
5979	13	Мемлекеттік қызмет	азаматтардың мемлекеттік басқаруды жүзеге асыруға бағытталған мемлекеттік органдардағы қызметі	10
5980	13	Меритократия	мемлекеттік қызметкердің жеке еңбегі мен жетістіктерін мойындау, оныың қабілеті мен кәсіби дайындығына сәйкес мемлекеттік қызмет бойынша көтерілуі	10
5981	13	Генетикалық қор	байқалатын және потенциалды тұқымқуалаушылық белгілері бар тірі  ағза түрлерінің жиынтығы. Табиғи ортаның азғындауы жануарлар мен өсімдіктердің өзгеріске ұшырауына, мутанттардың, яғни, өзгеше генетикалық белгілері бар ағзалардың пайда болуына алып келеді	10
5982	13	Экоцид	өсімдік және жануарлар әлемін жаппай жойып жіберу, атмосфераны, жер немесе су қорларын улау, сонымен қатар экологиялық апатқа алып келетін басқа да әрекеттерге бару	10
5983	13	Экологиялық құқықбұзушылық	мемлекеттің заңды және жекетұлғаларының экологиялық құқықтары мен заңды мүдделеріне зиян келтіретін қарсы әрекеттерге баруы	10
5984	13	Таксалар	шаруашылықты ұстауға (орман, балық, аңшылық) кеткен шығындарды бағалаудың шартты бірліктері, сонымен қатар тәртіп бұзушыны жазалау қажеттілігі. Такса екі бөліктен тұрады, біреуі шыққан шығынды өтеу,  екіншісі кінәліні жауапқа тарту	10
5985	13	Қылмыстық құқық	қылмыстық заңда бекітілген нормалар жиынтығы. Бұл нормалар "қылмыстық құқықбұзушылық", "қылмыс пен  әрекеттің жазалануы", "қылмыстық жауапкершілік негізі", "жаза тағайындаудың жалпы бастауы", "қылмыстық жауапкершілік пен жазадан босату шарттары" ұғымдарына түсінік береді	10
5986	13	Диспозиция	нақты қылмыстық әрекеттің белгілерін сипаттайтын бап бөлігі	10
5987	13	Санкция	жасалған қылмыс түрі мен жазалау мөлшерін анықтайтын бап бөлігі	10
5988	13	Қылмыс	айыппұл салу, түзеу жұмыстары, қоғамдық жұмыстарға тарту, бас бостандығын шектеу, бас бостандығынан айыру түрінде жазаланатын әрекет	10
5989	13	Қылмыстық жауаптылық	жасаған қылмысы үшін жекетұлғаның қылмыстыққ заңмен бекітілген жаза немесе қылмыстық-құқықтық сипаттағы басқа да шараларды мойындауға міндеттілігі	10
5990	13	Қылмыстық құқықбұзушылық субъектісі	қылмыстық заңда көрсетілген жасқа жеткен ақыл-есі дұрыс жеке тұлға	10
5991	13	Ақыл-есі дұрыстығы	тұлғаның өз іс-әрекетінің (немесе әрекетсіздігінің) қоғамға қауіпті  екенін түсінуі және оны басқаруы	10
5992	13	Ақыл-есі дұрыс еместігі	жекетұлға созылмалы жүйке ауруы салдарынан, жүйкесінің уақытша бұзылуынан немесе ақыл-есі аздығынан, басқа да жүйке аурулары кесірінен өз әрекетінің (әрекетсіздігі) қоғамға қауіптілігін түсінбеуі және оны басқара алмауы	10
5993	13	Айып	жасалған қылмыстық құқықбұзушылығына психикалық қатынасы. Екі түрде болады - қасақана немесе абайсызда	10
5994	13	Жаза	соттың шешімімен тағайындалатын мемлекеттік мәжбүрлеу шарасы. Қылмыстық құқықбұзушылық жасады деп айыпталған тұлғаға қолданылады. Қылмыстық заңда қарастырыдғандай, аталған тұлғаны құқығы мен бостандығынан айыру немесе шектеу түрінде көрініс табады	10
5995	13	Қылмыстық құқықтағы жеңілдету жағдайлары	жекетұлғаны жағымды жағынан сипаттайтын немесе оның әрекетінің қоғамға қауіптілік дәрежесін төмендетуін ескере отырып, айыпталушыға неғұрлым жеңілдетілген жаза қолдануға мүмкіндік беретін заңды фактілер мен жағдайлар	10
6300	14	Импрессионизм	түс пен жарықтың құбылуы басты назарға алынатын, 19 ғасырдың аяғында пайда болған өнердегі жаңа бағыт	4
6301	14	Плакат	мәтін мен суреттен тұратын графика түрі	4
5996	13	Қылмыстық жауаптылықтан босату	қылмыстық тексеруді жүзеге асыратын мемлекеттік органдардың қылмыс бойынша қозғалған істі әрі қарай жүргізуден бас тартуы. Мұнда аталған тұлғаның қылмыс жасау фактісі дәлелденуі керек. Аталған жағдайда тұлғаға қандай да бір қылмыстық-құқықтық шаралар қолдану тоқтатылады	10
5997	13	Іс-әрекетіне өкіну	қылмыс жасаған тұлғаның өзі келтірген зиянды жоюға, ауырлығын азайтуға немесе қылмысты тексеріп, ашуға көмек көрсетуі сияқты жағымды мінез-құлқы	10
5998	13	Сыбайлас жемқорлық	лауазымды адамдардың өздерінің лауазымдық (қызметтік) өкілеттіктерін мүліктік (мүліктік емес) игіліктер мен артықшылықтар алу мақсатында заңсыз пайдалануы, сол сияқты осы адамдарды параға сатып алу	10
5999	13	Сыбайлас жемқорлық тәуекелін сараптау (ішкі және сыртқы)	жемқорлық құқықбұзушылыққа баруға итермелеген себптер мен жағдайларды анықтап, зерттеу	10
6000	13	Сыбайлас жемқорлыққа қарсы мәдениетті қалыптастыру	арнайы органдардың қоғамда жемқорлыққа төзбеушілікті бейнелейтін құндылықтар жүйсін сақтау мен нығайтудағы қызметі	10
6001	13	Сыбайлас жемқорлыққа қарсы стандарттар	жемқорлықтың алдын алуға бағытталған ұсыныстар жүйесі	10
6002	13	Қаржылық бақылау шаралары	арнайы шараларға сәйкес, нақты тұлғалардың активтері мен міндеттері, табыстары мен дүние-мүлкі туралы декларация тапсыруы	10
6003	13	Цивилистика	азаматтық құқық туралы ғылым	10
6004	13	Мүлік	тұлғаның (жекетұлға, заңды тұлға), мемлекеттің меншігінде болатын заттар мен  материалдық құндылықтардың жиынтығы	10
6005	13	Азаматтық құқықтың қағидаттары	азаматтық-құқықтық қатынастарды реттеу барысында басшылыққа алынатын негізгі идеялар	10
6006	13	Азаматтық құқықтық қабілеттілік	адамның азаматтық құқықтар мен міндеттерге ие болу мүмкіндігі немесе қабілеті.	10
6007	13	Лицензия	заңға сәйкес қызметті жүзеге асыру үшін арнайы мемелекеттік орган берген рұқсат.	10
6008	13	Азаматтық айналым	азаматтық құқық субъектілері жасаған және міндеттемелер негізінде туындайтын мәмілелердің жиынтығы	10
6009	13	Иесіз қалған мүлік	мұрагері жоқ немесе мұрагерлері бас тартқын мүлік	10
6010	13	Зат	табиғи жағдайда кездесетін немесе адам еңбегімен жасалған сыртқы (материалдық) әлемдегі нәрсе	10
6011	13	Игілік	адамдардың күнделікті өмірдегі қажеттіліктерін өтеуге қабілетті, адамдарға пайда әкелетін барлық нәрсе	10
6012	13	Мемлекеттік тіркеу	жылжымайтын мүлікке және оған теңестірілген мүлікке ауыртпалық пен құқықты есепке алу рәсімі, оны тіркеу органы жүргізеді	10
6013	13	Жеке мүліктік емес құқықтар	мүліктік құқықтарымен қатар жүретін азаматтық құқықтардың бір түрі	10
6014	13	Мәміле	азаматтар мен заңды тұлғалардың азаматтық құқықтар мен міндеттемелерді белгілеуге , өзгертуге немесе тоқтатуға бағытталған әрекеттері	10
6015	13	Биржа	сатып алущылар мен сатушылар арасында жасалған мәмілелер	10
6016	13	Даулы мәміле	мәміленің мәнсіздігі заңнамалық актілерде қарастырылмаса	10
6017	13	Қарыз шарты	қарыз беруші ақшаны немесе заттарды қарыз алушының меншігіне береді. Қарыз алушы оларды осы көлемде және сапада уақытынжа қайтаруды  міндетіне алады	10
6018	13	Жалға беру шарты	жалға беруші жалға алушының алдында мүлікті белгілі бір ақы үшін уақытша иелігіне беруді немесе пайдалануға беруді міндетіне алады	10
6019	13	Өкілеттік 	өкіл жүзеге асыра алатын әрекет шегін анықтау (бұған мәміле де кіреді), өкілдің құқықтық қатынастағы мүмкіндіктерінің аясын белгілеу	10
6020	13	Сенім білдіруші	өкіл оның атынан және оның мүддесіне сай мәміле жасайтын тұлға	10
6021	13	Өкіл 	басқа тұлғаның атынан оның өкілеттігі бойынша мәміле немесе өзге де заңдық әрекеттер жасайтын тұлға	10
6022	13	Тәркілеу	құқықбұзушылық жасағаны үшін меншік иесінен мүлікті сот тәртібімен ақысыз алу	10
6023	13	Ұлттандыру	жеке-меншіктегі мүлікті мемлекет меншігіне өткізу	10
6024	13	Затқа құқық	заттарды басқа тұлғаның пайдалануына беру арқылы зат иесінің өз мүддесін қанағаттандыру құқығы	10
6025	13	Виндикциялық талап-парыз	басқа адам заңсыз иемденген мүлкін қайтару туралы меншік иесінің талабы	10
6026	13	Негаторлық талап-арыз	мүлік иесінің үшінші тарапқа затты иемденуге және оны толықтай пайдалануға кедергі келтіретін себептерді жою туралы талабы	10
6027	13	Зияндар	құықығы бұзылған тұлғаның бұзылған құқықты қалпына келтіруге жұмсалатын шығындары	10
6028	13	Нақты залал	жәбірленушінің өз мүлкін қалпына келтіруге жұмсайтын немесе жұмсауға тиіс шығындары	10
6029	13	Жоғалтқан пайда	мүлік иесінің құқығы бұзылмаған жағдайда алынуы тиіс болған кіріс, пайда	10
6030	13	Міндеттемелік құқық	несие беруші мен борышқордың арасындағы міндеттемеге негізделген қатынастарды реттейтін құқықтық нормалар	10
6031	13	Айыппұл	борышкер несие берушіге белігілі бір көлемде төлеуге міндетті, келісім арқылы белгіленген ақшалай қаржы	10
6032	13	Өсімпұл	мерзімі өтіп кеткен төлемақының пайыздық қатынасын төлеуге арналған ақшалай қаржы, оның көлемі келісім бойынша белгіленеді	10
6033	13	Субсидиарлық (қосымша) жауапкершілік	белгіленген міндеттерді орындауда борышқормен қатар жауап беретін қосымша жауапкершілік артылған тұлғалар	10
6034	13	Ортақ жауапкершілік	борышқор жағынан бірнеше тұлға болған жағдайда пайда болады. Несие беруші солардың қайсысынан болса да талап етуге құқылы	10
6035	13	Санкция	заңбұзушыға қолданылатын жазалау шарасы	10
6036	13	Жауаптылық	заңбұзушылық болған жағдайдағы жағымсыз салдар	10
6037	13	Шығындар	міндеттеменің бұзылуынан туындығын мүліктік зиянның орнын толтыру үшін несие берушінің шығарған шығыстары	10
6038	13	Нақты жоғалту	несие берушінің мүлкін жоғалту немесе зақымдау	10
6039	13	Айырылып қалған пайда	борышқор міндеттемені бұзбаған жағдайда, несие беруші қалыпты айналымнан алуы тиіс болған табыс	10
6040	13	Моральдық шығын	жеке және заңды тұлғалардың жеке мүліктік емес игіліктері мен құқықтарын бұзу, төмендету немесе айыру; оларды моральдық немесе физикалық тұрғыдан азаптау	10
6041	13	Тұтынушы	кәсіпкерлік қызметпен байланысы жоқ, жеке өзі тұтыну үшін немесе жеке шаруашылықта қолдану мақсатында тауар сатып алатын немесе қызметтерді пайдаланатын тұлға	10
6042	13	Дайындаушы	сатуға арнап тауар шығаратын жеке не заңды тұлға	10
6043	13	Жарамдылық мерзімі	белгілі бір уақыт кезеңі, бұл уақыт өтіп кетсе, тауар жарамсыз деп есептеледі	10
6044	13	Кемшілік	тауардың (жұмыстың, көрсетілетін қызметтің) техникалық реттеме, стандарттау бойынша нормативтік құжат , келімшарт талаптарына, сонымен қатар тауар (жұмыс, көрсетілетін қызмет) туралы сатушы берген ақпаратқа сәйкес келмеуі	10
6045	13	Тауардың (жұмыстың, қызметтің) сапасы  	тауар (жұмыс, көрсетілетін қызмет) сипаттамаларының тұтынушының  қажеттіліктерін қанағаттандыру мүмкіндігіне қатысты жиынтығы	10
6046	13	Бала	18 жасқа (кәмелетке) толмаған тұлға	10
6047	13	Ерлі-зайыптылар мүлкінің заңды режімі	ерлі-зайыптылардың неке кезеңінде бірге тапқан мүлкі олардың ортақ меншігі болып табылады	10
6048	13	Ата-аналық құқықтық қатынастар	ата-аналардың құқықтары мен міндеттері	10
6049	13	Сынақ мерзімі	жұмысшының жұмысты орындауға қабілеттілігін тексеру үшін жұмыс берушінің тағайындаған мерзімі	10
6050	13	Жұмыс уақыты	еңбек міндеттемелерін орындау уақыты	10
6051	13	Тынығу уақыты	жұмыскер өзінің еңбек міндеттерін орындаудан бос болатын уақыт бөлігі	10
6052	13	Кәмелетке толмаған жасөспірім	заңмен бекітілген әрекетқабілеттілік жасына жетпеген тұлға	10
6053	13	Кәмелетке толмағандардың ерекше еңбек жағдайы	еңбек әрекеті барысындағы кәмелетке толмағандардың денсаулығы мен өмірінің қауіпсіздігін қамтамасыз ету жүйесі	10
6054	13	Қылмыстық іс жүргізу құқықығы	сот органдарының, прокуратураның қылмыстық істерді тергеу мен анықтау, қозғау қызметін реттейтін құқық саласы	10
6055	13	Қылмыстық процесс	соттың, прокурордың, тергеушінің, анықтау органынының, басқа да қылмыстық іс өндірісіне қатысушылардың заңмен реттелген қызметі	10
6056	13	Ар-абырой	адамның немесе мекеменің жағымды әлеуметтік-адамгершілік бағасы, беделі, репутациясы; басты адамгершілік қасиеттің бірі, адалдықтың, тәртіптіліктің, ізгіліктің жоғарғы деңгейі	10
6057	13	Қадір-қасиет	адамның қаржылық мүмкіндігіне, сіңірген еңбегіне, мәртебесіне қатысы жоқ ажырамас қасиеті. 	10
6058	13	Қылмыстық процестің қағидаттары	қылмыстық процестің барлық қатысушылары сақтауға тиіс жалпыға бірдей міндетті талаптар	10
6059	13	Тергеу судьясы	бірінші сатыдағы сот судьясы. Ол сот ісінде тұлғалардың заңды мүдделерінің, бостандықтары мен құқықтарының сақталуын бақылайды.	10
6060	13	Тергеуші	өз құзыреті шегінде қылмыстық іс бойынша алдын ала тергеуді жүзеге асыруға уәкілеттік берілген лауазымды тұлға	10
6061	13	Сатылар	қылмыстық процестің бір-бірімен байланысқан жеке бөліктері	10
6062	13	Сотқа дейінгі іс жүргізу	қылмыстық істі сотқа дейінгі тергеп-тексеру басталғаннан бастап, прокурор оны ары қарай немесе тоқтату үшін сотқа жібергенге дейінгі  өндіріс. Сондай-ақ жеке айыптаушы мен қорғаушы тараптың қылмыстық іс бойынша материалдар дайындауы	10
6063	13	Сотқа дейінгі тергеп-тексерудің бірыңғай тізілімі 	қабылданған процестік шешімдер, жүргізілген әрекеттер, қылмыстық іс жүргізудің жалжуы, қылмыстық процестің арыз иелері мен қатысушылары туралы мәліметтер енетін автоматтандырылған деректер базасы	10
6064	13	Қылмыстық қудалау (айыптау)	қылмыстық заңда тыйым салынған іс-әрекетті және оны жасаған адамды, соңғысының қылмыстық құқықбұзушылық жасаудағы кінәсін анықтау мақсатында, сондай-ақ осындай адамға жаза немесе өзге де қылмыстық-құқықтық ықпал ету шараларын қолдануды қамтамасыз ету үшін айыптаушы тарап жүзеге асыратын процестік қызмет	10
6065	13	Тергеу	қылмыстық іс жағдайын анықтау үшін күдіктіден, жәбірленушіден, куәгерден жауап алу	10
6066	13	Қарап-тексеру	қылмыс ізін, өзге де материалдық объектілерді, сондай-ақ іс үшін маңызы бар жағдайларды айқындау мақсатында жерді, үй-жайларды, заттарды, құжаттарды, көзі тірі адамдарды, мәйіттерді, жануарларды зерттеу, тексеру	10
6067	13	Басты сот талқылауы	қылмыстық істі бірінші инстанциядағы сот отырысының қарауы	10
6068	13	Сот тергеуі	сот талқылауы кезеңі, тараптар қылмыстық іс бойынша дәйекті түрде өз ұстанымын баяндайды және дәйектемелерді ұсыну арқылы дәлелдейді және соттың қатысуымен оларды тексереді.	10
6069	13	Азаматтық процесс құқығы	азаматтық істер бойынша сот төрелігін жүзеге асыру тәртібін жүзеге асыру тәртібін, сондай-ақ сот шешімдерін мәжбүрлеп орындау тәртібін реттейтін заңдар жиынтығы	10
6070	13	Азаматтық процесс субъектілері	азаматтық іс жүргізу қатынастарына қатысушылар немесе қатысуға ниет білдірген тұлғалар	10
6071	13	Әкімшілік іс жүргізу	атқарушы органдардың жүктелген міндеттер мен қызметтерді іске асыру үшін жасалатын іс-қимыл жиынтығы	10
6072	13	Әкімшілік құқықбұзушылық	әкімшілік құқық нормаларын бұзу	10
6073	13	Кінә	жасалған әкімшілік құқықбұзушылыққа тұлғаның психикалық қатынасы	10
6074	13	Құқыққа қарсы әрекет	міндеттемелерді, заң талаптарын белсенді түрде орындамау, бекітілген тыйымды бұзу	10
6075	13	Құқыққа қарсы әрекетсіздік	заңды немесе жекетұлғаға артылған құқықтық міндеттемелерді белсенді түрде орындамау	10
6076	13	Әкімшілік жауаптылық	әкімшілік құқықбұзушылық жасалған соң туындайтын жағымсыз салдар	10
6077	13	Әкімшілік жаза	әкімшілік құқықбұзушылық үшін мемлекеттік органдар тағайындайтын шаралар	10
6078	13	Халықаралық құқық 	мемлекеттер мен халықаралық қатынастарды реттейтін нормалар	10
6079	13	Халықаралық жеке құқық	азаматтық құқықтық, отбасылық, еңбек қатынастарын немесе шетелдегі объектілерге  байланысты қатынастарды реттейтін нормалар	10
6080	13	Халықаралық келісімшарт	мемлекет бекіткен халықаралық құқықпен реттелген келісім және/немесе халықаралық құқықпен реттелген келісім және/немесе халықаралық құқықтың басқа да субъектілері	10
6081	13	Пакт	үлкен саяси мәні бар халықаралық келісімнің бір түрі, тараптардың келісімі бойынша уақыты шектелген	10
6082	13	Ратификация	жоғарғы мемлекеттік билік органдарының халықаралық келісімдер мен шарттарды бекітуі	10
6083	13	Халықаралық жария құқықтың қайнар көздері	халықаралық құқық субъектілерінің келісілген еркі енгізілген нормалар	10
6084	13	Халықаралық келісімшарт	халықаралық жария құқықтың негізгі қайнар көздері	10
6085	13	Халықаралық жария құқық субъектілері	халықаралық қатынастарға қатысатын, халықаралық құқықтар мен міндеттерді иемденетін, оларды халықаралық құқық негізінде жүзеге асыратын және керек жағдайда халықаралық-құқықтық жауапкершілікті алып жүретін ұжымдық құрылым	10
6086	13	Мемлекет	халықаралық жария құқықтың негізгі субъектісі, оның анағұрлым көлемді халықаралық құқықтары мен міндеттері бар	10
6087	13	Халықаралық ұйымдар	БҰҰ келісімі немесе Халықаралық қылмыстық полиция ұйымы (Интерпол) келісімі негізінде құрылған мемлекетаралық және мемлекеттік емес сипаттағы берлестік	10
6088	13	Адам құқықығын қамтамасыз ету	құқықтар толық көлемде сақталатын жағдай жасау	10
6089	13	Адам құқықығын халықаралық қорғау	адам құқықтары мен бостандықтарын келісімшарт  тәртібінде анықтайтын және бекітетін құқықтық нормалардың жиынтығы. 	10
6090	13	Халықаралық құқықтағы адам құқығын қорғаудың механизмдері	біртұтас, өзара байланысқан объектілерді қорғаудың заңды рәсімделген жүйесі мен олардың арасындағы өзара әрекеттесу нысаны, бұл әрекеттер азаматтың өз құқықтарын қалпына келтіруге және оларды бұзудың алдын алуға бағытталады	10
6091	13	Адам құқығын қорғау саласындағы халықаралық рәсімдер	адам құқығын бұзу жайындағы ақпараттар бойынша ұсыныстарды қарау тәртібі	10
6092	13	Біріккен Ұлттар Ұйымы (БҰҰ)	мемлекеттер арасындағы ынтымақтастықты дамыту үшін және халықаралық бейбітшілік пен қауіпсіздікті бекіту мен қолдау үшін құрылған халықаралық ұйым	10
6093	13	ЮНЕСКО	БҰҰ-ның білім, ғылым және мәдениет мәселелері жөніндегі ұйым	10
6094	13	БҰҰ Бас Ассамблеясы	БҰҰ-ның кеңесші, директивті, өкілетті органдарының бірі	10
6095	13	Заңнама жүйесі	мемлекетте қолданылатын нормативтік құқықтық актілердің жиынтығы	11
6096	13	Заң	жоғары заңдық күші бар нормативтік құқықтық акт	11
6097	13	Номативтік құқықтық актілердің иерархиясы	төменгі деңгейдегі актілердің жоғарғы деңгейдегі актілердің жоғарғы деңгейдегі актілерге бағыну тәртібі	11
6098	13	Заң техникасы	құқықтық актілерді рәсімдеу тәсілдерінің, талаптары мен қағидаларының жиынтығы	11
6099	13	Кодекс	аса маңызды қоғамдық қатынастарды реттейтін құқық нормалары біріктірілген және жүйеге келтірілген заң	11
6100	13	Конституциялық заң	Қазақстан Республикасының Конституциясында көзделген мәселелер бойынша қабылданған заң	11
6101	13	Құқықшығармашылық	Нормативтік құқықтық актілерді әзірлеу және қабылдау үдерісі	11
6102	13	Құқықтық нормаларды түсіндіру	құқық нормаларының нақты мазмұнын анықтау мақсатындағы ерікті үдеріс	11
6103	13	Түсіндіру-анықтау	құқық нормаларын қолданушы субъектінің санасында жүріп жататын іштей ойлау үдерісі	11
6104	13	Түсіндіру-түсінік беру	заңға жазбаша түрде түсіндірме беретін ресми акт, құжат	11
6105	13	Идеология	әлеуметтік топтың, қауымдастықтың немесе қоғамның мүдделерін білдіретін көзқарастар мен идеялар жүйесі	11
6106	13	Құқықтық идеология	құқықтанушы ғалымдар әзірлейтін құқыққа қатысты көзқарастар мен ғылыми идеялар	11
6107	13	Құқықтық психология	құқыққа қатысты көзқарастардың, сезімдердің, көңіл күйдің жиынтығы	11
6108	13	Жекетұлғаның құқықтық мәдениеті	тұлғаның құқықты біліп, түсініп және құрметтеп, заң ұйғарымдарын саналы түрде орындауы	11
6109	13	Құқықтық нигилизм	құқықтық білімсіздіктен туындайтын теріс құбылыс	11
6110	13	Құқықбұзушылық	адамның қоғамға, мемлекетке немесе жекетұлғаға зиян келтіретін заңға қайшы әрекеті	11
6111	13	Қылмыс	қоғамдық қауіптіліктің (зияндылықтың) барынша жоғары дәрежесіне ие құқықбұзушылықтар	11
6112	13	Теріс қылық	әлеуметтік зияндылық пен қоғамдық қауіптіліктің аз дәрежесімен ерекшеленетін құқықбұзушылықтар	11
6113	13	Заңдық жауапкершілік	кінәлі тұлғаға қолданылатын мемлекеттік мәжбүрлеу шаралары	11
6114	13	Заңдық жауапкершіліктің ізгілік қағидаты	заңдық жауапкершілік нормаларында көрсетілген адамгершілік ұстанымдарының жүйесі	11
6115	13	Заңдылық	барлық субъектілерге заң нұсқамаларын орындауға қойылатын талап	11
6116	13	Заңдылық қағидаттары	заңдылық мазмұнын білдіретін негізгі идеялар	11
6117	13	Заңдылық кепілідіктері	заң талаптарын сақтауды қамтамасыз ететін объективті шарттар	11
6118	13	Құқықтық тәртіп	заң талаптарының сақталу жағдайы	11
6119	13	Билік 	адамдар арасындағы қарым-қатынастың нәтижесінде бір адамның басқаның санасына, еркіне, мінез-құлқына әсер етуі	11
6120	13	Саясат	жекетұлғалар мен ұйымдардың билік саласындағы әрекеті	11
6121	13	Саяси жүйе 	нормалардың, идеялар мен оларға негізделген институттардың, азаматтар мен мемлекеттің арасындағы өзара байланысты саяси билікті ұйымдастыратын әрекеттер жиынтығы	11
6122	13	Қоғамның саяси жүйесі	белгілі бір саяси қызметтерді жүзеге асыратын мемлекеттік және мемлекеттік емес әлеуметтік институттардың жиынтығы	11
6123	13	Саяси партиялар	адамдардың белгілі бір саяси идеялар негізінде бірігуі. Партияның негізгі мақсаты - мемлекеттік билік үшін күрес	11
6124	13	Вето	мемлекет басшысының заң шығарушы орган қабылдаған заңның қолданысқа енгізілуін тоқтата тұру немесе оған жол бермеу құқығы	11
6125	13	Вотум	дауы беру арқылы пікір білдіру. Парламент Үкіметке сенімсіздік вотумын жариялай алады	11
6126	13	Импичмент	жоғары лауазымды тұлғаға деген сенімсіздік, мемлекет басшысы, яғни, Президентті қызметінен босату, оны заңдық жауапкершілікке тарту	11
6127	13	Демократия	халық билігі	11
6128	13	Конституция 	мемлекет пен қоғам өмір сүруінің басты идеялары мен қағидаттарын бекітетін негізгі заң	11
6129	13	Құқықтық мемлекет	адамның өмірі, оның құқықтары мен бостандықтары басты құндылық болып табылатын мемлекет	11
6130	13	Азаматтық қоғам	мемлекет пен оның органдарына тәуелсіз өмір сүретін қоғамдық қатынастардың жиынтығы	11
6131	13	Қоғамдық бірлестіктер	белгілі бір міндеттерді шешу үшін құрылған коммерциялық емес ұйымдар	11
6132	13	Бұқаралық ақпарат құралдары	тұқаралық ақпаратты жинаумен, өңдеумен, талдаумен және таратумен айналысатын әлеуметтік институттар	11
6133	13	Үкіметтік емес ұйымдар	ресми институттардың қатысуынсыз жекетұлғалар немесе басқа да қоғамдық ұйымдар құрған бірселстік	11
6134	13	Қамқоршылық	он төрт жастан он сегіз жасқа дейінгі балалардың құқығы мен мүдделерін қорғаудың құқықтық нысаны	11
6135	13	Қорғаншылық	он төрт жасқа толмаған балалардың құқығы мен заңды мүдделерін қорғаудың құқықтық нысаны	11
6136	13	Ювеналды юстиция	кәмелетке толмағандардың құқықтары мен заңды мүдделерін қорғауға бағытталған құқықтық шаралар жүйесі	11
6137	13	Мүгедектік	ағза қызметінің тұрақты бұзылып, денсаулығның нашарлауы салдарынан адамның тұрмыс-тіршілігінің шектелу дәрежесі	11
6138	13	Мүмкіндігі шектеулі бала	ерекше әлеуметтік қорғауды қажет ететін, денсаулығы тұрақты бұзылған 18 жасқа толмаған тұлға	11
6139	13	Заң көмегі 	субъектілердің құқықтарын іске асыруда және қорғауда құқықтық көмек көрсету	11
6140	13	Нотариат	нотариаттық іс-әрекеттер жасау арқылы білікті заң көмегін көрсету жөніндегі құқықтық институт	11
6141	13	Жанжал	адамдардың мүдделерінің, мақсаттары мен ұстанымдарының қарама-қайшы болуынан туындайтын дау	11
6142	13	Құқықтық жанжал	құқықтық салдарға әкеліп соқтыратын және құқықтық құралдармен шешілетін жанжал	11
6143	13	Билер соты	қауымдағы дана, беделді, құрметті адамдардың шешімі	11
6144	13	Медиация	медиатор арқылы келіссөз	11
6145	13	Партисипативтік рәсім	адвокаттардың екі тараптың арасында келіссөздер жүргізу арқылы жан-жалды сотқа жеткізбей шешуі	11
6146	13	Сот	сот төрелігін жүзеге асыруға айрықша құқығы бар мемлекеттік орган	11
6147	13	Соттық билік	әділ сот төрелігін жүзеге асыру арқылы азаматтар мен ұйымдардың құқықтарын, бостандықтары мен заңды мүдделерін қорғайтын үкіметтің тәуелсіз саласы	11
6148	13	Судьяның иммунитеті	судьяға қолсұғылмаушылық кепілі	11
6302	14	Пленэр	күн шұғыласы мен ауаның әсерінен түстердің өзгеруін көрсететін кескіндеме түрі	4
6149	13	Судьяның құқықтық мәртебесі	құқықтар мен міндеттердің жарғылық жиынтығы, сондай-ақ сот төрелігін жүзеге асырудағы оның тәуелсіздік кепілдігі	11
6150	13	Судьяның тәуелсіздік кепілдігі	судьяның тәуелсіздігін қамтамасыз етуге бағытталған шарттар, құралдар, шаралар	11
6151	13	Азаматтық	адамның мемлекетпен саяси-құқықтық байланысы	11
6152	13	Натурализация	өтініш бойынша азаматтыққа қабылдау	11
6153	13	Санкция	құқықбұзушылық жасағаны үшін қолданылатын ықпал ету шаралары	11
6154	13	Филиация	туылу жеріне орай азаматтық алу	11
6155	13	Сайлау жүйесі	мемлекеттік органдардың сайлау тәртібі	11
6156	13	Сайлау құқығы	сайлу кезінде пайда болатын қоғамдық қатынастарды реттейтін құқықтық-конституциялық ережелер жиынтығы	11
6157	13	Әкімшілік жауапкершілік 	әкімшілік құқықбұзушылық жасағаны үшін берілетін жаза	11
6158	13	Әкімшілік жауапкершілік 	әкімшілік заңнамамен тыйым салынған құқыққа қарсы әрекет	11
6159	13	Әкімшілік мәжбүрлеу	жеке және заңды тұлғаларға сотқа дейінгі және сот тәртібімен ықпал ету тәсілі	11
6160	13	АЕК	айлық есептік көрсеткіш.	11
6161	13	Әкімшілік хаттама	әкімшілік құқықбұзушылық жасаған азаматтың  еркін әрекетіне қысқа мерзімге шек қою	11
6162	13	Қоғамдық органдар 	адамдар жүретін кеңістік немесе аймақ (саябақтар, театрла, демалыс орындары, кафе және т.б.)	11
6163	13	Жер құқығы әдісі	жер қатынастарына қатысушыларға әсер етудің заңдық тәсілдерінің жиынтығы	11
6164	13	Жер құқығы қатынастары	жер құқығы нормаларымен реттелген жерді пайдалану мен қорғауға байланысты туындайтын қоғамдық қатынастар	11
6165	13	Жер құқығының пәні	құқық нормаларымен реттелген жер қатынастары	11
6166	13	Жеке қосалқы шаруашылық	ауылдық жерлерде және қала маңындағы аймақтағы жер учаскесінде өз мұқтаждықтарын қанағаттандыруға арналған қызмет 	11
6167	13	Жер учаскесіне жеке-меншік құқығы	жекеменшік иесінің өздеріне тиесілі жер учаскесін иелену, пайдалану және оған билік ету құқықғы	11
6168	13	Құқық белгілейтін құжат	жер учаскесіне құқықты растайтын құжат	11
6169	13	Бүлінген жерлерді рекультивациялау	бүлінген және ластанған жерлердің өнімділігін қалпына келтіру	11
6170	13	Жерді косервациялау	жерді шаруашылық айналымнан уақытша алып тастау	11
6171	13	Жердің ластануы	жер бетінде оның құндылығын төмендететін, ауылшаруашылық өнімдерінің сапасын нашарлататын мөлшерде түрлі заттар мен организмдердің жинақталуы	11
6172	13	Жердің тозуы	оның жай-күйінің нашарлауы, табиғи-шаруашылық маңыздылығының төмендеуі	11
6173	13	Жер құқығын бұзушылық	жер заңнамасын бұзатын, теріс салдарға әкеп соқтыратын немесе осындай салдардың болу қаупін туғызатын қоғамға қауіпті, құқыққа қарсы әрекет	11
6174	13	Жерге құқықтық жауапкершілік	жер заңнамасын бұзғаны үшін жазалау шаралары	11
6175	13	Жіктеу	белгілі бір критерийлер бойынша құқықбұзушылықтарды жүйелеу	11
6176	13	Қылмыстық құқықбұзушылық  	қоғамға зиян келтіретін қоғамға қарсы әрекет	11
6177	13	Қылмыс	кодексте жазалану қатерімен тыйым салынған айыпты қоғамдық қауіпті әрекет	11
6178	13	Денсаулыққа келтірілген ауыр зиян	адамның денсаулығына, өміріне  қауіп төндіретін, не денсаулыққа көру, сөйлеу, есту қабілетінен, не қандай да бір ағзадан айырылуға әкелетін өзге де зиян	11
6179	13	Денсаулыққа келтірілген орташа ауырлықтағы зиян	адамның денсаулығына, өміріне  қауіп төндірмейтіндей, денсаулықтың ұзақ уақыт бұзылуына немесе жалпы еңбек қабілетін тұрақты түрде жоғалтуға әкелетін зиян	11
6180	13	Денсаулыққа келтірілген жеңіл зиян	адам денсаулығына қысқа мерзімге бұзылуына немесе жалпы еңбек қабілетін тұрақты түрде болмашы жоғалтуға әкелетін зиян	11
6181	13	Отбасы	мемлекеттің қорғауындағы әлеусеттік институт	11
6182	13	Отбасы мен кәмелетке толмағандарға қарсы қылмыстар	отбасы мен кәмелетке толмағандардың мүдделеріне қол сұғатын қоғамдық қауіпті әрекеттер	11
6183	13	Адамның конституциялық құқықтары мен бостандықтары	Конституцияда бекітілген әрекет ету мүмкіндіктері	11
6184	13	Тең құқықылық	әрбір адам заң мен сот алдында тең мүмкіндіктерге ие және міндеттерді орындауы тиіс	11
6185	13	Тұрғын үйге қолсұғылмаушылық	тұрғын үйге, онда тұратын адамдардың еркіне қарсы кіруге жол берілмеу қағидаты	11
6186	13	Сепаратизм	мемлекеттің бір бөлігін бөліп алып, жаңа мемлекет құру үшін немесе елдің бір бөлігін автономияға алу үшін жүргізілетін қозғалыс	11
6187	13	Терроризм	адамдарға қарсы қатыгездік жолмен күш қолдану	11
6188	13	Шпионаж	шет мемлекетке, халықаралық немесе шетелдік ұйымға, олардың өкілдеріне мемлекеттік құпия мәліметтерін беру	11
6189	13	Экстремизм	шектен тыс көзқарастар мен қандай да бір әрекеттерді ұсыну	11
6190	13	Алаяқтық	алдау немесе артылған сенімді асыра пайдалану жолымен бөтеннің мүлкін заңсыз иелену	11
6191	13	Қарақшылық	жәбірленушінің денсаулығы мен өміріне қауіп туғызатындай күш қолдана отырып, мүмкін иелену мақсатында шабуыл жасау	11
6192	13	Тонау	біреудің мүлкін ашық түрде жымқыру	11
6193	13	Ұрлық	біреудің мүлкін жасырын жымқыру	11
6194	13	Жария ету 	ақша қаражатымен немесе мүліктермен, басқа адамдар арқылы қылмыстық жолмен қаржылық операциялар мен мәмілелер жасау	11
6195	13	Экономикалық қызмет саласындағы қылмыстық құқық-бұзушылықтар	экономикалық мүдделерге қолсұғушылық	11
6196	13	Қоғамдық қауіпсіздік	жеке адамның, қоғам мен мемлекеттің жалпы қауіпті сипаттағы ішкі қатерлерден қорғану деңгейі	11
6197	13	Қоғамдық тәртіп	белгіленген ережелер мен нормаларды сақтау нәтижесінде қалыптасатын қоғамдық қатынастар жүйесі	11
6198	13	Билік өкілі	заңда белгіленген тәртіппен билік ету өкілеттіктері берілген мемлекеттік қызметші	11
6199	13	Сыбайлас жемқорлық	билік өкілдерінің жеке мүдделерін, игіліктер мен артықшыдықтарын алу үшін мемлекет қызметін пайдалануы	11
6200	13	Сыбайлас жемқорлық құқықбұзушылықтар	сыбайлас жемқорлықпен байланысты немесе оған жағдай туғызатын заңға қайшы  әрекет	11
5173	8	Сұйықтық	заттың өзінің көлемін сақтайтын күйі, бірақ пішіні болмаііды.	7
5174	8	Сұйықтық	заттың өзінің көлемін сақтайтын күйі, бірақ пішіні болмаііды.	1
5175	8	Сынап	элементтердің периодтық кестесінің 6 тобындағы мырыш топшасына жататын атомдық нөмірі 80, атомдық массасы 200,59 химиялық элемент.	7
5176	8	Сыртқы сфера	кешенді қосылыстардың аниондары немесе катиондары болуы кешен ионының зарядына байланысты: егер қосылыстағы кешен ионының заряды оң (теріс) болса, онда сыртқы сферада аниондар (катиондар) орналасады.	11
5177	8	Табиғи газ	жер қойнауларында органикалық заттардың анаэробты бөлінуі кезінде пайда болған газдар қоспасы.	7
5178	8	Табиғи топ	газ, су, метал және басқа табиги заттар тобы.	7
5179	8	Таза зат	бірдей молекулалардан тұрады.	7
5180	8	Тарту және итермелеу	молекулалар мен атомдар арасында болатын және үздіксіз қозғалысты тудыратын күштер.	9
5181	8	Тас тұзы	хлоридтер класының минералы.	7
5182	8	Таттану (шіру, ашу)	оттегінің қатысуымен жүретін баяу тотығу, бүліну үдерістері.	8
5183	8	Таттану (шіру, ашу)	оттегінің қатысуымен жүретін баяу тотығу, бүліну үдерістері.	9
5184	8	Темір	элементтердің периодтық кестесінің 4-ші периодының 8-ші қосымша тобындағы металдар қатарына жататын белсенді химиялық элемент.	7
5185	8	Температура	макроскопикалық жүйенің термодинамикалық тепе-теңдік күйін сипаттайтын физикалық шама.	7
5186	8	Теңдеу	химиялық реакцияларды химиялық формулалар, химиялық таңба, сан мен математикалық белгілер арқылы өрнектеу.	7
5187	8	Термохимиялық теңдеулер	реакцияның жылу эффектісі мен реакцияға түсуші және оның нәтижесінде түзілген заттардың агрегаттық күйі көрсетіліп жазылған химиялық теңдеулер.	7
5188	8	Термохимиялық теңдеулер	реакцияның жылу эффектісі мен реакцияға түсуші және оның нәтижесінде түзілген заттардың агрегаттық күйі көрсетіліп жазылған химиялық теңдеулер.	8
5189	8	Тәжірибелер	адамдардың материалдық, мақсат қоюшы іс-әрекеті, объективті болмысты игеруі және түрлендіруі.	7
5190	8	Тікелей реакция	өнімдердің түзілуіне бағытталған реакция.	8
5192	8	Топ	оттекті қосылыстарында жоғары валенттіліктері бірдей, қасиеттері ұқсас элементтердің тік бағаны, олардың жалпы саны сегіз, әр топ екіге бөлінеді: негізгі және қосымша.	8
5193	8	Топ	оттекті қосылыстарында жоғары валенттіліктері бірдей, қасиеттері ұқсас элементтердің тік бағаны, олардың жалпы саны сегіз, әр топ екіге бөлінеді: негізгі және қосымша.	9
5194	8	Топ	оттекті қосылыстарында жоғары валенттіліктері бірдей, қасиеттері ұқсас элементтердің тік бағаны, олардың жалпы саны сегіз, әр топ екіге бөлінеді: негізгі және қосымша.	10
5195	8	Тотығу	атом, ион және иолекуланың элекгронын беру процессі.	7
5196	8	Тотығу	атом, ион және иолекуланың элекгронын беру процессі.	1
5197	8	Тотығу дәрежесі	зат тек иондардан турады деп есептегенде байқалатын қосылыс молекуласындағы атомдарының шартты заряды.	7
5198	8	Тотығу күйі	молекуладағы немесе кристалдағы атомның шартты заряды, егер барлық полярлық байланыстар иондық болса, онда пайда болады.	8
5199	8	Тотығу күйі	молекуладағы немесе кристалдағы атомның шартты заряды, егер барлық полярлық байланыстар иондық болса, онда пайда болады.	9
5200	8	Тотығу-тотықсыздану реякциялары	1) электрондардың бір атомнан екінші атомга ауысуы нәтижесінде жүретін реакция;\n элемент атомының тогығу дәрежелерінің өзгеруі арқылы жүретін реакция.	10
5201	8	Тотығу-тотықсыздану реякциялары	1) электрондардың бір атомнан екінші атомга ауысуы нәтижесінде жүретін реакция;\n элемент атомының тогығу дәрежелерінің өзгеруі арқылы жүретін реакция.	11
5202	8	Тотықсыздандырғыштар	электронын беретін атом, молекупа және иондар.	10
5203	8	Тотықсыздану	атомның немесе бөлшектердің электронды қосып алу процессі.	10
5204	8	Тотықсыздану	атомның немесе бөлшектердің электронды қосып алу процессі.	11
5205	8	Тотықтыргыштар	электронды қосатын бөлшек (атом, молекула, ион), олар нәтііжесінде тоіпықеызданады.	10
5206	8	Тритий	массалық саны 3-ке тең болатын сутектің ең ауыр радиоактивті изотопы.	7
5207	8	Түзілу жылуы	жай заттардан бір моль күрделі зат түзілгепде бөліиетін немесе сінірілетін жылу мөлшері.	10
5208	8	Тұз	1)молекулалары металл атомдары мен қышқыл қалдығынан тұратын күрделі зат; 2)орташа, қышқылдық, негіздік, күрделі болып жіктеледі.	7
5209	8	Тұз	1)молекулалары металл атомдары мен қышқыл қалдығынан тұратын күрделі зат; 2)орташа, қышқылдық, негіздік, күрделі болып жіктеледі.	8
5210	8	Тұз	1)молекулалары металл атомдары мен қышқыл қалдығынан тұратын күрделі зат; 2)орташа, қышқылдық, негіздік, күрделі болып жіктеледі.	9
5211	8	Тұз	1)молекулалары металл атомдары мен қышқыл қалдығынан тұратын күрделі зат; 2)орташа, қышқылдық, негіздік, күрделі болып жіктеледі.	10
5212	8	Тұз қыщқылы	хлорсутек газының судағы ерітіндісі боолатын бір негізді қышқыл.	7
5213	8	Тұзды емес оксид	оксид түзетін элементтің тотығу дәрежесі бірдей ешбір қышқылға сәйкес келмейтін оксид.	8
5214	8	Тұзды емес оксид	оксид түзетін элементтің тотығу дәрежесі бірдей ешбір қышқылға сәйкес келмейтін оксид.	9
5215	8	Тұну	Ерітіндінің булануы әсерінен онда еріген заттар үйірімділігінің артуы, коагуляцияға ұшырауы немесе химиялық реакцияға түсуі нәтижесінде сол ерітінді құрамындағы тұздардыңтұнбаға түсуі.	7
5216	8	Тұрақсыз изотоптар	атом ядросы, радиоактивті ыдырауға шалдығатынн изотоптар.	7
5217	8	Тұрақты изотоптар	атом ядросы, радиоактивті ыдырауға шалдықпаған изотоптар.	7
5218	8	Тұтану температурасы	зат буларының тигельде қыздырылған сұйық жанғыш заттың бетінен қысқа уақытқа жыпылықтауы	7
5219	8	Тығыздық	заттың көлем бірлігінің массасы:	7
5220	8	Ультракүлгін сәуле шығару	көрінетін жарыкқа қарағанда энергиясы жоғары электромагниттік сәулелер.	10
5221	8	Ультракүлгін сәулелену	жарық сәулелерінің энергиясынан көп дененің ұлпаларын зақымдайтын электромагниттік сәулелену	11
5222	8	Фенолдар	гидросиксил тобы бензол сақинасымен тікелей байланысқан органикалық қосылыстар.	11
6303	14	Алгоритм	іс-әрекет ретін сипаттайтын нұсқамалар жиынтығы	5
5223	8	Фенолфталеин	үшфенилметан бояғышы, қышқыл-негіз индикаторы, түссізден қызыл-күлгінге, «таңқурайға» pH>12 болғанда индикатор қайтадан түссіз болады.	7
5224	8	Ферменттер	барлық тірі организмдер құрамына кіретін арнайы нәруыздар, химиялық реакцияларды жеделдетеді.	11
5225	8	Физикалық құбылыс	заттың өзгермелі физикалық күйі (булануы, балқуы, электр өткізгіштігі, жылу мен жарықтың бөлінуі, иілгіштігі және т.б.) немесе атом ядроларының құрамының өзгеруімен жаңа заттардың түзілуі.	9
5226	8	Физикалық құбылыс	заттың өзгермелі физикалық күйі (булануы, балқуы, электр өткізгіштігі, жылу мен жарықтың бөлінуі, иілгіштігі және т.б.) немесе атом ядроларының құрамының өзгеруімен жаңа заттардың түзілуі.	1
5227	8	Фосфор	элементтердің периодтық жүйесінің В тобындағы химиялық элемент, реттік нөмірі – 15, атомдық массасы 30,97.	7
5228	8	Фосфор қыщқылы	Түссіз кристалды, суда жақсы еритін улы емес зат	7
5229	8	Фотосинтез	жасыл жапырақ органоидтері, яғни хлоропласт арқылы күн сәулесі энергиясының химиялық байланыс энергиясына айналу процесі.	7
5230	8	Фракциялық айдау	сұйықтықтардың өзара еритін қоспасын фракцияға, бір бірінен және бастапқы қоспадан да қайнау температурасымен айырмашылығы болатын, бөлу процесі.	7
5231	8	Фрууктоза	моносахаридтер тобына жататын тәтті зат (сахарозадан 1,5 есе, қант құрағынан 3 есе тәтті); глюкозаның изомері.	7
5232	8	Фтор	элементтердің периодтық кестесінің  атомдық нөмірі 9, атомдық массасы 18,998 галогендер тобына жататын химиялық элемент.	7
5233	8	Функционалды топ	берілген заттың химиялық қасиеттерін анықтайтын атомдар тобы, мысалы, спирттерде гидроксотоптар.	10
5234	8	Халькогендер	VI топтың негізгі топшасының химиялық элементтері.	8
5235	8	Халькогендер	VI топтың негізгі топшасының химиялық элементтері.	9
5236	8	Химия	1) заттар және олардың түрленуі туралы ғылым; 2) заттар, олардың түрлену заңдылықтары (физикалық және химиялық қасиеттері) және қолданылуы туралы ғылым.	7
5237	8	Химия	1) заттар және олардың түрленуі туралы ғылым; 2) заттар, олардың түрлену заңдылықтары (физикалық және химиялық қасиеттері) және қолданылуы туралы ғылым.	8
5238	8	Химия	1) заттар және олардың түрленуі туралы ғылым; 2) заттар, олардың түрлену заңдылықтары (физикалық және химиялық қасиеттері) және қолданылуы туралы ғылым.	9
5239	8	Химия	1) заттар және олардың түрленуі туралы ғылым; 2) заттар, олардың түрлену заңдылықтары (физикалық және химиялық қасиеттері) және қолданылуы туралы ғылым.	10
5240	8	Химия	1) заттар және олардың түрленуі туралы ғылым; 2) заттар, олардың түрлену заңдылықтары (физикалық және химиялық қасиеттері) және қолданылуы туралы ғылым.	11
5241	8	Химиялык кұбылыстар	атомдар ядроларының құрамы өзгермей бастапқы заттардан жаңа заттар түзілетіи құбылыс.	9
5242	8	Химиялык кұбылыстар	атомдар ядроларының құрамы өзгермей бастапқы заттардан жаңа заттар түзілетіи құбылыс.	1
5243	8	Химиялық байланыс	электрондардың алмасуы немесе электрондардың бір атомнан екінші атомға ауысуы арқылы жүзеге асырылатын атомдардың өзара әрекеттесуі.	8
5244	8	Химиялық байланыс	электрондардың алмасуы немесе электрондардың бір атомнан екінші атомға ауысуы арқылы жүзеге асырылатын атомдардың өзара әрекеттесуі.	9
5245	8	Химиялық байланыс	электрондардың алмасуы немесе электрондардың бір атомнан екінші атомға ауысуы арқылы жүзеге асырылатын атомдардың өзара әрекеттесуі.	10
5246	8	Химиялық байланыс түрі	атомдарды молекулаларға, радикалдарға, кристалдарға біріктіретін коваленттік, иондық, металдық түрі.	8
5247	8	Химиялық байланыс түрі	атомдарды молекулаларға, радикалдарға, кристалдарға біріктіретін коваленттік, иондық, металдық түрі.	9
5248	8	Химиялық кинетика	реакцияның жүру мехннизмі мен жылдамдығын зерттейтін ілім.	8
5249	8	Химиялық кинетика	реакцияның жүру мехннизмі мен жылдамдығын зерттейтін ілім.	9
5250	8	Химиялық реакция	бастапқы заттардың молекулалары жойылып, жаңа заттардың молекулалары түзілетін процесс, яғни бір заттың басқа затқа айналуы.	8
6304	14	Бактерия	түрлі ауру тудыратын микроағзалар	5
5251	8	Химиялық реакция	бастапқы заттардың молекулалары жойылып, жаңа заттардың молекулалары түзілетін процесс, яғни бір заттың басқа затқа айналуы.	9
5252	8	Химиялық реакцияға түскен барлық заттардың массасы	барлық реакция өнімдерінің массасына тең шама.	9
5253	8	Химиялық реакциялардың жылдамдығы	біртекті жүйелер үшін әрекеттесуші заттардың концентрациясының уақыт бірлігіндегі өзгерістерінің қатынасы.	8
5254	8	Химиялық реакциялардың жылдамдығы	біртекті жүйелер үшін әрекеттесуші заттардың концентрациясының уақыт бірлігіндегі өзгерістерінің қатынасы.	9
5255	8	Химиялық реакцияның теңдеуі	химиялық реакцияны формулалар және математикалық таңбалар көмегімен шартты түрде өрнектеу.	8
5256	8	Химиялық реакцияның теңдеуі	химиялық реакцияны формулалар және математикалық таңбалар көмегімен шартты түрде өрнектеу.	9
5257	8	Химиялық тепе-теңдік	тура реакцияның жылдамдығы кері реакция жылдамдығына тең болатын жүйенің күйі.	8
5258	8	Химиялық тепе-теңдік	тура реакцияның жылдамдығы кері реакция жылдамдығына тең болатын жүйенің күйі.	9
5259	8	Химиялық тепе-теңдік	тура реакцияның жылдамдығы кері реакция жылдамдығына тең болатын жүйенің күйі.	10
5260	8	Химиялық трансформация	атомдар арасындағы кейбір байланыстың үзілуі және басқаларының түзілу процесі, нәтижесінде реакция өнімдерінің молекулалары бастапқы заттардың молекулаларынан алынады.	9
5261	8	Химиялық формула	химиялық жеке заттар молекуласының құрамын химиялық таңба және сан арқылы белгілеу.	7
5262	8	Химиялық формула	химиялық жеке заттар молекуласының құрамын химиялық таңба және сан арқылы белгілеу.	8
5263	8	Химиялық элемент	1)  ядро зарядтары бірдей атомдар түрі; 2) ядролардың белгілі зарядтарымен және электрондық қабаттардың құрылымымен сипатталатын атомдардың түрі.	8
5264	8	Химиялық элемент	1)  ядро зарядтары бірдей атомдар түрі; 2) ядролардың белгілі зарядтарымен және электрондық қабаттардың құрылымымен сипатталатын атомдардың түрі.	9
5265	8	Химиялық энергия	атомның немесе молекуланың ішкі құрылымындағы энергия.	7
5266	8	Хлор	элементтердің периодтық кестесінің атомдық нөмірі 17, атомдық массасы 35,45, молекуласы 2 атом, тығыздығы 0,3214 г/см3, балқу температурасы 101°С болатын және галогендер тобына жататын өткір иісті сарғылт, жасыл түсті улы газ.	7
5267	8	Хунд ережесі	бір энергетикалық ішкі деңгей ішінде электрондар орбитальдарда жұпталмаған электрондар саны максимум болатындай таралады.	8
5268	8	Хунд ережесі	бір энергетикалық ішкі деңгей ішінде электрондар орбитальдарда жұпталмаған электрондар саны максимум болатындай таралады.	9
5269	8	Целлюлоза	негізгі құрам бөліктері өсімдіктер жасушаларының қабығын түзетін үлкен молекулалы көмірсу (полисахарид).	7
5270	8	Циклді қосылыстар	тізбектері тек көміртек атомдарынан құралса карбоциклді, ал көміртек атомдарымен бірге циклде басқа элементтердің де атомдары азот, күкірт және т.б. болса гетероциклді болады.	11
5271	8	Шикі мұнай	тікелей ұңгымадан (скважинадан) алынған мұнай.	10
5272	8	Шойын	темірге көміртек (< 2%), марганец (< 1,5%), кремний (< 4,5%), күкірт (< 0,08%), фосфор (< 1,8%) және  басқа элементтерді қосып алатын құйма.	7
5273	8	Ыдырау реакциясы	бір күрделі заттан екі (немесе одан да көп) зат түзілетін химиялық реакция.	8
5274	8	Ыдырау реакциясы	бір күрделі заттан екі (немесе одан да көп) зат түзілетін химиялық реакция.	9
5275	8	Экзотермиялық реакциялар	жылу бөле жүретін химиялық реакциялар.	8
5276	8	Экзотермиялық реакциялар	жылу бөле жүретін химиялық реакциялар.	9
5277	8	Элекгролиттік днссоциацяя	суда еріткенде немесе балқытқанда заттардың иондарға ыдырауы, нәтижесінде катондар мен аниондар тузіледЕ	8
5278	8	Элекгролиттік днссоциацяя	суда еріткенде немесе балқытқанда заттардың иондарға ыдырауы, нәтижесінде катондар мен аниондар тузіледЕ	9
5279	8	Элекгртерістілік	химиялық қосылыстағы бір химиялық элеменг атомның екінші элемент атомының валенттілік элекгрондарын өзіне тарту кабілеті.	10
5280	8	Электролит	ерітіндісі немесе балқымасы электр тогын өткізетін зат	8
5283	8	Электролиттік диссоциация	электролиттің ерітіндідегі немесе балқымадағы иондарға ыдырау (диссоциациялану) қабілеті.	8
5284	8	Электролиттік диссоциация	электролиттің ерітіндідегі немесе балқымадағы иондарға ыдырау (диссоциациялану) қабілеті.	9
5285	8	Электролиттік диссоциациялану дәрежесі	диссоциацияланған молекулалар санының еріген зат молекулаларының жалпы санына қатынасы.	8
5286	8	Электролиттік диссоциациялану дәрежесі	диссоциацияланған молекулалар санының еріген зат молекулаларының жалпы санына қатынасы.	9
5287	8	Электрон	1) массасы өте аз және теріс зарядталған бөлшек; 2) екі жақты сипат көрсетеді: ол материя сияқты және энергия (толқын) сияқты әрекет ете алады.	8
5288	8	Электрон	1) массасы өте аз және теріс зарядталған бөлшек; 2) екі жақты сипат көрсетеді: ол материя сияқты және энергия (толқын) сияқты әрекет ете алады.	9
5289	8	Электрон	1) массасы өте аз және теріс зарядталған бөлшек; 2) екі жақты сипат көрсетеді: ол материя сияқты және энергия (толқын) сияқты әрекет ете алады.	10
5290	8	Электрондық қабат	атом ядросының айналасындағы электрондардың жиынтығы.	8
5291	8	Электрондық қабат	атом ядросының айналасындағы электрондардың жиынтығы.	9
5292	8	Электрондылық	элементтің электрондарды тарту қабілеті.	8
5293	8	Электронның спині	электронның магнит өрісіне қатынасын сипаттайтын қасиеті.	8
5294	8	Электронның спині	электронның магнит өрісіне қатынасын сипаттайтын қасиеті.	9
5295	8	Электрофил	оң зарядталған бөлшек.	11
5296	8	Электрөткізгіштік	электр өрісі өзгермеген жағдайда заттың тұрақты электр тогын өткізу қабілеті.	7
5297	8	Электртерістілік	элементтің сыртқы электрон қабатын толықтыруға ұмтылысын сипаттайтын шаманы айтады.	7
5298	8	Элемент	ядро ​​заряды бірдей атом түрі.	7
5299	8	Элемент	ядро ​​заряды бірдей атом түрі.	8
5300	8	Элементар бөлшектер	атомды құрайтын бөлшектер: электрондар, нейтрондар, протондар.	8
5301	8	Элементар бөлшектер	атомды құрайтын бөлшектер: электрондар, нейтрондар, протондар.	9
5302	8	Элементтің атомдық нөмірі	ядродағы протон сандарына немесе атомның энергетикалық деңгейлеріндегі барлық электрондардың санына тең сан.	8
5303	8	Элементтің атомдық нөмірі	ядродағы протон сандарына немесе атомның энергетикалық деңгейлеріндегі барлық электрондардың санына тең сан.	9
5304	8	Элементтің атомдық нөмірі	ядродағы протон сандарына немесе атомның энергетикалық деңгейлеріндегі барлық электрондардың санына тең сан.	10
5305	8	Элементтің реттік нөмірі	оның ядросының заряды атомдағы электрондар мен протондардың санына (тең) сәйкес	8
5306	8	Элементтің реттік нөмірі	оның ядросының заряды атомдағы электрондар мен протондардың санына (тең) сәйкес	9
5307	8	Элементтің салыстырмалы атомдық массасы	осы элемент массасы атомдық масса бірлігінен неше есе ауыр екенін көрсететін шама.	8
5308	8	Элементтің салыстырмалы атомдық массасы	осы элемент массасы атомдық масса бірлігінен неше есе ауыр екенін көрсететін шама.	9
5309	8	Элементтің салыстырмалы атомдық массасы	осы элемент массасы атомдық масса бірлігінен неше есе ауыр екенін көрсететін шама.	10
5310	8	Элсктрофилдер	оң зарядты бөлшектер.	10
5311	8	Эндотермиялық реакциялар	жылу сіңіре жүретін химиялық реакциялар.	8
5312	8	Эндотермиялық реакциялар	жылу сіңіре жүретін химиялық реакциялар.	9
5313	8	Энергетикалық деңгейлер	энергия қорының шамасына қарай ядродан әртүрлі қашықтықта электрондар орналаса алатын кеңістіктің бөлігі.	8
5314	8	Энергетикалық деңгейлер	энергия қорының шамасына қарай ядродан әртүрлі қашықтықта электрондар орналаса алатын кеңістіктің бөлігі.	9
5315	8	Энергия	материя қозғалысының әртүрлі формасының жалпы өлшеуіші.	7
5316	8	Энтальпия	заттың энергетикалық жағдайын сипаттайтын энергия, ол ішкі энергия мен ішкі кедергіні (жұмыс, ұлғаю) жоюға жұмсалатын энергиядан тұрады.	10
5317	8	Энтропия	материалды жүйенің күйі мен оның өзгеру мүмкіндігін сипаттайды.	10
5318	8	Этерификация	карбон қышқылдары мен спирттер арасындағы күрделі эфир мен су түзілетін алмасу реакциясы.	10
5319	8	Ядро	жануарлар мен өсімдіктер жасушаларының ең маңызды құрам бөлігі, тұқым қуалаушылық ақпараттың сақталуы және осыған байланысты жасуша цитоплазмасындағы белоктар мен\n ферменттердің түзілуін қамтамасыз етеді.	7
5320	8	Ядро	жануарлар мен өсімдіктер жасушаларының ең маңызды құрам бөлігі, тұқым қуалаушылық ақпараттың сақталуы және осыған байланысты жасуша цитоплазмасындағы белоктар мен\n ферменттердің түзілуін қамтамасыз етеді.	8
5321	8	Ядро заряды	Ядро заряды (  ) Д.И.элементтердің периодтық кестесіндегі химиялық элементтің орнын анықтайды,  Z - ядродағы протондар саны,    - электрон зарядына тең болатын протон заряды.	7
6201	13	Лауазымдық өкілеттікті теріс пайдалану	адам өзі немесе басқа адамдар немесе ұйымдар үшін пайда мен артықшылықтар алуға лауазымдық өкілеттігін пайдалануы	11
6202	13	Пара	адамның лауазымды тұлғаға қызметі үшін айырбас ретінде құнды зат беруі	11
6203	13	Сыбайлас жемқорлық құқықбұзушылық	сыбайлас жемқорлыққа немесе сыбайлас жемқорлыққа жағдай туғызуға байланысты құқыққа қарсы әрекеттер	11
6204	13	Сыбайлас жемқорлыққа байланысты құқықбұзушылық субъектілері	мемлекеттік қызметтерді орындауға уәкілетті адамдар және оларға теңестірілген адамдар, жауапты мемлекеттік лауазымды атқаратын адам, лауазымды адам	11
6205	13	Сыбайлас жемқорлық құқықбұзушылық	сыбайлас жемқорлық белгілері бар құқыққа қайшы, кінәлі түрдегі іс-әрекет (әрекет немесе әрекетсіздік)	11
6305	14	Гигиена	денсаулықты сақтау үшін денеге жасалатын күтім	5
6306	14	Дегустация	дәмі мен иісі арқылы сапасын анықтап, түрлі тағамдар мен сусындарды бағалау	5
6307	14	Декор	безендіру	5
6308	14	Жанр	өзіндік ерекше белгілері бар (портрет, натюрморт, пейзаж және т. б.) туындылардың түрі	5
6309	14	Интерьер	үй-жайдың ішкі жайластырылуы	5
6310	14	Картина	кенеп, қағаз, картонда және т. б. бояумен салынған кескіндеме туындысы	5
6311	14	Композиция	бөлшектерден тұтасты құру	5
6312	14	Контраст	заттардың қандай да бір қасиеттеріне (өлшемі, пішіні, түсі, жарық пен көлеңке үйлесіміне және т. б.) байланысты өзгерісі	5
6313	14	Лекало	қағаз, картон немесе металдан жасалған бөлшек	5
6314	14	Лупа	ұсақ заттарды үлкейтіп көруге арналған шыны	5
6315	14	Макет	алдын ала жасалған үлгі немесе бір нәрсенің кішірейтілген көшірмесі	5
6316	14	Мастихин	пышақ не қалақша пішінді жұқа, оңай иілетін болат тілімше	5
6317	14	Мережка	матаның жіптері суырылған жерлеріндегі селдір кесте	5
6318	14	Модуль (оригамиде)	жалпының бір нәрсе жасалатын бөлігі	5
6319	14	Мозаика	материалы, пішіні мен түсі бірдей немесе әртүрлі элементтен жасалған өрнек	5
6320	14	Оригами	қағаздан түрлі пішін жасайтын көне өнер түрі	5
6321	14	Пастель	кескіндеме техникасы; бұдырмақ қағаз бетінде бор не қарындашпен сурет салу	5
6322	14	Пластика	мүсінді иілмелі, тұтқыр материалдардан сомдау	5
6323	14	Пропорция	көркем туындының, сәулет құрылысының барлық бөлшегінің бір-біріне сәйкестігі, үйлесімділігі, тұтастығы	5
6324	14	Профилактика	аурудың алдын алу, иммунитетті арттыру мақсатында жасалатын кешенді іс-шара	5
6325	14	Рацион	белгілі мерзімге арналған (тәуліктік, апталық және т. б.) тағамның шамасы мен құрамы	5
6326	14	Репродукция	қандай да бір суретті фотосурет немесе полиграфия көмегімен жаңғырту	5
6327	14	Ришелье	шеттері торланған кертіктерден тұратын матадағы селдір өрнек	5
6328	14	Фиксация (белгілеу)	бірдеңені белгілі бір қалыпта бекіту	5
6329	14	Фрагмент	бүтіннің бір бөлігі	5
6330	14	Электрод	электр тоғын өткізуші	5
6331	14	Энергия	материяның негізгі қасиеттерінің бірі, оның қозғалысының өлшемі, сонымен қатар жұмыс өңдіру қабілеті	5
6332	14	Эскиз	алдын ала жасалған нобай	5
6333	14	Эстетика	әсемдік, әдемілік	5
6334	14	Автопортрет	суретшінің өзін-өзі салған бейнесі, графика, мүсін, суреттегі портрет жанрының бірі	6
6336	14	Графика	сызық, штрих, дақ, нүктелер (түс те қолданылуы мүмкін) негізгі құралдар ретінде қолданылатын бейнелеу өнерінің түрі	6
6337	14	Декорация	бұйымды не бөлмені сәндеу	6
6338	14	Колорит	өңі, түстің қанықтығы бойынша картинадағы түстердің үйлесімі	6
6339	14	Портрет	шынайы өмірдегі адамның не бұрын болған бір, не бірнеше адамның түрлі құралдармен (кескіндеме, графика, мүсін, фотосурет) бейнеленген суреті	6
6340	14	Репродукция	өнер туындыларын суретке түсіру, клише жасау (көшіру) немесе түпнұсқаны өз қолымен салу арқылы қайта жасау	6
6341	14	Сценарий	кино немесе телефильм түсіруге арналған әрекеттер мен репликалар егжей-тегжейлі баяндалатын драмалық шығарманың, сондай-ақ қойылым, спектакльдің қысқаша желісі	6
6342	14	Тауматроп	екі жағында да суреті бар дөңгелек қағазды тез айналдырған кезде тұтасып, бір сурет болып көрінетін оптикалық иллюзияға негізделген ойыншық	6
6343	14	Фактура	нысан бетінің сипаты, бедерлілігі	6
6344	14	Флипбук	парақтаған кезде қозғалыс иллюзиясын тудыратын суреттер жиынтығынан тұратын кішкентай кітап	6
6345	14	Фон	сурет салынатын орынның негізгі түсі, реңкі, суреттің артқы жағы	6
6346	14	Фотоөнер	фотографияның бейнелеу құралдарын қолданатын өнер түрі	6
6347	14	Штрих	жіңішке қысқа сызық	6
6348	14	Эксперимент	ғылыми тәжірибе, бұрын болмаған, жаңа бір әрекет орындауға ұмтылу	6
\.


--
-- TOC entry 3748 (class 0 OID 19035)
-- Dependencies: 241
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, subject) FROM stdin;
1	Ақп ком технологиялары
2	Жаратылыстану
3	Математика
4	Алгебра
5	Физика
6	География
7	Информатика
8	Химия
9	Қазақ тілі
10	Әдебиеттік оқу
11	Қазақ әдебиеті
12	Құқық негіздері
13	Көркем еңбек
\.


--
-- TOC entry 3738 (class 0 OID 18297)
-- Dependencies: 231
-- Data for Name: synamizer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synamizer (id, words, words_family, status, meaning, pos) FROM stdin;
491	аралас	сын есім	бірмағыналы	Екі не одан да көп нәрселердің бірігіп, қосылып кетуі не өзара қарым-қатынасқа түсу, қатынаста болу .	2
1	сайлау	зат есім	омоним	 мақсаты мен нәтижесі белгілі бір уақытқа басқару және шешім қабылдау қызметтерін жүзеге асыратын адамдарды сайлау жолындағы іс-әрекеттің жиынтығы.	1
3	сайлау 	сын есім	омоним	аздап сай, сайлылау.	2
1108	маңызды	сын есім	бірмағыналы	заттың немесе әрекеттің қажеттілігін білдіру көрсеткіші	2
1109	ықпал ету	етістік	бірмағыналы	жалпылау, болжау, бағалау 	5
1110	салыстырмалы	сын есім	бірмағыналы	жалпылау, бағалау, болжау мақсатында пайдаланатын сөз	2
1111	үгіт	зат есім	бірмағыналы	сайлау барысында халықпен жұмыс істеу тәсілі	1
1112	сайлау қорытындысы	зат есім	бірмағыналы	сайлаудың нәтижесі мағынасында	1
1113	либералды	сын есім	бірмағыналы	жеке еркіндікті басты құндылық ретінде ұстану	2
1114	сараптама жасау	етістік	бірмағыналы	белгілі бір құбылысты зерттеу, оған баға беру	5
1115	консервативті	сын есім	бірмағыналы	дәстүрлі әлеуметтік құндылықтарды қорғау бағыты	2
1116	плюрализм	зат есім	бірмағыналы	пікірдің саналуандығын білдіру	1
1117	азаматтық қоғам	зат есім	бірмағыналы	мемлекет ісінде азаматтардың белсенді болуы 	1
1118	электорат	зат есім	зат есім	дауыс беру құқығы бар әлеумет	1
1119	саяси технологиялар	зат есім	бірмағыналы	саясатта белгілі бір нәтижеге қол жеткізге бағыталған әдіс-тәсілдердің жиыны	1
1120	өркениет	зат есім	бірмағыналы	қоғамның материалдық және рухани жетістіктерінің жиынтығы	1
1121	жершілдік	зат есім	бірмағыналы	жер принципі бойынша қоғамда бөліну 	1
1122	рушылдық	зат есім	бірмағыналы	туыстық принципі бойынша бөліну	1
1123	тұжырымдама	зат есім	бірмағыналы	ұғымдар мен көзқарастардың орамды жиынтығы	1
1124	тиімді	сын есім	бірмағыналы	пайдалы деген ұғымда	2
1125	жергілікті	сын есім	бірмағыналы	белгілі бір территориялық аймаққа байланыстылығын білдіру	2
1126	ауылдық округ	зат есім	бірмағыналы	ең кіші әкімшілік бірлік	1
1128	саяси бәсеке	зат есім	бірмағыналы	билік үшін партиялар мен кандидаттар арасындағы тартыс	1
1129	сайлау участкесі	зат есім	бірмағыналы	сайлау процессін белгілі бір территориялық аймақта ұйымдастыру	1
1131	көзқарас	зат есім	бірмағыналы	тұлғаның белгілі бір нәрсеге немесе құбылысқа байланысты ой-пікірі	1
1132	әралуан	сын есім	бірмағыналы	әртүрлі мағынасында	2
1133	жұмыссыздық	зат есім	бірмағыналы	 халықтың бір бөлігінің жұмыссыз болуы	1
1134	жалпыхалықтық	зат есім	бірмағыналы	барлық халыққа ортақ мағынасында	1
1135	әкімшілік-аумақтық	зат есім	бірмағыналы	мемлекеттің аумақтық үйымдастырылу жүйесі	1
1136	элиталық	сын есім	бірмағыналы	халықтың таңдамалы бөлігі	2
1137	саяси бәсекелестік	зат есім	бірмағыналы	саяси топтардың билікке тартысы	1
1138	әрқилы	сын есім	бірмағыналы	әртүрлі мағынасында	2
1139	демократия индексі	зат есім	бірмағыналы	көрсеткішті білдіреді	1
1140	заманауи	сын есім	бірмағыналы	даму түрғысынан уақыттың соңғы мерзімі	2
1141	заң ережелері	зат есім	бірмағыналы	заңның талаптары мағынасында	1
1142	мандат	зат есім	бірмағыналы	саясатта сайлау органына немесе сайланған тұлғаға берілетін құқық	1
1143	үміткер	зат есім	бірмағыналы	лауазымға өту мақсатында конкурсқа немесе сайлауға  қатысушы	1
1144	сәйкестілік	зат есім	бірмағыналы	өзара ұқсастық мағынасында	1
1145	пропорционалдық жүйе	зат есім	бірмағыналы	партиялық жүйе арқылы сайлау системасы	1
1146	оппозиция	зат есім	бірмағыналы	саясатта немесе пікірталастағы қарсы тарап	1
18	сұрақ-жауап 	зат есім	бірмағыналы	Алдын ала даярлап, қағазға жазылып қойылған сұрақтарға жауап қайтарылатын ісқағазы; анкета	1
19	кездесу 	етістік	бірмағыналы	Кездес етістігінің қимыл атауы; жолығу, ұшырату. 	5
20	республикалық референдум	зат есім	бірмағыналы	 хабарлауға тұратын нәрсе, аса маңызды мемлекеттік немесе қоғамдық мәселе бойынша сұрау салу немесе дауыс беру арқылы сайлаушылардың бүкілхалықтық еркін білдіруі. 	1
21	жарлық	зат есім	бірмағыналы	мемлекет басшысымен шығарылатын маңызды актілердің атауы.	1
22	Үгіт 	зат есім	бірмағыналы	Әңгіме, баяндама өткізу арқылы, бұқараға саяси әсер етудің құралы	1
23	акт	зат есім	бірмағыналы	Белгілі бір оқиғаны растайтын жазба құжат . 	1
24	әкім	зат есім	бірмағыналы	Қазақстан Республикасының Президенті тағайындайтын Қазақстан Республикасындағы территориялық бірліктегі жоғары лауазымдық тұлға.	1
25	заң	зат есім	бірмағыналы	тұтас алғанда барлық нормативтік-құқықтық актілер, мемлекет тағайындалған барлық жалпы міндетті тәртіптер. 	1
26	Конституциялық заң	зат есім	бірмағыналы	 ҚР Конституциясында конституциялық деп аталған, ҚР Конституциясы 62-бабының 4-тармағында белгіленген тәртіппен қабылданатын заң	1
27	толықтыру	етістік	бірмағыналы	Жетілдіру мақсатымен заңға қосымша өзгерістерді енгізу	5
28	енгізу	етістік	бірмағыналы	Қолданысқа кіргізу, тәжірибеге пайдалану.	5
29	жоба	зат есім	бірмағыналы	тиісті талаптарға сәйкес мақсаттарға жету үшін қолға алынатын, уақыт, құн және ресуртар жағынан шектеулері бар, бастапқы және соңғы күндеріне дейін белгіленген бағдарды әрі басқарылатын жұмыстар жиынтығынан құралған айрықша үдеріс.	1
30	баяндалған	етістік	бірмағыналы	Суреттеу арқылы оқиға мен сюжетті баяндау.\n	5
31	көрсетілген	етістік	бірмағыналы	Көрсетіл етістігінің қимыл атауы, бейнелену, айқындалу.	5
32	өткізу	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы.	5
33	азамат	зат есім	бірмағыналы	 Кәмелетке толып, ер жеткен адам	1
34	ерікті	сын есім	бірмағыналы	Өз еркі өзінде, ықтиярлы; құқылы, тәуелсіз іс-әрекеттер мен адамды сипаттайды.	2
35	жасырын	сын есім	бірмағыналы	Ашық түрде емес, құпия жасалынатын іс-әрекеттерді сипаттайды.	2
36	дауыс беру	етістік	бірмағыналы	бұл ұсынылған үміткерлерді сайлау мәселесі бойынша сайлаушылардың еркін білдіретін, сайлау процесінің шешуші сатысы. Дауыс беру сайлау бюллетені немесе арнайы машиналардың көмегімен жүргізіледі.\n	5
37	тікелей	үстеу	бірмағыналы	Тіке, тұп-тура, бірден.	9
38	негізделеді	етістік	бірмағыналы	Негізге алыну, сүйенілу.\n\n	5
39	әкімдік	сын есім	бірмағыналы	Елге билік жүргізушілік, мансап құрушылық.	2
40	дауыс	зат есім	бірмағыналы	Адамның көмейден шығатын, құлаққа естілетін үні .	1
41	тізім	зат есім	бірмағыналы	Адамның, мал-мүлік, дүниенің қағаз бетіне рет-ретімен жазылған аты.	1
42	әзірлеу	етістік	бірмағыналы	Әзірле етістігінің қимыл атауы. Сайлау, қамдау, дайындық жасау.	5
43	құрам	зат есім	бірмағыналы	Белгілі бір әлеуметтік топты құрайтын адамдар (жиынтығы).	1
44	аумақтық	сын есім	бірмағыналы	Белгілі бір аумаққа ғана сәйкес.	2
45	учаскелік 	зат есім	бірмағыналы	Бір аймаққа ғана сәйкес.	1
46	комиссия	зат есім	бірмағыналы	Орыс тілінен келген кірме сөз, арнаулы бір тапсырманы орындау үшін немесе мәселені шешу үшін белгіленген адамдар тобының уақытша немесе үнемі болып тұратын мәжілісі\n	1
47	жариялау	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы. Баспаға беру, бастырту, мәлімдеу, басу	5
48	орналасқан	етістік	бірмағыналы	Орналас етістігінің қимыл атауы.	5
49	жер	зат есім	бірмағыналы	егемендігі белгіленетін шектегі аумақтық кеңістік, табиғи ресурс, жалпыға ортақ өндіріс құралы және кез келген еңбек процесінің аумақтық негізі.	1
50	жұмыс	зат есім	бірмағыналы	Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті. 	1
90	арналған	етістік	бірмағыналы		5
180	санаймын	етістік	бірмағыналы	Сана етістігінің қимыл атауы	5
51	уақыт	зат есім	бірмағыналы	Ол материалдық объектілердің өмір сүруінің ұзақтылығын және сол объектілердің даму процесінде өзгерулерінің (күй – жағдайларының ауысуының) тізбектілігін білдіреді	1
52	мәлімет	зат есім	бірмағыналы	Белгілі бір оқиға не жұмыс жөнінде ауызша немесе жазбаша түрде берілетін ақпарат, дерек.	1
53	тағайындалған	етістік	бірмағыналы	Сайлану/сайланған деген мағынаны білдіреді.	5
54	күн	зат есім	бірмағыналы	Таңның атысынан, күннің батуына дейінгі аралық	1
55	кешіктірілмей	етістік	бірмағыналы	Кешіктіріл етістігінің қимыл атауы, болымсыз түрі. 	5
56	ақпарат	зат есім	бірмағыналы	маңызды мәліметтер.\n	1
57	қол қояды	етістік	бірмағыналы	Белгілі бір құжат мәтініне жауапты, қатысы бар құзырлы адамның қолтаңбасын жазуы. 	5
58	өзгеріс	зат есім	көпмағыналы	Бір нәрсенің бойындағы жаңалық, бұрынғы күйінен ерекшелеп тұрған айырмашылық.	1
59	өзгеріс	зат есім	көпмағыналы	Ауытқу, өсу, жаңару.	1
60	өзгеріс	зат есім	көпмағыналы	Бойлама осьтің айналасымен көкжиекке қатысты алғанда 180º-қа төңкерілген жағдайда ұшақтың шүйліге айналуы.	1
61	сұраныс	зат есім	бірмағыналы	Қажет етушілік, керек затты талап етушілік. 	1
62	қоғам	зат есім	бірмағыналы	адамдар арасындағы тарихи қалыптасқан саяси-әлеуметтік байланыстар мен қатынастардың тұрақты жүйесі.	1
63	мүдде	зат есім	бірмағыналы	қоғамдағы әлеуметтік субъектілер іс-әрекетінің, өмір сүру бағдарының негізі, қозғаушы күші. 	1
64	жүзеге асырылмақ	етістік	бірмағыналы	Бірдеңені іске асыру, жүргізу.	5
65	Ата Заң	зат есім	бірмағыналы	елдің негізгі заңы; ең жоғарғы заң күші бар нормативтік акт.	1
66	заңгер-құқықтанушылар	зат есім	бірмағыналы	Заң ғылымдарын меңгерген маман	1
67	құқық	зат есім	бірмағыналы	азаматтың немесе ұйымның мүддесін қанағаттандыруға байланысты мақсаттарына қол жеткізуге бағытталған болжамды іс-әрекетінің заңмен қамтамасыз етілген шаралары.	1
68	сала	зат есім	көпмағыналы	Ғылым, өнер, әдебиет, мәдениеттің, қоғамның бір арнасы, бөлік, тармағы.	1
69	сала	зат есім	көпмағыналы	Сайдың ашасы, өзен ортасының тарауы.	1
70	сала	зат есім	көпмағыналы	Белгілі бір өнеркәсіптің, шаруашылықтың, өндірістің және т.б. жеке бөлігі, тармағы.	1
71	сала	зат есім	көпмағыналы	Жан-жақ, төрт тарап.	1
72	сала	зат есім	көпмағыналы	Ірірек ағын суға немесе көлге құятын ағын су	1
73	маман	зат есім	бірмағыналы	белгілі бір саланың кәсіпқой қызметі немесе басқа ауқымды мәселесі бойынша құзырлығы бар тұлға.	1
74	Кеңес	зат есім	бірмағыналы	Жергілікті жердегі үкімет орны	1
75	оң	сын есім	бірмағыналы	теріс,сол сөздерінің антонимі	2
76	баға	зат есім	көпмағыналы	Қазақ тілінде «тауардың, қызметтің т.б. нәрселердің ақшаға шаққандағы құны» деген ұғымды білдіреді.	1
77	баға	зат есім	көпмағыналы	білім алушының оқудағы кемшіліктері мен табыстары мен берілген жұмыстың орындалу сапасы туралы пайымдау.	1
78	баға	зат есім	көпмағыналы	Адамның қадір-қасиеті, парқы.	1
79	беру	етістік	көпмағыналы	Бер етістігінің қимыл атауы.  Өнім өндіру, шығару. 	5
80	беру	етістік	көпмағыналы	Бер етістігінің қимыл атауы. Теледидардан көрсету, радиодан айту.	5
81	мақсат	зат есім	көпмағыналы	Белгілі бір нысанаға жету жолында қойылған міндет, нысана.	1
82	мақсат	зат есім	көпмағыналы	Белгілі бір нысанаға жету жолында қойылған міндет, нысана.	1
83	мақсат	зат есім	көпмағыналы	Алда орындалатын әрекет нәтижесінің айқын бейнесі.	1
84	мақсат	зат есім	көпмағыналы	Ойлау процесі нәтижесінде алдын ала болжау арқылы туатын мұрат, ішкі қозғаушы күш. 	1
85	көздеу	етістік	бірмағыналы	Көзде етістігінің қимыл атауы.	5
86	үдеріс	зат есім	көпмағыналы	Қауырт қозғалыс, қарбалас.	1
87	үдеріс	етістік	көпмағыналы	Шошу, қорқу.	5
88	негіз	зат есім	бірмағыналы	Табан тірер, сүйеніш етер тірек, таяныш; жай-күй, жағдай.	1
89	қалыптастыру	етістік	бірмағыналы	Бір заттың күйін, қалпын қолдан жасау, қалыптастыру	5
116	қорғау	етістік	көпмағыналы	Ғылыми тұрғыда	5
91	Президент	зат есім	көпмағыналы	елбасы;  кейбір республикада белгілі бір мерзімге сайланған мемлекет басы	1
92	Президент	зат есім	көпмағыналы	қоғам мен немесе мекемеге басшылық жасау үшін сайланған төраға, мысалы ғылым академиясының президенті.	1
93	басқару	етістік	бірмағыналы	Әр алуан ортаның (әлеуметтік, биологиялық, техникалық) белгілі бір құрылымын сақтап, әрекет ету режимін қолдау, олардың мақсат-мұраттарын жүзеге асыруды қамтамасыз ету үшін ұйымдастырылған жүйенің кызметі.	5
94	көшу	етістік	көпмағыналы	Көш етістігінің қимыл атауы	5
95	көшу	етістік	көпмағыналы		5
96	билік	зат есім	көпмағыналы	Басқарушылық, басшылық, әкімшілік.	1
97	билік	зат есім	көпмағыналы	Үкімет, мемлекетті басқару органы.	1
98	билік	зат есім	көпмағыналы	Мансап	1
99	өкілеттік	сын есім	бірмағыналы	Толық құқықтылық	2
100	қайта бөлу	етістік	бірмағыналы	Бөл етістігінің қимыл атауы.	5
101	рөл	зат есім	көпмағыналы	Актердің театрда ойнайтын әдеби бейнесі.	1
102	рөл	зат есім	көпмағыналы	 Маңыз, мән, қызмет. 	1
103	күшейту	етістік	бірмағыналы	Күшейт етістігінің қимыл атауы	5
104	 мәртебе	зат есім	бірмағыналы	топтағы адамның топ мүшелеріне қатысты тұрғысы.	1
105	арттыру	етістік	бірмағыналы	Бір нәрсенің қарқыны,  қалпі бұрынғыдан жақсара түсу, түзелу.  Істің сапасын жақсарту, жоғарылату.	5
106	ел	зат есім	бірмағыналы	Қауымдастық не шекарасы нық бекіген мемлекет.	1
107	іс	зат есім	бірмағыналы	Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті.	1
108	қатысу	етістік	көпмағыналы	Процесті өз көзімен көру, ішінде болу.	5
109	қатысу	етістік	көпмағыналы	Араласу, қатынасу.	5
110	қатысу	етістік	көпмағыналы	Оқушының, студенттің т.б. тыңдаушының дәрісханадағы сабаққа араласуы, жауап беруі. 	5
111	мүмкіндік	зат есім	бірмағыналы	Бір істің іске асуына туғызылған қолайлы жағдай .	1
112	кеңейту	етістік	бірмағыналы	Бір құбылыстың өзгеріске түсуі,оның үлкейтілуі, ұлғайтылуы.	5
113	қорғау	етістік	көпмағыналы	Аман алып қалу, сақтау, пана болу.	5
114	қорғау	етістік	көпмағыналы	Күту, аялау, қамқорлық жасау.	5
158	қабылданды 	етістік	бірмағыналы	Шығарылған заң немесе шешім қабылданады.	5
159	ант	зат есім	бірмағыналы	Берілген уәдені ант, серт деп те атайды.	1
115	қорғау	етістік	көпмағыналы	Заң жүзінде, заңды тұрғыда. Қылмыс жасады деп сезік келтірілген адамдардың құқықтары мен мүдделерін қамтамасыз ету, айыптауды жоққа шығару, жеңілдету, заңсыз қылмыстықізге түсуге ұшыраған адамдарды ақтау мақсатында қорғау тарабы жүзеге асыратыніс жүргізу қызметі.	5
117	тәсіл	зат есім	бірмағыналы	Белгілі бір істі орындап шығу үшін қолданылатын әдіс, амал, айла.	1
118	жетілдіру	етістік	бірмағыналы	Меңгерту, дамыту, ілгерілету деген мағынады қолданылады.	5
119	айырмашылық	зат есім	бірмағыналы	Қалыптан тыс өзгешелік, ерекшелік.	1
120	нұсқа	зат есім	бірмағыналы	бір заттың көшірмесі, екінші данасы. Қазақ тілінде «бір істің жөні, жобасы», «үлгі, негіз» деген ауыспалы мағыналарда қолданылады.	1
121	жаңа	сын есім	бірмағыналы	Өңі кетпеген, әрі түспеген, ұсталмаған .	2
122	түсіну	етістік	бірмағыналы	Мәніне жету, бағалау.	5
123	байыпты	зат есім	бірмағыналы	Сабырлы деген мағынада қолданылады.	1
124	бару	етістік	бірмағыналы	Бар етістігінің қимыл атауы; алға жылжу, ілгерілеу, қозғалу.	5
125	аз	сын есім	бірмағыналы	Мөлшердің аз көлемде екенін, шағын екенін көрсетеді.	2
126	қиындық	зат есім	көпмағыналы	Азап, бейнет, қиыншылық, ауыртпалық. 	1
127	қиындық	зат есім	көпмағыналы	Жоқшылық, мұқтаждық, тапшылық	1
128	қиындық	зат есім	көпмағыналы	Кедергі, бөгет.	1
129	туғызатын	етістік	көпмағыналы	Жасау, қамтамасыз ету.	5
130	туғызатын	етістік	көпмағыналы	келеңсіздікке бастау, нашар жағдайға ұрындыру, душар ету.	5
131	анық	сын есім	бірмағыналы	Дәл, айқын.	2
132	ұғынықты	сын есім	бірмағыналы	Түсінікті деген сөздің орнына қолданылады.	2
133	түзетулер	зат есім	бірмағыналы	жарияланған материалдың ішінде жіберілген қате туралы оқушыларға ескерту, редакцияның атынан жарияланатын қысқаша хабар.	1
134	нақты	сын есім	бірмағыналы	Анық, тура айтылған ақпарат	2
135	бап	зат есім	бірмағыналы	Кітаптың тарау, бөлімі	1
136	тармақ	зат есім	бірмағыналы	Бір нәрсенің, заттың тарауы, саласы, бөлегі.	1
137	көрсету	етістік	бірмағыналы	Көрсет етістігінің қимыл атауы .	5
138	бөлік	зат есім	көпмағыналы	Бірнешеге бөлінген тұтас нәрсенің бір бөлігі.	1
139	бөлік	зат есім	көпмағыналы	Арнайы берілген, белгіленген орын; бөлім.	1
140	бөлік	зат есім	көпмағыналы	Екі аралықты бөліп тұрған зат, бөлінген жер.	1
141	бөлінген	етістік	бірмағыналы	Бөлшектерге ұсақталған	5
142	сан	зат есім	көпмағыналы	Белгілі бір заттың, құбылыстың есеп мөлшері.	1
143	сан	зат есім	көпмағыналы	Математиканың негізгі ұғымдарының бірі.	1
144	сан	зат есім	көпмағыналы	Есеп мөлшерінің таңбалау, жазу белгісі.	1
145	сан	зат есім	көпмағыналы	Мың деген мағынада.	1
146	сан	зат есім	көпмағыналы	Талай рет, бірнеше мәрте.	1
147	хабар	зат есім	көпмағыналы	Болған іс, оқиға, сондай-ақ біреулердің хал-жайы жөнінде білдірілген қысқаша мәлімет.	1
148	жарамсыз	сын есім	көпмағыналы	Көңіл толмайтын, жағымсыз, қолайсыз, ұнамсыз.	2
149	жарамсыз	сын есім	көпмағыналы	Қабілетсіз, мүгедек, кемтар.	2
150	бюллетень	зат есім	көпмағыналы	Қоғамдық үлкен мәні бар оқиға жайындағы қысқаша ақпараттық хабарлама	1
151	бюллетень	зат есім	көпмағыналы	Библиографиялық, статистикалық, метеорологиялық т.б. арнаулы мәліметтерді жариялайтын мерзімді не мерзімсіз басылым	1
152	бюллетень	зат есім	көпмағыналы	Сайлау кезінде үміткердің аты-жөні тіркелген арнаулы қағаз.	1
153	бюллетень	зат есім	көпмағыналы	 Қызметкерлер мен жұмысшылардың науқастануына байланысты жұмысқа уақытша жарамсыздығы жөнінде мемлекеттік қамсыздандыру жағынан ақшалай жәрдем алатын емхана орны беретін қағаз.	1
154	танылды	етістік	бірмағыналы	Көпшілікке белгілі болды, ел-жұрт білді.	5
155	есептелу	етістік	бірмағыналы	саналу, есепке алыну	5
156	шығарылған	етістік	бірмағыналы	шығармашылықты елестетудің, қиялдаудың нәтижесі.	5
157	маңыз	зат есім	бірмағыналы	Бір нәрсенің өмірдегі орны, мәні, қадірі.	1
160	сауал	зат есім	бірмағыналы	Қазіргі қазақ тілінде «көптен бері жауабын білгісі келіп жүрген сұрақ» (депутаттық сауал, журналистік сауал) ұғымында да қолданылады.	1
161	жүктелсін	етістік	бірмағыналы	Орындалуға тиісті тапсырма берілді. 	5
162	шара	зат есім	бірмағыналы	Арнайы жасалған іс, міндет	1
163	қолданыс	зат есім	бірмағыналы	Пайдалану ісі, әдісі; пайдаға асу үдерісі.	1
164	салынады	етістік	бірмағыналы	Салын етістігінің қимыл атауы.	5
165	тыйым	зат есім	бірмағыналы	Тыйып тастағандық, тежегендік; тоқтам.	1
166	төтенше	сын есім	көпмағыналы	Айрықша, ерекше.	2
167	төтенше	сын есім	көпмағыналы	Шұғыл жағдайларға байланысты.	2
168	пікір	зат есім	бірмағыналы	Өмірдегі құбылыстар мен заттар туралы өзіндік көзқарас, тұжырым, пайымдау.	1
169	сұрады	етістік	бірмағыналы	Сұра етістігінің қимыл атауы; білгісі келу, жауап күту.	5
170	ұсынды	етістік	омоним	жеке құрамды тағайындау, ауыстыру немесе қолдау көрсету туралы ережесі, сондай-ақ қандай да бір бірлікке жататын (бұйым, операция) өндірілген өнім, мекеме қызметіне қатысты белгілі бір әрекет немесе іс-шараны куәландыратын құжат.	5
171	ұсынды	етістік	омоним	Ұсын етістігінің қимыл атауы.	5
172	тіршілік	зат есім	омоним	Күнделікті іс-әрекет, өмір, тірлік.	1
173	тіршілік	зат есім	омоним	 Тірі жүрушілік, аман-саулық.\n	1
174	тіршілік	зат есім	омоним	ауыс, Белгілі бір шаруа, кәсіп.	1
175	маңызды	сын есім	бірмағыналы	Аса құнды, мәнді, маңызы зор.	2
176	шешім	зат есім	бірмағыналы	проблемалық жағдаяттың ойлау операцияларының қалыптасуы.	1
177	білдіру	етістік	бірмағыналы	Білдір етістігінің қимыл атауы	5
181	отырыс	зат есім	бірмағыналы	 Көп адамның бас қосқан жері	1
182	сөйлеген	етістік	бірмағыналы	Адамдардың материалдық өзгертуші іс-әрекеті процесінде тарихи тұрғыда қалыптасқан тіл арқылы болатын қарым-қатынас нысаны	5
183	сөз	зат есім	бірмағыналы	 Белгілі бір мағынасы бар заттар мен құбылыстардың атауын білдіретін тілдің негізгі единицасы	1
184	іске асыру	етістік	бірмағыналы	 Қабылдаған бағдарламаны орындау	5
185	келіспеу	етістік	бірмағыналы	күтілген нәтиже мен шындық арасындағы алшақтық пен айырмашылық	5
186	атап өту 	етістік	бірмағыналы	қталып кету, атап-атап көрсету, ерекше назар аударту	5
187	көлемді 	сын есім	бірмағыналы	Қомақтылық, ауқымдылық	2
188	бүкілхалықтық 	сын есім	бірмағыналы	Барша халыққа ортақ	2
189	бірлік	зат есім	бірмағыналы	Біреу ғана екендік, жалғыздық	1
190	сапа	зат есім	бірмағыналы	Белгілі бір заттың немесе құбылыстың басқа бір заттар мен құбылыстардан өзгеше қасиеті, ерекше айырмасы, белгісі.	1
191	айқын	сын есім	бірмағыналы	бір заттың анық,дәл екенін көрсетеді	2
192	идея	зат есім	бірмағыналы	Белгілі бір нәрсе туралы адам санасында пайда болған жаңаша ой, пікір	1
193	қысқа	сын есім	бірмағыналы	Шолақ, ұзын емес (қашықтық жағынан).	2
194	оңай	сын есім	бірмағыналы	Қиын емес, ауырлығы жоқ, жеңіл. 	2
195	іс	зат есім	бірмағыналы	Қазақ тілінде «саналы түрде мақсатқа жетуге бағытталған іс-қимыл, амал» ұғымында да қолданылады. 	1
196	атап өтті	етістік	бірмағыналы	Қиын емес, ауырлығы жоқ, жеңіл. 	5
197	белгілі	сын есім	бірмағыналы	 Ел ішінде беделді, атақ-даңқы асқан (адам)	2
198	сұрақ	зат есім	бірмағыналы	 Жауап алу, бір-бірімен қарым-қатынас барысында ойларын айқындау үшін қойылатын сұрау, сауал	1
199	реформа	зат есім	бірмағыналы	өмір сүріп отырған әлеуметтік құрылымның негіздерін сақтай отырып, қоғамдық өмірдің кейбір қырларын өзгертіп, қайта құру. 	1
200	референдум	зат есім	бірмағыналы	 аса маңызды мемлекеттік немесе қоғамдық мәселе бойынша сұрау салу немесе дауыс беру арқылы сайлаушылардың бүкілхалықтық еркін білдіруі	1
201	өткізіледі	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы	5
202	ұйымдастыру	етістік	бірмағыналы	Бір істі ұйымдастырған адам	5
203	іс-шара	зат есім	бірмағыналы	өтілуі қажет оқиғалар	1
204	күрделі	сын есім	бірмағыналы	 Неше түрлі бөліктен тұратын, көп құрамды	2
205	басқару жүйесі	зат есім	бірмағыналы	басқару іс-әрекеті мен қызметі жүзеге асатын жүйе.	1
206	айналым	зат есім	бірмағыналы	затты, яки тауарды экспорт, импорт, сатып алу, сақтау, көтерме және бөлшек саудада өткізу.	1
207	жұмыс істейді	етістік	бірмағыналы	. Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті	5
208	кетіретін	етістік	бірмағыналы	кетір етістігінің қимыл атауы.	5
209	тиімді	сын есім	бірмағыналы	белгілі бір заттың ыңғайлы,қолайлы болуы	2
210	тез	сын есім	бірмағыналы	. Тарақ жасаған кезде мүйізді түзетуге арналған аспап, қалып.	2
211	қабылдау керек	етістік	бірмағыналы	Адамдарды бір нәрсенің немесе әлдекімнің құрметіне орай шақыру, жиналыс, кездесу.	5
212	қажеттілік	зат есім	бірмағыналы	жеке адамның, әлеуметтік топтың, қоғамның тіршілік әрекетін қамтамасыз ету үшін объективті түрде керек нәрсеге мұқтаждық;	1
213	жариялаған 	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы.	5
214	сенімдімін	етістік	бірмағыналы	 Сөзге тұрақты, іске берік, сенім артуға болатын	5
215	сарапшылар	зат есім	бірмағыналы	Объектілерді, процесстерді, құбылыстарды бағалау саласында арнайы білімі бар тұлға	1
216	медиа қауымдастық	зат есім	екі мағыналы	(media) – ақпарат және ойын-сауық бағдарламаларын ұсынуды қамтамасыз ететін контент пен тарату механизмі.	1
1147	округ	зат есім	бірмағыналы	әкімшілік немесе сайлау құқықғы таралатын аймаұ	1
217	күш	зат есім	бірмағыналы	Күш деп дененің басқа денелер тарапынан болатын әрекеттің нәтижесінде үдеу алатынын сипаттайтын және осы әрекеттің өлшемі болып табылатын физикалық шаманы айтады.	1
218	сала	етістік	бірмағыналы	Сала  – қызметтің‚ ғылымның‚ өндірістің жеке саласы. 	5
219	жүргізілуі мүмкін	етістік	бірмағыналы	Кемені шлюз арқылы жүргізу. Аралық өткізу. Жаңа темір жол өткізу.	5
220	табу	етістік	бірмағыналы	сценарийлерде, жарнамада жекелеген сөздерді немесе әрекеттерді пайдалануға тыйым салу; демеуші, хабар тарату ұйымы, редакция енгізеді.	5
221	терең	сын есім	бірмағыналы	Түбіне бойламай кететін тұңғиық; шыңырау.	2
222	демократия	зат есім	бірмағыналы	1) жоғарғы өкімет билігі халықтың қолында болатын мемлекет құрылысы; 2) мәселені шешуге барлық ұжым мүшелері қатыстырынын, белгілі бір ұжымды басқару әдісі.	1
223	бағыт	зат есім	бірмағыналы	Бір жаққа қарай бет түзеді, бағытталуды сипаттайды.	1
224	супер-президенттік	сын есім	екімағыналы	Президенттің іс-әрекетін сипаттап айту мақсатымен қолданылады.	2
225	басқару	етістік	бірмағыналы	Әр алуан ортаның (әлеуметтік, биологиялық, техникалық) белгілі бір құрылымын сақтап, әрекет ету режимін қолдау, олардың мақсат-мұраттарын жүзеге асыруды қамтамасыз ету үшін ұйымдастырылған жүйенің кызметі.	5
226	күшті	сын есім	бірмағыналы	Күштің көп болған жағдайдағы сипаттамасы.	2
227	шектеу	етістік	бірмағыналы	сыртқы тежелудің бір түрі. 	5
228	жүйелеу	етістік	бірмағыналы	Бір ретпен тұтастықты құрайтын қатардағы элементтердің жиынтығы, ойлау операцияларының бірі.	5
229	қайтар	етістік	бірмағыналы	Орал деген сөздермен мағыналас келетін іс-әрекетті білдіретін етістік.	5
230	қызмет	зат есім	бірмағыналы	нысанның өзгертілуіне бағытталған, ісәрекеттің мақсатқа бағытталған және нақтыланған жүйесі.\n	1
231	ролі	зат есім	бірмағыналы	мәні, қандай да бір іске, оқиғаға қатысу дәрежесі.	1
232	құру	етістік	бірмағыналы	Құры етістігінің қимыл атауы .	5
233	тепе-теңдік	зат есім	бірмағыналы	Бірдей дәрежеде атқарылатын іс-әрекетті сипаттайды.	1
234	тоқтатылу	етістік	бірмағыналы	Тоқтатыл етістігінің қимыл атауы.	5
235	аралас пропорционалды - мажоритарлы	сын есім	бірмағыналы	Аралас сайлау жүйесі-мажоритарлық пропорционалды жүйе.	2
236	модель	зат есім	бірмағыналы	араларында өзара әрекеттестік туындайтын және танымдық белсенділікті ынталандыруға арналған жағдайлар қалыптасатын ірі жүйелер бірлігі.	1
237	тіркеу 	етістік	бірмағыналы	Рәсімдеу сөзінің мағыналас сөзі.	5
238	процесі	зат есім	бірмағыналы	1) бір нәрсенің дамуы қалпындағы құбылыстардың кезегімен алмасуы; 2) қандай да бір нәтижеге жету үшін әрекеттердің бірізді жиынтығы.	1
239	ырықтандыру	етістік	бірмағыналы	Ырықтандыр етістігінің қимыл атауы. 	5
240	Еуразиялық	сын есім	бірмағыналы	Еуразия континентіне тән, қыртысты.	2
241	мониторинг	зат есім	бірмағыналы	Бір құбылысты жікті бақылау	1
242	дербестік	зат есім	бірмағыналы	жеке адамның қайталанбайтын, өзіндік болмысы, өзінің субъектісі түрінде оның мақсаты мен мән-мағынасы болатын іс-қимылы	1
243	директоры	зат есім	бірмағыналы	компанияның, кәсіпорынның немесе оқу орнының басқарушысы, басшысы, бастығы	1
244	орталығы	зат есім	бірмағыналы	бір нәрсенің ортасы, негізгі бөлігі немесе нүктесі, сонымен қатар басты орын, елдің маңызды ресурстарының шоғырлануы, аумақтық бірлік, әлеуметтік топ, инфрақұрылым және т. б.	1
245	өткізілетін	етістік	бірмағыналы	қандай да бір оқиғаның болуы	5
246	хабарланған	етістік	бірмағыналы	 Болған жаңалықтарды білу, хабардар болу.	5
247	болатын	етістік	бірмағыналы	болашаұта өтетіін оқиға	5
248	ауыстырылсын	етістік	бірмағыналы	бір затты басқасымен алмастыру	5
249	кеңес	зат есім	Омоним	Нұсқаулық, нұсқау, ұсыныс, қалай жалғастыру керек. 	1
250	кеңес	зат есім	Омоним	белгілі бір мәселелерді бірлесіп талқылау	1
1148	өміршең	сын есім	бірмағыналы	заттың немесе құбылыстың өмірге қабілеттілігі	2
251	Сот	зат есім	бірмағыналы	сот төрелігін жүзеге асыру, құқық бұзушыларға мәжбүрлеу шараларын қолдану жолдарымен қоғамның және азаматтардың құқықтары мен заңды мүдделерін заңсыз қол сұғушылықтан қорғайтын мемлекеттік орган.	1
253	өткiзiлсiн	етістік	бірмағыналы	қандай да бір оқиғаның болуы	5
254	енгізіледі	етістік	бірмағыналы	бір заттың болашақта енгізілуі	5
255	жариялансын	етістік	бірмағыналы	бірдеңкені бәрінің білуі	5
256	белгілейді	етістік	бірмағыналы	бір нәрсені анықтау	5
257	қойылуы мүмкiн	етістік	бірмағыналы	белгілі бір жерге орналасуы	5
258	өзгерту	етістік	бірмағыналы	бір затты екіншісімен ауыстыру	5
259	жасау	етістік	бірмағыналы	белгілі бір тапсырманы орындау	5
260	босату	етістік	бірмағыналы	іс әрекетті орындамаса болады	5
261	бола алмайды	етістік	бірмағыналы	болмау	5
262	орындау	етістік	бірмағыналы	бір әрекетті іске асыру	5
263	бiлдiру	етістік	бірмағыналы	эмоцияны білдіру	5
264	санаймын	етістік	бірмағыналы	Сана етістігінің қимыл атауы	5
265	берiледi	етістік	бірмағыналы	іс әрекеттің өткізілуі	5
266	болуы мүмкін	етістік	бірмағыналы	іс әрекеттің орындалуының мүмкіндігі	5
267	қолдау	етістік	бірмағыналы	моральдық көмек көрсету, сенім ұялату, жігерлендіру	5
268	алып тасталсын	етістік	бірмағыналы	бір затты  тізімнен өшіру	5
269	береді	етістік	бірмағыналы	белгелі бір затты біреуге ұстату	5
270	толықтырылсын	етістік	бірмағыналы	үстіне қосу	5
271	болмауға тиіс	етістік	бірмағыналы	бір істің орындалуына рұқсат етпеу	5
272	тағайындайды	етістік	бірмағыналы	бір орынға басқа адамды қоюы	5
273	тұрады	етістік	көпмағыналы	адамның өзінің айтқан нәрсесін де тұруы	5
275	жүзеге асырылады	етістік	бірмағыналы	бір нәрсені нақты орындау	5
276	айырылады	етістік	көпмағыналы	өзіне керек бір адамнан не заттан айырылу	5
277	қабылдау	етістік	омоним	қолдан қолға алу	5
279	жүргізеді	етістік	бірмағыналы	біреудің қасында жүру, біреуді ертіп жүру, қозғалысты	5
280	білдіреді	етістік	бірмағыналы	мағынасын көрсету	5
281	тыңдау	етістік	омоним	есту арқылы қабылдау, есту үшін кез-келген дыбысқа бағыттау	5
283	ұсынады	етістік	бірмағыналы	біреудің билігіне, қолдануына, біреуге қызмет етуге, бірдеңе жасауға баруға дайын болу немесе тілек білдіру	5
284	жатады	етістік	бірмағыналы	біреумен қарым-қатынаста немесе бір нәрсемен байланыста болудың белгілі бір сипатын көрсету	5
285	болады	етістік	бірмағыналы	болашақта орын алатын оқиға	5
287	қаралу	етістік	бірмағыналы	бір нәрсені байқау, анықтау үшін кез-келген кеңістікті шолу	5
288	қайтарылады	етістік	бірмағыналы	алынған нәрсені қайтару	5
289	беріледі	етістік	бірмағыналы	кез-келген әрекеттің нәтижесінде бірдеңе әкелу, өндіру	5
290	шешіледі	етістік	бірмағыналы	тапсырманы қандай да бір жолмен шешу	5
291	мақұлдайды	етістік	бірмағыналы	қолдайды, жақсы, дұрыс деп есептейді\n	5
292	созылады	етістік	бірмағыналы	белгілі бір заттың жан жаққа тартылуы	5
293	тағайындала алмайды	етістік	бірмағыналы	қалаған жұмысын ала алмады	5
294	сыйыспайды	етістік	бірмағыналы	белгілі бір ортада басқа адамдармен жақындаса алмады	5
295	реттеледі	етістік	бірмағыналы	белгілі тәртіпті, жүйені бір нәрсеге енгізу	5
296	қарайды	етістік	бірмағыналы	бағыттау, біреуге, бір нәрсеге немесе бір жерге қарау	5
297	айқындалады	етістік	бірмағыналы	белгісіз, түсініксіз нәрсені орнату, анықтау	5
298	шығарады	етістік	омоним	өз ойынан жаңа дүние шығарады	5
300	қолданылуға жатпайды	етістік	бірмағыналы	белгілі бір затты ұстамау	5
301	жойылады	етістік	бірмағыналы	деректер жиынтығының өшірілуі	5
302	ықпал етеді	етістік	бірмағыналы	іс әрекеттің ықпал етуі	5
303	тартуға болмайды	етістік	бірмағыналы	темекі тартуға болмайды	5
304	өзгермейді	етістік	бірмағыналы	іс әрекеттің не заттың ауысусыз,өзгеріссіз қалуы	5
305	сақтайды	етістік	бірмағыналы	затты бір уақытқа дейін алып қалу	5
306	жалғастырады	етістік	бірмағыналы	басталған оқиғаның өтіп жатқан ортасы	5
307	өтіп жатыр	етістік	бірмағыналы	оқиғаның жалғасуы	5
308	хабарлайды 	етістік	бірмағыналы	бір оқиға жайлы айту	5
309	басталды	етістік	бірмағыналы	бір нәрсе қатарында бірінші болып, бір нәрсені ашыңыз	5
310	Cаll орталықтар	зат есім	бірмағыналы	сауалыңызға жауап беретін арнайы байланыс орталықтары	1
311	беруі керек	етістік	бірмағыналы	бір нәрсе туралы ескерту, алдын ала айтты	5
312	хабарлады	етістік	бірмағыналы	бір нәрсе туралы ескерту, алдын ала айту	5
313	саясаттанушы 	зат есім	бірмағыналы	бұл өз мемлекетінің де, басқа елдердің де қазіргі саяси оқиғаларын жақсы білетін маман.	1
314	ашу	етістік	көпмағыналы	жабық тұрған затты ашу	5
317	реформа	зат есім	бірмағыналы	өмір сүріп отырған әлеуметтік құрылымның негіздерін сақтай отырып, қоғамдық өмірдің кейбір қырларын өзгертіп, қайта құру. 	1
318	бөлімше	зат есім	бірмағыналы	әскери қарулы күштердегі 6 — 12 адамнан жасақталатын ең төменгі тактикалық жауынгерлік топ	1
319	референдум	зат есім	бірмағыналы	мемлекеттік маңызы бар мәселені халықтық дауысқа салу.	1
320	байқау орталығы	зат есім	бірмағыналы	белгілі бір мақсат қойып, объектіні әдейі қабылдайтын орталық	1
321	материалдар	зат есім	бірмағыналы	өнімді дайындау және өндіріске қызмет көрсету үшін көбінесе еңбек заты ретінде пайдаланылатын әр түрлі заттай элементтер.	1
322	тренингтер	зат есім	бірмағыналы	білім - дағдыларды, әлеуметтік қызметтерді белсенді дамытуға бағытталған оқыту әдісі болып табылады	1
323	төрағалары	зат есім	бірмағыналы	бұл директорлар кеңесі сайлайтын, директорлар кеңесі немесе комитет мәжілістеріне төрағалық етуге жауапты директор	1
324	байқаушылары	зат есім	бірмағыналы	сырттан қарайтын адам	1
325	сайлау учаскелері	зат есім	бірмағыналы	учаскелік немесе дауыс беретін округ	1
326	мониторинг	зат есім	бірмағыналы	қоршаған табиғи орта жағдайының антропогендік факторлардың әсер-ықпалынан өзгеруін болжау мен бағалаудың, бақылаудың кешенді жүйесі.	1
327	әділ	сын есім	бірмағыналы	адамның қызметі, оның табиғи және ажыратылмайтын құқықтары мен міндеттері туралы көзқарастарға сәйкес келетін адами өзара қатынастардағы істердің дұрыс, тиісті болу идеясын білдіретін моральдық және құқықтық сананың түсінігі, ұғымы	2
328	міндеттері	зат есім	бірмағыналы	жасалынуы тиіс іс әрекеттер жиынтығы	1
329	функциялары	зат есім	бірмағыналы	Қызмет, міндет, жұмыс; қатынастар жүйесіндегі қайсы бір объекті қасиеттерінің сыртқы көрінісі	1
330	негізгі	сын есім	бірмағыналы	ең басты ерекшелік	2
756	шет мемлекет	зат есім	бірмағыналы	сыртқы мемлекеттер	1
331	қағидаттары	зат есім	бірмағыналы	 оның негізінде ғылыми теориялар мен заңдар, құқықтық құжаттар жасалады.	1
332	мәселелер	зат есім	бірмағыналы	деректер жиынтығының өшірілуі	1
333	адал	сын есім	бірмағыналы	әрдайым әділдікті ұстанатын адам қасиеті	2
334	дәріс	зат есім	бірмағыналы	мектеп, медреселердегі,университеттегі сабақ	1
335	оқыды	етістік	бірмағыналы	жазбаша сөзді оның белгілері, әріптері бойынша қабылдау	5
336	сипаттамалары 	зат есім	бірмағыналы	шаманың ерекшелігін анықтайтын белгі	1
337	ерекшеліктері	зат есім	бірмағыналы	әр заттың жеке дара белгілері	1
338	баяндады	етістік	көпмағыналы	Ресми түрде басшылықты немесе жоғары лауазымды тұлғаны хабардар ету	5
339	баяндады	етістік	омоним	Мейманның немесе келушінің келгені туралы  хабарлау.	5
340	баяндады	етістік	омоним	бір нәрсені айту, бір нәрсе туралы хабарлау.	5
341	семинар	зат есім	бірмағыналы	оқу-практикалық сабақтар, онда студенттер оқытушының жетекшілігімен оқу немесе ғылыми зерттеулердің нәтижелері бойынша жасаған хабарламаларын, баяндамалары мен рефераттарын талқылайды.	1
1149	тікелей	сын есім	бірмағыналы	тура мағынасында	2
1150	жанама	сын есім	бірмағыналы	тура емес мағынасында	2
342	мобильді платформалар	зат есім	бірмағыналы	бұл белгілі бір қосымшадаплатформада орнатылған және белгілі бір функционалдылыққа ие планшеттер мен смартфондарға (iOS, Android, Windows Phone және т.б.) арналған әзірленген бағдарлама	1
343	қолжетімді 	сын есім	бірмағыналы	бір заттың ыңғайлы болуы	2
344	тексеру	етістік	бірмағыналы	бір заттың дұрыстығын қарап шығу	5
345	сервисі	зат есім	бірмағыналы	тауарларды (бұйымдарды) өткізумен және пайдаланумен байланысты қызметтер кешенін қамтамасыз ететін маркетинг атқарымы.	1
346	ЖСН	зат есім	бірмағыналы	Қазақстан Республикасында жеке тұлғаларға берілетін сандық код	1
347	қалды	етістік	бірмағыналы	кез-келген жағдайда болуды тоқтатпаңыз; кез-келген, кез-келген, бір нәрсе болуды жалғастырыңыз	5
349	комиссия мүшелері	зат есім	бірмағыналы	комиссия төрағасынан тексеру мақсаттарына және тексерілетін бөлімшеге қатысты нұсқаулар алады	1
350	мүгедек	зат есім	бірмағыналы	тіршілік-тынысының шектелуіне және оны әлеуметтік қорғау қажеттігіне әкеп соқтыратын аурулардан, жарақаттардан, олардың салдарынан, кемістіктерден организм функциялары тұрақты бұзылып, денсаулығы бұзылған адам.	1
351	тапсырды	етістік	бірмағыналы	Өткізу секілді сипатта қолданылатын етістік.	5
352	ыңғайлы	сын есім	бірмағыналы	Жағдайға келетін, қолайлы. 	2
353	Тарихи 	сын есім	бірмағыналы	Тарихқа байланысты, соған қатысты, тарихты баяндайтын.	2
354	жариялады	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы	5
355	үндеу	зат есім	бірмағыналы	Халықты белгілі бір іске жұмылдыру үшін жазылған ұран; шақыру.  2. Батыл қимылға, стачка, ереуіл, қарулы көтеріліске шақыратын, әдетте, астыртын таратылатын хат.	1
356	маусым	зат есім	бірмағыналы	белгілі бір кезең, мезгіл.	1
357	өткізу	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы.	5
358	қарастыру	етістік	бірмағыналы	Бір нәрсені табу үшін әрекет ету.	5
359	әкелу	етістік	бірмағыналы	Белгілі бір нәрсені алып келу, жеткізу.	5
360	ауыстыру	етістік	бірмағыналы	Бір нәрсені екіншісімен алмастыру .	5
361	халық	зат есім	бірмағыналы	Белгілі бір елдің, мемлекеттің негізін қалаған, өздеріне тән тілі, мәдениеті, салт-дәстүрлері бар әлеуметтік топтар жиынтығы; этнос.	1
362	институт	зат есім	бірмағыналы	кәсіптік жоғары білімнің білім беру бағдарламаларын іске асыратын және қолданбалы сипаттағы ғылыми зерттеулерді жүзеге асыратын жоғары оқу орны 	1
363	саяси	сын есім	бірмағыналы	Саясатпен байланысы бар, саясатқа қатысты.	2
364	құзырет	зат есім	бірмағыналы	қандай да болмасын мемлекеттік органның немесе лауазымды тұлғаның үлесіндегі ерекше құқық.	1
365	орнатылады	етістік	бірмағыналы	Орнатыл етістігінің қимыл атауы. 	5
366	конституциялық 	сын есім	бірмағыналы	Конституцияға тән, конституцияға қатысты.	2
402	қуану 	етістік	бірмағыналы	Қуан етістігінің қимыл атауы;	5
367	кеңейтіледі	етістік	бірмағыналы	сөздер әсерлірек болу үшін уақыт өте келе сөз мағынасының өзгеріп, семантикалық өзгеріске түсуі	5
368	сайлау жүйесі	зат есім	бірмағыналы	белгілі бір билік түрін, мемлекеттік өкілеттілік, заң шығаратын, атқару, сот орындарын қалыптастыруға қатысуды қамтамасыз ететін ережелер мен әдістердің жиынтығы.	1
369	тәуелсіз 	сын есім	бірмағыналы	Ешкімге, еш нәрсеге бағынышты емес; байланыссыз.	2
370	депутат	зат есім	бірмағыналы	заң шығарушы немесе өкілетті органға белгіленген тәртіпте сайланған тұлға.	1
371	аккредиттеу	етістік	бірмағыналы	уәкілетті органның «Аудиторлық қызмет туралы» ҚР Заңда көзделген кәсіби аудиторлық ұйымдардың құқықтылығын ресми тануы («Аудиторлық қызмет туралы» 1998 жылғы 20 қарашадағы № 304-1 ҚРЗ 1-бап)	5
372	миссия	зат есім	бірмағыналы	Белгілі бір мемлекеттің елшісіне, жеке адамға жүктелген міндеттеме.	1
373	жалғасады	етістік	бірмағыналы	Заттың я уақиғаның бір шектен арғы ұламы.	5
374	Жастар	зат есім	бірмағыналы	ҚР он төрт жастан жиырма тоғыз жасқа дейінгі азаматтары	1
412	бермеу	етістік	бірмағыналы	 бой бермеу, көнбеу.	5
375	көшбасшы	зат есім	бірмағыналы	Қоғамдық ұйымның жеке ықпалы әлеуметтік процестерде және жағдайларда, ұжымдағы, топтағы, қоғамдағы қарым-қатынастарды реттеуде маңызды қызмет атқаратын кез келген әлеуметтік топтың беделді мүшесі; 	1
376	тоқтатылды	етістік	бірмағыналы	Тоқтат етістігінің қимыл атауы.	5
377	пайдаланушы	зат есім	бірмағыналы	Белгілі бір затты пайдаға асырушы, керегіне, қажетіне жаратушы.	1
378	алаң	зат есім	бірмағыналы	Мереке-жиын өтетін елді мекен (қала, село т.б.) ішіндегі арнаулы орын .	1
379	Ассамблея 	зат есім	бірмағыналы	Халықаралық ұйым мүшелерінің жалпы қоғамдық жиналысы.	1
380	тірек	зат есім	бірмағыналы	 Бір нәрселерді тіреп қоятын ағаш	1
381	Қазақстан	зат есім	бірмағыналы	 Қазақ Республикасы; қазақ жері, қазақ елі.	1
382	құбылыс	зат есім	бірмағыналы	Бізді қоршаған ортада, табиғатта болып тұратын әртүрлі өзгеріс .	1
383	сирек	сын есім	бірмағыналы	Жиі емес, селдір.	2
384	туындады	етістік	бірмағыналы	Туында етістігінің қимыл атауы.	5
385	қалыпты	сын есім	бірмағыналы	дағдылы сауда операциялары процесінде өндіруші және (немесе) экспорттаушы елге демпингке қарсы істі қарау нысанасы болып табылатын тауарға ұқсас тауарды сату кезінде нақты төленген немесе төленуге тиісті баға («Демпингке қарсы шаралар туралы» 1999 жылғы 13 шілдедегі № 421 ҚРЗ 1-бап)	2
386	ұстаным	зат есім	бірмағыналы	Нақты бір мәселеге көзқарас.	1
387	сезінеді	етістік	бірмағыналы	Сезін етістігінің қимыл атауы.	5
388	адам 	зат есім	бірмағыналы	Ойлау және сөйлеу қабiлeтi зоp, еңбек құpалдаpын жасап, олаpды өз игілік қажетте жаpата білетін қоғамның саналы мүшесі.	1
389	шекара	зат есім	бірмағыналы	Аумақтық жағынан бір-біріне шектесіп жатқан жер.	1
390	бостандық	зат есім	бірмағыналы	Еркіндік, өз биліғі өзінде болушылық, еріктілік.	1
391	көтеріледі	етістік	бірмағыналы	Көтер етістігінің қимыл атауы	5
392	көрінбеу 	етістік	бірмағыналы	Көру қиын, көру мүмкін емес	5
393	ауыр	сын есім	бірмағыналы	 Науқастану, сырқаттану, дертке шалдығу	2
394	жаза 	зат есім	бірмағыналы	. Қазақ тілінде «істеген кінәсінің, қылмысының өтеуі» деген мағынада да қолданылады.	1
395	дәлел 	зат есім	бірмағыналы	дәлелдеме процесінде пайдаланылатын дәлел, нақты факт.	1
396	Мәжіліс	зат есім	бірмағыналы	 Белгілі бір мәселені талқылап шешу үшін ұжым мүшелерінің бас қосқан отырысы, кеңес	1
397	Парламент	зат есім	бірмағыналы	конституциялық мемлекеттерде жоғары заңнамалық өкілетті жиналыс.	1
398	Мәслихат 	зат есім	бірмағыналы	ақыл айту, кеңес беру.	1
399	дербес 	сын есім	бірмағыналы	жеке адамның қайталанбайтын, өзіндік болмысы, өзінің субъектісі түрінде оның мақсаты мен мән-мағынасы болатын іс-қимылы. 	2
400	заманауи 	сын есім	бірмағыналы	 Бұлардың бәрі тек заманауи “бесжылдық жоспарға” байланысты құбылыстар болып қалмастан, сол жоспардың туындысы және соның көріністері болып табылады .	2
401	мемлекет	зат есім	көпмағыналы	өз аумағында күш көрсету мен мәжбүрлеуді заң жүзінде қолдана алатын қоғамдық құрылым.	1
403	таңдау 	зат есім	көпмағыналы	өз еркімен екі мемлекет азаматтығының бірін таңдау, қалап алу.	1
404	қала	зат есім	бірмағыналы	 Зауыты, фабрикасы, өнеркәсібі, оқу орындары бар ірі елді мекен.	1
405	қаралған	зат есім	бірмағыналы	Денсаулықты тексерту, емделу	1
406	растау	етістік	бірмағыналы	Раста етістігінің қимыл атауы.	5
407	қамтамасыздандыру	етістік	бірмағыналы	Қамтамасыздандыр етістігінің қимыл атауы.	5
408	жоғары 	сын есім	көпмағыналы	/ Мемлекеттік басшылық қызмет, жетекшілік ететін басшы орын	2
409	төмен	сын есім	көпмағыналы	Артта қалған, деңгейі пәс.	2
410	рәсімдеу	етістік	бірмағыналы	Рәсімде етістігінің қимыл атауы; белгілі бір әрекеттің заң күшіне ендірілуі.	5
411	енгізеді	етістік	бірмағыналы	 Қолданысқа кіргізу, тәжірибеге пайдалану.	5
178	жарқын	сын есім	бірмағыналы	 нұры жайнаған. 	2
413	қайта құрылды	етістік	бірмағыналы	Керісінше, мүлде, қарама-қарсы	5
414	аймақ	зат есім	бірмағыналы	республиканың бірнеше елді мекендері енгізілетін, оның мүддесі үшін құрылатын және басқарылатын республика аумағының бір бөлігі.	1
415	алу	сын есім	көпмағыналы	Арифметикадағы санды азайту амалы.	2
416	тиімсіз 	сын есім	бірмағыналы	Iс-әрекеттің ешбір қорытынды-түйінге келмей бітуі; жеміссіз.	2
417	тұстары	зат есім	бірмағыналы	Бір кездерде	1
418	атап өтті	етістік	бірмағыналы	. Тоқталып кету, атап-атап көрсету, ерекше назар аударту.	5
419	жұрт	зат есім	бірмағыналы	қазақтың халықтық-мекендік, тектестік-тұтастықты білдіретін байырғы әлеуметтік ұғымы.	1
420	жаһандану 	зат есім	бірмағыналы	Идеялардың, ресурстардың, тәжірибелердің және адамдардың байланысы жергілікті жүйеде емес, негізінен, бүкіл әлемдік деңгейде жүзеге асатын процесс.	1
421	ауқымды 	сын есім	бірмағыналы	Кеңді, көлемді	2
422	Палата	зат есім	бірмағыналы	. Ауруханалар мен емдеу орындарындағы аурулар жататын арнаулы бөлме.	1
423	Спикер	зат есім	бірмағыналы	бірқатар парламенттік мемлекеттердегі парламент басшысының немесе палата басшысының аты	1
424	қолдану	етістік	бірмағыналы	Қолдан етістігінің қимыл атауы.	5
425	шағымдану	етістік	бірмағыналы	Tuicmi орындарға, жетекшілерге қандай да бір мәселе жайында арыз айтып, шағым түсірy.	5
426	Офис	зат есім	бірмағыналы	Мекемелер мен кәсіпорындардың әкімшілік-кеңселік бөлімдерінің жалпы атауы.	1
427	жүгіну	етістік	бірмағыналы	Екі аяғын астына баса тізерлеп отыру.	5
428	бақылау	етістік	бірмағыналы	Бiр заңды тұлғаның басқа заңды тұлғаның шешiмдерiн айқындау мүмкiндiгi, ол мынадай: бiр тұлға басқа тұлғаның дауыс беретiн акцияларының елу процентiнен астамын дербес не бiр немесе бiрнеше тұлғамен бiрлесiп тiкелей немесе жанама иеленетiн не басқа заңды тұлғаның акцияларының елу процентiнен астамымен дербес дауыс беру мүмкiндiгi болатын;	5
429	сөйлесу	етістік	көпмағыналы	Сөйлес етістігінің қимыл атауы.	5
430	әңгімелесті	етістік	бірмағыналы	Әңгімелес етістігінің қимыл атауы.	5
431	спорт 	зат есім	бірмағыналы	. Организм нығайып, шынығуы үшін жасалатын дене жаттығуы.	1
432	ішкі	сын есім	бірмағыналы	Іш жағындағы, ішіндегі .	2
433	талқыланды	етістік	бірмағыналы	 атау. Талқылан-у.	5
434	клиника	зат есім	бірмағыналы	Науқас адамдарды емдеумен қатар педагогикалық және ғылыми-зерттеу жұмыстары бірге жүргізілетін емдік-профилактикалық мекеме.	1
435	құжат	зат есім	бірмағыналы	«дәлел, айғақ, куәлік», «иелену құқығын айғақтайтын, меншік иесі екенін дәлелдейтін заңды құжат». Қазақ тілінде «адамның жеке басына, үйге, көлікке т.б. қатысты құжаттар» ұғымында да қолданылады.	1
436	вакцинация	зат есім	бірмағыналы	(мед.) адам организміне вакцина немесе арнайы тәсілмен дайындалған антигендік қасиеті бар заттарды енгізу арқылы белгілі бір жұқпалы аурудан алдын ала сақтандыру үшін қолданылатын әдіс.	1
437	назар аудару	етістік	бірмағыналы	белгілі бір объектіге қабылдаудың селективті бағыты, кез-келген деректерді алу үшін объектіге деген қызығушылықты арттыру.	5
438	іске қосылды	етістік	бірмағыналы	Қосыл етістігінің қимыл атауы.	5
439	пысықтау	етістік	көпмағыналы	оқыту процесінде оқушылардың алған білімі мен дағдысын бекіту, тиянақтау, жүйеге келтіру мақсатымен бұрынғы өткен материалға қайта оралу.	5
440	тарату 	етістік	бірмағыналы	тұтынушыларға тікелей немесе даяшы көмегімен дайын тағамды, аспаздық өнімді құрастырып және таратуға арналған арнаулы жабдықталған бөлме.	5
441	мүше	зат есім	көпмағыналы	Сойылған мал етінің қонағына қарай тартар негізгі бөлшегі жамбас, жілік, сүбе т.б.	1
442	редакция	зат есім	бірмағыналы	зат. Баспадан шығуға тиісті кітап, газет, журналдарды өндіріске әзірлейтін мекеме, ұжым.	1
443	кандидатура	зат есім	көпмағыналы	Кандидат ретінде тағайындалуы мүмкін адам	1
444	бюджет	зат есім	бірмағыналы	Белгіленген уақыт кезеңі ішінде жобаланатын кірістер мен шығыстардың мәлімдемесі.	1
445	жүздесу	зат есім	бірмағыналы	Жүздес етістігінің қимыл атауы; кездесу, жолығысу, ұшырасу.	1
446	жабдықтау	зат есім	бірмағыналы	Жабдықта етістігінің қимыл атауы. 	1
447	реттеу	етістік	бірмағыналы	Ретте етістігінің қимыл атауы.	5
448	түйіндеу	етістік	бірмағыналы	Түйінде етістігінің қимыл атауы; түйін жасап байлау.	5
449	әсер	зат есім	көпмағыналы	Сырттай бір құбылыстан, қимыл-әрекеттен болатын ықпал.	1
542	шешім	зат есім	көпмағыналы	Бір нәрсенің түйіні, байлам, тоқтам, қорытынды	1
450	күшею	етістік	бірмағыналы	Күшей етістігінің қимыл атауы; арту, нығаю деген мағынада қолданылады.	5
451	өту	етістік	бірмағыналы	Өт етістігінің қимыл атауы, жүзеге асыру деген секілді іс-қимылды білдіреді.	5
452	сараптау	зат есім	бірмағыналы	Сарапта етістігінің қимыл атауы.	1
453	нақты	зат есім	көпмағыналы	Істің дәл, анық жағдайын сипаттайды.	1
454	бекіту	зат есім	көпмағыналы	белгілі бір істің қайталануын болдыратын стимул.	1
455	проблема	зат есім	көпмағыналы	оны шешуді талап ететін практикалық немесе теориялық мәселе; таным процесінде туындайтын белгісіздік немесе қайшылық, субъектінің белгілі бір жағдайда туындайтын қиындықтар мен қайшылықтарды қолма-қол білім мен тәжірибе арқылы шеше алмайтындығын түсінуі.	1
456	өсиеттеу	етістік	көпмағыналы	Өсиетте етістігінің қимыл атауы.	5
457	тіреледі	етістік	көпмағыналы	Тірел етістігінің қимыл атауы.	5
458	жаңғырту	етістік	бірмағыналы	Объектіні жаңарту процесі, оны жаңа талаптар мен нормаларға, техникалық шарттарға, сапа көрсеткіштеріне сәйкес келтіру	5
459	өзекті	сын есім	бірмағыналы	шын мәнінде бар, іске асырылған	2
460	ықтимал	сын есім	бірмағыналы	«мүмкін, бәлкім», «төзімділік, мықтылық, бекемдік». Екінші мағынасы қазақ фольклорлық жырларында кеңінен қолданылған.	2
461	шеттету	етістік	бірмағыналы	Жеке тұлғаны заңды тұлғаны басқарудың атқарушы органында қызмет атқару, кәсіпкерлік қызметті жүзеге асыру құқығынан айыру	5
462	қанықты	сын есім	бірмағыналы	өте мазмұнды	2
463	абыройлы	сын есім	бірмағыналы	Құрмет, құрмет белгісі ретінде сайланады	2
464	тұлға	зат есім	көпмағыналы	пайымдау, мораль, зерде, мендік сана секілді болмыстық қырларын, сондай-ақ әлеуметтік байланыс пен мәдени нормалға қатысты туыстық, мүлік меншігі, заңдық жауапкершілігі қатарлыларды қамтитын, кісілік қабілеттер мен ерекшеліктерге ие жеке адамды сипаттайды.	1
465	атсалысу	етістік	бірмағыналы	бұл біреудің басқа адамдармен бірге жасайтын әрекеті.	5
466	алмасу	етістік	бірмағыналы	алма кезек ауысу	5
467	анық-қанық	сын есім	бірмағыналы	бір нәрсенің дәйекті ақиқаты	2
468	арақатынас 	етістік 	бірмағыналы	бір-бірімен байланыс	5
469	арқасында 	сын есім	бірмағыналы	Еткен еңбектің нәтижесінде, еңбекпен қол жеткен.	2
470	арқау	зат есім	бірмағыналы	бір нәрсенің ұзын ырғағы, байланыстылығы	1
471	арнайы	сын есім	бірмағыналы	белгілі бір мақсатпен біле тұра ерекшелеп	2
472	эксперт	зат есім	көпмағыналы	сараптама жүргізетін маман, яғни осы салада Құзыретті емес басқа адамдар қарайтын немесе шешетін мәселе бойынша білікті қорытынды немесе пікір беру үшін шақырылған немесе жалданған адам.	1
473	спикер	зат есім	бірмағыналы	бір палаталы Парламенттің немесе көп палаталы парламент палатасының төрағасы.	1
474	ереже	зат есім	көпмағыналы	дәстүрлі халық құқығының қайнар көзі, нормативтік-құқықтық қағидалар.	1
475	анықтау	етістік	көпмағыналы	бір нәрсені анықтау, орнату	5
476	кеміту  	етістік	бірмағыналы	шаманың қысқаруы, кемуі	5
477	жою	етістік	көпмағыналы	кемшіліктерді жою сауатсыздықты жою	5
478	бас	зат есім	көпмағыналы	Бас-бұл адамдар мен жануарларда болатын дененің бөлігі.	1
479	тарту	зат есім	бірмағыналы	Бір нәрсені істеуге ынталандыру, бір нәрсеге қатысу, бір нәрсеге қатыстыру. Біреуге қосылуға итермелеу, біреуді қолдаушы ету.	1
480	вице-министр	зат есім	бірмағыналы	Министрдің орынбасары лауазымы; осы лауазымды атқаратын адам	1
481	баспасөз	зат есім	көпмағыналы	мерзімді және мерзімсіз басылымдардың жиынтық атауы.	1
482	жер	зат есім	көпмағыналы	Жер — Күннен әрі қарай санағанда үшінші ғаламшар және тіршілігі табылған жалғыз астрономиялық нысан.	1
483	су	зат есім	бірмағыналы	сутегі мен оттегінің қалыпты жағдайларда тұрақтылығын сақтайтын қарапайым химиялық қосылыс	1
484	өсімдік	зат есім	бірмағыналы	тірі организмдер дүниесіндегі негізгі екі топтың бірі (біріншісі - хайуандар). 	1
964	маңызы бар	сын есім	бірмағыналы	мәндірек мағынасында қолданылады	2
486	дүние	зат есім	көпмағыналы	жалпы мағынасында — бүкіл әлем, ғалам	1
487	тоқталды	етістік	бірмағыналы	қозғалысты тоқтату,жұмыс істеу	5
488	модель	зат есім	көпмағыналы	белгілі бір зерттелетін нысанның ой түсінігі арқылы немесе материалдық түрде жасалған шартты үлгісі (бейнесі, сұлбасы, сипаттамасы, т.б.). 	1
489	квота	зат есім	көпмағыналы	әркімге тиесілі бөлік‚ guot – қанша), үлестеме – әркімге тиесілі үлес‚ бөлік‚ норма.	1
490	мандат	зат есім	көпмағыналы	өкілеттік, міндет, тапсырма, тұлғаның өкілеттілігін білдіретін құжат.	1
492	есеп	зат есім	көпмағыналы	 нәрсенің, құбылыстың, үрдістің өлшемі, мөлшері, амалы, тәсілі, әдісі дегенді білдіреді. 	1
493	сайлану құқығы	зат есім	бірмағыналы	Республика азаматтарының мемлекеттік органдар мен жергілікті өзін-өзі басқару органдарын сайлауға және оларға сайлануға, сондай-ақ республикалық референдумға қатысуға құқығы бар	1
494	тең сайлау	зат есім	бірмағыналы	Сайлаушылар Президентті, Парламент Мәжілісі мен мәслихаттардың партиялық тізімдер бойынша сайланатын депутаттарын сайлауға, сондай-ақ аудандық маңызы бар қалалар, ауылдар, кенттер, ауылдық округтер әкімдерін сайлауға тең негіздерде қатысады әрі олардың әрқайсысының бір сайлау бюллетеніне тиісінше бір дауысы болады	1
495	төте сайлау	зат есім	бірмағыналы	Республика Президентiн, Парламентi Мәжiлiсiнiң және мәслихаттарының депутаттарын, аудандық маңызы бар қалалар, ауылдар, кенттер, ауылдық округтер әкімдерін, өзге де жергілікті өзін-өзі басқару органдарының мүшелерін азаматтар тiкелей сайлайды	1
496	жанама сайлау	зат есім	бірмағыналы	Парламент Сенаты депутаттарын сайлауға таңдаушылардың – мәслихаттар депутаттары болып табылатын Қазақстан азаматтарының қатысуы. Таңдаушылар сайлауға тең негізде қатысады және олардың әр	1
497	құқық	зат есім	бірмағыналы	азаматтың немесе ұйымның мүддесін қанағаттандыруға байланысты мақсаттарына қол жеткізуге бағытталған болжамды іс-әрекетінің заңмен қамтамасыз етілген шаралары; Саяси әлеуметтік, қоғамдық ерік; қақы	1
498	дауыс беру\nдауыс	етістік	бірмағыналы	бұл ұсынылған үміткерлерді сайлау мәселесі бойынша сайлаушылардың еркін білдіретін, сайлау процесінің шешуші сатысы	5
499	жасырын	сын есім	бірмағыналы	астыртын, байқатпай, білдірмей деген мағынаны білдіреді	2
500	ерікті	сын есім	бірмағыналы	Өз еркі өзінде, ықтиярлы; құқылы, тәуелсіз мағынасында пайдаланылады	2
501	белсенді сайлау	зат есім	бірмағыналы	сайланбалы мемлекеттік органдар мен жергілікті өзін-өзі басқару органдарын сайлауға қатысу құқы	1
535	бірлестік	зат есім	көпмағыналы	Бірнеше саладағы ұйымның немесе өндіріс мүшелерінің, ұжымның бірігіп, ұйымдасқан түрі	1
502	бәсең сайлау	зат есім	бірмағыналы	Қазақстан Республикасы азаматтарының Қазақстан Республикасының Президентi, Қазақстан Республикасы Парламентiнiң, мәслихатының депутаты немесе жергiлiктi өзiн-өзi басқару органына мүше болып сайлану құқығы.	1
503	жалпыға бірдей	сын есім	бірмағыналы	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2
504	мүше	зат есім	көпмағыналы	Белгілі бір ұйымның, ұжымның, отбасының құрамына енетін адам	1
505	кандидат	зат есім	бірмағыналы	қандай да бір қызметке үміткер; кіші ғылыми атақ	1
506	сайлаушы	зат есім	бірмағыналы	Сайлауға қатысатын, дауыс беретін адам	1
507	партия	зат есім	бірмағыналы	1) белгілі бір әлеуметтік топ мүдделерін қорғайтын және сипаттайтын саяси ұйым және оның саяси әрекетіне басшылық жүргізеді; 2) жалпы көзқарас пен мақсаттармен біріктірілген тұлғалар тобы	1
693	тәуелсіз	сын есім	бірмағыналы	Өз саясатын, билігін өз еркімен жүргізуге қабілетті.	2
508	бюллетень	зат есім	көпмағыналы	Кандидаттардың аты-жөндері жазылған дауыс беруге арналған парақ. Қоғамдық үлкен мәні бар оқиға жайындағы қысқаша ақпараттық хабарлама. Белгілі бір мекеменің өз қызметі жөнінде жаңа мәліметтер беретін уақытша басылымы	1
509	санат	зат есім	бірмағыналы	Маманның кәсіби деңгейін көрсететін өлшем, дәреже, категория.	1
510	кепілдік	зат есім	бірмағыналы	міндеттемелердің орындалуын қамтамасыз ететін құқықтық принциптер мен тәсілдердің жиынтығы	1
511	шарт	зат есім	көпмағыналы	азаматтық құқықтар мен міндеттерді белгілеу, өзгерту немесе тоқтатуға бағытталған екі не одан да көп тараптардың келісуі, мәміленің бір түрі	1
512	азамат	зат есім	бірмағыналы	белгілі бір мемлекетке құқытық негізде тиесілі тұлға	1
513	тікелей	үстеу	бірмағыналы	Тіке, тұп-тура, бірден мағыналарында пайдаланылады	9
514	таңдау	етістік	бірмағыналы	Таңда етістігінің қимыл атауы	5
515	таңдаушы	зат есім	бірмағыналы	Таңдап алатын адам	1
516	бақылау	етістік	бірмағыналы	Бақыла етістігінің қимыл атауы	5
517	жүйе	зат есім	көпмағыналы	өзара байланысты және өзара әрекеттестіктегі элементтер жиынтығы	1
518	қатысу	етістік	бірмағыналы	Қатыс етістігінің қимыл атауы	5
519	пайыз	зат есім	бірмағыналы	Бүтін ретінде алынған қандай да бір заттың жүз бөлігі, процент.	1
520	қайта дауыс беру	етістік	бірмағыналы	сайлау үрдісінің шешуші кезеңі. Бір немесе екі турдан болады. Бюллетендермен немесе арнайы машиналармен дауыс беру арқылы жүзеге асады	5
521	аумақтық	сын есім	бірмағыналы	Аумаққа тән, аумаққа қатысты	2
522	округ	зат есім	бірмағыналы	Аумақтық әкімшілікке, бөлікке тән, соған қатысты	1
523	біртұтас	сын есім	бірмағыналы	Бөлінбейтін, бірімен-бірі байланысты, бір бүтінге айналған	2
524	жалпыұлттық	сын есім	бірмағыналы	Бүкіл ұлтқа тəн, жалпыхалықтық	2
525	тізім	зат есім	бірмағыналы	Адамның, мал-мүлік, дүниенің қағаз бетіне рет-ретімен жазылған аты. Тізім көп элементті құрылымнан тұрады, оның кез келгенін қалауымызша таңдай беруге болады, оған элементтер қосуға немесе қысқартуға да мүмкіндік бар	1
526	жақтап	етістік	көпмағыналы	Біреуді қолдау, қоштау, сөзін сөйлеу	5
527	қарсы	үстеу	бірмағыналы	Қарама-қарсы жақ	9
528	учаскелік	сын есім	бірмағыналы	Учаскеге тән, учаскеге қатысты	2
529	орталық	сын есім	бірмағыналы	Облыстық, аудандық деңгейдегі саяси-әкімшілік басқару орындары орналасқан қала немесе елді мекен. Белгілі бір аумақтың, өлкенің орта тұсы, негізгі бөлігі немесе елді мекен	2
530	мерзім	зат есім	көпмағыналы	Мөлшерлі уақыты бар, кесімді мезгіл	1
531	өкілеттік	зат есім	бірмағыналы	Белгілі бір міндеттелген істі орындауға құқықтылық	1
532	саяси	сын есім	бірмағыналы	Саясатпен байланысы бар, саясатқа қатысты.	2
533	ұсыныс	зат есім	бірмағыналы	Кәсіпорын атынан басқа кәсіпорынға бағытталған белгілі бір шарт бойынша келісім-шарт жасасуға дайындығы туралы жазбаша өтініш	1
534	кандидатура	зат есім	бірмағыналы	бір орынға, қызметке, партияға лайықты деп ұсынылған адам	1
536	қоғамдық	сын есім	бірмағыналы	Қоғамға тән, қоғамда болып жататын іс-әрекет, құрылыстармен тығыз байланысты, қоғамға қатысты	2
537	өтініш	зат есім	бірмағыналы	өтінішті қарайтын субъектіге немесе лауазымды тұлғаға жіберілген жеке немесе ұжымдық жазбаша, ауызша не электрондық цифрлық қолтаңбамен расталған электронды құжат нысанындағы ұсыныс, арыз, шағым, сауал немесе үн қосу	1
538	отырыс	зат есім	көпмағыналы	Көп адамның бас қосқан жері, жиналыс	1
589	интернет ресурс	зат есім	бірмағыналы		1
539	хатшы	зат есім	бірмағыналы	1) хат жазушы. 2) іс жүргізуші (жеке кісінің, мекеменің). 3) мекеменің, ұйымның басшы қызметінің аты	1
540	құрам	зат есім	көпмағыналы	Белгілі бір әлеуметтік топты құрайтын адамдар (жиынтығы). Бір бүтін нәрсенің барлық бөлшектері, жиынтығы.	1
541	бұқаралық ақпарат құралдары	зат есім	бірмағыналы	қолданылатын ақпараттың физикалық объектілері, құралдары мен тасымалдағыштары, жеке немесе бұқаралық байланыс. Газет- журнал, радио мен теледидар сияқты ақпарат тарату құралдарының жалпы атауы, баспасөз.	1
543	хабар	зат есім	бірмағыналы	Болған іс, оқиға, сондай-ақ біреулердің хал-жайы жөнінде білдірілген қысқаша мәлімет. Телерадио бағдарламалары арқылы берілетін ресми ақпараттар	1
544	құзырет	зат есім	көпмағыналы	мемлекеттік орган, сондай-ақ, сол бір немесе өзге лауазымды тұлға иеленетін және тиісті заңды құжатта бекітілетін биліктік құқықтардың мазмұны мен көлемі	1
545	қызмет	зат есім	омоним	Еңбек ету аясындағы жұмыс; кәсіп. Белгілі бір мекемеде өз мамандығы бойынша атқарылытын жұмыс	1
546	тұрақты	сын есім	көпмағыналы	Бағдарлама орындалу барысында тұрақты мәні сақталатын шама; математикалық сан	2
547	орынбасар	зат есім	бірмағыналы	Мекеме бастығының бірінші көмекшісі, оның қызметін атқаратын адам	1
548	ведомство	зат есім	бірмағыналы	Мекеменің құрамына енетін түрлі қызметтер мен ұйымдардың жалпы атауы	1
549	бағынысты	сын есім	бірмағыналы	Біреуге бағынатын, тәуелді	2
550	ұйым	зат есім	бірмағыналы	Мемлекеттік, бұқаралық немесе қоғамдық мекеме. Меншік және бағынушылық нысанына тәуелсіз кәсіпорын, мекеме, ұйым. Өзара байланысты ерекше мақсаттарға жетуге және жоғары формалданған құрылымдардың қалыптастырылуына бағытталған әлеуметтік топ	1
551	басшылық ету	етістік	бірмағыналы	реттеуге, қорғауға, қойылған мақсатқа сай нысанның жүйесін өзгертуге немесе жоюға бағытталған, субъектінің нысанға әрекет ету процесі	5
552	жәрдем	етістік	бірмағыналы	Көмек көрсету, болысу, қолғабыс тигізу	5
553	аппарат	зат есім	көпмағыналы	Басқару ұйымдарындағы мекемелер мен қызметкерлердің жиынтығы	1
554	бірыңғай	сын есім	бірмағыналы	Түр жағынан өзара ұқсас келген біркелкі, бірдей	2
555	міндетті	сын есім	бірмағыналы	Орындауға тиісті, борышты	2
556	ұйымдастыру	етістік	бірмағыналы	Бір істі ұйымдастыру, ыңғайластыру. Ұйымдастыр етістігінің қимыл атауы. 	5
557	өткізу	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы	5
558	өтінім	зат есім	бірмағыналы	Қызметтің көрсетілуіне жазбаша түрде ресімделген ниет. Ұйымдастыру комитетіне немесе жарыстың төрешілер алқасына берілетін, қатысушылардың жасы, жынысы, спорттық біліктілігі көрсетілген тізімі бар құжат	1
559	күшін жою	етістік	бірмағыналы	ҚР өзі жасасқан халықаралық шарттан тиісінше ресімдеп бас тартуы және ҚР халықаралық шартының қолданылуын тоқтату тәсілінің бірі. Күшін қайтару, үзу, тоқтату, күшінде жоқ деп тану	5
560	тоқтату	етістік	бірмағыналы	Белгілі бір істі әрі қарай жалғастырмай, тыю, тоқтау қою	5
561	арыз	зат есім	бірмағыналы	Жеке адамның мекеме басшысына ресми түрде жазған шағымы	1
562	шағым	зат есім	бірмағыналы	ұйым жұмысында анықталған немесе болуы мүмкін кемшіліктер, соның ішінде өнім/қызмет сапасы бойынша кемшіліктер туралы арыз. адамның өзінің бұзылған құқықтарын, бостандықтарын немесе заңды мүдделерін қалпына келтіру, лауазымды тұлғалардың заңсыз іс-әрекеттерін немесе әрекетсіздігін жою, сондай-ақ субъектілердің заңсыз шешімдерінің күшін жою туралы талабы	1
593	аудандық	сын есім	бірмағыналы	Аудан көлеміндегі, ауданға тән, қатысты	2
563	процесс\nүдеріс	зат есім	көпмағыналы	қандай да бір құбылыстың дамуы; бір нәрсені дамытудағы жай-күйлердің ретімен заңды ауысуы	1
564	қатысушы	зат есім	бірмағыналы	Бір нәрсенің процесіне араласушы. Жиын, конференция т.с.с. қатынасушы адам	1
1151	тығыз байланысты	үстеу	бірмағыналы	байланыстың беріктігін көрсету	9
565	тәртіп	зат есім	бірмағыналы	Аумаққа, ғимаратқа, ақпаратқа кіруді бақылау мен қамтамасыз  ететін ережелердің, шаралардың, нормалардың жиынтығы. Адамдардың қоғамдық ортада белгілі бір тәртіп жүйесін сақтауын және оларды игеруге міндетті нормаларды (құқықтық, моральдық, саяси-этностық) берік сақтауын талап ететін жүйе	1
566	мөр	зат есім	бірмағыналы	Бір нәрсені куәландыру, растау үшін қолданылатын құрал, оның қағазға түскен дағы, ізі	1
567	жәшік	зат есім	бірмағыналы	Түрлі зат салуға арналған, тақтай я қаңылтырдан жасалатын төрт бұрышты ыдыс	1
568	үлгі	зат есім	бірмағыналы	Бұйымды, т.б. бір-бірінен бұлжытпай жасауға арналған қалып. Ауыспалы мағынада өнеге, тәлім ретінде пайдаланылады	1
694	штаб	зат есім	бірмағыналы	басқарып отыратын орган, орталық	1
569	құжат	зат есім	бірмағыналы	Қандай да бір фактіні немесе әлдебір нәрсе жөніндегі құқықты қуаттайтын ісқағаз	1
570	сақтау	етістік	көпмағыналы	Сақта етістігінің қимыл атауы	5
571	дайындау	етістік	бірмағыналы	Дайында етістігінің қимыл атауы.	5
572	куәлік	зат есім	көпмағыналы	Заңдық мәні бар әлдебір деректі (туу туралы, неке туралы, оқу орнын бітіргені туралы т.б.) тұлғаның құқын (авторлық, иеленушілік т.б.) немесе дайындалған материалдардың (бұйымдардың, құрылымдардың) стандарттарға не техникалық шарттарға сәйкестігін дәлелдейтін ресми құжат	1
573	есептен шығару	етістік	бірмағыналы	тізімнен алып тастауды білдіреді	5
574	есепке алу	етістік	бірмағыналы	тізімге қосуды білдіреді	5
575	тіркеу	етістік	көпмағыналы	1. Тұрған жерді көрсетіп, құжатта тіркелген белгі. 2. халықаралық шартты халықаралық үкіметаралық ұйымдардың жүргізетін арнайы тізіміне енгізу. 3. дипломатиялық өкілді тіркеу рəсімі	5
576	науқан	зат есім	бірмағыналы	Қоғамдық-саяси маңызы зор қауырт істелетін мерзімді іс	1
577	тағайындау	етістік	бірмағыналы	Тағайында етістігінің қимыл атауы. Біреуді белгілі бір қызметке қою, орналастыру.	5
578	хабарландыру	етістік	көпмағыналы	Құлақтандыру ретіндегі жарнама	5
579	қорытынды	зат есім	көпмағыналы	Белгілі біріс-әрекеттен, тәжірибеден туындайтын шешім, байлам, тұжырым, тоқтам	1
580	бөлініс	зат есім	көпмағыналы	саяси субъектіні бір немесе бірнеше жеке автономиялық аймақтарға бөлу	1
581	әкімшілік	зат есім	бірмағыналы	басқаруды жүзеге асыратын мемлекеттік органдар; мемлекеттік органның, сондай-ақ қоғамдық ұйымнан басқа кез-келген ұйымдардың атынан әрекет ететін басқарушы қызметкерлер, лауазымды тұлғалар	1
582	халық	зат есім	бірмағыналы	белгілі бір мемлекеттің аумағында тұратын және оның құқықтық өкілеттігіне жататын адамдар жиынтығы	1
583	есептеу	етістік	бірмағыналы	Есепте етістігінің қимыл атауы. Санау, тіркеу	5
584	нәтиже	зат есім	бірмағыналы	Белгілі бір іс-әрекеттен туатын, шығатын қорытынды, түйін	1
585	электронды	сын есім	бірмағыналы	Электрондық сайлау жүйесіне қызмет көрсететін мамандарды дайындауды және оқытуды Қазақстан Республикасының Орталық сайлау комиссиясы тиісті шарт жасаған ұйым жүргізеді	2
586	ақпарат	зат есім	бірмағыналы	берілген уақытта жаңалықтарды құраушы болып табылатын әртүрлі мәліметтердің жиынтығы	1
587	үгіт	зат есім	бірмағыналы	ауызша не газет-журнал бетінде белгілі бір саяси мәселені көпшілікке түсіндіру үшін жүргізілген әрекет, қызмет	1
588	ақпараттық	сын есім	көпмағыналы	Деректер берілген, көрсетілген, ақпараты бар	2
590	пункт	зат есім	бірмағыналы	Сайлау учаскесі, дауыс беру пункті орналасатын ғимаратта сайлау учаскесінің нөмірі көрсетілген дауыс беруге арналған үй-жайдың орналасқан жерінің көрсеткіштері ілінеді.	1
591	нұсқаулық	зат есім	бірмағыналы	іс-әрекетті жүзеге асырудың ұсынылған немесе міндетті амал-тәсілдері мен осы орайда қолданылатын құралдарды белгілейтін құжат	1
592	облыстық	сын есім	бірмағыналы	Облыс көлеміндегі, облысқа қатысты.	2
594	қалалық	сын есім	бірмағыналы	Қалаға тән,қалаға қатысты	2
595	хабарлама	зат есім	көпмағыналы	Ауызша не жазбаша түрде берілген мәлімет	1
596	мәлімет\nдеректер	зат есім	бірмағыналы	Белгілі бір оқиға, жұмыс жөнінде ауызша не жазбаша берілетін ақпар деген ұғымда да қолданылады	1
597	өзектілігі	сын есім	бірмағыналы	жаңалық мазмұны, даулы немесе эмоцияға толы оқиғалардан туындаған соңғы және өзекті жаңалықтардың ықпалы	2
598	анықтылығы	сын есім	бірмағыналы	Айқындық, дәлдік мағынасында да пайдаланылады	2
599	сенім	зат есім	бірмағыналы	Бір нәрсеге, біреуге көзі жетіп иланушылық сезімі, жеке адамдар арасындағы не жеке адамдар мен қоғам арасындағы, қатынастың сапалық өлшемі; наным	1
600	кабина	зат есім	бірмағыналы	қандай да бір көлік құралын басқаратын адамға немесе жүргізушіге, жолаушыға арналған, шағын көлемдегі, арнайы жабық орын	1
794	түсініктеме	зат есім	көпмағыналы	Бір нәрсе жайлы деректеме, анықтама	1
601	хаттама	зат есім	бірмағыналы	мәжіліс, жиналыс, конференция және т.б. мәселелердің талқылануы мен шешімдердің қабылдануын бедерлейтін және орындалған жұмыс пен қол жеткізген нәтижелердің объективті дәлелдемесі болып табылатын құжат	1
602	учаске	зат есім	бірмағыналы	Учаскеге тән, учаскеге қатысты	1
603	санау	етістік	бірмағыналы	Сана етістігінің қимыл атауы. Есептеу, санын анықтау	5
604	қайта сайлау	етістік	бірмағыналы	Егер Президент сайлауы жарамсыз деп танылса, не қайта дауыс беру сайланған Президенттi анықтауға мүмкiндiк бермесе, Орталық сайлау комиссиясы Президент сайлауын қайта тағайындайды	5
605	Президент	зат есім	бірмағыналы	республикалық басқару түріндегі мемлекеттің басшысы	1
606	Мәжіліс	зат есім	көпмағыналы	Мемлекеттің заң шығару қызметін жүзеге асыратын ең жоғары өкілді органы, Парламенттің тұрақты негізде жұмыс істейтін Сенаттан кейінгі екі палатасының бірі	1
607	мәслихат	зат есім	көпмағыналы	тиісті әкімшілік-аумақтық бөлініс қарамағындағы аймақтың жай-күйіне жауапты жергілікті орган	1
608	жергілікті	сын есім	бірмағыналы	барлық элементтері бар жер бетінің бөлігі (учаскесі, ауданы)	2
609	басқару органдары	зат есім	бірмағыналы	мемлекеттік орган	1
610	қателік\nқате	зат есім	бірмағыналы	дұрыс емес жасалған мәліметтер	1
611	жаңсақтық	зат есім	бірмағыналы	Әдейі істейін деп істемеген, байқаусыздан кеткен қылық 	1
612	өзгеріс	зат есім	көпмағыналы	Бұрынғы күйінен басқашалық, өзгешелік, айырмашылық	1
613	талап	зат есім	көпмағыналы	қалыптасқан қажеттілік немесе күту, әдетте болжам жасалады немесе міндетті саналады	1
614	санақ	зат есім	көпмағыналы	Санақ – статистикалық қадағалау объектісінің статистикалық есептеме тәртібімен жиналатын бірқатар сипатты белгілері бойынша саны мен құрамын есептеу мақсатымен жүргізілетін арнайы ұйымдастырылған қадағалау түрлерінің бірі 	1
615	өкіл	зат есім	бірмағыналы	Белгілі бір елдің, мекеменің, ұйымның көзқарасын, мүддесін білдіретін, оны жүзеге асыратын ресми адам	1
616	сенімхат	зат есім	бірмағыналы	Бір тұлға (сенімхат беруші) екінші бір тұлғаға (сенім жүктелген тұлғаға, өкілге) заңды әрекеттер (мәміле) жасасу үшін берген жазбаша өкілеттік	1
617	мүдде	зат есім	бірмағыналы	қоғамдағы әлеуметтік субъектілер іс-әрекетінің, өмір сүру бағдарының негізі, қозғаушы күші	1
618	куәландырылған	етістік	бірмағыналы	нотариалды бекітілген немесе мемлекеттік мекемемен немесе ұйымның мөрімен расталған	5
619	норма	зат есім / сын есім	көпмағыналы	Адамның іс-әрекетін және оның басқа адамдармен қарым-қатынасын реттейтін ереже	\N
620	нормативтік	сын есім	бірмағыналы	уәкілетті орган қабылдаған, құқық нормасын белгілейтін, өзгертетін немесе алып тастайтын ресми жазбаша құжат	2
621	акт	зат есім	бірмағыналы	заңдық маңызы бар кұжаттың атауы	1
622	қоғам	зат есім	бірмағыналы	дамдар арасындағы тарихи қалыптасқан саяси-әлеуметтік байланыстар мен қатынастардың тұрақты жүйесі	1
653	саясат	зат есім	бірмағыналы	Ел билеу ісінде мемлекеттер аралығындағы немесе әлеуметтік топтар аралығындағы қарым-қатынастарға байланысты істелетін бүркемеленген әртүрлі іс-әрекеттер мен шаралар	1
654	мемлекеттік	сын есім	бірмағыналы	Мемлекетке тән, мемлекетке қатысты	2
623	лауазым	зат есім	бірмағыналы	мемлекеттік органдарда, өзін-өзі басқару органдарында, Қарулы Күштер жүйесінде арнайы құзыреттілікпен тұрақты немесе уақытша билік өкілі қызметін, не болмаса (мекеме, кәсіпорындарда) ұйымдастыру-басқару, әкімшілік-шаруашылық қызметін атқаруды жүктейтін өкілеттілік	1
624	қалыптастыру	етістік	бірмағыналы	процесст пен жұмыс бойынша  бір нәтижеге жету, құрастыру	5
625	алқалылық	сын есім	бірмағыналы	басшылық әрқайсысы белгілі қызмет саласына дербес жауапкершіліктегі уәкілетті тұлғалар (алқалық) тобы жүзеге асыратын басқару принципі	2
626	жариялылық\nжариялық	сын есім	бірмағыналы	жұртшылық үшін ақпараттық өнімнің қолжетімділігі	2
627	ашықтық	сын есім	бірмағыналы	Түрлі дәрежедегі ішкі, сыртқы қоғамдық-саяси, экономикалық қарым-қатынасқа дайын болушылық	2
628	ашық дауыс беру	етістік	бірмағыналы	ашық дауыс беру арқылы сайлау бұл - демократиялық институттың тереңдеген үлгісі	5
629	кеңес	зат есім	көпмағыналы	функционалды басқару жүйесіне интеграцияланған, әдетте құрылымдық бөлімшелердегі басқару топтарының жиынтығы	1
630	кеңесші	зат есім	бірмағыналы	Сайлау комиссияларының құрамында өкілі жоқ саяси партиялар сайлау науқанын даярлау және өткізу кезеңіне тиісті сайлау комиссиясына сайлау тағайындалған немесе жарияланған күннен бастап он күннен кешіктірмей өз өкілін кеңесші дауыс құқығымен жіберуге құқылы. Сайланбалы органдардың немесе халықаралық ұйымдардың жұмысына кеңес беру міндеттерімен қатысу құқығы, яғни кез келген мәселелер бойынша дауыс беруге қатыспай, тек кеңес беруші ретінде ғана қатысу құқығы.	1
631	депутат	зат есім	бірмағыналы	Халық сенім білдіріп, сайланатын жоғарғы және жергілікті өкілдік билік органының мүшесі, өкіл	1
632	байқаушы	зат есім	бірмағыналы	Дауыс беру процесінің адал өтуін қамтамасыз етуді көздейтін тұлға, қадағалаушы 	1
633	аудармашы	зат есім	бірмағыналы	Бір тілден екінші тілге аудару ісімен шұғылданатын маман	1
634	халықаралық	сын есім	бірмағыналы	халықтар мен елдердің өзара байланысы, соларга тән қасиеттер	2
635	коммерциялық емес	сын есім	бірмағыналы	өз қызметінің негізгі мақсаты ретінде пайда тартуды көздемейтін және алынған пайданы қатынасушылар арасында бөлмейтін заңды тұлға болып табылатын ұйым	2
636	қарау	етістік	көпмағыналы	Бір мәселені қарау, зерттеу процесі	5
637	фотожазба	зат есім	бірмағыналы	Суретке түсіру	1
638	бейнежазба	зат есім	бірмағыналы	Видео жасау 	1
639	дыбысжазба	зат есім	бірмағыналы	Дыбыс жазу	1
640	мәлімдеме	зат есім	көпмағыналы	Белгілі бір оқиға туралы хабарлама	1
641	жазбаша	сын есім	бірмағыналы	Қағаз бетіне түскен күйде; құжат түрінде	2
642	ереже	зат есім	бірмағыналы	Белгілі бір іс-әрекеттің, оқиғаның, құбылыстың арақатынасы, заңдылығы көрініс табатын қағида. Қандай да бір мемлекеттік органның немесе оның құрылымдық бөлімшесінің мәртебесі мен белгілейтін нормативтік құқықтық келісім	1
643	ескерту	етістік	бірмағыналы	Ескерт етістігінің қимыл атауы; бір нәрсені ойына салу, хабардар ету	5
644	артықшылық	зат есім	бірмағыналы	Басымдық мағынасында пайдаланылады	1
645	өкілдік	зат есім	бірмағыналы	Белгілі бір қызметті атқаруға берілген билік, құқық	1
646	миссия	зат есім	көпмағыналы	1) тапсырма, тапсырыс; 2) уәкіл немесе сенімді адам басқарған дипломатиялық өкілдік; 3) миссионерлік ұйым; 4) басқа елге белгілі бір мақсатпен жіберілген дипломатиялық делегация.	1
647	аккредиттеу	етістік	бірмағыналы	Шет мемлекеттердің, халықаралық ұйымдардың байқаушыларын аккредиттеу мерзімін Орталық сайлау комиссиясы белгілейді.	5
648	заңсыз	сын есім	бірмағыналы	Заңға қайшы, заңға сай емес	2
649	Парламент	зат есім	бірмағыналы	Парламент ҚР заң шығару қызметін жүзеге асыратын Республиканың ең жоғары өкілді органы (1995 жылғы 30 тамыздағы ҚР Конституциясы 49-бап)	1
650	рәсім	зат есім	бірмағыналы	белгіленген салтанатты шара, бірнәрсені орындау тәртібі	1
651	жалпыжұрт	зат есім	бірмағыналы	Барлық, күллі, бүкіл деген мағынада да пайдаланылады	1
652	шекара	зат есім	бірмағыналы	Аумақтық жағынан бір-біріне шектесіп жатқан жер	1
655	басқару	етістік	бірмағыналы	реттеуге, қорғауға, қойылған мақсатқа сай нысанның жүйесін өзгертуге немесе жоюға бағытталған, субъектінің нысанға әрекет ету процесі	5
656	жарыспалы	сын есім	бірмағыналы	Жарыса жүретін, қабаттаса қолданылатын.	2
657	билік	зат есім	бірмағыналы	қоғамда қалыптасқан нормалар мен құндылықтарға сүйенетін және олардың қолданылуын заңдастыратын күш.	1
658	демократия	зат есім	бірмағыналы	1) жоғарғы өкімет билігі халықтың қолында болатын мемлекет құрылысы; 2) мәселені шешуге барлық ұжым мүшелері қатыстырынын, белгілі бір ұжымды басқару әдісі. 	1
659	бәсеке	зат есім	бірмағыналы	Екі тарап арасындағы талас, тартыс; бақталастық	1
660	мерзімді	сын есім	бірмағыналы	Мөлшерлі уақыты бар, кесімді мезгіл	2
661	балама	сын есім	бірмағыналы	Екінші бір заттың, атаудың орнына жүретін, соған тең, барабар, сай келетін нәрсе, атау.	2
662	жиналыс	зат есім	көпмағыналы	Ұжым мүшелерінің белгілі бір мәселені талқылау үшін, өздерінің ішкі өндірістік, экономикалық, әлеуметтік мәселелерін қарау үшін бас қосқан кеңесі; мәжіліс	1
663	көзқарас	зат есім	бірмағыналы	Адамның белгілі бір нәрсеге деген өзіндік ұғым-түсінігі, ой-пікірі.	1
664	қозғалыс	етістік	бірмағыналы	материяның аса маңызды атрибуты, өмір сүруінің тәсілі	5
665	бостандық	сын есім	бірмағыналы	Елдің, халықтың өз билігі өзінде болуы, тәуелсіздік	2
666	заңнама	зат есім	бірмағыналы	мемлекеттік билік органдарының заң шығаруы түрінде көрінетін, мемлекеттің өз міндеттерін жүзеге асыруының негізгі тәсілдерінің бірі	1
667	әлеуметтік	сын есім	бірмағыналы	Қоғамдық, өмірлік, қоғамга тән	2
668	топ	зат есім	бірмағыналы	өзара әрекеттесетін және өзара тәуелді, белгілі бір мақсаттарға бірге жетуді көздейтін екі не одан көп жеке тұлға	1
670	жыныс	зат есім	көпмағыналы	араб тіліндегі мағыналары «адам, жан-жануар және өсімдіктердің аталығы мен аналығы», «еркек немесе ұрғашы екенін білдіретін белгілер жиынтығы», «нәсіл, тек».	1
671	нәсіл	зат есім	бірмағыналы	әлеуметтік мән берілетін физикалық сипаттамаларына қарай бөлінетін адамдар категориясы	1
672	ұлт	зат есім	бірмағыналы	Тіл, территория, экономикалық өмір тұтастығы негізінде және психологиялық мінез-құлықтың ортақтығы негізінде қалыптасқан адамдардың тарихи әлеуметтік, этникалық тұтастығы	1
673	тіл	зат есім	бірмағыналы	синтаксистік, семантикалық және прагматикалық ережелер жиынтығымен реттелген белгі жүйесі.	1
674	тұрғылықты жері	зат есім	бірмағыналы	жеке тұлғаның тұрғылықты жері (почта мекен-жайы) немесе заңды тұлғаның орналасқан жері	1
675	республика	зат есім	бірмағыналы	мемлекеттік биліктің барлық жоғарғы органдары сайланбалы немесе жалпыұлттық өкілетті құрылымдармен (парламентпен) құрылатын, ал азаматтары жеке және саяси құқықтарға ие басқару түрі; осындай басқару түріндегі мемлекет.	1
676	ашық	сын есім	бірмағыналы	Жасырын емес түрде жүргізілетін процесс	2
677	ұлттық	сын есім	бірмағыналы	Белгілі бір ұлтқа тән, ұлтқа қатысты; ұлт ерекшеліктерін көрсететін, қамтитын.	2
678	мәдени	сын есім	бірмағыналы	адамзат жасаған әрі жасайтын және жеке адамның жарасымды дамуына, ҚР азаматтарының отаншылдығын тәрбиелеуге және эстетикалық қажеттері мен мүдделерін қанағаттандыруға бағытталған материалдың және рухани құндылықтар жиынтығы («Мәдениет туралы» 2006 жылғы 15 желтоқсандағы № 207 ҚРЗ 1-бап)	2
679	аралас	сын есім	бірмағыналы	Екі не одан да көп нәрселердің бірігіп, қосылып кетуі	2
680	түзету	етістік	көпмағыналы	Түзет етістігінің қимыл атауы; жөнге салу, жөнге келтіру	5
681	бөлім	зат есім	бірмағыналы	Белгілі бір мекеменің, ұйымның, өндіріс орнының құрамына кіретін жеке- жеке сала	1
682	тарау	зат есім	көпмағыналы	бөлім, сала, тармақ мағыналарында қолданылады	1
683	бап	зат есім	көпмағыналы	1) тарау, бөлім (кітаптың). 2) көз, бұлақ (кірістің). 3) бір түрі, тек, сорт. 4) грам. етістік түрі	1
684	отандық	сын есім	бірмағыналы	Отанға тән, отанға қатысты	2
685	кезектен тыс	сын есім	бірмағыналы	Алдын ала жоспарланбаған, кезексіз	2
686	іс-шара	зат есім	бірмағыналы	Бір істі орындау үшін қолданылатын амал, айла, тәсіл	1
687	бірлік	сын есім	бірмағыналы	Ауызбіршілік, бірауыздық, ынтымақтастық, татулық ұғымында қолданылады	2
688	әділ	сын есім	бірмағыналы	Шындықты сүйетін, ақиқатты жақтайтын, адал	2
689	саралау	етістік	бірмағыналы	Сарала етістігінің қимыл атауы. Сұрыптау, таңдау, іріктеу.	5
690	жауапкершілік	зат есім	бірмағыналы	Белгілі бір нәрсеге жауапты болушылық, міндетіне алушылық	1
691	тосқауыл	зат есім	бірмағыналы	Алдынан қарсы шығу, алдын бөгеу	1
692	үміткер	зат есім	бірмағыналы	Бір нәрседен (жетістіктен, жақсылықтан т.б.) үміті бар, дәмелі адам.	1
695	әлеуметтік желі	зат есім	бірмағыналы	жеке тұлғалар немесе ұйымдар «бір торапқа» айналған, өзара достасу, ортақ қызығушылық, сексуалды қарым-қатынас, абырой-бедел, эмоция және мәселеге сәйкес өзара байланыс орнатуға арналған әлеуметтік құрылым	1
696	келеңсіздік	сын есім	бірмағыналы	Жөнсіздік, епетейсіздік, оғаштық мағыналарында пайдаланылады	2
697	күмән	зат есім	бірмағыналы	әдеттік құқықтағы дауды қарау үрдісіндегі айғақтың жетік болмай, күдік, шүбә туғызуы	1
698	күдік	зат есім	бірмағыналы	қандай да бір секеммен қарау, күмән келтіру	1
699	тығырық	зат есім	бірмағыналы	Ілгері жүруі, өтуі қиын тұйық жер. Өмірде кездесетін қиыншылық; дағдарыс	1
700	дер кезі	зат есім	бірмағыналы	Өз уақтысында, дәл уағында	1
701	ашық алаң	зат есім	бірмағыналы	ашық орын	1
702	жабық алаң	зат есім	бірмағыналы	ашық емес, жабулы алаң	1
703	сенімді	сын есім	бірмағыналы	Сөзге тұрақты, іске берік, сенім артуға болатын.	2
704	қолдау	етістік	бірмағыналы	қолқабыс тигізу	5
705	журнал	зат есім	бірмағыналы	белгілі бір үлгіде жасалған және мерзімді жазбаларды, мәліметтерді, оқиғаларды, шешімдерді, кіріс әрі шығыс құжаттарын, т.б. қамтитын құжат	1
706	енгізу	етістік	бірмағыналы	Енгіз етістігінің қимыл атауы. 1. қосу, кіріктіру, кіргізу.\n2. Қолданысқа кіргізу, тәжірибеге пайдалану. 3. құру, ұйымдастыру, іске қосу. 	5
707	бүлінген	етістік	бірмағыналы	Бүлін етістігінің қимыл атауы. Жарамсыз болу, бұзылу	5
708	қапшық	зат есім	бірмағыналы	1. ұсақ заттарды салуға арналған ыдыс, кішірек қап; 2. Ішіне бір нәрселерді салып, көтеріп жүретін дорба пішіндес ыдыс	1
709	конверт	зат есім	бірмағыналы	Белгілі бір жаққа жіберу үшін (хат, кітап т,б, нәрселерді) төрт бұрышты не үшбұрышты етіліп қағаздан жасалатын пакет	1
710	жою	етістік	бірмағыналы	Жой етістігінің қимыл атауы. 1. Құрту, жоқ қылу. 2. Болдырмау, жол бермеу.	5
711	бұрмалау	етістік	бірмағыналы	Бұрмала етістігінің қимыл атауы; басқа бағытқа бұрып, теріс түсінік беру	5
712	жарамсыз	сын есім	бірмағыналы	Көңіл толмайтын, жағымсыз, қолайсыз, ұнамсыз	2
713	көпшілік	зат есім	бірмағыналы	Халық, жұртшылық, қауым мағынасында қолданылады	1
714	ресми	сын есім	бірмағыналы	Арнайы бекітілген, заңды мойындалған	2
715	тәжірибе	зат есім	бірмағыналы	Белгілі бір істі үнемі істеумен, машықтанумен болатын жұмыс дағдысы	1
716	түсіндірме	зат есім	көпмағыналы	Бір нәрсенің мән-мағынасын ашатын сипаттама	1
717	қағида	зат есім	бірмағыналы	Қалыптасқан заңдылық, белгілі ұстаным, ереже.	1
718	меже	зат есім	бірмағыналы	қандай да бір шекті білдіреді	1
719	мандат	зат есім	бірмағыналы	1) әртүрлі өкілеттілікті куәландыратын ресми құжат; 2) бұрынғы колонияны немесе жеңілген ел аумағының белгілі бір бөлігін басқару құқығы. 3) тапсырма, құқық.	1
720	пропорционалды	сын есім	бірмағыналы	негізі әрбір партия өкілді органда сайлаушылардың оларға берілген дауыстарына пропорционал санда депутаттық орындар санын алудан тұрады.	2
721	тәсіл	зат есім	бірмағыналы	Белгілі бір істі орындап шығу үшін қолданылатын әдіс, амал, айла	1
722	деңгей	зат есім	бірмағыналы	Бір нәрсенің шегі, шені; тұсы.	1
723	құлақтандыру	етістік	бірмағыналы	Болған немесе болатын оқиғаның мән-жайын айтып беру, жеткізу	5
724	тіркеу орны	зат есім	бірмағыналы	Тұрған жерді көрсетіп, құжатта тіркелген белгі.	1
725	тексеру	етістік	бірмағыналы	Тексер етістігінің қимыл атауы. Бақылау, анықтау	5
726	орналасқан жер	зат есім	бірмағыналы	сайлау учаскелерінің орналасқан жері анықталады	1
727	ынтымақтастық	сын есім	бірмағыналы	Ортақ мақсаттарға қол жеткізу үшін бірге жұмыс істейтін адамдардың өзара әрекеттестігі	2
728	Ассамблея	зат есім	бірмағыналы	1) халықаралық ұйымдардың бірқатар басқарушылық органдарының атауы; 2) кейбір елдерде парламенттің немесе оның палаталарының бірінің атауының құрамдас бөлігі; 3) белгілі бір мәселелерді шешу немесе талқылау үшін біршама адамдардың жиналысы (халықтық және сословиелік, орталық және жергілікті); бірлестік.	1
729	қол қою	етістік	бірмағыналы	Белгілі бір құжат мәтініне жауапты, қатысы бар құзырлы адамның қолтаңбасын жазуы	5
731	жариялау\nжария	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы. 1. Баспаға беру, бастырту. 2. Мәлімдеу, табу. 	5
732	мәртебе	зат есім	көпмағыналы	Топтағы адамның топ мүшелеріне қатысты тұрғысы. Абырой-атақ, даңқ, дәреже 	1
733	қызметкер	зат есім	бірмағыналы	кәсіпорын мен бірлестіктердегі штатты қызметкерлердің негізгі және көмекші құрамы	1
734	жедел	сын есім	бірмағыналы	тез, жылдам мағынасында қолданылады	2
735	қорғау	етістік	бірмағыналы	Қорға етістігінің қимыл атауы.\n1. Аман алып қалу, сақтау, пана болу.\n2. Күту, аялау, қамқорлық жасау.	5
736	қамтамасыз ету	етістік	бірмағыналы	Керек-жарақпен қамту, жабдықтау. 	5
737	баға	зат есім	бірмағыналы	1. Тауардың құны ақшамен белгіленуі, баға көлемі тауардың құнының деңгейіне және тауарға деген сұраныс пен ұсыныс қатынастарына байланысты. 2. Адамның қадір-қасиеті, парқы	1
738	шектеулі	сын есім	бірмағыналы	Тежеулі, өлшеулі мағыналарында да қолданылады	2
739	тану	етістік	бірмағыналы	(I) жеке академиялық, немесе кәсіби біліктілікті; (II) жоғары оқу орнының бағдарламаларын немесе (III) белгілі бір стандарттардың болуын растайтын құзырлы уәкілетті орган тарапынан сапаны қамтамасыз ету жөніндегі агенттіктерді формальді түрде тану.	5
740	енген	етістік	бірмағыналы	Жарамды болды, заңды айналымға кірді.	5
741	тарату	етістік	көпмағыналы	Тарат етістігінің қимыл атауы. 1. Халық арасына жайдырту, жеткізу. 2. Үлестіру, тарқату.	5
742	босату	етістік	көпмағыналы	Босат етістігінің қимыл атауы. Еркіндікке шығару, азат ету	5
743	заңды	сын есім	бірмағыналы	Заңға сәйкес келетін, заңға үйлесімді	2
744	жарғы	зат есім	бірмағыналы	мемлекеттік немесе өзге саяси билік жеке тұлға, қала, одақ немесе өзге ұйымға айрықша қызметті жүзеге асыру үшін арнайы құқық, болмаса басымдық беру	1
745	бөгде	зат есім	бірмағыналы	Бөтен, жат, бейтаныс мағынасында қолданылады	1
746	тыйым	етістік	бірмағыналы	Тыйып тастағандық, тежегендік; тоқтам мағынасын береді	5
747	редакция	зат есім	бірмағыналы	1) мәтінді өңдеу және дұрыстау, оны баспаға дайындау; 2) мәтіннің нақты жағдайы, оның қандай да бір түрі; 3) нақты тұжырымдамалар, пікір білдіру формасы; 4) басылымды басқаратын және оның мазмұнын белгілейтін немесе жариялауға арналған мәтінді өңдеуге және дайындауға арналған тапсырмаларды орындайтын қызметкерлер ұжымы; 5) қандай да бір басылым редакцияланатын бөлме.	1
748	күн тәртібі	зат есім	бірмағыналы	Жиналыс, мәжілістерде қаралатын мәселелердің түрлері мен өтілу реті.	1
749	тармақ	зат есім	бірмағыналы	Бір нәрсенің, заттың тарауы, бөлегі, саласы	1
750	жеке бас	зат есім	бірмағыналы	Бір өзі, жалғыз өзі, жеке өзіне қатысты	1
751	кедергі	зат есім	бірмағыналы	тосқауылды білдіреді	1
752	факт	зат есім	бірмағыналы	эмпириялық жəне теориялық білімді құрастыруда қатысатын тəжірибе буыны; бағдарлама құралдарымен бейімделген эмпириялық нақтылық (мəтіндер, формулалар, фотосуреттер, бейнетаспалар т.б.).	1
753	шынайы	сын есім	бірмағыналы	Дәл мәніндегі, нағыз	2
754	шақыру	етістік	бірмағыналы	Шақыр етістігінің қимыл атауы	5
755	гендерлік	сын есім	бірмағыналы	Адамдардың жыныс ерекшелігімен байланысты	2
757	мемлекет	зат есім	бірмағыналы	мемлекеттік биліктің, мемлекеттік басқарудың, соттар мен прокуратураның орталық және жергілікті органдары жүйесінің көмегімен, қоғамды басқаруды жүзеге асыратын саяси жүйенің негізгі құрамдас бөлігі	1
758	негіз	зат есім	бірмағыналы	Белгілі бір құбылыстың (нәтиженің) өмір сүруіне және оны айқындауға алғышарт жасайтын қажетті жағдай	1
759	жүзеге асыру	етістік	бірмағыналы	Бірдеңені жүзеге асыру, жүргізу.	5
760	атқарушы	зат есім	бірмағыналы	Заң шығарушы биліктің қабылдаған заңдарын атқару міндетін орындаушы лауазым иесі	1
761	жеке	зат есім	бірмағыналы	Дербес, өз алдына; бөлек. Өзіндік, өзіне тән. Дара, жалғыз.	1
762	тұлға	зат есім	бірмағыналы	қоғамда өз орнын білетін адам немесе жеке тұлға, қоғамға пайдасын тигізетін адам. «Тұлға» ұғымы адам өзін қоғамнан бөлектеп, өзгешелігін сезінетіндігін білідреді	1
763	мүмкіндік	зат есім	бірмағыналы	Бір істің іске асуына туғызылған қолайлы жағдай	1
764	мекен	зат есім	бірмағыналы	Қоныстанып орын тепкен жай, қоныс	1
765	алыс	сын есім	бірмағыналы	шалғай, жақын емес жай	2
766	иелік	зат есім	бірмағыналы	Ие болушылық, қожайындық, басшылық	1
767	меншік	зат есім	бірмағыналы	Біреудің иелігіндегі нәрсе, зат, мүлік, жер	1
768	түрткі	зат есім	бірмағыналы	субъектінің өмір сүру жағдайы ыкпалымен қалыптасатын және оның белсенділігінің бағыттылығын анықтайтын әрекетті туғызушы	1
769	мақсат	зат есім	бірмағыналы	Белгілі бір нысанаға жету жолында қойылған міндет, нысана. Алда орындалатын әрекет нәтижесінің айқын бейнесі.	1
770	шетел	зат есім	бірмағыналы	Бөтен ел, басқа мемлекет	1
771	азаматтық	сын есім	бірмағыналы	жеке тұлға мен мемлекет арасындағы олардың өзара құқықтары мен міндеттерінің жиынтығын белгілейтін тұрақты саяси-құқықтық байланыс	2
772	пікір	зат есім	бірмағыналы	Өмірдегі құбылыстар мен заттар туралы көзқарас, тұжырым, пайымдау	1
773	талас	зат есім / етістік	бірмағыналы	Белгілі бір мәселе жайындағы пікір тартысы, дау, керіс.	\N
774	митинг	зат есім	бірмағыналы	саяси және өмірдің өзге де өзекті мәселелерін талқылау, қандай да бір талаптарды қолдау, наразылықты немесе қолдаушылықты білдіру үшін көпшілік жиналысы	1
775	шеру	зат есім	бірмағыналы	Көп адамның (әскердің) бір жаққа қарай сап түзеп, салтанатты түрде жүруі; аттаныс, сапар	1
776	демонстрация	зат есім	бірмағыналы	1) бір нәрсені көпшілік алдында жариялы түрде көрсету (кинофильм демонстрация, көрмедегі өнер туындыларының демонстрация және т.б.); 2) қоғамдық-саяси көңіл-күйді, талаптарды, наразылықтарды, ынтымақтастықты (мерекелік демонстрация, үкіметке қарсы демонстрация, соғысқа қарсы демонстрация) көрсететін бұқаралық шеру.	1
777	баспа	зат есім / етістік	бірмағыналы	Баспа өнімдерін дайындап шығаратын мекеме.	\N
778	қауіпсіздік	зат есім	бірмағыналы	адамның, қоғамның және мемлекеттің өмірлік маңызды мүдделерінің ішкі және сыртқы қауіп-қатерден қорғалуының жай-күйі	1
779	тарту	етістік	бірмағыналы	Тарт етістігінің қимыл атауы. Біреуге арнап берілетін ерекше сый, арналған бағалы зат.	5
780	нұқсан	зат есім	бірмағыналы	1. Кему, азаю, кемдік, кемістік. 2. Ауысп. Зиян, зиян тигізу, зияны тию.	1
781	қалыс қалу	етістік	бірмағыналы	ерекше пікір	5
782	бедел	зат есім	бірмағыналы	Белгілі бір адамның, топтың, қоғамдық ұйымның, әлеуметтік институттың жалпы жұрт қабылдаған, мойындаған қабілеті мен еңбегі	1
783	материал	зат есім	бірмағыналы	1) бір нәрсе дайындау кезінде негіз болатын заттар; 2) қандай да бір мәселе бойынша іріктеп алынған құжаттамалар, файлдар; 3) бір нәрсеге негіз болатын дереккөз, мәлімет.	1
784	теріске шығару	етістік	бірмағыналы	мәліметтердің жалған, дұрыс еместігінің дәлелдемелері(жариялануы тиіс).	5
785	бағдарлама	зат есім	бірмағыналы	1. белгіленіп отырған іс-әрекеттің, жұмыстардың жоспары; 2. орындалатын рөлдердің, нөмірлердің, сөзсөйлеушілердің, хабарлар мен орындаушылардың басылған көрсеткіші.	1
786	пікірсайыс	зат есім 	бірмағыналы	әртүрлі көзқарастың, ой- пікірдің ортаға салынып, көпшіліктің талқысына түсуі.	1
787	орналастыру	етістік	бірмағыналы	Орналастыр етістігінің қимыл атауы, жайғастыру	5
788	уақыт	зат есім	бірмағыналы	оқиғаның ұзақтығы және тізбектілігін сипаттайтын физиканың негізгі түсініктерінің бірі	1
789	эфир	зат есім	бірмағыналы	теледидар бағдарламаларында көрсету	1
790	баспасөз	зат есім	бірмағыналы	Альманах, журнал, газет түріндегі БАҚ басылымы	1
791	мөлшер	зат есім	бірмағыналы	Белгілі бір нәрсенің, заттың жалпы аумағын көрсететін шама, көлем.	1
792	кезек	зат есім	бірмағыналы	Бірінен кейін бірі, алма кезек. Бір нәрсенің реті, жөні, орайы	1
793	кезекті	сын есім	бірмағыналы	Келесі, алдағы; кезекте тұрған мағынасында қолданылады	2
795	басылым	зат есім	бірмағыналы	Баспа орнынан басылып шыққан кітап, журнал және басқа да шығармалар.	1
796	плакат	зат есім	бірмағыналы	қысқа ғана мәтіні бар үгіттік бейне	1
797	листовка	зат есім	бірмағыналы	Үндеухат мағынасында қолданылады	1
798	ұран	зат есім 	бірмағыналы	Халықты бір іске жұмылдыру мақсатында айтылатын үндеу, шақыру, дабыл	1
799	тапсырыс	зат есім / етістік	көпмағыналы	Тапсырылған іс, жұмыс, шаруа	\N
800	таралым	зат есім	бірмағыналы	Таралу мөлшері	1
801	тысқары	сын есім	бірмағыналы	Сырт жерде, далада	2
802	аноним	сын есім	бірмағыналы	әр түрлі себептерге көбінесе, саяси жағдайға байланысты авторы көрсетілмей жарияланады	2
803	жабық	сын есім	бірмағыналы	Ашық емес, бекітулі	2
804	ашық	сын есім	бірмағыналы	жабық емес, ашық түрде келтірілу	2
805	ғимарат	зат есім	бірмағыналы	адамдардың тұруына немесе ішінде болуына, өндірістік процестерді орындауға, сондай-ақ материалдық құндылықтарды орналастыруға және сақтауға пайдаланылатын функционалдық мақсатына қарай, міндетті түрде жер бетіне салынып, тұйық көлемді құрайтын, тірек және қоршау конструкцияларынан тұратын жасанды құрылыс.	1
806	қор	зат есім	бірмағыналы	Сайлау қорларының тізіліміне сайлау қоры туралы деректерді енгізеді	1
807	қаражат	зат есім	бірмағыналы	араб тіліндегі мағынасы «шығын», «жұмсау»	1
808	шектеу	етістік	бірмағыналы	сыртқы тежелудің бір түрі.	5
809	салу	етістік	бірмағыналы	Сал етістігінің қимыл атауы, бөлу, ие қылу	5
810	сауал	зат есім / етістік	көпмағыналы	Көптен бері көкейінде жүрген, жауап таба алмай жүрген сұрақ	\N
811	келісім	зат есім / етістік	көпмағыналы	бір тоқтамға, мәмілеге келу	\N
812	жауапты	етістік	бірмағыналы	Міндетті, борышты; жауап беретін тұлға	5
813	тұжырым	зат есім	көпмағыналы	Белгілі бір істің, ойдың қорытындысы, байламы, шешімі	1
814	болжам	зат есім	бірмағыналы	құбылыстардың болашақтағы жағдайы, тенденциялары және даму кезеңдері, үдерістері немесе оқиғалары туралы ғылыми негізделген ықтимал пікірлер мен пайымдаулар	1
815	сала	зат есім	бірмағыналы	Ғылым, өнер, әдебиет, мәдениеттің, қоғамның бір арнасы, бөлік, тармағы.	1
816	өңір	зат есім	бірмағыналы	1) жеке экономикалық-географиялық немесе ұлттық құрамы мен мәдениеті жақын, немесе белгілі әскеристратегиялық пайымдауға бөлінген әлемнің бір ауданы (мемлекеттен жеке алынған); 2) жалпы табиғи, әлеуметтік-экономикалық, ұлттық-мәдени және басқа да жағдайлары бар ҚР аумағының бір бөлігі.	1
817	талдау	етістік	бірмағыналы	бір істің егжей-тегжейін ажырата зерттеу	5
818	міндет	зат есім	бірмағыналы	 Атқарылуға тиісті қызмет, іс.	1
819	сарапшы	зат есім	бірмағыналы	Объектілерді, процесстерді, құбылыстарды бағалау саласында арнайы білімі бар тұлға	1
820	лингвистикалық комиссия	зат есім	бірмағыналы	Белгілі бір мәселені шешу үшін арнайы құралған алқа	1
821	жанама	сын есім	бірмағыналы	Қосымша, қосалқы, үстеме мағынасында қолданылады	2
822	әліпби	зат есім	бірмағыналы	әріптер жиынтығы, алфавит	1
1152	салыстырмалы	сын есім	бірмағыналы	заттар немесе құбылыстардың бір-бірінен артық-кемдігін анықтау	2
1153	көппартиялық	сын есім	бірмағыналы	мемлекетте бірнеше партияның қатысуымен билік институттарын қалыптастыруға мүмкіндік беретін саяси-партиялық жүйе сипаттамасы	2
823	резерв	зат есім	бірмағыналы	1. Әйтеуір қажетке жарайтын басы артық бір нәрсенің болуы. 2. Қажетті жаңа материалдарды, күштерді алатын көздер. 3. Белгілі мерзімге сақтап қойылған әскер құрамалары, әскер бөлімдері, соғыс қимылдарын жүргізуге, шығын орнын толтыруға іске пайдаланылатын әскер, әскери техника, қару-жарақ қорының болуы және кезегі келген әскерге шақырылушылар, запасқа шыққан әскери міндеттілер.	1
824	қалпына келтіру	етістік	бірмағыналы	Жөндеу, бұрынғыдай ету.	5
825	бүтіндігі	сын есім	бірмағыналы	тұтастық мағынасында қолданылады	2
826	пломба	зат есім	бірмағыналы	Бөгде біреу ашпау үшін қатталған тауарға, бекітілген ғимарат, вагон, құрылғылардың есігіне т.б. тағылатын мөр түріндегі белгі қойылған қорғасын, не пластикалық материалдың тілімшесі.	1
827	белгілеу	етістік	бірмағыналы	Белгіле етістігінің қимыл атауы. Таңбалау, белгі қою.	5
854	қауымдастық	зат есім	бірмағыналы	Көптеген адамдар жеке байланыстарымен топтасатын қоғамдар	1
828	белгі	зат есім	бірмағыналы	құрылымдық ұйымдастырылған белгілік жүйедегі нысан қасиеттерін енгізу болып табылатын ақпараттың элементарлық бірлігі	1
829	күтім	етістік	бірмағыналы	Біреуге жасалған жағдай, бап	5
830	күнтізбе	зат есім	бірмағыналы	Ұзақ уақыт мезгілін есептеудің аспан денелерінің көрінерлік қозғалысының ауық-ауық қайталану ерекшелігіне негізделген жүйесі. 	1
831	пресс-релиз\nбаспасөз-релизі	зат есім	бірмағыналы	маңызды ақпараты бар баспасөзге арналған арнайы бюллетень.	1
832	еркін	сын есім	бірмағыналы	Өз еркі өзінде, ерікті (кісі).	2
833	еркіндік	сын есім	бірмағыналы	Еркін болушылық, еріктілік.	2
834	Біріккен Ұлттар Ұйымы	зат есім	бірмағыналы	халықаралық бейбітшілік пен қауіпсіздікті сақтау жəне нығайту, өзара ынтымақтастықты дамыту мақсатында егемен мемлекеттердің өз күштерін ерікті түрде біріктіре отырып, 1945-ші жылдың 26-шы маусымында Сан Франциско қаласында құрған халықаралық ұйымы	1
835	референдум	зат есім	бірмағыналы	қандай да бір маңызды заңнамалық актіні қабылдау мақсатында, сондай-ақ мемлекеттік өмірдің басқа да бірқатар мәселесі бойынша өткізілетін бүкілхалықтық дауыс беру	1
836	конвенция	зат есім	бірмағыналы	1) кез-келген саладағы адамдардың мінез-құлқының және іс-әрекетінің, оның ішінде, жаһандық мәселелерді шешу барысында келісім бойынша қабылданған ережелер мен қағидалар; 2) келісім бойынша уағдаласушы жақтардың құқықтар мен міндеттемелерін айқындайтын құжат; 3) субъектілердің келісімі мен уағдаласуы негізінде ережелер, белгілер, символдар, тілдік және басқа да жүйелер енгізуді ұйғаратын танымдық шара	1
837	пакт	зат есім	бірмағыналы	өзара жəне коллективтік қауіпсіздікті, өзара көмек пен шабуыл жасаспауды жəне басқа да сұрақтарды, сондай-ақ мемлекеттер ынтымақтастығының нақты салалары үшін мағынасы үлкен қағидалар мен қалыптарын реттейтін өзара жəне көптараптық халықаралық шарттың атауы	1
838	ратификация	етістік	бірмағыналы	Белгілі бір халықаралық шартты жоғарғы өкімет органының бекітіп, оған заңды күш беруі	5
839	ұғым	зат есім	бірмағыналы	Белгілі бір зат, құбылыс жөніндегі адамның түсінігі, танымы	1
840	мажоритарлық	сын есім	бірмағыналы	өзге үміткерлерге қатынасы бойынша басым көпшілік дауыс алған үміткер сайланған болып саналатын ішкі жүйе.	2
841	гибридті	сын есім	бірмағыналы	аралас болып келетін сайлау жүйесі	2
842	рейтинг	зат есім	бірмағыналы	белгілі бір белгі бойынша артықшылық көрсеткіші	1
843	орын	зат есім	бірмағыналы	Бір нәрсені қоятын, орналастыратын кеңістік.	1
844	ішкі тәртіп	зат есім	бірмағыналы	Белгілі бір қоғам не ұйым мүшелеріне ортақ, орындалуы міндетті, қалыптасқан мінез-құлық жүйесі	1
845	синтез	зат есім	бірмағыналы	Талдау нәтижесінде айқындалған белгілер мен қасиеттерді біріктіру	1
846	ресімдеу	етістік	бірмағыналы	Ресімде етістігінен жасалған өзгелік етіс. Әзірлеу мағынасында қолданылады	5
847	ұстаным	зат есім	бірмағыналы	Нақты бір мәселеге көзқарас.	1
1154	тәуелді	сын есім	бірмағыналы	бағынышты мағынасында	2
1155	дебат	зат есім	бірмағыналы	өзекті мәселелер бойынша пікірталас	1
848	билік	зат есім	бірмағыналы	жекелеген тұлғалардың (билік етушілердің) еркі мен іс әрекеті басқа тұлғалардың (бағынушылардың) еркі мен іс-әрекетінен басым тұратын, үстемдік ету мен бағыныштынық қатынастары	1
849	дода	зат есім	бірмағыналы	парсы тіліндегі мағыналары «үйме, үйінді», «көпшілік халық». Қазақ тілінде «жарыс, бәсеке» деген ауыспалы мағынада қолданылады.	1
850	консенсус	зат есім	бірмағыналы	саяси басқару мен ықпалдасудың құралдары мен әдістерін қоғамдық мойындау. Саяси консенсус арқылы саяси үстемдікті шынайы, іс жүзінде заңдастыру жүзеге асырылады.	1
851	бірізді	сын есім	бірмағыналы	жүйелі болуын қамтамасыз етеді	2
852	ықпал	зат есім	бірмағыналы	Бір адамның екінші адамға, бір нәрсенің екінші нәрсеге әсері.	1
853	көшбасшы	зат есім	бірмағыналы	Қоғамдық ұйымның жеке ықпалы әлеуметтік процестерде және жағдайларда, ұжымдағы, топтағы, қоғамдағы қарым-қатынастарды реттеуде маңызды қызмет атқаратын кез келген әлеуметтік топтың беделді мүшесі; сол қауымдастықтың мүдделерін қанағаттандыруға бағытталған ортақ іс-әрекетті ықпалдастыру мақсатында әрекет жасауға қабілетті тұлға.	1
855	төңірегінде	зат есім	бірмағыналы	Бір заттың айналасы, жан-жағы, қасы; маңы.	1
856	жұмыла	етістік	бірмағыналы	Жұмысты, белгілі бір іс-әрекетті барлығы бірдей бар ықыласымен құлай істеді.	5
857	жақтас	сын есім / етістік	көпмағыналы	Бір пікірлес, ниеттес	\N
858	ұтымды	сын есім	бірмағыналы	ұтқыр мағынасында қолданылады	2
859	тұсы	зат есім	бірмағыналы	Бір заттың тұсы, қапталы, бүйірі.	1
860	кірмеу	етістік	бірмағыналы	құрамында еместігін білдіреді	5
861	дін	зат есім	бірмағыналы	Құдайға сенетін бар адамдарды моральдық қауымдастыққа біріктіретін, қасиетті дүниелермен байланысты нанымдар мен тәжірибелер жүйесі.	1
862	наным	зат есім	бірмағыналы	Бір нәрсеге сенім, иланым	1
863	тегі	зат есім	бірмағыналы	Адамның түп нәсілін, арғы атасын білдіретін тарихи ұғым	1
864	мүлік	зат есім	бірмағыналы	қайсы біреудің меншігінде, біреуге тиесілі.	1
865	қабілетсіз	сын есім	бірмағыналы	Қабілеті жоқ, икемсіз	2
866	сот	зат есім	бірмағыналы	Азаматтық дау-дамайлар мен қылмыстық істерді қарайтын мемлекеттік заң орны және соны жүргізуші маман	1
867	мәжбүр	сын есім	бірмағыналы	амалсыз көну, көндіру, ықтиярсыз істеу, істету мағынасында қолданылады	2
868	мәжбүрлеусіз	етістік	бірмағыналы	мәжбүрлемей, бір әрекетті орындау 	5
869	қалауы	етістік	бірмағыналы	Қала етістігінің қимыл атауы. Бұйымтай сұрап алмақшы болған нәрсе, қолқа	5
870	абсентизм	зат есім	бірмағыналы	сайлаудағы немесе референдумдағы сайлаушылардың дауыс беруге ерікті қатыспауын білдіретін конституциялық құқық ғылымындағы термин	1
871	кінәлі	сын есім	бірмағыналы	Кінәсі бар, айыпты, жазықты деген мағыналарда қолданылады	2
872	айыппұл	зат есім	бірмағыналы	Қылмыстық кодексінде көзделген шекте, заңмен белгіленген және жаза тағайындау сәтіне қолданылып жүрген айлық есептік көрсеткіштің белгілі бір мөлшеріне сәйкес келетін мөлшерде не сотталған адамның жалақысының немесе ол қылмыс жасаған сәтіне белгілі бір кезең ішіндегі өзге де табысының мөлшерінде тағайындалатын ақша өндіріп алу (1997 жылғы 16 шілдедегі № 167 ҚР ҚК 40-бап)	1
873	принцип	зат есім	бірмағыналы	дүниені тану мен өзгерту процесінде фактілерді немесе білімдерді бір ізге салуға қызмет ететін, олардың кейібр жиынтығының түпнегізі ретінде көрінетін ғылыми танымның ерекше формасы	1
874	кешіктірмей	етістік	бірмағыналы	мерзімінде, уақытында жасалу керек	5
875	аулақ	сын есім	бірмағыналы	алыста болуды білдіреді	2
876	өркениетті	сын есім	бірмағыналы	Өркениеті бар, қоғамдық, мәдени дамуы жағынан көтерілген, жетілген.	2
877	алаңдау	етістік	бірмағыналы	Алаңда етістігінің қимыл атауы; көңілі орнықпау, мазасыздану. 	5
878	үлес	зат есім / етістік	көпмағыналы	Бір нәрседен әрбір адам өзіне тиесілін бөліп алу.	\N
879	жеңіс	етістік	бірмағыналы	Жеңіске жетуге көмектесу, бірге жеңу	5
880	мониторинг	зат есім / етістік	бірмағыналы	жүйенің жай-күйін білдіретін аз көлемдегі көрсеткіштерді анықтау	\N
881	лайықты	сын есім	бірмағыналы	Сай келетін, тең, қолайлы	2
882	дұрыс	сын есім	бірмағыналы	Тиісті ереже нормаға сай, тура, бабымен	2
883	назар	зат есім / етістік	көпмағыналы	Белгілі бір обьектіні немесе әрекет үстіндегі адамның практикалық және танымдық қызметінің бағытын және назарын қамтамасыз ететін жәй-күй.	\N
884	тыс	сын есім	бірмағыналы	бір аймаққа тиелісі болмайтын	2
885	көш ілгері	сын есім	бірмағыналы	Әжептәуір алда, әлдеқайда артық	2
1042	сауалнама	зат есім	бірмағыналы	сқрақтар қою арқылы алғашқы ақпаратты жинау әдісі	1
886	салыстырғанда	етістік	бірмағыналы	Салыстыр етістігінің қимыл атауы; ойлаудың логикалық амалдарының бірі.	5
887	құрылым	зат есім	бірмағыналы	Бір нәрсенің құрылысы, құрамы, жүйесі	1
888	кереғар	сын есім	бірмағыналы	Қарама-қарсы, қайшы мағынасында қолданылады	2
889	уақытша	сын есім	бірмағыналы	Белгілі бір уақытқа дейін, қысқа мерзімге	2
890	қадам	зат есім	бірмағыналы	Адым мағынасында қолданылады	1
930	әкесінің аты	зат есім	бірмағыналы	Адамның әкесінің аты көрсетіледі	1
891	араласу	етістік	бірмағыналы	Аралас етістігінің қимыл атауы. Араласып-құраласу, қарым-қатынаста болу. 	5
892	құрал	зат есім	бірмағыналы	Бір істі жүзеге асырудың әдіс-тәсілі, амал-айласы.	1
893	бұзу	етістік	бірмағыналы	Дағдылы, үйреншікті, қалыпты жағдайды бүлдіру, өзгерту.	5
894	қаржыландыру	етістік	бірмағыналы	ағымдағы шығындар мен күрделі жұмсалымдарды қажетті қаржылық ресурстармен қамтамасыз ету кәсіпорынның (компанияның) немесе мемлекеттің меншік қаражаттарының, тартылған, қарыз қаражаттар мен басқаларының есебінен жүзеге асырылады.	5
895	қол жеткізу	етістік	бірмағыналы	Жүзеге асыру, мақсатқа жету, орындау. 	5
896	жеребе	зат есім	бірмағыналы	Бірдемеге кезек алу үшін, я арадағы дауды әділ шешу үшін бір түстес нөмірленген зат, я нәрсені жасырын алудың атауы.	1
897	бойынша	шылау	бірмағыналы	Бір нәрсеге сәйкес, лайық	8
898	кесте	зат есім	бірмағыналы	бір ақпарат графаға түсіріп жазылған мәлімет	1
899	бірлесу	етістік	бірмағыналы	Бірлес етістігінің қимыл атауы.	5
900	стенд	зат есім	бірмағыналы	Әр түрлі суреттер, портреттер, графиктер ілінген тақта.	1
901	тақта	зат есім	бірмағыналы	Түрлі хабарландыру, жарнама ілінетін, тақтайдан жасалған құрылғы.	1
902	тұғыр\nтұғырлық	зат есім	бірмағыналы	Тірек, тіреу, сүйеніш мағынасында қолданылады	1
903	жарақтандыру	етістік	бірмағыналы	Жарақтандыр етістігінің қимыл атауы; жабдықтандыру, керекті құрал-жабдықпен қамтамасыз ету.	5
904	құндылық	зат есім	бірмағыналы	танымның, белгілі бір объектінің адам үшін, топ үшін, қоғам үшін қасиетті деп танылуы.	1
905	коэффициент	зат есім	бірмағыналы	Ауыспалы немесе белгісіз шаманың көбейткіші болатын, тұрақты немесе белгілі шама.	1
906	араздық	зат есім	бірмағыналы	Өзара келіспеушілік, қырғиқабақтық, өшпенділік	1
907	қатыгездік	зат есім	бірмағыналы	Адамның мінез-құлқындағы жағымсыз іс-әрекет; қаталдық, мейірімсіздік, тасжүректік.	1
908	уағыз	зат есім	бірмағыналы	«насихаттау, үгіттеу», «үйрету, ұқтыру, жөн сілтеу»	1
909	баяндау	етістік	бірмағыналы	Суреттеу арқылы оқиға мен сюжетті баяндау. 	5
910	тиісті	сын есім	бірмағыналы	Қажетті, міндетті. 	2
911	үкім	зат есім	бірмағыналы	«шешім, бұйрық», «билік, үстемдік».	1
912	прокуратура	зат есім	бірмағыналы	заңдардың сақталуын қадағалауды жүзеге асыратын және заң бұзушыларды сотқа тартатын мемлекеттік билік органы.	1
913	дайындық	етістік	бірмағыналы	Бір әрекетті орындауға әзірлікті білдіреді. Әзірлік, даярлық мағыналарында қолданылады. 	5
914	іс-әрекет	зат есім	бірмағыналы	жұмыс жасауды және орындауды білдіреді	1
915	кезең	зат есім	бірмағыналы	Қандай да бір белгіленген уақыт мезетін көрсетеді. Уақыт, мезгіл, кез мағынасында қолданылады	1
916	көзделмесе	етістік	бірмағыналы	Нысанага алынбайды, дәлденбейді	5
917	қате	зат есім	бірмағыналы	«дұрыс емес, бұрыс», «жаңылыс, қателік жіберу, жаза басу»	1
918	шегінде	шылау	бірмағыналы	Бір нәрсенің жеткен жері, аяқталып таусылар шекарасы	8
919	қасақана	үстеу	бірмағыналы	Біле тұра, әдейі жасалған әрекет	9
920	жалған	сын есім	бірмағыналы	Шындығы жоқ, өтірік дегенді білдіреді	2
921	өзге	үстеу	бірмағыналы	Бөлек, бөтен, басқа мағынасында қолданылады	9
922	күн	зат есім	бірмағыналы	Таңның атысынан, күннің батуына дейінгі аралық; күндіз	1
923	алғашқы	сын есім	бірмағыналы	Әуелгі, бастапқы, бірінші кезектегі мағына	2
924	қол жинау	етістік	бірмағыналы	Көптеген адамдардың қолдарын жинақтаумен жүргізіледі	5
925	растау	етістік	бірмағыналы	Раста етістігінің қимыл атауы. Растау мәселесін жүргізеді. Бір нәрсенің шындығын, дұрыстығын қуаттау, дәлелдеу; куәгер болу.	5
926	астана	зат есім	бірмағыналы	«белгілі бір мемлекеттің саяси, мәдени орталығы», «босаға, табалдырық»	1
927	жалпы саны	зат есім	бірмағыналы	Барлығына қатысты, көпшілікке қатысты, ортақ	1
928	кем дегенде	шылау	бірмағыналы	аз дегенде мағынасында қолданылады	8
929	аты	зат есім	көпмағыналы	есімін білдіреді	1
931	қолы	зат есім	көпмағыналы	өкілетті лауазымды тұлғаның немесе құжат авторының жеке қолын білдіретін құжат реквизиті.	1
932	көшірме	зат есім	бірмағыналы	Түпнұсқа жазудан көшіріліп алынған дана	1
933	қажетті	сын есім	бірмағыналы	Қажеті бар, керекті.	2
934	растамау	етістік	бірмағыналы	Бір нәрсенің орындалуын реттемеу	5
935	жолдау	зат есім / етістік	көпмағыналы	Жолда етістігінің қимыл атауы; жіберу, арнап жазу	\N
936	анықталған	етістік	бірмағыналы	Анықта етістігінің қимыл атауы; айқындау.	5
937	кіріс	зат есім	бірмағыналы	Белгілі бір істі, шаруаны орындауға дереу араласу, тікелей жұмылу, соны орындауға қатысу, қолға алу. Табыс келу . Мемлекеттік мекеме.	1
938	қолданыста	етістік	бірмағыналы	қолданылатын кезді көрсетеді	5
939	жұбайы	зат есім	бірмағыналы	Ерлі-зайыптылар ұғымын  білдіреді	1
940	сұратылған	етістік	бірмағыналы	Сұрат етістігінің қимыл атауы. Бір ақпаратты алу мағынасында қолданылады  	5
941	медициналық	сын есім	бірмағыналы	Медицинаға қатысты, медицинамен байланысты.	2
942	денсаулық	зат есім	бірмағыналы	Адам ағзасының қалыпты жағдайы, есен-саулықты, сонымен қатар ауру-сырқауының жағдайы.	1
943	тізбе	зат есім	бірмағыналы	Қатарлай тізілген тізбек.	1
944	ұсыну	етістік	бірмағыналы	жеке құрамды тағайындау, ауыстыру немесе қолдау көрсету туралы ережесі, сондай-ақ қандай да бір бірлікке жататын (бұйым, операция) өндірілген өнім, мекеме қызметіне қатысты белгілі бір әрекет немесе іс-шараны куәландыратын құжат.	5
945	әділет	зат есім / сын есім	көпмағыналы	ғибраттық-праволық, әлеуметтік-саяси сана категориясы, адамның түпкілікті праволарының тарихи кезеңдерде өзгерістерге ұшырауына байланысты оған берілетін шынайы баға туралы ұғым.	\N
946	министрлік	зат есім	бірмағыналы	Белгілі бір салаға басшылық көрсетуде министр басқарып отырған мекеме	1
947	үзінді	зат есім	бірмағыналы	Сөйлеген сөзден, шығармадан бөлініп алынған бөлшек	1
948	өмірбаян	зат есім	бірмағыналы	Жеке адамның өмір тарихы	1
949	жарна	зат есім	бірмағыналы	Белгілі бір ұйымға мүше болғаны үшін төленіп тұратын қаржы	1
950	декларация	зат есім	бірмағыналы	1) заңды шаралардың негізгі қағидаларын үкіметтің немесе партияның атынан ресми түрде мәлімдеу; 2) мағлұмдама; мәлімдеме, бір немесе бірнеше мемлекеттің халықаралық саясаттың белгілі бір мәселесі туралы бірігей жасайтын мәлімдемесі; 3) мағлұмдама; мағлұмдау хат; мағлұмхат (кеден алымы алынатын тауарлардың тізімін әйгілеу); 4) салық төлеуші адамдардың өзінің мүлкі, кіріс мөлшері жайын хабарлап отыратын мәлімдемесі.	1
951	бас тарту	етістік	бірмағыналы	болдырмау мақсатында жасалатын әрекет	5
952	жол бермеу	етістік	бірмағыналы	қандай да бір әрекетке, жұмысқа, процесске жол берілмеуді қарастырады	5
953	түпкілікті	сын есім	бірмағыналы	Түбегейлі мағынасы түрінде қолданылып тұр	2
1156	шынайы	сын есім	бірмағыналы	шын,ақиқат мағынасында	2
954	бюджет	зат есім	бірмағыналы	Белгіленген уақыт кезеңі ішінде жобаланатын кірістер мен шығыстардың мәлімдемесі.	1
955	қаражат	зат есім	бірмағыналы	араб тіліндегі мағынасы «шығын», «жұмсау»; қажетке жұмсалатын ақша, пұл	1
956	шығыс	зат есім	бірмағыналы	шығымы, түсім мағынасында қолданылады. Шығарылған шығындарды білдіреді	1
957	қаулы	зат есім	бірмағыналы	үкіметтің өкімі, мемлекеттік басқару актісі.	1
958	қосымша	зат есім / сын есім / үстеу	көпмағыналы	Бір нәрсені толықтыра түсетін, толымды ететін; қосалқы, жанама	\N
959	сай	сын есім	бірмағыналы	қандай да бір процесстің, жұмыстың сәйкестілігін анықтайды	2
960	семинар	зат есім	бірмағыналы	ғылыми мәселелер бойынша кеңес, сондай-ақ біліктілікті арттыруға арналған жиналыс	1
1043	сүрінбеу	үстеу	бірмағыналы	кедергілерден құламай өту мағынасында	9
961	сессия	зат есім	бірмағыналы	мәжілістер, өкілетті органдар, сот, ғылыми мекемелер жұмысындағы кезеңдер	1
962	спикер	зат есім	бірмағыналы	бірқатар парламенттік мемлекеттердегі парламент басшысының немесе палата басшысының аты.	1
963	сөз сөйлеу	етістік	бірмағыналы	бір мезгілде болатын нақтылы сөйлеу	5
965	атқару	етістік	бірмағыналы	Атқар етістігінің қимыл атауы. Орындау, жұмыс істеу	5
966	жұмыс	зат есім	бірмағыналы	Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті. 	1
967	мүгедек	сын есім	бірмағыналы	тіршілік-тынысының шектелуіне және оны әлеуметтік қорғау қажеттігіне әкеп соқтыратын аурулардан, жарақаттардан, олардың салдарынан, кемістіктерден организм функциялары тұрақты бұзылып, денсаулығы бұзылған адам.	2
968	алмасу	етістік	бірмағыналы	бірінің орнын бірі басу, ауысу	5
969	бағыт	зат есім	бірмағыналы	ұшу аппаратының, кеменің жүріс жолы, қозғалысының бағыты; Әскери қызметкерлердің дайындығының тәртібі мен мәнін анықтайтын басшылық құжат (құрал); Жоғары және орта әскери оқу орындарында оқудың кезеңі, дәрежесі.	1
970	тапсырма	зат есім	бірмағыналы	Міндеттелген жұмыс, іс	1
971	бөлісу	етістік	бірмағыналы	Әркімге белгілі бір нәрсені тарату, бөліп беру	5
972	бірқатар	үстеу	бірмағыналы	Көлем жағынан аз емес, саны әлденеше,көбірек	9
973	жаңғырту	етістік	бірмағыналы	Белгілі бір дүниені, халықтық мұраны жаңарту, қайта өңдеу	5
974	дамыту	етістік	бірмағыналы	Дамыт етістігінің қимыл атауы	5
975	реттеу	етістік	бірмағыналы	Ретте етістігінің қимыл атауы	5
976	жетілдіру	етістік	бірмағыналы	Жетілдір етістігінің қимыл атауы	5
977	базасында	зат есім	бірмағыналы	негіз, бір заттың негіздемесі	1
978	регламент	зат есім	бірмағыналы	белгілі бір іс-әрекет тәртіптерін реттеу ережелері, қандай да бір мемлекеттік орган мен оның құрылымдық бөлімшелері қызметінің ішкі тәртібін реттейтін нормативтік құқықтық акт	1
979	реформа	зат есім	бірмағыналы	1) жақсарту, қайта жаңғырту мақсатында бір нәрсенің құрылымына жасалған өзгерістер; 2) ел үкіметінің заңнамалық және мемлекеттік құрылымға жұмыс істеп тұрған мемлекеттік құрылымның іргесін бұзбай өзгеріс жасауы.\n	1
980	үміт	зат есім	бірмағыналы	Белгілі бір істің, ойдың жүзеге асуына білдірілген сенім	1
981	сәйкессіздік	зат есім	бірмағыналы	талаптың орындалмауы. Біріне-бірі дөп түспеушілік, сай келмеушілік, үйлеспеушілік	1
982	жақсарту	етістік	бірмағыналы	Жақсарт етістігінің қимыл атауы	5
983	ауқымды	сын есім	бірмағыналы	Көлемі үлкен, аялы, кеңдік, көлемділік	2
984	бақылаушы	зат есім	бірмағыналы	халықаралық мемлекетаралық ұйымдардың жұмысына, халықаралық мəслихаттарға т.б. форумдарға шекті түрде қатысуға жолданған мемлекеттік жəне халықаралық ұйымдардың өкілдері	1
985	шектеусіз	сын есім	бірмағыналы	Шексіз, шегі жоқ, шектелмеген.	2
1157	сыншыл	сын есім	бірмағыналы	сын айтуға бейімділік	2
1158	толыққанды		бірмағыналы	барлық жағынан қамтылған мағынасында	\N
1159	меншік құқығы	зат есім	бірмағыналы	субьектінің заң жүзінде танылатын және қорғалатн өзіне тиесілі мүлікті өз ұалауныша пайдалану құқығы	1
986	міндеттеме	зат есім / етістік	бірмағыналы	міндеттемеге сәйкес бір адам (борышқор) басқа адамның (несие берушінің) пайдасына мүлік беру, жұмыс орындау, ақша төлеу және т.б. сияқты белгілі бір әрекеттер жасауға, не белгілі бір әрекет жасаудан тартынуға міндетті, ал несие беруші борышқордан өз міндеттерін орындауын талап етуге құқылы. Несие беруші борышқордан атқарылғанды қабылдауға міндетті. Сөзсіз орындаймын деп жазбаша түрде берілген серт, уәде .	\N
987	сұхбат	зат есім	бірмағыналы	бағытталған диалог	1
988	бейтарап	сын есім	бірмағыналы	парсы тіліндегі мағыналары «бейтарап (нейтралды)», «әділ, объективті». Қазақ тілінде «ешкімге қосылмай, оқшау жүру», «енжар, селқос», «қалыс қалу» тәрізді ұғымдарда қолданылады	2
989	шағымдану	етістік	бірмағыналы	Шағымдан етістігінің қимыл атауы	5
990	палата	зат есім	бірмағыналы	ҚР Парламенті құрамына енетін жоғарғы мемлекеттік заң орындарының аты.	1
991	сенатор	зат есім	бірмағыналы	Сенат мүшелерінің басшысы. Сенат мүшесі	1
1044	жуырда	сын есім	бірмағыналы	болашақтағы мерзім көрсеткіші	2
1045	дода	зат есім	бірмағыналы	жарыс, сайыс мағынасында	1
1047	оңтайлы	сын есім	бірмағыналы	ынғайлы мағынасында	2
1040	дәстүрлі	сын есім	бірмағыналы	әлеуметтік немесе этникалық ортаға тән құбылыс	2
1041	артықшылық	зат есім	бірмағыналы	салыстырмалылық көрсеткіші	1
1048	қолжетімді	сын есім	бірмағыналы	заттың құнын бағалау дәрежесі	2
1049	өріс	зат есім	омоним	физикалық шама, географиялық шама	1
992	адал	сын есім	бірмағыналы	«рұқсат етілген, тыйым салынбаған», «арам емес, таза», «кіршіксіз, пәк». Сонымен қатар «адамгершілікті жоғары қоятын, ар-ұяты күпіті» (адал адам; жүрегі адал), «сатқын емес, шын берілген» (Отанына адал), «арам жолмен таппаған, таза еңбек, маңдай тер» (адал табыс), «тура, анық, шын» (адал шешім, адал достық) деген ауыспалы мағыналарда да кеңінен қолданылады.	2
994	кездесу 	зат есім	бірмағыналы	адамдардың бетпе-бет жолығысуы	1
995	кандидатура	зат есім	бірмағыналы	сайлауға түсетін немесе лауазымға ұсынылатын адам	1
996	жаңғырту	етістік	бірмағыналы	өмірдің әр саласындағы жетістіктер, қоғамның алға жылжуы	5
997	тәуелсіз	сын есім	бірмағыналы	заттардың немесе құбылыстардың тәуелді еместігі	2
998	бұрмалаушылық	зат есім	бірмағыналы	бұрмалап, терістеп көрсету	1
999	ашықтық	зат есім	бірмағыналы	ашық, кең мағынасында	1
1000	бақылаушы	зат есім	бірмағыналы	белгілі бір процесті қадағалайтын түлға	1
1001	белсенді	сын есім	бірмағыналы	адамның іс-қимылы	2
1002	қоғам	зат есім	бірмағыналы	өздерін мәдениеті ортақ бірлестік деп білетін адамдар тобы	1
1004	бюллетень	зат есім	бірмағыналы	кандидаттардың аты жазылған сайлау парағы	1
1005	кедергісіз	сын есім	бірмағыналы	қарсы бағытталған әсердің жоқтығын сипаттайтын шама	2
1006	дауыс	зат есім	омоним	дауыс шықты	1
1007	дауыс	зат есім	омоним	дауыс берді	1
1008	электронды	сын есім	бірмағыналы	сандық форматта жасалған дүниелер	2
1009	мажоритарлық	сын есім	бірмағыналы	сайлау жүйесінің түрі	2
1010	мәслихат	зат есім	бірмағыналы	аймақтардағы сайланбалы орган	1
1011	енгізу	етістік	бірмағыналы	жаңа бір затты белгілі бір ортаға қосу	5
1012	жетілдіру	етістік	омоним	заман талабына сай өзгерістер енгізу	5
1013	ұлттық	сын есім	бірмағыналы	қандай да бір этностың қалыптасқан формасы	2
1014	құндылықтар 	зат есім	омоним	рухани байлық	1
1015	сіңіру	етістік	омоним	физиологиялық процесс	5
1016	спикер	зат есім	бірмағыналы	парламент немесе палата басшысы	1
1017	жұртшылық	зат есім	бірмағыналы	әлеуметтік топ	1
1018	басқару	етістік	бірмағыналы	субъектінің нысанға қатысты әрекет ету процессі	5
1019	күшейту	етістік	бірмағыналы	белгілі бір процесті нығайту оған қарқын беру	5
1020	сенім	зат есім	бірмағыналы	адамның қорғашан ортаға қарым-қатынасын анықтайтын ұғым	1
1021	үдеріс	зат есім		алға жылжу құбылысы	1
1022	парламент	зат есім	бірмағыналы	мемлекеттегі сайланбалы заң шығарушы орган	1
1023	қабырға	зат есім	омоним	геометриялық фигураның қырлары, адам сүйегі	1
1024	жаңғыру	етістік	бірмағыналы	қоғамның саяси мәдениетінің өсуі, қабалданған әрекеттердің тиімділігі	5
1025	серпін	зат есім	бірмағыналы	талпыныс мағынасында	1
1026	әкім	зат есім	бірмағыналы	әкімшілік аумақтың басшысы	1
1027	көзқарас	зат есім	бірмағыналы	субъектің белгілі бір процестерге қатысты ойы	1
1028	қалыптастыру	етістік	бірмағыналы	затты немесе тұлғаны қажет деңгейге жеткізу	5
1029	айрықша	сын есім	бірмағыналы	заттың ерекшелігін атап көрсету	2
1030	маңызды	сын есім	бірмағыналы	нысанның немесе процестің ерекшелігін кқрсету дәрежесі	2
1031	жүйелі	сын есім	бірмағыналы	мағыналы деген нүсқада	2
1032	тікелей	сын есім	бірмағыналы	тура мағынасында	2
1033	үні	зат есім	бірмағыналы	дауыс, дыбыс мағынасында	1
1034	еркін	үстеу	бірмағыналы	бос, тәуелсіз мағынасында	9
1035	өкіл	зат есім	бірмағыналы	ұйымның қызығушылықтарын жеткізуші түлға	1
1036	жүйе	зат есім	бірмағыналы	белгілі бір тұтастық, бірлестік құратын көптеген құрамдас бөліктер жиыны	1
1037	науқан	зат есім	бірмағыналы	іс-шараның кезеңі	1
1038	жүздесу	етістік	бірмағыналы	көрісу мағынасында	5
1039	өзекті	сын есім	бірмағыналы	бір заттың белгілі бір мерзімдегі маңыздылығы	2
1050	референдум	зат есім	бірмағыналы	маңызды мәселелер бойынша халықтың таңдау жасау формасы	1
1053	тетігі	зат есім	бірмағыналы	негізгі бөлшегі мағынасында	1
1054	ұстаным	зат есім	бірмағыналы	наұты бір пікірде болу	1
1055	сезіну	үстеу	бірмағыналы	сезу, білу мағынасында	9
1056	іргелі	сын есім	бірмағыналы	іргетас ретінде қызмет етуді көрсету	2
1057	бірлік	зат есім	омоним	өлшем бірлігі, достастық мағынасында	1
1058	тұтас	сын есім	бірмағыналы	барлығы деген мағынада	2
1059	табиғи	сын есім	бірмағыналы	қоршаған ортағы жанды және жансыз заттардың жиынтығы	2
1060	біржолата	үстеу	бірмағыналы	белгілі бір істі түбегейлі шешу мағынасында	9
1061	әділдік	зат есім	бірмағыналы	адамның өмір сүру жағдайлары мен сапасын білдіретін әлеуметтік-этикалық категория	1
1062	бәсеке	зат есім	бірмағыналы	іс-қимыл өткізетін салада ұнамды нәтижеге қол жеткізуге бағытталған жарыс	1
1063	түбегейлі	сын есім	бірмағыналы	нақты, тұтас мағынасында	2
1064	филиал	зат есім	бірмағыналы	бір ұйымның белгілі бір мекендегі өкілдігі	1
1065	партиялық жүйе	зат есім	бірмағыналы	партияда қалыптасқан механизм мен басқару әдістерінің жиыны	1
1066	тағайындау	етістік	бірмағыналы	лауазымға лайықты тұлғаларды бекіту рәсімі	5
1067	рәсім	зат есім	бірмағыналы	символдық мағынадағы күндерді мерекелеуге арналған әрекеттердің дәйектілігі	1
1068	баламалы	сын есім	бірмағыналы	заттың басқа да алмастыруға болатындығын білдіру	2
1069	көпшілік	зат есім	бірмағыналы	халықтың басым бқлігін білідретін ұғым	1
1070	өкілеттік	зат есім	бірмағыналық	лауазымды тұлғаның қызмет ету мерзімі	1
1071	сыбайластық	зат есім	бірмағыналы	адамдар арасында негативті қарым-қатынас дәрежесінің көрсеткіші	1
1072	рушылдық	зат есім	бірмағыналы	адамдардың туыстық топқа бөлінуі	1
1073	кесірлі	сын есім	бірмағыналы	зиянды деген мағынада	2
1074	түзету	етістік	бірмағыналы		5
1075	құзырлы	сын есім	бірмағыналы	уәкілеттіліктің бір түрі	2
1076	дербестік	зат есім	бірмағыналы	жеке, тәуелсіз мағынасында	1
1077	өзгеріс	зат есім	бірмағыналы	құбылыстардың жаңаша бір сипат алуы	1
1078	қысылтаяң шақ	зат есім	бірмағыналы	күрделі уақыт мерзімі	1
1079	реформа	зат есім	бірмағыналы	қоғамның басты негіздерін қайта құру	1
1080	талқыға салу	етістік	бірмағыналы	белгілі бір тақырыпты әңгіме қылу	5
1081	кешенді	сын есім	бірмағыналы	біртұтастықты құрайтын заттардың,құбылыстардың жиынтығы	2
1082	концептуалды	сын есім	бірмағыналы	халықтың ғалам туралы қорытқан ойы	2
4	төраға	зат есім	бірмағыналы	Мәжілісті, жиналысты басқарушы ресми тұлға.	1
5	арнайы 	сын есім	бірмағыналы  	Әдейілеп, арнайы 	2
6	делегация 	зат есім	бірмағыналы	қандай да бір ұйымның немесе мемлекеттің форум, съезд, конференция, халықаралық келіссөздерде және т.б. мүддесін қорғайтын тұлғалар тобы (делегаттар).	1
7	Шығыс Қазақстан	зат есім	бірмағыналы	Қазақстанның ірі облыстарының бірі.	1
8	облыс	зат есім	бірмағыналы	Кез келген республика құрамындағы ең ірі әкімшілік-аумақтық бөлік, аймақ.	1
9	сапар	зат есім	бірмағыналы	Бет алып шыққан алыс жол; саяхат.	1
10	үй	зат есім	бірмағыналы	Баспана, пана.	1
11	мәдениет үйі	зат есім	бірмағыналы	мәдени-ағарту, кейде спорттық мекемелерді орналастыруға арналған ғимарат.\n	1
12	үлкен 	сын есім	бірмағыналы	Көлемі бойынша біршама ауқымды немесе жасы көп деген мағынада қолданылады.	2
13	зал	зат есім	бірмағыналы	жиналыстар мен кездесулер т.б. өткізуге арналған үлкен бөлме.	1
14	қала	зат есім	бірмағыналы	Зауыты, фабрикасы, өнеркәсібі, оқу орындары бар ірі елді мекен.	1
15	жұртшылық	зат есім	бірмағыналы	көпшілік, қауым, кейде ел-жұрт мағынасында қолданылады. Дәстүрлі қазақы ортада әдетте ауыл адамдарына немесе бүкіл руластарына қарата айтылады.	1
16	мәселе	зат есім	бірмағыналы	Шешімін табуды қажет ететін келелі іс-әрекет, алда тұрған міндет .	1
17	ашық 	сын есім	бірмағыналы	Жабық, жасырын емес қалыпты сипаттайды.	2
179	көрініс	зат есім	бірмағыналы	 Сыртқы дүниенің көзге шалынған сыртқы бейнесі	1
1083	өтпелі	сын есім	бірмағыналы	уақыттық тұрақсыз кезеңінің атауы	2
1084	сайлауалды	сын есім	бірмағыналы	сайлауға дайындық шараларын ұйымдастыру мерзімі	2
1085	бұқара	зат есім	бірмағыналы	халықтың басқарушы топтан өзгелері	1
1086	атқарушы билік	зат есім	бірмағыналы	белгілі бір территориялық аумақтағы шаруашылық-әкімшілік басқару органы	1
1087	үміткер	зат есім	бірмағыналы	белгілі бір лауазымға дәмеленуші, конкурсқа қатыстушы тұлға	1
1088	дауыс беру	етістік	бірмағыналы	адамның конституциялық құқығы	5
1089	халық қалаулылары	зат есім	бірмағыналы	сайлау нәтижесі бойынша халықтың таңдау түскен тұлғалар	1
1090	кепілдік	зат есім	бірмағыналы	растаушы, еркіндік беруші сөз немесе құжат	1
1091	аманат	зат есім	бірмағыналы	маңызды затты орындауға тапсырма беру/алу мағынасында	1
1092	заңды	сын есім	бірмағыналы	іс-әрекеттердің заң аясында болуын көрсету	2
252	етемін	етістік	бірмағыналы	бір істі орындаймын	5
348	жағдай	зат есім	бірмағыналы	Хал-ахуал, тұрмыс-жай	1
485	жануар	зат есім	бірмағыналы	ірі организмдер дүниесіндегі негізгі екі топтың бірі (екіншісі – өсімдіктер)	1
1178	Бала	зат есім	омоним	әке-шешенің перзенті, ұрпағы. Жыныс ерекшелігіне қарай ұл, қыз, жас шамасына қарай	1
669	жағдай	зат есім	бірмағыналы	Хал-ахуал, тұрмыс-жай	1
730	парақ	зат есім	бірмағыналы	бір бет қағаз	1
993	ашық	сын есім	омоним	түстің ашықтығын білдіру	2
1052	лайықты	сын есім	бірмағыналы	бағалау көрсеткіші	2
1130	жаңаша	сын есім	бірмағыналы		2
1093	қанағаттандыру	етістік	бірмағыналы	біреудің үміттерін немесе қажеттіліктерін орындау	5
1094	халықаралық қатынастар	зат есім	бірмағыналы	әлемдік деңгейде іс-әрекеттер жасайтын субъектілер арасындағы экономикалық, саяси және мәдени байланыстар	1
1096	қосарланған	сын есім	бірмағыналы	екі заттың біріккен түрін түсіндіретін ұғым	2
1097	ықпалды	сын есім	бірмағыналы	адамның кәсіби және филикалық түрғыда басым дәрежесінің көрсеткіші	2
1098	көрнекті	сын есім	бірмағыналы	адамның кәсіби деңгейі мен парасаттылығын сипайттайтын сөз	2
1099	демократиялық	сын есім	бірмағыналы	биліктің негізгі көзі халық екендігін білдіреді	2
1100	бағалы	сын есім	бірмағыналық	заттың құнын атап көрсету	2
1101	сирек	сын есім	бірмағыналы	табиғатта аз, шашыранды кездесетіндігін білдіретін өлшем атауы	2
1102	айрықша	сын есім	бірмағыналы	ерекше мағынасында	2
1103	ерік білдіру	етістік	бірмағыналы	пікірін жеткізу	5
1104	әкім	зат есім	бірмағыналы	аймақтық немесе ауылдық шаруашылық-әкімшілік басқару жүйесінің басшысы	1
1105	саяси партия	зат есім	бірмағыналы	мемлекеттік билікті қолға лау және жүргізу мақсатында құрылған адамдардың ерікті одағы	1
1106	саясат	зат есім	бірмағыналы	мемлекеттік немесе қоғамдық істерді басқару шеберлігі	1
1107	реформа	зат есім	бірмағыналы	қоғамның басты негіздерін қайта құру	1
1161	екіұшты	сын есім	бірмағыналы	екі түрлі деген мағынада	2
1162	таңдау	зат есім	бірмағыналы	бар ақпараттау негізінде керегін анықтау	1
1163	енжар	сын есім	бірмағыналы	бейімсіздік, құлықсыздық мағынасында	2
1164	аппеляция	зат есім	бірмағыналы	сайлау немесе емтихан нәтижелеріне қанғаттандай, оны қайтадан қарауға шағым түсіру	1
1165	мажоритарлық	сын есім	бірмағыналы	партиялық жүйе арқылы сайлау системасы	2
1166	санаулы	сын есім	бірмағыналы	заттың белгілі бір мөлшерде екенін білдіру	2
1167	пропорционалдық	сын есім	бірмағыналы	барлық бөліктердің тең болу жағдайы	2
1168	бұқаралық ақпарат	зат есім	бірмағыналы	халыққа ақпарат жеткізу құралдары	1
1169	бақылаушы	зат есім	бірмағыналы	белгілі бір процессті қадағалаушы	1
1170	әділдік	зат есім	бірмағыналы	адами өзара қатынастардағы істердің дұрыс болуын білдіретін моральдық сананың ұғымы	1
1171	бетбұрыс	зат есім	бірмағыналы	өмірдегі өзгерістер	1
2	сайлау	етістік	омоним	сайлаудың немесе сайланудың ресми және ұйымдасқан процесі	5
\.


--
-- TOC entry 3743 (class 0 OID 18319)
-- Dependencies: 236
-- Data for Name: synonym_word; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonym_word (word_id, synonym_id) FROM stdin;
1	1
1	2
1	\N
1	4
2	5
2	6
2	\N
3	8
3	9
3	\N
4	11
4	12
4	\N
4	14
5	15
5	16
5	\N
5	18
6	19
6	20
6	\N
6	22
7	23
7	24
7	\N
7	26
8	27
8	28
8	\N
8	30
9	31
9	32
9	\N
9	34
10	35
10	36
10	\N
10	38
11	39
11	40
11	\N
11	42
12	43
12	44
12	\N
12	46
12	47
13	48
13	49
13	\N
13	51
14	52
14	53
14	\N
14	55
14	56
15	57
15	58
15	\N
15	60
15	61
16	62
16	63
16	\N
16	65
16	66
17	67
17	68
17	\N
17	70
17	71
18	72
18	73
18	\N
18	75
19	76
19	77
19	\N
19	79
19	80
19	81
20	82
20	83
20	\N
20	85
20	86
21	87
21	88
21	\N
21	90
21	91
21	92
22	93
22	94
23	95
23	96
23	\N
23	98
23	99
24	100
24	101
24	\N
24	103
24	104
24	105
25	106
25	107
25	\N
25	109
25	110
26	111
26	112
26	\N
26	114
27	115
27	116
27	\N
27	118
27	119
28	120
28	121
28	\N
28	123
28	124
28	125
29	126
29	127
29	\N
29	129
29	130
30	131
30	132
30	\N
30	134
30	135
31	136
31	137
31	\N
31	139
32	140
32	141
32	\N
32	143
33	144
33	145
33	\N
33	147
33	148
33	149
34	150
34	151
34	\N
34	153
34	154
34	155
35	156
35	157
35	\N
35	159
35	160
35	161
36	162
36	163
36	\N
36	165
36	166
37	167
37	168
37	\N
37	170
37	171
38	172
38	173
38	\N
38	175
39	176
39	177
39	\N
39	179
40	180
40	181
40	\N
40	183
40	184
40	185
41	186
41	187
41	\N
41	189
42	190
42	191
42	\N
42	193
42	194
42	195
43	196
43	197
43	\N
43	199
44	200
44	201
44	\N
45	203
45	204
45	\N
46	206
46	207
46	\N
47	209
47	210
47	\N
47	212
47	213
48	214
48	215
48	\N
48	217
49	218
49	219
49	\N
49	221
50	222
50	223
50	\N
50	225
50	226
51	227
51	228
51	\N
51	230
51	231
51	232
52	233
52	234
52	\N
52	236
52	237
53	238
53	239
54	240
54	241
54	\N
54	243
54	244
55	245
55	246
56	247
56	248
56	\N
56	250
56	251
57	252
57	253
58	254
58	255
58	\N
58	257
59	258
59	259
59	\N
59	261
60	262
60	263
60	\N
60	265
61	266
61	267
61	\N
62	269
62	270
62	\N
62	272
62	273
63	274
63	275
63	\N
63	277
64	278
64	279
64	\N
64	281
65	282
65	283
65	\N
65	285
66	286
66	287
67	288
67	289
67	\N
67	291
68	292
68	293
68	\N
68	295
69	296
69	297
69	\N
69	299
70	300
70	301
70	\N
70	303
71	304
71	305
71	\N
71	307
72	308
72	309
72	\N
72	311
73	312
73	313
73	\N
73	315
74	316
74	317
74	\N
74	319
74	320
74	321
75	322
75	323
75	\N
75	325
76	326
76	327
76	\N
76	329
76	330
77	331
77	332
77	\N
77	334
77	335
78	336
78	337
78	\N
78	339
78	340
79	341
79	342
79	\N
79	344
79	345
80	346
80	347
80	\N
80	349
80	350
81	351
81	352
81	\N
81	354
81	355
82	356
82	357
82	\N
82	359
82	360
83	361
83	362
83	\N
83	364
83	365
84	366
84	367
84	\N
84	369
84	370
85	371
85	372
85	\N
85	374
86	375
86	376
86	\N
86	378
86	379
87	380
87	381
87	\N
87	383
87	384
88	385
88	386
88	\N
88	388
89	389
89	390
89	\N
89	392
90	393
90	394
90	\N
90	396
91	397
91	398
91	\N
91	400
92	401
92	402
92	\N
92	404
93	405
93	406
93	\N
93	408
94	409
94	410
94	\N
95	412
95	413
95	\N
96	415
96	416
96	\N
97	418
97	419
97	\N
98	421
98	422
98	\N
99	424
100	425
100	426
100	\N
100	428
100	429
100	430
101	431
101	432
101	\N
101	434
101	435
103	436
103	437
104	438
104	439
104	\N
104	441
104	442
104	443
105	444
105	445
105	\N
105	447
106	448
106	449
106	\N
106	451
107	452
107	453
107	\N
107	455
107	456
108	457
108	458
111	459
111	460
112	461
112	462
112	\N
112	464
112	465
113	466
113	467
113	\N
113	469
113	470
114	471
114	472
114	\N
114	474
114	475
115	476
115	477
115	\N
115	479
115	480
116	481
116	482
116	\N
116	484
116	485
117	486
117	487
117	\N
117	489
117	490
118	491
118	492
118	\N
118	494
118	495
119	496
119	497
119	\N
119	499
120	500
120	501
120	\N
120	503
121	504
122	505
122	506
122	\N
123	508
123	509
123	\N
124	511
124	512
125	513
125	514
125	\N
125	516
125	517
125	518
126	519
126	520
126	\N
127	522
127	523
127	\N
127	525
128	526
128	527
128	\N
128	529
128	530
129	531
129	532
129	\N
131	534
131	535
131	\N
131	537
131	538
132	539
132	540
132	\N
133	542
134	543
134	544
134	\N
134	546
135	547
135	548
135	\N
135	550
136	551
136	552
136	\N
137	554
137	555
137	\N
137	557
138	558
138	559
141	560
141	561
142	562
142	563
143	564
143	565
143	\N
144	567
144	568
144	\N
145	570
145	571
145	\N
146	573
146	574
146	\N
147	576
148	577
148	578
148	\N
148	580
148	581
148	582
150	583
150	584
150	\N
154	586
154	587
154	\N
155	589
155	590
156	591
156	592
157	593
157	594
157	\N
157	596
157	597
158	598
158	599
159	600
159	601
159	\N
159	603
159	604
159	605
160	606
160	607
161	608
161	609
161	\N
161	611
162	612
162	613
162	\N
162	615
163	616
164	617
164	618
165	619
165	620
165	\N
166	622
166	623
166	\N
166	625
166	626
168	627
168	628
168	\N
169	630
169	631
169	\N
170	633
170	634
172	635
172	636
172	\N
172	638
172	639
172	640
173	641
173	642
175	643
175	644
175	\N
175	646
176	647
176	648
176	\N
176	650
176	651
177	652
177	653
177	\N
178	655
178	656
178	\N
178	658
178	659
178	660
179	661
179	662
180	663
180	664
181	665
181	666
181	\N
181	668
181	669
181	670
182	671
183	672
183	673
183	\N
184	675
184	676
185	677
185	678
185	\N
186	680
186	681
187	682
187	683
187	\N
187	685
188	686
188	687
189	688
189	689
189	\N
189	691
189	692
190	693
190	694
190	\N
191	696
191	697
192	698
192	699
193	700
193	701
193	\N
193	703
194	704
194	705
194	\N
194	707
194	708
195	709
195	710
195	\N
195	712
195	713
196	714
196	715
197	716
197	717
197	\N
197	719
197	720
197	721
198	722
198	723
199	724
199	725
199	\N
200	727
200	728
201	729
201	730
202	731
202	732
203	733
203	734
203	\N
203	736
204	737
204	738
205	739
205	740
206	741
206	742
206	\N
207	744
207	745
208	746
208	747
209	748
209	749
209	\N
209	751
209	752
210	753
210	754
210	\N
211	756
211	757
212	758
212	759
213	760
213	761
214	762
214	763
215	764
215	765
216	766
216	767
216	\N
217	769
217	770
217	\N
217	772
218	773
218	774
218	\N
218	776
218	777
219	778
219	779
219	\N
219	781
220	782
220	783
220	\N
221	785
221	786
221	\N
221	788
221	789
222	790
222	791
223	792
223	793
223	\N
223	795
224	796
224	797
225	798
225	799
225	\N
225	801
226	802
226	803
226	\N
226	805
226	806
227	807
227	808
227	\N
227	810
228	811
228	812
229	813
230	814
230	815
230	\N
230	817
231	818
231	819
231	\N
231	821
232	822
232	823
233	824
233	825
234	826
234	827
235	828
235	829
235	\N
236	831
236	832
236	\N
236	834
236	835
237	836
237	837
237	\N
238	839
238	840
238	\N
239	842
239	843
240	844
240	845
240	\N
241	847
241	848
241	\N
241	850
241	851
242	852
242	853
242	\N
243	855
243	856
243	\N
243	858
244	859
244	860
244	\N
244	862
244	863
245	864
245	865
245	\N
245	867
245	868
246	869
246	870
247	871
247	872
247	\N
248	874
248	875
248	\N
248	877
248	878
249	879
249	880
249	\N
249	882
250	883
250	884
250	\N
250	886
251	887
251	888
252	889
252	890
253	891
253	892
253	\N
254	894
254	895
254	\N
255	897
255	898
256	899
256	900
256	\N
256	902
257	903
257	904
257	\N
258	906
258	907
258	\N
258	909
259	910
259	911
259	\N
260	913
260	914
260	\N
261	916
261	917
262	918
262	919
263	920
263	921
264	922
264	923
265	924
265	925
266	926
266	927
267	928
267	929
267	\N
267	931
267	932
268	933
268	934
268	\N
269	936
269	937
269	\N
269	939
270	940
270	941
270	\N
270	943
271	944
271	945
272	946
272	947
273	948
275	949
275	950
275	\N
276	952
276	953
276	\N
277	955
277	956
277	\N
277	958
279	959
279	960
279	\N
279	962
280	963
280	964
280	\N
280	966
281	967
281	968
281	\N
281	970
283	971
283	972
283	\N
283	974
284	975
284	976
285	977
285	978
287	979
287	980
287	\N
288	982
288	983
288	\N
289	985
289	986
289	\N
289	988
289	989
290	990
290	991
290	\N
291	993
291	994
292	995
292	996
293	997
293	998
293	\N
293	1000
294	1001
294	1002
294	\N
295	1004
295	1005
295	\N
296	1007
296	1008
296	\N
297	1010
297	1011
297	\N
298	1013
298	1014
298	\N
300	1016
300	1017
301	1018
301	1019
301	\N
302	1021
302	1022
302	\N
302	1024
303	1025
303	1026
303	\N
303	1028
304	1029
304	1030
304	\N
305	1032
305	1033
305	\N
305	1035
306	1036
306	1037
307	1038
307	1039
307	\N
308	1041
308	1042
308	\N
308	1044
308	1045
308	1046
309	1047
309	1048
310	1049
310	1050
310	\N
311	1052
311	1053
311	\N
312	1055
312	1056
312	\N
313	1058
314	1059
314	1060
314	\N
314	1062
317	1063
317	1064
317	\N
318	1066
318	1067
318	\N
318	1069
318	1070
319	1071
319	1072
320	1073
320	1074
321	1075
321	1076
321	\N
321	1078
321	1079
322	1080
322	1081
322	\N
322	1083
323	1084
323	1085
323	\N
324	1087
324	1088
325	1089
325	1090
325	\N
325	1092
326	1093
326	1094
326	\N
326	1096
326	1097
327	1098
327	1099
328	1100
328	1101
328	\N
328	1103
328	1104
329	1105
329	1106
329	\N
329	1108
330	1109
330	1110
330	\N
331	1112
331	1113
331	\N
331	1115
331	1116
332	1117
332	1118
332	\N
332	1120
333	1121
333	1122
333	\N
334	1124
334	1125
334	1126
335	1127
335	1128
335	\N
335	1130
336	1131
336	1132
337	1133
337	1134
338	1135
338	1136
339	1137
339	1138
340	1139
340	1140
340	\N
341	1142
341	1143
341	\N
342	1145
343	1146
343	1147
344	1148
344	1149
344	\N
345	1151
345	1152
346	1153
346	1154
347	1155
347	1156
347	\N
348	1158
348	1159
348	\N
349	1161
349	1162
349	\N
350	1164
350	1165
350	\N
350	1167
350	1168
351	1169
351	1170
352	1171
352	1172
352	\N
352	1174
353	1175
353	1176
353	\N
353	1178
354	1179
354	1180
354	\N
354	1182
355	1183
355	1184
356	1185
356	1186
356	\N
356	1188
357	1189
357	1190
357	\N
357	1192
357	1193
357	1194
358	1195
358	1196
358	\N
358	1198
358	1199
359	1200
359	1201
359	\N
359	1203
360	1204
360	1205
360	\N
360	1207
360	1208
361	1209
361	1210
361	\N
361	1212
361	1213
362	1214
362	1215
362	\N
362	1217
362	1218
363	1219
363	1220
363	\N
363	1222
363	1223
363	1224
364	1225
364	1226
364	\N
364	1228
364	1229
365	1230
365	1231
366	1232
366	1233
367	1234
367	1235
367	\N
368	1237
368	1238
369	1239
369	1240
369	\N
369	1242
370	1243
370	1244
370	\N
370	1246
371	1247
371	1248
371	\N
372	1250
372	1251
372	\N
373	1253
373	1254
373	\N
373	1256
373	1257
374	1258
374	1259
375	1260
375	1261
375	\N
375	1263
376	1264
376	1265
376	\N
376	1267
377	1268
377	1269
377	\N
377	1271
377	1272
377	1273
378	1274
378	1275
378	\N
378	1277
378	1278
379	1279
379	1280
380	1281
380	1282
380	\N
381	1284
381	1285
381	\N
382	1287
382	1288
383	1289
383	1290
383	\N
383	1292
383	1293
383	1294
384	1295
384	1296
384	\N
384	1298
384	1299
384	1300
385	1301
385	1302
386	1303
386	1304
386	\N
387	1306
387	1307
388	1308
388	1309
388	\N
389	1311
389	1312
390	1313
390	1314
390	\N
391	1316
391	1317
391	\N
392	1319
392	1320
392	\N
392	1322
392	1323
393	1324
393	1325
394	1326
394	1327
395	1328
395	1329
395	\N
395	1331
396	1332
396	1333
396	\N
396	1335
396	1336
397	1337
397	1338
397	\N
397	1340
398	1341
398	1342
398	\N
398	1344
398	1345
399	1346
399	1347
399	\N
399	1349
399	1350
400	1351
400	1352
400	\N
400	1354
400	1355
400	1356
401	1357
401	1358
401	\N
401	1360
401	1361
401	1362
402	1363
402	1364
403	1365
403	1366
403	\N
403	1368
404	1369
404	1370
404	\N
404	1372
405	1373
405	1374
405	\N
405	1376
405	1377
406	1378
406	1379
406	\N
406	1381
406	1382
406	1383
407	1384
407	1385
407	\N
408	1387
408	1388
408	\N
408	1390
408	1391
408	1392
409	1393
409	1394
409	\N
409	1396
409	1397
409	1398
410	1399
410	1400
410	\N
410	1402
410	1403
410	1404
411	1405
411	1406
411	\N
411	1408
411	1409
411	1410
412	1411
412	1412
412	\N
412	1414
412	1415
413	1416
413	1417
413	\N
413	1419
413	1420
414	1421
414	1422
414	\N
414	1424
414	1425
414	1426
415	1427
415	1428
415	\N
415	1430
415	1431
415	1432
416	1433
416	1434
416	\N
416	1436
416	1437
417	1438
417	1439
417	\N
417	1441
417	1442
417	1443
418	1444
418	1445
418	\N
418	1447
418	1448
418	1449
419	1450
419	1451
419	\N
419	1453
419	1454
419	1455
420	1456
420	1457
420	\N
420	1459
420	1460
421	1461
421	1462
421	\N
421	1464
421	1465
421	1466
422	1467
422	1468
422	\N
422	1470
422	1471
422	1472
423	1473
423	1474
423	\N
423	1476
423	1477
424	1478
424	1479
424	\N
424	1481
424	1482
424	1483
425	1484
425	1485
425	\N
425	1487
425	1488
426	1489
426	1490
426	\N
426	1492
426	1493
426	1494
427	1495
427	1496
427	\N
427	1498
427	1499
427	1500
428	1501
428	1502
428	\N
428	1504
428	1505
428	1506
429	1507
429	1508
429	\N
429	1510
429	1511
429	1512
430	1513
430	1514
430	\N
430	1516
430	1517
431	1518
431	1519
431	\N
431	1521
431	1522
431	1523
432	1524
432	1525
432	\N
433	1527
433	1528
433	\N
433	1530
433	1531
434	1532
434	1533
434	\N
434	1535
435	1536
435	1537
435	\N
435	1539
435	1540
435	1541
436	1542
436	1543
436	\N
437	1545
437	1546
437	\N
437	1548
437	1549
437	1550
438	1551
438	1552
438	\N
438	1554
438	1555
438	1556
439	1557
439	1558
439	\N
439	1560
439	1561
439	1562
440	1563
440	1564
440	\N
440	1566
440	1567
440	1568
441	1569
441	1570
442	1571
442	1572
442	\N
442	1574
442	1575
442	1576
443	1577
443	1578
443	\N
443	1580
443	1581
443	1582
444	1583
444	1584
444	\N
444	1586
444	1587
444	1588
445	1589
445	1590
445	\N
445	1592
445	1593
445	1594
446	1595
446	1596
446	\N
446	1598
446	1599
447	1600
447	1601
447	\N
447	1603
447	1604
447	1605
448	1606
448	1607
448	\N
448	1609
448	1610
448	1611
449	1612
449	1613
449	\N
449	1615
449	1616
449	1617
450	1618
450	1619
450	\N
450	1621
450	1622
450	1623
451	1624
451	1625
451	\N
451	1627
452	1628
452	1629
452	\N
452	1631
452	1632
452	1633
453	1634
453	1635
453	\N
453	1637
453	1638
453	1639
454	1640
454	1641
454	\N
454	1643
454	1644
454	1645
455	1646
455	1647
455	\N
455	1649
455	1650
455	1651
456	1652
456	1653
456	\N
456	1655
456	1656
456	1657
457	1658
457	1659
457	\N
457	1661
457	1662
457	1663
458	1664
458	1665
458	\N
458	1667
458	1668
458	1669
459	1670
459	1671
459	\N
459	1673
459	1674
459	1675
460	1676
460	1677
460	\N
460	1679
460	1680
460	1681
461	1682
461	1683
461	\N
461	1685
462	1686
462	1687
462	\N
462	1689
462	1690
463	1691
463	1692
463	\N
463	1694
463	1695
464	1696
464	1697
464	\N
464	1699
464	1700
464	1701
465	1702
465	1703
465	\N
465	1705
465	1706
465	1707
466	1708
466	1709
466	\N
466	1711
466	1712
467	1713
467	1714
468	1715
468	1716
468	\N
468	1718
469	1719
469	1720
470	1721
470	1722
470	\N
470	1724
470	1725
471	1726
471	1727
471	\N
472	1729
472	1730
472	\N
472	1732
472	1733
473	1734
473	1735
473	\N
473	1737
473	1738
474	1739
474	1740
474	\N
474	1742
474	1743
474	1744
475	1745
475	1746
475	\N
475	1748
476	1749
476	1750
476	\N
476	1752
477	1753
477	1754
477	\N
477	1756
477	1757
477	1758
478	1759
478	1760
478	\N
478	1762
478	1763
479	1764
479	1765
479	\N
479	1767
479	1768
479	1769
480	1770
480	1771
480	\N
480	1773
480	1774
481	1775
481	1776
481	\N
481	1778
481	1779
481	1780
482	1781
482	1782
482	\N
482	1784
482	1785
482	1786
483	1787
483	1788
483	\N
483	1790
483	1791
483	1792
484	1793
484	1794
484	\N
484	1796
484	1797
485	1798
485	1799
485	\N
485	1801
485	1802
486	1803
486	1804
486	\N
486	1806
486	1807
486	1808
487	1809
487	1810
487	\N
487	1812
487	1813
487	1814
488	1815
488	1816
488	\N
488	1818
488	1819
488	1820
489	1821
489	1822
489	\N
489	1824
489	1825
489	1826
490	1827
490	1828
490	\N
490	1830
490	1831
490	1832
491	1833
491	1834
491	\N
491	1836
492	1837
492	1838
492	\N
492	1840
492	1841
492	1842
493	1843
494	1844
494	1845
495	1846
496	1847
496	1848
497	1849
497	1850
498	1851
498	1852
499	1853
499	1854
499	\N
499	1856
499	1857
499	1858
500	1859
500	1860
500	\N
503	1862
503	1863
503	\N
504	1865
504	1866
505	1867
505	1868
506	1869
507	1870
508	1871
508	1872
510	1873
510	1874
510	\N
511	1876
511	1877
511	\N
511	1879
511	1880
512	1881
512	1882
513	1883
513	1884
513	\N
513	1886
513	1887
514	1888
514	1889
514	\N
515	1891
515	1892
515	\N
516	1894
516	1895
516	\N
516	1897
516	1898
517	1899
517	1900
518	1901
519	1902
519	1903
521	1904
522	1905
522	1906
522	\N
523	1908
524	1909
524	1910
524	\N
525	1912
526	1913
526	1914
526	\N
526	1916
526	1917
527	1918
528	1919
529	1920
529	1921
529	\N
530	1923
530	1924
530	\N
530	1926
531	1927
531	1928
533	1929
534	1930
534	1931
534	\N
535	1933
535	1934
535	\N
535	1936
536	1937
537	1938
537	1939
537	\N
537	1941
538	1942
538	1943
538	\N
538	1945
538	1946
538	1947
540	1948
542	1949
542	1950
543	1951
543	1952
543	\N
543	1954
543	1955
543	1956
544	1957
544	1958
545	1959
545	1960
545	\N
546	1962
546	1963
546	\N
546	1965
548	1966
548	1967
549	1968
549	1969
549	\N
550	1971
550	1972
551	1973
551	1974
551	\N
552	1976
552	1977
552	\N
552	1979
552	1980
552	1981
554	1982
555	1983
555	1984
556	1985
556	1986
556	\N
557	1988
557	1989
558	1990
558	1991
559	1992
559	1993
559	\N
559	1995
559	1996
560	1997
560	1998
560	\N
560	2000
560	2001
560	2002
561	2003
561	2004
562	2005
562	2006
563	2007
565	2008
565	2009
565	\N
565	2011
565	2012
566	2013
566	2014
566	\N
567	2016
567	2017
567	\N
568	2019
568	2020
568	\N
568	2022
568	2023
568	2024
569	2025
569	2026
570	2027
570	2028
571	2029
571	2030
571	\N
571	2032
571	2033
571	2034
572	2035
572	2036
572	\N
572	2038
572	2039
573	2040
573	2041
574	2042
574	2043
575	2044
575	2045
575	\N
575	2047
575	2048
575	2049
576	2050
577	2051
577	2052
577	\N
578	2054
578	2055
578	\N
578	2057
578	2058
579	2059
579	2060
579	\N
579	2062
579	2063
580	2064
580	2065
580	\N
580	2067
580	2068
582	2069
582	2070
582	\N
582	2072
582	2073
582	2074
583	2075
583	2076
583	\N
583	2078
583	2079
583	2080
584	2081
584	2082
584	\N
585	2084
586	2085
586	2086
586	\N
586	2088
587	2089
587	2090
587	\N
587	2092
588	2093
588	2094
589	2095
590	2096
590	2097
590	\N
590	2099
590	2100
590	2101
591	2102
591	2103
592	2104
594	2105
594	2106
595	2107
595	2108
595	\N
595	2110
595	2111
595	2112
596	2113
596	2114
596	\N
596	2116
596	2117
596	2118
597	2119
597	2120
597	\N
597	2122
597	2123
598	2124
598	2125
598	\N
598	2127
598	2128
599	2129
599	2130
600	2131
600	2132
601	2133
601	2134
602	2135
602	2136
602	\N
602	2138
602	2139
603	2140
604	2141
605	2142
606	2143
606	2144
606	\N
606	2146
607	2147
607	2148
607	\N
607	2150
608	2151
608	2152
609	2153
609	2154
610	2155
610	2156
610	\N
610	2158
610	2159
610	2160
611	2161
611	2162
611	\N
611	2164
611	2165
612	2166
613	2167
613	2168
614	2169
614	2170
615	2171
617	2172
617	2173
617	\N
617	2175
617	2176
617	2177
618	2178
619	2179
619	2180
619	\N
619	2182
619	2183
619	2184
620	2185
620	2186
622	2187
622	2188
622	\N
622	2190
622	2191
622	2192
623	2193
623	2194
624	2195
624	2196
624	\N
626	2198
626	2199
627	2200
627	2201
628	2202
629	2203
629	2204
630	2205
630	2206
631	2207
632	2208
632	2209
632	\N
633	2211
633	2212
634	2213
636	2214
636	2215
636	\N
637	2217
638	2218
639	2219
640	2220
640	2221
640	\N
640	2223
642	2224
642	2225
642	\N
642	2227
643	2228
643	2229
644	2230
644	2231
644	\N
644	2233
644	2234
645	2235
645	2236
646	2237
646	2238
646	\N
647	2240
647	2241
650	2242
650	2243
651	2244
651	2245
651	\N
651	2247
652	2248
652	2249
652	\N
652	2251
652	2252
652	2253
653	2254
653	2255
653	\N
653	2257
655	2258
655	2259
655	\N
656	2261
657	2262
657	2263
657	\N
657	2265
659	2266
659	2267
659	\N
660	2269
660	2270
660	\N
660	2272
661	2273
661	2274
662	2275
662	2276
662	\N
663	2278
663	2279
664	2280
664	2281
664	\N
665	2283
665	2284
665	\N
667	2286
668	2287
668	2288
668	\N
668	2290
668	2291
669	2292
669	2293
669	\N
669	2295
669	2296
671	2297
671	2298
671	\N
671	2300
671	2301
671	2302
674	2303
674	2304
674	\N
676	2306
676	2307
678	2308
678	2309
678	\N
679	2311
679	2312
679	\N
679	2314
680	2315
680	2316
680	\N
680	2318
681	2319
681	2320
681	\N
682	2322
682	2323
682	\N
683	2325
683	2326
683	\N
685	2328
687	2329
687	2330
687	\N
687	2332
687	2333
687	2334
688	2335
688	2336
688	\N
688	2338
689	2339
689	2340
689	\N
689	2342
689	2343
689	2344
690	2345
691	2346
691	2347
691	\N
691	2349
692	2350
693	2351
693	2352
693	\N
696	2354
696	2355
696	\N
696	2357
696	2358
697	2359
697	2360
697	\N
697	2362
697	2363
697	2364
698	2365
698	2366
698	\N
698	2368
698	2369
698	2370
699	2371
700	2372
700	2373
700	\N
700	2375
700	2376
703	2377
703	2378
704	2379
704	2380
704	\N
704	2382
704	2383
704	2384
705	2385
706	2386
706	2387
706	\N
706	2389
707	2390
707	2391
707	\N
708	2393
709	2394
710	2395
710	2396
710	\N
711	2398
711	2399
711	\N
712	2401
712	2402
712	\N
713	2404
713	2405
713	\N
713	2407
713	2408
715	2409
715	2410
715	\N
716	2412
716	2413
716	\N
716	2415
716	2416
716	2417
717	2418
717	2419
718	2420
718	2421
718	\N
718	2423
718	2424
718	2425
720	2426
720	2427
720	\N
720	2429
720	2430
721	2431
721	2432
721	\N
721	2434
722	2435
723	2436
723	2437
723	\N
724	2439
725	2440
725	2441
725	\N
725	2443
726	2444
726	2445
726	\N
727	2447
727	2448
727	\N
727	2450
727	2451
729	2452
730	2453
731	2454
731	2455
731	\N
731	2457
731	2458
732	2459
732	2460
732	\N
732	2462
732	2463
733	2464
734	2465
734	2466
734	\N
734	2468
734	2469
734	2470
735	2471
735	2472
735	\N
735	2474
735	2475
736	2476
736	2477
736	\N
736	2479
737	2480
737	2481
738	2482
738	2483
738	\N
738	2485
739	2486
739	2487
740	2488
740	2489
741	2490
741	2491
742	2492
742	2493
742	\N
745	2495
745	2496
745	\N
745	2498
745	2499
745	2500
749	2501
749	2502
750	2503
751	2504
751	2505
751	\N
751	2507
751	2508
751	2509
753	2510
753	2511
753	\N
753	2513
753	2514
754	2515
754	2516
756	2517
758	2518
758	2519
758	\N
758	2521
759	2522
759	2523
759	\N
759	2525
759	2526
759	2527
760	2528
760	2529
761	2530
761	2531
761	\N
761	2533
761	2534
761	2535
762	2536
762	2537
763	2538
764	2539
764	2540
764	\N
764	2542
765	2543
765	2544
765	\N
765	2546
765	2547
765	2548
766	2549
766	2550
767	2551
767	2552
768	2553
768	2554
769	2555
769	2556
769	\N
769	2558
772	2559
772	2560
773	2561
773	2562
773	\N
773	2564
773	2565
773	2566
774	2567
775	2568
776	2569
777	2570
778	2571
778	2572
779	2573
779	2574
779	\N
779	2576
780	2577
780	2578
780	\N
780	2580
781	2581
781	2582
782	2583
782	2584
783	2585
783	2586
783	\N
784	2588
784	2589
786	2590
786	2591
786	\N
786	2593
786	2594
787	2595
787	2596
787	\N
787	2598
787	2599
787	2600
788	2601
788	2602
788	\N
788	2604
788	2605
788	2606
791	2607
791	2608
791	\N
791	2610
792	2611
792	2612
793	2613
793	2614
793	\N
794	2616
794	2617
794	\N
794	2619
794	2620
794	2621
795	2622
797	2623
797	2624
797	\N
798	2626
798	2627
798	\N
799	2629
800	2630
801	2631
801	2632
801	\N
802	2634
804	2635
805	2636
805	2637
806	2638
806	2639
807	2640
807	2641
808	2642
808	2643
809	2644
809	2645
809	\N
809	2647
809	2648
810	2649
810	2650
811	2651
811	2652
811	\N
811	2654
811	2655
811	2656
812	2657
812	2658
813	2659
813	2660
813	\N
813	2662
813	2663
814	2664
814	2665
814	\N
814	2667
815	2668
815	2669
815	\N
816	2671
816	2672
816	\N
816	2674
816	2675
816	2676
817	2677
817	2678
817	\N
818	2680
818	2681
818	\N
819	2683
820	2684
821	2685
821	2686
821	\N
822	2688
822	2689
823	2690
823	2691
824	2692
825	2693
825	2694
825	\N
825	2696
825	2697
825	2698
827	2699
827	2700
827	\N
828	2702
828	2703
828	\N
828	2705
829	2706
829	2707
830	2708
830	2709
832	2710
832	2711
832	\N
832	2713
832	2714
833	2715
833	2716
833	\N
833	2718
836	2719
836	2720
836	\N
836	2722
836	2723
836	2724
837	2725
837	2726
838	2727
839	2728
839	2729
843	2730
843	2731
843	\N
843	2733
844	2734
844	2735
845	2736
845	2737
845	\N
846	2739
846	2740
846	\N
847	2742
847	2743
847	\N
848	2745
848	2746
848	\N
849	2748
850	2749
850	2750
850	\N
850	2752
850	2753
850	2754
851	2755
851	2756
851	\N
852	2758
853	2759
853	2760
853	\N
853	2762
854	2763
854	2764
855	2765
855	2766
855	\N
855	2768
856	2769
856	2770
857	2771
857	2772
857	\N
857	2774
858	2775
858	2776
859	2777
859	2778
859	\N
861	2780
861	2781
862	2782
862	2783
864	2784
864	2785
864	\N
864	2787
864	2788
865	2789
865	2790
865	\N
865	2792
865	2793
867	2794
867	2795
867	\N
867	2797
867	2798
868	2799
868	2800
869	2801
869	2802
870	2803
871	2804
871	2805
871	\N
871	2807
871	2808
873	2809
873	2810
874	2811
874	2812
875	2813
875	2814
875	\N
875	2816
875	2817
875	2818
876	2819
876	2820
877	2821
877	2822
878	2823
878	2824
878	\N
879	2826
880	2827
881	2828
881	2829
881	\N
881	2831
881	2832
882	2833
882	2834
882	\N
883	2836
883	2837
883	\N
884	2839
884	2840
884	\N
884	2842
884	2843
884	2844
885	2845
886	2846
887	2847
888	2848
888	2849
888	\N
888	2851
889	2852
889	2853
889	\N
890	2855
890	2856
891	2857
891	2858
891	\N
892	2860
892	2861
892	\N
893	2863
893	2864
893	\N
893	2866
893	2867
893	2868
895	2869
895	2870
895	\N
895	2872
896	2873
897	2874
897	2875
897	\N
899	2877
899	2878
899	\N
899	2880
899	2881
899	2882
902	2883
902	2884
902	\N
902	2886
903	2887
903	2888
903	\N
903	2890
904	2891
904	2892
904	\N
906	2894
906	2895
906	\N
906	2897
906	2898
906	2899
907	2900
907	2901
907	\N
907	2903
908	2904
908	2905
909	2906
909	2907
909	\N
909	2909
910	2910
910	2911
910	\N
911	2913
911	2914
911	\N
911	2916
911	2917
911	2918
913	2919
913	2920
914	2921
914	2922
915	2923
915	2924
915	\N
915	2926
915	2927
915	2928
917	2929
917	2930
917	\N
919	2932
919	2933
920	2934
920	2935
920	\N
920	2937
921	2938
921	2939
921	\N
921	2941
921	2942
921	2943
922	2944
923	2945
923	2946
923	\N
923	2948
923	2949
923	2950
924	2951
924	2952
925	2953
926	2954
928	2955
928	2956
929	2957
930	2958
931	2959
933	2960
933	2961
933	\N
933	2963
934	2964
934	2965
935	2966
935	2967
935	\N
936	2969
936	2970
936	\N
936	2972
936	2973
937	2974
937	2975
937	\N
937	2977
938	2978
939	2979
940	2980
941	2981
943	2982
944	2983
944	2984
947	2985
947	2986
947	\N
947	2988
948	2989
948	2990
949	2991
949	2992
950	2993
950	2994
950	\N
951	2996
951	2997
951	\N
952	2999
953	3000
953	3001
955	3002
955	3003
956	3004
956	3005
956	\N
957	3007
957	3008
958	3009
958	3010
958	\N
959	3012
959	3013
959	\N
959	3015
959	3016
960	3017
960	3018
960	\N
961	3020
961	3021
961	\N
963	3023
964	3024
964	3025
965	3026
965	3027
966	3028
966	3029
966	\N
966	3031
966	3032
967	3033
967	3034
967	\N
967	3036
968	3037
968	3038
968	\N
968	3040
969	3041
969	3042
969	\N
969	3044
970	3045
970	3046
971	3047
972	3048
972	3049
972	\N
972	3051
972	3052
972	3053
973	3054
974	3055
974	3056
974	\N
975	3058
975	3059
975	\N
976	3061
976	3062
976	\N
976	3064
977	3065
978	3066
978	3067
978	\N
978	3069
978	3070
980	3071
980	3072
980	\N
980	3074
981	3075
981	3076
981	\N
981	3078
981	3079
982	3080
982	3081
982	\N
983	3083
983	3084
983	\N
983	3086
983	3087
983	3088
984	3089
984	3090
984	\N
985	3092
985	3093
986	3094
986	3095
987	3096
987	3097
987	\N
988	3099
988	3100
988	\N
989	3102
989	3103
990	3104
992	3105
992	3106
992	\N
992	3108
992	3109
992	3110
993	3111
994	3112
994	3113
995	3114
995	3115
996	3116
996	3117
997	3118
997	3119
998	3120
999	3121
1000	3122
1000	3123
1001	3124
1002	3125
1002	3126
1004	3127
1005	3128
1006	3129
1006	3130
1007	3131
1008	3132
1008	3133
1009	3134
1010	3135
1011	3136
1011	3137
1012	3138
1012	3139
1013	3140
1013	3141
1014	3142
1015	3143
1016	3144
1016	3145
1017	3146
1017	3147
1018	3148
1018	3149
1019	3150
1019	3151
1020	3152
1020	3153
1021	3154
1021	3155
1022	3156
1023	3157
1023	3158
1024	3159
1024	3160
1025	3161
1025	3162
1026	3163
1026	3164
1027	3165
1027	3166
1028	3167
1029	3168
1029	3169
1030	3170
1030	3171
1031	3172
1031	3173
1032	3174
1032	3175
1033	3176
1033	3177
1034	3178
1034	3179
1035	3180
1035	3181
1036	3182
1037	3183
1037	3184
1038	3185
1038	3186
1039	3187
1039	3188
1040	3189
1041	3190
1041	3191
1042	3192
1043	3193
1043	3194
1044	3195
1044	3196
1045	3197
1045	3198
1047	3199
1047	3200
1048	3201
1048	3202
1049	3203
1049	3204
1049	\N
1050	3206
1050	3207
1052	3208
1052	3209
1053	3210
1053	3211
1053	\N
1054	3213
1054	3214
1055	3215
1055	3216
1056	3217
1056	3218
1057	3219
1057	3220
1058	3221
1058	3222
1059	3223
1060	3224
1060	3225
1061	3226
1061	3227
1062	3228
1062	3229
1063	3230
1063	3231
1064	3232
1064	3233
1065	3234
1065	3235
1066	3236
1066	3237
1067	3238
1068	3239
1068	3240
1069	3241
1069	3242
1070	3243
1070	3244
1071	3245
1071	3246
1072	3247
1072	3248
1073	3249
1073	3250
1074	3251
1074	3252
1075	3253
1075	3254
1076	3255
1077	3256
1078	3257
1078	3258
1079	3259
1079	3260
1080	3261
1080	3262
1081	3263
1081	3264
1082	3265
1082	3266
1083	3267
1083	3268
1084	3269
1085	3270
1085	3271
1086	3272
1086	3273
1087	3274
1087	3275
1088	3276
1088	3277
1089	3278
1090	3279
1090	3280
1091	3281
1091	3282
1092	3283
1092	3284
1093	3285
1094	3286
1096	3287
1096	3288
1097	3289
1097	3290
1098	3291
1098	3292
1099	3293
1099	3294
1100	3295
1100	3296
1101	3297
1101	3298
1102	3299
1102	3300
1103	3301
1103	3302
1104	3303
1104	3304
1105	3305
1105	3306
1106	3307
1106	3308
1107	3309
1107	3310
1108	3311
1108	3312
1109	3313
1109	3314
1111	3315
1111	3316
1112	3317
1113	3318
1114	3319
1114	3320
1115	3321
1115	3322
1116	3323
1116	3324
1117	3325
1118	3326
1118	3327
1119	3328
1120	3329
1120	3330
1121	3331
1121	3332
1122	3333
1122	3334
1123	3335
1123	3336
1124	3337
1124	3338
1125	3339
1126	3340
1128	3341
1128	3342
1129	3343
1130	3344
1130	3345
1131	3346
1131	3347
1132	3348
1132	3349
1133	3350
1134	3351
1135	3352
1136	3353
1136	3354
1137	3355
1138	3356
1138	3357
1139	3358
1140	3359
1140	3360
1141	3361
1141	3362
1142	3363
1143	3364
1143	3365
1144	3366
1144	3367
1145	3368
1146	3369
1146	3370
1147	3371
1147	3372
1148	3373
1148	3374
1149	3375
1149	3376
1150	3377
1150	3378
1151	3379
1152	3380
1153	3381
1154	3382
1154	3383
1155	3384
1155	3385
1156	3386
1156	3387
1157	3388
1157	3389
1158	3390
1158	3391
1159	3392
1161	3393
1162	3394
1162	3395
1163	3396
1163	3397
1164	3398
1164	3399
1165	3400
1166	3401
1166	3402
1167	3403
1168	3404
1168	3405
1169	3406
1169	3407
1170	3408
1170	3409
1171	3410
1171	3411
1178	3500
1178	3501
1178	3502
1178	3503
1178	3504
1178	3505
1178	3507
\.


--
-- TOC entry 3740 (class 0 OID 18306)
-- Dependencies: 233
-- Data for Name: synonyms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonyms (id, synonym) FROM stdin;
1	адамды сайлау
2	қолдаушылар
3	шешім
4	нәтиже
5	дауыс беру
6	қолдау
7	ойластыру
8	әзірлеу
9	даярлау
10	жабдықтау
11	ресми тұлға
12	басқарушы 
13	бастық
14	директор
15	әдейі
16	әдейілеп
17	зәуілеп
18	арнайы
19	сайланған топ
20	сайланған құрам
21	сайланған орта
22	іскерлік кездесулердің ұйымы
23	Шығыс аймақ
24	шығыс мекен
25	шығыс өңір
26	шығыс 
27	әкімшілік-территориялық бөлік
28	аймақ
29	белгілі бір бөлік
30	атырап
31	жол
32	саяхат
33	алыс жол
34	керуен
35	баспана
36	шаңырақ
37	мекен
38	пана
39	мәдениет мекені
40	мәдениет ұйымы
41	өнер
42	еңбек
43	дәу
44	алып
45	еңгезердей
46	ірі
47	әңгіредей
48	қонақ бөлме
49	төр үй
50	түпкі бөлме
51	кең,мол бөлме
52	шаһар
53	кент 
54	шөр
55	мекен
56	аймақ
57	халық
58	ел-жұрт
59	қауым
60	руластар
61	тобыр
62	жағдай
63	оқиға
64	мысал
65	түбірткі
66	қиыншылық
67	жұмбақсыз
68	астарсыз
69	жасырын емес
70	тұйық емес
71	жайдарлы
72	сауал-сұрақ
73	анкета
74	сұхбат
75	айдарласу
76	көрісу
77	қауышу
78	жүздесу
79	беттесу
80	жолығу
81	көзігу
82	дауыс беру жүйесі
83	өз шешімінді қалдыратын жер
84	хабарлау
85	сұрау салу
86	еркін білдіру
87	бұйрық
88	акт
89	заң
90	әмір
91	шешім
92	жарлы
93	насихат
94	уағыз
95	хаттама
96	хат
97	қағаз
98	хабарлама
99	ата-заң
100	басшы
101	төре
102	ұлық
103	мырза
104	шонжар
105	шора
106	жарғы
107	низам
108	мизам
109	қаулы
110	құқықтық акт
111	Конституциялық жарғы
112	Конституциялық низам 
113	Конституциялық мизам
114	Ата Заң
115	толтыру
116	жетілдіру
117	аяғына дейін бітіретін іс
118	түгендеу
119	сұрыпта
120	қосу
121	іске қосу
122	құру
123	тарату
124	кіріктіру
125	кіргізу
126	проект
127	жоспар
128	схема
129	теория
130	чертеж
131	мазмұндалған
132	айтылған
133	хабарлаған
134	білдірген
135	суреттеу
136	ұсынылған
137	білдірілген
138	байқатылған
139	қарастырылған
140	жіберу
141	өңдеу
142	өтеусіз беру
143	қылғыту
144	тұлға
145	кісі
146	адам
147	пенде
148	жігіт
149	ер
150	ықтиярлы
151	ырықты
152	құқылы 
153	тәуелсіз
154	күштеусіз
155	зорлықсыз
156	астыртын
157	құпия
158	бұғыңқы
159	бүркенішті
160	ашық түрде емес
161	ептеп-басып
162	сайлау
163	үміткер тандау
164	еркін білдіру
165	өз шешімін беру
166	қолдау
167	тікесінен
168	төтесінен
169	турасынан
170	тіке
171	ең негізгі
172	айқындалады
173	бағдарланады
174	нақтыланады
175	дәлелденеді
176	билік
177	қожалық
178	төрелік
179	үстемдік
180	үн
181	дыбыс
182	саңқылдау
183	дабырласу
184	дабыр-дүбір
185	шуылдау
186	тізбе
187	Тізбектеу 
188	тізу
189	тізгіштеу
190	даярлау
191	дайындау
192	қамдау
193	сайлау
194	жабдықтау
195	әбзелдеу
196	топ
197	адамдар жиынтығы
198	тобыр
199	руластар
200	аймақтық 
201	аумаққа тән
202	аумаққа қатысты
203	Учаскеге тән
204	учаскеге қатысты
205	аймақ
206	мәжіліс
207	өкіл
208	тексеріс
209	жария ету
210	жар салу
211	баспаға беру
212	бастырту
213	мәлімдеу
214	жайғасқан
215	орныққан
216	жайласқан
217	орын алу
218	ел
219	Отан
220	аймақ
221	мекен
222	шаруа
223	іс
224	қызмет
225	еңбек
226	қаракет
227	мезгіл
228	мезет
229	кезең
230	шақ
231	кез
232	уақ 
233	мағлұмат
234	ақпарат
235	дерек
236	дәйек
237	хабар
238	сайланған
239	әзірленген
240	тәулік
241	мезгіл
242	уақыт
243	шақ
244	сөтке
245	көп ұзатпай
246	кідіртпей
247	мәлімет
248	мағлұмат
249	дәйек
250	дерек
251	хабар
252	қолтаңбы қою
253	құжаттың міндетті реквизеті
254	айырмашылық
255	ауытқу
256	жаналық
257	жұмыслдыру
258	айырмашылық
259	ауытқу
260	жаналық
261	жұмыслдыру
262	айырмашылық
263	ауытқу
264	жаналық
265	жұмыслдыру
266	өтініш
267	қалау
268	тадап етуші
269	қауымдастық
270	серіктестік
271	орта
272	тобыр
273	топ
274	мақсат
275	тілек
276	арман
277	талап
278	іске аспақ
279	істі жасау
280	жүргізу
281	мақсат
282	жарлық
283	заңдар жинағы
284	акт
285	конституция
286	адвокат 
287	прокурор
288	тәртіп
289	міндет
290	заң
291	қақ
292	тармақ
293	бөлік
294	тармақ
295	жұмыс
296	тармақ
297	бөлік
298	тармақ
299	жұмыс
300	тармақ
301	бөлік
302	тармақ
303	жұмыс
304	тармақ
305	бөлік
306	тармақ
307	жұмыс
308	тармақ
309	бөлік
310	тармақ
311	жұмыс
312	кадр
313	кәсіпқой
314	шебер
315	өз істің білегі
316	жиналыс
317	жиылыс
318	мәслихат
319	отырыс
320	мәжіліс
321	қаума
322	теріс емес
323	тура
324	дұрыс
325	сол емес
326	нарық
327	бәс
328	кұн
329	көрсеткіш
330	қаражат
331	нарық
332	бәс
333	кұн
334	көрсеткіш
335	қаражат
336	нарық
337	бәс
338	кұн
339	көрсеткіш
340	қаражат
341	өндіру
342	шығару
343	табыстау
344	ұсыну
345	көрсету
346	өндіру
347	шығару
348	табыстау
349	ұсыну
350	көрсету
351	тілек
352	тілеу
353	мүдде
354	қалау
355	арман
356	тілек
357	тілеу
358	мүдде
359	қалау
360	арман
361	тілек
362	тілеу
363	мүдде
364	қалау
365	арман
366	тілек
367	тілеу
368	мүдде
369	қалау
370	арман
371	дәлдеу
372	қарау
373	байқау
374	болжау
375	қозғалыс
376	іздену
377	жұмыс
378	әрекет
379	даму
380	қозғалыс
381	іздену
382	жұмыс
383	әрекет
384	даму
385	тұрақтылық
386	тірек
387	басты
388	маңызды
389	жаттығу
390	әзірлету
391	қалпына келтіру
392	құрастыру
393	ұсынылған
394	әдейлетіп
395	даярланды
396	қасақана
397	елбасы
398	төраға
399	басшы
400	лауазымды тұлға
401	елбасы
402	төраға
403	басшы
404	лауазымды тұлға
405	басшылық жасау
406	билеу
407	билеп-төстеу
408	атқару
409	қоныс аудару
410	жер аудару
411	орын ауыстыру
412	қоныс аудару
413	жер аудару
414	орын ауыстыру
415	қожалық
416	әкімдік
417	мансап
418	қожалық
419	әкімдік
420	мансап
421	қожалық
422	әкімдік
423	мансап
424	құқықтық
425	қайыра айыру
426	қайыра жару
427	қайыра бөлшектеу
428	тағы да бөлшектеу
429	тағы да бөлу
430	қайтадан ажырату
431	бейне
432	маңыз
433	мағына
434	мән
435	қызмет
436	нығайту
437	арттыру
438	абырой-атақ
439	дәреже
440	атақ
441	мансап
442	шен
443	даңқ
444	нығайту
445	күшейту
446	жақсарту
447	жоғарылату
448	жұрт
449	халық
450	қауым
451	мемлекет
452	жұмыс
453	қызмет
454	қарекет
455	еңбек
456	шаруа
457	ат салысу
458	қатынасу
459	мүмкіншілік
460	мұрша
461	жайылу
462	үлкейту
463	ұлғайту
464	кеңею
465	кеңу
466	жақтау
467	аялау
468	сақтау
469	аман алып қалу
470	күту
471	сақтау
472	күту
473	қарайласу
474	кқамқорлық
475	аялау
476	сақтау
477	күту
478	қарайласу
479	кқамқорлық
480	аялау
481	сақтау
482	күту
483	қарайласу
484	кқамқорлық
485	аялау
486	әдіс
487	айла
488	әрекет
489	амал
490	шешу жолы
491	жеткізу
492	дамыту
493	ілгерілету
494	меңгерту
495	жалғастыру
496	айырма
497	өзгешелік
498	ерекшелік
499	екі түрлі 
500	үлгі
501	көшірме
502	негіз
503	жоба
504	ескі емес
505	ұғыну
506	сезіну
507	білу
508	байсалды
509	сабырлы 
510	салмақты
511	келу
512	жылжу
513	шамалы
514	шағын
515	азғана
516	кем
517	санаулы
518	азырақ
519	ауыртпалық
520	машақаттық
521	қиыншылық
522	киын кез
523	ашаршылық
524	жоқшылық
525	мұқтаждық
526	тосқауыл
527	ілгішек
528	бөгет
529	оралғы
530	тосқын
531	тудыратын
532	әрекет ететін
533	қамтамасаздандыру
534	дәл
535	айқын
536	нағыз
537	көмескі емес
538	нақты
539	түсінікті
540	ұғымды
541	ақылға қонымды
542	дұрыстаулар
543	анық
544	айқын
545	дәл
546	тура
547	бөлім
548	тарау
549	күй
550	күтім
551	тарау
552	тарам
553	сала
554	қарастыру
555	байқату
556	білдіру
557	сездіру
558	бөлшек
559	бөлім
560	айырылған
561	ұсақталған
562	мөлшер
563	көлем
564	талай рет
565	бірнеше 
566	мәрте
567	талай рет
568	бірнеше 
569	мәрте
570	талай рет
571	бірнеше 
572	мәрте
573	талай рет
574	бірнеше 
575	мәрте
576	жаңалық
577	қажетсіз
578	керексіз
579	жағымсыз
580	қолайсыз
581	ұнамсыз
582	қабілетсіз
583	хабарлама
584	мәлімдеме
585	қағаз
586	белгілі болды
587	танымал болды
588	атақты болды
589	саналу
590	есепке алыну
591	басылған
592	табылған
593	мән
594	мағына
595	мазмұн
596	орны 
597	қадірі
598	түйсінеді
599	мақұлданды
600	уәде
601	серт
602	қасам
603	уағда
604	әймен
605	ант-аман
606	сұрақ
607	өтініш
608	тапсырылсын
609	міндеттелсін
610	артылсын
611	табысталсын
612	амал 
613	әрекет
614	айла
615	тәсіл
616	пайдалану
617	тұрғызылады
618	бой көтереді
619	шек
620	тоқтам
621	тежегендік
622	ерекше
623	айрықша
624	өзгеше
625	ерек
626	басқаша
627	көзқарас
628	ой
629	тұжырым
630	сұхбаттасты
631	тіленді
632	өтінді
633	кеңес берді
634	ұмсынды
635	күнкөріс
636	өмір
637	дүние
638	дәурен
639	ғұмыр
640	тірлік
641	Тірі жүрушілік
642	амандық
643	мәнді
644	мазмұнды
645	негізгі
646	маңызы зор
647	тұжырым
648	байлам
649	бітім
650	түйін
651	ұйғарым
652	көрсету
653	сездіру
654	байқату
655	жайдары
656	ашық
657	жадыраңқы
658	ақжарқын
659	ақкөңіл
660	нұрлы
661	бейне
662	елес
663	есептеймін
664	ойлаймын
665	жиналыс
666	жиын
667	жиылыс
668	кеңес
669	мәслихат
670	мәжіліс
671	айтылған
672	пікір
673	мәлімдеме
674	ой
675	жүзеге асыру
676	жүргізу
677	сөзге келу
678	ұрыс
679	ойлары бір жерден шықпау
680	айтып кету
681	тоқталып кету
682	қомақты
683	ауқымды
684	аумақты
685	өрелі
686	дүйімжұрттық
687	жалпыхалықтық
688	ынтымақ
689	ұжымды
690	ұйымшылдық
691	бүтіндік
692	ауызбірлік
693	таза
694	қоспасыз
695	анық
696	анық
697	ашық
698	ой
699	көзқарас
700	шолақ
701	келте
702	молтақ
703	молақ
704	жеңіл
705	қиындықсыз
706	жеңіл-желпі
707	қитықсыз
708	ауыр емес
709	жұмыс
710	шаруа
711	қызмет
712	еңбек
713	қаракет
714	айтып өтті
715	айтты
716	аян
717	мағлұм
718	мәлім
719	әйгілі
720	мәшһүр
721	танымал
722	сауал
723	сұрау
724	жаңғырту
725	жақсарту
726	жаңалау
727	бүкілхалықтық дауыс беру
728	заңнамалық актіні қабылдау
729	жүргізіледі
730	сатылады
731	жетекші
732	ұйытқы
733	іс
734	бастау
735	жиын
736	той
737	қиын
738	ауыр
739	білім беру
740	жоспарлау
741	орам
742	оралым
743	экспорт
744	жұмыс жасайды
745	организмнің жұмыс жасауы
746	болдыратын
747	құртатын
748	пайдалы
749	ұтымды
750	ұтықты
751	ұтырлы
752	ыңғайлы
753	жылдам
754	лезде
755	шапшаң
756	қабылдау қажет
757	асығу керек
758	керектік
759	мұқтаждық
760	хабарлаған
761	мәлімдеген
762	беделді
763	өтімді
764	сарапқа салушы
765	бағалаушы
766	телекоммуникация
767	 директ-маркетинг
768	 бизнес-көшбасшы
769	қуат
770	қайрат
771	дәрмен
772	әл
773	тармақ 
774	ғылым
775	өнер
776	әдебиет
777	мәдениет
778	өткізілуі мүмкін
779	жасалуы мүмкін
780	қозғау
781	іске қосу
782	тауып алу
783	іздеу\n
784	\nкездесу
785	түпсіз
786	шұңғыл
787	шыңырау
788	шұңғыл
789	тұңғиық
790	халық билігі
791	билік жүргізу
792	бағдар
793	беталыс
794	бет
795	жол
796	мықты-басшылық
797	супер-басшылық
798	билеу
799	билік жүргізу
800	төстеу
801	төрелік ету
802	мықты
803	қуатты
804	қайратты
805	мықты
806	әлді
807	шек
808	шекара
809	тежеу
810	жол бермеу
811	оптимизациялау
812	іске асыру
813	оралау
814	жұмыс
815	еңбек
816	іс
817	кәсіп
818	орын
819	мән
820	мағына
821	маңызы
822	пайда болған
823	жүзеге асыру
824	бір дәрежеде
825	бірдей
826	босату
827	аяқталу
828	аралас сайлау жүйесі
829	 пропорционалды сайлау жүйесі
830	көпшілік сайлау жүйесі
831	 сурет
832	бейне
833	сипаттама
834	кесте
835	сызба
836	рәсімдеу
837	белгі
838	жазба
839	үрдіс
840	жиынтық
841	қарау тәртібі
842	тәуелсіздендіру
843	жүзеге асыру
844	Еуразия континентілік
845	Еуразияға тән
846	Еуразияға қыртысты
847	бақылау
848	болжау
849	бағалау
850	қадағалау
851	түсіну
852	сараптама
853	сұрыптама
854	анықтама
855	анықтау
856	саралау
857	сұрыптау
858	президенті
859	центр
860	мекен
861	орын 
862	мекеме
863	бөлім
864	жүзеге асырылатын
865	орындалатын
866	өтілетін
867	берілетін 
868	құрылатын
869	ескертілген
870	байланысқан
871	өтілетін
872	жасалатын
873	істелінетін
874	алмастыру
875	өзгерту
876	қайта өңдеу
877	жабу
878	орналыстыру
879	нұсқау
880	ақыл
881	пікір
882	ұсыныс
883	нұсқау
884	ақыл
885	жиналыс
886	комитет
887	прокуррор
888	адвокат
889	жасаймын
890	орындаймын
891	жүзеге асырылатын
892	орындалатын
893	өтілетін
894	енгізу
895	қосу
896	жазу
897	хабарлансын
898	айтылсын
899	түрту
900	белгілеу
901	сызу
902	ен салу
903	болуы мүмкін
904	қойылды
905	орналасуы мүмкін
906	алмастыру
907	айырбастау
908	талқылау
909	толқу
910	орындау
911	дайындау 
912	істеу
913	азайту
914	азат ету
915	құтқару
916	істеу алмайды
917	болмау
918	жасау
919	көрсету
920	көрсету
921	түсіндіру
922	есептеймін
923	ойлаймын
924	өткізіледі
925	жүргізіледі
926	орындалуы мүмкін
927	жасалынуы мүмкін
928	қамқорлық
929	тірек
930	қамтамасыз ету 
931	көмекші 
932	қорғау 
933	өшірілсін
934	тазаласын
935	дұрыстасын
936	берді
937	қуантты
938	болжады
939	бас тартты
940	қосылсын
941	топтасу
942	ұйымдасу
943	бірігу
944	рұқсат етпеу
945	орындама
946	сайланды
947	орын алды
948	болады
949	іске асырылды
950	жүргізу
951	орындау
952	жоғалту
953	айырылысу
954	бөліну
955	қорытынды
956	қамтамасыз ету
957	өткізу
958	 орнату
959	істерді жүргізу\n
960	жүзеге асыру
961	сүймелдеу
962	қозғады
963	ескерту
964	белгілеу
965	көрсету
966	мағыналы
967	есту
968	назар сады
969	айтып жеткізу
970	үйрету
971	береді
972	алады 
973	әперді
974	жойылу
975	демалады
976	тынығады
977	жасаймыз
978	істеуейміз
979	байқалу
980	шолу
981	орындалу
982	беріледі
983	қайта істелінеді
984	қайта беріледі
985	істелінді
986	қайтарылады
987	сыйланады
988	ауысу
989	көшу
990	шешімі табылады
991	табылады
992	орындалады
993	келіседі
994	қолдайды
995	жиырылады
996	тартылды
997	бола алмайды
998	жасай алмайды
999	істей алмайды
1000	орындай алмайды
1001	жақындаса алмайды
1002	піспейді
1003	сыймайды
1004	орын орнына келді
1005	орын орнына қойылды
1006	дұрыс болы
1007	көреді
1008	байқайды
1009	қарау
1010	байқалады
1011	сезіледі
1012	анығы көрінеді
1013	орнатады
1014	ойлап табады
1015	табады
1016	істеуге жатпайды
1017	жасауға жатпайды
1018	өшіріледі
1019	жоқ болады
1020	жоқ
1021	әсер етеді
1022	әсер
1023	тигізеді
1024	ықпалын тигізеді
1025	жіберуге болмайды
1026	жіберу
1027	тарату
1028	орнату
1029	ауыстыру
1030	алмастыру
1031	өзгеру
1032	ұзақ мерзімге қою
1033	қою
1034	ұзақ сақтау
1035	ұзақ
1036	өтіп жатыр
1037	жалғасады
1038	жалғастырады
1039	жалғасады
1040	жалғасып жатыр
1041	айтады
1042	жеткізеді
1043	білдіреді
1044	сездіреді
1045	сөрсетеді
1046	ұсынады
1047	жаңадан басталды
1048	қосылды
1049	байланыс ортанығы
1050	байланыс
1051	қоңырау
1052	болуы керек
1053	алуы керек
1054	береді
1055	ескертілген
1056	айтылған 
1057	жеткізілген
1058	саясатты білуші
1059	көтеру
1060	итеру
1061	ашулы
1062	кекті
1063	жаңа
1064	өзгеріс
1065	төңкерңіс
1066	аймақ
1067	бөлім
1068	тармақ
1069	жол 
1070	орын
1071	дауыс беру
1072	таңдау
1073	байқау
1074	центр
1075	зат
1076	қажеттілер
1077	керек жарақ
1078	құрамы
1079	қажеттілік
1080	коуч
1081	сабақ 
1082	жаңа
1083	семинар
1084	басшы
1085	бастық 
1086	төрайым
1087	білуші
1088	бақылаушы
1089	сайлау орны
1090	орын
1091	сайланатын жер
1092	сайлау
1093	бақылау
1094	бағалау
1095	қарау
1096	көру
1097	болжау
1098	жанқиярлық
1099	адал
1100	шарт
1101	істеуі тиіс
1102	маңызды
1103	тиіс
1104	құрметтеу
1105	рөл
1106	жұмысы
1107	ісі
1108	қызметі
1109	бастысы
1110	ортасы
1111	ерекшелігі
1112	постулат
1113	принцип
1114	міндет
1115	шарт
1116	қызмет
1117	проблемма
1118	міндет
1119	іс-әрекет
1120	есеп
1121	әділ
1122	шын
1123	рас
1124	сабақ
1125	оқу
1126	лекция
1127	білді
1128	анықтады
1129	жазды
1130	орындады
1131	тиімді
1132	ерекшелігі
1133	белгілері
1134	жекелігк
1135	ескертті
1136	айтты
1137	айтты
1138	ескертті
1139	жеткізді
1140	айтты
1141	ескертті
1142	мәселер
1143	оқиға
1144	лагерь
1145	мобильді қосымшалар
1146	ыңғайлы
1147	сапалы
1148	бақылау
1149	қадағалау
1150	себебін ашу
1151	операциялық жүйе
1152	орта
1153	жеке код
1154	жеке тұлға
1155	қалдық
1156	болу
1157	алды
1158	оқиға
1159	жағдаят
1160	іс
1161	кеңес мүшелері
1162	комитет мүшелер
1163	бюро мүшелер
1164	кемтар
1165	жарымжан
1166	ғаріп
1167	кемтік
1168	жермешел
1169	өткізді
1170	берді
1171	қолайлы
1172	тиімді
1173	жағдайлы
1174	оңтайлы
1175	көне
1176	дәуір
1177	деректер
1178	эпикалық
1179	жария етті
1180	хабарлады
1181	баспаға беру
1182	мәлімдеу
1183	ұран
1184	дабыл
1185	кезең
1186	кез
1187	мезгіл
1188	шақ
1189	процесс
1190	құру 
1191	жұмыс 
1192	әзірлеу 
1193	іске асыру 
1194	әрекет 
1195	зерттеу
1196	талқылау 
1197	талдау 
1198	қарау 
1199	тексеру
1200	тасымалдау
1201	импорт
1202	 импорттау
1203	кері импорт
1204	жедел ауыстыру
1205	айырбастау 
1206	ауыстыру 
1207	өзгерту
1208	қайта орнату
1209	ел
1210	жұрт
1211	қауым
1212	адамзат
1213	адам
1214	жоғары оқу орны
1215	ұйымдастыру
1216	орнату
1217	мекеме
1218	интернат
1219	стратегиялық
1220	саясат
1221	саясаттану 
1222	сыртқы саяси-қоғамдық 
1223	саяси-әлеуметтік 
1224	мемлекеттік
1225	өкілеттіктер\n
1226	тәжірибе
1227	 хабардарлық 
1228	білу 
1229	біліктілігі
1230	құрылады
1231	қойылады
1232	конституция
1233	құрылтайшылық
1234	жайылады
1235	артылады
1236	молаяды
1237	әзірлеу жүйесі
1238	даярлау жүйесі
1239	дербес
1240	азат
1241	ерікті
1242	бостан
1243	сайланған\n
1244	парламент мүшесі\n
1245	заң шығарушы\n
1246	өкіл
1247	қайта аккредиттеу
1248	уәкілетті
1249	аттестаттау
1250	тапсырма
1251	жауапкершілікті тапсырма
1252	мақсат
1253	ұласады
1254	шектеседі
1255	ұштасады
1256	жіптеседі
1257	сабақтасады
1258	жаңа буын
1259	жеткіншек
1260	төраға
1261	президент
1262	басшы
1263	ел басы
1264	бітіру
1265	тоқтату
1266	аяқтау
1267	жабу
1268	қолданушы
1269	веб-серфер
1270	клиент
1271	оқырман
1272	тұтынушы
1273	Тапсырыс беруші 
1274	учаске
1275	аймақ
1276	аудан
1277	кеңістік
1278	орын
1279	Парламент
1280	жиналыс
1281	таяныш
1282	сүйеніш
1283	сүйемел
1284	қазақстандық
1285	ел
1286	жер
1287	жаратылыс
1288	табиғи
1289	жиі емес
1290	ілуде бір
1291	аз
1292	бірең-сараң
1293	селдір
1294	әредік
1295	іске асыру
1296	құру
1297	шығу
1298	дамыту
1299	қалыптастыру
1300	болу
1301	дағдылы
1302	үйреншікті
1303	принцип
1304	көзқарас
1305	пікір
1306	сезіледі
1307	білінеді
1308	адамзат
1309	азамат
1310	кісі
1311	қоршау
1312	жер 
1313	азаттық
1314	еркіндік
1315	теңдік
1316	жоғарылайды
1317	өрлейді
1318	биіктейді
1319	жұмбақ
1320	көрінбейтін
1321	кідіріс
1322	айқын емес
1323	ажырата алмау
1324	қиын
1325	салмақты
1326	шара
1327	құн
1328	айғақ
1329	дәйек
1330	дерек
1331	дәлелдеме
1332	кеңес
1333	отырыс
1334	жиналыс
1335	жиылыс
1336	қаума
1337	палата
1338	сенат
1339	мәжіліс
1340	конгресс
1341	жиылыс
1342	жиналыс
1343	отырыс
1344	қаума
1345	кеңес
1346	тәуелсіз
1347	дара
1348	жеке
1349	бөлек
1350	саяқ
1351	қазіргі заманғы
1352	қазіргі
1353	соңғы
1354	бүгінгі
1355	жетілдірілген
1356	қазіргі заманға сай
1357	ел
1358	империя\n
1359	князьдік\n
1360	патшалық\n
1361	ватикан\n
1362	күш
1363	риза болу
1364	күлу
1365	дауыс беру
1366	қайта сайлау
1367	референдум
1368	сайлау
1369	провинция\n
1370	мегаполис\n
1371	елді мекен\n
1372	астанасы\n
1373	зерттеу
1374	талдау
1375	талқылау
1376	қарау 
1377	зерттеу
1378	қайталау\n
1379	негіздеме\n
1380	дәлел\n
1381	куәгер\n
1382	дәлел\n
1383	куәлік\n
1384	кепілдік\n
1385	әлеуметтік қамсыздандыру\n
1386	қамтамасыз ету\n
1387	төтенше
1388	шамадан тыс
1389	шарықтау шегі
1390	үстінде
1391	өрге қарай
1392	биік
1393	аласа
1394	кішкентай
1395	қысқа
1396	еңіс
1397	ылди
1398	етек
1399	бланк
1400	 құжат
1401	паспорт
1402	тіркеу
1403	 есепке алу
1404	формальдылық
1405	кірістіру\n
1406	таныстыру\n
1407	қосу\n
1408	енгізу\n
1409	отырғызу\n
1410	құру
1411	кедергі жасау
1412	болдырмау
1413	кедергі жасау
1414	бұғаттау
1415	ыңғай бермеу
1416	өзгерту
1417	түрлендіру
1418	реформалау
1419	қайта құру
1420	қайыра ұйымдастырылуы
1421	Облыс
1422	округ
1423	өлке
1424	орын
1425	учаске
1426	атырап
1427	иемдену
1428	қабылдау
1429	байыту
1430	балқыту
1431	өндіру
1432	суретке түсіру
1433	нәтижесіздік
1434	өнімсіз 
1435	әрекетсіздік
1436	 дәрменсіздік
1437	пайдасыз
1438	бағыт 
1439	сапа
1440	қатысушы
1441	ерекшелік
1442	аспект
1443	сәт
1444	Бақыланатын
1445	көрсетілетін
1446	белгіленетін
1447	ескертілетін
1448	тіркелетін
1449	тоқталып кететін
1450	адамдар
1451	халық
1452	қоғам
1453	көпшілік
1454	көрермендер
1455	көрермендер
1456	Интеграция
1457	интернационализация
1458	кеңейту
1459	глобалдылық
1460	үдеріс
1461	үлкен
1462	көлемі үлкен
1463	терең
1464	маңызды
1465	кең
1466	монументалды
1467	Үй
1468	парламент
1469	сот
1470	бөлме
1471	кеңес
1472	коммерц-коллегия
1473	Төраға
1474	көсбасшы
1475	президент
1476	басшы
1477	басқарушы 
1478	пайдалану\n
1479	тұтыну\n
1480	арнайы қолдану\n
1481	қосымша\n
1482	бейімделу\n
1483	құқықтық қолдану\n
1484	шағымданды
1485	наразылық білдірді 
1486	шағым берді
1487	арыз жазу
1488	шағыну
1489	фирма
1490	бюро
1491	кеңсе
1492	өкілдік
1493	кеңсе
1494	кеңсе бөлмесі 
1495	қарым-қатынас
1496	өтініш
1497	айналым
1498	сөйлеу
1499	бұйрық
1500	сұрау
1501	норма бақылау
1502	басқару
1503	мониторинг
1504	бақылау
1505	тексеру 
1506	қадағалау
1507	әңгіме
1508	диалог
1509	қоңырау
1510	қауесет
1511	түсіндіру
1512	келіссөздер
1513	дидарласты
1514	сырласты
1515	сұхбаттасты
1516	сөйлесу
1517	талқылау
1518	күрес 
1519	виндсервинг 
1520	салауатты өмір салты 
1521	марафон 
1522	туризм
1523	футбол
1524	жасырын
1525	құпия
1526	жабық
1527	пікір алмасу
1528	сөз қылу
1529	пікірталас\n
1530	конференция\n
1531	қарастыру\n
1532	емхана
1533	аурухана
1534	стационар
1535	госпиталь
1536	қағаз
1537	құрал
1538	мәтін
1539	талап
1540	акт 
1541	куәлік
1542	егу
1543	вакцинациялау
1544	вакцинопрофилактика
1545	зейін қою
1546	жауапкершілік
1547	қызығушылық
1548	қатысу
1549	байқау 
1550	 қарау  
1551	шығару
1552	бағыттау
1553	іске қосу
1554	жіберу
1555	бастау
1556	топтасу
1557	әзірлеу
1558	аяқтау
1559	қайта өңдеу
1560	финализация
1561	тюнинг
1562	жетілдіру
1563	үлестіру
1564	бөлу
1565	кеңейту
1566	жалғастыру
1567	көбейту
1568	үндеу
1569	қатысушы
1570	ағза
1571	баспахана
1572	көрініс\n
1573	пішіні\n
1574	редколлегия\n
1575	тұжырымы\n
1576	редакциялау\n
1577	кандидатура
1578	Мұрагер
1579	инаугурация
1580	әкім
1581	депутат
1582	президенттік
1583	ақша қоры
1584	Есептеу
1585	смета
1586	мемлекеттік бюджет
1587	шағын бюджет
1588	бөлу
1589	қауышу
1590	кезікті
1591	кездесті
1592	беттесті
1593	кеңес
1594	саммит
1595	қамтамасыз ету
1596	жабдық
1597	ұсыну
1598	жеткізу
1599	логистика
1600	тәртіптеу
1601	реттеу
1602	тұрақтандыру
1603	ретке келтіру
1604	түзету
1605	салыстырып тексеру
1606	тұжырымдау
1607	қорытындылау
1608	қорытынды\n
1609	жалпылау\n
1610	жинақтау\n
1611	түйін салынуы
1612	ықпал
1613	нәтижесі\n
1614	әрекет
1615	белгі
1616	ырық
1617	әрекет
1618	арттыру
1619	ұлғайту
1620	кеңейту
1621	нығайту
1622	тереңдету
1623	күшейту
1624	кіру
1625	жылжыту
1626	жүру
1627	өмір сүру
1628	талдау
1629	саралау
1630	жіліктеу
1631	жіктеу
1632	бағалау
1633	сұрыптау
1634	белгілі\n\n
1635	айқын\n\n
1636	оң\n
1637	бір мәнді\n\n
1638	маңызды\n
1639	нағыз\n
1640	рәсімдеу
1641	бекіту
1642	қабылдау
1643	санкция
1644	мақұлдау
1645	өткізіп жіберу
1646	мәселе
1647	сұрақ
1648	қиындық
1649	күрделілік
1650	кедергі
1651	тығыздық
1652	мұраға қалдыру
1653	қалдыру\n
1654	уағыздау 
1655	бұйрық беру 
1656	тапсыру 
1657	сипаттау
1658	құру
1659	бастау
1660	негіздеу
1661	анықтау
1662	баяндау
1663	сипаттау
1664	жаңарту
1665	жетілдіру
1666	түрлендіру
1667	түрлендіру
1668	модернизация
1669	апгрейд
1670	нақты
1671	мағыналы
1672	орынды
1673	сәйкес
1674	мәнді
1675	қажетті
1676	мүмкін 
1677	қол жетімді
1678	рұқсат етілген
1679	нақты
1680	виртуалды
1681	әлеуетті
1682	ығыстыру
1683	Алып тастау
1684	біліктілігінен айыру
1685	бөліп тастау
1686	жарқын
1687	қалың
1688	қарқынды
1689	шоғырланған
1690	тамақтандырылған
1691	беделді
1692	өтімді
1693	ықпалды
1694	құрметті
1695	беделді
1696	адам
1697	азамат
1698	адамзат
1699	жеке тұлға\n\n
1700	персона\n
1701	әйел адам
1702	салым
1703	жәрдемдесу
1704	қызығушылық
1705	ынтымақтастық 
1706	қызмет
1707	қамтамасыз ету
1708	кезектесу
1709	ұтылау 
1710	алмалау 
1711	ауысу
1712	ұрысу
1713	анық-танық
1714	керемет
1715	арақатыс
1716	өзара 
1717	байланыс
1718	қатынас
1719	арқылы
1720	көмегімен
1721	желі
1722	өзек
1723	негізі
1724	тірегі
1725	көзі
1726	әдейі
1727	әдейілеп
1728	зәуімен
1729	рецензент\n
1730	кеңесші\n
1731	маман 
1732	ветэксперт 
1733	сот-медициналық сарапшы
1734	парламенттің төрағасы
1735	парламент палатасының төрағасы
1736	төреғасы
1737	басшы
1738	конференция жүргізуші
1739	тәртіп
1740	анықтама
1741	шарт 
1742	талап
1743	қағида
1744	тәртіп
1745	анықтау
1746	 белгілеу
1747	тағайындау, 
1748	бекіту
1749	азайту
1750	төмендету
1751	кішірейту
1752	қорлау
1753	Шығару
1754	алып тастау
1755	өшіру
1756	алыстату
1757	құрту
1758	өлтіру
1759	жетекші
1760	басқарушы
1761	президент
1762	басшы
1763	көшбасшы
1764	жұмылдыру
1765	байлау\n
1766	араластыру\n
1767	жұмысқа қабылдау\n
1768	аутсорсинг
1769	бағалы зат
1770	Министрлер Кабинеті
1771	мэр
1772	министр
1773	парламент
1774	министрдің көмекшісі
1775	журналист
1776	баспа
1777	төртінші билік
1778	репортер
1779	шолушы
1780	журналистика
1781	өлке
1782	құрлық
1783	жазық
1784	алқап
1785	жер қойнау
1786	дала
1787	ауыз су
1788	тұщы су
1789	Сұйық
1790	ылғал
1791	сусын
1792	ағын
1793	шөп
1794	дәрі
1795	тағам
1796	көкөніс
1797	ағаш
1798	айуан
1799	хайуан
1800	аң
1801	 мал
1802	түлік
1803	әлем
1804	бұйым
1805	жаратылыс
1806	игілік
1807	байлық
1808	мүлік
1809	атап өту
1810	көңіл бөлді
1811	айтып кетті
1812	ұстану
1813	болу
1814	тұру
1815	сұлба
1816	схема
1817	макет
1818	парадигма
1819	теория
1820	стандарт
1821	Үлес
1822	норма
1823	шектеу
1824	контингент
1825	 лимит
1826	мөлшерлеме
1827	құжат
1828	куәлік
1829	рұқсаттама
1830	паспорт
1831	сенімхат
1832	үкімет
1833	әртүрлі
1834	қосылу
1835	бірігу
1836	бәстесу
1837	сан
1838	мөлшер
1839	шама
1840	пікір
1841	жауап
1842	техникалық есеп
1843	таңдалу құқығы
1844	бірдей сайлау
1845	парапар сайлау
1846	тікелей сайлау
1847	қосалқы сайлау
1848	қосымша сайлау
1849	қақы
1850	негіз
1851	дауысқа салу
1852	\nпікір
1853	құпия
1854	бүркенішті түрде
1855	бүркеме
1856	астыртын
1857	астырт
1858	бұғыңқы
1859	тәуелсіз
1860	ықтиярлы
1861	ырықты
1862	жан-жақты
1863	бірыңғай
1864	тұтас
1865	тұлға
1866	құрам
1867	сайланушы
1868	үміткер
1869	дауыс беруші
1870	топ
1871	дауыс беру парағы
1872	дауыс беру парақшасы
1873	кепіл
1874	кепілдеме
1875	гарантия
1876	жағдай
1877	талап
1878	міндет
1879	борыш
1880	келісім
1881	тұлға
1882	адам
1883	тура
1884	тік
1885	түзу
1886	ашық
1887	тұп-тура
1888	талғау
1889	сайлау
1890	қалау
1891	талғаушы
1892	сайлаушы
1893	қалаушы
1894	байқау
1895	қарау
1896	қадағалау
1897	тексеру
1898	бағдарлау
1899	тәртіп
1900	реттілік
1901	үлес қосу
1902	өсім
1903	процент
1904	өлкелік
1905	өңір
1906	аймақ
1907	аумақ
1908	бірыңғай
1909	барлық ұлтқа бірдей
1910	барлық ұлттық
1911	жалпыхалықтық
1912	тізбе
1913	қолдау
1914	қоштау
1915	құптау
1916	мақұлдау
1917	қуаттау
1918	кері
1919	бөлімшелік
1920	астана
1921	елорда
1922	орта
1923	мезгіл
1924	уақыт
1925	сәт
1926	кез
1927	өкілдік
1928	уәкілдік
1929	ұсыным
1930	кандидат
1931	сайланушы
1932	үміткер
1933	ассоциация
1934	ұйым
1935	одақ
1936	ұжым
1937	әлеуметтік
1938	өтіл
1939	тілек
1940	арыз
1941	сұрау
1942	кеңес
1943	мәслихат
1944	мәжіліс
1945	жиылыс
1946	кездесу
1947	іс-шара
1948	мүше
1949	тоқтам
1950	түйін
1951	дерек
1952	дәйек
1953	мәлімет
1954	ақпар
1955	мағлұмат
1956	ақпарат
1957	билік
1958	компетенция
1959	лауазым
1960	жұмыс
1961	кәсіп
1962	орнықты
1963	үздіксіз 
1964	бірқалыпты
1965	ауыспайтын
1966	бюро
1967	мекеме
1968	бағыныңқы
1969	бағынышты
1970	тәуелді
1971	мекеме
1972	кәсіпорын
1973	басқару
1974	билеу
1975	билік жүргізу
1976	көмек
1977	тірек
1978	сүйеніш
1979	қолғабыс
1980	демеу
1981	септік
1982	біртұтас
1983	тиісті
1984	борышты
1985	әрекет ету
1986	топтастыру
1987	шоғырландыру
1988	жүргізу
1989	орындау
1990	ұсыныс
1991	ұсынылым
1992	денонсация
1993	бас тарту
1994	күшін қайтару
1995	үзу
1996	күшінде жоқ
1997	доғару
1998	қою
1999	қысқарту
2000	тыю
2001	үзу
2002	біту
2003	шағым
2004	мәлімдеме 
2005	арыз
2006	наразылық
2007	барыс
2008	ереже
2009	қағида
2010	рет
2011	жөн
2012	жүйе
2013	таңба
2014	белгі
2015	баспа
2016	орын
2017	тартпа
2018	суырма
2019	нұсқа 
2020	мысал
2021	өнеге
2022	ғибрат
2023	ұлағат
2024	төлім
2025	жазба
2026	қағаз
2027	қорғау
2028	қалдыру
2029	әзірлеу
2030	даярлау
2031	дайындалу
2032	қамдану
2033	әзірлік
2034	қаузау
2035	сертификат
2036	растама қағаз
2037	белгі
2038	айғақ
2039	дәлел
2040	тізімнен алу
2041	санақтан алу
2042	тізімге қосу
2043	санаққа қосу
2044	тізімдеу
2045	тізбелеу
2046	тізгіштеу
2047	қосу
2048	есептеу
2049	санау
2050	кампания
2051	белгілеу
2052	қою
2053	орнату
2054	жариялау
2055	хабарлау
2056	құлақтандыру
2057	хабардар ету
2058	ескерту
2059	нәтиже
2060	түйін
2061	тұжырым
2062	қорытым
2063	дәйектеме
2064	бөліну
2065	бөлісу
2066	бөлу
2067	жіктеу
2068	айырым
2069	ел
2070	жұрт\nжұртшылық
2071	жамағат
2072	бұқара
2073	әлеумет
2074	қауым
2075	санау
2076	табу
2077	мәнін шығару
2078	есеп жүргізу
2079	есеп-қисап жүргізу
2080	тіркеу
2081	қорытынды
2082	түйін
2083	тұжырым
2084	онлайн
2085	деректер
2086	дерек
2087	мағлұмат
2088	мәлімет
2089	насихат
2090	үгіт-насихат
2091	уағыз
2092	нұсқау
2093	мәліметтік
2094	ескертпелік
2095	әлемдік желі ресурсы
2096	жер
2097	мекен
2098	бекет
2099	орын
2100	орынжай
2101	тармақ
2102	басшылық
2103	нұсқамалық
2104	жергілікті
2105	шаһарлық
2106	кенттік
2107	жарияланым
2108	жаңалық
2109	хабар
2110	хабарлау
2111	құлаққағыс
2112	мәлімдеме\nмағлұмдама
2113	ақпарат
2114	ақпар
2115	мағлұмат
2116	деректер
2117	дәйек
2118	хабар
2119	маңыздылық
2120	көкейкестілік
2121	келелілік
2122	мәнділік
2123	қажеттілік
2124	түсініктілігі
2125	ұғыныңқылығы
2126	айқындылығы
2127	ашықтығы
2128	дәлелдігі
2129	наным\nнану
2130	иланым\nилану
2131	бөлме
2132	бөлімше
2133	акт
2134	құжат
2135	бөлім
2136	жер
2137	аумақ
2138	сала
2139	үлескі
2140	есептеу
2141	жаңадан сайлау
2142	елбасы
2143	мәслихат
2144	отырыс
2145	кеңес
2146	жиылыс
2147	мәжіліс
2148	кеңес
2149	отырыс
2150	жиылыс
2151	тұрғылықты
2152	тұрғын
2153	билік 
2154	билік органдары
2155	жаңылыс
2156	дәл емес
2157	олқылық
2158	терістік
2159	ала-құлалық
2160	дәлсіздік
2161	қателік
2162	әбестік
2163	жаңылысушылық
2164	терістік
2165	ағаттық
2166	жаңалық
2167	ынта
2168	ереже
2169	есеп
2170	тіркеу
2171	уәкіл
2172	мақсат
2173	тілек
2174	тілеу
2175	мұрат
2176	мақсұт
2177	ниет
2178	расталған
2179	ереже
2180	қағида
2181	үлгі
2182	қалып
2183	шама
2184	мөлшер
2185	дәстүрлі
2186	қағидалы
2187	әлеумет
2188	жамағат
2189	жұрт
2190	қауым
2191	орта
2192	халайық
2193	қызмет
2194	мансап
2195	жасау
2196	құрастыру
2197	құру
2198	ашықтық
2199	әйгілік
2200	жасырмаушылық
2201	жариялылық
2202	айқын дауыс беру
2203	жиын
2204	жиналыс
2205	ақылшы
2206	ақыл беруші
2207	халық қызметшісі
2208	бақылаушы
2209	қадағалаушы
2210	қараушы
2211	тілмаш
2212	тәржімеші
2213	интернационалдық
2214	бақылау
2215	зерттеу
2216	көру
2217	кескін
2218	бейнематериал
2219	аудиожазба
2220	өтініш
2221	арыз
2222	хабарлама
2223	ескертпе
2224	қағида
2225	тәртіп
2226	бап
2227	заң
2228	ескертпе
2229	аңғарту
2230	ерекшелік
2231	басымдық
2232	басымдылық
2233	артықтық
2234	үстемдік
2235	өкілеттік
2236	уәкілдік
2237	міндет
2238	борыш
2239	тапсырма
2240	тағайындау
2241	тіркеу
2242	дәстүр
2243	салт
2244	барлық
2245	жалпы
2246	күллі
2247	бүкіл
2248	шек
2249	қыр
2250	маң
2251	аралық
2252	меже
2253	шеп
2254	айла
2255	амал
2256	басқару
2257	жетектеу
2258	меңгеру
2259	билеу
2260	жүргізу
2261	қатар бағынатын
2262	өкімет
2263	үкімет
2264	басқарушы
2265	билеуші
2266	бақталастық
2267	бәсекелестік
2268	тартыс
2269	межелі
2270	мезгілді
2271	мөлшерлі
2272	мұғдарлы
2273	эквивалент
2274	альтернатива
2275	жиын
2276	кеңес
2277	кездесу
2278	ой 
2279	пікір
2280	қимыл
2281	жыбыр
2282	әрекет
2283	азаттық
2284	еркіндік
2285	теңдік
2286	қоғамдық
2287	тобыр
2288	сап
2289	жиын
2290	лек
2291	шоғыр
2292	ахуал
2293	жағдаят
2294	күй
2295	тұрмыс
2296	хал
2297	әулет
2298	буын
2299	жұрағат
2300	тұқым
2301	түлек
2302	ұрпақ
2303	тұрақты жері
2304	тұратын жер
2305	өмір сүретін жері
2306	анық
2307	айқын
2308	мәдениетті
2309	дамыған
2310	өркениетті
2311	құрама
2312	құрамдастырылған
2313	құрамалы
2314	құрастырылған
2315	туралау
2316	тегістеу
2317	жөндеу
2318	түзулеу
2319	бөлшек
2320	бөлік
2321	тарау
2322	бөлім
2323	сала 
2324	тармақ
2325	заң
2326	тәртіп
2327	қағида
2328	жоспарланбаған
2329	бүтіндік
2330	ұйымшылдық
2331	ынтымақ
2332	ауызбіршілік
2333	бірауыздылық
2334	тұтастық
2335	шыншыл
2336	турашыл
2337	әділетшіл
2338	адал
2339	жіктеу
2340	сараптау
2341	талдау
2342	жіліктеу
2343	таңдау
2344	сұрыптау
2345	жауаптылық
2346	бөгет
2347	кедергі
2348	оралғы
2349	тосқын
2350	кандидат
2351	азат
2352	ерікті
2353	бостан
2354	ретсіздік
2355	жөнсіздік
2356	орынсыздық
2357	жосықсыздық
2358	ерсілік
2359	күдік
2360	қауіп
2361	сезік
2362	секем
2363	шүбә
2364	шәк
2365	күмән
2366	қауіп
2367	сезік
2368	секем
2369	шүбә
2370	шәк
2371	тұйық
2372	нақ уақыты
2373	сол мезетте
2374	сәтте
2375	уақытта
2376	шағында
2377	нанымды 
2378	иланымды
2379	жақтау
2380	қорғау
2381	қостау
2382	қоштау
2383	құптау
2384	жәрдемдесу
2385	тіркеу құжаты
2386	ендіру
2387	орнату
2388	сіңдіру
2389	қолдану
2390	бұзылған
2391	былыққан
2392	жарамсыз болған
2393	қалта
2394	хатқалта
2395	құрту
2396	жоғалту
2397	жоқ қылу
2398	өзгерту
2399	фальсификациялау
2400	бұзу
2401	бұзылған
2402	істен шыққан
2403	ақаулы
2404	жұртшылық
2405	жұрт
2406	әлеумет
2407	тобыр
2408	халық
2409	дағды
2410	іс-тәжірибе
2411	машық
2412	анықтама
2413	түсініктеме
2414	дефиниция
2415	пайымдама
2416	мәлімдеме
2417	түсінік
2418	тәртіп
2419	ереже
2420	болжал
2421	болжам
2422	мөлшер
2423	нобай
2424	тұспал
2425	шек
2426	үйлесімді
2427	мөлшерлес
2428	өлшемдес
2429	шамалас
2430	тепе-теңдік
2431	айла
2432	амал
2433	әдіс
2434	жол
2435	дәреже
2436	хабардар ету
2437	жариялау
2438	хабарлау
2439	тізімдеу орны
2440	байқау
2441	бақылау
2442	қадағалау
2443	тергеу
2444	тұратын жері
2445	тұрғылықты жері
2446	тұрған орны
2447	достық
2448	татулық
2449	бірлік
2450	әріптестік
2451	ұйымшылдық
2452	қолтаңба қою
2453	қағаз
2454	әйгілеу
2455	жария ету
2456	елге жеткізу
2457	халыққа есіттіру
2458	құлақтандыру
2459	атақ
2460	дәреже
2461	лауазым
2462	мансап
2463	шен
2464	қызметші
2465	демде
2466	әп-сәтте
2467	жылдам
2468	лезде
2469	шапшаң
2470	шұғыл
2471	құптау
2472	қоштау
2473	қолдау
2474	жақтау
2475	қостау
2476	қамсыздандыру
2477	жеткізіп тұру
2478	жабдықтау
2479	қамдау
2480	құн
2481	белгі
2482	мардымсыз
2483	шамалы
2484	өлшеулі
2485	тежеулі
2486	білу
2487	мойындау
2488	игерілген
2489	кірген
2490	бөлу
2491	үлестіру
2492	шығару
2493	құтқару
2494	азат ету
2495	өзге
2496	бөтен
2497	біреу
2498	жат
2499	бейтаныс
2500	сырт адам
2501	сала
2502	тарау
2503	тұлға
2504	бөгет
2505	оралғы
2506	тосқауыл
2507	тосқын
2508	ілгішек
2509	бөгесін
2510	ақиқат
2511	бүркеусіз
2512	шындық
2513	нағыз
2514	шын
2515	үндеу
2516	дабылдау
2517	шетел
2518	база
2519	арқау
2520	тірек
2521	өзек
2522	жасау
2523	орындау
2524	іске асыру
2525	орындау
2526	істеу
2527	атқару
2528	орындаушы
2529	істеуші
2530	бөлек
2531	дара
2532	дербес
2533	оқшау
2534	оңаша
2535	саяқ
2536	адам
2537	кісі
2538	мүмкіншілік
2539	қоныс
2540	тұрақ
2541	орын
2542	жай
2543	алшақ
2544	аулақ
2545	қашық
2546	ұзақ
2547	шалғай
2548	жырақ
2549	меншік
2550	қожалық
2551	мүлік
2552	иелік
2553	ұйытқы
2554	қозғау
2555	мұрат
2556	мүдде
2557	тілек
2558	тілеу
2559	көзқарас
2560	ой
2561	дау
2562	жанжал
2563	керіс
2564	тайталас
2565	қақтығыс
2566	тартыс
2567	шеру
2568	митинг
2569	көрсету
2570	жарияланым
2571	қорғаныс
2572	қатерсіздік
2573	тежеу
2574	тізгіндеу
2575	ұқсау
2576	шектеу
2577	залал
2578	зиян
2579	шығын
2580	кесел
2581	тартыну
2582	тыйылу
2583	абырой
2584	қадір
2585	ақпар
2586	мәлімет 
2587	хабар
2588	терістеу
2589	мойындамау
2590	пікірталас
2591	талқылау
2592	дебат
2593	диспут
2594	жарыссөз
2595	орнықтыру
2596	жайғастыру
2597	қою
2598	сыйғызу
2599	бастыру
2600	тарту
2601	дәуір
2602	кез
2603	кезең
2604	мезгіл
2605	мерзім
2606	уақ
2607	көлем
2608	ауқым
2609	шама
2610	меже
2611	рет
2612	орай
2613	жоспарланған
2614	алдағы
2615	келесі
2616	түсіндірме
2617	анықтама
2618	дефиниция
2619	пайымдама
2620	мәлімдеме
2621	түсінік
2622	жарияланым
2623	үндеухат
2624	үндеу
2625	үнпарақ
2626	үндеу
2627	дабыл
2628	шақыру
2629	тапсырма
2630	тираж
2631	тыс
2632	шеткері
2633	сыртқары
2634	жасырын
2635	айқын
2636	корпус
2637	үй
2638	фонд
2639	жинақ
2640	қаржы
2641	ақша
2642	кедергі қою
2643	тежеу
2644	орналастыру
2645	орнықтыру
2646	сыйғызу
2647	жайғастыру
2648	жатқызу
2649	сұрақ
2650	сұрау
2651	мәміле
2652	үйлесім
2653	ымыра
2654	бәтуа
2655	бітім
2656	ымыра
2657	жауапкершілік
2658	жауаптылық
2659	түйін
2660	тоқтам
2661	кесім
2662	бітім
2663	байлау
2664	болжал
2665	жорамал
2666	тұспал
2667	нобай
2668	тарау
2669	тармақ
2670	арна
2671	аймақ
2672	айнала
2673	атырап
2674	маң
2675	маңай
2676	өлке
2677	жіктеу
2678	саралау
2679	сараптау
2680	борыш
2681	парыз
2682	қарыз
2683	эксперт
2684	тілтанымдық комиссия
2685	қосалқы
2686	қосымша
2687	үстеме
2688	әліппе
2689	алфавит
2690	қосалқы
2691	қосымша
2692	еске түсіру
2693	ауызбірлік
2694	бірлік
2695	ұжым
2696	ұйымшылдық
2697	ынтымақ
2698	тұтастық
2699	белгі қою
2700	таңба салу
2701	таңбалау
2702	таңба
2703	нышан
2704	тұспал
2705	ишара
2706	баптау
2707	күй
2708	күнпарақ
2709	календарь
2710	ерікті
2711	азат
2712	кедергісіз
2713	бос
2714	кең
2715	азаттық
2716	бостандық
2717	еркіншілік
2718	теңдік
2719	келісім
2720	мәміле
2721	бітім
2722	уағдаластық
2723	пакт
2724	шарт
2725	келісім
2726	шарт
2727	бекіту
2728	түсінік
2729	ұғыныс
2730	мекен
2731	жер
2732	қоныс
2733	тұрақ
2734	ішкі ереже
2735	ішкі қағида
2736	жинақтау
2737	құрау
2738	зерделеу
2739	дайындау
2740	әзірлеу
2741	жүзеге асыру
2742	позиция
2743	бағдар
2744	бекініс
2745	басқарушы орган
2746	үкімет
2747	өкімет
2748	жарыс
2749	келісім
2750	мәміле
2751	үйлесім
2752	ымыра
2753	бәтуа
2754	бітім
2755	жүйелі
2756	ретті
2757	дәйекті
2758	әсер
2759	лидер
2760	басқарушы
2761	басшы
2762	жетекші
2763	қоғамдастық
2764	ассоциация
2765	жанында
2766	қасында
2767	маңында
2768	маңайында
2769	бірігіп
2770	барлығы
2771	қолдаушы
2772	ниеттес
2773	жақтаушы
2774	қуаттаушы
2775	ұтқыр
2776	ұтырлы
2777	маң
2778	жақ
2779	тарап
2780	сенім
2781	наным
2782	сенім
2783	иланым
2784	дүние
2785	нәрсе
2786	зат
2787	жасау
2788	бұйым
2789	дарынсыз
2790	болымсыз
2791	зейінсіз
2792	лайықсыз
2793	ыңғайсыз
2794	еріксіз
2795	шарасыз
2796	лажсыз
2797	мәжбүр
2798	амалсыз
2799	ерікті
2800	ықтиярлы
2801	ықтияры
2802	еркімен
2803	 
2804	айыпты
2805	жазалы
2806	жазықты
2807	жауапты
2808	айыпкер
2809	қағида
2810	ұстаным
2811	кешікпей
2812	бөгелмей
2813	алшақ
2814	алыс
2815	жырақ
2816	қашық
2817	қиыр
2818	ұзақ
2819	мәдениетті
2820	мәдени
2821	елеңдеу
2822	елегізу
2823	жарна
2824	мүше
2825	ұпай
2826	жетістік
2827	бақылау
2828	келісті
2829	орынды
2830	үйлесімді
2831	жарасты
2832	қолайлы
2833	тура
2834	түзу
2835	жөн
2836	зейін
2837	зерде
2838	зер
2839	сырт
2840	сыртқары
2841	шет
2842	шеткері
2843	тысқары
2844	тыс
2845	дамыған
2846	сәйкестендіргенде
2847	бөлім
2848	бұрыс
2849	үйлеспейтін
2850	сыйымсыз
2851	үйлесімсіз
2852	әзіргі
2853	мерзімді
2854	шақтық
2855	адым
2856	аттам
2857	қатысу
2858	біріктіру
2859	қосылу
2860	аспап
2861	жабдық
2862	сайман
2863	бүлдіру
2864	күйрету
2865	қаусату
2866	қирату
2867	сындыру
2868	ойрандау
2869	мүмкіндік
2870	рұқсат
2871	қолжетімділік
2872	кіру
2873	зеребе
2874	сәйкес
2875	лайықты
2876	сай
2877	бірігу
2878	серіктесу
2879	ұйымдасу
2880	ұжымдасу
2881	ынтымақтасу
2882	интеграциялау
2883	тіреуіш
2884	демеуіш
2885	тіреуіш
2886	таяныш
2887	жабдықтау
2888	даярлау
2889	жарақтау
2890	саймандау
2891	бағалылық
2892	мәнділік
2893	маңыздылық
2894	өшпенділік
2895	дұшпандық
2896	жауыздық
2897	қамкүнемдік
2898	қастандық
2899	қастық
2900	мейірімсіздік
2901	рақымсыздық
2902	қатыбастық
2903	қатыбезерлік
2904	ақыл 
2905	өсиет
2906	айту
2907	әңгімелеу
2908	деу
2909	сөйлеу
2910	тиесілі
2911	тән
2912	белгіленген
2913	шешім
2914	әмір
2915	бұйрық
2916	билік
2917	жарлық
2918	құзыр
2919	әзірлік
2920	даярлық
2921	қызмет
2922	жұмыс
2923	мезет
2924	мерзім
2925	уақыт
2926	шақ
2927	заман
2928	маусым
2929	ағат
2930	бұрыс
2931	теріс
2932	әдейі
2933	арнайы
2934	жасанды
2935	өтірік
2936	бояма
2937	бекер
2938	басқа
2939	бөгде
2940	бөтен
2941	жат
2942	бейтаныс
2943	сырт
2944	мезгіл
2945	әуелгі
2946	әдепкі
2947	басқы
2948	бастапқы
2949	тұңғыш
2950	алдыңғы
2951	топтау
2952	шоғырлау
2953	куәландыру
2954	елорда
2955	ең азы
2956	минимум
2957	есімі
2958	жөні
2959	қолтаңбасы
2960	керекті
2961	маңызды
2962	міндетті
2963	тиісті
2964	дәлелдемеу
2965	сәйкес келмеу
2966	үндеу
2967	жүгіну
2968	бағыттау
2969	көрсетілген
2970	белгіленген
2971	орнатылған
2972	нақтыланған
2973	дәлелденген
2974	табыс
2975	ұтыс
2976	пайда
2977	олжа
2978	пайдалануда
2979	зайыбы
2980	сұралған
2981	дәрігерлік
2982	тізім
2983	тапсыру
2984	көрсету
2985	фрагмент
2986	көрініс
2987	қиынды
2988	қалдық
2989	ғұмырнама
2990	биография
2991	ұпай
2992	үлес
2993	мәлімдеме
2994	мағлұмдама
2995	хабарлама
2996	қабыл алмау
2997	істемейтін болу
2998	қабылдамау
2999	жасамау
3000	түбегейлі
3001	баянды
3002	қаржы
3003	ақша
3004	шығын
3005	өтім
3006	түсім
3007	жарғы
3008	қарар
3009	қосалқы
3010	үстеме
3011	жанама
3012	сәйкес
3013	лайық
3014	үйлесімді
3015	орайлас
3016	сәйкесті
3017	жиын
3018	кездесу
3019	жиналыс
3020	жиын
3021	кездесу
3022	жиналыс
3023	баяндама жасау
3024	мағыналы
3025	мәнді
3026	орындау
3027	өткеру
3028	еңбек
3029	шаруа
3030	іс
3031	қызмет
3032	қаракет
3033	жарымжан
3034	кемтар
3035	дімкәс
3036	ғаріп
3037	кезектесу
3038	ауысу
3039	ұтылау
3040	алмалау
3041	бағдар
3042	ағым
3043	беталыс
3044	жол
3045	тапсырыс
3046	аманат
3047	үлесу
3048	бірсыпыра
3049	бірталай
3050	едәуір
3051	қыруар
3052	талай
3053	біраз
3054	жаңалау
3055	жетілдіру
3056	өркендету
3057	өрістету
3058	тәртіптеу
3059	қалыпты күйге келтіру
3060	жөнге салу
3061	арттыру
3062	жақсарту
3063	дамыту
3064	ілгерілету
3065	негізінде
3066	тәртіптеме
3067	реттеме
3068	күн тәртібі
3069	ереже
3070	жарғы
3071	сенім
3072	қиял
3073	дәме
3074	арман
3075	үйлеспеушілік
3076	сәйкес келмеушілік
3077	сай келмеушілік
3078	диспропорция
3079	үйлесімсіздік
3080	жетілдіру
3081	арттыру
3082	асылдандыру
3083	көлемді
3084	аумақты
3085	қомақты
3086	өрелі
3087	масштабты
3088	кеңдік
3089	шолушы
3090	шолғыншы
3091	барлаушы
3092	лимитсіз
3093	шегі жоқ
3094	кепілдеме
3095	серт
3096	әңгіме
3097	сөз сөйлеу
3098	диалог
3099	қалыс қалу
3100	оқшау
3101	немқұрайлы
3102	арыздану
3103	шағыну
3104	бөлме
3105	ашық
3106	кіршіксіз
3107	пәк
3108	бүкпесіз
3109	ақ
3110	таза
3111	солғын
3112	жолығу
3113	жүздесу
3114	үміткер
3115	сайланушы
3116	жаңалау
3117	дамыту
3118	егемен
3119	бодансыз
3120	өзгеріс
3121	кеңдік
3122	тексеруші
3123	қадағалаушы
3124	жылдам
3125	әлеумет
3126	халық
3127	дауыс беру қағазы
3128	қауіпсіз
3129	үн
3130	дыбыс
3131	таңдау
3132	санды
3133	цифрлы
3134	партиялық
3135	аймақтың депутаттар корпусы
3136	қосу
3137	кіргізу
3138	дамыту
3139	нығайту
3140	мемлекеттің
3141	халықтық
3142	байлық
3143	қорыту
3144	төраға 
3145	жетекші
3146	халық
3147	қоғам
3148	жүргізу 
3149	меңгеру
3150	нығайту
3151	дамыту
3152	үміт
3153	аманат
3154	процесс
3155	алға жылжу
3156	заң шығарушы билік
3157	қыр
3158	жақ
3159	жаңару
3160	өзгеру
3161	серпіліс
3162	талпыныс
3163	басшы
3164	директор
3165	ой 
3166	пікір
3167	жасау
3168	ерекше
3169	айқын
3170	негізгі
3171	өзекті
3172	бірізді
3173	мағыналы
3174	тура
3175	нақты
3176	дауысы
3177	дыбысы
3178	ашық 
3179	тәуелсіз
3180	төраға
3181	қонақ
3182	система
3183	мерзім
3184	шара
3185	көрісу
3186	кездесу
3187	маңызды
3188	басты
3189	салтты
3190	басымдығы
3191	биіктігі
3192	анкета
3193	мойымау
3194	құламау
3195	жақында
3196	болашақта
3197	жарыс
3198	сайыс
3199	ыңғайлы
3200	қолайлы
3201	жеңіл
3202	арзан
3203	атырап
3204	аймақ
3205	бәсеке
3206	сайлау науқаны
3207	дауыс беру
3208	тұрарлық
3209	жанасымды
3210	бөлшегі
3211	механизмі
3212	разряд
3213	пікір
3214	позиция
3215	сезу
3216	түю
3217	ауқымды
3218	фундаменталды
3219	татулық
3220	тұрақтылық
3221	жаппай
3222	біртұтас
3223	натуралды
3224	түбегейлі
3225	нақты
3226	турашылық
3227	әділдік
3228	тартыс
3229	жарыс
3230	тұтас
3231	толыққанды
3232	бөлімше
3233	өкілдік
3234	бекіту
3235	сайлау
3236	іс-шара
3237	мереке
3238	ұқсас
3239	альтернативті
3240	ұқсас
3241	бұқара
3242	жамағат
3243	құзырет
3244	мерзім
3245	біріккен
3246	топтасқан
3247	жікшілдік
3248	туысшылдық
3249	тәкапар
3250	зиянды
3251	жөндеу
3252	өзгерту
3253	жауапты
3254	уәкілетті
3255	тәуелсіздік
3256	бетбұрыс
3257	қиын уақыт
3258	күрделі шақ
3259	заң
3260	үкім
3261	талқылау
3262	пікір алмасу
3263	жүйелі
3264	құрылымды
3265	негізгі
3266	түбегейлі
3267	ауыспалы
3268	өзгермелі
3269	сайлаудан бұрын
3270	көпшілік
3271	халық
3272	үкімет
3273	жергілікті басқару органдары
3274	талапкер
3275	кандидат
3276	таңдау
3277	сайлау
3278	депутат
3279	уәде
3280	гарантия
3281	өсиет
3282	тапсырма
3283	заң шеңберінде
3284	құқық аясында
3285	қажеттілікті орындау
3286	сыртқы саяси байланыстар
3287	біріккен
3288	тұтасқан
3289	беделді
3290	күшті
3291	айтулы
3292	атаұты
3293	тәуелсіз
3294	еркін
3295	құнды
3296	қымбат
3297	аз
3298	шашыраңқы
3299	ерекше
3300	маңызды
3301	пікірін жеткізу
3302	щйын айту
3303	басшы
3304	билеуші
3305	саяси ұйым
3306	қоғамдық ұйым
3307	билік
3308	басқару
3309	заң 
3310	өзгеріс
3311	қажетті
3312	құнды
3313	әсер ету
3314	итермелеу
3315	насихат
3316	уағыз
3317	сайлау нәтижесі
3318	еркін
3319	анализ
3320	зерттеу
3321	дәстүрлі
3322	ескіше
3323	сөз еркіндігі
3324	саналуан
3325	демократиялық қоғам
3326	сайлаушылар
3327	дауыс берушілер
3328	саяси әдістер
3329	мәдениет
3330	цивилизация
3331	рушылдық
3332	трайбализм
3333	жершілдік
3334	туысшылдық
3335	түйін
3336	қорытынды
3337	пайдалы
3338	табысты
3339	аумақтық
3340	ауыл
3341	саяси тартыс
3342	саяси күрес
3343	дауыс беру орны
3344	заманауи
3345	озық
3346	пікір
3347	ой
3348	әртүрлі
3349	әртүрі
3350	қызметсіздік
3351	мемлекеттік
3352	аймақтық басқару
3353	таңдамалы
3354	жоғарғы деңгейдегі
3355	саяси тартыс
3356	әртүрлі 
3357	сан алуан
3358	демократияның таралу көрсеткіші
3359	жаңаша
3360	озық
3361	заң талаптары
3362	заңның шешімдері
3363	құқық
3364	қатысушы
3365	кандидат
3366	ұқсастық
3367	бейімділік
3368	партиялық сайлау жүйесі
3369	қарсылас
3370	оппонент
3371	аудан
3372	аймақ
3373	қабілетті
3374	ұзақмерзімді
3375	тура
3376	төте
3377	қосымша
3378	жапсарлас
3379	мықты байланысты
3380	таңдамалы
3381	саяси коалиция
3382	бағынышты
3383	байланысты
3384	пікірталас
3385	пікір алмасу
3386	шыншыл
3387	ақиқат
3388	ақиқатшыл
3389	турашыл
3390	тұтас
3391	түбегейлі
3392	жеке мұлік құқығы
3393	екімағыналы
3394	қолдау
3395	дауыс беру
3396	жігерсіз
3397	әрекетсіз
3398	қайта қарау
3399	тексеру
3400	партиялық жүйе
3401	аздаған
3402	бірнеше
3403	теңгерімді
3404	ақпарат құралдары
3405	медиа
3406	қадағалаушы
3407	тексеруші
3408	турашылдық
3409	шыншылдық
3410	өзгеріс
3411	жаңа бағыт
3500	нәресте
3501	 сәби
3502	 бөбек
3503	 балдырған
3504	 жеткіншек
3505	 жасөспірім
\.


--
-- TOC entry 3734 (class 0 OID 18285)
-- Dependencies: 227
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (name, id) FROM stdin;
АҒАРТУШЫ	1
ҰЛТ ҰСТАЗЫ	2
ҚОҒАМ ҚАЙРАТКЕРІ	3
ТІЛТАНУШЫ	4
ТҮРКІТАНУШЫ	5
ТЕРМИНТАНУШЫ	6
ҚАЗАҚ ЖАЗУЫ МЕН ЕМЛЕСІНІҢ РЕФОРМАТОРЫ	7
ӘДЕБИЕТТАНУШЫ	8
ФОЛЬКЛОРТАНУШЫ	9
ӨНЕРТАНУШЫ	10
АҚЫН	11
ЖАЗУШЫ	12
ПУБЛИЦИСТ	13
АУДАРМАШЫ	14
ӘДІСКЕР	15
ПЕДАГОГ	16
ПСИХОЛОГ	17
ЗАҢГЕР	18
САЯСАТКЕР	19
ДЕМОГРАФ	20
ТАРИХШЫ	21
\.


--
-- TOC entry 3736 (class 0 OID 18293)
-- Dependencies: 229
-- Data for Name: tag_legacy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag_legacy (tag_id, legacy_id) FROM stdin;
1	1
2	4
3	98
4	75
\.


--
-- TOC entry 3729 (class 0 OID 18146)
-- Dependencies: 222
-- Data for Name: termin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.termin (id, name, description, examples) FROM stdin;
1	Дыбыс	Естілетін, көзге көрінбейтін нәрсе	\N
2	Әріп	Дыбыс таңбасы, көрінетін, естілмейтін нәрсе	\N
3	Буын	Бір сөздің ішінде бірнеше буын болады. Сөз буын санына қарай бір буынды, үш буынды,  төрт буынды, онан да көп буынды сөз деп аталады. Бір буынның ішінде бірнеше дыбыс болады	ат, а-та, а-та-лар, а-та-ла-ры-ма
4	Тасымал	Жазып келе жатқанда жол аяғында орын аз қалып, сөз сыймайтын болса, ол сөзге тасымал керек, яғни сөзді екі бөліп, бір бөлігін сол жолда қалдырып, екінші бөлігін келесі жолға асыру керек	Ша-қыр-ған-ға
5	Сөйлем	Сөздің басын құрастырып, біреу айтқан ой. Айтушының ойын тыңдаушы ұғарлық даражада түсінікті болып айтылған сөздер ғана сөйлем болады.	Елдің малы далада, біткен жаны жалада, көбі жатыр қалада.
6	Түбіршік тіл	Түпкі қалпынан өзгерілмей жұмсалады.	Қытай һәм иапон тілдері.
7	Жалғамалы тіл	Сөздің аяғына жалғау қосылып өзгерілетін тіл.	Түрік, фин, қазақ тілдері.
8	Қопармалы тіл	Сөз түбірімен қопарылып өзгерілетін тіл.	Орыс тілі, араб тілі.
9	Тысқарғы жалғау	Сөздің тұлғасын өзгертсе де, ішкі мағынасын өзгертпейді. Сөйлегенде, жазғанда сөздерді біріне-бірін қиындастырып тізу үшін қажет.	«Құлақ» деген сөзге «-тың» деген жалғау қоссақ, «құлақтың» болады. Тұлғасы өзгерілді, мағынасы өзгерілген жоқ. «Құлақтың» дегенде бастың мүшесінің атын көрсетеді. Міні, сондықтан «-тың» тысқарғы жалғау болады.
10	Ішкергі жалғау	Сөздің тұлғасын да, мағынасын да өзгертеді. Бір мағаналы сөзден екінші мағаналы сөз шығарып, сөзден сөз туғызып, көбейтіп тілді байыту үшін қажет.	Егерде «құлақ» деген сөзге «-шын» деген жалғау қоссақ, «құлақшын» болады. Мұнда тұлғасы да, мағанасы да өзгерілді. «Құлақ» бастың мүшесін көрсетуші еді, «құлақшын» болған соң, басқа киетін киімнің атын көрсетіп тұр. Міні, сондықтан «-шын» ішкергі жалғау болады.
11	Харіф	Дыбыс таңбасы, көрінетін, естілмейтін нәрсе.	а, о, ы, ұ, у, қ, ғ, т, с, т.б.
12	Зат есім	Кім? не? деп сұрауларға жауап болып айтылатын һәм нәрселердің атын көрсететін сөздерді зат есім дейміз. Деректі һәм дерексіз заттардың атын көрсететін сөздерді зат есім дейміз.	Жер, тау, тас, су, ағаш, шөп, жапырақ, күн, ай, жұлдыз, бұлт, қар, жаңбыр.
13	Сын есім	Нәрселердің сынын көрсететін сөздер сын есімдер деп аталады. Сын есімнің сұрауы: қандай?	Жарлы, жақын, алыс, аш, тоқ арзан, қымбат, қалың, жұқа, зерек, кешше, өткір, топас, семіз.
14	Сан есім	Неше? қанша? деп сұрауға жауап болатын һәм нәрсенің санын көрсететін сөздерді сан есім дейміз.	Бір, екі, үш, төрт, бес, алты, жеті, сегіз, тоғыз, он, он бір, он екі, он үш, он төрт, он бес, он алты, он жеті, он сегіз, он тоғыз, жиырма, отыз, қырық.
15	Есімдік	Есімдік дегеніміз есімдердің яғни, зат есімнің, сын есімнің, сан есімнің орнына жүретін сөздер. Есімдік қазақ тілінде бес тарау болады: 1) Жіктеу есімдігі. 2) Сілтеу есімдігі. 3) Сұрау есімдігі. 4) Жалпылау есімдігі. 5) Танықтық есімдігі.	Мен, сен, ол, біз, сіз, олар, кім, не, қайсы, қандай, өзім, өзің, өзі, бұл, ол, мынау, анау, бірі, бәрі, менікі, сенікі, оныкі, өзімдікі, өзінікі, өзімдікі, басқанікі.
16	Етістік	Не етеді? не істейді, не қылады? деп сұрағанға жауап һәм өздері істеген істі атайтын сөздер. Сондай не етпек? не істемек?\nне қылмақ? деген сұрауларға жауап болатын сөздердің бәрі де етістік болады.	Арт, тарт, ал, ұр, саба, соқ, қорық, күрес, маңыра, сөк, сүз, таста, шық, жық, ас, ал, төз.
17	Үстеу	Сөз үстіне қосылып, сөздің мағынасын толықтыратын сөздерді үстеу сөз дейміз. Қалай? Қашан? Қайда? деген сөздерге жауап болып айтылатын сөздердің бәрі де, я үстеу сөз, я соның орнындағы төлеу сөз.	Әрең, әрі, бері, бұрын, енді
18	Демеу сөздер 	Екі сөздің арасын, яки екі сөйлемнің арасын жалғастыруға демеу болатын сөздер.	да, де, я, яки, үйткені, сүйткені, үйтседе, бүйтседе, ба, бе, ма, ме, әлде, әйтпесе, немесе
19	Жалғаулық сөздер	Кей сөздер жалғау орнына жүреді һәм жалғаулар сияқты басқа сөздердің шылауында тұрмаса, өз алдына мағына шықпайды. Сондай сөздерді жалғаулық дейміз.	менен, үшін, арқылы, тақырыпты, туралы.
20	Одағай сөз	Кей сөздер басқа сөздерден оңаша, одағай айтылады. Қуаныш, реніш, күйініш, уайым, қайғы жан күйзелгенде, тән күйзелгенде, жан рахат тапқанда, тән рахат тапқанда шығатын дыбыстар, дауыстар, айтылатын сөздер, жанды һәм сөздер, хайуандарға айтатын сөздер, дауыстар, шақырулар бәрі одағай табына кіреді.	әһ! Ах! Ой-бай-ай! Жаным-ай! Құдайым-ай! Апырым-ай! Ау! Отағасы-ау! Апырым-ау! Ай-қай! Е-е-е! Ой тәңірім-ай! Ойбай-ай! Күс-күс! Құр-құр! Хош! Қош, қош! Қош! Құру! Шөре-шөре! Ау-қау! Сорап! айт-айт! Тарс-тұрс, дүңк-дүңк, сықыр-сықыр, тырс-тырс, сарт-сұрт, қаңқ, пыс-пыс.
21	Дауысты дыбыс / ашық дыбыс	Ашық айтылатын, дауыстап айтуға көнетін дыбыс.	\N
22	Дауыссыз дыбыс / тұйық дыбыс	Тұйық айтылатын, яғни дауыстап айтуға көнбейтін дыбыс.	\N
23	Жарты дауысты дыбыс / орта дыбыс	Дауысты дыбыстардай нағыз ашық айтылмайтын һәм дауыссыз дыбыстардай тым тұйық айтылмайтын орта дыбыс.	\N
24	Деректі заттар	Көзге көрінетін, құлаққа естілетін, мұрынға иіс келетін, тілге татылатын, денеге сезілетін деректі заттар.	Жер, су, ай, күн, дыбыс, ән, күй, иіс-қоныс, дәм, ащылық, тұщылық, жылулық, суықтық
25	Дерексіз заттар	Көзге көрінбейтін, құлаққа естілмейтін, мұрынға иіс келмейтін, тілге татылмайтын, денеге сезілмейтін, адам ақылмен ғана білетін дерексіз заттар.	Бақ, бәле, жан, өлім, мінез, ұят, реніш, қуаныш
26	Жалқы есім	Нәрсенің дербес өз басына ғана қойылған зат есім түрі.	Ахмет, Ашымтай, Атығай, Қызылжар, Семей, Қырым, Қытай.
27	Жалпы есім	Нәрсенің біріне емес, барлық табына қойылған зат есім түрі.	Кісі, еркек, қала, дала, ел, жұрт, ұлт, өлке, патшалық.
28	Жекелік айырыс	Нәрсенің жеке күйіндегі есімнің түрі.	Ата, дене, омырау, белбеу, ой, сырнай, керней, ашу, шыны, қаз, құнан, аяқ, шелек.
29	Көптік айырыс	Нәрсенің көп күйіндегі есімнің түрі.	Аталар, денелер, омыраулар, белбеулер, ойлар, сырнайлар, кернейлер, ашулар, шынылар, қаздар, құнандар, аяқтар, шелектер.
30	Жай қалып	Нәрсенің битарап күйіндегі есімнің түрі.	Жекеше: ата, дене, омырау, белбеу, ой, үй, сырнай, керней, ашу, шыны, қаз, құнан, аяқ, шелек.\nКөпше: аталар, денелер, омыраулар, белбеулер, ойлар, үйлер, сырнайлар, кернейлер, ашулар, шынылар, қаздар, құнандар, аяқтар, шелектер.
31	Тәуелді қалып	Бір нәрсені екінші нәрсе меншіктеуін көрсеткендегі сөздің түрі.	\N
32	Оңаша тәуелдік	Бір нәрсені екінші нәрсе оңаша меншіктеуін көрсетеді.	Жекеше, 1-нші жақ (мендік): атам, денем, омырауым, белбеуім, ойым, үйім, сырнайым, кернейім, ашуым, шыным, қазым, құнаным, аяғым, шелегім.\n2-нші жақ (сендік): атаң, денең, омырауың, белбеуің, ойың, үйің, сырнайың, кернейің, ашуың, шының, қазың, құнаның, аяғың, шелегің.\n3-нші жақ (бөгделік): атасы, денесі, омырауы, белбеуі, ойы, үйі, сырнайы, кернейі, ашуы, шынысы, қазы, құнаны, аяғы, шелегі.\nКөпше: 1-нші жақ (мендік): аталарым, денелерім, омырауларым, белбеулерім, ойларым, үйлерім, сырнайларым, кернейлерім, ашуларым, шыныларым, қаздарым, құнандарым, аяқтарым, шелектерім.\n2-нші жақ (сендік): аталарың, денелерің, омырауларың, белбеулерің, ойларың, үйлерің, сырнайларың, кернейлерің, ашуларың, шыныларың, қаздарың, құнандарың, аяқтарың, шелектерің.\n3-нші жақ (бөгделік): аталары, денелері, омыраулары, белбеулері, ойлары, үйлері, сырнайлары, кернейлері, ашулары, шынылары, қаздары, құнандары, аяқтары, шелектері.
47	Жіктеу есімдігі	Сөйлеген кезде сөйлеушінің, тыңдаушының һәм бөгдедегілердің жігін ашатын сөздер.	Жіктеу есімдігі үш жақты болады: 1) Сөйлеуші үшін «мен» дейді, бұл бірінші жақ. 2) Тыңдаушыға сөйлеуші «сен» дейді, бұл екінші жақ. 3) Сөйлеуші өзі мен тыңдаушыдан басқаны «ол» дейді, бұл үшінші жақ. Сыпайылап сөйлегенде сөйлеуші өзін «мен» деудің орнына «біз» дейді, тыңдаушыға сен деудің орнына «сіз» дейді, бөгде кісіні «ол» деудің орнына «о кісі» (ол кісі) дейді. Сондықтан «біз» бірінші жақ болады, «сіз» екінші жақ болады, «о кісі» үшінші жақ болады.
48	Сілтеу есімдігі	Нәрсені көрсеткенде айтылатын сөздер.	Жақын нәрсені көрсеткенде: осы, бұл, мынау, сол, анау деген сөздер сілтеу есімдігі болады.
33	Ортақ тәуелдік	Бір нәрсені басқа нәрселер ортақ меншіктеуін көрсетеді.	Жекеше: 1-ші жақ (біздікі): атамыз, денеміз, омырауымыз, белбеуіміз, ойымыз, үйіміз, сырнайымыз, кернейіміз, ашуымыз, шынымыз, қазымыз, құнанымыз, аяғымыз, шелегіміз.\n2-нші жақ (сіздік): атаңыз, денеңіз, омырауыңыз, белбеуіңіз, ойыңыз, үйіңіз, сырнайыңыз, кернейіңіз, ашуыңыз, шыныңыз, қазыңыз, құнаныңыз, аяғыңыз, шелегіңіз.\n3-нші жақ (бөгделік): атасы, денесі, омырауы, белбеуі, ойы, үйі, сырнайы, кернейі, ашуы, шынысы, қазы, құнаны, аяғы, шелегі.\nКөпше: 1-нші жақ (біздік): аталарымыз, денелеріміз, омырауларымыз, белбеулеріміз, ойларымыз, үйлеріміз, сырнайларымыз, кернейлеріміз, ашуларымыз, шыныларымыз, қаздарымыз, құнандарымыз, аяқтарымыз, шелектеріміз. 2-нші жақ (сіздік): аталарыңыз, денелеріңіз, омырауларыңыз, белбеулеріңіз, ойларыңыз, үйлеріңіз, сырнайларыңыз, кернейлеріңіз, ашуларыңыз, шыныларыңыз, қаздарыңыз, құнандарыңыз, аяқтарыңыз, шелектеріңіз.\n3-нші жақ (бөгделік): аталары, денелері, омыраулары, белбеулері, ойлары, үйлері, сырнайлары, кернейлері, ашулары, шынылары, қаздары, құнандары, аяқтары, шелектері.
34	Септік жалғау	Сөздердің үйлесуіне сеп болады.	Септік жалғау бесеу: 1) Ілік жалғау «-дың»; 2) Барыс жалғау «-ға»; 3) Табыс жалғау «-ды»; 4) Жатыс жалғау «-да»; 5) Шығыс жалғау «-дан».
35	Көптік жалғау	Нәрсенің жеке емес, көп күйдегі есімін көрсетеді.	лар, лер, дар, дер.
36	Түпкі зат есімдер	Түпкі заттың есімін көрсетеді.	\N
37	Тек сыны	Нәрсенің тегін көрсетеді.	Ағаш аяқ, күміс қасық, алтын жүзік, қағаз ақша, жез құман, киіз қалпақ, мақта жіп, қайыс жүген
38	Сыр сыны	Нәрсенің ішкі, тысқы сырын, реңін яғни, түрін, түсін, тегін, тұлғасын, пішінін, жайын, күйін көрсетеді.	Аласа, жуан, жіңішке, толық, нәзік, арық, семіз, тоқ, аш, шебер, шорқақ, ұста, олақ, ақ, қара, қызыл, сары, көк, жасыл, торы, күрең, шабдар, бурыл, зерек, кеще, тентек, жуас, шадыр, момын, қу, сұм, аңқау
39	Жай шырай	Жай шырай артық-кем демей, нәрсенің сиқын жай көрсетеді.	Жақсы атан, жаман қой, тентек бала, жуас ат, шорқақ кісі, қызыл шүберек, биік ағаш
40	Талғаулы шырай	Талғаулы шырай нәрсе сиқының бірінен-бірі артық-кемдігін көрсетеді; оны көрсету үшін жай сындағы сөзге «-рақ», «-рек» деген талғау қосымшалары тіркеледі.	Жақсы – жақсырақ, жаман – жаманырақ, зерек – зерегірек, семіз – семізірек. Талғау шырайын күшейткенде, көптеген сөз қосылып айтылады. Мәселен: Сиыр түйеден көп аласа; Қой аттан көп арзан.
41	Таңдаулы шырай	Таңдаулы шырай нәрсенің сиқы өте артық екенін көрсетеді. Оны көрсету үшін жай шырайдағы сөздің алдына ең, нақ, тап, тым, бек, хас деген сөздер қосылып айтылады.	Ең жақсы, нақ шешен, тап зерек, тым қорқақ, бек нәзік, хас батыр. Таңдаулы шырай екінші түрлі де болады: жай шырайдағы сөз таңдаулы шырайға түсуге бас дыбыстары бөлек алынып, оған «-п» дыбысы жалғанып, сол бөлектенген дыбыстар сөз алдына қойылып айтылады. Мәселен: а-нық – ап-анық, ау-лақ – ап-аулақ, шо-лақ – шоп-\n62\nшолақ, қыс-қа – қып-қысқа, тай-пақ – тап-тайпақ, жал-пақ – жап-жалпақ, се-міз – сеп-семіз, ақ-шам – ап-ақшам.
42	Зат-сын	Зат пен сын орнына бірдей жүретін сөздерді зат-сын дейміз.	Сын есімнің кейбіреулері зат есімнің орнына жүреді. Мәселен: «Арзан еттің сорпасы татымас» дегеннің орнына «арзанның сорпасы татымас» деп айтылады. «Арзан еттің» деген екі сөздің орнына «арзан» деген жалғыз сөз жарап тұр.
43	Есептік сан есім	Нәрселердің есебін һәм ретін көрсететін сөздер.	Бір, екі, үш, төрт, бес, алты, жеті, сегіз, тоғыз, он, жиырма, отыз, қырық, елу, алпыс, жетпіс, сексен, тоқсан, жүз, мың, миллион, түмен.
44	Реттік сан есім	Нәрселердің ретін көрсететін сөздер.	Бірінші, екінші, үшінші, төртінші, бесінші, алтыншы, жетінші, сегізінші, тоғызыншы, оныншы, жиырмасыншы, отызыншы, қырқыншы, елуінші, алпысыншы, жетпісінші, сексенінші, тоқсаныншы, жүзінші, мыңыншы, миллионыншы.
45	Темілдік сан есімдер	Нәрсенің бүтіні емес, бөлімтігінің санын көрсететін сөздер	Жарты, жарым, ширек.
46	Жадағай есептік сан есімдер	Зат есімге тіркелмей сөйленетін есептік сан есімдер.	Біреу, екеу, үшеу, төртеу, бесеу, алтау, жетеу.
49	Сұрау есімдігі	Біреуден бір нәрсе туралы сұрағанда айтылатын сөздер.	Адам туралы сұрасақ, «кім?» дейміз, басқа заттар туралы сұрасақ «не?» дейміз. Қай нәрсе екендігін сұрасақ «қайсы» дейміз. Нәрсенің сыны тақырыпты сұрасақ, «қандай?» дейміз. Нәрсенің дәл санын сұрасақ, «нешеу?», «неше?» дейміз. Нәрсенің дәл саны емес, шамасын сұрағанда «қанша» дейміз. Нәрсенің қатарда қайсы екендігін сұрасақ «нешінші?» дейміз. Мезгіл туралы сұрасақ, «қашан?» дейміз. Кім? не? Қайсы? Қандай? Нешеу? Неше? Қанша? Нешінші? Қашан? деген сөздер сұрау есімдігі болады.
50	Жалпылау есімдігі	Нәрсенің жігін айта сөйлегенде айтылатын сөздер.	бәрі, барша.\n«һәр» деген сөз өзі жіктеу һәм басқа сөздерге де қосылып, жіктеу есімдігінің орнына жүреді. Мәселен, һәр кім, һәр бір, һәр қайсысы уа ғайри сондай сөздер.
51	Сөйлем	сөздің басын құрастырып, біреу айтқан ой.\nСөйлеген де, жазғанда кім де болса ойын айтады. Ойын айтуға тиісті\nсөздерді алады да, олардың басын құрап, біріне-бірінің қырын келтіріп,\nқиындастырады. Қыры келетін сөздер, тұрған күйінде алса да, қиындаса\nқалады. Қыры келмейтін сөздерді қиындастыру үшін қырларын өзгертіп\nқиюын келтіреміз.\n	\N
\.


--
-- TOC entry 3731 (class 0 OID 18185)
-- Dependencies: 224
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (user_id, role_id, id) FROM stdin;
1	1	1
2	2	2
1	2	3
\.


--
-- TOC entry 3728 (class 0 OID 18136)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, password_salt) FROM stdin;
1	test	12345678	\N
2	magzhan200508@gmail.com	123	\N
\.


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 214
-- Name: legacy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legacy_id_seq', 100, true);


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 238
-- Name: morphemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.morphemes_id_seq', 195, true);


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 226
-- Name: my_serial; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.my_serial', 65, true);


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 216
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_id_seq', 1, false);


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 234
-- Name: paraphrases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paraphrases_id_seq', 1099, true);


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 218
-- Name: quote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quote_id_seq', 1, false);


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 242
-- Name: school_termins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_termins_id_seq', 6348, true);


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 240
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 13, true);


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 230
-- Name: synamizer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synamizer_id_seq', 1178, true);


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 232
-- Name: synonyms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synonyms_id_seq', 3507, true);


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 228
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 1, true);


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3552 (class 2606 OID 18115)
-- Name: legacy legacy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legacy
    ADD CONSTRAINT legacy_pkey PRIMARY KEY (id);


--
-- TOC entry 3572 (class 2606 OID 18355)
-- Name: morphemes morphemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.morphemes
    ADD CONSTRAINT morphemes_pkey PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 18124)
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 18318)
-- Name: paraphrases paraphrases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paraphrases
    ADD CONSTRAINT paraphrases_pkey PRIMARY KEY (id);


--
-- TOC entry 3556 (class 2606 OID 18134)
-- Name: quote quote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_pkey PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 18164)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3576 (class 2606 OID 19049)
-- Name: school_termins school_termins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_termins
    ADD CONSTRAINT school_termins_pkey PRIMARY KEY (id);


--
-- TOC entry 3574 (class 2606 OID 19040)
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 3566 (class 2606 OID 18304)
-- Name: synamizer synamizer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synamizer
    ADD CONSTRAINT synamizer_pkey PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 18311)
-- Name: synonyms synonyms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 18152)
-- Name: termin termin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termin
    ADD CONSTRAINT termin_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 18201)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3558 (class 2606 OID 18143)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 18193)
-- Name: user_role user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);


--
-- TOC entry 3578 (class 2606 OID 18188)
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2023-07-03 11:59:18 +06

--
-- PostgreSQL database dump complete
--

