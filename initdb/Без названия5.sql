PGDMP     .            	        {            userdb    15.1    15.1     K           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            L           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            M           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            N           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18160    role    TABLE     `   CREATE TABLE public.role (
    role_id integer NOT NULL,
    name text,
    description text
);
    DROP TABLE public.role;
       public         heap    magzhanzhumabaev    false            H          0    18160    role 
   TABLE DATA           :   COPY public.role (role_id, name, description) FROM stdin;
    public          magzhanzhumabaev    false    223   6       �           2606    18164    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            magzhanzhumabaev    false    223            H   `   x�%�Q
�0��)�	�<�dk��m"Mz��1��l���r��i�����0M��n�Y���5
O*�%P;�sKu�����|G�<>z?����H�'�     