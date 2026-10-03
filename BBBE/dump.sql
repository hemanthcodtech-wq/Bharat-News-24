--
-- PostgreSQL database dump
--

\restrict sYhCexgIJvAstEZn3zRCcQxHrjwW4gJsf5D1NMJfkZNutsnQiOPH8dO1zdHHlmG

-- Dumped from database version 18.6 (4e955f5)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_parent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.breaking_news DROP CONSTRAINT IF EXISTS breaking_news_article_id_fkey;
ALTER TABLE IF EXISTS ONLY neon_auth.session DROP CONSTRAINT IF EXISTS "session_userId_fkey";
ALTER TABLE IF EXISTS ONLY neon_auth.member DROP CONSTRAINT IF EXISTS "member_userId_fkey";
ALTER TABLE IF EXISTS ONLY neon_auth.member DROP CONSTRAINT IF EXISTS "member_organizationId_fkey";
ALTER TABLE IF EXISTS ONLY neon_auth.invitation DROP CONSTRAINT IF EXISTS "invitation_organizationId_fkey";
ALTER TABLE IF EXISTS ONLY neon_auth.invitation DROP CONSTRAINT IF EXISTS "invitation_inviterId_fkey";
ALTER TABLE IF EXISTS ONLY neon_auth.account DROP CONSTRAINT IF EXISTS "account_userId_fkey";
DROP INDEX IF EXISTS neon_auth.verification_identifier_idx;
DROP INDEX IF EXISTS neon_auth."session_userId_idx";
DROP INDEX IF EXISTS neon_auth.organization_slug_uidx;
DROP INDEX IF EXISTS neon_auth."member_userId_idx";
DROP INDEX IF EXISTS neon_auth."member_organizationId_idx";
DROP INDEX IF EXISTS neon_auth."invitation_organizationId_idx";
DROP INDEX IF EXISTS neon_auth.invitation_email_idx;
DROP INDEX IF EXISTS neon_auth."account_userId_idx";
ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_slug_key;
ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_pkey;
ALTER TABLE IF EXISTS ONLY public.epapers DROP CONSTRAINT IF EXISTS epapers_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_slug_key;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY public.breaking_news DROP CONSTRAINT IF EXISTS breaking_news_pkey;
ALTER TABLE IF EXISTS ONLY public.advertisements DROP CONSTRAINT IF EXISTS advertisements_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_email_key;
ALTER TABLE IF EXISTS ONLY neon_auth.verification DROP CONSTRAINT IF EXISTS verification_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth."user" DROP CONSTRAINT IF EXISTS user_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth."user" DROP CONSTRAINT IF EXISTS user_email_key;
ALTER TABLE IF EXISTS ONLY neon_auth.session DROP CONSTRAINT IF EXISTS session_token_key;
ALTER TABLE IF EXISTS ONLY neon_auth.session DROP CONSTRAINT IF EXISTS session_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.project_config DROP CONSTRAINT IF EXISTS project_config_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.project_config DROP CONSTRAINT IF EXISTS project_config_endpoint_id_key;
ALTER TABLE IF EXISTS ONLY neon_auth.organization DROP CONSTRAINT IF EXISTS organization_slug_key;
ALTER TABLE IF EXISTS ONLY neon_auth.organization DROP CONSTRAINT IF EXISTS organization_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.member DROP CONSTRAINT IF EXISTS member_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.jwks DROP CONSTRAINT IF EXISTS jwks_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.invitation DROP CONSTRAINT IF EXISTS invitation_pkey;
ALTER TABLE IF EXISTS ONLY neon_auth.account DROP CONSTRAINT IF EXISTS account_pkey;
ALTER TABLE IF EXISTS public.news ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.epapers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.breaking_news ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.advertisements ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_users ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.news_id_seq;
DROP TABLE IF EXISTS public.news;
DROP SEQUENCE IF EXISTS public.epapers_id_seq;
DROP TABLE IF EXISTS public.epapers;
DROP SEQUENCE IF EXISTS public.categories_id_seq;
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public.breaking_news_id_seq;
DROP TABLE IF EXISTS public.breaking_news;
DROP SEQUENCE IF EXISTS public.advertisements_id_seq;
DROP TABLE IF EXISTS public.advertisements;
DROP SEQUENCE IF EXISTS public.admin_users_id_seq;
DROP TABLE IF EXISTS public.admin_users;
DROP TABLE IF EXISTS neon_auth.verification;
DROP TABLE IF EXISTS neon_auth."user";
DROP TABLE IF EXISTS neon_auth.session;
DROP TABLE IF EXISTS neon_auth.project_config;
DROP TABLE IF EXISTS neon_auth.organization;
DROP TABLE IF EXISTS neon_auth.member;
DROP TABLE IF EXISTS neon_auth.jwks;
DROP TABLE IF EXISTS neon_auth.invitation;
DROP TABLE IF EXISTS neon_auth.account;
DROP SCHEMA IF EXISTS neon_auth;
--
-- Name: neon_auth; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA neon_auth;


ALTER SCHEMA neon_auth OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" uuid NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamp with time zone,
    "refreshTokenExpiresAt" timestamp with time zone,
    scope text,
    password text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE neon_auth.account OWNER TO neondb_owner;

--
-- Name: invitation; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.invitation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    email text NOT NULL,
    role text,
    status text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "inviterId" uuid NOT NULL
);


ALTER TABLE neon_auth.invitation OWNER TO neondb_owner;

--
-- Name: jwks; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.jwks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "publicKey" text NOT NULL,
    "privateKey" text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "expiresAt" timestamp with time zone
);


ALTER TABLE neon_auth.jwks OWNER TO neondb_owner;

--
-- Name: member; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.member (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL
);


ALTER TABLE neon_auth.member OWNER TO neondb_owner;

--
-- Name: organization; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.organization (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    logo text,
    "createdAt" timestamp with time zone NOT NULL,
    metadata text
);


ALTER TABLE neon_auth.organization OWNER TO neondb_owner;

--
-- Name: project_config; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.project_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    endpoint_id text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    trusted_origins jsonb NOT NULL,
    social_providers jsonb NOT NULL,
    email_provider jsonb,
    email_and_password jsonb,
    allow_localhost boolean NOT NULL,
    plugin_configs jsonb,
    webhook_config jsonb
);


ALTER TABLE neon_auth.project_config OWNER TO neondb_owner;

--
-- Name: session; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.session (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "userId" uuid NOT NULL,
    "impersonatedBy" text,
    "activeOrganizationId" text
);


ALTER TABLE neon_auth.session OWNER TO neondb_owner;

--
-- Name: user; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "emailVerified" boolean NOT NULL,
    image text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role text,
    banned boolean,
    "banReason" text,
    "banExpires" timestamp with time zone
);


ALTER TABLE neon_auth."user" OWNER TO neondb_owner;

--
-- Name: verification; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.verification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE neon_auth.verification OWNER TO neondb_owner;

--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash text NOT NULL,
    role character varying(50) DEFAULT 'admin'::character varying,
    allowed_categories integer[] DEFAULT '{}'::integer[],
    reset_code character varying(10),
    reset_code_expires_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.admin_users OWNER TO neondb_owner;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_id_seq OWNER TO neondb_owner;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: advertisements; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.advertisements (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    image_url text NOT NULL,
    link_url text,
    "position" character varying(50) DEFAULT 'sidebar'::character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.advertisements OWNER TO neondb_owner;

--
-- Name: advertisements_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.advertisements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advertisements_id_seq OWNER TO neondb_owner;

--
-- Name: advertisements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.advertisements_id_seq OWNED BY public.advertisements.id;


--
-- Name: breaking_news; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.breaking_news (
    id integer NOT NULL,
    title text NOT NULL,
    article_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.breaking_news OWNER TO neondb_owner;

--
-- Name: breaking_news_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.breaking_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.breaking_news_id_seq OWNER TO neondb_owner;

--
-- Name: breaking_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.breaking_news_id_seq OWNED BY public.breaking_news.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    slug character varying(150) NOT NULL,
    parent_id integer,
    sort_order integer DEFAULT 0,
    show_in_header boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.categories OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: epapers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.epapers (
    id integer NOT NULL,
    title character varying(255) DEFAULT 'Main Edition'::character varying NOT NULL,
    published_date date NOT NULL,
    cover_image text,
    pdf_url text,
    pages integer DEFAULT 1,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.epapers OWNER TO neondb_owner;

--
-- Name: epapers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.epapers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.epapers_id_seq OWNER TO neondb_owner;

--
-- Name: epapers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.epapers_id_seq OWNED BY public.epapers.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.news (
    id integer NOT NULL,
    title text NOT NULL,
    slug character varying(255) NOT NULL,
    content text,
    excerpt text,
    image text,
    author character varying(150),
    category_id integer,
    is_published boolean DEFAULT true,
    is_trending boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    status character varying(20) DEFAULT 'approved'::character varying,
    created_by integer,
    rejection_reason text
);


ALTER TABLE public.news OWNER TO neondb_owner;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_id_seq OWNER TO neondb_owner;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: advertisements id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.advertisements ALTER COLUMN id SET DEFAULT nextval('public.advertisements_id_seq'::regclass);


--
-- Name: breaking_news id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.breaking_news ALTER COLUMN id SET DEFAULT nextval('public.breaking_news_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: epapers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.epapers ALTER COLUMN id SET DEFAULT nextval('public.epapers_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.account (id, "accountId", "providerId", "userId", "accessToken", "refreshToken", "idToken", "accessTokenExpiresAt", "refreshTokenExpiresAt", scope, password, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.invitation (id, "organizationId", email, role, status, "expiresAt", "createdAt", "inviterId") FROM stdin;
\.


--
-- Data for Name: jwks; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.jwks (id, "publicKey", "privateKey", "createdAt", "expiresAt") FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.member (id, "organizationId", "userId", role, "createdAt") FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.organization (id, name, slug, logo, "createdAt", metadata) FROM stdin;
\.


--
-- Data for Name: project_config; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.project_config (id, name, endpoint_id, created_at, updated_at, trusted_origins, social_providers, email_provider, email_and_password, allow_localhost, plugin_configs, webhook_config) FROM stdin;
b2b4def2-84e6-4040-b733-dbb21b70c671	Shabdham	ep-royal-glitter-ay4yk28m	2026-08-14 20:34:43.302+00	2026-08-14 20:34:43.302+00	[]	[{"id": "google", "isShared": true}]	{"type": "shared"}	{"enabled": true, "disableSignUp": false, "emailVerificationMethod": "otp", "requireEmailVerification": false, "autoSignInAfterVerification": true, "sendVerificationEmailOnSignIn": false, "sendVerificationEmailOnSignUp": false}	t	{"magicLink": {"config": {"expiresIn": 5, "disableSignUp": false}, "enabled": false}, "phoneNumber": {"config": {"otp_expires_in": 300}, "enabled": false}, "organization": {"config": {"creatorRole": "owner", "membershipLimit": 100, "organizationLimit": 10, "sendInvitationEmail": false}, "enabled": true}}	{"enabled": false, "enabledEvents": [], "timeoutSeconds": 5}
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.session (id, "expiresAt", token, "createdAt", "updatedAt", "ipAddress", "userAgent", "userId", "impersonatedBy", "activeOrganizationId") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth."user" (id, name, email, "emailVerified", image, "createdAt", "updatedAt", role, banned, "banReason", "banExpires") FROM stdin;
\.


--
-- Data for Name: verification; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.verification (id, identifier, value, "expiresAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.admin_users (id, name, email, password_hash, role, allowed_categories, reset_code, reset_code_expires_at, created_at) FROM stdin;
1	Admin	admin@shabdhamtv.com	$2b$10$bEaz53h1TN6Mgj0INIuLc.6CHy3qxfKwFdnDRHrP9.cFXrO.Bezfy	superadmin	{}	\N	\N	2026-08-14 21:04:24.41248
3	Venkatesh	news.venkatesh2016@gmail.com	$2b$10$SEUqlDG1dFAB.VTq7Ih4JOCKFmrqIvydodxI8OLSSNJFyjY/CwTcK	employee	{2,71,75,79,83,87,91,95,99,72}	\N	\N	2026-08-30 02:51:19.693516
7	a	kancharlahemanth89@gmail.com	$2b$10$D7TYmn4N9KFL76FLyr93rON7dchCUvDpYWF/5kBzhe7t/lnZfd3Ti	employee	{2}	\N	\N	2026-09-02 12:16:46.589759
4	karan	mrkaran3376@gmail.com	$2b$10$MJyVw7KeQig1R.16bksAcOKkfv/3C4bVEY5c5PMHbqytfdQL1eAhG	employee	{2}	\N	\N	2026-08-30 02:53:09.279624
8	Admin	admin@bharath24news.com	$2b$10$s6Ros8PrMwE5EhquGyGVcu1vQjuvC1QRykRkXdDIgpUs3MoTi2Se6	superadmin	{}	\N	\N	2026-10-03 09:37:45.630597
\.


--
-- Data for Name: advertisements; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.advertisements (id, title, image_url, link_url, "position", is_active, created_at) FROM stdin;
\.


--
-- Data for Name: breaking_news; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.breaking_news (id, title, article_id, is_active, created_at) FROM stdin;
1	Hiii	\N	t	2026-10-03 09:46:41.615234
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.categories (id, name, slug, parent_id, sort_order, show_in_header, created_at) FROM stdin;
3	ఆంధ్రప్రదేశ్	andhra-pradesh	\N	2	t	2026-08-26 07:15:15.677157
5	అంతర్జాతీయం	international	\N	4	t	2026-08-26 07:15:15.677157
9	ఆరోగ్యం	health	\N	8	t	2026-08-26 07:15:15.677157
10	విద్య	education	\N	9	t	2026-08-26 07:15:15.677157
11	నేరాలు	crime	\N	10	t	2026-08-26 07:15:15.677157
12	అదిలాబాద్	adilabad	2	1	f	2026-08-26 07:15:15.677157
13	భద్రాద్రి కొత్తగూడెం	bhadradri-kothagudem	2	2	f	2026-08-26 07:15:15.677157
14	హనుమకొండ	hanumakonda	2	3	f	2026-08-26 07:15:15.677157
15	హైదరాబాద్	hyderabad	2	4	f	2026-08-26 07:15:15.677157
16	జగిత్యాల	jagtial	2	5	f	2026-08-26 07:15:15.677157
17	జనగాం	jangaon	2	6	f	2026-08-26 07:15:15.677157
18	జయశంకర్ భూపాలపల్లి	jayashankar-bhupalpally	2	7	f	2026-08-26 07:15:15.677157
19	జోగులాంబ గద్వాల	jogulamba-gadwal	2	8	f	2026-08-26 07:15:15.677157
20	కామారెడ్డి	kamareddy	2	9	f	2026-08-26 07:15:15.677157
21	కరీంనగర్	karimnagar	2	10	f	2026-08-26 07:15:15.677157
22	ఖమ్మం	khammam	2	11	f	2026-08-26 07:15:15.677157
23	కుమురం భీం ఆసిఫాబాద్	kumuram-bheem-asifabad	2	12	f	2026-08-26 07:15:15.677157
24	మహబూబాబాద్	mahabubabad	2	13	f	2026-08-26 07:15:15.677157
25	మహబూబ్‌నగర్	mahabubnagar	2	14	f	2026-08-26 07:15:15.677157
26	మంచిర్యాల	mancherial	2	15	f	2026-08-26 07:15:15.677157
27	మెదక్	medak	2	16	f	2026-08-26 07:15:15.677157
28	మేడ్చల్-మల్కాజ్‌గిరి	medchal-malkajgiri	2	17	f	2026-08-26 07:15:15.677157
29	ములుగు	mulugu	2	18	f	2026-08-26 07:15:15.677157
30	నాగర్‌కర్నూల్	nagarkurnool	2	19	f	2026-08-26 07:15:15.677157
31	నల్గొండ	nalgonda	2	20	f	2026-08-26 07:15:15.677157
32	నారాయణపేట	narayanpet	2	21	f	2026-08-26 07:15:15.677157
33	నిర్మల్	nirmal	2	22	f	2026-08-26 07:15:15.677157
34	నిజామాబాద్	nizamabad	2	23	f	2026-08-26 07:15:15.677157
35	పెద్దపల్లి	peddapalli	2	24	f	2026-08-26 07:15:15.677157
36	రాజన్న సిర్సిల్ల	rajanna-sircilla	2	25	f	2026-08-26 07:15:15.677157
37	రంగారెడ్డి	rangareddy	2	26	f	2026-08-26 07:15:15.677157
38	సంగారెడ్డి	sangareddy	2	27	f	2026-08-26 07:15:15.677157
39	సిద్దిపేట	siddipet	2	28	f	2026-08-26 07:15:15.677157
40	సూర్యాపేట	suryapet	2	29	f	2026-08-26 07:15:15.677157
41	వికారాబాద్	vikarabad	2	30	f	2026-08-26 07:15:15.677157
42	వనపర్తి	wanaparthy	2	31	f	2026-08-26 07:15:15.677157
43	వరంగల్	warangal	2	32	f	2026-08-26 07:15:15.677157
44	యాదాద్రి భువనగిరి	yadadri-bhuvanagiri	2	33	f	2026-08-26 07:15:15.677157
45	అల్లూరి సీతారామరాజు	alluri-sitharama-raju	3	1	f	2026-08-26 07:15:15.677157
46	అనకాపల్లి	anakapalli	3	2	f	2026-08-26 07:15:15.677157
47	అనంతపురము	ananthapuramu	3	3	f	2026-08-26 07:15:15.677157
48	అన్నమయ్య	annamayya	3	4	f	2026-08-26 07:15:15.677157
49	బాపట్ల	bapatla	3	5	f	2026-08-26 07:15:15.677157
50	చిత్తూరు	chittoor	3	6	f	2026-08-26 07:15:15.677157
51	తూర్పు గోదావరి	east-godavari	3	7	f	2026-08-26 07:15:15.677157
52	ఏలూరు	eluru	3	8	f	2026-08-26 07:15:15.677157
53	గుంటూరు	guntur	3	9	f	2026-08-26 07:15:15.677157
54	కాకినాడ	kakinada	3	10	f	2026-08-26 07:15:15.677157
55	కోనసీమ	konaseema	3	11	f	2026-08-26 07:15:15.677157
56	కృష్ణా	krishna	3	12	f	2026-08-26 07:15:15.677157
57	కర్నూలు	kurnool	3	13	f	2026-08-26 07:15:15.677157
58	నందయాల	nandyal	3	14	f	2026-08-26 07:15:15.677157
59	ఎన్టీఆర్	ntr	3	15	f	2026-08-26 07:15:15.677157
60	పల్నాడు	palnadu	3	16	f	2026-08-26 07:15:15.677157
61	పార్వతీపురం మన్యం	parvathipuram-manyam	3	17	f	2026-08-26 07:15:15.677157
62	ప్రకాశం	prakasam	3	18	f	2026-08-26 07:15:15.677157
63	శ్రీ బాలాజీ	sri-balaji	3	19	f	2026-08-26 07:15:15.677157
64	శ్రీ సత్యసాయి	sri-sathya-sai	3	20	f	2026-08-26 07:15:15.677157
65	శ్రీకాకుళం	srikakulam	3	21	f	2026-08-26 07:15:15.677157
66	తిరుపతి	tirupati	3	22	f	2026-08-26 07:15:15.677157
67	విశాఖపట్నం	visakhapatnam	3	23	f	2026-08-26 07:15:15.677157
68	విజయనగరం	vizianagaram	3	24	f	2026-08-26 07:15:15.677157
69	పశ్చిమ గోదావరి	west-godavari	3	25	f	2026-08-26 07:15:15.677157
70	వైఎస్సార్ కడప	ysr-kadapa	3	26	f	2026-08-26 07:15:15.677157
71	రాజకీయం	national-politics	4	1	f	2026-08-26 07:15:15.677157
72	ఆర్థికం	national-economy	4	2	f	2026-08-26 07:15:15.677157
73	న్యాయం	national-judiciary	4	3	f	2026-08-26 07:15:15.677157
74	రక్షణ	national-defence	4	4	f	2026-08-26 07:15:15.677157
75	ఆసియా	asia	5	1	f	2026-08-26 07:15:15.677157
76	అమెరికా	america	5	2	f	2026-08-26 07:15:15.677157
77	యూరప్	europe	5	3	f	2026-08-26 07:15:15.677157
78	మిడిల్ ఈస్ట్	middle-east	5	4	f	2026-08-26 07:15:15.677157
79	సినిమా	cinema	6	1	f	2026-08-26 07:15:15.677157
80	టెలివిజన్	television	6	2	f	2026-08-26 07:15:15.677157
81	సంగీతం	music	6	3	f	2026-08-26 07:15:15.677157
82	OTT	ott	6	4	f	2026-08-26 07:15:15.677157
83	క్రికెట్	cricket	7	1	f	2026-08-26 07:15:15.677157
84	ఫుట్‌బాల్	football	7	2	f	2026-08-26 07:15:15.677157
85	కబడ్డీ	kabaddi	7	3	f	2026-08-26 07:15:15.677157
86	ఒలింపిక్స్	olympics	7	4	f	2026-08-26 07:15:15.677157
87	మార్కెట్లు	markets	8	1	f	2026-08-26 07:15:15.677157
2	Telangana	telangana	\N	1	t	2026-08-26 07:15:15.677157
8	Business	business	\N	7	t	2026-08-26 07:15:15.677157
7	Sports	sports	\N	6	t	2026-08-26 07:15:15.677157
6	Entertainment	entertainment	\N	5	t	2026-08-26 07:15:15.677157
88	Technology	technology	8	2	f	2026-08-26 07:15:15.677157
89	వ్యవసాయం	agriculture	8	3	f	2026-08-26 07:15:15.677157
90	స్టార్టప్స్	startups	8	4	f	2026-08-26 07:15:15.677157
91	వైద్యం	medicine	9	1	f	2026-08-26 07:15:15.677157
92	యోగా	yoga	9	2	f	2026-08-26 07:15:15.677157
93	ఆహారం	diet	9	3	f	2026-08-26 07:15:15.677157
94	మందులు	pharma	9	4	f	2026-08-26 07:15:15.677157
95	పరీక్షలు	exams	10	1	f	2026-08-26 07:15:15.677157
96	ఉద్యోగాలు	jobs	10	2	f	2026-08-26 07:15:15.677157
97	స్కాలర్‌షిప్‌లు	scholarships	10	3	f	2026-08-26 07:15:15.677157
98	విశ్వవిద్యాలయాలు	universities	10	4	f	2026-08-26 07:15:15.677157
99	హత్య	murder	11	1	f	2026-08-26 07:15:15.677157
100	మోసాలు	fraud	11	2	f	2026-08-26 07:15:15.677157
101	సైబర్ నేరాలు	cyber-crime	11	3	f	2026-08-26 07:15:15.677157
102	అక్రమ రవాణా	trafficking	11	4	f	2026-08-26 07:15:15.677157
4	National	national	\N	3	t	2026-08-26 07:15:15.677157
108	Andhra	andhra	\N	0	f	2026-10-02 14:21:44.292472
\.


--
-- Data for Name: epapers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.epapers (id, title, published_date, cover_image, pdf_url, pages, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.news (id, title, slug, content, excerpt, image, author, category_id, is_published, is_trending, created_at, updated_at, status, created_by, rejection_reason) FROM stdin;
39	Chandrayaan-4 Mission Gets Final Go-Ahead from Government	chandrayaan-4-mission-gets-final-go-ahead	<p>The Indian Space Research Organisation (ISRO) has received the final approval for Chandrayaan-4, aiming to bring back lunar samples. This marks a significant milestone in India's space exploration journey, aiming for a launch by 2027.</p>	ISRO receives final approval for the Chandrayaan-4 sample return mission.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	K.SUSHMA REKHA	4	t	t	2026-10-02 13:57:27.829161	2026-10-02 13:57:27.829161	approved	\N	\N
40	Hyderabad Tech Park Expansion to Create 50,000 New Jobs	hyderabad-tech-park-expansion-jobs	<p>The Telangana government announced a massive expansion of the HITEC City phase 2, which is expected to generate over 50,000 new jobs in the IT and ITES sectors within the next two years.</p>	Massive tech park expansion in Hyderabad to create 50,000 jobs.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	News Desk	2	t	t	2026-10-02 13:57:28.559551	2026-10-02 13:57:28.559551	approved	\N	\N
41	Sensex Hits Record High Amid Global Market Rally	sensex-hits-record-high-global-rally	<p>The BSE Sensex touched an all-time high today, driven by strong quarterly earnings and a global market rally. Tech and banking stocks led the surge, bringing cheer to investors across the country.</p>	BSE Sensex reaches an all-time high driven by a global market rally and tech stocks.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Correspondent	8	t	f	2026-10-02 13:57:29.119529	2026-10-02 13:57:29.119529	approved	\N	\N
42	New regulations affect local businesses - Part 1 (ec9c978d)	article-ec9c978d-0	<p>This is a detailed report on New regulations affect local businesses - Part 1 (ec9c978d). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 1 (ec9c978d). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Sports Editor	8	t	f	2026-10-02 14:21:45.648213	2026-10-02 14:21:45.648213	approved	\N	\N
43	New breakthrough in medical research - Part 2 (c3f57e18)	article-c3f57e18-1	<p>This is a detailed report on New breakthrough in medical research - Part 2 (c3f57e18). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 2 (c3f57e18). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	K.SUSHMA REKHA	6	t	f	2026-10-02 14:21:48.458136	2026-10-02 14:21:48.458136	approved	\N	\N
44	Global markets react to recent events - Part 3 (e14bda95)	article-e14bda95-2	<p>This is a detailed report on Global markets react to recent events - Part 3 (e14bda95). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 3 (e14bda95). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	4	t	f	2026-10-02 14:21:50.488014	2026-10-02 14:21:50.488014	approved	\N	\N
45	Government announces new initiative - Part 4 (e41e1c8a)	article-e41e1c8a-3	<p>This is a detailed report on Government announces new initiative - Part 4 (e41e1c8a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 4 (e41e1c8a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	News Desk	7	t	f	2026-10-02 14:21:51.37326	2026-10-02 14:21:51.37326	approved	\N	\N
46	New breakthrough in medical research - Part 5 (e94924df)	article-e94924df-4	<p>This is a detailed report on New breakthrough in medical research - Part 5 (e94924df). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 5 (e94924df). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	K.SUSHMA REKHA	88	t	f	2026-10-02 14:21:51.637548	2026-10-02 14:21:51.637548	approved	\N	\N
47	New breakthrough in medical research - Part 6 (c41d939b)	article-c41d939b-5	<p>This is a detailed report on New breakthrough in medical research - Part 6 (c41d939b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 6 (c41d939b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	News Desk	6	t	f	2026-10-02 14:21:51.907871	2026-10-02 14:21:51.907871	approved	\N	\N
48	New regulations affect local businesses - Part 7 (90529cf1)	article-90529cf1-6	<p>This is a detailed report on New regulations affect local businesses - Part 7 (90529cf1). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 7 (90529cf1). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	88	t	f	2026-10-02 14:21:52.167983	2026-10-02 14:21:52.167983	approved	\N	\N
49	New breakthrough in medical research - Part 8 (9b313f5d)	article-9b313f5d-7	<p>This is a detailed report on New breakthrough in medical research - Part 8 (9b313f5d). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 8 (9b313f5d). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	88	t	f	2026-10-02 14:21:52.428028	2026-10-02 14:21:52.428028	approved	\N	\N
50	Startups drive innovation in the sector - Part 9 (36c0995d)	article-36c0995d-8	<p>This is a detailed report on Startups drive innovation in the sector - Part 9 (36c0995d). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 9 (36c0995d). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	K.SUSHMA REKHA	108	t	f	2026-10-02 14:21:52.742727	2026-10-02 14:21:52.742727	approved	\N	\N
51	Startups drive innovation in the sector - Part 10 (c99be202)	article-c99be202-9	<p>This is a detailed report on Startups drive innovation in the sector - Part 10 (c99be202). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 10 (c99be202). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	Tech Correspondent	8	t	f	2026-10-02 14:21:53.007806	2026-10-02 14:21:53.007806	approved	\N	\N
52	New regulations affect local businesses - Part 11 (e99f01ed)	article-e99f01ed-10	<p>This is a detailed report on New regulations affect local businesses - Part 11 (e99f01ed). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 11 (e99f01ed). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Sports Editor	8	t	f	2026-10-02 14:21:53.302642	2026-10-02 14:21:53.302642	approved	\N	\N
53	Local sports team wins championship - Part 12 (0284c0fb)	article-0284c0fb-11	<p>This is a detailed report on Local sports team wins championship - Part 12 (0284c0fb). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 12 (0284c0fb). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	K.SUSHMA REKHA	108	t	f	2026-10-02 14:21:53.55774	2026-10-02 14:21:53.55774	approved	\N	\N
54	Local sports team wins championship - Part 13 (9c746726)	article-9c746726-12	<p>This is a detailed report on Local sports team wins championship - Part 13 (9c746726). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 13 (9c746726). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Tech Correspondent	2	t	f	2026-10-02 14:21:53.833369	2026-10-02 14:21:53.833369	approved	\N	\N
55	Tech companies see record profits - Part 14 (527b3238)	article-527b3238-13	<p>This is a detailed report on Tech companies see record profits - Part 14 (527b3238). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 14 (527b3238). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Tech Correspondent	88	t	f	2026-10-02 14:21:54.110012	2026-10-02 14:21:54.110012	approved	\N	\N
56	Tech companies see record profits - Part 15 (b31036d0)	article-b31036d0-14	<p>This is a detailed report on Tech companies see record profits - Part 15 (b31036d0). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 15 (b31036d0). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	News Desk	4	t	f	2026-10-02 14:21:54.40083	2026-10-02 14:21:54.40083	approved	\N	\N
57	Local sports team wins championship - Part 16 (93a82bde)	article-93a82bde-15	<p>This is a detailed report on Local sports team wins championship - Part 16 (93a82bde). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 16 (93a82bde). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Tech Correspondent	8	t	f	2026-10-02 14:21:54.672608	2026-10-02 14:21:54.672608	approved	\N	\N
58	Global markets react to recent events - Part 17 (b930446e)	article-b930446e-16	<p>This is a detailed report on Global markets react to recent events - Part 17 (b930446e). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 17 (b930446e). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	Business Analyst	4	t	f	2026-10-02 14:21:54.937311	2026-10-02 14:21:54.937311	approved	\N	\N
59	Startups drive innovation in the sector - Part 18 (73e49796)	article-73e49796-17	<p>This is a detailed report on Startups drive innovation in the sector - Part 18 (73e49796). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 18 (73e49796). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	Sports Editor	4	t	f	2026-10-02 14:21:55.20802	2026-10-02 14:21:55.20802	approved	\N	\N
60	Startups drive innovation in the sector - Part 19 (17e52646)	article-17e52646-18	<p>This is a detailed report on Startups drive innovation in the sector - Part 19 (17e52646). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 19 (17e52646). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	Sports Editor	2	t	f	2026-10-02 14:21:55.473422	2026-10-02 14:21:55.473422	approved	\N	\N
61	Global markets react to recent events - Part 20 (793ad816)	article-793ad816-19	<p>This is a detailed report on Global markets react to recent events - Part 20 (793ad816). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 20 (793ad816). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	News Desk	108	t	f	2026-10-02 14:21:55.728075	2026-10-02 14:21:55.728075	approved	\N	\N
62	Global markets react to recent events - Part 21 (f90e21b5)	article-f90e21b5-20	<p>This is a detailed report on Global markets react to recent events - Part 21 (f90e21b5). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 21 (f90e21b5). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	K.SUSHMA REKHA	4	t	f	2026-10-02 14:21:55.988102	2026-10-02 14:21:55.988102	approved	\N	\N
63	Local sports team wins championship - Part 22 (d20e9ab0)	article-d20e9ab0-21	<p>This is a detailed report on Local sports team wins championship - Part 22 (d20e9ab0). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 22 (d20e9ab0). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	Business Analyst	4	t	f	2026-10-02 14:21:56.261963	2026-10-02 14:21:56.261963	approved	\N	\N
64	Global markets react to recent events - Part 23 (33c975ff)	article-33c975ff-22	<p>This is a detailed report on Global markets react to recent events - Part 23 (33c975ff). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 23 (33c975ff). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	4	t	t	2026-10-02 14:21:56.587752	2026-10-02 14:21:56.587752	approved	\N	\N
65	Startups drive innovation in the sector - Part 24 (82c6ab87)	article-82c6ab87-23	<p>This is a detailed report on Startups drive innovation in the sector - Part 24 (82c6ab87). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 24 (82c6ab87). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	News Desk	6	t	f	2026-10-02 14:21:56.858036	2026-10-02 14:21:56.858036	approved	\N	\N
66	New regulations affect local businesses - Part 25 (fd498440)	article-fd498440-24	<p>This is a detailed report on New regulations affect local businesses - Part 25 (fd498440). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 25 (fd498440). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:21:57.114456	2026-10-02 14:21:57.114456	approved	\N	\N
67	Upcoming movie sets box office records - Part 26 (408dc576)	article-408dc576-25	<p>This is a detailed report on Upcoming movie sets box office records - Part 26 (408dc576). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 26 (408dc576). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	News Desk	88	t	f	2026-10-02 14:21:57.389873	2026-10-02 14:21:57.389873	approved	\N	\N
68	New regulations affect local businesses - Part 27 (7441e178)	article-7441e178-26	<p>This is a detailed report on New regulations affect local businesses - Part 27 (7441e178). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 27 (7441e178). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	K.SUSHMA REKHA	8	t	f	2026-10-02 14:21:57.6477	2026-10-02 14:21:57.6477	approved	\N	\N
69	Global markets react to recent events - Part 28 (df3d7e02)	article-df3d7e02-27	<p>This is a detailed report on Global markets react to recent events - Part 28 (df3d7e02). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 28 (df3d7e02). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	88	t	t	2026-10-02 14:21:57.927826	2026-10-02 14:21:57.927826	approved	\N	\N
70	Local sports team wins championship - Part 29 (723e8bae)	article-723e8bae-28	<p>This is a detailed report on Local sports team wins championship - Part 29 (723e8bae). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 29 (723e8bae). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Tech Correspondent	108	t	t	2026-10-02 14:21:58.232674	2026-10-02 14:21:58.232674	approved	\N	\N
71	Government announces new initiative - Part 30 (3897a8fa)	article-3897a8fa-29	<p>This is a detailed report on Government announces new initiative - Part 30 (3897a8fa). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 30 (3897a8fa). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	7	t	f	2026-10-02 14:21:58.528165	2026-10-02 14:21:58.528165	approved	\N	\N
72	Tech companies see record profits - Part 31 (36f11df5)	article-36f11df5-30	<p>This is a detailed report on Tech companies see record profits - Part 31 (36f11df5). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 31 (36f11df5). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	7	t	t	2026-10-02 14:21:58.787974	2026-10-02 14:21:58.787974	approved	\N	\N
73	Government announces new initiative - Part 32 (bb16d821)	article-bb16d821-31	<p>This is a detailed report on Government announces new initiative - Part 32 (bb16d821). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 32 (bb16d821). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Tech Correspondent	2	t	f	2026-10-02 14:21:59.05294	2026-10-02 14:21:59.05294	approved	\N	\N
74	New breakthrough in medical research - Part 33 (a7f111c7)	article-a7f111c7-32	<p>This is a detailed report on New breakthrough in medical research - Part 33 (a7f111c7). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 33 (a7f111c7). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Tech Correspondent	6	t	f	2026-10-02 14:21:59.312946	2026-10-02 14:21:59.312946	approved	\N	\N
75	New regulations affect local businesses - Part 34 (b70fafec)	article-b70fafec-33	<p>This is a detailed report on New regulations affect local businesses - Part 34 (b70fafec). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 34 (b70fafec). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	K.SUSHMA REKHA	8	t	f	2026-10-02 14:21:59.569911	2026-10-02 14:21:59.569911	approved	\N	\N
76	Startups drive innovation in the sector - Part 35 (283b9199)	article-283b9199-34	<p>This is a detailed report on Startups drive innovation in the sector - Part 35 (283b9199). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 35 (283b9199). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	News Desk	88	t	f	2026-10-02 14:21:59.943327	2026-10-02 14:21:59.943327	approved	\N	\N
77	Tech companies see record profits - Part 36 (df844987)	article-df844987-35	<p>This is a detailed report on Tech companies see record profits - Part 36 (df844987). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 36 (df844987). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	K.SUSHMA REKHA	88	t	f	2026-10-02 14:22:00.813329	2026-10-02 14:22:00.813329	approved	\N	\N
78	Government announces new initiative - Part 37 (cc1bd6e7)	article-cc1bd6e7-36	<p>This is a detailed report on Government announces new initiative - Part 37 (cc1bd6e7). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 37 (cc1bd6e7). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	K.SUSHMA REKHA	88	t	f	2026-10-02 14:22:01.547516	2026-10-02 14:22:01.547516	approved	\N	\N
79	Startups drive innovation in the sector - Part 38 (9c89ee7f)	article-9c89ee7f-37	<p>This is a detailed report on Startups drive innovation in the sector - Part 38 (9c89ee7f). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 38 (9c89ee7f). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Tech Correspondent	6	t	t	2026-10-02 14:22:02.043225	2026-10-02 14:22:02.043225	approved	\N	\N
80	Startups drive innovation in the sector - Part 39 (bd0140ab)	article-bd0140ab-38	<p>This is a detailed report on Startups drive innovation in the sector - Part 39 (bd0140ab). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 39 (bd0140ab). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	News Desk	108	t	f	2026-10-02 14:22:03.407562	2026-10-02 14:22:03.407562	approved	\N	\N
81	Upcoming movie sets box office records - Part 40 (606e0979)	article-606e0979-39	<p>This is a detailed report on Upcoming movie sets box office records - Part 40 (606e0979). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 40 (606e0979). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	Sports Editor	4	t	f	2026-10-02 14:22:03.892914	2026-10-02 14:22:03.892914	approved	\N	\N
82	New breakthrough in medical research - Part 41 (3a49f446)	article-3a49f446-40	<p>This is a detailed report on New breakthrough in medical research - Part 41 (3a49f446). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 41 (3a49f446). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Tech Correspondent	6	t	f	2026-10-02 14:22:04.261201	2026-10-02 14:22:04.261201	approved	\N	\N
83	Government announces new initiative - Part 42 (05fa61eb)	article-05fa61eb-41	<p>This is a detailed report on Government announces new initiative - Part 42 (05fa61eb). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 42 (05fa61eb). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Sports Editor	88	t	f	2026-10-02 14:22:04.653059	2026-10-02 14:22:04.653059	approved	\N	\N
84	Government announces new initiative - Part 43 (f5b26ba9)	article-f5b26ba9-42	<p>This is a detailed report on Government announces new initiative - Part 43 (f5b26ba9). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 43 (f5b26ba9). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	Business Analyst	8	t	f	2026-10-02 14:22:04.972699	2026-10-02 14:22:04.972699	approved	\N	\N
85	Global markets react to recent events - Part 44 (1cc95ba5)	article-1cc95ba5-43	<p>This is a detailed report on Global markets react to recent events - Part 44 (1cc95ba5). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 44 (1cc95ba5). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	News Desk	7	t	t	2026-10-02 14:22:05.272893	2026-10-02 14:22:05.272893	approved	\N	\N
86	Government announces new initiative - Part 45 (eb75d35e)	article-eb75d35e-44	<p>This is a detailed report on Government announces new initiative - Part 45 (eb75d35e). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 45 (eb75d35e). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Tech Correspondent	2	t	t	2026-10-02 14:22:05.532887	2026-10-02 14:22:05.532887	approved	\N	\N
87	Government announces new initiative - Part 46 (7ad1c38e)	article-7ad1c38e-45	<p>This is a detailed report on Government announces new initiative - Part 46 (7ad1c38e). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 46 (7ad1c38e). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	8	t	t	2026-10-02 14:22:05.827345	2026-10-02 14:22:05.827345	approved	\N	\N
88	Upcoming movie sets box office records - Part 47 (041c30fa)	article-041c30fa-46	<p>This is a detailed report on Upcoming movie sets box office records - Part 47 (041c30fa). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 47 (041c30fa). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	Business Analyst	88	t	f	2026-10-02 14:22:06.102977	2026-10-02 14:22:06.102977	approved	\N	\N
89	Government announces new initiative - Part 48 (10b33b19)	article-10b33b19-47	<p>This is a detailed report on Government announces new initiative - Part 48 (10b33b19). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 48 (10b33b19). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	News Desk	7	t	f	2026-10-02 14:22:06.352836	2026-10-02 14:22:06.352836	approved	\N	\N
90	Local sports team wins championship - Part 49 (18e7ab71)	article-18e7ab71-48	<p>This is a detailed report on Local sports team wins championship - Part 49 (18e7ab71). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 49 (18e7ab71). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	7	t	f	2026-10-02 14:22:06.608122	2026-10-02 14:22:06.608122	approved	\N	\N
91	New breakthrough in medical research - Part 50 (16f6b80b)	article-16f6b80b-49	<p>This is a detailed report on New breakthrough in medical research - Part 50 (16f6b80b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 50 (16f6b80b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	News Desk	108	t	f	2026-10-02 14:22:06.862438	2026-10-02 14:22:06.862438	approved	\N	\N
92	Tech companies see record profits - Part 51 (f7a5fc48)	article-f7a5fc48-50	<p>This is a detailed report on Tech companies see record profits - Part 51 (f7a5fc48). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 51 (f7a5fc48). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Tech Correspondent	7	t	f	2026-10-02 14:22:07.173309	2026-10-02 14:22:07.173309	approved	\N	\N
93	New breakthrough in medical research - Part 52 (75f2435b)	article-75f2435b-51	<p>This is a detailed report on New breakthrough in medical research - Part 52 (75f2435b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 52 (75f2435b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Tech Correspondent	88	t	f	2026-10-02 14:22:07.4832	2026-10-02 14:22:07.4832	approved	\N	\N
94	Global markets react to recent events - Part 53 (841949fd)	article-841949fd-52	<p>This is a detailed report on Global markets react to recent events - Part 53 (841949fd). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 53 (841949fd). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	Tech Correspondent	108	t	f	2026-10-02 14:22:07.753202	2026-10-02 14:22:07.753202	approved	\N	\N
95	Upcoming movie sets box office records - Part 54 (2fa7f263)	article-2fa7f263-53	<p>This is a detailed report on Upcoming movie sets box office records - Part 54 (2fa7f263). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 54 (2fa7f263). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	K.SUSHMA REKHA	108	t	t	2026-10-02 14:22:08.02338	2026-10-02 14:22:08.02338	approved	\N	\N
96	Startups drive innovation in the sector - Part 55 (56a40bd7)	article-56a40bd7-54	<p>This is a detailed report on Startups drive innovation in the sector - Part 55 (56a40bd7). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 55 (56a40bd7). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	K.SUSHMA REKHA	108	t	t	2026-10-02 14:22:08.308509	2026-10-02 14:22:08.308509	approved	\N	\N
97	New regulations affect local businesses - Part 56 (3afc503b)	article-3afc503b-55	<p>This is a detailed report on New regulations affect local businesses - Part 56 (3afc503b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 56 (3afc503b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Sports Editor	2	t	f	2026-10-02 14:22:08.597686	2026-10-02 14:22:08.597686	approved	\N	\N
98	Government announces new initiative - Part 57 (d2d8ce60)	article-d2d8ce60-56	<p>This is a detailed report on Government announces new initiative - Part 57 (d2d8ce60). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 57 (d2d8ce60). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Tech Correspondent	6	t	f	2026-10-02 14:22:08.883161	2026-10-02 14:22:08.883161	approved	\N	\N
99	Upcoming movie sets box office records - Part 58 (b76eeed2)	article-b76eeed2-57	<p>This is a detailed report on Upcoming movie sets box office records - Part 58 (b76eeed2). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 58 (b76eeed2). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	K.SUSHMA REKHA	88	t	f	2026-10-02 14:22:09.26267	2026-10-02 14:22:09.26267	approved	\N	\N
100	New regulations affect local businesses - Part 59 (6bd34cff)	article-6bd34cff-58	<p>This is a detailed report on New regulations affect local businesses - Part 59 (6bd34cff). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 59 (6bd34cff). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80	Sports Editor	108	t	f	2026-10-02 14:22:09.527983	2026-10-02 14:22:09.527983	approved	\N	\N
101	New regulations affect local businesses - Part 60 (891b6da7)	article-891b6da7-59	<p>This is a detailed report on New regulations affect local businesses - Part 60 (891b6da7). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 60 (891b6da7). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:22:09.823001	2026-10-02 14:22:09.823001	approved	\N	\N
102	Tech companies see record profits - Part 61 (a4ec1869)	article-a4ec1869-60	<p>This is a detailed report on Tech companies see record profits - Part 61 (a4ec1869). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 61 (a4ec1869). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:22:10.128079	2026-10-02 14:22:10.128079	approved	\N	\N
103	Upcoming movie sets box office records - Part 62 (4a222572)	article-4a222572-61	<p>This is a detailed report on Upcoming movie sets box office records - Part 62 (4a222572). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 62 (4a222572). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Business Analyst	7	t	t	2026-10-02 14:22:10.423502	2026-10-02 14:22:10.423502	approved	\N	\N
104	Startups drive innovation in the sector - Part 63 (52620b26)	article-52620b26-62	<p>This is a detailed report on Startups drive innovation in the sector - Part 63 (52620b26). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 63 (52620b26). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:22:10.873163	2026-10-02 14:22:10.873163	approved	\N	\N
105	Startups drive innovation in the sector - Part 64 (1870afd8)	article-1870afd8-63	<p>This is a detailed report on Startups drive innovation in the sector - Part 64 (1870afd8). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 64 (1870afd8). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	108	t	f	2026-10-02 14:22:11.344252	2026-10-02 14:22:11.344252	approved	\N	\N
106	Government announces new initiative - Part 65 (910c64db)	article-910c64db-64	<p>This is a detailed report on Government announces new initiative - Part 65 (910c64db). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 65 (910c64db). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	K.SUSHMA REKHA	6	t	f	2026-10-02 14:22:11.732516	2026-10-02 14:22:11.732516	approved	\N	\N
107	Upcoming movie sets box office records - Part 66 (c10a314a)	article-c10a314a-65	<p>This is a detailed report on Upcoming movie sets box office records - Part 66 (c10a314a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 66 (c10a314a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	4	t	f	2026-10-02 14:22:12.607965	2026-10-02 14:22:12.607965	approved	\N	\N
108	Government announces new initiative - Part 67 (4bd7d785)	article-4bd7d785-66	<p>This is a detailed report on Government announces new initiative - Part 67 (4bd7d785). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 67 (4bd7d785). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	News Desk	2	t	f	2026-10-02 14:22:12.927497	2026-10-02 14:22:12.927497	approved	\N	\N
109	Local sports team wins championship - Part 68 (94811429)	article-94811429-67	<p>This is a detailed report on Local sports team wins championship - Part 68 (94811429). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 68 (94811429). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	7	t	f	2026-10-02 14:22:13.227995	2026-10-02 14:22:13.227995	approved	\N	\N
110	Tech companies see record profits - Part 69 (bb06e936)	article-bb06e936-68	<p>This is a detailed report on Tech companies see record profits - Part 69 (bb06e936). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 69 (bb06e936). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:22:13.537868	2026-10-02 14:22:13.537868	approved	\N	\N
111	Startups drive innovation in the sector - Part 70 (52f5d3aa)	article-52f5d3aa-69	<p>This is a detailed report on Startups drive innovation in the sector - Part 70 (52f5d3aa). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 70 (52f5d3aa). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	K.SUSHMA REKHA	8	t	f	2026-10-02 14:22:13.823339	2026-10-02 14:22:13.823339	approved	\N	\N
112	New breakthrough in medical research - Part 71 (ddef97d8)	article-ddef97d8-70	<p>This is a detailed report on New breakthrough in medical research - Part 71 (ddef97d8). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 71 (ddef97d8). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Tech Correspondent	88	t	f	2026-10-02 14:22:14.167877	2026-10-02 14:22:14.167877	approved	\N	\N
113	Global markets react to recent events - Part 72 (30419926)	article-30419926-71	<p>This is a detailed report on Global markets react to recent events - Part 72 (30419926). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 72 (30419926). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	Sports Editor	4	t	f	2026-10-02 14:22:14.497628	2026-10-02 14:22:14.497628	approved	\N	\N
114	Global markets react to recent events - Part 73 (b1a8f501)	article-b1a8f501-72	<p>This is a detailed report on Global markets react to recent events - Part 73 (b1a8f501). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 73 (b1a8f501). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80	Tech Correspondent	2	t	f	2026-10-02 14:22:14.787812	2026-10-02 14:22:14.787812	approved	\N	\N
115	Local sports team wins championship - Part 74 (90b34779)	article-90b34779-73	<p>This is a detailed report on Local sports team wins championship - Part 74 (90b34779). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 74 (90b34779). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Business Analyst	88	t	t	2026-10-02 14:22:15.278112	2026-10-02 14:22:15.278112	approved	\N	\N
116	Global markets react to recent events - Part 75 (d5d9911b)	article-d5d9911b-74	<p>This is a detailed report on Global markets react to recent events - Part 75 (d5d9911b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 75 (d5d9911b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	K.SUSHMA REKHA	2	t	f	2026-10-02 14:22:15.597757	2026-10-02 14:22:15.597757	approved	\N	\N
117	New breakthrough in medical research - Part 76 (b76e54d5)	article-b76e54d5-75	<p>This is a detailed report on New breakthrough in medical research - Part 76 (b76e54d5). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 76 (b76e54d5). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	K.SUSHMA REKHA	4	t	f	2026-10-02 14:22:15.852756	2026-10-02 14:22:15.852756	approved	\N	\N
118	New regulations affect local businesses - Part 77 (4b6e704e)	article-4b6e704e-76	<p>This is a detailed report on New regulations affect local businesses - Part 77 (4b6e704e). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 77 (4b6e704e). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	Sports Editor	2	t	t	2026-10-02 14:22:16.112664	2026-10-02 14:22:16.112664	approved	\N	\N
119	Tech companies see record profits - Part 78 (aed9229b)	article-aed9229b-77	<p>This is a detailed report on Tech companies see record profits - Part 78 (aed9229b). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 78 (aed9229b). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	K.SUSHMA REKHA	8	t	f	2026-10-02 14:22:16.387766	2026-10-02 14:22:16.387766	approved	\N	\N
120	Local sports team wins championship - Part 79 (b2b29136)	article-b2b29136-78	<p>This is a detailed report on Local sports team wins championship - Part 79 (b2b29136). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 79 (b2b29136). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	K.SUSHMA REKHA	8	t	t	2026-10-02 14:22:16.648133	2026-10-02 14:22:16.648133	approved	\N	\N
121	Upcoming movie sets box office records - Part 80 (31578a96)	article-31578a96-79	<p>This is a detailed report on Upcoming movie sets box office records - Part 80 (31578a96). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Upcoming movie sets box office records - Part 80 (31578a96). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Sports Editor	108	t	f	2026-10-02 14:22:16.907394	2026-10-02 14:22:16.907394	approved	\N	\N
122	Tech companies see record profits - Part 81 (82c3a77a)	article-82c3a77a-80	<p>This is a detailed report on Tech companies see record profits - Part 81 (82c3a77a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 81 (82c3a77a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	Business Analyst	6	t	f	2026-10-02 14:22:17.169933	2026-10-02 14:22:17.169933	approved	\N	\N
123	New breakthrough in medical research - Part 82 (18085f0a)	article-18085f0a-81	<p>This is a detailed report on New breakthrough in medical research - Part 82 (18085f0a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 82 (18085f0a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	News Desk	2	t	f	2026-10-02 14:22:17.447612	2026-10-02 14:22:17.447612	approved	\N	\N
124	New breakthrough in medical research - Part 83 (1d779d37)	article-1d779d37-82	<p>This is a detailed report on New breakthrough in medical research - Part 83 (1d779d37). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 83 (1d779d37). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	Tech Correspondent	6	t	f	2026-10-02 14:22:17.735082	2026-10-02 14:22:17.735082	approved	\N	\N
125	Local sports team wins championship - Part 84 (db5a1fdd)	article-db5a1fdd-83	<p>This is a detailed report on Local sports team wins championship - Part 84 (db5a1fdd). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 84 (db5a1fdd). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Sports Editor	6	t	f	2026-10-02 14:22:18.008026	2026-10-02 14:22:18.008026	approved	\N	\N
126	New breakthrough in medical research - Part 85 (5df524a6)	article-5df524a6-84	<p>This is a detailed report on New breakthrough in medical research - Part 85 (5df524a6). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 85 (5df524a6). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Business Analyst	4	t	f	2026-10-02 14:22:18.277642	2026-10-02 14:22:18.277642	approved	\N	\N
127	Local sports team wins championship - Part 86 (87c857d9)	article-87c857d9-85	<p>This is a detailed report on Local sports team wins championship - Part 86 (87c857d9). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 86 (87c857d9). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Tech Correspondent	8	t	f	2026-10-02 14:22:18.568434	2026-10-02 14:22:18.568434	approved	\N	\N
128	Local sports team wins championship - Part 87 (b439d720)	article-b439d720-86	<p>This is a detailed report on Local sports team wins championship - Part 87 (b439d720). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Local sports team wins championship - Part 87 (b439d720). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Business Analyst	4	t	f	2026-10-02 14:22:18.827905	2026-10-02 14:22:18.827905	approved	\N	\N
129	Tech companies see record profits - Part 88 (3d0c4f28)	article-3d0c4f28-87	<p>This is a detailed report on Tech companies see record profits - Part 88 (3d0c4f28). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 88 (3d0c4f28). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	K.SUSHMA REKHA	6	t	f	2026-10-02 14:22:19.092911	2026-10-02 14:22:19.092911	approved	\N	\N
130	Tech companies see record profits - Part 89 (f685b22c)	article-f685b22c-88	<p>This is a detailed report on Tech companies see record profits - Part 89 (f685b22c). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 89 (f685b22c). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	K.SUSHMA REKHA	8	t	f	2026-10-02 14:22:19.34764	2026-10-02 14:22:19.34764	approved	\N	\N
131	Tech companies see record profits - Part 90 (1b8f9a62)	article-1b8f9a62-89	<p>This is a detailed report on Tech companies see record profits - Part 90 (1b8f9a62). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 90 (1b8f9a62). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80	Sports Editor	88	t	f	2026-10-02 14:22:19.598052	2026-10-02 14:22:19.598052	approved	\N	\N
132	Startups drive innovation in the sector - Part 91 (9b8fed92)	article-9b8fed92-90	<p>This is a detailed report on Startups drive innovation in the sector - Part 91 (9b8fed92). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Startups drive innovation in the sector - Part 91 (9b8fed92). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	Tech Correspondent	108	t	f	2026-10-02 14:22:20.88764	2026-10-02 14:22:20.88764	approved	\N	\N
133	New regulations affect local businesses - Part 92 (7aa61b8d)	article-7aa61b8d-91	<p>This is a detailed report on New regulations affect local businesses - Part 92 (7aa61b8d). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New regulations affect local businesses - Part 92 (7aa61b8d). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80	Business Analyst	7	t	f	2026-10-02 14:22:21.537966	2026-10-02 14:22:21.537966	approved	\N	\N
134	Tech companies see record profits - Part 93 (4f55fa6a)	article-4f55fa6a-92	<p>This is a detailed report on Tech companies see record profits - Part 93 (4f55fa6a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 93 (4f55fa6a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	News Desk	88	t	f	2026-10-02 14:22:22.543074	2026-10-02 14:22:22.543074	approved	\N	\N
135	New breakthrough in medical research - Part 94 (f4bb3b5a)	article-f4bb3b5a-93	<p>This is a detailed report on New breakthrough in medical research - Part 94 (f4bb3b5a). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 94 (f4bb3b5a). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	Sports Editor	6	t	t	2026-10-02 14:22:23.097838	2026-10-02 14:22:23.097838	approved	\N	\N
136	Government announces new initiative - Part 95 (cada1b77)	article-cada1b77-94	<p>This is a detailed report on Government announces new initiative - Part 95 (cada1b77). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 95 (cada1b77). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	News Desk	108	t	f	2026-10-02 14:22:23.69287	2026-10-02 14:22:23.69287	approved	\N	\N
137	Government announces new initiative - Part 96 (9db3eea5)	article-9db3eea5-95	<p>This is a detailed report on Government announces new initiative - Part 96 (9db3eea5). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Government announces new initiative - Part 96 (9db3eea5). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80	Sports Editor	8	t	f	2026-10-02 14:22:25.272663	2026-10-02 14:22:25.272663	approved	\N	\N
138	Tech companies see record profits - Part 97 (df6fa138)	article-df6fa138-96	<p>This is a detailed report on Tech companies see record profits - Part 97 (df6fa138). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 97 (df6fa138). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	Tech Correspondent	7	t	f	2026-10-02 14:22:26.377507	2026-10-02 14:22:26.377507	approved	\N	\N
139	Tech companies see record profits - Part 98 (937521d7)	article-937521d7-97	<p>This is a detailed report on Tech companies see record profits - Part 98 (937521d7). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Tech companies see record profits - Part 98 (937521d7). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80	News Desk	88	t	f	2026-10-02 14:22:26.78312	2026-10-02 14:22:26.78312	approved	\N	\N
140	Global markets react to recent events - Part 99 (f8937f2f)	article-f8937f2f-98	<p>This is a detailed report on Global markets react to recent events - Part 99 (f8937f2f). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into Global markets react to recent events - Part 99 (f8937f2f). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80	K.SUSHMA REKHA	7	t	f	2026-10-02 14:22:27.047502	2026-10-02 14:22:27.047502	approved	\N	\N
141	New breakthrough in medical research - Part 100 (fd536f36)	article-fd536f36-99	<p>This is a detailed report on New breakthrough in medical research - Part 100 (fd536f36). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>	A brief look into New breakthrough in medical research - Part 100 (fd536f36). Discover the full details in our comprehensive report.	https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80	K.SUSHMA REKHA	108	t	f	2026-10-02 14:22:27.307659	2026-10-02 14:22:27.307659	approved	\N	\N
142	Hellooooooo	hellooooooo	Hello	Hello	https://res.cloudinary.com/ujb952lg/image/upload/v1791021591/bharath24/news/fym9emdidyemtlyjsgdm.png	Hemanth	108	t	f	2026-10-03 15:30:00	2026-10-03 10:00:12.410254	approved	8	\N
143	విలేకరులకు ఇళ్ల స్థలాలు లేదా ఇళ్లు కేటాయించాలి: కోరిబిల్లి పరి	-అర్హులైన జర్నలిస్టులకు గృహ వసతిపై స్పష్టమైన కార్యాచరణ ప్రకటించాలని డిమాండ్	అనకాపల్లి: ప్రజా సమస్యలను ఎప్పటికప్పుడు వెలుగులోకి తీసుకువస్తూ ప్రజలకు, ప్రభుత్వానికి మధ్య వారధిగా పనిచేస్తున్న ప్రింట్, ఎలక్ట్రానిక్ మీడియా విలేకరులకు ఇళ్ల స్థలాలు లేదా ఇళ్లు కేటాయించాలని సర్వజన ఐక్యవేదిక వ్యవస్థాపకుడు, NHRPF హ్యూమన్ రైట్స్ అనకాపల్లి జిల్లా అధ్యక్షుడు కోరిబిల్లి పరి ప్రభుత్వాన్ని డిమాండ్ చేశారు.\nఏ ప్రభుత్వం అధికారంలోకి వచ్చినా జర్నలిస్టుల గృహ వసతి సమస్యను పరిష్కరిస్తామని హామీలు వస్తున్నప్పటికీ, ఏళ్ల తరబడి ఈ సమస్య పూర్తిస్థాయిలో పరిష్కారం కాకపోవడం బాధాకరమని పేర్కొన్నారు. జర్నలిస్టుల ఇళ్ల స్థలాల అంశంపై రాష్ట్రంలోని జర్నలిస్టు సంఘాలు కూడా ప్రభుత్వానికి పలుమార్లు విజ్ఞప్తులు చేస్తున్నాయని తెలిపారు.\nప్రజా సమస్యల పరిష్కారం కోసం నిరంతరం క్షేత్రస్థాయిలో పనిచేసే విలేకరులు, ఎలక్ట్రానిక్ మీడియా ప్రతినిధుల గృహ వసతి సమస్యను ప్రభుత్వం ప్రత్యేకంగా పరిగణించాలని పరి కోరారు. అనకాపల్లి జిల్లాలో అర్హులైన విలేకరులను గుర్తించి వారికి ఇళ్ల స్థలాలు లేదా ఇళ్లు కేటాయించేందుకు స్పష్టమైన కార్యాచరణ ప్రకటించాలని డిమాండ్ చేశారు.\nజర్నలిస్టులకు ఇళ్ల స్థలాల కేటాయింపు కోసం రాష్ట్రంలో జర్నలిస్టు సంఘాలు ఇటీవల కూడా ప్రభుత్వానికి వినతులు, నిరసనల ద్వారా డిమాండ్లు తెలియజేస్తున్నాయి.\nఈ డిమాండ్ సాధన కోసం వచ్చే వారం ఒకరోజు విలేకరులు, మీడియా ప్రతినిధులు, సంబంధిత సంస్థలతో కలిసి దీక్ష చేపట్టనున్నట్లు కోరిబిల్లి పరి ప్రకటించారు. విలేకరుల న్యాయమైన గృహ వసతి డిమాండ్‌కు పరిష్కారం లభించే వరకు ప్రజాస్వామ్య పద్ధతిలో తమ పోరాటాన్ని కొనసాగిస్తామని తెలిపారు.		https://res.cloudinary.com/ujb952lg/image/upload/v1791022881/bharath24/news/ovvinfdxdlzpfdwxfkwt.jpg		46	t	f	2026-10-03 15:52:00	2026-10-03 10:22:14.713217	approved	8	\N
\.


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 8, true);


--
-- Name: advertisements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.advertisements_id_seq', 1, false);


--
-- Name: breaking_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.breaking_news_id_seq', 1, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.categories_id_seq', 112, true);


--
-- Name: epapers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.epapers_id_seq', 1, false);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.news_id_seq', 143, true);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: invitation invitation_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (id);


--
-- Name: jwks jwks_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: organization organization_slug_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_slug_key UNIQUE (slug);


--
-- Name: project_config project_config_endpoint_id_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_endpoint_id_key UNIQUE (endpoint_id);


--
-- Name: project_config project_config_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: session session_token_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_token_key UNIQUE (token);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_email_key UNIQUE (email);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: advertisements advertisements_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.advertisements
    ADD CONSTRAINT advertisements_pkey PRIMARY KEY (id);


--
-- Name: breaking_news breaking_news_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.breaking_news
    ADD CONSTRAINT breaking_news_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: epapers epapers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.epapers
    ADD CONSTRAINT epapers_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: news news_slug_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_slug_key UNIQUE (slug);


--
-- Name: account_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX "account_userId_idx" ON neon_auth.account USING btree ("userId");


--
-- Name: invitation_email_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX invitation_email_idx ON neon_auth.invitation USING btree (email);


--
-- Name: invitation_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX "invitation_organizationId_idx" ON neon_auth.invitation USING btree ("organizationId");


--
-- Name: member_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX "member_organizationId_idx" ON neon_auth.member USING btree ("organizationId");


--
-- Name: member_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX "member_userId_idx" ON neon_auth.member USING btree ("userId");


--
-- Name: organization_slug_uidx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE UNIQUE INDEX organization_slug_uidx ON neon_auth.organization USING btree (slug);


--
-- Name: session_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX "session_userId_idx" ON neon_auth.session USING btree ("userId");


--
-- Name: verification_identifier_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX verification_identifier_idx ON neon_auth.verification USING btree (identifier);


--
-- Name: account account_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: invitation invitation_inviterId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: invitation invitation_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- Name: member member_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- Name: member member_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: session session_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: breaking_news breaking_news_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.breaking_news
    ADD CONSTRAINT breaking_news_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.news(id) ON DELETE SET NULL;


--
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: news news_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: news news_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict sYhCexgIJvAstEZn3zRCcQxHrjwW4gJsf5D1NMJfkZNutsnQiOPH8dO1zdHHlmG

