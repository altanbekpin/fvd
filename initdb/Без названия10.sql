PGDMP                 	        {            userdb    15.1    15.1     M           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            N           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            O           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            P           1262    17351    userdb    DATABASE     �   CREATE DATABASE userdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE userdb;
                postgres    false            �            1259    18146    termin    TABLE     �   CREATE TABLE public.termin (
    id bigint NOT NULL,
    name character varying(250),
    description text,
    examples text
);
    DROP TABLE public.termin;
       public         heap    postgres    false            �            1259    18211 	   my_serial    SEQUENCE     �   CREATE SEQUENCE public.my_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.my_serial;
       public          postgres    false    222            Q           0    0 	   my_serial    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.my_serial OWNED BY public.termin.id;
          public          postgres    false    226            �           2604    18212 	   termin id    DEFAULT     b   ALTER TABLE ONLY public.termin ALTER COLUMN id SET DEFAULT nextval('public.my_serial'::regclass);
 8   ALTER TABLE public.termin ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    222            I          0    18146    termin 
   TABLE DATA           A   COPY public.termin (id, name, description, examples) FROM stdin;
    public          postgres    false    222   ?
       R           0    0 	   my_serial    SEQUENCE SET     8   SELECT pg_catalog.setval('public.my_serial', 65, true);
          public          postgres    false    226            �           2606    18152    termin termin_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.termin
    ADD CONSTRAINT termin_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.termin DROP CONSTRAINT termin_pkey;
       public            postgres    false    222            I      x��\]nI�~&OQ�6��%�������g�Djf���7<���z���za`MB�(�I�OP�o�'و�"2#��(��X`l���2#"�?#j���ms�L6��a��q3܌6gͲ���u]5�/��̚�f*?7G|��4�f�!U����6�ދ�����]ݺ��ͨo?�kcZ��Sŕ�a�U�����1ͻ�g��j3 /7g��9�Y/�	�%Np)/ҏ��;�{U�ߏOi�q��͸ڞ�Gtc���q�r]m?mN�[���6��Ӛk��"�� �m2D1��S~4f�98H�'�B�2�ߣ��	��?�|s�^���Ǹ�k�c���Y��3�3�K�uA /y�+���& ��-���u������iA3��%OTd��,�|w�wGh���g�dx#d�a�,hBZ�V�v|R��3�;Kf�:�޺ޣ�zAB �LF��ߔ�h;N��x��B���,͸�4ñ����Bߞ�k����'<:癚.��M�h���v¼*R�OLy)!&6�I8'�z%�=&�O���a�׌5�W�	�C��^mυ�E6���+��cJ�MFB�4���%p��W�Ǔ#����z��+�� ����H��^d��#�aɛ`?Ơ������?%N�~�D����
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
m��݂�O������J����������+��/�������ڬ�;gt5�������1�\��ĩ�����5W��oM��%i����X�9���ݓK���D�������sĸv���;�GeJ�����{%ɼ�v���{mP2�U@�?�0C5�]l'���=O�"0��m�*�Ѽreyc�������Sp���'�zw~Ύ�m�,��-���l����xI�]����B�a�K�(�)��^� [�H&��+]W�:|��.�3zYn�u��i�k���Viڭ��롩���z苗����w����Y$�F�#4�|���Dz~m���h��O1ه��)���6��M��EU���f/�_9 x��I�&vp�"�O��ю�#�J'`b��~�d��b�X�w����Ik���1��|��zg�$����Hc�2���������s     