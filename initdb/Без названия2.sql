PGDMP     
            	        {            userdb    15.1    15.1     M           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            N           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            O           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            P           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18348 	   morphemes    TABLE     �   CREATE TABLE public.morphemes (
    id integer NOT NULL,
    morphem character varying,
    pos integer,
    ismoderated integer
);
    DROP TABLE public.morphemes;
       public         heap    postgres    false            �            1259    18347    morphemes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.morphemes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.morphemes_id_seq;
       public          postgres    false    239            Q           0    0    morphemes_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.morphemes_id_seq OWNED BY public.morphemes.id;
          public          postgres    false    238            �           2604    18351    morphemes id    DEFAULT     l   ALTER TABLE ONLY public.morphemes ALTER COLUMN id SET DEFAULT nextval('public.morphemes_id_seq'::regclass);
 ;   ALTER TABLE public.morphemes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            J          0    18348 	   morphemes 
   TABLE DATA           B   COPY public.morphemes (id, morphem, pos, ismoderated) FROM stdin;
    public          postgres    false    239   �
       R           0    0    morphemes_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.morphemes_id_seq', 195, true);
          public          postgres    false    238            �           2606    18355    morphemes morphemes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.morphemes
    ADD CONSTRAINT morphemes_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.morphemes DROP CONSTRAINT morphemes_pkey;
       public            postgres    false    239            J   �  x�]VKn�8]3w��(���e;h����E� A���U��8?rʹмWU��,��"���Uy7��n�q����M�i{ypB��.���i�T��ⵜG��r�u�Є�]�Y�ɇ���ik��K�i�g����{���һ{O#{3�k��q��4�z:��喾魨�hTӊ��`�r/c~ep�Ѿ���+�[sQ����USn�>�$u�_�G{���szs=���vV�J�h~M
nZY��(�N'�V��~�免d�lIk��gx�+���<l�Id!�I��'�P��������ӝ���x��j/�ޗ�R�����/Dgߨ�~�;���;}��l�`O�fa�����G���<j]q����~�@)���~��=x����/��Vӝ���84�H��~g�X��w$<iQq\}A�w���jWP������*�9�������"�����xe���jQ�=k]2�U���^��k~(�t��Ț�6��5��,���H��Dg�~�R��x���WR���"����/�L���U��׮��e��a������p�ʝ�9��(�^���*[o��,��6�%2�Z�34Z�c��"�^5Q��n�|yC��i��mx6"����A�uf��p,��W�G?M���L�F����������b�WQ{�e�j�pqU��n�A猳Ud#�SQ�W#9˘~?-)܍��� ^��'�p���K6�6�8�q9��-*i��	�SÝ���^���TU�!��mr��|�D���ol�k����׭�0w��;�&Gdy_����Ճ�\��Td�Xf$��bz`J����6�\D�(��-���̄���k&�Y"��Lj���M�V��Z�lI�ȷ!�C��͗�1Ep�o�c��=�J:h={:����T�1��a*��b�E���:�a���I�B�O7d(SI��,���fף���e��:��/Ɖ��AF��5J��cʬ��7�|��(�;����d�2��.����9�v�Q
���֍k��S��f̓ADJX�N�E��F���<���z���5�ߕlu���+�x-��0[[�?��L�B��ne�b��'kq�;ٯ��)�F�(W/��t��(1I�p����P�0w��6���e�:��a"�&���&�T�`��f�˰����'%�+�/dK����z���j��s?ҏ��r�d�%�M;�C���<�rfK���l*��������8     