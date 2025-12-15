--
-- PostgreSQL database dump
--

\restrict 5z4h8nQnQdz6gCONWgewPaEcwaFPwYujJHTkjItK6fTDEXsKf5AszG8anrTJoq2

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: analytics_budgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_budgets (
    id integer NOT NULL,
    tenant_id integer,
    fiscal_year integer NOT NULL,
    fiscal_quarter integer,
    department_id integer,
    category character varying(100),
    budget_allocated numeric(15,2),
    budget_used numeric(15,2) DEFAULT 0,
    budget_remaining numeric(15,2),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_budgets OWNER TO postgres;

--
-- Name: analytics_budgets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_budgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_budgets_id_seq OWNER TO postgres;

--
-- Name: analytics_budgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_budgets_id_seq OWNED BY public.analytics_budgets.id;


--
-- Name: analytics_customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_customers (
    id integer NOT NULL,
    tenant_id integer,
    customer_code character varying(50) NOT NULL,
    company_name character varying(200) NOT NULL,
    industry character varying(100),
    segment character varying(50),
    region_id integer,
    credit_limit numeric(15,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_customers OWNER TO postgres;

--
-- Name: analytics_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_customers_id_seq OWNER TO postgres;

--
-- Name: analytics_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_customers_id_seq OWNED BY public.analytics_customers.id;


--
-- Name: analytics_departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_departments (
    id integer NOT NULL,
    tenant_id integer,
    code character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    cost_center character varying(50),
    manager_name character varying(100),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_departments OWNER TO postgres;

--
-- Name: analytics_departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_departments_id_seq OWNER TO postgres;

--
-- Name: analytics_departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_departments_id_seq OWNED BY public.analytics_departments.id;


--
-- Name: analytics_expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_expenses (
    id integer NOT NULL,
    tenant_id integer,
    expense_date date NOT NULL,
    department_id integer,
    category character varying(100) NOT NULL,
    subcategory character varying(100),
    description text,
    amount numeric(15,2) NOT NULL,
    cost_center character varying(50),
    approval_status character varying(30),
    payment_method character varying(50),
    vendor_name character varying(200),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_expenses OWNER TO postgres;

--
-- Name: analytics_expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_expenses_id_seq OWNER TO postgres;

--
-- Name: analytics_expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_expenses_id_seq OWNED BY public.analytics_expenses.id;


--
-- Name: analytics_financial_summaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_financial_summaries (
    id integer NOT NULL,
    tenant_id integer,
    period_year integer NOT NULL,
    period_month integer NOT NULL,
    period_quarter integer,
    total_revenue numeric(18,2),
    total_cogs numeric(18,2),
    gross_profit numeric(18,2),
    operating_expenses numeric(18,2),
    operating_income numeric(18,2),
    tax_expense numeric(18,2),
    net_income numeric(18,2),
    ebitda numeric(18,2),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_financial_summaries OWNER TO postgres;

--
-- Name: analytics_financial_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_financial_summaries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_financial_summaries_id_seq OWNER TO postgres;

--
-- Name: analytics_financial_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_financial_summaries_id_seq OWNED BY public.analytics_financial_summaries.id;


--
-- Name: analytics_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_products (
    id integer NOT NULL,
    tenant_id integer,
    sku character varying(50) NOT NULL,
    name character varying(200) NOT NULL,
    category character varying(100),
    subcategory character varying(100),
    unit_price numeric(12,2),
    cost_price numeric(12,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_products OWNER TO postgres;

--
-- Name: analytics_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_products_id_seq OWNER TO postgres;

--
-- Name: analytics_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_products_id_seq OWNED BY public.analytics_products.id;


--
-- Name: analytics_regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_regions (
    id integer NOT NULL,
    tenant_id integer,
    code character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    country character varying(100),
    timezone character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_regions OWNER TO postgres;

--
-- Name: analytics_regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_regions_id_seq OWNER TO postgres;

--
-- Name: analytics_regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_regions_id_seq OWNED BY public.analytics_regions.id;


--
-- Name: analytics_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_sales (
    id integer NOT NULL,
    tenant_id integer,
    order_number character varying(50) NOT NULL,
    order_date date NOT NULL,
    customer_id integer,
    product_id integer,
    region_id integer,
    department_id integer,
    sales_channel character varying(50),
    quantity integer,
    unit_price numeric(12,2),
    discount_percent numeric(5,2) DEFAULT 0,
    total_amount numeric(15,2),
    cost_amount numeric(15,2),
    profit_amount numeric(15,2),
    sales_rep character varying(100),
    invoice_number character varying(50),
    payment_status character varying(30),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.analytics_sales OWNER TO postgres;

--
-- Name: analytics_sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analytics_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analytics_sales_id_seq OWNER TO postgres;

--
-- Name: analytics_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analytics_sales_id_seq OWNED BY public.analytics_sales.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id integer NOT NULL,
    tenant_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255),
    is_active integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: data_sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_sources (
    id integer NOT NULL,
    tenant_id integer NOT NULL,
    name character varying(255) NOT NULL,
    db_type character varying(50) NOT NULL,
    connection_string text NOT NULL,
    schema_info text,
    tables_info text,
    is_active boolean,
    is_read_only boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.data_sources OWNER TO postgres;

--
-- Name: data_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_sources_id_seq OWNER TO postgres;

--
-- Name: data_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_sources_id_seq OWNED BY public.data_sources.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    conversation_id integer NOT NULL,
    role character varying(20) NOT NULL,
    content text NOT NULL,
    query_type character varying(50),
    generated_query text,
    query_result text,
    chart_type character varying(50),
    chart_data text,
    insights text,
    user_rating integer,
    user_feedback text,
    execution_time_ms double precision,
    created_at timestamp without time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: nlq_memories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nlq_memories (
    id integer NOT NULL,
    tenant_id integer NOT NULL,
    user_id integer NOT NULL,
    normalized_query character varying(512) NOT NULL,
    raw_user_input text NOT NULL,
    generated_sql text,
    generated_mongo_pipeline text,
    intent character varying(100),
    metrics text,
    filters text,
    hit_count integer,
    last_used_at timestamp without time zone,
    confidence_score double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.nlq_memories OWNER TO postgres;

--
-- Name: nlq_memories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nlq_memories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nlq_memories_id_seq OWNER TO postgres;

--
-- Name: nlq_memories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nlq_memories_id_seq OWNED BY public.nlq_memories.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations (
    id integer NOT NULL,
    tenant_id integer NOT NULL,
    name character varying(100) NOT NULL,
    display_name character varying(255),
    is_active boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizations_id_seq OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    display_name character varying(255),
    description text,
    is_active boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    db_type character varying(50),
    db_connection_string text,
    rate_limit_per_minute integer,
    rate_limit_per_hour integer
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tenants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tenants_id_seq OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tenants_id_seq OWNED BY public.tenants.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    phone_number character varying(50),
    profile_picture text,
    tenant_id integer NOT NULL,
    organization_id integer NOT NULL,
    is_active boolean,
    is_verified boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    last_login timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: analytics_budgets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_budgets ALTER COLUMN id SET DEFAULT nextval('public.analytics_budgets_id_seq'::regclass);


--
-- Name: analytics_customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_customers ALTER COLUMN id SET DEFAULT nextval('public.analytics_customers_id_seq'::regclass);


--
-- Name: analytics_departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_departments ALTER COLUMN id SET DEFAULT nextval('public.analytics_departments_id_seq'::regclass);


--
-- Name: analytics_expenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_expenses ALTER COLUMN id SET DEFAULT nextval('public.analytics_expenses_id_seq'::regclass);


--
-- Name: analytics_financial_summaries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_financial_summaries ALTER COLUMN id SET DEFAULT nextval('public.analytics_financial_summaries_id_seq'::regclass);


--
-- Name: analytics_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_products ALTER COLUMN id SET DEFAULT nextval('public.analytics_products_id_seq'::regclass);


--
-- Name: analytics_regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_regions ALTER COLUMN id SET DEFAULT nextval('public.analytics_regions_id_seq'::regclass);


--
-- Name: analytics_sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_sales ALTER COLUMN id SET DEFAULT nextval('public.analytics_sales_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: data_sources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources ALTER COLUMN id SET DEFAULT nextval('public.data_sources_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: nlq_memories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nlq_memories ALTER COLUMN id SET DEFAULT nextval('public.nlq_memories_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: tenants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants ALTER COLUMN id SET DEFAULT nextval('public.tenants_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics_budgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_budgets (id, tenant_id, fiscal_year, fiscal_quarter, department_id, category, budget_allocated, budget_used, budget_remaining, created_at) FROM stdin;
1	1	2023	1	1	Travel	189956.00	115725.00	74231.00	2025-12-13 07:11:45.467881
2	1	2023	1	1	Payroll	211562.00	204019.00	7543.00	2025-12-13 07:11:45.467881
3	1	2023	1	1	Infrastructure	278074.00	183075.00	94999.00	2025-12-13 07:11:45.467881
4	1	2023	1	1	Marketing	479445.00	476923.00	2522.00	2025-12-13 07:11:45.467881
5	1	2023	1	1	Operations	176496.00	156858.00	19638.00	2025-12-13 07:11:45.467881
6	1	2023	1	2	Travel	215635.00	215281.00	354.00	2025-12-13 07:11:45.467881
7	1	2023	1	2	Payroll	292804.00	264076.00	28728.00	2025-12-13 07:11:45.467881
8	1	2023	1	2	Infrastructure	428661.00	422369.00	6292.00	2025-12-13 07:11:45.467881
9	1	2023	1	2	Marketing	230692.00	206886.00	23806.00	2025-12-13 07:11:45.467881
10	1	2023	1	2	Operations	381195.00	295786.00	85409.00	2025-12-13 07:11:45.467881
11	1	2023	1	3	Travel	482419.00	304694.00	177725.00	2025-12-13 07:11:45.467881
12	1	2023	1	3	Payroll	98191.00	100974.00	-2783.00	2025-12-13 07:11:45.467881
13	1	2023	1	3	Infrastructure	473578.00	321743.00	151835.00	2025-12-13 07:11:45.467881
14	1	2023	1	3	Marketing	166871.00	156886.00	9985.00	2025-12-13 07:11:45.467881
15	1	2023	1	3	Operations	291621.00	313202.00	-21581.00	2025-12-13 07:11:45.467881
16	1	2023	1	4	Travel	343506.00	374012.00	-30506.00	2025-12-13 07:11:45.467881
17	1	2023	1	4	Payroll	336297.00	231034.00	105263.00	2025-12-13 07:11:45.467881
18	1	2023	1	4	Infrastructure	316240.00	243253.00	72987.00	2025-12-13 07:11:45.467881
19	1	2023	1	4	Marketing	350630.00	339942.00	10688.00	2025-12-13 07:11:45.467881
20	1	2023	1	4	Operations	398957.00	299328.00	99629.00	2025-12-13 07:11:45.467881
21	1	2023	1	5	Travel	144698.00	116782.00	27916.00	2025-12-13 07:11:45.467881
22	1	2023	1	5	Payroll	452437.00	274982.00	177455.00	2025-12-13 07:11:45.467881
23	1	2023	1	5	Infrastructure	367178.00	231442.00	135736.00	2025-12-13 07:11:45.467881
24	1	2023	1	5	Marketing	484431.00	338933.00	145498.00	2025-12-13 07:11:45.467881
25	1	2023	1	5	Operations	268265.00	191432.00	76833.00	2025-12-13 07:11:45.467881
26	1	2023	2	1	Travel	285368.00	187571.00	97797.00	2025-12-13 07:11:45.467881
27	1	2023	2	1	Payroll	366825.00	266054.00	100771.00	2025-12-13 07:11:45.467881
28	1	2023	2	1	Infrastructure	61752.00	58623.00	3129.00	2025-12-13 07:11:45.467881
29	1	2023	2	1	Marketing	136236.00	88417.00	47819.00	2025-12-13 07:11:45.467881
30	1	2023	2	1	Operations	72725.00	71985.00	740.00	2025-12-13 07:11:45.467881
31	1	2023	2	2	Travel	340872.00	328801.00	12071.00	2025-12-13 07:11:45.467881
32	1	2023	2	2	Payroll	416574.00	422448.00	-5874.00	2025-12-13 07:11:45.467881
33	1	2023	2	2	Infrastructure	113348.00	76126.00	37222.00	2025-12-13 07:11:45.467881
34	1	2023	2	2	Marketing	276841.00	300943.00	-24102.00	2025-12-13 07:11:45.467881
35	1	2023	2	2	Operations	55355.00	58951.00	-3596.00	2025-12-13 07:11:45.467881
36	1	2023	2	3	Travel	439047.00	430175.00	8872.00	2025-12-13 07:11:45.467881
37	1	2023	2	3	Payroll	437816.00	401387.00	36429.00	2025-12-13 07:11:45.467881
38	1	2023	2	3	Infrastructure	193039.00	191299.00	1740.00	2025-12-13 07:11:45.467881
39	1	2023	2	3	Marketing	287699.00	274510.00	13189.00	2025-12-13 07:11:45.467881
40	1	2023	2	3	Operations	352995.00	314818.00	38177.00	2025-12-13 07:11:45.467881
41	1	2023	2	4	Travel	283971.00	260543.00	23428.00	2025-12-13 07:11:45.467881
42	1	2023	2	4	Payroll	310638.00	213359.00	97279.00	2025-12-13 07:11:45.467881
43	1	2023	2	4	Infrastructure	176387.00	193572.00	-17185.00	2025-12-13 07:11:45.467881
44	1	2023	2	4	Marketing	322252.00	256404.00	65848.00	2025-12-13 07:11:45.467881
45	1	2023	2	4	Operations	349879.00	239915.00	109964.00	2025-12-13 07:11:45.467881
46	1	2023	2	5	Travel	172795.00	152025.00	20770.00	2025-12-13 07:11:45.467881
47	1	2023	2	5	Payroll	498278.00	374324.00	123954.00	2025-12-13 07:11:45.467881
48	1	2023	2	5	Infrastructure	254781.00	253045.00	1736.00	2025-12-13 07:11:45.467881
49	1	2023	2	5	Marketing	379042.00	280443.00	98599.00	2025-12-13 07:11:45.467881
50	1	2023	2	5	Operations	184083.00	181187.00	2896.00	2025-12-13 07:11:45.467881
51	1	2023	3	1	Travel	169906.00	149436.00	20470.00	2025-12-13 07:11:45.467881
52	1	2023	3	1	Payroll	245417.00	176288.00	69129.00	2025-12-13 07:11:45.467881
53	1	2023	3	1	Infrastructure	461996.00	351446.00	110550.00	2025-12-13 07:11:45.467881
54	1	2023	3	1	Marketing	241642.00	155513.00	86129.00	2025-12-13 07:11:45.467881
55	1	2023	3	1	Operations	472068.00	332468.00	139600.00	2025-12-13 07:11:45.467881
56	1	2023	3	2	Travel	381371.00	408085.00	-26714.00	2025-12-13 07:11:45.467881
57	1	2023	3	2	Payroll	133264.00	86985.00	46279.00	2025-12-13 07:11:45.467881
58	1	2023	3	2	Infrastructure	142022.00	136888.00	5134.00	2025-12-13 07:11:45.467881
59	1	2023	3	2	Marketing	314209.00	206741.00	107468.00	2025-12-13 07:11:45.467881
60	1	2023	3	2	Operations	93184.00	88918.00	4266.00	2025-12-13 07:11:45.467881
61	1	2023	3	3	Travel	452220.00	492351.00	-40131.00	2025-12-13 07:11:45.467881
62	1	2023	3	3	Payroll	376507.00	400012.00	-23505.00	2025-12-13 07:11:45.467881
63	1	2023	3	3	Infrastructure	414368.00	381048.00	33320.00	2025-12-13 07:11:45.467881
64	1	2023	3	3	Marketing	263692.00	180778.00	82914.00	2025-12-13 07:11:45.467881
65	1	2023	3	3	Operations	181999.00	128706.00	53293.00	2025-12-13 07:11:45.467881
66	1	2023	3	4	Travel	273139.00	225824.00	47315.00	2025-12-13 07:11:45.467881
67	1	2023	3	4	Payroll	214069.00	191824.00	22245.00	2025-12-13 07:11:45.467881
68	1	2023	3	4	Infrastructure	133349.00	114108.00	19241.00	2025-12-13 07:11:45.467881
69	1	2023	3	4	Marketing	74493.00	77864.00	-3371.00	2025-12-13 07:11:45.467881
70	1	2023	3	4	Operations	88281.00	80122.00	8159.00	2025-12-13 07:11:45.467881
71	1	2023	3	5	Travel	121614.00	122234.00	-620.00	2025-12-13 07:11:45.467881
72	1	2023	3	5	Payroll	328215.00	305794.00	22421.00	2025-12-13 07:11:45.467881
73	1	2023	3	5	Infrastructure	409748.00	271937.00	137811.00	2025-12-13 07:11:45.467881
74	1	2023	3	5	Marketing	214002.00	133008.00	80994.00	2025-12-13 07:11:45.467881
75	1	2023	3	5	Operations	199534.00	200184.00	-650.00	2025-12-13 07:11:45.467881
76	1	2023	4	1	Travel	155547.00	146203.00	9344.00	2025-12-13 07:11:45.467881
77	1	2023	4	1	Payroll	438407.00	450997.00	-12590.00	2025-12-13 07:11:45.467881
78	1	2023	4	1	Infrastructure	212724.00	128908.00	83816.00	2025-12-13 07:11:45.467881
79	1	2023	4	1	Marketing	239808.00	234234.00	5574.00	2025-12-13 07:11:45.467881
80	1	2023	4	1	Operations	100051.00	69911.00	30140.00	2025-12-13 07:11:45.467881
81	1	2023	4	2	Travel	204880.00	138160.00	66720.00	2025-12-13 07:11:45.467881
82	1	2023	4	2	Payroll	396110.00	383429.00	12681.00	2025-12-13 07:11:45.467881
83	1	2023	4	2	Infrastructure	356424.00	240407.00	116017.00	2025-12-13 07:11:45.467881
84	1	2023	4	2	Marketing	183349.00	161354.00	21995.00	2025-12-13 07:11:45.467881
85	1	2023	4	2	Operations	477891.00	502364.00	-24473.00	2025-12-13 07:11:45.467881
86	1	2023	4	3	Travel	253766.00	196101.00	57665.00	2025-12-13 07:11:45.467881
87	1	2023	4	3	Payroll	310943.00	273519.00	37424.00	2025-12-13 07:11:45.467881
88	1	2023	4	3	Infrastructure	262674.00	189677.00	72997.00	2025-12-13 07:11:45.467881
89	1	2023	4	3	Marketing	221081.00	200736.00	20345.00	2025-12-13 07:11:45.467881
90	1	2023	4	3	Operations	446172.00	391013.00	55159.00	2025-12-13 07:11:45.467881
91	1	2023	4	4	Travel	399601.00	388064.00	11537.00	2025-12-13 07:11:45.467881
92	1	2023	4	4	Payroll	357658.00	271132.00	86526.00	2025-12-13 07:11:45.467881
93	1	2023	4	4	Infrastructure	55142.00	40512.00	14630.00	2025-12-13 07:11:45.467881
94	1	2023	4	4	Marketing	267392.00	281811.00	-14419.00	2025-12-13 07:11:45.467881
95	1	2023	4	4	Operations	360937.00	217981.00	142956.00	2025-12-13 07:11:45.467881
96	1	2023	4	5	Travel	418961.00	436874.00	-17913.00	2025-12-13 07:11:45.467881
97	1	2023	4	5	Payroll	406087.00	260714.00	145373.00	2025-12-13 07:11:45.467881
98	1	2023	4	5	Infrastructure	272253.00	281971.00	-9718.00	2025-12-13 07:11:45.467881
99	1	2023	4	5	Marketing	159484.00	157856.00	1628.00	2025-12-13 07:11:45.467881
100	1	2023	4	5	Operations	286421.00	289019.00	-2598.00	2025-12-13 07:11:45.467881
101	1	2024	1	1	Travel	102000.00	97724.00	4276.00	2025-12-13 07:11:45.467881
102	1	2024	1	1	Payroll	412321.00	355254.00	57067.00	2025-12-13 07:11:45.467881
103	1	2024	1	1	Infrastructure	465176.00	479622.00	-14446.00	2025-12-13 07:11:45.467881
104	1	2024	1	1	Marketing	475579.00	292385.00	183194.00	2025-12-13 07:11:45.467881
105	1	2024	1	1	Operations	215363.00	200501.00	14862.00	2025-12-13 07:11:45.467881
106	1	2024	1	2	Travel	428758.00	343699.00	85059.00	2025-12-13 07:11:45.467881
107	1	2024	1	2	Payroll	157138.00	154027.00	3111.00	2025-12-13 07:11:45.467881
108	1	2024	1	2	Infrastructure	397593.00	421404.00	-23811.00	2025-12-13 07:11:45.467881
109	1	2024	1	2	Marketing	316508.00	312805.00	3703.00	2025-12-13 07:11:45.467881
110	1	2024	1	2	Operations	396358.00	240192.00	156166.00	2025-12-13 07:11:45.467881
111	1	2024	1	3	Travel	71195.00	72868.00	-1673.00	2025-12-13 07:11:45.467881
112	1	2024	1	3	Payroll	149256.00	161165.00	-11909.00	2025-12-13 07:11:45.467881
113	1	2024	1	3	Infrastructure	87273.00	54064.00	33209.00	2025-12-13 07:11:45.467881
114	1	2024	1	3	Marketing	118281.00	123221.00	-4940.00	2025-12-13 07:11:45.467881
115	1	2024	1	3	Operations	182436.00	194108.00	-11672.00	2025-12-13 07:11:45.467881
116	1	2024	1	4	Travel	210411.00	150614.00	59797.00	2025-12-13 07:11:45.467881
117	1	2024	1	4	Payroll	213693.00	142959.00	70734.00	2025-12-13 07:11:45.467881
118	1	2024	1	4	Infrastructure	136135.00	125204.00	10931.00	2025-12-13 07:11:45.467881
119	1	2024	1	4	Marketing	265540.00	277751.00	-12211.00	2025-12-13 07:11:45.467881
120	1	2024	1	4	Operations	216122.00	222352.00	-6230.00	2025-12-13 07:11:45.467881
121	1	2024	1	5	Travel	470139.00	373575.00	96564.00	2025-12-13 07:11:45.467881
122	1	2024	1	5	Payroll	348279.00	347715.00	564.00	2025-12-13 07:11:45.467881
123	1	2024	1	5	Infrastructure	494824.00	458871.00	35953.00	2025-12-13 07:11:45.467881
124	1	2024	1	5	Marketing	440426.00	329763.00	110663.00	2025-12-13 07:11:45.467881
125	1	2024	1	5	Operations	382532.00	251251.00	131281.00	2025-12-13 07:11:45.467881
126	1	2024	2	1	Travel	227691.00	144770.00	82921.00	2025-12-13 07:11:45.467881
127	1	2024	2	1	Payroll	169261.00	120749.00	48512.00	2025-12-13 07:11:45.467881
128	1	2024	2	1	Infrastructure	75353.00	70016.00	5337.00	2025-12-13 07:11:45.467881
129	1	2024	2	1	Marketing	450388.00	293026.00	157362.00	2025-12-13 07:11:45.467881
130	1	2024	2	1	Operations	302886.00	256312.00	46574.00	2025-12-13 07:11:45.467881
131	1	2024	2	2	Travel	463568.00	292568.00	171000.00	2025-12-13 07:11:45.467881
132	1	2024	2	2	Payroll	211400.00	172893.00	38507.00	2025-12-13 07:11:45.467881
133	1	2024	2	2	Infrastructure	397600.00	295933.00	101667.00	2025-12-13 07:11:45.467881
134	1	2024	2	2	Marketing	342050.00	294480.00	47570.00	2025-12-13 07:11:45.467881
135	1	2024	2	2	Operations	293365.00	268812.00	24553.00	2025-12-13 07:11:45.467881
136	1	2024	2	3	Travel	483250.00	488507.00	-5257.00	2025-12-13 07:11:45.467881
137	1	2024	2	3	Payroll	347668.00	305947.00	41721.00	2025-12-13 07:11:45.467881
138	1	2024	2	3	Infrastructure	231164.00	190510.00	40654.00	2025-12-13 07:11:45.467881
139	1	2024	2	3	Marketing	229884.00	180489.00	49395.00	2025-12-13 07:11:45.467881
140	1	2024	2	3	Operations	224037.00	236354.00	-12317.00	2025-12-13 07:11:45.467881
141	1	2024	2	4	Travel	166422.00	139849.00	26573.00	2025-12-13 07:11:45.467881
142	1	2024	2	4	Payroll	473722.00	415785.00	57937.00	2025-12-13 07:11:45.467881
143	1	2024	2	4	Infrastructure	400199.00	290123.00	110076.00	2025-12-13 07:11:45.467881
144	1	2024	2	4	Marketing	137996.00	113633.00	24363.00	2025-12-13 07:11:45.467881
145	1	2024	2	4	Operations	52476.00	42359.00	10117.00	2025-12-13 07:11:45.467881
146	1	2024	2	5	Travel	287359.00	234586.00	52773.00	2025-12-13 07:11:45.467881
147	1	2024	2	5	Payroll	265531.00	227751.00	37780.00	2025-12-13 07:11:45.467881
148	1	2024	2	5	Infrastructure	356136.00	250426.00	105710.00	2025-12-13 07:11:45.467881
149	1	2024	2	5	Marketing	227704.00	241576.00	-13872.00	2025-12-13 07:11:45.467881
150	1	2024	2	5	Operations	93437.00	97743.00	-4306.00	2025-12-13 07:11:45.467881
151	1	2024	3	1	Travel	190497.00	145620.00	44877.00	2025-12-13 07:11:45.467881
152	1	2024	3	1	Payroll	86856.00	76646.00	10210.00	2025-12-13 07:11:45.467881
153	1	2024	3	1	Infrastructure	299619.00	270867.00	28752.00	2025-12-13 07:11:45.467881
154	1	2024	3	1	Marketing	292794.00	260228.00	32566.00	2025-12-13 07:11:45.467881
155	1	2024	3	1	Operations	217433.00	141568.00	75865.00	2025-12-13 07:11:45.467881
156	1	2024	3	2	Travel	314540.00	201084.00	113456.00	2025-12-13 07:11:45.467881
157	1	2024	3	2	Payroll	428525.00	286717.00	141808.00	2025-12-13 07:11:45.467881
158	1	2024	3	2	Infrastructure	375511.00	330438.00	45073.00	2025-12-13 07:11:45.467881
159	1	2024	3	2	Marketing	83954.00	88010.00	-4056.00	2025-12-13 07:11:45.467881
160	1	2024	3	2	Operations	422701.00	436164.00	-13463.00	2025-12-13 07:11:45.467881
161	1	2024	3	3	Travel	269966.00	169882.00	100084.00	2025-12-13 07:11:45.467881
162	1	2024	3	3	Payroll	209656.00	196008.00	13648.00	2025-12-13 07:11:45.467881
163	1	2024	3	3	Infrastructure	189644.00	177841.00	11803.00	2025-12-13 07:11:45.467881
164	1	2024	3	3	Marketing	103931.00	69649.00	34282.00	2025-12-13 07:11:45.467881
165	1	2024	3	3	Operations	350028.00	331993.00	18035.00	2025-12-13 07:11:45.467881
166	1	2024	3	4	Travel	297242.00	280362.00	16880.00	2025-12-13 07:11:45.467881
167	1	2024	3	4	Payroll	265676.00	267322.00	-1646.00	2025-12-13 07:11:45.467881
168	1	2024	3	4	Infrastructure	389715.00	289616.00	100099.00	2025-12-13 07:11:45.467881
169	1	2024	3	4	Marketing	460739.00	406055.00	54684.00	2025-12-13 07:11:45.467881
170	1	2024	3	4	Operations	170928.00	104317.00	66611.00	2025-12-13 07:11:45.467881
171	1	2024	3	5	Travel	435954.00	394020.00	41934.00	2025-12-13 07:11:45.467881
172	1	2024	3	5	Payroll	78383.00	77022.00	1361.00	2025-12-13 07:11:45.467881
173	1	2024	3	5	Infrastructure	261609.00	274863.00	-13254.00	2025-12-13 07:11:45.467881
174	1	2024	3	5	Marketing	383200.00	304821.00	78379.00	2025-12-13 07:11:45.467881
175	1	2024	3	5	Operations	409711.00	263959.00	145752.00	2025-12-13 07:11:45.467881
176	1	2024	4	1	Travel	438215.00	294049.00	144166.00	2025-12-13 07:11:45.467881
177	1	2024	4	1	Payroll	94536.00	59945.00	34591.00	2025-12-13 07:11:45.467881
178	1	2024	4	1	Infrastructure	154713.00	145172.00	9541.00	2025-12-13 07:11:45.467881
179	1	2024	4	1	Marketing	186240.00	116695.00	69545.00	2025-12-13 07:11:45.467881
180	1	2024	4	1	Operations	383371.00	326796.00	56575.00	2025-12-13 07:11:45.467881
181	1	2024	4	2	Travel	497965.00	441337.00	56628.00	2025-12-13 07:11:45.467881
182	1	2024	4	2	Payroll	220325.00	228351.00	-8026.00	2025-12-13 07:11:45.467881
183	1	2024	4	2	Infrastructure	325910.00	279870.00	46040.00	2025-12-13 07:11:45.467881
184	1	2024	4	2	Marketing	201891.00	189103.00	12788.00	2025-12-13 07:11:45.467881
185	1	2024	4	2	Operations	132619.00	121990.00	10629.00	2025-12-13 07:11:45.467881
186	1	2024	4	3	Travel	474039.00	480374.00	-6335.00	2025-12-13 07:11:45.467881
187	1	2024	4	3	Payroll	256857.00	273610.00	-16753.00	2025-12-13 07:11:45.467881
188	1	2024	4	3	Infrastructure	93403.00	64329.00	29074.00	2025-12-13 07:11:45.467881
189	1	2024	4	3	Marketing	275141.00	185020.00	90121.00	2025-12-13 07:11:45.467881
190	1	2024	4	3	Operations	73106.00	69645.00	3461.00	2025-12-13 07:11:45.467881
191	1	2024	4	4	Travel	206791.00	125384.00	81407.00	2025-12-13 07:11:45.467881
192	1	2024	4	4	Payroll	66088.00	50813.00	15275.00	2025-12-13 07:11:45.467881
193	1	2024	4	4	Infrastructure	212421.00	229044.00	-16623.00	2025-12-13 07:11:45.467881
194	1	2024	4	4	Marketing	92985.00	99812.00	-6827.00	2025-12-13 07:11:45.467881
195	1	2024	4	4	Operations	386187.00	367902.00	18285.00	2025-12-13 07:11:45.467881
196	1	2024	4	5	Travel	112877.00	119110.00	-6233.00	2025-12-13 07:11:45.467881
197	1	2024	4	5	Payroll	250675.00	202961.00	47714.00	2025-12-13 07:11:45.467881
198	1	2024	4	5	Infrastructure	459098.00	471256.00	-12158.00	2025-12-13 07:11:45.467881
199	1	2024	4	5	Marketing	131233.00	123261.00	7972.00	2025-12-13 07:11:45.467881
200	1	2024	4	5	Operations	222413.00	168958.00	53455.00	2025-12-13 07:11:45.467881
201	2	2023	1	1	Travel	103183.00	100826.00	2357.00	2025-12-13 07:11:45.467881
202	2	2023	1	1	Payroll	61297.00	53174.00	8123.00	2025-12-13 07:11:45.467881
203	2	2023	1	1	Infrastructure	328706.00	306259.00	22447.00	2025-12-13 07:11:45.467881
204	2	2023	1	1	Marketing	96279.00	83882.00	12397.00	2025-12-13 07:11:45.467881
205	2	2023	1	1	Operations	232466.00	247788.00	-15322.00	2025-12-13 07:11:45.467881
206	2	2023	1	2	Travel	207264.00	218472.00	-11208.00	2025-12-13 07:11:45.467881
207	2	2023	1	2	Payroll	156155.00	163708.00	-7553.00	2025-12-13 07:11:45.467881
208	2	2023	1	2	Infrastructure	79202.00	59735.00	19467.00	2025-12-13 07:11:45.467881
209	2	2023	1	2	Marketing	74985.00	66421.00	8564.00	2025-12-13 07:11:45.467881
210	2	2023	1	2	Operations	294878.00	244767.00	50111.00	2025-12-13 07:11:45.467881
211	2	2023	1	3	Travel	73510.00	59335.00	14175.00	2025-12-13 07:11:45.467881
212	2	2023	1	3	Payroll	323955.00	330068.00	-6113.00	2025-12-13 07:11:45.467881
213	2	2023	1	3	Infrastructure	351483.00	352669.00	-1186.00	2025-12-13 07:11:45.467881
214	2	2023	1	3	Marketing	395967.00	373232.00	22735.00	2025-12-13 07:11:45.467881
215	2	2023	1	3	Operations	471788.00	464621.00	7167.00	2025-12-13 07:11:45.467881
216	2	2023	1	4	Travel	400029.00	269448.00	130581.00	2025-12-13 07:11:45.467881
217	2	2023	1	4	Payroll	493234.00	319467.00	173767.00	2025-12-13 07:11:45.467881
218	2	2023	1	4	Infrastructure	92443.00	68089.00	24354.00	2025-12-13 07:11:45.467881
219	2	2023	1	4	Marketing	316510.00	247613.00	68897.00	2025-12-13 07:11:45.467881
220	2	2023	1	4	Operations	446141.00	272852.00	173289.00	2025-12-13 07:11:45.467881
221	2	2023	1	5	Travel	321248.00	228723.00	92525.00	2025-12-13 07:11:45.467881
222	2	2023	1	5	Payroll	101630.00	100319.00	1311.00	2025-12-13 07:11:45.467881
223	2	2023	1	5	Infrastructure	147434.00	94773.00	52661.00	2025-12-13 07:11:45.467881
224	2	2023	1	5	Marketing	403131.00	423561.00	-20430.00	2025-12-13 07:11:45.467881
225	2	2023	1	5	Operations	158280.00	106901.00	51379.00	2025-12-13 07:11:45.467881
226	2	2023	2	1	Travel	376171.00	326319.00	49852.00	2025-12-13 07:11:45.467881
227	2	2023	2	1	Payroll	207780.00	178183.00	29597.00	2025-12-13 07:11:45.467881
228	2	2023	2	1	Infrastructure	292335.00	247137.00	45198.00	2025-12-13 07:11:45.467881
229	2	2023	2	1	Marketing	473521.00	457794.00	15727.00	2025-12-13 07:11:45.467881
230	2	2023	2	1	Operations	158877.00	109342.00	49535.00	2025-12-13 07:11:45.467881
231	2	2023	2	2	Travel	252237.00	156048.00	96189.00	2025-12-13 07:11:45.467881
232	2	2023	2	2	Payroll	325990.00	223766.00	102224.00	2025-12-13 07:11:45.467881
233	2	2023	2	2	Infrastructure	443025.00	452401.00	-9376.00	2025-12-13 07:11:45.467881
234	2	2023	2	2	Marketing	330314.00	208651.00	121663.00	2025-12-13 07:11:45.467881
235	2	2023	2	2	Operations	474895.00	398577.00	76318.00	2025-12-13 07:11:45.467881
236	2	2023	2	3	Travel	301738.00	218777.00	82961.00	2025-12-13 07:11:45.467881
237	2	2023	2	3	Payroll	416629.00	284409.00	132220.00	2025-12-13 07:11:45.467881
238	2	2023	2	3	Infrastructure	149576.00	106693.00	42883.00	2025-12-13 07:11:45.467881
239	2	2023	2	3	Marketing	447948.00	312180.00	135768.00	2025-12-13 07:11:45.467881
240	2	2023	2	3	Operations	321428.00	286164.00	35264.00	2025-12-13 07:11:45.467881
241	2	2023	2	4	Travel	459236.00	292878.00	166358.00	2025-12-13 07:11:45.467881
242	2	2023	2	4	Payroll	282069.00	195137.00	86932.00	2025-12-13 07:11:45.467881
243	2	2023	2	4	Infrastructure	163844.00	146168.00	17676.00	2025-12-13 07:11:45.467881
244	2	2023	2	4	Marketing	287211.00	195879.00	91332.00	2025-12-13 07:11:45.467881
245	2	2023	2	4	Operations	129157.00	122347.00	6810.00	2025-12-13 07:11:45.467881
246	2	2023	2	5	Travel	411726.00	440629.00	-28903.00	2025-12-13 07:11:45.467881
247	2	2023	2	5	Payroll	393574.00	332857.00	60717.00	2025-12-13 07:11:45.467881
248	2	2023	2	5	Infrastructure	249879.00	211924.00	37955.00	2025-12-13 07:11:45.467881
249	2	2023	2	5	Marketing	106374.00	72306.00	34068.00	2025-12-13 07:11:45.467881
250	2	2023	2	5	Operations	328932.00	211456.00	117476.00	2025-12-13 07:11:45.467881
251	2	2023	3	1	Travel	212678.00	211273.00	1405.00	2025-12-13 07:11:45.467881
252	2	2023	3	1	Payroll	398862.00	379870.00	18992.00	2025-12-13 07:11:45.467881
253	2	2023	3	1	Infrastructure	434206.00	429830.00	4376.00	2025-12-13 07:11:45.467881
254	2	2023	3	1	Marketing	487912.00	377835.00	110077.00	2025-12-13 07:11:45.467881
255	2	2023	3	1	Operations	221936.00	229418.00	-7482.00	2025-12-13 07:11:45.467881
256	2	2023	3	2	Travel	417808.00	407916.00	9892.00	2025-12-13 07:11:45.467881
257	2	2023	3	2	Payroll	162816.00	138977.00	23839.00	2025-12-13 07:11:45.467881
258	2	2023	3	2	Infrastructure	493514.00	468181.00	25333.00	2025-12-13 07:11:45.467881
259	2	2023	3	2	Marketing	384058.00	307435.00	76623.00	2025-12-13 07:11:45.467881
260	2	2023	3	2	Operations	195648.00	173047.00	22601.00	2025-12-13 07:11:45.467881
261	2	2023	3	3	Travel	410833.00	426745.00	-15912.00	2025-12-13 07:11:45.467881
262	2	2023	3	3	Payroll	70030.00	46129.00	23901.00	2025-12-13 07:11:45.467881
263	2	2023	3	3	Infrastructure	171142.00	162365.00	8777.00	2025-12-13 07:11:45.467881
264	2	2023	3	3	Marketing	149156.00	132310.00	16846.00	2025-12-13 07:11:45.467881
265	2	2023	3	3	Operations	374077.00	275967.00	98110.00	2025-12-13 07:11:45.467881
266	2	2023	3	4	Travel	115099.00	84786.00	30313.00	2025-12-13 07:11:45.467881
267	2	2023	3	4	Payroll	241049.00	146225.00	94824.00	2025-12-13 07:11:45.467881
268	2	2023	3	4	Infrastructure	296839.00	204214.00	92625.00	2025-12-13 07:11:45.467881
269	2	2023	3	4	Marketing	57533.00	52507.00	5026.00	2025-12-13 07:11:45.467881
270	2	2023	3	4	Operations	111875.00	106124.00	5751.00	2025-12-13 07:11:45.467881
271	2	2023	3	5	Travel	257810.00	244063.00	13747.00	2025-12-13 07:11:45.467881
272	2	2023	3	5	Payroll	79129.00	66662.00	12467.00	2025-12-13 07:11:45.467881
273	2	2023	3	5	Infrastructure	123457.00	107245.00	16212.00	2025-12-13 07:11:45.467881
274	2	2023	3	5	Marketing	111165.00	77682.00	33483.00	2025-12-13 07:11:45.467881
275	2	2023	3	5	Operations	292983.00	237676.00	55307.00	2025-12-13 07:11:45.467881
276	2	2023	4	1	Travel	238200.00	201559.00	36641.00	2025-12-13 07:11:45.467881
277	2	2023	4	1	Payroll	348157.00	353171.00	-5014.00	2025-12-13 07:11:45.467881
278	2	2023	4	1	Infrastructure	450446.00	450154.00	292.00	2025-12-13 07:11:45.467881
279	2	2023	4	1	Marketing	243064.00	223183.00	19881.00	2025-12-13 07:11:45.467881
280	2	2023	4	1	Operations	215109.00	195226.00	19883.00	2025-12-13 07:11:45.467881
281	2	2023	4	2	Travel	347614.00	352880.00	-5266.00	2025-12-13 07:11:45.467881
282	2	2023	4	2	Payroll	415065.00	403632.00	11433.00	2025-12-13 07:11:45.467881
283	2	2023	4	2	Infrastructure	494951.00	363073.00	131878.00	2025-12-13 07:11:45.467881
284	2	2023	4	2	Marketing	257501.00	201924.00	55577.00	2025-12-13 07:11:45.467881
285	2	2023	4	2	Operations	269739.00	230643.00	39096.00	2025-12-13 07:11:45.467881
286	2	2023	4	3	Travel	461331.00	312032.00	149299.00	2025-12-13 07:11:45.467881
287	2	2023	4	3	Payroll	345698.00	235208.00	110490.00	2025-12-13 07:11:45.467881
288	2	2023	4	3	Infrastructure	125766.00	103254.00	22512.00	2025-12-13 07:11:45.467881
289	2	2023	4	3	Marketing	92428.00	81533.00	10895.00	2025-12-13 07:11:45.467881
290	2	2023	4	3	Operations	355615.00	297767.00	57848.00	2025-12-13 07:11:45.467881
291	2	2023	4	4	Travel	169838.00	110043.00	59795.00	2025-12-13 07:11:45.467881
292	2	2023	4	4	Payroll	168945.00	106396.00	62549.00	2025-12-13 07:11:45.467881
293	2	2023	4	4	Infrastructure	419883.00	428559.00	-8676.00	2025-12-13 07:11:45.467881
294	2	2023	4	4	Marketing	499188.00	534979.00	-35791.00	2025-12-13 07:11:45.467881
295	2	2023	4	4	Operations	388469.00	337846.00	50623.00	2025-12-13 07:11:45.467881
296	2	2023	4	5	Travel	133889.00	121958.00	11931.00	2025-12-13 07:11:45.467881
297	2	2023	4	5	Payroll	467480.00	304631.00	162849.00	2025-12-13 07:11:45.467881
298	2	2023	4	5	Infrastructure	272133.00	182316.00	89817.00	2025-12-13 07:11:45.467881
299	2	2023	4	5	Marketing	422885.00	254560.00	168325.00	2025-12-13 07:11:45.467881
300	2	2023	4	5	Operations	465458.00	286022.00	179436.00	2025-12-13 07:11:45.467881
301	2	2024	1	1	Travel	311588.00	284059.00	27529.00	2025-12-13 07:11:45.467881
302	2	2024	1	1	Payroll	104528.00	66714.00	37814.00	2025-12-13 07:11:45.467881
303	2	2024	1	1	Infrastructure	371192.00	351846.00	19346.00	2025-12-13 07:11:45.467881
304	2	2024	1	1	Marketing	454761.00	370840.00	83921.00	2025-12-13 07:11:45.467881
305	2	2024	1	1	Operations	371280.00	350116.00	21164.00	2025-12-13 07:11:45.467881
306	2	2024	1	2	Travel	98935.00	78427.00	20508.00	2025-12-13 07:11:45.467881
307	2	2024	1	2	Payroll	145984.00	156637.00	-10653.00	2025-12-13 07:11:45.467881
308	2	2024	1	2	Infrastructure	153111.00	166606.00	-13495.00	2025-12-13 07:11:45.467881
309	2	2024	1	2	Marketing	213107.00	197216.00	15891.00	2025-12-13 07:11:45.467881
310	2	2024	1	2	Operations	83690.00	57451.00	26239.00	2025-12-13 07:11:45.467881
311	2	2024	1	3	Travel	487624.00	328072.00	159552.00	2025-12-13 07:11:45.467881
312	2	2024	1	3	Payroll	411705.00	344532.00	67173.00	2025-12-13 07:11:45.467881
313	2	2024	1	3	Infrastructure	215225.00	131585.00	83640.00	2025-12-13 07:11:45.467881
314	2	2024	1	3	Marketing	92729.00	86999.00	5730.00	2025-12-13 07:11:45.467881
315	2	2024	1	3	Operations	114547.00	81209.00	33338.00	2025-12-13 07:11:45.467881
316	2	2024	1	4	Travel	476437.00	488206.00	-11769.00	2025-12-13 07:11:45.467881
317	2	2024	1	4	Payroll	314389.00	256122.00	58267.00	2025-12-13 07:11:45.467881
318	2	2024	1	4	Infrastructure	465564.00	338092.00	127472.00	2025-12-13 07:11:45.467881
319	2	2024	1	4	Marketing	420108.00	344734.00	75374.00	2025-12-13 07:11:45.467881
320	2	2024	1	4	Operations	295637.00	290201.00	5436.00	2025-12-13 07:11:45.467881
321	2	2024	1	5	Travel	217256.00	162625.00	54631.00	2025-12-13 07:11:45.467881
322	2	2024	1	5	Payroll	343461.00	352100.00	-8639.00	2025-12-13 07:11:45.467881
323	2	2024	1	5	Infrastructure	202520.00	212897.00	-10377.00	2025-12-13 07:11:45.467881
324	2	2024	1	5	Marketing	331396.00	361465.00	-30069.00	2025-12-13 07:11:45.467881
325	2	2024	1	5	Operations	262492.00	263337.00	-845.00	2025-12-13 07:11:45.467881
326	2	2024	2	1	Travel	238601.00	147066.00	91535.00	2025-12-13 07:11:45.467881
327	2	2024	2	1	Payroll	319456.00	336933.00	-17477.00	2025-12-13 07:11:45.467881
328	2	2024	2	1	Infrastructure	52027.00	40790.00	11237.00	2025-12-13 07:11:45.467881
329	2	2024	2	1	Marketing	307115.00	294422.00	12693.00	2025-12-13 07:11:45.467881
330	2	2024	2	1	Operations	102539.00	98755.00	3784.00	2025-12-13 07:11:45.467881
331	2	2024	2	2	Travel	99614.00	80659.00	18955.00	2025-12-13 07:11:45.467881
332	2	2024	2	2	Payroll	417687.00	435464.00	-17777.00	2025-12-13 07:11:45.467881
333	2	2024	2	2	Infrastructure	216545.00	145665.00	70880.00	2025-12-13 07:11:45.467881
334	2	2024	2	2	Marketing	248520.00	199251.00	49269.00	2025-12-13 07:11:45.467881
335	2	2024	2	2	Operations	349033.00	257492.00	91541.00	2025-12-13 07:11:45.467881
336	2	2024	2	3	Travel	452019.00	401140.00	50879.00	2025-12-13 07:11:45.467881
337	2	2024	2	3	Payroll	377289.00	374966.00	2323.00	2025-12-13 07:11:45.467881
338	2	2024	2	3	Infrastructure	251527.00	161188.00	90339.00	2025-12-13 07:11:45.467881
339	2	2024	2	3	Marketing	452076.00	465422.00	-13346.00	2025-12-13 07:11:45.467881
340	2	2024	2	3	Operations	270365.00	251806.00	18559.00	2025-12-13 07:11:45.467881
341	2	2024	2	4	Travel	253314.00	275498.00	-22184.00	2025-12-13 07:11:45.467881
342	2	2024	2	4	Payroll	236274.00	163105.00	73169.00	2025-12-13 07:11:45.467881
343	2	2024	2	4	Infrastructure	164974.00	181199.00	-16225.00	2025-12-13 07:11:45.467881
344	2	2024	2	4	Marketing	281921.00	224820.00	57101.00	2025-12-13 07:11:45.467881
345	2	2024	2	4	Operations	491161.00	336476.00	154685.00	2025-12-13 07:11:45.467881
346	2	2024	2	5	Travel	400775.00	282843.00	117932.00	2025-12-13 07:11:45.467881
347	2	2024	2	5	Payroll	294115.00	215413.00	78702.00	2025-12-13 07:11:45.467881
348	2	2024	2	5	Infrastructure	77621.00	56876.00	20745.00	2025-12-13 07:11:45.467881
349	2	2024	2	5	Marketing	268345.00	261968.00	6377.00	2025-12-13 07:11:45.467881
350	2	2024	2	5	Operations	180321.00	127669.00	52652.00	2025-12-13 07:11:45.467881
351	2	2024	3	1	Travel	91750.00	72436.00	19314.00	2025-12-13 07:11:45.467881
352	2	2024	3	1	Payroll	457437.00	343927.00	113510.00	2025-12-13 07:11:45.467881
353	2	2024	3	1	Infrastructure	317668.00	232028.00	85640.00	2025-12-13 07:11:45.467881
354	2	2024	3	1	Marketing	418407.00	316077.00	102330.00	2025-12-13 07:11:45.467881
355	2	2024	3	1	Operations	448932.00	278825.00	170107.00	2025-12-13 07:11:45.467881
356	2	2024	3	2	Travel	101216.00	100466.00	750.00	2025-12-13 07:11:45.467881
357	2	2024	3	2	Payroll	70199.00	58298.00	11901.00	2025-12-13 07:11:45.467881
358	2	2024	3	2	Infrastructure	371773.00	251425.00	120348.00	2025-12-13 07:11:45.467881
359	2	2024	3	2	Marketing	263247.00	272928.00	-9681.00	2025-12-13 07:11:45.467881
360	2	2024	3	2	Operations	92465.00	64283.00	28182.00	2025-12-13 07:11:45.467881
361	2	2024	3	3	Travel	196104.00	123650.00	72454.00	2025-12-13 07:11:45.467881
362	2	2024	3	3	Payroll	410862.00	406638.00	4224.00	2025-12-13 07:11:45.467881
363	2	2024	3	3	Infrastructure	77087.00	79942.00	-2855.00	2025-12-13 07:11:45.467881
364	2	2024	3	3	Marketing	186281.00	118085.00	68196.00	2025-12-13 07:11:45.467881
365	2	2024	3	3	Operations	269948.00	236344.00	33604.00	2025-12-13 07:11:45.467881
366	2	2024	3	4	Travel	180159.00	197524.00	-17365.00	2025-12-13 07:11:45.467881
367	2	2024	3	4	Payroll	275471.00	226921.00	48550.00	2025-12-13 07:11:45.467881
368	2	2024	3	4	Infrastructure	184652.00	143652.00	41000.00	2025-12-13 07:11:45.467881
369	2	2024	3	4	Marketing	107717.00	77841.00	29876.00	2025-12-13 07:11:45.467881
370	2	2024	3	4	Operations	290434.00	317723.00	-27289.00	2025-12-13 07:11:45.467881
371	2	2024	3	5	Travel	98663.00	73207.00	25456.00	2025-12-13 07:11:45.467881
372	2	2024	3	5	Payroll	51816.00	48543.00	3273.00	2025-12-13 07:11:45.467881
373	2	2024	3	5	Infrastructure	191142.00	204514.00	-13372.00	2025-12-13 07:11:45.467881
374	2	2024	3	5	Marketing	339837.00	298652.00	41185.00	2025-12-13 07:11:45.467881
375	2	2024	3	5	Operations	128846.00	124435.00	4411.00	2025-12-13 07:11:45.467881
376	2	2024	4	1	Travel	59228.00	48283.00	10945.00	2025-12-13 07:11:45.467881
377	2	2024	4	1	Payroll	325016.00	334586.00	-9570.00	2025-12-13 07:11:45.467881
378	2	2024	4	1	Infrastructure	484331.00	502193.00	-17862.00	2025-12-13 07:11:45.467881
379	2	2024	4	1	Marketing	220153.00	215135.00	5018.00	2025-12-13 07:11:45.467881
380	2	2024	4	1	Operations	180108.00	193679.00	-13571.00	2025-12-13 07:11:45.467881
381	2	2024	4	2	Travel	157731.00	102669.00	55062.00	2025-12-13 07:11:45.467881
382	2	2024	4	2	Payroll	411726.00	308376.00	103350.00	2025-12-13 07:11:45.467881
383	2	2024	4	2	Infrastructure	88997.00	94415.00	-5418.00	2025-12-13 07:11:45.467881
384	2	2024	4	2	Marketing	153380.00	132335.00	21045.00	2025-12-13 07:11:45.467881
385	2	2024	4	2	Operations	426463.00	327230.00	99233.00	2025-12-13 07:11:45.467881
386	2	2024	4	3	Travel	382946.00	406069.00	-23123.00	2025-12-13 07:11:45.467881
387	2	2024	4	3	Payroll	429147.00	448879.00	-19732.00	2025-12-13 07:11:45.467881
388	2	2024	4	3	Infrastructure	469140.00	463752.00	5388.00	2025-12-13 07:11:45.467881
389	2	2024	4	3	Marketing	481229.00	294151.00	187078.00	2025-12-13 07:11:45.467881
390	2	2024	4	3	Operations	361218.00	362043.00	-825.00	2025-12-13 07:11:45.467881
391	2	2024	4	4	Travel	97365.00	58585.00	38780.00	2025-12-13 07:11:45.467881
392	2	2024	4	4	Payroll	164812.00	160030.00	4782.00	2025-12-13 07:11:45.467881
393	2	2024	4	4	Infrastructure	67752.00	63012.00	4740.00	2025-12-13 07:11:45.467881
394	2	2024	4	4	Marketing	228801.00	238310.00	-9509.00	2025-12-13 07:11:45.467881
395	2	2024	4	4	Operations	415194.00	278549.00	136645.00	2025-12-13 07:11:45.467881
396	2	2024	4	5	Travel	473516.00	399820.00	73696.00	2025-12-13 07:11:45.467881
397	2	2024	4	5	Payroll	433297.00	419173.00	14124.00	2025-12-13 07:11:45.467881
398	2	2024	4	5	Infrastructure	136475.00	115667.00	20808.00	2025-12-13 07:11:45.467881
399	2	2024	4	5	Marketing	115295.00	120236.00	-4941.00	2025-12-13 07:11:45.467881
400	2	2024	4	5	Operations	453594.00	276539.00	177055.00	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_customers (id, tenant_id, customer_code, company_name, industry, segment, region_id, credit_limit, is_active, created_at) FROM stdin;
1	1	CUST-001	TechCorp Industries	Technology	Enterprise	2	50000.00	t	2025-12-13 07:11:45.467881
2	1	CUST-002	Global Manufacturing Co	Manufacturing	Enterprise	3	500000.00	t	2025-12-13 07:11:45.467881
3	1	CUST-003	Healthcare Systems Inc	Healthcare	Enterprise	4	250000.00	t	2025-12-13 07:11:45.467881
4	1	CUST-004	Retail Solutions Ltd	Retail	Mid-Market	3	500000.00	t	2025-12-13 07:11:45.467881
5	1	CUST-005	Finance Partners LLC	Finance	Enterprise	1	1000000.00	t	2025-12-13 07:11:45.467881
6	1	CUST-006	Education First Group	Education	Mid-Market	1	50000.00	t	2025-12-13 07:11:45.467881
7	1	CUST-007	Logistics Network Inc	Logistics	Mid-Market	4	1000000.00	t	2025-12-13 07:11:45.467881
8	1	CUST-008	Energy Solutions Corp	Energy	Enterprise	3	1000000.00	t	2025-12-13 07:11:45.467881
9	1	CUST-009	Media Dynamics Ltd	Media	SMB	3	1000000.00	t	2025-12-13 07:11:45.467881
10	1	CUST-010	Startup Innovations	Technology	SMB	3	1000000.00	t	2025-12-13 07:11:45.467881
11	1	CUST-011	AgriTech Farms	Agriculture	Mid-Market	5	50000.00	t	2025-12-13 07:11:45.467881
12	1	CUST-012	Construction Builders Co	Construction	Mid-Market	3	500000.00	t	2025-12-13 07:11:45.467881
13	1	CUST-013	Telecom Networks	Telecommunications	Enterprise	3	100000.00	t	2025-12-13 07:11:45.467881
14	1	CUST-014	Travel Adventures Inc	Travel	SMB	2	1000000.00	t	2025-12-13 07:11:45.467881
15	1	CUST-015	Food Services Group	Food & Beverage	Mid-Market	3	50000.00	t	2025-12-13 07:11:45.467881
16	2	CUST-001	TechCorp Industries	Technology	Enterprise	5	500000.00	t	2025-12-13 07:11:45.467881
17	2	CUST-002	Global Manufacturing Co	Manufacturing	Enterprise	2	1000000.00	t	2025-12-13 07:11:45.467881
18	2	CUST-003	Healthcare Systems Inc	Healthcare	Enterprise	4	500000.00	t	2025-12-13 07:11:45.467881
19	2	CUST-004	Retail Solutions Ltd	Retail	Mid-Market	4	250000.00	t	2025-12-13 07:11:45.467881
20	2	CUST-005	Finance Partners LLC	Finance	Enterprise	1	1000000.00	t	2025-12-13 07:11:45.467881
21	2	CUST-006	Education First Group	Education	Mid-Market	2	1000000.00	t	2025-12-13 07:11:45.467881
22	2	CUST-007	Logistics Network Inc	Logistics	Mid-Market	1	1000000.00	t	2025-12-13 07:11:45.467881
23	2	CUST-008	Energy Solutions Corp	Energy	Enterprise	3	100000.00	t	2025-12-13 07:11:45.467881
24	2	CUST-009	Media Dynamics Ltd	Media	SMB	1	50000.00	t	2025-12-13 07:11:45.467881
25	2	CUST-010	Startup Innovations	Technology	SMB	3	500000.00	t	2025-12-13 07:11:45.467881
26	2	CUST-011	AgriTech Farms	Agriculture	Mid-Market	4	500000.00	t	2025-12-13 07:11:45.467881
27	2	CUST-012	Construction Builders Co	Construction	Mid-Market	2	1000000.00	t	2025-12-13 07:11:45.467881
28	2	CUST-013	Telecom Networks	Telecommunications	Enterprise	4	500000.00	t	2025-12-13 07:11:45.467881
29	2	CUST-014	Travel Adventures Inc	Travel	SMB	2	1000000.00	t	2025-12-13 07:11:45.467881
30	2	CUST-015	Food Services Group	Food & Beverage	Mid-Market	3	1000000.00	t	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_departments (id, tenant_id, code, name, cost_center, manager_name, created_at) FROM stdin;
1	1	SALES	Sales Department	CC-SALES	Manager SALES	2025-12-13 07:11:45.467881
2	1	FIN	Finance Department	CC-FIN	Manager FIN	2025-12-13 07:11:45.467881
3	1	HR	Human Resources	CC-HR	Manager HR	2025-12-13 07:11:45.467881
4	1	OPS	Operations	CC-OPS	Manager OPS	2025-12-13 07:11:45.467881
5	1	MKT	Marketing	CC-MKT	Manager MKT	2025-12-13 07:11:45.467881
6	2	SALES	Sales Department	CC-SALES	Manager SALES	2025-12-13 07:11:45.467881
7	2	FIN	Finance Department	CC-FIN	Manager FIN	2025-12-13 07:11:45.467881
8	2	HR	Human Resources	CC-HR	Manager HR	2025-12-13 07:11:45.467881
9	2	OPS	Operations	CC-OPS	Manager OPS	2025-12-13 07:11:45.467881
10	2	MKT	Marketing	CC-MKT	Manager MKT	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_expenses (id, tenant_id, expense_date, department_id, category, subcategory, description, amount, cost_center, approval_status, payment_method, vendor_name, created_at) FROM stdin;
1	1	2024-11-22	1	Payroll	Salaries	Salaries expense	36911.00	CC-SALES	Rejected	Cash	Vendor 33	2025-12-13 07:11:45.467881
2	1	2023-05-08	2	Operations	Maintenance	Maintenance expense	3874.00	CC-FIN	Rejected	Cash	Vendor 34	2025-12-13 07:11:45.467881
3	1	2024-03-02	1	Travel	Flights	Flights expense	348.00	CC-SALES	Approved	Check	Vendor 2	2025-12-13 07:11:45.467881
4	1	2023-08-02	5	Infrastructure	Networking	Networking expense	14535.00	CC-MKT	Rejected	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
5	1	2024-09-08	2	Marketing	Social Media	Social Media expense	4349.00	CC-FIN	Approved	Bank Transfer	Vendor 11	2025-12-13 07:11:45.467881
6	1	2023-04-17	1	Payroll	Benefits	Benefits expense	37532.00	CC-SALES	Approved	Cash	Vendor 28	2025-12-13 07:11:45.467881
7	1	2024-09-30	5	Travel	Transportation	Transportation expense	4943.00	CC-MKT	Approved	Check	Vendor 16	2025-12-13 07:11:45.467881
8	1	2023-10-08	1	Operations	Office Supplies	Office Supplies expense	1904.00	CC-SALES	Pending	Credit Card	Vendor 36	2025-12-13 07:11:45.467881
9	1	2024-06-30	4	Marketing	Events	Events expense	4480.00	CC-OPS	Approved	Check	Vendor 27	2025-12-13 07:11:45.467881
10	1	2023-08-28	3	Operations	Office Supplies	Office Supplies expense	1526.00	CC-HR	Approved	Check	Vendor 44	2025-12-13 07:11:45.467881
11	1	2023-04-02	4	Travel	Hotels	Hotels expense	4519.00	CC-OPS	Rejected	Cash	Vendor 34	2025-12-13 07:11:45.467881
12	1	2024-01-18	3	Marketing	Social Media	Social Media expense	3937.00	CC-HR	Rejected	Cash	Vendor 45	2025-12-13 07:11:45.467881
13	1	2024-03-25	5	Infrastructure	Servers	Servers expense	9538.00	CC-MKT	Approved	Bank Transfer	Vendor 9	2025-12-13 07:11:45.467881
14	1	2023-03-31	5	Payroll	Salaries	Salaries expense	44865.00	CC-MKT	Approved	Credit Card	Vendor 29	2025-12-13 07:11:45.467881
15	1	2023-07-31	1	Travel	Meals	Meals expense	1474.00	CC-SALES	Rejected	Check	Vendor 33	2025-12-13 07:11:45.467881
16	1	2024-12-24	1	Travel	Flights	Flights expense	4961.00	CC-SALES	Pending	Credit Card	Vendor 10	2025-12-13 07:11:45.467881
17	1	2024-04-17	2	Payroll	Benefits	Benefits expense	47074.00	CC-FIN	Rejected	Bank Transfer	Vendor 14	2025-12-13 07:11:45.467881
18	1	2024-01-11	3	Travel	Meals	Meals expense	4983.00	CC-HR	Pending	Cash	Vendor 37	2025-12-13 07:11:45.467881
19	1	2023-04-24	2	Marketing	Events	Events expense	2788.00	CC-FIN	Pending	Cash	Vendor 38	2025-12-13 07:11:45.467881
20	1	2024-01-20	2	Travel	Transportation	Transportation expense	554.00	CC-FIN	Approved	Bank Transfer	Vendor 41	2025-12-13 07:11:45.467881
21	1	2024-04-28	1	Payroll	Salaries	Salaries expense	43741.00	CC-SALES	Rejected	Cash	Vendor 49	2025-12-13 07:11:45.467881
22	1	2023-03-20	1	Travel	Hotels	Hotels expense	2337.00	CC-SALES	Pending	Bank Transfer	Vendor 1	2025-12-13 07:11:45.467881
23	1	2024-03-08	2	Travel	Hotels	Hotels expense	4193.00	CC-FIN	Approved	Cash	Vendor 41	2025-12-13 07:11:45.467881
24	1	2024-05-05	4	Operations	Equipment	Equipment expense	3919.00	CC-OPS	Pending	Bank Transfer	Vendor 7	2025-12-13 07:11:45.467881
25	1	2023-05-26	4	Travel	Transportation	Transportation expense	2242.00	CC-OPS	Pending	Check	Vendor 16	2025-12-13 07:11:45.467881
26	1	2024-06-08	2	Infrastructure	Cloud Services	Cloud Services expense	19199.00	CC-FIN	Pending	Bank Transfer	Vendor 40	2025-12-13 07:11:45.467881
27	1	2023-03-16	4	Travel	Hotels	Hotels expense	800.00	CC-OPS	Pending	Credit Card	Vendor 13	2025-12-13 07:11:45.467881
28	1	2023-07-17	3	Travel	Transportation	Transportation expense	2241.00	CC-HR	Approved	Cash	Vendor 19	2025-12-13 07:11:45.467881
29	1	2023-03-23	5	Marketing	Advertising	Advertising expense	2609.00	CC-MKT	Approved	Check	Vendor 23	2025-12-13 07:11:45.467881
30	1	2023-02-06	3	Operations	Equipment	Equipment expense	147.00	CC-HR	Approved	Check	Vendor 20	2025-12-13 07:11:45.467881
31	1	2023-10-18	2	Payroll	Overtime	Overtime expense	41741.00	CC-FIN	Approved	Cash	Vendor 20	2025-12-13 07:11:45.467881
32	1	2023-12-16	4	Infrastructure	Networking	Networking expense	8112.00	CC-OPS	Approved	Credit Card	Vendor 38	2025-12-13 07:11:45.467881
33	1	2023-09-03	5	Marketing	Advertising	Advertising expense	1255.00	CC-MKT	Pending	Cash	Vendor 50	2025-12-13 07:11:45.467881
34	1	2024-07-10	3	Marketing	Social Media	Social Media expense	864.00	CC-HR	Pending	Credit Card	Vendor 26	2025-12-13 07:11:45.467881
35	1	2024-02-04	3	Infrastructure	Networking	Networking expense	5551.00	CC-HR	Approved	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
36	1	2023-03-01	5	Operations	Equipment	Equipment expense	2339.00	CC-MKT	Rejected	Check	Vendor 2	2025-12-13 07:11:45.467881
37	1	2024-01-12	5	Payroll	Overtime	Overtime expense	44581.00	CC-MKT	Approved	Cash	Vendor 21	2025-12-13 07:11:45.467881
38	1	2024-04-28	2	Infrastructure	Networking	Networking expense	2385.00	CC-FIN	Rejected	Cash	Vendor 10	2025-12-13 07:11:45.467881
39	1	2023-11-06	1	Operations	Maintenance	Maintenance expense	1893.00	CC-SALES	Approved	Cash	Vendor 48	2025-12-13 07:11:45.467881
40	1	2024-07-23	4	Travel	Meals	Meals expense	4425.00	CC-OPS	Approved	Bank Transfer	Vendor 28	2025-12-13 07:11:45.467881
41	1	2024-11-17	2	Travel	Flights	Flights expense	908.00	CC-FIN	Approved	Check	Vendor 34	2025-12-13 07:11:45.467881
42	1	2023-11-13	3	Operations	Office Supplies	Office Supplies expense	2172.00	CC-HR	Approved	Cash	Vendor 27	2025-12-13 07:11:45.467881
43	1	2023-10-30	3	Travel	Transportation	Transportation expense	1129.00	CC-HR	Rejected	Cash	Vendor 41	2025-12-13 07:11:45.467881
44	1	2024-06-20	3	Travel	Hotels	Hotels expense	4118.00	CC-HR	Approved	Credit Card	Vendor 7	2025-12-13 07:11:45.467881
45	1	2023-05-30	1	Operations	Maintenance	Maintenance expense	4664.00	CC-SALES	Approved	Credit Card	Vendor 29	2025-12-13 07:11:45.467881
46	1	2024-08-05	1	Marketing	Events	Events expense	1974.00	CC-SALES	Pending	Credit Card	Vendor 21	2025-12-13 07:11:45.467881
47	1	2023-04-26	3	Travel	Meals	Meals expense	945.00	CC-HR	Approved	Bank Transfer	Vendor 22	2025-12-13 07:11:45.467881
48	1	2024-08-28	4	Infrastructure	Servers	Servers expense	19752.00	CC-OPS	Approved	Bank Transfer	Vendor 44	2025-12-13 07:11:45.467881
49	1	2023-09-15	5	Marketing	Events	Events expense	1537.00	CC-MKT	Pending	Bank Transfer	Vendor 7	2025-12-13 07:11:45.467881
50	1	2024-06-14	2	Operations	Maintenance	Maintenance expense	4746.00	CC-FIN	Approved	Credit Card	Vendor 41	2025-12-13 07:11:45.467881
51	1	2024-11-23	5	Travel	Flights	Flights expense	4896.00	CC-MKT	Rejected	Credit Card	Vendor 32	2025-12-13 07:11:45.467881
52	1	2023-07-28	5	Travel	Hotels	Hotels expense	2094.00	CC-MKT	Approved	Bank Transfer	Vendor 23	2025-12-13 07:11:45.467881
53	1	2023-01-09	4	Payroll	Overtime	Overtime expense	28662.00	CC-OPS	Approved	Bank Transfer	Vendor 48	2025-12-13 07:11:45.467881
54	1	2023-11-14	5	Operations	Utilities	Utilities expense	752.00	CC-MKT	Rejected	Check	Vendor 42	2025-12-13 07:11:45.467881
55	1	2023-04-07	4	Payroll	Bonuses	Bonuses expense	8020.00	CC-OPS	Approved	Cash	Vendor 6	2025-12-13 07:11:45.467881
56	1	2024-12-02	1	Operations	Equipment	Equipment expense	456.00	CC-SALES	Approved	Credit Card	Vendor 23	2025-12-13 07:11:45.467881
57	1	2023-08-28	4	Operations	Office Supplies	Office Supplies expense	4511.00	CC-OPS	Pending	Credit Card	Vendor 47	2025-12-13 07:11:45.467881
58	1	2023-03-22	5	Operations	Office Supplies	Office Supplies expense	4069.00	CC-MKT	Approved	Cash	Vendor 28	2025-12-13 07:11:45.467881
59	1	2024-05-14	4	Operations	Equipment	Equipment expense	790.00	CC-OPS	Approved	Bank Transfer	Vendor 19	2025-12-13 07:11:45.467881
60	1	2024-02-06	3	Operations	Maintenance	Maintenance expense	3992.00	CC-HR	Rejected	Check	Vendor 16	2025-12-13 07:11:45.467881
61	1	2024-08-23	5	Payroll	Salaries	Salaries expense	46025.00	CC-MKT	Approved	Check	Vendor 19	2025-12-13 07:11:45.467881
62	1	2024-01-07	4	Marketing	Content	Content expense	257.00	CC-OPS	Approved	Bank Transfer	Vendor 1	2025-12-13 07:11:45.467881
63	1	2024-07-16	4	Travel	Transportation	Transportation expense	1576.00	CC-OPS	Approved	Bank Transfer	Vendor 19	2025-12-13 07:11:45.467881
64	1	2024-03-09	5	Payroll	Bonuses	Bonuses expense	35082.00	CC-MKT	Rejected	Credit Card	Vendor 1	2025-12-13 07:11:45.467881
65	1	2023-09-05	1	Travel	Meals	Meals expense	2417.00	CC-SALES	Approved	Cash	Vendor 35	2025-12-13 07:11:45.467881
66	1	2024-04-25	4	Travel	Meals	Meals expense	1078.00	CC-OPS	Approved	Cash	Vendor 19	2025-12-13 07:11:45.467881
67	1	2023-07-06	4	Operations	Equipment	Equipment expense	2656.00	CC-OPS	Rejected	Bank Transfer	Vendor 8	2025-12-13 07:11:45.467881
68	1	2024-06-26	5	Operations	Maintenance	Maintenance expense	1728.00	CC-MKT	Pending	Check	Vendor 9	2025-12-13 07:11:45.467881
69	1	2023-10-14	4	Infrastructure	Networking	Networking expense	11950.00	CC-OPS	Approved	Credit Card	Vendor 21	2025-12-13 07:11:45.467881
70	1	2023-03-21	1	Infrastructure	Cloud Services	Cloud Services expense	3738.00	CC-SALES	Approved	Credit Card	Vendor 16	2025-12-13 07:11:45.467881
71	1	2024-09-04	4	Operations	Maintenance	Maintenance expense	2772.00	CC-OPS	Approved	Cash	Vendor 31	2025-12-13 07:11:45.467881
72	1	2023-03-26	4	Infrastructure	Servers	Servers expense	4785.00	CC-OPS	Approved	Credit Card	Vendor 29	2025-12-13 07:11:45.467881
73	1	2024-04-20	5	Operations	Maintenance	Maintenance expense	1701.00	CC-MKT	Approved	Check	Vendor 4	2025-12-13 07:11:45.467881
74	1	2023-12-27	5	Operations	Maintenance	Maintenance expense	2482.00	CC-MKT	Pending	Bank Transfer	Vendor 27	2025-12-13 07:11:45.467881
75	1	2023-02-03	1	Marketing	Advertising	Advertising expense	1949.00	CC-SALES	Approved	Credit Card	Vendor 25	2025-12-13 07:11:45.467881
76	1	2023-02-08	1	Marketing	Content	Content expense	306.00	CC-SALES	Rejected	Check	Vendor 22	2025-12-13 07:11:45.467881
77	1	2024-01-09	4	Operations	Maintenance	Maintenance expense	3669.00	CC-OPS	Approved	Check	Vendor 41	2025-12-13 07:11:45.467881
78	1	2023-08-01	2	Travel	Hotels	Hotels expense	1088.00	CC-FIN	Approved	Credit Card	Vendor 42	2025-12-13 07:11:45.467881
79	1	2023-04-26	2	Travel	Meals	Meals expense	2306.00	CC-FIN	Pending	Check	Vendor 37	2025-12-13 07:11:45.467881
80	1	2024-08-06	1	Operations	Maintenance	Maintenance expense	3085.00	CC-SALES	Pending	Bank Transfer	Vendor 1	2025-12-13 07:11:45.467881
81	1	2024-11-19	3	Marketing	Content	Content expense	179.00	CC-HR	Rejected	Credit Card	Vendor 31	2025-12-13 07:11:45.467881
82	1	2023-06-04	4	Operations	Office Supplies	Office Supplies expense	3972.00	CC-OPS	Approved	Cash	Vendor 27	2025-12-13 07:11:45.467881
83	1	2024-04-11	4	Travel	Transportation	Transportation expense	1889.00	CC-OPS	Approved	Credit Card	Vendor 31	2025-12-13 07:11:45.467881
84	1	2023-11-03	4	Marketing	Social Media	Social Media expense	3099.00	CC-OPS	Rejected	Bank Transfer	Vendor 47	2025-12-13 07:11:45.467881
85	1	2023-11-21	4	Travel	Transportation	Transportation expense	3820.00	CC-OPS	Approved	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
86	1	2024-01-10	2	Travel	Transportation	Transportation expense	4805.00	CC-FIN	Approved	Cash	Vendor 8	2025-12-13 07:11:45.467881
87	1	2023-12-21	4	Operations	Utilities	Utilities expense	3521.00	CC-OPS	Pending	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
88	1	2024-03-03	1	Travel	Hotels	Hotels expense	2839.00	CC-SALES	Pending	Bank Transfer	Vendor 8	2025-12-13 07:11:45.467881
89	1	2023-04-08	5	Marketing	Social Media	Social Media expense	1875.00	CC-MKT	Approved	Cash	Vendor 13	2025-12-13 07:11:45.467881
90	1	2024-02-03	1	Payroll	Benefits	Benefits expense	33831.00	CC-SALES	Approved	Check	Vendor 15	2025-12-13 07:11:45.467881
91	1	2023-12-07	2	Operations	Maintenance	Maintenance expense	2415.00	CC-FIN	Approved	Cash	Vendor 43	2025-12-13 07:11:45.467881
92	1	2023-03-17	5	Payroll	Salaries	Salaries expense	27605.00	CC-MKT	Approved	Check	Vendor 3	2025-12-13 07:11:45.467881
93	1	2024-05-31	3	Operations	Office Supplies	Office Supplies expense	3944.00	CC-HR	Rejected	Check	Vendor 41	2025-12-13 07:11:45.467881
94	1	2023-10-01	5	Marketing	Content	Content expense	3095.00	CC-MKT	Approved	Cash	Vendor 19	2025-12-13 07:11:45.467881
95	1	2024-03-12	1	Infrastructure	Servers	Servers expense	9352.00	CC-SALES	Approved	Credit Card	Vendor 13	2025-12-13 07:11:45.467881
96	1	2024-06-22	4	Payroll	Bonuses	Bonuses expense	9938.00	CC-OPS	Approved	Check	Vendor 8	2025-12-13 07:11:45.467881
97	1	2024-08-15	5	Infrastructure	Cloud Services	Cloud Services expense	12277.00	CC-MKT	Rejected	Check	Vendor 35	2025-12-13 07:11:45.467881
98	1	2024-11-22	2	Operations	Maintenance	Maintenance expense	3268.00	CC-FIN	Approved	Cash	Vendor 22	2025-12-13 07:11:45.467881
99	1	2024-09-15	1	Travel	Transportation	Transportation expense	2354.00	CC-SALES	Approved	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
100	1	2024-01-07	4	Operations	Office Supplies	Office Supplies expense	1328.00	CC-OPS	Approved	Cash	Vendor 4	2025-12-13 07:11:45.467881
101	1	2023-11-10	3	Marketing	Events	Events expense	2749.00	CC-HR	Approved	Check	Vendor 48	2025-12-13 07:11:45.467881
102	1	2024-12-31	5	Travel	Meals	Meals expense	1632.00	CC-MKT	Pending	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
103	1	2023-11-29	5	Payroll	Salaries	Salaries expense	22924.00	CC-MKT	Rejected	Bank Transfer	Vendor 23	2025-12-13 07:11:45.467881
104	1	2024-08-22	4	Infrastructure	Software Licenses	Software Licenses expense	8809.00	CC-OPS	Rejected	Cash	Vendor 42	2025-12-13 07:11:45.467881
105	1	2023-01-01	1	Travel	Transportation	Transportation expense	3179.00	CC-SALES	Approved	Credit Card	Vendor 4	2025-12-13 07:11:45.467881
106	1	2023-04-11	5	Infrastructure	Software Licenses	Software Licenses expense	19778.00	CC-MKT	Pending	Bank Transfer	Vendor 5	2025-12-13 07:11:45.467881
107	1	2024-12-21	4	Payroll	Overtime	Overtime expense	9878.00	CC-OPS	Rejected	Cash	Vendor 29	2025-12-13 07:11:45.467881
108	1	2023-04-11	1	Infrastructure	Cloud Services	Cloud Services expense	4378.00	CC-SALES	Approved	Bank Transfer	Vendor 22	2025-12-13 07:11:45.467881
109	1	2023-05-16	2	Travel	Flights	Flights expense	3500.00	CC-FIN	Approved	Cash	Vendor 49	2025-12-13 07:11:45.467881
110	1	2023-03-26	4	Operations	Office Supplies	Office Supplies expense	2082.00	CC-OPS	Pending	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
111	1	2023-10-23	3	Infrastructure	Networking	Networking expense	13559.00	CC-HR	Approved	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
112	1	2023-12-24	2	Infrastructure	Software Licenses	Software Licenses expense	2903.00	CC-FIN	Approved	Credit Card	Vendor 50	2025-12-13 07:11:45.467881
113	1	2024-04-06	3	Operations	Maintenance	Maintenance expense	1672.00	CC-HR	Approved	Check	Vendor 25	2025-12-13 07:11:45.467881
114	1	2024-05-05	4	Marketing	Content	Content expense	1191.00	CC-OPS	Approved	Check	Vendor 9	2025-12-13 07:11:45.467881
115	1	2023-12-01	4	Infrastructure	Software Licenses	Software Licenses expense	14616.00	CC-OPS	Approved	Check	Vendor 42	2025-12-13 07:11:45.467881
116	1	2023-06-20	1	Payroll	Benefits	Benefits expense	27805.00	CC-SALES	Approved	Cash	Vendor 12	2025-12-13 07:11:45.467881
117	1	2023-01-21	2	Marketing	Social Media	Social Media expense	3160.00	CC-FIN	Approved	Cash	Vendor 49	2025-12-13 07:11:45.467881
118	1	2024-07-24	5	Payroll	Overtime	Overtime expense	43456.00	CC-MKT	Approved	Cash	Vendor 38	2025-12-13 07:11:45.467881
119	1	2023-11-29	2	Operations	Maintenance	Maintenance expense	2392.00	CC-FIN	Approved	Check	Vendor 18	2025-12-13 07:11:45.467881
300	1	2023-05-24	3	Payroll	Bonuses	Bonuses expense	16027.00	CC-HR	Approved	Credit Card	Vendor 27	2025-12-13 07:11:45.467881
120	1	2023-11-15	5	Infrastructure	Networking	Networking expense	17357.00	CC-MKT	Pending	Credit Card	Vendor 9	2025-12-13 07:11:45.467881
121	1	2023-08-24	5	Operations	Utilities	Utilities expense	1274.00	CC-MKT	Rejected	Bank Transfer	Vendor 44	2025-12-13 07:11:45.467881
122	1	2024-01-09	3	Marketing	Advertising	Advertising expense	1210.00	CC-HR	Approved	Credit Card	Vendor 10	2025-12-13 07:11:45.467881
123	1	2023-03-06	5	Travel	Meals	Meals expense	1144.00	CC-MKT	Pending	Check	Vendor 35	2025-12-13 07:11:45.467881
124	1	2023-05-04	1	Travel	Flights	Flights expense	3565.00	CC-SALES	Approved	Credit Card	Vendor 4	2025-12-13 07:11:45.467881
125	1	2024-01-19	4	Operations	Utilities	Utilities expense	4954.00	CC-OPS	Approved	Cash	Vendor 37	2025-12-13 07:11:45.467881
126	1	2024-04-15	5	Payroll	Salaries	Salaries expense	49361.00	CC-MKT	Approved	Bank Transfer	Vendor 29	2025-12-13 07:11:45.467881
127	1	2023-06-07	4	Marketing	Advertising	Advertising expense	2334.00	CC-OPS	Pending	Check	Vendor 32	2025-12-13 07:11:45.467881
128	1	2024-04-18	1	Operations	Maintenance	Maintenance expense	945.00	CC-SALES	Approved	Bank Transfer	Vendor 46	2025-12-13 07:11:45.467881
129	1	2023-08-02	4	Payroll	Benefits	Benefits expense	21886.00	CC-OPS	Approved	Check	Vendor 28	2025-12-13 07:11:45.467881
130	1	2024-03-31	5	Operations	Equipment	Equipment expense	3165.00	CC-MKT	Approved	Credit Card	Vendor 12	2025-12-13 07:11:45.467881
131	1	2023-01-13	3	Payroll	Overtime	Overtime expense	16033.00	CC-HR	Approved	Bank Transfer	Vendor 49	2025-12-13 07:11:45.467881
132	1	2023-07-05	1	Payroll	Salaries	Salaries expense	15825.00	CC-SALES	Pending	Bank Transfer	Vendor 26	2025-12-13 07:11:45.467881
133	1	2024-12-23	4	Operations	Utilities	Utilities expense	4877.00	CC-OPS	Approved	Credit Card	Vendor 16	2025-12-13 07:11:45.467881
134	1	2024-10-21	3	Infrastructure	Cloud Services	Cloud Services expense	9209.00	CC-HR	Approved	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
135	1	2023-10-25	3	Operations	Maintenance	Maintenance expense	3660.00	CC-HR	Pending	Check	Vendor 13	2025-12-13 07:11:45.467881
136	1	2024-02-10	3	Marketing	Advertising	Advertising expense	275.00	CC-HR	Rejected	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
137	1	2023-05-25	4	Operations	Equipment	Equipment expense	4827.00	CC-OPS	Pending	Check	Vendor 14	2025-12-13 07:11:45.467881
138	1	2024-02-03	5	Payroll	Bonuses	Bonuses expense	5765.00	CC-MKT	Approved	Credit Card	Vendor 8	2025-12-13 07:11:45.467881
139	1	2024-01-28	2	Travel	Transportation	Transportation expense	1029.00	CC-FIN	Approved	Credit Card	Vendor 3	2025-12-13 07:11:45.467881
140	1	2024-08-07	3	Marketing	Social Media	Social Media expense	2579.00	CC-HR	Approved	Check	Vendor 7	2025-12-13 07:11:45.467881
141	1	2024-12-09	5	Infrastructure	Software Licenses	Software Licenses expense	18685.00	CC-MKT	Pending	Check	Vendor 24	2025-12-13 07:11:45.467881
142	1	2023-09-22	2	Operations	Maintenance	Maintenance expense	3115.00	CC-FIN	Approved	Credit Card	Vendor 12	2025-12-13 07:11:45.467881
143	1	2024-06-04	2	Infrastructure	Servers	Servers expense	15854.00	CC-FIN	Approved	Bank Transfer	Vendor 48	2025-12-13 07:11:45.467881
144	1	2024-09-12	5	Payroll	Salaries	Salaries expense	5829.00	CC-MKT	Approved	Bank Transfer	Vendor 33	2025-12-13 07:11:45.467881
145	1	2023-05-26	2	Operations	Utilities	Utilities expense	901.00	CC-FIN	Approved	Check	Vendor 22	2025-12-13 07:11:45.467881
146	1	2023-03-30	1	Operations	Office Supplies	Office Supplies expense	2204.00	CC-SALES	Approved	Check	Vendor 6	2025-12-13 07:11:45.467881
147	1	2023-11-15	5	Payroll	Salaries	Salaries expense	8187.00	CC-MKT	Approved	Check	Vendor 29	2025-12-13 07:11:45.467881
148	1	2024-02-13	2	Travel	Transportation	Transportation expense	919.00	CC-FIN	Pending	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
149	1	2023-09-15	2	Operations	Utilities	Utilities expense	3235.00	CC-FIN	Approved	Cash	Vendor 24	2025-12-13 07:11:45.467881
150	1	2023-09-02	3	Travel	Hotels	Hotels expense	4975.00	CC-HR	Approved	Bank Transfer	Vendor 2	2025-12-13 07:11:45.467881
151	1	2023-06-01	2	Travel	Hotels	Hotels expense	364.00	CC-FIN	Rejected	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
152	1	2024-03-08	1	Infrastructure	Cloud Services	Cloud Services expense	18275.00	CC-SALES	Pending	Bank Transfer	Vendor 11	2025-12-13 07:11:45.467881
153	1	2023-07-30	2	Infrastructure	Software Licenses	Software Licenses expense	5717.00	CC-FIN	Rejected	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
154	1	2023-12-03	2	Operations	Maintenance	Maintenance expense	2920.00	CC-FIN	Approved	Bank Transfer	Vendor 40	2025-12-13 07:11:45.467881
155	1	2023-02-07	5	Marketing	Content	Content expense	2468.00	CC-MKT	Approved	Bank Transfer	Vendor 26	2025-12-13 07:11:45.467881
156	1	2023-01-16	3	Operations	Maintenance	Maintenance expense	1912.00	CC-HR	Approved	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
157	1	2024-06-18	3	Marketing	Content	Content expense	1106.00	CC-HR	Pending	Credit Card	Vendor 2	2025-12-13 07:11:45.467881
158	1	2023-06-10	1	Infrastructure	Servers	Servers expense	2163.00	CC-SALES	Approved	Cash	Vendor 23	2025-12-13 07:11:45.467881
159	1	2024-02-12	1	Travel	Meals	Meals expense	498.00	CC-SALES	Pending	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
160	1	2023-01-18	2	Infrastructure	Software Licenses	Software Licenses expense	6339.00	CC-FIN	Approved	Check	Vendor 17	2025-12-13 07:11:45.467881
161	1	2023-07-31	1	Operations	Equipment	Equipment expense	338.00	CC-SALES	Rejected	Cash	Vendor 6	2025-12-13 07:11:45.467881
162	1	2024-09-16	2	Operations	Equipment	Equipment expense	3881.00	CC-FIN	Approved	Cash	Vendor 23	2025-12-13 07:11:45.467881
163	1	2023-09-20	5	Marketing	Events	Events expense	827.00	CC-MKT	Rejected	Bank Transfer	Vendor 37	2025-12-13 07:11:45.467881
164	1	2024-09-23	5	Infrastructure	Servers	Servers expense	14657.00	CC-MKT	Pending	Bank Transfer	Vendor 3	2025-12-13 07:11:45.467881
165	1	2023-10-07	5	Marketing	Events	Events expense	1915.00	CC-MKT	Pending	Bank Transfer	Vendor 19	2025-12-13 07:11:45.467881
166	1	2023-03-02	5	Payroll	Bonuses	Bonuses expense	28877.00	CC-MKT	Approved	Cash	Vendor 45	2025-12-13 07:11:45.467881
167	1	2023-03-15	2	Marketing	Content	Content expense	3902.00	CC-FIN	Rejected	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
168	1	2023-12-16	4	Operations	Office Supplies	Office Supplies expense	160.00	CC-OPS	Approved	Credit Card	Vendor 38	2025-12-13 07:11:45.467881
169	1	2023-09-18	5	Marketing	Social Media	Social Media expense	1936.00	CC-MKT	Approved	Cash	Vendor 9	2025-12-13 07:11:45.467881
170	1	2023-02-11	4	Infrastructure	Servers	Servers expense	7404.00	CC-OPS	Pending	Bank Transfer	Vendor 44	2025-12-13 07:11:45.467881
171	1	2023-03-20	1	Infrastructure	Servers	Servers expense	16018.00	CC-SALES	Approved	Cash	Vendor 22	2025-12-13 07:11:45.467881
172	1	2023-09-27	4	Payroll	Bonuses	Bonuses expense	9130.00	CC-OPS	Approved	Cash	Vendor 14	2025-12-13 07:11:45.467881
173	1	2024-03-12	1	Travel	Transportation	Transportation expense	2238.00	CC-SALES	Approved	Bank Transfer	Vendor 12	2025-12-13 07:11:45.467881
174	1	2023-07-07	4	Infrastructure	Servers	Servers expense	18564.00	CC-OPS	Approved	Credit Card	Vendor 26	2025-12-13 07:11:45.467881
175	1	2023-03-17	1	Travel	Meals	Meals expense	3497.00	CC-SALES	Rejected	Check	Vendor 17	2025-12-13 07:11:45.467881
176	1	2024-05-30	3	Travel	Meals	Meals expense	1353.00	CC-HR	Pending	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
177	1	2023-01-08	4	Travel	Transportation	Transportation expense	288.00	CC-OPS	Approved	Cash	Vendor 41	2025-12-13 07:11:45.467881
178	1	2023-08-01	1	Marketing	Advertising	Advertising expense	982.00	CC-SALES	Approved	Cash	Vendor 32	2025-12-13 07:11:45.467881
179	1	2024-12-11	4	Payroll	Benefits	Benefits expense	16605.00	CC-OPS	Pending	Check	Vendor 39	2025-12-13 07:11:45.467881
180	1	2023-03-14	4	Operations	Equipment	Equipment expense	2825.00	CC-OPS	Pending	Bank Transfer	Vendor 1	2025-12-13 07:11:45.467881
181	1	2023-07-21	5	Infrastructure	Networking	Networking expense	14914.00	CC-MKT	Approved	Credit Card	Vendor 37	2025-12-13 07:11:45.467881
182	1	2024-04-23	4	Travel	Hotels	Hotels expense	2822.00	CC-OPS	Approved	Cash	Vendor 37	2025-12-13 07:11:45.467881
183	1	2024-01-14	5	Marketing	Events	Events expense	2611.00	CC-MKT	Approved	Credit Card	Vendor 1	2025-12-13 07:11:45.467881
184	1	2023-05-15	1	Infrastructure	Software Licenses	Software Licenses expense	8454.00	CC-SALES	Approved	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
185	1	2024-06-26	2	Marketing	Content	Content expense	607.00	CC-FIN	Approved	Credit Card	Vendor 12	2025-12-13 07:11:45.467881
186	1	2024-11-23	4	Infrastructure	Cloud Services	Cloud Services expense	18939.00	CC-OPS	Rejected	Check	Vendor 43	2025-12-13 07:11:45.467881
187	1	2024-09-22	5	Marketing	Events	Events expense	3908.00	CC-MKT	Approved	Check	Vendor 16	2025-12-13 07:11:45.467881
188	1	2024-09-20	2	Infrastructure	Networking	Networking expense	4322.00	CC-FIN	Approved	Check	Vendor 3	2025-12-13 07:11:45.467881
189	1	2023-01-21	1	Payroll	Benefits	Benefits expense	43285.00	CC-SALES	Approved	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
190	1	2024-07-21	2	Infrastructure	Cloud Services	Cloud Services expense	14996.00	CC-FIN	Pending	Cash	Vendor 47	2025-12-13 07:11:45.467881
191	1	2024-11-28	4	Marketing	Events	Events expense	378.00	CC-OPS	Approved	Credit Card	Vendor 34	2025-12-13 07:11:45.467881
192	1	2023-07-07	5	Travel	Transportation	Transportation expense	2104.00	CC-MKT	Pending	Cash	Vendor 31	2025-12-13 07:11:45.467881
193	1	2024-03-27	3	Travel	Flights	Flights expense	2144.00	CC-HR	Approved	Bank Transfer	Vendor 2	2025-12-13 07:11:45.467881
194	1	2023-06-30	1	Infrastructure	Cloud Services	Cloud Services expense	5108.00	CC-SALES	Rejected	Credit Card	Vendor 31	2025-12-13 07:11:45.467881
195	1	2023-04-01	2	Travel	Flights	Flights expense	3707.00	CC-FIN	Rejected	Check	Vendor 21	2025-12-13 07:11:45.467881
196	1	2023-05-04	2	Travel	Hotels	Hotels expense	1354.00	CC-FIN	Pending	Check	Vendor 24	2025-12-13 07:11:45.467881
197	1	2024-11-28	2	Marketing	Advertising	Advertising expense	2944.00	CC-FIN	Approved	Bank Transfer	Vendor 3	2025-12-13 07:11:45.467881
198	1	2023-12-21	2	Infrastructure	Servers	Servers expense	3426.00	CC-FIN	Pending	Cash	Vendor 24	2025-12-13 07:11:45.467881
199	1	2023-01-26	5	Payroll	Salaries	Salaries expense	18258.00	CC-MKT	Pending	Credit Card	Vendor 24	2025-12-13 07:11:45.467881
200	1	2023-03-15	4	Travel	Meals	Meals expense	1084.00	CC-OPS	Approved	Bank Transfer	Vendor 39	2025-12-13 07:11:45.467881
201	1	2023-10-13	2	Infrastructure	Cloud Services	Cloud Services expense	10750.00	CC-FIN	Rejected	Bank Transfer	Vendor 26	2025-12-13 07:11:45.467881
202	1	2024-02-05	3	Travel	Transportation	Transportation expense	2496.00	CC-HR	Pending	Check	Vendor 24	2025-12-13 07:11:45.467881
203	1	2024-10-21	1	Payroll	Benefits	Benefits expense	20443.00	CC-SALES	Approved	Check	Vendor 41	2025-12-13 07:11:45.467881
204	1	2023-09-15	1	Travel	Meals	Meals expense	4118.00	CC-SALES	Approved	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
205	1	2024-05-13	5	Marketing	Advertising	Advertising expense	2585.00	CC-MKT	Rejected	Check	Vendor 15	2025-12-13 07:11:45.467881
206	1	2024-10-05	5	Marketing	Social Media	Social Media expense	3330.00	CC-MKT	Pending	Check	Vendor 1	2025-12-13 07:11:45.467881
207	1	2023-01-15	2	Operations	Maintenance	Maintenance expense	341.00	CC-FIN	Pending	Check	Vendor 21	2025-12-13 07:11:45.467881
208	1	2024-06-26	2	Payroll	Bonuses	Bonuses expense	39066.00	CC-FIN	Rejected	Bank Transfer	Vendor 9	2025-12-13 07:11:45.467881
209	1	2023-02-16	3	Operations	Maintenance	Maintenance expense	3053.00	CC-HR	Rejected	Check	Vendor 44	2025-12-13 07:11:45.467881
210	1	2024-11-13	1	Infrastructure	Networking	Networking expense	15467.00	CC-SALES	Rejected	Credit Card	Vendor 38	2025-12-13 07:11:45.467881
211	1	2024-01-06	3	Travel	Transportation	Transportation expense	2283.00	CC-HR	Approved	Cash	Vendor 17	2025-12-13 07:11:45.467881
212	1	2023-06-29	4	Operations	Equipment	Equipment expense	4029.00	CC-OPS	Approved	Credit Card	Vendor 27	2025-12-13 07:11:45.467881
213	1	2024-08-23	5	Infrastructure	Cloud Services	Cloud Services expense	3442.00	CC-MKT	Approved	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
214	1	2024-03-02	3	Payroll	Salaries	Salaries expense	29747.00	CC-HR	Rejected	Bank Transfer	Vendor 17	2025-12-13 07:11:45.467881
215	1	2024-07-23	2	Travel	Flights	Flights expense	534.00	CC-FIN	Approved	Check	Vendor 16	2025-12-13 07:11:45.467881
216	1	2024-07-28	5	Operations	Equipment	Equipment expense	1780.00	CC-MKT	Approved	Credit Card	Vendor 36	2025-12-13 07:11:45.467881
217	1	2024-09-14	3	Marketing	Advertising	Advertising expense	4752.00	CC-HR	Approved	Bank Transfer	Vendor 13	2025-12-13 07:11:45.467881
218	1	2023-05-13	4	Infrastructure	Networking	Networking expense	3502.00	CC-OPS	Approved	Check	Vendor 23	2025-12-13 07:11:45.467881
219	1	2024-02-29	2	Payroll	Overtime	Overtime expense	47735.00	CC-FIN	Approved	Credit Card	Vendor 41	2025-12-13 07:11:45.467881
220	1	2024-09-21	2	Travel	Hotels	Hotels expense	817.00	CC-FIN	Rejected	Credit Card	Vendor 3	2025-12-13 07:11:45.467881
221	1	2023-10-23	4	Travel	Meals	Meals expense	4344.00	CC-OPS	Approved	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
222	1	2023-06-14	3	Travel	Transportation	Transportation expense	4560.00	CC-HR	Pending	Bank Transfer	Vendor 5	2025-12-13 07:11:45.467881
223	1	2024-12-29	2	Payroll	Overtime	Overtime expense	43961.00	CC-FIN	Approved	Credit Card	Vendor 50	2025-12-13 07:11:45.467881
224	1	2023-06-02	4	Infrastructure	Networking	Networking expense	15155.00	CC-OPS	Approved	Credit Card	Vendor 18	2025-12-13 07:11:45.467881
225	1	2024-10-04	2	Payroll	Overtime	Overtime expense	14963.00	CC-FIN	Pending	Cash	Vendor 22	2025-12-13 07:11:45.467881
226	1	2024-05-27	1	Payroll	Bonuses	Bonuses expense	18994.00	CC-SALES	Approved	Cash	Vendor 3	2025-12-13 07:11:45.467881
227	1	2023-12-11	1	Travel	Hotels	Hotels expense	168.00	CC-SALES	Approved	Check	Vendor 16	2025-12-13 07:11:45.467881
228	1	2024-01-03	5	Operations	Office Supplies	Office Supplies expense	2808.00	CC-MKT	Approved	Check	Vendor 48	2025-12-13 07:11:45.467881
229	1	2023-11-16	1	Operations	Equipment	Equipment expense	2724.00	CC-SALES	Approved	Bank Transfer	Vendor 9	2025-12-13 07:11:45.467881
230	1	2023-09-29	1	Payroll	Benefits	Benefits expense	22088.00	CC-SALES	Rejected	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
231	1	2024-12-28	3	Marketing	Advertising	Advertising expense	1155.00	CC-HR	Pending	Bank Transfer	Vendor 46	2025-12-13 07:11:45.467881
232	1	2024-10-18	3	Payroll	Bonuses	Bonuses expense	25463.00	CC-HR	Pending	Check	Vendor 50	2025-12-13 07:11:45.467881
233	1	2023-04-02	1	Payroll	Salaries	Salaries expense	41170.00	CC-SALES	Approved	Check	Vendor 35	2025-12-13 07:11:45.467881
234	1	2023-01-12	4	Travel	Flights	Flights expense	1080.00	CC-OPS	Approved	Cash	Vendor 21	2025-12-13 07:11:45.467881
235	1	2023-05-27	1	Operations	Office Supplies	Office Supplies expense	763.00	CC-SALES	Approved	Check	Vendor 40	2025-12-13 07:11:45.467881
236	1	2023-06-01	2	Travel	Flights	Flights expense	2116.00	CC-FIN	Approved	Bank Transfer	Vendor 4	2025-12-13 07:11:45.467881
237	1	2023-12-16	4	Payroll	Bonuses	Bonuses expense	14046.00	CC-OPS	Pending	Bank Transfer	Vendor 27	2025-12-13 07:11:45.467881
238	1	2024-11-05	1	Payroll	Bonuses	Bonuses expense	26725.00	CC-SALES	Rejected	Check	Vendor 20	2025-12-13 07:11:45.467881
239	1	2024-04-05	2	Operations	Equipment	Equipment expense	4264.00	CC-FIN	Approved	Credit Card	Vendor 12	2025-12-13 07:11:45.467881
240	1	2024-11-14	1	Operations	Maintenance	Maintenance expense	1111.00	CC-SALES	Approved	Cash	Vendor 16	2025-12-13 07:11:45.467881
241	1	2024-08-15	1	Operations	Equipment	Equipment expense	865.00	CC-SALES	Rejected	Check	Vendor 42	2025-12-13 07:11:45.467881
242	1	2023-03-19	4	Marketing	Content	Content expense	3879.00	CC-OPS	Pending	Check	Vendor 1	2025-12-13 07:11:45.467881
243	1	2024-11-05	3	Marketing	Advertising	Advertising expense	981.00	CC-HR	Approved	Check	Vendor 6	2025-12-13 07:11:45.467881
244	1	2024-09-22	5	Operations	Maintenance	Maintenance expense	745.00	CC-MKT	Pending	Check	Vendor 2	2025-12-13 07:11:45.467881
245	1	2024-01-14	3	Travel	Transportation	Transportation expense	2171.00	CC-HR	Approved	Cash	Vendor 13	2025-12-13 07:11:45.467881
246	1	2023-02-01	3	Operations	Maintenance	Maintenance expense	2887.00	CC-HR	Pending	Cash	Vendor 41	2025-12-13 07:11:45.467881
247	1	2024-04-27	5	Travel	Hotels	Hotels expense	3341.00	CC-MKT	Approved	Bank Transfer	Vendor 35	2025-12-13 07:11:45.467881
248	1	2023-12-30	4	Payroll	Benefits	Benefits expense	43796.00	CC-OPS	Pending	Cash	Vendor 36	2025-12-13 07:11:45.467881
249	1	2024-04-08	5	Infrastructure	Servers	Servers expense	9603.00	CC-MKT	Approved	Check	Vendor 32	2025-12-13 07:11:45.467881
250	1	2023-03-08	5	Travel	Transportation	Transportation expense	1133.00	CC-MKT	Approved	Cash	Vendor 14	2025-12-13 07:11:45.467881
251	1	2023-08-02	4	Operations	Office Supplies	Office Supplies expense	3734.00	CC-OPS	Pending	Credit Card	Vendor 1	2025-12-13 07:11:45.467881
252	1	2024-11-28	4	Payroll	Benefits	Benefits expense	37274.00	CC-OPS	Approved	Credit Card	Vendor 36	2025-12-13 07:11:45.467881
253	1	2023-01-30	3	Infrastructure	Networking	Networking expense	5239.00	CC-HR	Approved	Check	Vendor 9	2025-12-13 07:11:45.467881
254	1	2023-05-17	5	Payroll	Salaries	Salaries expense	13773.00	CC-MKT	Rejected	Check	Vendor 42	2025-12-13 07:11:45.467881
255	1	2024-01-09	5	Marketing	Social Media	Social Media expense	803.00	CC-MKT	Approved	Bank Transfer	Vendor 28	2025-12-13 07:11:45.467881
256	1	2023-04-09	1	Infrastructure	Networking	Networking expense	1232.00	CC-SALES	Approved	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
257	1	2023-05-17	1	Payroll	Bonuses	Bonuses expense	25373.00	CC-SALES	Pending	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
258	1	2023-09-01	1	Operations	Equipment	Equipment expense	4931.00	CC-SALES	Rejected	Bank Transfer	Vendor 43	2025-12-13 07:11:45.467881
259	1	2024-07-29	3	Operations	Office Supplies	Office Supplies expense	284.00	CC-HR	Approved	Cash	Vendor 48	2025-12-13 07:11:45.467881
260	1	2023-08-11	5	Travel	Hotels	Hotels expense	2066.00	CC-MKT	Pending	Bank Transfer	Vendor 48	2025-12-13 07:11:45.467881
261	1	2024-07-06	5	Operations	Equipment	Equipment expense	1370.00	CC-MKT	Pending	Credit Card	Vendor 24	2025-12-13 07:11:45.467881
262	1	2024-03-29	2	Operations	Office Supplies	Office Supplies expense	4331.00	CC-FIN	Approved	Cash	Vendor 5	2025-12-13 07:11:45.467881
263	1	2023-02-08	4	Infrastructure	Servers	Servers expense	1623.00	CC-OPS	Rejected	Credit Card	Vendor 2	2025-12-13 07:11:45.467881
264	1	2024-11-26	5	Operations	Office Supplies	Office Supplies expense	4974.00	CC-MKT	Rejected	Check	Vendor 46	2025-12-13 07:11:45.467881
265	1	2023-09-22	2	Infrastructure	Software Licenses	Software Licenses expense	18086.00	CC-FIN	Approved	Check	Vendor 3	2025-12-13 07:11:45.467881
266	1	2024-07-06	5	Travel	Flights	Flights expense	3867.00	CC-MKT	Approved	Check	Vendor 28	2025-12-13 07:11:45.467881
267	1	2024-12-27	1	Travel	Meals	Meals expense	148.00	CC-SALES	Pending	Cash	Vendor 36	2025-12-13 07:11:45.467881
268	1	2024-03-08	2	Travel	Meals	Meals expense	3687.00	CC-FIN	Approved	Cash	Vendor 40	2025-12-13 07:11:45.467881
269	1	2024-06-29	5	Marketing	Social Media	Social Media expense	1349.00	CC-MKT	Approved	Check	Vendor 6	2025-12-13 07:11:45.467881
270	1	2023-08-25	4	Travel	Hotels	Hotels expense	2636.00	CC-OPS	Approved	Cash	Vendor 35	2025-12-13 07:11:45.467881
271	1	2024-03-18	4	Infrastructure	Servers	Servers expense	10758.00	CC-OPS	Approved	Bank Transfer	Vendor 37	2025-12-13 07:11:45.467881
272	1	2024-08-24	1	Infrastructure	Networking	Networking expense	14195.00	CC-SALES	Approved	Bank Transfer	Vendor 41	2025-12-13 07:11:45.467881
273	1	2023-10-13	2	Operations	Maintenance	Maintenance expense	4631.00	CC-FIN	Pending	Check	Vendor 10	2025-12-13 07:11:45.467881
274	1	2023-09-05	3	Travel	Flights	Flights expense	3450.00	CC-HR	Approved	Cash	Vendor 38	2025-12-13 07:11:45.467881
275	1	2024-01-02	3	Infrastructure	Software Licenses	Software Licenses expense	18127.00	CC-HR	Rejected	Cash	Vendor 3	2025-12-13 07:11:45.467881
276	1	2024-01-16	5	Marketing	Content	Content expense	1796.00	CC-MKT	Approved	Credit Card	Vendor 13	2025-12-13 07:11:45.467881
277	1	2023-06-02	4	Payroll	Salaries	Salaries expense	35580.00	CC-OPS	Approved	Check	Vendor 40	2025-12-13 07:11:45.467881
278	1	2023-11-15	4	Infrastructure	Software Licenses	Software Licenses expense	2656.00	CC-OPS	Approved	Bank Transfer	Vendor 24	2025-12-13 07:11:45.467881
279	1	2024-10-12	3	Marketing	Advertising	Advertising expense	2334.00	CC-HR	Rejected	Check	Vendor 46	2025-12-13 07:11:45.467881
280	1	2024-01-19	4	Payroll	Bonuses	Bonuses expense	45283.00	CC-OPS	Approved	Check	Vendor 29	2025-12-13 07:11:45.467881
281	1	2024-07-30	2	Infrastructure	Networking	Networking expense	17029.00	CC-FIN	Rejected	Bank Transfer	Vendor 8	2025-12-13 07:11:45.467881
282	1	2023-08-10	5	Infrastructure	Networking	Networking expense	7568.00	CC-MKT	Approved	Credit Card	Vendor 39	2025-12-13 07:11:45.467881
283	1	2023-08-14	3	Operations	Utilities	Utilities expense	1021.00	CC-HR	Approved	Check	Vendor 50	2025-12-13 07:11:45.467881
284	1	2023-02-13	4	Travel	Hotels	Hotels expense	3001.00	CC-OPS	Approved	Bank Transfer	Vendor 21	2025-12-13 07:11:45.467881
285	1	2023-11-02	3	Operations	Utilities	Utilities expense	4724.00	CC-HR	Pending	Bank Transfer	Vendor 33	2025-12-13 07:11:45.467881
286	1	2023-09-29	2	Payroll	Benefits	Benefits expense	38438.00	CC-FIN	Rejected	Credit Card	Vendor 6	2025-12-13 07:11:45.467881
287	1	2023-03-12	1	Travel	Transportation	Transportation expense	4406.00	CC-SALES	Approved	Credit Card	Vendor 50	2025-12-13 07:11:45.467881
288	1	2024-11-10	4	Operations	Utilities	Utilities expense	364.00	CC-OPS	Approved	Bank Transfer	Vendor 33	2025-12-13 07:11:45.467881
289	1	2023-03-18	1	Infrastructure	Servers	Servers expense	18972.00	CC-SALES	Approved	Check	Vendor 20	2025-12-13 07:11:45.467881
290	1	2023-03-05	4	Payroll	Salaries	Salaries expense	30566.00	CC-OPS	Rejected	Cash	Vendor 38	2025-12-13 07:11:45.467881
291	1	2023-03-13	3	Marketing	Advertising	Advertising expense	1877.00	CC-HR	Approved	Cash	Vendor 39	2025-12-13 07:11:45.467881
292	1	2024-11-05	5	Travel	Hotels	Hotels expense	516.00	CC-MKT	Pending	Bank Transfer	Vendor 41	2025-12-13 07:11:45.467881
293	1	2023-01-28	2	Infrastructure	Cloud Services	Cloud Services expense	2836.00	CC-FIN	Rejected	Cash	Vendor 38	2025-12-13 07:11:45.467881
294	1	2024-10-16	1	Infrastructure	Software Licenses	Software Licenses expense	12344.00	CC-SALES	Approved	Bank Transfer	Vendor 12	2025-12-13 07:11:45.467881
295	1	2023-09-21	4	Payroll	Benefits	Benefits expense	31592.00	CC-OPS	Approved	Check	Vendor 8	2025-12-13 07:11:45.467881
296	1	2024-09-02	5	Marketing	Advertising	Advertising expense	3964.00	CC-MKT	Approved	Bank Transfer	Vendor 18	2025-12-13 07:11:45.467881
297	1	2023-02-16	4	Marketing	Events	Events expense	3713.00	CC-OPS	Approved	Bank Transfer	Vendor 43	2025-12-13 07:11:45.467881
298	1	2023-06-16	5	Operations	Maintenance	Maintenance expense	796.00	CC-MKT	Rejected	Credit Card	Vendor 11	2025-12-13 07:11:45.467881
299	1	2023-05-28	2	Operations	Equipment	Equipment expense	4552.00	CC-FIN	Approved	Cash	Vendor 48	2025-12-13 07:11:45.467881
301	2	2023-04-03	2	Operations	Office Supplies	Office Supplies expense	504.00	CC-FIN	Pending	Check	Vendor 7	2025-12-13 07:11:45.467881
302	2	2024-05-18	3	Infrastructure	Cloud Services	Cloud Services expense	4207.00	CC-HR	Approved	Bank Transfer	Vendor 35	2025-12-13 07:11:45.467881
303	2	2024-10-15	2	Marketing	Advertising	Advertising expense	4234.00	CC-FIN	Pending	Check	Vendor 48	2025-12-13 07:11:45.467881
304	2	2023-08-10	4	Operations	Equipment	Equipment expense	1826.00	CC-OPS	Approved	Credit Card	Vendor 25	2025-12-13 07:11:45.467881
305	2	2024-12-25	3	Operations	Utilities	Utilities expense	2345.00	CC-HR	Approved	Cash	Vendor 23	2025-12-13 07:11:45.467881
306	2	2023-01-01	5	Payroll	Benefits	Benefits expense	32047.00	CC-MKT	Pending	Credit Card	Vendor 10	2025-12-13 07:11:45.467881
307	2	2024-07-14	5	Marketing	Content	Content expense	1175.00	CC-MKT	Approved	Bank Transfer	Vendor 35	2025-12-13 07:11:45.467881
308	2	2024-09-24	2	Travel	Hotels	Hotels expense	2438.00	CC-FIN	Approved	Check	Vendor 25	2025-12-13 07:11:45.467881
309	2	2023-11-23	4	Payroll	Bonuses	Bonuses expense	5300.00	CC-OPS	Approved	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
310	2	2023-08-06	2	Travel	Meals	Meals expense	3841.00	CC-FIN	Approved	Bank Transfer	Vendor 22	2025-12-13 07:11:45.467881
311	2	2023-09-07	2	Marketing	Advertising	Advertising expense	3399.00	CC-FIN	Approved	Check	Vendor 3	2025-12-13 07:11:45.467881
312	2	2024-01-29	2	Infrastructure	Servers	Servers expense	16642.00	CC-FIN	Pending	Check	Vendor 30	2025-12-13 07:11:45.467881
313	2	2024-07-17	5	Marketing	Advertising	Advertising expense	2103.00	CC-MKT	Approved	Bank Transfer	Vendor 29	2025-12-13 07:11:45.467881
314	2	2023-07-12	2	Infrastructure	Cloud Services	Cloud Services expense	15825.00	CC-FIN	Pending	Cash	Vendor 14	2025-12-13 07:11:45.467881
315	2	2024-01-10	2	Payroll	Bonuses	Bonuses expense	29607.00	CC-FIN	Rejected	Cash	Vendor 44	2025-12-13 07:11:45.467881
316	2	2023-05-15	5	Operations	Office Supplies	Office Supplies expense	4651.00	CC-MKT	Rejected	Cash	Vendor 11	2025-12-13 07:11:45.467881
317	2	2023-03-27	1	Infrastructure	Software Licenses	Software Licenses expense	14885.00	CC-SALES	Pending	Bank Transfer	Vendor 29	2025-12-13 07:11:45.467881
318	2	2024-01-14	5	Travel	Transportation	Transportation expense	4460.00	CC-MKT	Pending	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
319	2	2023-03-21	2	Travel	Hotels	Hotels expense	3456.00	CC-FIN	Approved	Credit Card	Vendor 48	2025-12-13 07:11:45.467881
320	2	2024-07-13	1	Payroll	Overtime	Overtime expense	28236.00	CC-SALES	Rejected	Check	Vendor 19	2025-12-13 07:11:45.467881
321	2	2024-09-26	2	Infrastructure	Cloud Services	Cloud Services expense	1708.00	CC-FIN	Rejected	Check	Vendor 41	2025-12-13 07:11:45.467881
322	2	2024-03-02	3	Payroll	Bonuses	Bonuses expense	34070.00	CC-HR	Pending	Credit Card	Vendor 33	2025-12-13 07:11:45.467881
323	2	2024-01-05	3	Marketing	Events	Events expense	4756.00	CC-HR	Approved	Check	Vendor 8	2025-12-13 07:11:45.467881
324	2	2023-04-02	2	Payroll	Bonuses	Bonuses expense	15895.00	CC-FIN	Pending	Credit Card	Vendor 28	2025-12-13 07:11:45.467881
325	2	2023-08-15	2	Marketing	Social Media	Social Media expense	3491.00	CC-FIN	Approved	Bank Transfer	Vendor 23	2025-12-13 07:11:45.467881
326	2	2023-03-13	1	Operations	Maintenance	Maintenance expense	4053.00	CC-SALES	Approved	Check	Vendor 1	2025-12-13 07:11:45.467881
327	2	2024-01-03	4	Payroll	Salaries	Salaries expense	17230.00	CC-OPS	Rejected	Check	Vendor 34	2025-12-13 07:11:45.467881
328	2	2024-11-29	5	Travel	Flights	Flights expense	223.00	CC-MKT	Rejected	Cash	Vendor 24	2025-12-13 07:11:45.467881
329	2	2024-01-05	4	Operations	Utilities	Utilities expense	1220.00	CC-OPS	Approved	Credit Card	Vendor 48	2025-12-13 07:11:45.467881
330	2	2024-10-23	5	Infrastructure	Software Licenses	Software Licenses expense	3823.00	CC-MKT	Approved	Bank Transfer	Vendor 49	2025-12-13 07:11:45.467881
331	2	2024-05-30	2	Marketing	Advertising	Advertising expense	303.00	CC-FIN	Pending	Check	Vendor 50	2025-12-13 07:11:45.467881
332	2	2024-10-27	5	Operations	Maintenance	Maintenance expense	1701.00	CC-MKT	Pending	Cash	Vendor 13	2025-12-13 07:11:45.467881
333	2	2023-09-27	4	Infrastructure	Cloud Services	Cloud Services expense	12852.00	CC-OPS	Approved	Check	Vendor 42	2025-12-13 07:11:45.467881
334	2	2024-04-24	2	Marketing	Advertising	Advertising expense	1386.00	CC-FIN	Approved	Cash	Vendor 42	2025-12-13 07:11:45.467881
335	2	2024-02-05	1	Operations	Office Supplies	Office Supplies expense	3229.00	CC-SALES	Approved	Bank Transfer	Vendor 16	2025-12-13 07:11:45.467881
336	2	2023-05-23	2	Operations	Equipment	Equipment expense	4396.00	CC-FIN	Pending	Check	Vendor 10	2025-12-13 07:11:45.467881
337	2	2023-05-18	4	Payroll	Overtime	Overtime expense	45777.00	CC-OPS	Pending	Check	Vendor 34	2025-12-13 07:11:45.467881
338	2	2024-07-04	5	Operations	Office Supplies	Office Supplies expense	2694.00	CC-MKT	Rejected	Cash	Vendor 45	2025-12-13 07:11:45.467881
339	2	2024-07-20	5	Operations	Equipment	Equipment expense	1383.00	CC-MKT	Approved	Credit Card	Vendor 15	2025-12-13 07:11:45.467881
340	2	2024-11-25	1	Payroll	Salaries	Salaries expense	10653.00	CC-SALES	Approved	Check	Vendor 32	2025-12-13 07:11:45.467881
341	2	2024-06-21	4	Marketing	Social Media	Social Media expense	3294.00	CC-OPS	Approved	Check	Vendor 10	2025-12-13 07:11:45.467881
342	2	2024-08-14	4	Travel	Hotels	Hotels expense	3692.00	CC-OPS	Approved	Check	Vendor 45	2025-12-13 07:11:45.467881
343	2	2023-04-15	4	Infrastructure	Software Licenses	Software Licenses expense	12149.00	CC-OPS	Approved	Check	Vendor 8	2025-12-13 07:11:45.467881
344	2	2023-07-17	2	Travel	Transportation	Transportation expense	3118.00	CC-FIN	Approved	Credit Card	Vendor 24	2025-12-13 07:11:45.467881
345	2	2023-01-20	1	Marketing	Social Media	Social Media expense	3098.00	CC-SALES	Approved	Cash	Vendor 29	2025-12-13 07:11:45.467881
346	2	2024-03-12	3	Infrastructure	Servers	Servers expense	14857.00	CC-HR	Approved	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
347	2	2023-10-11	5	Operations	Utilities	Utilities expense	3522.00	CC-MKT	Approved	Check	Vendor 28	2025-12-13 07:11:45.467881
348	2	2024-03-30	1	Payroll	Salaries	Salaries expense	26335.00	CC-SALES	Approved	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
349	2	2024-12-13	5	Infrastructure	Networking	Networking expense	1440.00	CC-MKT	Rejected	Check	Vendor 6	2025-12-13 07:11:45.467881
350	2	2023-06-24	5	Marketing	Social Media	Social Media expense	1491.00	CC-MKT	Pending	Bank Transfer	Vendor 44	2025-12-13 07:11:45.467881
351	2	2024-12-24	4	Marketing	Events	Events expense	830.00	CC-OPS	Approved	Cash	Vendor 22	2025-12-13 07:11:45.467881
352	2	2024-04-06	4	Marketing	Advertising	Advertising expense	4397.00	CC-OPS	Rejected	Cash	Vendor 40	2025-12-13 07:11:45.467881
353	2	2023-08-16	5	Travel	Flights	Flights expense	4567.00	CC-MKT	Approved	Check	Vendor 9	2025-12-13 07:11:45.467881
354	2	2024-06-11	5	Marketing	Content	Content expense	2043.00	CC-MKT	Approved	Credit Card	Vendor 36	2025-12-13 07:11:45.467881
355	2	2023-10-30	2	Infrastructure	Software Licenses	Software Licenses expense	11336.00	CC-FIN	Approved	Check	Vendor 45	2025-12-13 07:11:45.467881
356	2	2024-02-26	1	Marketing	Events	Events expense	1673.00	CC-SALES	Approved	Check	Vendor 6	2025-12-13 07:11:45.467881
357	2	2023-07-22	2	Operations	Office Supplies	Office Supplies expense	3471.00	CC-FIN	Rejected	Credit Card	Vendor 46	2025-12-13 07:11:45.467881
358	2	2023-11-10	1	Operations	Utilities	Utilities expense	1252.00	CC-SALES	Approved	Credit Card	Vendor 47	2025-12-13 07:11:45.467881
359	2	2024-09-15	2	Infrastructure	Networking	Networking expense	14056.00	CC-FIN	Approved	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
360	2	2024-02-13	5	Infrastructure	Software Licenses	Software Licenses expense	2930.00	CC-MKT	Approved	Cash	Vendor 25	2025-12-13 07:11:45.467881
361	2	2023-10-29	1	Infrastructure	Networking	Networking expense	16196.00	CC-SALES	Approved	Check	Vendor 42	2025-12-13 07:11:45.467881
362	2	2024-05-22	1	Operations	Utilities	Utilities expense	3553.00	CC-SALES	Approved	Bank Transfer	Vendor 22	2025-12-13 07:11:45.467881
363	2	2024-12-29	3	Operations	Utilities	Utilities expense	916.00	CC-HR	Rejected	Credit Card	Vendor 39	2025-12-13 07:11:45.467881
364	2	2023-03-26	1	Infrastructure	Servers	Servers expense	7440.00	CC-SALES	Approved	Credit Card	Vendor 41	2025-12-13 07:11:45.467881
365	2	2023-04-16	5	Infrastructure	Servers	Servers expense	3334.00	CC-MKT	Approved	Cash	Vendor 49	2025-12-13 07:11:45.467881
366	2	2023-02-15	3	Payroll	Overtime	Overtime expense	34922.00	CC-HR	Approved	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
367	2	2024-07-20	2	Operations	Office Supplies	Office Supplies expense	3041.00	CC-FIN	Approved	Credit Card	Vendor 37	2025-12-13 07:11:45.467881
368	2	2024-09-26	1	Marketing	Events	Events expense	1268.00	CC-SALES	Pending	Bank Transfer	Vendor 13	2025-12-13 07:11:45.467881
369	2	2023-11-02	1	Marketing	Content	Content expense	1927.00	CC-SALES	Approved	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
370	2	2024-01-16	1	Travel	Transportation	Transportation expense	3107.00	CC-SALES	Pending	Cash	Vendor 43	2025-12-13 07:11:45.467881
371	2	2024-01-19	5	Infrastructure	Software Licenses	Software Licenses expense	8122.00	CC-MKT	Approved	Cash	Vendor 40	2025-12-13 07:11:45.467881
372	2	2023-04-24	4	Marketing	Social Media	Social Media expense	1495.00	CC-OPS	Approved	Check	Vendor 27	2025-12-13 07:11:45.467881
373	2	2023-02-09	1	Marketing	Events	Events expense	1748.00	CC-SALES	Pending	Cash	Vendor 3	2025-12-13 07:11:45.467881
374	2	2023-12-24	5	Marketing	Events	Events expense	1093.00	CC-MKT	Approved	Bank Transfer	Vendor 32	2025-12-13 07:11:45.467881
375	2	2024-04-17	1	Travel	Flights	Flights expense	1341.00	CC-SALES	Pending	Cash	Vendor 6	2025-12-13 07:11:45.467881
376	2	2024-07-27	5	Operations	Office Supplies	Office Supplies expense	848.00	CC-MKT	Approved	Check	Vendor 12	2025-12-13 07:11:45.467881
377	2	2024-09-07	5	Infrastructure	Servers	Servers expense	11918.00	CC-MKT	Rejected	Bank Transfer	Vendor 49	2025-12-13 07:11:45.467881
378	2	2023-03-31	2	Marketing	Social Media	Social Media expense	3637.00	CC-FIN	Approved	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
379	2	2023-10-02	4	Travel	Meals	Meals expense	3787.00	CC-OPS	Approved	Cash	Vendor 34	2025-12-13 07:11:45.467881
380	2	2024-02-01	2	Operations	Maintenance	Maintenance expense	2840.00	CC-FIN	Approved	Bank Transfer	Vendor 17	2025-12-13 07:11:45.467881
381	2	2023-05-28	3	Marketing	Social Media	Social Media expense	3485.00	CC-HR	Approved	Credit Card	Vendor 50	2025-12-13 07:11:45.467881
382	2	2023-06-19	1	Infrastructure	Software Licenses	Software Licenses expense	19381.00	CC-SALES	Rejected	Bank Transfer	Vendor 43	2025-12-13 07:11:45.467881
383	2	2024-02-02	2	Infrastructure	Servers	Servers expense	5641.00	CC-FIN	Pending	Check	Vendor 39	2025-12-13 07:11:45.467881
384	2	2024-02-13	1	Marketing	Social Media	Social Media expense	4654.00	CC-SALES	Approved	Credit Card	Vendor 48	2025-12-13 07:11:45.467881
385	2	2023-09-28	3	Travel	Transportation	Transportation expense	759.00	CC-HR	Approved	Cash	Vendor 29	2025-12-13 07:11:45.467881
386	2	2023-12-27	2	Payroll	Bonuses	Bonuses expense	25550.00	CC-FIN	Approved	Credit Card	Vendor 39	2025-12-13 07:11:45.467881
387	2	2024-07-11	1	Payroll	Salaries	Salaries expense	12083.00	CC-SALES	Approved	Cash	Vendor 39	2025-12-13 07:11:45.467881
388	2	2023-01-03	1	Marketing	Content	Content expense	1238.00	CC-SALES	Approved	Cash	Vendor 5	2025-12-13 07:11:45.467881
389	2	2023-10-25	2	Travel	Meals	Meals expense	2181.00	CC-FIN	Rejected	Check	Vendor 1	2025-12-13 07:11:45.467881
390	2	2024-06-27	4	Travel	Transportation	Transportation expense	4465.00	CC-OPS	Approved	Cash	Vendor 14	2025-12-13 07:11:45.467881
391	2	2024-01-23	3	Payroll	Bonuses	Bonuses expense	24276.00	CC-HR	Pending	Bank Transfer	Vendor 13	2025-12-13 07:11:45.467881
392	2	2024-04-01	3	Marketing	Advertising	Advertising expense	3991.00	CC-HR	Approved	Cash	Vendor 3	2025-12-13 07:11:45.467881
393	2	2024-09-22	1	Operations	Utilities	Utilities expense	1968.00	CC-SALES	Approved	Bank Transfer	Vendor 25	2025-12-13 07:11:45.467881
394	2	2023-07-21	4	Infrastructure	Cloud Services	Cloud Services expense	4395.00	CC-OPS	Approved	Bank Transfer	Vendor 47	2025-12-13 07:11:45.467881
395	2	2023-11-27	2	Infrastructure	Software Licenses	Software Licenses expense	7944.00	CC-FIN	Approved	Bank Transfer	Vendor 46	2025-12-13 07:11:45.467881
396	2	2023-12-15	2	Infrastructure	Cloud Services	Cloud Services expense	14295.00	CC-FIN	Approved	Bank Transfer	Vendor 37	2025-12-13 07:11:45.467881
397	2	2023-08-02	5	Payroll	Benefits	Benefits expense	5179.00	CC-MKT	Approved	Credit Card	Vendor 1	2025-12-13 07:11:45.467881
398	2	2023-12-30	1	Payroll	Overtime	Overtime expense	6584.00	CC-SALES	Approved	Credit Card	Vendor 22	2025-12-13 07:11:45.467881
399	2	2023-06-26	4	Operations	Utilities	Utilities expense	3272.00	CC-OPS	Rejected	Cash	Vendor 21	2025-12-13 07:11:45.467881
400	2	2023-12-29	1	Travel	Flights	Flights expense	4445.00	CC-SALES	Rejected	Check	Vendor 33	2025-12-13 07:11:45.467881
401	2	2024-05-11	3	Travel	Flights	Flights expense	2750.00	CC-HR	Rejected	Check	Vendor 21	2025-12-13 07:11:45.467881
402	2	2023-06-28	2	Marketing	Events	Events expense	1143.00	CC-FIN	Approved	Cash	Vendor 18	2025-12-13 07:11:45.467881
403	2	2024-12-11	1	Infrastructure	Servers	Servers expense	7046.00	CC-SALES	Approved	Check	Vendor 30	2025-12-13 07:11:45.467881
404	2	2023-04-01	4	Travel	Hotels	Hotels expense	3586.00	CC-OPS	Rejected	Credit Card	Vendor 11	2025-12-13 07:11:45.467881
405	2	2024-03-09	1	Payroll	Benefits	Benefits expense	31162.00	CC-SALES	Approved	Credit Card	Vendor 5	2025-12-13 07:11:45.467881
406	2	2024-08-25	3	Travel	Transportation	Transportation expense	473.00	CC-HR	Rejected	Credit Card	Vendor 35	2025-12-13 07:11:45.467881
407	2	2024-11-02	1	Travel	Flights	Flights expense	2059.00	CC-SALES	Rejected	Check	Vendor 25	2025-12-13 07:11:45.467881
408	2	2024-09-08	5	Operations	Equipment	Equipment expense	3283.00	CC-MKT	Approved	Cash	Vendor 42	2025-12-13 07:11:45.467881
409	2	2023-11-03	1	Travel	Flights	Flights expense	4950.00	CC-SALES	Approved	Bank Transfer	Vendor 44	2025-12-13 07:11:45.467881
410	2	2024-05-26	5	Operations	Office Supplies	Office Supplies expense	4361.00	CC-MKT	Pending	Check	Vendor 50	2025-12-13 07:11:45.467881
411	2	2023-09-17	4	Travel	Flights	Flights expense	4954.00	CC-OPS	Pending	Cash	Vendor 40	2025-12-13 07:11:45.467881
412	2	2023-07-31	3	Marketing	Advertising	Advertising expense	3440.00	CC-HR	Rejected	Cash	Vendor 1	2025-12-13 07:11:45.467881
413	2	2024-05-17	4	Marketing	Social Media	Social Media expense	1334.00	CC-OPS	Rejected	Credit Card	Vendor 44	2025-12-13 07:11:45.467881
414	2	2023-08-13	3	Marketing	Advertising	Advertising expense	886.00	CC-HR	Approved	Credit Card	Vendor 3	2025-12-13 07:11:45.467881
415	2	2023-05-15	4	Infrastructure	Servers	Servers expense	12625.00	CC-OPS	Approved	Bank Transfer	Vendor 41	2025-12-13 07:11:45.467881
416	2	2024-06-26	2	Operations	Utilities	Utilities expense	914.00	CC-FIN	Rejected	Bank Transfer	Vendor 4	2025-12-13 07:11:45.467881
417	2	2024-08-31	5	Infrastructure	Servers	Servers expense	8522.00	CC-MKT	Rejected	Cash	Vendor 35	2025-12-13 07:11:45.467881
418	2	2023-04-10	4	Travel	Flights	Flights expense	776.00	CC-OPS	Rejected	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
419	2	2024-05-13	2	Marketing	Events	Events expense	1119.00	CC-FIN	Pending	Bank Transfer	Vendor 12	2025-12-13 07:11:45.467881
420	2	2024-09-08	5	Payroll	Salaries	Salaries expense	26612.00	CC-MKT	Approved	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
421	2	2023-11-10	5	Infrastructure	Networking	Networking expense	8136.00	CC-MKT	Rejected	Bank Transfer	Vendor 9	2025-12-13 07:11:45.467881
422	2	2024-12-11	3	Payroll	Benefits	Benefits expense	48907.00	CC-HR	Pending	Cash	Vendor 40	2025-12-13 07:11:45.467881
423	2	2023-06-10	4	Payroll	Benefits	Benefits expense	27751.00	CC-OPS	Pending	Cash	Vendor 45	2025-12-13 07:11:45.467881
424	2	2024-12-16	5	Infrastructure	Cloud Services	Cloud Services expense	13451.00	CC-MKT	Approved	Cash	Vendor 39	2025-12-13 07:11:45.467881
425	2	2023-05-11	2	Operations	Maintenance	Maintenance expense	2468.00	CC-FIN	Rejected	Bank Transfer	Vendor 25	2025-12-13 07:11:45.467881
426	2	2024-09-04	4	Payroll	Overtime	Overtime expense	12621.00	CC-OPS	Pending	Bank Transfer	Vendor 39	2025-12-13 07:11:45.467881
427	2	2024-09-13	2	Operations	Maintenance	Maintenance expense	1462.00	CC-FIN	Approved	Cash	Vendor 2	2025-12-13 07:11:45.467881
428	2	2023-04-21	3	Payroll	Overtime	Overtime expense	24881.00	CC-HR	Approved	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
429	2	2024-02-05	1	Operations	Maintenance	Maintenance expense	2180.00	CC-SALES	Approved	Cash	Vendor 13	2025-12-13 07:11:45.467881
430	2	2024-12-31	3	Marketing	Advertising	Advertising expense	523.00	CC-HR	Pending	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
431	2	2023-01-15	5	Marketing	Advertising	Advertising expense	3413.00	CC-MKT	Approved	Check	Vendor 34	2025-12-13 07:11:45.467881
432	2	2024-11-27	5	Payroll	Benefits	Benefits expense	9141.00	CC-MKT	Approved	Cash	Vendor 1	2025-12-13 07:11:45.467881
433	2	2024-05-12	3	Marketing	Social Media	Social Media expense	4947.00	CC-HR	Approved	Bank Transfer	Vendor 5	2025-12-13 07:11:45.467881
434	2	2023-01-30	2	Payroll	Salaries	Salaries expense	39605.00	CC-FIN	Approved	Check	Vendor 7	2025-12-13 07:11:45.467881
435	2	2024-08-07	2	Payroll	Benefits	Benefits expense	19026.00	CC-FIN	Rejected	Credit Card	Vendor 10	2025-12-13 07:11:45.467881
436	2	2023-12-24	2	Infrastructure	Servers	Servers expense	13867.00	CC-FIN	Approved	Cash	Vendor 38	2025-12-13 07:11:45.467881
437	2	2023-08-04	5	Marketing	Content	Content expense	4182.00	CC-MKT	Approved	Cash	Vendor 44	2025-12-13 07:11:45.467881
438	2	2024-04-28	4	Operations	Office Supplies	Office Supplies expense	412.00	CC-OPS	Rejected	Credit Card	Vendor 7	2025-12-13 07:11:45.467881
439	2	2024-11-09	2	Marketing	Events	Events expense	4929.00	CC-FIN	Pending	Credit Card	Vendor 3	2025-12-13 07:11:45.467881
440	2	2024-03-01	2	Operations	Maintenance	Maintenance expense	2147.00	CC-FIN	Approved	Bank Transfer	Vendor 47	2025-12-13 07:11:45.467881
441	2	2024-05-05	3	Marketing	Events	Events expense	4913.00	CC-HR	Rejected	Credit Card	Vendor 31	2025-12-13 07:11:45.467881
442	2	2023-03-05	5	Travel	Flights	Flights expense	402.00	CC-MKT	Approved	Check	Vendor 13	2025-12-13 07:11:45.467881
443	2	2023-07-19	2	Payroll	Salaries	Salaries expense	15464.00	CC-FIN	Rejected	Credit Card	Vendor 25	2025-12-13 07:11:45.467881
444	2	2024-06-09	2	Infrastructure	Software Licenses	Software Licenses expense	13871.00	CC-FIN	Approved	Cash	Vendor 6	2025-12-13 07:11:45.467881
445	2	2023-07-04	4	Payroll	Benefits	Benefits expense	26777.00	CC-OPS	Rejected	Cash	Vendor 3	2025-12-13 07:11:45.467881
446	2	2023-03-24	2	Infrastructure	Servers	Servers expense	10954.00	CC-FIN	Rejected	Check	Vendor 14	2025-12-13 07:11:45.467881
447	2	2024-11-22	5	Marketing	Advertising	Advertising expense	1027.00	CC-MKT	Approved	Bank Transfer	Vendor 29	2025-12-13 07:11:45.467881
448	2	2023-12-31	1	Payroll	Benefits	Benefits expense	42200.00	CC-SALES	Approved	Cash	Vendor 28	2025-12-13 07:11:45.467881
449	2	2024-06-06	4	Payroll	Benefits	Benefits expense	47002.00	CC-OPS	Approved	Credit Card	Vendor 16	2025-12-13 07:11:45.467881
450	2	2023-09-18	5	Infrastructure	Software Licenses	Software Licenses expense	13089.00	CC-MKT	Approved	Bank Transfer	Vendor 20	2025-12-13 07:11:45.467881
451	2	2023-09-11	2	Travel	Hotels	Hotels expense	935.00	CC-FIN	Approved	Bank Transfer	Vendor 9	2025-12-13 07:11:45.467881
452	2	2024-06-07	5	Marketing	Content	Content expense	340.00	CC-MKT	Approved	Cash	Vendor 2	2025-12-13 07:11:45.467881
453	2	2024-01-02	1	Marketing	Social Media	Social Media expense	2660.00	CC-SALES	Rejected	Cash	Vendor 38	2025-12-13 07:11:45.467881
454	2	2023-11-04	3	Marketing	Events	Events expense	4043.00	CC-HR	Approved	Bank Transfer	Vendor 33	2025-12-13 07:11:45.467881
455	2	2023-12-20	2	Marketing	Events	Events expense	779.00	CC-FIN	Pending	Credit Card	Vendor 15	2025-12-13 07:11:45.467881
456	2	2024-09-05	5	Operations	Utilities	Utilities expense	652.00	CC-MKT	Approved	Cash	Vendor 1	2025-12-13 07:11:45.467881
457	2	2024-04-15	5	Travel	Hotels	Hotels expense	1673.00	CC-MKT	Approved	Cash	Vendor 45	2025-12-13 07:11:45.467881
458	2	2023-05-09	4	Travel	Meals	Meals expense	3243.00	CC-OPS	Rejected	Check	Vendor 7	2025-12-13 07:11:45.467881
459	2	2023-10-09	1	Payroll	Benefits	Benefits expense	46998.00	CC-SALES	Rejected	Credit Card	Vendor 34	2025-12-13 07:11:45.467881
460	2	2024-11-13	5	Payroll	Salaries	Salaries expense	11004.00	CC-MKT	Rejected	Bank Transfer	Vendor 39	2025-12-13 07:11:45.467881
461	2	2023-11-12	4	Marketing	Events	Events expense	1348.00	CC-OPS	Approved	Credit Card	Vendor 8	2025-12-13 07:11:45.467881
462	2	2024-01-24	4	Payroll	Bonuses	Bonuses expense	41105.00	CC-OPS	Rejected	Check	Vendor 49	2025-12-13 07:11:45.467881
463	2	2023-03-01	5	Infrastructure	Servers	Servers expense	11541.00	CC-MKT	Rejected	Bank Transfer	Vendor 31	2025-12-13 07:11:45.467881
464	2	2024-10-30	1	Marketing	Content	Content expense	1312.00	CC-SALES	Pending	Bank Transfer	Vendor 7	2025-12-13 07:11:45.467881
465	2	2024-06-29	1	Infrastructure	Software Licenses	Software Licenses expense	11739.00	CC-SALES	Approved	Credit Card	Vendor 35	2025-12-13 07:11:45.467881
466	2	2023-04-20	1	Operations	Office Supplies	Office Supplies expense	1112.00	CC-SALES	Pending	Credit Card	Vendor 6	2025-12-13 07:11:45.467881
467	2	2023-12-01	3	Marketing	Content	Content expense	1918.00	CC-HR	Approved	Check	Vendor 50	2025-12-13 07:11:45.467881
468	2	2024-12-10	4	Travel	Flights	Flights expense	2296.00	CC-OPS	Pending	Credit Card	Vendor 26	2025-12-13 07:11:45.467881
469	2	2023-12-23	2	Operations	Utilities	Utilities expense	3864.00	CC-FIN	Approved	Cash	Vendor 31	2025-12-13 07:11:45.467881
470	2	2024-10-29	2	Infrastructure	Networking	Networking expense	19601.00	CC-FIN	Approved	Bank Transfer	Vendor 24	2025-12-13 07:11:45.467881
471	2	2024-03-12	4	Travel	Flights	Flights expense	4927.00	CC-OPS	Pending	Bank Transfer	Vendor 16	2025-12-13 07:11:45.467881
472	2	2023-07-25	1	Payroll	Salaries	Salaries expense	7753.00	CC-SALES	Approved	Check	Vendor 19	2025-12-13 07:11:45.467881
473	2	2023-02-11	3	Travel	Meals	Meals expense	1416.00	CC-HR	Rejected	Credit Card	Vendor 34	2025-12-13 07:11:45.467881
474	2	2023-03-06	5	Infrastructure	Software Licenses	Software Licenses expense	2186.00	CC-MKT	Approved	Cash	Vendor 31	2025-12-13 07:11:45.467881
475	2	2023-09-24	4	Marketing	Social Media	Social Media expense	259.00	CC-OPS	Rejected	Bank Transfer	Vendor 11	2025-12-13 07:11:45.467881
476	2	2024-09-06	2	Operations	Utilities	Utilities expense	1304.00	CC-FIN	Approved	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
477	2	2023-04-22	1	Marketing	Content	Content expense	2888.00	CC-SALES	Rejected	Check	Vendor 27	2025-12-13 07:11:45.467881
478	2	2024-01-10	3	Travel	Meals	Meals expense	2313.00	CC-HR	Approved	Credit Card	Vendor 28	2025-12-13 07:11:45.467881
479	2	2024-12-01	4	Infrastructure	Cloud Services	Cloud Services expense	3707.00	CC-OPS	Rejected	Cash	Vendor 13	2025-12-13 07:11:45.467881
480	2	2024-03-31	2	Payroll	Salaries	Salaries expense	16794.00	CC-FIN	Approved	Cash	Vendor 36	2025-12-13 07:11:45.467881
481	2	2023-07-01	5	Payroll	Salaries	Salaries expense	13348.00	CC-MKT	Pending	Bank Transfer	Vendor 14	2025-12-13 07:11:45.467881
482	2	2023-04-05	3	Payroll	Bonuses	Bonuses expense	47824.00	CC-HR	Rejected	Cash	Vendor 50	2025-12-13 07:11:45.467881
483	2	2023-04-18	2	Operations	Utilities	Utilities expense	3286.00	CC-FIN	Approved	Cash	Vendor 9	2025-12-13 07:11:45.467881
484	2	2024-10-21	4	Operations	Equipment	Equipment expense	1760.00	CC-OPS	Pending	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
485	2	2023-01-11	1	Travel	Flights	Flights expense	4207.00	CC-SALES	Rejected	Cash	Vendor 9	2025-12-13 07:11:45.467881
486	2	2024-12-12	3	Operations	Maintenance	Maintenance expense	4450.00	CC-HR	Pending	Cash	Vendor 14	2025-12-13 07:11:45.467881
487	2	2023-07-01	4	Marketing	Content	Content expense	2946.00	CC-OPS	Approved	Check	Vendor 26	2025-12-13 07:11:45.467881
488	2	2023-03-28	5	Payroll	Salaries	Salaries expense	14948.00	CC-MKT	Approved	Cash	Vendor 45	2025-12-13 07:11:45.467881
489	2	2024-05-24	4	Operations	Maintenance	Maintenance expense	2010.00	CC-OPS	Approved	Cash	Vendor 31	2025-12-13 07:11:45.467881
490	2	2023-02-28	5	Travel	Hotels	Hotels expense	4873.00	CC-MKT	Approved	Cash	Vendor 44	2025-12-13 07:11:45.467881
491	2	2023-07-14	1	Infrastructure	Servers	Servers expense	11462.00	CC-SALES	Approved	Check	Vendor 5	2025-12-13 07:11:45.467881
492	2	2023-12-10	4	Travel	Transportation	Transportation expense	2006.00	CC-OPS	Pending	Cash	Vendor 12	2025-12-13 07:11:45.467881
493	2	2023-08-22	4	Travel	Hotels	Hotels expense	616.00	CC-OPS	Rejected	Check	Vendor 49	2025-12-13 07:11:45.467881
494	2	2024-06-04	5	Operations	Office Supplies	Office Supplies expense	4269.00	CC-MKT	Approved	Credit Card	Vendor 13	2025-12-13 07:11:45.467881
495	2	2023-09-09	1	Operations	Maintenance	Maintenance expense	2846.00	CC-SALES	Approved	Cash	Vendor 46	2025-12-13 07:11:45.467881
496	2	2023-07-01	1	Travel	Meals	Meals expense	1583.00	CC-SALES	Rejected	Cash	Vendor 14	2025-12-13 07:11:45.467881
497	2	2023-12-03	2	Payroll	Salaries	Salaries expense	6030.00	CC-FIN	Approved	Cash	Vendor 17	2025-12-13 07:11:45.467881
498	2	2023-05-16	5	Marketing	Events	Events expense	1528.00	CC-MKT	Approved	Bank Transfer	Vendor 48	2025-12-13 07:11:45.467881
499	2	2023-02-17	3	Operations	Utilities	Utilities expense	1823.00	CC-HR	Approved	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
500	2	2024-07-25	1	Marketing	Advertising	Advertising expense	4735.00	CC-SALES	Approved	Cash	Vendor 29	2025-12-13 07:11:45.467881
501	2	2024-10-19	1	Marketing	Advertising	Advertising expense	2666.00	CC-SALES	Pending	Cash	Vendor 44	2025-12-13 07:11:45.467881
502	2	2024-01-25	3	Payroll	Benefits	Benefits expense	44191.00	CC-HR	Rejected	Check	Vendor 4	2025-12-13 07:11:45.467881
503	2	2024-12-15	5	Operations	Office Supplies	Office Supplies expense	684.00	CC-MKT	Approved	Credit Card	Vendor 8	2025-12-13 07:11:45.467881
504	2	2023-12-14	1	Travel	Hotels	Hotels expense	301.00	CC-SALES	Rejected	Bank Transfer	Vendor 15	2025-12-13 07:11:45.467881
505	2	2024-05-05	5	Marketing	Events	Events expense	4954.00	CC-MKT	Approved	Credit Card	Vendor 18	2025-12-13 07:11:45.467881
506	2	2023-10-11	3	Payroll	Overtime	Overtime expense	17288.00	CC-HR	Rejected	Credit Card	Vendor 2	2025-12-13 07:11:45.467881
507	2	2023-09-22	3	Travel	Transportation	Transportation expense	2746.00	CC-HR	Rejected	Credit Card	Vendor 14	2025-12-13 07:11:45.467881
508	2	2023-04-21	5	Payroll	Salaries	Salaries expense	22141.00	CC-MKT	Approved	Bank Transfer	Vendor 5	2025-12-13 07:11:45.467881
509	2	2023-12-07	2	Travel	Meals	Meals expense	2761.00	CC-FIN	Pending	Bank Transfer	Vendor 24	2025-12-13 07:11:45.467881
510	2	2024-03-10	1	Payroll	Benefits	Benefits expense	17295.00	CC-SALES	Rejected	Check	Vendor 18	2025-12-13 07:11:45.467881
511	2	2023-02-08	3	Payroll	Salaries	Salaries expense	21200.00	CC-HR	Approved	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
512	2	2024-10-21	4	Travel	Hotels	Hotels expense	3537.00	CC-OPS	Approved	Check	Vendor 10	2025-12-13 07:11:45.467881
513	2	2024-12-29	5	Travel	Meals	Meals expense	4618.00	CC-MKT	Approved	Credit Card	Vendor 50	2025-12-13 07:11:45.467881
514	2	2023-11-17	1	Operations	Utilities	Utilities expense	2923.00	CC-SALES	Pending	Check	Vendor 17	2025-12-13 07:11:45.467881
515	2	2023-06-29	1	Operations	Maintenance	Maintenance expense	2730.00	CC-SALES	Rejected	Credit Card	Vendor 23	2025-12-13 07:11:45.467881
516	2	2023-08-13	4	Operations	Utilities	Utilities expense	235.00	CC-OPS	Pending	Bank Transfer	Vendor 49	2025-12-13 07:11:45.467881
517	2	2024-12-11	1	Travel	Hotels	Hotels expense	127.00	CC-SALES	Approved	Cash	Vendor 40	2025-12-13 07:11:45.467881
518	2	2023-10-22	2	Infrastructure	Software Licenses	Software Licenses expense	8161.00	CC-FIN	Approved	Bank Transfer	Vendor 7	2025-12-13 07:11:45.467881
519	2	2024-04-09	5	Travel	Meals	Meals expense	1596.00	CC-MKT	Approved	Cash	Vendor 20	2025-12-13 07:11:45.467881
520	2	2024-09-24	1	Travel	Meals	Meals expense	2181.00	CC-SALES	Approved	Check	Vendor 6	2025-12-13 07:11:45.467881
521	2	2024-07-22	1	Travel	Flights	Flights expense	437.00	CC-SALES	Approved	Bank Transfer	Vendor 1	2025-12-13 07:11:45.467881
522	2	2023-07-23	3	Operations	Equipment	Equipment expense	3148.00	CC-HR	Approved	Cash	Vendor 9	2025-12-13 07:11:45.467881
523	2	2023-06-04	1	Infrastructure	Cloud Services	Cloud Services expense	10139.00	CC-SALES	Approved	Bank Transfer	Vendor 38	2025-12-13 07:11:45.467881
524	2	2023-12-16	2	Travel	Transportation	Transportation expense	2417.00	CC-FIN	Approved	Bank Transfer	Vendor 8	2025-12-13 07:11:45.467881
525	2	2023-01-19	1	Travel	Transportation	Transportation expense	1161.00	CC-SALES	Approved	Bank Transfer	Vendor 3	2025-12-13 07:11:45.467881
526	2	2023-02-07	3	Marketing	Social Media	Social Media expense	4567.00	CC-HR	Pending	Bank Transfer	Vendor 40	2025-12-13 07:11:45.467881
527	2	2024-05-30	5	Travel	Transportation	Transportation expense	2395.00	CC-MKT	Approved	Credit Card	Vendor 29	2025-12-13 07:11:45.467881
528	2	2023-05-19	4	Marketing	Content	Content expense	2467.00	CC-OPS	Rejected	Bank Transfer	Vendor 30	2025-12-13 07:11:45.467881
529	2	2023-12-20	5	Travel	Flights	Flights expense	4382.00	CC-MKT	Rejected	Check	Vendor 8	2025-12-13 07:11:45.467881
530	2	2024-07-25	4	Marketing	Social Media	Social Media expense	3020.00	CC-OPS	Rejected	Check	Vendor 45	2025-12-13 07:11:45.467881
531	2	2024-10-14	2	Marketing	Advertising	Advertising expense	527.00	CC-FIN	Rejected	Credit Card	Vendor 34	2025-12-13 07:11:45.467881
532	2	2024-07-30	2	Travel	Transportation	Transportation expense	2084.00	CC-FIN	Approved	Bank Transfer	Vendor 18	2025-12-13 07:11:45.467881
533	2	2023-04-02	2	Travel	Flights	Flights expense	2547.00	CC-FIN	Approved	Check	Vendor 42	2025-12-13 07:11:45.467881
534	2	2024-12-06	2	Operations	Utilities	Utilities expense	1815.00	CC-FIN	Approved	Check	Vendor 47	2025-12-13 07:11:45.467881
535	2	2024-01-24	4	Payroll	Salaries	Salaries expense	42175.00	CC-OPS	Approved	Bank Transfer	Vendor 11	2025-12-13 07:11:45.467881
536	2	2023-01-20	3	Infrastructure	Cloud Services	Cloud Services expense	7048.00	CC-HR	Approved	Cash	Vendor 41	2025-12-13 07:11:45.467881
537	2	2023-06-10	2	Operations	Office Supplies	Office Supplies expense	1314.00	CC-FIN	Rejected	Cash	Vendor 2	2025-12-13 07:11:45.467881
538	2	2024-12-03	2	Infrastructure	Networking	Networking expense	3714.00	CC-FIN	Approved	Credit Card	Vendor 16	2025-12-13 07:11:45.467881
539	2	2023-03-15	3	Payroll	Benefits	Benefits expense	45585.00	CC-HR	Approved	Cash	Vendor 38	2025-12-13 07:11:45.467881
540	2	2024-11-21	4	Travel	Transportation	Transportation expense	3078.00	CC-OPS	Approved	Cash	Vendor 36	2025-12-13 07:11:45.467881
541	2	2024-04-14	5	Infrastructure	Servers	Servers expense	4709.00	CC-MKT	Pending	Credit Card	Vendor 48	2025-12-13 07:11:45.467881
542	2	2023-11-22	2	Marketing	Content	Content expense	2357.00	CC-FIN	Approved	Check	Vendor 31	2025-12-13 07:11:45.467881
543	2	2023-04-29	3	Travel	Hotels	Hotels expense	4677.00	CC-HR	Pending	Cash	Vendor 8	2025-12-13 07:11:45.467881
544	2	2023-12-25	4	Infrastructure	Networking	Networking expense	14844.00	CC-OPS	Pending	Credit Card	Vendor 40	2025-12-13 07:11:45.467881
545	2	2023-05-12	5	Infrastructure	Cloud Services	Cloud Services expense	2106.00	CC-MKT	Approved	Cash	Vendor 50	2025-12-13 07:11:45.467881
546	2	2024-06-16	2	Payroll	Overtime	Overtime expense	24095.00	CC-FIN	Rejected	Check	Vendor 13	2025-12-13 07:11:45.467881
547	2	2023-04-05	5	Travel	Transportation	Transportation expense	2927.00	CC-MKT	Approved	Credit Card	Vendor 8	2025-12-13 07:11:45.467881
548	2	2024-09-25	2	Operations	Maintenance	Maintenance expense	1343.00	CC-FIN	Pending	Credit Card	Vendor 45	2025-12-13 07:11:45.467881
549	2	2023-10-30	2	Marketing	Content	Content expense	4211.00	CC-FIN	Rejected	Credit Card	Vendor 48	2025-12-13 07:11:45.467881
550	2	2023-11-16	1	Payroll	Bonuses	Bonuses expense	37053.00	CC-SALES	Rejected	Credit Card	Vendor 39	2025-12-13 07:11:45.467881
551	2	2023-06-08	2	Travel	Meals	Meals expense	4837.00	CC-FIN	Approved	Credit Card	Vendor 10	2025-12-13 07:11:45.467881
552	2	2023-10-29	5	Infrastructure	Software Licenses	Software Licenses expense	3094.00	CC-MKT	Rejected	Bank Transfer	Vendor 34	2025-12-13 07:11:45.467881
553	2	2024-01-25	2	Travel	Transportation	Transportation expense	2909.00	CC-FIN	Rejected	Credit Card	Vendor 17	2025-12-13 07:11:45.467881
554	2	2023-04-16	2	Infrastructure	Networking	Networking expense	13748.00	CC-FIN	Pending	Credit Card	Vendor 11	2025-12-13 07:11:45.467881
555	2	2023-10-06	1	Travel	Hotels	Hotels expense	2961.00	CC-SALES	Pending	Cash	Vendor 10	2025-12-13 07:11:45.467881
556	2	2024-11-19	2	Payroll	Bonuses	Bonuses expense	46990.00	CC-FIN	Rejected	Check	Vendor 41	2025-12-13 07:11:45.467881
557	2	2024-12-12	5	Infrastructure	Servers	Servers expense	6593.00	CC-MKT	Approved	Bank Transfer	Vendor 18	2025-12-13 07:11:45.467881
558	2	2023-02-27	4	Infrastructure	Servers	Servers expense	3385.00	CC-OPS	Pending	Cash	Vendor 43	2025-12-13 07:11:45.467881
559	2	2024-10-30	2	Payroll	Overtime	Overtime expense	48067.00	CC-FIN	Approved	Cash	Vendor 17	2025-12-13 07:11:45.467881
560	2	2024-10-10	4	Infrastructure	Networking	Networking expense	8566.00	CC-OPS	Rejected	Credit Card	Vendor 41	2025-12-13 07:11:45.467881
561	2	2023-12-11	1	Travel	Flights	Flights expense	2828.00	CC-SALES	Approved	Cash	Vendor 26	2025-12-13 07:11:45.467881
562	2	2023-09-17	4	Operations	Office Supplies	Office Supplies expense	2709.00	CC-OPS	Approved	Cash	Vendor 25	2025-12-13 07:11:45.467881
563	2	2024-05-23	2	Travel	Hotels	Hotels expense	4746.00	CC-FIN	Approved	Credit Card	Vendor 4	2025-12-13 07:11:45.467881
564	2	2023-01-11	2	Operations	Equipment	Equipment expense	4421.00	CC-FIN	Approved	Cash	Vendor 41	2025-12-13 07:11:45.467881
565	2	2024-05-16	1	Operations	Office Supplies	Office Supplies expense	4974.00	CC-SALES	Approved	Bank Transfer	Vendor 22	2025-12-13 07:11:45.467881
566	2	2023-01-19	5	Infrastructure	Cloud Services	Cloud Services expense	4796.00	CC-MKT	Approved	Credit Card	Vendor 43	2025-12-13 07:11:45.467881
567	2	2023-06-20	4	Infrastructure	Software Licenses	Software Licenses expense	3128.00	CC-OPS	Approved	Credit Card	Vendor 49	2025-12-13 07:11:45.467881
568	2	2024-02-12	1	Payroll	Bonuses	Bonuses expense	23268.00	CC-SALES	Approved	Bank Transfer	Vendor 11	2025-12-13 07:11:45.467881
569	2	2023-02-26	2	Travel	Transportation	Transportation expense	4950.00	CC-FIN	Pending	Check	Vendor 7	2025-12-13 07:11:45.467881
570	2	2023-09-20	5	Travel	Flights	Flights expense	2007.00	CC-MKT	Approved	Check	Vendor 38	2025-12-13 07:11:45.467881
571	2	2023-05-22	5	Payroll	Bonuses	Bonuses expense	9157.00	CC-MKT	Rejected	Cash	Vendor 46	2025-12-13 07:11:45.467881
572	2	2023-01-09	4	Operations	Office Supplies	Office Supplies expense	4459.00	CC-OPS	Rejected	Bank Transfer	Vendor 30	2025-12-13 07:11:45.467881
573	2	2023-08-28	2	Operations	Maintenance	Maintenance expense	884.00	CC-FIN	Rejected	Check	Vendor 22	2025-12-13 07:11:45.467881
574	2	2023-02-09	3	Payroll	Benefits	Benefits expense	8420.00	CC-HR	Pending	Credit Card	Vendor 21	2025-12-13 07:11:45.467881
575	2	2023-06-07	3	Infrastructure	Cloud Services	Cloud Services expense	7760.00	CC-HR	Rejected	Check	Vendor 12	2025-12-13 07:11:45.467881
576	2	2024-10-12	5	Marketing	Events	Events expense	2543.00	CC-MKT	Pending	Cash	Vendor 46	2025-12-13 07:11:45.467881
577	2	2024-04-15	4	Payroll	Bonuses	Bonuses expense	13663.00	CC-OPS	Rejected	Check	Vendor 2	2025-12-13 07:11:45.467881
578	2	2023-11-10	3	Operations	Utilities	Utilities expense	1992.00	CC-HR	Approved	Bank Transfer	Vendor 13	2025-12-13 07:11:45.467881
579	2	2023-10-09	5	Infrastructure	Networking	Networking expense	11019.00	CC-MKT	Approved	Check	Vendor 15	2025-12-13 07:11:45.467881
580	2	2023-11-12	2	Marketing	Events	Events expense	1511.00	CC-FIN	Approved	Cash	Vendor 44	2025-12-13 07:11:45.467881
581	2	2023-01-22	5	Operations	Utilities	Utilities expense	2506.00	CC-MKT	Approved	Bank Transfer	Vendor 41	2025-12-13 07:11:45.467881
582	2	2023-11-18	1	Marketing	Content	Content expense	1005.00	CC-SALES	Rejected	Check	Vendor 2	2025-12-13 07:11:45.467881
583	2	2024-09-05	2	Travel	Hotels	Hotels expense	3485.00	CC-FIN	Approved	Cash	Vendor 4	2025-12-13 07:11:45.467881
584	2	2024-05-30	2	Marketing	Advertising	Advertising expense	922.00	CC-FIN	Approved	Credit Card	Vendor 4	2025-12-13 07:11:45.467881
585	2	2024-06-22	3	Operations	Utilities	Utilities expense	1264.00	CC-HR	Approved	Bank Transfer	Vendor 36	2025-12-13 07:11:45.467881
586	2	2024-11-04	2	Marketing	Events	Events expense	4491.00	CC-FIN	Approved	Check	Vendor 5	2025-12-13 07:11:45.467881
587	2	2024-04-28	1	Travel	Meals	Meals expense	2313.00	CC-SALES	Pending	Check	Vendor 2	2025-12-13 07:11:45.467881
588	2	2023-09-15	1	Marketing	Content	Content expense	3299.00	CC-SALES	Approved	Credit Card	Vendor 23	2025-12-13 07:11:45.467881
589	2	2024-06-09	2	Marketing	Content	Content expense	3946.00	CC-FIN	Approved	Bank Transfer	Vendor 29	2025-12-13 07:11:45.467881
590	2	2024-07-13	1	Operations	Maintenance	Maintenance expense	2068.00	CC-SALES	Pending	Credit Card	Vendor 42	2025-12-13 07:11:45.467881
591	2	2024-10-28	4	Marketing	Content	Content expense	1208.00	CC-OPS	Rejected	Cash	Vendor 47	2025-12-13 07:11:45.467881
592	2	2023-02-07	4	Operations	Equipment	Equipment expense	3907.00	CC-OPS	Approved	Bank Transfer	Vendor 40	2025-12-13 07:11:45.467881
593	2	2024-04-12	2	Operations	Equipment	Equipment expense	333.00	CC-FIN	Approved	Check	Vendor 4	2025-12-13 07:11:45.467881
594	2	2023-11-06	2	Operations	Equipment	Equipment expense	4185.00	CC-FIN	Pending	Bank Transfer	Vendor 5	2025-12-13 07:11:45.467881
595	2	2023-06-15	1	Infrastructure	Networking	Networking expense	15000.00	CC-SALES	Pending	Cash	Vendor 11	2025-12-13 07:11:45.467881
596	2	2023-01-28	2	Infrastructure	Software Licenses	Software Licenses expense	12129.00	CC-FIN	Approved	Cash	Vendor 40	2025-12-13 07:11:45.467881
597	2	2023-02-18	1	Infrastructure	Cloud Services	Cloud Services expense	3828.00	CC-SALES	Rejected	Check	Vendor 33	2025-12-13 07:11:45.467881
598	2	2024-12-12	3	Travel	Flights	Flights expense	1332.00	CC-HR	Approved	Check	Vendor 22	2025-12-13 07:11:45.467881
599	2	2023-03-20	1	Operations	Equipment	Equipment expense	1067.00	CC-SALES	Approved	Bank Transfer	Vendor 3	2025-12-13 07:11:45.467881
600	2	2023-05-07	1	Travel	Transportation	Transportation expense	2676.00	CC-SALES	Rejected	Bank Transfer	Vendor 38	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_financial_summaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_financial_summaries (id, tenant_id, period_year, period_month, period_quarter, total_revenue, total_cogs, gross_profit, operating_expenses, operating_income, tax_expense, net_income, ebitda, created_at) FROM stdin;
1	1	2023	1	1	775028.00	264188.00	510840.00	205029.00	305811.00	76452.00	229359.00	326313.00	2025-12-13 07:11:45.467881
2	1	2023	2	1	1875079.00	623336.00	1251743.00	381415.00	870328.00	217582.00	652746.00	908469.00	2025-12-13 07:11:45.467881
3	1	2023	3	1	1223795.00	445146.00	778649.00	400231.00	378418.00	94604.00	283814.00	418441.00	2025-12-13 07:11:45.467881
4	1	2023	4	2	1325316.00	452562.00	872754.00	423599.00	449155.00	112288.00	336867.00	491514.00	2025-12-13 07:11:45.467881
5	1	2023	5	2	749577.00	360813.00	388764.00	188909.00	199855.00	49963.00	149892.00	218745.00	2025-12-13 07:11:45.467881
6	1	2023	6	2	853846.00	345742.00	508104.00	204819.00	303285.00	75821.00	227464.00	323766.00	2025-12-13 07:11:45.467881
7	1	2023	7	3	820707.00	249976.00	570731.00	252158.00	318573.00	79643.00	238930.00	343788.00	2025-12-13 07:11:45.467881
8	1	2023	8	3	1665631.00	529746.00	1135885.00	426135.00	709750.00	177437.00	532313.00	752363.00	2025-12-13 07:11:45.467881
9	1	2023	9	3	1242934.00	620309.00	622625.00	307155.00	315470.00	78867.00	236603.00	346185.00	2025-12-13 07:11:45.467881
10	1	2023	10	4	1956629.00	642610.00	1314019.00	638963.00	675056.00	168764.00	506292.00	738952.00	2025-12-13 07:11:45.467881
11	1	2023	11	4	677725.00	336942.00	340783.00	216346.00	124437.00	31109.00	93328.00	146071.00	2025-12-13 07:11:45.467881
12	1	2023	12	4	1262986.00	494851.00	768135.00	415497.00	352638.00	88159.00	264479.00	394187.00	2025-12-13 07:11:45.467881
13	1	2024	1	1	1366969.00	481177.00	885792.00	333121.00	552671.00	138167.00	414504.00	585983.00	2025-12-13 07:11:45.467881
14	1	2024	2	1	1850674.00	842176.00	1008498.00	544223.00	464275.00	116068.00	348207.00	518697.00	2025-12-13 07:11:45.467881
15	1	2024	3	1	1324771.00	556639.00	768132.00	333408.00	434724.00	108681.00	326043.00	468064.00	2025-12-13 07:11:45.467881
16	1	2024	4	2	1790069.00	657389.00	1132680.00	414126.00	718554.00	179638.00	538916.00	759966.00	2025-12-13 07:11:45.467881
17	1	2024	5	2	553094.00	249122.00	303972.00	177178.00	126794.00	31698.00	95096.00	144511.00	2025-12-13 07:11:45.467881
18	1	2024	6	2	1641494.00	735856.00	905638.00	461172.00	444466.00	111116.00	333350.00	490583.00	2025-12-13 07:11:45.467881
19	1	2024	7	3	1864414.00	852683.00	1011731.00	646226.00	365505.00	91376.00	274129.00	430127.00	2025-12-13 07:11:45.467881
20	1	2024	8	3	1619583.00	748314.00	871269.00	424035.00	447234.00	111808.00	335426.00	489637.00	2025-12-13 07:11:45.467881
21	1	2024	9	3	1799418.00	720220.00	1079198.00	491312.00	587886.00	146971.00	440915.00	637017.00	2025-12-13 07:11:45.467881
22	1	2024	10	4	1529378.00	738219.00	791159.00	499897.00	291262.00	72815.00	218447.00	341251.00	2025-12-13 07:11:45.467881
23	1	2024	11	4	1659649.00	591500.00	1068149.00	533214.00	534935.00	133733.00	401202.00	588256.00	2025-12-13 07:11:45.467881
24	1	2024	12	4	773226.00	277129.00	496097.00	181611.00	314486.00	78621.00	235865.00	332647.00	2025-12-13 07:11:45.467881
25	2	2023	1	1	1390630.00	578838.00	811792.00	402380.00	409412.00	102353.00	307059.00	449650.00	2025-12-13 07:11:45.467881
26	2	2023	2	1	1826834.00	798388.00	1028446.00	597100.00	431346.00	107836.00	323510.00	491056.00	2025-12-13 07:11:45.467881
27	2	2023	3	1	1700495.00	519545.00	1180950.00	430425.00	750525.00	187631.00	562894.00	793567.00	2025-12-13 07:11:45.467881
28	2	2023	4	2	1947556.00	948706.00	998850.00	616274.00	382576.00	95644.00	286932.00	444203.00	2025-12-13 07:11:45.467881
29	2	2023	5	2	1943843.00	868624.00	1075219.00	487321.00	587898.00	146974.00	440924.00	636630.00	2025-12-13 07:11:45.467881
30	2	2023	6	2	726504.00	339191.00	387313.00	253439.00	133874.00	33468.00	100406.00	159217.00	2025-12-13 07:11:45.467881
31	2	2023	7	3	1760463.00	868102.00	892361.00	615772.00	276589.00	69147.00	207442.00	338166.00	2025-12-13 07:11:45.467881
32	2	2023	8	3	729085.00	298958.00	430127.00	207170.00	222957.00	55739.00	167218.00	243674.00	2025-12-13 07:11:45.467881
33	2	2023	9	3	1647002.00	582577.00	1064425.00	543760.00	520665.00	130166.00	390499.00	575041.00	2025-12-13 07:11:45.467881
34	2	2023	10	4	1076453.00	480107.00	596346.00	333591.00	262755.00	65688.00	197067.00	296114.00	2025-12-13 07:11:45.467881
35	2	2023	11	4	1855220.00	850391.00	1004829.00	600391.00	404438.00	101109.00	303329.00	464477.00	2025-12-13 07:11:45.467881
36	2	2023	12	4	615185.00	239809.00	375376.00	164512.00	210864.00	52716.00	158148.00	227315.00	2025-12-13 07:11:45.467881
37	2	2024	1	1	1246097.00	445433.00	800664.00	319392.00	481272.00	120318.00	360954.00	513211.00	2025-12-13 07:11:45.467881
38	2	2024	2	1	740918.00	262993.00	477925.00	217265.00	260660.00	65165.00	195495.00	282386.00	2025-12-13 07:11:45.467881
39	2	2024	3	1	850000.00	340576.00	509424.00	239918.00	269506.00	67376.00	202130.00	293497.00	2025-12-13 07:11:45.467881
40	2	2024	4	2	1240942.00	401245.00	839697.00	426177.00	413520.00	103380.00	310140.00	456137.00	2025-12-13 07:11:45.467881
41	2	2024	5	2	1009235.00	391264.00	617971.00	301732.00	316239.00	79059.00	237180.00	346412.00	2025-12-13 07:11:45.467881
42	2	2024	6	2	1517170.00	576603.00	940567.00	526653.00	413914.00	103478.00	310436.00	466579.00	2025-12-13 07:11:45.467881
43	2	2024	7	3	1570737.00	661875.00	908862.00	494195.00	414667.00	103666.00	311001.00	464086.00	2025-12-13 07:11:45.467881
44	2	2024	8	3	713294.00	353811.00	359483.00	153434.00	206049.00	51512.00	154537.00	221392.00	2025-12-13 07:11:45.467881
45	2	2024	9	3	529264.00	202938.00	326326.00	176622.00	149704.00	37426.00	112278.00	167366.00	2025-12-13 07:11:45.467881
46	2	2024	10	4	1741354.00	705484.00	1035870.00	351311.00	684559.00	171139.00	513420.00	719690.00	2025-12-13 07:11:45.467881
47	2	2024	11	4	758827.00	333918.00	424909.00	254128.00	170781.00	42695.00	128086.00	196193.00	2025-12-13 07:11:45.467881
48	2	2024	12	4	1217664.00	512337.00	705327.00	406910.00	298417.00	74604.00	223813.00	339108.00	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_products (id, tenant_id, sku, name, category, subcategory, unit_price, cost_price, is_active, created_at) FROM stdin;
1	1	PRD-001	Enterprise Software License	Software	Enterprise	5000.00	1500.00	t	2025-12-13 07:11:45.467881
2	1	PRD-002	Cloud Storage Plan	Services	Cloud	199.00	50.00	t	2025-12-13 07:11:45.467881
3	1	PRD-003	Analytics Dashboard Pro	Software	Analytics	2500.00	800.00	t	2025-12-13 07:11:45.467881
4	1	PRD-004	Data Integration Suite	Software	Integration	3500.00	1200.00	t	2025-12-13 07:11:45.467881
5	1	PRD-005	Mobile App Development Kit	Software	Mobile	1500.00	400.00	t	2025-12-13 07:11:45.467881
6	1	PRD-006	API Gateway License	Software	Infrastructure	2000.00	600.00	t	2025-12-13 07:11:45.467881
7	1	PRD-007	Security Compliance Package	Services	Security	4500.00	1500.00	t	2025-12-13 07:11:45.467881
8	1	PRD-008	Support Premium Plan	Services	Support	500.00	150.00	t	2025-12-13 07:11:45.467881
9	1	PRD-009	Training Workshop Bundle	Services	Training	800.00	200.00	t	2025-12-13 07:11:45.467881
10	1	PRD-010	Hardware Sensor Kit	Hardware	IoT	350.00	120.00	t	2025-12-13 07:11:45.467881
11	2	PRD-001	Enterprise Software License	Software	Enterprise	5000.00	1500.00	t	2025-12-13 07:11:45.467881
12	2	PRD-002	Cloud Storage Plan	Services	Cloud	199.00	50.00	t	2025-12-13 07:11:45.467881
13	2	PRD-003	Analytics Dashboard Pro	Software	Analytics	2500.00	800.00	t	2025-12-13 07:11:45.467881
14	2	PRD-004	Data Integration Suite	Software	Integration	3500.00	1200.00	t	2025-12-13 07:11:45.467881
15	2	PRD-005	Mobile App Development Kit	Software	Mobile	1500.00	400.00	t	2025-12-13 07:11:45.467881
16	2	PRD-006	API Gateway License	Software	Infrastructure	2000.00	600.00	t	2025-12-13 07:11:45.467881
17	2	PRD-007	Security Compliance Package	Services	Security	4500.00	1500.00	t	2025-12-13 07:11:45.467881
18	2	PRD-008	Support Premium Plan	Services	Support	500.00	150.00	t	2025-12-13 07:11:45.467881
19	2	PRD-009	Training Workshop Bundle	Services	Training	800.00	200.00	t	2025-12-13 07:11:45.467881
20	2	PRD-010	Hardware Sensor Kit	Hardware	IoT	350.00	120.00	t	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_regions (id, tenant_id, code, name, country, timezone, created_at) FROM stdin;
1	1	NORTH	North Region	USA	America/New_York	2025-12-13 07:11:45.467881
2	1	SOUTH	South Region	USA	America/Chicago	2025-12-13 07:11:45.467881
3	1	EAST	East Region	USA	America/New_York	2025-12-13 07:11:45.467881
4	1	WEST	West Region	USA	America/Los_Angeles	2025-12-13 07:11:45.467881
5	1	INTL	International	Global	UTC	2025-12-13 07:11:45.467881
6	2	NORTH	North Region	USA	America/New_York	2025-12-13 07:11:45.467881
7	2	SOUTH	South Region	USA	America/Chicago	2025-12-13 07:11:45.467881
8	2	EAST	East Region	USA	America/New_York	2025-12-13 07:11:45.467881
9	2	WEST	West Region	USA	America/Los_Angeles	2025-12-13 07:11:45.467881
10	2	INTL	International	Global	UTC	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: analytics_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_sales (id, tenant_id, order_number, order_date, customer_id, product_id, region_id, department_id, sales_channel, quantity, unit_price, discount_percent, total_amount, cost_amount, profit_amount, sales_rep, invoice_number, payment_status, created_at) FROM stdin;
1	1	ORD-1-00001	2023-09-19	5	4	3	1	Partner	18	3500.00	5.00	59850.00	21600.00	38250.00	David Brown	INV-1-00001	Overdue	2025-12-13 07:11:45.467881
2	1	ORD-1-00002	2023-08-17	4	3	5	1	Direct Sales	11	2500.00	10.00	24750.00	8800.00	15950.00	Mike Johnson	INV-1-00002	Overdue	2025-12-13 07:11:45.467881
3	1	ORD-1-00003	2024-04-24	4	3	2	1	Partner	7	2500.00	10.00	15750.00	5600.00	10150.00	Robert Taylor	INV-1-00003	Overdue	2025-12-13 07:11:45.467881
4	1	ORD-1-00004	2023-05-31	14	7	2	1	Partner	4	4500.00	20.00	14400.00	6000.00	8400.00	Mike Johnson	INV-1-00004	Paid	2025-12-13 07:11:45.467881
5	1	ORD-1-00005	2024-12-24	3	9	2	1	Direct Sales	16	800.00	15.00	10880.00	3200.00	7680.00	David Brown	INV-1-00005	Pending	2025-12-13 07:11:45.467881
6	1	ORD-1-00006	2023-07-23	14	7	1	1	Direct Sales	17	4500.00	20.00	61200.00	25500.00	35700.00	Mike Johnson	INV-1-00006	Paid	2025-12-13 07:11:45.467881
7	1	ORD-1-00007	2023-03-28	8	5	2	1	Online	12	1500.00	0.00	18000.00	4800.00	13200.00	Mike Johnson	INV-1-00007	Overdue	2025-12-13 07:11:45.467881
8	1	ORD-1-00008	2023-02-17	2	9	5	1	Partner	16	800.00	15.00	10880.00	3200.00	7680.00	Mike Johnson	INV-1-00008	Paid	2025-12-13 07:11:45.467881
9	1	ORD-1-00009	2023-07-14	7	7	2	1	Retail	12	4500.00	5.00	51300.00	18000.00	33300.00	Emily Davis	INV-1-00009	Overdue	2025-12-13 07:11:45.467881
10	1	ORD-1-00010	2023-05-28	4	3	4	1	Online	8	2500.00	5.00	19000.00	6400.00	12600.00	John Smith	INV-1-00010	Pending	2025-12-13 07:11:45.467881
11	1	ORD-1-00011	2023-06-26	7	7	1	1	Reseller	9	4500.00	15.00	34425.00	13500.00	20925.00	Chris Lee	INV-1-00011	Pending	2025-12-13 07:11:45.467881
12	1	ORD-1-00012	2023-12-19	3	1	2	1	Direct Sales	14	5000.00	20.00	56000.00	21000.00	35000.00	Sarah Wilson	INV-1-00012	Paid	2025-12-13 07:11:45.467881
13	1	ORD-1-00013	2023-04-08	12	9	4	1	Reseller	5	800.00	10.00	3600.00	1000.00	2600.00	Robert Taylor	INV-1-00013	Paid	2025-12-13 07:11:45.467881
14	1	ORD-1-00014	2024-10-25	14	5	5	1	Reseller	17	1500.00	0.00	25500.00	6800.00	18700.00	Lisa Anderson	INV-1-00014	Overdue	2025-12-13 07:11:45.467881
15	1	ORD-1-00015	2023-05-07	5	5	1	1	Retail	7	1500.00	5.00	9975.00	2800.00	7175.00	Sarah Wilson	INV-1-00015	Paid	2025-12-13 07:11:45.467881
16	1	ORD-1-00016	2024-12-13	8	6	4	1	Online	14	2000.00	20.00	22400.00	8400.00	14000.00	Emily Davis	INV-1-00016	Pending	2025-12-13 07:11:45.467881
17	1	ORD-1-00017	2024-08-19	2	10	3	1	Online	4	350.00	15.00	1190.00	480.00	710.00	Emily Davis	INV-1-00017	Paid	2025-12-13 07:11:45.467881
18	1	ORD-1-00018	2023-12-13	1	5	4	1	Partner	13	1500.00	0.00	19500.00	5200.00	14300.00	John Smith	INV-1-00018	Overdue	2025-12-13 07:11:45.467881
19	1	ORD-1-00019	2023-02-13	12	2	5	1	Partner	19	199.00	20.00	3024.80	950.00	2074.80	Sarah Wilson	INV-1-00019	Paid	2025-12-13 07:11:45.467881
20	1	ORD-1-00020	2024-02-04	11	9	1	1	Retail	2	800.00	20.00	1280.00	400.00	880.00	Amanda White	INV-1-00020	Paid	2025-12-13 07:11:45.467881
21	1	ORD-1-00021	2023-10-28	12	9	5	1	Partner	9	800.00	15.00	6120.00	1800.00	4320.00	Jane Doe	INV-1-00021	Paid	2025-12-13 07:11:45.467881
22	1	ORD-1-00022	2023-02-28	10	9	1	1	Reseller	17	800.00	20.00	10880.00	3400.00	7480.00	David Brown	INV-1-00022	Paid	2025-12-13 07:11:45.467881
23	1	ORD-1-00023	2023-04-29	6	9	4	1	Partner	9	800.00	10.00	6480.00	1800.00	4680.00	Robert Taylor	INV-1-00023	Paid	2025-12-13 07:11:45.467881
24	1	ORD-1-00024	2023-04-25	2	4	4	1	Reseller	20	3500.00	10.00	63000.00	24000.00	39000.00	David Brown	INV-1-00024	Paid	2025-12-13 07:11:45.467881
25	1	ORD-1-00025	2024-01-03	1	2	4	1	Retail	1	199.00	0.00	199.00	50.00	149.00	Emily Davis	INV-1-00025	Paid	2025-12-13 07:11:45.467881
26	1	ORD-1-00026	2024-03-19	5	1	3	1	Retail	7	5000.00	5.00	33250.00	10500.00	22750.00	Sarah Wilson	INV-1-00026	Paid	2025-12-13 07:11:45.467881
27	1	ORD-1-00027	2024-07-13	5	5	2	1	Direct Sales	17	1500.00	15.00	21675.00	6800.00	14875.00	John Smith	INV-1-00027	Overdue	2025-12-13 07:11:45.467881
28	1	ORD-1-00028	2023-07-12	9	10	1	1	Partner	8	350.00	0.00	2800.00	960.00	1840.00	Chris Lee	INV-1-00028	Paid	2025-12-13 07:11:45.467881
29	1	ORD-1-00029	2024-03-08	7	10	4	1	Online	9	350.00	20.00	2520.00	1080.00	1440.00	Sarah Wilson	INV-1-00029	Paid	2025-12-13 07:11:45.467881
30	1	ORD-1-00030	2024-06-29	4	9	1	1	Retail	2	800.00	20.00	1280.00	400.00	880.00	Mike Johnson	INV-1-00030	Paid	2025-12-13 07:11:45.467881
31	1	ORD-1-00031	2023-10-03	9	1	2	1	Direct Sales	2	5000.00	10.00	9000.00	3000.00	6000.00	Amanda White	INV-1-00031	Paid	2025-12-13 07:11:45.467881
32	1	ORD-1-00032	2024-03-25	3	3	5	1	Online	3	2500.00	5.00	7125.00	2400.00	4725.00	Amanda White	INV-1-00032	Paid	2025-12-13 07:11:45.467881
33	1	ORD-1-00033	2023-02-01	3	3	4	1	Reseller	7	2500.00	5.00	16625.00	5600.00	11025.00	Mike Johnson	INV-1-00033	Pending	2025-12-13 07:11:45.467881
34	1	ORD-1-00034	2024-04-15	3	8	3	1	Retail	7	500.00	10.00	3150.00	1050.00	2100.00	John Smith	INV-1-00034	Overdue	2025-12-13 07:11:45.467881
35	1	ORD-1-00035	2024-09-18	12	3	3	1	Reseller	12	2500.00	15.00	25500.00	9600.00	15900.00	Sarah Wilson	INV-1-00035	Paid	2025-12-13 07:11:45.467881
36	1	ORD-1-00036	2023-05-27	1	2	1	1	Online	19	199.00	0.00	3781.00	950.00	2831.00	David Brown	INV-1-00036	Paid	2025-12-13 07:11:45.467881
37	1	ORD-1-00037	2023-03-15	13	9	2	1	Online	11	800.00	20.00	7040.00	2200.00	4840.00	Robert Taylor	INV-1-00037	Paid	2025-12-13 07:11:45.467881
38	1	ORD-1-00038	2023-04-02	1	10	2	1	Reseller	6	350.00	10.00	1890.00	720.00	1170.00	Robert Taylor	INV-1-00038	Paid	2025-12-13 07:11:45.467881
39	1	ORD-1-00039	2023-01-19	14	10	4	1	Reseller	5	350.00	0.00	1750.00	600.00	1150.00	Sarah Wilson	INV-1-00039	Pending	2025-12-13 07:11:45.467881
40	1	ORD-1-00040	2024-09-22	1	3	3	1	Retail	14	2500.00	15.00	29750.00	11200.00	18550.00	Robert Taylor	INV-1-00040	Pending	2025-12-13 07:11:45.467881
41	1	ORD-1-00041	2023-07-16	1	1	5	1	Direct Sales	3	5000.00	5.00	14250.00	4500.00	9750.00	John Smith	INV-1-00041	Paid	2025-12-13 07:11:45.467881
42	1	ORD-1-00042	2024-06-09	4	8	5	1	Partner	16	500.00	20.00	6400.00	2400.00	4000.00	Jane Doe	INV-1-00042	Paid	2025-12-13 07:11:45.467881
43	1	ORD-1-00043	2024-09-15	1	4	5	1	Retail	6	3500.00	10.00	18900.00	7200.00	11700.00	Jane Doe	INV-1-00043	Paid	2025-12-13 07:11:45.467881
44	1	ORD-1-00044	2024-07-05	8	6	1	1	Retail	11	2000.00	0.00	22000.00	6600.00	15400.00	Sarah Wilson	INV-1-00044	Pending	2025-12-13 07:11:45.467881
45	1	ORD-1-00045	2024-11-23	13	6	3	1	Partner	13	2000.00	15.00	22100.00	7800.00	14300.00	David Brown	INV-1-00045	Pending	2025-12-13 07:11:45.467881
46	1	ORD-1-00046	2023-07-25	6	8	4	1	Reseller	17	500.00	0.00	8500.00	2550.00	5950.00	Jane Doe	INV-1-00046	Pending	2025-12-13 07:11:45.467881
47	1	ORD-1-00047	2023-02-19	2	7	3	1	Online	9	4500.00	5.00	38475.00	13500.00	24975.00	Chris Lee	INV-1-00047	Paid	2025-12-13 07:11:45.467881
48	1	ORD-1-00048	2023-06-06	2	2	3	1	Reseller	2	199.00	0.00	398.00	100.00	298.00	Jane Doe	INV-1-00048	Pending	2025-12-13 07:11:45.467881
49	1	ORD-1-00049	2023-09-11	3	10	4	1	Direct Sales	18	350.00	20.00	5040.00	2160.00	2880.00	Chris Lee	INV-1-00049	Paid	2025-12-13 07:11:45.467881
50	1	ORD-1-00050	2024-12-04	4	6	2	1	Reseller	20	2000.00	15.00	34000.00	12000.00	22000.00	Chris Lee	INV-1-00050	Paid	2025-12-13 07:11:45.467881
51	1	ORD-1-00051	2023-07-04	15	3	1	1	Direct Sales	5	2500.00	10.00	11250.00	4000.00	7250.00	Emily Davis	INV-1-00051	Paid	2025-12-13 07:11:45.467881
52	1	ORD-1-00052	2024-11-25	11	8	1	1	Online	2	500.00	20.00	800.00	300.00	500.00	Amanda White	INV-1-00052	Paid	2025-12-13 07:11:45.467881
53	1	ORD-1-00053	2024-04-01	3	2	3	1	Online	4	199.00	5.00	756.20	200.00	556.20	Emily Davis	INV-1-00053	Paid	2025-12-13 07:11:45.467881
54	1	ORD-1-00054	2024-08-15	14	9	1	1	Online	6	800.00	10.00	4320.00	1200.00	3120.00	Robert Taylor	INV-1-00054	Paid	2025-12-13 07:11:45.467881
55	1	ORD-1-00055	2023-06-27	3	4	2	1	Retail	16	3500.00	0.00	56000.00	19200.00	36800.00	Chris Lee	INV-1-00055	Overdue	2025-12-13 07:11:45.467881
56	1	ORD-1-00056	2024-03-13	15	8	2	1	Reseller	6	500.00	10.00	2700.00	900.00	1800.00	Sarah Wilson	INV-1-00056	Paid	2025-12-13 07:11:45.467881
57	1	ORD-1-00057	2023-03-23	6	10	3	1	Online	9	350.00	0.00	3150.00	1080.00	2070.00	Jane Doe	INV-1-00057	Paid	2025-12-13 07:11:45.467881
58	1	ORD-1-00058	2024-04-03	13	3	4	1	Direct Sales	8	2500.00	10.00	18000.00	6400.00	11600.00	Robert Taylor	INV-1-00058	Paid	2025-12-13 07:11:45.467881
59	1	ORD-1-00059	2024-10-19	9	4	4	1	Partner	18	3500.00	5.00	59850.00	21600.00	38250.00	David Brown	INV-1-00059	Paid	2025-12-13 07:11:45.467881
60	1	ORD-1-00060	2023-03-26	1	5	2	1	Direct Sales	1	1500.00	5.00	1425.00	400.00	1025.00	Amanda White	INV-1-00060	Paid	2025-12-13 07:11:45.467881
61	1	ORD-1-00061	2023-05-22	7	4	3	1	Online	9	3500.00	20.00	25200.00	10800.00	14400.00	Lisa Anderson	INV-1-00061	Overdue	2025-12-13 07:11:45.467881
62	1	ORD-1-00062	2023-12-30	10	5	2	1	Reseller	2	1500.00	10.00	2700.00	800.00	1900.00	Amanda White	INV-1-00062	Paid	2025-12-13 07:11:45.467881
63	1	ORD-1-00063	2024-09-05	15	4	2	1	Direct Sales	9	3500.00	15.00	26775.00	10800.00	15975.00	Robert Taylor	INV-1-00063	Overdue	2025-12-13 07:11:45.467881
64	1	ORD-1-00064	2023-10-17	15	9	1	1	Retail	5	800.00	10.00	3600.00	1000.00	2600.00	Emily Davis	INV-1-00064	Paid	2025-12-13 07:11:45.467881
65	1	ORD-1-00065	2023-11-21	6	7	2	1	Partner	12	4500.00	0.00	54000.00	18000.00	36000.00	Mike Johnson	INV-1-00065	Overdue	2025-12-13 07:11:45.467881
66	1	ORD-1-00066	2023-11-30	7	5	3	1	Direct Sales	20	1500.00	5.00	28500.00	8000.00	20500.00	John Smith	INV-1-00066	Pending	2025-12-13 07:11:45.467881
67	1	ORD-1-00067	2024-06-09	14	8	4	1	Retail	13	500.00	0.00	6500.00	1950.00	4550.00	Sarah Wilson	INV-1-00067	Overdue	2025-12-13 07:11:45.467881
68	1	ORD-1-00068	2023-01-20	14	5	2	1	Direct Sales	1	1500.00	15.00	1275.00	400.00	875.00	Emily Davis	INV-1-00068	Paid	2025-12-13 07:11:45.467881
69	1	ORD-1-00069	2024-07-07	4	3	1	1	Partner	16	2500.00	20.00	32000.00	12800.00	19200.00	Chris Lee	INV-1-00069	Pending	2025-12-13 07:11:45.467881
70	1	ORD-1-00070	2024-07-04	12	10	3	1	Direct Sales	8	350.00	20.00	2240.00	960.00	1280.00	David Brown	INV-1-00070	Paid	2025-12-13 07:11:45.467881
71	1	ORD-1-00071	2024-02-16	3	2	1	1	Partner	18	199.00	10.00	3223.80	900.00	2323.80	Mike Johnson	INV-1-00071	Paid	2025-12-13 07:11:45.467881
72	1	ORD-1-00072	2024-05-16	9	1	5	1	Direct Sales	1	5000.00	20.00	4000.00	1500.00	2500.00	Lisa Anderson	INV-1-00072	Pending	2025-12-13 07:11:45.467881
73	1	ORD-1-00073	2023-08-07	2	9	5	1	Online	8	800.00	10.00	5760.00	1600.00	4160.00	Mike Johnson	INV-1-00073	Pending	2025-12-13 07:11:45.467881
74	1	ORD-1-00074	2023-11-13	11	2	4	1	Direct Sales	16	199.00	0.00	3184.00	800.00	2384.00	John Smith	INV-1-00074	Overdue	2025-12-13 07:11:45.467881
75	1	ORD-1-00075	2024-05-11	3	3	1	1	Partner	3	2500.00	5.00	7125.00	2400.00	4725.00	Lisa Anderson	INV-1-00075	Overdue	2025-12-13 07:11:45.467881
76	1	ORD-1-00076	2023-09-21	15	8	5	1	Retail	7	500.00	5.00	3325.00	1050.00	2275.00	Mike Johnson	INV-1-00076	Paid	2025-12-13 07:11:45.467881
77	1	ORD-1-00077	2023-01-10	12	3	2	1	Direct Sales	3	2500.00	10.00	6750.00	2400.00	4350.00	Amanda White	INV-1-00077	Overdue	2025-12-13 07:11:45.467881
78	1	ORD-1-00078	2024-06-16	7	8	4	1	Retail	19	500.00	15.00	8075.00	2850.00	5225.00	John Smith	INV-1-00078	Pending	2025-12-13 07:11:45.467881
79	1	ORD-1-00079	2024-02-15	15	6	1	1	Retail	13	2000.00	0.00	26000.00	7800.00	18200.00	David Brown	INV-1-00079	Overdue	2025-12-13 07:11:45.467881
80	1	ORD-1-00080	2024-09-23	12	9	1	1	Partner	15	800.00	0.00	12000.00	3000.00	9000.00	Jane Doe	INV-1-00080	Pending	2025-12-13 07:11:45.467881
81	1	ORD-1-00081	2024-08-16	3	3	4	1	Retail	5	2500.00	10.00	11250.00	4000.00	7250.00	Emily Davis	INV-1-00081	Pending	2025-12-13 07:11:45.467881
82	1	ORD-1-00082	2023-12-11	11	9	4	1	Direct Sales	17	800.00	10.00	12240.00	3400.00	8840.00	Emily Davis	INV-1-00082	Paid	2025-12-13 07:11:45.467881
83	1	ORD-1-00083	2024-11-02	1	4	4	1	Direct Sales	17	3500.00	0.00	59500.00	20400.00	39100.00	Lisa Anderson	INV-1-00083	Paid	2025-12-13 07:11:45.467881
84	1	ORD-1-00084	2023-12-20	13	6	1	1	Online	7	2000.00	10.00	12600.00	4200.00	8400.00	John Smith	INV-1-00084	Paid	2025-12-13 07:11:45.467881
85	1	ORD-1-00085	2024-04-12	7	4	2	1	Partner	17	3500.00	0.00	59500.00	20400.00	39100.00	David Brown	INV-1-00085	Overdue	2025-12-13 07:11:45.467881
86	1	ORD-1-00086	2024-02-19	13	3	5	1	Retail	1	2500.00	20.00	2000.00	800.00	1200.00	Robert Taylor	INV-1-00086	Paid	2025-12-13 07:11:45.467881
87	1	ORD-1-00087	2023-11-12	9	2	1	1	Partner	16	199.00	5.00	3024.80	800.00	2224.80	Mike Johnson	INV-1-00087	Paid	2025-12-13 07:11:45.467881
88	1	ORD-1-00088	2023-06-27	10	3	5	1	Retail	10	2500.00	5.00	23750.00	8000.00	15750.00	Sarah Wilson	INV-1-00088	Paid	2025-12-13 07:11:45.467881
89	1	ORD-1-00089	2023-01-01	8	1	4	1	Online	4	5000.00	20.00	16000.00	6000.00	10000.00	Robert Taylor	INV-1-00089	Overdue	2025-12-13 07:11:45.467881
90	1	ORD-1-00090	2024-05-24	1	2	1	1	Reseller	8	199.00	5.00	1512.40	400.00	1112.40	David Brown	INV-1-00090	Paid	2025-12-13 07:11:45.467881
91	1	ORD-1-00091	2024-05-05	12	6	2	1	Direct Sales	2	2000.00	20.00	3200.00	1200.00	2000.00	Emily Davis	INV-1-00091	Pending	2025-12-13 07:11:45.467881
92	1	ORD-1-00092	2024-01-21	12	4	1	1	Direct Sales	1	3500.00	15.00	2975.00	1200.00	1775.00	David Brown	INV-1-00092	Paid	2025-12-13 07:11:45.467881
93	1	ORD-1-00093	2024-06-05	9	4	1	1	Partner	7	3500.00	0.00	24500.00	8400.00	16100.00	John Smith	INV-1-00093	Paid	2025-12-13 07:11:45.467881
94	1	ORD-1-00094	2024-04-24	11	5	4	1	Reseller	1	1500.00	15.00	1275.00	400.00	875.00	John Smith	INV-1-00094	Paid	2025-12-13 07:11:45.467881
95	1	ORD-1-00095	2024-05-20	6	7	1	1	Direct Sales	18	4500.00	20.00	64800.00	27000.00	37800.00	Mike Johnson	INV-1-00095	Paid	2025-12-13 07:11:45.467881
96	1	ORD-1-00096	2023-04-26	8	3	5	1	Partner	10	2500.00	10.00	22500.00	8000.00	14500.00	Lisa Anderson	INV-1-00096	Overdue	2025-12-13 07:11:45.467881
97	1	ORD-1-00097	2024-04-30	10	2	1	1	Partner	6	199.00	5.00	1134.30	300.00	834.30	Amanda White	INV-1-00097	Overdue	2025-12-13 07:11:45.467881
98	1	ORD-1-00098	2024-08-08	7	10	5	1	Reseller	5	350.00	10.00	1575.00	600.00	975.00	Mike Johnson	INV-1-00098	Paid	2025-12-13 07:11:45.467881
99	1	ORD-1-00099	2023-09-22	6	9	4	1	Direct Sales	10	800.00	15.00	6800.00	2000.00	4800.00	Robert Taylor	INV-1-00099	Overdue	2025-12-13 07:11:45.467881
100	1	ORD-1-00100	2024-03-23	9	5	1	1	Online	14	1500.00	0.00	21000.00	5600.00	15400.00	John Smith	INV-1-00100	Paid	2025-12-13 07:11:45.467881
101	1	ORD-1-00101	2023-02-06	11	4	4	1	Partner	11	3500.00	15.00	32725.00	13200.00	19525.00	Amanda White	INV-1-00101	Overdue	2025-12-13 07:11:45.467881
102	1	ORD-1-00102	2024-05-16	10	7	2	1	Online	6	4500.00	20.00	21600.00	9000.00	12600.00	Chris Lee	INV-1-00102	Paid	2025-12-13 07:11:45.467881
103	1	ORD-1-00103	2024-02-03	4	5	3	1	Partner	13	1500.00	15.00	16575.00	5200.00	11375.00	David Brown	INV-1-00103	Paid	2025-12-13 07:11:45.467881
104	1	ORD-1-00104	2023-10-10	12	10	4	1	Direct Sales	1	350.00	10.00	315.00	120.00	195.00	Lisa Anderson	INV-1-00104	Paid	2025-12-13 07:11:45.467881
105	1	ORD-1-00105	2024-03-17	1	6	4	1	Reseller	10	2000.00	20.00	16000.00	6000.00	10000.00	Sarah Wilson	INV-1-00105	Paid	2025-12-13 07:11:45.467881
106	1	ORD-1-00106	2024-04-28	13	5	4	1	Partner	2	1500.00	10.00	2700.00	800.00	1900.00	Mike Johnson	INV-1-00106	Pending	2025-12-13 07:11:45.467881
107	1	ORD-1-00107	2024-03-01	8	1	2	1	Online	2	5000.00	15.00	8500.00	3000.00	5500.00	Robert Taylor	INV-1-00107	Paid	2025-12-13 07:11:45.467881
108	1	ORD-1-00108	2024-12-28	8	10	4	1	Retail	4	350.00	5.00	1330.00	480.00	850.00	Emily Davis	INV-1-00108	Paid	2025-12-13 07:11:45.467881
109	1	ORD-1-00109	2024-07-29	11	6	4	1	Reseller	5	2000.00	10.00	9000.00	3000.00	6000.00	Amanda White	INV-1-00109	Overdue	2025-12-13 07:11:45.467881
110	1	ORD-1-00110	2023-02-12	14	5	5	1	Retail	4	1500.00	0.00	6000.00	1600.00	4400.00	Jane Doe	INV-1-00110	Paid	2025-12-13 07:11:45.467881
111	1	ORD-1-00111	2024-10-31	7	7	5	1	Retail	19	4500.00	20.00	68400.00	28500.00	39900.00	Lisa Anderson	INV-1-00111	Paid	2025-12-13 07:11:45.467881
112	1	ORD-1-00112	2024-07-26	11	10	1	1	Reseller	12	350.00	15.00	3570.00	1440.00	2130.00	Robert Taylor	INV-1-00112	Paid	2025-12-13 07:11:45.467881
113	1	ORD-1-00113	2023-11-10	14	2	2	1	Direct Sales	9	199.00	20.00	1432.80	450.00	982.80	Lisa Anderson	INV-1-00113	Pending	2025-12-13 07:11:45.467881
114	1	ORD-1-00114	2024-03-04	4	9	5	1	Partner	17	800.00	15.00	11560.00	3400.00	8160.00	John Smith	INV-1-00114	Overdue	2025-12-13 07:11:45.467881
115	1	ORD-1-00115	2023-01-03	14	2	1	1	Partner	6	199.00	0.00	1194.00	300.00	894.00	Chris Lee	INV-1-00115	Pending	2025-12-13 07:11:45.467881
116	1	ORD-1-00116	2024-05-21	6	4	1	1	Direct Sales	8	3500.00	10.00	25200.00	9600.00	15600.00	Mike Johnson	INV-1-00116	Overdue	2025-12-13 07:11:45.467881
117	1	ORD-1-00117	2023-09-22	12	1	3	1	Direct Sales	1	5000.00	5.00	4750.00	1500.00	3250.00	Jane Doe	INV-1-00117	Paid	2025-12-13 07:11:45.467881
118	1	ORD-1-00118	2024-02-27	1	9	1	1	Reseller	3	800.00	20.00	1920.00	600.00	1320.00	Amanda White	INV-1-00118	Overdue	2025-12-13 07:11:45.467881
119	1	ORD-1-00119	2024-08-29	2	3	3	1	Reseller	2	2500.00	0.00	5000.00	1600.00	3400.00	David Brown	INV-1-00119	Paid	2025-12-13 07:11:45.467881
120	1	ORD-1-00120	2024-11-12	3	7	2	1	Retail	20	4500.00	0.00	90000.00	30000.00	60000.00	Amanda White	INV-1-00120	Paid	2025-12-13 07:11:45.467881
121	1	ORD-1-00121	2023-11-12	9	9	2	1	Partner	20	800.00	0.00	16000.00	4000.00	12000.00	John Smith	INV-1-00121	Paid	2025-12-13 07:11:45.467881
122	1	ORD-1-00122	2024-03-11	3	5	3	1	Online	5	1500.00	0.00	7500.00	2000.00	5500.00	Amanda White	INV-1-00122	Pending	2025-12-13 07:11:45.467881
123	1	ORD-1-00123	2024-05-19	1	10	3	1	Reseller	19	350.00	0.00	6650.00	2280.00	4370.00	Robert Taylor	INV-1-00123	Paid	2025-12-13 07:11:45.467881
124	1	ORD-1-00124	2024-12-03	10	2	2	1	Direct Sales	8	199.00	0.00	1592.00	400.00	1192.00	Lisa Anderson	INV-1-00124	Pending	2025-12-13 07:11:45.467881
125	1	ORD-1-00125	2024-12-12	8	4	3	1	Partner	5	3500.00	10.00	15750.00	6000.00	9750.00	John Smith	INV-1-00125	Paid	2025-12-13 07:11:45.467881
126	1	ORD-1-00126	2024-10-06	5	9	4	1	Direct Sales	19	800.00	20.00	12160.00	3800.00	8360.00	Robert Taylor	INV-1-00126	Overdue	2025-12-13 07:11:45.467881
127	1	ORD-1-00127	2023-03-08	4	10	3	1	Partner	9	350.00	10.00	2835.00	1080.00	1755.00	Mike Johnson	INV-1-00127	Pending	2025-12-13 07:11:45.467881
128	1	ORD-1-00128	2024-07-06	14	3	1	1	Reseller	6	2500.00	5.00	14250.00	4800.00	9450.00	Lisa Anderson	INV-1-00128	Paid	2025-12-13 07:11:45.467881
129	1	ORD-1-00129	2023-12-30	15	7	1	1	Online	10	4500.00	20.00	36000.00	15000.00	21000.00	Amanda White	INV-1-00129	Paid	2025-12-13 07:11:45.467881
130	1	ORD-1-00130	2024-09-02	6	2	2	1	Partner	11	199.00	20.00	1751.20	550.00	1201.20	Jane Doe	INV-1-00130	Paid	2025-12-13 07:11:45.467881
131	1	ORD-1-00131	2023-04-05	9	1	1	1	Partner	1	5000.00	15.00	4250.00	1500.00	2750.00	John Smith	INV-1-00131	Paid	2025-12-13 07:11:45.467881
132	1	ORD-1-00132	2024-04-02	11	2	2	1	Partner	17	199.00	10.00	3044.70	850.00	2194.70	Robert Taylor	INV-1-00132	Paid	2025-12-13 07:11:45.467881
133	1	ORD-1-00133	2023-05-12	13	9	1	1	Online	7	800.00	10.00	5040.00	1400.00	3640.00	Jane Doe	INV-1-00133	Paid	2025-12-13 07:11:45.467881
134	1	ORD-1-00134	2023-02-22	13	8	1	1	Direct Sales	9	500.00	20.00	3600.00	1350.00	2250.00	Chris Lee	INV-1-00134	Paid	2025-12-13 07:11:45.467881
135	1	ORD-1-00135	2024-01-01	15	1	1	1	Partner	2	5000.00	0.00	10000.00	3000.00	7000.00	Amanda White	INV-1-00135	Paid	2025-12-13 07:11:45.467881
136	1	ORD-1-00136	2024-07-19	13	3	2	1	Online	4	2500.00	0.00	10000.00	3200.00	6800.00	Mike Johnson	INV-1-00136	Overdue	2025-12-13 07:11:45.467881
137	1	ORD-1-00137	2024-09-22	9	10	5	1	Direct Sales	3	350.00	5.00	997.50	360.00	637.50	Mike Johnson	INV-1-00137	Paid	2025-12-13 07:11:45.467881
138	1	ORD-1-00138	2023-03-29	2	4	3	1	Reseller	5	3500.00	0.00	17500.00	6000.00	11500.00	John Smith	INV-1-00138	Paid	2025-12-13 07:11:45.467881
139	1	ORD-1-00139	2023-11-16	14	2	4	1	Partner	12	199.00	10.00	2149.20	600.00	1549.20	Amanda White	INV-1-00139	Pending	2025-12-13 07:11:45.467881
140	1	ORD-1-00140	2024-04-17	10	9	3	1	Partner	10	800.00	15.00	6800.00	2000.00	4800.00	Mike Johnson	INV-1-00140	Pending	2025-12-13 07:11:45.467881
141	1	ORD-1-00141	2024-09-25	6	6	1	1	Direct Sales	19	2000.00	10.00	34200.00	11400.00	22800.00	Jane Doe	INV-1-00141	Paid	2025-12-13 07:11:45.467881
142	1	ORD-1-00142	2024-04-20	15	2	2	1	Partner	8	199.00	10.00	1432.80	400.00	1032.80	Emily Davis	INV-1-00142	Paid	2025-12-13 07:11:45.467881
143	1	ORD-1-00143	2023-02-14	2	7	5	1	Partner	19	4500.00	15.00	72675.00	28500.00	44175.00	David Brown	INV-1-00143	Pending	2025-12-13 07:11:45.467881
144	1	ORD-1-00144	2024-07-16	2	6	4	1	Direct Sales	15	2000.00	15.00	25500.00	9000.00	16500.00	Amanda White	INV-1-00144	Pending	2025-12-13 07:11:45.467881
145	1	ORD-1-00145	2023-01-26	3	10	5	1	Retail	12	350.00	5.00	3990.00	1440.00	2550.00	Lisa Anderson	INV-1-00145	Overdue	2025-12-13 07:11:45.467881
146	1	ORD-1-00146	2024-01-16	11	7	5	1	Retail	18	4500.00	0.00	81000.00	27000.00	54000.00	Mike Johnson	INV-1-00146	Pending	2025-12-13 07:11:45.467881
147	1	ORD-1-00147	2023-10-12	9	7	1	1	Online	17	4500.00	10.00	68850.00	25500.00	43350.00	Sarah Wilson	INV-1-00147	Paid	2025-12-13 07:11:45.467881
148	1	ORD-1-00148	2023-06-30	7	3	5	1	Reseller	5	2500.00	20.00	10000.00	4000.00	6000.00	Lisa Anderson	INV-1-00148	Pending	2025-12-13 07:11:45.467881
149	1	ORD-1-00149	2023-11-29	2	7	4	1	Retail	10	4500.00	20.00	36000.00	15000.00	21000.00	David Brown	INV-1-00149	Paid	2025-12-13 07:11:45.467881
150	1	ORD-1-00150	2023-06-12	11	2	3	1	Online	19	199.00	20.00	3024.80	950.00	2074.80	John Smith	INV-1-00150	Paid	2025-12-13 07:11:45.467881
151	1	ORD-1-00151	2024-10-28	14	4	2	1	Retail	10	3500.00	20.00	28000.00	12000.00	16000.00	Robert Taylor	INV-1-00151	Paid	2025-12-13 07:11:45.467881
152	1	ORD-1-00152	2024-06-11	15	3	4	1	Reseller	3	2500.00	15.00	6375.00	2400.00	3975.00	David Brown	INV-1-00152	Overdue	2025-12-13 07:11:45.467881
153	1	ORD-1-00153	2023-04-19	2	3	2	1	Retail	20	2500.00	20.00	40000.00	16000.00	24000.00	Emily Davis	INV-1-00153	Paid	2025-12-13 07:11:45.467881
154	1	ORD-1-00154	2024-08-08	7	3	3	1	Direct Sales	12	2500.00	10.00	27000.00	9600.00	17400.00	Lisa Anderson	INV-1-00154	Paid	2025-12-13 07:11:45.467881
155	1	ORD-1-00155	2023-12-20	8	10	1	1	Reseller	15	350.00	5.00	4987.50	1800.00	3187.50	Sarah Wilson	INV-1-00155	Paid	2025-12-13 07:11:45.467881
156	1	ORD-1-00156	2024-07-05	4	6	5	1	Retail	4	2000.00	15.00	6800.00	2400.00	4400.00	Sarah Wilson	INV-1-00156	Overdue	2025-12-13 07:11:45.467881
157	1	ORD-1-00157	2024-03-04	10	3	2	1	Online	13	2500.00	0.00	32500.00	10400.00	22100.00	John Smith	INV-1-00157	Paid	2025-12-13 07:11:45.467881
158	1	ORD-1-00158	2024-06-29	6	1	4	1	Retail	5	5000.00	5.00	23750.00	7500.00	16250.00	Mike Johnson	INV-1-00158	Paid	2025-12-13 07:11:45.467881
159	1	ORD-1-00159	2024-08-07	15	10	2	1	Retail	5	350.00	0.00	1750.00	600.00	1150.00	Lisa Anderson	INV-1-00159	Paid	2025-12-13 07:11:45.467881
160	1	ORD-1-00160	2023-03-28	12	9	5	1	Online	8	800.00	10.00	5760.00	1600.00	4160.00	Robert Taylor	INV-1-00160	Pending	2025-12-13 07:11:45.467881
161	1	ORD-1-00161	2024-11-30	12	4	5	1	Retail	16	3500.00	20.00	44800.00	19200.00	25600.00	John Smith	INV-1-00161	Pending	2025-12-13 07:11:45.467881
162	1	ORD-1-00162	2023-05-18	9	8	3	1	Direct Sales	1	500.00	20.00	400.00	150.00	250.00	Sarah Wilson	INV-1-00162	Overdue	2025-12-13 07:11:45.467881
163	1	ORD-1-00163	2023-10-15	1	9	4	1	Retail	16	800.00	0.00	12800.00	3200.00	9600.00	Robert Taylor	INV-1-00163	Pending	2025-12-13 07:11:45.467881
164	1	ORD-1-00164	2024-07-03	11	10	3	1	Reseller	12	350.00	20.00	3360.00	1440.00	1920.00	David Brown	INV-1-00164	Paid	2025-12-13 07:11:45.467881
165	1	ORD-1-00165	2023-11-12	10	4	3	1	Partner	13	3500.00	20.00	36400.00	15600.00	20800.00	Jane Doe	INV-1-00165	Paid	2025-12-13 07:11:45.467881
166	1	ORD-1-00166	2023-12-03	9	4	4	1	Online	3	3500.00	15.00	8925.00	3600.00	5325.00	Chris Lee	INV-1-00166	Pending	2025-12-13 07:11:45.467881
167	1	ORD-1-00167	2023-11-09	12	8	3	1	Reseller	18	500.00	5.00	8550.00	2700.00	5850.00	Jane Doe	INV-1-00167	Paid	2025-12-13 07:11:45.467881
168	1	ORD-1-00168	2023-11-24	15	1	4	1	Online	14	5000.00	0.00	70000.00	21000.00	49000.00	Robert Taylor	INV-1-00168	Pending	2025-12-13 07:11:45.467881
169	1	ORD-1-00169	2023-04-30	4	9	3	1	Reseller	5	800.00	15.00	3400.00	1000.00	2400.00	John Smith	INV-1-00169	Paid	2025-12-13 07:11:45.467881
170	1	ORD-1-00170	2023-10-18	14	3	1	1	Retail	14	2500.00	20.00	28000.00	11200.00	16800.00	Jane Doe	INV-1-00170	Paid	2025-12-13 07:11:45.467881
171	1	ORD-1-00171	2024-03-21	10	6	2	1	Direct Sales	13	2000.00	20.00	20800.00	7800.00	13000.00	Sarah Wilson	INV-1-00171	Overdue	2025-12-13 07:11:45.467881
172	1	ORD-1-00172	2023-09-06	15	1	3	1	Direct Sales	20	5000.00	15.00	85000.00	30000.00	55000.00	John Smith	INV-1-00172	Paid	2025-12-13 07:11:45.467881
173	1	ORD-1-00173	2023-07-30	10	8	1	1	Online	17	500.00	5.00	8075.00	2550.00	5525.00	Robert Taylor	INV-1-00173	Paid	2025-12-13 07:11:45.467881
174	1	ORD-1-00174	2023-07-24	5	5	1	1	Retail	10	1500.00	0.00	15000.00	4000.00	11000.00	Chris Lee	INV-1-00174	Overdue	2025-12-13 07:11:45.467881
175	1	ORD-1-00175	2023-05-12	9	4	2	1	Retail	14	3500.00	5.00	46550.00	16800.00	29750.00	Amanda White	INV-1-00175	Paid	2025-12-13 07:11:45.467881
176	1	ORD-1-00176	2024-04-16	5	6	4	1	Retail	4	2000.00	20.00	6400.00	2400.00	4000.00	John Smith	INV-1-00176	Paid	2025-12-13 07:11:45.467881
177	1	ORD-1-00177	2024-01-12	10	3	2	1	Online	4	2500.00	0.00	10000.00	3200.00	6800.00	Jane Doe	INV-1-00177	Paid	2025-12-13 07:11:45.467881
178	1	ORD-1-00178	2024-02-07	12	2	3	1	Partner	12	199.00	20.00	1910.40	600.00	1310.40	Chris Lee	INV-1-00178	Paid	2025-12-13 07:11:45.467881
179	1	ORD-1-00179	2023-11-20	9	6	2	1	Direct Sales	4	2000.00	10.00	7200.00	2400.00	4800.00	Sarah Wilson	INV-1-00179	Paid	2025-12-13 07:11:45.467881
180	1	ORD-1-00180	2023-06-14	8	5	1	1	Retail	13	1500.00	20.00	15600.00	5200.00	10400.00	Jane Doe	INV-1-00180	Paid	2025-12-13 07:11:45.467881
181	1	ORD-1-00181	2023-02-03	1	7	3	1	Reseller	19	4500.00	15.00	72675.00	28500.00	44175.00	John Smith	INV-1-00181	Paid	2025-12-13 07:11:45.467881
182	1	ORD-1-00182	2023-12-08	2	6	5	1	Reseller	2	2000.00	20.00	3200.00	1200.00	2000.00	John Smith	INV-1-00182	Paid	2025-12-13 07:11:45.467881
183	1	ORD-1-00183	2024-03-05	6	3	4	1	Reseller	18	2500.00	10.00	40500.00	14400.00	26100.00	Jane Doe	INV-1-00183	Paid	2025-12-13 07:11:45.467881
184	1	ORD-1-00184	2023-02-24	4	1	2	1	Partner	11	5000.00	5.00	52250.00	16500.00	35750.00	Amanda White	INV-1-00184	Paid	2025-12-13 07:11:45.467881
185	1	ORD-1-00185	2024-04-07	2	10	4	1	Partner	13	350.00	20.00	3640.00	1560.00	2080.00	Emily Davis	INV-1-00185	Paid	2025-12-13 07:11:45.467881
186	1	ORD-1-00186	2023-01-23	10	5	4	1	Retail	13	1500.00	20.00	15600.00	5200.00	10400.00	Mike Johnson	INV-1-00186	Overdue	2025-12-13 07:11:45.467881
187	1	ORD-1-00187	2023-12-25	4	6	3	1	Retail	12	2000.00	20.00	19200.00	7200.00	12000.00	Robert Taylor	INV-1-00187	Paid	2025-12-13 07:11:45.467881
188	1	ORD-1-00188	2024-01-17	1	1	1	1	Reseller	9	5000.00	15.00	38250.00	13500.00	24750.00	Mike Johnson	INV-1-00188	Paid	2025-12-13 07:11:45.467881
189	1	ORD-1-00189	2024-10-25	5	5	2	1	Reseller	14	1500.00	10.00	18900.00	5600.00	13300.00	Mike Johnson	INV-1-00189	Paid	2025-12-13 07:11:45.467881
190	1	ORD-1-00190	2024-05-23	14	8	2	1	Online	4	500.00	10.00	1800.00	600.00	1200.00	Robert Taylor	INV-1-00190	Pending	2025-12-13 07:11:45.467881
191	1	ORD-1-00191	2024-10-25	2	8	5	1	Retail	10	500.00	10.00	4500.00	1500.00	3000.00	Amanda White	INV-1-00191	Pending	2025-12-13 07:11:45.467881
192	1	ORD-1-00192	2023-10-16	14	9	1	1	Reseller	9	800.00	20.00	5760.00	1800.00	3960.00	Mike Johnson	INV-1-00192	Overdue	2025-12-13 07:11:45.467881
193	1	ORD-1-00193	2024-02-08	3	2	4	1	Direct Sales	7	199.00	5.00	1323.35	350.00	973.35	John Smith	INV-1-00193	Overdue	2025-12-13 07:11:45.467881
194	1	ORD-1-00194	2023-06-06	12	1	1	1	Online	3	5000.00	0.00	15000.00	4500.00	10500.00	Mike Johnson	INV-1-00194	Paid	2025-12-13 07:11:45.467881
195	1	ORD-1-00195	2023-07-04	6	10	1	1	Reseller	8	350.00	5.00	2660.00	960.00	1700.00	Mike Johnson	INV-1-00195	Pending	2025-12-13 07:11:45.467881
196	1	ORD-1-00196	2023-03-09	9	6	5	1	Direct Sales	14	2000.00	5.00	26600.00	8400.00	18200.00	Lisa Anderson	INV-1-00196	Pending	2025-12-13 07:11:45.467881
197	1	ORD-1-00197	2024-02-18	7	1	4	1	Online	8	5000.00	5.00	38000.00	12000.00	26000.00	John Smith	INV-1-00197	Paid	2025-12-13 07:11:45.467881
198	1	ORD-1-00198	2023-06-21	4	9	4	1	Reseller	8	800.00	5.00	6080.00	1600.00	4480.00	Robert Taylor	INV-1-00198	Paid	2025-12-13 07:11:45.467881
199	1	ORD-1-00199	2023-12-21	6	2	4	1	Partner	9	199.00	10.00	1611.90	450.00	1161.90	Robert Taylor	INV-1-00199	Paid	2025-12-13 07:11:45.467881
200	1	ORD-1-00200	2023-04-06	7	5	5	1	Online	8	1500.00	20.00	9600.00	3200.00	6400.00	David Brown	INV-1-00200	Paid	2025-12-13 07:11:45.467881
201	1	ORD-1-00201	2024-01-19	10	1	1	1	Online	8	5000.00	20.00	32000.00	12000.00	20000.00	John Smith	INV-1-00201	Paid	2025-12-13 07:11:45.467881
202	1	ORD-1-00202	2024-07-31	5	4	1	1	Partner	16	3500.00	5.00	53200.00	19200.00	34000.00	Jane Doe	INV-1-00202	Pending	2025-12-13 07:11:45.467881
203	1	ORD-1-00203	2024-07-30	9	1	1	1	Direct Sales	4	5000.00	20.00	16000.00	6000.00	10000.00	John Smith	INV-1-00203	Paid	2025-12-13 07:11:45.467881
204	1	ORD-1-00204	2024-08-04	8	1	5	1	Retail	8	5000.00	10.00	36000.00	12000.00	24000.00	David Brown	INV-1-00204	Paid	2025-12-13 07:11:45.467881
205	1	ORD-1-00205	2024-06-15	5	2	3	1	Online	20	199.00	0.00	3980.00	1000.00	2980.00	David Brown	INV-1-00205	Paid	2025-12-13 07:11:45.467881
206	1	ORD-1-00206	2024-05-19	13	2	3	1	Retail	12	199.00	20.00	1910.40	600.00	1310.40	Emily Davis	INV-1-00206	Pending	2025-12-13 07:11:45.467881
207	1	ORD-1-00207	2023-04-16	6	7	5	1	Direct Sales	19	4500.00	10.00	76950.00	28500.00	48450.00	Sarah Wilson	INV-1-00207	Paid	2025-12-13 07:11:45.467881
208	1	ORD-1-00208	2023-03-10	9	2	5	1	Online	1	199.00	5.00	189.05	50.00	139.05	Mike Johnson	INV-1-00208	Paid	2025-12-13 07:11:45.467881
209	1	ORD-1-00209	2024-10-23	6	10	3	1	Direct Sales	8	350.00	10.00	2520.00	960.00	1560.00	David Brown	INV-1-00209	Paid	2025-12-13 07:11:45.467881
210	1	ORD-1-00210	2023-12-04	6	5	2	1	Reseller	14	1500.00	20.00	16800.00	5600.00	11200.00	Emily Davis	INV-1-00210	Overdue	2025-12-13 07:11:45.467881
211	1	ORD-1-00211	2024-01-15	15	4	1	1	Reseller	6	3500.00	15.00	17850.00	7200.00	10650.00	Sarah Wilson	INV-1-00211	Paid	2025-12-13 07:11:45.467881
212	1	ORD-1-00212	2023-03-10	9	5	2	1	Partner	2	1500.00	0.00	3000.00	800.00	2200.00	Robert Taylor	INV-1-00212	Overdue	2025-12-13 07:11:45.467881
213	1	ORD-1-00213	2024-01-27	15	2	3	1	Direct Sales	13	199.00	15.00	2198.95	650.00	1548.95	Sarah Wilson	INV-1-00213	Paid	2025-12-13 07:11:45.467881
214	1	ORD-1-00214	2024-12-29	2	1	1	1	Retail	6	5000.00	15.00	25500.00	9000.00	16500.00	Sarah Wilson	INV-1-00214	Paid	2025-12-13 07:11:45.467881
215	1	ORD-1-00215	2024-02-28	5	9	2	1	Partner	17	800.00	10.00	12240.00	3400.00	8840.00	Sarah Wilson	INV-1-00215	Pending	2025-12-13 07:11:45.467881
216	1	ORD-1-00216	2024-03-21	12	10	5	1	Online	13	350.00	0.00	4550.00	1560.00	2990.00	Mike Johnson	INV-1-00216	Pending	2025-12-13 07:11:45.467881
217	1	ORD-1-00217	2024-03-12	9	10	5	1	Online	9	350.00	20.00	2520.00	1080.00	1440.00	Sarah Wilson	INV-1-00217	Paid	2025-12-13 07:11:45.467881
218	1	ORD-1-00218	2023-04-16	6	9	3	1	Online	12	800.00	15.00	8160.00	2400.00	5760.00	John Smith	INV-1-00218	Paid	2025-12-13 07:11:45.467881
219	1	ORD-1-00219	2024-09-03	5	5	5	1	Reseller	7	1500.00	10.00	9450.00	2800.00	6650.00	Lisa Anderson	INV-1-00219	Overdue	2025-12-13 07:11:45.467881
220	1	ORD-1-00220	2023-02-15	11	3	2	1	Reseller	20	2500.00	10.00	45000.00	16000.00	29000.00	Amanda White	INV-1-00220	Paid	2025-12-13 07:11:45.467881
221	1	ORD-1-00221	2024-11-30	11	5	3	1	Partner	13	1500.00	5.00	18525.00	5200.00	13325.00	Jane Doe	INV-1-00221	Paid	2025-12-13 07:11:45.467881
222	1	ORD-1-00222	2024-01-17	4	5	3	1	Retail	14	1500.00	10.00	18900.00	5600.00	13300.00	Emily Davis	INV-1-00222	Paid	2025-12-13 07:11:45.467881
223	1	ORD-1-00223	2024-07-30	6	9	3	1	Online	13	800.00	0.00	10400.00	2600.00	7800.00	Mike Johnson	INV-1-00223	Overdue	2025-12-13 07:11:45.467881
224	1	ORD-1-00224	2023-12-07	9	5	5	1	Partner	20	1500.00	5.00	28500.00	8000.00	20500.00	Amanda White	INV-1-00224	Paid	2025-12-13 07:11:45.467881
225	1	ORD-1-00225	2023-07-31	6	3	2	1	Retail	10	2500.00	20.00	20000.00	8000.00	12000.00	Chris Lee	INV-1-00225	Overdue	2025-12-13 07:11:45.467881
226	1	ORD-1-00226	2024-01-11	8	7	2	1	Online	20	4500.00	20.00	72000.00	30000.00	42000.00	Emily Davis	INV-1-00226	Overdue	2025-12-13 07:11:45.467881
227	1	ORD-1-00227	2024-11-09	10	6	3	1	Reseller	12	2000.00	15.00	20400.00	7200.00	13200.00	John Smith	INV-1-00227	Paid	2025-12-13 07:11:45.467881
228	1	ORD-1-00228	2023-02-14	4	3	3	1	Retail	19	2500.00	5.00	45125.00	15200.00	29925.00	Amanda White	INV-1-00228	Overdue	2025-12-13 07:11:45.467881
229	1	ORD-1-00229	2023-07-19	6	10	4	1	Direct Sales	8	350.00	5.00	2660.00	960.00	1700.00	Robert Taylor	INV-1-00229	Overdue	2025-12-13 07:11:45.467881
230	1	ORD-1-00230	2024-06-21	15	4	2	1	Online	7	3500.00	10.00	22050.00	8400.00	13650.00	Jane Doe	INV-1-00230	Paid	2025-12-13 07:11:45.467881
231	1	ORD-1-00231	2024-05-20	10	7	2	1	Direct Sales	14	4500.00	0.00	63000.00	21000.00	42000.00	John Smith	INV-1-00231	Paid	2025-12-13 07:11:45.467881
232	1	ORD-1-00232	2023-08-27	8	9	2	1	Direct Sales	19	800.00	10.00	13680.00	3800.00	9880.00	Amanda White	INV-1-00232	Pending	2025-12-13 07:11:45.467881
233	1	ORD-1-00233	2023-06-17	14	3	4	1	Direct Sales	3	2500.00	5.00	7125.00	2400.00	4725.00	Jane Doe	INV-1-00233	Paid	2025-12-13 07:11:45.467881
234	1	ORD-1-00234	2023-02-18	2	10	4	1	Online	10	350.00	5.00	3325.00	1200.00	2125.00	David Brown	INV-1-00234	Paid	2025-12-13 07:11:45.467881
235	1	ORD-1-00235	2023-08-01	3	9	4	1	Direct Sales	9	800.00	20.00	5760.00	1800.00	3960.00	John Smith	INV-1-00235	Pending	2025-12-13 07:11:45.467881
236	1	ORD-1-00236	2024-11-18	11	5	4	1	Partner	19	1500.00	5.00	27075.00	7600.00	19475.00	Chris Lee	INV-1-00236	Pending	2025-12-13 07:11:45.467881
237	1	ORD-1-00237	2023-10-14	10	10	3	1	Retail	14	350.00	5.00	4655.00	1680.00	2975.00	Robert Taylor	INV-1-00237	Paid	2025-12-13 07:11:45.467881
238	1	ORD-1-00238	2024-02-04	9	10	4	1	Retail	13	350.00	0.00	4550.00	1560.00	2990.00	Amanda White	INV-1-00238	Paid	2025-12-13 07:11:45.467881
239	1	ORD-1-00239	2024-02-01	9	7	1	1	Retail	8	4500.00	5.00	34200.00	12000.00	22200.00	Robert Taylor	INV-1-00239	Paid	2025-12-13 07:11:45.467881
240	1	ORD-1-00240	2023-03-04	3	1	1	1	Direct Sales	2	5000.00	10.00	9000.00	3000.00	6000.00	David Brown	INV-1-00240	Paid	2025-12-13 07:11:45.467881
241	1	ORD-1-00241	2024-10-01	15	2	2	1	Retail	9	199.00	5.00	1701.45	450.00	1251.45	Mike Johnson	INV-1-00241	Overdue	2025-12-13 07:11:45.467881
242	1	ORD-1-00242	2023-11-15	13	4	5	1	Retail	5	3500.00	20.00	14000.00	6000.00	8000.00	Amanda White	INV-1-00242	Overdue	2025-12-13 07:11:45.467881
243	1	ORD-1-00243	2024-11-09	15	2	3	1	Retail	1	199.00	15.00	169.15	50.00	119.15	Jane Doe	INV-1-00243	Pending	2025-12-13 07:11:45.467881
244	1	ORD-1-00244	2024-03-29	2	4	3	1	Online	20	3500.00	10.00	63000.00	24000.00	39000.00	John Smith	INV-1-00244	Paid	2025-12-13 07:11:45.467881
245	1	ORD-1-00245	2024-07-29	10	5	2	1	Reseller	13	1500.00	5.00	18525.00	5200.00	13325.00	David Brown	INV-1-00245	Paid	2025-12-13 07:11:45.467881
246	1	ORD-1-00246	2024-06-24	11	7	4	1	Direct Sales	8	4500.00	5.00	34200.00	12000.00	22200.00	Robert Taylor	INV-1-00246	Overdue	2025-12-13 07:11:45.467881
247	1	ORD-1-00247	2023-03-30	8	2	4	1	Online	16	199.00	0.00	3184.00	800.00	2384.00	Amanda White	INV-1-00247	Paid	2025-12-13 07:11:45.467881
248	1	ORD-1-00248	2024-11-21	9	1	3	1	Retail	4	5000.00	10.00	18000.00	6000.00	12000.00	Amanda White	INV-1-00248	Paid	2025-12-13 07:11:45.467881
249	1	ORD-1-00249	2023-03-10	3	1	3	1	Online	7	5000.00	5.00	33250.00	10500.00	22750.00	Mike Johnson	INV-1-00249	Paid	2025-12-13 07:11:45.467881
250	1	ORD-1-00250	2024-02-06	15	6	1	1	Reseller	10	2000.00	15.00	17000.00	6000.00	11000.00	Mike Johnson	INV-1-00250	Paid	2025-12-13 07:11:45.467881
251	1	ORD-1-00251	2024-10-18	1	6	5	1	Reseller	20	2000.00	5.00	38000.00	12000.00	26000.00	Robert Taylor	INV-1-00251	Paid	2025-12-13 07:11:45.467881
252	1	ORD-1-00252	2023-04-24	6	8	3	1	Reseller	20	500.00	0.00	10000.00	3000.00	7000.00	Emily Davis	INV-1-00252	Paid	2025-12-13 07:11:45.467881
253	1	ORD-1-00253	2023-05-31	6	9	1	1	Reseller	16	800.00	15.00	10880.00	3200.00	7680.00	Lisa Anderson	INV-1-00253	Paid	2025-12-13 07:11:45.467881
254	1	ORD-1-00254	2024-10-18	15	6	2	1	Reseller	7	2000.00	10.00	12600.00	4200.00	8400.00	Lisa Anderson	INV-1-00254	Paid	2025-12-13 07:11:45.467881
255	1	ORD-1-00255	2023-01-07	14	10	2	1	Direct Sales	17	350.00	20.00	4760.00	2040.00	2720.00	Chris Lee	INV-1-00255	Pending	2025-12-13 07:11:45.467881
256	1	ORD-1-00256	2024-05-30	8	6	2	1	Reseller	8	2000.00	5.00	15200.00	4800.00	10400.00	Chris Lee	INV-1-00256	Paid	2025-12-13 07:11:45.467881
257	1	ORD-1-00257	2024-03-07	12	5	4	1	Online	9	1500.00	0.00	13500.00	3600.00	9900.00	Emily Davis	INV-1-00257	Paid	2025-12-13 07:11:45.467881
258	1	ORD-1-00258	2024-02-19	5	1	2	1	Retail	11	5000.00	15.00	46750.00	16500.00	30250.00	John Smith	INV-1-00258	Paid	2025-12-13 07:11:45.467881
259	1	ORD-1-00259	2024-09-03	4	2	2	1	Direct Sales	13	199.00	20.00	2069.60	650.00	1419.60	Sarah Wilson	INV-1-00259	Overdue	2025-12-13 07:11:45.467881
260	1	ORD-1-00260	2024-05-19	11	1	1	1	Retail	20	5000.00	0.00	100000.00	30000.00	70000.00	Lisa Anderson	INV-1-00260	Paid	2025-12-13 07:11:45.467881
261	1	ORD-1-00261	2024-03-20	8	1	1	1	Online	2	5000.00	20.00	8000.00	3000.00	5000.00	Robert Taylor	INV-1-00261	Paid	2025-12-13 07:11:45.467881
262	1	ORD-1-00262	2024-09-19	13	6	2	1	Direct Sales	8	2000.00	5.00	15200.00	4800.00	10400.00	Robert Taylor	INV-1-00262	Paid	2025-12-13 07:11:45.467881
263	1	ORD-1-00263	2023-09-24	4	10	2	1	Reseller	8	350.00	0.00	2800.00	960.00	1840.00	John Smith	INV-1-00263	Overdue	2025-12-13 07:11:45.467881
264	1	ORD-1-00264	2024-10-18	3	4	5	1	Direct Sales	8	3500.00	0.00	28000.00	9600.00	18400.00	David Brown	INV-1-00264	Paid	2025-12-13 07:11:45.467881
265	1	ORD-1-00265	2024-02-19	6	1	1	1	Reseller	16	5000.00	15.00	68000.00	24000.00	44000.00	David Brown	INV-1-00265	Pending	2025-12-13 07:11:45.467881
266	1	ORD-1-00266	2023-10-22	14	7	4	1	Reseller	7	4500.00	20.00	25200.00	10500.00	14700.00	David Brown	INV-1-00266	Pending	2025-12-13 07:11:45.467881
267	1	ORD-1-00267	2024-02-22	10	9	5	1	Retail	20	800.00	15.00	13600.00	4000.00	9600.00	David Brown	INV-1-00267	Paid	2025-12-13 07:11:45.467881
268	1	ORD-1-00268	2023-08-13	15	4	2	1	Reseller	12	3500.00	20.00	33600.00	14400.00	19200.00	Sarah Wilson	INV-1-00268	Paid	2025-12-13 07:11:45.467881
269	1	ORD-1-00269	2023-01-20	9	10	5	1	Reseller	15	350.00	10.00	4725.00	1800.00	2925.00	Amanda White	INV-1-00269	Paid	2025-12-13 07:11:45.467881
270	1	ORD-1-00270	2023-08-22	15	9	4	1	Reseller	17	800.00	20.00	10880.00	3400.00	7480.00	Chris Lee	INV-1-00270	Overdue	2025-12-13 07:11:45.467881
271	1	ORD-1-00271	2023-05-24	7	3	3	1	Direct Sales	9	2500.00	20.00	18000.00	7200.00	10800.00	Robert Taylor	INV-1-00271	Paid	2025-12-13 07:11:45.467881
272	1	ORD-1-00272	2024-08-27	4	6	3	1	Direct Sales	7	2000.00	0.00	14000.00	4200.00	9800.00	Sarah Wilson	INV-1-00272	Paid	2025-12-13 07:11:45.467881
273	1	ORD-1-00273	2023-08-27	9	3	2	1	Direct Sales	4	2500.00	15.00	8500.00	3200.00	5300.00	Amanda White	INV-1-00273	Paid	2025-12-13 07:11:45.467881
274	1	ORD-1-00274	2023-01-29	9	8	2	1	Reseller	17	500.00	15.00	7225.00	2550.00	4675.00	Lisa Anderson	INV-1-00274	Pending	2025-12-13 07:11:45.467881
275	1	ORD-1-00275	2024-11-15	6	4	5	1	Partner	12	3500.00	15.00	35700.00	14400.00	21300.00	Emily Davis	INV-1-00275	Paid	2025-12-13 07:11:45.467881
276	1	ORD-1-00276	2024-04-26	12	7	5	1	Partner	12	4500.00	10.00	48600.00	18000.00	30600.00	John Smith	INV-1-00276	Paid	2025-12-13 07:11:45.467881
277	1	ORD-1-00277	2023-02-04	2	7	1	1	Direct Sales	5	4500.00	15.00	19125.00	7500.00	11625.00	Amanda White	INV-1-00277	Pending	2025-12-13 07:11:45.467881
278	1	ORD-1-00278	2024-05-06	7	7	1	1	Reseller	13	4500.00	15.00	49725.00	19500.00	30225.00	Mike Johnson	INV-1-00278	Paid	2025-12-13 07:11:45.467881
279	1	ORD-1-00279	2024-12-13	1	2	2	1	Online	6	199.00	15.00	1014.90	300.00	714.90	John Smith	INV-1-00279	Paid	2025-12-13 07:11:45.467881
280	1	ORD-1-00280	2023-01-28	11	3	1	1	Direct Sales	8	2500.00	0.00	20000.00	6400.00	13600.00	Robert Taylor	INV-1-00280	Pending	2025-12-13 07:11:45.467881
281	1	ORD-1-00281	2023-05-11	15	10	5	1	Reseller	13	350.00	15.00	3867.50	1560.00	2307.50	David Brown	INV-1-00281	Overdue	2025-12-13 07:11:45.467881
282	1	ORD-1-00282	2024-10-02	13	10	2	1	Online	13	350.00	5.00	4322.50	1560.00	2762.50	Sarah Wilson	INV-1-00282	Paid	2025-12-13 07:11:45.467881
283	1	ORD-1-00283	2024-06-18	14	4	4	1	Direct Sales	16	3500.00	20.00	44800.00	19200.00	25600.00	Mike Johnson	INV-1-00283	Paid	2025-12-13 07:11:45.467881
284	1	ORD-1-00284	2023-11-03	4	6	3	1	Online	14	2000.00	5.00	26600.00	8400.00	18200.00	Amanda White	INV-1-00284	Pending	2025-12-13 07:11:45.467881
285	1	ORD-1-00285	2024-12-07	2	8	5	1	Reseller	13	500.00	0.00	6500.00	1950.00	4550.00	Lisa Anderson	INV-1-00285	Paid	2025-12-13 07:11:45.467881
286	1	ORD-1-00286	2023-01-11	5	6	1	1	Direct Sales	14	2000.00	20.00	22400.00	8400.00	14000.00	Robert Taylor	INV-1-00286	Paid	2025-12-13 07:11:45.467881
287	1	ORD-1-00287	2023-11-13	10	6	5	1	Direct Sales	12	2000.00	0.00	24000.00	7200.00	16800.00	John Smith	INV-1-00287	Paid	2025-12-13 07:11:45.467881
288	1	ORD-1-00288	2024-12-20	8	6	2	1	Online	19	2000.00	20.00	30400.00	11400.00	19000.00	David Brown	INV-1-00288	Paid	2025-12-13 07:11:45.467881
289	1	ORD-1-00289	2024-11-16	4	10	4	1	Direct Sales	3	350.00	0.00	1050.00	360.00	690.00	John Smith	INV-1-00289	Paid	2025-12-13 07:11:45.467881
290	1	ORD-1-00290	2023-03-09	2	6	2	1	Online	20	2000.00	20.00	32000.00	12000.00	20000.00	Sarah Wilson	INV-1-00290	Paid	2025-12-13 07:11:45.467881
291	1	ORD-1-00291	2023-07-16	11	6	2	1	Direct Sales	8	2000.00	0.00	16000.00	4800.00	11200.00	Robert Taylor	INV-1-00291	Overdue	2025-12-13 07:11:45.467881
292	1	ORD-1-00292	2023-03-23	15	5	3	1	Partner	19	1500.00	5.00	27075.00	7600.00	19475.00	Chris Lee	INV-1-00292	Paid	2025-12-13 07:11:45.467881
293	1	ORD-1-00293	2024-12-03	5	10	5	1	Reseller	12	350.00	10.00	3780.00	1440.00	2340.00	Robert Taylor	INV-1-00293	Overdue	2025-12-13 07:11:45.467881
294	1	ORD-1-00294	2024-07-06	1	4	5	1	Retail	3	3500.00	15.00	8925.00	3600.00	5325.00	David Brown	INV-1-00294	Paid	2025-12-13 07:11:45.467881
295	1	ORD-1-00295	2023-03-20	14	4	1	1	Partner	11	3500.00	10.00	34650.00	13200.00	21450.00	Chris Lee	INV-1-00295	Overdue	2025-12-13 07:11:45.467881
296	1	ORD-1-00296	2023-09-01	1	4	5	1	Online	8	3500.00	20.00	22400.00	9600.00	12800.00	David Brown	INV-1-00296	Overdue	2025-12-13 07:11:45.467881
297	1	ORD-1-00297	2023-10-07	8	8	2	1	Retail	15	500.00	0.00	7500.00	2250.00	5250.00	Emily Davis	INV-1-00297	Paid	2025-12-13 07:11:45.467881
298	1	ORD-1-00298	2024-10-10	14	3	2	1	Retail	13	2500.00	5.00	30875.00	10400.00	20475.00	David Brown	INV-1-00298	Paid	2025-12-13 07:11:45.467881
299	1	ORD-1-00299	2023-11-01	12	6	2	1	Retail	8	2000.00	5.00	15200.00	4800.00	10400.00	David Brown	INV-1-00299	Paid	2025-12-13 07:11:45.467881
300	1	ORD-1-00300	2024-06-02	9	8	3	1	Online	8	500.00	10.00	3600.00	1200.00	2400.00	Chris Lee	INV-1-00300	Overdue	2025-12-13 07:11:45.467881
301	1	ORD-1-00301	2024-12-25	4	1	5	1	Retail	20	5000.00	15.00	85000.00	30000.00	55000.00	Mike Johnson	INV-1-00301	Overdue	2025-12-13 07:11:45.467881
302	1	ORD-1-00302	2024-03-16	8	5	4	1	Partner	1	1500.00	10.00	1350.00	400.00	950.00	Sarah Wilson	INV-1-00302	Overdue	2025-12-13 07:11:45.467881
303	1	ORD-1-00303	2024-04-23	1	10	4	1	Online	11	350.00	5.00	3657.50	1320.00	2337.50	Lisa Anderson	INV-1-00303	Paid	2025-12-13 07:11:45.467881
304	1	ORD-1-00304	2023-03-21	11	4	5	1	Retail	10	3500.00	15.00	29750.00	12000.00	17750.00	John Smith	INV-1-00304	Paid	2025-12-13 07:11:45.467881
305	1	ORD-1-00305	2023-12-07	2	3	2	1	Retail	2	2500.00	10.00	4500.00	1600.00	2900.00	Jane Doe	INV-1-00305	Paid	2025-12-13 07:11:45.467881
306	1	ORD-1-00306	2023-03-26	9	7	5	1	Reseller	7	4500.00	10.00	28350.00	10500.00	17850.00	Mike Johnson	INV-1-00306	Paid	2025-12-13 07:11:45.467881
307	1	ORD-1-00307	2024-07-08	1	6	2	1	Direct Sales	3	2000.00	20.00	4800.00	1800.00	3000.00	Mike Johnson	INV-1-00307	Paid	2025-12-13 07:11:45.467881
308	1	ORD-1-00308	2023-08-30	1	5	2	1	Direct Sales	14	1500.00	15.00	17850.00	5600.00	12250.00	Lisa Anderson	INV-1-00308	Paid	2025-12-13 07:11:45.467881
309	1	ORD-1-00309	2023-06-18	11	4	4	1	Retail	15	3500.00	15.00	44625.00	18000.00	26625.00	Emily Davis	INV-1-00309	Pending	2025-12-13 07:11:45.467881
310	1	ORD-1-00310	2023-07-28	6	7	2	1	Reseller	12	4500.00	20.00	43200.00	18000.00	25200.00	Mike Johnson	INV-1-00310	Pending	2025-12-13 07:11:45.467881
311	1	ORD-1-00311	2023-02-11	5	10	3	1	Retail	11	350.00	0.00	3850.00	1320.00	2530.00	John Smith	INV-1-00311	Paid	2025-12-13 07:11:45.467881
312	1	ORD-1-00312	2023-06-22	2	3	1	1	Reseller	17	2500.00	10.00	38250.00	13600.00	24650.00	Mike Johnson	INV-1-00312	Paid	2025-12-13 07:11:45.467881
313	1	ORD-1-00313	2023-03-11	5	4	5	1	Online	18	3500.00	5.00	59850.00	21600.00	38250.00	Sarah Wilson	INV-1-00313	Paid	2025-12-13 07:11:45.467881
314	1	ORD-1-00314	2024-09-28	12	8	5	1	Retail	10	500.00	5.00	4750.00	1500.00	3250.00	Lisa Anderson	INV-1-00314	Pending	2025-12-13 07:11:45.467881
315	1	ORD-1-00315	2024-07-04	8	5	2	1	Online	5	1500.00	10.00	6750.00	2000.00	4750.00	Chris Lee	INV-1-00315	Overdue	2025-12-13 07:11:45.467881
316	1	ORD-1-00316	2024-04-23	8	7	5	1	Retail	6	4500.00	10.00	24300.00	9000.00	15300.00	Amanda White	INV-1-00316	Pending	2025-12-13 07:11:45.467881
317	1	ORD-1-00317	2023-10-06	9	1	3	1	Online	5	5000.00	5.00	23750.00	7500.00	16250.00	John Smith	INV-1-00317	Paid	2025-12-13 07:11:45.467881
318	1	ORD-1-00318	2024-02-09	5	6	5	1	Reseller	1	2000.00	10.00	1800.00	600.00	1200.00	Robert Taylor	INV-1-00318	Overdue	2025-12-13 07:11:45.467881
319	1	ORD-1-00319	2024-08-30	3	2	5	1	Partner	14	199.00	20.00	2228.80	700.00	1528.80	Emily Davis	INV-1-00319	Pending	2025-12-13 07:11:45.467881
320	1	ORD-1-00320	2024-04-18	4	2	1	1	Online	14	199.00	20.00	2228.80	700.00	1528.80	Lisa Anderson	INV-1-00320	Paid	2025-12-13 07:11:45.467881
321	1	ORD-1-00321	2024-04-05	11	5	3	1	Direct Sales	11	1500.00	5.00	15675.00	4400.00	11275.00	David Brown	INV-1-00321	Pending	2025-12-13 07:11:45.467881
322	1	ORD-1-00322	2024-04-16	4	7	4	1	Online	1	4500.00	15.00	3825.00	1500.00	2325.00	David Brown	INV-1-00322	Paid	2025-12-13 07:11:45.467881
323	1	ORD-1-00323	2023-07-25	3	2	5	1	Partner	1	199.00	0.00	199.00	50.00	149.00	Amanda White	INV-1-00323	Pending	2025-12-13 07:11:45.467881
324	1	ORD-1-00324	2023-08-08	3	8	1	1	Reseller	1	500.00	5.00	475.00	150.00	325.00	Sarah Wilson	INV-1-00324	Overdue	2025-12-13 07:11:45.467881
325	1	ORD-1-00325	2023-05-06	8	10	5	1	Retail	5	350.00	15.00	1487.50	600.00	887.50	Emily Davis	INV-1-00325	Paid	2025-12-13 07:11:45.467881
326	1	ORD-1-00326	2024-01-17	3	3	2	1	Partner	18	2500.00	20.00	36000.00	14400.00	21600.00	Lisa Anderson	INV-1-00326	Overdue	2025-12-13 07:11:45.467881
327	1	ORD-1-00327	2024-08-14	10	2	1	1	Online	11	199.00	0.00	2189.00	550.00	1639.00	John Smith	INV-1-00327	Paid	2025-12-13 07:11:45.467881
328	1	ORD-1-00328	2023-05-25	3	2	5	1	Direct Sales	18	199.00	5.00	3402.90	900.00	2502.90	Mike Johnson	INV-1-00328	Overdue	2025-12-13 07:11:45.467881
329	1	ORD-1-00329	2024-06-30	2	3	1	1	Retail	20	2500.00	0.00	50000.00	16000.00	34000.00	David Brown	INV-1-00329	Paid	2025-12-13 07:11:45.467881
330	1	ORD-1-00330	2024-02-26	8	5	3	1	Partner	17	1500.00	10.00	22950.00	6800.00	16150.00	Lisa Anderson	INV-1-00330	Paid	2025-12-13 07:11:45.467881
331	1	ORD-1-00331	2024-08-10	6	4	1	1	Direct Sales	8	3500.00	10.00	25200.00	9600.00	15600.00	John Smith	INV-1-00331	Pending	2025-12-13 07:11:45.467881
332	1	ORD-1-00332	2024-05-28	3	9	1	1	Partner	16	800.00	0.00	12800.00	3200.00	9600.00	David Brown	INV-1-00332	Pending	2025-12-13 07:11:45.467881
333	1	ORD-1-00333	2023-03-18	6	1	5	1	Direct Sales	6	5000.00	15.00	25500.00	9000.00	16500.00	Jane Doe	INV-1-00333	Pending	2025-12-13 07:11:45.467881
334	1	ORD-1-00334	2023-11-12	7	2	1	1	Partner	5	199.00	5.00	945.25	250.00	695.25	Chris Lee	INV-1-00334	Paid	2025-12-13 07:11:45.467881
335	1	ORD-1-00335	2024-06-30	2	3	2	1	Partner	14	2500.00	5.00	33250.00	11200.00	22050.00	John Smith	INV-1-00335	Overdue	2025-12-13 07:11:45.467881
336	1	ORD-1-00336	2024-06-10	11	8	3	1	Partner	3	500.00	5.00	1425.00	450.00	975.00	Lisa Anderson	INV-1-00336	Pending	2025-12-13 07:11:45.467881
337	1	ORD-1-00337	2023-05-03	11	6	5	1	Retail	4	2000.00	20.00	6400.00	2400.00	4000.00	John Smith	INV-1-00337	Overdue	2025-12-13 07:11:45.467881
338	1	ORD-1-00338	2024-05-09	2	2	5	1	Direct Sales	6	199.00	0.00	1194.00	300.00	894.00	Jane Doe	INV-1-00338	Overdue	2025-12-13 07:11:45.467881
339	1	ORD-1-00339	2023-01-21	12	6	4	1	Online	9	2000.00	0.00	18000.00	5400.00	12600.00	Amanda White	INV-1-00339	Pending	2025-12-13 07:11:45.467881
340	1	ORD-1-00340	2023-10-09	3	2	2	1	Retail	19	199.00	20.00	3024.80	950.00	2074.80	Mike Johnson	INV-1-00340	Overdue	2025-12-13 07:11:45.467881
341	1	ORD-1-00341	2023-09-19	11	7	3	1	Retail	7	4500.00	5.00	29925.00	10500.00	19425.00	Lisa Anderson	INV-1-00341	Paid	2025-12-13 07:11:45.467881
342	1	ORD-1-00342	2023-12-05	14	5	2	1	Direct Sales	8	1500.00	5.00	11400.00	3200.00	8200.00	Jane Doe	INV-1-00342	Paid	2025-12-13 07:11:45.467881
343	1	ORD-1-00343	2024-01-23	6	5	2	1	Partner	19	1500.00	0.00	28500.00	7600.00	20900.00	Emily Davis	INV-1-00343	Pending	2025-12-13 07:11:45.467881
344	1	ORD-1-00344	2023-07-29	5	7	3	1	Direct Sales	5	4500.00	20.00	18000.00	7500.00	10500.00	Robert Taylor	INV-1-00344	Paid	2025-12-13 07:11:45.467881
345	1	ORD-1-00345	2024-03-07	13	5	3	1	Partner	12	1500.00	10.00	16200.00	4800.00	11400.00	Chris Lee	INV-1-00345	Paid	2025-12-13 07:11:45.467881
346	1	ORD-1-00346	2024-05-08	7	5	2	1	Retail	10	1500.00	0.00	15000.00	4000.00	11000.00	Amanda White	INV-1-00346	Paid	2025-12-13 07:11:45.467881
347	1	ORD-1-00347	2024-08-15	10	3	4	1	Reseller	5	2500.00	0.00	12500.00	4000.00	8500.00	Chris Lee	INV-1-00347	Paid	2025-12-13 07:11:45.467881
348	1	ORD-1-00348	2024-12-07	6	10	4	1	Direct Sales	9	350.00	20.00	2520.00	1080.00	1440.00	Jane Doe	INV-1-00348	Pending	2025-12-13 07:11:45.467881
349	1	ORD-1-00349	2024-06-23	11	1	3	1	Partner	1	5000.00	10.00	4500.00	1500.00	3000.00	Amanda White	INV-1-00349	Paid	2025-12-13 07:11:45.467881
350	1	ORD-1-00350	2024-09-26	4	6	2	1	Retail	19	2000.00	0.00	38000.00	11400.00	26600.00	John Smith	INV-1-00350	Paid	2025-12-13 07:11:45.467881
351	1	ORD-1-00351	2023-12-19	6	1	3	1	Partner	15	5000.00	10.00	67500.00	22500.00	45000.00	Sarah Wilson	INV-1-00351	Paid	2025-12-13 07:11:45.467881
352	1	ORD-1-00352	2023-10-18	3	2	4	1	Partner	11	199.00	0.00	2189.00	550.00	1639.00	Mike Johnson	INV-1-00352	Overdue	2025-12-13 07:11:45.467881
353	1	ORD-1-00353	2023-01-05	4	2	2	1	Reseller	10	199.00	15.00	1691.50	500.00	1191.50	Sarah Wilson	INV-1-00353	Paid	2025-12-13 07:11:45.467881
354	1	ORD-1-00354	2023-02-17	14	1	4	1	Online	15	5000.00	15.00	63750.00	22500.00	41250.00	David Brown	INV-1-00354	Paid	2025-12-13 07:11:45.467881
355	1	ORD-1-00355	2023-09-23	12	7	2	1	Direct Sales	9	4500.00	5.00	38475.00	13500.00	24975.00	Sarah Wilson	INV-1-00355	Paid	2025-12-13 07:11:45.467881
356	1	ORD-1-00356	2024-04-30	7	6	1	1	Partner	1	2000.00	10.00	1800.00	600.00	1200.00	Chris Lee	INV-1-00356	Paid	2025-12-13 07:11:45.467881
357	1	ORD-1-00357	2024-11-15	8	3	2	1	Retail	18	2500.00	15.00	38250.00	14400.00	23850.00	Emily Davis	INV-1-00357	Overdue	2025-12-13 07:11:45.467881
358	1	ORD-1-00358	2023-07-28	11	4	1	1	Reseller	7	3500.00	15.00	20825.00	8400.00	12425.00	Robert Taylor	INV-1-00358	Overdue	2025-12-13 07:11:45.467881
359	1	ORD-1-00359	2023-07-03	7	3	4	1	Online	5	2500.00	20.00	10000.00	4000.00	6000.00	David Brown	INV-1-00359	Overdue	2025-12-13 07:11:45.467881
360	1	ORD-1-00360	2024-12-29	7	1	2	1	Online	3	5000.00	5.00	14250.00	4500.00	9750.00	Mike Johnson	INV-1-00360	Paid	2025-12-13 07:11:45.467881
361	1	ORD-1-00361	2023-07-04	5	5	1	1	Partner	16	1500.00	10.00	21600.00	6400.00	15200.00	Chris Lee	INV-1-00361	Paid	2025-12-13 07:11:45.467881
362	1	ORD-1-00362	2023-07-04	10	9	5	1	Reseller	7	800.00	10.00	5040.00	1400.00	3640.00	David Brown	INV-1-00362	Paid	2025-12-13 07:11:45.467881
363	1	ORD-1-00363	2024-10-13	4	8	4	1	Partner	5	500.00	10.00	2250.00	750.00	1500.00	Chris Lee	INV-1-00363	Paid	2025-12-13 07:11:45.467881
364	1	ORD-1-00364	2023-06-25	11	10	2	1	Online	11	350.00	20.00	3080.00	1320.00	1760.00	Amanda White	INV-1-00364	Paid	2025-12-13 07:11:45.467881
365	1	ORD-1-00365	2024-12-18	7	3	5	1	Reseller	12	2500.00	5.00	28500.00	9600.00	18900.00	Sarah Wilson	INV-1-00365	Pending	2025-12-13 07:11:45.467881
366	1	ORD-1-00366	2023-04-09	4	7	4	1	Direct Sales	6	4500.00	20.00	21600.00	9000.00	12600.00	Emily Davis	INV-1-00366	Overdue	2025-12-13 07:11:45.467881
367	1	ORD-1-00367	2023-04-14	14	6	2	1	Online	7	2000.00	15.00	11900.00	4200.00	7700.00	Emily Davis	INV-1-00367	Overdue	2025-12-13 07:11:45.467881
368	1	ORD-1-00368	2024-01-06	9	5	3	1	Online	19	1500.00	0.00	28500.00	7600.00	20900.00	Emily Davis	INV-1-00368	Overdue	2025-12-13 07:11:45.467881
369	1	ORD-1-00369	2023-01-24	2	1	5	1	Partner	4	5000.00	10.00	18000.00	6000.00	12000.00	Jane Doe	INV-1-00369	Paid	2025-12-13 07:11:45.467881
370	1	ORD-1-00370	2023-09-08	11	9	1	1	Retail	3	800.00	0.00	2400.00	600.00	1800.00	John Smith	INV-1-00370	Overdue	2025-12-13 07:11:45.467881
371	1	ORD-1-00371	2023-12-28	5	4	4	1	Partner	6	3500.00	15.00	17850.00	7200.00	10650.00	Emily Davis	INV-1-00371	Paid	2025-12-13 07:11:45.467881
372	1	ORD-1-00372	2023-03-17	8	10	5	1	Online	20	350.00	20.00	5600.00	2400.00	3200.00	Lisa Anderson	INV-1-00372	Pending	2025-12-13 07:11:45.467881
373	1	ORD-1-00373	2024-12-30	15	9	5	1	Retail	2	800.00	5.00	1520.00	400.00	1120.00	Amanda White	INV-1-00373	Overdue	2025-12-13 07:11:45.467881
374	1	ORD-1-00374	2024-12-20	5	4	4	1	Partner	3	3500.00	10.00	9450.00	3600.00	5850.00	Amanda White	INV-1-00374	Paid	2025-12-13 07:11:45.467881
375	1	ORD-1-00375	2023-07-04	8	6	1	1	Partner	12	2000.00	5.00	22800.00	7200.00	15600.00	David Brown	INV-1-00375	Pending	2025-12-13 07:11:45.467881
376	1	ORD-1-00376	2024-11-01	11	8	3	1	Online	10	500.00	10.00	4500.00	1500.00	3000.00	Emily Davis	INV-1-00376	Pending	2025-12-13 07:11:45.467881
377	1	ORD-1-00377	2023-02-02	12	4	3	1	Direct Sales	9	3500.00	5.00	29925.00	10800.00	19125.00	Robert Taylor	INV-1-00377	Paid	2025-12-13 07:11:45.467881
378	1	ORD-1-00378	2024-01-24	14	5	4	1	Online	18	1500.00	10.00	24300.00	7200.00	17100.00	Lisa Anderson	INV-1-00378	Paid	2025-12-13 07:11:45.467881
379	1	ORD-1-00379	2023-10-07	1	1	3	1	Reseller	14	5000.00	15.00	59500.00	21000.00	38500.00	Emily Davis	INV-1-00379	Paid	2025-12-13 07:11:45.467881
380	1	ORD-1-00380	2024-10-17	6	2	4	1	Partner	16	199.00	20.00	2547.20	800.00	1747.20	David Brown	INV-1-00380	Paid	2025-12-13 07:11:45.467881
381	1	ORD-1-00381	2024-09-09	8	8	5	1	Retail	16	500.00	15.00	6800.00	2400.00	4400.00	Robert Taylor	INV-1-00381	Paid	2025-12-13 07:11:45.467881
382	1	ORD-1-00382	2024-02-14	3	1	2	1	Reseller	16	5000.00	0.00	80000.00	24000.00	56000.00	Jane Doe	INV-1-00382	Paid	2025-12-13 07:11:45.467881
383	1	ORD-1-00383	2023-08-12	6	5	3	1	Partner	1	1500.00	10.00	1350.00	400.00	950.00	David Brown	INV-1-00383	Paid	2025-12-13 07:11:45.467881
384	1	ORD-1-00384	2023-01-25	13	4	5	1	Online	18	3500.00	15.00	53550.00	21600.00	31950.00	Lisa Anderson	INV-1-00384	Overdue	2025-12-13 07:11:45.467881
385	1	ORD-1-00385	2023-09-09	11	10	1	1	Online	14	350.00	15.00	4165.00	1680.00	2485.00	Sarah Wilson	INV-1-00385	Paid	2025-12-13 07:11:45.467881
386	1	ORD-1-00386	2024-02-16	12	1	2	1	Retail	3	5000.00	20.00	12000.00	4500.00	7500.00	David Brown	INV-1-00386	Overdue	2025-12-13 07:11:45.467881
387	1	ORD-1-00387	2024-12-14	15	1	5	1	Retail	13	5000.00	5.00	61750.00	19500.00	42250.00	David Brown	INV-1-00387	Paid	2025-12-13 07:11:45.467881
388	1	ORD-1-00388	2024-01-26	7	9	3	1	Partner	14	800.00	20.00	8960.00	2800.00	6160.00	Amanda White	INV-1-00388	Paid	2025-12-13 07:11:45.467881
389	1	ORD-1-00389	2024-02-19	12	1	4	1	Partner	3	5000.00	20.00	12000.00	4500.00	7500.00	John Smith	INV-1-00389	Overdue	2025-12-13 07:11:45.467881
390	1	ORD-1-00390	2023-01-11	14	2	4	1	Partner	2	199.00	5.00	378.10	100.00	278.10	John Smith	INV-1-00390	Overdue	2025-12-13 07:11:45.467881
391	1	ORD-1-00391	2023-08-10	4	2	2	1	Retail	17	199.00	5.00	3213.85	850.00	2363.85	Lisa Anderson	INV-1-00391	Paid	2025-12-13 07:11:45.467881
392	1	ORD-1-00392	2024-08-03	5	10	5	1	Partner	7	350.00	5.00	2327.50	840.00	1487.50	Chris Lee	INV-1-00392	Paid	2025-12-13 07:11:45.467881
393	1	ORD-1-00393	2023-01-03	9	10	3	1	Partner	16	350.00	0.00	5600.00	1920.00	3680.00	John Smith	INV-1-00393	Paid	2025-12-13 07:11:45.467881
394	1	ORD-1-00394	2024-02-10	14	1	2	1	Retail	1	5000.00	0.00	5000.00	1500.00	3500.00	David Brown	INV-1-00394	Paid	2025-12-13 07:11:45.467881
395	1	ORD-1-00395	2023-03-28	13	6	5	1	Retail	5	2000.00	5.00	9500.00	3000.00	6500.00	Robert Taylor	INV-1-00395	Paid	2025-12-13 07:11:45.467881
396	1	ORD-1-00396	2023-07-19	8	4	1	1	Retail	9	3500.00	10.00	28350.00	10800.00	17550.00	Robert Taylor	INV-1-00396	Paid	2025-12-13 07:11:45.467881
397	1	ORD-1-00397	2023-12-17	6	9	4	1	Retail	4	800.00	10.00	2880.00	800.00	2080.00	Robert Taylor	INV-1-00397	Pending	2025-12-13 07:11:45.467881
398	1	ORD-1-00398	2023-01-26	9	3	5	1	Online	8	2500.00	20.00	16000.00	6400.00	9600.00	John Smith	INV-1-00398	Pending	2025-12-13 07:11:45.467881
399	1	ORD-1-00399	2024-10-15	15	6	2	1	Partner	17	2000.00	20.00	27200.00	10200.00	17000.00	Amanda White	INV-1-00399	Overdue	2025-12-13 07:11:45.467881
400	1	ORD-1-00400	2023-06-27	1	5	4	1	Retail	14	1500.00	10.00	18900.00	5600.00	13300.00	David Brown	INV-1-00400	Paid	2025-12-13 07:11:45.467881
401	1	ORD-1-00401	2023-12-11	9	2	4	1	Partner	8	199.00	0.00	1592.00	400.00	1192.00	Chris Lee	INV-1-00401	Paid	2025-12-13 07:11:45.467881
402	1	ORD-1-00402	2024-06-26	5	1	4	1	Online	17	5000.00	15.00	72250.00	25500.00	46750.00	Mike Johnson	INV-1-00402	Pending	2025-12-13 07:11:45.467881
403	1	ORD-1-00403	2024-03-04	2	2	4	1	Partner	5	199.00	5.00	945.25	250.00	695.25	John Smith	INV-1-00403	Paid	2025-12-13 07:11:45.467881
404	1	ORD-1-00404	2024-08-30	13	4	2	1	Online	18	3500.00	0.00	63000.00	21600.00	41400.00	Jane Doe	INV-1-00404	Overdue	2025-12-13 07:11:45.467881
405	1	ORD-1-00405	2024-02-17	10	4	2	1	Direct Sales	13	3500.00	10.00	40950.00	15600.00	25350.00	Lisa Anderson	INV-1-00405	Pending	2025-12-13 07:11:45.467881
406	1	ORD-1-00406	2023-07-15	11	1	4	1	Partner	20	5000.00	15.00	85000.00	30000.00	55000.00	Jane Doe	INV-1-00406	Paid	2025-12-13 07:11:45.467881
407	1	ORD-1-00407	2023-10-04	1	6	4	1	Online	16	2000.00	20.00	25600.00	9600.00	16000.00	Emily Davis	INV-1-00407	Pending	2025-12-13 07:11:45.467881
408	1	ORD-1-00408	2023-09-06	6	1	3	1	Reseller	20	5000.00	15.00	85000.00	30000.00	55000.00	Chris Lee	INV-1-00408	Paid	2025-12-13 07:11:45.467881
409	1	ORD-1-00409	2023-05-11	2	7	2	1	Reseller	8	4500.00	20.00	28800.00	12000.00	16800.00	Amanda White	INV-1-00409	Overdue	2025-12-13 07:11:45.467881
410	1	ORD-1-00410	2024-08-12	15	6	4	1	Reseller	6	2000.00	0.00	12000.00	3600.00	8400.00	Jane Doe	INV-1-00410	Paid	2025-12-13 07:11:45.467881
411	1	ORD-1-00411	2024-08-06	2	1	1	1	Reseller	18	5000.00	10.00	81000.00	27000.00	54000.00	Mike Johnson	INV-1-00411	Pending	2025-12-13 07:11:45.467881
412	1	ORD-1-00412	2023-10-04	14	1	5	1	Online	11	5000.00	20.00	44000.00	16500.00	27500.00	Chris Lee	INV-1-00412	Paid	2025-12-13 07:11:45.467881
413	1	ORD-1-00413	2024-10-28	9	2	4	1	Direct Sales	17	199.00	10.00	3044.70	850.00	2194.70	John Smith	INV-1-00413	Paid	2025-12-13 07:11:45.467881
414	1	ORD-1-00414	2023-07-21	10	5	1	1	Online	17	1500.00	5.00	24225.00	6800.00	17425.00	Mike Johnson	INV-1-00414	Paid	2025-12-13 07:11:45.467881
415	1	ORD-1-00415	2023-08-16	7	9	4	1	Retail	1	800.00	5.00	760.00	200.00	560.00	David Brown	INV-1-00415	Paid	2025-12-13 07:11:45.467881
416	1	ORD-1-00416	2024-06-22	3	3	5	1	Retail	3	2500.00	20.00	6000.00	2400.00	3600.00	Robert Taylor	INV-1-00416	Paid	2025-12-13 07:11:45.467881
417	1	ORD-1-00417	2023-09-07	10	7	3	1	Reseller	5	4500.00	20.00	18000.00	7500.00	10500.00	John Smith	INV-1-00417	Paid	2025-12-13 07:11:45.467881
418	1	ORD-1-00418	2024-04-04	9	7	4	1	Partner	4	4500.00	15.00	15300.00	6000.00	9300.00	Sarah Wilson	INV-1-00418	Paid	2025-12-13 07:11:45.467881
419	1	ORD-1-00419	2023-01-18	10	1	2	1	Online	14	5000.00	20.00	56000.00	21000.00	35000.00	Sarah Wilson	INV-1-00419	Paid	2025-12-13 07:11:45.467881
420	1	ORD-1-00420	2024-12-03	6	7	3	1	Retail	14	4500.00	5.00	59850.00	21000.00	38850.00	Robert Taylor	INV-1-00420	Pending	2025-12-13 07:11:45.467881
421	1	ORD-1-00421	2023-01-04	2	9	1	1	Online	18	800.00	10.00	12960.00	3600.00	9360.00	John Smith	INV-1-00421	Paid	2025-12-13 07:11:45.467881
422	1	ORD-1-00422	2023-01-18	3	7	2	1	Direct Sales	14	4500.00	10.00	56700.00	21000.00	35700.00	John Smith	INV-1-00422	Paid	2025-12-13 07:11:45.467881
423	1	ORD-1-00423	2024-06-07	1	5	1	1	Reseller	5	1500.00	10.00	6750.00	2000.00	4750.00	Mike Johnson	INV-1-00423	Paid	2025-12-13 07:11:45.467881
424	1	ORD-1-00424	2023-04-21	13	2	3	1	Reseller	6	199.00	5.00	1134.30	300.00	834.30	David Brown	INV-1-00424	Overdue	2025-12-13 07:11:45.467881
425	1	ORD-1-00425	2024-09-26	7	10	3	1	Retail	9	350.00	0.00	3150.00	1080.00	2070.00	Mike Johnson	INV-1-00425	Pending	2025-12-13 07:11:45.467881
426	1	ORD-1-00426	2023-09-22	4	2	5	1	Direct Sales	9	199.00	10.00	1611.90	450.00	1161.90	Sarah Wilson	INV-1-00426	Pending	2025-12-13 07:11:45.467881
427	1	ORD-1-00427	2023-09-29	6	8	2	1	Online	15	500.00	5.00	7125.00	2250.00	4875.00	Robert Taylor	INV-1-00427	Paid	2025-12-13 07:11:45.467881
428	1	ORD-1-00428	2023-03-02	9	7	1	1	Retail	1	4500.00	0.00	4500.00	1500.00	3000.00	Jane Doe	INV-1-00428	Paid	2025-12-13 07:11:45.467881
429	1	ORD-1-00429	2024-01-15	13	7	2	1	Partner	3	4500.00	15.00	11475.00	4500.00	6975.00	Sarah Wilson	INV-1-00429	Overdue	2025-12-13 07:11:45.467881
430	1	ORD-1-00430	2023-05-22	7	3	5	1	Retail	11	2500.00	20.00	22000.00	8800.00	13200.00	Jane Doe	INV-1-00430	Paid	2025-12-13 07:11:45.467881
431	1	ORD-1-00431	2024-02-16	10	1	2	1	Online	8	5000.00	20.00	32000.00	12000.00	20000.00	Jane Doe	INV-1-00431	Paid	2025-12-13 07:11:45.467881
432	1	ORD-1-00432	2023-10-22	6	8	5	1	Reseller	6	500.00	5.00	2850.00	900.00	1950.00	John Smith	INV-1-00432	Pending	2025-12-13 07:11:45.467881
433	1	ORD-1-00433	2024-04-22	1	5	2	1	Retail	19	1500.00	0.00	28500.00	7600.00	20900.00	David Brown	INV-1-00433	Paid	2025-12-13 07:11:45.467881
434	1	ORD-1-00434	2024-01-14	13	4	4	1	Direct Sales	19	3500.00	5.00	63175.00	22800.00	40375.00	Amanda White	INV-1-00434	Paid	2025-12-13 07:11:45.467881
435	1	ORD-1-00435	2024-10-10	5	3	2	1	Partner	6	2500.00	5.00	14250.00	4800.00	9450.00	Chris Lee	INV-1-00435	Overdue	2025-12-13 07:11:45.467881
436	1	ORD-1-00436	2023-07-18	5	3	1	1	Partner	11	2500.00	0.00	27500.00	8800.00	18700.00	Chris Lee	INV-1-00436	Paid	2025-12-13 07:11:45.467881
437	1	ORD-1-00437	2023-01-28	15	8	1	1	Reseller	11	500.00	20.00	4400.00	1650.00	2750.00	Chris Lee	INV-1-00437	Overdue	2025-12-13 07:11:45.467881
438	1	ORD-1-00438	2024-10-27	4	4	1	1	Reseller	11	3500.00	5.00	36575.00	13200.00	23375.00	John Smith	INV-1-00438	Overdue	2025-12-13 07:11:45.467881
439	1	ORD-1-00439	2024-03-07	12	10	2	1	Partner	5	350.00	5.00	1662.50	600.00	1062.50	Jane Doe	INV-1-00439	Paid	2025-12-13 07:11:45.467881
440	1	ORD-1-00440	2024-07-18	5	3	3	1	Reseller	2	2500.00	0.00	5000.00	1600.00	3400.00	David Brown	INV-1-00440	Overdue	2025-12-13 07:11:45.467881
441	1	ORD-1-00441	2024-05-03	10	4	5	1	Reseller	9	3500.00	20.00	25200.00	10800.00	14400.00	Lisa Anderson	INV-1-00441	Paid	2025-12-13 07:11:45.467881
442	1	ORD-1-00442	2024-07-31	10	3	5	1	Reseller	1	2500.00	20.00	2000.00	800.00	1200.00	Mike Johnson	INV-1-00442	Paid	2025-12-13 07:11:45.467881
443	1	ORD-1-00443	2023-10-07	4	2	4	1	Direct Sales	7	199.00	10.00	1253.70	350.00	903.70	Sarah Wilson	INV-1-00443	Overdue	2025-12-13 07:11:45.467881
444	1	ORD-1-00444	2024-07-12	14	10	1	1	Partner	2	350.00	20.00	560.00	240.00	320.00	Mike Johnson	INV-1-00444	Pending	2025-12-13 07:11:45.467881
445	1	ORD-1-00445	2024-05-21	3	1	5	1	Direct Sales	6	5000.00	0.00	30000.00	9000.00	21000.00	Robert Taylor	INV-1-00445	Paid	2025-12-13 07:11:45.467881
446	1	ORD-1-00446	2024-07-14	11	4	1	1	Direct Sales	20	3500.00	15.00	59500.00	24000.00	35500.00	Chris Lee	INV-1-00446	Paid	2025-12-13 07:11:45.467881
447	1	ORD-1-00447	2023-07-06	11	4	2	1	Reseller	3	3500.00	15.00	8925.00	3600.00	5325.00	Lisa Anderson	INV-1-00447	Paid	2025-12-13 07:11:45.467881
448	1	ORD-1-00448	2024-03-12	3	6	4	1	Reseller	8	2000.00	15.00	13600.00	4800.00	8800.00	Jane Doe	INV-1-00448	Paid	2025-12-13 07:11:45.467881
449	1	ORD-1-00449	2024-02-19	10	7	5	1	Online	7	4500.00	5.00	29925.00	10500.00	19425.00	Sarah Wilson	INV-1-00449	Paid	2025-12-13 07:11:45.467881
450	1	ORD-1-00450	2024-11-02	14	3	3	1	Reseller	16	2500.00	15.00	34000.00	12800.00	21200.00	Sarah Wilson	INV-1-00450	Overdue	2025-12-13 07:11:45.467881
451	1	ORD-1-00451	2023-08-10	15	2	1	1	Online	17	199.00	20.00	2706.40	850.00	1856.40	Sarah Wilson	INV-1-00451	Paid	2025-12-13 07:11:45.467881
452	1	ORD-1-00452	2024-05-29	14	3	5	1	Retail	7	2500.00	15.00	14875.00	5600.00	9275.00	Robert Taylor	INV-1-00452	Paid	2025-12-13 07:11:45.467881
453	1	ORD-1-00453	2024-12-12	4	9	1	1	Retail	18	800.00	5.00	13680.00	3600.00	10080.00	Robert Taylor	INV-1-00453	Paid	2025-12-13 07:11:45.467881
454	1	ORD-1-00454	2023-01-23	15	4	5	1	Direct Sales	8	3500.00	10.00	25200.00	9600.00	15600.00	Emily Davis	INV-1-00454	Paid	2025-12-13 07:11:45.467881
455	1	ORD-1-00455	2024-02-03	15	9	3	1	Retail	3	800.00	10.00	2160.00	600.00	1560.00	Amanda White	INV-1-00455	Paid	2025-12-13 07:11:45.467881
456	1	ORD-1-00456	2024-01-20	15	4	3	1	Partner	2	3500.00	5.00	6650.00	2400.00	4250.00	John Smith	INV-1-00456	Overdue	2025-12-13 07:11:45.467881
457	1	ORD-1-00457	2023-12-17	7	10	4	1	Retail	1	350.00	0.00	350.00	120.00	230.00	Robert Taylor	INV-1-00457	Overdue	2025-12-13 07:11:45.467881
458	1	ORD-1-00458	2024-01-04	4	8	4	1	Reseller	5	500.00	20.00	2000.00	750.00	1250.00	John Smith	INV-1-00458	Pending	2025-12-13 07:11:45.467881
459	1	ORD-1-00459	2023-05-12	15	4	1	1	Retail	18	3500.00	0.00	63000.00	21600.00	41400.00	Jane Doe	INV-1-00459	Pending	2025-12-13 07:11:45.467881
460	1	ORD-1-00460	2023-09-20	3	6	3	1	Retail	4	2000.00	10.00	7200.00	2400.00	4800.00	Mike Johnson	INV-1-00460	Paid	2025-12-13 07:11:45.467881
461	1	ORD-1-00461	2023-11-13	10	7	4	1	Direct Sales	3	4500.00	5.00	12825.00	4500.00	8325.00	Robert Taylor	INV-1-00461	Pending	2025-12-13 07:11:45.467881
462	1	ORD-1-00462	2023-01-05	11	10	3	1	Partner	18	350.00	20.00	5040.00	2160.00	2880.00	John Smith	INV-1-00462	Paid	2025-12-13 07:11:45.467881
463	1	ORD-1-00463	2023-10-14	8	9	2	1	Partner	16	800.00	5.00	12160.00	3200.00	8960.00	Sarah Wilson	INV-1-00463	Paid	2025-12-13 07:11:45.467881
464	1	ORD-1-00464	2023-06-20	4	9	4	1	Partner	18	800.00	20.00	11520.00	3600.00	7920.00	John Smith	INV-1-00464	Overdue	2025-12-13 07:11:45.467881
465	1	ORD-1-00465	2023-04-09	8	4	5	1	Partner	4	3500.00	15.00	11900.00	4800.00	7100.00	Emily Davis	INV-1-00465	Paid	2025-12-13 07:11:45.467881
466	1	ORD-1-00466	2023-03-29	10	5	1	1	Retail	13	1500.00	5.00	18525.00	5200.00	13325.00	John Smith	INV-1-00466	Paid	2025-12-13 07:11:45.467881
467	1	ORD-1-00467	2024-11-08	3	6	1	1	Retail	19	2000.00	5.00	36100.00	11400.00	24700.00	Robert Taylor	INV-1-00467	Paid	2025-12-13 07:11:45.467881
468	1	ORD-1-00468	2023-10-17	15	8	3	1	Partner	8	500.00	20.00	3200.00	1200.00	2000.00	David Brown	INV-1-00468	Paid	2025-12-13 07:11:45.467881
469	1	ORD-1-00469	2024-04-11	11	4	3	1	Online	7	3500.00	15.00	20825.00	8400.00	12425.00	Jane Doe	INV-1-00469	Pending	2025-12-13 07:11:45.467881
470	1	ORD-1-00470	2023-10-09	4	4	2	1	Online	2	3500.00	0.00	7000.00	2400.00	4600.00	Mike Johnson	INV-1-00470	Paid	2025-12-13 07:11:45.467881
471	1	ORD-1-00471	2024-03-20	7	6	4	1	Partner	10	2000.00	5.00	19000.00	6000.00	13000.00	Emily Davis	INV-1-00471	Paid	2025-12-13 07:11:45.467881
472	1	ORD-1-00472	2024-03-02	6	8	4	1	Reseller	10	500.00	0.00	5000.00	1500.00	3500.00	Mike Johnson	INV-1-00472	Paid	2025-12-13 07:11:45.467881
473	1	ORD-1-00473	2024-12-14	10	1	5	1	Reseller	16	5000.00	0.00	80000.00	24000.00	56000.00	Chris Lee	INV-1-00473	Paid	2025-12-13 07:11:45.467881
474	1	ORD-1-00474	2023-09-20	3	7	2	1	Partner	20	4500.00	10.00	81000.00	30000.00	51000.00	Amanda White	INV-1-00474	Overdue	2025-12-13 07:11:45.467881
475	1	ORD-1-00475	2024-05-26	14	7	3	1	Reseller	11	4500.00	0.00	49500.00	16500.00	33000.00	Jane Doe	INV-1-00475	Paid	2025-12-13 07:11:45.467881
476	1	ORD-1-00476	2024-01-11	15	3	2	1	Online	5	2500.00	5.00	11875.00	4000.00	7875.00	Amanda White	INV-1-00476	Paid	2025-12-13 07:11:45.467881
477	1	ORD-1-00477	2024-02-21	9	3	3	1	Direct Sales	15	2500.00	15.00	31875.00	12000.00	19875.00	Robert Taylor	INV-1-00477	Paid	2025-12-13 07:11:45.467881
478	1	ORD-1-00478	2024-07-25	13	9	2	1	Direct Sales	4	800.00	0.00	3200.00	800.00	2400.00	Robert Taylor	INV-1-00478	Overdue	2025-12-13 07:11:45.467881
479	1	ORD-1-00479	2023-09-25	6	8	5	1	Direct Sales	1	500.00	20.00	400.00	150.00	250.00	Jane Doe	INV-1-00479	Pending	2025-12-13 07:11:45.467881
480	1	ORD-1-00480	2023-01-16	6	4	5	1	Online	10	3500.00	0.00	35000.00	12000.00	23000.00	Lisa Anderson	INV-1-00480	Paid	2025-12-13 07:11:45.467881
481	1	ORD-1-00481	2023-04-24	1	2	1	1	Reseller	7	199.00	20.00	1114.40	350.00	764.40	Robert Taylor	INV-1-00481	Overdue	2025-12-13 07:11:45.467881
482	1	ORD-1-00482	2023-12-09	5	1	1	1	Online	17	5000.00	0.00	85000.00	25500.00	59500.00	Chris Lee	INV-1-00482	Paid	2025-12-13 07:11:45.467881
483	1	ORD-1-00483	2023-04-30	3	9	1	1	Online	18	800.00	0.00	14400.00	3600.00	10800.00	Chris Lee	INV-1-00483	Paid	2025-12-13 07:11:45.467881
484	1	ORD-1-00484	2024-02-11	1	1	3	1	Partner	13	5000.00	0.00	65000.00	19500.00	45500.00	John Smith	INV-1-00484	Overdue	2025-12-13 07:11:45.467881
485	1	ORD-1-00485	2024-04-19	6	2	2	1	Online	2	199.00	20.00	318.40	100.00	218.40	Lisa Anderson	INV-1-00485	Paid	2025-12-13 07:11:45.467881
486	1	ORD-1-00486	2024-03-21	1	2	3	1	Online	13	199.00	15.00	2198.95	650.00	1548.95	John Smith	INV-1-00486	Paid	2025-12-13 07:11:45.467881
487	1	ORD-1-00487	2023-04-08	12	5	4	1	Online	6	1500.00	10.00	8100.00	2400.00	5700.00	David Brown	INV-1-00487	Overdue	2025-12-13 07:11:45.467881
488	1	ORD-1-00488	2024-04-23	8	7	2	1	Online	3	4500.00	5.00	12825.00	4500.00	8325.00	Jane Doe	INV-1-00488	Pending	2025-12-13 07:11:45.467881
489	1	ORD-1-00489	2023-01-11	4	10	1	1	Direct Sales	6	350.00	0.00	2100.00	720.00	1380.00	Sarah Wilson	INV-1-00489	Paid	2025-12-13 07:11:45.467881
490	1	ORD-1-00490	2023-11-12	14	6	2	1	Online	4	2000.00	20.00	6400.00	2400.00	4000.00	David Brown	INV-1-00490	Overdue	2025-12-13 07:11:45.467881
491	1	ORD-1-00491	2023-07-01	12	8	3	1	Direct Sales	16	500.00	5.00	7600.00	2400.00	5200.00	Jane Doe	INV-1-00491	Overdue	2025-12-13 07:11:45.467881
492	1	ORD-1-00492	2023-12-06	3	10	5	1	Reseller	14	350.00	5.00	4655.00	1680.00	2975.00	Robert Taylor	INV-1-00492	Paid	2025-12-13 07:11:45.467881
493	1	ORD-1-00493	2023-12-06	9	10	4	1	Online	4	350.00	15.00	1190.00	480.00	710.00	Mike Johnson	INV-1-00493	Pending	2025-12-13 07:11:45.467881
494	1	ORD-1-00494	2024-09-09	13	5	4	1	Direct Sales	17	1500.00	20.00	20400.00	6800.00	13600.00	John Smith	INV-1-00494	Paid	2025-12-13 07:11:45.467881
495	1	ORD-1-00495	2024-05-27	2	9	2	1	Online	9	800.00	15.00	6120.00	1800.00	4320.00	Sarah Wilson	INV-1-00495	Paid	2025-12-13 07:11:45.467881
496	1	ORD-1-00496	2024-05-30	8	4	3	1	Direct Sales	14	3500.00	10.00	44100.00	16800.00	27300.00	David Brown	INV-1-00496	Overdue	2025-12-13 07:11:45.467881
497	1	ORD-1-00497	2023-12-16	8	6	3	1	Partner	15	2000.00	5.00	28500.00	9000.00	19500.00	Lisa Anderson	INV-1-00497	Paid	2025-12-13 07:11:45.467881
498	1	ORD-1-00498	2024-09-05	14	10	4	1	Reseller	2	350.00	10.00	630.00	240.00	390.00	John Smith	INV-1-00498	Paid	2025-12-13 07:11:45.467881
499	1	ORD-1-00499	2023-07-29	12	1	1	1	Online	6	5000.00	20.00	24000.00	9000.00	15000.00	Robert Taylor	INV-1-00499	Paid	2025-12-13 07:11:45.467881
500	1	ORD-1-00500	2024-03-01	2	7	2	1	Online	9	4500.00	15.00	34425.00	13500.00	20925.00	Amanda White	INV-1-00500	Paid	2025-12-13 07:11:45.467881
501	1	ORD-1-00501	2024-09-10	5	4	2	1	Direct Sales	8	3500.00	20.00	22400.00	9600.00	12800.00	Jane Doe	INV-1-00501	Pending	2025-12-13 07:11:45.467881
502	1	ORD-1-00502	2024-02-14	15	7	2	1	Reseller	19	4500.00	10.00	76950.00	28500.00	48450.00	Jane Doe	INV-1-00502	Pending	2025-12-13 07:11:45.467881
503	1	ORD-1-00503	2024-07-07	6	9	5	1	Partner	2	800.00	10.00	1440.00	400.00	1040.00	Mike Johnson	INV-1-00503	Paid	2025-12-13 07:11:45.467881
504	1	ORD-1-00504	2023-09-17	10	6	4	1	Reseller	19	2000.00	5.00	36100.00	11400.00	24700.00	Mike Johnson	INV-1-00504	Paid	2025-12-13 07:11:45.467881
505	1	ORD-1-00505	2023-08-07	7	7	2	1	Online	8	4500.00	20.00	28800.00	12000.00	16800.00	Chris Lee	INV-1-00505	Pending	2025-12-13 07:11:45.467881
506	1	ORD-1-00506	2023-07-09	10	10	2	1	Retail	6	350.00	5.00	1995.00	720.00	1275.00	Mike Johnson	INV-1-00506	Paid	2025-12-13 07:11:45.467881
507	1	ORD-1-00507	2023-01-09	5	4	4	1	Retail	15	3500.00	20.00	42000.00	18000.00	24000.00	Mike Johnson	INV-1-00507	Paid	2025-12-13 07:11:45.467881
508	1	ORD-1-00508	2024-08-12	11	1	5	1	Partner	18	5000.00	15.00	76500.00	27000.00	49500.00	David Brown	INV-1-00508	Paid	2025-12-13 07:11:45.467881
509	1	ORD-1-00509	2023-08-28	15	8	3	1	Retail	5	500.00	10.00	2250.00	750.00	1500.00	John Smith	INV-1-00509	Paid	2025-12-13 07:11:45.467881
510	1	ORD-1-00510	2023-10-29	7	8	4	1	Reseller	20	500.00	20.00	8000.00	3000.00	5000.00	John Smith	INV-1-00510	Paid	2025-12-13 07:11:45.467881
511	1	ORD-1-00511	2023-09-21	14	5	4	1	Direct Sales	3	1500.00	0.00	4500.00	1200.00	3300.00	Mike Johnson	INV-1-00511	Paid	2025-12-13 07:11:45.467881
512	1	ORD-1-00512	2024-07-01	1	9	2	1	Online	9	800.00	10.00	6480.00	1800.00	4680.00	Sarah Wilson	INV-1-00512	Paid	2025-12-13 07:11:45.467881
513	1	ORD-1-00513	2024-03-01	8	7	1	1	Retail	18	4500.00	10.00	72900.00	27000.00	45900.00	Jane Doe	INV-1-00513	Paid	2025-12-13 07:11:45.467881
514	1	ORD-1-00514	2023-11-06	10	2	5	1	Reseller	12	199.00	20.00	1910.40	600.00	1310.40	David Brown	INV-1-00514	Overdue	2025-12-13 07:11:45.467881
515	1	ORD-1-00515	2023-09-05	9	6	2	1	Reseller	17	2000.00	20.00	27200.00	10200.00	17000.00	Amanda White	INV-1-00515	Overdue	2025-12-13 07:11:45.467881
516	1	ORD-1-00516	2023-04-15	10	7	3	1	Online	15	4500.00	15.00	57375.00	22500.00	34875.00	Amanda White	INV-1-00516	Pending	2025-12-13 07:11:45.467881
517	1	ORD-1-00517	2023-02-24	8	8	2	1	Direct Sales	14	500.00	10.00	6300.00	2100.00	4200.00	David Brown	INV-1-00517	Pending	2025-12-13 07:11:45.467881
518	1	ORD-1-00518	2023-11-09	7	10	4	1	Partner	1	350.00	20.00	280.00	120.00	160.00	Sarah Wilson	INV-1-00518	Pending	2025-12-13 07:11:45.467881
519	1	ORD-1-00519	2023-05-23	9	6	1	1	Direct Sales	4	2000.00	5.00	7600.00	2400.00	5200.00	John Smith	INV-1-00519	Paid	2025-12-13 07:11:45.467881
520	1	ORD-1-00520	2024-09-11	12	1	4	1	Retail	15	5000.00	15.00	63750.00	22500.00	41250.00	Amanda White	INV-1-00520	Pending	2025-12-13 07:11:45.467881
521	1	ORD-1-00521	2024-08-22	6	10	5	1	Online	5	350.00	10.00	1575.00	600.00	975.00	David Brown	INV-1-00521	Paid	2025-12-13 07:11:45.467881
522	1	ORD-1-00522	2024-10-04	8	8	4	1	Online	13	500.00	5.00	6175.00	1950.00	4225.00	Sarah Wilson	INV-1-00522	Pending	2025-12-13 07:11:45.467881
523	1	ORD-1-00523	2024-11-21	9	6	5	1	Partner	9	2000.00	15.00	15300.00	5400.00	9900.00	John Smith	INV-1-00523	Paid	2025-12-13 07:11:45.467881
524	1	ORD-1-00524	2023-10-19	13	4	4	1	Partner	6	3500.00	5.00	19950.00	7200.00	12750.00	Sarah Wilson	INV-1-00524	Paid	2025-12-13 07:11:45.467881
525	1	ORD-1-00525	2023-08-14	14	4	3	1	Partner	20	3500.00	20.00	56000.00	24000.00	32000.00	Mike Johnson	INV-1-00525	Paid	2025-12-13 07:11:45.467881
526	1	ORD-1-00526	2024-09-28	7	10	4	1	Reseller	13	350.00	15.00	3867.50	1560.00	2307.50	Amanda White	INV-1-00526	Paid	2025-12-13 07:11:45.467881
527	1	ORD-1-00527	2024-09-11	11	10	1	1	Online	9	350.00	10.00	2835.00	1080.00	1755.00	Robert Taylor	INV-1-00527	Overdue	2025-12-13 07:11:45.467881
528	1	ORD-1-00528	2023-03-28	3	1	5	1	Reseller	4	5000.00	15.00	17000.00	6000.00	11000.00	Jane Doe	INV-1-00528	Paid	2025-12-13 07:11:45.467881
529	1	ORD-1-00529	2023-02-10	1	4	2	1	Online	5	3500.00	15.00	14875.00	6000.00	8875.00	David Brown	INV-1-00529	Overdue	2025-12-13 07:11:45.467881
530	1	ORD-1-00530	2024-04-05	9	10	1	1	Online	14	350.00	20.00	3920.00	1680.00	2240.00	John Smith	INV-1-00530	Overdue	2025-12-13 07:11:45.467881
531	1	ORD-1-00531	2024-03-30	7	9	3	1	Online	20	800.00	10.00	14400.00	4000.00	10400.00	Mike Johnson	INV-1-00531	Paid	2025-12-13 07:11:45.467881
532	1	ORD-1-00532	2023-10-18	8	4	2	1	Retail	9	3500.00	0.00	31500.00	10800.00	20700.00	Mike Johnson	INV-1-00532	Paid	2025-12-13 07:11:45.467881
533	1	ORD-1-00533	2024-05-18	15	1	5	1	Online	12	5000.00	0.00	60000.00	18000.00	42000.00	Mike Johnson	INV-1-00533	Pending	2025-12-13 07:11:45.467881
534	1	ORD-1-00534	2023-03-12	13	9	1	1	Partner	18	800.00	20.00	11520.00	3600.00	7920.00	David Brown	INV-1-00534	Paid	2025-12-13 07:11:45.467881
535	1	ORD-1-00535	2023-04-24	8	5	5	1	Reseller	8	1500.00	5.00	11400.00	3200.00	8200.00	John Smith	INV-1-00535	Overdue	2025-12-13 07:11:45.467881
536	1	ORD-1-00536	2023-09-06	6	9	4	1	Direct Sales	7	800.00	10.00	5040.00	1400.00	3640.00	Amanda White	INV-1-00536	Paid	2025-12-13 07:11:45.467881
537	1	ORD-1-00537	2023-10-05	13	2	3	1	Online	13	199.00	20.00	2069.60	650.00	1419.60	Lisa Anderson	INV-1-00537	Overdue	2025-12-13 07:11:45.467881
538	1	ORD-1-00538	2023-06-18	10	8	5	1	Reseller	9	500.00	20.00	3600.00	1350.00	2250.00	Chris Lee	INV-1-00538	Overdue	2025-12-13 07:11:45.467881
539	1	ORD-1-00539	2024-06-02	5	6	1	1	Direct Sales	15	2000.00	0.00	30000.00	9000.00	21000.00	Emily Davis	INV-1-00539	Paid	2025-12-13 07:11:45.467881
540	1	ORD-1-00540	2023-03-07	9	10	5	1	Reseller	14	350.00	10.00	4410.00	1680.00	2730.00	Lisa Anderson	INV-1-00540	Overdue	2025-12-13 07:11:45.467881
541	1	ORD-1-00541	2024-07-23	11	1	5	1	Reseller	15	5000.00	0.00	75000.00	22500.00	52500.00	Jane Doe	INV-1-00541	Overdue	2025-12-13 07:11:45.467881
542	1	ORD-1-00542	2023-09-07	12	1	1	1	Reseller	16	5000.00	5.00	76000.00	24000.00	52000.00	Amanda White	INV-1-00542	Paid	2025-12-13 07:11:45.467881
543	1	ORD-1-00543	2023-11-17	5	8	5	1	Retail	8	500.00	5.00	3800.00	1200.00	2600.00	Robert Taylor	INV-1-00543	Overdue	2025-12-13 07:11:45.467881
544	1	ORD-1-00544	2023-11-11	6	7	2	1	Online	12	4500.00	20.00	43200.00	18000.00	25200.00	Mike Johnson	INV-1-00544	Paid	2025-12-13 07:11:45.467881
545	1	ORD-1-00545	2023-05-30	6	8	4	1	Reseller	8	500.00	10.00	3600.00	1200.00	2400.00	John Smith	INV-1-00545	Paid	2025-12-13 07:11:45.467881
546	1	ORD-1-00546	2023-11-19	5	5	1	1	Retail	4	1500.00	15.00	5100.00	1600.00	3500.00	Sarah Wilson	INV-1-00546	Paid	2025-12-13 07:11:45.467881
547	1	ORD-1-00547	2024-12-08	5	7	4	1	Online	2	4500.00	5.00	8550.00	3000.00	5550.00	Chris Lee	INV-1-00547	Paid	2025-12-13 07:11:45.467881
548	1	ORD-1-00548	2023-04-05	1	8	2	1	Online	20	500.00	5.00	9500.00	3000.00	6500.00	Jane Doe	INV-1-00548	Overdue	2025-12-13 07:11:45.467881
549	1	ORD-1-00549	2024-05-06	14	8	3	1	Retail	16	500.00	5.00	7600.00	2400.00	5200.00	Emily Davis	INV-1-00549	Paid	2025-12-13 07:11:45.467881
550	1	ORD-1-00550	2023-04-23	3	4	2	1	Partner	17	3500.00	10.00	53550.00	20400.00	33150.00	Amanda White	INV-1-00550	Paid	2025-12-13 07:11:45.467881
551	1	ORD-1-00551	2024-06-06	6	7	2	1	Partner	19	4500.00	0.00	85500.00	28500.00	57000.00	Mike Johnson	INV-1-00551	Paid	2025-12-13 07:11:45.467881
552	1	ORD-1-00552	2023-03-01	2	3	4	1	Direct Sales	11	2500.00	0.00	27500.00	8800.00	18700.00	Mike Johnson	INV-1-00552	Paid	2025-12-13 07:11:45.467881
553	1	ORD-1-00553	2023-10-04	13	5	5	1	Online	19	1500.00	0.00	28500.00	7600.00	20900.00	David Brown	INV-1-00553	Pending	2025-12-13 07:11:45.467881
554	1	ORD-1-00554	2023-01-25	10	6	2	1	Direct Sales	11	2000.00	10.00	19800.00	6600.00	13200.00	Sarah Wilson	INV-1-00554	Paid	2025-12-13 07:11:45.467881
555	1	ORD-1-00555	2023-01-21	7	1	5	1	Reseller	6	5000.00	5.00	28500.00	9000.00	19500.00	Robert Taylor	INV-1-00555	Paid	2025-12-13 07:11:45.467881
556	1	ORD-1-00556	2024-02-17	1	5	1	1	Online	19	1500.00	20.00	22800.00	7600.00	15200.00	John Smith	INV-1-00556	Pending	2025-12-13 07:11:45.467881
557	1	ORD-1-00557	2023-02-08	6	1	2	1	Online	16	5000.00	10.00	72000.00	24000.00	48000.00	Sarah Wilson	INV-1-00557	Paid	2025-12-13 07:11:45.467881
558	1	ORD-1-00558	2024-12-04	5	10	4	1	Retail	7	350.00	5.00	2327.50	840.00	1487.50	Jane Doe	INV-1-00558	Pending	2025-12-13 07:11:45.467881
559	1	ORD-1-00559	2024-04-21	13	8	1	1	Online	12	500.00	20.00	4800.00	1800.00	3000.00	Mike Johnson	INV-1-00559	Pending	2025-12-13 07:11:45.467881
560	1	ORD-1-00560	2023-11-23	5	9	5	1	Online	8	800.00	15.00	5440.00	1600.00	3840.00	David Brown	INV-1-00560	Pending	2025-12-13 07:11:45.467881
561	1	ORD-1-00561	2023-10-15	4	1	2	1	Online	12	5000.00	10.00	54000.00	18000.00	36000.00	Lisa Anderson	INV-1-00561	Paid	2025-12-13 07:11:45.467881
562	1	ORD-1-00562	2023-01-03	11	1	3	1	Partner	14	5000.00	5.00	66500.00	21000.00	45500.00	Mike Johnson	INV-1-00562	Paid	2025-12-13 07:11:45.467881
563	1	ORD-1-00563	2024-12-17	12	7	1	1	Direct Sales	17	4500.00	5.00	72675.00	25500.00	47175.00	Chris Lee	INV-1-00563	Pending	2025-12-13 07:11:45.467881
564	1	ORD-1-00564	2024-01-01	8	4	4	1	Retail	18	3500.00	0.00	63000.00	21600.00	41400.00	Mike Johnson	INV-1-00564	Paid	2025-12-13 07:11:45.467881
565	1	ORD-1-00565	2023-05-10	5	2	4	1	Partner	4	199.00	5.00	756.20	200.00	556.20	Amanda White	INV-1-00565	Paid	2025-12-13 07:11:45.467881
566	1	ORD-1-00566	2023-11-08	3	10	3	1	Reseller	7	350.00	0.00	2450.00	840.00	1610.00	Robert Taylor	INV-1-00566	Paid	2025-12-13 07:11:45.467881
567	1	ORD-1-00567	2024-08-16	3	4	2	1	Direct Sales	12	3500.00	5.00	39900.00	14400.00	25500.00	Lisa Anderson	INV-1-00567	Paid	2025-12-13 07:11:45.467881
568	1	ORD-1-00568	2023-06-12	10	4	1	1	Direct Sales	13	3500.00	10.00	40950.00	15600.00	25350.00	David Brown	INV-1-00568	Paid	2025-12-13 07:11:45.467881
569	1	ORD-1-00569	2023-02-06	8	2	2	1	Direct Sales	15	199.00	20.00	2388.00	750.00	1638.00	Mike Johnson	INV-1-00569	Overdue	2025-12-13 07:11:45.467881
570	1	ORD-1-00570	2023-06-25	5	4	1	1	Online	17	3500.00	20.00	47600.00	20400.00	27200.00	Robert Taylor	INV-1-00570	Paid	2025-12-13 07:11:45.467881
571	1	ORD-1-00571	2023-10-03	9	4	5	1	Reseller	14	3500.00	20.00	39200.00	16800.00	22400.00	Mike Johnson	INV-1-00571	Paid	2025-12-13 07:11:45.467881
572	1	ORD-1-00572	2023-05-14	14	10	1	1	Partner	4	350.00	0.00	1400.00	480.00	920.00	Chris Lee	INV-1-00572	Overdue	2025-12-13 07:11:45.467881
573	1	ORD-1-00573	2023-03-22	14	4	2	1	Retail	13	3500.00	5.00	43225.00	15600.00	27625.00	Sarah Wilson	INV-1-00573	Overdue	2025-12-13 07:11:45.467881
574	1	ORD-1-00574	2024-03-30	3	2	3	1	Partner	9	199.00	10.00	1611.90	450.00	1161.90	Emily Davis	INV-1-00574	Paid	2025-12-13 07:11:45.467881
575	1	ORD-1-00575	2023-04-04	3	8	3	1	Direct Sales	16	500.00	15.00	6800.00	2400.00	4400.00	Mike Johnson	INV-1-00575	Overdue	2025-12-13 07:11:45.467881
576	1	ORD-1-00576	2024-03-18	7	7	4	1	Online	17	4500.00	5.00	72675.00	25500.00	47175.00	Chris Lee	INV-1-00576	Pending	2025-12-13 07:11:45.467881
577	1	ORD-1-00577	2024-05-31	12	9	5	1	Partner	6	800.00	5.00	4560.00	1200.00	3360.00	Mike Johnson	INV-1-00577	Overdue	2025-12-13 07:11:45.467881
578	1	ORD-1-00578	2024-07-13	4	5	1	1	Reseller	4	1500.00	5.00	5700.00	1600.00	4100.00	David Brown	INV-1-00578	Paid	2025-12-13 07:11:45.467881
579	1	ORD-1-00579	2023-01-09	3	4	1	1	Reseller	20	3500.00	20.00	56000.00	24000.00	32000.00	Emily Davis	INV-1-00579	Overdue	2025-12-13 07:11:45.467881
580	1	ORD-1-00580	2024-07-29	15	5	2	1	Online	6	1500.00	5.00	8550.00	2400.00	6150.00	Jane Doe	INV-1-00580	Overdue	2025-12-13 07:11:45.467881
581	1	ORD-1-00581	2023-06-14	14	2	4	1	Online	15	199.00	0.00	2985.00	750.00	2235.00	Emily Davis	INV-1-00581	Pending	2025-12-13 07:11:45.467881
582	1	ORD-1-00582	2023-04-28	5	6	3	1	Direct Sales	10	2000.00	20.00	16000.00	6000.00	10000.00	Chris Lee	INV-1-00582	Paid	2025-12-13 07:11:45.467881
583	1	ORD-1-00583	2024-10-18	2	2	1	1	Online	19	199.00	10.00	3402.90	950.00	2452.90	John Smith	INV-1-00583	Paid	2025-12-13 07:11:45.467881
584	1	ORD-1-00584	2023-01-22	6	1	1	1	Retail	2	5000.00	5.00	9500.00	3000.00	6500.00	Robert Taylor	INV-1-00584	Overdue	2025-12-13 07:11:45.467881
585	1	ORD-1-00585	2024-10-18	1	9	4	1	Online	5	800.00	5.00	3800.00	1000.00	2800.00	Mike Johnson	INV-1-00585	Paid	2025-12-13 07:11:45.467881
586	1	ORD-1-00586	2023-01-01	5	3	1	1	Online	20	2500.00	5.00	47500.00	16000.00	31500.00	John Smith	INV-1-00586	Paid	2025-12-13 07:11:45.467881
587	1	ORD-1-00587	2024-04-20	11	1	4	1	Partner	6	5000.00	20.00	24000.00	9000.00	15000.00	Lisa Anderson	INV-1-00587	Paid	2025-12-13 07:11:45.467881
588	1	ORD-1-00588	2023-05-23	6	5	4	1	Online	18	1500.00	15.00	22950.00	7200.00	15750.00	Robert Taylor	INV-1-00588	Paid	2025-12-13 07:11:45.467881
589	1	ORD-1-00589	2024-06-30	1	1	4	1	Online	9	5000.00	5.00	42750.00	13500.00	29250.00	Chris Lee	INV-1-00589	Paid	2025-12-13 07:11:45.467881
590	1	ORD-1-00590	2024-08-19	14	2	1	1	Online	3	199.00	10.00	537.30	150.00	387.30	Chris Lee	INV-1-00590	Paid	2025-12-13 07:11:45.467881
591	1	ORD-1-00591	2024-12-16	11	1	4	1	Retail	14	5000.00	15.00	59500.00	21000.00	38500.00	Emily Davis	INV-1-00591	Overdue	2025-12-13 07:11:45.467881
592	1	ORD-1-00592	2023-03-29	3	2	5	1	Retail	15	199.00	5.00	2835.75	750.00	2085.75	Robert Taylor	INV-1-00592	Paid	2025-12-13 07:11:45.467881
593	1	ORD-1-00593	2023-10-03	13	3	1	1	Retail	17	2500.00	10.00	38250.00	13600.00	24650.00	Sarah Wilson	INV-1-00593	Pending	2025-12-13 07:11:45.467881
594	1	ORD-1-00594	2023-06-07	2	4	4	1	Online	10	3500.00	20.00	28000.00	12000.00	16000.00	Jane Doe	INV-1-00594	Overdue	2025-12-13 07:11:45.467881
595	1	ORD-1-00595	2023-11-17	2	10	5	1	Reseller	6	350.00	15.00	1785.00	720.00	1065.00	Chris Lee	INV-1-00595	Paid	2025-12-13 07:11:45.467881
596	1	ORD-1-00596	2023-05-29	2	3	4	1	Reseller	17	2500.00	0.00	42500.00	13600.00	28900.00	Amanda White	INV-1-00596	Pending	2025-12-13 07:11:45.467881
597	1	ORD-1-00597	2023-03-08	12	7	3	1	Reseller	2	4500.00	20.00	7200.00	3000.00	4200.00	Mike Johnson	INV-1-00597	Pending	2025-12-13 07:11:45.467881
598	1	ORD-1-00598	2023-05-16	3	9	2	1	Reseller	13	800.00	5.00	9880.00	2600.00	7280.00	Robert Taylor	INV-1-00598	Pending	2025-12-13 07:11:45.467881
599	1	ORD-1-00599	2023-09-16	14	6	4	1	Direct Sales	2	2000.00	20.00	3200.00	1200.00	2000.00	Lisa Anderson	INV-1-00599	Pending	2025-12-13 07:11:45.467881
600	1	ORD-1-00600	2023-10-18	12	9	5	1	Partner	18	800.00	10.00	12960.00	3600.00	9360.00	Jane Doe	INV-1-00600	Paid	2025-12-13 07:11:45.467881
601	2	ORD-2-00001	2023-02-26	3	5	2	1	Reseller	4	1500.00	15.00	5100.00	1600.00	3500.00	Mike Johnson	INV-2-00001	Pending	2025-12-13 07:11:45.467881
602	2	ORD-2-00002	2024-05-06	9	1	5	1	Retail	12	5000.00	10.00	54000.00	18000.00	36000.00	John Smith	INV-2-00002	Paid	2025-12-13 07:11:45.467881
603	2	ORD-2-00003	2023-08-22	3	7	4	1	Online	1	4500.00	15.00	3825.00	1500.00	2325.00	Amanda White	INV-2-00003	Paid	2025-12-13 07:11:45.467881
604	2	ORD-2-00004	2023-08-22	6	7	4	1	Retail	9	4500.00	0.00	40500.00	13500.00	27000.00	Lisa Anderson	INV-2-00004	Pending	2025-12-13 07:11:45.467881
605	2	ORD-2-00005	2023-07-21	14	4	4	1	Retail	16	3500.00	10.00	50400.00	19200.00	31200.00	Robert Taylor	INV-2-00005	Pending	2025-12-13 07:11:45.467881
606	2	ORD-2-00006	2024-07-20	7	10	1	1	Retail	15	350.00	5.00	4987.50	1800.00	3187.50	Lisa Anderson	INV-2-00006	Pending	2025-12-13 07:11:45.467881
607	2	ORD-2-00007	2024-10-28	10	10	1	1	Partner	7	350.00	10.00	2205.00	840.00	1365.00	Amanda White	INV-2-00007	Overdue	2025-12-13 07:11:45.467881
608	2	ORD-2-00008	2024-08-20	14	1	3	1	Partner	11	5000.00	5.00	52250.00	16500.00	35750.00	Lisa Anderson	INV-2-00008	Paid	2025-12-13 07:11:45.467881
609	2	ORD-2-00009	2024-12-15	7	10	4	1	Direct Sales	10	350.00	5.00	3325.00	1200.00	2125.00	Mike Johnson	INV-2-00009	Pending	2025-12-13 07:11:45.467881
610	2	ORD-2-00010	2024-07-10	11	3	1	1	Partner	10	2500.00	15.00	21250.00	8000.00	13250.00	John Smith	INV-2-00010	Overdue	2025-12-13 07:11:45.467881
611	2	ORD-2-00011	2024-03-05	11	9	3	1	Reseller	3	800.00	20.00	1920.00	600.00	1320.00	Sarah Wilson	INV-2-00011	Pending	2025-12-13 07:11:45.467881
612	2	ORD-2-00012	2023-01-10	2	8	1	1	Reseller	14	500.00	0.00	7000.00	2100.00	4900.00	Jane Doe	INV-2-00012	Overdue	2025-12-13 07:11:45.467881
613	2	ORD-2-00013	2023-11-20	14	5	4	1	Reseller	3	1500.00	15.00	3825.00	1200.00	2625.00	David Brown	INV-2-00013	Pending	2025-12-13 07:11:45.467881
614	2	ORD-2-00014	2024-06-03	2	1	2	1	Retail	16	5000.00	20.00	64000.00	24000.00	40000.00	Robert Taylor	INV-2-00014	Paid	2025-12-13 07:11:45.467881
615	2	ORD-2-00015	2023-04-21	13	7	3	1	Retail	9	4500.00	5.00	38475.00	13500.00	24975.00	David Brown	INV-2-00015	Pending	2025-12-13 07:11:45.467881
616	2	ORD-2-00016	2024-09-05	15	7	3	1	Online	4	4500.00	15.00	15300.00	6000.00	9300.00	Mike Johnson	INV-2-00016	Overdue	2025-12-13 07:11:45.467881
617	2	ORD-2-00017	2023-04-19	11	10	2	1	Online	15	350.00	10.00	4725.00	1800.00	2925.00	Chris Lee	INV-2-00017	Overdue	2025-12-13 07:11:45.467881
618	2	ORD-2-00018	2024-10-16	10	8	5	1	Online	15	500.00	5.00	7125.00	2250.00	4875.00	Mike Johnson	INV-2-00018	Paid	2025-12-13 07:11:45.467881
619	2	ORD-2-00019	2023-12-03	4	7	1	1	Direct Sales	3	4500.00	15.00	11475.00	4500.00	6975.00	John Smith	INV-2-00019	Paid	2025-12-13 07:11:45.467881
620	2	ORD-2-00020	2024-12-22	10	5	5	1	Direct Sales	12	1500.00	10.00	16200.00	4800.00	11400.00	Emily Davis	INV-2-00020	Overdue	2025-12-13 07:11:45.467881
621	2	ORD-2-00021	2023-01-26	6	3	1	1	Reseller	14	2500.00	15.00	29750.00	11200.00	18550.00	Sarah Wilson	INV-2-00021	Paid	2025-12-13 07:11:45.467881
622	2	ORD-2-00022	2023-10-28	10	6	4	1	Reseller	12	2000.00	20.00	19200.00	7200.00	12000.00	Chris Lee	INV-2-00022	Paid	2025-12-13 07:11:45.467881
623	2	ORD-2-00023	2024-08-06	14	8	2	1	Partner	7	500.00	5.00	3325.00	1050.00	2275.00	David Brown	INV-2-00023	Overdue	2025-12-13 07:11:45.467881
624	2	ORD-2-00024	2023-06-15	6	8	5	1	Reseller	8	500.00	20.00	3200.00	1200.00	2000.00	Lisa Anderson	INV-2-00024	Overdue	2025-12-13 07:11:45.467881
625	2	ORD-2-00025	2023-12-02	4	6	3	1	Direct Sales	5	2000.00	5.00	9500.00	3000.00	6500.00	John Smith	INV-2-00025	Overdue	2025-12-13 07:11:45.467881
626	2	ORD-2-00026	2023-12-03	8	4	2	1	Direct Sales	16	3500.00	20.00	44800.00	19200.00	25600.00	Amanda White	INV-2-00026	Pending	2025-12-13 07:11:45.467881
627	2	ORD-2-00027	2023-11-13	9	2	4	1	Online	1	199.00	5.00	189.05	50.00	139.05	Jane Doe	INV-2-00027	Paid	2025-12-13 07:11:45.467881
628	2	ORD-2-00028	2024-02-01	3	5	4	1	Online	16	1500.00	0.00	24000.00	6400.00	17600.00	Chris Lee	INV-2-00028	Paid	2025-12-13 07:11:45.467881
629	2	ORD-2-00029	2024-04-11	5	3	5	1	Partner	9	2500.00	10.00	20250.00	7200.00	13050.00	Robert Taylor	INV-2-00029	Paid	2025-12-13 07:11:45.467881
630	2	ORD-2-00030	2024-10-13	4	10	2	1	Direct Sales	1	350.00	20.00	280.00	120.00	160.00	Mike Johnson	INV-2-00030	Pending	2025-12-13 07:11:45.467881
631	2	ORD-2-00031	2023-03-18	2	2	1	1	Reseller	1	199.00	20.00	159.20	50.00	109.20	Chris Lee	INV-2-00031	Paid	2025-12-13 07:11:45.467881
632	2	ORD-2-00032	2023-09-18	12	6	1	1	Reseller	3	2000.00	0.00	6000.00	1800.00	4200.00	Mike Johnson	INV-2-00032	Overdue	2025-12-13 07:11:45.467881
633	2	ORD-2-00033	2024-09-22	9	2	2	1	Reseller	14	199.00	0.00	2786.00	700.00	2086.00	Lisa Anderson	INV-2-00033	Paid	2025-12-13 07:11:45.467881
634	2	ORD-2-00034	2023-03-25	1	3	5	1	Online	13	2500.00	20.00	26000.00	10400.00	15600.00	Sarah Wilson	INV-2-00034	Paid	2025-12-13 07:11:45.467881
635	2	ORD-2-00035	2024-08-27	11	4	2	1	Reseller	11	3500.00	20.00	30800.00	13200.00	17600.00	Lisa Anderson	INV-2-00035	Paid	2025-12-13 07:11:45.467881
636	2	ORD-2-00036	2023-02-17	1	8	3	1	Reseller	1	500.00	5.00	475.00	150.00	325.00	Jane Doe	INV-2-00036	Paid	2025-12-13 07:11:45.467881
637	2	ORD-2-00037	2023-12-14	11	3	4	1	Partner	12	2500.00	20.00	24000.00	9600.00	14400.00	Jane Doe	INV-2-00037	Paid	2025-12-13 07:11:45.467881
638	2	ORD-2-00038	2023-06-18	9	6	1	1	Partner	6	2000.00	10.00	10800.00	3600.00	7200.00	Lisa Anderson	INV-2-00038	Pending	2025-12-13 07:11:45.467881
639	2	ORD-2-00039	2023-02-20	15	8	2	1	Reseller	19	500.00	15.00	8075.00	2850.00	5225.00	John Smith	INV-2-00039	Overdue	2025-12-13 07:11:45.467881
640	2	ORD-2-00040	2024-11-25	12	10	4	1	Partner	13	350.00	10.00	4095.00	1560.00	2535.00	Jane Doe	INV-2-00040	Paid	2025-12-13 07:11:45.467881
641	2	ORD-2-00041	2024-07-08	10	5	4	1	Direct Sales	14	1500.00	15.00	17850.00	5600.00	12250.00	Mike Johnson	INV-2-00041	Paid	2025-12-13 07:11:45.467881
642	2	ORD-2-00042	2023-03-22	13	9	1	1	Direct Sales	4	800.00	15.00	2720.00	800.00	1920.00	Sarah Wilson	INV-2-00042	Paid	2025-12-13 07:11:45.467881
643	2	ORD-2-00043	2024-07-20	8	7	3	1	Direct Sales	5	4500.00	0.00	22500.00	7500.00	15000.00	Jane Doe	INV-2-00043	Paid	2025-12-13 07:11:45.467881
644	2	ORD-2-00044	2024-03-23	12	2	2	1	Reseller	16	199.00	15.00	2706.40	800.00	1906.40	Chris Lee	INV-2-00044	Paid	2025-12-13 07:11:45.467881
645	2	ORD-2-00045	2024-04-17	6	1	5	1	Partner	4	5000.00	20.00	16000.00	6000.00	10000.00	Jane Doe	INV-2-00045	Paid	2025-12-13 07:11:45.467881
646	2	ORD-2-00046	2023-05-06	4	5	1	1	Reseller	4	1500.00	15.00	5100.00	1600.00	3500.00	Sarah Wilson	INV-2-00046	Paid	2025-12-13 07:11:45.467881
647	2	ORD-2-00047	2024-10-20	1	3	1	1	Retail	17	2500.00	20.00	34000.00	13600.00	20400.00	Mike Johnson	INV-2-00047	Paid	2025-12-13 07:11:45.467881
648	2	ORD-2-00048	2023-10-06	9	5	2	1	Reseller	19	1500.00	15.00	24225.00	7600.00	16625.00	David Brown	INV-2-00048	Overdue	2025-12-13 07:11:45.467881
649	2	ORD-2-00049	2023-01-21	8	9	5	1	Online	11	800.00	20.00	7040.00	2200.00	4840.00	John Smith	INV-2-00049	Overdue	2025-12-13 07:11:45.467881
650	2	ORD-2-00050	2024-03-07	12	4	3	1	Retail	9	3500.00	20.00	25200.00	10800.00	14400.00	Amanda White	INV-2-00050	Paid	2025-12-13 07:11:45.467881
651	2	ORD-2-00051	2024-03-03	6	6	3	1	Partner	15	2000.00	20.00	24000.00	9000.00	15000.00	David Brown	INV-2-00051	Paid	2025-12-13 07:11:45.467881
652	2	ORD-2-00052	2023-02-21	8	4	1	1	Retail	14	3500.00	15.00	41650.00	16800.00	24850.00	Emily Davis	INV-2-00052	Pending	2025-12-13 07:11:45.467881
653	2	ORD-2-00053	2023-03-25	4	4	5	1	Online	1	3500.00	0.00	3500.00	1200.00	2300.00	Emily Davis	INV-2-00053	Paid	2025-12-13 07:11:45.467881
654	2	ORD-2-00054	2023-08-11	2	2	1	1	Retail	13	199.00	5.00	2457.65	650.00	1807.65	John Smith	INV-2-00054	Paid	2025-12-13 07:11:45.467881
655	2	ORD-2-00055	2023-09-06	12	10	2	1	Online	18	350.00	10.00	5670.00	2160.00	3510.00	Robert Taylor	INV-2-00055	Paid	2025-12-13 07:11:45.467881
656	2	ORD-2-00056	2023-09-13	15	2	1	1	Reseller	10	199.00	10.00	1791.00	500.00	1291.00	Lisa Anderson	INV-2-00056	Paid	2025-12-13 07:11:45.467881
657	2	ORD-2-00057	2023-08-23	5	6	1	1	Retail	11	2000.00	10.00	19800.00	6600.00	13200.00	David Brown	INV-2-00057	Paid	2025-12-13 07:11:45.467881
658	2	ORD-2-00058	2023-11-05	5	2	2	1	Online	1	199.00	10.00	179.10	50.00	129.10	Lisa Anderson	INV-2-00058	Paid	2025-12-13 07:11:45.467881
659	2	ORD-2-00059	2023-09-14	7	1	4	1	Direct Sales	10	5000.00	20.00	40000.00	15000.00	25000.00	Mike Johnson	INV-2-00059	Paid	2025-12-13 07:11:45.467881
660	2	ORD-2-00060	2023-06-28	12	2	5	1	Partner	18	199.00	5.00	3402.90	900.00	2502.90	Emily Davis	INV-2-00060	Paid	2025-12-13 07:11:45.467881
661	2	ORD-2-00061	2024-11-20	4	9	3	1	Partner	2	800.00	20.00	1280.00	400.00	880.00	Mike Johnson	INV-2-00061	Paid	2025-12-13 07:11:45.467881
662	2	ORD-2-00062	2023-03-14	5	5	1	1	Partner	18	1500.00	15.00	22950.00	7200.00	15750.00	Lisa Anderson	INV-2-00062	Overdue	2025-12-13 07:11:45.467881
663	2	ORD-2-00063	2023-06-19	9	3	5	1	Reseller	19	2500.00	10.00	42750.00	15200.00	27550.00	Mike Johnson	INV-2-00063	Paid	2025-12-13 07:11:45.467881
664	2	ORD-2-00064	2023-09-24	12	1	5	1	Partner	12	5000.00	15.00	51000.00	18000.00	33000.00	Mike Johnson	INV-2-00064	Paid	2025-12-13 07:11:45.467881
665	2	ORD-2-00065	2024-11-17	10	3	2	1	Reseller	17	2500.00	0.00	42500.00	13600.00	28900.00	Jane Doe	INV-2-00065	Overdue	2025-12-13 07:11:45.467881
666	2	ORD-2-00066	2023-06-18	4	9	4	1	Retail	17	800.00	0.00	13600.00	3400.00	10200.00	David Brown	INV-2-00066	Pending	2025-12-13 07:11:45.467881
667	2	ORD-2-00067	2023-08-07	3	4	1	1	Partner	2	3500.00	10.00	6300.00	2400.00	3900.00	Mike Johnson	INV-2-00067	Paid	2025-12-13 07:11:45.467881
668	2	ORD-2-00068	2024-03-10	2	3	2	1	Retail	20	2500.00	15.00	42500.00	16000.00	26500.00	Lisa Anderson	INV-2-00068	Paid	2025-12-13 07:11:45.467881
669	2	ORD-2-00069	2023-01-05	1	8	3	1	Retail	2	500.00	0.00	1000.00	300.00	700.00	Chris Lee	INV-2-00069	Paid	2025-12-13 07:11:45.467881
670	2	ORD-2-00070	2024-02-06	15	7	2	1	Reseller	15	4500.00	10.00	60750.00	22500.00	38250.00	John Smith	INV-2-00070	Overdue	2025-12-13 07:11:45.467881
671	2	ORD-2-00071	2024-05-23	11	6	5	1	Partner	8	2000.00	0.00	16000.00	4800.00	11200.00	John Smith	INV-2-00071	Pending	2025-12-13 07:11:45.467881
672	2	ORD-2-00072	2024-05-27	12	9	3	1	Partner	10	800.00	20.00	6400.00	2000.00	4400.00	Mike Johnson	INV-2-00072	Paid	2025-12-13 07:11:45.467881
673	2	ORD-2-00073	2024-05-28	14	1	3	1	Retail	9	5000.00	15.00	38250.00	13500.00	24750.00	Chris Lee	INV-2-00073	Paid	2025-12-13 07:11:45.467881
674	2	ORD-2-00074	2023-12-10	15	3	5	1	Direct Sales	7	2500.00	0.00	17500.00	5600.00	11900.00	Chris Lee	INV-2-00074	Paid	2025-12-13 07:11:45.467881
675	2	ORD-2-00075	2024-03-27	8	2	5	1	Reseller	7	199.00	5.00	1323.35	350.00	973.35	Lisa Anderson	INV-2-00075	Overdue	2025-12-13 07:11:45.467881
676	2	ORD-2-00076	2024-03-06	2	6	4	1	Direct Sales	4	2000.00	20.00	6400.00	2400.00	4000.00	Mike Johnson	INV-2-00076	Overdue	2025-12-13 07:11:45.467881
677	2	ORD-2-00077	2024-11-24	11	8	3	1	Reseller	20	500.00	10.00	9000.00	3000.00	6000.00	Mike Johnson	INV-2-00077	Overdue	2025-12-13 07:11:45.467881
678	2	ORD-2-00078	2024-06-10	6	5	3	1	Direct Sales	5	1500.00	5.00	7125.00	2000.00	5125.00	Chris Lee	INV-2-00078	Pending	2025-12-13 07:11:45.467881
679	2	ORD-2-00079	2023-08-11	8	3	3	1	Retail	9	2500.00	20.00	18000.00	7200.00	10800.00	Amanda White	INV-2-00079	Paid	2025-12-13 07:11:45.467881
680	2	ORD-2-00080	2024-12-15	6	2	2	1	Direct Sales	2	199.00	20.00	318.40	100.00	218.40	Mike Johnson	INV-2-00080	Pending	2025-12-13 07:11:45.467881
681	2	ORD-2-00081	2024-12-25	2	9	3	1	Direct Sales	14	800.00	5.00	10640.00	2800.00	7840.00	Robert Taylor	INV-2-00081	Paid	2025-12-13 07:11:45.467881
682	2	ORD-2-00082	2024-04-04	5	2	4	1	Partner	8	199.00	5.00	1512.40	400.00	1112.40	Chris Lee	INV-2-00082	Paid	2025-12-13 07:11:45.467881
683	2	ORD-2-00083	2023-03-07	7	1	1	1	Direct Sales	11	5000.00	20.00	44000.00	16500.00	27500.00	Amanda White	INV-2-00083	Paid	2025-12-13 07:11:45.467881
684	2	ORD-2-00084	2024-02-09	4	3	5	1	Partner	2	2500.00	15.00	4250.00	1600.00	2650.00	Sarah Wilson	INV-2-00084	Paid	2025-12-13 07:11:45.467881
685	2	ORD-2-00085	2024-10-16	14	5	4	1	Online	4	1500.00	5.00	5700.00	1600.00	4100.00	Amanda White	INV-2-00085	Overdue	2025-12-13 07:11:45.467881
686	2	ORD-2-00086	2023-05-12	12	3	5	1	Direct Sales	7	2500.00	15.00	14875.00	5600.00	9275.00	Jane Doe	INV-2-00086	Paid	2025-12-13 07:11:45.467881
687	2	ORD-2-00087	2023-08-03	1	6	4	1	Direct Sales	7	2000.00	15.00	11900.00	4200.00	7700.00	Chris Lee	INV-2-00087	Pending	2025-12-13 07:11:45.467881
688	2	ORD-2-00088	2023-07-21	5	7	5	1	Online	12	4500.00	20.00	43200.00	18000.00	25200.00	Mike Johnson	INV-2-00088	Paid	2025-12-13 07:11:45.467881
689	2	ORD-2-00089	2023-06-07	3	2	3	1	Reseller	12	199.00	0.00	2388.00	600.00	1788.00	Sarah Wilson	INV-2-00089	Overdue	2025-12-13 07:11:45.467881
690	2	ORD-2-00090	2024-09-12	10	1	5	1	Partner	1	5000.00	15.00	4250.00	1500.00	2750.00	Chris Lee	INV-2-00090	Paid	2025-12-13 07:11:45.467881
691	2	ORD-2-00091	2024-01-10	6	9	2	1	Partner	12	800.00	5.00	9120.00	2400.00	6720.00	Robert Taylor	INV-2-00091	Pending	2025-12-13 07:11:45.467881
692	2	ORD-2-00092	2024-01-31	4	10	3	1	Retail	19	350.00	0.00	6650.00	2280.00	4370.00	David Brown	INV-2-00092	Pending	2025-12-13 07:11:45.467881
693	2	ORD-2-00093	2024-08-24	9	4	1	1	Partner	7	3500.00	20.00	19600.00	8400.00	11200.00	Jane Doe	INV-2-00093	Paid	2025-12-13 07:11:45.467881
694	2	ORD-2-00094	2024-05-20	3	2	5	1	Direct Sales	3	199.00	10.00	537.30	150.00	387.30	Jane Doe	INV-2-00094	Overdue	2025-12-13 07:11:45.467881
695	2	ORD-2-00095	2023-08-02	2	1	2	1	Partner	14	5000.00	0.00	70000.00	21000.00	49000.00	Jane Doe	INV-2-00095	Paid	2025-12-13 07:11:45.467881
696	2	ORD-2-00096	2023-08-22	6	3	4	1	Partner	8	2500.00	0.00	20000.00	6400.00	13600.00	Chris Lee	INV-2-00096	Overdue	2025-12-13 07:11:45.467881
697	2	ORD-2-00097	2024-06-05	13	5	4	1	Direct Sales	18	1500.00	15.00	22950.00	7200.00	15750.00	Amanda White	INV-2-00097	Overdue	2025-12-13 07:11:45.467881
698	2	ORD-2-00098	2023-05-14	5	6	3	1	Partner	13	2000.00	10.00	23400.00	7800.00	15600.00	Mike Johnson	INV-2-00098	Paid	2025-12-13 07:11:45.467881
699	2	ORD-2-00099	2024-08-08	15	2	2	1	Partner	14	199.00	10.00	2507.40	700.00	1807.40	John Smith	INV-2-00099	Paid	2025-12-13 07:11:45.467881
700	2	ORD-2-00100	2024-07-22	5	1	2	1	Retail	17	5000.00	10.00	76500.00	25500.00	51000.00	Robert Taylor	INV-2-00100	Paid	2025-12-13 07:11:45.467881
701	2	ORD-2-00101	2023-09-29	8	10	1	1	Online	8	350.00	5.00	2660.00	960.00	1700.00	Chris Lee	INV-2-00101	Paid	2025-12-13 07:11:45.467881
702	2	ORD-2-00102	2023-11-02	11	1	5	1	Retail	16	5000.00	10.00	72000.00	24000.00	48000.00	Robert Taylor	INV-2-00102	Paid	2025-12-13 07:11:45.467881
703	2	ORD-2-00103	2024-02-07	5	2	4	1	Reseller	15	199.00	5.00	2835.75	750.00	2085.75	Mike Johnson	INV-2-00103	Pending	2025-12-13 07:11:45.467881
704	2	ORD-2-00104	2023-11-03	2	1	4	1	Retail	16	5000.00	15.00	68000.00	24000.00	44000.00	Jane Doe	INV-2-00104	Paid	2025-12-13 07:11:45.467881
705	2	ORD-2-00105	2023-05-21	7	7	3	1	Online	13	4500.00	10.00	52650.00	19500.00	33150.00	John Smith	INV-2-00105	Paid	2025-12-13 07:11:45.467881
706	2	ORD-2-00106	2023-12-21	11	1	2	1	Partner	1	5000.00	0.00	5000.00	1500.00	3500.00	Sarah Wilson	INV-2-00106	Pending	2025-12-13 07:11:45.467881
707	2	ORD-2-00107	2023-08-14	7	1	4	1	Partner	20	5000.00	10.00	90000.00	30000.00	60000.00	Chris Lee	INV-2-00107	Overdue	2025-12-13 07:11:45.467881
708	2	ORD-2-00108	2023-09-21	2	8	3	1	Retail	6	500.00	10.00	2700.00	900.00	1800.00	Amanda White	INV-2-00108	Pending	2025-12-13 07:11:45.467881
709	2	ORD-2-00109	2023-08-16	12	5	1	1	Reseller	9	1500.00	10.00	12150.00	3600.00	8550.00	Lisa Anderson	INV-2-00109	Paid	2025-12-13 07:11:45.467881
710	2	ORD-2-00110	2023-11-04	5	3	1	1	Partner	12	2500.00	15.00	25500.00	9600.00	15900.00	Sarah Wilson	INV-2-00110	Overdue	2025-12-13 07:11:45.467881
711	2	ORD-2-00111	2024-03-18	14	10	5	1	Reseller	3	350.00	15.00	892.50	360.00	532.50	Emily Davis	INV-2-00111	Paid	2025-12-13 07:11:45.467881
712	2	ORD-2-00112	2024-10-02	1	8	4	1	Reseller	15	500.00	15.00	6375.00	2250.00	4125.00	Chris Lee	INV-2-00112	Paid	2025-12-13 07:11:45.467881
713	2	ORD-2-00113	2023-04-18	11	5	4	1	Direct Sales	3	1500.00	0.00	4500.00	1200.00	3300.00	John Smith	INV-2-00113	Overdue	2025-12-13 07:11:45.467881
714	2	ORD-2-00114	2024-05-05	10	5	1	1	Online	20	1500.00	0.00	30000.00	8000.00	22000.00	Chris Lee	INV-2-00114	Pending	2025-12-13 07:11:45.467881
715	2	ORD-2-00115	2024-07-21	5	8	3	1	Retail	8	500.00	20.00	3200.00	1200.00	2000.00	Robert Taylor	INV-2-00115	Paid	2025-12-13 07:11:45.467881
716	2	ORD-2-00116	2024-09-27	11	6	1	1	Reseller	14	2000.00	0.00	28000.00	8400.00	19600.00	Robert Taylor	INV-2-00116	Paid	2025-12-13 07:11:45.467881
717	2	ORD-2-00117	2024-09-03	8	8	2	1	Reseller	7	500.00	15.00	2975.00	1050.00	1925.00	Mike Johnson	INV-2-00117	Paid	2025-12-13 07:11:45.467881
718	2	ORD-2-00118	2024-07-24	1	5	5	1	Retail	16	1500.00	10.00	21600.00	6400.00	15200.00	Emily Davis	INV-2-00118	Overdue	2025-12-13 07:11:45.467881
719	2	ORD-2-00119	2024-08-03	4	6	2	1	Online	20	2000.00	20.00	32000.00	12000.00	20000.00	David Brown	INV-2-00119	Paid	2025-12-13 07:11:45.467881
720	2	ORD-2-00120	2023-12-21	6	2	1	1	Online	6	199.00	15.00	1014.90	300.00	714.90	Emily Davis	INV-2-00120	Paid	2025-12-13 07:11:45.467881
721	2	ORD-2-00121	2023-01-13	14	6	5	1	Direct Sales	13	2000.00	15.00	22100.00	7800.00	14300.00	Jane Doe	INV-2-00121	Paid	2025-12-13 07:11:45.467881
722	2	ORD-2-00122	2024-10-30	8	3	4	1	Retail	16	2500.00	5.00	38000.00	12800.00	25200.00	David Brown	INV-2-00122	Pending	2025-12-13 07:11:45.467881
723	2	ORD-2-00123	2024-07-03	10	2	2	1	Online	10	199.00	0.00	1990.00	500.00	1490.00	Sarah Wilson	INV-2-00123	Pending	2025-12-13 07:11:45.467881
724	2	ORD-2-00124	2024-11-21	14	7	5	1	Reseller	12	4500.00	0.00	54000.00	18000.00	36000.00	Amanda White	INV-2-00124	Pending	2025-12-13 07:11:45.467881
725	2	ORD-2-00125	2023-08-18	7	6	5	1	Retail	15	2000.00	5.00	28500.00	9000.00	19500.00	Emily Davis	INV-2-00125	Overdue	2025-12-13 07:11:45.467881
726	2	ORD-2-00126	2024-09-19	13	3	3	1	Reseller	7	2500.00	5.00	16625.00	5600.00	11025.00	Jane Doe	INV-2-00126	Paid	2025-12-13 07:11:45.467881
727	2	ORD-2-00127	2023-03-24	13	7	4	1	Direct Sales	3	4500.00	0.00	13500.00	4500.00	9000.00	Robert Taylor	INV-2-00127	Paid	2025-12-13 07:11:45.467881
728	2	ORD-2-00128	2024-11-10	9	2	1	1	Retail	10	199.00	5.00	1890.50	500.00	1390.50	David Brown	INV-2-00128	Pending	2025-12-13 07:11:45.467881
729	2	ORD-2-00129	2024-07-13	10	10	4	1	Online	7	350.00	10.00	2205.00	840.00	1365.00	Robert Taylor	INV-2-00129	Overdue	2025-12-13 07:11:45.467881
730	2	ORD-2-00130	2023-05-10	5	10	1	1	Online	2	350.00	20.00	560.00	240.00	320.00	Jane Doe	INV-2-00130	Overdue	2025-12-13 07:11:45.467881
731	2	ORD-2-00131	2024-12-29	9	7	2	1	Reseller	16	4500.00	20.00	57600.00	24000.00	33600.00	Emily Davis	INV-2-00131	Pending	2025-12-13 07:11:45.467881
732	2	ORD-2-00132	2023-11-15	10	4	1	1	Reseller	15	3500.00	5.00	49875.00	18000.00	31875.00	Amanda White	INV-2-00132	Paid	2025-12-13 07:11:45.467881
733	2	ORD-2-00133	2024-05-31	12	7	2	1	Retail	19	4500.00	20.00	68400.00	28500.00	39900.00	Lisa Anderson	INV-2-00133	Paid	2025-12-13 07:11:45.467881
734	2	ORD-2-00134	2024-07-22	10	9	5	1	Online	19	800.00	10.00	13680.00	3800.00	9880.00	Jane Doe	INV-2-00134	Overdue	2025-12-13 07:11:45.467881
735	2	ORD-2-00135	2023-08-21	13	5	2	1	Partner	1	1500.00	0.00	1500.00	400.00	1100.00	Mike Johnson	INV-2-00135	Pending	2025-12-13 07:11:45.467881
736	2	ORD-2-00136	2023-03-23	14	2	5	1	Partner	17	199.00	15.00	2875.55	850.00	2025.55	Chris Lee	INV-2-00136	Paid	2025-12-13 07:11:45.467881
737	2	ORD-2-00137	2024-06-17	10	6	1	1	Partner	5	2000.00	10.00	9000.00	3000.00	6000.00	Jane Doe	INV-2-00137	Paid	2025-12-13 07:11:45.467881
738	2	ORD-2-00138	2023-10-01	14	2	4	1	Online	15	199.00	20.00	2388.00	750.00	1638.00	Robert Taylor	INV-2-00138	Pending	2025-12-13 07:11:45.467881
739	2	ORD-2-00139	2023-02-05	15	10	5	1	Online	3	350.00	20.00	840.00	360.00	480.00	Emily Davis	INV-2-00139	Overdue	2025-12-13 07:11:45.467881
740	2	ORD-2-00140	2023-03-18	7	7	5	1	Direct Sales	1	4500.00	0.00	4500.00	1500.00	3000.00	Emily Davis	INV-2-00140	Paid	2025-12-13 07:11:45.467881
741	2	ORD-2-00141	2023-12-19	11	10	5	1	Reseller	10	350.00	5.00	3325.00	1200.00	2125.00	David Brown	INV-2-00141	Pending	2025-12-13 07:11:45.467881
742	2	ORD-2-00142	2023-02-15	12	8	1	1	Reseller	6	500.00	0.00	3000.00	900.00	2100.00	Chris Lee	INV-2-00142	Paid	2025-12-13 07:11:45.467881
743	2	ORD-2-00143	2023-11-12	8	2	1	1	Retail	9	199.00	5.00	1701.45	450.00	1251.45	Amanda White	INV-2-00143	Pending	2025-12-13 07:11:45.467881
744	2	ORD-2-00144	2024-03-07	8	2	5	1	Online	8	199.00	15.00	1353.20	400.00	953.20	Mike Johnson	INV-2-00144	Paid	2025-12-13 07:11:45.467881
745	2	ORD-2-00145	2023-08-13	7	8	2	1	Direct Sales	15	500.00	15.00	6375.00	2250.00	4125.00	Robert Taylor	INV-2-00145	Overdue	2025-12-13 07:11:45.467881
746	2	ORD-2-00146	2024-06-07	7	10	1	1	Reseller	16	350.00	0.00	5600.00	1920.00	3680.00	Robert Taylor	INV-2-00146	Overdue	2025-12-13 07:11:45.467881
747	2	ORD-2-00147	2024-08-21	6	5	3	1	Reseller	5	1500.00	5.00	7125.00	2000.00	5125.00	Lisa Anderson	INV-2-00147	Paid	2025-12-13 07:11:45.467881
748	2	ORD-2-00148	2024-02-13	5	3	2	1	Reseller	10	2500.00	15.00	21250.00	8000.00	13250.00	John Smith	INV-2-00148	Overdue	2025-12-13 07:11:45.467881
749	2	ORD-2-00149	2023-05-22	8	3	3	1	Online	2	2500.00	5.00	4750.00	1600.00	3150.00	David Brown	INV-2-00149	Pending	2025-12-13 07:11:45.467881
750	2	ORD-2-00150	2024-03-23	13	5	3	1	Direct Sales	3	1500.00	0.00	4500.00	1200.00	3300.00	Jane Doe	INV-2-00150	Paid	2025-12-13 07:11:45.467881
751	2	ORD-2-00151	2024-06-13	10	2	1	1	Partner	3	199.00	10.00	537.30	150.00	387.30	David Brown	INV-2-00151	Paid	2025-12-13 07:11:45.467881
752	2	ORD-2-00152	2023-04-02	8	7	2	1	Reseller	9	4500.00	20.00	32400.00	13500.00	18900.00	John Smith	INV-2-00152	Paid	2025-12-13 07:11:45.467881
753	2	ORD-2-00153	2023-11-30	8	7	4	1	Direct Sales	16	4500.00	20.00	57600.00	24000.00	33600.00	Emily Davis	INV-2-00153	Paid	2025-12-13 07:11:45.467881
754	2	ORD-2-00154	2023-08-06	10	6	2	1	Partner	12	2000.00	10.00	21600.00	7200.00	14400.00	Emily Davis	INV-2-00154	Paid	2025-12-13 07:11:45.467881
755	2	ORD-2-00155	2023-11-11	5	8	5	1	Direct Sales	11	500.00	0.00	5500.00	1650.00	3850.00	Chris Lee	INV-2-00155	Paid	2025-12-13 07:11:45.467881
756	2	ORD-2-00156	2023-05-28	6	1	1	1	Retail	4	5000.00	20.00	16000.00	6000.00	10000.00	Robert Taylor	INV-2-00156	Paid	2025-12-13 07:11:45.467881
757	2	ORD-2-00157	2023-02-26	5	8	4	1	Online	5	500.00	15.00	2125.00	750.00	1375.00	David Brown	INV-2-00157	Paid	2025-12-13 07:11:45.467881
758	2	ORD-2-00158	2024-01-12	12	8	3	1	Direct Sales	18	500.00	20.00	7200.00	2700.00	4500.00	Robert Taylor	INV-2-00158	Paid	2025-12-13 07:11:45.467881
759	2	ORD-2-00159	2024-10-24	12	6	2	1	Reseller	7	2000.00	0.00	14000.00	4200.00	9800.00	David Brown	INV-2-00159	Paid	2025-12-13 07:11:45.467881
760	2	ORD-2-00160	2023-07-02	11	1	4	1	Online	11	5000.00	15.00	46750.00	16500.00	30250.00	Robert Taylor	INV-2-00160	Paid	2025-12-13 07:11:45.467881
761	2	ORD-2-00161	2024-03-07	3	10	5	1	Online	10	350.00	5.00	3325.00	1200.00	2125.00	Emily Davis	INV-2-00161	Paid	2025-12-13 07:11:45.467881
762	2	ORD-2-00162	2024-02-16	10	7	5	1	Reseller	9	4500.00	10.00	36450.00	13500.00	22950.00	John Smith	INV-2-00162	Paid	2025-12-13 07:11:45.467881
763	2	ORD-2-00163	2024-10-12	2	10	5	1	Online	7	350.00	5.00	2327.50	840.00	1487.50	David Brown	INV-2-00163	Paid	2025-12-13 07:11:45.467881
764	2	ORD-2-00164	2023-08-04	15	8	5	1	Online	13	500.00	15.00	5525.00	1950.00	3575.00	John Smith	INV-2-00164	Overdue	2025-12-13 07:11:45.467881
765	2	ORD-2-00165	2023-03-05	3	10	3	1	Direct Sales	10	350.00	5.00	3325.00	1200.00	2125.00	David Brown	INV-2-00165	Overdue	2025-12-13 07:11:45.467881
766	2	ORD-2-00166	2024-09-14	8	2	3	1	Reseller	18	199.00	0.00	3582.00	900.00	2682.00	Robert Taylor	INV-2-00166	Paid	2025-12-13 07:11:45.467881
767	2	ORD-2-00167	2023-04-02	8	7	2	1	Direct Sales	5	4500.00	10.00	20250.00	7500.00	12750.00	Emily Davis	INV-2-00167	Paid	2025-12-13 07:11:45.467881
768	2	ORD-2-00168	2023-06-29	6	10	5	1	Direct Sales	19	350.00	0.00	6650.00	2280.00	4370.00	John Smith	INV-2-00168	Pending	2025-12-13 07:11:45.467881
769	2	ORD-2-00169	2024-01-05	4	2	1	1	Reseller	10	199.00	20.00	1592.00	500.00	1092.00	Chris Lee	INV-2-00169	Overdue	2025-12-13 07:11:45.467881
770	2	ORD-2-00170	2024-10-01	7	9	2	1	Direct Sales	20	800.00	15.00	13600.00	4000.00	9600.00	Lisa Anderson	INV-2-00170	Paid	2025-12-13 07:11:45.467881
771	2	ORD-2-00171	2024-01-23	11	5	1	1	Retail	5	1500.00	15.00	6375.00	2000.00	4375.00	Amanda White	INV-2-00171	Paid	2025-12-13 07:11:45.467881
772	2	ORD-2-00172	2024-06-21	4	4	5	1	Direct Sales	13	3500.00	10.00	40950.00	15600.00	25350.00	Mike Johnson	INV-2-00172	Pending	2025-12-13 07:11:45.467881
773	2	ORD-2-00173	2023-11-29	11	4	3	1	Reseller	19	3500.00	15.00	56525.00	22800.00	33725.00	Chris Lee	INV-2-00173	Paid	2025-12-13 07:11:45.467881
774	2	ORD-2-00174	2024-02-16	2	2	2	1	Reseller	9	199.00	10.00	1611.90	450.00	1161.90	David Brown	INV-2-00174	Overdue	2025-12-13 07:11:45.467881
775	2	ORD-2-00175	2023-12-25	1	10	5	1	Reseller	9	350.00	10.00	2835.00	1080.00	1755.00	Mike Johnson	INV-2-00175	Paid	2025-12-13 07:11:45.467881
776	2	ORD-2-00176	2023-02-17	10	3	2	1	Reseller	8	2500.00	5.00	19000.00	6400.00	12600.00	Mike Johnson	INV-2-00176	Pending	2025-12-13 07:11:45.467881
777	2	ORD-2-00177	2024-07-20	13	4	1	1	Direct Sales	8	3500.00	10.00	25200.00	9600.00	15600.00	Robert Taylor	INV-2-00177	Pending	2025-12-13 07:11:45.467881
778	2	ORD-2-00178	2023-04-11	9	2	2	1	Online	2	199.00	5.00	378.10	100.00	278.10	Amanda White	INV-2-00178	Pending	2025-12-13 07:11:45.467881
779	2	ORD-2-00179	2024-11-28	6	4	3	1	Online	11	3500.00	0.00	38500.00	13200.00	25300.00	Robert Taylor	INV-2-00179	Paid	2025-12-13 07:11:45.467881
780	2	ORD-2-00180	2024-09-14	1	2	1	1	Online	3	199.00	20.00	477.60	150.00	327.60	John Smith	INV-2-00180	Paid	2025-12-13 07:11:45.467881
781	2	ORD-2-00181	2024-11-30	14	2	4	1	Direct Sales	16	199.00	15.00	2706.40	800.00	1906.40	Amanda White	INV-2-00181	Paid	2025-12-13 07:11:45.467881
782	2	ORD-2-00182	2023-11-08	2	10	4	1	Online	6	350.00	5.00	1995.00	720.00	1275.00	Mike Johnson	INV-2-00182	Paid	2025-12-13 07:11:45.467881
783	2	ORD-2-00183	2023-07-20	11	1	1	1	Online	8	5000.00	10.00	36000.00	12000.00	24000.00	Lisa Anderson	INV-2-00183	Overdue	2025-12-13 07:11:45.467881
784	2	ORD-2-00184	2023-08-25	13	9	3	1	Reseller	7	800.00	5.00	5320.00	1400.00	3920.00	David Brown	INV-2-00184	Paid	2025-12-13 07:11:45.467881
785	2	ORD-2-00185	2023-01-22	5	2	4	1	Retail	7	199.00	0.00	1393.00	350.00	1043.00	Lisa Anderson	INV-2-00185	Paid	2025-12-13 07:11:45.467881
786	2	ORD-2-00186	2023-08-09	4	6	1	1	Partner	6	2000.00	5.00	11400.00	3600.00	7800.00	John Smith	INV-2-00186	Paid	2025-12-13 07:11:45.467881
787	2	ORD-2-00187	2023-01-24	3	6	3	1	Retail	9	2000.00	15.00	15300.00	5400.00	9900.00	Jane Doe	INV-2-00187	Overdue	2025-12-13 07:11:45.467881
788	2	ORD-2-00188	2023-12-11	5	2	2	1	Online	10	199.00	0.00	1990.00	500.00	1490.00	Amanda White	INV-2-00188	Paid	2025-12-13 07:11:45.467881
789	2	ORD-2-00189	2024-09-03	4	3	1	1	Retail	1	2500.00	20.00	2000.00	800.00	1200.00	Jane Doe	INV-2-00189	Pending	2025-12-13 07:11:45.467881
790	2	ORD-2-00190	2024-05-07	2	9	4	1	Retail	4	800.00	10.00	2880.00	800.00	2080.00	David Brown	INV-2-00190	Paid	2025-12-13 07:11:45.467881
791	2	ORD-2-00191	2023-02-21	10	5	4	1	Reseller	18	1500.00	20.00	21600.00	7200.00	14400.00	Lisa Anderson	INV-2-00191	Overdue	2025-12-13 07:11:45.467881
792	2	ORD-2-00192	2023-07-03	6	5	2	1	Reseller	15	1500.00	10.00	20250.00	6000.00	14250.00	John Smith	INV-2-00192	Pending	2025-12-13 07:11:45.467881
793	2	ORD-2-00193	2024-12-03	9	1	3	1	Reseller	9	5000.00	20.00	36000.00	13500.00	22500.00	Sarah Wilson	INV-2-00193	Paid	2025-12-13 07:11:45.467881
794	2	ORD-2-00194	2023-09-22	2	7	4	1	Direct Sales	14	4500.00	20.00	50400.00	21000.00	29400.00	Lisa Anderson	INV-2-00194	Overdue	2025-12-13 07:11:45.467881
795	2	ORD-2-00195	2024-01-06	13	9	4	1	Retail	14	800.00	5.00	10640.00	2800.00	7840.00	Lisa Anderson	INV-2-00195	Paid	2025-12-13 07:11:45.467881
796	2	ORD-2-00196	2024-11-12	12	4	2	1	Direct Sales	20	3500.00	10.00	63000.00	24000.00	39000.00	Mike Johnson	INV-2-00196	Paid	2025-12-13 07:11:45.467881
797	2	ORD-2-00197	2024-04-14	4	4	2	1	Online	15	3500.00	5.00	49875.00	18000.00	31875.00	David Brown	INV-2-00197	Paid	2025-12-13 07:11:45.467881
798	2	ORD-2-00198	2023-10-23	7	5	1	1	Retail	9	1500.00	20.00	10800.00	3600.00	7200.00	Chris Lee	INV-2-00198	Paid	2025-12-13 07:11:45.467881
799	2	ORD-2-00199	2023-10-30	11	5	2	1	Partner	10	1500.00	15.00	12750.00	4000.00	8750.00	Lisa Anderson	INV-2-00199	Paid	2025-12-13 07:11:45.467881
800	2	ORD-2-00200	2023-06-13	15	8	3	1	Retail	18	500.00	5.00	8550.00	2700.00	5850.00	Mike Johnson	INV-2-00200	Paid	2025-12-13 07:11:45.467881
801	2	ORD-2-00201	2023-02-11	14	7	3	1	Online	13	4500.00	5.00	55575.00	19500.00	36075.00	Robert Taylor	INV-2-00201	Paid	2025-12-13 07:11:45.467881
802	2	ORD-2-00202	2024-04-26	2	2	4	1	Retail	18	199.00	15.00	3044.70	900.00	2144.70	Mike Johnson	INV-2-00202	Paid	2025-12-13 07:11:45.467881
803	2	ORD-2-00203	2023-04-25	1	6	3	1	Retail	2	2000.00	5.00	3800.00	1200.00	2600.00	Sarah Wilson	INV-2-00203	Paid	2025-12-13 07:11:45.467881
804	2	ORD-2-00204	2024-03-21	11	2	3	1	Reseller	13	199.00	15.00	2198.95	650.00	1548.95	Emily Davis	INV-2-00204	Paid	2025-12-13 07:11:45.467881
805	2	ORD-2-00205	2024-12-09	6	1	3	1	Online	12	5000.00	5.00	57000.00	18000.00	39000.00	John Smith	INV-2-00205	Paid	2025-12-13 07:11:45.467881
806	2	ORD-2-00206	2024-07-01	8	8	4	1	Reseller	19	500.00	10.00	8550.00	2850.00	5700.00	Robert Taylor	INV-2-00206	Paid	2025-12-13 07:11:45.467881
807	2	ORD-2-00207	2023-06-27	9	3	5	1	Partner	20	2500.00	5.00	47500.00	16000.00	31500.00	John Smith	INV-2-00207	Pending	2025-12-13 07:11:45.467881
808	2	ORD-2-00208	2024-06-25	8	2	1	1	Reseller	4	199.00	5.00	756.20	200.00	556.20	Sarah Wilson	INV-2-00208	Paid	2025-12-13 07:11:45.467881
809	2	ORD-2-00209	2023-06-24	8	2	3	1	Partner	14	199.00	20.00	2228.80	700.00	1528.80	Robert Taylor	INV-2-00209	Paid	2025-12-13 07:11:45.467881
810	2	ORD-2-00210	2023-10-30	4	3	4	1	Online	9	2500.00	15.00	19125.00	7200.00	11925.00	Emily Davis	INV-2-00210	Paid	2025-12-13 07:11:45.467881
811	2	ORD-2-00211	2023-07-10	12	4	1	1	Direct Sales	10	3500.00	10.00	31500.00	12000.00	19500.00	Robert Taylor	INV-2-00211	Paid	2025-12-13 07:11:45.467881
812	2	ORD-2-00212	2023-07-16	14	3	4	1	Reseller	1	2500.00	15.00	2125.00	800.00	1325.00	John Smith	INV-2-00212	Pending	2025-12-13 07:11:45.467881
813	2	ORD-2-00213	2024-05-30	8	1	3	1	Partner	2	5000.00	20.00	8000.00	3000.00	5000.00	Robert Taylor	INV-2-00213	Pending	2025-12-13 07:11:45.467881
814	2	ORD-2-00214	2023-11-11	7	6	5	1	Direct Sales	7	2000.00	0.00	14000.00	4200.00	9800.00	John Smith	INV-2-00214	Overdue	2025-12-13 07:11:45.467881
815	2	ORD-2-00215	2024-09-20	1	5	3	1	Partner	4	1500.00	5.00	5700.00	1600.00	4100.00	Jane Doe	INV-2-00215	Paid	2025-12-13 07:11:45.467881
816	2	ORD-2-00216	2023-03-31	14	6	5	1	Direct Sales	1	2000.00	5.00	1900.00	600.00	1300.00	Chris Lee	INV-2-00216	Paid	2025-12-13 07:11:45.467881
817	2	ORD-2-00217	2023-08-17	8	4	2	1	Retail	11	3500.00	15.00	32725.00	13200.00	19525.00	Jane Doe	INV-2-00217	Paid	2025-12-13 07:11:45.467881
818	2	ORD-2-00218	2023-03-29	3	4	4	1	Online	10	3500.00	5.00	33250.00	12000.00	21250.00	Chris Lee	INV-2-00218	Pending	2025-12-13 07:11:45.467881
819	2	ORD-2-00219	2023-03-08	9	4	3	1	Retail	5	3500.00	0.00	17500.00	6000.00	11500.00	John Smith	INV-2-00219	Paid	2025-12-13 07:11:45.467881
820	2	ORD-2-00220	2023-01-28	12	4	4	1	Partner	5	3500.00	10.00	15750.00	6000.00	9750.00	Lisa Anderson	INV-2-00220	Paid	2025-12-13 07:11:45.467881
821	2	ORD-2-00221	2024-11-02	4	2	1	1	Partner	3	199.00	20.00	477.60	150.00	327.60	Amanda White	INV-2-00221	Pending	2025-12-13 07:11:45.467881
822	2	ORD-2-00222	2023-02-15	12	9	4	1	Reseller	6	800.00	15.00	4080.00	1200.00	2880.00	Robert Taylor	INV-2-00222	Paid	2025-12-13 07:11:45.467881
823	2	ORD-2-00223	2024-06-21	4	7	4	1	Online	8	4500.00	5.00	34200.00	12000.00	22200.00	Amanda White	INV-2-00223	Paid	2025-12-13 07:11:45.467881
824	2	ORD-2-00224	2024-08-18	12	9	4	1	Reseller	18	800.00	0.00	14400.00	3600.00	10800.00	John Smith	INV-2-00224	Paid	2025-12-13 07:11:45.467881
825	2	ORD-2-00225	2024-11-22	13	7	1	1	Retail	1	4500.00	0.00	4500.00	1500.00	3000.00	Emily Davis	INV-2-00225	Paid	2025-12-13 07:11:45.467881
826	2	ORD-2-00226	2024-02-27	5	8	2	1	Online	20	500.00	0.00	10000.00	3000.00	7000.00	Jane Doe	INV-2-00226	Paid	2025-12-13 07:11:45.467881
827	2	ORD-2-00227	2024-04-07	15	2	3	1	Retail	18	199.00	10.00	3223.80	900.00	2323.80	Amanda White	INV-2-00227	Paid	2025-12-13 07:11:45.467881
828	2	ORD-2-00228	2024-10-14	3	2	3	1	Online	8	199.00	5.00	1512.40	400.00	1112.40	Amanda White	INV-2-00228	Overdue	2025-12-13 07:11:45.467881
829	2	ORD-2-00229	2023-10-14	14	2	4	1	Direct Sales	5	199.00	20.00	796.00	250.00	546.00	Mike Johnson	INV-2-00229	Pending	2025-12-13 07:11:45.467881
830	2	ORD-2-00230	2023-03-13	15	3	4	1	Reseller	4	2500.00	5.00	9500.00	3200.00	6300.00	Amanda White	INV-2-00230	Paid	2025-12-13 07:11:45.467881
831	2	ORD-2-00231	2024-11-12	11	10	1	1	Partner	6	350.00	0.00	2100.00	720.00	1380.00	Emily Davis	INV-2-00231	Paid	2025-12-13 07:11:45.467881
832	2	ORD-2-00232	2024-10-22	15	9	4	1	Direct Sales	14	800.00	0.00	11200.00	2800.00	8400.00	Mike Johnson	INV-2-00232	Paid	2025-12-13 07:11:45.467881
833	2	ORD-2-00233	2023-01-25	6	7	5	1	Retail	5	4500.00	15.00	19125.00	7500.00	11625.00	Lisa Anderson	INV-2-00233	Paid	2025-12-13 07:11:45.467881
834	2	ORD-2-00234	2023-07-08	9	6	4	1	Reseller	19	2000.00	20.00	30400.00	11400.00	19000.00	David Brown	INV-2-00234	Overdue	2025-12-13 07:11:45.467881
835	2	ORD-2-00235	2023-12-19	8	5	4	1	Direct Sales	7	1500.00	15.00	8925.00	2800.00	6125.00	John Smith	INV-2-00235	Paid	2025-12-13 07:11:45.467881
836	2	ORD-2-00236	2024-03-29	7	8	5	1	Reseller	12	500.00	15.00	5100.00	1800.00	3300.00	Emily Davis	INV-2-00236	Overdue	2025-12-13 07:11:45.467881
837	2	ORD-2-00237	2023-08-31	7	1	5	1	Partner	6	5000.00	10.00	27000.00	9000.00	18000.00	Amanda White	INV-2-00237	Overdue	2025-12-13 07:11:45.467881
838	2	ORD-2-00238	2024-04-20	1	5	4	1	Retail	11	1500.00	5.00	15675.00	4400.00	11275.00	David Brown	INV-2-00238	Pending	2025-12-13 07:11:45.467881
839	2	ORD-2-00239	2023-03-06	7	7	4	1	Direct Sales	9	4500.00	20.00	32400.00	13500.00	18900.00	Lisa Anderson	INV-2-00239	Pending	2025-12-13 07:11:45.467881
840	2	ORD-2-00240	2024-06-01	11	9	2	1	Direct Sales	13	800.00	5.00	9880.00	2600.00	7280.00	David Brown	INV-2-00240	Paid	2025-12-13 07:11:45.467881
841	2	ORD-2-00241	2023-10-31	15	2	4	1	Direct Sales	4	199.00	0.00	796.00	200.00	596.00	Amanda White	INV-2-00241	Overdue	2025-12-13 07:11:45.467881
842	2	ORD-2-00242	2024-10-06	3	3	2	1	Reseller	7	2500.00	5.00	16625.00	5600.00	11025.00	Chris Lee	INV-2-00242	Pending	2025-12-13 07:11:45.467881
843	2	ORD-2-00243	2024-12-13	1	8	1	1	Retail	4	500.00	5.00	1900.00	600.00	1300.00	Amanda White	INV-2-00243	Overdue	2025-12-13 07:11:45.467881
844	2	ORD-2-00244	2023-08-02	3	7	1	1	Direct Sales	17	4500.00	10.00	68850.00	25500.00	43350.00	Amanda White	INV-2-00244	Paid	2025-12-13 07:11:45.467881
845	2	ORD-2-00245	2024-09-03	13	1	5	1	Retail	17	5000.00	0.00	85000.00	25500.00	59500.00	David Brown	INV-2-00245	Paid	2025-12-13 07:11:45.467881
846	2	ORD-2-00246	2023-12-01	5	7	1	1	Partner	15	4500.00	15.00	57375.00	22500.00	34875.00	Jane Doe	INV-2-00246	Overdue	2025-12-13 07:11:45.467881
847	2	ORD-2-00247	2024-09-26	10	4	1	1	Partner	13	3500.00	5.00	43225.00	15600.00	27625.00	Amanda White	INV-2-00247	Pending	2025-12-13 07:11:45.467881
848	2	ORD-2-00248	2023-12-05	2	5	2	1	Direct Sales	18	1500.00	15.00	22950.00	7200.00	15750.00	Sarah Wilson	INV-2-00248	Paid	2025-12-13 07:11:45.467881
849	2	ORD-2-00249	2024-01-26	14	7	4	1	Reseller	14	4500.00	10.00	56700.00	21000.00	35700.00	Emily Davis	INV-2-00249	Paid	2025-12-13 07:11:45.467881
850	2	ORD-2-00250	2024-06-30	13	4	1	1	Reseller	19	3500.00	15.00	56525.00	22800.00	33725.00	Sarah Wilson	INV-2-00250	Paid	2025-12-13 07:11:45.467881
851	2	ORD-2-00251	2024-01-17	13	2	4	1	Direct Sales	8	199.00	0.00	1592.00	400.00	1192.00	Emily Davis	INV-2-00251	Pending	2025-12-13 07:11:45.467881
852	2	ORD-2-00252	2023-09-04	14	1	1	1	Partner	17	5000.00	20.00	68000.00	25500.00	42500.00	Amanda White	INV-2-00252	Paid	2025-12-13 07:11:45.467881
853	2	ORD-2-00253	2024-12-09	12	4	3	1	Retail	4	3500.00	10.00	12600.00	4800.00	7800.00	John Smith	INV-2-00253	Paid	2025-12-13 07:11:45.467881
854	2	ORD-2-00254	2024-01-20	7	5	5	1	Retail	19	1500.00	10.00	25650.00	7600.00	18050.00	Sarah Wilson	INV-2-00254	Pending	2025-12-13 07:11:45.467881
855	2	ORD-2-00255	2023-03-13	14	8	4	1	Direct Sales	9	500.00	5.00	4275.00	1350.00	2925.00	John Smith	INV-2-00255	Paid	2025-12-13 07:11:45.467881
856	2	ORD-2-00256	2023-02-15	11	4	4	1	Partner	5	3500.00	0.00	17500.00	6000.00	11500.00	David Brown	INV-2-00256	Overdue	2025-12-13 07:11:45.467881
857	2	ORD-2-00257	2024-03-03	7	7	3	1	Reseller	3	4500.00	0.00	13500.00	4500.00	9000.00	Amanda White	INV-2-00257	Pending	2025-12-13 07:11:45.467881
858	2	ORD-2-00258	2024-07-07	1	1	1	1	Retail	8	5000.00	0.00	40000.00	12000.00	28000.00	David Brown	INV-2-00258	Paid	2025-12-13 07:11:45.467881
859	2	ORD-2-00259	2023-05-12	6	2	2	1	Reseller	13	199.00	5.00	2457.65	650.00	1807.65	Sarah Wilson	INV-2-00259	Paid	2025-12-13 07:11:45.467881
860	2	ORD-2-00260	2023-12-28	11	3	5	1	Partner	9	2500.00	5.00	21375.00	7200.00	14175.00	Lisa Anderson	INV-2-00260	Overdue	2025-12-13 07:11:45.467881
861	2	ORD-2-00261	2023-01-24	3	4	5	1	Online	17	3500.00	10.00	53550.00	20400.00	33150.00	Sarah Wilson	INV-2-00261	Paid	2025-12-13 07:11:45.467881
862	2	ORD-2-00262	2023-12-16	1	9	3	1	Direct Sales	13	800.00	15.00	8840.00	2600.00	6240.00	Sarah Wilson	INV-2-00262	Paid	2025-12-13 07:11:45.467881
863	2	ORD-2-00263	2023-07-25	11	5	5	1	Partner	3	1500.00	15.00	3825.00	1200.00	2625.00	Jane Doe	INV-2-00263	Paid	2025-12-13 07:11:45.467881
864	2	ORD-2-00264	2024-12-30	13	4	3	1	Partner	11	3500.00	20.00	30800.00	13200.00	17600.00	Mike Johnson	INV-2-00264	Paid	2025-12-13 07:11:45.467881
865	2	ORD-2-00265	2023-04-21	6	9	1	1	Online	20	800.00	15.00	13600.00	4000.00	9600.00	John Smith	INV-2-00265	Overdue	2025-12-13 07:11:45.467881
866	2	ORD-2-00266	2023-06-02	9	7	3	1	Reseller	7	4500.00	15.00	26775.00	10500.00	16275.00	Lisa Anderson	INV-2-00266	Pending	2025-12-13 07:11:45.467881
867	2	ORD-2-00267	2023-01-17	3	3	2	1	Partner	14	2500.00	10.00	31500.00	11200.00	20300.00	John Smith	INV-2-00267	Paid	2025-12-13 07:11:45.467881
868	2	ORD-2-00268	2024-02-09	12	3	1	1	Direct Sales	8	2500.00	5.00	19000.00	6400.00	12600.00	David Brown	INV-2-00268	Paid	2025-12-13 07:11:45.467881
869	2	ORD-2-00269	2024-04-18	11	9	5	1	Online	18	800.00	15.00	12240.00	3600.00	8640.00	Jane Doe	INV-2-00269	Pending	2025-12-13 07:11:45.467881
870	2	ORD-2-00270	2023-07-24	9	1	1	1	Retail	19	5000.00	0.00	95000.00	28500.00	66500.00	Sarah Wilson	INV-2-00270	Paid	2025-12-13 07:11:45.467881
871	2	ORD-2-00271	2024-05-30	7	6	4	1	Partner	12	2000.00	0.00	24000.00	7200.00	16800.00	Mike Johnson	INV-2-00271	Paid	2025-12-13 07:11:45.467881
872	2	ORD-2-00272	2023-03-03	3	9	1	1	Online	1	800.00	10.00	720.00	200.00	520.00	John Smith	INV-2-00272	Pending	2025-12-13 07:11:45.467881
873	2	ORD-2-00273	2023-04-02	11	7	4	1	Retail	14	4500.00	15.00	53550.00	21000.00	32550.00	Robert Taylor	INV-2-00273	Paid	2025-12-13 07:11:45.467881
874	2	ORD-2-00274	2024-08-13	12	1	5	1	Direct Sales	7	5000.00	10.00	31500.00	10500.00	21000.00	Jane Doe	INV-2-00274	Paid	2025-12-13 07:11:45.467881
875	2	ORD-2-00275	2024-11-02	9	1	5	1	Reseller	5	5000.00	5.00	23750.00	7500.00	16250.00	Mike Johnson	INV-2-00275	Paid	2025-12-13 07:11:45.467881
876	2	ORD-2-00276	2023-08-12	11	3	4	1	Partner	17	2500.00	5.00	40375.00	13600.00	26775.00	John Smith	INV-2-00276	Paid	2025-12-13 07:11:45.467881
877	2	ORD-2-00277	2023-03-16	15	5	1	1	Partner	20	1500.00	20.00	24000.00	8000.00	16000.00	Sarah Wilson	INV-2-00277	Paid	2025-12-13 07:11:45.467881
878	2	ORD-2-00278	2023-05-10	7	10	1	1	Reseller	17	350.00	5.00	5652.50	2040.00	3612.50	Chris Lee	INV-2-00278	Paid	2025-12-13 07:11:45.467881
879	2	ORD-2-00279	2024-12-08	13	5	2	1	Online	6	1500.00	10.00	8100.00	2400.00	5700.00	Amanda White	INV-2-00279	Paid	2025-12-13 07:11:45.467881
880	2	ORD-2-00280	2024-03-16	12	8	4	1	Partner	6	500.00	10.00	2700.00	900.00	1800.00	Lisa Anderson	INV-2-00280	Pending	2025-12-13 07:11:45.467881
881	2	ORD-2-00281	2023-08-20	9	4	5	1	Reseller	16	3500.00	10.00	50400.00	19200.00	31200.00	Robert Taylor	INV-2-00281	Paid	2025-12-13 07:11:45.467881
882	2	ORD-2-00282	2023-03-07	13	8	3	1	Reseller	7	500.00	5.00	3325.00	1050.00	2275.00	Lisa Anderson	INV-2-00282	Paid	2025-12-13 07:11:45.467881
883	2	ORD-2-00283	2023-08-07	4	6	4	1	Direct Sales	8	2000.00	0.00	16000.00	4800.00	11200.00	Lisa Anderson	INV-2-00283	Paid	2025-12-13 07:11:45.467881
884	2	ORD-2-00284	2024-02-09	11	8	5	1	Reseller	1	500.00	20.00	400.00	150.00	250.00	John Smith	INV-2-00284	Pending	2025-12-13 07:11:45.467881
885	2	ORD-2-00285	2023-10-12	6	1	5	1	Retail	3	5000.00	10.00	13500.00	4500.00	9000.00	Amanda White	INV-2-00285	Paid	2025-12-13 07:11:45.467881
886	2	ORD-2-00286	2023-10-30	4	5	5	1	Reseller	7	1500.00	10.00	9450.00	2800.00	6650.00	Sarah Wilson	INV-2-00286	Paid	2025-12-13 07:11:45.467881
887	2	ORD-2-00287	2024-09-24	9	3	4	1	Retail	5	2500.00	10.00	11250.00	4000.00	7250.00	Emily Davis	INV-2-00287	Overdue	2025-12-13 07:11:45.467881
888	2	ORD-2-00288	2023-07-30	4	1	1	1	Partner	12	5000.00	15.00	51000.00	18000.00	33000.00	Chris Lee	INV-2-00288	Paid	2025-12-13 07:11:45.467881
889	2	ORD-2-00289	2024-06-28	15	9	1	1	Partner	3	800.00	15.00	2040.00	600.00	1440.00	Robert Taylor	INV-2-00289	Overdue	2025-12-13 07:11:45.467881
890	2	ORD-2-00290	2023-04-30	2	2	4	1	Reseller	4	199.00	0.00	796.00	200.00	596.00	David Brown	INV-2-00290	Paid	2025-12-13 07:11:45.467881
891	2	ORD-2-00291	2023-11-15	7	2	3	1	Online	5	199.00	5.00	945.25	250.00	695.25	Sarah Wilson	INV-2-00291	Paid	2025-12-13 07:11:45.467881
892	2	ORD-2-00292	2023-08-14	9	6	4	1	Online	6	2000.00	15.00	10200.00	3600.00	6600.00	John Smith	INV-2-00292	Paid	2025-12-13 07:11:45.467881
893	2	ORD-2-00293	2024-04-29	2	8	2	1	Reseller	5	500.00	5.00	2375.00	750.00	1625.00	Jane Doe	INV-2-00293	Paid	2025-12-13 07:11:45.467881
894	2	ORD-2-00294	2024-01-23	14	9	1	1	Partner	19	800.00	15.00	12920.00	3800.00	9120.00	Lisa Anderson	INV-2-00294	Paid	2025-12-13 07:11:45.467881
895	2	ORD-2-00295	2024-08-07	9	9	4	1	Direct Sales	12	800.00	20.00	7680.00	2400.00	5280.00	Lisa Anderson	INV-2-00295	Paid	2025-12-13 07:11:45.467881
896	2	ORD-2-00296	2023-11-27	6	6	3	1	Online	6	2000.00	15.00	10200.00	3600.00	6600.00	John Smith	INV-2-00296	Overdue	2025-12-13 07:11:45.467881
897	2	ORD-2-00297	2023-08-04	12	6	4	1	Partner	7	2000.00	0.00	14000.00	4200.00	9800.00	Mike Johnson	INV-2-00297	Paid	2025-12-13 07:11:45.467881
898	2	ORD-2-00298	2023-09-28	4	5	4	1	Retail	6	1500.00	10.00	8100.00	2400.00	5700.00	David Brown	INV-2-00298	Pending	2025-12-13 07:11:45.467881
899	2	ORD-2-00299	2024-02-19	3	1	2	1	Partner	20	5000.00	15.00	85000.00	30000.00	55000.00	David Brown	INV-2-00299	Paid	2025-12-13 07:11:45.467881
900	2	ORD-2-00300	2024-02-01	5	7	4	1	Direct Sales	15	4500.00	10.00	60750.00	22500.00	38250.00	Robert Taylor	INV-2-00300	Overdue	2025-12-13 07:11:45.467881
901	2	ORD-2-00301	2024-12-21	14	3	5	1	Online	2	2500.00	20.00	4000.00	1600.00	2400.00	Sarah Wilson	INV-2-00301	Paid	2025-12-13 07:11:45.467881
902	2	ORD-2-00302	2024-08-08	5	8	3	1	Direct Sales	2	500.00	20.00	800.00	300.00	500.00	Mike Johnson	INV-2-00302	Paid	2025-12-13 07:11:45.467881
903	2	ORD-2-00303	2023-11-16	4	5	3	1	Reseller	10	1500.00	20.00	12000.00	4000.00	8000.00	Lisa Anderson	INV-2-00303	Paid	2025-12-13 07:11:45.467881
904	2	ORD-2-00304	2023-01-03	13	10	4	1	Direct Sales	16	350.00	15.00	4760.00	1920.00	2840.00	John Smith	INV-2-00304	Paid	2025-12-13 07:11:45.467881
905	2	ORD-2-00305	2024-01-07	4	4	3	1	Retail	18	3500.00	20.00	50400.00	21600.00	28800.00	Chris Lee	INV-2-00305	Overdue	2025-12-13 07:11:45.467881
906	2	ORD-2-00306	2024-08-11	13	6	4	1	Partner	16	2000.00	15.00	27200.00	9600.00	17600.00	Emily Davis	INV-2-00306	Overdue	2025-12-13 07:11:45.467881
907	2	ORD-2-00307	2024-04-07	2	4	2	1	Online	5	3500.00	15.00	14875.00	6000.00	8875.00	Robert Taylor	INV-2-00307	Overdue	2025-12-13 07:11:45.467881
908	2	ORD-2-00308	2023-10-22	15	4	5	1	Direct Sales	16	3500.00	10.00	50400.00	19200.00	31200.00	Emily Davis	INV-2-00308	Pending	2025-12-13 07:11:45.467881
909	2	ORD-2-00309	2024-11-26	10	2	4	1	Retail	2	199.00	5.00	378.10	100.00	278.10	Amanda White	INV-2-00309	Paid	2025-12-13 07:11:45.467881
910	2	ORD-2-00310	2023-12-24	8	2	3	1	Retail	6	199.00	10.00	1074.60	300.00	774.60	Jane Doe	INV-2-00310	Paid	2025-12-13 07:11:45.467881
911	2	ORD-2-00311	2024-04-15	12	9	4	1	Reseller	4	800.00	0.00	3200.00	800.00	2400.00	David Brown	INV-2-00311	Paid	2025-12-13 07:11:45.467881
912	2	ORD-2-00312	2023-09-14	7	8	1	1	Retail	14	500.00	20.00	5600.00	2100.00	3500.00	Amanda White	INV-2-00312	Paid	2025-12-13 07:11:45.467881
913	2	ORD-2-00313	2023-09-30	1	7	3	1	Reseller	2	4500.00	15.00	7650.00	3000.00	4650.00	Chris Lee	INV-2-00313	Paid	2025-12-13 07:11:45.467881
914	2	ORD-2-00314	2023-02-10	3	2	5	1	Online	11	199.00	10.00	1970.10	550.00	1420.10	Jane Doe	INV-2-00314	Paid	2025-12-13 07:11:45.467881
915	2	ORD-2-00315	2024-10-09	14	5	2	1	Direct Sales	9	1500.00	20.00	10800.00	3600.00	7200.00	Sarah Wilson	INV-2-00315	Paid	2025-12-13 07:11:45.467881
916	2	ORD-2-00316	2023-04-23	2	2	5	1	Partner	5	199.00	20.00	796.00	250.00	546.00	Robert Taylor	INV-2-00316	Paid	2025-12-13 07:11:45.467881
917	2	ORD-2-00317	2023-07-30	5	10	4	1	Partner	19	350.00	15.00	5652.50	2280.00	3372.50	Robert Taylor	INV-2-00317	Paid	2025-12-13 07:11:45.467881
918	2	ORD-2-00318	2024-04-04	7	4	3	1	Direct Sales	9	3500.00	10.00	28350.00	10800.00	17550.00	Emily Davis	INV-2-00318	Overdue	2025-12-13 07:11:45.467881
919	2	ORD-2-00319	2023-11-06	15	2	5	1	Partner	12	199.00	20.00	1910.40	600.00	1310.40	Sarah Wilson	INV-2-00319	Paid	2025-12-13 07:11:45.467881
920	2	ORD-2-00320	2024-03-17	9	3	3	1	Partner	1	2500.00	10.00	2250.00	800.00	1450.00	Emily Davis	INV-2-00320	Pending	2025-12-13 07:11:45.467881
921	2	ORD-2-00321	2023-04-09	12	2	5	1	Online	20	199.00	20.00	3184.00	1000.00	2184.00	John Smith	INV-2-00321	Paid	2025-12-13 07:11:45.467881
922	2	ORD-2-00322	2024-03-11	4	3	2	1	Partner	15	2500.00	0.00	37500.00	12000.00	25500.00	Chris Lee	INV-2-00322	Overdue	2025-12-13 07:11:45.467881
923	2	ORD-2-00323	2023-07-11	10	10	2	1	Partner	18	350.00	5.00	5985.00	2160.00	3825.00	Mike Johnson	INV-2-00323	Paid	2025-12-13 07:11:45.467881
924	2	ORD-2-00324	2024-06-21	9	3	2	1	Retail	15	2500.00	20.00	30000.00	12000.00	18000.00	David Brown	INV-2-00324	Paid	2025-12-13 07:11:45.467881
925	2	ORD-2-00325	2024-10-13	7	8	4	1	Retail	3	500.00	10.00	1350.00	450.00	900.00	Chris Lee	INV-2-00325	Paid	2025-12-13 07:11:45.467881
926	2	ORD-2-00326	2023-10-07	5	4	3	1	Retail	1	3500.00	5.00	3325.00	1200.00	2125.00	Robert Taylor	INV-2-00326	Paid	2025-12-13 07:11:45.467881
927	2	ORD-2-00327	2023-03-07	5	3	2	1	Online	13	2500.00	0.00	32500.00	10400.00	22100.00	Jane Doe	INV-2-00327	Paid	2025-12-13 07:11:45.467881
928	2	ORD-2-00328	2023-08-29	3	10	1	1	Direct Sales	17	350.00	10.00	5355.00	2040.00	3315.00	Robert Taylor	INV-2-00328	Paid	2025-12-13 07:11:45.467881
929	2	ORD-2-00329	2023-02-10	7	6	1	1	Reseller	19	2000.00	20.00	30400.00	11400.00	19000.00	Chris Lee	INV-2-00329	Overdue	2025-12-13 07:11:45.467881
930	2	ORD-2-00330	2024-06-08	9	4	4	1	Reseller	17	3500.00	0.00	59500.00	20400.00	39100.00	Amanda White	INV-2-00330	Paid	2025-12-13 07:11:45.467881
931	2	ORD-2-00331	2024-12-25	6	6	1	1	Online	17	2000.00	5.00	32300.00	10200.00	22100.00	Lisa Anderson	INV-2-00331	Paid	2025-12-13 07:11:45.467881
932	2	ORD-2-00332	2024-03-12	7	7	4	1	Online	8	4500.00	20.00	28800.00	12000.00	16800.00	Chris Lee	INV-2-00332	Paid	2025-12-13 07:11:45.467881
933	2	ORD-2-00333	2024-04-15	6	3	1	1	Online	11	2500.00	5.00	26125.00	8800.00	17325.00	John Smith	INV-2-00333	Paid	2025-12-13 07:11:45.467881
934	2	ORD-2-00334	2023-10-02	2	5	5	1	Partner	19	1500.00	5.00	27075.00	7600.00	19475.00	Amanda White	INV-2-00334	Overdue	2025-12-13 07:11:45.467881
935	2	ORD-2-00335	2023-10-15	10	5	1	1	Direct Sales	17	1500.00	10.00	22950.00	6800.00	16150.00	Emily Davis	INV-2-00335	Pending	2025-12-13 07:11:45.467881
936	2	ORD-2-00336	2024-07-27	12	3	4	1	Online	19	2500.00	5.00	45125.00	15200.00	29925.00	Mike Johnson	INV-2-00336	Paid	2025-12-13 07:11:45.467881
937	2	ORD-2-00337	2023-09-05	14	10	5	1	Partner	17	350.00	10.00	5355.00	2040.00	3315.00	Robert Taylor	INV-2-00337	Overdue	2025-12-13 07:11:45.467881
938	2	ORD-2-00338	2023-04-14	6	3	2	1	Reseller	11	2500.00	10.00	24750.00	8800.00	15950.00	Emily Davis	INV-2-00338	Pending	2025-12-13 07:11:45.467881
939	2	ORD-2-00339	2024-03-09	5	9	5	1	Online	19	800.00	15.00	12920.00	3800.00	9120.00	David Brown	INV-2-00339	Paid	2025-12-13 07:11:45.467881
940	2	ORD-2-00340	2023-01-06	5	5	1	1	Online	1	1500.00	15.00	1275.00	400.00	875.00	John Smith	INV-2-00340	Paid	2025-12-13 07:11:45.467881
941	2	ORD-2-00341	2024-07-07	1	9	4	1	Retail	19	800.00	15.00	12920.00	3800.00	9120.00	David Brown	INV-2-00341	Paid	2025-12-13 07:11:45.467881
942	2	ORD-2-00342	2023-11-14	5	2	3	1	Direct Sales	12	199.00	15.00	2029.80	600.00	1429.80	John Smith	INV-2-00342	Paid	2025-12-13 07:11:45.467881
943	2	ORD-2-00343	2023-12-19	8	6	5	1	Online	13	2000.00	0.00	26000.00	7800.00	18200.00	Amanda White	INV-2-00343	Pending	2025-12-13 07:11:45.467881
944	2	ORD-2-00344	2024-07-29	12	2	4	1	Partner	9	199.00	10.00	1611.90	450.00	1161.90	Mike Johnson	INV-2-00344	Paid	2025-12-13 07:11:45.467881
945	2	ORD-2-00345	2024-10-16	3	9	3	1	Reseller	12	800.00	5.00	9120.00	2400.00	6720.00	John Smith	INV-2-00345	Paid	2025-12-13 07:11:45.467881
946	2	ORD-2-00346	2023-11-24	11	9	4	1	Partner	9	800.00	5.00	6840.00	1800.00	5040.00	Jane Doe	INV-2-00346	Paid	2025-12-13 07:11:45.467881
947	2	ORD-2-00347	2024-03-28	1	6	1	1	Direct Sales	18	2000.00	20.00	28800.00	10800.00	18000.00	Robert Taylor	INV-2-00347	Paid	2025-12-13 07:11:45.467881
948	2	ORD-2-00348	2023-10-20	9	8	2	1	Reseller	3	500.00	5.00	1425.00	450.00	975.00	Chris Lee	INV-2-00348	Paid	2025-12-13 07:11:45.467881
949	2	ORD-2-00349	2023-11-30	3	1	3	1	Retail	7	5000.00	15.00	29750.00	10500.00	19250.00	Robert Taylor	INV-2-00349	Paid	2025-12-13 07:11:45.467881
950	2	ORD-2-00350	2024-04-07	1	6	1	1	Retail	6	2000.00	20.00	9600.00	3600.00	6000.00	John Smith	INV-2-00350	Overdue	2025-12-13 07:11:45.467881
951	2	ORD-2-00351	2024-05-13	15	10	2	1	Retail	10	350.00	0.00	3500.00	1200.00	2300.00	Lisa Anderson	INV-2-00351	Paid	2025-12-13 07:11:45.467881
952	2	ORD-2-00352	2024-02-22	9	10	1	1	Partner	19	350.00	20.00	5320.00	2280.00	3040.00	Lisa Anderson	INV-2-00352	Overdue	2025-12-13 07:11:45.467881
953	2	ORD-2-00353	2024-06-09	12	6	4	1	Retail	1	2000.00	5.00	1900.00	600.00	1300.00	Amanda White	INV-2-00353	Pending	2025-12-13 07:11:45.467881
954	2	ORD-2-00354	2024-07-07	13	6	1	1	Retail	20	2000.00	0.00	40000.00	12000.00	28000.00	Lisa Anderson	INV-2-00354	Paid	2025-12-13 07:11:45.467881
955	2	ORD-2-00355	2024-02-16	6	2	2	1	Direct Sales	9	199.00	15.00	1522.35	450.00	1072.35	Robert Taylor	INV-2-00355	Paid	2025-12-13 07:11:45.467881
956	2	ORD-2-00356	2024-08-03	1	3	2	1	Online	9	2500.00	15.00	19125.00	7200.00	11925.00	Emily Davis	INV-2-00356	Pending	2025-12-13 07:11:45.467881
957	2	ORD-2-00357	2024-02-21	12	8	3	1	Partner	12	500.00	10.00	5400.00	1800.00	3600.00	Robert Taylor	INV-2-00357	Paid	2025-12-13 07:11:45.467881
958	2	ORD-2-00358	2024-06-25	3	1	1	1	Partner	16	5000.00	5.00	76000.00	24000.00	52000.00	Lisa Anderson	INV-2-00358	Paid	2025-12-13 07:11:45.467881
959	2	ORD-2-00359	2023-09-15	9	2	4	1	Direct Sales	20	199.00	15.00	3383.00	1000.00	2383.00	Lisa Anderson	INV-2-00359	Overdue	2025-12-13 07:11:45.467881
960	2	ORD-2-00360	2024-09-24	8	3	5	1	Direct Sales	13	2500.00	20.00	26000.00	10400.00	15600.00	David Brown	INV-2-00360	Paid	2025-12-13 07:11:45.467881
961	2	ORD-2-00361	2023-01-05	3	9	3	1	Direct Sales	15	800.00	10.00	10800.00	3000.00	7800.00	Mike Johnson	INV-2-00361	Paid	2025-12-13 07:11:45.467881
962	2	ORD-2-00362	2024-02-10	13	4	4	1	Retail	15	3500.00	10.00	47250.00	18000.00	29250.00	Mike Johnson	INV-2-00362	Paid	2025-12-13 07:11:45.467881
963	2	ORD-2-00363	2023-10-21	14	3	4	1	Reseller	12	2500.00	10.00	27000.00	9600.00	17400.00	Sarah Wilson	INV-2-00363	Paid	2025-12-13 07:11:45.467881
964	2	ORD-2-00364	2024-12-05	9	5	1	1	Retail	6	1500.00	15.00	7650.00	2400.00	5250.00	Jane Doe	INV-2-00364	Overdue	2025-12-13 07:11:45.467881
965	2	ORD-2-00365	2023-04-24	6	2	5	1	Partner	9	199.00	20.00	1432.80	450.00	982.80	Chris Lee	INV-2-00365	Paid	2025-12-13 07:11:45.467881
966	2	ORD-2-00366	2024-10-19	9	6	1	1	Direct Sales	18	2000.00	10.00	32400.00	10800.00	21600.00	Sarah Wilson	INV-2-00366	Pending	2025-12-13 07:11:45.467881
967	2	ORD-2-00367	2023-09-10	8	1	4	1	Online	6	5000.00	5.00	28500.00	9000.00	19500.00	Mike Johnson	INV-2-00367	Overdue	2025-12-13 07:11:45.467881
968	2	ORD-2-00368	2023-12-03	4	6	1	1	Reseller	4	2000.00	0.00	8000.00	2400.00	5600.00	Robert Taylor	INV-2-00368	Overdue	2025-12-13 07:11:45.467881
969	2	ORD-2-00369	2023-09-13	7	6	2	1	Online	19	2000.00	10.00	34200.00	11400.00	22800.00	Lisa Anderson	INV-2-00369	Pending	2025-12-13 07:11:45.467881
970	2	ORD-2-00370	2023-07-13	14	4	4	1	Partner	3	3500.00	5.00	9975.00	3600.00	6375.00	Sarah Wilson	INV-2-00370	Pending	2025-12-13 07:11:45.467881
971	2	ORD-2-00371	2024-02-20	10	3	5	1	Retail	8	2500.00	10.00	18000.00	6400.00	11600.00	Mike Johnson	INV-2-00371	Paid	2025-12-13 07:11:45.467881
972	2	ORD-2-00372	2023-12-10	3	10	1	1	Direct Sales	16	350.00	20.00	4480.00	1920.00	2560.00	Lisa Anderson	INV-2-00372	Paid	2025-12-13 07:11:45.467881
973	2	ORD-2-00373	2023-05-22	9	10	4	1	Partner	11	350.00	15.00	3272.50	1320.00	1952.50	Robert Taylor	INV-2-00373	Overdue	2025-12-13 07:11:45.467881
974	2	ORD-2-00374	2024-08-21	9	8	2	1	Partner	2	500.00	20.00	800.00	300.00	500.00	Mike Johnson	INV-2-00374	Overdue	2025-12-13 07:11:45.467881
975	2	ORD-2-00375	2023-01-29	10	6	4	1	Reseller	19	2000.00	5.00	36100.00	11400.00	24700.00	Chris Lee	INV-2-00375	Paid	2025-12-13 07:11:45.467881
976	2	ORD-2-00376	2024-02-14	9	10	4	1	Partner	9	350.00	0.00	3150.00	1080.00	2070.00	Emily Davis	INV-2-00376	Paid	2025-12-13 07:11:45.467881
977	2	ORD-2-00377	2024-05-09	4	5	1	1	Partner	8	1500.00	0.00	12000.00	3200.00	8800.00	Amanda White	INV-2-00377	Overdue	2025-12-13 07:11:45.467881
978	2	ORD-2-00378	2023-05-08	4	10	3	1	Retail	5	350.00	20.00	1400.00	600.00	800.00	David Brown	INV-2-00378	Overdue	2025-12-13 07:11:45.467881
979	2	ORD-2-00379	2023-12-24	11	1	2	1	Online	1	5000.00	0.00	5000.00	1500.00	3500.00	David Brown	INV-2-00379	Pending	2025-12-13 07:11:45.467881
980	2	ORD-2-00380	2023-01-17	14	9	5	1	Partner	15	800.00	20.00	9600.00	3000.00	6600.00	Amanda White	INV-2-00380	Pending	2025-12-13 07:11:45.467881
981	2	ORD-2-00381	2023-12-31	8	8	3	1	Reseller	19	500.00	5.00	9025.00	2850.00	6175.00	Mike Johnson	INV-2-00381	Paid	2025-12-13 07:11:45.467881
982	2	ORD-2-00382	2023-12-11	8	10	3	1	Reseller	12	350.00	10.00	3780.00	1440.00	2340.00	John Smith	INV-2-00382	Paid	2025-12-13 07:11:45.467881
983	2	ORD-2-00383	2024-03-12	12	5	2	1	Reseller	19	1500.00	20.00	22800.00	7600.00	15200.00	Chris Lee	INV-2-00383	Overdue	2025-12-13 07:11:45.467881
984	2	ORD-2-00384	2023-05-04	9	10	2	1	Retail	11	350.00	10.00	3465.00	1320.00	2145.00	Amanda White	INV-2-00384	Paid	2025-12-13 07:11:45.467881
985	2	ORD-2-00385	2024-10-18	1	9	5	1	Partner	14	800.00	10.00	10080.00	2800.00	7280.00	Robert Taylor	INV-2-00385	Paid	2025-12-13 07:11:45.467881
986	2	ORD-2-00386	2024-06-08	2	1	2	1	Reseller	11	5000.00	10.00	49500.00	16500.00	33000.00	Chris Lee	INV-2-00386	Paid	2025-12-13 07:11:45.467881
987	2	ORD-2-00387	2023-12-11	2	6	3	1	Online	5	2000.00	5.00	9500.00	3000.00	6500.00	Lisa Anderson	INV-2-00387	Pending	2025-12-13 07:11:45.467881
988	2	ORD-2-00388	2024-11-26	12	8	3	1	Partner	9	500.00	5.00	4275.00	1350.00	2925.00	Emily Davis	INV-2-00388	Pending	2025-12-13 07:11:45.467881
989	2	ORD-2-00389	2024-06-21	4	3	1	1	Retail	15	2500.00	5.00	35625.00	12000.00	23625.00	John Smith	INV-2-00389	Overdue	2025-12-13 07:11:45.467881
990	2	ORD-2-00390	2023-10-16	5	8	3	1	Direct Sales	1	500.00	20.00	400.00	150.00	250.00	Amanda White	INV-2-00390	Paid	2025-12-13 07:11:45.467881
991	2	ORD-2-00391	2023-12-24	2	3	1	1	Reseller	8	2500.00	5.00	19000.00	6400.00	12600.00	Mike Johnson	INV-2-00391	Overdue	2025-12-13 07:11:45.467881
992	2	ORD-2-00392	2023-10-14	13	9	5	1	Reseller	2	800.00	5.00	1520.00	400.00	1120.00	John Smith	INV-2-00392	Paid	2025-12-13 07:11:45.467881
993	2	ORD-2-00393	2023-08-24	9	10	1	1	Reseller	16	350.00	10.00	5040.00	1920.00	3120.00	Lisa Anderson	INV-2-00393	Paid	2025-12-13 07:11:45.467881
994	2	ORD-2-00394	2023-07-31	9	8	4	1	Reseller	18	500.00	10.00	8100.00	2700.00	5400.00	Amanda White	INV-2-00394	Paid	2025-12-13 07:11:45.467881
995	2	ORD-2-00395	2024-11-10	12	2	5	1	Online	4	199.00	0.00	796.00	200.00	596.00	Chris Lee	INV-2-00395	Pending	2025-12-13 07:11:45.467881
996	2	ORD-2-00396	2023-02-23	4	7	4	1	Partner	1	4500.00	5.00	4275.00	1500.00	2775.00	John Smith	INV-2-00396	Paid	2025-12-13 07:11:45.467881
997	2	ORD-2-00397	2024-04-28	4	2	5	1	Online	12	199.00	15.00	2029.80	600.00	1429.80	Mike Johnson	INV-2-00397	Pending	2025-12-13 07:11:45.467881
998	2	ORD-2-00398	2023-12-19	4	10	1	1	Direct Sales	5	350.00	5.00	1662.50	600.00	1062.50	Jane Doe	INV-2-00398	Paid	2025-12-13 07:11:45.467881
999	2	ORD-2-00399	2024-02-14	1	7	4	1	Reseller	7	4500.00	0.00	31500.00	10500.00	21000.00	Robert Taylor	INV-2-00399	Paid	2025-12-13 07:11:45.467881
1000	2	ORD-2-00400	2024-07-15	15	9	4	1	Partner	16	800.00	0.00	12800.00	3200.00	9600.00	Emily Davis	INV-2-00400	Paid	2025-12-13 07:11:45.467881
1001	2	ORD-2-00401	2024-08-27	9	1	2	1	Partner	4	5000.00	5.00	19000.00	6000.00	13000.00	Amanda White	INV-2-00401	Paid	2025-12-13 07:11:45.467881
1002	2	ORD-2-00402	2024-11-21	3	2	4	1	Direct Sales	11	199.00	10.00	1970.10	550.00	1420.10	Chris Lee	INV-2-00402	Pending	2025-12-13 07:11:45.467881
1003	2	ORD-2-00403	2023-02-13	6	10	2	1	Retail	13	350.00	15.00	3867.50	1560.00	2307.50	John Smith	INV-2-00403	Paid	2025-12-13 07:11:45.467881
1004	2	ORD-2-00404	2023-01-21	2	6	2	1	Reseller	17	2000.00	20.00	27200.00	10200.00	17000.00	John Smith	INV-2-00404	Paid	2025-12-13 07:11:45.467881
1005	2	ORD-2-00405	2023-07-09	13	7	1	1	Reseller	3	4500.00	20.00	10800.00	4500.00	6300.00	Sarah Wilson	INV-2-00405	Pending	2025-12-13 07:11:45.467881
1006	2	ORD-2-00406	2023-06-05	6	5	3	1	Partner	17	1500.00	5.00	24225.00	6800.00	17425.00	Mike Johnson	INV-2-00406	Paid	2025-12-13 07:11:45.467881
1007	2	ORD-2-00407	2023-04-09	4	4	4	1	Direct Sales	19	3500.00	10.00	59850.00	22800.00	37050.00	Robert Taylor	INV-2-00407	Overdue	2025-12-13 07:11:45.467881
1008	2	ORD-2-00408	2024-03-26	7	6	4	1	Reseller	3	2000.00	0.00	6000.00	1800.00	4200.00	John Smith	INV-2-00408	Paid	2025-12-13 07:11:45.467881
1009	2	ORD-2-00409	2024-08-12	11	5	4	1	Online	19	1500.00	15.00	24225.00	7600.00	16625.00	David Brown	INV-2-00409	Overdue	2025-12-13 07:11:45.467881
1010	2	ORD-2-00410	2024-03-11	1	4	3	1	Online	19	3500.00	15.00	56525.00	22800.00	33725.00	Sarah Wilson	INV-2-00410	Paid	2025-12-13 07:11:45.467881
1011	2	ORD-2-00411	2024-09-16	8	3	1	1	Online	8	2500.00	20.00	16000.00	6400.00	9600.00	Sarah Wilson	INV-2-00411	Overdue	2025-12-13 07:11:45.467881
1012	2	ORD-2-00412	2023-06-23	15	9	2	1	Direct Sales	3	800.00	5.00	2280.00	600.00	1680.00	Lisa Anderson	INV-2-00412	Paid	2025-12-13 07:11:45.467881
1013	2	ORD-2-00413	2024-01-12	3	3	4	1	Reseller	3	2500.00	0.00	7500.00	2400.00	5100.00	Chris Lee	INV-2-00413	Pending	2025-12-13 07:11:45.467881
1014	2	ORD-2-00414	2023-07-31	15	1	1	1	Direct Sales	5	5000.00	5.00	23750.00	7500.00	16250.00	Jane Doe	INV-2-00414	Paid	2025-12-13 07:11:45.467881
1015	2	ORD-2-00415	2024-09-01	14	2	5	1	Reseller	3	199.00	5.00	567.15	150.00	417.15	Sarah Wilson	INV-2-00415	Paid	2025-12-13 07:11:45.467881
1016	2	ORD-2-00416	2024-05-28	1	2	2	1	Retail	11	199.00	10.00	1970.10	550.00	1420.10	Lisa Anderson	INV-2-00416	Pending	2025-12-13 07:11:45.467881
1017	2	ORD-2-00417	2024-09-21	15	10	3	1	Retail	8	350.00	5.00	2660.00	960.00	1700.00	John Smith	INV-2-00417	Paid	2025-12-13 07:11:45.467881
1018	2	ORD-2-00418	2023-06-16	4	1	2	1	Reseller	18	5000.00	5.00	85500.00	27000.00	58500.00	Amanda White	INV-2-00418	Paid	2025-12-13 07:11:45.467881
1019	2	ORD-2-00419	2023-04-15	14	8	1	1	Direct Sales	9	500.00	15.00	3825.00	1350.00	2475.00	Sarah Wilson	INV-2-00419	Paid	2025-12-13 07:11:45.467881
1020	2	ORD-2-00420	2024-07-06	10	9	1	1	Online	2	800.00	20.00	1280.00	400.00	880.00	Robert Taylor	INV-2-00420	Paid	2025-12-13 07:11:45.467881
1021	2	ORD-2-00421	2023-09-12	9	10	1	1	Partner	17	350.00	20.00	4760.00	2040.00	2720.00	Jane Doe	INV-2-00421	Overdue	2025-12-13 07:11:45.467881
1022	2	ORD-2-00422	2024-01-21	9	10	3	1	Direct Sales	7	350.00	15.00	2082.50	840.00	1242.50	Mike Johnson	INV-2-00422	Overdue	2025-12-13 07:11:45.467881
1023	2	ORD-2-00423	2023-08-21	2	9	3	1	Reseller	8	800.00	20.00	5120.00	1600.00	3520.00	John Smith	INV-2-00423	Paid	2025-12-13 07:11:45.467881
1024	2	ORD-2-00424	2023-01-04	13	7	3	1	Partner	10	4500.00	0.00	45000.00	15000.00	30000.00	Sarah Wilson	INV-2-00424	Paid	2025-12-13 07:11:45.467881
1025	2	ORD-2-00425	2024-04-02	15	10	4	1	Reseller	4	350.00	15.00	1190.00	480.00	710.00	Emily Davis	INV-2-00425	Paid	2025-12-13 07:11:45.467881
1026	2	ORD-2-00426	2024-03-26	1	4	3	1	Direct Sales	6	3500.00	5.00	19950.00	7200.00	12750.00	Robert Taylor	INV-2-00426	Paid	2025-12-13 07:11:45.467881
1027	2	ORD-2-00427	2024-01-15	8	5	2	1	Online	12	1500.00	5.00	17100.00	4800.00	12300.00	Emily Davis	INV-2-00427	Pending	2025-12-13 07:11:45.467881
1028	2	ORD-2-00428	2024-07-10	14	9	3	1	Retail	11	800.00	10.00	7920.00	2200.00	5720.00	John Smith	INV-2-00428	Paid	2025-12-13 07:11:45.467881
1029	2	ORD-2-00429	2024-03-07	13	10	2	1	Online	7	350.00	0.00	2450.00	840.00	1610.00	Emily Davis	INV-2-00429	Paid	2025-12-13 07:11:45.467881
1030	2	ORD-2-00430	2024-04-16	13	4	1	1	Reseller	16	3500.00	5.00	53200.00	19200.00	34000.00	David Brown	INV-2-00430	Paid	2025-12-13 07:11:45.467881
1031	2	ORD-2-00431	2024-05-13	13	8	1	1	Partner	17	500.00	15.00	7225.00	2550.00	4675.00	Jane Doe	INV-2-00431	Overdue	2025-12-13 07:11:45.467881
1032	2	ORD-2-00432	2023-12-29	13	8	5	1	Reseller	13	500.00	20.00	5200.00	1950.00	3250.00	David Brown	INV-2-00432	Pending	2025-12-13 07:11:45.467881
1033	2	ORD-2-00433	2024-07-15	1	2	1	1	Partner	1	199.00	0.00	199.00	50.00	149.00	Amanda White	INV-2-00433	Paid	2025-12-13 07:11:45.467881
1034	2	ORD-2-00434	2023-09-14	1	3	3	1	Retail	14	2500.00	10.00	31500.00	11200.00	20300.00	Robert Taylor	INV-2-00434	Overdue	2025-12-13 07:11:45.467881
1035	2	ORD-2-00435	2023-07-14	4	9	1	1	Reseller	5	800.00	15.00	3400.00	1000.00	2400.00	Robert Taylor	INV-2-00435	Overdue	2025-12-13 07:11:45.467881
1036	2	ORD-2-00436	2023-04-12	10	7	4	1	Online	8	4500.00	5.00	34200.00	12000.00	22200.00	Robert Taylor	INV-2-00436	Paid	2025-12-13 07:11:45.467881
1037	2	ORD-2-00437	2023-07-15	11	4	5	1	Reseller	6	3500.00	10.00	18900.00	7200.00	11700.00	Sarah Wilson	INV-2-00437	Overdue	2025-12-13 07:11:45.467881
1038	2	ORD-2-00438	2024-12-29	4	9	1	1	Online	16	800.00	5.00	12160.00	3200.00	8960.00	Emily Davis	INV-2-00438	Paid	2025-12-13 07:11:45.467881
1039	2	ORD-2-00439	2023-12-09	3	3	4	1	Reseller	2	2500.00	15.00	4250.00	1600.00	2650.00	Mike Johnson	INV-2-00439	Paid	2025-12-13 07:11:45.467881
1040	2	ORD-2-00440	2023-08-31	4	8	4	1	Reseller	17	500.00	15.00	7225.00	2550.00	4675.00	Lisa Anderson	INV-2-00440	Overdue	2025-12-13 07:11:45.467881
1041	2	ORD-2-00441	2023-12-07	7	10	4	1	Partner	13	350.00	10.00	4095.00	1560.00	2535.00	Amanda White	INV-2-00441	Overdue	2025-12-13 07:11:45.467881
1042	2	ORD-2-00442	2024-03-23	7	6	4	1	Direct Sales	13	2000.00	5.00	24700.00	7800.00	16900.00	Amanda White	INV-2-00442	Pending	2025-12-13 07:11:45.467881
1043	2	ORD-2-00443	2023-03-08	1	1	5	1	Direct Sales	9	5000.00	15.00	38250.00	13500.00	24750.00	Sarah Wilson	INV-2-00443	Overdue	2025-12-13 07:11:45.467881
1044	2	ORD-2-00444	2024-12-30	12	2	5	1	Partner	8	199.00	5.00	1512.40	400.00	1112.40	Lisa Anderson	INV-2-00444	Paid	2025-12-13 07:11:45.467881
1045	2	ORD-2-00445	2023-05-28	9	9	3	1	Partner	9	800.00	10.00	6480.00	1800.00	4680.00	Chris Lee	INV-2-00445	Overdue	2025-12-13 07:11:45.467881
1046	2	ORD-2-00446	2023-09-11	7	9	2	1	Retail	13	800.00	0.00	10400.00	2600.00	7800.00	Chris Lee	INV-2-00446	Paid	2025-12-13 07:11:45.467881
1047	2	ORD-2-00447	2024-10-17	8	6	1	1	Retail	20	2000.00	0.00	40000.00	12000.00	28000.00	Sarah Wilson	INV-2-00447	Paid	2025-12-13 07:11:45.467881
1048	2	ORD-2-00448	2024-03-16	9	7	4	1	Online	20	4500.00	10.00	81000.00	30000.00	51000.00	David Brown	INV-2-00448	Overdue	2025-12-13 07:11:45.467881
1049	2	ORD-2-00449	2024-08-03	14	2	4	1	Partner	1	199.00	0.00	199.00	50.00	149.00	Mike Johnson	INV-2-00449	Paid	2025-12-13 07:11:45.467881
1050	2	ORD-2-00450	2024-04-03	13	6	1	1	Reseller	17	2000.00	20.00	27200.00	10200.00	17000.00	Robert Taylor	INV-2-00450	Paid	2025-12-13 07:11:45.467881
1051	2	ORD-2-00451	2024-10-04	12	3	5	1	Direct Sales	11	2500.00	5.00	26125.00	8800.00	17325.00	Sarah Wilson	INV-2-00451	Paid	2025-12-13 07:11:45.467881
1052	2	ORD-2-00452	2024-11-05	8	10	2	1	Online	19	350.00	5.00	6317.50	2280.00	4037.50	Lisa Anderson	INV-2-00452	Paid	2025-12-13 07:11:45.467881
1053	2	ORD-2-00453	2023-06-12	5	8	1	1	Retail	7	500.00	5.00	3325.00	1050.00	2275.00	Emily Davis	INV-2-00453	Paid	2025-12-13 07:11:45.467881
1054	2	ORD-2-00454	2024-12-29	14	7	4	1	Reseller	8	4500.00	15.00	30600.00	12000.00	18600.00	Chris Lee	INV-2-00454	Paid	2025-12-13 07:11:45.467881
1055	2	ORD-2-00455	2023-03-12	9	4	3	1	Partner	6	3500.00	20.00	16800.00	7200.00	9600.00	Emily Davis	INV-2-00455	Pending	2025-12-13 07:11:45.467881
1056	2	ORD-2-00456	2023-07-16	13	6	1	1	Partner	15	2000.00	10.00	27000.00	9000.00	18000.00	Chris Lee	INV-2-00456	Paid	2025-12-13 07:11:45.467881
1057	2	ORD-2-00457	2024-11-17	15	6	2	1	Retail	14	2000.00	15.00	23800.00	8400.00	15400.00	Chris Lee	INV-2-00457	Pending	2025-12-13 07:11:45.467881
1058	2	ORD-2-00458	2024-06-26	6	4	5	1	Direct Sales	3	3500.00	10.00	9450.00	3600.00	5850.00	John Smith	INV-2-00458	Paid	2025-12-13 07:11:45.467881
1059	2	ORD-2-00459	2023-03-13	8	9	4	1	Direct Sales	6	800.00	15.00	4080.00	1200.00	2880.00	Amanda White	INV-2-00459	Overdue	2025-12-13 07:11:45.467881
1060	2	ORD-2-00460	2024-07-19	5	5	2	1	Reseller	18	1500.00	0.00	27000.00	7200.00	19800.00	Chris Lee	INV-2-00460	Overdue	2025-12-13 07:11:45.467881
1061	2	ORD-2-00461	2023-12-25	6	9	4	1	Retail	2	800.00	20.00	1280.00	400.00	880.00	Sarah Wilson	INV-2-00461	Paid	2025-12-13 07:11:45.467881
1062	2	ORD-2-00462	2023-03-01	9	7	3	1	Online	16	4500.00	15.00	61200.00	24000.00	37200.00	David Brown	INV-2-00462	Overdue	2025-12-13 07:11:45.467881
1063	2	ORD-2-00463	2023-01-28	14	7	4	1	Reseller	13	4500.00	0.00	58500.00	19500.00	39000.00	Chris Lee	INV-2-00463	Overdue	2025-12-13 07:11:45.467881
1064	2	ORD-2-00464	2024-09-25	13	7	2	1	Direct Sales	11	4500.00	15.00	42075.00	16500.00	25575.00	Amanda White	INV-2-00464	Overdue	2025-12-13 07:11:45.467881
1065	2	ORD-2-00465	2023-03-11	14	10	1	1	Partner	4	350.00	15.00	1190.00	480.00	710.00	Jane Doe	INV-2-00465	Pending	2025-12-13 07:11:45.467881
1066	2	ORD-2-00466	2023-11-14	13	7	1	1	Direct Sales	5	4500.00	5.00	21375.00	7500.00	13875.00	Jane Doe	INV-2-00466	Paid	2025-12-13 07:11:45.467881
1067	2	ORD-2-00467	2023-09-15	3	5	3	1	Retail	2	1500.00	15.00	2550.00	800.00	1750.00	Emily Davis	INV-2-00467	Overdue	2025-12-13 07:11:45.467881
1068	2	ORD-2-00468	2023-05-20	14	3	4	1	Partner	2	2500.00	0.00	5000.00	1600.00	3400.00	Amanda White	INV-2-00468	Overdue	2025-12-13 07:11:45.467881
1069	2	ORD-2-00469	2024-11-10	8	1	3	1	Reseller	3	5000.00	15.00	12750.00	4500.00	8250.00	Chris Lee	INV-2-00469	Overdue	2025-12-13 07:11:45.467881
1070	2	ORD-2-00470	2024-02-06	14	5	5	1	Retail	13	1500.00	20.00	15600.00	5200.00	10400.00	Emily Davis	INV-2-00470	Paid	2025-12-13 07:11:45.467881
1071	2	ORD-2-00471	2023-08-25	6	1	4	1	Direct Sales	13	5000.00	15.00	55250.00	19500.00	35750.00	John Smith	INV-2-00471	Paid	2025-12-13 07:11:45.467881
1072	2	ORD-2-00472	2023-03-14	13	3	3	1	Reseller	19	2500.00	10.00	42750.00	15200.00	27550.00	David Brown	INV-2-00472	Overdue	2025-12-13 07:11:45.467881
1073	2	ORD-2-00473	2023-09-17	4	2	3	1	Direct Sales	11	199.00	5.00	2079.55	550.00	1529.55	Chris Lee	INV-2-00473	Paid	2025-12-13 07:11:45.467881
1074	2	ORD-2-00474	2024-12-03	13	6	1	1	Partner	2	2000.00	20.00	3200.00	1200.00	2000.00	Sarah Wilson	INV-2-00474	Pending	2025-12-13 07:11:45.467881
1075	2	ORD-2-00475	2024-05-11	5	2	2	1	Partner	13	199.00	0.00	2587.00	650.00	1937.00	Chris Lee	INV-2-00475	Overdue	2025-12-13 07:11:45.467881
1076	2	ORD-2-00476	2023-10-05	7	10	2	1	Direct Sales	15	350.00	0.00	5250.00	1800.00	3450.00	Jane Doe	INV-2-00476	Paid	2025-12-13 07:11:45.467881
1077	2	ORD-2-00477	2024-12-02	6	8	2	1	Direct Sales	6	500.00	15.00	2550.00	900.00	1650.00	Chris Lee	INV-2-00477	Paid	2025-12-13 07:11:45.467881
1078	2	ORD-2-00478	2023-10-07	11	7	2	1	Reseller	20	4500.00	5.00	85500.00	30000.00	55500.00	Jane Doe	INV-2-00478	Paid	2025-12-13 07:11:45.467881
1079	2	ORD-2-00479	2024-11-25	10	2	5	1	Direct Sales	6	199.00	15.00	1014.90	300.00	714.90	Lisa Anderson	INV-2-00479	Overdue	2025-12-13 07:11:45.467881
1080	2	ORD-2-00480	2024-04-03	12	10	1	1	Online	4	350.00	10.00	1260.00	480.00	780.00	Amanda White	INV-2-00480	Overdue	2025-12-13 07:11:45.467881
1081	2	ORD-2-00481	2023-04-03	12	3	3	1	Direct Sales	4	2500.00	10.00	9000.00	3200.00	5800.00	Emily Davis	INV-2-00481	Pending	2025-12-13 07:11:45.467881
1082	2	ORD-2-00482	2024-03-04	2	3	5	1	Online	14	2500.00	0.00	35000.00	11200.00	23800.00	Robert Taylor	INV-2-00482	Pending	2025-12-13 07:11:45.467881
1083	2	ORD-2-00483	2023-04-26	13	6	2	1	Direct Sales	6	2000.00	15.00	10200.00	3600.00	6600.00	Mike Johnson	INV-2-00483	Pending	2025-12-13 07:11:45.467881
1084	2	ORD-2-00484	2023-12-02	12	4	4	1	Retail	16	3500.00	20.00	44800.00	19200.00	25600.00	Lisa Anderson	INV-2-00484	Paid	2025-12-13 07:11:45.467881
1085	2	ORD-2-00485	2024-06-22	9	5	3	1	Partner	17	1500.00	20.00	20400.00	6800.00	13600.00	Sarah Wilson	INV-2-00485	Paid	2025-12-13 07:11:45.467881
1086	2	ORD-2-00486	2024-05-19	14	7	4	1	Reseller	11	4500.00	20.00	39600.00	16500.00	23100.00	Amanda White	INV-2-00486	Paid	2025-12-13 07:11:45.467881
1087	2	ORD-2-00487	2024-06-05	15	3	4	1	Direct Sales	20	2500.00	10.00	45000.00	16000.00	29000.00	Emily Davis	INV-2-00487	Pending	2025-12-13 07:11:45.467881
1088	2	ORD-2-00488	2023-09-19	14	7	5	1	Retail	2	4500.00	0.00	9000.00	3000.00	6000.00	Emily Davis	INV-2-00488	Paid	2025-12-13 07:11:45.467881
1089	2	ORD-2-00489	2024-05-12	5	2	3	1	Direct Sales	9	199.00	10.00	1611.90	450.00	1161.90	David Brown	INV-2-00489	Pending	2025-12-13 07:11:45.467881
1090	2	ORD-2-00490	2023-03-28	13	4	3	1	Reseller	14	3500.00	20.00	39200.00	16800.00	22400.00	Lisa Anderson	INV-2-00490	Paid	2025-12-13 07:11:45.467881
1091	2	ORD-2-00491	2024-06-15	14	8	5	1	Partner	9	500.00	15.00	3825.00	1350.00	2475.00	Robert Taylor	INV-2-00491	Paid	2025-12-13 07:11:45.467881
1092	2	ORD-2-00492	2023-03-07	11	9	2	1	Direct Sales	1	800.00	10.00	720.00	200.00	520.00	Mike Johnson	INV-2-00492	Paid	2025-12-13 07:11:45.467881
1093	2	ORD-2-00493	2023-05-02	4	3	3	1	Partner	20	2500.00	20.00	40000.00	16000.00	24000.00	Emily Davis	INV-2-00493	Paid	2025-12-13 07:11:45.467881
1094	2	ORD-2-00494	2023-09-18	7	4	1	1	Retail	6	3500.00	0.00	21000.00	7200.00	13800.00	Chris Lee	INV-2-00494	Paid	2025-12-13 07:11:45.467881
1095	2	ORD-2-00495	2024-09-29	15	6	1	1	Partner	6	2000.00	10.00	10800.00	3600.00	7200.00	John Smith	INV-2-00495	Paid	2025-12-13 07:11:45.467881
1096	2	ORD-2-00496	2023-06-18	11	3	2	1	Partner	12	2500.00	10.00	27000.00	9600.00	17400.00	David Brown	INV-2-00496	Paid	2025-12-13 07:11:45.467881
1097	2	ORD-2-00497	2023-08-22	11	1	2	1	Direct Sales	14	5000.00	5.00	66500.00	21000.00	45500.00	Robert Taylor	INV-2-00497	Paid	2025-12-13 07:11:45.467881
1098	2	ORD-2-00498	2024-01-10	4	5	1	1	Direct Sales	15	1500.00	15.00	19125.00	6000.00	13125.00	Mike Johnson	INV-2-00498	Overdue	2025-12-13 07:11:45.467881
1099	2	ORD-2-00499	2023-08-25	15	9	3	1	Retail	2	800.00	0.00	1600.00	400.00	1200.00	Sarah Wilson	INV-2-00499	Paid	2025-12-13 07:11:45.467881
1100	2	ORD-2-00500	2024-05-31	15	8	3	1	Retail	17	500.00	20.00	6800.00	2550.00	4250.00	Jane Doe	INV-2-00500	Paid	2025-12-13 07:11:45.467881
1101	2	ORD-2-00501	2023-11-23	11	3	1	1	Retail	15	2500.00	5.00	35625.00	12000.00	23625.00	Chris Lee	INV-2-00501	Paid	2025-12-13 07:11:45.467881
1102	2	ORD-2-00502	2024-12-13	15	8	3	1	Direct Sales	17	500.00	0.00	8500.00	2550.00	5950.00	Chris Lee	INV-2-00502	Paid	2025-12-13 07:11:45.467881
1103	2	ORD-2-00503	2024-11-10	8	8	3	1	Partner	11	500.00	20.00	4400.00	1650.00	2750.00	Sarah Wilson	INV-2-00503	Paid	2025-12-13 07:11:45.467881
1104	2	ORD-2-00504	2024-07-05	1	5	4	1	Partner	15	1500.00	5.00	21375.00	6000.00	15375.00	David Brown	INV-2-00504	Paid	2025-12-13 07:11:45.467881
1105	2	ORD-2-00505	2024-11-09	1	8	3	1	Online	19	500.00	10.00	8550.00	2850.00	5700.00	John Smith	INV-2-00505	Paid	2025-12-13 07:11:45.467881
1106	2	ORD-2-00506	2024-10-17	9	7	1	1	Retail	10	4500.00	15.00	38250.00	15000.00	23250.00	Sarah Wilson	INV-2-00506	Pending	2025-12-13 07:11:45.467881
1107	2	ORD-2-00507	2024-03-28	11	8	1	1	Online	13	500.00	0.00	6500.00	1950.00	4550.00	Emily Davis	INV-2-00507	Paid	2025-12-13 07:11:45.467881
1108	2	ORD-2-00508	2023-04-27	6	9	2	1	Online	15	800.00	5.00	11400.00	3000.00	8400.00	David Brown	INV-2-00508	Paid	2025-12-13 07:11:45.467881
1109	2	ORD-2-00509	2023-12-14	4	4	4	1	Reseller	5	3500.00	15.00	14875.00	6000.00	8875.00	Mike Johnson	INV-2-00509	Paid	2025-12-13 07:11:45.467881
1110	2	ORD-2-00510	2023-04-28	11	6	2	1	Online	7	2000.00	10.00	12600.00	4200.00	8400.00	Robert Taylor	INV-2-00510	Pending	2025-12-13 07:11:45.467881
1111	2	ORD-2-00511	2024-02-09	14	8	4	1	Partner	11	500.00	0.00	5500.00	1650.00	3850.00	Sarah Wilson	INV-2-00511	Paid	2025-12-13 07:11:45.467881
1112	2	ORD-2-00512	2023-01-13	7	3	4	1	Retail	9	2500.00	15.00	19125.00	7200.00	11925.00	Chris Lee	INV-2-00512	Overdue	2025-12-13 07:11:45.467881
1113	2	ORD-2-00513	2023-07-10	8	5	5	1	Retail	13	1500.00	0.00	19500.00	5200.00	14300.00	Emily Davis	INV-2-00513	Paid	2025-12-13 07:11:45.467881
1114	2	ORD-2-00514	2023-01-17	9	2	5	1	Online	13	199.00	15.00	2198.95	650.00	1548.95	Jane Doe	INV-2-00514	Overdue	2025-12-13 07:11:45.467881
1115	2	ORD-2-00515	2024-11-17	13	3	5	1	Online	13	2500.00	0.00	32500.00	10400.00	22100.00	Chris Lee	INV-2-00515	Paid	2025-12-13 07:11:45.467881
1116	2	ORD-2-00516	2023-11-22	8	8	3	1	Online	20	500.00	5.00	9500.00	3000.00	6500.00	Emily Davis	INV-2-00516	Paid	2025-12-13 07:11:45.467881
1117	2	ORD-2-00517	2023-02-13	2	9	3	1	Reseller	19	800.00	5.00	14440.00	3800.00	10640.00	Emily Davis	INV-2-00517	Pending	2025-12-13 07:11:45.467881
1118	2	ORD-2-00518	2024-09-27	15	10	1	1	Online	19	350.00	10.00	5985.00	2280.00	3705.00	Lisa Anderson	INV-2-00518	Overdue	2025-12-13 07:11:45.467881
1119	2	ORD-2-00519	2023-10-12	8	9	2	1	Retail	8	800.00	0.00	6400.00	1600.00	4800.00	Chris Lee	INV-2-00519	Pending	2025-12-13 07:11:45.467881
1120	2	ORD-2-00520	2023-10-29	13	3	4	1	Reseller	18	2500.00	20.00	36000.00	14400.00	21600.00	John Smith	INV-2-00520	Overdue	2025-12-13 07:11:45.467881
1121	2	ORD-2-00521	2023-07-27	11	4	3	1	Online	19	3500.00	15.00	56525.00	22800.00	33725.00	Sarah Wilson	INV-2-00521	Pending	2025-12-13 07:11:45.467881
1122	2	ORD-2-00522	2023-03-02	14	2	4	1	Partner	8	199.00	20.00	1273.60	400.00	873.60	Emily Davis	INV-2-00522	Overdue	2025-12-13 07:11:45.467881
1123	2	ORD-2-00523	2023-06-08	4	10	2	1	Reseller	3	350.00	0.00	1050.00	360.00	690.00	Lisa Anderson	INV-2-00523	Paid	2025-12-13 07:11:45.467881
1124	2	ORD-2-00524	2024-01-22	4	7	4	1	Retail	4	4500.00	0.00	18000.00	6000.00	12000.00	Amanda White	INV-2-00524	Paid	2025-12-13 07:11:45.467881
1125	2	ORD-2-00525	2023-07-20	9	4	5	1	Direct Sales	8	3500.00	5.00	26600.00	9600.00	17000.00	John Smith	INV-2-00525	Paid	2025-12-13 07:11:45.467881
1126	2	ORD-2-00526	2024-09-03	15	9	4	1	Retail	3	800.00	20.00	1920.00	600.00	1320.00	David Brown	INV-2-00526	Pending	2025-12-13 07:11:45.467881
1127	2	ORD-2-00527	2023-03-27	15	1	1	1	Partner	18	5000.00	0.00	90000.00	27000.00	63000.00	Mike Johnson	INV-2-00527	Paid	2025-12-13 07:11:45.467881
1128	2	ORD-2-00528	2023-06-22	10	5	3	1	Online	13	1500.00	10.00	17550.00	5200.00	12350.00	Jane Doe	INV-2-00528	Pending	2025-12-13 07:11:45.467881
1129	2	ORD-2-00529	2024-08-07	12	8	5	1	Reseller	12	500.00	5.00	5700.00	1800.00	3900.00	Amanda White	INV-2-00529	Paid	2025-12-13 07:11:45.467881
1130	2	ORD-2-00530	2024-02-10	15	7	2	1	Online	17	4500.00	10.00	68850.00	25500.00	43350.00	John Smith	INV-2-00530	Paid	2025-12-13 07:11:45.467881
1131	2	ORD-2-00531	2023-10-20	12	1	2	1	Direct Sales	3	5000.00	0.00	15000.00	4500.00	10500.00	Amanda White	INV-2-00531	Overdue	2025-12-13 07:11:45.467881
1132	2	ORD-2-00532	2023-01-22	15	9	1	1	Partner	13	800.00	15.00	8840.00	2600.00	6240.00	Jane Doe	INV-2-00532	Paid	2025-12-13 07:11:45.467881
1133	2	ORD-2-00533	2024-04-01	15	10	1	1	Direct Sales	2	350.00	0.00	700.00	240.00	460.00	John Smith	INV-2-00533	Paid	2025-12-13 07:11:45.467881
1134	2	ORD-2-00534	2023-01-18	4	2	4	1	Reseller	2	199.00	0.00	398.00	100.00	298.00	Sarah Wilson	INV-2-00534	Paid	2025-12-13 07:11:45.467881
1135	2	ORD-2-00535	2023-06-08	5	5	3	1	Online	16	1500.00	20.00	19200.00	6400.00	12800.00	Emily Davis	INV-2-00535	Paid	2025-12-13 07:11:45.467881
1136	2	ORD-2-00536	2024-09-20	13	8	5	1	Retail	13	500.00	10.00	5850.00	1950.00	3900.00	Jane Doe	INV-2-00536	Paid	2025-12-13 07:11:45.467881
1137	2	ORD-2-00537	2023-08-09	6	7	3	1	Direct Sales	19	4500.00	10.00	76950.00	28500.00	48450.00	Mike Johnson	INV-2-00537	Paid	2025-12-13 07:11:45.467881
1138	2	ORD-2-00538	2023-08-18	2	1	1	1	Reseller	4	5000.00	20.00	16000.00	6000.00	10000.00	Sarah Wilson	INV-2-00538	Paid	2025-12-13 07:11:45.467881
1139	2	ORD-2-00539	2024-07-30	5	10	2	1	Direct Sales	3	350.00	5.00	997.50	360.00	637.50	Sarah Wilson	INV-2-00539	Paid	2025-12-13 07:11:45.467881
1140	2	ORD-2-00540	2023-03-28	4	8	2	1	Reseller	5	500.00	0.00	2500.00	750.00	1750.00	Amanda White	INV-2-00540	Paid	2025-12-13 07:11:45.467881
1141	2	ORD-2-00541	2024-07-29	14	2	3	1	Direct Sales	16	199.00	5.00	3024.80	800.00	2224.80	Lisa Anderson	INV-2-00541	Paid	2025-12-13 07:11:45.467881
1142	2	ORD-2-00542	2024-08-19	12	6	4	1	Retail	12	2000.00	0.00	24000.00	7200.00	16800.00	David Brown	INV-2-00542	Paid	2025-12-13 07:11:45.467881
1143	2	ORD-2-00543	2024-12-21	3	4	4	1	Reseller	6	3500.00	10.00	18900.00	7200.00	11700.00	Jane Doe	INV-2-00543	Paid	2025-12-13 07:11:45.467881
1144	2	ORD-2-00544	2023-10-03	3	1	4	1	Direct Sales	9	5000.00	0.00	45000.00	13500.00	31500.00	Jane Doe	INV-2-00544	Overdue	2025-12-13 07:11:45.467881
1145	2	ORD-2-00545	2024-04-22	1	4	5	1	Reseller	1	3500.00	20.00	2800.00	1200.00	1600.00	David Brown	INV-2-00545	Overdue	2025-12-13 07:11:45.467881
1146	2	ORD-2-00546	2024-06-18	13	8	3	1	Reseller	15	500.00	0.00	7500.00	2250.00	5250.00	Emily Davis	INV-2-00546	Paid	2025-12-13 07:11:45.467881
1147	2	ORD-2-00547	2023-04-04	1	10	5	1	Retail	15	350.00	5.00	4987.50	1800.00	3187.50	Robert Taylor	INV-2-00547	Overdue	2025-12-13 07:11:45.467881
1148	2	ORD-2-00548	2024-04-05	12	3	2	1	Retail	14	2500.00	20.00	28000.00	11200.00	16800.00	Amanda White	INV-2-00548	Pending	2025-12-13 07:11:45.467881
1149	2	ORD-2-00549	2023-03-13	13	4	2	1	Retail	16	3500.00	20.00	44800.00	19200.00	25600.00	Robert Taylor	INV-2-00549	Pending	2025-12-13 07:11:45.467881
1150	2	ORD-2-00550	2023-05-22	11	7	1	1	Online	12	4500.00	0.00	54000.00	18000.00	36000.00	David Brown	INV-2-00550	Paid	2025-12-13 07:11:45.467881
1151	2	ORD-2-00551	2024-04-09	13	7	2	1	Retail	7	4500.00	15.00	26775.00	10500.00	16275.00	Chris Lee	INV-2-00551	Paid	2025-12-13 07:11:45.467881
1152	2	ORD-2-00552	2023-12-17	11	8	3	1	Online	16	500.00	5.00	7600.00	2400.00	5200.00	Emily Davis	INV-2-00552	Pending	2025-12-13 07:11:45.467881
1153	2	ORD-2-00553	2024-10-10	12	6	3	1	Direct Sales	6	2000.00	5.00	11400.00	3600.00	7800.00	Mike Johnson	INV-2-00553	Overdue	2025-12-13 07:11:45.467881
1154	2	ORD-2-00554	2023-11-11	9	3	5	1	Online	13	2500.00	15.00	27625.00	10400.00	17225.00	David Brown	INV-2-00554	Overdue	2025-12-13 07:11:45.467881
1155	2	ORD-2-00555	2024-07-12	12	6	5	1	Reseller	14	2000.00	15.00	23800.00	8400.00	15400.00	Amanda White	INV-2-00555	Paid	2025-12-13 07:11:45.467881
1156	2	ORD-2-00556	2024-04-19	5	5	4	1	Online	14	1500.00	15.00	17850.00	5600.00	12250.00	Robert Taylor	INV-2-00556	Overdue	2025-12-13 07:11:45.467881
1157	2	ORD-2-00557	2024-04-08	10	6	1	1	Retail	19	2000.00	5.00	36100.00	11400.00	24700.00	Robert Taylor	INV-2-00557	Pending	2025-12-13 07:11:45.467881
1158	2	ORD-2-00558	2023-01-03	13	8	3	1	Partner	14	500.00	20.00	5600.00	2100.00	3500.00	Mike Johnson	INV-2-00558	Paid	2025-12-13 07:11:45.467881
1159	2	ORD-2-00559	2023-03-20	10	3	2	1	Online	13	2500.00	10.00	29250.00	10400.00	18850.00	Lisa Anderson	INV-2-00559	Pending	2025-12-13 07:11:45.467881
1160	2	ORD-2-00560	2023-08-07	2	4	1	1	Reseller	19	3500.00	10.00	59850.00	22800.00	37050.00	Emily Davis	INV-2-00560	Paid	2025-12-13 07:11:45.467881
1161	2	ORD-2-00561	2023-08-06	13	9	3	1	Direct Sales	15	800.00	5.00	11400.00	3000.00	8400.00	Jane Doe	INV-2-00561	Paid	2025-12-13 07:11:45.467881
1162	2	ORD-2-00562	2023-03-31	10	8	2	1	Online	9	500.00	15.00	3825.00	1350.00	2475.00	Amanda White	INV-2-00562	Paid	2025-12-13 07:11:45.467881
1163	2	ORD-2-00563	2023-01-16	1	9	1	1	Online	13	800.00	5.00	9880.00	2600.00	7280.00	Jane Doe	INV-2-00563	Paid	2025-12-13 07:11:45.467881
1164	2	ORD-2-00564	2023-05-03	5	1	5	1	Online	17	5000.00	10.00	76500.00	25500.00	51000.00	Amanda White	INV-2-00564	Paid	2025-12-13 07:11:45.467881
1165	2	ORD-2-00565	2023-11-17	7	10	2	1	Reseller	18	350.00	0.00	6300.00	2160.00	4140.00	Emily Davis	INV-2-00565	Paid	2025-12-13 07:11:45.467881
1166	2	ORD-2-00566	2023-01-30	14	1	2	1	Online	12	5000.00	20.00	48000.00	18000.00	30000.00	Emily Davis	INV-2-00566	Paid	2025-12-13 07:11:45.467881
1167	2	ORD-2-00567	2023-11-03	6	6	5	1	Direct Sales	15	2000.00	20.00	24000.00	9000.00	15000.00	Robert Taylor	INV-2-00567	Overdue	2025-12-13 07:11:45.467881
1168	2	ORD-2-00568	2024-07-28	12	5	5	1	Retail	17	1500.00	20.00	20400.00	6800.00	13600.00	Jane Doe	INV-2-00568	Overdue	2025-12-13 07:11:45.467881
1169	2	ORD-2-00569	2023-03-13	8	2	1	1	Retail	4	199.00	10.00	716.40	200.00	516.40	John Smith	INV-2-00569	Paid	2025-12-13 07:11:45.467881
1170	2	ORD-2-00570	2024-04-08	3	3	3	1	Online	5	2500.00	20.00	10000.00	4000.00	6000.00	Amanda White	INV-2-00570	Paid	2025-12-13 07:11:45.467881
1171	2	ORD-2-00571	2023-02-14	2	9	4	1	Online	16	800.00	20.00	10240.00	3200.00	7040.00	Lisa Anderson	INV-2-00571	Paid	2025-12-13 07:11:45.467881
1172	2	ORD-2-00572	2023-03-21	5	1	4	1	Reseller	6	5000.00	15.00	25500.00	9000.00	16500.00	Amanda White	INV-2-00572	Pending	2025-12-13 07:11:45.467881
1173	2	ORD-2-00573	2023-04-19	2	5	2	1	Direct Sales	20	1500.00	0.00	30000.00	8000.00	22000.00	Jane Doe	INV-2-00573	Paid	2025-12-13 07:11:45.467881
1174	2	ORD-2-00574	2024-02-10	9	10	2	1	Retail	6	350.00	5.00	1995.00	720.00	1275.00	Lisa Anderson	INV-2-00574	Paid	2025-12-13 07:11:45.467881
1175	2	ORD-2-00575	2024-06-24	10	6	3	1	Partner	9	2000.00	10.00	16200.00	5400.00	10800.00	John Smith	INV-2-00575	Paid	2025-12-13 07:11:45.467881
1176	2	ORD-2-00576	2023-10-27	4	9	3	1	Reseller	1	800.00	5.00	760.00	200.00	560.00	John Smith	INV-2-00576	Overdue	2025-12-13 07:11:45.467881
1177	2	ORD-2-00577	2023-09-21	12	2	4	1	Online	13	199.00	20.00	2069.60	650.00	1419.60	Lisa Anderson	INV-2-00577	Paid	2025-12-13 07:11:45.467881
1178	2	ORD-2-00578	2023-09-05	11	3	4	1	Online	17	2500.00	15.00	36125.00	13600.00	22525.00	Jane Doe	INV-2-00578	Paid	2025-12-13 07:11:45.467881
1179	2	ORD-2-00579	2024-02-19	3	9	3	1	Retail	19	800.00	5.00	14440.00	3800.00	10640.00	John Smith	INV-2-00579	Overdue	2025-12-13 07:11:45.467881
1180	2	ORD-2-00580	2024-09-27	2	3	3	1	Reseller	11	2500.00	15.00	23375.00	8800.00	14575.00	Lisa Anderson	INV-2-00580	Paid	2025-12-13 07:11:45.467881
1181	2	ORD-2-00581	2023-10-14	2	3	1	1	Online	13	2500.00	15.00	27625.00	10400.00	17225.00	David Brown	INV-2-00581	Paid	2025-12-13 07:11:45.467881
1182	2	ORD-2-00582	2023-12-21	4	2	1	1	Direct Sales	8	199.00	20.00	1273.60	400.00	873.60	Robert Taylor	INV-2-00582	Pending	2025-12-13 07:11:45.467881
1183	2	ORD-2-00583	2023-11-14	7	8	5	1	Retail	7	500.00	5.00	3325.00	1050.00	2275.00	Robert Taylor	INV-2-00583	Paid	2025-12-13 07:11:45.467881
1184	2	ORD-2-00584	2023-12-28	11	2	2	1	Online	7	199.00	15.00	1184.05	350.00	834.05	Lisa Anderson	INV-2-00584	Paid	2025-12-13 07:11:45.467881
1185	2	ORD-2-00585	2024-09-20	2	5	1	1	Direct Sales	5	1500.00	20.00	6000.00	2000.00	4000.00	Sarah Wilson	INV-2-00585	Paid	2025-12-13 07:11:45.467881
1186	2	ORD-2-00586	2023-08-27	14	3	2	1	Online	2	2500.00	0.00	5000.00	1600.00	3400.00	David Brown	INV-2-00586	Paid	2025-12-13 07:11:45.467881
1187	2	ORD-2-00587	2023-08-18	2	6	1	1	Retail	4	2000.00	20.00	6400.00	2400.00	4000.00	David Brown	INV-2-00587	Pending	2025-12-13 07:11:45.467881
1188	2	ORD-2-00588	2023-12-24	2	10	2	1	Online	8	350.00	0.00	2800.00	960.00	1840.00	Lisa Anderson	INV-2-00588	Pending	2025-12-13 07:11:45.467881
1189	2	ORD-2-00589	2024-11-15	7	9	2	1	Reseller	5	800.00	15.00	3400.00	1000.00	2400.00	Jane Doe	INV-2-00589	Paid	2025-12-13 07:11:45.467881
1190	2	ORD-2-00590	2023-03-23	1	3	4	1	Retail	2	2500.00	0.00	5000.00	1600.00	3400.00	Emily Davis	INV-2-00590	Pending	2025-12-13 07:11:45.467881
1191	2	ORD-2-00591	2024-08-31	11	1	4	1	Online	15	5000.00	10.00	67500.00	22500.00	45000.00	John Smith	INV-2-00591	Pending	2025-12-13 07:11:45.467881
1192	2	ORD-2-00592	2024-03-11	8	4	5	1	Partner	14	3500.00	15.00	41650.00	16800.00	24850.00	Emily Davis	INV-2-00592	Paid	2025-12-13 07:11:45.467881
1193	2	ORD-2-00593	2023-03-21	10	5	5	1	Retail	3	1500.00	15.00	3825.00	1200.00	2625.00	Chris Lee	INV-2-00593	Overdue	2025-12-13 07:11:45.467881
1194	2	ORD-2-00594	2024-07-31	5	2	2	1	Online	1	199.00	15.00	169.15	50.00	119.15	Chris Lee	INV-2-00594	Pending	2025-12-13 07:11:45.467881
1195	2	ORD-2-00595	2024-01-21	6	7	5	1	Direct Sales	4	4500.00	5.00	17100.00	6000.00	11100.00	Mike Johnson	INV-2-00595	Paid	2025-12-13 07:11:45.467881
1196	2	ORD-2-00596	2023-12-31	11	10	1	1	Direct Sales	11	350.00	0.00	3850.00	1320.00	2530.00	Emily Davis	INV-2-00596	Pending	2025-12-13 07:11:45.467881
1197	2	ORD-2-00597	2023-09-07	14	6	1	1	Reseller	15	2000.00	15.00	25500.00	9000.00	16500.00	Amanda White	INV-2-00597	Pending	2025-12-13 07:11:45.467881
1198	2	ORD-2-00598	2024-03-18	7	2	3	1	Online	9	199.00	0.00	1791.00	450.00	1341.00	Jane Doe	INV-2-00598	Overdue	2025-12-13 07:11:45.467881
1199	2	ORD-2-00599	2024-06-15	1	1	3	1	Reseller	18	5000.00	15.00	76500.00	27000.00	49500.00	Jane Doe	INV-2-00599	Paid	2025-12-13 07:11:45.467881
1200	2	ORD-2-00600	2024-05-27	5	1	1	1	Partner	16	5000.00	0.00	80000.00	24000.00	56000.00	Amanda White	INV-2-00600	Overdue	2025-12-13 07:11:45.467881
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, tenant_id, user_id, title, is_active, created_at, updated_at) FROM stdin;
2	4	6	whatwhat arewhat are thewhat are the totalwhat are	0	2025-12-13 06:46:23.754498	2025-12-13 06:50:46.828181
3	4	6	21323232r33232	1	2025-12-13 06:51:28.21729	2025-12-13 06:51:28.217292
4	3	7	What are the total sales by category?	1	2025-12-13 06:54:03.382422	2025-12-13 06:54:03.382424
5	3	7	Compare sales performance across regions	1	2025-12-13 06:54:21.795083	2025-12-13 06:54:21.795084
6	5	8	What are the total sales by category?	1	2025-12-13 06:56:55.772645	2025-12-13 06:56:55.772647
7	5	8	what table u currently have	1	2025-12-13 07:02:23.537805	2025-12-13 07:02:23.537807
8	1	1	Show me monthly sales trend for 2024	1	2025-12-13 07:14:17.040498	2025-12-13 07:14:17.0405
13	1	1	Show total sales by month in 2024	1	2025-12-13 07:44:53.44567	2025-12-13 07:44:53.445673
14	5	8	show me list of table you have?	1	2025-12-13 07:45:33.476503	2025-12-13 07:45:33.476505
15	1	1	What are the total sales by category?	1	2025-12-13 07:47:04.026775	2025-12-13 07:47:04.026777
16	4	6	what table currently you have	1	2025-12-13 07:49:50.085854	2025-12-13 07:49:50.085856
17	1	1	What are the total sales by category?	1	2025-12-13 07:55:40.665865	2025-12-13 07:55:40.665867
18	1	1	Show total sales by month in 2024	1	2025-12-13 08:07:20.224937	2025-12-13 08:07:20.224939
20	1	1	What are the total sales by category?	1	2025-12-13 08:31:00.376897	2025-12-13 08:31:00.376898
1	1	1	What are the total sales by category?	0	2025-12-13 06:39:59.271799	2025-12-13 09:43:13.927887
10	1	1	What are the total sales by category?	0	2025-12-13 07:25:42.566288	2025-12-13 09:43:16.092778
11	1	1	Show me monthly sales trend for 2024	0	2025-12-13 07:31:49.914688	2025-12-13 09:43:20.821566
12	1	1	What are the total sales by category?	0	2025-12-13 07:38:48.136584	2025-12-13 09:43:22.781283
9	1	1	What are the total sales by category?	0	2025-12-13 07:25:06.854072	2025-12-13 09:43:24.774388
23	1	1	Which products have the highest revenue?	1	2025-12-13 09:44:17.370515	2025-12-13 09:44:17.370517
25	4	6	what are the total sales by category	1	2025-12-13 10:11:13.471521	2025-12-13 10:11:13.471523
24	1	1	What are the total sales by category?	0	2025-12-13 10:06:11.073816	2025-12-13 10:12:53.216453
21	1	1	Show total revenue by month for the last 12 months	0	2025-12-13 09:12:28.752649	2025-12-13 10:13:02.580234
22	1	1	What are the total sales by category?	0	2025-12-13 09:42:54.278388	2025-12-13 10:13:04.142872
19	1	1	Show expenses by mothn for 2024	0	2025-12-13 08:30:05.60551	2025-12-13 10:13:05.775527
30	4	6	provide expences per month for 2024 show	1	2025-12-13 10:25:35.828963	2025-12-13 10:25:35.828965
27	1	1	show expences per month for 2024	0	2025-12-13 10:17:26.757222	2025-12-13 10:36:12.771783
34	1	1	Which products have the highest revenue?	0	2025-12-13 10:35:43.95387	2025-12-13 10:36:21.760959
33	1	1	provide expences per month for 2024 show	0	2025-12-13 10:29:11.126898	2025-12-13 10:36:54.099769
32	1	1	provide expences per month for 2024 show	0	2025-12-13 10:28:53.825174	2025-12-13 10:36:55.993413
31	1	1	provide expences per month for 2024 show	0	2025-12-13 10:26:09.713711	2025-12-13 10:36:56.89874
29	1	1	Show me the trend of orders over the last 6 months	0	2025-12-13 10:23:40.348377	2025-12-13 10:36:57.924613
28	1	1	provide expences per month for 2024 show	0	2025-12-13 10:19:19.286616	2025-12-13 10:36:59.308667
26	1	1	provide expences per month for 2024 total	0	2025-12-13 10:12:06.876992	2025-12-13 10:37:02.854369
35	1	1	What are the total sales by category?	1	2025-12-13 10:37:20.544626	2025-12-13 10:37:20.544628
36	1	1	What are the total sales by category?	1	2025-12-13 10:42:17.579097	2025-12-13 10:42:17.5791
37	1	1	Which products have the highest revenue?	1	2025-12-13 10:42:48.032681	2025-12-13 10:42:48.032683
38	1	1	Show me the trend of orders over the last 6 months	1	2025-12-13 10:45:33.755614	2025-12-13 10:45:33.755615
39	1	1	Show sales trend by month for 2023	1	2025-12-13 11:03:36.965614	2025-12-13 11:03:36.965616
40	5	8	Top 10 sale product list last month.	1	2025-12-13 11:04:06.54804	2025-12-13 11:04:06.548046
41	1	1	give me top 10 list of last month sale product	1	2025-12-13 11:05:19.901145	2025-12-13 11:05:19.901147
42	1	1	Compare 2023 vs 2024 sales performance	1	2025-12-13 11:08:03.474326	2025-12-13 11:08:03.474327
43	1	1	Show sales trend by month for 2023	1	2025-12-13 11:10:15.443798	2025-12-13 11:10:15.4438
44	1	1	Show sales trend by month for 2023	1	2025-12-13 11:11:54.380773	2025-12-13 11:11:54.380775
45	1	1	Show sales trend by month for 2023	1	2025-12-13 11:19:28.860537	2025-12-13 11:19:28.860646
46	1	1	Show sales trend by month for 2023	1	2025-12-13 11:20:18.251621	2025-12-13 11:20:18.251623
47	1	1	Total expenses by category	1	2025-12-13 11:31:41.156131	2025-12-13 11:31:41.156134
48	1	1	Total expenses by category	1	2025-12-13 11:39:36.506921	2025-12-13 11:39:36.506922
49	1	1	Show me monthly expenses for 2024	1	2025-12-13 11:44:28.336589	2025-12-13 11:44:28.336592
51	1	1	Show me monthly expenses for 2024	1	2025-12-13 11:45:00.625622	2025-12-13 11:45:00.625624
50	1	1	top 10 products revenue in 2024	0	2025-12-13 11:44:46.34151	2025-12-13 11:45:03.244835
52	1	1	Show sales trend by month for 2023	1	2025-12-13 11:52:25.990379	2025-12-13 11:52:25.990381
53	1	1	show sales trends by month for 2023	1	2025-12-13 14:00:44.063946	2025-12-13 14:00:44.063949
54	1	1	Compare 2023 vs 2024 sales performance	1	2025-12-15 08:12:48.412527	2025-12-15 08:12:48.412532
55	1	1	Show me monthly expenses for 2024	1	2025-12-15 08:27:57.429927	2025-12-15 08:27:57.429929
\.


--
-- Data for Name: data_sources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_sources (id, tenant_id, name, db_type, connection_string, schema_info, tables_info, is_active, is_read_only, created_at, updated_at) FROM stdin;
1	1	Enterprise Analytics Database	postgresql	current_database	Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024	{\n        "tables": [\n            {"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status"]},\n            {"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name"]},\n            {"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit"]},\n            {"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price"]},\n            {"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name"]},\n            {"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country"]},\n            {"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining"]},\n            {"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda"]}\n        ]\n    }	t	t	\N	\N
2	2	Enterprise Analytics Database	postgresql	current_database	Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024	{\n        "tables": [\n            {"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status"]},\n            {"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name"]},\n            {"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit"]},\n            {"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price"]},\n            {"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name"]},\n            {"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country"]},\n            {"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining"]},\n            {"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda"]}\n        ]\n    }	t	t	\N	\N
3	3	Enterprise Analytics Database	postgresql	current_database	Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024	{"tables": [{"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status", "tenant_id"]},{"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name", "tenant_id"]},{"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit", "tenant_id"]},{"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price", "tenant_id"]},{"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name", "tenant_id"]},{"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country", "tenant_id"]},{"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining", "tenant_id"]},{"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda", "tenant_id"]}]}	t	t	\N	\N
4	4	Enterprise Analytics Database	postgresql	current_database	Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024	{"tables": [{"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status", "tenant_id"]},{"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name", "tenant_id"]},{"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit", "tenant_id"]},{"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price", "tenant_id"]},{"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name", "tenant_id"]},{"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country", "tenant_id"]},{"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining", "tenant_id"]},{"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda", "tenant_id"]}]}	t	t	\N	\N
5	5	Enterprise Analytics Database	postgresql	current_database	Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024	{"tables": [{"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status", "tenant_id"]},{"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name", "tenant_id"]},{"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit", "tenant_id"]},{"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price", "tenant_id"]},{"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name", "tenant_id"]},{"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country", "tenant_id"]},{"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining", "tenant_id"]},{"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda", "tenant_id"]}]}	t	t	\N	\N
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, conversation_id, role, content, query_type, generated_query, query_result, chart_type, chart_data, insights, user_rating, user_feedback, execution_time_ms, created_at) FROM stdin;
1	1	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:39:59.296972
2	1	assistant	I don't see 'sales' or 'category' in the available database schema. Could you please specify which tables or columns contain this information?	\N	\N	\N	\N	\N	\N	1	u did not give a result 	\N	2025-12-13 06:40:05.509295
3	2	user	whatwhat arewhat are thewhat are the totalwhat are the totalwhat are the totalwhat are the total Sawhat are the total saleswhat are the total saleswhat are the total sales bywhat are the total sales by CAwhat are the total sales by Catewhat are the total sales by categwhat are the total sales by categorywhat are the total sales by categorywhat are the total sales by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:46:23.779406
4	2	assistant	The current database schema does not contain information about 'sales' or 'category'. Could you please specify which tables contain this data, or if you were referring to a different kind of metric or grouping available in the current tables?	\N	\N	\N	\N	\N	\N	1	Not useful	\N	2025-12-13 06:46:26.293934
5	3	user	21323232r33232	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:51:28.243526
6	3	assistant	I couldn't understand your query. Could you please rephrase what information you are looking for?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:51:30.508394
7	4	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:54:03.390256
8	4	assistant	The available schema does not contain information about 'sales' or 'category'. Could you please specify which tables or columns refer to 'sales' and 'category', or are you looking for a different kind of information?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:54:06.137182
9	5	user	Compare sales performance across regions	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:54:21.820787
10	5	assistant	The current database schema does not contain information about 'sales performance' or 'regions'. Could you please specify which tables or columns might contain this data, or provide more context on how these should be defined?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:54:28.988293
11	6	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:56:55.781541
12	6	assistant	I don't see information about 'sales' or 'category' in the available tables. Could you specify which tables or columns refer to sales and categories, or if you meant something else?	\N	\N	\N	\N	\N	\N	4	\N	\N	2025-12-13 06:56:59.423215
13	6	user	Give me result, Here there is no result.	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 06:57:21.930977
14	6	assistant	It seems you are asking for a result and then stating there isn't one. Could you please clarify what you mean by 'result' and what task you'd like me to perform?	\N	\N	\N	\N	\N	\N	5	Fine	\N	2025-12-13 06:57:25.042819
15	6	user	kjdkjs	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:00:06.725269
16	6	assistant	I couldn't understand your query. Could you please rephrase it or provide more details on what you're looking for?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:00:08.175343
17	6	user	ghjk	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:00:20.70215
18	6	assistant	I couldn't understand your query. Could you please rephrase it or provide more context?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:00:21.714379
19	7	user	what table u currently have	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:02:23.582263
20	7	assistant	The system currently has 6 tables: `users`, `tenants`, `organizations`, `conversations`, `messages`, and `nlq_memories`. These tables collectively suggest a multi-tenant application that handles user and organizational data, includes a communication or messaging feature, and notably, incorporates advanced Natural Language Query (NLQ) capabilities, likely for storing interaction context or historical NLQ data.	sql	SELECT 'users' AS table_name\nUNION ALL\nSELECT 'tenants'\nUNION ALL\nSELECT 'organizations'\nUNION ALL\nSELECT 'conversations'\nUNION ALL\nSELECT 'messages'\nUNION ALL\nSELECT 'nlq_memories';	\N	table	{"data": [{"table_name": "users"}, {"table_name": "tenants"}, {"table_name": "organizations"}, {"table_name": "conversations"}, {"table_name": "messages"}, {"table_name": "nlq_memories"}], "config": {"x_axis": null, "y_axis": ["table_name"], "series": null, "colors": null, "title": "Available Tables"}}	[{"title": "Core Application Entities Identified", "description": "The presence of `users`, `tenants`, and `organizations` tables indicates that the system manages fundamental application entities. This suggests a structure for user management, potentially within a multi-tenant environment, and grouping users into organizations.", "importance": "high"}, {"title": "Communication and Messaging Feature", "description": "The `conversations` and `messages` tables strongly suggest that the application includes a communication or messaging feature, allowing users to interact directly or track interaction history.", "importance": "medium"}, {"title": "Advanced Natural Language Query (NLQ) Capabilities", "description": "The `nlq_memories` table is a clear indicator that the system incorporates Natural Language Query processing. This table is likely used to store context, historical queries, or learned information to enhance future NLQ interactions, signifying an advanced AI/NLP component.", "importance": "high"}]	\N	\N	44193.26043128967	2025-12-13 07:03:07.727426
21	8	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:14:17.086324
22	8	assistant	I don't see any 'sales' information in the available tables. Could you please tell me which table or column contains the sales data?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:14:19.905535
23	8	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:18:44.648258
24	8	assistant	I don't see any 'sales' related data in the available tables. Could you please specify which table or column represents 'sales' so I can help you with the trend analysis?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:18:46.680272
25	8	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:19:31.979305
26	8	assistant	I cannot find any data related to 'sales' in the available schema. Could you please specify which table or column contains sales information?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:19:33.771783
27	9	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:25:06.87951
28	9	assistant	The terms 'sales' and 'category' do not appear to be present in the available database schema (users, tenants, organizations, conversations, messages, nlq_memories). Could you please clarify which tables or columns you are referring to for 'sales' and 'category'?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:25:10.215691
29	10	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:25:42.578198
30	10	assistant	The current database schema does not contain information about 'sales' or 'category'. Could you please specify which tables or columns you are referring to for 'sales' and 'category'?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:25:48.785652
31	11	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:31:49.938929
32	11	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:33:34.704404
33	12	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:38:48.169426
34	12	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	1568.160057067871	2025-12-13 07:38:49.699934
35	13	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:44:53.460063
36	13	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	1578.129529953003	2025-12-13 07:44:55.01495
37	13	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:45:08.08058
38	13	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	253.47399711608887	2025-12-13 07:45:08.324102
39	14	user	show me list of table you have?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:45:33.504702
40	14	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	744.434118270874	2025-12-13 07:45:34.215915
41	7	user	show all table value in users	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:46:50.518121
42	7	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	789.8943424224854	2025-12-13 07:46:51.306135
43	15	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:47:04.036449
44	15	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	244.5383071899414	2025-12-13 07:47:04.252079
45	14	user	give me mssql raw query for get all value from users table	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:48:10.50348
46	14	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	773.5540866851807	2025-12-13 07:48:11.274401
47	15	user	what are the tables here we r using	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:49:10.833076
48	15	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	750.8330345153809	2025-12-13 07:49:11.581291
49	15	user	what table u currently have	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:49:30.086815
50	15	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	729.9082279205322	2025-12-13 07:49:30.81427
51	16	user	what table currently you have	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:49:50.094016
52	16	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	673.3102798461914	2025-12-13 07:49:50.757757
53	15	user	list customers	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:50:12.218819
54	15	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	679.5945167541504	2025-12-13 07:50:12.895505
55	7	user	what table u currently have	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:51:03.18211
56	7	assistant	Data retrieved successfully.	sql	SELECT 'users' AS table_name\nUNION ALL\nSELECT 'tenants'\nUNION ALL\nSELECT 'organizations'\nUNION ALL\nSELECT 'conversations'\nUNION ALL\nSELECT 'messages'\nUNION ALL\nSELECT 'nlq_memories';	\N	table	{"data": [{"table_name": "users"}, {"table_name": "tenants"}, {"table_name": "organizations"}, {"table_name": "conversations"}, {"table_name": "messages"}, {"table_name": "nlq_memories"}], "config": {}}	\N	\N	\N	271.12698554992676	2025-12-13 07:51:03.446414
57	17	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 07:55:40.6783
58	17	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	1494.6460723876953	2025-12-13 07:55:42.158361
59	17	user	SELECT\n    DATE(sales_date) AS sale_date,\n    SUM(total_amount) AS total_sales,\n    SUM(quantity) AS total_quantity,\n    COUNT(DISTINCT order_id) AS total_orders\nFROM sales_data\nGROUP BY DATE(sales_date)\nORDER BY sale_date;	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:00:00.719838
60	18	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:07:20.245231
61	18	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	line	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {"x_axis": "sales_month", "y_axis": ["total_sales"], "series": null, "colors": ["#4E79A7"], "title": "Total Sales by Month in 2024"}}	\N	\N	\N	24150.10142326355	2025-12-13 08:07:44.370946
62	18	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:08:49.68224
63	18	assistant	I encountered an error executing the query: (psycopg2.errors.UndefinedFunction) operator does not exist: integer = character varying\nLINE 6:   ON ar.product_id = ap.sku\n                           ^\nHINT:  No operator matches the given name and argument types. You might need to add explicit type casts.\n\n[SQL: SELECT\n  ap.category AS category,\n  COALESCE(SUM(ar.total_amount), 0) AS total_sales\nFROM analytics_sales AS ar\nINNER JOIN analytics_products AS ap\n  ON ar.product_id = ap.sku\nWHERE\n  ar.tenant_id = 1\nGROUP BY\n  ap.category\nLIMIT 1000;]\n(Background on this error at: https://sqlalche.me/e/20/f405). Please try rephrasing your question.	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:09:04.372962
64	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:11:03.259499
65	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	line	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {"x_axis": "month", "y_axis": ["total_expenses"], "series": null, "colors": ["#2196F3"], "title": "Total Expenses per Month for 2024"}}	\N	\N	\N	29843.562602996826	2025-12-13 08:11:33.101121
66	18	user	provide it as table	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:12:47.748785
67	18	assistant	What information or data would you like to see as a table? Please provide more details.	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:12:48.807745
68	18	user	all info regarding expenses	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:13:42.05636
69	18	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	8872.736930847168	2025-12-13 08:13:50.927569
70	18	user	provide expences per month for 2024 . i want table view	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:15:33.187219
71	18	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	721.6548919677734	2025-12-13 08:15:33.907843
72	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:15:53.392427
90	20	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:33:05.044568
92	20	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:33:16.084814
167	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	773.6608982086182	2025-12-13 10:45:34.529188
73	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	229.56323623657227	2025-12-13 08:15:53.60327
74	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:16:35.118819
75	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	282.578706741333	2025-12-13 08:16:35.370242
76	18	user	Show total sales by month in 2024 as an insight	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:16:58.161893
77	18	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	682.471513748169	2025-12-13 08:16:58.843568
78	18	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:17:05.658229
79	18	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	203.68313789367676	2025-12-13 08:17:05.854645
80	18	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:17:13.897676
81	18	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	223.20270538330078	2025-12-13 08:17:14.113321
82	19	user	Show expenses by mothn for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:30:05.662702
83	19	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	793.0991649627686	2025-12-13 08:30:06.397492
84	20	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:31:00.383295
85	20	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	699.0780830383301	2025-12-13 08:31:01.075059
86	18	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:32:19.930128
87	18	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	287.8596782684326	2025-12-13 08:32:20.202689
88	18	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:32:40.576303
89	18	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	217.9555892944336	2025-12-13 08:32:40.786783
91	20	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	231.03809356689453	2025-12-13 08:33:05.263334
93	20	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	244.54712867736816	2025-12-13 08:33:16.321231
94	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:33:49.212125
96	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:33:58.948753
98	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 08:34:10.272721
95	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	245.55635452270508	2025-12-13 08:33:49.431993
97	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	207.09776878356934	2025-12-13 08:33:59.149467
99	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	228.68919372558594	2025-12-13 08:34:10.495388
100	21	user	Show total revenue by month for the last 12 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 09:12:28.791281
101	21	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	2259.8445415496826	2025-12-13 09:12:30.996419
102	22	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 09:42:54.286325
103	22	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	743.02077293396	2025-12-13 09:42:55.021597
104	18	user	provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 09:43:42.412811
105	18	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	269.59753036499023	2025-12-13 09:43:42.656716
106	23	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 09:44:17.386671
107	23	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	685.5068206787109	2025-12-13 09:44:18.054802
108	24	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:06:11.094425
109	24	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	752.5932788848877	2025-12-13 10:06:11.825035
110	18	user	Show me the trend of orders over the last 6 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:08:24.422168
111	18	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	772.9744911193848	2025-12-13 10:08:25.185423
112	25	user	what are the total sales by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:11:13.478498
113	25	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	733.4580421447754	2025-12-13 10:11:14.204319
114	26	user	provide expences per month for 2024 total	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:12:06.89014
115	26	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	679.5692443847656	2025-12-13 10:12:07.555468
116	26	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:12:41.116189
161	20	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	646.8896865844727	2025-12-13 10:43:36.478684
162	20	user	Show total sales by month in 2025	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:43:42.571697
165	36	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	642.902135848999	2025-12-13 10:43:44.983969
168	38	user	Show me the trend of orders over the last 6 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:45:52.871684
170	38	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:56:07.533904
117	26	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	262.8946304321289	2025-12-13 10:12:41.34391
118	27	user	show expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:17:26.781987
119	27	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	778.8474559783936	2025-12-13 10:17:27.531697
120	28	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:19:19.301332
121	28	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	274.4319438934326	2025-12-13 10:19:19.540084
122	29	user	Show me the trend of orders over the last 6 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:23:40.36278
123	29	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	841.5732383728027	2025-12-13 10:23:41.186118
124	30	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:25:35.838538
125	30	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	758.9433193206787	2025-12-13 10:25:36.587297
126	31	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:26:09.720519
127	31	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	251.15299224853516	2025-12-13 10:26:09.955261
128	32	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:28:53.833853
129	32	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	299.5414733886719	2025-12-13 10:28:54.117682
130	33	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:29:11.137025
163	20	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	718.679666519165	2025-12-13 10:43:43.28816
164	36	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:43:44.341084
169	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	631.0224533081055	2025-12-13 10:45:53.49975
194	41	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:06:08.093196
197	41	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	674.4413375854492	2025-12-13 11:06:49.457584
249	49	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	\N	\N	196.7778205871582	2025-12-13 11:45:19.58456
131	33	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	5	Yes. it will be very helpful. Thank you.	236.11068725585938	2025-12-13 10:29:11.354803
132	34	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:35:43.983917
133	34	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	808.9404106140137	2025-12-13 10:35:44.7603
134	34	user	Show distribution of customers by country	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:35:59.292065
135	34	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	638.2331848144531	2025-12-13 10:35:59.928397
136	26	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:36:40.106805
137	26	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	248.77381324768066	2025-12-13 10:36:40.329143
138	35	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:37:20.574418
139	35	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	718.8351154327393	2025-12-13 10:37:21.262514
140	35	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:37:32.550179
141	35	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	662.5771522521973	2025-12-13 10:37:33.211072
142	8	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:38:21.403975
143	8	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	684.6392154693604	2025-12-13 10:38:22.087633
144	8	user	Show me monthly sales trend for 2024 view as table	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:38:35.081893
145	8	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	720.4568386077881	2025-12-13 10:38:35.804098
146	8	user	Show me monthly sales trend for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:39:01.678905
147	8	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	674.7531890869141	2025-12-13 10:39:02.352814
148	36	user	What are the total sales by category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:42:17.617662
149	36	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	766.0112380981445	2025-12-13 10:42:18.332078
150	36	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:42:31.735916
151	36	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	650.5410671234131	2025-12-13 10:42:32.380755
152	37	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:42:48.039621
153	37	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	633.0082416534424	2025-12-13 10:42:48.66591
154	37	user	Which products have the highest revenue?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:42:55.225581
155	37	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	662.8105640411377	2025-12-13 10:42:55.887486
156	20	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:43:19.051545
157	20	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	233.79898071289062	2025-12-13 10:43:19.273138
158	20	user	Show total sales by month in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:43:29.191582
159	20	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2024-01", "total_sales": 569807.95}, {"sales_month": "2024-02", "total_sales": 723982.55}, {"sales_month": "2024-03", "total_sales": 551493.6}, {"sales_month": "2024-04", "total_sales": 334157.7}, {"sales_month": "2024-05", "total_sales": 636671.8}, {"sales_month": "2024-06", "total_sales": 517935.0}, {"sales_month": "2024-07", "total_sales": 436425.0}, {"sales_month": "2024-08", "total_sales": 421042.6}, {"sales_month": "2024-09", "total_sales": 343175.8}, {"sales_month": "2024-10", "total_sales": 434573.75}, {"sales_month": "2024-11", "total_sales": 466269.15}, {"sales_month": "2024-12", "total_sales": 652719.4}], "config": {}}	\N	\N	\N	316.2662982940674	2025-12-13 10:43:29.420379
160	20	user	Show total sales by month in 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:43:35.83138
166	38	user	Show me the trend of orders over the last 6 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:45:33.816624
171	38	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	line	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {"x_axis": "sales_month", "y_axis": ["total_sales"], "series": null, "colors": "viridis", "title": "2023 Monthly Sales Trend"}}	\N	\N	\N	22588.94395828247	2025-12-13 10:56:30.0887
172	38	user	Show me the trend of orders over the last 6 months	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:57:16.974087
173	38	assistant	No data available for analysis.	sql	SELECT\n  DATE_TRUNC('month', asl.order_date) AS order_month,\n  COUNT(asl.order_number) AS orders\nFROM\n  analytics_sales AS asl\nWHERE\n  asl.tenant_id = 1\n  AND asl.order_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '6 month')\n  AND asl.order_date < DATE_TRUNC('month', CURRENT_DATE)\nGROUP BY\n  DATE_TRUNC('month', asl.order_date)\nORDER BY\n  order_month ASC\nLIMIT 1000;	\N	line	{"data": [], "config": {"x_axis": "order_date", "y_axis": "orders", "series": null, "colors": ["#4C78A8"], "title": "Trend of Orders Over Last 6 Months"}}	\N	\N	\N	23282.663106918335	2025-12-13 10:57:40.254614
174	38	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 10:59:15.647014
175	38	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	bar	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {"x_axis": "month", "y_axis": ["total_expenses"], "series": null, "colors": ["#4285F4"], "title": "Monthly Expenses for 2024"}}	\N	\N	\N	26086.16065979004	2025-12-13 10:59:41.731502
176	38	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:01:29.907685
177	38	assistant	The monthly expenses for 2024 from January to October reveal significant volatility in spending. April saw the highest expenses at $169,876, marking a peak for the period. However, this was immediately followed by a sharp decline in May, which recorded the lowest expenses at just $32,776 – an 80% drop from the previous month. The average monthly expense for this period was approximately $103,735. After the low in May, spending generally stabilized, fluctuating around or below the average for the remainder of the available data, without exhibiting a strong consistent trend.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	line	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {"x_axis": "month", "y_axis": ["total_expenses"], "series": null, "colors": ["#1f77b4"], "title": "Monthly Expenses for 2024"}}	[{"title": "Significant Monthly Volatility", "description": "Monthly expenses for 2024 (January to October) show considerable fluctuation, ranging from a peak of $169,876 in April to a low of $32,776 in May. This represents an approximately 80% decrease between these two consecutive months, indicating potential one-off expenditures or significant operational changes.", "importance": "high"}, {"title": "April as Peak Spending Month", "description": "April 2024 recorded the highest monthly expenses at $169,876. This figure is significantly above the average monthly expense of $103,735 for the observed period, suggesting potentially higher operational costs, project-related spending, or seasonal outlays during this month.", "importance": "medium"}, {"title": "May's Unusually Low Expenses", "description": "Following the peak in April, May 2024 experienced an unusually low expense total of $32,776. This figure is the lowest observed so far and significantly below the average, warranting further investigation into its cause (e.g., cost-saving initiatives, deferred expenses, or reduced activity).", "importance": "high"}, {"title": "Post-May Stabilization", "description": "After the drastic dip in May, expenses in the subsequent months (June-October) show more relative stability compared to the extreme fluctuations seen in April and May, generally hovering around or below the calculated average of $103,735.", "importance": "low"}]	\N	\N	15693.04370880127	2025-12-13 11:01:45.58063
178	38	user	Top 10 products by revenue in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:02:55.71877
179	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	4684.264898300171	2025-12-13 11:03:00.399636
180	38	user	Compare 2023 vs 2024 sales performance	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:03:16.688839
181	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	645.7493305206299	2025-12-13 11:03:17.329975
182	38	user	What is the total sales by product category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:03:29.342537
183	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	707.4308395385742	2025-12-13 11:03:30.046603
184	39	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:03:36.980733
185	39	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	256.2434673309326	2025-12-13 11:03:37.213605
186	38	user	What is the total sales by product category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:03:49.516119
187	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	656.3241481781006	2025-12-13 11:03:50.170577
188	40	user	Top 10 sale product list last month.	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:04:06.576005
189	40	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	656.2299728393555	2025-12-13 11:04:07.215626
190	41	user	give me top 10 list of last month sale product	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:05:19.938676
191	41	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	722.679853439331	2025-12-13 11:05:20.62235
192	41	user	give me 10 product which is less than 50rs	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:05:43.331125
193	41	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	644.2770957946777	2025-12-13 11:05:43.96777
195	41	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	227.28419303894043	2025-12-13 11:06:08.306163
196	41	user	What is the total expense by department?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:06:48.785414
198	41	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:07:17.030662
200	42	user	Compare 2023 vs 2024 sales performance	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:08:03.480943
202	42	user	Compare expenses by category for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:08:36.60917
205	42	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	621.3235855102539	2025-12-13 11:08:43.857978
199	41	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	223.42824935913086	2025-12-13 11:07:17.224293
201	42	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	661.1320972442627	2025-12-13 11:08:04.134505
203	42	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	741.3651943206787	2025-12-13 11:08:37.351272
204	42	user	Compare expenses by category for 2024 list	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:08:43.23967
206	43	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:10:15.453131
207	43	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	314.6975040435791	2025-12-13 11:10:15.707847
208	41	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:10:55.142851
209	41	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	230.03745079040527	2025-12-13 11:10:55.352663
210	44	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:11:54.391131
211	44	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	242.83218383789062	2025-12-13 11:11:54.616344
212	39	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:16:05.75202
213	39	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	329.46181297302246	2025-12-13 11:16:06.033691
214	45	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:19:28.878112
250	51	user	show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:46:12.380501
215	45	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	392.3661708831787	2025-12-13 11:19:29.231891
216	46	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:20:18.266007
217	46	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	287.45102882385254	2025-12-13 11:20:18.521047
218	38	user	Show me monthly expenses for 2024\nTotal expenses by category Sales revenue by product category Top 10 products by revenue in 2024 Compare 2023 vs 2024 total sales	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:30:37.808328
219	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	791.534423828125	2025-12-13 11:30:38.598315
220	38	user	Total expenses by category Sales revenue by product category Top 10 products by revenue in 2024 Compare 2023 vs 2024 total sales	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:30:49.975259
221	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	687.6842975616455	2025-12-13 11:30:50.660741
222	38	user	Total expenses by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:31:29.303283
223	38	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	773.543119430542	2025-12-13 11:31:30.062892
224	47	user	Total expenses by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:31:41.166788
225	47	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	685.4803562164307	2025-12-13 11:31:41.842
226	47	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:31:54.419505
227	47	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	\N	\N	201.1256217956543	2025-12-13 11:31:54.614864
228	47	user	Total expenses by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:32:10.575917
229	47	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	662.5003814697266	2025-12-13 11:32:11.236937
230	47	user	Sales revenue by product category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:32:33.095022
231	47	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	779.4413566589355	2025-12-13 11:32:33.869191
232	47	user	Top 10 products by revenue in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:32:46.556941
233	47	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	626.7292499542236	2025-12-13 11:32:47.182901
234	48	user	Total expenses by category	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:39:36.532427
235	48	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	1844.092845916748	2025-12-13 11:39:38.350807
236	48	user	Top 10 products by revenue in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:41:14.167535
237	48	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	566.8842792510986	2025-12-13 11:41:14.732309
238	48	user	Top 10 products by revenue in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:41:18.793917
239	48	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	485.38661003112793	2025-12-13 11:41:19.279421
240	49	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:44:28.349577
241	49	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	\N	\N	1136.0392570495605	2025-12-13 11:44:29.45664
242	50	user	top 10 products revenue in 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:44:46.351662
243	50	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	552.1273612976074	2025-12-13 11:44:46.893276
244	51	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:45:00.648123
245	51	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	\N	\N	234.99202728271484	2025-12-13 11:45:00.830118
246	49	user	What is the total sales by product category?	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:45:09.533899
247	49	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	537.750244140625	2025-12-13 11:45:10.070442
248	49	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:45:19.395401
251	51	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	5	Yest  nmn	228.07788848876953	2025-12-13 11:46:12.602982
252	52	user	Show sales trend by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:52:26.002855
253	52	assistant	Data retrieved successfully.	sql	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	table	{"data": [{"sales_month": "2023-01-01T00:00:00+00:00", "total_sales": 686088.6}, {"sales_month": "2023-02-01T00:00:00+00:00", "total_sales": 625472.8}, {"sales_month": "2023-03-01T00:00:00+00:00", "total_sales": 519923.8}, {"sales_month": "2023-04-01T00:00:00+00:00", "total_sales": 474603.7}, {"sales_month": "2023-05-01T00:00:00+00:00", "total_sales": 370870.1}, {"sales_month": "2023-06-01T00:00:00+00:00", "total_sales": 410912.8}, {"sales_month": "2023-07-01T00:00:00+00:00", "total_sales": 562954.0}, {"sales_month": "2023-08-01T00:00:00+00:00", "total_sales": 216335.25}, {"sales_month": "2023-09-01T00:00:00+00:00", "total_sales": 617306.9}, {"sales_month": "2023-10-01T00:00:00+00:00", "total_sales": 590757.1}, {"sales_month": "2023-11-01T00:00:00+00:00", "total_sales": 430376.45}, {"sales_month": "2023-12-01T00:00:00+00:00", "total_sales": 447681.4}], "config": {}}	\N	\N	\N	248.9449977874756	2025-12-13 11:52:26.233781
254	52	user	provide expences per month for 2024 show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:53:59.717288
255	52	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	261.1508369445801	2025-12-13 11:53:59.955434
256	52	user	show provide expences per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:54:27.043367
257	52	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"year": 2024.0, "month": 1.0, "total_expenses": 391962.0}, {"year": 2024.0, "month": 2.0, "total_expenses": 147477.0}, {"year": 2024.0, "month": 3.0, "total_expenses": 283284.0}, {"year": 2024.0, "month": 4.0, "total_expenses": 205690.0}, {"year": 2024.0, "month": 5.0, "total_expenses": 80264.0}, {"year": 2024.0, "month": 6.0, "total_expenses": 219433.0}, {"year": 2024.0, "month": 7.0, "total_expenses": 154088.0}, {"year": 2024.0, "month": 8.0, "total_expenses": 144716.0}, {"year": 2024.0, "month": 9.0, "total_expenses": 143592.0}, {"year": 2024.0, "month": 10.0, "total_expenses": 187631.0}, {"year": 2024.0, "month": 11.0, "total_expenses": 249430.0}, {"year": 2024.0, "month": 12.0, "total_expenses": 207152.0}], "config": {}}	\N	\N	\N	209.78212356567383	2025-12-13 11:54:27.24595
258	52	user	show	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 11:54:35.59613
259	52	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	560.3547096252441	2025-12-13 11:54:36.155071
260	53	user	show sales trends by month for 2023	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 14:00:44.088545
261	53	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	6196.233749389648	2025-12-13 14:00:50.250082
262	52	user	show provide expense per month for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-13 16:13:26.893371
263	52	assistant	Data retrieved successfully.	sql	SELECT 1	\N	table	{"data": [{"?column?": 1}], "config": {}}	\N	\N	\N	5421.881675720215	2025-12-13 16:13:32.290015
264	54	user	Compare 2023 vs 2024 sales performance	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-15 08:12:48.423547
265	54	assistant	Data retrieved successfully.	sql	SELECT\n  EXTRACT(YEAR FROM s.order_date) AS sales_year,\n  SUM(s.total_amount) AS total_sales\nFROM analytics_sales AS s\nWHERE\n  EXTRACT(YEAR FROM s.order_date) IN (2023, 2024) AND s.tenant_id = 1\nGROUP BY\n  EXTRACT(YEAR FROM s.order_date)\nLIMIT 1000;	\N	bar	{"data": [{"sales_year": 2023.0, "total_sales": 5953282.9}, {"sales_year": 2024.0, "total_sales": 6088254.3}], "config": {"x_axis": "sales_year", "y_axis": "total_sales", "series": null, "colors": ["#4CAF50", "#2196F3"], "title": "2023 vs 2024 Sales Performance Comparison"}}	\N	\N	\N	23564.513206481934	2025-12-15 08:13:11.965499
266	55	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-15 08:27:57.437965
269	55	assistant	Data retrieved successfully.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	table	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {}}	\N	\N	\N	6070.762157440186	2025-12-15 08:28:56.074912
267	55	assistant	The line chart displays the monthly expenses for 2024, revealing a highly volatile spending pattern. Expenses started at 147,189 in January and fluctuated significantly over the subsequent months. The highest expense month was April, reaching 169,876, followed by a dramatic drop to the lowest point of 32,776 in May. Another considerable decrease was observed in September, with expenses at 57,293. This suggests that spending is not consistent and varies greatly from month to month, indicating potential periods of increased or reduced financial activity.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	line	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {"x_axis": "month", "y_axis": ["total_expenses"], "series": null, "colors": ["#4285F4"], "title": "Monthly Expenses for 2024"}}	[{"title": "Significant Volatility in Monthly Expenses", "description": "Monthly expenses for 2024 show considerable fluctuations, ranging from a peak of 169,876 in April to a low of 32,776 in May. This wide range indicates inconsistent spending patterns throughout the year.", "importance": "high"}, {"title": "Peak Spending Observed in April", "description": "April 2024 recorded the highest monthly expenses at 169,876. This significant increase compared to other months suggests a potential period of heightened activity or one-time large expenditures during that month.", "importance": "medium"}, {"title": "Sharp Drops in Expenses in May and September", "description": "Following the peak in April, expenses drastically fell to their lowest point in May (32,776). Another notable decline occurred in September, with expenses dropping to 57,293. These sharp decreases warrant further investigation to understand their causes.", "importance": "medium"}]	\N	\N	11780.161619186401	2025-12-15 08:28:09.196689
268	55	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-15 08:28:50.033394
270	55	user	Show me monthly expenses for 2024	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-15 08:29:13.825879
271	55	assistant	The monthly expenses for 2024 have shown significant fluctuations. The highest spending occurred in April with 169,876, followed by a dramatic drop to the lowest point of 32,776 in May. After this sharp decrease, expenses have generally remained at lower levels compared to the first quarter, oscillating between roughly 57,000 and 113,000. This volatility suggests varying operational costs or project cycles throughout the year, especially highlighting the distinct spending patterns between April and May.	sql	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	line	{"data": [{"month": "2024-01", "total_expenses": 147189.0}, {"month": "2024-02", "total_expenses": 101062.0}, {"month": "2024-03", "total_expenses": 135697.0}, {"month": "2024-04", "total_expenses": 169876.0}, {"month": "2024-05", "total_expenses": 32776.0}, {"month": "2024-06", "total_expenses": 102191.0}, {"month": "2024-07", "total_expenses": 90181.0}, {"month": "2024-08", "total_expenses": 113003.0}, {"month": "2024-09", "total_expenses": 57293.0}, {"month": "2024-10", "total_expenses": 88086.0}, {"month": "2024-11", "total_expenses": 155835.0}, {"month": "2024-12", "total_expenses": 102358.0}], "config": {"x_axis": "month", "y_axis": ["total_expenses"], "series": null, "colors": ["#4C78A8"], "title": "Monthly Expenses for 2024"}}	[{"title": "Significant Monthly Expense Volatility", "description": "Monthly expenses for 2024 show considerable fluctuation, ranging from a high of 169,876 in April to a low of 32,776 in May. This indicates an inconsistent spending pattern throughout the year.", "importance": "high"}, {"title": "April Marks the Highest Spending Month", "description": "April 2024 recorded the peak in monthly expenses at 169,876. This was the highest spending period observed within the first ten months of the year.", "importance": "medium"}, {"title": "Drastic Drop in Expenses in May", "description": "Following the peak in April, May 2024 experienced the lowest monthly expenses, dropping sharply to 32,776. This significant decrease warrants further investigation to understand the underlying causes.", "importance": "high"}, {"title": "Post-May Expenses Generally Lower Than Q1", "description": "After the dramatic shift in May, monthly expenses have generally remained at lower levels compared to the first quarter (January-March), typically fluctuating between 57,000 and 113,000, which is below the initial Q1 average.", "importance": "medium"}]	\N	\N	13799.821615219116	2025-12-15 08:29:27.597296
\.


--
-- Data for Name: nlq_memories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nlq_memories (id, tenant_id, user_id, normalized_query, raw_user_input, generated_sql, generated_mongo_pipeline, intent, metrics, filters, hit_count, last_used_at, confidence_score, created_at, updated_at) FROM stdin;
14	1	1	6 last months orders over trend	Show me the trend of orders over the last 6 months	SELECT\n  DATE_TRUNC('month', asl.order_date) AS order_month,\n  COUNT(asl.order_number) AS orders\nFROM\n  analytics_sales AS asl\nWHERE\n  asl.tenant_id = 1\n  AND asl.order_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '6 month')\n  AND asl.order_date < DATE_TRUNC('month', CURRENT_DATE)\nGROUP BY\n  DATE_TRUNC('month', asl.order_date)\nORDER BY\n  order_month ASC\nLIMIT 1000;	\N	trend_analysis	{"metrics": ["orders"], "dimensions": ["order_date"], "aggregations": ["COUNT"], "time_granularity": "month"}	{"time_range": {"start_date": null, "end_date": null, "relative": "last 6 months"}, "conditions": [{"field": "tenant_id", "operator": "=", "value": "1"}], "limit": null, "order_by": null}	1	2025-12-13 10:57:40.23206	1	2025-12-13 10:57:40.232062	2025-12-13 10:57:40.232063
1	5	8	currently table u	what table u currently have	SELECT 'users' AS table_name\nUNION ALL\nSELECT 'tenants'\nUNION ALL\nSELECT 'organizations'\nUNION ALL\nSELECT 'conversations'\nUNION ALL\nSELECT 'messages'\nUNION ALL\nSELECT 'nlq_memories';	\N	detail_lookup	{"metrics": [], "dimensions": [], "aggregations": [], "time_granularity": null}	{"time_range": null, "conditions": [], "limit": null, "order_by": []}	2	2025-12-13 07:51:03.175689	0.95	2025-12-13 07:03:07.717888	2025-12-13 07:51:03.175912
12	1	1	2024 expences month per provide	provide expences per month for 2024	SELECT\n  EXTRACT(YEAR FROM ae.expense_date) AS year,\n  EXTRACT(MONTH FROM ae.expense_date) AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM analytics_expenses AS ae\nWHERE\n  ae.expense_date >= '2024-01-01' AND ae.expense_date <= '2024-12-31'\nGROUP BY\n  EXTRACT(YEAR FROM ae.expense_date),\n  EXTRACT(MONTH FROM ae.expense_date)\nORDER BY\n  year ASC,\n  month ASC\nLIMIT 1000;	\N	aggregation	{"metrics": ["amount"], "dimensions": ["expense_date"], "aggregations": ["SUM"], "time_granularity": "month"}	{"time_range": {"start_date": "2024-01-01", "end_date": "2024-12-31", "relative": null}, "conditions": [{"field": "tenant_id", "operator": "=", "value": 1}], "limit": null, "order_by": []}	16	2025-12-13 11:54:27.035925	0.95	2025-12-13 08:11:33.088859	2025-12-13 11:54:27.036178
11	1	1	2024 month sales total	Show total sales by month in 2024	SELECT\n  TO_CHAR(a_s.order_date, 'YYYY-MM') AS sales_month,\n  COALESCE(SUM(a_s.total_amount), 0) AS total_sales\nFROM\n  analytics_sales AS a_s\nWHERE\n  a_s.order_date BETWEEN '2024-01-01' AND '2024-12-31' AND a_s.tenant_id = 1\nGROUP BY\n  TO_CHAR(a_s.order_date, 'YYYY-MM')\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	trend_analysis	{"metrics": ["total_amount"], "dimensions": ["order_date"], "aggregations": ["SUM"], "time_granularity": "month"}	{"time_range": {"start_date": "2024-01-01", "end_date": "2024-12-31", "relative": null}, "conditions": [{"field": "order_date", "operator": "BETWEEN", "value": ["2024-01-01", "2024-12-31"]}, {"field": "tenant_id", "operator": "=", "value": 1}], "limit": null, "order_by": []}	9	2025-12-13 10:43:29.10735	0.95	2025-12-13 08:07:44.358578	2025-12-13 10:43:29.107698
16	1	1	2023 2024 compare performance sales vs	Compare 2023 vs 2024 sales performance	SELECT\n  EXTRACT(YEAR FROM s.order_date) AS sales_year,\n  SUM(s.total_amount) AS total_sales\nFROM analytics_sales AS s\nWHERE\n  EXTRACT(YEAR FROM s.order_date) IN (2023, 2024) AND s.tenant_id = 1\nGROUP BY\n  EXTRACT(YEAR FROM s.order_date)\nLIMIT 1000;	\N	comparison	{"metrics": ["total_amount"], "dimensions": ["year"], "aggregations": ["SUM"], "time_granularity": "year"}	{"time_range": null, "conditions": [{"field": "YEAR(order_date)", "operator": "IN", "value": [2023, 2024]}, {"field": "tenant_id", "operator": "=", "value": 1}], "limit": null, "order_by": []}	1	2025-12-15 08:13:11.91911	0.95	2025-12-15 08:13:11.919114	2025-12-15 08:13:11.919115
15	1	1	2024 expenses monthly	Show me monthly expenses for 2024	SELECT\n  TO_CHAR(ae.expense_date, 'YYYY-MM') AS month,\n  COALESCE(SUM(ae.amount), 0) AS total_expenses\nFROM\n  analytics_expenses AS ae\nWHERE\n  ae.expense_date BETWEEN '2024-01-01' AND '2024-12-31'\n  AND ae.tenant_id = 1\nGROUP BY\n  TO_CHAR(ae.expense_date, 'YYYY-MM')\nORDER BY\n  month ASC\nLIMIT 1000;	\N	aggregation	{"metrics": ["amount"], "dimensions": ["expense_date"], "aggregations": ["SUM"], "time_granularity": "month"}	{"time_range": {"start_date": "2024-01-01", "end_date": "2024-12-31", "relative": null}, "conditions": [{"field": "expense_date", "operator": "BETWEEN", "value": ["2024-01-01", "2024-12-31"]}], "limit": null, "order_by": []}	10	2025-12-15 08:29:13.810783	0.95	2025-12-13 10:59:41.724641	2025-12-15 08:29:13.811062
13	1	1	2023 month sales trend	Show sales trend by month for 2023	SELECT\n  DATE_TRUNC('month', s.order_date) AS sales_month,\n  SUM(s.total_amount) AS total_sales\nFROM\n  analytics_sales AS s\nWHERE\n  s.tenant_id = 1 AND s.order_date >= '2023-01-01' AND s.order_date <= '2023-12-31'\nGROUP BY\n  DATE_TRUNC('month', s.order_date)\nORDER BY\n  sales_month ASC\nLIMIT 1000;	\N	trend_analysis	{"metrics": ["total_amount"], "dimensions": ["order_date"], "aggregations": ["SUM"], "time_granularity": "month"}	{"time_range": {"start_date": "2023-01-01", "end_date": "2023-12-31", "relative": null}, "conditions": [{"field": "tenant_id", "operator": "=", "value": 1}], "limit": null, "order_by": []}	10	2025-12-13 11:52:25.9825	0.95	2025-12-13 10:56:30.066836	2025-12-13 11:52:25.982782
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizations (id, tenant_id, name, display_name, is_active, created_at) FROM stdin;
1	1	engineering	Engineering Team	t	2025-12-13 06:17:06.983877
2	1	sales	Sales Team	t	2025-12-13 06:17:06.983877
3	2	product	Product Team	t	2025-12-13 06:17:06.983877
4	3	ITL	ITL	t	2025-12-13 06:42:59.662811
5	4	ITL	ITL	t	2025-12-13 06:45:37.372443
6	5	ITL	ITL	t	2025-12-13 06:56:38.784831
7	6	ITL	ITL	t	2025-12-13 10:28:08.627501
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenants (id, name, display_name, description, is_active, created_at, updated_at, db_type, db_connection_string, rate_limit_per_minute, rate_limit_per_hour) FROM stdin;
1	acme_corp	Acme Corporation	Primary demo tenant	t	2025-12-13 06:16:58.662071	2025-12-13 06:16:58.662071	postgresql	\N	60	1000
2	tech_startup	Tech Startup Inc	Secondary demo tenant	t	2025-12-13 06:16:58.662071	2025-12-13 06:16:58.662071	postgresql	\N	30	500
3	Ideal tech labs	Ideal tech labs	\N	t	2025-12-13 06:42:59.6586	2025-12-13 06:42:59.658602	postgresql	\N	60	1000
4	IdealTechlabs	IdealTechlabs	\N	t	2025-12-13 06:45:37.369637	2025-12-13 06:45:37.369639	postgresql	\N	60	1000
5	IT Company	IT Company	\N	t	2025-12-13 06:56:38.782548	2025-12-13 06:56:38.78255	postgresql	\N	60	1000
6	ITL	ITL	\N	t	2025-12-13 10:28:08.622313	2025-12-13 10:28:08.622315	postgresql	\N	60	1000
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, name, hashed_password, phone_number, profile_picture, tenant_id, organization_id, is_active, is_verified, created_at, updated_at, last_login) FROM stdin;
2	john@acme.com	John Smith	$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6	\N	\N	1	1	t	t	2025-12-13 06:17:22.878027	2025-12-13 06:17:22.878027	\N
3	jane@acme.com	Jane Doe	$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6	\N	\N	1	2	t	t	2025-12-13 06:17:22.878027	2025-12-13 06:17:22.878027	\N
4	demo@techstartup.com	Demo User	$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6	\N	\N	2	3	t	t	2025-12-13 06:17:22.878027	2025-12-13 06:17:22.878027	\N
8	praveenkumar.ramachandran+123@idealtechlabs.com	Praveenkumar Ramachandran	$2b$12$nJir3g2VVOMbXTcM6qjEIO1/ar3CRNmKs7lOABA/OSJab5Dzsuea.	\N	\N	5	6	t	f	2025-12-13 06:56:39.085628	2025-12-13 11:03:33.658661	2025-12-13 11:03:33.658269
7	prakash@idealtechlabs.com	Prakash V S	$2b$12$mIuZKXbna/87G7XdicUIrOekL.Le232MRGlCpwUy4I7bcfuZSOUXu	9884479924	\N	3	4	t	f	2025-12-13 06:52:15.734742	2025-12-13 06:52:15.734746	\N
5	praveenkumar.ramachandran@idealtechlabs.com	Praveen kumar	$2b$12$3YIN5mlYHE5wMWwKGoeyI.GSVHQHZGlYC0hLLGEAeJ8rGvnfQTfPW	7871144071	\N	3	4	t	f	2025-12-13 06:42:59.943268	2025-12-13 07:07:18.948822	2025-12-13 07:07:18.948399
1	admin@acme.com	Admin User	$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6	\N	\N	1	1	t	t	2025-12-13 06:17:22.878027	2025-12-15 08:10:35.539054	2025-12-15 08:10:35.538672
6	saravanakumar.ramadoss@idealtechlabs.com	Saravanakumar Ramadoss	$2b$12$J1aIACpq3bjyZ3q/ue2VBOMtTFJlaug9OL8OiRlqiMLF4ihAOik0q	8667207962	\N	4	5	t	f	2025-12-13 06:45:37.656001	2025-12-13 10:25:28.938983	2025-12-13 10:25:28.938579
9	saravanakumar.ramadoss@itl.com	Saravanakumar R	$2b$12$/w1KRAQXj7ocv3xC7Sm7tOAaaPQvjplxDDhXRFqgEHKpUh8./KGUO	8667207962	\N	6	7	t	f	2025-12-13 10:28:08.897219	2025-12-13 10:28:21.108794	2025-12-13 10:28:21.108271
\.


--
-- Name: analytics_budgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_budgets_id_seq', 400, true);


--
-- Name: analytics_customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_customers_id_seq', 30, true);


--
-- Name: analytics_departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_departments_id_seq', 10, true);


--
-- Name: analytics_expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_expenses_id_seq', 600, true);


--
-- Name: analytics_financial_summaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_financial_summaries_id_seq', 48, true);


--
-- Name: analytics_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_products_id_seq', 20, true);


--
-- Name: analytics_regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_regions_id_seq', 10, true);


--
-- Name: analytics_sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analytics_sales_id_seq', 1200, true);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_id_seq', 55, true);


--
-- Name: data_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_sources_id_seq', 5, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 271, true);


--
-- Name: nlq_memories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nlq_memories_id_seq', 16, true);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organizations_id_seq', 7, true);


--
-- Name: tenants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tenants_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: analytics_budgets analytics_budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_budgets
    ADD CONSTRAINT analytics_budgets_pkey PRIMARY KEY (id);


--
-- Name: analytics_customers analytics_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_customers
    ADD CONSTRAINT analytics_customers_pkey PRIMARY KEY (id);


--
-- Name: analytics_departments analytics_departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_departments
    ADD CONSTRAINT analytics_departments_pkey PRIMARY KEY (id);


--
-- Name: analytics_expenses analytics_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_expenses
    ADD CONSTRAINT analytics_expenses_pkey PRIMARY KEY (id);


--
-- Name: analytics_financial_summaries analytics_financial_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_financial_summaries
    ADD CONSTRAINT analytics_financial_summaries_pkey PRIMARY KEY (id);


--
-- Name: analytics_products analytics_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_products
    ADD CONSTRAINT analytics_products_pkey PRIMARY KEY (id);


--
-- Name: analytics_regions analytics_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_regions
    ADD CONSTRAINT analytics_regions_pkey PRIMARY KEY (id);


--
-- Name: analytics_sales analytics_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_sales
    ADD CONSTRAINT analytics_sales_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: data_sources data_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT data_sources_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: nlq_memories nlq_memories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nlq_memories
    ADD CONSTRAINT nlq_memories_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_expenses_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_expenses_date ON public.analytics_expenses USING btree (expense_date);


--
-- Name: idx_expenses_tenant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_expenses_tenant ON public.analytics_expenses USING btree (tenant_id);


--
-- Name: idx_sales_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sales_date ON public.analytics_sales USING btree (order_date);


--
-- Name: idx_sales_tenant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sales_tenant ON public.analytics_sales USING btree (tenant_id);


--
-- Name: ix_conversations_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_conversations_id ON public.conversations USING btree (id);


--
-- Name: ix_conversations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_conversations_tenant_id ON public.conversations USING btree (tenant_id);


--
-- Name: ix_conversations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_conversations_user_id ON public.conversations USING btree (user_id);


--
-- Name: ix_data_sources_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_data_sources_id ON public.data_sources USING btree (id);


--
-- Name: ix_data_sources_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_data_sources_tenant_id ON public.data_sources USING btree (tenant_id);


--
-- Name: ix_messages_conversation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_messages_conversation_id ON public.messages USING btree (conversation_id);


--
-- Name: ix_messages_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_messages_id ON public.messages USING btree (id);


--
-- Name: ix_nlq_memories_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_nlq_memories_id ON public.nlq_memories USING btree (id);


--
-- Name: ix_nlq_memories_normalized_query; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_nlq_memories_normalized_query ON public.nlq_memories USING btree (normalized_query);


--
-- Name: ix_nlq_memories_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_nlq_memories_tenant_id ON public.nlq_memories USING btree (tenant_id);


--
-- Name: ix_nlq_memories_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_nlq_memories_user_id ON public.nlq_memories USING btree (user_id);


--
-- Name: ix_organizations_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_organizations_id ON public.organizations USING btree (id);


--
-- Name: ix_organizations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_organizations_tenant_id ON public.organizations USING btree (tenant_id);


--
-- Name: ix_tenants_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tenants_id ON public.tenants USING btree (id);


--
-- Name: ix_tenants_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_tenants_name ON public.tenants USING btree (name);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_organization_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_organization_id ON public.users USING btree (organization_id);


--
-- Name: ix_users_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_tenant_id ON public.users USING btree (tenant_id);


--
-- Name: analytics_budgets analytics_budgets_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_budgets
    ADD CONSTRAINT analytics_budgets_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_customers analytics_customers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_customers
    ADD CONSTRAINT analytics_customers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_departments analytics_departments_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_departments
    ADD CONSTRAINT analytics_departments_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_expenses analytics_expenses_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_expenses
    ADD CONSTRAINT analytics_expenses_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_financial_summaries analytics_financial_summaries_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_financial_summaries
    ADD CONSTRAINT analytics_financial_summaries_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_products analytics_products_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_products
    ADD CONSTRAINT analytics_products_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_regions analytics_regions_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_regions
    ADD CONSTRAINT analytics_regions_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: analytics_sales analytics_sales_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_sales
    ADD CONSTRAINT analytics_sales_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: conversations conversations_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: conversations conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: data_sources data_sources_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT data_sources_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: messages messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: nlq_memories nlq_memories_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nlq_memories
    ADD CONSTRAINT nlq_memories_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: nlq_memories nlq_memories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nlq_memories
    ADD CONSTRAINT nlq_memories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: organizations organizations_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- Name: users users_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: users users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5z4h8nQnQdz6gCONWgewPaEcwaFPwYujJHTkjItK6fTDEXsKf5AszG8anrTJoq2

