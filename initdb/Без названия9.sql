PGDMP                 	        {            userdb    15.1    15.1     I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            L           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18293 
   tag_legacy    TABLE     `   CREATE TABLE public.tag_legacy (
    tag_id integer NOT NULL,
    legacy_id integer NOT NULL
);
    DROP TABLE public.tag_legacy;
       public         heap    postgres    false            F          0    18293 
   tag_legacy 
   TABLE DATA           7   COPY public.tag_legacy (tag_id, legacy_id) FROM stdin;
    public          postgres    false    229          F      x�3�4�2�4�2洴�2�47����� $k     