--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.1

-- Started on 2024-05-15 13:38:58

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
-- TOC entry 209 (class 1259 OID 1237764)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    user_id integer NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 1237767)
-- Name: education_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_materials (
    id integer NOT NULL,
    created_at timestamp without time zone,
    teacher_id integer,
    file json
);


ALTER TABLE public.education_materials OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 1237772)
-- Name: education_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.education_materials_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 211
-- Name: education_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_materials_id_seq OWNED BY public.education_materials.id;


--
-- TOC entry 212 (class 1259 OID 1237773)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    quantorium_id integer,
    img json
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 1237778)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 213
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 214 (class 1259 OID 1237779)
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    date date NOT NULL,
    quantorium_id integer,
    quantum_id integer,
    teacher_id integer,
    group_id integer,
    time_begin time without time zone NOT NULL,
    time_end time without time zone NOT NULL
);


ALTER TABLE public.lessons OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 1237782)
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 215
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- TOC entry 216 (class 1259 OID 1237783)
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    created_at timestamp without time zone,
    description text,
    quantorium_id integer,
    img json
);


ALTER TABLE public.news OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 1237788)
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 217
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- TOC entry 218 (class 1259 OID 1237789)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    description text NOT NULL,
    user_id integer
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 1237794)
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 219
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- TOC entry 220 (class 1259 OID 1237795)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    created_at timestamp without time zone,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    materials json NOT NULL,
    quantum_id integer,
    student_id integer,
    img json
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 1237800)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 221
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 222 (class 1259 OID 1237801)
-- Name: quantoriums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quantoriums (
    id integer NOT NULL,
    address character varying(255) NOT NULL,
    created_at timestamp without time zone,
    img json
);


ALTER TABLE public.quantoriums OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 1237806)
-- Name: quantoriums_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quantoriums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quantoriums_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 223
-- Name: quantoriums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quantoriums_id_seq OWNED BY public.quantoriums.id;


--
-- TOC entry 224 (class 1259 OID 1237807)
-- Name: quantums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quantums (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    quantorium_id integer,
    img json
);


ALTER TABLE public.quantums OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 1237812)
-- Name: quantums_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quantums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quantums_id_seq OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 225
-- Name: quantums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quantums_id_seq OWNED BY public.quantums.id;


--
-- TOC entry 226 (class 1259 OID 1237813)
-- Name: reasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reasons (
    id integer NOT NULL,
    date_begin timestamp without time zone NOT NULL,
    name character varying(100) NOT NULL,
    quantorium_id integer,
    date_end timestamp without time zone NOT NULL
);


ALTER TABLE public.reasons OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 1237816)
-- Name: reasons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reasons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reasons_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 227
-- Name: reasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reasons_id_seq OWNED BY public.reasons.id;


--
-- TOC entry 228 (class 1259 OID 1237817)
-- Name: recoveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recoveries (
    code character varying(255) NOT NULL,
    user_id integer
);


ALTER TABLE public.recoveries OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 1237820)
-- Name: representatives; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.representatives (
    user_id integer NOT NULL,
    phone character varying(30) NOT NULL,
    patronymic character varying(255) NOT NULL,
    quantorium_id integer
);


ALTER TABLE public.representatives OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 1237823)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 1237826)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 231
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 232 (class 1259 OID 1237827)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    quantorium_id integer,
    img json
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 1237832)
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 233
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- TOC entry 234 (class 1259 OID 1237833)
-- Name: schedule_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_items (
    id integer NOT NULL,
    dateweek integer NOT NULL,
    quantorium_id integer,
    quantum_id integer,
    teacher_id integer,
    group_id integer,
    room_id integer,
    time_begin time without time zone NOT NULL,
    time_end time without time zone NOT NULL
);


ALTER TABLE public.schedule_items OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 1237836)
-- Name: schedule_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_items_id_seq OWNER TO postgres;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 235
-- Name: schedule_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_items_id_seq OWNED BY public.schedule_items.id;


--
-- TOC entry 236 (class 1259 OID 1237837)
-- Name: student_presences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_presences (
    id integer NOT NULL,
    is_here boolean NOT NULL,
    lesson_id integer,
    student_id integer
);


ALTER TABLE public.student_presences OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 1237840)
-- Name: student_presences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_presences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_presences_id_seq OWNER TO postgres;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 237
-- Name: student_presences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_presences_id_seq OWNED BY public.student_presences.id;


--
-- TOC entry 238 (class 1259 OID 1237841)
-- Name: student_project_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_project_links (
    student_id integer NOT NULL,
    project_id integer NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.student_project_links OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 1237844)
-- Name: student_quantum_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_quantum_links (
    student_id integer NOT NULL,
    quantum_id integer NOT NULL,
    is_free boolean NOT NULL
);


ALTER TABLE public.student_quantum_links OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 1237847)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    user_id integer NOT NULL,
    phone character varying(30) NOT NULL,
    patronymic character varying(255) NOT NULL,
    birthdate date NOT NULL,
    group_id integer,
    quantorium_id integer
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 1237850)
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    user_id integer NOT NULL,
    phone character varying(30) NOT NULL,
    patronymic character varying(255) NOT NULL,
    birthdate date NOT NULL,
    quantorium_id integer,
    quantum_id integer
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 1237853)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    firstname character varying(255) NOT NULL,
    lastname character varying(255) NOT NULL,
    email character varying(320) NOT NULL,
    hashed_password character varying(1024) NOT NULL,
    created_at timestamp without time zone,
    role_id integer,
    img json
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 1237858)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 243
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3257 (class 2604 OID 1237859)
-- Name: education_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_materials ALTER COLUMN id SET DEFAULT nextval('public.education_materials_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 1237860)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 1237861)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 1237862)
-- Name: news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 1237863)
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 1237864)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 1237865)
-- Name: quantoriums id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantoriums ALTER COLUMN id SET DEFAULT nextval('public.quantoriums_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 1237866)
-- Name: quantums id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantums ALTER COLUMN id SET DEFAULT nextval('public.quantums_id_seq'::regclass);


--
-- TOC entry 3265 (class 2604 OID 1237867)
-- Name: reasons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reasons ALTER COLUMN id SET DEFAULT nextval('public.reasons_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 1237868)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 1237869)
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 1237870)
-- Name: schedule_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items ALTER COLUMN id SET DEFAULT nextval('public.schedule_items_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 1237871)
-- Name: student_presences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_presences ALTER COLUMN id SET DEFAULT nextval('public.student_presences_id_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 1237872)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3489 (class 0 OID 1237764)
-- Dependencies: 209
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (user_id) FROM stdin;
1
\.


--
-- TOC entry 3490 (class 0 OID 1237767)
-- Dependencies: 210
-- Data for Name: education_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_materials (id, created_at, teacher_id, file) FROM stdin;
10	2024-05-08 17:43:44.741147	23	{"token": "5449c9e0b5e0b8d29820360dedfb92d0081182aa6df811d943db605636e4ecb2f9fbcd935c8055c0f024", "name": "ba6e5c84b87c0f71ed1998540.kdenlive", "size": 337753, "originalFilename": "d.kdenlive", "createdAt": "2024-05-08T14:43:44.352Z", "mimeType": "application/octet-stream", "deleteToken": "a6dc0931ca103435bc3a"}
11	2024-05-08 17:57:42.468559	23	{"token": "fc375a5230000289296bde76dc5f52492c37412a7c15d809ee4ac86cc91a658d654b2c442c5c7f30e36f", "name": "ba6e5c84b87c0f71ed1998559.docx", "size": 11697, "originalFilename": "\\u0438\\u0441\\u0442\\u043e\\u0440\\u0438\\u044f \\u0447\\u0438\\u043a-\\u0447\\u0438\\u0440\\u0438\\u043a.docx", "createdAt": "2024-05-08T14:57:42.063Z", "mimeType": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "deleteToken": "43ff02a6d597fd8eda69"}
\.


--
-- TOC entry 3492 (class 0 OID 1237773)
-- Dependencies: 212
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, created_at, quantorium_id, img) FROM stdin;
19	БТ-1	2024-05-10 12:19:47.070843	3	{"token": "0d578faa7e9deaef702cc079c189a73552bbd87508a7fed0cc427f43e7945c5ec0dc898da96e11aa8c39", "name": "02868aee42f6491174fa2a4b7.jpg", "size": 4726, "originalFilename": "\\u0411\\u0422-1.jpg", "createdAt": "2024-05-12T09:31:53.617Z", "mimeType": "image/jpeg", "deleteToken": "c1fee583084e8c91f390"}
38	РГ-1	2024-05-10 12:21:57.806246	3	{"token": "ec09656333aae6717905c7fbf8e278755cc7c1bcf24c370e4150d020c165e147bb717e9e6d2e90e268ca", "name": "02868aee42f6491174fa2a4ee.jpg", "size": 4250, "originalFilename": "\\u0420\\u0413-1.jpg", "createdAt": "2024-05-12T10:26:06.863Z", "mimeType": "image/jpeg", "deleteToken": "94e974d54c659b234609"}
2	ITИ-2	2024-05-07 11:41:36.46151	3	{"token": "2edd9e4fb95ce2345de77e1ef1322ecd95fcec3c2ad264d8aa8eb5e6d65359129db679bc8a4882bfb31f", "name": "02868aee42f6491174fa2a493.png", "size": 9764, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-12T09:06:31.151Z", "mimeType": "image/png", "deleteToken": "b988f829bfb109758d5b"}
65	ITП-3	2024-05-10 20:52:10.522796	3	{"token": "55655c5f29d71377664e3b763aff35da4ff2e8c3895df60c89cec3bb5826eb3abdb3b42df471c8f1e729", "name": "02868aee42f6491174fa2a496.jpg", "size": 4301, "originalFilename": "Untitled_logo_9_free-file.jpg", "createdAt": "2024-05-12T09:08:15.289Z", "mimeType": "image/jpeg", "deleteToken": "77c45d42f55eea59711e"}
7	VE-1	2024-05-10 12:18:41.551174	3	{"token": "1abc135df13625b2467d54450d6a26274c1befa12bebf9a83509a87f49e76e647e93457a0b72cac5eb55", "name": "02868aee42f6491174fa2a4a3.jpg", "size": 3664, "originalFilename": "VE-1.jpg", "createdAt": "2024-05-12T09:17:31.559Z", "mimeType": "image/jpeg", "deleteToken": "9ebfd6b403e8578eb311"}
63	ITП-1	2024-05-10 20:52:01.106674	3	{"token": "f39f60634707d4f3b51736e2cb5f5459360d03e23184b2963674bd6e8a121915004353bdd8369d2809d3", "name": "02868aee42f6491174fa2a494.png", "size": 5015, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-12T09:06:56.663Z", "mimeType": "image/png", "deleteToken": "17fd527ad86b4c657661"}
6	ITТ-2	2024-05-10 12:18:34.344788	3	{"token": "239d898a0623b648c6666146e79fb379cab1f691cb7541ebb2725c1b6b10ed711d8a4f8291bee1851c9a", "name": "02868aee42f6491174fa2a49d.jpg", "size": 4104, "originalFilename": "IT\\u04222.jpg", "createdAt": "2024-05-12T09:13:46.278Z", "mimeType": "image/jpeg", "deleteToken": "23118b5d3cb45e5d7f34"}
64	ITП-2	2024-05-10 20:52:08.387516	3	{"token": "2d276d69ce3a7cb716f2dd90bbde2684bba2ca99213fde4b911702af34005c3f4e51a27ee1dd64d62af9", "name": "02868aee42f6491174fa2a495.jpg", "size": 3931, "originalFilename": "Untitled_logo_9_free-file.jpg", "createdAt": "2024-05-12T09:07:33.502Z", "mimeType": "image/jpeg", "deleteToken": "cac97f719b7cb17c5f3e"}
66	ITП-4	2024-05-10 20:52:12.749124	3	{"token": "8c709cca663a856ad5d4453e26e0ea3f649a091e9b35c20cc66cfb71d6b7099f16c0b5dccb9036668ee9", "name": "02868aee42f6491174fa2a497.jpg", "size": 3930, "originalFilename": "Untitled_logo_9_free-file (1).jpg", "createdAt": "2024-05-12T09:08:40.150Z", "mimeType": "image/jpeg", "deleteToken": "e4e8573c202b2a22f8bb"}
5	ITТ-1	2024-05-10 12:18:30.324107	3	{"token": "222ad78be5b651d65faee22ba388b16461c56017e587378a7e577e46a3b1f5ab408e7918ab47a8927abb", "name": "02868aee42f6491174fa2a499.jpg", "size": 3934, "originalFilename": "Untitled_logo_9_free-file (3).jpg", "createdAt": "2024-05-12T09:09:46.962Z", "mimeType": "image/jpeg", "deleteToken": "f8e0ba1ffce868b46346"}
67	КITП	2024-05-10 20:52:21.503508	3	{"token": "c762f49260a077b314900f6d7003a7f554443e665333e613da59395442e871aa761f5a05e2b3f8c74b8a", "name": "02868aee42f6491174fa2a49f.jpg", "size": 4159, "originalFilename": "\\u041aIT\\u041f.jpg", "createdAt": "2024-05-12T09:14:45.033Z", "mimeType": "image/jpeg", "deleteToken": "0a236612a122b4595f4b"}
3	КITИ	2024-05-07 11:41:46.570554	3	{"token": "94ba03f0a2fad79fcd2193dc8eeb23835dc72e04d9e205482c1a7ca6a160bd08206d9daf5ba028fa6c87", "name": "02868aee42f6491174fa2a49e.jpg", "size": 4854, "originalFilename": "\\u041aIT\\u0418.jpg", "createdAt": "2024-05-12T09:14:05.759Z", "mimeType": "image/jpeg", "deleteToken": "0c8d96bd43f6c2b85513"}
15	БД-1 	2024-05-10 12:19:25.376065	3	{"token": "ab91f20aa35f5728486580d2d739ec27f656da7febf2c08f28c40e44b37b5c3d1a69de25d99dcb1cc70c", "name": "02868aee42f6491174fa2a4b3.jpg", "size": 5068, "originalFilename": "\\u0411\\u0414-1.jpg", "createdAt": "2024-05-12T09:29:03.030Z", "mimeType": "image/jpeg", "deleteToken": "9d3e62f9b2f3b97e1a04"}
9	VE-2	2024-05-10 12:18:50.726187	3	{"token": "e15705b34faf1617cb03423cc18a41709f4dd9e5f573c0ace494f79ed50edf1b3ff6339b8d0576e72aee", "name": "02868aee42f6491174fa2a4a4.jpg", "size": 3773, "originalFilename": "VE-2.jpg", "createdAt": "2024-05-12T09:19:16.251Z", "mimeType": "image/jpeg", "deleteToken": "6d1892c3a08a63625a93"}
57	КММ	2024-05-10 12:23:52.329524	3	{"token": "cc543606b3b6a23e5469378416983a65a2dc2277cc84ae41b120a8db484fa160d2f7802274503cde0fdb", "name": "02868aee42f6491174fa2a4bb.jpg", "size": 5756, "originalFilename": "\\u041a\\u041c\\u041c.jpg", "createdAt": "2024-05-12T09:37:25.127Z", "mimeType": "image/jpeg", "deleteToken": "2417bd6deeb43094ef77"}
39	РП-2	2024-05-10 12:22:02.462564	3	{"token": "30ae7e1f6c38794145694ef9755c5134d6f56360b454c4d769731e850103bf85e6cf152b0afb3833a421", "name": "02868aee42f6491174fa2a4f3.jpg", "size": 4570, "originalFilename": "\\u0420\\u041f-2.jpg", "createdAt": "2024-05-12T10:26:44.265Z", "mimeType": "image/jpeg", "deleteToken": "10def9d11d8bdb748ef8"}
52	АШ-2	2024-05-10 12:23:30.656144	3	{"token": "b6ca5323795dda4deb2e89c056cf0761e68ee9df495325a54cbeef466ea8238c11b320a69259fec8d8b5", "name": "02868aee42f6491174fa2a4e2.jpg", "size": 4660, "originalFilename": "\\u0410\\u0428-2.jpg", "createdAt": "2024-05-12T10:16:47.941Z", "mimeType": "image/jpeg", "deleteToken": "55e2d90e3579b7f84690"}
44	НТТ-2	2024-05-10 12:22:48.94268	3	{"token": "0058cbe8f48f75ad2ae3bf511db06c0630ff9ac37bc95ee2007be0e5786db74b4093d617dbf7179ce8ec", "name": "b286e47f5d6867b5badfa9c04.jpg", "size": 2974, "originalFilename": "\\u041d\\u0422\\u0422-2.jpg", "createdAt": "2024-05-12T10:53:13.184Z", "mimeType": "image/jpeg", "deleteToken": "ccedfc108e4de679221d"}
31	НУ-1 б	2024-05-10 12:21:12.662241	3	{"token": "12e77f015019e43b02e3ce2f603da738514815d0bca1101c7b6406e0bd169f01481fa073d68a31dc43ba", "name": "02868aee42f6491174fa2a4cc.jpg", "size": 4867, "originalFilename": "\\u041d\\u0423-1 \\u0431.jpg", "createdAt": "2024-05-12T09:44:42.731Z", "mimeType": "image/jpeg", "deleteToken": "a33a38bb65a1530c1e08"}
37	РГ-2	2024-05-10 12:21:53.984071	3	{"token": "60fc9e2bc7efdbd0c37a81340871c178c3817e8f2acf37b70177271e0ca51bcc954101e46a7db71daa69", "name": "02868aee42f6491174fa2a4ef.jpg", "size": 4269, "originalFilename": "\\u0420\\u0413-2.jpg", "createdAt": "2024-05-12T10:26:13.177Z", "mimeType": "image/jpeg", "deleteToken": "50872ffd237176d990cc"}
41	РИ-1	2024-05-10 12:22:09.868127	3	{"token": "344d9c2d239cc68ae8b65831d9353047d18822741b60a386f9cc6313ed52fd954357aab4c8f0a2af56de", "name": "02868aee42f6491174fa2a4f0.jpg", "size": 4486, "originalFilename": "\\u0420\\u0418-1.jpg", "createdAt": "2024-05-12T10:26:20.067Z", "mimeType": "image/jpeg", "deleteToken": "2a71880d08067038ae79"}
71	KVВ	2024-05-11 21:21:13.170946	3	{"token": "8fa030c31f06d9ffaba3a0bebc125ddc58ad8e1e8a9e01066fea695ae0f35fa8e9b9dd355f0da1c936ed", "name": "02868aee42f6491174fa2a4a1.jpg", "size": 4390, "originalFilename": "KV\\u0412.jpg", "createdAt": "2024-05-12T09:16:25.877Z", "mimeType": "image/jpeg", "deleteToken": "25878a4523416e8b5624"}
8	VE-3	2024-05-10 12:18:45.111788	3	{"token": "418f1995fd7d48ce37b15dd9f3742e5c938cc348ac34d8bf5ae6b3919096a2419b42e48ad5362504d62f", "name": "02868aee42f6491174fa2a4a8.jpg", "size": 3923, "originalFilename": "VE-3.jpg", "createdAt": "2024-05-12T09:19:34.841Z", "mimeType": "image/jpeg", "deleteToken": "3c213b4687b9f109eff3"}
10	VE-4	2024-05-10 12:18:57.303103	3	{"token": "cdbd082975214e5f40c66a6ee55ecd51639a499f761d862315ee911df9ee22d96b9393f7e50888a2267e", "name": "02868aee42f6491174fa2a4a6.jpg", "size": 3753, "originalFilename": "VE-4.jpg", "createdAt": "2024-05-12T09:19:22.738Z", "mimeType": "image/jpeg", "deleteToken": "6442a2a271b318c4efb7"}
70	KVК	2024-05-11 21:20:34.410304	3	{"token": "ec2afa2bdcadf5bddc1612f7abdc67a72da4b670ab4d508202697f4876f5fb0deabbc8a28381ebc55941", "name": "02868aee42f6491174fa2a4a2.jpg", "size": 4555, "originalFilename": "KV\\u041a.jpg", "createdAt": "2024-05-12T09:17:00.629Z", "mimeType": "image/jpeg", "deleteToken": "ae6909936dd72da06f3b"}
72	VВ-3	2024-05-11 21:38:20.547598	3	{"token": "03138e7cbd0d6dfc6612539be9fa56a3f2e9bc0c350680372d374eaf6540fc46cfe59373ef9d85c222ff", "name": "02868aee42f6491174fa2a4ac.jpg", "size": 3907, "originalFilename": "V\\u0412-3.jpg", "createdAt": "2024-05-12T09:22:01.295Z", "mimeType": "image/jpeg", "deleteToken": "67110c1e07a8e5039456"}
11	VК-1	2024-05-10 12:19:01.83454	3	{"token": "3464f0980efa8f1d866fe35e2f533ab738fdccb6c6f4703bb8fa897904babcf5b9ed7c4e3de583961309", "name": "02868aee42f6491174fa2a4ad.jpg", "size": 3945, "originalFilename": "V\\u041a-1.jpg", "createdAt": "2024-05-12T09:22:06.617Z", "mimeType": "image/jpeg", "deleteToken": "eef891fc7b5c0e6b6fa1"}
17	БД-3	2024-05-10 12:19:34.280617	3	{"token": "98e1887748fd9aed2afee87e992dbb63d79e750c1ca4825a9dbc1c40e7b8205b1d0d8ec1af012d2d19ce", "name": "2f1a9cf2ee226cc937df21f31.png", "size": 15238, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-11T19:58:43.310Z", "mimeType": "image/png", "deleteToken": "9ec2fe52eb043d0164cd"}
16	БД-2	2024-05-10 12:19:28.563443	3	{"token": "e37c5b35884b2e11adb03897188c6aaba1e89b973a5ff197bb1104f7ea377beaa648ec46dbc1e9564028", "name": "02868aee42f6491174fa2a4b4.jpg", "size": 5275, "originalFilename": "\\u0411\\u0414-2.jpg", "createdAt": "2024-05-12T09:29:08.274Z", "mimeType": "image/jpeg", "deleteToken": "9f3bffdb6840e22316e1"}
68	VE-5	2024-05-11 21:13:55.175161	3	{"token": "62c08746a8675ae99789310e48e64ee2ec764f5fdd0de2a8881c971bb57af2797907b847ff20826a924d", "name": "02868aee42f6491174fa2a4a7.jpg", "size": 3764, "originalFilename": "VE-5.jpg", "createdAt": "2024-05-12T09:19:28.883Z", "mimeType": "image/jpeg", "deleteToken": "06c32baf6b61f397dfd3"}
13	VВ-1	2024-05-10 12:19:09.601554	3	{"token": "81d94391c87034018b383a41fa0b6ca7c5c38644bbe426a1a353a49f73a2ee251c89e9c3249e8696814b", "name": "02868aee42f6491174fa2a4aa.jpg", "size": 3743, "originalFilename": "V\\u0412-1.jpg", "createdAt": "2024-05-12T09:21:49.527Z", "mimeType": "image/jpeg", "deleteToken": "9cbd12f916904bb39216"}
14	VВ-2	2024-05-10 12:19:13.608096	3	{"token": "cbeba901872c22d9c331d0f4e239de2ae0a0a6e56539549c22c27e18a37f0a37dcd742bdf8b5a37a3ce1", "name": "02868aee42f6491174fa2a4ab.jpg", "size": 3963, "originalFilename": "V\\u0412-2.jpg", "createdAt": "2024-05-12T09:21:56.225Z", "mimeType": "image/jpeg", "deleteToken": "216a679e3c14417cfdb7"}
12	VК-2	2024-05-10 12:19:05.368901	3	{"token": "1776f7d4677a4352955b6dbcdfe9ff23cf6e2487c7fe2d6895f7a056e31435cff3c963fe641066b1bd6e", "name": "02868aee42f6491174fa2a4ae.jpg", "size": 4052, "originalFilename": "V\\u041a-2.jpg", "createdAt": "2024-05-12T09:22:13.918Z", "mimeType": "image/jpeg", "deleteToken": "31cacedc67f830e1f818"}
21	БК-1	2024-05-10 12:19:55.858932	3	{"token": "1de88e370705555b9891b3aabaed7b7b82e4489f5f5ff0e170616a8d992e5982618853d4efef6d10d3fc", "name": "02868aee42f6491174fa2a4b0.jpg", "size": 5173, "originalFilename": "\\u0411\\u041a-1.jpg", "createdAt": "2024-05-12T09:27:34.229Z", "mimeType": "image/jpeg", "deleteToken": "8801080dc8e88da4aa9e"}
22	БК-2	2024-05-10 12:20:00.395957	3	{"token": "4577385d40cb48a6fd9fee2a1daa89fc7985134886907871580e7f4fdeee4f46b7ce427416202b95e9bd", "name": "02868aee42f6491174fa2a4b1.jpg", "size": 5387, "originalFilename": "\\u0411\\u041a-2.jpg", "createdAt": "2024-05-12T09:27:39.286Z", "mimeType": "image/jpeg", "deleteToken": "85c65ce9a732a9f71b4b"}
74	БК-3	2024-05-11 23:00:51.76721	3	{"token": "5561fdc6237a298fdbaa3adcd5cc89918b0fafeaa19fdf4191853bedc3c4d451bd3af132c9cbd85baf82", "name": "02868aee42f6491174fa2a4b2.jpg", "size": 5423, "originalFilename": "\\u0411\\u041a-3.jpg", "createdAt": "2024-05-12T09:27:43.981Z", "mimeType": "image/jpeg", "deleteToken": "4114320d997aaedbef20"}
18	КБД	2024-05-10 12:19:37.525971	3	{"token": "0ff1d4a590b34c1ad1b762bcb445def5095e48294e9d0cb99de58c7b6fa34873b3de686a745f699bd5a1", "name": "02868aee42f6491174fa2a4b5.jpg", "size": 5784, "originalFilename": "\\u041a\\u0411\\u0414.jpg", "createdAt": "2024-05-12T09:30:34.727Z", "mimeType": "image/jpeg", "deleteToken": "2a8a8cc4f675773afb92"}
23	КБК	2024-05-10 12:20:04.931307	3	{"token": "3dff0c85da8563e182fcd92d97f9f018c476467df84701df46480e50617b56063b86783446da512fca8d", "name": "02868aee42f6491174fa2a4b6.jpg", "size": 6101, "originalFilename": "\\u041a\\u0411\\u041a.jpg", "createdAt": "2024-05-12T09:30:39.699Z", "mimeType": "image/jpeg", "deleteToken": "4021dda3b8ede304174e"}
20	БТ-2	2024-05-10 12:19:51.36979	3	{"token": "cca68af73e0bdc5cb6bba94586ad27303cff2dd1becbba5d87e91735819de02dd88012da88d290644a9d", "name": "02868aee42f6491174fa2a4b8.jpg", "size": 5108, "originalFilename": "\\u0411\\u0422-2.jpg", "createdAt": "2024-05-12T09:31:58.767Z", "mimeType": "image/jpeg", "deleteToken": "519490b8f456ed0c9346"}
24	МБ-1 б	2024-05-10 12:20:40.612526	3	{"token": "d5d4a6637f08a9850107fa8d93ea0a66e0013b301dc152771ce91787290e79bd04d69c63ff37e488a25e", "name": "02868aee42f6491174fa2a4bc.jpg", "size": 4793, "originalFilename": "\\u041c\\u0411-1 \\u0431.jpg", "createdAt": "2024-05-12T09:37:35.282Z", "mimeType": "image/jpeg", "deleteToken": "006261eb73876e7af6ca"}
60	МР-1	2024-05-10 12:24:05.792993	3	{"token": "c9518031aa9c73369b14e865cfd6cb55cc94c1931b6ddbb5a05b5aea205553816b620e12d83ab479b804", "name": "2f1a9cf2ee226cc937df21f89.png", "size": 16205, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-11T22:32:12.695Z", "mimeType": "image/png", "deleteToken": "ba7e508d6a8821a10603"}
27	ММ-2 б	2024-05-10 12:20:50.882836	3	{"token": "bf6c2bc6d22121557c96c206497d1a4e9eeb50fd4bddfed8b397c9751a23a849f9dba0ad0f8f7707ab13", "name": "02868aee42f6491174fa2a4be.jpg", "size": 4793, "originalFilename": "\\u041c\\u041c-2 \\u0431.jpg", "createdAt": "2024-05-12T09:37:53.931Z", "mimeType": "image/jpeg", "deleteToken": "8117c31bc5a4b1829d08"}
55	МС-2 у	2024-05-10 12:23:43.671729	3	{"token": "705553abe389cdefc96fc6a52fbaf392158a832ea89b0ce41fb3d86ac50e449ca55abb6dafe60f3b6928", "name": "02868aee42f6491174fa2a4c0.jpg", "size": 4691, "originalFilename": "\\u041c\\u0421-2 \\u0443.jpg", "createdAt": "2024-05-12T09:39:26.315Z", "mimeType": "image/jpeg", "deleteToken": "df6a765bd46e5693c1ca"}
32	НУ-2 б	2024-05-10 12:21:16.395964	3	{"token": "ce4f2eb985402e34532ecbad442615751fd131d98ee2149dcb2d088a4acafe2a9926f4f0764252376ac9", "name": "02868aee42f6491174fa2a4cb.jpg", "size": 5087, "originalFilename": "\\u041d\\u0423-2 \\u0431.jpg", "createdAt": "2024-05-12T09:44:35.500Z", "mimeType": "image/jpeg", "deleteToken": "76e4c027ed8e884317d3"}
81	ММ-4	2024-05-12 01:33:17.21725	3	{"token": "f4a93158b5f506077c11525e42b2279e6c4da437c9d27e9cb55947e47be852a4dfd2638fa3cf82a1dd2b", "name": "02868aee42f6491174fa2a4ea.jpg", "size": 4396, "originalFilename": "\\u041c\\u041c-4.jpg", "createdAt": "2024-05-12T10:20:05.502Z", "mimeType": "image/jpeg", "deleteToken": "5f962704d56b4ddf20f7"}
59	КМР	2024-05-10 12:24:01.003068	3	{"token": "ed9a5682cc38f39cc39b554bb6866fcb9db829684d17983c901b4d6f97815b70d21ed4bb050e9ec4f32e", "name": "2f1a9cf2ee226cc937df21f88.png", "size": 21394, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-11T22:31:39.700Z", "mimeType": "image/png", "deleteToken": "a31ea2ae61c55503a1e1"}
56	МС-1 с	2024-05-10 12:23:47.504828	3	{"token": "013935f2ac8a31fef473f15193dee95d7f72ee8293a1555f1ff5a39e8b0b0f37bb535b55d2ac7f36157d", "name": "02868aee42f6491174fa2a4bf.jpg", "size": 4422, "originalFilename": "\\u041c\\u0421-1 \\u0441.jpg", "createdAt": "2024-05-12T09:39:21.045Z", "mimeType": "image/jpeg", "deleteToken": "0d30857701087037a39a"}
30	КНТ	2024-05-10 12:21:07.524477	3	{"token": "05f6000687e3425efbdd6d8b7b2102373860d12e219f9274b1233c4bb3d7c50a79d0b74eb6a9469b0e38", "name": "02868aee42f6491174fa2a4c4.jpg", "size": 4853, "originalFilename": "\\u041a\\u041d\\u0422.jpg", "createdAt": "2024-05-12T09:42:36.645Z", "mimeType": "image/jpeg", "deleteToken": "dcbabc01fceefaf5ff67"}
62	КЧ-2	2024-05-10 12:24:19.889661	3	{"token": "69ef1391f0f0eb78400e2c5b165bfd85e35baf4b5dc44e77bf85c7f76b3d01f3d88986991835421e6ca0", "name": "02868aee42f6491174fa2a4d5.jpg", "size": 4388, "originalFilename": "\\u041a\\u0427-2.jpg", "createdAt": "2024-05-12T09:49:06.310Z", "mimeType": "image/jpeg", "deleteToken": "edcf90f939f8aa791e72"}
80	ММ-3	2024-05-12 01:33:12.048823	3	{"token": "35fa00d4da4157fcc7e4caaf57c7d1c8b4716ca4b1b5dd69d34415f3f47ac75848e01fb9746120bba5eb", "name": "02868aee42f6491174fa2a4e9.jpg", "size": 4642, "originalFilename": "\\u041c\\u041c-3.jpg", "createdAt": "2024-05-12T10:20:01.746Z", "mimeType": "image/jpeg", "deleteToken": "8c0851cb960f45fc83ad"}
58	МР-2	2024-05-10 12:23:57.495749	3	{"token": "e2361db34a358aa9a32ba49429c9cfda72ca1e74b7d768a767062fef9e26631d0628b5e5d2822a09e7f5", "name": "2f1a9cf2ee226cc937df21f8a.png", "size": 18971, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-11T22:32:31.844Z", "mimeType": "image/png", "deleteToken": "aa829a4afa20dcb2efa0"}
75	SЛ-2	2024-05-11 23:46:07.270072	3	{"token": "a5c3c261636715b393536904384a803443fb6bceaf6a458226637af25c2fd8120eb5423c3fcbfb809fee", "name": "02868aee42f6491174fa2a4ba.jpg", "size": 5092, "originalFilename": "S\\u041b-2.jpg", "createdAt": "2024-05-12T09:34:26.695Z", "mimeType": "image/jpeg", "deleteToken": "f56965eed1d26773396c"}
25	ММ-1 с	2024-05-10 12:20:43.834822	3	{"token": "caa8b67e66c165f91fc52f891e6f57c43883309be7ef1c6f66b7236167c6933161f2126fb20c5e877c2f", "name": "02868aee42f6491174fa2a4bd.jpg", "size": 4500, "originalFilename": "\\u041c\\u041c-1 \\u0441.jpg", "createdAt": "2024-05-12T09:37:46.364Z", "mimeType": "image/jpeg", "deleteToken": "1e4d6525b2b74a7373b8"}
77	КНУ	2024-05-12 00:18:46.470438	3	{"token": "d1fd250f7f028c98debb683a7e9ff910a21aff39fddf6d5961166b3845f52c49eaacddbe46675fe0a32d", "name": "02868aee42f6491174fa2a4c6.jpg", "size": 5555, "originalFilename": "\\u041a\\u041d\\u0423.jpg", "createdAt": "2024-05-12T09:42:43.593Z", "mimeType": "image/jpeg", "deleteToken": "91a1ec63d3b268f5fb80"}
33	НЧ-1 с2	2024-05-10 12:21:22.915257	3	{"token": "1ca7a4cd640c6ffca0d407d4975c2fd1be892fa06c66c419c65d0736f8c1f6f7601e822ee056d9b49833", "name": "02868aee42f6491174fa2a4c8.jpg", "size": 4572, "originalFilename": "\\u041d\\u0427-1 \\u04412.jpg", "createdAt": "2024-05-12T09:43:10.971Z", "mimeType": "image/jpeg", "deleteToken": "a430ba432e4b80957a20"}
28	НТ-1 с	2024-05-10 12:20:59.974064	3	{"token": "dd0c93f720e98ad26939fd2a77a634392f5bdebeb0c7ed67097a366538b300a29e2c22894b5562170d34", "name": "02868aee42f6491174fa2a4cf.jpg", "size": 4041, "originalFilename": "\\u041d\\u0422-1 \\u0441.jpg", "createdAt": "2024-05-12T09:45:47.087Z", "mimeType": "image/jpeg", "deleteToken": "d22e5f7b4d898dcd860f"}
29	НТ-2 у	2024-05-10 12:21:03.460966	3	{"token": "4e474e8d62f4f3a2f795173c3abf6bfdbf70f807cad9eaea295368f4b963bc4f40859d8c576f0c032d10", "name": "02868aee42f6491174fa2a4d0.jpg", "size": 4495, "originalFilename": "\\u041d\\u0422-2 \\u0443.jpg", "createdAt": "2024-05-12T09:45:52.335Z", "mimeType": "image/jpeg", "deleteToken": "62c1669569d33ee64149"}
76	КНЧ	2024-05-12 00:16:02.596148	3	{"token": "84218e557d88542783fe7884fc24646be6b669015a1b89cdf6567f59334de7956231779cf865bad4b3b5", "name": "02868aee42f6491174fa2a4d1.jpg", "size": 5101, "originalFilename": "\\u041a\\u041d\\u0427.jpg", "createdAt": "2024-05-12T09:47:03.775Z", "mimeType": "image/jpeg", "deleteToken": "aebb4f82c3878131d2cc"}
61	КЧ-1	2024-05-10 12:24:15.474757	3	{"token": "9c4eeb6b18f1dc1b64f38d2fbee9aec7e4639da4a13c135df0bc5d0ac15dbbf4ea01a1b1f62481708e21", "name": "02868aee42f6491174fa2a4d4.jpg", "size": 4127, "originalFilename": "\\u041a\\u0427-1.jpg", "createdAt": "2024-05-12T09:48:51.075Z", "mimeType": "image/jpeg", "deleteToken": "dd2b4df4b3936e870d10"}
84	КРИ	2024-05-12 11:56:07.235358	3	{"token": "67d0d46303edfa10be0cab92d399f8ee8a19cfb6a0a82175aefd2971edd20dcd9330aab59416bf60c911", "name": "02868aee42f6491174fa2a4f5.jpg", "size": 5231, "originalFilename": "\\u041a\\u0420\\u0418.jpg", "createdAt": "2024-05-12T10:28:40.786Z", "mimeType": "image/jpeg", "deleteToken": "2da4bbde765e7a5521d4"}
85	КРП	2024-05-12 11:56:30.846113	3	{"token": "27c426ba4928bf50564e2b0ffe8055051fd7d7ad9b20c15d227127546e10f757ba9a883ada18b7b234dc", "name": "02868aee42f6491174fa2a4f6.jpg", "size": 5186, "originalFilename": "\\u041a\\u0420\\u041f.jpg", "createdAt": "2024-05-12T10:28:47.356Z", "mimeType": "image/jpeg", "deleteToken": "6f9cf7ed56b85ed19c9a"}
54	АШ-4	2024-05-10 12:23:38.704677	3	{"token": "e6b3ec47beaeed31f769643c7f681b53c0c3a9f87d6bf79147e08f6cb16cc84b6af3d9ea33c5bd6b1675", "name": "02868aee42f6491174fa2a4e4.jpg", "size": 4382, "originalFilename": "\\u0410\\u0428-4.jpg", "createdAt": "2024-05-12T10:16:57.250Z", "mimeType": "image/jpeg", "deleteToken": "c52d5139aea45da9ff76"}
82	КРБ	2024-05-12 11:54:41.693566	3	{"token": "7fd32b5fc224ddd04121fae83ee0784bfdb21f26bb69c7c7395c3d22092fd85cee6c68d9b35c6df70e2a", "name": "02868aee42f6491174fa2a4f7.jpg", "size": 5555, "originalFilename": "\\u041a\\u0420\\u0411.jpg", "createdAt": "2024-05-12T10:29:27.028Z", "mimeType": "image/jpeg", "deleteToken": "e9a0d57ac9228b29b601"}
46	НТКФШ	2024-05-10 12:22:57.887405	3	{"token": "95c63411f75cf95a5ba62207b319be9da94551ebf76f3348b9733737b7576a7ac687f5166656cebacec4", "name": "b286e47f5d6867b5badfa9c02.jpg", "size": 3400, "originalFilename": "\\u041d\\u0422\\u041a\\u0424\\u0428.jpg", "createdAt": "2024-05-12T10:53:05.038Z", "mimeType": "image/jpeg", "deleteToken": "665ab25c632a62917409"}
1	ITИ-1	2024-04-24 14:20:05.89898	3	{"token": "2a660753eb93a825602989578a6e788c29b7fecb4770a9658e3063953c0c3034e7ce52ed98bbcc60cbec", "name": "02868aee42f6491174fa2a492.png", "size": 8002, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-12T09:06:05.809Z", "mimeType": "image/png", "deleteToken": "160b5f7c1f7b0c4b16b2"}
69	KVE	2024-05-11 21:14:05.40167	3	{"token": "1ec15a1a02b777ca6650fe32de3ca28a6b7c8fc0b83e1ffd3e39645f9a9cf2c66be62783e0dbbd7a93df", "name": "02868aee42f6491174fa2a4a0.jpg", "size": 4294, "originalFilename": "KVE.jpg", "createdAt": "2024-05-12T09:16:20.579Z", "mimeType": "image/jpeg", "deleteToken": "167deb2abb112e1a39ec"}
26	SЛ-1	2024-05-10 12:20:47.276459	3	{"token": "e663fe9fb431d1fb0f336189e2221cb6e3265bfb3a3b279847bfb006e1dc11212342eeb7b8874d83cf7c", "name": "02868aee42f6491174fa2a4b9.jpg", "size": 4897, "originalFilename": "S\\u041b-1.jpg", "createdAt": "2024-05-12T09:34:22.000Z", "mimeType": "image/jpeg", "deleteToken": "f390fe70d273ed030ca8"}
34	НЧ-2 б2	2024-05-10 12:21:33.520021	3	{"token": "e0295c0a5441ad00ee6d9f82bbdf0e9e769805da30bce85bf237eddaeec42d4a1e70e786e7c62ca1f234", "name": "02868aee42f6491174fa2a4cd.jpg", "size": 5028, "originalFilename": "\\u041d\\u0427-2 \\u04312.jpg", "createdAt": "2024-05-12T09:44:48.336Z", "mimeType": "image/jpeg", "deleteToken": "a3c51dc90ecee0080140"}
78	ММ-1	2024-05-12 01:33:03.967159	3	{"token": "d29d74e6347b51843dce24e8e958d8c78beb9fd896f795eb698f4c3ea24b116d9e73dcfa231e7dea528c", "name": "02868aee42f6491174fa2a4e7.jpg", "size": 4465, "originalFilename": "\\u041c\\u041c-1.jpg", "createdAt": "2024-05-12T10:19:53.461Z", "mimeType": "image/jpeg", "deleteToken": "fe539c93b8995196472e"}
51	АШ-1	2024-05-10 12:23:19.12229	3	{"token": "51aa4f49bb166e886c59d22393a2f3c9bd46f862e8a3fa87b7714869c82d67b226f700832123d60844f3", "name": "02868aee42f6491174fa2a4e1.jpg", "size": 4529, "originalFilename": "\\u0410\\u0428-1.jpg", "createdAt": "2024-05-12T10:16:43.688Z", "mimeType": "image/jpeg", "deleteToken": "f0a5aeaf39f63b452171"}
53	АШ-3	2024-05-10 12:23:34.49698	3	{"token": "3eff84ea2ccb2065a6ac3563c81a0a65d8f7fa2d7e0e733765f67fe93c2958887897458885f227e9b3cd", "name": "02868aee42f6491174fa2a4e3.jpg", "size": 4669, "originalFilename": "\\u0410\\u0428-3.jpg", "createdAt": "2024-05-12T10:16:51.682Z", "mimeType": "image/jpeg", "deleteToken": "31fd7b208a91fe9eac6a"}
79	ММ-2	2024-05-12 01:33:06.889227	3	{"token": "388c1c1a181026145e0b522bcf0c62851cdee8493a423f59840add2c02c8edf0ba4ec0410e2161fe77c5", "name": "02868aee42f6491174fa2a4e8.jpg", "size": 4471, "originalFilename": "\\u041c\\u041c-2.jpg", "createdAt": "2024-05-12T10:19:58.107Z", "mimeType": "image/jpeg", "deleteToken": "8b9dcd612f439f64ecb5"}
35	РБ-1	2024-05-10 12:21:39.269463	3	{"token": "e750b60d7fe607fb8484517957721e7cf3783ab5c699e7311e959024062de6f1c3b1941a0b621ba79a0c", "name": "02868aee42f6491174fa2a4ec.jpg", "size": 4599, "originalFilename": "\\u0420\\u0411-1.jpg", "createdAt": "2024-05-12T10:25:24.488Z", "mimeType": "image/jpeg", "deleteToken": "a00645495bc9054e960f"}
36	РБ-2	2024-05-10 12:21:49.726294	3	{"token": "6ed206c038efd83e2ce6bca9d1e7ef816136f8971064053b041c812770f338eb9b636ea9440460a16e84", "name": "02868aee42f6491174fa2a4ed.jpg", "size": 4795, "originalFilename": "\\u0420\\u0411-2.jpg", "createdAt": "2024-05-12T10:25:28.666Z", "mimeType": "image/jpeg", "deleteToken": "e84427a4d62b67dbfc93"}
42	РИ-2	2024-05-10 12:22:13.029232	3	{"token": "4a68df4afdcba9a9b4557d23783e83c646823f8919282df8f21a356e72292de81174025679eb2685bb71", "name": "02868aee42f6491174fa2a4f1.jpg", "size": 4870, "originalFilename": "\\u0420\\u0418-2.jpg", "createdAt": "2024-05-12T10:26:26.955Z", "mimeType": "image/jpeg", "deleteToken": "504808026db33bb18dee"}
40	РП-1	2024-05-10 12:22:06.127964	3	{"token": "62a5a87473d6296e1cb1788b9c60932875ad8ecaae2b953126beeff8da3db08afcf1865139ac3a4157df", "name": "02868aee42f6491174fa2a4f2.jpg", "size": 4252, "originalFilename": "\\u0420\\u041f-1.jpg", "createdAt": "2024-05-12T10:26:34.472Z", "mimeType": "image/jpeg", "deleteToken": "64669ff6517cc236f37b"}
83	КРГ	2024-05-12 11:55:23.23931	3	{"token": "ce55d1768ca5ffb1694b38dd3b436e87502f7f1b2bf4623e30c773f5892dc5429d52c7b2b9dfb3d3008d", "name": "02868aee42f6491174fa2a4f4.jpg", "size": 4733, "originalFilename": "\\u041a\\u0420\\u0413.jpg", "createdAt": "2024-05-12T10:28:29.628Z", "mimeType": "image/jpeg", "deleteToken": "24a5061546312630a115"}
49	НТК-1	2024-05-10 12:23:10.695898	3	{"token": "c26c4c52495dc1f41c281bb8490da5d827ee39cf0ea3772663130368e8154a712e25c3b008e3544a4cf8", "name": "b286e47f5d6867b5badfa9c00.jpg", "size": 3229, "originalFilename": "\\u041d\\u0422\\u041a-1.jpg", "createdAt": "2024-05-12T10:52:56.455Z", "mimeType": "image/jpeg", "deleteToken": "e012a7f414418828970c"}
45	НТК-2	2024-05-10 12:22:52.625016	3	{"token": "e99c8d6a1e7b48d9de76cc0d45a734b64adb87ca92683adeb091591f7e4abebbf9782206ca3a0c240687", "name": "b286e47f5d6867b5badfa9c01.jpg", "size": 3240, "originalFilename": "\\u041d\\u0422\\u041a-2.jpg", "createdAt": "2024-05-12T10:53:00.984Z", "mimeType": "image/jpeg", "deleteToken": "9f7d1db0983194172dc7"}
43	НТТ-1	2024-05-10 12:22:45.931276	3	{"token": "999e5f1f9926dea21c3c20d1b6edf84090ae316d973086849a5f9113d2c5b8693f79b29f175d1bf310c3", "name": "b286e47f5d6867b5badfa9c03.jpg", "size": 2840, "originalFilename": "\\u041d\\u0422\\u0422-1.jpg", "createdAt": "2024-05-12T10:53:09.315Z", "mimeType": "image/jpeg", "deleteToken": "be1a785d04401865e912"}
50	НТТШ	2024-05-10 12:23:14.424715	3	{"token": "6088ff1ed75c845ffa1a92f411b573ea7d832a59128973ef631f2cbf22e9fafb9fd6942857be8601408d", "name": "b286e47f5d6867b5badfa9c05.jpg", "size": 2896, "originalFilename": "\\u041d\\u0422\\u0422\\u0428.jpg", "createdAt": "2024-05-12T10:53:17.734Z", "mimeType": "image/jpeg", "deleteToken": "9c07f876c4650bd90b14"}
86	НТФ-3	2024-05-12 14:00:26.726518	3	{"token": "55ca69e5a91092f534ff87adb316fd4819637e8540a6b5b374ee4c99c01a646431c4e30c6408fc5df6f5", "name": "b286e47f5d6867b5badfa9c09.jpg", "size": 3606, "originalFilename": "\\u041d\\u0422\\u0424-3.jpg", "createdAt": "2024-05-12T11:01:00.207Z", "mimeType": "image/jpeg", "deleteToken": "496ddb6e27d105c1bb5e"}
47	НТФ-2	2024-05-10 12:23:02.047936	3	{"token": "8cffd1e01f4641b75516d4c24ae14fa4af6514d3e173156b978907725bbdf5f9ad39750c9dc761bd9ef3", "name": "b286e47f5d6867b5badfa9c06.jpg", "size": 3554, "originalFilename": "\\u041d\\u0422\\u0424-2.jpg", "createdAt": "2024-05-12T10:53:21.551Z", "mimeType": "image/jpeg", "deleteToken": "c59a50b0398f47ed90c8"}
87	НТФ-4	2024-05-12 14:01:15.927149	3	{"token": "66cf1cf87566d8c3bcc39ac280ebd30fcc12d833c605b1bbaa71306818375e960b002a94e5705e7a75b7", "name": "b286e47f5d6867b5badfa9c0a.jpg", "size": 3259, "originalFilename": "\\u041d\\u0422\\u0424-4.jpg", "createdAt": "2024-05-12T11:01:31.600Z", "mimeType": "image/jpeg", "deleteToken": "e34618a115c6ff0c8287"}
88	НТФ-1	2024-05-12 14:04:26.653747	3	{"token": "06e7d14e64d0501425f950d9fae9787a30c0937cb69382b2e921359aa79f7733e86f38e247aac651e810", "name": "b286e47f5d6867b5badfa9c0b.jpg", "size": 3357, "originalFilename": "\\u041d\\u0422\\u0424-1.jpg", "createdAt": "2024-05-12T11:04:56.338Z", "mimeType": "image/jpeg", "deleteToken": "1821c2ca2757865e979f"}
104	VГ-2б	2024-05-12 14:17:13.345446	4	{"token": "2c349899dae117b93cf141cd097fe7d36874bb991c75d646ab222c4384cfab1ce009b68529083017a6ff", "name": "b286e47f5d6867b5badfa9c30.jpg", "size": 4542, "originalFilename": "V\\u0413-2\\u0431.jpg", "createdAt": "2024-05-12T11:27:53.469Z", "mimeType": "image/jpeg", "deleteToken": "8a61e70f04a5ecbcc623"}
90	РЕ-2б	2024-05-12 14:15:48.358137	4	{"token": "c1fba0f8339b357680d74e2007498f35b1c53b3f55a4bec01fe57152e73592acc490c3e7c2194ee266f8", "name": "b286e47f5d6867b5badfa9c1f.jpg", "size": 3696, "originalFilename": "\\u0420\\u0415-2\\u0431.jpg", "createdAt": "2024-05-12T11:19:19.366Z", "mimeType": "image/jpeg", "deleteToken": "e23c64353a8fe66eabb2"}
89	РП-2б	2024-05-12 14:15:42.46931	4	{"token": "839bb387c494bf1c4a523190a0001ca1109309e85ba04469be5dac8c70d15869d4e2026674b2dfe54e32", "name": "b286e47f5d6867b5badfa9c20.jpg", "size": 3526, "originalFilename": "\\u0420\\u041f-2\\u0431.jpg", "createdAt": "2024-05-12T11:19:23.880Z", "mimeType": "image/jpeg", "deleteToken": "66d8e665e4a01882426c"}
91	ПБ-1с	2024-05-12 14:15:55.736112	4	{"token": "5f122764121c15b9c4c3a4029f398e3510f2c537e7dbe37e7adb05194d818cd2d12cfdab814b321a199e", "name": "b286e47f5d6867b5badfa9c21.jpg", "size": 4469, "originalFilename": "\\u041f\\u0411-1\\u0441.jpg", "createdAt": "2024-05-12T11:22:06.882Z", "mimeType": "image/jpeg", "deleteToken": "db4cf5ce1ab61c5106aa"}
92	ПБ-2б	2024-05-12 14:16:00.271233	4	{"token": "75a5f7e8c3c216a482b1eb9b91c1c134304c5b65d67371230e4a03cf0703caa6bfb8f114671c5747dbda", "name": "b286e47f5d6867b5badfa9c23.jpg", "size": 5163, "originalFilename": "\\u041f\\u0411-2\\u0431.jpg", "createdAt": "2024-05-12T11:22:11.147Z", "mimeType": "image/jpeg", "deleteToken": "e23be3014822a0ba2144"}
93	ПП-2б	2024-05-12 14:16:06.131446	4	{"token": "4f56a5879088a5e861e68069e24aab4870d107a0f2d1ce48049b49762674e3f2f8e5ad93dfb161b8483a", "name": "b286e47f5d6867b5badfa9c24.jpg", "size": 4720, "originalFilename": "\\u041f\\u041f-2\\u0431.jpg", "createdAt": "2024-05-12T11:22:15.288Z", "mimeType": "image/jpeg", "deleteToken": "820bec7279df22461832"}
94	ПТ-1б	2024-05-12 14:16:13.44891	4	{"token": "e4db2594191edf7f5c3d24d1bb66bdb2b9ef1c31583105d5ae35801ecd6efddb8337f9c0296253c9ae81", "name": "b286e47f5d6867b5badfa9c25.jpg", "size": 4653, "originalFilename": "\\u041f\\u0422-1\\u0431.jpg", "createdAt": "2024-05-12T11:22:19.572Z", "mimeType": "image/jpeg", "deleteToken": "88cc339dfb05d7f614cf"}
95	ПТ-2у	2024-05-12 14:16:21.35015	4	{"token": "87e6074b5986043201fa71a902905f7384e508119eda2865537ac90c25dbc728df5f3a454e47c416ad61", "name": "b286e47f5d6867b5badfa9c26.jpg", "size": 4869, "originalFilename": "\\u041f\\u0422-2\\u0443.jpg", "createdAt": "2024-05-12T11:22:23.012Z", "mimeType": "image/jpeg", "deleteToken": "54dab0edd7964a123e0c"}
96	ШФ-1с	2024-05-12 14:16:29.428831	4	{"token": "2aa9c9deeffdb5797b7531ed88c0e243ae7590b8aaaf819b1b756062766a2caf5b25bdc1ac8dcb4cafd0", "name": "b286e47f5d6867b5badfa9c27.jpg", "size": 4044, "originalFilename": "\\u0428\\u0424-1\\u0441.jpg", "createdAt": "2024-05-12T11:23:29.362Z", "mimeType": "image/jpeg", "deleteToken": "4795d85b7c4b2a6c6abc"}
97	ШФ-2б	2024-05-12 14:16:40.539244	4	{"token": "e10fb0e2dfbfb8112f70326c85bfac1ba24f09c1eefdaf74732d6e9672bd1994a0e9d900adca5fe920bb", "name": "b286e47f5d6867b5badfa9c28.jpg", "size": 4568, "originalFilename": "\\u0428\\u0424-2\\u0431.jpg", "createdAt": "2024-05-12T11:23:33.268Z", "mimeType": "image/jpeg", "deleteToken": "08fed2d62fb630f5b334"}
98	ТК-2у	2024-05-12 14:16:46.301182	4	{"token": "09892575dcceeb9e1e0c95e9c914245ad2c27bea67bca210a04e5e5657b83b6e1a53f826cb87c7101bac", "name": "b286e47f5d6867b5badfa9c29.jpg", "size": 4570, "originalFilename": "\\u0422\\u041a-2\\u0443.jpg", "createdAt": "2024-05-12T11:24:11.439Z", "mimeType": "image/jpeg", "deleteToken": "5fb53c76c1ab24a73e70"}
100	НТГ-1с	2024-05-12 14:16:56.307031	4	{"token": "aff88ca257bba31c84258a325b223b7dcd12e68a74846f4635a3ef03483de06e62e6b02de0fdfa6f43d3", "name": "b286e47f5d6867b5badfa9c2a.jpg", "size": 3791, "originalFilename": "\\u041d\\u0422\\u0413-1\\u0441.jpg", "createdAt": "2024-05-12T11:25:16.678Z", "mimeType": "image/jpeg", "deleteToken": "9aae817df7f7fc3bab2b"}
99	НТК-2б	2024-05-12 14:16:52.005521	4	{"token": "1c7cde73381b4bd4423a5a10912ccfdb3f2437740408c6a255d71e7bcbc5e5a638f33ac9f7a5bc87decf", "name": "b286e47f5d6867b5badfa9c2b.jpg", "size": 4480, "originalFilename": "\\u041d\\u0422\\u041a-2\\u0431.jpg", "createdAt": "2024-05-12T11:25:21.157Z", "mimeType": "image/jpeg", "deleteToken": "0300210abf84ebba0720"}
101	АР-1б	2024-05-12 14:17:00.682246	4	{"token": "20d86383d6f530d3d1257e4bcdd75cf98aeb1314865ee53360dae312db546362a533aa54f355d2ac2fc4", "name": "b286e47f5d6867b5badfa9c2d.jpg", "size": 4380, "originalFilename": "\\u0410\\u0420-1\\u0431.jpg", "createdAt": "2024-05-12T11:26:24.560Z", "mimeType": "image/jpeg", "deleteToken": "1e42decc5a5cbb21866f"}
102	АР-2б	2024-05-12 14:17:04.826016	4	{"token": "83b83a8487cfa9b2628c8024f2aeb01cb2c1eb37b164db7e76c07ef339acd54aa5e595a48dfd3387dcf0", "name": "b286e47f5d6867b5badfa9c2e.jpg", "size": 4594, "originalFilename": "\\u0410\\u0420-2\\u0431.jpg", "createdAt": "2024-05-12T11:26:28.718Z", "mimeType": "image/jpeg", "deleteToken": "bac75b3bb8a87be51154"}
103	VH-1у	2024-05-12 14:17:09.251274	4	{"token": "f1240719249551dbb719b43d015c132228b07297776c5cfcb8300d04352386540272195df81adaee1d68", "name": "b286e47f5d6867b5badfa9c2f.jpg", "size": 4088, "originalFilename": "VH-1\\u0443.jpg", "createdAt": "2024-05-12T11:27:49.227Z", "mimeType": "image/jpeg", "deleteToken": "c5dcc09f95e570d215b3"}
106	АП-2б	2024-05-12 14:17:23.074539	4	{"token": "71d2bde65ba079995a96da8e16b51e648227850ddff199aaff07b58d33894cb29e2aab0ee4d051aa6aa0", "name": "b286e47f5d6867b5badfa9c31.jpg", "size": 4738, "originalFilename": "Untitled_logo_9_free-file.jpg", "createdAt": "2024-05-12T11:28:42.232Z", "mimeType": "image/jpeg", "deleteToken": "5862b176dfb0b7aa7a20"}
105	ВМ-2б	2024-05-12 14:17:18.328562	4	{"token": "59f9de67640a36e7a8dc9ef2ec3c33a750583360e914519d37076a030fc7b473ed349d7b07f6c9a1bb05", "name": "b286e47f5d6867b5badfa9c32.jpg", "size": 5371, "originalFilename": "\\u0412\\u041c-2\\u0431.jpg", "createdAt": "2024-05-12T11:29:46.714Z", "mimeType": "image/jpeg", "deleteToken": "ed824bd408e477244d6f"}
\.


--
-- TOC entry 3494 (class 0 OID 1237779)
-- Dependencies: 214
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lessons (id, date, quantorium_id, quantum_id, teacher_id, group_id, time_begin, time_end) FROM stdin;
3	2024-05-06	3	9	23	2	17:30:00	19:00:00
4	2024-05-06	3	9	23	3	19:10:00	19:50:00
5	2024-05-07	3	9	23	1	15:00:00	16:30:00
6	2024-05-08	3	9	23	2	18:20:00	19:50:00
7	2024-04-22	3	9	23	1	15:00:00	16:30:00
8	2024-04-22	3	9	23	2	17:30:00	19:00:00
9	2024-04-22	3	9	23	3	19:10:00	19:50:00
10	2024-04-23	3	9	23	1	15:00:00	16:30:00
11	2024-04-24	3	9	23	2	18:20:00	19:50:00
12	2024-04-01	3	9	23	1	15:00:00	16:30:00
13	2024-04-01	3	9	23	2	17:30:00	19:00:00
14	2024-04-01	3	9	23	3	19:10:00	19:50:00
15	2024-04-02	3	9	23	1	15:00:00	16:30:00
16	2024-04-03	3	9	23	2	18:20:00	19:50:00
17	2024-04-08	3	9	23	1	15:00:00	16:30:00
18	2024-04-09	3	9	23	1	15:00:00	16:30:00
19	2024-04-10	3	9	23	2	18:20:00	19:50:00
20	2024-04-15	3	9	23	1	15:00:00	16:30:00
21	2024-04-15	3	9	23	2	17:30:00	19:00:00
22	2024-04-15	3	9	23	3	19:10:00	19:50:00
23	2024-04-16	3	9	23	1	15:00:00	16:30:00
24	2024-04-17	3	9	23	2	18:20:00	19:50:00
25	2024-05-06	3	9	23	1	15:00:00	16:30:00
26	2024-05-13	3	9	23	1	15:00:00	16:30:00
27	2024-05-13	3	9	23	2	17:30:00	19:00:00
28	2024-05-13	3	9	23	3	19:10:00	19:50:00
29	2024-05-14	3	9	23	1	15:00:00	16:30:00
\.


--
-- TOC entry 3496 (class 0 OID 1237783)
-- Dependencies: 216
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, title, created_at, description, quantorium_id, img) FROM stdin;
1	Выходные дни в мае	2024-04-28 18:51:21.952814	\N	3	{"token": "7b741fa919a1a5fe5756b471bc56238bef1c394511b018b691a79fead8bf1eb1108eb65fd543460f77ef", "name": "b1d1b3f72287ddc91d0e43bb8.png", "size": 75896, "originalFilename": "unsplash_TeJZ3CGZXRw (1).png", "createdAt": "2024-05-05T09:31:22.458Z", "mimeType": "image/png", "deleteToken": "328f124384209e6265d6"}
15	«Digitalogia. Новое поколение»	2024-05-07 01:09:11.976137	Детские технопарки «Кванториум» и ПАО «Ростелеком» запускают межрегиональный медиаконкурс «Digitalogia. Новое поколение».	3	{"token": "6e96adc1fe4aa61881ab4e534642324a1e81ca524e8c0441c57a68d9d496b53e1c1454e104e5582dcc6a", "name": "ebcfd50bd791b9475b3758644.jpg", "size": 287181, "originalFilename": "kx034a6c3302wkxpmt42g96fz3nsjy2y.jpg", "createdAt": "2024-05-06T22:09:11.582Z", "mimeType": "image/jpeg", "deleteToken": "fe877236217b2945bf97"}
16	Мобильный технопарк в ДСООЦ «Лазурный»	2024-05-07 01:09:31.95082	Мобильный технопарк «Кванториум», центра молодежных, инженерных и научных компетенций, посетил детский центр «Лазурный» Нижегородской области.	3	{"token": "410af6d7a84166cc9e1fdb745fab99433012850c2aae5b76802efc5b5cf6fe1c794fd33a6bd7336f7eb6", "name": "ebcfd50bd791b9475b3758645.jpg", "size": 235633, "originalFilename": "d01uidx1ldh7w3vakturwgrup0mru527.jpg", "createdAt": "2024-05-06T22:09:33.051Z", "mimeType": "image/jpeg", "deleteToken": "a2e9647cfa9eb8a61cca"}
25	День труда	2024-04-27 16:06:37.65571	Отмена занятий в связи с празднованием 1 мая - Праздника Весны и Труда 💐\n\n🚩Ура товарищи!	\N	null
2	12 апреля – День космонавтики!🪐	2024-04-12 15:48:28.431873	В честь данного праздника у нас в Кванториуме прошел интерактивный КВИЗ «Полетам дан отсчет!». Ребята отвечали на различные вопросы о космосе, планетах, знаменитых космонавтах, а также узнали много нового и интересного о космической жизни!  \n\n🚀Несколько интересных фактов о космосе: \n\nФакт №1– Вес Солнца превышает вес Земли в 330 тысяч раз. \nФакт №2– День на Марсе длится 24 часа 39 минут и 35 секунд. \nФакт №3– Следы от ботинок или лунохода на Луне останутся навсегда. \n\nА вы знали?🤔	3	{"token": "a3e45d251a3dca924c838dc7277a50b55f0fe555e8e0eb619cfeb71b551836cd1f28e3d0cb78929cb17b", "name": "b1d1b3f72287ddc91d0e43bbc.png", "size": 409876, "originalFilename": "unsplash_TeJZ3CGZXRw.png", "createdAt": "2024-05-05T09:38:20.449Z", "mimeType": "image/png", "deleteToken": "6096224bc3e6d0894771"}
26	День Победы🎉	2024-05-08 16:16:08.476616	Отмена занятий в связи с празднованием Дня Победы!!!	\N	{\n  "createdAt": "2024-05-11T13:18:07.743Z",\n  "deleteToken": "f65125353f1ee05b5dcb",\n  "mimeType": "image/jpeg",\n  "name": "e8587cbf9fd8b9da8097cf6ad.jpg",\n  "originalFilename": "UDAGBUc2KpmthBYwLAHn.jpg",\n  "size": 165446,\n  "token": "66b5d50b9df21f22729074a114194b2d6d51524dd463fe930e5899dce414142b84d77ab85822630157f2"\n}
\.


--
-- TOC entry 3498 (class 0 OID 1237789)
-- Dependencies: 218
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, description, user_id) FROM stdin;
\.


--
-- TOC entry 3500 (class 0 OID 1237795)
-- Dependencies: 220
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, created_at, name, description, materials, quantum_id, student_id, img) FROM stdin;
12	2024-05-09 13:31:46.295805	Симулятор вождения	Симулятор вождения на легковом автомобиле по городам и сёлам России	{"files": [{"token": "5d0575aeae148a234cb656214c6bcd1c9b67e38ee5004ecc4927a6554b67e3eb28b82c49eef0591cf678", "name": "7860bb1b2b87c3ab2190b3825.txt", "size": 32, "originalFilename": "\\u0444\\u0430\\u0439\\u043b.txt", "createdAt": "2024-05-09T10:31:45.614Z", "mimeType": "text/plain", "deleteToken": "e2ebaad5b687465f8f60"}, {"token": "fa050155c97408c4750d704bfd52600bbf9d8834002b4c9320030659e8df78529ae009ab6ceab2b6996f", "name": "d09212a51f797380849bd202f.jpg", "size": 393584, "originalFilename": "961358_OFEDFQ0.jpg", "createdAt": "2024-05-09T16:59:13.199Z", "mimeType": "image/jpeg", "deleteToken": "808b4674214eab4cd400"}, {"token": "703983e503d5025966b7482cedeb186e37f8b52479cf38e0d610f9a4a0a5f4adeb246d7552c93abdab34", "name": "d09212a51f797380849bd2034.kdenlive", "size": 337753, "originalFilename": "d.kdenlive", "createdAt": "2024-05-09T17:04:00.344Z", "mimeType": "application/octet-stream", "deleteToken": "487ad424ca4b300efb28"}, {"token": "44b6601f9b56748dccdcd71472129336a5d732fd1963ca40e802b8b94ae21b5b751f04ecc148b9fc844a", "name": "f0259b8dfa24979d8ca487e9e.png", "size": 12240, "originalFilename": "2W8F4Q1N8KBBMSVNJKQ9_1714575454806.png", "createdAt": "2024-05-15T08:32:07.456Z", "mimeType": "image/png", "deleteToken": "533f3866bfe25f451179"}]}	9	8	{"token": "0c33ee36a8fca18077bfd5be6bbb910b3078df6f35cf39522576c499fa0c50fd19864b58dae94174c56e", "name": "d09212a51f797380849bd2032.jpg", "size": 9225, "originalFilename": "\\u0411\\u0435\\u0437 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f.jpg", "createdAt": "2024-05-09T17:01:47.241Z", "mimeType": "image/jpeg", "deleteToken": "2123c4fa25a97d81489a"}
\.


--
-- TOC entry 3502 (class 0 OID 1237801)
-- Dependencies: 222
-- Data for Name: quantoriums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quantoriums (id, address, created_at, img) FROM stdin;
4	Кванториум ГАЗ	2024-05-05 20:59:29.299715	{"token": "99db8748434deb11ca275804a1f6bd9829e8f8d8a5c6a8556486b969805480db1e74cccd07aa68186fe3", "name": "f2b66ef15305b4c00e1ff0ee6.png", "size": 48794, "originalFilename": "kv_gaz.png", "createdAt": "2024-05-06T20:01:23.416Z", "mimeType": "image/png", "deleteToken": "e100071b44e48814c15e"}
3	Кванториум Нижний Новгород	2024-04-24 13:38:16.84232	{"token": "ffc44ff21bad42afe282c7515e811a62d53b0a18f4e8df80fcbb3a9ddc7ad2aa3b586edda39532b40a7e", "name": "ed42f9c35f1ed78a8875bce05.png", "size": 58126, "originalFilename": "kvantotium_nn.png", "createdAt": "2024-05-07T07:46:39.588Z", "mimeType": "image/png", "deleteToken": "a1dbadcb7ae2dd0ac373"}
\.


--
-- TOC entry 3504 (class 0 OID 1237807)
-- Dependencies: 224
-- Data for Name: quantums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quantums (id, name, quantorium_id, img) FROM stdin;
3	Промробоквантум	3	{"token": "dd1b4aae1ec69c0b057a962bb594efbaefbb32aa814a1e1fa4ad7be825b8b02e7d977cf3e57be159f6c2", "name": "ed42f9c35f1ed78a8875bce0d.jpg", "size": 18202, "originalFilename": "v9277wu8lbpikjlqt37fdzaorcouduwt.jpg", "createdAt": "2024-05-07T07:53:06.800Z", "mimeType": "image/jpeg", "deleteToken": "fe42cab18ede549d418d"}
2	Наноквантум	3	{"token": "dd20da9cc70298a651b248e0287f22c89eeaf60d07c7c94ee7593a8d6d67d0ec2f746fdf076f51d02068", "name": "ed42f9c35f1ed78a8875bce0e.jpg", "size": 14879, "originalFilename": "fi3nzt16clk4eni108g0nnpu5jbr2cxe.jpg", "createdAt": "2024-05-07T07:53:15.813Z", "mimeType": "image/jpeg", "deleteToken": "7267f2853d288d79bc89"}
4	VR/AR-квантум	3	{"token": "bcf161644cc8be5ccaa3f4bee475ae32e988beae1b6d73f574288c925582a59d0e6825eeff94a34cea68", "name": "ed42f9c35f1ed78a8875bce10.jpg", "size": 15092, "originalFilename": "n9qvv2b25pwiz4rf3ynpsjpwq4dwyhep.jpg", "createdAt": "2024-05-07T08:16:26.105Z", "mimeType": "image/jpeg", "deleteToken": "114dcf2c84e82bec2a02"}
5	Биоквантум	3	{"token": "ceff57de1187050fab093d9ca948b94d22fc91eae8e119ad1672a0ba2612730d9f15f5998f26d4f9f65d", "name": "ed42f9c35f1ed78a8875bce11.jpg", "size": 12220, "originalFilename": "47qv993atsrvbplo4dmtjsrlhsmijv2s.jpg", "createdAt": "2024-05-07T08:39:01.075Z", "mimeType": "image/jpeg", "deleteToken": "1093be4040885cac085b"}
9	IT-квантум	3	{"token": "0fed19c943c817c36a4af2fa4164bb095309829ed4e004af7aa7851fa7f26c23e97cccb9ec668d6370d2", "name": "01bbd6f5cea870e370e63af1d.jpg", "size": 13491, "originalFilename": "ksk4q1nzxvhm0lt6tkyygpvmgcqes24k.jpg", "createdAt": "2024-05-07T15:21:03.002Z", "mimeType": "image/jpeg", "deleteToken": "651a6bc7b8443232f6d8"}
12	Английский язык	3	{"token": "636aa8327654d1ef86c4e2648a4577edb9886fa410a4ff0a535a1ba0fb57c5e521df2627760205fa09b4", "name": "7d2529d0088b99ad53d51e100.jpg", "size": 17158, "originalFilename": "w60p48ncfyem3rcc0ifnk8ansf2n9nzr.jpg", "createdAt": "2024-05-10T08:31:30.846Z", "mimeType": "image/jpeg", "deleteToken": "a03dc2a7939e42f16c6b"}
19	Автоквантум	4	{"token": "be34edad4297f8d27290cc3ae2735500b33dc44bf4597990b6957760648177cff9e3a2e362e4b5e00dca", "name": "b286e47f5d6867b5badfa9c14.jpg", "size": 15655, "originalFilename": "8knej6ecdiazwa5immrnn3x5l84ztta1.jpg", "createdAt": "2024-05-12T11:11:44.070Z", "mimeType": "image/jpeg", "deleteToken": "25cb3eb90b6ea183db15"}
13	Математика	3	{"token": "b536118c78eb3d5f415e84120b1d7f071a6622f66e1ea68f78afed324f1c8f7dc660b5eb71c691e4550f", "name": "7d2529d0088b99ad53d51e102.jpg", "size": 11992, "originalFilename": "hf8lwuhhgaqbfd33rlvvzkazqdi4pvpk.jpg", "createdAt": "2024-05-10T08:31:46.559Z", "mimeType": "image/jpeg", "deleteToken": "9fc6d94c66e65e9bfcd0"}
10	Хайтек	3	{"token": "eaac10238f1f8730da3bcc2bdb19be8193c834c51494e9238d3a1cd0087927ae27504b3969966f6c2997", "name": "7d2529d0088b99ad53d51e103.jpg", "size": 12352, "originalFilename": "iwlsszizp8zpekr3x61p6i1mxvla91yt.jpg", "createdAt": "2024-05-10T08:31:56.754Z", "mimeType": "image/jpeg", "deleteToken": "9f352615195df03eff21"}
14	Медиаквантум	3	{"token": "4daff47edb41238d979772435d90783bdbb5f42bad21f71792b8575a19ca0835616d9ebd669578b184f2", "name": "7d2529d0088b99ad53d51e104.jpg", "size": 20484, "originalFilename": "madv8ku0lzrdmizc5hs505hifb2av9v3.jpg", "createdAt": "2024-05-10T08:31:57.467Z", "mimeType": "image/jpeg", "deleteToken": "54de84b802a0471ecf1c"}
11	Квантошахматы	3	{"token": "beb19d26093c6a575af55373f8785b666f65e5e755326965f144ad93cfefc213c686cbe088fa6eae9db5", "name": "7d2529d0088b99ad53d51e101.jpg", "size": 19209, "originalFilename": "s09jx6nz8o8g9d14cg2xoijfxf8qcs3j.jpg", "createdAt": "2024-05-10T08:31:39.617Z", "mimeType": "image/jpeg", "deleteToken": "78c6ca81eacc529aedd1"}
23	VR/AR-квантум	4	{"token": "7a50d146f016b4f9c1e0e76ff9903c9bdef53502d88feca4ebd2fa86db9a853a10eccd8684d95777570a", "name": "b286e47f5d6867b5badfa9c0e.jpg", "size": 15092, "originalFilename": "n9qvv2b25pwiz4rf3ynpsjpwq4dwyhep.jpg", "createdAt": "2024-05-12T11:09:57.038Z", "mimeType": "image/jpeg", "deleteToken": "f24bde473e10b85c1c36"}
22	Английский язык	4	{"token": "65cb82644d98f6ecec8a2970d83f227a14cc7570a086ed6b374648133f74cda6917fab985761610d3d58", "name": "b286e47f5d6867b5badfa9c0f.jpg", "size": 17158, "originalFilename": "w60p48ncfyem3rcc0ifnk8ansf2n9nzr.jpg", "createdAt": "2024-05-12T11:10:03.698Z", "mimeType": "image/jpeg", "deleteToken": "4e32a58bbf6497897206"}
21	Квантошахматы	4	{"token": "40b733dc8c5ff7f2b83901ca56640b6f585d11bec72f6a5a5213a448709e38c6d60d17369d7fd39249fb", "name": "b286e47f5d6867b5badfa9c10.jpg", "size": 19209, "originalFilename": "s09jx6nz8o8g9d14cg2xoijfxf8qcs3j.jpg", "createdAt": "2024-05-12T11:10:07.279Z", "mimeType": "image/jpeg", "deleteToken": "0162e8a81c12c7e6c2a3"}
20	Медиаквантум	4	{"token": "84bdc4ce5b317b50eb1d18a4bcfee1797063f702c4a66e844e24d13ac1c3552c5d73dd69fcc0a24773ac", "name": "b286e47f5d6867b5badfa9c11.jpg", "size": 20484, "originalFilename": "madv8ku0lzrdmizc5hs505hifb2av9v3.jpg", "createdAt": "2024-05-12T11:10:10.968Z", "mimeType": "image/jpeg", "deleteToken": "1b08e1b4f3d51db9d220"}
16	Промробоквантум	4	{"token": "9dc9da7baf85580974256dcf3c1fe23d6d0f3e7a40d7dd4339c45aeeb9f441376d50c5d6338c75df60a9", "name": "b286e47f5d6867b5badfa9c12.jpg", "size": 18202, "originalFilename": "v9277wu8lbpikjlqt37fdzaorcouduwt.jpg", "createdAt": "2024-05-12T11:10:22.603Z", "mimeType": "image/jpeg", "deleteToken": "f40f7bda8f971dcc3d21"}
18	Хайтек	4	{"token": "8914d4c2650f87b124dc223e632f1cdc7b81fb001d21b9ad9aadca50e60557150de3cf109a78c1cc2b1a", "name": "b286e47f5d6867b5badfa9c13.jpg", "size": 12352, "originalFilename": "iwlsszizp8zpekr3x61p6i1mxvla91yt.jpg", "createdAt": "2024-05-12T11:10:25.498Z", "mimeType": "image/jpeg", "deleteToken": "054b4fbf9199b928a94b"}
17	Промдизайнквантум	4	{"token": "9978d1467678c6c5adf71e489bdbdf679a2b60e0bae07a548860fc9b47072f1bcef65e8141b9b0182eea", "name": "b286e47f5d6867b5badfa9c15.jpg", "size": 13084, "originalFilename": "q3osf8o18bt7ss4rtbifo0dxda4x6lkf.jpg", "createdAt": "2024-05-12T11:11:48.128Z", "mimeType": "image/jpeg", "deleteToken": "881e05488c2a595e519a"}
\.


--
-- TOC entry 3506 (class 0 OID 1237813)
-- Dependencies: 226
-- Data for Name: reasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reasons (id, date_begin, name, quantorium_id, date_end) FROM stdin;
10	2024-04-28 00:00:00	День труда	\N	2024-05-01 23:59:00
11	2024-05-09 00:00:00	День Победы🎉	\N	2024-05-12 23:59:00
\.


--
-- TOC entry 3508 (class 0 OID 1237817)
-- Dependencies: 228
-- Data for Name: recoveries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recoveries (code, user_id) FROM stdin;
cgnvcfpxwtxveyul	1
oedmuahlyilwgazx	1
\.


--
-- TOC entry 3509 (class 0 OID 1237820)
-- Dependencies: 229
-- Data for Name: representatives; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.representatives (user_id, phone, patronymic, quantorium_id) FROM stdin;
15	+7 (935) 623-73-47	Сергеевна	4
21	+7 (993) 971-82-83	Давидовна	3
\.


--
-- TOC entry 3510 (class 0 OID 1237823)
-- Dependencies: 230
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	администратор
2	представитель
3	преподаватель
4	ученик
\.


--
-- TOC entry 3512 (class 0 OID 1237827)
-- Dependencies: 232
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, name, quantorium_id, img) FROM stdin;
4	Промробоквантум	3	{"token": "180e50eab16a4f4b1f5657ccdabddcf22c9d3245c01f5ca7fd4a4d672333c71f6b7c39539c27bb2dc5d2", "name": "ed42f9c35f1ed78a8875bce16.jpg", "size": 29396, "originalFilename": "Z3oboW8VYw8.jpg", "createdAt": "2024-05-07T08:59:20.784Z", "mimeType": "image/jpeg", "deleteToken": "16b23ffc26a03f72072f"}
5	VR/AR-квантум	3	{"token": "da70e76ad401edd21be102bebacded9a5ad1524ec95fb5514573867c6c86085a39e7c1a8e288a63126f6", "name": "ed42f9c35f1ed78a8875bce22.jpg", "size": 19224, "originalFilename": "n9qvv2b25pwiz4rf3ynpsjpwq4dwyhep.jpg", "createdAt": "2024-05-07T09:06:14.799Z", "mimeType": "image/jpeg", "deleteToken": "5d7a8920b8bd200f9c58"}
6	IT-квантум	3	{"token": "5412bed2cfb9a68d362e6b7d40ffe6c9d8a61d64e8bafb1eb7dc26836fb7c91c7775e7413feeca8864ad", "name": "ab06d6784c1da094e2f17af51.jpg", "size": 54371, "originalFilename": "Uc2bqqVAPsQ.jpg", "createdAt": "2024-05-10T17:12:51.827Z", "mimeType": "image/jpeg", "deleteToken": "6393b9bcc4126389b2bc"}
1	Хайтекквантум	3	{"token": "e9bb26652e75d99a1286cf5bf029f4c5d70e564ce2d1c67c8a2d90a01c5d435ea4645b2885a7910911ff", "name": "ab06d6784c1da094e2f17af54.png", "size": 14530, "originalFilename": "kvant-hajtek-.png", "createdAt": "2024-05-10T17:13:34.563Z", "mimeType": "image/png", "deleteToken": "d71a222708ef21f0db9d"}
7	Шахматы	3	{"token": "acaef99268cbc9e4326aad5915e097f8dc549d519535d554326bba3d5ea09fc70539fe117fa60daaf3ae", "name": "ab06d6784c1da094e2f17af56.jpg", "size": 23424, "originalFilename": "ngvz6_9-KcQ.jpg", "createdAt": "2024-05-10T17:14:42.403Z", "mimeType": "image/jpeg", "deleteToken": "2c42697955e3a3014715"}
8	Математика	3	{"token": "1caeea24fe2ecf4a387465bcd00dfd8124a72e0e6ffaa94a00c6bdca6db96eff63e7497ee7dbc4e0e0cb", "name": "ab06d6784c1da094e2f17af58.jpg", "size": 12904, "originalFilename": "hf8lwuhhgaqbfd33rlvvzkazqdi4pvpk.jpg", "createdAt": "2024-05-10T17:16:14.393Z", "mimeType": "image/jpeg", "deleteToken": "327602c68a07abc0d931"}
9	Наноквантум	3	{"token": "02ad05400a0f258a16bda13a6940d2e267551cefee58a3c4f40f7ef1ed23fc8af9ce213cff0e765b7f5e", "name": "ab06d6784c1da094e2f17af59.jpg", "size": 18848, "originalFilename": "fi3nzt16clk4eni108g0nnpu5jbr2cxe.jpg", "createdAt": "2024-05-10T17:17:03.655Z", "mimeType": "image/jpeg", "deleteToken": "4a2fa6208000bd039040"}
2	Коворкинг	3	{"token": "b01897611cf5914718cf4f88b1b182d43e5e476255c00faf1fefd8fb04cb3399d515e195ff6363d49b95", "name": "2f1a9cf2ee226cc937df21f29.jpg", "size": 19306, "originalFilename": "dQypWh86yCE.jpg", "createdAt": "2024-05-11T19:47:59.550Z", "mimeType": "image/jpeg", "deleteToken": "85567a3d2ea951dc792a"}
11	Биоквантум	3	{"token": "c18d3b1d04719f993e97b044723a599b00a6432371b8840586f05947d97ca487d0867620f1f3114ac2bc", "name": "2f1a9cf2ee226cc937df21f3d.jpg", "size": 32178, "originalFilename": "ecVn4-GxaJ4.jpg", "createdAt": "2024-05-11T20:07:23.266Z", "mimeType": "image/jpeg", "deleteToken": "a0052dd4a00bb59aa70c"}
12	Медиаквантум	3	{"token": "7de6d30dc8db1519402942c512870a9798022d7670f843a597f7d3a3e6c92c6dfc20723ea9d25e26883e", "name": "2f1a9cf2ee226cc937df21f49.jpg", "size": 20321, "originalFilename": "madv8ku0lzrdmizc5hs505hifb2av9v3.jpg", "createdAt": "2024-05-11T20:37:41.060Z", "mimeType": "image/jpeg", "deleteToken": "9a000c2e8f2a56bdc120"}
15	VR/AR-квантум	4	{"token": "0e05d8f71cc75d814f6dcc19d4162f967c27d14ee2906c3184914feb3cf5aeec4eb797a6e8ff9d1a15d3", "name": "b286e47f5d6867b5badfa9c18.jpg", "size": 19224, "originalFilename": "n9qvv2b25pwiz4rf3ynpsjpwq4dwyhep.jpg", "createdAt": "2024-05-12T11:13:00.449Z", "mimeType": "image/jpeg", "deleteToken": "6398896f59585f98fc73"}
17	Коворкинг 	4	{"token": "71e9cb741cfdd2335d44bf978b51b013a92c246b319d062a4389e714bad1dac81eb681158d78a9e9f3e6", "name": "b286e47f5d6867b5badfa9c19.jpg", "size": 19306, "originalFilename": "dQypWh86yCE.jpg", "createdAt": "2024-05-12T11:13:03.794Z", "mimeType": "image/jpeg", "deleteToken": "08002fc41a50bf8c949c"}
16	Промробоквантум	4	{"token": "9b5811ac3702635aaec4ed170b74ee0f71ba9f796f13d911d76c78ae401a560d98cd38d50689d2fda6b4", "name": "b286e47f5d6867b5badfa9c1a.jpg", "size": 29396, "originalFilename": "Z3oboW8VYw8.jpg", "createdAt": "2024-05-12T11:13:08.183Z", "mimeType": "image/jpeg", "deleteToken": "b03175b4ea810151bdb8"}
14	Хайтекквантум	4	{"token": "bce53a48eb7689f711384a82c80090d31ef88bfb4f7abe7d5b2aa6061d9f8750c569753356f0d55e75e5", "name": "b286e47f5d6867b5badfa9c1b.png", "size": 14530, "originalFilename": "kvant-hajtek-.png", "createdAt": "2024-05-12T11:13:11.700Z", "mimeType": "image/png", "deleteToken": "4fc1fedf3ec7adfe75d7"}
13	Промдизайнквантум	4	{"token": "b810411a1e986176203c5d045201c65d243077d003209f6112e09574e6e79b9bb889738dc83b862323fb", "name": "b286e47f5d6867b5badfa9c1d.jpg", "size": 15456, "originalFilename": "q3osf8o18bt7ss4rtbifo0dxda4x6lkf.jpg", "createdAt": "2024-05-12T11:15:21.557Z", "mimeType": "image/jpeg", "deleteToken": "122b74886ae07d44b75b"}
\.


--
-- TOC entry 3514 (class 0 OID 1237833)
-- Dependencies: 234
-- Data for Name: schedule_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_items (id, dateweek, quantorium_id, quantum_id, teacher_id, group_id, room_id, time_begin, time_end) FROM stdin;
64	5	3	5	35	74	11	18:20:00	19:50:00
65	0	3	14	37	25	12	16:40:00	18:10:00
66	0	3	14	37	27	12	18:20:00	19:50:00
67	1	3	14	37	57	12	16:40:00	17:20:00
68	1	3	14	149	24	12	18:20:00	19:50:00
69	2	3	14	36	26	12	15:00:00	16:30:00
70	2	3	14	37	25	12	16:40:00	18:10:00
71	2	3	14	37	27	12	18:20:00	19:50:00
72	3	3	14	36	75	12	15:00:00	16:30:00
73	3	3	14	149	56	12	17:30:00	18:10:00
74	3	3	14	149	55	12	18:20:00	19:50:00
1	3	3	9	52	66	6	16:40:00	18:10:00
2	3	3	9	52	67	6	15:00:00	16:30:00
3	2	3	9	28	6	6	15:00:00	16:30:00
4	0	3	9	23	1	6	15:00:00	16:30:00
6	0	3	9	23	2	6	17:30:00	19:00:00
8	0	3	9	23	3	6	19:10:00	19:50:00
9	1	3	9	23	1	6	15:00:00	16:30:00
10	1	3	9	28	5	6	16:40:00	18:10:00
11	1	3	9	28	6	6	18:20:00	19:50:00
12	2	3	9	28	5	6	16:40:00	18:10:00
13	2	3	9	23	2	6	18:20:00	19:50:00
14	3	3	9	52	65	6	18:20:00	19:50:00
15	4	3	9	52	63	6	15:00:00	16:30:00
16	4	3	9	52	66	6	16:40:00	18:10:00
17	4	3	9	52	64	6	18:20:00	19:50:00
18	5	3	9	52	63	6	15:00:00	16:30:00
19	5	3	9	52	65	6	16:40:00	18:10:00
20	5	3	9	52	64	6	18:20:00	19:50:00
21	0	3	4	32	13	5	10:00:00	11:30:00
22	0	3	4	32	14	5	15:00:00	16:30:00
24	0	3	4	30	8	5	18:20:00	19:50:00
23	0	3	4	83	9	5	16:40:00	18:10:00
25	1	3	4	31	70	5	14:10:00	14:50:00
26	1	3	4	31	11	5	15:00:00	16:30:00
27	1	3	4	31	12	5	16:40:00	18:10:00
29	1	3	4	32	72	5	18:20:00	19:50:00
30	2	3	4	32	13	5	10:00:00	11:30:00
31	2	3	4	32	14	5	15:00:00	16:30:00
32	2	3	4	30	7	5	16:40:00	18:10:00
33	2	3	4	30	10	5	18:20:00	19:50:00
34	3	3	4	32	71	5	13:40:00	14:50:00
35	3	3	4	31	11	5	15:00:00	16:30:00
36	3	3	4	31	12	5	16:40:00	18:10:00
37	3	3	4	32	72	5	18:20:00	19:50:00
38	4	3	4	30	69	5	14:10:00	14:50:00
39	4	3	4	30	68	5	15:00:00	16:30:00
41	4	3	4	30	8	5	18:20:00	19:50:00
40	4	3	4	83	9	5	16:40:00	18:10:00
42	5	3	4	30	69	5	13:40:00	14:50:00
43	5	3	4	30	68	5	15:00:00	16:30:00
44	5	3	4	30	7	5	16:40:00	18:10:00
45	5	3	4	30	10	5	18:20:00	19:50:00
46	0	3	5	33	16	11	15:00:00	16:30:00
47	0	3	5	33	15	11	16:40:00	18:10:00
48	0	3	5	33	18	11	18:20:00	19:30:00
49	1	3	5	34	19	11	16:40:00	18:10:00
50	1	3	5	34	20	11	18:20:00	19:50:00
51	2	3	5	34	19	11	15:50:00	18:10:00
52	2	3	5	34	20	11	18:20:00	19:50:00
53	3	3	5	33	16	11	15:00:00	16:30:00
54	3	3	5	33	17	11	16:40:00	18:10:00
55	3	3	5	35	21	11	18:20:00	19:50:00
56	4	3	5	35	74	11	10:00:00	11:30:00
57	4	3	5	35	22	11	15:00:00	16:30:00
58	4	3	5	33	17	11	16:40:00	18:10:00
59	4	3	5	33	15	11	18:20:00	19:50:00
60	5	3	5	35	23	11	13:40:00	14:50:00
61	5	3	5	35	22	11	15:00:00	16:30:00
62	5	3	5	35	21	11	16:40:00	18:10:00
75	5	3	14	149	24	12	14:10:00	14:50:00
76	5	3	14	149	24	12	15:00:00	16:30:00
77	5	3	14	149	24	12	16:40:00	18:10:00
78	0	3	2	48	33	9	15:00:00	16:30:00
79	0	3	2	40	31	9	16:40:00	18:10:00
80	0	3	2	40	32	9	18:20:00	19:50:00
81	1	3	2	48	34	9	15:00:00	16:30:00
82	1	3	2	38	28	9	16:40:00	18:10:00
83	1	3	2	38	29	9	18:20:00	19:50:00
84	2	3	2	38	30	9	15:50:00	16:30:00
85	2	3	2	38	28	9	16:40:00	18:10:00
86	2	3	2	38	29	9	18:20:00	19:50:00
87	3	3	2	40	77	9	15:50:00	16:30:00
88	3	3	2	40	31	9	16:40:00	18:10:00
89	3	3	2	40	32	9	18:20:00	19:50:00
90	5	3	2	48	76	9	15:50:00	16:30:00
91	5	3	2	48	34	9	16:40:00	18:10:00
92	5	3	2	48	33	9	18:20:00	19:50:00
93	2	3	11	48	62	7	15:50:00	18:10:00
94	2	3	11	48	61	7	18:20:00	19:50:00
95	5	3	11	48	62	7	15:00:00	16:30:00
96	5	3	11	48	61	7	16:40:00	18:10:00
97	1	3	13	49	78	8	16:40:00	18:10:00
98	1	3	13	49	80	8	18:20:00	19:50:00
99	3	3	13	50	60	8	15:00:00	16:30:00
100	3	3	13	50	58	8	16:40:00	18:10:00
101	4	3	13	49	79	8	16:40:00	18:10:00
102	4	3	13	49	81	8	16:40:00	18:10:00
104	5	3	13	50	59	8	14:10:00	14:50:00
105	5	3	13	50	58	8	15:00:00	16:30:00
106	5	3	13	50	60	8	16:40:00	18:10:00
107	0	3	12	191	52	2	15:00:00	16:30:00
108	0	3	12	191	54	2	16:40:00	18:10:00
109	0	3	12	191	54	2	18:20:00	19:50:00
110	1	3	12	191	51	2	15:00:00	16:30:00
111	2	3	12	191	52	2	15:00:00	16:30:00
112	2	3	12	191	54	2	16:40:00	18:10:00
113	2	3	12	191	53	2	18:20:00	19:50:00
114	4	3	12	191	51	2	15:00:00	16:30:00
115	0	3	3	44	40	4	13:20:00	14:50:00
118	0	3	3	44	39	4	15:00:00	16:30:00
119	0	3	3	45	41	4	16:40:00	18:10:00
120	0	3	3	45	42	4	18:20:00	19:50:00
121	1	3	3	44	40	4	14:10:00	15:40:00
122	1	3	3	43	83	4	15:50:00	16:30:00
123	1	3	3	43	37	4	16:40:00	18:10:00
124	1	3	3	43	38	4	18:20:00	19:50:00
117	2	3	3	42	82	4	15:50:00	16:30:00
125	2	3	3	42	35	4	16:40:00	18:10:00
126	2	3	3	42	35	4	16:40:00	18:10:00
127	2	3	3	42	36	4	18:20:00	19:50:00
128	3	3	3	45	84	4	15:50:00	16:30:00
129	3	3	3	45	41	4	16:40:00	18:10:00
130	3	3	3	45	42	4	18:20:00	19:50:00
131	4	3	3	44	85	4	14:10:00	14:50:00
116	4	3	3	44	39	4	15:00:00	16:30:00
132	4	3	3	43	37	4	16:40:00	18:10:00
133	4	3	3	43	38	4	18:20:00	19:50:00
134	5	3	3	42	35	4	15:00:00	16:30:00
135	5	3	3	42	36	4	16:40:00	18:10:00
136	0	3	10	28	50	1	15:00:00	16:30:00
137	0	3	10	28	44	1	16:40:00	18:10:00
138	0	3	10	28	43	1	18:20:00	19:50:00
139	1	3	10	28	44	1	15:00:00	16:30:00
140	1	3	10	192	45	1	16:40:00	18:10:00
141	1	3	10	192	45	1	18:20:00	19:50:00
142	2	3	10	47	47	1	16:40:00	18:10:00
143	2	3	10	28	43	1	18:20:00	19:50:00
144	3	3	10	47	46	1	13:20:00	14:50:00
145	3	3	10	192	46	1	13:20:00	14:50:00
146	3	3	10	47	86	1	15:00:00	16:30:00
147	3	3	10	192	49	1	16:40:00	18:10:00
148	3	3	10	192	45	1	18:20:00	19:50:00
149	4	3	10	47	47	1	15:00:00	16:30:00
150	4	3	10	47	87	1	16:40:00	18:10:00
151	4	3	10	47	88	1	18:20:00	19:50:00
152	5	3	10	47	86	1	15:00:00	16:30:00
153	5	3	10	47	87	1	16:40:00	18:10:00
154	5	3	10	47	88	1	18:20:00	19:50:00
155	4	4	23	194	103	15	11:00:00	13:30:00
\.


--
-- TOC entry 3516 (class 0 OID 1237837)
-- Dependencies: 236
-- Data for Name: student_presences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_presences (id, is_here, lesson_id, student_id) FROM stdin;
4	t	3	53
5	t	3	54
6	t	3	56
7	t	4	57
8	t	4	58
9	f	4	59
10	t	4	60
11	t	5	8
12	t	5	10
13	f	5	24
14	t	6	53
15	t	6	54
16	t	6	56
17	t	7	8
18	t	7	10
19	t	7	24
20	t	8	53
21	t	8	54
22	t	8	56
23	t	9	57
24	t	9	58
25	t	9	59
26	t	9	60
27	t	10	8
28	f	10	10
29	t	10	24
30	f	11	53
31	t	11	54
32	t	11	56
33	t	12	8
34	t	12	10
35	t	12	24
36	t	13	53
37	t	13	54
38	f	13	56
39	t	14	57
40	t	14	58
41	f	14	59
42	t	14	60
43	t	15	8
44	t	15	10
45	f	15	24
46	t	16	53
47	t	16	54
48	t	16	56
49	t	17	8
50	t	17	10
51	t	17	24
52	f	18	8
53	t	18	10
54	t	18	24
55	t	19	53
56	t	19	54
57	f	19	56
58	t	20	8
59	t	20	10
60	f	20	24
61	f	21	53
62	t	21	54
63	t	21	56
64	f	22	57
65	t	22	58
66	t	22	59
67	t	22	60
68	t	23	8
69	t	23	10
70	t	23	24
71	t	24	53
72	t	24	54
73	t	24	56
74	t	25	8
75	t	25	10
76	t	25	24
77	t	25	61
78	t	26	8
79	t	26	10
80	t	26	24
81	t	26	61
82	t	27	53
83	f	27	54
84	t	27	56
85	t	28	57
86	t	28	58
87	t	28	59
88	f	28	60
89	t	29	8
90	f	29	10
91	t	29	24
92	t	29	61
\.


--
-- TOC entry 3518 (class 0 OID 1237841)
-- Dependencies: 238
-- Data for Name: student_project_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_project_links (student_id, project_id, role) FROM stdin;
8	12	Создатель проекта
10	12	Фронтендер
\.


--
-- TOC entry 3519 (class 0 OID 1237844)
-- Dependencies: 239
-- Data for Name: student_quantum_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_quantum_links (student_id, quantum_id, is_free) FROM stdin;
8	9	t
10	9	t
24	9	t
8	4	f
53	9	t
62	9	t
54	9	t
57	9	t
63	9	t
65	9	t
58	9	t
66	9	t
59	9	t
61	9	t
67	9	t
60	9	t
100	4	t
139	5	t
125	4	t
140	5	t
97	4	t
158	14	t
111	4	t
172	2	t
101	4	t
174	2	t
130	5	t
152	14	t
98	4	t
156	14	t
116	4	t
146	5	t
99	4	t
153	14	t
126	4	t
92	4	t
151	14	t
135	5	t
93	4	t
179	11	t
84	4	t
102	4	t
117	4	t
118	4	t
166	2	t
119	4	t
120	4	t
176	2	t
173	2	t
141	5	t
137	5	t
143	5	t
177	11	t
164	14	t
147	5	t
145	5	t
91	4	t
72	9	t
124	4	t
110	4	t
82	9	t
155	14	t
123	4	t
81	9	t
163	14	t
136	5	t
80	9	t
96	4	t
109	4	t
169	2	t
74	9	t
90	4	t
95	4	t
157	14	t
89	4	t
159	14	t
56	9	t
75	9	t
76	9	t
160	14	t
131	5	t
171	2	t
161	14	t
104	4	t
77	9	t
70	9	t
150	14	t
86	4	t
105	4	t
78	9	t
112	4	t
122	4	t
106	4	t
168	2	t
134	5	t
129	5	t
154	14	t
165	14	t
170	2	t
175	2	t
127	4	t
68	9	t
113	4	t
87	4	t
148	5	t
114	4	t
138	5	t
132	5	t
162	14	t
133	5	t
144	5	t
69	9	t
107	4	t
88	4	t
142	5	t
71	9	t
94	4	t
79	9	t
108	4	t
115	4	t
73	9	t
180	13	t
181	13	t
182	13	t
183	13	t
185	13	t
184	13	t
186	13	t
187	12	t
188	12	t
189	12	t
190	12	t
195	23	t
195	19	f
\.


--
-- TOC entry 3520 (class 0 OID 1237847)
-- Dependencies: 240
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (user_id, phone, patronymic, birthdate, group_id, quantorium_id) FROM stdin;
10	+7 (994) 801-49-76	Геннадьевна	2016-04-28	1	3
24	+7 (906) 204-71-36	Эдуардович	2013-10-25	1	3
8	+7 (981) 723-31-73	Дмитриевич	2015-04-24	1	3
54	+7 (982) 841-76-91	Сергеевич	2013-05-24	2	3
53	+7 (952) 924-47-31	Федорович	2012-01-20	2	3
56	+7 (997) 850-48-39	Андреевич	2015-12-19	2	3
57	+7 (989) 823-62-97	Константинович	2011-04-08	3	3
58	+7 (952) 713-38-40	Вадимович	2012-08-01	3	3
59	+7 (908) 145-56-76	Ильинична	2018-05-26	3	3
60	+7 (996) 186-20-18	Александровна	2017-09-06	3	3
61	+7 (948) 279-42-91	Николаевич	2014-10-08	1	3
62	+7 (956) 640-11-30	Сергеевич	2016-05-09	5	3
63	+7 (939) 761-55-72	Ильич	2013-08-23	5	3
65	+7 (923) 770-57-67	Александровна	2013-05-19	5	3
66	+7 (950) 711-85-94	Александрович	2012-02-04	5	3
67	+7 (990) 851-42-80	Михайлович	2014-03-04	63	3
68	+7 (956) 905-28-88	Михайловна	2012-02-19	63	3
69	+7 (928) 191-99-52	Алексеевич	2014-10-12	63	3
70	+7 (986) 591-68-46	Юрьевич	2017-12-04	64	3
71	+7 (939) 439-39-47	Михайлович	2017-09-26	64	3
72	+7 (943) 935-19-67	Михайлович	2014-09-07	65	3
73	+7 (939) 989-34-82	Александровна	2014-09-02	6	3
74	+7 (948) 167-53-66	Евгеньевич	2015-07-23	6	3
75	+7 (925) 574-92-34	Сергеевич	2018-04-03	65	3
76	+7 (948) 669-20-39	Андреевна	2014-05-04	65	3
77	+7 (951) 731-95-52	Дмитриевич	2013-07-04	64	3
78	+7 (919) 329-96-93	Иванович	2017-06-04	67	3
79	+7 (917) 484-51-37	Игоревич	2018-05-28	67	3
80	+7 (988) 529-95-79	Алексеевич	2013-09-19	66	3
81	+7 (914) 558-37-69	Сергеевич	2014-02-26	66	3
82	+7 (907) 959-82-44	Андреевич	2014-11-18	66	3
84	+7 (911) 675-27-83	Дмитриевич	2010-11-16	7	3
86	+7 (994) 500-54-45	Александровна	2011-02-18	7	3
87	+7 (971) 782-44-66	Павловна	2011-05-16	7	3
88	+7 (992) 372-36-44	Максимович	2009-01-28	69	3
89	+7 (997) 286-23-53	Алексеевич	2009-04-17	69	3
90	+7 (936) 383-95-53	Юрьевич	2010-03-24	69	3
91	+7 (953) 339-19-38	Дмитриевич	2011-12-05	71	3
92	+7 (983) 618-50-73	Александрович	2018-12-10	71	3
93	+7 (934) 350-82-35	Андреевич	2019-02-12	71	3
94	+7 (968) 118-42-27	Акбарович	2013-01-02	70	3
95	+7 (952) 957-38-36	Сергеевич	2012-04-23	70	3
96	+7 (920) 287-63-86	Александрович	2010-11-25	70	3
97	+7 (988) 788-36-81	Михайлович	2018-01-27	9	3
98	+7 (980) 645-79-78	Константинович	2012-06-21	9	3
99	+7 (908) 186-25-61	Иванович	2013-08-15	9	3
100	+7 (931) 774-86-46	Петрович	2017-10-10	8	3
101	+7 (989) 510-59-47	Станиславович	2012-10-22	8	3
102	+7 (949) 802-81-44	Эдуардович	2015-03-16	8	3
103	+7 (986) 822-58-84	Денисович	2010-05-05	10	3
104	+7 (939) 488-21-30	Сергеевич	1971-12-04	10	3
105	+7 (994) 559-66-66	Сергеевна	1976-01-11	10	3
106	+7 (935) 725-88-32	Алексеевич	1983-11-26	68	3
107	+7 (924) 124-90-45	Романовна	1985-10-01	68	3
108	+7 (978) 899-93-16	Кириллович	1975-06-26	68	3
109	+7 (980) 663-28-14	Юрьевна	1973-05-17	13	3
110	+7 (936) 674-93-68	Александрович	1986-07-14	13	3
111	+7 (934) 645-79-34	Игоревич	1990-06-03	13	3
112	+7 (993) 973-25-10	Алексеевна	1968-02-11	14	3
113	+7 (931) 807-11-10	Владиславович	1963-11-14	13	3
114	+7 (960) 210-28-62	Сергеевич	1974-09-12	14	3
115	+7 (957) 555-79-80	Максимович	1973-02-24	14	3
116	+7 (966) 407-84-22	Константинович	1991-08-13	72	3
117	+7 (985) 340-68-53	Сергеевич	1972-06-22	72	3
118	+7 (948) 883-81-88	Дмитриевич	1985-01-21	72	3
119	+7 (942) 538-74-53	Дмитриевич	1987-10-03	11	3
120	+7 (942) 538-74-53	Николаевна	1989-02-12	11	3
122	+7 (977) 828-18-90	Александрович	1968-11-17	11	3
123	+7 (973) 841-58-53	Сергеевна	1993-04-14	11	3
124	+7 (952) 751-88-65	Дмитриевич	1965-03-01	11	3
125	+7 (933) 700-18-20	Сергеевич	1964-10-02	12	3
126	+7 (956) 626-37-82	Максимович	1993-07-04	12	3
127	+7 (959) 409-66-87	Михайлович	1961-05-17	12	3
129	+7 (987) 373-27-35	Юрьевич	1987-02-17	15	3
130	+7 (964) 967-71-58	Якововна	1968-11-03	15	3
131	+7 (981) 467-29-56	Григорьевна	1974-04-12	16	3
132	+7 (945) 137-77-83	Степанович	1982-05-22	16	3
133	+7 (995) 730-42-21	Иванович	1971-06-01	17	3
134	+7 (922) 385-37-99	Данилович	1972-05-17	17	3
135	+7 (913) 872-22-20	Себастьянович	1993-04-14	21	3
136	+7 (919) 930-11-19	Кирилловна	1995-09-02	21	3
137	+7 (955) 828-84-47	Якововна	1960-04-23	22	3
138	+7 (917) 112-17-95	Ефимовна	1981-07-08	74	3
139	+7 (928) 474-21-69	Климентьевич	1975-06-09	74	3
140	+7 (978) 674-23-27	Георгиевич	1991-11-27	22	3
141	+7 (992) 338-20-32	Нифонтович	1963-12-10	19	3
142	+7 (959) 813-88-41	Никифорович	1973-04-28	19	3
143	+7 (983) 861-33-26	Сергеевна	1990-01-27	20	3
144	+7 (997) 961-82-24	Александровна	1968-02-12	20	3
145	+7 (983) 488-10-15	Климентьевич	1986-02-01	18	3
146	+7 (952) 754-46-61	Марковна	1968-11-26	18	3
147	+7 (917) 819-45-97	Яковлевич	1984-06-23	23	3
148	+7 (980) 507-79-34	Вячеславович	1978-04-10	23	3
150	+7 (983) 784-31-31	Филиппович	1966-02-10	26	3
151	+7 (995) 963-92-77	Фадеевна	1978-04-23	26	3
152	+7 (982) 182-57-97	Николаевич	1986-07-12	75	3
157	+7 (927) 617-94-64	Тимофеевна	1985-10-23	25	3
160	+7 (966) 380-35-13	Лаврентиич	1975-02-21	57	3
153	+7 (994) 163-16-81	Максимович	1965-08-13	75	3
158	+7 (968) 115-39-48	Данииловна	1988-12-24	27	3
154	+7 (934) 278-31-50	Макаровна	1984-09-12	24	3
159	+7 (910) 576-19-21	Марковна	1990-01-21	27	3
155	+7 (943) 309-79-45	Трофимовна	1995-07-14	24	3
156	+7 (953) 267-84-96	Дмитриевич	1996-09-10	25	3
161	+7 (937) 235-53-65	Макарович	1984-05-11	57	3
162	+7 (966) 718-57-78	Макарович	1974-11-11	56	3
163	+7 (930) 803-36-44	Максимович	1969-11-07	56	3
164	+7 (964) 778-78-14	Валентиновна	1975-03-24	55	3
165	+7 (925) 207-74-18	Валерьевна	1968-12-14	55	3
166	+7 (988) 979-10-62	Максимович	1978-02-18	30	3
168	+7 (968) 842-86-55	Ираклиевна	1964-07-11	77	3
169	+7 (917) 788-14-15	Севастьяновна	1990-03-05	76	3
170	+7 (970) 346-20-85	Степановна	1993-10-01	28	3
171	+7 (963) 401-26-19	Петрович	1966-02-02	29	3
172	+7 (999) 476-78-41	Семенович	1982-09-01	31	3
173	+7 (961) 275-63-27	Александрович	1983-07-11	32	3
174	+7 (926) 863-74-86	Антоновна	1980-12-26	32	3
175	+7 (957) 137-76-83	Вячеславовна	1986-06-17	33	3
176	+7 (947) 865-82-21	Яковна	1981-12-12	34	3
177	+7 (961) 868-14-38	Антонович	1967-05-19	61	3
179	+7 (909) 835-27-32	Петрович	1984-01-13	62	3
180	+7 (908) 507-34-75	Трофимовна	1963-08-07	60	3
181	+7 (911) 706-21-63	Васильевич	1993-03-03	58	3
182	+7 (910) 610-13-21	Ефимовна	1975-12-06	59	3
183	+7 (947) 532-91-15	Кирилловна	1974-02-17	78	3
184	+7 (981) 897-13-47	Вячеславович	1988-09-12	79	3
185	+7 (916) 694-18-46	Никаноровна	1983-07-11	80	3
186	+7 (917) 203-24-79	Прокльев	1977-03-12	81	3
187	+7 (976) 214-62-32	Герасимович	1996-08-25	51	3
188	+7 (919) 856-61-14	Климентьевна	1977-05-07	52	3
189	+7 (930) 465-82-32	Трофимович	1965-09-17	53	3
190	+7 (989) 659-66-63	Венедиктович	1990-01-02	54	3
195	+7 (985) 990-76-18	Никифоровна	2018-09-03	103	4
\.


--
-- TOC entry 3521 (class 0 OID 1237850)
-- Dependencies: 241
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (user_id, phone, patronymic, birthdate, quantorium_id, quantum_id) FROM stdin;
28	+7 (910) 627-30-69	Анатольевич	1991-08-13	3	9
30	+7 (910) 352-24-42	Васильевич	1967-02-27	3	4
33	+7 (946) 277-98-51	Валерьевна	1975-09-11	3	5
34	+7 (997) 411-42-98	Сергеевич	1963-07-03	3	5
37	+7 (908) 367-12-34	Алексеевна	1965-09-01	3	14
38	+7 (955) 119-32-80	Климентьевна	1975-09-20	3	2
40	+7 (986) 627-26-49	Анатольевна	1991-09-20	3	2
42	+7 (949) 313-80-70	Сергеевич	1975-01-17	3	3
43	+7 (992) 303-64-44	Александрович	1960-01-05	3	3
44	+7 (929) 861-89-94	Анатольевич	1962-10-03	3	3
47	+7 (998) 616-67-38	Алексеевич	1996-10-22	3	10
48	+7 (941) 581-64-53	Евгеньевич	1964-04-04	3	11
49	+7 (953) 340-22-61	Васильевич	1976-06-26	3	13
50	+7 (922) 864-29-45	Александровна	1974-04-23	3	13
51	+7 (933) 658-76-38	Ивановна	1973-03-08	3	12
52	+7 (988) 518-28-93	Анатольевич	1988-04-21	3	9
23	+7 (923) 620-33-55	Юрьевна	1982-04-11	3	9
32	+7 (996) 301-82-87	Валерьевич	1974-11-12	3	4
31	+7 (918) 857-66-71	Николаевич	1964-09-01	3	4
83	+7 (935) 550-34-96	Сергеевич	1992-01-18	3	4
35	+7 (972) 738-12-84	Алексеевич	1960-03-21	3	5
36	+7 (978) 247-35-81	Сергеевна	1971-01-10	3	14
149	+7 (922) 339-31-23	Николаевна	1965-05-16	3	14
191	+7 (913) 970-77-19	Алексеевна	1988-05-12	3	12
45	+7 (975) 554-20-93	Николаевич	1972-04-17	3	3
192	+7 (993) 436-61-21	Владимирович	1976-05-10	3	10
194	+7 (943) 684-93-73	Севастьяновна	1971-01-20	4	23
\.


--
-- TOC entry 3522 (class 0 OID 1237853)
-- Dependencies: 242
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, firstname, lastname, email, hashed_password, created_at, role_id, img) FROM stdin;
24	Константин	Захарянц	leonid1978@mail.ru	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-07 21:23:19.732676	4	\N
8	Артем	Бабичук	katsumiproo@gmail.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-04-24 14:34:04.049924	4	\N
10	Анастасия	Воронина	userr@example.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-04-28 18:24:27.998684	4	\N
15	Мария	Фокина	jarofe2765@goulink.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-06 11:42:10.39107	2	{"token": "44920bafc1ec240b0b7c4d1291d8d0307e3e28ea6d8808a84bf37a3f4638975a8300d66e6a2bd106d5bd", "name": "f2b66ef15305b4c00e1ff0ee0.jpg", "size": 126497, "originalFilename": "ol9aiY4d85BUPkHWHQfbEg_mWVFHPf_nRIfuW1hJ3dfr68WXUPwxqYjzD_Bl2mW32O9bX6zxnF9suHJxc7K9y4JO.jpg", "createdAt": "2024-05-06T19:57:24.333Z", "mimeType": "image/jpeg", "deleteToken": "a0ee995912543f3da2fb"}
21	Раиса	Фарышева	yowipes113@goulink.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-06 20:06:46.797565	2	{"token": "e560943ca2580d12acebad2f37916d93212f04661f56d53644f06e0d5a16b075982a41e301af85c263e8", "name": "f2b66ef15305b4c00e1ff0eeb.png", "size": 690415, "originalFilename": "3d-illustration-of-a-female-doctor-in-a-white-cap-and-glasses.png", "createdAt": "2024-05-06T20:06:49.811Z", "mimeType": "image/png", "deleteToken": "d67ff775ea6997a417db"}
28	Павел	Третьяков	danila13081991@ya.ru	$2b$12$KWwiK/zWAGjbrsVSE.iBCeVhJ3YVL8haatC.8YK2U1xdjMeeq4lzq	2024-05-10 11:37:59.021555	3	\N
30	Денис	Евдокимов	georgiy27021967@gmail.com	$2b$12$QrYgmRq0J4pEKtm.2bG1sOos6jmytBxoLWoC7MFDONL5Oo6soP3vS	2024-05-10 11:39:38.544804	3	\N
33	Наталья	Дектерева	zoya1975@hotmail.com	$2b$12$KL6pF39.y.t9DSp9L.5sqO2UIYVHFSuka02EgwE7r0uYiJJxr5Q5y	2024-05-10 11:57:57.285743	3	\N
34	Сергей	Тарасов	sevastyan03071963@outlook.com	$2b$12$tmRYA5eMemmvgooziCFNnuItInM/4nnl3dXr5ebKZM1awzb9RTKqe	2024-05-10 11:58:33.051156	3	\N
37	Юлия	Меркулова	oksana.muhametova@mail.ru	$2b$12$4xT0BJI7WtzyIe13QFMOvOBX2l0GDNL75sBwfZMD2ksckctaovkMy	2024-05-10 12:02:27.741785	3	\N
38	Екатерина	Титаева	zinaida31@yandex.ru	$2b$12$QCxO67oqnBSLkdnjiuQ24.PxHyaYQaT8h0r9p.QQoVkQZ5gbfZix6	2024-05-10 12:03:59.644912	3	\N
40	Клара	Уткина	raisa9427@yandex.ru	$2b$12$fJGiiA5DMP7oywDEXyAw0eTmz1JEvlQWJ/RFrFbKm.oPxqu4gd2Xi	2024-05-10 12:06:39.094071	3	\N
42	Михаил	Бараев	aleksandr1975@mail.ru	$2b$12$V15sHPbiM5vWkx6jxgoeluDyVDc2PXtRQNgk3ihqyT20ILH33BX1.	2024-05-10 12:09:55.384452	3	\N
43	Максим	Гришин	anton1960@ya.ru	$2b$12$ZQjZIRd63W20ORz1qlrpueaOWY8tHFQMRbjgtbdA2nQ/sZdfkobJC	2024-05-10 12:11:11.943229	3	\N
44	Евгений	Пичугин	nikolay4901@gmail.com	$2b$12$6kor0YOQ0uqPJWBSUISBdutrcAvk6qe63LRgciG6maCb/byqgzfcu	2024-05-10 12:11:49.160721	3	\N
47	Константин	Фадеев	yuriy1996@outlook.com	$2b$12$N56U.6HtUzpiAnUGJNLjmO2ZZvNPD7XXjbR4CBntMigMiqdvEgzl.	2024-05-10 12:13:50.664759	3	\N
48	Олег	Чирков	evgeniy4388@rambler.ru	$2b$12$KWg2dyd3A6ytes0Iz8XE/ONr07ESlmISE5GDDNQhaHVKxdXQEMPt2	2024-05-10 12:14:40.960396	3	\N
50	Валентина	Рубцова	elena1712@yandex.ru	$2b$12$eDt3RJT6FDrsAu631OjC1.IGsK5ktYK1qnHv15nx0PuIJwsS.5Iha	2024-05-10 12:16:22.931485	3	\N
51	Алина	Зотеева	anastasiya08031973@gmail.com	$2b$12$mpKLQvRQaqrfP1Y0OxZjz.1LhU4Bk9lM3dNY7L1tKzAY.h90O11eu	2024-05-10 12:18:06.614101	3	\N
23	Светлана	Иванова	maryamna87@rambler.ru	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-07 18:30:27.329861	3	{"token": "809b9a06efb4743bfd462cb77f2f0efd254a7dff5e3990bec4c287e1f1a73fc815258cd8d25fc35d8e0f", "name": "ab06d6784c1da094e2f17af79.png", "size": 378142, "originalFilename": "\\u0411\\u0435\\u0437 \\u0438\\u043c\\u0435\\u043d\\u0438.png", "createdAt": "2024-05-10T18:00:10.844Z", "mimeType": "image/png", "deleteToken": "69d7fd37aa5bb67daf97"}
49	Алексей	Мишин	filipp26061976@hotmail.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-10 12:15:30.36591	3	\N
52	Анатолий	Панфилов	konstantin21041988@outlook.com	$2b$12$0EUImy.eR50MY7wqvZJlceyumO5v6zzJ6MgwnQxPwBGKnSCgNfYLO	2024-05-10 20:53:02.598541	3	\N
53	Илья	Анкудинов	kirill.malafeev@rambler.ru	$2b$12$DyhiAr/.rkAYiqy8UDWagOi1FT0121dDcSY0kQ4jxqRStbImldzwa	2024-05-11 16:24:26.136105	4	\N
54	Матвей	Афанасьев	fedot24051977@ya.ru	$2b$12$JDjTxTO2SG/iaWLGAtWiweQPl1L9NLK9AFlExT7rOih1pA6/bEZP2	2024-05-11 16:25:04.18948	4	\N
56	Илья	Зубавин	makar1975@hotmail.com	$2b$12$DV28xhzxDwUwazZ0z6A25upUgeC0O0E2Ce3eU5/lES2ZGEd332Ykm	2024-05-11 16:26:20.785991	4	\N
57	Константин	Вашкевич	maksim10121966@rambler.ru	$2b$12$3WUPqyLdfiFM6236gnwlwe9iCo8GAvN0.XKNWXmD/Mtaqo1ymQ7KG	2024-05-11 16:27:58.508915	4	\N
58	Андрей	Кириленко	lavrentiy01081992@outlook.com	$2b$12$J/tSHLP/vBAKWSLHXUDk6Of7RjefpEAEVqsowuN8ondborR6cpy5q	2024-05-11 16:28:27.549532	4	\N
59	Александра	Мартьянова	milana1968@outlook.com	$2b$12$yp.wSB.FcX1CnvLWvYPUuO2Wg6KdRbWi1ZfLJXWdL9C1ccUk/oa.u	2024-05-11 16:29:04.263242	4	\N
60	Дарья	Рябова	katerina.vyazmitina@ya.ru	$2b$12$lZSX/ua1bu48ec0x6IXwoeQ8ocKnp3KeImuvrwosWQJcUTRomnzi.	2024-05-11 16:29:32.907539	4	\N
61	Артем	Мяков	valentin.avelskiy@hotmail.com	$2b$12$Ke10YWUcCQG6JJkII6dRRe33FP8Tow0PAadA3TZ0EoWcP0ZLJfGyC	2024-05-11 19:51:48.655248	4	\N
62	Богдан	Анохин	ilya09051986@outlook.com	$2b$12$wGYp95QILlTGyEG7.MQgPOzWYIMtWWO4IR30EItxZneOR0G7wH1ue	2024-05-11 20:40:51.79107	4	\N
63	Семен	Горбунов	efim48@hotmail.com	$2b$12$mgxKBdh5mZscR6LiGGRlwuwEyCR2x28c.0OH0.2EobSUSfyodERWS	2024-05-11 20:41:26.619985	4	\N
65	Арина	Занозина	mila19051993@rambler.ru	$2b$12$u1ad6h28/NiQd8PrM6TrweMxgkUwMqLhpnrG5h08GcJNvTP9B5m1q	2024-05-11 20:41:55.092572	4	\N
31	Илья	Кропотов	makar01091964@yandex.ru	$2b$12$DYBwqZGKn0PBP4T6L4wdwemW4bdYxARJzwCYIcrCGkhiRVwOFAIPC	2024-05-10 11:40:45.618155	3	\N
35	Константин	Тутжаров	georgiy4789@ya.ru	$2b$12$a45GykMwj1ZS8HZc3ZmGR.9bzqlEB/pI8UJ7cmAYUIhhyp9ZeFenO	2024-05-10 11:59:25.520019	3	\N
36	Ирина	Лагунова	ekaterina8819@hotmail.com	$2b$12$.x/d4sCP6nFHHKNEQS.CreoXpBHfbbqSs0HqPRf4NlnRrmfWc1dne	2024-05-10 12:00:59.466016	3	\N
45	Иннокентий	Попов	nikita1972@mail.ru	$2b$12$xl35whs4e0daWOatyNvTyOzU7B1an8t5y6lS0g/wmhbF9Y2Q429yW	2024-05-10 12:12:34.048489	3	\N
66	Илья	Ковалев	yuriy1992@rambler.ru	$2b$12$MJL9RvkET.RPaOyaIWdZbOHnwIUyY57rxX5U98FOlX0djGxVeojMq	2024-05-11 20:42:29.090754	4	\N
67	Денис	Ручкин	david1984@mail.ru	$2b$12$WJjtmuxfML6oDOjLjqUx4eP0PZaed3mFzj39gWO9Pap/YZlMnzYri	2024-05-11 20:43:39.703869	4	\N
68	Анастасия	Ручкина	lyudmila19021982@hotmail.com	$2b$12$5tvZ8gVg1Fel5EQ2wfnPD.ig5CekY/oEbOfWGvZ.7RDfUxWc6pS.a	2024-05-11 20:47:03.240879	4	\N
69	Илья	Степанов	kuzma60@ya.ru	$2b$12$.0o45/VWWDQnTjYZpzkFpOLt89/8xJzut4YYhlHTzii05IJWkX2Lu	2024-05-11 20:49:04.245192	4	\N
70	Илья	Лукичев	egor1977@mail.ru	$2b$12$gHNmdjVjeajOgx9vo9mKUemPbZKOPBTXQwV/tbCcx/4b9Iuce/USq	2024-05-11 20:51:11.711644	4	\N
71	Егор	Сучков	efim26091977@mail.ru	$2b$12$VPzxdNpM50m5ykHQo6fazeHvCgYw4JCDvUlfaq2MQSe1ywZXxxCjG	2024-05-11 20:51:50.402213	4	\N
72	Сергей	Юров	trofim.yanson@yandex.ru	$2b$12$1iAx8h4q1xvif54sMSLAweeF1mD51l6KaDSa8kOgbY3HcW/pbG38S	2024-05-11 20:52:27.147786	4	\N
73	Мария	Усова	zoya1984@hotmail.com	$2b$12$lzUq5WbMvKR0KlRBDkaphO87BFUqIDFsowOUHB5LBHyYEOdqGFlXy	2024-05-11 20:53:20.700959	4	\N
74	Максим	Фурман	rostislav.krivkov@outlook.com	$2b$12$dtd0ENUDZ1roTrwfzQG3ee7hli5U0sjZSmj08ucZViQuEZZbgCL8i	2024-05-11 20:54:35.092833	4	\N
75	Александр	Комаров	rostislav.aksenov@yandex.ru	$2b$12$GSb5FjoTSKS5oyGpH1EIxecGJsR04pbhKe.066LHLCYZ824eC7eCq	2024-05-11 20:55:39.850972	4	\N
76	Ксения	Комова	veronika41@outlook.com	$2b$12$mWxWnOzOHaz9phl6B.rmd.KUlv1Ib.VGzeheVK6OnlNNUkKERIcOK	2024-05-11 20:56:05.977438	4	\N
77	Никита	Ломакин	savva04071963@outlook.com	$2b$12$O275ZdKL7tcvXKsMunrOjOVntnmL//W4gHtj89/d3Sk0zgl3f/pwe	2024-05-11 20:56:51.654299	4	\N
78	Константин	Михонин	yurin.baranov@yandex.ru	$2b$12$CPJjEfM6PI07r1q4V9P9QeTxNiI7mUsVRprqZ9DrB6.BHOIZRVgca	2024-05-11 20:57:42.224891	4	\N
79	Никита	Тарасенко	anton9251@gmail.com	$2b$12$RjNe66dKdqlEFRWN83Y5VOZiUnZi0P64NJnUEISafUXerEdDfmEQq	2024-05-11 20:58:42.620145	4	\N
80	Иван	Чучков	ignat.slavakov@ya.ru	$2b$12$Tmb6sstf8UyD2m5iizsFquNBA3uf6tFTZfGwB8t9jgtoVC1ErtX0K	2024-05-11 20:59:14.271533	4	\N
81	Денис	Шиенко	aleksandr1974@hotmail.com	$2b$12$t0Elw9HmchX9qaXi5uGuJeDRAv1KWJwaUpoo9y2zYxbQLMyTJZm1G	2024-05-11 20:59:43.14608	4	\N
82	Фёдор	Шихирев	fedot.avdeev@mail.ru	$2b$12$m7.fUx9Kz2GgFoLVjfKQD.1.zL9i0a3PdzgczWc7/RFMjiA75GI/W	2024-05-11 21:00:20.070424	4	\N
32	Дмитрий	Васильев	afanasiy1974@mail.ru	$2b$12$fitCLtgfhHxbr269YhZ2j.G4xsEmvzn/1Goo7jKXlIZMR0s5nhWcG	2024-05-10 11:56:50.285816	3	\N
83	Александр	Щелоков	mihail79@hotmail.com	$2b$12$RfbRYBjuNWfWH56//Q5RuuNSzbKpMO6ADVPmZH9V27BgzkWhtT1qG	2024-05-11 21:24:45.418113	3	\N
84	Егор	Жарский	ivan2820@gmail.com	$2b$12$DOy2b6nIB4PMmYB7ZuCtcuWwvEZvV8sqVe5eVQdB7SbAvQNxm.3M6	2024-05-11 22:28:23.036635	4	\N
86	Юлиана	Малова	ekaterina1961@ya.ru	$2b$12$90CUUkcDKr4OygH9bau/ZOFYiBRExsJX/Zr42hsEe1KMN8JgwLP7G	2024-05-11 22:29:15.492634	4	\N
87	Александра	Савельева	katerina.yashvili@rambler.ru	$2b$12$uSplkVk/L5AMVxPV1Ed2z.hr./OnrnOddxRrNrV5ZO3jhUyIebQPa	2024-05-11 22:29:50.902278	4	\N
88	Иван	Суглицкий	trofim.korakov@ya.ru	$2b$12$.ueTFgNmFCLiqLxkduqjounPgSsZtzBjQPaUBw6R8wH2jXUvDV/MC	2024-05-11 22:31:12.426897	4	\N
89	Максим	Фалин	filipp1969@yandex.ru	$2b$12$TJ0d3LUzEFqE5D/Q63P8UuFkBJih6QXgeEqQr.7qHShNMIwnatade	2024-05-11 22:31:45.078286	4	\N
90	Александр	Филькин	vitaliy.telicyn@ya.ru	$2b$12$2wWZeIkzFxjAoOECKD/7uuz00WFUnFWdrupNqb1t2GTTAZJNUiuSC	2024-05-11 22:32:12.341481	4	\N
91	Александр	Щегольков	grigoriy.kolokolcov@outlook.com	$2b$12$zfbr7EZoKxCeed8Rw27p0e3mkk1TWaZSUgHCD28/invMKmxQeBc9G	2024-05-11 22:33:13.808222	4	\N
92	Николай	Долков	trofim1978@mail.ru	$2b$12$cm.FbjBmdxDLOAS1WUC5YudueScVqbwq7aVHvCcTf7knjmN.8.pgW	2024-05-11 22:33:41.88196	4	\N
93	Антон	Евтеев	vasiliy81@yandex.ru	$2b$12$XRDpda6Uq4/CotSmFWrJsOaHpCRAa6QwzQtACHnv.SH5K5ims2T/S	2024-05-11 22:34:13.434252	4	\N
94	Амирбек	Тагиров	semen22@gmail.com	$2b$12$BiD1eX/NTOGsgNmm9FH.qedPFJcRKGjjYeKJN6egoQtpQinU4K4NW	2024-05-11 22:34:40.027004	4	\N
95	Константин	Федько	egor8610@hotmail.com	$2b$12$Uv3rIK2c7nHAIJH3SfoBluM8ZtsRlNcFar88qfD/D7foJdS/GjK0e	2024-05-11 22:35:08.749841	4	\N
96	Макар	Цивиков	valentin1990@ya.ru	$2b$12$C/doxArgTcirHqra4esCPOIZiLxRQ6C9JjuqWJziGhmSXhkrVS9Ee	2024-05-11 22:35:38.908823	4	\N
97	Захар	Безруков	vitaliy1680@ya.ru	$2b$12$JDBEIC.0MNOdeDikiZT20.gvKWxqwFlAc2yXzhbjuqBaRf.I8QLv2	2024-05-11 22:36:09.294874	4	\N
98	Константин	Вашкевич	ilya9312@gmail.com	$2b$12$byFHT5Jm5wKHfYQSCyKRzeOPOTrVcUiqCcrrkADpKI.Zwx2fX0w8.	2024-05-11 22:36:31.946365	4	\N
99	Егор	Григорьев	efrem4561@hotmail.com	$2b$12$aSQXE8n2fjwncWYVVLHl9esx7YKCgM79L4xf3fpJHt1AT9f9P01We	2024-05-11 22:36:55.550241	4	\N
100	Егор	Алексеев	vasiliy1987@outlook.com	$2b$12$yVBFtN9QBP/OSGEd/DpGYuOntR1WqAQjRmOMAwFHDsXo3Tu88PMte	2024-05-11 22:37:32.046052	4	\N
101	Вадим	Бондаровский	taras22101982@gmail.com	$2b$12$cihAu.myB/k9r0xAF02kAe3OFMICoaCq5bhnJ4gr7LH5PRgvT5i8q	2024-05-11 22:37:58.480413	4	\N
102	Никита	Закиров	valeriy1995@yandex.ru	$2b$12$Q1CF2P1faSf5gISlKrYQ6OLcNQMShXtyAerHAZWoM8ar5lQrKsSRG	2024-05-11 22:38:20.873241	4	\N
103	Демьян	Кульков	fedor25@mail.ru	$2b$12$7YRo1FfAjv7Ij.bLqD6cF.YzEnFQe9g0qudYT3jTCBoNNRomLfAHm	2024-05-11 22:39:36.119504	4	\N
104	Владислав	Ложкин	kirill.vyalicyn@mail.ru	$2b$12$wKKg7lR//bZq.D4DEJw93.Ala9vp.VCiQ3DXDTp8Plfxkr0KjrTwG	2024-05-11 22:40:15.670684	4	\N
105	Алёна	Маркелова	kira.basmanova@yandex.ru	$2b$12$3UkRkHt1G3Agl.FUQyx98eAx4Foq0WrRH2FGZ3gzX4JFMKORbaulW	2024-05-11 22:40:47.224554	4	\N
106	Иван	Ногинов	sergey26111983@hotmail.com	$2b$12$964eg2ujaGtoYRoRSMaLfukF7yxK.qCGmWUW3GGU5B8N4DZyigaom	2024-05-11 22:41:35.021845	4	\N
107	Елизавета	Суворова	alena5999@outlook.com	$2b$12$8lpjzaaQAwVhiK4LfGV4peF.HUD5xVxa0y0dybqmmCxO7ibhimcky	2024-05-11 22:42:28.252887	4	\N
108	Лев	Тарасов	kuzma26061975@ya.ru	$2b$12$4ZaUyXpvnQrW8XjTthTrOuGMU.qJGhV4nkmPkIbcr4p2tQfVcbEmW	2024-05-11 22:42:48.473414	4	\N
109	Елизавета	Цветова	yuliya86@mail.ru	$2b$12$mbcYmc9mUvHrVbYzBoPhOui3wWDoRk9ug6rKZSyoylW3kIeEhJ2Km	2024-05-11 22:43:49.402115	4	\N
110	Иван	Шурыгин	yurin7717@outlook.com	$2b$12$miz4mN1CbZoLw/c87q28IuqezF5EWU6ruDioyEvldC4xmeY9pTPnK	2024-05-11 22:44:25.46397	4	\N
111	Никита	Берников	maksim.tretyakov@yandex.ru	$2b$12$YZP1XpgrYMX3QKfgYAAQmuAapoJ5WrbIEnNSJ/u2t/ZEfaNrq0vAO	2024-05-11 22:44:57.247839	4	\N
112	Анна	Никифорова	valentina9501@gmail.com	$2b$12$aAgw1aRf3nt70yPKLMTemer7wRIUSlpb6QGyjnv2qpjJ8XRKRF02u	2024-05-11 22:45:23.863479	4	\N
113	Артемий	Рындин	sergey14111963@outlook.com	$2b$12$4yvCHPDZJq44Br8sntXKUOWWK9JnEeDkvZtHdnY2B9o0BHqXKrSPS	2024-05-11 22:45:50.252286	4	\N
114	Станислав	Сагайдак	zahar12091974@ya.ru	$2b$12$28mWw/iwCS/VlkWBEny14ecEy0G40xAJNLhhmtq1qFPDJd7T2Mhwy	2024-05-11 22:46:30.399867	4	\N
117	Никита	Зубанов	dmitriy1972@ya.ru	$2b$12$ULUzaxvXkhDndIsIeCjW8uVzwiBIBy6rCKMuP1XrAxicz.FwJd5Si	2024-05-11 22:49:38.551744	4	\N
115	Арсений	Терентьев	roman56@gmail.com	$2b$12$0g8v04Eb6jEDg.MVMhR9K.ZVrBvx4tnKOdgHRUuhk3zgnZwz4orZi	2024-05-11 22:46:53.666695	4	\N
116	Александр	Гладышев	vasiliy1991@gmail.com	$2b$12$zf4xL.0Y4KGoUILVINB1euuMqNXGjVFWGRLfZooSrfqCwSo2kUsm.	2024-05-11 22:49:14.471788	4	\N
118	Виктор	Иванов	yurin2484@rambler.ru	$2b$12$jWw1jFvZlvJqtJvYpSHVx./sHtGQGqLAJou1DNxzgE6uqcosH2LDa	2024-05-11 22:50:03.579013	4	\N
119	Григорий	Карпов	nikolay43@outlook.com	$2b$12$6teHRcu0KNKaNuAzXt0zi..sP8otM07DFsJrZgcwkTNoGa8VLU2XO	2024-05-11 22:50:26.94216	4	\N
120	Анастасия	Киляшова	veronika12021989@hotmail.com	$2b$12$Cxmb.RjwRlt2dg4bqyTmB.jcxVNEUL.b/j/Yjo6v/WtNSg9dwZ/Vq	2024-05-11 22:51:00.663123	4	\N
122	Андрей	Николаев	georgiy5165@yandex.ru	$2b$12$6qwfmG7RVzpArJp8lVToUeyglpllMHa0sE53ixn9b43gd9Z6S0iDm	2024-05-11 22:51:31.135095	4	\N
123	Анна	Шилова	anjela1278@mail.ru	$2b$12$prj.WmSiex70POCYEgJvZ.xEA6O3TMLKsp2bIDzE3BbOmZbzyS4Ty	2024-05-11 22:51:51.964591	4	\N
124	Тимофей	Шушунов	anton.kuksyuk@ya.ru	$2b$12$DxID7Lg36qD7oAFGBc4YauKd24zCyJTVkXQ71DAh.ZfR0Lyae6yIC	2024-05-11 22:52:21.215912	4	\N
125	Никита	Аникин	egor4020@outlook.com	$2b$12$z1gwZYCa.lSJa5Jrdd.TXuR1de1QnqWN8DjXHlD3buFyYPuev/GMm	2024-05-11 22:52:59.732272	4	\N
126	Андрей	Дербенев	semen40@gmail.com	$2b$12$IXrJ19qHWc96ILhCPk84wePGlxSsFTxkPF7RGwMXWDjDJ0lhe5oOi	2024-05-11 22:53:21.028199	4	\N
127	Леонид	Рубинштейн	pavel17051961@yandex.ru	$2b$12$DHrBFLu/9GFh3DTwzl2Afu2GxTQ5HNGo32vXyk0lfE/dMVsSM9Ysi	2024-05-11 22:53:43.442853	4	\N
129	Георгий	Пахомов	georgiy1649@mail.ru	$2b$12$ygNT7E8ouhcgrv6l3hCugese0542Bxg6sQtGP7Lm6RlxQU3BQI5fW	2024-05-11 23:26:23.257394	4	\N
130	Виктория	Букирь	viktoriya.bukir@hotmail.com	$2b$12$ZW.shZXcgv3NS0BguO0x/e8JcWJUjZITJ1IzB./.nAZLrXWldAZxK	2024-05-11 23:26:48.071288	4	\N
131	Ярослава	Курпатова	yaroslava.kurpatova@hotmail.com	$2b$12$ITATZDU.9gLbVXthDyFu7u5DpZGt0I.RoOK9kMOJzSaV05ajd/P9S	2024-05-11 23:27:18.985224	4	\N
132	Валентин	Саламатов	valentin1982@rambler.ru	$2b$12$hul8lXm.fx0X.r9ux/GOre9qsH7TKRyO12BqYjwkXXEHwAa5gWLhS	2024-05-11 23:27:43.244523	4	\N
133	Ефим	Серпионов	efim94@yandex.ru	$2b$12$2uw1teSvsBnrWQHHIX/SUuG5BXdFFRpBSdhdQ1iG4uqDneAkKIljW	2024-05-11 23:28:03.807986	4	\N
134	Арсений	Осминин	arseniy33@yandex.ru	$2b$12$3fI2isZtHa2elo.w.Nk4petTPvKAy/mVoRzKQcs096JL9JhhkAW.i	2024-05-11 23:28:30.895076	4	\N
135	Лаврентий	Дудко	lavrentiy82@rambler.ru	$2b$12$shNQd4.rTQktDMbQ/53C.umvtmYCnTUy05QbTsrPSJSRI.4ifTbUq	2024-05-11 23:29:15.582507	4	\N
136	Катерина	Шевелёка	katerina.eveleka@gmail.com	$2b$12$tf2YHuxreUYWgZYHQrjBuumylc4tjZPS0l0iHAgKJuYBSHVt0r9SS	2024-05-11 23:29:35.797954	4	\N
137	Галина	Коломийцева	galina23@rambler.ru	$2b$12$Q.5zlJ2V9yEzyuqVmg8vz.ey1jwUFaruoVbhb4qTRaI7iOmaNoQ9m	2024-05-11 23:29:58.003288	4	\N
138	Алина	Сайтахметова	alina18@gmail.com	$2b$12$1Wos5Jx3SKUPYR9jS/rKxeUVtClsQrrkL7OCYTYUJ3Zhxb3MhGQHS	2024-05-11 23:30:20.932202	4	\N
139	Антон	Андреев	anton30@gmail.com	$2b$12$H.HBR7seCJuQT8OVjEr5EO.95f5Q43QV6le46.ZvJOrzeIBsCDU1q	2024-05-11 23:30:42.875233	4	\N
140	Иннокентий	Аристархов	innokentiy.aristarhov@ya.ru	$2b$12$M2xLUIBDQiErI.m/a74tz.H6gM9tB1gbcyPIPxFfLssGiy7rdF4.a	2024-05-11 23:31:08.950266	4	\N
141	Павел	Колиух	pavel.koliuh@ya.ru	$2b$12$WdImXzYLtxL4sBbIo0J.3uk9C0M.ZzCvLV3smvfBanoHW1eU20Fsy	2024-05-11 23:31:47.666198	4	\N
142	Николай	Сурков	nikolay1973@yandex.ru	$2b$12$l06sPzFqurGv6IxjeZE3fO8m2mqUbTwtZZSvrvpO5dSzAxM6MHRsm	2024-05-11 23:32:09.359405	4	\N
143	Рада	Коромыслова	rada.koromyslova@gmail.com	$2b$12$ewk2bwHUPHtbZYfEy2sufeij4brn/tJ/j.inpXQ5oLLckIsqeaFae	2024-05-11 23:32:28.794006	4	\N
144	Ева	Снегирева	eva6583@gmail.com	$2b$12$Z0AZ.nwwNd77IeoQ7UTZveMi6BU2SD67Mw24LpcnrWrjCkDmCtwyS	2024-05-11 23:32:54.882397	4	\N
145	Семен	Янишевский	semen4455@hotmail.com	$2b$12$pYtSuCfxsRHkT29mTQle3utvXci2kpT8bk3NdvjgUT6ZEwU/kXREu	2024-05-11 23:33:28.975769	4	\N
146	Светлана	Горяинова	svetlana7836@ya.ru	$2b$12$kjuAPf5BFozJJ/2hj4.JBOU8Nw5UVC/Um3u87VUsYkBZyVe6RSLGe	2024-05-11 23:33:46.902057	4	\N
147	Илья	Ярополов	ilya1984@hotmail.com	$2b$12$t/2ue8buqYgvU0EFB.tK5uGRFSiXn1MqkgAxGOaAweCFzzTYtB/ay	2024-05-11 23:34:06.072685	4	\N
148	Александр	Саврасов	aleksandr10041978@hotmail.com	$2b$12$zpwbny.osc8QUjq/rAbGf..u6Lc2d44JvR6CS4WraJR.BuKWDZgQS	2024-05-11 23:34:27.678272	4	\N
149	Ольга	Барочкина	pelageya1965@gmail.com	$2b$12$DHdLgNAxPxM3c826zskFA.yIS2lVYEJ15uDSIodJIG8odWDc6OIeq	2024-05-11 23:48:24.409395	3	\N
150	Максим	Луковников	maksim1966@outlook.com	$2b$12$zhRd0WnCFjPqro5J/bIFa.wZTNnnrsj5nfg.pmbHI3eKUnyafK2iO	2024-05-12 00:04:02.503336	4	\N
151	Екатерина	Достовалова	ekaterina.dostovalova@yandex.ru	$2b$12$g/13B9s6ZvZVMmJz.NBYLuCJ69prmZkCM/3JnWnuHfrRKv7GciIkG	2024-05-12 00:04:23.379981	4	\N
152	Георгий	Варенников	georgiy1986@mail.ru	$2b$12$aQTA.UhMi3gamCN353lpbemYB5DpeR6hiOJ5pLI5.6zzzKtbl7OBC	2024-05-12 00:04:47.239633	4	\N
153	Афанасий	Гроссман	afanasiy4117@hotmail.com	$2b$12$d8pcP8YPHGCHnLniXHyTeOdkDQGyHTkgNBfIURFzKieN/s47tiz/e	2024-05-12 00:05:07.049034	4	\N
154	Марина	Оропай	marina3490@hotmail.com	$2b$12$ZdE1Dyq86NMVy.FRkQKC4uqah8rBrtAJhXC9P8lvw4.x30dwb5myy	2024-05-12 00:05:49.682609	4	\N
155	Евгения	Шинская	evgeniya13@mail.ru	$2b$12$EM3Aa7iCIu1gEb/XP82BGeTRgs1acvH/yDz5ejf8L.pM/9EUab9ty	2024-05-12 00:06:14.780848	4	\N
156	Афанасий	Геремеш	afanasiy10091996@rambler.ru	$2b$12$mqmU056zfgdlG0e.OY/KAOsbkoxmihXb5WUxDKGhYWYC2UeC07hkq	2024-05-12 00:06:43.582727	4	\N
157	Анна	Фахриева	anna25@ya.ru	$2b$12$x4GdZvhHKs7d6Fa..BFthOvn3j/ug4bGapNw/ZQADJhO/m3mqsM8i	2024-05-12 00:07:48.745565	4	\N
158	Любовь	Белоконь	lyubov24121988@mail.ru	$2b$12$4qJBcgGeQe/W2RkOS3Pce.d9TA10KoTxpgHNdo.4MKtSqIfe8GXWa	2024-05-12 00:09:29.163573	4	\N
159	Жанна	Устимовича	janna.ustimovicha@gmail.com	$2b$12$ZVUPkufZUS7uXe/lsFOBZu4FQ2ydSes9YyHEQgm3LK/TUQlokZCAO	2024-05-12 00:09:49.006311	4	\N
160	Василий	Курбонмамадов	vasiliy.kurbonmamadov@rambler.ru	$2b$12$NdvVMOAbqZ6f035OevCA8eM48qnYYf408lC5R/QmHlICxoAG7CkyW	2024-05-12 00:10:14.517954	4	\N
161	Юлиан	Лелух	yulian.leluh@ya.ru	$2b$12$f2Gusqbmvjf0NAJ3olGBNOWYamNql.giZOiiC9uOJPItUK4Nel5Ny	2024-05-12 00:10:41.236004	4	\N
162	Валентин	Свистовский	valentin.svistovskiy@yandex.ru	$2b$12$eytnm5LigjytLn5OeSZYhutaxAmJF85JkU/v86uYynEOSmAfD7aS6	2024-05-12 00:12:04.895357	4	\N
163	Максим	Шеин	maksim07111969@ya.ru	$2b$12$Cg5zgjbJwVFtYzF4K.a9EO6EAhThFuT6BmML7l.dI6E8Ff5zHJrYy	2024-05-12 00:12:33.730389	4	\N
164	Арина	Краева	arina8026@yandex.ru	$2b$12$dpd6M.S.b.QpxsFQ8mNLceWr0NU1y/1XDBNcM1vguhDzkvdYir4Wy	2024-05-12 00:12:53.281728	4	\N
165	Нина	Перешивкина	nina2402@yandex.ru	$2b$12$y/lRapSTlt0ao55PnWWui.YXuAeVW9ghu/KO1Ks4lA31dh4rM3jiW	2024-05-12 00:13:13.637146	4	\N
166	Иван	Камбаров	ivan1978@yandex.ru	$2b$12$V/THLSnQaWyQs0oPTRFUyeSgClqaOFD19H8DebWaw2fUe8k5QpDEu	2024-05-12 00:35:41.820479	4	\N
168	Оксана	Огаркова	oksana4566@mail.ru	$2b$12$Mhnk8olZejPArhDLLiy2x.Qj7M99Z6lRh5elh7KrorZd0ZsFOZ9H.	2024-05-12 00:36:12.255626	4	\N
169	Валерия	Хорошавцева	valeriya05031990@yandex.ru	$2b$12$IJzioOG4JkawQuWOgO.eTeKZQvTJ11nkIvX4HKAB4mcjfaFyqIe7i	2024-05-12 00:36:44.923387	4	\N
170	Любовь	Полевщикова	lyubov01101993@outlook.com	$2b$12$F6d8XNpLV21vTszhpthdfegcXpS1ML5xNIf3qV/IEWiWdx4R2Fo3e	2024-05-12 00:37:36.521988	4	\N
175	Арина	Разудалова	arina.razudalova@mail.ru	$2b$12$FMEX2uMzTEq2RRLV4ydD2u4LZ14YP8hgewZ49GYu8iiRgth3iUcaa	2024-05-12 00:39:40.929485	4	\N
171	Кузьма	Кылымнык	kuzma02021966@yandex.ru	$2b$12$Hlm9mY0DXrP7VnfxZnqwhes3WBEB8ZEk7V31iJh6xhvQkTVUHJrem	2024-05-12 00:38:01.859444	4	\N
174	Марина	Борисюка	marina4327@mail.ru	$2b$12$gADc.uyssXdJwdoC1hQjzuQBEK5y4tvamtHpTFzE0t0iDH.lTCaOS	2024-05-12 00:39:19.843841	4	\N
179	Валерий	Еремеев	valeriy94@ya.ru	$2b$12$fqpBt/A8YN09IIq6usUogOzo8Sc9pwKtXUG0b/Ht7MUZCyj72nSxW	2024-05-12 01:01:41.808701	4	\N
182	Александра	Баскакова	aleksandra4312@rambler.ru	$2b$12$YIX47foDmHslhPabK/WpcO4ElD5lGeGqjLXGbemrcTwQspt7HQZxu	2024-05-12 01:37:02.657125	4	\N
172	Петр	Богомолов	petr01091982@gmail.com	$2b$12$.9X3YzkeDppfKZsC.aTxeeCgduFuUuupsLU6laJc1wWuwOb4WJ5t6	2024-05-12 00:38:24.807267	4	\N
177	Валерий	Корсаков	valeriy30@hotmail.com	$2b$12$lK1b.TsQ8zw3lyLIygfYU.SIHFpYZSHlY4q//7XGrgjFVObSXyJ62	2024-05-12 01:01:16.694648	4	\N
180	Анфиса	Щавлева	anfisa4987@rambler.ru	$2b$12$Sof5jQdqx/VfpRVk//Eo9uHU/qCsqzFTgszqkYrksM0PKAn6GbrJO	2024-05-12 01:35:47.017121	4	\N
173	Алексей	Кодица	aleksey1983@hotmail.com	$2b$12$jaXci9at622eM8dHeuhQDOtYKjUTpJTMeGdMvSipSJR9S1ApkQ58y	2024-05-12 00:38:58.555219	4	\N
176	Ника	Кобзева	nika94@ya.ru	$2b$12$31o6UH2FwqTxdqnKjAbVue9uQWRWZnd7qH7t0ZI9yRqKAagKaWn9u	2024-05-12 00:40:02.036816	4	\N
181	Юрий	Янзинов	yuriy4276@outlook.com	$2b$12$W4o3nsis191pSo28GS6vYuYhodluHqN0SMOMPRzYAhgsN0sAd2dBG	2024-05-12 01:36:21.033867	4	\N
183	Римма	Новожилова	rimma1974@rambler.ru	$2b$12$eC.coyFJBDk12yBvDBfCeOin4j8JWhQa8noHCMHEQ1oWkxlzib63.	2024-05-12 01:38:18.00753	4	\N
184	Николай	Амалиев	nikolay5840@yandex.ru	$2b$12$nyLx/jLXtWBq1S6LRUSl7.7TDlI7ShfoUqU37PituJjBXT.K3NzEa	2024-05-12 01:39:11.074316	4	\N
185	Анастасия	Шигина	anastasiya11071983@rambler.ru	$2b$12$89/SjzESgDvHpZ55V6G1JuOEdBHIq1BG3mGpZluZfeK6MfVRGOP6u	2024-05-12 01:39:31.910161	4	\N
186	Антон	Истомин	anton1977@outlook.com	$2b$12$bHm5QzFdsLt.YVSTdWGI6OsjWzTAFK3oAbXUCLEch1aRmBPSXSKgC	2024-05-12 01:40:55.167604	4	\N
187	Кирилл	Староверов	kirill9358@ya.ru	$2b$12$5VzHCyosaQOcD/x3In1KAuLh3YhjS/KT4HfvsayMnXwAxwplaqp2S	2024-05-12 02:51:55.536807	4	\N
188	Марианна	Ермолина	marianna.ermolina@hotmail.com	$2b$12$4L9BmkeeBzn9OJWk9WKa6OR7PDAGs8jFmzjfQkM2sYey2IYMUS7BK	2024-05-12 02:52:31.376118	4	\N
189	Ростислав	Другаков	rostislav18@mail.ru	$2b$12$NoUJsd0M.w7pGPFzU3kgmOiyFCsWnT.Y1Jx2ltNFX8Ig2GmgCHRvW	2024-05-12 02:53:08.567887	4	\N
190	Юрий	Кудрявцев	yuriy2914@mail.ru	$2b$12$jirWuK35ez4ikRqIN90qWeSawdDo0rkEM3yzb2auo9cuWfCLQPISW	2024-05-12 02:53:39.02313	4	\N
191	Дарья	Шмейлина	nika90@outlook.com	$2b$12$49cHsGpFiQtFkst5JaLNd.qqcdcJyiUh.376HokfEo9ALfXTNSqMW	2024-05-12 02:57:03.123545	3	\N
192	Сергей	Килин	sergey.kidin@ya.ru	$2b$12$sE.g3x1l8aH1nvk8bSGJiucl8R9BIxDKTraFL9hErYPF2QN.USvGa	2024-05-12 13:54:45.80571	3	\N
194	Марьяна	Богоявленская	titice5236@godsigma.com	$2b$12$QYtct1RGfmZeOHw1Ub1FVubbDPyoaofe72Bt4EAmR08oeFoDhB4o2	2024-05-15 11:08:44.573271	3	{"token": "23c7a6625635fc2979c4222d8a009dff2b7faad512a2d48f7c73441c3be24a79cfd8b39ce5945ffbee0c", "name": "f0259b8dfa24979d8ca487e94.png", "size": 330067, "originalFilename": "EWS2AOD49YMFFSTAO7H3_1714578670139.png", "createdAt": "2024-05-15T08:09:00.838Z", "mimeType": "image/png", "deleteToken": "787cbac756f61eb5bd1c"}
195	Алла	Тевосова	cahike8200@godsigma.com	$2b$12$abhpcMWvs5j2/iqgHYwu4./Ng.ElUvx6ghUidJdr6c2SmA8YvyuYW	2024-05-15 11:09:50.078866	4	{"token": "43f0525dd277ef580dacee159fb663019aa758292f7902306fcc44b252b2f3fcfa112e9315fc85f41db5", "name": "f0259b8dfa24979d8ca487e96.jpeg", "size": 61777, "originalFilename": "1709935773065_6TICO9A32RLSV6B2MAVZ.jpeg", "createdAt": "2024-05-15T08:09:58.193Z", "mimeType": "image/jpeg", "deleteToken": "330a6688e3c2da373bf6"}
1	Мария	Фокина	m.fokina2020@mail.ru	$2b$12$N7hMnx6E65kycyeDS86t9.xvL1X3NGIE9PHDFk5AyqzqmybBobWRm	2023-08-11 19:55:29.263782	1	{"token": "88121cda857867beb617fd279432dab9fe567ab5154081dc089adeec435c0bca8460b2c5c78fbdda4fc7", "name": "f0259b8dfa24979d8ca487e9f.jpg", "size": 640232, "originalFilename": "FCVehDEihZ4.jpg", "createdAt": "2024-05-15T08:38:01.495Z", "mimeType": "image/jpeg", "deleteToken": "300071ce1e23ab5d6fa7"}
\.


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 211
-- Name: education_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_materials_id_seq', 12, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 213
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 107, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 215
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 29, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 217
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_id_seq', 29, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 219
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 221
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 13, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 223
-- Name: quantoriums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quantoriums_id_seq', 6, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 225
-- Name: quantums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quantums_id_seq', 24, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 227
-- Name: reasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reasons_id_seq', 13, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 231
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 233
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 18, true);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 235
-- Name: schedule_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_items_id_seq', 155, true);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 237
-- Name: student_presences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_presences_id_seq', 92, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 243
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 195, true);


--
-- TOC entry 3272 (class 2606 OID 1237874)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3274 (class 2606 OID 1237876)
-- Name: education_materials education_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_materials
    ADD CONSTRAINT education_materials_pkey PRIMARY KEY (id);


--
-- TOC entry 3276 (class 2606 OID 1237878)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 1237880)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 3280 (class 2606 OID 1237882)
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 1237884)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 1237886)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 1237888)
-- Name: quantoriums quantoriums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantoriums
    ADD CONSTRAINT quantoriums_pkey PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 1237890)
-- Name: quantums quantums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantums
    ADD CONSTRAINT quantums_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 1237892)
-- Name: reasons reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reasons
    ADD CONSTRAINT reasons_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 1237894)
-- Name: recoveries recoveries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recoveries
    ADD CONSTRAINT recoveries_pkey PRIMARY KEY (code);


--
-- TOC entry 3294 (class 2606 OID 1237896)
-- Name: representatives representatives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3296 (class 2606 OID 1237898)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 1237900)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 1237902)
-- Name: schedule_items schedule_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 1237904)
-- Name: student_presences student_presences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_presences
    ADD CONSTRAINT student_presences_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 1237906)
-- Name: student_project_links student_project_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_project_links
    ADD CONSTRAINT student_project_links_pkey PRIMARY KEY (student_id, project_id);


--
-- TOC entry 3306 (class 2606 OID 1237908)
-- Name: student_quantum_links student_quantum_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_quantum_links
    ADD CONSTRAINT student_quantum_links_pkey PRIMARY KEY (student_id, quantum_id);


--
-- TOC entry 3308 (class 2606 OID 1237910)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3310 (class 2606 OID 1237912)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3312 (class 2606 OID 1237914)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3314 (class 2606 OID 1237916)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 1237917)
-- Name: admins admins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3316 (class 2606 OID 1237922)
-- Name: education_materials education_materials_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_materials
    ADD CONSTRAINT education_materials_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(user_id);


--
-- TOC entry 3317 (class 2606 OID 1237927)
-- Name: groups groups_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3318 (class 2606 OID 1237932)
-- Name: lessons lessons_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3319 (class 2606 OID 1237937)
-- Name: lessons lessons_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3320 (class 2606 OID 1237942)
-- Name: lessons lessons_quantum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_quantum_id_fkey FOREIGN KEY (quantum_id) REFERENCES public.quantums(id);


--
-- TOC entry 3321 (class 2606 OID 1237947)
-- Name: lessons lessons_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(user_id);


--
-- TOC entry 3322 (class 2606 OID 1237952)
-- Name: news news_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3323 (class 2606 OID 1237957)
-- Name: notes notes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3324 (class 2606 OID 1237962)
-- Name: projects projects_quantum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_quantum_id_fkey FOREIGN KEY (quantum_id) REFERENCES public.quantums(id);


--
-- TOC entry 3325 (class 2606 OID 1237967)
-- Name: projects projects_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(user_id);


--
-- TOC entry 3326 (class 2606 OID 1237972)
-- Name: quantums quantums_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantums
    ADD CONSTRAINT quantums_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3327 (class 2606 OID 1237977)
-- Name: reasons reasons_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reasons
    ADD CONSTRAINT reasons_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3328 (class 2606 OID 1237982)
-- Name: recoveries recoveries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recoveries
    ADD CONSTRAINT recoveries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3329 (class 2606 OID 1237987)
-- Name: representatives representatives_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3330 (class 2606 OID 1237992)
-- Name: representatives representatives_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3331 (class 2606 OID 1237997)
-- Name: rooms rooms_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3332 (class 2606 OID 1238002)
-- Name: schedule_items schedule_items_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3333 (class 2606 OID 1238007)
-- Name: schedule_items schedule_items_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3334 (class 2606 OID 1238012)
-- Name: schedule_items schedule_items_quantum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_quantum_id_fkey FOREIGN KEY (quantum_id) REFERENCES public.quantums(id);


--
-- TOC entry 3335 (class 2606 OID 1238017)
-- Name: schedule_items schedule_items_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- TOC entry 3336 (class 2606 OID 1238022)
-- Name: schedule_items schedule_items_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_items
    ADD CONSTRAINT schedule_items_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(user_id);


--
-- TOC entry 3337 (class 2606 OID 1238027)
-- Name: student_presences student_presences_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_presences
    ADD CONSTRAINT student_presences_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 3338 (class 2606 OID 1238032)
-- Name: student_presences student_presences_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_presences
    ADD CONSTRAINT student_presences_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(user_id);


--
-- TOC entry 3339 (class 2606 OID 1238037)
-- Name: student_project_links student_project_links_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_project_links
    ADD CONSTRAINT student_project_links_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3340 (class 2606 OID 1238042)
-- Name: student_project_links student_project_links_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_project_links
    ADD CONSTRAINT student_project_links_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(user_id);


--
-- TOC entry 3341 (class 2606 OID 1238047)
-- Name: student_quantum_links student_quantum_links_quantum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_quantum_links
    ADD CONSTRAINT student_quantum_links_quantum_id_fkey FOREIGN KEY (quantum_id) REFERENCES public.quantums(id);


--
-- TOC entry 3342 (class 2606 OID 1238052)
-- Name: student_quantum_links student_quantum_links_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_quantum_links
    ADD CONSTRAINT student_quantum_links_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(user_id);


--
-- TOC entry 3343 (class 2606 OID 1238057)
-- Name: students students_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3344 (class 2606 OID 1238062)
-- Name: students students_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3345 (class 2606 OID 1238067)
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3346 (class 2606 OID 1238072)
-- Name: teachers teachers_quantorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_quantorium_id_fkey FOREIGN KEY (quantorium_id) REFERENCES public.quantoriums(id);


--
-- TOC entry 3347 (class 2606 OID 1238077)
-- Name: teachers teachers_quantum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_quantum_id_fkey FOREIGN KEY (quantum_id) REFERENCES public.quantums(id);


--
-- TOC entry 3348 (class 2606 OID 1238082)
-- Name: teachers teachers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3349 (class 2606 OID 1238087)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2024-05-15 13:38:58

--
-- PostgreSQL database dump complete
--

