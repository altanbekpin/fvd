PGDMP     7            	        {            userdb    15.1    15.1     O           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            P           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            Q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            R           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18185 	   user_role    TABLE     e   CREATE TABLE public.user_role (
    user_id integer,
    role_id integer,
    id integer NOT NULL
);
    DROP TABLE public.user_role;
       public         heap    magzhanzhumabaev    false            �            1259    18198    user_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_role_id_seq;
       public          magzhanzhumabaev    false    224            S           0    0    user_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;
          public          magzhanzhumabaev    false    225            �           2604    18199    user_role id    DEFAULT     l   ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);
 ;   ALTER TABLE public.user_role ALTER COLUMN id DROP DEFAULT;
       public          magzhanzhumabaev    false    225    224            K          0    18185 	   user_role 
   TABLE DATA           9   COPY public.user_role (user_id, role_id, id) FROM stdin;
    public          magzhanzhumabaev    false    224   �       T           0    0    user_role_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_role_id_seq', 1, true);
          public          magzhanzhumabaev    false    225            �           2606    18201    user_role user_role_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_pkey;
       public            magzhanzhumabaev    false    224            �           2606    18193     user_role user_role_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);
 J   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_role_id_fkey;
       public          magzhanzhumabaev    false    224            �           2606    18188     user_role user_role_user_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 J   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_user_id_fkey;
       public          magzhanzhumabaev    false    224            K      x�3�4�4�2�B.C i����� !��     