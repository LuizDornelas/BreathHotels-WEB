PGDMP                     	    y            BreathHotels    13.4    13.4 F               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16394    BreathHotels    DATABASE     n   CREATE DATABASE "BreathHotels" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "BreathHotels";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16514    cartao    TABLE     D  CREATE TABLE public.cartao (
    cartaoid integer NOT NULL,
    numerocartao character varying(50) NOT NULL,
    nome_cartao character varying(50) NOT NULL,
    validade character varying(30) NOT NULL,
    codigo character varying(30) NOT NULL,
    bandeira character varying(30) NOT NULL,
    usuariofk integer NOT NULL
);
    DROP TABLE public.cartao;
       public         heap    postgres    false    3            �            1259    16517    cartao_cartaoid_seq    SEQUENCE     �   CREATE SEQUENCE public.cartao_cartaoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cartao_cartaoid_seq;
       public          postgres    false    200    3                       0    0    cartao_cartaoid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.cartao_cartaoid_seq OWNED BY public.cartao.cartaoid;
          public          postgres    false    201            �            1259    16519    consumos    TABLE     -  CREATE TABLE public.consumos (
    consumoid integer NOT NULL,
    item character varying(50) NOT NULL,
    valor numeric NOT NULL,
    quantidade integer NOT NULL,
    data timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    reservafk integer NOT NULL,
    itemfk integer NOT NULL
);
    DROP TABLE public.consumos;
       public         heap    postgres    false    3            �            1259    16526    consumos_consumoid_seq    SEQUENCE     �   CREATE SEQUENCE public.consumos_consumoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.consumos_consumoid_seq;
       public          postgres    false    3    202                       0    0    consumos_consumoid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.consumos_consumoid_seq OWNED BY public.consumos.consumoid;
          public          postgres    false    203            �            1259    16528 
   fornecedor    TABLE     �   CREATE TABLE public.fornecedor (
    fornecedorid integer NOT NULL,
    nome_fornecedor character varying(30) NOT NULL,
    valor_item numeric NOT NULL,
    itemfk integer NOT NULL
);
    DROP TABLE public.fornecedor;
       public         heap    postgres    false    3            �            1259    16534    fornecedor_fornecedorid_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_fornecedorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.fornecedor_fornecedorid_seq;
       public          postgres    false    3    204                       0    0    fornecedor_fornecedorid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.fornecedor_fornecedorid_seq OWNED BY public.fornecedor.fornecedorid;
          public          postgres    false    205            �            1259    16536    itens    TABLE     �   CREATE TABLE public.itens (
    itemid integer NOT NULL,
    item character varying(30) NOT NULL,
    valor numeric NOT NULL,
    quantidade integer NOT NULL,
    status character varying(30) NOT NULL
);
    DROP TABLE public.itens;
       public         heap    postgres    false    3            �            1259    16542    itens_itemid_seq    SEQUENCE     �   CREATE SEQUENCE public.itens_itemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.itens_itemid_seq;
       public          postgres    false    206    3                       0    0    itens_itemid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.itens_itemid_seq OWNED BY public.itens.itemid;
          public          postgres    false    207            �            1259    16544    login    TABLE     ,  CREATE TABLE public.login (
    loginid integer NOT NULL,
    login character varying(50) NOT NULL,
    senha character varying(50) NOT NULL,
    ativo character varying(30) DEFAULT 'Desativado'::character varying NOT NULL,
    tipo character varying(30) NOT NULL,
    fk_usuario integer NOT NULL
);
    DROP TABLE public.login;
       public         heap    postgres    false    3            �            1259    16548    login_id_seq    SEQUENCE     �   CREATE SEQUENCE public.login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.login_id_seq;
       public          postgres    false    208    3                       0    0    login_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.login_id_seq OWNED BY public.login.loginid;
          public          postgres    false    209            �            1259    16662    quartos    TABLE     F  CREATE TABLE public.quartos (
    id_quarto integer NOT NULL,
    quarto character varying(30) NOT NULL,
    tipo character varying(30) NOT NULL,
    camasolteiro integer NOT NULL,
    camacasal integer NOT NULL,
    status character varying(30) NOT NULL,
    reservafk integer,
    diaria numeric NOT NULL,
    CONSTRAINT quartos_camacasal_check CHECK (((camacasal >= 0) AND (camacasal <= 10))),
    CONSTRAINT quartos_camasolteiro_check CHECK (((camasolteiro >= 0) AND (camasolteiro <= 10))),
    CONSTRAINT quartos_diaria_check CHECK (((diaria >= (50)::numeric) AND (diaria <= (10000)::numeric))),
    CONSTRAINT quartos_status_check CHECK ((((status)::text = 'Disponível'::text) OR ((status)::text = 'Ocupado'::text))),
    CONSTRAINT quartos_tipo_check CHECK ((((tipo)::text = 'Simples'::text) OR ((tipo)::text = 'Luxo'::text)))
);
    DROP TABLE public.quartos;
       public         heap    postgres    false    3            �            1259    16660    quartos_id_quarto_seq    SEQUENCE     �   CREATE SEQUENCE public.quartos_id_quarto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.quartos_id_quarto_seq;
       public          postgres    false    215    3                       0    0    quartos_id_quarto_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.quartos_id_quarto_seq OWNED BY public.quartos.id_quarto;
          public          postgres    false    214            �            1259    16558    reservas    TABLE     �  CREATE TABLE public.reservas (
    reservaid integer NOT NULL,
    nomefunc character varying(50) NOT NULL,
    nomecli character varying(50) NOT NULL,
    entrada character varying(50) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    saida character varying(50) NOT NULL,
    valor numeric NOT NULL,
    quartofk integer NOT NULL,
    status character varying(30) NOT NULL,
    usuariofk integer NOT NULL
);
    DROP TABLE public.reservas;
       public         heap    postgres    false    3            �            1259    16565    reservas_reservaid_seq    SEQUENCE     �   CREATE SEQUENCE public.reservas_reservaid_seq
    AS integer
    START WITH 3000
    INCREMENT BY 1
    MINVALUE 3000
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.reservas_reservaid_seq;
       public          postgres    false    210    3                       0    0    reservas_reservaid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.reservas_reservaid_seq OWNED BY public.reservas.reservaid;
          public          postgres    false    211            �            1259    16567    usuario    TABLE     �  CREATE TABLE public.usuario (
    usuarioid integer NOT NULL,
    nome character varying(50) NOT NULL,
    rg character varying(30) NOT NULL,
    telefone character varying(20) NOT NULL,
    rua character varying(50) NOT NULL,
    numero character varying(10) NOT NULL,
    bairro character varying(50) NOT NULL,
    cidade character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    cep character varying(10) NOT NULL
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    3            �            1259    16570    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    212    3                       0    0    usuario_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.usuarioid;
          public          postgres    false    213            Q           2604    16572    cartao cartaoid    DEFAULT     r   ALTER TABLE ONLY public.cartao ALTER COLUMN cartaoid SET DEFAULT nextval('public.cartao_cartaoid_seq'::regclass);
 >   ALTER TABLE public.cartao ALTER COLUMN cartaoid DROP DEFAULT;
       public          postgres    false    201    200            S           2604    16573    consumos consumoid    DEFAULT     x   ALTER TABLE ONLY public.consumos ALTER COLUMN consumoid SET DEFAULT nextval('public.consumos_consumoid_seq'::regclass);
 A   ALTER TABLE public.consumos ALTER COLUMN consumoid DROP DEFAULT;
       public          postgres    false    203    202            T           2604    16574    fornecedor fornecedorid    DEFAULT     �   ALTER TABLE ONLY public.fornecedor ALTER COLUMN fornecedorid SET DEFAULT nextval('public.fornecedor_fornecedorid_seq'::regclass);
 F   ALTER TABLE public.fornecedor ALTER COLUMN fornecedorid DROP DEFAULT;
       public          postgres    false    205    204            U           2604    16575    itens itemid    DEFAULT     l   ALTER TABLE ONLY public.itens ALTER COLUMN itemid SET DEFAULT nextval('public.itens_itemid_seq'::regclass);
 ;   ALTER TABLE public.itens ALTER COLUMN itemid DROP DEFAULT;
       public          postgres    false    207    206            Y           2604    16665    quartos id_quarto    DEFAULT     v   ALTER TABLE ONLY public.quartos ALTER COLUMN id_quarto SET DEFAULT nextval('public.quartos_id_quarto_seq'::regclass);
 @   ALTER TABLE public.quartos ALTER COLUMN id_quarto DROP DEFAULT;
       public          postgres    false    214    215    215            W           2604    16576    reservas reservaid    DEFAULT     x   ALTER TABLE ONLY public.reservas ALTER COLUMN reservaid SET DEFAULT nextval('public.reservas_reservaid_seq'::regclass);
 A   ALTER TABLE public.reservas ALTER COLUMN reservaid DROP DEFAULT;
       public          postgres    false    211    210            �          0    16514    cartao 
   TABLE DATA           l   COPY public.cartao (cartaoid, numerocartao, nome_cartao, validade, codigo, bandeira, usuariofk) FROM stdin;
    public          postgres    false    200   <T                  0    16519    consumos 
   TABLE DATA           _   COPY public.consumos (consumoid, item, valor, quantidade, data, reservafk, itemfk) FROM stdin;
    public          postgres    false    202   �T                 0    16528 
   fornecedor 
   TABLE DATA           W   COPY public.fornecedor (fornecedorid, nome_fornecedor, valor_item, itemfk) FROM stdin;
    public          postgres    false    204   �U                 0    16536    itens 
   TABLE DATA           H   COPY public.itens (itemid, item, valor, quantidade, status) FROM stdin;
    public          postgres    false    206   'V                 0    16544    login 
   TABLE DATA           O   COPY public.login (loginid, login, senha, ativo, tipo, fk_usuario) FROM stdin;
    public          postgres    false    208   �V                 0    16662    quartos 
   TABLE DATA           n   COPY public.quartos (id_quarto, quarto, tipo, camasolteiro, camacasal, status, reservafk, diaria) FROM stdin;
    public          postgres    false    215   JW                 0    16558    reservas 
   TABLE DATA           t   COPY public.reservas (reservaid, nomefunc, nomecli, entrada, saida, valor, quartofk, status, usuariofk) FROM stdin;
    public          postgres    false    210   �W       
          0    16567    usuario 
   TABLE DATA           j   COPY public.usuario (usuarioid, nome, rg, telefone, rua, numero, bairro, cidade, estado, cep) FROM stdin;
    public          postgres    false    212   �Y                  0    0    cartao_cartaoid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cartao_cartaoid_seq', 18, true);
          public          postgres    false    201                       0    0    consumos_consumoid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.consumos_consumoid_seq', 23, true);
          public          postgres    false    203                       0    0    fornecedor_fornecedorid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.fornecedor_fornecedorid_seq', 14, true);
          public          postgres    false    205                        0    0    itens_itemid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.itens_itemid_seq', 20, true);
          public          postgres    false    207            !           0    0    login_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.login_id_seq', 6, true);
          public          postgres    false    209            "           0    0    quartos_id_quarto_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.quartos_id_quarto_seq', 12, true);
          public          postgres    false    214            #           0    0    reservas_reservaid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.reservas_reservaid_seq', 3018, true);
          public          postgres    false    211            $           0    0    usuario_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.usuario_id_seq', 7, true);
          public          postgres    false    213            `           2606    16578    cartao cartaoidpk 
   CONSTRAINT     U   ALTER TABLE ONLY public.cartao
    ADD CONSTRAINT cartaoidpk PRIMARY KEY (cartaoid);
 ;   ALTER TABLE ONLY public.cartao DROP CONSTRAINT cartaoidpk;
       public            postgres    false    200            b           2606    16580    consumos consumoidpk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.consumos
    ADD CONSTRAINT consumoidpk PRIMARY KEY (consumoid);
 >   ALTER TABLE ONLY public.consumos DROP CONSTRAINT consumoidpk;
       public            postgres    false    202            d           2606    16582    fornecedor fornecedoridpk 
   CONSTRAINT     a   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedoridpk PRIMARY KEY (fornecedorid);
 C   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedoridpk;
       public            postgres    false    204            f           2606    16584    itens item_name 
   CONSTRAINT     J   ALTER TABLE ONLY public.itens
    ADD CONSTRAINT item_name UNIQUE (item);
 9   ALTER TABLE ONLY public.itens DROP CONSTRAINT item_name;
       public            postgres    false    206            h           2606    16586    itens itemidpk 
   CONSTRAINT     P   ALTER TABLE ONLY public.itens
    ADD CONSTRAINT itemidpk PRIMARY KEY (itemid);
 8   ALTER TABLE ONLY public.itens DROP CONSTRAINT itemidpk;
       public            postgres    false    206            j           2606    16588    login login_name 
   CONSTRAINT     L   ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_name UNIQUE (login);
 :   ALTER TABLE ONLY public.login DROP CONSTRAINT login_name;
       public            postgres    false    208            l           2606    16590    login loginpk 
   CONSTRAINT     P   ALTER TABLE ONLY public.login
    ADD CONSTRAINT loginpk PRIMARY KEY (loginid);
 7   ALTER TABLE ONLY public.login DROP CONSTRAINT loginpk;
       public            postgres    false    208            r           2606    16675    quartos quartos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.quartos
    ADD CONSTRAINT quartos_pkey PRIMARY KEY (id_quarto);
 >   ALTER TABLE ONLY public.quartos DROP CONSTRAINT quartos_pkey;
       public            postgres    false    215            t           2606    16677    quartos quartos_quarto_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.quartos
    ADD CONSTRAINT quartos_quarto_key UNIQUE (quarto);
 D   ALTER TABLE ONLY public.quartos DROP CONSTRAINT quartos_quarto_key;
       public            postgres    false    215            n           2606    16594    reservas reservaidpk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservaidpk PRIMARY KEY (reservaid);
 >   ALTER TABLE ONLY public.reservas DROP CONSTRAINT reservaidpk;
       public            postgres    false    210            p           2606    16596    usuario usuariopk 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuariopk PRIMARY KEY (usuarioid);
 ;   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuariopk;
       public            postgres    false    212            x           2606    16597    login fk_usuario    FK CONSTRAINT     {   ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES public.usuario(usuarioid);
 :   ALTER TABLE ONLY public.login DROP CONSTRAINT fk_usuario;
       public          postgres    false    212    208    2928            w           2606    16607    fornecedor itemfk    FK CONSTRAINT     s   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT itemfk FOREIGN KEY (itemfk) REFERENCES public.itens(itemid);
 ;   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT itemfk;
       public          postgres    false    204    2920    206            {           2606    16690    quartos quartos_reservafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quartos
    ADD CONSTRAINT quartos_reservafk_fkey FOREIGN KEY (reservafk) REFERENCES public.reservas(reservaid);
 H   ALTER TABLE ONLY public.quartos DROP CONSTRAINT quartos_reservafk_fkey;
       public          postgres    false    215    2926    210            v           2606    16617    consumos reserva_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.consumos
    ADD CONSTRAINT reserva_fk FOREIGN KEY (reservafk) REFERENCES public.reservas(reservaid);
 =   ALTER TABLE ONLY public.consumos DROP CONSTRAINT reserva_fk;
       public          postgres    false    202    210    2926            z           2606    16685    reservas reservas_quartofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_quartofk_fkey FOREIGN KEY (quartofk) REFERENCES public.quartos(id_quarto);
 I   ALTER TABLE ONLY public.reservas DROP CONSTRAINT reservas_quartofk_fkey;
       public          postgres    false    2930    215    210            u           2606    16622    cartao usuario_fk    FK CONSTRAINT     {   ALTER TABLE ONLY public.cartao
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuariofk) REFERENCES public.usuario(usuarioid);
 ;   ALTER TABLE ONLY public.cartao DROP CONSTRAINT usuario_fk;
       public          postgres    false    2928    200    212            y           2606    16627    reservas usuariofk    FK CONSTRAINT     |   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT usuariofk FOREIGN KEY (usuariofk) REFERENCES public.usuario(usuarioid);
 <   ALTER TABLE ONLY public.reservas DROP CONSTRAINT usuariofk;
       public          postgres    false    2928    212    210            �   �   x�U��
�0E盯���$m�,�� .�����AD�p8��:Ђ�r6q8�+H7lAlp���ۼ��+���q�֚�"۶J{�H��,���]rL�B��	l�wO��X��#bE�|�|,�/�~�Oc�v{8o���B��)*m          �   x���AN1E��)r����q&Ͷ7�-��t$�JU�8>�L1A�����0��|���b0y5l���1%p6BDl���u~+�|���e�B�����cG��>0']������gv�������+��hԴRb1=�bI�Xq����=4@��]vՊ�o>/F�y!��d�Ey@c����2�=���	����4@V����+����ǈ�'�����|�C+�����[k� �{�         :   x�34��K-.�I�4�42�2�t�ONTp��I�4�4�2�.M*O��44�4����� 8/h         \   x�32�tN̬HTHIUH��O��I,I�44�45�t�,.���,K��2�N�K)�L� J��q�Hq��e��%����r�!���qqq �� !         �   x��ν
�0��އ�4m�"�V���&���M���Oo'q�Ng9�H�P�b�A�R5$�[B�>#١6�vn���HTЎ�z��A��@Ƒ�l,SRM��K)�p�O^gvs
��B�JN1�S�G�T,Vp����p͞��b�kϟ�ty�C�o�x}k�         �   x�u�=
�@�������dwm,E�4�)��/�)������~cp�q~e�~���^��	��x�K��n*Fj#�I�.�|���=�X���k�~d�)��
��
X��qkh��;�L�?��}]�C�         �  x����N�0���S�Zy���B�\�b!Km"ܴ��u�đ��H�2;;�`�����"���~�	gVL�@R�VgH�#�\w��{��D�1���n�;�� � Aj����y.h"��2�$�$��t �$#��޽;��+.)�FV��� -L0<`T�hk�����o�`v��w��`t�H�<	5
u �"��E`��zk;�>���_^��`�U�;�13<���E@d녀/�	����M�:px5
�I��m�H�����D/6;��S��*9"�
��d���S�h��\V�>3ո�1U���b��R8��#��و����B�8�z�A# �K����y��]����ֺ�d'9[
	��aޭ���4����e����k��},ĥ7�@�jX5�k$�Z�Y%�@+�W�Mg?��j��@���aj1�*^�EQ|��q�      
   �  x�}��n�0���SpL䑔�QiP�Acvѩ�%�]��P��M�G��$�h�X �#�������g��7)��^lIlB}"�S�kj�9�������p67XP�:y@O��� ��cL]����>�h+>���[�\~G�����fe�seT���.��@��ϔ��0�6Jt���G���xd��va�Œ�6� ��Fv��I6��13P�a�֋�ɇ��oc+6�t��p��ܹ|~�����ևfl5ؙ����5���J�,˴^T���-����w��q,���$��C�h��!]�Y��nm17l4�s5!�M����k֒z:����z,Ⱥ�ђUh~��ؕ��^R���|5�<V��L4X�J٬�u|��><$ڳOV�Ǝ#ګ��r�ja-Ţ�c��w������ݏ&)*�9X�41����k#�:Yhw�m4�e>��i����� m��-#/]udW^� n�93*w��~�,�� �D�     