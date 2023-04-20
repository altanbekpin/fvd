PGDMP     4                    {            userdb    15.1    15.1 /    S           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            T           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            U           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            V           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
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
       public          postgres    false    215            W           0    0    legacy_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.legacy_id_seq OWNED BY public.legacy.id;
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
       public          postgres    false    217            X           0    0    page_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;
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
       public          postgres    false    219            Y           0    0    quote_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.quote_id_seq OWNED BY public.quote.id;
          public          postgres    false    218            �            1259    18160    role    TABLE     `   CREATE TABLE public.role (
    role_id integer NOT NULL,
    name text,
    description text
);
    DROP TABLE public.role;
       public         heap    magzhanzhumabaev    false            �            1259    18146    termin    TABLE     �   CREATE TABLE public.termin (
    id bigint NOT NULL,
    name character varying(250),
    description text,
    examples text
);
    DROP TABLE public.termin;
       public         heap    postgres    false            �            1259    18185 	   user_role    TABLE     e   CREATE TABLE public.user_role (
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
       public          magzhanzhumabaev    false    224            Z           0    0    user_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;
          public          magzhanzhumabaev    false    225            �            1259    18136    users    TABLE     �   CREATE TABLE public.users (
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
       public          postgres    false    221            [           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    220            �           2604    18111 	   legacy id    DEFAULT     f   ALTER TABLE ONLY public.legacy ALTER COLUMN id SET DEFAULT nextval('public.legacy_id_seq'::regclass);
 8   ALTER TABLE public.legacy ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    18120    page id    DEFAULT     b   ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);
 6   ALTER TABLE public.page ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    18129    quote id    DEFAULT     d   ALTER TABLE ONLY public.quote ALTER COLUMN id SET DEFAULT nextval('public.quote_id_seq'::regclass);
 7   ALTER TABLE public.quote ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    18199    user_role id    DEFAULT     l   ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);
 ;   ALTER TABLE public.user_role ALTER COLUMN id DROP DEFAULT;
       public          magzhanzhumabaev    false    225    224            �           2604    18139    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            F          0    18108    legacy 
   TABLE DATA           D   COPY public.legacy (id, name, path, parent_id, is_file) FROM stdin;
    public          postgres    false    215   t1       H          0    18117    page 
   TABLE DATA           S   COPY public.page (id, name, parent_id, content, is_deleted, is_hidden) FROM stdin;
    public          postgres    false    217   J:       J          0    18126    quote 
   TABLE DATA           P   COPY public.quote (id, quote, quote_by, added_by, created, updated) FROM stdin;
    public          postgres    false    219   g:       N          0    18160    role 
   TABLE DATA           :   COPY public.role (role_id, name, description) FROM stdin;
    public          magzhanzhumabaev    false    223   t;       M          0    18146    termin 
   TABLE DATA           A   COPY public.termin (id, name, description, examples) FROM stdin;
    public          postgres    false    222   �;       O          0    18185 	   user_role 
   TABLE DATA           9   COPY public.user_role (user_id, role_id, id) FROM stdin;
    public          magzhanzhumabaev    false    224   ^S       L          0    18136    users 
   TABLE DATA           H   COPY public.users (id, email, password_salt, password_hash) FROM stdin;
    public          postgres    false    221   �S       \           0    0    legacy_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.legacy_id_seq', 1, false);
          public          postgres    false    214            ]           0    0    page_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.page_id_seq', 1, false);
          public          postgres    false    216            ^           0    0    quote_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.quote_id_seq', 1, false);
          public          postgres    false    218            _           0    0    user_role_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_role_id_seq', 1, true);
          public          magzhanzhumabaev    false    225            `           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
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
       public            postgres    false    219            �           2606    18164    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            magzhanzhumabaev    false    223            �           2606    18152    termin termin_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.termin
    ADD CONSTRAINT termin_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.termin DROP CONSTRAINT termin_pkey;
       public            postgres    false    222            �           2606    18201    user_role user_role_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_pkey;
       public            magzhanzhumabaev    false    224            �           2606    18143    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    221            �           2606    18193     user_role user_role_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);
 J   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_role_id_fkey;
       public          magzhanzhumabaev    false    223    3506    224            �           2606    18188     user_role user_role_user_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 J   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_user_id_fkey;
       public          magzhanzhumabaev    false    221    224    3502            F   �  x��[]rG~^�b�Z~�DN��T�s	���� ˲Il���.W�O[�*@�y�]� '��u����.O0���===�=��3Mό����7���^t]x�ه`ՠg?zG5�\�s�C����`aNA�A�_~�ya�EL���F���fvI{՚o��$�!D���2#+�Ii�d�3��S߼����.�Öv9�hyO�sk�fȌ�N2��;�٬`I@��#/~��j��>�������љ��*�褹f��!$�G�~�^h`��S����אЕIQ�܊�C�@����M�#� 0�5�y�����8L��<���?jG���,a/���y�9f\��Q�aާ�c A����q���$j��o�K%V��$^)c�
`��!�}+�x�{	|�J��3���I�ԋN���_ a`Y�8n�B�h�AtF%'ѡ?:��X n�6	���q�]e��;k�%	U��7O��sX *# �#D��Og�)����N��󸔅؊�*p��
�q7L�X=��5b�,���6��>#�|K���p��J�݋�����*A1n��%P[	�Dp�-���>���%�f�=;ӓ�RX���C�Ir���dg%J��@����E�O����ws�I���>���6j����|=�\�\�Z���[��?�H3�� �㯹T����4���d�U�N2C�c,-ˣ��*���$�Z�n����+A�`J
��;�6�����0B����ngjN�Jgc��T%F�*t�a>WT������m��LJ �,_�k8ٞK�ދY�B)����!O�ʡrV��A^j fX�O��k�B5[X%A�~ȍ훗�S�d`n�J��5�%+
��Yt��k�^��sBTz���ʩ� �;a�P(�� Brb���n)�%�n$�ۙ�ӳ���j��$�G��dq�L��i��%вB(�ff{HD���T��gg"�N��\F'*s�lOH�És�}�HPPB��}rj]HM_/��Ɂ�tq���od+����[�lI��Q�Տ,�4j�_����T��3�#�n&��ì��uېE2���xn�Sb��^�o�[��2�� GMԅ�Nyh�5�=v� ��⡍2227P%����i�ύ���ַe�4��M6����c���9�q-&���J'5���9��W8��&�l	p��
�(��i��+�(�g�лzli�;�J�U��5�'3���=w�"1�V�����,M&�f;��"�2�0M'3���\M��.��ȓ�?e]7-��o.i��au�e�3�ʌ�Z,L,���7s�@�9���9q@�ɇ�e�$�р-���mu�9}W��%h���H���֨m���;�q�C��t.�W}�^����S�N��Oc�>�M-�f1긃�6�/a�����n�f"�)��<�^�ܼ�6-`��˃ �fk�;� �H�;0��R��r��F�m���Nz��*��G�$�&{�f�']qWJS<�/1�/Ռ8)}��,s�NAD��(C6�+r"�/��)�nq_��'S��s�9�&�w��Ϯ3�^�z틜Z��>kVw�R�^����V��֥[�fŰt� �]�o�� W94f�Gm�;�L�"4��S��l�y.��
���=��JӴ���Qv�.���f��Z�U9Zc�,Œ�O��ຌck*�u��kj�\���[��]k��٠�l�W��KR�.[%��`�\�4���`�Y�Dm�؋	jNu2�����{O��I�Rͽpa�*%��|Yb�'�9!������Y�����*�˳����6[Vz��pӓ�@�p���Z�i��O�C����n�V]g$�'-�[�Y��S�!��*A���q���Cw���uk�@rJ�r �;�K�9`��V2Rh��^�����ժ&	6��-cy#u*E��*�ey�W��RSk+�F���g@�nɳ��"�e+[Gպ���_����X~%/�����i�؞H�E�In1޷��׃�.�c�L�T���I��Qߢk�h��i��~�6qCQV���ȽV��D?�Qӊ���SX�������A�=z +-��F.��FS�r��05[f�v�m�D��r@6'G���Τ[,ɣ��w�7����S�ɕ͜ư�f-f�o�<����M�l+�~_/]Y$�a�����h�A���+e+����#I�8�35\��V+#�l��;���r;^��&���a2@��L�����K2���˘F�·S ���rpp�?Ω3      H      x������ � �      J   �   x�=�1R�0Ek�� I�2�(�hh�ȶ�ȖGZ%�hs��+Ȝ���g��˓[m	V�t�F�t�=��^�����	��[?��a����AR�^*%�`�[TF�;�Q*�@6ε����f�{3hX2�&g��Hl�$�@�.�4z�|$:h��g��igc�yg��J���V7�'��OX��2[/��e��K6w)K�kx'|����i:�O��<����"�����?�y^%[Ϡ�*M�o/gp�      N   `   x�%�Q
�0��)�	�<�dk��m"Mz��1��l���r��i�����0M��n�Y���5
O*�%P;�sKu�����|G�<>z?����H�'�      M      x��\]nI�~&OQ�6��%�������g�Djf���7<���z���za`MB�(�I�OP�o�'و�"2#��(��X`l���2#"�?#j���ms�L6��a��q3܌6gͲ���u]5�/��̚�f*?7G|��4�f�!U����6�ދ�����]ݺ��ͨo?�kcZ��Sŕ�a�U�����1ͻ�g��j3 /7g��9�Y/�	�%Np)/ҏ��;�{U�ߏOi�q��͸ڞ�Gtc���q�r]m?mN�[���6��Ӛk��"�� �m2D1��S~4f�98H�'�B�2�ߣ��	��?�|s�^���Ǹ�k�c���Y��3�3�K�uA /y�+���& ��-���u������iA3��%OTd��,�|w�wGh���g�dx#d�a�,hBZ�V�v|R��3�;Kf�:�޺ޣ�zAB �LF��ߔ�h;N��x��B���,͸�4ñ����Bߞ�k����'<:癚.��M�h���v¼*R�OLy)!&6�I8'�z%�=&�O���a�׌5�W�	�C��^mυ�E6���+��cJ�MFB�4���%p��W�Ǔ#����z��+�� ����H��^d��#�aɛ`?Ơ������?%N�~�D����
��+�P��1��5Ua��vҬD�4�oh͑����O��5]ݲ�Ѕ@���^��hfH4	#D	+Ʋ[�鍰�!�Sկι'(�#��?d���i��|�:���B>a%晐e- �{���Ǌ%��3�S�}�pk���ϣ���	)R�\}r ��ވ&�E�B_~F��+�m9O�F\|�c&�e��~i̮" �dt">�L�kӞ^����w�6�	����q�������ex����q QOG�xh����L_M��{O�|w/e�2r�7��ʣR W�QGT���5dDm	܏!S��Ɩ��q5���d^J���H���b)���z͟�}d�/T�ܓU_��Nx'a=�A}y
���NVyh�
���e��Ɛ��fjjD���6(����N�WI�_@�'#��d\�[��që)��L�f�<�� �����e��3�G1�⣈�� 9�Q���.�$e��:�P�ͻCt�؁��$ЌE���`���C��l��<0 ��� f�|B��jѿ��{Ĉ�߽fB�<�5��D����Q��?�+^����DJ�S�p��]ɍ����&�,{�Ql�Q4�%Ed6�ef	����cV��]3R\.[�2��f:�x�G���-�L9|���/�}�W��	]�p���d�Y����MĬ�8���̘���7jo3������&aO��Hyh��!]���9�nW|����hs����Q3.��i��g
,Y8��9Jް�̓g<�A��	B9�D�����
Q�H�	k��t��l(0�8b�Q�s�f��)�{�8!a�sł~��R�rat����̈:���[�8�����)�l� k)8~�)�_+����H,���{�XH]����%o�ں70Y�8�t�T�+v�m�c!�,�֚�����r�iٗ�.����	���h�\�m�["n'�c�熳!F�@���$L)�� ĥ<x�J�Znx�U�_W��Q��S7����_���]#x��w��!���eǨ'4�=�\=����^�3o�2!�m��V�q�5�ʭj1]�氤^���`$~�&�iװ�J}M����"�KD�Tc}�p�lK��o[��k7":36���)�1����IUt�a�+�`���T�h�-xR��R]��Վͭި�b���U7���<��`�xq�ü��/^z���<�z��qN��͵�$����h���]^A�AȐ;dNaT�'���=��s�&�U)���_#
N2����_@JR�~�J��MYC�������o-DR�$�Fp��G�aB)��.M<��e��2�.|�6�d�7�̟�o�����+��Lb�ai����wm,�?���]����z�T���=��7SQ� &�
��t��r�p����Ǿ)�t�F}(��b��֑m�ȁ��j}Z02a��=,=���e�`�P�#�S����90ёR�����Z��<��$'��J�H��~B*M~͡�-�,�����߹$ K��>E0�nLh��c%�^V��ʯ��e�&@��G����p	7�E��R����h�`8T�g_T��i�5���U�"�(�	V�HB������ܒip�$?�C����׼�T88�����C�q�3z���7"��[���į\k�ٵ��l��lLH�u4��MS�юw?ַE��(N�����P�)v��$1�a�H]�ɂ��[�hrX�l�>gXh�c����5g�$�
��T��	���Z$�����v�UE�����f>@l��}w��q�7$Sti�i�^!>Nnm�yBa\ML��h�5�/���甧�Gv���f�mzz�����@��`�ᔜ4���Z9���W����/�����"���w���������W�4s88�BG�r���i1��C��,��+5Á����^� >�����h0		_�Cҿ�,��d�B���$<W���_ٽ3�M��*Ο����tO�{X���Rh$]9o��>�-@�G�Zr쟁w��%���H�z�@�Ee�W���1s��H����X2���JHX�� <�?�ey8�o#{Q��Θ�E�6&<cte6���x�����p&��?�D���̯Ⓠ9
.��	=I�Y�.PC|����Zȉ�Z�Z��7b��K̢'�����������7�B���'���g��"���I�dd����� ]QN���!�sS;%��@q�ڔ�l��X'�q/N�R+����&��J��\�#8%��O�#=gi-�\�E\��h����\La�w�]m@�j�҂#I��IϘ�Pѵ�H��0�k\�9�M-%�bS�Nl}
c��eR�v��6`j2g]�V!������gr�q$���,�F)�k*)��`�4M.��Bv�V8�D3���"��_��8�;�*naz����D�*�Ti��o��*���F���D�cy6���%U-���%���fB+JP!^��.�8N�b� t��*����nd�.��������R�K�v�w����"&�"9�;B��Ʈ5iziWF&�b9�WI&������#H��h����f_J8�B^��f��101��y�R���[��^�`Q�?�79��iw���e�q¾keArn���g�>���M~̍�I`���3�W|����bg	["��~`!
���yF�����+gv��4� �|xe��d�������7!���R���g�{�x��R3�m���X�����9����(���rܨ(��E-Ip(�9�E;C�(ʨE��(��P�Q��#(❈���x��E.ݼ|�	�Z����]NP�54����^D����+"QK˔�=Uԇ2E��Sfʭ;���]����Z
�3��*>��Pu9���^	f̯��A"` xQ0�s�H��g���y�墒�W ^?2'^"#S*J�nJ�D��(\F�|e�I�.%[�he��k�+'V�T9�Jd��r���d�}ka�L�[�����s��f[x,wA�nZ�t�	��b#�%��ֆ�+��,�ƿK!�ŀ�?B?Y5����鴋�c���}���9�hvp�쉿�s��I�:mr_"��ק�Ѡ��a�,,�D�j��W��X��B���sZG_�+0h��d��H)=��;&Cꡅ���Z��Ҥ�����z1���n�xV�*F�J���f���f�����.f����vV�d�U��|�	���ZG�r��3>�pFnY'���CHס5
S�p�Hqp�j�����ϡwŭYMe��2��SϾRf����9��`�~c�8�s��2?���1��o��'q�u����y�ӏQ��י��o�> ЙC`s�@@�Q��P$�R���R�4aTx��J�	�d�BJ-aJ�x���4q@(i�%��Ia��+�	Hp����z�PD��ǧ�E�KZ��1��@��O+r. e  ʟ�AG�Q.����'qу/Ӽ$��w�qH��^&�q嘤�橔�o���ے�?�c�.��
Y�׍Y�,|s�f&Q��0�v�u��ݓj}/��ß�����q������%"�H�)]6���ƝG�l<J+{��U�������;G�#N�{��D$��>v��K�p��_��t,�lidK_j���ol����,`�Lw-��o�u|�m��}��5��(�B�H��Vr+5$C+E]�Tr]��̎���m�UTa1�g�����U�Z�9�YW�g�tn#��Zi����'���ZG��j;i	��NO#�8u��v����)��Y׎nu����r�3K���z��~Ņm�n��_�%}_�+���/7���=�]%��R[[+������/�t.��Z%�w��x��a	r�t7��h����DXbU{��G�\qٲ�U��[}3VLyGz_("�D'Pb2�
�_;t$�b��?�֩�����c�y�((���V��U��
�3��]a�r�Ì,m�0e�" zF�"���e�fyi;��a�34�[�9'"_|y�>��J�J΄.����N�Jɝ�7��Gݦ�E�E�^���̘�RBk9C��NT���Y��!�g9s*�W8�[KY��,[�?G�-�6t�tq[m .ݐ��b�Zɸ��+C�٫���/.��+���t;�e�o�t���Ҧk�߬�q��
w$Fqj�j*Ǧž��D�HSDa�5������,�U�ǎg�2����c�
�j�܍��^�V���*�Wn�C�5�U~�V����@	-KxG���5?�wQn�E�'�m�D�jZG� �İx�ʎ��{�Sy���@j�K�����֪\Z)R��c��M�����P2��@)�R]un���� voEK���Gl�}�&��m��ʡQųD�I����h`� ]h�f�x {�#4��?��iȋ�O�x)K3�R�+�>(�������Z�h�M�j��u��ar����8����8������lV�:��| ���oU�6V@1�qId�j�t���'mv(6����/ Y�Xn���i������汑�<���W,��.���5i֠�Ք�k��v@�}*�5��Q�+��ٺj�J���?<��[�f��]��{%���w��$�O큾�YV]j����6�%�o��FW� N��#�j��k�gI��X�\?���������	�k�i��NK���D�ѓƾC������3��Ym�{貍��m��SGa��l�z�#ەB�mˡ��e�.B����<v����*+M���d��>m�dX��9Q�͖�h�'�怴gI���>�Ë�}#�!"prƚ�ku���Z+�:����M�~�Dk�]���sa�9r����S�(���_��:"$�}qD�LA�	U
m��݂�O������J����������+��/�������ڬ�;gt5�������1�\��ĩ�����5W��oM��%i����X�9���ݓK���D�������sĸv���;�GeJ�����{%ɼ�v���{mP2�U@�?�0C5�]l'���=O�"0��m�*�Ѽreyc�������Sp���'�zw~Ύ�m�,��-���l����xI�]����B�a�K�(�)��^� [�H&��+]W�:|��.�3zYn�u��i�k���Viڭ��롩���z苗����w����Y$�F�#4�|���Dz~m���h��O1ه��)���6��M��EU���f/�_9 x��I�&vp�"�O��ю�#�J'`b��~�d��b�X�w����Ik���1��|��zg�$����Hc�2���������s      O      x�3�4�4�2�B.C i����� !��      L   ;   x�3�,I-.�4426153��3��8sӫ2�L,�s3s���sQ�r��qqq U�d     