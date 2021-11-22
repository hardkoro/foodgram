--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE foodgram_db;




--
-- Drop roles
--

DROP ROLE foodgram;


--
-- Roles
--

CREATE ROLE foodgram;
ALTER ROLE foodgram WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md56a166e6f603eec3d51778901709d682d';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Debian 12.4-1.pgdg100+1)
-- Dumped by pg_dump version 12.4 (Debian 12.4-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: foodgram
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO foodgram;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: foodgram
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: foodgram
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: foodgram
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "foodgram_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Debian 12.4-1.pgdg100+1)
-- Dumped by pg_dump version 12.4 (Debian 12.4-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: foodgram_db; Type: DATABASE; Schema: -; Owner: foodgram
--

CREATE DATABASE foodgram_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE foodgram_db OWNER TO foodgram;

\connect foodgram_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_ingredient; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_ingredient (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    measurement_unit character varying(200) NOT NULL
);


ALTER TABLE public.api_ingredient OWNER TO foodgram;

--
-- Name: api_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_ingredient_id_seq OWNER TO foodgram;

--
-- Name: api_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_ingredient_id_seq OWNED BY public.api_ingredient.id;


--
-- Name: api_ingredientinrecipe; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_ingredientinrecipe (
    id bigint NOT NULL,
    amount smallint,
    ingredient_id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    CONSTRAINT api_ingredientinrecipe_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.api_ingredientinrecipe OWNER TO foodgram;

--
-- Name: api_ingredientinrecipe_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_ingredientinrecipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_ingredientinrecipe_id_seq OWNER TO foodgram;

--
-- Name: api_ingredientinrecipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_ingredientinrecipe_id_seq OWNED BY public.api_ingredientinrecipe.id;


--
-- Name: api_recipe; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_recipe (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    image character varying(100) NOT NULL,
    text text NOT NULL,
    cooking_time smallint NOT NULL,
    author_id integer NOT NULL,
    CONSTRAINT api_recipe_cooking_time_check CHECK ((cooking_time >= 0))
);


ALTER TABLE public.api_recipe OWNER TO foodgram;

--
-- Name: api_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_recipe_id_seq OWNER TO foodgram;

--
-- Name: api_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_recipe_id_seq OWNED BY public.api_recipe.id;


--
-- Name: api_recipe_tags; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_recipe_tags (
    id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.api_recipe_tags OWNER TO foodgram;

--
-- Name: api_recipe_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_recipe_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_recipe_tags_id_seq OWNER TO foodgram;

--
-- Name: api_recipe_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_recipe_tags_id_seq OWNED BY public.api_recipe_tags.id;


--
-- Name: api_recipefavorite; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_recipefavorite (
    id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.api_recipefavorite OWNER TO foodgram;

--
-- Name: api_recipefavorite_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_recipefavorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_recipefavorite_id_seq OWNER TO foodgram;

--
-- Name: api_recipefavorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_recipefavorite_id_seq OWNED BY public.api_recipefavorite.id;


--
-- Name: api_recipeincart; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_recipeincart (
    id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.api_recipeincart OWNER TO foodgram;

--
-- Name: api_recipeincart_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_recipeincart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_recipeincart_id_seq OWNER TO foodgram;

--
-- Name: api_recipeincart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_recipeincart_id_seq OWNED BY public.api_recipeincart.id;


--
-- Name: api_tag; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.api_tag (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    color character varying(7) NOT NULL,
    slug character varying(200) NOT NULL
);


ALTER TABLE public.api_tag OWNER TO foodgram;

--
-- Name: api_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.api_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_tag_id_seq OWNER TO foodgram;

--
-- Name: api_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.api_tag_id_seq OWNED BY public.api_tag.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO foodgram;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO foodgram;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO foodgram;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO foodgram;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO foodgram;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO foodgram;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO foodgram;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO foodgram;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO foodgram;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO foodgram;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO foodgram;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO foodgram;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO foodgram;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO foodgram;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO foodgram;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO foodgram;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO foodgram;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO foodgram;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO foodgram;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO foodgram;

--
-- Name: users_follow; Type: TABLE; Schema: public; Owner: foodgram
--

CREATE TABLE public.users_follow (
    id bigint NOT NULL,
    author_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.users_follow OWNER TO foodgram;

--
-- Name: users_follow_id_seq; Type: SEQUENCE; Schema: public; Owner: foodgram
--

CREATE SEQUENCE public.users_follow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_follow_id_seq OWNER TO foodgram;

--
-- Name: users_follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodgram
--

ALTER SEQUENCE public.users_follow_id_seq OWNED BY public.users_follow.id;


--
-- Name: api_ingredient id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredient ALTER COLUMN id SET DEFAULT nextval('public.api_ingredient_id_seq'::regclass);


--
-- Name: api_ingredientinrecipe id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredientinrecipe ALTER COLUMN id SET DEFAULT nextval('public.api_ingredientinrecipe_id_seq'::regclass);


--
-- Name: api_recipe id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe ALTER COLUMN id SET DEFAULT nextval('public.api_recipe_id_seq'::regclass);


--
-- Name: api_recipe_tags id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe_tags ALTER COLUMN id SET DEFAULT nextval('public.api_recipe_tags_id_seq'::regclass);


--
-- Name: api_recipefavorite id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipefavorite ALTER COLUMN id SET DEFAULT nextval('public.api_recipefavorite_id_seq'::regclass);


--
-- Name: api_recipeincart id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipeincart ALTER COLUMN id SET DEFAULT nextval('public.api_recipeincart_id_seq'::regclass);


--
-- Name: api_tag id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_tag ALTER COLUMN id SET DEFAULT nextval('public.api_tag_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: users_follow id; Type: DEFAULT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.users_follow ALTER COLUMN id SET DEFAULT nextval('public.users_follow_id_seq'::regclass);


--
-- Data for Name: api_ingredient; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_ingredient (id, name, measurement_unit) FROM stdin;
1	абрикосовое варенье	г
2	абрикосовое пюре	г
3	абрикосовый джем	г
4	абрикосовый сок	стакан
5	абрикосы	г
6	абрикосы консервированные	г
7	авокадо	по вкусу
8	агава сироп	г
9	агар-агар	г
10	аграм	г
11	аджика	г
12	аджика зеленая	г
13	айва	по вкусу
14	айвовое пюре	г
15	айран	г
16	айсинг	г
17	акула стейки	г
18	алкоголь	стакан
19	алкоголь крепкий	ст. л.
20	алыча	г
21	альбухара	шт.
22	альмехи	г
23	амарантовая мука	г
24	ананасовый сироп	г
25	ананасовый сок	г
26	ананасы	г
27	ананасы вяленые	г
28	ананасы консервированные	по вкусу
29	анис	по вкусу
30	анис звездочки	г
31	анисовый ликер	мл
32	анис семена	г
33	анчоусы	г
34	апельсиновая вода	г
35	апельсиновая цедра	г
36	апельсиновая эссенция	ч. л.
37	апельсиновое варенье	г
38	апельсиновые цукаты	г
39	апельсиновый джем	г
40	апельсиновый джем с имбирем	г
41	апельсиновый ликер	г
42	апельсиновый сироп	стакан
43	апельсиновый сок	по вкусу
44	апельсиновый сок свежевыжатый	г
45	апельсиновый уксус	ст. л.
46	апельсиновый экстракт	ч. л.
47	апельсины	г
48	апельсины красные	шт.
49	апельсины крупные	шт.
50	арахис	г
51	арахис жареный	г
52	арахисовая паста	г
53	арахисовое масло	г
54	арахис соленый	г
55	арбузная мякоть	г
56	арбузы	г
57	аргановое масло	г
58	аришта	г
59	ароматизатор	г
60	ароматизатор "ананас"	по вкусу
61	ароматизатор "вишня"	капля
62	ароматизатор "малина"	капля
63	ароматизатор "ром"	г
64	артишоки	г
65	артишоки в масле	г
66	артишоки маринованные	г
67	аспирин	шт.
68	ассорти мясное	г
69	ассорти овощное	г
70	ассорти фруктовое	г
71	ассорти ягодное	г
72	аши	г
73	багет	г
74	багет вчерашний	г
75	багет мини	г
76	бадан	звездочка
77	бадьян	щепотка
78	базилик лимонный	г
79	базилик свежий	г
80	базилик сушеный	г
81	базилик тайский	горсть
82	базилик фиолетовый	г
83	баклажаны	по вкусу
84	баклажаны мини	г
85	баклажаны тайские	г
86	балык	г
87	бальзам	г
88	бальзамический крем	стакан
89	бальзамический соус	ст. л.
90	бальзамический уксус	стакан
91	бальзам рижский черный	ст. л.
92	бамия	г
93	банановое пюре	г
94	банановые чипсы	горсть
95	банановый зеленый сироп	мл
96	банановый ликер	мл
97	бананы	г
98	бананы мини	г
99	барабулька	г
100	бараний ливер	г
101	бараний окорок на косточке	кусок
102	бараний фарш	г
103	баранина	г
104	баранки	г
105	бараньи антрекоты	кг
106	бараньи голяшки	шт.
107	бараньи потроха	кг
108	бараньи ребрышки	шт.
109	баранья лопатка	кг
110	баранья нога	г
111	баранья печень	г
112	барбарис	г
113	барбарис вяленый	ст. л.
114	барбарис молотый	г
115	бастурма	г
116	батат	г
117	батон	г
118	батончики шоколадные	г
119	безе	г
120	бекон	по вкусу
121	бекон варено-копченый	г
122	бекон сырокопченый	г
123	белорыбица	г
124	бирнель	мл
125	бисквик смесь готовая	пакет
126	бисквит	г
127	бисквитная крошка	г
128	бисквитный корж	г
129	бисквитный рулет	г
130	бисквит шоколадный	г
131	бифштекс	шт.
132	блинная мука	г
133	блины готовые	г
134	блины овсяные	шт.
135	бобовые ростки	г
136	бобы	г
137	бобы мунг пророщенные	г
138	бобы тонка	шт.
139	ботарга	г
140	брезаола	г
141	бренди	г
142	брокколи замороженная	г
143	брокколи свежая	г
144	брусника замороженная	г
145	брусника свежая	г
146	брусника сушеная	г
147	брусничное варенье	г
148	брусничный соус	г
149	брынза	по вкусу
150	брынза сербская	г
151	брюква	г
152	буженина	г
153	бузина сироп	ст. л.
154	букет гарни	пучок
155	булгур	г
156	булка	кусок
157	булка белая	г
158	булка сдобная	г
159	булочки	г
160	булочки белые черствые	г
161	булочки бриошь	шт.
162	булочки вчерашние	шт.
163	булочки для гамбургеров	шт.
164	булочки зерновые	шт.
165	булочки ржаные	кусок
166	булочки с кунжутом	шт.
167	бульон	г
168	бульонные кубики	г
169	бурбон	г
170	Буррата	г
171	буряк	г
172	бусинки кондитерские	ч. л.
173	бусинки кондитерские серебряные	по вкусу
174	бычий хвост	г
175	ванилин	г
176	ваниль в стручках	г
177	ванильная настойка	ст. л.
178	ванильная эссенция	г
179	ванильный порошок	г
180	ванильный сироп	г
181	ванильный экстракт	по вкусу
182	варенье	г
183	васаби	г
184	вафельная крошка	г
185	вафельные коржи	г
186	вафельные трубочки	г
187	вафли	г
188	вафли шоколадные	г
189	вермишель	г
190	вермишель яичная	г
191	вермут	г
192	вермут белый	г
193	вермут сухой	г
194	ветчина	г
195	ветчина вареная	г
196	ветчина варено-копченая	кусок
197	ветчина копченая	г
198	ветчина пармская	г
199	ветчина сырокопченая	г
200	вешенки	г
201	винегрет	г
202	винный камень	щепотка
203	винный уксус	г
204	винный уксус белый	г
205	винный уксус красный	ч. л.
206	винный уксус на чесноке	ч. л.
207	винный уксус на эстрагоне	ст. л.
208	вино белое	по вкусу
209	вино белое полусладкое	г
210	вино белое полусухое	г
211	вино белое сладкое	г
212	вино белое столовое	стакан
213	вино белое сухое	г
214	виноград	г
215	виноград без косточек	г
216	виноград белый	г
217	виноград изабелла	кг
218	виноградное желе	ст. л.
219	виноградные листья	г
220	виноградные листья маринованные	г
221	виноградные листья молодые	шт.
222	виноградный сок	г
223	виноградный сок осветленный	ч. л.
224	виноград синий	г
225	виноград черный	г
226	вино десертное	г
227	вино игристое сухое	г
228	вино красное	г
229	вино красное полусладкое	г
230	вино красное полусухое	г
231	вино красное сладкое	г
232	вино красное сухое	г
233	вино крепленое	г
234	вино розовое полусладкое	ст. л.
235	вино розовое полусухое	г
236	виски	г
237	витамин C в порошке	г
238	вишневая настойка	мл
239	вишневое варенье	г
240	вишневые листья	г
241	вишневый джем	г
242	вишневый ликер	по вкусу
243	вишневый сироп	стакан
244	вишневый сок	г
245	вишня	г
246	вишня вяленая	г
247	вишня замороженная	г
248	вишня засахаренная кондитерская	шт.
249	вишня коктейльная	г
250	вишня мараскино	шт.
251	вишня, протертая с сахаром	г
252	вода	г
253	вода минеральная без газа	стакан
254	вода минеральная газированная	г
255	водка	г
256	водка анисовая	ч. л.
257	водоросли	г
258	вустерширский соус	г
259	галангал корень	долька
260	галеты	г
261	гамбургер	г
262	ганаш	г
263	гарам масала	г
264	гарнир	г
265	гаспачо	г
266	гвоздика	г
267	гвоздика молотая	по вкусу
268	герань листья	г
269	геркулес	г
270	глазурь	г
271	глазурь белая	г
272	глазурь готовая	по вкусу
273	глазурь черная	по вкусу
274	глазурь шоколадная белая	г
275	глутамат натрия	г
276	глюкоза	г
277	глюкоза сироп	г
278	говядина	г
279	говядина на кости	г
280	говяжий фарш	по вкусу
281	говяжий язык	г
282	говяжье сердце	по вкусу
283	говяжьи бифштексы	г
284	говяжьи голяшки	г
285	говяжьи легкие	г
286	говяжьи ребра	г
287	говяжьи стейки рибай	г
288	говяжья вырезка	шт.
289	говяжья грудинка	кг
290	говяжья лопатка	г
291	говяжья мозговая кость	шт.
292	говяжья мякоть	кг
293	говяжья печень	шт.
294	говяжья черева	г
295	говяжья шейка	кг
296	годжи	г
297	голец филе	шт.
298	голубика	г
299	голубика замороженная	г
300	голубь	г
301	горбуша	по вкусу
302	горбуша в собственном соку	банка
303	горбуша филе	г
304	горгонзола	г
305	горгонзола пиканте	г
306	горох	г
307	горох колотый	г
308	гороховые ростки	горсть
309	гороховый суп	г
310	горошек зеленый	г
311	горошек зеленый замороженный	г
312	горошек зеленый консервированный	г
313	горошек стручковый свежий	г
314	горчица	г
315	горчица дижонская	г
316	горчица дижонская с медом	г
317	горчица желтая семена	г
318	горчица острая	г
319	горчица русская	ст. л.
320	горчица семена	г
321	горчица с зернами	г
322	горчица сухая	г
323	горчица французская	г
324	горчица цитрусовая	г
325	горчичное масло	г
326	горчичный порошок	г
327	грана падано	ст. л.
328	гранатные зерна	г
329	гранатовая паста	ст. л.
330	гранатовый сироп	г
331	гранатовый сок	г
332	гранатовый сок свежевыжатый	мл
333	гранатовый соус	ч. л.
334	гранаты	г
335	гранита	г
336	гранола с орехами	г
337	граппа	ч. л.
338	гратен	кг
339	грейпфрутовая цедра	г
340	грейпфрутовый сок	г
341	грейпфруты	г
342	грейпфруты розовые	г
343	гренадин	г
344	гренки	г
345	грецкие орехи	г
346	грецкие орехи рубленые	г
347	гречневая крупа	г
348	гречневая крупа зеленая	ст. л.
349	гречневая лапша соба	г
350	гречневая мука	г
351	гречневое молоко	стакан
352	гречневые хлопья	г
353	грибы	г
354	грибы белые	г
355	грибы белые замороженные	г
356	грибы белые маринованные	г
357	грибы белые сухие	г
358	грибы замороженные	г
359	грибы замороженные (опята и маслята)	г
360	грибы лесные	г
361	грибы маринованные	г
362	грибы свежие	г
363	грибы соленые	г
364	грибы соломенные консервированные	шт.
365	грибы сухие	г
366	грибы шиитаке	г
367	грибы шиитаке сухие	г
368	гриль	г
369	гриссини	г
370	грудинка	г
371	грудинка варено-копченая	г
372	грудинка копченая	по вкусу
373	грушевое пюре	г
374	грушевый ликер	мл
375	грушевый сироп	мл
376	грушевый сок	г
377	грушевый уксус	ст. л.
378	груши	по вкусу
379	груши вяленые	г
380	грюйер	г
381	гуава	шт.
382	гуанчиале	г
383	гурьевская каша	г
384	гусиная грудка копченая	г
385	гусиная печень	г
386	гусиный жир	ст. л.
387	гусь	г
388	гусь тушка	кг
389	дайкон	г
390	детское питание	г
391	джем	г
392	джин	г
393	джусай	г
394	диоксид титана	г
395	долма	г
396	дорада	шт.
397	дорада потрошеная с головой	шт.
398	дорада с головой	шт.
399	дорада тушка	шт.
400	драже	г
401	дрожжи домашние	г
402	дрожжи свежие	г
403	дрожжи сухие	по вкусу
404	дубовая кора	г
405	душица	г
406	дыня	г
407	ежевика	г
408	ежевика замороженная	г
409	ерш	г
410	ёрш-носарь	шт.
411	желатин	г
412	желатин листовой	по вкусу
413	желе	г
414	желе для торта	упаковка
415	желирующее вещество	упаковка
416	желирующий сахар	г
417	женьшень	г
418	жидкий дым	г
419	жимолость	г
420	жир	г
421	жир вытопленный	стакан
422	жир кулинарный	г
423	жир растительный	г
424	заатар	щепотка
425	завтрак сухой	г
426	завтрак сухой подушечки	г
427	загуститель для сливок	г
428	зайчатина	г
429	закваска	пакет
430	закваска вечная	г
431	заменитель сахара	по вкусу
432	заменитель сахара стевия	г
433	заправка для салатов готовая	г
434	зверобой	по вкусу
435	зелень	г
436	зелень рубленая	г
437	земляника	по вкусу
438	земляника замороженная	г
439	зефир	г
440	зира	г
441	злаковые хлопья	г
442	зубатка	г
443	зубатка филе	г
444	изолят соевого протеина	г
445	изюм	г
446	изюм без косточек	г
447	изюм белый	г
448	изюм черный	г
449	икра	г
450	икра вяленой рыбы	г
451	икра горбуши зернистая	г
452	икра красная	г
453	икра красной рыбы мелкая	г
454	икра летучей рыбы	г
455	икра лосося	г
456	икра мойвы	г
457	икра палтуса	г
458	икра судака	г
459	икра черная	г
460	имбирное варенье	г
461	имбирное печенье	по вкусу
462	имбирные цукаты	ст. л.
463	имбирь	г
464	имбирь засахаренный	г
465	имбирь корень	г
466	имбирь маринованный	г
467	имбирь молотый	г
468	индейка	г
469	индейка голень	г
470	индейка грудка	г
471	индейка копченая	г
472	индейка тушка	шт.
473	индейка фарш	г
474	индейка филе	г
475	индоутка	шт.
476	индюшачья печень	г
477	инжир	г
478	инжир свежий	г
479	инжир сушеный	г
480	ирга	г
481	ириски	г
482	итальянские травы	г
483	йогурт	г
484	йогурт греческий	г
485	йогурт жирный	г
486	йогурт козий	г
487	йогурт натуральный	г
488	йогурт нежирный	г
489	йогурт обезжиренный	г
490	йогурт фруктовый	г
491	кабачки	г
492	кабачки замороженные	г
493	кабачки молодые	г
494	каджунская смесь специй	ст. л.
495	какао	горсть
496	какао-бобы	г
497	какао-масло	г
498	какао-порошок	по вкусу
499	какао-порошок обезжиренный	г
500	какао сгущенное	банка
501	калина	по вкусу
502	калина протертая	г
503	калинджи семена	ч. л.
504	кальвадос	г
505	кальмары	г
506	кальмары вареные	г
507	кальмары замороженные	г
508	кальмары консервированные	г
509	кальмары филе	шт.
510	камамбер	упаковка
511	камбала	г
512	камбала филе	г
513	кампари	мл
514	кандурин золотой	ч. л.
515	каннеллони	г
516	капеллини	г
517	каперсы	г
518	каперсы в винном уксусе	г
519	каперсы маринованные	г
520	капуста белокочанная	г
521	капуста брюссельская	г
522	капуста брюссельская замороженная	г
523	капуста кале	г
524	капуста квашеная	по вкусу
525	капуста кольраби	г
526	капуста краснокочанная	г
527	капуста морская	по вкусу
528	капуста морская замороженная	г
529	капуста морская сушеная	г
530	капуста пекинская	г
531	капуста савойская	г
532	капуста цветная	г
533	капуста цветная замороженная	г
534	капустный рассол	г
535	капучино	г
536	каракатица	г
537	каракатица очищенная	г
538	карамбола	г
539	карамель	мл
540	карамельный соус	г
541	карамель с начинкой	г
542	карамель соленая	г
543	карась	г
544	карбонад	г
545	кардамон	г
546	кардамон зерна	ч. л.
547	кардамон молотый	г
548	кардамон стручки	шт.
549	каркаде	г
550	карп	г
551	карп зеркальный	кг
552	карп филе	кг
553	карри	г
554	карри листья	г
555	карри паста	пакет
556	картофель	г
557	картофель вареный	г
558	картофель вареный в мундире	г
559	картофель молодой	г
560	картофельное пюре	по вкусу
561	картофельные ньокки	г
562	картофельные хлопья	г
563	картофельные чипсы	г
564	картофельный крахмал	г
565	картофельный отвар	г
566	картофельный хэш замороженный	г
567	картофель печеный	г
568	катык	г
569	каффир-лайм листья	по вкусу
570	каша	г
571	каша для детского питания	г
572	каштановая мука	г
573	каштановый крем	г
574	каштаны	г
575	каштаны вареные	г
576	каштаны консервированные	г
577	каштаны очищенные	г
578	квас	г
579	квасное сусло	г
580	квасной концентрат сухой	упаковка
581	квас хлебный	г
582	кедровая мука	г
583	кедровые орехи	г
584	кедровые орехи жареные	г
585	кета	г
586	кетчуп острый	по вкусу
587	кетчуп томатный	г
588	кетчуп тосканский	ст. л.
589	кетчуп шашлычный	г
590	кефаль	г
591	кефир	по вкусу
592	кефир 1%	г
593	кефир 2,5%	г
594	кефир 3,2%	г
595	кефир обезжиренный	г
596	кешью	г
597	кивано	г
598	киви	кг
599	киви желе	г
600	кижуч	г
601	кижуч горячего копчения филе	г
602	кизил	г
603	килька	г
604	кимчи	г
605	кинза свежая	зубчик
606	кинза сушеная	г
607	киноа	г
608	киноа молотая	г
609	кипяток	г
610	кирш	ст. л.
611	кисель	г
612	кисель сухой	г
613	кисломолочный напиток Тан	мл
614	кишки	г
615	клейковина	г
616	клементины	г
617	кленовый сироп	г
618	клубника	г
619	клубника в сиропе	г
620	клубника замороженная	г
621	клубника, протертая с сахаром	г
622	клубника сушеная	г
623	клубничное варенье	г
624	клубничное желе	упаковка
625	клубничное пюре	г
626	клубничный джем	г
627	клубничный джем густой	мл
628	клубничный компот	стакан
629	клубничный ликер	г
630	клубничный сироп	г
631	клюква	г
632	клюква вяленая	г
633	клюква замороженная	г
634	клюква, протертая с сахаром	г
635	клюквенное варенье	г
636	клюквенный джем	г
637	клюквенный морс	ст. л.
638	клюквенный сироп	г
639	клюквенный соус	г
640	козлиная печень	г
641	козлятина молодая	кг
642	кока-кола	ст. л.
643	кокосовая вода	стакан
644	кокосовая мука	ст. л.
645	кокосовая стружка	г
646	кокосовая стружка цветная	г
647	кокосовое масло	мл
648	кокосовое молоко	г
649	кокосовые сливки	г
650	кокосовый ликер	ст. л.
651	кокосовый экстракт	г
652	кокосы	г
653	кола	г
654	колбаса	г
655	колбаса вареная	г
656	колбаса варено-копченая	г
657	колбаса копченая	г
658	колбаса кровяная	г
659	колбаса полукопченая	г
660	колбаса сырокопченая	г
661	колбаска свиная свежая (salsiccia)	шт.
662	колбаски	г
663	колбаски для жарки	г
664	колбаски домашние	шт.
665	колбаски охотничьи	г
666	колбаски сырокопченые	шт.
667	компот	г
668	конопляное масло	ст. л.
669	конопля семена	г
670	конфеты	по вкусу
671	конфеты M&M’s	г
672	конфеты жевательные лакричные	г
673	конфеты Коровка	г
674	конфеты Трюфель	г
675	конфитюр	по вкусу
676	конфитюрка	упаковка
677	коньяк	г
678	копчености	г
679	коренья	по вкусу
680	кориандр	г
681	кориандр зелень	г
682	кориандр молотый	г
683	кориандр семена	г
684	коринка	ст. л.
685	корица	г
686	корица молотая	г
687	корнишоны	г
688	корнишоны маринованые	г
689	корюшка	г
690	корюшка горячего копчения	г
691	кости	г
692	кости мозговые	г
693	кость сахарная	г
694	кофе в зернах	стакан
695	кофе зеленый	г
696	кофейные зерна в шоколаде	г
697	кофейный ликер	г
698	кофейный ликер Kahlua	мл
699	кофейный напиток	мл
700	кофейный сироп	г
701	кофейный экстракт	мл
702	кофе молотый	ст. л.
703	кофе растворимый	г
704	кофе свежесваренный	г
705	кофе черный	г
706	кофе эспрессо	стакан
707	крабовое мясо	г
708	крабовые палочки	по вкусу
709	краб снежный	по вкусу
710	крабы	г
711	крапива	г
712	краситель-гель пищевой	шт.
713	краситель пищевой	г
714	краситель пищевой вишневый	щепотка
715	краситель пищевой желтый	г
716	краситель пищевой зеленый	ст. л.
717	краситель пищевой красный	г
718	краситель пищевой оранжевый	г
719	краситель пищевой фиолетовый	г
720	краситель пищевой черный	г
721	красная смородина	г
722	красная смородина, протертая с сахаром	ст. л.
723	красноперка	шт.
724	красносмородиновое варенье	г
725	красный винный соус	г
726	крахмал	г
727	креветки	г
728	креветки замороженные	г
729	креветки королевские	г
730	креветки очищенные	г
731	креветки очищенные в рассоле	г
732	креветки салатные	г
733	креветки сушеные	г
734	креветки тигровые	г
735	крекер	г
736	крекер соленый	г
737	крем заварной	г
738	крем заварной порошковый	г
739	крем-фреш	г
740	кресс-салат	г
741	кровь	мл
742	кролик	г
743	кролик тушка	г
744	кролик филе	г
745	кроличья печень	г
746	круассаны	по вкусу
747	крутоны мелкие	г
748	крыжовник	г
749	крыжовниковое варенье	банка
750	кукуруза	г
751	кукуруза замороженная	г
752	кукуруза консервированная	г
753	кукуруза обжаренная кикос	г
754	кукурузная крупа	г
755	кукурузная мука	г
756	кукурузное масло	г
757	кукурузные лепешки	шт.
758	кукурузные палочки	г
759	кукурузные хлопья	г
760	кукурузные хлопья глазированные	г
761	кукурузные чипсы	г
762	кукурузный (золотой) сироп	г
763	кукурузный крахмал	по вкусу
764	кумин	г
765	кумкваты	горсть
766	кунжут	г
767	кунжутная мука	г
768	кунжутная паста	г
769	кунжутное масло	г
770	кунжутные семечки	по вкусу
771	кунжут черный	ч. л.
772	купаты	шт.
773	курага	по вкусу
774	курдючное сало	г
775	курдючный жир	г
776	куриная ветчина	г
777	куриная кожа	г
778	куриная печень	г
779	куриное карпаччо	г
780	куриное филе	г
781	куриные бедра	г
782	куриные голени	г
783	куриные голени копченые	шт.
784	куриные грудки	г
785	куриные грудки вареные	г
786	куриные грудки копченые	г
787	куриные желудочки	шт.
788	куриные кости	г
789	куриные крылья	г
790	куриные окорочка	г
791	куриные окорочка копченые	г
792	куриные потрошки	г
793	куриные сердечки	г
794	куриный бульон	г
795	куриный паштет	г
796	куриный суповой набор	кг
797	куриный фарш	г
798	курица	г
799	курица вареная	г
800	курица для жарки	кг
801	курица копченая	г
802	курица тушка	г
803	куркума	г
804	куропатки	г
805	кускус	г
806	кускус жемчужный	стакан
807	кэроб	г
808	лаванда	г
809	лаванда сушеная	щепотка
810	лавандовый краситель	ч. л.
811	лаваш	по вкусу
812	лаваш армянский	г
813	лаваш персидский круглый	г
814	лаваш тонкий	пласт
815	лавровые листья свежие	шт.
816	лавровый лист	г
817	лайм	г
818	лайм листья	шт.
819	лаймовая цедра	г
820	лаймовый сок	г
821	лангустины	шт.
822	лапша	г
823	лапша для лагмана	упаковка
824	лапша ширатаки	г
825	лапша яичная в гнездах	шт.
826	латук	г
827	легкие	г
828	лед	г
829	леди-фиш тушка	шт.
830	лемонграсс (лимонное сорго)	г
831	лен семена	г
832	лепешки	г
833	лепешки арабские	шт.
834	лесные орехи	г
835	лечо	г
836	ливер	г
837	ликер	г
838	ликер Alchermes	г
839	ликер Amaretto	г
840	ликер Baileys	г
841	ликер Cointreau	г
842	ликер кремовый	г
843	ликер сливочный	г
844	лимонад	г
845	лимонная кислота	г
846	лимонная цедра	г
847	лимонник стебель	г
848	лимонник ягоды	г
849	лимонные корочки засахаренные	г
850	лимонные цукаты	г
851	лимонный сок	г
852	лимонный уксус	г
853	лимонный экстракт	г
854	лимончелло	г
855	лимоны	г
856	лимоны сушеные	г
857	лингвине	шт.
858	лисички	г
859	лисички сушеные	г
860	личи	шт.
861	личи компот	г
862	лобстер	г
863	лонган	г
864	лонгконг	шт.
865	лососевые молоки	г
866	лососевый фарш	г
867	лосось	г
868	лосось горячего копчения	г
869	лосось копченый	г
870	лосось свежесоленый	г
871	лосось свежий	г
872	лосось свежий филе	г
873	лосось слабосоленый	г
874	лосось стейки	г
875	лосось филе	г
876	лосось филе на коже	г
877	лосось холодного копчения	г
878	лосятина	кг
879	лук белый	по вкусу
880	лук зеленый	г
881	лук красный	по вкусу
882	лук маринованный	г
883	луковая шелуха	г
884	луковый порошок	г
885	лук-порей	горсть
886	лук-резанец	по вкусу
887	лук репчатый	г
888	лук репчатый мелкий	г
889	лук салатный	шт.
890	лук сушеный	г
891	лук-шалот	г
892	лук-шалот красный	шт.
893	льняная мука	г
894	льняное масло	ч. л.
895	льняное семя	г
896	льняное семя молотое	г
897	любисток	г
898	маасдам	г
899	мадера	г
900	майонез	г
901	майонез домашний	г
902	майонез легкий	г
903	майонезный соус «Слобода» Постный	г
904	майонез оливковый	г
905	майонез «Слобода» Легкий	г
906	майонез «Слобода» На перепелиных яйцах	г
907	майонез «Слобода» Оливковый	г
908	майонез «Слобода» Провансаль	г
909	майонез «Слобода» С лимонным соком	г
910	майонез «Слобода» Сметанный	г
911	майоран	г
912	майоран свежий	по вкусу
913	майоран сушеный	г
914	мак	г
915	макаронные изделия	г
916	макаронные изделия мелкие	г
917	макароны	г
918	макароны-бабочки (farfalle)	г
919	макароны-бабочки (farfalle) мини	г
920	макароны баветте	г
921	макароны-бантики	г
922	макароны букатини	г
923	макароны джильи	г
924	макароны диталони	г
925	макароны-звездочки	стакан
926	макароны орзо	г
927	макароны-ракушки (conchiglie)	г
928	макароны-ракушки (conchiglie rigate)	г
929	макароны-ракушки крупные	г
930	макароны рисони	г
931	макароны-рожки (pipe rigate)	г
932	макароны-спиральки (fusilli)	г
933	макароны-ушки (orecchiette)	г
934	маккерончини	г
935	мак молотый	г
936	маковая масса	пачка
937	малина	г
938	малина замороженная	г
939	малина, протертая с сахаром	стакан
940	малина сушеная	г
941	малиновое варенье	г
942	малиновое желе	г
943	малиновое пюре	г
944	малиновый джем	г
945	малиновый крем	г
946	малиновый сироп	ч. л.
947	малиновый соус	ч. л.
948	малиновый уксус	мл
949	малиновый чай	г
950	манго	по вкусу
951	манговый сироп	мл
952	манго консервированное	г
953	мангольд	г
954	мангустин	шт.
955	мандариновое пюре	г
956	мандариновые цукаты	г
957	мандариновый сок	г
958	мандарины	по вкусу
959	мандарины в собственном соку	г
960	манная крупа	г
961	маракуйя	г
962	маргарин	г
963	маргарин сливочный	г
964	мармелад	по вкусу
965	мармелад бутербродный	г
966	марсала	стакан
967	мартини	г
968	мартини красный	г
969	марципан	по вкусу
970	марципан зеленый	г
971	марципан розовый	г
972	маршмеллоу	г
973	маршмеллоу крем	г
974	маршмеллоу мини	г
975	маскарпоне	г
976	маслины	г
977	маслины без косточек	г
978	масло авокадо	г
979	масло виноградных косточек	г
980	масло грецкого ореха	ч. л.
981	масло для фритюра	г
982	масло кедрового ореха	г
983	маслята	г
984	мастика	г
985	мастика желатиновая	г
986	мастика шоколадная	г
987	матча	г
988	мафальдине	г
989	маца	г
990	мацони	г
991	маш	г
992	мед	г
993	мед акации	г
994	мед гречишный	г
995	мед жидкий	г
996	мед лавандовый	г
997	мелисса	г
998	меренги	шт.
999	мидии	г
1000	мидии в раковинах	г
1001	мидии в раковинах крупные черные	г
1002	мидии в раковинах мелкие зеленые	г
1003	мидии замороженные	шт.
1004	мидии копченые в масле	г
1005	микрозелень	горсть
1006	миндаль	г
1007	миндаль жареный	г
1008	миндаль измельченный	г
1009	миндальная масса	г
1010	миндальная мука	г
1011	миндальная паста	г
1012	миндальная эссенция	г
1013	миндальное масло	г
1014	миндальное молоко	г
1015	миндальное печенье	г
1016	миндальное пралине	г
1017	миндальные лепестки	г
1018	миндальный ликер	г
1019	миндальный сироп	г
1020	миндальный экстракт	капля
1021	миндаль очищенный	г
1022	миндаль рубленый	г
1023	мини-кукуруза	шт.
1024	минога	г
1025	минтай	г
1026	минтай печень	г
1027	минтай филе	г
1028	мисо-паста	г
1029	мисо-суп	пакет
1030	можжевельник ягоды	г
1031	мойва	г
1032	моллюски	г
1033	молоко	г
1034	молоко 0,5%	г
1035	молоко 1,5%	г
1036	молоко 2,5%	г
1037	молоко 3,2%	г
1038	молоко 3,6%	г
1039	молоко 4%	г
1040	молоко 6%	г
1041	молоко козье	г
1042	молоко концентрированное	г
1043	молоко рисовое	мл
1044	молоко сгущенное	г
1045	молоко сгущенное вареное	ст. л.
1046	молоко сгущенное с какао	г
1047	молоко сухое	г
1048	молоко сухое обезжиренное	ст. л.
1049	молоко топленое	г
1050	молочная смесь	г
1051	молочные продукты	г
1052	морепродукты	шт.
1053	морковное пюре	г
1054	морковь	г
1055	морковь вареная	г
1056	морковь крупная	г
1057	морковь молодая	г
1058	морковь по-корейски	г
1059	морковь тертая	шт.
1060	мороженое	по вкусу
1061	мороженое ванильное	г
1062	мороженое клубничное	г
1063	мороженое лимонное	по вкусу
1064	мороженое малиновое	г
1065	мороженое пломбир	г
1066	мороженое шоколадное	мл
1067	морошка	г
1068	морские гребешки	кг
1069	морской коктейль	г
1070	морской коктейль в масле	упаковка
1071	морской коктейль замороженный	г
1072	морской черт	г
1073	морской язык	г
1074	морской язык филе	г
1075	мортаделла	г
1076	моцарелла	г
1077	моцарелла для запекания	г
1078	моцарелла для пиццы	г
1079	моцарелла мини	г
1080	моцарелла с травами	г
1081	моцарелла шарик большой	г
1082	мука	г
1083	мука 1 сорт	г
1084	мука 2 сорт	г
1085	мука «Аладушкин»	г
1086	мука грубого помола	г
1087	мука для темпуры	г
1088	мука из пророщенной пшеницы	ст. л.
1089	мука манитоба	г
1090	мука самоподнимающаяся	г
1091	мука с отрубями	ч. л.
1092	мука с семечками	г
1093	мука хлебопекарная	г
1094	мука цельнозерновая	г
1095	мускат белый	мл
1096	мускатное вино	г
1097	мускатный орех	г
1098	мускатный орех молотый	г
1099	мюсли	г
1100	мягкий творог	г
1101	мясной бульон	г
1102	мясной фарш	г
1103	мясо	г
1104	мясо дикого кабана	г
1105	мясо криля	г
1106	мясо на косточке	кг
1107	мята	г
1108	мята сушеная	г
1109	мятный сироп	г
1110	мятный шнапс	г
1111	нардек	г
1112	нектарины	шт.
1113	нога ягненка без кости	г
1114	нори	г
1115	нуга	г
1116	нуга с орехами	г
1117	нут	г
1118	нутелла	г
1119	нут консервированный	г
1120	нутовая мука	г
1121	облепиха	г
1234	пеперончино	ч. л.
1122	облепиха замороженная	г
1123	облепиховый сироп	стакан
1124	овощи	г
1125	овощная смесь	г
1126	овощная смесь замороженная	г
1127	овощная смесь замороженная для wok	г
1128	овощная смесь по-китайски	г
1129	овощной бульон	по вкусу
1130	овсяная мука	г
1131	овсяное молоко	стакан
1132	овсяное печенье	г
1133	овсяное толокно	г
1134	овсяные зерна	г
1135	овсяные отруби	г
1136	овсяные хлопья	г
1137	овсяные хлопья быстрого приготовления	г
1138	огуречный рассол	стакан
1139	огурцы	г
1140	огурцы консервированные	шт.
1141	огурцы малосольные	шт.
1142	огурцы маринованные	банка
1143	огурцы свежие	г
1144	огурцы соленые	г
1145	одуванчики	г
1146	окорок	г
1147	окорок варено-копченый	г
1148	окунь	г
1149	окунь красный филе	г
1150	окунь морской	г
1151	окунь морской филе	г
1152	окунь филе	г
1153	оленина	г
1154	оливки	г
1155	оливки без косточек	г
1156	оливки зеленые	по вкусу
1157	оливки зеленые консервированные	банка
1158	оливки каламата	г
1159	оливки консервированные	г
1160	оливки, фаршированные анчоусами	г
1161	оливки черные	по вкусу
1162	оливковая паста	г
1163	оливковое масло	г
1164	оливковое масло Extra Virgin	г
1165	опунция плоды	г
1166	опята	по вкусу
1167	опята замороженные	г
1168	опята маринованные	г
1169	орегано	г
1170	орегано свежий	г
1171	орегано сушеный	г
1172	орехи	г
1173	орехи бразильские	г
1174	орехи макадамия	г
1175	орехи пекан	г
1176	орехи пекан засахаренные	г
1177	орехи пинии	г
1178	ореховая крошка	стакан
1179	ореховая паста	шт.
1180	ореховое масло	ст. л.
1181	ореховый ликер	мл
1182	ореховый соус	ст. л.
1183	осетр	г
1184	осетрина холодного копчения	г
1185	осьминог	г
1186	осьминоги консервированные	г
1187	осьминоги мини	г
1188	отруби	г
1189	ошеек	г
1190	пагр	г
1191	пажитник	г
1192	пажитник семена	г
1193	палтус	г
1194	пальмовое масло	г
1195	пангасиус	г
1196	панеттоне	шт.
1197	Панифарин	г
1198	панчетта	г
1199	папайя	г
1200	папайя консервированная в собственном соку	г
1201	папоротник	г
1202	папоротник соленый	упаковка
1203	паппарделле	г
1204	паприка	г
1205	паприка копченая	ст. л.
1206	паприка красная	ст. л.
1207	паприка красная молотая	г
1208	паприка острая копченая	г
1209	паприка сладкая	г
1210	паприка сладкая копченая	г
1211	паприка сладкая хлопьями	ч. л.
1212	пармезан	г
1213	паста	г
1214	паста веджимайт	г
1215	паста тахини	г
1216	паста хариса	ст. л.
1217	пастернак	г
1218	пастила	г
1219	пастила виноградная	г
1220	патиссоны	г
1221	патока	г
1222	патока крахмальная	г
1223	патока черная (меласса)	г
1224	пахта	г
1225	паштет	г
1226	пекарский порошок	г
1227	пекарский порошок	ч. л.
1228	пекорино	г
1229	пектин	г
1230	пеленгас	г
1231	пельмени	г
1232	пенне	г
1233	пенне ригате	г
1235	пеперончино молотый	щепотка
1236	переводной лист для шоколада	шт.
1237	перепелки	тушка
1238	перец	г
1239	перец белый	г
1240	перец белый горошком	по вкусу
1241	перец белый молотый	г
1242	перец белый свежемолотый	ч. л.
1243	перец болгарский	г
1244	перец болгарский желтый	г
1245	перец болгарский зеленый	г
1246	перец болгарский красный	г
1247	перец горошком	г
1248	перец горошком смесь	г
1249	перец душистый	щепотка
1250	перец душистый горошком	г
1251	перец душистый молотый	г
1252	перец испанский острый	шт.
1253	перец кайенский	г
1254	перец кайенский красный	г
1255	перец кайенский молотый	щепотка
1256	перец красный	г
1257	перец красный горошком	г
1258	перец красный жгучий	г
1259	перец красный молотый	г
1260	перец красный острый	г
1261	перец красный острый молотый	по вкусу
1262	перец красный хлопьями	щепотка
1263	перец лимонный	г
1264	перец маринованный	г
1265	перец острый	г
1266	перец острый зеленый	шт.
1267	перец острый молотый	щепотка
1268	перец падрон	г
1269	перец пеперони	г
1270	перец пеперони красный	шт.
1271	перец розовый горошком	г
1272	перец свежемолотый смесь	г
1273	перец сенегальский	по вкусу
1274	перец сладкий	г
1275	перец сладкий желтый	г
1276	перец сладкий зеленый	г
1277	перец сладкий красный	г
1278	перец сладкий красный маринованный	шт.
1279	перец сладкий красный молотый	г
1280	перец сладкий оранжевый	г
1281	перец сладкий сушеный	г
1282	перец сычуаньский	г
1283	перец халапеньо	г
1284	перец халапеньо маринованный	шт.
1285	перец черный	ст. л.
1286	перец черный горошком	по вкусу
1287	перец черный молотый	г
1288	перец черный свежемолотый	г
1289	перец чили	г
1290	перец чили зеленый	стручок
1291	перец чили красный	стручок
1292	перец чили маринованный	по вкусу
1293	перец чили молотый	г
1294	перец чили сухой	ст. л.
1295	перец чили хлопьями	по вкусу
1296	перец ямайский	г
1297	перловая крупа	г
1298	перловая мука	г
1299	персики	г
1300	персики консервированные	г
1301	персики сушеные	горсть
1302	персиковое пюре	г
1303	персиковый джем	г
1304	персиковый мармелад	ст. л.
1305	персиковый сироп	мл
1306	персиковый сок	г
1307	перцовая паста	ч. л.
1308	петрушка	г
1309	петрушка зелень	г
1310	петрушка итальянская	пучок
1311	петрушка корень	г
1312	петрушка рубленая	г
1313	петрушка сушеная	г
1314	печень	г
1315	печенье	по вкусу
1316	печенье Oreo	г
1317	печенье Амаретти	г
1318	печенье бисквитное	г
1319	печенье галетное	шт.
1320	печенье «Дамские пальчики»	г
1321	печенье песочное	г
1322	печенье рассыпчатое	г
1323	печенье Савоярди	г
1324	печенье сахарное	г
1325	печенье сладкое	г
1326	печенье сухое	г
1327	печенье шоколадное	г
1328	печенье Юбилейное молочное	г
1329	пиво	г
1330	пиво имбирное	мл
1331	пиво нефильтрованное	г
1332	пиво светлое	г
1333	пиво темное	банка
1334	пикша	шт.
1335	питы	по вкусу
1336	повидло	г
1337	подсолнечное масло	г
1338	подсолнечные семечки	г
1339	полба	г
1340	полба недозрелая	г
1341	полента	по вкусу
1342	полента быстрого приготовления	стакан
1343	помело	г
1344	помидоры	г
1345	помидоры бурые	г
1346	помидоры вяленые	по вкусу
1347	помидоры вяленые в масле	г
1348	помидоры желтые	шт.
1349	помидоры зеленые	кг
1350	помидоры консервированные	г
1351	помидоры консервированные в собственном соку	г
1352	помидоры консервированные в собственном соку с базиликом	г
1353	помидоры протертые пассата	г
1354	помидоры соленые	шт.
1355	помидоры сушеные хлопьями	г
1356	помидоры черри	г
1357	помидоры черри желтые	г
1358	попкорн	г
1359	поросенок	кг
1360	портвейн	г
1361	портобелло	г
1362	портулак	г
1363	посыпка кондитерская	по вкусу
1364	почки	г
1365	приправа 4 перца	г
1366	приправа 5 специй (five spice)	ч. л.
1367	приправа для баранины	ст. л.
1368	приправа для картофеля	г
1369	приправа для курицы	г
1370	приправа для макарон	по вкусу
1371	приправа для маринования свинины	по вкусу
1372	приправа для морепродуктов	по вкусу
1373	приправа для мяса	г
1374	приправа для паэльи	по вкусу
1375	приправа для пиццы	ч. л.
1376	приправа для плова	г
1377	приправа для птицы	ст. л.
1378	приправа для рыбы	г
1379	приправа для салатов	по вкусу
1380	приправа заатар	ч. л.
1381	приправа креольская	ст. л.
1382	приправа с сушеными грибами	ч. л.
1383	приправы	г
1384	прованские травы	г
1385	проволоне	г
1386	просекко	мл
1387	простокваша	г
1388	протеин сывороточный	г
1389	прошутто	г
1390	пряники	г
1391	пряничные специи	г
1392	пряности	г
1393	псиллиум	г
1394	птитим	г
1395	пудинг	г
1396	пудинг ванильный	г
1397	пудинг ванильный инстант	упаковка
1398	пудинг карамельный	г
1399	пшеница	г
1400	пшеничная крупа	г
1401	пшеничная мука	г
1402	пшеничная мука цельнозерновая	г
1403	пшеничные зародыши	стакан
1404	пшеничные отруби	г
1405	пшеничные ростки	г
1406	пшеничные хлопья	г
1407	пшенные хлопья	ст. л.
1408	пшено	г
1409	пыльца цветочная	г
1410	пюре	по вкусу
1411	радиккио	шт.
1412	разрыхлитель	г
1413	раки	шт.
1414	раковые шейки	г
1415	раковые шейки в рассоле	г
1416	рамбутан	г
1417	рапаны	г
1418	рапсовое масло	по вкусу
1419	рассол	г
1420	рассол от каперсов	ст. л.
1421	рассол от оливок	ст. л.
1422	растительное масло	г
1423	растительное масло для жарки	г
1424	растительное масло нерафинированное	стакан
1425	растительное масло рафинированное	г
1426	растительное молоко	стакан
1427	ревень	г
1428	реган	веточка
1429	редис	г
1430	редька	г
1431	редька белая	шт.
1432	редька зеленая	шт.
1433	редька черная	шт.
1434	репа	г
1435	репа белая	шт.
1436	ржаная закваска	г
1437	ржаная закваска густая	г
1438	ржаная мука	г
1439	ржаные отруби	г
1440	ригатони	г
1441	рикотта	г
1442	рикотта твердая	г
1443	рис	г
1444	рис арборио	г
1445	рис басмати	г
1446	рис бурый	г
1447	рис бурый и дикий смесь	г
1448	рис вареный	г
1449	рис виола	г
1450	рис девзира	г
1451	рис дикий	г
1452	рис дикий и золотистый смесь	г
1453	рис длиннозерный	г
1454	рис длиннозерный золотистый	г
1455	рис для плова	г
1456	рис для пудинга	г
1457	рис для ризотто	г
1458	рис для суши	г
1459	рис жасминовый	г
1460	рис золотистый	г
1461	рис индика	г
1462	рис италика	г
1463	рис карнароли	г
1464	рис красный	г
1465	рис круглозерный	г
1466	рис кубанский	г
1467	рисовая бумага	г
1468	рисовая лапша	г
1469	рисовая мука	г
1470	рисовое вино	ч. л.
1471	рисовые хлопья	г
1472	рисовые шарики воздушные	г
1473	рисовый крахмал	ст. л.
1474	рисовый уксус	по вкусу
1475	рис пропаренный	г
1476	рис пропаренный и дикий смесь	г
1477	рис японика	г
1478	рожь	г
1479	розмарин	шт.
1480	розмарин сушеный	по вкусу
1481	розовая вода	г
1482	розовые бутоны сушеные	г
1483	розовые лепестки	г
1484	розы	г
1485	рокфор	г
1486	ром	бутылка
1487	ромашка сушеная	г
1488	ромовый экстракт	ч. л.
1489	ром темный	г
1490	ростбиф	г
1491	рукола	г
1492	рулька	по вкусу
1493	рыба	г
1494	рыба белая	г
1495	рыба белая филе	г
1496	рыба консервированная	банка
1497	рыба копченая	г
1498	рыба копченая филе	г
1499	рыба красная	г
1500	рыба красная соленая	г
1501	рыба красная филе	г
1502	рыба-меч	г
1503	рыба морская	г
1504	рыба солнечник филе	шт.
1505	рыба-соль	тушка
1506	рыбное филе	г
1507	рыбные консервы	г
1508	рыбные кости	г
1509	рыбные обрезки, головы, плавники	по вкусу
1510	рыбный бульон	г
1511	рыбный соус	г
1512	рыбный соус Nam Pla	г
1513	рыбный соус тайский	г
1514	рыбный фарш	г
1515	рябина черноплодная	г
1516	рябчик	г
1517	ряженка	г
1518	ряженка 4%	г
1519	сайда	г
1520	сайда филе	г
1521	сайра	г
1522	сайра консервированная	банка
1523	саке	ст. л.
1524	салака	г
1525	салат	г
1526	салат айсберг	г
1527	салат китайский	г
1528	салат корн	пучок
1529	салат кочанный	г
1530	салат кучерявый	г
1531	салат листовой	г
1532	салатный микс	г
1533	салат романо	г
1534	салат фриссе	г
1535	сало	г
1536	сало копченое в перце	г
1537	сало копченое с мясными прослойками	г
1538	сало с мясными прослойками	г
1539	сальник	г
1540	сальса	г
1541	сальса верде	ч. л.
1542	салями	г
1543	салями итальянская	г
1544	сардельки	г
1545	сардельки копченые	г
1546	сардинки маленькие	шт.
1547	сардины	г
1548	сардины в масле	банка
1549	сахар	г
1550	сахар ванильный	г
1551	сахар демерара	г
1552	сахар жемчужный	г
1553	сахар коричневый	г
1554	сахар коричневый крупнокристаллический	г
1555	сахар мусковадо	горсть
1556	сахарная пудра	г
1557	сахарная пудра апельсиновая	г
1558	сахарная пудра ванильная	г
1559	сахарные жемчужинки	г
1560	сахарные кондитерские украшения	горсть
1561	сахарный песок	г
1562	сахарный песок крупный	г
1563	сахарный песок мелкий	г
1564	сахарный сироп	г
1565	сахар пальмовый	г
1566	сахар-рафинад	г
1567	сахар-рафинад с корицей	г
1568	сахар тростниковый	г
1569	сванская соль	г
1570	свекла	г
1571	свекла вареная	г
1572	свекольная ботва	г
1573	свекольные листья	г
1574	свиная вырезка	г
1575	свиная голова	г
1576	свиная грудинка	г
1577	свиная корейка	г
1578	свиная корейка копченая	г
1579	свиная корейка на кости	г
1580	свиная лопатка варено-копченая	г
1581	свиная мякоть	г
1582	свиная пашина	кг
1583	свиная печень	г
1584	свиная рулька	по вкусу
1585	свиная рулька варено-копченая	г
1586	свиная рулька копченая	г
1587	свиная шейка	кусок
1588	свинина	г
1589	свинина вареная	г
1590	свинина нежирная	г
1591	свинина с жирком	г
1592	свиное сердце	г
1593	свиное филе	г
1594	свиной подчеревок	г
1595	свиной фарш	г
1596	свиной язык	г
1597	свиные котлеты на косточке	шт.
1598	свиные легкие	г
1599	свиные ножки	г
1600	свиные отбивные	г
1601	свиные отбивные на косточке	г
1602	свиные ребра	г
1603	свиные уши	шт.
1604	свиные щечки	шт.
1605	свити	г
1606	сельдерей	г
1607	сельдерей зелень	г
1608	сельдерей корень	г
1609	сельдерей корень сушеный	по вкусу
1610	сельдерейная соль	г
1611	сельдерей семена	ч. л.
1612	сельдерей стебли	г
1613	сельдь	г
1614	сельдь слабосоленая	г
1615	сельдь соленая	шт.
1616	сельдь филе	г
1617	семга	г
1618	семга копченая	г
1619	семга свежая	г
1620	семга соленая	г
1621	семга филе на коже	г
1622	семечки	г
1623	семечки смесь	ст. л.
1624	семолина	г
1625	сервелат варено-копченый	г
1626	сибас	г
1627	сидр	г
1628	сироп	г
1629	сироп от консервированных груш	г
1630	сироп от консервированных персиков	ст. л.
1631	сироп топинамбура	стакан
1632	скумбрия	по вкусу
1633	скумбрия свежая	г
1634	скумбрия филе	г
1635	скумбрия холодного копчения	г
1636	сливки	упаковка
1637	сливки 10-20%	г
1638	сливки 15%	г
1639	сливки 20%	г
1640	сливки 33-35%	г
1641	сливки жирные	г
1642	сливки кондитерские	г
1643	сливовая паста	г
1644	сливовое варенье	г
1645	сливовое вино	г
1646	сливовый джем	г
1647	сливовый ликер	ст. л.
1648	сливовый соус	г
1649	сливочное масло	г
1650	сливы	кг
1651	сливы замороженные	г
1652	смалец	г
1653	смесь для кекса	шт.
1654	смесь для оладий	г
1655	смесь для хлеба 8 злаков	г
1656	сметана	г
1657	сметана 10%	г
1658	сметана 15%	ч. л.
1659	сметана 18%	г
1660	сметана 20%	г
1661	сметана 25%	г
1662	сметана 30%	г
1663	сметана 35%	г
1664	сметана жирная	г
1665	сметана нежирная	г
1666	сметана некислая	г
1667	смородина сушеная	г
1668	смородиновые листья	г
1669	сморчки сухие	г
1670	снежок	л
1671	сныть	г
1672	сода	г
1673	соевая мука	г
1674	соевое масло	г
1675	соевое молоко	г
1676	соевые ростки	г
1677	соевый соус	г
1678	сок	г
1679	сок из красных апельсинов	мл
1680	сок мультивитаминный	мл
1681	сок юзу	мл
1682	солод	ч. л.
1683	солод жидкий	г
1684	солодовый экстракт	г
1685	солод темный	г
1686	соломка	г
1687	соль	г
1688	соль гималайская	г
1689	соль крупного помола	г
1690	соль морская	г
1691	сом филе	г
1692	сосиски	г
1693	сосиски из куриного фарша	шт.
1694	сосиски копченые	г
1695	соус	г
1696	соус black bean	ст. л.
1697	соус sambal oelek	ч. л.
1698	соус барбекю	г
1699	соус краснодарский	г
1700	соус красный острый	г
1701	соус мирин	по вкусу
1702	соус наршараб	г
1703	соус острый	г
1704	соус песто	по вкусу
1705	соус сацебели	г
1706	соус табаско	капля
1707	соус терияки	г
1708	соус ткемали	стакан
1709	соус ткемали благородный	г
1710	соус ткемали ранний	ст. л.
1711	соус устричный	ч. л.
1712	соус чили	г
1713	соус чили сладкий	ч. л.
1714	соус экзотический	г
1715	соя	г
1716	спагетти	г
1717	спагетти № 3	г
1718	спагетти № 5	г
1719	спагетти лунги	г
1720	спаржа	кг
1721	спаржа белая	г
1722	спаржа зеленая	г
1723	спаржа молодая	г
1724	спек	г
1725	спельта	стакан
1726	спельтовая (полбяная) мука	г
1727	специи	г
1728	спирт	г
1729	спирулина порошок	г
1730	спред	г
1731	ставрида	г
1732	стейк семги	шт.
1733	стейк семги	г
1734	стеклянная лапша	г
1735	страчателла	г
1736	судак	г
1737	судак филе	г
1738	судак филе на коже	г
1739	сулугуни	г
1740	сулугуни копченый	г
1741	сумах	г
1742	суповой набор	г
1743	сухари	по вкусу
1744	сухари белые	г
1745	сухари молотые	г
1746	сухари панировочные	г
1747	сухари ржаные	г
1748	сухарная крошка	г
1749	сухофрукты	г
1750	сухофрукты тропические	по вкусу
1751	сушки	г
1752	сыворотка	г
1753	сыр	г
1754	сыр tete de moine	г
1755	сыр Австрия блю	г
1756	сыр адыгейский	г
1757	сыр бри	г
1758	сыр буко	г
1759	сыр гауда	г
1760	сыр гойя	г
1761	сыр голландский	г
1762	сыр голубой	г
1763	сыр гравьера	г
1764	сыр джугас	г
1765	сыр домашний	г
1766	сыр дорблю	г
1767	сыр имеретинский	г
1768	сыр кефалотири	г
1769	сырки творожные	г
1770	сыр козий мягкий	г
1771	сыр козий твердый	г
1772	сыр колбасный	г
1773	сыр копченый	г
1774	сыр коттедж	г
1775	сыр Маскарпоне	г
1776	сыр мраморный	г
1777	сыр мягкий	по вкусу
1778	сыр овечий	г
1779	сыр панир	г
1780	сыр пеше миньон	г
1781	сыр плавленый	г
1782	сыр плавленый шоколадный	г
1783	сыр пластинками	г
1784	сыр полутвердый	г
1785	сыр провола	г
1786	сыр российский	г
1787	сыр скаморца	г
1788	сыр скаморца копченый	г
1789	сыр сливочный	г
1790	сыр с плесенью	г
1906	устрицы	г
1791	сыр с плесенью мягкий	г
1792	сыр твердый	г
1793	сыр филадельфия	г
1794	сыр фонтина	г
1795	сыр хаварти	г
1796	сыр швейцарский	г
1797	сычужный фермент	ч. л.
1798	таледжо	г
1799	тальолини	г
1800	тальятелле	г
1801	тальятелле-гнезда	шт.
1802	тамаринд	шт.
1803	тамариндовая паста	ч. л.
1804	тапиока	г
1805	тарталетки	по вкусу
1806	тартар	ст. л.
1807	тархун	г
1808	творог	г
1809	творог 18%	г
1810	творог 2%	г
1811	творог 5%	г
1812	творог 9%	г
1813	творог жирный	г
1814	творог зерненый	г
1815	творог обезжиренный	г
1816	творожная масса	г
1817	творожная паста	г
1818	творожный сыр	г
1819	творожный сыр соленый	г
1820	творожок клубничный	г
1821	текила	стакан
1822	телятина	по вкусу
1823	телятина вареная	г
1824	телячий фарш	г
1825	телячьи отбивные на косточке	шт.
1826	телячьи шницели	шт.
1827	телячьи эскалопы	г
1828	телячья вырезка	г
1829	телячья печень	г
1830	телячья щека	шт.
1831	тесто бездрожжевое	г
1832	тесто готовое	г
1833	тесто для вонтонов	г
1834	тесто для пиццы	шт.
1835	тесто дрожжевое	по вкусу
1836	тесто катаифи	г
1837	тесто макаронное	г
1838	тесто макаронное для лазаньи	г
1839	тесто пельменное	г
1840	тесто песочное	по вкусу
1841	тесто пресное	г
1842	тесто пряничное	г
1843	тесто слоеное	г
1844	тесто слоеное бездрожжевое	по вкусу
1845	тесто слоеное дрожжевое	кг
1846	тесто фило	г
1847	тилапия	г
1848	тилапия филе	г
1849	тильзитер	г
1850	тимьян	горсть
1851	тимьян лимонный	веточка
1852	тимьян свежий	по вкусу
1853	тимьян сушеный	г
1854	ткемали	г
1855	тмин	г
1856	тмин молотый	г
1857	томатная паста	г
1858	томатное пюре	г
1859	томатный концентрат	г
1860	томатный порошок	г
1861	томатный сок	г
1862	томатный соус	г
1863	томатный соус итальянский	г
1864	томатный соус острый	г
1865	томатный соус с базиликом	г
1866	тоник	бутылка
1867	топинамбур	г
1868	топленое масло	г
1869	тортильи	по вкусу
1870	тортильони	г
1871	тофу	г
1872	травы ароматные	г
1873	травы пряные с перцем	ч. л.
1874	травы сухие	г
1875	треска	г
1876	треска печень	г
1877	треска филе	г
1878	трюфель	г
1879	трюфельная крошка	г
1880	трюфельное масло	ст. л.
1881	трюфель черный	шт.
1882	тунец	по вкусу
1883	тунец консервированный	г
1884	тунец филе	г
1885	тушенка	г
1886	тыква	г
1887	тыквенное масло	шт.
1888	тыквенное пюре	г
1889	тыквенные семечки	г
1890	тюлька свежая	г
1891	угорь	г
1892	угорь копченый	г
1893	угурт	г
1894	укроп	г
1895	укропное семя	ч. л.
1896	укроп свежий	г
1897	укроп сушеный	г
1898	уксус	г
1899	уксус 9%	г
1900	уксус из сидра	ст. л.
1901	уксусная эссенция	г
1902	уксус столовый	г
1903	улитки	г
1904	улитки виноградные	шт.
1905	урюк	г
1907	утиная грудка	г
1908	утиная печень	г
1909	утиное филе	г
1910	утиные бедрышки	г
1911	утиные ножки	по вкусу
1912	утка	по вкусу
1913	утка печеная	г
1914	утка тушка	тушка
1915	уцхо-сунели	г
1916	фазан	г
1917	фарш (баранина и говядина)	г
1918	фарш (свинина и курица)	г
1919	фасоль	г
1920	фасоль белая	г
1921	фасоль белая консервированная	г
1922	фасоль белая лима	г
1923	фасоль зеленая стручковая	г
1924	фасоль кенийская	горсть
1925	фасоль кидни красная	г
1926	фасоль консервированная	г
1927	фасоль красная	г
1928	фасоль красная вареная	стакан
1929	фасоль красная консервированная	г
1930	фасоль молодая замороженная	г
1931	фасоль пинто	г
1932	фасоль спаржевая вареная	г
1933	фасоль стручковая	г
1934	фасоль стручковая замороженная	г
1935	фасоль стручковая консервированная	г
1936	фасоль черный глаз	г
1937	фейхоа	г
1938	фенхель	г
1939	фенхель семена	г
1940	фенхель семена молотые	г
1941	фестонате	г
1942	фета	г
1943	фетаки	г
1944	фетакса	г
1945	феттучине	г
1946	фиалки засахаренные	шт.
1947	фиалковый сироп	г
1948	физалис	по вкусу
1949	филе красного окуня	шт.
1950	филе лосося	г
1951	филе палтуса	шт.
1952	финики	г
1953	финики без косточек	стакан
1954	финики иранские	г
1955	финики иранские без косточек	шт.
1956	фисташки	г
1957	фисташки очищенные	г
1958	фисташки очищенные несоленые	горсть
1959	фисташки рубленые	г
1960	фисташковая мука	г
1961	фисташковая паста	г
1962	фисташковое масло	г
1963	фокачча	по вкусу
1964	форель	г
1965	форель вареная	г
1966	форель горячего копчения	г
1967	форель озерная свежая	шт.
1968	форель слабосоленая	г
1969	форель стейки	шт.
1970	форель филе	г
1971	форель холодного копчения	г
1972	фрикадельки	г
1973	фрукт дракона	шт.
1974	фруктовый сироп	г
1975	фруктовый сок	г
1976	фруктовый сок без сахара	стакан
1977	фруктоза	г
1978	фрукты	г
1979	фрукты консервированные	г
1980	фундук	г
1981	фундучная мука	г
1982	фунчоза	г
1983	халва	г
1984	халва ванильная	г
1985	халва подсолнечная	г
1986	халуми	г
1987	хамон	г
1988	хек	г
1989	хек филе	г
1990	херес	стакан
1991	хересный уксус	ч. л.
1992	хлеб	г
1993	хлеб 7 злаков	батон
1994	хлеб белый	г
1995	хлеб белый сухой	г
1996	хлеб бородинский	кусок
1997	хлеб датский ржаной	г
1998	хлеб для сэндвичей	г
1999	хлебная крошка	г
2000	хлеб ржаной	г
2001	хлеб серый	г
2002	хлеб с кунжутом	кусок
2003	хлеб цельнозерновой	г
2004	хлебцы пшенично-ржаные цельнозерновые	г
2005	хлопья 4 злака	г
2006	хлопья 5 злаков	г
2007	хлопья 7 злаков	ст. л.
2008	хлопья быстрого приготовления	стакан
2009	хлорид кальция	г
2010	хмели-сунели	г
2011	хмель	ст. л.
2012	хрен	г
2013	хрен протертый	г
2014	хрен со сливками	г
2015	хурма	г
2016	хурма спелая	г
2017	цесарка тушка	г
2018	цикорий	ч. л.
2019	цитроновые цукаты	горсть
2020	цитрусовые цукаты	шт.
2021	цитрусовый свежевыжатый сок	мл
2022	цукаты	г
2023	цукини	г
2024	цукини цветы	шт.
2025	цыплята	г
2026	цыплята-корнишоны	шт.
2027	чабер	г
2028	чабрец	г
2029	чабрец сушеный	г
2030	чай дарджилинг	пакетик
2031	чай жасминовый	ст. л.
2032	чай зеленый	пакетик
2033	чай копченый лапсанг сушонг	г
2034	чай красный	г
2035	чай ройбуш	ст. л.
2036	чай черный	г
2037	чай черный крупнолистовой	ч. л.
2038	чай черный со специями	пакет
2039	чай эрл грей	стакан
2040	чатни манго	г
2041	чеддер	г
2042	черемуха	г
2043	черемуховая мука	г
2044	черемша	г
2045	черешневый джем	г
2046	черешня	г
2047	черешня консервированная без косточек	ст. л.
2048	черная смородина	г
2049	черника	г
2050	черника замороженная	г
2051	чернила каракатицы	г
2052	черничный джем	стакан
2053	чернослив	г
2054	чернослив без косточек	г
2055	чернослив вяленый	г
2056	чернослив копченый без косточек	г
2057	черносмородиновое варенье	г
2058	черносмородиновый джем	г
2059	чеснок	г
2060	чеснок молодой	г
2061	чеснок сушеный	г
2062	чесночная соль	щепотка
2063	чесночное масло	по вкусу
2064	чесночный порошок	г
2065	чечевица	г
2066	чечевица вареная	ст. л.
2067	чечевица зеленая	г
2068	чечевица красная	г
2069	чечил спагетти	г
2070	чиабатта	кусок
2071	чиа семена	г
2072	чипотле молотый	щепотка
2073	чипсы	г
2074	чоризо	г
2075	шалфей	г
2076	шалфей свежий	пучок
2077	шалфей сушеный	лист
2078	шампанское	г
2079	шампанское советское	стакан
2080	шампанское сухое	ст. л.
2081	шампиньоны	по вкусу
2082	шампиньоны замороженные	г
2083	шампиньоны консервированные	г
2084	шампиньоны маринованные	г
2085	шампиньоны свежие	г
2086	шафран	г
2087	шафран имеретинский	г
2088	шафран молотый	ч. л.
2089	шафран нити	шт.
2090	шелковица	г
2091	шелковица сушеная	г
2092	шиповник	г
2093	шиповниковый сироп	г
2094	шнапс	г
2095	шнитт-лук	стебель
2096	шоколад	г
2097	шоколад белый	г
2098	шоколад горький с апельсиновой цедрой	г
2099	шоколад молочный	г
2100	шоколад мятный	г
2101	шоколадная паста	г
2102	шоколадная стружка	г
2103	шоколадное масло	г
2104	шоколадно-ореховая паста	г
2105	шоколадные горошины	г
2106	шоколадные капли	г
2107	шоколадные капли белые	г
2108	шоколадные конфеты	г
2109	шоколадные хлопья	г
2110	шоколадные шарики из готовых завтраков	горсть
2111	шоколадный ликер	г
2112	шоколадный сироп	г
2113	шоколадный соус	г
2114	шоколад полусладкий	г
2115	шоколад с орехами	г
2116	шоколад черный горький	г
2117	шоколад черный горький 70%	г
2118	шоколад черный горький 75%	ч. л.
2119	шоколад черный горький 85%	г
2120	шортенинг	стакан
2121	шпик	шт.
2122	шпик копченый	г
2123	шпинат	г
2124	шпинат замороженный	г
2125	шпинат молодой	г
2126	шпинат свежий	г
2127	шпроты	г
2128	шпроты в масле	г
2129	шрот	г
2130	щавель замороженный	г
2131	щавель свежий	веточка
2132	щука	г
2133	щука филе	г
2134	эгг-ног	стакан
2135	эдам	г
2136	эль	мл
2137	эмменталь	г
2138	эскалоп	г
2139	эстрагон	г
2140	эстрагон сушеный	веточка
2141	яблоки	г
2142	яблоки антоновка	кг
2143	яблоки гала	г
2144	яблоки голден	г
2145	яблоки гренни смит	кг
2146	яблоки зеленые	г
2147	яблоки красные	шт.
2148	яблоки моченые	шт.
2149	яблоки нетвердых сортов	г
2150	яблоки сладкие	г
2151	яблоки сушеные	г
2152	яблочная эссенция	ч. л.
2153	яблочное варенье	г
2154	яблочное повидло	г
2155	яблочное пюре	г
2156	яблочные чипсы	стакан
2157	яблочный джем	г
2158	яблочный сироп	ст. л.
2159	яблочный сок	г
2160	яблочный соус	ст. л.
2161	яблочный уксус	г
2162	ягнятина	г
2163	ягнятина кострец	г
2164	ягнятина фарш	г
2165	ягнячьи отбивные на косточке	шт.
2166	ягнячья голень нарубленная	г
2167	ягнячья корейка	г
2168	ягодное варенье	ст. л.
2169	ягодное желе	г
2170	ягодный сироп	г
2171	ягодный сок	г
2172	ягодный соус кислый	г
2173	ягоды	г
2174	ягоды вяленые	по вкусу
2175	ягоды замороженные	г
2176	ягоды лесные	г
2177	ягоды лесные замороженные	г
2178	яичные белки	г
2179	яичные желтки	г
2180	яичные желтки вареные	шт.
2181	яичные желтки крупные	г
2182	яичный меланж	г
2183	яичный порошок	ст. л.
2184	яйца куриные	г
2185	яйца куриные крупные	г
2186	яйца перепелиные	г
2187	японская крошка панко	г
2188	ячменные хлопья	г
2189	ячмень	г
2190	ячневая крупа	г
\.


--
-- Data for Name: api_ingredientinrecipe; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_ingredientinrecipe (id, amount, ingredient_id, recipe_id) FROM stdin;
1	300	1136	1
2	150	1172	1
3	100	1749	1
4	50	995	1
5	50	1422	1
6	50	645	1
7	240	1082	6
8	250	594	6
9	1	2184	6
10	40	1549	6
11	5	1687	6
12	5	1672	6
13	60	1422	6
14	50	1136	5
15	70	1952	5
16	170	596	5
17	300	648	5
18	80	992	5
19	10	9	5
20	400	1917	4
21	1	889	4
22	1	1059	4
23	50	310	4
24	20	2059	4
25	50	1082	4
26	50	1857	4
27	150	167	4
28	600	556	4
29	100	1033	4
30	50	1649	4
31	150	1753	4
32	40	1163	4
33	1	1480	4
34	20	1308	4
35	5	1687	4
36	5	1287	4
37	500	885	3
38	500	556	3
39	150	887	3
40	1000	167	3
41	100	1649	3
42	200	1639	3
43	10	1687	3
44	1	1285	3
45	4	2184	2
46	200	1344	2
47	150	1243	2
48	1	879	2
49	25	1857	2
50	10	2059	2
51	5	1549	2
52	5	1687	2
53	5	1287	2
54	800	1843	7
55	300	2123	7
56	4	2184	7
57	150	1640	7
58	50	851	7
59	50	435	7
60	250	150	7
61	100	1212	7
62	5	1687	7
63	5	1287	7
\.


--
-- Data for Name: api_recipe; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_recipe (id, name, image, text, cooking_time, author_id) FROM stdin;
1	Домашняя гранола	recipes/unnamed.jpg	N.B. Мед в рецепте выступает подсластителем, а растительное масло помогает овсяным хлопьям не слипнуться между собой.\r\n\r\nСухофрукты промыть и залить тёплой водой. Порубить орехи ножом и измельчить их молоточком на мелкие кусочки. В глубокой миске смешать овсяные хлопья и рубленые орехи. Добавить мёд и растительное масло, перемешать.\r\n\r\nРазогреть духовку до 130–150 градусов. Выложить гранолу на противень, предварительно застеленный пергаментной бумагой. Запекать 30–35 мин. Каждые 7–8 мин. перемешивать гранолу для более равномерного пропекания. За 5 мин. до готовности добавить просушенные на бумажном полотенце сухофрукты и кокосовую стружку.	45	2
2	Шакшука	recipes/unnamed.png	ук почистить, мелко нарезать и протушить на сковороде до мягкости. Перец, чеснок и помидоры нарезать и добавить на сковороду, протушить. Добавить томатную пасту, посолить, поперчить, разбавить водой и перемешать.\r\n\r\nДобавить сахар, перемешать и сделать углубление для 4-х яиц. В углубления разбить яйца. Накрыть крышкой и жарить до готовности яиц.	30	2
3	Вишисуаз	recipes/unnamed_1.jpg	Растереть сливочное масло в глубокой кастрюле, добавить мелко нарезанный репчатый лук и обжарить до мягкости.\r\n\r\nДобавить мелко нарезанный лук-порей и обжаривать до мягкости. Затем добавить очищенный картофель, нарезанный мелкими кубиками, и бульон. Довести до кипения, посолить, поперчить и варить на медленном огне 30 мин.\r\n\r\nГотовый суп пюрировать в блендере. Охладить и подавать с мелко нарубленным зелёным луком.	45	2
4	Пастуший пирог	recipes/unnamed_2.jpg	Лук, морковь, картофель очистить. Лук и морковь нарезать кубиками, чеснок пропустить через пресс, картофель нарезать.\r\n\r\nПоставить кастрюлю с водой для картофеля и глубокую сковороду для мяса на огонь. На среднем огне разогреть оливковое масло на сковороде. Пассеровать в нём лук с морковью в течение 2–3 мин, добавить чеснок и жарить, помешивая, ещё 30 с. Добавить мясо и, перемешивая, поджаривать его 7–10 мин до готовности. Добавить муку и, постоянно помешивая, готовить ещё 30 с. Добавить бульон, вустерский соус, томатную пасту и сушёные травы по вкусу. Хорошенько перемешать, дать закипеть, уменьшить огонь до минимального и оставить тушиться на 20–30 мин. За 5–10 мин до конца добавить зелёный горошек. В конце посолить, поперчить по вкусу.\r\n\r\nКартофель варить до готовности (20–30 мин), в конце варки посолить по вкусу. Подогреть молоко со сливочным маслом. Пюрировать картофель с молоком и маслом. Можно добавить немного тёртого сыра и куркумы для цвета.\r\n\r\nРазогреть духовку до 180°C. В глубокую посуду для запекания выложить мясной соус, разровнять, сверху распределить картофельное пюре, разровнять. Посыпать тёртым сыром, поставить в духовку на 20–30 мин, пока сыр не станет золотистым.\r\n\r\nПосыпать рубленой петрушкой.	75	2
5	Веганский чизкейк из кешью на кокосовом молоке	recipes/unnamed_3.jpg	Для основы соединяем овсяные хлопья, финики и кешью. Взбиваем в миксере до однородности. Распределяем основу по форме (~16 см, плошка из-под мультиварки немного большевата, но в принципе сойдёт) и отправляем в холодильник.\r\n\r\nКешью соединяем с мёдом и взбиваем в миксере до однородности. В кокосовое молоко добавляем агар-агар и варим, помешивая, до закипания и ещё 2 мин. Снимаем с огня и переливаем к кешью, хорошо перемешиваем. Добавляем к основе и вновь отправляем в холодильник на 1 ч.\r\n\r\nДля малиновой заливки увариваем малину с агаром и протираем через сито. Выливаем на массу, распределяем и отправляем в холодильник на 2 ч.	180	3
6	Оладьи на кефире	recipes/unnamed_4.jpg	Яйцо и кефир достать из холодильника заранее.\r\n\r\nСмешать яйцо с сахаром и солью до растворения последних. В микроволновке слегка подогреть кефир. В яичную смесь, постоянно помешивая, влить кефир.\r\n\r\nПросеять муку и вводить её небольшими порциями в жидкую смесь, постоянно помешивая. Замешать однородное густое тесто. По окончании просеять соду и вмешать её в тесто. Сейчас же можно добавить добавки (ваниль и/или изюм). Дать тесту постоять 10–15 мин. до образования пузырьков. В дальнейшем тесто не перемешивать.\r\n\r\nЖарить на хорошо прогретой сковороде с добавлением масла на среднем огне.	40	3
7	Киш с брынзой и шпинатом	recipes/unnamed_5.jpg	Слоёное тесто раскатать и выложить в форму для выпекания. Смешать яйца, сливки, приправить солью, перцем, лимонным соком, добавить зелень. Брынзу раскрошить, добавить шпинат и яичную смесь. \r\n\r\nНаполнить получившейся начинкой форму, сверху посыпать тёртым сыром и поставить в предварительно разогретую до 180°С духовку. Выпекать 30–40 минут, пока начинка не станет густой. \r\n\r\nГотовый пирог подавать тёплым, украсив дольками томатов черри и листиками салата.	60	2
\.


--
-- Data for Name: api_recipe_tags; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_recipe_tags (id, recipe_id, tag_id) FROM stdin;
1	1	3
2	2	3
3	3	6
4	4	4
5	5	2
6	6	1
7	6	3
8	7	1
9	7	4
\.


--
-- Data for Name: api_recipefavorite; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_recipefavorite (id, recipe_id, user_id) FROM stdin;
1	1	1
2	4	1
3	5	1
\.


--
-- Data for Name: api_recipeincart; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_recipeincart (id, recipe_id, user_id) FROM stdin;
2	4	1
3	5	1
\.


--
-- Data for Name: api_tag; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.api_tag (id, name, color, slug) FROM stdin;
1	выпечка	orange	bakery
2	десерт	pink	dessert
3	завтрак	blue	breakfast
4	основное	red	main_dishes
5	салат	green	salads
6	суп	purple	soups
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Token	7	add_token
26	Can change Token	7	change_token
27	Can delete Token	7	delete_token
28	Can view Token	7	view_token
29	Can add token	8	add_tokenproxy
30	Can change token	8	change_tokenproxy
31	Can delete token	8	delete_tokenproxy
32	Can view token	8	view_tokenproxy
33	Can add ingredient	9	add_ingredient
34	Can change ingredient	9	change_ingredient
35	Can delete ingredient	9	delete_ingredient
36	Can view ingredient	9	view_ingredient
37	Can add ingredient in recipe	10	add_ingredientinrecipe
38	Can change ingredient in recipe	10	change_ingredientinrecipe
39	Can delete ingredient in recipe	10	delete_ingredientinrecipe
40	Can view ingredient in recipe	10	view_ingredientinrecipe
41	Can add tag	11	add_tag
42	Can change tag	11	change_tag
43	Can delete tag	11	delete_tag
44	Can view tag	11	view_tag
45	Can add recipe	12	add_recipe
46	Can change recipe	12	change_recipe
47	Can delete recipe	12	delete_recipe
48	Can view recipe	12	view_recipe
49	Can add recipe in cart	13	add_recipeincart
50	Can change recipe in cart	13	change_recipeincart
51	Can delete recipe in cart	13	delete_recipeincart
52	Can view recipe in cart	13	view_recipeincart
53	Can add recipe favorite	14	add_recipefavorite
54	Can change recipe favorite	14	change_recipefavorite
55	Can delete recipe favorite	14	delete_recipefavorite
56	Can view recipe favorite	14	view_recipefavorite
57	Can add follow	15	add_follow
58	Can change follow	15	change_follow
59	Can delete follow	15	delete_follow
60	Can view follow	15	view_follow
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$TNqqvNNgkrHXcBPZDVp6vr$LmPZd0ir93D5a5f3tEsZc3k5m/ssj5mLWiiNYEK5W/o=	2021-11-22 17:49:50+00	t	admin	Администратор	Сайта	admin@ya.ru	t	t	2021-11-22 17:12:36+00
3	pbkdf2_sha256$260000$Ke0HBqJiGDQsKa8GKW7Hgl$8jloFqhpLgODPT2RAzO/GbmgPdo6LvYu7cOP+zAloF4=	\N	f	test	Тамара	Константиновна	eug.korobkov@gmail.com	f	t	2021-11-22 17:37:28+00
2	pbkdf2_sha256$260000$EkthLWmXPPv2EziewqCeU2$SUf59s2hHgZkWlE+7H6rIzYNAiP3nYuDLh0mDc4K24c=	2021-11-22 17:56:57.455084+00	f	hardkoro	Евгений	Коробков	hardkoro@yandex.ru	f	t	2021-11-22 17:25:13+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-11-22 17:23:28.520471+00	1	выпечка	1	[{"added": {}}]	11	1
2	2021-11-22 17:23:55.719856+00	2	десерт	1	[{"added": {}}]	11	1
3	2021-11-22 17:24:11.919818+00	3	завтрак	1	[{"added": {}}]	11	1
4	2021-11-22 17:24:22.823012+00	4	основное	1	[{"added": {}}]	11	1
5	2021-11-22 17:24:34.734641+00	5	салат	1	[{"added": {}}]	11	1
6	2021-11-22 17:24:45.889508+00	6	суп	1	[{"added": {}}]	11	1
7	2021-11-22 17:25:13.556195+00	2	hardkoro	1	[{"added": {}}]	4	1
8	2021-11-22 17:26:27.066669+00	1	Домашняя гранола by hardkoro	1	[{"added": {}}]	12	1
9	2021-11-22 17:27:13.404709+00	1	Домашняя гранола by hardkoro: овсяные хлопья, г 300	1	[{"added": {}}]	10	1
10	2021-11-22 17:27:25.190936+00	2	Домашняя гранола by hardkoro: орехи, г 150	1	[{"added": {}}]	10	1
11	2021-11-22 17:27:36.877031+00	3	Домашняя гранола by hardkoro: сухофрукты, г 100	1	[{"added": {}}]	10	1
12	2021-11-22 17:28:09.744184+00	4	Домашняя гранола by hardkoro: мед жидкий, г 50	1	[{"added": {}}]	10	1
13	2021-11-22 17:28:26.004875+00	5	Домашняя гранола by hardkoro: растительное масло, г 50	1	[{"added": {}}]	10	1
14	2021-11-22 17:28:41.53714+00	6	Домашняя гранола by hardkoro: кокосовая стружка, г 50	1	[{"added": {}}]	10	1
15	2021-11-22 17:35:08.167518+00	2	Шакшука by hardkoro	1	[{"added": {}}]	12	1
16	2021-11-22 17:35:46.000136+00	3	Вишисуаз by hardkoro	1	[{"added": {}}]	12	1
17	2021-11-22 17:37:00.411745+00	4	Пастуший пирог by hardkoro	1	[{"added": {}}]	12	1
18	2021-11-22 17:37:29.034939+00	3	test	1	[{"added": {}}]	4	1
19	2021-11-22 17:38:01.613645+00	5	Веганский чизкейк из кешью на кокосовом молоке by test	1	[{"added": {}}]	12	1
20	2021-11-22 17:38:38.567804+00	6	Оладьи на кефире by test	1	[{"added": {}}]	12	1
21	2021-11-22 17:38:57.449479+00	7	Оладьи на кефире by test: мука, г 240	1	[{"added": {}}]	10	1
22	2021-11-22 17:39:21.168571+00	8	Оладьи на кефире by test: кефир 3,2%, г 250	1	[{"added": {}}]	10	1
23	2021-11-22 17:39:38.698086+00	9	Оладьи на кефире by test: яйца куриные, г 1	1	[{"added": {}}]	10	1
24	2021-11-22 17:39:55.223368+00	10	Оладьи на кефире by test: сахар, г 40	1	[{"added": {}}]	10	1
25	2021-11-22 17:40:08.035726+00	11	Оладьи на кефире by test: соль, г 5	1	[{"added": {}}]	10	1
26	2021-11-22 17:40:18.097155+00	12	Оладьи на кефире by test: сода, г 5	1	[{"added": {}}]	10	1
27	2021-11-22 17:40:30.794486+00	13	Оладьи на кефире by test: растительное масло, г 60	1	[{"added": {}}]	10	1
28	2021-11-22 17:40:57.123334+00	14	Веганский чизкейк из кешью на кокосовом молоке by test: овсяные хлопья, г 50	1	[{"added": {}}]	10	1
29	2021-11-22 17:41:11.878844+00	15	Веганский чизкейк из кешью на кокосовом молоке by test: финики, г 70	1	[{"added": {}}]	10	1
30	2021-11-22 17:41:29.50018+00	16	Веганский чизкейк из кешью на кокосовом молоке by test: кешью, г 170	1	[{"added": {}}]	10	1
31	2021-11-22 17:41:55.674697+00	17	Веганский чизкейк из кешью на кокосовом молоке by test: кокосовое молоко, г 300	1	[{"added": {}}]	10	1
32	2021-11-22 17:42:19.383485+00	18	Веганский чизкейк из кешью на кокосовом молоке by test: мед, г 80	1	[{"added": {}}]	10	1
33	2021-11-22 17:42:26.811252+00	19	Веганский чизкейк из кешью на кокосовом молоке by test: агар-агар, г 10	1	[{"added": {}}]	10	1
34	2021-11-22 17:42:53.583265+00	20	Пастуший пирог by hardkoro: фарш (баранина и говядина), г 400	1	[{"added": {}}]	10	1
35	2021-11-22 17:43:21.311547+00	21	Пастуший пирог by hardkoro: лук салатный, шт. 1	1	[{"added": {}}]	10	1
36	2021-11-22 17:43:36.286934+00	22	Пастуший пирог by hardkoro: морковь тертая, шт. 1	1	[{"added": {}}]	10	1
37	2021-11-22 17:43:53.484961+00	23	Пастуший пирог by hardkoro: горошек зеленый, г 50	1	[{"added": {}}]	10	1
38	2021-11-22 17:44:02.909029+00	24	Пастуший пирог by hardkoro: чеснок, г 20	1	[{"added": {}}]	10	1
39	2021-11-22 17:44:17.80842+00	25	Пастуший пирог by hardkoro: мука, г 50	1	[{"added": {}}]	10	1
40	2021-11-22 17:44:24.621071+00	26	Пастуший пирог by hardkoro: томатная паста, г 50	1	[{"added": {}}]	10	1
41	2021-11-22 17:44:41.209773+00	27	Пастуший пирог by hardkoro: бульон, г 150	1	[{"added": {}}]	10	1
42	2021-11-22 17:44:53.701338+00	28	Пастуший пирог by hardkoro: картофель, г 600	1	[{"added": {}}]	10	1
43	2021-11-22 17:45:00.928942+00	29	Пастуший пирог by hardkoro: молоко, г 100	1	[{"added": {}}]	10	1
44	2021-11-22 17:45:12.327443+00	30	Пастуший пирог by hardkoro: сливочное масло, г 50	1	[{"added": {}}]	10	1
45	2021-11-22 17:45:19.709406+00	31	Пастуший пирог by hardkoro: сыр, г 150	1	[{"added": {}}]	10	1
46	2021-11-22 17:45:29.845927+00	32	Пастуший пирог by hardkoro: оливковое масло, г 40	1	[{"added": {}}]	10	1
47	2021-11-22 17:45:43.303589+00	33	Пастуший пирог by hardkoro: розмарин сушеный, по вкусу 1	1	[{"added": {}}]	10	1
48	2021-11-22 17:45:52.390167+00	34	Пастуший пирог by hardkoro: петрушка, г 20	1	[{"added": {}}]	10	1
49	2021-11-22 17:46:04.715619+00	35	Пастуший пирог by hardkoro: соль, г 5	1	[{"added": {}}]	10	1
50	2021-11-22 17:46:18.70636+00	36	Пастуший пирог by hardkoro: перец черный молотый, г 5	1	[{"added": {}}]	10	1
51	2021-11-22 17:46:38.30292+00	37	Вишисуаз by hardkoro: лук-порей, горсть 500	1	[{"added": {}}]	10	1
52	2021-11-22 17:46:47.864545+00	38	Вишисуаз by hardkoro: картофель, г 500	1	[{"added": {}}]	10	1
53	2021-11-22 17:47:00.536924+00	39	Вишисуаз by hardkoro: лук репчатый, г 150	1	[{"added": {}}]	10	1
54	2021-11-22 17:47:10.40217+00	40	Вишисуаз by hardkoro: бульон, г 1000	1	[{"added": {}}]	10	1
55	2021-11-22 17:47:20.05369+00	41	Вишисуаз by hardkoro: сливочное масло, г 100	1	[{"added": {}}]	10	1
56	2021-11-22 17:47:36.366679+00	42	Вишисуаз by hardkoro: сливки 20%, г 200	1	[{"added": {}}]	10	1
57	2021-11-22 17:47:45.589993+00	43	Вишисуаз by hardkoro: соль, г 10	1	[{"added": {}}]	10	1
58	2021-11-22 17:47:56.308322+00	44	Вишисуаз by hardkoro: перец черный, ст. л. 1	1	[{"added": {}}]	10	1
59	2021-11-22 17:48:21.150655+00	45	Шакшука by hardkoro: яйца куриные, г 4	1	[{"added": {}}]	10	1
60	2021-11-22 17:48:29.836116+00	46	Шакшука by hardkoro: помидоры, г 200	1	[{"added": {}}]	10	1
61	2021-11-22 17:48:41.177636+00	47	Шакшука by hardkoro: перец болгарский, г 150	1	[{"added": {}}]	10	1
62	2021-11-22 17:48:50.780556+00	48	Шакшука by hardkoro: лук белый, по вкусу 1	1	[{"added": {}}]	10	1
63	2021-11-22 17:48:58.859331+00	49	Шакшука by hardkoro: томатная паста, г 25	1	[{"added": {}}]	10	1
64	2021-11-22 17:49:06.221353+00	50	Шакшука by hardkoro: чеснок, г 10	1	[{"added": {}}]	10	1
65	2021-11-22 17:49:16.195457+00	51	Шакшука by hardkoro: сахар, г 5	1	[{"added": {}}]	10	1
66	2021-11-22 17:49:25.930497+00	52	Шакшука by hardkoro: соль, г 5	1	[{"added": {}}]	10	1
67	2021-11-22 17:49:38.272442+00	53	Шакшука by hardkoro: перец черный молотый, г 5	1	[{"added": {}}]	10	1
68	2021-11-22 17:50:17.00039+00	1	admin	2	[{"changed": {"fields": ["First name", "Last name"]}}]	4	1
69	2021-11-22 17:50:31.909978+00	2	hardkoro	2	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	4	1
70	2021-11-22 17:51:00.266408+00	3	test	2	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	4	1
71	2021-11-22 17:55:02.455478+00	7	Киш с брынзой и шпинатом by hardkoro	1	[{"added": {}}]	12	1
72	2021-11-22 17:55:21.836031+00	54	Киш с брынзой и шпинатом by hardkoro: тесто слоеное, г 800	1	[{"added": {}}]	10	1
73	2021-11-22 17:55:30.821174+00	55	Киш с брынзой и шпинатом by hardkoro: шпинат, г 300	1	[{"added": {}}]	10	1
74	2021-11-22 17:55:40.388443+00	56	Киш с брынзой и шпинатом by hardkoro: яйца куриные, г 4	1	[{"added": {}}]	10	1
75	2021-11-22 17:55:54.773626+00	57	Киш с брынзой и шпинатом by hardkoro: сливки 33-35%, г 150	1	[{"added": {}}]	10	1
76	2021-11-22 17:56:02.230355+00	58	Киш с брынзой и шпинатом by hardkoro: лимонный сок, г 50	1	[{"added": {}}]	10	1
77	2021-11-22 17:56:11.893046+00	59	Киш с брынзой и шпинатом by hardkoro: зелень, г 50	1	[{"added": {}}]	10	1
78	2021-11-22 17:56:24.025722+00	60	Киш с брынзой и шпинатом by hardkoro: брынза сербская, г 250	1	[{"added": {}}]	10	1
79	2021-11-22 17:56:29.907739+00	61	Киш с брынзой и шпинатом by hardkoro: пармезан, г 100	1	[{"added": {}}]	10	1
80	2021-11-22 17:56:36.089133+00	62	Киш с брынзой и шпинатом by hardkoro: соль, г 5	1	[{"added": {}}]	10	1
81	2021-11-22 17:56:44.684577+00	63	Киш с брынзой и шпинатом by hardkoro: перец черный молотый, г 5	1	[{"added": {}}]	10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	authtoken	token
8	authtoken	tokenproxy
9	api	ingredient
10	api	ingredientinrecipe
11	api	tag
12	api	recipe
13	api	recipeincart
14	api	recipefavorite
15	users	follow
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-11-22 17:12:13.794983+00
2	auth	0001_initial	2021-11-22 17:12:13.910715+00
3	admin	0001_initial	2021-11-22 17:12:13.941701+00
4	admin	0002_logentry_remove_auto_add	2021-11-22 17:12:13.949552+00
5	admin	0003_logentry_add_action_flag_choices	2021-11-22 17:12:13.957196+00
6	api	0001_initial	2021-11-22 17:12:14.099676+00
7	api	0002_auto_20211118_1913	2021-11-22 17:12:14.175753+00
8	api	0003_auto_20211118_2024	2021-11-22 17:12:14.248134+00
9	contenttypes	0002_remove_content_type_name	2021-11-22 17:12:14.268988+00
10	auth	0002_alter_permission_name_max_length	2021-11-22 17:12:14.283667+00
11	auth	0003_alter_user_email_max_length	2021-11-22 17:12:14.320755+00
12	auth	0004_alter_user_username_opts	2021-11-22 17:12:14.331742+00
13	auth	0005_alter_user_last_login_null	2021-11-22 17:12:14.342676+00
14	auth	0006_require_contenttypes_0002	2021-11-22 17:12:14.34522+00
15	auth	0007_alter_validators_add_error_messages	2021-11-22 17:12:14.355723+00
16	auth	0008_alter_user_username_max_length	2021-11-22 17:12:14.370865+00
17	auth	0009_alter_user_last_name_max_length	2021-11-22 17:12:14.382271+00
18	auth	0010_alter_group_name_max_length	2021-11-22 17:12:14.394625+00
19	auth	0011_update_proxy_permissions	2021-11-22 17:12:14.406001+00
20	auth	0012_alter_user_first_name_max_length	2021-11-22 17:12:14.416057+00
21	authtoken	0001_initial	2021-11-22 17:12:14.439093+00
22	authtoken	0002_auto_20160226_1747	2021-11-22 17:12:14.474127+00
23	authtoken	0003_tokenproxy	2021-11-22 17:12:14.477751+00
24	sessions	0001_initial	2021-11-22 17:12:14.493472+00
25	users	0001_initial	2021-11-22 17:12:14.608599+00
26	users	0002_auto_20211118_2024	2021-11-22 17:12:14.634087+00
27	users	0003_delete_user	2021-11-22 17:12:14.640382+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
ujk8sunopifdvnjvivj4je9n8wxgm9n8	.eJxVjMsOwiAUBf-FtSG9hVJw6d5vINwHUjU0Ke3K-O_apAvdnpk5LxXTtpa4NVnixOqsQJ1-N0z0kLoDvqd6mzXNdV0m1LuiD9r0dWZ5Xg7376CkVr518C6QoPVWbM-cg_Ed4Ggd4jBm4wmTgZA924w8JBAiFOg7R5YNGFDvD_KDOGM:1mpCsc:Ch_gcWQHgeKxib2Sshh23CyZwujAWvbw_o-BSVf3SkU	2021-12-06 17:13:22.970683+00
\.


--
-- Data for Name: users_follow; Type: TABLE DATA; Schema: public; Owner: foodgram
--

COPY public.users_follow (id, author_id, user_id) FROM stdin;
2	3	1
3	2	1
\.


--
-- Name: api_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_ingredient_id_seq', 2190, true);


--
-- Name: api_ingredientinrecipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_ingredientinrecipe_id_seq', 63, true);


--
-- Name: api_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_recipe_id_seq', 7, true);


--
-- Name: api_recipe_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_recipe_tags_id_seq', 9, true);


--
-- Name: api_recipefavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_recipefavorite_id_seq', 3, true);


--
-- Name: api_recipeincart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_recipeincart_id_seq', 3, true);


--
-- Name: api_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.api_tag_id_seq', 6, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 60, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 3, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 81, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 15, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 27, true);


--
-- Name: users_follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodgram
--

SELECT pg_catalog.setval('public.users_follow_id_seq', 3, true);


--
-- Name: api_ingredient api_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredient
    ADD CONSTRAINT api_ingredient_pkey PRIMARY KEY (id);


--
-- Name: api_ingredientinrecipe api_ingredientinrecipe_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredientinrecipe
    ADD CONSTRAINT api_ingredientinrecipe_pkey PRIMARY KEY (id);


--
-- Name: api_recipe api_recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe
    ADD CONSTRAINT api_recipe_pkey PRIMARY KEY (id);


--
-- Name: api_recipe_tags api_recipe_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe_tags
    ADD CONSTRAINT api_recipe_tags_pkey PRIMARY KEY (id);


--
-- Name: api_recipe_tags api_recipe_tags_recipe_id_tag_id_4e3605b4_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe_tags
    ADD CONSTRAINT api_recipe_tags_recipe_id_tag_id_4e3605b4_uniq UNIQUE (recipe_id, tag_id);


--
-- Name: api_recipefavorite api_recipefavorite_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipefavorite
    ADD CONSTRAINT api_recipefavorite_pkey PRIMARY KEY (id);


--
-- Name: api_recipeincart api_recipeincart_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipeincart
    ADD CONSTRAINT api_recipeincart_pkey PRIMARY KEY (id);


--
-- Name: api_tag api_tag_color_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_color_key UNIQUE (color);


--
-- Name: api_tag api_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_name_key UNIQUE (name);


--
-- Name: api_tag api_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_pkey PRIMARY KEY (id);


--
-- Name: api_tag api_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_slug_key UNIQUE (slug);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_ingredientinrecipe unique Ingredient in Recipe; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredientinrecipe
    ADD CONSTRAINT "unique Ingredient in Recipe" UNIQUE (recipe_id, ingredient_id);


--
-- Name: api_recipeincart unique Recipe in cart; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipeincart
    ADD CONSTRAINT "unique Recipe in cart" UNIQUE (user_id, recipe_id);


--
-- Name: api_recipefavorite unique Recipe in favorites; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipefavorite
    ADD CONSTRAINT "unique Recipe in favorites" UNIQUE (user_id, recipe_id);


--
-- Name: users_follow unique User to Follow; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.users_follow
    ADD CONSTRAINT "unique User to Follow" UNIQUE (user_id, author_id);


--
-- Name: api_ingredient unique ingredient & measurement pair; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredient
    ADD CONSTRAINT "unique ingredient & measurement pair" UNIQUE (name, measurement_unit);


--
-- Name: users_follow users_follow_pkey; Type: CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.users_follow
    ADD CONSTRAINT users_follow_pkey PRIMARY KEY (id);


--
-- Name: api_ingredient_name_fd445561; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_ingredient_name_fd445561 ON public.api_ingredient USING btree (name);


--
-- Name: api_ingredient_name_fd445561_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_ingredient_name_fd445561_like ON public.api_ingredient USING btree (name varchar_pattern_ops);


--
-- Name: api_ingredientinrecipe_ingredient_id_fd0667c5; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_ingredientinrecipe_ingredient_id_fd0667c5 ON public.api_ingredientinrecipe USING btree (ingredient_id);


--
-- Name: api_ingredientinrecipe_recipe_id_4e0f91e1; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_ingredientinrecipe_recipe_id_4e0f91e1 ON public.api_ingredientinrecipe USING btree (recipe_id);


--
-- Name: api_recipe_author_id_423d4c07; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipe_author_id_423d4c07 ON public.api_recipe USING btree (author_id);


--
-- Name: api_recipe_cooking_time_8e83a7b1; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipe_cooking_time_8e83a7b1 ON public.api_recipe USING btree (cooking_time);


--
-- Name: api_recipe_tags_recipe_id_39cc25a8; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipe_tags_recipe_id_39cc25a8 ON public.api_recipe_tags USING btree (recipe_id);


--
-- Name: api_recipe_tags_tag_id_85673ca0; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipe_tags_tag_id_85673ca0 ON public.api_recipe_tags USING btree (tag_id);


--
-- Name: api_recipefavorite_recipe_id_e70a0747; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipefavorite_recipe_id_e70a0747 ON public.api_recipefavorite USING btree (recipe_id);


--
-- Name: api_recipefavorite_user_id_a9713677; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipefavorite_user_id_a9713677 ON public.api_recipefavorite USING btree (user_id);


--
-- Name: api_recipeincart_recipe_id_22c447fb; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipeincart_recipe_id_22c447fb ON public.api_recipeincart USING btree (recipe_id);


--
-- Name: api_recipeincart_user_id_5a1ba753; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_recipeincart_user_id_5a1ba753 ON public.api_recipeincart USING btree (user_id);


--
-- Name: api_tag_color_2a7628a5_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_tag_color_2a7628a5_like ON public.api_tag USING btree (color varchar_pattern_ops);


--
-- Name: api_tag_name_e0f7a95d_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_tag_name_e0f7a95d_like ON public.api_tag USING btree (name varchar_pattern_ops);


--
-- Name: api_tag_slug_dc7250ca_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX api_tag_slug_dc7250ca_like ON public.api_tag USING btree (slug varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: users_follow_author_id_c48003a4; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX users_follow_author_id_c48003a4 ON public.users_follow USING btree (author_id);


--
-- Name: users_follow_user_id_e66dc3cf; Type: INDEX; Schema: public; Owner: foodgram
--

CREATE INDEX users_follow_user_id_e66dc3cf ON public.users_follow USING btree (user_id);


--
-- Name: api_ingredientinrecipe api_ingredientinreci_ingredient_id_fd0667c5_fk_api_ingre; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredientinrecipe
    ADD CONSTRAINT api_ingredientinreci_ingredient_id_fd0667c5_fk_api_ingre FOREIGN KEY (ingredient_id) REFERENCES public.api_ingredient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_ingredientinrecipe api_ingredientinrecipe_recipe_id_4e0f91e1_fk_api_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_ingredientinrecipe
    ADD CONSTRAINT api_ingredientinrecipe_recipe_id_4e0f91e1_fk_api_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.api_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipe api_recipe_author_id_423d4c07_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe
    ADD CONSTRAINT api_recipe_author_id_423d4c07_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipe_tags api_recipe_tags_recipe_id_39cc25a8_fk_api_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe_tags
    ADD CONSTRAINT api_recipe_tags_recipe_id_39cc25a8_fk_api_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.api_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipe_tags api_recipe_tags_tag_id_85673ca0_fk_api_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipe_tags
    ADD CONSTRAINT api_recipe_tags_tag_id_85673ca0_fk_api_tag_id FOREIGN KEY (tag_id) REFERENCES public.api_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipefavorite api_recipefavorite_recipe_id_e70a0747_fk_api_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipefavorite
    ADD CONSTRAINT api_recipefavorite_recipe_id_e70a0747_fk_api_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.api_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipefavorite api_recipefavorite_user_id_a9713677_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipefavorite
    ADD CONSTRAINT api_recipefavorite_user_id_a9713677_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipeincart api_recipeincart_recipe_id_22c447fb_fk_api_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipeincart
    ADD CONSTRAINT api_recipeincart_recipe_id_22c447fb_fk_api_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.api_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_recipeincart api_recipeincart_user_id_5a1ba753_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.api_recipeincart
    ADD CONSTRAINT api_recipeincart_user_id_5a1ba753_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_follow users_follow_author_id_c48003a4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.users_follow
    ADD CONSTRAINT users_follow_author_id_c48003a4_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_follow users_follow_user_id_e66dc3cf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: foodgram
--

ALTER TABLE ONLY public.users_follow
    ADD CONSTRAINT users_follow_user_id_e66dc3cf_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Debian 12.4-1.pgdg100+1)
-- Dumped by pg_dump version 12.4 (Debian 12.4-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: foodgram
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO foodgram;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: foodgram
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

