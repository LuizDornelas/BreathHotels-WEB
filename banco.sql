PGDMP     2    	            	    y            BreathHotels    13.4    13.4 A               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            
           1262    16394    BreathHotels    DATABASE     n   CREATE DATABASE "BreathHotels" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "BreathHotels";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16540    cartao    TABLE       CREATE TABLE public.cartao (
    cartaoid integer NOT NULL,
    numerocartao character varying(50),
    nome character varying(50),
    validade character varying(30),
    codigo character varying(30),
    bandeira character varying(30),
    usuariofk integer
);
    DROP TABLE public.cartao;
       public         heap    postgres    false    3            �            1259    16543    cartao_cartaoid_seq    SEQUENCE     �   CREATE SEQUENCE public.cartao_cartaoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cartao_cartaoid_seq;
       public          postgres    false    200    3                       0    0    cartao_cartaoid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.cartao_cartaoid_seq OWNED BY public.cartao.cartaoid;
          public          postgres    false    201            �            1259    16545    consumos    TABLE     �   CREATE TABLE public.consumos (
    consumoid integer NOT NULL,
    item character varying(50),
    valor numeric,
    quantidade integer,
    data timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    reservafk integer,
    itemfk integer
);
    DROP TABLE public.consumos;
       public         heap    postgres    false    3            �            1259    16552    consumos_consumoid_seq    SEQUENCE     �   CREATE SEQUENCE public.consumos_consumoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.consumos_consumoid_seq;
       public          postgres    false    202    3                       0    0    consumos_consumoid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.consumos_consumoid_seq OWNED BY public.consumos.consumoid;
          public          postgres    false    203            �            1259    16554 
   fornecedor    TABLE     �   CREATE TABLE public.fornecedor (
    fornecedorid integer NOT NULL,
    nome_fornecedor character varying(30),
    valor_item numeric,
    itemfk integer
);
    DROP TABLE public.fornecedor;
       public         heap    postgres    false    3            �            1259    16560    fornecedor_fornecedorid_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_fornecedorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.fornecedor_fornecedorid_seq;
       public          postgres    false    3    204                       0    0    fornecedor_fornecedorid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.fornecedor_fornecedorid_seq OWNED BY public.fornecedor.fornecedorid;
          public          postgres    false    205            �            1259    16562    itens    TABLE     �   CREATE TABLE public.itens (
    itemid integer NOT NULL,
    item character varying(30),
    valor numeric,
    quantidade integer,
    status character varying(30)
);
    DROP TABLE public.itens;
       public         heap    postgres    false    3            �            1259    16568    itens_itemid_seq    SEQUENCE     �   CREATE SEQUENCE public.itens_itemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.itens_itemid_seq;
       public          postgres    false    3    206                       0    0    itens_itemid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.itens_itemid_seq OWNED BY public.itens.itemid;
          public          postgres    false    207            �            1259    16570    login    TABLE     �   CREATE TABLE public.login (
    loginid integer NOT NULL,
    login character varying(50),
    senha character varying(50),
    ativo character varying(30) DEFAULT 'Desativado'::character varying,
    tipo character varying(30),
    fk_usuario integer
);
    DROP TABLE public.login;
       public         heap    postgres    false    3            �            1259    16574    login_id_seq    SEQUENCE     �   CREATE SEQUENCE public.login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.login_id_seq;
       public          postgres    false    208    3                       0    0    login_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.login_id_seq OWNED BY public.login.loginid;
          public          postgres    false    209            �            1259    16576    quartos    TABLE     �   CREATE TABLE public.quartos (
    quarto character varying(30) NOT NULL,
    tipo character varying(30),
    camasolteiro integer DEFAULT 0,
    camacasal integer DEFAULT 0,
    status character varying(30),
    reservafk integer,
    diaria numeric
);
    DROP TABLE public.quartos;
       public         heap    postgres    false    3            �            1259    16584    reservas    TABLE     N  CREATE TABLE public.reservas (
    reservaid integer NOT NULL,
    nomefunc character varying(50),
    nomecli character varying(50),
    entrada character varying DEFAULT CURRENT_TIMESTAMP,
    saida character varying,
    valor numeric,
    quartofk character varying(30),
    status character varying(30),
    usuariofk integer
);
    DROP TABLE public.reservas;
       public         heap    postgres    false    3            �            1259    16591    reservas_reservaid_seq    SEQUENCE     �   CREATE SEQUENCE public.reservas_reservaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.reservas_reservaid_seq;
       public          postgres    false    3    211                       0    0    reservas_reservaid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.reservas_reservaid_seq OWNED BY public.reservas.reservaid;
          public          postgres    false    212            �            1259    16593    usuario    TABLE     h  CREATE TABLE public.usuario (
    usuarioid integer NOT NULL,
    nome character varying(50),
    rg character varying(30),
    telefone character varying(20),
    rua character varying(50),
    numero character varying(10),
    bairro character varying(50),
    cidade character varying(50),
    estado character varying(50),
    cep character varying(10)
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    3            �            1259    16596    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    3    213                       0    0    usuario_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.usuarioid;
          public          postgres    false    214            O           2604    16598    cartao cartaoid    DEFAULT     r   ALTER TABLE ONLY public.cartao ALTER COLUMN cartaoid SET DEFAULT nextval('public.cartao_cartaoid_seq'::regclass);
 >   ALTER TABLE public.cartao ALTER COLUMN cartaoid DROP DEFAULT;
       public          postgres    false    201    200            Q           2604    16599    consumos consumoid    DEFAULT     x   ALTER TABLE ONLY public.consumos ALTER COLUMN consumoid SET DEFAULT nextval('public.consumos_consumoid_seq'::regclass);
 A   ALTER TABLE public.consumos ALTER COLUMN consumoid DROP DEFAULT;
       public          postgres    false    203    202            R           2604    16600    fornecedor fornecedorid    DEFAULT     �   ALTER TABLE ONLY public.fornecedor ALTER COLUMN fornecedorid SET DEFAULT nextval('public.fornecedor_fornecedorid_seq'::regclass);
 F   ALTER TABLE public.fornecedor ALTER COLUMN fornecedorid DROP DEFAULT;
       public          postgres    false    205    204            S           2604    16601    itens itemid    DEFAULT     l   ALTER TABLE ONLY public.itens ALTER COLUMN itemid SET DEFAULT nextval('public.itens_itemid_seq'::regclass);
 ;   ALTER TABLE public.itens ALTER COLUMN itemid DROP DEFAULT;
       public          postgres    false    207    206            W           2604    16602    reservas reservaid    DEFAULT     x   ALTER TABLE ONLY public.reservas ALTER COLUMN reservaid SET DEFAULT nextval('public.reservas_reservaid_seq'::regclass);
 A   ALTER TABLE public.reservas ALTER COLUMN reservaid DROP DEFAULT;
       public          postgres    false    212    211            �          0    16540    cartao 
   TABLE DATA           e   COPY public.cartao (cartaoid, numerocartao, nome, validade, codigo, bandeira, usuariofk) FROM stdin;
    public          postgres    false    200   IJ       �          0    16545    consumos 
   TABLE DATA           _   COPY public.consumos (consumoid, item, valor, quantidade, data, reservafk, itemfk) FROM stdin;
    public          postgres    false    202   �J       �          0    16554 
   fornecedor 
   TABLE DATA           W   COPY public.fornecedor (fornecedorid, nome_fornecedor, valor_item, itemfk) FROM stdin;
    public          postgres    false    204   �K       �          0    16562    itens 
   TABLE DATA           H   COPY public.itens (itemid, item, valor, quantidade, status) FROM stdin;
    public          postgres    false    206   �K       �          0    16570    login 
   TABLE DATA           O   COPY public.login (loginid, login, senha, ativo, tipo, fk_usuario) FROM stdin;
    public          postgres    false    208   RL                  0    16576    quartos 
   TABLE DATA           c   COPY public.quartos (quarto, tipo, camasolteiro, camacasal, status, reservafk, diaria) FROM stdin;
    public          postgres    false    210   �L                 0    16584    reservas 
   TABLE DATA           t   COPY public.reservas (reservaid, nomefunc, nomecli, entrada, saida, valor, quartofk, status, usuariofk) FROM stdin;
    public          postgres    false    211   oM                 0    16593    usuario 
   TABLE DATA           j   COPY public.usuario (usuarioid, nome, rg, telefone, rua, numero, bairro, cidade, estado, cep) FROM stdin;
    public          postgres    false    213   AN                  0    0    cartao_cartaoid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cartao_cartaoid_seq', 8, true);
          public          postgres    false    201                       0    0    consumos_consumoid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.consumos_consumoid_seq', 18, true);
          public          postgres    false    203                       0    0    fornecedor_fornecedorid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.fornecedor_fornecedorid_seq', 10, true);
          public          postgres    false    205                       0    0    itens_itemid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.itens_itemid_seq', 18, true);
          public          postgres    false    207                       0    0    login_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.login_id_seq', 6, true);
          public          postgres    false    209                       0    0    reservas_reservaid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reservas_reservaid_seq', 7, true);
          public          postgres    false    212                       0    0    usuario_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.usuario_id_seq', 7, true);
          public          postgres    false    214            Z           2606    16604    cartao cartaoidpk 
   CONSTRAINT     U   ALTER TABLE ONLY public.cartao
    ADD CONSTRAINT cartaoidpk PRIMARY KEY (cartaoid);
 ;   ALTER TABLE ONLY public.cartao DROP CONSTRAINT cartaoidpk;
       public            postgres    false    200            \           2606    16606    consumos consumoidpk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.consumos
    ADD CONSTRAINT consumoidpk PRIMARY KEY (consumoid);
 >   ALTER TABLE ONLY public.consumos DROP CONSTRAINT consumoidpk;
       public            postgres    false    202            ^           2606    16608    fornecedor fornecedoridpk 
   CONSTRAINT     a   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedoridpk PRIMARY KEY (fornecedorid);
 C   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedoridpk;
       public            postgres    false    204            `           2606    16610    itens item_name 
   CONSTRAINT     J   ALTER TABLE ONLY public.itens
    ADD CONSTRAINT item_name UNIQUE (item);
 9   ALTER TABLE ONLY public.itens DROP CONSTRAINT item_name;
       public            postgres    false    206            b           2606    16612    itens itemidpk 
   CONSTRAINT     P   ALTER TABLE ONLY public.itens
    ADD CONSTRAINT itemidpk PRIMARY KEY (itemid);
 8   ALTER TABLE ONLY public.itens DROP CONSTRAINT itemidpk;
       public            postgres    false    206            d           2606    16614    login login_name 
   CONSTRAINT     L   ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_name UNIQUE (login);
 :   ALTER TABLE ONLY public.login DROP CONSTRAINT login_name;
       public            postgres    false    208            f           2606    16616    login loginpk 
   CONSTRAINT     P   ALTER TABLE ONLY public.login
    ADD CONSTRAINT loginpk PRIMARY KEY (loginid);
 7   ALTER TABLE ONLY public.login DROP CONSTRAINT loginpk;
       public            postgres    false    208            h           2606    16618    quartos quartopk 
   CONSTRAINT     R   ALTER TABLE ONLY public.quartos
    ADD CONSTRAINT quartopk PRIMARY KEY (quarto);
 :   ALTER TABLE ONLY public.quartos DROP CONSTRAINT quartopk;
       public            postgres    false    210            j           2606    16620    reservas reservaidpk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservaidpk PRIMARY KEY (reservaid);
 >   ALTER TABLE ONLY public.reservas DROP CONSTRAINT reservaidpk;
       public            postgres    false    211            l           2606    16622    usuario usuariopk 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuariopk PRIMARY KEY (usuarioid);
 ;   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuariopk;
       public            postgres    false    213            q           2606    16623    login fk_usuario    FK CONSTRAINT     {   ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES public.usuario(usuarioid);
 :   ALTER TABLE ONLY public.login DROP CONSTRAINT fk_usuario;
       public          postgres    false    213    2924    208            n           2606    16628    consumos item_fk    FK CONSTRAINT     r   ALTER TABLE ONLY public.consumos
    ADD CONSTRAINT item_fk FOREIGN KEY (itemfk) REFERENCES public.itens(itemid);
 :   ALTER TABLE ONLY public.consumos DROP CONSTRAINT item_fk;
       public          postgres    false    202    2914    206            p           2606    16633    fornecedor itemfk    FK CONSTRAINT     s   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT itemfk FOREIGN KEY (itemfk) REFERENCES public.itens(itemid);
 ;   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT itemfk;
       public          postgres    false    206    2914    204            r           2606    16638    quartos reserva_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.quartos
    ADD CONSTRAINT reserva_fk FOREIGN KEY (reservafk) REFERENCES public.reservas(reservaid);
 <   ALTER TABLE ONLY public.quartos DROP CONSTRAINT reserva_fk;
       public          postgres    false    210    211    2922            o           2606    16643    consumos reserva_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.consumos
    ADD CONSTRAINT reserva_fk FOREIGN KEY (reservafk) REFERENCES public.reservas(reservaid);
 =   ALTER TABLE ONLY public.consumos DROP CONSTRAINT reserva_fk;
       public          postgres    false    211    202    2922            m           2606    16648    cartao usuario_fk    FK CONSTRAINT     {   ALTER TABLE ONLY public.cartao
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuariofk) REFERENCES public.usuario(usuarioid);
 ;   ALTER TABLE ONLY public.cartao DROP CONSTRAINT usuario_fk;
       public          postgres    false    213    200    2924            s           2606    16653    reservas usuariofk    FK CONSTRAINT     |   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT usuariofk FOREIGN KEY (usuariofk) REFERENCES public.usuario(usuarioid);
 <   ALTER TABLE ONLY public.reservas DROP CONSTRAINT usuariofk;
       public          postgres    false    2924    211    213            �   �   x�U���0�O�T����k%M�5�ab!��� �Ԅ�x�%7��!e�3VK�NK���՗�����F�L`���u��e����҆�!bILK�!U���_�~�hL��)L�}�Y��/Ĕ/].���ԍ��fbu���݈�$�xч,r      �   �   x���1�0�W��|{6���4VbH$�HH<�s���#B��N�e�3I��AZZ�\D		����{Zߙ�ѡ��=���j��?3��|��@��O4�囚)7ü��+�F\�^&�M������s�c*�ї��{��?�OGZ      �   <   x�3��K-.�I�4�30�4�2�t�ONTp��I�4	qr�&�'Vrpr��qqq f|#      �   _   x�3�tN̬HTHIUp��O��I,I�44�30�4�t�,.���,K��2�JM+�LO-J��0�3*�DVa����R���4�\ψ��Y:F��� <  �      �   n   x�m̽
�0F��}/F��AQ���6�����ջ����4g�2�u>D��4����{�Q���V���˪#<��}J�u�����U~��aD�^U������},�          �   x�s4��)���4�4�t�,.��;��,5�3Ə���@��������
c�
���܂��b�1��M!�Lq[dQa7ƈ� ��"C�"�Y�ɥ�)�����y$�`�dRa��!FF\��i#��a��sCL����� �V         �   x��н
�0����y�������MD���C@����׶Am����]�W�ML�&��
4i�X�bH��R�*���1�<8�����7�2c>+��u������w��:�O�;���9fp��M��]~V�%�J����@�DVg��ѝ��M��{d]j.���[6	�U�*��s
�?M+v3!�=�j�         n  x�}��j�0���S��ll9N�cYk�J���.��C�v�C_g����@7ƨAH�A��I6����.�esv	��Q(�f
�:7E��Tй����r��Sd�G�֖Վ�G�;�X�۶	4
�KQ�+���<�Zi�`O�o-{��[�
�}C��N)YM��b!���g`;�7��(�,1C��.�7O,���<��|�����B��f/Q�xA�@�˃?8��)�������FE����'G<:_[@8G�!�ǚ�ud��g�
{a���Ի�U��k,���ee�,�!,X�H4gh� ��Ȇ��0lx�^�Z��" �QZY��]��I���j����7��zY�}G���     