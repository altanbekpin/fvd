PGDMP         6                {            userdb    15.1    15.1      9           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            :           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ;           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            <           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18108    legacy    TABLE     �   CREATE TABLE public.legacy (
    id integer NOT NULL,
    name character varying(255),
    path character varying(255),
    parent_id integer,
    is_file integer
);
    DROP TABLE public.legacy;
       public         heap    postgres    false            �            1259    18107    legacy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.legacy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.legacy_id_seq;
       public          postgres    false    215            =           0    0    legacy_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.legacy_id_seq OWNED BY public.legacy.id;
          public          postgres    false    214            �            1259    18117    page    TABLE     �   CREATE TABLE public.page (
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
       public          postgres    false    217            >           0    0    page_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;
          public          postgres    false    216            �            1259    18126    quote    TABLE       CREATE TABLE public.quote (
    id integer NOT NULL,
    quote character varying(512) NOT NULL,
    quote_by character varying(100),
    added_by character varying(100),
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated timestamp without time zone
);
    DROP TABLE public.quote;
       public         heap    postgres    false            �            1259    18125    quote_id_seq    SEQUENCE     �   CREATE SEQUENCE public.quote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.quote_id_seq;
       public          postgres    false    219            ?           0    0    quote_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.quote_id_seq OWNED BY public.quote.id;
          public          postgres    false    218            �            1259    18136    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_salt character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    18135    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    221            @           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    220            �           2604    18111 	   legacy id    DEFAULT     f   ALTER TABLE ONLY public.legacy ALTER COLUMN id SET DEFAULT nextval('public.legacy_id_seq'::regclass);
 8   ALTER TABLE public.legacy ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    18120    page id    DEFAULT     b   ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);
 6   ALTER TABLE public.page ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    18129    quote id    DEFAULT     d   ALTER TABLE ONLY public.quote ALTER COLUMN id SET DEFAULT nextval('public.quote_id_seq'::regclass);
 7   ALTER TABLE public.quote ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    18139    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            0          0    18108    legacy 
   TABLE DATA           D   COPY public.legacy (id, name, path, parent_id, is_file) FROM stdin;
    public          postgres    false    215   �        2          0    18117    page 
   TABLE DATA           S   COPY public.page (id, name, parent_id, content, is_deleted, is_hidden) FROM stdin;
    public          postgres    false    217   �)       4          0    18126    quote 
   TABLE DATA           P   COPY public.quote (id, quote, quote_by, added_by, created, updated) FROM stdin;
    public          postgres    false    219   �)       6          0    18136    users 
   TABLE DATA           H   COPY public.users (id, email, password_salt, password_hash) FROM stdin;
    public          postgres    false    221   �*       A           0    0    legacy_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.legacy_id_seq', 1, false);
          public          postgres    false    214            B           0    0    page_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.page_id_seq', 1, false);
          public          postgres    false    216            C           0    0    quote_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.quote_id_seq', 1, false);
          public          postgres    false    218            D           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public          postgres    false    220            �           2606    18115    legacy legacy_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.legacy
    ADD CONSTRAINT legacy_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.legacy DROP CONSTRAINT legacy_pkey;
       public            postgres    false    215            �           2606    18124    page page_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.page DROP CONSTRAINT page_pkey;
       public            postgres    false    217            �           2606    18134    quote quote_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.quote DROP CONSTRAINT quote_pkey;
       public            postgres    false    219            �           2606    18143    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    221            0   �  x��[]rG~^�b�Z~�DN��T�s	���� ˲Il���.W�O[�*@�y�]� '��u����.O0���===�=��3Mό����7���^t]x�ه`ՠg?zG5�\�s�C����`aNA�A�_~�ya�EL���F���fvI{՚o��$�!D���2#+�Ii�d�3��S߼����.�Öv9�hyO�sk�fȌ�N2��;�٬`I@��#/~��j��>�������љ��*�褹f��!$�G�~�^h`��S����אЕIQ�܊�C�@����M�#� 0�5�y�����8L��<���?jG���,a/���y�9f\��Q�aާ�c A����q���$j��o�K%V��$^)c�
`��!�}+�x�{	|�J��3���I�ԋN���_ a`Y�8n�B�h�AtF%'ѡ?:��X n�6	���q�]e��;k�%	U��7O��sX *# �#D��Og�)����N��󸔅؊�*p��
�q7L�X=��5b�,���6��>#�|K���p��J�݋�����*A1n��%P[	�Dp�-���>���%�f�=;ӓ�RX���C�Ir���dg%J��@����E�O����ws�I���>���6j����|=�\�\�Z���[��?�H3�� �㯹T����4���d�U�N2C�c,-ˣ��*���$�Z�n����+A�`J
��;�6�����0B����ngjN�Jgc��T%F�*t�a>WT������m��LJ �,_�k8ٞK�ދY�B)����!O�ʡrV��A^j fX�O��k�B5[X%A�~ȍ훗�S�d`n�J��5�%+
��Yt��k�^��sBTz���ʩ� �;a�P(�� Brb���n)�%�n$�ۙ�ӳ���j��$�G��dq�L��i��%вB(�ff{HD���T��gg"�N��\F'*s�lOH�És�}�HPPB��}rj]HM_/��Ɂ�tq���od+����[�lI��Q�Տ,�4j�_����T��3�#�n&��ì��uېE2���xn�Sb��^�o�[��2�� GMԅ�Nyh�5�=v� ��⡍2227P%����i�ύ���ַe�4��M6����c���9�q-&���J'5���9��W8��&�l	p��
�(��i��+�(�g�лzli�;�J�U��5�'3���=w�"1�V�����,M&�f;��"�2�0M'3���\M��.��ȓ�?e]7-��o.i��au�e�3�ʌ�Z,L,���7s�@�9���9q@�ɇ�e�$�р-���mu�9}W��%h���H���֨m���;�q�C��t.�W}�^����S�N��Oc�>�M-�f1긃�6�/a�����n�f"�)��<�^�ܼ�6-`��˃ �fk�;� �H�;0��R��r��F�m���Nz��*��G�$�&{�f�']qWJS<�/1�/Ռ8)}��,s�NAD��(C6�+r"�/��)�nq_��'S��s�9�&�w��Ϯ3�^�z틜Z��>kVw�R�^����V��֥[�fŰt� �]�o�� W94f�Gm�;�L�"4��S��l�y.��
���=��JӴ���Qv�.���f��Z�U9Zc�,Œ�O��ຌck*�u��kj�\���[��]k��٠�l�W��KR�.[%��`�\�4���`�Y�Dm�؋	jNu2�����{O��I�Rͽpa�*%��|Yb�'�9!������Y�����*�˳����6[Vz��pӓ�@�p���Z�i��O�C����n�V]g$�'-�[�Y��S�!��*A���q���Cw���uk�@rJ�r �;�K�9`��V2Rh��^�����ժ&	6��-cy#u*E��*�ey�W��RSk+�F���g@�nɳ��"�e+[Gպ���_����X~%/�����i�؞H�E�In1޷��׃�.�c�L�T���I��Qߢk�h��i��~�6qCQV���ȽV��D?�Qӊ���SX�������A�=z +-��F.��FS�r��05[f�v�m�D��r@6'G���Τ[,ɣ��w�7����S�ɕ͜ư�f-f�o�<����M�l+�~_/]Y$�a�����h�A���+e+����#I�8�35\��V+#�l��;���r;^��&���a2@��L�����K2���˘F�·S ���rpp�?Ω3      2      x������ � �      4   �   x�=�1R�0Ek�� I�2�(�hh�ȶ�ȖGZ%�hs��+Ȝ���g��˓[m	V�t�F�t�=��^�����	��[?��a����AR�^*%�`�[TF�;�Q*�@6ε����f�{3hX2�&g��Hl�$�@�.�4z�|$:h��g��igc�yg��J���V7�'��OX��2[/��e��K6w)K�kx'|����i:�O��<����"�����?�y^%[Ϡ�*M�o/gp�      6      x������ � �     