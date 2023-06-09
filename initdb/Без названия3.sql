PGDMP     %            	        {            userdb    15.1    15.1     M           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            N           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            O           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            P           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18117    page    TABLE     �   CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    content character varying(255),
    is_deleted boolean,
    is_hidden boolean
);
    DROP TABLE public.page;
       public         heap    postgres    false            �            1259    18116    page_id_seq    SEQUENCE     �   CREATE SEQUENCE public.page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.page_id_seq;
       public          postgres    false    217            Q           0    0    page_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;
          public          postgres    false    216            �           2604    18120    page id    DEFAULT     b   ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);
 6   ALTER TABLE public.page ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            J          0    18117    page 
   TABLE DATA           S   COPY public.page (id, name, parent_id, content, is_deleted, is_hidden) FROM stdin;
    public          postgres    false    217   �
       R           0    0    page_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.page_id_seq', 1, false);
          public          postgres    false    216            �           2606    18124    page page_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.page DROP CONSTRAINT page_pkey;
       public            postgres    false    217            J      x������ � �     