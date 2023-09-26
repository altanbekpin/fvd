--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-09-26 10:36:01 +06

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

--
-- TOC entry 250 (class 1255 OID 19109)
-- Name: create_offer_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_offer_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO offers (offer_id, user_id, activate_type, activated)
  VALUES (NEW.id, NEW.id, 2, FALSE);
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_offer_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 245 (class 1259 OID 19089)
-- Name: activate_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activate_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.activate_types OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 19088)
-- Name: activate_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activate_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activate_types_id_seq OWNER TO postgres;

--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 244
-- Name: activate_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activate_types_id_seq OWNED BY public.activate_types.id;


--
-- TOC entry 248 (class 1259 OID 19591)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    comment text NOT NULL,
    username character varying(300) NOT NULL,
    termin_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 19596)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 3793 (class 0 OID 0)
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
-- TOC entry 3794 (class 0 OID 0)
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
    examples text,
    is_new boolean DEFAULT false NOT NULL
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
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 226
-- Name: my_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.my_serial OWNED BY public.termin.id;


--
-- TOC entry 247 (class 1259 OID 19098)
-- Name: offers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers (
    id integer NOT NULL,
    offer_id integer,
    user_id integer,
    activate_type integer,
    activated boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.offers OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 19097)
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_id_seq OWNER TO postgres;

--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 246
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_id_seq OWNED BY public.offers.id;


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
-- TOC entry 3797 (class 0 OID 0)
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
    paraphrase text
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
-- TOC entry 3798 (class 0 OID 0)
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
-- TOC entry 3799 (class 0 OID 0)
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
-- TOC entry 3800 (class 0 OID 0)
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
-- TOC entry 3801 (class 0 OID 0)
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
    pos integer,
    example text,
    created_at timestamp without time zone DEFAULT now()
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
-- TOC entry 3802 (class 0 OID 0)
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
    synonym text
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
-- TOC entry 3803 (class 0 OID 0)
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
-- TOC entry 3804 (class 0 OID 0)
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
-- TOC entry 3805 (class 0 OID 0)
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
    password_salt text,
    is_verified boolean DEFAULT false,
    confirmation_code_hash text,
    full_name character varying(255)
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
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3570 (class 2604 OID 19092)
-- Name: activate_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activate_types ALTER COLUMN id SET DEFAULT nextval('public.activate_types_id_seq'::regclass);


--
-- TOC entry 3553 (class 2604 OID 18111)
-- Name: legacy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legacy ALTER COLUMN id SET DEFAULT nextval('public.legacy_id_seq'::regclass);


--
-- TOC entry 3567 (class 2604 OID 18351)
-- Name: morphemes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.morphemes ALTER COLUMN id SET DEFAULT nextval('public.morphemes_id_seq'::regclass);


--
-- TOC entry 3571 (class 2604 OID 19101)
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers ALTER COLUMN id SET DEFAULT nextval('public.offers_id_seq'::regclass);


--
-- TOC entry 3554 (class 2604 OID 18120)
-- Name: page id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- TOC entry 3566 (class 2604 OID 18316)
-- Name: paraphrases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paraphrases ALTER COLUMN id SET DEFAULT nextval('public.paraphrases_id_seq'::regclass);


--
-- TOC entry 3555 (class 2604 OID 18129)
-- Name: quote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote ALTER COLUMN id SET DEFAULT nextval('public.quote_id_seq'::regclass);


--
-- TOC entry 3569 (class 2604 OID 19045)
-- Name: school_termins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_termins ALTER COLUMN id SET DEFAULT nextval('public.school_termins_id_seq'::regclass);


--
-- TOC entry 3568 (class 2604 OID 19038)
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- TOC entry 3563 (class 2604 OID 18300)
-- Name: synamizer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synamizer ALTER COLUMN id SET DEFAULT nextval('public.synamizer_id_seq'::regclass);


--
-- TOC entry 3565 (class 2604 OID 18309)
-- Name: synonyms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms ALTER COLUMN id SET DEFAULT nextval('public.synonyms_id_seq'::regclass);


--
-- TOC entry 3562 (class 2604 OID 18289)
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- TOC entry 3559 (class 2604 OID 18212)
-- Name: termin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termin ALTER COLUMN id SET DEFAULT nextval('public.my_serial'::regclass);


--
-- TOC entry 3561 (class 2604 OID 18199)
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- TOC entry 3557 (class 2604 OID 18139)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3782 (class 0 OID 19089)
-- Dependencies: 245
-- Data for Name: activate_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activate_types (id, name) FROM stdin;
2	User
1	Word
3	Synonym
4	Paraphrase
\.


--
-- TOC entry 3785 (class 0 OID 19591)
-- Dependencies: 248
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (comment, username, termin_id, id) FROM stdin;
\.


--
-- TOC entry 3752 (class 0 OID 18108)
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
-- TOC entry 3776 (class 0 OID 18348)
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
-- TOC entry 3784 (class 0 OID 19098)
-- Dependencies: 247
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers (id, offer_id, user_id, activate_type, activated, created_at) FROM stdin;
1165	3889	1	1	t	2023-07-13 11:13:13.898146+06
1166	3890	1	1	t	2023-07-13 11:13:13.898146+06
1167	3891	1	1	t	2023-07-13 11:13:13.898146+06
1168	3892	1	1	t	2023-07-13 11:13:13.898146+06
1169	3893	1	1	t	2023-07-13 11:13:13.898146+06
1170	3894	1	1	t	2023-07-13 11:13:13.898146+06
1171	3895	1	1	t	2023-07-13 11:13:13.898146+06
1172	3896	1	1	t	2023-07-13 11:13:13.898146+06
1173	3897	1	1	t	2023-07-13 11:13:13.898146+06
1174	3898	1	1	t	2023-07-13 11:13:13.898146+06
1175	3899	1	1	t	2023-07-13 11:13:13.898146+06
1176	3900	1	1	t	2023-07-13 11:13:13.898146+06
1177	3901	1	1	t	2023-07-13 11:13:13.898146+06
1178	3902	1	1	t	2023-07-13 11:13:13.898146+06
1179	3903	1	1	t	2023-07-13 11:13:13.898146+06
1180	3904	1	1	t	2023-07-13 11:13:13.898146+06
1181	3905	1	1	t	2023-07-13 11:13:13.898146+06
1182	3906	1	1	t	2023-07-13 11:13:13.898146+06
1183	3907	1	1	t	2023-07-13 11:13:13.898146+06
1184	3908	1	1	t	2023-07-13 11:13:13.898146+06
1185	3909	1	1	t	2023-07-13 11:13:13.898146+06
1186	3910	1	1	t	2023-07-13 11:13:13.898146+06
1187	3911	1	1	t	2023-07-13 11:13:13.898146+06
1188	3912	1	1	t	2023-07-13 11:13:13.898146+06
1189	3935	1	1	t	2023-07-13 11:13:13.898146+06
1190	3936	1	1	t	2023-07-13 11:13:13.898146+06
1191	3913	1	1	t	2023-07-13 11:13:13.898146+06
1192	3914	1	1	t	2023-07-13 11:13:13.898146+06
1193	3915	1	1	t	2023-07-13 11:13:13.898146+06
1194	3916	1	1	t	2023-07-13 11:13:13.898146+06
1195	3917	1	1	t	2023-07-13 11:13:13.898146+06
1196	3918	1	1	t	2023-07-13 11:13:13.898146+06
1197	3919	1	1	t	2023-07-13 11:13:13.898146+06
1198	3920	1	1	t	2023-07-13 11:13:13.898146+06
1199	3921	1	1	t	2023-07-13 11:13:13.898146+06
1200	3922	1	1	t	2023-07-13 11:13:13.898146+06
1201	3923	1	1	t	2023-07-13 11:13:13.898146+06
1202	3924	1	1	t	2023-07-13 11:13:13.898146+06
1203	3925	1	1	t	2023-07-13 11:13:13.898146+06
1204	3926	1	1	t	2023-07-13 11:13:13.898146+06
1205	3927	1	1	t	2023-07-13 11:13:13.898146+06
1206	3928	1	1	t	2023-07-13 11:13:13.898146+06
1207	3929	1	1	t	2023-07-13 11:13:13.898146+06
1208	3930	1	1	t	2023-07-13 11:13:13.898146+06
1209	3931	1	1	t	2023-07-13 11:13:13.898146+06
1210	3932	1	1	t	2023-07-13 11:13:13.898146+06
1211	3933	1	1	t	2023-07-13 11:13:13.898146+06
1212	3934	1	1	t	2023-07-13 11:13:13.898146+06
1213	3937	1	1	t	2023-07-13 11:13:13.898146+06
1214	3938	1	1	t	2023-07-13 11:13:13.898146+06
1215	3939	1	1	t	2023-07-13 11:13:13.898146+06
1216	3940	1	1	t	2023-07-13 11:13:13.898146+06
1217	3941	1	1	t	2023-07-13 11:13:13.898146+06
1218	3942	1	1	t	2023-07-13 11:13:13.898146+06
1219	3943	1	1	t	2023-07-13 11:13:13.898146+06
1220	3944	1	1	t	2023-07-13 11:13:13.898146+06
1221	3945	1	1	t	2023-07-13 11:13:13.898146+06
1222	3946	1	1	t	2023-07-13 11:13:13.898146+06
1223	3947	1	1	t	2023-07-13 11:13:13.898146+06
1224	3948	1	1	t	2023-07-13 11:13:13.898146+06
1225	3949	1	1	t	2023-07-13 11:13:13.898146+06
1226	3950	1	1	t	2023-07-13 11:13:13.898146+06
1227	3951	1	1	t	2023-07-13 11:13:13.898146+06
1228	3952	1	1	t	2023-07-13 11:13:13.898146+06
1229	3953	1	1	t	2023-07-13 11:13:13.898146+06
1230	3954	1	1	t	2023-07-13 11:13:13.898146+06
1231	3955	1	1	t	2023-07-13 11:13:13.898146+06
1232	3956	1	1	t	2023-07-13 11:13:13.898146+06
1233	3957	1	1	t	2023-07-13 11:13:13.898146+06
1234	3958	1	1	t	2023-07-13 11:13:13.898146+06
1235	4067	1	1	t	2023-07-13 11:13:13.898146+06
1236	3959	1	1	t	2023-07-13 11:13:13.898146+06
1237	3960	1	1	t	2023-07-13 11:13:13.898146+06
1238	3961	1	1	t	2023-07-13 11:13:13.898146+06
1239	3962	1	1	t	2023-07-13 11:13:13.898146+06
1240	3963	1	1	t	2023-07-13 11:13:13.898146+06
1241	3964	1	1	t	2023-07-13 11:13:13.898146+06
1242	3965	1	1	t	2023-07-13 11:13:13.898146+06
1243	3966	1	1	t	2023-07-13 11:13:13.898146+06
1244	3967	1	1	t	2023-07-13 11:13:13.898146+06
1245	3968	1	1	t	2023-07-13 11:13:13.898146+06
1246	3969	1	1	t	2023-07-13 11:13:13.898146+06
1247	3970	1	1	t	2023-07-13 11:13:13.898146+06
1248	3971	1	1	t	2023-07-13 11:13:13.898146+06
1249	3972	1	1	t	2023-07-13 11:13:13.898146+06
1250	3973	1	1	t	2023-07-13 11:13:13.898146+06
1251	3974	1	1	t	2023-07-13 11:13:13.898146+06
1252	3975	1	1	t	2023-07-13 11:13:13.898146+06
1253	3976	1	1	t	2023-07-13 11:13:13.898146+06
1254	3977	1	1	t	2023-07-13 11:13:13.898146+06
1255	3978	1	1	t	2023-07-13 11:13:13.898146+06
1256	3979	1	1	t	2023-07-13 11:13:13.898146+06
1257	3980	1	1	t	2023-07-13 11:13:13.898146+06
1258	3981	1	1	t	2023-07-13 11:13:13.898146+06
1259	3982	1	1	t	2023-07-13 11:13:13.898146+06
1260	3983	1	1	t	2023-07-13 11:13:13.898146+06
1261	3984	1	1	t	2023-07-13 11:13:13.898146+06
1262	3985	1	1	t	2023-07-13 11:13:13.898146+06
1263	3986	1	1	t	2023-07-13 11:13:13.898146+06
1264	3987	1	1	t	2023-07-13 11:13:13.898146+06
1265	3988	1	1	t	2023-07-13 11:13:13.898146+06
1266	3989	1	1	t	2023-07-13 11:13:13.898146+06
1267	3990	1	1	t	2023-07-13 11:13:13.898146+06
1268	3991	1	1	t	2023-07-13 11:13:13.898146+06
1269	3992	1	1	t	2023-07-13 11:13:13.898146+06
1270	3993	1	1	t	2023-07-13 11:13:13.898146+06
1271	3994	1	1	t	2023-07-13 11:13:13.898146+06
1272	3995	1	1	t	2023-07-13 11:13:13.898146+06
1273	3996	1	1	t	2023-07-13 11:13:13.898146+06
1274	3997	1	1	t	2023-07-13 11:13:13.898146+06
1275	3998	1	1	t	2023-07-13 11:13:13.898146+06
1276	3999	1	1	t	2023-07-13 11:13:13.898146+06
1277	4000	1	1	t	2023-07-13 11:13:13.898146+06
1278	4001	1	1	t	2023-07-13 11:13:13.898146+06
1279	4002	1	1	t	2023-07-13 11:13:13.898146+06
1280	4003	1	1	t	2023-07-13 11:13:13.898146+06
1281	4004	1	1	t	2023-07-13 11:13:13.898146+06
1282	4005	1	1	t	2023-07-13 11:13:13.898146+06
1283	4006	1	1	t	2023-07-13 11:13:13.898146+06
1284	4007	1	1	t	2023-07-13 11:13:13.898146+06
1285	4008	1	1	t	2023-07-13 11:13:13.898146+06
1286	4009	1	1	t	2023-07-13 11:13:13.898146+06
1287	4010	1	1	t	2023-07-13 11:13:13.898146+06
1288	4011	1	1	t	2023-07-13 11:13:13.898146+06
1289	4012	1	1	t	2023-07-13 11:13:13.898146+06
1290	4013	1	1	t	2023-07-13 11:13:13.898146+06
1291	4014	1	1	t	2023-07-13 11:13:13.898146+06
1292	4015	1	1	t	2023-07-13 11:13:13.898146+06
1293	4016	1	1	t	2023-07-13 11:13:13.898146+06
1294	4017	1	1	t	2023-07-13 11:13:13.898146+06
1295	4018	1	1	t	2023-07-13 11:13:13.898146+06
1296	4019	1	1	t	2023-07-13 11:13:13.898146+06
1297	4020	1	1	t	2023-07-13 11:13:13.898146+06
1298	4021	1	1	t	2023-07-13 11:13:13.898146+06
1299	4022	1	1	t	2023-07-13 11:13:13.898146+06
1300	4023	1	1	t	2023-07-13 11:13:13.898146+06
1301	4024	1	1	t	2023-07-13 11:13:13.898146+06
1302	4068	1	1	t	2023-07-13 11:13:13.898146+06
1303	4025	1	1	t	2023-07-13 11:13:13.898146+06
1304	4026	1	1	t	2023-07-13 11:13:13.898146+06
1305	4027	1	1	t	2023-07-13 11:13:13.898146+06
1306	4028	1	1	t	2023-07-13 11:13:13.898146+06
1307	4029	1	1	t	2023-07-13 11:13:13.898146+06
1308	4030	1	1	t	2023-07-13 11:13:13.898146+06
1309	4031	1	1	t	2023-07-13 11:13:13.898146+06
1310	4032	1	1	t	2023-07-13 11:13:13.898146+06
1311	4033	1	1	t	2023-07-13 11:13:13.898146+06
1312	4034	1	1	t	2023-07-13 11:13:13.898146+06
1313	4035	1	1	t	2023-07-13 11:13:13.898146+06
1314	4036	1	1	t	2023-07-13 11:13:13.898146+06
1315	4037	1	1	t	2023-07-13 11:13:13.898146+06
1316	4038	1	1	t	2023-07-13 11:13:13.898146+06
1317	4039	1	1	t	2023-07-13 11:13:13.898146+06
1318	4040	1	1	t	2023-07-13 11:13:13.898146+06
1319	4041	1	1	t	2023-07-13 11:13:13.898146+06
1320	4042	1	1	t	2023-07-13 11:13:13.898146+06
1321	4043	1	1	t	2023-07-13 11:13:13.898146+06
1322	4044	1	1	t	2023-07-13 11:13:13.898146+06
1323	4045	1	1	t	2023-07-13 11:13:13.898146+06
1324	4046	1	1	t	2023-07-13 11:13:13.898146+06
1325	4047	1	1	t	2023-07-13 11:13:13.898146+06
1326	4048	1	1	t	2023-07-13 11:13:13.898146+06
1327	4112	1	1	t	2023-07-13 11:13:13.898146+06
1328	4049	1	1	t	2023-07-13 11:13:13.898146+06
1329	4050	1	1	t	2023-07-13 11:13:13.898146+06
1330	4051	1	1	t	2023-07-13 11:13:13.898146+06
1331	4052	1	1	t	2023-07-13 11:13:13.898146+06
1332	4053	1	1	t	2023-07-13 11:13:13.898146+06
1333	4054	1	1	t	2023-07-13 11:13:13.898146+06
1334	4055	1	1	t	2023-07-13 11:13:13.898146+06
1335	4056	1	1	t	2023-07-13 11:13:13.898146+06
1336	4057	1	1	t	2023-07-13 11:13:13.898146+06
1337	4058	1	1	t	2023-07-13 11:13:13.898146+06
1338	4059	1	1	t	2023-07-13 11:13:13.898146+06
1339	4060	1	1	t	2023-07-13 11:13:13.898146+06
1340	4061	1	1	t	2023-07-13 11:13:13.898146+06
1341	4062	1	1	t	2023-07-13 11:13:13.898146+06
1342	4063	1	1	t	2023-07-13 11:13:13.898146+06
1343	4064	1	1	t	2023-07-13 11:13:13.898146+06
1344	4065	1	1	t	2023-07-13 11:13:13.898146+06
1345	4066	1	1	t	2023-07-13 11:13:13.898146+06
1346	4069	1	1	t	2023-07-13 11:13:13.898146+06
1347	4070	1	1	t	2023-07-13 11:13:13.898146+06
1348	4071	1	1	t	2023-07-13 11:13:13.898146+06
1349	4072	1	1	t	2023-07-13 11:13:13.898146+06
1350	4073	1	1	t	2023-07-13 11:13:13.898146+06
1351	4074	1	1	t	2023-07-13 11:13:13.898146+06
1352	4075	1	1	t	2023-07-13 11:13:13.898146+06
1353	4076	1	1	t	2023-07-13 11:13:13.898146+06
1354	4077	1	1	t	2023-07-13 11:13:13.898146+06
1355	4078	1	1	t	2023-07-13 11:13:13.898146+06
1356	4079	1	1	t	2023-07-13 11:13:13.898146+06
1357	4080	1	1	t	2023-07-13 11:13:13.898146+06
1358	4081	1	1	t	2023-07-13 11:13:13.898146+06
1359	4082	1	1	t	2023-07-13 11:13:13.898146+06
1360	4083	1	1	t	2023-07-13 11:13:13.898146+06
1361	4084	1	1	t	2023-07-13 11:13:13.898146+06
1362	4085	1	1	t	2023-07-13 11:13:13.898146+06
1363	4086	1	1	t	2023-07-13 11:13:13.898146+06
1364	4087	1	1	t	2023-07-13 11:13:13.898146+06
1365	4088	1	1	t	2023-07-13 11:13:13.898146+06
1366	4089	1	1	t	2023-07-13 11:13:13.898146+06
1367	4090	1	1	t	2023-07-13 11:13:13.898146+06
1368	4091	1	1	t	2023-07-13 11:13:13.898146+06
1369	4092	1	1	t	2023-07-13 11:13:13.898146+06
1370	4093	1	1	t	2023-07-13 11:13:13.898146+06
1371	4094	1	1	t	2023-07-13 11:13:13.898146+06
1372	4095	1	1	t	2023-07-13 11:13:13.898146+06
1373	4096	1	1	t	2023-07-13 11:13:13.898146+06
1374	4097	1	1	t	2023-07-13 11:13:13.898146+06
1375	4098	1	1	t	2023-07-13 11:13:13.898146+06
1376	4099	1	1	t	2023-07-13 11:13:13.898146+06
1377	4100	1	1	t	2023-07-13 11:13:13.898146+06
1378	4101	1	1	t	2023-07-13 11:13:13.898146+06
1379	4102	1	1	t	2023-07-13 11:13:13.898146+06
1380	4103	1	1	t	2023-07-13 11:13:13.898146+06
1381	4104	1	1	t	2023-07-13 11:13:13.898146+06
1382	4105	1	1	t	2023-07-13 11:13:13.898146+06
1383	4106	1	1	t	2023-07-13 11:13:13.898146+06
1384	4107	1	1	t	2023-07-13 11:13:13.898146+06
1385	4108	1	1	t	2023-07-13 11:13:13.898146+06
1386	4109	1	1	t	2023-07-13 11:13:13.898146+06
1387	4110	1	1	t	2023-07-13 11:13:13.898146+06
1388	4111	1	1	t	2023-07-13 11:13:13.898146+06
1389	4113	1	1	t	2023-07-13 11:13:13.898146+06
1390	4114	1	1	t	2023-07-13 11:13:13.898146+06
1391	4115	1	1	t	2023-07-13 11:13:13.898146+06
1392	4116	1	1	t	2023-07-13 11:13:13.898146+06
1393	4117	1	1	t	2023-07-13 11:13:13.898146+06
1394	4118	1	1	t	2023-07-13 11:13:13.898146+06
1395	4119	1	1	t	2023-07-13 11:13:13.898146+06
1396	4120	1	1	t	2023-07-13 11:13:13.898146+06
1397	4121	1	1	t	2023-07-13 11:13:13.898146+06
1398	4122	1	1	t	2023-07-13 11:13:13.898146+06
1399	4123	1	1	t	2023-07-13 11:13:13.898146+06
1400	4124	1	1	t	2023-07-13 11:13:13.898146+06
1401	4125	1	1	t	2023-07-13 11:13:13.898146+06
1402	4126	1	1	t	2023-07-13 11:13:13.898146+06
1403	4127	1	1	t	2023-07-13 11:13:13.898146+06
1404	4128	1	1	t	2023-07-13 11:13:13.898146+06
1405	4129	1	1	t	2023-07-13 11:13:13.898146+06
1406	4130	1	1	t	2023-07-13 11:13:13.898146+06
1407	4131	1	1	t	2023-07-13 11:13:13.898146+06
1408	4132	1	1	t	2023-07-13 11:13:13.898146+06
1409	4133	1	1	t	2023-07-13 11:13:13.898146+06
1410	4134	1	1	t	2023-07-13 11:13:13.898146+06
1411	4135	1	1	t	2023-07-13 11:13:13.898146+06
1412	4136	1	1	t	2023-07-13 11:13:13.898146+06
1413	4137	1	1	t	2023-07-13 11:13:13.898146+06
1414	4138	1	1	t	2023-07-13 11:13:13.898146+06
1415	4139	1	1	t	2023-07-13 11:13:13.898146+06
1416	4140	1	1	t	2023-07-13 11:13:13.898146+06
1417	4141	1	1	t	2023-07-13 11:13:13.898146+06
1418	4142	1	1	t	2023-07-13 11:13:13.898146+06
1419	4143	1	1	t	2023-07-13 11:13:13.898146+06
1420	4144	1	1	t	2023-07-13 11:13:13.898146+06
1421	4145	1	1	t	2023-07-13 11:13:13.898146+06
1422	4146	1	1	t	2023-07-13 11:13:13.898146+06
1423	4147	1	1	t	2023-07-13 11:13:13.898146+06
1424	4148	1	1	t	2023-07-13 11:13:13.898146+06
1425	4149	1	1	t	2023-07-13 11:13:13.898146+06
1426	4150	1	1	t	2023-07-13 11:13:13.898146+06
1427	4151	1	1	t	2023-07-13 11:13:13.898146+06
1428	4152	1	1	t	2023-07-13 11:13:13.898146+06
1429	4153	1	1	t	2023-07-13 11:13:13.898146+06
1430	4154	1	1	t	2023-07-13 11:13:13.898146+06
1431	4155	1	1	t	2023-07-13 11:13:13.898146+06
1432	4156	1	1	t	2023-07-13 11:13:13.898146+06
1433	4157	1	1	t	2023-07-13 11:13:13.898146+06
1434	4158	1	1	t	2023-07-13 11:13:13.898146+06
1435	4159	1	1	t	2023-07-13 11:13:13.898146+06
1436	4160	1	1	t	2023-07-13 11:13:13.898146+06
1437	4161	1	1	t	2023-07-13 11:13:13.898146+06
1438	4162	1	1	t	2023-07-13 11:13:13.898146+06
1439	4163	1	1	t	2023-07-13 11:13:13.898146+06
1440	4164	1	1	t	2023-07-13 11:13:13.898146+06
1441	4165	1	1	t	2023-07-13 11:13:13.898146+06
1442	4166	1	1	t	2023-07-13 11:13:13.898146+06
1443	4167	1	1	t	2023-07-13 11:13:13.898146+06
1444	4168	1	1	t	2023-07-13 11:13:13.898146+06
1445	4169	1	1	t	2023-07-13 11:13:13.898146+06
1446	4170	1	1	t	2023-07-13 11:13:13.898146+06
1447	4171	1	1	t	2023-07-13 11:13:13.898146+06
1448	4172	1	1	t	2023-07-13 11:13:13.898146+06
1449	4173	1	1	t	2023-07-13 11:13:13.898146+06
1450	4174	1	1	t	2023-07-13 11:13:13.898146+06
1451	4175	1	1	t	2023-07-13 11:13:13.898146+06
1452	4176	1	1	t	2023-07-13 11:13:13.898146+06
1453	4177	1	1	t	2023-07-13 11:13:13.898146+06
1454	4178	1	1	t	2023-07-13 11:13:13.898146+06
1455	4179	1	1	t	2023-07-13 11:13:13.898146+06
1456	4180	1	1	t	2023-07-13 11:13:13.898146+06
1457	4181	1	1	t	2023-07-13 11:13:13.898146+06
1458	4182	1	1	t	2023-07-13 11:13:13.898146+06
1459	4183	1	1	t	2023-07-13 11:13:13.898146+06
1460	4184	1	1	t	2023-07-13 11:13:13.898146+06
1461	4185	1	1	t	2023-07-13 11:13:13.898146+06
1462	4186	1	1	t	2023-07-13 11:13:13.898146+06
1463	4187	1	1	t	2023-07-13 11:13:13.898146+06
1464	4188	1	1	t	2023-07-13 11:13:13.898146+06
1465	4189	1	1	t	2023-07-13 11:13:13.898146+06
1466	4190	1	1	t	2023-07-13 11:13:13.898146+06
1467	4191	1	1	t	2023-07-13 11:13:13.898146+06
1468	4192	1	1	t	2023-07-13 11:13:13.898146+06
1469	4193	1	1	t	2023-07-13 11:13:13.898146+06
1470	4194	1	1	t	2023-07-13 11:13:13.898146+06
1471	4195	1	1	t	2023-07-13 11:13:13.898146+06
1472	4196	1	1	t	2023-07-13 11:13:13.898146+06
1473	4197	1	1	t	2023-07-13 11:13:13.898146+06
1474	4198	1	1	t	2023-07-13 11:13:13.898146+06
1475	4199	1	1	t	2023-07-13 11:13:13.898146+06
1476	4200	1	1	t	2023-07-13 11:13:13.898146+06
1477	4201	1	1	t	2023-07-13 11:13:13.898146+06
1478	4202	1	1	t	2023-07-13 11:13:13.898146+06
1479	4203	1	1	t	2023-07-13 11:13:13.898146+06
1480	4204	1	1	t	2023-07-13 11:13:13.898146+06
1481	4205	1	1	t	2023-07-13 11:13:13.898146+06
1482	4206	1	1	t	2023-07-13 11:13:13.898146+06
1483	4207	1	1	t	2023-07-13 11:13:13.898146+06
1484	4208	1	1	t	2023-07-13 11:13:13.898146+06
1485	4209	1	1	t	2023-07-13 11:13:13.898146+06
1486	4210	1	1	t	2023-07-13 11:13:13.898146+06
1487	4211	1	1	t	2023-07-13 11:13:13.898146+06
1488	4212	1	1	t	2023-07-13 11:13:13.898146+06
1489	4213	1	1	t	2023-07-13 11:13:13.898146+06
1490	4214	1	1	t	2023-07-13 11:13:13.898146+06
1491	4215	1	1	t	2023-07-13 11:13:13.898146+06
1492	4216	1	1	t	2023-07-13 11:13:13.898146+06
1493	4217	1	1	t	2023-07-13 11:13:13.898146+06
1494	4218	1	1	t	2023-07-13 11:13:13.898146+06
1495	4219	1	1	t	2023-07-13 11:13:13.898146+06
1496	4220	1	1	t	2023-07-13 11:13:13.898146+06
1497	4221	1	1	t	2023-07-13 11:13:13.898146+06
1498	4222	1	1	t	2023-07-13 11:13:13.898146+06
1499	4223	1	1	t	2023-07-13 11:13:13.898146+06
1500	4224	1	1	t	2023-07-13 11:13:13.898146+06
1501	4225	1	1	t	2023-07-13 11:13:13.898146+06
1502	4226	1	1	t	2023-07-13 11:13:13.898146+06
1503	4227	1	1	t	2023-07-13 11:13:13.898146+06
1504	4228	1	1	t	2023-07-13 11:13:13.898146+06
1505	4229	1	1	t	2023-07-13 11:13:13.898146+06
1506	4230	1	1	t	2023-07-13 11:13:13.898146+06
1507	4231	1	1	t	2023-07-13 11:13:13.898146+06
1508	4232	1	1	t	2023-07-13 11:13:13.898146+06
1509	4233	1	1	t	2023-07-13 11:13:13.898146+06
1510	4234	1	1	t	2023-07-13 11:13:13.898146+06
1511	4235	1	1	t	2023-07-13 11:13:13.898146+06
1512	4236	1	1	t	2023-07-13 11:13:13.898146+06
1513	4237	1	1	t	2023-07-13 11:13:13.898146+06
1514	4238	1	1	t	2023-07-13 11:13:13.898146+06
1515	4239	1	1	t	2023-07-13 11:13:13.898146+06
1516	4240	1	1	t	2023-07-13 11:13:13.898146+06
1517	4241	1	1	t	2023-07-13 11:13:13.898146+06
1518	4242	1	1	t	2023-07-13 11:13:13.898146+06
1519	4243	1	1	t	2023-07-13 11:13:13.898146+06
1520	4244	1	1	t	2023-07-13 11:13:13.898146+06
1521	4245	1	1	t	2023-07-13 11:13:13.898146+06
1522	4246	1	1	t	2023-07-13 11:13:13.898146+06
1523	4247	1	1	t	2023-07-13 11:13:13.898146+06
1524	4248	1	1	t	2023-07-13 11:13:13.898146+06
1525	4249	1	1	t	2023-07-13 11:13:13.898146+06
1526	4250	1	1	t	2023-07-13 11:13:13.898146+06
1527	4251	1	1	t	2023-07-13 11:13:13.898146+06
1528	4252	1	1	t	2023-07-13 11:13:13.898146+06
1529	4253	1	1	t	2023-07-13 11:13:13.898146+06
1530	4254	1	1	t	2023-07-13 11:13:13.898146+06
1531	4276	1	1	t	2023-07-13 11:13:13.898146+06
1532	4255	1	1	t	2023-07-13 11:13:13.898146+06
1533	4256	1	1	t	2023-07-13 11:13:13.898146+06
1534	4257	1	1	t	2023-07-13 11:13:13.898146+06
1535	4258	1	1	t	2023-07-13 11:13:13.898146+06
1536	4259	1	1	t	2023-07-13 11:13:13.898146+06
1537	4260	1	1	t	2023-07-13 11:13:13.898146+06
1538	4261	1	1	t	2023-07-13 11:13:13.898146+06
1539	4262	1	1	t	2023-07-13 11:13:13.898146+06
1540	4263	1	1	t	2023-07-13 11:13:13.898146+06
1541	4264	1	1	t	2023-07-13 11:13:13.898146+06
1542	4265	1	1	t	2023-07-13 11:13:13.898146+06
1543	4266	1	1	t	2023-07-13 11:13:13.898146+06
1544	4267	1	1	t	2023-07-13 11:13:13.898146+06
1545	4268	1	1	t	2023-07-13 11:13:13.898146+06
1546	4269	1	1	t	2023-07-13 11:13:13.898146+06
1547	4270	1	1	t	2023-07-13 11:13:13.898146+06
1548	4271	1	1	t	2023-07-13 11:13:13.898146+06
1549	4272	1	1	t	2023-07-13 11:13:13.898146+06
1550	4273	1	1	t	2023-07-13 11:13:13.898146+06
1551	4274	1	1	t	2023-07-13 11:13:13.898146+06
1552	4275	1	1	t	2023-07-13 11:13:13.898146+06
1553	4277	1	1	t	2023-07-13 11:13:13.898146+06
1554	4278	1	1	t	2023-07-13 11:13:13.898146+06
1555	4279	1	1	t	2023-07-13 11:13:13.898146+06
1556	4280	1	1	t	2023-07-13 11:13:13.898146+06
1557	4281	1	1	t	2023-07-13 11:13:13.898146+06
1558	4282	1	1	t	2023-07-13 11:13:13.898146+06
1559	4283	1	1	t	2023-07-13 11:13:13.898146+06
1560	4284	1	1	t	2023-07-13 11:13:13.898146+06
1561	4285	1	1	t	2023-07-13 11:13:13.898146+06
1562	4286	1	1	t	2023-07-13 11:13:13.898146+06
1563	4287	1	1	t	2023-07-13 11:13:13.898146+06
1564	4288	1	1	t	2023-07-13 11:13:13.898146+06
1565	4289	1	1	t	2023-07-13 11:13:13.898146+06
1566	4290	1	1	t	2023-07-13 11:13:13.898146+06
1567	4291	1	1	t	2023-07-13 11:13:13.898146+06
1568	4292	1	1	t	2023-07-13 11:13:13.898146+06
1569	4293	1	1	t	2023-07-13 11:13:13.898146+06
1570	4294	1	1	t	2023-07-13 11:13:13.898146+06
1571	4295	1	1	t	2023-07-13 11:13:13.898146+06
1572	4296	1	1	t	2023-07-13 11:13:13.898146+06
1573	4297	1	1	t	2023-07-13 11:13:13.898146+06
1574	4390	1	1	t	2023-07-13 11:13:13.898146+06
1575	4298	1	1	t	2023-07-13 11:13:13.898146+06
1576	4299	1	1	t	2023-07-13 11:13:13.898146+06
1577	4300	1	1	t	2023-07-13 11:13:13.898146+06
1578	4301	1	1	t	2023-07-13 11:13:13.898146+06
1579	4302	1	1	t	2023-07-13 11:13:13.898146+06
1580	4303	1	1	t	2023-07-13 11:13:13.898146+06
1581	4304	1	1	t	2023-07-13 11:13:13.898146+06
1582	4305	1	1	t	2023-07-13 11:13:13.898146+06
1583	4306	1	1	t	2023-07-13 11:13:13.898146+06
1584	4307	1	1	t	2023-07-13 11:13:13.898146+06
1585	4308	1	1	t	2023-07-13 11:13:13.898146+06
1586	4309	1	1	t	2023-07-13 11:13:13.898146+06
1587	4310	1	1	t	2023-07-13 11:13:13.898146+06
1588	4311	1	1	t	2023-07-13 11:13:13.898146+06
1589	4312	1	1	t	2023-07-13 11:13:13.898146+06
1590	4313	1	1	t	2023-07-13 11:13:13.898146+06
1591	4314	1	1	t	2023-07-13 11:13:13.898146+06
1592	4315	1	1	t	2023-07-13 11:13:13.898146+06
1593	4391	1	1	t	2023-07-13 11:13:13.898146+06
1594	4316	1	1	t	2023-07-13 11:13:13.898146+06
1595	4317	1	1	t	2023-07-13 11:13:13.898146+06
1596	4318	1	1	t	2023-07-13 11:13:13.898146+06
1597	4319	1	1	t	2023-07-13 11:13:13.898146+06
1598	4320	1	1	t	2023-07-13 11:13:13.898146+06
1599	4321	1	1	t	2023-07-13 11:13:13.898146+06
1600	4322	1	1	t	2023-07-13 11:13:13.898146+06
1601	4323	1	1	t	2023-07-13 11:13:13.898146+06
1602	4324	1	1	t	2023-07-13 11:13:13.898146+06
1603	4325	1	1	t	2023-07-13 11:13:13.898146+06
1604	4326	1	1	t	2023-07-13 11:13:13.898146+06
1605	4327	1	1	t	2023-07-13 11:13:13.898146+06
1606	4328	1	1	t	2023-07-13 11:13:13.898146+06
1607	4329	1	1	t	2023-07-13 11:13:13.898146+06
1608	4330	1	1	t	2023-07-13 11:13:13.898146+06
1609	4331	1	1	t	2023-07-13 11:13:13.898146+06
1610	4332	1	1	t	2023-07-13 11:13:13.898146+06
1611	4333	1	1	t	2023-07-13 11:13:13.898146+06
1612	4334	1	1	t	2023-07-13 11:13:13.898146+06
1613	4335	1	1	t	2023-07-13 11:13:13.898146+06
1614	4336	1	1	t	2023-07-13 11:13:13.898146+06
1615	4337	1	1	t	2023-07-13 11:13:13.898146+06
1616	4338	1	1	t	2023-07-13 11:13:13.898146+06
1617	4339	1	1	t	2023-07-13 11:13:13.898146+06
1618	4340	1	1	t	2023-07-13 11:13:13.898146+06
1619	4341	1	1	t	2023-07-13 11:13:13.898146+06
1620	4342	1	1	t	2023-07-13 11:13:13.898146+06
1621	4343	1	1	t	2023-07-13 11:13:13.898146+06
1622	4344	1	1	t	2023-07-13 11:13:13.898146+06
1623	4345	1	1	t	2023-07-13 11:13:13.898146+06
1624	4346	1	1	t	2023-07-13 11:13:13.898146+06
1625	4347	1	1	t	2023-07-13 11:13:13.898146+06
1626	4348	1	1	t	2023-07-13 11:13:13.898146+06
1627	4349	1	1	t	2023-07-13 11:13:13.898146+06
1628	4350	1	1	t	2023-07-13 11:13:13.898146+06
1629	4351	1	1	t	2023-07-13 11:13:13.898146+06
1630	4352	1	1	t	2023-07-13 11:13:13.898146+06
1631	4353	1	1	t	2023-07-13 11:13:13.898146+06
1632	4354	1	1	t	2023-07-13 11:13:13.898146+06
1633	4355	1	1	t	2023-07-13 11:13:13.898146+06
1634	4356	1	1	t	2023-07-13 11:13:13.898146+06
1635	4357	1	1	t	2023-07-13 11:13:13.898146+06
1636	4358	1	1	t	2023-07-13 11:13:13.898146+06
1637	4359	1	1	t	2023-07-13 11:13:13.898146+06
1638	4360	1	1	t	2023-07-13 11:13:13.898146+06
1639	4361	1	1	t	2023-07-13 11:13:13.898146+06
1640	4362	1	1	t	2023-07-13 11:13:13.898146+06
1641	4363	1	1	t	2023-07-13 11:13:13.898146+06
1642	4364	1	1	t	2023-07-13 11:13:13.898146+06
1643	4365	1	1	t	2023-07-13 11:13:13.898146+06
1644	4366	1	1	t	2023-07-13 11:13:13.898146+06
1645	4367	1	1	t	2023-07-13 11:13:13.898146+06
1646	4368	1	1	t	2023-07-13 11:13:13.898146+06
1647	4369	1	1	t	2023-07-13 11:13:13.898146+06
1648	4370	1	1	t	2023-07-13 11:13:13.898146+06
1649	4371	1	1	t	2023-07-13 11:13:13.898146+06
1650	4372	1	1	t	2023-07-13 11:13:13.898146+06
1651	4373	1	1	t	2023-07-13 11:13:13.898146+06
1652	4374	1	1	t	2023-07-13 11:13:13.898146+06
1653	4375	1	1	t	2023-07-13 11:13:13.898146+06
1654	4376	1	1	t	2023-07-13 11:13:13.898146+06
1655	4377	1	1	t	2023-07-13 11:13:13.898146+06
1656	4378	1	1	t	2023-07-13 11:13:13.898146+06
1657	4379	1	1	t	2023-07-13 11:13:13.898146+06
1658	4380	1	1	t	2023-07-13 11:13:13.898146+06
1659	4381	1	1	t	2023-07-13 11:13:13.898146+06
1660	4382	1	1	t	2023-07-13 11:13:13.898146+06
1661	4383	1	1	t	2023-07-13 11:13:13.898146+06
1662	4384	1	1	t	2023-07-13 11:13:13.898146+06
1663	4385	1	1	t	2023-07-13 11:13:13.898146+06
1664	4386	1	1	t	2023-07-13 11:13:13.898146+06
1665	4387	1	1	t	2023-07-13 11:13:13.898146+06
1666	4388	1	1	t	2023-07-13 11:13:13.898146+06
1667	4389	1	1	t	2023-07-13 11:13:13.898146+06
1668	4392	1	1	t	2023-07-13 11:13:13.898146+06
1669	4393	1	1	t	2023-07-13 11:13:13.898146+06
1670	4394	1	1	t	2023-07-13 11:13:13.898146+06
1671	4395	1	1	t	2023-07-13 11:13:13.898146+06
1672	4396	1	1	t	2023-07-13 11:13:13.898146+06
1673	4397	1	1	t	2023-07-13 11:13:13.898146+06
1674	4398	1	1	t	2023-07-13 11:13:13.898146+06
1675	4399	1	1	t	2023-07-13 11:13:13.898146+06
1676	4400	1	1	t	2023-07-13 11:13:13.898146+06
1677	4401	1	1	t	2023-07-13 11:13:13.898146+06
1678	4402	1	1	t	2023-07-13 11:13:13.898146+06
1679	4403	1	1	t	2023-07-13 11:13:13.898146+06
1680	4404	1	1	t	2023-07-13 11:13:13.898146+06
1681	4405	1	1	t	2023-07-13 11:13:13.898146+06
1682	4406	1	1	t	2023-07-13 11:13:13.898146+06
1683	4407	1	1	t	2023-07-13 11:13:13.898146+06
1684	4408	1	1	t	2023-07-13 11:13:13.898146+06
1685	4409	1	1	t	2023-07-13 11:13:13.898146+06
1686	4410	1	1	t	2023-07-13 11:13:13.898146+06
1687	4411	1	1	t	2023-07-13 11:13:13.898146+06
1688	4412	1	1	t	2023-07-13 11:13:13.898146+06
1689	4413	1	1	t	2023-07-13 11:13:13.898146+06
1690	4414	1	1	t	2023-07-13 11:13:13.898146+06
1691	4415	1	1	t	2023-07-13 11:13:13.898146+06
1692	4416	1	1	t	2023-07-13 11:13:13.898146+06
1693	4417	1	1	t	2023-07-13 11:13:13.898146+06
1694	4418	1	1	t	2023-07-13 11:13:13.898146+06
1695	4419	1	1	t	2023-07-13 11:13:13.898146+06
1696	4420	1	1	t	2023-07-13 11:13:13.898146+06
1697	4421	1	1	t	2023-07-13 11:13:13.898146+06
1698	4422	1	1	t	2023-07-13 11:13:13.898146+06
1699	4423	1	1	t	2023-07-13 11:13:13.898146+06
1700	4424	1	1	t	2023-07-13 11:13:13.898146+06
1701	4425	1	1	t	2023-07-13 11:13:13.898146+06
1702	4426	1	1	t	2023-07-13 11:13:13.898146+06
1703	4427	1	1	t	2023-07-13 11:13:13.898146+06
1704	4428	1	1	t	2023-07-13 11:13:13.898146+06
1705	4429	1	1	t	2023-07-13 11:13:13.898146+06
1706	4430	1	1	t	2023-07-13 11:13:13.898146+06
1707	4431	1	1	t	2023-07-13 11:13:13.898146+06
1708	4432	1	1	t	2023-07-13 11:13:13.898146+06
1709	4433	1	1	t	2023-07-13 11:13:13.898146+06
1710	4434	1	1	t	2023-07-13 11:13:13.898146+06
1711	4435	1	1	t	2023-07-13 11:13:13.898146+06
1712	4436	1	1	t	2023-07-13 11:13:13.898146+06
1713	4437	1	1	t	2023-07-13 11:13:13.898146+06
1714	4438	1	1	t	2023-07-13 11:13:13.898146+06
1715	4439	1	1	t	2023-07-13 11:13:13.898146+06
1716	4440	1	1	t	2023-07-13 11:13:13.898146+06
1717	4441	1	1	t	2023-07-13 11:13:13.898146+06
1718	4442	1	1	t	2023-07-13 11:13:13.898146+06
1719	4443	1	1	t	2023-07-13 11:13:13.898146+06
1720	4444	1	1	t	2023-07-13 11:13:13.898146+06
1721	4445	1	1	t	2023-07-13 11:13:13.898146+06
1722	4446	1	1	t	2023-07-13 11:13:13.898146+06
1723	4447	1	1	t	2023-07-13 11:13:13.898146+06
1724	4448	1	1	t	2023-07-13 11:13:13.898146+06
1725	4449	1	1	t	2023-07-13 11:13:13.898146+06
1726	4450	1	1	t	2023-07-13 11:13:13.898146+06
1727	4451	1	1	t	2023-07-13 11:13:13.898146+06
1728	4452	1	1	t	2023-07-13 11:13:13.898146+06
1729	4453	1	1	t	2023-07-13 11:13:13.898146+06
1730	4454	1	1	t	2023-07-13 11:13:13.898146+06
1731	4455	1	1	t	2023-07-13 11:13:13.898146+06
1732	4456	1	1	t	2023-07-13 11:13:13.898146+06
1733	4457	1	1	t	2023-07-13 11:13:13.898146+06
1734	4458	1	1	t	2023-07-13 11:13:13.898146+06
1735	4459	1	1	t	2023-07-13 11:13:13.898146+06
1736	4460	1	1	t	2023-07-13 11:13:13.898146+06
1737	4461	1	1	t	2023-07-13 11:13:13.898146+06
1738	4462	1	1	t	2023-07-13 11:13:13.898146+06
1739	4463	1	1	t	2023-07-13 11:13:13.898146+06
1740	4464	1	1	t	2023-07-13 11:13:13.898146+06
1741	4465	1	1	t	2023-07-13 11:13:13.898146+06
1742	4466	1	1	t	2023-07-13 11:13:13.898146+06
1743	4467	1	1	t	2023-07-13 11:13:13.898146+06
1744	4500	1	1	t	2023-07-13 11:13:13.898146+06
1745	4468	1	1	t	2023-07-13 11:13:13.898146+06
1746	4469	1	1	t	2023-07-13 11:13:13.898146+06
1747	4470	1	1	t	2023-07-13 11:13:13.898146+06
1748	4471	1	1	t	2023-07-13 11:13:13.898146+06
1749	4472	1	1	t	2023-07-13 11:13:13.898146+06
1750	4473	1	1	t	2023-07-13 11:13:13.898146+06
1751	4474	1	1	t	2023-07-13 11:13:13.898146+06
1752	4475	1	1	t	2023-07-13 11:13:13.898146+06
1753	4476	1	1	t	2023-07-13 11:13:13.898146+06
1754	4477	1	1	t	2023-07-13 11:13:13.898146+06
1755	4478	1	1	t	2023-07-13 11:13:13.898146+06
1756	4479	1	1	t	2023-07-13 11:13:13.898146+06
1757	4480	1	1	t	2023-07-13 11:13:13.898146+06
1758	4481	1	1	t	2023-07-13 11:13:13.898146+06
1759	4482	1	1	t	2023-07-13 11:13:13.898146+06
1760	4483	1	1	t	2023-07-13 11:13:13.898146+06
1761	4484	1	1	t	2023-07-13 11:13:13.898146+06
1762	4485	1	1	t	2023-07-13 11:13:13.898146+06
1763	4568	1	1	t	2023-07-13 11:13:13.898146+06
1764	4486	1	1	t	2023-07-13 11:13:13.898146+06
1765	4487	1	1	t	2023-07-13 11:13:13.898146+06
1766	4488	1	1	t	2023-07-13 11:13:13.898146+06
1767	4489	1	1	t	2023-07-13 11:13:13.898146+06
1768	4490	1	1	t	2023-07-13 11:13:13.898146+06
1769	4491	1	1	t	2023-07-13 11:13:13.898146+06
1770	4492	1	1	t	2023-07-13 11:13:13.898146+06
1771	4493	1	1	t	2023-07-13 11:13:13.898146+06
1772	4494	1	1	t	2023-07-13 11:13:13.898146+06
1773	4495	1	1	t	2023-07-13 11:13:13.898146+06
1774	4496	1	1	t	2023-07-13 11:13:13.898146+06
1775	4497	1	1	t	2023-07-13 11:13:13.898146+06
1776	4498	1	1	t	2023-07-13 11:13:13.898146+06
1777	4499	1	1	t	2023-07-13 11:13:13.898146+06
1778	4501	1	1	t	2023-07-13 11:13:13.898146+06
1779	4502	1	1	t	2023-07-13 11:13:13.898146+06
1780	4503	1	1	t	2023-07-13 11:13:13.898146+06
1781	4504	1	1	t	2023-07-13 11:13:13.898146+06
1782	4505	1	1	t	2023-07-13 11:13:13.898146+06
1783	4506	1	1	t	2023-07-13 11:13:13.898146+06
1784	4507	1	1	t	2023-07-13 11:13:13.898146+06
1785	4508	1	1	t	2023-07-13 11:13:13.898146+06
1786	4509	1	1	t	2023-07-13 11:13:13.898146+06
1787	4510	1	1	t	2023-07-13 11:13:13.898146+06
1788	4511	1	1	t	2023-07-13 11:13:13.898146+06
1789	4512	1	1	t	2023-07-13 11:13:13.898146+06
1790	4513	1	1	t	2023-07-13 11:13:13.898146+06
1791	4514	1	1	t	2023-07-13 11:13:13.898146+06
1792	4515	1	1	t	2023-07-13 11:13:13.898146+06
1793	4516	1	1	t	2023-07-13 11:13:13.898146+06
1794	4517	1	1	t	2023-07-13 11:13:13.898146+06
1795	4518	1	1	t	2023-07-13 11:13:13.898146+06
1796	4519	1	1	t	2023-07-13 11:13:13.898146+06
1797	4520	1	1	t	2023-07-13 11:13:13.898146+06
1798	4521	1	1	t	2023-07-13 11:13:13.898146+06
1799	4522	1	1	t	2023-07-13 11:13:13.898146+06
1800	4523	1	1	t	2023-07-13 11:13:13.898146+06
1801	4524	1	1	t	2023-07-13 11:13:13.898146+06
1802	4525	1	1	t	2023-07-13 11:13:13.898146+06
1803	4526	1	1	t	2023-07-13 11:13:13.898146+06
1804	4527	1	1	t	2023-07-13 11:13:13.898146+06
1805	4528	1	1	t	2023-07-13 11:13:13.898146+06
1806	4529	1	1	t	2023-07-13 11:13:13.898146+06
1807	4530	1	1	t	2023-07-13 11:13:13.898146+06
1808	4531	1	1	t	2023-07-13 11:13:13.898146+06
1809	4532	1	1	t	2023-07-13 11:13:13.898146+06
1810	4533	1	1	t	2023-07-13 11:13:13.898146+06
1811	4534	1	1	t	2023-07-13 11:13:13.898146+06
1812	4535	1	1	t	2023-07-13 11:13:13.898146+06
1813	4536	1	1	t	2023-07-13 11:13:13.898146+06
1814	4537	1	1	t	2023-07-13 11:13:13.898146+06
1815	4538	1	1	t	2023-07-13 11:13:13.898146+06
1816	4539	1	1	t	2023-07-13 11:13:13.898146+06
1817	4540	1	1	t	2023-07-13 11:13:13.898146+06
1818	4541	1	1	t	2023-07-13 11:13:13.898146+06
1819	4542	1	1	t	2023-07-13 11:13:13.898146+06
1820	4543	1	1	t	2023-07-13 11:13:13.898146+06
1821	4544	1	1	t	2023-07-13 11:13:13.898146+06
1822	4545	1	1	t	2023-07-13 11:13:13.898146+06
1823	4546	1	1	t	2023-07-13 11:13:13.898146+06
1824	4547	1	1	t	2023-07-13 11:13:13.898146+06
1825	4548	1	1	t	2023-07-13 11:13:13.898146+06
1826	4549	1	1	t	2023-07-13 11:13:13.898146+06
1827	4550	1	1	t	2023-07-13 11:13:13.898146+06
1828	4551	1	1	t	2023-07-13 11:13:13.898146+06
1829	4552	1	1	t	2023-07-13 11:13:13.898146+06
1830	4553	1	1	t	2023-07-13 11:13:13.898146+06
1831	4554	1	1	t	2023-07-13 11:13:13.898146+06
1832	4555	1	1	t	2023-07-13 11:13:13.898146+06
1833	4556	1	1	t	2023-07-13 11:13:13.898146+06
1834	4557	1	1	t	2023-07-13 11:13:13.898146+06
1835	4558	1	1	t	2023-07-13 11:13:13.898146+06
1836	4559	1	1	t	2023-07-13 11:13:13.898146+06
1837	4560	1	1	t	2023-07-13 11:13:13.898146+06
1838	4561	1	1	t	2023-07-13 11:13:13.898146+06
1839	4562	1	1	t	2023-07-13 11:13:13.898146+06
1840	4563	1	1	t	2023-07-13 11:13:13.898146+06
1841	4564	1	1	t	2023-07-13 11:13:13.898146+06
1842	4565	1	1	t	2023-07-13 11:13:13.898146+06
1843	4566	1	1	t	2023-07-13 11:13:13.898146+06
1844	4567	1	1	t	2023-07-13 11:13:13.898146+06
1845	4569	1	1	t	2023-07-13 11:13:13.898146+06
1846	4570	1	1	t	2023-07-13 11:13:13.898146+06
1847	4571	1	1	t	2023-07-13 11:13:13.898146+06
1848	4572	1	1	t	2023-07-13 11:13:13.898146+06
1849	4573	1	1	t	2023-07-13 11:13:13.898146+06
1850	4574	1	1	t	2023-07-13 11:13:13.898146+06
1851	4575	1	1	t	2023-07-13 11:13:13.898146+06
1852	4576	1	1	t	2023-07-13 11:13:13.898146+06
1853	4577	1	1	t	2023-07-13 11:13:13.898146+06
1854	4578	1	1	t	2023-07-13 11:13:13.898146+06
1855	4579	1	1	t	2023-07-13 11:13:13.898146+06
1856	4580	1	1	t	2023-07-13 11:13:13.898146+06
1857	4581	1	1	t	2023-07-13 11:13:13.898146+06
1858	4582	1	1	t	2023-07-13 11:13:13.898146+06
1859	4583	1	1	t	2023-07-13 11:13:13.898146+06
1860	4584	1	1	t	2023-07-13 11:13:13.898146+06
1861	4585	1	1	t	2023-07-13 11:13:13.898146+06
1862	4586	1	1	t	2023-07-13 11:13:13.898146+06
1863	4587	1	1	t	2023-07-13 11:13:13.898146+06
1864	4657	1	1	t	2023-07-13 11:13:13.898146+06
1865	4588	1	1	t	2023-07-13 11:13:13.898146+06
1866	4589	1	1	t	2023-07-13 11:13:13.898146+06
1867	4590	1	1	t	2023-07-13 11:13:13.898146+06
1868	4591	1	1	t	2023-07-13 11:13:13.898146+06
1869	4592	1	1	t	2023-07-13 11:13:13.898146+06
1870	4593	1	1	t	2023-07-13 11:13:13.898146+06
1871	4594	1	1	t	2023-07-13 11:13:13.898146+06
1872	4595	1	1	t	2023-07-13 11:13:13.898146+06
1873	4596	1	1	t	2023-07-13 11:13:13.898146+06
1874	4597	1	1	t	2023-07-13 11:13:13.898146+06
1875	4598	1	1	t	2023-07-13 11:13:13.898146+06
1876	4599	1	1	t	2023-07-13 11:13:13.898146+06
1877	4600	1	1	t	2023-07-13 11:13:13.898146+06
1878	4601	1	1	t	2023-07-13 11:13:13.898146+06
1879	4602	1	1	t	2023-07-13 11:13:13.898146+06
1880	4603	1	1	t	2023-07-13 11:13:13.898146+06
1881	4604	1	1	t	2023-07-13 11:13:13.898146+06
1882	4605	1	1	t	2023-07-13 11:13:13.898146+06
1883	4606	1	1	t	2023-07-13 11:13:13.898146+06
1884	4607	1	1	t	2023-07-13 11:13:13.898146+06
1885	4608	1	1	t	2023-07-13 11:13:13.898146+06
1886	4609	1	1	t	2023-07-13 11:13:13.898146+06
1887	4610	1	1	t	2023-07-13 11:13:13.898146+06
1888	4611	1	1	t	2023-07-13 11:13:13.898146+06
1889	4612	1	1	t	2023-07-13 11:13:13.898146+06
1890	4613	1	1	t	2023-07-13 11:13:13.898146+06
1891	4614	1	1	t	2023-07-13 11:13:13.898146+06
1892	4615	1	1	t	2023-07-13 11:13:13.898146+06
1893	4616	1	1	t	2023-07-13 11:13:13.898146+06
1894	4617	1	1	t	2023-07-13 11:13:13.898146+06
1895	4678	1	1	t	2023-07-13 11:13:13.898146+06
1896	4618	1	1	t	2023-07-13 11:13:13.898146+06
1897	4619	1	1	t	2023-07-13 11:13:13.898146+06
1898	4620	1	1	t	2023-07-13 11:13:13.898146+06
1899	4621	1	1	t	2023-07-13 11:13:13.898146+06
1900	4622	1	1	t	2023-07-13 11:13:13.898146+06
1901	4623	1	1	t	2023-07-13 11:13:13.898146+06
1902	4624	1	1	t	2023-07-13 11:13:13.898146+06
1903	4625	1	1	t	2023-07-13 11:13:13.898146+06
1904	4626	1	1	t	2023-07-13 11:13:13.898146+06
1905	4627	1	1	t	2023-07-13 11:13:13.898146+06
1906	4628	1	1	t	2023-07-13 11:13:13.898146+06
1907	4629	1	1	t	2023-07-13 11:13:13.898146+06
1908	4630	1	1	t	2023-07-13 11:13:13.898146+06
1909	4631	1	1	t	2023-07-13 11:13:13.898146+06
1910	4632	1	1	t	2023-07-13 11:13:13.898146+06
1911	4633	1	1	t	2023-07-13 11:13:13.898146+06
1912	4634	1	1	t	2023-07-13 11:13:13.898146+06
1913	4635	1	1	t	2023-07-13 11:13:13.898146+06
1914	4636	1	1	t	2023-07-13 11:13:13.898146+06
1915	4740	1	1	t	2023-07-13 11:13:13.898146+06
1916	4637	1	1	t	2023-07-13 11:13:13.898146+06
1917	4638	1	1	t	2023-07-13 11:13:13.898146+06
1918	4639	1	1	t	2023-07-13 11:13:13.898146+06
1919	4640	1	1	t	2023-07-13 11:13:13.898146+06
1920	4641	1	1	t	2023-07-13 11:13:13.898146+06
1921	4642	1	1	t	2023-07-13 11:13:13.898146+06
1922	4643	1	1	t	2023-07-13 11:13:13.898146+06
1923	4644	1	1	t	2023-07-13 11:13:13.898146+06
1924	4645	1	1	t	2023-07-13 11:13:13.898146+06
1925	4646	1	1	t	2023-07-13 11:13:13.898146+06
1926	4647	1	1	t	2023-07-13 11:13:13.898146+06
1927	4648	1	1	t	2023-07-13 11:13:13.898146+06
1928	4649	1	1	t	2023-07-13 11:13:13.898146+06
1929	4650	1	1	t	2023-07-13 11:13:13.898146+06
1930	4651	1	1	t	2023-07-13 11:13:13.898146+06
1931	4652	1	1	t	2023-07-13 11:13:13.898146+06
1932	4653	1	1	t	2023-07-13 11:13:13.898146+06
1933	4654	1	1	t	2023-07-13 11:13:13.898146+06
1934	4655	1	1	t	2023-07-13 11:13:13.898146+06
1935	4656	1	1	t	2023-07-13 11:13:13.898146+06
1936	4741	1	1	t	2023-07-13 11:13:13.898146+06
1937	4658	1	1	t	2023-07-13 11:13:13.898146+06
1938	4659	1	1	t	2023-07-13 11:13:13.898146+06
1939	4660	1	1	t	2023-07-13 11:13:13.898146+06
1940	4661	1	1	t	2023-07-13 11:13:13.898146+06
1941	4662	1	1	t	2023-07-13 11:13:13.898146+06
1942	4663	1	1	t	2023-07-13 11:13:13.898146+06
1943	4664	1	1	t	2023-07-13 11:13:13.898146+06
1944	4665	1	1	t	2023-07-13 11:13:13.898146+06
1945	4666	1	1	t	2023-07-13 11:13:13.898146+06
1946	4667	1	1	t	2023-07-13 11:13:13.898146+06
1947	4668	1	1	t	2023-07-13 11:13:13.898146+06
1948	4669	1	1	t	2023-07-13 11:13:13.898146+06
1949	4670	1	1	t	2023-07-13 11:13:13.898146+06
1950	4671	1	1	t	2023-07-13 11:13:13.898146+06
1951	4672	1	1	t	2023-07-13 11:13:13.898146+06
1952	4673	1	1	t	2023-07-13 11:13:13.898146+06
1953	4674	1	1	t	2023-07-13 11:13:13.898146+06
1954	4675	1	1	t	2023-07-13 11:13:13.898146+06
1955	4676	1	1	t	2023-07-13 11:13:13.898146+06
1956	4677	1	1	t	2023-07-13 11:13:13.898146+06
1957	4763	1	1	t	2023-07-13 11:13:13.898146+06
1958	4679	1	1	t	2023-07-13 11:13:13.898146+06
1959	4680	1	1	t	2023-07-13 11:13:13.898146+06
1960	4681	1	1	t	2023-07-13 11:13:13.898146+06
1961	4682	1	1	t	2023-07-13 11:13:13.898146+06
1962	4683	1	1	t	2023-07-13 11:13:13.898146+06
1963	4684	1	1	t	2023-07-13 11:13:13.898146+06
1964	4685	1	1	t	2023-07-13 11:13:13.898146+06
1965	4686	1	1	t	2023-07-13 11:13:13.898146+06
1966	4687	1	1	t	2023-07-13 11:13:13.898146+06
1967	4688	1	1	t	2023-07-13 11:13:13.898146+06
1968	4689	1	1	t	2023-07-13 11:13:13.898146+06
1969	4690	1	1	t	2023-07-13 11:13:13.898146+06
1970	4691	1	1	t	2023-07-13 11:13:13.898146+06
1971	4692	1	1	t	2023-07-13 11:13:13.898146+06
1972	4693	1	1	t	2023-07-13 11:13:13.898146+06
1973	4694	1	1	t	2023-07-13 11:13:13.898146+06
1974	4695	1	1	t	2023-07-13 11:13:13.898146+06
1975	4696	1	1	t	2023-07-13 11:13:13.898146+06
1976	4697	1	1	t	2023-07-13 11:13:13.898146+06
1977	4698	1	1	t	2023-07-13 11:13:13.898146+06
1978	4699	1	1	t	2023-07-13 11:13:13.898146+06
1979	4700	1	1	t	2023-07-13 11:13:13.898146+06
1980	4701	1	1	t	2023-07-13 11:13:13.898146+06
1981	4764	1	1	t	2023-07-13 11:13:13.898146+06
1982	4702	1	1	t	2023-07-13 11:13:13.898146+06
1983	4703	1	1	t	2023-07-13 11:13:13.898146+06
1984	4704	1	1	t	2023-07-13 11:13:13.898146+06
1985	4705	1	1	t	2023-07-13 11:13:13.898146+06
1986	4706	1	1	t	2023-07-13 11:13:13.898146+06
1987	4707	1	1	t	2023-07-13 11:13:13.898146+06
1988	4708	1	1	t	2023-07-13 11:13:13.898146+06
1989	4709	1	1	t	2023-07-13 11:13:13.898146+06
1990	4710	1	1	t	2023-07-13 11:13:13.898146+06
1991	4711	1	1	t	2023-07-13 11:13:13.898146+06
1992	4712	1	1	t	2023-07-13 11:13:13.898146+06
1993	4713	1	1	t	2023-07-13 11:13:13.898146+06
1994	4714	1	1	t	2023-07-13 11:13:13.898146+06
1995	4715	1	1	t	2023-07-13 11:13:13.898146+06
1996	4716	1	1	t	2023-07-13 11:13:13.898146+06
1997	4717	1	1	t	2023-07-13 11:13:13.898146+06
1998	4718	1	1	t	2023-07-13 11:13:13.898146+06
1999	4719	1	1	t	2023-07-13 11:13:13.898146+06
2000	4720	1	1	t	2023-07-13 11:13:13.898146+06
2001	4721	1	1	t	2023-07-13 11:13:13.898146+06
2002	4722	1	1	t	2023-07-13 11:13:13.898146+06
2003	4723	1	1	t	2023-07-13 11:13:13.898146+06
2004	4724	1	1	t	2023-07-13 11:13:13.898146+06
2005	4725	1	1	t	2023-07-13 11:13:13.898146+06
2006	4726	1	1	t	2023-07-13 11:13:13.898146+06
2007	4727	1	1	t	2023-07-13 11:13:13.898146+06
2008	4728	1	1	t	2023-07-13 11:13:13.898146+06
2009	4729	1	1	t	2023-07-13 11:13:13.898146+06
2010	4730	1	1	t	2023-07-13 11:13:13.898146+06
2011	4731	1	1	t	2023-07-13 11:13:13.898146+06
2012	4732	1	1	t	2023-07-13 11:13:13.898146+06
2013	4733	1	1	t	2023-07-13 11:13:13.898146+06
2014	4734	1	1	t	2023-07-13 11:13:13.898146+06
2015	4735	1	1	t	2023-07-13 11:13:13.898146+06
2016	4736	1	1	t	2023-07-13 11:13:13.898146+06
2017	4737	1	1	t	2023-07-13 11:13:13.898146+06
2018	4738	1	1	t	2023-07-13 11:13:13.898146+06
2019	4739	1	1	t	2023-07-13 11:13:13.898146+06
2020	4742	1	1	t	2023-07-13 11:13:13.898146+06
2021	4743	1	1	t	2023-07-13 11:13:13.898146+06
2022	4744	1	1	t	2023-07-13 11:13:13.898146+06
2023	4745	1	1	t	2023-07-13 11:13:13.898146+06
2024	4746	1	1	t	2023-07-13 11:13:13.898146+06
2025	4747	1	1	t	2023-07-13 11:13:13.898146+06
2026	4748	1	1	t	2023-07-13 11:13:13.898146+06
2027	4749	1	1	t	2023-07-13 11:13:13.898146+06
2028	4750	1	1	t	2023-07-13 11:13:13.898146+06
2029	4751	1	1	t	2023-07-13 11:13:13.898146+06
2030	4752	1	1	t	2023-07-13 11:13:13.898146+06
2031	4753	1	1	t	2023-07-13 11:13:13.898146+06
2032	4754	1	1	t	2023-07-13 11:13:13.898146+06
2033	4755	1	1	t	2023-07-13 11:13:13.898146+06
2034	4756	1	1	t	2023-07-13 11:13:13.898146+06
2035	4757	1	1	t	2023-07-13 11:13:13.898146+06
2036	4758	1	1	t	2023-07-13 11:13:13.898146+06
2037	4759	1	1	t	2023-07-13 11:13:13.898146+06
2038	4760	1	1	t	2023-07-13 11:13:13.898146+06
2039	4761	1	1	t	2023-07-13 11:13:13.898146+06
2040	4762	1	1	t	2023-07-13 11:13:13.898146+06
2041	4765	1	1	t	2023-07-13 11:13:13.898146+06
2042	4766	1	1	t	2023-07-13 11:13:13.898146+06
2043	4767	1	1	t	2023-07-13 11:13:13.898146+06
2044	4768	1	1	t	2023-07-13 11:13:13.898146+06
2045	4769	1	1	t	2023-07-13 11:13:13.898146+06
2046	4770	1	1	t	2023-07-13 11:13:13.898146+06
2047	4771	1	1	t	2023-07-13 11:13:13.898146+06
2048	4772	1	1	t	2023-07-13 11:13:13.898146+06
2049	4773	1	1	t	2023-07-13 11:13:13.898146+06
2050	4774	1	1	t	2023-07-13 11:13:13.898146+06
2051	4775	1	1	t	2023-07-13 11:13:13.898146+06
2052	4776	1	1	t	2023-07-13 11:13:13.898146+06
2053	4777	1	1	t	2023-07-13 11:13:13.898146+06
2054	4778	1	1	t	2023-07-13 11:13:13.898146+06
2055	4779	1	1	t	2023-07-13 11:13:13.898146+06
2056	4780	1	1	t	2023-07-13 11:13:13.898146+06
2057	4781	1	1	t	2023-07-13 11:13:13.898146+06
2058	4782	1	1	t	2023-07-13 11:13:13.898146+06
2059	4783	1	1	t	2023-07-13 11:13:13.898146+06
2060	4784	1	1	t	2023-07-13 11:13:13.898146+06
2061	4785	1	1	t	2023-07-13 11:13:13.898146+06
2062	4786	1	1	t	2023-07-13 11:13:13.898146+06
2063	4787	1	1	t	2023-07-13 11:13:13.898146+06
2064	4788	1	1	t	2023-07-13 11:13:13.898146+06
2065	4789	1	1	t	2023-07-13 11:13:13.898146+06
2066	4790	1	1	t	2023-07-13 11:13:13.898146+06
2067	4791	1	1	t	2023-07-13 11:13:13.898146+06
2068	4792	1	1	t	2023-07-13 11:13:13.898146+06
2069	4793	1	1	t	2023-07-13 11:13:13.898146+06
2070	4794	1	1	t	2023-07-13 11:13:13.898146+06
2071	4795	1	1	t	2023-07-13 11:13:13.898146+06
2072	4796	1	1	t	2023-07-13 11:13:13.898146+06
2073	4797	1	1	t	2023-07-13 11:13:13.898146+06
2074	4798	1	1	t	2023-07-13 11:13:13.898146+06
2075	4799	1	1	t	2023-07-13 11:13:13.898146+06
2076	4800	1	1	t	2023-07-13 11:13:13.898146+06
2077	4801	1	1	t	2023-07-13 11:13:13.898146+06
2078	4802	1	1	t	2023-07-13 11:13:13.898146+06
2079	4803	1	1	t	2023-07-13 11:13:13.898146+06
2080	4804	1	1	t	2023-07-13 11:13:13.898146+06
2081	4805	1	1	t	2023-07-13 11:13:13.898146+06
2082	4806	1	1	t	2023-07-13 11:13:13.898146+06
2083	4807	1	1	t	2023-07-13 11:13:13.898146+06
2084	4808	1	1	t	2023-07-13 11:13:13.898146+06
2085	4809	1	1	t	2023-07-13 11:13:13.898146+06
2086	4810	1	1	t	2023-07-13 11:13:13.898146+06
2087	4811	1	1	t	2023-07-13 11:13:13.898146+06
2088	4812	1	1	t	2023-07-13 11:13:13.898146+06
2089	4813	1	1	t	2023-07-13 11:13:13.898146+06
2090	4814	1	1	t	2023-07-13 11:13:13.898146+06
2091	4815	1	1	t	2023-07-13 11:13:13.898146+06
2092	4816	1	1	t	2023-07-13 11:13:13.898146+06
2093	4817	1	1	t	2023-07-13 11:13:13.898146+06
2094	4818	1	1	t	2023-07-13 11:13:13.898146+06
2095	4819	1	1	t	2023-07-13 11:13:13.898146+06
2096	4820	1	1	t	2023-07-13 11:13:13.898146+06
2097	4821	1	1	t	2023-07-13 11:13:13.898146+06
2098	4822	1	1	t	2023-07-13 11:13:13.898146+06
2099	4823	1	1	t	2023-07-13 11:13:13.898146+06
2100	4824	1	1	t	2023-07-13 11:13:13.898146+06
2101	4825	1	1	t	2023-07-13 11:13:13.898146+06
2102	4826	1	1	t	2023-07-13 11:13:13.898146+06
2103	4845	1	1	t	2023-07-13 11:13:13.898146+06
2104	4846	1	1	t	2023-07-13 11:13:13.898146+06
2105	4827	1	1	t	2023-07-13 11:13:13.898146+06
2106	4828	1	1	t	2023-07-13 11:13:13.898146+06
2107	4829	1	1	t	2023-07-13 11:13:13.898146+06
2108	4830	1	1	t	2023-07-13 11:13:13.898146+06
2109	4831	1	1	t	2023-07-13 11:13:13.898146+06
2110	4832	1	1	t	2023-07-13 11:13:13.898146+06
2111	4833	1	1	t	2023-07-13 11:13:13.898146+06
2112	4834	1	1	t	2023-07-13 11:13:13.898146+06
2113	4835	1	1	t	2023-07-13 11:13:13.898146+06
2114	4836	1	1	t	2023-07-13 11:13:13.898146+06
2115	4837	1	1	t	2023-07-13 11:13:13.898146+06
2116	4838	1	1	t	2023-07-13 11:13:13.898146+06
2117	4839	1	1	t	2023-07-13 11:13:13.898146+06
2118	4840	1	1	t	2023-07-13 11:13:13.898146+06
2119	4841	1	1	t	2023-07-13 11:13:13.898146+06
2120	4842	1	1	t	2023-07-13 11:13:13.898146+06
2121	4843	1	1	t	2023-07-13 11:13:13.898146+06
2122	4844	1	1	t	2023-07-13 11:13:13.898146+06
2123	4866	1	1	t	2023-07-13 11:13:13.898146+06
2124	4847	1	1	t	2023-07-13 11:13:13.898146+06
2125	4848	1	1	t	2023-07-13 11:13:13.898146+06
2126	4849	1	1	t	2023-07-13 11:13:13.898146+06
2127	4850	1	1	t	2023-07-13 11:13:13.898146+06
2128	4851	1	1	t	2023-07-13 11:13:13.898146+06
2129	4852	1	1	t	2023-07-13 11:13:13.898146+06
2130	4853	1	1	t	2023-07-13 11:13:13.898146+06
2131	4854	1	1	t	2023-07-13 11:13:13.898146+06
2132	4855	1	1	t	2023-07-13 11:13:13.898146+06
2133	4856	1	1	t	2023-07-13 11:13:13.898146+06
2134	4857	1	1	t	2023-07-13 11:13:13.898146+06
2135	4858	1	1	t	2023-07-13 11:13:13.898146+06
2136	4859	1	1	t	2023-07-13 11:13:13.898146+06
2137	4860	1	1	t	2023-07-13 11:13:13.898146+06
2138	4861	1	1	t	2023-07-13 11:13:13.898146+06
2139	4862	1	1	t	2023-07-13 11:13:13.898146+06
2140	4863	1	1	t	2023-07-13 11:13:13.898146+06
2141	4864	1	1	t	2023-07-13 11:13:13.898146+06
2142	4865	1	1	t	2023-07-13 11:13:13.898146+06
2143	4867	1	1	t	2023-07-13 11:13:13.898146+06
2144	4868	1	1	t	2023-07-13 11:13:13.898146+06
2145	4869	1	1	t	2023-07-13 11:13:13.898146+06
2146	4870	1	1	t	2023-07-13 11:13:13.898146+06
2147	4871	1	1	t	2023-07-13 11:13:13.898146+06
2148	4872	1	1	t	2023-07-13 11:13:13.898146+06
2149	4873	1	1	t	2023-07-13 11:13:13.898146+06
2150	4874	1	1	t	2023-07-13 11:13:13.898146+06
2151	4875	1	1	t	2023-07-13 11:13:13.898146+06
2152	4876	1	1	t	2023-07-13 11:13:13.898146+06
2153	4877	1	1	t	2023-07-13 11:13:13.898146+06
2154	4878	1	1	t	2023-07-13 11:13:13.898146+06
2155	4879	1	1	t	2023-07-13 11:13:13.898146+06
2156	4880	1	1	t	2023-07-13 11:13:13.898146+06
2157	4881	1	1	t	2023-07-13 11:13:13.898146+06
2158	4882	1	1	t	2023-07-13 11:13:13.898146+06
2159	4883	1	1	t	2023-07-13 11:13:13.898146+06
2160	4884	1	1	t	2023-07-13 11:13:13.898146+06
2161	4885	1	1	t	2023-07-13 11:13:13.898146+06
2163	8143	1	3	t	2023-07-13 11:13:13.898146+06
2164	8144	1	3	t	2023-07-13 11:13:13.898146+06
2165	8145	1	3	t	2023-07-13 11:13:13.898146+06
2166	8146	1	3	t	2023-07-13 11:13:13.898146+06
2167	8147	1	3	t	2023-07-13 11:13:13.898146+06
2168	8148	1	3	t	2023-07-13 11:13:13.898146+06
2169	8149	1	3	t	2023-07-13 11:13:13.898146+06
2170	8150	1	3	t	2023-07-13 11:13:13.898146+06
2171	8151	1	3	t	2023-07-13 11:13:13.898146+06
2172	8152	1	3	t	2023-07-13 11:13:13.898146+06
2173	8153	1	3	t	2023-07-13 11:13:13.898146+06
2174	8154	1	3	t	2023-07-13 11:13:13.898146+06
2175	8155	1	3	t	2023-07-13 11:13:13.898146+06
2176	8156	1	3	t	2023-07-13 11:13:13.898146+06
2177	8157	1	3	t	2023-07-13 11:13:13.898146+06
2178	8158	1	3	t	2023-07-13 11:13:13.898146+06
2179	8159	1	3	t	2023-07-13 11:13:13.898146+06
2180	8160	1	3	t	2023-07-13 11:13:13.898146+06
2181	8161	1	3	t	2023-07-13 11:13:13.898146+06
2182	8162	1	3	t	2023-07-13 11:13:13.898146+06
2183	8163	1	3	t	2023-07-13 11:13:13.898146+06
2184	8164	1	3	t	2023-07-13 11:13:13.898146+06
2185	8165	1	3	t	2023-07-13 11:13:13.898146+06
2186	8166	1	3	t	2023-07-13 11:13:13.898146+06
2187	8167	1	3	t	2023-07-13 11:13:13.898146+06
2188	8168	1	3	t	2023-07-13 11:13:13.898146+06
2189	8169	1	3	t	2023-07-13 11:13:13.898146+06
2190	8170	1	3	t	2023-07-13 11:13:13.898146+06
2191	8171	1	3	t	2023-07-13 11:13:13.898146+06
2192	8172	1	3	t	2023-07-13 11:13:13.898146+06
2193	8173	1	3	t	2023-07-13 11:13:13.898146+06
2194	8174	1	3	t	2023-07-13 11:13:13.898146+06
2195	8175	1	3	t	2023-07-13 11:13:13.898146+06
2196	8176	1	3	t	2023-07-13 11:13:13.898146+06
2197	8177	1	3	t	2023-07-13 11:13:13.898146+06
2198	8178	1	3	t	2023-07-13 11:13:13.898146+06
2199	8179	1	3	t	2023-07-13 11:13:13.898146+06
2200	8180	1	3	t	2023-07-13 11:13:13.898146+06
2201	8181	1	3	t	2023-07-13 11:13:13.898146+06
2202	8182	1	3	t	2023-07-13 11:13:13.898146+06
2203	8183	1	3	t	2023-07-13 11:13:13.898146+06
2204	8184	1	3	t	2023-07-13 11:13:13.898146+06
2205	8185	1	3	t	2023-07-13 11:13:13.898146+06
2206	8186	1	3	t	2023-07-13 11:13:13.898146+06
2207	8187	1	3	t	2023-07-13 11:13:13.898146+06
2208	8188	1	3	t	2023-07-13 11:13:13.898146+06
2209	8189	1	3	t	2023-07-13 11:13:13.898146+06
2210	8190	1	3	t	2023-07-13 11:13:13.898146+06
2211	8191	1	3	t	2023-07-13 11:13:13.898146+06
2212	8192	1	3	t	2023-07-13 11:13:13.898146+06
2213	8193	1	3	t	2023-07-13 11:13:13.898146+06
2214	8194	1	3	t	2023-07-13 11:13:13.898146+06
2215	8195	1	3	t	2023-07-13 11:13:13.898146+06
2216	8196	1	3	t	2023-07-13 11:13:13.898146+06
2217	8197	1	3	t	2023-07-13 11:13:13.898146+06
2218	8198	1	3	t	2023-07-13 11:13:13.898146+06
2219	8199	1	3	t	2023-07-13 11:13:13.898146+06
2220	8200	1	3	t	2023-07-13 11:13:13.898146+06
2221	8201	1	3	t	2023-07-13 11:13:13.898146+06
2222	8202	1	3	t	2023-07-13 11:13:13.898146+06
2223	8203	1	3	t	2023-07-13 11:13:13.898146+06
2224	8204	1	3	t	2023-07-13 11:13:13.898146+06
2225	8205	1	3	t	2023-07-13 11:13:13.898146+06
2226	8206	1	3	t	2023-07-13 11:13:13.898146+06
2227	8207	1	3	t	2023-07-13 11:13:13.898146+06
2228	8208	1	3	t	2023-07-13 11:13:13.898146+06
2229	8209	1	3	t	2023-07-13 11:13:13.898146+06
2230	8210	1	3	t	2023-07-13 11:13:13.898146+06
2231	8211	1	3	t	2023-07-13 11:13:13.898146+06
2232	8212	1	3	t	2023-07-13 11:13:13.898146+06
2233	8213	1	3	t	2023-07-13 11:13:13.898146+06
2234	8214	1	3	t	2023-07-13 11:13:13.898146+06
2235	8215	1	3	t	2023-07-13 11:13:13.898146+06
2236	8216	1	3	t	2023-07-13 11:13:13.898146+06
2237	8217	1	3	t	2023-07-13 11:13:13.898146+06
2238	8218	1	3	t	2023-07-13 11:13:13.898146+06
2239	8219	1	3	t	2023-07-13 11:13:13.898146+06
2240	8220	1	3	t	2023-07-13 11:13:13.898146+06
2241	8221	1	3	t	2023-07-13 11:13:13.898146+06
2242	8222	1	3	t	2023-07-13 11:13:13.898146+06
2243	8223	1	3	t	2023-07-13 11:13:13.898146+06
2244	8224	1	3	t	2023-07-13 11:13:13.898146+06
2245	8225	1	3	t	2023-07-13 11:13:13.898146+06
2246	8226	1	3	t	2023-07-13 11:13:13.898146+06
2247	8227	1	3	t	2023-07-13 11:13:13.898146+06
2248	8228	1	3	t	2023-07-13 11:13:13.898146+06
2249	8229	1	3	t	2023-07-13 11:13:13.898146+06
2250	8230	1	3	t	2023-07-13 11:13:13.898146+06
2251	8231	1	3	t	2023-07-13 11:13:13.898146+06
2252	8232	1	3	t	2023-07-13 11:13:13.898146+06
2253	8233	1	3	t	2023-07-13 11:13:13.898146+06
2254	8234	1	3	t	2023-07-13 11:13:13.898146+06
2255	8235	1	3	t	2023-07-13 11:13:13.898146+06
2256	8236	1	3	t	2023-07-13 11:13:13.898146+06
2257	8237	1	3	t	2023-07-13 11:13:13.898146+06
2258	8238	1	3	t	2023-07-13 11:13:13.898146+06
2259	8239	1	3	t	2023-07-13 11:13:13.898146+06
2260	8240	1	3	t	2023-07-13 11:13:13.898146+06
2261	8241	1	3	t	2023-07-13 11:13:13.898146+06
2262	8242	1	3	t	2023-07-13 11:13:13.898146+06
2263	8243	1	3	t	2023-07-13 11:13:13.898146+06
2264	8244	1	3	t	2023-07-13 11:13:13.898146+06
2265	8245	1	3	t	2023-07-13 11:13:13.898146+06
2266	8246	1	3	t	2023-07-13 11:13:13.898146+06
2267	8247	1	3	t	2023-07-13 11:13:13.898146+06
2268	8248	1	3	t	2023-07-13 11:13:13.898146+06
2269	8249	1	3	t	2023-07-13 11:13:13.898146+06
2270	8250	1	3	t	2023-07-13 11:13:13.898146+06
2271	8251	1	3	t	2023-07-13 11:13:13.898146+06
2272	8252	1	3	t	2023-07-13 11:13:13.898146+06
2273	8253	1	3	t	2023-07-13 11:13:13.898146+06
2274	8254	1	3	t	2023-07-13 11:13:13.898146+06
2275	8255	1	3	t	2023-07-13 11:13:13.898146+06
2276	8256	1	3	t	2023-07-13 11:13:13.898146+06
2277	8257	1	3	t	2023-07-13 11:13:13.898146+06
2278	8258	1	3	t	2023-07-13 11:13:13.898146+06
2279	8259	1	3	t	2023-07-13 11:13:13.898146+06
2280	8260	1	3	t	2023-07-13 11:13:13.898146+06
2281	8261	1	3	t	2023-07-13 11:13:13.898146+06
2282	8262	1	3	t	2023-07-13 11:13:13.898146+06
2283	8263	1	3	t	2023-07-13 11:13:13.898146+06
2284	8264	1	3	t	2023-07-13 11:13:13.898146+06
2285	8265	1	3	t	2023-07-13 11:13:13.898146+06
2286	8266	1	3	t	2023-07-13 11:13:13.898146+06
2287	8267	1	3	t	2023-07-13 11:13:13.898146+06
2288	8268	1	3	t	2023-07-13 11:13:13.898146+06
2289	8269	1	3	t	2023-07-13 11:13:13.898146+06
2290	8270	1	3	t	2023-07-13 11:13:13.898146+06
2291	8271	1	3	t	2023-07-13 11:13:13.898146+06
2292	8272	1	3	t	2023-07-13 11:13:13.898146+06
2293	8273	1	3	t	2023-07-13 11:13:13.898146+06
2294	8274	1	3	t	2023-07-13 11:13:13.898146+06
2295	8275	1	3	t	2023-07-13 11:13:13.898146+06
2296	8276	1	3	t	2023-07-13 11:13:13.898146+06
2297	8277	1	3	t	2023-07-13 11:13:13.898146+06
2298	8278	1	3	t	2023-07-13 11:13:13.898146+06
2299	8279	1	3	t	2023-07-13 11:13:13.898146+06
2300	8280	1	3	t	2023-07-13 11:13:13.898146+06
2301	8281	1	3	t	2023-07-13 11:13:13.898146+06
2302	8282	1	3	t	2023-07-13 11:13:13.898146+06
2303	8283	1	3	t	2023-07-13 11:13:13.898146+06
2304	8284	1	3	t	2023-07-13 11:13:13.898146+06
2305	8285	1	3	t	2023-07-13 11:13:13.898146+06
2306	8286	1	3	t	2023-07-13 11:13:13.898146+06
2307	8287	1	3	t	2023-07-13 11:13:13.898146+06
2308	8288	1	3	t	2023-07-13 11:13:13.898146+06
2309	8289	1	3	t	2023-07-13 11:13:13.898146+06
2310	8290	1	3	t	2023-07-13 11:13:13.898146+06
2311	8291	1	3	t	2023-07-13 11:13:13.898146+06
2312	8292	1	3	t	2023-07-13 11:13:13.898146+06
2313	8293	1	3	t	2023-07-13 11:13:13.898146+06
2314	8294	1	3	t	2023-07-13 11:13:13.898146+06
2315	8295	1	3	t	2023-07-13 11:13:13.898146+06
2316	8296	1	3	t	2023-07-13 11:13:13.898146+06
2317	8297	1	3	t	2023-07-13 11:13:13.898146+06
2318	8298	1	3	t	2023-07-13 11:13:13.898146+06
2319	8299	1	3	t	2023-07-13 11:13:13.898146+06
2320	8300	1	3	t	2023-07-13 11:13:13.898146+06
2321	8301	1	3	t	2023-07-13 11:13:13.898146+06
2322	8302	1	3	t	2023-07-13 11:13:13.898146+06
2323	8303	1	3	t	2023-07-13 11:13:13.898146+06
2324	8304	1	3	t	2023-07-13 11:13:13.898146+06
2325	8305	1	3	t	2023-07-13 11:13:13.898146+06
2326	8306	1	3	t	2023-07-13 11:13:13.898146+06
2327	8307	1	3	t	2023-07-13 11:13:13.898146+06
2328	8308	1	3	t	2023-07-13 11:13:13.898146+06
2329	8309	1	3	t	2023-07-13 11:13:13.898146+06
2330	8310	1	3	t	2023-07-13 11:13:13.898146+06
2331	8311	1	3	t	2023-07-13 11:13:13.898146+06
2332	8312	1	3	t	2023-07-13 11:13:13.898146+06
2333	8313	1	3	t	2023-07-13 11:13:13.898146+06
2334	8314	1	3	t	2023-07-13 11:13:13.898146+06
2335	8315	1	3	t	2023-07-13 11:13:13.898146+06
2336	8316	1	3	t	2023-07-13 11:13:13.898146+06
2337	8317	1	3	t	2023-07-13 11:13:13.898146+06
2338	8318	1	3	t	2023-07-13 11:13:13.898146+06
2339	8319	1	3	t	2023-07-13 11:13:13.898146+06
2340	8320	1	3	t	2023-07-13 11:13:13.898146+06
2341	8321	1	3	t	2023-07-13 11:13:13.898146+06
2342	8322	1	3	t	2023-07-13 11:13:13.898146+06
2343	8323	1	3	t	2023-07-13 11:13:13.898146+06
2344	8324	1	3	t	2023-07-13 11:13:13.898146+06
2345	8325	1	3	t	2023-07-13 11:13:13.898146+06
2346	8326	1	3	t	2023-07-13 11:13:13.898146+06
2347	8327	1	3	t	2023-07-13 11:13:13.898146+06
2348	8328	1	3	t	2023-07-13 11:13:13.898146+06
2349	8329	1	3	t	2023-07-13 11:13:13.898146+06
2350	8330	1	3	t	2023-07-13 11:13:13.898146+06
2351	8331	1	3	t	2023-07-13 11:13:13.898146+06
2352	8332	1	3	t	2023-07-13 11:13:13.898146+06
2353	8333	1	3	t	2023-07-13 11:13:13.898146+06
2354	8334	1	3	t	2023-07-13 11:13:13.898146+06
2355	8335	1	3	t	2023-07-13 11:13:13.898146+06
2356	8336	1	3	t	2023-07-13 11:13:13.898146+06
2357	8337	1	3	t	2023-07-13 11:13:13.898146+06
2358	8338	1	3	t	2023-07-13 11:13:13.898146+06
2359	8339	1	3	t	2023-07-13 11:13:13.898146+06
2360	8340	1	3	t	2023-07-13 11:13:13.898146+06
2361	8341	1	3	t	2023-07-13 11:13:13.898146+06
2362	8342	1	3	t	2023-07-13 11:13:13.898146+06
2363	8343	1	3	t	2023-07-13 11:13:13.898146+06
2364	8344	1	3	t	2023-07-13 11:13:13.898146+06
2365	8345	1	3	t	2023-07-13 11:13:13.898146+06
2366	8346	1	3	t	2023-07-13 11:13:13.898146+06
2367	8347	1	3	t	2023-07-13 11:13:13.898146+06
2368	8348	1	3	t	2023-07-13 11:13:13.898146+06
2369	8349	1	3	t	2023-07-13 11:13:13.898146+06
2370	8350	1	3	t	2023-07-13 11:13:13.898146+06
2371	8351	1	3	t	2023-07-13 11:13:13.898146+06
2372	8352	1	3	t	2023-07-13 11:13:13.898146+06
2373	8353	1	3	t	2023-07-13 11:13:13.898146+06
2374	8354	1	3	t	2023-07-13 11:13:13.898146+06
2375	8355	1	3	t	2023-07-13 11:13:13.898146+06
2376	8356	1	3	t	2023-07-13 11:13:13.898146+06
2377	8357	1	3	t	2023-07-13 11:13:13.898146+06
2378	8358	1	3	t	2023-07-13 11:13:13.898146+06
2379	8359	1	3	t	2023-07-13 11:13:13.898146+06
2380	8360	1	3	t	2023-07-13 11:13:13.898146+06
2381	8361	1	3	t	2023-07-13 11:13:13.898146+06
2382	8362	1	3	t	2023-07-13 11:13:13.898146+06
2383	8363	1	3	t	2023-07-13 11:13:13.898146+06
2384	8364	1	3	t	2023-07-13 11:13:13.898146+06
2385	8365	1	3	t	2023-07-13 11:13:13.898146+06
2386	8366	1	3	t	2023-07-13 11:13:13.898146+06
2387	8367	1	3	t	2023-07-13 11:13:13.898146+06
2388	8368	1	3	t	2023-07-13 11:13:13.898146+06
2389	8369	1	3	t	2023-07-13 11:13:13.898146+06
2390	8370	1	3	t	2023-07-13 11:13:13.898146+06
2391	8371	1	3	t	2023-07-13 11:13:13.898146+06
2392	8372	1	3	t	2023-07-13 11:13:13.898146+06
2393	8373	1	3	t	2023-07-13 11:13:13.898146+06
2394	8374	1	3	t	2023-07-13 11:13:13.898146+06
2395	8375	1	3	t	2023-07-13 11:13:13.898146+06
2396	8376	1	3	t	2023-07-13 11:13:13.898146+06
2397	8377	1	3	t	2023-07-13 11:13:13.898146+06
2398	8378	1	3	t	2023-07-13 11:13:13.898146+06
2399	8379	1	3	t	2023-07-13 11:13:13.898146+06
2400	8380	1	3	t	2023-07-13 11:13:13.898146+06
2401	8381	1	3	t	2023-07-13 11:13:13.898146+06
2402	8382	1	3	t	2023-07-13 11:13:13.898146+06
2403	8383	1	3	t	2023-07-13 11:13:13.898146+06
2404	8384	1	3	t	2023-07-13 11:13:13.898146+06
2405	8385	1	3	t	2023-07-13 11:13:13.898146+06
2406	8386	1	3	t	2023-07-13 11:13:13.898146+06
2407	8387	1	3	t	2023-07-13 11:13:13.898146+06
2408	8388	1	3	t	2023-07-13 11:13:13.898146+06
2409	8389	1	3	t	2023-07-13 11:13:13.898146+06
2410	8390	1	3	t	2023-07-13 11:13:13.898146+06
2411	8391	1	3	t	2023-07-13 11:13:13.898146+06
2412	8392	1	3	t	2023-07-13 11:13:13.898146+06
2413	8393	1	3	t	2023-07-13 11:13:13.898146+06
2414	8394	1	3	t	2023-07-13 11:13:13.898146+06
2415	8395	1	3	t	2023-07-13 11:13:13.898146+06
2416	8396	1	3	t	2023-07-13 11:13:13.898146+06
2417	8397	1	3	t	2023-07-13 11:13:13.898146+06
2418	8398	1	3	t	2023-07-13 11:13:13.898146+06
2419	8399	1	3	t	2023-07-13 11:13:13.898146+06
2420	8400	1	3	t	2023-07-13 11:13:13.898146+06
2421	8401	1	3	t	2023-07-13 11:13:13.898146+06
2422	8402	1	3	t	2023-07-13 11:13:13.898146+06
2423	8403	1	3	t	2023-07-13 11:13:13.898146+06
2424	8404	1	3	t	2023-07-13 11:13:13.898146+06
2425	8405	1	3	t	2023-07-13 11:13:13.898146+06
2426	8406	1	3	t	2023-07-13 11:13:13.898146+06
2427	8407	1	3	t	2023-07-13 11:13:13.898146+06
2428	8408	1	3	t	2023-07-13 11:13:13.898146+06
2429	8409	1	3	t	2023-07-13 11:13:13.898146+06
2430	8410	1	3	t	2023-07-13 11:13:13.898146+06
2431	8411	1	3	t	2023-07-13 11:13:13.898146+06
2432	8412	1	3	t	2023-07-13 11:13:13.898146+06
2433	8413	1	3	t	2023-07-13 11:13:13.898146+06
2434	8414	1	3	t	2023-07-13 11:13:13.898146+06
2435	8415	1	3	t	2023-07-13 11:13:13.898146+06
2436	8416	1	3	t	2023-07-13 11:13:13.898146+06
2437	8417	1	3	t	2023-07-13 11:13:13.898146+06
2438	8418	1	3	t	2023-07-13 11:13:13.898146+06
2439	8419	1	3	t	2023-07-13 11:13:13.898146+06
2440	8420	1	3	t	2023-07-13 11:13:13.898146+06
2441	8421	1	3	t	2023-07-13 11:13:13.898146+06
2442	8422	1	3	t	2023-07-13 11:13:13.898146+06
2443	8423	1	3	t	2023-07-13 11:13:13.898146+06
2444	8424	1	3	t	2023-07-13 11:13:13.898146+06
2445	8425	1	3	t	2023-07-13 11:13:13.898146+06
2446	8426	1	3	t	2023-07-13 11:13:13.898146+06
2447	8427	1	3	t	2023-07-13 11:13:13.898146+06
2448	8428	1	3	t	2023-07-13 11:13:13.898146+06
2449	8429	1	3	t	2023-07-13 11:13:13.898146+06
2450	8430	1	3	t	2023-07-13 11:13:13.898146+06
2451	8431	1	3	t	2023-07-13 11:13:13.898146+06
2452	8432	1	3	t	2023-07-13 11:13:13.898146+06
2453	8433	1	3	t	2023-07-13 11:13:13.898146+06
2454	8434	1	3	t	2023-07-13 11:13:13.898146+06
2455	8435	1	3	t	2023-07-13 11:13:13.898146+06
2456	8436	1	3	t	2023-07-13 11:13:13.898146+06
2457	8437	1	3	t	2023-07-13 11:13:13.898146+06
2458	8438	1	3	t	2023-07-13 11:13:13.898146+06
2459	8439	1	3	t	2023-07-13 11:13:13.898146+06
2460	8440	1	3	t	2023-07-13 11:13:13.898146+06
2461	8441	1	3	t	2023-07-13 11:13:13.898146+06
2462	8442	1	3	t	2023-07-13 11:13:13.898146+06
2463	8443	1	3	t	2023-07-13 11:13:13.898146+06
2464	8444	1	3	t	2023-07-13 11:13:13.898146+06
2465	8445	1	3	t	2023-07-13 11:13:13.898146+06
2466	8446	1	3	t	2023-07-13 11:13:13.898146+06
2467	8447	1	3	t	2023-07-13 11:13:13.898146+06
2468	8448	1	3	t	2023-07-13 11:13:13.898146+06
2469	8449	1	3	t	2023-07-13 11:13:13.898146+06
2470	8450	1	3	t	2023-07-13 11:13:13.898146+06
2471	8451	1	3	t	2023-07-13 11:13:13.898146+06
2472	8452	1	3	t	2023-07-13 11:13:13.898146+06
2473	8453	1	3	t	2023-07-13 11:13:13.898146+06
2474	8454	1	3	t	2023-07-13 11:13:13.898146+06
2475	8455	1	3	t	2023-07-13 11:13:13.898146+06
2476	8456	1	3	t	2023-07-13 11:13:13.898146+06
2477	8457	1	3	t	2023-07-13 11:13:13.898146+06
2478	8458	1	3	t	2023-07-13 11:13:13.898146+06
2479	8459	1	3	t	2023-07-13 11:13:13.898146+06
2480	8460	1	3	t	2023-07-13 11:13:13.898146+06
2481	8461	1	3	t	2023-07-13 11:13:13.898146+06
2482	8462	1	3	t	2023-07-13 11:13:13.898146+06
2483	8463	1	3	t	2023-07-13 11:13:13.898146+06
2484	8464	1	3	t	2023-07-13 11:13:13.898146+06
2485	8465	1	3	t	2023-07-13 11:13:13.898146+06
2486	8466	1	3	t	2023-07-13 11:13:13.898146+06
2487	8467	1	3	t	2023-07-13 11:13:13.898146+06
2488	8468	1	3	t	2023-07-13 11:13:13.898146+06
2489	8469	1	3	t	2023-07-13 11:13:13.898146+06
2490	8470	1	3	t	2023-07-13 11:13:13.898146+06
2491	8471	1	3	t	2023-07-13 11:13:13.898146+06
2492	8472	1	3	t	2023-07-13 11:13:13.898146+06
2493	8473	1	3	t	2023-07-13 11:13:13.898146+06
2494	8474	1	3	t	2023-07-13 11:13:13.898146+06
2495	8475	1	3	t	2023-07-13 11:13:13.898146+06
2496	8476	1	3	t	2023-07-13 11:13:13.898146+06
2497	8477	1	3	t	2023-07-13 11:13:13.898146+06
2498	8478	1	3	t	2023-07-13 11:13:13.898146+06
2499	8479	1	3	t	2023-07-13 11:13:13.898146+06
2500	8480	1	3	t	2023-07-13 11:13:13.898146+06
2501	8481	1	3	t	2023-07-13 11:13:13.898146+06
2502	8482	1	3	t	2023-07-13 11:13:13.898146+06
2503	8483	1	3	t	2023-07-13 11:13:13.898146+06
2504	8484	1	3	t	2023-07-13 11:13:13.898146+06
2505	8485	1	3	t	2023-07-13 11:13:13.898146+06
2506	8486	1	3	t	2023-07-13 11:13:13.898146+06
2507	8487	1	3	t	2023-07-13 11:13:13.898146+06
2508	8488	1	3	t	2023-07-13 11:13:13.898146+06
2509	8489	1	3	t	2023-07-13 11:13:13.898146+06
2510	8490	1	3	t	2023-07-13 11:13:13.898146+06
2511	8491	1	3	t	2023-07-13 11:13:13.898146+06
2512	8492	1	3	t	2023-07-13 11:13:13.898146+06
2513	8493	1	3	t	2023-07-13 11:13:13.898146+06
2514	8494	1	3	t	2023-07-13 11:13:13.898146+06
2515	8495	1	3	t	2023-07-13 11:13:13.898146+06
2516	8496	1	3	t	2023-07-13 11:13:13.898146+06
2517	8497	1	3	t	2023-07-13 11:13:13.898146+06
2518	8498	1	3	t	2023-07-13 11:13:13.898146+06
2519	8499	1	3	t	2023-07-13 11:13:13.898146+06
2520	8500	1	3	t	2023-07-13 11:13:13.898146+06
2521	8501	1	3	t	2023-07-13 11:13:13.898146+06
2522	8502	1	3	t	2023-07-13 11:13:13.898146+06
2523	8503	1	3	t	2023-07-13 11:13:13.898146+06
2524	8504	1	3	t	2023-07-13 11:13:13.898146+06
2525	8505	1	3	t	2023-07-13 11:13:13.898146+06
2526	8506	1	3	t	2023-07-13 11:13:13.898146+06
2527	8507	1	3	t	2023-07-13 11:13:13.898146+06
2528	8508	1	3	t	2023-07-13 11:13:13.898146+06
2529	8509	1	3	t	2023-07-13 11:13:13.898146+06
2530	8510	1	3	t	2023-07-13 11:13:13.898146+06
2531	8511	1	3	t	2023-07-13 11:13:13.898146+06
2532	8512	1	3	t	2023-07-13 11:13:13.898146+06
2533	8513	1	3	t	2023-07-13 11:13:13.898146+06
2534	8514	1	3	t	2023-07-13 11:13:13.898146+06
2535	8515	1	3	t	2023-07-13 11:13:13.898146+06
2536	8516	1	3	t	2023-07-13 11:13:13.898146+06
2537	8517	1	3	t	2023-07-13 11:13:13.898146+06
2538	8518	1	3	t	2023-07-13 11:13:13.898146+06
2539	8519	1	3	t	2023-07-13 11:13:13.898146+06
2540	8520	1	3	t	2023-07-13 11:13:13.898146+06
2541	8521	1	3	t	2023-07-13 11:13:13.898146+06
2542	8522	1	3	t	2023-07-13 11:13:13.898146+06
2543	8523	1	3	t	2023-07-13 11:13:13.898146+06
2544	8524	1	3	t	2023-07-13 11:13:13.898146+06
2545	8525	1	3	t	2023-07-13 11:13:13.898146+06
2546	8526	1	3	t	2023-07-13 11:13:13.898146+06
2547	8527	1	3	t	2023-07-13 11:13:13.898146+06
2548	8528	1	3	t	2023-07-13 11:13:13.898146+06
2549	8529	1	3	t	2023-07-13 11:13:13.898146+06
2550	8530	1	3	t	2023-07-13 11:13:13.898146+06
2551	8531	1	3	t	2023-07-13 11:13:13.898146+06
2552	8532	1	3	t	2023-07-13 11:13:13.898146+06
2553	8533	1	3	t	2023-07-13 11:13:13.898146+06
2554	8534	1	3	t	2023-07-13 11:13:13.898146+06
2555	8535	1	3	t	2023-07-13 11:13:13.898146+06
2556	8536	1	3	t	2023-07-13 11:13:13.898146+06
2557	8537	1	3	t	2023-07-13 11:13:13.898146+06
2558	8538	1	3	t	2023-07-13 11:13:13.898146+06
2559	8539	1	3	t	2023-07-13 11:13:13.898146+06
2560	8540	1	3	t	2023-07-13 11:13:13.898146+06
2561	8541	1	3	t	2023-07-13 11:13:13.898146+06
2562	8542	1	3	t	2023-07-13 11:13:13.898146+06
2563	8543	1	3	t	2023-07-13 11:13:13.898146+06
2564	8544	1	3	t	2023-07-13 11:13:13.898146+06
2565	8545	1	3	t	2023-07-13 11:13:13.898146+06
2566	8546	1	3	t	2023-07-13 11:13:13.898146+06
2567	8547	1	3	t	2023-07-13 11:13:13.898146+06
2568	8548	1	3	t	2023-07-13 11:13:13.898146+06
2569	8549	1	3	t	2023-07-13 11:13:13.898146+06
2570	8550	1	3	t	2023-07-13 11:13:13.898146+06
2571	8551	1	3	t	2023-07-13 11:13:13.898146+06
2572	8552	1	3	t	2023-07-13 11:13:13.898146+06
2573	8553	1	3	t	2023-07-13 11:13:13.898146+06
2574	8554	1	3	t	2023-07-13 11:13:13.898146+06
2575	8555	1	3	t	2023-07-13 11:13:13.898146+06
2576	8556	1	3	t	2023-07-13 11:13:13.898146+06
2577	8557	1	3	t	2023-07-13 11:13:13.898146+06
2578	8558	1	3	t	2023-07-13 11:13:13.898146+06
2579	8559	1	3	t	2023-07-13 11:13:13.898146+06
2580	8560	1	3	t	2023-07-13 11:13:13.898146+06
2581	8561	1	3	t	2023-07-13 11:13:13.898146+06
2582	8562	1	3	t	2023-07-13 11:13:13.898146+06
2583	8563	1	3	t	2023-07-13 11:13:13.898146+06
2584	8564	1	3	t	2023-07-13 11:13:13.898146+06
2585	8565	1	3	t	2023-07-13 11:13:13.898146+06
2586	8566	1	3	t	2023-07-13 11:13:13.898146+06
2587	8567	1	3	t	2023-07-13 11:13:13.898146+06
2588	8568	1	3	t	2023-07-13 11:13:13.898146+06
2589	8569	1	3	t	2023-07-13 11:13:13.898146+06
2590	8570	1	3	t	2023-07-13 11:13:13.898146+06
2591	8571	1	3	t	2023-07-13 11:13:13.898146+06
2592	8572	1	3	t	2023-07-13 11:13:13.898146+06
2593	8573	1	3	t	2023-07-13 11:13:13.898146+06
2594	8574	1	3	t	2023-07-13 11:13:13.898146+06
2595	8575	1	3	t	2023-07-13 11:13:13.898146+06
2596	8576	1	3	t	2023-07-13 11:13:13.898146+06
2597	8577	1	3	t	2023-07-13 11:13:13.898146+06
2598	8578	1	3	t	2023-07-13 11:13:13.898146+06
2599	8579	1	3	t	2023-07-13 11:13:13.898146+06
2600	8580	1	3	t	2023-07-13 11:13:13.898146+06
2601	8581	1	3	t	2023-07-13 11:13:13.898146+06
2602	8582	1	3	t	2023-07-13 11:13:13.898146+06
2603	8583	1	3	t	2023-07-13 11:13:13.898146+06
2604	8584	1	3	t	2023-07-13 11:13:13.898146+06
2605	8585	1	3	t	2023-07-13 11:13:13.898146+06
2606	8586	1	3	t	2023-07-13 11:13:13.898146+06
2607	8587	1	3	t	2023-07-13 11:13:13.898146+06
2608	8588	1	3	t	2023-07-13 11:13:13.898146+06
2609	8589	1	3	t	2023-07-13 11:13:13.898146+06
2610	8590	1	3	t	2023-07-13 11:13:13.898146+06
2611	8591	1	3	t	2023-07-13 11:13:13.898146+06
2612	8592	1	3	t	2023-07-13 11:13:13.898146+06
2613	8593	1	3	t	2023-07-13 11:13:13.898146+06
2614	8594	1	3	t	2023-07-13 11:13:13.898146+06
2615	8595	1	3	t	2023-07-13 11:13:13.898146+06
2616	8596	1	3	t	2023-07-13 11:13:13.898146+06
2617	8597	1	3	t	2023-07-13 11:13:13.898146+06
2618	8598	1	3	t	2023-07-13 11:13:13.898146+06
2619	8599	1	3	t	2023-07-13 11:13:13.898146+06
2620	8600	1	3	t	2023-07-13 11:13:13.898146+06
2621	8601	1	3	t	2023-07-13 11:13:13.898146+06
2622	8602	1	3	t	2023-07-13 11:13:13.898146+06
2623	8603	1	3	t	2023-07-13 11:13:13.898146+06
2624	8604	1	3	t	2023-07-13 11:13:13.898146+06
2625	8605	1	3	t	2023-07-13 11:13:13.898146+06
2626	8606	1	3	t	2023-07-13 11:13:13.898146+06
2627	8607	1	3	t	2023-07-13 11:13:13.898146+06
2628	8608	1	3	t	2023-07-13 11:13:13.898146+06
2629	8609	1	3	t	2023-07-13 11:13:13.898146+06
2630	8610	1	3	t	2023-07-13 11:13:13.898146+06
2631	8611	1	3	t	2023-07-13 11:13:13.898146+06
2632	8612	1	3	t	2023-07-13 11:13:13.898146+06
2633	8613	1	3	t	2023-07-13 11:13:13.898146+06
2634	8614	1	3	t	2023-07-13 11:13:13.898146+06
2635	8615	1	3	t	2023-07-13 11:13:13.898146+06
2636	8616	1	3	t	2023-07-13 11:13:13.898146+06
2637	8617	1	3	t	2023-07-13 11:13:13.898146+06
2638	8618	1	3	t	2023-07-13 11:13:13.898146+06
2639	8619	1	3	t	2023-07-13 11:13:13.898146+06
2640	8620	1	3	t	2023-07-13 11:13:13.898146+06
2641	8621	1	3	t	2023-07-13 11:13:13.898146+06
2642	8622	1	3	t	2023-07-13 11:13:13.898146+06
2643	8623	1	3	t	2023-07-13 11:13:13.898146+06
2644	8624	1	3	t	2023-07-13 11:13:13.898146+06
2645	8625	1	3	t	2023-07-13 11:13:13.898146+06
2646	8626	1	3	t	2023-07-13 11:13:13.898146+06
2647	8627	1	3	t	2023-07-13 11:13:13.898146+06
2648	8628	1	3	t	2023-07-13 11:13:13.898146+06
2649	8629	1	3	t	2023-07-13 11:13:13.898146+06
2650	8630	1	3	t	2023-07-13 11:13:13.898146+06
2651	8631	1	3	t	2023-07-13 11:13:13.898146+06
2652	8632	1	3	t	2023-07-13 11:13:13.898146+06
2653	8633	1	3	t	2023-07-13 11:13:13.898146+06
2654	8634	1	3	t	2023-07-13 11:13:13.898146+06
2655	8635	1	3	t	2023-07-13 11:13:13.898146+06
2656	8636	1	3	t	2023-07-13 11:13:13.898146+06
2657	8637	1	3	t	2023-07-13 11:13:13.898146+06
2658	8638	1	3	t	2023-07-13 11:13:13.898146+06
2659	8639	1	3	t	2023-07-13 11:13:13.898146+06
2660	8640	1	3	t	2023-07-13 11:13:13.898146+06
2661	8641	1	3	t	2023-07-13 11:13:13.898146+06
2662	8642	1	3	t	2023-07-13 11:13:13.898146+06
2663	8643	1	3	t	2023-07-13 11:13:13.898146+06
2664	8644	1	3	t	2023-07-13 11:13:13.898146+06
2665	8645	1	3	t	2023-07-13 11:13:13.898146+06
2666	8646	1	3	t	2023-07-13 11:13:13.898146+06
2667	8647	1	3	t	2023-07-13 11:13:13.898146+06
2668	8648	1	3	t	2023-07-13 11:13:13.898146+06
2669	8649	1	3	t	2023-07-13 11:13:13.898146+06
2670	8650	1	3	t	2023-07-13 11:13:13.898146+06
2671	8651	1	3	t	2023-07-13 11:13:13.898146+06
2672	8652	1	3	t	2023-07-13 11:13:13.898146+06
2673	8653	1	3	t	2023-07-13 11:13:13.898146+06
2674	8654	1	3	t	2023-07-13 11:13:13.898146+06
2675	8655	1	3	t	2023-07-13 11:13:13.898146+06
2676	8656	1	3	t	2023-07-13 11:13:13.898146+06
2677	8657	1	3	t	2023-07-13 11:13:13.898146+06
2678	8658	1	3	t	2023-07-13 11:13:13.898146+06
2679	8659	1	3	t	2023-07-13 11:13:13.898146+06
2680	8660	1	3	t	2023-07-13 11:13:13.898146+06
2681	8661	1	3	t	2023-07-13 11:13:13.898146+06
2682	8662	1	3	t	2023-07-13 11:13:13.898146+06
2683	8663	1	3	t	2023-07-13 11:13:13.898146+06
2684	8664	1	3	t	2023-07-13 11:13:13.898146+06
2685	8665	1	3	t	2023-07-13 11:13:13.898146+06
2686	8666	1	3	t	2023-07-13 11:13:13.898146+06
2687	8667	1	3	t	2023-07-13 11:13:13.898146+06
2688	8668	1	3	t	2023-07-13 11:13:13.898146+06
2689	8669	1	3	t	2023-07-13 11:13:13.898146+06
2690	8670	1	3	t	2023-07-13 11:13:13.898146+06
2691	8671	1	3	t	2023-07-13 11:13:13.898146+06
2692	8672	1	3	t	2023-07-13 11:13:13.898146+06
2693	8673	1	3	t	2023-07-13 11:13:13.898146+06
2694	8674	1	3	t	2023-07-13 11:13:13.898146+06
2695	8675	1	3	t	2023-07-13 11:13:13.898146+06
2696	8676	1	3	t	2023-07-13 11:13:13.898146+06
2697	8677	1	3	t	2023-07-13 11:13:13.898146+06
2698	8678	1	3	t	2023-07-13 11:13:13.898146+06
2699	8679	1	3	t	2023-07-13 11:13:13.898146+06
2700	8680	1	3	t	2023-07-13 11:13:13.898146+06
2701	8681	1	3	t	2023-07-13 11:13:13.898146+06
2702	8682	1	3	t	2023-07-13 11:13:13.898146+06
2703	8683	1	3	t	2023-07-13 11:13:13.898146+06
2704	8684	1	3	t	2023-07-13 11:13:13.898146+06
2705	8685	1	3	t	2023-07-13 11:13:13.898146+06
2706	8686	1	3	t	2023-07-13 11:13:13.898146+06
2707	8687	1	3	t	2023-07-13 11:13:13.898146+06
2708	8688	1	3	t	2023-07-13 11:13:13.898146+06
2709	8689	1	3	t	2023-07-13 11:13:13.898146+06
2710	8690	1	3	t	2023-07-13 11:13:13.898146+06
2711	8691	1	3	t	2023-07-13 11:13:13.898146+06
2712	8692	1	3	t	2023-07-13 11:13:13.898146+06
2713	8693	1	3	t	2023-07-13 11:13:13.898146+06
2714	8694	1	3	t	2023-07-13 11:13:13.898146+06
2715	8695	1	3	t	2023-07-13 11:13:13.898146+06
2716	8696	1	3	t	2023-07-13 11:13:13.898146+06
2717	8697	1	3	t	2023-07-13 11:13:13.898146+06
2718	8698	1	3	t	2023-07-13 11:13:13.898146+06
2719	8699	1	3	t	2023-07-13 11:13:13.898146+06
2720	8700	1	3	t	2023-07-13 11:13:13.898146+06
2721	8701	1	3	t	2023-07-13 11:13:13.898146+06
2722	8702	1	3	t	2023-07-13 11:13:13.898146+06
2723	8703	1	3	t	2023-07-13 11:13:13.898146+06
2724	8704	1	3	t	2023-07-13 11:13:13.898146+06
2725	8705	1	3	t	2023-07-13 11:13:13.898146+06
2726	8706	1	3	t	2023-07-13 11:13:13.898146+06
2727	8707	1	3	t	2023-07-13 11:13:13.898146+06
2728	8708	1	3	t	2023-07-13 11:13:13.898146+06
2729	8709	1	3	t	2023-07-13 11:13:13.898146+06
2730	8710	1	3	t	2023-07-13 11:13:13.898146+06
2731	8711	1	3	t	2023-07-13 11:13:13.898146+06
2732	8712	1	3	t	2023-07-13 11:13:13.898146+06
2733	8713	1	3	t	2023-07-13 11:13:13.898146+06
2734	8714	1	3	t	2023-07-13 11:13:13.898146+06
2735	8715	1	3	t	2023-07-13 11:13:13.898146+06
2736	8716	1	3	t	2023-07-13 11:13:13.898146+06
2737	8717	1	3	t	2023-07-13 11:13:13.898146+06
2738	8718	1	3	t	2023-07-13 11:13:13.898146+06
2739	8719	1	3	t	2023-07-13 11:13:13.898146+06
2740	8720	1	3	t	2023-07-13 11:13:13.898146+06
2741	8721	1	3	t	2023-07-13 11:13:13.898146+06
2742	8722	1	3	t	2023-07-13 11:13:13.898146+06
2743	8723	1	3	t	2023-07-13 11:13:13.898146+06
2744	8724	1	3	t	2023-07-13 11:13:13.898146+06
2745	8725	1	3	t	2023-07-13 11:13:13.898146+06
2746	8726	1	3	t	2023-07-13 11:13:13.898146+06
2747	8727	1	3	t	2023-07-13 11:13:13.898146+06
2748	8728	1	3	t	2023-07-13 11:13:13.898146+06
2749	8729	1	3	t	2023-07-13 11:13:13.898146+06
2750	8730	1	3	t	2023-07-13 11:13:13.898146+06
2751	8731	1	3	t	2023-07-13 11:13:13.898146+06
2752	8732	1	3	t	2023-07-13 11:13:13.898146+06
2753	8733	1	3	t	2023-07-13 11:13:13.898146+06
2754	8734	1	3	t	2023-07-13 11:13:13.898146+06
2755	8735	1	3	t	2023-07-13 11:13:13.898146+06
2756	8736	1	3	t	2023-07-13 11:13:13.898146+06
2757	8737	1	3	t	2023-07-13 11:13:13.898146+06
2758	8738	1	3	t	2023-07-13 11:13:13.898146+06
2759	8739	1	3	t	2023-07-13 11:13:13.898146+06
2760	8740	1	3	t	2023-07-13 11:13:13.898146+06
2761	8741	1	3	t	2023-07-13 11:13:13.898146+06
2762	8742	1	3	t	2023-07-13 11:13:13.898146+06
2763	8743	1	3	t	2023-07-13 11:13:13.898146+06
2764	8744	1	3	t	2023-07-13 11:13:13.898146+06
2765	8745	1	3	t	2023-07-13 11:13:13.898146+06
2766	8746	1	3	t	2023-07-13 11:13:13.898146+06
2767	8747	1	3	t	2023-07-13 11:13:13.898146+06
2768	8748	1	3	t	2023-07-13 11:13:13.898146+06
2769	8749	1	3	t	2023-07-13 11:13:13.898146+06
2770	8750	1	3	t	2023-07-13 11:13:13.898146+06
2771	8751	1	3	t	2023-07-13 11:13:13.898146+06
2772	8752	1	3	t	2023-07-13 11:13:13.898146+06
2773	8753	1	3	t	2023-07-13 11:13:13.898146+06
2774	8754	1	3	t	2023-07-13 11:13:13.898146+06
2775	8755	1	3	t	2023-07-13 11:13:13.898146+06
2776	8756	1	3	t	2023-07-13 11:13:13.898146+06
2777	8757	1	3	t	2023-07-13 11:13:13.898146+06
2778	8758	1	3	t	2023-07-13 11:13:13.898146+06
2779	8759	1	3	t	2023-07-13 11:13:13.898146+06
2780	8760	1	3	t	2023-07-13 11:13:13.898146+06
2781	8761	1	3	t	2023-07-13 11:13:13.898146+06
2782	8762	1	3	t	2023-07-13 11:13:13.898146+06
2783	8763	1	3	t	2023-07-13 11:13:13.898146+06
2784	8764	1	3	t	2023-07-13 11:13:13.898146+06
2785	8765	1	3	t	2023-07-13 11:13:13.898146+06
2786	8766	1	3	t	2023-07-13 11:13:13.898146+06
2787	8767	1	3	t	2023-07-13 11:13:13.898146+06
2788	8768	1	3	t	2023-07-13 11:13:13.898146+06
2789	8769	1	3	t	2023-07-13 11:13:13.898146+06
2790	8770	1	3	t	2023-07-13 11:13:13.898146+06
2791	8771	1	3	t	2023-07-13 11:13:13.898146+06
2792	8772	1	3	t	2023-07-13 11:13:13.898146+06
2793	8773	1	3	t	2023-07-13 11:13:13.898146+06
2794	8774	1	3	t	2023-07-13 11:13:13.898146+06
2795	8775	1	3	t	2023-07-13 11:13:13.898146+06
2796	8776	1	3	t	2023-07-13 11:13:13.898146+06
2797	8777	1	3	t	2023-07-13 11:13:13.898146+06
2798	8778	1	3	t	2023-07-13 11:13:13.898146+06
2799	8779	1	3	t	2023-07-13 11:13:13.898146+06
2800	8780	1	3	t	2023-07-13 11:13:13.898146+06
2801	8781	1	3	t	2023-07-13 11:13:13.898146+06
2802	8782	1	3	t	2023-07-13 11:13:13.898146+06
2803	8783	1	3	t	2023-07-13 11:13:13.898146+06
2804	8784	1	3	t	2023-07-13 11:13:13.898146+06
2805	8785	1	3	t	2023-07-13 11:13:13.898146+06
2806	8786	1	3	t	2023-07-13 11:13:13.898146+06
2807	8787	1	3	t	2023-07-13 11:13:13.898146+06
2808	8788	1	3	t	2023-07-13 11:13:13.898146+06
2809	8789	1	3	t	2023-07-13 11:13:13.898146+06
2810	8790	1	3	t	2023-07-13 11:13:13.898146+06
2811	8791	1	3	t	2023-07-13 11:13:13.898146+06
2812	8792	1	3	t	2023-07-13 11:13:13.898146+06
2813	8793	1	3	t	2023-07-13 11:13:13.898146+06
2814	8794	1	3	t	2023-07-13 11:13:13.898146+06
2815	8795	1	3	t	2023-07-13 11:13:13.898146+06
2816	8796	1	3	t	2023-07-13 11:13:13.898146+06
2817	8797	1	3	t	2023-07-13 11:13:13.898146+06
2818	8798	1	3	t	2023-07-13 11:13:13.898146+06
2819	8799	1	3	t	2023-07-13 11:13:13.898146+06
2820	8800	1	3	t	2023-07-13 11:13:13.898146+06
2821	8801	1	3	t	2023-07-13 11:13:13.898146+06
2822	8802	1	3	t	2023-07-13 11:13:13.898146+06
2823	8803	1	3	t	2023-07-13 11:13:13.898146+06
2824	8804	1	3	t	2023-07-13 11:13:13.898146+06
2825	8805	1	3	t	2023-07-13 11:13:13.898146+06
2826	8806	1	3	t	2023-07-13 11:13:13.898146+06
2827	8807	1	3	t	2023-07-13 11:13:13.898146+06
2828	8808	1	3	t	2023-07-13 11:13:13.898146+06
2829	8809	1	3	t	2023-07-13 11:13:13.898146+06
2830	8810	1	3	t	2023-07-13 11:13:13.898146+06
2831	8811	1	3	t	2023-07-13 11:13:13.898146+06
2832	8812	1	3	t	2023-07-13 11:13:13.898146+06
2833	8813	1	3	t	2023-07-13 11:13:13.898146+06
2834	8814	1	3	t	2023-07-13 11:13:13.898146+06
2835	8815	1	3	t	2023-07-13 11:13:13.898146+06
2836	8816	1	3	t	2023-07-13 11:13:13.898146+06
2837	8817	1	3	t	2023-07-13 11:13:13.898146+06
2838	8818	1	3	t	2023-07-13 11:13:13.898146+06
2839	8819	1	3	t	2023-07-13 11:13:13.898146+06
2840	8820	1	3	t	2023-07-13 11:13:13.898146+06
2841	8821	1	3	t	2023-07-13 11:13:13.898146+06
2842	8822	1	3	t	2023-07-13 11:13:13.898146+06
2843	8823	1	3	t	2023-07-13 11:13:13.898146+06
2844	8824	1	3	t	2023-07-13 11:13:13.898146+06
2845	8825	1	3	t	2023-07-13 11:13:13.898146+06
2846	8826	1	3	t	2023-07-13 11:13:13.898146+06
2847	8827	1	3	t	2023-07-13 11:13:13.898146+06
2848	8828	1	3	t	2023-07-13 11:13:13.898146+06
2849	8829	1	3	t	2023-07-13 11:13:13.898146+06
2850	8830	1	3	t	2023-07-13 11:13:13.898146+06
2851	8831	1	3	t	2023-07-13 11:13:13.898146+06
2852	8832	1	3	t	2023-07-13 11:13:13.898146+06
2853	8833	1	3	t	2023-07-13 11:13:13.898146+06
2854	8834	1	3	t	2023-07-13 11:13:13.898146+06
2855	8835	1	3	t	2023-07-13 11:13:13.898146+06
2856	8836	1	3	t	2023-07-13 11:13:13.898146+06
2857	8837	1	3	t	2023-07-13 11:13:13.898146+06
2858	8838	1	3	t	2023-07-13 11:13:13.898146+06
2859	8839	1	3	t	2023-07-13 11:13:13.898146+06
2860	8840	1	3	t	2023-07-13 11:13:13.898146+06
2861	8841	1	3	t	2023-07-13 11:13:13.898146+06
2862	8842	1	3	t	2023-07-13 11:13:13.898146+06
2863	8843	1	3	t	2023-07-13 11:13:13.898146+06
2864	8844	1	3	t	2023-07-13 11:13:13.898146+06
2865	8845	1	3	t	2023-07-13 11:13:13.898146+06
2866	8846	1	3	t	2023-07-13 11:13:13.898146+06
2867	8847	1	3	t	2023-07-13 11:13:13.898146+06
2868	8848	1	3	t	2023-07-13 11:13:13.898146+06
2869	8849	1	3	t	2023-07-13 11:13:13.898146+06
2870	8850	1	3	t	2023-07-13 11:13:13.898146+06
2871	8851	1	3	t	2023-07-13 11:13:13.898146+06
2872	8852	1	3	t	2023-07-13 11:13:13.898146+06
2873	8853	1	3	t	2023-07-13 11:13:13.898146+06
2874	8854	1	3	t	2023-07-13 11:13:13.898146+06
2875	8855	1	3	t	2023-07-13 11:13:13.898146+06
2876	8856	1	3	t	2023-07-13 11:13:13.898146+06
2877	8857	1	3	t	2023-07-13 11:13:13.898146+06
2878	8858	1	3	t	2023-07-13 11:13:13.898146+06
2879	8859	1	3	t	2023-07-13 11:13:13.898146+06
2880	8860	1	3	t	2023-07-13 11:13:13.898146+06
2881	8861	1	3	t	2023-07-13 11:13:13.898146+06
2882	8862	1	3	t	2023-07-13 11:13:13.898146+06
2883	8863	1	3	t	2023-07-13 11:13:13.898146+06
2884	8864	1	3	t	2023-07-13 11:13:13.898146+06
2885	8865	1	3	t	2023-07-13 11:13:13.898146+06
2886	8866	1	3	t	2023-07-13 11:13:13.898146+06
2887	8867	1	3	t	2023-07-13 11:13:13.898146+06
2888	8868	1	3	t	2023-07-13 11:13:13.898146+06
2889	8869	1	3	t	2023-07-13 11:13:13.898146+06
2890	8870	1	3	t	2023-07-13 11:13:13.898146+06
2891	8871	1	3	t	2023-07-13 11:13:13.898146+06
2892	8872	1	3	t	2023-07-13 11:13:13.898146+06
2893	8873	1	3	t	2023-07-13 11:13:13.898146+06
2894	8874	1	3	t	2023-07-13 11:13:13.898146+06
2895	8875	1	3	t	2023-07-13 11:13:13.898146+06
2896	8876	1	3	t	2023-07-13 11:13:13.898146+06
2897	8877	1	3	t	2023-07-13 11:13:13.898146+06
2898	8878	1	3	t	2023-07-13 11:13:13.898146+06
2899	8879	1	3	t	2023-07-13 11:13:13.898146+06
2900	8880	1	3	t	2023-07-13 11:13:13.898146+06
2901	8881	1	3	t	2023-07-13 11:13:13.898146+06
2902	8882	1	3	t	2023-07-13 11:13:13.898146+06
2903	8883	1	3	t	2023-07-13 11:13:13.898146+06
2904	8884	1	3	t	2023-07-13 11:13:13.898146+06
2905	8885	1	3	t	2023-07-13 11:13:13.898146+06
2906	8886	1	3	t	2023-07-13 11:13:13.898146+06
2907	8887	1	3	t	2023-07-13 11:13:13.898146+06
2908	8888	1	3	t	2023-07-13 11:13:13.898146+06
2909	8889	1	3	t	2023-07-13 11:13:13.898146+06
2910	8890	1	3	t	2023-07-13 11:13:13.898146+06
2911	8891	1	3	t	2023-07-13 11:13:13.898146+06
2912	8892	1	3	t	2023-07-13 11:13:13.898146+06
2913	8893	1	3	t	2023-07-13 11:13:13.898146+06
2914	8894	1	3	t	2023-07-13 11:13:13.898146+06
2915	8895	1	3	t	2023-07-13 11:13:13.898146+06
2916	8896	1	3	t	2023-07-13 11:13:13.898146+06
2917	8897	1	3	t	2023-07-13 11:13:13.898146+06
2918	8898	1	3	t	2023-07-13 11:13:13.898146+06
2919	8899	1	3	t	2023-07-13 11:13:13.898146+06
2920	8900	1	3	t	2023-07-13 11:13:13.898146+06
2921	8901	1	3	t	2023-07-13 11:13:13.898146+06
2922	8902	1	3	t	2023-07-13 11:13:13.898146+06
2923	8903	1	3	t	2023-07-13 11:13:13.898146+06
2924	8904	1	3	t	2023-07-13 11:13:13.898146+06
2925	8905	1	3	t	2023-07-13 11:13:13.898146+06
2926	8906	1	3	t	2023-07-13 11:13:13.898146+06
2927	8907	1	3	t	2023-07-13 11:13:13.898146+06
2928	8908	1	3	t	2023-07-13 11:13:13.898146+06
2929	8909	1	3	t	2023-07-13 11:13:13.898146+06
2930	8910	1	3	t	2023-07-13 11:13:13.898146+06
2931	8911	1	3	t	2023-07-13 11:13:13.898146+06
2932	8912	1	3	t	2023-07-13 11:13:13.898146+06
2933	8913	1	3	t	2023-07-13 11:13:13.898146+06
2934	8914	1	3	t	2023-07-13 11:13:13.898146+06
2935	8915	1	3	t	2023-07-13 11:13:13.898146+06
2936	8916	1	3	t	2023-07-13 11:13:13.898146+06
2937	8917	1	3	t	2023-07-13 11:13:13.898146+06
2938	8918	1	3	t	2023-07-13 11:13:13.898146+06
2939	8919	1	3	t	2023-07-13 11:13:13.898146+06
2940	8920	1	3	t	2023-07-13 11:13:13.898146+06
2941	8921	1	3	t	2023-07-13 11:13:13.898146+06
2942	8922	1	3	t	2023-07-13 11:13:13.898146+06
2943	8923	1	3	t	2023-07-13 11:13:13.898146+06
2944	8924	1	3	t	2023-07-13 11:13:13.898146+06
2945	8925	1	3	t	2023-07-13 11:13:13.898146+06
2946	8926	1	3	t	2023-07-13 11:13:13.898146+06
2947	8927	1	3	t	2023-07-13 11:13:13.898146+06
2948	8928	1	3	t	2023-07-13 11:13:13.898146+06
2949	8929	1	3	t	2023-07-13 11:13:13.898146+06
2950	8930	1	3	t	2023-07-13 11:13:13.898146+06
2951	8931	1	3	t	2023-07-13 11:13:13.898146+06
2952	8932	1	3	t	2023-07-13 11:13:13.898146+06
2953	8933	1	3	t	2023-07-13 11:13:13.898146+06
2954	8934	1	3	t	2023-07-13 11:13:13.898146+06
2955	8935	1	3	t	2023-07-13 11:13:13.898146+06
2956	8936	1	3	t	2023-07-13 11:13:13.898146+06
2957	8937	1	3	t	2023-07-13 11:13:13.898146+06
2958	8938	1	3	t	2023-07-13 11:13:13.898146+06
2959	8939	1	3	t	2023-07-13 11:13:13.898146+06
2960	8940	1	3	t	2023-07-13 11:13:13.898146+06
2961	8941	1	3	t	2023-07-13 11:13:13.898146+06
2962	8942	1	3	t	2023-07-13 11:13:13.898146+06
2963	8943	1	3	t	2023-07-13 11:13:13.898146+06
2964	8944	1	3	t	2023-07-13 11:13:13.898146+06
2965	8945	1	3	t	2023-07-13 11:13:13.898146+06
2966	8946	1	3	t	2023-07-13 11:13:13.898146+06
2967	8947	1	3	t	2023-07-13 11:13:13.898146+06
2968	8948	1	3	t	2023-07-13 11:13:13.898146+06
2969	8949	1	3	t	2023-07-13 11:13:13.898146+06
2970	8950	1	3	t	2023-07-13 11:13:13.898146+06
2971	8951	1	3	t	2023-07-13 11:13:13.898146+06
2972	8952	1	3	t	2023-07-13 11:13:13.898146+06
2973	8953	1	3	t	2023-07-13 11:13:13.898146+06
2974	8954	1	3	t	2023-07-13 11:13:13.898146+06
2975	8955	1	3	t	2023-07-13 11:13:13.898146+06
2976	8956	1	3	t	2023-07-13 11:13:13.898146+06
2977	8957	1	3	t	2023-07-13 11:13:13.898146+06
2978	8958	1	3	t	2023-07-13 11:13:13.898146+06
2979	8959	1	3	t	2023-07-13 11:13:13.898146+06
2980	8960	1	3	t	2023-07-13 11:13:13.898146+06
2981	8961	1	3	t	2023-07-13 11:13:13.898146+06
2982	8962	1	3	t	2023-07-13 11:13:13.898146+06
2983	8963	1	3	t	2023-07-13 11:13:13.898146+06
2984	8964	1	3	t	2023-07-13 11:13:13.898146+06
2985	8965	1	3	t	2023-07-13 11:13:13.898146+06
2986	8966	1	3	t	2023-07-13 11:13:13.898146+06
2987	8967	1	3	t	2023-07-13 11:13:13.898146+06
2988	8968	1	3	t	2023-07-13 11:13:13.898146+06
2989	8969	1	3	t	2023-07-13 11:13:13.898146+06
2990	8970	1	3	t	2023-07-13 11:13:13.898146+06
2991	8971	1	3	t	2023-07-13 11:13:13.898146+06
2992	8972	1	3	t	2023-07-13 11:13:13.898146+06
2993	8973	1	3	t	2023-07-13 11:13:13.898146+06
2994	8974	1	3	t	2023-07-13 11:13:13.898146+06
2995	8975	1	3	t	2023-07-13 11:13:13.898146+06
2996	8976	1	3	t	2023-07-13 11:13:13.898146+06
2997	8977	1	3	t	2023-07-13 11:13:13.898146+06
2998	8978	1	3	t	2023-07-13 11:13:13.898146+06
2999	8979	1	3	t	2023-07-13 11:13:13.898146+06
3000	8980	1	3	t	2023-07-13 11:13:13.898146+06
3001	8981	1	3	t	2023-07-13 11:13:13.898146+06
3002	8982	1	3	t	2023-07-13 11:13:13.898146+06
3003	8983	1	3	t	2023-07-13 11:13:13.898146+06
3004	8984	1	3	t	2023-07-13 11:13:13.898146+06
3005	8985	1	3	t	2023-07-13 11:13:13.898146+06
3006	8986	1	3	t	2023-07-13 11:13:13.898146+06
3007	8987	1	3	t	2023-07-13 11:13:13.898146+06
3008	8988	1	3	t	2023-07-13 11:13:13.898146+06
3009	8989	1	3	t	2023-07-13 11:13:13.898146+06
3010	8990	1	3	t	2023-07-13 11:13:13.898146+06
3011	8991	1	3	t	2023-07-13 11:13:13.898146+06
3012	8992	1	3	t	2023-07-13 11:13:13.898146+06
3013	8993	1	3	t	2023-07-13 11:13:13.898146+06
3014	8994	1	3	t	2023-07-13 11:13:13.898146+06
3015	8995	1	3	t	2023-07-13 11:13:13.898146+06
3016	8996	1	3	t	2023-07-13 11:13:13.898146+06
3017	8997	1	3	t	2023-07-13 11:13:13.898146+06
3018	8998	1	3	t	2023-07-13 11:13:13.898146+06
3019	8999	1	3	t	2023-07-13 11:13:13.898146+06
3020	9000	1	3	t	2023-07-13 11:13:13.898146+06
3021	9001	1	3	t	2023-07-13 11:13:13.898146+06
3022	9002	1	3	t	2023-07-13 11:13:13.898146+06
3023	9003	1	3	t	2023-07-13 11:13:13.898146+06
3024	9004	1	3	t	2023-07-13 11:13:13.898146+06
3025	9005	1	3	t	2023-07-13 11:13:13.898146+06
3026	9006	1	3	t	2023-07-13 11:13:13.898146+06
3027	9007	1	3	t	2023-07-13 11:13:13.898146+06
3028	9008	1	3	t	2023-07-13 11:13:13.898146+06
3029	9009	1	3	t	2023-07-13 11:13:13.898146+06
3030	9010	1	3	t	2023-07-13 11:13:13.898146+06
3031	9011	1	3	t	2023-07-13 11:13:13.898146+06
3032	9012	1	3	t	2023-07-13 11:13:13.898146+06
3033	9013	1	3	t	2023-07-13 11:13:13.898146+06
3034	9014	1	3	t	2023-07-13 11:13:13.898146+06
3035	9015	1	3	t	2023-07-13 11:13:13.898146+06
3036	9016	1	3	t	2023-07-13 11:13:13.898146+06
3037	9017	1	3	t	2023-07-13 11:13:13.898146+06
3038	9018	1	3	t	2023-07-13 11:13:13.898146+06
3039	9019	1	3	t	2023-07-13 11:13:13.898146+06
3040	9020	1	3	t	2023-07-13 11:13:13.898146+06
3041	9021	1	3	t	2023-07-13 11:13:13.898146+06
3042	9022	1	3	t	2023-07-13 11:13:13.898146+06
3043	9023	1	3	t	2023-07-13 11:13:13.898146+06
3044	9024	1	3	t	2023-07-13 11:13:13.898146+06
3045	9025	1	3	t	2023-07-13 11:13:13.898146+06
3046	9026	1	3	t	2023-07-13 11:13:13.898146+06
3047	9027	1	3	t	2023-07-13 11:13:13.898146+06
3048	9028	1	3	t	2023-07-13 11:13:13.898146+06
3049	9029	1	3	t	2023-07-13 11:13:13.898146+06
3050	9030	1	3	t	2023-07-13 11:13:13.898146+06
3051	9031	1	3	t	2023-07-13 11:13:13.898146+06
3052	9032	1	3	t	2023-07-13 11:13:13.898146+06
3053	9033	1	3	t	2023-07-13 11:13:13.898146+06
3054	9034	1	3	t	2023-07-13 11:13:13.898146+06
3055	9035	1	3	t	2023-07-13 11:13:13.898146+06
3056	9036	1	3	t	2023-07-13 11:13:13.898146+06
3057	9037	1	3	t	2023-07-13 11:13:13.898146+06
3058	9038	1	3	t	2023-07-13 11:13:13.898146+06
3059	9039	1	3	t	2023-07-13 11:13:13.898146+06
3060	9040	1	3	t	2023-07-13 11:13:13.898146+06
3061	9041	1	3	t	2023-07-13 11:13:13.898146+06
3062	9042	1	3	t	2023-07-13 11:13:13.898146+06
3063	9043	1	3	t	2023-07-13 11:13:13.898146+06
3064	9044	1	3	t	2023-07-13 11:13:13.898146+06
3065	9045	1	3	t	2023-07-13 11:13:13.898146+06
3066	9046	1	3	t	2023-07-13 11:13:13.898146+06
3067	9047	1	3	t	2023-07-13 11:13:13.898146+06
3068	9048	1	3	t	2023-07-13 11:13:13.898146+06
3069	9049	1	3	t	2023-07-13 11:13:13.898146+06
3070	9050	1	3	t	2023-07-13 11:13:13.898146+06
3071	9051	1	3	t	2023-07-13 11:13:13.898146+06
3072	9052	1	3	t	2023-07-13 11:13:13.898146+06
3073	9053	1	3	t	2023-07-13 11:13:13.898146+06
3074	9054	1	3	t	2023-07-13 11:13:13.898146+06
3075	9055	1	3	t	2023-07-13 11:13:13.898146+06
3076	9056	1	3	t	2023-07-13 11:13:13.898146+06
3077	9057	1	3	t	2023-07-13 11:13:13.898146+06
3078	9058	1	3	t	2023-07-13 11:13:13.898146+06
3079	9059	1	3	t	2023-07-13 11:13:13.898146+06
3080	9060	1	3	t	2023-07-13 11:13:13.898146+06
3081	9061	1	3	t	2023-07-13 11:13:13.898146+06
3082	9062	1	3	t	2023-07-13 11:13:13.898146+06
3083	9063	1	3	t	2023-07-13 11:13:13.898146+06
3084	9064	1	3	t	2023-07-13 11:13:13.898146+06
3085	9065	1	3	t	2023-07-13 11:13:13.898146+06
3086	9066	1	3	t	2023-07-13 11:13:13.898146+06
3087	9067	1	3	t	2023-07-13 11:13:13.898146+06
3088	9068	1	3	t	2023-07-13 11:13:13.898146+06
3089	9069	1	3	t	2023-07-13 11:13:13.898146+06
3090	9070	1	3	t	2023-07-13 11:13:13.898146+06
3091	9071	1	3	t	2023-07-13 11:13:13.898146+06
3092	9072	1	3	t	2023-07-13 11:13:13.898146+06
3093	9073	1	3	t	2023-07-13 11:13:13.898146+06
3094	9074	1	3	t	2023-07-13 11:13:13.898146+06
3095	9075	1	3	t	2023-07-13 11:13:13.898146+06
3096	9076	1	3	t	2023-07-13 11:13:13.898146+06
3097	9077	1	3	t	2023-07-13 11:13:13.898146+06
3098	9078	1	3	t	2023-07-13 11:13:13.898146+06
3099	9079	1	3	t	2023-07-13 11:13:13.898146+06
3100	9080	1	3	t	2023-07-13 11:13:13.898146+06
3101	9081	1	3	t	2023-07-13 11:13:13.898146+06
3102	9082	1	3	t	2023-07-13 11:13:13.898146+06
3103	9083	1	3	t	2023-07-13 11:13:13.898146+06
3104	9084	1	3	t	2023-07-13 11:13:13.898146+06
3105	9085	1	3	t	2023-07-13 11:13:13.898146+06
3106	9086	1	3	t	2023-07-13 11:13:13.898146+06
3107	9087	1	3	t	2023-07-13 11:13:13.898146+06
3108	9088	1	3	t	2023-07-13 11:13:13.898146+06
3109	9089	1	3	t	2023-07-13 11:13:13.898146+06
3110	9090	1	3	t	2023-07-13 11:13:13.898146+06
3111	9091	1	3	t	2023-07-13 11:13:13.898146+06
3112	9092	1	3	t	2023-07-13 11:13:13.898146+06
3113	9093	1	3	t	2023-07-13 11:13:13.898146+06
3114	9094	1	3	t	2023-07-13 11:13:13.898146+06
3115	9095	1	3	t	2023-07-13 11:13:13.898146+06
3116	9096	1	3	t	2023-07-13 11:13:13.898146+06
3117	9097	1	3	t	2023-07-13 11:13:13.898146+06
3118	9098	1	3	t	2023-07-13 11:13:13.898146+06
3119	9099	1	3	t	2023-07-13 11:13:13.898146+06
3120	9100	1	3	t	2023-07-13 11:13:13.898146+06
3121	9101	1	3	t	2023-07-13 11:13:13.898146+06
3122	9102	1	3	t	2023-07-13 11:13:13.898146+06
3123	9103	1	3	t	2023-07-13 11:13:13.898146+06
3124	9104	1	3	t	2023-07-13 11:13:13.898146+06
3125	9105	1	3	t	2023-07-13 11:13:13.898146+06
3126	9106	1	3	t	2023-07-13 11:13:13.898146+06
3127	9107	1	3	t	2023-07-13 11:13:13.898146+06
3128	9108	1	3	t	2023-07-13 11:13:13.898146+06
3129	9109	1	3	t	2023-07-13 11:13:13.898146+06
3130	9110	1	3	t	2023-07-13 11:13:13.898146+06
3131	9111	1	3	t	2023-07-13 11:13:13.898146+06
3132	9112	1	3	t	2023-07-13 11:13:13.898146+06
3133	9113	1	3	t	2023-07-13 11:13:13.898146+06
3134	9114	1	3	t	2023-07-13 11:13:13.898146+06
3135	9115	1	3	t	2023-07-13 11:13:13.898146+06
3136	9116	1	3	t	2023-07-13 11:13:13.898146+06
3137	9117	1	3	t	2023-07-13 11:13:13.898146+06
3138	9118	1	3	t	2023-07-13 11:13:13.898146+06
3139	9119	1	3	t	2023-07-13 11:13:13.898146+06
3140	9120	1	3	t	2023-07-13 11:13:13.898146+06
3141	9121	1	3	t	2023-07-13 11:13:13.898146+06
3142	9122	1	3	t	2023-07-13 11:13:13.898146+06
3143	9123	1	3	t	2023-07-13 11:13:13.898146+06
3144	9124	1	3	t	2023-07-13 11:13:13.898146+06
3145	9125	1	3	t	2023-07-13 11:13:13.898146+06
3146	9126	1	3	t	2023-07-13 11:13:13.898146+06
3147	9127	1	3	t	2023-07-13 11:13:13.898146+06
3148	9128	1	3	t	2023-07-13 11:13:13.898146+06
3149	9129	1	3	t	2023-07-13 11:13:13.898146+06
3150	9130	1	3	t	2023-07-13 11:13:13.898146+06
3151	9131	1	3	t	2023-07-13 11:13:13.898146+06
3152	9132	1	3	t	2023-07-13 11:13:13.898146+06
3153	9133	1	3	t	2023-07-13 11:13:13.898146+06
3154	9134	1	3	t	2023-07-13 11:13:13.898146+06
3155	9135	1	3	t	2023-07-13 11:13:13.898146+06
3156	9136	1	3	t	2023-07-13 11:13:13.898146+06
3157	9137	1	3	t	2023-07-13 11:13:13.898146+06
3158	9138	1	3	t	2023-07-13 11:13:13.898146+06
3159	9139	1	3	t	2023-07-13 11:13:13.898146+06
3160	9140	1	3	t	2023-07-13 11:13:13.898146+06
3161	9141	1	3	t	2023-07-13 11:13:13.898146+06
3162	9142	1	3	t	2023-07-13 11:13:13.898146+06
3163	9143	1	3	t	2023-07-13 11:13:13.898146+06
3164	9144	1	3	t	2023-07-13 11:13:13.898146+06
3165	9145	1	3	t	2023-07-13 11:13:13.898146+06
3166	9146	1	3	t	2023-07-13 11:13:13.898146+06
3167	9147	1	3	t	2023-07-13 11:13:13.898146+06
3168	9148	1	3	t	2023-07-13 11:13:13.898146+06
3169	9149	1	3	t	2023-07-13 11:13:13.898146+06
3170	9150	1	3	t	2023-07-13 11:13:13.898146+06
3171	9151	1	3	t	2023-07-13 11:13:13.898146+06
3172	9152	1	3	t	2023-07-13 11:13:13.898146+06
3173	9153	1	3	t	2023-07-13 11:13:13.898146+06
3174	9154	1	3	t	2023-07-13 11:13:13.898146+06
3175	9155	1	3	t	2023-07-13 11:13:13.898146+06
3176	9156	1	3	t	2023-07-13 11:13:13.898146+06
3177	9157	1	3	t	2023-07-13 11:13:13.898146+06
3178	9158	1	3	t	2023-07-13 11:13:13.898146+06
3179	9159	1	3	t	2023-07-13 11:13:13.898146+06
3180	9160	1	3	t	2023-07-13 11:13:13.898146+06
3181	9161	1	3	t	2023-07-13 11:13:13.898146+06
3182	9162	1	3	t	2023-07-13 11:13:13.898146+06
3183	9163	1	3	t	2023-07-13 11:13:13.898146+06
3184	9164	1	3	t	2023-07-13 11:13:13.898146+06
3185	9165	1	3	t	2023-07-13 11:13:13.898146+06
3186	9166	1	3	t	2023-07-13 11:13:13.898146+06
3187	9167	1	3	t	2023-07-13 11:13:13.898146+06
3188	9168	1	3	t	2023-07-13 11:13:13.898146+06
3189	9169	1	3	t	2023-07-13 11:13:13.898146+06
3190	9170	1	3	t	2023-07-13 11:13:13.898146+06
3191	9171	1	3	t	2023-07-13 11:13:13.898146+06
3192	9172	1	3	t	2023-07-13 11:13:13.898146+06
3193	9173	1	3	t	2023-07-13 11:13:13.898146+06
3194	9174	1	3	t	2023-07-13 11:13:13.898146+06
3195	9175	1	3	t	2023-07-13 11:13:13.898146+06
3196	9176	1	3	t	2023-07-13 11:13:13.898146+06
3197	9177	1	3	t	2023-07-13 11:13:13.898146+06
3198	9178	1	3	t	2023-07-13 11:13:13.898146+06
3199	9179	1	3	t	2023-07-13 11:13:13.898146+06
3200	9180	1	3	t	2023-07-13 11:13:13.898146+06
3201	9181	1	3	t	2023-07-13 11:13:13.898146+06
3202	9182	1	3	t	2023-07-13 11:13:13.898146+06
3203	9183	1	3	t	2023-07-13 11:13:13.898146+06
3204	9184	1	3	t	2023-07-13 11:13:13.898146+06
3205	9185	1	3	t	2023-07-13 11:13:13.898146+06
3206	9186	1	3	t	2023-07-13 11:13:13.898146+06
3207	9187	1	3	t	2023-07-13 11:13:13.898146+06
3208	9188	1	3	t	2023-07-13 11:13:13.898146+06
3209	9189	1	3	t	2023-07-13 11:13:13.898146+06
3210	9190	1	3	t	2023-07-13 11:13:13.898146+06
3211	9191	1	3	t	2023-07-13 11:13:13.898146+06
3212	9192	1	3	t	2023-07-13 11:13:13.898146+06
3213	9193	1	3	t	2023-07-13 11:13:13.898146+06
3214	9194	1	3	t	2023-07-13 11:13:13.898146+06
3215	9195	1	3	t	2023-07-13 11:13:13.898146+06
3216	9196	1	3	t	2023-07-13 11:13:13.898146+06
3217	9197	1	3	t	2023-07-13 11:13:13.898146+06
3218	9198	1	3	t	2023-07-13 11:13:13.898146+06
3219	9199	1	3	t	2023-07-13 11:13:13.898146+06
3220	9200	1	3	t	2023-07-13 11:13:13.898146+06
3221	9201	1	3	t	2023-07-13 11:13:13.898146+06
3222	9202	1	3	t	2023-07-13 11:13:13.898146+06
3223	9203	1	3	t	2023-07-13 11:13:13.898146+06
3224	9204	1	3	t	2023-07-13 11:13:13.898146+06
3225	9205	1	3	t	2023-07-13 11:13:13.898146+06
3226	9206	1	3	t	2023-07-13 11:13:13.898146+06
3227	9207	1	3	t	2023-07-13 11:13:13.898146+06
3228	9208	1	3	t	2023-07-13 11:13:13.898146+06
3229	9209	1	3	t	2023-07-13 11:13:13.898146+06
3230	9210	1	3	t	2023-07-13 11:13:13.898146+06
3231	9211	1	3	t	2023-07-13 11:13:13.898146+06
3232	9212	1	3	t	2023-07-13 11:13:13.898146+06
3233	9213	1	3	t	2023-07-13 11:13:13.898146+06
3234	9214	1	3	t	2023-07-13 11:13:13.898146+06
3235	9215	1	3	t	2023-07-13 11:13:13.898146+06
3236	9216	1	3	t	2023-07-13 11:13:13.898146+06
3237	9217	1	3	t	2023-07-13 11:13:13.898146+06
3238	9218	1	3	t	2023-07-13 11:13:13.898146+06
3239	9219	1	3	t	2023-07-13 11:13:13.898146+06
3240	9220	1	3	t	2023-07-13 11:13:13.898146+06
3241	9221	1	3	t	2023-07-13 11:13:13.898146+06
3242	9222	1	3	t	2023-07-13 11:13:13.898146+06
3243	9223	1	3	t	2023-07-13 11:13:13.898146+06
3244	9224	1	3	t	2023-07-13 11:13:13.898146+06
3245	9225	1	3	t	2023-07-13 11:13:13.898146+06
3246	9226	1	3	t	2023-07-13 11:13:13.898146+06
3247	9227	1	3	t	2023-07-13 11:13:13.898146+06
3248	9228	1	3	t	2023-07-13 11:13:13.898146+06
3249	9229	1	3	t	2023-07-13 11:13:13.898146+06
3250	9230	1	3	t	2023-07-13 11:13:13.898146+06
3251	9231	1	3	t	2023-07-13 11:13:13.898146+06
3252	9232	1	3	t	2023-07-13 11:13:13.898146+06
3253	9233	1	3	t	2023-07-13 11:13:13.898146+06
3254	9234	1	3	t	2023-07-13 11:13:13.898146+06
3255	9235	1	3	t	2023-07-13 11:13:13.898146+06
3256	9236	1	3	t	2023-07-13 11:13:13.898146+06
3257	9237	1	3	t	2023-07-13 11:13:13.898146+06
3258	9238	1	3	t	2023-07-13 11:13:13.898146+06
3259	9239	1	3	t	2023-07-13 11:13:13.898146+06
3260	9240	1	3	t	2023-07-13 11:13:13.898146+06
3261	9241	1	3	t	2023-07-13 11:13:13.898146+06
3262	9242	1	3	t	2023-07-13 11:13:13.898146+06
3263	9243	1	3	t	2023-07-13 11:13:13.898146+06
3264	9244	1	3	t	2023-07-13 11:13:13.898146+06
3265	9245	1	3	t	2023-07-13 11:13:13.898146+06
3266	9246	1	3	t	2023-07-13 11:13:13.898146+06
3267	9247	1	3	t	2023-07-13 11:13:13.898146+06
3268	9248	1	3	t	2023-07-13 11:13:13.898146+06
3269	9249	1	3	t	2023-07-13 11:13:13.898146+06
3270	9250	1	3	t	2023-07-13 11:13:13.898146+06
3271	9251	1	3	t	2023-07-13 11:13:13.898146+06
3272	9252	1	3	t	2023-07-13 11:13:13.898146+06
3273	9253	1	3	t	2023-07-13 11:13:13.898146+06
3274	9254	1	3	t	2023-07-13 11:13:13.898146+06
3275	9255	1	3	t	2023-07-13 11:13:13.898146+06
3276	9256	1	3	t	2023-07-13 11:13:13.898146+06
3277	9257	1	3	t	2023-07-13 11:13:13.898146+06
3278	9258	1	3	t	2023-07-13 11:13:13.898146+06
3279	9259	1	3	t	2023-07-13 11:13:13.898146+06
3280	9260	1	3	t	2023-07-13 11:13:13.898146+06
3281	9261	1	3	t	2023-07-13 11:13:13.898146+06
3282	9262	1	3	t	2023-07-13 11:13:13.898146+06
3283	9263	1	3	t	2023-07-13 11:13:13.898146+06
3284	9264	1	3	t	2023-07-13 11:13:13.898146+06
3285	9265	1	3	t	2023-07-13 11:13:13.898146+06
3286	9266	1	3	t	2023-07-13 11:13:13.898146+06
3287	9267	1	3	t	2023-07-13 11:13:13.898146+06
3288	9268	1	3	t	2023-07-13 11:13:13.898146+06
3289	9269	1	3	t	2023-07-13 11:13:13.898146+06
3290	9270	1	3	t	2023-07-13 11:13:13.898146+06
3291	9271	1	3	t	2023-07-13 11:13:13.898146+06
3292	9272	1	3	t	2023-07-13 11:13:13.898146+06
3293	9273	1	3	t	2023-07-13 11:13:13.898146+06
3294	9274	1	3	t	2023-07-13 11:13:13.898146+06
3295	9275	1	3	t	2023-07-13 11:13:13.898146+06
3296	9276	1	3	t	2023-07-13 11:13:13.898146+06
3297	9277	1	3	t	2023-07-13 11:13:13.898146+06
3298	9278	1	3	t	2023-07-13 11:13:13.898146+06
3299	9279	1	3	t	2023-07-13 11:13:13.898146+06
3300	9280	1	3	t	2023-07-13 11:13:13.898146+06
3301	9281	1	3	t	2023-07-13 11:13:13.898146+06
3302	9282	1	3	t	2023-07-13 11:13:13.898146+06
3303	9283	1	3	t	2023-07-13 11:13:13.898146+06
3304	9284	1	3	t	2023-07-13 11:13:13.898146+06
3305	9285	1	3	t	2023-07-13 11:13:13.898146+06
3306	9286	1	3	t	2023-07-13 11:13:13.898146+06
3307	9287	1	3	t	2023-07-13 11:13:13.898146+06
3308	9288	1	3	t	2023-07-13 11:13:13.898146+06
3309	9289	1	3	t	2023-07-13 11:13:13.898146+06
3310	9290	1	3	t	2023-07-13 11:13:13.898146+06
3311	9291	1	3	t	2023-07-13 11:13:13.898146+06
3312	9292	1	3	t	2023-07-13 11:13:13.898146+06
3313	9293	1	3	t	2023-07-13 11:13:13.898146+06
3314	9294	1	3	t	2023-07-13 11:13:13.898146+06
3315	9295	1	3	t	2023-07-13 11:13:13.898146+06
3316	9296	1	3	t	2023-07-13 11:13:13.898146+06
3317	9297	1	3	t	2023-07-13 11:13:13.898146+06
3318	9298	1	3	t	2023-07-13 11:13:13.898146+06
3319	9299	1	3	t	2023-07-13 11:13:13.898146+06
3320	9300	1	3	t	2023-07-13 11:13:13.898146+06
3321	9301	1	3	t	2023-07-13 11:13:13.898146+06
3322	9302	1	3	t	2023-07-13 11:13:13.898146+06
3323	9303	1	3	t	2023-07-13 11:13:13.898146+06
3324	9304	1	3	t	2023-07-13 11:13:13.898146+06
3325	9305	1	3	t	2023-07-13 11:13:13.898146+06
3326	9306	1	3	t	2023-07-13 11:13:13.898146+06
3327	9307	1	3	t	2023-07-13 11:13:13.898146+06
3328	9308	1	3	t	2023-07-13 11:13:13.898146+06
3329	9309	1	3	t	2023-07-13 11:13:13.898146+06
3330	9310	1	3	t	2023-07-13 11:13:13.898146+06
3331	9311	1	3	t	2023-07-13 11:13:13.898146+06
3332	9312	1	3	t	2023-07-13 11:13:13.898146+06
3333	9313	1	3	t	2023-07-13 11:13:13.898146+06
3334	9314	1	3	t	2023-07-13 11:13:13.898146+06
3335	9315	1	3	t	2023-07-13 11:13:13.898146+06
3336	9316	1	3	t	2023-07-13 11:13:13.898146+06
3337	9317	1	3	t	2023-07-13 11:13:13.898146+06
3338	9318	1	3	t	2023-07-13 11:13:13.898146+06
3339	9319	1	3	t	2023-07-13 11:13:13.898146+06
3340	9320	1	3	t	2023-07-13 11:13:13.898146+06
3341	9321	1	3	t	2023-07-13 11:13:13.898146+06
3342	9322	1	3	t	2023-07-13 11:13:13.898146+06
3343	9323	1	3	t	2023-07-13 11:13:13.898146+06
3344	9324	1	3	t	2023-07-13 11:13:13.898146+06
3345	9325	1	3	t	2023-07-13 11:13:13.898146+06
3346	9326	1	3	t	2023-07-13 11:13:13.898146+06
3347	9327	1	3	t	2023-07-13 11:13:13.898146+06
3348	9328	1	3	t	2023-07-13 11:13:13.898146+06
3349	9329	1	3	t	2023-07-13 11:13:13.898146+06
3350	9330	1	3	t	2023-07-13 11:13:13.898146+06
3351	9331	1	3	t	2023-07-13 11:13:13.898146+06
3352	9332	1	3	t	2023-07-13 11:13:13.898146+06
3353	9333	1	3	t	2023-07-13 11:13:13.898146+06
3354	9334	1	3	t	2023-07-13 11:13:13.898146+06
3355	9335	1	3	t	2023-07-13 11:13:13.898146+06
3356	9336	1	3	t	2023-07-13 11:13:13.898146+06
3357	9337	1	3	t	2023-07-13 11:13:13.898146+06
3358	9338	1	3	t	2023-07-13 11:13:13.898146+06
3359	9339	1	3	t	2023-07-13 11:13:13.898146+06
3360	9340	1	3	t	2023-07-13 11:13:13.898146+06
3361	9341	1	3	t	2023-07-13 11:13:13.898146+06
3362	9342	1	3	t	2023-07-13 11:13:13.898146+06
3363	9343	1	3	t	2023-07-13 11:13:13.898146+06
3364	9344	1	3	t	2023-07-13 11:13:13.898146+06
3365	9345	1	3	t	2023-07-13 11:13:13.898146+06
3366	9346	1	3	t	2023-07-13 11:13:13.898146+06
3367	9347	1	3	t	2023-07-13 11:13:13.898146+06
3368	9348	1	3	t	2023-07-13 11:13:13.898146+06
3369	9349	1	3	t	2023-07-13 11:13:13.898146+06
3370	9350	1	3	t	2023-07-13 11:13:13.898146+06
3371	9351	1	3	t	2023-07-13 11:13:13.898146+06
3372	9352	1	3	t	2023-07-13 11:13:13.898146+06
3373	9353	1	3	t	2023-07-13 11:13:13.898146+06
3374	9354	1	3	t	2023-07-13 11:13:13.898146+06
3375	9355	1	3	t	2023-07-13 11:13:13.898146+06
3376	9356	1	3	t	2023-07-13 11:13:13.898146+06
3377	9357	1	3	t	2023-07-13 11:13:13.898146+06
3378	9358	1	3	t	2023-07-13 11:13:13.898146+06
3379	9359	1	3	t	2023-07-13 11:13:13.898146+06
3380	9360	1	3	t	2023-07-13 11:13:13.898146+06
3381	9361	1	3	t	2023-07-13 11:13:13.898146+06
3382	9362	1	3	t	2023-07-13 11:13:13.898146+06
3383	9363	1	3	t	2023-07-13 11:13:13.898146+06
3384	9364	1	3	t	2023-07-13 11:13:13.898146+06
3385	9365	1	3	t	2023-07-13 11:13:13.898146+06
3386	9366	1	3	t	2023-07-13 11:13:13.898146+06
3387	9367	1	3	t	2023-07-13 11:13:13.898146+06
3388	9368	1	3	t	2023-07-13 11:13:13.898146+06
3389	9369	1	3	t	2023-07-13 11:13:13.898146+06
3390	9370	1	3	t	2023-07-13 11:13:13.898146+06
3391	9371	1	3	t	2023-07-13 11:13:13.898146+06
3392	9372	1	3	t	2023-07-13 11:13:13.898146+06
3393	9373	1	3	t	2023-07-13 11:13:13.898146+06
3394	9374	1	3	t	2023-07-13 11:13:13.898146+06
3395	9375	1	3	t	2023-07-13 11:13:13.898146+06
3396	9376	1	3	t	2023-07-13 11:13:13.898146+06
3397	9377	1	3	t	2023-07-13 11:13:13.898146+06
3398	9378	1	3	t	2023-07-13 11:13:13.898146+06
3399	9379	1	3	t	2023-07-13 11:13:13.898146+06
3400	9380	1	3	t	2023-07-13 11:13:13.898146+06
3401	9381	1	3	t	2023-07-13 11:13:13.898146+06
3402	9382	1	3	t	2023-07-13 11:13:13.898146+06
3403	9383	1	3	t	2023-07-13 11:13:13.898146+06
3404	9384	1	3	t	2023-07-13 11:13:13.898146+06
3405	9385	1	3	t	2023-07-13 11:13:13.898146+06
3406	9386	1	3	t	2023-07-13 11:13:13.898146+06
3407	9387	1	3	t	2023-07-13 11:13:13.898146+06
3408	9388	1	3	t	2023-07-13 11:13:13.898146+06
3409	9389	1	3	t	2023-07-13 11:13:13.898146+06
3410	9390	1	3	t	2023-07-13 11:13:13.898146+06
3411	9391	1	3	t	2023-07-13 11:13:13.898146+06
3412	9392	1	3	t	2023-07-13 11:13:13.898146+06
3413	9393	1	3	t	2023-07-13 11:13:13.898146+06
3414	9394	1	3	t	2023-07-13 11:13:13.898146+06
3415	9395	1	3	t	2023-07-13 11:13:13.898146+06
3416	9396	1	3	t	2023-07-13 11:13:13.898146+06
3417	9397	1	3	t	2023-07-13 11:13:13.898146+06
3418	9398	1	3	t	2023-07-13 11:13:13.898146+06
3419	9399	1	3	t	2023-07-13 11:13:13.898146+06
3420	9400	1	3	t	2023-07-13 11:13:13.898146+06
3421	9401	1	3	t	2023-07-13 11:13:13.898146+06
3422	9402	1	3	t	2023-07-13 11:13:13.898146+06
3423	9403	1	3	t	2023-07-13 11:13:13.898146+06
3424	9404	1	3	t	2023-07-13 11:13:13.898146+06
3425	9405	1	3	t	2023-07-13 11:13:13.898146+06
3426	9406	1	3	t	2023-07-13 11:13:13.898146+06
3427	9407	1	3	t	2023-07-13 11:13:13.898146+06
3428	9408	1	3	t	2023-07-13 11:13:13.898146+06
3429	9409	1	3	t	2023-07-13 11:13:13.898146+06
3430	9410	1	3	t	2023-07-13 11:13:13.898146+06
3431	9411	1	3	t	2023-07-13 11:13:13.898146+06
3432	9412	1	3	t	2023-07-13 11:13:13.898146+06
3433	9413	1	3	t	2023-07-13 11:13:13.898146+06
3434	9414	1	3	t	2023-07-13 11:13:13.898146+06
3435	9415	1	3	t	2023-07-13 11:13:13.898146+06
3436	9416	1	3	t	2023-07-13 11:13:13.898146+06
3437	9417	1	3	t	2023-07-13 11:13:13.898146+06
3438	9418	1	3	t	2023-07-13 11:13:13.898146+06
3439	9419	1	3	t	2023-07-13 11:13:13.898146+06
3440	9420	1	3	t	2023-07-13 11:13:13.898146+06
3441	9421	1	3	t	2023-07-13 11:13:13.898146+06
3442	9422	1	3	t	2023-07-13 11:13:13.898146+06
3443	9423	1	3	t	2023-07-13 11:13:13.898146+06
3444	9424	1	3	t	2023-07-13 11:13:13.898146+06
3445	9425	1	3	t	2023-07-13 11:13:13.898146+06
3446	9426	1	3	t	2023-07-13 11:13:13.898146+06
3447	9427	1	3	t	2023-07-13 11:13:13.898146+06
3448	9428	1	3	t	2023-07-13 11:13:13.898146+06
3449	9429	1	3	t	2023-07-13 11:13:13.898146+06
3450	9430	1	3	t	2023-07-13 11:13:13.898146+06
3451	9431	1	3	t	2023-07-13 11:13:13.898146+06
3452	9432	1	3	t	2023-07-13 11:13:13.898146+06
3453	9433	1	3	t	2023-07-13 11:13:13.898146+06
3454	9434	1	3	t	2023-07-13 11:13:13.898146+06
3455	9435	1	3	t	2023-07-13 11:13:13.898146+06
3456	9436	1	3	t	2023-07-13 11:13:13.898146+06
3457	9437	1	3	t	2023-07-13 11:13:13.898146+06
3458	9438	1	3	t	2023-07-13 11:13:13.898146+06
3459	9439	1	3	t	2023-07-13 11:13:13.898146+06
3460	9440	1	3	t	2023-07-13 11:13:13.898146+06
3461	9441	1	3	t	2023-07-13 11:13:13.898146+06
3462	9442	1	3	t	2023-07-13 11:13:13.898146+06
3463	9443	1	3	t	2023-07-13 11:13:13.898146+06
3464	9444	1	3	t	2023-07-13 11:13:13.898146+06
3465	9445	1	3	t	2023-07-13 11:13:13.898146+06
3466	9446	1	3	t	2023-07-13 11:13:13.898146+06
3467	9447	1	3	t	2023-07-13 11:13:13.898146+06
3468	9448	1	3	t	2023-07-13 11:13:13.898146+06
3469	9449	1	3	t	2023-07-13 11:13:13.898146+06
3470	9450	1	3	t	2023-07-13 11:13:13.898146+06
3471	9451	1	3	t	2023-07-13 11:13:13.898146+06
3472	9452	1	3	t	2023-07-13 11:13:13.898146+06
3473	9453	1	3	t	2023-07-13 11:13:13.898146+06
3474	9454	1	3	t	2023-07-13 11:13:13.898146+06
3475	9455	1	3	t	2023-07-13 11:13:13.898146+06
3476	9456	1	3	t	2023-07-13 11:13:13.898146+06
3477	9457	1	3	t	2023-07-13 11:13:13.898146+06
3478	9458	1	3	t	2023-07-13 11:13:13.898146+06
3479	9459	1	3	t	2023-07-13 11:13:13.898146+06
3480	9460	1	3	t	2023-07-13 11:13:13.898146+06
3481	9461	1	3	t	2023-07-13 11:13:13.898146+06
3482	9462	1	3	t	2023-07-13 11:13:13.898146+06
3483	9463	1	3	t	2023-07-13 11:13:13.898146+06
3484	9464	1	3	t	2023-07-13 11:13:13.898146+06
3485	9465	1	3	t	2023-07-13 11:13:13.898146+06
3486	9466	1	3	t	2023-07-13 11:13:13.898146+06
3487	9467	1	3	t	2023-07-13 11:13:13.898146+06
3488	9468	1	3	t	2023-07-13 11:13:13.898146+06
3489	9469	1	3	t	2023-07-13 11:13:13.898146+06
3490	9470	1	3	t	2023-07-13 11:13:13.898146+06
3491	9471	1	3	t	2023-07-13 11:13:13.898146+06
3492	9472	1	3	t	2023-07-13 11:13:13.898146+06
3493	9473	1	3	t	2023-07-13 11:13:13.898146+06
3494	9474	1	3	t	2023-07-13 11:13:13.898146+06
3495	9475	1	3	t	2023-07-13 11:13:13.898146+06
3496	9476	1	3	t	2023-07-13 11:13:13.898146+06
3497	9477	1	3	t	2023-07-13 11:13:13.898146+06
3498	9478	1	3	t	2023-07-13 11:13:13.898146+06
3499	9479	1	3	t	2023-07-13 11:13:13.898146+06
3500	9480	1	3	t	2023-07-13 11:13:13.898146+06
3501	9481	1	3	t	2023-07-13 11:13:13.898146+06
3502	9482	1	3	t	2023-07-13 11:13:13.898146+06
3503	9483	1	3	t	2023-07-13 11:13:13.898146+06
3504	9484	1	3	t	2023-07-13 11:13:13.898146+06
3505	9485	1	3	t	2023-07-13 11:13:13.898146+06
3506	9486	1	3	t	2023-07-13 11:13:13.898146+06
3507	9487	1	3	t	2023-07-13 11:13:13.898146+06
3508	9488	1	3	t	2023-07-13 11:13:13.898146+06
3509	9489	1	3	t	2023-07-13 11:13:13.898146+06
3510	9490	1	3	t	2023-07-13 11:13:13.898146+06
3511	9491	1	3	t	2023-07-13 11:13:13.898146+06
3512	9492	1	3	t	2023-07-13 11:13:13.898146+06
3513	9493	1	3	t	2023-07-13 11:13:13.898146+06
3514	9494	1	3	t	2023-07-13 11:13:13.898146+06
3515	9495	1	3	t	2023-07-13 11:13:13.898146+06
3516	9496	1	3	t	2023-07-13 11:13:13.898146+06
3517	9497	1	3	t	2023-07-13 11:13:13.898146+06
3518	9498	1	3	t	2023-07-13 11:13:13.898146+06
3519	9499	1	3	t	2023-07-13 11:13:13.898146+06
3520	9500	1	3	t	2023-07-13 11:13:13.898146+06
3521	9501	1	3	t	2023-07-13 11:13:13.898146+06
3522	9502	1	3	t	2023-07-13 11:13:13.898146+06
3523	9503	1	3	t	2023-07-13 11:13:13.898146+06
3524	9504	1	3	t	2023-07-13 11:13:13.898146+06
3525	9505	1	3	t	2023-07-13 11:13:13.898146+06
3526	9506	1	3	t	2023-07-13 11:13:13.898146+06
3527	9507	1	3	t	2023-07-13 11:13:13.898146+06
3528	9508	1	3	t	2023-07-13 11:13:13.898146+06
3529	9509	1	3	t	2023-07-13 11:13:13.898146+06
3530	9510	1	3	t	2023-07-13 11:13:13.898146+06
3531	9511	1	3	t	2023-07-13 11:13:13.898146+06
3532	9512	1	3	t	2023-07-13 11:13:13.898146+06
3533	9513	1	3	t	2023-07-13 11:13:13.898146+06
3534	9514	1	3	t	2023-07-13 11:13:13.898146+06
3535	9515	1	3	t	2023-07-13 11:13:13.898146+06
3536	9516	1	3	t	2023-07-13 11:13:13.898146+06
3537	9517	1	3	t	2023-07-13 11:13:13.898146+06
3538	9518	1	3	t	2023-07-13 11:13:13.898146+06
3539	9519	1	3	t	2023-07-13 11:13:13.898146+06
3540	9520	1	3	t	2023-07-13 11:13:13.898146+06
3541	9521	1	3	t	2023-07-13 11:13:13.898146+06
3542	9522	1	3	t	2023-07-13 11:13:13.898146+06
3543	9523	1	3	t	2023-07-13 11:13:13.898146+06
3544	9524	1	3	t	2023-07-13 11:13:13.898146+06
3545	9525	1	3	t	2023-07-13 11:13:13.898146+06
3546	9526	1	3	t	2023-07-13 11:13:13.898146+06
3547	9527	1	3	t	2023-07-13 11:13:13.898146+06
3548	9528	1	3	t	2023-07-13 11:13:13.898146+06
3549	9529	1	3	t	2023-07-13 11:13:13.898146+06
3550	9530	1	3	t	2023-07-13 11:13:13.898146+06
3551	9531	1	3	t	2023-07-13 11:13:13.898146+06
3552	9532	1	3	t	2023-07-13 11:13:13.898146+06
3553	9533	1	3	t	2023-07-13 11:13:13.898146+06
3554	9534	1	3	t	2023-07-13 11:13:13.898146+06
3555	9535	1	3	t	2023-07-13 11:13:13.898146+06
3556	9536	1	3	t	2023-07-13 11:13:13.898146+06
3557	9537	1	3	t	2023-07-13 11:13:13.898146+06
3558	9538	1	3	t	2023-07-13 11:13:13.898146+06
3559	9539	1	3	t	2023-07-13 11:13:13.898146+06
3560	9540	1	3	t	2023-07-13 11:13:13.898146+06
3561	9541	1	3	t	2023-07-13 11:13:13.898146+06
3562	9542	1	3	t	2023-07-13 11:13:13.898146+06
3563	9543	1	3	t	2023-07-13 11:13:13.898146+06
3564	9544	1	3	t	2023-07-13 11:13:13.898146+06
3565	9545	1	3	t	2023-07-13 11:13:13.898146+06
3566	9546	1	3	t	2023-07-13 11:13:13.898146+06
3567	9547	1	3	t	2023-07-13 11:13:13.898146+06
3568	9548	1	3	t	2023-07-13 11:13:13.898146+06
3569	9549	1	3	t	2023-07-13 11:13:13.898146+06
3570	9550	1	3	t	2023-07-13 11:13:13.898146+06
3571	9551	1	3	t	2023-07-13 11:13:13.898146+06
3572	9552	1	3	t	2023-07-13 11:13:13.898146+06
3573	9553	1	3	t	2023-07-13 11:13:13.898146+06
3574	9554	1	3	t	2023-07-13 11:13:13.898146+06
3575	9555	1	3	t	2023-07-13 11:13:13.898146+06
3576	9556	1	3	t	2023-07-13 11:13:13.898146+06
3577	9557	1	3	t	2023-07-13 11:13:13.898146+06
3578	9558	1	3	t	2023-07-13 11:13:13.898146+06
3579	9559	1	3	t	2023-07-13 11:13:13.898146+06
3580	9560	1	3	t	2023-07-13 11:13:13.898146+06
3581	9561	1	3	t	2023-07-13 11:13:13.898146+06
3582	9562	1	3	t	2023-07-13 11:13:13.898146+06
3583	9563	1	3	t	2023-07-13 11:13:13.898146+06
3584	9564	1	3	t	2023-07-13 11:13:13.898146+06
3585	9565	1	3	t	2023-07-13 11:13:13.898146+06
3586	9566	1	3	t	2023-07-13 11:13:13.898146+06
3587	9567	1	3	t	2023-07-13 11:13:13.898146+06
3588	9568	1	3	t	2023-07-13 11:13:13.898146+06
3589	9569	1	3	t	2023-07-13 11:13:13.898146+06
3590	9570	1	3	t	2023-07-13 11:13:13.898146+06
3591	9571	1	3	t	2023-07-13 11:13:13.898146+06
3592	9572	1	3	t	2023-07-13 11:13:13.898146+06
3593	9573	1	3	t	2023-07-13 11:13:13.898146+06
3594	9574	1	3	t	2023-07-13 11:13:13.898146+06
3595	9575	1	3	t	2023-07-13 11:13:13.898146+06
3596	9576	1	3	t	2023-07-13 11:13:13.898146+06
3597	9577	1	3	t	2023-07-13 11:13:13.898146+06
3598	9578	1	3	t	2023-07-13 11:13:13.898146+06
3599	9579	1	3	t	2023-07-13 11:13:13.898146+06
3600	9580	1	3	t	2023-07-13 11:13:13.898146+06
3601	9581	1	3	t	2023-07-13 11:13:13.898146+06
3602	9582	1	3	t	2023-07-13 11:13:13.898146+06
3603	9583	1	3	t	2023-07-13 11:13:13.898146+06
3604	9584	1	3	t	2023-07-13 11:13:13.898146+06
3605	9585	1	3	t	2023-07-13 11:13:13.898146+06
3606	9586	1	3	t	2023-07-13 11:13:13.898146+06
3607	9587	1	3	t	2023-07-13 11:13:13.898146+06
3608	9588	1	3	t	2023-07-13 11:13:13.898146+06
3609	9589	1	3	t	2023-07-13 11:13:13.898146+06
3610	9590	1	3	t	2023-07-13 11:13:13.898146+06
3611	9591	1	3	t	2023-07-13 11:13:13.898146+06
3612	9592	1	3	t	2023-07-13 11:13:13.898146+06
3613	9593	1	3	t	2023-07-13 11:13:13.898146+06
3614	9594	1	3	t	2023-07-13 11:13:13.898146+06
3615	9595	1	3	t	2023-07-13 11:13:13.898146+06
3616	9596	1	3	t	2023-07-13 11:13:13.898146+06
3617	9597	1	3	t	2023-07-13 11:13:13.898146+06
3618	9598	1	3	t	2023-07-13 11:13:13.898146+06
3619	9599	1	3	t	2023-07-13 11:13:13.898146+06
3620	9600	1	3	t	2023-07-13 11:13:13.898146+06
3621	9601	1	3	t	2023-07-13 11:13:13.898146+06
3622	9602	1	3	t	2023-07-13 11:13:13.898146+06
3623	9603	1	3	t	2023-07-13 11:13:13.898146+06
3624	9604	1	3	t	2023-07-13 11:13:13.898146+06
3625	9605	1	3	t	2023-07-13 11:13:13.898146+06
3626	9606	1	3	t	2023-07-13 11:13:13.898146+06
3627	9607	1	3	t	2023-07-13 11:13:13.898146+06
3628	9608	1	3	t	2023-07-13 11:13:13.898146+06
3629	9609	1	3	t	2023-07-13 11:13:13.898146+06
3630	9610	1	3	t	2023-07-13 11:13:13.898146+06
3631	9611	1	3	t	2023-07-13 11:13:13.898146+06
3632	9612	1	3	t	2023-07-13 11:13:13.898146+06
3633	9613	1	3	t	2023-07-13 11:13:13.898146+06
3634	9614	1	3	t	2023-07-13 11:13:13.898146+06
3635	9615	1	3	t	2023-07-13 11:13:13.898146+06
3636	9616	1	3	t	2023-07-13 11:13:13.898146+06
3637	9617	1	3	t	2023-07-13 11:13:13.898146+06
3638	9618	1	3	t	2023-07-13 11:13:13.898146+06
3639	9619	1	3	t	2023-07-13 11:13:13.898146+06
3640	9620	1	3	t	2023-07-13 11:13:13.898146+06
3641	9621	1	3	t	2023-07-13 11:13:13.898146+06
3642	9622	1	3	t	2023-07-13 11:13:13.898146+06
3643	9623	1	3	t	2023-07-13 11:13:13.898146+06
3644	9624	1	3	t	2023-07-13 11:13:13.898146+06
3645	9625	1	3	t	2023-07-13 11:13:13.898146+06
3646	9626	1	3	t	2023-07-13 11:13:13.898146+06
3647	9627	1	3	t	2023-07-13 11:13:13.898146+06
3648	9628	1	3	t	2023-07-13 11:13:13.898146+06
3649	9629	1	3	t	2023-07-13 11:13:13.898146+06
3650	9630	1	3	t	2023-07-13 11:13:13.898146+06
3651	9631	1	3	t	2023-07-13 11:13:13.898146+06
3652	9632	1	3	t	2023-07-13 11:13:13.898146+06
3653	9633	1	3	t	2023-07-13 11:13:13.898146+06
3654	9634	1	3	t	2023-07-13 11:13:13.898146+06
3655	9635	1	3	t	2023-07-13 11:13:13.898146+06
3656	9636	1	3	t	2023-07-13 11:13:13.898146+06
3657	9637	1	3	t	2023-07-13 11:13:13.898146+06
3658	9638	1	3	t	2023-07-13 11:13:13.898146+06
3659	9639	1	3	t	2023-07-13 11:13:13.898146+06
3660	9640	1	3	t	2023-07-13 11:13:13.898146+06
3661	9641	1	3	t	2023-07-13 11:13:13.898146+06
3662	9642	1	3	t	2023-07-13 11:13:13.898146+06
3663	9643	1	3	t	2023-07-13 11:13:13.898146+06
3664	9644	1	3	t	2023-07-13 11:13:13.898146+06
3665	9645	1	3	t	2023-07-13 11:13:13.898146+06
3666	9646	1	3	t	2023-07-13 11:13:13.898146+06
3667	9647	1	3	t	2023-07-13 11:13:13.898146+06
3668	9648	1	3	t	2023-07-13 11:13:13.898146+06
3669	9649	1	3	t	2023-07-13 11:13:13.898146+06
3670	9650	1	3	t	2023-07-13 11:13:13.898146+06
3671	9651	1	3	t	2023-07-13 11:13:13.898146+06
3672	9652	1	3	t	2023-07-13 11:13:13.898146+06
3673	9653	1	3	t	2023-07-13 11:13:13.898146+06
3674	9654	1	3	t	2023-07-13 11:13:13.898146+06
3675	9655	1	3	t	2023-07-13 11:13:13.898146+06
3676	9656	1	3	t	2023-07-13 11:13:13.898146+06
3677	9657	1	3	t	2023-07-13 11:13:13.898146+06
3678	9658	1	3	t	2023-07-13 11:13:13.898146+06
3679	9659	1	3	t	2023-07-13 11:13:13.898146+06
3680	9660	1	3	t	2023-07-13 11:13:13.898146+06
3681	9661	1	3	t	2023-07-13 11:13:13.898146+06
3682	9662	1	3	t	2023-07-13 11:13:13.898146+06
3683	9663	1	3	t	2023-07-13 11:13:13.898146+06
3684	9664	1	3	t	2023-07-13 11:13:13.898146+06
3685	9665	1	3	t	2023-07-13 11:13:13.898146+06
3686	9666	1	3	t	2023-07-13 11:13:13.898146+06
3687	9667	1	3	t	2023-07-13 11:13:13.898146+06
3688	9668	1	3	t	2023-07-13 11:13:13.898146+06
3689	9669	1	3	t	2023-07-13 11:13:13.898146+06
3690	9670	1	3	t	2023-07-13 11:13:13.898146+06
3691	9671	1	3	t	2023-07-13 11:13:13.898146+06
3692	9672	1	3	t	2023-07-13 11:13:13.898146+06
3693	9673	1	3	t	2023-07-13 11:13:13.898146+06
3694	9674	1	3	t	2023-07-13 11:13:13.898146+06
3695	9675	1	3	t	2023-07-13 11:13:13.898146+06
3696	9676	1	3	t	2023-07-13 11:13:13.898146+06
3697	9677	1	3	t	2023-07-13 11:13:13.898146+06
3698	9678	1	3	t	2023-07-13 11:13:13.898146+06
3699	9679	1	3	t	2023-07-13 11:13:13.898146+06
3700	9680	1	3	t	2023-07-13 11:13:13.898146+06
3701	9681	1	3	t	2023-07-13 11:13:13.898146+06
3702	9682	1	3	t	2023-07-13 11:13:13.898146+06
3703	9683	1	3	t	2023-07-13 11:13:13.898146+06
3704	9684	1	3	t	2023-07-13 11:13:13.898146+06
3705	9685	1	3	t	2023-07-13 11:13:13.898146+06
3706	9686	1	3	t	2023-07-13 11:13:13.898146+06
3707	9687	1	3	t	2023-07-13 11:13:13.898146+06
3708	9688	1	3	t	2023-07-13 11:13:13.898146+06
3709	9689	1	3	t	2023-07-13 11:13:13.898146+06
3710	9690	1	3	t	2023-07-13 11:13:13.898146+06
3711	9691	1	3	t	2023-07-13 11:13:13.898146+06
3712	9692	1	3	t	2023-07-13 11:13:13.898146+06
3713	9693	1	3	t	2023-07-13 11:13:13.898146+06
3714	9694	1	3	t	2023-07-13 11:13:13.898146+06
3715	9695	1	3	t	2023-07-13 11:13:13.898146+06
3716	9696	1	3	t	2023-07-13 11:13:13.898146+06
3717	9697	1	3	t	2023-07-13 11:13:13.898146+06
3718	9698	1	3	t	2023-07-13 11:13:13.898146+06
3719	9699	1	3	t	2023-07-13 11:13:13.898146+06
3720	9700	1	3	t	2023-07-13 11:13:13.898146+06
3721	9701	1	3	t	2023-07-13 11:13:13.898146+06
3722	9702	1	3	t	2023-07-13 11:13:13.898146+06
3723	9703	1	3	t	2023-07-13 11:13:13.898146+06
3724	9704	1	3	t	2023-07-13 11:13:13.898146+06
3725	9705	1	3	t	2023-07-13 11:13:13.898146+06
3726	9706	1	3	t	2023-07-13 11:13:13.898146+06
3727	9707	1	3	t	2023-07-13 11:13:13.898146+06
3728	9708	1	3	t	2023-07-13 11:13:13.898146+06
3729	9709	1	3	t	2023-07-13 11:13:13.898146+06
3730	9710	1	3	t	2023-07-13 11:13:13.898146+06
3731	9711	1	3	t	2023-07-13 11:13:13.898146+06
3732	9712	1	3	t	2023-07-13 11:13:13.898146+06
3733	9713	1	3	t	2023-07-13 11:13:13.898146+06
3734	9714	1	3	t	2023-07-13 11:13:13.898146+06
3735	9715	1	3	t	2023-07-13 11:13:13.898146+06
3736	9716	1	3	t	2023-07-13 11:13:13.898146+06
3737	9717	1	3	t	2023-07-13 11:13:13.898146+06
3738	9718	1	3	t	2023-07-13 11:13:13.898146+06
3739	9719	1	3	t	2023-07-13 11:13:13.898146+06
3740	9720	1	3	t	2023-07-13 11:13:13.898146+06
3741	9721	1	3	t	2023-07-13 11:13:13.898146+06
3742	9722	1	3	t	2023-07-13 11:13:13.898146+06
3743	9723	1	3	t	2023-07-13 11:13:13.898146+06
3744	9724	1	3	t	2023-07-13 11:13:13.898146+06
3745	9725	1	3	t	2023-07-13 11:13:13.898146+06
3746	9726	1	3	t	2023-07-13 11:13:13.898146+06
3747	9727	1	3	t	2023-07-13 11:13:13.898146+06
3748	9728	1	3	t	2023-07-13 11:13:13.898146+06
3749	9729	1	3	t	2023-07-13 11:13:13.898146+06
3750	9730	1	3	t	2023-07-13 11:13:13.898146+06
3751	9731	1	3	t	2023-07-13 11:13:13.898146+06
3752	9732	1	3	t	2023-07-13 11:13:13.898146+06
3753	9733	1	3	t	2023-07-13 11:13:13.898146+06
3754	9734	1	3	t	2023-07-13 11:13:13.898146+06
3755	9735	1	3	t	2023-07-13 11:13:13.898146+06
3756	9736	1	3	t	2023-07-13 11:13:13.898146+06
3757	9737	1	3	t	2023-07-13 11:13:13.898146+06
3758	9738	1	3	t	2023-07-13 11:13:13.898146+06
3759	9739	1	3	t	2023-07-13 11:13:13.898146+06
3760	9740	1	3	t	2023-07-13 11:13:13.898146+06
3761	9741	1	3	t	2023-07-13 11:13:13.898146+06
3762	9742	1	3	t	2023-07-13 11:13:13.898146+06
3763	9743	1	3	t	2023-07-13 11:13:13.898146+06
3764	9744	1	3	t	2023-07-13 11:13:13.898146+06
3765	9745	1	3	t	2023-07-13 11:13:13.898146+06
3766	9746	1	3	t	2023-07-13 11:13:13.898146+06
3767	9747	1	3	t	2023-07-13 11:13:13.898146+06
3768	9748	1	3	t	2023-07-13 11:13:13.898146+06
3769	9749	1	3	t	2023-07-13 11:13:13.898146+06
3770	9750	1	3	t	2023-07-13 11:13:13.898146+06
3771	9751	1	3	t	2023-07-13 11:13:13.898146+06
3772	9752	1	3	t	2023-07-13 11:13:13.898146+06
3773	9753	1	3	t	2023-07-13 11:13:13.898146+06
3774	9754	1	3	t	2023-07-13 11:13:13.898146+06
3775	9755	1	3	t	2023-07-13 11:13:13.898146+06
3776	9756	1	3	t	2023-07-13 11:13:13.898146+06
3777	9757	1	3	t	2023-07-13 11:13:13.898146+06
3778	9758	1	3	t	2023-07-13 11:13:13.898146+06
3779	9759	1	3	t	2023-07-13 11:13:13.898146+06
3780	9760	1	3	t	2023-07-13 11:13:13.898146+06
3781	9761	1	3	t	2023-07-13 11:13:13.898146+06
3782	9762	1	3	t	2023-07-13 11:13:13.898146+06
3783	9763	1	3	t	2023-07-13 11:13:13.898146+06
3784	9764	1	3	t	2023-07-13 11:13:13.898146+06
3785	9765	1	3	t	2023-07-13 11:13:13.898146+06
3786	9766	1	3	t	2023-07-13 11:13:13.898146+06
3787	9767	1	3	t	2023-07-13 11:13:13.898146+06
3788	9768	1	3	t	2023-07-13 11:13:13.898146+06
3789	9769	1	3	t	2023-07-13 11:13:13.898146+06
3790	9770	1	3	t	2023-07-13 11:13:13.898146+06
3791	9771	1	3	t	2023-07-13 11:13:13.898146+06
3792	9772	1	3	t	2023-07-13 11:13:13.898146+06
3793	9773	1	3	t	2023-07-13 11:13:13.898146+06
3794	9774	1	3	t	2023-07-13 11:13:13.898146+06
3795	9775	1	3	t	2023-07-13 11:13:13.898146+06
3796	9776	1	3	t	2023-07-13 11:13:13.898146+06
3797	9777	1	3	t	2023-07-13 11:13:13.898146+06
3798	9778	1	3	t	2023-07-13 11:13:13.898146+06
3799	9779	1	3	t	2023-07-13 11:13:13.898146+06
3800	9780	1	3	t	2023-07-13 11:13:13.898146+06
3801	9781	1	3	t	2023-07-13 11:13:13.898146+06
3802	9782	1	3	t	2023-07-13 11:13:13.898146+06
3803	9783	1	3	t	2023-07-13 11:13:13.898146+06
3804	9784	1	3	t	2023-07-13 11:13:13.898146+06
3805	9785	1	3	t	2023-07-13 11:13:13.898146+06
3806	9786	1	3	t	2023-07-13 11:13:13.898146+06
3807	9787	1	3	t	2023-07-13 11:13:13.898146+06
3808	9788	1	3	t	2023-07-13 11:13:13.898146+06
3809	9789	1	3	t	2023-07-13 11:13:13.898146+06
3810	9790	1	3	t	2023-07-13 11:13:13.898146+06
3811	9791	1	3	t	2023-07-13 11:13:13.898146+06
3812	9792	1	3	t	2023-07-13 11:13:13.898146+06
3813	9793	1	3	t	2023-07-13 11:13:13.898146+06
3814	9794	1	3	t	2023-07-13 11:13:13.898146+06
3815	9795	1	3	t	2023-07-13 11:13:13.898146+06
3816	9796	1	3	t	2023-07-13 11:13:13.898146+06
3817	9797	1	3	t	2023-07-13 11:13:13.898146+06
3818	9798	1	3	t	2023-07-13 11:13:13.898146+06
3819	9799	1	3	t	2023-07-13 11:13:13.898146+06
3820	9800	1	3	t	2023-07-13 11:13:13.898146+06
3821	9801	1	3	t	2023-07-13 11:13:13.898146+06
3822	9802	1	3	t	2023-07-13 11:13:13.898146+06
3823	9803	1	3	t	2023-07-13 11:13:13.898146+06
3824	9804	1	3	t	2023-07-13 11:13:13.898146+06
3825	9805	1	3	t	2023-07-13 11:13:13.898146+06
3826	9806	1	3	t	2023-07-13 11:13:13.898146+06
3827	9807	1	3	t	2023-07-13 11:13:13.898146+06
3828	9808	1	3	t	2023-07-13 11:13:13.898146+06
3829	9809	1	3	t	2023-07-13 11:13:13.898146+06
3830	9810	1	3	t	2023-07-13 11:13:13.898146+06
3831	9811	1	3	t	2023-07-13 11:13:13.898146+06
3832	9812	1	3	t	2023-07-13 11:13:13.898146+06
3833	9813	1	3	t	2023-07-13 11:13:13.898146+06
3834	9814	1	3	t	2023-07-13 11:13:13.898146+06
3835	9815	1	3	t	2023-07-13 11:13:13.898146+06
3836	9816	1	3	t	2023-07-13 11:13:13.898146+06
3837	9817	1	3	t	2023-07-13 11:13:13.898146+06
3838	9818	1	3	t	2023-07-13 11:13:13.898146+06
3839	9819	1	3	t	2023-07-13 11:13:13.898146+06
3840	9820	1	3	t	2023-07-13 11:13:13.898146+06
3841	9821	1	3	t	2023-07-13 11:13:13.898146+06
3842	9822	1	3	t	2023-07-13 11:13:13.898146+06
3843	9823	1	3	t	2023-07-13 11:13:13.898146+06
3844	9824	1	3	t	2023-07-13 11:13:13.898146+06
3845	9825	1	3	t	2023-07-13 11:13:13.898146+06
3846	9826	1	3	t	2023-07-13 11:13:13.898146+06
3847	9827	1	3	t	2023-07-13 11:13:13.898146+06
3848	9828	1	3	t	2023-07-13 11:13:13.898146+06
3849	9829	1	3	t	2023-07-13 11:13:13.898146+06
3850	9830	1	3	t	2023-07-13 11:13:13.898146+06
3851	9831	1	3	t	2023-07-13 11:13:13.898146+06
3852	9832	1	3	t	2023-07-13 11:13:13.898146+06
3853	9833	1	3	t	2023-07-13 11:13:13.898146+06
3854	9834	1	3	t	2023-07-13 11:13:13.898146+06
3855	9835	1	3	t	2023-07-13 11:13:13.898146+06
3856	9836	1	3	t	2023-07-13 11:13:13.898146+06
3857	9837	1	3	t	2023-07-13 11:13:13.898146+06
3858	9838	1	3	t	2023-07-13 11:13:13.898146+06
3859	9839	1	3	t	2023-07-13 11:13:13.898146+06
3860	9840	1	3	t	2023-07-13 11:13:13.898146+06
3861	9841	1	3	t	2023-07-13 11:13:13.898146+06
3862	9842	1	3	t	2023-07-13 11:13:13.898146+06
3863	9843	1	3	t	2023-07-13 11:13:13.898146+06
3864	9844	1	3	t	2023-07-13 11:13:13.898146+06
3865	9845	1	3	t	2023-07-13 11:13:13.898146+06
3866	9846	1	3	t	2023-07-13 11:13:13.898146+06
3867	9847	1	3	t	2023-07-13 11:13:13.898146+06
3868	9848	1	3	t	2023-07-13 11:13:13.898146+06
3869	9849	1	3	t	2023-07-13 11:13:13.898146+06
3870	9850	1	3	t	2023-07-13 11:13:13.898146+06
3871	9851	1	3	t	2023-07-13 11:13:13.898146+06
3872	9852	1	3	t	2023-07-13 11:13:13.898146+06
3873	9853	1	3	t	2023-07-13 11:13:13.898146+06
3874	9854	1	3	t	2023-07-13 11:13:13.898146+06
3875	9855	1	3	t	2023-07-13 11:13:13.898146+06
3876	9856	1	3	t	2023-07-13 11:13:13.898146+06
3877	9857	1	3	t	2023-07-13 11:13:13.898146+06
3878	9858	1	3	t	2023-07-13 11:13:13.898146+06
3879	9859	1	3	t	2023-07-13 11:13:13.898146+06
3880	9860	1	3	t	2023-07-13 11:13:13.898146+06
3881	9861	1	3	t	2023-07-13 11:13:13.898146+06
3882	9862	1	3	t	2023-07-13 11:13:13.898146+06
3883	9863	1	3	t	2023-07-13 11:13:13.898146+06
3884	9864	1	3	t	2023-07-13 11:13:13.898146+06
3885	9865	1	3	t	2023-07-13 11:13:13.898146+06
3886	9866	1	3	t	2023-07-13 11:13:13.898146+06
3887	9867	1	3	t	2023-07-13 11:13:13.898146+06
3888	9868	1	3	t	2023-07-13 11:13:13.898146+06
3889	9869	1	3	t	2023-07-13 11:13:13.898146+06
3890	9870	1	3	t	2023-07-13 11:13:13.898146+06
3891	9871	1	3	t	2023-07-13 11:13:13.898146+06
3892	9872	1	3	t	2023-07-13 11:13:13.898146+06
3893	9873	1	3	t	2023-07-13 11:13:13.898146+06
3894	9874	1	3	t	2023-07-13 11:13:13.898146+06
3895	9875	1	3	t	2023-07-13 11:13:13.898146+06
3896	9876	1	3	t	2023-07-13 11:13:13.898146+06
3897	9877	1	3	t	2023-07-13 11:13:13.898146+06
3898	9878	1	3	t	2023-07-13 11:13:13.898146+06
3899	9879	1	3	t	2023-07-13 11:13:13.898146+06
3900	9880	1	3	t	2023-07-13 11:13:13.898146+06
3901	9881	1	3	t	2023-07-13 11:13:13.898146+06
3902	9882	1	3	t	2023-07-13 11:13:13.898146+06
3903	9883	1	3	t	2023-07-13 11:13:13.898146+06
3904	9884	1	3	t	2023-07-13 11:13:13.898146+06
3905	9885	1	3	t	2023-07-13 11:13:13.898146+06
3906	9886	1	3	t	2023-07-13 11:13:13.898146+06
3907	9887	1	3	t	2023-07-13 11:13:13.898146+06
3908	9888	1	3	t	2023-07-13 11:13:13.898146+06
3909	9889	1	3	t	2023-07-13 11:13:13.898146+06
3910	9890	1	3	t	2023-07-13 11:13:13.898146+06
3911	9891	1	3	t	2023-07-13 11:13:13.898146+06
3912	9892	1	3	t	2023-07-13 11:13:13.898146+06
3913	9893	1	3	t	2023-07-13 11:13:13.898146+06
3914	9894	1	3	t	2023-07-13 11:13:13.898146+06
3915	9895	1	3	t	2023-07-13 11:13:13.898146+06
3916	9896	1	3	t	2023-07-13 11:13:13.898146+06
3917	9897	1	3	t	2023-07-13 11:13:13.898146+06
3918	9898	1	3	t	2023-07-13 11:13:13.898146+06
3919	9899	1	3	t	2023-07-13 11:13:13.898146+06
3920	9900	1	3	t	2023-07-13 11:13:13.898146+06
3921	9901	1	3	t	2023-07-13 11:13:13.898146+06
3922	9902	1	3	t	2023-07-13 11:13:13.898146+06
3923	9903	1	3	t	2023-07-13 11:13:13.898146+06
3924	9904	1	3	t	2023-07-13 11:13:13.898146+06
3925	9905	1	3	t	2023-07-13 11:13:13.898146+06
3926	9906	1	3	t	2023-07-13 11:13:13.898146+06
3927	9907	1	3	t	2023-07-13 11:13:13.898146+06
3928	9908	1	3	t	2023-07-13 11:13:13.898146+06
3929	9909	1	3	t	2023-07-13 11:13:13.898146+06
3930	9910	1	3	t	2023-07-13 11:13:13.898146+06
3931	9911	1	3	t	2023-07-13 11:13:13.898146+06
3932	9912	1	3	t	2023-07-13 11:13:13.898146+06
3933	9913	1	3	t	2023-07-13 11:13:13.898146+06
3934	9914	1	3	t	2023-07-13 11:13:13.898146+06
3935	9915	1	3	t	2023-07-13 11:13:13.898146+06
3936	9916	1	3	t	2023-07-13 11:13:13.898146+06
3937	9917	1	3	t	2023-07-13 11:13:13.898146+06
3938	9918	1	3	t	2023-07-13 11:13:13.898146+06
3939	9919	1	3	t	2023-07-13 11:13:13.898146+06
3940	9920	1	3	t	2023-07-13 11:13:13.898146+06
3941	9921	1	3	t	2023-07-13 11:13:13.898146+06
3942	9922	1	3	t	2023-07-13 11:13:13.898146+06
3943	9923	1	3	t	2023-07-13 11:13:13.898146+06
3944	9924	1	3	t	2023-07-13 11:13:13.898146+06
3945	9925	1	3	t	2023-07-13 11:13:13.898146+06
3946	9926	1	3	t	2023-07-13 11:13:13.898146+06
3947	9927	1	3	t	2023-07-13 11:13:13.898146+06
3948	9928	1	3	t	2023-07-13 11:13:13.898146+06
3949	9929	1	3	t	2023-07-13 11:13:13.898146+06
3950	9930	1	3	t	2023-07-13 11:13:13.898146+06
3951	9931	1	3	t	2023-07-13 11:13:13.898146+06
3952	9932	1	3	t	2023-07-13 11:13:13.898146+06
3953	9933	1	3	t	2023-07-13 11:13:13.898146+06
3954	9934	1	3	t	2023-07-13 11:13:13.898146+06
3955	9935	1	3	t	2023-07-13 11:13:13.898146+06
3956	9936	1	3	t	2023-07-13 11:13:13.898146+06
3957	9937	1	3	t	2023-07-13 11:13:13.898146+06
3958	9938	1	3	t	2023-07-13 11:13:13.898146+06
3959	9939	1	3	t	2023-07-13 11:13:13.898146+06
3960	9940	1	3	t	2023-07-13 11:13:13.898146+06
3961	9941	1	3	t	2023-07-13 11:13:13.898146+06
3962	9942	1	3	t	2023-07-13 11:13:13.898146+06
3963	9943	1	3	t	2023-07-13 11:13:13.898146+06
3964	9944	1	3	t	2023-07-13 11:13:13.898146+06
3965	9945	1	3	t	2023-07-13 11:13:13.898146+06
3966	9946	1	3	t	2023-07-13 11:13:13.898146+06
3967	9947	1	3	t	2023-07-13 11:13:13.898146+06
3968	9948	1	3	t	2023-07-13 11:13:13.898146+06
3969	9949	1	3	t	2023-07-13 11:13:13.898146+06
3970	9950	1	3	t	2023-07-13 11:13:13.898146+06
3971	9951	1	3	t	2023-07-13 11:13:13.898146+06
3972	9952	1	3	t	2023-07-13 11:13:13.898146+06
3973	9953	1	3	t	2023-07-13 11:13:13.898146+06
3974	9954	1	3	t	2023-07-13 11:13:13.898146+06
3975	9955	1	3	t	2023-07-13 11:13:13.898146+06
3976	9956	1	3	t	2023-07-13 11:13:13.898146+06
3977	9957	1	3	t	2023-07-13 11:13:13.898146+06
3978	9958	1	3	t	2023-07-13 11:13:13.898146+06
3979	9959	1	3	t	2023-07-13 11:13:13.898146+06
3980	9960	1	3	t	2023-07-13 11:13:13.898146+06
3981	9961	1	3	t	2023-07-13 11:13:13.898146+06
3982	9962	1	3	t	2023-07-13 11:13:13.898146+06
3983	9963	1	3	t	2023-07-13 11:13:13.898146+06
3984	9964	1	3	t	2023-07-13 11:13:13.898146+06
3985	9965	1	3	t	2023-07-13 11:13:13.898146+06
3986	9966	1	3	t	2023-07-13 11:13:13.898146+06
3987	9967	1	3	t	2023-07-13 11:13:13.898146+06
3988	9968	1	3	t	2023-07-13 11:13:13.898146+06
3989	9969	1	3	t	2023-07-13 11:13:13.898146+06
3990	9970	1	3	t	2023-07-13 11:13:13.898146+06
3991	9971	1	3	t	2023-07-13 11:13:13.898146+06
3992	9972	1	3	t	2023-07-13 11:13:13.898146+06
3993	9973	1	3	t	2023-07-13 11:13:13.898146+06
3994	9974	1	3	t	2023-07-13 11:13:13.898146+06
3995	9975	1	3	t	2023-07-13 11:13:13.898146+06
3996	9976	1	3	t	2023-07-13 11:13:13.898146+06
3997	9977	1	3	t	2023-07-13 11:13:13.898146+06
3998	9978	1	3	t	2023-07-13 11:13:13.898146+06
3999	9979	1	3	t	2023-07-13 11:13:13.898146+06
4000	9980	1	3	t	2023-07-13 11:13:13.898146+06
4001	9981	1	3	t	2023-07-13 11:13:13.898146+06
4002	9982	1	3	t	2023-07-13 11:13:13.898146+06
4003	9983	1	3	t	2023-07-13 11:13:13.898146+06
4004	9984	1	3	t	2023-07-13 11:13:13.898146+06
4005	9985	1	3	t	2023-07-13 11:13:13.898146+06
4006	9986	1	3	t	2023-07-13 11:13:13.898146+06
4007	9987	1	3	t	2023-07-13 11:13:13.898146+06
4008	9988	1	3	t	2023-07-13 11:13:13.898146+06
4009	9989	1	3	t	2023-07-13 11:13:13.898146+06
4010	9990	1	3	t	2023-07-13 11:13:13.898146+06
4011	9991	1	3	t	2023-07-13 11:13:13.898146+06
4012	9992	1	3	t	2023-07-13 11:13:13.898146+06
4013	9993	1	3	t	2023-07-13 11:13:13.898146+06
4014	9994	1	3	t	2023-07-13 11:13:13.898146+06
4015	9995	1	3	t	2023-07-13 11:13:13.898146+06
4016	9996	1	3	t	2023-07-13 11:13:13.898146+06
4017	9997	1	3	t	2023-07-13 11:13:13.898146+06
4018	9998	1	3	t	2023-07-13 11:13:13.898146+06
4019	9999	1	3	t	2023-07-13 11:13:13.898146+06
4020	10000	1	3	t	2023-07-13 11:13:13.898146+06
4021	10001	1	3	t	2023-07-13 11:13:13.898146+06
4022	10002	1	3	t	2023-07-13 11:13:13.898146+06
4023	10003	1	3	t	2023-07-13 11:13:13.898146+06
4024	10004	1	3	t	2023-07-13 11:13:13.898146+06
4025	10005	1	3	t	2023-07-13 11:13:13.898146+06
4026	10006	1	3	t	2023-07-13 11:13:13.898146+06
4027	10007	1	3	t	2023-07-13 11:13:13.898146+06
4028	10008	1	3	t	2023-07-13 11:13:13.898146+06
4029	10009	1	3	t	2023-07-13 11:13:13.898146+06
4030	10010	1	3	t	2023-07-13 11:13:13.898146+06
4031	10011	1	3	t	2023-07-13 11:13:13.898146+06
4032	10012	1	3	t	2023-07-13 11:13:13.898146+06
4033	10013	1	3	t	2023-07-13 11:13:13.898146+06
4034	10014	1	3	t	2023-07-13 11:13:13.898146+06
4035	10015	1	3	t	2023-07-13 11:13:13.898146+06
4036	10016	1	3	t	2023-07-13 11:13:13.898146+06
4037	10017	1	3	t	2023-07-13 11:13:13.898146+06
4038	10018	1	3	t	2023-07-13 11:13:13.898146+06
4039	10019	1	3	t	2023-07-13 11:13:13.898146+06
4040	10020	1	3	t	2023-07-13 11:13:13.898146+06
4041	10021	1	3	t	2023-07-13 11:13:13.898146+06
4042	10022	1	3	t	2023-07-13 11:13:13.898146+06
4043	10023	1	3	t	2023-07-13 11:13:13.898146+06
4044	10024	1	3	t	2023-07-13 11:13:13.898146+06
4045	10025	1	3	t	2023-07-13 11:13:13.898146+06
4046	10026	1	3	t	2023-07-13 11:13:13.898146+06
4047	10027	1	3	t	2023-07-13 11:13:13.898146+06
4048	10028	1	3	t	2023-07-13 11:13:13.898146+06
4049	10029	1	3	t	2023-07-13 11:13:13.898146+06
4050	10030	1	3	t	2023-07-13 11:13:13.898146+06
4051	10031	1	3	t	2023-07-13 11:13:13.898146+06
4052	10032	1	3	t	2023-07-13 11:13:13.898146+06
4053	10033	1	3	t	2023-07-13 11:13:13.898146+06
4054	10034	1	3	t	2023-07-13 11:13:13.898146+06
4055	10035	1	3	t	2023-07-13 11:13:13.898146+06
4056	10036	1	3	t	2023-07-13 11:13:13.898146+06
4057	10037	1	3	t	2023-07-13 11:13:13.898146+06
4058	10038	1	3	t	2023-07-13 11:13:13.898146+06
4059	10039	1	3	t	2023-07-13 11:13:13.898146+06
4060	10040	1	3	t	2023-07-13 11:13:13.898146+06
4061	10041	1	3	t	2023-07-13 11:13:13.898146+06
4062	10042	1	3	t	2023-07-13 11:13:13.898146+06
4063	10043	1	3	t	2023-07-13 11:13:13.898146+06
4064	10044	1	3	t	2023-07-13 11:13:13.898146+06
4065	10045	1	3	t	2023-07-13 11:13:13.898146+06
4066	10046	1	3	t	2023-07-13 11:13:13.898146+06
4067	10047	1	3	t	2023-07-13 11:13:13.898146+06
4068	10048	1	3	t	2023-07-13 11:13:13.898146+06
4069	10049	1	3	t	2023-07-13 11:13:13.898146+06
4070	10050	1	3	t	2023-07-13 11:13:13.898146+06
4071	10051	1	3	t	2023-07-13 11:13:13.898146+06
4072	10052	1	3	t	2023-07-13 11:13:13.898146+06
4073	10053	1	3	t	2023-07-13 11:13:13.898146+06
4074	10054	1	3	t	2023-07-13 11:13:13.898146+06
4075	10055	1	3	t	2023-07-13 11:13:13.898146+06
4076	10056	1	3	t	2023-07-13 11:13:13.898146+06
4077	10057	1	3	t	2023-07-13 11:13:13.898146+06
4078	10058	1	3	t	2023-07-13 11:13:13.898146+06
4079	10059	1	3	t	2023-07-13 11:13:13.898146+06
4080	10060	1	3	t	2023-07-13 11:13:13.898146+06
4081	10061	1	3	t	2023-07-13 11:13:13.898146+06
4082	10062	1	3	t	2023-07-13 11:13:13.898146+06
4083	10063	1	3	t	2023-07-13 11:13:13.898146+06
4084	10064	1	3	t	2023-07-13 11:13:13.898146+06
4085	10065	1	3	t	2023-07-13 11:13:13.898146+06
4086	10066	1	3	t	2023-07-13 11:13:13.898146+06
4087	10067	1	3	t	2023-07-13 11:13:13.898146+06
4088	10068	1	3	t	2023-07-13 11:13:13.898146+06
4089	10069	1	3	t	2023-07-13 11:13:13.898146+06
4090	10070	1	3	t	2023-07-13 11:13:13.898146+06
4091	10071	1	3	t	2023-07-13 11:13:13.898146+06
4092	10072	1	3	t	2023-07-13 11:13:13.898146+06
4093	10073	1	3	t	2023-07-13 11:13:13.898146+06
4094	10074	1	3	t	2023-07-13 11:13:13.898146+06
4095	10075	1	3	t	2023-07-13 11:13:13.898146+06
4096	10076	1	3	t	2023-07-13 11:13:13.898146+06
4097	10077	1	3	t	2023-07-13 11:13:13.898146+06
4098	10078	1	3	t	2023-07-13 11:13:13.898146+06
4099	10079	1	3	t	2023-07-13 11:13:13.898146+06
4100	10080	1	3	t	2023-07-13 11:13:13.898146+06
4101	10081	1	3	t	2023-07-13 11:13:13.898146+06
4102	10082	1	3	t	2023-07-13 11:13:13.898146+06
4103	10083	1	3	t	2023-07-13 11:13:13.898146+06
4104	10084	1	3	t	2023-07-13 11:13:13.898146+06
4105	10085	1	3	t	2023-07-13 11:13:13.898146+06
4106	10086	1	3	t	2023-07-13 11:13:13.898146+06
4107	10087	1	3	t	2023-07-13 11:13:13.898146+06
4108	10088	1	3	t	2023-07-13 11:13:13.898146+06
4109	10089	1	3	t	2023-07-13 11:13:13.898146+06
4110	10090	1	3	t	2023-07-13 11:13:13.898146+06
4111	10091	1	3	t	2023-07-13 11:13:13.898146+06
4112	10092	1	3	t	2023-07-13 11:13:13.898146+06
4113	10093	1	3	t	2023-07-13 11:13:13.898146+06
4114	10094	1	3	t	2023-07-13 11:13:13.898146+06
4115	10095	1	3	t	2023-07-13 11:13:13.898146+06
4116	10096	1	3	t	2023-07-13 11:13:13.898146+06
4117	10097	1	3	t	2023-07-13 11:13:13.898146+06
4118	10098	1	3	t	2023-07-13 11:13:13.898146+06
4119	10099	1	3	t	2023-07-13 11:13:13.898146+06
4120	10100	1	3	t	2023-07-13 11:13:13.898146+06
4121	10101	1	3	t	2023-07-13 11:13:13.898146+06
4122	10102	1	3	t	2023-07-13 11:13:13.898146+06
4123	10103	1	3	t	2023-07-13 11:13:13.898146+06
4124	10104	1	3	t	2023-07-13 11:13:13.898146+06
4125	10105	1	3	t	2023-07-13 11:13:13.898146+06
4126	10106	1	3	t	2023-07-13 11:13:13.898146+06
4127	10107	1	3	t	2023-07-13 11:13:13.898146+06
4128	10108	1	3	t	2023-07-13 11:13:13.898146+06
4129	10109	1	3	t	2023-07-13 11:13:13.898146+06
4130	10110	1	3	t	2023-07-13 11:13:13.898146+06
4131	10111	1	3	t	2023-07-13 11:13:13.898146+06
4132	10112	1	3	t	2023-07-13 11:13:13.898146+06
4133	10113	1	3	t	2023-07-13 11:13:13.898146+06
4134	10114	1	3	t	2023-07-13 11:13:13.898146+06
4135	10115	1	3	t	2023-07-13 11:13:13.898146+06
4136	10116	1	3	t	2023-07-13 11:13:13.898146+06
4137	10117	1	3	t	2023-07-13 11:13:13.898146+06
4138	10118	1	3	t	2023-07-13 11:13:13.898146+06
4139	10119	1	3	t	2023-07-13 11:13:13.898146+06
4140	10120	1	3	t	2023-07-13 11:13:13.898146+06
4141	10121	1	3	t	2023-07-13 11:13:13.898146+06
4142	10122	1	3	t	2023-07-13 11:13:13.898146+06
4143	10123	1	3	t	2023-07-13 11:13:13.898146+06
4144	10124	1	3	t	2023-07-13 11:13:13.898146+06
4145	10125	1	3	t	2023-07-13 11:13:13.898146+06
4146	10126	1	3	t	2023-07-13 11:13:13.898146+06
4147	10127	1	3	t	2023-07-13 11:13:13.898146+06
4148	10128	1	3	t	2023-07-13 11:13:13.898146+06
4149	10129	1	3	t	2023-07-13 11:13:13.898146+06
4150	10130	1	3	t	2023-07-13 11:13:13.898146+06
4151	10131	1	3	t	2023-07-13 11:13:13.898146+06
4152	10132	1	3	t	2023-07-13 11:13:13.898146+06
4153	10133	1	3	t	2023-07-13 11:13:13.898146+06
4154	10134	1	3	t	2023-07-13 11:13:13.898146+06
4155	10135	1	3	t	2023-07-13 11:13:13.898146+06
4156	10136	1	3	t	2023-07-13 11:13:13.898146+06
4157	10137	1	3	t	2023-07-13 11:13:13.898146+06
4158	10138	1	3	t	2023-07-13 11:13:13.898146+06
4159	10139	1	3	t	2023-07-13 11:13:13.898146+06
4160	10140	1	3	t	2023-07-13 11:13:13.898146+06
4161	10141	1	3	t	2023-07-13 11:13:13.898146+06
4162	10142	1	3	t	2023-07-13 11:13:13.898146+06
4163	10143	1	3	t	2023-07-13 11:13:13.898146+06
4164	10144	1	3	t	2023-07-13 11:13:13.898146+06
4165	10145	1	3	t	2023-07-13 11:13:13.898146+06
4166	10146	1	3	t	2023-07-13 11:13:13.898146+06
4167	10147	1	3	t	2023-07-13 11:13:13.898146+06
4168	10148	1	3	t	2023-07-13 11:13:13.898146+06
4169	10149	1	3	t	2023-07-13 11:13:13.898146+06
4170	10150	1	3	t	2023-07-13 11:13:13.898146+06
4171	10151	1	3	t	2023-07-13 11:13:13.898146+06
4172	10152	1	3	t	2023-07-13 11:13:13.898146+06
4173	10153	1	3	t	2023-07-13 11:13:13.898146+06
4174	10154	1	3	t	2023-07-13 11:13:13.898146+06
4175	10155	1	3	t	2023-07-13 11:13:13.898146+06
4176	10156	1	3	t	2023-07-13 11:13:13.898146+06
4177	10157	1	3	t	2023-07-13 11:13:13.898146+06
4178	10158	1	3	t	2023-07-13 11:13:13.898146+06
4179	10159	1	3	t	2023-07-13 11:13:13.898146+06
4180	10160	1	3	t	2023-07-13 11:13:13.898146+06
4181	10161	1	3	t	2023-07-13 11:13:13.898146+06
4182	10162	1	3	t	2023-07-13 11:13:13.898146+06
4183	10163	1	3	t	2023-07-13 11:13:13.898146+06
4184	10164	1	3	t	2023-07-13 11:13:13.898146+06
4185	10165	1	3	t	2023-07-13 11:13:13.898146+06
4186	10166	1	3	t	2023-07-13 11:13:13.898146+06
4187	10167	1	3	t	2023-07-13 11:13:13.898146+06
4188	10168	1	3	t	2023-07-13 11:13:13.898146+06
4189	10169	1	3	t	2023-07-13 11:13:13.898146+06
4190	10170	1	3	t	2023-07-13 11:13:13.898146+06
4191	10171	1	3	t	2023-07-13 11:13:13.898146+06
4192	10172	1	3	t	2023-07-13 11:13:13.898146+06
4193	10173	1	3	t	2023-07-13 11:13:13.898146+06
4194	10174	1	3	t	2023-07-13 11:13:13.898146+06
4195	10175	1	3	t	2023-07-13 11:13:13.898146+06
4196	10176	1	3	t	2023-07-13 11:13:13.898146+06
4197	10177	1	3	t	2023-07-13 11:13:13.898146+06
4198	10178	1	3	t	2023-07-13 11:13:13.898146+06
4199	10179	1	3	t	2023-07-13 11:13:13.898146+06
4200	10180	1	3	t	2023-07-13 11:13:13.898146+06
4201	10181	1	3	t	2023-07-13 11:13:13.898146+06
4202	10182	1	3	t	2023-07-13 11:13:13.898146+06
4203	10183	1	3	t	2023-07-13 11:13:13.898146+06
4204	10184	1	3	t	2023-07-13 11:13:13.898146+06
4205	10185	1	3	t	2023-07-13 11:13:13.898146+06
4206	10186	1	3	t	2023-07-13 11:13:13.898146+06
4207	10187	1	3	t	2023-07-13 11:13:13.898146+06
4208	10188	1	3	t	2023-07-13 11:13:13.898146+06
4209	10189	1	3	t	2023-07-13 11:13:13.898146+06
4210	10190	1	3	t	2023-07-13 11:13:13.898146+06
4211	10191	1	3	t	2023-07-13 11:13:13.898146+06
4212	10192	1	3	t	2023-07-13 11:13:13.898146+06
4213	10193	1	3	t	2023-07-13 11:13:13.898146+06
4214	10194	1	3	t	2023-07-13 11:13:13.898146+06
4215	10195	1	3	t	2023-07-13 11:13:13.898146+06
4216	10196	1	3	t	2023-07-13 11:13:13.898146+06
4217	10197	1	3	t	2023-07-13 11:13:13.898146+06
4218	10198	1	3	t	2023-07-13 11:13:13.898146+06
4219	10199	1	3	t	2023-07-13 11:13:13.898146+06
4220	10200	1	3	t	2023-07-13 11:13:13.898146+06
4221	10201	1	3	t	2023-07-13 11:13:13.898146+06
4222	10202	1	3	t	2023-07-13 11:13:13.898146+06
4223	10203	1	3	t	2023-07-13 11:13:13.898146+06
4224	10204	1	3	t	2023-07-13 11:13:13.898146+06
4225	10205	1	3	t	2023-07-13 11:13:13.898146+06
4226	10206	1	3	t	2023-07-13 11:13:13.898146+06
4227	10207	1	3	t	2023-07-13 11:13:13.898146+06
4228	10208	1	3	t	2023-07-13 11:13:13.898146+06
4229	10209	1	3	t	2023-07-13 11:13:13.898146+06
4230	10210	1	3	t	2023-07-13 11:13:13.898146+06
4231	10211	1	3	t	2023-07-13 11:13:13.898146+06
4232	10212	1	3	t	2023-07-13 11:13:13.898146+06
4233	10213	1	3	t	2023-07-13 11:13:13.898146+06
4234	10214	1	3	t	2023-07-13 11:13:13.898146+06
4235	10215	1	3	t	2023-07-13 11:13:13.898146+06
4236	10216	1	3	t	2023-07-13 11:13:13.898146+06
4237	10217	1	3	t	2023-07-13 11:13:13.898146+06
4238	10218	1	3	t	2023-07-13 11:13:13.898146+06
4239	10219	1	3	t	2023-07-13 11:13:13.898146+06
4240	10220	1	3	t	2023-07-13 11:13:13.898146+06
4241	10221	1	3	t	2023-07-13 11:13:13.898146+06
4242	10222	1	3	t	2023-07-13 11:13:13.898146+06
4243	10223	1	3	t	2023-07-13 11:13:13.898146+06
4244	10224	1	3	t	2023-07-13 11:13:13.898146+06
4245	10225	1	3	t	2023-07-13 11:13:13.898146+06
4246	10226	1	3	t	2023-07-13 11:13:13.898146+06
4247	10227	1	3	t	2023-07-13 11:13:13.898146+06
4248	10228	1	3	t	2023-07-13 11:13:13.898146+06
4249	10229	1	3	t	2023-07-13 11:13:13.898146+06
4250	10230	1	3	t	2023-07-13 11:13:13.898146+06
4251	10231	1	3	t	2023-07-13 11:13:13.898146+06
4252	10232	1	3	t	2023-07-13 11:13:13.898146+06
4253	10233	1	3	t	2023-07-13 11:13:13.898146+06
4254	10234	1	3	t	2023-07-13 11:13:13.898146+06
4255	10235	1	3	t	2023-07-13 11:13:13.898146+06
4256	10236	1	3	t	2023-07-13 11:13:13.898146+06
4257	10237	1	3	t	2023-07-13 11:13:13.898146+06
4258	10238	1	3	t	2023-07-13 11:13:13.898146+06
4259	10239	1	3	t	2023-07-13 11:13:13.898146+06
4260	10240	1	3	t	2023-07-13 11:13:13.898146+06
4261	10241	1	3	t	2023-07-13 11:13:13.898146+06
4262	10242	1	3	t	2023-07-13 11:13:13.898146+06
4263	10243	1	3	t	2023-07-13 11:13:13.898146+06
4264	10244	1	3	t	2023-07-13 11:13:13.898146+06
4265	10245	1	3	t	2023-07-13 11:13:13.898146+06
4266	10246	1	3	t	2023-07-13 11:13:13.898146+06
4267	10247	1	3	t	2023-07-13 11:13:13.898146+06
4268	10248	1	3	t	2023-07-13 11:13:13.898146+06
4269	10249	1	3	t	2023-07-13 11:13:13.898146+06
4270	10250	1	3	t	2023-07-13 11:13:13.898146+06
4271	10251	1	3	t	2023-07-13 11:13:13.898146+06
4272	10252	1	3	t	2023-07-13 11:13:13.898146+06
4273	10253	1	3	t	2023-07-13 11:13:13.898146+06
4274	10254	1	3	t	2023-07-13 11:13:13.898146+06
4275	10255	1	3	t	2023-07-13 11:13:13.898146+06
4276	10256	1	3	t	2023-07-13 11:13:13.898146+06
4277	10257	1	3	t	2023-07-13 11:13:13.898146+06
4278	10258	1	3	t	2023-07-13 11:13:13.898146+06
4279	10259	1	3	t	2023-07-13 11:13:13.898146+06
4280	10260	1	3	t	2023-07-13 11:13:13.898146+06
4281	10261	1	3	t	2023-07-13 11:13:13.898146+06
4282	10262	1	3	t	2023-07-13 11:13:13.898146+06
4283	10263	1	3	t	2023-07-13 11:13:13.898146+06
4284	10264	1	3	t	2023-07-13 11:13:13.898146+06
4285	10265	1	3	t	2023-07-13 11:13:13.898146+06
4286	10266	1	3	t	2023-07-13 11:13:13.898146+06
4287	10267	1	3	t	2023-07-13 11:13:13.898146+06
4288	10268	1	3	t	2023-07-13 11:13:13.898146+06
4289	10269	1	3	t	2023-07-13 11:13:13.898146+06
4290	10270	1	3	t	2023-07-13 11:13:13.898146+06
4291	10271	1	3	t	2023-07-13 11:13:13.898146+06
4292	10272	1	3	t	2023-07-13 11:13:13.898146+06
4293	10273	1	3	t	2023-07-13 11:13:13.898146+06
4294	10274	1	3	t	2023-07-13 11:13:13.898146+06
4295	10275	1	3	t	2023-07-13 11:13:13.898146+06
4296	10276	1	3	t	2023-07-13 11:13:13.898146+06
4297	10277	1	3	t	2023-07-13 11:13:13.898146+06
4298	10278	1	3	t	2023-07-13 11:13:13.898146+06
4299	10279	1	3	t	2023-07-13 11:13:13.898146+06
4300	10280	1	3	t	2023-07-13 11:13:13.898146+06
4301	10281	1	3	t	2023-07-13 11:13:13.898146+06
4302	10282	1	3	t	2023-07-13 11:13:13.898146+06
4303	10283	1	3	t	2023-07-13 11:13:13.898146+06
4304	10284	1	3	t	2023-07-13 11:13:13.898146+06
4305	10285	1	3	t	2023-07-13 11:13:13.898146+06
4306	10286	1	3	t	2023-07-13 11:13:13.898146+06
4307	10287	1	3	t	2023-07-13 11:13:13.898146+06
4308	10288	1	3	t	2023-07-13 11:13:13.898146+06
4309	10289	1	3	t	2023-07-13 11:13:13.898146+06
4310	10290	1	3	t	2023-07-13 11:13:13.898146+06
4311	10291	1	3	t	2023-07-13 11:13:13.898146+06
4312	10292	1	3	t	2023-07-13 11:13:13.898146+06
4313	10293	1	3	t	2023-07-13 11:13:13.898146+06
4314	10294	1	3	t	2023-07-13 11:13:13.898146+06
4315	10295	1	3	t	2023-07-13 11:13:13.898146+06
4316	10296	1	3	t	2023-07-13 11:13:13.898146+06
4317	10297	1	3	t	2023-07-13 11:13:13.898146+06
4318	10298	1	3	t	2023-07-13 11:13:13.898146+06
4319	10299	1	3	t	2023-07-13 11:13:13.898146+06
4320	10300	1	3	t	2023-07-13 11:13:13.898146+06
4321	10301	1	3	t	2023-07-13 11:13:13.898146+06
4322	10302	1	3	t	2023-07-13 11:13:13.898146+06
4323	10303	1	3	t	2023-07-13 11:13:13.898146+06
4324	10304	1	3	t	2023-07-13 11:13:13.898146+06
4325	10305	1	3	t	2023-07-13 11:13:13.898146+06
4326	10306	1	3	t	2023-07-13 11:13:13.898146+06
4327	10307	1	3	t	2023-07-13 11:13:13.898146+06
4328	10308	1	3	t	2023-07-13 11:13:13.898146+06
4329	10309	1	3	t	2023-07-13 11:13:13.898146+06
4330	10310	1	3	t	2023-07-13 11:13:13.898146+06
4331	10311	1	3	t	2023-07-13 11:13:13.898146+06
4332	10312	1	3	t	2023-07-13 11:13:13.898146+06
4333	10313	1	3	t	2023-07-13 11:13:13.898146+06
4334	10314	1	3	t	2023-07-13 11:13:13.898146+06
4335	10315	1	3	t	2023-07-13 11:13:13.898146+06
4336	10316	1	3	t	2023-07-13 11:13:13.898146+06
4337	10317	1	3	t	2023-07-13 11:13:13.898146+06
4338	10318	1	3	t	2023-07-13 11:13:13.898146+06
4339	10319	1	3	t	2023-07-13 11:13:13.898146+06
4340	10320	1	3	t	2023-07-13 11:13:13.898146+06
4341	10321	1	3	t	2023-07-13 11:13:13.898146+06
4342	10322	1	3	t	2023-07-13 11:13:13.898146+06
4343	10323	1	3	t	2023-07-13 11:13:13.898146+06
4344	10324	1	3	t	2023-07-13 11:13:13.898146+06
4345	10325	1	3	t	2023-07-13 11:13:13.898146+06
4346	10326	1	3	t	2023-07-13 11:13:13.898146+06
4347	10327	1	3	t	2023-07-13 11:13:13.898146+06
4348	10328	1	3	t	2023-07-13 11:13:13.898146+06
4349	10329	1	3	t	2023-07-13 11:13:13.898146+06
4350	10330	1	3	t	2023-07-13 11:13:13.898146+06
4351	10331	1	3	t	2023-07-13 11:13:13.898146+06
4352	10332	1	3	t	2023-07-13 11:13:13.898146+06
4353	10333	1	3	t	2023-07-13 11:13:13.898146+06
4354	10334	1	3	t	2023-07-13 11:13:13.898146+06
4355	10335	1	3	t	2023-07-13 11:13:13.898146+06
4356	10336	1	3	t	2023-07-13 11:13:13.898146+06
4357	10337	1	3	t	2023-07-13 11:13:13.898146+06
4358	10338	1	3	t	2023-07-13 11:13:13.898146+06
4359	10339	1	3	t	2023-07-13 11:13:13.898146+06
4360	10340	1	3	t	2023-07-13 11:13:13.898146+06
4361	10341	1	3	t	2023-07-13 11:13:13.898146+06
4362	10342	1	3	t	2023-07-13 11:13:13.898146+06
4363	10343	1	3	t	2023-07-13 11:13:13.898146+06
4364	10344	1	3	t	2023-07-13 11:13:13.898146+06
4365	10345	1	3	t	2023-07-13 11:13:13.898146+06
4366	10346	1	3	t	2023-07-13 11:13:13.898146+06
4367	10347	1	3	t	2023-07-13 11:13:13.898146+06
4368	10348	1	3	t	2023-07-13 11:13:13.898146+06
4369	10349	1	3	t	2023-07-13 11:13:13.898146+06
4370	10350	1	3	t	2023-07-13 11:13:13.898146+06
4371	10351	1	3	t	2023-07-13 11:13:13.898146+06
4372	10352	1	3	t	2023-07-13 11:13:13.898146+06
4373	10353	1	3	t	2023-07-13 11:13:13.898146+06
4374	10354	1	3	t	2023-07-13 11:13:13.898146+06
4375	10355	1	3	t	2023-07-13 11:13:13.898146+06
4376	10356	1	3	t	2023-07-13 11:13:13.898146+06
4377	10357	1	3	t	2023-07-13 11:13:13.898146+06
4378	10358	1	3	t	2023-07-13 11:13:13.898146+06
4379	10359	1	3	t	2023-07-13 11:13:13.898146+06
4380	10360	1	3	t	2023-07-13 11:13:13.898146+06
4381	10361	1	3	t	2023-07-13 11:13:13.898146+06
4382	10362	1	3	t	2023-07-13 11:13:13.898146+06
4383	10363	1	3	t	2023-07-13 11:13:13.898146+06
4384	10364	1	3	t	2023-07-13 11:13:13.898146+06
4385	10365	1	3	t	2023-07-13 11:13:13.898146+06
4386	10366	1	3	t	2023-07-13 11:13:13.898146+06
4387	10367	1	3	t	2023-07-13 11:13:13.898146+06
4388	10368	1	3	t	2023-07-13 11:13:13.898146+06
4389	10369	1	3	t	2023-07-13 11:13:13.898146+06
4390	10370	1	3	t	2023-07-13 11:13:13.898146+06
4391	10371	1	3	t	2023-07-13 11:13:13.898146+06
4392	10372	1	3	t	2023-07-13 11:13:13.898146+06
4393	10373	1	3	t	2023-07-13 11:13:13.898146+06
4394	10374	1	3	t	2023-07-13 11:13:13.898146+06
4395	10375	1	3	t	2023-07-13 11:13:13.898146+06
4396	10376	1	3	t	2023-07-13 11:13:13.898146+06
4397	10377	1	3	t	2023-07-13 11:13:13.898146+06
4398	10378	1	3	t	2023-07-13 11:13:13.898146+06
4399	10379	1	3	t	2023-07-13 11:13:13.898146+06
4400	10380	1	3	t	2023-07-13 11:13:13.898146+06
4401	10381	1	3	t	2023-07-13 11:13:13.898146+06
4402	10382	1	3	t	2023-07-13 11:13:13.898146+06
4403	10383	1	3	t	2023-07-13 11:13:13.898146+06
4404	10384	1	3	t	2023-07-13 11:13:13.898146+06
4405	10385	1	3	t	2023-07-13 11:13:13.898146+06
4406	10386	1	3	t	2023-07-13 11:13:13.898146+06
4407	10387	1	3	t	2023-07-13 11:13:13.898146+06
4408	10388	1	3	t	2023-07-13 11:13:13.898146+06
4409	10389	1	3	t	2023-07-13 11:13:13.898146+06
4410	10390	1	3	t	2023-07-13 11:13:13.898146+06
4411	10391	1	3	t	2023-07-13 11:13:13.898146+06
4412	10392	1	3	t	2023-07-13 11:13:13.898146+06
4413	10393	1	3	t	2023-07-13 11:13:13.898146+06
4414	10394	1	3	t	2023-07-13 11:13:13.898146+06
4415	10395	1	3	t	2023-07-13 11:13:13.898146+06
4416	10396	1	3	t	2023-07-13 11:13:13.898146+06
4417	10397	1	3	t	2023-07-13 11:13:13.898146+06
4418	10398	1	3	t	2023-07-13 11:13:13.898146+06
4419	10399	1	3	t	2023-07-13 11:13:13.898146+06
4420	10400	1	3	t	2023-07-13 11:13:13.898146+06
4421	10401	1	3	t	2023-07-13 11:13:13.898146+06
4422	10402	1	3	t	2023-07-13 11:13:13.898146+06
4423	10403	1	3	t	2023-07-13 11:13:13.898146+06
4424	10404	1	3	t	2023-07-13 11:13:13.898146+06
4425	10405	1	3	t	2023-07-13 11:13:13.898146+06
4426	10406	1	3	t	2023-07-13 11:13:13.898146+06
4427	10407	1	3	t	2023-07-13 11:13:13.898146+06
4428	10408	1	3	t	2023-07-13 11:13:13.898146+06
4429	10409	1	3	t	2023-07-13 11:13:13.898146+06
4430	10410	1	3	t	2023-07-13 11:13:13.898146+06
4431	10411	1	3	t	2023-07-13 11:13:13.898146+06
4432	10412	1	3	t	2023-07-13 11:13:13.898146+06
4433	10413	1	3	t	2023-07-13 11:13:13.898146+06
4434	10414	1	3	t	2023-07-13 11:13:13.898146+06
4435	10415	1	3	t	2023-07-13 11:13:13.898146+06
4436	10416	1	3	t	2023-07-13 11:13:13.898146+06
4437	10417	1	3	t	2023-07-13 11:13:13.898146+06
4438	10418	1	3	t	2023-07-13 11:13:13.898146+06
4439	10419	1	3	t	2023-07-13 11:13:13.898146+06
4440	10420	1	3	t	2023-07-13 11:13:13.898146+06
4441	10421	1	3	t	2023-07-13 11:13:13.898146+06
4442	10422	1	3	t	2023-07-13 11:13:13.898146+06
4443	10423	1	3	t	2023-07-13 11:13:13.898146+06
4444	10424	1	3	t	2023-07-13 11:13:13.898146+06
4445	10425	1	3	t	2023-07-13 11:13:13.898146+06
4446	10426	1	3	t	2023-07-13 11:13:13.898146+06
4447	10427	1	3	t	2023-07-13 11:13:13.898146+06
4448	10428	1	3	t	2023-07-13 11:13:13.898146+06
4449	10429	1	3	t	2023-07-13 11:13:13.898146+06
4450	10430	1	3	t	2023-07-13 11:13:13.898146+06
4451	10431	1	3	t	2023-07-13 11:13:13.898146+06
4452	10432	1	3	t	2023-07-13 11:13:13.898146+06
4453	10433	1	3	t	2023-07-13 11:13:13.898146+06
4454	10434	1	3	t	2023-07-13 11:13:13.898146+06
4455	10435	1	3	t	2023-07-13 11:13:13.898146+06
4456	10436	1	3	t	2023-07-13 11:13:13.898146+06
4457	10437	1	3	t	2023-07-13 11:13:13.898146+06
4458	10438	1	3	t	2023-07-13 11:13:13.898146+06
4459	10439	1	3	t	2023-07-13 11:13:13.898146+06
4460	10440	1	3	t	2023-07-13 11:13:13.898146+06
4461	10441	1	3	t	2023-07-13 11:13:13.898146+06
4462	10442	1	3	t	2023-07-13 11:13:13.898146+06
4463	10443	1	3	t	2023-07-13 11:13:13.898146+06
4464	10444	1	3	t	2023-07-13 11:13:13.898146+06
4465	10445	1	3	t	2023-07-13 11:13:13.898146+06
4466	10446	1	3	t	2023-07-13 11:13:13.898146+06
4467	10447	1	3	t	2023-07-13 11:13:13.898146+06
4468	10448	1	3	t	2023-07-13 11:13:13.898146+06
4469	10449	1	3	t	2023-07-13 11:13:13.898146+06
4470	10450	1	3	t	2023-07-13 11:13:13.898146+06
4471	10451	1	3	t	2023-07-13 11:13:13.898146+06
4472	10452	1	3	t	2023-07-13 11:13:13.898146+06
4473	10453	1	3	t	2023-07-13 11:13:13.898146+06
4474	10454	1	3	t	2023-07-13 11:13:13.898146+06
4475	10455	1	3	t	2023-07-13 11:13:13.898146+06
4476	10456	1	3	t	2023-07-13 11:13:13.898146+06
4477	10457	1	3	t	2023-07-13 11:13:13.898146+06
4478	10458	1	3	t	2023-07-13 11:13:13.898146+06
4479	10459	1	3	t	2023-07-13 11:13:13.898146+06
4480	10460	1	3	t	2023-07-13 11:13:13.898146+06
4481	10461	1	3	t	2023-07-13 11:13:13.898146+06
4482	10462	1	3	t	2023-07-13 11:13:13.898146+06
4483	10463	1	3	t	2023-07-13 11:13:13.898146+06
4484	10464	1	3	t	2023-07-13 11:13:13.898146+06
4485	10465	1	3	t	2023-07-13 11:13:13.898146+06
4486	10466	1	3	t	2023-07-13 11:13:13.898146+06
4487	10467	1	3	t	2023-07-13 11:13:13.898146+06
4488	10468	1	3	t	2023-07-13 11:13:13.898146+06
4489	10469	1	3	t	2023-07-13 11:13:13.898146+06
4490	10470	1	3	t	2023-07-13 11:13:13.898146+06
4491	10471	1	3	t	2023-07-13 11:13:13.898146+06
4492	10472	1	3	t	2023-07-13 11:13:13.898146+06
4493	10473	1	3	t	2023-07-13 11:13:13.898146+06
4494	10474	1	3	t	2023-07-13 11:13:13.898146+06
4495	10475	1	3	t	2023-07-13 11:13:13.898146+06
4496	10476	1	3	t	2023-07-13 11:13:13.898146+06
4497	10477	1	3	t	2023-07-13 11:13:13.898146+06
4498	10478	1	3	t	2023-07-13 11:13:13.898146+06
4499	10479	1	3	t	2023-07-13 11:13:13.898146+06
4500	10480	1	3	t	2023-07-13 11:13:13.898146+06
4501	10481	1	3	t	2023-07-13 11:13:13.898146+06
4502	10482	1	3	t	2023-07-13 11:13:13.898146+06
4503	10483	1	3	t	2023-07-13 11:13:13.898146+06
4504	10484	1	3	t	2023-07-13 11:13:13.898146+06
4505	10485	1	3	t	2023-07-13 11:13:13.898146+06
4506	10486	1	3	t	2023-07-13 11:13:13.898146+06
4507	10487	1	3	t	2023-07-13 11:13:13.898146+06
4508	10488	1	3	t	2023-07-13 11:13:13.898146+06
4509	10489	1	3	t	2023-07-13 11:13:13.898146+06
4510	10490	1	3	t	2023-07-13 11:13:13.898146+06
4511	10491	1	3	t	2023-07-13 11:13:13.898146+06
4512	10492	1	3	t	2023-07-13 11:13:13.898146+06
4513	10493	1	3	t	2023-07-13 11:13:13.898146+06
4514	10494	1	3	t	2023-07-13 11:13:13.898146+06
4515	10495	1	3	t	2023-07-13 11:13:13.898146+06
4516	10496	1	3	t	2023-07-13 11:13:13.898146+06
4517	10497	1	3	t	2023-07-13 11:13:13.898146+06
4518	10498	1	3	t	2023-07-13 11:13:13.898146+06
4519	10499	1	3	t	2023-07-13 11:13:13.898146+06
4520	10500	1	3	t	2023-07-13 11:13:13.898146+06
4521	10501	1	3	t	2023-07-13 11:13:13.898146+06
4522	10502	1	3	t	2023-07-13 11:13:13.898146+06
4523	10503	1	3	t	2023-07-13 11:13:13.898146+06
4524	10504	1	3	t	2023-07-13 11:13:13.898146+06
4525	10505	1	3	t	2023-07-13 11:13:13.898146+06
4526	10506	1	3	t	2023-07-13 11:13:13.898146+06
4527	10507	1	3	t	2023-07-13 11:13:13.898146+06
4528	10508	1	3	t	2023-07-13 11:13:13.898146+06
4529	10509	1	3	t	2023-07-13 11:13:13.898146+06
4530	10510	1	3	t	2023-07-13 11:13:13.898146+06
4531	10511	1	3	t	2023-07-13 11:13:13.898146+06
4532	10512	1	3	t	2023-07-13 11:13:13.898146+06
4533	10513	1	3	t	2023-07-13 11:13:13.898146+06
4534	10514	1	3	t	2023-07-13 11:13:13.898146+06
4535	10515	1	3	t	2023-07-13 11:13:13.898146+06
4536	10516	1	3	t	2023-07-13 11:13:13.898146+06
4537	10517	1	3	t	2023-07-13 11:13:13.898146+06
4538	10518	1	3	t	2023-07-13 11:13:13.898146+06
4539	10519	1	3	t	2023-07-13 11:13:13.898146+06
4540	10520	1	3	t	2023-07-13 11:13:13.898146+06
4541	10521	1	3	t	2023-07-13 11:13:13.898146+06
4542	10522	1	3	t	2023-07-13 11:13:13.898146+06
4543	10523	1	3	t	2023-07-13 11:13:13.898146+06
4544	10524	1	3	t	2023-07-13 11:13:13.898146+06
4545	10525	1	3	t	2023-07-13 11:13:13.898146+06
4546	10526	1	3	t	2023-07-13 11:13:13.898146+06
4547	10527	1	3	t	2023-07-13 11:13:13.898146+06
4548	10528	1	3	t	2023-07-13 11:13:13.898146+06
4549	10529	1	3	t	2023-07-13 11:13:13.898146+06
4550	10530	1	3	t	2023-07-13 11:13:13.898146+06
4551	10531	1	3	t	2023-07-13 11:13:13.898146+06
4552	10532	1	3	t	2023-07-13 11:13:13.898146+06
4553	10533	1	3	t	2023-07-13 11:13:13.898146+06
4554	10534	1	3	t	2023-07-13 11:13:13.898146+06
4555	10535	1	3	t	2023-07-13 11:13:13.898146+06
4556	10536	1	3	t	2023-07-13 11:13:13.898146+06
4557	10537	1	3	t	2023-07-13 11:13:13.898146+06
4558	10538	1	3	t	2023-07-13 11:13:13.898146+06
4559	10539	1	3	t	2023-07-13 11:13:13.898146+06
4560	10540	1	3	t	2023-07-13 11:13:13.898146+06
4561	10541	1	3	t	2023-07-13 11:13:13.898146+06
4562	10542	1	3	t	2023-07-13 11:13:13.898146+06
4563	10543	1	3	t	2023-07-13 11:13:13.898146+06
4564	10544	1	3	t	2023-07-13 11:13:13.898146+06
4565	10545	1	3	t	2023-07-13 11:13:13.898146+06
4566	10546	1	3	t	2023-07-13 11:13:13.898146+06
4567	10547	1	3	t	2023-07-13 11:13:13.898146+06
4568	10548	1	3	t	2023-07-13 11:13:13.898146+06
4569	10549	1	3	t	2023-07-13 11:13:13.898146+06
4570	10550	1	3	t	2023-07-13 11:13:13.898146+06
4571	10551	1	3	t	2023-07-13 11:13:13.898146+06
4572	10552	1	3	t	2023-07-13 11:13:13.898146+06
4573	10553	1	3	t	2023-07-13 11:13:13.898146+06
4574	10554	1	3	t	2023-07-13 11:13:13.898146+06
4575	10555	1	3	t	2023-07-13 11:13:13.898146+06
4576	10556	1	3	t	2023-07-13 11:13:13.898146+06
4577	10557	1	3	t	2023-07-13 11:13:13.898146+06
4578	10558	1	3	t	2023-07-13 11:13:13.898146+06
4579	10559	1	3	t	2023-07-13 11:13:13.898146+06
4580	10560	1	3	t	2023-07-13 11:13:13.898146+06
4581	10561	1	3	t	2023-07-13 11:13:13.898146+06
4582	10562	1	3	t	2023-07-13 11:13:13.898146+06
4583	10563	1	3	t	2023-07-13 11:13:13.898146+06
4584	10564	1	3	t	2023-07-13 11:13:13.898146+06
4585	10565	1	3	t	2023-07-13 11:13:13.898146+06
4586	10566	1	3	t	2023-07-13 11:13:13.898146+06
4587	10567	1	3	t	2023-07-13 11:13:13.898146+06
4588	10568	1	3	t	2023-07-13 11:13:13.898146+06
4589	10569	1	3	t	2023-07-13 11:13:13.898146+06
4590	10570	1	3	t	2023-07-13 11:13:13.898146+06
4591	10571	1	3	t	2023-07-13 11:13:13.898146+06
4592	10572	1	3	t	2023-07-13 11:13:13.898146+06
4593	10573	1	3	t	2023-07-13 11:13:13.898146+06
4594	10574	1	3	t	2023-07-13 11:13:13.898146+06
4595	10575	1	3	t	2023-07-13 11:13:13.898146+06
4596	10576	1	3	t	2023-07-13 11:13:13.898146+06
4597	10577	1	3	t	2023-07-13 11:13:13.898146+06
4598	10578	1	3	t	2023-07-13 11:13:13.898146+06
4599	10579	1	3	t	2023-07-13 11:13:13.898146+06
4600	10580	1	3	t	2023-07-13 11:13:13.898146+06
4601	10581	1	3	t	2023-07-13 11:13:13.898146+06
4602	10582	1	3	t	2023-07-13 11:13:13.898146+06
4603	10583	1	3	t	2023-07-13 11:13:13.898146+06
4604	10584	1	3	t	2023-07-13 11:13:13.898146+06
4605	10585	1	3	t	2023-07-13 11:13:13.898146+06
4606	10586	1	3	t	2023-07-13 11:13:13.898146+06
4607	10587	1	3	t	2023-07-13 11:13:13.898146+06
4608	10588	1	3	t	2023-07-13 11:13:13.898146+06
4609	10589	1	3	t	2023-07-13 11:13:13.898146+06
4610	10590	1	3	t	2023-07-13 11:13:13.898146+06
4611	10591	1	3	t	2023-07-13 11:13:13.898146+06
4612	10592	1	3	t	2023-07-13 11:13:13.898146+06
4613	10593	1	3	t	2023-07-13 11:13:13.898146+06
4614	10594	1	3	t	2023-07-13 11:13:13.898146+06
4615	10595	1	3	t	2023-07-13 11:13:13.898146+06
4616	10596	1	3	t	2023-07-13 11:13:13.898146+06
4617	10597	1	3	t	2023-07-13 11:13:13.898146+06
4618	10598	1	3	t	2023-07-13 11:13:13.898146+06
4619	10599	1	3	t	2023-07-13 11:13:13.898146+06
4620	10600	1	3	t	2023-07-13 11:13:13.898146+06
4621	10601	1	3	t	2023-07-13 11:13:13.898146+06
4622	10602	1	3	t	2023-07-13 11:13:13.898146+06
4623	10603	1	3	t	2023-07-13 11:13:13.898146+06
4624	10604	1	3	t	2023-07-13 11:13:13.898146+06
4625	10605	1	3	t	2023-07-13 11:13:13.898146+06
4626	10606	1	3	t	2023-07-13 11:13:13.898146+06
4627	10607	1	3	t	2023-07-13 11:13:13.898146+06
4628	10608	1	3	t	2023-07-13 11:13:13.898146+06
4629	10609	1	3	t	2023-07-13 11:13:13.898146+06
4630	10610	1	3	t	2023-07-13 11:13:13.898146+06
4631	10611	1	3	t	2023-07-13 11:13:13.898146+06
4632	10612	1	3	t	2023-07-13 11:13:13.898146+06
4633	10613	1	3	t	2023-07-13 11:13:13.898146+06
4634	10614	1	3	t	2023-07-13 11:13:13.898146+06
4635	10615	1	3	t	2023-07-13 11:13:13.898146+06
4636	10616	1	3	t	2023-07-13 11:13:13.898146+06
4637	10617	1	3	t	2023-07-13 11:13:13.898146+06
4638	10618	1	3	t	2023-07-13 11:13:13.898146+06
4639	10619	1	3	t	2023-07-13 11:13:13.898146+06
4640	10620	1	3	t	2023-07-13 11:13:13.898146+06
4641	10621	1	3	t	2023-07-13 11:13:13.898146+06
4642	10622	1	3	t	2023-07-13 11:13:13.898146+06
4643	10623	1	3	t	2023-07-13 11:13:13.898146+06
4644	10624	1	3	t	2023-07-13 11:13:13.898146+06
4645	10625	1	3	t	2023-07-13 11:13:13.898146+06
4646	10626	1	3	t	2023-07-13 11:13:13.898146+06
4647	10627	1	3	t	2023-07-13 11:13:13.898146+06
4648	10628	1	3	t	2023-07-13 11:13:13.898146+06
4649	10629	1	3	t	2023-07-13 11:13:13.898146+06
4650	10630	1	3	t	2023-07-13 11:13:13.898146+06
4651	10631	1	3	t	2023-07-13 11:13:13.898146+06
4652	10632	1	3	t	2023-07-13 11:13:13.898146+06
4653	10633	1	3	t	2023-07-13 11:13:13.898146+06
4654	10634	1	3	t	2023-07-13 11:13:13.898146+06
4655	10635	1	3	t	2023-07-13 11:13:13.898146+06
4656	10636	1	3	t	2023-07-13 11:13:13.898146+06
4657	10637	1	3	t	2023-07-13 11:13:13.898146+06
4658	10638	1	3	t	2023-07-13 11:13:13.898146+06
4659	10639	1	3	t	2023-07-13 11:13:13.898146+06
4660	10640	1	3	t	2023-07-13 11:13:13.898146+06
4661	10641	1	3	t	2023-07-13 11:13:13.898146+06
4662	10642	1	3	t	2023-07-13 11:13:13.898146+06
4663	10643	1	3	t	2023-07-13 11:13:13.898146+06
4664	10644	1	3	t	2023-07-13 11:13:13.898146+06
4665	10645	1	3	t	2023-07-13 11:13:13.898146+06
4666	10646	1	3	t	2023-07-13 11:13:13.898146+06
4667	10647	1	3	t	2023-07-13 11:13:13.898146+06
4668	10648	1	3	t	2023-07-13 11:13:13.898146+06
4669	10649	1	3	t	2023-07-13 11:13:13.898146+06
4670	10650	1	3	t	2023-07-13 11:13:13.898146+06
4671	10651	1	3	t	2023-07-13 11:13:13.898146+06
4672	10652	1	3	t	2023-07-13 11:13:13.898146+06
4673	10653	1	3	t	2023-07-13 11:13:13.898146+06
4674	10654	1	3	t	2023-07-13 11:13:13.898146+06
4675	10655	1	3	t	2023-07-13 11:13:13.898146+06
4676	10656	1	3	t	2023-07-13 11:13:13.898146+06
4677	10657	1	3	t	2023-07-13 11:13:13.898146+06
4678	10658	1	3	t	2023-07-13 11:13:13.898146+06
4679	10659	1	3	t	2023-07-13 11:13:13.898146+06
4680	10660	1	3	t	2023-07-13 11:13:13.898146+06
4681	10661	1	3	t	2023-07-13 11:13:13.898146+06
4682	10662	1	3	t	2023-07-13 11:13:13.898146+06
4683	10663	1	3	t	2023-07-13 11:13:13.898146+06
4684	10664	1	3	t	2023-07-13 11:13:13.898146+06
4685	10665	1	3	t	2023-07-13 11:13:13.898146+06
4686	10666	1	3	t	2023-07-13 11:13:13.898146+06
4687	10667	1	3	t	2023-07-13 11:13:13.898146+06
4688	10668	1	3	t	2023-07-13 11:13:13.898146+06
4689	10669	1	3	t	2023-07-13 11:13:13.898146+06
4690	10670	1	3	t	2023-07-13 11:13:13.898146+06
4691	10671	1	3	t	2023-07-13 11:13:13.898146+06
4692	10672	1	3	t	2023-07-13 11:13:13.898146+06
4693	10673	1	3	t	2023-07-13 11:13:13.898146+06
4694	10674	1	3	t	2023-07-13 11:13:13.898146+06
4695	10675	1	3	t	2023-07-13 11:13:13.898146+06
4696	10676	1	3	t	2023-07-13 11:13:13.898146+06
4697	10677	1	3	t	2023-07-13 11:13:13.898146+06
4698	10678	1	3	t	2023-07-13 11:13:13.898146+06
4699	10679	1	3	t	2023-07-13 11:13:13.898146+06
4700	10680	1	3	t	2023-07-13 11:13:13.898146+06
4701	10681	1	3	t	2023-07-13 11:13:13.898146+06
4702	10682	1	3	t	2023-07-13 11:13:13.898146+06
4703	10683	1	3	t	2023-07-13 11:13:13.898146+06
4704	10684	1	3	t	2023-07-13 11:13:13.898146+06
4705	10685	1	3	t	2023-07-13 11:13:13.898146+06
4706	10686	1	3	t	2023-07-13 11:13:13.898146+06
4707	10687	1	3	t	2023-07-13 11:13:13.898146+06
4708	10688	1	3	t	2023-07-13 11:13:13.898146+06
4709	10689	1	3	t	2023-07-13 11:13:13.898146+06
4710	10690	1	3	t	2023-07-13 11:13:13.898146+06
4711	10691	1	3	t	2023-07-13 11:13:13.898146+06
4712	10692	1	3	t	2023-07-13 11:13:13.898146+06
4713	10693	1	3	t	2023-07-13 11:13:13.898146+06
4714	10694	1	3	t	2023-07-13 11:13:13.898146+06
4715	10695	1	3	t	2023-07-13 11:13:13.898146+06
4716	10696	1	3	t	2023-07-13 11:13:13.898146+06
4717	10697	1	3	t	2023-07-13 11:13:13.898146+06
4718	10698	1	3	t	2023-07-13 11:13:13.898146+06
4719	10699	1	3	t	2023-07-13 11:13:13.898146+06
4720	10700	1	3	t	2023-07-13 11:13:13.898146+06
4721	10701	1	3	t	2023-07-13 11:13:13.898146+06
4722	10702	1	3	t	2023-07-13 11:13:13.898146+06
4723	10703	1	3	t	2023-07-13 11:13:13.898146+06
4724	10704	1	3	t	2023-07-13 11:13:13.898146+06
4725	10705	1	3	t	2023-07-13 11:13:13.898146+06
4726	10706	1	3	t	2023-07-13 11:13:13.898146+06
4727	10707	1	3	t	2023-07-13 11:13:13.898146+06
4728	10708	1	3	t	2023-07-13 11:13:13.898146+06
4729	10709	1	3	t	2023-07-13 11:13:13.898146+06
4730	10710	1	3	t	2023-07-13 11:13:13.898146+06
4731	10711	1	3	t	2023-07-13 11:13:13.898146+06
4732	10712	1	3	t	2023-07-13 11:13:13.898146+06
4733	10713	1	3	t	2023-07-13 11:13:13.898146+06
4734	10714	1	3	t	2023-07-13 11:13:13.898146+06
4735	10715	1	3	t	2023-07-13 11:13:13.898146+06
4736	10716	1	3	t	2023-07-13 11:13:13.898146+06
4737	10717	1	3	t	2023-07-13 11:13:13.898146+06
4738	10718	1	3	t	2023-07-13 11:13:13.898146+06
4739	10719	1	3	t	2023-07-13 11:13:13.898146+06
4740	10720	1	3	t	2023-07-13 11:13:13.898146+06
4741	10721	1	3	t	2023-07-13 11:13:13.898146+06
4742	10722	1	3	t	2023-07-13 11:13:13.898146+06
4743	10723	1	3	t	2023-07-13 11:13:13.898146+06
4744	10724	1	3	t	2023-07-13 11:13:13.898146+06
4745	10725	1	3	t	2023-07-13 11:13:13.898146+06
4746	10726	1	3	t	2023-07-13 11:13:13.898146+06
4747	10727	1	3	t	2023-07-13 11:13:13.898146+06
4748	10728	1	3	t	2023-07-13 11:13:13.898146+06
4749	10729	1	3	t	2023-07-13 11:13:13.898146+06
4750	10730	1	3	t	2023-07-13 11:13:13.898146+06
4751	10731	1	3	t	2023-07-13 11:13:13.898146+06
4752	10732	1	3	t	2023-07-13 11:13:13.898146+06
4753	10733	1	3	t	2023-07-13 11:13:13.898146+06
4754	10734	1	3	t	2023-07-13 11:13:13.898146+06
4755	10735	1	3	t	2023-07-13 11:13:13.898146+06
4756	10736	1	3	t	2023-07-13 11:13:13.898146+06
4757	10737	1	3	t	2023-07-13 11:13:13.898146+06
4758	10738	1	3	t	2023-07-13 11:13:13.898146+06
4759	10739	1	3	t	2023-07-13 11:13:13.898146+06
4760	10740	1	3	t	2023-07-13 11:13:13.898146+06
4761	10741	1	3	t	2023-07-13 11:13:13.898146+06
4762	10742	1	3	t	2023-07-13 11:13:13.898146+06
4763	10743	1	3	t	2023-07-13 11:13:13.898146+06
4764	10744	1	3	t	2023-07-13 11:13:13.898146+06
4765	10745	1	3	t	2023-07-13 11:13:13.898146+06
4766	10746	1	3	t	2023-07-13 11:13:13.898146+06
4767	10747	1	3	t	2023-07-13 11:13:13.898146+06
4768	10748	1	3	t	2023-07-13 11:13:13.898146+06
4769	10749	1	3	t	2023-07-13 11:13:13.898146+06
4770	10750	1	3	t	2023-07-13 11:13:13.898146+06
4771	10751	1	3	t	2023-07-13 11:13:13.898146+06
4772	10752	1	3	t	2023-07-13 11:13:13.898146+06
4773	10753	1	3	t	2023-07-13 11:13:13.898146+06
4774	10754	1	3	t	2023-07-13 11:13:13.898146+06
4775	10755	1	3	t	2023-07-13 11:13:13.898146+06
4776	10756	1	3	t	2023-07-13 11:13:13.898146+06
4777	10757	1	3	t	2023-07-13 11:13:13.898146+06
4778	10758	1	3	t	2023-07-13 11:13:13.898146+06
4779	10759	1	3	t	2023-07-13 11:13:13.898146+06
4780	10760	1	3	t	2023-07-13 11:13:13.898146+06
4781	10761	1	3	t	2023-07-13 11:13:13.898146+06
4782	10762	1	3	t	2023-07-13 11:13:13.898146+06
4783	10763	1	3	t	2023-07-13 11:13:13.898146+06
4784	10764	1	3	t	2023-07-13 11:13:13.898146+06
4785	10765	1	3	t	2023-07-13 11:13:13.898146+06
4786	10766	1	3	t	2023-07-13 11:13:13.898146+06
4787	10767	1	3	t	2023-07-13 11:13:13.898146+06
4788	10768	1	3	t	2023-07-13 11:13:13.898146+06
4789	10769	1	3	t	2023-07-13 11:13:13.898146+06
4790	10770	1	3	t	2023-07-13 11:13:13.898146+06
4791	10771	1	3	t	2023-07-13 11:13:13.898146+06
4792	10772	1	3	t	2023-07-13 11:13:13.898146+06
4793	10773	1	3	t	2023-07-13 11:13:13.898146+06
4794	10774	1	3	t	2023-07-13 11:13:13.898146+06
4795	10775	1	3	t	2023-07-13 11:13:13.898146+06
4796	10776	1	3	t	2023-07-13 11:13:13.898146+06
4797	10777	1	3	t	2023-07-13 11:13:13.898146+06
4798	10778	1	3	t	2023-07-13 11:13:13.898146+06
4799	10779	1	3	t	2023-07-13 11:13:13.898146+06
4800	10780	1	3	t	2023-07-13 11:13:13.898146+06
4801	10781	1	3	t	2023-07-13 11:13:13.898146+06
4802	10782	1	3	t	2023-07-13 11:13:13.898146+06
4803	10783	1	3	t	2023-07-13 11:13:13.898146+06
4804	10784	1	3	t	2023-07-13 11:13:13.898146+06
4805	10785	1	3	t	2023-07-13 11:13:13.898146+06
4806	10786	1	3	t	2023-07-13 11:13:13.898146+06
4807	10787	1	3	t	2023-07-13 11:13:13.898146+06
4808	10788	1	3	t	2023-07-13 11:13:13.898146+06
4809	10789	1	3	t	2023-07-13 11:13:13.898146+06
4810	10790	1	3	t	2023-07-13 11:13:13.898146+06
4811	10791	1	3	t	2023-07-13 11:13:13.898146+06
4812	10792	1	3	t	2023-07-13 11:13:13.898146+06
4813	10793	1	3	t	2023-07-13 11:13:13.898146+06
4814	10794	1	3	t	2023-07-13 11:13:13.898146+06
4815	10795	1	3	t	2023-07-13 11:13:13.898146+06
4816	10796	1	3	t	2023-07-13 11:13:13.898146+06
4817	10797	1	3	t	2023-07-13 11:13:13.898146+06
4818	10798	1	3	t	2023-07-13 11:13:13.898146+06
4819	10799	1	3	t	2023-07-13 11:13:13.898146+06
4820	10800	1	3	t	2023-07-13 11:13:13.898146+06
4821	10801	1	3	t	2023-07-13 11:13:13.898146+06
4822	10802	1	3	t	2023-07-13 11:13:13.898146+06
4823	10803	1	3	t	2023-07-13 11:13:13.898146+06
4824	10804	1	3	t	2023-07-13 11:13:13.898146+06
4825	10805	1	3	t	2023-07-13 11:13:13.898146+06
4826	10806	1	3	t	2023-07-13 11:13:13.898146+06
4827	10807	1	3	t	2023-07-13 11:13:13.898146+06
4828	10808	1	3	t	2023-07-13 11:13:13.898146+06
4829	10809	1	3	t	2023-07-13 11:13:13.898146+06
4830	10810	1	3	t	2023-07-13 11:13:13.898146+06
4831	10811	1	3	t	2023-07-13 11:13:13.898146+06
4832	10812	1	3	t	2023-07-13 11:13:13.898146+06
4833	10813	1	3	t	2023-07-13 11:13:13.898146+06
4834	10814	1	3	t	2023-07-13 11:13:13.898146+06
4835	10815	1	3	t	2023-07-13 11:13:13.898146+06
4836	10816	1	3	t	2023-07-13 11:13:13.898146+06
4837	10817	1	3	t	2023-07-13 11:13:13.898146+06
4838	10818	1	3	t	2023-07-13 11:13:13.898146+06
4839	10819	1	3	t	2023-07-13 11:13:13.898146+06
4840	10820	1	3	t	2023-07-13 11:13:13.898146+06
4841	10821	1	3	t	2023-07-13 11:13:13.898146+06
4842	10822	1	3	t	2023-07-13 11:13:13.898146+06
4843	10823	1	3	t	2023-07-13 11:13:13.898146+06
4844	10824	1	3	t	2023-07-13 11:13:13.898146+06
4845	10825	1	3	t	2023-07-13 11:13:13.898146+06
4846	10826	1	3	t	2023-07-13 11:13:13.898146+06
4847	10827	1	3	t	2023-07-13 11:13:13.898146+06
4848	10828	1	3	t	2023-07-13 11:13:13.898146+06
4849	10829	1	3	t	2023-07-13 11:13:13.898146+06
4850	10830	1	3	t	2023-07-13 11:13:13.898146+06
4851	10831	1	3	t	2023-07-13 11:13:13.898146+06
4852	10832	1	3	t	2023-07-13 11:13:13.898146+06
4853	10833	1	3	t	2023-07-13 11:13:13.898146+06
4854	10834	1	3	t	2023-07-13 11:13:13.898146+06
4855	10835	1	3	t	2023-07-13 11:13:13.898146+06
4856	10836	1	3	t	2023-07-13 11:13:13.898146+06
4857	10837	1	3	t	2023-07-13 11:13:13.898146+06
4858	10838	1	3	t	2023-07-13 11:13:13.898146+06
4859	10839	1	3	t	2023-07-13 11:13:13.898146+06
4860	10840	1	3	t	2023-07-13 11:13:13.898146+06
4861	10841	1	3	t	2023-07-13 11:13:13.898146+06
4862	10842	1	3	t	2023-07-13 11:13:13.898146+06
4863	10843	1	3	t	2023-07-13 11:13:13.898146+06
4864	10844	1	3	t	2023-07-13 11:13:13.898146+06
4865	10845	1	3	t	2023-07-13 11:13:13.898146+06
4866	10846	1	3	t	2023-07-13 11:13:13.898146+06
4867	10847	1	3	t	2023-07-13 11:13:13.898146+06
4868	10848	1	3	t	2023-07-13 11:13:13.898146+06
4869	10849	1	3	t	2023-07-13 11:13:13.898146+06
4870	10850	1	3	t	2023-07-13 11:13:13.898146+06
4871	10851	1	3	t	2023-07-13 11:13:13.898146+06
4872	10852	1	3	t	2023-07-13 11:13:13.898146+06
4873	10853	1	3	t	2023-07-13 11:13:13.898146+06
4874	10854	1	3	t	2023-07-13 11:13:13.898146+06
4875	10855	1	3	t	2023-07-13 11:13:13.898146+06
4876	10856	1	3	t	2023-07-13 11:13:13.898146+06
4877	10857	1	3	t	2023-07-13 11:13:13.898146+06
4878	10858	1	3	t	2023-07-13 11:13:13.898146+06
4879	10859	1	3	t	2023-07-13 11:13:13.898146+06
4880	10860	1	3	t	2023-07-13 11:13:13.898146+06
4881	10861	1	3	t	2023-07-13 11:13:13.898146+06
4882	10862	1	3	t	2023-07-13 11:13:13.898146+06
4883	10863	1	3	t	2023-07-13 11:13:13.898146+06
4884	10864	1	3	t	2023-07-13 11:13:13.898146+06
4885	10865	1	3	t	2023-07-13 11:13:13.898146+06
4886	10866	1	3	t	2023-07-13 11:13:13.898146+06
4887	10867	1	3	t	2023-07-13 11:13:13.898146+06
4888	10868	1	3	t	2023-07-13 11:13:13.898146+06
4889	10869	1	3	t	2023-07-13 11:13:13.898146+06
4890	10870	1	3	t	2023-07-13 11:13:13.898146+06
4891	10871	1	3	t	2023-07-13 11:13:13.898146+06
4892	10872	1	3	t	2023-07-13 11:13:13.898146+06
4893	10873	1	3	t	2023-07-13 11:13:13.898146+06
4894	10874	1	3	t	2023-07-13 11:13:13.898146+06
4895	10875	1	3	t	2023-07-13 11:13:13.898146+06
4896	10876	1	3	t	2023-07-13 11:13:13.898146+06
4897	10877	1	3	t	2023-07-13 11:13:13.898146+06
4898	10878	1	3	t	2023-07-13 11:13:13.898146+06
4899	10879	1	3	t	2023-07-13 11:13:13.898146+06
4900	10880	1	3	t	2023-07-13 11:13:13.898146+06
4901	10881	1	3	t	2023-07-13 11:13:13.898146+06
4902	10882	1	3	t	2023-07-13 11:13:13.898146+06
4903	10883	1	3	t	2023-07-13 11:13:13.898146+06
4904	10884	1	3	t	2023-07-13 11:13:13.898146+06
4905	10885	1	3	t	2023-07-13 11:13:13.898146+06
4906	10886	1	3	t	2023-07-13 11:13:13.898146+06
4907	10887	1	3	t	2023-07-13 11:13:13.898146+06
4908	10888	1	3	t	2023-07-13 11:13:13.898146+06
4909	10889	1	3	t	2023-07-13 11:13:13.898146+06
4910	10890	1	3	t	2023-07-13 11:13:13.898146+06
4911	10891	1	3	t	2023-07-13 11:13:13.898146+06
4912	10892	1	3	t	2023-07-13 11:13:13.898146+06
4913	10893	1	3	t	2023-07-13 11:13:13.898146+06
4914	10894	1	3	t	2023-07-13 11:13:13.898146+06
4915	10895	1	3	t	2023-07-13 11:13:13.898146+06
4916	10896	1	3	t	2023-07-13 11:13:13.898146+06
4917	10897	1	3	t	2023-07-13 11:13:13.898146+06
4918	10898	1	3	t	2023-07-13 11:13:13.898146+06
4919	10899	1	3	t	2023-07-13 11:13:13.898146+06
4920	10900	1	3	t	2023-07-13 11:13:13.898146+06
4921	10901	1	3	t	2023-07-13 11:13:13.898146+06
4922	10902	1	3	t	2023-07-13 11:13:13.898146+06
4923	10903	1	3	t	2023-07-13 11:13:13.898146+06
4924	10904	1	3	t	2023-07-13 11:13:13.898146+06
4925	10905	1	3	t	2023-07-13 11:13:13.898146+06
4926	10906	1	3	t	2023-07-13 11:13:13.898146+06
4927	10907	1	3	t	2023-07-13 11:13:13.898146+06
4928	10908	1	3	t	2023-07-13 11:13:13.898146+06
4929	10909	1	3	t	2023-07-13 11:13:13.898146+06
4930	10910	1	3	t	2023-07-13 11:13:13.898146+06
4931	10911	1	3	t	2023-07-13 11:13:13.898146+06
4932	10912	1	3	t	2023-07-13 11:13:13.898146+06
4933	10913	1	3	t	2023-07-13 11:13:13.898146+06
4934	10914	1	3	t	2023-07-13 11:13:13.898146+06
4935	10915	1	3	t	2023-07-13 11:13:13.898146+06
4936	10916	1	3	t	2023-07-13 11:13:13.898146+06
4937	10917	1	3	t	2023-07-13 11:13:13.898146+06
4938	10918	1	3	t	2023-07-13 11:13:13.898146+06
4939	10919	1	3	t	2023-07-13 11:13:13.898146+06
4940	10920	1	3	t	2023-07-13 11:13:13.898146+06
4941	10921	1	3	t	2023-07-13 11:13:13.898146+06
4942	10922	1	3	t	2023-07-13 11:13:13.898146+06
4943	10923	1	3	t	2023-07-13 11:13:13.898146+06
4944	10924	1	3	t	2023-07-13 11:13:13.898146+06
4945	10925	1	3	t	2023-07-13 11:13:13.898146+06
4946	10926	1	3	t	2023-07-13 11:13:13.898146+06
4947	10927	1	3	t	2023-07-13 11:13:13.898146+06
4948	10928	1	3	t	2023-07-13 11:13:13.898146+06
4949	10929	1	3	t	2023-07-13 11:13:13.898146+06
4950	10930	1	3	t	2023-07-13 11:13:13.898146+06
4951	10931	1	3	t	2023-07-13 11:13:13.898146+06
4952	10932	1	3	t	2023-07-13 11:13:13.898146+06
4953	10933	1	3	t	2023-07-13 11:13:13.898146+06
4954	10934	1	3	t	2023-07-13 11:13:13.898146+06
4955	10935	1	3	t	2023-07-13 11:13:13.898146+06
4956	10936	1	3	t	2023-07-13 11:13:13.898146+06
4957	10937	1	3	t	2023-07-13 11:13:13.898146+06
4958	10938	1	3	t	2023-07-13 11:13:13.898146+06
4959	10939	1	3	t	2023-07-13 11:13:13.898146+06
4960	10940	1	3	t	2023-07-13 11:13:13.898146+06
4961	10941	1	3	t	2023-07-13 11:13:13.898146+06
4962	10942	1	3	t	2023-07-13 11:13:13.898146+06
4963	10943	1	3	t	2023-07-13 11:13:13.898146+06
4964	10944	1	3	t	2023-07-13 11:13:13.898146+06
4965	10945	1	3	t	2023-07-13 11:13:13.898146+06
4966	10946	1	3	t	2023-07-13 11:13:13.898146+06
4967	10947	1	3	t	2023-07-13 11:13:13.898146+06
4968	10948	1	3	t	2023-07-13 11:13:13.898146+06
4969	10949	1	3	t	2023-07-13 11:13:13.898146+06
4970	10950	1	3	t	2023-07-13 11:13:13.898146+06
4971	10951	1	3	t	2023-07-13 11:13:13.898146+06
4972	10952	1	3	t	2023-07-13 11:13:13.898146+06
4973	10953	1	3	t	2023-07-13 11:13:13.898146+06
4974	10954	1	3	t	2023-07-13 11:13:13.898146+06
4975	10955	1	3	t	2023-07-13 11:13:13.898146+06
4976	10956	1	3	t	2023-07-13 11:13:13.898146+06
4977	10957	1	3	t	2023-07-13 11:13:13.898146+06
4978	10958	1	3	t	2023-07-13 11:13:13.898146+06
4979	10959	1	3	t	2023-07-13 11:13:13.898146+06
4980	10960	1	3	t	2023-07-13 11:13:13.898146+06
4981	10961	1	3	t	2023-07-13 11:13:13.898146+06
4982	10962	1	3	t	2023-07-13 11:13:13.898146+06
4983	10963	1	3	t	2023-07-13 11:13:13.898146+06
4984	10964	1	3	t	2023-07-13 11:13:13.898146+06
4985	10965	1	3	t	2023-07-13 11:13:13.898146+06
4986	10966	1	3	t	2023-07-13 11:13:13.898146+06
4987	10967	1	3	t	2023-07-13 11:13:13.898146+06
4988	10968	1	3	t	2023-07-13 11:13:13.898146+06
4989	10969	1	3	t	2023-07-13 11:13:13.898146+06
4990	10970	1	3	t	2023-07-13 11:13:13.898146+06
4991	10971	1	3	t	2023-07-13 11:13:13.898146+06
4992	10972	1	3	t	2023-07-13 11:13:13.898146+06
4993	10973	1	3	t	2023-07-13 11:13:13.898146+06
4994	10974	1	3	t	2023-07-13 11:13:13.898146+06
4995	10975	1	3	t	2023-07-13 11:13:13.898146+06
4996	10976	1	3	t	2023-07-13 11:13:13.898146+06
4997	10977	1	3	t	2023-07-13 11:13:13.898146+06
4998	10978	1	3	t	2023-07-13 11:13:13.898146+06
4999	10979	1	3	t	2023-07-13 11:13:13.898146+06
5000	10980	1	3	t	2023-07-13 11:13:13.898146+06
5001	10981	1	3	t	2023-07-13 11:13:13.898146+06
5002	10982	1	3	t	2023-07-13 11:13:13.898146+06
5003	10983	1	3	t	2023-07-13 11:13:13.898146+06
5004	10984	1	3	t	2023-07-13 11:13:13.898146+06
5005	10985	1	3	t	2023-07-13 11:13:13.898146+06
5006	10986	1	3	t	2023-07-13 11:13:13.898146+06
5007	10987	1	3	t	2023-07-13 11:13:13.898146+06
5008	10988	1	3	t	2023-07-13 11:13:13.898146+06
5009	10989	1	3	t	2023-07-13 11:13:13.898146+06
5010	10990	1	3	t	2023-07-13 11:13:13.898146+06
5011	10991	1	3	t	2023-07-13 11:13:13.898146+06
5012	10992	1	3	t	2023-07-13 11:13:13.898146+06
5013	10993	1	3	t	2023-07-13 11:13:13.898146+06
5014	10994	1	3	t	2023-07-13 11:13:13.898146+06
5015	10995	1	3	t	2023-07-13 11:13:13.898146+06
5016	10996	1	3	t	2023-07-13 11:13:13.898146+06
5017	10997	1	3	t	2023-07-13 11:13:13.898146+06
5018	10998	1	3	t	2023-07-13 11:13:13.898146+06
5019	10999	1	3	t	2023-07-13 11:13:13.898146+06
5020	11000	1	3	t	2023-07-13 11:13:13.898146+06
5021	11001	1	3	t	2023-07-13 11:13:13.898146+06
5022	11002	1	3	t	2023-07-13 11:13:13.898146+06
5023	11003	1	3	t	2023-07-13 11:13:13.898146+06
5024	11004	1	3	t	2023-07-13 11:13:13.898146+06
5025	11005	1	3	t	2023-07-13 11:13:13.898146+06
5026	11006	1	3	t	2023-07-13 11:13:13.898146+06
5027	11007	1	3	t	2023-07-13 11:13:13.898146+06
5028	11008	1	3	t	2023-07-13 11:13:13.898146+06
5029	11009	1	3	t	2023-07-13 11:13:13.898146+06
5030	11010	1	3	t	2023-07-13 11:13:13.898146+06
5031	11011	1	3	t	2023-07-13 11:13:13.898146+06
5032	11012	1	3	t	2023-07-13 11:13:13.898146+06
5033	11013	1	3	t	2023-07-13 11:13:13.898146+06
5034	11014	1	3	t	2023-07-13 11:13:13.898146+06
5035	11015	1	3	t	2023-07-13 11:13:13.898146+06
5036	11016	1	3	t	2023-07-13 11:13:13.898146+06
5037	11017	1	3	t	2023-07-13 11:13:13.898146+06
5038	11018	1	3	t	2023-07-13 11:13:13.898146+06
5039	11019	1	3	t	2023-07-13 11:13:13.898146+06
5040	11020	1	3	t	2023-07-13 11:13:13.898146+06
5041	11021	1	3	t	2023-07-13 11:13:13.898146+06
5042	11022	1	3	t	2023-07-13 11:13:13.898146+06
5043	11023	1	3	t	2023-07-13 11:13:13.898146+06
5044	11024	1	3	t	2023-07-13 11:13:13.898146+06
5045	11025	1	3	t	2023-07-13 11:13:13.898146+06
5046	11026	1	3	t	2023-07-13 11:13:13.898146+06
5047	11027	1	3	t	2023-07-13 11:13:13.898146+06
5048	11028	1	3	t	2023-07-13 11:13:13.898146+06
5049	11029	1	3	t	2023-07-13 11:13:13.898146+06
5050	11030	1	3	t	2023-07-13 11:13:13.898146+06
5051	11031	1	3	t	2023-07-13 11:13:13.898146+06
5052	11032	1	3	t	2023-07-13 11:13:13.898146+06
5053	11033	1	3	t	2023-07-13 11:13:13.898146+06
5054	11034	1	3	t	2023-07-13 11:13:13.898146+06
5055	11035	1	3	t	2023-07-13 11:13:13.898146+06
5056	11036	1	3	t	2023-07-13 11:13:13.898146+06
5057	11037	1	3	t	2023-07-13 11:13:13.898146+06
5058	11038	1	3	t	2023-07-13 11:13:13.898146+06
5059	11039	1	3	t	2023-07-13 11:13:13.898146+06
5060	11040	1	3	t	2023-07-13 11:13:13.898146+06
5061	11041	1	3	t	2023-07-13 11:13:13.898146+06
5062	11042	1	3	t	2023-07-13 11:13:13.898146+06
5063	11043	1	3	t	2023-07-13 11:13:13.898146+06
5064	11044	1	3	t	2023-07-13 11:13:13.898146+06
5065	11045	1	3	t	2023-07-13 11:13:13.898146+06
5066	11046	1	3	t	2023-07-13 11:13:13.898146+06
5067	11047	1	3	t	2023-07-13 11:13:13.898146+06
5068	11048	1	3	t	2023-07-13 11:13:13.898146+06
5069	11049	1	3	t	2023-07-13 11:13:13.898146+06
5070	11050	1	3	t	2023-07-13 11:13:13.898146+06
5071	11051	1	3	t	2023-07-13 11:13:13.898146+06
5072	11052	1	3	t	2023-07-13 11:13:13.898146+06
5073	11053	1	3	t	2023-07-13 11:13:13.898146+06
5074	11054	1	3	t	2023-07-13 11:13:13.898146+06
5075	11055	1	3	t	2023-07-13 11:13:13.898146+06
5076	11056	1	3	t	2023-07-13 11:13:13.898146+06
5077	11057	1	3	t	2023-07-13 11:13:13.898146+06
5078	11058	1	3	t	2023-07-13 11:13:13.898146+06
5079	11059	1	3	t	2023-07-13 11:13:13.898146+06
5080	11060	1	3	t	2023-07-13 11:13:13.898146+06
5081	11061	1	3	t	2023-07-13 11:13:13.898146+06
5082	11062	1	3	t	2023-07-13 11:13:13.898146+06
5083	11063	1	3	t	2023-07-13 11:13:13.898146+06
5084	11064	1	3	t	2023-07-13 11:13:13.898146+06
5085	11065	1	3	t	2023-07-13 11:13:13.898146+06
5086	11066	1	3	t	2023-07-13 11:13:13.898146+06
5087	11067	1	3	t	2023-07-13 11:13:13.898146+06
5088	11068	1	3	t	2023-07-13 11:13:13.898146+06
5089	11069	1	3	t	2023-07-13 11:13:13.898146+06
5090	11070	1	3	t	2023-07-13 11:13:13.898146+06
5091	11071	1	3	t	2023-07-13 11:13:13.898146+06
5092	11072	1	3	t	2023-07-13 11:13:13.898146+06
5093	11073	1	3	t	2023-07-13 11:13:13.898146+06
5094	11074	1	3	t	2023-07-13 11:13:13.898146+06
5095	11075	1	3	t	2023-07-13 11:13:13.898146+06
5096	11076	1	3	t	2023-07-13 11:13:13.898146+06
5097	11077	1	3	t	2023-07-13 11:13:13.898146+06
5098	11078	1	3	t	2023-07-13 11:13:13.898146+06
5099	11079	1	3	t	2023-07-13 11:13:13.898146+06
5100	11080	1	3	t	2023-07-13 11:13:13.898146+06
5101	11081	1	3	t	2023-07-13 11:13:13.898146+06
5102	11082	1	3	t	2023-07-13 11:13:13.898146+06
5103	11083	1	3	t	2023-07-13 11:13:13.898146+06
5104	11084	1	3	t	2023-07-13 11:13:13.898146+06
5105	11085	1	3	t	2023-07-13 11:13:13.898146+06
5106	11086	1	3	t	2023-07-13 11:13:13.898146+06
5107	11087	1	3	t	2023-07-13 11:13:13.898146+06
5108	11088	1	3	t	2023-07-13 11:13:13.898146+06
5109	11089	1	3	t	2023-07-13 11:13:13.898146+06
5110	11090	1	3	t	2023-07-13 11:13:13.898146+06
5111	11091	1	3	t	2023-07-13 11:13:13.898146+06
5112	11092	1	3	t	2023-07-13 11:13:13.898146+06
5113	11093	1	3	t	2023-07-13 11:13:13.898146+06
5114	11094	1	3	t	2023-07-13 11:13:13.898146+06
5115	11095	1	3	t	2023-07-13 11:13:13.898146+06
5116	11096	1	3	t	2023-07-13 11:13:13.898146+06
5117	11097	1	3	t	2023-07-13 11:13:13.898146+06
5118	11098	1	3	t	2023-07-13 11:13:13.898146+06
5119	11099	1	3	t	2023-07-13 11:13:13.898146+06
5120	11100	1	3	t	2023-07-13 11:13:13.898146+06
5121	11101	1	3	t	2023-07-13 11:13:13.898146+06
5122	11102	1	3	t	2023-07-13 11:13:13.898146+06
5123	11103	1	3	t	2023-07-13 11:13:13.898146+06
5124	11104	1	3	t	2023-07-13 11:13:13.898146+06
5125	11105	1	3	t	2023-07-13 11:13:13.898146+06
5126	11106	1	3	t	2023-07-13 11:13:13.898146+06
5127	11107	1	3	t	2023-07-13 11:13:13.898146+06
5128	11108	1	3	t	2023-07-13 11:13:13.898146+06
5129	11109	1	3	t	2023-07-13 11:13:13.898146+06
5130	11110	1	3	t	2023-07-13 11:13:13.898146+06
5131	11111	1	3	t	2023-07-13 11:13:13.898146+06
5132	11112	1	3	t	2023-07-13 11:13:13.898146+06
5133	11113	1	3	t	2023-07-13 11:13:13.898146+06
5134	11114	1	3	t	2023-07-13 11:13:13.898146+06
5135	11115	1	3	t	2023-07-13 11:13:13.898146+06
5136	11116	1	3	t	2023-07-13 11:13:13.898146+06
5137	11117	1	3	t	2023-07-13 11:13:13.898146+06
5138	11118	1	3	t	2023-07-13 11:13:13.898146+06
5139	11119	1	3	t	2023-07-13 11:13:13.898146+06
5140	11120	1	3	t	2023-07-13 11:13:13.898146+06
5141	11121	1	3	t	2023-07-13 11:13:13.898146+06
5142	11122	1	3	t	2023-07-13 11:13:13.898146+06
5143	11123	1	3	t	2023-07-13 11:13:13.898146+06
5144	11124	1	3	t	2023-07-13 11:13:13.898146+06
5145	11125	1	3	t	2023-07-13 11:13:13.898146+06
5146	11126	1	3	t	2023-07-13 11:13:13.898146+06
5147	11127	1	3	t	2023-07-13 11:13:13.898146+06
5148	11128	1	3	t	2023-07-13 11:13:13.898146+06
5149	11129	1	3	t	2023-07-13 11:13:13.898146+06
5150	11130	1	3	t	2023-07-13 11:13:13.898146+06
5151	11131	1	3	t	2023-07-13 11:13:13.898146+06
5152	11132	1	3	t	2023-07-13 11:13:13.898146+06
5153	11133	1	3	t	2023-07-13 11:13:13.898146+06
5154	11134	1	3	t	2023-07-13 11:13:13.898146+06
5155	11135	1	3	t	2023-07-13 11:13:13.898146+06
5156	11136	1	3	t	2023-07-13 11:13:13.898146+06
5157	11137	1	3	t	2023-07-13 11:13:13.898146+06
5158	11138	1	3	t	2023-07-13 11:13:13.898146+06
5159	11139	1	3	t	2023-07-13 11:13:13.898146+06
5160	11140	1	3	t	2023-07-13 11:13:13.898146+06
5161	11141	1	3	t	2023-07-13 11:13:13.898146+06
5162	11142	1	3	t	2023-07-13 11:13:13.898146+06
5163	11143	1	3	t	2023-07-13 11:13:13.898146+06
5164	11144	1	3	t	2023-07-13 11:13:13.898146+06
5165	11145	1	3	t	2023-07-13 11:13:13.898146+06
5166	11146	1	3	t	2023-07-13 11:13:13.898146+06
5167	11147	1	3	t	2023-07-13 11:13:13.898146+06
5168	11148	1	3	t	2023-07-13 11:13:13.898146+06
5169	11149	1	3	t	2023-07-13 11:13:13.898146+06
5170	11150	1	3	t	2023-07-13 11:13:13.898146+06
5171	11151	1	3	t	2023-07-13 11:13:13.898146+06
5172	11152	1	3	t	2023-07-13 11:13:13.898146+06
5173	11153	1	3	t	2023-07-13 11:13:13.898146+06
5174	11154	1	3	t	2023-07-13 11:13:13.898146+06
5175	11155	1	3	t	2023-07-13 11:13:13.898146+06
5176	11156	1	3	t	2023-07-13 11:13:13.898146+06
5177	11157	1	3	t	2023-07-13 11:13:13.898146+06
5178	11158	1	3	t	2023-07-13 11:13:13.898146+06
5179	11159	1	3	t	2023-07-13 11:13:13.898146+06
5180	11160	1	3	t	2023-07-13 11:13:13.898146+06
5181	11161	1	3	t	2023-07-13 11:13:13.898146+06
5182	11162	1	3	t	2023-07-13 11:13:13.898146+06
5183	11163	1	3	t	2023-07-13 11:13:13.898146+06
5184	11164	1	3	t	2023-07-13 11:13:13.898146+06
5185	11165	1	3	t	2023-07-13 11:13:13.898146+06
5186	11166	1	3	t	2023-07-13 11:13:13.898146+06
5187	11167	1	3	t	2023-07-13 11:13:13.898146+06
5188	11168	1	3	t	2023-07-13 11:13:13.898146+06
5189	11169	1	3	t	2023-07-13 11:13:13.898146+06
5190	11170	1	3	t	2023-07-13 11:13:13.898146+06
5191	11171	1	3	t	2023-07-13 11:13:13.898146+06
5192	11172	1	3	t	2023-07-13 11:13:13.898146+06
5193	11173	1	3	t	2023-07-13 11:13:13.898146+06
5194	11174	1	3	t	2023-07-13 11:13:13.898146+06
5195	11175	1	3	t	2023-07-13 11:13:13.898146+06
5196	11176	1	3	t	2023-07-13 11:13:13.898146+06
5197	11177	1	3	t	2023-07-13 11:13:13.898146+06
5198	11178	1	3	t	2023-07-13 11:13:13.898146+06
5199	11179	1	3	t	2023-07-13 11:13:13.898146+06
5200	11180	1	3	t	2023-07-13 11:13:13.898146+06
5201	11181	1	3	t	2023-07-13 11:13:13.898146+06
5202	11182	1	3	t	2023-07-13 11:13:13.898146+06
5203	11183	1	3	t	2023-07-13 11:13:13.898146+06
5204	11184	1	3	t	2023-07-13 11:13:13.898146+06
5205	11185	1	3	t	2023-07-13 11:13:13.898146+06
5206	11186	1	3	t	2023-07-13 11:13:13.898146+06
5207	11187	1	3	t	2023-07-13 11:13:13.898146+06
5208	11188	1	3	t	2023-07-13 11:13:13.898146+06
5209	11189	1	3	t	2023-07-13 11:13:13.898146+06
5210	11190	1	3	t	2023-07-13 11:13:13.898146+06
5211	11191	1	3	t	2023-07-13 11:13:13.898146+06
5212	11192	1	3	t	2023-07-13 11:13:13.898146+06
5213	11193	1	3	t	2023-07-13 11:13:13.898146+06
5214	11194	1	3	t	2023-07-13 11:13:13.898146+06
5215	11195	1	3	t	2023-07-13 11:13:13.898146+06
5216	11196	1	3	t	2023-07-13 11:13:13.898146+06
5217	11197	1	3	t	2023-07-13 11:13:13.898146+06
5218	11198	1	3	t	2023-07-13 11:13:13.898146+06
5219	11199	1	3	t	2023-07-13 11:13:13.898146+06
5220	11200	1	3	t	2023-07-13 11:13:13.898146+06
5221	11201	1	3	t	2023-07-13 11:13:13.898146+06
5222	11202	1	3	t	2023-07-13 11:13:13.898146+06
5223	11203	1	3	t	2023-07-13 11:13:13.898146+06
5224	11204	1	3	t	2023-07-13 11:13:13.898146+06
5225	11205	1	3	t	2023-07-13 11:13:13.898146+06
5226	11206	1	3	t	2023-07-13 11:13:13.898146+06
5227	11207	1	3	t	2023-07-13 11:13:13.898146+06
5228	11208	1	3	t	2023-07-13 11:13:13.898146+06
5229	11209	1	3	t	2023-07-13 11:13:13.898146+06
5230	11210	1	3	t	2023-07-13 11:13:13.898146+06
5231	11211	1	3	t	2023-07-13 11:13:13.898146+06
5232	11212	1	3	t	2023-07-13 11:13:13.898146+06
5233	11213	1	3	t	2023-07-13 11:13:13.898146+06
5234	11214	1	3	t	2023-07-13 11:13:13.898146+06
5235	11215	1	3	t	2023-07-13 11:13:13.898146+06
5236	11216	1	3	t	2023-07-13 11:13:13.898146+06
5237	11217	1	3	t	2023-07-13 11:13:13.898146+06
5238	11218	1	3	t	2023-07-13 11:13:13.898146+06
5239	11219	1	3	t	2023-07-13 11:13:13.898146+06
5240	11220	1	3	t	2023-07-13 11:13:13.898146+06
5241	11221	1	3	t	2023-07-13 11:13:13.898146+06
5242	11222	1	3	t	2023-07-13 11:13:13.898146+06
5243	11223	1	3	t	2023-07-13 11:13:13.898146+06
5244	11224	1	3	t	2023-07-13 11:13:13.898146+06
5245	11225	1	3	t	2023-07-13 11:13:13.898146+06
5246	11226	1	3	t	2023-07-13 11:13:13.898146+06
5247	11227	1	3	t	2023-07-13 11:13:13.898146+06
5248	11228	1	3	t	2023-07-13 11:13:13.898146+06
5249	11229	1	3	t	2023-07-13 11:13:13.898146+06
5250	11230	1	3	t	2023-07-13 11:13:13.898146+06
5251	11231	1	3	t	2023-07-13 11:13:13.898146+06
5252	11232	1	3	t	2023-07-13 11:13:13.898146+06
5253	11233	1	3	t	2023-07-13 11:13:13.898146+06
5254	11234	1	3	t	2023-07-13 11:13:13.898146+06
5255	11235	1	3	t	2023-07-13 11:13:13.898146+06
5256	11236	1	3	t	2023-07-13 11:13:13.898146+06
5257	11237	1	3	t	2023-07-13 11:13:13.898146+06
5258	11238	1	3	t	2023-07-13 11:13:13.898146+06
5259	11239	1	3	t	2023-07-13 11:13:13.898146+06
5260	11240	1	3	t	2023-07-13 11:13:13.898146+06
5261	11241	1	3	t	2023-07-13 11:13:13.898146+06
5262	11242	1	3	t	2023-07-13 11:13:13.898146+06
5263	11243	1	3	t	2023-07-13 11:13:13.898146+06
5264	11244	1	3	t	2023-07-13 11:13:13.898146+06
5265	11245	1	3	t	2023-07-13 11:13:13.898146+06
5266	11246	1	3	t	2023-07-13 11:13:13.898146+06
5267	11247	1	3	t	2023-07-13 11:13:13.898146+06
5268	11248	1	3	t	2023-07-13 11:13:13.898146+06
5269	11249	1	3	t	2023-07-13 11:13:13.898146+06
5270	11250	1	3	t	2023-07-13 11:13:13.898146+06
5271	11251	1	3	t	2023-07-13 11:13:13.898146+06
5272	11252	1	3	t	2023-07-13 11:13:13.898146+06
5273	11253	1	3	t	2023-07-13 11:13:13.898146+06
5274	11254	1	3	t	2023-07-13 11:13:13.898146+06
5275	11255	1	3	t	2023-07-13 11:13:13.898146+06
5276	11256	1	3	t	2023-07-13 11:13:13.898146+06
5277	11257	1	3	t	2023-07-13 11:13:13.898146+06
5278	11258	1	3	t	2023-07-13 11:13:13.898146+06
5279	11259	1	3	t	2023-07-13 11:13:13.898146+06
5280	11260	1	3	t	2023-07-13 11:13:13.898146+06
5281	11261	1	3	t	2023-07-13 11:13:13.898146+06
5282	11262	1	3	t	2023-07-13 11:13:13.898146+06
5283	11263	1	3	t	2023-07-13 11:13:13.898146+06
5284	11264	1	3	t	2023-07-13 11:13:13.898146+06
5285	11265	1	3	t	2023-07-13 11:13:13.898146+06
5286	11266	1	3	t	2023-07-13 11:13:13.898146+06
5287	11267	1	3	t	2023-07-13 11:13:13.898146+06
5288	11268	1	3	t	2023-07-13 11:13:13.898146+06
5289	11269	1	3	t	2023-07-13 11:13:13.898146+06
5290	11270	1	3	t	2023-07-13 11:13:13.898146+06
5291	11271	1	3	t	2023-07-13 11:13:13.898146+06
5292	11272	1	3	t	2023-07-13 11:13:13.898146+06
5293	11273	1	3	t	2023-07-13 11:13:13.898146+06
5294	11274	1	3	t	2023-07-13 11:13:13.898146+06
5295	11275	1	3	t	2023-07-13 11:13:13.898146+06
5296	11276	1	3	t	2023-07-13 11:13:13.898146+06
5297	11277	1	3	t	2023-07-13 11:13:13.898146+06
5298	11278	1	3	t	2023-07-13 11:13:13.898146+06
5299	11279	1	3	t	2023-07-13 11:13:13.898146+06
5300	11280	1	3	t	2023-07-13 11:13:13.898146+06
5301	11281	1	3	t	2023-07-13 11:13:13.898146+06
5302	11282	1	3	t	2023-07-13 11:13:13.898146+06
5303	11283	1	3	t	2023-07-13 11:13:13.898146+06
5304	11284	1	3	t	2023-07-13 11:13:13.898146+06
5305	11285	1	3	t	2023-07-13 11:13:13.898146+06
5306	11286	1	3	t	2023-07-13 11:13:13.898146+06
5307	11287	1	3	t	2023-07-13 11:13:13.898146+06
5308	11288	1	3	t	2023-07-13 11:13:13.898146+06
5309	11289	1	3	t	2023-07-13 11:13:13.898146+06
5310	11290	1	3	t	2023-07-13 11:13:13.898146+06
5311	11291	1	3	t	2023-07-13 11:13:13.898146+06
5312	11292	1	3	t	2023-07-13 11:13:13.898146+06
5313	11293	1	3	t	2023-07-13 11:13:13.898146+06
5314	11294	1	3	t	2023-07-13 11:13:13.898146+06
5315	11295	1	3	t	2023-07-13 11:13:13.898146+06
5316	11296	1	3	t	2023-07-13 11:13:13.898146+06
5317	11297	1	3	t	2023-07-13 11:13:13.898146+06
5318	11298	1	3	t	2023-07-13 11:13:13.898146+06
5319	11299	1	3	t	2023-07-13 11:13:13.898146+06
5320	11300	1	3	t	2023-07-13 11:13:13.898146+06
5321	11301	1	3	t	2023-07-13 11:13:13.898146+06
5322	11302	1	3	t	2023-07-13 11:13:13.898146+06
5323	11303	1	3	t	2023-07-13 11:13:13.898146+06
5324	11304	1	3	t	2023-07-13 11:13:13.898146+06
5325	11305	1	3	t	2023-07-13 11:13:13.898146+06
5326	11306	1	3	t	2023-07-13 11:13:13.898146+06
5327	11307	1	3	t	2023-07-13 11:13:13.898146+06
5328	11308	1	3	t	2023-07-13 11:13:13.898146+06
5329	11309	1	3	t	2023-07-13 11:13:13.898146+06
5330	11310	1	3	t	2023-07-13 11:13:13.898146+06
5331	11311	1	3	t	2023-07-13 11:13:13.898146+06
5332	11312	1	3	t	2023-07-13 11:13:13.898146+06
5333	11313	1	3	t	2023-07-13 11:13:13.898146+06
5334	11314	1	3	t	2023-07-13 11:13:13.898146+06
5335	11315	1	3	t	2023-07-13 11:13:13.898146+06
5336	11316	1	3	t	2023-07-13 11:13:13.898146+06
5337	11317	1	3	t	2023-07-13 11:13:13.898146+06
5338	11318	1	3	t	2023-07-13 11:13:13.898146+06
5339	11319	1	3	t	2023-07-13 11:13:13.898146+06
5340	11320	1	3	t	2023-07-13 11:13:13.898146+06
5341	11321	1	3	t	2023-07-13 11:13:13.898146+06
5342	11322	1	3	t	2023-07-13 11:13:13.898146+06
5343	11323	1	3	t	2023-07-13 11:13:13.898146+06
5344	11324	1	3	t	2023-07-13 11:13:13.898146+06
5345	11325	1	3	t	2023-07-13 11:13:13.898146+06
5346	11326	1	3	t	2023-07-13 11:13:13.898146+06
5347	11327	1	3	t	2023-07-13 11:13:13.898146+06
5348	11328	1	3	t	2023-07-13 11:13:13.898146+06
5349	11329	1	3	t	2023-07-13 11:13:13.898146+06
5350	11330	1	3	t	2023-07-13 11:13:13.898146+06
5351	11331	1	3	t	2023-07-13 11:13:13.898146+06
5352	11332	1	3	t	2023-07-13 11:13:13.898146+06
5353	11333	1	3	t	2023-07-13 11:13:13.898146+06
5354	11334	1	3	t	2023-07-13 11:13:13.898146+06
5355	11335	1	3	t	2023-07-13 11:13:13.898146+06
5356	11336	1	3	t	2023-07-13 11:13:13.898146+06
5357	11337	1	3	t	2023-07-13 11:13:13.898146+06
5358	11338	1	3	t	2023-07-13 11:13:13.898146+06
5359	11339	1	3	t	2023-07-13 11:13:13.898146+06
5360	11340	1	3	t	2023-07-13 11:13:13.898146+06
5361	11341	1	3	t	2023-07-13 11:13:13.898146+06
5362	11342	1	3	t	2023-07-13 11:13:13.898146+06
5363	11343	1	3	t	2023-07-13 11:13:13.898146+06
5364	11344	1	3	t	2023-07-13 11:13:13.898146+06
5365	11345	1	3	t	2023-07-13 11:13:13.898146+06
5366	11346	1	3	t	2023-07-13 11:13:13.898146+06
5367	11347	1	3	t	2023-07-13 11:13:13.898146+06
5368	11348	1	3	t	2023-07-13 11:13:13.898146+06
5369	11349	1	3	t	2023-07-13 11:13:13.898146+06
5370	11350	1	3	t	2023-07-13 11:13:13.898146+06
5371	11351	1	3	t	2023-07-13 11:13:13.898146+06
5372	11352	1	3	t	2023-07-13 11:13:13.898146+06
5373	11353	1	3	t	2023-07-13 11:13:13.898146+06
5374	11354	1	3	t	2023-07-13 11:13:13.898146+06
5375	11355	1	3	t	2023-07-13 11:13:13.898146+06
5376	11356	1	3	t	2023-07-13 11:13:13.898146+06
5377	11357	1	3	t	2023-07-13 11:13:13.898146+06
5378	11358	1	3	t	2023-07-13 11:13:13.898146+06
5379	11359	1	3	t	2023-07-13 11:13:13.898146+06
5380	11360	1	3	t	2023-07-13 11:13:13.898146+06
5381	11361	1	3	t	2023-07-13 11:13:13.898146+06
5382	11362	1	3	t	2023-07-13 11:13:13.898146+06
5383	11363	1	3	t	2023-07-13 11:13:13.898146+06
5384	11364	1	3	t	2023-07-13 11:13:13.898146+06
5385	11365	1	3	t	2023-07-13 11:13:13.898146+06
5386	11366	1	3	t	2023-07-13 11:13:13.898146+06
5387	11367	1	3	t	2023-07-13 11:13:13.898146+06
5388	11368	1	3	t	2023-07-13 11:13:13.898146+06
5389	11369	1	3	t	2023-07-13 11:13:13.898146+06
5390	11370	1	3	t	2023-07-13 11:13:13.898146+06
5391	11371	1	3	t	2023-07-13 11:13:13.898146+06
5392	11372	1	3	t	2023-07-13 11:13:13.898146+06
5393	11373	1	3	t	2023-07-13 11:13:13.898146+06
5394	11374	1	3	t	2023-07-13 11:13:13.898146+06
5395	11375	1	3	t	2023-07-13 11:13:13.898146+06
5396	11376	1	3	t	2023-07-13 11:13:13.898146+06
5397	11377	1	3	t	2023-07-13 11:13:13.898146+06
5398	11378	1	3	t	2023-07-13 11:13:13.898146+06
5399	11379	1	3	t	2023-07-13 11:13:13.898146+06
5400	11380	1	3	t	2023-07-13 11:13:13.898146+06
5401	11381	1	3	t	2023-07-13 11:13:13.898146+06
5402	11382	1	3	t	2023-07-13 11:13:13.898146+06
5403	11383	1	3	t	2023-07-13 11:13:13.898146+06
5404	11384	1	3	t	2023-07-13 11:13:13.898146+06
5405	11385	1	3	t	2023-07-13 11:13:13.898146+06
5406	11386	1	3	t	2023-07-13 11:13:13.898146+06
5407	11387	1	3	t	2023-07-13 11:13:13.898146+06
5408	11388	1	3	t	2023-07-13 11:13:13.898146+06
5409	11389	1	3	t	2023-07-13 11:13:13.898146+06
5410	11390	1	3	t	2023-07-13 11:13:13.898146+06
5411	11391	1	3	t	2023-07-13 11:13:13.898146+06
5412	11392	1	3	t	2023-07-13 11:13:13.898146+06
5413	11393	1	3	t	2023-07-13 11:13:13.898146+06
5414	11394	1	3	t	2023-07-13 11:13:13.898146+06
5415	11395	1	3	t	2023-07-13 11:13:13.898146+06
5416	11396	1	3	t	2023-07-13 11:13:13.898146+06
5417	11397	1	3	t	2023-07-13 11:13:13.898146+06
5418	11398	1	3	t	2023-07-13 11:13:13.898146+06
5419	11399	1	3	t	2023-07-13 11:13:13.898146+06
5420	11400	1	3	t	2023-07-13 11:13:13.898146+06
5421	11401	1	3	t	2023-07-13 11:13:13.898146+06
5422	11402	1	3	t	2023-07-13 11:13:13.898146+06
5423	11403	1	3	t	2023-07-13 11:13:13.898146+06
5424	11404	1	3	t	2023-07-13 11:13:13.898146+06
5425	11405	1	3	t	2023-07-13 11:13:13.898146+06
5426	11406	1	3	t	2023-07-13 11:13:13.898146+06
5427	11407	1	3	t	2023-07-13 11:13:13.898146+06
5428	11408	1	3	t	2023-07-13 11:13:13.898146+06
5429	11409	1	3	t	2023-07-13 11:13:13.898146+06
5430	11410	1	3	t	2023-07-13 11:13:13.898146+06
5431	11411	1	3	t	2023-07-13 11:13:13.898146+06
5432	11412	1	3	t	2023-07-13 11:13:13.898146+06
5433	11413	1	3	t	2023-07-13 11:13:13.898146+06
5434	11414	1	3	t	2023-07-13 11:13:13.898146+06
5435	11415	1	3	t	2023-07-13 11:13:13.898146+06
5436	11416	1	3	t	2023-07-13 11:13:13.898146+06
5437	11417	1	3	t	2023-07-13 11:13:13.898146+06
5438	11418	1	3	t	2023-07-13 11:13:13.898146+06
5439	11419	1	3	t	2023-07-13 11:13:13.898146+06
5440	11420	1	3	t	2023-07-13 11:13:13.898146+06
5441	11421	1	3	t	2023-07-13 11:13:13.898146+06
5442	11422	1	3	t	2023-07-13 11:13:13.898146+06
5443	11423	1	3	t	2023-07-13 11:13:13.898146+06
5444	11424	1	3	t	2023-07-13 11:13:13.898146+06
5445	11425	1	3	t	2023-07-13 11:13:13.898146+06
5446	11426	1	3	t	2023-07-13 11:13:13.898146+06
5447	11427	1	3	t	2023-07-13 11:13:13.898146+06
5448	11428	1	3	t	2023-07-13 11:13:13.898146+06
5449	11429	1	3	t	2023-07-13 11:13:13.898146+06
5450	11430	1	3	t	2023-07-13 11:13:13.898146+06
5451	11431	1	3	t	2023-07-13 11:13:13.898146+06
5452	11432	1	3	t	2023-07-13 11:13:13.898146+06
5453	11433	1	3	t	2023-07-13 11:13:13.898146+06
5454	11434	1	3	t	2023-07-13 11:13:13.898146+06
5455	11435	1	3	t	2023-07-13 11:13:13.898146+06
5456	11436	1	3	t	2023-07-13 11:13:13.898146+06
5457	11437	1	3	t	2023-07-13 11:13:13.898146+06
5458	11438	1	3	t	2023-07-13 11:13:13.898146+06
5459	11439	1	3	t	2023-07-13 11:13:13.898146+06
5460	11440	1	3	t	2023-07-13 11:13:13.898146+06
5461	11441	1	3	t	2023-07-13 11:13:13.898146+06
5462	11442	1	3	t	2023-07-13 11:13:13.898146+06
5463	11443	1	3	t	2023-07-13 11:13:13.898146+06
5464	11444	1	3	t	2023-07-13 11:13:13.898146+06
5465	11445	1	3	t	2023-07-13 11:13:13.898146+06
5466	11446	1	3	t	2023-07-13 11:13:13.898146+06
5467	11447	1	3	t	2023-07-13 11:13:13.898146+06
5468	11448	1	3	t	2023-07-13 11:13:13.898146+06
5469	11449	1	3	t	2023-07-13 11:13:13.898146+06
5470	11450	1	3	t	2023-07-13 11:13:13.898146+06
5471	11451	1	3	t	2023-07-13 11:13:13.898146+06
5472	11452	1	3	t	2023-07-13 11:13:13.898146+06
5473	11453	1	3	t	2023-07-13 11:13:13.898146+06
5474	11454	1	3	t	2023-07-13 11:13:13.898146+06
5475	11455	1	3	t	2023-07-13 11:13:13.898146+06
5476	11456	1	3	t	2023-07-13 11:13:13.898146+06
5477	11457	1	3	t	2023-07-13 11:13:13.898146+06
5478	11458	1	3	t	2023-07-13 11:13:13.898146+06
5479	11459	1	3	t	2023-07-13 11:13:13.898146+06
5480	11460	1	3	t	2023-07-13 11:13:13.898146+06
5481	11461	1	3	t	2023-07-13 11:13:13.898146+06
5482	11462	1	3	t	2023-07-13 11:13:13.898146+06
5483	11463	1	3	t	2023-07-13 11:13:13.898146+06
5484	11464	1	3	t	2023-07-13 11:13:13.898146+06
5485	11465	1	3	t	2023-07-13 11:13:13.898146+06
5486	11466	1	3	t	2023-07-13 11:13:13.898146+06
5487	11467	1	3	t	2023-07-13 11:13:13.898146+06
5488	11468	1	3	t	2023-07-13 11:13:13.898146+06
5489	11469	1	3	t	2023-07-13 11:13:13.898146+06
5490	11470	1	3	t	2023-07-13 11:13:13.898146+06
5491	11471	1	3	t	2023-07-13 11:13:13.898146+06
5492	11472	1	3	t	2023-07-13 11:13:13.898146+06
5493	11473	1	3	t	2023-07-13 11:13:13.898146+06
5494	11474	1	3	t	2023-07-13 11:13:13.898146+06
5495	11475	1	3	t	2023-07-13 11:13:13.898146+06
5496	11476	1	3	t	2023-07-13 11:13:13.898146+06
5497	11477	1	3	t	2023-07-13 11:13:13.898146+06
5498	11478	1	3	t	2023-07-13 11:13:13.898146+06
5499	11479	1	3	t	2023-07-13 11:13:13.898146+06
5500	11480	1	3	t	2023-07-13 11:13:13.898146+06
5501	11481	1	3	t	2023-07-13 11:13:13.898146+06
5502	11482	1	3	t	2023-07-13 11:13:13.898146+06
5503	11483	1	3	t	2023-07-13 11:13:13.898146+06
5504	11484	1	3	t	2023-07-13 11:13:13.898146+06
5505	11485	1	3	t	2023-07-13 11:13:13.898146+06
5506	11486	1	3	t	2023-07-13 11:13:13.898146+06
5507	11487	1	3	t	2023-07-13 11:13:13.898146+06
5508	11488	1	3	t	2023-07-13 11:13:13.898146+06
5509	11489	1	3	t	2023-07-13 11:13:13.898146+06
5510	11490	1	3	t	2023-07-13 11:13:13.898146+06
5511	11491	1	3	t	2023-07-13 11:13:13.898146+06
5512	11492	1	3	t	2023-07-13 11:13:13.898146+06
5513	11493	1	3	t	2023-07-13 11:13:13.898146+06
5514	11494	1	3	t	2023-07-13 11:13:13.898146+06
5515	11495	1	3	t	2023-07-13 11:13:13.898146+06
5516	11496	1	3	t	2023-07-13 11:13:13.898146+06
5517	11497	1	3	t	2023-07-13 11:13:13.898146+06
5518	11498	1	3	t	2023-07-13 11:13:13.898146+06
5519	11499	1	3	t	2023-07-13 11:13:13.898146+06
5520	11500	1	3	t	2023-07-13 11:13:13.898146+06
5521	11501	1	3	t	2023-07-13 11:13:13.898146+06
5522	11502	1	3	t	2023-07-13 11:13:13.898146+06
5523	11503	1	3	t	2023-07-13 11:13:13.898146+06
5524	11504	1	3	t	2023-07-13 11:13:13.898146+06
5525	11505	1	3	t	2023-07-13 11:13:13.898146+06
5526	11506	1	3	t	2023-07-13 11:13:13.898146+06
5527	11507	1	3	t	2023-07-13 11:13:13.898146+06
5528	11508	1	3	t	2023-07-13 11:13:13.898146+06
5529	11509	1	3	t	2023-07-13 11:13:13.898146+06
5530	11510	1	3	t	2023-07-13 11:13:13.898146+06
5531	11511	1	3	t	2023-07-13 11:13:13.898146+06
5532	11512	1	3	t	2023-07-13 11:13:13.898146+06
5533	11513	1	3	t	2023-07-13 11:13:13.898146+06
5534	11514	1	3	t	2023-07-13 11:13:13.898146+06
5535	11515	1	3	t	2023-07-13 11:13:13.898146+06
5536	11516	1	3	t	2023-07-13 11:13:13.898146+06
5537	11517	1	3	t	2023-07-13 11:13:13.898146+06
5538	11518	1	3	t	2023-07-13 11:13:13.898146+06
5539	11519	1	3	t	2023-07-13 11:13:13.898146+06
5540	11520	1	3	t	2023-07-13 11:13:13.898146+06
5541	11521	1	3	t	2023-07-13 11:13:13.898146+06
5542	11522	1	3	t	2023-07-13 11:13:13.898146+06
5543	11523	1	3	t	2023-07-13 11:13:13.898146+06
5544	11524	1	3	t	2023-07-13 11:13:13.898146+06
5545	11525	1	3	t	2023-07-13 11:13:13.898146+06
5546	11526	1	3	t	2023-07-13 11:13:13.898146+06
5547	11527	1	3	t	2023-07-13 11:13:13.898146+06
5548	11528	1	3	t	2023-07-13 11:13:13.898146+06
5549	11529	1	3	t	2023-07-13 11:13:13.898146+06
5550	11530	1	3	t	2023-07-13 11:13:13.898146+06
5551	11531	1	3	t	2023-07-13 11:13:13.898146+06
5552	11532	1	3	t	2023-07-13 11:13:13.898146+06
5553	11533	1	3	t	2023-07-13 11:13:13.898146+06
5554	11534	1	3	t	2023-07-13 11:13:13.898146+06
5555	11535	1	3	t	2023-07-13 11:13:13.898146+06
5556	11536	1	3	t	2023-07-13 11:13:13.898146+06
5557	11537	1	3	t	2023-07-13 11:13:13.898146+06
5558	11538	1	3	t	2023-07-13 11:13:13.898146+06
5559	11539	1	3	t	2023-07-13 11:13:13.898146+06
5560	11540	1	3	t	2023-07-13 11:13:13.898146+06
5561	11541	1	3	t	2023-07-13 11:13:13.898146+06
5562	11542	1	3	t	2023-07-13 11:13:13.898146+06
5563	11543	1	3	t	2023-07-13 11:13:13.898146+06
5564	11544	1	3	t	2023-07-13 11:13:13.898146+06
5565	11545	1	3	t	2023-07-13 11:13:13.898146+06
5566	11546	1	3	t	2023-07-13 11:13:13.898146+06
5567	11547	1	3	t	2023-07-13 11:13:13.898146+06
5568	11548	1	3	t	2023-07-13 11:13:13.898146+06
5569	11549	1	3	t	2023-07-13 11:13:13.898146+06
5570	11550	1	3	t	2023-07-13 11:13:13.898146+06
5571	11551	1	3	t	2023-07-13 11:13:13.898146+06
5572	11552	1	3	t	2023-07-13 11:13:13.898146+06
5573	11553	1	3	t	2023-07-13 11:13:13.898146+06
5574	11554	1	3	t	2023-07-13 11:13:13.898146+06
5575	11555	1	3	t	2023-07-13 11:13:13.898146+06
5576	11556	1	3	t	2023-07-13 11:13:13.898146+06
5577	11557	1	3	t	2023-07-13 11:13:13.898146+06
5578	11558	1	3	t	2023-07-13 11:13:13.898146+06
5579	11559	1	3	t	2023-07-13 11:13:13.898146+06
5580	11560	1	3	t	2023-07-13 11:13:13.898146+06
5581	11561	1	3	t	2023-07-13 11:13:13.898146+06
5582	11562	1	3	t	2023-07-13 11:13:13.898146+06
5583	11563	1	3	t	2023-07-13 11:13:13.898146+06
5584	11564	1	3	t	2023-07-13 11:13:13.898146+06
5585	11565	1	3	t	2023-07-13 11:13:13.898146+06
5586	11566	1	3	t	2023-07-13 11:13:13.898146+06
5587	11567	1	3	t	2023-07-13 11:13:13.898146+06
5588	11568	1	3	t	2023-07-13 11:13:13.898146+06
5589	11569	1	3	t	2023-07-13 11:13:13.898146+06
5590	11570	1	3	t	2023-07-13 11:13:13.898146+06
5591	11571	1	3	t	2023-07-13 11:13:13.898146+06
5592	11572	1	3	t	2023-07-13 11:13:13.898146+06
5593	11573	1	3	t	2023-07-13 11:13:13.898146+06
5594	11574	1	3	t	2023-07-13 11:13:13.898146+06
5595	11575	1	3	t	2023-07-13 11:13:13.898146+06
5596	11576	1	3	t	2023-07-13 11:13:13.898146+06
5597	11577	1	3	t	2023-07-13 11:13:13.898146+06
5598	11578	1	3	t	2023-07-13 11:13:13.898146+06
5599	11579	1	3	t	2023-07-13 11:13:13.898146+06
5600	11580	1	3	t	2023-07-13 11:13:13.898146+06
5601	11581	1	3	t	2023-07-13 11:13:13.898146+06
5602	11582	1	3	t	2023-07-13 11:13:13.898146+06
5603	11583	1	3	t	2023-07-13 11:13:13.898146+06
5604	11584	1	3	t	2023-07-13 11:13:13.898146+06
5605	11585	1	3	t	2023-07-13 11:13:13.898146+06
5606	11586	1	3	t	2023-07-13 11:13:13.898146+06
5607	11587	1	3	t	2023-07-13 11:13:13.898146+06
5608	11588	1	3	t	2023-07-13 11:13:13.898146+06
5609	11589	1	3	t	2023-07-13 11:13:13.898146+06
5610	11590	1	3	t	2023-07-13 11:13:13.898146+06
5611	11591	1	3	t	2023-07-13 11:13:13.898146+06
5612	11592	1	3	t	2023-07-13 11:13:13.898146+06
5613	11593	1	3	t	2023-07-13 11:13:13.898146+06
5614	11594	1	3	t	2023-07-13 11:13:13.898146+06
5615	11595	1	3	t	2023-07-13 11:13:13.898146+06
5616	11596	1	3	t	2023-07-13 11:13:13.898146+06
5617	11597	1	3	t	2023-07-13 11:13:13.898146+06
5618	11598	1	3	t	2023-07-13 11:13:13.898146+06
5619	11599	1	3	t	2023-07-13 11:13:13.898146+06
5620	11600	1	3	t	2023-07-13 11:13:13.898146+06
5621	11601	1	3	t	2023-07-13 11:13:13.898146+06
5622	11602	1	3	t	2023-07-13 11:13:13.898146+06
5623	11603	1	3	t	2023-07-13 11:13:13.898146+06
5624	11604	1	3	t	2023-07-13 11:13:13.898146+06
5625	11605	1	3	t	2023-07-13 11:13:13.898146+06
5626	11606	1	3	t	2023-07-13 11:13:13.898146+06
5627	11607	1	3	t	2023-07-13 11:13:13.898146+06
5628	11608	1	3	t	2023-07-13 11:13:13.898146+06
5629	11609	1	3	t	2023-07-13 11:13:13.898146+06
5630	11610	1	3	t	2023-07-13 11:13:13.898146+06
5631	11611	1	3	t	2023-07-13 11:13:13.898146+06
5632	11612	1	3	t	2023-07-13 11:13:13.898146+06
5633	11613	1	3	t	2023-07-13 11:13:13.898146+06
5634	11614	1	3	t	2023-07-13 11:13:13.898146+06
5635	11615	1	3	t	2023-07-13 11:13:13.898146+06
5636	11616	1	3	t	2023-07-13 11:13:13.898146+06
5637	11617	1	3	t	2023-07-13 11:13:13.898146+06
5638	11618	1	3	t	2023-07-13 11:13:13.898146+06
5639	11619	1	3	t	2023-07-13 11:13:13.898146+06
5640	11620	1	3	t	2023-07-13 11:13:13.898146+06
5641	11621	1	3	t	2023-07-13 11:13:13.898146+06
5642	11622	1	3	t	2023-07-13 11:13:13.898146+06
5643	11623	1	3	t	2023-07-13 11:13:13.898146+06
5644	11624	1	3	t	2023-07-13 11:13:13.898146+06
5645	11625	1	3	t	2023-07-13 11:13:13.898146+06
5646	11626	1	3	t	2023-07-13 11:13:13.898146+06
5647	11627	1	3	t	2023-07-13 11:13:13.898146+06
5648	11628	1	3	t	2023-07-13 11:13:13.898146+06
5649	11629	1	3	t	2023-07-13 11:13:13.898146+06
5650	11630	1	3	t	2023-07-13 11:13:13.898146+06
5651	11631	1	3	t	2023-07-13 11:13:13.898146+06
5652	11632	1	3	t	2023-07-13 11:13:13.898146+06
5653	11633	1	3	t	2023-07-13 11:13:13.898146+06
5654	11634	1	3	t	2023-07-13 11:13:13.898146+06
5655	11635	1	3	t	2023-07-13 11:13:13.898146+06
5656	11636	1	3	t	2023-07-13 11:13:13.898146+06
5657	11637	1	3	t	2023-07-13 11:13:13.898146+06
5658	11638	1	3	t	2023-07-13 11:13:13.898146+06
5659	11639	1	3	t	2023-07-13 11:13:13.898146+06
5660	11640	1	3	t	2023-07-13 11:13:13.898146+06
5661	11641	1	3	t	2023-07-13 11:13:13.898146+06
5662	11642	1	3	t	2023-07-13 11:13:13.898146+06
5663	11643	1	3	t	2023-07-13 11:13:13.898146+06
5664	11644	1	3	t	2023-07-13 11:13:13.898146+06
5665	11645	1	3	t	2023-07-13 11:13:13.898146+06
5666	11646	1	3	t	2023-07-13 11:13:13.898146+06
5667	11647	1	3	t	2023-07-13 11:13:13.898146+06
5668	11648	1	3	t	2023-07-13 11:13:13.898146+06
5669	11649	1	3	t	2023-07-13 11:13:13.898146+06
5670	11650	1	3	t	2023-07-13 11:13:13.898146+06
5671	11651	1	3	t	2023-07-13 11:13:13.898146+06
5672	11652	1	3	t	2023-07-13 11:13:13.898146+06
5673	11653	1	3	t	2023-07-13 11:13:13.898146+06
5674	11654	1	3	t	2023-07-13 11:13:13.898146+06
5675	11655	1	3	t	2023-07-13 11:13:13.898146+06
5676	11656	1	3	t	2023-07-13 11:13:13.898146+06
5677	11657	1	3	t	2023-07-13 11:13:13.898146+06
5678	11658	1	3	t	2023-07-13 11:13:13.898146+06
5679	11659	1	3	t	2023-07-13 11:13:13.898146+06
5680	11660	1	3	t	2023-07-13 11:13:13.898146+06
5681	11661	1	3	t	2023-07-13 11:13:13.898146+06
5682	11662	1	3	t	2023-07-13 11:13:13.898146+06
5683	11663	1	3	t	2023-07-13 11:13:13.898146+06
5684	11664	1	3	t	2023-07-13 11:13:13.898146+06
5685	11665	1	3	t	2023-07-13 11:13:13.898146+06
5686	11666	1	3	t	2023-07-13 11:13:13.898146+06
5687	11667	1	3	t	2023-07-13 11:13:13.898146+06
5688	11668	1	3	t	2023-07-13 11:13:13.898146+06
5689	11669	1	3	t	2023-07-13 11:13:13.898146+06
5690	11670	1	3	t	2023-07-13 11:13:13.898146+06
5691	11671	1	3	t	2023-07-13 11:13:13.898146+06
5692	11672	1	3	t	2023-07-13 11:13:13.898146+06
5693	11673	1	3	t	2023-07-13 11:13:13.898146+06
5694	11674	1	3	t	2023-07-13 11:13:13.898146+06
5695	11675	1	3	t	2023-07-13 11:13:13.898146+06
5696	2214	1	4	t	2023-07-13 11:13:13.898146+06
5697	2215	1	4	t	2023-07-13 11:13:13.898146+06
5698	2216	1	4	t	2023-07-13 11:13:13.898146+06
5699	2217	1	4	t	2023-07-13 11:13:13.898146+06
5700	2218	1	4	t	2023-07-13 11:13:13.898146+06
5701	2219	1	4	t	2023-07-13 11:13:13.898146+06
5702	2220	1	4	t	2023-07-13 11:13:13.898146+06
5703	2221	1	4	t	2023-07-13 11:13:13.898146+06
5704	2222	1	4	t	2023-07-13 11:13:13.898146+06
5705	2223	1	4	t	2023-07-13 11:13:13.898146+06
5706	2224	1	4	t	2023-07-13 11:13:13.898146+06
5707	2225	1	4	t	2023-07-13 11:13:13.898146+06
5708	2226	1	4	t	2023-07-13 11:13:13.898146+06
5709	2227	1	4	t	2023-07-13 11:13:13.898146+06
5710	2228	1	4	t	2023-07-13 11:13:13.898146+06
5711	2229	1	4	t	2023-07-13 11:13:13.898146+06
5712	2230	1	4	t	2023-07-13 11:13:13.898146+06
5713	2231	1	4	t	2023-07-13 11:13:13.898146+06
5714	2232	1	4	t	2023-07-13 11:13:13.898146+06
5715	2233	1	4	t	2023-07-13 11:13:13.898146+06
5716	2234	1	4	t	2023-07-13 11:13:13.898146+06
5717	2235	1	4	t	2023-07-13 11:13:13.898146+06
5718	2236	1	4	t	2023-07-13 11:13:13.898146+06
5719	2237	1	4	t	2023-07-13 11:13:13.898146+06
5720	2238	1	4	t	2023-07-13 11:13:13.898146+06
5721	2239	1	4	t	2023-07-13 11:13:13.898146+06
5722	2240	1	4	t	2023-07-13 11:13:13.898146+06
5723	2241	1	4	t	2023-07-13 11:13:13.898146+06
5724	2242	1	4	t	2023-07-13 11:13:13.898146+06
5725	2243	1	4	t	2023-07-13 11:13:13.898146+06
5726	2244	1	4	t	2023-07-13 11:13:13.898146+06
5727	2245	1	4	t	2023-07-13 11:13:13.898146+06
5728	2246	1	4	t	2023-07-13 11:13:13.898146+06
5729	2247	1	4	t	2023-07-13 11:13:13.898146+06
5730	2248	1	4	t	2023-07-13 11:13:13.898146+06
5731	2249	1	4	t	2023-07-13 11:13:13.898146+06
5732	2250	1	4	t	2023-07-13 11:13:13.898146+06
5733	2251	1	4	t	2023-07-13 11:13:13.898146+06
5734	2252	1	4	t	2023-07-13 11:13:13.898146+06
5735	2253	1	4	t	2023-07-13 11:13:13.898146+06
5736	2254	1	4	t	2023-07-13 11:13:13.898146+06
5737	2255	1	4	t	2023-07-13 11:13:13.898146+06
5738	2256	1	4	t	2023-07-13 11:13:13.898146+06
5739	2257	1	4	t	2023-07-13 11:13:13.898146+06
5740	2258	1	4	t	2023-07-13 11:13:13.898146+06
5741	2259	1	4	t	2023-07-13 11:13:13.898146+06
5742	2260	1	4	t	2023-07-13 11:13:13.898146+06
5743	2261	1	4	t	2023-07-13 11:13:13.898146+06
5744	2262	1	4	t	2023-07-13 11:13:13.898146+06
5745	2263	1	4	t	2023-07-13 11:13:13.898146+06
5746	2264	1	4	t	2023-07-13 11:13:13.898146+06
5747	2265	1	4	t	2023-07-13 11:13:13.898146+06
5748	2266	1	4	t	2023-07-13 11:13:13.898146+06
5749	2267	1	4	t	2023-07-13 11:13:13.898146+06
5750	2268	1	4	t	2023-07-13 11:13:13.898146+06
5751	2269	1	4	t	2023-07-13 11:13:13.898146+06
5752	2270	1	4	t	2023-07-13 11:13:13.898146+06
5753	2271	1	4	t	2023-07-13 11:13:13.898146+06
5754	2272	1	4	t	2023-07-13 11:13:13.898146+06
5755	2273	1	4	t	2023-07-13 11:13:13.898146+06
5756	2274	1	4	t	2023-07-13 11:13:13.898146+06
5757	2275	1	4	t	2023-07-13 11:13:13.898146+06
5758	2276	1	4	t	2023-07-13 11:13:13.898146+06
5759	2277	1	4	t	2023-07-13 11:13:13.898146+06
5760	2278	1	4	t	2023-07-13 11:13:13.898146+06
5761	2279	1	4	t	2023-07-13 11:13:13.898146+06
5762	2280	1	4	t	2023-07-13 11:13:13.898146+06
5763	2281	1	4	t	2023-07-13 11:13:13.898146+06
5764	2282	1	4	t	2023-07-13 11:13:13.898146+06
5765	2283	1	4	t	2023-07-13 11:13:13.898146+06
5766	2284	1	4	t	2023-07-13 11:13:13.898146+06
5767	2285	1	4	t	2023-07-13 11:13:13.898146+06
5768	2286	1	4	t	2023-07-13 11:13:13.898146+06
5769	2287	1	4	t	2023-07-13 11:13:13.898146+06
5770	2288	1	4	t	2023-07-13 11:13:13.898146+06
5771	2289	1	4	t	2023-07-13 11:13:13.898146+06
5772	2290	1	4	t	2023-07-13 11:13:13.898146+06
5773	2291	1	4	t	2023-07-13 11:13:13.898146+06
5774	2292	1	4	t	2023-07-13 11:13:13.898146+06
5775	2293	1	4	t	2023-07-13 11:13:13.898146+06
5776	2294	1	4	t	2023-07-13 11:13:13.898146+06
5777	2295	1	4	t	2023-07-13 11:13:13.898146+06
5778	2296	1	4	t	2023-07-13 11:13:13.898146+06
5779	2297	1	4	t	2023-07-13 11:13:13.898146+06
5780	2298	1	4	t	2023-07-13 11:13:13.898146+06
5781	2299	1	4	t	2023-07-13 11:13:13.898146+06
5782	2300	1	4	t	2023-07-13 11:13:13.898146+06
5783	2301	1	4	t	2023-07-13 11:13:13.898146+06
5784	2302	1	4	t	2023-07-13 11:13:13.898146+06
5785	2303	1	4	t	2023-07-13 11:13:13.898146+06
5786	2304	1	4	t	2023-07-13 11:13:13.898146+06
5787	2305	1	4	t	2023-07-13 11:13:13.898146+06
5788	2306	1	4	t	2023-07-13 11:13:13.898146+06
5789	2307	1	4	t	2023-07-13 11:13:13.898146+06
5790	2308	1	4	t	2023-07-13 11:13:13.898146+06
5791	2309	1	4	t	2023-07-13 11:13:13.898146+06
5792	2310	1	4	t	2023-07-13 11:13:13.898146+06
5793	2311	1	4	t	2023-07-13 11:13:13.898146+06
5794	2312	1	4	t	2023-07-13 11:13:13.898146+06
5795	2313	1	4	t	2023-07-13 11:13:13.898146+06
5796	2314	1	4	t	2023-07-13 11:13:13.898146+06
5797	2315	1	4	t	2023-07-13 11:13:13.898146+06
5798	2316	1	4	t	2023-07-13 11:13:13.898146+06
5799	2317	1	4	t	2023-07-13 11:13:13.898146+06
5800	2318	1	4	t	2023-07-13 11:13:13.898146+06
5801	2319	1	4	t	2023-07-13 11:13:13.898146+06
5802	2320	1	4	t	2023-07-13 11:13:13.898146+06
5803	2321	1	4	t	2023-07-13 11:13:13.898146+06
5804	2322	1	4	t	2023-07-13 11:13:13.898146+06
5805	2323	1	4	t	2023-07-13 11:13:13.898146+06
5806	2324	1	4	t	2023-07-13 11:13:13.898146+06
5807	2325	1	4	t	2023-07-13 11:13:13.898146+06
5808	2326	1	4	t	2023-07-13 11:13:13.898146+06
5809	2327	1	4	t	2023-07-13 11:13:13.898146+06
5810	2328	1	4	t	2023-07-13 11:13:13.898146+06
5811	2329	1	4	t	2023-07-13 11:13:13.898146+06
5812	2330	1	4	t	2023-07-13 11:13:13.898146+06
5813	2331	1	4	t	2023-07-13 11:13:13.898146+06
5814	2332	1	4	t	2023-07-13 11:13:13.898146+06
5815	2333	1	4	t	2023-07-13 11:13:13.898146+06
5816	2334	1	4	t	2023-07-13 11:13:13.898146+06
5817	2335	1	4	t	2023-07-13 11:13:13.898146+06
5818	2336	1	4	t	2023-07-13 11:13:13.898146+06
5819	2337	1	4	t	2023-07-13 11:13:13.898146+06
5820	2338	1	4	t	2023-07-13 11:13:13.898146+06
5821	2339	1	4	t	2023-07-13 11:13:13.898146+06
5822	2340	1	4	t	2023-07-13 11:13:13.898146+06
5823	2341	1	4	t	2023-07-13 11:13:13.898146+06
5824	2342	1	4	t	2023-07-13 11:13:13.898146+06
5825	2343	1	4	t	2023-07-13 11:13:13.898146+06
5826	2344	1	4	t	2023-07-13 11:13:13.898146+06
5827	2345	1	4	t	2023-07-13 11:13:13.898146+06
5828	2346	1	4	t	2023-07-13 11:13:13.898146+06
5829	2347	1	4	t	2023-07-13 11:13:13.898146+06
5830	2348	1	4	t	2023-07-13 11:13:13.898146+06
5831	2349	1	4	t	2023-07-13 11:13:13.898146+06
5832	2350	1	4	t	2023-07-13 11:13:13.898146+06
5833	2351	1	4	t	2023-07-13 11:13:13.898146+06
5834	2352	1	4	t	2023-07-13 11:13:13.898146+06
5835	2353	1	4	t	2023-07-13 11:13:13.898146+06
5836	2354	1	4	t	2023-07-13 11:13:13.898146+06
5837	2355	1	4	t	2023-07-13 11:13:13.898146+06
5838	2356	1	4	t	2023-07-13 11:13:13.898146+06
5839	2357	1	4	t	2023-07-13 11:13:13.898146+06
5840	2358	1	4	t	2023-07-13 11:13:13.898146+06
5841	2359	1	4	t	2023-07-13 11:13:13.898146+06
5842	2360	1	4	t	2023-07-13 11:13:13.898146+06
5843	2361	1	4	t	2023-07-13 11:13:13.898146+06
5844	2362	1	4	t	2023-07-13 11:13:13.898146+06
5845	2363	1	4	t	2023-07-13 11:13:13.898146+06
5846	2364	1	4	t	2023-07-13 11:13:13.898146+06
5847	2365	1	4	t	2023-07-13 11:13:13.898146+06
5848	2366	1	4	t	2023-07-13 11:13:13.898146+06
5849	2367	1	4	t	2023-07-13 11:13:13.898146+06
5850	2368	1	4	t	2023-07-13 11:13:13.898146+06
5851	2369	1	4	t	2023-07-13 11:13:13.898146+06
5852	2370	1	4	t	2023-07-13 11:13:13.898146+06
5853	2371	1	4	t	2023-07-13 11:13:13.898146+06
5854	2372	1	4	t	2023-07-13 11:13:13.898146+06
5855	2373	1	4	t	2023-07-13 11:13:13.898146+06
5856	2374	1	4	t	2023-07-13 11:13:13.898146+06
5857	2375	1	4	t	2023-07-13 11:13:13.898146+06
5858	2376	1	4	t	2023-07-13 11:13:13.898146+06
5859	2377	1	4	t	2023-07-13 11:13:13.898146+06
5860	2378	1	4	t	2023-07-13 11:13:13.898146+06
5861	2379	1	4	t	2023-07-13 11:13:13.898146+06
5862	2380	1	4	t	2023-07-13 11:13:13.898146+06
5863	2381	1	4	t	2023-07-13 11:13:13.898146+06
5864	2382	1	4	t	2023-07-13 11:13:13.898146+06
5865	2383	1	4	t	2023-07-13 11:13:13.898146+06
5866	2384	1	4	t	2023-07-13 11:13:13.898146+06
5867	2385	1	4	t	2023-07-13 11:13:13.898146+06
5868	2386	1	4	t	2023-07-13 11:13:13.898146+06
5869	2387	1	4	t	2023-07-13 11:13:13.898146+06
5870	2388	1	4	t	2023-07-13 11:13:13.898146+06
5871	2389	1	4	t	2023-07-13 11:13:13.898146+06
5872	2390	1	4	t	2023-07-13 11:13:13.898146+06
5873	2391	1	4	t	2023-07-13 11:13:13.898146+06
5874	2392	1	4	t	2023-07-13 11:13:13.898146+06
5875	2393	1	4	t	2023-07-13 11:13:13.898146+06
5876	2394	1	4	t	2023-07-13 11:13:13.898146+06
5877	2395	1	4	t	2023-07-13 11:13:13.898146+06
5878	2396	1	4	t	2023-07-13 11:13:13.898146+06
5879	2397	1	4	t	2023-07-13 11:13:13.898146+06
5880	2398	1	4	t	2023-07-13 11:13:13.898146+06
5881	2399	1	4	t	2023-07-13 11:13:13.898146+06
5882	2400	1	4	t	2023-07-13 11:13:13.898146+06
5883	2401	1	4	t	2023-07-13 11:13:13.898146+06
5884	2402	1	4	t	2023-07-13 11:13:13.898146+06
5885	2403	1	4	t	2023-07-13 11:13:13.898146+06
5886	2404	1	4	t	2023-07-13 11:13:13.898146+06
5887	2405	1	4	t	2023-07-13 11:13:13.898146+06
5888	2406	1	4	t	2023-07-13 11:13:13.898146+06
5889	2407	1	4	t	2023-07-13 11:13:13.898146+06
5890	2408	1	4	t	2023-07-13 11:13:13.898146+06
5891	2409	1	4	t	2023-07-13 11:13:13.898146+06
5892	2410	1	4	t	2023-07-13 11:13:13.898146+06
5893	2411	1	4	t	2023-07-13 11:13:13.898146+06
5894	2412	1	4	t	2023-07-13 11:13:13.898146+06
5895	2413	1	4	t	2023-07-13 11:13:13.898146+06
5896	2414	1	4	t	2023-07-13 11:13:13.898146+06
5897	2415	1	4	t	2023-07-13 11:13:13.898146+06
5898	2416	1	4	t	2023-07-13 11:13:13.898146+06
5899	2417	1	4	t	2023-07-13 11:13:13.898146+06
5900	2418	1	4	t	2023-07-13 11:13:13.898146+06
5901	2419	1	4	t	2023-07-13 11:13:13.898146+06
5902	2420	1	4	t	2023-07-13 11:13:13.898146+06
5903	2421	1	4	t	2023-07-13 11:13:13.898146+06
5904	2422	1	4	t	2023-07-13 11:13:13.898146+06
5905	2423	1	4	t	2023-07-13 11:13:13.898146+06
5906	2424	1	4	t	2023-07-13 11:13:13.898146+06
5907	2425	1	4	t	2023-07-13 11:13:13.898146+06
5908	2426	1	4	t	2023-07-13 11:13:13.898146+06
5909	2427	1	4	t	2023-07-13 11:13:13.898146+06
5910	2428	1	4	t	2023-07-13 11:13:13.898146+06
5911	2429	1	4	t	2023-07-13 11:13:13.898146+06
5912	2430	1	4	t	2023-07-13 11:13:13.898146+06
5913	2431	1	4	t	2023-07-13 11:13:13.898146+06
5914	2432	1	4	t	2023-07-13 11:13:13.898146+06
5915	2433	1	4	t	2023-07-13 11:13:13.898146+06
5916	2434	1	4	t	2023-07-13 11:13:13.898146+06
5917	2435	1	4	t	2023-07-13 11:13:13.898146+06
5918	2436	1	4	t	2023-07-13 11:13:13.898146+06
5919	2437	1	4	t	2023-07-13 11:13:13.898146+06
5920	2438	1	4	t	2023-07-13 11:13:13.898146+06
5921	2439	1	4	t	2023-07-13 11:13:13.898146+06
5922	2440	1	4	t	2023-07-13 11:13:13.898146+06
5923	2441	1	4	t	2023-07-13 11:13:13.898146+06
5924	2442	1	4	t	2023-07-13 11:13:13.898146+06
5925	2443	1	4	t	2023-07-13 11:13:13.898146+06
5926	2444	1	4	t	2023-07-13 11:13:13.898146+06
5927	2445	1	4	t	2023-07-13 11:13:13.898146+06
5928	2446	1	4	t	2023-07-13 11:13:13.898146+06
5929	2447	1	4	t	2023-07-13 11:13:13.898146+06
5930	2448	1	4	t	2023-07-13 11:13:13.898146+06
5931	2449	1	4	t	2023-07-13 11:13:13.898146+06
5932	2450	1	4	t	2023-07-13 11:13:13.898146+06
5933	2451	1	4	t	2023-07-13 11:13:13.898146+06
5934	2452	1	4	t	2023-07-13 11:13:13.898146+06
5935	2453	1	4	t	2023-07-13 11:13:13.898146+06
5936	2454	1	4	t	2023-07-13 11:13:13.898146+06
5937	2455	1	4	t	2023-07-13 11:13:13.898146+06
5938	2456	1	4	t	2023-07-13 11:13:13.898146+06
5939	2457	1	4	t	2023-07-13 11:13:13.898146+06
5940	2458	1	4	t	2023-07-13 11:13:13.898146+06
5941	2459	1	4	t	2023-07-13 11:13:13.898146+06
5942	2460	1	4	t	2023-07-13 11:13:13.898146+06
5943	2461	1	4	t	2023-07-13 11:13:13.898146+06
5944	2462	1	4	t	2023-07-13 11:13:13.898146+06
5945	2463	1	4	t	2023-07-13 11:13:13.898146+06
5946	2464	1	4	t	2023-07-13 11:13:13.898146+06
5947	2465	1	4	t	2023-07-13 11:13:13.898146+06
5948	2466	1	4	t	2023-07-13 11:13:13.898146+06
5949	2467	1	4	t	2023-07-13 11:13:13.898146+06
5950	2468	1	4	t	2023-07-13 11:13:13.898146+06
5951	2469	1	4	t	2023-07-13 11:13:13.898146+06
5952	2470	1	4	t	2023-07-13 11:13:13.898146+06
5953	2471	1	4	t	2023-07-13 11:13:13.898146+06
5954	2472	1	4	t	2023-07-13 11:13:13.898146+06
5955	2473	1	4	t	2023-07-13 11:13:13.898146+06
5956	2474	1	4	t	2023-07-13 11:13:13.898146+06
5957	2475	1	4	t	2023-07-13 11:13:13.898146+06
5958	2476	1	4	t	2023-07-13 11:13:13.898146+06
5959	2477	1	4	t	2023-07-13 11:13:13.898146+06
5960	2478	1	4	t	2023-07-13 11:13:13.898146+06
5961	2479	1	4	t	2023-07-13 11:13:13.898146+06
5962	2480	1	4	t	2023-07-13 11:13:13.898146+06
5963	2481	1	4	t	2023-07-13 11:13:13.898146+06
5964	2482	1	4	t	2023-07-13 11:13:13.898146+06
5965	2483	1	4	t	2023-07-13 11:13:13.898146+06
5966	2484	1	4	t	2023-07-13 11:13:13.898146+06
5967	2485	1	4	t	2023-07-13 11:13:13.898146+06
5968	2486	1	4	t	2023-07-13 11:13:13.898146+06
5969	2487	1	4	t	2023-07-13 11:13:13.898146+06
5970	2488	1	4	t	2023-07-13 11:13:13.898146+06
5971	2489	1	4	t	2023-07-13 11:13:13.898146+06
5972	2490	1	4	t	2023-07-13 11:13:13.898146+06
5973	2491	1	4	t	2023-07-13 11:13:13.898146+06
5974	2492	1	4	t	2023-07-13 11:13:13.898146+06
5975	2493	1	4	t	2023-07-13 11:13:13.898146+06
5976	2494	1	4	t	2023-07-13 11:13:13.898146+06
5977	2495	1	4	t	2023-07-13 11:13:13.898146+06
5978	2496	1	4	t	2023-07-13 11:13:13.898146+06
5979	2497	1	4	t	2023-07-13 11:13:13.898146+06
5980	2498	1	4	t	2023-07-13 11:13:13.898146+06
5981	2499	1	4	t	2023-07-13 11:13:13.898146+06
5982	2500	1	4	t	2023-07-13 11:13:13.898146+06
5983	2501	1	4	t	2023-07-13 11:13:13.898146+06
5984	2502	1	4	t	2023-07-13 11:13:13.898146+06
5985	2503	1	4	t	2023-07-13 11:13:13.898146+06
5986	2504	1	4	t	2023-07-13 11:13:13.898146+06
5987	2505	1	4	t	2023-07-13 11:13:13.898146+06
5988	2506	1	4	t	2023-07-13 11:13:13.898146+06
5989	2507	1	4	t	2023-07-13 11:13:13.898146+06
5990	2508	1	4	t	2023-07-13 11:13:13.898146+06
5991	2509	1	4	t	2023-07-13 11:13:13.898146+06
5992	2510	1	4	t	2023-07-13 11:13:13.898146+06
5993	2511	1	4	t	2023-07-13 11:13:13.898146+06
5994	2512	1	4	t	2023-07-13 11:13:13.898146+06
5995	2513	1	4	t	2023-07-13 11:13:13.898146+06
5996	2514	1	4	t	2023-07-13 11:13:13.898146+06
5997	2515	1	4	t	2023-07-13 11:13:13.898146+06
5998	2516	1	4	t	2023-07-13 11:13:13.898146+06
5999	2517	1	4	t	2023-07-13 11:13:13.898146+06
6000	2518	1	4	t	2023-07-13 11:13:13.898146+06
6001	2519	1	4	t	2023-07-13 11:13:13.898146+06
6002	2520	1	4	t	2023-07-13 11:13:13.898146+06
6003	2521	1	4	t	2023-07-13 11:13:13.898146+06
6004	2522	1	4	t	2023-07-13 11:13:13.898146+06
6005	2523	1	4	t	2023-07-13 11:13:13.898146+06
6006	2524	1	4	t	2023-07-13 11:13:13.898146+06
6007	2525	1	4	t	2023-07-13 11:13:13.898146+06
6008	2526	1	4	t	2023-07-13 11:13:13.898146+06
6009	2527	1	4	t	2023-07-13 11:13:13.898146+06
6010	2528	1	4	t	2023-07-13 11:13:13.898146+06
6011	2529	1	4	t	2023-07-13 11:13:13.898146+06
6012	2530	1	4	t	2023-07-13 11:13:13.898146+06
6013	2531	1	4	t	2023-07-13 11:13:13.898146+06
6014	2532	1	4	t	2023-07-13 11:13:13.898146+06
6015	2533	1	4	t	2023-07-13 11:13:13.898146+06
6016	2534	1	4	t	2023-07-13 11:13:13.898146+06
6017	2535	1	4	t	2023-07-13 11:13:13.898146+06
6018	2536	1	4	t	2023-07-13 11:13:13.898146+06
6019	2537	1	4	t	2023-07-13 11:13:13.898146+06
6020	2538	1	4	t	2023-07-13 11:13:13.898146+06
6021	2539	1	4	t	2023-07-13 11:13:13.898146+06
6022	2540	1	4	t	2023-07-13 11:13:13.898146+06
6023	2541	1	4	t	2023-07-13 11:13:13.898146+06
6024	2542	1	4	t	2023-07-13 11:13:13.898146+06
6025	2543	1	4	t	2023-07-13 11:13:13.898146+06
6026	2544	1	4	t	2023-07-13 11:13:13.898146+06
6027	2545	1	4	t	2023-07-13 11:13:13.898146+06
6028	2546	1	4	t	2023-07-13 11:13:13.898146+06
6029	2547	1	4	t	2023-07-13 11:13:13.898146+06
6030	2548	1	4	t	2023-07-13 11:13:13.898146+06
6031	2549	1	4	t	2023-07-13 11:13:13.898146+06
6032	2550	1	4	t	2023-07-13 11:13:13.898146+06
6033	2551	1	4	t	2023-07-13 11:13:13.898146+06
6034	2552	1	4	t	2023-07-13 11:13:13.898146+06
6035	2553	1	4	t	2023-07-13 11:13:13.898146+06
6036	2554	1	4	t	2023-07-13 11:13:13.898146+06
6037	2555	1	4	t	2023-07-13 11:13:13.898146+06
6038	2556	1	4	t	2023-07-13 11:13:13.898146+06
6039	2557	1	4	t	2023-07-13 11:13:13.898146+06
6040	2558	1	4	t	2023-07-13 11:13:13.898146+06
6041	2559	1	4	t	2023-07-13 11:13:13.898146+06
6042	2560	1	4	t	2023-07-13 11:13:13.898146+06
6043	2561	1	4	t	2023-07-13 11:13:13.898146+06
6044	2562	1	4	t	2023-07-13 11:13:13.898146+06
6045	2563	1	4	t	2023-07-13 11:13:13.898146+06
6046	2564	1	4	t	2023-07-13 11:13:13.898146+06
6047	2565	1	4	t	2023-07-13 11:13:13.898146+06
6048	2566	1	4	t	2023-07-13 11:13:13.898146+06
6049	2567	1	4	t	2023-07-13 11:13:13.898146+06
6050	2568	1	4	t	2023-07-13 11:13:13.898146+06
6051	2569	1	4	t	2023-07-13 11:13:13.898146+06
6052	2570	1	4	t	2023-07-13 11:13:13.898146+06
6053	2571	1	4	t	2023-07-13 11:13:13.898146+06
6054	2572	1	4	t	2023-07-13 11:13:13.898146+06
6055	2573	1	4	t	2023-07-13 11:13:13.898146+06
6056	2574	1	4	t	2023-07-13 11:13:13.898146+06
6057	2575	1	4	t	2023-07-13 11:13:13.898146+06
6058	2576	1	4	t	2023-07-13 11:13:13.898146+06
6059	2577	1	4	t	2023-07-13 11:13:13.898146+06
6060	2578	1	4	t	2023-07-13 11:13:13.898146+06
6061	2579	1	4	t	2023-07-13 11:13:13.898146+06
6062	2580	1	4	t	2023-07-13 11:13:13.898146+06
6063	2581	1	4	t	2023-07-13 11:13:13.898146+06
6064	2582	1	4	t	2023-07-13 11:13:13.898146+06
6065	2583	1	4	t	2023-07-13 11:13:13.898146+06
6066	2584	1	4	t	2023-07-13 11:13:13.898146+06
6067	2585	1	4	t	2023-07-13 11:13:13.898146+06
6068	2586	1	4	t	2023-07-13 11:13:13.898146+06
6069	2587	1	4	t	2023-07-13 11:13:13.898146+06
6070	2588	1	4	t	2023-07-13 11:13:13.898146+06
6071	2589	1	4	t	2023-07-13 11:13:13.898146+06
6072	2590	1	4	t	2023-07-13 11:13:13.898146+06
6073	2591	1	4	t	2023-07-13 11:13:13.898146+06
6074	2592	1	4	t	2023-07-13 11:13:13.898146+06
6075	2593	1	4	t	2023-07-13 11:13:13.898146+06
6076	2594	1	4	t	2023-07-13 11:13:13.898146+06
6077	2595	1	4	t	2023-07-13 11:13:13.898146+06
6078	2596	1	4	t	2023-07-13 11:13:13.898146+06
6079	2597	1	4	t	2023-07-13 11:13:13.898146+06
6080	2598	1	4	t	2023-07-13 11:13:13.898146+06
6081	2599	1	4	t	2023-07-13 11:13:13.898146+06
6082	2600	1	4	t	2023-07-13 11:13:13.898146+06
6083	2601	1	4	t	2023-07-13 11:13:13.898146+06
6084	2602	1	4	t	2023-07-13 11:13:13.898146+06
6085	2603	1	4	t	2023-07-13 11:13:13.898146+06
6086	2604	1	4	t	2023-07-13 11:13:13.898146+06
6087	2605	1	4	t	2023-07-13 11:13:13.898146+06
6088	2606	1	4	t	2023-07-13 11:13:13.898146+06
6089	2607	1	4	t	2023-07-13 11:13:13.898146+06
6090	2608	1	4	t	2023-07-13 11:13:13.898146+06
6091	2609	1	4	t	2023-07-13 11:13:13.898146+06
6092	2610	1	4	t	2023-07-13 11:13:13.898146+06
6093	2611	1	4	t	2023-07-13 11:13:13.898146+06
6094	2612	1	4	t	2023-07-13 11:13:13.898146+06
6095	2613	1	4	t	2023-07-13 11:13:13.898146+06
6096	2614	1	4	t	2023-07-13 11:13:13.898146+06
6097	2615	1	4	t	2023-07-13 11:13:13.898146+06
6098	2616	1	4	t	2023-07-13 11:13:13.898146+06
6099	2617	1	4	t	2023-07-13 11:13:13.898146+06
6100	2618	1	4	t	2023-07-13 11:13:13.898146+06
6101	2619	1	4	t	2023-07-13 11:13:13.898146+06
6102	2620	1	4	t	2023-07-13 11:13:13.898146+06
6103	2621	1	4	t	2023-07-13 11:13:13.898146+06
6104	2622	1	4	t	2023-07-13 11:13:13.898146+06
6105	2623	1	4	t	2023-07-13 11:13:13.898146+06
6106	2624	1	4	t	2023-07-13 11:13:13.898146+06
6107	2625	1	4	t	2023-07-13 11:13:13.898146+06
6108	2626	1	4	t	2023-07-13 11:13:13.898146+06
6109	2627	1	4	t	2023-07-13 11:13:13.898146+06
6110	2628	1	4	t	2023-07-13 11:13:13.898146+06
6111	2629	1	4	t	2023-07-13 11:13:13.898146+06
6112	2630	1	4	t	2023-07-13 11:13:13.898146+06
6113	2631	1	4	t	2023-07-13 11:13:13.898146+06
6114	2632	1	4	t	2023-07-13 11:13:13.898146+06
6115	2633	1	4	t	2023-07-13 11:13:13.898146+06
6116	2634	1	4	t	2023-07-13 11:13:13.898146+06
6117	2635	1	4	t	2023-07-13 11:13:13.898146+06
6118	2636	1	4	t	2023-07-13 11:13:13.898146+06
6119	2637	1	4	t	2023-07-13 11:13:13.898146+06
6120	2638	1	4	t	2023-07-13 11:13:13.898146+06
6121	2639	1	4	t	2023-07-13 11:13:13.898146+06
6122	2640	1	4	t	2023-07-13 11:13:13.898146+06
6123	2641	1	4	t	2023-07-13 11:13:13.898146+06
6124	2642	1	4	t	2023-07-13 11:13:13.898146+06
6125	2643	1	4	t	2023-07-13 11:13:13.898146+06
6126	2644	1	4	t	2023-07-13 11:13:13.898146+06
6127	2645	1	4	t	2023-07-13 11:13:13.898146+06
6128	2646	1	4	t	2023-07-13 11:13:13.898146+06
6129	2647	1	4	t	2023-07-13 11:13:13.898146+06
6130	2648	1	4	t	2023-07-13 11:13:13.898146+06
6131	2649	1	4	t	2023-07-13 11:13:13.898146+06
6132	2650	1	4	t	2023-07-13 11:13:13.898146+06
6133	2651	1	4	t	2023-07-13 11:13:13.898146+06
6134	2652	1	4	t	2023-07-13 11:13:13.898146+06
6135	2653	1	4	t	2023-07-13 11:13:13.898146+06
6136	2654	1	4	t	2023-07-13 11:13:13.898146+06
6137	2655	1	4	t	2023-07-13 11:13:13.898146+06
6138	2656	1	4	t	2023-07-13 11:13:13.898146+06
6139	2657	1	4	t	2023-07-13 11:13:13.898146+06
6140	2658	1	4	t	2023-07-13 11:13:13.898146+06
6141	2659	1	4	t	2023-07-13 11:13:13.898146+06
6142	2660	1	4	t	2023-07-13 11:13:13.898146+06
6143	2661	1	4	t	2023-07-13 11:13:13.898146+06
6144	2662	1	4	t	2023-07-13 11:13:13.898146+06
6145	2663	1	4	t	2023-07-13 11:13:13.898146+06
6146	2664	1	4	t	2023-07-13 11:13:13.898146+06
6147	2665	1	4	t	2023-07-13 11:13:13.898146+06
6148	2666	1	4	t	2023-07-13 11:13:13.898146+06
6149	2667	1	4	t	2023-07-13 11:13:13.898146+06
6150	2668	1	4	t	2023-07-13 11:13:13.898146+06
6151	2669	1	4	t	2023-07-13 11:13:13.898146+06
6152	2670	1	4	t	2023-07-13 11:13:13.898146+06
6153	2671	1	4	t	2023-07-13 11:13:13.898146+06
6154	2672	1	4	t	2023-07-13 11:13:13.898146+06
6155	2673	1	4	t	2023-07-13 11:13:13.898146+06
6156	2674	1	4	t	2023-07-13 11:13:13.898146+06
6157	2675	1	4	t	2023-07-13 11:13:13.898146+06
6158	2676	1	4	t	2023-07-13 11:13:13.898146+06
6159	2677	1	4	t	2023-07-13 11:13:13.898146+06
6160	2678	1	4	t	2023-07-13 11:13:13.898146+06
6161	2679	1	4	t	2023-07-13 11:13:13.898146+06
6162	2680	1	4	t	2023-07-13 11:13:13.898146+06
6163	2681	1	4	t	2023-07-13 11:13:13.898146+06
6164	2682	1	4	t	2023-07-13 11:13:13.898146+06
6165	2683	1	4	t	2023-07-13 11:13:13.898146+06
6166	2684	1	4	t	2023-07-13 11:13:13.898146+06
6167	2685	1	4	t	2023-07-13 11:13:13.898146+06
6168	2686	1	4	t	2023-07-13 11:13:13.898146+06
6169	2687	1	4	t	2023-07-13 11:13:13.898146+06
6170	2688	1	4	t	2023-07-13 11:13:13.898146+06
6171	2689	1	4	t	2023-07-13 11:13:13.898146+06
6172	2690	1	4	t	2023-07-13 11:13:13.898146+06
6173	2691	1	4	t	2023-07-13 11:13:13.898146+06
6174	2692	1	4	t	2023-07-13 11:13:13.898146+06
6175	2693	1	4	t	2023-07-13 11:13:13.898146+06
6176	2694	1	4	t	2023-07-13 11:13:13.898146+06
6177	2695	1	4	t	2023-07-13 11:13:13.898146+06
6178	2696	1	4	t	2023-07-13 11:13:13.898146+06
6179	2697	1	4	t	2023-07-13 11:13:13.898146+06
6180	2698	1	4	t	2023-07-13 11:13:13.898146+06
6181	2699	1	4	t	2023-07-13 11:13:13.898146+06
6182	2700	1	4	t	2023-07-13 11:13:13.898146+06
6183	2701	1	4	t	2023-07-13 11:13:13.898146+06
6184	2702	1	4	t	2023-07-13 11:13:13.898146+06
6185	2703	1	4	t	2023-07-13 11:13:13.898146+06
6186	2704	1	4	t	2023-07-13 11:13:13.898146+06
6187	2705	1	4	t	2023-07-13 11:13:13.898146+06
6188	2706	1	4	t	2023-07-13 11:13:13.898146+06
6189	2707	1	4	t	2023-07-13 11:13:13.898146+06
6190	2708	1	4	t	2023-07-13 11:13:13.898146+06
6191	2709	1	4	t	2023-07-13 11:13:13.898146+06
6192	2710	1	4	t	2023-07-13 11:13:13.898146+06
6193	2711	1	4	t	2023-07-13 11:13:13.898146+06
6194	2712	1	4	t	2023-07-13 11:13:13.898146+06
6195	2713	1	4	t	2023-07-13 11:13:13.898146+06
6196	2714	1	4	t	2023-07-13 11:13:13.898146+06
6197	2715	1	4	t	2023-07-13 11:13:13.898146+06
6198	2716	1	4	t	2023-07-13 11:13:13.898146+06
6199	2717	1	4	t	2023-07-13 11:13:13.898146+06
6200	2718	1	4	t	2023-07-13 11:13:13.898146+06
6201	2719	1	4	t	2023-07-13 11:13:13.898146+06
6202	2720	1	4	t	2023-07-13 11:13:13.898146+06
6203	2721	1	4	t	2023-07-13 11:13:13.898146+06
6204	2722	1	4	t	2023-07-13 11:13:13.898146+06
6205	2723	1	4	t	2023-07-13 11:13:13.898146+06
6206	2724	1	4	t	2023-07-13 11:13:13.898146+06
6207	2725	1	4	t	2023-07-13 11:13:13.898146+06
6208	2726	1	4	t	2023-07-13 11:13:13.898146+06
6209	2727	1	4	t	2023-07-13 11:13:13.898146+06
6210	2728	1	4	t	2023-07-13 11:13:13.898146+06
6211	2729	1	4	t	2023-07-13 11:13:13.898146+06
6212	2730	1	4	t	2023-07-13 11:13:13.898146+06
6213	2731	1	4	t	2023-07-13 11:13:13.898146+06
6214	2732	1	4	t	2023-07-13 11:13:13.898146+06
6215	2733	1	4	t	2023-07-13 11:13:13.898146+06
6216	2734	1	4	t	2023-07-13 11:13:13.898146+06
6217	2735	1	4	t	2023-07-13 11:13:13.898146+06
6218	2736	1	4	t	2023-07-13 11:13:13.898146+06
6219	2737	1	4	t	2023-07-13 11:13:13.898146+06
6220	2738	1	4	t	2023-07-13 11:13:13.898146+06
6221	2739	1	4	t	2023-07-13 11:13:13.898146+06
6222	2740	1	4	t	2023-07-13 11:13:13.898146+06
6223	2741	1	4	t	2023-07-13 11:13:13.898146+06
6224	2742	1	4	t	2023-07-13 11:13:13.898146+06
6225	2743	1	4	t	2023-07-13 11:13:13.898146+06
6226	2744	1	4	t	2023-07-13 11:13:13.898146+06
6227	2745	1	4	t	2023-07-13 11:13:13.898146+06
6228	2746	1	4	t	2023-07-13 11:13:13.898146+06
6229	2747	1	4	t	2023-07-13 11:13:13.898146+06
6230	2748	1	4	t	2023-07-13 11:13:13.898146+06
6231	2749	1	4	t	2023-07-13 11:13:13.898146+06
6232	2750	1	4	t	2023-07-13 11:13:13.898146+06
6233	2751	1	4	t	2023-07-13 11:13:13.898146+06
6234	2752	1	4	t	2023-07-13 11:13:13.898146+06
6235	2753	1	4	t	2023-07-13 11:13:13.898146+06
6236	2754	1	4	t	2023-07-13 11:13:13.898146+06
6237	2755	1	4	t	2023-07-13 11:13:13.898146+06
6238	2756	1	4	t	2023-07-13 11:13:13.898146+06
6239	2757	1	4	t	2023-07-13 11:13:13.898146+06
6240	2758	1	4	t	2023-07-13 11:13:13.898146+06
6241	2759	1	4	t	2023-07-13 11:13:13.898146+06
6242	2760	1	4	t	2023-07-13 11:13:13.898146+06
6243	2761	1	4	t	2023-07-13 11:13:13.898146+06
6244	2762	1	4	t	2023-07-13 11:13:13.898146+06
6245	2763	1	4	t	2023-07-13 11:13:13.898146+06
6246	2764	1	4	t	2023-07-13 11:13:13.898146+06
6247	2765	1	4	t	2023-07-13 11:13:13.898146+06
6248	2766	1	4	t	2023-07-13 11:13:13.898146+06
6249	2767	1	4	t	2023-07-13 11:13:13.898146+06
6250	2768	1	4	t	2023-07-13 11:13:13.898146+06
6251	2769	1	4	t	2023-07-13 11:13:13.898146+06
6252	2770	1	4	t	2023-07-13 11:13:13.898146+06
6253	2771	1	4	t	2023-07-13 11:13:13.898146+06
6254	2772	1	4	t	2023-07-13 11:13:13.898146+06
6255	2773	1	4	t	2023-07-13 11:13:13.898146+06
6256	2774	1	4	t	2023-07-13 11:13:13.898146+06
6257	2775	1	4	t	2023-07-13 11:13:13.898146+06
6258	2776	1	4	t	2023-07-13 11:13:13.898146+06
6259	2777	1	4	t	2023-07-13 11:13:13.898146+06
6260	2778	1	4	t	2023-07-13 11:13:13.898146+06
6261	2779	1	4	t	2023-07-13 11:13:13.898146+06
6262	2780	1	4	t	2023-07-13 11:13:13.898146+06
6263	2781	1	4	t	2023-07-13 11:13:13.898146+06
6264	2782	1	4	t	2023-07-13 11:13:13.898146+06
6265	2783	1	4	t	2023-07-13 11:13:13.898146+06
6266	2784	1	4	t	2023-07-13 11:13:13.898146+06
6267	2785	1	4	t	2023-07-13 11:13:13.898146+06
6268	2786	1	4	t	2023-07-13 11:13:13.898146+06
6269	2787	1	4	t	2023-07-13 11:13:13.898146+06
6270	2788	1	4	t	2023-07-13 11:13:13.898146+06
6271	2789	1	4	t	2023-07-13 11:13:13.898146+06
6272	2790	1	4	t	2023-07-13 11:13:13.898146+06
6273	2791	1	4	t	2023-07-13 11:13:13.898146+06
6274	2792	1	4	t	2023-07-13 11:13:13.898146+06
6275	2793	1	4	t	2023-07-13 11:13:13.898146+06
6276	2794	1	4	t	2023-07-13 11:13:13.898146+06
6277	2795	1	4	t	2023-07-13 11:13:13.898146+06
6278	2796	1	4	t	2023-07-13 11:13:13.898146+06
6279	2797	1	4	t	2023-07-13 11:13:13.898146+06
6280	2798	1	4	t	2023-07-13 11:13:13.898146+06
6281	2799	1	4	t	2023-07-13 11:13:13.898146+06
6282	2800	1	4	t	2023-07-13 11:13:13.898146+06
6283	2801	1	4	t	2023-07-13 11:13:13.898146+06
6284	2802	1	4	t	2023-07-13 11:13:13.898146+06
6285	2803	1	4	t	2023-07-13 11:13:13.898146+06
6286	2804	1	4	t	2023-07-13 11:13:13.898146+06
6287	2805	1	4	t	2023-07-13 11:13:13.898146+06
6288	2806	1	4	t	2023-07-13 11:13:13.898146+06
6289	2807	1	4	t	2023-07-13 11:13:13.898146+06
6290	2808	1	4	t	2023-07-13 11:13:13.898146+06
6291	2809	1	4	t	2023-07-13 11:13:13.898146+06
6292	2810	1	4	t	2023-07-13 11:13:13.898146+06
6293	2811	1	4	t	2023-07-13 11:13:13.898146+06
6294	2812	1	4	t	2023-07-13 11:13:13.898146+06
6295	2813	1	4	t	2023-07-13 11:13:13.898146+06
6296	2814	1	4	t	2023-07-13 11:13:13.898146+06
6297	2815	1	4	t	2023-07-13 11:13:13.898146+06
6298	2816	1	4	t	2023-07-13 11:13:13.898146+06
6299	2817	1	4	t	2023-07-13 11:13:13.898146+06
6300	2818	1	4	t	2023-07-13 11:13:13.898146+06
6301	2819	1	4	t	2023-07-13 11:13:13.898146+06
6302	2820	1	4	t	2023-07-13 11:13:13.898146+06
6303	2821	1	4	t	2023-07-13 11:13:13.898146+06
6304	2822	1	4	t	2023-07-13 11:13:13.898146+06
6305	2823	1	4	t	2023-07-13 11:13:13.898146+06
6306	2824	1	4	t	2023-07-13 11:13:13.898146+06
6307	2825	1	4	t	2023-07-13 11:13:13.898146+06
6308	2826	1	4	t	2023-07-13 11:13:13.898146+06
6309	2827	1	4	t	2023-07-13 11:13:13.898146+06
6310	2828	1	4	t	2023-07-13 11:13:13.898146+06
6311	2829	1	4	t	2023-07-13 11:13:13.898146+06
6312	2830	1	4	t	2023-07-13 11:13:13.898146+06
6313	2831	1	4	t	2023-07-13 11:13:13.898146+06
6314	2832	1	4	t	2023-07-13 11:13:13.898146+06
6315	2833	1	4	t	2023-07-13 11:13:13.898146+06
6316	2834	1	4	t	2023-07-13 11:13:13.898146+06
6317	2835	1	4	t	2023-07-13 11:13:13.898146+06
6318	2836	1	4	t	2023-07-13 11:13:13.898146+06
6319	2837	1	4	t	2023-07-13 11:13:13.898146+06
6320	2838	1	4	t	2023-07-13 11:13:13.898146+06
6321	2839	1	4	t	2023-07-13 11:13:13.898146+06
6322	2840	1	4	t	2023-07-13 11:13:13.898146+06
6323	2841	1	4	t	2023-07-13 11:13:13.898146+06
6324	2842	1	4	t	2023-07-13 11:13:13.898146+06
6325	2843	1	4	t	2023-07-13 11:13:13.898146+06
6326	2844	1	4	t	2023-07-13 11:13:13.898146+06
6327	2845	1	4	t	2023-07-13 11:13:13.898146+06
6328	2846	1	4	t	2023-07-13 11:13:13.898146+06
6329	2847	1	4	t	2023-07-13 11:13:13.898146+06
6330	2848	1	4	t	2023-07-13 11:13:13.898146+06
6331	2849	1	4	t	2023-07-13 11:13:13.898146+06
6332	2850	1	4	t	2023-07-13 11:13:13.898146+06
6333	2851	1	4	t	2023-07-13 11:13:13.898146+06
6334	2852	1	4	t	2023-07-13 11:13:13.898146+06
6335	2853	1	4	t	2023-07-13 11:13:13.898146+06
6336	2854	1	4	t	2023-07-13 11:13:13.898146+06
6337	2855	1	4	t	2023-07-13 11:13:13.898146+06
6338	2856	1	4	t	2023-07-13 11:13:13.898146+06
6339	2857	1	4	t	2023-07-13 11:13:13.898146+06
6340	2858	1	4	t	2023-07-13 11:13:13.898146+06
6341	2859	1	4	t	2023-07-13 11:13:13.898146+06
6342	2860	1	4	t	2023-07-13 11:13:13.898146+06
6343	2861	1	4	t	2023-07-13 11:13:13.898146+06
6344	2862	1	4	t	2023-07-13 11:13:13.898146+06
6345	2863	1	4	t	2023-07-13 11:13:13.898146+06
6346	2864	1	4	t	2023-07-13 11:13:13.898146+06
6347	2865	1	4	t	2023-07-13 11:13:13.898146+06
6348	2866	1	4	t	2023-07-13 11:13:13.898146+06
6349	2867	1	4	t	2023-07-13 11:13:13.898146+06
6350	2868	1	4	t	2023-07-13 11:13:13.898146+06
6351	2869	1	4	t	2023-07-13 11:13:13.898146+06
6352	2870	1	4	t	2023-07-13 11:13:13.898146+06
6353	2871	1	4	t	2023-07-13 11:13:13.898146+06
6354	2872	1	4	t	2023-07-13 11:13:13.898146+06
6355	2873	1	4	t	2023-07-13 11:13:13.898146+06
6356	2874	1	4	t	2023-07-13 11:13:13.898146+06
6357	2875	1	4	t	2023-07-13 11:13:13.898146+06
6358	2876	1	4	t	2023-07-13 11:13:13.898146+06
6359	2877	1	4	t	2023-07-13 11:13:13.898146+06
6360	2878	1	4	t	2023-07-13 11:13:13.898146+06
6361	2879	1	4	t	2023-07-13 11:13:13.898146+06
6362	2880	1	4	t	2023-07-13 11:13:13.898146+06
6363	2881	1	4	t	2023-07-13 11:13:13.898146+06
6364	2882	1	4	t	2023-07-13 11:13:13.898146+06
6365	2883	1	4	t	2023-07-13 11:13:13.898146+06
6366	2884	1	4	t	2023-07-13 11:13:13.898146+06
6367	2885	1	4	t	2023-07-13 11:13:13.898146+06
6368	2886	1	4	t	2023-07-13 11:13:13.898146+06
6369	2887	1	4	t	2023-07-13 11:13:13.898146+06
6370	2888	1	4	t	2023-07-13 11:13:13.898146+06
6371	2889	1	4	t	2023-07-13 11:13:13.898146+06
6372	2890	1	4	t	2023-07-13 11:13:13.898146+06
6373	2891	1	4	t	2023-07-13 11:13:13.898146+06
6374	2892	1	4	t	2023-07-13 11:13:13.898146+06
6375	2893	1	4	t	2023-07-13 11:13:13.898146+06
6376	2894	1	4	t	2023-07-13 11:13:13.898146+06
6377	2895	1	4	t	2023-07-13 11:13:13.898146+06
6378	2896	1	4	t	2023-07-13 11:13:13.898146+06
6379	2897	1	4	t	2023-07-13 11:13:13.898146+06
6380	2898	1	4	t	2023-07-13 11:13:13.898146+06
6381	2899	1	4	t	2023-07-13 11:13:13.898146+06
6382	2900	1	4	t	2023-07-13 11:13:13.898146+06
6383	2901	1	4	t	2023-07-13 11:13:13.898146+06
6384	2902	1	4	t	2023-07-13 11:13:13.898146+06
6385	2903	1	4	t	2023-07-13 11:13:13.898146+06
6386	2904	1	4	t	2023-07-13 11:13:13.898146+06
6387	2905	1	4	t	2023-07-13 11:13:13.898146+06
6388	2906	1	4	t	2023-07-13 11:13:13.898146+06
6389	2907	1	4	t	2023-07-13 11:13:13.898146+06
6390	2908	1	4	t	2023-07-13 11:13:13.898146+06
6391	2909	1	4	t	2023-07-13 11:13:13.898146+06
6392	2910	1	4	t	2023-07-13 11:13:13.898146+06
6393	2911	1	4	t	2023-07-13 11:13:13.898146+06
6394	2912	1	4	t	2023-07-13 11:13:13.898146+06
6395	2913	1	4	t	2023-07-13 11:13:13.898146+06
6396	2914	1	4	t	2023-07-13 11:13:13.898146+06
6397	2915	1	4	t	2023-07-13 11:13:13.898146+06
6398	2916	1	4	t	2023-07-13 11:13:13.898146+06
6399	2917	1	4	t	2023-07-13 11:13:13.898146+06
6400	2918	1	4	t	2023-07-13 11:13:13.898146+06
6401	2919	1	4	t	2023-07-13 11:13:13.898146+06
6402	2920	1	4	t	2023-07-13 11:13:13.898146+06
6403	2921	1	4	t	2023-07-13 11:13:13.898146+06
6404	2922	1	4	t	2023-07-13 11:13:13.898146+06
6405	2923	1	4	t	2023-07-13 11:13:13.898146+06
6406	2924	1	4	t	2023-07-13 11:13:13.898146+06
6407	2925	1	4	t	2023-07-13 11:13:13.898146+06
6408	2926	1	4	t	2023-07-13 11:13:13.898146+06
6409	2927	1	4	t	2023-07-13 11:13:13.898146+06
6410	2928	1	4	t	2023-07-13 11:13:13.898146+06
6411	2929	1	4	t	2023-07-13 11:13:13.898146+06
6412	2930	1	4	t	2023-07-13 11:13:13.898146+06
6413	2931	1	4	t	2023-07-13 11:13:13.898146+06
6414	2932	1	4	t	2023-07-13 11:13:13.898146+06
6415	2933	1	4	t	2023-07-13 11:13:13.898146+06
6416	2934	1	4	t	2023-07-13 11:13:13.898146+06
6417	2935	1	4	t	2023-07-13 11:13:13.898146+06
6418	2936	1	4	t	2023-07-13 11:13:13.898146+06
6419	2937	1	4	t	2023-07-13 11:13:13.898146+06
6420	2938	1	4	t	2023-07-13 11:13:13.898146+06
6421	2939	1	4	t	2023-07-13 11:13:13.898146+06
6422	2940	1	4	t	2023-07-13 11:13:13.898146+06
6423	2941	1	4	t	2023-07-13 11:13:13.898146+06
6424	2942	1	4	t	2023-07-13 11:13:13.898146+06
6425	2943	1	4	t	2023-07-13 11:13:13.898146+06
6426	2944	1	4	t	2023-07-13 11:13:13.898146+06
6427	2945	1	4	t	2023-07-13 11:13:13.898146+06
6428	2946	1	4	t	2023-07-13 11:13:13.898146+06
6429	2947	1	4	t	2023-07-13 11:13:13.898146+06
6430	2948	1	4	t	2023-07-13 11:13:13.898146+06
6431	2949	1	4	t	2023-07-13 11:13:13.898146+06
6432	2950	1	4	t	2023-07-13 11:13:13.898146+06
6433	2951	1	4	t	2023-07-13 11:13:13.898146+06
6434	2952	1	4	t	2023-07-13 11:13:13.898146+06
6435	2953	1	4	t	2023-07-13 11:13:13.898146+06
6436	2954	1	4	t	2023-07-13 11:13:13.898146+06
6437	2955	1	4	t	2023-07-13 11:13:13.898146+06
6438	2956	1	4	t	2023-07-13 11:13:13.898146+06
6439	2957	1	4	t	2023-07-13 11:13:13.898146+06
6440	2958	1	4	t	2023-07-13 11:13:13.898146+06
6441	2959	1	4	t	2023-07-13 11:13:13.898146+06
6442	2960	1	4	t	2023-07-13 11:13:13.898146+06
6443	2961	1	4	t	2023-07-13 11:13:13.898146+06
6444	2962	1	4	t	2023-07-13 11:13:13.898146+06
6445	2963	1	4	t	2023-07-13 11:13:13.898146+06
6446	2964	1	4	t	2023-07-13 11:13:13.898146+06
6447	2965	1	4	t	2023-07-13 11:13:13.898146+06
6448	2966	1	4	t	2023-07-13 11:13:13.898146+06
6449	2967	1	4	t	2023-07-13 11:13:13.898146+06
6450	2968	1	4	t	2023-07-13 11:13:13.898146+06
6451	2969	1	4	t	2023-07-13 11:13:13.898146+06
6452	2970	1	4	t	2023-07-13 11:13:13.898146+06
6453	2971	1	4	t	2023-07-13 11:13:13.898146+06
6454	2972	1	4	t	2023-07-13 11:13:13.898146+06
6455	2973	1	4	t	2023-07-13 11:13:13.898146+06
6456	2974	1	4	t	2023-07-13 11:13:13.898146+06
6457	2975	1	4	t	2023-07-13 11:13:13.898146+06
6458	2976	1	4	t	2023-07-13 11:13:13.898146+06
6459	2977	1	4	t	2023-07-13 11:13:13.898146+06
6460	2978	1	4	t	2023-07-13 11:13:13.898146+06
6461	2979	1	4	t	2023-07-13 11:13:13.898146+06
6462	2980	1	4	t	2023-07-13 11:13:13.898146+06
6463	2981	1	4	t	2023-07-13 11:13:13.898146+06
6464	2982	1	4	t	2023-07-13 11:13:13.898146+06
6465	2983	1	4	t	2023-07-13 11:13:13.898146+06
6466	2984	1	4	t	2023-07-13 11:13:13.898146+06
6467	2985	1	4	t	2023-07-13 11:13:13.898146+06
6468	2986	1	4	t	2023-07-13 11:13:13.898146+06
6469	2987	1	4	t	2023-07-13 11:13:13.898146+06
6470	2988	1	4	t	2023-07-13 11:13:13.898146+06
6471	2989	1	4	t	2023-07-13 11:13:13.898146+06
6472	2990	1	4	t	2023-07-13 11:13:13.898146+06
6473	2991	1	4	t	2023-07-13 11:13:13.898146+06
6474	2992	1	4	t	2023-07-13 11:13:13.898146+06
6475	2993	1	4	t	2023-07-13 11:13:13.898146+06
6476	2994	1	4	t	2023-07-13 11:13:13.898146+06
6477	2995	1	4	t	2023-07-13 11:13:13.898146+06
6478	2996	1	4	t	2023-07-13 11:13:13.898146+06
6479	2997	1	4	t	2023-07-13 11:13:13.898146+06
6480	2998	1	4	t	2023-07-13 11:13:13.898146+06
6481	2999	1	4	t	2023-07-13 11:13:13.898146+06
6482	3000	1	4	t	2023-07-13 11:13:13.898146+06
6483	3001	1	4	t	2023-07-13 11:13:13.898146+06
6484	3002	1	4	t	2023-07-13 11:13:13.898146+06
6485	3003	1	4	t	2023-07-13 11:13:13.898146+06
6486	3004	1	4	t	2023-07-13 11:13:13.898146+06
6487	3005	1	4	t	2023-07-13 11:13:13.898146+06
6488	3006	1	4	t	2023-07-13 11:13:13.898146+06
6489	3007	1	4	t	2023-07-13 11:13:13.898146+06
6490	3008	1	4	t	2023-07-13 11:13:13.898146+06
6491	3009	1	4	t	2023-07-13 11:13:13.898146+06
6492	3010	1	4	t	2023-07-13 11:13:13.898146+06
6493	3011	1	4	t	2023-07-13 11:13:13.898146+06
6494	3012	1	4	t	2023-07-13 11:13:13.898146+06
6495	3013	1	4	t	2023-07-13 11:13:13.898146+06
6496	3014	1	4	t	2023-07-13 11:13:13.898146+06
6497	3015	1	4	t	2023-07-13 11:13:13.898146+06
6498	3016	1	4	t	2023-07-13 11:13:13.898146+06
6499	3017	1	4	t	2023-07-13 11:13:13.898146+06
6500	3018	1	4	t	2023-07-13 11:13:13.898146+06
6501	3019	1	4	t	2023-07-13 11:13:13.898146+06
6502	3020	1	4	t	2023-07-13 11:13:13.898146+06
6503	3021	1	4	t	2023-07-13 11:13:13.898146+06
6504	3022	1	4	t	2023-07-13 11:13:13.898146+06
6505	3023	1	4	t	2023-07-13 11:13:13.898146+06
6506	3024	1	4	t	2023-07-13 11:13:13.898146+06
6507	3025	1	4	t	2023-07-13 11:13:13.898146+06
6508	3026	1	4	t	2023-07-13 11:13:13.898146+06
6509	3027	1	4	t	2023-07-13 11:13:13.898146+06
6510	3028	1	4	t	2023-07-13 11:13:13.898146+06
6511	3029	1	4	t	2023-07-13 11:13:13.898146+06
6512	3030	1	4	t	2023-07-13 11:13:13.898146+06
6513	3031	1	4	t	2023-07-13 11:13:13.898146+06
6514	3032	1	4	t	2023-07-13 11:13:13.898146+06
6515	3033	1	4	t	2023-07-13 11:13:13.898146+06
6516	3034	1	4	t	2023-07-13 11:13:13.898146+06
6517	3035	1	4	t	2023-07-13 11:13:13.898146+06
6518	3036	1	4	t	2023-07-13 11:13:13.898146+06
6519	3037	1	4	t	2023-07-13 11:13:13.898146+06
6520	3038	1	4	t	2023-07-13 11:13:13.898146+06
6521	3039	1	4	t	2023-07-13 11:13:13.898146+06
6522	3040	1	4	t	2023-07-13 11:13:13.898146+06
6523	3041	1	4	t	2023-07-13 11:13:13.898146+06
6524	3042	1	4	t	2023-07-13 11:13:13.898146+06
6525	3043	1	4	t	2023-07-13 11:13:13.898146+06
6526	3044	1	4	t	2023-07-13 11:13:13.898146+06
6527	3045	1	4	t	2023-07-13 11:13:13.898146+06
6528	3046	1	4	t	2023-07-13 11:13:13.898146+06
6529	3047	1	4	t	2023-07-13 11:13:13.898146+06
6530	3048	1	4	t	2023-07-13 11:13:13.898146+06
6531	3049	1	4	t	2023-07-13 11:13:13.898146+06
6532	3050	1	4	t	2023-07-13 11:13:13.898146+06
6533	3051	1	4	t	2023-07-13 11:13:13.898146+06
6534	3052	1	4	t	2023-07-13 11:13:13.898146+06
6535	3053	1	4	t	2023-07-13 11:13:13.898146+06
6536	3054	1	4	t	2023-07-13 11:13:13.898146+06
6537	3055	1	4	t	2023-07-13 11:13:13.898146+06
6538	3056	1	4	t	2023-07-13 11:13:13.898146+06
6539	3057	1	4	t	2023-07-13 11:13:13.898146+06
6540	3058	1	4	t	2023-07-13 11:13:13.898146+06
6541	3059	1	4	t	2023-07-13 11:13:13.898146+06
6542	3060	1	4	t	2023-07-13 11:13:13.898146+06
6543	3061	1	4	t	2023-07-13 11:13:13.898146+06
6544	3062	1	4	t	2023-07-13 11:13:13.898146+06
6545	3063	1	4	t	2023-07-13 11:13:13.898146+06
6546	3064	1	4	t	2023-07-13 11:13:13.898146+06
6547	3065	1	4	t	2023-07-13 11:13:13.898146+06
6548	3066	1	4	t	2023-07-13 11:13:13.898146+06
6549	3067	1	4	t	2023-07-13 11:13:13.898146+06
6550	3068	1	4	t	2023-07-13 11:13:13.898146+06
6551	3069	1	4	t	2023-07-13 11:13:13.898146+06
6552	3070	1	4	t	2023-07-13 11:13:13.898146+06
6553	3071	1	4	t	2023-07-13 11:13:13.898146+06
6554	3072	1	4	t	2023-07-13 11:13:13.898146+06
6555	3073	1	4	t	2023-07-13 11:13:13.898146+06
6556	3074	1	4	t	2023-07-13 11:13:13.898146+06
6557	3075	1	4	t	2023-07-13 11:13:13.898146+06
6558	3076	1	4	t	2023-07-13 11:13:13.898146+06
6559	3077	1	4	t	2023-07-13 11:13:13.898146+06
6560	3078	1	4	t	2023-07-13 11:13:13.898146+06
6561	3079	1	4	t	2023-07-13 11:13:13.898146+06
6562	3080	1	4	t	2023-07-13 11:13:13.898146+06
6563	3081	1	4	t	2023-07-13 11:13:13.898146+06
6564	3082	1	4	t	2023-07-13 11:13:13.898146+06
6565	3083	1	4	t	2023-07-13 11:13:13.898146+06
6566	3084	1	4	t	2023-07-13 11:13:13.898146+06
6567	3085	1	4	t	2023-07-13 11:13:13.898146+06
6568	3086	1	4	t	2023-07-13 11:13:13.898146+06
6569	3087	1	4	t	2023-07-13 11:13:13.898146+06
6570	3088	1	4	t	2023-07-13 11:13:13.898146+06
6571	3089	1	4	t	2023-07-13 11:13:13.898146+06
6572	3090	1	4	t	2023-07-13 11:13:13.898146+06
6573	3091	1	4	t	2023-07-13 11:13:13.898146+06
6574	3092	1	4	t	2023-07-13 11:13:13.898146+06
6575	3093	1	4	t	2023-07-13 11:13:13.898146+06
6576	3094	1	4	t	2023-07-13 11:13:13.898146+06
6577	3095	1	4	t	2023-07-13 11:13:13.898146+06
6578	3096	1	4	t	2023-07-13 11:13:13.898146+06
6579	3097	1	4	t	2023-07-13 11:13:13.898146+06
6580	3098	1	4	t	2023-07-13 11:13:13.898146+06
6581	3099	1	4	t	2023-07-13 11:13:13.898146+06
6582	3100	1	4	t	2023-07-13 11:13:13.898146+06
6583	3101	1	4	t	2023-07-13 11:13:13.898146+06
6584	3102	1	4	t	2023-07-13 11:13:13.898146+06
6585	3103	1	4	t	2023-07-13 11:13:13.898146+06
6586	3104	1	4	t	2023-07-13 11:13:13.898146+06
6587	3105	1	4	t	2023-07-13 11:13:13.898146+06
6588	3106	1	4	t	2023-07-13 11:13:13.898146+06
6589	3107	1	4	t	2023-07-13 11:13:13.898146+06
6590	3108	1	4	t	2023-07-13 11:13:13.898146+06
6591	3109	1	4	t	2023-07-13 11:13:13.898146+06
6592	3110	1	4	t	2023-07-13 11:13:13.898146+06
6593	3111	1	4	t	2023-07-13 11:13:13.898146+06
6594	3112	1	4	t	2023-07-13 11:13:13.898146+06
6595	3113	1	4	t	2023-07-13 11:13:13.898146+06
6596	3114	1	4	t	2023-07-13 11:13:13.898146+06
6597	3115	1	4	t	2023-07-13 11:13:13.898146+06
6598	3116	1	4	t	2023-07-13 11:13:13.898146+06
6599	3117	1	4	t	2023-07-13 11:13:13.898146+06
6600	3118	1	4	t	2023-07-13 11:13:13.898146+06
6601	3119	1	4	t	2023-07-13 11:13:13.898146+06
6602	3120	1	4	t	2023-07-13 11:13:13.898146+06
6603	3121	1	4	t	2023-07-13 11:13:13.898146+06
6604	3122	1	4	t	2023-07-13 11:13:13.898146+06
6605	3123	1	4	t	2023-07-13 11:13:13.898146+06
6606	3124	1	4	t	2023-07-13 11:13:13.898146+06
6607	3125	1	4	t	2023-07-13 11:13:13.898146+06
6608	3126	1	4	t	2023-07-13 11:13:13.898146+06
6609	3127	1	4	t	2023-07-13 11:13:13.898146+06
6610	3128	1	4	t	2023-07-13 11:13:13.898146+06
6611	3129	1	4	t	2023-07-13 11:13:13.898146+06
6612	3130	1	4	t	2023-07-13 11:13:13.898146+06
6613	3131	1	4	t	2023-07-13 11:13:13.898146+06
6614	3132	1	4	t	2023-07-13 11:13:13.898146+06
6615	3133	1	4	t	2023-07-13 11:13:13.898146+06
6616	3134	1	4	t	2023-07-13 11:13:13.898146+06
6617	3135	1	4	t	2023-07-13 11:13:13.898146+06
6618	3136	1	4	t	2023-07-13 11:13:13.898146+06
6619	3137	1	4	t	2023-07-13 11:13:13.898146+06
6620	3138	1	4	t	2023-07-13 11:13:13.898146+06
6621	3139	1	4	t	2023-07-13 11:13:13.898146+06
6622	3140	1	4	t	2023-07-13 11:13:13.898146+06
6623	3141	1	4	t	2023-07-13 11:13:13.898146+06
6624	3142	1	4	t	2023-07-13 11:13:13.898146+06
6625	3143	1	4	t	2023-07-13 11:13:13.898146+06
6626	3144	1	4	t	2023-07-13 11:13:13.898146+06
6627	3145	1	4	t	2023-07-13 11:13:13.898146+06
6628	3146	1	4	t	2023-07-13 11:13:13.898146+06
6629	3147	1	4	t	2023-07-13 11:13:13.898146+06
6630	3148	1	4	t	2023-07-13 11:13:13.898146+06
6631	3149	1	4	t	2023-07-13 11:13:13.898146+06
6632	3150	1	4	t	2023-07-13 11:13:13.898146+06
6633	3151	1	4	t	2023-07-13 11:13:13.898146+06
6634	3152	1	4	t	2023-07-13 11:13:13.898146+06
6635	3153	1	4	t	2023-07-13 11:13:13.898146+06
6636	3154	1	4	t	2023-07-13 11:13:13.898146+06
6637	3155	1	4	t	2023-07-13 11:13:13.898146+06
6638	3156	1	4	t	2023-07-13 11:13:13.898146+06
6639	3157	1	4	t	2023-07-13 11:13:13.898146+06
6640	3158	1	4	t	2023-07-13 11:13:13.898146+06
6641	3159	1	4	t	2023-07-13 11:13:13.898146+06
6642	3160	1	4	t	2023-07-13 11:13:13.898146+06
6643	3161	1	4	t	2023-07-13 11:13:13.898146+06
6644	3162	1	4	t	2023-07-13 11:13:13.898146+06
6645	3163	1	4	t	2023-07-13 11:13:13.898146+06
6646	3164	1	4	t	2023-07-13 11:13:13.898146+06
6647	3165	1	4	t	2023-07-13 11:13:13.898146+06
6648	3166	1	4	t	2023-07-13 11:13:13.898146+06
6649	3167	1	4	t	2023-07-13 11:13:13.898146+06
6650	3168	1	4	t	2023-07-13 11:13:13.898146+06
6651	3169	1	4	t	2023-07-13 11:13:13.898146+06
6652	3170	1	4	t	2023-07-13 11:13:13.898146+06
6653	3171	1	4	t	2023-07-13 11:13:13.898146+06
6654	3172	1	4	t	2023-07-13 11:13:13.898146+06
6655	3173	1	4	t	2023-07-13 11:13:13.898146+06
6656	3174	1	4	t	2023-07-13 11:13:13.898146+06
6657	3175	1	4	t	2023-07-13 11:13:13.898146+06
6658	3176	1	4	t	2023-07-13 11:13:13.898146+06
6659	3177	1	4	t	2023-07-13 11:13:13.898146+06
6660	3178	1	4	t	2023-07-13 11:13:13.898146+06
6661	3179	1	4	t	2023-07-13 11:13:13.898146+06
6662	3180	1	4	t	2023-07-13 11:13:13.898146+06
6663	3181	1	4	t	2023-07-13 11:13:13.898146+06
6664	3182	1	4	t	2023-07-13 11:13:13.898146+06
6665	3183	1	4	t	2023-07-13 11:13:13.898146+06
6666	3184	1	4	t	2023-07-13 11:13:13.898146+06
6667	3185	1	4	t	2023-07-13 11:13:13.898146+06
6668	3186	1	4	t	2023-07-13 11:13:13.898146+06
6669	3187	1	4	t	2023-07-13 11:13:13.898146+06
6670	3188	1	4	t	2023-07-13 11:13:13.898146+06
6671	3189	1	4	t	2023-07-13 11:13:13.898146+06
6672	3190	1	4	t	2023-07-13 11:13:13.898146+06
6673	3191	1	4	t	2023-07-13 11:13:13.898146+06
6674	3192	1	4	t	2023-07-13 11:13:13.898146+06
6675	3193	1	4	t	2023-07-13 11:13:13.898146+06
6676	3194	1	4	t	2023-07-13 11:13:13.898146+06
6677	3195	1	4	t	2023-07-13 11:13:13.898146+06
6678	3196	1	4	t	2023-07-13 11:13:13.898146+06
6679	3197	1	4	t	2023-07-13 11:13:13.898146+06
6680	3198	1	4	t	2023-07-13 11:13:13.898146+06
6681	3199	1	4	t	2023-07-13 11:13:13.898146+06
6682	3200	1	4	t	2023-07-13 11:13:13.898146+06
6683	3201	1	4	t	2023-07-13 11:13:13.898146+06
6684	3202	1	4	t	2023-07-13 11:13:13.898146+06
6685	3203	1	4	t	2023-07-13 11:13:13.898146+06
2162	1	1	2	t	2023-07-13 11:13:13.898146+06
\.


--
-- TOC entry 3754 (class 0 OID 18117)
-- Dependencies: 217
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page (id, name, parent_id, content, is_deleted, is_hidden) FROM stdin;
\.


--
-- TOC entry 3774 (class 0 OID 18322)
-- Dependencies: 237
-- Data for Name: paraphrase_word; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paraphrase_word (word_id, paraphrase_id) FROM stdin;
3889	2214
3890	2215
3890	2216
3890	2217
3891	2218
3891	2219
3891	2220
3892	2221
3893	2222
3893	2223
3893	2224
3894	2225
3895	2226
3895	2227
3896	2228
3897	2229
3898	2230
3898	2231
3898	2232
3900	2233
3900	2234
3901	2235
3901	2236
3903	2237
3903	2238
3904	2239
3904	2240
3906	2241
3906	2242
3906	2243
3906	2244
3909	2245
3909	2246
3910	2247
3911	2248
3911	2249
3911	2250
3911	2251
3913	2252
3914	2253
3915	2254
3916	2255
3917	2256
3917	2257
3918	2258
3920	2259
3920	2260
3923	2261
3924	2262
3927	2263
3928	2264
3931	2265
3932	2266
3932	2267
3937	2268
3937	2269
3938	2270
3939	2271
3942	2272
3944	2273
3944	2274
3944	2275
3944	2276
3944	2277
3946	2278
3947	2279
3948	2280
3950	2281
3950	2282
3952	2283
3956	2284
3959	2285
3964	2286
3964	2287
3965	2288
3965	2289
3970	2290
3970	2291
3970	2292
3973	2293
3974	2294
3974	2295
3976	2296
3976	2297
3978	2298
3978	2299
3981	2300
3982	2301
3982	2302
3983	2303
3983	2304
3985	2305
3986	2306
3988	2307
3988	2308
3989	2309
3989	2310
3989	2311
3989	2312
3990	2313
3990	2314
3993	2315
3995	2316
3997	2317
3997	2318
3999	2319
4000	2320
4001	2321
4001	2322
4001	2323
4001	2324
4003	2325
4005	2326
4005	2327
4005	2328
4005	2329
4005	2330
4006	2331
4008	2332
4008	2333
4010	2334
4010	2335
4010	2336
4011	2337
4011	2338
4014	2339
4014	2340
4014	2341
4015	2342
4016	2343
4019	2344
4019	2345
4020	2346
4020	2347
4020	2348
4021	2349
4022	2350
4023	2351
4025	2352
4026	2353
4026	2354
4026	2355
4026	2356
4026	2357
4027	2358
4028	2359
4031	2360
4034	2361
4034	2362
4034	2363
4036	2364
4038	2365
4040	2366
4043	2367
4043	2368
4043	2369
4043	2370
4046	2371
4046	2372
4047	2373
4051	2374
4052	2375
4052	2376
4053	2377
4053	2378
4055	2379
4055	2380
4056	2381
4059	2382
4060	2383
4064	2384
4064	2385
4064	2386
4064	2387
4067	2388
4068	2389
4069	2390
4069	2391
4069	2392
4072	2393
4072	2394
4074	2395
4076	2396
4077	2397
4078	2398
4078	2399
4079	2400
4080	2401
4080	2402
4080	2403
4081	2404
4081	2405
4082	2406
4084	2407
4087	2408
4095	2409
4096	2410
4096	2411
4097	2412
4099	2413
4099	2414
4099	2415
4100	2416
4101	2417
4103	2418
4104	2419
4106	2420
4106	2421
4107	2422
4107	2423
4110	2424
4110	2425
4113	2426
4116	2427
4116	2428
4116	2429
4117	2430
4117	2431
4118	2432
4119	2433
4119	2434
4119	2435
4120	2436
4122	2437
4122	2438
4124	2439
4124	2440
4125	2441
4125	2442
4125	2443
4125	2444
4127	2445
4129	2446
4129	2447
4131	2448
4131	2449
4131	2450
4134	2451
4135	2452
4140	2453
4140	2454
4142	2455
4142	2456
4143	2457
4146	2458
4148	2459
4148	2460
4149	2461
4149	2462
4149	2463
4150	2464
4150	2465
4150	2466
4150	2467
4153	2468
4155	2469
4155	2470
4158	2471
4159	2472
4160	2473
4161	2474
4161	2475
4161	2476
4162	2477
4162	2478
4163	2479
4163	2480
4165	2481
4166	2482
4166	2483
4167	2484
4167	2485
4172	2486
4172	2487
4172	2488
4172	2489
4174	2490
4175	2491
4175	2492
4175	2493
4175	2494
4182	2495
4183	2496
4183	2497
4183	2498
4185	2499
4188	2500
4189	2501
4190	2502
4190	2503
4192	2504
4192	2505
4192	2506
4193	2507
4193	2508
4193	2509
4193	2510
4193	2511
4194	2512
4194	2513
4194	2514
4194	2515
4194	2516
4195	2517
4195	2518
4195	2519
4196	2520
4196	2521
4196	2522
4197	2523
4197	2524
4198	2525
4198	2526
4198	2527
4198	2528
4199	2529
4199	2530
4201	2531
4201	2532
4201	2533
4201	2534
4202	2535
4202	2536
4202	2537
4202	2538
4205	2539
4205	2540
4206	2541
4207	2542
4207	2543
4207	2544
4207	2545
4208	2546
4209	2547
4209	2548
4209	2549
4209	2550
4209	2551
4210	2552
4210	2553
4210	2554
4210	2555
4210	2556
4212	2557
4214	2558
4215	2559
4216	2560
4216	2561
4218	2562
4219	2563
4219	2564
4219	2565
4221	2566
4221	2567
4221	2568
4221	2569
4222	2570
4224	2571
4224	2572
4224	2573
4225	2574
4225	2575
4225	2576
4225	2577
4228	2578
4228	2579
4232	2580
4233	2581
4234	2582
4235	2583
4236	2584
4236	2585
4236	2586
4236	2587
4242	2588
4243	2589
4246	2590
4248	2591
4248	2592
4251	2593
4251	2594
4253	2595
4253	2596
4253	2597
4253	2598
4254	2599
4254	2600
4254	2601
4255	2602
4255	2603
4256	2604
4258	2605
4258	2606
4258	2607
4258	2608
4260	2609
4263	2610
4265	2611
4265	2612
4265	2613
4268	2614
4268	2615
4268	2616
4268	2617
4268	2618
4270	2619
4270	2620
4271	2621
4272	2622
4272	2623
4272	2624
4273	2625
4277	2626
4277	2627
4277	2628
4277	2629
4279	2630
4279	2631
4279	2632
4280	2633
4281	2634
4282	2635
4282	2636
4282	2637
4283	2638
4287	2639
4288	2640
4291	2641
4291	2642
4293	2643
4294	2644
4294	2645
4298	2646
4302	2647
4304	2648
4305	2649
4306	2650
4306	2651
4307	2652
4307	2653
4308	2654
4308	2655
4309	2656
4309	2657
4309	2658
4311	2659
4315	2660
4315	2661
4317	2662
4322	2663
4323	2664
4323	2665
4324	2666
4329	2667
4330	2668
4330	2669
4330	2670
4330	2671
4332	2672
4333	2673
4333	2674
4334	2675
4334	2676
4335	2677
4337	2678
4338	2679
4338	2680
4340	2681
4342	2682
4343	2683
4343	2684
4345	2685
4345	2686
4345	2687
4346	2688
4346	2689
4346	2690
4347	2691
4350	2692
4350	2693
4350	2694
4351	2695
4351	2696
4356	2697
4356	2698
4357	2699
4357	2700
4357	2701
4360	2702
4360	2703
4360	2704
4360	2705
4362	2706
4362	2707
4362	2708
4362	2709
4366	2710
4366	2711
4369	2712
4373	2713
4373	2714
4376	2715
4376	2716
4377	2717
4377	2718
4377	2719
4380	2720
4381	2721
4382	2722
4382	2723
4385	2724
4385	2725
4388	2726
4388	2727
4390	2728
4392	2729
4392	2730
4392	2731
4392	2732
4395	2733
4396	2734
4397	2735
4397	2736
4397	2737
4399	2738
4399	2739
4399	2740
4400	2741
4400	2742
4401	2743
4403	2744
4404	2745
4404	2746
4407	2747
4408	2748
4409	2749
4411	2750
4411	2751
4412	2752
4413	2753
4413	2754
4413	2755
4417	2756
4417	2757
4417	2758
4417	2759
4419	2760
4419	2761
4419	2762
4419	2763
4422	2764
4427	2765
4428	2766
4429	2767
4430	2768
4430	2769
4431	2770
4431	2771
4433	2772
4433	2773
4436	2774
4436	2775
4436	2776
4436	2777
4441	2778
4441	2779
4442	2780
4442	2781
4443	2782
4444	2783
4444	2784
4446	2785
4446	2786
4446	2787
4446	2788
4451	2789
4451	2790
4453	2791
4453	2792
4455	2793
4456	2794
4458	2795
4458	2796
4466	2797
4467	2798
4467	2799
4467	2800
4468	2801
4468	2802
4469	2803
4469	2804
4469	2805
4469	2806
4470	2807
4471	2808
4471	2809
4471	2810
4472	2811
4472	2812
4472	2813
4475	2814
4475	2815
4475	2816
4476	2817
4476	2818
4477	2819
4477	2820
4477	2821
4479	2822
4480	2823
4480	2824
4481	2825
4481	2826
4482	2827
4488	2828
4492	2829
4494	2830
4494	2831
4494	2832
4494	2833
4497	2834
4497	2835
4499	2836
4499	2837
4500	2838
4500	2839
4500	2840
4500	2841
4502	2842
4505	2843
4505	2844
4506	2845
4507	2846
4507	2847
4507	2848
4509	2849
4510	2850
4510	2851
4510	2852
4513	2853
4515	2854
4515	2855
4515	2856
4516	2857
4518	2858
4519	2859
4519	2860
4519	2861
4525	2862
4525	2863
4525	2864
4525	2865
4526	2866
4526	2867
4526	2868
4526	2869
4527	2870
4532	2871
4532	2872
4532	2873
4532	2874
4534	2875
4535	2876
4535	2877
4535	2878
4537	2879
4537	2880
4539	2881
4539	2882
4544	2883
4547	2884
4547	2885
4547	2886
4548	2887
4548	2888
4548	2889
4548	2890
4548	2891
4550	2892
4550	2893
4551	2894
4551	2895
4552	2896
4552	2897
4553	2898
4553	2899
4554	2900
4557	2901
4557	2902
4558	2903
4558	2904
4558	2905
4559	2906
4559	2907
4559	2908
4560	2909
4566	2910
4567	2911
4571	2912
4572	2913
4575	2914
4575	2915
4576	2916
4576	2917
4577	2918
4577	2919
4578	2920
4578	2921
4579	2922
4579	2923
4579	2924
4580	2925
4580	2926
4580	2927
4582	2928
4583	2929
4588	2930
4588	2931
4590	2932
4590	2933
4590	2934
4591	2935
4591	2936
4591	2937
4593	2938
4593	2939
4594	2940
4596	2941
4600	2942
4600	2943
4602	2944
4605	2945
4605	2946
4605	2947
4607	2948
4608	2949
4610	2950
4612	2951
4613	2952
4614	2953
4614	2954
4615	2955
4615	2956
4616	2957
4616	2958
4617	2959
4617	2960
4617	2961
4621	2962
4621	2963
4626	2964
4629	2965
4629	2966
4629	2967
4633	2968
4633	2969
4633	2970
4633	2971
4633	2972
4636	2973
4636	2974
4637	2975
4637	2976
4640	2977
4641	2978
4641	2979
4642	2980
4642	2981
4644	2982
4649	2983
4650	2984
4651	2985
4651	2986
4652	2987
4654	2988
4655	2989
4655	2990
4656	2991
4656	2992
4661	2993
4661	2994
4662	2995
4662	2996
4670	2997
4670	2998
4671	2999
4671	3000
4672	3001
4672	3002
4676	3003
4677	3004
4678	3005
4679	3006
4680	3007
4681	3008
4683	3009
4683	3010
4684	3011
4684	3012
4685	3013
4685	3014
4685	3015
4686	3016
4689	3017
4689	3018
4691	3019
4691	3020
4691	3021
4691	3022
4694	3023
4694	3024
4695	3025
4695	3026
4696	3027
4697	3028
4702	3029
4706	3030
4706	3031
4707	3032
4707	3033
4707	3034
4713	3035
4713	3036
4714	3037
4714	3038
4714	3039
4715	3040
4716	3041
4716	3042
4717	3043
4718	3044
4718	3045
4719	3046
4719	3047
4719	3048
4721	3049
4721	3050
4723	3051
4723	3052
4724	3053
4724	3054
4731	3055
4731	3056
4731	3057
4734	3058
4734	3059
4734	3060
4735	3061
4740	3062
4740	3063
4740	3064
4742	3065
4742	3066
4742	3067
4743	3068
4745	3069
4745	3070
4746	3071
4747	3072
4747	3073
4747	3074
4749	3075
4749	3076
4750	3077
4750	3078
4750	3079
4750	3080
4753	3081
4755	3082
4755	3083
4758	3084
4758	3085
4758	3086
4759	3087
4759	3088
4760	3089
4760	3090
4760	3091
4762	3092
4765	3093
4766	3094
4766	3095
4767	3096
4770	3097
4770	3098
4770	3099
4773	3100
4773	3101
4776	3102
4781	3103
4786	3104
4786	3105
4787	3106
4787	3107
4787	3108
4787	3109
4791	3110
4791	3111
4791	3112
4798	3113
4798	3114
4798	3115
4801	3116
4802	3117
4803	3118
4805	3119
4810	3120
4810	3121
4810	3122
4810	3123
4810	3124
4812	3125
4812	3126
4812	3127
4814	3128
4814	3129
4819	3130
4820	3131
4824	3132
4825	3133
4825	3134
4826	3135
4826	3136
4827	3137
4828	3138
4828	3139
4828	3140
4830	3141
4831	3142
4834	3143
4834	3144
4835	3145
4836	3146
4837	3147
4837	3148
4837	3149
4838	3150
4838	3151
4838	3152
4838	3153
4838	3154
4839	3155
4840	3156
4840	3157
4842	3158
4842	3159
4842	3160
4843	3161
4849	3162
4851	3163
4852	3164
4852	3165
4852	3166
4852	3167
4853	3168
4853	3169
4854	3170
4854	3171
4854	3172
4856	3173
4856	3174
4856	3175
4856	3176
4856	3177
4858	3178
4858	3179
4859	3180
4860	3181
4861	3182
4861	3183
4861	3184
4861	3185
4864	3186
4864	3187
4865	3188
4865	3189
4865	3190
4866	3191
4867	3192
4867	3193
4867	3194
4870	3195
4873	3196
4875	3197
4879	3198
4879	3199
4879	3200
4880	3201
4880	3202
4882	3203
\.


--
-- TOC entry 3772 (class 0 OID 18313)
-- Dependencies: 235
-- Data for Name: paraphrases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paraphrases (id, paraphrase) FROM stdin;
2214	байланыс нүктелер
2215	ойланып істелмеген
2216	әдейі емес
2217	күтпеген жерден
2218	сайлауға қатысудан жалтару
2219	айлау кезінде саналы түрде дауыс беруге қатыспауы
2220	менің даусымнан ештеңе өзгермейді деу
2221	әбүйір
2222	жұрт таныған
2223	сый құрмет
2224	қадір қасиет
2225	әбүйірлі
2226	әдейі істейін деп істмеген
2227	байқаусыздан кеткен қылық
2228	ақиқат
2229	мөлдір
2230	адамзат
2231	әйел адам
2232	ер адам
2233	Кәмелетке толып, ер жеткен адам
2234	бір елдің азаматтығы бар адам
2235	тұлға құқығы мен міндеттерінің жиынтығы
2236	мемлекет тарапынан тұлға құқығын қорғау
2237	ешкімге тәуелді емес
2238	өз билігі өзінде
2239	айғағы жоқ
2240	дәлелі жоқ
2241	дәл
2242	айдын
2243	шалқар
2244	белгілі
2245	анығы көрінеді
2246	айқын сипатталады
2247	туған өлке
2248	жер
2249	оралым
2250	тәрбиелеу процесі
2251	импорт
2252	заң немесе құқық бұзушылықтар жасауға байланысты қойылатын төлемдер
2253	тәртіп бұзған
2254	орнына алмастырып қой
2255	екі түрлі 
2256	екі жаққа кетеді
2257	жоғалады
2258	талаптарға сйкестігін анықта
2259	заңды күші бар ресми құжат.
2260	Деректі тіркейтін хаттама
2261	түсіру
2262	форум
2263	бір топ адам бірлесіп іс басқару формасы
2264	адамдар тобы
2265	түсіру
2266	қиыр
2267	шет жақ
2268	айға таңба басқандай
2269	шын мәніндегі
2270	негізін біліп алып
2271	айқындау
2272	айқындау
2273	қызметкер
2274	бюро
2275	механизм
2276	құрал
2277	агрегат
2278	өшпендік
2279	қарым
2280	араласып-құраласу
2281	 сайлау кепілдігі
2282	пассивті сайлау құқығы
2283	жәрдемімен
2284	өсір
2285	халықаралық ұйым мүшелерінің жалпы жиналысы
2286	Конституция
2287	зағдар жинағы
2288	ауыс
2289	той тойлау
2290	жер
2291	аумақ
2292	аймақ
2293	шалғай
2294	аумаққа тән
2295	аумаққа қатысты
2296	жанына бату
2297	ауырсыну
2298	алмастыру
2299	орнын өзгерту
2300	қаны қарайған
2301	жасырын емес
2302	жабық емес
2303	ақиқат
2304	шыншыл
2305	сақадай сайла
2306	дайын
2307	елге билік жүргізші
2308	ел басқарушы
2309	өз дегенін
2310	қожалық ететін
2311	төрелік
2312	үстемдік
2313	ұйым басшысы
2314	Мемлекеттік билік пен басқарудың атқарушы және өкім етуші орғандары; басқару аппараты
2315	интернет ресурс
2316	әігңме дүкен құр
2317	бірге жұмыс істейтін адма
2318	қызметі бір
2319	ықпал
2320	байқа
2321	құн
2322	парқы
2323	көрсеткіш
2324	бәс
2325	қаражат мөлшері
2326	негізгі ереже
2327	арна
2328	схема
2329	жоспар
2330	жоба
2331	орындау
2332	жол
2333	саяхат
2334	парықта
2335	әр нәрсеге жіті қара
2336	көз жеткіз
2337	көрермен
2338	көпшілік
2339	салмақты 
2340	сабырлы
2341	байсалды
2342	мониторингте
2343	мониторингтеуші
2344	бөлім
2345	тарау
2346	алға жылжу
2347	қозғалу
2348	ілгерілеу
2349	бас қолбасшы
2350	аяқ қолын ала қаш
2351	билеп-төсте
2352	хат
2353	су көзі
2354	тұма
2355	жер
2356	қабылдау
2357	бастау
2358	шешуші мәні бар
2359	жол көрсетуші
2360	еш нәрседен тайынбайтын
2361	айтылған
2362	хабарлаған
2363	білдірген
2364	қадір құрметке бөленген
2365	көркем образ арқылы кескіндеу
2366	кешкімге қосылмайтын
2367	атақты
2368	мәлім
2369	көрнекті
2370	беделді
2371	алынды
2372	жіберілді
2373	жаратпау
2374	бәсекеге түскен
2375	ақырын сайлау
2376	жай сайлау
2377	басқару
2378	қожалық ету
2379	сездіру
2380	байқату
2381	айтады
2382	Мекеме
2383	әжептеуір
2384	бірауыздылық
2385	тұтастық
2386	ынтымақтық
2387	татулық
2388	тиісінше
2389	істей алмайды
2390	бола алатын
2391	шығарылатын
2392	жүргізілетін
2393	мүмкін
2394	болды
2395	туу
2396	еріктілік
2397	адамдардың өз билігі өзінде болу
2398	қаймана
2399	басқа
2400	Бөлшектерге ұсақталған
2401	бір бөлігі
2402	бөлшек
2403	бөлім
2404	жеке саласы
2405	әскери топ
2406	Бөлшектерге ұсақталған
2407	жалпыхалықтық
2408	талқандау
2409	ақша
2410	сайлау қағазы
2411	хабарлама
2412	вакцинация шаралары
2413	орынбасар
2414	министрден кейінгі екінші адам
2415	министрдің көмекшісі
2416	жынысы әр түрлі адамдар
2417	аралас
2418	жабду
2419	жабду
2420	күні бұрын қамданбанған
2421	даярлық жасалмаған
2422	алға басып ілгеріле
2423	көркейе түс
2424	шатақ
2425	келіспеушілік
2426	сайлау
2427	Мемлекет я ұжым атынан сайланған ресми адамдар тобы.
2428	іскерлік кездесулердің ұйымы
2429	мүддесін қорғайтын тұлғалар тобы
2430	халықтың басқаруы
2431	басқару жүйесі
2432	халық билік жасайтын
2433	әрекет
2434	қимыл
2435	көрсетілім
2436	амандық-саулық жайы
2437	мүшесі
2438	конгрессмен
2439	әрекет
2440	бағынышты
2441	сараптама
2442	сұрыптама
2443	жекелік
2444	даралық
2445	факт
2446	жүйелі
2447	дәйекті
2448	басшы
2449	шеф
2450	бастық
2451	ниеттес қарым қатынаст болу
2452	 тіршілік
2453	мемлекет
2454	жұрт
2455	қолданысқа кіргізу
2456	тәжірбиеге пайдалану
2457	кіргізу
2458	жол-жоба
2459	әдеттегідей емес
2460	ғажап
2461	өзгешелік
2462	айрықшалық
2463	өзіндік
2464	өз еркі өзінде
2465	құқылы 
2466	тәуелсіз
2467	күштеусіз
2468	рапорт
2469	саналу
2470	есепке алыну
2471	беремін
2472	Еуразия континентілік
2473	жылумен жабдықтау
2474	құпия
2475	жасырын
2476	ішкі
2477	хал-жағдай
2478	тұрмыс
2479	әл әуқат
2480	тіршілік
2481	теріс әрекет
2482	сазайы
2483	зауал
2484	жазылған
2485	жазу арқылы
2486	шектеседі
2487	астасады
2488	сабақтасады
2489	тұтастасады
2490	көз алдағыш
2491	шектеседі
2492	астасады
2493	сабақтасады
2494	тұтастасады
2495	хайуанаттар бағы
2496	ұсталмаған
2497	бұрын болмаған
2498	өңі кетпеген
2499	жаңа
2500	әлемдік
2501	әлемдік
2502	бәрі бірдей
2503	баршасы
2504	көңіл толатын
2505	қабілетті
2506	істен шықпаған
2507	көңіл толмайтын
2508	қабілетсіз
2509	мүгедек
2510	кемтар
2511	істен шыққан
2512	нұсқаулық
2513	ереже
2514	ескертпе
2515	жаднама
2516	тәртіп
2517	жұрт білетін
2518	елге таныс
2519	көпке жария
2520	жұрт білетін
2521	елге таныс
2522	көпке жария
2523	бастытрқан
2524	табылған
2525	жария етті
2526	хабарлады
2527	бастырту
2528	табу
2529	мәлімдеу
2530	жария ету
2531	айқын
2532	ашық
2533	жарық
2534	анық
2535	акт
2536	бұйрық
2537	заң
2538	әмір
2539	бойжеткен
2540	жаңа өсіп келе жатқан
2541	бұлжытпай орында
2542	ашық емес
2543	құпия түрде
2544	көзден таса
2545	Қалтарысы бар\n
2546	жария емес
2547	ішіне кіреді
2548	тұрмыс
2549	жағдай
2550	ыдырау
2551	жоюлу
2552	ішіне кіреді
2553	тұрмыс
2554	жағдай
2555	ыдырау
2556	жоюлу
2557	жауап беретін тұлға
2558	тез
2559	өз алдына
2560	адам басы
2561	бір адам
2562	жеңіске жеткен
2563	аумақтық кеңістік
2564	табиғи ресурс
2565	жер қойнау
2566	алғышқы таңдау жасау
2567	жеребе салу
2568	жеребе тастау
2569	таңдау жасау
2570	күндік кескен туып өтскен жері бір
2571	меңгерту
2572	дамыту
2573	ілгерілету
2574	меңгерту
2575	дамыту
2576	ілгерілету
2577	нығайту
2578	демеу көрсету
2579	қосымша күш
2580	көп адам жиналған жер
2581	проект
2582	артық
2583	жоқ қылу
2584	алу
2585	тазарту
2586	қабылдау
2587	тазалау
2588	жоқ қылу
2589	жеке тұлға
2590	жолыру
2591	көрсету
2592	өсіру
2593	оптимизациялау
2594	іске асыру
2595	тапсырылсын
2596	артылсын
2597	табысталсын
2598	міндеттелсін
2599	айдайды
2600	іске қосты
2601	орындау
2602	жүзеге асыру
2603	орындау
2604	қосағы
2605	еңбек
2606	іс
2607	қарекет
2608	қызмет
2609	тыңдаушылар
2610	кең,мол бөлме
2611	нормативті-құқықтық акт
2612	қаулы
2613	жарғы
2614	әділ
2615	әділетті
2616	тура
2617	турашыл
2618	дұрыс
2619	пікір
2620	бейне
2621	жеке меншік
2622	университет
2623	ВУЗ
2624	колледж
2625	әлеуметтік желі ресурсы
2626	жұмыс
2627	қарекет
2628	шаруа
2629	қызмет
2630	орындау
2631	жасау
2632	жүргізу
2633	ұйымдасу
2634	торшаның жұмыс жасауы
2635	оқиға
2636	адым
2637	қадам
2638	ішінде
2639	 ұсыныс
2640	жиынтық
2641	бетпе бет жүздес
2642	өзімен жеке кездес
2643	жүзбе жүз әңгімелесу
2644	бетпе бет жүздесу
2645	өзімен жеке кездесу
2646	уақ
2647	ойлары бір жерден шықпа
2648	кемсіту
2649	ойда жоқта
2650	үлкейту
2651	үлғайту
2652	үлкейту
2653	ұлғайту
2654	жиын
2655	жиналыс
2656	одақ
2657	қоғам
2658	сот
2659	жауапкершілікке алу
2660	аластайтын
2661	жолататын
2662	кідіртпей
2663	палата
2664	арнайы жиын
2665	мәжіліс
2666	кеңес мүшелер
2667	құрылтайшылық
2668	Ата Заң
2669	Конституциялық жарғы
2670	Конституциялық низам 
2671	Конституциялық мизам
2672	шама
2673	көп жағдайда
2674	көп уақытта
2675	дәлдеу
2676	болжау
2677	ойластырылмаса
2678	діттеген мақсатты
2679	көлемі көп
2680	аумақты
2681	барын ортаға салғыш
2682	байқамау
2683	кескін-келбеті
2684	бейне
2685	ұсынылған
2686	білдірілген
2687	байқатылған
2688	байқату
2689	сездіру
2690	білдіру
2691	ұзындайды
2692	көсемдік
2693	бастаушылық
2694	басшылық
2695	ұқсас
2696	құдды
2697	Аптаның жеті күнінің бірі
2698	 Жиырма төрт сағатқа тең уақыт
2699	қаралатын мәселе
2700	жиын
2701	тәртіп
2702	шымшытырық
2703	маңызды
2704	негізгі
2705	басты
2706	ерік
2707	рух
2708	қабілет
2709	ақыл
2710	бойында күші мол
2711	алып күш
2712	түйсінеді
2713	тәртіп
2714	заң
2715	қажеті болушылық
2716	керектілік
2717	мекен
2718	республика
2719	тәуелсіз
2720	қайтара дауыс беру
2721	ұайтарымы беріледі
2722	елді мекен\n
2723	астанасы\n
2724	түзеу
2725	жаңадан жөндеу
2726	стандартты
2727	анықтамалық
2728	дауыс бермеу
2729	әлеуметтік қамсыздандыру\n
2730	қамтамасыз ету\n
2731	кепілдік беру
2732	жабдықтау
2733	терең
2734	орта
2735	бақылау
2736	бағдарлау
2737	қадағалау
2738	көрінген
2739	денсаулықты тексерткен
2740	емделген
2741	тексерілу
2742	байқалу
2743	іздестіру
2744	ақша бөлу
2745	екпіні күшті
2746	ағыны қатты
2747	дұрыс емес
2748	ағат іс істе
2749	жаңсақтық
2750	қатынасу
2751	атсалысу
2752	әрекет етуші тұлға
2753	қорғанысты қамтамасыз ету
2754	қорғау
2755	қамқорлық жасау
2756	ауыртпалық
2757	кедергі
2758	бөгет
2759	тапшылық
2760	компания
2761	қауымдастық
2762	серіктестік
2763	адамдардан тұратын топтар
2764	жасалды
2765	көмектесу
2766	қайта өңдеу
2767	қайта өңдеу
2768	жасауға кірмес зат
2769	қолдануға болмайды
2770	пайдаға асыру үрдісі
2771	пайдалану ісі
2772	көмек
2773	көрсетк
2774	қамқорлық жасау
2775	сақтау
2776	жақтау
2777	аялау
2778	риза болып шаттану
2779	 көңілдену
2780	аралық фазасы
2781	айқындалу формасы
2782	анықтама
2783	орган
2784	лауазымды
2785	адамның құқығы
2786	саяси еркі
2787	қоғамдық еркі
2788	қақы
2789	пайда болған
2790	жүзеге асыру
2791	адамдар жиынтығы
2792	топ
2793	тұтас бір заттың бөлімдерінің өзара орналасуы
2794	жұмыс
2795	аз уақыт
2796	ұзақ емес
2797	үміткер немесе партия сайлануы үшін сайлаушылардың көпшілік дауысын алуы қажет
2798	тілек
2799	тілеу
2800	мүдде
2801	сынақ
2802	саты
2803	дарланған қызметкер
2804	қолынан іс келетін
2805	кәсіпқой
2806	шебер
2807	өкілдік
2808	орны
2809	қадірі
2810	мәні
2811	маңызы зор
2812	мазмұнды
2813	мәнді
2814	керегі
2815	сапа
2816	дереккөз
2817	мерзім
2818	ай
2819	даңқ
2820	абырой-атақ
2821	дәреже
2822	жорамал
2823	тұрғылықты жері
2824	тұратын орны
2825	демократия
2826	президент
2827	ұлттық
2828	іс-шаралар өтетін жер
2829	парламент
2830	ақпарат
2831	мағлұмат
2832	дерек
2833	хабар
2834	Әңгіменің төркіні
2835	мәні түйіні
2836	мемлекеттік мекеме
2837	үкіметбасы
2838	міндеттеме
2839	тапсырма
2840	уәкіл
2841	ұйым
2842	орындалатын қадамдар
2843	платформа
2844	қосымша
2845	эталон
2846	бақылау
2847	маркетинг
2848	игеру
2849	бір нәрсенің таңбасы, өзіндік белгісі
2850	кемтар
2851	жарымжан
2852	кемтік
2853	ақаусыз
2854	қолайлы жағдай
2855	мұрша
2856	мүмкіншілік
2857	орган
2858	көрсету
2859	анық
2860	тура
2861	дәл
2862	маңызды
2863	шешуші
2864	мәні бар
2865	басты
2866	айқындалады
2867	бағдарланады
2868	нақтыланады
2869	дәлелденеді
2870	тек
2871	көшірме
2872	үлгі
2873	негіз
2874	жоба
2875	әкімшілік-территориялық бөлік
2876	жер
2877	аумақ
2878	аймақ
2879	шақырды
2880	түсіну
2881	ауырлығы жоқ
2882	күш жұмсаусыз
2883	орын алу
2884	жасау
2885	қондыру
2886	тұрғызады
2887	орта тұсы
2888	басты қала
2889	негіз
2890	күш
2891	тірек
2892	басты тұлғаның көмекшісі
2893	Мекеме бастығының бірінші көмекшісі
2894	іске асыру
2895	ойнау
2896	мемлекеттік
2897	ұлттық
2898	ресми басқосу
2899	ойын-той
2900	коворкинг
2901	үздіксіз
2902	тұрақтылық
2903	ауыстыру
2904	толтыру
2905	сілтілеу
2906	ауыстыру
2907	толтыру
2908	сілтілеу
2909	сұранысқа ие
2910	түсімі мол
2911	төңірек
2912	өнгелеу
2913	жасыл желектер
2914	аяқтау
2915	тоқтату
2916	өтілсін
2917	болсын
2918	өтілсін
2919	болсын
2920	айырбастайды
2921	сатады
2922	іске асырылатын
2923	ұсынылатын
2924	жаңғыртылатын
2925	сату
2926	айырбастау
2927	тиіп жіберу
2928	кету
2929	тіркелуші
2930	жиналыс
2931	палата
2932	тұжырым
2933	көзқарас
2934	ой
2935	ерегіс
2936	тәжікелесу
2937	сөз таластыру
2938	мемлекет басшысы
2939	елбасы
2940	сұхбат беру
2941	шиеленіс
2942	үрдіс
2943	ғылым
2944	аяқтау
2945	нұсқау
2946	кешіру
2947	жол беру
2948	мәжілісті жүргізуге 
2949	нұсқа
2950	деңгей
2951	еркін дауыс беру
2952	қалай болса солай
2953	қалыпты күйге келтір
2954	жөнге сал
2955	сәйкес келді
2956	дұрысталды
2957	халықтың дауыс беруі
2958	еркін сайлау
2959	өзгеріс жасау
2960	жақсарту
2961	қайта құру
2962	мән
2963	маңызы
2964	Көпшілік дауыс беру
2965	қалаулы
2966	элективті
2967	электоральды
2968	аман қалу
2969	қорғау
2970	қорға жинау
2971	жол бермеу
2972	арашалау
2973	тармақ
2974	бөлік
2975	тұрғызылады
2976	бой көтереді
2977	мөлшер
2978	түсінемін
2979	есептеймін
2980	түсінемін
2981	есептеймін
2982	категория
2983	іріктеу
2984	сұрыптау
2985	сарапқа салушы
2986	талдау жасайтын маман
2987	көптен бері жауабын білгісі келіп жүрген сұрақ
2988	мемлекетті басқару өнері
2989	саяси шолушы
2990	саяси комментатор
2991	құқықтық
2992	дипломатиялық
2993	аңғаршулық
2994	байқаушылық
2995	дөңгелек үстел
2996	практикалық сабақтар
2997	шашыраңқы
2998	сілдіреу
2999	тартылады
3000	ұлғайады
3001	пікір
3002	ой
3003	сұхбат
3004	төрағалық етуші
3005	жаттығу
3006	қандай да бір ақпараттық материалдарды ілуге арналған құрал
3007	өмір нәрі
3008	жәрдемші күш
3009	білгісі келді
3010	жауап күтті
3011	ауыс
3012	мәселе
3013	анкета
3014	сауал-сұрақ
3015	сұхбат
3016	қажет етушілік
3017	ауыз жаласқан
3018	жең ұшынан жалғасқан
3019	сәйкес емес
3020	жанжал
3021	соғысу
3022	күресі
3023	қою
3024	орналастыру
3025	қоя алмайды
3026	тағайынды емес
3027	сайланған
3028	ақпаратты орналастыруға арналған зат
3029	ойлану
3030	қолданыс табу
3031	іздеп табу
3032	өткізді
3033	сынақтан өту
3034	міндеттеу
3035	көп танылатын
3036	дәуірлік
3037	сала
3038	тарам
3039	тарау
3040	төлеу
3041	жөнелту
3042	жеткізу
3043	әкесінің аты
3044	 әп-сәтте
3045	шалт
3046	анықтау
3047	тергеу
3048	жауап алу
3049	артық кемі жоқ
3050	пара пар
3051	теңдей етіп
3052	бір дәреже
3053	шыңырау
3054	түбі жоқ
3055	айла
3056	әрекет
3057	әдіс
3058	табысы мол
3059	қолайлы
3060	жағдайлы
3061	қажеті шамалы
3062	арнайы
3063	тіке
3064	тұп-тура
3065	үй
3066	қора
3067	шахта
3068	жазбала
3069	Тірі жүрушілік
3070	амандық
3071	кідіру
3072	тыю
3073	тоқтау қою
3074	өшіру
3075	жетілдіру 
3076	толтыру
3077	қосылу
3078	бас қосу
3079	араласу
3080	тоқайласу
3081	жерге қарай
3082	ең бірінші басшы
3083	жиналысты басқарушы ресми тұлға
3084	шұғыл 
3085	ерекше
3086	айрықша
3087	жаттығу
3088	дайындық
3089	ұрыну
3090	душар ету
3091	тудырту
3092	пайда болу
3093	өзгерістер
3094	дұрыстаулар
3095	сәйкессіздікті жою
3096	тоқу
3097	терең сезіну
3098	білу
3099	ұғыну
3100	қойғыш
3101	іргетас
3102	ер адам
3103	кезде
3104	тежегендік
3105	тоқтам
3106	қолақ қою
3107	көрсету
3108	сездіру
3109	байқату
3110	шақ
3111	кезең
3112	мезгіл
3113	қауырт қозғалыс
3114	қарбалас
3115	дер
3116	өкім
3117	өрел
3118	жақсы тәрбие алған
3119	әңгіредей
3120	ұран
3121	дабыл
3122	шақыру
3123	бірдеме деу
3124	сөйлеу
3125	ақылға қонымды
3126	түсінікті
3127	ұғымды
3128	Ұйымдастыра білушілік
3129	жетекші
3130	қоғам
3131	мемлекеттік
3132	бір атадан тараған
3133	мәселе
3134	ой
3135	тағайымдайды
3136	жасады
3137	қолтаңба қою
3138	Нақтылы тілек
3139	тұжырымды пікір
3140	өз ойын айту
3141	қиыннан қиыстырып
3142	даусыз жағдай
3143	тағайындау
3144	міндеті
3145	қысқаша мәлімет
3146	мән жайын айтып бер
3147	қоңырау шалды
3148	жариялады
3149	айтты
3150	хабар беру
3151	мәлімдеу
3152	мағлұмдау
3153	жариялау
3154	әйгілеу
3155	ақпарат
3156	айтылған
3157	есеп берілген
3158	қоғам
3159	көпшілік
3160	адамдар
3161	халайық
3162	арыздану
3163	білгілі мөлшерге жуық
3164	борыш
3165	келісім
3166	айла
3167	әрекет
3168	шеп
3169	меже
3170	жол бермеу
3171	тежеу
3172	шек қою
3173	шектелмеген
3174	шексіз
3175	бейпіл
3176	шегі жоқ
3177	шек қойылмаған
3178	өзге ел
3179	шет аймақ
3180	шет қақпайла
3181	айтылады
3182	байлам
3183	бітім
3184	түйін
3185	ұйғарым
3186	жетекші орын
3187	басқару органы
3188	тысқа жеткізу
3189	апару
3190	жариялау
3191	ойдан табылған
3192	кему
3193	азаю
3194	өлке
3195	түптеп келгенде
3196	әсер етеді
3197	күтілетін
3198	қолайлы
3199	тиімді
3200	оңтайлы
3201	тәуелсіздендіру
3202	жүзеге асыру
3203	маман
\.


--
-- TOC entry 3756 (class 0 OID 18126)
-- Dependencies: 219
-- Data for Name: quote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quote (id, quote, quote_by, added_by, created, updated) FROM stdin;
1	Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.	Allan Kay	Sam	2022-08-04 17:04:32	\N
2	Мен қосып отырмын 	Altosh	Altosh	2022-08-05 11:46:28	\N
\.


--
-- TOC entry 3760 (class 0 OID 18160)
-- Dependencies: 223
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_id, name, description) FROM stdin;
1	user	user has minimal opportunities \n
2	admin	admin can change inforamtion in the site but not source code
3	expert	expert can see offers and has the same permetions as user
\.


--
-- TOC entry 3780 (class 0 OID 19042)
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
-- TOC entry 3778 (class 0 OID 19035)
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
-- TOC entry 3768 (class 0 OID 18297)
-- Dependencies: 231
-- Data for Name: synamizer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synamizer (id, words, words_family, status, meaning, pos, example, created_at) FROM stdin;
3897	адал	сын есім	бірмағыналы	«рұқсат етілген, тыйым салынбаған», «арам емес, таза», «кіршіксіз, пәк». Сонымен қатар «адамгершілікті жоғары қоятын, ар-ұяты күпіті» (адал адам; жүрегі адал), «сатқын емес, шын берілген» (Отанына адал), «арам жолмен таппаған, таза еңбек, маңдай тер» (адал табыс), «тура, анық, шын» (адал шешім, адал достық) деген ауыспалы мағыналарда да кеңінен қолданылады.	2	Адал адамның аты арып, тоны тозбас	2023-07-18 18:49:56.449805
3899	аз	сын есім	бірмағыналы	Мөлшердің аз көлемде екенін, шағын екенін көрсетеді.	2	Бүгіндікке табыс көзі аз болып тұр.	2023-07-21 22:09:53.757828
3903	азат	сын есім	бірмағыналы		2		2023-07-20 02:49:23.542853
3902	азаматтық қоғам	зат есім	бірмағыналы	мемлекет ісінде азаматтардың белсенді болуы 	1	Азамматтық қоғамның дамуы демократияның белгісі	2023-07-23 01:34:04.600017
3904	айғақсыз	сын есім	бірмағыналы		2	 	2023-07-24 03:40:20.932523
3905	айқақ	зат есім	бірмағыналы		1		2023-07-23 05:19:51.493324
3906	айқын	сын есім	бірмағыналы	бір заттың анық,дәл екенін көрсетеді	2	Әсіресе «Естай-Қорланда» ақынның шалқар шабыты мен азаматтық өктем үні, зор таланты әр қырынан айқын көрінеді (4,285).	2023-07-20 08:30:24.485542
3907	айқын	сын есім	бірмағыналы		2		2023-07-17 16:51:28.863249
3908	айқында	етістік	бірмағыналы		5		2023-07-18 03:09:47.954005
3909	айқындалады	етістік	бірмағыналы	белгісіз, түсініксіз нәрсені орнату, анықтау	5	Ұйым өзінің мақсаттарын анықтайтын облыстарды айқындауы керек. Ұйым мақсаттарының түрлері 2 топқа біріктірілуі мүмкін: экономикалық және экономикалық емес сипатта болады.	2023-07-22 11:41:18.251305
3910	аймақ	зат есім	бірмағыналы	республиканың бірнеше елді мекендері енгізілетін, оның мүддесі үшін құрылатын және басқарылатын республика аумағының бір бөлігі.	1	ҚХР-дағы Іле қазақ автономиялы облысына Алтай аймағы , Тарбағатай аймағы , Іле аймағы қарайды. Әр аймақ өз ішінен және жеті-сегіз ауданды басқарады.	2023-07-22 09:30:27.871065
3911	айналым	зат есім	бірмағыналы	затты, яки тауарды экспорт, импорт, сатып алу, сақтау, көтерме және бөлшек саудада өткізу.	1	Білегіңді әкелші, қан айналымың қалпында ма екен? (4,217).	2023-07-19 07:33:50.312218
3912	айрықша	сын есім	бірмағыналы	заттың ерекшелігін атап көрсету	2	Жаңа бағдарламалардың пайдасы айрықша білінеді	2023-07-20 09:01:47.157837
3935	аноним	сын есім	бірмағыналы	әр түрлі себептерге көбінесе, саяси жағдайға байланысты авторы көрсетілмей жарияланады	2	анонимдiк үгiт материалдарын таратуға тыйым салынады.	2023-07-19 14:19:53.726241
3936	ант	зат есім	бірмағыналы	Берілген уәдені ант, серт деп те атайды.	1	Берген антың қайда?!	2023-07-20 04:48:20.13404
3896	адал	сын есім	бірмағыналы	әрдайым әділдікті ұстанатын адам қасиеті	2	көлеңкелі кәсіпкерлік (бизнес), сыбайлас жемқорлық тағы басқа руханисыздықтың әсер етулерi нөлге жеткен, кәсiпкерлiк ашықта адал.	2023-07-23 08:07:09.425857
3933	алыс	сын есім	көпмағыналы		2		2023-07-20 10:01:34.826743
3889	Cаll орталық	зат есім	бірмағыналы	сауалыңызға жауап беретін арнайы байланыс орталықтары	1	Сall орталықтың тынысымен танысу мақсатында дін мамандарымен тілдескен едік.	2023-07-19 17:13:11.947448
3892	абырой	зат есім			1		2023-07-18 04:01:36.617377
3893	абырой	зат есім	бірмағыналы		1		2023-07-18 03:09:28.147286
3894	абыройлы	сын есім	бірмағыналы	Құрмет, құрмет белгісі ретінде сайланады	2	Құрметті, оған лайықты адамдар	2023-07-22 08:44:23.397527
4828	ұсыныс	зат есім	бірмағыналы	Кәсіпорын атынан басқа кәсіпорынға бағытталған белгілі бір шарт бойынша келісім-шарт жасасуға дайындығы туралы жазбаша өтініш	1	Республика Премьер-Министрі тағайындалғаннан кейінгі он күн мерзім ішінде Премьер-Министр Үкіметтің құрылымы мен құрамы туралы Республика Президентіне ұсыныс енгізеді	2023-07-18 09:54:48.104227
3913	айыппұл	зат есім	бірмағыналы	Қылмыстық кодексінде көзделген шекте, заңмен белгіленген және жаза тағайындау сәтіне қолданылып жүрген айлық есептік көрсеткіштің белгілі бір мөлшеріне сәйкес келетін мөлшерде не сотталған адамның жалақысының немесе ол қылмыс жасаған сәтіне белгілі бір кезең ішіндегі өзге де табысының мөлшерінде тағайындалатын ақша өндіріп алу (1997 жылғы 16 шілдедегі № 167 ҚР ҚК 40-бап)	1	Сайлау тақырыбында сауалнама жүргізгендерге айыппұл салынатын болады	2023-07-22 02:06:15.805707
3914	айыпты	сын есім	бірмағыналы		2		2023-07-18 17:21:35.606889
3915	айырбаста	етістік	бірмағыналы		5		2023-07-22 21:33:33.512409
3916	айырмашылық	зат есім	бірмағыналы	Қалыптан тыс өзгешелік, ерекшелік.	1	Ой адамдарының ішіндегі ақынның басқалардан айырмашылығы : қас қағымның арасында бүкіл өмірдің бүкіл бір тарихын экранда жарқ еткізіп елестетіп өтеді (4,295).	2023-07-20 00:30:06.119257
3917	айырылады	етістік	көпмағыналы	өзіне керек бір адамнан не заттан айырылу	5	Оның туысқандары Шақтыға көшетін болып, айырылу болып жатыр, барып қоштасып қайт (Гур., Маңғ.).	2023-07-18 10:52:39.001149
3918	аккредитте	етістік	бірмағыналы	уәкілетті органның «Аудиторлық қызмет туралы» ҚР Заңда көзделген кәсіби аудиторлық ұйымдардың құқықтылығын ресми тануы («Аудиторлық қызмет туралы» 1998 жылғы 20 қарашадағы № 304-1 ҚРЗ 1-бап)	5		2023-07-24 02:45:18.808122
3919	аккредиттеу	етістік	бірмағыналы	Шет мемлекеттердің, халықаралық ұйымдардың байқаушыларын аккредиттеу мерзімін Орталық сайлау комиссиясы белгілейді.	5	Аккредиттеу үшін шет мемлекеттер мен халықаралық ұйымдар Қазақстан Республикасы Сыртқы істер министрлігіне өз байқаушыларының, өкілдерінің тізімін ұсынады.	2023-07-23 16:58:13.329796
3920	акт	зат есім	бірмағыналы	заңдық маңызы бар кұжаттың атауы	1	Республика Президентінің Парламентті тарату туралы актісі қолданысқа енгізілген күн депутаттардың кезектен тыс сайлауы өткізілуге тиіс мерзімнің басталу кезі болып табылады	2023-07-19 13:56:36.274606
3921	ақпарат	зат есім	бірмағыналы	берілген уақытта жаңалықтарды құраушы болып табылатын әртүрлі мәліметтердің жиынтығы	1	Белгісіздік ақпараттың шектелуіне байланысты екі немесе одан да көп мүмкіндіктерді таңдау қажет болған кез	2023-07-20 10:50:56.617772
3922	ақпараттық	сын есім	көпмағыналы	Деректер берілген, көрсетілген, ақпараты бар	2	сайлауды ақпараттық қамтамасыз ету - сайлаушыларды сайлау науқанына әзiрлiк пен оны өткiзудiң барысы туралы, сайлау алдындағы үгiттi қоспағанда, жедел және кеңiнен хабардар етуге бағытталған шаралар кешенi	2023-07-18 19:04:27.481628
3923	ал	сын есім	көпмағыналы	Арифметикадағы санды азайту амалы.	2	Мен фотоаппаратты алуды да білмеймін (Түрікм., Таш.).	2023-07-19 23:10:03.850047
3924	алаң	зат есім	бірмағыналы	Мереке-жиын өтетін елді мекен (қала, село т.б.) ішіндегі арнаулы орын .	1	Барын киінген жұрт кеңсе алдындағы алаңға қарай аңыздап барады (4,155).	2023-07-22 22:46:13.959047
3925	алаңда	етістік	бірмағыналы	Алаңда етістігінің қимыл атауы; көңілі орнықпау, мазасыздану. 	5	өз елінің немесе өзі өмір сүретін аймақтың тағдырына алаңдаушы азамат жеке өзіне ұнаған кандидатқа немесе партияға дауыс беру және сайлау үдерісінің заң талаптарына сай өтуіне ресми бақылау жасауға үлес қосқаны жөн. 	2023-07-20 03:29:11.930501
3926	алғашқы	сын есім	бірмағыналы	Әуелгі, бастапқы, бірінші кезектегі мағына	2	Депутаттық мандаттарды бөлуге қатысатын әрбір партиялық тізім алған дауыстардың саны алғашқы сайлау бөлінді санына бөлінеді.	2023-07-24 04:16:00.227307
3927	алқалылық	сын есім	бірмағыналы	басшылық әрқайсысы белгілі қызмет саласына дербес жауапкершіліктегі уәкілетті тұлғалар (алқалық) тобы жүзеге асыратын басқару принципі	2	Сайлау комиссияларының қызметі алқалылық, жариялылық және ашықтық негізінде жүзеге асырылады	2023-07-17 10:37:08.442288
3928	алқылы	сын есім	бірмағыналы		2		2023-07-20 19:19:38.980607
3929	алмас	етістік	бірмағыналы	алма кезек ауысу	5	бірінің орнын бірі басу, ауысу.	2023-07-19 09:43:41.480269
3930	алмасу	етістік	бірмағыналы	бірінің орнын бірі басу, ауысу	5	Ғылыми-техникалық революция жерді қойып, ғарышқа бой ұрды. Өндірістегі жаңа технологиялардың алмасуы тездеді	2023-07-20 11:35:44.994451
3931	алу	сын есім	көпмағыналы	Арифметикадағы санды азайту амалы.	2	Мен фотоаппаратты алуды да білмеймін (Түрікм., Таш.).	2023-07-20 15:16:03.939485
3932	алыс	сын есім	бірмағыналы	шалғай, жақын емес жай	2	Алыс жерлерде жұмыс жасайтындарға сайлау жәшігі тікұшақпен жеткізілмек	2023-07-20 13:24:08.292833
3940	анықта	етістік	бірмағыналы		5		2023-07-21 23:25:04.044926
3934	аманат	зат есім	бірмағыналы	маңызды затты орындауға тапсырма беру/алу мағынасында	1	Халықтың аманаты басты мәселе	2023-07-17 18:03:58.368741
3937	анық	сын есім	бірмағыналы	Дәл, айқын.	2	Мен дастархан басына отыра бергенде, шам жарығы анық көрсетіп - жарқылдап Сақып отыр (Ж.Омарбеков, Сөнбе.).	2023-07-23 10:08:24.160547
3938	анық-қанық	сын есім	бірмағыналы	бір нәрсенің дәйекті ақиқаты	2	Үлкен ауыл жақтан жаңғырыққан дауыс шықты. Түнгі дауыс саңғырап, қандай анық естіледі (Ж.Аймауытов, Шығ.).	2023-07-22 14:35:20.885561
3939	анықта	етістік	көпмағыналы	бір нәрсені анықтау, орнату	5	Көбінің жазбасы өте нашар. Бұларды тергеп, тексеріп, анықтау өте қиын жұмыс (Х.Досмұхамедұлы, Шығ.).	2023-07-18 13:21:51.154819
3941	анықталған	етістік	бірмағыналы	Анықта етістігінің қимыл атауы; айқындау.	5	Конституциялық заңның бұзылуы анықталған кезде олардың шешiмдерiнің күшін жояды	2023-07-23 13:59:45.939177
3942	анықтау	етістік	көпмағыналы	бір нәрсені анықтау, орнату	5	Көбінің жазбасы өте нашар. Бұларды тергеп, тексеріп, анықтау өте қиын жұмыс (Х.Досмұхамедұлы, Шығ.).	2023-07-21 16:21:03.23936
3943	анықтылығы	сын есім	бірмағыналы	Айқындық, дәлдік мағынасында да пайдаланылады	2	Кандидат пен оның зайыбы (жұбайы) декларациялаған кірістері мен мүлкi туралы мәлiметтердiң анықтығын мемлекеттік кіріс органдары кандидат тіркелген күннен бастап он бес күн ішiнде тексереді	2023-07-18 06:00:28.612531
3944	аппарат	зат есім	көпмағыналы	Басқару ұйымдарындағы мекемелер мен қызметкерлердің жиынтығы	1	Мемлекеттік аппарат елеулі түрде жасарды	2023-07-23 10:22:29.934938
3945	аппеляция	зат есім	бірмағыналы	сайлау немесе емтихан нәтижелеріне қанғаттандай, оны қайтадан қарауға шағым түсіру	1	Бірнеше студент емтихан нәтижелеріне риза болмай аппелациялық шағым түсірді	2023-07-22 07:29:08.016211
3946	араздық	зат есім	бірмағыналы	Өзара келіспеушілік, қырғиқабақтық, өшпенділік	1	«Біреудің жеке басына тіл тигізу, жалған ақпарат беру, қоғамдық араздық тудыратын мәліметтер жасау әрекеті заң бойынша жауапқа тартылады	2023-07-20 09:12:38.959211
3947	арақатынас 	етістік 	бірмағыналы	бір-бірімен байланыс	5	Бiздiң ұсыныс - адамдармен арақатынасты бейбіт жолмен шешу (Ғ.Баймаханов, Қаратау.).	2023-07-20 17:01:38.530395
3948	аралас	сын есім 	бірмағыналы	Екі не одан да көп нәрселердің бірігіп, қосылып кетуі не өзара қарым-қатынасқа түсу, қатынаста болу .	2	Аралас жүйе деп парламенттің бір бөлігін можаритарлық жүйемен бір бөлігін партиялық тізіммен тепе теңдік жүйемен жүзеге асыруды айтады	2023-07-18 14:36:28.814757
3949	аралас	етістік	бірмағыналы		5		2023-07-19 04:23:36.950335
3950	аралас пропорционалды - мажоритарлы	сын есім	бірмағыналы	Аралас сайлау жүйесі-мажоритарлық пропорционалды жүйе.	2	Депутаттардың бір бөлігі (әдетте жартысы) заң шығарушы (өкілді) органға көпшілік сайлау жүйесі бойынша, ал екіншісі пропорционалды түрде сайланған кезде.	2023-07-22 23:15:49.856548
3951	араласу	етістік	бірмағыналы	Аралас етістігінің қимыл атауы. Араласып-құраласу, қарым-қатынаста болу. 	5	электрондық дауыс берудi өткiзуге, дауыстарды санауға, сайлау нәтижелерi туралы ақпараттарды беруге заңсыз араласып, бақылау жасауға жол берiлмейдi.	2023-07-19 20:39:54.052312
3952	арқасында 	сын есім	бірмағыналы	Еткен еңбектің нәтижесінде, еңбекпен қол жеткен.	2	Ата дәулетінің арқасында сылаңдап ерке өскен Зейнеш еді (Б. Майлин).	2023-07-18 15:21:06.872821
3953	арқау	зат есім	бірмағыналы	бір нәрсенің ұзын ырғағы, байланыстылығы	1	Сөзі жоқ бірдеңені ыңылдап, астына бөстегін төсе, арқауына мініп отыр әжей. Жап-жалтыр ағаш қылышы жалт-жұлт етеді (4,141).	2023-07-24 03:18:20.809898
3954	арнайы	сын есім	бірмағыналы	белгілі бір мақсатпен біле тұра ерекшелеп	2	Жоғарыда аталып өткен таңдамалыларды қоспағанның өзінде, қазақ совет поэзиясының бір жылғы өнімінің өзі бір адамның арнайы бір жыл отырып зерттеуіне тұрарлық дүниелер (4,306).	2023-07-18 22:13:56.676765
3955	арналған	етістік	бірмағыналы		5		2023-07-21 20:05:09.541063
3956	арттыр	етістік	бірмағыналы	Бір нәрсенің қарқыны,  қалпі бұрынғыдан жақсара түсу, түзелу.  Істің сапасын жақсарту, жоғарылату.	5	Баяндамада екінші тың деп аталған мал шаруашылығын кетеру ісі кеңінен сөз болады (Т. Ахтанов).	2023-07-21 07:07:03.856546
3962	ат	зат есім			1		2023-07-19 16:35:50.784336
3957	артықшылық	зат есім	бірмағыналы	Басымдық мағынасында пайдаланылады	1	Мемлекеттiк органдардың лауазымды адамдары болып табылатын кандидаттарға өзiнiң лауазымдық немесе қызмет жағдайының артықшылықтарын пайдалануға тыйым салынады.	2023-07-20 23:31:21.277561
4067	бойынша	шылау	бірмағыналы	Бір нәрсеге сәйкес, лайық	8	Сенат депутаттарын сайлау бойынша дауыс беру бiр күннiң iшiнде өткiзiледi.	2023-07-21 03:23:37.038852
3959	Ассамблея	зат есім	бірмағыналы	1) халықаралық ұйымдардың бірқатар басқарушылық органдарының атауы; 2) кейбір елдерде парламенттің немесе оның палаталарының бірінің атауының құрамдас бөлігі; 3) белгілі бір мәселелерді шешу немесе талқылау үшін біршама адамдардың жиналысы (халықтық және сословиелік, орталық және жергілікті); бірлестік.	1	Қазақстан халқы Ассамблеясы сайлайтын Мәжіліс депутаттарының сайлауы күні Мәжілістің партиялық тізім бойынша сайланатын депутаттар сайлауы өткізілетін күнмен дәл келмеуі мүмкін.	2023-07-18 17:11:12.483093
3960	астана	зат есім	бірмағыналы	«белгілі бір мемлекеттің саяси, мәдени орталығы», «босаға, табалдырық»	1	Сенат депутаттығына кандидат болып тиiстi облыстың, республикалық маңызы бар қаланың немесе Республика астанасының аумағында тұратын азамат ұсыныла алады.	2023-07-24 06:19:26.821603
3961	ат	зат есім	көпмағыналы	есімін білдіреді	1	Әрбiр қол қою парағының рет нөмiрi болуға тиiс және оған кандидаттың тегi, аты, әкесiнiң аты мен оның сенiм бiлдiрген адамының жеке қолы, қол жинаушының тегi, аты, әкесiнiң аты, қол жинау жүргiзiлген елдi мекеннiң атауы, сондай-ақ қол қоятын адамдар туралы мәлiметтер бар бағаналар енгiзiлуге тиiс	2023-07-23 09:39:39.75469
3963	ат	етістік			5		2023-07-22 09:09:43.637853
3964	Ата Заң	зат есім	бірмағыналы	елдің негізгі заңы; ең жоғарғы заң күші бар нормативтік акт.	1	1995 жылғы Қазақстан Республикасының Ата Заңы бүкілхалықтық референдум жолымен қабылданды.	2023-07-18 03:28:48.556109
3965	атап өтті	етістік	бірмағыналы	Қиын емес, ауырлығы жоқ, жеңіл. 	5	1969 жылы оны құрметтейтін қауым оның 150 жылдығын атап өтті (3,291).	2023-07-24 01:08:13.068776
3966	атқару	етістік	бірмағыналы	Атқар етістігінің қимыл атауы. Орындау, жұмыс істеу	5	өз актiлерiмен Үкiметке Республика Конституциясы мен заңдарында белгiленгеннен басқа атқару мiндеттерiн жүзеге асыруды жүктеуге хақылы	2023-07-21 19:52:03.596438
3967	атқарушы	зат есім	бірмағыналы	Заң шығарушы биліктің қабылдаған заңдарын атқару міндетін орындаушы лауазым иесі	1	Әрбір сайлаушы сайлау жарияланған немесе тағайындалған кезден бастап тиісті жергілікті атқарушы органда сайлаушы ретінде тіркелуге құқылы.	2023-07-23 21:39:45.93639
3968	атқарушы билік	зат есім	бірмағыналы	белгілі бір территориялық аумақтағы шаруашылық-әкімшілік басқару органы	1	Атқарушы билік сайлауға дайындық жұмыстарын бастап кетті	2023-07-20 01:52:29.20173
3969	атсалыс	етістік	бірмағыналы	бұл біреудің басқа адамдармен бірге жасайтын әрекеті.	5	Профильді қалыптастыруға табу жоспарланған қызметкердің тікелей басшысы және персонал менеджері қатысуы керек.	2023-07-20 14:03:06.972216
3970	аудандық	сын есім	бірмағыналы	Аудан көлеміндегі, ауданға тән, қатысты	2	Учаскелiк сайлау комиссиясы аудандық (қалалық) және облыстық мәслихаттар депутаттарын сайлау кезінде дауыс беру нәтижелерi бойынша хаттамалар жасайды, олар дереу тиiстi сайлау комиссиясына (аудандық, қалалық, қаладағы аудандық) жіберіледі.	2023-07-23 03:56:06.119575
3971	аудармашы	зат есім	бірмағыналы	Бір тілден екінші тілге аудару ісімен шұғылданатын маман	1	Аудармашы білімді, екі тілді де еркін білетін, жазу-сызуға ебі бар адам болуға тиіс («Қаз. әдеб.»).	2023-07-19 00:27:06.710521
3972	ауқымды	сын есім	бірмағыналы	Көлемі үлкен, аялы, кеңдік, көлемділік	2	Оның атқарар қызметі басқалармен салыстырғанда анағұрлым ауқымды болатын	2023-07-19 08:45:27.586395
3973	аулақ	сын есім	бірмағыналы	алыста болуды білдіреді	2	таңдау құқығының болуы, яғни тек бір ғана кандитатты тіркеуден аулақ болу	2023-07-22 21:00:43.838313
3974	аумақтық	сын есім	бірмағыналы	Белгілі бір аумаққа ғана сәйкес.	2	Дөңдегі томпиып-томпиып жатқан аумақтық қорымның ішіндегі ең еңселісі разақ әулиенікі (Н.Сералиев, Қанат).	2023-07-19 10:50:33.020925
3975	ауылдық округ	зат есім	бірмағыналы	ең кіші әкімшілік бірлік	1	Аылдық округте екі сайлау участкесі орналасқан	2023-07-21 03:56:45.177035
3976	ауыр	сын есім	бірмағыналы	 Науқастану, сырқаттану, дертке шалдығу	2	. Жәмила аяқ астынан ауырып, ауруханаға түсе қалды (Б.Қыдырбекұлы, Ешкім.). 	2023-07-20 01:09:03.199214
3977	ауыр	етістік			5		2023-07-23 19:16:12.71109
3978	ауыстыр	етістік	бірмағыналы	Бір нәрсені екіншісімен алмастыру .	5	Әкесі басшыларға кіріп жүріп сменасын ауыстыртты («Қазақст. әйелдері»).	2023-07-23 20:03:47.308898
3979	аш	сын есім			2		2023-07-22 13:57:16.833265
3980	аш	етістік			5		2023-07-19 22:18:09.328107
3981	ашу	зат есім	көпмағыналы	жабық тұрған затты ашу	1	Қорытып айтқанда, 100 абсолютті инновация ғылыми-техникалық серпіліс үшін жағдай жасап, өнеркәсіптік даму мен Қазақстанда жаңа жұмыс орындару ашу үшін қуатты серпін береді.	2023-07-24 05:56:20.963109
3982	ашық	сын есім	бірмағыналы	Жасырын емес түрде жүргізілетін процесс	2	Комиссиялардың шешімдері, осы Конституциялық заңда белгіленгеннен өзге жағдайларды қоспағанда, олардың мүшелерінің жалпы санының көпшілік даусымен ашық дауыс беру арқылы қабылданады.	2023-07-22 03:02:14.928351
3983	әділ	сын есім	бірмағыналы	адамның қызметі, оның табиғи және ажыратылмайтын құқықтары мен міндеттері туралы көзқарастарға сәйкес келетін адами өзара қатынастардағы істердің дұрыс, тиісті болу идеясын білдіретін моральдық және құқықтық сананың түсінігі, ұғымы	2	Егер бұрыннан жағымсыз қылықтары байқалмаса арамдық ниеті болмаса мұсылман атаулы әділ болып есептеледі.	2023-07-23 02:11:09.840435
3984	әділдік	зат есім	бірмағыналы	адамның өмір сүру жағдайлары мен сапасын білдіретін әлеуметтік-этикалық категория	1	Сайлаудағы басты қағидаттардың бірі әділдік	2023-07-18 07:36:00.19736
3985	әзірле	етістік	бірмағыналы	Әзірле етістігінің қимыл атауы. Сайлау, қамдау, дайындық жасау.	5	Қозының дені сау, ширақ болып тууы саулықтарды күйекке жақсы әзірлеу және ұрықтандыру, буаз кезіндегі азықтандырылу жағдайына байланысты (М.Төлешов, Қой. қоздату). 	2023-07-22 17:08:49.791344
3986	әкел	етістік	бірмағыналы	Белгілі бір нәрсені алып келу, жеткізу.	5	Артельдің ауыл маңына үйілген маясынан сұраусыз шөп әкелуге болмайды (С.Мұқанов, Бақташы.).	2023-07-20 17:08:18.557277
3987	әкесінің аты	зат есім	бірмағыналы	Адамның әкесінің аты көрсетіледі	1	партиялық тізімге енгізілген әрбір адамның тегін, атын, әкесінің атын, туған жылын, атқаратын қызметін (жұмысын), жұмыс орны мен тұрғылықты жерін көрсете отырып, тіркелгені туралы хабар жариялайды	2023-07-21 07:02:04.903573
3988	әкім	зат есім	бірмағыналы	Қазақстан Республикасының Президенті тағайындайтын Қазақстан Республикасындағы территориялық бірліктегі жоғары лауазымдық тұлға.	1	Осы күзде ауыл әкімдерінің сайлауы өтпек	2023-07-20 10:49:03.641437
3989	әкімдік	сын есім	бірмағыналы	Елге билік жүргізушілік, мансап құрушылық.	2	Немене? Жетім-жесірдің аулы ма бұл, біз әкімдік жүргізетін, – деді Абай Майбасарға (М. Әуезов).	2023-07-23 22:22:52.010356
3990	әкімшілік	зат есім	бірмағыналы	басқаруды жүзеге асыратын мемлекеттік органдар; мемлекеттік органның, сондай-ақ қоғамдық ұйымнан басқа кез-келген ұйымдардың атынан әрекет ететін басқарушы қызметкерлер, лауазымды тұлғалар	1	Әкімшіліктің құрылымын облысты, ауданды, қаланы басқарудың схемасына сәйкес анықтап, әкімнің ұсынуымен мәслихат бекітеді	2023-07-18 16:35:27.423157
3991	әлеумет	зат есім	бірмағыналы	Қоғамдық, өмірлік, қоғамга тән	1	Қазақстан Республикасы өзін демократиялық, зайырлы құқықтық және әлеуметтік мемлекет ретінде орнықтырады, оның ең қымбат қазынасы - адам және адамның өмірі, құқықтары мен бостандықтары (ҚР Конституциясы).	2023-07-21 09:27:57.725968
3992	әлеуметтік	сын есім	бірмағыналы	Қоғамдық, өмірлік, қоғамга тән	2	Қазақстан Республикасы өзін демократиялық, зайырлы құқықтық және әлеуметтік мемлекет ретінде орнықтырады, оның ең қымбат қазынасы - адам және адамның өмірі, құқықтары мен бостандықтары (ҚР Конституциясы).	2023-07-17 14:56:47.596726
3993	әлеуметтік желі	зат есім	бірмағыналы	жеке тұлғалар немесе ұйымдар «бір торапқа» айналған, өзара достасу, ортақ қызығушылық, сексуалды қарым-қатынас, абырой-бедел, эмоция және мәселеге сәйкес өзара байланыс орнатуға арналған әлеуметтік құрылым	1	Әлеуметтік желілер арқылы сайлауға үгіттеу заңмен шектелмейді	2023-07-20 14:43:52.930339
3994	әліпби	зат есім	бірмағыналы	әріптер жиынтығы, алфавит	1	Орталық сайлау комиссиясының қаулысымен партия алған депутаттық мандаттарды бөлу мемлекеттік тілдің әліпбилік ретімен тіркелген тізімдерге сай жүзеге асырылады.	2023-07-21 00:14:03.381823
3995	әңгімелес	етістік	бірмағыналы	Әңгімелес етістігінің қимыл атауы.	5	Он жыл бірге оқып, бірге өсіп, бірер сағат әңгімелесуге қақым бар ғой деп ойлаймын (4,222).	2023-07-23 19:54:00.423956
3996	әралуан	сын есім	бірмағыналы	әртүрлі мағынасында	2	Әралуан түске бөленген аспан әдемі көрініспен көмкеріліп тұр	2023-07-22 09:01:13.958382
3997	әріптес	зат есім	бірмағыналы		1		2023-07-18 13:55:45.604628
3998	әрқилы	сын есім	бірмағыналы	әртүрлі мағынасында	2	Бақытқа бастар жол әрқилы болуы мүмкін	2023-07-18 17:33:43.230747
3999	әсер	зат есім	көпмағыналы	Сырттай бір құбылыстан, қимыл-әрекеттен болатын ықпал.	1	Оның саған да тигізген әсері білініп тұр.	2023-07-18 13:53:03.833845
4001	баға	зат есім	көпмағыналы	Қазақ тілінде «тауардың, қызметтің т.б. нәрселердің ақшаға шаққандағы құны» деген ұғымды білдіреді.	1	Алманың бағасы қанша?	2023-07-23 08:41:27.416313
4002	баға	зат есім	көпмағыналы	1. Тауардың құны ақшамен белгіленуі, баға көлемі тауардың құнының деңгейіне және тауарға деген сұраныс пен ұсыныс қатынастарына байланысты. 2. Адамның қадір-қасиеті, парқы	1	кандидаттар мен партиялық тiзiм ұсынған саяси партиялардың қызметiне жария баға беруден аулақ болуға мiндеттi	2023-07-18 00:59:38.018807
4004	бағалы	сын есім	бірмағыналық	заттың құнын атап көрсету	2	Бағалы кеңес алу бәрінен қымбат	2023-07-18 05:20:24.061977
4005	бағдарлама	зат есім	бірмағыналы	1. белгіленіп отырған іс-әрекеттің, жұмыстардың жоспары; 2. орындалатын рөлдердің, нөмірлердің, сөзсөйлеушілердің, хабарлар мен орындаушылардың басылған көрсеткіші.	1	Мемлекет кандидаттарға өз бағдарламаларымен бұқаралық ақпарат құралдарына шығу үшiн қаражаттың тең бөлiнуіне кепiлдiк бередi.	2023-07-19 05:07:40.364219
4006	бағын	етістік	бірмағыналы	біреудің Кеңесіне, нұсқауларына құлақ асыңыз, біреуге бағыныңыз, бағыныңыз	5	Ата-анаңыздың айтқанын тыңдаңыз	2023-07-22 01:32:47.124222
4007	бағынысты	сын есім	бірмағыналы	Біреуге бағынатын, тәуелді	2	Бағынышты адамдай байыппенен аттадым	2023-07-22 16:02:45.914032
4008	бағыт	зат есім	бірмағыналы	Бір жаққа қарай бет түзеді, бағытталуды сипаттайды.	1	Әдебиеттегі, әдебиет майданындағы теріс бағыттармен күресу үшін пролетариат бағытын қолданатын жазушылардың ұйымын жасау керек (С.Сейфуллин).	2023-07-21 20:12:50.473128
4009	база	зат есім	бірмағыналы	негіз, бір заттың негіздемесі	1	Біліктілік арттыру курсы мектеп базасында өткізілді	2023-07-20 00:05:39.869593
4010	байқа	етістік	бірмағыналы		5		2023-07-18 04:25:00.488624
4011	байқаушы	зат есім	бірмағыналы	Дауыс беру процесінің адал өтуін қамтамасыз етуді көздейтін тұлға, қадағалаушы 	1	Дауыстарды санау кезiнде қатысатын сенiм бiлдiрiлген адамдар мен байқаушылар дауыстарды санауды бюллетеньдердегi белгілердiң көрiнiп тұруы қамтамасыз етiлетiндей қашықтық пен жағдайда байқап тұрады.	2023-07-23 15:40:13.021709
4012	байсалды	сын есім	бірмағыналы		2		2023-07-23 06:33:06.528468
4013	байсалдылық	зат есім	бірмағыналы		1		2023-07-23 00:27:57.37443
4014	байыпты	зат есім	бірмағыналы	Сабырлы деген мағынада қолданылады.	1	Желқайыққа отырды ұстаз игілікті, байыпты , Мен де міндім әдеппенен ұстазыма лайықты, Сездім сонда екеумізді ауырлаған қайықты (5,39).	2023-07-23 16:43:22.113014
4015	бақыла	етістік	бірмағыналы	Бақыла етістігінің қимыл атауы	5	Экономиканы сауықтыру және макроэкономикалық жұмыспен қамту және инфляция деңгейін бақылау, экономикалық өсуді ынталандыру	2023-07-19 02:42:02.795771
4016	бақылаушы	зат есім	бірмағыналы	белгілі бір процесті қадағалайтын түлға	1	бақылаушы ел ретінде ұйымға мүше болу	2023-07-19 17:05:36.518545
4017	балама	сын есім	бірмағыналы	Екінші бір заттың, атаудың орнына жүретін, соған тең, барабар, сай келетін нәрсе, атау.	2	Олардың барлығы сөз, жиналыс, қозғалыс бостандығын, олардың саяси көзқарастарының естілуі үшін және олар сайлаушыларға балама кандидаттарды ұсына алуы үшін қажеттінің барлығын пайдалана алады.	2023-07-23 04:38:05.88185
4018	баламалы	сын есім	бірмағыналы	заттың басқа да алмастыруға болатындығын білдіру	2	Баламалы энергия көздерін ашу жаңа заман талабы	2023-07-18 03:32:32.561819
4019	бап	зат есім	бірмағыналы	Кітаптың тарау, бөлімі	1	Конституция 9 тараудан, 98 баптан тұрады.	2023-07-20 20:41:04.725413
4020	бару	етістік	бірмағыналы	Бар етістігінің қимыл атауы; алға жылжу, ілгерілеу, қозғалу.	5	Ертең ана кісінің үйіне бару керек еді.	2023-07-18 12:57:34.880591
4021	бас қолбасшы	зат есім	көпмағыналы	Бас-бұл адамдар мен жануарларда болатын дененің бөлігі.	1	әскери және әкімшілік лауазымдарының атауы	2023-07-20 17:16:22.038391
4027	басты	сын есім	көпмағыналы		2		2023-07-23 15:52:04.792595
4022	бас тарт	етістік	бірмағыналы	болдырмау мақсатында жасалатын әрекет	5	Орталық сайлау комиссиясының Президенттiкке кандидатты тiркеуден бас тартуына немесе тiркеу жөнiндегi шешiмнiң күшiн жоюына байланысты кандидат сотқа шағым беруі мүмкін	2023-07-24 01:36:38.713083
4023	басқар	етістік	бірмағыналы	Әр алуан ортаның (әлеуметтік, биологиялық, техникалық) белгілі бір құрылымын сақтап, әрекет ету режимін қолдау, олардың мақсат-мұраттарын жүзеге асыруды қамтамасыз ету үшін ұйымдастырылған жүйенің кызметі.	5	Басқару адам тұрмысының ажырамас бөлігі, онсыз адамдардың ортақ қызметі де, жалпы қоғам да мүмкін емес.	2023-07-20 10:29:50.051401
4024	баспа	зат есім / етістік	бірмағыналы	Баспа өнімдерін дайындап шығаратын мекеме.	1	баспа, дыбыс-бейне және өзге де үгiт материалдарын шығару және (немесе) тарату жолымен жүзеге асырылады.	2023-07-19 10:04:25.211559
4068	бола алмайды	етістік	бірмағыналы	болмау	5	Өнерде шәкірт бола алмаған, Ұстаз бола алмайды мақал	2023-07-24 04:58:54.589592
4025	баспасөз	зат есім	көпмағыналы	мерзімді және мерзімсіз басылымдардың жиынтық атауы.	1	Осы жылға дейін Қазақстанда өткен сайлауда журналистер орталық сайлау комиссиясының баспасөз орталығынан ақпарат таратып келген	2023-07-18 23:37:31.840077
4026	басталды	етістік	бірмағыналы	бір нәрсе қатарында бірінші болып, бір нәрсені ашыңыз	5	Мұндағы экскурсия мұражайдың мәдени-білім беру қызметінің қалыптасуы басталған дәстүрлі түрлердің бірі.	2023-07-17 12:17:34.558126
4029	басшылық ету	етістік	бірмағыналы	реттеуге, қорғауға, қойылған мақсатқа сай нысанның жүйесін өзгертуге немесе жоюға бағытталған, субъектінің нысанға әрекет ету процесі	5	Басшылық ету адам іс-әрекетінің түрі ретінде адамдардың бірлесіп қызмет ету пайда болғаннан бар	2023-07-20 21:19:42.827264
4030	басылым	зат есім	бірмағыналы	Баспа орнынан басылып шыққан кітап, журнал және басқа да шығармалар.	1	мерзімді баспасөз басылымының таралымы барлық кандидаттар, партиялық тізімдерін ұсынған саяси партиялар үшін бірдей болуға тиіс.	2023-07-18 13:28:54.892516
4031	батыл	сын есім	бірмағыналы		2		2023-07-21 20:57:49.542839
4032	баянда	етістік	бірмағыналы	Суреттеу арқылы оқиға мен сюжетті баяндау. 	5	Олар өздерінің идеяларын, ұстаным­дарын баяндауға толық мүмкіндік алды.	2023-07-20 22:27:16.729625
4033	баяндады	етістік	омоним	Мейманның немесе келушінің келгені туралы  хабарлау.	5	Конституциясында баянды етілген адамның тұратын жерін еркін таңдау құқығын, еңбек бостандығын, қызмет пен кәсіп түрін еркін тандауың, кету бостандығын қамтамасыз ету.	2023-07-20 13:49:44.018854
4034	баяндалған	етістік	бірмағыналы	Суреттеу арқылы оқиға мен сюжетті баяндау.\n	5	Ұлжан панфиловшыл жиырма сегіз батырдың ерлік істері туралы да баяндаған (Ж. Тілеков).	2023-07-23 13:48:30.378615
4035	бедел	зат есім	бірмағыналы	Белгілі бір адамның, топтың, қоғамдық ұйымның, әлеуметтік институттың жалпы жұрт қабылдаған, мойындаған қабілеті мен еңбегі	1	сот кандидаттың және (немесе) оның сенiм бiлдiрiлген адамдарының басқа кандидаттың ар-намысы мен қадiр-қасиетіне нұқсан келтiретін, оның iскерлік беделiн түсiретiн жалған мәлiметтердi тарату фактiсiн анықтаған	2023-07-22 23:18:19.703503
4036	беделді	сын есім	бірмағыналы		2		2023-07-19 11:22:53.77962
4037	бейнежазба	зат есім	бірмағыналы	Видео жасау 	1	Байқаушылар дауыс беру барысына кедергі жасамай, бейнежазба жасауларына болады	2023-07-23 14:11:20.334649
4038	бейнеле	етістік	бірмағыналы		5		2023-07-22 00:03:53.623002
4039	бейтарап	сын есім	бірмағыналы	парсы тіліндегі мағыналары «бейтарап (нейтралды)», «әділ, объективті». Қазақ тілінде «ешкімге қосылмай, оқшау жүру», «енжар, селқос», «қалыс қалу» тәрізді ұғымдарда қолданылады	2	Құрыштай бойындағы ерекше бір қасиет - ол еш нәрсеге бейтарап қарай алмайды	2023-07-24 04:52:00.393259
4040	бейтарап	сын есім	бірмағыналы		2		2023-07-22 19:35:45.316926
4041	бекіт	зат есім	көпмағыналы	белгілі бір істің қайталануын болдыратын стимул.	1	мемлекеттік биліктің жоғары органының осы мемлекет немесе үкіметі атынан толық құқылы өкілі қол қойған халықаралық шартты бекітуі.	2023-07-18 13:42:35.453664
4050	бәсеке	зат есім			1		2023-07-22 13:43:35.76389
4042	белгі	зат есім	бірмағыналы	құрылымдық ұйымдастырылған белгілік жүйедегі нысан қасиеттерін енгізу болып табылатын ақпараттың элементарлық бірлігі	1	сайлаушылар тiзiміне тиiсті белгі қойылады. Бюллетеньге қарындашпен белгі қоюға, сондай-ақ оған қандай да бір түзетулер енгізуге жол бермеңіз.	2023-07-23 04:26:37.961661
4043	белгілі	сын есім	бірмағыналы	 Ел ішінде беделді, атақ-даңқы асқан (адам)	2	Келген кісілердің ішінде бұл өңірдің белгілі ірі байлары - Мыңбай, Жүзбай, Жылқыбай бар (Ә.Нұрпейісов, Сергелдең).	2023-07-22 12:19:33.808894
4045	бер	етістік	бірмағыналы	белгелі бір затты біреуге ұстату	5	Президент Жарлығына сәйкес жылда барлық деңгейдегі әкімдер халық алдында есеп беретін.	2023-07-23 18:44:52.894981
4046	берiледi	етістік	бірмағыналы	іс әрекеттің өткізілуі	5	Қызметкерлерге берілетін сыйақы – ұйымның қызметкерлерге олар көрсеткен қызметтің орнына ұсынылатын сыйақылардың жəне төлемдердің барлық түрлері.	2023-07-19 03:31:46.743136
4047	берме	етістік	бірмағыналы	 бой бермеу, көнбеу.	5	Жандықтар жікідей (қ.) балаға ие беруші м(е) еді, өзің барың (Түрікм., Мары).	2023-07-21 01:33:37.94632
4048	бетбұрыс	зат есім	бірмағыналы	өмірдегі өзгерістер	1	Еліміздегі саяси реформалар ұлы бетбұрысқа бет алудың белгісін көрсетеді	2023-07-17 10:38:20.985757
4112	дауыс	зат есім	омоним	дауыс берді	1	Сайлауда дауыс беру	2023-07-21 15:45:24.464027
4049	бәсеке	зат есім	бірмағыналы	Екі тарап арасындағы талас, тартыс; бақталастық	1	Қазақстан беделді халықаралық ұйымдардың белсенді мүшесі бола отырып, өзі қабылдаған ерікті және бәсекелі сайлау өткізу жөніндегі барлық міндеттемелерді ұстанады.	2023-07-18 15:04:28.62185
4052	бәсең	сын есім	бірмағыналы	Қазақстан Республикасы азаматтарының Қазақстан Республикасының Президентi, Қазақстан Республикасы Парламентiнiң, мәслихатының депутаты немесе жергiлiктi өзiн-өзi басқару органына мүше болып сайлану құқығы.	2	Қазақстан Республикасы азаматтарының Қазақстан Республикасының Президентi, Қазақстан Республикасы Парламентiнiң, мәслихатының депутаты немесе жергiлiктi өзiн-өзi басқару органына мүше болып сайлану құқығы.	2023-07-20 03:19:11.200884
4053	билік	зат есім	көпмағыналы	Басқарушылық, басшылық, әкімшілік.	1	Қазағым, бұл ғадетті тасталық та,\n\nХалықты тура жолға басталық та.\n\nВолост, билік, ауылнайлық, выборныйлық,\n\nҚимайтұғын соншама падишаһлық па? (М.Дулатов, Шығ).	2023-07-20 03:58:30.310048
4054	билік	зат есім	бірмағыналы	қоғамда қалыптасқан нормалар мен құндылықтарға сүйенетін және олардың қолданылуын заңдастыратын күш.	1	Демократиялық сайлау – бұл бәсекелі, мерзімді және өкілдік сайлау, оның процесінде кең еркіндікке ие азаматтар билік құрылымдарына өздерінің өкілдерін балама негізде сайлайды.	2023-07-19 15:05:37.127626
4055	біл	етістік	бірмағыналы	Білдір етістігінің қимыл атауы	5	. Ол осындай әңгіменің үстінде өзінің әкелік үстемдігін б і л д і р у үшін Жанайға өстіп кекесінмен мәнсіз жымиып қойып сөйлесетін (С.Мұратбеков, Көкорай)	2023-07-19 18:26:57.249338
4056	білдіреді	етістік	бірмағыналы	мағынасын көрсету	5	Бүгінгі тарихшылар бұл сөздің не мағына беретінін дәл таба алмай сан-саққа апарып, қиналуда	2023-07-18 23:15:29.259553
4057	біржолата	үстеу	бірмағыналы	белгілі бір істі түбегейлі шешу мағынасында	9	Мен шетелден елге біржолата оралдым	2023-07-19 23:09:45.924606
4058	бірізді	сын есім	бірмағыналы	жүйелі болуын қамтамасыз етеді	2	Бұдан кейінгі тараулар сайлауды байқау жөніндегі миссиялардың жедел қызметіне арналған және белгілі бір қисынды бірізділікпен беріліп отыр. 	2023-07-22 16:42:56.449932
4059	Біріккен Ұлттар Ұйымы	зат есім	бірмағыналы	халықаралық бейбітшілік пен қауіпсіздікті сақтау жəне нығайту, өзара ынтымақтастықты дамыту мақсатында егемен мемлекеттердің өз күштерін ерікті түрде біріктіре отырып, 1945-ші жылдың 26-шы маусымында Сан Франциско қаласында құрған халықаралық ұйымы	1	Адам құқықтары жөніндегі кеңес-құрамына бүкіл әлем бойынша барлық адам құқықтарын көтермелеуге және қорғауға жауапты 47 мемлекет кіретін БҰҰ жүйесінің үкіметаралық органы.	2023-07-22 23:51:45.638748
4060	бірқатар	үстеу	бірмағыналы	Көлем жағынан аз емес, саны әлденеше,көбірек	9	Әрине, жобадағының бәрін бірден орната алмассың, бірқатарын биыл салсақ, бірқатарын келесі жылдардың үлесіне қалдырамыз	2023-07-17 13:19:54.693154
4061	бірлес	етістік	бірмағыналы	Бірлес етістігінің қимыл атауы.	5	Сайлау комиссиялары жергілікті атқарушы органдармен және жергілікті өзін-өзі басқару органдарымен бірлесіп, бөлінген үй-жайда кандидаттардың сайлаушылармен кездесулер кестесін жасайды және оны бұқаралық ақпарат құралдарында жариялайды.	2023-07-22 12:29:12.317662
4062	бірлестік	зат есім	көпмағыналы	Бірнеше саладағы ұйымның немесе өндіріс мүшелерінің, ұжымның бірігіп, ұйымдасқан түрі	1	Бірлестік құрамы мен орындайтын міндетіне қарай стратегиялық, оперативтік-стратегиялық, оперативтік немесе оперативтік тактикалық болуы мүмкін	2023-07-20 05:16:42.749205
4063	бірлесу	етістік	бірмағыналы	Бірлес етістігінің қимыл атауы.	5	Сайлау комиссиялары жергілікті атқарушы органдармен және жергілікті өзін-өзі басқару органдарымен бірлесіп, бөлінген үй-жайда кандидаттардың сайлаушылармен кездесулер кестесін жасайды және оны бұқаралық ақпарат құралдарында жариялайды.	2023-07-22 14:25:43.268143
4065	біртұтас	сын есім	бірмағыналы	Бөлінбейтін, бірімен-бірі байланысты, бір бүтінге айналған	2	Өзара тығыз байланысты біртұтас халық шаруашылық комплексі жасалды	2023-07-22 18:53:14.468598
4066	бірыңғай	сын есім	бірмағыналы	Түр жағынан өзара ұқсас келген біркелкі, бірдей	2	Біз бірге бірыңғайлап әрекет етіп, жұмыс жасағанға қалай қарайсың?	2023-07-23 15:40:55.974878
4069	болатын	етістік	бірмағыналы	болашаұта өтетіін оқиға	5	Қазақстанда әр бала басты кейіпкер болатын персоналды кітап жарық көреді	2023-07-18 15:29:19.627469
4070	болжал	зат есім	бірмағыналы		1		2023-07-19 13:48:04.408638
4071	болжам	зат есім	бірмағыналы	құбылыстардың болашақтағы жағдайы, тенденциялары және даму кезеңдері, үдерістері немесе оқиғалары туралы ғылыми негізделген ықтимал пікірлер мен пайымдаулар	1	дауыс беру нәтижелерiнiң болжамдарын дауыс берiлетін күннің алдындағы бес күн ішінде және дауыс берiлетiн күні Интернет желісінде жариялауға жол берілмейдi.	2023-07-20 16:16:22.720487
4072	болуы мүмкін	етістік	бірмағыналы	іс әрекеттің орындалуының мүмкіндігі	5	бүгінгі іс әрекетіңіз ертеңгі жетістігіңіздің себебі болуы мүмкін	2023-07-18 14:01:40.563367
4073	бопса	зат есім	бірмағыналы		1		2023-07-22 04:56:29.256576
4074	босат	етістік	бірмағыналы	іс әрекетті орындамаса болады	5	Еңбек кодексінде жұмыстан босату үшін бірнеше себеп қарастырылған.	2023-07-22 05:32:16.268657
4075	босату	етістік	көпмағыналы	Босат етістігінің қимыл атауы. Еркіндікке шығару, азат ету	5	мiндеттерiн атқарудан босату туралы өз еркiмен өтiнiш берген	2023-07-23 00:04:38.384718
4076	бостандық	зат есім	бірмағыналы	Еркіндік, өз биліғі өзінде болушылық, еріктілік.	1	Саяси бостандық ұғымы азаматтардың саяси белсенділігін, саяси өмірде ұдайы қатысып, әлеуметтік мәні зор шешімдер қабылдау ісіне тікелей ықпал етуге қабілеттілігін арттырады	2023-07-22 20:15:55.201946
4077	бостандық	зат есім	бірмағыналы		1		2023-07-22 09:48:15.877178
4078	бөгде	зат есім	бірмағыналы	Бөтен, жат, бейтаныс мағынасында қолданылады	1	Сайлау комиссиясының үй-жайында сайлау процесіне қатысы жоқ бөгде адамдардың болуына тыйым салынады.	2023-07-17 22:28:24.65263
4079	бөл	етістік	бірмағыналы	Бөлшектерге ұсақталған	5	Үстел үстінде алма жуылып бөлінген екен. 	2023-07-18 21:34:00.267254
4080	бөлік	зат есім	көпмағыналы	Бірнешеге бөлінген тұтас нәрсенің бір бөлігі.	1	Қандай істердің алқабилердің қатысуымен қаралатыны ҚПК 291-бабының екінші бөлімінде көрсетілген, яғни облыстық және оған теңестірілген соттар қарайтын өлім жазасы қолданылатын баптар қаралатын қылмыстық істер алқабилердің қатысуымен жүргізелетіндігі жөнінде тұтас бөлік енгізілген («Егемен Қазақстан»).	2023-07-22 10:10:44.766349
4081	бөлімше	зат есім	бірмағыналы	әскери қарулы күштердегі 6 — 12 адамнан жасақталатын ең төменгі тактикалық жауынгерлік топ	1	қарама-қайшылықтар бар, бұл салааралық баланстың қоғамдық ұдайы өндіріс модельдер індег і бөлімшелер ара сындағ ы бал анспен түйісуге қызмет ете алмайды	2023-07-20 18:26:42.810202
4082	бөлінген	етістік	бірмағыналы	Бөлшектерге ұсақталған	5	Үстел үстінде алма жуылып бөлінген екен. 	2023-07-18 04:06:38.104797
4083	бөліс	етістік	бірмағыналы	Әркімге белгілі бір нәрсені тарату, бөліп беру	5	Біздің борыш белгілі, тек ағайыншылықпен ғана емес, адамгершілікпен, ар-ожданмен барды бардай, жоқты жоқтай бөлісу	2023-07-23 10:59:11.110434
4084	бүкілхалықтық 	сын есім	бірмағыналы	Барша халыққа ортақ	2	Жароковтың «Жапанды орман жаңғыртты» поэмасында ой айқындығы мен дара жан сезімі б ү к і л х а л ы қ т ы қ оқиғамен қойындасып кеткен (С.Мәуленов, Үркер.)	2023-07-19 13:34:01.657302
4085	бүлінген	етістік	бірмағыналы	Бүлін етістігінің қимыл атауы. Жарамсыз болу, бұзылу	5	Дауыс беру учаскесіндегі сайлаушылар түгел дауыс берген соң, пайдаланылмаған және бү­лінген бюллетеньдер саналады.	2023-07-21 07:06:48.228886
4086	бүтіндігі	сын есім	бірмағыналы	тұтастық мағынасында қолданылады	2	Дауыс беру кезеңіне 30 минут қалғанда сайлау комиссияларының төраға­лары комиссия мүшелерінің қаты­суымен дауыс беру жәшіктерінде бюллетеньдердің бар-жоғын қарап, оның бүтіндігін тексеріп, жәшіктерді дауыс беру үшін бекітіп, мөрлеп қойды.	2023-07-19 14:31:37.896942
4087	бұз	етістік	бірмағыналы	Дағдылы, үйреншікті, қалыпты жағдайды бүлдіру, өзгерту.	5	Хабарламаға сүйенсек, сайлау кезінде ешқандай заң бұзушылық орын алмаған. 	2023-07-23 11:34:20.921991
4088	бұқара	зат есім	бірмағыналы	халықтың басқарушы топтан өзгелері	1	Бұқара халық электораттың негізін құрайды	2023-07-18 20:22:13.276828
4089	бұқара	зат есім	бірмағыналы		1		2023-07-19 02:14:58.738049
4090	бұқаралық ақпарат	зат есім	бірмағыналы	халыққа ақпарат жеткізу құралдары	1	Бұқаралық ақпарат құралдарын пайдалана отырып сайлауға қатысты мағлұматтар толықтай жеткізілуде	2023-07-22 22:51:48.719192
4091	бұрмала	етістік	бірмағыналы	Бұрмала етістігінің қимыл атауы; басқа бағытқа бұрып, теріс түсінік беру	5	белгi қарындашпен қойылған, түзету немесе өзге де бұрмалау iздерi бар, сондай-ақ сайлаушылардың ерiк бiлдiруiн анықтау мүмкiн емес бюллетеньдер жарамсыз деп танылады.	2023-07-21 07:15:52.678219
4092	бұрмалау	етістік	бірмағыналы	Бұрмала етістігінің қимыл атауы; басқа бағытқа бұрып, теріс түсінік беру	5	белгi қарындашпен қойылған, түзету немесе өзге де бұрмалау iздерi бар, сондай-ақ сайлаушылардың ерiк бiлдiруiн анықтау мүмкiн емес бюллетеньдер жарамсыз деп танылады.	2023-07-19 18:54:52.10749
4093	бұрмалаушылық	зат есім	бірмағыналы	бұрмалап, терістеп көрсету	1	Кітап ішінде бұрмалаушылық белгілері білінеді	2023-07-17 11:39:20.571618
4094	БҰҰ	зат есім			1		2023-07-18 19:03:56.891173
4095	бюджет	зат есім	бірмағыналы	Белгіленген уақыт кезеңі ішінде жобаланатын кірістер мен шығыстардың мәлімдемесі.	1	 Б ю д ж е т т і ң пайда болуы, мемлекеттің дамуы оның қаржы ресурстарына деген сұраныстың артуымен тікелей байланысты (ҚҰЭ).	2023-07-22 00:04:25.530286
4096	бюллетень	зат есім	көпмағыналы	Кандидаттардың аты-жөндері жазылған дауыс беруге арналған парақ. Қоғамдық үлкен мәні бар оқиға жайындағы қысқаша ақпараттық хабарлама. Белгілі бір мекеменің өз қызметі жөнінде жаңа мәліметтер беретін уақытша басылымы	1	Президенттi және Парламент депутаттарын сайлау жөнiндегi сайлау алдындағы науқанның барысы туралы сайлаушыларды хабарландырып отырады, мерзiм-мерзім ақпарат бюллетенін шығарады	2023-07-22 09:04:16.273649
4097	вакцинация	зат есім	бірмағыналы	(мед.) адам организміне вакцина немесе арнайы тәсілмен дайындалған антигендік қасиеті бар заттарды енгізу арқылы белгілі бір жұқпалы аурудан алдын ала сақтандыру үшін қолданылатын әдіс.	1	1885 жылы 6 маусымда дүниежүзінде бірінші рет Париж қаласында Пастердің станциясы ашылып, онда в а к ц и н а ц и я (құтырма ауруына қарсы алдын ала профилактикалық егу) жүргізіле бастады (Н.Әжіғалиев, Мал. ауру.).	2023-07-17 23:07:56.049836
4098	ведомство	зат есім	бірмағыналы	Мекеменің құрамына енетін түрлі қызметтер мен ұйымдардың жалпы атауы	1	Қазақстан Республикасының бұрынғы Денсаулық сақтау министрлігінің ведомстволық бұйрығымен сот сараптауларының мерзімі 30 тәулік деп белгіленген	2023-07-20 08:18:49.987659
4099	вице-министр	зат есім	бірмағыналы	Министрдің орынбасары лауазымы; осы лауазымды атқаратын адам	1	Алайда тергеушілер вице-министрді өліміоның кәсіби қызметімен байланысты деп санайды.	2023-07-20 20:00:46.718654
4100	гендерлік	сын есім	бірмағыналы	Адамдардың жыныс ерекшелігімен байланысты	2	Шақыруда миссия саны мен құрамына, сондай-ақ миссияда гендерлік балансты, елдік өкілдікті қамтамасыз етуге қатысты тілектер қамтылуы мүмкін.	2023-07-20 03:38:00.10738
4101	гибридті	сын есім	бірмағыналы	аралас болып келетін сайлау жүйесі	2	Гибридтік сайлау жүйесі мажоритарлық және пропорционалдық сайлау жүйелерінің синтезі, яғни кандидаттарды мажоритарлық жүйедегідей сайласа, оларды ұсыну жағы пропорционалдық сайлау жүйесіне сәйкес ресімделеді.	2023-07-22 13:35:24.343953
4120	денсаулық	зат есім	бірмағыналы	Адам ағзасының қалыпты жағдайы, есен-саулықты, сонымен қатар ауру-сырқауының жағдайы.	1	Жекелеген сайлаушылар денсаулық жағдайына, отбасының сырқат мүшесiне күтiм жасау себебiне, сондай-ақ сайлау учаскелерi құрылмаған шалғайдағы және қатынасу қиын аудандарда болуына байланысты дауыс беруге келе алмаған жағдайда,  сайлаушылардың тұрған жерiнде дауыс берудi ұйымдастыруға тиiс.	2023-07-21 03:43:16.088846
4102	ғимарат	зат есім	бірмағыналы	адамдардың тұруына немесе ішінде болуына, өндірістік процестерді орындауға, сондай-ақ материалдық құндылықтарды орналастыруға және сақтауға пайдаланылатын функционалдық мақсатына қарай, міндетті түрде жер бетіне салынып, тұйық көлемді құрайтын, тірек және қоршау конструкцияларынан тұратын жасанды құрылыс.	1	Үгiт материалдарын ескерткiштерге, ескерткіш тұғырларға, тарихи, мәдени немесе сәулеттiк құндылығы бар үйлер мен ғимараттарға, сондай-ақ дауыс беруге арналған үй-жайларға iліп қоюға тыйым салынады.	2023-07-19 21:39:15.944171
4103	дайында	етістік	бірмағыналы	Дайында етістігінің қимыл атауы.	5	Солдаттар халықтың арасын ашып, келетін жолды дайындады да, төмен қарай шаба жөнелді (Ә. Әбішев)	2023-07-17 14:56:26.198462
4104	дайындау	етістік	бірмағыналы	Дайында етістігінің қимыл атауы.	5	Солдаттар халықтың арасын ашып, келетін жолды дайындады да, төмен қарай шаба жөнелді (Ә. Әбішев)	2023-07-23 00:15:47.566012
4105	дайындық	етістік	бірмағыналы	Бір әрекетті орындауға әзірлікті білдіреді. Әзірлік, даярлық мағыналарында қолданылады. 	5	Сайлау науқанына дайындық барысы пысықталды.	2023-07-24 01:11:54.774812
4106	дайындықсыз	сын есім	бірмағыналы		2		2023-07-22 04:57:40.996954
4108	дамыт	етістік	бірмағыналы	Дамыт етістігінің қимыл атауы	5	Жақсы аударманың әдеби тілімізді дамытуға, оның сөз қоры мен синтаксистік мүмкіндіктерін байытуға себепші болуына да құштармыз біз	2023-07-23 03:59:55.419325
4109	дамыту	етістік	бірмағыналы	Дамыт етістігінің қимыл атауы	5	Жақсы аударманың әдеби тілімізді дамытуға, оның сөз қоры мен синтаксистік мүмкіндіктерін байытуға себепші болуына да құштармыз біз	2023-07-18 14:28:23.985409
4110	дау	зат есім	бірмағыналы		1		2023-07-19 00:47:46.356862
4111	дау дамай	зат есім	бірмағыналы		1		2023-07-21 18:53:51.765326
4113	дауыс беру	етістік	бірмағыналы	бұл ұсынылған үміткерлерді сайлау мәселесі бойынша сайлаушылардың еркін білдіретін, сайлау процесінің шешуші сатысы. Дауыс беру сайлау бюллетені немесе арнайы машиналардың көмегімен жүргізіледі.\n	5	Бұл кездегі сайлау ашық дауыс берумен өтетін (Ш.Өтепов, Өшп. жалын).	2023-07-20 01:30:03.982748
4114	дебат	зат есім	бірмағыналы	өзекті мәселелер бойынша пікірталас	1	Жастардың дебат өткізуге сүранымы артып келеді	2023-07-24 07:28:28.808693
4115	декларация	зат есім	бірмағыналы	1) заңды шаралардың негізгі қағидаларын үкіметтің немесе партияның атынан ресми түрде мәлімдеу; 2) мағлұмдама; мәлімдеме, бір немесе бірнеше мемлекеттің халықаралық саясаттың белгілі бір мәселесі туралы бірігей жасайтын мәлімдемесі; 3) мағлұмдама; мағлұмдау хат; мағлұмхат (кеден алымы алынатын тауарлардың тізімін әйгілеу); 4) салық төлеуші адамдардың өзінің мүлкі, кіріс мөлшері жайын хабарлап отыратын мәлімдемесі.	1	кандидаттың және оның зайыбының (жұбайының) активтер мен міндеттемелер туралы декларацияларды тапсырғаны туралы мемлекеттік кіріс органының анықтамаларын тапсырады	2023-07-22 05:31:37.794715
4116	делегация 	зат есім	бірмағыналы	қандай да бір ұйымның немесе мемлекеттің форум, съезд, конференция, халықаралық келіссөздерде және т.б. мүддесін қорғайтын тұлғалар тобы (делегаттар).	1	Біртұтас экономикалық кеңістік құрушы төрт мемлекет делегациясы өкілдерінің мәслихаты жетінші рет Астанада өтті («Жас Алаш»).	2023-07-21 08:12:37.654546
4117	демократия	зат есім	бірмағыналы	1) жоғарғы өкімет билігі халықтың қолында болатын мемлекет құрылысы; 2) мәселені шешуге барлық ұжым мүшелері қатыстырынын, белгілі бір ұжымды басқару әдісі.	1	Қазақстан деморкатиялы мемлекет. ЕҚЫҰ-ның Копенгаген кеңесінің құжатына (1990 ж.) енгізілген демократиялық сайлаудың жалпыға танымал принциптеріне сәйкес ашықтық және жариялық жағдайларында өтеді.	2023-07-23 01:23:57.722735
4118	демократиялық	сын есім	бірмағыналы	биліктің негізгі көзі халық екендігін білдіреді	2	Сайлаудың негізі қағидаттарының бірі халықтың демократиялық таңдау жасауы 	2023-07-21 21:26:38.017697
4119	демонстрация	зат есім	бірмағыналы	1) бір нәрсені көпшілік алдында жариялы түрде көрсету (кинофильм демонстрация, көрмедегі өнер туындыларының демонстрация және т.б.); 2) қоғамдық-саяси көңіл-күйді, талаптарды, наразылықтарды, ынтымақтастықты (мерекелік демонстрация, үкіметке қарсы демонстрация, соғысқа қарсы демонстрация) көрсететін бұқаралық шеру.	1	Өткен аптаның соңында әлемді дүрліктірген демонстрациялар болды	2023-07-17 22:44:57.217955
4121	деңгей	зат есім	бірмағыналы	Бір нәрсенің шегі, шені; тұсы.	1	Барлық деңгейдегi мәслихаттар депутаттарының кезектi сайлауы бiр мезгiлде өткiзiледi және мерзiмі жөнiнен Президент сайлауына, Парламент Сенаты сайлауына тұспа-тұс келмеуге тиiс.	2023-07-23 17:55:58.018694
4122	депутат	зат есім	бірмағыналы	заң шығарушы немесе өкілетті органға белгіленген тәртіпте сайланған тұлға.	1	Тағы да екі-үш жыл өткеннен кейін өзінің (Мақпалдың) әкесі Жоғарғы Советке д е п у т а т болып сайланды (Ө.Қанахин, Мұрагер)	2023-07-19 22:49:46.563129
4123	дер кезі	зат есім	бірмағыналы	Өз уақтысында, дәл уағында	1	мүдделі жақтың ұйымдастыруымен арнайы адамдар бірнеше учаскелерге барып, бірнеше рет дауыс беруі мүмкін және оны дер кезінде біле алмайсың, тап басып ұстай алмайсың, өте қиын	2023-07-17 19:26:52.626268
4124	дербес 	сын есім	бірмағыналы	жеке адамның қайталанбайтын, өзіндік болмысы, өзінің субъектісі түрінде оның мақсаты мен мән-мағынасы болатын іс-қимылы. 	2	 Қазақ музыка білгірлерінің зерттеулеріне қарағанда, өз атымен шығаратын д е р б е с күйшілер типі он тоғызыншы ғасырдың бас кезінде ғана қалыптасады (М.Мағауин, Көк кептер).	2023-07-23 06:17:02.217312
4125	дербестік	зат есім	бірмағыналы	жеке адамның қайталанбайтын, өзіндік болмысы, өзінің субъектісі түрінде оның мақсаты мен мән-мағынасы болатын іс-қимылы	1	Талдама оңтай – нәрсені бұтарлап, мүшелеп, ұсақтай түсіндіргенде қолданатын оңтай (А.Байтұрсынов, Шығ.).	2023-07-20 22:51:07.32957
4127	дәлел 	зат есім	бірмағыналы	дәлелдеме процесінде пайдаланылатын дәлел, нақты факт.	1	Артым бос, айтар тас буын,\n\nЖоқ тұғын менің дәлелім (2,143).	2023-07-17 16:33:27.697712
4128	дәлелде	етістік	бірмағыналы		5		2023-07-23 14:23:06.010206
4129	дәріс	зат есім	бірмағыналы	мектеп, медреселердегі,университеттегі сабақ	1	Сондықтан, бүгінгі мұражай өз аудиториясына дәстүрлі экскурсиялар өткізу мен дәрістер оқуға қарағанда, рекреациялық бағдарламаларға көп көңіл бөлуі тиіс.	2023-07-19 07:39:36.343862
4130	дәстүрлі	сын есім	бірмағыналы	әлеуметтік немесе этникалық ортаға тән құбылыс	2	Сайлау науқаны нәтижесі бойынша дәстүрлі бас қосулар өтті	2023-07-21 12:16:42.451657
4131	директор	зат есім	бірмағыналы	компанияның, кәсіпорынның немесе оқу орнының басқарушысы, басшысы, бастығы	1	Қазіргі таңда, педагогиканың бірнеше зерттеу түрлері аныұталып, баянадалады.	2023-07-18 21:46:08.982788
4132	дін	зат есім	бірмағыналы	Құдайға сенетін бар адамдарды моральдық қауымдастыққа біріктіретін, қасиетті дүниелермен байланысты нанымдар мен тәжірибелер жүйесі.	1	діни бiрлестiктерге сайлау алдындағы үгiттi жүргiзуге, кез келген сайлау алдындағы үгiт материалдарын таратуға тыйым салынады.	2023-07-24 03:35:56.077566
4133	дода	зат есім	бірмағыналы	парсы тіліндегі мағыналары «үйме, үйінді», «көпшілік халық». Қазақ тілінде «жарыс, бәсеке» деген ауыспалы мағынада қолданылады.	1	бұл партиялар ішінен жаңарып, тазарып, әлі күнге дейін додадан түспей отыр.	2023-07-21 19:01:32.643821
4134	достық	зат есім	бірмағыналы		1		2023-07-22 09:22:13.248367
4135	дүние	зат есім	көпмағыналы	жалпы мағынасында — бүкіл әлем, ғалам	1	нақты мағынасында — дүние жүзі, яғни Жер бетіндегі елдердің бәрі	2023-07-20 14:33:13.644517
4136	дұрыс	сын есім	бірмағыналы	Тиісті ереже нормаға сай, тура, бабымен	2	сайлау – азаматтардың билікке, мемлекетті басқару саласына араласуын қамтамасыз ететін маңызды құрал. Оны дұрыс пайдалану қарапайым халық пен мемлекетті басқару аппаратына тікелей тәуелді.	2023-07-18 02:47:40.234155
4137	дұрыста	етістік	бірмағыналы		5		2023-07-23 06:18:12.813119
4138	дыбысжазба	зат есім	бірмағыналы	Дыбыс жазу	1	Байқаушылар дауыс беру барысына кедергі жасамай, дыбысжазба жасауларына болады	2023-07-17 23:46:23.692698
4139	екіұшты	сын есім	бірмағыналы	екі түрлі деген мағынада	2	Екіұшты сөздер халықтың зығырданын шығарды	2023-07-23 16:00:20.848973
4140	ел	зат есім	бірмағыналы	Қауымдастық не шекарасы нық бекіген мемлекет.	1	Мырзакеш, ел-жұртының қамын ойлайтын нағыз азамат екен,-деді өз сөздеріне кәміл сенген Томар ақсақал.	2023-07-21 19:30:13.895159
4141	енген	етістік	бірмағыналы	Жарамды болды, заңды айналымға кірді.	5	Конституциялық заң күшiне енгеннен кейiн пайда болған құқықтық қатынастарға қолданылады	2023-07-19 22:30:37.858024
4142	енгіз	етістік	бірмағыналы	Қолданысқа кіргізу, тәжірибеге пайдалану.	5	Кеншілер руда шығарудың ең өнімді жаңа жүйелерін жасап, рудниктерде енгізу мәселелеріне негізінен баса көңіл бөлуде (Қ.Сәтбаев, Қазақстан.).	2023-07-20 06:00:41.941393
4143	енгізеді	етістік	бірмағыналы	 Қолданысқа кіргізу, тәжірибеге пайдалану.	5	Ауыспалы егіс тәртібін енгізу  үшін егіс көлемінің құрылымы жөніндегі мәселені дұрыс шешу қажет (М.Ерлепесов, Суармалы егін.).	2023-07-18 22:51:56.473179
4144	енгізу	етістік	бірмағыналы	Енгіз етістігінің қимыл атауы. 1. қосу, кіріктіру, кіргізу.\n2. Қолданысқа кіргізу, тәжірибеге пайдалану. 3. құру, ұйымдастыру, іске қосу.	5	Дауыстарды санау басталғаннан кейін сайлаушылар (таңдаушылар) тiзiмдерiне өзгерістер енгізуге тыйым салынады.	2023-07-23 01:06:11.947325
4145	енжар	сын есім	бірмағыналы	бейімсіздік, құлықсыздық мағынасында	2	Келіссөздер барысында жастар жағы енжарлық танытты	2023-07-23 19:30:10.955404
4146	ереже	зат есім	көпмағыналы	Белгілі бір іс-әрекеттің, оқиғаның, құбылыстың арақатынасы, заңдылығы көрініс табатын қағида. Қандай да бір мемлекеттік органның немесе оның құрылымдық бөлімшесінің мәртебесі мен белгілейтін нормативтік құқықтық келісім	1	Президенттiкке кандидаттар ұсыну осы Конституциялық заңда белгiленген ережелерге сәйкес жүзеге асырылады	2023-07-22 07:40:27.029189
4147	ереже	зат есім	бірмағыналы		1		2023-07-20 04:08:49.576198
4148	ерекше	сын есім	бірмағыналы		2		2023-07-21 21:06:01.329691
4149	ерекшелік	зат есім	бірмағыналы	әр заттың жеке дара белгілері	1	Көптеген елдер өз ерекшеліктерін ескере отырып, ұлттық ақпараттандыру бағдарламаларын қабылдады.	2023-07-18 18:45:30.944161
4150	ерікті	сын есім	бірмағыналы	Өз еркі өзінде, ықтиярлы; құқылы, тәуелсіз іс-әрекеттер мен адамды сипаттайды.	2	Мен – қазақпын азат қыз, е р і к т і ұлмын, жер бетінде Антейден берік тұрмын (Ж.Молдағалиев, Шығ.).	2023-07-19 19:58:41.139907
4151	еркін	сын есім	бірмағыналы	Өз еркі өзінде, ерікті (кісі).	2	сайлаушылардың еркін білдіруін анықтау мүмкін емес бюллетеньдер жарамсыз деп саналады, демек Сіздің дауысыңыз ескерілмейді.	2023-07-22 20:56:01.991595
4152	еркіндік	сын есім	бірмағыналы	Еркін болушылық, еріктілік.	2	Саяси еркіндік - мемлекет конституциясы кепілдік беріп, заң бойынша қамтамасыз етілетін азаматтардың, демократиялық түрде еркін саяси үрдістерге қатысу құқықтары	2023-07-23 19:40:01.01037
4153	есеп	зат есім	көпмағыналы	 нәрсенің, құбылыстың, үрдістің өлшемі, мөлшері, амалы, тәсілі, әдісі дегенді білдіреді. 	1	Әр істің барысында есеп жүргізген абзал.	2023-07-23 02:58:59.308151
4154	есепке алу	етістік	бірмағыналы	тізімге қосуды білдіреді	5	Таратылған мәліметке сәйкес, қаулымен 2022 жылғы 5 маусымда республикалық референдум өткізу кезінде дауыс беру құқығын беретін есептен шығару куәлігін беру және есепке алу Орталық сайлау комиссиясының 2009 жылғы 8 сәуірдегі қаулысымен бекітілген тиісті қағидаларға сай жүзеге асырылады	2023-07-17 21:48:09.289625
4155	есепте	етістік	бірмағыналы	саналу, есепке алыну	5	Әлішер Навои шығармаларының бір томдығынан басқа қазақ тіліне аударылған кітаптар саны ондап есептеледі (Ғ. Мүсірепов).	2023-07-24 04:22:57.229132
4156	есептен шығар	етістік	бірмағыналы	тізімнен алып тастауды білдіреді	5	Қоса беріліп отырған Дауыс беру құқығын беретін есептен шығару куәліктерін беру және есепке алу қағидалары бекітілсін	2023-07-22 06:15:55.020963
4157	ескер	етістік	бірмағыналы	Ескерт етістігінің қимыл атауы; бір нәрсені ойына салу, хабардар ету	5	«Қайтарыңда маған соғарсың» деген ескертуден кейін Смағұл шығып кетті (Ж.Еділбаев, Буырқанған.).	2023-07-20 22:05:34.983659
4158	етемін	етістік	бірмағыналы	бір істі орындаймын	5	Егер түзелмеймін десе, заңмен міндеттеп болсын, мәселені шешуге кірісетінін шарт етеді.	2023-07-20 15:51:08.970756
4159	Еуразиялық	сын есім	бірмағыналы	Еуразия континентіне тән, қыртысты.	2	Бұл еуразиялық мәдени типке, Ресей тарихы мен орыс діліне шығыс «тұрандық», негізінен татар-моңғол жаугершілігінен қалған түркі-татарлық ықпалы зор болған (Мәдени- филос. энцикл.сөздігі).	2023-07-20 18:45:02.988665
4160	жабдықта	зат есім	бірмағыналы	Жабдықта етістігінің қимыл атауы. 	1	Алғашқы екі күн колхоздың жаңадан ашылған дәрігерлік пункті ж а б д ы қ т а у м е н өтті (Т.Ахтанов, Көк құлан). э	2023-07-23 16:15:53.902991
4649	сарала	етістік	бірмағыналы	Сарала етістігінің қимыл атауы. Сұрыптау, таңдау, іріктеу.	5	Жалпы, салмақтап, саралап қарасақ, осы жыл еліміз үшін өте күрделі кезең болды.	2023-07-22 17:29:38.001967
4161	жабық	сын есім	бірмағыналы	Ашық емес, бекітулі	2	Парламент Мәжілісі депутаттары партиялық тізім негізінде сайланады, яғни пропорционалды жүйенің ішінде «жабық тізімі» қолданылады.\nБарлық құқықтар қорғалған. EL.KZ белсенді сілтемені пайдаланыңыз: https://el.kz/news/archive/proportsionaldy_saylau_zh-yesi_turaly_ne_bilemiz/	2023-07-23 01:05:28.578805
4162	жағдай	зат есім	бірмағыналы	Хал-ахуал, тұрмыс-жай	1	Алматы қаласында эпидемиялық жағдай қиын (ауыр) болып тұр.	2023-07-21 20:02:43.035112
4164	жағымпаз	сын есім	бірмағыналы		2		2023-07-22 11:13:39.010824
4165	жаза	зат есім	көпмағыналы		1		2023-07-18 09:11:54.978629
4166	жаза 	зат есім	бірмағыналы	. Қазақ тілінде «істеген кінәсінің, қылмысының өтеуі» деген мағынада да қолданылады.	1	 Мұсылмандық ережелерден шегінгендер немесе ол ережелерді дұрыс атқармағандар үш түрлі жазаға кесілетін еді: бірінші жаза – шапалақтау, екінші жаза – таяқпен дүрелеу, үшінші жаза – темір шыбықпен (шомполмен) соғу (X. Ақназаров). 	2023-07-22 21:10:33.655168
4167	жазбаша	сын есім	бірмағыналы	Қағаз бетіне түскен күйде; құжат түрінде	2	Кандидаттардың және партиялық тiзiмдерiн ұсынған саяси партиялардың бұқаралық ақпарат құралдарына шығу кезектілігі жазбаша өтініштердің келiп түсу ретiмен не егер өтiнiштер бiр мезгiлде келіп түссе, жеребе бойынша белгiленедi.	2023-07-19 01:25:17.54208
4168	жақсарт	етістік	бірмағыналы	Жақсарт етістігінің қимыл атауы	5	Осы күнгі фабрика- заводтың оқу жүйесін барынша батыл түрде жақсарту қажет	2023-07-22 10:50:26.873558
4169	жақта	етістік	көпмағыналы	Біреуді қолдау, қоштау, сөзін сөйлеу	5	Жақтасаң да өзің біл, даттасаң да, Соттасаң да еркің бар, ақтасаң да. Мен де жұмбақ адаммын, оны да ойла, Мыңмен жалғыз алысып жатпасам да (М.Мақатаев, Шығ.)	2023-07-24 06:40:54.264718
4170	жақтас	зат есім	көпмағыналы	Бір пікірлес, ниеттес	1	Сайлау алдындағы үгiт - сайлаушылардың белгiлi бiр кандидатты, саяси партияны жақтап немесе қарсы дауыс беруге қатысуына түрткi болу мақсатындағы қызмет.	2023-07-20 08:43:59.726025
4171	жақтас	сын есім 	көпмағыналы	Бір пікірлес, ниеттес	2	Сайлау алдындағы үгiт - сайлаушылардың белгiлi бiр кандидатты, саяси партияны жақтап немесе қарсы дауыс беруге қатысуына түрткi болу мақсатындағы қызмет.	2023-07-18 20:01:24.458738
4172	жалға	етістік	бірмағыналы	Заттың я уақиғаның бір шектен арғы ұламы.	5	Бес-ақ тиыны билет боп, қалғаны қолдан-қолға жалғасумен иесін табады (Ғ.Сланов, Замана.).	2023-07-18 19:20:09.282206
4173	жалған	сын есім	бірмағыналы	Шындығы жоқ, өтірік дегенді білдіреді	2	Жалған дауыс жинап ел болашағын тонауға жол бермеу	2023-07-20 22:12:11.268482
4174	жалған	сын есім	бірмағыналы		2		2023-07-20 09:32:13.952956
4175	жалғасады	етістік	бірмағыналы	Заттың я уақиғаның бір шектен арғы ұламы.	5	Бес-ақ тиыны билет боп, қалғаны қолдан-қолға жалғасумен иесін табады (Ғ.Сланов, Замана.).	2023-07-18 09:06:25.648448
4176	жалпыға бірдей	сын есім	бірмағыналы	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2023-07-20 04:43:17.460611
4177	жалпыжұрт	зат есім	бірмағыналы	Барлық, күллі, бүкіл деген мағынада да пайдаланылады	1	Хаттаманың көшiрмесi жалпыжұрттың танысуы үшiн сайлау учаскесiнiң үй-жайындағы арнайы белгiленген орынға дереу iлiнедi және үй-жайда екi күн бойы тұрады.	2023-07-18 22:40:30.128117
4178	жалпыұлттық	сын есім	бірмағыналы	Бүкіл ұлтқа тəн, жалпыхалықтық	2	Əскербасылықтан Əбілқайырдың аулақтауы сөйтіп əуелі қазақтың жалпыұлттық ұранынан аздырды (Қ. Тоқмырзин, Керзаман, 3, 260)	2023-07-19 12:15:35.464253
4195	жария	сын есім	бірмағыналы		2		2023-07-19 07:42:19.918518
4179	жалпыхалықтық	зат есім	бірмағыналы	барлық халыққа ортақ мағынасында	1	Жалпыхалықтық референдум басталып кетті	2023-07-23 09:44:33.795295
4199	жариялау	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы. Баспаға беру, бастырту, мәлімдеу, басу	5	Мен өзімнің қолжазбаларымды «Куба әсерлері» деген атпен жариялау ойымда бар (Б.Момышұлы, Шығ.).	2023-07-19 15:59:58.183767
4180	жанама	сын есім	бірмағыналы	Қосымша, қосалқы, үстеме мағынасында қолданылады	2	1. Сенат депутаттарын сайлау жанама сайлау құқығы негізінде жасырын дауыс беру жолымен жүзеге асырылады. 2. Республикадағы сайлауды қаржыландыруға, олардың қандай да болмасын тiкелей немесе жанама түрде республикадағы сайлауды қаржыландыруға қатысуына тыйым салынады.	2023-07-21 10:17:32.244272
4181	жанама сайлау	зат есім	бірмағыналы	Парламент Сенаты депутаттарын сайлауға таңдаушылардың – мәслихаттар депутаттары болып табылатын Қазақстан азаматтарының қатысуы. Таңдаушылар сайлауға тең негізде қатысады және олардың әр­қайсысы бір дауысқа ие	1	Республика Парламентi Сенатының депутаттарын сайлау жанама сайлау құқығы негiзiнде жасырын дауыс беру жағдайында өткiзiледi.	2023-07-18 21:35:55.156692
4182	жануар	зат есім	бірмағыналы	ірі организмдер дүниесіндегі негізгі екі топтың бірі (екіншісі – өсімдіктер)	1	жүруге және сезінуге бейім тіршілік иесі	2023-07-21 11:39:32.255563
4183	жаңа	сын есім	бірмағыналы	Өңі кетпеген, әрі түспеген, ұсталмаған .	2	 Аяңдап келем көшемен,\nАңырап әрбір жаңа үйге.	2023-07-21 00:40:52.066653
4184	жаңаша	сын есім	бірмағыналы		2	Батыста оқыған адамдар жаңаша көзқарасты ұстанады	2023-07-24 03:11:09.257643
4185	жаңғырт	етістік	бірмағыналы	Объектіні жаңарту процесі, оны жаңа талаптар мен нормаларға, техникалық шарттарға, сапа көрсеткіштеріне сәйкес келтіру	5	Соңғы жылдары сол ұмытылған аспаптарды тауып, оларды жаңартып жасау, қайта жаңғырту жөнінде бірқатар жұмыстар істелді («Білім және еңбек»). 	2023-07-24 05:24:16.412975
4186	жаңсақ	сын есім	бірмағыналы	Әдейі істейін деп істемеген, байқаусыздан кеткен қылық 	2		2023-07-22 23:21:19.266629
4187	жаңсақтық	зат есім	бірмағыналы	Әдейі істейін деп істемеген, байқаусыздан кеткен қылық 	1	Әрбiр азамат (таңдаушы) сайлаушылар тiзiмдерiндегi өзi туралы деректердi тексеруге және тiзiмге енгiзiлмегенi, дұрыс енгiзiлмегенi немесе тiзiмнен шығарып тасталғаны, сондай-ақ тiзiмдердегi сайлаушы (таңдаушы) туралы деректерде жаңсақтық жiберiлгенi үшiн шағымдануға құқылы	2023-07-22 16:51:56.658327
4188	жаһан	зат есім	бірмағыналы	Идеялардың, ресурстардың, тәжірибелердің және адамдардың байланысы жергілікті жүйеде емес, негізінен, бүкіл әлемдік деңгейде жүзеге асатын процесс.	1		2023-07-20 08:21:01.085978
4189	жаһандан	зат есім	бірмағыналы	Идеялардың, ресурстардың, тәжірибелердің және адамдардың байланысы жергілікті жүйеде емес, негізінен, бүкіл әлемдік деңгейде жүзеге асатын процесс.	1	 Меніңше, жаһанданудың астарын түсіндіру үшін, дүниежүзі философиясын оқып танысудың қажеттігі жоқ («Қаз. әдеб.»).	2023-07-23 19:24:00.290405
4190	жаппай	сын есім	бірмағыналы		2		2023-07-17 16:29:36.685421
4191	жарақта	етістік	бірмағыналы	Жарақтандыр етістігінің қимыл атауы; жабдықтандыру, керекті құрал-жабдықпен қамтамасыз ету.	5	оларды стендтермен, тақталармен, тұғырлықтармен жарақтандырады.	2023-07-23 02:20:29.513387
4192	жарамды	сын есім	көпмағыналы	Көңіл толатын, жағымды, қолайлы, ұнамды.	2	Есіл өмірді ескерусіз, босқа жарамсыз қылықпен қор етіп өткізді (Абай, Тол. жин.).	2023-07-17 17:11:34.61562
4193	жарамсыз	сын есім	көпмағыналы	Көңіл толмайтын, жағымсыз, қолайсыз, ұнамсыз.	2	Дауыстарды тiкелей санау кезiнде жарамсыз сайлау бюллетеньдерi дауыс беруге қатысқан сайлаушылардың (таңдаушылардың) бюллетеньдерi қатарынан алып тасталады.	2023-07-24 05:51:49.431703
4194	жарғы	зат есім	бірмағыналы	мемлекеттік немесе өзге саяси билік жеке тұлға, қала, одақ немесе өзге ұйымға айрықша қызметті жүзеге асыру үшін арнайы құқық, болмаса басымдық беру	1	Партия жарғысына сәйкес уәкілетті адамдар қолдарын қойған және мөрмен расталған, саяси партия өкілін жіберу туралы акт тиісті сайлау комиссиясына жіберіледі.	2023-07-20 10:20:02.25164
4196	жария	етістік	бірмағыналы		5		2023-07-22 21:37:30.345468
4197	жариялаған 	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы.	5	 Сонымен қатар Республика Конституциясы Президентке заң жобасын қарауда басымдық беруді анықтауға, сондай-ақ заң жобасын жедел қажет деп жариялауға құқық береді («Егемен Қазақстан»).	2023-07-23 01:06:11.456624
4198	жариялады	етістік	бірмағыналы	Жарияла етістігінің қимыл атауы	5	Барша қазақстандықтар үшін рефрендум жайлы онлайн газеттерде жарияланған болатын.	2023-07-20 21:53:45.0758
4241	жолдау	зат есім 	көпмағыналы	Жолда етістігінің қимыл атауы; жіберу, арнап жазу	1	Қазақстан халқына биылғы Жолдауында баяндалғанын жария етті.	2023-07-17 20:11:47.980101
4200	жариялылық\nжариялық	зат есім	бірмағыналы	жұртшылық үшін ақпараттық өнімнің қолжетімділігі	1	Кез келген қоғамдық мәні бар әрекет туралы ашық әрі толық ақпарат беру және оны көпшіліктің ашық талқылау мүмкіндігі бар демократия принциптерінің бірі. Өйткені мұндай жариялылық көптеген теріс түсініктерге жетелейтіндігі белгілі	2023-07-20 19:50:59.632869
4201	жарқын	сын есім	бірмағыналы	 нұры жайнаған. 	2	 Қызу қарқын, көңіл шат, Шығады жарқын дауыстар. 	2023-07-21 04:41:52.942376
4202	жарлық	зат есім	бірмағыналы	мемлекет басшысымен шығарылатын маңызды актілердің атауы.	1	Отан қорғау ісіне көмегі тиер деп, бізді жұмысқа шақырған жарлық шықты (Ә.Бөкейханов, Шығ.)	2023-07-18 01:32:00.469564
4203	жарна	зат есім	бірмағыналы	Белгілі бір ұйымға мүше болғаны үшін төленіп тұратын қаржы	1	саяси партияның сайлау жарнасын енгізгенін растайтын құжат	2023-07-17 09:44:33.362544
4204	жарыспалы	сын есім	бірмағыналы	Жарыса жүретін, қабаттаса қолданылатын.	2	Осы міндеттер атқарылу үшін сайлау жалпыға бірдей, тең, төте (жанама сайлаудың демократиялығы төмен), жарыспалы, ерікті түрде өтуге тиіс.	2023-07-20 04:42:41.82826
4205	Жас	зат есім	бірмағыналы	ҚР он төрт жастан жиырма тоғыз жасқа дейінгі азаматтары	1	Қазіргі жастар құрылыстар мен ірі зауыттардың не екенін біледі.	2023-07-23 05:32:34.260703
4206	жаса	етістік	бірмағыналы	белгілі бір тапсырманы орындау	5	Егер бұлай жасау кімде-кімнің қолынан келе қалса, ол ерекше жанға айналады, ал хәкімше айтсақ: табанының топырағы көзге сүртерлік адам сол болады.	2023-07-20 17:33:52.627049
4207	жасырын	сын есім	бірмағыналы	Ашық түрде емес, құпия жасалынатын іс-әрекеттерді сипаттайды.	2	Осы түн ел әбден ұйықтаған кезде Абай мен Ербол үй тонайтын ұрыларша жасырын бұғып, ептеп басып кеп Асылбек отауының есігіне жетті (М.Әуезов, Абай).	2023-07-21 05:03:35.972068
4208	жасырын	сын есім	бірмағыналы	астыртын, байқатпай, білдірмей деген мағынаны білдіреді	2	Жанымда менің жасырын жатқан вулкан бар, Жалынын атпай, Жасырын ғана бұрқанған.	2023-07-19 05:52:40.526766
4209	жат	етістік	бірмағыналы	біреумен қарым-қатынаста немесе бір нәрсемен байланыста болудың белгілі бір сипатын көрсету	5	Пайда ұйым мақсатының негізгі бола алмайды, өйткені ол ішкі мәселелер қатарына жатады	2023-07-19 00:56:22.341622
4210	жатады	етістік	бірмағыналы	біреумен қарым-қатынаста немесе бір нәрсемен байланыста болудың белгілі бір сипатын көрсету	5	Пайда ұйым мақсатының негізгі бола алмайды, өйткені ол ішкі мәселелер қатарына жатады	2023-07-20 18:09:32.044629
4211	жауапкершілік	зат есім	бірмағыналы	Белгілі бір нәрсеге жауапты болушылық, міндетіне алушылық	1	Шын мәнінде, сайлаудың әділ өтуі әр азаматтың құқықтық санасы мен ортақ жауапкершілігіне байланысты.	2023-07-22 18:07:01.034485
4212	жауапты	зат есім	бірмағыналы	Міндетті, борышты; жауап беретін тұлға	1	Жергiлiктi атқарушы органдардың лауазымды адамдары тиiстi сайлау комиссиясы ұсынған сайлаушылар тiзiмдерiнiң, сондай-ақ сайлаушылар туралы деректердiң анықтығы үшiн жауапты болады.	2023-07-22 16:40:59.916959
4213	жауапты	сын есім	бірмағыналы		2		2023-07-20 15:35:09.515219
4214	жедел	сын есім	бірмағыналы	тез, жылдам мағынасында қолданылады	2	жедел шешiм қабылдауды қажет ететiн жағдайларды қоспағанда, қырық сегiз сағат бұрын хабардар етiледi;	2023-07-19 15:05:48.452028
4215	жеке	зат есім	бірмағыналы	Дербес, өз алдына; бөлек. Өзіндік, өзіне тән. Дара, жалғыз.	1	Кандидатқа, саяси партияларға сайлау алдындағы үгітті жүргiзуге байланысты қызмет көрсететiн жеке және заңды тұлғаларда олардың осы қызметтердi қабылдауға жазбаша келiсiмi болуға тиiс.	2023-07-18 08:39:21.25148
4216	жеке бас	зат есім	бірмағыналы	Бір өзі, жалғыз өзі, жеке өзіне қатысты	1	Бұл құжат байқаушыны жіберген ұйымның мөрімен расталады және ол байқаушының жеке басын куәландыратын құжатты көрсеткен кезде жарамды болады.	2023-07-20 22:11:22.322292
4237	жоқшылық	зат есім	бірмағыналы		1		2023-07-19 12:29:56.825676
4217	жеңімпаз	зат есім	бірмағыналы		1		2023-07-17 18:18:00.980677
4218	жеңіс	зат есім	бірмағыналы	Жеңіске жетуге көмектесу, бірге жеңу	1	Тәуелсіз бақылаушылар негізінен халықаралық ұйымдардан, өзге шет мемлекеттерден, сондай-ақ қандай да бір кандидат немесе партияның жеңіске жетуіне бүйрегі бұрмайтын бейтарап үкіметтік емес ұйымдардан ұсынылып, сайлаудың әділ өтуіне мониторинг жасайды. 	2023-07-19 21:10:11.764844
4242	жою	етістік	көпмағыналы	кемшіліктерді жою сауатсыздықты жою	5	 Ал құртудың екі жолы бар: бірі – Моғолстанды шабу, екіншісі – Жәнібек пен Керейді көп кешіктірмей ж о ю (I.Есенберлин, Алмас.). 	2023-07-24 03:35:15.527987
4219	жер	зат есім	бірмағыналы	егемендігі белгіленетін шектегі аумақтық кеңістік, табиғи ресурс, жалпыға ортақ өндіріс құралы және кез келген еңбек процесінің аумақтық негізі.	1	Туған жердей жер болмас туған елдей ел болмас.	2023-07-17 22:37:10.287275
4220	жергілікті	сын есім	бірмағыналы	барлық элементтері бар жер бетінің бөлігі (учаскесі, ауданы)	2	Партиялық тізімдерін ұсынған саяси партиялар өз қаражаттарынан жергілікті атқарушы органдардың шотына партиялық тізімге енгізілген әрбір адам үшін Қазақстан Республикасының заңнамасында белгіленген ең төмен жалақының бес еселенген мөлшерінде сайлау жарнасын енгізеді.	2023-07-18 00:39:59.721057
4221	жеребе	зат есім	бірмағыналы	Бірдемеге кезек алу үшін, я арадағы дауды әділ шешу үшін бір түстес нөмірленген зат, я нәрсені жасырын алудың атауы.	1	Жеребе тартуды Орталық сайлау комиссиясы жүргiзедi.	2023-07-20 03:10:08.746196
4223	жершілдік	зат есім	бірмағыналы	жер принципі бойынша қоғамда бөліну 	1	Жершілдік қазақтың бірігуіне кері әсерін тигізетін дерт	2023-07-19 14:01:54.272881
4224	жетіл	етістік	бірмағыналы	Меңгерту, дамыту, ілгерілету деген мағынады қолданылады.	5	Маркетингтің өндірістік ұйымдастыру, технологияны үнемі жетілдіру қажеттігіне деген сеніміне негізделген (Б.Жүнісов,.. Нарық. экон. негіз.).	2023-07-22 19:17:16.22143
4225	жетілдіру	етістік	бірмағыналы	Меңгерту, дамыту, ілгерілету деген мағынады қолданылады.	5	Маркетингтің өндірістік ұйымдастыру, технологияны үнемі жетілдіру қажеттігіне деген сеніміне негізделген (Б.Жүнісов,.. Нарық. экон. негіз.).	2023-07-17 18:32:48.195593
4227	жәрдем	зат есім	бірмағыналы	Көмек көрсету, болысу, қолғабыс тигізу	1	Кәпірден қорлық көрсетпей, Маған жәрдем бер деді	2023-07-19 19:32:38.431257
4228	жәрдем	зат есім	бірмағыналы		1		2023-07-22 07:59:46.16964
4229	жәрдемдес	етістік	бірмағыналы	Көмек көрсету, болысу, қолғабыс тигізу	5	Кәпірден қорлық көрсетпей, Маған жәрдем бер деді	2023-07-17 11:45:08.013224
4230	жина	етістік	көпмағыналы		5		2023-07-20 03:55:05.986211
4231	жиналыс	зат есім	көпмағыналы	Ұжым мүшелерінің белгілі бір мәселені талқылау үшін, өздерінің ішкі өндірістік, экономикалық, әлеуметтік мәселелерін қарау үшін бас қосқан кеңесі; мәжіліс	1	Жергiлiктi өзiн-өзi басқару органдарына кандидаттар ұсыну туралы шешiмдi жиналысқа қатысқан азаматтар санының көпшiлiк даусымен қабылданады, ол тиiстi хаттамамен ресiмделедi.	2023-07-20 13:31:20.107577
4232	жиын	зат есім	бірмағыналы		1		2023-07-18 19:47:04.507602
4233	жоба	зат есім	бірмағыналы	тиісті талаптарға сәйкес мақсаттарға жету үшін қолға алынатын, уақыт, құн және ресуртар жағынан шектеулері бар, бастапқы және соңғы күндеріне дейін белгіленген бағдарды әрі басқарылатын жұмыстар жиынтығынан құралған айрықша үдеріс.	1	Осы жобаның қарсаңында көптеген сабақтар аларымыз айдан анық.	2023-07-19 11:05:57.681355
4234	жоғары 	сын есім	көпмағыналы	/ Мемлекеттік басшылық қызмет, жетекшілік ететін басшы орын	2	 Семафордың үстіңгі қанаты ж оғ а р ы көтерілгенде ғана жүру керек (Н.Ғабдуллин, Қызық дәурен).	2023-07-17 15:31:45.296047
4235	жой	етістік	көпмағыналы	кемшіліктерді жою сауатсыздықты жою	5	 Ал құртудың екі жолы бар: бірі – Моғолстанды шабу, екіншісі – Жәнібек пен Керейді көп кешіктірмей ж о ю (I.Есенберлин, Алмас.). 	2023-07-17 18:54:11.002411
4236	жойылады	етістік	бірмағыналы	деректер жиынтығының өшірілуі	5	Бүгінге дейін жинақталған барлық ақпарат басшылықтың бұйрығымен жойлыады	2023-07-23 14:43:16.460738
4238	жол берме	етістік	бірмағыналы	қандай да бір әрекетке, жұмысқа, процесске жол берілмеуді қарастырады	5	Дауыс беретін күнге екі күн қалғанда партиялық тізімді тіркеу туралы шешімнің күшін жоюға немесе бұрын тіркеуден шығарылған партиялық тізімді қалпына келтіруге жол берілмейді	2023-07-21 10:07:46.736967
4239	жол бермеу	етістік	бірмағыналы	қандай да бір әрекетке, жұмысқа, процесске жол берілмеуді қарастырады	5	Дауыс беретін күнге екі күн қалғанда партиялық тізімді тіркеу туралы шешімнің күшін жоюға немесе бұрын тіркеуден шығарылған партиялық тізімді қалпына келтіруге жол берілмейді	2023-07-23 13:52:32.337502
4240	жолда	етістік	көпмағыналы	Жолда етістігінің қимыл атауы; жіберу, арнап жазу	5	Қазақстан халқына биылғы Жолдауында баяндалғанын жария етті.	2023-07-21 09:29:17.367552
4243	ЖСН	зат есім	бірмағыналы	Қазақстан Республикасында жеке тұлғаларға берілетін сандық код	1	ЖСН енгізудің мақсаты белгілі бір тұлғаға қатысты мәліметтерді тіркеудің бірыңғай жүйесіне өту болып табылады.	2023-07-19 21:27:00.188632
4244	журнал	зат есім	бірмағыналы	белгілі бір үлгіде жасалған және мерзімді жазбаларды, мәліметтерді, оқиғаларды, шешімдерді, кіріс әрі шығыс құжаттарын, т.б. қамтитын құжат	1	Құжаттар сайлау комиссиясының төрағасына не оны алмастыратын адамға байқаушы туралы деректерді есепке алу журналына енгізу арқылы оны тіркеу үшін көрсетіледі.	2023-07-20 13:03:29.970102
4245	жуырда	сын есім	бірмағыналы	болашақтағы мерзім көрсеткіші	2	Жуырда жаңа өзгерістер күтілуде	2023-07-22 23:11:34.192891
4246	жүздес	етістік	бірмағыналы	Жүздес етістігінің қимыл атауы; кездесу, жолығысу, ұшырасу.	5	Соңғы ж ү з д е с у і м і з 1961 жылдың майы. Мен Москваға, одан соң өз елім Ленинградқа баратын боп, қоштасуға келдім (Біздің Мұхтар)	2023-07-23 01:15:38.145202
4247	жүздесу	етістік	бірмағыналы	көрісу мағынасында	5	кандидаттар халықпен жүздесті	2023-07-22 07:54:14.743496
4248	жүзеге ас	етістік	бірмағыналы	бір нәрсені нақты орындау	5	биылға мақсаттап қойылған барлық тапсыма жүзеге асырылды	2023-07-20 17:14:23.273813
4249	жүзеге асыру	етістік	бірмағыналы	Бірдеңені жүзеге асыру, жүргізу.	5	Республика азаматының өз сайлау құқығын еркiн жүзеге асыруына зорлық-зомбылық жасау, алдау, қорқыту, сатып алу жолымен кедергi келтiрген жағдайда заңмен белгiленген қылмыстық жауаптылықта болады.	2023-07-22 03:03:11.849336
4250	жүйе	зат есім	көпмағыналы	өзара байланысты және өзара әрекеттестіктегі элементтер жиынтығы	1	Жүйе ұғымы қазіргі философияда ғылымда техникада және практикалық іс-әрекеттерде маңызды роль атқарады, жүйелі шешім және жүйелердің жалпы теориясы салаларында 20 ғ. ортасынан бастап қарқынды зерттеулер жүргізілуде	2023-07-23 06:15:29.435128
4251	жүйеле	етістік	бірмағыналы	Бір ретпен тұтастықты құрайтын қатардағы элементтердің жиынтығы, ойлау операцияларының бірі.	5	Жүйелі талдау — құбылыстар мен объектілерді, әртүрлі құрылымдарды бөліп көрсету арқылы, онын тұтастығын көрсету тәсілін іздестіру.	2023-07-19 13:33:36.808192
4252	жүйелі	сын есім	бірмағыналы	мағыналы деген нүсқада	2	Жүйелі сөз жастарға жігер беретіні анық	2023-07-18 19:40:49.742879
4253	жүктелсін	етістік	бірмағыналы	Орындалуға тиісті тапсырма берілді. 	5	Бұзаушыға оларды азықтандырып, бағып-күту, сиырлардың өнімділігімен бұзаулардың қосқан салмағын бақылау, қораны тазалау міндеті жүктелсін (С.Тілеубергенов, Мал шаруаш.).	2023-07-23 06:41:48.813315
4254	жүргізеді	етістік	бірмағыналы	біреудің қасында жүру, біреуді ертіп жүру, қозғалысты	5	Көлік жүргізіп келе жатып ұялы байланыстан да ажырамайтын көлік жүргізушілерін талай көрген боларсыз.	2023-07-19 08:53:36.500314
4276	іргелі	сын есім	бірмағыналы	іргетас ретінде қызмет етуді көрсету	2	Бұл ферма аудандағы іргелі шаруашылықтардың бірі	2023-07-20 10:16:05.923093
4255	жүргізілуі мүмкін	етістік	бірмағыналы	Кемені шлюз арқылы жүргізу. Аралық өткізу. Жаңа темір жол өткізу.	5	Іске қатысатын адамның өтінішхаты қанағаттандырылған кезде жабық сот талқылауы жүргізілуі мүмкін	2023-07-20 21:16:21.827482
4256	жұбайы	зат есім	бірмағыналы	Ерлі-зайыптылар ұғымын  білдіреді	1	Кандидат пен оның зайыбы (жұбайы) декларациялаған кірістері мен мүлкi туралы мәлiметтердiң анықтығын мемлекеттік кіріс органдары кандидат тіркелген күннен бастап он бес күн ішiнде тексереді.	2023-07-24 04:12:58.772909
4257	жұмыла	сын есім	бірмағыналы	Жұмысты, белгілі бір іс-әрекетті барлығы бірдей бар ықыласымен құлай істеді.	2	үш жылда атқарылған ауқымды жұмыстар мен жүргізілген түрлі реформалардан кейін сайлау өткізіп, елдің алдағы бағыт-бағдарын тағы бір айқындап алатын уақыт жетті. Сол себепті ел тұрғындары алдағы саяси шараға бір адамдай жұмыла атсалысуы керек.	2023-07-21 00:09:11.18084
4258	жұмыс	зат есім	бірмағыналы	Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті. 	1	Жұмыла қимылдаған жұртшылық күн қызғанша жұмыста еңсеріп-ақ жіберді (С.Бегалин, Ана.). 	2023-07-22 09:26:04.334077
4259	жұмыссыздық	зат есім	бірмағыналы	 халықтың бір бөлігінің жұмыссыз болуы	1	Жұмыссыздық оқу бітірген студенттер үшін ең басты проблема	2023-07-19 13:14:49.273178
4334	көзде	етістік	бірмағыналы	Көзде етістігінің қимыл атауы.	5	К ө з д е у алыстығы мылтық қарауылы арқылы қанша жердегі нысананы алуға болатындығы (Қаз. тілі. термин. Әскери.).	2023-07-19 18:07:47.032398
4260	жұрт	зат есім	бірмағыналы	қазақтың халықтық-мекендік, тектестік-тұтастықты білдіретін байырғы әлеуметтік ұғымы.	1	 Жұрт ұғымының объектілік нақтылануы айтайын деп тұрған субъектінің көксеген мақсатына байланысты болып келеді. 	2023-07-20 14:09:06.650747
4261	жұртшылық	зат есім	бірмағыналы	көпшілік, қауым, кейде ел-жұрт мағынасында қолданылады. Дәстүрлі қазақы ортада әдетте ауыл адамдарына немесе бүкіл руластарына қарата айтылады.	1	 Жұртшылық ұғымы рулық-туыстық қатынасқа негізделген жақындықты да білдіреді.	2023-07-23 13:54:42.896852
4262	жыныс	зат есім	көпмағыналы	араб тіліндегі мағыналары «адам, жан-жануар және өсімдіктердің аталығы мен аналығы», «еркек немесе ұрғашы екенін білдіретін белгілер жиынтығы», «нәсіл, тек».	1	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2023-07-23 21:56:41.246919
4263	зал	зат есім	бірмағыналы	жиналыстар мен кездесулер т.б. өткізуге арналған үлкен бөлме.	1	Мәдинәштардың залы біздікінен әлдеқайда үлкендеу екен.	2023-07-20 16:13:36.508255
4264	заманауи	сын есім	бірмағыналы	даму түрғысынан уақыттың соңғы мерзімі	2	Дәрісті заманауи технологияларды пайдаланып қткізу қажет	2023-07-22 03:35:09.844241
4265	заң	зат есім	бірмағыналы	тұтас алғанда барлық нормативтік-құқықтық актілер, мемлекет тағайындалған барлық жалпы міндетті тәртіптер. 	1	Заңды, әдетте, мемлекеттік биліктің жоғары өкілетті органы парламент немесе референдум арқылы қабылдайды.	2023-07-19 06:43:47.403456
4266	заң ережелері	зат есім	бірмағыналы	заңның талаптары мағынасында	1		2023-07-24 00:00:43.670921
4267	заңгер	зат есім	бірмағыналы	Заң ғылымдарын меңгерген маман	1	Осы орайда белгілі заңгер М. Нәрікбаевтың: «Діни конфессиялармен күрескеннен гөрі, олардың іс-әрекетін қадағалау керек» дегені көңілін айтты.	2023-07-18 16:23:01.9056
4268	заңды	сын есім	бірмағыналы	Заңға сәйкес келетін, заңға үйлесімді	2	саяси партияны тарату туралы заңды күшiне енген шешiмді қабылдаған жағдайларда, өз міндеттерінен босатылады.	2023-07-24 06:58:19.097975
4270	идея	зат есім	бірмағыналы	Белгілі бір нәрсе туралы адам санасында пайда болған жаңаша ой, пікір	1	Ол – біздің советтік дәуір. Ол идея –марксизм-ленинизм идеясы, коммунистік идея (4,316)	2023-07-21 23:10:25.526793
4271	иелік	зат есім	бірмағыналы	Ие болушылық, қожайындық, басшылық	1	Бұл шоттарға республикалық бюджеттен түсетін бюджет қаражатына иелік етуді аумақтық сайлау комиссиялары жүзеге асырады.	2023-07-19 05:34:52.510771
4272	институт	зат есім	бірмағыналы	кәсіптік жоғары білімнің білім беру бағдарламаларын іске асыратын және қолданбалы сипаттағы ғылыми зерттеулерді жүзеге асыратын жоғары оқу орны 	1	Ол медициналық институтты бітіріп, бүгін мемлекеттік емтихан тапсырды.	2023-07-21 18:37:58.07827
4273	интернет ресурс	зат есім	бірмағыналы		1	Мемлекеттік органдар интернет-ресурсының дизайнында адаптивті веб-дизайн пайдаланылады	2023-07-23 01:35:05.548734
4274	іле-шала	үстеу	бірмағыналы		9		2023-07-19 13:33:33.183598
4275	іргелес	сын есім	бірмағыналы		2		2023-07-23 14:16:07.032904
4277	іс	зат есім	бірмағыналы	Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті.	1	Ісің оңды болғай.	2023-07-22 13:06:41.849414
4300	келесі	сын есім	бірмағыналы		2		2023-07-19 23:01:10.508468
4278	іс-әрекет	зат есім	бірмағыналы	жұмыс жасауды және орындауды білдіреді	1	Сайлау комиссиясының және оның мүшелерiнiң шешімдері мен іс-әрекеттеріне (әрекетсіздiгіне) жасалған шағымды, егер осы Конституциялық заңда өзгеше көзделмесе, жоғары тұрған комиссия шағым түскен күннен бастап үш күннiң ішінде қарайды.	2023-07-20 03:23:02.966352
4279	іске асыр	етістік	бірмағыналы	 Қабылдаған бағдарламаны орындау	5	Бұл ойын іске асыру үшін ол Омбыға арнаулы кісі жіберді (С.Мұқанов, Аққан жұлд.)	2023-07-19 04:08:05.36674
4280	іске қосылды	етістік	бірмағыналы	Қосыл етістігінің қимыл атауы.	5	Меніңше, бұл пікірге қосылуға да, қосылмауға да болатын сияқты (4,291).	2023-07-20 20:22:39.212034
4281	істе	етістік	бірмағыналы	. Жеке адамның не көпшіліктің белгілі мақсатта еткен еңбегі, әрекеті	5	Мен қазір «Қызыл жұлдыз» колхозының жанындағы комсомол ұйымының секретары болып ж ұ м ы с ж а с а й м ы н (Ақт., Байғ.).	2023-07-22 03:31:42.078414
4282	іс-шара	зат есім	бірмағыналы	өтілуі қажет оқиғалар	1	Бұқаралық ақпарат құралдары барлық кандидаттарды және партиялық тізімдерді ұсыну, оларды сайлау комиссияларының тіркеуі жөніндегі іс-шаралар туралы ақпаратты баспасөз бетіндегі орны, эфир уақыты бойынша бірдей көлемде таратуға міндетті.	2023-07-19 02:12:15.137373
4283	ішкі	сын есім	бірмағыналы	Іш жағындағы, ішіндегі .	2	Жарасты бетке ұстап, шығармасын бөлім-бөлімге жіктеп алған да тарта берген, ішкі динамика әлсіз (4,251).	2023-07-20 05:12:48.060122
4284	ішкі тәртіп	зат есім	бірмағыналы	Белгілі бір қоғам не ұйым мүшелеріне ортақ, орындалуы міндетті, қалыптасқан мінез-құлық жүйесі	1	Ол орындарға кімдер баратынын партияның өзі ішкі тәртіппен таңдайды.	2023-07-23 23:20:48.37041
4285	кабина	зат есім	бірмағыналы	қандай да бір көлік құралын басқаратын адамға немесе жүргізушіге, жолаушыға арналған, шағын көлемдегі, арнайы жабық орын	1	Дауыс берушiлер сайлау бюллетеньдерiн жасырын дауыс беруге арналған кабиналарда толтырады	2023-07-17 14:32:58.049027
4286	кандидат	зат есім	бірмағыналы	қандай да бір қызметке үміткер; кіші ғылыми атақ	1	Мемлекеттік қызметші лауазымына кандидатқа қойылатын талаптар лауазымдық міндеттердің сипатына ғана байланысты болады және заңмен белгіленеді	2023-07-20 03:41:07.781004
4287	кандидатура	зат есім	көпмағыналы	Кандидат ретінде тағайындалуы мүмкін адам	1	Және бәрі бір-біріне таныс болған кезде күткенді жөн көреді және тиісті кандидатураны ұсынады.	2023-07-20 08:12:36.97476
4288	квота	зат есім	көпмағыналы	әркімге тиесілі бөлік‚ guot – қанша), үлестеме – әркімге тиесілі үлес‚ бөлік‚ норма.	1	1) өндіріске‚ өткізуге‚ экспортқа немесе импортқа қатысу үлесі‚ ол ұлттық (мемлекет ішіндегі) немесе халықаралық келісімге не халықаралық топқа қатысушылардың әрқайсысы үшін белгіленеді; халықаралық экономика немесе валюталық-қаржы ұйымының жарғылық қорындағы немесе капиталындағы белгілі бір елдің жарнасы;\n2) салық салынатын белгілі бір бірліктен алынатын салықтың мөлшерлемесі (абсолют мөлшерде немесе үлес түрінде);\n3) сайлау квотасы – сайлау округіндегі бір депутаттың сайлануы үшін қажетті дауыс саны;\n4) жекешелендіру барысында азаматтарға қайтарусыз берілетін мемлекттік меншік үлесі.\n5) Квотаны белгілеудің мақсаты - монополиялық мол пайда табу мақсатында тауар сатуды, экспорттауды, ал\nкейде өнім өндіруді шектеу. Импорттық квоталар - контитгенттер - импортты сан жағынан шектеу формаларының бірі; елге белгілі уақытта сырітан әкелінуі мүмкін белгілі бір категориядағы тауарлар сомасының жоғары деңгейі (немесе саны) белгіленеді.\n\nКвота(ғылымда) -\n\n1. Белім, норма, белгілі бір заттың мөлшері, сандық шектеулі;\n2. Салықтың ең кіші бөлігінен алынатын салықтың мөлшері;\n3. Жалпы өндірісте, өнімді сыртқа өткізу кезінде түскен жалпы пайдасы катысушылардың әрқайсысына бөлінген бөлшек.	2023-07-17 15:37:57.236524
4289	кедергі	зат есім	бірмағыналы	тосқауылды білдіреді	1	сайлау комиссиясының жұмысына кедергі келтіретін іс-әрекеттер жасамау керек	2023-07-21 12:04:28.277912
4290	кедергісіз	сын есім	бірмағыналы	қарсы бағытталған әсердің жоқтығын сипаттайтын шама	2	биылғы сайлау науқаны кедергісіз өтуде	2023-07-21 23:59:30.855066
4291	кездес	етістік	бірмағыналы		5		2023-07-21 12:57:36.268739
4292	кездес	етістік	көпмағыналы		5		2023-07-19 10:02:28.259923
4293	кездесу	зат есім	көпмағыналы		1		2023-07-23 20:11:09.588468
4294	кездесу 	етістік	бірмағыналы	Кездес етістігінің қимыл атауы; жолығу, ұшырату. 	5	Ойда жоқ жерден кездесуімізді айтамын-ау (Ә.Сәрсенбаев, Батыр.). 	2023-07-20 00:17:19.381499
4295	кезек	зат есім	бірмағыналы	Бірінен кейін бірі, алма кезек. Бір нәрсенің реті, жөні, орайы	1	Ендігі кезек бюллетендерді санау!	2023-07-17 09:26:40.341582
4296	кезектен тыс	сын есім	бірмағыналы	Алдын ала жоспарланбаған, кезексіз	2	1941 жылы 22 июнь күні «Социалистік Қазақстан» газетінің кезектен тыс номері шықты	2023-07-20 14:22:49.301097
4297	кезекті	сын есім	бірмағыналы	Келесі, алдағы; кезекте тұрған мағынасында қолданылады	2	Президенттiң кезектi сайлауы бес жылда бiр рет тиiстi жылғы желтоқсанның бiрiншi жексенбiсiнде өткiзiледi	2023-07-17 14:11:22.702637
4390	қалыс қалу	етістік	бірмағыналы	ерекше пікір	5	қалыс қалу арқылы дауыс бермеді, нейтралды пікірде қалуды көздеді	2023-07-21 10:19:22.707746
4298	кезең	зат есім	бірмағыналы	Қандай да бір белгіленген уақыт мезетін көрсетеді. Уақыт, мезгіл, кез мағынасында қолданылады	1	Ақпараттық-сараптамалық қамтамасыз етудің бірінші кезеңі - сайлау алдындағы округтегі жағдайды жан-жақты талдау	2023-07-22 12:41:10.350546
4299	келеңсіздік	сын есім	бірмағыналы	Жөнсіздік, епетейсіздік, оғаштық мағыналарында пайдаланылады	2	Үміткерге дауыс беру барысында туындауы мүмкін кейбір келеңсіздіктерді де ескерген жөн	2023-07-20 09:44:11.988472
4301	келісім	зат есім / етістік	көпмағыналы	бір тоқтамға, мәмілеге келу	1	Актіге азаматтың комиссияға кеңесші дауыс құқығымен кіруге келісімі туралы өтініші қоса беріледі.	2023-07-20 22:25:37.979829
4302	келіспе	етістік	бірмағыналы	күтілген нәтиже мен шындық арасындағы алшақтық пен айырмашылық	5	Егер бұл келісімшарт бізге қолайлы болмайтын болса,келіспеу керек	2023-07-18 09:01:45.403265
4303	кем дегенде	шылау	бірмағыналы	аз дегенде мағынасында қолданылады	8	Президенттiкке кандидатты сайлаушылардың Республиканың облыстарының, республикалық маңызы бар қаласының және астанасының кем дегенде үштен екiсiнiң атынан теңдей өкiлдiк ететiн сайлаушылардың жалпы санының кем дегенде бiр процентi қолдауға тиiс.	2023-07-21 07:19:39.275092
4304	кеміт	етістік	бірмағыналы	шаманың қысқаруы, кемуі	5	 Біліп тұрған баланың бағасын к е м і т у деген – қылмыс, бізде ондай әдет болған емес (М.Дүйсенов, Мейман.)	2023-07-22 20:04:28.234738
4306	кеңейт	етістік	бірмағыналы	Бір құбылыстың өзгеріске түсуі,оның үлкейтілуі, ұлғайтылуы.	5	Төрт бұрышты келген аласа қызыл үй қазір төрт жағынан бірдей к е ң е й т і л і п биіктеп кеткен (Д.Әбілев, Замана.).	2023-07-17 17:16:52.227045
4307	кеңейтіледі	етістік	бірмағыналы	сөздер әсерлірек болу үшін уақыт өте келе сөз мағынасының өзгеріп, семантикалық өзгеріске түсуі	5	 Төрт бұрышты келген аласа қызыл үй қазір төрт жағынан бірдей к е ң е й т і л і п биіктеп кеткен (Д.Әбілев, Замана.).	2023-07-19 17:34:46.959963
4308	Кеңес	зат есім	бірмағыналы	Жергілікті жердегі үкімет орны	1	Конституциялық Кеңес Конституцияны бұзу анықталған учаскелердегi (әкiмшiлiк-аумақтық бөлiнiстердегi) Республика Президентi сайлауы Конституцияға сәйкес емес деп таныған жағдайда Орталық сайлау комиссиясы тиiстi учаскелердегi (әкiмшiлiк-аумақтық бөлiнiстердегi) сайлауды жарамсыз деп тану және сайлау жарамсыз деп танылған учаскелерде (әкiмшiлiк-аумақтық бөлiнiстерде) екi ай iшiнде қайта дауыс беру өткiзу жөнiнде шешiм қабылдайды.	2023-07-20 03:38:56.491945
4309	кеңес	етістік	Омоним	Нұсқаулық, нұсқау, ұсыныс, қалай жалғастыру керек. 	5	Жергілікті жердегі үкімет орны. Дәрігерден марқамат болмаған соң мән-жайды а у ы л д ы қ к е ң е с к е айттым (Қ.Тайшықов, Окт. ұшқыны)	2023-07-21 09:13:07.669747
4310	кеңесші	зат есім	бірмағыналы	Сайлау комиссияларының құрамында өкілі жоқ саяси партиялар сайлау науқанын даярлау және өткізу кезеңіне тиісті сайлау комиссиясына сайлау тағайындалған немесе жарияланған күннен бастап он күннен кешіктірмей өз өкілін кеңесші дауыс құқығымен жіберуге құқылы. Сайланбалы органдардың немесе халықаралық ұйымдардың жұмысына кеңес беру міндеттерімен қатысу құқығы, яғни кез келген мәселелер бойынша дауыс беруге қатыспай, тек кеңес беруші ретінде ғана қатысу құқығы.	1	Сайлау комиссиясы кеңесші дауыс құқығымен сайлау комиссиясының мүшесін тағайындау туралы шешім қабылдайды.	2023-07-17 10:15:11.491326
4311	кепілдік	зат есім	бірмағыналы	міндеттемелердің орындалуын қамтамасыз ететін құқықтық принциптер мен тәсілдердің жиынтығы	1	Кепілдік берілетін белгілі бір міндеттемелерді соңғысының мойындауына қарамастан кепілдік осы міндеттемелердің бүкіл көлеміне қолданылады	2023-07-18 23:01:23.625679
4312	кереғар	сын есім	бірмағыналы	Қарама-қарсы, қайшы мағынасында қолданылады	2	Тәуелсіз байқаушылар дауыс беру науқаны әділ  әрі заңға  кереғар іс-әрекетсіз өткенін  мәлімдеді.	2023-07-17 18:37:27.247645
4313	кесірлі	сын есім	бірмағыналы	зиянды деген мағынада	2	кесірлі сөздер зиянын тигізуі мүмкін	2023-07-20 21:49:33.117294
4314	кесте	зат есім	бірмағыналы	бір ақпарат графаға түсіріп жазылған мәлімет	1	Учаскелік сайлау комиссияларының жұмыс кестесін, дауыс беру күнін қоспағанда, тиісті аумақтық сайлау комиссиялары айқындайды.	2023-07-19 17:12:56.531762
4315	кетіретін	етістік	бірмағыналы	кетір етістігінің қимыл атауы.	5	Дақты к е т і р у үшін арнайы химиялық қоспалар пайдаланылады (Шаңырақ энцикл.).	2023-07-23 12:10:30.978958
4391	қамқор	зат есім	бірмағыналы		1		2023-07-18 19:44:39.711331
4316	кешенді	сын есім	бірмағыналы	біртұтастықты құрайтын заттардың,құбылыстардың жиынтығы	2	Сатылай кешенді талдау жұмыстары өтті	2023-07-17 17:14:35.881527
4317	кешіктірілмей	етістік	бірмағыналы	Кешіктіріл етістігінің қимыл атауы, болымсыз түрі. 	5	Көп кешіктірілмей барлығы да жүзеге асар.	2023-07-20 23:49:56.966674
4318	кешіктірмей	етістік	бірмағыналы	мерзімінде, уақытында жасалу керек	5	сайлаудың бекітілген мерзімнен кешіктірілмей ұйымдастырылуы (яғни, сайлаудың өтуін жариялау және оны іске асыру) керек	2023-07-19 13:42:16.376726
4335	көзделмесе	етістік	бірмағыналы	Нысанага алынбайды, дәлденбейді	5	Конституциялық заңда өзгеше көзделмесе, жоғары тұрған комиссия шағым түскен күннен бастап үш күннiң ішінде қарайды.	2023-07-23 03:57:02.09691
4319	кінәлі	сын есім	бірмағыналы	Кінәсі бар, айыпты, жазықты деген мағыналарда қолданылады	2	Австралия, Автрия, Италия сияқты елдер абсентизм фактісі, яғни азаматтардың сайлауға қатыспауына орай кінәліні заңмен қудалап, айыппұл салу немесе қоғамдық жұмысқа мәжбүрлеу сияқты әкімшілік шаралар қарастырған.\nБарлық құқықтар қорғалған. strategy2050.kz белсенді сілтемені пайдаланыңыз: https://strategy2050.kz/news/saylau-memleketti-alyptastyrudy-raly-retinde/	2023-07-17 21:38:59.685149
4320	кіріс	зат есім	бірмағыналы	Белгілі бір істі, шаруаны орындауға дереу араласу, тікелей жұмылу, соны орындауға қатысу, қолға алу. Табыс келу . Мемлекеттік мекеме.	1	Кандидат пен оның зайыбы (жұбайы) декларациялаған кірістері мен мүлкi туралы мәлiметтердiң анықтығын мемлекеттік кіріс органдары кандидат тіркелген күннен бастап он бес күн ішiнде тексереді.	2023-07-22 10:33:56.819698
4321	кіріспе	зат есім	көпмағыналы		1		2023-07-21 17:54:07.838831
4322	клиника	зат есім	бірмағыналы	Науқас адамдарды емдеумен қатар педагогикалық және ғылыми-зерттеу жұмыстары бірге жүргізілетін емдік-профилактикалық мекеме.	1	Хирургия к л и н и к а с ы н а таяудағы бір ауданнан жарақаттанған отыз жастағы ер адамды алып келді (А.Рақышев, Бұл тур. біл. ). 	2023-07-17 14:00:46.915724
4323	комиссия	зат есім	бірмағыналы	Орыс тілінен келген кірме сөз, арнаулы бір тапсырманы орындау үшін немесе мәселені шешу үшін белгіленген адамдар тобының уақытша немесе үнемі болып тұратын мәжілісі\n	1	Қалалық комиссия тасқын зардабын жою үшін шұғыл шара қолдануда (К.Тоқаев, Тасқын). 	2023-07-19 10:27:46.855516
4324	комиссия мүшелері	зат есім	бірмағыналы	комиссия төрағасынан тексеру мақсаттарына және тексерілетін бөлімшеге қатысты нұсқаулар алады	1	Конкурс әлі өтпеді, ал комиссия мүшесімен кездесе алды	2023-07-17 16:53:15.444903
4325	конвенция	зат есім	бірмағыналы	1) кез-келген саладағы адамдардың мінез-құлқының және іс-әрекетінің, оның ішінде, жаһандық мәселелерді шешу барысында келісім бойынша қабылданған ережелер мен қағидалар; 2) келісім бойынша уағдаласушы жақтардың құқықтар мен міндеттемелерін айқындайтын құжат; 3) субъектілердің келісімі мен уағдаласуы негізінде ережелер, белгілер, символдар, тілдік және басқа да жүйелер енгізуді ұйғаратын танымдық шара	1	Адам құқықтары және негізгі бостандықтарын қорғау туралы конвенция, Адам және халықтардың құқықтары туралы Африка хартиясы, Азаматтық және саяси құқықтар туралы халықаралық пакт және тағы басқа көптеген мемлекет ратификациялаған халықаралық құқықтық келісімшарттар адамдардың сайлау құқығына қатысты таңдау құқығын мойындайды.	2023-07-20 21:23:59.113548
4326	конверт	зат есім	бірмағыналы	Белгілі бір жаққа жіберу үшін (хат, кітап т,б, нәрселерді) төрт бұрышты не үшбұрышты етіліп қағаздан жасалатын пакет	1	Әлібек шешесінің қолынан хатты ала сала, конвертін ашып жіберді	2023-07-19 10:13:13.514753
4327	консенсус	зат есім	бірмағыналы	саяси басқару мен ықпалдасудың құралдары мен әдістерін қоғамдық мойындау. Саяси консенсус арқылы саяси үстемдікті шынайы, іс жүзінде заңдастыру жүзеге асырылады.	1	Консенсус немесе алқалық қағидаты негізінде жұмыс істей алатын сайлау\nоргандары халықтың сеніміне бөленуде.	2023-07-22 01:02:05.341338
4358	күнкөріс	зат есім	бірмағыналы		1		2023-07-18 03:34:18.089344
4328	консервативті	сын есім	бірмағыналы	дәстүрлі әлеуметтік құндылықтарды қорғау бағыты	2	Англияда әлемдегі ең консерватиті қоғам қалыптасқан	2023-07-23 09:05:27.562069
4329	конституциялық 	сын есім	бірмағыналы	Конституцияға тән, конституцияға қатысты.	2	Халық пен мемлекет атынан билік жүргізуге Республика Президентінің, сондай-ақ өзінің к о н с т и т у ц и я л ы қ өкілеттігі шегінде Парламенттің құқығы бар (ҚР Конституциясы).	2023-07-17 11:19:19.677296
4330	Конституциялық заң	зат есім	бірмағыналы	ҚР Конституциясында конституциялық деп аталған, ҚР Конституциясы 62-бабының 4-тармағында белгіленген тәртіппен қабылданатын заң	1	1995 жылы 30 тамызда ҚР-ның Конституциялық Заңы екінші мәрте қабылданған болатын.	2023-07-18 09:32:55.376871
4331	концептуалды	сын есім	бірмағыналы	халықтың ғалам туралы қорытқан ойы	2	білімді концептуалды түрде ұйымдастыру керек	2023-07-19 20:17:32.914011
4332	коэффициент	зат есім	бірмағыналы	Ауыспалы немесе белгісіз шаманың көбейткіші болатын, тұрақты немесе белгілі шама.	1	сауал салу нәтижелерінің қателiк коэффициентiн көрсетуге мiндеттi.	2023-07-23 00:16:44.533347
4333	көбінесе	үстеу	бірмағыналы		9		2023-07-18 17:28:54.279741
4371	қабырға	зат есім	омоним	геометриялық фигураның қырлары, адам сүйегі	1	Адамда 12 қабырға сүйегі болады	2023-07-23 16:58:23.446294
4336	көзқарас	зат есім	бірмағыналы	Адамның белгілі бір нәрсеге деген өзіндік ұғым-түсінігі, ой-пікірі.	1	Қазақстан Республикасы Конституциясының 33-бабы Қазақстан Республикасының он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, мемлекеттік органдар мен жергілікті өзін-өзі басқару органдарын сайлауға және оларға сайлануға, сондай-ақ республикалық референдумға қатысу құқығына кепілдік береді.	2023-07-21 03:34:24.691085
4337	көкейкесті	сын есім	бірмағыналы		2		2023-07-24 01:02:29.617282
4338	көлемді 	сын есім	бірмағыналы	Қомақтылық, ауқымдылық	2	Сазарған салқындығынан аумаған Шыңғыстың Шоқанға қатты ұнаған бір жері, Науаннан қалғаны бар, өзінің жинағандары бар, ауыл жағдайында к ө л е м д і кітапхана жасап алған (С.Мұқанов, Аққан жұлдыз).	2023-07-21 11:02:26.161998
4339	көппартиялық	сын есім	бірмағыналы	мемлекетте бірнеше партияның қатысуымен билік институттарын қалыптастыруға мүмкіндік беретін саяси-партиялық жүйе сипаттамасы	2	Көппартиялық парламентте пікірталастың болуы табиғи заңдылық	2023-07-22 12:30:43.017491
4340	көпшіл	сын есім	бірмағыналы		2		2023-07-22 21:45:38.533192
4341	көпшілік	зат есім	бірмағыналы	Халық, жұртшылық, қауым мағынасында қолданылады	1	Қазақстан халқы Ассамблеясы Кеңесінің шешімі көпшілік дауыспен қабылданады және хаттамадан үзінді көшірмемен ресімделеді.	2023-07-21 13:41:09.83547
4342	көрінбейтін	етістік	бірмағыналы	Көру қиын, көру мүмкін емес	5	Нәтижесінде біз жағдайды егжей-тегжейлі сипаттай аламыз, пациенттің талдаушыға қарай кейде көрінбейтін қозғалыстар жасап, дабылға тап болған кезде қайтадан баспанаға тығыла аламыз.	2023-07-22 20:21:04.948341
4343	көрініс	зат есім	бірмағыналы	 Сыртқы дүниенің көзге шалынған сыртқы бейнесі	1	Мұндай сұрықсыз көріністің болғанына екеуі де кінәлі емес екендіктерін іштей ұғысуда (4,162)	2023-07-17 13:26:29.677535
4344	көрнекті	сын есім	бірмағыналы	адамның кәсіби деңгейі мен парасаттылығын сипайттайтын сөз	2	Ахмет Байтұрсынұлы қазақтың аса көрнекті қоғам қайраткері	2023-07-20 11:29:37.949367
4345	көрсет	етістік	бірмағыналы	Көрсетіл етістігінің қимыл атауы, бейнелену, айқындалу.	5	Алдында ғана бұл тапсырманың жауабы қарастырылып, көрсетілген болатын.	2023-07-20 14:22:39.749875
4346	көрсету	етістік	бірмағыналы	Көрсет етістігінің қимыл атауы .	5	Ішіңнен бұрын сыртыңды көрсетуің неғайбіл (5,107).	2023-07-20 01:42:28.765763
4347	көтеріледі	етістік	бірмағыналы	Көтер етістігінің қимыл атауы	5	 Жоғары ұстау, түсірмеу. Алпамсадай мына денемен мойнына асылғанды к ө т е р у оңай жұмыс емес (М.Сатыбалдиев, Қоңыр қозы).	2023-07-23 16:19:13.921108
4348	көш	етістік	көпмағыналы	Көш етістігінің қимыл атауы	5	1. Орын ауыстыру. Ел-елдің бәрі де түйесін қомдап, үйлерін жығып, к ө ш у г е кіріскен еді (М.Әуезов, Қилы заман)	2023-07-20 18:32:09.798305
4349	көш ілгері	сын есім	бірмағыналы	Әжептәуір алда, әлдеқайда артық	2	Қазақстанда азаматтардың сайлауға қатысу белсенділігі әлемнің көптеген елдерімен салыстырғанда көш ілгері.	2023-07-22 21:58:22.613814
4350	көшбасшы	зат есім	бірмағыналы	Қоғамдық ұйымның жеке ықпалы әлеуметтік процестерде және жағдайларда, ұжымдағы, топтағы, қоғамдағы қарым-қатынастарды реттеуде маңызды қызмет атқаратын кез келген әлеуметтік топтың беделді мүшесі; 	1	 К ө ш б а с ш ы ол жеке қасиеттері, қабілеттері сол қоғамның қажетіне жарайтын, соның арқасында қызметі пайдаға асатын жеке тұлға (шеберкәсіп иесі, талантты зерттеуші жән ет. с.с.) (Саяси сөздік). 	2023-07-17 21:32:13.435249
4351	көшірме	зат есім	бірмағыналы	Түпнұсқа жазудан көшіріліп алынған дана	1	сайлау комиссиясының мөрiмен куәландырылған хаттаманың көшірмесі беріледі.	2023-07-19 02:21:43.125877
4352	көшу	етістік	көпмағыналы		5	2. ауыс. Жаңа тәртіпке өту, жаңа бағытта жұмыс істеу. Жаңа оқу жоспарына к ө ш у г е мектеп толығынан дайын («Халық мұғ».).	2023-07-20 21:13:53.131268
4353	куәландырылған	етістік	бірмағыналы	нотариалды бекітілген немесе мемлекеттік мекемемен немесе ұйымның мөрімен расталған	5	Бұл құжат байқаушыны жіберген ұйымның мөрімен расталады және ол байқаушының жеке басын куәландыратын құжатты көрсеткен кезде жарамды болады	2023-07-18 06:18:22.9014
4465	листовка	зат есім	бірмағыналы	Үндеухат мағынасында қолданылады	1	плакаттар, листовкалар, ұрандар мен өзге де үгіттiк баспа материалдарын басып шығару	2023-07-21 12:49:05.734064
4354	куәлік	зат есім	көпмағыналы	Заңдық мәні бар әлдебір деректі (туу туралы, неке туралы, оқу орнын бітіргені туралы т.б.) тұлғаның құқын (авторлық, иеленушілік т.б.) немесе дайындалған материалдардың (бұйымдардың, құрылымдардың) стандарттарға не техникалық шарттарға сәйкестігін дәлелдейтін ресми құжат	1	Оны айғақтайтын бірден-бір куәліктер Санкт-Петербургтің Эрмитажында, Ұлыбритания, Париж, Берлин мұражайларында сақтаулы тұрған алтын және күміс теңгелер болып табылады («Парасат»)	2023-07-18 17:26:30.406343
4355	күдік	зат есім	бірмағыналы	қандай да бір секеммен қарау, күмән келтіру	1	тәуелсіз байқаушылар штабы ортақ WhatsApp немесе Telegram топтары арқылы бірнеше учаскелерде байқалған күмәнді азаматтарды бақылауға алуы және мәліметтерді дер кезінде саралап отырулары керек.	2023-07-18 02:09:15.596115
4356	күн	зат есім	бірмағыналы	Таңның атысынан, күннің батуына дейінгі аралық	1	Күні бойы еңбек қылғаннан басқа еш нәрсені білмейді екен.	2023-07-19 16:21:02.326619
4357	күн тәртібі	зат есім	бірмағыналы	Жиналыс, мәжілістерде қаралатын мәселелердің түрлері мен өтілу реті.	1	Депутаттыққа кандидаттар, партиялық тізімдерін ұсынған саяси партиялар өздеріне қатысты мәселелер қаралатын кезде тиісті сайлау комиссияларының отырыстары мен күн тәртібі туралы алдын ала хабардар етіледі.	2023-07-20 19:50:27.123017
4359	күнтізбе	зат есім	бірмағыналы	Ұзақ уақыт мезгілін есептеудің аспан денелерінің көрінерлік қозғалысының ауық-ауық қайталану ерекшелігіне негізделген жүйесі. 	1	Жоғары сайлау кеңесі дайындаған күнтізбелік жоспар аясында сайлау кезеңінің бастауы 30 сәуір болып белгіленген болатын.	2023-07-23 06:24:36.272212
4360	күрделі	сын есім	бірмағыналы	 Неше түрлі бөліктен тұратын, көп құрамды	2	Іле үлкендігі жағынан Қазақстанда үшінші орын алатын к ү р д е л і өзен (Н.Баяндин, Өзен алқабы.).	2023-07-17 14:17:25.563121
4361	күтім	етістік	бірмағыналы	Біреуге жасалған жағдай, бап	5	Егер сайлау күні Сіз сайлау учаскесіне денсаулық жағдайы бойынша немесе отбасының ауру мүшесіне күтім жасау себебінен келе алмасаңыз, сондай-ақ сайлау учаскесі құрылмаған шалғай және жету қиын жерде болған жағдайда, Сіз учаскелік сайлау комиссиясына «үйде» дауыс беруді ұйымдастыру туралы өтінішпен жүгінуге құқылысыз.	2023-07-23 18:21:04.768381
4362	күш	зат есім	бірмағыналы	Күш деп дененің басқа денелер тарапынан болатын әрекеттің нәтижесінде үдеу алатынын сипаттайтын және осы әрекеттің өлшемі болып табылатын физикалық шаманы айтады.	1	Қырымызда қаулап қарқын, Біріккен к ү ш жүзі жарқын, Дұшпанға оқ дәні мір. Анамыз жер дегізетін, Иіп емшек емізетін, Мәңгі қарыз сенде тұр (Ү.Кәрібаев, Таңд. шығ.)	2023-07-24 05:59:51.529933
4363	күшейт	етістік	бірмағыналы	Күшейт етістігінің қимыл атауы	5	Қазіргі таңда, әсіресе, елдің рухын көтеріп, отаншылдық сезімін ояту, к ү ш е й т у қажет деп санаймыз («Егемен Қазақстан»).	2023-07-20 23:05:09.574732
4393	қанағатсыз	сын есім	бірмағыналы		2		2023-07-20 15:07:09.712418
4364	күшейту	етістік	бірмағыналы	белгілі бір процесті нығайту оған қарқын беру	5	білім сапасын күшейту	2023-07-23 04:25:37.706234
4365	күшін жой	етістік	бірмағыналы	ҚР өзі жасасқан халықаралық шарттан тиісінше ресімдеп бас тартуы және ҚР халықаралық шартының қолданылуын тоқтату тәсілінің бірі. Күшін қайтару, үзу, тоқтату, күшінде жоқ деп тану	5	Осы бұйрықтың 3-қосымшасына сәйкес Қазақстан Республикасы Әділет министрлігі бұйрықтарының күші жойылған деп танылсын	2023-07-24 00:26:51.297237
4366	күшті	сын есім	бірмағыналы	Күштің көп болған жағдайдағы сипаттамасы.	2	Үш бірдей ірі, к ү ш т і, сау адамдардың қосыла күлген күлкісі қар жамылған ақ даланы жаңғыртып, аязды күнді жылытып жібергендей болды (Ә.Нұршайықов, Жомарт.). 	2023-07-22 03:28:02.428032
4368	қабілетсіз	сын есім	бірмағыналы	Қабілеті жоқ, икемсіз	2	Сайлауға сот iс-әрекетке қабілетсiз деп таныған, сондай-ақ сот үкiмiмен бас бостандығынан айыру орындарында отырған азаматтар қатыспайды.	2023-07-24 07:20:22.996567
4369	қабылданды 	етістік	бірмағыналы	Шығарылған заң немесе шешім қабылданады.	5	1989 жылды 22 қазанында Қазақ ССР Жоғарғы Кеңесінің XIV кезектен тыс сессиясында «Қазақ ССРіндегі тілдер туралы з а ң» қ а б ы л д а н д ы.	2023-07-24 00:12:03.883733
4370	қабылдау керек	етістік	бірмағыналы	Адамдарды бір нәрсенің немесе әлдекімнің құрметіне орай шақыру, жиналыс, кездесу.	5	директордың орынбасары бүгін келушілерді қабылдауы қажет	2023-07-23 01:02:41.075883
4372	қағида	зат есім	бірмағыналы	Қалыптасқан заңдылық, белгілі ұстаным, ереже.	1	Бұл жағдайда мәслихат депутаттығына кандидаттардың партиялық тізімдерін ұсыну осы Конституциялық заңда белгiленген қағидаларға сәйкес жүзеге асырылады.	2023-07-19 18:14:14.777118
4373	қағидаттар	зат есім	бірмағыналы	 оның негізінде ғылыми теориялар мен заңдар, құқықтық құжаттар жасалады.	1	депрессия кезеңінде жаңа технологиялық қағидаттарға көшудің, базистік инновацияла р кла стер лерін мең герудің алғышарттары құрылып, сөйтіп келесі циклдің бар лық инновациял ары а лдың ғы, я ғни дағдарысты кезеңде құрылады.	2023-07-21 16:11:36.787048
4374	қадам	зат есім	бірмағыналы	Адым мағынасында қолданылады	1	Бұл қадам – партия­лар­дың Мәжіліс пен мәслихатқа өту шегін төмендету үшін осыған дейін қабылданған шешімнің заңды жалғасы.	2023-07-22 10:48:55.641628
4375	қажетті	сын есім	бірмағыналы	Қажеті бар, керекті.	2	кандидат ұсыну ережелерiн бұзған, тiркеу үшін қажетті құжаттарды табыс етпеген	2023-07-22 17:14:03.736857
4376	қажеттілік	зат есім	бірмағыналы	жеке адамның, әлеуметтік топтың, қоғамның тіршілік әрекетін қамтамасыз ету үшін объективті түрде керек нәрсеге мұқтаждық;	1	 Қажеттілік субъект пен оның қызметінің өзара байланысын көрсетеді, әуестіктен, мүдделерден, мақсаттардан және мінез-кұлықтан көрініс табады.	2023-07-17 19:15:03.526054
4377	Қазақстан	зат есім	бірмағыналы	 Қазақ Республикасы; қазақ жері, қазақ елі.	1	Поезд вагондарының есік, терезелерінен Қазақстанның шексіз, кең даласына құмарта, қызыға көз тікті (Ә.Нұршайықов, Тың астығы).	2023-07-23 10:06:17.882911
4378	қайта	сын есім			2	Қайта сайлау алғашқы сайлаудан кейiн екi ай мерзiмнен кешiктiрiлмей өткiзiледi.	2023-07-20 04:59:39.393234
4379	қайта бөлу	етістік	бірмағыналы	Бөл етістігінің қимыл атауы.	5		2023-07-23 18:00:00.281159
4380	қайта дауыс беру	етістік	бірмағыналы	сайлау үрдісінің шешуші кезеңі. Бір немесе екі турдан болады. Бюллетендермен немесе арнайы машиналармен дауыс беру арқылы жүзеге асады	5	Қайта дауыс беру өткізген жағдайда округтік сайлау комиссиялары сайлау бюллетеніне сайлаушылардың ең көп дауысын алған саны екеуден артық емес депутаттыққа кандидаттардың тегін енгізсін	2023-07-19 08:38:35.161774
4381	қайтарылады	етістік	бірмағыналы	алынған нәрсені қайтару	5	Ол қаржылық шаруашылық қызметтің нәтижелері туралы есепте қосымша құн салығы, акциздер және т.с.с. салықтар мен міндетті төлемдерді, сондай-ақ қайтарылған тауарлардың құнын, сату және баға шегерімдерін алып тасталып көрсетіледі.	2023-07-20 00:15:54.970361
4382	қала	зат есім	бірмағыналы	Зауыты, фабрикасы, өнеркәсібі, оқу орындары бар ірі елді мекен.	1	Қазіргі Семей қаласы Алаш Орданың астанасы болған.	2023-07-24 07:50:43.246516
4416	қиын	сын есім	бірмағыналы		2		2023-07-21 19:56:20.763427
4383	қалалық	сын есім	бірмағыналы	Қалаға тән,қалаға қатысты	2	халық топтары жинақы тұратын ауылдық және қалалық жергiлiктi қауымдастықтардың аумақтары сайлау округтерi болып табылады	2023-07-21 02:05:41.302328
4384	қалауы	етістік	бірмағыналы	Қала етістігінің қимыл атауы. Бұйымтай сұрап алмақшы болған нәрсе, қолқа	5	Азаматтың сайлауға қатысуы еркін және өз еркімен /қалауымен/ болады. 	2023-07-23 20:11:30.527364
4385	қалпына келтір	етістік	бірмағыналы	Жөндеу, бұрынғыдай ету.	5	Дауыс беретін күнге екі күн қалғанда партиялық тізімді тіркеу туралы шешімнің күшін жоюға немесе бұрын тіркеуден шығарылған партиялық тізімді қалпына келтіруге жол берілмейді	2023-07-20 10:13:59.549808
4386	қалыптас	етістік	бірмағыналы	Бір заттың күйін, қалпын қолдан жасау, қалыптастыру	5	Ағзалардың ұрпақ қалдыруға қабілеттілігін қалыптастыру.	2023-07-19 09:17:57.587984
4387	қалыптастыру	етістік	бірмағыналы	процесст пен жұмыс бойынша  бір нәтижеге жету, құрастыру	5	Сайлаушылардың дауыс беруге арналған тізімдерін қалыптастыру	2023-07-20 02:00:18.239106
4388	қалыпты	сын есім	бірмағыналы	дағдылы сауда операциялары процесінде өндіруші және (немесе) экспорттаушы елге демпингке қарсы істі қарау нысанасы болып табылатын тауарға ұқсас тауарды сату кезінде нақты төленген немесе төленуге тиісті баға («Демпингке қарсы шаралар туралы» 1999 жылғы 13 шілдедегі № 421 ҚРЗ 1-бап)	2	өнімділігі жоғары және орташа, орман өсірудің белгілі бір жағдайында сапасы жақсы және орташа екпе (2003 жылғы 8 шілдедегі №477 ҚР ОК 4бап)	2023-07-18 04:20:20.41533
4389	қалыс қалған	зат есім			1		2023-07-17 12:49:06.098412
4668	сәйкестілік	зат есім	бірмағыналы	өзара ұқсастық мағынасында	1	теория мен практиканың сәйкестілігі жақсы нәтиже береді	2023-07-17 19:04:36.38609
4392	қамтамасыз ету	етістік	бірмағыналы	Керек-жарақпен қамту, жабдықтау. 	5	Республиканың аумағында сайлау туралы заңдардың атқарылуына бақылауды жүзеге асырады; олардың бiрыңғай қолданылуын қамтамасыз етедi; өзiнiң құзыретi шегiнде бүкiл Республика аумағында мiндеттi шешiмдер қабылдайды	2023-07-19 10:46:22.354446
4394	қанағаттан	етістік	бірмағыналы	біреудің үміттерін немесе қажеттіліктерін орындау	5	Сайлаушының талабын қанағаттандыру партиялар алдындағы міндет 	2023-07-21 02:38:16.189583
4395	қанықты	сын есім	бірмағыналы	өте мазмұнды	2	Көп қарап, бәріне көзі жетті.\n\nАулақтадық олардан, көзім тағы қанықты,\n\nБір шұңқырға бір-екеу мұзда қатып қалыпты,\n\nТөңкерілген бөріктей бірін-бірі жауыпты (5,154).	2023-07-18 19:07:01.973496
4396	қапшық	зат есім	бірмағыналы	1. ұсақ заттарды салуға арналған ыдыс, кішірек қап; 2. Ішіне бір нәрселерді салып, көтеріп жүретін дорба пішіндес ыдыс	1	Пайдаланылмаған және бүлінген бюллетеньдер сыртында тиісті жазу жазылған пакетке (қапшыққа, конвертке) салынып, ол мөрленеді. 	2023-07-21 05:58:30.755942
4397	қара	етістік	бірмағыналы	бағыттау, біреуге, бір нәрсеге немесе бір жерге қарау	5	Абайдың жоқ екенін білсе де,Даусын естігенде Айнұр жалт қарады	2023-07-23 00:38:32.49382
4398	қаражат	зат есім	бірмағыналы	араб тіліндегі мағынасы «шығын», «жұмсау»	1	Комиссия хатшысы бұл кезектен тыс президенттік сайлау болғандықтан, сайлауға қаражат үкімет резервінен бөлінетінін хабарлады.\nБарлық құқықтар қорғалған. baq.kz белсенді сілтемені пайдаланыңыз: https://baq.kz/saylau-otkizuge-bolinetin-qarazhat-2-ese-osti-287870/	2023-07-23 15:31:53.260728
4399	қаралған	сын есім	бірмағыналы	Денсаулықты тексерту, емделу	2	Доктор Шұғылов науқастанып, Орал қаласына қаралу үшін кеттi (X. Есенжанов).	2023-07-19 02:46:30.848599
4400	қаралу	етістік	бірмағыналы	бір нәрсені байқау, анықтау үшін кез-келген кеңістікті шолу	5	Аудиторлық қызметтердің сапасын арттыру мәселелері мен оның бақылау мүмкіндігі мемлекет деңгейінде де, кәсіби құрылымдар деңгейінде де қаралып жатыр.	2023-07-21 10:20:04.738672
4401	қарастыр	етістік	бірмағыналы	Бір нәрсені табу үшін әрекет ету.	5	Мұхит, бәрінен бұрын адамдарды орнымен пайдалануды қарастыру керек (Ғ. Сланов).	2023-07-22 02:46:26.343006
4402	қарау	етістік	көпмағыналы	Бір мәселені қарау, зерттеу процесі	5	Сот түскен өтініш туралы және оны қарау нәтижелері бойынша сот шешімінің заңды күшіне енгені жөнінде сайлау комиссиясын хабардар етеді.	2023-07-18 05:47:51.086734
4434	қолжетімді	сын есім	бірмағыналы	заттың құнын бағалау дәрежесі	2	қолжетімді нарық	2023-07-20 06:12:33.95997
4403	қаржыландыру	етістік	бірмағыналы	ағымдағы шығындар мен күрделі жұмсалымдарды қажетті қаржылық ресурстармен қамтамасыз ету кәсіпорынның (компанияның) немесе мемлекеттің меншік қаражаттарының, тартылған, қарыз қаражаттар мен басқаларының есебінен жүзеге асырылады.	5	Осы Конституциялық заңға сәйкес сайлау қорларын құрмайтын азаматтар, қоғамдық бiрлестіктер қаржыландыруды талап етпейтiн сайлау алдындағы үгіт жүргiзуге құқылы.	2023-07-23 14:54:05.773477
4404	қарқынды	сын есім	бірмағыналы		2		2023-07-17 22:20:03.752647
4405	қарсы	үстеу	бірмағыналы	Қарама-қарсы жақ	9	Сайлаушылар арасында 279 адам бәріне қарсы дауыс берді	2023-07-22 21:34:00.287103
4406	қасақана	үстеу	бірмағыналы	Біле тұра, әдейі жасалған әрекет	9	үгiт материалдарын қасақана жойған немесе зақымдаған	2023-07-18 02:30:51.644186
4407	қате	зат есім	бірмағыналы	«дұрыс емес, бұрыс», «жаңылыс, қателік жіберу, жаза басу»	1	тiзiмдердегi қателiктер мен жаңсақтықтар туралы арыздарды қарайды және оған тиiстi өзгерiстер енгiзу туралы мәселелердi шешедi	2023-07-20 01:49:14.580512
4408	қателес	етістік	бірмағыналы		5		2023-07-19 18:31:51.419549
4409	қателік\n	зат есім	бірмағыналы	дұрыс емес жасалған мәліметтер	1	азаматтарды сайлаушылардың тiзiмiмен таныстырады, тiзiмдердегi қателiктер мен жаңсақтықтар туралы арыздарды қарайды және оған тиiстi өзгерiстер енгiзу туралы мәселелердi шешедi	2023-07-22 03:33:10.099795
4410	қатыгездік	зат есім	бірмағыналы	Адамның мінез-құлқындағы жағымсыз іс-әрекет; қаталдық, мейірімсіздік, тасжүректік.	1	қатыгездік пен зорлық-зомбылыққа бас ұруды насихаттауға немесе үгіттеуге жол бермеу туралы ережелерін басшылыққа алу	2023-07-21 04:42:13.618797
4411	қатыс	етістік	көпмағыналы	Процесті өз көзімен көру, ішінде болу.	5	Сайлау барысына байқаушы болып қатысуға ЕҚЫҰ мен ТМД және өзге де елдер мен халықаралық ұйымдардан арнайы өкілдер келді (“Егемен Қазақстан”).	2023-07-22 16:47:03.230081
4829	ұтымды	сын есім	бірмағыналы	ұтқыр мағынасында қолданылады	2	Байқаушылар ұтымды қимылды, сенімділікті қамтамасыз етулері керек	2023-07-23 17:27:08.514994
4412	қатысушы	зат есім	бірмағыналы	Бір нәрсенің процесіне араласушы. Жиын, конференция т.с.с. қатынасушы адам	1	Конференцияға қатысушылар таңертеңгі сағат тоғыз жарымға дейін тіркелуі тиіс	2023-07-21 17:43:31.425377
4413	қауіпсіздік	зат есім	бірмағыналы	адамның, қоғамның және мемлекеттің өмірлік маңызды мүдделерінің ішкі және сыртқы қауіп-қатерден қорғалуының жай-күйі	1	ҚР Ішкі істер министрлігі сайлау кезіндегі қауіпсіздік және құқықтық тәртіп мәселелері туралы ресми мәлімдеме жасады	2023-07-18 19:16:12.396653
4414	қаулы	зат есім	бірмағыналы	үкіметтің өкімі, мемлекеттік басқару актісі.	1	Президент сайлауының қорытындыларын белгiлейдi және тиiстi қаулы қабылдайды.	2023-07-20 05:48:05.462698
4415	қауымдастық	зат есім	бірмағыналы	Көптеген адамдар жеке байланыстарымен топтасатын қоғамдар	1	Өзге де жергілікті өзін-өзі басқару органдары мүшелерін сайлау кезiнде қалалық және селолық қауымдастықтардың аумақтарын қамтитын көп мандатты аумақтық сайлау округтерi құрылады.	2023-07-19 14:30:36.785214
4417	қиындық	зат есім	көпмағыналы	Азап, бейнет, қиыншылық, ауыртпалық. 	1	Көрмесең, түсінбесең қ и ы н д ы қ т ы, Қадірін жақсылықтың білер ме едің (Н.Сүлейменов, Жолда).	2023-07-22 06:11:42.92748
4418	қиындық	зат есім	көпмағыналы	Кедергі, бөгет.	1	Қазақстан топырағында тап тартысы шиеленіскен, қиын түрде өтіп, біздің жазушыларымыздың ескі санамен күресе отырып, жаңа салт-санаға түсулеріне талай кедергі, талай қ и ы н д ы қ т а р жасады (Ғ.Мүсірепов, Суреткер.).	2023-07-20 22:31:03.38807
4419	қоғам	зат есім	бірмағыналы	дамдар арасындағы тарихи қалыптасқан саяси-әлеуметтік байланыстар мен қатынастардың тұрақты жүйесі	1	дауыс берудi өткiзу кезiнде қоғамдық тәртiп пен сайлау бостандығын қамтамасыз етеді	2023-07-21 20:09:43.156695
4420	қоғамдық	сын есім	бірмағыналы	Қоғамға тән, қоғамда болып жататын іс-әрекет, құрылыстармен тығыз байланысты, қоғамға қатысты	2	Тілі де, діні де бөлек, тірлік тұрмысы, қоғамдық құрылысы да бөлек жат жұртқа сапар шекті	2023-07-19 02:39:16.318919
4421	қозғалыс	етістік	бірмағыналы	материяның аса маңызды атрибуты, өмір сүруінің тәсілі	5	Материя қозғалысы абсолютті, ал кез - келген тыныштық салыстырмалы және қозғалыс сәттерінің бірі болып табылады.	2023-07-17 12:49:11.676911
4422	қойылуы мүмкiн	етістік	бірмағыналы	белгілі бір жерге орналасуы	5	Тіпті адам өзімен-өзі қалып, түрлі мәселеден түйін шығарғанда да Абайдан алшақтай қойылуы мүмкін емес	2023-07-24 03:07:08.070297
4423	қол	зат есім	көпмағыналы	өкілетті лауазымды тұлғаның немесе құжат авторының жеке қолын білдіретін құжат реквизиті.	1	Сайлау қорытындылары туралы аумақтық комиссияның төрағасы мен мүшелерiнiң қолы қойылған хаттама жасалады.	2023-07-17 22:09:19.393092
4424	қол жеткізу	етістік	бірмағыналы	Жүзеге асыру, мақсатқа жету, орындау. 	5	Сайлау алдындағы бағдарламаның (тұғырнаманың) қағидаларын баяндау үшін бұқаралық ақпарат және телекоммуникация құралдарына тең қол жеткізу жағдайлары қамтамасыз етілуі тиіс.	2023-07-19 11:15:00.590227
4425	қол жинау	етістік	бірмағыналы	Көптеген адамдардың қолдарын жинақтаумен жүргізіледі	5	Сайлаушылардың Президенттiкке кандидатты қолдауы олардың қол жинауы арқылы расталады.	2023-07-17 22:50:38.952621
4426	қол қою	етістік	бірмағыналы	Белгілі бір құжат мәтініне жауапты, қатысы бар құзырлы адамның қолтаңбасын жазуы	5	Әрбiр қол қою парағының рет нөмiрi болуға тиiс	2023-07-23 15:26:19.344897
4427	қолда	етістік	бірмағыналы	қолқабыс тигізу	5	кандидаттарға, партиялық тiзiмдерiн ұсынған саяси партияларға олардың сайлау қорларынан тыс қаржылық (материалдық) қолдау көрсеткен	2023-07-21 14:32:12.158322
4428	қолдан	етістік	бірмағыналы	Қолдан етістігінің қимыл атауы.	5	Айталық, ауқымы кең, арнасы мол эпикада ақын бар ойын барынша пайдалану мақсатымен, амалсыз баяндауға, баяндағанын дәлелдеуге, бір сөзбен, етістіктерді көп қолдануға тап болатыны сөзсіз (4,255).	2023-07-18 09:09:07.865132
4429	қолдану	етістік	бірмағыналы	Қолдан етістігінің қимыл атауы.	5	Айталық, ауқымы кең, арнасы мол эпикада ақын бар ойын барынша пайдалану мақсатымен, амалсыз баяндауға, баяндағанын дәлелдеуге, бір сөзбен, етістіктерді көп қолдануға тап болатыны сөзсіз (4,255).	2023-07-17 12:20:53.646203
4466	мажоритарлық	сын есім	бірмағыналы	өзге үміткерлерге қатынасы бойынша басым көпшілік дауыс алған үміткер сайланған болып саналатын ішкі жүйе.	2	Мәжілістің депутаттық корпусының 70 пайызы – пропорционалды (партия атынан), 30 пайызы мажоритарлық негізде жасақталады.	2023-07-22 08:22:00.32041
4430	қолданылуға жатпайды	етістік	бірмағыналы	белгілі бір затты ұстамау	5	Олармен іскерлік әріптестік, түрлі көрмелер мен бағдарламалар арқылы мұражайға келушілердің қызығушылықтарын қолдауға, сондай-ақ, коллекция тақырыбымен мүдделері байланысты қосымша аудиторияны мұражайға тартуға мүмкіндік береді.	2023-07-19 16:20:36.708563
4431	қолданыс	зат есім	бірмағыналы	Пайдалану ісі, әдісі; пайдаға асу үдерісі.	1	Латын әріптері күнделікті қолданысқа жаңа еніп жатқан кез (Т.Жармағамбетов, Ақ жауын).	2023-07-23 15:13:11.516191
4432	қолданыста	етістік	бірмағыналы	қолданылатын кезді көрсетеді	5	Саяси партия ұсынған кандидатты қоспағанда, кандидат өз қаражатынан жергілікті атқарушы органдардың шотына тиісті қаржы жылына арналған республикалық бюджет туралы заңда белгіленетін және тиісті қаржы жылының 1 қаңтарында қолданыста болатын ең төмен жалақының бір еселенген мөлшерінде сайлау жарнасын енгізеді.	2023-07-23 14:11:26.261169
4433	қолдау	зат есім	бірмағыналы	моральдық көмек көрсету, сенім ұялату, жігерлендіру	1	Ерекше дарынды балалар инвесторлардан қолдау күтеді	2023-07-18 20:20:43.66786
4435	қор	зат есім	бірмағыналы	Сайлау қорларының тізіліміне сайлау қоры туралы деректерді енгізеді	1	Сайлау қорларына заңды жолмен алынған қаражат қана берiледi.	2023-07-21 05:26:16.33567
4436	қорға	етістік	көпмағыналы	Аман алып қалу, сақтау, пана болу.	5	Аттандым қайнап ащы кек, Қорғауға туған Отанды (Қ.Ұябаев, Тағдыр.).	2023-07-23 17:32:38.080977
4437	қорғау	етістік	көпмағыналы	Заң жүзінде, заңды тұрғыда. Қылмыс жасады деп сезік келтірілген адамдардың құқықтары мен мүдделерін қамтамасыз ету, айыптауды жоққа шығару, жеңілдету, заңсыз қылмыстықізге түсуге ұшыраған адамдарды ақтау мақсатында қорғау тарабы жүзеге асыратыніс жүргізу қызметі.	5	Қорғау шаралары – заңдық міндеттердің орындалуын қамтамасыз ететін және құқықтардың жүзеге асырылуын кепілдендіретін құқықтық ырықтандырудың бір түрі (Қаз. тілі. термин. Заңтану).	2023-07-18 16:47:24.554929
4568	өріс	зат есім	омоним	физикалық шама, географиялық шама	1		2023-07-19 07:34:27.9428
4438	қорытынды	зат есім	көпмағыналы	Белгілі біріс-әрекеттен, тәжірибеден туындайтын шешім, байлам, тұжырым, тоқтам	1	Бұл жетістік ондаған жылдар бойы су қоймасында жасалған коллективтік еңбектің қорытындысы болып табылады	2023-07-20 17:52:05.598305
4439	қосарланған	сын есім	бірмағыналы	екі заттың біріккен түрін түсіндіретін ұғым	2	Қосарланған күрделі атаулардың жазылу ережесі болады	2023-07-18 13:55:46.509572
4440	қосымша	зат есім / сын есім / үстеу	көпмағыналы	Бір нәрсені толықтыра түсетін, толымды ететін; қосалқы, жанама	1	Қосымша сайлау осы Конституциялық заңда бастапқы сайлау үшiн белгiленген ережелерге сәйкес өткiзiледi.	2023-07-18 05:28:25.352936
4441	қуану 	етістік	бірмағыналы	Қуан етістігінің қимыл атауы;	5	Жаңа жыл қуануда, күрсінуде, Селдария сезімдердің түйсігінде. Жолдардың жан баспаған торабында, Талдардың гүл жармаған бүршігінде (Т.Айбергенов, Мен саған.).	2023-07-18 12:07:32.339184
4442	құбылыс	зат есім	бірмағыналы	Бізді қоршаған ортада, табиғатта болып тұратын әртүрлі өзгеріс .	1	Табиғаттың таңғажайып  құбылыстарын алдымен сезініп, алдымен ләзаттанып, алдымен жеркенетін де сол адам (4,275).	2023-07-18 20:35:34.602633
4443	құжат	зат есім	бірмағыналы	«дәлел, айғақ, куәлік», «иелену құқығын айғақтайтын, меншік иесі екенін дәлелдейтін заңды құжат». Қазақ тілінде «адамның жеке басына, үйге, көлікке т.б. қатысты құжаттар» ұғымында да қолданылады.	1	Колхоздың көк өгізін алғандығың туралы құжат беріп кеткін (Алм., Кег.).	2023-07-22 22:12:30.486255
4444	құзырет	зат есім	бірмағыналы	қандай да болмасын мемлекеттік органның немесе лауазымды тұлғаның үлесіндегі ерекше құқық.	1	Үкіметтің құзыреті, ұйымдастырылуы мен қызмет тәртібі конституциялық заңмен белгіленеді (ҚР Конституциясы).	2023-07-22 15:03:33.66384
4445	құзырлы	сын есім	бірмағыналы	уәкілеттіліктің бір түрі	2	құзырлы мемлекеттік органдар сайлаудың заң аясында өтуіне жауап береді	2023-07-23 09:54:37.942233
4446	құқық	зат есім	бірмағыналы	азаматтың немесе ұйымның мүддесін қанағаттандыруға байланысты мақсаттарына қол жеткізуге бағытталған болжамды іс-әрекетінің заңмен қамтамасыз етілген шаралары.	1	Алайда, Жер-Ананы тізе бүктіретіндейОлжаста қандай күш бар?Алып жерге айғай салатындай қандай Құйған құқығы  бар оның? (4,248)	2023-07-19 13:20:49.84203
4582	өту	етістік	бірмағыналы	Өт етістігінің қимыл атауы, жүзеге асыру деген секілді іс-қимылды білдіреді.	5	Комсомолға өту – жас өспірімнің өміріндегі үлкен оқиға (Семья тәрбиесі).	2023-07-20 23:39:00.233278
4447	құлақтандыр	етістік	бірмағыналы	Болған немесе болатын оқиғаның мән-жайын айтып беру, жеткізу	5	Тиiстi әкiмдер сайлау тағайындалғаннан немесе жарияланғаннан кейiн – он бес күн мерзiмде, ал өзге де жергiлiктi өзiн-өзi басқару органдары мүшелерiн сайлауды өткiзген кезде жеті күн мерзiмде сайлаушыларды бұқаралық ақпарат құралдары арқылы сайлау учаскелерiнiң шекаралары туралы құлақтандырады.	2023-07-18 08:15:38.071961
4448	құндылық	зат есім	бірмағыналы	танымның, белгілі бір объектінің адам үшін, топ үшін, қоғам үшін қасиетті деп танылуы.	1	Сайлау – демократиялық құндылық	2023-07-19 15:45:03.888063
4449	құндылықтар 	зат есім	омоним	рухани байлық	1	Рухани құндылықтарымызды сақтау	2023-07-19 18:13:31.27128
4450	құпта	етістік	бірмағыналы	іс әрекетті орындауға рұқсат	5	Сал аара лық бал анс модельдерінің қал ыпта суын тал дау кезінде оны анық түсінуге болады.	2023-07-23 00:26:48.277357
4451	құр	етістік	бірмағыналы	Құры етістігінің қимыл атауы .	5	Балам-ау, күрес болғасын, кейін бір жағы жеңіп, салтанат құруы керек қой (4,240).	2023-07-24 08:56:35.858766
4452	құрал	зат есім	бірмағыналы	Бір істі жүзеге асырудың әдіс-тәсілі, амал-айласы.	1	Электрондық сайлау жүйесi кез келген енгізілген ақпаратты оның енгізілуiне қарай iс-әрекеттi cипаттап және енгiзудiң дәл уақытын көрсете отырып, автоматты түрде сақтауға мүмкiндiк беретiн бағдарламалық-техникалық қамтамасыз ету құралдарын (дауыс беру туралы деректердi жазу құрылғысын) қамтуға тиiс.	2023-07-23 20:57:49.354233
4453	құрам	зат есім	бірмағыналы	Белгілі бір әлеуметтік топты құрайтын адамдар (жиынтығы).	1	Қазақтың құрамы\n\nҚашанда, қыраным,\n\nҚырқыссаң,\n\nҚырқысқан\n\nБіздерден тұрады (Қ.Мырзалиев, Мәңгі майдан).	2023-07-23 19:10:15.930874
3958	арыз	зат есім	бірмағыналы	Жеке адамның мекеме басшысына ресми түрде жазған шағымы	1		2023-07-23 17:45:45.725825
4454	құрам	зат есім	көпмағыналы	Белгілі бір әлеуметтік топты құрайтын адамдар (жиынтығы). Бір бүтін нәрсенің барлық бөлшектері, жиынтығы.	1	Комиссияның құрылар мерзімі, құрамы жайлы, сол пікір қорытқан жолдастың өзіне тапсырылды	2023-07-19 14:52:48.494923
4455	құрылым	зат есім	бірмағыналы	Бір нәрсенің құрылысы, құрамы, жүйесі	1	әкiмшiлiк-аумақтық бөлiнiстегi әкiмшiлiк-аумақтық құрылым шекарасының сақталуы ескерiле отырып құрылады	2023-07-18 07:46:26.455634
4456	қызмет	зат есім	бірмағыналы	нысанның өзгертілуіне бағытталған, ісәрекеттің мақсатқа бағытталған және нақтыланған жүйесі.\n	1	Өз өмірімді қалыпқа келтіріп алмай, бұл қызметке оралмаспын, сірә	2023-07-22 05:20:54.989612
4457	қызметкер	зат есім	бірмағыналы	кәсіпорын мен бірлестіктердегі штатты қызметкерлердің негізгі және көмекші құрамы	1	Орталық сайлау комиссиясының Төрағасы, мүшелерi және оның аппаратының қызметкерлерi өз өкiлеттiктерiн кәсіби тұрақты негiзде жүзеге асырады.	2023-07-23 10:01:50.928242
4458	қысқа	сын есім	бірмағыналы	Шолақ, ұзын емес (қашықтық жағынан).	2	Шынтуайтқа көшсек, қырық құбылатын қысқа сөзге не жетсін (Т.Әлімқұлов, Күрең өзен).	2023-07-19 16:57:55.797667
4459	қысылтаяң шақ	зат есім	бірмағыналы	күрделі уақыт мерзімі	1	Қысылтаяң шақта достардың көмегі қажет	2023-07-20 12:43:32.535246
4460	лайықты	сын есім	бірмағыналы	Сай келетін, тең, қолайлы	2	Олардың басты халық қалаған лайықты кандидаттың әділ сайлауда анықталуын қамтамасыз ету.	2023-07-22 21:45:54.924272
4461	лайықты	сын есім	бірмағыналы	бағалау көрсеткіші	2	біздің кандидат әкімнің лауазымына лайықты тұлға	2023-07-23 02:50:45.882368
4462	лауазым	зат есім	бірмағыналы	мемлекеттік органдарда, өзін-өзі басқару органдарында, Қарулы Күштер жүйесінде арнайы құзыреттілікпен тұрақты немесе уақытша билік өкілі қызметін, не болмаса (мекеме, кәсіпорындарда) ұйымдастыру-басқару, әкімшілік-шаруашылық қызметін атқаруды жүктейтін өкілеттілік	1	Қазақстан Республикасында атқаратын қызметі өте маңызды, құзыреті үлкен лауазымдар Конституцияда бекітілген. Жергiлiктi мемлекеттiк басқару және өзiн-өзi басқару органдарының, кәсiпорындар мен ұйымдардың, олардың лауазымды адамдарының сайлау туралы заңдарды бұзатын шешiмдерi мен iс-әрекеттерiне сотқа шағым жасалады	2023-07-18 04:40:20.396881
4463	либералды	сын есім	бірмағыналы	жеке еркіндікті басты құндылық ретінде ұстану	2	либералды демократия теориясы адам бостандыңы мен құқықтарына негізделген	2023-07-23 16:40:58.967434
4464	лингвистикалық комиссия	зат есім	бірмағыналы	Белгілі бір мәселені шешу үшін арнайы құралған алқа	1	сайлау комиссияларын ұйымдастыруда лингвистикалық комиссияның мүшелерiн аттестациялау	2023-07-17 19:32:12.336916
4467	мақсат	зат есім	көпмағыналы	Белгілі бір нысанаға жету жолында қойылған міндет, нысана.	1	 Осыларды өнер деп өлсе сенбе, онан басқа өнер көп іздегенге. Өкінішің өлімнен қиын болар, м а қ с а т ы м не деп ойлар кез келгенде (Ш.Құдайбердиев, Шығ.).	2023-07-19 21:18:08.081997
4500	миссия	зат есім	бірмағыналы	Белгілі бір мемлекеттің елшісіне, жеке адамға жүктелген міндеттеме.	1	Демек, осындай миссияны орындап шығу үшін ақын болу, тіпті лирик болу аз, әрине (4,273).	2023-07-17 13:48:26.374975
4468	мақұлдайды	етістік	бірмағыналы	қолдайды, жақсы, дұрыс деп есептейді\n	5	. Диалектологиялық сөздікте ауа сөзінің әдеби тілдегіден басқа екі мағынасы көрсетілген: "1) Ауа (Орал: Орда., Чап.; Гур., Маңғ.) оқиға, көтеріліс, қозғалыс. 2)Ауа (Түркм., Ашх., Таш., Мары., Тедж.; Гур., Маңғ.; Қарақ. қаз) иә, я - мақұлдау мағынасындағы сөз" (ҚТДС, 1 т., А., 1998, 74-б.).	2023-07-18 04:45:54.876554
4469	маман	зат есім	бірмағыналы	белгілі бір саланың кәсіпқой қызметі немесе басқа ауқымды мәселесі бойынша құзырлығы бар тұлға.	1	Әйелім қазақ тілі мен әдебиетінің маманы бола тұрса да, мектептерде орын болмай шықты (5,225).	2023-07-18 14:25:53.828239
4470	мандат	зат есім	көпмағыналы	өкілеттік, міндет, тапсырма, тұлғаның өкілеттілігін білдіретін құжат.	1	Депутаттық мандат депутатқа берілетін билік пен жауапкершіліктің дәлелі.	2023-07-23 08:07:21.540373
4471	маңыз	зат есім	бірмағыналы	Бір нәрсенің өмірдегі орны, мәні, қадірі.	1	Жезқазған кен орнының Ұлы Отан соғысы жылдарында маңызы зор болды (М.Бакенов, Қазақст. ресурс.).	2023-07-18 12:10:59.385865
4472	маңызды	сын есім	бірмағыналы	Аса құнды, мәнді, маңызы зор.	2	Тұтқынға түскен үш неміс офицері осы маңызды мәліметтерді берді (Ә.Әлішев, Батыр.).	2023-07-17 21:43:35.210646
4473	маңызы бар	сын есім	бірмағыналы	мәндірек мағынасында қолданылады	2	Облыстық (республикалық маңызы бар қалалар және Республика астанасы), аудандық, қалалық, қаладағы аудандық сайлау комиссиялары аумақтық сайлау комиссиялары болып табылады.	2023-07-22 12:43:21.687781
4474	материал	зат есім	бірмағыналы	1) бір нәрсе дайындау кезінде негіз болатын заттар; 2) қандай да бір мәселе бойынша іріктеп алынған құжаттамалар, файлдар; 3) бір нәрсеге негіз болатын дереккөз, мәлімет.	1	Орталық сайлау комиссиясы Республика Президентi сайлауын өткiзудiң дұрыстығы жөнiнде дау туындаған жағдайда сайлауды әзiрлеу мен өткiзуге байланысты материалдарды Конституциялық Кеңеске бередi.	2023-07-20 15:03:13.690098
4475	материалдар	зат есім	бірмағыналы	өнімді дайындау және өндіріске қызмет көрсету үшін көбінесе еңбек заты ретінде пайдаланылатын әр түрлі заттай элементтер.	1	Дегенмен, экскурсияда мазмұнды бөлігімен қатар, материалды ұсыну формасы да маңызды	2023-07-19 01:51:59.890822
4476	маусым	зат есім	бірмағыналы	белгілі бір кезең, мезгіл.	1	Арқаның Сібірмен шектес алабында салқын қыраулы маусым басталса, Бетпақ даламен шектес өңірінде күз күні әлі де шуақтап тұр (Ә. Көшімов).	2023-07-21 10:53:05.144213
4477	мәртебе	зат есім	бірмағыналы	топтағы адамның топ мүшелеріне қатысты тұрғысы.	1	Мәртебесін зорлықпен былғап алған бар жауыз:\n\nАлександр осында, Дионисий жалмауыз,\n\nСицилия бейбаққа жара салған қанды ауыз (5,59).	2023-07-19 09:32:13.821227
4478	медициналық	сын есім	бірмағыналы	Медицинаға қатысты, медицинамен байланысты.	2	Республика Президентінің міндеттерін атқаруға кедергі келтіретін ауруларының жоқ екендігін растау үшін оған медициналық куәландыру жүргізіледі	2023-07-18 14:05:06.29844
4479	меже	зат есім	бірмағыналы	қандай да бір шекті білдіреді	1	Бастапқы жоспар бойынша, 2027 жылға дейін бұл меже 63-ке келіп тоқтауы керек	2023-07-19 00:33:12.606446
4480	мекен	зат есім	бірмағыналы	Қоныстанып орын тепкен жай, қоныс	1	Есептен шығару куәлігі бір елді мекеннің шегіндегі басқа сайлау округінде немесе басқа сайлау учаскесінде дауыс беруге қатысқысы келетін сайлаушыларға берілмейді.	2023-07-19 12:40:58.42416
4481	мемлекет	зат есім	көпмағыналы	өз аумағында күш көрсету мен мәжбүрлеуді заң жүзінде қолдана алатын қоғамдық құрылым.	1	Мемлекет – биліктің негізгі институты.	2023-07-18 22:43:17.289354
4482	мемлекеттік	сын есім	бірмағыналы	Мемлекетке тән, мемлекетке қатысты	2	Мемлекеттік билік жүйесінде мемлекет басшысы, оның жоғарғы лауазымды тұлғасы болып та-былатын Қазақстан Республикасының Президенті ерекше орын алады	2023-07-22 15:41:18.692571
4483	меншік	зат есім	бірмағыналы	Біреудің иелігіндегі нәрсе, зат, мүлік, жер	1	Абсолюттік құқықтарға: меншік құқығы, барлық жеке мүліктік емес құқықтар жатады	2023-07-18 12:55:23.07234
4484	меншік құқығы	зат есім	бірмағыналы	субьектінің заң жүзінде танылатын және қорғалатн өзіне тиесілі мүлікті өз ұалауныша пайдалану құқығы	1	Жылжымайтын мүлікке меншік құқығы туралы заңдарды толықтыру қажет	2023-07-21 10:47:48.74079
4485	мерзім	зат есім	көпмағыналы	Мөлшерлі уақыты бар, кесімді мезгіл	1	Осы тұрғыда тұрғын үй құнын төмендету, ипотекалық несиенің қайтарым мерзімін созу, төлемақы жарнасы мен несие ставкасын төмендету	2023-07-23 00:52:54.781208
4486	мерзімді	сын есім	бірмағыналы	Мөлшерлі уақыты бар, кесімді мезгіл	2	Қазақстан Республикасының заңнамасы сайлаудың мерзімділігін, билік органдарында елдің әр түрлі әлеуметтік топтарының өкілдігін қамтамасыз етеді.	2023-07-20 10:56:51.428623
4487	мәдени	сын есім	бірмағыналы	адамзат жасаған әрі жасайтын және жеке адамның жарасымды дамуына, ҚР азаматтарының отаншылдығын тәрбиелеуге және эстетикалық қажеттері мен мүдделерін қанағаттандыруға бағытталған материалдың және рухани құндылықтар жиынтығы («Мәдениет туралы» 2006 жылғы 15 желтоқсандағы № 207 ҚРЗ 1-бап)	2	Үгiт материалдарын ескерткiштерге, ескерткіш тұғырларға, тарихи, мәдени немесе сәулеттiк құндылығы бар үйлер мен ғимараттарға, сондай-ақ дауыс беруге арналған үй-жайларға iліп қоюға тыйым салынады.	2023-07-24 05:26:49.654164
4488	мәдениет үйі	зат есім	бірмағыналы	мәдени-ағарту, кейде спорттық мекемелерді орналастыруға арналған ғимарат.\n	1	Гурьев облысы, Теңіз ауданы, Киров атындағы совхоздың, Семей облысы, Абай ауданының мәдениет үйінің драма коллективтері бар (І.Омаров, Серпін.)	2023-07-20 05:22:15.430126
4489	мәжбүр	сын есім	бірмағыналы	амалсыз көну, көндіру, ықтиярсыз істеу, істету мағынасында қолданылады	2	Азаматты сайлауға қатысуға немесе қатыспауға мәжбүрлеуге, сондай-ақ оның еркiн бiлдiрудi шектеуге ешкiмнiң де құқығы жоқ.	2023-07-22 06:55:11.496047
4491	мәжбүрлеусіз	етістік	бірмағыналы	мәжбүрлемей, бір әрекетті орындау 	5	Өркениетті елдердің көпшілігінде азаматтардың сайлауға барып, дауыс беруі мәжбүрлеусіз, яғни адамның жеке қалауына, белсенділік көрсеткішіне байланысты.\nБарлық құқықтар қорғалған. strategy2050.kz белсенді сілтемені пайдаланыңыз: https://strategy2050.kz/news/saylau-memleketti-alyptastyrudy-raly-retinde/	2023-07-17 10:50:18.06925
4492	Мәжіліс	зат есім	бірмағыналы	 Белгілі бір мәселені талқылап шешу үшін ұжым мүшелерінің бас қосқан отырысы, кеңес	1	Парламент Палаталардың бөлек отырысында мәселелерді әуелі Мәжілісте, ал содан кейін Сенатта өз кезегімен қарау арқылы заңдар қабылдайды (ҚР Конституциясы.).	2023-07-19 16:02:13.300344
4493	мәлімдеме	зат есім	көпмағыналы	Белгілі бір оқиға туралы хабарлама	1	сайлау комиссиясы мүшелерінің назарын осы Конституциялық заң талаптарының бұзылуына аударуға, оларға бұзушылықтар туралы тиісті жазбаша мәлімдемелерді, актілерді табыс етуге және табыс еткені туралы белгі соқтыруға құқылы	2023-07-22 08:38:07.463396
4494	мәлімет	зат есім	бірмағыналы	Белгілі бір оқиға не жұмыс жөнінде ауызша немесе жазбаша түрде берілетін ақпарат, дерек.	1	Егерде біздің алған мәліметтеріміз дұрыс болса, біздің дивизияға кемінде дұшпанның үш-төрт дивизиясы шабуыл жасайды (Б.Момышұлы, Москва.).	2023-07-21 15:40:23.143106
4495	мәлімет\n	зат есім	бірмағыналы	Белгілі бір оқиға, жұмыс жөнінде ауызша не жазбаша берілетін ақпар деген ұғымда да қолданылады	1	сайлаушылар және сайлау учаскелерінің шекаралары туралы мәліметтердің өзектілігі мен анықтығын, дауыс беруге арналған сайлаушылар тізімдерінің уақтылы әрі дұрыс жасалуын және олардың барша жұрттың танысуы үшін ұсынылуын бақылайды	2023-07-18 19:22:51.107025
4496	мәртебе	зат есім	көпмағыналы	Топтағы адамның топ мүшелеріне қатысты тұрғысы. Абырой-атақ, даңқ, дәреже 	1	Шет мемлекеттер мен халықаралық ұйымдар байқаушыларының, шетелдік бұқаралық ақпарат құралдары өкілдерінің өз мәртебесін Қазақстан Республикасындағы сайлауды байқауға қатысы жоқ қызметті жүзеге асыру үшін пайдалануға құқығы жоқ.	2023-07-18 19:52:23.318926
4497	мәселе	зат есім	бірмағыналы	Шешімін табуды қажет ететін келелі іс-әрекет, алда тұрған міндет .	1	Ақындарымыздың жинақтарын оқу үстінде, күн тәртібінен түспей келе жатқан мәселе – азаматтық әуеннің тапшылығына көзім жетті (4,273).	2023-07-19 07:24:29.227729
4628	сайлау 	сын есім	омоним	аздап сай, сайлылау.	2	Тарбағатай сілемдері сайлау, шұқанақ ойпаттарына ең қымбаттысын жасырып тастағандай (О.Бөкеев, Өз атыңды., 17).	2023-07-20 22:18:40.270195
4498	мәслихат	зат есім	көпмағыналы	тиісті әкімшілік-аумақтық бөлініс қарамағындағы аймақтың жай-күйіне жауапты жергілікті орган	1	Мәслихат депутаттарының кезектi сайлауын Орталық сайлау комиссиясы мәслихаттардың өкiлеттiк мерзiмiнiң аяқталуынан кемiнде үш ай бұрын тағайындайды және ол мәслихаттар өкiлеттiгiнiң конституциялық мерзiмiнiң аяқталуына кемiнде бiр ай қалғанда өткiзiлуге тиiс	2023-07-17 12:20:06.922118
4499	министрлік	зат есім	бірмағыналы	Белгілі бір салаға басшылық көрсетуде министр басқарып отырған мекеме	1	Министрлік осы жылы  27 маусым-11 шілде аралығындағы (қоса есептегенде) мерзімде азаматтардан Қоғамдық кеңеске кандидатуралар бойынша ұсыныстарды жазбаша түрде қабылдайды.	2023-07-23 04:33:11.534305
4831	факт	зат есім	бірмағыналы	эмпириялық жəне теориялық білімді құрастыруда қатысатын тəжірибе буыны; бағдарлама құралдарымен бейімделген эмпириялық нақтылық (мəтіндер, формулалар, фотосуреттер, бейнетаспалар т.б.).	1	Нақтылы сайлау учаскесiнде азаматты сайлаушылар тiзiмiне енгiзу үшiн оның осы сайлау учаскесiнiң аумағында тұрғылықты жерi бойынша тiркелу фактiсi негiз болады.	2023-07-18 06:57:32.609042
4833	фотожазба	зат есім	бірмағыналы	Суретке түсіру	1	Байқаушылар дауыс беру барысына кедергі жасамай, фотожазба жасауларына болады	2023-07-17 20:07:46.897164
4044	белсенді	сын есім	бірмағыналы	адамның іс-қимылы	2	белсенді түрде әрекет жасау	2023-07-23 10:02:50.651851
4501	митинг	зат есім	бірмағыналы	саяси және өмірдің өзге де өзекті мәселелерін талқылау, қандай да бір талаптарды қолдау, наразылықты немесе қолдаушылықты білдіру үшін көпшілік жиналысы	1	сайлау алдындағы жария iс-шараларды (сайлау алдындағы жиналыстарды және сайлаушылармен (таңдаушылармен) кездесулердi, сайлау алдындағы жария пікір таластар мен пiкiр алысуларды, митингiлердi, шерулердi, демонстрацияларды және заңнамада белгiленген тәртiппен және осы Конституциялық заңда тыйым салынбаған өзге де сайлау алдындағы іс-шараларды), сондай-ақ кандидаттардың және олардың сенiм бiлдiрген адамдарының сайлаушылармен (таңдаушылармен) жеке кездесулерін өткiзу	2023-07-21 16:32:34.30852
4502	міндет	зат есім	бірмағыналы	 Атқарылуға тиісті қызмет, іс.	1	Жаңадан жасақталатын жаңа Үкімет жаңа міндеттерді орындауға қабілетті іскер әрі жас менеджерлерден іріктелуі тиіс.	2023-07-18 08:06:50.175902
4503	міндеттеме	зат есім / етістік	бірмағыналы	міндеттемеге сәйкес бір адам (борышқор) басқа адамның (несие берушінің) пайдасына мүлік беру, жұмыс орындау, ақша төлеу және т.б. сияқты белгілі бір әрекеттер жасауға, не белгілі бір әрекет жасаудан тартынуға міндетті, ал несие беруші борышқордан өз міндеттерін орындауын талап етуге құқылы. Несие беруші борышқордан атқарылғанды қабылдауға міндетті. Сөзсіз орындаймын деп жазбаша түрде берілген серт, уәде .	1	Жалпы міндеттеме орындалмағанымен, аумақты жоспарлардан толық іске асқаны баршылық	2023-07-23 02:21:01.750787
4504	міндетті	сын есім	бірмағыналы	Орындауға тиісті, борышты	2	Азаматтардың мемлекеттік оқу орындарында тегін орта білім алуына кепілдік беріледі. Орта білім алу міндетті 	2023-07-22 21:38:53.222442
4505	мобильді платформалар	зат есім	бірмағыналы	бұл белгілі бір қосымшадаплатформада орнатылған және белгілі бір функционалдылыққа ие планшеттер мен смартфондарға (iOS, Android, Windows Phone және т.б.) арналған әзірленген бағдарлама	1	Мобильді платформаға мобильді қосымшалар өңдеу қазіргі таңда өзекті мәселе деуге болады. Сол себепті, жұмыстың мақсаты адамдарға арналған Android және iOS операциялық жүйелеріне арнап мобильді қосымша құру болып табылады.	2023-07-22 21:21:05.919716
4506	модель	зат есім	көпмағыналы	белгілі бір зерттелетін нысанның ой түсінігі арқылы немесе материалдық түрде жасалған шартты үлгісі (бейнесі, сұлбасы, сипаттамасы, т.б.). 	1	Модельдің ең қарапайым түрі нысандарды көрнекі етіп сурет, кескін, сызба формасында графиктік түрде көрсету.	2023-07-18 03:22:33.886714
4507	мониторинг	зат есім	бірмағыналы	Бір құбылысты жікті бақылау	1	Мониторинг – диагностика жүргізуге және болжамдалған нәтижелерге сәйкес мектептің оңтайлы қызмет етуін қамтамасыз етуге мүмкіндік беретін, мектепті көп деңгейлі басқарудың маңызды жүйелерінің бірі.	2023-07-17 22:09:47.870228
4508	мөлшер	зат есім	бірмағыналы	Белгілі бір нәрсенің, заттың жалпы аумағын көрсететін шама, көлем.	1	Сайлау бюллетеньдерi сайлау округiндегi сайлаушылардың жалпы санының 1 процентi резервiмен сайлау округiндегi сайлаушылардың санына тең мөлшерде дайындалады.	2023-07-23 16:31:02.291917
4509	мөр	зат есім	бірмағыналы	Бір нәрсені куәландыру, растау үшін қолданылатын құрал, оның қағазға түскен дағы, ізі	1	Бұл фактінің растығын берілген мәліметтерге қойылған таңбалар мен мөрлерде дәлелдейді 	2023-07-19 03:17:17.694344
4510	мүгедек	зат есім	бірмағыналы	тіршілік-тынысының шектелуіне және оны әлеуметтік қорғау қажеттігіне әкеп соқтыратын аурулардан, жарақаттардан, олардың салдарынан, кемістіктерден организм функциялары тұрақты бұзылып, денсаулығы бұзылған адам.	1	Біздің елімізде мүгедектерге арналып арнайы пенсия тағайындалған.	2023-07-23 01:40:00.63024
4511	мүдде	зат есім	бірмағыналы	қоғамдағы әлеуметтік субъектілер іс-әрекетінің, өмір сүру бағдарының негізі, қозғаушы күші	1	Сайлау комиссиясының төрағасы сотта және басқа да мемлекеттік органдарда комиссияның мүдделерін бiлдіреді, сондай-ақ сайлау комиссиясының мүдделерін бiлдiру жөнiндегi өкілеттiктi тиiстi сенімхат беру арқылы басқа адамдарға беруге құқылы.	2023-07-17 17:34:34.802781
4512	мүлік	зат есім	бірмағыналы	қайсы біреудің меншігінде, біреуге тиесілі.	1	«Жалпыға бiрдей белсендi сайлау құқығы – Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сай­лауда дауыс беруге қатысу құқығы»	2023-07-21 23:59:23.184299
4514	мүмкін	сын есім	бірмағыналы		2		2023-07-20 06:01:02.86587
4515	мүмкіндік	зат есім	бірмағыналы	Бір істің іске асуына туғызылған қолайлы жағдай .	1	сайлаушылардың дауыс беруге арналған үй-жайға келу мүмкіндігі болмаған жағдайда олардың дауыс беруге арналған үй-жайдан тыс жерде дауыс беруін өткізу кезінде қатысу	2023-07-20 08:30:29.33495
4516	мүше	зат есім	көпмағыналы	Сойылған мал етінің қонағына қарай тартар негізгі бөлшегі жамбас, жілік, сүбе т.б.	1	Белгілі қоғамда өмір сүріп, оның белсенді мүшелерінің бірі болып отырғасын, ақын сол өзі дәуір сүріп отырған ортаға алдымен қызмет етуге міндеті	2023-07-20 08:10:40.739175
4517	назар	зат есім / етістік	көпмағыналы	Белгілі бір обьектіні немесе әрекет үстіндегі адамның практикалық және танымдық қызметінің бағытын және назарын қамтамасыз ететін жәй-күй.	1	сайлау комиссиясы мүшелерінің назарын осы Конституциялық заң талаптарының бұзылуына аударуға, оларға бұзушылықтар туралы тиісті жазбаша мәлімдемелерді, актілерді табыс етуге және табыс еткені туралы белгі соқтыруға құқылы.	2023-07-21 06:08:43.740031
4518	назар аудару	етістік	бірмағыналы	белгілі бір объектіге қабылдаудың селективті бағыты, кез-келген деректерді алу үшін объектіге деген қызығушылықты арттыру.	5	Белгілі бір обьектіні немесе әрекет үстіндегі адамның практикалық және танымдық қызметінің бағытын және назарын қамтамасыз ететін жәй-күй. Бір нәрсеге еріктеп тысқары (алдын ала ойластырылмаған) назар осы нәрсенің (физиол.тұрғыдан бағдарланған рефлекс) ондағы өзгерістерге, басқа нәрселерден айырмасына, оның әсер ету күшіне (күшті, жарық, қатты дыбыс) байланысты туындайды	2023-07-20 19:37:05.388099
4519	нақты	сын есім	бірмағыналы	Анық, тура айтылған ақпарат	2	Ал егер оқушы сұрақтың жауабын нақты білмей, басқа лампаны бұрап жіберсе, ол кезде лампа жанбайды («Қазақст. мект.»).	2023-07-23 07:59:00.422676
4520	нақтыла	етістік	бірмағыналы		5		2023-07-20 12:54:56.248064
4521	наным	зат есім	бірмағыналы	Бір нәрсеге сенім, иланым	1	әрбір адамның ой-сана, ар-ұждан, дін мен наным-сенім бостандығына, өз пікірін білдіру бостандығына, қауымдастық пен бейбіт жиналыстар бостандығына, жүріп-тұру бостандығына құқығы бар	2023-07-21 15:13:28.079761
4522	насихатшы	зат есім	бірмағыналы		1		2023-07-18 22:47:08.603893
4523	науқан	зат есім	бірмағыналы	Қоғамдық-саяси маңызы зор қауырт істелетін мерзімді іс	1	Өйткені олар сайлау науқаны аяқталған кезең мен сайлау қорытындылары ресми жарияланатын уақыт аралығында көпшілік демонстрациялар өткізуге тыйым салып, адам құқын шектейді немесе Қазақстандағы демократиялық институттар дамуында кері қадам болып табылады деген мәлімдемесіне орай өз көзқарастарын төмендегіше түйіндейді: «Бірқатар ТМД елдерінде таяудағы орын алған толқуларды ескерер болсақ, мұндай шектеулердің себебін түсіну қиынға түспейді»	2023-07-18 04:22:46.620702
4524	негіз	зат есім	бірмағыналы	Табан тірер, сүйеніш етер тірек, таяныш; жай-күй, жағдай.	1	Бақытқа жету үшін де негіз , тұяқ тірер тұғыр керек 	2023-07-22 00:30:26.163004
4525	негізгі	сын есім	бірмағыналы	ең басты ерекшелік	2	Бұл жерде салааралық баланстың жасанды қал ыпта сқаны н ата п өтеміз, өйткені ол, эмпирикалық материалдың аса көп санын және қате математикалық аппаратты пайдалануды алдын ала анықтайтын, қате экономикалық ережелер негізі нде жасал ған.	2023-07-18 15:41:45.584993
4526	негізделеді	етістік	бірмағыналы	Негізге алыну, сүйенілу.\n\n	5	Әрбір қимыл өз сипатына үйлес келетін музыка үніне негізделеді(«Қазақст. мект.»).	2023-07-17 15:48:28.23202
4527	нәсіл	зат есім	бірмағыналы	әлеуметтік мән берілетін физикалық сипаттамаларына қарай бөлінетін адамдар категориясы	1	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2023-07-22 20:48:09.21229
4528	нәтиже	зат есім	бірмағыналы	Белгілі бір іс-әрекеттен туатын, шығатын қорытынды, түйін	1	Үкімет басшысы индустриялық-инновациялық даму стратегиясын жүзеге асырудың бір тетігі саналатын корпорацияның жұмыс нәтижесін оң бағалай келіп, корпорация басшылығы алдына ағымдағы және орта мерзімдік кезеңге арналған бірқатар міндеттер қойды	2023-07-23 19:57:21.901961
4529	норма	зат есім / сын есім	көпмағыналы	Адамның іс-әрекетін және оның басқа адамдармен қарым-қатынасын реттейтін ереже	1	Электрондық сайлау жүйесiн пайдаланып сайлау өткiзген кезде осы Конституциялық заңның нормалары электрондық сайлау жүйесiн пайдаланудың ерекшелiктерi ескеріле отырып қолданылады.	2023-07-20 04:00:48.581506
4530	нормативтік	сын есім	бірмағыналы	уәкілетті орган қабылдаған, құқық нормасын белгілейтін, өзгертетін немесе алып тастайтын ресми жазбаша құжат	2	Медициналық қорытындыға қойылатын талаптар мен Республика Президенттігіне кандидат болып тіркелуге кедергі келтіретін аурулардың тізбесі Орталық сайлау комиссиясы мен денсаулық сақтау саласындағы уәкілетті органның бірлескен нормативтік құқықтық актісінде белгіленеді.	2023-07-21 13:18:24.542661
4531	нұқсан	зат есім	бірмағыналы	1. Кему, азаю, кемдік, кемістік. 2. Ауысп. Зиян, зиян тигізу, зияны тию.	1	кандидаттар, саяси партиялар туралы көрiнеу жалған мәлiметтер таратқан немесе олардың ар-намысы мен қадiр-қасиетiне нұқсан келтiретiн өзге де iс-әрекеттер жасаған	2023-07-23 08:44:18.337696
4532	нұсқа	зат есім	бірмағыналы	бір заттың көшірмесі, екінші данасы. Қазақ тілінде «бір істің жөні, жобасы», «үлгі, негіз» деген ауыспалы мағыналарда қолданылады.	1	Аралап тұзын таттым талай жердің, Кітаптан әуелі оқып нұсқа көрдім («Қисса Мұхаммед Расул Алланың дәрул пәниден дәрул бақиға рихлат еткен мәселесі». Бабалар сөзі. 11-том. 2005. 100 томдық).	2023-07-22 18:42:43.365476
4533	нұсқаулық	зат есім	бірмағыналы	іс-әрекетті жүзеге асырудың ұсынылған немесе міндетті амал-тәсілдері мен осы орайда қолданылатын құралдарды белгілейтін құжат	1	Орталық, облыстық, Астана және Алматы қалалық, аудандық (қалалық), округтік сайлау комиссиялары Сайлау қорларының тізілімін осы Нұсқаулыққа қосымшаға сай нысан бойынша жүргізеді	2023-07-20 16:09:54.184868
4534	облыс	зат есім	бірмағыналы	Кез келген республика құрамындағы ең ірі әкімшілік-аумақтық бөлік, аймақ.	1	Менің балалық шағым Тарбағатай баурайынд өткен болатын.	2023-07-21 14:45:05.706959
4535	облыстық	сын есім	бірмағыналы	Облыс көлеміндегі, облысқа қатысты.	2	Облыстық (республикалық маңызы бар қалалар және Республика астанасы), аудандық, қалалық, қаладағы аудандық сайлау комиссиялары аумақтық сайлау комиссиялары болып табылады.	2023-07-19 20:48:06.451445
4536	округ	зат есім	бірмағыналы	Аумақтық әкімшілікке, бөлікке тән, соған қатысты	1	Үкімет 2004 жылдан бастап селолық округтер үшін республикалық қазынадан 3 миллиард теңге қаржы бөлуге тиіс (“Жас Алаш”)	2023-07-24 04:15:29.206733
4537	оқыды	етістік	бірмағыналы	жазбаша сөзді оның белгілері, әріптері бойынша қабылдау	5	мамандарды даярлауда көптеген мәселелерді шешуге, сонымен қатар ғылыми - әдістемелік қорлардың орталықтандырылған банкісін құруға, қашықтықтан оқыту жүйесін дамытуға мүмкіндік береді.	2023-07-21 09:37:41.954327
4538	оң	сын есім	бірмағыналы	теріс,сол сөздерінің антонимі	2	"Арман,оң қолмен тамақ ішу керек"	2023-07-18 09:31:35.194172
4539	оңай	сын есім	бірмағыналы	Қиын емес, ауырлығы жоқ, жеңіл. 	2	Сондықтан еспелеп қайталақтауды шамалы қолданбаса, маңыздаудың орнына мылжыңдау болып кетуі оңай (А.Байтұрсынов, Шығ.).	2023-07-20 20:49:42.680871
4540	оңай	сын есім	бірмағыналы		2		2023-07-21 05:34:21.647868
4541	оңтайлы	сын есім	бірмағыналы	ынғайлы мағынасында	2	Оңтайлы сәтті жақсы пайдаланған абзал	2023-07-18 15:05:15.158565
4542	оңтайлы	сын есім	бірмағыналы		2		2023-07-22 19:41:21.987424
4543	оппозиция	зат есім	бірмағыналы	саясатта немесе пікірталастағы қарсы тарап	1	Саяси оппозицияның күшеюі демократия қағидаттардың дұрыс жұмыс істейтіндігін көрсетеді	2023-07-23 06:06:04.810281
4544	орналасқан	етістік	бірмағыналы	Орналас етістігінің қимыл атауы.	5	Заттық құраушы бөлшектердің кеңістіктегі заңды орналасуына қарай кристалдық тор түзіледі, осы тордың түйіндерінен атомдар, иондар, радикалиондар және молекулалар орын алады (К.Сапарбайұлы, Геология.).	2023-07-19 18:33:28.797323
4545	орналасқан жер	зат есім	бірмағыналы	сайлау учаскелерінің орналасқан жері анықталады	1	Сайлау комиссияларының құрамын қалыптастыру туралы шешiмдер, олардың құрамы мен орналасқан жерi бұқаралық ақпарат құралдарында хабарланады.	2023-07-20 10:12:04.076251
4546	орналастыр	етістік	бірмағыналы	Орналастыр етістігінің қимыл атауы, жайғастыру	5	Саяси партиялар адамдарды партиялық тізімге орналастыру тәртібін дербес айқындайды.	2023-07-22 22:13:44.561228
4548	орталық	зат есім	бірмағыналы	бір нәрсенің ортасы, негізгі бөлігі немесе нүктесі, сонымен қатар басты орын, елдің маңызды ресурстарының шоғырлануы, аумақтық бірлік, әлеуметтік топ, инфрақұрылым және т. б.	1	Нұр-Сұлтан Қазақстан Республикасының орталығы	2023-07-17 10:59:48.47613
4549	орын	зат есім	бірмағыналы	Бір нәрсені қоятын, орналастыратын кеңістік.	1	Эфир және баспасөз бетінен орын бергені үшін төлемнің мөлшері, шарттары мен тәртібі туралы мәліметтерді тиісті бұқаралық ақпарат құралы сайлау алдындағы үгіт жүргізу басталардан кемінде бес күн бұрын хабарлауға және жариялауға тиіс	2023-07-22 02:11:58.567486
4550	орынбасар	зат есім	бірмағыналы	Мекеме бастығының бірінші көмекшісі, оның қызметін атқаратын адам	1	Бригада командирінің орынбасары орта бойлы, қара торы, үшкір мұрынды подполковник екен	2023-07-22 00:06:45.644486
4551	орында	етістік	бірмағыналы	бір әрекетті іске асыру	5	Курстық жұмысты орындауға арналған әдістемелік нұсқау бар	2023-07-22 12:27:29.636198
4552	отандық	сын есім	бірмағыналы	Отанға тән, отанға қатысты	2	Отандық өнеркәсіпті өркендетуге лайықты үлес қосу қазақ жігіттері мен қыздарының да айбынды және абыройлы борышы	2023-07-17 19:04:45.11078
4553	отырыс	зат есім	бірмағыналы	 Көп адамның бас қосқан жері	1	Шілдехана өте бір көңілді, жайдары отырысқа айналды (Ө.Қанахин, Бақыт.)	2023-07-23 07:43:53.52136
4554	Офис	зат есім	бірмағыналы	Мекемелер мен кәсіпорындардың әкімшілік-кеңселік бөлімдерінің жалпы атауы.	1	Бұл жас Google компаниясының бас офисі болды, мен бос қолыммен келген жоқпын.	2023-07-20 07:20:45.852191
4555	өзге	үстеу	бірмағыналы	Бөлек, бөтен, басқа мағынасында қолданылады	9	Конституциялық заңда белгiленген өзге де жағдайларда партиялық тізімді тіркеуден бас тартады немесе тіркеу туралы шешімнің күшін жояды	2023-07-23 11:41:12.014548
4556	өзгеріс	зат есім	көпмағыналы	Ауытқу, өсу, жаңару.	1	Демографилық өзгерістер салдарынан бүгінде АҚШ пен Еуропаға ұлттық, діни және нәсілдік жағынан қайта өзгеру қаупі төнуде («Жалын»).	2023-07-20 02:13:36.706133
4557	өзгермейді	етістік	бірмағыналы	іс әрекеттің не заттың ауысусыз,өзгеріссіз қалуы	5	Тіпті тікелей өндірісішілік шығындар коэффициенттері мен технологиялық коэ ффициенттерді а нықтау [6 , 164 -б] қате көзқара сты өзгертуге мүм кіндік б ермеді, өйткені олар а ралық өнімдер шег інде ғ ана тауарларды жеткізу мен тұтыну теңдігінің ара қатынас нәтижелерін білдіреді.	2023-07-23 13:07:27.411934
4558	өзгерт	етістік	бірмағыналы	бір затты екіншісімен ауыстыру	5	жаңа міндеттерге сәйкес белгіліні жетілдіре, өзгерте аламыз	2023-07-21 13:41:01.970635
4559	өзгерту	етістік	бірмағыналы	бір затты екіншісімен ауыстыру	5	жаңа міндеттерге сәйкес белгіліні жетілдіре, өзгерте аламыз	2023-07-22 15:58:42.669972
4560	өзекті	сын есім	бірмағыналы	шын мәнінде бар, іске асырылған	2	Кермиық кер бетегесі туырылып, қара топырағынан май сорғалаған өзенді, өзекті өлкемен біздің ел жылап қоштасқан (С. Омаров, Дала.).	2023-07-20 00:45:40.070545
4561	өзектілік	сын есім	бірмағыналы	жаңалық мазмұны, даулы немесе эмоцияға толы оқиғалардан туындаған соңғы және өзекті жаңалықтардың ықпалы	2	сайлаушылар және сайлау учаскелерінің шекаралары туралы мәліметтердің өзектілігі мен анықтығын, дауыс беруге арналған сайлаушылар тізімдерінің уақтылы әрі дұрыс жасалуын және олардың барша жұрттың танысуы үшін ұсынылуын бақылайды	2023-07-18 21:39:59.743363
4562	өкіл	зат есім	бірмағыналы	Белгілі бір елдің, мекеменің, ұйымның көзқарасын, мүддесін білдіретін, оны жүзеге асыратын ресми адам	1	Сайлау комиссияларының құрамында өкілі жоқ саяси партиялар сайлау науқанын даярлау және өткізу кезеңіне тиісті сайлау комиссиясына сайлау тағайындалған немесе жарияланған күннен бастап он күннен кешіктірмей өз өкілін кеңесші дауыс құқығымен жіберуге құқылы.	2023-07-23 22:43:27.416783
4563	өкілдік	зат есім	бірмағыналы	Белгілі бір қызметті атқаруға берілген билік, құқық	1	Шақыруда миссия саны мен құрамына, сондай-ақ миссияда гендерлік балансты, елдік өкілдікті қамтамасыз етуге қатысты тілектер қамтылуы мүмкін.	2023-07-20 01:26:05.506935
4565	өміршең	сын есім	бірмағыналы	заттың немесе құбылыстың өмірге қабілеттілігі	2	Стратегиялық жоспар өзінің өміршеңдігін көрсетті	2023-07-19 14:31:45.294757
4566	өнімді	сын есім	бірмағыналы		2		2023-07-21 18:51:51.765437
4567	өңір	зат есім	бірмағыналы	1) жеке экономикалық-географиялық немесе ұлттық құрамы мен мәдениеті жақын, немесе белгілі әскеристратегиялық пайымдауға бөлінген әлемнің бір ауданы (мемлекеттен жеке алынған); 2) жалпы табиғи, әлеуметтік-экономикалық, ұлттық-мәдени және басқа да жағдайлары бар ҚР аумағының бір бөлігі.	1	қоғамдық пікірге сауал салу жүргізілетін өңірлер туралы, қолданылатын талдау әдістері туралы мәліметтер көрсетіледі.	2023-07-21 21:30:38.704246
4569	өркениет	зат есім	бірмағыналы	қоғамның материалдық және рухани жетістіктерінің жиынтығы	1	Өркениеттер қақтығысы кітабын оқыдым	2023-07-20 17:47:41.907076
4570	өркениетті	сын есім	бірмағыналы	Өркениеті бар, қоғамдық, мәдени дамуы жағынан көтерілген, жетілген.	2	Сайлаудың әділ әрі бәсекелі өтуі кез келген елдегі азаматтық қоғамның қалыптасқанын, мемлекеттің өркениетті екенін көрсетеді. 	2023-07-22 18:53:55.53185
4571	өсиеттеу	етістік	көпмағыналы	Өсиетте етістігінің қимыл атауы.	5	Абай атамыз міне дәл осы баянды еңбекті сол кезде де өсиеттей білді (I. Омаров).	2023-07-22 16:54:35.144636
4572	өсімдік	зат есім	бірмағыналы	тірі организмдер дүниесіндегі негізгі екі топтың бірі (біріншісі - хайуандар). 	1	Құрлықтың барлық жерінде өседі, суда кездесетін түрлері де бар.	2023-07-23 10:19:22.087598
4573	өтінім	зат есім	бірмағыналы	Қызметтің көрсетілуіне жазбаша түрде ресімделген ниет. Ұйымдастыру комитетіне немесе жарыстың төрешілер алқасына берілетін, қатысушылардың жасы, жынысы, спорттық біліктілігі көрсетілген тізімі бар құжат	1	Өтінім тақырыбы – босалқы бөлшектер жеткізілімі, жабдықты жөндеу, тауар белгісін тіркеу, өнертабысты патенттеу, несие алу т.б.	2023-07-19 09:11:02.095725
4574	өтініш	зат есім	бірмағыналы	өтінішті қарайтын субъектіге немесе лауазымды тұлғаға жіберілген жеке немесе ұжымдық жазбаша, ауызша не электрондық цифрлық қолтаңбамен расталған электронды құжат нысанындағы ұсыныс, арыз, шағым, сауал немесе үн қосу	1	Ғанидың өтініші бойынша шақырылған қазақ жастары өкілдерінің мәжілісі өтті	2023-07-21 17:20:34.045433
4575	өтіп жатыр	етістік	бірмағыналы	оқиғаның жалғасуы	5	Бұл өмір су арнасында тоқтамай өтіп жатыр	2023-07-17 23:00:05.296742
4576	өткiз	етістік	бірмағыналы	қандай да бір оқиғаның болуы	5	Қаңтар айында түрлі іс шаралар өткізілсін	2023-07-17 20:26:29.554267
4577	өткiзiлсiн	етістік	бірмағыналы	қандай да бір оқиғаның болуы	5	Қаңтар айында түрлі іс шаралар өткізілсін	2023-07-21 11:55:58.184795
4578	өткізіледі	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы	5	Дайындаушы кәсіпорындар тұтынушылар тапсырысты көп көлемде бергенде, делдалдар жоқ болғанда, басқа да жағдайларда өткізу қызметімен өзінің өткізу кеңселері, өткізуші агенттері арқылы айналысады (Қаз. тілі термин. Экономика).	2023-07-23 02:52:45.372236
4579	өткізілетін	сын есім	бірмағыналы	қандай да бір оқиғаның болуы	2	Етке өткізілуге тиісті, бірақ әлі өткізіп үлгермеген бес жүз қойдың артық боп шыққаны рас (С.Бақбергенов, Адам.).	2023-07-19 20:58:54.980524
4580	өткізу	етістік	бірмағыналы	Өткіз етістігінің қимыл атауы.	5	Өткізу керек багажға (C.Жиенбаев, Алтын қалам).	2023-07-21 00:03:48.939243
4581	өтпелі	сын есім	бірмағыналы	уақыттық тұрақсыз кезеңінің атауы	2	Өтпелі кезеңде өмір сүрудің өз заңдылықтары бар	2023-07-17 12:27:14.538948
4583	пайдаланушы	зат есім	бірмағыналы	Белгілі бір затты пайдаға асырушы, керегіне, қажетіне жаратушы.	1	Сондай дүрбелеңнен ел ішінде мылтық, қол пулемет сияқты қарулар да қалып қойып, оны жинап алып, кейбір жағдайда пайдаланушылар да табылып қалатын (С.Бегалин, Замана.).	2023-07-18 13:17:59.848947
4584	пайыз	зат есім	бірмағыналы	Бүтін ретінде алынған қандай да бір заттың жүз бөлігі, процент.	1	Тәуелсіздік алған 10 жылдан бері еліміздің экономикасына 12 миллиард доллардан астам қаржы тартылды, ал оның 40 пайызынан астамы мұнай-газ саласының үлесінде	2023-07-18 18:34:25.649007
4585	пакт	зат есім	бірмағыналы	өзара жəне коллективтік қауіпсіздікті, өзара көмек пен шабуыл жасаспауды жəне басқа да сұрақтарды, сондай-ақ мемлекеттер ынтымақтастығының нақты салалары үшін мағынасы үлкен қағидалар мен қалыптарын реттейтін өзара жəне көптараптық халықаралық шарттың атауы	1	Азаматтық және саяси құқықтар туралы халықаралық пактінің, сондай-ақ Еуропадағы қауіпсіздік және ынтымақтастық жөніндегі ұйымның, Еуропа Кеңесінің, басқа да халықаралық ұйымдардың еркін және әділ сайлауды өткізу туралы құжаттарының маңызын қуаттау	2023-07-17 11:29:00.289134
4586	парақ	зат есім	бірмағыналы	бір бет қағаз	1	Қол жинаушы адам қол жинаған кезде тиiстi қол қоятын парақта жеке қолы қойылған кандидаттың сенiм бiлдiрген адамының тiркелгенi туралы куәлiктiң көшiрмесiн көрсетуге тиiс.	2023-07-22 05:48:42.257006
4587	парасатты	сын есім	бірмағыналы		2		2023-07-19 02:01:42.590177
4657	саяси бәсеке	зат есім	бірмағыналы	билік үшін партиялар мен кандидаттар арасындағы тартыс	1	Саяси бәсекеде аясында екі ел арасында нарық соғысы өтті	2023-07-23 07:12:23.707155
4588	Парламент	зат есім	бірмағыналы	конституциялық мемлекеттерде жоғары заңнамалық өкілетті жиналыс.	1	Парламент ҚР заң шығару қызметін жүзеге асыратын Республиканың ең жоғары өкілді органы (1995 жылғы 30 тамыздағы ҚР Конституциясы 49-бап)	2023-07-21 00:42:52.581095
4589	партия	зат есім	бірмағыналы	1) белгілі бір әлеуметтік топ мүдделерін қорғайтын және сипаттайтын саяси ұйым және оның саяси әрекетіне басшылық жүргізеді; 2) жалпы көзқарас пен мақсаттармен біріктірілген тұлғалар тобы	1	Әркім өзінің қай ұлтқа, қай партияға және қай дінге жататынын өзі анықтауға және оны көрсету-көрсетпеуге хақылы	2023-07-17 14:10:16.850118
4590	пікір	зат есім	бірмағыналы	Өмірдегі құбылыстар мен заттар туралы өзіндік көзқарас, тұжырым, пайымдау.	1	Сайлау комиссиясының оның шешімімен келіспейтін мүшелері ерекше пікірін айтуға құқылы	2023-07-22 10:50:28.51362
4591	пікірсайыс	зат есім 	бірмағыналы	әртүрлі көзқарастың, ой- пікірдің ортаға салынып, көпшіліктің талқысына түсуі.	1	Мәслихаттар депутаттығына кандидаттардың партиялық тізімдерін ұсынған саяси партиялар телевизиядағы сайлау алдындағы пікірсайыстарға қатыса алады	2023-07-18 22:19:51.641081
4592	плюрализм	зат есім	бірмағыналы	пікірдің саналуандығын білдіру	1	Батыста плюрализм, академиялық бостандық жоғарғы деңгейде дамыған	2023-07-20 17:42:34.542773
4593	Президент	зат есім	көпмағыналы	елбасы;  кейбір республикада белгілі бір мерзімге сайланған мемлекет басы	1	Президенті – мемлекеттің басшысы, мемлекеттің ішкі және сыртқы саясатының негізгі бағыттарын айқындайтын, ел ішінде және халықаралық қатынастарда Қазақстанның атынан өкілдік ететін ең жоғары лауазымды тұлға (ҚР Конституциясы).	2023-07-17 21:04:20.165487
4594	пресс-релиз\n	зат есім	бірмағыналы	маңызды ақпараты бар баспасөзге арналған арнайы бюллетень.	1	Атырау облыстық аумақтық референдум комиссиясының баспасөз-релизі 5 маусым өткізілді	2023-07-22 01:56:59.063556
4595	принцип	зат есім	бірмағыналы	дүниені тану мен өзгерту процесінде фактілерді немесе білімдерді бір ізге салуға қызмет ететін, олардың кейібр жиынтығының түпнегізі ретінде көрінетін ғылыми танымның ерекше формасы	1	дауыс берудің еркіндігі және дауыс беруге мәжбүрлемеу принципі қарастырылған	2023-07-20 17:21:29.713082
4596	проблема	зат есім	көпмағыналы	оны шешуді талап ететін практикалық немесе теориялық мәселе; таным процесінде туындайтын белгісіздік немесе қайшылық, субъектінің белгілі бір жағдайда туындайтын қиындықтар мен қайшылықтарды қолма-қол білім мен тәжірибе арқылы шеше алмайтындығын түсінуі.	1		2023-07-17 22:16:33.108404
4647	сапар	зат есім	бірмағыналы	Бет алып шыққан алыс жол; саяхат.	1	Ауыр да азапты сапар артта қалды, сол сапарда туыстарын еске алып көп қайғырды (Д.Исабеков, Тіршілік).	2023-07-23 06:17:27.705955
4648	сапарлау	етістік			5		2023-07-17 10:35:41.595525
4597	пропорционалды	сын есім	бірмағыналы	негізі әрбір партия өкілді органда сайлаушылардың оларға берілген дауыстарына пропорционал санда депутаттық орындар санын алудан тұрады.	2	Мәслихаттардың депутаттарын пропорционалды сайлау жүйесі негізінде сайлау осы Конституциялық заңда көзделген негіздер басталған кезде, 2019 жылғы 1 қаңтардан бастап жүргізілетін болады.	2023-07-24 03:16:46.220298
4598	пропорционалдық	сын есім	бірмағыналы	барлық бөліктердің тең болу жағдайы	2	Пропорционалдық сайлау жүйесі негізінде парламентке 3 партия өтті	2023-07-18 20:11:40.299704
4599	пропорционалдық жүйе	зат есім	бірмағыналы	партиялық жүйе арқылы сайлау системасы	1	Пропорционалдық сайлау жүйесі негізінде парламентке і партия өтті	2023-07-19 11:22:02.36916
4600	процес	зат есім	бірмағыналы	1) бір нәрсенің дамуы қалпындағы құбылыстардың кезегімен алмасуы; 2) қандай да бір нәтижеге жету үшін әрекеттердің бірізді жиынтығы.	1	Халық арасындағы небір жаңа сөз, жаңа ұғымдар туып жатады, бұл табиғи процесс (Біздің Мұхтар).	2023-07-23 23:42:19.538215
4601	пункт	зат есім	бірмағыналы	Сайлау учаскесі, дауыс беру пункті орналасатын ғимаратта сайлау учаскесінің нөмірі көрсетілген дауыс беруге арналған үй-жайдың орналасқан жерінің көрсеткіштері ілінеді.	1	Дауыс беруге арналған үй-жайлар (пункттер) мүмкіндіктері шектеулі азаматтар үшін барынша қолжетімділікпен қамтамасызетіледі, бірінші қабаттарда орналасуы немесе басқа қабаттарға бару үшін көтеру тетіктері болуы тиіс	2023-07-20 14:35:34.946799
4602	пысықтау	етістік	көпмағыналы	оқыту процесінде оқушылардың алған білімі мен дағдысын бекіту, тиянақтау, жүйеге келтіру мақсатымен бұрынғы өткен материалға қайта оралу.	5	. Пысықтау оқу-таным жұмысының кезеңі, оқыту процесінің қажетті құрауышы.	2023-07-22 08:33:00.041301
4603	раста	етістік	бірмағыналы		5		2023-07-18 17:05:26.82954
4604	растамау	етістік	бірмағыналы	Бір нәрсенің орындалуын реттемеу	5	жеке табыс салығы бойынша асып кету сомасын толық растамаудың себептері көрсетілген бөлігінде растау	2023-07-23 07:12:00.419859
4605	растау	етістік	бірмағыналы	Раста етістігінің қимыл атауы.	5	Мен сені Арқадан іздеп келген жиенім деп елге лақап таратуға мәжбүр боламын. Сен менің осы сөзімді растауға  тиістісің (С.Омаров, Қиыр жол).	2023-07-20 13:34:14.269305
4606	ратификация	етістік	бірмағыналы	Белгілі бір халықаралық шартты жоғарғы өкімет органының бекітіп, оған заңды күш беруі	5	Тәуелсіз Мемлекеттер Достастығына қатысушы мемлекеттердегі демократиялық сайлаудың, сайлау құқықтары мен бостандықтарының стандарттары туралы конвенцияны ратификациялау	2023-07-24 03:37:27.994864
4607	регламент	зат есім	бірмағыналы	белгілі бір іс-әрекет тәртіптерін реттеу ережелері, қандай да бір мемлекеттік орган мен оның құрылымдық бөлімшелері қызметінің ішкі тәртібін реттейтін нормативтік құқықтық акт	1	Парламент Палаталарының төрағалары өздеріне Парламент регламенті жүктейтін басқа да міндеттерді атқарады	2023-07-17 14:53:21.649036
4608	редакция	зат есім	бірмағыналы	1) мәтінді өңдеу және дұрыстау, оны баспаға дайындау; 2) мәтіннің нақты жағдайы, оның қандай да бір түрі; 3) нақты тұжырымдамалар, пікір білдіру формасы; 4) басылымды басқаратын және оның мазмұнын белгілейтін немесе жариялауға арналған мәтінді өңдеуге және дайындауға арналған тапсырмаларды орындайтын қызметкерлер ұжымы; 5) қандай да бір басылым редакцияланатын бөлме.	1	Кандидаттар не олардың сенiм бiлдiрген адамдары болып тiркелген журналистердiң, бұқаралық ақпарат құралдары редакциялары лауазымды адамдарының сайлауды бұқаралық ақпарат құралдары арқылы көрсетуге қатысуына құқығы жоқ.	2023-07-23 11:06:08.796425
4609	резерв	зат есім	бірмағыналы	1. Әйтеуір қажетке жарайтын басы артық бір нәрсенің болуы. 2. Қажетті жаңа материалдарды, күштерді алатын көздер. 3. Белгілі мерзімге сақтап қойылған әскер құрамалары, әскер бөлімдері, соғыс қимылдарын жүргізуге, шығын орнын толтыруға іске пайдаланылатын әскер, әскери техника, қару-жарақ қорының болуы және кезегі келген әскерге шақырылушылар, запасқа шыққан әскери міндеттілер.	1	Сайлау бюллетеньдерi сайлау округiндегi сайлаушылардың жалпы санының 1 процентi резервiмен сайлау округiндегi сайлаушылардың санына тең мөлшерде дайындалады.	2023-07-21 09:34:51.196982
4610	рейтинг	зат есім	бірмағыналы	белгілі бір белгі бойынша артықшылық көрсеткіші	1	Партиялардың дауысқа түсу рейтингісіне қарай парламент пен мәслихаттан орын саны бөлінеді.	2023-07-18 06:03:14.435077
4611	ресімдеу	етістік	бірмағыналы	Ресімде етістігінен жасалған өзгелік етіс. Әзірлеу мағынасында қолданылады	5	сайлау учаскесінде, дауыс беруге арналған пунктте дауыс беру барысын, дауыстарды санау және дауыс беру нәтижелерін ресімдеу рәсімін барлық аталған рәсімдерді анық көру мүмкіндігін қамтамасыз ететін жағдайларда байқау	2023-07-20 01:57:13.87107
4674	сөйле	етістік	бірмағыналы		5		2023-07-19 16:03:28.540324
4612	республикалық референдум	зат есім	бірмағыналы	 хабарлауға тұратын нәрсе, аса маңызды мемлекеттік немесе қоғамдық мәселе бойынша сұрау салу немесе дауыс беру арқылы сайлаушылардың бүкілхалықтық еркін білдіруі. 	1	ҚР конституциялық заңдарының, заңдарының және мемлекеттік өмірінің өзге де неғұрлым маңызды мәселелеріне арналған шешімдердің жобалары бойынша бүкілхалықтық дауыс беру («Республикалық референдум туралы» 1995 жылғы 2 қарашадағы № 2592 ҚР КЗ 1-бап)	2023-07-19 04:25:00.897423
4613	ретсіз	сын есім	бірмағыналы		2		2023-07-23 11:26:34.942409
4614	ретте	етістік	бірмағыналы	Ретте етістігінің қимыл атауы.	5	Экспонаттарды соңғы бір реттеуде музей қызметкерлері жаңылып, тас этикеткасын ауыстырып алған деп түсіндіріпті (Қаныш аға).	2023-07-23 14:15:27.408658
4615	реттеледі	етістік	бірмағыналы	белгілі тәртіпті, жүйені бір нәрсеге енгізу	5	Қазіргі уақытта Қазақстанда аудиторлық қызмет жеткілікті деңгейде заңнамада реттелген.	2023-07-19 20:24:23.17087
4616	референдум	зат есім	бірмағыналы	 аса маңызды мемлекеттік немесе қоғамдық мәселе бойынша сұрау салу немесе дауыс беру арқылы сайлаушылардың бүкілхалықтық еркін білдіруі	1	Референдум - сайлау правосы бар барлық азаматтардың дауыс беруі арқылы ерекше маңызды мәселелер жөнінде халықтың пікірін анықтау (Саяси сөздік).	2023-07-17 21:00:34.27877
4617	реформа	зат есім	бірмағыналы	өмір сүріп отырған әлеуметтік құрылымның негіздерін сақтай отырып, қоғамдық өмірдің кейбір қырларын өзгертіп, қайта құру. 	1	Отан соғысы аяқталғаннан кейін совет халқының әл-ауқаты арта бастады. Карточка жүйесі жойылып, ақша реформасы жүргізілді (Халық бақыты.).	2023-07-23 07:09:20.544552
4678	спорт 	зат есім	бірмағыналы	. Организм нығайып, шынығуы үшін жасалатын дене жаттығуы.	1	Совет Одағында спорттың 60 түрі кеңінен дамыған (Ғалам ғажап.).	2023-07-21 05:28:13.34851
4618	рәсім	зат есім	бірмағыналы	белгіленген салтанатты шара, бірнәрсені орындау тәртібі	1	дауыс беру нәтижелері туралы хаттамаларды жоғары тұрған сайлау комиссияларына беру рәсімін байқауға құқығы бар	2023-07-22 11:40:54.894231
4619	рәсім	зат есім	бірмағыналы	символдық мағынадағы күндерді мерекелеуге арналған әрекеттердің дәйектілігі	1	Мерекенің ашылу салтанатының рәсімі өткізілді	2023-07-24 08:56:27.586415
4620	рәсімде	етістік	бірмағыналы	Рәсімде етістігінің қимыл атауы; белгілі бір әрекеттің заң күшіне ендірілуі.	5	Қазақстан мен Қытай шекаралық сызықтың делимитациясын және демаркациясын жүргізу арқылы оның режимі туралы келісімге келіп, шекараны заңдық рәсімдеу процесін аяқтады ( « Жұлдыз »).	2023-07-22 09:30:00.83814
4621	рөл	зат есім	бірмағыналы	мәні, қандай да бір іске, оқиғаға қатысу дәрежесі.	1	Күнделікті өмірде су ішудің де өмірлік ролі зор.	2023-07-17 12:11:53.714199
4622	рушылдық	зат есім	бірмағыналы	адамдардың туыстық топқа бөлінуі	1	рушылдық қазақтың бойындағы теріс қасиет	2023-07-18 07:54:05.259028
4623	сай	сын есім	бірмағыналы	қандай да бір процесстің, жұмыстың сәйкестілігін анықтайды	2	партиялық тізімге енгізілген адам Қазақстан Республикасының   Конституциясында және осы Конституциялық заңда кандидатқа қойылатын талаптарға сай келмеген	2023-07-18 23:55:57.012604
4624	сайла	етістік			5		2023-07-17 20:34:18.245519
4625	сайлану құқығы	зат есім	бірмағыналы	Республика азаматтарының мемлекеттік органдар мен жергілікті өзін-өзі басқару органдарын сайлауға және оларға сайлануға, сондай-ақ республикалық референдумға қатысуға құқығы бар	1	Жергiлiктi өзiн-өзi басқару органының мүшесi болып сайлану үшiн азамат Қазақстан Республикасының тиiстi заңымен белгiленген талаптарды қанағаттандыруға, сондай-ақ оның Конституцияның 33-бабының 2 және 3-тармақтарына сәйкес сайлану құқығы болуға тиiс.	2023-07-22 15:37:48.898903
4626	сайлау 	зат есім	омоним	 мақсаты мен нәтижесі белгілі бір уақытқа басқару және шешім қабылдау қызметтерін жүзеге асыратын адамдарды сайлау жолындағы іс-әрекеттің жиынтығы.	1	Сайлау  барысында заң бұзушылықтар анықталған жоқ	2023-07-23 20:30:02.47322
4627	сайлау 	етістік	омоним	сайлаудың немесе сайланудың ресми және ұйымдасқан процесі	5	Қалаған үміткеріңді сайлау	2023-07-24 09:08:50.187563
4629	сайлау жүйесі	зат есім	бірмағыналы	белгілі бір билік түрін, мемлекеттік өкілеттілік, заң шығаратын, атқару, сот орындарын қалыптастыруға қатысуды қамтамасыз ететін ережелер мен әдістердің жиынтығы.	1	Сайлау жүйесінде  сайлау және сайлану құқығын кімдерге беру, сайлаушылар тізімін жасау тәртібі, үгіт-насихат жүргізу, сайлау компаниясын қаржыландыру, кандидаттарды тіркеу, дауысты есептеу, сайлау нәтижесін анықтау, сайлау нәтижесін шағымдау тәртібі сияқты көптеген мәселе бар (ҚҰЭ).	2023-07-21 04:12:57.635532
4630	сайлау участкесі	зат есім	бірмағыналы	сайлау процессін белгілі бір территориялық аймақта ұйымдастыру	1	245 сайлау участкесінде дауыс беру	2023-07-19 04:24:07.083265
4631	сайлауалды	сын есім	бірмағыналы	сайлауға дайындық шараларын ұйымдастыру мерзімі	2	Сайлауалды бағдарламалар әдетте уәделерге толы болады	2023-07-20 01:36:17.887548
4632	сайлаушы	зат есім	бірмағыналы	Сайлауға қатысатын, дауыс беретін адам	1	Ана жылы Думаға депутат сайлауға жиналғанда, Торғай облысының сайлаушылары қазақша газет шығаруға деп бірнеше мың сом ақша жинаған	2023-07-23 01:26:48.546711
4633	сақтайды	етістік	бірмағыналы	затты бір уақытқа дейін алып қалу	5	жалпы өлшемдері талаптарының сақталуын қам тама сыз ету үш ін қандай да бір пропорцияла рдағы құр амды бөлі к болып көр інбейді.	2023-07-19 16:52:14.712379
4634	сақтау	етістік	көпмағыналы	Сақта етістігінің қимыл атауы	5	Мәліметтер тобын жедел жадтан сыртқы жадқа жазу; дайындалған құжаттарды белгілі бір ат қойылған файл түрінде дискіге жазып сақтау командасы.	2023-07-22 09:11:14.093471
4635	сал	етістік	бірмағыналы	Сал етістігінің қимыл атауы, бөлу, ие қылу	5	Сайлау күнi дауыс беруге арналған үй-жайда немесе пунктте қоғамдық пiкiрге сауал салуды жүргізуге тыйым салынады.	2023-07-21 09:38:59.197572
4636	сала	зат есім	көпмағыналы	Ғылым, өнер, әдебиет, мәдениеттің, қоғамның бір арнасы, бөлік, тармағы.	1	Әдебиеттің бір саласы болған театр кітабынан бұрын біз әуелі әдебиетіміздің не күйде екенін ескеріп өтелік (М.Дулатов, Шығ.).	2023-07-17 20:44:40.419038
4740	тікелей	үстеу	бірмағыналы	Тіке, тұп-тура, бірден.	9	Менің тікелей жүрген шаруам – елдің кітап оқуы (Ғ.Қайырбеков, Қарқаралы.).	2023-07-17 11:13:34.442306
4637	салынады	етістік	бірмағыналы	Салын етістігінің қимыл атауы.	5	Республикада ірі-ірі жаңа металлургиялық заводтар салынуына байланысты, Қазақстанда марганец рудаларының кеңінен пайдаланылатыны сөзсіз (Қ.Сәтбаев, Қазақстан.).	2023-07-19 01:42:21.871746
4638	салыстырғанда	етістік	бірмағыналы	Салыстыр етістігінің қимыл атауы; ойлаудың логикалық амалдарының бірі.	5	қайта дауыс беру кезiнде, басқа кандидатпен салыстырғанда, дауыс беруге қатысқан сайлаушылардың көпшiлiк дауысын алған.	2023-07-19 13:55:37.498656
4639	салыстырмалы	сын есім	бірмағыналы	заттар немесе құбылыстардың бір-бірінен артық-кемдігін анықтау	2	Салыстырмалы кесте жасай отырып, оқушылардың оқу деңгейін арттыру қажет	2023-07-19 15:52:28.225853
4640	сан	зат есім	көпмағыналы	Белгілі бір заттың, құбылыстың есеп мөлшері.	1	Шаңырақ таңбалары күлдіреуішінің санына қарай әртүрлі белгілерін білдіреді (Қ.Айтазин, Кәсіби лексика).	2023-07-19 22:27:35.09306
4641	сана	етістік	бірмағыналы	Сана етістігінің қимыл атауы	5	Ондық системаның пайда болуы он саусақ бойынша санаумен байланысты болғанына шүбә келтіруге болмайды (О.А.Жәутіков, Жаратылыстану.).	2023-07-22 16:26:10.869827
4642	санаймын	етістік	бірмағыналы	Сана етістігінің қимыл атауы	5	ҚазАқпарат - Латын әліпбиінің соңғы ұсынылған нұсқасы дұрыс деп санайды	2023-07-19 07:49:34.653259
4643	санақ	зат есім	көпмағыналы	Санақ – статистикалық қадағалау объектісінің статистикалық есептеме тәртібімен жиналатын бірқатар сипатты белгілері бойынша саны мен құрамын есептеу мақсатымен жүргізілетін арнайы ұйымдастырылған қадағалау түрлерінің бірі 	1	Сайлау учаскесiндегi (дауыс беру пунктiндегi) дауыстарды санағын жүргізу	2023-07-17 21:06:12.104721
4644	санат	зат есім	бірмағыналы	Маманның кәсіби деңгейін көрсететін өлшем, дәреже, категория.	1		2023-07-22 16:07:39.955918
4645	санау	етістік	бірмағыналы	Сана етістігінің қимыл атауы. Есептеу, санын анықтау	5	сайлау учаскесінде, дауыс беруге арналған пунктте дауыс беру барысын, дауыстарды санау және дауыс беру нәтижелерін ресімдеу рәсімін барлық аталған рәсімдерді анық көру мүмкіндігін қамтамасыз ететін жағдайларда байқауға	2023-07-22 04:15:35.025742
4646	санаулы	сын есім	бірмағыналы	заттың белгілі бір мөлшерде екенін білдіру	2	Сайлауға санаулы күндер қалды	2023-07-20 02:04:16.618071
4720	тең	сын есім			2		2023-07-24 00:04:18.818701
4650	сарапта	зат есім	бірмағыналы	Сарапта етістігінің қимыл атауы.	1	1965 жылы Польшада қоғамдық пікірді зерттеу мен программаны сараптау орталығы ұйымдастырылды (К. Үсебаев).	2023-07-24 04:01:26.549806
4651	сарапшы	зат есім	бірмағыналы	Объектілерді, процесстерді, құбылыстарды бағалау саласында арнайы білімі бар тұлға	1	iссапар шығыстарына, консультанттарға, сарапшыларға, лингвистикалық комиссияның мүшелерiне, электронды сайлау жүйелерінің пайдаланылуын қамтамасыз ететін мамандарға еңбек ақы төлеу	2023-07-21 18:10:26.656206
4652	сауал	зат есім	бірмағыналы	Қазіргі қазақ тілінде «көптен бері жауабын білгісі келіп жүрген сұрақ» (депутаттық сауал, журналистік сауал) ұғымында да қолданылады.	1	Шығардың қара өлеңмен түрлі қияу,\n\nМен айтқан бірақ ұғым сауал түрін (Айқын қыз).	2023-07-21 15:45:41.027109
4653	сауалнама	зат есім	бірмағыналы	сқрақтар қою арқылы алғашқы ақпаратты жинау әдісі	1	мемтептен 200 оқушыдан сауалнама алынды	2023-07-18 04:18:53.802002
4654	саясат	зат есім	бірмағыналы	мемлекеттік немесе қоғамдық істерді басқару шеберлігі	1	Мемлекеттік тіл туралы саясат заңғамалармен бекітілген	2023-07-20 12:31:25.154287
4655	саясаттанушы 	зат есім	бірмағыналы	бұл өз мемлекетінің де, басқа елдердің де қазіргі саяси оқиғаларын жақсы білетін маман.	1	Сенатор өз сөзінде 2050 жылы әлемнің ең дамыған 30 елінің қатарына кіру жөніндегі Қазақстан Президенті Нұрсұлтан Назарбаев алға қойған жаңа саяси бағыттың басты мақсатын іске асыруға саясаттанушы ғалымдар тікелей қатысуы тиіс екенін атап өтті	2023-07-20 19:58:34.321082
4656	саяси	сын есім	бірмағыналы	Саясатпен байланысы бар, саясатқа қатысты.	2	Шөлдеген қиялға сусын болатын әр тараулы мағлұмат, қазіргі қазаққа тілінде шығып тұрған газеталар саяси хабарларды жазудан артық босанбайды (“Абай”).	2023-07-23 16:26:57.141221
4658	саяси партия	зат есім	бірмағыналы	мемлекеттік билікті қолға лау және жүргізу мақсатында құрылған адамдардың ерікті одағы	1	Саяси партия құру үшін оның платформасын әзірлеу керек	2023-07-21 19:59:27.138115
4659	саяси технологиялар	зат есім	бірмағыналы	саясатта белгілі бір нәтижеге қол жеткізге бағыталған әдіс-тәсілдердің жиыны	1	Саяси технологияларды пайдаланып сайлауда жеғіске жетуге болады	2023-07-22 05:31:26.766723
4660	сез	үстеу	бірмағыналы	сезу, білу мағынасында	9	Достардың көмегін сезіну қиын сәттерде үлкен күш береді	2023-07-19 20:39:25.269484
4661	сезінеді	етістік	бірмағыналы	Сезін етістігінің қимыл атауы.	5	Шыншылдық өмір тәжірибесінен, соны терең сезінуден, ойланудан туады (С.Қирабаев, Октябрь.).	2023-07-19 13:40:32.885129
4662	семинар	зат есім	бірмағыналы	оқу-практикалық сабақтар, онда студенттер оқытушының жетекшілігімен оқу немесе ғылыми зерттеулердің нәтижелері бойынша жасаған хабарламаларын, баяндамалары мен рефераттарын талқылайды.	1	Жаңартылған бағдарлама Семинарлар бойынша өзіңізге керек материалды таңдап, тегін жүктеп, сабақ барысында қолдануға болады.	2023-07-19 03:39:38.322
4663	сенім	зат есім	бірмағыналы	адамның қорғашан ортаға қарым-қатынасын анықтайтын ұғым	1	партиялық тізімді ұсынған саяси партия, ол ұсынған кандидаттар, оның сенім білдірген адамдары сайлау алдындағы үгітті тіркелу мерзімі аяқталғанға дейін жүргізген	2023-07-24 00:35:42.520143
4664	сенімді	сын есім	бірмағыналы	Сөзге тұрақты, іске берік, сенім артуға болатын.	2	Сонымен бірге байқаушы ретінде әр үміткердің де сенімді адамдары қатыса алады.	2023-07-21 19:47:56.471806
4665	серпін	зат есім	бірмағыналы	талпыныс мағынасында	1	жаңа бағдарлама жастарға үлкен серпін берді	2023-07-20 21:53:33.180726
4666	сессия	зат есім	бірмағыналы	мәжілістер, өкілетті органдар, сот, ғылыми мекемелер жұмысындағы кезеңдер	1	Қазақстан халқы Ассамблеясы сайлайтын Парламент Мәжілісінің депутаттарын сайлау Республика Президенті шақыратын Қазақстан халқы Ассамблеясының сессиясында өткізіледі.	2023-07-20 20:59:10.244609
4667	сәйкессіздік	зат есім	бірмағыналы	талаптың орындалмауы. Біріне-бірі дөп түспеушілік, сай келмеушілік, үйлеспеушілік	1	Математика саласында ашылған жаңалықтардың көлемі мен олардың практикада қолданылуы арасында кейбір с ә й к е с с і з д і к бар, өйткені абстрактілі математика салаларындағы кейбір жаңалықтар осы уақытқа дейін практикада қолданылмай келеді	2023-07-17 20:48:44.744567
4728	тәкаппар	сын есім	бірмағыналы		2		2023-07-22 03:10:32.530664
4669	синтез	зат есім	бірмағыналы	Талдау нәтижесінде айқындалған белгілер мен қасиеттерді біріктіру	1	Гибридтік сайлау жүйесі мажоритарлық және пропорционалдық сайлау жүйелерінің синтезі	2023-07-23 01:58:17.855068
4670	сирек	сын есім	бірмағыналы	Жиі емес, селдір.	2	Жәлел бақыр басты келген, мұрны кішкене, ұсақ тістері сирек, қалмақ бетті бала (М.Әуезов, Шығ.).	2023-07-21 13:52:22.595076
4671	созылады	етістік	бірмағыналы	белгілі бір заттың жан жаққа тартылуы	5	әшекей бұйымдарды Сәуле созылатын жіптен жасайды	2023-07-17 14:53:09.316711
4672	сөз	зат есім	бірмағыналы	 Белгілі бір мағынасы бар заттар мен құбылыстардың атауын білдіретін тілдің негізгі единицасы	1	Айтылуда метр деген де, литр деген де – екі буынды сөз (Қазіргі қаз. тілі)	2023-07-17 22:19:27.810901
4673	сөз сөйлеу	етістік	бірмағыналы	бір мезгілде болатын нақтылы сөйлеу	5	сайлау комиссиясының отырысында сөз сөйлеуге, тиісті сайлау комиссиясының құзыретіне жататын мәселелер бойынша ұсыныстар енгiзуге және олар бойынша дауыс берiлуiн талап етуге құқылы	2023-07-23 21:46:31.748213
4675	сөйлеген	етістік	бірмағыналы	Адамдардың материалдық өзгертуші іс-әрекеті процесінде тарихи тұрғыда қалыптасқан тіл арқылы болатын қарым-қатынас нысаны	5	 Сыбырлап сөйлегенді Құдай естімейме, орыс солдатын жеңетін Қоқанда да күш жоғы өзіңізге аян (I. Есенберлин).	2023-07-23 14:11:42.751487
4676	сөйлес	етістік	көпмағыналы	Сөйлес етістігінің қимыл атауы.	5	– Байеке, бәйгем қайда, атым келді. Бас бәйгені байлану қақымда енді. Бұғыбай нөкөрлерін жиып алып, Өзара сөйлесуді мақұл көрді (1,189).	2023-07-21 23:52:43.734651
4677	Спикер	зат есім	бірмағыналы	бірқатар парламенттік мемлекеттердегі парламент басшысының немесе палата басшысының аты	1	Мысалы, АҚШ-та өкілдер палатасының спикері, Ұлыбританияда қауымдастар палатасының спикері дейді.	2023-07-19 21:57:04.996609
4679	стенд	зат есім	бірмағыналы	Әр түрлі суреттер, портреттер, графиктер ілінген тақта.	1	Жергiлiктi атқарушы органдар тиiстi сайлау комиссияларымен бiрлесiп барлық кандидаттар үшiн үгіттiк баспа материалдарын орналастыру үшiн орын белгiлейдi және оларды стендтермен, тақталармен, тұғырлықтармен жарақтандырады.	2023-07-21 22:16:02.084695
4680	су	зат есім	бірмағыналы	сутегі мен оттегінің қалыпты жағдайларда тұрақтылығын сақтайтын қарапайым химиялық қосылыс	1	Ауыз су, тіршілік көзі, ол Жер шарының 3 / 4 бөлігін алады, тірі ағзалардың 60-70%-ы, ал өсімдіктердің 90 % -ы судан тұрады.	2023-07-24 07:57:50.417934
4681	сүйеу	зат есім	бірмағыналы		1		2023-07-21 04:44:15.229298
4682	сүрінбе	үстеу	бірмағыналы	кедергілерден құламай өту мағынасында	9	Барлық сынақтан сүрінбей өттім	2023-07-22 00:33:03.331677
4683	сұра	етістік	бірмағыналы	Сұра етістігінің қимыл атауы; білгісі келу, жауап күту.	5	Жаутаңдап қарап дала тұр, Көз жасын сүртіп жаңа бір. Хабарсыз ұлын с ұ р а у ғ а, Жолыңды тосып ана жүр (С.Мәуленов, Алыс кет.).	2023-07-19 05:21:47.011984
4684	сұрақ	зат есім	бірмағыналы	 Жауап алу, бір-бірімен қарым-қатынас барысында ойларын айқындау үшін қойылатын сұрау, сауал	1	Алыстан айғайлап мен қоймағасын, Аялдап, аңдап, шолып, айналасын. Ағынмен арпалысқан мені көріп: – Айт, – деді – сұрағыңды , Қай баласың? (2,208).	2023-07-19 06:59:23.094208
4685	сұрақ-жауап 	зат есім	бірмағыналы	Алдын ала даярлап, қағазға жазылып қойылған сұрақтарға жауап қайтарылатын ісқағазы; анкета	1	Осы сұрақ-жауаптың негізінде келесі жолғы баяндамыз жарық көрмек.	2023-07-20 15:49:38.056279
4686	сұраныс	зат есім	бірмағыналы	Қажет етушілік, керек затты талап етушілік. 	1	Биылғы каталог ең сұранысқа ие қазіргі заманның нарығына сай болып саналады.	2023-07-18 03:48:15.37057
4687	сұратылған	етістік	бірмағыналы	Сұрат етістігінің қимыл атауы. Бір ақпаратты алу мағынасында қолданылады  	5	Бұл ретте кандидат пен оның зайыбының (жұбайының) кірістері мен мүлкi туралы мәліметтер ұсыну жөніндегі мемлекеттік кіріс органдарының талаптарын алған ұйымдар сұратылған ақпаратты талап алынған күннен бастап төрт күн iшiнде ұсынуға міндетті.	2023-07-20 15:47:56.153012
4688	сұхбат	зат есім	бірмағыналы	бағытталған диалог	1	Міне осындай ірі-ірі жетістіктерге жетіп отырған зейнетақы қорының басқарма төрағасының орынбасарымен болған сұхбатты “Түркістан” газеті оқырмандарының назарына ұсынып отырмыз	2023-07-19 06:11:57.372403
4689	сыбайлас	сын есім	бірмағыналы		2		2023-07-22 04:27:33.177734
4690	сыбайластық	зат есім	бірмағыналы	адамдар арасында негативті қарым-қатынас дәрежесінің көрсеткіші	1	Қоғамға зиян әрекеттердің бірі жемқорлардың сыбайластығы	2023-07-17 10:11:27.389327
4691	сыйыспа	етістік	бірмағыналы	белгілі бір ортада басқа адамдармен жақындаса алмады	5	Ол екеуі бір кеңістікте мүлде сыйыспайды	2023-07-22 09:48:05.160658
4693	табиғи	сын есім	бірмағыналы	қоршаған ортағы жанды және жансыз заттардың жиынтығы	2	Қазақстан табиғи ресурстарға бай мемлекет	2023-07-18 20:15:45.348811
4694	тағайындайды	етістік	бірмағыналы	бір орынға басқа адамды қоюы	5	Қоса беріліп отырған Мемлекеттік білім беру ұйымдарының бірінші басшылары мен педагогтерін лауазымға тағайындау, лауазымнан босату қағидалары бекітілсін.	2023-07-22 12:47:15.466328
4695	тағайындала алмайды	етістік	бірмағыналы	қалаған жұмысын ала алмады	5	Біз сізді болға барлық жайттардан кейін бұл жұмысқа тайғайындай алмаймыз	2023-07-23 00:48:37.064433
4696	тағайындалған	етістік	бірмағыналы	Сайлану/сайланған деген мағынаны білдіреді.	5	1840 жылы Құнанбай Өскенбайұлы тобықты еліне болыс болып тағайындалған болатын.	2023-07-24 04:36:03.639239
4697	тақта	зат есім	бірмағыналы	Түрлі хабарландыру, жарнама ілінетін, тақтайдан жасалған құрылғы.	1	Сонымен бірге сайлауға түсетін партиялар бағдарламалары ілінген тақта орнатылды»,- дейді ол.	2023-07-22 20:29:43.398445
4698	талас	зат есім / етістік	бірмағыналы	Белгілі бір мәселе жайындағы пікір тартысы, дау, керіс.	1	Әрі онда негізгі-негізгі деген 2-3 партия, әрі кетсе 4 партия таласқа түседі.	2023-07-21 00:24:24.806673
4699	талда	етістік	бірмағыналы	бір істің егжей-тегжейін ажырата зерттеу	5	қолданылатын талдау әдістері туралы мәліметтер көрсетіледі.	2023-07-17 12:40:42.138078
4700	талқыға сал	етістік	бірмағыналы	белгілі бір тақырыпты әңгіме қылу	5	Жиналыста көптеген мәселелер талқыға салынды	2023-07-21 22:01:12.526531
4701	талқыла	етістік	бірмағыналы		5		2023-07-19 05:42:40.548143
4764	түбегейлі	сын есім	бірмағыналы	нақты, тұтас мағынасында	2	Реформалардың мақсаты салада  түбейглі өзгерістер жасау	2023-07-22 07:49:48.766085
4702	талқыланды	етістік	бірмағыналы	 атау. Талқылан-у.	5	Күн тәртібінде «табиғатты қорғауды жақсарту және табиғи қорды тиімді пайдалану жө ніндегі шаралар туралы» маңызды мәселе талқылануда (М.Неталиев, Үл кен жол.)	2023-07-17 13:13:40.908197
4703	таны	етістік	бірмағыналы	(I) жеке академиялық, немесе кәсіби біліктілікті; (II) жоғары оқу орнының бағдарламаларын немесе (III) белгілі бір стандарттардың болуын растайтын құзырлы уәкілетті орган тарапынан сапаны қамтамасыз ету жөніндегі агенттіктерді формальді түрде тану.	5	жергiлiктi өзiн-өзi басқару органдары мүшелерiнiң сайлауын жарамсыз деп тану	2023-07-18 23:03:38.81697
4704	таңда	етістік	бірмағыналы	Таңда етістігінің қимыл атауы	5	Бүгінгі өмірімізде, қоғамда қандай мамандық таңдау, қай салада еңбек ету, кіммен тұрмыс құру әрбір жастың өз қалауындағы нәрсе	2023-07-22 09:26:23.520199
4705	таңдаушы	зат есім	бірмағыналы	Таңдап алатын адам	1	Дауыс беруге қатысқан сайлаушылардың немесе таңдаушылардың неғұрлым көбірек дауыс санын алған кандидат сайланды деп есептеледі 	2023-07-19 19:43:03.126151
4706	тап	етістік	бірмағыналы	сценарийлерде, жарнамада жекелеген сөздерді немесе әрекеттерді пайдалануға тыйым салу; демеуші, хабар тарату ұйымы, редакция енгізеді.	5	Азық табу оңай ма, Ақ иығын талдырды. Аңдар ығып тоғайға, Адырларды қалдырды (1,216).	2023-07-18 14:47:28.616614
4707	тапсырды	етістік	бірмағыналы	Өткізу секілді сипатта қолданылатын етістік.	5	Жансая алдыңғы аптадағы тапсырмасын жыр қылып жүріп тапсырды.	2023-07-19 03:18:31.560604
4708	тапсырма	зат есім	бірмағыналы	Міндеттелген жұмыс, іс	1	Олардың командирлері полковникке келіп жайды баяндап, қысқа-қысқа тапсырма алып кетіп жатты	2023-07-20 21:21:45.474781
4709	тапсырыс	зат есім / етістік	көпмағыналы	Тапсырылған іс, жұмыс, шаруа	1	Сайлауға байланысты қоғамдық пікірге сұрау салу нәтижелерін жариялаған кезде бұқаралық ақпарат құралдары сұрау жүргізген заңды тұлғаны, сұрау жүргізуге тапсырыс берген және оның ақысын төлеген адамдарды, сұрау жүргізілген уақытты, ақпарат жинау әдісін, сұрақтың нақты тұжырымын, сұралғандардың саны мен сұрау салу нәтижелерінің қателік коэффициентін көрсетуге міндетті.	2023-07-20 19:35:43.983645
4710	таралым	зат есім	бірмағыналы	Таралу мөлшері	1	кандидаттардың сайлау алдындағы үгітіне байланысты мерзімді баспасөз басылымының таралымы барлық кандидаттар үшін бірдей болып табылады	2023-07-17 12:43:48.148595
4783	тығыз	сын есім			2		2023-07-22 23:18:52.303569
4711	тарат	етістік	көпмағыналы	Тарат етістігінің қимыл атауы. 1. Халық арасына жайдырту, жеткізу. 2. Үлестіру, тарқату.	5	баспа, дыбыс-бейне және өзге де үгiт материалдарын шығару және (немесе) тарату жолымен жүзеге асырылады.	2023-07-20 01:31:44.081403
4713	Тарихи 	сын есім	бірмағыналы	Тарихқа байланысты, соған қатысты, тарихты баяндайтын.	2	Тарихи сәттер алда да көп іспеттес.	2023-07-21 15:04:00.473169
4714	тармақ	зат есім	бірмағыналы	Бір нәрсенің, заттың тарауы, саласы, бөлегі.	1	Еділ, Жайық, Сырдария – Белгілі жұртқа ескі су, Тәтті, дәмді, тармақты Ұзын Ертіс, Жетісу, Осы бес су арасы (М.Жұмабаев, Шығ.). 	2023-07-21 06:20:42.665658
4715	тарт	зат есім	бірмағыналы	Бір нәрсені істеуге ынталандыру, бір нәрсеге қатысу, бір нәрсеге қатыстыру. Біреуге қосылуға итермелеу, біреуді қолдаушы ету.	1	жауапқа тарту, ауыз біршілікке тарту	2023-07-18 09:59:19.934978
4716	тартуға болмайды	етістік	бірмағыналы	темекі тартуға болмайды	5	Бұл шарт Қаржы министрлігіне халықаралық аудит стандарттары, сапа кепілдігі және кәсіби этика жөніндегі Анықтамалық бойынша қазақ және орыс тілдеріндегі аудармаларды қайта жаңғыртуға, жариялауға және таратуға рұқсат береді.	2023-07-21 07:04:41.464749
4717	тегі	зат есім	бірмағыналы	Адамның түп нәсілін, арғы атасын білдіретін тарихи ұғым	1	Қазақстан Республикасының саяси партиялары, өзге де қоғамдық бірлестіктері, коммерциялық емес ұйымдары байқаушысының өкілеттіктері оның тегі, аты, әкесінің аты көрсетіліп, жазбаша нысанда куәландырылуға тиіс.	2023-07-20 18:14:19.339969
4718	тез	сын есім	бірмағыналы	. Тарақ жасаған кезде мүйізді түзетуге арналған аспап, қалып.	2	«Ал, жарым, қош» – деп, «Пәлен күні тос» – деп,«Тез келмесең, өлем» – деп, Болмады деп таң ұзақ, Сол болар қайғың жалғыз-ақ (Ш.Құдайбердиев, Шығ.).	2023-07-24 06:11:13.638306
4719	тексер	етістік	бірмағыналы	бір заттың дұрыстығын қарап шығу	5	Мәліметтерді салыстырып тексеру және ұсыну тәртібін Орталық сайлау комиссиясы айқындайды.	2023-07-23 23:54:53.244739
4721	тең	сын есім	бірмағыналы		2		2023-07-21 06:18:25.043398
4722	тең сайлау	зат есім	бірмағыналы	Сайлаушылар Президентті, Парламент Мәжілісі мен мәслихаттардың партиялық тізімдер бойынша сайланатын депутаттарын сайлауға, сондай-ақ аудандық маңызы бар қалалар, ауылдар, кенттер, ауылдық округтер әкімдерін сайлауға тең негіздерде қатысады әрі олардың әрқайсысының бір сайлау бюллетеніне тиісінше бір дауысы болады	1	Сайлаушылар Республика Президентi, партиялық тізімдер бойынша сайланатын Парламенті Мәжілісінің депутаттары және мәслихаттарының депутаттары сайлауына тең негiздерде қатысады әрi олардың әрқайсысының бiр сайлау бюллетенiне тиiсiнше бiр дауысы болады.	2023-07-18 07:04:46.877854
4723	тепе-теңдік	зат есім	бірмағыналы	Бірдей дәрежеде атқарылатын іс-әрекетті сипаттайды.	1	Білімі тепе-тең адамша сөйлесіп, мұғалім сенерліктей кейбір жақсылықтың ұшығын да аңғартты (Қ.Жұмалиев, Жайсаң жан.).	2023-07-17 19:47:57.758364
4724	терең	сын есім	бірмағыналы	Түбіне бойламай кететін тұңғиық; шыңырау.	2	Желсіз түнде жарық ай, Сәулесі суда дірілдеп. Ауылдың маңы терең сай, Тасыған өзен дірілдеп (Абай, Тол. жин.).	2023-07-21 15:46:16.460968
4725	теріске шығар	етістік	бірмағыналы	мәліметтердің жалған, дұрыс еместігінің дәлелдемелері(жариялануы тиіс).	5	Теріске шығару көлемі теріске шығарылатын хабардың немесе материалдың көлемінен екі есе және одан үлкен болмауға тиіс.	2023-07-20 02:46:25.393487
4726	тетік	зат есім	бірмағыналы	негізгі бөлшегі мағынасында	1	баұылаушылар сайлау процессінің реттеуші тетігі 	2023-07-23 20:59:21.445907
4727	тәжірибе	зат есім	бірмағыналы	Белгілі бір істі үнемі істеумен, машықтанумен болатын жұмыс дағдысы	1	Орталық сайлау комиссиясына жіберілетін хабарламада сауал салуды жүргізуге қатысатын және осы салада жұмыс тәжірибесі бар мамандар туралы, қоғамдық пікірге сауал салу жүргізілетін өңірлер туралы, қолданылатын талдау әдістері туралы мәліметтер көрсетіледі.	2023-07-20 21:08:03.12432
4729	тәрбие	зат есім	бірмағыналы		1		2023-07-18 00:44:50.879172
4834	функция	зат есім	бірмағыналы	Қызмет, міндет, жұмыс; қатынастар жүйесіндегі қайсы бір объекті қасиеттерінің сыртқы көрінісі	1	Әріптестер шеңберін кеңейте отыра, бүгінгі мұражай өткір әлеуметтік мәселелерді шешуге көмек бере алатын азаматтық белсенділік орталығының функциясын орындайды.	2023-07-20 06:40:38.209505
4793	уәде	зат есім	бірмағыналы		1		2023-07-20 06:51:44.419815
4730	тәртіп	зат есім	бірмағыналы	Аумаққа, ғимаратқа, ақпаратқа кіруді бақылау мен қамтамасыз  ететін ережелердің, шаралардың, нормалардың жиынтығы. Адамдардың қоғамдық ортада белгілі бір тәртіп жүйесін сақтауын және оларды игеруге міндетті нормаларды (құқықтық, моральдық, саяси-этностық) берік сақтауын талап ететін жүйе	1	Талқылаған негізгі екі мәселенің бірі – бүгінгі ауыл мәдениеті де, екіншісі – Т. Мергенбаевтың жеке басының тәртібі туралы болды	2023-07-21 19:50:41.045454
4731	тәсіл	зат есім	бірмағыналы	Белгілі бір істі орындап шығу үшін қолданылатын әдіс, амал, айла.	1	Тасқарада тәсіл көп сияқты. Орайы келсе–ақ жабыса кеткелі жүр (Ғ.Мүсірепов, Кездесп. кет.).	2023-07-17 10:26:31.080869
4732	тәуелді	сын есім	бірмағыналы	бағынышты мағынасында	2	Сайлау процессі заң талаптарына тәуелді	2023-07-17 14:07:11.306848
4733	тәуелсіз	сын есім	бірмағыналы	Өз саясатын, билігін өз еркімен жүргізуге қабілетті.	2	Қазақстан Президенті Н.Ә.Назарбаев құқықтық жүйенің қалыптасуы мен сот билігінің тәуелсіз қызметіне айрықша мән беріп отыр	2023-07-20 06:19:17.963297
4734	тиімді	сын есім	бірмағыналы	белгілі бір заттың ыңғайлы,қолайлы болуы	2	Жазғандар-ай, жанбағысты ойлап, басқа бір тиімді тіршілікпен айналыспай ма онанда (4,233).	2023-07-17 12:20:07.534154
4735	тиімсіз 	сын есім	бірмағыналы	Iс-әрекеттің ешбір қорытынды-түйінге келмей бітуі; жеміссіз.	2	Бұл жағдайдың өзіне т и і м с і з екенін түсінген қарсыласы қызбалықты қойып, шайқастың барысын басқаша жоспарлай бастады (Ә.Бүркітбаев, Жетімек).	2023-07-19 14:22:08.716699
4737	тиісті	сын есім	бірмағыналы	Қажетті, міндетті. 	2	Аумақтық және учаскелік сайлау комиссияларының мүшелерін саяси партиялардың ұсыныстары негізінде тиісті мәслихаттар сайлайды.	2023-07-18 17:56:20.1241
4738	тізбе	зат есім	бірмағыналы	Қатарлай тізілген тізбек.	1	Республика Президенттігіне кандидат болып тіркелуге кедергі келтіретін аурулардың тізбесі Орталық сайлау комиссиясы мен денсаулық сақтау саласындағы уәкілетті органның бірлескен нормативтік құқықтық актісінде белгіленеді.	2023-07-23 22:40:44.310627
4739	тізім	зат есім	бірмағыналы	Адамның, мал-мүлік, дүниенің қағаз бетіне рет-ретімен жазылған аты. Тізім көп элементті құрылымнан тұрады, оның кез келгенін қалауымызша таңдай беруге болады, оған элементтер қосуға немесе қысқартуға да мүмкіндік бар	1	Бір күні сайлаушылардың тізімін қарап отырсақ, Анна Николаева деген әйелдің туған жылы 1827 екен	2023-07-22 01:39:05.729971
4742	тірек	зат есім	бірмағыналы	 Бір нәрселерді тіреп қоятын ағаш	1	Білгендерге көк – құр қуыс. Рас, көктің сәулесі көп, бірақ онда қорек те жоқ, тірі және тіректе жоқ. Текеперлік не керек? (Ж.Аймауытов, Шығ.).	2023-07-18 19:55:12.531557
4743	тірке	етістік	көпмағыналы	1. Тұрған жерді көрсетіп, құжатта тіркелген белгі. 2. халықаралық шартты халықаралық үкіметаралық ұйымдардың жүргізетін арнайы тізіміне енгізу. 3. дипломатиялық өкілді тіркеу рəсімі	5	Кандидаттарды тіркеу мерзімі аяқталды	2023-07-21 14:46:53.390152
4744	тіркеу орны	зат есім	бірмағыналы	Тұрған жерді көрсетіп, құжатта тіркелген белгі.	1	Орган өз кезегінде азаматты тіркеу орны бойынша сайлаушылар тізімінен шығаруды және оны өзі дауыс беруді жоспарлап отырған сайлаушылар тізіміне енгізуді ұйымдастырады.	2023-07-22 19:37:50.101484
4745	тіршілік	зат есім	омоним	Күнделікті іс-әрекет, өмір, тірлік.	1	Тіршіліктің байлығы – денсаулық екеніне қай жұрттың, қай адамның болса да таласы жоқ (“Абай” журн.).	2023-07-21 07:46:32.48535
4746	тоқта	етістік	бірмағыналы	қозғалысты тоқтату,жұмыс істеу	5	Кенеттен ол тоқтап, сөмкені тым ауыр сияқты жерге түсірді.	2023-07-22 23:24:16.161134
4747	тоқтатылды	етістік	бірмағыналы	Тоқтат етістігінің қимыл атауы.	5	Арызға келген жетімді Жібермей тоқтату, Билерім, сізге жөн бе екен? (Бес ғасыр.).	2023-07-23 13:25:19.896629
4748	тоқтаусыз	сын есім	бірмағыналы		2		2023-07-21 16:50:36.553626
4749	толықтыру	етістік	бірмағыналы	Жетілдіру мақсатымен заңға қосымша өзгерістерді енгізу	5	Нақ осы кезеңде «Шаруашылық серіктестіктер туралы», «Өндірістік кооператив туралы» және басқа да заң күші бар Жарлықтар қабылданған еді, өзгерістер мен толықтырулар енгізіліп, бұлар күні бүгінге дейін қолданылып келеді (“Егемен Қазақстан”).	2023-07-22 13:53:13.970585
4750	толықтырылсын	етістік	бірмағыналы	үстіне қосу	5	Меніңше, бұл пікірге қосылуға да, қосылмауға да болатын сияқты (4,291)	2023-07-23 10:06:44.253184
4751	топ	зат есім	бірмағыналы	өзара әрекеттесетін және өзара тәуелді, белгілі бір мақсаттарға бірге жетуді көздейтін екі не одан көп жеке тұлға	1	Қазақстан Республикасының заңнамасы сайлаудың мерзімділігін, билік органдарында елдің әр түрлі әлеуметтік топтарының өкілдігін қамтамасыз етеді.	2023-07-21 21:32:53.21993
4752	тосқауыл	зат есім	бірмағыналы	Алдынан қарсы шығу, алдын бөгеу	1	Әрине, оған заңдық негіздегі шаралар арқылы тосқауыл қою керек, яғни әр адам өзінің азаматтық құқын біліп, ел алдындағы жауапкершілігін сезінуі керек. Ол үшін белсенді болу керек.	2023-07-17 22:24:08.997977
4753	төмен	сын есім	көпмағыналы	Артта қалған, деңгейі пәс.	2	Аңырақай кең сайдан тау өзені төмен құлап жатыр (4,241).	2023-07-21 19:35:55.310806
4754	төңірегі	зат есім	бірмағыналы	Бір заттың айналасы, жан-жағы, қасы; маңы.	1	Елбасы төңірегінде осындай жаңа әрі іскер жас басшылар көбейе түскенін қалар едік.	2023-07-20 10:50:24.85373
4755	төраға	зат есім	бірмағыналы	Мәжілісті, жиналысты басқарушы ресми тұлға.	1	Палаталарды мемлекеттік тілді еркін меңгерген өз депутаттарының арасынан Палаталар депутаттары жалпы санының көпшілік даусымен жасырын дауыс беру арқылы Сенат пен Мәжіліс сайлаған төрағалар басқарады (ҚР Конституциясы).	2023-07-23 10:26:49.117658
4757	төте сайлау	зат есім	бірмағыналы	Республика Президентiн, Парламентi Мәжiлiсiнiң және мәслихаттарының депутаттарын, аудандық маңызы бар қалалар, ауылдар, кенттер, ауылдық округтер әкімдерін, өзге де жергілікті өзін-өзі басқару органдарының мүшелерін азаматтар тiкелей сайлайды	1	Республика Президентін, Парламенті Мәжілісінің және мәслихаттарының депутаттарын, өзге де жергілікті өзін-өзі басқару органдарының мүшелерін азаматтар тікелей сайлайды	2023-07-17 20:58:30.690641
4758	төтенше	сын есім	көпмағыналы	Айрықша, ерекше.	2	Төтенше бір өжеттікпен өзегім өртеніп, мен сол сәт өз бойыма шақ келмейтұғын қайрат жасадым (М.Сатыбалдиев, Қоңыр қозы).	2023-07-18 01:16:14.941578
4759	тренинг	зат есім	бірмағыналы	білім - дағдыларды, әлеуметтік қызметтерді белсенді дамытуға бағытталған оқыту әдісі болып табылады	1	Тренингтер көптеген маңызды міндеттерді орындай алады. Жақсы тренинг көптеген практикалық нәрселерді айқындайды: оны қабылдап, оны қолданыңыз.	2023-07-19 07:21:51.348242
4760	туғыз	етістік	көпмағыналы	Жасау, қамтамасыз ету.	5	Мемлекет Қазақстан халқының тілдерін үйрену мен дамыту үшін жағдай туғызуға қамқорлық жасайды (ҚР Конституциясы).	2023-07-18 16:15:51.19128
4762	туындады	етістік	бірмағыналы	Туында етістігінің қимыл атауы.	5	Өріс кенейіп, өнім сапасын арттыруға жаңа бір себептер туындауы мүмкін (Ж.Дәуренбеков, Уақыттан.).	2023-07-21 03:08:57.598902
4765	түзет	етістік	көпмағыналы	Түзет етістігінің қимыл атауы; жөнге салу, жөнге келтіру	5	Арызданушы үшiн дұрыс шешiм қабылданған жағдайда сайлау комиссиясы сайлаушылар (таңдаушылар) тiзiмiне түзетудi немесе енгiзiлмеген сайлаушыны тiзiмге енгiзудi дереу жүргiзедi.	2023-07-18 08:18:16.607907
4766	түзету	зат есім	бірмағыналы	жарияланған материалдың ішінде жіберілген қате туралы оқушыларға ескерту, редакцияның атынан жарияланатын қысқаша хабар.	1	Бұл мақалада түзетулер көп байқалады.	2023-07-21 22:16:12.8071
4767	түйінде	етістік	бірмағыналы	Түйінде етістігінің қимыл атауы; түйін жасап байлау.	5	Эссенің соңғы абзацында ойыңызды түйіндеп, қысқаша қорытынды жасап жазыңыз. 	2023-07-17 23:35:06.927689
4768	түпкілікті	сын есім	бірмағыналы	Түбегейлі мағынасы түрінде қолданылып тұр	2	Партиялық тізімге енгізілген адамды осы тізімнен шығару туралы шешімге партиялық тізімді ұсынған саяси партия не партиялық тізімнен шығарылған адам сотқа шағым жасай алады, соттың шешімі түпкілікті болып табылады.	2023-07-21 03:45:46.321245
4769	түрткі	зат есім	бірмағыналы	субъектінің өмір сүру жағдайы ыкпалымен қалыптасатын және оның белсенділігінің бағыттылығын анықтайтын әрекетті туғызушы	1	Сайлау алдындағы үгiт - сайлаушылардың белгiлi бiр кандидатты, саяси партияны жақтап немесе қарсы дауыс беруге қатысуына түрткi болу мақсатындағы қызмет.	2023-07-24 00:45:29.61988
4770	түсін	етістік	бірмағыналы	Мәніне жету, бағалау.	5	Поэзия – әсемдікті мүсіндеу. Ал әсемдік – ізгіліктің қанаты. Жыр қадірін түсінбеу Гүл қадірін түсінбеуден әлдеқайда сорақы (М.Шаханов, Ғасырлар.).	2023-07-18 22:28:11.192079
4771	түсіндірме	зат есім	көпмағыналы	Бір нәрсенің мән-мағынасын ашатын сипаттама	1	Сұрау мен жауапқа үлкен мағына берген сықылды, сөзге, әңгімеге, түсіндірмеге, дәлелге де үлкен маңыз беру тиіс (Ж.Аймауытов, шығ.).	2023-07-21 13:59:52.142134
4772	түсініктеме	зат есім	көпмағыналы	Бір нәрсе жайлы деректеме, анықтама	1	кандидаттардың, саяси партиялардың ешқайсысына артықшылық бермейді және олардың сөздеріне түсініктеме бермейді	2023-07-17 18:25:08.990177
4773	тұғыр\n	зат есім	бірмағыналы	Тірек, тіреу, сүйеніш мағынасында қолданылады	1	ЖЕҢІСКЕ ЖЕТКІЗЕТІН ЖЕТІ ТҰҒЫР	2023-07-20 09:36:20.848947
4774	тұжырым	зат есім	көпмағыналы	Белгілі бір істің, ойдың қорытындысы, байламы, шешімі	1	сауал жүргiзілген уақытты, ақпарат жинау әдiсiн, сұрақтың нақты тұжырымын, сауал салынғандардың саны мен сауал салу нәтижелерінің қателiк коэффициентiн көрсетуге мiндеттi.	2023-07-18 19:29:42.579077
4775	тұжырымдама	зат есім	бірмағыналы	ұғымдар мен көзқарастардың орамды жиынтығы	1	Тұжырымдамана сапалы әзірлеу үшін сарапшылар керек	2023-07-23 15:18:26.545984
4776	тұлға	зат есім	көпмағыналы	пайымдау, мораль, зерде, мендік сана секілді болмыстық қырларын, сондай-ақ әлеуметтік байланыс пен мәдени нормалға қатысты туыстық, мүлік меншігі, заңдық жауапкершілігі қатарлыларды қамтитын, кісілік қабілеттер мен ерекшеліктерге ие жеке адамды сипаттайды.	1	Тұлғалық қасиеттер мен тұлғалық қырлар бір адамның қандай адам болғанын, қандай қасиеттер мен қабілеттер оны сондай адам еткенін, оның түрлі мәдени контекстегі ерекшелігі мен рөлін білдіреді.	2023-07-20 20:09:36.474305
4777	тұрады	етістік	көпмағыналы	адамның өзінің айтқан нәрсесін де тұруы	5	арнайы бағасының болуы: 500тг тұрады	2023-07-22 18:11:30.925759
4778	тұрақты	сын есім	көпмағыналы	Бағдарлама орындалу барысында тұрақты мәні сақталатын шама; математикалық сан	2	Алдын ала берілген мейлінше аз оң е санына сәйкес келетін және оған тәуелді N(е) саны табылып, айнымалы хn мен тұрақты а санынан n-інші нөмірден бастап	2023-07-18 00:41:15.565439
4779	тұрғылықты жері	зат есім	бірмағыналы	жеке тұлғаның тұрғылықты жері (почта мекен-жайы) немесе заңды тұлғаның орналасқан жері	1	Нақтылы сайлау учаскесiнде азаматты сайлаушылар тiзiмiне енгiзу үшiн оның осы сайлау учаскесiнiң аумағында тұрғылықты жерi бойынша тiркелу фактiсi негiз болады.	2023-07-18 05:01:59.363799
4780	тұс	зат есім	бірмағыналы	Бір заттың тұсы, қапталы, бүйірі.	1	Комиссияның бюллетеньдi (бюллетеньдердi) берген мүшесi оларға өзiнiң қолын қояды, сондай-ақ бюллетеньдi (бюллетеньдердi) алған сайлаушының (таңдаушының) тiзiмдегi тегiнiң тұсына қол қояды.	2023-07-23 19:31:46.460595
4781	тұстары	зат есім	бірмағыналы	Бір кездерде	1	 Б і р т ұ с т а р д а пайдасынан зияны көп болған сол әсем аңғардың алқымына бұл күнде үлкен тоған салынған (Ә.Кекілбаев, Лашын.).	2023-07-19 08:37:41.484911
4782	тұтас	сын есім	бірмағыналы	барлығы деген мағынада	2	бұлттар аспанды тұтас тұмшалап тастады	2023-07-22 05:47:01.450914
4784	тығыз байланысты	үстеу	бірмағыналы	байланыстың беріктігін көрсету	9	Тығыз байланыс орната отырып одаққа мүше елдердің ортақ экономикасын құруға болады	2023-07-21 03:25:05.550098
4785	тығырық	зат есім	бірмағыналы	Ілгері жүруі, өтуі қиын тұйық жер. Өмірде кездесетін қиыншылық; дағдарыс	1	Осы арқылы дауыс ұрлағысы келгендерді тығырыққа тірейді. 	2023-07-18 12:02:29.603642
4786	тыйым	зат есім	бірмағыналы	Тыйып тастағандық, тежегендік; тоқтам.	1	Қиқулаған қалың қол құйын дерсің,\n\nҚайтып оған шағын жұрт тыйым берсін.\n\nТозған жұртты топырлап тапап кетті,\n\nҚатыгез жау қайсыбір бұйым көрсін (2,101).	2023-07-19 01:10:52.224465
4787	тыңда	етістік	омоним	есту арқылы қабылдау, есту үшін кез-келген дыбысқа бағыттау	5	Зейін қойып тыңдау дегеніміз не және бұл біздің қарым-қатынасымызға тікелей әсер етеді	2023-07-21 09:42:56.03684
4788	тыс	сын есім	бірмағыналы	бір аймаққа тиелісі болмайтын	2	Биліктің, қоғамның назарынан тыс қалып, құқықтары жеткілікті қорғалмай жатқан екі әлеуметтік топтың билік құрылымдарына жетіп, маңызды мәселелерге араласуы елдің дамуы жолындағы оң үдеріс болғанымен, жынысына, дініне, көзқарасына қарамастан шынайы демократиялық бәсекелес орта құру принциптеріне кереғар келіп жататыны да айтылуда.	2023-07-18 14:25:43.069303
4789	тысқары	сын есім	бірмағыналы	Сырт жерде, далада	2	Yгiттiк баспа материалдарын Қазақстан Республикасының аумағынан тысқары жерлерде дайындауға тыйым салынады.	2023-07-17 13:12:29.692403
4790	уағыз	зат есім	бірмағыналы	«насихаттау, үгіттеу», «үйрету, ұқтыру, жөн сілтеу»	1	заңдарда көзделмеген әскерилендiрілген құралымдар құру идеялары уағыздалмауға тиiс.	2023-07-17 10:40:30.222166
4791	уақыт	зат есім	бірмағыналы	Ол материалдық объектілердің өмір сүруінің ұзақтылығын және сол объектілердің даму процесінде өзгерулерінің (күй – жағдайларының ауысуының) тізбектілігін білдіреді	1	Не дерсің уақыт құрғырға,\n\nБіреулер кеткен жантайып,\n\nОралмас мәңгі құрдымға,\n\nБіреулер қалған қартайып,\n\nАттандым аз күн тұрдым да (3,242).	2023-07-18 09:35:42.289282
4792	уақытша	сын есім	бірмағыналы	Белгілі бір уақытқа дейін, қысқа мерзімге	2	Елдің орталық сайлау органы тұрақты негізде немесе сайлау кезеңінде ғана – уақытша жұмыс істей алады. 	2023-07-23 04:24:17.287318
4794	учаске	зат есім	бірмағыналы	Учаскеге тән, учаскеге қатысты	1	Аумақтық және учаскелік сайлау комиссияларының мүшелерін саяси партиялардың ұсыныстары негізінде тиісті мәслихаттар сайлайды	2023-07-17 23:17:56.667055
4795	учаскелік	сын есім	бірмағыналы	Учаскеге тән, учаскеге қатысты	2	Екі күн өткеннен кейін Серікқалиға Ақсайдың учаскелік милиционері келді (Қ.Исабаев, Соңғы ерлік)	2023-07-19 09:38:41.811125
4796	үгіт	зат есім	бірмағыналы	ауызша не газет-журнал бетінде белгілі бір саяси мәселені көпшілікке түсіндіру үшін жүргізілген әрекет, қызмет	1	Сайлау алдындағы үгіт Сайлау комиссияларында кандидаттарды тіркеген күннен бастап сайлау алдындагы үгіт басталады	2023-07-18 18:16:52.987485
4798	үдеріс	зат есім	көпмағыналы	Қауырт қозғалыс, қарбалас.	1	“Жағымды” 50 пайызға Ресейдегі көптеген үдерістерді “күтімді қалыпқа” көшіретін Президент сайлауы, сондай-ақ басқа да елдердің тұжырымдамалары қосылады (“Егемен Қазақстан”).	2023-07-24 00:19:41.250205
4799	үзінді	зат есім	бірмағыналы	Сөйлеген сөзден, шығармадан бөлініп алынған бөлшек	1	Саяси партияның тиісті филиалының (өкілдігінің) жоғары басшы органының аудандық маңызы бар қала, ауыл, кент, ауылдық округ әкіміне кандидат ұсыну туралы шешімі хаттамадан үзінді көшірмемен ресімделеді.	2023-07-17 15:48:15.898704
4800	үй	зат есім	бірмағыналы	Баспана, пана.	1	Үйдің құрылысы шаршатты,-деді Сәлима күйеуіне ренжіген түр танытып.	2023-07-23 19:28:50.359169
4801	үкім	зат есім	бірмағыналы	«шешім, бұйрық», «билік, үстемдік».	1	Конституция бойынша сайлауды мамыр айында өткізуге үкім шығарған еді.	2023-07-21 02:55:09.6856
4802	үлгі	зат есім	бірмағыналы	Бұйымды, т.б. бір-бірінен бұлжытпай жасауға арналған қалып. Ауыспалы мағынада өнеге, тәлім ретінде пайдаланылады	1	Егер өндірістік үлгісі болмаса, мұндай модельді де қолдан жасау қиын емес	2023-07-17 15:14:01.191917
4804	үлес	зат есім / етістік	көпмағыналы	Бір нәрседен әрбір адам өзіне тиесілін бөліп алу.	1	Қазақстандағы алдағы сайлауда әйелдер мен жастардың үлесі жалпы сайланушылардың 30 пайызынан төмен болмауы тиіс деген ұстаным да қоғам тарапынан екі жақты ой қалыптастыруда.	2023-07-23 17:35:38.142411
4805	үлкен 	сын есім	бірмағыналы	Көлемі бойынша біршама ауқымды немесе жасы көп деген мағынада қолданылады.	2	Үйден үлкен адамның телогрейкасына оранған 5-6-лар шамасындағы қыз бала шықты (4,147).	2023-07-19 06:43:21.472357
4806	үміт	зат есім	бірмағыналы	Белгілі бір істің, ойдың жүзеге асуына білдірілген сенім	1	Үмітім бар, тыңла, сізден шапағат, Һәмма адам жығылғанда қиямет	2023-07-24 07:51:24.717498
4807	үміт	зат есім	бірмағыналы		1		2023-07-21 02:45:07.737716
4808	үміткер	зат есім	бірмағыналы	Бір нәрседен (жетістіктен, жақсылықтан т.б.) үміті бар, дәмелі адам.	1	Үміткерге дауыс беру барысында туындауы мүмкін кейбір келеңсіздіктерді де ескерген жөн.	2023-07-19 19:51:11.664177
4809	үн	зат есім	бірмағыналы	дауыс, дыбыс мағынасында	1	Тамылжыған кеште жастар үні керемет 	2023-07-18 23:50:58.97192
4810	үндеу	зат есім	бірмағыналы	Халықты белгілі бір іске жұмылдыру үшін жазылған ұран; шақыру.  2. Батыл қимылға, стачка, ереуіл, қарулы көтеріліске шақыратын, әдетте, астыртын таратылатын хат.	1	Ол саған үндеу тастаса да, сен оны білдіртпей жүрсін.	2023-07-22 11:12:05.052004
4811	ұғым	зат есім	бірмағыналы	Белгілі бір зат, құбылыс жөніндегі адамның түсінігі, танымы	1	Қазақстан Республикасы Сайлау туралы заңының 4-бабында бұл ұғымдарға былайша баға берілген.	2023-07-17 13:56:51.380722
4812	ұғынықты	сын есім	бірмағыналы	Түсінікті деген сөздің орнына қолданылады.	2	Оның сөздері әрі ұғынықты, әрі қарапайым, әрі дәлелді де келетін (Аялы жандар).	2023-07-22 05:45:18.584584
4867	шығыс	зат есім	бірмағыналы	шығымы, түсім мағынасында қолданылады. Шығарылған шығындарды білдіреді	1	Орталық сайлау комиссиясы мен оның аппаратын ұстауға жұмсалатын шығыстар республикалық бюджеттен қаржыландырылады.	2023-07-21 20:25:22.557102
4868	Шығыс Қазақстан	зат есім	бірмағыналы	Қазақстанның ірі облыстарының бірі.	1	Өткен турда Шығыс Қазақстандықтар «Томлестен» 0:1 есебімен ұтылды (Бір-ақ ұпай // Спорт.).	2023-07-21 14:37:54.23326
4870	шынында	үстеу	бірмағыналы		9		2023-07-20 02:47:53.684767
4813	ұйым	зат есім	бірмағыналы	Мемлекеттік, бұқаралық немесе қоғамдық мекеме. Меншік және бағынушылық нысанына тәуелсіз кәсіпорын, мекеме, ұйым. Өзара байланысты ерекше мақсаттарға жетуге және жоғары формалданған құрылымдардың қалыптастырылуына бағытталған әлеуметтік топ	1	Нашарға көңілдері еріп жатыр, «Мә, жәрдем!» – деп аямай беріп жатыр, Ұйымнан, ынтымақтан басын тартпай, Сөзге, жөнге, қатарға кіріп жатыр	2023-07-21 18:12:20.289633
4814	ұйымдастыр	етістік	бірмағыналы	Бір істі ұйымдастырған адам	5	Әкем С.Мақатаев ұжымшарды тұңғыш ұйымдастырушылардың бірі еді, соңынан сол шаруашылықты басқарды (5,223)	2023-07-20 08:04:46.735149
4816	ұйытқы	зат есім	бірмағыналы		1		2023-07-20 00:40:14.309336
4817	ұқыпты	сын есім	бірмағыналы		2		2023-07-23 01:58:39.440021
4818	ұлан-байтақ	зат есім	бірмағыналы		1		2023-07-22 21:56:05.15193
4819	ұлт	зат есім	бірмағыналы	Тіл, территория, экономикалық өмір тұтастығы негізінде және психологиялық мінез-құлықтың ортақтығы негізінде қалыптасқан адамдардың тарихи әлеуметтік, этникалық тұтастығы	1	Жалпыға бiрдей белсендi сайлау құқығы - Республиканың он сегiз жасқа жеткен азаматтарының тегiне, әлеуметтiк, лауазымдық және мүлiктiк жағдайына, жынысына, нәсiлiне, ұлтына, тiлiне, дiнге көзқарасына, нанымына, тұрғылықты жерiне немесе кез келген өзге жағдаяттарға қарамастан, сайлауда дауыс беруге қатысу құқығы.	2023-07-18 20:37:45.97142
4820	ұлттық	сын есім	бірмағыналы	Белгілі бір ұлтқа тән, ұлтқа қатысты; ұлт ерекшеліктерін көрсететін, қамтитын.	2	Қоғамның ұлттық-мәдени және өзге де елеулі мүдделерінің білдірілуін қамтамасыз ету қажеттілігі ескеріліп, Сенаттың он бес депутатын Мемлекет Басшысы тағайындайды.	2023-07-24 07:27:07.504055
4821	ұлтшыл	сын есім	бірмағыналы		2		2023-07-24 06:20:03.487378
4822	ұпай	зат есім	бірмағыналы		1		2023-07-24 06:47:31.452262
4823	ұран	зат есім 	бірмағыналы	Халықты бір іске жұмылдыру мақсатында айтылатын үндеу, шақыру, дабыл	1	Сайлауалды үгіт науқаны басталды деп, Елбасы жаңаша ұран тастап, жаңа уәделер, құлаққа жағымды сөздер айтумен әуестенген жоқ	2023-07-18 16:44:56.160885
4824	ұрпақ	зат есім	бірмағыналы		1		2023-07-21 13:41:01.055929
4825	ұстаным	зат есім	бірмағыналы	Нақты бір мәселеге көзқарас.	1	Бұл мәселе жөніндегі менің ұстанымым “Огни Алатау” газетінде толық бейнеленді («Алматы ақшамы»).	2023-07-23 20:17:37.947181
4826	ұсын	етістік	бірмағыналы	біреудің билігіне, қолдануына, біреуге қызмет етуге, бірдеңе жасауға баруға дайын болу немесе тілек білдіру	5	бүкіл өндіруші секторла р мен тауа рлар тізі мі ар асындағы жалпы тепе-теңдік ара қатынасына әкелетін тех нологиялы қ коэ ффициенттерді анықтау әдісін, сондай-ақ сызықтық теңдеулер жүйесін ұсынады	2023-07-21 04:32:01.748155
4845	халықаралық	сын есім	бірмағыналы	халықтар мен елдердің өзара байланысы, соларга тән қасиеттер	2	Сақтың жауынгерлік ерлігімен қабат ертегі-аңыздары да халықаралық көлемде көп тарады (М. Ақынжанов).	2023-07-20 07:18:30.37774
4846	халықаралық қатынастар	зат есім	бірмағыналы	әлемдік деңгейде іс-әрекеттер жасайтын субъектілер арасындағы экономикалық, саяси және мәдени байланыстар	1	халықаралық қатынастар факультетінде оқу	2023-07-23 16:14:29.713987
4835	хабар	зат есім	көпмағыналы	Болған іс, оқиға, сондай-ақ біреулердің хал-жайы жөнінде білдірілген қысқаша мәлімет.	1	Сол күні «солдат алады» деген хабар Ертістің екі жағына тарап кетті (I.Жансүгіров, Шығ. жин.).	2023-07-21 06:27:06.598977
3898	адам 	зат есім	бірмағыналы	Ойлау және сөйлеу қабiлeтi зоp, еңбек құpалдаpын жасап, олаpды өз игілік қажетте жаpата білетін қоғамның саналы мүшесі.	1	Һүнер мен мәзкүрлерді адам тапқан, Жалғыз-ақ біздің қазақ қарап жатқан (М.Дулатов, Шығ.).	2023-07-18 13:48:10.837359
3900	азамат	зат есім	бірмағыналы	 Кәмелетке толып, ер жеткен адам\nбелгілі бір мемлекетке құқытық негізде тиесілі тұлға	1	Республика Президент болып тумысынан республика азаматы болып табылатын қырық жасқа толған, мемлекеттiк тiлдi еркiн меңгерген ерi Қазақстанда кемiнде он бес жыл бойы тұратын Республика азаматы сайлана алады 	2023-07-23 07:49:13.103052
3901	азаматтық	сын есім	бірмағыналы	жеке тұлға мен мемлекет арасындағы олардың өзара құқықтары мен міндеттерінің жиынтығын белгілейтін тұрақты саяси-құқықтық байланыс	2	Онда дауыс беру, әділдік әр азаматтық борышы, жауапкершілігі есептеледі. 	2023-07-21 18:34:35.106712
4000	бiл	етістік	бірмағыналы		5		2023-07-23 05:48:09.094876
4003	баға	зат есім	бірмағыналы		1		2023-07-19 11:10:02.068735
4028	басшы	зат есім	көпмағыналы		1		2023-07-22 18:35:43.863395
4051	бәсекелес	сын есім	бірмағыналы		2		2023-07-18 07:29:17.389517
4064	бірлік	зат есім	бірмағыналы	Біреу ғана екендік, жалғыздық	1	Абай Алланың бірлігі мен пайғамбардың хақтығына шүбə келтірмеген (Жұлдыздар отбасы, 2010, 5, 36)	2023-07-23 07:28:12.92151
4107	дамы	етістік	бірмағыналы		5		2023-07-24 06:19:30.243946
4126	дербестік	зат есім	бірмағыналы	жеке, тәуелсіз мағынасында	1	Ел дербестігі үшін ерлер от пен суға түсуге дайын	2023-07-22 23:01:01.263245
4163	жағдай	зат есім	бірмағыналы		1		2023-07-21 07:30:24.334652
4222	жерлес	зат есім	бірмағыналы		1		2023-07-23 11:13:58.320233
4226	жетістік	зат есім	бірмағыналы		1		2023-07-22 01:12:39.88177
4269	зорлық	зат есім	бірмағыналы		1		2023-07-22 21:18:36.246368
4305	кенет	үстеу	бірмағыналы		9		2023-07-21 20:23:55.393309
4367	күшті	сын есім	бірмағыналы		2		2023-07-17 21:35:43.653471
4830	ұтымды	сын есім	бірмағыналы		2		2023-07-21 19:41:21.167543
4490	мәжбүрлеу	етістік			5		2023-07-18 04:45:06.541774
4836	хабарла	етістік	бірмағыналы		5		2023-07-20 03:43:37.381288
4513	мүлтіксіз	сын есім	бірмағыналы		2		2023-07-23 04:48:34.318252
4547	орнатылады	етістік	бірмағыналы	Орнатыл етістігінің қимыл атауы. 	5	Әлішер білгенінше олардың орнатылу тарихын айтып тұр (Б.Қойшыбаев, Ай нұры).	2023-07-23 11:54:56.598576
4564	өмірбаян	зат есім	бірмағыналы	Жеке адамның өмір тарихы	1	партиялық тізімге енген әрбір адам туралы өмірбаяндық деректерді тіркейді	2023-07-17 20:41:44.451847
4741	тікелей	сын есім	бірмағыналы	тура мағынасында	2	Бұл сіздерге тікелей қатысты	2023-07-20 06:28:50.195392
4763	туыстық	сын есім	бірмағыналы		2		2023-07-17 23:14:11.741295
4692	сыншыл	сын есім	бірмағыналы	сын айтуға бейімділік	2	Адам жасы ұлғайған сайын сыншыл келеді	2023-07-22 19:04:31.991732
4712	тарау	зат есім	көпмағыналы	бөлім, сала, тармақ мағыналарында қолданылады	1	Кітап үш тараудан - тұрады	2023-07-19 07:23:33.4104
4736	тиісмсіз	сын есім	бірмағыналы		2		2023-07-23 06:36:57.031289
4756	төте	сын есім			2		2023-07-22 13:02:41.367314
4761	турашыл	сын есім	бірмағыналы		2		2023-07-23 05:30:08.937725
4797	үгітте	етістік	бірмағыналы		5		2023-07-19 02:48:44.725814
4803	үлгілі	сын есім	бірмағыналы		2		2023-07-17 21:48:13.026275
4815	ұйымшыл	сын есім	бірмағыналы		2		2023-07-21 19:30:16.755071
4832	филиал	зат есім	бірмағыналы	бір ұйымның белгілі бір мекендегі өкілдігі	1	елімізде шет ел университеттерінің филиалдары жұмыс істеуде	2023-07-18 17:15:13.217157
4837	хабарлады	етістік	бірмағыналы	бір нәрсе туралы ескерту, алдын ала айту	5	Бұл жағдай туралы курсанттардың ата-аналарына хабаланған	2023-07-19 11:46:54.187383
4827	ұсынды	етістік	омоним	жеке құрамды тағайындау, ауыстыру немесе қолдау көрсету туралы ережесі, сондай-ақ қандай да бір бірлікке жататын (бұйым, операция) өндірілген өнім, мекеме қызметіне қатысты белгілі бір әрекет немесе іс-шараны куәландыратын құжат.	5	1. Бір затты біреуге қолымен әперу.\n\nАлыс кетсем көп қарадың жолыма, Түстер көрдің шырмалып ой торына. Оралғанда ұсынуға сапардан Сақтадың сен не түссе де қолыңа (С.Мәуленов, Алыс кет.).\n\nЖаралған неше түрлі тігіндіден Жасқандым ұсынуға гүлімді мен. Кетіп те қалғың келді менен сенің, Қимай да қайта оралып жүрдің білем (Т.Молдағалиев, Жүректегі.).	2023-07-18 08:03:58.314685
4838	хабарлайды 	етістік	бірмағыналы	бір оқиға жайлы айту	5	БАҚ бүгінде бағаның тұрақсыз болатынын хабарлайды	2023-07-21 20:04:38.529716
4874	ықпалды	сын есім	бірмағыналы	адамның кәсіби және филикалық түрғыда басым дәрежесінің көрсеткіші	2	ҚР Президенті әлемдік деңгейдегі ықпалды саясаткер	2023-07-22 07:00:37.187255
4839	хабарлама	зат есім	көпмағыналы	Ауызша не жазбаша түрде берілген мәлімет	1	сайлауды әзiрлеу мен өткiзуге байланысты мәселелер бойынша мемлекеттiк органдар мен ұйымдардың есебiн, сондай-ақ сайлау туралы заңдардың сақталуы мәселелерi бойынша қоғамдық бiрлестiктер органдарының хабарламасын тыңдауға хақылы	2023-07-18 07:45:58.973714
4840	хабарланған	етістік	бірмағыналы	 Болған жаңалықтарды білу, хабардар болу.	5	Бұлар танысып болғанша, алақандай Қарағанды хабарланып та болды (Ғ. Мұстафин).	2023-07-18 22:44:27.529716
4841	хабарландыру	зат есім	көпмағыналы	Құлақтандыру ретіндегі жарнама	1	Бірақ бұрын кезектен тыс сайлау өткізу туралы хабарландыру және өткізу туралы Жарлыққа қол қою бір күнде болатын	2023-07-18 09:49:59.930577
4842	халық	зат есім	бірмағыналы	Белгілі бір елдің, мемлекеттің негізін қалаған, өздеріне тән тілі, мәдениеті, салт-дәстүрлері бар әлеуметтік топтар жиынтығы; этнос.	1	Ең бірінші бақытым – халқым менің,  Соған берем ойымның алтын кенін.	2023-07-23 15:13:41.385731
4843	халық	зат есім	бірмағыналы	белгілі бір мемлекеттің аумағында тұратын және оның құқықтық өкілеттігіне жататын адамдар жиынтығы	1	Адамзат тарихының басым бөлігінде әлем халқы тым баяу өсті, ол әлеуметтік-экономикалық даму деңгейінің төмендігімен, адамның табиғатқа тәуелділігімен түсіндірілді	2023-07-20 18:40:49.515144
4844	халық қалаулылары	зат есім	бірмағыналы	сайлау нәтижесі бойынша халықтың таңдау түскен тұлғалар	1	Халық қалаулылары жазғы каникулда еліміздің өңірлерін аралауда	2023-07-21 02:48:32.790008
4866	шығарылған	етістік	бірмағыналы	шығармашылықты елестетудің, қиялдаудың нәтижесі.	5	Бұның бәрі ойдан шығарылған болатын,-деп күрсінді Жанар.	2023-07-17 19:46:29.448343
4847	хаттама	зат есім	бірмағыналы	мәжіліс, жиналыс, конференция және т.б. мәселелердің талқылануы мен шешімдердің қабылдануын бедерлейтін және орындалған жұмыс пен қол жеткізген нәтижелердің объективті дәлелдемесі болып табылатын құжат	1	Учаскелiк сайлау комиссиясының төрағасы не оның орнындағы комиссия мүшесi санау нәтижелерiн жария етедi және оларды дауыс беру нәтижелерi туралы хаттамаға енгiзедi	2023-07-21 14:40:12.354601
4848	шағым	зат есім	бірмағыналы	ұйым жұмысында анықталған немесе болуы мүмкін кемшіліктер, соның ішінде өнім/қызмет сапасы бойынша кемшіліктер туралы арыз. адамның өзінің бұзылған құқықтарын, бостандықтарын немесе заңды мүдделерін қалпына келтіру, лауазымды тұлғалардың заңсыз іс-әрекеттерін немесе әрекетсіздігін жою, сондай-ақ субъектілердің заңсыз шешімдерінің күшін жою туралы талабы	1	Үкім жайында жоғары орындарға шағым беруге болады, – деп аяқтады судья	2023-07-20 03:00:29.176495
4849	шағымдан	етістік	бірмағыналы	Tuicmi орындарға, жетекшілерге қандай да бір мәселе жайында арыз айтып, шағым түсірy.	5	Оның туысқандары бас қосып, Ертілеуге ақыл-кеңес бергенімен бетінен қайтпайтынын, жоғары жаққа шағымдануын қоймайтынын айтты (Ж.Сатаев, Құйын).	2023-07-21 09:01:47.606268
4850	шақыру	зат есім	бірмағыналы	Шақыр етістігінің қимыл атауы	1	Шақыру Қазақстан Республикасының Сыртқы істер министрлігі арқылы жіберіледі.	2023-07-22 01:13:31.056034
4851	шамалас	сын есім	бірмағыналы		2		2023-07-19 14:09:02.674797
4852	шара	зат есім	бірмағыналы	Арнайы жасалған іс, міндет	1	Қап, ойлаған шарасы іске аспады.	2023-07-20 16:04:31.968683
4853	шекара	зат есім	бірмағыналы	Аумақтық жағынан бір-біріне шектесіп жатқан жер.	1	Хабаровскіден бір-ақ шығып, шекарашылар ансамблінде әнші болып істеп, 1946 жылдың май айында армиядан босап театрға қайтып келдім (К.Кенжетаев, Дарқан.).	2023-07-23 10:09:58.497783
4854	шекте	етістік	бірмағыналы	сыртқы тежелудің бір түрі. 	5	Өз-өздерінің жандарын түсіне алмай, шектеу дегеннәрсенә атымен білмейтін адамдар да кездеседі.	2023-07-20 21:40:11.019251
4855	шектеулі	сын есім	бірмағыналы	Тежеулі, өлшеулі мағыналарында да қолданылады	2	соттың оны iс-әрекетке қабiлетсiз, iс-әрекетке қабiлетi шектеулi, хабар-ошарсыз кеткен деп тануы немесе оны қайтыс болған деп жариялағаны туралы шешімi заңды күшiне енген	2023-07-20 13:45:57.230244
4856	шектеусіз	сын есім	бірмағыналы	Шексіз, шегі жоқ, шектелмеген.	2		2023-07-19 08:12:56.874065
4881	ырыс	зат есім	бірмағыналы		1		2023-07-21 16:55:10.271756
4857	шеру	зат есім	бірмағыналы	Көп адамның (әскердің) бір жаққа қарай сап түзеп, салтанатты түрде жүруі; аттаныс, сапар	1	сайлау алдындағы пiкiр алысуларды, митингiлердi, шерулердi, демонстрацияларды және заңнамада белгiленген тәртiппен және Конституциялық заңда тыйым салынбаған өзге де сайлау алдындағы іс-шараларды, сондай-ақ кандидаттардың және олардың сенiм бiлдiрген адамдарының сайлаушылармен жеке кездесулерін өткiзу	2023-07-23 17:43:57.748166
4858	шет мемлекет	зат есім	бірмағыналы	сыртқы мемлекеттер	1	Осы Конституциялық заңда көзделген жағдайларда Орталық сайлау комиссиясы шет мемлекет, халықаралық ұйым байқаушысының аккредиттелуін кері қайтарып алуға құқылы.	2023-07-18 15:41:41.691219
4859	шеттет	етістік	бірмағыналы	Жеке тұлғаны заңды тұлғаны басқарудың атқарушы органында қызмет атқару, кәсіпкерлік қызметті жүзеге асыру құқығынан айыру	5	Дисквалификация жеке тұлғаны заңды тұлғаны басқарудың атқарушы органында қызмет атқару, кәсіпкерлік қызметті жүзеге асыру құқығынан айыру болып табылады.	2023-07-20 20:01:13.617876
4860	шешіледі	етістік	бірмағыналы	тапсырманы қандай да бір жолмен шешу	5	Мақала класстерлік талдауға арналған. Қазіргі уақытта маркетингтік зерттеулерде қолданылады. Класстерлік талдау көмегімен өнімдер, клиенттер, қызметкерлер мәселелері шешіледі.	2023-07-20 01:09:21.928478
4861	шешім	зат есім	бірмағыналы	проблемалық жағдаяттың ойлау операцияларының қалыптасуы.	1	 Шешім процесінде шешімді іздеу, қабылдау және іске асыру кезеңдері сараланады. 	2023-07-20 01:57:18.335105
4862	ширақтық	зат есім	бірмағыналы		1		2023-07-21 15:59:09.241259
4863	шолушы	зат есім	бірмағыналы		1		2023-07-18 14:34:45.116513
4864	штаб	зат есім	бірмағыналы	басқарып отыратын орган, орталық	1	Сайлау учаскесіндегі түрлі келеңсіздіктерді, күмәнді адамдарды, заңсыздықтарды бастан аяқ видеоға түсіріп, үнемі әлеуметтік желіге жариялап немесе штабқа хабарлап отыруы керек.	2023-07-19 14:29:41.45549
4865	шығарады	етістік	омоним	өз ойынан жаңа дүние шығарады	5	Мемлекет нарықтың шаруашылық субъектісі ретінде Үкімет арқылы әкімшілік әдістерден медициналық қызметтер нарығын мемлекеттік реттеуді жүзеге асырады: денсаулық сақтау саласында нормативтік-құқықтық актілерді шығарады	2023-07-22 07:52:19.430363
4869	шынайы	сын есім	бірмағыналы	Дәл мәніндегі, нағыз	2	байқаушылар өз ескертулерін құжатталған, шынайы және тексеруге болатын фактілермен негіздеу керек	2023-07-24 04:24:46.523302
4871	ықпал	зат есім	бірмағыналы	Бір адамның екінші адамға, бір нәрсенің екінші нәрсеге әсері.	1	Сондықтан да сайлауды байқау осы құқықтардың орнығуына және оларды қорғауға ықпал етеді.	2023-07-23 09:01:17.316349
4872	ықпал ет	етістік	бірмағыналы	жалпылау, болжау, бағалау 	5	сайлауалды бағдарламалардыі мақсаты халықтың белсенділігіне ықпал ету	2023-07-21 00:14:26.930647
4873	ықпал етеді	етістік	бірмағыналы	іс әрекеттің ықпал етуі	5	ткен. Көші-қонға мемлекеттің ықпал ету әдістері тікелей де, жанама да болуы мүмкін. Әлемдік істәжірибе қатаң, директивалық іс-шаралардың тиімсіздігін көрсетіп отыр, керісінше, жанама, үкімет тарапынан түзетуші ықпал жасаудың артықшылығы көп.	2023-07-21 20:37:21.313576
4875	ықтимал	сын есім	бірмағыналы	«мүмкін, бәлкім», «төзімділік, мықтылық, бекемдік». Екінші мағынасы қазақ фольклорлық жырларында кеңінен қолданылған.	2	 Қаракем айтқан халқына Ы қ т и м а л деп Арқаны Орыс келсе алуға. Сонан соң көштік Шыңғыстан, Жиделі Байсан баруға (А.Байтұрсынов, Жоқтау). 	2023-07-21 16:23:21.48682
4876	ынтымақ	зат есім	бірмағыналы		1		2023-07-22 01:29:32.630923
4877	ынтымақтас	етістік	бірмағыналы		5		2023-07-22 23:53:20.587949
4878	ынтымақтастық	сын есім	бірмағыналы	Ортақ мақсаттарға қол жеткізу үшін бірге жұмыс істейтін адамдардың өзара әрекеттестігі	2	Микродеңгейдегі ынтымақтастық ретінде түрлі топтардың, қоғамдық ұйымдардың белгілі бір мәселелерді ұйымдасып шешіп отыруға ниетін атауға болады	2023-07-23 16:29:05.009766
4879	ыңғайлы	сын есім	бірмағыналы	Жағдайға келетін, қолайлы. 	2	Ыңғайлы болып көрінеді екен алыстан көз тартсаң.	2023-07-22 17:30:11.115483
4880	ырықтандыр	етістік	бірмағыналы	Ырықтандыр етістігінің қимыл атауы. 	5	Бұл әркелкілік жаһандасу процестеріне толықтай қатысатын экономикалық дамыған аз ғана елдердің экспансиясына жаћандасу мен ырықтандыру жағдайларына бейімделе алған бірқатар елдердің қауырт, бірақ тұрақты емес өсімге қол жеткізуінен, жаћандасуға қабілеті келмеген елдердің дағдарысқа түсуінен көрінеді («Егемен Қазақстан»).	2023-07-24 02:43:36.391012
4882	эксперт	зат есім	көпмағыналы	сараптама жүргізетін маман, яғни осы салада Құзыретті емес басқа адамдар қарайтын немесе шешетін мәселе бойынша білікті қорытынды немесе пікір беру үшін шақырылған немесе жалданған адам.	1	Сарапшылар объектілердің жай-күйін бағалау үшін, жауапты шешімдер қабылдау үшін: соттар, кәсіпорындар мен жобалар басқармалары немесе тарихи объектілер мен артефактілерді бағалау, мәлімделген ашылымдар мен өнертабыстарды қайта тексеру және т. б. үшін тартылады.	2023-07-23 03:02:57.640593
4883	электорат	зат есім	бірмағыналы	дауыс беру құқығы бар әлеумет	1	Электорат санының басым бөлігі үлкен қалаларда 	2023-07-22 03:58:49.444879
4884	электронды	сын есім	бірмағыналы	Электрондық сайлау жүйесіне қызмет көрсететін мамандарды дайындауды және оқытуды Қазақстан Республикасының Орталық сайлау комиссиясы тиісті шарт жасаған ұйым жүргізеді	2	Сайлау учаскелері электронды картаға енгізілді	2023-07-19 22:06:42.316357
4885	элиталық	сын есім	бірмағыналы	халықтың таңдамалы бөлігі	2	Саяси элита сайлау науқанынан қатысты пікірлерін айтып жатыр	2023-07-19 16:50:30.347157
3890	абайсыз	үстеу	бірмағыналы		9		2023-07-21 18:13:28.994376
3891	абсентизм	зат есім	бірмағыналы	сайлаудағы немесе референдумдағы сайлаушылардың дауыс беруге ерікті қатыспауын білдіретін конституциялық құқық ғылымындағы термин	1	еліміздегі қазіргі абсентизм деңгейін ескеріп, сайлау нәтижесін мойындау үшін сайлаушылардың пайыз бойынша белгілі бір мөлшері қатысуы керек деген норманы қайта енгізгеніміз жөн.	2023-07-19 05:31:24.479724
3895	ағаттық	зат есім	бірмағыналы		1		2023-07-21 03:14:27.495943
\.


--
-- TOC entry 3773 (class 0 OID 18319)
-- Dependencies: 236
-- Data for Name: synonym_word; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonym_word (word_id, synonym_id) FROM stdin;
3889	8143
3889	8144
3889	8145
3890	8146
3890	8147
3890	8148
3891	8149
3892	8150
3892	8151
3892	8152
3892	8153
3893	8154
3893	8155
3893	8156
3894	8157
3894	8158
3894	8159
3894	8160
3894	8161
3895	8162
3895	8163
3896	8164
3896	8165
3896	8166
3897	8167
3897	8168
3897	8169
3897	8170
3897	8171
3897	8172
3897	8173
3898	8174
3898	8175
3898	8176
3898	8177
3898	8178
3899	8179
3899	8180
3899	8181
3899	8182
3899	8183
3899	8184
3900	8185
3900	8186
3900	8187
3900	8188
3900	8189
3900	8190
3901	8191
3901	8192
3901	8193
3902	8194
3903	8195
3903	8196
3903	8197
3904	8198
3904	8199
3905	8200
3905	8201
3906	8202
3906	8203
3907	8204
3907	8205
3907	8206
3908	8207
3908	8208
3908	8209
3908	8210
3908	8211
3908	8212
3909	8213
3909	8214
3909	8215
3910	8216
3910	8217
3910	8218
3910	8219
3910	8220
3910	8221
3910	8222
3911	8223
3911	8224
3911	8225
3912	8226
3912	8227
3912	8228
3913	8229
3913	8230
3914	8231
3914	8232
3914	8233
3914	8234
3914	8235
3915	8236
3915	8237
3916	8238
3916	8239
3916	8240
3917	8241
3917	8242
3917	8243
3918	8244
3918	8245
3919	8246
3919	8247
3919	8248
3920	8249
3920	8250
3921	8251
3921	8252
3921	8253
3921	8254
3921	8255
3922	8256
3922	8257
3923	8258
3923	8259
3924	8260
3924	8261
3924	8262
3924	8263
3925	8264
3925	8265
3926	8266
3926	8267
3926	8268
3926	8269
3926	8270
3927	8271
3927	8272
3927	8273
3928	8274
3928	8275
3928	8276
3929	8277
3929	8278
3930	8279
3930	8280
3930	8281
3930	8282
3931	8283
3931	8284
3931	8285
3931	8286
3931	8287
3931	8288
3932	8289
3932	8290
3932	8291
3932	8292
3932	8293
3932	8294
3933	8295
3933	8296
3933	8297
3933	8298
3933	8299
3933	8300
3934	8301
3934	8302
3935	8303
3935	8304
3936	8305
3936	8306
3936	8307
3936	8308
3936	8309
3936	8310
3937	8311
3937	8312
3937	8313
3937	8314
3938	8315
3939	8316
3939	8317
3939	8318
3939	8319
3940	8320
3940	8321
3940	8322
3940	8323
3940	8324
3940	8325
3941	8326
3941	8327
3941	8328
3941	8329
3941	8330
3942	8331
3942	8332
3942	8333
3942	8334
3943	8335
3943	8336
3943	8337
3943	8338
3943	8339
3945	8340
3945	8341
3946	8342
3946	8343
3946	8344
3946	8345
3946	8346
3946	8347
3947	8348
3947	8349
3947	8350
3947	8351
3947	8352
3948	8353
3948	8354
3948	8355
3948	8356
3948	8357
3949	8358
3949	8359
3949	8360
3950	8361
3950	8362
3950	8363
3951	8364
3951	8365
3951	8366
3952	8367
3952	8368
3953	8369
3953	8370
3953	8371
3953	8372
3954	8373
3954	8374
3954	8375
3955	8376
3955	8377
3956	8378
3956	8379
3956	8380
3956	8381
3957	8382
3957	8383
3957	8384
3957	8385
3957	8386
3958	8387
3958	8388
3958	8389
3959	8390
3960	8391
3961	8392
3962	8393
3962	8394
3962	8395
3963	8396
3963	8397
3964	8398
3964	8399
3964	8400
3964	8401
3965	8402
3965	8403
3965	8404
3965	8405
3965	8406
3966	8407
3966	8408
3967	8409
3967	8410
3967	8411
3968	8412
3968	8413
3969	8414
3969	8415
3969	8416
3970	8417
3970	8418
3970	8419
3970	8420
3970	8421
3971	8422
3971	8423
3972	8424
3972	8425
3972	8426
3972	8427
3972	8428
3972	8429
3972	8430
3973	8431
3973	8432
3973	8433
3973	8434
3973	8435
3973	8436
3974	8437
3974	8438
3974	8439
3974	8440
3974	8441
3975	8442
3976	8443
3976	8444
3976	8445
3977	8446
3978	8447
3978	8448
3978	8449
3978	8450
3978	8451
3978	8452
3979	8453
3979	8454
3980	8455
3981	8456
3981	8457
3981	8458
3981	8459
3982	8460
3982	8461
3982	8462
3982	8463
3982	8464
3982	8465
3982	8466
3983	8467
3983	8468
3983	8469
3983	8470
3983	8471
3983	8472
3984	8473
3984	8474
3984	8475
3985	8476
3985	8477
3985	8478
3985	8479
3985	8480
3985	8481
3986	8482
3986	8483
3987	8484
3988	8485
3988	8486
3988	8487
3988	8488
3988	8489
3988	8490
3988	8491
3989	8492
3989	8493
3989	8494
3989	8495
3990	8496
3990	8497
3991	8498
3991	8499
3992	8500
3992	8501
3992	8502
3994	8503
3994	8504
3995	8505
3995	8506
3995	8507
3995	8508
3995	8509
3996	8510
3996	8511
3997	8512
3997	8513
3997	8514
3997	8515
3997	8516
3998	8517
3998	8518
3998	8519
3999	8520
3999	8521
3999	8522
3999	8523
3999	8524
4000	8525
4000	8526
4000	8527
4000	8528
4001	8529
4001	8530
4001	8531
4001	8532
4001	8533
4002	8534
4002	8535
4002	8536
4002	8537
4002	8538
4002	8539
4003	8540
4003	8541
4003	8542
4004	8543
4004	8544
4005	8545
4005	8546
4005	8547
4006	8548
4006	8549
4006	8550
4007	8551
4007	8552
4007	8553
4008	8554
4008	8555
4008	8556
4008	8557
4008	8558
4009	8559
4009	8560
4009	8561
4010	8562
4010	8563
4010	8564
4010	8565
4010	8566
4010	8567
4011	8568
4011	8569
4011	8570
4011	8571
4012	8572
4012	8573
4013	8574
4013	8575
4014	8576
4014	8577
4014	8578
4015	8579
4015	8580
4015	8581
4015	8582
4015	8583
4015	8584
4015	8585
4016	8586
4016	8587
4016	8588
4016	8589
4016	8590
4016	8591
4016	8592
4017	8593
4017	8594
4017	8595
4018	8596
4018	8597
4019	8598
4019	8599
4019	8600
4019	8601
4019	8602
4020	8603
4020	8604
4021	8605
4021	8606
4021	8607
4021	8608
4021	8609
4022	8610
4022	8611
4023	8612
4023	8613
4023	8614
4023	8615
4023	8616
4023	8617
4023	8618
4024	8619
4025	8620
4025	8621
4025	8622
4025	8623
4025	8624
4025	8625
4026	8626
4026	8627
4027	8628
4027	8629
4027	8630
4027	8631
4027	8632
4028	8633
4028	8634
4028	8635
4028	8636
4029	8637
4029	8638
4029	8639
4030	8640
4031	8641
4031	8642
4031	8643
4031	8644
4031	8645
4032	8646
4032	8647
4032	8648
4032	8649
4032	8650
4033	8651
4033	8652
4033	8653
4033	8654
4033	8655
4033	8656
4034	8657
4034	8658
4034	8659
4034	8660
4034	8661
4035	8662
4035	8663
4036	8664
4036	8665
4036	8666
4036	8667
4037	8668
4038	8669
4038	8670
4038	8671
4038	8672
4039	8673
4039	8674
4040	8675
4040	8676
4040	8677
4040	8678
4041	8679
4041	8680
4041	8681
4041	8682
4041	8683
4042	8684
4042	8685
4042	8686
4042	8687
4042	8688
4042	8689
4043	8690
4043	8691
4043	8692
4043	8693
4043	8694
4043	8695
4044	8696
4044	8697
4044	8698
4044	8699
4045	8700
4045	8701
4045	8702
4045	8703
4046	8704
4046	8705
4046	8706
4046	8707
4047	8708
4047	8709
4047	8710
4047	8711
4047	8712
4048	8713
4048	8714
4049	8715
4049	8716
4049	8717
4049	8718
4050	8719
4050	8720
4051	8721
4051	8722
4052	8723
4052	8724
4053	8725
4053	8726
4053	8727
4054	8728
4054	8729
4054	8730
4054	8731
4054	8732
4054	8733
4055	8734
4055	8735
4055	8736
4056	8737
4056	8738
4056	8739
4057	8740
4057	8741
4058	8742
4058	8743
4058	8744
4059	8745
4060	8746
4060	8747
4060	8748
4060	8749
4060	8750
4060	8751
4061	8752
4061	8753
4061	8754
4061	8755
4061	8756
4061	8757
4062	8758
4062	8759
4062	8760
4062	8761
4063	8762
4063	8763
4063	8764
4063	8765
4063	8766
4063	8767
4064	8768
4064	8769
4064	8770
4064	8771
4064	8772
4064	8773
4064	8774
4065	8775
4065	8776
4066	8777
4066	8778
4067	8779
4067	8780
4067	8781
4068	8782
4068	8783
4069	8784
4069	8785
4069	8786
4070	8787
4070	8788
4070	8789
4070	8790
4071	8791
4071	8792
4071	8793
4071	8794
4072	8795
4072	8796
4073	8797
4073	8798
4073	8799
4074	8800
4074	8801
4074	8802
4075	8803
4075	8804
4075	8805
4076	8806
4076	8807
4076	8808
4077	8809
4077	8810
4077	8811
4078	8812
4078	8813
4078	8814
4078	8815
4078	8816
4078	8817
4079	8818
4079	8819
4079	8820
4079	8821
4080	8822
4080	8823
4080	8824
4081	8825
4081	8826
4081	8827
4081	8828
4081	8829
4082	8830
4082	8831
4082	8832
4082	8833
4083	8834
4084	8835
4084	8836
4085	8837
4085	8838
4085	8839
4086	8840
4086	8841
4086	8842
4086	8843
4086	8844
4086	8845
4087	8846
4087	8847
4087	8848
4087	8849
4087	8850
4087	8851
4088	8852
4088	8853
4089	8854
4089	8855
4089	8856
4090	8857
4090	8858
4091	8859
4091	8860
4091	8861
4092	8862
4092	8863
4092	8864
4093	8865
4094	8866
4095	8867
4095	8868
4095	8869
4095	8870
4095	8871
4096	8872
4096	8873
4096	8874
4096	8875
4096	8876
4096	8877
4097	8878
4097	8879
4098	8880
4098	8881
4099	8882
4099	8883
4100	8884
4101	8885
4101	8886
4102	8887
4102	8888
4102	8889
4103	8890
4103	8891
4103	8892
4103	8893
4103	8894
4103	8895
4104	8896
4104	8897
4104	8898
4104	8899
4104	8900
4104	8901
4105	8902
4105	8903
4106	8904
4106	8905
4106	8906
4107	8907
4107	8908
4107	8909
4107	8910
4107	8911
4107	8912
4107	8913
4108	8914
4108	8915
4108	8916
4109	8917
4109	8918
4109	8919
4110	8920
4110	8921
4110	8922
4110	8923
4110	8924
4110	8925
4110	8926
4111	8927
4111	8928
4111	8929
4111	8930
4111	8931
4111	8932
4111	8933
4112	8934
4112	8935
4112	8936
4112	8937
4112	8938
4112	8939
4112	8940
4113	8941
4113	8942
4113	8943
4113	8944
4113	8945
4114	8946
4114	8947
4115	8948
4115	8949
4115	8950
4116	8951
4116	8952
4116	8953
4116	8954
4117	8955
4117	8956
4118	8957
4118	8958
4119	8959
4120	8960
4120	8961
4120	8962
4121	8963
4122	8964
4122	8965
4122	8966
4122	8967
4123	8968
4123	8969
4123	8970
4123	8971
4123	8972
4124	8973
4124	8974
4124	8975
4124	8976
4124	8977
4125	8978
4125	8979
4125	8980
4126	8981
4127	8982
4127	8983
4127	8984
4127	8985
4128	8986
4128	8987
4128	8988
4128	8989
4128	8990
4128	8991
4129	8992
4129	8993
4129	8994
4130	8995
4131	8996
4131	8997
4131	8998
4132	8999
4132	9000
4133	9001
4133	9002
4134	9003
4134	9004
4134	9005
4134	9006
4135	9007
4135	9008
4135	9009
4135	9010
4135	9011
4135	9012
4136	9013
4136	9014
4136	9015
4136	9016
4137	9017
4137	9018
4138	9019
4139	9020
4140	9021
4140	9022
4140	9023
4140	9024
4141	9025
4141	9026
4142	9027
4142	9028
4142	9029
4142	9030
4142	9031
4142	9032
4143	9033
4143	9034
4143	9035
4143	9036
4143	9037
4143	9038
4144	9039
4144	9040
4144	9041
4144	9042
4144	9043
4144	9044
4145	9045
4145	9046
4146	9047
4146	9048
4146	9049
4146	9050
4146	9051
4146	9052
4146	9053
4147	9054
4148	9055
4148	9056
4148	9057
4148	9058
4148	9059
4148	9060
4148	9061
4149	9062
4149	9063
4150	9064
4150	9065
4150	9066
4150	9067
4150	9068
4150	9069
4150	9070
4151	9071
4151	9072
4151	9073
4151	9074
4151	9075
4151	9076
4151	9077
4152	9078
4152	9079
4152	9080
4152	9081
4153	9082
4153	9083
4153	9084
4153	9085
4153	9086
4153	9087
4154	9088
4154	9089
4155	9090
4155	9091
4155	9092
4155	9093
4155	9094
4155	9095
4155	9096
4156	9097
4156	9098
4157	9099
4157	9100
4157	9101
4158	9102
4158	9103
4159	9104
4159	9105
4159	9106
4160	9107
4160	9108
4160	9109
4160	9110
4161	9111
4162	9112
4162	9113
4162	9114
4162	9115
4162	9116
4162	9117
4162	9118
4163	9119
4163	9120
4163	9121
4163	9122
4163	9123
4163	9124
4164	9125
4164	9126
4164	9127
4165	9128
4165	9129
4165	9130
4165	9131
4165	9132
4165	9133
4166	9134
4166	9135
4166	9136
4166	9137
4166	9138
4166	9139
4166	9140
4167	9141
4168	9142
4168	9143
4168	9144
4169	9145
4169	9146
4169	9147
4169	9148
4169	9149
4170	9150
4170	9151
4170	9152
4170	9153
4171	9154
4171	9155
4171	9156
4171	9157
4172	9158
4172	9159
4172	9160
4172	9161
4172	9162
4173	9163
4173	9164
4173	9165
4173	9166
4174	9167
4174	9168
4174	9169
4174	9170
4175	9171
4175	9172
4175	9173
4175	9174
4175	9175
4176	9176
4176	9177
4176	9178
4177	9179
4177	9180
4177	9181
4178	9182
4178	9183
4178	9184
4178	9185
4179	9186
4179	9187
4179	9188
4180	9189
4180	9190
4180	9191
4180	9192
4181	9193
4181	9194
4182	9195
4182	9196
4182	9197
4182	9198
4182	9199
4183	9200
4183	9201
4183	9202
4183	9203
4184	9204
4184	9205
4185	9206
4185	9207
4185	9208
4185	9209
4185	9210
4185	9211
4185	9212
4186	9213
4186	9214
4186	9215
4186	9216
4186	9217
4187	9218
4187	9219
4187	9220
4187	9221
4187	9222
4188	9223
4188	9224
4188	9225
4188	9226
4189	9227
4189	9228
4189	9229
4189	9230
4189	9231
4189	9232
4190	9233
4190	9234
4190	9235
4191	9236
4191	9237
4191	9238
4192	9239
4192	9240
4192	9241
4192	9242
4192	9243
4192	9244
4192	9245
4193	9246
4193	9247
4193	9248
4193	9249
4193	9250
4193	9251
4193	9252
4194	9253
4194	9254
4194	9255
4194	9256
4194	9257
4195	9258
4195	9259
4195	9260
4195	9261
4195	9262
4195	9263
4196	9264
4196	9265
4196	9266
4196	9267
4196	9268
4197	9269
4197	9270
4198	9271
4198	9272
4198	9273
4198	9274
4199	9275
4199	9276
4199	9277
4199	9278
4199	9279
4200	9280
4200	9281
4201	9282
4201	9283
4201	9284
4201	9285
4201	9286
4201	9287
4202	9288
4202	9289
4202	9290
4202	9291
4202	9292
4202	9293
4203	9294
4203	9295
4204	9296
4205	9297
4205	9298
4206	9299
4206	9300
4206	9301
4207	9302
4207	9303
4207	9304
4207	9305
4207	9306
4207	9307
4208	9308
4208	9309
4208	9310
4208	9311
4208	9312
4208	9313
4209	9314
4209	9315
4210	9316
4210	9317
4211	9318
4211	9319
4211	9320
4212	9321
4212	9322
4213	9323
4213	9324
4213	9325
4213	9326
4213	9327
4213	9328
4214	9329
4214	9330
4214	9331
4214	9332
4214	9333
4214	9334
4215	9335
4215	9336
4215	9337
4215	9338
4215	9339
4215	9340
4216	9341
4217	9342
4217	9343
4218	9344
4218	9345
4219	9346
4219	9347
4219	9348
4219	9349
4219	9350
4219	9351
4219	9352
4220	9353
4220	9354
4220	9355
4220	9356
4221	9357
4222	9358
4222	9359
4222	9360
4222	9361
4222	9362
4223	9363
4223	9364
4224	9365
4224	9366
4224	9367
4224	9368
4224	9369
4224	9370
4224	9371
4225	9372
4225	9373
4225	9374
4225	9375
4225	9376
4225	9377
4225	9378
4226	9379
4226	9380
4227	9381
4227	9382
4227	9383
4227	9384
4227	9385
4227	9386
4228	9387
4228	9388
4228	9389
4228	9390
4229	9391
4229	9392
4229	9393
4229	9394
4230	9395
4230	9396
4230	9397
4230	9398
4231	9399
4231	9400
4231	9401
4232	9402
4232	9403
4232	9404
4232	9405
4232	9406
4233	9407
4233	9408
4233	9409
4233	9410
4233	9411
4234	9412
4234	9413
4234	9414
4234	9415
4234	9416
4234	9417
4235	9418
4235	9419
4235	9420
4235	9421
4235	9422
4235	9423
4236	9424
4236	9425
4236	9426
4236	9427
4237	9428
4237	9429
4237	9430
4237	9431
4238	9432
4238	9433
4238	9434
4239	9435
4239	9436
4239	9437
4240	9438
4240	9439
4240	9440
4241	9441
4242	9442
4242	9443
4242	9444
4242	9445
4242	9446
4242	9447
4242	9448
4243	9449
4243	9450
4244	9451
4245	9452
4245	9453
4246	9454
4246	9455
4246	9456
4246	9457
4246	9458
4247	9459
4247	9460
4247	9461
4247	9462
4247	9463
4248	9464
4248	9465
4248	9466
4249	9467
4249	9468
4249	9469
4249	9470
4249	9471
4249	9472
4250	9473
4250	9474
4250	9475
4250	9476
4250	9477
4250	9478
4251	9479
4251	9480
4251	9481
4252	9482
4252	9483
4253	9484
4253	9485
4253	9486
4253	9487
4254	9488
4254	9489
4254	9490
4254	9491
4255	9492
4255	9493
4255	9494
4255	9495
4256	9496
4256	9497
4256	9498
4256	9499
4256	9500
4257	9501
4257	9502
4257	9503
4258	9504
4258	9505
4258	9506
4258	9507
4258	9508
4259	9509
4259	9510
4260	9511
4260	9512
4260	9513
4260	9514
4260	9515
4261	9516
4261	9517
4261	9518
4261	9519
4261	9520
4261	9521
4262	9522
4263	9523
4263	9524
4263	9525
4263	9526
4263	9527
4264	9528
4264	9529
4264	9530
4264	9531
4264	9532
4264	9533
4265	9534
4265	9535
4265	9536
4265	9537
4265	9538
4266	9539
4266	9540
4267	9541
4267	9542
4267	9543
4268	9544
4268	9545
4268	9546
4268	9547
4269	9548
4269	9549
4269	9550
4269	9551
4269	9552
4269	9553
4270	9554
4270	9555
4271	9556
4271	9557
4272	9558
4272	9559
4272	9560
4272	9561
4272	9562
4273	9563
4274	9564
4274	9565
4274	9566
4275	9567
4275	9568
4275	9569
4275	9570
4276	9571
4276	9572
4277	9573
4277	9574
4277	9575
4277	9576
4277	9577
4278	9578
4278	9579
4279	9580
4279	9581
4279	9582
4279	9583
4280	9584
4280	9585
4280	9586
4280	9587
4281	9588
4281	9589
4282	9590
4282	9591
4282	9592
4282	9593
4282	9594
4283	9595
4283	9596
4283	9597
4284	9598
4284	9599
4285	9600
4285	9601
4286	9602
4286	9603
4287	9604
4287	9605
4287	9606
4287	9607
4287	9608
4287	9609
4288	9610
4288	9611
4288	9612
4288	9613
4288	9614
4288	9615
4289	9616
4289	9617
4289	9618
4289	9619
4289	9620
4289	9621
4290	9622
4290	9623
4291	9624
4291	9625
4291	9626
4291	9627
4291	9628
4291	9629
4292	9630
4292	9631
4292	9632
4292	9633
4292	9634
4293	9635
4293	9636
4293	9637
4293	9638
4293	9639
4293	9640
4293	9641
4294	9642
4294	9643
4294	9644
4294	9645
4294	9646
4294	9647
4295	9648
4295	9649
4296	9650
4297	9651
4297	9652
4297	9653
4298	9654
4298	9655
4298	9656
4298	9657
4298	9658
4298	9659
4299	9660
4299	9661
4299	9662
4299	9663
4299	9664
4300	9665
4300	9666
4301	9667
4301	9668
4301	9669
4301	9670
4301	9671
4301	9672
4302	9673
4302	9674
4302	9675
4303	9676
4303	9677
4304	9678
4304	9679
4304	9680
4304	9681
4305	9682
4305	9683
4305	9684
4305	9685
4305	9686
4305	9687
4306	9688
4306	9689
4306	9690
4307	9691
4307	9692
4307	9693
4308	9694
4308	9695
4308	9696
4308	9697
4308	9698
4308	9699
4308	9700
4309	9701
4309	9702
4309	9703
4310	9704
4310	9705
4311	9706
4311	9707
4311	9708
4311	9709
4312	9710
4312	9711
4312	9712
4312	9713
4313	9714
4313	9715
4315	9716
4315	9717
4315	9718
4315	9719
4316	9720
4316	9721
4317	9722
4317	9723
4318	9724
4318	9725
4319	9726
4319	9727
4319	9728
4319	9729
4319	9730
4320	9731
4320	9732
4320	9733
4320	9734
4321	9735
4322	9736
4322	9737
4322	9738
4322	9739
4323	9740
4323	9741
4323	9742
4324	9743
4324	9744
4324	9745
4325	9746
4325	9747
4325	9748
4325	9749
4325	9750
4325	9751
4326	9752
4327	9753
4327	9754
4327	9755
4327	9756
4327	9757
4327	9758
4328	9759
4328	9760
4329	9761
4329	9762
4330	9763
4330	9764
4330	9765
4330	9766
4331	9767
4331	9768
4333	9769
4333	9770
4333	9771
4333	9772
4334	9773
4334	9774
4334	9775
4334	9776
4336	9777
4336	9778
4337	9779
4337	9780
4338	9781
4338	9782
4338	9783
4338	9784
4339	9785
4340	9786
4340	9787
4340	9788
4341	9789
4341	9790
4341	9791
4341	9792
4341	9793
4341	9794
4341	9795
4342	9796
4342	9797
4342	9798
4342	9799
4342	9800
4343	9801
4343	9802
4344	9803
4344	9804
4345	9805
4345	9806
4345	9807
4345	9808
4346	9809
4346	9810
4346	9811
4346	9812
4347	9813
4347	9814
4347	9815
4348	9816
4348	9817
4348	9818
4349	9819
4350	9820
4350	9821
4350	9822
4350	9823
4350	9824
4350	9825
4351	9826
4352	9827
4352	9828
4352	9829
4353	9830
4354	9831
4354	9832
4354	9833
4354	9834
4354	9835
4355	9836
4355	9837
4355	9838
4355	9839
4355	9840
4355	9841
4356	9842
4356	9843
4356	9844
4356	9845
4356	9846
4357	9847
4358	9848
4359	9849
4359	9850
4360	9851
4360	9852
4361	9853
4361	9854
4362	9855
4362	9856
4362	9857
4362	9858
4363	9859
4363	9860
4363	9861
4363	9862
4363	9863
4364	9864
4364	9865
4364	9866
4364	9867
4364	9868
4365	9869
4365	9870
4365	9871
4365	9872
4365	9873
4366	9874
4366	9875
4366	9876
4366	9877
4366	9878
4367	9879
4367	9880
4367	9881
4367	9882
4367	9883
4368	9884
4368	9885
4368	9886
4368	9887
4368	9888
4369	9889
4369	9890
4370	9891
4370	9892
4371	9893
4371	9894
4372	9895
4372	9896
4373	9897
4373	9898
4373	9899
4373	9900
4373	9901
4374	9902
4374	9903
4375	9904
4375	9905
4375	9906
4375	9907
4376	9908
4376	9909
4377	9910
4377	9911
4377	9912
4378	9913
4378	9914
4378	9915
4379	9916
4379	9917
4379	9918
4379	9919
4379	9920
4379	9921
4380	9922
4381	9923
4381	9924
4381	9925
4382	9926
4382	9927
4382	9928
4382	9929
4382	9930
4382	9931
4382	9932
4383	9933
4383	9934
4384	9935
4384	9936
4385	9937
4386	9938
4386	9939
4386	9940
4386	9941
4387	9942
4387	9943
4387	9944
4388	9945
4388	9946
4389	9947
4389	9948
4390	9949
4390	9950
4391	9951
4391	9952
4391	9953
4391	9954
4392	9955
4392	9956
4392	9957
4392	9958
4393	9959
4393	9960
4393	9961
4394	9962
4395	9963
4395	9964
4395	9965
4395	9966
4395	9967
4396	9968
4397	9969
4397	9970
4397	9971
4398	9972
4398	9973
4398	9974
4399	9975
4399	9976
4399	9977
4399	9978
4400	9979
4400	9980
4401	9981
4401	9982
4401	9983
4401	9984
4401	9985
4402	9986
4402	9987
4402	9988
4403	9989
4404	9990
4404	9991
4404	9992
4404	9993
4405	9994
4406	9995
4406	9996
4407	9997
4407	9998
4407	9999
4408	10000
4408	10001
4408	10002
4408	10003
4408	10004
4409	10005
4409	10006
4409	10007
4409	10008
4409	10009
4409	10010
4410	10011
4410	10012
4410	10013
4410	10014
4411	10015
4411	10016
4411	10017
4412	10018
4412	10019
4413	10020
4413	10021
4414	10022
4414	10023
4415	10024
4415	10025
4416	10026
4416	10027
4416	10028
4417	10029
4417	10030
4417	10031
4417	10032
4417	10033
4417	10034
4417	10035
4418	10036
4418	10037
4418	10038
4418	10039
4418	10040
4419	10041
4419	10042
4419	10043
4419	10044
4419	10045
4419	10046
4419	10047
4420	10048
4421	10049
4421	10050
4421	10051
4422	10052
4422	10053
4422	10054
4423	10055
4424	10056
4424	10057
4424	10058
4424	10059
4425	10060
4425	10061
4426	10062
4427	10063
4427	10064
4427	10065
4427	10066
4427	10067
4427	10068
4428	10069
4428	10070
4428	10071
4428	10072
4428	10073
4428	10074
4429	10075
4429	10076
4429	10077
4429	10078
4429	10079
4429	10080
4430	10081
4430	10082
4431	10083
4432	10084
4433	10085
4433	10086
4433	10087
4433	10088
4433	10089
4434	10090
4434	10091
4434	10092
4434	10093
4435	10094
4435	10095
4436	10096
4436	10097
4436	10098
4436	10099
4436	10100
4436	10101
4437	10102
4437	10103
4437	10104
4437	10105
4437	10106
4437	10107
4438	10108
4438	10109
4438	10110
4438	10111
4438	10112
4439	10113
4439	10114
4440	10115
4440	10116
4440	10117
4441	10118
4441	10119
4442	10120
4442	10121
4443	10122
4443	10123
4443	10124
4443	10125
4443	10126
4443	10127
4443	10128
4444	10129
4444	10130
4444	10131
4444	10132
4444	10133
4444	10134
4444	10135
4445	10136
4445	10137
4446	10138
4446	10139
4446	10140
4446	10141
4446	10142
4446	10143
4447	10144
4447	10145
4447	10146
4448	10147
4448	10148
4448	10149
4449	10150
4450	10151
4450	10152
4450	10153
4451	10154
4451	10155
4452	10156
4452	10157
4452	10158
4453	10159
4453	10160
4453	10161
4453	10162
4454	10163
4455	10164
4456	10165
4456	10166
4456	10167
4456	10168
4456	10169
4456	10170
4456	10171
4457	10172
4458	10173
4458	10174
4458	10175
4458	10176
4459	10177
4459	10178
4460	10179
4460	10180
4460	10181
4460	10182
4460	10183
4461	10184
4461	10185
4462	10186
4462	10187
4463	10188
4464	10189
4465	10190
4465	10191
4465	10192
4466	10193
4466	10194
4466	10195
4467	10196
4467	10197
4467	10198
4467	10199
4467	10200
4467	10201
4468	10202
4468	10203
4469	10204
4469	10205
4469	10206
4469	10207
4470	10208
4470	10209
4470	10210
4470	10211
4470	10212
4470	10213
4471	10214
4471	10215
4471	10216
4471	10217
4471	10218
4472	10219
4472	10220
4472	10221
4472	10222
4472	10223
4472	10224
4472	10225
4473	10226
4473	10227
4474	10228
4474	10229
4474	10230
4475	10231
4475	10232
4475	10233
4475	10234
4475	10235
4476	10236
4476	10237
4476	10238
4476	10239
4477	10240
4477	10241
4477	10242
4477	10243
4477	10244
4477	10245
4478	10246
4479	10247
4479	10248
4479	10249
4479	10250
4479	10251
4479	10252
4480	10253
4480	10254
4480	10255
4480	10256
4481	10257
4481	10258
4481	10259
4481	10260
4481	10261
4481	10262
4482	10263
4483	10264
4483	10265
4484	10266
4485	10267
4485	10268
4485	10269
4485	10270
4486	10271
4486	10272
4486	10273
4486	10274
4487	10275
4487	10276
4487	10277
4488	10278
4488	10279
4488	10280
4489	10281
4489	10282
4489	10283
4489	10284
4489	10285
4490	10286
4490	10287
4490	10288
4490	10289
4491	10290
4491	10291
4492	10292
4492	10293
4492	10294
4492	10295
4492	10296
4492	10297
4493	10298
4493	10299
4493	10300
4493	10301
4494	10302
4494	10303
4494	10304
4494	10305
4494	10306
4495	10307
4495	10308
4495	10309
4495	10310
4495	10311
4495	10312
4496	10313
4496	10314
4496	10315
4496	10316
4496	10317
4497	10318
4497	10319
4497	10320
4497	10321
4497	10322
4498	10323
4498	10324
4498	10325
4498	10326
4498	10327
4498	10328
4498	10329
4500	10330
4500	10331
4500	10332
4500	10333
4500	10334
4500	10335
4501	10336
4502	10337
4502	10338
4502	10339
4503	10340
4503	10341
4504	10342
4504	10343
4505	10344
4506	10345
4506	10346
4506	10347
4506	10348
4506	10349
4506	10350
4506	10351
4507	10352
4507	10353
4507	10354
4507	10355
4507	10356
4508	10357
4508	10358
4508	10359
4508	10360
4509	10361
4509	10362
4509	10363
4510	10364
4510	10365
4510	10366
4510	10367
4510	10368
4510	10369
4511	10370
4511	10371
4511	10372
4511	10373
4511	10374
4511	10375
4511	10376
4512	10377
4512	10378
4512	10379
4512	10380
4512	10381
4513	10382
4513	10383
4513	10384
4514	10385
4514	10386
4514	10387
4514	10388
4515	10389
4515	10390
4516	10391
4516	10392
4516	10393
4516	10394
4517	10395
4517	10396
4517	10397
4518	10398
4518	10399
4518	10400
4518	10401
4518	10402
4518	10403
4519	10404
4519	10405
4519	10406
4519	10407
4519	10408
4519	10409
4519	10410
4520	10411
4520	10412
4520	10413
4520	10414
4520	10415
4520	10416
4521	10417
4521	10418
4522	10419
4522	10420
4522	10421
4523	10422
4523	10423
4524	10424
4524	10425
4524	10426
4524	10427
4524	10428
4524	10429
4524	10430
4525	10431
4525	10432
4525	10433
4526	10434
4526	10435
4526	10436
4526	10437
4527	10438
4527	10439
4527	10440
4527	10441
4527	10442
4527	10443
4528	10444
4528	10445
4528	10446
4529	10447
4529	10448
4529	10449
4529	10450
4529	10451
4529	10452
4530	10453
4530	10454
4531	10455
4531	10456
4531	10457
4531	10458
4532	10459
4532	10460
4532	10461
4532	10462
4533	10463
4533	10464
4534	10465
4534	10466
4534	10467
4534	10468
4534	10469
4535	10470
4535	10471
4535	10472
4535	10473
4535	10474
4536	10475
4536	10476
4536	10477
4536	10478
4537	10479
4537	10480
4537	10481
4537	10482
4538	10483
4538	10484
4538	10485
4538	10486
4539	10487
4539	10488
4539	10489
4539	10490
4539	10491
4540	10492
4540	10493
4540	10494
4541	10495
4541	10496
4542	10497
4542	10498
4542	10499
4542	10500
4542	10501
4543	10502
4543	10503
4544	10504
4544	10505
4544	10506
4544	10507
4545	10508
4545	10509
4545	10510
4546	10511
4546	10512
4546	10513
4546	10514
4546	10515
4546	10516
4547	10517
4547	10518
4548	10519
4548	10520
4548	10521
4548	10522
4548	10523
4549	10524
4549	10525
4549	10526
4549	10527
4550	10528
4550	10529
4551	10530
4551	10531
4551	10532
4553	10533
4553	10534
4553	10535
4553	10536
4553	10537
4553	10538
4553	10539
4554	10540
4554	10541
4554	10542
4554	10543
4554	10544
4555	10545
4555	10546
4555	10547
4555	10548
4555	10549
4555	10550
4556	10551
4556	10552
4556	10553
4556	10554
4556	10555
4557	10556
4557	10557
4557	10558
4558	10559
4558	10560
4558	10561
4559	10562
4559	10563
4559	10564
4559	10565
4560	10566
4560	10567
4560	10568
4560	10569
4560	10570
4560	10571
4560	10572
4561	10573
4561	10574
4561	10575
4561	10576
4561	10577
4562	10578
4562	10579
4562	10580
4563	10581
4563	10582
4563	10583
4563	10584
4563	10585
4564	10586
4564	10587
4565	10588
4565	10589
4566	10590
4566	10591
4566	10592
4566	10593
4567	10594
4567	10595
4567	10596
4567	10597
4567	10598
4567	10599
4568	10600
4568	10601
4568	10602
4569	10603
4569	10604
4570	10605
4570	10606
4571	10607
4571	10608
4571	10609
4571	10610
4571	10611
4571	10612
4572	10613
4572	10614
4572	10615
4572	10616
4572	10617
4573	10618
4573	10619
4574	10620
4574	10621
4574	10622
4574	10623
4575	10624
4575	10625
4576	10626
4576	10627
4576	10628
4577	10629
4577	10630
4577	10631
4578	10632
4578	10633
4579	10634
4579	10635
4579	10636
4579	10637
4579	10638
4580	10639
4580	10640
4580	10641
4580	10642
4580	10643
4580	10644
4581	10645
4581	10646
4582	10647
4582	10648
4582	10649
4582	10650
4583	10651
4583	10652
4583	10653
4583	10654
4583	10655
4583	10656
4584	10657
4584	10658
4585	10659
4585	10660
4586	10661
4587	10662
4587	10663
4587	10664
4587	10665
4587	10666
4587	10667
4587	10668
4588	10669
4588	10670
4588	10671
4588	10672
4588	10673
4588	10674
4589	10675
4589	10676
4590	10677
4590	10678
4590	10679
4591	10680
4591	10681
4591	10682
4591	10683
4591	10684
4592	10685
4592	10686
4593	10687
4593	10688
4593	10689
4593	10690
4594	10691
4595	10692
4595	10693
4596	10694
4596	10695
4596	10696
4596	10697
4596	10698
4596	10699
4597	10700
4597	10701
4597	10702
4597	10703
4597	10704
4598	10705
4599	10706
4600	10707
4600	10708
4600	10709
4600	10710
4601	10711
4601	10712
4601	10713
4601	10714
4601	10715
4601	10716
4602	10717
4602	10718
4602	10719
4602	10720
4602	10721
4602	10722
4603	10723
4604	10724
4604	10725
4605	10726
4605	10727
4605	10728
4605	10729
4605	10730
4605	10731
4605	10732
4606	10733
4607	10734
4607	10735
4607	10736
4607	10737
4607	10738
4608	10739
4608	10740
4608	10741
4608	10742
4608	10743
4608	10744
4609	10745
4609	10746
4610	10747
4610	10748
4611	10749
4611	10750
4611	10751
4612	10752
4612	10753
4612	10754
4612	10755
4612	10756
4613	10757
4613	10758
4613	10759
4614	10760
4614	10761
4614	10762
4615	10763
4615	10764
4615	10765
4616	10766
4616	10767
4616	10768
4617	10769
4617	10770
4617	10771
4617	10772
4617	10773
4618	10774
4618	10775
4619	10776
4620	10777
4620	10778
4621	10779
4621	10780
4621	10781
4621	10782
4621	10783
4621	10784
4622	10785
4622	10786
4622	10787
4623	10788
4623	10789
4623	10790
4623	10791
4623	10792
4624	10793
4624	10794
4624	10795
4624	10796
4624	10797
4624	10798
4625	10799
4626	10800
4627	10801
4627	10802
4627	10803
4627	10804
4627	10805
4627	10806
4627	10807
4628	10808
4628	10809
4628	10810
4629	10811
4629	10812
4630	10813
4631	10814
4632	10815
4632	10816
4633	10817
4633	10818
4633	10819
4633	10820
4634	10821
4634	10822
4635	10823
4635	10824
4635	10825
4635	10826
4635	10827
4636	10828
4636	10829
4636	10830
4636	10831
4636	10832
4636	10833
4637	10834
4637	10835
4638	10836
4639	10837
4640	10838
4640	10839
4640	10840
4640	10841
4640	10842
4641	10843
4642	10844
4643	10845
4643	10846
4644	10847
4645	10848
4646	10849
4646	10850
4647	10851
4647	10852
4647	10853
4647	10854
4648	10855
4648	10856
4648	10857
4649	10858
4649	10859
4649	10860
4649	10861
4649	10862
4649	10863
4649	10864
4650	10865
4650	10866
4650	10867
4650	10868
4650	10869
4650	10870
4651	10871
4651	10872
4652	10873
4652	10874
4652	10875
4653	10876
4655	10877
4656	10878
4656	10879
4656	10880
4656	10881
4656	10882
4656	10883
4657	10884
4657	10885
4658	10886
4658	10887
4659	10888
4660	10889
4660	10890
4660	10891
4661	10892
4661	10893
4662	10894
4662	10895
4662	10896
4662	10897
4663	10898
4663	10899
4663	10900
4663	10901
4664	10902
4664	10903
4664	10904
4664	10905
4665	10906
4665	10907
4666	10908
4666	10909
4666	10910
4667	10911
4667	10912
4667	10913
4667	10914
4667	10915
4668	10916
4668	10917
4669	10918
4669	10919
4669	10920
4670	10921
4670	10922
4670	10923
4670	10924
4670	10925
4670	10926
4670	10927
4671	10928
4672	10929
4672	10930
4672	10931
4673	10932
4674	10933
4674	10934
4674	10935
4674	10936
4674	10937
4675	10938
4676	10939
4676	10940
4676	10941
4676	10942
4676	10943
4676	10944
4677	10945
4677	10946
4677	10947
4677	10948
4677	10949
4678	10950
4678	10951
4678	10952
4678	10953
4678	10954
4678	10955
4679	10956
4680	10957
4680	10958
4680	10959
4680	10960
4680	10961
4680	10962
4681	10963
4681	10964
4681	10965
4681	10966
4681	10967
4682	10968
4682	10969
4683	10970
4683	10971
4683	10972
4684	10973
4684	10974
4685	10975
4685	10976
4685	10977
4685	10978
4686	10979
4686	10980
4686	10981
4687	10982
4688	10983
4688	10984
4688	10985
4689	10986
4689	10987
4689	10988
4690	10989
4690	10990
4691	10991
4691	10992
4691	10993
4692	10994
4692	10995
4693	10996
4694	10997
4694	10998
4695	10999
4695	11000
4695	11001
4695	11002
4696	11003
4696	11004
4697	11005
4698	11006
4698	11007
4698	11008
4698	11009
4698	11010
4698	11011
4699	11012
4699	11013
4699	11014
4700	11015
4700	11016
4701	11017
4701	11018
4702	11019
4702	11020
4702	11021
4702	11022
4702	11023
4703	11024
4703	11025
4703	11026
4704	11027
4704	11028
4704	11029
4704	11030
4705	11031
4705	11032
4705	11033
4706	11034
4706	11035
4707	11036
4707	11037
4708	11038
4708	11039
4709	11040
4710	11041
4711	11042
4711	11043
4711	11044
4711	11045
4712	11046
4712	11047
4712	11048
4713	11049
4713	11050
4713	11051
4713	11052
4714	11053
4714	11054
4714	11055
4715	11056
4715	11057
4715	11058
4715	11059
4715	11060
4715	11061
4715	11062
4716	11063
4716	11064
4716	11065
4716	11066
4717	11067
4717	11068
4718	11069
4718	11070
4718	11071
4719	11072
4719	11073
4719	11074
4719	11075
4719	11076
4720	11077
4720	11078
4720	11079
4721	11080
4721	11081
4721	11082
4721	11083
4721	11084
4722	11085
4722	11086
4723	11087
4723	11088
4724	11089
4724	11090
4724	11091
4724	11092
4724	11093
4725	11094
4725	11095
4726	11096
4726	11097
4726	11098
4727	11099
4727	11100
4727	11101
4728	11102
4728	11103
4728	11104
4728	11105
4728	11106
4729	11107
4729	11108
4729	11109
4730	11110
4730	11111
4730	11112
4730	11113
4730	11114
4731	11115
4731	11116
4731	11117
4731	11118
4731	11119
4732	11120
4732	11121
4733	11122
4733	11123
4733	11124
4733	11125
4733	11126
4733	11127
4734	11128
4734	11129
4734	11130
4734	11131
4734	11132
4734	11133
4735	11134
4735	11135
4735	11136
4735	11137
4735	11138
4736	11139
4736	11140
4737	11141
4737	11142
4737	11143
4738	11144
4738	11145
4738	11146
4739	11147
4739	11148
4739	11149
4740	11150
4740	11151
4740	11152
4740	11153
4740	11154
4740	11155
4741	11156
4741	11157
4741	11158
4742	11159
4742	11160
4742	11161
4743	11162
4743	11163
4743	11164
4743	11165
4743	11166
4743	11167
4743	11168
4744	11169
4745	11170
4745	11171
4745	11172
4745	11173
4745	11174
4745	11175
4746	11176
4746	11177
4746	11178
4746	11179
4746	11180
4746	11181
4747	11182
4747	11183
4747	11184
4747	11185
4747	11186
4747	11187
4748	11188
4748	11189
4749	11190
4749	11191
4749	11192
4749	11193
4749	11194
4750	11195
4750	11196
4750	11197
4750	11198
4751	11199
4751	11200
4751	11201
4751	11202
4751	11203
4752	11204
4752	11205
4752	11206
4752	11207
4753	11208
4753	11209
4753	11210
4753	11211
4753	11212
4753	11213
4754	11214
4754	11215
4754	11216
4754	11217
4755	11218
4755	11219
4755	11220
4755	11221
4756	11222
4757	11223
4758	11224
4758	11225
4758	11226
4758	11227
4758	11228
4759	11229
4759	11230
4759	11231
4759	11232
4760	11233
4760	11234
4760	11235
4760	11236
4761	11237
4761	11238
4761	11239
4761	11240
4762	11241
4762	11242
4762	11243
4762	11244
4762	11245
4762	11246
4763	11247
4763	11248
4764	11249
4764	11250
4765	11251
4765	11252
4765	11253
4765	11254
4766	11255
4766	11256
4767	11257
4767	11258
4767	11259
4767	11260
4767	11261
4768	11262
4768	11263
4769	11264
4769	11265
4770	11266
4770	11267
4770	11268
4771	11269
4771	11270
4771	11271
4771	11272
4771	11273
4771	11274
4772	11275
4772	11276
4772	11277
4772	11278
4772	11279
4772	11280
4773	11281
4773	11282
4773	11283
4773	11284
4773	11285
4774	11286
4774	11287
4774	11288
4774	11289
4774	11290
4774	11291
4775	11292
4775	11293
4775	11294
4775	11295
4776	11296
4776	11297
4776	11298
4776	11299
4776	11300
4776	11301
4776	11302
4777	11303
4778	11304
4778	11305
4778	11306
4778	11307
4779	11308
4779	11309
4779	11310
4780	11311
4780	11312
4780	11313
4781	11314
4781	11315
4781	11316
4781	11317
4781	11318
4781	11319
4782	11320
4782	11321
4783	11322
4783	11323
4783	11324
4784	11325
4785	11326
4786	11327
4786	11328
4786	11329
4787	11330
4787	11331
4787	11332
4787	11333
4788	11334
4788	11335
4788	11336
4788	11337
4788	11338
4788	11339
4789	11340
4789	11341
4789	11342
4790	11343
4790	11344
4791	11345
4791	11346
4791	11347
4791	11348
4791	11349
4791	11350
4791	11351
4792	11352
4792	11353
4792	11354
4793	11355
4793	11356
4793	11357
4793	11358
4794	11359
4794	11360
4794	11361
4794	11362
4794	11363
4795	11364
4795	11365
4795	11366
4795	11367
4796	11368
4796	11369
4796	11370
4796	11371
4797	11372
4797	11373
4798	11374
4798	11375
4798	11376
4798	11377
4798	11378
4798	11379
4799	11380
4799	11381
4799	11382
4799	11383
4800	11384
4800	11385
4800	11386
4800	11387
4800	11388
4801	11389
4801	11390
4801	11391
4801	11392
4801	11393
4801	11394
4802	11395
4802	11396
4802	11397
4802	11398
4802	11399
4802	11400
4803	11401
4803	11402
4803	11403
4803	11404
4803	11405
4804	11406
4804	11407
4804	11408
4805	11409
4805	11410
4805	11411
4805	11412
4806	11413
4806	11414
4806	11415
4806	11416
4807	11417
4807	11418
4808	11419
4808	11420
4808	11421
4809	11422
4809	11423
4810	11424
4810	11425
4811	11426
4811	11427
4812	11428
4812	11429
4812	11430
4813	11431
4813	11432
4814	11433
4814	11434
4814	11435
4814	11436
4814	11437
4815	11438
4815	11439
4816	11440
4816	11441
4817	11442
4817	11443
4817	11444
4817	11445
4817	11446
4818	11447
4818	11448
4818	11449
4819	11450
4820	11451
4820	11452
4820	11453
4821	11454
4821	11455
4822	11456
4822	11457
4823	11458
4823	11459
4823	11460
4824	11461
4824	11462
4824	11463
4824	11464
4824	11465
4825	11466
4825	11467
4825	11468
4825	11469
4825	11470
4825	11471
4826	11472
4826	11473
4826	11474
4826	11475
4827	11476
4827	11477
4828	11478
4829	11479
4829	11480
4830	11481
4830	11482
4830	11483
4831	11484
4831	11485
4831	11486
4831	11487
4832	11488
4832	11489
4833	11490
4834	11491
4834	11492
4834	11493
4834	11494
4835	11495
4835	11496
4835	11497
4835	11498
4835	11499
4835	11500
4836	11501
4836	11502
4836	11503
4836	11504
4836	11505
4837	11506
4837	11507
4837	11508
4837	11509
4837	11510
4837	11511
4838	11512
4838	11513
4838	11514
4838	11515
4838	11516
4838	11517
4839	11518
4839	11519
4839	11520
4839	11521
4839	11522
4839	11523
4840	11524
4840	11525
4841	11526
4841	11527
4841	11528
4841	11529
4841	11530
4842	11531
4842	11532
4842	11533
4842	11534
4842	11535
4843	11536
4843	11537
4843	11538
4843	11539
4843	11540
4843	11541
4844	11542
4844	11543
4845	11544
4846	11545
4847	11546
4847	11547
4848	11548
4848	11549
4849	11550
4849	11551
4849	11552
4849	11553
4849	11554
4850	11555
4850	11556
4851	11557
4851	11558
4852	11559
4852	11560
4852	11561
4852	11562
4852	11563
4852	11564
4852	11565
4853	11566
4853	11567
4853	11568
4853	11569
4853	11570
4853	11571
4853	11572
4854	11573
4854	11574
4854	11575
4855	11576
4855	11577
4855	11578
4855	11579
4856	11580
4856	11581
4857	11582
4858	11583
4859	11584
4859	11585
4859	11586
4859	11587
4860	11588
4860	11589
4860	11590
4861	11591
4861	11592
4861	11593
4861	11594
4861	11595
4861	11596
4862	11597
4862	11598
4862	11599
4862	11600
4863	11601
4863	11602
4863	11603
4864	11604
4865	11605
4865	11606
4865	11607
4866	11608
4866	11609
4867	11610
4867	11611
4867	11612
4868	11613
4868	11614
4868	11615
4868	11616
4869	11617
4869	11618
4869	11619
4869	11620
4869	11621
4869	11622
4870	11623
4870	11624
4870	11625
4870	11626
4871	11627
4872	11628
4872	11629
4873	11630
4873	11631
4873	11632
4873	11633
4874	11634
4874	11635
4875	11636
4875	11637
4875	11638
4875	11639
4875	11640
4875	11641
4876	11642
4876	11643
4876	11644
4876	11645
4876	11646
4877	11647
4877	11648
4878	11649
4878	11650
4878	11651
4878	11652
4878	11653
4879	11654
4879	11655
4879	11656
4879	11657
4880	11658
4880	11659
4881	11660
4881	11661
4881	11662
4882	11663
4882	11664
4882	11665
4882	11666
4882	11667
4883	11668
4883	11669
4884	11670
4884	11671
4884	11672
4885	11673
4885	11674
1	11675
\.


--
-- TOC entry 3770 (class 0 OID 18306)
-- Dependencies: 233
-- Data for Name: synonyms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.synonyms (id, synonym) FROM stdin;
8958	еркін
10367	кемтік
8143	қоңырау орталық
8144	байланыс орталық
8145	байланыс
8146	аңдаусыз
8147	қаперсіз
8148	бейқам
8149	қатыспаушы
8150	ар-ұят
8151	қадір-қасиет
8152	бедел
8153	құрмет
8154	бедел
8155	абиыр
8156	қадір
8157	беделді
8158	өтімді
8159	ықпалды
8160	құрметті
8161	қадірлі
8162	жансақтық
8163	өбестік
8164	әділ
8165	ашық
8166	таза
8167	ашық
8168	кіршіксіз
8169	пәк
8170	бүкпесіз
8171	ақ
8172	таза
8173	шын
8174	азамат
8175	кісі
8176	пенде
8177	жан
8178	тұлға
8179	шамалы
8180	шағын
8181	азғана
8182	кем
8183	санаулы
8184	азырақ
8185	тұлға
8186	кісі
8187	адам
8188	пенде
8189	жігіт
8190	ер
8191	адамдық
8192	тұлғалық
8193	жігіттік
8194	демократиялық қоғам
8195	бостан
8196	ерік
8197	тәуелсіз
8198	дәлелсіз
8199	дерексіз
8200	дәлел
8201	дерек
8202	анық
8203	ашық
8204	анық
8205	зайыр
8206	күмәнсіз
8207	анықта
8208	нақтыла
8209	дәлелде
8210	айғақта
8211	бағдарла
8212	раста
8213	байқалады
8214	анықталады
8215	сезіледі
8216	облыс
8217	өңір
8218	өлке
8219	округ
8220	атырап
8221	орын
8222	учаске
8223	оралым
8224	орам
8225	экспорт
8226	ерекше
8227	айқын
8228	өзгеше
8229	штраф
8230	ақшалай айып
8231	жазалы
8232	жазықты
8233	кәнілі
8234	күнәлі
8235	жазықкер
8236	ауыстыр
8237	алмастыр
8238	өзгешелік
8239	ерекшелік
8240	әртүрлілік
8241	бөлінеді
8242	айырылысады
8243	бөлінеді
8244	сәйкестендір
8245	аттестатта
8246	сәйкестендіру
8247	тағайындау
8248	тіркеу
8249	құжат
8250	хаттама
8251	мәлімет
8252	мағлұмат
8253	дәйек
8254	дерек
8255	хабар
8256	мәліметтік
8257	ескертпелік
8258	қабылда
8259	иемден
8260	орын
8261	аймақ
8262	аудан
8263	кеңістік
8264	елеңде
8265	елегізде
8266	бастапқы
8267	әуелгі
8268	әдепкі
8269	алдыңғы
8270	тұңғыш
8271	колегиалдылық
8272	жиындық
8273	топтық
8274	коллегиалды
8275	жиынды
8276	топты
8277	кезектес
8278	ауыс
8279	кезектесу
8280	ауысу
8281	ұтылау
8282	алмалау
8283	иемдену
8284	қабылдау
8285	байыту
8286	балқыту
8287	өндіру
8288	суретке түсіру
8289	алшақ
8290	аулақ
8291	қашық
8292	ұзақ
8293	шалғай
8294	жырақ
8295	қашық
8296	қиыр
8297	шет
8298	шыған
8299	қиын
8300	шалғай
8301	өсиет
8302	тапсырма
8303	жасырын
8304	бүркеніш
8305	уәде
8306	серт
8307	уағда
8308	әймен
8309	ант-аман
8310	қасам
8311	айқын
8312	нақты
8313	дәл
8314	көмескі емес
8315	нақтылық
8316	айқында
8317	белгіле
8318	тағайында
8319	бекіт
8320	нақтыла
8321	дәлелд
8322	айғақта
8323	бағдарла
8324	раста
8325	раста
8326	айқындалған
8327	нақтыланған
8328	орнатылған
8329	белгіленген
8330	дәлелденген
8331	айқындау
8332	белгілеу
8333	тағайындау
8334	бекіту
8335	түсініктілігі
8336	ұғыныңқылығы
8337	айқындылығы
8338	ашықтығы
8339	дәлелдігі
8340	қайта қарау
8341	тексеру
8342	өшпенділік
8343	дұшпандық
8344	жауыздық
8345	қамкүнемдік
8346	қастандық
8347	қастық
8348	қарым қатынас
8349	қарым-қатынас
8350	өзара байланыс
8351	байланыс
8352	қатынас
8353	құралған
8354	біріккен
8355	үйлес
8356	үйлескен
8357	бәстесу
8358	құрас
8359	бірік
8360	үйлес
8361	аралас сайлау жүйесі
8362	пропорционалды сайлау жүйесі
8363	көпшілік сайлау жүйесі
8364	қатысу
8365	қосылу
8366	біріктіру
8367	арқылы
8368	көмегімен
8369	өзек
8370	негізі
8371	тірегі
8372	көзі
8373	әдейі
8374	әдейілеп
8375	зәуімен
8376	ұсынылған
8377	даярланған
8378	нығайт
8379	күшейт
8380	жақсарт
8381	жоғарылат
8382	ерекшелік
8383	басымдық
8384	басымдылық
8385	артықтық
8386	үстемдік
8387	шағым
8388	мәлімдеме
8389	өтініш
8390	консультативті-кеңесші орган
8391	елорда
8392	есім
8393	жылқы
8394	тұлпар
8395	жирен
8396	өлтір
8397	көзде
8398	конституция
8399	заңдар жинағы
8400	акт
8401	жарғы
8402	айтып өтті
8403	айтты
8404	көрсетті
8405	тоқталды
8406	ескертті
8407	орындау
8408	өткеру
8409	орындаушы
8410	істеуші
8411	жасаушы
8412	жергілікті басқару органдары
8413	үкімет
8414	жәрдемдес
8415	көмектес
8416	қамтамасыз ет
8417	аумақтық
8418	өлкелік
8419	жергілікті
8420	округтік
8421	аймақтық
8422	тілмаш
8423	тәржімеші
8424	көлемді
8425	аумақты
8426	қомақты
8427	өрелі
8428	масштабты
8429	кеңдік
8430	маңызды
8431	алшақ
8432	алыс
8433	жырақ
8434	қашық
8435	қиыр
8436	ұзақ
8437	аймақтық
8438	аудандық
8439	округтік
8440	жергілікті
8441	өлкелік
8442	ауыл
8443	зілдей
8444	салмақты
8445	қиын
8446	науқастан
8447	айырбаста
8448	өзгерт
8449	қайта өңдеу
8450	өзгерту
8451	қайта орнату
8452	орналастыр
8453	аш жалаңаш
8454	ашалаң
8455	көрсет
8456	ыза
8457	ызақор
8458	дол
8459	зығыр
8460	анық
8461	айқын
8462	астарсыз
8463	жұмбақсыз
8464	жайдарлы
8465	жария
8466	жасырмаушы
8467	адал
8468	жанқиярлық
8469	шыншыл
8470	турашыл
8471	әділетшіл
8472	адал
8473	адалдық
8474	турашылдық
8475	шыншылдық
8476	даярла
8477	дайында
8478	қамда
8479	сайла
8480	жабдықта
8481	әбзелде
8482	тасымалда
8483	импортта
8484	жөні
8485	басшы
8486	ауыл басшы
8487	төре
8488	мырза
8489	шонжар
8490	билеуші
8491	директор
8492	билік
8493	қожалық
8494	төрелік
8495	үстемдік
8496	жергілікті атқару органы
8497	басқарушы орган
8498	қоғам
8499	қауым
8500	қоғамдық
8501	қауымдық
8502	қауымдастық
8503	әліппе
8504	алфавит
8505	сұхбаттас
8506	сөйлес
8507	дидарлас
8508	сырлас
8509	талқыла
8510	әртүрлі
8511	әртүрі
8512	қызметтес
8513	істес
8514	кәсіптес
8515	еңбектес
8516	жұмыстас
8517	әртүрлі
8518	сан алуан
8519	әралуан
8520	ықпал
8521	нәтиже\n
8522	әрекет
8523	белгі
8524	ырық
8525	үйрен
8526	түсін
8527	көр
8528	сез
8529	нарық
8530	бәс
8531	кұн
8532	көрсеткіш
8533	қаражат
8534	көрсеткіш
8535	белгі
8536	кұн
8537	нарық
8538	қаражат
8539	бәс
8540	нарық
8541	құн
8542	бөс
8543	құнды
8544	қымбат
8545	программа
8546	сайлауалды бағдарлама
8547	жасақтама
8548	құлақ асыңыз
8549	айтқанын істе
8550	айтқанын жаса
8551	бағыныңқы
8552	бағынышты
8553	тәуелді
8554	бағдар
8555	ағым
8556	бет
8557	жол
8558	беталыс
8559	негіз
8560	ішкі
8561	түпнұсқа
8562	байымда
8563	бағдарланады
8564	аңғар
8565	аңда
8566	абайла
8567	байқаста
8568	бақылаушы
8569	қадағалаушы
8570	қараушы
8571	тексеруші
8572	байыпты
8573	салиқалы
8574	байыптылық
8575	салиқалық
8576	байсалды
8577	сабырлы
8578	салмақты
8579	байқа
8580	қара
8581	қадағала
8582	барла
8583	тексер
8584	ірікте
8585	шол
8586	байқаушы
8587	қараушы
8588	қадағалаушы
8589	барлаушы
8590	тексеруші
8591	іріктеуші
8592	шолушы
8593	эквивалент
8594	альтернатива
8595	ұқсас
8596	альтернативті
8597	ұқсас
8598	бөлім
8599	тарау
8600	күй
8601	күтім
8602	қағида
8603	келу
8604	жылжу
8605	жетекші
8606	басқарушы
8607	президент
8608	басшы
8609	көшбасшы
8610	қабыл алма
8611	қабылдама
8612	басшылық жаса
8613	билік жүргіз
8614	төрелік ет
8615	биле
8616	атқару
8617	төсте
8618	меңгер
8619	жарияланым
8620	басылым
8621	баспа
8622	төртінші билік
8623	репортер
8624	шолушы
8625	журналистика
8626	жаңадан басталды
8627	қосылды
8628	негізгі
8629	маңызды
8630	түбірлі
8631	түбегейлі
8632	күре
8633	жетекші
8634	бастаушы
8635	басқарушы
8636	бастық
8637	басқару
8638	билеу
8639	билік жүргізу
8640	жарияланым
8641	өзжет
8642	өткір
8643	жүректі
8644	қтті
8645	тәуекелшіл
8646	айт
8647	әңгімеле
8648	хабарла
8649	жеткіз
8650	мазмұнда
8651	айтты
8652	жеткізді
8653	айтты
8654	ескертті
8655	хабарлады
8656	білдірді
8657	мазмұндалған
8658	айтылған
8659	хабарлаған
8660	білдірген
8661	суреттелген
8662	абырой
8663	қадір
8664	абыройлы
8665	ықпалды
8666	мерейлі
8667	абиырлы
8668	бейнематериал
8669	суретте
8670	сипатта
8671	кейіпте
8672	кескінде
8673	қалыс
8674	немқұрайлы
8675	қалыс
8676	дауыс бермеген
8677	оқшау
8678	немқұрайлы
8679	мақұлда
8680	бекіт
8681	қабылда
8682	санкция
8683	рәсімде
8684	таңба
8685	нышан
8686	тұспал
8687	ишара
8688	сыза
8689	ен
8690	аян
8691	мағлұм
8692	мәлім
8693	әйгілі
8694	мәшһүр
8695	танымал
8696	активті
8697	жігерлі
8698	бастамашыл
8699	жылдам
8700	ұсын
8701	табыста
8702	жаса
8703	жүргіз
8704	ұсынылады
8705	табысталады
8706	жасалады
8707	жүргізіледі
8708	кедергі жасау
8709	болдырмау
8710	кедергі жасау
8711	бұғаттау
8712	ыңғай бермеу
8713	өзгеріс
8714	жаңа бағыт
8715	бақталастық
8716	бәсекелестік
8717	тартыс
8718	жарыс
8719	тартыс
8720	күрес
8721	бақталас
8722	жарысқыш
8723	баяу
8724	ақырын
8725	әкімдік
8726	мансап
8727	қожалық
8728	үкімет
8729	өкімет
8730	әкімдік
8731	басқарушы орган
8732	басқарушы
8733	билеуші
8734	үйрен
8735	сез
8736	көр
8737	үйренеді
8738	сезеді
8739	көреді
8740	түбегейлі
8741	нақты
8742	жүйелі
8743	ретті
8744	дәйекті
8745	БҰҰ
8746	бірсыпыра
8747	бірталай
8748	едәуір
8749	қыруар
8750	талай
8751	біраз
8752	бірік
8753	серіктес
8754	ұйымдас
8755	ұжымдас
8756	ынтымақтас
8757	интеграциялан
8758	ассоциация
8759	ұйым
8760	одақ
8761	ұжым
8762	бірігу
8763	серіктесу
8764	ұйымдасу
8765	ұжымдасу
8766	ынтымақтасу
8767	интеграциялау
8768	ынтымақ
8769	ұжым
8770	ұйымшыл
8771	бүтіндік
8772	ауызбірлік
8773	тұтастық
8774	татулық
8775	бірыңғай
8776	біріккен
8777	біртұтас
8778	біріккен
8779	сәйкес
8780	лайықты
8781	сай
8782	істеу алмайды
8783	болмайды
8784	өтілетін
8785	жасалатын
8786	істелінетін
8787	болжам
8788	түспал
8789	жорамал
8790	бағдарла
8791	болжал
8792	жорамал
8793	тұспал
8794	нобай
8795	орындалуы мүмкін
8796	жасалынуы мүмкін
8797	қоқан лоққы
8798	домбытпа
8799	домбай
8800	шығар
8801	азат ет
8802	құтқар
8803	шығару
8804	құтқару
8805	азат ету
8806	азаттық
8807	еркіндік
8808	теңдік
8809	азаттық
8810	еркіндік
8811	теңдік
8812	өзге
8813	бөтен
8814	біреу
8815	жат
8816	бейтаныс
8817	сырт адам
8818	айыр
8819	ұсақта
8820	айыр
8821	жікте
8822	бөлік
8823	тарау
8824	бөлшек
8825	бөлім
8826	аймақ
8827	тармақ
8828	жол
8829	орын
8830	айырылған
8831	ұсақталған
8832	айырылған
8833	жіктелген
8834	көрсет
8835	жалпыхалықтық
8836	дүйімжұрттық
8837	бұзылған
8838	былыққан
8839	жарамсыз болған
8840	ауызбірлігі
8841	бірлігі
8842	ұжым
8843	ұйымшылдығы
8844	ынтымақтығы
8845	тұтастығы
8846	бүлдір
8847	күйрет
8848	қаусат
8849	қират
8850	сындыр
8851	ойранда
8852	көпшілік
8853	халық
8854	қара халық
8855	еңбекші халық
8856	жұрт
8857	ақпарат құралдары
8858	медиа
8859	өзгерт
8860	фальсификацияла
8861	бұз
8862	өзгерту
8863	фальсификациялау
8864	бұзу
8865	өзгеріс
8866	Біріккен Ұлттар Ұйымы
8867	ақша қоры
8868	мемлекеттік бюджет
8869	шағын бюджет
8870	смета
8871	бөлінген ақша
8872	дауыс беру парағы
8873	дауыс беру парақшасы
8874	сайлау қағазы
8875	мәлімдеме
8876	қағаз
8877	хабарлама
8878	екпе
8879	вакцинопрофилактика
8880	бюро
8881	мекеме
8882	министр орынбасары
8883	мэр
8884	әйел теңдігі
8885	аралас
8886	біріккен
8887	корпус
8888	үй
8889	жай
8890	әзірле
8891	даярла
8892	дайындал
8893	қамдан
8894	жабдықта
8895	құр
8896	әзірлеу
8897	даярлау
8898	дайындау
8899	қамдану
8900	жабдықтау
8901	құру
8902	әзірлік
8903	даярлық
8904	қамсыз
8905	даярлықсыз
8906	әзірліксіз
8907	өркенде
8908	өнімсіз
8909	өс
8910	өрбі
8911	өрле
8912	қарышта
8913	гүлден
8914	жетілдір
8915	өркендет
8916	өрістет
8917	жетілдіру
8918	өркендету
8919	өрістету
8920	талас
8921	тартыс
8922	тәжіке
8923	ұрыс керіс
8924	тайталас
8925	дау дамай
8926	қақтығыс
8927	талас
8928	тартыс
8929	тәжіке
8930	ұрыс керіс
8931	тайталас
8932	қақтығыс
8933	қақтығыс
8934	таңдау
8935	үн
8936	дыбыс
8937	саңқылдау
8938	дабырласу
8939	дабыр-дүбір
8940	шуылдау
8941	сайлау
8942	үміткер тандау
8943	еркін білдіру
8944	өз шешімін беру
8945	қолдау
8946	пікірталас
8947	пікір алмасу
8948	мәлімдеме
8949	мағлұмдама
8950	хабарлама
8951	делегаттар тобы
8952	сайланған топ
8953	сайланған құрам
8954	сайланған орта
8955	халықтық билік
8956	билік жүргізу
8957	тәуелсіз
8959	көрсету
8960	есен саулық
8961	жай күйі
8962	әл-ауқат
8963	дәреже
8964	парламент мүшесі\n
8965	халық қызметшісі
8966	заң шығарушы\n
8967	өкіл
8968	нақ уақыты
8969	сол мезетте
8970	сәтте
8971	уақытта
8972	шағында
8973	тәуелсіз
8974	дара
8975	жеке
8976	бөлек
8977	саяқ
8978	сараптама
8979	сұрыптама
8980	анықтама
8981	тәуелсіздік
8982	айғақ
8983	дәйек
8984	дерек
8985	дәлелдеме
8986	анықта
8987	нақтыла
8988	дәлелде
8989	айғақта
8990	бағдарла
8991	раста
8992	сабақ
8993	оқу
8994	лекция
8995	салтты
8996	басшы
8997	басқарушы
8998	президенті
8999	сенім
9000	наным
9001	жарыс
9002	сайыс
9003	татулық
9004	бауырмалдық
9005	сыйластық
9006	бауырластық
9007	әлем
9008	бұйым
9009	жаратылыс
9010	игілік
9011	байлық
9012	мүлік
9013	жөнімен
9014	орнымен
9015	түзу
9016	тура
9017	жөнде
9018	тәртіпте
9019	аудиожазба
9020	екімағыналы
9021	жұрт
9022	халық
9023	қауым
9024	мемлекет
9025	игерілген
9026	кірген
9027	кірістір
9028	кіргіз
9029	құр
9030	тарат
9031	қос
9032	іске қос
9033	кірістіреді
9034	кіргізеді
9035	құрады
9036	таратады
9037	қосады
9038	іске қосады
9039	ендіру
9040	қосу
9041	кіргізу
9042	орнату
9043	сіңдіру
9044	қолдану
9045	жігерсіз
9046	әрекетсіз
9047	тәртіп
9048	талап
9049	қағида
9050	заң
9051	анықтама
9052	шарт
9053	бап
9054	қағида
9055	айрықша
9056	өзгеше
9057	бөлекше
9058	төтенше
9059	ересеен
9060	басқаша
9061	бірқилы
9062	белгі
9063	жекелік
9064	ықтиярлы
9065	ырықты
9066	құқылы
9067	тәуелсіз
9068	күштеусіз
9069	зорлықсыз
9070	тәуелсіз
9071	азаттық
9072	ерікті
9073	кедергісіз
9074	бос
9075	кең
9076	ашық
9077	тәуелсіз
9078	азаттық
9079	бостандық
9080	еркіншілік
9081	теңдік
9082	отчет
9083	мөлшер
9084	шама
9085	пікір
9086	жауап
9087	техникалық есеп
9088	тізімге қосу
9089	санаққа қосу
9090	сана
9091	есепке ал
9092	мәнін шығар
9093	есеп жүргіз
9094	есеп-қисап жүргіз
9095	тірке
9096	ескер
9097	тізімнен ал
9098	санақтан ал
9099	сана
9100	есепке ал
9101	сана
9102	жасаймын
9103	орындаймын
9104	Еуразия континенті
9105	Еуразияға тән
9106	Еуразияға қыртысты
9107	қамтамасыз ет
9108	жаса
9109	құр
9110	орнат
9111	жасырын
9112	оқиға
9113	жағдаят
9114	іс
9115	ахуал
9116	күй
9117	тұрмыс
9118	хал
9119	жағдаят
9120	жөйт
9121	күй
9122	тұрмыс
9123	хал ахуал
9124	жайт
9125	жарамсақ
9126	жағымтал
9127	жалпош
9128	айып
9129	жазып
9130	күнә
9131	кінә
9132	қылмыс
9133	сазай
9134	шара
9135	жазық
9136	айып
9137	күнә
9138	сазай
9139	саза
9140	кінә
9141	қағаз жүзінде
9142	жетілдір
9143	арттыр
9144	асылдандыр
9145	қолда
9146	құпта
9147	мақұлда
9148	қуатта
9149	қошта
9150	қолдаушы
9151	ниеттесші
9152	жақтаушы
9153	қуаттаушы
9154	қолдаулас
9155	ниеттес
9156	жақтаулас
9157	қуаттаушы
9158	ұшта
9159	шекте
9160	жіпте
9161	сабақта
9162	ұлас
9163	жасанды
9164	өтірік
9165	бояма
9166	бекер
9167	өтірік
9168	бояма
9169	жасанды
9170	бекер
9171	ұштасады
9172	шектеседі
9173	жіптеседі
9174	сабақтасады
9175	ұласады
9176	бірыңғай
9177	тұтас
9178	жалпыға ортақ
9179	халық
9180	жұрт
9181	қауым
9182	барлық ұлтқа бірдей
9183	барлық ұлттық
9184	жалпыхалықтық
9185	жалпыжұрттық
9186	мемлекеттік
9187	жалпыжұрттық
9188	қауымдық
9189	қосалқы
9190	қосымша
9191	үстеме
9192	жапсарлас
9193	қосалқы сайлау
9194	қосымша сайлау
9195	айуан
9196	хайуан
9197	аң
9198	мал
9199	түлік
9200	әлгі
9201	әлгінде
9202	заманауи
9203	озық
9204	заманауи
9205	озық
9206	жаңарт
9207	жетілдір
9208	түрлендір
9209	модернизацияла
9210	апгрейд
9211	жаңала
9212	дамыт
9213	қате
9214	әбес
9215	жаңылыс
9216	теріс
9217	ағат
9218	қателік
9219	әбестік
9220	жаңылысушылық
9221	терістік
9222	ағаттық
9223	әлем
9224	жер дүние
9225	дүние
9226	глобал
9227	әлемден
9228	интернационализациялан
9229	кеңейт
9230	глобалдан
9231	Интеграциялан
9232	үдеріс
9233	түгелдей
9234	сыпыра
9235	шетінен
9236	жабдықта
9237	даярла
9238	сайманда
9239	бұзылмаған
9240	ақаусыз
9241	жағымды
9242	қолайлы
9243	ұнамды
9244	қабілетті
9245	қажетті
9246	бұзылған
9247	ақаулы
9248	жағымсыз
9249	қолайсыз
9250	ұнамсыз
9251	қабілетсіз
9252	қажетсіз
9253	қағаида
9254	ереже
9255	тәртіп
9256	заң
9257	низам
9258	мәлім
9259	мағлұм
9260	баян
9261	белгілі
9262	әйгілі
9263	аян
9264	мәлімде
9265	мағлұмда
9266	баянда
9267	белгіле
9268	әйгіле
9269	хабарлаған
9270	мәлімдеген
9271	жария етті
9272	хабарлады
9273	баспаға беру
9274	мәлімдеу
9275	жария ету
9276	жар салу
9277	баспаға беру
9278	бастырту
9279	мәлімдеу
9280	ашықтық
9281	әйгілік
9282	жайдары
9283	ашық
9284	жадыраңқы
9285	ақжарқын
9286	ақкөңіл
9287	нұрлы
9288	бұйрық
9289	акт
9290	заң
9291	әмір
9292	шешім
9293	жарлы
9294	төлем
9295	үлес
9296	қатар бағынатын
9297	жаңа буын
9298	жеткіншек
9299	орында
9300	дайында
9301	істе
9302	астыртын
9303	құпия
9304	бұғыңқы
9305	бүркенішті
9306	ашық түрде емес
9307	ептеп-басып
9308	құпия
9309	бүркенішті түрде
9310	бүркеме
9311	астыртын
9312	астырт
9313	бұғыңқы
9314	демал
9315	тынық
9316	демалады
9317	тынығады
9318	жауаптылық
9319	жетелілк
9320	саналылық
9321	міндетті
9322	борышты
9323	ұқыпты
9324	мұқиятты
9325	тиянақты
9326	тыңғылықты
9327	ықтиятты
9328	міндетті
9329	жылдам
9330	шапшаң
9331	шұғыл
9332	әп-сәтте
9333	демде
9334	лезде
9335	дара
9336	бөлек
9337	дербес
9338	оқшау
9339	оңаша
9340	саяқ
9341	тұлға
9342	жеңіскер
9343	жеңгіш
9344	жетістік
9345	жеңімпаз
9346	ел
9347	аймақ
9348	мекен
9349	өлке
9350	құрлық
9351	жазық
9352	алқап
9353	тұрғылықты
9354	аумақтық
9355	мекенді
9356	өлкелік
9357	зеребе
9358	елдес
9359	ауылдас
9360	мекендес
9361	отандас
9362	қоныстас
9363	рушылдық
9364	трайбализм
9365	дамыт
9366	жет
9367	ілгеріле
9368	меңгер
9369	жалғастыр
9370	арттыр
9371	жақсар
9372	дамыту
9373	жету
9374	ілгерілету
9375	меңгерту
9376	жалғастыру
9377	арттыру
9378	жақсарту
9379	жеңіс
9380	табыс
9381	көмек
9382	тірек
9383	сүйеніш
9384	қолғабыс
9385	демеу
9386	септік
9387	көмек
9388	қолғабыс
9389	септік
9390	жылу
9391	көмектес
9392	тіректес
9393	қолғабыста
9394	демеулес
9395	шоғырла
9396	шоқта
9397	топта
9398	біріктір
9399	жиын
9400	кеңес
9401	кездесу
9402	тобыр
9403	топ
9404	лек
9405	топыр
9406	шоғыр
9407	проект
9408	жоспар
9409	схема
9410	теория
9411	чертеж
9412	биік
9413	шамадан тыс
9414	шарықтау шегі
9415	үстінде
9416	өрге қарай
9417	төтенше
9418	алып таста
9419	өшір
9420	құрт
9421	шығар
9422	өлтір
9423	жоғалт
9424	өшіріледі
9425	жоқ болады
9426	жоқ
9427	өшіріледі
9428	тапшылық
9429	қатшылық
9430	таршылық
9431	жетіспеушілік
9432	жасама
9433	жүзеге асырма
9434	болдырма
9435	жасамау
9436	жүзеге асырмау
9437	болдырмау
9438	үнде
9439	жүгін
9440	бағытта
9441	үндеу
9442	алып тастау
9443	өшіру
9444	алыстату
9445	құрту
9446	өлтіру
9447	шығау
9448	жоғалту
9449	жеке сәйкестендіру нөмір
9450	жеке тұлға нөмері
9451	тіркеу құжат
9452	жақында
9453	болашақта
9454	кездес
9455	қауыш
9456	беттес
9457	кеңес
9458	көріс
9459	кездесу
9460	қауышу
9461	беттесу
9462	кеңесу
9463	көрісу
9464	іске ас
9465	жүргіз
9466	орында
9467	жасау
9468	орындау
9469	іске асыру
9470	орындау
9471	істеу
9472	атқару
9473	жиынтық
9474	тәртіп
9475	реттілік
9476	тұтастық
9477	система
9478	бірлестік
9479	ретте
9480	тәртіпте
9481	бірізден
9482	бірізді
9483	мағыналы
9484	тапсырылсын
9485	міндеттелсін
9486	артылсын
9487	табысталсын
9488	жүзеге асырады
9489	сүйемелдейді
9490	жасайды
9491	қозғайды
9492	өткізілуі мүмкін
9493	жасалуы мүмкін
9494	қозғау
9495	іске қосу
9496	зайыбы
9497	әйелі
9498	жолдасы
9499	күйеуі
9500	қосағы
9501	бірлесе
9502	бірігіп
9503	ынтымақтаса
9504	іс
9505	қызмет
9506	еңбек
9507	қаракет
9508	шаруа
9509	қызметсіздік
9510	боссыздық
9511	халық
9512	қоғам
9513	көпшілік
9514	көрермендер
9515	адамдар
9516	халық
9517	ел-жұрт
9518	қауым
9519	руластар
9520	тобыр
9521	қоғам
9522	ныспы
9523	сайлау бөлме
9524	төр үй
9525	түпкі бөлме
9526	дәліз
9527	лобби
9528	қазіргі заманғы
9529	озық
9530	жаңаша
9531	соңғы
9532	жетілдірілген
9533	қазіргі заманға сай
9534	қаулы
9535	жарғы
9536	низам
9537	мизам
9538	құқықтық акт
9539	заң талаптары
9540	заңның шешімдері
9541	адвокат
9542	құқықтанушылар
9543	прокурор
9544	заңға сәйкес
9545	заңға үйлесімді
9546	заң шеңберінде
9547	құқық аясында
9548	зомбылық
9549	қинат
9550	қысым
9551	қияпат
9552	озбырлық
9553	өктемдік
9554	ой
9555	көзқарас
9556	меншік
9557	қожалық
9558	жоғары оқу орны
9559	ұйымдастыру
9560	орнату
9561	мекеме
9562	интернат
9563	әлемдік желі ресурсы
9564	артынша
9565	ізінше
9566	едел жедел
9567	жапсарлас
9568	маңайлас
9569	шегаралас
9570	шектес
9571	ауқымды
9572	фундаменталды
9573	жұмыс
9574	қызмет
9575	қарекет
9576	еңбек
9577	шаруа
9578	қызмет
9579	жұмыс
9580	жүзеге асыр
9581	жүргіз
9582	еңбектен
9583	іске қос
9584	жүзеге асырылды
9585	жүргізілді
9586	жіберілді
9587	басталды
9588	жаса
9589	етеді
9590	жиналыс
9591	іс
9592	бастау
9593	жиын
9594	той
9595	жасырын
9596	құпия
9597	жабық
9598	ішкі ереже
9599	ішкі қағида
9600	бөлме
9601	бөлімше
9602	үміткер
9603	сайланушы
9604	үміткер
9605	сайланушы
9606	инаугурация
9607	әкім
9608	депутат
9609	президенттік
9610	жеңілдік
9611	Үлес
9612	шектеу
9613	контингент
9614	лимит
9615	мөлшерлеме
9616	бөгет
9617	оралғы
9618	тосқауыл
9619	тосқын
9620	ілгішек
9621	бөгесін
9622	қауіпсіз
9623	шектеусіз
9624	жолық
9625	көріс
9626	жүздес
9627	беттес
9628	кездес
9629	көздес
9630	жүзде
9631	дидарлас
9632	душарлас
9633	табыс
9634	көріс
9635	жүздесу
9636	дидарласу
9637	душарласу
9638	табысу
9639	көрісу
9640	беттесу
9641	қауысу
9642	жолығу
9643	көрісу
9644	жүздесу
9645	беттесу
9646	кездесу
9647	көздесу
9648	рет
9649	орай
9650	жоспарланбаған
9651	жоспарланған
9652	алдағы
9653	келесі
9654	мезет
9655	мерзім
9656	уақыт
9657	шақ
9658	заман
9659	маусым
9660	ретсіздік
9661	жөнсіздік
9662	орынсыздық
9663	жосықсыздық
9664	ерсілік
9665	ендігі
9666	алдағы
9667	мәміле
9668	үйлесім
9669	ымыра
9670	бәтуа
9671	бітім
9672	ымыра
9673	сөзге кел
9674	ұрыс
9675	берілме
9676	ең азы
9677	минимум
9678	азайт
9679	төмендет
9680	кішірейт
9681	қорла
9682	тосын
9683	күрт
9684	бірден
9685	оқыс
9686	қапыл
9687	дүрік
9688	ұлғайт
9689	үлкейт
9690	кеңі
9691	молаяды
9692	артылады
9693	жайылады
9694	жиналыс
9695	жиылыс
9696	мәслихат
9697	отырыс
9698	мәжіліс
9699	қаума
9700	жиын
9701	пікір алмас
9702	жинал
9703	сөйлес
9704	ақылшы
9705	ақыл беруші
9706	кепіл
9707	кепілдеме
9708	гарантия
9709	уәде
9710	бұрыс
9711	үйлеспейтін
9712	сыйымсыз
9713	үйлесімсіз
9714	тәкаппар
9715	зиянды
9716	жоятын
9717	болдыратын
9718	құртатын
9719	болдырмайтын
9720	жүйелі
9721	құрылымды
9722	көп ұзатпай
9723	кідіртпей
9724	кешікпей
9725	бөгелмей
9726	айыпты
9727	жазалы
9728	жазықты
9729	жауапты
9730	айыпкер
9731	табыс
9732	ұтыс
9733	пайда
9734	олжа
9735	алғысөз
9736	емхана
9737	аурухана
9738	стационар
9739	госпиталь
9740	коллегия
9741	өкіл
9742	мәжіліс
9743	кеңес мүшелері
9744	комитет мүшелер
9745	бюро мүшелер
9746	келісім
9747	мәміле
9748	бітім
9749	уағдаластық
9750	пакт
9751	шарт
9752	хатқалта
9753	келісім
9754	мәміле
9755	үйлесім
9756	ымыра
9757	бәтуа
9758	бітім
9759	дәстүрлі
9760	ескіше
9761	заңнамалық
9762	құрылтайшылық
9763	Ата заң
9764	Конституциялық жарғы
9765	Конституциялық низам
9766	Конституциялық мизам
9767	негізгі
9768	түбегейлі
9769	көбіне
9770	кебіне-кеп
9771	көбінше
9772	кебісінде
9773	дәлде
9774	қара
9775	байқа
9776	болжа
9777	ой
9778	пікір
9779	көкейжарды
9780	кекейкесті
9781	қомақты
9782	ауқымды
9783	аумақты
9784	өрелі
9785	саяси коалиция
9786	қауымшыл
9787	ортақшыл
9788	орташыл
9789	жұртшылық
9790	жұрт
9791	әлеумет
9792	тобыр
9793	халық
9794	бұқара
9795	жамағат
9796	жасырын
9797	жұмбақ
9798	кідіріс
9799	айқын емес
9800	ажырата алмау
9801	бейне
9802	елес
9803	айтулы
9804	атақты
9805	ұсын
9806	білдір
9807	байқат
9808	қарастырылған
9809	қарастыру
9810	байқату
9811	білдіру
9812	сездіру
9813	жоғарылайды
9814	өрлейді
9815	биіктейді
9816	қоныс аудар
9817	жер аудар
9818	орын ауыстыр
9819	едәуір дамыған
9820	төраға
9821	басшы
9822	ел басы
9823	лидер
9824	басқарушы
9825	жетекші
9826	копия
9827	қоныс аудару
9828	жер аудару
9829	орын ауыстыру
9830	расталған
9831	сертификат
9832	растама қағаз
9833	белгі
9834	айғақ
9835	дәлел
9836	күмән
9837	қауіп
9838	сезік
9839	секем
9840	шүбә
9841	шәк
9842	тәулік
9843	мезгіл
9844	уақыт
9845	шақ
9846	сөтке
9847	күнделіті қызметі
9848	тіршілік
9849	күнпарақ
9850	календарь
9851	қиын
9852	ауыр
9853	баптау
9854	күй
9855	қуат
9856	қайрат
9857	дәрмен
9858	әл
9859	нығайт
9860	арттыр
9861	ұлғайт
9862	кеңейт
9863	тереңдет
9864	нығайту
9865	дамыту
9866	ұлғайту
9867	нығайту
9868	тереңдету
9869	денонсация
9870	бас тартылған
9871	күшін қайтарылған
9872	үзілген
9873	күшінде жоқ
9874	мықты
9875	қуатты
9876	қайратты
9877	мықты
9878	әлді
9879	қайратты
9880	қажырлы
9881	жігерлі
9882	әлуетті
9883	қарулы
9884	дарынсыз
9885	болымсыз
9886	зейінсіз
9887	лайықсыз
9888	ыңғайсыз
9889	жарияланды
9890	жүзеге асырылды
9891	қабылдау қажет
9892	асығу керек
9893	қыр
9894	жақ
9895	тәртіп
9896	ереже
9897	постулат
9898	принцип
9899	міндет
9900	шарт
9901	қызмет
9902	адым
9903	аттам
9904	керекті
9905	маңызды
9906	міндетті
9907	тиісті
9908	керектік
9909	мұқтаждық
9910	Қазақстан Республикасы
9911	Қазақ елі
9912	Егеменді Қазақстан
9913	қайтадан
9914	жаңадан
9915	қайыра
9916	қайыра айыру
9917	қайыра жару
9918	қайыра бөлшектеу
9919	тағы да бөлшектеу
9920	тағы да бөлу
9921	қайтадан ажырату
9922	қайыра дауыс беру
9923	беріледі
9924	қайта істелінеді
9925	қайта беріледі
9926	шаһар
9927	кент
9928	шөр
9929	мекен
9930	аймақ
9931	провинция\n
9932	мегаполис\n
9933	шаһарлық
9934	кенттік
9935	ықтияры
9936	еркімен
9937	орнына келтір
9938	орналас
9939	әзірлет
9940	қалпына келтіру
9941	құрастыр
9942	жасау
9943	құрастыру
9944	құру
9945	дағдылы
9946	үйреншікті
9947	дауыс бермеген
9948	қатыспаған
9949	тартыну
9950	тыйылу
9951	пана
9952	қорған
9953	қамшыл
9954	қормал
9955	қамсыздандыру
9956	жеткізіп тұру
9957	жабдықтау
9958	қамдау
9959	тойымсыз
9960	нысапсыз
9961	күнпар
9962	қажеттілікті орында
9963	жарқын
9964	қалың
9965	қарқынды
9966	шоғырланған
9967	тамақтандырылған
9968	қалта
9969	орында
9970	байқа
9971	көр
9972	қаржы
9973	ақша
9974	смета
9975	қарастырылған
9976	талданған
9977	талқыланған
9978	зерттелген
9979	орындалу
9980	шолу
9981	қарал
9982	талқыла
9983	талда
9984	тексер
9985	зертте
9986	бақылау
9987	зерттеу
9988	көру
9989	қаражаттандыру
9990	екпінді
9991	тегеурінді
9992	ағынды
9993	қарышты
9994	кері
9995	әдейі
9996	арнайы
9997	ағат
9998	бұрыс
9999	теріс
10000	шатас
10001	жаңылыс
10002	адас
10003	жаңыл
10004	шатастыр
10005	жаңылыс
10006	дәл емес
10007	олқылық
10008	терістік
10009	ала-құлалық
10010	дәлсіздік
10011	мейірімсіздік
10012	рақымсыздық
10013	қатыбастық
10014	қатыбезерлік
10015	ат салыс
10016	қатынас
10017	үлес қос
10018	қатынасушы
10019	араласушы
10020	қорғаныс
10021	қатерсіздік
10022	жарғы
10023	қарар
10024	қоғамдастық
10025	ассоциация
10026	ауыр
10027	қыстау
10028	биқат
10029	ауыртпалық
10030	машақаттық
10031	қиыншылық
10032	киын кез
10033	ашаршылық
10034	жоқшылық
10035	мұқтаждық
10036	тосқауыл
10037	ілгішек
10038	бөгет
10039	оралғы
10040	тосқын
10041	әлеумет
10042	жамағат
10043	жұрт
10044	қауым
10045	орта
10046	халайық
10047	халық
10048	әлеуметтік
10049	қимыл
10050	жыбыр
10051	әрекет
10052	болуы мүмкін
10053	қойылды
10054	орналасуы мүмкін
10055	қолтаңба
10056	мүмкіндік
10057	рұқсат
10058	қолжетімділік
10059	кіру
10060	дауыс жинау
10061	шоғырлау
10062	қолтаңба қою
10063	қошта
10064	қорға
10065	қоста
10066	жақта
10067	құпта
10068	жәрдемдес
10069	пайдалан\n
10070	тұтын
10071	арнайы қолдан\n
10072	қосымша\n
10073	бейімдел\n
10074	құқықтық қолдан\n
10075	пайдалану\n
10076	тұтыну\n
10077	арнайы қолдану\n
10078	қосымша\n
10079	бейімделу\n
10080	құқықтық қолдану\n
10081	істеуге жатпайды
10082	жасауға жатпайды
10083	пайдалануға
10084	пайдалануда
10085	қамқорлық
10086	тірек
10087	қамтамасыз ету
10088	көмекші
10089	қорғау
10090	ыңғайлы
10091	сапалы
10092	жеңіл
10093	арзан
10094	фонд
10095	жинақ
10096	жақта
10097	аяла
10098	сақта
10099	аман алып қал
10100	күт
10101	қайрайла
10102	сақтау
10103	күту
10104	қарайласу
10105	кқамқорлық
10106	аялау
10107	құптау
10108	нәтиже
10109	түйін
10110	тұжырым
10111	қорытым
10112	дәйектеме
10113	біріккен
10114	тұтасқан
10115	қосалқы
10116	үстеме
10117	жанама
10118	риза болу
10119	күлу
10120	жаратылыс
10121	табиғи
10122	куәлік
10123	құрал
10124	мәтін
10125	талап
10126	акт
10127	қағаз
10128	жазба
10129	өкілеттік\n
10130	тәжірибе
10131	хабардарлық
10132	білу
10133	біліктілігі
10134	билік
10135	компетенция
10136	жауапты
10137	уәкілетті
10138	тәртіп
10139	міндет
10140	заң
10141	қақ
10142	қақы
10143	негіз
10144	хабардар ет
10145	жарияла
10146	хабарла
10147	бағалылық
10148	мәнділік
10149	маңыздылық
10150	байлық
10151	келіс
10152	рұқсат бер
10153	мүмкіндік бер
10154	жүзеге асыр
10155	жаса
10156	жабдық
10157	аспап
10158	сайман
10159	топ
10160	адамдар жиынтығы
10161	тобыр
10162	руластар
10163	мүше
10164	бөлім
10165	жұмыс
10166	еңбек
10167	іс
10168	кәсіп
10169	лауазым
10170	жұмыс
10171	кәсіп
10172	қызметші
10173	шолақ
10174	келте
10175	молтақ
10176	молақ
10177	қиын уақыт
10178	күрделі шақ
10179	келісті
10180	орынды
10181	үйлесімді
10182	жарасты
10183	қолайлы
10184	тұрарлық
10185	жанасымды
10186	қызмет
10187	мансап
10188	еркін
10189	тілтанымдық комиссия
10190	үндеухат
10191	үндеу
10192	үнпарақ
10193	көпшілік
10194	партиялық
10195	партиялық жүйе
10196	мұрат
10197	тілеу
10198	мүдде
10199	қалау
10200	арман
10201	тілек
10202	келіседі
10203	қолдайды
10204	кадр
10205	кәсіпқой
10206	шебер
10207	өз істің білегі
10208	құжат
10209	куәлік
10210	рұқсаттама
10211	паспорт
10212	сенімхат
10213	үкімет
10214	мән
10215	мағына
10216	мазмұн
10217	орны
10218	қадірі
10219	өзекті
10220	мазмұнды
10221	негізгі
10222	маңызы зор
10223	мәнді
10224	құнды
10225	қажетті
10226	мағыналы
10227	мәнді
10228	ақпар
10229	мәлімет
10230	хабар
10231	зат
10232	қажеттілер
10233	керек жарақ
10234	құрамы
10235	қажеттілік
10236	кезең
10237	кез
10238	мезгіл
10239	шақ
10240	абырой-атақ
10241	дәреже
10242	атақ
10243	мансап
10244	шен
10245	даңқ
10246	дәрігерлік
10247	болжал
10248	болжам
10249	мөлшер
10250	нобай
10251	тұспал
10252	шек
10253	қоныс
10254	тұрақ
10255	орын
10256	жай
10257	ел
10258	империя\n
10259	князьдік\n
10260	патшалық\n
10261	ватикан\n
10262	күш
10263	халықтық
10264	мүлік
10265	иелік
10266	жеке мұлік құқығы
10267	мезгіл
10268	уақыт
10269	сәт
10270	кез
10271	межелі
10272	мезгілді
10273	мөлшерлі
10274	мұғдарлы
10275	мәдениетті
10276	дамыған
10277	өркениетті
10278	мәдениет мекені
10279	мәдениет ұйымы
10280	өнер үйі
10281	еріксіз
10282	шарасыз
10283	лажсыз
10284	мәжбүр
10285	амалсыз
10286	істету
10287	көндіру
10288	ықтиярсыз көндіру
10289	амалсыз көндіру
10290	ерікті
10291	ықтиярлы
10292	кеңес
10293	отырыс
10294	жиналыс
10295	жиылыс
10296	қаума
10297	мәслихат
10298	хабарлама
10299	арыз
10300	өтініш
10301	ескертпе
10302	мағлұмат
10303	ақпарат
10304	дерек
10305	дәйек
10306	хабар
10307	ақпарат
10308	ақпар
10309	мағлұмат
10310	деректер
10311	дәйек
10312	хабар
10313	атақ
10314	дәреже
10315	лауазым
10316	мансап
10317	шен
10318	проблема
10319	оқиға
10320	түбірткі
10321	қиыншылық
10322	жағдай
10323	мәжіліс
10324	кеңес
10325	отырыс
10326	жиылыс
10327	аймақтың депутаттар корпусы
10328	жиналыс
10329	кеңес
10330	тапсырма
10331	жауапкершілікті тапсырма
10332	мақсат
10333	міндет
10334	борыш
10335	тапсырма
10336	шеру
10337	борыш
10338	парыз
10339	қарыз
10340	кепілдеме
10341	серт
10342	тиісті
10343	борышты
10344	мобильді қосымшалар
10345	сұлба
10346	схема
10347	макет
10348	парадигма
10349	теория
10350	стандарт
10351	бейне
10352	бақылау
10353	болжау
10354	бағалау
10355	қадағалау
10356	түсіну
10357	көлем
10358	ауқым
10359	шама
10360	меже
10361	таңба
10362	белгі
10363	баспа
10364	кемтар
10365	жарымжан
10366	ғаріп
10368	жермешел
10369	дімкәс
10370	мақсат
10371	тілек
10372	тілеу
10373	мұрат
10374	мақсұт
10375	ниет
10376	талап
10377	дүние
10378	нәрсе
10379	зат
10380	жасау
10381	бұйым
10382	мінсіз
10383	кінәратсыз
10384	мүлтсіз
10385	ықтимал
10386	бәлкім
10387	кәдік
10388	бәлки
10389	мүмкіншілік
10390	мұрша
10391	қатысушы
10392	ағза
10393	тұлға
10394	құрам
10395	зейін
10396	зерде
10397	зер
10398	зейін қою
10399	жауапкершілік
10400	қызығушылық
10401	қатысу
10402	байқау
10403	қарау
10404	анық
10405	айқын
10406	дәл
10407	тура
10408	белгілі\n\n
10409	маңызды\n
10410	нағыз\n
10411	анықта
10412	нақтыла
10413	дәлелде
10414	айғақта
10415	бағдарла
10416	раста
10417	сенім
10418	иланым
10419	үгіттеуші
10420	үгітші
10421	уағызшы
10422	кампания
10423	іс-шара
10424	база
10425	тірек
10426	басты
10427	маңызды
10428	бас
10429	өзек
10430	арқау
10431	бастысы
10432	ортасы
10433	ерекшелігі
10434	айқындалады
10435	бағдарланады
10436	нақтыланады
10437	дәлелденеді
10438	әулет
10439	буын
10440	жұрағат
10441	тұқым
10442	түлек
10443	ұрпақ
10444	қорытынды
10445	түйін
10446	тұжырым
10447	ереже
10448	қағида
10449	үлгі
10450	қалып
10451	шама
10452	мөлшер
10453	дәстүрлі
10454	қағидалы
10455	залал
10456	зиян
10457	шығын
10458	кесел
10459	үлгі
10460	көшірме
10461	негіз
10462	жоба
10463	басшылық
10464	нұсқамалық
10465	өңір
10466	аймақ
10467	атырап
10468	округ
10469	аумақ
10470	өңірлік
10471	аймақтық
10472	жергілікті
10473	округтік
10474	аумақтық
10475	өңір
10476	аймақ
10477	аумақ
10478	аудан
10479	білді
10480	анықтады
10481	жазды
10482	орындады
10483	теріс емес
10484	тура
10485	дұрыс
10486	сол емес
10487	жеңіл
10488	қиындықсыз
10489	жеңіл-желпі
10490	қитықсыз
10491	ауыр емес
10492	жеңіл
10493	қиындықсыз
10494	қитықсыз
10495	ыңғайлы
10496	қолайлы
10497	икемді
10498	епті
10499	ыңғайлы
10500	ықгшамды
10501	орамды
10502	қарсылас
10503	оппонент
10504	жайғасқан
10505	орныққан
10506	жайласқан
10507	орын алу
10508	тұратын жер
10509	тұрғылықты жер
10510	тұрған орны
10511	орнықтыр
10512	жайғастыр
10513	қой
10514	сыйғыз
10515	бастыр
10516	тарт
10517	құрылады
10518	қойылады
10519	центр
10520	мекен
10521	орын
10522	мекеме
10523	бөлім
10524	мекен
10525	жер
10526	қоныс
10527	тұрақ
10528	бірінші басшы
10529	вице
10530	жаса
10531	көрсет
10532	жүзеге асыр
10533	жиналыс
10534	жиын
10535	жиылыс
10536	кеңес
10537	мәслихат
10538	мәжіліс
10539	кеңес
10540	бюро
10541	кеңсе
10542	өкілдік
10543	кеңсе
10544	кеңсе бөлмесі
10545	басқа
10546	бөгде
10547	бөтен
10548	жат
10549	бейтаныс
10550	сырт
10551	айырмашылық
10552	ауытқу
10553	жаналық
10554	жұмыслдыру
10555	бетбұрыс
10556	ауыстырылмайды
10557	алмастырылмайды
10558	өзгерілмейді
10559	алмастыр
10560	айырбаста
10561	талқыла
10562	алмастыру
10563	айырбастау
10564	талқылау
10565	толқу
10566	маңызды
10567	мағыналы
10568	орынды
10569	сәйкес
10570	мәнді
10571	қажетті
10572	нақты
10573	маңыздылық
10574	көкейкестілік
10575	келелілік
10576	мәнділік
10577	қажеттілік
10578	уәкіл
10579	төраға
10580	қонақ
10581	өкілеттік
10582	уәкілдік
10583	құқықтық
10584	құзырет
10585	мерзім
10586	ғұмырнама
10587	биография
10588	қабілетті
10589	ұзақмерзімді
10590	мардымды
10591	жартымды
10592	маңдымды
10593	түсімді
10594	аймақ
10595	айнала
10596	атырап
10597	маң
10598	маңай
10599	өлке
10600	атырап
10601	аймақ
10602	бәсеке
10603	мәдениет
10604	цивилизация
10605	мәдениетті
10606	мәдени
10607	мұраға қалдыру
10608	қалдыру\n
10609	уағыздау
10610	бұйрық беру
10611	тапсыру
10612	сипаттау
10613	шөп
10614	дәрі
10615	тағам
10616	көкөніс
10617	ағаш
10618	ұсыныс
10619	ұсынылым
10620	арыз
10621	тілек
10622	өтіл
10623	сұрау
10624	болып жатыр
10625	жалғасып жатыр
10626	жүзеге асыр
10627	орында
10628	өтіл
10629	жүзеге асырылсын
10630	орындалсын
10631	өтілсін
10632	жүргізіледі
10633	сатылады
10634	жүзеге асырылатын
10635	орындалатын
10636	өтілетін
10637	берілетін
10638	құрылатын
10639	іске асыру
10640	құру
10641	жұмыс
10642	әзірлеу
10643	жүргізу
10644	әрекет
10645	ауыспалы
10646	өзгермелі
10647	кіру
10648	жылжыту
10649	жүру
10650	өмір сүру
10651	қолданушы
10652	веб-серфер
10653	клиент
10654	оқырман
10655	тұтынушы
10656	Тапсырыс беруші
10657	өсім
10658	процент
10659	келісім
10660	шарт
10661	қағаз
10662	ұлағатты
10663	салауатты
10664	сұңғыла
10665	парықты
10666	ойшаң
10667	тоқтаулы
10668	ойлы
10669	заң шығарушы билік
10670	палата
10671	сенат
10672	мәжіліс
10673	конгресс
10674	өкілді орган
10675	саяси ұйым
10676	саяси топ
10677	көзқарас
10678	ой
10679	тұжырым
10680	пікірталас
10681	талқылау
10682	дебат
10683	диспут
10684	жарыссөз
10685	сөз еркіндігі
10686	саналуан
10687	елбасы
10688	төраға
10689	басшы
10690	лауазымды тұлға
10691	баспасөз-релизі
10692	қағида
10693	ұстаным
10694	мәселе
10695	сұрақ
10696	қиындық
10697	күрделілік
10698	кедергі
10699	тығыздық
10700	үйлесімді
10701	мөлшерлес
10702	өлшемдес
10703	шамалас
10704	тепе-теңдік
10705	теңгерімдік
10706	партиялық сайлау жүйесі
10707	үрдіс
10708	жиынтық
10709	қарау тәртібі
10710	үдеріс
10711	бекет
10712	мекен
10713	бекет
10714	орын
10715	орынжай
10716	тармақ
10717	әзірлеу
10718	аяқтау
10719	қайта өңдеу
10720	финализация
10721	тюнинг
10722	жетілдіру
10723	куәландыр
10724	дәлелдемеу
10725	сәйкес келмеу
10726	дәлелдеу
10727	негіздеме\n
10728	дәлел\n
10729	куәгер\n
10730	дәлел\n
10731	куәлік\n
10732	куәландыру
10733	бекіту
10734	тәртіптеме
10735	реттеме
10736	күн тәртібі
10737	ереже
10738	жарғы
10739	баспахана
10740	көрініс\n
10741	пішіні\n
10742	редколлегия\n
10743	тұжырымы\n
10744	редакциялау\n
10745	қосалқы
10746	қосымша
10747	бағалануы
10748	реттік
10749	дайындау
10750	әзірлеу
10751	жүзеге асыру
10752	дауыс беру жүйесі
10753	өз шешімінді қалдыратын жер
10754	хабарлау
10755	сұрау салу
10756	еркін білдіру
10757	жүйесіз
10758	тәртіпсіз
10759	қисынсыз
10760	тәртіпте
10761	тұрақта
10762	түзе
10763	орын орнына келеді
10764	орын орнына қойылды
10765	дұрыс болы
10766	бүкілхалықтық дауыс беру
10767	заңнамалық актіні қабылдау
10768	сайлау науқаны
10769	өзгеріс
10770	төңкеріс
10771	жаңғырту
10772	жақсарту
10773	жаңалау
10774	дәстүр
10775	салт
10776	салтанат
10777	сүйемелде
10778	жаса
10779	орын
10780	мән
10781	мағына
10782	маңызы
10783	бейне
10784	маңыз
10785	жікшілдік
10786	туысшылдық
10787	жершілдік
10788	сәйкес
10789	лайық
10790	үйлесімді
10791	орайлас
10792	сәйкесті
10793	дауыс бер
10794	қолда
10795	әзірле
10796	даярла
10797	жабдықта
10798	қамда
10799	таңдалу құқығы
10800	дауыс беру
10801	дауыс беру
10802	қолдау
10803	ойластыру
10804	әзірлеу
10805	даярлау
10806	жабдықтау
10807	қамдау
10808	сайлы
10809	аздап сай
10810	сайлылау
10811	әзірлеу жүйесі
10812	даярлау жүйесі
10813	дауыс беру орны
10814	сайлаудан бұрын
10815	дауыс беруші
10816	таңдаушы
10817	ұзақ мерзімге сақта
10818	қою
10819	ұзақ сақтау
10820	ұзақ
10821	қорғау
10822	қалдыру
10823	орналас
10824	орнық
10825	сый
10826	жайғас
10827	жатқызу
10828	облыс
10829	бөлік
10830	тармақ
10831	жұмыс
10832	тарау
10833	арна
10834	тұрғызылады
10835	бой көтереді
10836	сәйкестендіргенде
10837	таңдамалы
10838	мөлшер
10839	көлем
10840	талай рет
10841	бірнеше
10842	мәрте
10843	есепте
10844	есептеймін
10845	есеп
10846	тіркеу
10847	категория
10848	есептеу
10849	аздаған
10850	бірнеше
10851	саяхат
10852	жол
10853	алыс жол
10854	керуен
10855	жолға шығу
10856	жол жүру
10857	алыс жол
10858	жікте
10859	сарапта
10860	талда
10861	жілікте
10862	таңда
10863	сұрыпта
10864	сараптама жаса
10865	талда
10866	сарала
10867	жілікте
10868	жікте
10869	бағала
10870	сұрыпта
10871	эксперт
10872	бағалаушы
10873	сұрау
10874	өтініш
10875	сұрақ
10876	анкета
10877	саясатты білуші
10878	стратегиялық
10879	саясат
10880	саясаттану
10881	сыртқы саяси-қоғамдық
10882	саяси-әлеуметтік
10883	мемлекеттік
10884	саяси тартыс
10885	саяси күрес
10886	саяси ұйым
10887	қоғамдық ұйым
10888	саяси әдістер
10889	біл
10890	түй
10891	үйрен
10892	сезіледі
10893	білінеді
10894	отырыс
10895	жиын
10896	кездесу
10897	жиналыс
10898	үміт
10899	аманат
10900	наным\n
10901	иланым\n
10902	беделді
10903	өтімді
10904	нанымды
10905	иланымды
10906	серпіліс
10907	талпыныс
10908	жиын
10909	кездесу
10910	жиналыс
10911	үйлеспеушілік
10912	сәйкес келмеушілік
10913	сай келмеушілік
10914	диспропорция
10915	үйлесімсіздік
10916	ұқсастық
10917	бейімділік
10918	жинақтау
10919	құрау
10920	зерделеу
10921	бірең-сараң
10922	ілуде бір
10923	аз
10924	жиі емес
10925	селдір
10926	әредік
10927	аз
10928	ұласады
10929	пікір
10930	мәлімдеме
10931	ой
10932	баяндама жасау
10933	баянда
10934	сарна
10935	тіл қат
10936	айт
10937	де
10938	айтылған
10939	әңгімелес
10940	диалог
10941	қоңырау
10942	қауесет
10943	түсіндіру
10944	келіссөздер
10945	баяндама жасаушы
10946	басқарушы
10947	конференция жүргізуші
10948	төраға
10949	жетекші
10950	күрес
10951	виндсервинг
10952	салауатты өмір салты
10953	марафон
10954	туризм
10955	футбол
10956	сайлау тақтасы
10957	ауыз су
10958	тұщы су
10959	Сұйық
10960	ылғал
10961	сусын
10962	ағын
10963	демеу
10964	медет
10965	медеу
10966	сүйеніш
10967	сүйемел
10968	мойыма
10969	құлама
10970	сұхбаттас
10971	біл
10972	үйрен
10973	сауал
10974	сұрау
10975	сауал-сұрақ
10976	анкета
10977	сұхбат
10978	айдарласу
10979	өтініш
10980	қалау
10981	тадап етуші
10982	сұралған
10983	әңгіме
10984	сөз сөйлеу
10985	диалог
10986	жемдес
10987	құлқындас
10988	жемтіктес
10989	біріккен
10990	топтасқан
10991	сыйма
10992	жақындаса алма
10993	піспе
10994	турашыл
10995	турашыл
10996	натуралды
10997	сайлайды
10998	орын алды
10999	бола алмайды
11000	жасай алмайды
11001	істей алмайды
11002	орындай алмайды
11003	сайланған
11004	әзірленген
11005	стенд
11006	дау
11007	жанжал
11008	керіс
11009	тайталас
11010	қақтығыс
11011	тартыс
11012	жікте
11013	сарала
11014	сарапта
11015	талқыла
11016	пікір алмас
11017	сарапқа сал
11018	ортаға сал
11019	пікір алмасты
11020	сөз қылды
11021	пікірталас\n
11022	конференция\n
11023	қарастыру\n
11024	біл
11025	мойында
11026	атақты бол
11027	сайла
11028	дауыс бер
11029	қала
11030	қолда
11031	сайлаушы
11032	қалаушы
11033	таңдаушы
11034	ізде
11035	кездес
11036	өткізді
11037	берді
11038	тапсырыс
11039	аманат
11040	тапсырма
11041	тираж
11042	бөліс
11043	үлестір
11044	үнде
11045	жалғғастыр
11046	бөлім
11047	сала
11048	тармақ
11049	көне
11050	дәуір
11051	деректер
11052	эпикалық
11053	тарау
11054	тарам
11055	сала
11056	жұмылдыр
11057	араластыр\n
11058	орналастыр
11059	жұмысқа қабылдау\n
11060	аутсорсинг
11061	бағалы зат
11062	шекте
11063	жіберуге болмайды
11064	жіберу
11065	тарату
11066	орнату
11067	фамилиясы
11068	атасының аты
11069	жылдам
11070	лезде
11071	шапшаң
11072	бақыла
11073	қадағала
11074	себебін аш
11075	байқа
11076	терге
11077	бірдей
11078	парапар
11079	бір дәрежеде
11080	тепе- тең
11081	барабар
11082	бірдей
11083	теңдес
11084	теңдей
11085	бірдей сайлау
11086	парапар сайлау
11087	бір дәрежеде
11088	бірдей
11089	түпсіз
11090	шұңғыл
11091	шыңырау
11092	шұңғыл
11093	тұңғиық
11094	терісте
11095	мойындама
11096	бөлшек
11097	механизм
11098	разряд
11099	дағды
11100	іс-тәжірибе
11101	машық
11102	менмен
11103	кесірлі
11104	кекірт
11105	кер
11106	өр көкірек
11107	тәлім
11108	тағылым
11109	сабақ
11110	ереже
11111	қағида
11112	рет
11113	жөн
11114	жүйе
11115	әдіс
11116	айла
11117	әрекет
11118	амал
11119	шешу жол
11120	бағынышты
11121	байланысты
11122	ерікті
11123	азат
11124	бостан
11125	егемен
11126	бодансыз
11127	дербес
11128	ұтымды
11129	пайдалы
11130	ұтықты
11131	ұтырлы
11132	ыңғайлы
11133	табысты
11134	нәтижесіз
11135	өнімсіз
11136	әрекетсіздік
11137	дәрменсіздік
11138	пайдасыз
11139	пайдасыз
11140	ұтымсыздық
11141	тиесілі
11142	тән
11143	белгіленген
11144	тізім
11145	тізбек
11146	ретттілік
11147	тізбе
11148	тізбек
11149	ретттілік
11150	тікесінен
11151	төтесінен
11152	турасынан
11153	тура
11154	түзу
11155	ең негізгі
11156	тура
11157	нақты
11158	төте
11159	таяныш
11160	сүйеніш
11161	сүйемел
11162	тізімде
11163	тізбеле
11164	тізгіште
11165	қос
11166	есепте
11167	сана
11168	рәсімде
11169	тізімдеу орны
11170	күнкөріс
11171	өмір
11172	дүние
11173	дәурен
11174	ғұмыр
11175	тірлік
11176	аяқта
11177	тұр
11178	доғар
11179	қысқарт
11180	тиыл
11181	бітір
11182	аяқталды
11183	тұрды
11184	доғарылды
11185	қысқартылды
11186	тиылды
11187	бітірді
11188	толассыз
11189	тынымсыз
11190	толтыру
11191	жетілдіру
11192	аяғына дейін бітіретін іс
11193	түгендеу
11194	сұрыпта
11195	қосылсын
11196	топтасу
11197	ұйымдасу
11198	бірігу
11199	тобыр
11200	сап
11201	жиын
11202	лек
11203	шоғыр
11204	бөгет
11205	кедергі
11206	оралғы
11207	тосқын
11208	аласа
11209	кішкентай
11210	қысқа
11211	еңіс
11212	ылди
11213	етек
11214	жаны
11215	қасы
11216	маңы
11217	маңайы
11218	ресми басшы
11219	басшы
11220	бастық
11221	басқарушы
11222	тікелей
11223	тікелей сайлау
11224	шұғыл
11225	айрықша
11226	өзгеше
11227	ерек
11228	басқаша
11229	коуч
11230	сабақ
11231	жаңа
11232	семинар
11233	тудыр
11234	әрекет ет
11235	қамтамасыз ет
11236	жаса
11237	шыншыл
11238	әділ
11239	әділетшіл
11240	тура
11241	пайда болды
11242	құрылды
11243	шықты
11244	дамыды
11245	қалыптасты
11246	болды
11247	тумалық
11248	туысқандық
11249	тұтас
11250	толыққанды
11251	жөнде
11252	тегісте
11253	өзгерт
11254	түзуле
11255	өзгеріс
11256	дұрыстау
11257	тұжырымда
11258	қорытындыла
11259	жалпыла
11260	жинақта
11261	түйінде
11262	түбегейлі
11263	баянды
11264	ұйытқы
11265	қозғау
11266	ұғын
11267	сезін
11268	біл
11269	анықтама
11270	түсініктеме
11271	дефиниция
11272	пайымдама
11273	мәлімдеме
11274	түсінік
11275	түсіндірме
11276	анықтама
11277	дефиниция
11278	пайымдама
11279	мәлімдеме
11280	түсінік
11281	тіреуіш
11282	демеуіш
11283	тіреуіш
11284	таяныш
11285	тұғырлық
11286	тоқтам
11287	түйін
11288	кесім
11289	бітім
11290	байлау
11291	қорытынды
11292	түйін
11293	қорытынды
11294	тоқтам
11295	түйін
11296	адам
11297	азамат
11298	адамзат
11299	жеке тұлға\n\n
11300	персона\n
11301	әйел адам
11302	кісі
11303	болады
11304	орнықты
11305	үздіксіз
11306	бірқалыпты
11307	ауыспайтын
11308	тұрақты жері
11309	тұратын жер
11310	өмір сүретін жері
11311	маң
11312	жақ
11313	тарап
11314	бағыт ы
11315	сапаы
11316	қатысушы
11317	ерекшелік
11318	аспект
11319	сәт
11320	жаппай
11321	біртұтас
11322	мықты
11323	нақты
11324	бірлескен
11325	мықты байланысты
11326	тұйық
11327	шек
11328	тоқтам
11329	тежегендік
11330	есті
11331	назар сал
11332	айтып жеткіз
11333	үйрет
11334	сырт
11335	сыртқары
11336	шет
11337	шеткері
11338	тысқары
11339	тыс
11340	тыс
11341	шеткері
11342	сыртқары
11343	өсиет
11344	ақыл
11345	мезгіл
11346	мезет
11347	кезең
11348	шақ
11349	кез
11350	уақ
11351	дәуір
11352	әзірге
11353	мерзімді
11354	шақтық
11355	серт
11356	уағда
11357	ант
11358	пәтуа
11359	бөлім
11360	жер
11361	аумақ
11362	сала
11363	үлескі
11364	бөлімшелік
11365	Учаскеге тән
11366	учаскеге қатысты
11367	аймақ
11368	насихат
11369	үгіт-насихат
11370	уағыз
11371	нұсқау
11372	насихатта
11373	уағызда
11374	қозғалыс
11375	іздену
11376	жұмыс
11377	әрекет
11378	даму
11379	процесс
11380	фрагмент
11381	көрініс
11382	қиынды
11383	қалдық
11384	шаңырақ
11385	баспана
11386	мекен
11387	пана
11388	баспана
11389	шешім
11390	әмір
11391	бұйрық
11392	билік
11393	жарлық
11394	құзыр
11395	нұсқа
11396	мысал
11397	өнеге
11398	ғибрат
11399	ұлағат
11400	төлім
11401	өнегелі
11402	тәрбиелі
11403	тәлімді
11404	тәртіпті
11405	ғибратты
11406	жарна
11407	мүше
11408	ұпай
11409	ірі
11410	алып
11411	еңгезердей
11412	дәу
11413	сенім
11414	қиял
11415	дәме
11416	арман
11417	сенім
11418	дәме
11419	кандидат
11420	талапкер
11421	қатысушы
11422	дауыс
11423	дыбыс
11424	ұран
11425	дабыл
11426	түсінік
11427	ұғыныс
11428	түсінікті
11429	ұғымды
11430	ақылға қонымды
11431	мекеме
11432	кәсіпорын
11433	топтастыр
11434	тұтастандыр
11435	айналдыр
11436	шоғырландыр
11437	әрекет ет
11438	ынтымақшыл
11439	ынтымаұтылық
11440	түрткі
11441	қозғау
11442	мұқият
11443	ықтиятты
11444	құнтты
11445	тиянақты
11446	тыңғылықты
11447	кең байтақ
11448	ұлан-ғайыр
11449	шалқар
11450	нәсіл
11451	жалпыұлттық
11452	мемлекеттік
11453	халықтық
11454	ұлтжанды
11455	отаншыл
11456	үлес
11457	жарна
11458	үндеу
11459	дабыл
11460	шақыру
11461	нәсіл
11462	тұзым
11463	тұяқ
11464	зұрият
11465	әулеь
11466	көзқарас
11467	принцип
11468	пікір
11469	позиция
11470	бағдар
11471	бекініс
11472	бер
11473	көрсет
11474	кеңес бер
11475	тапсыр
11476	кеңес берді
11477	ұмсынды
11478	ұсыным
11479	ұтқыр
11480	ұтырлы
11481	ұтқыр
11482	ұтықты
11483	ұтырлы
11484	дерек
11485	ақиқат
11486	оқиға
11487	шындық
11488	бөлімше
11489	өкілдік
11490	кескін
11491	рөл
11492	жұмыс
11493	іс
11494	қызмет
11495	жаңалық
11496	дерек
11497	дәйек
11498	мәлімет
11499	ақпар
11500	мағлұмат
11501	мәлімде
11502	жарияла
11503	құландандыр
11504	әйгіле
11505	ақпарла
11506	жариялады
11507	айтты
11508	айтылды
11509	жеткізілді
11510	мағлұматтады
11511	ұсынды
11512	жариялайды
11513	айтты
11514	айтады
11515	жеткізеді
11516	мағлұматтады
11517	ұсынады
11518	жарияланым
11519	жаңалық
11520	хабар
11521	хабарлау
11522	құлаққағыс
11523	мәлімдеме\nмағлұмдама
11524	ескертілген
11525	байланысқан
11526	жариялау
11527	хабарлау
11528	құлақтандыру
11529	хабардар ету
11530	ескерту
11531	ел
11532	жұрт
11533	қауым
11534	адамзат
11535	адам
11536	ел
11537	жұрт\nжұртшылық
11538	жамағат
11539	бұқара
11540	әлеумет
11541	қауым
11542	депутат
11543	билік басшылары
11544	интернационалдық
11545	сыртқы саяси байланыстар
11546	акт
11547	құжат
11548	арыз
11549	наразылық
11550	шағым бер
11551	наразылық білдір
11552	арыз жаз
11553	шағын
11554	арыздан
11555	үндеу
11556	дабылдау
11557	мөлшерлес
11558	қарайлас
11559	амал
11560	әрекет
11561	айла
11562	тәсіл
11563	жағдай
11564	талап
11565	міндет
11566	шектеме
11567	шектелген жер
11568	шек
11569	қыр
11570	маң
11571	аралық
11572	меже
11573	теже
11574	кедергі келтір
11575	жол берме
11576	тежеулі
11577	мардымсыз
11578	өлшеулі
11579	шамалы
11580	лимитсіз
11581	шегі жоқ
11582	митинг
11583	шетел
11584	ығыстыр
11585	Алып таста
11586	біліктілігінен айыр
11587	бөліп таста
11588	шешімі табылады
11589	табылады
11590	орындалады
11591	тұжырым
11592	байлам
11593	бітім
11594	түйін
11595	ұйғарым
11596	тоқтам
11597	сергектік
11598	ширақтылық
11599	қунақылық
11600	самдағайлық
11601	бақылаушы
11602	барлаушы
11603	шолғыншы
11604	орталық бөлім
11605	орнатады
11606	ойлап табады
11607	табады
11608	басылған
11609	табылған
11610	шығын
11611	өтім
11612	түсім
11613	Шығыс аймақ
11614	шығыс мекен
11615	шығыс өңір
11616	шығыс
11617	ақиқат
11618	бүркеусіз
11619	шындық
11620	нағыз
11621	шын
11622	шыншыл
11623	шынымен
11624	расымен
11625	ақиқатында
11626	шынтуайытнда
11627	әсер
11628	әсер ет
11629	итермеле
11630	әсер етеді
11631	әсер береді
11632	тигізеді
11633	ықпалын тигізеді
11634	беделді
11635	күшті
11636	мүмкін
11637	қол жетімді
11638	рұқсат етілген
11639	нақты
11640	виртуалды
11641	әлеуетті
11642	бірлік
11643	бүтіндік
11644	ұйымшылдық
11645	ауызбірлік
11646	татулық
11647	ұжысдас
11648	бірлес
11649	достық
11650	татулық
11651	бірлік
11652	әріптестік
11653	ұйымшылдық
11654	қолайлы
11655	тиімді
11656	жағдайлы
11657	оңтайлы
11658	тәуелсіздендір
11659	жүзеге асыр
11660	несібе
11661	ризық
11662	рыздық
11663	рецензент\n
11664	кеңесші\n
11665	маман
11666	ветэксперт
11667	сот-медициналық сарапшы
11668	сайлаушылар
11669	дауыс берушілер
11670	онлайн
11671	санды
11672	цифрлы
11673	таңдамалы
11674	жоғарғы деңгейдегі
11675	Абыроооой
\.


--
-- TOC entry 3764 (class 0 OID 18285)
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
-- TOC entry 3766 (class 0 OID 18293)
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
-- TOC entry 3759 (class 0 OID 18146)
-- Dependencies: 222
-- Data for Name: termin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.termin (id, name, description, examples, is_new) FROM stdin;
1	Дыбыс	Естілетін, көзге көрінбейтін нәрсе	\N	f
2	Әріп	Дыбыс таңбасы, көрінетін, естілмейтін нәрсе	\N	f
3	Буын	Бір сөздің ішінде бірнеше буын болады. Сөз буын санына қарай бір буынды, үш буынды,  төрт буынды, онан да көп буынды сөз деп аталады. Бір буынның ішінде бірнеше дыбыс болады	ат, а-та, а-та-лар, а-та-ла-ры-ма	f
4	Тасымал	Жазып келе жатқанда жол аяғында орын аз қалып, сөз сыймайтын болса, ол сөзге тасымал керек, яғни сөзді екі бөліп, бір бөлігін сол жолда қалдырып, екінші бөлігін келесі жолға асыру керек	Ша-қыр-ған-ға	f
5	Сөйлем	Сөздің басын құрастырып, біреу айтқан ой. Айтушының ойын тыңдаушы ұғарлық даражада түсінікті болып айтылған сөздер ғана сөйлем болады.	Елдің малы далада, біткен жаны жалада, көбі жатыр қалада.	f
6	Түбіршік тіл	Түпкі қалпынан өзгерілмей жұмсалады.	Қытай һәм иапон тілдері.	f
7	Жалғамалы тіл	Сөздің аяғына жалғау қосылып өзгерілетін тіл.	Түрік, фин, қазақ тілдері.	f
8	Қопармалы тіл	Сөз түбірімен қопарылып өзгерілетін тіл.	Орыс тілі, араб тілі.	f
9	Тысқарғы жалғау	Сөздің тұлғасын өзгертсе де, ішкі мағынасын өзгертпейді. Сөйлегенде, жазғанда сөздерді біріне-бірін қиындастырып тізу үшін қажет.	«Құлақ» деген сөзге «-тың» деген жалғау қоссақ, «құлақтың» болады. Тұлғасы өзгерілді, мағынасы өзгерілген жоқ. «Құлақтың» дегенде бастың мүшесінің атын көрсетеді. Міні, сондықтан «-тың» тысқарғы жалғау болады.	f
10	Ішкергі жалғау	Сөздің тұлғасын да, мағынасын да өзгертеді. Бір мағаналы сөзден екінші мағаналы сөз шығарып, сөзден сөз туғызып, көбейтіп тілді байыту үшін қажет.	Егерде «құлақ» деген сөзге «-шын» деген жалғау қоссақ, «құлақшын» болады. Мұнда тұлғасы да, мағанасы да өзгерілді. «Құлақ» бастың мүшесін көрсетуші еді, «құлақшын» болған соң, басқа киетін киімнің атын көрсетіп тұр. Міні, сондықтан «-шын» ішкергі жалғау болады.	f
11	Харіф	Дыбыс таңбасы, көрінетін, естілмейтін нәрсе.	а, о, ы, ұ, у, қ, ғ, т, с, т.б.	f
12	Зат есім	Кім? не? деп сұрауларға жауап болып айтылатын һәм нәрселердің атын көрсететін сөздерді зат есім дейміз. Деректі һәм дерексіз заттардың атын көрсететін сөздерді зат есім дейміз.	Жер, тау, тас, су, ағаш, шөп, жапырақ, күн, ай, жұлдыз, бұлт, қар, жаңбыр.	f
13	Сын есім	Нәрселердің сынын көрсететін сөздер сын есімдер деп аталады. Сын есімнің сұрауы: қандай?	Жарлы, жақын, алыс, аш, тоқ арзан, қымбат, қалың, жұқа, зерек, кешше, өткір, топас, семіз.	f
14	Сан есім	Неше? қанша? деп сұрауға жауап болатын һәм нәрсенің санын көрсететін сөздерді сан есім дейміз.	Бір, екі, үш, төрт, бес, алты, жеті, сегіз, тоғыз, он, он бір, он екі, он үш, он төрт, он бес, он алты, он жеті, он сегіз, он тоғыз, жиырма, отыз, қырық.	f
15	Есімдік	Есімдік дегеніміз есімдердің яғни, зат есімнің, сын есімнің, сан есімнің орнына жүретін сөздер. Есімдік қазақ тілінде бес тарау болады: 1) Жіктеу есімдігі. 2) Сілтеу есімдігі. 3) Сұрау есімдігі. 4) Жалпылау есімдігі. 5) Танықтық есімдігі.	Мен, сен, ол, біз, сіз, олар, кім, не, қайсы, қандай, өзім, өзің, өзі, бұл, ол, мынау, анау, бірі, бәрі, менікі, сенікі, оныкі, өзімдікі, өзінікі, өзімдікі, басқанікі.	f
16	Етістік	Не етеді? не істейді, не қылады? деп сұрағанға жауап һәм өздері істеген істі атайтын сөздер. Сондай не етпек? не істемек?\nне қылмақ? деген сұрауларға жауап болатын сөздердің бәрі де етістік болады.	Арт, тарт, ал, ұр, саба, соқ, қорық, күрес, маңыра, сөк, сүз, таста, шық, жық, ас, ал, төз.	f
17	Үстеу	Сөз үстіне қосылып, сөздің мағынасын толықтыратын сөздерді үстеу сөз дейміз. Қалай? Қашан? Қайда? деген сөздерге жауап болып айтылатын сөздердің бәрі де, я үстеу сөз, я соның орнындағы төлеу сөз.	Әрең, әрі, бері, бұрын, енді	f
18	Демеу сөздер 	Екі сөздің арасын, яки екі сөйлемнің арасын жалғастыруға демеу болатын сөздер.	да, де, я, яки, үйткені, сүйткені, үйтседе, бүйтседе, ба, бе, ма, ме, әлде, әйтпесе, немесе	f
19	Жалғаулық сөздер	Кей сөздер жалғау орнына жүреді һәм жалғаулар сияқты басқа сөздердің шылауында тұрмаса, өз алдына мағына шықпайды. Сондай сөздерді жалғаулық дейміз.	менен, үшін, арқылы, тақырыпты, туралы.	f
66	Атауы	Анықтамасы	Мысал	t
95	Барыс септік	Кімге? неге? қайда? деген сұрақтарға жауап береді.                                                                                                                      	Кімге? Балаға; қайда? үйге.	t
20	Одағай сөз	Кей сөздер басқа сөздерден оңаша, одағай айтылады. Қуаныш, реніш, күйініш, уайым, қайғы жан күйзелгенде, тән күйзелгенде, жан рахат тапқанда, тән рахат тапқанда шығатын дыбыстар, дауыстар, айтылатын сөздер, жанды һәм сөздер, хайуандарға айтатын сөздер, дауыстар, шақырулар бәрі одағай табына кіреді.	әһ! Ах! Ой-бай-ай! Жаным-ай! Құдайым-ай! Апырым-ай! Ау! Отағасы-ау! Апырым-ау! Ай-қай! Е-е-е! Ой тәңірім-ай! Ойбай-ай! Күс-күс! Құр-құр! Хош! Қош, қош! Қош! Құру! Шөре-шөре! Ау-қау! Сорап! айт-айт! Тарс-тұрс, дүңк-дүңк, сықыр-сықыр, тырс-тырс, сарт-сұрт, қаңқ, пыс-пыс.	f
21	Дауысты дыбыс / ашық дыбыс	Ашық айтылатын, дауыстап айтуға көнетін дыбыс.	\N	f
22	Дауыссыз дыбыс / тұйық дыбыс	Тұйық айтылатын, яғни дауыстап айтуға көнбейтін дыбыс.	\N	f
23	Жарты дауысты дыбыс / орта дыбыс	Дауысты дыбыстардай нағыз ашық айтылмайтын һәм дауыссыз дыбыстардай тым тұйық айтылмайтын орта дыбыс.	\N	f
24	Деректі заттар	Көзге көрінетін, құлаққа естілетін, мұрынға иіс келетін, тілге татылатын, денеге сезілетін деректі заттар.	Жер, су, ай, күн, дыбыс, ән, күй, иіс-қоныс, дәм, ащылық, тұщылық, жылулық, суықтық	f
25	Дерексіз заттар	Көзге көрінбейтін, құлаққа естілмейтін, мұрынға иіс келмейтін, тілге татылмайтын, денеге сезілмейтін, адам ақылмен ғана білетін дерексіз заттар.	Бақ, бәле, жан, өлім, мінез, ұят, реніш, қуаныш	f
26	Жалқы есім	Нәрсенің дербес өз басына ғана қойылған зат есім түрі.	Ахмет, Ашымтай, Атығай, Қызылжар, Семей, Қырым, Қытай.	f
27	Жалпы есім	Нәрсенің біріне емес, барлық табына қойылған зат есім түрі.	Кісі, еркек, қала, дала, ел, жұрт, ұлт, өлке, патшалық.	f
28	Жекелік айырыс	Нәрсенің жеке күйіндегі есімнің түрі.	Ата, дене, омырау, белбеу, ой, сырнай, керней, ашу, шыны, қаз, құнан, аяқ, шелек.	f
29	Көптік айырыс	Нәрсенің көп күйіндегі есімнің түрі.	Аталар, денелер, омыраулар, белбеулер, ойлар, сырнайлар, кернейлер, ашулар, шынылар, қаздар, құнандар, аяқтар, шелектер.	f
30	Жай қалып	Нәрсенің битарап күйіндегі есімнің түрі.	Жекеше: ата, дене, омырау, белбеу, ой, үй, сырнай, керней, ашу, шыны, қаз, құнан, аяқ, шелек.\nКөпше: аталар, денелер, омыраулар, белбеулер, ойлар, үйлер, сырнайлар, кернейлер, ашулар, шынылар, қаздар, құнандар, аяқтар, шелектер.	f
31	Тәуелді қалып	Бір нәрсені екінші нәрсе меншіктеуін көрсеткендегі сөздің түрі.	\N	f
32	Оңаша тәуелдік	Бір нәрсені екінші нәрсе оңаша меншіктеуін көрсетеді.	Жекеше, 1-нші жақ (мендік): атам, денем, омырауым, белбеуім, ойым, үйім, сырнайым, кернейім, ашуым, шыным, қазым, құнаным, аяғым, шелегім.\n2-нші жақ (сендік): атаң, денең, омырауың, белбеуің, ойың, үйің, сырнайың, кернейің, ашуың, шының, қазың, құнаның, аяғың, шелегің.\n3-нші жақ (бөгделік): атасы, денесі, омырауы, белбеуі, ойы, үйі, сырнайы, кернейі, ашуы, шынысы, қазы, құнаны, аяғы, шелегі.\nКөпше: 1-нші жақ (мендік): аталарым, денелерім, омырауларым, белбеулерім, ойларым, үйлерім, сырнайларым, кернейлерім, ашуларым, шыныларым, қаздарым, құнандарым, аяқтарым, шелектерім.\n2-нші жақ (сендік): аталарың, денелерің, омырауларың, белбеулерің, ойларың, үйлерің, сырнайларың, кернейлерің, ашуларың, шыныларың, қаздарың, құнандарың, аяқтарың, шелектерің.\n3-нші жақ (бөгделік): аталары, денелері, омыраулары, белбеулері, ойлары, үйлері, сырнайлары, кернейлері, ашулары, шынылары, қаздары, құнандары, аяқтары, шелектері.	f
47	Жіктеу есімдігі	Сөйлеген кезде сөйлеушінің, тыңдаушының һәм бөгдедегілердің жігін ашатын сөздер.	Жіктеу есімдігі үш жақты болады: 1) Сөйлеуші үшін «мен» дейді, бұл бірінші жақ. 2) Тыңдаушыға сөйлеуші «сен» дейді, бұл екінші жақ. 3) Сөйлеуші өзі мен тыңдаушыдан басқаны «ол» дейді, бұл үшінші жақ. Сыпайылап сөйлегенде сөйлеуші өзін «мен» деудің орнына «біз» дейді, тыңдаушыға сен деудің орнына «сіз» дейді, бөгде кісіні «ол» деудің орнына «о кісі» (ол кісі) дейді. Сондықтан «біз» бірінші жақ болады, «сіз» екінші жақ болады, «о кісі» үшінші жақ болады.	f
48	Сілтеу есімдігі	Нәрсені көрсеткенде айтылатын сөздер.	Жақын нәрсені көрсеткенде: осы, бұл, мынау, сол, анау деген сөздер сілтеу есімдігі болады.	f
96	Барыс септікті меңгеретін септеулік шылау	Барыс септік жалғауларында тұрған сөзбен тіркесіп қолданылады.	Дейін, шейін, қарай, таман, салым, жуық, тарта, таяу, сәйкес, қарсы	t
483	Пайдаланылған әдебиеттер: 	\N	\N	t
33	Ортақ тәуелдік	Бір нәрсені басқа нәрселер ортақ меншіктеуін көрсетеді.	Жекеше: 1-ші жақ (біздікі): атамыз, денеміз, омырауымыз, белбеуіміз, ойымыз, үйіміз, сырнайымыз, кернейіміз, ашуымыз, шынымыз, қазымыз, құнанымыз, аяғымыз, шелегіміз.\n2-нші жақ (сіздік): атаңыз, денеңіз, омырауыңыз, белбеуіңіз, ойыңыз, үйіңіз, сырнайыңыз, кернейіңіз, ашуыңыз, шыныңыз, қазыңыз, құнаныңыз, аяғыңыз, шелегіңіз.\n3-нші жақ (бөгделік): атасы, денесі, омырауы, белбеуі, ойы, үйі, сырнайы, кернейі, ашуы, шынысы, қазы, құнаны, аяғы, шелегі.\nКөпше: 1-нші жақ (біздік): аталарымыз, денелеріміз, омырауларымыз, белбеулеріміз, ойларымыз, үйлеріміз, сырнайларымыз, кернейлеріміз, ашуларымыз, шыныларымыз, қаздарымыз, құнандарымыз, аяқтарымыз, шелектеріміз. 2-нші жақ (сіздік): аталарыңыз, денелеріңіз, омырауларыңыз, белбеулеріңіз, ойларыңыз, үйлеріңіз, сырнайларыңыз, кернейлеріңіз, ашуларыңыз, шыныларыңыз, қаздарыңыз, құнандарыңыз, аяқтарыңыз, шелектеріңіз.\n3-нші жақ (бөгделік): аталары, денелері, омыраулары, белбеулері, ойлары, үйлері, сырнайлары, кернейлері, ашулары, шынылары, қаздары, құнандары, аяқтары, шелектері.	f
34	Септік жалғау	Сөздердің үйлесуіне сеп болады.	Септік жалғау бесеу: 1) Ілік жалғау «-дың»; 2) Барыс жалғау «-ға»; 3) Табыс жалғау «-ды»; 4) Жатыс жалғау «-да»; 5) Шығыс жалғау «-дан».	f
35	Көптік жалғау	Нәрсенің жеке емес, көп күйдегі есімін көрсетеді.	лар, лер, дар, дер.	f
36	Түпкі зат есімдер	Түпкі заттың есімін көрсетеді.	\N	f
37	Тек сыны	Нәрсенің тегін көрсетеді.	Ағаш аяқ, күміс қасық, алтын жүзік, қағаз ақша, жез құман, киіз қалпақ, мақта жіп, қайыс жүген	f
38	Сыр сыны	Нәрсенің ішкі, тысқы сырын, реңін яғни, түрін, түсін, тегін, тұлғасын, пішінін, жайын, күйін көрсетеді.	Аласа, жуан, жіңішке, толық, нәзік, арық, семіз, тоқ, аш, шебер, шорқақ, ұста, олақ, ақ, қара, қызыл, сары, көк, жасыл, торы, күрең, шабдар, бурыл, зерек, кеще, тентек, жуас, шадыр, момын, қу, сұм, аңқау	f
39	Жай шырай	Жай шырай артық-кем демей, нәрсенің сиқын жай көрсетеді.	Жақсы атан, жаман қой, тентек бала, жуас ат, шорқақ кісі, қызыл шүберек, биік ағаш	f
40	Талғаулы шырай	Талғаулы шырай нәрсе сиқының бірінен-бірі артық-кемдігін көрсетеді; оны көрсету үшін жай сындағы сөзге «-рақ», «-рек» деген талғау қосымшалары тіркеледі.	Жақсы – жақсырақ, жаман – жаманырақ, зерек – зерегірек, семіз – семізірек. Талғау шырайын күшейткенде, көптеген сөз қосылып айтылады. Мәселен: Сиыр түйеден көп аласа; Қой аттан көп арзан.	f
41	Таңдаулы шырай	Таңдаулы шырай нәрсенің сиқы өте артық екенін көрсетеді. Оны көрсету үшін жай шырайдағы сөздің алдына ең, нақ, тап, тым, бек, хас деген сөздер қосылып айтылады.	Ең жақсы, нақ шешен, тап зерек, тым қорқақ, бек нәзік, хас батыр. Таңдаулы шырай екінші түрлі де болады: жай шырайдағы сөз таңдаулы шырайға түсуге бас дыбыстары бөлек алынып, оған «-п» дыбысы жалғанып, сол бөлектенген дыбыстар сөз алдына қойылып айтылады. Мәселен: а-нық – ап-анық, ау-лақ – ап-аулақ, шо-лақ – шоп-\n62\nшолақ, қыс-қа – қып-қысқа, тай-пақ – тап-тайпақ, жал-пақ – жап-жалпақ, се-міз – сеп-семіз, ақ-шам – ап-ақшам.	f
42	Зат-сын	Зат пен сын орнына бірдей жүретін сөздерді зат-сын дейміз.	Сын есімнің кейбіреулері зат есімнің орнына жүреді. Мәселен: «Арзан еттің сорпасы татымас» дегеннің орнына «арзанның сорпасы татымас» деп айтылады. «Арзан еттің» деген екі сөздің орнына «арзан» деген жалғыз сөз жарап тұр.	f
43	Есептік сан есім	Нәрселердің есебін һәм ретін көрсететін сөздер.	Бір, екі, үш, төрт, бес, алты, жеті, сегіз, тоғыз, он, жиырма, отыз, қырық, елу, алпыс, жетпіс, сексен, тоқсан, жүз, мың, миллион, түмен.	f
44	Реттік сан есім	Нәрселердің ретін көрсететін сөздер.	Бірінші, екінші, үшінші, төртінші, бесінші, алтыншы, жетінші, сегізінші, тоғызыншы, оныншы, жиырмасыншы, отызыншы, қырқыншы, елуінші, алпысыншы, жетпісінші, сексенінші, тоқсаныншы, жүзінші, мыңыншы, миллионыншы.	f
45	Темілдік сан есімдер	Нәрсенің бүтіні емес, бөлімтігінің санын көрсететін сөздер	Жарты, жарым, ширек.	f
46	Жадағай есептік сан есімдер	Зат есімге тіркелмей сөйленетін есептік сан есімдер.	Біреу, екеу, үшеу, төртеу, бесеу, алтау, жетеу.	f
49	Сұрау есімдігі	Біреуден бір нәрсе туралы сұрағанда айтылатын сөздер.	Адам туралы сұрасақ, «кім?» дейміз, басқа заттар туралы сұрасақ «не?» дейміз. Қай нәрсе екендігін сұрасақ «қайсы» дейміз. Нәрсенің сыны тақырыпты сұрасақ, «қандай?» дейміз. Нәрсенің дәл санын сұрасақ, «нешеу?», «неше?» дейміз. Нәрсенің дәл саны емес, шамасын сұрағанда «қанша» дейміз. Нәрсенің қатарда қайсы екендігін сұрасақ «нешінші?» дейміз. Мезгіл туралы сұрасақ, «қашан?» дейміз. Кім? не? Қайсы? Қандай? Нешеу? Неше? Қанша? Нешінші? Қашан? деген сөздер сұрау есімдігі болады.	f
50	Жалпылау есімдігі	Нәрсенің жігін айта сөйлегенде айтылатын сөздер.	бәрі, барша.\n«һәр» деген сөз өзі жіктеу һәм басқа сөздерге де қосылып, жіктеу есімдігінің орнына жүреді. Мәселен, һәр кім, һәр бір, һәр қайсысы уа ғайри сондай сөздер.	f
51	Сөйлем	сөздің басын құрастырып, біреу айтқан ой.\nСөйлеген де, жазғанда кім де болса ойын айтады. Ойын айтуға тиісті\nсөздерді алады да, олардың басын құрап, біріне-бірінің қырын келтіріп,\nқиындастырады. Қыры келетін сөздер, тұрған күйінде алса да, қиындаса\nқалады. Қыры келмейтін сөздерді қиындастыру үшін қырларын өзгертіп\nқиюын келтіреміз.\n	\N	f
67	Адамға бағышталып айтылатын одағайлар	Бұған адамның адресіне бұйыру, жекіру, тыйым салу мақсатымен қолданылатын сөздер мен одағайлы тіркестер жатады.	Айда! Тәйт! Сап-сап! Стоп! Кәне! Жә/тек/тәк! Әуп! Әлди-әлди! Сияқты одағайлар жатады. Жә, тоқтат, ақсақал базаралыдан алмаған өшің бар ма?! (әуезов). Тек, тантымай сөйле! Былғама нұрғанымды (әуезов). Желігуден жалықты жаным менің, сап-сап, көңілім, лепірме, тоқта, тоқта (аманжолов).	t
68	Айқындағыш	Я жеке сөздерді, я сөз тіркестерін, я жеке сөйлемдерді бір-бірімен жалғастырады да, алдыңғы сөз, сөз тіркесі, сөйлем арқылы не баяндауға, не айқындауға, не анықтауға болатын дәнекер сөздер.	яғни, демек	t
69	Амалдың өту сипаты	Амалдың өту белгілерін білдіреді. -ла (-ле, -да, -де, -та, -те);-қыла (-кіле, -ғыла, -гіле);-мала (-меле, -бала, -беле, -пала, -пеле);-ғышта (-қышта, -кіште, гіште);-ыңқыра (-іңкіре, -ңқыра, -ңкіре);-ымсыра (-імсіре, -мсыра, -місре);-ыстрыр (-істір, -стыр, -стір) қосымшаларының көмегімен жасалады. 	оймала, ойғышта, жиыстыр т.б.	t
70	Аналитикалық етістік	Етістіктің (сөз табының) сыртқы құрылысы жағынан да, мазмұны жағынан да аса бай, қызметі жағынан төтенше өрісті, ерекше категориясы.   	айтқан жоқ, келген жоқ, барған емес, көрген емес, т.б.	t
74	Анықтауыш сұрақты сөйлем	Екінші жақтың сөзін анықтап алу үшін қойылған сұрақты сөйлем. 	– Бұл ойды кім айтты?\n– Тілек айтты.\n– Тілек?\n– Иә, Тілек.	t
76	Аралас құрмалас сөйлем	Кемінде үш сөйлемнен құралып, бір-бірімен салаласа да, сабақтаса да байланысады.	Күз келіп, күн суытты, сондықтан ол жылы киінді.	t
77	Аралас құрмалас сөйлем	Құрамына енген жай сөйлемдері бір-бірімен сабақтаса да, салаласа да байланысатын құрмалас сөйлем.	Жабай шығып кетпегенде, Игілік жігіттерді сөзге айналдырып бөгей тұрмақ еді, бірақ оның реті болмай қалды. 	t
78	Асырмалы шырай	Заттың сындық қасиетін я тіпті асыра көтереді, я тым асыра төмендетеді. Асырма шырай сын есімдердің алдына аса, өте, тым (дым), тым-ақ (дым-ақ), тіпті, тіптен, шымқай, нағыз, нақ, ең, ал, орасан, керемет сияқты күшейткіш үстеу сөздердің тіркесуі арқылы жасалады.                                                            	тым үлкен, аса бай	t
79	Атау септік	Формасы, бір жағынан, басқа септіктердің формалары мен мағыналарын салыстырып ажырату үшін қабылданған негізгі форма болса, екінші жағынан, ол тек белгілі бір затты атау үшін ғана емес, онан әлдеқайда кең грамматикалық қызмет атқаратындықтан, арнай талдайтын негізгі форма ретінде қарастырылады. Осыған орай, ол негізгі септік деп аталады.                                                                                                                            	бала, үй	t
80	Атау септік	Кім? кімдер? не? нелер? деген сұрауларға жауап береді де, жекеше, көпше және тәуелді түрлерде де қолданыла береді.                                                                                                                               	Кім? Бала; не? үй.	t
81	Атау септікті меңгеретін септеулік шылау	Атау септік жалғауларында тұрған сөзбен тіркесіп қолданылады.	Үшін, сайын, сияқты, тәрізді, секілді, сықылды, сынды, туралы, жайында, жайлы, жөнінде, арқылы, бойы, бойынша, шама,,лы, шақты, қаралы, ғұрлы, ғұрлым, құрлым, түгіл,	t
82	Атаулы сөйлем	Іс-оқиға жайында баяндамай, тек заттың, құбылыстың, мезгілдің, мекеннің атауын ғана білдіретін, бастауыш баяндауыштық қатынастан тұрмайтын, бірақ зат есімді не есімді тіркестерді атау арқылы білдіретін, айрықша интонациямен айтылатын, бір құрамды сөйлем.	Дала. Күз. Егін даласы рақат құшағында., т.б.	t
83	Атаулы сөйлем	Іс-оқиғаның, құбылыстың тек атауын ғана білдіретін сөйлем.	Түн. Жарық ай. 	t
86	Ауыспалы келер шақ	Іс-қимылдың алдағы уақытта анық іске асатынын білдіреді,  -е/-й қосымшалары арқылы жасалады. 	келе-мін, ойнай-мын т.б.	t
87	Ауыспалы осы шақ	Іс-әрекеттің сөйлеп тұрған кезде болатынын әрі ұласпалылық сипатын танытады, -а, -е, -й қосымшасы арқылы жасалады. 	келе, ойнай т.б.	t
88	Ауыспалы өткен шақ  	Ауыспалы өткен шақ  есімшеніңі -атын, -етін, -йтын, -йтін жұрнақтары арқылы жасалып, бірде өткен шақтық, бірде келер шақтық мағынада қолданылады.  	келетін, ойнайтын т.б.	t
91	Ашық рай (индикатив)	Амал-әрекеттің өткенде, қазірде және келешекте болу я болмауын білдіретін негативті грамматикалық категорияны айтамыз. Амалдың айқын емес екенін білдіретін негативтік сипат – неғайбыл райлардың (ирреалды) бәріне де тән жалпы қасиет.                                                                                            	Қар жауып тұр (Осы шақ), Ертең хабарласарсың (Келер шақ), Қырғыз елінде болғанмын (Өткен шақ).	t
92	Барыс жалғаулы сөз тіркестері	Жанама толықтауыштық, пысықтауыштық қатынастарда жұмсалады	тоғайға кіру, жазға киіну, оқуға келу	t
93	Барыс жалғаулы сөз тіркестері	Барыс жалғаулы сөз тіркестері өзара меңгеріле байланысады да, жанама толықтауыштық, пысықтауыштық қатынастарда жұмсалады. Барыс жалғаулы есімдер қатысқан етістікті сөз тіркесінің қарым-қатынасының əр түрлі болуы сөз тіркесі құрамының түрлі-түрлі болуымен байланысты, мысалы, тауға шығу (беталыс), тоғайға кіру, үйге келу (мекен), балаға беру (арнау). Барыс жалғаулы есімдер кез келген етістіктермен тіркесе бермейді, мағыналық үйлесімде бола алатын етістіктермен ғана тіркеседі. 	Олар мынадай етістіктер: беру, кету, келу, жату, отырыу, ұмыту, сену, нану, жалыну, ұнау, сіңу, қуану, таяну, қамау, беру, беттеу, шығу, түсу, тою, қарау, салу, жету, жүру, шабу, кіру, кірісу, қону, айту, толу, қамау, қою, жақындау, бату, қызығу, көріну, дайындалу,т.б	t
94	Барыс септік	Бұл септіктегі сөз әрқашан етістік мүшемен (сөзбен) тікелей де, жанай да байланысып, негізінде, қимылдың бағытын, мақсатын білдіреді. Барыс септіктегі сөз мағынасына қарай сөйлемде толықтауыш та, пысықтауыш та болады.     	балаға, үйге	t
392	Құрама	Әрбір компонентінде өзді-өзіне дербес лексикалық мағына бар	ойланып-толғану, алдап-сулау т.б.	t
107	Бейнелеуіш сөздер	Табиғатта ұшырасатын сан алуан құбылыстар мен заттардың бір-біріне қақтығысу-соқтығысуларынан туатын дыбыстарды, сондай-ақ, жан-жануарлардың дыбысталу мүшелерінен шығатын әртүрлі дыбыстарды көзбен көру қабілеті арқылы туатын түсініктер.	Салп, жалт, кілт, елең, жалп, зып, бүлк, қалқ, селк т.б.	t
108	Бейнелеуіш сөздер	Табиғаттағы құбылыстар мен заттардың және неше алуан жан-жануарлардың сыртқы сын-сипаттары мен әрекет-қимылдарын көру қабілеті арқылы қабылданған бейне-көріністердің атауларын, яғни атаулары ретінде қызмет ететін сөздерді айтамыз.         	жалт қарады, маң-маң басады, желп-желп етеді, жарқ-жарқ етті	t
109	Белгісіздік есімдігі	Затты, сындық белгіні, сан-мөлшерді белгісіз етіп жорамалдап, тұспалдап көрсету мәнін білдіретін есімдіктің түрі.	Біреу, кейбіреу, қайсыбіреу, әлдекім, әркім, кімде-кім, әлдебіреу, бірдеме, әрне, әлдене, қайсыбір, кейбір, әр, әрбір, қайбір, біраз, бірнеше, әрқашан, әрдайым, әлдеқашан, әлдеқайда, әрқалай, әлдеқалай	t
110	Белгісіздік есімдіктер	Мағыналары жағынан заттар мен құбылыстарды нақтылы түрде білдірмей, белгісіз мәнде айтылатын сөздерді айтамыз. Белгісіздік есімдіктердің жасалуына бір, әлде, әр деген үш сөз ұйытқы болып қызмет атқарады.  	бір, біреу, кейбір, кейбіреу, әрбір, әрбіреу, қайбір, қайбіреу, біраз, бірдеме, бірнеше, әлде, әлдекім, әлдене, әлденеше, әлдеқалай, әлдеқашан, әлдеқайда, әлдеқайдан, т.б.	t
111	Біріккен етістік	Екі түбір етістіктің бірігіп кетуі арқылы жасалған етістік	жүрек жалғау т.б	t
112	Біріккен зат есім	Кемінде екі түбір морфемадан бірігу арқылы жасалған зат есімдер. 	Жаңаарқа, Алтынтөбе, Ақтөбе, теміржол	t
113	Біріккен зат есім	Кемінде екі түбір морфемадан бірігу арқылы жасалған зат есімдер жатады.                                                                                                                                   	Темірқазық, Түйетабан, Көкшетау, Еңбеккүн	t
114	Біріккен одағай	Мағыналы екі сөздің бірігуі арқылы туындаған одағай сөз.	Мәссаған!, бәрекелді!	t
115	Біріккен сөз	Екі я онан да көп сөз бірігіп, жаңа лексикалық мағынада айтылған сөз тұлғасы.	көкжиек, ешқашан, қонақжай, Жетіқарақшы, Екібастұз	t
116	Біріккен сөз	Компоненттері мағына жағынан да, форма жағынан да елеулі өзгерістерге ұшырамай-ақ, өзара бірігіп, жинақталған бір тұтас лексика-семантикалық мағына білдіретін күрделі сөзді айтамыз.                        	аққұтан, Темірқазық, кәсіпорын, ақкөгершін, бұзаубас, т.б.\n\n 	t
117	Біріккен сын есім	Бірігу арқылы жасалған сын есім	көкпеңбек, 	t
118	Біріккен үстеу	Сөздің бірігуі арқылы жасалған.	Таңертең, жаздыгүні	t
119	Бірыңғай мүшелер	Жай сөйлемде түрлі сөзбен қайталанып отырған кейбір мүшелердің сұрауы ортақ және бір мүшеге бағынуы. 	М: Иван Петрович орта бойлы, жылтыр шаш, қыр мұрын, қой көзді, аққұба келген жігіт еді. 	t
101	Бастауышқа қойылатын сұрақтар: 	Кім? Не? Кімдер? Нелер? Кімі? Несі? 	\N	t
120	Болжалды келер шақ	Іс- қимылдың келешекте іске асуын күмәндануды білдіреді, -ар/-ер/-р қосымшалары арқылы жасалады. 	келер, ойнар т.б.	t
121	Болжалды келер шақ	Алдағы уақытта істелетін амал-әрекетті атайды, бірақ ол амалдың жүзеге асу-аспауы күдікті, екі талай екені аңғарылады. Ал форманың өзі есімшенің келер шағының –ар (-ер, -р) жұрнағы арқылы етістіктің жалаң және күрделі негіздерінен жасала береді.  	қуан-ар-сың, жет-ер-сің, тоқы-р-сың, айтпа-с, сындырма-с, келтірме-с, өкпелетпе-с	t
122	Болжалды келер шақты есімше	ар,-ер,-р есімшенің болымды, болымсыз түрі қосарланып, әрі қарай түрлі септік жалғауы арқылы қолданылады да болымды, шұғыл ірекетті аңғартады. 	келер, ойнар т.б.	t
123	Болжалдық сан есім	Жалпы заттың, зат есімнен туған сындық белгінің немесе іс-әрекет, амалдың ұзын-ұрға саны, сандық мөлшерін білдіру үшін қолданылады.	бірдей, ондаған, жүздеген т.б.	t
124	Болжалдық сан есім	Белгілі бір заттар мен құбылыстың сан мөлшерін дәл атамай, тұспалдап қана шамамен атайтын сөздер.                                                                   	жиырмалаған, мыңдаған, жүздеген, жиырмалап, елулеп, бір-бірлеп, екеулеп, тоқсандай, мыңдай, жүздей	t
125	Болжалдық/күдіктік	Жеке сөздер арқылы, сөз тіркестері арқылы және сөйлем арқылы берілген ойға күмандану, болжалдау, көмескілендіру, сенімсіздік білдіру, мысқылдау, кекеу мәнін жамау үшін қолданылатын демеуліктер.	Мыс, міс, ау, екеш	t
126	Болымды 	Іс-әрекеттің жүзеге асуын білдіретін форма етістіктің болымды түрі деп аталады.	кел, жүр, отыр т.б.	t
127	Болымды етістік	Іс-әрекеттің жүзеге асуын білдіретін форма.	оқы, жазды, айтқызды, орындады, сана, жүгір	t
128	Болымсыз	Іс-әрекеттің жүзеге аспауын білдіретін форма етістіктің болымсыз түрі деп аталады. Ма, -ме, (-ба, -бе, -па, -пе) қосымшаларының көмегімен жасалады. 	келме, жүрме, отырма т.б.	t
129	Болымсыз етістік	Іс-әрекеттің жүзеге аспауын білдіретін форма.	жақындама, жүгірме, сұранба, күрсінбе, алыстатпа, тездетпе	t
130	Болымсыздық	Жанындағы сөзге болымсыздық мағына беретін демеуліктер.	Түгіл, тұрсын, тұрмақ, құрылым	t
131	Болымсыздық есімдігі	Болымсыздық мағынаны білдіретін есімдіктің түрі.	Ешкім, ешқайсысы, дәнеңе, ештеңе, ешқандай, ешбір, ешқашан, ешқайда	t
133	Болымсыздық есімдіктер	Негізінде еш деген сөзбен кейбір есімдіктердің бірігуі арқылы жасалады. Болымсыздық сөйлемде болымсыздық мағына білдіретін емес, жоқ деген сөздермен және етістіктің болымсыз түрімен байланысты қолданылады.    	ештеңе, ештеме, ешкім, ешбір, ешқашан, ешқандай, ешқайдан, ешқайда, дәнеңе, дәнеме.	t
134	Бөлшектік сан есім	Есептік сан есім -ыншы, -інші, -ншы, -нші  жұрнақтары арқылы жасалып, белгілі бір заттар мен құбылыстардың сандық ретін білдіреді.	жүзден бір, мың жарым, төрт ширек т.б.	t
135	Бөлшектік сан есім	Негізінде таза математикалық ұғымға байланысты туған сөздер. Олар белгілі бір заттар мен құбылыстардың сандық бөлшегін білдіреді.                                     	үш бүтін оннан бір, жеті бүтін оннан төрт (7,04)	t
136	Бұйрық рай (императив)	Аталып жүрген түрінің модальдік мағыналары – семантика жағынан да, грамматика жағынан да қарымы кең формалар. Бұл рай іске қосу, амалды істеуге қозғау салу, түрткі болу, ұсыныс жасау, кеңес беру, тілек айту, өтініш ету, жалыну, бұйыру, әмір ету... тәрізді қыруар көп модальдік мағыналарды білдіреді.	 хабарлас-сын, жеткіз-сін, көрсетпе-сін, тоқтатпа-сын	t
137	Бұйрықты сөйлем	Біреуге бұйыру не талап ету мақсатында айтылған сөйлем бұйрықты сөйлем деп аталады.	Атаның баласы болма, адамның баласы бол.	t
138	Бұйрықты сөйлем 	Бұйыру, тілек-өтініш ету мақсататында айтылатын сөйлем. Сөйлем соңында нүкте немесе леп белгісі қойылады. Баяндауышы бұйрық рай арқылы жасалады. 	Сөйлемді жазып шық. Жүр, тез аяғыңды бас!	t
139	Бұйырық рай	Сөйлеушінің тыңдаушыға немесе тыңдаушы арқылы бөгде біреуге (3-жаққа) қаратылып, бұйрық, сұрай айтылатын, өзіне (1 жаққа) байланысты қимылға, іс-әрекетке қозғау салу, ниет мәнін білдіріп, белгілі қосымшалар жүйесі арқылы берілетін рай түрі болып табылады. -айын, -ейін, -йын, -йін, -ыңыз, -іңіз, -ңыз, -ңіз, -сын, -сін қосымшалары бұйрықты, насихатты, тыйымды және т.б. білдіреді.	келіңіз, ойнасын т.б.	t
140	Бұрынғы өткен шақ 	Қимылдың, іс-әрекеттің сөйлеп тұрған сәтпен салыстырғанда әлдеқайда бұрын болғандығын білдіреді, -ған, -ген, -қан, -кен қосымшасының көмегімен жасалады. 	келген, ойнаған т.б.	t
147	Дағдылы өткен шақты есімше	с,-атын,-етін, -йтын,-йтін,-ушы,-уші түрі сөйлемде жіктеліп, бұрын болған әрекеттің бірнеше қайталанып, дағдылы қалыпта орындалатынын білдіреді. 	келетін, ойнайтын т.б.	t
148	Дара анықтауыш 	Бір сөзден тұратын анықтауыш. 	Сары жапырақтар жерге түсіп жатыр. 	t
149	Дара бастауыш 	Бір сөзден тұратын бастауыш.	Жігіттер аттарын жетектеп, бұлақ басына жақындай береді. 	t
150	Дара баяндауыш	Дара баяндауыш бір сөзден жасалады. 	Бұл сөзге бәрі жамырай күлді. Дәмеш осы үйдің үлкені. Жолаушылар саны – отыздай.	t
151	Дара баяндауыш 	Бір сөзден тұратын баяндауыш. 	Олар алыс жерден келді. 	t
153	Дара есімдік	Бір сөзден жасалған есімдік.	мен, олар, сендерсіңдер, дәнеңе, анау, бәрі, күллі, қашан, сол, өз, кей	t
154	Дара зат есім	Бір сөзден жасалған зат есім	бала, ағаш, буын, орақ, жауын, жасау	t
155	Дара пысықтауыш	Дара пысықтауыш тек бір сөзден тұрады. 	Ананың үні мейірімді естілді. Мен досымның жүзіне бағдарлай қарадым. \nҚалаға кештетіп жеттік. Алыстан бірнеше адам көрінді.	t
156	Дара пысықтауыш 	Бір сөзден тұратын пысықтауыш.	Ол сұраққа ойланбастан жауап берді. 	t
157	Дара сан есім	Заттың санын, мөлшерін, ретін, шамасын білдіретін сөз табы.сан есім өзі анықтайтын сөздің алдынан келіп, атау тұлғасында тұрады, субстантивтенгенде (заттанғанда) көптеледі, жіктеледі, тәуелденеді, септеледі.	бес, мың, алтау, оныншы	t
158	Дара сөйлем мүшесі	Дара сөйлем мүшесі толық мағыналы бір сөзден болады. Сөйлемдегі әрбір сөйлем мүшесі – бір ғана сөзден құралып тұрған дара мүшелер.	Аман жиналғандармен қысқа амандасты. Ол жиналғандармен қысқа сөйлесті. \n	t
159	Дара сын есім	Бір ғана түбірден тұратын сын есімдер	Ақ, көк, жақсы, қызық	t
160	Дара толықтауыш 	Бір сөзден тұратын  толықтауыш.	Оны ешкімге көрсетпе. 	t
162	Демеулік	Өздері тіркесетін сөздерге әр қилы қосымша реңктер (мағыналар) жамайтын сөздер. Демеуліктер өзгермейді, түрленбейді, тіркескен сөздеріне қосымша мағына үстейді.	ма, ме, әсіресе, қой, ғой, түгіл, т.б.	t
223	Жайылма сөйлем	Тұрлаулы мүшемен бірге тұрлаусыз мүше қатысқан сөйлем. 	Алтын қасықты апам сыйға тартқан болатын. Мен ұзақ жол жүрдім. Алыстан биік ағаш көрінеді, т.б.	t
163	Демеулік шылау	Өздері тіркесетін сөздерге әр қилы қосымша реңктер (мағыналар) жамайтын сөздерді айтамыз.                                                                             	1. Сұраулық демеуліктер: ма, ме, ба, бе, па, пе (мы, мі, бы, бі, пы, пі). Мысалы, барасың ба? – барамысың? келесің бе? – келемісің? көріп пе ең? – көріппісің? айтып па ең? – айтыппысың?\n2. Күшейткіш демеуліктер: -ақ, -ау, -ай, әсіресе, -да, -де, -та, -те. Мысалы, Осы-ақ, досым-ай, қарағым-ау, Тілек те келді.\n3. Шектік (тежеу) демеуліктері: ғана (қана) тек. Мысалы, тек қана, сен ғана.\n4. Болжалдық демеуліктер: -мыс, -міс. Мысалы, болыпты-мыс, өмір сүріпті-міс.\n5. Болымсыздық немесе қарсы мәнді салыстыру демеуліктері: түгіл, тұрсын, тұрмақ. Мысалы, Ол түгіл, сен тұрмақ.\n6. Нақтылау мәнді демеуліктер: қой (ғой), -ды, -ді, -ты, -ті. Мысалы, сол ғой, айтқан-ды, көрген-ді.	t
164	Дерексіз зат есім	Көзге көрінбейтін, денеге сезілмейтін, тек ойша топшылап барып қана айтуға келетін заттар.	Ауа, ақыл, сана	t
165	Деректі зат есім	Көзге көрінетін, денеге сезілетін деректі зат атаулары.	үстел, су	t
166	Еліктеу сөздер	Біріншіден, табиғатта ұшырасатын сан алуан құбылыстар мен заттардың бір-бірімен қақтығысу я соқтығысуларынан туатын, сондай-ақ, неше түрлі жан-жануарлардың дыбысталу мүшелерінен шығатын әртүрлі әрекет қимылдарынан туатын, әр қилы дыбыстарға еліктеуден пайда болған түсініктер, екіншіден сол табиғатта ұшырасатын сан алуан құбылыстар мен заттардың және неше түрлі жан-жануарлардың сыртқы сын-сипаты мен қимыл-әрекеттерінің де қилы-қилы көріністерінен пайда болатын түсініктерді білдіреді.	Арс, гүрс, борт, күрт, былп, желп, сарт-сұрт, жалт-жалт, арбаң-арбаң, қызараң-қызараң, митың-митың, қалт-құлт, морт, шырт, батыр-бұтыр, т.б.	t
167	Еліктеу сөздер	Сыртқы морфологиялық құрылысына қарай, жалаң да, күрделі де болады.  Жалаң еліктеу сөздер негізгі және туынды болып екі салаға бөлінеді.                                                                                                                                                     	жалт-жұлт етеді, сарт ете түсті, арбаң-арбаң етіп, күлмің-күлмің етті, шіңк-шіңк етті	t
168	Еліктеу сөздер (мимема)	Тілімізде семантикалық ерекшелігі жағынан да, грамматикалық сыр-сипаты жағынан да, фонетика-морфологиялық құрылымы жағынан да өзге сөз топтарынан оқшауланып тұратын, соған сәйкес, өз алдына дербес сөз табы ретінде қаралатын бір алуан сөздер	жалт-жұлт етеді, сарт ете түсті, арбаң-арбаң етіп, күлмің-күлмің етті, шіңк-шіңк етті	t
169	Еліктеуіш	Табиғатта ұшырасатын сан алуан құбылыстар мен заттардың бір-біріне қақтығысу-соқтығысуларынан туатын дыбыстарды, сондай-ақ, жан-жануарлардың дыбысталу мүшелерінен шығатын әртүрлі дыбыстарды есту қабілеті арқылы белгілі түсініктер ретінде қабылдаудан болған сөздер.	Тарс, қарқ, дүңк, тыңқ, діңк, тоқ, тық, топ, ырр, дар-дар, сырт-сырт, қорқ-қорқ, т.б.	t
170	Еліктеуіш сөз	ла (-ле, -да, -де, -та, -те);    -ра (-ре, -ыра, -іре);-ырай (-ірей); -ы, -і; -шы, -ші; -ан, -ен, -ын, -ін, -н; -ырқа, -ірке;-ырқан, -іркен; -ына, -іне;-қа, -ке, -ға, -ге;-ди, -тый, -ти	жымыңда, күлімде, сүйрелеңде; күлімсіре, жыламсыра; жарқыра, дүркіре, күркіре, бұрқыра; бақырай, тасырай, тысырай; желпі; дүрди, сұсти, ташти, төсти.	t
171	Еліктеуіш сөздер	Табиғатта ұшырасатын сан алуан құбылыстар мен заттардың бір-біріне қақтығысу-соқтығысуларынан туатын дыбыстарды, сондай-ақ, жан-жануарлардың дыбысталу мүшелерінен шығатын әр түрлі дыбыстарды есіту қабілеті арқылы белгілі-белгілі түсініктер ретінде қабылдаудан болған және сол түсініктердің атаулары есебінде қалыптасқан сөздерді айтамыз. 	сарт-сұрт ете қалды, гүрс ете түсті, жымың-жымың етеді, жарқ ете қалды	t
173	Еліктеуішті сөз тіркестері	Еліктеуіш сөздер көмекші не негізгі етістіктермен тіркескен синтаксистік құрамда қолданылады	жалт қарау, кілт тоқтады, тарс-тұрс жарылды	t
224	Жақсыз сөйлем	Жақсыз сөйлем – бастауышы мүлдем жоқ сөйлем.	Менің оқығым келеді. 	t
174	Еліктеуішті сөз тіркестері	Етістікті сөз тіркестерінің бағыныңқы сыңары қызметінде жұмсалатын еліктеуіш сөздер етістіктерді мəнерлі түрде еліктеу тұрғысынан сипаттайды. Оның ішінде бір буынды еліктеуіш сөздері бар тіркестер қимыл-əрекеттің шапшаңдық қарқынын меңзейді. 	жалт-жалт қарау, бұрқ-бұрқ қайнау, тарс-тарс соғу.	t
175	Еркін  сөз тіркесі 	Тіркестің құрамындағы сөздер еркін қатынаста өзгеріп, алмасып отырады/ Құрамындағы сөздердің орнын өзгертуге немесе басқа сөздермен алмастыруға болатын сөз тіркесі	сауатты  адам, дамыған ел,  ақ жаға,  тіл дамыту,  сүңгуір қайық, салтанатты кеш,  бір апта 	t
176	Еркін сөз тіркесі	Сөз тіркесінің құрамындағы сөздерді өзгертіп айтуға болады.	көрікті деген сөзді бірнеше сөзбен тіркестіруге болады: көрікті адам, көрікті жігіт, көрікті қыз, көрікті табиғат, т.б. 	t
177	Есептік  сан есім	Бір ғана түбірден тұратын сан есім. 	бір, екі, үш, төрт, бес т.б.	t
178	Есептік сан есім	Жалпы заттың, зат есімнен туған сындық белгінің немесе іс-әрекет, амалдың ұзын-ұрға саны, сандық мөлшерін білдіру үшін қолданылады.                                                                                                                                      	төрт, жетпіс, мың, сегіз, бес, тоғыз	t
183	Есімді меңгеру	\N	қойдан жуас, оқуға ықыласты, қалада көп	t
180	Есімдерден сын есім тудыратын өнімсіз жұрнақтар	 - ті, -сыз, -сіз, -шыл, -шіл, -дай, -дей, -тай, -тей, -лық, -лік, -дық, -дік, -тық, -тік, -лас, -лес, -дас, -дес, -тас, -тес, -шаң, -шең	ақылды, ақылсыз, ішкі, таудай, ашушаң т.б.	t
181	Есімдерден сын есім тудыратын өнімсіз жұрнақтар	-ыл,-іл,-л,-ал,-ел,-дар,-дер,-тар,-тер,-и,-паз,-мпаз,-ымпаз,-імпаз,-қой,-ғой,-қор	ашық, сезгіш, ұтқыр, жасанды т.б.	t
182	Есімдерден сын есім тудыратын өнімсіз жұрнақтар	-қ,-к,-ық,-ік,-ақ,-ек,-уық,-уік,-ыңқы,-ңқы,-іңкі,-ңкі,-ынді,-інді,-нды,-нді,-малы,-мелі,-балы,-белі,-палы,-пелі,-қыш,-кіш,-ғыш,-гіш,-шақ ,-шек,-ымды,-імді,-мды,-мді,-улы,-улі,-қақ,-кек,-ғақ,-гек,-ма,-ме,-ба,-бе,-па,-пе	қағыс, ұшқалақ, келімсек т.б.	t
185	Есімді сөз тіркесі	Сөз тіркесінің басыңқы сыңары есім сөз болып келетін түрі. Мұндай сөз тіркесінің ұйытқы сөздері (басыңқылары), негізінен, зат есім және сын есім, сан есім сияқты есім сөздер болады да, бағыныңқы сыңарлардың қызметін есім сөздердің бірі немесе етістіктің есімше түрі атқарады. 	қалың тоғай, жақсының сөзі, екінің бірі, оқылған кітап.	t
186	Есімді сөз тіркесі	Сөз тіркесінің құрамындағы сөздің екінші басыңқы сыңары зат есім, сын есім, сан есім, есімдік болса, ол есімді сөз тіркесі деп аталады.  	Тұрғын үй, орындалған арман, балаға мейірімді, көп қабатты үй, жүгіріп келген бала, өнегелі өмір.	t
187	Есімді тіркестер	Есімді сөз тіркестерінде есім сөздің бірі басыңқы болады.	қызық өмір, үш кісі, келген қыз, ағаштың бұтағы, менің ақылдым, үштің екісі, саған қиын	t
188	Есімдік	Есім сөздердің (зат есім, сын есім, сан есімнің) атын да, белгісін де, санын да атамай, тек солардың орнына қолданылады.	мен, сен, сіз, біз, сендер, сіздер және т.б.	t
189	Есімдік	Заттың атын, сынын, санын, я олардың аттарын білдірмейді, бірақ солардың (зат есім, сын есім, сан есімдердің) орнына жұмсалады. Есімдіктер белгілі бір түсінікті я ойды жалпылама түрде меңзеу арқылы білдіреді. Есімдіктердің нақтылы мағыналары өздерінен бұрын айтылған сөйлемге немесе жалпы сөйлеу аңғарына қарай айқындалады.   	мен, сен, сіз, біз, сендер, сіздер, олар, 	t
190	Есімдікті сөз тіркестері	Есімдіктер етістіктермен тіркескенде екі түрлі жағдайда кездеседі, біріншіден таза атау тұлғада етістіктермен тіркеседі, екіншіден түрлі көмекші сөздер арқылы етістікпен тіркеседі	түгел жиналды, әлдеқашан орналасты, ешқандай шықпады, қалай алып қалар, әлдеқашан төлеп қойған, әлденеше рет тоярсың	t
191	Есімдікті тіркестер	Есімдіктердің ішінде қабыса байланысқан есімді сөз тіркестерінің бағыныңқы сыңары болып жиі кездесетіндері – сілтеу, сұрау жəне жинақтау есімдіктері. Олар зат есімдермен тіркесіп, анықтауыштық қатынаста жұмсалады.	мына кітап, ана тау, осы қала, қай аудан?	t
208	Етістікті меңгеру	\N	терезені ашты, жайлауға шықты, қалтасынан алды, жолда жатты, түнімен жүрді	t
194	Есімшелі тіркестер	Зат есімдермен қабыса байланысатын сөздердің бір тобы. Есімшелердің зат есімдермен тіркесуі арқылы анықтауыштық қатынастағы есімді сөз тіркестері жасалады. 	орылған егін, жайнаған дала	t
198	Етістік	Заттың қимылын, амалын, жай-күйін білдіретін сөздер. Сөйлемнің баяндауыш, пысықтауыш қызметін атқарады.  Не істеді?   Не істейді? Не қылған? Деген сұрақтарға жауап береді. 	бар, күл, жаз 	t
201	Етістіктен етістік тудыратын жұрнақтпр 	Етістік негіздерінен арнаулы жұрнақтар арқылы жасалатын туынды етістіктер: -ла (-ле, -да, -де, -та, -те);-қыла (-кіле, -ғыла, -гіле);-мала (-меле, -бала, -беле, -пала, -пеле);-ғышта (-қышта, -кіште, гіште);-ыңқыра (-іңкіре, -ңқыра, -ңкіре);-ымсыра (-імсіре, -мсыра, -місре);-ыстрыр (-істір, -стыр, -стір);-ыс (-іс, е);-т;-тыр (-тір, -дыр, -дір);-қыз (-ғыз, -кіз, -гіз);-ыл (-іл, -л);-ын (-ін, -н)	атқыла, қарастыр, қанағаттандырылмағандықтан т.б.	t
203	Етістіктерден зат есім тудыратын жұрнақтар	Етістіктерден арнаулы жұрнақтар арқылы жасалатын туынды зат есімдер: ма(-ме,-ба,-бе,-па,-пе),  -м(-ым,-ім),-қы(-кі,-ғы,-гі), -ыс(-іс,-с), -у,-қ,-к (-ық,-ік,-ақ,-ек), -ынды(-інді,-нды,-нді),-ғыш(-гіш,-қыш,-кіш,-ыш,-іш,-ш,-уыш,-уіш), -қаш, -кеш, -ғаш, -геш, -мақ(-мек,-бақ,-бек,-пақ,-пек), -сын,-сін, -мыс(-міс,-мыш,-піш), -мал( -мел, -ман,-мен,-бан,-бен), -р(-ыр,-ір,-ар,-ер), -ыт(-іт,-т), -уыл(-уіл),-қын(-кін,-ғын,-гін), -асы,-есі, -ын(-ін,-н),-шақ(-шек,-ашақ,-ешек)	ту-ыс, қыр-ғыш, қи-ынды, жаз-мыш, қара-уыл	t
204	Етістікті қабысу	Қабыса байланысқан сөз тіркестері өзара ешқандай жалғаусыз, тек қатар тұру арқылы тіркеседі	жақсы оқиды, бүгін келдім, сылқ-сылқ күледі, оқығалы келіп отырмыз, бес ескерттім	t
205	Етістікті қабысу	Қабыса байланысқан сөз тіркестері өзара ешқандай жалғаусыз, тек қатар тұру арқылы тіркеседі/сөздердің бір-бірімен ешбір жалғаусыз, шылаусыз, тек іргелес тұру арқылы байланысу түрі	таңертең ашылады, қарқ-қарқ күлді, күлімсіреп сөйлеу,майда турады, бес-алты рет жөндейді,арыз бермекші, не алды?	t
206	Етістікті меңгеру	Сөздердің бағыныңқы бөлімі іліктен басқа септік  жалғауларының бірінде болатын байланысы	пішенді ору, баланы қара, сені байқамады	t
207	Етістікті меңгеру	Сөздердің бағыныңқы бөлімі іліктен басқа септік  жалғауларының бірінде болатын байланысы.	тауға шық, қаладан жібер, арқанмен түс, балаға қара, суға түс, жолдасыңа жібер	t
210	Етістікті сөз тіркесі 	Сөз тіркесінің құрамындағы сөздің екінші  басыңқы сыңары етістік болса, етістікті сөз тіркесі деп аталады.  	Үйге келу, жиналысқа қатысу, телефон арқылы сөйлесу, ерінбей еңбектену, ауланы тазалау, т.б.	t
211	Әрі жағымды, әрі жағымсыз эмоцияларды білдіретін	Әрі жағымды, әрі жағымсыз эмоцияларды білдіретін одағайлар.	1) бұл топтағы одағайлар әдетте көп мәнді болып келеді де, олардын мағыналары контекст ішінде не ситуацияда анықталады: пай-пай! Одағайы қарама-қарсы екі мәнде жұмсалады. А) таңдану, сүйсіну, таңырқау. Кәне, басыңа киіп көрші. Пай-пай қандай жарасады, ә?! (кәлменов). Пай-пай, шіркін, алатау, шандоз едің неткен сен! (сәрсенбаев).ә) ренжу, наразылық мағынасында - пай- пай, осы бір емізіп тартатының-ай! Айтпайсың ба camырлатып! (мұстафин). Ал, енді бұлар төбелесті, пай-пай, аяқтарының астында қаламыз-ау! (ә уезов).	t
212	Жағымды көңіл күйді білдіретін	Жағымды мағынаға ие одағайлар.	1) алақай! Ура! (қуаныш, шаттану), һа! Паһ- паһ! (сүйсіну, таңдану), бәрекелді! (сүйсіну, қоштау), оһо! (таңдану) т.б. Мысалы: тракторға теңеу таппай, жүрт абыржып, аузына келгенін айтты - паһ-паһ! Күйше күркіреуін қарашы! (мұстафин). Алақай! Ата! Апа!... Есбосындар келіп қалды! Соғыс бітті! (сланов). -оһо, жолдас болатын болдың (әбішев) т.б.	t
213	Жағымсыз эмоцияны білдіретін	Жағымсыз мағынаға ие одағайлар.	1) әттеген-ай! Әттең! Қап! (өкіну), тәйірі! Түге! (наразылык, іреніш), бай-бай-бай! (наразылық, кейістік), піш! Пішту! (жақтырмау, менсінбеу) т.б. Мысалы: қап, қазекеңе бақты суару керек деп айтайын деп отырып, ұмытып кеткенімді қарашы/(шамкенов). Уай, қайдасыңдар, түге, бар болғырлар! (сонда). Піш, тапқан екенсің қажырлы кісіні! (мұқанов). Бай-бай-бай, сорлы-ай, мені біреумен кетіп барады дейсің бе? Айтақтағалы барамын ғой... (қуанышбаев).	t
215	Жай (негізгі) шырай	Заттың белгісін, түсін (түрін), сапасын, көлемін, салмағын, аумағын, тағы басқа сондай негізгі сын-сипаттарын білдіретін сапалық сын есім жай шырай болып есептеледі.                                                                       	қызыл, ақ, сары, үлкен, семіз	t
216	Жай шырай	Заттың, іс-әрекеттің сапасын, түрін, түсін, салмағын, мөлшерін, көлемін, дәмін т.б. белгілерін көрсететін сын есімдер. Жасалу жолдары: ешбір қосымшасыз түбір және туынды сын есімдерден жасалады. 	ақ, ақылды, ауыр, биік, жеңіл, жұмсақ, жылдам, қызыл, өнімді, ұзын, ұтымды, үлкен, тәтті, тез, шабан, т.б.\n	t
218	Жай сөз тіркесі	Жай сөз тіркесінің құрамы екі сөзден ғана құралады. 	Орманды өлке, әдепті оқушы, асыққан жолаушы, екеуі кездесті, түсі қара, таулы өңір, тастақ жер, көпірден өту, әңгімелескен адам, т.б.	t
221	Жай шырай	Заттың белгісі я сипаты (түсі, түрі, сапасы, көлемі, аумағы, салмағы, сыры т. Б.) Біркелкі болмай, рең жағынан әр түрлі дәрежеде болатынын, демек, сипатының я белгінің бір затта артық, бір затта кем болатынын білдіретін сын есім формалары	жақсы, әдемі, қызыл т.б.	t
222	Жайылма сөйлем	Жайылма сөйлем тұрлаусыз мүше қатысқан сөйлем.	Жаңбыр қатты жауып тұр. 	t
225	Жақсыз сөйлем	Баяндауыштың бір өзі сөйлемге негіз болатын жай сөйлем. 	Оның айтқаны орындалды. Бір жерде \nкөргенім бар. Маратқа бәрін түсіндіруге тура келді., т.б.	t
226	Жақты сөйлем	Жақты сөйлем – бастауышы бар, жасырын тұрғанда да сұрақ қою арқылы табуға болатын сөйлем.	Мен ауылға бардым. 	t
227	Жақты сөйлем	Бастауышы бар, жасырын тұрғанда да баяндауыш арқылы табуға болатын жай сөйлем. \n	Арада шай қайнатымдай уақыт өтеді. Күтпестен ауылға көзі түсіп кеткен,\nОлжас сөзге қосыла кетті., т.б.	t
229	Жалаң сөз	Құрамында бір ғана негізгі түбір бар сөздерді айтамыз.	бас, қол, кітап, мал	t
230	Жалаң сөз	Құрамында түбір сөздер мен түбірге жұрнақ жалғану арқылы жасалған туынды түбір сөздер.	бас, бастық, басшы, басқар, басқарма деген сөздердің бәрі бірдей түбір сөздер емес, — түбірлес сөздер.	t
231	Жалаң сөйлем	Тұрлаусыз мүше қатыспайтын, тек тұрлаулы мүшеден ғана құралған сөйлем. 	Ойын қызық. Дал жылы. Көргің келеді, Күн салқындады., т.б.	t
232	Жалаң сөйлем	Жалаң тек тұрлаулы мүшелерден тұратын сөйлем.	Ол келді. Бала-шағасы толып кетті. 	t
236	Жалғаулық шылау	Өзара тең бірыңғай сөздердің, бірыңғай сөз тіркестерінің және бірыңғай сөйлемдердің араларындағы әр қилы қатынастарды білдіреді.                                      	мен, бен, пен, менен, бенен, пенен, да, де, та, те, және, әрі, бірақ, алайда, дегенмен, әйткенмен, сонда да, әйтпесе, әлде, біресе, кейде, яки, бірде, я, не, немесе, болмаса, не болмаса, я болмаса, себебі, өйткені, сондықтан, сол себепті.	t
237	Жалқы есім	Жеке я дара заттарға берілген, мағына жағынан белгілі бір ұғымды білдірмей, тек бір жеке дара затты басқа заттардан ажырату үшін қойылған белгі – ат ретінде ғана жұмсалатын зат есімдер.	• кісі аттары, мысалы: Абай, Әлжан, Берік, Мәлік, Сәкен, т.б.; \n• үй жануарларының аттары, мысалы: Құлагер, Таймас, т.б.; \n• өндіріс, мекеме, ұйым аттары, мысалы: "Жиһаз", "Мұнайлы", "Орда", "Алаш", "Қайрат" , т.б.; \n• газет, журнал, фильм, кітап аттары мен жеке шығармалардың аттары, мысалы: "Дат", "Жұлдыз", "Көшпенділер", "Қаһар" , т.б.; \n• географиялық атаулар, мысалы: Алатау, Ертіс, Жетісу, т.б.; \n• қала, көше, алаң аттары, мысалы: Алматы, Ақтау, Арқалық, Атырау, Түркістан, Шымкент, Желтоқсан көшесі, Жеңіс даңғылы, Республика алаңы, т.б.;\n	t
238	Көптік мәнді есімдер 	Затты жеке-даралап атамай, оның жиынын тобымен атайтын зат есімдер. \n	 айран, бу, түтін, тұман, ұн, тозаң, шаң, айла, алғыс, дау, қайғы	t
240	Жалқы зат есім	Белгілі бір ғана затты арнай, даралай атайтын зат есімдер. Жалқы есімдер мағына жағынан белгілі бір ұғымды білдірмейді, тек бір жеке-дара затты басқа заттардан ажырату үшін қойылған белгі - ат ретінде ғана жұмсалады.	Айгерім, Астана, Қазақстан, Бәйтерек, т.б.\n	t
242	Жалпы есім	Тілдегі әр алуан деректі және дерексіз заттар мен ұғымдарды білдіретін зат есімдер.	Ағаш, ауыл, ат, ас, арал, арба, өзен, тау, \nтемір, т.б.	t
244	Жалпылау есімдігі	Жинақтық мағыналарын білдіретін есімдіктің түрі.	Бәрі, барлық, бар, барша, бүкіл, күллі, бүтін, түгел, тегіс\n	t
245	Жалпылау есімдігі	Жалпылау есімдігі деп белгілі бір заттар мен құбылыстардың жиынтығына немесе толық қамтылуына нұсқай айтылатын жинақты - жалпылау мағынасындағы сөздерді айтамыз. 	бәрі, барлық, бар, барша, бүкіл, күллі, бүтін, түгел, тегіс	t
246	Жалпылауыш сөздер	Сөйлемнің бір мүшесі бірыңғай мүшелердің ортақ аты есебінде айтылуы. 	Қазақстан Алтайында қылқанды ағаштар : майқарағай, балқарағай самырсын, шырша өседі. 	t
247	Жанама толықтауыш	Барыс, жатыс, шығыс, көмектес септік тұлғаларындағы және, туралы, жөнінде, жайында шылауларымен тіркесіп келген сөздер тұлғасындағы толықтауыш.	Екі қарт кісімен амандастым. 	t
248	Жанасу	Сөздердің ешқандай жалғаусыз орын тәртібі арқылы алшақ тұрып, араға сөз салып байланысуы. Жанасу көбіне етістікті сөз тіркесі болып келеді, үстеу мен етістіктен, көсемше мен етістіктен құралады. 	қалықтап ұшу – қалықтап көкте ұшу, бүгін келу – бүгін үйге келу, енді айтты – енді екеуіне де айтты, т.б.	t
249	Жанасу	Сөз бен сөздің ешбір жалғаусыз, кейде алшақ кейде іргелес тұрып байланысуы. 	Телефон арқылы сөйлесу, үйге дейін бару, әдейі келу.	t
250	Жанасу	Бірқатар қабыса байланысатын сөздер сөйлемдегі орнын өзгертіп, өздері бағындыратын сөздерінен қашықтап тұруы.	Телефон арқылы сөйлесу, үйге дейін бару, әдейі келу.	t
251	Жанды зат есім	Кім? Деген сұраққа жауап беретін адамды не оның кәсібін білдіретін зат есімдер	бала, әке, түлкі	t
252	Жансыз зат есім	Адамнан басқа не? Деген сұраққа жауап беретін жанды-жансыз зат есімдер жатады. 	үстел, орындық, есік	t
253	Көмекші есімдер	Лексикалық мағыналары бірде бүтіндей сақталып, бірде солғындап, өзге сөздермен тіркесу ерекшеліктеріне қарай, синтаксистік жағынан кейде жеке-дара мүше есебінде, кейде күрделі мүшенің құрамындағы дәнекер элемент есебінде қолданылып, морфологиялық жағынан зат есімдерше түрленіп отыратын жәрдемші сөздер. 	алды, арты, асты, үсті, жаны, қасы, арасы, ортасы, іші, сырты, басы, беті, шеті, түбі, төбесі, маңы, тұсы.\n	t
255	Жатыс жалғаулы сөз тіркестері	1.Мекендік мағынадағы сөз тіркестері зат есімдер мен отыру, тұру, жүру, қараллу сиякты заттың күйін білдіретін етістіктерден не солар қатысты күрделі етістктерден құралады. 	Аппақ кең далада ауыл көсіле ұйықтап жатыр (Ғ.Мұстафин). 	t
256	Жатыс жалғаулы сөз тіркестері	2.Мезгілдік мағынадағы сөз тіркестерінің бағыныңқы сыңары шақ, мезгіл мəнді есімдер неесімдер тіркесі болады да, басыңқылары жоғарғыдай етістіктің бірі болады.	Оның бұл қылықтары Гүлнараға алғашқы кезде ұнамады.(С.Мұқанов). 	t
257	Жатыс септік	Бұл септіктегі сөздер негізінде көлемдік, мекендік және мезгілдік мағына береді. Осыған сәйкес, сөйлемде беретін мағынасына қарай жанама толықтауыш та, мезгіл пысықтауыш та, кейде орнына қарай, баяндауыш та болады.  	балада, үйде	t
258	Жатыс септік	Кімде? неде? қайда? деген сұрақтарға жауап береді.                                                                                                                     	Кімде? Балада; қайда? үйде.	t
259	Жедел  өткен шақ 	Жедел  өткен шақ етістіктің түбіріне -ды, -ді, -ты, -ті жұрнақтарының жалғануы арқылы жасалып, жіктеліп қолданылады. 	келді, ойнады т.б.	t
260	Жекеше жіктеу есімдіктері	Жекше түрдегі жіктік жалғауымен жасалады	Мен оқушымын, Сен оқушысың, Сіз оқушысыз, Ол оқушы	t
283	Зат есімді сөз тіркестері	Зат есімдер сабақты етістіктермен әрі мағыналық, әрі грамматикалық тығыз байланыста сөз тіркесін құрайды	жер жырту, бала оқыту, қымыз ішу, мылтық ату, сөз сөйлеу	t
261	Жетек сұрақты сұраулы сөйлем	Негізгі сұраққа жауап алу үстінде қосымша туған ойға байланысты сөйлем. Жетек сұрақты сөйлем толымсыз болып құралады, көбіне тек сұрақ мағыналы сөзден ғана тұрады. Жетек сұрақ ше шылауының қатысуымен жасалады.	– Іссапарға кімдер барады?\n– Жас қызметкерлер барады.\n– Біздер ше?\n	t
262	Жетекші етістік	Жетекші етістіктер толық лексикалық мағынаны, яғни қимыл атауын білдіреді. 	келе қалды дегенде жетекші етістік келу лексикалық мағынаны білдіріп тұр.	t
263	Жинақтық сан есім	Кемінде екі түбір морфемадан бірігу арқылы жасалған сан есімдер.	біреу, екеу	t
264	Жинақтық сан есім	Бірден жетіге дейінгі есептік сан есімдерге –ау, (-еу) аффиксінің қосылуы арқылы жасалады.                                                                                   	біреу, екеу, үшеу, төртеу, бесеу, алтау, жетеу	t
265	Жіктеу есімдігі	Белгілі бір заттық ұғыммен байланысты қолданылатын есімдіктің түрі.	Мен, біз, біздер,  сен, сіз, сендер,  сіздер, ол, олар	t
266	Жіктеу есімдіктері	Мен, сен, сіз, ол, біз (біздер), сендер, сіздер, олар деген сөздер жатады. Жіктеу есімдіктері сан жағынан аз болғанымен, қызметі жағынан есімдіктердің ішіндегі аса жиі қолданылатын тобы. Жіктеу есімдіктері үнемі жақтық ұғыммен байланысты келеді. Сол себептен олар ылғи адаммен байланысты, демек, сөйлеуші, тыңдаушы және бөгде кісі деген ұғымдармен байланысты қолданылады.        	мен, сен, сіз, біз, сендер, сіздер, олар	t
268	Жіктік 1 жақ жекеше	-м,-ым,-ім	Мен айттым, келдім	t
269	Жіктік 1 жақ көпше	-мыз, -міз	Біз айтамыз, келеміз	t
270	Жіктік 2 жақ жекеше	-сың, -сің, -ң	Сен айтасың, келесің	t
271	Жіктік 2 жақ жекеше (cыпайы)	-сыз, -сіз, -з 	сіз айтасыз, келесіз	t
272	Жіктік 2жақ көпше	-сыңдар, - сіңдер	Сендер айтасыңдар, келесіңдер	t
273	Жіктік 2жақ көпше (cыпайы)	-сыздар, -сіздер	Сіздер айтасыздар, келесіздер	t
274	Жіктік 3 жақ жекеше	-ды,-ді	ол айтады, келеді	t
275	Жіктік 3жақ көпше	-ды,-ді	олар айтады, келеді	t
279	Зат есім	Заттың, құбылыстың, оқиғаның атын білдіреді.	адам, табиғат, орман, жылқы	t
280	Зат есім	Тілдегі өзге сөздердің барлығына әрі ұйтқы, әрі өзек болып қызмет атқаратындықтан, әдетте, сөйлемнің барлық мүшелері ретінде қолданыла береді.  	адам, мектеп, табиғат	t
281	Зат есім	Құрылымы жағынан зат есім жалаң да, күрделі де болады. Жалаң зат есімдер екі салаға бөлінеді: біріншісі – түбір зат есімдер, екіншісі – туынды зат есімдер.                                                                                                                                                                                                                                                                                                   	адам, мектеп, табиғат	t
282	Зат есімдерден зат есім тудыратын жұрнақтар	Есімдерден арнаулы жұрнақтар арқылы жасалатын туынды зат есімдер: -шы(ші),-шылық(-шілік),-лық(-лік,-дық, -дік,-тық,-тік), -ыл(-іл,-л), -кер(-гер), -дақ(-дек, -лақ, -лек, -тақ, -тек),-кеш, -паз, -қор, -қой, -хана,-стан, -т(-ат,-іт,-айт,-ейт),-паң,-қал.	егін-ші, өнер-паз, кітап-хана, Қазақ-стан	t
277	Жұрнақ	Жалаң сөздерді жасау үшін қолданылады.	\N	t
285	Зат есімнен етістік жасайтын жұрнақтар 	Зат есімнен арнаулы жұрнақтар арқылы жасалатын етістіктер мына қосымшалардың көмегімен жасалады: ла (-ле, -да, -де, -та, -те);-лан (-лен, -дан, -ден, -тан, -тен);-лас (-лес, -дас, -дес, -тас, -тес);-лат (-лет, -дат, -дет); -а (-е); -ай (-ей, -й); -қар (-ғар, -кер, -гер);  -ал (-әл, -ыл, -іл, -л);  -сы (-сі);-мсы (-імсі); -сын (-сін); ; -ы, -і; -шы, -ші; -ан, -ен, -ын, -ін, -н; -ырқа, -ірке;-ырқан, -іркен; -ына, -іне;-қа, -ке, -ға, -ге;-ди, -тый, -ти	аяқта, тізгінде, шегеле, тақтайла; әдеттен, бұлттан; ақылдас, сабақтас; әндет, дауылдат; жаса, ойна, өрте; кұшей, көркей, қартай; суғар, ескер, аңғар; ұял, суал; адамсың, адалсың, ақылсың; байы; көпірші; шамырқан, иіске;	t
286	Зат есімнің рең мәнін тудыратын жұрнақтары	Зат есімдердің жұрнақтар арқылы рең мәні өзгерген зат есімдер: '- й -,- еке – ке – қа – а- е –, - тай –, - жан –, - қан-кен-қай-кей, ан-ң-, - шақ – шек –, - шық – шік –, - ша – ше –, - ш – ыш – іш –, - сымақ - екеш -,   -ақан , -шығаш, -шігеш	аға+й, әке+й, шеше+й\nағ+еке, Мұ+қа, Жә+ке\nаға+тай, әке+тай, апа+тай\nаға+жан, әке+жан, апа+жан\nбала+қай, шеше+кей\nқұлын+шақ, іні+шек\nқап+шық, төбе+шік\nсандық+ша, күрек+ше\nқалқа+ш, Нұр+ыш (Нұртай)\nбастық+сымақ, тас+ екеш	t
288	Ілік септік	Ілік септік меңгеру я меңгерілу жағынан тікелей етістікке қатыспайды, әрқашан соңғы тәуелдеулі есім сөзбен я субстантивтенген сөзбен байланысты болады. Осыған орай, атау формадағы әрбір сөзге жалғанатын ілік септіктің қосымшасы я меншікті (иелікті), я басқа бір қилы қатынасты білдіреді. 	баланың, үйдің	t
289	Ілік септік	Кімнің? ненің? деген сұрақтарға жауап береді.	Кімнің? Баланың; ненің? үйдің.	t
290	Кезектес салалас құрмалас сөйлем 	Іс-қимылдың кезектесіп келетінін білдіреді. Бірде, біресе, кейде жалғаулық шылауларымен байланысады. 	Біресе бұл-бұл нақышты, көп ырғақты «жиырма бесті» созады, бірде назды қоңыр, кең тынысты «Жанбота» шығады. 	t
291	Келер шақ	Мағыналары мен тұлғалық түрлеріне қарай, жалпы (анық) келер шақ, болжалды келер шақ және мақсататты (арнаулы) келер шақ деген үш топқа бөлінеді.                                                                                                              	қуан-ар-сың, жет-ер-сің, тоқы-р-сың, айтпа-с, сындырма-с, келтірме-с, өкпелетпе-с	t
293	Келер шақ көсемше 	-а, -е, -й   -ғалы,-гелі,-қалы,-келі, -ғанша,-генше,-қанша,-кенше жұрнақтары арқылы жасалатын көсемше. Қолдану ыңғайына қарай бұлформа  контексте осы шақ мәнін де, келер шақ мәнін де білдіреді. 	"келіп, ойнап, келгелі, ойнағалы, \nкелгенше, ойнағанша "\nкеле, ойнай т.б.	t
294	Кіріккен сөз	Компоненттердің біреуі, я екеуі де бірдей әуелгі өз мағыналарынан айрылып (делексикаланып), тұтасымен тұрып басқа бір жалпы мағына білдіретін және, сонымен бірге, сол компоненттері фонетикалық (дыбыстары, екпіндері) жағынан әр қилы өзгерістерге ұшырап, бір-бірімен белгілі дәрежеде әрі үндесіп, әрі ықшамдалып құралған күрделі сөзді айтамыз.                    	әкел (алып+кел), әпер (алып+бер), әкет (алып+кет), биыл (бұл+жыл), бүгін (бұл+күн), сәресі (сахар+асы), ағайын (аға+іні), қарлығаш (қара ала құс), білезік (білек+жүзік), сексен (сегіз+он), тоқсан (тоғыз+он), белбеу (бел+бау), қайтіп (қалай+етіп), түрегел (тұра кел), белуардан (бел+буардан), ендігәрі (ендігіден+әрі), ашудас (ащы+тас), сөйтіп (солай+етіп), өйтіп (олай+етіп), бірдеме (бір+неме), біресе (бір+ерсе), қолғанат (қол+қанат), қолғап (қол + қап), апар (алып +бар), түрегел (тұрып+кел), жаздыгүні (жаздың күні), күздігүні (күздің күні), қонақасы (қонақтың асы), Орынбасар (Орнын басар), Өмірзақ (Өмірі ұзақ) және т.б.	t
337	Күрделі сөз	Құрамында екі (я онан да көп) негізгі түбір бар сөзді айтамыз.     	 ата-ана, ауыл-аймақ, Сарағаш, Көкшетау, боз торғай, қара торы, он бес, ТМД, БҰУ	t
295	Кіріккен сөз	Кіріккен сөз – сыңарлары дыбыстық өзгеріске түсіп, біртұтас лексикалық мағына беретін сөздер.	қолғап (қол+қап), ендігәрі (ендігіден+әрі)  ашудас (ащы+тас), сөйтіп (солай+етіп), өйтіп (олай+етіп), қолғанат (қол+қанат), қолғап (қол + қап), апар (алып +бар), түрегел (тұрып+кел), қонақасы (қонақтың асы), Орынбасар (Орнын басар), Өмірзақ (Өмірі ұзақ) және т.б.	t
297	Көмектес септік	Бұл септік іс-амалдың құралы мен тәсілін, мекені мен мезгілін, ортақтасу, бірлесу, астасу, ұштасу сияқты жай-күй қатынастарын және басқа әр алуан мағыналарды білдіреді.	баламен, үймен	t
298	Көмектес септік	Кіммен? немен? деген сұрақтарға жауап береді.	Кіммен? Баламен; немен? үймен.	t
299	Көмектес септікті меңгеретін септеуліктер	Көмектес септік жалғауларында тұрған сөзбен тіркесіп қолданылады.	Бірге, қатар, қоса, қабат	t
300	Көмекші етістік 	Етістіктердің семантикалық және граматикалық мағынасын үстейтін етістік.	ал, бақ, бар, баста, бер, бол, біл, біт, жазда, жат, жөнел, жүр, жібер, де, еді, екен, емес, ет, кел, көр, қал, қой, қыл, отыр, өт, сал, таста, тұр, түс, шық. 	t
304	Көптік жалғау	Көптік мағына беретін қосымша. Көптік жалғауының дыбыс үндестігіне қарай алты варианты қолданылады: -лар, -лер, -дар, -дер, -тар, -тер.	қала-лар, көрші-лер, ғалым-дар, өзен-дер, ат-тар, шөп- тер	t
306	Көптік жалғауы	Нәрсенің көптігін білдіретін грамматикалық форма	бала-лар,  үй-лер, қыз-дар, мектеп-тер	t
312	көптік мәнді  зат есімдер	Затты жеке дара атамай, оның жиынын тобымен атайтын зат есімдер	сүт, ақыл, ұн, өмір	t
314	Көпше жіктеу есімдіктері	Көпше түрдегі жіктік жалғауымен жасалады	Біз үлкенбіз, Сендер үлкенсіңдер, Сіздер үлкенсіздер, Олар үлкен	t
317	Көсемшелі сөз тіркесі	Көсемшелер-синтаксистік қызметі жағынан етістіктің үстеуге бір түрі. Олар жіктік жалғауларын қабылдап, көсемшелік қасиетін жойып ала береді, бірақ көсемше тұлғаларында оқшау тұрып, күрделі мүшенің, мысалы, баяндауыштың құрамында, сонымен қатар толық мағыналы сөз ретінде етістікпен қабыса байланысып пысықтауыштық қатынаста да айтылады. Соңғы екі жағдайда да көсемшелік тұлғалар бір етістікті екінші етістікке бағынышты ететін қосымша қызметінде жұмсалады. Солай болатындықтан көсемшелер тек етістіктерге қатысты болып, тек етістіктермен ғана тіркесе алады. Олардың етістіктермен тіркескіштік қасиетін мынадан көруге болады; етістіктердің модальдық, шақтық, видтық т.б. мағыналарын түрлендіру үшін немесе əр түрлі пысықтауыштық қатынаста жұмсалу үшін етістіктер көсемше тұлғалары арқылы бірінің ұстіне бірі жамалып, өз ара қат- қабатала береді. 	Асықпай оқыды,-асықпай оқып отыр еді,-асықпай оқып кетіп бара жатыр еді; осылардың ішінде тек асықпай сөзі ғана пысықтауш мүше қызметінде дербес қолданылған да, қалған көсемшелер тұтас бір түйдекті тіркес құраған.	t
318	Көсемшелі сөз тіркестері	Көсемшелі сөз тіркестері пысықтауыштық қатынастарды, қимылдың амалын, мезгілін, мақсаттатын білдіреді	ұшып тұру, сызылып отыру, толтыра асау, шашып жеу, мүлгіп тыңдау	t
319	Күрделі анықтауыш 	Кемінде екі сөзден тұратын анықтауыш.	Қара торы ат ең бірінші келді. 	t
320	Күрделі атаулар төрт түрлі жолмен қысқарады:       	1.  Құрамындағы әрбір сөздің басқы әрпі алынады.    	ҰБТ, ТМД, БҰҰ т.б. Күрделі атаудың алғашқы әрпінен қысқарған сөздер бас әріппен, ал қосымшасы дефис арқылы жазылады. Мысалы: БҰҰ-ға, ҰБТ-да 	t
321	Күрделі атаулар төрт түрлі жолмен қысқарады:       	2. Күрделі атаудың бірінші сөздің басқы буыны қалған сөздердің алғашқы дыбысы алынып, қысқарады. 	ҚазҰПУ (Қазақ ұлттық педагогикалық университеті)	t
322	Күрделі атаулар төрт түрлі жолмен қысқарады:       	 3. Күрделі атаудың әрбір сөзінің басқы буыны қысқартылып бір сөз жазылады. 	ауатком (аудандық атқару комитеті). 	t
323	Күрделі атаулар төрт түрлі жолмен қысқарады:       	4. Күрделі атаудың бірінші сөзінің алғашқы буыны мен келесі сөз қосылып қысқартылады. 	пединститут, педколледж.     	t
324	Күрделі бастауыш 	Кемінде екі сөзден тұратын бастауыш. 	Кеншілер сарайы адамға лық толы. 	t
325	Күрделі баяндауыш	Күрделі баяндауыш екі немесе одан да көп сөзден тұрады. 	Бұл сөзге бәрі жамырай күліп жіберді. Дәмеш осы үйдің үлкені еді.	t
326	Күрделі баяндауыш 	Кемінде екі сөзден тұратын баяндауыш.	Ауыл мәдениеті өсіп келеді. 	t
328	Күрделі еліктеу сөздер	Жалаң еліктеу сөздердің я негізгі, я туынды формаларының не қайталануы, не қосарлануы арқылы жасалған түрлерін айтамыз.                                                           	бүрсең-бүрсең, дүр-дүр, гүрс-гүрс, жалп-жалп, арбаң-ербең, адыраң-едірең, шап-шұп	t
329	Күрделі есімдік	Екі түбір морфемадан құралған есімдік.	кімде-кім, өз-өзіне; бірігу арқылы: әрқашан, кейбіреу, әрне, әрқалай, әлдебіреу, әлдеқайдан, ешкі және т.б.​​​​​​​	t
330	Күрделі етістік	Бірнеше сөзден тұрады (синтаксистік тәсіл арқылы жасалу)	адам бол, қабыл ал т.б.	t
331	Күрделі зат есім	Кемінде екі я одан да көп түбір морфемадан құралған зат есімдер	ата-ана, ақтас, теміржол	t
333	Күрделі одағай	Бірнеше сөзден біріккен, қайталанған, қосарланған немесе басқа тілдерден ауысқан сөздер.	Мәссаған!, бәрекелді! Пай- пай, моһ-моһ, 	t
334	Күрделі пысықтауыш	Кемінде екі сөзден тұратын пысықтауыш. 	Мерей жымың-жымың етіп сахнаға шықты. 	t
335	Күрделі пысықтауыш	Күрделі пысықтауыш кемінде екі сөзден тұрып, бір сұраққа жауап береді. 	Бұл кезде ұшақ Алматыға келіп қонды. \nОл Атыраудан Алматы қаласына келді. Мен досыма көмектесу үшін ерте келдім.	t
336	Күрделі сан есім	Сан есімнің сұрақтары: неше? Қанша? Нешінші? Нешеу? Нешеден? Қаншадан?	он сегіз, мың тоғыз, бір-екі, үш-төрт, т.б.	t
338	Күрделі сөз	Сөздердің жай синтаксистік тіркесі емес, араларындағы синтаксистік қатынастарын жоғалтып, семантикалық мағынасы жағынан да, грамматикалық қызметі жағынан да тұтас бір бүтін тұлға (единица) ретінде қалыптасқан тіркес.   	тасбақа, асқазан, ата-баба, сексен (сегіз он), білезік (білек жүзік), қарлығаш (қара ала құс), бүгін (бұл күн), жаны ашу, қора-қора және т.б.	t
339	Күрделі сөз тіркесі 	Күрделі сөз тіркесі үш немесе одан да көп сөзден құралады. 	Әдепті оқушының мінезі, орманды өлкені аралау, асыққан жолаушыға жол көрсету, кездейсоқ кездескен екі достың әңгімесі, қара түсті ат мінген жолаушы, гүлге оранған өлке, тасыр-тұсыр шапқан ат, т.б.	t
340	Күрделі сөздер	Кемінде екі я онан көп дара сөзден (жалаң я туынды түбірлерден) құралып, ритм ырғақ жағынан бір ұдай, лексика-семантикалық жағынан біртұтас, лексика-грамматикалық жағынан бір бүтін тұлға болып бірлесіп тұрақталған құрама сөзді (я сөз тіркесін) айтамыз.                                                               	 ата-ана, ауыл-аймақ, Сарағаш, Көкшетау, боз торғай, қара торы, он бес, ТМД, БҰУ	t
341	Күрделі сөйлем мүшесі	Күрделі сөйлем мүшесі күрделі сөзден, тұрақты тіркестен не сөз тіркесінен, шылаулы сөзден құралады. 	Еңбек Ері Ыбырай Жақаев екі рет Алтын Жұлдыз медалімен марапатталған еді. Сөйлемдегі Еңбек Ері Ыбырай Жақаев – күрделі бастауыш, екі рет – күрделі пысықтауыш, Алтын Жұлдыз медалімен – күрделі толықтауыш, марапатталған еді – күрделі баяндауыш.	t
342	Күрделі сын есім	Бірігу, қосарлану және тіркесу арқылы жасалған сын есімдер	апалы-жезделі, мая-мая, жап-жасыл, аппақ, көкпеңбек, тәп-тәтті, тап-таяз, жұп-жуас, қоңыр ала, бидай өңді, торы төбел, тым ұзақ, қою қалың қара, ақ шулан, ақ шабдар, т.б.	t
343	Күрделі сын есім	Екі немесе одан да көп түбір сөздердің тіркесуінен, бірігуінен, қосарлануынан, қайталануынан немесе қарсы мәнділігінен құралған сын есімдер.	ала қасқа, ақ құба, аппақ, алакөк, көкала, ап-арық, беп-берекелі, биік-биік, бор-бор 	t
344	Қарсы мәнді сын есімдер	Мағыналары бір-біріне қарсы болатын, бір сұраққа жауап беретін дара сын есімдердің қосарлануынан жасалған күрделі сын есімдер. Қарсы мәнді сын есімдер дефис “-” арқылы жазылады.	Ағалы-інілі, алыс-беріс, ақ-қара, апалы-сіңлілі, ашық-жабық, ащы-тұщы, ашық-жабық,, берекелі-берекесіз, дұрыс-бұрыс, жақсылы-жаманды, көңілді-көңілсіз, қызықты-қызықсыз, \nоңды-солды, оң-теріс, сауатты-сауатсыз, үлкен-кіші.	t
345	Күрделі толықтауыш	Кемінде екі сөзден тұратын толықтауыш. 	Олар аттардың қара торысын таңдап алды. 	t
347	Күрделі үстеу	Екі не одан да көп түбірдің немесе сөздің бірігіп, тіркесіп немесе қосарланып тұрақтануынан жасалады.	Таңертең, жаздыгүні,  бостан-бос, жоғары-төмен	t
348	Күшейткіш демеуліктер	Күшейту мәнін беру үшін қолданылатын демеуліктер.	-ақ,-ау,-ай,да,де,әсіресе, та, те	t
349	Күшейткіш үстеуі	Қимылдың, іс-әрекеттің, сынның сапасын, белгісін не солғындатып, не күшейтіп көрсетеді. Сұрағы: қалай?	Әбден, керемет, мүлдем,   ең, өте, аса, тым, кілең	t
350	Күшейтпелі шырай	Бір заттың сынын екінші заттың сынына салыстырып, сол салыстырылатын белгілердің бір-бірінен я кем, я артық екенін білдіреді.	әп-әдемі, жып-жылы, сеп-семіз, тап-таза, үп-үлкен	t
351	Күшейтпелі шырай	Сын есімнің күшейтпелі шырайы негізгі сын есімдерге күшейткіш буынды үстеу арқылы жасалады.  Қазақ тілінде күшетпелі шырай дефис‘-’ арқылы жазылады. 	ап-анық, әп-әдемі, жеп-жеңіл	t
352	Күшейтпелі шырай	Күшейтпелі шырай сапалық сын есімдерге өте, тым, аса, ең, тіпті, нағыз, орасан, өңшең, кіл, кілең күшейткіш үстеулерінің тіркесуі арқылы жасалады. Бұл күшейткіш үстеулер сапалық сын есімнің алдынан бөлек жазылады. 	өте әдемі, тым биік, аса терең, ең мықты, тіпті ұзақ, нағыз шешен, орасан шыдамды, өңшең жүйрік, кілең күшті, т.б.	t
353	Күшейтпелі шырай	Заттың бастапқы сындық қасиетін күшейте түседі. Бұл шырай негізгі сын есімдерге күшейткіш (үстеме) буынды қабаттастыру арқылы жасалатын өте өнімді форма.	әп-әдемі, жып-жылы, сеп-семіз, тап-таза, үп-үлкен, көкпеңбек	t
354	Күшейту (я ұлғайту) үстеу	Заттың сынын, қимылдың өзін немесе түрлі мөлшерін, көлемін я аса күшейтіп, я аса солғындатып көрсетеді де, қалай? қандай? деген сұрауларға жауап береді.                                                                                     	Тым, өте, ең, тіпті, әбден, мүлдем, нағыз, керемет, аса, өңкей, кілең, орасан, ылғи, сәл, нақ, ерен, дәл.	t
356	Қабысу	Сөз тіркесінің бағыныңқы сыңарының басыңқымен жалғаусыз, қатар тұру арқылы байланысы	Дарақ күрек, отыз кітап, қызыл орамал, бұл үй, ол кім, қанша үлкен, бұл кішкентай, жез құман, т.б.	t
357	Қабысу	Сөздердің ешқандай жалғаусыз іргелес тұрып байланысуы.	Дарақ күрек, отыз кітап, қызыл орамал, бұл үй, ол кім, қанша үлкен, бұл кішкентай, жез құман, т.б.	t
358	Қайталама қос сөздер	Белгілі бір сөздің я қосымшасыз, я қосымшалы түрінің екі рет қайталануы арқылы, я сол сөздің не бір (я бірнеше) дыбысының немесе бір буынының өзгеріп қайталануы арқылы жасалады.   	тау - тау астық, көре-көре көсем боласың, көзбе-көз айтты, ауыл-ауылды аралады және т.б	t
359	Қайталанған одағай	Екі одағай сөздің қайталануы арқылы жасалатын.	Пай- пай, моһ-моһ! Шөре-шөре! Сарап-сарап! Қос-қос/кәуіс-кәуіс! Шәуім-шәуім! Әукім-әукім!	t
360	Қайталану арқылы жасалатын күрделі еліктеу сөздер	Амал әрекеттің үсті-үстіне әлденеше рет қайталанып жасаланатынын білдіреді.	Маң - маң, гүр - гүр, дір - дір, қорқ-қорқ, сырт-сырт, дар-дар, тарс-тарс т.б.	t
361	Қалау рай	Сөйлеушінің белгілі бір амалды я әрекетті жүзеге асыруға бағытталған ниетін, ынта-тілегін, үміт-арманын білдіреді, -ғы (+м, +ң) сы кел; -са игі еді; ғай еді; -са екен осымшасының көмегімен жасалады. 	келгісі келді, ойнаса екен т.б.	t
362	Қалау рай	Сөйлеушінің белгілі бір амалды я әрекетті жүзеге асыруға бағытталатын ниетін, ынта-тілегін, үміт-арманын білдіреді.                       	сұра-ғы-сы келді, айт-қы-сы келмеді, демал-ғы-м келді, жүр-гі-м келмейді, байқа-ғай-сың, жеткіз-гей-сің, тапсырт-қай-сың, тезірек келсе ғой, аман-есен жетсе игі еді	t
363	Қаратпа сөз	Біреуге арналып айтылған сөйлем оның кімге арналғанын білдіретін сөз не сөз тіркесі болуы мүмкін.	 Жолдастар, коммунизм құрылыстарын салуға кірісіңдер!	t
364	Қарсылықты бағыныңқылы сабақтас құрмалас сөйлем	Жай сөйлемдерінің бағыныңқысы басыңқысына қарама-қарсы болып келеді. Сұрақтары: қайтсе де?, қайткенмен?, не етпестен?, не еткені болмаса? Жасалу жолдары: -ғаны, -гені, -қаны, -кені, -а, -е, -й, -ғанша, -генше, -қанша, -кенше, -са да, -се де.	Қыс келсе де, қар жаумады.  	t
365	Қарсылықты мәнді жалғаулықтар	Бұрынғы сөйлемде айтылған ойға, соңғы сөйлемдегі ойдың мағына жағынан қарама-қарсы екенін аңғартуға дәнекер болатын жалғаулықтар.	бірақ, алайда, дегенмен, әйтсе де, сөйтсе де, бірақ та, әйтпесе, әйткенмен, әйткенде, әйтпегенде, сонда да	t
366	Қарсылықты салалас құрмалас сөйлем	Жай сөйлемдердің мағыналары бір-біріне қарама-қарсы болып келеді. Бірақ, дегенмен, сонда да, сөйтсе де, әйтсе де, алайда жалғаулық шылауларымен байланысады.	Есікті жауып қойған, сонда да ол ішке кірер үмітін үзбеді. 	t
367	Қатыстық сын есім	Заттың сын-сипатын, әртүрлі белгісін басқа сөз табының қатысы арқылы білдіретін сын есім	орманды алқап, гүлді өңір, алмалы бақ, әдепті қыз, қасиетті адам, құдіретті сөз, ақылды бала, дәмді тағам, өнерлі оқушы, салмақты мінез, шөлейт дала, шексіз аспан, т.б.	t
368	Қатыстық сын есім	Бір заттың белгісін басқа бір заттың я іс-амалдың қатысы арқылы білдіретін сөздерді айтамыз.                                                                                 	орманды алқап, гүлді өңір, алмалы бақ, әдепті қыз, қасиетті адам, құдіретті сөз, ақылды бала, дәмді тағам, өнерлі оқушы, салмақты мінез, шөлейт дала, шексіз аспан	t
369	Қимыл-сын бағыныңқылы сабақтас құрмалас сөйлем	Сөйлемнің бағыныңқы жай сөйлемі басыңқы жай сөйлемдегі іс-әрекеттің, қимыл-қозғалыстың қалай болғандығын білдіреді. Сұрақтары: қайтіп?, не етіп?, қалай? Жасалу жолдары: -а, -е, -й, -ып, -іп, -п, -ған, -ген, -қан, -кен, -дай, -дей. 	Екі қолы дірілдегендей болып, Оспан ішке кірді. 	t
372	Қиысу	Сөз бен сөздің жіктік жалғаумен жақ жағынан үйлесе байланысқан түрі.	Мен келемін, оқушы оқыды, балалар \nжүгірді, т.б.	t
373	Қиысу	Сөз бен сөздің жіктік жалғауы арқылы немесе жіктелу ретімен бастауыштық және баяндауыштық қатынаста жақ жағынан үйлесе байланысқан түрі. 	Мен оқимын (І жақ), сен оқисың (ІІ жақ), олар келеді (ІІІ жақ), біз дайындаламыз (І жақ көпше).	t
374	Қиысу 	Синтаксистік байланыстың көп қолданылатынт түрі. Қиысуда  сөйлемдегі бағыныңқы мүше басыңқы мүшенің грамматикалық тұлғасына не грамматикалық мақынасына қарай тұлғаланады.	Мен көрдім ұзын қайың құлағанын деген сөйлемде мен көрдім – қиыса байланысқан сөздер. Онда мен деген бастауыштың I жақтық грамматикалық мағынасымен үйлесіп, көрдім деген баяндауыш та бірінші жақтық жіктік жалғауда айтылған. Сіздер талапты жеткіншектерсіздер дегенде, баяндауыш сіздер деген бастауыштың II жақтық грамматикалық мағынасына жəне –дер деген грамматикалық тұлғасына қарай, дəл сондай жалғауларда айтылып қиысып тұр.	t
375	Қос сөз	Екі сөз қосарланып, бір лексикалық мағынада айтылған айтылған сөз тұлғасы. Қос сөздердің құрамындағы компоненттер я бір сөздің өзінің ешқандай өзгеріссіз қайталануынан, я оның бір сыңарының, не бір буынның, не бір дыбысының өзгеріліп жамалуынан құралады немесе морфологиялық жағынан бір тектес я синоним, я антоним сөздерден салаласып құралады.  	Жан-жануар, ата-ана, үй-үйге, сарт-сұрт, мая-мая және т.б.	t
376	Қос сөз	Қос сөздер  тұлғасына қосымшасыз қос сөз деп жіктеледі.                                                                            	ата-ана, ине-жіп, тарс-тұрс т.б.                                                                                                                                     	t
377	Қос сөз	Қос сөздер  тұлғасына қарай қосымшалы қос сөз деп жіктеледі.                                                                                                                                                                                     	бет-бетіне, балалы-шағалы, қолма-қол, т.б. 	t
378	Қос сөз	Қос сөздер  тұлғасына қарай күшейтпелі буынды қос сөз деп жіктеледі.                                                	үп-үлкен, жап-жақсы,   қып-қызыл.                              	t
380	Қосарлама қос сөздер	Лексикалық мағынасы басқа-басқа екі түрлі сөзден құралады.                                                	аяқ - табақ, құрт-құмырсқа	t
381	Қосарланған  одағай	Екі одағай сөздің қосарлануы арқылы жасалатын.	Пай- пай, моһ-моһ! Шөре-шөре! Сарап-сарап! Қос-қос/кәуіс-кәуіс! Шәуім-шәуім! Әукім-әукім!	t
382	Қосарланған зат есім	Екі түбір морфемадан қосарланып жасалған зат есімдер 	Бала-шаға, ата-ана	t
383	Қосарланған зат есім	Екі түбір морфемадан қосарланып жасалған зат есімдер жатады.      	Көрпе-жастық, жігіт-желең, ата-ана, дәрі-дәрмек	t
384	Қосарланған сан есім	Негізгі есептік сан атауларына сан есімнің мағыналық түрлерін жасайтын -ыншы, -інші, - ау, -еу, -ер, - тай жұрнақтары жалғануы арқылы жасалады	бір-екі, бес-алты т.б.	t
385	Қосарланған сын есім	Қосарлану арқылы жасалған сын есімдер	қып-қызыл, қоп-қоңыр, ұсақ-түйек, қоғамдық-саяси т.б.	t
386	Қосарланған үстеу	Сөздердің қосарлануы мен қайталануы арқылы жасалған.	Бостан-бос, жоғары-төмен	t
387	Қосарлану арқылы жасалатын күрделі еліктеу сөздер	Мағына жағынан бір-біріне жақын, синонимдес, екі түрлі еліктеуіш сөздің қосарлануы.	Тарс-тұрс, былқ - сылқ, жарқ-жұрқ, сатыр-күтір, салдыр-күлдір, бұрқ-сарқ т.б	t
388	Қосарлы айқындауыш  мүшелер	Алдыңғы сөзі соңғы сөзін анықтайтын, орын аусытырса да, мағынасы бұзылмайтын, тек қызметі ауысатын сөздер.	Ер Төлеген – Төлеген ер	t
394	Құранды	Бірінші компоненті (есім) негіз болса, екінші компоненті (көмекші етістік)	алып кел, барып қайт т.б.	t
398	Қысқарған зат есім	Бірнеше сөзден құралып қысқарған зат есімдер.	ҚР, БҰҰ, ҚазМҰУ, пединститут, см, мм, га, Кб, Мб 	t
399	Қысқарған зат есімдер	Бірнеше сөзден құралып қысқарған зат есімдер жатады.                            	Ұжымшар, БҰҰ, пединститут, медбике	t
400	Қысқарған сөздер	Күрделі атаулар тілде жиі қолданылатын болғандықтан, оларды айтуға, жазуға жеңілдету мақсатымен ықшамдап қолданылады. Осындай сөздер қысқарған сөздер деп аталады. 	ҚР, БҰҰ, ТМД, ҚазҰУ, ҚарМУ, ҚазҰПУ, ТУ-104, ДТ- 54, ЯК-40 және т.б.	t
401	Қыстырма сөз	Сөйлемде айтылған ойға, оның айтылу амалына жазушының, сөйлеушінің қалай қарайтынын білдіретін сөздер.	Көп білім алу үшін, əрине, көп оқу керек.	t
404	Лепті сөйлем	Айтушының түрлі көңіл күйін білдіру мақсатында айтылған сөйлем лепті сөйлем деп аталады.	Көзі мұндай өткір болар ма! Пай-пай, дауыс деп осыны айт! Уһ, жеттім ғой ақыры!	t
406	Мақсат мәнді келер шақты есімше 	“-мақ, -мек”, “-пақ”, “-пек” жұрнағы алда жасалатын істі мақсат етуді білдіреді.	келмек, ойнамақ т.б.	t
407	Мақсат үстеуі	Іс-әрекеттің, қимылдың орындалу мақсатын білдіреді, не мақсатпен? қалай? деген сұрақ қойылады. 	Әдейі, қасақана, жорта, әдейілеп	t
408	Мақсатат бағыныңқылы сабақтас құрмалас сөйлем	Бағыныңқы компоненті басыңқы компонентіндегі іс-әрекеттің, ойдың мақсататын білдіреді. Сұрақтары: не мақсататпен?, не үшін?, не етпек болып? Жасалу жолдары: -мақ, -мек, -пақ, -пек, -бақ, -бек; -у + үшін, -қы, -кі + тәуелдік жалғау. 	Аяғымның сырқырағаны басылар ма екен деп, ол тізесін отқа қыздырды. 	t
410	Мақсатат үстеу	Қимылдың мақсататын білдіреді. мақсатат үстеулері – өзге топтарға қарағанда сан жағынан өте аз топтың бірі. Оған әдейі, әдейілеп, жорта, қасақана деген сөздер жатады.                                                                                          	Қасақана, әдейі, жорта, әдейілеп.	t
411	Мақсататты (арнаулы) келер шақ	Амал-әрекеттің алдағы уақытта шүбәсыз, күдіксіз (қайткенде де) жүзеге асатынын және онда бір мақсатат барын қоса білдіреді. Бұл форма етістік негізіне есімшенің мақсататты келер шағының –мақ, -мек, -бақ, -бек, -пақ, -пек жұрнағы жалғану арқылы, кейде соңғы жұрнақтың үстіне –шы дәнекері қосылу арқылы жасалады.  	бар-мақ-шымын, кел-мек-шімін	t
412	Мақсатты келер шақ	Іс- қимылдың мақсатын білдіреді, - мақ/-мек, -ғалы,-гелі,-қалы,-келі, -ғанша,-генше,-қанша,-кенше қосымшалары арқылы жасалады. 	келмек, ойнамақ т.б.	t
413	Малға, үй хайуандарына бағышталып айтылатын одағайлар	Үй хайуандарын шақыру, айдау, үркіту, қорғау мақсатымен қолданылатын сөздер мен одағайлы тіркестер жатады.	1) бұл топқа айтақ, моһ-моһ! Шөре-шөре! Сарап-сарап! Қос-қос/кәуіс-кәуіс! Шәуім-шәуім! Әукім-әукім! Мәлік келгір! Жамандатқыр! Сияқты бағаң алақанын бір-біріне ұрып: моһ-моһ деп еді, етекке қарай желе жөнелді (бөкеев). Әукім - әукім, ақ бұзау, ертерек өс, құтты бол!.. Сиыр бол да, сүтті бал! (тұрманжанов) қоянның ышқына қашқанын қызық көріп «айтақ, айтақ!» деп айқай салды (хангелдин) т.б.	t
414	Матаса байланысқан сөз тіркестері	Матасу – қиысу, меңгеру сияқты синтаксистік байланыс формаларының бірі. Ол изафеттік құрылыстағы сөз тіркесінің байланыс формасы; Бұл сөз тіркестерінің бірінші сыңарлары ілік жалғауда, екінші сыңарлары тəуелдік жалғауда айтылған.	Омарбектің інісі, ағаштың бұтағы, біздің табысымыз. 	t
415	Матасу	Сөз тіркесінің құрамындағы бағыныңқы сөздің басыңқыға жəне басыңқының бағыныңқыға қарай тұлғаланып байланысуы. Осылайша бірімен-бірі қарама-қарсы, матаса байланысатын сөздердің бірі ілік жалғауда, екіншісі тəуелдік жалғауда айтылады. 	Ағаштың бұтағы, сенің кітабың, колхозшылардың табысы	t
416	Матасу	Сөздердің бірі ілік септік жалғауында, екіншісі тәуелдік жалғауында болып байланысуы. 	Ауылдың баласы, қызылдың түрі, біздің кітап, оның аты, т.б.	t
419	Мезгіл үстеу	Қимылдың жалпы мерзімін я дәлді мезгілін білдіреді де, қашан? қашаннан? сияқты сұрауларға жауап береді.                                                           	Бүгін, былтыр, биыл, таңертең, бүрсігүні, қыстан бері, ала жаздай, күні-түні, ендігәрі, күндіз, бағана, таң сәріге дейін, енді, қазір, әлгінде, ежелден, кеше.	t
420	Мезгіл үстеуі	Қимылдың, іс-әрекеттің мезгілін, мерзімін, уақытын білдіреді. Сұрағы: қашан? Қашаннан? 	Таңертеңнен, жазғытұрым, ала жаздай, күні-түні	t
422	Мекен үстеу	Қимылдың орнын (мекенін), бағытын білдіреді де, қайда? қайдан? деген сұрауларға жауап береді.             	Кейін, алдыға, артқа, әрі-бері, ілгері-кейін, әрмен қарай, тысқары, төменнен, жоғары-төмен, алдыдан.	t
423	Мекен үстеуі	Қимылдың, іс-әрекеттің орындалатын орнын, мекенін көрсетеді. Сұрағы: қайда? Қайдан? Қалай? Қарай? 	Тауға қарай, алға , ілгері-кейін, жоғарыдан	t
424	Меңгеріле байланысқан есімді сөз тіркестері	Меңгеріле байланысатын сөз тіркестерінің ерекшелігін олардың құралу тұлғасынан қарап айырамыз. Олар барыс, шығыс, табыс жатыс, көмектес жалғауларының бірінде болады да, басыңқы сөз сол жалғаудағы сөзді керек ететін етістік не есім болады. Осыдан меңгеріле байланысқан сөз тіркестері жасалады. Меңгеруші сөз жетектеуші де, меңгерілуші оның жетегіне еруші сөз болады. Септік жалғаулары сөзбен сөзді байланыстырумен қатар, түрлі-түрлі синтаксистік қатынасты білдіреді. 	барыс септігіндегі сөз беталысты, бағытты, мақсататты, мезгілді т.б. білдіреді.	t
427	Меңгеру	Сөз тіркесіндегі бағыныңқы сөздің басыңқымен мағыналық үйлесімі негізінде септік жалғауларының (іліктен басқа) бірінде тұрып байланысуы: меңгерілетін сөз табыс, барыс, шығыс, жатыс, көмектес жалғауларының бірінде тұрады да, меңгеретін сөз етістік, есім не сол екеуінің ортақтасқан тобы болады. 	Ұйымға мүше, өзіңе үлгі, елге жақсы, өзіңе өзің, т.б.	t
428	Меңгеру	Сөздердің бағыныңқы бөлігі ілік септіктен басқа септік жалғауларының бірінде болатын байланысы. 	Ұйымға мүше, өзіңе үлгі, елге жақсы, өзіңе өзің, т.б.	t
438	Мөлшер үстеу	Түрлі қатынастарды я жалпылап, я мөлшерлеп немесе қимылдың және сынның я теңдік, я кемдік дәрежесін білдіреді де, қанша? қаншалық? нешелеп? қаншалап? сияқты ғана сұрауларға жауап береді.                               	Қыруар, біршама, әжептәуір, неғұрлым, мұншама, соншалық, әжептәуір, мұнша, сонша, бірталай, көп.	t
439	Мөлшер үстеуі	Сынның немесе қимылдың көлемдік дәрежесін, мөлшерін, шама-шарқын білдіреді. Сұрағы: қанша? Қаншама? Қаншалық? Қаншалап?	Сонша, біршама, недәуір,  сонша, біршама	t
440	Нақ осы шақ	Іс- әрекет не қимылдың сөйлеп тұрған нақ сәтінде болуын білдіреді,  отыр, тұр, жатыр, жүр етістері арқылы жасалады.	келіп тұр, ойнап жүр	t
441	Нақ осы шақ	Көсемшенің өткен шақ (-ып, -іп, -п) және осы шақ (-а, -е, -й) түріндегі етістік формасына жатыр, жүр, тұр, отыр деген жай-күй етістіктерінің біреуі тіркесу арқылы жасалады.                                                                          	оқып отыр, күліп тұр, ойнап жүр, ұйықтап жатыр	t
442	Нақтылық	Жеке сөздер мен сөз тіркестерінің мағыналарын, сөйлемде айтылатын ойды нақтыландыра, тұжырымдай түсу үшін қолданылатын демеуліктер.	Қой, ғой, ды,ді, ты, ті	t
430	Морфема	Сөздің лексикалық я грамматикалық мағыналарын білдіретін  бөлшектері.	\N	t
446	Негізгі  зат есім	Түбірге және жұрнаққа бөлшектенбейтін, тек бір ғана түбір морфема ретінде қабылданатын заттық атаулар	бала, ана, ата,әке	t
447	Негізгі  түбір есімдік	Бір ғана түбірден жасалған есімдік.	мен, сен, сіз, біз, сендер, сіздер 	t
448	Негізгі еліктеу сөздер	Айналадағы табиғат құбылыстарын құлақпен есту арқылы қабылданған дыбыстардан және көзбен көру арқылы қабылданған елес-көріністердің бейнелерінен пайда болған түсініктердің атаулары, сол дыбыстар мен бейнелердің атаулары есебінде қызмет ететін түбір сөздер.	Дүрс, ар, морт, солқ, гүрс, ырс, күмп, саңқ, шалп, лып, бырс т.б.	t
449	Негізгі еліктеу сөздер	Айналадағы табиғат құбылыстарын құлақпен есту арқылы қабылданған дыбыстардан және көзбен көру арқылы қабылданған елес-көріністердің бейнелерінен пайда болған түсініктердің атаулары, демек, сол дыбыстар мен бейнелердің атаулары есебінде қызмет ететін түбір сөздерді айтамыз.                                                                                    	дүңк, тырс, дік, жылт, шаңқ, қарқ, дүрс, арс, шарт, пыр, шиқ, жалп, жарқ, шіңк, бүлк, тарс, қиқ	t
451	Негізгі сан есім	Күшейтпелі буынның тіркесуі болып табылады, ол сын есімнің бастапқы буынының қысқарып, оған -п дыбысының жалғануы арқылы жасалады .	бір, екі, үш, төрт, бес т.б.	t
452	Негізгі сұрақты сұраулы сөйлем	Бір нәрсе, оқиға, іс туралы мәлімет алу үшін қойылған бастапқы сұрақты сөйлем. Негізгі сұрақ сұрау есімдіктерінен және ма, ме, ба, бе, па, пе, ше шылауларының қатысуымен жасалады.	Бізбен бірге саяхатқа барасың ба? Қазақтың қандай ұлттық аспаптарын білесің? Балаңыз мектепті қашан бітірген? Бұл сөзбен не айтпақсыз?	t
453	Негізгі сын есім	Ешбір қосымшасыз негізгі түбір күйінде жұмсалатын сын есім	Ақ, көк, жақсы, қызық	t
455	Негізгі түбір сын есім	Негізгі сын есім ешбір қосымшасыз негізгі түбір күйінде болады. 	ақ, әсем, көк, сыпайы, кермек, жабайы, таза, шабан, асау, жеңіл	t
456	Негізгі үстеу	Түбірге және қосымшаға бөлшектеуге келмейді.	Жылдам, тез, ақырын, кеш	t
457	Негізгі үстеулер	Қазіргі кезде морфемаларға бөлшектеуге келмейтін, тек белгілі бір формада қалыптасқан сөздерді айтамыз.                                                                	ерте, тез, жоғары, қазір, жылдам, шапшаң, кеш	t
458	Одағай	Одағай сөздер мағына жағынан заттың (субстанцияның) өзі туралы да, сыны, саны, қимылы туралы да, қимылдың жайы-күйі туралы да ұғым бермейді. 	Cұрақ қойылмайды	t
459	Одағай	Ойды көріктендіріп, ырғақпен (интонация) айтылатын сөйлем емес, бірақ сөйлемге балама ретінде қолданылатын сөздер.	1. Көңіл күй одағайлары шаттану, таңырқау, ренжу, өкіну, қуану мәнінде қолданылады: пәлі, алақай, пай-пай, уһ, әттеген-ай, қап.\n2. Жекіру одағайлары тыйым салу, жекіру мәнінде айтылады: тәйт, тек, жә.\n3. Шақыру одағайлары хайуанаттарды, жан-жануарларды қуу, шақыру мәнінде жұмсалады. Жылқыға қатысты құрау-құрау, моһ-моһ; сиырға қатысты ауһау-ауһау, әукім-әукім; қойға қатысты пұшайт-пұшайт; түйеге қатысты көс-көс; ешкіге қатысты шөре-шөре; итке қатысты кә-кә, айтақ-айтақ; мысыққа қатысты пырс, т.б. одағайлар қолданылады.	t
461	Одағай сөздер	Кісінің сезімін, көңіл күйін, еркін білдіретін, дербес грамматикалық тұлғалары жоқ сөздер.	Уа, қой, деймін, бала! Мə-ə-ə, онысы несі?!	t
462	Одағайдан етістік жасайтын жұрнақтар  	Одағайдан арнаулы жұрнақтар арқылы жасалатын етістіктер: ла (-ле, -да, -де, -та, -те);    -ра (-ре, -ыра, -іре);-ырай (-ірей); -ы, -і; -шы, -ші; -ан, -ен, -ын, -ін, -н; -ырқа, -ірке;-ырқан, -іркен; -ына, -іне;-қа, -ке, -ға, -ге;-ди, -тый, -ти	аһла, үһле, ойбайла, аухаула;	t
454	Негізгі түбір	Сөздің басқа сөзге бөлшектеуге келмейтін ең негізгі тұлғасы.	\N	t
468	Ортақ меңгеру	\N	айтуға тілім жетпейді, сөзін мақұл көрдік, жұртқа күлкі болғанмен, маған күлкі емес	t
465	Оңашаланған айқындауыш мүшелер 	Өзінен бұрын айтылған сөзді айқындап, дәлелдеп түсіндіретін бір я бірненше сөз. 	Мені, Хворостякинді билемек болады. 	t
466	Ортақ етіс	 Қимыл, іс-әрекеттің иесі, орындаушысы біреу емес, бірнешеу болатын етіс. -ыс (-іс, е) қосымшаларының көмегімен жасалады. 	тарас, жинас т.б.	t
467	Ортақ етіс	–с, (-ыс, -іс) жұрнағы арқылы негізгі етіс формасынан (етістік негізінен) жасалады. Бұл жұрнақ негізгі етістікке амалды (істі) кемі екі я онан да аса субьекті қатысып жүзеге асыратындықты білдіретін мән үстейді, демек, бірнеше субьектінің қатысы арқылы жүзеге асатын амалды білдіреді.                                                        	Орысты, тазаласты, көтерісті	t
469	Осы шақ	Іс-әрекет пен қимылдың сөйлеп тұрған сәтте орындалып жатқанын білдіреді	Жұрт ойынмен болып жатыр. 	t
470	Осы шақ	Сөйлесіп отырған (диалог) уақыт бойында болатын я болып жататын амал-әрекетті суреттейді.                                                                                          	оқып отыр, күліп тұр, ойнап жүр, ұйықтап жатыр	t
471	Осы шақ көсемше	-а, -е, -й жұрнақтары арқылы жасалатын көсемше. Қолдану ыңғайына қарай бұлформа  контексте осы шақ мәнін де, келер шақ мәнін де білдіреді. 	келе, ойнай т.б.	t
472	Өзгелік етіс	Қимылдың, іс-әрекеттің сөйлемдегі іс иесі яғни субъектінің өзі емес, екінші бір басқа субъект. –т; -тыр (-тір, -дыр, -дір);-қыз (-ғыз, -кіз, -гіз) қосымшалары арқылы жасалады. 	ойлат, ойлаттыр, тарат, тарағыз	t
473	Өзгелік етіс	–т, -тыр, (-тір, -дыр, -дір); -қыз (-кіз, -ғыз, -гіз) жұрнақтары арқылы негіз етіс (етістік негізі) формасынан жасалады. Бұл жұрнақтар етістік негізінің мағынасына амалды (істі) басқа бір бөгде адам (субьекті) арқылы істелуін білдіретіндей мән үстейді.                                                                                             	Жаздыр, бердір, айттыр, келтір, асыр, кетір, жасат, сөйлет	t
475	Өздік есімдік	Қазақ тілінде өздік есімдікке жалғыз ғана өз сөзі жатады. Бұл есімдік көбінесе өзім, өзің, өзіңіз, өзі, өзіміз, өздеріңіз деген сияқты оңаша және ортақ тәуелдеулі түрде қолданылады.       	Өз есімдігі түрленіп тәуелденіп: сенің өзің; көптеліп: өздері, септеліп: өзімнің түрінде қолданылады.\n\n 	t
476	Өздік етіс	Қимылдың іс-әрекеттің орындаушысына, іс иесіне тікелей қатыстылығын білдіреді. -ын (-ін, -н) қосымшасы арқылы жасалады. 	ойлан, таран т.б.	t
477	Өздік етіс	–ын, (-ін, -н) жұрнағы етістік негізіне жалғану арқылы жасалады. Бұл жұрнақ етістік негізіне амалдың (істің) шарпуы я нәтижесі оны жасаушы субьектінің өзіне тиетінін білдіретіндей мән жамайды.    	Жуынды, киінді, боянды, таранды	t
478	Өткен шақ	Сөйлеу кезінен бұрын болған я істеліп тынған амал-әрекетті білдіретін етістік формаларын айтамыз.             	жаз-ды, көр-ді, жаттық-ты, тербет-ті	t
481	Өткен шақты  есімше	ған,-ген,-қан,-кен қосымшалы формалар қимыл-әрекеттің бұрын болып өткенін  білдіреді.	келген, ойнаған т.б.	t
482	Өткен шақты көсемше	-ып, -іп, -п, -ғалы,-гелі,-қалы,-келі, -ғанша,-генше,-қанша,-кенше жұрнақтары арқылы жасалатын көсемше	келіп, ойнап, келгелі, ойнағалы, \nкелгенше, ойнағанша 	t
490	Пысықтауыштық қатынастағы етістікті сөз тіркесі	Бағыныңқы сыңары шығыс жалғау арқылы тіккелей етістікке не демеулер арқылы етістікке бағынады.	мысалы: таудан асты, бір жылдан асты, аудан əрі асты. 	t
493	Реттік сан есім	Дара сан атауларының әр алуан жолмен тіркесе және қосарлана қолданылуы арқылы жасалады	бірінші, екінші	t
494	Реттік сан есім	Есептік сандарға -ыншы (-інші) аффиксін қосу арқылы жасалады да, белгілі бір заттар мен құбылыстардың сандық ретін білдіру үшін қолданылады.                                                                                                                                                     	қырық тоғызыншы, алпысыншы, оныншы	t
496	Сабақтас құрмалас сөйлем 	Жай сөйлемдердің алғашқысының баяндауышы тиянақсыз болып, екінші сөйлемге бағына байланысады. Баяндауышы тиянақсыз болып келген сөйлемді бағыныңқы, тиянақты болып келгенді басыңқы деп айтамыз. 	Күз келіп, күн суытты	t
498	Сабақты	Етістіктің қимылы объектіге ауысып, ол объектінің табыс септікте тұру қажет	аш, жап, жаз, айт т.б.	t
499	Салалас құрмалас сөйлем 	Құрамындағы жай сөйлемдердің  баяндауыштары тиянақты болып, өзара тең дәрежеде салаласа байланысады.	Күз келді, күн суытты 	t
501	Салдар мәнді жалғаулықтар	Салалас құрмалас сөйлемдердің арақатынасын білдіру үшін, яғни басыңқы сөйлемде айтылатын іс-әрекеттің, амалдың нәтижесін я салдары екенін білдіретін дәнекер есебінде жұмсалатын жалғаулықтар.	сондықтан, сол себепті, сол үшін	t
502	Салт етістік	Заттың, кісінің күйін білдіретін, табыс септеудегі тура толықтауышты меңгере алмайтын етістік.	кел, жүр, отыр т.б.	t
505	Салыстырмалы шырай	Салыстырмалы шырай біркелкі сындық белгінің бірінен екіншісінің артық немесе кемдігін салыстыру арқылы көрсетеді. Салыстырмалы шырай жасайтын жұрнақ түрлері: -рақ, -рек, -ырақ, -ірек, -лау, -леу, -дау, -деу, -тау, -теу, -қыл, -ғыл, -қылт, -ғылт, -тым, -шыл, -шіл, -қай, аң]	ақылды-рақ, ақылды-лау, жылдам-ырақ, жылдам-дау, арзан-ырақ, арзан-дау, кәрі-рек, кәрі-леу\n	t
506	Салыстырмалы шырай	Заттың белгісін, түсін (түрін), сапасын, көлемін, салмағын, аумағын, тағы басқа сондай негізгі сын-сипаттарын білдіретін сапалық сын есім	көгірек, бойшаңырақ, кішілеу, таныстау, дымқыл, бозғылт, көкшіл	t
507	Салыстырмалы шырай	Бір заттың сынын екінші заттың сынына салыстырып, сол салыстырылатын белгілердің бір-бірінен я кем, я артық екенін білдіреді.	жақсы-лау, сары-лау; кіші-леу, күрең-деу, терең-деу, сұр-лау, жасыл-дау, көк-теу, жақсы-рақ, жұқа-рақ, кіші-рек, күшті-рек, ұзын-ырақ, толығ-ырақ, үлкен-ірек, биіг-ірек	t
508	сан есім	ла (-ле, -да, -де, -та, -те)	онда, жүзде, екеуле, үшеуле;	t
509	Сан есім	Заттың санын, мөлшерін, ретін, шамасын білдіретін сөз табы.Сан есім өзі анықтайтын сөздің алдынан келіп, атау тұлғасында тұрады, субстантивтенгенде (заттанғанда) көптеледі, жіктеледі, тәуелденеді, септеледі.	бір, екі, үш, төрт, бес т.б.	t
511	Сан есімді сөз тіркестері	Сан есімдер етістікті сөз тіркесінің құрамында пысықтауыштық қатынаста  қимыл процесін сандық сапа тұрғысынан пысықтайды, "есе" сөзімен тіркесіп те етістікті сөз тіркесін құрайды	жаңбыр бір жауса, терек екі жауады; бес есе орындады, үш есе ұлғайды	t
512	Сан есімді сөз тіркестері	Сан есімдер етістікті сөз тіркестері құрамында пысықтауыштық қатынаста қимыл процесін сандық сапа тұрғысынан пысықтайды. Бұл қызмет сан есімдер атау тұлғасында етістіктермен қатар тұрады. Сонымен қатар сан есімдер рет, есе тəрізді сөздермен қосарланып жұмсалады:	 үш рет келді, екі есе көбейді, т.б.	t
514	Сан есімнен зат есім тудыратын жұрнақтар	Есептік сан есімдерден зат есім жасайтын қосымшалар: -дық,-дік, -тық,-тік	екі+лік, төрт+тік,он+дық	t
515	Сапалық сын есім	Заттың түр-түсін, сын-сапасын тікелей анықтайтын сын есім. 	жасыл (алқап), сарғыш (гүл), тәп-тәтті (алма), жаман (әдет), жақсы (қасиет), ұзын (көше), биік (тау), терең (өзен), жуас (жылқы), асау (тай) және т.б.	t
516	Сапалық сын есім	Сапалық сын есім сын есімнің тікелей өзі, яғни заттың түр-түсін, сын-сапасын анықтайды.	жасыл (алқап), сарғыш (гүл), тәп-тәтті (алма), жаман (әдет), жақсы (қасиет), ұзын (көше), биік (тау), терең (өзен), жуас (жылқы), асау (тай) және т.б.	t
517	Сапалық сын есім	Мағынасы жағынан заттың әр алуан сыр-сипатын, атап айтқанда, түрі мен түсін, сыры мен сапасын, көлемі мен аумағын, дәмі мен иісін білдіретін және заттың басқа да қасиет-белгілерін білдіретін сөздерді айтамыз.                                                  	жасыл , сарғыш, тәп-тәтті, жаман, жақсы, ұзын, биік, терең, жуас, асау 	t
518	Сараламалы	Екі я одан аса етістіктің тіркесінен құралады.	келіп  еді, айта сал т.б.	t
519	Себеп бағыныңқылы сабақтас құрмалас сөйлем	Жай сөйлемдерінің бағыныңқысы басыңқы сөйлемінің себебін білдіреді. Сұрақтары: неліктен?, не үшін?, не себепті?, не деп? Жасалу жолдары: -ғандықтан, -гендіктен, -қандықтан, -кендіктен, -ғаны, -генң, -қаны, -кені, -ып, -іп, -п, -ма, -ме, -ба, -бе, -па, -пе, -ған, -ген, -қан, -кен.	Күн жылы болғандықтан, біз серуенге шықтық. 	t
521	Себеп-салдар құрмалас сөйлем 	Жай сөйлемдерінің бірі екіншісінің себебін білдіреді. Өйткені, себебі, сондықтан, сол үшін жалғаулықтарымен байланысады. 	Менің кім екенімді қысқаша Жұмабайға әкесі айтып берді, сондықтан менен қымсынбай сөйледі	t
522	Себеп-салдар үстеу	Амалдың себебін я салдарын (нәтижесін) білдіреді. Оларға мынадай үстеулер жатады: жоққа, босқа, құр босқа, бекерге, амалсыздан, лажсыздан, шарасыздан	Құр босқа, текке, амалсыздан, шарасыздан, лажсыздан, босқа, бекерден-бекер, бекер, босқа.\n\n	t
523	Себеп-салдар үстеуі	Қимылдың, іс-әрекеттің болу себебін білдіреді. Сұрағы: не себепті? Қалай? Неге?	Құр босқа, лажсыздан, босқа, амалсыздан, бекерге, шарасыздан	t
524	Себепті мәнді жалғаулықтар	Салалас құрмалас сөйлемдердің құрамындағы соңғы жай сөйлем бұрынғы (алдыңғы) сөйлемде айтылатын ойдың себебін білдіру үшін арнаулы дәнекер болатын жалғаулықтар.	себебі, өйткені, неге десең	t
527	Септеулік шылау	Обьекті мен обьектінің не предикаттың арасындағы түрлі грамматикалық қатынастарды білдіру үшін қолданылып, белгілі бір септік жалғауын меңгеріп тұратын көмекші сөздерді айтамыз.                                                        	Сайын, үшін, арқылы, секілді, сияқты, тәрізді, сықылды, туралы, жайында, жөнінде, жайлы, шақты, шамалы, қаралы, шейін, дейін, таман, тарта, жуық, қарай, салым, таяу, соң, әрі, кейін, бұрын, бері, гөрі, қатар, бірге, қабат, қоса.	t
539	Сілтеу есімдігі	Мегзеу, нұсқау, көрсету мағыналарын білдіреді.	Бұл, сол, ол, осы, осынау, сонау, анау, ана, мына, мынау, әне, міне	t
540	Сілтеу есімдіктер	Бұл, осы, сол, анау, мынау, сонау, осынау, ана, мына, сона, әні, міне деген сөздер жатады. Бұл есімдіктер негізінен алғанда, сілтеу, көрсету, нұсқау сияқты ишараттарды білдіріп, қай? қайсы? Деген сұрауларға жауап беретін атрибутивтік сөздер.                                                                                            	бұл, сол, ол, осы, осынау, сонау, анау, ана, мына, әне, міне, мынау	t
547	Сөз тіркесі 	Лексика-грамматикалық мағыналары айқын сөздердің біріне-бірі сабақтаса бағынып барып жасалған синтаксистік тобы. 	қызық кітап, биік үйлер, темір жол, оқып отыр, зәресі ұшты, су қоймасы, көрші үй 	t
553	Сөз түрлендіруші жұрнақ	Өзі жалғанған сөздің бастапқы мағынасын өзгертпей, сәл түрлендіреді.	Үй+шік	t
555	Сөздер бір-бірімен жалғау арқылы байланысуы	Сөздердің септік, жіктік, тәуелдік жалғаулары арқылы байланысуы жалғау арқылы байланысу деп аталады. 	Достардың кеңесі, мектепке келу, ата-ананы құрметтеу, кітапта жазылған, апасынан сұрау, үлкендермен ақылдасу, біз дайындаламыз.	t
556	Сөздер бір-бірімен орын тәртібі арқылы байланысуы	Сөздер бір-бірімен орын тәртібі арқылы байланысады. 	Ашық мінез, жапырақты ағаш, өнегелі өмір, берілген тапсырма, жылы жаңбыр, биік мақсат, аталы сөз, кәсіби шеберлік, т.б.	t
557	Сөздер бір-бірімен шылау арқылы байланысуы	Сөздер шылау арқылы да байланысады.	Досым үшін ұялдым, күн сайын жаттықты, ата-анасымен бірге барды, сабақтан кейін дайындалды, гүл мен жапырақ, қалам және қарындаш, т.б.	t
558	Сөздер интонация арқылы байланысуы	Сөздер интонация арқылы да байланысады. 	Абай – ақын, Сәбит – жазушы, мектеп – кеме, білім – теңіз, т.б.	t
561	Сөздердің байланысу тəсілдері	1. Жалғаулар арқылы (септік, тəуелдік, көптік, жіктік). 	жастардың міндеті деген сөз тіркесіндегі екі сөздің алдыңғысы ілік жалғауда, сңғысы тəуелдік жалғауда айтылу арқылы байланысқан.	t
562	Сөздердің байланысу тəсілдері	2. Шылаулар арқылы (демеулер, жалғаулықтар). 	Отаным үшін аттанам, көрген сайын сұрайды дегендер шылаулар арқылы байланысқан. 	t
563	Сөздердің байланысу тəсілдері	3. Сөздердің орын тəртібі арқылы	биік тау, темір күрек, хат жаз, білім ал деген сөз тіркестері ешқандай жалғаусыз тек қатар тұру арқылы байланысқан. 	t
564	Сөздердің байланысу тəсілдері	4. Интонация. 	Бұл – кітап. Жақып – бригадир – интонация арқылы байланысқан.	t
551	Сөз тудыру	Жаңадан сөз жасау заңдары мен ережелерінің жинағы. 	\N	t
570	Сөйлем мүшесінің белгілері: 	1) толық мағыналы сөз болуы керек; 2) сөйлемдегі басқа сөзбен байланысып тұруы керек; 3) сөйлем мүшелерінің бірінің сұрағына жауап беруі керек. 	Мысалы: Жылы желдің әлсіз ызыңы естіледі. Сөйлемде толық мағыналы бес сөз бар. Олардың әрқайсысы белгілі бір сұраққа жауап беріп тұр. Жылы – қандай? – сындық ұғым атауы, желдің – ненің? – заттық ұғым атауы, әлсіз – қандай? – сындық ұғым атауы, ызыңы – несі? – заттық ұғым атауы, естіледі – қайтеді? – қимылдық ұғым атауы.	t
572	Суреттеме	Жетекші сөз бен көмекші етістіктен тұрады	апар, әкел т.б.	t
573	Сұрау есімдігі	Жауап алу мақсатымен сұрау мағынасында қойылатын сұрақтар.	кім? не? қандай? қай? қанша? неше? нешеу? нешінші? қайда? қайдан? қалай? қашан? қайдағы? т.б.	t
574	Сұрау есімдіктер	кім? не? неше? қай? қандай? қанша? қалай? қашан? тікелей баяндауышқа тете тұрып, білуді мақсатат етіп, сұрау қойған кісі сұраулы сөзге жауап беруші адамның назарын аудара айтады.          	кім? не? қандай? қай? қанша? неше? нешеу? нешінші? қайда? қайдан? қалай? қашан? қайдағы? т.б.	t
575	Сұраулы сөйлем 	Басқадан жауап күту мақсататымен айтылған сөйлем. Сөйлем соңында сұрау белгісі қойылады. Сұрау есімдітері (Кім? Не? Қанша? Қандай? , т.б.); сұраулық шылаулар (ма, ме, ба, бе, па, пе,ше); оқшау көмекші сөз (ә, сірә, қайтеді, шығар, т.б.) жасалады.	Сен оны танисың ба? Сен мектепте оқисың ба?	t
576	Сұраулы сөйлем 	Бір нәрсе жайында сұрап білу мақсатында айтылған сөйлем сұраулы сөйлем деп аталады.	«Есіл тасып барады» деген әнді естіп пе едің?	t
577	Сұраулық демеуліктер	Сұраулық мәнде қолданылатын демеуліктер.	ма, ме, ба, бе, па, пе, ше	t
578	Сын (бейне) үстеу	Қимылдың алуан түрлі сапасын, тәсілін (істелу жолын), бейнесін білдіреді де, қалай? қайтіп? қалайша? кімше? неше? (не сияқты?) сияқты сұрауларға жауап береді.                                                                                                  	Тез, жылдам, бетпе-бет, ақырын, бірден, әрең-әрең, жиі-жиі, бірте-бірте, бұрынғыдай, бұлбұлша, арыстандай, келе сала, емін-еркін, лезде, осылай.	t
579	Сын есім	Заттың сынын, сипатын, сапасын, түр-түсін, көлемін білдіреді	қандай? қай?	t
580	Сын есім	Заттың сапасын, сипатын, қасиетін, көлемін, салмағын, түсін (түр-реңін) және басқа сол сияқты сыр-сипаттарын білдіретін лексика-грамматикалық сөз табын айтамыз.                                                                                          	үлкен, құрғақ, дөңгелек, көгілдір, қышқыл, ауыр, жұмсақ 	t
581	Сын есімді сөз тіркестері	Кісінің сезімін, күйін, қабылдау қабілетін білдіретін сабақты етістіктер сын есіммен байланыста болады, сапалық сын есім бағыныңқы сыңар болады	кең пішті, жаман жазды, оңай түсінді, жақсы сөйледі, ұзын кесті	t
582	Сын есімді сөз тіркестері	Сын есімдерінің етістіктермен тіркесуі – сирек кездесетін құбылыс. Барлық сын есім етістікпен тіркесе бермейді, барлық етістікке сын есім бірдей қатыста бола бермейді.Сын есімдер етістіктермен тіркескенде, қимылға не күйге тəн қəсиетті, сапаны білдіреді. Барлық етістік бірдей ондай сапалық пысықтауышы болуын керек етпейді. Сын есімді сөз тіркестерін құрайтын етістіктер сан жағынан көп емес, тек кісінің (не заттың) ішкі сезімін, күйін, қабылдау қабілетін білдіретін сөйлеу, түсіну, оқу, жазу, секіру, ойнау сияқты жəне кейде қимылды, қозғалысты білдіретін кес, піш, байла, тура тəрізді сабақты етістіктер бірқатар сын есімдермен мағыналық байланыста бола алады. Сапалық сын есімдердің ішінде мұндай етістікті сөз тіркестерінің бағыныңқы сыңары болады: жақсы, жаман, қатты, ұзын, қысқа, кең, оңай, қиын, ұзақ,т.б. 	Жақсы сөйледі, жаман жазды, оңай түсінді, ұзын кесті, кең пішті, майда турады. Мұндай етістікті сөз тіркестері пысықтауыштық қатынасты білдіреді. Досы қатты сүйенген, дұшпаны жаман күйінген	t
571	Сөйлем түрлері 	Айтылу мақсататына қарай 4 түрі: хабарлы, сұраулы, лепті, бұйрықты.	\N	t
584	Сын есімнен етістік жасайтын жұрнақтар 	Сын есімнен арнаулы жұрнақтар арқылы жасалатын етістіктер: ла (-ле, -да, -де, -та, -те);-лан (-лен, -дан, -ден, -тан, -тен);-лат (-лет, -дат, -дет);  -ай (-ей, -й); -қар (-ғар, -кер, -гер); -ар (-ер, -р); -ал (-әл, -ыл, -іл, -л); -сы (-сі);-мсы (-імсі); -сын (-сін); -ырай (-ірей); 	жаманда, ұсақта; нәрсізден, қамсыздан, жалқаулан; тездет; молай, кеңей, көбей; оңғар, теңгер; жаңар, тазар, қысқар, өзгер;  оңал, теңел, тарыл; үлкенсі, ширақсы, көлгірсі; жамансың, батырсың; кішірей, тікірей; 	t
586	Сын-қимыл үстеуі	Іс-әрекеттің, қимылдың амалын, тәсілін, сын-бейнесін білдіреді. Сұрағы: қайтіп? Қалайша? Қалай? Кімше?	Ақырын, қазша, бекерден-бекер, балаша, бүркіттейін, қолма-қол 	t
588	Табыс септік	Бұл септіктегі сөз етістікпен байланысып, сөйлемде тура толықтауыш болып қызмет атқарады. Жалғаулары бірде ашық, бірде жасырын түрде қолданыла береді.  	баланы, үйді	t
589	Табыс септік	Кімді? нені? деген сұрақтарға жауап береді.                                                                                                                                                   	Кімді? Баланы; нені? үйді.	t
590	Талғаулы салалас құрмалас сөйлем 	Жай сөйлемдерде айтылған іс-әрекеттің біреуі ғана орындалатын сөйлем. Не, немесе, әлде, я, яки, әйтпесе, не болмаса деген жалғаулық шылаулармен байланысады. 	Ертерек үйге дәрігер шақыру керек немесе ауруханаға бару керек.	t
591	Талғаулықты жалғаулықтар	Сөйлемде зат есім, сын есім, етістік және басқа атаушы сөздер арқылы жасалып, салаласа жалғасқан мүшелердің  бірінен соң бірін я талғап, я таңдап, я кезектестіріп, я біріне-бірін қарама-қарсы қойып айту үшін қолданылатын жалғаулықтар.	әлде, кейде, бірде, не, немесе, я, яки, болмаса, не болмаса, біресе, әйтпесе, ал, енді, құй, мейлі	t
595	Тәуелдеу категориясы	Иеленуші үш жақтың біріне белгілі бір заттың меншікті екенін білдіретін грамматикалық категория.	менің ата-м, менің қалам-ым, сенің ата-ң, сенің қалам-ың	t
598	Тәуелдік жалғау	Заттың меншіктігін білдіретін жалғау.	менің ата-м, менің қалам-ым, сенің ата-ң, сенің қалам-ың	t
599	Тәуелдік жалғау	Бір заттың басқа бір затқа тәуелді екенін білдіретіндіктен, негізінде зат есімге тән қосымша бола тұрса да, зат есім қызметін атқаратын, демек, субстантивтенетін (заттанатын) сөздердің барлығына да жалғана береді.                                                                                                         	менің ата-м, менің қалам-ым, сенің ата-ң, сенің қалам-ың	t
600	Тәуелдік жалғауы	Үш жақтың біріне белгілі бір заттың меншікті екенін білдіретін грамматикалық категория	кімім?нем?кімің? Нең?	t
601	Тіркескен сөздер	Екі немесе одан да көп сөздер тіркесіп келіп, бір ұғымды білдіретін күрделі сөздің түрі.\n1. Күрделі зат есім: \n2. Күрделі сын есім: \n3. Күрделі сан есім: \n4. Күрделі үстеу: \n5. Күрделі етістік:	1. Қазақстан Республикасы\n2. ұзын бойлы\n3. он бес\n4. ала жаздай\n5. айтып отыр	t
602	Тіркескен сын есім	Тіркесу арқылы жасалған сын есімдер	кең маңдайлы, күрең қызыл, көк ала	t
603	Тіркескен үстеу	Сөздердің тіркесуі арқылы тұрақтанып қалыптасқан.	Кешке қарай, күні бүгін, күн ұзаққа	t
604	Тіркесті (құрама) зат есім	Кемінде екі я онан астам түбір сөздерден әр қилы жолмен тіркесу арқылы жасалған зат есімдер. 	ауылдың маңы, үйдің жаны	t
605	Тіркесті сан есім	Негізгі сан есімдер қатарына тек қана есептік сандар жатады.	он бір, жиырма үш т.б.	t
609	Толымды  сөйлем	Ойға қатысқан мүшелердің барлығы қатысқан сөйлем. 	Олар арттарына мәңгілік із қалдырды. 	t
610	Толымды көмекші етістік	Негізгі лексикалық мағынасын толық сақтап, дербес грамматикалық функияларын түгелдей атқарып, етістік атаулыға тән парадигмалық формалардың бәрін қабылдап, жазба тілде де, сөйлеу тілінде де дербес сөз мүше ретінде қолданыла беретін, солай бола тұра, екінщі жағынан, аналитикалық етістік құрамында тиісті жетекші етістікке белгілі дәнекер арқылы тіркесіп, оған қосымша абстракты грамматикалық мағына үстейтін бір алуан (30 шамалы) етістіктер.	ал, бар, бер, баста, бақ, бол, біт, жатыр, жүр, жөнел, жібер, кел, кет, көр, қал, қара, қой, сал, таста, тұр, отыр, өт, шық, де, қыл, ет.	t
611	Толымды сөйлем	Ойға қатысты сөйлем мүшелерінің барлығы қатынасқан сөйлем. 	Мысалы: Қобыланды батыр еді. Мен ұзын қармақпен балық ұстап алып әкелдім. Ол кеше апасына көмектескен \nеді., т.б.	t
612	Толымсыз  сөйлем	Ойға қатысты мүшелердің біреуі түсіп қалып айтылатын сөйлем.	Қайдан келдің, балам? - Астанадан	t
613	Толымсыз көмекші етістік 	Мазмұны жағынан да, форма жағынан да шалағай, яғни, толымсыз сөздер. Соған қарамастан атқаратын функциясы мол.	еді, екен, емес, еміс-еміс 	t
614	Толымсыз сөйлем	Ойға қатысты сөйлем мүшелерінің бірі түсіп қалған сөйлем. 	Мысалы: Құстар тағы келді. Қайта-қайта бара берді. Кеше апасына көмектескен еді., т.б.	t
615	Топтау (я саралау) үстеу	Амалдың және басқа қарым-қатынастың бірігу арқылы істелгенін немесе, керісінше, жекеленіп істелетіндігін білдіреді. Бұл үстеулер нешеден? қаншадан? қалай-қалай? сияқтанған сұрауларға жауап береді.                                               	біреулеп, екеулеп, қос-қостап, топ-тобымен, он-оннан, бір-бірлеп	t
616	Топтау үстеуі	Қимылдың топталып жасалатынын білдіреді. Сұрағы:  қаншалап? Нешелеп? Қалай? Қаншадан?	Екеулеп, ондап, топ-тобымен	t
617	Топтық сан есім	Екі түбір морфемадан қосарланып жасалған сан есімдер	екі- екіден, он-он бестен	t
618	Топтық сан есім	Есептік, жинақтық, болжалдық сан есімдерге, қазіргі кезде шығыс септікке тән грамматикалық мағынадан біржола қол үзген –дан (-ден, -тан, -тен) аффиксін қосу арқылы жасалады да, біркелкі заттар мен құбылыстардың сан мөлшерін топтап көрсетеді.  	үштен, қырықтан, жүзден, тоқсаннан, алтыдан, сексеннен, үшеуден	t
619	Тура толықтауыш 	Табыс септік тұлғасындағы толықтауыш.	Суды шым тоқтатар, сөзді шын тоқтатар.  	t
276	Жіктік жалғау	Синтаксистік қызмет атқаратын баяндауышқа ғана тән жалғау.                                                                                    	\N	t
620	Туынды еліктеу сөздер	Негізгі еліктеу сөздерден де және басқа атауыш сөздерден де тиісті -ң, -ың, -ің, -аң, -ең; -лаң, -лең, -алаң, -елең жұрнақтары арқылы жасалған еліктеу сөздер.	Томп+аң, елп+ең, қорб+аң, көлб+ең, қылм+аң, қылт+ың, салт+аң,балп+аң, арс+алаң, ағар+аң, иір+елең, бұра+лаң, т.б.	t
621	Туынды еліктеу сөздер	Негізгі (түбір) еліктеу сөздерден де және басқа атауыш (атаушы) сөздерден де тиісті жұрнақтар арқылы жасалған еліктеу сөздерді айтамыз.                                                                                                                          	балп-аң, елп-ең, жылт-ың, кілт-ің, жайна-ң, қиқ-аң	t
623	Туынды етістіктер	Түбірлерден арнаулы жұрнақтар арқылы жасалған етістіктер жатады.  	Балтала, биле, баста	t
624	Туынды зат есім	Түбір морфемаға және қосымша(жұрнақ) морфемаға бөлшектенетін, демек, түбір сөзден жұрнақ арқылы жасалған заттық атулар	егінші, балалық	t
625	Туынды зат есім	Түбір сөзден жұрнақ арқылы жасалған заттық атаулар.\n	егін-ші, өнер-паз, кітап-хана, Қазақ-стан, ту-ыс, қыр-ғыш, қи-ынды, жаз-мыш, қара-уылт.б.	t
626	Туынды зат есімдер	Есімдер деп қазіргі кезде түбір морфемаға және қосымша (жұрнақ) морфемаға бөлшектенетін, демек, түбір сөзден жұрнақ арқылы жасалған заттық атауларды айтамыз.                                                                                                                	Аңшы, жұлдызшы, сынықшы, әңгімеші, егінші, тергеуші, адамшылық, аңшылық, таршылық, молшылық, суретшілік	t
627	Туынды зат есімдер	Түбір және қосымша (жұрнақ, жалғау) морфемаларына бөлшектенетіп, түбір сөзден жұрнақ және жалғау арқылы жасалған заттық атаулар. 	Атшы, балгер, емші, дәнекер, жолаушы, заңгер, күншіл, қолдаушы, лепірме, малшы, найзашы, орақ, пайдақор, сынағыш, түнек, шипагер, ұлтшы, \nүміткер, ылғалдылық, іскер.	t
628	Күрделі зат есімдер	Екі немесе одан да көп түбір морфемадан құралған заттық атаулар.\n	алтыбақан, әуежай, абысын-ажын, азық-түлік, ауыр өнеркәсіп, ауыз \nәдебиеті, балалар бақшасы, АҚШ, БҰҰ, ЕҰУ, ҚазҰҒА, 	t
629	Туынды одағай	Бұл басында мағыналы сөздерден я сөз тіркестерінен бірігіп, одағай сөздерге айналған.	Мәссаған!, апырым-ай!, әттеген-ай, бэрекелді!	t
630	Туынды сан есім	Сын есімге өте, тым, аса, әбден, орасан, нағыз, нақ, шымқай күшейткіш үстеулерінің тіркесуінен жасалады.	бірінші, екеу, үштен, төрттей т.б.	t
631	Туынды сөздер	Жұрнақтар арқылы негізгі түбірлерден өрбіген сөздерді айтамыз.                              	ақыл + ды, әдіс + кер, талғам + паз, би + ші, қобыз + шы	t
632	Туынды сын есім	Басқа сөз табынан жұрнақ арқылы жасалған сын есім	ақылды, балаша, таудай	t
633	Туынды сын есім	Есім сөздерге, үстеуге немесе етістікке жұрнақ жалғау арқылы жасалған сын есімдер.\n	таулы, өнерлі, алдағы, биылғы, бұрынғы, тайғақ, жүргек, жабысқақ, 	t
635	Туынды түбір сын есім	Түбір сөзге жұрнақ жалғану арқылы жасалған сын есімді туынды сын есім дейміз. 	аппақ, әсемпаз, көгілдір, таудай, өнерлі, сезгіш.	t
637	Туынды үстеу	Туынды үстеу -ша, -ше; -лай, -лей, -дай, -дей, -тай, -тей; -дайын, -дейін, -тайын, -тейін; -шама, -шеме, -шалық, -шелік; -майынша, -мейінше, -байынша, -бейінше, -пайынша, -пейінше жұрнақтарының көмегімен жасалады. \n	Адамша, өзінше; қыстай, күздей, ақшалай; тотыдайын, бұлақтайын; осыншама, соншалық; айтпайынша, көрмейінше\n	t
638	Туынды үстеулер	Басқа сөз таптарынан түрлі қосымшалар арқылы, сөздердің бірігу және қосарлану, тіркесу тәсілдер арқылы, сондай-ақ, кейбір сөз тіркестерінің тұрақтануы арқылы жасалған (я үстеуге айналған) үстеулерді айтамыз.	балаша, бүркітше, жаңаша, бұлбұлша, жекеше, осылай, жүрелей, жаздай, күндей, көктей, асықтай, жапырақтай, жұлдыздай, арыстандай, бұлбұлдайын, бүркіттейін, жұдырықтайын, асықтайын, бүйректейін, тотыдайын, сұңқардайын, жорғадайын, балықтайын, соншалық, мұншама-мұншалық	t
463	Оқшау сөздер 	Сөйлемдегі сөздермен синтаксистік байланысқа енбей, олардан дауыс ырғағы арқылы бөлектеніп айтылатын сөздер.	\N	t
640	Түбір етістіктер	Арнаулы морфологиялық бөлшектері жоқ, демек, қазіргі кезде морфологиялық жағынан түбір және жұрнақ деп бөлшектеуге болмайтындай етістіктік формалары аталады.	отыр, тұр, жүр, жатыр, оқы, кел, барды, жүгірді, жасаған, көрген	t
641	Түбір зат есім	Қазіргі кезде тиісті морфемаларға (түбірге және жұрнаққа) бөлшектенбейтін, тек бір ғана түбір морфема (сөз) ретінде қабылданатын заттық атауларды айтамыз.                                                                                                                	ат, бал, ем, дән, жол, заң, күн, қол, леп, \nмал, найза, ор, пайда, сын, түн, шипа, ұлт, үміт, ылғал, іс. 	t
642	Түбір зат есімдер	түбір және жұрнақ морфемаларына бөлшектенбей, тек бір түбір морфема-сөз ретінде қабылданатын заттық атаулар. 	ат, бал, ем, дән, жол, заң, күн, қол, леп, \nмал, найза, ор, пайда, сын, түн, шипа, ұлт, үміт, ылғал, іс. 	t
645	Түбір одағай	Бір сөзден жасалған одағай.	А!, о!, ә!, ой!, пай!, қап!, бәсе!, мә!	t
646	Түбір сөз	Сөздің өз алдына тұрып мағына бере алатын, әрі қарай бөлшектеуге келмейтін түпкі мағыналы бөлшегі.	ана, әке, бас, тіл, жол, кел, жүр	t
647	Түбір сөз	Әрі қарай бөлшектенбейтін, морфемаларға мүшеленбейтін, нақтылы бір зат я құбылыс жайындағы немесе я әрекет жайындағы ұғымды білдіретін (я атау үшін қолданылатын) белгілі бір дыбысты я дыбыстық құрамды айтамыз.                                  	үй, жақсы, ғылым, адам, дәптер, тау, бар, көр	t
651	Тұйық етістік	Тұйық етістік етістіктің негізгі және туынды түбіріне, етіс және болымсыз етістік тұлғаларына -у жұрнағы жалғану арқылы жасалады	-у	t
652	Тұрақты	Лексикаланған, идиомаланған тіркестер жатады	сұра-у, жүр-у, бар-у, шегеле-у, айт-қыз-у, сөйле-с-у, кел-ме-у, бөге-ме-у	t
653	Тұрақты сөз тіркесі	Тұрақты сөз тіркесі – екі немесе одан да көп сөздің бастапқы мағынасы ескерілмей, бір ұғым ретінде қолданылып, бір сөйлем мүшесінің қызметін атқаруы.	Ағаш атқа мінгізді (қайтті?), мағынасы: Сөз қылды, келеке қылды.\nАғаштан түйін түйген (қандай?), мағынасы: Аса шебер, өте өнерлі\nБасқан ізін білдірмеді (қайтпеді?), мағынасы: Істегенін сездірмеді\nБеті бүлк етпеді (қайтпеді?), мағынасы: Ұялмады, қысылмады\nЗәресі зәр түбіне кетті (қайтті?), мағынасы: Қатты қорықты, үрейі ұшты	t
654	Тұрақты сөз тіркесі/Фразеологиялық тіркес	Екі немесе одан да көп сөздердің тіркесуінен жасалып, бір ұғымды білдіретін бейнелі сөздер тобы	сөзінде тұру,  судай жаңа,  көңіл айту,   нар тәуекел,  қол қусырып, көз бояушылық, ақ жаулық	t
661	Тұрмыс-салт одағайлары	Бұл топ сан жағынан шағындау болғанмен, өмірде жиі қолданылатын одағайлар. Бұған адамдардың амандасу, қоштасу т.б. Сыйластық белгісі ретінде қолданылатын	Хош! Хайыр! Рахмет! Ассалаумағалейкум! Құп! Ләббай! Кеш жарық! Сияқты сөздер жатады. Құп! - деді де, қоштасып жүріп кетті агроном (мұстафин). Ассалаумағалейкум, - дей мен сақалды адамға қол ұсындым (мұқанов) ләббай, тақсыр! -деп перизат терезеден әрі қараңғы бөлмеге сүңгіп кетті (тарази) т.б.	t
662	Жанды категория	Кім? деген сұраққа жауап беретін адамды не оның кәсібін  білдіретін зат есімдер.	Президент, ата, әже, бала, т.б.\n	t
663	Жансыз категория	Адамнан басқа не? деген сұраққа жауап беретін жанды жансыз зат есімдер жатады.	ит, сиыр, ағаш, су.	t
667	Үйірлі баяндауыш	\N	Бұл дүниенің бақыты – мұратқа қол жеткізу.	t
665	Үйірлі анықтауыш	Үйірлі сөздерден тұратын анықтауыш.	 Ақылы бар жігіт өмірден опық жемейді. 	t
666	Үйірлі бастауыш 	Үйірлі сөздерден тұратын бастауыш.	Уайымы көптер тез қартаяды. 	t
668	Үйірлі баяндауыш 	Үйірлі сөздерден тұратын баяндауыш.	Оның ең үлкен кемшілігі – сабақ оқымау. 	t
669	Үйірлі мүше	Кемінде екі не одан да көп сөзден құралып, бастауыштық-баяндауыштық қатынастан тұратын, бір сөйлем мүшесінің қызметін атқаратын сөздер тобы. Үйірлі мүшелер көбінесе бар, жоқ, аз, көп тәрізді сөздерге және сын есімдер мен есімше тұлғаларына аяқталады. 	Білімі көп адам жерде қалмайды. Білімі көп – қандай? адам – үйірлі анықтауыш. Сөйлемнің бес мүшесі де үйірлі бола алады.	t
670	Үйірлі пысықтауыш	Үйірлі сөзден тұратын пысықтауышты үйірлі пысықтауыш деп \nатайды.	Уақытым барда кітапханаға барып дайындалсам деймін. Ит жоқта қорада шошқа үреді.	t
671	Үйірлі пысықтауыш	Үйірлі сөздерден тұратын  пысықтауыш. 	Уақытым барда сабаққа дайындалса деймін. 	t
673	Үйірлі толықтауыш	Үйірлі сөздерден тұратын толықтауыш. 	Досы көппен сыйлас, досы жоқпен сырлас.  	t
674	Үстеу	Қимылдың, іс-әрекеттің әртүрлі белгісін: амалын, тәсілін, мекенін, мезгілін, себебін, мақсатын, т.б. сипаттарын білдіретін сөздер.	Қашан? Канша? Қалай? Қайтіп? Не себепті?	t
675	Үстеу	Морфологиялық жағынан түрленбейтін (некен-саяқтан ғана түрленетін), лексика-семантикалық жағынан өз алдына топ болып қалыптасып, сөйлемде пысықтауыш қызметінде жұмсалатын сөздерді айтамыз.                                                                                                                                                   	ерте, тез, жоғары, қазір, жылдам, шапшаң, кеш, балаша, бүркітше, жаңаша, осылай, жүрелей, жаздай, күндей, ала жаздай	t
676	Үстеу	Сөздің түп мағынасына үстеме мағына қосатын қосымшаны үстеу дейміз.	ерте, тез, жоғары, қазір, жылдам, шапшаң, кеш, балаша, бүркітше, жаңаша, осылай, жүрелей, жаздай, күндей, ала жаздай	t
677	Үстеуден етістік жасайтын жұрнақтар	 Үстеуден арнаулы жұрнақтар арқылы жасалатын етістіктер: ла (-ле, -да, -де, -та, -те);-лат (-лет, -дат, -дет);  	төменде, кейінде, ілгеріле; түнделет	t
678	Үстеулі сөз тіркестері	Үстеулер етістікті сөз тіркесінің құрамында пысықтауыштық қатынаста жұмсалады	кеше келді, төмен қарады, бүгінше тоқтай тұр, қазақша сөйлеу, көліксіз келу, амалсыздан тоқтады	t
696	Шығыс септікті меңгеретін септеуліктер	Шығыс септік жалғауларында тұрған сөзбен тіркесіп қолданылады.	Гөрі, соң, кейін, басқа, астам, артық, бетер, бөлек, өзге, бері, әрі, бұрын, аса, былай, бөтен, ілгері, тыс, шет, бастап	t
528	Септік жалғау	Зат есімдердің   мағыналарын түрлендіріп, оларды басқа сөздермен байланыстыратын қосымша.	\N	t
681	Ұштастырғыш	Мағына жағынан біріне-бірі орай қолданылатын екі жай сөйлемді ұштастырып байлыныстыру үшін жұмсалады да, бірінші сөйлемнен кейін іле екінші сөйлемде айтылатын ойды бастау үшін дәнекер ретінде қызмет ететін жалғаулықтар.	ал, ендеше, ал ендеше, олай болса	t
682	Хабарлы сөйлем 	Хабарлау, баяндау, суреттеу мақсататында айтылатын сөйлем. Сөйлем соңында нүкте қойылады. 	Таудан төмен сырғанап келе жатқан шаңғышылар колхоз клубының алдына келіп тоқтады.	t
683	Хабарлы сөйлем 	Белгілі бір оқиға, құбылыс, іс-әрекет туралы хабарлау, баяндау, суреттеу мақсатында айтылған сөйлем хабарлы сөйлем деп аталады.	Маржан ертең келетін шығар. 	t
684	Хабарлы сөйлем 	Хабарды, информацияны баяндау үшін жұмсалатын конструкциялар хабарлы сөйлем деп аталады. 	Тау іші, иен жайлау. Ұшқан құс, жүгірген аңнан басқа тіршілік бейнесі білінбейді (Жұмаділов)	t
686	Шарт	-майынша,-мейінше	келмейінше, ойнамайынша т.б.	t
687	Шарт мәнді жалғаулықтар	Сабақтас құрмалас сөйлемдердің арақатынасын білдіру үшін, яғни басыңқы және бағыныңқы сөйлемдердің бір-бірімен жалғасуларына дәнекер есебінде жұмсалатын жалғаулықтар.	егер, егерде, онда, алда- жалда	t
688	Шартты бағыныңқылы сабақтас құрмалас сөйлем 	Бағыныңқы сөйлемі басыңқы сөйлемінің шарты болып келеді. Қайтсе? Не етсе? Қайткенде? Не еткенде? Қайтпейінше? сұрақтарына жауап береді. Жасалу жолдары: -са, -се, -май, -мей, -пай, -пей, - бай, -бей, -ғанда, -генде, -қанда, -кенде.	Сабақ оқығанда, 5 алар едің. 	t
689	Шартты рай	Басқа бір амалдың я істің жүзеге асу-аспау шартын білдіреді, -са (-се) қосымшасының көмегімен жасалады. 	келсе, ойнаса т.б.	t
690	Шартты рай	Етістіктің жалаң (түбір, туынды), күрделі негіздеріне -са (-се) жұрнағы жалғану арқылы жасалады. Шартты райдың бұл формасы мағына жағынан басқа бір амалдың я істің жүзеге асу-аспау шартын білдіреді.        	Көп оқысаң, көп білесің. Кешікпей келсең, көрер едің. 	t
691	Шектеу	Білгілі бір нәрсеге, іс-әрекетке, амалға,сын-сипатқа, мезгілге т.б. Шек қоя тұжырымдап айту үшін қолданылатын демеуліктер.	Ғана, қана, тек, ақ, -ай	t
693	Шығыс септік	Септіктің бұл түрі іс-әрекеттің, қимылдың қай жерден, неден басталғандығын білдіреді. 	баладан, үйден	t
694	Шығыс септік	Кімнен? неден? деген сұрақтарға жауап береді.                                                                                                                     	Кімнен? Баладан; неден? үйден.	t
695	Шығыс септік	Бұл септік іс-амал, қимыл-әрекеттердің шыққан орнын, себебін, мезгілін, мөлшерін және басқа әр қилы мағыналарды білдіреді. Осы мағыналарына қарай, шығыс септіктегі сөз сөйлемде толықтауыш та, пысықтауыш та, кейде, баяндауыш та болады.	баладан, үйден	t
267	Жіктеу категориясы	Қазіргі қазақ тілінде тек етістікке ғана тән қасиет емес, баяндауыш болып қызмет атқара алатын өзге де сөз таптарына, соның ішінде есімдерге де тән қасиет.  	\N	t
697	Шылаулар	Сөз бен сөздің немесе сөйлем мен сөйлемнің араларын байланыстыру, құрастыру үшін қолданылатын, өздері тіркескен сөздерінің ұғымдарына әр қилы реңктер үстеп, оларға ортақтасып, тұлға жағынан тиянақталған, лексика-грамматикалық мағынасы бар сөздер.	үшін, жуық, бірақ, мен, да, әрі, сайын, таман, шақты, бірге, туралы, секілді	t
700	Ыңғайлас салалас құрмалас сөйлем	Бір-біріне жақын болған оқиғаларды білдіреді. Және, әрі, да, де, та, те жалғаулық шылаулармен байланысады.  	Сіздің қолыңыз босай қоймас және босағанымен бұл жұмыс сізге ауыр тиер. 	t
701	Ыңғайластық жалғаулықтар	Өзара ыңғайласып құрылатын, тең дәрежедегі сөздер мен мөз тіркестерін жалғастырады да, солардың ыңғайласқанын білдіретін жалғаулықтар.	мен (бен, пен, бенен, пенен), да (де, та, те), және, тағы, әрі, әм	t
702	Ырықсыз етіс	 Қимыл иесі арнайы айтылмай, іс қимыл өздігінен орындалады. -ыл (-іл, -л) қосымшасы арқылы жасалады. 	жиыл, тарал т.б.	t
703	Ырықсыз етіс	–ыл, (-іл, -л) жұрнағы арқылы және етістік негізінде л дыбысы болса, -ын (-ін, -н) жұрнағы арқылы жасалады. Бұл жұрнақ етістік негізінің мағынасына амал ырықсыз (өздігінен) істелетіндей мән жамайды, үстейді, бірақ ол формадан амалды кім істегені, яғни субьектісі көрінбейді де, көбінесе логикалық обьекті есебінде қызмет етеді.                   	Жаздыр, бердір, айттыр, келтір, асыр, кетір, жасат, сөйлет	t
97	Бастауыш	Сөйлемде атау септігінде тұрып, іс-оқиғаның иесін білдіретін тұрлаулы мүше. Бастауыш зат есім, есімдік, сын есім, сан есім, етістіктен жасалады. Бір сызықпен белгіленеді.   	\N	t
71	Анық (айғақты) өткен шақ	Сөйлеушінің болған я болмаған амал-әрекетті өзі басы-қасында болғандай, өз көзімен көргендей, тыңдаушы (оқушы) әбден қанық боларлықтай, сенерліктей етіп хабарлайтын формаларды айтамыз.   	\N	t
72	Анықтауыш	Зат есімнен болған мүшенің сын-сипатын анықтап тұрады. Сын есім, есімдік, зат есім, сан есім, есімшелерден жасалады. Құрамына қарай: дара, күрделі, үйірлі болып бөлінеді. 	\N	t
73	Анықтауыш	Зат есімнен не заттанған басқа сөз таптарынан болған мүшені сын-сапалық, сан-мөлшерлік, иелік-меншіліктік, қатыстық жағынан сипаттайтын және қандай? қай? қайдағы? қашанғы? нешінші? қайткенде? не еткенде? қанша? неше? кімнің? ненің? деген сұрақтарға жауап беретін сөйлемнің тұрлаусыз мүше.\n	\N	t
75	Анықтауышқа қойылатын сұрақтар	Қандай? Қай? Кімнің? Ненің? Неше? Нешінші? Қайдағы? Қашанғы?   Қайдағы? Қайткенде? Не еткенде? Қанша? 	\N	t
98	Бастауыш	Атау септігінде тұрып, іс-оқиғаның иесін білдіретін тұрлаулы сөйлем мүшесі бастауыш деп аталады. 	\N	t
84	Атауыш есімдер	Заттық ұғымдардың және ойша зат ретінде тұспалданатын түсініктердің аттарын, сондай-ақ, заттарға тән әр алуан тұрақты белгілер жайындағы түсініктердің аттарын білдіреді.	\N	t
85	Атауыш сөздер	Өздеріне тән лексикалық та, грамматикалық та мағыналары бар және ретіне қарай, үстеріне әр қилы қосымша реңтер жамап алып, өзге сөздермен әр алуан қарым-қатынасқа түсе алатын дербес сөздер.	\N	t
89	Ашық рай	Амал-әрекеттің өткенде, қазірде және келешекте болу я болмауын білдіретін негативті грамматикалық категория.	\N	t
90	Ашық рай	Қимыл, іс әрекет үш шақтың (осы шақ, келер шақ, өткен шақ) бірін білдіретін рай түрі. 	\N	t
99	Бастауыш 	Әрекеті баяндауышпен көрсетілген қимыл, іс әрекеттің, жай күйдің не басқа сапаның иесі болатын атау септікте тұрған затты таңбалайтын және кім? не? кімдер? нелер? кімім? нем? кімің? нең? кімі? несі? қайсысы? қаншасы? нешесі? деген сұрақтардың біріне жауап беретін сөйлемнің тұрлаулы мүшесі.	\N	t
100	Бастауыш құрамына қарай 	3 түрге бөлінеді: дара басауыш, күрделі бастауыш, үйірлі бастауыш. 	\N	t
102	Бастауыштың сұрақтары: 	Кім? Не? Кімдер? Нелер? Кімім? Нем? Кімің? Нең? Кіміңіз? Неңіз? Кімі? Несі? Кімдер? Нелер?	\N	t
103	Баяндауыш	Бастауыштың жай-күйін, оқиғаның қай шақта болғанын білдіріп, сөйлемді тиянақтап тұратын тұрдаулы мүше. Етістік, зат есім, сын есім, сан есім, есімдіктен жасалады. Екі сызықпен белгіленеді	\N	t
104	Баяндауыш	Сөйлемде бастауыштың қимылын, іс-әрекетін, жай-күйін, кім-не екенін білдіріп, онымен жақ жағынан, кейде жекеше, көпше (1-2 жақта) түрде қиыса байланысып тұратын және не істейді? не қылады?, не болды? не етеді? қайтеді? қандай? қанша? кім? не? деген сұрақтарға жауап беретін сөйлемнің тұрлаулы мүшесі.\n	\N	t
105	Баяндауыш құрамына қарай 	3 түрге бөлінеді: дара, күрделі, үйірлі.	\N	t
106	Баяндауыштың сұрақтары: 	Не істейді? не қылады?, не болды? не етеді? қайтеді? қандай? қанша? кім? не?	\N	t
132	Болымсыздық есімдіктер 	Еш деген сөзбен кейбір есімдіктердің бірігуі арқылы жасалып, бірге жазылатын есімдер түрі. Оларға бір, кім, қайда, қайдан, қайсы, қандай, қашан, нәрсе, теме, теңе деген есімдіктердің бірігуі арқылы жасалып, бірге жазылатын ешбір, ешкім, ешқайда, ешқайдан, ешқайсы, ешқандай, ешқашан, ешнәрсе, ештеме, ештеңе деген болымсыздық мағынаны білдіретін сөздер жатады.	\N	t
141	Грамматикалану	Күрделі сөздердің лексикалық мағынасы өзгермей, тек қана грамматикалық мағынасы өзгеруі	\N	t
142	Грамматикалық категория	Грамматикалық формасы (тәсілі) бар жалпы грамматикалық мағына.	\N	t
143	Грамматикалық мағына	Грамматикалық құбылыстың (сөздің я оның бөлшегінің) мазмұны болса, грамматикалық тәсіл сол мазмұнды білдіретін формасы.	\N	t
144	Грамматикалық семантика	Сөздің материалдық я лексикалық мағынасы емес, заттың атын, заттың амал-ісін, заттың сапалық, сандық, я басқа (қатыстық) белгілерін, амал мен белгінің белгілерін және басқа да солар сияқты материалдық ерекшеліктерді білдіретін семантика-грамматикалық мағыналар енеді.  	\N	t
145	Грамматикалық семантика	Сөздің материалдық я лексикалық мағынасы емес, заттың атын, заттың амал-ісін, заттың сапалық, сандық, я басқа (қатыстық) белгілерін, амал мен белгінің белгілерін және басқа да солар сияқты материалдық ерекшеліктерді білдіретін семантика-грамматикалық мағыналар енеді.  	\N	t
146	Грамматикалық формалар	Жалпы грамматикалық мағыналарды білдіретін грамматикалық амал-тәсілдер	\N	t
152	Дара еліктеу сөздер	Амал әрекеттің бір ғана рет жасаланатынын білдіреді.	\N	t
161	Делексикалану	Күрделі сөздің құрамындағы компоненттің дыбыстық өзгерістің нәтижесінде бастапқы өз мағынасынан ада-күде айрылуы	\N	t
172	Еліктеуіш сөздер	Өзіне тән лексика-семантикалық мағынасы, морфологиялық тұлға-тұрпаты (формалық структурасы) бар, дара түрлеріне де, қосарланған түрлеріне де көптік, тәуелдік, септік, жіктік жалғаулары тікелей жалғанбайтын (түрленбейтін) сөйлемде әрқашан сын-қимыл пысықтауыш болатын және бастапқы түбірлерінен жұрнақтар арқылы туынды есімдер және етістіктер жасалатын сөздер.       	\N	t
567	Сөйлем мүшелері	Грамматикалық мағыналарға ие болып, синтаксистік қызмет атқарып тұратын сөздер	\N	t
179	Есімдерден сын есім тудыратын өнімді жұрнақтар	-қы, -кі, -ғы, -гі, -лы, - лі, -ды, -ді, -ты,	\N	t
184	Есімді сөз тіркесі	Басыңқы сөзі əр уақытта есім, көбінесе зат есім болады. Зат есімдердің жетегінде айтылып, оларға бағынып тұратын тұратын сөздер де көбінесе есімдер болады	\N	t
192	Есімше	Көптік, септік, тәуелдік, жіктік жалғауларда түрленіп, сөйлемде барлық мүше бола алатын морфологиялық және синтаксистік сипаттары бар (бұл жағынан есімдерге ұқсас), амал-әрекеттің атауы болу, семантикасы мен шақтық ұғымды білдіру қабілеттері де бар (бұл жағынан етістіктерге ұқсас) телі формалар есімшелер категориясы деп аталады.	\N	t
193	Есімшелер категориясы	Көптік, септік, тәуелдік, жіктік жалғауларда түрленіп, сөйлемде барлық мүше бола алатын морфологиялық және синтаксистік сипаттары бар (бұл жағынан есімдерге ұқсас), амал-әрекеттің атауы болу, семантикасы мен шақтық ұғымды білдіру қабілеттері де бар (бұл жағынан етістерге ұқсас) телі формалар	\N	t
195	Етіс	Қимылдың объекті мен субъектіге қатысын білдіреді.	\N	t
196	Етіс	Етістіктен етістік тудыратын, өздерінше морфологиялық және синтаксистік сипаттары басқашалау болып келетін, бір алуан жұрнақтардың жүйесі	\N	t
197	Етіс категориясы	Амалдың (істің) субьекті мен обьектіге қатысын, сондай-ақ, керісінше, субьекті мен обьектінің амалға (іске) қатысын білдіретін формалардың жүйесін атаймыз.                                                                                                           	\N	t
199	Етістік	Тіліміздегі сөз таптарының ішіндегі ең күрделі және қарымы ең кең грамматикалық категория.                                                                                                          	\N	t
200	Етістік негізі	Жалаң я күрделі тұлға арқылы тек амалдың (істің) атын ғана атайтын, яғни амалдың лексикалық мазмұнын ғана білдіретін, сол амалды істеуді ғана мегзейтін, бірақ жүзеге асырудың ешқандай да жолдарын я сатыларын және ол жөніндегі көзқарасты білдірмейтін грамматикалық форманы айтамыз.	\N	t
202	Етістіктер	Амал-қимыл (процесс) ретінде қабылданатын әр алуан іс-әрекеттің, қилы-қилы көріністерінің аттарын білдіреді.                                                                               	\N	t
209	Етістікті сөз тіркесі	Грамматикалық діңгегі етістік болады да, соның негізінде басқа сөздер етістіктің маңына топтанады. Етістіктер мен есімдердің барлық түрлері, сондай-ақ үстеулер, көсемшелер, шылаулы есімдер тіркесе алады. Толып жатқан есім сөздер етістіктермен ешбір қосымшасыз тіркеседі. Бұл ретте етістіктер мен есімдердің өзара байланыс түрі қабысу болады. Етістікті сөз тіркестерінің енді бір тобы есімдердің барыс, жатыс, шығыс, көмектес, табыс жалғаулары арқылы салт жəне сабақты етістіктермен меңгеріле байланысады. Қазақ тіліндегі етістіктердің басқа сөздермен байланысуының осы ерекшелігіне қарай етістікті сөз тіркестері; 1) қабыса байланысқан етістікті сөз тіркестері. 2) меңгеріле байланысқан етістікті сөз тіркестері дейтін екі топқа бөлінеді.	\N	t
214	Сын есімнің шырайлары	Заттардың, іс-әрекеттердің бір тектес сындық, мөлшерлік, сапалық дәрежесінің бір-бірінен айырмашылығын (артық-кемдігін) білдіретін сын есімнің категориясы.	\N	t
217	Жай септеу	Септік қосымшаларының тікелей зат есімдердің және басқа есім қызметін атқаратын сөздердің тура түрлеріне жалғануын айтамыз.	\N	t
219	Жай сөйлем	Бір не бірнеше сөз бен сөз тіркесінен құралған тиянақты бір ғана ойды білдіретін сөйлем	\N	t
220	Жай сөйлем түрлері 	1) Жалаң, жайылма; 2) Толымды,толымсыз; 3) Жақты, жақсыз; 4) Атаулы	\N	t
228	Жалаң жұрнақтар	Мағына жағынан да, форма жағынан да, бөлшектенбейтін бір бүтін жұрнақты айтамыз.	\N	t
233	Жалаң үстеулер	Түрлі қосымшалар арқылы жасалған үстеулер.	\N	t
234	Жалғау	Жұрнақтар мен қосалқы сөздер арқылы жасалған жалаң және күрделі сөздерді бір-бірімен байланыстыру үшін қолданылады.	\N	t
235	Жалғау	Сөзге грамматикалық мағына үстейтін, сөз бен сөзді байланыстыратын қосымша.	\N	t
239	Жалқы есім	Жеке заттың, құбылыстың атауы болатын сөз, сөз тіркесі. Жалқы есімге адам аттары (антропонимдер), географиялық атаулар (топонимдер), діни атаулар (теонимдер), жануарлар атаулары (зоонимдер), аспан денелерінің атаулары (астронимдер), тарихи уақиғалармен байланысты мезгіл атаулары (хрононимдер), рухани нысандар атаулары (идеонимдер) т. б. жатады.	\N	t
241	Жалпы (анық) келер шақ	Амал-әрекеттің алдағы уақытта шүбәсіз, анық жүзеге асатынын білдіреді. Бұл шақ етістіктің негізінде көсемшенің осы шақ формасының жұрнағы (-а, -е, -й) қосылу арқылы жасалады.                                              	\N	t
243	Жалпы осы шақ	Етістік негізіне көсемшенің –а (-е, -й) жұрнағы жалғану арқылы жасалады.                                                                                                                                    	\N	t
254	Жатыс жалғаулы сөз тіркестері	Жатыс жалғаулы есімдерді меңгере алатын етістіктердің саны онша көп емес.Олардың көпшілігі заттың күйін білдіретін салт етістіктері: отыру, тұру, жүру,жату, кездесу, ойнау, қону, көру, көрсету,ұйықтау, қалғу, сүйену, жылау, ескеру, үйрету, ұнау, кұру,т.б Мұндай етістіктермен тіркесетін жатыс жалғаулы есімдер мынадай қатынастарда жұмсалады: а) Объектілік (Толықтауыштық). Объектілік қатынастағы ондай сөз тіркестерінің мағыналары қимыл процесінің қандай заттың үстінде не қандай затпен байланыста болатын, бірдеңенің кімде екенін білдіреді, мысалы:өмірде кездесу, заңда көрсетілу, ойда сақтау, күресте озу, сөзде тұру. ə) Пысықтауыштық. Пысықтауыштық қатынастағы жатыс жалғаулы сөз тіркестері мекендік жəне мезгілдік мағынада жұмсалады:	\N	t
278	Жұрнақ	Жұрнақтар мынадай топтарға бөлінеді:\n1.Тілдің өз материалынан я басқа тілден енген материалдан шыққандығына қарай, олар төл жұрнақтар және кірме жұрнақтар болып екі салаға бөлінеді.\n2. Олар, ерте я кеш шығып қалыптасуларына қарай, көне жұрнақтар және жаңа жұрнақтар болып екі топқа бөлінеді. \n3. Қазіргі кезде сөз тудыру қабілеттерінің бар я жоқтығына қарай, олар тірі жұрнақтар және өлі жұрнақтар болып сараланады.\n4.Құрамындағы морфемалардың дара я күрделі болуына қарай, олар жалаң жұрнақтар және құранды жұрнақтар болып жіктеледі.\n5. Мағыналық жағынан бір я бірнеше мағынаны білдеретіндігіне қарағанда, олар дара мағыналы (моносемиялық) және көп мағыналы (полисемиялық) болып бөлінеді.\n6.Қазіргі кезде сөз тудыру жағынан өнімді я өнімсіз болуларына қарай, олар құнарлы жұрнақтар және құнарсыз жұрнақтар болып салаласады.	\N	t
284	Зат есімді сөз тіркестері	Қабыса байланысқан етістікті сөз тіркестерінің үлкен бір тобы зат есімді тіркес болады. Зат есімдер сабақты етістіктермен қабыса тіркесу арқылы əрі мағыналық, əрі грамматикалық тығыз байланыстағы сөздер тобын құрайды.Сөз тіркестерінің бұл түрі тура обьектілік қатынаста жұмсалады.Жалғаусыз табыс септіктегі зат есімге сабақты етістіктің қимылы ауысып түсіп, онымен біте қайнасқан байланыста түрады. Мысалы: жер жырту, киім тігу, бала оқыту	\N	t
287	Императивтік одағайлар	Бұл топка адам не хайуанатқа бағышталып айтылатын шақыру, жекіру, тыйым салу, бұйыру мақсатымен қолданылатын одағай сөздер жатады.	\N	t
292	Келер шақ 	Алдағы уақытта болуы мүмкін, бірақ әлі басталмаған қимылды білдіреді.	\N	t
296	Көмектес жалғаулы сөз тіркестері	Сабақты жəне кейбір салт етістіктер көмектес жалғаулы есімдерді меңгеру арқылы сөз тіркесінің үлкен бір тобын құрайды. Көмектес жалғаулы есімдер етістіктерге меңгеру арқылы объектлі жəне пысықтауышты қатынастарда түрлі-түрлі мағынада жұмсалады: а) Объектілік қатынастағы сөз тіркестері. Көмектес жалғауда тұрып етістіктермен обьектілік қатынаста айтылатын сөздер-зат есімдер мен олардың орнына жүретін есімдіктер. Олардың обьектілік мағынасы əр түрлі болады. Оның себебі, біріншіден, көмектестегі бағыныңқы сөздердің нені білдіретінімен байланысты болса, екіншіден, оларды керек ететін етістіктердің мағыналарының əр қилы болумен байланысты.	\N	t
301	Көмекші сөздер	Өздеріне тән лексикалық мағыналары солғындаған, лексикалық мағыналары басым болу себебінен көбінесе әр алуан грамматикалық қатынастарды білдіріп, әр қилы грамматикалық қызмет атқаратын жәрдемші сөздер.                                                                                                        	\N	t
302	Көмекші сөздер	Нақтылы лексикалық мағыналары я әртүрлі дәрежеде солғындалып, я бүтіндей жоғалып, сөйлегенде (сөйлемде) жеке-дара тұлға есебінде қолданылмай, тек толық мағыналы (атаушы) сөздермен тіркесіп қана жұмсалып, оларға жәрдемші болып қызмет атқаратын сөздерді айтамыз.                                                  	\N	t
303	Көңіл-күй одағайлары	Бұл одағайлар адамның әр түрлі сезімдерін, көңіл-күйін білдіреді. 	\N	t
305	Көптік жалғау	Нәрсенің көптігін білдіретін грамматикалық форма.	\N	t
307	Көптік категориясы	Тілімізде үш түрлі жолмен беріледі: лексикалық тәсіл арқылы да,морфологиялық, синтаксистік тәсіл арқылы да айтылады. Сөз атаулының қай-қайсысы болса да жалпыланған, жинақталған ұғымды білдіреді. 	\N	t
308	Көптік категориясы	Көптік ұғымды сөздің тікелей өз лексикалық мағынасы арқылы білдіру лексикалық тәсіл деп аталады. 	\N	t
309	Көптік категориясы	Көптік ұғымдардың сөз (синтаксистік) тіркестері арқылы берілу жолы синтаксистік тәсіл деп аталады.	\N	t
310	Көптік категориясы	 Қос сөздер синтаксистік тәсіл арқылы туған күрделі сөздер болғандықтан, олардың көптік ұғымды білдіруін лексика-синтаксистік тәсіл деп атауға болады. 	\N	t
311	Көптік категориясы	  Көптік ұғымдардың сөздерге тиісті қосымшалар қосылу арқылы берілу жолы морфологиялық тәсіл деп аталады.	\N	t
313	Көптік мәнді есімдер	Затты жеке-даралап атамай, оның жиынын тобымен атайтын зат есімдер	\N	t
390	Қосымша морфема	Өз ішінде жұрнақтар, жалғаулар және қосалқы сөздер деп үш топқа бөлінеді.	\N	t
529	Септік жалғау	Зат есімдерді және зат есім қызметін атқаратын өзге сөздерді сөйлемдегі етістік мүшелерімен байланыстырады.	\N	t
315	Көсемше 	Етістік негіздерінен арнаулы қосымшалар арқылы  жасалып, тиісті дәрежеде шақтық, модальдік және басқа мәндерді білдіретін ерекше формалар көсемшелер категориясы деп аталады.	\N	t
316	Көсемшелер категориясы	Етістік негіздерінен арнаулы қосымшалар арқылы жасалып, тиісті дәрежеде шақтық, модальдік және басқа мәндерді білдіретін ерекше формалар.	\N	t
327	Күрделі еліктеу сөздер	Дара еліктеу сөздердің я негізгі, я туынды формаларының не қайталануы, не қосарлануы арқылы жасалған түрлері.	\N	t
332	Күрделі зат есім	Кемінде екі я онан да астам түбір морфемадан құралған формалар жатады.       	\N	t
391	Қосымша морфема	Мағыналық дербестік те, тұлғалық дербестік те болмайды.                                                             	\N	t
346	Күрделі туынды үстеулер	Екі сөзден я бірігіп, я қосарланып жасалған немесе кемі екі я онан да көп сөздерден тіркесіп тұрақтанған үстеулерді айтамыз.                                                                        	\N	t
355	Қабыса байланысқан етістікті сөз тіркестері	Етістіктермен қабыса байланысатын сөздер; үстеулер, еліктеуіш сөздер, көсемшелер, сын есімдер, сан есімдер, жалғаусыз зат есімдер. Есімдіктердің ішінде тек сұрау есімдіктері ғана етістіктермен қабысу жолымен қалай оқиды? қанша сұрайды? деген сөз тіркестерін құрайды. Қабыса байланысқан етістікті сөз тіркестері бағыныңқы сыңардың ыңғайына қарай; 1) үстеулі сөз тіркесі 2) еліктеуішті сөз тіркесі 3) көсемшелі сөз тіркестері 4) сын есімді сөз тіркестері 5) сан есімді сөз тіркестері; 6) зат есімді сөз тіркестері деген алты топқа бөлінеді.	\N	t
370	Қимыл-сын пысықтауыш	Сөйлемде істің, қимылдың қалай болғанын я болатынын, сынын және мөлшерін білдіреді. 	\N	t
371	Қимыл-сын пысықтауыш сұрақтары	Сұрақтары: қалай? қалайша? қайтіп? не етіп? не қып? кім арқылы? не арқылы? ненің арқасында? қанша? неше?	\N	t
379	Қосалқы жұрнақ	Сөз тіркестері мен құранды сөздерді жасау үшін қолданылады	\N	t
389	Қосымша морфема	Түбірге қосылып, оған қосымша мағыналар үстейтін морфемаларды айтамыз.     	\N	t
393	Құрама зат есімдер	Кемінде екі я онан да астам түбір сөздерден әр қилы жолмен тіркесу арқылы жасалған зат есімдер жатады.                                                                         	\N	t
395	Құранды жұрнақтар	Мағына жағынан бір бүтін бола тұрса да, құрамы жағынан кемі екі я онан да көп жалаң жұрнақтардан құралып (бірігіп) жасалған жұрнақтар	\N	t
396	Құрмалас сөйлем 	Екі немесе бірнеше жай сөйлемнен құралып, күрделі ойды білдіреді. 	\N	t
397	Құрмалас сөйлем құрылысына қарай	Салалас, сабақтас, аралас болып үш түрге бөлінеді. 	\N	t
402	Лексикалану	Жай синтаксистік тіркестің тұрақты сөз тіркесіне тән қасиетке ие болып, бір ұғымның атауы ретінде жұмсалуы	\N	t
403	Лексика-семантикалық фактор	Әуелгі жай сөз тіркестерінің идиомалану, лексикалану, делексикалану құбылыстары	\N	t
405	Лепті сөйлем 	Сөйлеушінің көңіл-күйін білдіру мақсататында айтылатын сөйлем. Сөйлем соңында леп белгісі қойылады. Жасалу жолдары: Одағай сөздер (қап, әттеген-ай, пай-пай, т.б.) ; күшейткіш мәнді сөздер (не деген, не еткен, қандай, шіркін, ғажап, т.б.); демеулік шылаулар (-ау, -ақ, -ай, т.б.) және интонация арқылы. М: Қап, мынау жығылды-ау! 	\N	t
409	Мақсатат пысықтауыш	Сөйлемде іс-қимылдың мақсататын білдіреді. Сұрақтары: не істеуге? не мақсататпен? не үшін? неге бола?	\N	t
443	Неғайбыл (ауыспалы) өткен шақ	Сөйлеушінің бұрын істелмекші болған, жүзеге асырылмақшы болған ниетті, мақсататты, шартты, болжалды, тілекті сөйлеп отырған кезге дейін орындалған-орындалмағанын белгісіз етіп көрсететін формаларды айтамыз.                                                                                                            	\N	t
568	Сөйлем мүшелері 	Атқаратын қызметіне қарай тұрлаулы және тұрлаусыз болып екіге бөлінеді.	\N	t
464	Омоним жұрнақтар	Дыбысталуы (айтылуы) мен таңбалануы (жазылуы) бірдей болғанымен, негізгі мағыналары да, туынды мағыналары да бір-бірімен байланыспайтын, ұштаспайтын тіпті басқа-басқа бір алуан жұрнақтар	\N	t
474	Өздік есімдігі	Әрқандай тұлғадағы өз деген сөз.	\N	t
479	Өткен шақ 	Бұрын болған оқиғаны, іс-әрекетті білдіреді.	\N	t
480	Өткен шақ 	Қимылдың, іс-әрекеттің сөйлеу кезінен бұрын болып, істеліп кеткенін білдіретін етістіктің грамматикалық формасы.  	\N	t
417	Мезгіл бағыныңқылы сабақтас құрмалас сөйлем	Бағыныңқы компоненті басыңқы компоненттегі іс-әрекеттің мезгілін білдіретін сөйлем. Сұрақтары: қашан?, қай кезде?, қашаннан бері? Жасалу жолдары: жатыс жалғаулы есімшеден болады: -ғанда, -генде, -қанда, -кенде; өткен шақтық есімшеге –ша, -ше жұрнағы қосылу арқылы; шығыс жалғаулы есімшеге кейін, соң, бері шылаулары тіркесу арқылы жасалады; шартты рай формалы етістіктен болады: -са, -се; көсемше етістіктен болады: -ғалы, -гелі, -қалы, -кел;  –ысы, -ісі қосымшалы етістіктің көмектес жалғаулы түрінен болады. 	\N	t
418	Мезгіл пысықтауыш	Сөйлемде іс-қимылдың мезгілін білдіреді. Сұрақтары: қашан? қашаннан бері? қашаннан? қашанға шейін? қай кезде?	\N	t
421	Мекен пысықтауыш	Сөйлемде іс-қимылдың мекенін, бет алы бағытын білдіреді. Сұрақатары: қайда? қалай қарай? қай жерге шейін?	\N	t
444	Неғайбыл осы шақ	Екі түрлі аналитикалық формант арқылы жасалады. Оның біріншісі – көсемшенің келер шақ (-ғалы, -гелі...) формасындағы етістікке жатыр, жүр, тұр, отыр етістіктерінің бірі тіркеседі де, соңғы көмекшіге жіктік жалғау тікелей жалғанып жасалады; екіншісі –йын деп (-йін деп) форманты жалғанған етістікке сол төрт (жатыр, жүр, тұр, отыр) етістіктің бірі тіркеседі де,оған жіктік жалғау тікелей қосылу арқылы жасалады.	\N	t
445	Неғайбыл рай	Амалдың реальді емес екенін білдіретін негативтік сипат - неғайбыл рай.	\N	t
425	Меңгеріле байланысқан етістікті сөз тіркестері	Етістіктермен меңгеріле байланысып, əр түрлі қарым-қатынаста жұмсалатын сөздер – есімдер. Есімдер етістікке қатысты болып меңгеріле байланысу үшін табыс, барыс, жатыс, шығыс, көмектес, жалғауларының бірінде айтылады. Бұл жалғаулар есімдерді етістіктермен ұластырушы ғана емес, сөздердің синтаксистік қызметтерін саралайтын да тұлғалар. Сондықтан меңгерудің етістікті сөз тіркесін құрауда мəні ерекше. Аталған септік жалғаулардың синтаксистік қызметі, негізінде, етістіктердің лексикалық магыналарымен байланысты болады да, сөз тіркестерінің бағыныңқы сыңарларына септік жалғауы басыңқы сөздердің ыңғайына қарай жалғанады. Мысалы, шық, түс, қара, жібер етістіктері барыс, шығыс, көмектес жалғауларындағы сөздері керек етіп, оларды өздеріне бағындырып (меңгеріп) тұрады: Шық-тауға шық, үйден шық, сатымен шық	\N	t
426	Меңгеріле байланысқан етістікті сөз тіркестерінің 5 түрі	1) табыс жалғаулы сөз тіркестері. 2) барыс жалғаулы 3) шығыс жалғаулы 4) жатыс жалғаулы 5) көмектес жалғаулы сөз тіркестері.	\N	t
429	Модальдік (арайлық) реңк	Адам сөйлегенде я жазғанда белгілі бір жайт туралы жалаң хабар беріп қана қоймайды, соған қатысты өзінше түйген көзқарасын, көңіл қошын, ой құбылысын да қоса білдіреді. Сөйлеуші лебізінің я сөйлеуші пікірінің ақиқат шындыққа қатысын білдіретін тілдегі тиісті фонетикалық, лексикалық, грамматикалық тәсілдер және олар арқылы берілу жүйесі.	\N	t
431	Морфема	Түбір морфема және қосымша морфема деп негізгі екі салаға (түрге) бөлуге болады.    	\N	t
432	Морфология	 Сөз және оның формалары туралы ілім. 	\N	t
433	Морфология	Сөзді, сөздің тиісті бөлшектерін, олардың мағыналары мен қызметтерін талдаса, синтаксис сөйлемді, сөйлем ішіндегі тиісті сөз тіркестерін я жеке сөздерді (сөйлемнің мүшелерін), олардың қарым-қатынастары мен грамматикалық сыр-сипаттарын талдайды.	\N	t
434	Морфология	Сөзді оқшау қарамайды, оны басқа сөздермен байланысты қарап барып, олардың қарым-қатынастарын анықтайды.  	\N	t
435	Морфология	Тілдің ары қарай бөлшектеуге келмейтін ең кіші мағыналық единицасы.  	\N	t
436	Морфологиялық категориялар	Жеке сөздердің өзгерілуі (түрленуі) арқылы туатын жалпы грамматикалық мағыналарды айтамыз.	\N	t
437	Морфологиялық тәсіл	Түбір сөзге я туынды сөзге қосымшалар қосу арқылы жаңа сөз тудыру тәсілін айтамыз.	\N	t
450	Негізгі етіс	Өзге етіс формаларына таяныш – негіз болатын, солардың түрлерін, мағыналарын, қызметтерін салыстырып айқындайтын форманы айтамыз.                                                                                                                                                  	\N	t
460	Одағай сөздер	Ешқандай да ақиқат ұғымдарды білдірмейтін, тек адамның әр алуан көңіл күйі мен әр қилы сезім райларын білдіру үшін қолданылатын (бірақ олардың атаулары есебінде жұмсалмайтын) сөздерді айтамыз.           	\N	t
484	Пысықтауыш	Сөйлемде іс-әрекеттің жай-күйін, сын сипатын, амалын, мөлшерін, мезгіл-мекенін, себеп-мақсатын білдіретін және қашан? қайда? (қалай қарай?) қайдан? қалай? қайтіп? не себептен? неліктен? кім үшін? не үшін? не істеуге? не қылуға? не мақсатпен? не арқылы? кім арқылы? ненің арқасында? кімнің арқасында? не сайын? кім сайын? қанша? қанша уақыт? неше рет? деген сұрақтарға жауап беретін сөйлемнің тұрлаусыз мүшесін атаймыз.\n	\N	t
565	Сөйлем 	Кісінің ойын айтудың негізгі формасы. Біршама тиянақты ойды білдіретін сөздер тобы. 	\N	t
485	Пысықтауыш 	Сөйлемде іс-қимылдың түрлі белгісін(мезгілін, мекенін) анықтайтын мүше. Үстеу, барыс, жатыс, шығыс септіктеріндегі сөздерден, есім сөз, еліктеу сөз және көсемшеден жасалады. 	\N	t
486	Пысықтауыш құрылысына қарай 	Үш түрге бөлінеді: дара, күрделі және үйірлі	\N	t
487	Пысықтауыш мағынасына қарай 	5 түрге: қимыл-сын, мезгіл, себеп, мақсатат, мекен. 	\N	t
488	Пысықтауышқа қойылатын сұрақтар	Сұрақтары Қайда? Қайдан? Қалай қарай? Қашан? Қашаннан бері? Қалайша? Қайтіп? Неліктен? Не үшін? Неге? Не мақсататпен? 	\N	t
489	Пысықтауышқа қойылатын сұрақтар	Қашан? қайда? (қалай қарай?) қайдан? қалай? қайтіп? не себептен? неліктен? кім үшін? не үшін? не істеуге? не қылуға? не мақсатпен? не арқылы? кім арқылы? ненің арқасында? кімнің арқасында? не сайын? кім сайын? қанша? қанша уақыт? неше рет? 	\N	t
491	Рай	Қимылдың болмысқа қатысы туралы сөйлеушінің түсінігін, көзқарасын білдіреді.	\N	t
492	Рай категориясы	Сөйлеушінің қимыл, іс-әрекетке көқарасын, қимылдың, іс-әрекеттің шындыққа, болмысқа қатысын, модальдық мәнін білдіріп, белгілі парадигмалық тұлғалар жүйесінен тұратын етістіктің грамматикалық категориясы рай категориясы деп аталады. 	\N	t
495	Сабақтандырғыш	Тек құрмалас сөйлемдердің құрамдарындағы жай сөйлемдерді бір-бірімен жалғастырып байланыстырып, солардың арақатысын анықтап көрсететін жалғаулықтар.	\N	t
497	Сабақтас құрмалас сөйлем түрлері	Шартты бағыныңқылы, қарсылықты бағыныңқылы, себеп бағыныңқылы, мезгіл бағыныңқылы, қимыл-сын бағыныңқылы, мақсатат бағыныңқылы сабақтас құрмалас сөйлем.	\N	t
500	Салалас құрмалас сөйлем түрлері 	Ыңғайлас, қарсылықты, себеп-салдар, кезектес, талғаулы, түсіндірмелі.	\N	t
503	Салт етістіктер	Табыс септіктегі сөзге (тура толықтауышқа) сабақталмайтын етістіктер.	\N	t
504	Салт және сабақты етістіктер	Объектіге қатынасына байланысты	\N	t
566	Сөйлем 	Әр алуан сөздердің өзара тіркесіп келіп, тиянақталған ойды білдіруі. 	\N	t
510	Сан есім	Есімдер тобына жататын сөз таптарының бірі, заттың сан мөлшерін, ретін, шамасын білдіретін лексика-грамматикалық сөз табы. Жаратылысы мен жасалу жүйесі жағынан сан есімдер дара және күрделі болып бөлінеді: дара сан есімдер қатарына бір, екі, үш, он, жүз, мың сияқты сан есімнің бастапқы шыға бастаған кезінен, жаратылысынан табиғи сан атаулары мен кейінгі замандарда кірігіп қалыптасқан алпыс, жетпіс, сексен сияқты сан есімдер (бұлар, бір жағынан, ондық көбейтілмелі сандар) жатады: күрделі сан есімдер тобына төрт-бес, он-он бес сияқты қосарлы сандар, әр алуан қосылмалы сандар, жүздік, мыңдық көбейтілмелі сандар және көбейтілмелі – қосылмалы аралас сандар жатады.                                                                                	\N	t
513	Сан есімді тіркестер	Зат есімдерге тəн, оларды сан жағынан анықтап тұратын, зат есімнің жетегінде айтылатын, өзінің басыңқылық дербестігі жоқ сөздер. Олардың зат есімдермен тіркесуі арқылы қабыса байланысқан есімді сөз тіркестері жасалады. Сан есімдер зат есімдердің өзара тіркесу қабілеті ерекше болатындықтан, ондай сөз тіркестері жиі кездеседі жəне олардың құрамы əр түрлі болады	\N	t
520	Себеп пысықтауыш	Сөйлемде іс-қимылдың себебін білдіреді. Сұрақтары: неліктен? не себепті? не үшін? 	\N	t
525	Септеулік	Объекті мен объектінің не предикаттың арасындағы түрлі грамматикалық қатынастарды білдіру үшін қолданылып, белгілі бір септік жалғауын меңгеріп тұратын көмекші сөздер.	\N	t
526	Септеулік шылау	Объекті мен объектінің не предикаттың арасындағы түрлі грамматикалық қатынастарды білдіру үшін қолданылып, белгілі бір септік жалғауын меңгеріп тұратын көмекші сөздер	\N	t
530	Септік жалғау	Есімдіктерге, сын есімге, сан есімге, есімшелерге және басқа субстантивтенетін сөздерге (көптеулі, тәуелдеулі сөздерге де) жалғанады.                       	\N	t
531	Септік жалғауы	Сөйлемдегі сөздерді бір-бірімен жалғасытырып, септестіріп тұратын қосымшалар	\N	t
532	Синоним жұрнақтар	Формасы (айтылуы мен жазылуы) басқа-басқа бола тұра, мағыналары бір-біріне жақын я мағыналас жұрнақтар.	\N	t
533	Синтаксис	Грамматиканың бір түрі. Мұнда сөйлемдегі сөздердің тіркесу жолдары, сөйлемдердің түр-түрі және олардың бір-бірімен тіркесу жолдары қарастырылады.	\N	t
534	Синтаксис	Синтаксис сөз тіркесі, сөйлем, олардың құрылымы мен түрлері, сөйлем мүшелері туралы қарастырады. Яғни синтаксис – сөз тіркесін, сөйлемнің грамматикалық сыр-сипатын зерттейтін ілім.	\N	t
535	Синтаксис 	Сөз тіркесін, сөйлемді, олардың түрлерін, сөйлем мүшелерін жəне басқа синтаксистік формаларды адамның ойын білдірудің грамматикалық тəсілдері ретінде, өзара байланысты категориялар ретінде қарастырады	\N	t
536	Синтаксис 	Сөздер арқылы сөз тіркеcі, сөйлем және мәтін қалай құрылатындығын көрсететін ережелер жиыны. 	\N	t
537	Синтаксис екі саласы 	1. Сөз тіркесі; 2. Сөйлем синтаксисі 	\N	t
538	Синтаксистік тәсіл	Түбір (я туынды) сөздердің бірігуі, қосарлануы, тіркесуі арқылы сөз тудыру тәсілін айтамыз.                                                                                                           	\N	t
541	Сөз	Ең негізгі тілдік тұлға (единица) болуымен қатар, күллі грамматикалық ережелер мен заңдардың да кіндігі.	\N	t
542	Сөз	Белгілі формалардың жүйесі.	\N	t
543	Сөз	Зат біткеннің бәрінің аты емес, әр елдің өзінің білген затының, білген құбылысының ғана аты.	\N	t
544	Сөз табы	Жалпы лексика – грамматикалық сипаттары мен белгілері бәріне бірдей ортақ болып келетін сөздердің тобын айтамыз.                                                              	\N	t
545	Сөз тіркесі	Толық мағыналы кемінде екі сөздің тұлғалық және мағыналық жағынан байланысқан тобы сөз тіркесі деп аталады. \nСөз тіркесінің негізгі белгілері:\n-сөздердің байланысуы сөйлем ішінде анықталатындықтан, сөз тіркесі -сөйлем ішінде танылады;\n-толық мағыналы кем дегенде екі сөзден тұрады;\n-сөз тіркесінің құрамындағы сөздер бір-бірімен белгілі бір грамматикалық тәсілдер арқылы байланысады;\n-сөз тіркесі қандай да бір синтаксистік қатынасты білдіреді.	\N	t
546	Сөз тіркесі 	Сөйлем құраудың материалды негізі. Синтаксистік қарым-қатынасты білдіру үшін кемінде толық мағыналы екі сөздің сабақтаса байланысқан тобы. Өзара тіркескен сөздің бірі екіншісін өзіне бағындырып тұрады. Сондықтан сөз тіркестері сабақтаса байланысқан екі сыңардан құралады; бірі – сөз тіркесінің ұйытқы бөлегі, сөз тіркесінің грамматикалық діңгегі- оның басыңқы сыңары, екіншісі – оның бағыныңқы сыңары.	\N	t
548	Сөз тіркесі 	Толық мағыналы кем дегенде екі сөздің өзара сабақтаса, бірі екіншісіне бағына байланысуын сөз тіркесі деп атайды	\N	t
549	Сөз тудыратын жұрнақ	 Сөзге (түбірге) жаңа лексикалық мағына үстейтіндіктен, өзі жалғанған сөзді басқа бір жаңа лексикалық тұлғаға айналдырады.	\N	t
550	Сөз тудыратын жұрнақ	Өзі жалғанған сөзден (түбірден) лексикалық мағынасы басқа жаңа сөз тудырады.	\N	t
552	Сөз тудыру	Қазақ тілінің сөз тудыру жүйесі үлкен-үлкен негізгі екі саладан тұрады. Оның бірі – морфологиялық тәсіл, екіншісі – синтаксистік тәсіл.	\N	t
554	Сөз формасы	Оның (сөздің) морфологиялық құрамындағы бөлшектерінің (морфемаларының), синтаксистік байланыс-жалғас тәсілдерінің өзара бір-бірінен ерекшеленіп бөлінерліктей және соған орай қосымша мағына білдірерліктей (я сондай мағыналарға ие боларлықтай) әр алуан түрлерін айтамыз.	\N	t
559	Сөздердің байланысу жолдары	1) қиысу, 2) матасу, 3) меңгеру, 4) қабысу, 5)жанасу. 	\N	t
560	Сөздердің байланысу тəсілдері	Сөз тіркесідегі сөздердің қосымшалары арқылы байланысуы – синтетикалық байланыс, қосымшаларсыз, орын тəртібі, интонация, шылаулар арқылы байланысуы аналитикалық байланыс болады	\N	t
569	Сөйлем мүшелері 	Сөйлем құрауға қатысқан толық мағыналы сөздер сөйлем мүшелері деп аталады. Қазақ тілінде бес сөйлем мүшесі бар: бастауыш, баяндауыш, толықтауыш, пысықтауыш. 	\N	t
583	Сын есімді тіркестер	Заттың əр түрлі сындық сапасын білдіретін сөздер. Солай болатындықтан олар зат есімдерге қатысты болып, зат есімдерден тіркесіп, есімді сөз тіркесінің құрамында өте көп жұмсалады.	\N	t
585	Сын есімнен зат есім тудыратын жұрнақтар	-лық(-лік,-дық, -дік,-тық,-тік),	\N	t
587	Табыс жалғаулы сөздерді	Табыс жалғаулы сөздерді керек ететін етістіктер – сабақты етістіктер. Қазақ тілінде сабақты, салт етістіктің тұлғалық айырмашылығы болмағанмен, оларды мағыналық ерекшеліктеріне қарап, табыс жалғаулы есімдердің олармен тіркесе алатын не тіркесе алмайтынына қарап айыруға болады. Мысалы, кес, ұр, шап, ал, бер, шақыр, сұра, сой, қама сияқты кісінің қимыл-əрекетін, ісін білдіретін етістіктер сабақты болады да, күл, қуан, қайғыр, жыла, шошы, есіне, жалық, ауыр, терле, тон сияқты заттың қимылдық күйін білдіретін етістіктер салт болады. Бұларға етіс жұрнақтары жалғанып, сабақты етістік салтқа, салт етістік сабақтыға ауыса береді;  Қуан қуант Шарша шаршат	\N	t
592	Танық (айғақсыз) өткен шақ	Сөйлеушінің болған я болмаған амал-әрекетті өзі басы-қасында болмай, өз көзімен көрмей, тек қана басқа айғаққа (біреудің айтуына, хабарлануына) сүйеніп, немесе өзі көріп, оқып, сұрап, естіп... білген мәліметке сүйеніп айтқанындай етіп көрсететін формаларды айтамыз.  	\N	t
593	Таптасқан сөздер	 Бұлар заттың өзін, сипатын, ісін айырып атау үшін қажет; таптасқан сөздер жеке тұрып хабар беру үшін емес, бірнешеуі қосылып барып, хабар беру үшін жасалған.	\N	t
594	Таптаспаған сөздер	Заттың өзін, сипатын, ісін, түйдегін жазбай атау үшін қажет. Олар хабарлауыш сөздер, жеке тұрып-ақ хабар беру үшін жасалған. Бірақ құрылысы жағынан жеке сөз, атқаратын қызметі жағынан сөйлемде не сөйлемдер жинағы.  	\N	t
596	Тәуелдеу категориясы	Үш түрлі тәсіл арқылы жасалады: біріншісі – морфологиялық (я синтеткалық) тәсіл, екіншісі- синтаксистік (аналитикалық), үшіншісі – аралас (демек, морфологиялық тәсіл мен синтаксистік тәсілдің тоқайласқан түрі) тәсіл.	\N	t
597	Тәуелді септеу	Септік жалғауларының зат есім немесе зат есім қызметін атқаратын басқа сөзердің тәуелді түрлеріне жалғануын айтамыз.	\N	t
606	Толықтауыш 	Сөйлемде атау мен іліктен басқа септіктердің бірінде тұрып, баяндауыш білдіретін амал-әрекетті, іс-оқиғаны заттық мағына жағынан толықтыру үшін жұмсалатын, толықтыратын және кімді? нені? кімге? неге? кімнен? неден? кімде? неде? кіммен? немен? кім (не) туралы? кім (не) жөнінде? не жайында? деген сұрақтарға жауап беретін сөйлемнің тұрлаусыз мүшесі.	\N	t
607	Толықтауыш 	Іс-оқиғаны заттық мағына жағынан сипаттайтын тұрлаусыз мүше. Зат есім, есімдік, сын есім, сан есім, етістіктерден жасалады. Құрамына қарай: дара, күрделі, үйірлі болып бөлінеді. Мағынасына қарай тура және жанама толықтауыш деп бөлінеді. 	\N	t
608	Толықтауыш сұрақтары: 	Кімді? Нені? Кімде? Неде? Кімге? Неге? Кімнен? Неден? Кіммен? Немен? 	\N	t
622	Туынды етістік	Түбірлерден арнаулы жұрнақтар арқылы жасалған етістіктер	\N	t
634	Туынды түбір есімдік	Түбірлердің бірігуі арқылы жасалған есімдік.	\N	t
636	Туынды үстеу	Жұрнақ арқылы және кейбір септік жалғауларының түбірмен сіңісіп, көнеленуі арқылы жасалған. 	\N	t
639	Түбір етістік	Арнаулы морфологиялық бөлшектері жоқ етістіктер	\N	t
643	Түбір морфема	Сөздің әрі қарай бөлшектеуге келмейтін ең түпкі негізі. Бұл түпкі негіз сөздің құрылысының да, мағынасының да негізгі ұйытқысы болып есептеледі.	\N	t
644	Түбір морфема	Өздігінен жеке тұрып семантикалық жағынан да, қызметі жағынан да дербес сөз бола алады.	\N	t
648	Түбірлес сөздер	Бір түбірден тараған туынды түбірлер.	\N	t
649	Түрік изафеті	Зат есімнің өзді-өзі, бір-бірімен тіркесу жүйесі.	\N	t
650	Түсіндірмелі салалас құрмалас сөйлем 	Жай сөйлемдерінің соңғы сөйлемі алдыңғысының мағынасын түсіндіріп тұрады. Компоненттердің мағыналық қатынастары жағынан алғанда, бірінші жай сөйлем  баяндауышы сол, соншама, соншалық, сондай деген есімдіктер мен үстеу сөздермен де жасалады. М: Оның үстіне киген қытайдың қызыл шайқысынан тігілгеноқалы көйлегінің ұзындығы сонша – оның етегін бірнеше қыздар саусақтарының ұшымен ұстап көріп келеді. 	\N	t
655	Тұрлаулы мүшелер	Бастауыш пен баяндауыш сөйлем құрауға негіз болады, сондықтан тұрлаулы мүшелер деп аталады. 	\N	t
656	Тұрлаулы мүшелер	Сөйлем құрауға негіз болатын, өзара \nпредикаттық қатынаста жұмсалатын сөйлем мүшелері.\n	\N	t
657	Тұрлаулы мүшелер 	Сөйлем құрауға негіз болатын мүше. Екі түрі бар: бастауыш және баяндауыш. 	\N	t
658	Тұрлаусыз мүшелер	Сөйлемнің тұрлаулы мүшелерінің айналасына топтасып, сөйлемді семантикалық жағынан кеңейтетін және толықтыратын сөйлем мүшелері.	\N	t
659	Тұрлаусыз мүшелер	Анықтауыш, толықтауыш, пысықтауыштар өздігінен сөйлем құрай алмайды, тек берілген ойдың шеңберін кеңейтеді, сондықтан бұлар тұрлаусыз мүшелер деп аталады.	\N	t
660	Тұрлаусыз мүшелер	Өздігінен сөйлем құрай алмайтын, тек ойды толықтырып тұратын сөйлем мүшесі. Үш түрі бар: толықтауыш, анықтауыш, пысықтауыш. 	\N	t
664	Үcтеулер	Өздерінің лексикалық мағыналарына лайық заттың қимылдық сапасын айқындайтын сөздер. Солай болатындықтан олар көбінесе етістіктерге қатысты болып, етістікті сөз тіркесінің құрамында жиі қолданылады. Үстеулердің есім сөздермен тіркесуі кездейсоқ құбылыс емес. Қазақ тілінің материалдарына қарағанда, мезгіл үстеулері сөйлем ішінде зат есім, сын есім, сан есім жəне бар, жоқ сөздеріне қатысты болып, солармен қабыса байланыста көп ұшырайды	\N	t
672	Үйірлі сөйлем мүшесі	Кемінде екі не одан да көп сөзден құралып, бастауыштық-баяндауыштық қатынастан тұратын, бір сөйлем мүшесінің қызметін атқаратын сөздер тобы. Үйірлі сөйлем мүшелері көбінесе бар, жоқ, аз, көп тәрізді сөздерге және сын есімдер мен есімше тұлғаларына аяқталады.\n	\N	t
679	Үстеулі сөз тіркестері	Үстеулерді қимыл процесімен байланыста айтылатын сөздер деп қараймыз, сондықтан олар етістіктермен тіркесу үшін жаратылған сөздер деуге болады. Үстеулер етістіктердің алдында қабыса байланыста жұмсалып өте жиі кездесетіндіктен, ондай сөз тіркестеріне ерекше назар аудару керек. Үстеулер етістікті сөз тіркестерінің құрамында пысықтауыштық қатынаста, мезгіл, мекен, себеп, мақсатат т.б. мағыналарда жұмсалады	\N	t
680	Үстеуші есімдер	Әр қилы іс-әрекеттің (амалдың) белгілерін және белгінің белгілерін білдіреді.                                                                                                                          	\N	t
685	Шақ 	Қимыл-іс-әрекеттің сөйлеп тұрған сәтпен байланысты болып өтетіндігін, бірақ болатынын білдіріп, белгілі жолдармен жасалатын етістіктің грамматикалық категориясы шақ деп аталады. 	\N	t
692	Шығыс жалғаулы сөз тіркестері	Жалғаулы есімдерді етістіктер меңгеріп, солардың байланысынан толықтауыштық жəне пысықтауыштық қатынастағы сөз тіркестері жасалады. Шығыс жалғаулы есімдерді (көбінесе зат есімдер мен есімдіктерді) меңгеретін етістіктер, негізінде, мыналар: шығу, шығару, қайту, қайтару, тастау, алу, (таудан асу), өлу, тарау, ұшу, тоқу, істеу, тігу, салу, қалу, пісіру, орнату,(тастан орнату),соғу, қарғау, сұрану,т.б. Бұлардың көбі қимыл (мысалы:тастау,шығару, тарау,тоқу) жəне қабылдау (мысалы:көру, қорқу, қарау, үйрену) мəнді етістіктер.	\N	t
698	Шырай	Шырай – тек сын есімге тән форма. Бір тектес заттардың сапалық белгісінің не артық, не кемдігін, сапа белгісінің әртүрлі дәрежеде болу қасиетін білдіреді. 	\N	t
699	Шырай формалары	Заттың белгісі я сипаты (түсі, түрі, сапасы, көлемі, аумағы, салмағы, сыры т.б.) біркелкі болмай, рең жағынан әр түрлі дәрежеде болатынын, демек, сипатының я белгінің бір затта кем кем болатынын білдіретін сын есім формалары	\N	t
\.


--
-- TOC entry 3761 (class 0 OID 18185)
-- Dependencies: 224
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (user_id, role_id, id) FROM stdin;
1	1	1
1	2	3
\.


--
-- TOC entry 3758 (class 0 OID 18136)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, password_salt, is_verified, confirmation_code_hash, full_name) FROM stdin;
1	enu201309@gmail.com	ae27accde72352ea5942bbaf42c5f38680dfc67a67f085ac0fdbc4ef4b773bdc	065750d6568a1d40aabd6dba97ac697f	t	a	e
\.


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 244
-- Name: activate_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activate_types_id_seq', 4, true);


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 249
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 214
-- Name: legacy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legacy_id_seq', 100, true);


--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 238
-- Name: morphemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.morphemes_id_seq', 195, true);


--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 226
-- Name: my_serial; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.my_serial', 703, true);


--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 246
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_id_seq', 6685, true);


--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 216
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_id_seq', 1, false);


--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 234
-- Name: paraphrases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paraphrases_id_seq', 3203, true);


--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 218
-- Name: quote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quote_id_seq', 1, false);


--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 242
-- Name: school_termins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_termins_id_seq', 6348, true);


--
-- TOC entry 3817 (class 0 OID 0)
-- Dependencies: 240
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 13, true);


--
-- TOC entry 3818 (class 0 OID 0)
-- Dependencies: 230
-- Name: synamizer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synamizer_id_seq', 4885, true);


--
-- TOC entry 3819 (class 0 OID 0)
-- Dependencies: 232
-- Name: synonyms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.synonyms_id_seq', 11675, true);


--
-- TOC entry 3820 (class 0 OID 0)
-- Dependencies: 228
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- TOC entry 3821 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 1, true);


--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 3601 (class 2606 OID 19096)
-- Name: activate_types activate_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activate_types
    ADD CONSTRAINT activate_types_name_key UNIQUE (name);


--
-- TOC entry 3603 (class 2606 OID 19094)
-- Name: activate_types activate_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activate_types
    ADD CONSTRAINT activate_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 18115)
-- Name: legacy legacy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legacy
    ADD CONSTRAINT legacy_pkey PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 18355)
-- Name: morphemes morphemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.morphemes
    ADD CONSTRAINT morphemes_pkey PRIMARY KEY (id);


--
-- TOC entry 3605 (class 2606 OID 19104)
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 18124)
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- TOC entry 3593 (class 2606 OID 18318)
-- Name: paraphrases paraphrases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paraphrases
    ADD CONSTRAINT paraphrases_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 18134)
-- Name: quote quote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_pkey PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 18164)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3599 (class 2606 OID 19049)
-- Name: school_termins school_termins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_termins
    ADD CONSTRAINT school_termins_pkey PRIMARY KEY (id);


--
-- TOC entry 3597 (class 2606 OID 19040)
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 18304)
-- Name: synamizer synamizer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synamizer
    ADD CONSTRAINT synamizer_pkey PRIMARY KEY (id);


--
-- TOC entry 3591 (class 2606 OID 18311)
-- Name: synonyms synonyms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 18152)
-- Name: termin termin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termin
    ADD CONSTRAINT termin_pkey PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 18201)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3581 (class 2606 OID 18143)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3608 (class 2620 OID 19110)
-- Name: users insert_offer_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_offer_trigger AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.create_offer_trigger();


--
-- TOC entry 3606 (class 2606 OID 18193)
-- Name: user_role user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);


--
-- TOC entry 3607 (class 2606 OID 18188)
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2023-09-26 10:36:01 +06

--
-- PostgreSQL database dump complete
--

