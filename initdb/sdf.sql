PGDMP     -            	        {            userdb    15.1    15.1     M           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            N           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            O           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            P           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
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
       public          postgres    false    215            Q           0    0    legacy_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.legacy_id_seq OWNED BY public.legacy.id;
          public          postgres    false    214            �           2604    18111 	   legacy id    DEFAULT     f   ALTER TABLE ONLY public.legacy ALTER COLUMN id SET DEFAULT nextval('public.legacy_id_seq'::regclass);
 8   ALTER TABLE public.legacy ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            J          0    18108    legacy 
   TABLE DATA           D   COPY public.legacy (id, name, path, parent_id, is_file) FROM stdin;
    public          postgres    false    215   �
       R           0    0    legacy_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.legacy_id_seq', 100, true);
          public          postgres    false    214            �           2606    18115    legacy legacy_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.legacy
    ADD CONSTRAINT legacy_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.legacy DROP CONSTRAINT legacy_pkey;
       public            postgres    false    215            J   �  x��[]rG~^�b�Z~�DN��T�s	���� ˲Il���.W�O[�*@�y�]� '��u����.O0���===�=��3Mό����7���^t]x�ه`ՠg?zG5�\�s�C����`aNA�A�_~�ya�EL���F���fvI{՚o��$�!D���2#+�Ii�d�3��S߼����.�Öv9�hyO�sk�fȌ�N2��;�٬`I@��#/~��j��>�������љ��*�褹f��!$�G�~�^h`��S����אЕIQ�܊�C�@����M�#� 0�5�y�����8L��<���?jG���,a/���y�9f\��Q�aާ�c A����q���$j��o�K%V��$^)c�
`��!�}+�x�{	|�J��3���I�ԋN���_ a`Y�8n�B�h�AtF%'ѡ?:��X n�6	���q�]e��;k�%	U��7O��sX *# �#D��Og�)����N��󸔅؊�*p��
�q7L�X=��5b�,���6��>#�|K���p��J�݋�����*A1n��%P[	�Dp�-���>���%�f�=;ӓ�RX���C�Ir���dg%J��@����E�O����ws�I���>���6j����|=�\�\�Z���[��?�H3�� �㯹T����4���d�U�N2C�c,-ˣ��*���$�Z�n����+A�`J
��;�6�����0B����ngjN�Jgc��T%F�*t�a>WT������m��LJ �,_�k8ٞK�ދY�B)����!O�ʡrV��A^j fX�O��k�B5[X%A�~ȍ훗�S�d`n�J��5�%+
��Yt��k�^��sBTz���ʩ� �;a�P(�� Brb���n)�%�n$�ۙ�ӳ���j��$�G��dq�L��i��%вB(�ff{HD���T��gg"�N��\F'*s�lOH�És�}�HPPB��}rj]HM_/��Ɂ�tq���od+����[�lI��Q�Տ,�4j�_����T��3�#�n&��ì��uېE2���xn�Sb��^�o�[��2�� GMԅ�Nyh�5�=v� ��⡍2227P%����i�ύ���ַe�4��M6����c���9�q-&���J'5���9��W8��&�l	p��
�(��i��+�(�g�лzli�;�J�U��5�'3���=w�"1�V�����,M&�f;��"�2�0M'3���\M��.��ȓ�?e]7-��o.i��au�e�3�ʌ�Z,L,���7s�@�9���9q@�ɇ�e�$�р-���mu�9}W��%h���H���֨m���;�q�C��t.�W}�^����S�N��Oc�>�M-�f1긃�6�/a�����n�f"�)��<�^�ܼ�6-`��˃ �fk�;� �H�;0��R��r��F�m���Nz��*��G�$�&{�f�']qWJS<�/1�/Ռ8)}��,s�NAD��(C6�+r"�/��)�nq_��'S��s�9�&�w��Ϯ3�^�z틜Z��>kVw�R�^����V��֥[�fŰt� �]�o�� W94f�Gm�;�L�"4��S��l�y.��
���=��JӴ���Qv�.���f��Z�U9Zc�,Œ�O��ຌck*�u��kj�\���[��]k��٠�l�W��KR�.[%��`�\�4���`�Y�Dm�؋	jNu2�����{O��I�Rͽpa�*%��|Yb�'�9!������Y�����*�˳����6[Vz��pӓ�@�p���Z�i��O�C����n�V]g$�'-�[�Y��S�!��*A���q���Cw���uk�@rJ�r �;�K�9`��V2Rh��^�����ժ&	6��-cy#u*E��*�ey�W��RSk+�F���g@�nɳ��"�e+[Gպ���_����X~%/�����i�؞H�E�In1޷��׃�.�c�L�T���I��Qߢk�h��i��~�6qCQV���ȽV��D?�Qӊ���SX�������A�=z +-��F.��FS�r��05[f�v�m�D��r@6'G���Τ[,ɣ��w�7����S�ɕ͜ư�f-f�o�<����M�l+�~_/]Y$�a�����h�A���+e+����#I�8�35\��V+#�l��;���r;^��&���a2@��L�����K2���˘F�·S ���rpp�?Ω3     