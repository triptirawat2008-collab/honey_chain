--
-- PostgreSQL database dump
--

\restrict 6okUWr5eWI4BSyF8K0GAGrr9YYtBjgyOh4XlhkYdWWX32HVshHmmdYDIwQIdA6O

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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

--
-- Name: verification; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA verification;


ALTER SCHEMA verification OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: apiary_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apiary_locations (
    location_id character varying(50) NOT NULL,
    beekeeper_id character varying(50),
    gps_coordinates character varying(255),
    hive_count integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255)
);


ALTER TABLE public.apiary_locations OWNER TO postgres;

--
-- Name: batch_harvest_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_harvest_mapping (
    batch_id character varying(255) NOT NULL,
    harvest_id character varying(255) NOT NULL
);


ALTER TABLE public.batch_harvest_mapping OWNER TO postgres;

--
-- Name: batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batches (
    batch_id character varying(50) NOT NULL,
    company_license character varying(50) NOT NULL,
    product_name character varying(100),
    quantity_kg numeric,
    final_lab_ulr character varying(100),
    ulr_status character varying(20) DEFAULT 'Pending'::character varying,
    manual_report_status character varying(20) DEFAULT 'Pending'::character varying,
    is_lab_certified boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    manual_report_certified boolean DEFAULT false
);


ALTER TABLE public.batches OWNER TO postgres;

--
-- Name: harvests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.harvests (
    harvest_id character varying(100) NOT NULL,
    beekeeper_id character varying(50),
    location_id character varying(50),
    harvest_date date,
    flower_sources jsonb,
    lab_ulr character varying(100),
    ulr_status character varying(50),
    block_hash character varying(255),
    tx_ref character varying(255),
    quantity_kg numeric,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    lab_report_url text
);


ALTER TABLE public.harvests OWNER TO postgres;

--
-- Name: health_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_logs (
    log_id integer NOT NULL,
    location_id character varying(50),
    status character varying(50),
    notes text,
    inspection_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.health_logs OWNER TO postgres;

--
-- Name: health_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_logs_log_id_seq OWNER TO postgres;

--
-- Name: health_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_logs_log_id_seq OWNED BY public.health_logs.log_id;


--
-- Name: beekeeper_registry; Type: TABLE; Schema: verification; Owner: postgres
--

CREATE TABLE verification.beekeeper_registry (
    id uuid NOT NULL,
    beekeeper_id character varying(255) NOT NULL,
    registered_name character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE verification.beekeeper_registry OWNER TO postgres;

--
-- Name: lab_report_registry; Type: TABLE; Schema: verification; Owner: postgres
--

CREATE TABLE verification.lab_report_registry (
    id uuid NOT NULL,
    ulr_number character varying(255) NOT NULL,
    lab_id character varying(255) NOT NULL,
    lab_name text NOT NULL,
    nabl_certificate_number character varying(255) NOT NULL,
    accreditation_status character varying(255) NOT NULL,
    state character varying(64) NOT NULL,
    city character varying(128) NOT NULL,
    report_number character varying(255) NOT NULL,
    report_date date NOT NULL,
    sample_id character varying(255) NOT NULL
);


ALTER TABLE verification.lab_report_registry OWNER TO postgres;

--
-- Name: license_registry; Type: TABLE; Schema: verification; Owner: postgres
--

CREATE TABLE verification.license_registry (
    id uuid NOT NULL,
    license_number character varying(64) NOT NULL,
    company_name text NOT NULL,
    state character varying(255) NOT NULL,
    issue_date date NOT NULL,
    expiry_date date NOT NULL,
    license_status character varying(255) NOT NULL,
    issuing_authority character varying(255) NOT NULL
);


ALTER TABLE verification.license_registry OWNER TO postgres;

--
-- Name: health_logs log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_logs ALTER COLUMN log_id SET DEFAULT nextval('public.health_logs_log_id_seq'::regclass);


--
-- Data for Name: apiary_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apiary_locations (location_id, beekeeper_id, gps_coordinates, hive_count, created_at, name) FROM stdin;
LOC-001	BK-SYN-57366	28.8500, 79.1000	8	2026-08-29 11:39:23.730366	\N
LOC-BK-SYN-57366-2352	BK-SYN-57366	28.8500, 79.1000	8	2026-08-29 12:06:42.469765	\N
LOC-BK-SYN-57366-1089	BK-SYN-57366	28.8500, 79.1000	8	2026-08-29 12:11:01.23462	\N
LOC-BK-SYN-57366-6079	BK-SYN-57366	28.8500, 79.1000	8	2026-08-29 12:50:46.225982	\N
LOC-BK-SYN-57366-7244	BK-SYN-57366	28.8500, 79.1000	8	2026-08-29 13:16:37.369995	\N
LOC-BK-SYN-24626-0608	BK-SYN-24626	28.8500, 79.1000	8	2026-08-29 17:49:00.743493	Apiary1 - New Flora
LOC-BK-SYN-24626-0611	BK-SYN-24626	28.8500, 79.1000	8	2026-08-30 01:02:40.65527	Apiary - New Flora
LOC-BK-SYN-57366-5345	BK-SYN-57366	28.8500, 79.1000	8	2026-08-30 20:58:55.464952	Apiary - New Flora
LOC-BK-SYN-57366-7328	BK-SYN-57366	28.8500, 79.1000	8	2026-08-30 21:32:07.444338	Apiary - New Flora
\.


--
-- Data for Name: batch_harvest_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_harvest_mapping (batch_id, harvest_id) FROM stdin;
BT-YW0LVUTWW9C5-20260829-01	HB-BK0001-20260820-01
BT-YW0LVUTWW9C5-20260829-01	HB-BK0001-20260824-02
BT-YW0LVUTWW9C5-20260829-02	HB-BK-SYN-57366-20260829-01
BT-YW0LVUTWW9C5-20260829-02	HB-BK-SYN-24626-20260829-9629
BT-YW0LVUTWW9C5-20260829-03	HB-BK-SYN-57366-20260828-1287
BT-YW0LVUTWW9C5-20260829-04	HB-BK-SYN-24626-20260829-8519
BT-YW0LVUTWW9C5-20260829-05	HB-BK-SYN-24626-20260829-8519
BT-IJIZU2F59WYI-20260830-01	HB-BK-SYN-24626-20260829-8519
BT-IJIZU2F59WYI-20260830-02	HB-BK-SYN-24626-20260829-8519
BT-IJIZU2F59WYI-20260830-03	HB-BK-SYN-24626-20260829-8519
BT-IJIZU2F59WYI-20260830-04	HB-BK-SYN-24626-20260830-7750
BT-IJIZU2F59WYI-20260830-05	HB-BK-SYN-24626-20260829-8519
\.


--
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batches (batch_id, company_license, product_name, quantity_kg, final_lab_ulr, ulr_status, manual_report_status, is_lab_certified, created_at, manual_report_certified) FROM stdin;
BT-LIC001-20260828-01	LIC-SYN-00001	Premium Multifloral Honey	500.5	ULR-FINAL-77733	Verified	Pending	f	2026-08-28 19:29:04.369549	f
BT-YW0LVUTWW9C5-20260829-01	YW0LVUTWW9C5	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	\N	Verified	Pending	t	2026-08-29 22:32:43.62897	f
BT-YW0LVUTWW9C5-20260829-02	YW0LVUTWW9C5	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	\N	Verified	Pending	t	2026-08-29 23:03:28.8716	f
BT-YW0LVUTWW9C5-20260829-03	YW0LVUTWW9C5	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	\N	Verified	Pending	t	2026-08-30 01:04:01.070723	f
BT-YW0LVUTWW9C5-20260829-04	YW0LVUTWW9C5	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	\N	Verified	Pending	t	2026-08-30 01:14:27.57526	f
BT-YW0LVUTWW9C5-20260829-05	YW0LVUTWW9C5	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	\N	Verified	Pending	t	2026-08-30 01:22:07.22585	f
BT-IJIZU2F59WYI-20260830-01	IJIZU2F59WYI	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	ULR-ZX-7606-27207511	Verified	Pending	t	2026-08-30 11:15:20.909508	f
BT-IJIZU2F59WYI-20260830-02	IJIZU2F59WYI	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	ULR-ZX-7606-27207511	Verified	Pending	t	2026-08-30 11:30:09.29666	f
BT-IJIZU2F59WYI-20260830-03	IJIZU2F59WYI	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	ULR-ZX-7606-27207511	Verified	Pending	t	2026-08-30 11:50:17.757661	f
BT-IJIZU2F59WYI-20260830-04	IJIZU2F59WYI	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	ULR-ZX-7606-27207511	Verified	Pending	t	2026-08-30 14:01:08.781699	f
BT-IJIZU2F59WYI-20260830-05	IJIZU2F59WYI	Raw Organic Mustard & Multifloral Honey (500g Jar)	500	ULR-ZX-7606-27207511	Verified	Pending	t	2026-08-30 20:16:30.259753	f
\.


--
-- Data for Name: harvests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.harvests (harvest_id, beekeeper_id, location_id, harvest_date, flower_sources, lab_ulr, ulr_status, block_hash, tx_ref, quantity_kg, created_at, lab_report_url) FROM stdin;
HB-BK-SYN-57366-20260829-01	BK-SYN-57366	LOC-001	2026-08-29	["Mustard"]	ULR-KY-3632-50252367	Verified	45bb472e45bb472e45bb472e45bb472e45bb472e45bb472e45bb472e45bb472e	0x4f89edb84f89edb84f89edb84f89edb84f89edb84f89edb84f89edb84f89	160	2026-08-29 12:11:45.625478	\N
HB-BK-SYN-24626-20260829-9629	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-29	["Mustard", "Eucalyptus", "Acacia"]	ULR-RJ-6841-51148441	Verified	4bad90144bad90144bad90144bad90144bad90144bad90144bad90144bad9014	0x49dc1e5849dc1e5849dc1e5849dc1e5849dc1e5849dc1e5849dc1e5849dc	160	2026-08-29 17:50:09.723897	\N
HB-BK-SYN-57366-20260828-1287	BK-SYN-57366	LOC-001	2026-08-28	["Mustard", "Multifloral"]	ULR-RJ-6841-51148441	Verified	740769d2740769d2740769d2740769d2740769d2740769d2740769d2740769d2	0x4188a3a84188a3a84188a3a84188a3a84188a3a84188a3a84188a3a84188	160	2026-08-30 00:52:01.296736	\N
HB-BK-SYN-24626-20260829-8519	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-29	["Mustard", "Eucalyptus"]	\N	Verified	b83ca33b83ca33b83ca33b83ca33b83ca33b83ca33b83ca33b83ca33	0x4729e1804729e1804729e1804729e1804729e1804729e1804729e1804729	160	2026-08-30 01:08:18.602881	\N
HB-BK-SYN-57366-20260829-9086	BK-SYN-57366	LOC-001	2026-08-29	["Mustard"]	ULR-RJ-6841-51148441	Verified	5b26f35a5b26f35a5b26f35a5b26f35a5b26f35a5b26f35a5b26f35a5b26f35a	0x65ea0cb065ea0cb065ea0cb065ea0cb065ea0cb065ea0cb065ea0cb065ea	160	2026-08-30 01:34:09.09432	\N
HB-BK-SYN-24626-20260830-9842	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard", "Eucalyptus"]	ULR-ZX-7606-27207511	Verified	68ba77b68ba77b68ba77b68ba77b68ba77b68ba77b68ba77b68ba77b	0x5d4253805d4253805d4253805d4253805d4253805d4253805d4253805d42	160	2026-08-30 11:12:49.851668	\N
HB-BK-SYN-24626-20260830-7750	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-UX-3752-56245895	Verified	33d01ec33d01ec33d01ec33d01ec33d01ec33d01ec33d01ec33d01ec	0x598e2580598e2580598e2580598e2580598e2580598e2580598e2580598e	160	2026-08-30 13:56:27.767171	\N
HB-BK-SYN-24626-20260830-1129	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	\N	Verified	6a1c7f286a1c7f286a1c7f286a1c7f286a1c7f286a1c7f286a1c7f286a1c7f28	0x1a778b701a778b701a778b701a778b701a778b701a778b701a778b701a77	160	2026-08-30 14:17:01.263403	\N
HB-BK-SYN-24626-20260830-6073	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard", "Eucalyptus"]	ULR-UX-3752-56245895	verified	6d2f78a26d2f78a26d2f78a26d2f78a26d2f78a26d2f78a26d2f78a26d2f78a2	0x92274609227460922746092274609227460922746092274609227460	160	2026-08-30 17:58:36.286023	\N
HB-BK-SYN-24626-20260830-7554	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-UX-3752-56245895	verified	2cea726e2cea726e2cea726e2cea726e2cea726e2cea726e2cea726e2cea726e	0x173d4948173d4948173d4948173d4948173d4948173d4948173d4948173d	160	2026-08-30 18:25:47.660994	\N
HB-BK-SYN-57366-20260830-4316	BK-SYN-57366	LOC-001	2026-08-30	["Mustard"]	ULR-RJ-6841-51148441	verified	343d4f5343d4f5343d4f5343d4f5343d4f5343d4f5343d4f5343d4f5	0x3df524803df524803df524803df524803df524803df524803df524803df5	160	2026-08-30 19:13:24.353965	\N
HB-BK-SYN-57366-20260830-5854	BK-SYN-57366	LOC-001	2026-08-30	["Mustard"]	ULR-RJ-6841-51148441	verified	728e6493728e6493728e6493728e6493728e6493728e6493728e6493728e6493	0x588c2d00588c2d00588c2d00588c2d00588c2d00588c2d00588c2d00588c	160	2026-08-30 19:39:05.871281	\N
HB-BK-SYN-24626-20260830-0972	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-RJ-6841-51148441	verified	1922f7151922f7151922f7151922f7151922f7151922f7151922f7151922f715	0x4805e5184805e5184805e5184805e5184805e5184805e5184805e5184805	160	2026-08-30 19:43:40.984994	\N
HB-BK-SYN-24626-20260830-3027	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-RJ-6841-51148441	verified	1bd9b9d31bd9b9d31bd9b9d31bd9b9d31bd9b9d31bd9b9d31bd9b9d31bd9b9d3	0x79f6206079f6206079f6206079f6206079f6206079f6206079f6206079f6	160	2026-08-30 19:48:43.04036	\N
HB-BK-SYN-57366-20260830-4660	BK-SYN-57366	LOC-001	2026-08-30	["Mustard"]	ULR-ZX-7606-27207511	verified	765e80cd765e80cd765e80cd765e80cd765e80cd765e80cd765e80cd765e80cd	0x65d3de4065d3de4065d3de4065d3de4065d3de4065d3de4065d3de4065d3	160	2026-08-30 20:46:44.674966	\N
HB-BK-SYN-57366-20260830-9600	BK-SYN-57366	LOC-001	2026-08-30	["Mustard"]	ULR-UX-3752-56245895	verified	4cdc01ee4cdc01ee4cdc01ee4cdc01ee4cdc01ee4cdc01ee4cdc01ee4cdc01ee	0x74d3b27874d3b27874d3b27874d3b27874d3b27874d3b27874d3b27874d3	98	2026-08-30 21:17:49.610431	\N
HB-BK-SYN-57366-20260830-4866	BK-SYN-57366	LOC-BK-SYN-57366-2352	2026-08-30	["Mustard", "Eucalyptus", "Sunflower", "Multifloral"]	ULR-UX-3752-56245895	verified	2e356302e356302e356302e356302e356302e356302e356302e35630	0x41aa090041aa090041aa090041aa090041aa090041aa090041aa090041aa	57	2026-08-30 21:30:55.065904	\N
HB-BK-SYN-24626-20260830-2046	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-UX-3752-56245895	verified	5bfdb24f5bfdb24f5bfdb24f5bfdb24f5bfdb24f5bfdb24f5bfdb24f5bfdb24f	0x525ff98525ff98525ff98525ff98525ff98525ff98525ff98525ff98	160	2026-08-30 23:40:02.067028	\N
HB-BK-SYN-24626-20260830-2697	BK-SYN-24626	LOC-BK-SYN-24626-0608	2026-08-30	["Mustard"]	ULR-UX-3752-56245895	verified	\N	\N	160	2026-08-30 23:53:22.724966	\N
\.


--
-- Data for Name: health_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_logs (log_id, location_id, status, notes, inspection_date, created_at) FROM stdin;
1	LOC-BK-SYN-24626-0608	Healthy	well	2026-08-29	2026-08-29 17:50:27.066525
2	LOC-BK-SYN-24626-0608	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-29	2026-08-29 17:50:55.627134
3	LOC-BK-SYN-24626-0608	Healthy	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-29	2026-08-30 01:09:09.785303
4	LOC-001	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-29	2026-08-30 01:09:47.168087
5	LOC-001	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-30	2026-08-30 10:55:33.866269
6	LOC-001	Needs Attention	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-30	2026-08-30 10:56:11.9579
7	LOC-001	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-30	2026-08-30 10:56:18.47427
8	LOC-001	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-30	2026-08-30 10:56:42.225885
9	LOC-001	Critical	नियमित निरीक्षण पूर्ण। सब ठीक है।	2026-08-30	2026-08-30 20:56:42.568945
10	LOC-BK-SYN-57366-7244	Needs Attention	बॉक्स नंबर 2 और 4 में अच्छी पराग गतिविधि देखी गई, रानी मधुमक्खी सक्रिय है।	2026-08-30	2026-08-30 21:33:08.939743
\.


--
-- Data for Name: beekeeper_registry; Type: TABLE DATA; Schema: verification; Owner: postgres
--

COPY verification.beekeeper_registry (id, beekeeper_id, registered_name, state, status) FROM stdin;
ad3f4e6c-5401-4fdb-a72f-2267c6c6f6b7	BK-SYN-41987	संमानित इन्द्रजित सिन्हा	Sikkim	EXPIRED
9771c8e6-9009-4abc-a389-131ac102cae3	BK-SYN-38774	सीमा थापाजी	Tripura	EXPIRED
365db7c0-1fd8-48d6-9778-90ee13b95fb2	BK-SYN-54994	सम्मानसूचक नीरव रॉय	Kerala	SUSPENDED
aaf0fcec-8265-4164-8bf1-fb69031844cc	BK-SYN-29915	िकशोरी द्विवेदीजी	Chandigarh	ACTIVE
acb328c9-3386-40f5-b0fe-8205ccfbd578	BK-SYN-38142	सीमा बलासुब्रमानियम	Bihar	EXPIRED
f6426a0a-5be0-448f-9774-2ac85c1e16be	BK-SYN-32251	रुपिन्द्र नाथजी	Chandigarh	EXPIRED
83c39245-22bf-4c8d-b171-c64ea916bcec	BK-SYN-76596	कर्ण डी’कोस्टाजी	Manipur	EXPIRED
7267841f-8a72-4c03-b2ad-c6c0c6f6eb92	BK-SYN-74884	शङ्कर ताम्बे	Assam	EXPIRED
72700dce-f6b4-4333-8013-657936014d3d	BK-SYN-52525	अनुजा गुरुंग	Manipur	SUSPENDED
f6ee2cc6-7a8d-4958-8cf8-903e58f96201	BK-SYN-95535	सम्मानसूचक अभिलाषा टंडन	Gujarat	ACTIVE
4382dcca-322d-4602-8cd9-7d984a669d2b	BK-SYN-62600	विशाल पिल्लई	Haryana	ACTIVE
e97b115b-1d4c-4fe8-815d-9e62532f3ec0	BK-SYN-33289	राजन रंगनजी	Kerala	SUSPENDED
8eb6c9b3-ecc6-496d-99e3-ca7ce5521ec0	BK-SYN-03202	आदरवाचक लीला मंडल	Tripura	EXPIRED
399d6005-ef8f-48ce-be75-635c58e2c146	BK-SYN-43646	सम्मानसूचक लीलावती कौल	Bihar	ACTIVE
94036b1c-13bd-4f69-ad4e-c2a611eac02e	BK-SYN-10582	बृजेश तमांगजी	Madhya Pradesh	EXPIRED
f81a2348-24b5-4c4a-9df8-16f59c3c1ae2	BK-SYN-69618	संमानित मोहना चक्रवर्ती	Telangana	EXPIRED
c59cce01-3ace-4d06-b595-6853582ffce7	BK-SYN-13018	आदरसूचक प्रभात रंगन	Karnataka	SUSPENDED
30bf5a85-5ebe-4b13-b1bb-738f1b3770cf	BK-SYN-91245	अनिला मेहताजी	Puducherry	EXPIRED
44ef21b2-9404-460d-bb3d-ad1f22ca4dbb	BK-SYN-70285	सीता अरोराजी	Goa	ACTIVE
50783ed1-4f8a-463d-8eb0-b5e24ad6439f	BK-SYN-98156	धनञ्जय शर्मा	Goa	SUSPENDED
89fe9088-f535-47e5-a992-d2e3c4239e2f	BK-SYN-15419	जयन्त अगरवालजी	Rajasthan	SUSPENDED
11303daf-5f8a-4675-bec0-70e35a1db0cb	BK-SYN-08851	विमला बनर्जी	Jammu and Kashmir	EXPIRED
21004c66-f340-44e6-b958-69d8348a51be	BK-SYN-93150	सम्मानात्मक दयाराम चोधरी	Chandigarh	ACTIVE
afa2a2c5-1e5f-4fc9-bee6-e439227aac49	BK-SYN-02011	अभिलाषा टंडनजी	Jharkhand	ACTIVE
1ea63a0f-0783-4b1b-b9ad-72db2f871727	BK-SYN-09956	वसन्त श्रीवास्तवजी	Jharkhand	ACTIVE
6a9b0da0-e552-44ab-afa6-e36b7e52e4b4	BK-SYN-76232	आदरवाचक लक्ष्मी खत्री	Manipur	EXPIRED
5466ea02-9ad6-4f16-a224-803724295f2e	BK-SYN-12184	रावण चोपराजी	Rajasthan	ACTIVE
df449683-07d0-4cb8-87ed-0f50500f9edd	BK-SYN-48169	अमर गुहा	Jharkhand	EXPIRED
da568797-2bb0-45f0-96ce-55ffda5fdd75	BK-SYN-82730	जगन्नाथ रॉय	Mizoram	ACTIVE
3d54747d-5dae-43f4-a68e-8f70bca4d855	BK-SYN-26076	आदरसूचक पार्वती दासगुप्ता	Odisha	ACTIVE
1ada68a2-ea86-48f2-9baa-a20bba6f1c9b	BK-SYN-25272	संमानित रञ्जित जैन	Goa	SUSPENDED
1799a9a2-6c44-49b7-9033-9b586d9c4098	BK-SYN-34915	आदरवाचक रुपिन्द्र कुमार	Kerala	ACTIVE
db2855e1-da68-43ee-b039-6dd7592bdbec	BK-SYN-27350	स्वपन कौल	Himachal Pradesh	SUSPENDED
26c70328-4d3b-4d42-b696-7b0320cbd9f8	BK-SYN-60241	देवी सेनगुप्ताजी	Lakshadweep	EXPIRED
921a33c6-cf6e-41ff-868a-74c91e633e59	BK-SYN-18709	मनीश तमांगजी	Uttarakhand	ACTIVE
bfe7f7cb-5e20-4c5c-8211-5083037d8b7b	BK-SYN-73128	दिलीप रोद्रिगुएस	Goa	SUSPENDED
b938f09b-42a3-4a5d-b300-90a020ca5903	BK-SYN-65466	लोचन यादवजी	Delhi	EXPIRED
8a0cccf7-155a-452a-85ba-a3f618bb83c8	BK-SYN-22105	दिव्या जयरामन	Chhattisgarh	ACTIVE
42883c81-e747-47c7-80fa-a9f921523183	BK-SYN-67328	शङ्कर टंडनजी	Lakshadweep	ACTIVE
36e20f3e-8ed0-413f-af14-031793e5b06d	BK-SYN-80830	आदरसूचक लीना सरीन	Jharkhand	ACTIVE
a0bfaecb-3b10-4647-935a-66c6cc6c3380	BK-SYN-72226	आभा पवार	Jharkhand	ACTIVE
867d9c41-51e5-4fcd-afe7-655f4e99451b	BK-SYN-87839	प्रबोध मुख़र्जी	Tripura	SUSPENDED
36e036fe-3e21-47bf-a723-b1ab43d25e19	BK-SYN-56095	संमानित लीलावती मालिक	Andhra Pradesh	EXPIRED
095f3fb0-3bda-42c5-8979-74e6f7a4e5b6	BK-SYN-89427	सावित्री मैती	Nagaland	SUSPENDED
ece0c58f-7a21-49b8-81d3-1d007d8e55d0	BK-SYN-52001	सम्मानात्मक अर्चना खान	Telangana	SUSPENDED
60013880-c660-4617-98b4-af609bbb3d40	BK-SYN-56062	पद्म राय	Goa	ACTIVE
ad2bc3e0-736e-4f1a-91d0-2c5286723a39	BK-SYN-26806	अनिल श्रीवास्तव	Uttar Pradesh	SUSPENDED
4a03251f-9cfc-4bc5-88b9-26145256a6c8	BK-SYN-82559	माननीय ललित दुत्ता	Nagaland	SUSPENDED
81915c4a-24d7-4786-939c-22455a822c96	BK-SYN-74777	रवि बलासुब्रमानियमजी	Sikkim	EXPIRED
03e9468b-0cc8-4372-82d2-311fa79d077c	BK-SYN-20494	सम्मानसूचक नवीन मंडल	Sikkim	SUSPENDED
60b6a6a6-42e8-4441-a199-0c77e43cc3ec	BK-SYN-09968	आदरवाचक सुदर्शन चक्रवर्ती	Manipur	EXPIRED
5c254579-d1f3-4b11-b85c-2f648efcb680	BK-SYN-21052	इन्दु डी’सोउज़ा	West Bengal	SUSPENDED
577e6340-a73d-4485-a81b-5791af970bd3	BK-SYN-20316	जितेन्द्र डी’सोउज़ाजी	Meghalaya	ACTIVE
e924dec0-53f8-4718-b76f-b72002ea1f94	BK-SYN-90278	हर्शद सिंहजी	Ladakh	SUSPENDED
5fd52b47-3c5e-4333-a167-2d2619c17e6b	BK-SYN-11939	सम्मानसूचक शोभा भटनागर	Jammu and Kashmir	SUSPENDED
d25195c2-592f-4ab8-8081-88052e563c3b	BK-SYN-73478	संजीव त्रिवेदी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
675d8fe6-5771-4943-8694-6e89fb2192b4	BK-SYN-94989	लाल वेंकटएसन	Sikkim	EXPIRED
26cbe933-d802-4b8d-b89e-87112af5c13f	BK-SYN-94864	सम्मानसूचक सुधीर कलिता	Lakshadweep	EXPIRED
7ac65382-c076-4138-ba98-cfeb8d5cc195	BK-SYN-67449	राजन कौलजी	Karnataka	EXPIRED
67d8b9b0-9948-4f69-9798-38492aaa165d	BK-SYN-50511	अनुजा डी’कोस्टा	Uttarakhand	EXPIRED
42b9d1d5-c460-4b4f-950c-ee6020280a1e	BK-SYN-22239	अर्चना तमांगजी	Kerala	EXPIRED
75233024-59ff-494c-8ea4-cdf5a43cc85b	BK-SYN-05976	सुरज सैनीजी	Andhra Pradesh	ACTIVE
305e332c-3972-4679-b8d6-3f672c0835e5	BK-SYN-72392	सुरेन्द्र चक्रवर्तीजी	Arunachal Pradesh	EXPIRED
0bb6a946-7e22-4c90-ab10-d2ffedc77761	BK-SYN-51257	विमला गुरुंग	Uttarakhand	SUSPENDED
ad5921de-4aed-46cd-934c-04665a3ee503	BK-SYN-08535	आदरसूचक जयन्त शर्मा	Nagaland	SUSPENDED
f8fb9a04-2b1b-48c4-8857-b0e93c51dd57	BK-SYN-56218	रावण साहा	Delhi	ACTIVE
5a907781-b514-46ba-b687-b5802f200444	BK-SYN-62891	सम्मानात्मक माधव सुब्रमण्यम	Maharashtra	EXPIRED
8778ea73-8d0d-4943-8caf-0c36557fe1da	BK-SYN-83593	महेन्द्रा चक्रवर्ती	Manipur	EXPIRED
29429579-0635-4dbc-872a-56f434f073b4	BK-SYN-64336	हनुमान् चौहानजी	Jharkhand	EXPIRED
cbc98649-004e-4c87-b24a-401742bd2f2d	BK-SYN-48988	इन्द्रजित शुक्ला	Maharashtra	SUSPENDED
7b2bad5e-6bc6-438c-8a55-b3c0dac4f28c	BK-SYN-47065	अभिलाषा चोधरी	Himachal Pradesh	SUSPENDED
759460a8-b637-4030-a2b9-4811a2de16ca	BK-SYN-94905	जयेन्द्र प्रधानजी	Goa	SUSPENDED
b12e9101-5550-48a7-955e-9faa9e7e8a31	BK-SYN-10531	अनुपम अहलूवालियाजी	Chhattisgarh	SUSPENDED
87aa9bab-a11d-4cea-835d-778307bdc876	BK-SYN-82228	सिद्धार्थ बुरुाह	Chandigarh	SUSPENDED
3558c75e-f840-4bd1-b1cb-943cad5b849e	BK-SYN-51468	अर्चना सरीन	Puducherry	SUSPENDED
5bdeace1-64bf-4c8f-aa3b-27bf2d86184d	BK-SYN-46637	माननीय वसन्त जेटली	Himachal Pradesh	ACTIVE
c49d8a81-dfaa-4729-a49e-82a9efecf60e	BK-SYN-33757	आदरसूचक जय चतुर्वेदी	Assam	ACTIVE
071e1f92-f538-4b58-89cd-b60edd568f8a	BK-SYN-80290	चन्द्रकान्ता जेटली	Odisha	SUSPENDED
8c106275-f4b9-46a1-aeb3-829e70e812fc	BK-SYN-32796	दीप्ति बलासुब्रमानियम	Odisha	SUSPENDED
1da8b8c4-96c2-4df6-b951-8079ef954876	BK-SYN-37781	कैलाश रॉयजी	West Bengal	EXPIRED
f60234fa-edac-4be5-a8fd-0183631a4937	BK-SYN-56635	शंकर साहा	Kerala	SUSPENDED
abc91c57-2381-4563-8b42-05e282f892de	BK-SYN-46282	आदरवाचक श्रीपति सक्सेना	Arunachal Pradesh	ACTIVE
e7a5f5e1-a573-4743-bff4-66b96a9b0672	BK-SYN-29892	मोहिनी मजूमदार	Lakshadweep	ACTIVE
a50afebf-3f83-4983-bf1a-feceba585791	BK-SYN-70378	आदरसूचक प्रसाद दास	Puducherry	EXPIRED
f244046b-a0c4-4dc4-8f6e-1b676c08cc2b	BK-SYN-96794	आदरवाचक सुमती गुहा	Uttarakhand	ACTIVE
2763680f-ca7b-42e6-92c8-c5a51c0b1f52	BK-SYN-38681	अरुंधती भटनागर	Ladakh	ACTIVE
fd28dee0-674f-4baa-9ac2-f34a4e4a7992	BK-SYN-18308	यश कपूरजी	Nagaland	EXPIRED
2f5eef03-e004-4abe-be53-79c3c310d651	BK-SYN-21397	रवि झा	Kerala	EXPIRED
265a2ffd-fec4-4ee7-b567-1a6640711f74	BK-SYN-52756	माननीय संजित लोबो	Mizoram	SUSPENDED
0d5cbf6e-803c-488f-8743-908f9ef49d56	BK-SYN-62251	संमानित पद्मावती पाण्डेय	Meghalaya	ACTIVE
f242ed20-5450-4dbb-92ab-74a0c25fb945	BK-SYN-81364	सम्मानसूचक क्षितिज तिवारी	Himachal Pradesh	ACTIVE
f168b825-e94c-42c5-906a-bf2f12395b3d	BK-SYN-51594	चेतना चोधरी	Lakshadweep	ACTIVE
04131deb-9d0e-487b-9d3c-040ee2445874	BK-SYN-49753	संमानित बल हजारिका	Mizoram	ACTIVE
46a65c10-1ee4-4189-af9b-5099067ac5f9	BK-SYN-48987	सुलभा मुख़र्जीजी	Gujarat	EXPIRED
4a2515c8-d707-46f1-a442-7dfe21db1a57	BK-SYN-02240	माननीय श्री मल्होत्रा	Puducherry	SUSPENDED
ee8095b2-31e7-4aa2-a801-ae4be36b503c	BK-SYN-91191	रघु गुहाजी	Tamil Nadu	ACTIVE
a09a5737-e81d-4480-b909-ebf5ee8d0a5d	BK-SYN-28384	रोहना रंगनजी	Himachal Pradesh	ACTIVE
17b6110b-cec7-4087-95e0-6cf8f1b69646	BK-SYN-76428	ईश रोद्रिगुएसजी	Chhattisgarh	ACTIVE
6ce813d9-c3d0-4bb2-b534-ffdd606c4eb1	BK-SYN-31663	माननीय प्रमोद प्रधान	Andaman and Nicobar Islands	ACTIVE
14f51e46-cac8-4caa-acbd-5f69b66d78fb	BK-SYN-79456	सुनीता थापाजी	Tripura	ACTIVE
aa0d69de-e027-4362-b608-e17dd56e291c	BK-SYN-41035	आदरसूचक मोहना कदम	Gujarat	EXPIRED
db7def06-9a0a-467f-936b-f189c9d194a9	BK-SYN-59723	ईश प्रसादजी	Ladakh	EXPIRED
2be3db70-542d-4973-ab7a-039def5aa1df	BK-SYN-64929	सम्मानात्मक सचिन टंडन	Madhya Pradesh	ACTIVE
d8ae393d-02f7-442b-9c9e-c4b098620a52	BK-SYN-41240	श्यामल दास	Himachal Pradesh	EXPIRED
bba55a0a-9bb1-4445-af23-77c4961a9c49	BK-SYN-03967	गुलज़ार सेनजी	Meghalaya	SUSPENDED
9dc87ce1-9dc2-46cf-ac3c-356416ef4448	BK-SYN-02771	उत्तम बनर्जी	Andaman and Nicobar Islands	ACTIVE
4f7546ad-525b-4a00-983c-e984e0cd17bc	BK-SYN-19564	मणि प्रसादजी	Haryana	EXPIRED
cd3cceae-c713-4bee-a0a0-cd56310e1189	BK-SYN-51546	आदरसूचक चन्दना तिवारी	Puducherry	SUSPENDED
430d5cdb-5313-47c5-bb1f-a26633d19f2a	BK-SYN-12672	राधा मजूमदारजी	Karnataka	ACTIVE
87bed563-70a2-4348-972b-0cb2c5908a53	BK-SYN-61241	उमा चतुर्वेदी	Karnataka	SUSPENDED
37dcef38-7426-474d-82b5-deaae4aa5e1d	BK-SYN-64576	तृष्णा मिस्त्री	Assam	ACTIVE
7a344b96-4623-4e2e-95c6-994148f0d5a0	BK-SYN-38547	आदरवाचक किरण बनर्जी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
8d81aaf3-eaa3-4db5-937b-4cefb35ab500	BK-SYN-14383	माननीय परवीन प्रसाद	West Bengal	SUSPENDED
3d284c60-53ec-4e24-8e0a-921d4993f338	BK-SYN-37865	महावीर गुरुंग	Jharkhand	EXPIRED
5027e46e-8ff2-4fde-b7dd-6cbd0a08a97d	BK-SYN-86843	सम्मानसूचक एषा शुक्ला	West Bengal	EXPIRED
1bc53674-e820-4b43-a43f-a41e835cad0a	BK-SYN-71603	आदरवाचक सुनीता चौहान	Uttar Pradesh	EXPIRED
d04d5c21-2051-4194-8394-7abf7d5d50ab	BK-SYN-60943	सम्मानात्मक राजीव जयरामन	Andaman and Nicobar Islands	SUSPENDED
89f39bb0-f134-4e82-b15b-8d7865807c87	BK-SYN-53726	संमानित रत्नम सेन	Uttar Pradesh	EXPIRED
ad2d444f-d98f-42ef-b05b-b4e04c7e370e	BK-SYN-90728	शंतनु मुख़र्जीजी	Lakshadweep	EXPIRED
70b32067-86ba-4cd2-8d4e-c1daced61ad8	BK-SYN-98222	कुणाल गुहाजी	Tripura	SUSPENDED
1eb0564c-4031-4074-853c-b476f0253e63	BK-SYN-61225	प्रबोध कदमजी	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
c70a1429-ceb0-4761-bf82-3beb2d1db1a8	BK-SYN-39393	कशोर रॉयजी	Himachal Pradesh	SUSPENDED
575a8942-015a-4d81-b761-7a3b9a0178c1	BK-SYN-75009	अनिरुद्ध गुहाजी	Jharkhand	SUSPENDED
25979a75-7714-4d94-b8f4-e6022f2eb7b4	BK-SYN-81545	शकुन्तला सरकार	Andaman and Nicobar Islands	SUSPENDED
c4fea842-966d-461f-9f02-60a3a63fff0f	BK-SYN-61558	संदीप रायजी	Maharashtra	EXPIRED
f24b64b2-dd86-491a-b6a0-d72eebccb543	BK-SYN-53436	अवनी मित्राजी	Madhya Pradesh	ACTIVE
ec6766cd-5e5e-40b1-90bf-2eceb63e4ed2	BK-SYN-93340	माया राय	Puducherry	SUSPENDED
b2f77611-d205-4a86-bb4b-e7002415fd9c	BK-SYN-02076	माननीय विमल भट	Uttarakhand	EXPIRED
a443bfba-ec98-40df-9545-62127e50fd7e	BK-SYN-80336	आदरवाचक विपुल गावडे	Himachal Pradesh	SUSPENDED
f3bb7ef3-f697-4210-8cd8-406ecf391316	BK-SYN-30425	माननीय कालिदास पाण्डेय	Rajasthan	SUSPENDED
da2bd56c-2378-43a8-86f4-ea71a2a6aacb	BK-SYN-44127	शङ्कर नायरजी	Uttar Pradesh	EXPIRED
2c1bc023-8765-457c-881a-dd8e2446dc3a	BK-SYN-99457	सम्मानसूचक उमा जयरामन	Delhi	EXPIRED
4c358828-5fdb-4b0e-ac51-861c07122048	BK-SYN-05322	संजीव शाह	Mizoram	ACTIVE
6553e2ac-cb22-4c0a-937a-5881e0816745	BK-SYN-23628	सम्मानात्मक सुधीर चोपरा	Kerala	EXPIRED
737fc638-d4cb-41e3-b823-e81579f920c3	BK-SYN-12903	आदरसूचक शकुन्तला टंडन	Karnataka	ACTIVE
e293155d-62f3-41e5-8b17-dbb6bec41df8	BK-SYN-72371	विजय बुरुाहजी	Meghalaya	ACTIVE
30d7db63-0fde-4f4e-be5d-d6eaede938cf	BK-SYN-79714	मणि पटेल	Punjab	SUSPENDED
a597e11b-5a7c-4b93-a1f2-89fb991fda40	BK-SYN-53014	पद्म मिश्राजी	Bihar	SUSPENDED
396636c0-31e5-4f0b-9aec-e541c6002d72	BK-SYN-96111	शेष सिन्हाजी	Chandigarh	SUSPENDED
8da8ede8-5ce4-4f4c-8fda-fe79deda9d58	BK-SYN-09287	संमानित श्यामा पाण्डेय	Meghalaya	EXPIRED
e7218de1-b57d-4fee-bee1-75ca2f2c5a7b	BK-SYN-15416	रचना रॉय	Lakshadweep	SUSPENDED
d02345d5-3af1-42ee-a784-c8e065f84c31	BK-SYN-41005	ब्रह्मा शुक्ला	Jharkhand	EXPIRED
2d4035fe-0180-46f3-9b82-e48edc1582e6	BK-SYN-35276	सुनीती मालिक	Delhi	EXPIRED
7ef1367a-bfbd-4b8a-868d-72d3336b73ad	BK-SYN-09793	मञ्जु श्रीवास्तव	Tamil Nadu	ACTIVE
2c96e7d2-6b0a-4ca9-a955-1917967a65f9	BK-SYN-99354	ऐश्वर्या तमांग	Goa	ACTIVE
8fbe679c-aa6f-47ea-9368-a4b9ca656be1	BK-SYN-70129	संमानित अनुष्का सरकार	Mizoram	EXPIRED
608cab6e-0fdc-4929-879a-312ca666ec12	BK-SYN-33269	कमला पाटिलजी	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
cb298102-0239-40ea-9007-ed5abe643b96	BK-SYN-08345	संमानित कपिल प्रधान	Puducherry	ACTIVE
2365ed8d-2798-4970-bb11-41ac62bf32bc	BK-SYN-28977	कम्बोज सिंह	Chandigarh	SUSPENDED
4dee3e0f-07e1-4d28-a60a-b08cc232e918	BK-SYN-96865	विद्या कुमारजी	Andhra Pradesh	ACTIVE
74ed800d-030a-4c0a-93ab-2463c3f23ba9	BK-SYN-52154	अमला द्विवेदीजी	Goa	ACTIVE
278424de-9a94-4248-876c-066a30bb6656	BK-SYN-63060	सीता भट्टाचार्य	West Bengal	ACTIVE
0d8fc417-d251-444b-ba6c-da46c5d558e0	BK-SYN-63465	माननीय अमृत सिंह	Sikkim	EXPIRED
732ce1d6-6685-4e00-8c6b-729314bf6b6d	BK-SYN-89475	प्रतिभा मैतीजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
1e181b17-9db1-49e7-a221-bf7faadc2e2f	BK-SYN-80367	उत्तम भरद्वाज	Haryana	SUSPENDED
113aed47-f2bd-4691-8166-37a74400c88e	BK-SYN-62901	संमानित पूर्णिमा तमांग	Rajasthan	ACTIVE
2ce3a9bc-39c5-42bb-9b16-8698cba7fc92	BK-SYN-82126	महात्मा खत्री	Andhra Pradesh	ACTIVE
3591ada6-b525-483e-82bc-7006893f53ef	BK-SYN-57976	आदरसूचक प्रणव चोधरी	Ladakh	SUSPENDED
ac484c14-2cc7-4d95-af32-6927a0bdd492	BK-SYN-63455	अनिरुद्ध डी’कोस्टाजी	Punjab	SUSPENDED
6bacdcec-a11d-4da4-b624-56c9df6c492b	BK-SYN-58008	लीला मिस्त्री	Ladakh	ACTIVE
7a7bb3e5-e202-47d6-ab99-59c4653bb852	BK-SYN-95634	सम्मानसूचक कशोर दुत्ता	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
fa16cac6-f127-4fb2-a078-b123a409ddf7	BK-SYN-43523	लक्ष्मण सिन्हाजी	Meghalaya	EXPIRED
686c12b3-f447-4535-ab87-e2157efd9cbe	BK-SYN-96375	आदरसूचक इन्द्रजित अहलूवालिया	Manipur	ACTIVE
39e09ce5-2e16-4cf2-b14d-a0c048e80a51	BK-SYN-23970	महावीर चवन	Karnataka	ACTIVE
61222683-8bf3-457e-a5b5-000114204896	BK-SYN-17480	इन्द्रजित मेहता	Punjab	EXPIRED
ab6be14f-f96f-4cfe-8bad-7ab42969eb29	BK-SYN-26224	दर्शन आहूजा	Rajasthan	EXPIRED
ff02945f-c332-4075-9a91-b64e8667117f	BK-SYN-82938	मनीश भरद्वाज	Lakshadweep	EXPIRED
2bda6533-c1dc-42be-b83a-8187195d7575	BK-SYN-57935	शेष मेहताजी	Tripura	EXPIRED
f2d14bad-d87b-4e74-a903-2f724b278924	BK-SYN-25551	सम्मानात्मक सुशीला चक्रवर्ती	Ladakh	SUSPENDED
109bae4c-aad8-46cd-9c0d-c1f88f12dc3b	BK-SYN-55220	उमा बोसजी	Uttar Pradesh	ACTIVE
e3593f55-43d0-4bc2-ae0e-2d517416c643	BK-SYN-51232	श्यामल सेनगुप्ता	Gujarat	EXPIRED
3cf781ba-abdc-46a6-9858-bdcd78d71730	BK-SYN-42703	कान्ती मालिकजी	Telangana	SUSPENDED
7fc26bb8-8e9c-498d-9cd5-ebf904763d57	BK-SYN-88373	लक्ष्मी अरोराजी	Jammu and Kashmir	EXPIRED
2186692d-2d41-4929-a399-ad492df3b003	BK-SYN-54921	पुष्पा अहलूवालियाजी	Uttar Pradesh	ACTIVE
f1732ee8-363b-4961-a056-b2484dd9f5c3	BK-SYN-48970	आदरवाचक उत्तम कौल	Rajasthan	SUSPENDED
a430bec8-2a77-4a90-a4e1-2df5926612ee	BK-SYN-80414	संमानित अनुपम श्रीवास्तव	Jharkhand	ACTIVE
10618a88-fa2c-4a4d-9a6a-bc603d934d11	BK-SYN-87045	श्याम थापा	Haryana	ACTIVE
6faa5503-dce3-44ac-b958-a131c55fa9d0	BK-SYN-20464	आदरसूचक हरीश सिन्हा	Ladakh	ACTIVE
ce08abc1-8a47-4e73-8d65-d9e5bfb1d329	BK-SYN-23594	श्यामल ताम्बेजी	Arunachal Pradesh	ACTIVE
c0749c46-76a4-45e7-89d9-53c921b37770	BK-SYN-93061	माननीय सूर्य शर्मा	Rajasthan	EXPIRED
e4e336d6-78ff-48ea-8051-43d7f1f60b98	BK-SYN-91324	आदरसूचक दीपक देशपांडे	Jharkhand	SUSPENDED
4f6be477-c5a2-4406-987e-73db61b8f66e	BK-SYN-12076	आदरवाचक सरस्वती पाटिल	Kerala	EXPIRED
d4f3663c-8acc-4568-8eba-9ec3589c69b8	BK-SYN-35839	रचना नाथ	Tripura	SUSPENDED
e5525b2d-bfc0-469d-a97d-62e3eab30cfe	BK-SYN-35979	सम्मानात्मक अमृता सरीन	West Bengal	EXPIRED
2b4df407-365f-4135-8445-30a3e39c7ec7	BK-SYN-47357	माननीय सीता चोपरा	Assam	ACTIVE
67a37bd3-78ab-47b4-9120-f5046aba17d9	BK-SYN-78653	प्रमोद तिवारी	Chhattisgarh	SUSPENDED
a19f21f5-c291-4d9b-a15d-725d04017125	BK-SYN-13871	रत्न अगरवाल	Karnataka	EXPIRED
52503b9a-14f2-4ca5-860b-fb9ca9e6508e	BK-SYN-18815	नंद चटर्जी	Punjab	EXPIRED
8cbba731-8ac9-4f34-8f63-05eeb8313808	BK-SYN-73019	वासिष्ठ चौहानजी	Himachal Pradesh	EXPIRED
1d496983-ca30-46c7-b22e-d51aa899faef	BK-SYN-87088	संमानित नेहा पाटिल	Bihar	ACTIVE
273bf8e4-2fb3-412b-b7ef-87ec7b8b4ab6	BK-SYN-95828	सम्मानसूचक लोचन मुख़र्जी	Assam	ACTIVE
2f59036e-8234-4ecc-9735-1debc3a9a0a3	BK-SYN-41981	आदरवाचक महात्मा मालिक	Assam	EXPIRED
279db036-7c53-478d-ab57-9c887eeee48f	BK-SYN-69568	सम्मानात्मक पद्म मंडल	Goa	SUSPENDED
9c217510-eca0-4276-bca7-3b9a74ee2cbc	BK-SYN-77610	अरुंधती अरोराजी	Tripura	SUSPENDED
5df07c7a-aed4-4b7b-9163-9a4643bd234a	BK-SYN-28866	अमित बनर्जी	Mizoram	EXPIRED
fb28a106-fdcd-44a5-99e4-917efa6a7e97	BK-SYN-00933	माननीय लीला रंगराजन	Punjab	ACTIVE
a7899ff5-fd47-4282-bb02-faae39dc4614	BK-SYN-94250	आदरसूचक हर्श रॉय	Himachal Pradesh	ACTIVE
25971c37-920b-4322-a62d-1763890830ce	BK-SYN-82863	उमा नायरजी	Bihar	SUSPENDED
ad55e66b-0ae5-4e13-81ff-dc7ea6dafa73	BK-SYN-05645	अरुंधती प्रसादजी	Puducherry	EXPIRED
356664cc-bc31-4d14-81df-cac7d5c9d6aa	BK-SYN-74250	माननीय शिव चवन	Sikkim	SUSPENDED
db9d9551-240a-4e9a-a487-8f766f227cfc	BK-SYN-29020	एषा बोस	Gujarat	SUSPENDED
fa46f789-b482-497c-943e-3750b72b4d96	BK-SYN-58530	गौहर कलिता	Chhattisgarh	SUSPENDED
78c4e5c5-ab5a-4a3c-bc03-a4c22223ddfb	BK-SYN-06466	सम्मानसूचक महेन्द्रा राय	Punjab	ACTIVE
e51aaf43-9df2-4169-9b97-e82fcd88c0e6	BK-SYN-66080	आनन्द ताम्बेजी	Madhya Pradesh	ACTIVE
c5247e2c-a93a-4209-a203-43c35a9daa16	BK-SYN-44235	सोनल बोस	Sikkim	EXPIRED
78015930-e842-4b48-8341-853ecce57e8d	BK-SYN-40187	लता रेड्डीजी	Bihar	EXPIRED
ee091881-60bc-4a2c-8e3c-e0255f82c80e	BK-SYN-17542	इन्द्र राय	Haryana	SUSPENDED
7d2f850f-f237-4194-9e28-22866687b737	BK-SYN-65049	सुरज अहलूवालिया	Mizoram	EXPIRED
7fa604ab-048e-4b35-983f-c8d7e49f91e2	BK-SYN-58107	आदरवाचक श्याम जैन	Jammu and Kashmir	SUSPENDED
6986f3ff-38f7-4862-88a3-3627049c4359	BK-SYN-43234	हरेन्द्र त्रिवेदीजी	Nagaland	ACTIVE
5e378b9c-b775-4525-9623-64f057cd4207	BK-SYN-53142	अरविन्द पवारजी	Mizoram	SUSPENDED
fbac7c87-b85c-4881-beef-fbd94a6f92ba	BK-SYN-74893	अवनी गुरुंग	Andhra Pradesh	SUSPENDED
09c879d4-5245-4eae-a153-9f9447b1b357	BK-SYN-20361	शिव नायरजी	Jharkhand	ACTIVE
dd525753-9399-4848-b271-07d21daa3b1e	BK-SYN-31386	सुमती खानजी	Uttar Pradesh	EXPIRED
af3caa16-b42f-423d-9004-b4aa3c38fa02	BK-SYN-05467	क्षितिज लोबोजी	Rajasthan	EXPIRED
941367ea-1db9-4112-91ea-88d3f1607225	BK-SYN-93930	इन्द्रजित दुत्ताजी	Chhattisgarh	ACTIVE
6a793e8c-b7bd-4a80-9769-e2caf65395bb	BK-SYN-47377	सम्मानसूचक दीप्ति लोबो	Delhi	EXPIRED
a6073548-a303-4db9-bd54-a70a80c584de	BK-SYN-79570	चन्द्रकान्ता बोस	Ladakh	ACTIVE
fc05aa88-cf89-4254-aca5-a9e07905b700	BK-SYN-06532	जयन्ती सिन्हा	Rajasthan	ACTIVE
b33206a0-bfc5-4384-a477-52287a2470af	BK-SYN-53254	संदीप अरोरा	Nagaland	EXPIRED
028738bf-da5b-4d91-9e34-ca823e24a7d3	BK-SYN-65305	महावीर गुहा	Assam	EXPIRED
bb673b5c-6859-474d-ab90-35f4004f8bac	BK-SYN-63260	अर्चना झादवजी	Odisha	EXPIRED
b2c0ff00-6bf4-404a-963f-de0d1b3f9aa4	BK-SYN-53874	लक्ष्मी पटेलजी	Ladakh	SUSPENDED
e4559dd0-574d-4ed5-8262-ff75b058f647	BK-SYN-14654	शंकर भरद्वाजजी	Haryana	EXPIRED
f79756fb-3293-4d51-ae57-daf2fdc60b54	BK-SYN-27008	राजन मित्राजी	Telangana	EXPIRED
9f000aeb-498f-4aa1-80b4-5d2b0b5eeafc	BK-SYN-20654	नरेन्द्र नारायणजी	Chandigarh	EXPIRED
262a64f4-1f09-4877-96ff-c3d1d94fb1bc	BK-SYN-51061	पुरुषोत्तम दासगुप्ता	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
4b350288-c077-4a0f-86fd-c18d42dac30a	BK-SYN-94211	दिव्या छेत्री	Sikkim	SUSPENDED
80bc87e9-e865-4d73-a7a4-96381feb004e	BK-SYN-90662	अनुष्का मल्होत्राजी	Manipur	SUSPENDED
2a98b6d7-6123-4f00-b3d8-2d5daad97765	BK-SYN-09357	आदरसूचक रतन प्रसाद	Karnataka	ACTIVE
66a3b3fb-3d57-4750-b8ee-25f9f180e5bb	BK-SYN-72673	माननीय सीमा कुमार	Mizoram	SUSPENDED
ce03dbea-8463-4fb9-bbf9-96ffb3544ed8	BK-SYN-61023	विपुल बोसजी	Mizoram	ACTIVE
b00f9491-46c0-424a-9159-dc2199128825	BK-SYN-20735	उषा कुमार	Meghalaya	SUSPENDED
babb1f8d-9dcb-4658-a8c3-f105a44b2dc2	BK-SYN-22348	कैलाश रॉय चौधरीजी	Delhi	ACTIVE
b78e3f16-072f-4437-a810-1314fd0f8bb7	BK-SYN-61636	श्यामा पवारजी	Lakshadweep	EXPIRED
c438bdcc-b76a-4e5e-b60a-dbe9ffc7dadd	BK-SYN-11257	प्रणय कुमार	Madhya Pradesh	SUSPENDED
bb548c9f-0235-4355-adbd-75b3dfbfd1d5	BK-SYN-27463	लीला भट्टाचार्यजी	Gujarat	EXPIRED
0328296f-0cf3-4387-b253-a7144c78fe5f	BK-SYN-63178	संमानित ब्रह्मा कुमार	Andaman and Nicobar Islands	SUSPENDED
13385045-8103-4987-bd56-a3a7834972d4	BK-SYN-56811	कमल बोस	Chandigarh	SUSPENDED
90b6f241-2e88-4bf2-81c1-49bad94c178f	BK-SYN-48612	आदरवाचक अनिल कदम	Meghalaya	ACTIVE
32af7b59-d368-4397-9874-7cadc03847ad	BK-SYN-30662	संमानित राजन सिन्हा	Chhattisgarh	ACTIVE
8425eada-fd04-4a38-a9bb-967750046561	BK-SYN-06791	शर्मिला नाथ	Lakshadweep	SUSPENDED
2ef74d36-27c9-4d9e-93db-2d62a36693d1	BK-SYN-97950	वसन्त घोष	Bihar	SUSPENDED
d7c9cfec-270d-4e18-93ff-1b31be499cd0	BK-SYN-20710	रेशमी डी’कोस्टाजी	Maharashtra	EXPIRED
01993a12-791c-4053-93ea-20832b683429	BK-SYN-82674	आदरसूचक काशी त्रिवेदी	Odisha	EXPIRED
05bb9a00-08e0-4bc4-805f-1603b2d480aa	BK-SYN-31595	आदरसूचक करिश्मा चवन	Mizoram	ACTIVE
b2c6c408-651a-492c-92b8-49668bfeaa74	BK-SYN-95731	आदरवाचक नरेन्द्र खत्री	Lakshadweep	ACTIVE
639d658c-1e0e-4c49-8474-07a8bf5120bc	BK-SYN-95488	आदरसूचक दिलीप शाह	West Bengal	EXPIRED
790bbea0-99ce-4fec-8654-41c64708b078	BK-SYN-77573	शर्म नारायण	Goa	ACTIVE
1c1c59ac-4d48-44a1-9429-b34ee8db4aa6	BK-SYN-08827	आदरवाचक मञ्जुला कौल	Uttar Pradesh	ACTIVE
f49d91c6-683b-4e5f-bd25-d4108207cd2e	BK-SYN-41592	रश्मी शुक्लाजी	Goa	ACTIVE
c33cd300-b9e4-4066-8c6d-ee723647bdd4	BK-SYN-71664	माननीय प्रदीप पवार	Sikkim	EXPIRED
f34ce1d7-ea5f-4d66-a18b-5eef5e0c772d	BK-SYN-78671	असीम जयरामन	Tamil Nadu	ACTIVE
1085534e-7ff0-46c1-b616-2cb07c64c482	BK-SYN-55973	बल रेड्डीजी	Punjab	ACTIVE
f64e0309-69b4-4026-91aa-e87761a37e34	BK-SYN-79943	चण्डा मालिक	Telangana	EXPIRED
6d1d6c04-bebc-4fe2-a777-f62b1c5392ab	BK-SYN-59397	विवेक गुरुंगजी	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
6224eb18-f8b8-403f-976b-81287556a145	BK-SYN-51321	इला कपूर	Ladakh	ACTIVE
9ae81519-34d1-425c-8370-29b819dff443	BK-SYN-26815	विजया जयरामन	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
e47f8b1d-ed94-402e-949b-447b80935161	BK-SYN-96193	माननीय चण्डा अहलूवालिया	Tripura	EXPIRED
bd80e88b-d989-437b-bc9e-704c3f2e7603	BK-SYN-59147	आदरवाचक अभिलाषा तिवारी	Madhya Pradesh	SUSPENDED
3a0a3dec-397a-4098-964c-cc03bc8cdfa1	BK-SYN-25663	सुलभा आचार्य	Puducherry	SUSPENDED
0a2ab2d0-8d6d-40fc-a33a-2103f02550b1	BK-SYN-86888	मणीन्द्र भट्टाचार्यजी	Haryana	ACTIVE
7ccef01d-a84f-4392-89e3-2a4d7d59b84a	BK-SYN-93662	आदरवाचक हर्शल पिल्लई	Chhattisgarh	ACTIVE
543419a2-6c8e-42fd-b1b6-562ac11f5998	BK-SYN-61522	गुलज़ार आचार्य	Jharkhand	EXPIRED
b3ab5286-0e2c-463b-b573-5707692e2406	BK-SYN-25487	नारायण महराजी	Jammu and Kashmir	SUSPENDED
a572db21-6af5-4f24-aff1-58b4e8c86a09	BK-SYN-12055	शंतनु लोबोजी	Telangana	EXPIRED
137502fe-b935-4338-b8f4-7831f2d88900	BK-SYN-01938	सम्मानात्मक श्रीपति जयरामन	West Bengal	SUSPENDED
b4dd194d-b6e7-4689-9ac5-bf57d67adbb7	BK-SYN-28009	गौहर आचार्य	Tamil Nadu	ACTIVE
91e6fbfd-a00f-4790-9c0d-db94ff81621d	BK-SYN-51911	प्रणव पाण्डेयजी	Tripura	EXPIRED
c8a6dba7-88f9-4722-9eac-b5a4a931d597	BK-SYN-49993	मोहना चोपरा	Maharashtra	ACTIVE
03902504-e074-4450-974f-413dc7c81845	BK-SYN-19134	राजीव महराजी	Rajasthan	SUSPENDED
3679c525-e9a4-4113-867e-3a14f46fdee6	BK-SYN-52581	माननीय विजया चौहान	Jammu and Kashmir	ACTIVE
6724dd16-267e-444f-92cd-bf932632918a	BK-SYN-63803	मञ्जु सरकार	Haryana	SUSPENDED
5f0a74d6-fada-420f-bd08-3a41185d6460	BK-SYN-30983	आदरवाचक रीतिका जैन	Arunachal Pradesh	EXPIRED
e3030c51-e33d-448a-be97-c3a8efc34844	BK-SYN-45391	स्वर्ण साहा	Tripura	SUSPENDED
5584bd4d-8275-4e8b-be84-7780372e1ff8	BK-SYN-15353	रोहन साहाजी	Andhra Pradesh	SUSPENDED
80761bd1-69a9-4eab-a97c-d6a51aeedea0	BK-SYN-89078	माननीय स्वर्ण रंगराजन	Maharashtra	SUSPENDED
c35c01d7-daac-457f-bb9f-43971194edae	BK-SYN-99659	अकबर नारायण	Puducherry	ACTIVE
1e49684d-6bb7-4ac6-bba2-d07a37b63090	BK-SYN-49515	पूर्णिमा बनर्जीजी	Tamil Nadu	ACTIVE
35c9987e-3e3b-4d73-89e4-463895b1653a	BK-SYN-56163	चन्द्रकान्त कपूर	Punjab	EXPIRED
1280351c-d1d3-4c64-9d9a-306a960cd3c8	BK-SYN-00241	सुलभा महराजी	Madhya Pradesh	ACTIVE
e5510d97-9002-4b86-b4ed-70416281749a	BK-SYN-17302	संमानित मनीश डी’कोस्टा	Chhattisgarh	ACTIVE
0769a939-3544-49d4-b69e-d1e11f5a3e00	BK-SYN-61383	अनिरुद्ध अगरवाल	Chandigarh	SUSPENDED
f9b695a7-5652-4a92-b839-66dc5b5befd1	BK-SYN-70277	प्रभाकर राव	Ladakh	ACTIVE
22ba99a6-38f8-495e-b160-89dbbb566d7c	BK-SYN-02625	असीम भटनागरजी	Andaman and Nicobar Islands	EXPIRED
0b9c221b-b764-4c37-9d6f-e31684cad336	BK-SYN-12829	अमृत खत्री	Madhya Pradesh	SUSPENDED
c2725342-b375-4531-ad58-e581a162882e	BK-SYN-49109	सम्मानसूचक लोचन पिल्लई	Andhra Pradesh	SUSPENDED
3d4885ea-49a4-4cf9-9e49-02573a168600	BK-SYN-81747	सम्मानात्मक मञ्जुला कौल	Jharkhand	EXPIRED
5cdf8111-418a-4f1b-905d-91fcc6cd96f7	BK-SYN-16038	लता भटनागर	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
026eaf5c-ed5f-4b52-afb9-6bf4c48f8385	BK-SYN-95008	संमानित देवदान शुक्ला	Jammu and Kashmir	EXPIRED
a319b297-8f63-4e9c-b110-50ba69fa419a	BK-SYN-50504	अशोक यादवजी	Maharashtra	ACTIVE
1341481f-20fd-4040-b2b4-05181e3037e2	BK-SYN-39513	उत्तम मेहताजी	Haryana	ACTIVE
e6ad6518-a408-4f6a-a08f-599feac61d13	BK-SYN-91269	आदरवाचक ललित मैती	Chandigarh	ACTIVE
3f4a047b-c97e-4ee2-9187-333ed7287f6b	BK-SYN-90229	रजनी भटनागर	Uttar Pradesh	ACTIVE
cb32318a-4dc7-42ad-813d-643759bcfdfc	BK-SYN-71349	रोहना दासजी	Haryana	ACTIVE
6fdfb97c-42a6-47c2-97a6-7feec54ac163	BK-SYN-37262	चेतना चोपरा	Lakshadweep	ACTIVE
e1aa6e61-4759-4557-846d-8b46d3114588	BK-SYN-48371	अमित नारायणजी	Odisha	SUSPENDED
c18d6aed-199a-402b-8286-d6392e9fd44e	BK-SYN-44908	सचिन गावडेजी	Jammu and Kashmir	EXPIRED
2a99e3ee-3886-4d2d-908b-a3cf2be5bb7d	BK-SYN-53682	सम्मानात्मक देवी दास	Meghalaya	SUSPENDED
9705c168-0661-462a-8ca3-eda2f8bd3434	BK-SYN-01410	गोविंदा सक्सेना	Tripura	SUSPENDED
f6959b80-0e71-4198-9635-f82666049991	BK-SYN-88102	आदरसूचक देवदान गुरुंग	Jharkhand	SUSPENDED
3f7f5966-831f-4567-8329-a0fc0da7ed3d	BK-SYN-48553	आदरवाचक प्रभु रंगन	Delhi	ACTIVE
47515639-5601-43a9-b886-81f8fef7ed65	BK-SYN-63420	सम्मानसूचक कैलाश शाह	Mizoram	SUSPENDED
c8e49711-04f1-4e3b-a5a9-993e63306275	BK-SYN-84263	श्यामल दासजी	Kerala	EXPIRED
8a6a24b1-fedc-4a18-a64d-c2d555848d25	BK-SYN-19723	असीम दासगुप्ताजी	Manipur	EXPIRED
650fc9a6-c590-43be-9668-e1d169356642	BK-SYN-19200	असीम रोद्रिगुएस	Tripura	EXPIRED
c7796377-b2f3-4a4b-bbae-50598d3728a3	BK-SYN-72151	सम्मानसूचक शशि गोयल	Bihar	ACTIVE
530d62e5-2317-4e5f-b049-6c9b56b3dd79	BK-SYN-17615	दिलीप साहाजी	Tripura	ACTIVE
701e0139-18ed-46f0-a453-6efa4cc4efba	BK-SYN-44966	यश रायजी	Arunachal Pradesh	EXPIRED
e392d21d-b306-4f54-9494-29b597588e9c	BK-SYN-45342	माननीय प्रमोद प्रसाद	Odisha	ACTIVE
34282dc5-c272-47e0-b017-b67ba39bb965	BK-SYN-29005	आदरवाचक सावित्री मेहता	Odisha	ACTIVE
7f45ce31-a1db-47cc-b240-5d3ea5e112cf	BK-SYN-20690	सुदर्शना कपूर	Manipur	EXPIRED
f513d781-580b-4141-8cf5-ea09d405e012	BK-SYN-10419	सम्मानात्मक मोहन बोस	West Bengal	EXPIRED
9e92f972-e8c0-497a-a632-c2222dd87b0f	BK-SYN-15538	सुन्दर चटर्जीजी	Odisha	SUSPENDED
1b128978-6580-4697-8e1d-680edb6979b8	BK-SYN-86554	कृष्ण डी’सोउज़ा	Himachal Pradesh	SUSPENDED
7fbfda94-1c01-4f41-9c4c-e098d1290f93	BK-SYN-73925	िनशा वर्माजी	Manipur	ACTIVE
c14d9295-60b3-4362-a69d-9204e4e7c214	BK-SYN-67930	सुदर्शन महराजी	Telangana	SUSPENDED
00c9cdb2-d5fd-4526-94bb-60d077446589	BK-SYN-28108	माननीय आकाङ्क्षा गावडे	Himachal Pradesh	ACTIVE
0fc0703e-870c-4420-a8a4-242b2c0aa07e	BK-SYN-85915	सुमन सैनीजी	Telangana	ACTIVE
9b3a6f5f-5ca3-477e-ab57-bbea05afc1d9	BK-SYN-04198	कमल अहलूवालियाजी	Madhya Pradesh	SUSPENDED
fecab93b-5551-4f33-a773-85f7ff54527c	BK-SYN-91649	गीता तिवारीजी	Jharkhand	SUSPENDED
4411782a-3dc2-4437-9588-b3f642e4bd40	BK-SYN-72810	सम्मानात्मक प्रमोद चौहान	Haryana	ACTIVE
a50b44b0-36a4-4664-b94e-b55642adc975	BK-SYN-88426	लक्ष्मण चटर्जी	Manipur	SUSPENDED
a90d3258-da09-422c-b23d-939bc1d2d35d	BK-SYN-95741	शिव चौहान	Manipur	SUSPENDED
c71286b0-73df-41bb-8bed-722c9dc630bf	BK-SYN-90821	दमयंती प्रसाद	Mizoram	EXPIRED
59255d1d-8d47-4162-8498-9997fdecf1f3	BK-SYN-51079	माननीय अमला मजूमदार	Lakshadweep	SUSPENDED
66a9907b-e644-4987-ab2b-c3acef882ec4	BK-SYN-44393	िनशा अगरवाल	Himachal Pradesh	SUSPENDED
919b2b2d-0129-45b2-ba8b-c621b2720699	BK-SYN-13485	सुनीता मैतीजी	Chhattisgarh	ACTIVE
c2aa5f27-6234-4b0a-a2c3-1da9e1915f9d	BK-SYN-92554	उषा दासगुप्ता	Telangana	ACTIVE
4de11791-1148-4b44-94ce-3a55e0a4e42e	BK-SYN-89368	देवदास दासजी	Uttar Pradesh	ACTIVE
7dd95404-99d5-43a3-bb79-be60fc18c8d5	BK-SYN-18194	चण्ड तिवारीजी	Delhi	EXPIRED
ba773e67-30a4-4551-a52d-8a1001ada3f9	BK-SYN-52920	सती चोधरीजी	Uttarakhand	EXPIRED
349c450d-7ddf-413c-a656-bf005135eb69	BK-SYN-67369	शंतनु गुरुंग	Jharkhand	SUSPENDED
1fdc8870-d308-437b-8dd3-269200e4115a	BK-SYN-04004	सम्मानसूचक इला पाटिल	Maharashtra	ACTIVE
9391c61b-71bf-4fb9-bff2-5dee161a5bfb	BK-SYN-81277	धनञ्जय थापा	Assam	ACTIVE
5cc99d0f-32a6-4e6c-b3e8-e5df3a455af9	BK-SYN-34365	सम्मानात्मक पद्म पाण्डेय	Andhra Pradesh	SUSPENDED
c3fe9583-f403-4f52-9647-f8603d442782	BK-SYN-39515	चण्ड डी’सोउज़ा	Lakshadweep	EXPIRED
e1ce7a15-e334-43fd-915c-507b8348f12d	BK-SYN-89766	संमानित पूर्णिमा दासगुप्ता	Andaman and Nicobar Islands	SUSPENDED
5df9f538-3a59-418d-91a6-ee4e6919394c	BK-SYN-16638	सम्मानसूचक जगदीश चक्रवर्ती	West Bengal	ACTIVE
dca8a1ac-7c04-419a-8f6c-9a090dcf38b1	BK-SYN-28223	श्रेष्ठ मैतीजी	Ladakh	EXPIRED
3a16d5e2-db9d-4c1c-9860-664fc4bdd1d6	BK-SYN-75349	मानदीप कलिता	Haryana	ACTIVE
ab153009-7373-4c03-8131-2ae11e042057	BK-SYN-65550	काली देशपांडेजी	Rajasthan	ACTIVE
30550659-a62e-40ae-8e1b-a37fb6a3d4c1	BK-SYN-85547	सम्मानात्मक सुदर्शन देशपांडे	Himachal Pradesh	ACTIVE
95c2ee88-91b8-42e5-aa93-9c444421260f	BK-SYN-43581	प्रभाकर जैनजी	Uttarakhand	EXPIRED
365026ee-ec07-47cd-914a-f5b8d16b0015	BK-SYN-78835	सम्मानसूचक सिद्धार्थ शुक्ला	Jharkhand	EXPIRED
8d37ba1e-e7d4-46ee-8765-713b301ae4a9	BK-SYN-81562	शिवाली जोशीजी	Maharashtra	EXPIRED
7049a7a9-512b-43d4-88c8-a61feb7bc4e3	BK-SYN-97369	सम्मानात्मक विपुल दास	Andaman and Nicobar Islands	EXPIRED
84f02108-bb6c-4bbd-8b9b-2f9b99e0b58d	BK-SYN-32458	संमानित लीना सरीन	Madhya Pradesh	EXPIRED
0d1aff99-5a81-4ca7-9dd0-24f5bae02688	BK-SYN-60263	शर्मिला भट्टाचार्य	Tamil Nadu	SUSPENDED
1cc0a063-e7fc-4acd-b125-af25c806661c	BK-SYN-46052	स्वर्ण त्रिवेदीजी	Mizoram	SUSPENDED
41f9f677-4e68-4cb9-a109-a7439b4f67c1	BK-SYN-67674	माला कौलजी	Tamil Nadu	ACTIVE
f0724451-7201-4af5-a99b-25e3c8956e4f	BK-SYN-42665	सुमन्त्र गावडेजी	Himachal Pradesh	EXPIRED
5e6504c7-a95f-4419-82f6-4cdb5c833fcf	BK-SYN-48043	कैलाश सिंहजी	Himachal Pradesh	ACTIVE
f55532da-96f7-4bdc-b225-cf93ac1fa865	BK-SYN-52975	ईश सैनीजी	Manipur	SUSPENDED
beada203-f55c-4b8e-87d0-a049be479a1b	BK-SYN-23276	संजय भट	Chandigarh	EXPIRED
cb66c546-3f4e-4e3e-8036-ed8a4c994e96	BK-SYN-37288	महात्मा पिल्लईजी	Chandigarh	EXPIRED
c1272b36-db24-459f-9416-58a7d97d793c	BK-SYN-29438	लीला गुप्ता	Lakshadweep	EXPIRED
e42cfbb4-4cf7-4a24-a958-c09b3af4e5e4	BK-SYN-20152	अरुंधती शाहजी	Tamil Nadu	ACTIVE
5dd6b246-b912-4d1e-98ab-32f26b2a9dca	BK-SYN-77929	मञ्जूषा झाजी	West Bengal	SUSPENDED
ba0e1f18-6645-4aeb-ab91-36b0fea93eb3	BK-SYN-11529	जयन्ती चटर्जीजी	Andaman and Nicobar Islands	EXPIRED
812f6fd9-99e5-46c2-8759-31af5e69b077	BK-SYN-64237	कान्ती गुरुंगजी	Kerala	SUSPENDED
426b8d3d-4e64-43c9-a823-af66dd892fed	BK-SYN-72243	आदरसूचक संजित चोधरी	Assam	ACTIVE
74c7b0d1-37e5-41d9-944c-d367440c6b6c	BK-SYN-73723	माननीय लीला दुत्ता	Uttarakhand	SUSPENDED
64ecb22a-8320-4090-ae5a-cea0453f2e23	BK-SYN-33351	जया प्रधानजी	Manipur	ACTIVE
c0646400-ec71-4d9c-8ab6-5a19a75d5063	BK-SYN-12422	दीप्ति चटर्जीजी	Kerala	ACTIVE
62a34172-ab0e-4afc-9dd8-3ea2dda10e12	BK-SYN-61375	शशी आहूजाजी	Assam	SUSPENDED
d668825f-79bb-403f-a2e9-2059e751210a	BK-SYN-15098	कुणाल मल्होत्राजी	Haryana	EXPIRED
bf891ddc-9dee-451c-9b1b-988b6daa2d8d	BK-SYN-51780	इला गुहा	Uttarakhand	EXPIRED
d79e62b1-a903-4c07-852f-bdea36b039aa	BK-SYN-67615	मञ्जु कुमारजी	Uttar Pradesh	ACTIVE
f424e886-407f-4f02-9ca5-02e794838eca	BK-SYN-66582	मञ्जुला चतुर्वेदीजी	Ladakh	EXPIRED
0d793d00-11ff-419c-915c-e7be638fd772	BK-SYN-55015	आदरवाचक प्रतिमा शाह	Sikkim	ACTIVE
847af1a6-f36b-4b9d-aeba-a79b9f7a7ac9	BK-SYN-52545	लीला वेंकटएसन	Delhi	ACTIVE
697b3bd6-e19f-4ce3-9f94-9a2409d8b25c	BK-SYN-04411	अनिला चवनजी	Bihar	SUSPENDED
e0e4c70e-cca2-4fb5-861d-bf44a87b32ab	BK-SYN-60835	विपिन कलिता	Tamil Nadu	EXPIRED
f88b0328-4f03-4685-a149-3110d337a101	BK-SYN-61856	संमानित अजित दुत्ता	Bihar	ACTIVE
fd0d9ab6-9ca9-468c-89c5-b2e0c0e10b65	BK-SYN-26763	माधव गोयल	Tamil Nadu	ACTIVE
77f46b5f-85ef-48f7-8bdc-56d5660626cd	BK-SYN-54451	श्री वर्मा	Karnataka	ACTIVE
2e73806b-cbf3-4e11-9415-1154f0f5323e	BK-SYN-96011	जयदेव पिल्लईजी	Punjab	ACTIVE
f9ee22bf-838c-4e25-9241-bbf5d520800b	BK-SYN-75290	संमानित अभिलाषा रंगन	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
000161a8-21db-43c3-a80f-1c3cdfd77b8f	BK-SYN-92778	माननीय कर्ण राय	Telangana	ACTIVE
e44bcb17-e127-40cc-bc7a-398ab02b1a04	BK-SYN-86313	नरेन्द्र कदमजी	Haryana	EXPIRED
0e64541c-3c78-406a-9f93-aaa3e3040ff8	BK-SYN-84080	बल प्रधानजी	Andhra Pradesh	ACTIVE
7111cc48-c6e9-4fed-bcbf-55fe1f4dc0a2	BK-SYN-84781	प्रसाद सिन्हाजी	Meghalaya	SUSPENDED
f9690082-357d-45cc-a9b6-b1b20bb50cb3	BK-SYN-67088	पूर्णिमा मेहताजी	Meghalaya	EXPIRED
796db7a6-d25c-4a0f-b644-dd795bbb8bfb	BK-SYN-31207	राज मित्रा	Punjab	ACTIVE
0e4a5727-6b1e-4165-9e71-fa1b0fecac0d	BK-SYN-20150	बल शाहजी	Arunachal Pradesh	SUSPENDED
3277e152-3077-4fe8-909e-6bb907adff4a	BK-SYN-47813	सुदर्शन नायर	Chhattisgarh	ACTIVE
64058e5a-265c-48f4-91b3-cc5c97ce16fe	BK-SYN-37056	प्रणय बुरुाहजी	Manipur	SUSPENDED
38027d30-2865-4487-a01b-60a7165e6f29	BK-SYN-66242	रवि आचार्य	Himachal Pradesh	SUSPENDED
c95311a4-7ffc-4c86-b8fe-92cffd483dc7	BK-SYN-95919	इन्दु बनर्जीजी	Manipur	SUSPENDED
0d6d0476-199a-4f7d-89b1-ce744d674c4b	BK-SYN-20834	माननीय रश्मी सिंह	Tamil Nadu	ACTIVE
492e7f5a-9f73-4d52-a00e-5a333fd6fa09	BK-SYN-22938	सम्मानात्मक पुष्पा महरा	Jammu and Kashmir	EXPIRED
4684da40-8363-4716-8323-06d8d68d59ec	BK-SYN-18300	आदरसूचक लोचन दास	Kerala	SUSPENDED
6a165b01-d4ff-4e78-ab09-eb519ca2ce8d	BK-SYN-78502	शान्ता रॉय	Manipur	EXPIRED
7394e5a7-9892-41bd-8cc7-f91440051df8	BK-SYN-59569	माननीय चेतना बलासुब्रमानियम	Meghalaya	EXPIRED
ab513677-0f4d-471c-ad5e-4395c62b5342	BK-SYN-14536	आदरसूचक प्रसन्न मेनन	Tamil Nadu	EXPIRED
9279b0ce-91ae-4876-9ebf-d81ab211d3ce	BK-SYN-79435	दीप्ति दुत्ता	Rajasthan	SUSPENDED
c3a06dd7-52f4-4594-aa60-d638816bb37e	BK-SYN-05604	दुर्गा सैनीजी	West Bengal	ACTIVE
8d2e28c6-5e1f-4457-beea-3d264e84d249	BK-SYN-82583	लोचन प्रधानजी	Nagaland	ACTIVE
2f496dbe-29aa-42f6-91b6-ee7411638a5e	BK-SYN-65304	नरेन्द्र खान	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
4b53fad7-4959-4aae-9eba-1d533447eadc	BK-SYN-58888	शोभा रंगन	Lakshadweep	ACTIVE
51cbf87d-cd2b-4dc8-b666-c1b4fbe3b218	BK-SYN-25555	चन्दना दुत्ता	Maharashtra	ACTIVE
4a7d949d-7371-4c88-8598-30f21b05cf8d	BK-SYN-42494	आदरसूचक लीना ताम्बे	Jammu and Kashmir	EXPIRED
7a9fff4b-2cef-4b35-bb11-7320e9856985	BK-SYN-62434	प्रसन्न सैनी	Meghalaya	SUSPENDED
17cea9e1-2be4-4ef7-aff1-576a5be5ea47	BK-SYN-67367	अनुष्का पवारजी	Rajasthan	EXPIRED
df77e2a7-4b68-4f21-a4c5-745476fd37bb	BK-SYN-24453	गुलज़ार प्रसाद	Gujarat	ACTIVE
31bd3bbb-a8b0-41ec-b542-4e33bc14d0d9	BK-SYN-19374	यश गुरुंग	West Bengal	ACTIVE
73d6578e-9b8b-40dc-a644-28dd31d20f30	BK-SYN-50758	प्रेमा घोषजी	Meghalaya	ACTIVE
42c0dbdb-da02-48f9-a985-2ee9e1fb94b0	BK-SYN-13715	सुरज शर्मा	Uttar Pradesh	EXPIRED
1d9f6720-b8bc-4af5-af36-43c57cf87944	BK-SYN-11090	सम्मानसूचक रोहना प्रसाद	Odisha	SUSPENDED
d91e020a-815e-474a-a6af-9ba98762d05f	BK-SYN-47834	अनिल चोधरी	Telangana	ACTIVE
2ed60ab0-86d2-4c84-90e5-dba7f52d51bb	BK-SYN-28767	शनि मजूमदारजी	Mizoram	SUSPENDED
7eba7436-8ed5-43dd-9165-602890586363	BK-SYN-72244	सुरेन्द्र अगरवाल	Telangana	ACTIVE
77885d14-f3d7-467e-b1fd-552ad3b676dc	BK-SYN-75095	रुक्मिणी सिन्हा	Uttar Pradesh	EXPIRED
7b469329-c7bf-42aa-8192-bd04942b4a13	BK-SYN-16705	लीला थापाजी	Andhra Pradesh	SUSPENDED
2bbc6175-a60b-470e-b719-c405c284042e	BK-SYN-35038	उमा डी’सोउज़ा	Kerala	EXPIRED
6ac29ecc-4c01-4bc1-b57a-5c091dac54d1	BK-SYN-26376	सम्मानात्मक शेखर कुमार	Puducherry	SUSPENDED
5e4eb392-3e26-44d4-b280-749f3bb93a6b	BK-SYN-42087	आकाङ्क्षा वेंकटएसन	Telangana	SUSPENDED
eeed4bc4-f828-40be-8863-10c96ca2432f	BK-SYN-77253	गोपाल ताम्बे	Puducherry	EXPIRED
24eb770d-ecc8-4a21-bbb2-ec33eb13b5da	BK-SYN-55190	बलराम प्रधानजी	Goa	EXPIRED
89bce66f-ced7-4889-9a31-2c31e6420307	BK-SYN-15550	महेन्द्रा त्रिवेदीजी	Uttar Pradesh	ACTIVE
0da46990-d45a-4992-b6a6-0cec2cecdcbb	BK-SYN-72827	लावण्या थापाजी	Rajasthan	EXPIRED
8b1ce0eb-d31b-4f4c-a7a3-b33e938e9ad6	BK-SYN-28301	आदरसूचक पल्लव थापा	Madhya Pradesh	EXPIRED
c5d51375-2baf-4d9b-a348-25250994a8be	BK-SYN-28993	दीपाली चोपरा	Telangana	SUSPENDED
0bfca09b-9e86-4344-8f7a-4fe07de5e3ba	BK-SYN-80408	सम्मानसूचक दीप्ति चक्रवर्ती	Tamil Nadu	EXPIRED
8ab934fb-28a1-4024-8add-322d39d6afb2	BK-SYN-08549	प्रमोद जयरामनजी	Kerala	SUSPENDED
69d38838-9b66-4fbb-9247-6f3ee4c32c57	BK-SYN-04965	देवदान नाथजी	Manipur	EXPIRED
93934df4-2b08-4a90-8f54-b99411313ce2	BK-SYN-83023	संमानित चन्द्रकान्त झादव	Uttar Pradesh	EXPIRED
2e6bdde7-afb1-416e-b976-8e8a42f83130	BK-SYN-95563	अशोक रायजी	Maharashtra	ACTIVE
31aa5978-9842-4a6d-a9ec-f87880c3f050	BK-SYN-74272	सुशील अहलूवालियाजी	Delhi	EXPIRED
a09e191b-22ce-4ac5-8721-9588846ac5ac	BK-SYN-58916	अमित चोधरी	Kerala	EXPIRED
2bdcf278-072d-4d87-a99c-1fe6ce650dda	BK-SYN-13858	संमानित रश्मी दासगुप्ता	Telangana	ACTIVE
3cae8f39-5373-4d39-9f20-5d0dc577bd29	BK-SYN-72761	सम्मानसूचक परवीन पाटिल	Chhattisgarh	EXPIRED
996e5c3e-45c6-4846-b3af-52043404f262	BK-SYN-19971	आदरवाचक महेन्द्रा छेत्री	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
c46fb9ac-031a-44db-8045-ddffe61b9519	BK-SYN-12704	माया रेड्डीजी	Gujarat	SUSPENDED
386a1dcf-4552-4f2a-a098-e3687513fd0d	BK-SYN-13965	हनुमान् आहूजाजी	Jammu and Kashmir	SUSPENDED
4d635d3e-de8b-4506-9fd3-f20e503e9bf5	BK-SYN-62827	गौरी रोद्रिगुएसजी	Ladakh	SUSPENDED
cd8087ea-0645-49fa-b904-4de8d863b268	BK-SYN-39729	संमानित काम भरद्वाज	Meghalaya	EXPIRED
45992bfc-863d-401c-b5ff-6132d1bdeba0	BK-SYN-83900	आदरसूचक श्रीपति मजूमदार	Delhi	EXPIRED
e46a8dcd-996a-48ff-a168-9797745e0a00	BK-SYN-75380	सरला दासगुप्ता	Andhra Pradesh	SUSPENDED
2f87ebbf-248d-4757-bee1-5a83a5c198e5	BK-SYN-87487	अभय पवारजी	Odisha	ACTIVE
b45311db-3850-45a3-af44-f5ec7338bf60	BK-SYN-29276	अमिता पिल्लईजी	West Bengal	ACTIVE
e9bab587-c571-45ef-9bb1-c5d340ccab65	BK-SYN-36678	सतीश सिंहजी	Karnataka	EXPIRED
3f4b19fa-620c-4882-8538-c8e0aa2746d4	BK-SYN-01112	सम्मानसूचक कुणाल कुमार	Odisha	EXPIRED
65262932-80ed-4457-bd92-123ed3e19f16	BK-SYN-89085	सुलभा द्विवेदी	Telangana	SUSPENDED
72a84e24-ae8f-4e8e-8cb4-4e626b86e89a	BK-SYN-15025	माननीय काम छेत्री	West Bengal	SUSPENDED
232045fb-9fec-4440-a8f3-cf827c09ed13	BK-SYN-73282	सुमन्त्र खत्री	Ladakh	EXPIRED
00d53d32-dd46-4cf5-b3e3-79124b94a65b	BK-SYN-48308	आदरवाचक अर्चना बुरुाह	Ladakh	SUSPENDED
b79c0a19-dc80-4c89-8ee2-e423be483585	BK-SYN-26400	सती सेन	Maharashtra	ACTIVE
ea7878f0-924a-474f-8336-e535981cc8d2	BK-SYN-40790	रघु दासजी	Tripura	EXPIRED
6a11a732-b89a-4ae4-a91c-0ac04f94c517	BK-SYN-63011	अमृत मल्होत्रा	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
152f959e-4242-4d93-88a8-9193811f5294	BK-SYN-65123	माधवी सक्सेना	Chhattisgarh	SUSPENDED
52790e0f-6977-49b0-b8e4-be69d17b703f	BK-SYN-51982	आदरसूचक शोभा यादव	Bihar	SUSPENDED
e6470684-a05f-4152-8bd5-3838859d8022	BK-SYN-22067	संजना रॉय चौधरी	Madhya Pradesh	ACTIVE
33c87f27-cd6f-4757-96f8-f9508b523ba2	BK-SYN-69484	दीपाली सेन	Goa	SUSPENDED
4a43af2c-ed11-46a7-ae30-eb51474be4a9	BK-SYN-12090	आदरवाचक इला बनर्जी	Telangana	SUSPENDED
8ddeb150-c41f-4df5-95ba-332e823e39bc	BK-SYN-93042	कुणाल डी’सोउज़ाजी	Assam	SUSPENDED
32fd4777-a0f5-4540-ab6e-24c2a8779eb1	BK-SYN-83019	आशा सेनगुप्ता	Gujarat	EXPIRED
0d565800-b58f-42a1-a3aa-2c1275ba8e6d	BK-SYN-02212	कैलाश झाजी	Chhattisgarh	ACTIVE
776cd63e-9c99-4685-86d8-58fbee6cba66	BK-SYN-08093	श्रेष्ठ मेहताजी	Meghalaya	ACTIVE
a8489490-6d48-43b6-b480-bbbf22f1f946	BK-SYN-08593	आदरसूचक शिवाली वेंकटएसन	Meghalaya	SUSPENDED
1d01184d-477a-4464-a04b-536d868db1cc	BK-SYN-40178	माननीय रेशमी मित्रा	Manipur	EXPIRED
c9cc6e37-367e-454c-a3b5-ac17ce4170f6	BK-SYN-66138	सम्मानात्मक नंद कपूर	Delhi	EXPIRED
e71e7ec6-150a-4b21-8b1d-1fb63d453430	BK-SYN-58545	मीरा जैनजी	Arunachal Pradesh	EXPIRED
82a24a4e-e57d-4e50-88ea-c814dbeafba3	BK-SYN-78636	आदरवाचक दीपक अरोरा	Uttar Pradesh	SUSPENDED
b7f7df2f-b0af-4c09-9d16-0b3eba9f812f	BK-SYN-08835	विनय सरीनजी	Haryana	SUSPENDED
6443dd09-0a4a-4e87-adf0-4e63e1b04351	BK-SYN-68642	संमानित प्रबोध कुमार	Madhya Pradesh	ACTIVE
72059775-d28b-40c3-b361-f2f53e60fd75	BK-SYN-23585	चन्दना रेड्डी	Uttarakhand	EXPIRED
f4af72fd-0106-4d17-879e-7bc0af69e60e	BK-SYN-63399	शीला नाथ	Himachal Pradesh	ACTIVE
0f545093-314f-4c3c-97a0-2b8c0a0407aa	BK-SYN-42160	विजय भट	Puducherry	ACTIVE
693faa61-e353-4155-bb96-ad4ade8b071d	BK-SYN-61198	वसन्ता कपूर	Andhra Pradesh	EXPIRED
c14977ce-76ca-4d85-bc13-83048964266e	BK-SYN-92281	वसन्ता गुहा	Chandigarh	EXPIRED
2e8c7f3f-bd2d-4be0-b160-103b4e7716f7	BK-SYN-22519	दामोदर पवार	Tripura	SUSPENDED
6a3d1d4f-6886-41fb-95b4-404548cd6739	BK-SYN-53790	वासिष्ठ वेंकटएसन	Meghalaya	EXPIRED
243bf496-beb0-4708-9dd4-7d2d5f2344b5	BK-SYN-42326	मञ्जुनाथ मित्राजी	Lakshadweep	SUSPENDED
ec232126-08a3-4b64-ab9c-1c06468da03d	BK-SYN-98800	सुलभा गुप्ता	Tamil Nadu	EXPIRED
7c6d86db-0f5c-4b9b-bd35-2e620bde764e	BK-SYN-23488	संमानित ब्रह्मा आचार्य	Chandigarh	EXPIRED
a0847b81-b41b-4769-baef-e9e17e5d8f79	BK-SYN-96378	सम्मानात्मक अनुजा गोयल	Jharkhand	EXPIRED
4ecdcd6e-f489-4cd1-adf1-17e6b2866040	BK-SYN-45453	दयाराम रॉयजी	Goa	EXPIRED
6552efde-4618-4f1e-b198-68db793cc412	BK-SYN-68017	शेखर दुत्ता	Karnataka	EXPIRED
8f25419c-c943-4d93-b19c-820835dca471	BK-SYN-01873	कर्ण खानजी	Tripura	EXPIRED
721045d0-f132-4f10-8e73-be7f9156ec71	BK-SYN-66724	राम पाटिलजी	Madhya Pradesh	EXPIRED
a3cf2224-5dba-41bf-8321-85380656ee4d	BK-SYN-71021	मनीषा पटेलजी	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
23df6d16-a398-485d-b691-42dafdbbce68	BK-SYN-35774	श्यामा घोषजी	Kerala	EXPIRED
c4c6b364-f004-46be-9349-f6921668061e	BK-SYN-34728	दिव्या राव	Tripura	ACTIVE
34a9e743-b71b-4767-a28c-ac9fb26e17d5	BK-SYN-33412	मनीषा पाण्डेय	Meghalaya	EXPIRED
b1c2e05d-a4d5-47b8-8ca1-8d04554fb738	BK-SYN-82715	ज्योतिष सरकार	West Bengal	ACTIVE
5e9bbb8d-e176-47b6-924a-a3c2bdd1018a	BK-SYN-54844	विजय सरकार	Puducherry	ACTIVE
254b3b26-4ed9-45d6-8e3c-a90cd4fac66e	BK-SYN-55666	धनञ्जय आचार्यजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
f3c3e616-9fef-4fbf-a80e-de8a25066002	BK-SYN-31785	हरेन्द्र डी’सोउज़ाजी	Goa	ACTIVE
eae8a8e0-e64f-4f55-aaad-d63e7cac55f5	BK-SYN-93149	आदरवाचक अरुंधती वर्मा	Rajasthan	EXPIRED
f4c91ae0-c587-4276-9095-87ff6ccb1008	BK-SYN-27112	आदरसूचक यश सैनी	Chandigarh	ACTIVE
14a0bf4a-f0ea-4aaf-9fae-7c43f597fc1e	BK-SYN-62210	सम्मानात्मक नारायण चोपरा	Andhra Pradesh	ACTIVE
b427a6b2-813e-4b20-b3c6-514bd44f05e1	BK-SYN-35342	स्वप्निल हजारिका	Ladakh	SUSPENDED
1862f7aa-db4b-4cb4-9c63-a96317ee33b7	BK-SYN-47812	अभय रेड्डीजी	Tripura	EXPIRED
e9ad7683-58f5-4f10-9709-4dad740d660e	BK-SYN-65960	सरला चतुर्वेदी	Mizoram	ACTIVE
825bc561-a7f6-439c-b3a5-4eccb6ba238d	BK-SYN-83453	लोचन दासगुप्ताजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
2ba0b767-e244-496c-8a6d-15ed1523b224	BK-SYN-90762	सुनीती साहाजी	Chhattisgarh	EXPIRED
a50f6e37-53bd-4789-bc8f-aa477627dade	BK-SYN-51057	माननीय सुमती भट्टाचार्य	Madhya Pradesh	EXPIRED
842788d0-37fb-48fa-b6e1-0a112cc687c6	BK-SYN-91998	अनुष्का सिंह	Gujarat	EXPIRED
19ca0b78-a08b-4dd5-b7dc-af95cda56c85	BK-SYN-79087	सम्मानसूचक प्रणव सिन्हा	Goa	ACTIVE
4def9d55-7eb9-4886-a568-4109dcee6fed	BK-SYN-81552	पद्मिनी गोयल	Rajasthan	EXPIRED
15d35412-6562-40fa-ab2c-9b2657e72b5f	BK-SYN-09991	आकाङ्क्षा खान	Gujarat	ACTIVE
56d30e6c-85ee-4b41-b67d-b7a9efd33dc5	BK-SYN-52188	इन्दु चोपरा	Himachal Pradesh	ACTIVE
b9e3372a-697f-4374-854b-fe6df1781258	BK-SYN-48348	आदित्य नाथ	Telangana	SUSPENDED
fbb3a563-46ed-46f8-8b9f-ddf88fcf1f20	BK-SYN-07715	गुलज़ार अरोरा	Goa	EXPIRED
40aedb37-c8c7-4ec9-a519-0fece5f350f5	BK-SYN-00699	आदरसूचक गोपाल सुब्रमण्यम	Assam	SUSPENDED
c20fa91c-85ca-46f4-b4b5-6939cbf7d7e1	BK-SYN-26417	रजनी रॉय चौधरीजी	Arunachal Pradesh	EXPIRED
1a93fcfb-5246-4727-801f-459df4131632	BK-SYN-79273	पल्लव रंगन	Jharkhand	ACTIVE
d32776ae-7d70-4efd-9817-c1c1c2478d2d	BK-SYN-17387	आदरसूचक लीला मुख़र्जी	Tamil Nadu	ACTIVE
02bff504-1618-4a9c-b91e-5f17620b57e7	BK-SYN-24626	सम्मानसूचक पद्मावती वेंकटएसन	Delhi	ACTIVE
23fe09f9-3236-438f-a51f-438c56ddc6d4	BK-SYN-71216	असीम बनर्जी	Mizoram	EXPIRED
43b03db9-b724-4fff-9bc1-2a7e49e6e7ce	BK-SYN-89970	संदीप सरीनजी	Rajasthan	EXPIRED
a5fe1d90-b171-4811-9081-29bcf731087f	BK-SYN-72427	नरेन्द्र जैनजी	Andhra Pradesh	SUSPENDED
00b4106c-a058-4933-b21f-a90f9d2838c8	BK-SYN-07414	राज सेनजी	Telangana	SUSPENDED
de759760-99cb-4f31-92d3-62f5ea4b080c	BK-SYN-86005	यश मिश्रा	Punjab	ACTIVE
1b47b942-1656-402e-981a-a059b3848ff7	BK-SYN-33716	अमृत शाह	Chhattisgarh	SUSPENDED
a7e655ad-8ac4-4866-a07e-893cb794a978	BK-SYN-92477	रानी पिल्लई	Delhi	SUSPENDED
5b9bfce9-014b-4080-a767-e2f9435ef5a7	BK-SYN-06052	तारा शुक्ला	Tripura	EXPIRED
9a504261-5f74-4af0-959e-608afd827ca8	BK-SYN-27749	सीमा मैतीजी	Mizoram	EXPIRED
a76f3b73-a363-4979-817d-51ee77faf2f3	BK-SYN-28994	शेखर गुप्ताजी	Mizoram	EXPIRED
9f6a85c1-686c-435c-abf0-597835e2837a	BK-SYN-66833	लक्ष्मी नायर	Chandigarh	EXPIRED
35ed7f96-3b1c-45b1-80f4-ada6c59ddc69	BK-SYN-35422	सुभाष नाथ	Jammu and Kashmir	EXPIRED
a6133926-36e2-4ae9-ad14-d84837663fea	BK-SYN-44653	सम्मानात्मक रामकृष्ण रेड्डी	Haryana	SUSPENDED
a43bce08-512b-490f-a083-ec6fb6299461	BK-SYN-12113	माननीय किरण सिन्हा	Tripura	SUSPENDED
952b2f63-544c-47e4-b327-e8cd8c0fb93c	BK-SYN-40625	शीला मेहता	Himachal Pradesh	ACTIVE
b4ea6581-f312-4409-8db1-a426a25b7f87	BK-SYN-70991	आदरसूचक ज्योतिष मजूमदार	Ladakh	EXPIRED
d2299de3-7417-4b63-a7b4-aa660fa52c13	BK-SYN-36380	आदरवाचक उमा चौहान	Punjab	EXPIRED
63d16c33-e108-47ba-8f26-40f7a4f8249a	BK-SYN-11431	अदिती सिंहजी	Arunachal Pradesh	ACTIVE
89e3248f-e681-4882-b1ab-84c2abb40e9d	BK-SYN-48931	मनीश बनर्जी	Madhya Pradesh	EXPIRED
96c22fb8-51f7-4d41-8f23-85bbcccfd2dd	BK-SYN-64214	अरुणा सिंह	Andhra Pradesh	EXPIRED
03214bcf-1e7e-4553-a30b-7391392b6460	BK-SYN-76694	शर्मिला झाजी	Haryana	SUSPENDED
e39433c6-4426-4b67-879d-903f6311ad79	BK-SYN-28250	आदरसूचक धनञ्जय तमांग	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
4b987f7d-da9e-4f26-b8f8-ba9252b872c7	BK-SYN-55386	आदरसूचक कम्बोज तमांग	Andhra Pradesh	SUSPENDED
ce1ab835-861b-43bc-911f-5538b247b9e8	BK-SYN-95613	रामचन्द्र देशपांडे	Madhya Pradesh	EXPIRED
063dc326-6f5f-40e1-a57e-f4ebf2b5fd01	BK-SYN-84107	सुधीर बोस	Tripura	EXPIRED
c54223bc-2ca6-4fac-9f38-94a434b694db	BK-SYN-50007	संमानित रतन चक्रवर्ती	Meghalaya	SUSPENDED
7d27e798-f4f5-4224-af0b-f0a5cf6596c0	BK-SYN-53706	सावित्री मल्होत्रा	Chhattisgarh	SUSPENDED
f962edb3-a365-4902-aedf-02af4e2be76c	BK-SYN-47591	अनिश सरकारजी	Assam	SUSPENDED
80e88534-4a32-4627-aa52-f58b6e6ea9ea	BK-SYN-33202	प्रणव छेत्रीजी	Himachal Pradesh	EXPIRED
3f8b7052-9227-4865-91c8-7fcc4dd0e3ec	BK-SYN-69417	आनन्दा खानजी	Delhi	SUSPENDED
43c7d9d2-f5a3-4411-a343-c9732c7b18e7	BK-SYN-30360	ईश पवारजी	Maharashtra	SUSPENDED
7eb29875-0aea-493d-a67f-6fab111a27b1	BK-SYN-82617	सम्मानात्मक पद्मिनी रंगन	Puducherry	EXPIRED
93e496fa-ab4c-4f32-b5c1-29fcd1dce940	BK-SYN-59291	सम्मानात्मक देवदान जैन	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
60570071-3715-48f1-b48b-532baf796825	BK-SYN-27170	राहुल झाजी	Chhattisgarh	ACTIVE
0a4a0a0e-f350-4c0e-8ec7-d8ab17b56f2d	BK-SYN-31270	माननीय कशोर झादव	Goa	EXPIRED
8a48bd3e-51a7-4342-a676-f4e5d99512c9	BK-SYN-57521	प्रेम शुक्लाजी	Tripura	ACTIVE
c7a6a285-5528-4296-a450-25f113ad545a	BK-SYN-74450	अरुण जैन	Madhya Pradesh	EXPIRED
4a549cc2-d5a1-4956-8825-2f7e21210be7	BK-SYN-47156	पद्म राव	Rajasthan	ACTIVE
75867330-2db2-4af7-9be6-0ddb24285d24	BK-SYN-62006	अवन्ती गुप्ताजी	West Bengal	SUSPENDED
28b9ccaa-34e3-4688-a015-c489df1dca1a	BK-SYN-99586	संमानित सुशील सिंह	Meghalaya	ACTIVE
0480cd35-4023-4d14-a177-8fc2915ddfc8	BK-SYN-46122	आदरसूचक कालिदास सेनगुप्ता	Goa	EXPIRED
483b0237-9a6a-4339-926d-a92a4fda47d4	BK-SYN-02547	अकबर चक्रवर्तीजी	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
f3b2c76e-f301-41ad-915f-b030f079a05b	BK-SYN-18021	आदरसूचक मीरा महरा	Goa	SUSPENDED
df2c1079-e024-4f30-b099-63e8869a4d33	BK-SYN-57401	आदरवाचक शंकर मित्रा	Jharkhand	EXPIRED
90ac356a-6b15-4980-b203-7d51d9db5942	BK-SYN-13648	मनीश तिवारी	Uttarakhand	SUSPENDED
f73a7af8-96ec-4a1d-94e9-dec88195716f	BK-SYN-92340	राजेन्द्र अगरवाल	Rajasthan	SUSPENDED
2e80e762-4407-46f3-b8bc-fd9428ab0d99	BK-SYN-45450	आदरसूचक अमला रेड्डी	Uttarakhand	EXPIRED
4d77c36d-c402-492a-be3b-0041518add01	BK-SYN-69174	संमानित राहुल द्विवेदी	Assam	EXPIRED
c03c8cdf-b56e-44d7-bb1a-2ed92c9f1a37	BK-SYN-64502	उत्तम शाहजी	West Bengal	ACTIVE
89c28a7f-d69f-4a7b-908e-7c5a7449fdf2	BK-SYN-65905	मीरा सरीनजी	Puducherry	EXPIRED
93c0e308-21d3-417e-9c60-03f341c61216	BK-SYN-11282	अनुपम टंडन	Andhra Pradesh	EXPIRED
f0dbfcdb-f9a5-47df-8f33-dd95c809d3b8	BK-SYN-67819	सुमती सिंहजी	Puducherry	ACTIVE
e997ec9a-2d10-4d77-9e1f-ecca7b517a12	BK-SYN-92310	निखिल सिंहजी	Rajasthan	SUSPENDED
a25f024b-03c7-4d10-86d7-bfdc9b9232bf	BK-SYN-77542	माननीय मञ्जूषा मित्रा	Chhattisgarh	ACTIVE
73f2e2bd-26e5-425d-8941-369a150a7808	BK-SYN-58218	शनि मालिक	Madhya Pradesh	SUSPENDED
a1876802-69de-4ade-beff-d8b96060073c	BK-SYN-19471	प्रताप चतुर्वेदी	Uttar Pradesh	SUSPENDED
34688a82-1c94-4b98-9dc3-8b5afef59cce	BK-SYN-90594	दीपाली जयरामनजी	Bihar	ACTIVE
4d541abe-881c-4f98-b3d0-7080a1d20c77	BK-SYN-06089	सम्मानात्मक कल्पना राव	Maharashtra	ACTIVE
1c751f08-9314-4cd4-ad54-85d507c67cbb	BK-SYN-73722	आदरवाचक स्वप्निल चटर्जी	West Bengal	EXPIRED
777e2d7d-0d50-42f9-996c-69fe8c887d28	BK-SYN-89326	विशाल अहलूवालियाजी	Tamil Nadu	SUSPENDED
65474590-946c-40aa-a004-326e2ac78433	BK-SYN-47368	संमानित जय शाह	Punjab	SUSPENDED
a4a95216-5835-4033-b727-804fbb78da25	BK-SYN-43360	शर्मिला रोद्रिगुएस	Karnataka	SUSPENDED
58de7d4e-2e07-4d2a-953d-f703980bf916	BK-SYN-64145	सम्मानात्मक सीता भट्टाचार्य	Uttarakhand	SUSPENDED
d1829448-687f-4de2-8976-d4d9ee888f67	BK-SYN-28900	आदरवाचक अभय चोपरा	Maharashtra	SUSPENDED
7c53bbb6-7b2d-4c87-b110-4d34dafbd606	BK-SYN-48172	अनिला मल्होत्रा	Gujarat	SUSPENDED
4fd0dd00-5cd7-483f-92af-6b9aefb76d07	BK-SYN-72369	संमानित कृष्ण सरीन	Kerala	ACTIVE
9a32132e-fbb2-459f-8453-55defad48f37	BK-SYN-80095	जयेन्द्र अरोराजी	Uttar Pradesh	EXPIRED
5815d8ba-6dc9-4e59-8954-bc6d6f818255	BK-SYN-59529	श्यामा पाटिलजी	Andaman and Nicobar Islands	EXPIRED
b45d30d3-ccbd-4653-a877-c6e160b83bf9	BK-SYN-58324	बृजेश श्रीवास्तवजी	Arunachal Pradesh	SUSPENDED
7217697f-0814-4d76-9da9-2f205cbb8c0e	BK-SYN-92470	मञ्जूषा शाह	Lakshadweep	EXPIRED
c8ca8f9e-3f90-4b72-9f11-3cfe2d2c204f	BK-SYN-37946	ज्योतिष मालिक	Chhattisgarh	ACTIVE
43ea88dc-d6b1-4b4d-bb8d-325b8463cb1a	BK-SYN-55821	आदरवाचक कौशल्या चतुर्वेदी	Ladakh	SUSPENDED
cbc827c0-1d81-40d4-bb96-0ecb7cc25f8c	BK-SYN-01423	माननीय शिव श्रीवास्तव	Odisha	SUSPENDED
92409cbf-ae2a-44da-aa06-0d32c19f4543	BK-SYN-65308	मोहन मल्होत्रा	Andaman and Nicobar Islands	EXPIRED
7f7d7822-444d-43d3-b151-b5927e0b01a0	BK-SYN-75047	अनुजा शाह	Maharashtra	EXPIRED
c7eb4032-e49a-495b-86e7-705814dbf2a8	BK-SYN-50914	सम्मानसूचक राकेश डी’सोउज़ा	Karnataka	EXPIRED
064dd4f0-918b-4af2-8ba6-36f0d6102009	BK-SYN-93468	आदरवाचक दयाराम नारायण	Odisha	EXPIRED
294b5445-baab-46f0-a77d-ee7452e90306	BK-SYN-55401	आदरवाचक अणिमा कुमार	Chandigarh	SUSPENDED
450157bc-ea0f-4239-9c7a-02ee7e209089	BK-SYN-13034	आदरसूचक स्वर्ण राय	Punjab	SUSPENDED
300e8065-d261-4cd9-97b7-7f96ca83c8d3	BK-SYN-69505	कुंती द्विवेदीजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
774c6343-44d2-40e1-9781-1cdd70b2addf	BK-SYN-39753	रुपिन्द्र मित्रा	Assam	SUSPENDED
8f7d40f8-cb8c-4b2b-897b-937a0ef6b4c0	BK-SYN-41054	लीलावती झादवजी	Bihar	SUSPENDED
3ce9774b-2237-4a1a-8671-21f3b03ed490	BK-SYN-90905	सम्मानसूचक प्रसाद गोयल	Haryana	EXPIRED
ac9a9e79-f5c3-4336-86a8-1318bd9a92e3	BK-SYN-27452	मञ्जुनाथ झादव	Delhi	ACTIVE
088b7dd2-d067-490e-9632-a15bac17173d	BK-SYN-50062	माननीय गुलज़ार डी’सोउज़ा	Haryana	ACTIVE
7e602df0-129e-4896-a8ec-53fdc2eccbea	BK-SYN-57665	बल दास	Goa	ACTIVE
a5673d58-bafc-4dbd-9f71-f68226fead3c	BK-SYN-99757	सम्मानात्मक कान्ती अहलूवालिया	Tripura	SUSPENDED
4f5bb1e2-a86c-4336-9cbc-e3e254d7595d	BK-SYN-80882	सम्मानात्मक कुमारी वेंकटएसन	West Bengal	EXPIRED
f4a16442-f81b-4451-9e47-649bc1188a89	BK-SYN-63041	संमानित कमला तमांग	Himachal Pradesh	ACTIVE
8dc47035-e4e7-4c68-9a49-1a4c48f6183a	BK-SYN-82036	लीला मैतीजी	Rajasthan	SUSPENDED
1e396be7-c9f0-441b-b18b-68079905d1d5	BK-SYN-44603	महात्मा द्विवेदीजी	Tripura	EXPIRED
7c2ca700-2069-4859-83db-2c432498510b	BK-SYN-60314	माननीय सुनील चोपरा	Manipur	SUSPENDED
04ad88f2-0c9d-4f0c-898e-874b7d9d1ec6	BK-SYN-01800	आदरसूचक सुदर्शन प्रसाद	Odisha	ACTIVE
22ec53c4-ee47-4c4e-b2ce-8fdca63b6ab9	BK-SYN-81877	संमानित भरत त्रिवेदी	Uttar Pradesh	ACTIVE
ecb98a0c-445b-4e4c-8572-5653e732fc85	BK-SYN-28500	देवराज कलिता	Uttar Pradesh	SUSPENDED
4aeb7e2d-e571-4775-bdb4-d0f93a8f6b19	BK-SYN-92786	आदरसूचक भरत सरकार	Puducherry	SUSPENDED
1b20e75d-b3b7-4282-82cc-eb00b6db18e7	BK-SYN-70279	बल दासजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
be4ee64c-dfea-4524-aa96-f94587d72819	BK-SYN-55570	शनि जयरामन	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
7f323570-d935-4d39-9b1a-a9695e8edd90	BK-SYN-37926	यश सरकारजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
dc6b84c5-64f7-45ad-bb7d-db34342a0e4c	BK-SYN-51410	आदरसूचक राजेश सिन्हा	Mizoram	SUSPENDED
3e3aeba8-15bb-4310-9cb1-adda42350a1a	BK-SYN-68256	सम्मानात्मक प्रणय डी’कोस्टा	Chandigarh	EXPIRED
cd41bd74-29c9-4f48-b79b-de532994fc9a	BK-SYN-30762	राम थापा	Uttarakhand	SUSPENDED
9ddd6225-9f8b-4d1a-b2e8-9dcf9d93675d	BK-SYN-71696	संमानित किरण हजारिका	Haryana	SUSPENDED
9940e416-88e4-477a-964e-8df4ec73a54b	BK-SYN-84753	हर्श पवार	Andhra Pradesh	SUSPENDED
d014f99d-5e77-4cf2-8495-9711b41ff7b3	BK-SYN-72880	पूर्णिमा अरोरा	Arunachal Pradesh	ACTIVE
cbf15625-f409-4029-bc2e-f2f93b210735	BK-SYN-73903	सुधीर बुरुाहजी	Telangana	EXPIRED
6bb4ca32-c237-47ac-86df-d8251523bf1b	BK-SYN-82485	हर्श मित्राजी	Lakshadweep	SUSPENDED
688f7736-6c9b-4a45-a05e-06b24a29ea73	BK-SYN-06543	श्याम प्रसादजी	Tripura	SUSPENDED
89a58893-4e89-44be-bb34-9a558bf6fa7f	BK-SYN-24089	आदरसूचक कमल ताम्बे	Andaman and Nicobar Islands	ACTIVE
e160b810-f263-4e43-8465-fff39d17af70	BK-SYN-25702	संमानित शेष मेनन	Sikkim	SUSPENDED
00c53569-88d4-43d3-97e4-4b49b32c51a9	BK-SYN-11757	चण्डा शाहजी	Sikkim	ACTIVE
f90b0519-7653-4c17-a027-6761ce34fa5f	BK-SYN-57333	सुनील मंडलजी	Telangana	ACTIVE
c2ee50c8-8f98-451d-a882-4cf7d62dac68	BK-SYN-77947	आदरसूचक सुलभा अहलूवालिया	Gujarat	SUSPENDED
5006b64a-5ec8-4543-918a-7e66bba7d33c	BK-SYN-15768	सुरेन्द्र प्रसादजी	Manipur	SUSPENDED
422a94a1-cf04-4558-9662-46b6af24e6e0	BK-SYN-82776	माला भट्टाचार्य	Punjab	SUSPENDED
bddf877b-ab61-41db-8fbe-eb03a21b3379	BK-SYN-89127	जगन्नाथ गावडेजी	Assam	EXPIRED
621703ad-dc42-4802-9b4d-d5f841104e4c	BK-SYN-86224	सम्मानसूचक विष्णु दुत्ता	Karnataka	EXPIRED
6d6ff665-3e20-4622-92a2-7497179c08f5	BK-SYN-50277	सम्मानात्मक रोहना टंडन	Maharashtra	SUSPENDED
ff7f4950-f911-4c9c-aedd-0bcb31b49444	BK-SYN-80017	माननीय प्रतिभा मेनन	Himachal Pradesh	SUSPENDED
1aacd389-8f4e-4a5a-8a1f-dc6dbbbf492d	BK-SYN-94271	महात्मा सिन्हा	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
160a4a17-f0c7-43ce-ab43-417efaa66327	BK-SYN-40367	माननीय राजीव तमांग	Jammu and Kashmir	EXPIRED
804c860f-9235-4805-a46d-8ad77ca50952	BK-SYN-38029	माननीय कुमार बनर्जी	Goa	ACTIVE
8980d1d3-3bcd-42c0-acbe-134c79aa45c3	BK-SYN-36671	माननीय प्रणव बलासुब्रमानियम	Bihar	ACTIVE
bd2ed992-c675-4fea-898d-002ca6bc96d5	BK-SYN-89456	पूर्णिमा यादव	Telangana	ACTIVE
0809bf40-df88-4de6-93f1-60bc6815fadf	BK-SYN-59064	आदरसूचक शशी छेत्री	Andhra Pradesh	EXPIRED
f08b15a2-0ea5-4a47-b455-b5eae113ba84	BK-SYN-23338	माननीय राम कलिता	Maharashtra	ACTIVE
425ecda3-e70c-4125-8de9-d0cb02980dcf	BK-SYN-54625	दिलीप दास	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
f1ceb8bd-9cc7-4236-9134-8a93d96bbdb4	BK-SYN-93169	आदरसूचक उषा अरोरा	Nagaland	ACTIVE
3dc6ba58-ef4f-4924-8240-e9795c0801f7	BK-SYN-95661	मणि रावजी	Madhya Pradesh	SUSPENDED
d6495bec-6478-4615-bcab-486cee9b6af3	BK-SYN-76748	माधव ताम्बेजी	Himachal Pradesh	ACTIVE
68e02234-1b53-4c02-9c47-4debb1bc8dde	BK-SYN-41732	दामोदर आहूजाजी	Maharashtra	SUSPENDED
54b7fb20-ff88-4fa6-a7eb-13f906e8c175	BK-SYN-82942	सीमा गावडे	Mizoram	ACTIVE
36093cde-50e5-4868-913c-694bf8ebc6ed	BK-SYN-60797	नेहा अगरवाल	Goa	ACTIVE
3c370465-4284-4d02-b847-0daa3324d855	BK-SYN-68775	सम्मानात्मक अनिश द्विवेदी	Jammu and Kashmir	EXPIRED
1aa3167b-bb3d-4605-a4a1-511e4f5b8cd7	BK-SYN-05727	आदरवाचक किरण पटेल	Lakshadweep	EXPIRED
f394b2f1-c2cd-4222-b467-b53a0865b2fe	BK-SYN-66531	प्रतिभा चवनजी	Manipur	SUSPENDED
8bd890da-3396-4a76-b1b1-c45f8f8c2c79	BK-SYN-30863	बलराम झाजी	Odisha	ACTIVE
f7afefde-9682-489b-9007-d56250b98132	BK-SYN-60341	पूर्णिमा तमांगजी	Maharashtra	ACTIVE
6e20e936-c135-4afb-8797-37589400ddff	BK-SYN-38711	माननीय महावीर छेत्री	Himachal Pradesh	SUSPENDED
027326f1-f222-4935-a3d3-11648635c51b	BK-SYN-06736	शकुन्तला नायर	Arunachal Pradesh	ACTIVE
f4674db6-ce95-4532-9b21-5f2cb58fcaa5	BK-SYN-66056	पद्म भट्टाचार्य	Sikkim	SUSPENDED
c6a20f20-f682-4c22-b509-beccbad40db4	BK-SYN-88039	नित्य प्रसाद	Andhra Pradesh	EXPIRED
0ba0b36d-7baf-4af0-9e08-7db98d063cd0	BK-SYN-97702	हर्शद झाजी	Telangana	SUSPENDED
5dd83078-42fc-47e7-8832-3436b088bdea	BK-SYN-64039	दिलीप मित्रा	Nagaland	ACTIVE
f6aa79e3-4e8b-4a6f-bf54-3b835e394036	BK-SYN-29819	प्रणय मल्होत्रा	Nagaland	ACTIVE
8f47f1e3-9133-4c61-8510-07dbccbd65af	BK-SYN-38615	लक्ष्मी महरा	Odisha	EXPIRED
ddcbc78a-9dcf-43cb-9232-3dffe9154b31	BK-SYN-86781	माननीय श्यामा गुप्ता	Goa	SUSPENDED
00e09fda-8987-490a-9bf3-babdbdbb40a6	BK-SYN-15397	सिकन्दर भट	Himachal Pradesh	ACTIVE
7ed2a6c1-f897-4549-a7f2-ece8f91cdce8	BK-SYN-67366	नीरव नारायण	Kerala	EXPIRED
a2098a90-c557-425b-a959-eaff03a833c9	BK-SYN-75841	सम्मानसूचक लक्ष्मी द्विवेदी	Chandigarh	SUSPENDED
7d70fdd3-2575-4acf-9a4b-c4afdeafbda2	BK-SYN-02691	संमानित अनुपम सक्सेना	Sikkim	EXPIRED
254f6ed6-ed2f-470a-afa3-707ea7d07884	BK-SYN-86414	मणि चोपराजी	Tripura	EXPIRED
af5671d5-7284-4eb6-bae4-61c6b7018b54	BK-SYN-51859	शङ्कर दासजी	Odisha	ACTIVE
5e173e4f-cbc7-4f6e-81e0-107edb63b914	BK-SYN-40012	शनि दुत्ता	Tamil Nadu	SUSPENDED
caaecf89-689d-43a9-942a-b325c8800840	BK-SYN-37670	आदरवाचक ज़स्विन्देर् यादव	Assam	ACTIVE
3acdb3c2-c5f4-4fec-890e-4ee728398153	BK-SYN-40530	उमा वर्माजी	Jammu and Kashmir	SUSPENDED
5c6f5e44-cf9b-4386-8651-76bbd07ff573	BK-SYN-36622	िनशा मैतीजी	Andaman and Nicobar Islands	EXPIRED
8f6de517-66a9-4976-8bc1-595f3c00d39e	BK-SYN-83822	सम्मानसूचक इन्दु मित्रा	Kerala	ACTIVE
c8de297c-45f7-46a8-b46a-641600f66f17	BK-SYN-65578	सूर्य देशपांडे	Andaman and Nicobar Islands	ACTIVE
c0c90001-8a33-46c1-b656-0450ec3cdce9	BK-SYN-17857	तारा तिवारीजी	Punjab	SUSPENDED
faaf6d48-052f-48b0-9c4c-04bc3c2d4e8a	BK-SYN-24656	अनुजा पिल्लई	Meghalaya	EXPIRED
1da71b9a-924c-4c22-82ed-86884568461f	BK-SYN-95049	राज्य सिंह	Kerala	ACTIVE
13a2014d-6a95-46c9-a3d1-01114105ccdc	BK-SYN-96936	आदरवाचक इन्दु कुमार	Karnataka	EXPIRED
46fbf507-9d86-4510-9cc4-1650e495d32c	BK-SYN-12443	धनञ्जय सिंहजी	Kerala	EXPIRED
d7a2f35b-568f-464b-9d7a-f7524f8596b5	BK-SYN-34156	शंकर कौलजी	Madhya Pradesh	SUSPENDED
e84719cf-9001-4e2a-afc9-dc1efdafdb4e	BK-SYN-12643	सिकन्दर तिवारीजी	Puducherry	SUSPENDED
23fb1c03-f535-4c34-97f3-581d1fe717ef	BK-SYN-93448	सुमना तिवारी	Bihar	ACTIVE
238309ff-3bb2-4e3c-bfef-dbb731a2dc60	BK-SYN-33950	शशी रायजी	West Bengal	SUSPENDED
73846dfe-b6a1-4a86-b672-2a57a9b706eb	BK-SYN-44977	लक्ष्मण खत्रीजी	Manipur	SUSPENDED
a1fc982b-309e-412d-bbca-817cce43dda0	BK-SYN-77582	चन्द्रकान्त डी’कोस्टा	Ladakh	SUSPENDED
35ef252b-2b0e-4a66-8e93-02573cb054d4	BK-SYN-20563	प्रिया जेटलीजी	Madhya Pradesh	EXPIRED
4aca2d6a-c65b-4ed1-b817-c12a7ea0f9e5	BK-SYN-53468	दिनेश भटनागरजी	Ladakh	SUSPENDED
a36f0811-4c9e-4639-874a-507ce2377c5b	BK-SYN-66319	जया खान	Maharashtra	SUSPENDED
f76bc133-a545-46e0-ba17-61dcc2cbae03	BK-SYN-16871	देवदान दासगुप्ता	Karnataka	SUSPENDED
1344472d-af96-45e2-b3f5-9f41d476ed29	BK-SYN-62160	सम्मानात्मक आदित्य सक्सेना	Uttarakhand	SUSPENDED
df00bc44-322a-4eef-8ff6-56928a6a6c57	BK-SYN-62855	सुनीता झा	Ladakh	ACTIVE
3b26f912-22ae-4b96-ae6b-47434e58b395	BK-SYN-17388	अजित त्रिवेदीजी	Goa	EXPIRED
165250c6-879c-472b-b6a9-62c2c027c0ca	BK-SYN-16558	माला मंडल	Madhya Pradesh	EXPIRED
e9031963-5045-477b-9f01-ffc410d3f1ef	BK-SYN-56634	सरस्वती चौहानजी	Jammu and Kashmir	ACTIVE
60245fdb-84ed-45a9-bdd3-34228936adcf	BK-SYN-42390	सीता बुरुाहजी	Kerala	EXPIRED
3a44053b-3a0a-45e5-8d05-5b5d08264cbd	BK-SYN-87028	मुक्ता कौलजी	Assam	EXPIRED
35c5bcb9-124c-4ad1-8335-e525d07a366f	BK-SYN-94836	प्रभाकर रंगनजी	Sikkim	SUSPENDED
f0380da5-beef-404c-a7f2-1e17efa50225	BK-SYN-89710	सीमा चवनजी	Rajasthan	EXPIRED
b239675d-3779-4b57-a24e-cb779a35f0a8	BK-SYN-13899	सुमन सिंह	Odisha	EXPIRED
09532f2e-4b5b-4002-b6ea-72f4be6309f9	BK-SYN-65548	मोहना जयरामनजी	Kerala	EXPIRED
38f233a2-7ec6-4805-a5bc-7d4970a17200	BK-SYN-09886	प्रसन्न मंडल	Uttarakhand	SUSPENDED
0a9588d6-ed34-4e74-9426-509a2ea6edaa	BK-SYN-24561	गौतम चौहानजी	Puducherry	EXPIRED
e908f040-1a96-4d77-a20e-e4e66b206253	BK-SYN-86056	सम्मानसूचक सवितृ नायर	Uttarakhand	ACTIVE
e66b4b5f-a591-4a80-81a1-cbda1e090d48	BK-SYN-07118	रामकृष्ण पिल्लईजी	Kerala	ACTIVE
31a39c06-91f0-4ba7-a81b-54a057a78529	BK-SYN-13486	रुक्मिणी यादव	Maharashtra	ACTIVE
14783edd-8bec-4689-851e-cb225d1dd5e0	BK-SYN-20658	कृष्ण बोस	Sikkim	EXPIRED
3acff771-625d-4779-9e30-9bf82a372a4e	BK-SYN-75635	शर्म द्विवेदीजी	Nagaland	SUSPENDED
cb976846-1f60-4d7d-9560-25dfbd0ec54c	BK-SYN-70299	भरत झादव	Telangana	EXPIRED
fc703344-0037-4a4a-bbc3-96b40064ac6a	BK-SYN-25501	संमानित अरुणा गावडे	Mizoram	EXPIRED
1109e2b6-2ab8-4daa-a493-9db58a79bf1f	BK-SYN-81394	कम्बोज गोयलजी	Goa	SUSPENDED
eca5919e-c0a1-4e68-a587-58f3aa0adce8	BK-SYN-06323	माननीय विजय चवन	Manipur	EXPIRED
927affae-ba78-4c06-9693-2e2fdfbf472d	BK-SYN-39892	असीम लोबो	Uttar Pradesh	EXPIRED
25a3b680-0d5b-432c-a5ca-9da65e7b01c0	BK-SYN-51952	सम्मानात्मक शनि सिन्हा	Bihar	EXPIRED
be370add-acf7-4537-b2ab-2ecd0407c867	BK-SYN-36523	रघु सेनगुप्ता	Gujarat	ACTIVE
07852f10-bffb-41a2-8091-5614ff81c6c3	BK-SYN-58179	सम्मानात्मक पुरुषोत्तम सेन	Punjab	EXPIRED
6a4121ac-183e-4c95-9631-7603778c92f4	BK-SYN-40087	सम्मानसूचक पीताम्बर महरा	Chandigarh	ACTIVE
5ca47e42-81d4-4c75-9173-577403c19daa	BK-SYN-28571	सम्मानसूचक विवेक सेनगुप्ता	Arunachal Pradesh	EXPIRED
fcc94877-cdb3-4c46-9791-3fbda95c757a	BK-SYN-69591	अरुंधती चतुर्वेदीजी	Sikkim	SUSPENDED
2f5062da-27d7-426c-90df-b348c57a950d	BK-SYN-05689	प्रभु मिश्रा	Puducherry	ACTIVE
ec468fb0-ad45-4490-9eee-7a0e2d10d2ce	BK-SYN-16627	दिनेश आहूजाजी	Nagaland	ACTIVE
b33868af-5d83-4303-9020-9c158cfb59a1	BK-SYN-65022	मञ्जूषा महराजी	Haryana	EXPIRED
a7ab4d84-554f-449c-bbf4-fef4c2a57c3c	BK-SYN-19025	संजित सुब्रमण्यम	Manipur	EXPIRED
d36160cd-dbb4-4da3-90ae-938825a52706	BK-SYN-81387	रजनीकांत बनर्जीजी	Goa	SUSPENDED
8edc425a-5bea-4ff7-ab4f-9c9cbd4a6f91	BK-SYN-19407	कैलाश बलासुब्रमानियमजी	Punjab	SUSPENDED
c4c5c396-ed28-426e-91c2-e1e3ecbb08aa	BK-SYN-55685	अमित साहाजी	Himachal Pradesh	SUSPENDED
f87caab1-ec37-40e6-a078-062e329544d4	BK-SYN-46068	आदित्य कदम	Nagaland	ACTIVE
0b3562f8-9886-42e4-aa44-778d8db3e3d3	BK-SYN-44272	तारा पटेलजी	Uttar Pradesh	ACTIVE
a093548b-3c2c-4f99-b808-a2cad2a0d7da	BK-SYN-17052	गौतम चवन	Ladakh	SUSPENDED
0839ee21-9e58-410b-960e-46a094dd4602	BK-SYN-46210	ज्योत्स्ना जोशीजी	Himachal Pradesh	EXPIRED
47ed3608-b8dc-4701-ac62-faa3bfd7730d	BK-SYN-27520	अनुष्का नायर	Jammu and Kashmir	SUSPENDED
1c1bb040-24c0-421f-890f-e547ce1400c9	BK-SYN-28856	गौरी साहाजी	Gujarat	SUSPENDED
9b42696b-50e5-4511-8cd1-02e7886bbf6f	BK-SYN-69485	गौरी प्रधानजी	Karnataka	EXPIRED
15be003a-160a-4bd2-acf7-d071e5f940a4	BK-SYN-40029	जयन्त अहलूवालियाजी	Chandigarh	ACTIVE
86a652aa-e6fe-42e8-a375-fd7033ef4513	BK-SYN-71155	कला सरीनजी	Himachal Pradesh	EXPIRED
784b4956-5c6b-4530-863a-f59a954c74d2	BK-SYN-71353	आदित्य रोद्रिगुएस	Uttar Pradesh	EXPIRED
8351b5ad-50f1-4842-8ced-c3aa6e2c0efc	BK-SYN-35972	शान्ती छेत्रीजी	Rajasthan	SUSPENDED
7fde27ed-b04f-46e8-9180-941d144ad580	BK-SYN-24970	सम्मानात्मक पार्वती पिल्लई	Meghalaya	EXPIRED
7bdfc442-8a51-4692-a9ea-daa9028c8e67	BK-SYN-70752	रञ्जित रावजी	Chandigarh	EXPIRED
3a909a09-8316-4383-af8e-a03ca4d5edcf	BK-SYN-60783	सम्मानसूचक सुमना घोष	West Bengal	SUSPENDED
4a89537b-a425-4edd-9c89-f7cbf5909f8f	BK-SYN-67663	विद्या सिंहजी	Sikkim	ACTIVE
a194933d-54d8-4088-b34e-54692e13840f	BK-SYN-38506	सम्मानसूचक रुक्मिणी कलिता	Tamil Nadu	ACTIVE
abfdaaa0-f400-47f3-b309-c484b5b1feba	BK-SYN-75998	रुपिन्द्र अगरवाल	Karnataka	EXPIRED
cee4d395-1263-4e9e-94d8-15b8447362e1	BK-SYN-43354	अरविन्द पिल्लईजी	Jammu and Kashmir	EXPIRED
74b40176-b083-42f5-86cb-ab35459620b9	BK-SYN-62046	सम्मानात्मक गौतम चोधरी	Assam	ACTIVE
b0c44ea6-70cd-4bbc-9320-03f6b10fb38f	BK-SYN-08186	आदरसूचक चण्ड मिस्त्री	Rajasthan	ACTIVE
35d40c91-c68b-4842-9010-c7bce8df7951	BK-SYN-43434	विजय चटर्जीजी	Puducherry	EXPIRED
5ab01e12-de21-4410-a516-3333194f12be	BK-SYN-26439	प्रदीप सिंह	Chhattisgarh	ACTIVE
d39d2948-9b0d-42b5-8eb2-af7eef946ef1	BK-SYN-52950	अदिती छेत्रीजी	Sikkim	EXPIRED
a8f32b45-4685-451a-966e-7e82f8d06406	BK-SYN-17966	प्रतिमा भटनागर	Odisha	ACTIVE
51150f4f-fbb2-4b36-a69d-0dac6e735f39	BK-SYN-11417	गोपीनाथ खानजी	Chhattisgarh	ACTIVE
edc8b149-df07-4dfb-8f1a-ae23dfceb945	BK-SYN-40816	राकेश पटेलजी	Madhya Pradesh	ACTIVE
abf261c9-3a52-4f22-b717-775dceeba3b3	BK-SYN-20359	मधुर त्रिवेदीजी	Maharashtra	ACTIVE
d70af28a-0b98-4290-a923-1e78a7e0cc75	BK-SYN-87693	विवेक सरीनजी	West Bengal	SUSPENDED
9913ee0a-54cd-47aa-bebb-964cc57abe6a	BK-SYN-22316	आदरसूचक विपुल बलासुब्रमानियम	Andhra Pradesh	EXPIRED
30db0753-8a5d-4013-a85c-57a156a2d014	BK-SYN-29383	सम्मानसूचक ईश यादव	Himachal Pradesh	SUSPENDED
60caf7e1-d49b-4d15-afc1-a46679e00d9b	BK-SYN-46577	कला नाथ	Madhya Pradesh	ACTIVE
c501f0dc-662d-4fda-a90a-fd70347fee2d	BK-SYN-10541	सारिका डी’सोउज़ाजी	Goa	SUSPENDED
9e76f5d1-8351-488d-9121-a3c4b45b01bf	BK-SYN-16054	सती बोस	Punjab	ACTIVE
882096c1-3ffc-4adb-9d57-ed3b4ce7b250	BK-SYN-73391	सुलभा छेत्रीजी	Puducherry	ACTIVE
fc6a3ff5-556b-4f3f-85d3-aa9427a6230a	BK-SYN-09558	संमानित यश अहलूवालिया	Chhattisgarh	EXPIRED
1b4f8d38-439a-4223-8060-5b4cbfc5ad82	BK-SYN-34519	सितारा थापा	Himachal Pradesh	SUSPENDED
bf58103d-86e9-4b63-b068-d32a412a4022	BK-SYN-90164	प्रसन्न गुप्ताजी	Rajasthan	SUSPENDED
81361f32-2ad9-40b8-84b9-8c52d9bd0633	BK-SYN-25056	आदरसूचक रतन चोपरा	Goa	SUSPENDED
f558d12c-002e-439c-84d5-5c33b4a97b57	BK-SYN-51060	रवि चोपरा	Manipur	SUSPENDED
ceaa459f-d6b4-4762-90db-7a4754bd5ae9	BK-SYN-17406	सम्मानसूचक रवि नारायण	Sikkim	EXPIRED
5a406395-73a5-4f24-8a17-f7fcfd436f0a	BK-SYN-98625	इन्द्र नायरजी	Lakshadweep	EXPIRED
19e20760-4698-4ab6-9ba0-0c80f876dc4f	BK-SYN-31186	चेतना जोशीजी	Haryana	ACTIVE
da23c067-2412-48d4-8fd0-ef8a2d5577cd	BK-SYN-29206	विमल भटनागर	Uttar Pradesh	ACTIVE
9036f9e5-0649-4517-80a8-0687c74728b7	BK-SYN-08330	जयन्ती सेन	West Bengal	ACTIVE
ab84249b-9017-42b3-9b29-582200a4bfb2	BK-SYN-27668	प्रबोध मेननजी	Punjab	EXPIRED
5c94b5a2-fd29-4874-bbd1-864bc79d2bd5	BK-SYN-59050	आदरसूचक मधुकर ताम्बे	Manipur	ACTIVE
5af427e8-fe38-40f1-b43a-36acce0705f6	BK-SYN-53163	मणीन्द्र घोष	Chandigarh	EXPIRED
4049be0c-db4e-49f7-aa70-dca3629f10aa	BK-SYN-80375	आदरवाचक अनिश साहा	Madhya Pradesh	SUSPENDED
5673fa70-9c74-4b9e-85c4-6fe42dc6b80e	BK-SYN-12425	सरस्वती तिवारी	Delhi	SUSPENDED
9e0789bc-8e7a-4ba1-b0a4-25e0cdda228b	BK-SYN-40463	रत्न कुमार	Kerala	SUSPENDED
e54dd6e8-d2be-4969-a58f-96aad430d385	BK-SYN-50358	सम्मानसूचक शिवाली दास	Odisha	EXPIRED
3a2a95ec-39af-48a5-a854-8561f0381f64	BK-SYN-52498	आदरवाचक कर्ण त्रिवेदी	Madhya Pradesh	ACTIVE
40e7dde7-b0ca-4f66-b769-4e288855577f	BK-SYN-30777	संमानित जयन्ती खान	Maharashtra	SUSPENDED
df73d794-f3c9-4f99-a10d-c3854cde4a55	BK-SYN-46110	सम्मानसूचक वासिष्ठ पिल्लई	Manipur	ACTIVE
f75b08fc-9c25-4ebf-a705-cde647a18ecd	BK-SYN-98018	करिश्मा मेनन	Jammu and Kashmir	EXPIRED
fc909ad6-51a1-4cca-92d5-2610e829cbc6	BK-SYN-18293	आदरवाचक इन्द्र द्विवेदी	Jammu and Kashmir	EXPIRED
874e7c48-e354-4efc-9cda-77c9a61ea515	BK-SYN-18044	उमा पिल्लईजी	Kerala	SUSPENDED
36732868-c76f-4a3b-a61a-586d42e0070f	BK-SYN-89306	सम्मानात्मक सुमन लोबो	Haryana	ACTIVE
7fdf4121-6238-4260-ac7d-f18d5ad0e1a8	BK-SYN-85503	लक्ष्मण पाण्डेय	Lakshadweep	EXPIRED
32db0ae8-d4a8-4c6b-93ed-7d1b3e24ac7d	BK-SYN-54251	रिया हजारिका	Uttar Pradesh	SUSPENDED
21651d29-69bb-4103-86a3-f68ac0db71e6	BK-SYN-86188	अदिती अरोरा	Andaman and Nicobar Islands	EXPIRED
ae354863-4bb1-4e7f-abb1-e2dd6c085298	BK-SYN-79084	राज वेंकटएसन	Sikkim	EXPIRED
abe350d1-6c0b-4504-8015-570b5c4c4392	BK-SYN-92708	प्रमोद आहूजा	Tamil Nadu	SUSPENDED
d4f83f21-e4ae-4b5f-a793-de09ad9053d9	BK-SYN-99618	शङ्कर रेड्डी	Nagaland	EXPIRED
e9d19bc7-1c52-49f8-81c1-93049604356b	BK-SYN-17653	अनिल अरोरा	Punjab	EXPIRED
d23208b2-7e88-485f-b29c-93db026fb04a	BK-SYN-01719	माननीय राहुल गुरुंग	Goa	EXPIRED
b245c696-6241-4efd-9932-30c6cc4845b1	BK-SYN-04344	आदरसूचक शेखर महरा	Arunachal Pradesh	EXPIRED
f4bfede7-3a33-4f96-8cdb-8d2c894aa9a9	BK-SYN-87850	माधवी रेड्डीजी	Tamil Nadu	EXPIRED
077b8906-647b-4815-a87c-193add1d631c	BK-SYN-73619	प्रतिमा कुमार	Nagaland	ACTIVE
1026f77d-c65b-4176-8f68-26b69ef92992	BK-SYN-48116	सुधीर तिवारीजी	Delhi	SUSPENDED
0c5f48e7-c1d2-4566-bff0-8e96b8ffd5d5	BK-SYN-19141	माला खत्री	Nagaland	EXPIRED
289f4263-7eea-48c5-b635-191c20e9a961	BK-SYN-98362	आदरवाचक सुनीती चोपरा	Punjab	ACTIVE
3617989d-2412-4703-9109-b4a62b9c3299	BK-SYN-25334	अमिता बुरुाहजी	Chandigarh	SUSPENDED
1f2b9c03-524d-4c04-81b2-2e61d66dcf0b	BK-SYN-54497	सतीश मालिकजी	Manipur	SUSPENDED
5b710b85-1562-42ad-9a21-d9baff514930	BK-SYN-31648	पद्मिनी गुहा	Mizoram	ACTIVE
41c46b75-aba8-4667-bca0-ca190f8a802d	BK-SYN-87276	माधव सिन्हाजी	Arunachal Pradesh	SUSPENDED
6c34b701-1a0d-474d-bc89-b83c35b2e352	BK-SYN-39817	इन्द्रजित लोबो	Odisha	EXPIRED
08f7433f-6014-4493-be55-43d10344cb3c	BK-SYN-61510	काशी कलिता	Puducherry	EXPIRED
6e71f13f-965a-4255-b0a7-d5e5027a1148	BK-SYN-80491	शान्ता जयरामन	Odisha	EXPIRED
658baaa6-6802-4404-b734-de2694d88cc6	BK-SYN-51581	कालिदास मेहता	Manipur	SUSPENDED
72933565-75f8-4e77-8f8d-4bcf187de21f	BK-SYN-09226	ओम पाण्डेयजी	Nagaland	EXPIRED
6238776d-f7e7-46e0-95f3-34b6d4e267be	BK-SYN-30090	संमानित पल्लव सिंह	Andaman and Nicobar Islands	ACTIVE
5875f146-e913-4a50-96dd-b78fa3244b57	BK-SYN-65852	रामकृष्ण गुहाजी	Jammu and Kashmir	SUSPENDED
1d56ff35-ed91-4dde-b36c-fd409983d103	BK-SYN-18295	अवन्ती मजूमदार	Arunachal Pradesh	EXPIRED
f183b9d8-d4bd-48e9-82ad-8b5849ef7580	BK-SYN-61058	सम्मानसूचक पीताम्बर राव	Nagaland	EXPIRED
0f8587f3-4a4e-4078-859c-b4dc046f939a	BK-SYN-75330	सुमना सैनी	Haryana	ACTIVE
d897f5c7-cf3c-4403-ada0-665ff6b8aca8	BK-SYN-03541	रतन थापा	Gujarat	ACTIVE
0f3a206e-ddba-4f06-9398-71c96df2e507	BK-SYN-36405	शिव रेड्डी	Goa	SUSPENDED
027d2312-6cfe-46a3-940c-16b73f5621d6	BK-SYN-73015	सम्मानसूचक नवीन मजूमदार	Meghalaya	ACTIVE
0c976409-0168-45c8-962c-1c70deac23f3	BK-SYN-21028	दीपक यादव	Jharkhand	EXPIRED
1b6ecebc-3a50-49b8-aac2-deb477d40615	BK-SYN-70082	मणीन्द्र प्रसादजी	Madhya Pradesh	EXPIRED
a99fdb42-e585-40f7-8392-9d9cf6239e5d	BK-SYN-14419	पूर्णिमा कपूरजी	Uttarakhand	SUSPENDED
468dc95b-74c1-4f9a-9991-b235fc6f5088	BK-SYN-98741	बृजेश भटजी	Chhattisgarh	ACTIVE
98b28357-e049-40d9-93be-52ab14e7c984	BK-SYN-04356	सुमन वेंकटएसन	Chhattisgarh	EXPIRED
e1e9470d-9cd8-4446-95c2-788410bbad04	BK-SYN-28311	मञ्जुनाथ सरीन	Karnataka	ACTIVE
260e4557-312f-45d1-a894-b2034cbb32f9	BK-SYN-77020	इन्दिरा मजूमदार	Kerala	ACTIVE
3d223bc6-db0e-4831-b62f-cf25b300977c	BK-SYN-34279	लीला कदमजी	Delhi	EXPIRED
638eb303-33b5-4613-9ed5-29b8150fc6bb	BK-SYN-59707	आदरसूचक अनिल महरा	Telangana	ACTIVE
5c12bba8-82c4-47fa-bf7e-3e55d8079365	BK-SYN-32974	बलदेव थापाजी	Rajasthan	EXPIRED
3f853e2d-af56-47e9-be67-7a08b7daaf2a	BK-SYN-29446	सम्मानसूचक इन्द्रजित चोपरा	Maharashtra	ACTIVE
f6be737a-5d81-4f2e-8f67-5ccd9a27fd04	BK-SYN-18625	राज्य मैती	Puducherry	EXPIRED
0063269a-1aeb-438a-9740-b47d633305b7	BK-SYN-42138	शनि देशपांडे	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
200be90d-cb94-4f20-9cee-7af225792c5b	BK-SYN-25913	संमानित जयन्ती अगरवाल	Jammu and Kashmir	SUSPENDED
1f64f1f0-0b62-493b-aced-fdf870ddede8	BK-SYN-20704	सम्मानसूचक अवन्ती घोष	Odisha	EXPIRED
a6d1507b-f1ca-4770-b55c-e42a8c598767	BK-SYN-09482	गोपीनाथ प्रधानजी	Delhi	SUSPENDED
b36c39d4-3e87-4c23-b8ff-5f6c938aa605	BK-SYN-42249	विशाल रॉय	Madhya Pradesh	SUSPENDED
1c870bba-3365-4cfb-9f0b-cd0af4c2ebfa	BK-SYN-72766	सम्मानसूचक मञ्जुनाथ महरा	Lakshadweep	ACTIVE
42a6c42f-7d6f-4b6d-b75f-b427861e3a3a	BK-SYN-77789	अनुज गुहाजी	Himachal Pradesh	SUSPENDED
59cc9452-7fe9-4ad0-b394-61bbc1f4edf3	BK-SYN-99255	रजनीकांत अरोरा	Haryana	ACTIVE
ec591b76-e080-4fda-9f9e-c05c240e6e81	BK-SYN-51364	ओम देशपांडेजी	Jharkhand	ACTIVE
42d074fc-9228-4fb4-9d01-298aa05e102f	BK-SYN-18566	आशा चटर्जी	Jharkhand	EXPIRED
9a704f66-8936-4bc9-ae35-f587b63bb20f	BK-SYN-77424	वासिष्ठ सक्सेना	Assam	EXPIRED
40674183-d4ae-401c-8abf-1f10d097fa56	BK-SYN-60692	प्रकाश मैती	Maharashtra	EXPIRED
1babdd31-0d28-42ae-83e4-d8e861b59e33	BK-SYN-50822	चन्द्रकान्ता सरकार	Punjab	SUSPENDED
e2894f18-6a07-4dd4-a410-4fdda8e56f98	BK-SYN-60391	आदरसूचक पीताम्बर ताम्बे	Himachal Pradesh	ACTIVE
13bd522a-798c-4b65-a0d0-c4f0f73134a9	BK-SYN-39222	मञ्जुला सरीनजी	Maharashtra	EXPIRED
586e160d-430c-4a37-a3ba-95cf1e6a4448	BK-SYN-63571	सरल चवन	Telangana	ACTIVE
422caa0f-6163-4ee5-bcdb-e7a4e6990af1	BK-SYN-56117	सम्मानसूचक शशि भटनागर	Lakshadweep	SUSPENDED
0b018c44-f2de-4a14-a342-ee2f4bd89c4d	BK-SYN-99566	ज्योत्सना मालिक	Manipur	ACTIVE
2e9d1827-2d86-48d4-8c37-a9982bcc5f29	BK-SYN-88789	संमानित गुलज़ार रोद्रिगुएस	Punjab	SUSPENDED
52e1b00f-4763-4899-95a5-d32b79fed6e0	BK-SYN-96008	लीना रेड्डी	Kerala	EXPIRED
0a83aa59-7a8a-45ac-872d-9c8ad5b117b8	BK-SYN-52135	रामकृष्ण चोपरा	Dadra and Nagar Haveli and Daman and Diu	SUSPENDED
3394c651-05a8-4e4a-abdd-3c73fec31033	BK-SYN-57214	प्रणव बुरुाहजी	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
69378e5a-a11c-40d5-ba2c-9a9f77273eeb	BK-SYN-84197	रामकृष्ण जयरामन	Lakshadweep	ACTIVE
cc3692ea-28a8-4972-8546-07b39d2f5728	BK-SYN-97951	सम्मानात्मक श्रीपति बलासुब्रमानियम	Nagaland	ACTIVE
0084490a-cee1-4da0-b30c-4089e901682b	BK-SYN-91846	सितारा साहाजी	Assam	ACTIVE
bb2382ac-4b77-4163-9e3a-7e940be80878	BK-SYN-95333	काली सेनजी	Kerala	SUSPENDED
90c19c1c-726e-42ff-a6ee-45e73d24a81a	BK-SYN-28871	माननीय लक्ष्मी सिंह	Goa	SUSPENDED
7745f741-19b7-4a98-8eb6-4e51b588fdd2	BK-SYN-65575	माधवी रंगनजी	Himachal Pradesh	SUSPENDED
1bb51bd5-783c-4fd4-a1e4-5cefc2d81692	BK-SYN-19928	माननीय सावित्री राव	Tamil Nadu	SUSPENDED
04f2e99c-458d-40d4-a7ab-302ac6d7c650	BK-SYN-27118	आदरवाचक मोहना चोपरा	Andhra Pradesh	SUSPENDED
beea4bde-5bd5-4d21-9ff9-6bd80ddb12c6	BK-SYN-96996	संदीप दास	Gujarat	SUSPENDED
98dc0aff-1ad7-4940-b8ed-cdf773a58e05	BK-SYN-41103	मधुकर राय	Bihar	ACTIVE
bd7c8c44-1a0e-4ab9-98a5-d186b214f2d5	BK-SYN-89873	आदरसूचक लीना मजूमदार	Sikkim	SUSPENDED
f3879e40-8278-4908-a817-005a02d5a2af	BK-SYN-43376	अभय दासगुप्ताजी	Rajasthan	ACTIVE
2617c64e-5f46-410a-8dbe-9738f244f892	BK-SYN-95224	रामचन्द्र पटेल	Bihar	ACTIVE
5744f867-ac9b-4756-8bd4-bdd753df04f4	BK-SYN-31497	संमानित कशोर सैनी	Mizoram	SUSPENDED
b5449705-451c-42a8-baee-8bc50c6f9af1	BK-SYN-54390	लाल तिवारीजी	Chandigarh	EXPIRED
d4fa3dc4-b787-48d5-8378-3e3333795960	BK-SYN-19677	रञ्जित थापा	Uttar Pradesh	SUSPENDED
3c50a95e-b6bd-4d38-8b5c-4fb94a9c1921	BK-SYN-93421	क्षितिज जोशी	Odisha	ACTIVE
e7fb03ce-dbfc-4efe-85f6-4f0817c2fbbf	BK-SYN-15940	पद्मावती बुरुाहजी	Meghalaya	ACTIVE
a8f57b4f-e66b-476a-8f8b-4d21a916b0ba	BK-SYN-49259	सम्मानात्मक दिनेश नाथ	Tamil Nadu	EXPIRED
f3b809e5-8364-4bb8-a273-bde4ebb8a868	BK-SYN-72573	राहुल मिश्राजी	Maharashtra	ACTIVE
358c49e4-0f86-4d04-a7a2-3f9df19c3015	BK-SYN-41273	विजया यादवजी	Ladakh	ACTIVE
af7222ec-785c-4f1d-a213-49e2b868554a	BK-SYN-34191	परवीन चवन	West Bengal	SUSPENDED
2406a2ae-26db-42e6-b7b8-fb1a14d68130	BK-SYN-00966	सारिका जोशीजी	Kerala	EXPIRED
57be8645-e72a-4835-8cf5-bdb1c9630209	BK-SYN-53429	अर्जुन भरद्वाज	Nagaland	SUSPENDED
9073b937-df64-4a72-9b73-5420bc24a94c	BK-SYN-62447	दर्शन आचार्यजी	Goa	ACTIVE
9b23042e-59e5-432c-bd2c-0e8f7945b1ad	BK-SYN-40966	वसन्त गुप्ता	Andaman and Nicobar Islands	EXPIRED
fb47a396-4553-4a59-8400-e3cf5a605807	BK-SYN-62352	किरण जोशी	Goa	ACTIVE
fe8cf79a-921b-4707-bd09-58684c251987	BK-SYN-94535	कमल गुरुंगजी	Telangana	SUSPENDED
a0e5ba1d-6f3a-428f-989d-351a48ca0d03	BK-SYN-06219	देवदान प्रसाद	Madhya Pradesh	SUSPENDED
aaec318b-6129-4a44-9600-d44e03e7f562	BK-SYN-84894	अनुज मुख़र्जी	Haryana	ACTIVE
e62c39df-39b4-4652-8b7c-7e12a54b28ec	BK-SYN-36911	अमृता सैनीजी	Meghalaya	SUSPENDED
173c40c7-be8d-4b04-adad-4b1c4b3b6151	BK-SYN-56768	शशी बनर्जीजी	Goa	SUSPENDED
52a6061d-aa76-4b4d-9cd7-24359bef5980	BK-SYN-46259	आदरसूचक रचना कदम	Andhra Pradesh	EXPIRED
212d4222-af56-4bf6-8a86-2d5467896370	BK-SYN-95325	इन्द्र मल्होत्रा	Lakshadweep	ACTIVE
8eb7f84a-019d-48f6-a4ce-65234dec3279	BK-SYN-50274	माननीय अदिती मल्होत्रा	Ladakh	EXPIRED
28e2af23-65d6-4c4e-9386-3d2e601d48a0	BK-SYN-63874	प्रतिभा मल्होत्रा	Jammu and Kashmir	ACTIVE
e1236684-05d0-4416-891f-2c1987e74f74	BK-SYN-42024	माननीय चण्डा नायर	Himachal Pradesh	SUSPENDED
6335f6c2-a2ea-4b9a-96cb-1c35810e8861	BK-SYN-15250	हरीश मित्रा	Chandigarh	EXPIRED
e6095095-de7c-4b59-988b-1b3930356481	BK-SYN-22140	सम्मानसूचक रत्न पिल्लई	Uttar Pradesh	EXPIRED
5020a1c1-10be-41a5-9eaf-276b2a2588dd	BK-SYN-18288	माननीय अजित बलासुब्रमानियम	Uttar Pradesh	ACTIVE
a09ca2bf-977a-4e63-b801-dc1442e71315	BK-SYN-89011	सम्मानात्मक प्रसाद जयरामन	Punjab	ACTIVE
4d2ba615-f7ef-4c15-ba47-3f42a2efa54b	BK-SYN-35654	आदरसूचक इन्द्रजित चतुर्वेदी	Tripura	SUSPENDED
ab8e995e-2a6b-46a1-955b-4443e50e0e25	BK-SYN-08755	पीताम्बर कौल	Arunachal Pradesh	ACTIVE
9837ff1e-a74f-474a-b09b-da08b72338ff	BK-SYN-13100	शेष खान	Chhattisgarh	ACTIVE
e9f9003b-4b3f-4410-a1ce-53f2fc71dddf	BK-SYN-90006	सम्मानात्मक हर्शद आचार्य	Telangana	SUSPENDED
2714b6d8-0b99-4dd1-b51f-068a0dee38a8	BK-SYN-23414	सम्मानसूचक जितेन्द्र डी’कोस्टा	Himachal Pradesh	ACTIVE
dd2434d4-9b9b-484f-920e-57541bd72970	BK-SYN-74318	सुन्दर शुक्ला	Haryana	SUSPENDED
d7ce01fd-46dd-48e1-97b0-5e34baf544f3	BK-SYN-68607	लावण्या हजारिकाजी	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
7b671b24-3fac-4226-972d-21ec0effb184	BK-SYN-68815	सम्मानात्मक लता चक्रवर्ती	Puducherry	SUSPENDED
f9fc14bc-dde7-40e3-b0f7-8b04080d6f6c	BK-SYN-95875	प्रभाकर पाण्डेयजी	Maharashtra	ACTIVE
0843d85f-3ede-41a3-adfc-5e0ad8c308c7	BK-SYN-57366	रघु लोबो	West Bengal	ACTIVE
4f1ac534-b9b5-44d2-8f5e-42370a45c744	BK-SYN-22192	ओम देशपांडे	Punjab	SUSPENDED
d5ac0ab4-33d5-4b9f-87d2-228d3ddfb375	BK-SYN-47952	पूर्णिमा सेनगुप्ताजी	Uttar Pradesh	EXPIRED
a2c102f2-7a1a-4840-9afd-fd240c21e324	BK-SYN-56441	माननीय दिलीप खत्री	Assam	SUSPENDED
a15c0c02-a0c9-48b3-81c9-e45392a814e5	BK-SYN-14693	अमित अहलूवालिया	Maharashtra	SUSPENDED
233dca9d-c002-4bb9-8667-6f180b8e8966	BK-SYN-11217	आदरसूचक असीम टंडन	Tripura	SUSPENDED
bc8cf5d2-35ab-4068-85e8-ef7bdba1d373	BK-SYN-80969	शक्ति तमांगजी	Andhra Pradesh	ACTIVE
1ee54bec-ad9c-4811-8164-a5a129234749	BK-SYN-76973	सुधीर अहलूवालिया	Chhattisgarh	EXPIRED
f6e4584d-5c3f-44fc-87cf-2cdd66efeeeb	BK-SYN-49996	ललित सुब्रमण्यम	West Bengal	EXPIRED
918d3e9f-cdd0-4541-8f25-454a43369ef8	BK-SYN-36053	लक्ष्मी साहा	West Bengal	ACTIVE
e29d64e7-4c82-4cbf-af11-cf5063d99063	BK-SYN-97454	सम्मानात्मक जय शाह	Assam	SUSPENDED
b7dbbb64-d151-4ddf-a6f8-96778fcb2614	BK-SYN-19915	सुनीती रावजी	Puducherry	SUSPENDED
ff17b5f1-4dc1-47ae-bd47-e60451f7859f	BK-SYN-35050	संदीप मुख़र्जी	Uttarakhand	EXPIRED
da5af617-25f6-4adb-a178-9c4609d20ff3	BK-SYN-34359	चन्द्रकान्ता सिंह	Rajasthan	SUSPENDED
e695049c-6699-42bf-b2dc-b7032a521254	BK-SYN-30964	सम्मानसूचक अभय मुख़र्जी	Karnataka	ACTIVE
f7da0fdb-f9a1-4518-9765-95066610ca44	BK-SYN-19807	अनिल दासगुप्ताजी	Bihar	ACTIVE
66cb6c59-da58-496b-911b-ea791cbb0bf3	BK-SYN-82077	आदरसूचक सुरज देशपांडे	Dadra and Nagar Haveli and Daman and Diu	ACTIVE
1090e2d0-d4e4-4761-926c-002cd41e8b6e	BK-SYN-69218	संमानित अंकुर हजारिका	Gujarat	SUSPENDED
87629527-855d-434e-a3fa-e726d5838f76	BK-SYN-64937	माननीय प्रसाद पिल्लई	Manipur	SUSPENDED
0b39a267-db85-4c7f-8007-14b62ce2b8ea	BK-SYN-29569	गुलज़ार शाहजी	West Bengal	EXPIRED
fe3769c5-0a5e-4b90-998b-f7044b7c8eb5	BK-SYN-67281	सम्मानात्मक सुभाष सेन	Karnataka	EXPIRED
8bb7ff77-68c4-4204-8b39-f7329777375a	BK-SYN-64453	अंकुर दुत्ता	Jammu and Kashmir	SUSPENDED
6b5d05f8-59a2-49d9-8161-72a0fd846c24	BK-SYN-05869	अंकुर भटजी	Tamil Nadu	SUSPENDED
a9dab75d-c973-492e-95fb-dc86ab524b0d	BK-SYN-71220	प्रेमा छेत्रीजी	Goa	EXPIRED
4d9b95c7-e1b0-4697-bcbd-8c7b033741be	BK-SYN-59745	आदरसूचक निखिला कपूर	Odisha	EXPIRED
3c7f5992-5309-4a28-9a74-567af1516452	BK-SYN-53539	सम्मानात्मक सुधीर चोपरा	Goa	SUSPENDED
e4763d50-ca9a-48ba-a3b5-c96649e4fb9f	BK-SYN-02230	आदरसूचक कम्बोज मिश्रा	Sikkim	ACTIVE
6f130b0b-c680-4511-94ea-e331f7622a79	BK-SYN-19167	लीलावती गोयल	Sikkim	ACTIVE
11da64c8-508d-4bae-924b-b6e820f7e2a8	BK-SYN-37150	अरुंधती मेहताजी	Jharkhand	EXPIRED
3e32badc-49af-479b-8bb8-d7fd1177cd8b	BK-SYN-62218	सावित्री हजारिका	Manipur	EXPIRED
821a487e-eaae-42b5-88af-6c2506e59193	BK-SYN-86144	सम्मानात्मक दिलीप चवन	Gujarat	SUSPENDED
df364b31-ee09-4bf0-8983-21ba44e0870e	BK-SYN-54745	आदरवाचक इन्द्र मेहता	Uttarakhand	ACTIVE
d080f0dc-15f5-415f-8f56-b3ffe4183bfb	BK-SYN-10307	दीप्ति कलिता	West Bengal	SUSPENDED
95747a36-e7e1-40eb-8848-2acca6d62d42	BK-SYN-46850	माननीय उमा सेनगुप्ता	Punjab	SUSPENDED
870fac62-6877-400d-9870-e1d5406f8d97	BK-SYN-05138	शर्मिला थापा	Uttarakhand	ACTIVE
2954ddf3-9a9e-4074-a9fe-d13d34f1efbf	BK-SYN-58336	कुमारी आचार्यजी	Delhi	SUSPENDED
276a3f45-c708-4347-a5e3-fba395e2ea0b	BK-SYN-45521	पद्मिनी तिवारीजी	Karnataka	EXPIRED
3333494e-650a-4d07-9d7b-c425dad6b770	BK-SYN-79090	मोहना आचार्यजी	Gujarat	ACTIVE
b6465272-05ea-4fbe-b332-43956107a5e2	BK-SYN-74356	माननीय क्षितिज गुहा	Uttar Pradesh	SUSPENDED
8ecdb269-c688-436b-8111-1617ee1d19a2	BK-SYN-76922	रवि त्रिवेदीजी	Bihar	EXPIRED
4b77c841-1b1d-4f70-af2a-2fecf5142662	BK-SYN-70528	रत्न सक्सेना	Arunachal Pradesh	SUSPENDED
862b4c77-c435-46ab-80a7-7970213d720f	BK-SYN-38399	शान्ता शुक्ला	Goa	SUSPENDED
178c26f1-1f1e-46fb-82a4-c4d38ed54935	BK-SYN-50054	काम भट	Ladakh	ACTIVE
82133f92-cb02-4a37-b003-be0a05fce4f6	BK-SYN-39669	मुक्ता टंडनजी	Ladakh	EXPIRED
03e1018d-b8a9-4a3f-a77b-6fa15b5a82cb	BK-SYN-56280	प्रणय अरोराजी	Andaman and Nicobar Islands	ACTIVE
de558824-1cdc-4721-9630-1bb1dd949e5e	BK-SYN-34710	अनुष्का मिश्राजी	Telangana	SUSPENDED
6b0b537f-a752-4010-bc28-3141b8700a93	BK-SYN-39948	जयन्ती चक्रवर्तीजी	Odisha	ACTIVE
15866fcd-6c01-4dbb-bf9c-d57812afa990	BK-SYN-02799	सम्मानसूचक मोहना महरा	Sikkim	ACTIVE
c38e2cb5-a7a0-4465-a1e4-40b0c88b2cee	BK-SYN-47806	अनुष्का गुहा	Assam	EXPIRED
1b84997d-8d07-4d39-9b4f-5644f3c81fb5	BK-SYN-95214	जगदीश मेननजी	Chandigarh	EXPIRED
a89839e2-5855-474b-b56a-13f468f170cb	BK-SYN-45103	आदरसूचक कमल कौल	Delhi	ACTIVE
4d7d4b08-cfec-40ba-bff0-42fd03150a53	BK-SYN-06489	अर्चना मालिक	Jammu and Kashmir	ACTIVE
62c604ad-024d-4189-8ec1-2a96beb3ed58	BK-SYN-27383	आदरवाचक अमला रॉय चौधरी	Tamil Nadu	SUSPENDED
7f4f9987-f7b6-40c9-9b44-c3eb4e09a993	BK-SYN-66275	सम्मानात्मक जगजीत कलिता	Jharkhand	EXPIRED
f56e743b-46de-4876-b74d-df39715d2da4	BK-SYN-98262	दुर्गा तमांगजी	Andhra Pradesh	SUSPENDED
27a020d3-140a-497e-8394-3c873486011e	BK-SYN-53332	आदरसूचक सितारा भरद्वाज	Maharashtra	ACTIVE
7b0ad522-9dbd-4637-bd58-a1b45c0da450	BK-SYN-73213	रजनी जैन	Andaman and Nicobar Islands	ACTIVE
063a79b1-ee42-491e-ab85-b36a961af3c9	BK-SYN-82223	रचना गुप्ता	Karnataka	ACTIVE
9a1bf224-67b7-45e3-8699-c6a24b6b5343	BK-SYN-19485	संमानित सिद्धार्थ खान	Uttarakhand	EXPIRED
06f22856-4d26-48d5-b616-5f7b28a922d4	BK-SYN-98955	दीपक सेनगुप्ता	Uttar Pradesh	EXPIRED
7c2c847f-9982-4acd-b722-34966233542e	BK-SYN-61834	शंकर मैतीजी	Andhra Pradesh	SUSPENDED
ec6d767f-edfb-48a8-ae7d-166abea1a56c	BK-SYN-01558	आदरवाचक दिव्या चौहान	Puducherry	ACTIVE
9784b62f-e971-49e5-8678-ff5f098cd713	BK-SYN-76095	जगजीत मालिकजी	Odisha	ACTIVE
a9882a52-abba-4273-9b9e-55a4b33bd72a	BK-SYN-51105	आदरवाचक जया पटेल	Dadra and Nagar Haveli and Daman and Diu	EXPIRED
c3424df4-62a2-4409-b437-369c89fb990a	BK-SYN-70874	दिलीप सिंहजी	Meghalaya	ACTIVE
6d87c48a-b03b-4d75-9404-07e5ecadcefd	BK-SYN-59337	सम्मानात्मक आनन्द कुमार	Jharkhand	EXPIRED
a9b4ec7c-e53d-4c73-9cc1-26b75adaf293	BK-SYN-74842	कान्ता छेत्री	Tamil Nadu	SUSPENDED
48c8100d-cadd-4e4e-9ea6-5dbbcd7385e1	BK-SYN-91671	सम्मानसूचक विशाल कौल	Nagaland	ACTIVE
28c089c9-f5f1-43ea-8c0c-edab419390b3	BK-SYN-68401	संमानित रघु जैन	Karnataka	EXPIRED
35b066fd-6f2c-4a55-bf7a-352638bc68ec	BK-SYN-72268	कुमारी गावडेजी	Ladakh	ACTIVE
4d0aead1-596e-41ea-a8df-c556e8a86e67	BK-SYN-20816	आदरवाचक बल गुरुंग	Haryana	ACTIVE
374e199b-0dba-4e35-9852-527adc8612c0	BK-SYN-46630	सचिन बलासुब्रमानियम	Uttarakhand	SUSPENDED
d4ffa057-8f4a-469d-bd90-f30c9c784ebc	BK-SYN-34508	लीलावती थापा	Haryana	ACTIVE
5030fd4b-b9c1-4b35-8c5f-0294e6784894	BK-SYN-42344	चन्द्रकान्त यादवजी	Madhya Pradesh	ACTIVE
4c3b7813-1cc2-4828-b9af-46bd181ab01a	BK-SYN-94325	सम्मानात्मक जया रोद्रिगुएस	Mizoram	EXPIRED
d5e16d04-1488-48ef-ab2b-1b8998282eaf	BK-SYN-12329	प्रतिमा राव	Tripura	SUSPENDED
e0025ee7-68d5-4a5c-9c10-430b3dbde8fc	BK-SYN-03458	कमल दास	Andaman and Nicobar Islands	EXPIRED
068651af-29ca-4dac-bfe6-f97fd33ae1cd	BK-SYN-96136	शंकर गुहा	Tripura	ACTIVE
91ac7e63-f35b-49ec-a0bc-8268a6ac2726	BK-SYN-30567	सम्मानसूचक हर्शद देशपांडे	Goa	SUSPENDED
371abfa0-ed35-4452-a0d2-0bc0bf4d15c1	BK-SYN-74913	सम्मानसूचक उमा सेनगुप्ता	Andhra Pradesh	ACTIVE
11795a2a-d686-4349-bdbd-e9095cab0e21	BK-SYN-48199	सम्मानसूचक सुशीला टंडन	Tamil Nadu	EXPIRED
24384dea-9725-42da-8685-fadf4fd49ad5	BK-SYN-25424	सुन्दर रंगराजनजी	Manipur	SUSPENDED
2b3cd8b5-3d6a-40b2-bb4f-ca7cf9e72ae1	BK-SYN-68533	शेखर गावडेजी	Haryana	ACTIVE
1c7f1191-1fb5-4811-8d90-63ae30254dda	BK-SYN-44925	स्वर्ण सक्सेनाजी	Himachal Pradesh	EXPIRED
d1febb74-e37a-4f78-a190-54dbba73a7f8	BK-SYN-86043	आदरवाचक विष्णु चोपरा	Jammu and Kashmir	EXPIRED
6cf70769-1558-4eb7-9798-dd9d1c35b650	BK-SYN-81185	माननीय सरल मंडल	Jammu and Kashmir	SUSPENDED
208cea8a-15d4-4529-b117-2fe7e43f34db	BK-SYN-22869	इन्दु लोबो	Madhya Pradesh	ACTIVE
eb5b585a-854e-4729-b801-731761945413	BK-SYN-70574	माननीय प्रणय छेत्री	Punjab	ACTIVE
d28f192c-e3e7-4206-8408-5a458a19d8eb	BK-SYN-36754	संजना पवारजी	Haryana	SUSPENDED
ba3224c9-b119-48f4-972b-c5709b23b631	BK-SYN-73913	शान्ता चौहानजी	Sikkim	EXPIRED
7da52394-e678-4fd0-b073-e9828f5883f5	BK-SYN-28910	सम्मानात्मक हर्श पिल्लई	Mizoram	ACTIVE
f373819d-d445-4274-85a3-dbe5c3fb363a	BK-SYN-77043	सम्मानात्मक हरि सैनी	Bihar	SUSPENDED
ed5bed47-7af0-4d94-886f-5c25c90973e2	BK-SYN-47921	एषा सरकार	Mizoram	ACTIVE
958dfe99-2d38-47eb-aff7-573320b03398	BK-SYN-13662	सम्मानसूचक माला मल्होत्रा	West Bengal	EXPIRED
935d1e1e-0c0b-444a-9de4-3cc2b0784722	BK-SYN-69551	प्रबोध लोबोजी	Bihar	SUSPENDED
9bd17a6b-416a-46fa-907f-39ae2262f7e5	BK-SYN-97107	स्वपन डी’कोस्टा	Chandigarh	ACTIVE
b0747c92-1709-462e-92d3-7a1d8a5fbe18	BK-SYN-68979	सूर्य वर्मा	Chandigarh	SUSPENDED
92a74d2a-1bf3-4003-bddc-ad32112d4737	BK-SYN-43683	विशाल भट्टाचार्य	Andhra Pradesh	EXPIRED
130d1932-9e60-4c8c-bda2-39a0c6220fe0	BK-SYN-98960	सम्मानसूचक सुमन पवार	West Bengal	ACTIVE
7f168d6a-3ab8-4b1e-96cf-7935f81726ec	BK-SYN-54743	माननीय मोहन शुक्ला	Punjab	EXPIRED
ac310a5e-7283-430d-88bd-d49dc61a0604	BK-SYN-07400	सुमती तिवारीजी	Meghalaya	EXPIRED
986f961b-75f0-40a6-895d-6483fae97013	BK-SYN-09148	प्रभु झादव	Kerala	EXPIRED
8ad347ac-6437-423d-908c-4afe7f85094d	BK-SYN-90552	सम्मानसूचक मञ्जुला सिंह	Assam	SUSPENDED
c2899227-c53c-4956-85ad-de88eeee26f4	BK-SYN-85051	संमानित शनि हजारिका	Tamil Nadu	EXPIRED
890ee84a-013d-4d45-a079-0fa22e4c4a49	BK-SYN-62349	सम्मानात्मक सुरेश मुख़र्जी	Telangana	SUSPENDED
e80f83ee-4952-4611-a254-c75f36da0efe	BK-SYN-73779	इन्द्रजित खत्री	Chhattisgarh	EXPIRED
\.


--
-- Data for Name: lab_report_registry; Type: TABLE DATA; Schema: verification; Owner: postgres
--

COPY verification.lab_report_registry (id, ulr_number, lab_id, lab_name, nabl_certificate_number, accreditation_status, state, city, report_number, report_date, sample_id) FROM stdin;
b2166d43-7b18-40c3-a401-d81ce9e1d338	ULR-TA-2573-74420402	LAB-IN-DVS-88050	Pierce-Johnson	NABL/TC-1088/2454	Withdrawn	Nagaland		RPT-4818-901480	2022-10-28	SMP-HNY-69430190
d8773e3f-17f7-4542-92ec-f4a0073b555c	ULR-QH-4041-11135337	LAB-IN-CKD-58020	Christian LLC	NABL/TC-6679/7636	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-6833-269717	2026-04-08	SMP-HNY-10811441
ddb878b2-e4ff-454e-8b12-80cfc75533d5	ULR-TR-0750-91802508	LAB-IN-HLA-63711	Ross, Reid and Jensen	NABL/TC-2733/0279	Provisional	Odisha		RPT-0260-682344	2022-07-22	SMP-HNY-63545784
50d57ffc-7e9a-41a7-b11a-434f21bf9414	ULR-CO-7828-79126440	LAB-IN-BCI-72716	Baker, Hood and Palmer	NABL/TC-0005/5204	Active	Assam		RPT-8772-796798	2022-08-07	SMP-HNY-54400898
e87a11e4-c656-4d64-9a8f-9d59f7b929fd	ULR-VA-6441-13344102	LAB-IN-AFN-09812	Pugh-Williams	NABL/TC-3345/2789	Expired	Chandigarh		RPT-0105-080242	2023-07-20	SMP-HNY-74461097
1c98ce59-d2ac-44b8-9f99-7dcc1184f471	ULR-TG-7767-14250097	LAB-IN-YGG-70091	Mcdonald-Rice	NABL/TC-1235/7643	Active	Delhi		RPT-4821-520726	2026-07-24	SMP-HNY-96854400
c0d59045-9abf-454b-80b7-bedc6851fe59	ULR-FH-3375-80965337	LAB-IN-QMA-38811	Townsend Inc	NABL/TC-9456/7770	Suspended	Assam		RPT-3438-804919	2025-01-06	SMP-HNY-25201852
e7e60419-d338-4bb0-9625-c00b0b84a6c5	ULR-SZ-6865-87648845	LAB-IN-SAG-81478	Smith-Lutz	NABL/TC-2544/8037	Withdrawn	Nagaland		RPT-6029-175068	2023-08-16	SMP-HNY-68160765
23935eff-1c6d-421d-bb0d-f40de0038662	ULR-TP-8841-25061775	LAB-IN-XVF-19046	Munoz PLC	NABL/TC-1716/4682	Expired	Himachal Pradesh		RPT-1102-331926	2023-06-19	SMP-HNY-73964221
8ea70e1f-b5ab-4e2a-8fa8-e08b164f1173	ULR-PP-9227-20770349	LAB-IN-IAB-20677	Koch-Myers	NABL/TC-1484/1992	Active	Manipur		RPT-5942-834088	2024-11-17	SMP-HNY-41080282
0083e448-5bfb-4d1d-9742-22f544d323f7	ULR-UX-3752-56245895	LAB-IN-WXC-13717	Wilson, Carter and Harper	NABL/TC-7096/8487	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-1833-034035	2025-02-16	SMP-HNY-54323532
5a644c39-fa4e-4618-9a33-e15072aafe04	ULR-YC-9586-90723194	LAB-IN-DKP-94520	Baker, Sims and Stephens	NABL/TC-5855/5994	Active	Telangana		RPT-6522-535175	2022-01-14	SMP-HNY-85681594
b8fb052f-5277-428c-8725-2b5e7f03c01b	ULR-DI-1461-70576730	LAB-IN-GZF-99423	Harris-Sanders	NABL/TC-1935/9221	Suspended	Goa		RPT-9205-009392	2022-02-27	SMP-HNY-26709072
0d018e68-ed2e-4be9-9bff-617384ac2df6	ULR-OL-6023-38437508	LAB-IN-KPT-72605	Gonzalez-Byrd	NABL/TC-6638/0642	Active	Chandigarh		RPT-8322-390957	2021-12-06	SMP-HNY-27652797
52097124-2deb-4cf0-b171-bb141e2dea16	ULR-VX-6054-65145841	LAB-IN-QBC-11170	Santiago and Sons	NABL/TC-7381/6151	Withdrawn	Lakshadweep		RPT-3265-375278	2025-04-29	SMP-HNY-49889891
03672c1d-cbb6-4024-b00f-b01065dc1d88	ULR-FH-0564-98662328	LAB-IN-YAL-91276	Best-Peck	NABL/TC-6726/7828	Expired	Arunachal Pradesh		RPT-4601-863117	2025-04-07	SMP-HNY-67544480
f0f807d1-a133-4555-942c-404f56bbe575	ULR-RQ-7063-16923251	LAB-IN-RVZ-59126	Morris Ltd	NABL/TC-4088/5763	Withdrawn	Tripura		RPT-5025-578873	2023-09-27	SMP-HNY-80480259
b87f984b-d451-490a-8117-2383f8ac60f0	ULR-PE-1572-00222163	LAB-IN-FRN-09411	Sampson, Carter and Dunn	NABL/TC-6773/4028	Active	Gujarat		RPT-0899-202794	2026-08-14	SMP-HNY-39144257
046e962f-b298-47a0-aa80-c37cc4158984	ULR-MF-0335-58929759	LAB-IN-LXM-18090	Grant, Hubbard and Simpson	NABL/TC-8169/4344	Active	Gujarat		RPT-0394-080932	2026-03-16	SMP-HNY-65528204
8c7a0f32-0d17-49d9-a96b-168287f6db55	ULR-US-1420-19354384	LAB-IN-QFQ-33658	Velazquez LLC	NABL/TC-7945/5289	Suspended	Arunachal Pradesh		RPT-6962-568066	2021-11-24	SMP-HNY-48414654
e8b8df9f-0f99-448a-bed5-19d1f8e6c223	ULR-LV-0375-63725379	LAB-IN-RQH-01215	Clark, Young and Webb	NABL/TC-6607/4558	Suspended	Rajasthan		RPT-1141-536308	2024-09-04	SMP-HNY-42867578
aab7296a-e8f0-4464-ad91-966106adb105	ULR-PZ-1974-32356677	LAB-IN-CXG-55158	Snyder PLC	NABL/TC-1462/8729	Suspended	Manipur		RPT-8528-839457	2021-10-24	SMP-HNY-62414854
42192fdd-94cb-4ef1-a0b4-59a4eec6fbac	ULR-TS-7131-38014566	LAB-IN-BMQ-52850	Lutz Inc	NABL/TC-3177/8993	Suspended	Tamil Nadu		RPT-5045-883958	2022-12-27	SMP-HNY-90288106
e91e3bd9-bb08-4b67-8ae5-04131c403807	ULR-SQ-1749-87779942	LAB-IN-JVQ-78616	Sanders-Freeman	NABL/TC-3492/7896	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-2225-091833	2022-01-13	SMP-HNY-24600269
f6e1f7e4-7a19-47cd-94b1-b60e27257f93	ULR-HG-9404-94958889	LAB-IN-PTX-80274	Gray-Lopez	NABL/TC-6405/6693	Expired	Uttar Pradesh		RPT-3111-881430	2024-06-27	SMP-HNY-91937659
2a29b395-4ca3-421c-9516-81e199f927b2	ULR-FM-4567-77242525	LAB-IN-KPW-72363	Smith-White	NABL/TC-4970/4563	Expired	Mizoram		RPT-2026-608044	2024-01-11	SMP-HNY-37745784
d807c8bc-15e6-4cb8-8853-6e2788a1c826	ULR-KB-1587-19653526	LAB-IN-EYO-19175	Martin, Kim and Davis	NABL/TC-6098/3170	Suspended	Arunachal Pradesh		RPT-7953-356310	2025-11-13	SMP-HNY-02791066
5d3d753a-4e53-4441-9a55-03cdcc105797	ULR-PQ-3375-45450279	LAB-IN-TOQ-88281	Mcdaniel-Patterson	NABL/TC-1747/6800	Provisional	Rajasthan		RPT-2460-334583	2023-12-10	SMP-HNY-00200785
52db73d3-0fab-4862-9803-f307fd64f9b7	ULR-PA-2907-07857962	LAB-IN-BSP-01102	Knox PLC	NABL/TC-3787/0249	Expired	Jammu and Kashmir		RPT-7487-152449	2021-09-16	SMP-HNY-82200981
9fc3fb07-0b89-40ac-a810-dda33cb1a583	ULR-UX-3115-12050022	LAB-IN-WWX-42915	Rice LLC	NABL/TC-6474/2903	Suspended	Tripura		RPT-4224-429896	2023-12-14	SMP-HNY-75926887
122ecfa6-b740-4dc2-b54a-4d05ba094328	ULR-PB-6076-75296263	LAB-IN-XYL-16121	Bell, Robertson and Jacobson	NABL/TC-3085/2633	Withdrawn	Uttar Pradesh		RPT-6813-290433	2023-11-09	SMP-HNY-53192583
a94d7dc7-16ec-4c19-8c4d-e54a79d2637b	ULR-JH-0056-82025216	LAB-IN-QLM-89680	Ward LLC	NABL/TC-1222/2431	Suspended	Jharkhand		RPT-5743-105012	2022-07-28	SMP-HNY-92763401
de09551d-021c-4943-be9a-d906c7a10970	ULR-JA-6248-64131857	LAB-IN-BCH-48789	Martin LLC	NABL/TC-7439/5562	Expired	Tripura		RPT-2136-080468	2024-01-11	SMP-HNY-52469510
ca4327fe-5e00-4bce-a5ab-0aa4b4e5afe5	ULR-NJ-7192-52754270	LAB-IN-TYY-26058	West, Randall and Blankenship	NABL/TC-2740/1898	Withdrawn	Kerala		RPT-0160-169080	2024-01-25	SMP-HNY-94194426
10fc62c7-fb9e-43c9-b323-b987677765d3	ULR-ND-2522-13335119	LAB-IN-BKU-65001	Thomas-Braun	NABL/TC-3891/2830	Active	Tripura		RPT-3850-986619	2023-11-30	SMP-HNY-39186428
bebb640d-7974-4763-9dc7-f930faae9bd8	ULR-VF-1704-32733770	LAB-IN-JAC-07549	Lewis PLC	NABL/TC-4752/5391	Suspended	Punjab		RPT-4462-975358	2022-04-27	SMP-HNY-48514983
3272886e-52b7-47b1-a79c-f4f2b72ff22c	ULR-NJ-3086-94411901	LAB-IN-QTB-39773	Scott, Herrera and Richardson	NABL/TC-1137/7061	Provisional	Rajasthan		RPT-5742-547734	2022-11-21	SMP-HNY-86905769
c8bf2996-bbe3-4d34-9940-55775a37b36e	ULR-HG-6249-36857232	LAB-IN-DUA-75227	Nelson PLC	NABL/TC-0279/0980	Provisional	Goa		RPT-8840-268428	2023-11-18	SMP-HNY-64500772
46e6306d-cd59-450b-a897-1ecb48a0a847	ULR-SF-8060-12092783	LAB-IN-NHI-46089	Drake-George	NABL/TC-7479/5221	Expired	Arunachal Pradesh		RPT-9375-109928	2024-10-25	SMP-HNY-13242921
d638c8d3-a298-4477-ab49-3f5dfca698cd	ULR-UV-7395-03931488	LAB-IN-LJJ-16227	Mahoney, Hudson and Larsen	NABL/TC-3237/1107	Withdrawn	Uttar Pradesh		RPT-1785-079247	2022-08-16	SMP-HNY-60001755
c80f9536-29d1-4f37-bfea-f3fd37bd4521	ULR-LJ-8696-23620383	LAB-IN-MTB-86851	Johnson, Gibbs and King	NABL/TC-5744/4704	Expired	Puducherry		RPT-7703-213384	2021-12-23	SMP-HNY-23947277
310eaa65-2582-478f-81cc-97dc0aa6ad7a	ULR-CE-2170-00346422	LAB-IN-TLF-43868	Villegas-Wise	NABL/TC-2790/4067	Expired	Arunachal Pradesh		RPT-7270-571158	2023-10-01	SMP-HNY-22411057
3dac98b6-b9c2-4882-85e9-a5151515a56c	ULR-QS-9591-13982128	LAB-IN-RIA-73687	Turner LLC	NABL/TC-2357/8208	Suspended	Tamil Nadu		RPT-6433-227330	2026-07-14	SMP-HNY-23413588
cd64b6b9-f9f8-41d3-8206-d048cf56b9c1	ULR-PZ-4195-91464902	LAB-IN-DDK-97891	Jones, Watts and Allen	NABL/TC-8623/0934	Active	Telangana		RPT-7177-293790	2022-05-15	SMP-HNY-07554253
ccb78701-41b8-4900-bdf3-dbb9c5ffea1d	ULR-HX-4940-76006151	LAB-IN-HDW-21666	Smith, Romero and Berry	NABL/TC-8014/3880	Active	Chandigarh		RPT-2695-165731	2026-03-14	SMP-HNY-10073201
2525d620-4a31-4d3b-b11d-28ebbda8070f	ULR-IR-0126-21664727	LAB-IN-RXS-93730	Roberts, Henry and Collins	NABL/TC-2985/8245	Provisional	Jammu and Kashmir		RPT-9173-111205	2022-03-19	SMP-HNY-87151593
0a1be80d-13c2-43ae-9dfd-f609fdfe7bd2	ULR-DK-0909-90847996	LAB-IN-XLO-43603	Carney PLC	NABL/TC-8004/0116	Expired	Goa		RPT-0355-656451	2023-09-26	SMP-HNY-10453112
a515a991-4f4f-4ecb-890f-354a4a2b9e99	ULR-RQ-6962-66268706	LAB-IN-AJJ-82490	Wyatt-Price	NABL/TC-4993/0522	Provisional	Maharashtra		RPT-5601-628621	2025-11-17	SMP-HNY-78441604
1ddf7f4e-1b57-40c4-bfa5-d879c3cdc7bd	ULR-EA-7762-49803978	LAB-IN-EFS-35029	Holder LLC	NABL/TC-8584/8800	Provisional	Mizoram		RPT-9512-808997	2025-03-15	SMP-HNY-53512509
3803bf2c-cb42-4cfe-89ec-7e8869e4d8dd	ULR-SD-8114-06428645	LAB-IN-JBU-25743	Cox PLC	NABL/TC-0666/9338	Withdrawn	Karnataka		RPT-0288-975212	2023-10-28	SMP-HNY-61941778
fe4698c7-73e7-488b-8227-9ae0eb75457d	ULR-TU-8838-12634890	LAB-IN-OTW-10798	Mcdaniel and Sons	NABL/TC-4806/0673	Active	Chhattisgarh		RPT-6255-150061	2026-07-17	SMP-HNY-33765082
01960652-acdf-43f2-aa82-cfffd86ad2d7	ULR-DV-4124-70452426	LAB-IN-FOK-27652	Silva Group	NABL/TC-8103/1357	Withdrawn	Ladakh		RPT-9399-277569	2025-10-11	SMP-HNY-85029941
3aca4407-10ad-4e8d-972f-34a341ca3d8c	ULR-EV-6024-46795916	LAB-IN-ZME-71814	Frazier, Graves and Moran	NABL/TC-0798/4792	Active	Madhya Pradesh		RPT-7923-456738	2025-09-22	SMP-HNY-03979096
550aa9b1-05d8-4bb6-a0d7-96943961ec98	ULR-LO-8945-89057421	LAB-IN-ZXS-89796	King Group	NABL/TC-3776/3816	Expired	Karnataka		RPT-8880-570469	2023-07-08	SMP-HNY-72658227
73a2dd9a-04cb-4643-ad96-1c7d2440ac2d	ULR-LQ-4825-93867491	LAB-IN-OHW-02747	Ferrell-Hanson	NABL/TC-0007/7511	Withdrawn	Tripura		RPT-9444-479094	2021-12-19	SMP-HNY-29593762
976cc88a-a94f-4d1e-bdf5-3bd395f606d8	ULR-CD-1623-09065683	LAB-IN-WWE-97768	Oconnor, Odom and Bradford	NABL/TC-3629/7839	Active	Puducherry		RPT-8113-078211	2024-05-13	SMP-HNY-98182528
490fe72c-fed4-4ffa-9e07-0f5cee9330f1	ULR-GH-7953-30818250	LAB-IN-HWV-70869	Jenkins Ltd	NABL/TC-3485/3159	Expired	Bihar		RPT-9709-976113	2025-09-14	SMP-HNY-27537908
e0526fd3-8b2f-419f-8c4b-ad960575951d	ULR-QA-2019-82154338	LAB-IN-LWP-42561	Smith Ltd	NABL/TC-8066/7239	Suspended	Chandigarh		RPT-6426-586320	2024-09-05	SMP-HNY-51075081
0a90d7d6-b5da-4e56-b35b-b7a5548678ec	ULR-MI-2917-21958848	LAB-IN-NYI-14275	Martin, Hicks and Lee	NABL/TC-8929/0734	Provisional	Telangana		RPT-2675-380615	2026-08-15	SMP-HNY-50802179
6ec70289-3e5d-44e9-a95c-e78b4d72dd01	ULR-CI-4267-38750688	LAB-IN-QBX-59421	Silva and Sons	NABL/TC-3876/9863	Expired	Delhi		RPT-7138-489414	2026-06-18	SMP-HNY-15393658
13d9f6ef-2b00-4bd7-bbf5-a3e246dadf07	ULR-BG-7855-52056516	LAB-IN-PXL-97748	Reid and Sons	NABL/TC-6431/2461	Provisional	Bihar		RPT-0827-639658	2022-02-25	SMP-HNY-84153315
1f732235-b820-42c5-ba37-481cd2c397ac	ULR-KD-1606-69083529	LAB-IN-VKA-45691	Davis, Baird and Barton	NABL/TC-1674/5649	Withdrawn	Jammu and Kashmir		RPT-1401-601457	2023-02-17	SMP-HNY-13266100
5f6c9d5a-cc95-4cdb-ab73-b6e5ceaa7d6e	ULR-DE-9224-25969134	LAB-IN-OTK-21784	Castillo, White and Schultz	NABL/TC-4369/9065	Provisional	Haryana		RPT-1958-322226	2024-02-29	SMP-HNY-14344756
97fd0d08-812a-4176-b89f-918146968f52	ULR-BQ-9329-84861214	LAB-IN-PFT-99649	Thomas, Wilkinson and Huang	NABL/TC-1272/8010	Provisional	Odisha		RPT-0187-137892	2025-07-05	SMP-HNY-34088727
57347eee-d932-4da5-9dcd-76ca436116a9	ULR-ZR-3423-68011204	LAB-IN-RFF-10390	Peterson-Adams	NABL/TC-4779/6325	Active	Madhya Pradesh		RPT-6996-444592	2023-12-21	SMP-HNY-15843815
bc045bda-52c5-4852-a02e-26f250ac5085	ULR-XG-8257-58979070	LAB-IN-TRX-17400	Mitchell-Jones	NABL/TC-4998/3283	Provisional	Punjab		RPT-8283-775619	2025-10-26	SMP-HNY-66729793
85288add-00c2-4b64-a3ab-9323363760ce	ULR-MO-6746-35036709	LAB-IN-FUI-16902	Silva, James and Padilla	NABL/TC-8020/5635	Suspended	Jharkhand		RPT-1019-134275	2022-10-23	SMP-HNY-50185779
41f6488a-1adf-4dd1-a4a4-a2d0959bf1ec	ULR-ZN-5950-37121727	LAB-IN-NEI-07998	Weaver LLC	NABL/TC-0141/6996	Expired	Goa		RPT-8449-671712	2026-02-25	SMP-HNY-53777957
23cca5af-ccf9-4b3f-8653-f5adf2296552	ULR-DI-8495-89590024	LAB-IN-QZX-09500	Wood-Collins	NABL/TC-1455/7408	Withdrawn	Madhya Pradesh		RPT-7618-243091	2022-04-19	SMP-HNY-76519319
0aeeca06-f957-436a-b3f7-e62120b60126	ULR-NX-3387-91028730	LAB-IN-EHW-20017	Cruz, Peters and Phillips	NABL/TC-2265/6731	Suspended	Jammu and Kashmir		RPT-8062-575919	2022-08-02	SMP-HNY-21833646
58cd44c6-a77e-48db-8818-69fcd0263e95	ULR-RA-7139-42553302	LAB-IN-IZS-31395	Beck, Davis and Perry	NABL/TC-6574/2078	Active	Arunachal Pradesh		RPT-4882-040301	2026-04-29	SMP-HNY-41894521
c1e1ce0f-f0d7-4fa2-965d-9f621ebfdcba	ULR-DZ-4458-06540678	LAB-IN-OXK-94234	Bowers LLC	NABL/TC-8030/9721	Provisional	Ladakh		RPT-6233-266623	2026-05-03	SMP-HNY-33231556
cc74d314-b885-4411-8a7b-924dc623974b	ULR-AI-5612-34408161	LAB-IN-RVZ-95824	Davis and Sons	NABL/TC-7593/8470	Withdrawn	Nagaland		RPT-6324-074306	2026-04-29	SMP-HNY-05001971
c78b20e1-ed43-44b9-a97d-98a24a542a42	ULR-GH-6755-63244599	LAB-IN-MFK-05827	Wright Inc	NABL/TC-5977/1294	Provisional	Maharashtra		RPT-8506-733816	2023-03-11	SMP-HNY-39399178
8c008e06-98f2-460e-bfe1-5bbd1574e06f	ULR-NK-4025-03203989	LAB-IN-OBV-68292	Miller, Garcia and Espinoza	NABL/TC-3071/1525	Active	Nagaland		RPT-0261-650650	2022-12-30	SMP-HNY-16509704
4ab947bb-b14e-4511-8c39-b046f30452af	ULR-CB-7195-39266231	LAB-IN-BHL-99545	Sanchez, Edwards and Adams	NABL/TC-3192/7176	Provisional	Nagaland		RPT-4647-725962	2024-05-26	SMP-HNY-91111505
2a3aa644-1e42-4130-869c-e266ba38a5cd	ULR-TT-8094-38130358	LAB-IN-ZYJ-44231	Castro-Robinson	NABL/TC-3844/5614	Expired	Andhra Pradesh		RPT-6174-685644	2024-10-25	SMP-HNY-24178379
8f079b10-2344-410e-87e5-a34ceda3204c	ULR-JJ-5211-05379101	LAB-IN-WJB-19499	Perez PLC	NABL/TC-8832/2813	Active	Puducherry		RPT-2201-635950	2025-03-16	SMP-HNY-99896596
466e47a4-d957-40a3-a447-f26d476546f4	ULR-IP-6428-24399963	LAB-IN-OFI-62641	Freeman-Ortiz	NABL/TC-1221/9631	Expired	Goa		RPT-1552-121374	2025-06-28	SMP-HNY-79322579
2d5c3aa9-884d-426c-9fd2-e64752a95721	ULR-QY-6301-56658938	LAB-IN-JSS-49756	Weiss-Curry	NABL/TC-9197/7896	Withdrawn	Arunachal Pradesh		RPT-4549-327474	2023-02-21	SMP-HNY-38432343
fce08a1e-e1bb-4df1-8061-5ee651660248	ULR-BD-6171-83389851	LAB-IN-BRC-70670	Barnett-Oneill	NABL/TC-3843/6044	Withdrawn	Bihar		RPT-3138-716590	2025-10-09	SMP-HNY-52612106
5ba26c27-aef4-4b38-836a-65e36c93c3cb	ULR-OV-1367-87933476	LAB-IN-STL-01762	Jones Ltd	NABL/TC-0406/4629	Active	Himachal Pradesh		RPT-1264-738033	2023-05-09	SMP-HNY-26191738
f490b71c-5df2-4db3-aa56-b4e4d01a85a7	ULR-ZF-6841-06782406	LAB-IN-IAL-36334	Weaver LLC	NABL/TC-4682/8941	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-0370-986738	2024-05-17	SMP-HNY-39216460
f94a6aba-c318-4048-8837-90a13a5db47a	ULR-LR-1522-10758389	LAB-IN-ZGS-40119	Smith, Williams and Hill	NABL/TC-6400/8323	Expired	Maharashtra		RPT-9777-904046	2024-02-23	SMP-HNY-80115321
de852390-0753-4cdd-bb03-7c56be31e42f	ULR-WA-1845-78476595	LAB-IN-XIP-76686	Palmer LLC	NABL/TC-6640/9235	Withdrawn	Goa		RPT-6470-938685	2025-06-13	SMP-HNY-20701082
e6860e21-3701-40da-be4b-42116cbb6b6f	ULR-MP-5294-49940347	LAB-IN-PQU-16263	Gibson LLC	NABL/TC-0511/8196	Expired	Himachal Pradesh		RPT-8817-203051	2022-09-20	SMP-HNY-51057609
20e39cb8-368e-48f6-bda3-c8f1f0053eee	ULR-EV-1722-86328402	LAB-IN-ULS-91015	Rios Inc	NABL/TC-1353/7055	Withdrawn	Madhya Pradesh		RPT-7852-854549	2023-01-18	SMP-HNY-63533768
dce1fb4e-111e-4591-9e1e-048dcf9294b1	ULR-LG-9666-32665678	LAB-IN-VKU-83402	Hall and Sons	NABL/TC-9963/8894	Withdrawn	Himachal Pradesh		RPT-5261-219359	2024-09-02	SMP-HNY-52233921
ebe62d73-024d-4697-bf41-1a4164f5ca39	ULR-PO-1518-41492179	LAB-IN-PXN-52443	Ballard-Bell	NABL/TC-9836/7191	Active	Madhya Pradesh		RPT-1691-642705	2026-06-29	SMP-HNY-15535199
ee8b5db7-22ca-4a99-8d42-63ac83545ef8	ULR-EB-2056-06595908	LAB-IN-RLJ-09023	Flowers Ltd	NABL/TC-1789/5730	Active	Chhattisgarh		RPT-1022-221514	2023-03-02	SMP-HNY-84187698
69e3075a-ed9c-4907-8948-6c8b506ea7c3	ULR-AY-3122-62447660	LAB-IN-FFZ-22965	Ward Ltd	NABL/TC-2573/1868	Withdrawn	Uttar Pradesh		RPT-5208-293075	2025-05-28	SMP-HNY-93853377
fe0bc40a-d4b5-4c3f-a17b-75b9c571fdf2	ULR-BQ-3013-58254275	LAB-IN-FGH-55351	Grant-Hawkins	NABL/TC-9863/9055	Suspended	Assam		RPT-7957-520370	2025-10-24	SMP-HNY-68959011
db091a26-c2a4-4e2f-a619-d4022b0ce912	ULR-IV-2379-12422200	LAB-IN-NDH-15065	Freeman Inc	NABL/TC-5012/6548	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-2635-809432	2022-09-27	SMP-HNY-84777899
8ab0000e-a007-42e4-a80a-90f15cbce8bd	ULR-WS-2260-41259712	LAB-IN-AZL-30333	Molina-Rivera	NABL/TC-0496/5134	Provisional	Telangana		RPT-4951-872886	2023-05-05	SMP-HNY-58606896
a56d8cac-d35a-481f-96c2-5c7e39c1322f	ULR-OY-9974-27427120	LAB-IN-UPG-05980	Chang LLC	NABL/TC-3521/9944	Active	Assam		RPT-9669-493755	2024-08-18	SMP-HNY-29397642
ed6aa0ef-e0f8-41aa-82e0-71ea57d1dc9e	ULR-FT-8380-94025544	LAB-IN-PQK-43098	Hoffman LLC	NABL/TC-2961/5552	Suspended	Ladakh		RPT-3275-126632	2021-11-26	SMP-HNY-17696470
ecc120b7-55bc-4594-86ac-bf60bb87dad2	ULR-WH-8347-17346439	LAB-IN-TBG-92010	Garcia-Pierce	NABL/TC-2379/6942	Suspended	Meghalaya		RPT-2608-579908	2023-12-24	SMP-HNY-86827086
cfd500d0-6fdf-4b86-b514-4b069691685d	ULR-EX-9267-45271386	LAB-IN-DSS-09517	Farley, Marshall and Williams	NABL/TC-3354/1310	Active	Punjab		RPT-3521-150709	2022-02-14	SMP-HNY-55362890
a5d0c755-0b0a-4266-a293-5b5289494851	ULR-YR-7996-77747825	LAB-IN-GJH-83170	Perry-Murray	NABL/TC-8056/3752	Withdrawn	Delhi		RPT-6277-008980	2021-10-16	SMP-HNY-16291961
9a834b07-0c09-448e-9642-f2b1461eb587	ULR-FO-6709-08616089	LAB-IN-GUY-40865	Sutton, Chapman and Johnson	NABL/TC-7494/8487	Active	Himachal Pradesh		RPT-7723-038685	2026-04-08	SMP-HNY-75593276
7570280c-0fed-4362-906d-83a12658106c	ULR-OM-7325-18106104	LAB-IN-UBE-61658	Cervantes-Hill	NABL/TC-9655/8087	Active	Chandigarh		RPT-3867-936688	2024-08-10	SMP-HNY-63180155
f4326d3b-3b5a-47b3-9842-5f73aa5176ee	ULR-HD-2984-47515819	LAB-IN-SXD-19578	Johnson, Moore and Stokes	NABL/TC-4869/4855	Suspended	West Bengal		RPT-3390-732690	2025-05-22	SMP-HNY-20111880
666cdf1a-83ec-4f49-82fb-72f615a6f77d	ULR-GL-1393-66059768	LAB-IN-UVD-92776	Higgins Group	NABL/TC-2490/5162	Suspended	Chhattisgarh		RPT-9111-049557	2024-06-22	SMP-HNY-76235371
42a9ee37-c19e-4324-8730-9c82505b543c	ULR-XO-3095-83891961	LAB-IN-VKG-56408	Snyder-Turner	NABL/TC-9053/8274	Withdrawn	Ladakh		RPT-7164-322945	2023-06-22	SMP-HNY-36750934
bb775387-d9ef-4b4f-bf47-e7f9e97f1dac	ULR-GQ-4643-36671177	LAB-IN-VJA-88740	Yoder, Lopez and Holmes	NABL/TC-9384/6654	Expired	Puducherry		RPT-0255-300275	2025-10-08	SMP-HNY-80651448
51f82d4e-a1c4-4231-8f6e-cd5bd39d82ea	ULR-VL-7518-49381281	LAB-IN-DLQ-81267	Case, Norris and Davis	NABL/TC-7203/6708	Active	Puducherry		RPT-5647-707060	2022-03-13	SMP-HNY-54067463
7c0dc7c3-a4c0-4a8e-88cb-1383f34b91a3	ULR-VQ-7131-56658349	LAB-IN-NHC-94454	Kelly, Henderson and Brown	NABL/TC-1815/4504	Suspended	Nagaland		RPT-6300-713675	2022-06-16	SMP-HNY-59922879
0be8b6f1-eee0-4d36-9b90-54d96fa3d1d3	ULR-XF-3140-48740750	LAB-IN-PXO-98691	Roman, Harrington and Sweeney	NABL/TC-6139/3982	Expired	Haryana		RPT-3900-534043	2026-01-14	SMP-HNY-31322866
e1514be6-26da-4871-873f-a261d71df750	ULR-BO-8186-77771076	LAB-IN-HTI-81150	Johnson-Mckinney	NABL/TC-0099/0641	Expired	Jammu and Kashmir		RPT-2719-877318	2024-02-12	SMP-HNY-57230667
354c18a4-95f4-45d2-9799-057b243c1bb0	ULR-XM-0331-92274369	LAB-IN-CZF-35690	Watson, Mcdonald and Bauer	NABL/TC-3760/2911	Active	Chandigarh		RPT-7267-600458	2023-10-06	SMP-HNY-63087305
844b6bd1-429a-4ac0-8e30-3ec3ffb39738	ULR-CR-0354-11601488	LAB-IN-EJR-30153	Yu, Jensen and Day	NABL/TC-3770/0120	Suspended	Maharashtra		RPT-8334-700192	2024-01-02	SMP-HNY-69949762
18aecb78-ff82-4cee-a345-67fc48402fcb	ULR-ZA-2963-11065696	LAB-IN-BCB-13792	Pierce PLC	NABL/TC-5201/7242	Active	Kerala		RPT-2459-606111	2024-07-15	SMP-HNY-63964346
c7ae168f-b2f2-4634-a6fc-ad532cf36966	ULR-QY-8718-37739883	LAB-IN-BWM-43891	Williams-King	NABL/TC-0896/2465	Provisional	Ladakh		RPT-1424-337141	2025-10-01	SMP-HNY-77134953
449888b2-f7ca-465d-9efc-c97a90408417	ULR-MG-6561-03746477	LAB-IN-PJZ-23060	Owen-Mitchell	NABL/TC-3645/7064	Active	Maharashtra		RPT-4002-096516	2022-05-25	SMP-HNY-29874531
7d4e31d9-06f2-4d60-a070-ed78c6bd7f35	ULR-PJ-3275-55714442	LAB-IN-AJQ-64763	Green, Austin and Shields	NABL/TC-8730/8265	Withdrawn	Andhra Pradesh		RPT-3001-548975	2023-08-07	SMP-HNY-30341344
ca1dc9e6-510e-4919-b516-1de932794d38	ULR-MR-7475-81926745	LAB-IN-FPI-33876	Thompson, Sandoval and Wilson	NABL/TC-6200/8504	Provisional	Uttar Pradesh		RPT-6372-446154	2024-04-09	SMP-HNY-41721657
46c0b15d-b68c-435b-bad9-f57b5e446c36	ULR-ZL-5735-79359639	LAB-IN-RYU-02604	Peters, Evans and Figueroa	NABL/TC-2616/7649	Active	Tamil Nadu		RPT-6885-502552	2023-05-17	SMP-HNY-78168787
ac2ef227-d418-4fbc-8f45-81b65a57d211	ULR-KN-3765-14701827	LAB-IN-UPX-19125	Mills-Caldwell	NABL/TC-5839/8264	Expired	Delhi		RPT-6768-740899	2026-06-04	SMP-HNY-12572279
06809324-3e83-4b18-a18b-478126733fbd	ULR-XL-2995-59269057	LAB-IN-TDF-04192	Carr, Flores and Jackson	NABL/TC-3835/8203	Provisional	Delhi		RPT-3301-593305	2026-07-02	SMP-HNY-34407572
109a4747-5829-4ffb-9995-895223344f34	ULR-WA-4301-25268119	LAB-IN-SMX-58750	Leonard Inc	NABL/TC-9464/3651	Expired	Uttar Pradesh		RPT-5464-142569	2022-10-30	SMP-HNY-46283826
693f43de-3a2a-4d44-9c31-5f180a1e6aa9	ULR-HF-4437-96908959	LAB-IN-DTR-08052	Neal Ltd	NABL/TC-5256/3801	Expired	Gujarat		RPT-7796-871171	2023-06-15	SMP-HNY-62691866
db08ab2a-2bc5-406e-8958-582d093bb8ff	ULR-CI-6030-29748184	LAB-IN-PJW-71772	Miller-Caldwell	NABL/TC-2239/6753	Expired	Chhattisgarh		RPT-0988-197287	2025-11-03	SMP-HNY-96308288
be595503-8c0e-4bbb-860a-09c9c519e42f	ULR-RG-7123-51476285	LAB-IN-UEE-56851	Brown Inc	NABL/TC-7170/7562	Provisional	Mizoram		RPT-7026-747254	2025-07-24	SMP-HNY-57630448
f33955da-61d2-4e3f-985e-dfb58fcdb62e	ULR-GF-1444-88125038	LAB-IN-QDJ-40828	Robinson, Johnson and Baker	NABL/TC-8102/0209	Withdrawn	Karnataka		RPT-0430-988156	2023-11-15	SMP-HNY-00909488
168bbee3-06cc-42c6-a693-4579c1b5659c	ULR-TJ-1544-52591838	LAB-IN-WZI-79413	Mason-Freeman	NABL/TC-3188/6799	Suspended	Himachal Pradesh		RPT-9433-142036	2022-06-24	SMP-HNY-67682675
27879717-f190-4505-be23-17085ddd4a98	ULR-AK-3342-69599384	LAB-IN-LMN-37020	Gordon and Sons	NABL/TC-3255/7734	Active	Jharkhand		RPT-7456-829315	2026-03-13	SMP-HNY-90234691
fb3e57ec-6fdf-4128-a185-dbea089c2b09	ULR-KV-4069-80319257	LAB-IN-PMF-83692	Douglas, Smith and Mills	NABL/TC-6889/3256	Withdrawn	Tamil Nadu		RPT-0058-174940	2026-01-11	SMP-HNY-17225677
ea2a47af-82a8-4ad1-b320-51ff44c97c40	ULR-RQ-5113-37018628	LAB-IN-ESD-06486	Kennedy, Wright and Gaines	NABL/TC-8213/4998	Expired	Mizoram		RPT-8892-247514	2025-02-06	SMP-HNY-46656985
6fd55aac-acfe-4d80-a8b2-891b163ac56b	ULR-RA-0625-12124397	LAB-IN-VNX-16641	Wyatt, Lopez and Miller	NABL/TC-7240/0779	Withdrawn	Bihar		RPT-2824-798194	2024-07-20	SMP-HNY-88247382
c3828df2-0e09-4f32-96d1-b70a3ecccd4f	ULR-GK-3917-21281284	LAB-IN-YMD-05031	Smith-Garcia	NABL/TC-8548/7598	Active	Chandigarh		RPT-3590-926220	2024-06-25	SMP-HNY-80116026
3907edf2-1c9d-41e9-8db4-5956dc3331ef	ULR-WL-4941-61018314	LAB-IN-GWZ-17121	Maldonado-Bradley	NABL/TC-8928/9785	Expired	Kerala		RPT-6128-219506	2026-03-31	SMP-HNY-85803968
39521241-236e-43fd-9571-63c0ed87cefe	ULR-YY-4466-67434380	LAB-IN-AFV-05363	Clark-Edwards	NABL/TC-4972/6062	Withdrawn	Punjab		RPT-8619-710268	2024-08-05	SMP-HNY-73158865
4b4002fe-ce64-4f10-b177-59e1515b3840	ULR-QN-2235-96669727	LAB-IN-CUN-07149	Juarez, Lewis and Bradley	NABL/TC-1945/2647	Suspended	Jammu and Kashmir		RPT-8884-552488	2026-03-14	SMP-HNY-97554535
e47316c0-e67a-4942-a97a-0292394a103d	ULR-YJ-4024-61434651	LAB-IN-KOO-49298	Brandt and Sons	NABL/TC-7347/7484	Suspended	Mizoram		RPT-1444-782711	2025-12-02	SMP-HNY-51875803
320cb690-0aff-4e5c-a4f8-2f08b6f39426	ULR-WR-1713-06240379	LAB-IN-YSV-38944	Abbott, Russell and Lewis	NABL/TC-1935/4725	Expired	Tamil Nadu		RPT-8454-247426	2025-01-10	SMP-HNY-98634057
656dc41e-4968-4d3b-9a50-1029df8eacd2	ULR-HR-2650-55358615	LAB-IN-TKF-03345	Davis PLC	NABL/TC-9533/3790	Active	West Bengal		RPT-9604-321751	2023-12-09	SMP-HNY-99012197
22de5331-1c05-404f-8daf-f6eb29023017	ULR-IE-3605-52775254	LAB-IN-KPM-42264	Cantu Inc	NABL/TC-3851/0831	Withdrawn	Haryana		RPT-2181-413519	2025-09-18	SMP-HNY-29773719
e82dd002-2102-4de0-9522-46bcf39d831e	ULR-PE-5844-98047288	LAB-IN-UCZ-21985	Lee and Sons	NABL/TC-0022/8921	Active	Jammu and Kashmir		RPT-1424-803674	2023-10-21	SMP-HNY-12381855
1cdf1288-db64-4eae-9591-5e4644495a45	ULR-JW-6145-21875661	LAB-IN-SXS-13651	Gonzalez-Swanson	NABL/TC-6555/1402	Active	Gujarat		RPT-3885-909152	2022-09-25	SMP-HNY-65463048
d71fe39e-f8e9-41de-909c-54f94af18b2f	ULR-ZW-2926-14773694	LAB-IN-UOI-64179	Hart, Reese and Chang	NABL/TC-8561/2988	Expired	Uttarakhand		RPT-7110-485278	2022-08-27	SMP-HNY-91576314
1b081ad5-2707-46f6-a00a-019c375c9587	ULR-QV-6751-42418692	LAB-IN-QHI-56011	Mills, Salazar and Rogers	NABL/TC-7012/8541	Active	Jammu and Kashmir		RPT-0715-760641	2022-02-21	SMP-HNY-40136087
c46dafe0-5573-4976-841f-a85708d47cc9	ULR-YH-7316-61428599	LAB-IN-FOA-47840	Hill Ltd	NABL/TC-6681/8316	Active	Karnataka		RPT-5648-456211	2023-12-22	SMP-HNY-79656021
69f620ae-df03-4c57-8f39-e1042df5be16	ULR-RX-4943-54168781	LAB-IN-SCX-29776	Barnes-Fox	NABL/TC-4227/0958	Active	Tripura		RPT-2684-108470	2023-08-14	SMP-HNY-22933874
ffbe3630-5fb3-4431-851b-13d870f79c67	ULR-RT-9544-58230518	LAB-IN-DJM-51640	Kidd, Miller and Burnett	NABL/TC-2225/3618	Provisional	Odisha		RPT-4499-736677	2025-04-28	SMP-HNY-26934378
e6f43d03-7eea-4c6d-aa7b-70527e1b266b	ULR-BJ-8009-12647943	LAB-IN-KSE-50346	Erickson, Simon and Murphy	NABL/TC-6584/0162	Expired	Kerala		RPT-1680-737042	2022-11-06	SMP-HNY-74144330
6aa468b9-3f07-4192-8541-11273e3e39a9	ULR-IF-8331-44721499	LAB-IN-VAV-84532	White and Sons	NABL/TC-7981/8528	Withdrawn	Andaman and Nicobar Islands		RPT-9307-782238	2023-02-02	SMP-HNY-69086435
dbd27201-60ef-4553-9083-b0925a277f3a	ULR-CE-8546-39656671	LAB-IN-AIN-11303	Grant, Nguyen and Graham	NABL/TC-4531/6258	Expired	Punjab		RPT-5196-160827	2022-09-14	SMP-HNY-71541484
ec540a9b-254e-4b76-8a6b-ac53b44e6139	ULR-QT-2749-32616291	LAB-IN-XSL-99520	Stevens PLC	NABL/TC-0703/5884	Provisional	Uttarakhand		RPT-8121-835983	2026-02-22	SMP-HNY-73082499
e459bc4a-ec0b-43ad-b8a5-df58ce4f4e1d	ULR-HJ-4785-73050267	LAB-IN-HAJ-42847	Simmons-Woods	NABL/TC-9187/2265	Expired	Uttarakhand		RPT-0424-845956	2025-08-14	SMP-HNY-40140470
0977e7f7-d49a-4bd8-b076-9bde0ebe74de	ULR-BP-3320-80753633	LAB-IN-IAI-94943	Boyer PLC	NABL/TC-8163/9673	Suspended	West Bengal		RPT-5002-292453	2025-07-28	SMP-HNY-03871038
ead702ef-3003-4f95-bf47-151ad67a0625	ULR-OS-5347-99368261	LAB-IN-EED-65919	Allison, Wyatt and Hernandez	NABL/TC-4858/7365	Active	Goa		RPT-6286-770703	2023-07-01	SMP-HNY-59853471
20209b8b-e991-41c1-ae6c-b2f2de94ee8f	ULR-ZX-5017-29980486	LAB-IN-HMQ-44478	Hernandez-Hill	NABL/TC-4104/7445	Suspended	Tamil Nadu		RPT-4821-586572	2023-07-13	SMP-HNY-68391580
39ebc49a-71d3-4da0-b4fb-91f1ed3e2f66	ULR-YK-8071-46372583	LAB-IN-EFF-56480	Jones-Morse	NABL/TC-3354/0499	Expired	Assam		RPT-1776-294830	2022-11-28	SMP-HNY-06730077
51d77935-44e6-488e-8e08-6d779662b36d	ULR-DU-1489-10627938	LAB-IN-NJN-28775	Schneider, Peterson and Singleton	NABL/TC-3110/2298	Withdrawn	Ladakh		RPT-0559-682380	2022-12-21	SMP-HNY-02841027
6e56ff83-a989-4b1e-b7f8-db3cd463f52f	ULR-OD-7506-35672645	LAB-IN-YQD-06081	Morales Ltd	NABL/TC-6752/4110	Active	Punjab		RPT-8690-683169	2023-08-30	SMP-HNY-59354045
86e08b5d-3f40-435e-aba5-4bc4627cf511	ULR-GQ-7703-42994156	LAB-IN-CIB-03930	Brooks and Sons	NABL/TC-9590/7067	Withdrawn	Telangana		RPT-7027-845013	2024-04-13	SMP-HNY-60339480
0a3fcccd-674c-4140-be11-90eb3c35b620	ULR-AF-0399-96176194	LAB-IN-FSG-49567	Serrano PLC	NABL/TC-5887/6624	Provisional	Uttar Pradesh		RPT-1219-717844	2024-12-21	SMP-HNY-26323207
2dcca8fc-c944-40aa-b432-a616fbe7b818	ULR-XE-4062-89645652	LAB-IN-VXM-57787	Koch-Porter	NABL/TC-0194/6245	Provisional	Rajasthan		RPT-0637-773583	2023-02-05	SMP-HNY-22084883
56ff4252-d0da-4a83-b079-100322f8b3f5	ULR-CI-2450-38051291	LAB-IN-ZLB-73009	Acosta, Lawson and Stevens	NABL/TC-5503/4617	Active	Goa		RPT-6116-406116	2024-03-29	SMP-HNY-52378213
65ee1afd-90b6-4c5b-9b71-4854806c3737	ULR-YA-3187-37916046	LAB-IN-REN-23828	Welch Group	NABL/TC-2975/1346	Active	Jammu and Kashmir		RPT-9449-536578	2024-05-31	SMP-HNY-13124964
5be91dff-8f01-4e08-85af-0c6d3b3acd76	ULR-KT-4163-70082946	LAB-IN-UDQ-36818	Molina-Whitney	NABL/TC-0562/1152	Withdrawn	Maharashtra		RPT-6430-671602	2025-12-28	SMP-HNY-55081061
918532d6-0a3e-406b-a41f-0ede246a8744	ULR-UX-1443-63549392	LAB-IN-JMU-61965	Peterson, Davis and Torres	NABL/TC-1583/1123	Withdrawn	Odisha		RPT-6772-006258	2025-02-22	SMP-HNY-96742421
ae73f128-13ca-490a-a7d0-476ff475f727	ULR-QA-7881-62541274	LAB-IN-LKP-64840	Carroll LLC	NABL/TC-0068/7745	Expired	Uttar Pradesh		RPT-1965-035154	2022-09-14	SMP-HNY-47299839
8fe330be-167a-4f7d-b274-de7c8143ce43	ULR-IH-9171-19032683	LAB-IN-NOA-83412	Willis-Wilson	NABL/TC-9301/0845	Provisional	Jharkhand		RPT-1584-256889	2025-04-08	SMP-HNY-71946610
404aea20-2375-4d2b-9a80-4c957e897fad	ULR-XK-9684-05970538	LAB-IN-OZV-59512	Dawson and Sons	NABL/TC-9396/3997	Provisional	Rajasthan		RPT-4791-090584	2024-03-12	SMP-HNY-08850412
71414bc4-8f6a-4bb3-b692-722bbc4cc0d0	ULR-TR-4686-64941764	LAB-IN-YMD-24686	Mcintosh PLC	NABL/TC-8817/9566	Expired	Andaman and Nicobar Islands		RPT-6857-019129	2023-06-30	SMP-HNY-67285423
487c8b68-7463-4bf8-900c-d7c70cee8896	ULR-GP-3323-16520656	LAB-IN-WPW-16066	Meza-Lucas	NABL/TC-1407/5870	Suspended	Jharkhand		RPT-0821-326739	2023-09-01	SMP-HNY-60781859
3ead661f-6891-4349-838e-3704c360b3d3	ULR-PV-6898-49427970	LAB-IN-DBV-12975	Shaffer LLC	NABL/TC-8326/4489	Withdrawn	Uttar Pradesh		RPT-1443-459280	2025-08-13	SMP-HNY-58558739
e44dd5cd-3ec1-4f77-a813-53ec8229eecd	ULR-VC-4294-09120126	LAB-IN-CIQ-29776	Smith, Hunter and Vasquez	NABL/TC-4124/2602	Provisional	Karnataka		RPT-9798-685499	2026-07-09	SMP-HNY-71353586
20c1bc3d-e207-43dd-ae4b-669a57cde87c	ULR-RC-9241-09029948	LAB-IN-FUE-42676	Gonzalez Group	NABL/TC-9580/3059	Suspended	Bihar		RPT-4924-425771	2024-09-12	SMP-HNY-27951818
d32769a4-a048-4202-9053-7a7310a3b71b	ULR-OI-5330-29293931	LAB-IN-ANI-14025	Johnson, Bishop and Morrow	NABL/TC-6048/6574	Withdrawn	Manipur		RPT-0752-695456	2023-01-08	SMP-HNY-52293169
c8afb31b-492d-4100-8951-c21af8e7da59	ULR-XS-8961-57786323	LAB-IN-OAK-37837	Nguyen, Frye and Smith	NABL/TC-3387/8505	Expired	Gujarat		RPT-3495-516230	2023-11-15	SMP-HNY-93261762
998f5de8-d12e-45fe-9756-4002d13c4712	ULR-DO-7393-53309192	LAB-IN-WWV-87417	Murphy PLC	NABL/TC-4868/6950	Active	Himachal Pradesh		RPT-3239-828331	2026-03-01	SMP-HNY-60590186
ff7930c7-a5a9-41ac-8f9b-fd9d4323560f	ULR-QG-5385-15283094	LAB-IN-HHW-31546	Williams PLC	NABL/TC-2941/4858	Suspended	Manipur		RPT-6921-703906	2026-01-22	SMP-HNY-24648620
0d2c90ff-6253-4bca-bdd1-fd499f2271a5	ULR-IZ-1585-15025222	LAB-IN-ZOJ-30925	Fry, Ellis and Mclaughlin	NABL/TC-8315/0993	Provisional	Odisha		RPT-4195-957310	2025-06-13	SMP-HNY-57925407
8ab6b668-bec0-4b96-9e29-2be49e295b86	ULR-RK-1860-67032518	LAB-IN-LAQ-57244	Gardner, Stewart and Sloan	NABL/TC-3257/9738	Expired	Madhya Pradesh		RPT-7183-692386	2022-07-05	SMP-HNY-14119160
abb13a05-3640-4200-a010-0bbdeda65772	ULR-JK-4850-06048990	LAB-IN-XUC-63202	Morris-Dixon	NABL/TC-3819/6863	Provisional	Delhi		RPT-4804-745895	2023-09-03	SMP-HNY-60112273
96ec0c1d-5bcf-4a76-bedb-bd61297a26f2	ULR-UR-8619-70147712	LAB-IN-RHH-05786	Davidson LLC	NABL/TC-9161/0999	Provisional	Chhattisgarh		RPT-5993-537285	2023-02-07	SMP-HNY-30725388
09a82fde-13ed-47e3-8d2e-8fac29246983	ULR-YG-9410-49047459	LAB-IN-QFQ-59692	Juarez Inc	NABL/TC-7030/2567	Provisional	Bihar		RPT-2372-041196	2022-04-16	SMP-HNY-82127742
61cd0793-5618-4ff5-a2c7-628bcd952600	ULR-WA-7822-75259568	LAB-IN-CQO-84930	Richards-Mcmillan	NABL/TC-1205/6324	Suspended	Gujarat		RPT-7974-103873	2023-03-17	SMP-HNY-67148295
de2b7629-138d-4e8e-a97f-2deb0bde883b	ULR-QE-0752-73774493	LAB-IN-LVX-73609	Sanders, Jones and Garcia	NABL/TC-2033/6136	Withdrawn	Haryana		RPT-0107-851724	2023-04-26	SMP-HNY-88231493
af5d148e-75d4-405a-83ee-e93faf301b1b	ULR-IT-5030-60714092	LAB-IN-NPM-66757	Murphy-Holland	NABL/TC-2927/4446	Withdrawn	Madhya Pradesh		RPT-3766-360042	2025-02-14	SMP-HNY-40873194
010a3e67-3de5-419c-a2c0-53c52c21a277	ULR-VW-9328-68087471	LAB-IN-QMI-89346	Brooks-Miller	NABL/TC-3025/8632	Suspended	Arunachal Pradesh		RPT-7702-588488	2022-03-20	SMP-HNY-81769692
e627f316-16f9-4e04-b224-9b42820bcf28	ULR-TP-3568-93870030	LAB-IN-VDV-98137	Davis and Sons	NABL/TC-5896/5740	Active	Uttar Pradesh		RPT-7587-072909	2022-06-22	SMP-HNY-84446822
d7f3d2f3-0b1f-43a8-978b-65d2f731370a	ULR-IW-1783-42587389	LAB-IN-JWH-11218	Ingram-Bell	NABL/TC-6109/8885	Active	Maharashtra		RPT-5331-773954	2024-02-14	SMP-HNY-53649121
69f1ddf5-4fa4-41c5-9940-d8dfbf77a87d	ULR-NK-6608-71631257	LAB-IN-XEV-34999	Garrison Group	NABL/TC-9390/6972	Expired	Andhra Pradesh		RPT-8295-748018	2025-11-30	SMP-HNY-33277758
ea1e8006-608a-4604-986b-be02b482e4e0	ULR-HO-6590-15948667	LAB-IN-JUD-03994	Bailey and Sons	NABL/TC-2558/9390	Provisional	Madhya Pradesh		RPT-0071-731041	2024-10-19	SMP-HNY-89244489
0d1a58ba-17f6-4583-b2a5-e4744ed444a1	ULR-TL-1562-18630645	LAB-IN-YDH-13343	Johnson LLC	NABL/TC-4362/6378	Expired	Uttarakhand		RPT-3934-827023	2025-08-29	SMP-HNY-29906421
d671fcea-4892-4133-ab63-d8f9d1111a38	ULR-IA-9587-08326666	LAB-IN-EVH-37184	Meyer, Johnson and Taylor	NABL/TC-2245/3575	Suspended	Nagaland		RPT-0845-188904	2024-10-09	SMP-HNY-91793671
1ce6d8b1-74ae-4415-88df-16fc21877179	ULR-YF-5774-16672224	LAB-IN-WKC-49909	Wolf-Mitchell	NABL/TC-9195/9775	Active	Meghalaya		RPT-2815-039106	2025-06-13	SMP-HNY-49678331
d2e5ee44-bd56-4169-b19c-473e75fb142f	ULR-QB-9388-35890935	LAB-IN-SCQ-91481	Nguyen, Shaw and Gill	NABL/TC-7288/9991	Active	Chhattisgarh		RPT-6845-264342	2025-04-05	SMP-HNY-08494342
a24ded11-0ada-426c-bdad-b7611ccb0c11	ULR-DH-1395-15988460	LAB-IN-DGA-68126	Schmidt, Williamson and Harris	NABL/TC-2043/2778	Expired	Manipur		RPT-0558-366214	2025-06-09	SMP-HNY-96714593
a3b5604f-b890-4bec-ab8c-f60dbf5113fe	ULR-TF-3326-19015770	LAB-IN-ZEC-12985	Allen Ltd	NABL/TC-8727/6624	Suspended	Madhya Pradesh		RPT-1051-317727	2025-03-21	SMP-HNY-94265748
856ec19c-8759-4e5f-b3c7-3ac8355cbb9b	ULR-LV-0964-53630659	LAB-IN-SZI-22866	Simpson Ltd	NABL/TC-4443/4439	Expired	West Bengal		RPT-7696-596233	2025-06-04	SMP-HNY-65542169
ecc18b72-feb5-4574-aedd-37862de5c5cd	ULR-AT-8391-41327485	LAB-IN-FMT-12291	Wallace, Wright and Warren	NABL/TC-9725/7430	Suspended	Haryana		RPT-0084-690124	2026-04-14	SMP-HNY-76274884
7423d699-c188-431a-82aa-99701e74c2ad	ULR-EK-7981-44232614	LAB-IN-KUB-84878	Munoz-Allen	NABL/TC-3745/5199	Provisional	Telangana		RPT-9514-081486	2025-04-01	SMP-HNY-42158661
57d5e803-7073-4911-b899-93f6b1831e75	ULR-YD-0084-05324408	LAB-IN-MWF-75856	Rivera-Ferguson	NABL/TC-0046/9131	Provisional	Andaman and Nicobar Islands		RPT-6617-375744	2022-09-06	SMP-HNY-42164977
9de5e555-52cb-4687-a035-f6ce99f44864	ULR-LI-5998-60071033	LAB-IN-IQT-71864	Perez-Lopez	NABL/TC-7642/8261	Suspended	Meghalaya		RPT-9008-506609	2025-03-10	SMP-HNY-34835580
1953fabc-fb35-48cf-9cce-ade719fc643a	ULR-AU-8377-99381572	LAB-IN-QHV-95945	Ortiz and Sons	NABL/TC-0064/9112	Expired	Telangana		RPT-1674-113529	2024-07-08	SMP-HNY-22616413
688352d2-35e2-46f8-8ca4-10cae8f9bbc6	ULR-MN-2034-87687324	LAB-IN-ZQU-39712	Moore Inc	NABL/TC-3429/1990	Expired	Sikkim		RPT-8672-388577	2022-04-16	SMP-HNY-98603822
cf08b219-46b5-462f-9b09-de176777bdf6	ULR-SB-5851-82776048	LAB-IN-XQK-73444	Ramirez-Grimes	NABL/TC-9538/1760	Withdrawn	Uttar Pradesh		RPT-4599-011796	2023-12-03	SMP-HNY-38288108
236e10e4-5ce3-41ad-a95b-fa67189c51d1	ULR-CU-8344-81473908	LAB-IN-ZDS-84098	Wong Ltd	NABL/TC-0995/6876	Provisional	West Bengal		RPT-1661-652683	2022-07-04	SMP-HNY-81970973
5fbdddd7-7f90-4132-8df1-0ab6d495bef4	ULR-YM-6582-59366766	LAB-IN-ESX-08019	Brown-Brown	NABL/TC-8087/6485	Active	Jammu and Kashmir		RPT-1583-846743	2023-08-15	SMP-HNY-13491128
88c4f2a3-5041-4b06-9613-641ffe8c0482	ULR-OL-1633-41365132	LAB-IN-UYF-27526	Hammond, Hogan and Walters	NABL/TC-6262/0444	Suspended	Chhattisgarh		RPT-8903-416960	2023-02-23	SMP-HNY-75462755
82f8e219-59f8-4514-8a36-59ee101e0140	ULR-HG-9899-93426396	LAB-IN-KLK-31631	Thompson Group	NABL/TC-0563/7479	Provisional	West Bengal		RPT-9680-993294	2022-07-10	SMP-HNY-14980957
1b2151fa-5db0-4d73-bc57-47d5ae723482	ULR-FA-9847-45575917	LAB-IN-UBL-88769	Dixon-Jensen	NABL/TC-0781/6978	Withdrawn	Meghalaya		RPT-6215-389400	2026-01-24	SMP-HNY-79153567
0c3b9a79-01e1-49a3-a6f1-47d582c99640	ULR-HX-8420-68446378	LAB-IN-EVK-33638	Evans-Morris	NABL/TC-5726/3389	Active	Telangana		RPT-0626-235864	2026-03-02	SMP-HNY-27390843
c859b145-a373-4b24-aef7-912be0b8809d	ULR-XC-3625-95425174	LAB-IN-EKU-14800	Mitchell, Meyers and Rodriguez	NABL/TC-9802/6704	Expired	Sikkim		RPT-8507-640169	2025-12-07	SMP-HNY-01295331
9d49639b-dfcc-4fd7-86f9-2dfe3684ec29	ULR-XE-5970-16559695	LAB-IN-KZE-69757	Ramirez-Ryan	NABL/TC-8409/9933	Withdrawn	Bihar		RPT-8497-411059	2026-06-27	SMP-HNY-19471553
9b724336-4178-4b61-a17e-5e56fd5f16d6	ULR-DE-4730-81615986	LAB-IN-LOS-91904	Malone-Johnson	NABL/TC-5053/1458	Expired	Uttarakhand		RPT-7329-851724	2025-07-04	SMP-HNY-47074575
05cc180c-243b-413c-883d-0a31c8e85f63	ULR-GV-4504-27645390	LAB-IN-MFD-24502	Bowen PLC	NABL/TC-5506/3707	Suspended	Odisha		RPT-1007-021967	2021-09-15	SMP-HNY-13758669
fefae078-02b5-47e3-be4e-e40b34cf2dcf	ULR-AI-4208-47978813	LAB-IN-YUI-74246	Norris Inc	NABL/TC-2053/5945	Expired	Ladakh		RPT-9350-784307	2025-03-25	SMP-HNY-71399674
c2d40118-4308-4527-a81e-d199f8b2d2af	ULR-NX-2803-93665628	LAB-IN-SZE-05120	Kline-Ellis	NABL/TC-5839/0816	Withdrawn	Delhi		RPT-4482-440453	2021-10-17	SMP-HNY-51803592
ea437117-73ec-46df-a125-e7eb1b009086	ULR-PQ-4581-86352186	LAB-IN-ZDR-47261	Pierce Ltd	NABL/TC-3628/8225	Active	Rajasthan		RPT-4944-251134	2024-04-09	SMP-HNY-72592373
ca8b2892-3ed5-4dc6-b6c5-6916340d1fe6	ULR-SV-6995-58262088	LAB-IN-IAY-16034	Wells Inc	NABL/TC-9587/6909	Active	Haryana		RPT-3349-159554	2022-05-08	SMP-HNY-14035364
5c3859a4-a344-4a37-a736-45849426059c	ULR-PM-1076-67339111	LAB-IN-PCN-78746	Johnson-Miles	NABL/TC-6000/8875	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-1070-362455	2024-10-13	SMP-HNY-20450477
18237946-155b-4d1a-9eb0-8c24448b1e8d	ULR-DR-6694-31387447	LAB-IN-ERK-03119	Graham-Caldwell	NABL/TC-2725/8189	Provisional	Arunachal Pradesh		RPT-2787-053082	2024-02-02	SMP-HNY-13541490
a138601c-6124-48f8-92ee-d39c1256367f	ULR-KE-4044-43182757	LAB-IN-ARK-60905	Gamble-Bradford	NABL/TC-3465/4354	Withdrawn	Gujarat		RPT-7707-679921	2024-01-09	SMP-HNY-69223388
f7dc9525-e26e-40c8-a520-b08a8db56d5b	ULR-EK-1497-84272865	LAB-IN-MZN-39986	Wheeler LLC	NABL/TC-0353/0416	Expired	Arunachal Pradesh		RPT-9908-021876	2025-10-07	SMP-HNY-34149894
fe18edc6-8536-4720-822d-38cc3bbb83f5	ULR-ST-6867-51156873	LAB-IN-YUF-15596	Williams, Morales and Donaldson	NABL/TC-0578/4767	Active	Maharashtra		RPT-5410-982789	2026-04-29	SMP-HNY-80814852
a62d4278-d504-45fe-b6c7-9cabac026525	ULR-OV-7128-48427951	LAB-IN-ZVI-72393	Russell Group	NABL/TC-0488/9615	Expired	Tripura		RPT-3727-465529	2021-10-23	SMP-HNY-29646288
93215e2e-f22a-4ed6-8998-2a48a3e40465	ULR-XL-3716-26822781	LAB-IN-VYX-30175	Lopez Ltd	NABL/TC-6793/5942	Active	Bihar		RPT-6371-386644	2023-01-01	SMP-HNY-71084937
2ac4829d-21ac-4dd4-82a8-2fac3fee84f1	ULR-DD-3898-28999824	LAB-IN-IML-37343	Dunlap-Lyons	NABL/TC-3435/1641	Active	Karnataka		RPT-3571-400118	2026-01-05	SMP-HNY-54669952
9518818c-340a-4970-8013-1d45fe64d165	ULR-XY-7142-49317310	LAB-IN-MBB-30321	Anderson LLC	NABL/TC-3133/5100	Expired	West Bengal		RPT-9674-086877	2024-06-13	SMP-HNY-26247633
b2c73a53-b83c-4b02-876e-2e8bc825741a	ULR-BG-7564-96645390	LAB-IN-DVA-69962	Powers-Church	NABL/TC-3321/6576	Suspended	Tripura		RPT-5689-516132	2024-01-10	SMP-HNY-38680693
5d032e55-0784-4e27-8959-5345b099243d	ULR-EK-8719-15267823	LAB-IN-IIM-03568	Lowe, Jones and Mckay	NABL/TC-1727/6305	Suspended	Kerala		RPT-7763-452555	2026-07-18	SMP-HNY-95382373
5f5b0bb7-3029-452b-ae06-89d888f1ab6b	ULR-GG-3378-97471177	LAB-IN-LNY-95931	Campbell and Sons	NABL/TC-5830/5478	Withdrawn	Puducherry		RPT-6129-040824	2025-06-09	SMP-HNY-12258452
86d26e8c-25f0-49a3-b26d-7f7ba81c4f37	ULR-JP-3922-79676362	LAB-IN-LTG-71036	Ball-Stafford	NABL/TC-9123/5145	Active	Chhattisgarh		RPT-9606-359523	2024-03-31	SMP-HNY-09635698
4c8f7bbd-219c-4095-9877-5978442adc64	ULR-HJ-0275-58482676	LAB-IN-PCV-73891	Soto-Foley	NABL/TC-0087/6434	Suspended	Mizoram		RPT-8496-698334	2024-02-13	SMP-HNY-03649744
957efcc6-af21-4ea9-9e89-cbeb5b69f839	ULR-RK-1344-93441648	LAB-IN-BFL-74487	Li-Nichols	NABL/TC-1517/3702	Provisional	Karnataka		RPT-0637-991905	2025-02-13	SMP-HNY-81997578
6fb5c890-6b5a-4d74-8b4f-81b234623f37	ULR-OL-3435-49509365	LAB-IN-DRZ-90529	Guzman-Reed	NABL/TC-2062/3635	Suspended	Chhattisgarh		RPT-6950-008310	2026-04-20	SMP-HNY-20099660
e1af40b2-ebce-450d-8708-e1ff54414432	ULR-FG-2787-95562741	LAB-IN-DXH-86515	Poole Group	NABL/TC-4980/6851	Active	Ladakh		RPT-9395-490949	2023-10-11	SMP-HNY-14633651
90e7b139-fa1a-4f52-8ae7-37f4dd6d99c4	ULR-DK-2180-43088702	LAB-IN-QFA-42238	Nielsen-Smith	NABL/TC-3667/2892	Provisional	Karnataka		RPT-1639-689632	2021-09-25	SMP-HNY-20505709
2c1e1a12-1c29-4410-b97b-2864e1e67b62	ULR-IO-0388-69130633	LAB-IN-ONU-90749	Richard, Garrett and Campbell	NABL/TC-6066/7988	Suspended	Nagaland		RPT-6371-071068	2021-10-02	SMP-HNY-71953481
a661101b-ddf6-471e-88da-87dee14b4db0	ULR-IY-9099-21433664	LAB-IN-IYU-09958	Wells, Saunders and Aguilar	NABL/TC-7457/8432	Suspended	Ladakh		RPT-8336-260268	2024-11-12	SMP-HNY-67763285
def2d683-954e-47ff-a8af-9ff5cf7730c3	ULR-KW-2757-48697469	LAB-IN-VUP-20008	Hampton Group	NABL/TC-3213/3486	Expired	Andhra Pradesh		RPT-6377-887089	2021-10-10	SMP-HNY-34669108
27f3931f-2b8c-45ff-a951-444df9b9e2a0	ULR-PI-0604-41757478	LAB-IN-YEO-30562	Nguyen Ltd	NABL/TC-8632/3846	Active	Kerala		RPT-6183-941840	2023-03-09	SMP-HNY-70654001
312fc879-213a-4cff-8ad7-9d279aeb5706	ULR-VB-6600-11581814	LAB-IN-YXI-59491	Stevens Group	NABL/TC-0516/6015	Withdrawn	Chhattisgarh		RPT-0015-943075	2021-09-13	SMP-HNY-45669610
04af2fb1-1753-4715-95db-b85bc4bb69d3	ULR-SC-5199-75595577	LAB-IN-WOM-06944	Carroll LLC	NABL/TC-6824/7831	Provisional	Maharashtra		RPT-8236-542728	2024-02-04	SMP-HNY-24901340
59ff4b8e-7155-42b3-b687-bde4c827cf81	ULR-IS-6914-66784036	LAB-IN-PPN-93064	Barron, Jones and Brown	NABL/TC-2690/5223	Provisional	West Bengal		RPT-3312-075077	2023-07-17	SMP-HNY-05503721
2b5654d1-c786-4737-ba3c-fda9ef8ad4fb	ULR-KU-5251-03491426	LAB-IN-QAP-51806	Hall Group	NABL/TC-1266/5715	Provisional	Punjab		RPT-2494-442022	2022-01-19	SMP-HNY-15900665
3127f644-5e20-4625-996c-0a6a73ae91e3	ULR-FW-8813-88696793	LAB-IN-SJH-14374	Kirby Ltd	NABL/TC-4905/4547	Provisional	Mizoram		RPT-7018-413386	2026-05-10	SMP-HNY-87873705
3addaf3d-c5c7-4345-a19f-c0bffbe11a35	ULR-PQ-3019-64360294	LAB-IN-JRR-96025	Barton-Mcdonald	NABL/TC-2424/0569	Expired	Bihar		RPT-6856-686814	2022-09-30	SMP-HNY-39870922
bd2a8dcf-9721-4c7d-b3b4-6a6c81e3e1d1	ULR-GR-0110-18196577	LAB-IN-MPG-69140	Pacheco-Dunn	NABL/TC-6246/8940	Active	Jharkhand		RPT-1385-548956	2021-10-19	SMP-HNY-42230705
5fbef9f1-87bc-43da-a240-92b90094acba	ULR-IW-7735-36910932	LAB-IN-UCG-75705	Lawson PLC	NABL/TC-8350/1803	Withdrawn	Odisha		RPT-9005-188769	2022-02-13	SMP-HNY-70490208
c3c32c4d-f7ab-40c8-b787-8999dd85012a	ULR-PO-9745-23085033	LAB-IN-IPO-43078	Carroll, Miranda and Hernandez	NABL/TC-8278/0718	Expired	Haryana		RPT-1289-623876	2022-11-07	SMP-HNY-19680250
a74dd2d4-1416-4016-a101-905a54295115	ULR-JS-7355-97485471	LAB-IN-ZYG-37652	Hodge Inc	NABL/TC-4175/7343	Active	Nagaland		RPT-6986-249086	2023-01-26	SMP-HNY-81179185
fdcbb712-a338-47ec-a2db-de9dc0c462bd	ULR-KU-7463-85539603	LAB-IN-NMU-35640	Sutton, Tran and Cook	NABL/TC-7437/7420	Provisional	West Bengal		RPT-6995-098914	2025-02-26	SMP-HNY-24089652
7c53a0d8-d38c-4fba-a964-a154f4bcddb7	ULR-XJ-2430-72328895	LAB-IN-MVJ-46936	Phillips LLC	NABL/TC-1487/3493	Expired	Chhattisgarh		RPT-5959-366309	2026-03-14	SMP-HNY-29722994
b06706f6-f521-49e0-b122-6dc26606177e	ULR-YM-1481-17839112	LAB-IN-ZVJ-92822	Salas Group	NABL/TC-4767/7495	Suspended	Ladakh		RPT-2418-840612	2023-06-13	SMP-HNY-42819756
d091b7e3-029b-4d2b-8423-f8c81c541b3d	ULR-AS-0711-90265962	LAB-IN-FTE-93116	Jacobson-Green	NABL/TC-3114/8779	Active	Puducherry		RPT-9771-106796	2026-04-27	SMP-HNY-94139933
d1e3455a-74ad-481e-9501-7c01427861af	ULR-SC-7030-41671218	LAB-IN-UYQ-09951	Garcia-Bradley	NABL/TC-0388/6439	Withdrawn	Bihar		RPT-1997-796008	2026-03-25	SMP-HNY-07829619
75c60d11-c70a-4933-b577-349e89c8f268	ULR-QT-6880-84033651	LAB-IN-OQO-08131	Weiss-Levy	NABL/TC-4692/4673	Provisional	Andhra Pradesh		RPT-5646-698830	2025-06-10	SMP-HNY-40557565
78bf95ee-9f8e-4f85-b0fd-a7e6d1bc8c52	ULR-MJ-9021-67119987	LAB-IN-YIG-48232	Ball-Fisher	NABL/TC-4294/7810	Withdrawn	Meghalaya		RPT-7775-836908	2024-10-06	SMP-HNY-31583132
0a3c4220-edbb-4c6d-9b3a-3dad5d0d5beb	ULR-KV-7040-37612260	LAB-IN-MHR-28246	Wright-Jones	NABL/TC-2004/5002	Withdrawn	Lakshadweep		RPT-0099-694831	2025-04-27	SMP-HNY-47815754
9bbf45a9-c53a-479b-ba00-173eb6898d3d	ULR-KU-8832-81611640	LAB-IN-BMJ-20303	Mitchell, Chase and Jones	NABL/TC-7904/4453	Expired	Odisha		RPT-1668-412727	2025-03-21	SMP-HNY-34411719
4eb46d11-d5ee-4b2e-9646-4ced271a02a1	ULR-UX-7938-95424209	LAB-IN-CTU-82348	White, Ortega and Lowery	NABL/TC-9377/8753	Expired	Madhya Pradesh		RPT-1104-307472	2022-10-25	SMP-HNY-16279883
feaf4fc5-cf70-40f6-8dfb-b76f57d00add	ULR-BH-1071-53991826	LAB-IN-ZPH-24571	Sullivan and Sons	NABL/TC-8575/8828	Suspended	Manipur		RPT-8255-299672	2025-04-27	SMP-HNY-89662757
dcd30a5b-5757-4b71-9a78-803a453ac8d6	ULR-VZ-6022-76258700	LAB-IN-VIB-58484	Watson, Barrett and Morales	NABL/TC-8355/8751	Provisional	Madhya Pradesh		RPT-3836-153315	2024-09-16	SMP-HNY-19327622
c30f4575-4adb-4b6e-8598-299e3e603fd4	ULR-AF-1283-80608544	LAB-IN-ZNL-15605	Owens LLC	NABL/TC-0616/8442	Suspended	Nagaland		RPT-7709-717995	2023-06-07	SMP-HNY-45342724
7dd42e91-f1d8-49bb-bb32-8515e88e10dd	ULR-RU-2669-33764261	LAB-IN-QOG-41118	Lee, Raymond and Travis	NABL/TC-9594/0855	Provisional	Punjab		RPT-5512-093214	2022-02-01	SMP-HNY-84764775
172c5c07-49c0-43f6-b81b-b1a29d282f00	ULR-SG-4718-50989964	LAB-IN-KJK-56456	Hudson, Flynn and Martin	NABL/TC-7438/9857	Expired	Uttar Pradesh		RPT-6250-001696	2025-05-30	SMP-HNY-23925748
b1d934b8-c909-441d-b5cc-ff04f0487fa5	ULR-UC-4787-57520094	LAB-IN-QUX-50078	Williams LLC	NABL/TC-5109/9133	Provisional	Punjab		RPT-9798-150210	2025-11-20	SMP-HNY-61581820
408dc613-25f0-4107-baaa-d0218fa819d2	ULR-LD-5493-07668014	LAB-IN-VCX-73941	Gutierrez PLC	NABL/TC-8128/8086	Expired	West Bengal		RPT-6473-356123	2025-12-10	SMP-HNY-17716475
52da6f3e-bad4-4b8e-8a64-23ca872785c1	ULR-HY-5147-18036706	LAB-IN-YKB-35987	Jacobs-Flores	NABL/TC-5895/9403	Provisional	Arunachal Pradesh		RPT-8065-345256	2023-04-02	SMP-HNY-97273324
f27e0f53-9a61-472b-9959-3cdc87d19c62	ULR-VI-2909-79912655	LAB-IN-DBV-50357	Brooks Inc	NABL/TC-2761/3872	Suspended	Uttar Pradesh		RPT-0932-678563	2022-10-02	SMP-HNY-36508896
3594a28e-fac2-40ad-8509-6b3cc116cabd	ULR-CK-4951-46764267	LAB-IN-GQR-85496	Hughes, Serrano and Coleman	NABL/TC-1776/2120	Expired	Sikkim		RPT-7912-748845	2022-02-11	SMP-HNY-17014037
d9caab44-2efa-4dbb-b830-4c6432ffd0a4	ULR-WK-6332-55524181	LAB-IN-CWC-46605	Gray, Rosales and Green	NABL/TC-7048/3559	Expired	Bihar		RPT-2633-372510	2022-08-17	SMP-HNY-17318145
ac8a47c5-ff1a-4530-a279-4e3a7290b1af	ULR-WQ-7218-43329157	LAB-IN-SHL-56199	Miller and Sons	NABL/TC-0414/1785	Active	Haryana		RPT-3394-509199	2025-08-26	SMP-HNY-42717957
515c1d8e-c620-40a4-ac14-15853660e1e4	ULR-UB-1292-70078074	LAB-IN-FLH-36229	Higgins, Young and Brandt	NABL/TC-0308/3167	Expired	Odisha		RPT-5216-856813	2022-03-14	SMP-HNY-54983925
1fbcecaf-7343-4d80-861d-25a58be4ab05	ULR-VH-0640-67783463	LAB-IN-KDW-49304	Thomas, Robles and Blankenship	NABL/TC-3804/6574	Provisional	Kerala		RPT-4888-786648	2023-03-01	SMP-HNY-13714602
963117ab-5723-453b-8344-ec4f46d65f9b	ULR-DS-9429-24300184	LAB-IN-ZQH-02445	Jordan, Bennett and Rodriguez	NABL/TC-6036/1264	Withdrawn	Arunachal Pradesh		RPT-0255-092171	2025-08-30	SMP-HNY-59176642
eb9edabf-36f3-4e47-a881-60eb12bbb319	ULR-VE-6209-84601020	LAB-IN-CCK-66063	Clark, Chavez and Coleman	NABL/TC-4929/1814	Active	Meghalaya		RPT-1516-094062	2026-05-24	SMP-HNY-21788421
adbe4b71-a509-4dd8-becd-5946c5ddc603	ULR-WF-2122-21920132	LAB-IN-NMP-48439	Hamilton-Martinez	NABL/TC-3538/1098	Provisional	Andhra Pradesh		RPT-5573-465008	2025-06-14	SMP-HNY-91718460
c501e0ad-25ec-48f8-a176-617620389462	ULR-VW-9271-58160667	LAB-IN-KRM-13751	Little, Gibbs and Wang	NABL/TC-5666/1586	Active	Punjab		RPT-3414-153992	2022-11-23	SMP-HNY-05775736
4355a346-b40a-466a-a3fe-09682fd11c2d	ULR-BT-2989-95600895	LAB-IN-JRD-02747	Gomez, Wolf and Odom	NABL/TC-0069/1306	Provisional	Andaman and Nicobar Islands		RPT-4909-316351	2023-11-09	SMP-HNY-94274454
9acd2a28-788b-44e9-a973-107cf28ddbe1	ULR-CB-2404-57172523	LAB-IN-FBE-02789	Terry-Evans	NABL/TC-6264/6992	Provisional	Andaman and Nicobar Islands		RPT-4411-714329	2024-04-25	SMP-HNY-73982604
9ba31739-dc28-4993-8472-d84e6eef3006	ULR-PN-8620-40640241	LAB-IN-IJD-68380	Carr-Morrow	NABL/TC-9607/1574	Expired	Rajasthan		RPT-8420-986247	2023-09-07	SMP-HNY-30440681
8f58a825-5966-40b1-94eb-27843917737f	ULR-DM-3263-38341602	LAB-IN-DAI-77366	Howell Group	NABL/TC-3832/2559	Withdrawn	Nagaland		RPT-3242-491363	2024-03-13	SMP-HNY-49700531
bba1912e-daf5-4350-a2c3-4e595aa5bde6	ULR-CH-6381-63687748	LAB-IN-GBG-58559	Reynolds, Reyes and Rodriguez	NABL/TC-4653/9182	Expired	Uttar Pradesh		RPT-1284-506274	2022-10-16	SMP-HNY-02729020
ea92af97-a1ee-40d6-b203-c006d7ff5416	ULR-CT-2341-66674639	LAB-IN-LFE-24262	Miller-Wright	NABL/TC-7232/9858	Expired	Meghalaya		RPT-4290-660482	2024-07-26	SMP-HNY-61697008
05fbd4ea-3280-44dc-bf4c-b70f4f304376	ULR-ZX-7606-27207511	LAB-IN-YNM-17725	Johnson, Smith and Scott	NABL/TC-5651/5417	Active	Arunachal Pradesh		RPT-3570-794291	2023-12-15	SMP-HNY-62531740
f5f746a0-2be6-415d-ba7d-ca3d3b177ef8	ULR-KY-0172-55983740	LAB-IN-RZI-89361	Terry-Torres	NABL/TC-6925/2348	Expired	Uttar Pradesh		RPT-4191-438664	2024-12-25	SMP-HNY-65924033
91446e10-b5c6-43b1-91ec-f4c4e9284079	ULR-WG-7219-00685962	LAB-IN-SYU-40031	Wood, Thompson and Clark	NABL/TC-5272/5594	Withdrawn	Delhi		RPT-5748-323566	2022-06-14	SMP-HNY-33170449
1d43baac-fa22-4e72-8b35-fa4d8d9746d1	ULR-TE-3582-41500444	LAB-IN-QZP-96903	Smith PLC	NABL/TC-2813/0995	Suspended	Tamil Nadu		RPT-3726-024076	2022-11-04	SMP-HNY-41665235
0c8942d2-3186-43a3-a43d-b527571bd4bf	ULR-JY-7069-84221129	LAB-IN-LNF-10572	Garcia-Daniel	NABL/TC-4376/5931	Expired	Mizoram		RPT-3750-800038	2021-11-14	SMP-HNY-05264430
05eeb7c8-12ca-4141-9b76-b0e6bae3161c	ULR-OS-7153-45800626	LAB-IN-OQE-60296	Robertson-Wolfe	NABL/TC-0320/5754	Provisional	Haryana		RPT-9599-574569	2022-01-31	SMP-HNY-13097039
43cf8166-efae-44c1-beb1-db1c1b28e513	ULR-GJ-5216-64122420	LAB-IN-LIX-81266	Daniels-Greene	NABL/TC-6179/4177	Provisional	Uttarakhand		RPT-1119-325984	2025-09-15	SMP-HNY-66052095
a8039a0c-c9d3-467a-9b68-d3a5a9a849b5	ULR-VE-9301-39860920	LAB-IN-JAX-88181	Davis PLC	NABL/TC-9766/0569	Withdrawn	Kerala		RPT-5086-290130	2021-10-11	SMP-HNY-89148359
303430b2-2fc0-4ab2-875b-36285e7b01e3	ULR-BW-5632-35995850	LAB-IN-ZAT-84779	Vazquez, Green and Roman	NABL/TC-7441/0782	Active	Chandigarh		RPT-1911-279139	2021-12-28	SMP-HNY-14914670
3ec99e2f-e7fe-4348-9d2a-de46534779af	ULR-VM-3639-61793173	LAB-IN-WNO-12032	Reynolds, Sanders and Carroll	NABL/TC-6678/5339	Active	Tripura		RPT-7640-397247	2021-11-18	SMP-HNY-77993991
6eca187e-5906-46f4-8423-5202176447f7	ULR-FS-8585-07235715	LAB-IN-ICA-93423	Jones and Sons	NABL/TC-3627/0007	Expired	Uttar Pradesh		RPT-8913-152095	2024-03-11	SMP-HNY-01862876
af8edd89-dbf7-417c-ba8a-4d78a7b48af5	ULR-JI-9365-55642089	LAB-IN-QZZ-36522	Gardner-Carroll	NABL/TC-0100/1893	Active	Chandigarh		RPT-4628-491872	2024-02-17	SMP-HNY-34360958
27f5c548-5c10-4376-bfad-cfc88ccba4d5	ULR-PH-6139-73452932	LAB-IN-NBH-07454	Moore Group	NABL/TC-7567/0383	Suspended	Sikkim		RPT-6463-453713	2022-12-12	SMP-HNY-48801917
b0369812-7a81-4090-a750-63e6b97f75c8	ULR-BD-4701-15961133	LAB-IN-QDA-73710	Smith, Nelson and May	NABL/TC-2142/2353	Expired	Odisha		RPT-2109-218854	2022-03-18	SMP-HNY-69816516
f1df94e9-d70b-4137-8354-7f33d8dc431d	ULR-BE-4454-82093328	LAB-IN-CKA-55677	Davis Group	NABL/TC-7684/3542	Suspended	Gujarat		RPT-5723-604446	2024-02-27	SMP-HNY-72171588
01ac766b-d0c7-4004-a202-4f193ade06d4	ULR-SN-1343-89042046	LAB-IN-URP-85349	Joseph, Harrell and Good	NABL/TC-7421/1230	Withdrawn	Karnataka		RPT-2840-798514	2025-03-10	SMP-HNY-77313555
75da2d7c-3859-4f3c-8c4f-736a5d9cd1ba	ULR-SC-4387-41459215	LAB-IN-ZDZ-19789	Wallace-Griffin	NABL/TC-4879/5043	Withdrawn	Arunachal Pradesh		RPT-9081-063297	2024-09-28	SMP-HNY-64757832
085bec18-3c5c-4b20-8174-19fd19fbabd7	ULR-PT-0113-09253221	LAB-IN-YLA-89937	Johnson Ltd	NABL/TC-9930/9686	Suspended	Lakshadweep		RPT-0380-040559	2025-10-11	SMP-HNY-96967885
9f44fa51-f4a8-4fc4-828a-dc3a2f0e7184	ULR-AY-4758-29617024	LAB-IN-XFZ-47338	Brown and Sons	NABL/TC-1624/4535	Expired	Uttar Pradesh		RPT-9362-150849	2024-10-07	SMP-HNY-24066878
e97e7ff9-6c9b-484c-835f-c0c9017f7d9f	ULR-PE-5426-35202030	LAB-IN-QFE-56467	Floyd-Beck	NABL/TC-4850/2551	Suspended	Uttarakhand		RPT-4616-947056	2024-04-24	SMP-HNY-19333516
1be33277-8a53-4513-9ec3-d503a24b0f0d	ULR-YM-1764-52575093	LAB-IN-AWS-06006	Choi-Ramos	NABL/TC-7316/3903	Suspended	Lakshadweep		RPT-1872-553717	2022-02-22	SMP-HNY-67970866
d212c239-2ebc-4506-bf0a-30edb07b2dfa	ULR-YD-3064-51597644	LAB-IN-CTR-53311	Gray Group	NABL/TC-8909/2730	Active	West Bengal		RPT-2061-174057	2024-07-02	SMP-HNY-23484150
e27d9ee6-5b48-48e4-9ac5-de881e7d1932	ULR-CT-6399-56046099	LAB-IN-XPY-95010	Franklin, Hall and Rogers	NABL/TC-6259/0283	Suspended	Gujarat		RPT-8034-488321	2023-11-28	SMP-HNY-75960688
634f43dc-557a-4b9a-b709-39d3900f46f7	ULR-WI-2675-51524778	LAB-IN-FHA-28920	Daniels, Wise and Stephens	NABL/TC-0878/5397	Active	Sikkim		RPT-2697-577250	2025-06-03	SMP-HNY-79487425
83612b8b-ceeb-4912-ad53-20dbb51f1812	ULR-JP-4557-97154835	LAB-IN-YKR-20781	Wright-Davis	NABL/TC-0538/2502	Provisional	Telangana		RPT-4687-261017	2026-04-23	SMP-HNY-27987777
2c8a8e8b-b91a-49e5-b07c-2bf4fc6df352	ULR-WT-8070-75730857	LAB-IN-BWP-19052	Johnson-Coleman	NABL/TC-3916/9968	Provisional	Puducherry		RPT-5276-360324	2024-11-14	SMP-HNY-07729520
ce712200-4e20-4499-aca0-ee5973d5c9c5	ULR-JN-9807-50485470	LAB-IN-CDZ-40238	Wagner, Mitchell and Wilcox	NABL/TC-0880/4718	Active	Uttar Pradesh		RPT-5054-486360	2022-10-23	SMP-HNY-45387114
68c8809e-92b2-465c-83bb-1f24bb40cbc0	ULR-EC-7662-45390305	LAB-IN-QME-85238	Clark, Moore and Quinn	NABL/TC-5626/0887	Provisional	Odisha		RPT-1923-536019	2026-07-18	SMP-HNY-09574588
0f1dab04-a45c-4fcb-9bcb-a79eef538393	ULR-XK-3528-72388020	LAB-IN-ZDV-92748	Flores, Villarreal and Smith	NABL/TC-2839/3225	Active	Assam		RPT-2940-556088	2022-03-03	SMP-HNY-28056080
628e8d70-bcfb-4a57-b307-bdb356a3fc4e	ULR-NM-0173-04089291	LAB-IN-SCH-65656	King Ltd	NABL/TC-9489/6364	Active	Uttarakhand		RPT-2405-487634	2024-05-08	SMP-HNY-61318639
e22975d2-a4ed-4412-b57f-4349a9ab217f	ULR-AC-7449-03592761	LAB-IN-BXT-61931	Hill, Riddle and Jordan	NABL/TC-6370/8597	Withdrawn	Karnataka		RPT-5167-127958	2024-01-04	SMP-HNY-86477422
4a222536-85e0-4423-b552-af448df31c66	ULR-RJ-0732-83963258	LAB-IN-VTV-72033	Combs, Butler and Sanchez	NABL/TC-3557/5721	Suspended	Delhi		RPT-5750-980231	2025-12-02	SMP-HNY-97141977
4bb1b76c-7c79-4008-9fa7-c7fe7f90bb33	ULR-VX-9940-22399050	LAB-IN-EPB-91016	Long Group	NABL/TC-1093/5069	Withdrawn	Lakshadweep		RPT-3804-699398	2025-10-26	SMP-HNY-16797569
ed23a0a0-917f-41dd-a630-078d647a3561	ULR-ZQ-7391-50740704	LAB-IN-TQC-11037	Richmond-Carey	NABL/TC-5691/1484	Provisional	Uttarakhand		RPT-3760-103970	2024-11-23	SMP-HNY-11105103
c40ee03c-eb1a-4e43-b2d0-470262e12c1c	ULR-CA-8727-41038572	LAB-IN-BXU-20231	Thomas-Garcia	NABL/TC-8645/7501	Expired	West Bengal		RPT-2413-513671	2024-10-22	SMP-HNY-54549758
30b31b1b-74b0-473c-9a7f-62d37aaa741c	ULR-PZ-0178-29902815	LAB-IN-TJJ-62003	Gonzalez, Robbins and Rice	NABL/TC-4994/8881	Provisional	Sikkim		RPT-1747-785169	2023-08-11	SMP-HNY-05094868
a6d14997-d5c7-4b1a-9bc7-c06a036ee1f8	ULR-EK-6638-16348420	LAB-IN-REL-69613	Taylor-Baldwin	NABL/TC-9325/5417	Suspended	Madhya Pradesh		RPT-6831-098642	2026-08-10	SMP-HNY-97941433
60a6f35a-1d49-44ea-9e53-aa7a34d70ea2	ULR-JN-2083-40456981	LAB-IN-BRK-22936	Harrell, Bailey and Haas	NABL/TC-2177/1412	Expired	Chandigarh		RPT-3652-098430	2026-01-31	SMP-HNY-75064443
3f749bc7-706e-4211-9439-8aa7d1b14c3d	ULR-YY-3787-87219264	LAB-IN-KMJ-37797	Webster PLC	NABL/TC-9913/8379	Expired	Karnataka		RPT-0035-915096	2023-05-07	SMP-HNY-42165356
bb569e5a-fa08-4128-b2f8-1ade264dfa10	ULR-ZF-2551-52396473	LAB-IN-ZIN-97593	Nguyen-Thomas	NABL/TC-1596/9755	Withdrawn	West Bengal		RPT-0134-104549	2023-12-26	SMP-HNY-46945039
247f89c0-a251-4515-93c5-a0eb0e2e2c6c	ULR-RY-7344-99645688	LAB-IN-VPO-45782	Tucker Ltd	NABL/TC-7602/8538	Provisional	Chandigarh		RPT-5521-050297	2022-02-20	SMP-HNY-87823136
e0e995a9-d7d1-404e-a1a5-15e8f07d8fef	ULR-KL-1023-64610843	LAB-IN-PJD-15157	Nixon, Murphy and Johnson	NABL/TC-1790/1909	Active	Manipur		RPT-9068-765859	2022-04-10	SMP-HNY-64320876
b690c9bd-692d-49ed-90be-3df8eccec3c7	ULR-GI-1852-50256256	LAB-IN-KQA-56565	Washington-Cunningham	NABL/TC-6357/1968	Provisional	Madhya Pradesh		RPT-4724-936649	2024-01-09	SMP-HNY-05248633
2f300bdc-b697-44e8-92a4-3f3570271bc8	ULR-GN-5849-87244892	LAB-IN-AUA-17683	Edwards, King and Schroeder	NABL/TC-8539/9065	Suspended	Andhra Pradesh		RPT-0011-721217	2025-11-12	SMP-HNY-88122843
21b5ca40-964b-48a4-9cd4-de785610cfde	ULR-VE-0875-61326717	LAB-IN-ZWM-33857	Compton-Adams	NABL/TC-7819/9658	Provisional	Chandigarh		RPT-8241-234021	2025-12-28	SMP-HNY-88588299
efcea2d9-f2d9-4332-a1f6-c48fb181e2c5	ULR-CF-5894-83915606	LAB-IN-QNW-01176	Jones PLC	NABL/TC-6350/6201	Provisional	Gujarat		RPT-0688-103310	2024-12-10	SMP-HNY-16942728
d1dab72a-434a-4f0f-9bda-051a759d06c1	ULR-GG-4828-47906405	LAB-IN-EQL-37710	Quinn, King and Galvan	NABL/TC-8342/6717	Active	Andhra Pradesh		RPT-7773-273906	2024-03-01	SMP-HNY-63138243
fe70d6ef-b2fe-4800-bbaa-516841bc389d	ULR-OR-4785-59619443	LAB-IN-YRW-51126	Adams Group	NABL/TC-7560/4654	Provisional	Lakshadweep		RPT-9178-630549	2026-04-12	SMP-HNY-93078902
e93cf4f7-0aa2-4eff-bd96-e843023d8a90	ULR-BA-5307-97612111	LAB-IN-DZT-64091	Jordan-Hernandez	NABL/TC-8088/7490	Withdrawn	Chhattisgarh		RPT-9457-074712	2025-12-23	SMP-HNY-08381388
bbd57562-4053-4cf9-a09b-da40ec29a0e4	ULR-FS-2959-25763532	LAB-IN-USN-13358	Smith, Alvarado and Kelly	NABL/TC-5007/4099	Suspended	West Bengal		RPT-5506-118835	2025-12-06	SMP-HNY-96310204
4d6f9bf9-e43b-4cbf-b32b-1a8eb24b2ca8	ULR-TE-3419-58854911	LAB-IN-LUZ-35793	Clayton, Walker and Bright	NABL/TC-7863/6313	Withdrawn	Madhya Pradesh		RPT-4984-961366	2022-06-12	SMP-HNY-17926203
5e672e3e-a38f-4f5d-ac9d-e230c653232a	ULR-VM-9338-75805969	LAB-IN-YBE-05795	Morgan-Mason	NABL/TC-6164/7290	Provisional	Nagaland		RPT-1177-332550	2024-02-05	SMP-HNY-24012126
71417e74-f168-4718-b948-ac76b8a5fde2	ULR-ME-9710-23593790	LAB-IN-BBD-27984	Austin, Peterson and Ibarra	NABL/TC-6930/6070	Suspended	Punjab		RPT-5902-539180	2023-07-07	SMP-HNY-40063938
8510233c-d85d-4644-9cee-8ff1a9c27201	ULR-XT-8112-25816071	LAB-IN-OFH-39803	Reed, Munoz and Campbell	NABL/TC-0523/4015	Withdrawn	Maharashtra		RPT-7802-007035	2026-02-19	SMP-HNY-45512998
cf367299-efa9-4005-9f40-0a57873469ae	ULR-SC-7478-29710994	LAB-IN-MZJ-25316	Richards PLC	NABL/TC-5111/7885	Expired	Dadra and Nagar Haveli and Daman and Diu		RPT-5634-401906	2022-11-15	SMP-HNY-94805390
ae82cbcc-90d0-4a23-9f79-f7560b5fb61e	ULR-XM-9519-93112802	LAB-IN-QNC-57845	Burton and Sons	NABL/TC-5440/6292	Expired	Dadra and Nagar Haveli and Daman and Diu		RPT-6903-724710	2023-08-17	SMP-HNY-48840527
2731e06b-c3e2-4784-968b-a7daa88af32c	ULR-OD-0191-45532242	LAB-IN-EBY-91854	Johnson-Cooper	NABL/TC-4918/1692	Suspended	Rajasthan		RPT-7878-461500	2022-11-10	SMP-HNY-38141333
ca74bbce-df26-44a9-af81-0eb3a6ad1963	ULR-ZD-7097-17186335	LAB-IN-VGH-88454	Hansen, Lloyd and Baker	NABL/TC-4245/4082	Withdrawn	Delhi		RPT-2865-876390	2025-04-01	SMP-HNY-59177188
a6ff8f5a-36ff-4717-b613-212aea3d0f11	ULR-GA-1584-27486023	LAB-IN-TXK-99698	Hines and Sons	NABL/TC-6622/2775	Suspended	Odisha		RPT-4135-484514	2023-02-16	SMP-HNY-40044001
cbfb9f22-7b94-40b2-b81f-80e1059f1e43	ULR-IZ-9204-07483299	LAB-IN-LLO-74331	Collins-Aguirre	NABL/TC-8034/1042	Expired	Andaman and Nicobar Islands		RPT-6748-427839	2022-06-04	SMP-HNY-33811024
29bb10d9-96be-4b3e-862f-ee57cc036853	ULR-UZ-8173-22182780	LAB-IN-NDT-68202	Chan Inc	NABL/TC-8176/9222	Provisional	Tripura		RPT-8536-941258	2026-01-31	SMP-HNY-54937881
c085f76a-ab0e-4fc0-b4c7-77ceb40c309b	ULR-TH-1856-45948773	LAB-IN-NCQ-08683	Schultz-Hughes	NABL/TC-9635/6124	Suspended	Tamil Nadu		RPT-0456-538830	2022-02-09	SMP-HNY-12224939
4bbd38d0-69d8-47e1-b7dd-54a30a08ebff	ULR-ZP-0738-34536169	LAB-IN-RWA-95917	Moore-Hernandez	NABL/TC-7936/1429	Withdrawn	Sikkim		RPT-1691-967530	2025-05-11	SMP-HNY-45185222
77d4cb16-6e4e-40e4-b831-aa520c5be5eb	ULR-DX-1989-87224176	LAB-IN-WLD-61665	Reed-Townsend	NABL/TC-1652/7964	Provisional	Chhattisgarh		RPT-4007-991713	2024-02-25	SMP-HNY-46795215
2db0e908-6408-4afa-b12d-5bb986f28be0	ULR-YE-0905-08617809	LAB-IN-TWJ-14782	Williams and Sons	NABL/TC-1625/3292	Active	Nagaland		RPT-4069-529847	2025-01-23	SMP-HNY-49718515
ba2f8f69-e09a-4bbe-a257-a680c196489c	ULR-SN-1172-59713749	LAB-IN-UKX-46545	Jackson, Hernandez and Rose	NABL/TC-7532/3434	Suspended	Arunachal Pradesh		RPT-0001-392124	2024-02-16	SMP-HNY-92980652
51975dc0-8bd3-4ba3-a5a8-fdc2712bed1a	ULR-VT-6899-36614737	LAB-IN-BUE-57694	Campbell, Bowman and Clark	NABL/TC-4887/2848	Suspended	Kerala		RPT-3117-548845	2023-04-14	SMP-HNY-52098371
fe328bd1-bb88-4538-841e-e95fe8f0ead3	ULR-ON-8089-10383174	LAB-IN-QGL-84561	Wilson-Watson	NABL/TC-5045/8078	Active	Bihar		RPT-0788-649295	2025-05-19	SMP-HNY-24482617
ab8209d8-160f-4277-857c-0bf1c3eed79e	ULR-MW-3870-68763788	LAB-IN-MNT-02373	Navarro Ltd	NABL/TC-5399/5858	Withdrawn	Goa		RPT-8684-547183	2021-10-21	SMP-HNY-04268040
c6cafcae-de91-42b0-a696-78c5f5f874a1	ULR-IS-2952-49993510	LAB-IN-GUQ-53535	Martin-Brown	NABL/TC-6360/5052	Active	Tamil Nadu		RPT-9882-544624	2026-06-27	SMP-HNY-03026882
2218525f-2a18-48e2-ae4b-6a0976ab9670	ULR-HU-5756-26004066	LAB-IN-FLD-84415	Sawyer-Rogers	NABL/TC-6900/1956	Expired	Jammu and Kashmir		RPT-6294-154255	2024-04-08	SMP-HNY-37120998
f4526447-61a7-4460-a813-4f32a4f5c91e	ULR-XD-5670-49305309	LAB-IN-MEY-46674	Bruce PLC	NABL/TC-6833/1035	Provisional	Maharashtra		RPT-0825-514529	2023-11-07	SMP-HNY-71169523
a49f426b-c69f-47db-ac0f-fb83767ad14a	ULR-AP-6442-27001275	LAB-IN-DON-46241	Shaw, Larson and Johnston	NABL/TC-2573/3585	Expired	Odisha		RPT-3353-139305	2022-10-16	SMP-HNY-43949027
f77c6233-651f-4373-b910-719d1d3b981d	ULR-RA-7044-83543906	LAB-IN-FWL-35333	Cox Ltd	NABL/TC-5047/4933	Provisional	Lakshadweep		RPT-4289-547590	2023-03-05	SMP-HNY-16452558
2400f2cf-42d0-4c6f-9c58-6c6b36ba51e9	ULR-LW-0762-77334770	LAB-IN-PUS-02661	Dyer LLC	NABL/TC-2097/2468	Active	Mizoram		RPT-0723-963476	2024-09-07	SMP-HNY-45562633
0cd31925-da72-40b9-8a81-46f516732f97	ULR-CX-1949-13519245	LAB-IN-UTQ-60291	Delgado, Hall and Santos	NABL/TC-5983/3964	Provisional	Chandigarh		RPT-7572-334416	2024-11-17	SMP-HNY-31213761
1caa37d2-1d63-4ee1-a47d-c579fba066ff	ULR-WM-4154-71013068	LAB-IN-QQH-39208	Thompson and Sons	NABL/TC-7406/8710	Provisional	Jharkhand		RPT-5328-285420	2025-05-13	SMP-HNY-98332200
4e625976-90ca-4bf5-ba08-42f26ada6235	ULR-AL-6254-42585297	LAB-IN-WRO-86861	Romero-Frazier	NABL/TC-2709/4815	Expired	Ladakh		RPT-7299-562654	2022-10-27	SMP-HNY-16833792
3a74fd18-b899-4cbf-971c-779e32030036	ULR-YU-9743-18134418	LAB-IN-KAC-27614	Gomez-Richardson	NABL/TC-1592/8903	Provisional	Kerala		RPT-7262-237352	2024-11-24	SMP-HNY-07718596
679a97fc-199f-4491-9f75-9985749e16d9	ULR-HS-3816-10334482	LAB-IN-FYA-62551	Miller, Watson and Davis	NABL/TC-3588/8106	Suspended	Nagaland		RPT-6922-755595	2024-11-08	SMP-HNY-70011940
72a6a859-9614-485f-a0d4-f1ceccbb7bcf	ULR-RD-4848-56354317	LAB-IN-AKV-46138	Klein PLC	NABL/TC-4964/8422	Expired	Karnataka		RPT-8120-558517	2023-09-08	SMP-HNY-58568013
bf327620-d993-4b90-92e1-7ee6047d92e4	ULR-GV-1643-19631080	LAB-IN-ZCM-71228	Conley-Allen	NABL/TC-8950/5302	Withdrawn	Andaman and Nicobar Islands		RPT-1675-792309	2025-09-13	SMP-HNY-21458210
b91db744-add9-4cc5-8857-40d33f1e0825	ULR-JH-1741-85716970	LAB-IN-ZNM-74830	Allen, Harris and Stone	NABL/TC-5530/0787	Suspended	Andaman and Nicobar Islands		RPT-8861-401197	2025-04-25	SMP-HNY-40806261
0db9a6ac-6553-4c3a-b9f7-991ffd82f71e	ULR-TA-3990-50593958	LAB-IN-NYM-82111	Fletcher-Dominguez	NABL/TC-9794/6975	Suspended	Maharashtra		RPT-6871-905660	2025-08-14	SMP-HNY-65660805
e8d9d1b2-6894-4872-8e2d-a3ea565f13b4	ULR-OJ-0716-92430896	LAB-IN-BZD-39407	Lopez LLC	NABL/TC-5185/3376	Withdrawn	Andaman and Nicobar Islands		RPT-6237-988770	2025-02-15	SMP-HNY-98847941
1b1888ab-2ae8-49d6-916a-f502f7d7ef30	ULR-EH-9013-82603354	LAB-IN-WFI-55175	Thomas Inc	NABL/TC-2134/7931	Suspended	Karnataka		RPT-3356-113997	2023-07-15	SMP-HNY-19158151
3a400444-78c6-4add-be49-4f2704a77aba	ULR-IH-1441-20431001	LAB-IN-XNK-44080	Stewart Ltd	NABL/TC-5841/2842	Suspended	Assam		RPT-3794-541726	2025-11-27	SMP-HNY-17465567
d2f1bf62-2709-4023-8814-370c2cf47d50	ULR-SH-8401-59089219	LAB-IN-QBV-54013	Davis Inc	NABL/TC-0384/6162	Expired	Punjab		RPT-2333-913714	2026-03-08	SMP-HNY-10331732
f976e23a-5f9c-4fa1-81e6-37b3b7efbfd9	ULR-QX-6842-94235120	LAB-IN-LYM-69430	Williams, Deleon and Robinson	NABL/TC-9235/7144	Active	Kerala		RPT-2222-913853	2024-02-21	SMP-HNY-51812298
e315483a-a885-4b33-bff1-328eca0fcf44	ULR-VU-8407-21647017	LAB-IN-COB-87589	Kennedy-Gonzalez	NABL/TC-1585/0213	Provisional	Assam		RPT-4687-895222	2024-03-17	SMP-HNY-61204336
2dfaacf7-6f51-4ee5-84d8-c5d44fe3a504	ULR-UH-1656-48312586	LAB-IN-SKP-73346	Oneill, Green and Thomas	NABL/TC-6035/0353	Expired	Kerala		RPT-3433-080891	2022-05-14	SMP-HNY-62944735
160eebbd-d2bf-48ea-850b-148994a9b1ac	ULR-BL-7636-58506979	LAB-IN-UUJ-53658	Mclaughlin Ltd	NABL/TC-6743/5647	Active	Tripura		RPT-0451-662678	2023-04-16	SMP-HNY-86107287
ff9a90f2-923c-4bbb-aca5-8f734df82894	ULR-AL-5504-91062646	LAB-IN-MMS-55031	Wilson-Hernandez	NABL/TC-0825/3698	Suspended	Telangana		RPT-8272-061078	2026-02-13	SMP-HNY-82862763
0dcb2de4-a403-46a3-bda0-4a60a24ec641	ULR-QJ-8176-83241475	LAB-IN-TOS-21424	Rodriguez-Lewis	NABL/TC-3809/3713	Active	Ladakh		RPT-8195-526298	2025-03-07	SMP-HNY-82719411
5648f929-91d3-4daf-9c73-b9bc9f2cc3ec	ULR-PM-8505-47474114	LAB-IN-IUT-54020	Ponce Group	NABL/TC-5659/8216	Active	Nagaland		RPT-9795-936845	2023-01-10	SMP-HNY-67706415
5656e027-5e03-4555-8b8c-8e073a90c31b	ULR-HH-5956-97674552	LAB-IN-XNX-00629	Wright Group	NABL/TC-5896/5443	Active	Goa		RPT-1615-608057	2024-06-10	SMP-HNY-84749332
c03961b1-5e0e-46bb-9b78-8aeee42fae7b	ULR-WV-6069-63326470	LAB-IN-JGS-78329	Underwood LLC	NABL/TC-3090/3439	Withdrawn	Manipur		RPT-0189-264926	2025-02-21	SMP-HNY-75540887
582a4bee-fb3f-4050-a82c-93350757b2da	ULR-IV-1254-98486231	LAB-IN-UBV-07936	Shields-Parrish	NABL/TC-6021/5719	Expired	Tamil Nadu		RPT-4383-062288	2022-01-03	SMP-HNY-35890700
efb8eb2e-eeb1-4c9d-80c5-4c46941e7bd8	ULR-ED-2334-33010763	LAB-IN-FLZ-44869	Snyder Inc	NABL/TC-2772/6491	Provisional	Rajasthan		RPT-3806-481715	2024-12-29	SMP-HNY-00763303
27fa8203-44d9-406a-8409-3a91c15dbcb0	ULR-KC-6647-78480794	LAB-IN-NXA-73895	Benson, Tate and Torres	NABL/TC-8372/6003	Suspended	Nagaland		RPT-9372-494687	2023-01-12	SMP-HNY-75362954
6ff7765c-aa99-447f-8bc6-9b2fadedb689	ULR-RF-7387-52528942	LAB-IN-BVF-54759	Whitney-Evans	NABL/TC-7953/8986	Withdrawn	Kerala		RPT-4670-611489	2024-11-09	SMP-HNY-40546232
fefa0ddc-c118-4c58-8275-188aa18b88a3	ULR-GP-2626-30820894	LAB-IN-ZIR-94587	Young-Brown	NABL/TC-2080/6944	Suspended	Delhi		RPT-0418-495373	2022-12-17	SMP-HNY-25900982
acf97759-fe20-4e89-a39a-6b685ec28b6f	ULR-JS-2361-76264150	LAB-IN-SHE-03596	Avery, Robinson and Reynolds	NABL/TC-1468/2241	Withdrawn	Chandigarh		RPT-9309-006333	2026-06-09	SMP-HNY-14458783
28f71fd8-aabc-47bf-a1d7-c9287a839e2e	ULR-VL-2043-22306147	LAB-IN-TEG-41895	Richard PLC	NABL/TC-1016/2502	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-8670-636259	2023-05-26	SMP-HNY-87507591
6efd583c-a73e-48cd-91c7-2cef79c7a3cd	ULR-IB-7447-56587398	LAB-IN-GST-74817	Ramos, Coleman and Nolan	NABL/TC-4792/7860	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-6510-197962	2025-03-27	SMP-HNY-98516581
a551e54c-2af0-4563-a5c5-144bb6318a5d	ULR-EE-7416-30722679	LAB-IN-MZA-05374	Hernandez Ltd	NABL/TC-3770/6457	Active	Mizoram		RPT-9455-427940	2024-10-03	SMP-HNY-44138766
9bc69e3d-11cf-4d1b-9ca3-5ce6351e0f1f	ULR-FJ-2811-56635816	LAB-IN-PAW-13792	Chapman LLC	NABL/TC-2223/1087	Provisional	Sikkim		RPT-1205-654118	2025-07-26	SMP-HNY-21157667
4a40c906-7341-4a86-b19f-925e51e3db34	ULR-MP-2988-16227291	LAB-IN-CZJ-97342	Ferguson-Young	NABL/TC-0870/6398	Expired	Punjab		RPT-1663-809023	2023-05-26	SMP-HNY-76502821
35dfb08e-de87-484f-9117-db357f2e68ea	ULR-JJ-8081-76633610	LAB-IN-CGP-19437	Flores PLC	NABL/TC-5449/1164	Expired	Karnataka		RPT-2844-069814	2022-05-09	SMP-HNY-56104676
a3b05ef4-5c65-43d9-9583-a9af11b4131f	ULR-WN-4257-62275107	LAB-IN-IJJ-47779	Peterson-Smith	NABL/TC-7336/6021	Suspended	Goa		RPT-6006-082274	2022-03-11	SMP-HNY-33447022
2720ef8d-d29a-49f0-aa4d-23f877296403	ULR-XV-8170-54814921	LAB-IN-ZWO-33440	West-Barton	NABL/TC-9080/5339	Provisional	Tripura		RPT-5472-058429	2023-06-09	SMP-HNY-23728144
16bf5484-6904-482e-a1f3-c0eceade2470	ULR-IP-6147-01745768	LAB-IN-WUW-86592	Allen, Clark and Rowe	NABL/TC-5442/1993	Active	Chhattisgarh		RPT-5092-878288	2022-08-07	SMP-HNY-84490928
34978d15-50b3-4e67-8bb6-6abe883776f7	ULR-TO-5026-72470804	LAB-IN-ZDW-67765	Russell Group	NABL/TC-0387/9948	Expired	Tamil Nadu		RPT-9670-518697	2023-12-27	SMP-HNY-66096727
7e3f5c20-ebc1-4d7d-80cc-63aa031a2fba	ULR-MH-0424-15205406	LAB-IN-IFT-07678	Warner LLC	NABL/TC-2756/3411	Active	Goa		RPT-3073-766134	2023-02-09	SMP-HNY-39590159
026c58f5-b90d-42f7-95d3-0b18679251f0	ULR-RJ-6841-51148441	LAB-IN-LXA-86762	Wade Ltd	NABL/TC-0998/5313	Active	Haryana		RPT-6095-757895	2025-03-24	SMP-HNY-05027096
98534b0a-7811-49c2-9b4a-ce4743b4b53b	ULR-RX-4638-93866861	LAB-IN-INH-85398	Walker-Lutz	NABL/TC-6169/5287	Active	Lakshadweep		RPT-4933-283468	2022-08-18	SMP-HNY-98649607
bead0803-366b-4da6-85e3-0371d55209a7	ULR-RA-0798-71177286	LAB-IN-HTU-34398	Wong and Sons	NABL/TC-6370/6164	Withdrawn	Chandigarh		RPT-1516-929202	2025-05-26	SMP-HNY-49069046
3d336f65-0d06-4f2a-97b0-2324b10bf77d	ULR-LC-5804-24222168	LAB-IN-WKQ-78516	Weber-Combs	NABL/TC-4327/8917	Active	Kerala		RPT-8727-750294	2021-08-29	SMP-HNY-82882386
56be0781-466f-42b5-ab81-32e559df9947	ULR-WZ-1593-33323461	LAB-IN-ZZQ-94153	Garcia, Daniels and George	NABL/TC-8152/0731	Active	West Bengal		RPT-4014-290646	2026-03-29	SMP-HNY-42688347
667be31d-f32f-4a8a-9584-66b1a55370ec	ULR-HM-9179-80261199	LAB-IN-CEM-52112	Gonzalez, Lambert and Graham	NABL/TC-6889/3560	Active	Telangana		RPT-7119-685403	2025-02-09	SMP-HNY-43847905
6d7f1db2-1568-4b17-b25f-61b6eb06ae4b	ULR-VM-8133-77454323	LAB-IN-BRS-78707	Meyers, Williams and Hammond	NABL/TC-3206/7053	Provisional	Karnataka		RPT-5067-036081	2023-09-04	SMP-HNY-71725096
caf1f091-d0c5-4f91-ade2-7e0294a2ecbd	ULR-BF-3056-46387586	LAB-IN-TKK-97715	Gonzalez, Mccarthy and Kim	NABL/TC-4601/9781	Active	Gujarat		RPT-8894-552959	2022-03-12	SMP-HNY-08925033
116be46e-2342-4eca-b363-5214173c2f42	ULR-QR-7592-34249614	LAB-IN-UFP-09934	Ellis-Smith	NABL/TC-0540/2003	Withdrawn	Kerala		RPT-6344-429632	2024-12-14	SMP-HNY-52217992
723b3fba-2c6f-4216-804d-6f2130d3a6ab	ULR-RW-7305-62534853	LAB-IN-LYX-50975	Flores LLC	NABL/TC-4731/9557	Active	Madhya Pradesh		RPT-6100-405424	2025-11-03	SMP-HNY-00589674
cec38a34-748a-48c4-9545-d46c53befedc	ULR-YA-2781-24650473	LAB-IN-YON-00510	Padilla, Hinton and Macias	NABL/TC-0648/8534	Suspended	Arunachal Pradesh		RPT-9705-859580	2024-09-03	SMP-HNY-24074680
4704e9f6-903c-47d3-b48e-34ffc27fbd9d	ULR-US-2380-51245964	LAB-IN-PIA-88495	Thompson and Sons	NABL/TC-6875/6301	Provisional	Arunachal Pradesh		RPT-5359-555475	2026-07-04	SMP-HNY-43215363
24d6f989-99d6-46c7-a1a7-40718d023509	ULR-WR-1358-97204168	LAB-IN-JII-13448	Conley-Reed	NABL/TC-6173/4167	Suspended	Assam		RPT-7612-849771	2024-07-12	SMP-HNY-46491496
8c83e739-dda4-4f46-bef9-b4c33faa91c6	ULR-JW-2160-52153842	LAB-IN-TXO-58857	Johnson and Sons	NABL/TC-9848/3923	Provisional	Ladakh		RPT-9227-969800	2023-01-31	SMP-HNY-51464614
10568a4e-aa5b-4407-91a5-74093e936b6b	ULR-EZ-4464-32460532	LAB-IN-CVR-12574	Gibson, Underwood and Huber	NABL/TC-1701/2380	Expired	Chhattisgarh		RPT-5687-949056	2023-03-10	SMP-HNY-30869301
5bb38b05-ac9a-4f00-b909-b1c0878a3a44	ULR-YG-4786-55875100	LAB-IN-ZBE-11852	Manning, Martin and Gross	NABL/TC-2192/3893	Provisional	Himachal Pradesh		RPT-4499-260773	2023-08-11	SMP-HNY-23996147
af1355b6-5a64-4650-907e-8f33a8a13a36	ULR-WX-7677-92768561	LAB-IN-QDO-28744	Barker, Todd and Patel	NABL/TC-0451/3393	Provisional	Uttarakhand		RPT-6997-788386	2026-06-28	SMP-HNY-27208091
07474d60-be09-41e7-a49f-a816a0f9c66e	ULR-XF-4605-51048795	LAB-IN-HFP-41630	Hughes PLC	NABL/TC-2669/7736	Withdrawn	Delhi		RPT-7565-144199	2025-02-25	SMP-HNY-65475618
5540394c-0213-432b-a63f-2e5d6debfc68	ULR-PN-6957-36467094	LAB-IN-FQQ-39911	Hill-Wilson	NABL/TC-1864/8365	Active	West Bengal		RPT-8285-368079	2023-08-05	SMP-HNY-73919789
c61f84c7-769d-41ff-85e7-9518998c0e18	ULR-XY-3926-80887498	LAB-IN-IGK-25761	Andrews, Cannon and Saunders	NABL/TC-8602/9743	Withdrawn	Telangana		RPT-0537-900642	2021-12-01	SMP-HNY-74604572
5031de4d-5134-4274-9f05-ccd014d7b010	ULR-GG-5385-03799010	LAB-IN-WVL-95430	Nelson and Sons	NABL/TC-1626/3829	Active	Nagaland		RPT-6438-141632	2023-10-24	SMP-HNY-38935687
c4ed2017-bdc5-473f-9fc2-178bc99dcc4b	ULR-JE-2414-46938051	LAB-IN-OJG-16286	Morales, Johnson and Fuller	NABL/TC-2926/3322	Suspended	Sikkim		RPT-0860-767733	2023-06-24	SMP-HNY-78186912
e38f813a-d524-4dd0-81e9-f0b33b0658b9	ULR-QV-6737-16667430	LAB-IN-USX-11272	Rodriguez and Sons	NABL/TC-0452/1918	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-1219-296286	2023-08-07	SMP-HNY-44322379
5a49b113-458b-4933-bd76-442a1fbd8660	ULR-YZ-2832-88461999	LAB-IN-QFK-13279	Willis-Montoya	NABL/TC-8765/6891	Suspended	Meghalaya		RPT-1296-621372	2024-09-12	SMP-HNY-19396524
59d2c1e8-3353-4a99-9768-a9e829ae60f3	ULR-PN-8186-91335027	LAB-IN-ZVM-30376	Anderson and Sons	NABL/TC-8251/8227	Suspended	Odisha		RPT-3408-271391	2022-12-21	SMP-HNY-60750063
4d565eec-3294-49ca-b217-ce5dca1cadc2	ULR-GJ-1818-31186080	LAB-IN-GXR-52524	Dominguez-Green	NABL/TC-5221/5419	Expired	Goa		RPT-6039-354560	2022-11-26	SMP-HNY-36179860
2fe5ebf9-5f65-489f-a76e-48fdaa7f2e6e	ULR-DZ-8307-90197241	LAB-IN-LDK-05344	Richardson, Jones and Perry	NABL/TC-8216/8436	Withdrawn	Rajasthan		RPT-3449-823582	2023-04-17	SMP-HNY-72263439
6e5edeb8-e1b1-45d4-9ca4-8092e3c35d58	ULR-MC-5594-82953901	LAB-IN-LBR-73096	Lewis PLC	NABL/TC-6828/4979	Withdrawn	Bihar		RPT-6978-090718	2024-06-15	SMP-HNY-01994409
0edc19eb-825d-4d7e-a1b5-0d70f7bdf57e	ULR-WV-1620-04353368	LAB-IN-MSJ-19702	Mcmillan-Johnson	NABL/TC-4133/1194	Suspended	Rajasthan		RPT-5741-464575	2022-10-27	SMP-HNY-31560429
6f1ffb58-e3f2-4d1c-beb9-40f51c9a43ae	ULR-SI-3702-76602714	LAB-IN-PUC-01362	Guerrero-Garcia	NABL/TC-9661/4535	Expired	Lakshadweep		RPT-2114-397402	2021-11-08	SMP-HNY-55019554
4e1c9762-f416-48b6-a49c-6feb37f96a58	ULR-UD-8163-83658009	LAB-IN-KZD-47260	Wade-Williams	NABL/TC-6707/5485	Provisional	Jammu and Kashmir		RPT-4460-558572	2024-03-08	SMP-HNY-56936840
14279b21-e334-409f-a70b-477c06607316	ULR-PK-6843-51924638	LAB-IN-LAL-97008	Parker, Adams and Norris	NABL/TC-7234/2369	Suspended	Himachal Pradesh		RPT-8334-803605	2024-07-07	SMP-HNY-98894132
49d65f94-1811-4323-a95b-6f425ae39e2d	ULR-GN-5531-87930797	LAB-IN-KAO-14455	Lopez, Hayes and Sexton	NABL/TC-9671/7720	Active	Tripura		RPT-8123-972255	2024-07-23	SMP-HNY-39263899
57c1cc09-97ed-4263-80a5-25c9a205ec22	ULR-ZX-7277-80375309	LAB-IN-BTH-59820	Bell, White and Jones	NABL/TC-4765/5566	Suspended	Kerala		RPT-7935-308918	2022-07-26	SMP-HNY-76776654
deb2a8ba-5bc0-47c7-945e-edbe3abc44b4	ULR-AZ-7398-14658203	LAB-IN-GQX-74406	Woods, Gillespie and Campbell	NABL/TC-3461/9394	Provisional	Arunachal Pradesh		RPT-7159-614920	2022-03-22	SMP-HNY-86895076
8ab7174f-ca0e-41e9-9c67-9ffe658385cb	ULR-TL-9186-52200173	LAB-IN-BXR-94844	Phillips, Wiley and Burnett	NABL/TC-3670/4749	Provisional	Haryana		RPT-7948-216129	2021-10-06	SMP-HNY-73884280
80df5b49-1a9f-48f5-a7d1-599e0cab0d82	ULR-HY-2447-14458959	LAB-IN-LJR-70721	Davis LLC	NABL/TC-0348/3320	Active	Goa		RPT-1101-316600	2023-12-11	SMP-HNY-39948935
5e476e75-7319-43f9-b265-a3bf2dba0fc4	ULR-MY-2166-23561638	LAB-IN-GWJ-43774	Johnson, Harmon and Woods	NABL/TC-5263/0034	Provisional	Karnataka		RPT-0784-175381	2025-07-25	SMP-HNY-96334782
59fc9471-2e1b-4416-a891-5360e42bdee4	ULR-MU-6958-85234390	LAB-IN-LKK-35707	Walker PLC	NABL/TC-3038/5981	Provisional	Madhya Pradesh		RPT-3320-278626	2024-01-03	SMP-HNY-84801760
0bbb3536-20d2-4fca-bee0-e1d0eb63b65a	ULR-KV-3897-43766057	LAB-IN-ZXT-86230	Trevino Group	NABL/TC-8293/0041	Provisional	Arunachal Pradesh		RPT-5956-522730	2025-02-08	SMP-HNY-57436914
c100e9af-a206-4481-931e-341f157351ab	ULR-FC-4282-62668160	LAB-IN-AHI-82893	Trujillo-Larson	NABL/TC-4664/2015	Active	Haryana		RPT-9983-146414	2025-06-27	SMP-HNY-34913940
56642094-f965-430a-9d1e-8ab233667deb	ULR-AZ-4032-30343209	LAB-IN-UKT-00297	Thomas-Hurley	NABL/TC-8534/2894	Active	West Bengal		RPT-1704-734932	2024-12-10	SMP-HNY-77293138
ee8292de-9cb2-4050-85b6-b00ed5b81923	ULR-SA-9568-89314609	LAB-IN-HZM-65333	Franco, Turner and Edwards	NABL/TC-4434/9069	Withdrawn	Tamil Nadu		RPT-0455-910895	2025-10-06	SMP-HNY-10938930
6ae426a6-859f-4047-b421-4f76b9c39a50	ULR-KF-3401-29775784	LAB-IN-QBJ-50823	Smith, Beard and Stewart	NABL/TC-5896/1056	Active	Jharkhand		RPT-1810-739185	2025-09-18	SMP-HNY-07001235
fc69e370-9b5c-4270-b320-19b0bb9710ff	ULR-SD-5980-54436747	LAB-IN-DPH-66356	Dean-Mitchell	NABL/TC-9124/1592	Active	Jammu and Kashmir		RPT-2093-746397	2023-04-24	SMP-HNY-85607811
072d3b39-a683-4696-bb19-66e1cc3f52b2	ULR-HO-9173-08962789	LAB-IN-ZUZ-88184	Zamora-Cooper	NABL/TC-5641/1221	Withdrawn	Assam		RPT-8549-979848	2025-03-13	SMP-HNY-28279749
3f8e8b40-6c70-4344-afc4-e9da5d86481c	ULR-ND-7784-66321993	LAB-IN-RGB-85944	Patterson-Crane	NABL/TC-1219/4109	Active	Haryana		RPT-1331-986175	2025-01-21	SMP-HNY-72702864
70aa5df6-c0a2-4ab2-8dc6-415f8948f913	ULR-YT-7420-01842224	LAB-IN-WHK-11135	Schmidt, Diaz and Higgins	NABL/TC-6568/9624	Active	Mizoram		RPT-2311-475186	2025-10-15	SMP-HNY-30810122
8a45ab29-fe4f-479b-9d3d-df4b544443de	ULR-LN-5784-86990905	LAB-IN-OWD-26986	Rojas Group	NABL/TC-6238/6075	Provisional	Chhattisgarh		RPT-4816-512417	2024-09-17	SMP-HNY-14961133
3f181999-53eb-4cce-877f-d16fac4e73f2	ULR-SO-4383-17897507	LAB-IN-LTX-21547	Curry, Weaver and Griffin	NABL/TC-0931/5765	Active	Goa		RPT-9528-033584	2025-09-04	SMP-HNY-46300566
3af3250d-97fe-4a38-9d60-485845b801c9	ULR-XQ-5603-45189508	LAB-IN-KJD-07587	Wright, Woods and Jackson	NABL/TC-3711/8791	Suspended	Ladakh		RPT-7839-954014	2022-08-02	SMP-HNY-83328412
2158704b-cc69-4e60-a2d4-a066a25c114e	ULR-VR-7926-82176396	LAB-IN-ILD-07068	Mitchell-Johnson	NABL/TC-9464/6804	Withdrawn	Ladakh		RPT-9898-763930	2025-02-25	SMP-HNY-31193998
1f55149b-6ea2-4010-91ae-71611fa204e6	ULR-MW-9321-44111280	LAB-IN-QNF-04720	King Ltd	NABL/TC-5006/7942	Expired	Delhi		RPT-2866-865573	2024-01-05	SMP-HNY-09688985
90ba89a7-0c00-44a8-a78b-ea92a0fb1220	ULR-OV-4613-84799107	LAB-IN-JMQ-53016	Sanders LLC	NABL/TC-2684/2945	Withdrawn	Tamil Nadu		RPT-8913-774820	2023-05-10	SMP-HNY-82557365
6bad9070-614d-46e8-a74f-1501ad27f9b2	ULR-DW-8791-85701720	LAB-IN-RJR-41364	Walker, Brown and Miller	NABL/TC-2385/8754	Withdrawn	Lakshadweep		RPT-0088-173762	2025-05-16	SMP-HNY-12274346
2fabe80c-045c-4b2a-a012-3c07511bde9c	ULR-JF-8693-13491428	LAB-IN-LTH-28483	Williams-Anderson	NABL/TC-8679/5681	Withdrawn	Tamil Nadu		RPT-2166-141966	2022-12-27	SMP-HNY-09408748
17c647ab-d0aa-4dab-91cc-17a47bc74b73	ULR-DN-1360-12034398	LAB-IN-UTC-52870	Edwards, Johnson and Newton	NABL/TC-8575/5613	Withdrawn	Chhattisgarh		RPT-0832-629390	2025-03-23	SMP-HNY-80579238
1fa1abbc-3676-4d35-9237-aa527afc50d1	ULR-RZ-8731-95403129	LAB-IN-DPN-71907	Summers-Hernandez	NABL/TC-7659/7643	Active	Gujarat		RPT-7503-628857	2026-07-14	SMP-HNY-69558650
ff09c893-25c1-4bab-93f0-d51f9ad78672	ULR-UW-5143-67782146	LAB-IN-PLH-93032	Adams-Smith	NABL/TC-7435/0466	Withdrawn	Uttar Pradesh		RPT-5284-699328	2026-05-01	SMP-HNY-02925952
d72c53af-5ad2-479f-82d0-a5e28c6a456d	ULR-CZ-1790-00352907	LAB-IN-CPL-68444	Campbell, Gutierrez and Blankenship	NABL/TC-5867/9150	Active	Delhi		RPT-9158-572057	2022-05-15	SMP-HNY-98823174
65b53040-639b-450a-9595-b50a76f4c0fb	ULR-EL-1922-28658135	LAB-IN-AKK-61584	Hodge, Griffith and Chung	NABL/TC-4690/0194	Withdrawn	Andaman and Nicobar Islands		RPT-1660-968690	2025-06-11	SMP-HNY-53809072
41d6288b-533f-4d02-ba55-15d0bf5a96a3	ULR-EW-9458-45473442	LAB-IN-YNP-24327	Miller PLC	NABL/TC-6632/9821	Withdrawn	Assam		RPT-0222-805587	2024-01-27	SMP-HNY-65874511
b9ca5703-1421-4bb7-ac02-73b7e0a3a51c	ULR-RU-4481-51020519	LAB-IN-TKO-41596	Hill, Phelps and Bird	NABL/TC-4491/4623	Provisional	Kerala		RPT-0814-575415	2024-06-13	SMP-HNY-47425410
3cd016f0-deb0-411c-88e9-9227300ca72a	ULR-MH-3650-60429844	LAB-IN-AGO-09235	Williams-Perez	NABL/TC-5419/6423	Withdrawn	Andhra Pradesh		RPT-9119-033841	2023-07-05	SMP-HNY-53634522
e91985ca-0fe0-43ad-a3a0-b1dc5a1caf96	ULR-FI-7014-83804945	LAB-IN-NUW-83990	Moore, Flynn and Rodriguez	NABL/TC-0221/0242	Provisional	Manipur		RPT-9058-146153	2025-09-29	SMP-HNY-20988074
e2897da1-1c36-4346-a346-e5c3e8ec536f	ULR-VH-1321-80870621	LAB-IN-BZW-06810	Thompson-Murphy	NABL/TC-4804/9936	Provisional	Arunachal Pradesh		RPT-0989-473376	2023-03-16	SMP-HNY-57376559
8d175605-1c4e-4fc8-be41-d0acbab35c8f	ULR-YS-3519-96340164	LAB-IN-INQ-67172	Hughes, Martinez and Thompson	NABL/TC-2696/6418	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-2688-087432	2021-12-27	SMP-HNY-17577900
e7397a34-6751-459b-ad06-4d9b7e50a76c	ULR-KH-2976-41848943	LAB-IN-TPT-09155	Moss Inc	NABL/TC-3910/6211	Expired	Telangana		RPT-9713-449430	2023-07-23	SMP-HNY-38032352
c7e4e2e4-33ac-4236-867f-9dad29ce515f	ULR-XC-7122-77001862	LAB-IN-EAY-90939	Rodriguez PLC	NABL/TC-9495/1131	Provisional	Karnataka		RPT-3198-897595	2025-03-26	SMP-HNY-25475752
f66061f9-6a83-479b-ba65-ff04997903f8	ULR-DI-0028-33005057	LAB-IN-GYX-91724	Smith-Roberson	NABL/TC-5333/1723	Provisional	Punjab		RPT-7618-240710	2022-02-25	SMP-HNY-23211239
47512cc5-e833-4a4b-b4ca-02fd3cf07df4	ULR-NF-2208-23387995	LAB-IN-KUM-58122	Haynes-Marshall	NABL/TC-7031/9779	Provisional	Telangana		RPT-2382-958949	2024-09-22	SMP-HNY-22398783
90d1841e-86cf-4d89-bffd-c98d9c2697e5	ULR-SW-8238-26034702	LAB-IN-HYS-11005	Matthews-Williams	NABL/TC-3453/0262	Active	Uttarakhand		RPT-1156-389214	2023-01-10	SMP-HNY-79002041
1471e815-e490-4cc6-82f8-bb68682cadb2	ULR-IN-2456-79385540	LAB-IN-HGD-11601	Gomez, Sexton and Tran	NABL/TC-2027/3165	Provisional	Jharkhand		RPT-9235-115511	2023-02-07	SMP-HNY-50663054
f56b3a99-81c3-4aef-8b94-7156b1c3588a	ULR-FY-5340-43787540	LAB-IN-UVA-40649	Park-Davenport	NABL/TC-8676/6066	Active	Uttar Pradesh		RPT-9905-528730	2025-04-15	SMP-HNY-03649903
0ae50132-3fbe-4e87-baf9-c8c441cadcd7	ULR-RF-8120-81575123	LAB-IN-SBD-37468	Smith Inc	NABL/TC-2057/5245	Suspended	Mizoram		RPT-3934-679130	2024-07-05	SMP-HNY-00790020
6234f62c-714d-48a7-bfae-5c947990f41c	ULR-JW-5138-20277030	LAB-IN-HEX-41981	Cox, Anderson and Sexton	NABL/TC-0085/1539	Withdrawn	Tamil Nadu		RPT-1867-349881	2023-06-26	SMP-HNY-74661875
516eea35-53cf-4000-834c-01215778690d	ULR-LM-3894-79656166	LAB-IN-UHR-95490	Perez-Thomas	NABL/TC-2217/2085	Withdrawn	Puducherry		RPT-2487-207429	2026-01-03	SMP-HNY-52560399
34080335-1243-4819-b4a9-aedad7f867fa	ULR-YY-5309-29548521	LAB-IN-ZOJ-50519	Bridges-Cameron	NABL/TC-1304/4827	Withdrawn	Lakshadweep		RPT-9947-191901	2022-09-20	SMP-HNY-17615501
809dba46-f308-43de-8577-f0d82134665a	ULR-KJ-4821-96196452	LAB-IN-QCT-25644	Mendez and Sons	NABL/TC-3975/2663	Expired	Himachal Pradesh		RPT-0188-087566	2025-12-10	SMP-HNY-16617240
55e43e15-7007-48fd-9ffb-9e3181cbec36	ULR-NJ-6525-51749651	LAB-IN-MQE-05392	Adams, Watkins and Hall	NABL/TC-1510/5069	Suspended	Madhya Pradesh		RPT-2550-561344	2024-08-08	SMP-HNY-14181118
2280ba86-22b0-42bd-951c-61c480f25065	ULR-XS-4391-96588630	LAB-IN-LMQ-85800	Webster and Sons	NABL/TC-7587/5900	Provisional	Tripura		RPT-5048-500705	2023-03-24	SMP-HNY-35930647
bdebe45a-7a5a-403a-854b-174cbf7c7391	ULR-RF-1704-99580848	LAB-IN-KDL-64927	Webb and Sons	NABL/TC-3419/6129	Provisional	Madhya Pradesh		RPT-5334-358305	2024-01-09	SMP-HNY-33576783
54599034-6baf-4797-b4a8-4da9ad285b45	ULR-NS-7631-71485682	LAB-IN-ASM-98385	Payne-Henderson	NABL/TC-7521/9734	Active	Maharashtra		RPT-2429-318892	2024-07-20	SMP-HNY-65086545
66e7c14d-c5d2-4bd9-bfc6-7646ea4acd76	ULR-WJ-4909-51541698	LAB-IN-GCT-73874	Rodriguez-Ramos	NABL/TC-9624/8183	Provisional	Tripura		RPT-4015-745464	2022-05-20	SMP-HNY-39817415
b3b9aa0d-9aa9-46a9-8746-ccae82bfae0d	ULR-PM-1692-16711730	LAB-IN-ATC-12825	Cunningham, Garcia and Howard	NABL/TC-6223/4057	Provisional	West Bengal		RPT-5128-105726	2025-07-02	SMP-HNY-36353008
08d12871-d6a9-4ccc-b31f-5637301f8b29	ULR-CX-0825-61128566	LAB-IN-VAW-14858	Graham PLC	NABL/TC-4073/0787	Provisional	Gujarat		RPT-9995-696185	2024-08-14	SMP-HNY-44205590
3eaad461-d9a5-4a29-875e-292b0b111c57	ULR-GQ-0325-26203128	LAB-IN-NSF-89536	Vega-Willis	NABL/TC-6210/0980	Active	Madhya Pradesh		RPT-5174-235095	2022-07-12	SMP-HNY-80000204
cff657dd-b254-4211-b3d7-bc95d388e204	ULR-LL-1234-95770626	LAB-IN-LHD-96403	Eaton, Wong and Graham	NABL/TC-1078/0596	Withdrawn	Uttar Pradesh		RPT-6931-391523	2025-09-24	SMP-HNY-15726831
8b3deebf-8079-4498-b03c-0342847ba766	ULR-HR-7474-59016451	LAB-IN-AUM-47484	Evans-Ayers	NABL/TC-2147/1094	Provisional	Sikkim		RPT-6260-963179	2026-05-28	SMP-HNY-61592198
4d616a20-78ed-467e-98dd-a32de6a0976c	ULR-IE-3694-57882854	LAB-IN-TPC-31171	Scott-Mills	NABL/TC-2880/7324	Suspended	Sikkim		RPT-6539-172653	2022-01-24	SMP-HNY-40974752
23f95f22-d67c-43a2-9ccc-8bd60e5d1b0c	ULR-GH-4289-86394903	LAB-IN-RIE-08513	Cowan, Jackson and Mcdowell	NABL/TC-6752/6658	Suspended	Andhra Pradesh		RPT-8987-827019	2023-04-02	SMP-HNY-72389752
eccc089b-29a1-48a8-ace0-d4ffcaa077de	ULR-RD-7334-70962463	LAB-IN-UQO-08064	Park and Sons	NABL/TC-3462/4209	Active	Mizoram		RPT-6089-660403	2026-06-28	SMP-HNY-19499946
f89e2cf2-77b7-40a3-b9c5-688436f93add	ULR-AL-1165-54904082	LAB-IN-VFQ-28646	Aguilar Group	NABL/TC-0000/6940	Expired	Gujarat		RPT-3873-591226	2025-08-17	SMP-HNY-88116470
d168cd52-dbb2-46d1-b014-ecb5e7b365bf	ULR-MJ-5432-72397565	LAB-IN-WHD-39249	Green, Wilson and Price	NABL/TC-0066/6516	Expired	Andaman and Nicobar Islands		RPT-4980-794925	2025-12-18	SMP-HNY-21930113
bd95d3d6-f88f-4bcb-a3c4-fbec462ae264	ULR-XI-9738-26185357	LAB-IN-JYJ-21042	Carpenter, Spears and Watson	NABL/TC-2174/4152	Active	Uttar Pradesh		RPT-7912-826396	2024-10-08	SMP-HNY-56915405
2d9a6951-25b4-456a-84fa-1e888449a91c	ULR-ME-0771-61631384	LAB-IN-NPT-35008	Pineda-Chavez	NABL/TC-3684/5163	Withdrawn	Ladakh		RPT-7390-681653	2024-05-10	SMP-HNY-11527835
21ab6005-c64e-4839-bbd3-12ec9ac833fb	ULR-BG-6991-40305705	LAB-IN-JZT-76397	Cook-Singleton	NABL/TC-4671/4726	Active	Karnataka		RPT-6564-066743	2026-04-15	SMP-HNY-39745188
dda58a42-f041-4b8c-8439-9f4c4f56aff9	ULR-KE-7009-58213130	LAB-IN-ELT-62724	Murillo, Hanson and Jones	NABL/TC-9212/8607	Expired	Tamil Nadu		RPT-5793-365293	2024-04-13	SMP-HNY-60233401
fd7a6016-ed6e-4850-a125-85c7f60854e8	ULR-VO-4145-78367378	LAB-IN-UQR-24993	Vance-Gates	NABL/TC-1706/8713	Withdrawn	Puducherry		RPT-6060-006588	2021-11-15	SMP-HNY-31637584
fca01b51-3b4c-4347-a338-2ca561af3ae8	ULR-YX-6712-82746944	LAB-IN-QHU-96028	Petersen, Taylor and Hardy	NABL/TC-9926/7217	Suspended	Mizoram		RPT-6819-166525	2025-01-23	SMP-HNY-73369338
56f68cd7-82f9-4f06-b447-9b2ba95930b5	ULR-HO-7469-40676303	LAB-IN-DLU-96131	Lopez-Camacho	NABL/TC-0256/5685	Expired	Gujarat		RPT-6893-152465	2025-07-18	SMP-HNY-31238619
5c1453d6-6746-4d7d-ab6e-0189a0d3cf79	ULR-VG-3020-46583490	LAB-IN-GGA-51491	Clay Ltd	NABL/TC-8474/9235	Suspended	Karnataka		RPT-4549-198649	2025-04-16	SMP-HNY-52729789
32affeb6-5801-4824-b8d0-c7ca04152a60	ULR-XM-3201-26923623	LAB-IN-DZS-32168	Garrett PLC	NABL/TC-0145/6799	Active	Himachal Pradesh		RPT-1797-848368	2025-06-29	SMP-HNY-72380464
df90343f-3582-4aa5-8753-185ef508970e	ULR-VA-7038-16664457	LAB-IN-ZRY-88578	Collins and Sons	NABL/TC-7026/0716	Expired	Chhattisgarh		RPT-1585-472453	2024-05-28	SMP-HNY-05002269
bd7fab3f-a392-48fe-8174-f3b5006f83fa	ULR-XE-0214-41725693	LAB-IN-LVM-41542	Wilson Ltd	NABL/TC-4268/8607	Provisional	Uttarakhand		RPT-5764-454544	2024-03-08	SMP-HNY-76543392
805d62b8-2432-4e62-84c8-8028a13816ab	ULR-WG-6183-17547860	LAB-IN-HKU-12619	Harris Group	NABL/TC-7063/5142	Expired	Nagaland		RPT-1590-363549	2026-02-17	SMP-HNY-37250194
383e269b-5109-42f1-8b5b-20afdc3ff67d	ULR-YA-0002-05539060	LAB-IN-BSP-94642	Nguyen, Jones and Harvey	NABL/TC-6801/6855	Withdrawn	Manipur		RPT-9713-853910	2023-06-23	SMP-HNY-75066402
c2a9f89d-2f34-442f-adc6-f34378b693ab	ULR-ZC-6069-98289235	LAB-IN-FPQ-16679	Perry LLC	NABL/TC-8306/8800	Active	Ladakh		RPT-8942-059816	2022-05-24	SMP-HNY-72629248
f0445b32-57e2-4328-9c7e-81fe0cf23636	ULR-VM-0239-00905403	LAB-IN-SMP-93510	Valencia, Williams and Barron	NABL/TC-2440/6539	Suspended	Karnataka		RPT-2355-910401	2025-08-17	SMP-HNY-31855663
e373b228-c853-4ebe-ac32-2079c6cd2ff4	ULR-VZ-0911-28909102	LAB-IN-YDD-69174	Odom-Larson	NABL/TC-4005/6486	Active	Rajasthan		RPT-0225-035235	2025-06-08	SMP-HNY-86175012
b4072890-7546-4afb-ba76-7920bd29acf0	ULR-LA-3449-10356811	LAB-IN-VAR-50671	Mendoza-Hernandez	NABL/TC-6591/8520	Expired	Ladakh		RPT-7585-689710	2023-01-21	SMP-HNY-54682291
9cf41778-2d90-46d1-8212-b36dc5435eb9	ULR-TU-9006-43079474	LAB-IN-ZUH-43870	Thornton PLC	NABL/TC-1882/4252	Suspended	Meghalaya		RPT-0733-160023	2024-04-10	SMP-HNY-55857278
f851a11e-3af7-42bc-a6b1-a300c1bc5185	ULR-VN-5932-42462169	LAB-IN-XWP-83816	Johnson-Powell	NABL/TC-5545/3942	Provisional	Andhra Pradesh		RPT-3821-867089	2025-02-13	SMP-HNY-09010144
6ed7a76c-6f8c-4bd1-9cae-f5dcac304de1	ULR-PL-8088-41019142	LAB-IN-HCW-16905	Rivera, Mccormick and Little	NABL/TC-7575/8254	Active	Lakshadweep		RPT-6133-033182	2023-08-04	SMP-HNY-06817547
3e84a9e0-b16a-4aab-a3ac-3aca24e16d50	ULR-RE-5682-32086603	LAB-IN-GNZ-29628	Pollard Group	NABL/TC-2309/7965	Provisional	Manipur		RPT-9758-562842	2022-10-23	SMP-HNY-73962335
f7d2028d-e15a-4472-b887-e048e858135e	ULR-PJ-5198-59048390	LAB-IN-QBW-00705	Morse Inc	NABL/TC-5126/5686	Suspended	Lakshadweep		RPT-0257-588889	2025-09-18	SMP-HNY-10245699
e4137c89-e82b-46c7-9c1c-26ab7693dd1e	ULR-TY-0569-88676694	LAB-IN-OYG-50747	Savage, Conway and Dean	NABL/TC-0026/4241	Provisional	Uttarakhand		RPT-9170-305842	2021-12-01	SMP-HNY-38821555
9f0690b9-a801-4e62-802d-456fe13971c8	ULR-YA-9694-23091555	LAB-IN-IIT-38536	Padilla and Sons	NABL/TC-2312/7794	Expired	Chandigarh		RPT-3658-226689	2022-09-28	SMP-HNY-62986563
166e4094-5132-4bf7-a92e-1fd80491f634	ULR-HM-6155-95981289	LAB-IN-NMM-83335	Harding PLC	NABL/TC-0418/2217	Active	Uttar Pradesh		RPT-1652-554301	2024-07-08	SMP-HNY-49804224
d6274247-15a0-4f9e-b486-7a7545133f3c	ULR-JV-7326-79420204	LAB-IN-CKL-42323	Newman-Gonzales	NABL/TC-9117/7999	Active	Rajasthan		RPT-9842-612599	2024-05-03	SMP-HNY-49191726
fa27dfbb-40c1-4f0b-ad6d-b88cde08039b	ULR-CM-3793-56255775	LAB-IN-MWD-76217	Rogers-White	NABL/TC-1230/5793	Expired	Assam		RPT-6055-741743	2024-01-05	SMP-HNY-50151235
fd1af9e2-7a5e-43ea-a7d6-f4c44b5bf1d1	ULR-LN-0535-84491342	LAB-IN-SYA-41215	Thompson-Bates	NABL/TC-5380/9383	Withdrawn	Arunachal Pradesh		RPT-7064-777182	2021-10-13	SMP-HNY-97981672
55c7e8c7-2800-4351-9ba8-d3b2e54d9702	ULR-RD-9173-03441789	LAB-IN-XGQ-64619	Park PLC	NABL/TC-6655/1392	Active	Manipur		RPT-1242-966657	2022-06-13	SMP-HNY-66807194
08d52fba-9672-40b4-8570-9d40b8767874	ULR-KH-7008-76832698	LAB-IN-BAB-90712	Patel Group	NABL/TC-1949/9513	Expired	Maharashtra		RPT-8355-518445	2025-11-26	SMP-HNY-40748201
ac8fdeb4-e1ae-4e59-b55f-f1c5ab620e8e	ULR-PX-8140-16344017	LAB-IN-QRZ-33215	Gordon Group	NABL/TC-8635/3650	Withdrawn	Meghalaya		RPT-4547-165851	2024-09-09	SMP-HNY-23865977
586c7108-30bc-4320-ab50-099011208230	ULR-OS-7776-54436403	LAB-IN-JOA-35823	Roman-Thomas	NABL/TC-9755/9407	Expired	Sikkim		RPT-3674-626147	2024-12-08	SMP-HNY-25673389
bef354d4-e358-4fcc-b8ca-caa1d1a17a2f	ULR-IT-0738-75838450	LAB-IN-RJJ-01471	Bowen, Atkinson and Yang	NABL/TC-6553/2592	Active	Tamil Nadu		RPT-8493-604826	2024-08-15	SMP-HNY-84929180
c104c76e-8603-434c-9861-4a200ca8b821	ULR-OZ-7859-95954959	LAB-IN-MFP-85748	Watkins Group	NABL/TC-1446/9163	Expired	Uttar Pradesh		RPT-1294-283340	2024-08-21	SMP-HNY-34640073
51de3e12-02bd-4b52-a4ba-de5796c524ad	ULR-WA-7962-98349868	LAB-IN-OEI-00470	Callahan-Bowers	NABL/TC-7553/0594	Active	Maharashtra		RPT-4100-534770	2024-03-30	SMP-HNY-62210293
fafab7e0-6135-4422-8207-58bbe731ddf4	ULR-VR-9336-50817606	LAB-IN-KIO-05601	Pierce-Solis	NABL/TC-5664/5669	Expired	Chhattisgarh		RPT-1758-784381	2025-01-16	SMP-HNY-91956832
354f35ec-ef06-4445-b15a-161b69d5555b	ULR-ZD-9046-09708582	LAB-IN-OKE-50960	Miller Group	NABL/TC-1788/0104	Suspended	Arunachal Pradesh		RPT-9609-998792	2022-08-12	SMP-HNY-56868466
bf38704f-e7fc-425f-954a-eb43cfbfa326	ULR-SD-7190-17516914	LAB-IN-LDD-84669	Morrison, Brooks and Howard	NABL/TC-7225/3075	Suspended	Mizoram		RPT-5988-800543	2025-03-07	SMP-HNY-00636858
591a72c0-9126-4dab-adc3-7eb2c92860cb	ULR-AT-2103-07809049	LAB-IN-UQH-26345	Hoffman PLC	NABL/TC-6930/0521	Expired	Gujarat		RPT-7632-282207	2023-07-08	SMP-HNY-74876884
0b1b9b6b-a0f6-4619-9f4c-5c954202871a	ULR-VN-9837-30705032	LAB-IN-DGT-95632	Frazier and Sons	NABL/TC-3162/8879	Provisional	Delhi		RPT-2100-569601	2025-07-24	SMP-HNY-46589247
94f61493-5f6a-457a-ac53-0de7c5088210	ULR-ZG-8541-38067774	LAB-IN-ZXP-11072	Horn-Webb	NABL/TC-9831/1749	Withdrawn	Karnataka		RPT-3609-127498	2024-08-03	SMP-HNY-69538844
eb0e4093-cc46-4947-851a-3880ca7b6221	ULR-JF-0983-86557816	LAB-IN-ZEL-64319	Anderson, Waller and Clark	NABL/TC-1140/0884	Provisional	Arunachal Pradesh		RPT-0752-890930	2022-03-27	SMP-HNY-74680980
fab25440-8644-4c14-9c6e-ca6e8560d94f	ULR-DN-3344-83307278	LAB-IN-MOP-62878	Caldwell-Roy	NABL/TC-6771/8430	Withdrawn	Delhi		RPT-3075-497725	2026-01-04	SMP-HNY-87332517
e505b315-840f-44cc-aa78-045e26503ef8	ULR-YS-9353-77095725	LAB-IN-GVL-58844	Keller Inc	NABL/TC-5622/1917	Expired	Goa		RPT-2828-296299	2025-06-14	SMP-HNY-93715499
6bee2fd6-cee5-4669-b357-a031fb178c3b	ULR-VM-6190-91331581	LAB-IN-MMK-09439	Garcia, Brown and Cunningham	NABL/TC-1333/7661	Provisional	Bihar		RPT-8118-426560	2025-12-12	SMP-HNY-03209065
0a572c1c-7075-4b7b-8511-7cb62d94c432	ULR-WV-4258-03137357	LAB-IN-DHE-72957	Boyd, Poole and Warren	NABL/TC-1433/0171	Expired	Puducherry		RPT-1939-178976	2026-02-07	SMP-HNY-56961882
f597d76a-192a-40c8-9178-ea0eba012d1b	ULR-KS-6116-72433367	LAB-IN-DRF-01467	Wood PLC	NABL/TC-7916/6310	Withdrawn	Tamil Nadu		RPT-2263-830015	2024-01-06	SMP-HNY-81617216
a1736284-f3d4-4945-9fac-3a0fcc60c781	ULR-HQ-8223-03234393	LAB-IN-ZID-97311	Rodriguez PLC	NABL/TC-5361/7639	Withdrawn	Karnataka		RPT-6272-062083	2022-09-17	SMP-HNY-09055908
44a7ccb6-7b67-4b84-9311-71592420fd7a	ULR-MV-9195-63917102	LAB-IN-MCN-01853	Hoover, Gill and Mcintyre	NABL/TC-0416/1867	Active	Karnataka		RPT-2806-453699	2022-08-23	SMP-HNY-26308621
fe245dde-71a4-4d14-b0eb-d9f8bd0b8305	ULR-WB-1127-53151776	LAB-IN-VSI-70880	Martin, Woods and Hendricks	NABL/TC-0975/7195	Expired	Ladakh		RPT-0271-705736	2025-03-15	SMP-HNY-38393084
095dea2f-edad-4909-825e-659303a3ad83	ULR-OG-7290-96300381	LAB-IN-WZS-87392	Marquez Inc	NABL/TC-1514/4685	Active	Madhya Pradesh		RPT-8521-883856	2022-09-26	SMP-HNY-24984643
63f9368f-2d18-4797-a81d-319bce949d2d	ULR-ZJ-7748-91602107	LAB-IN-AAQ-21989	Robertson, Rios and Johnson	NABL/TC-7236/4942	Expired	Uttar Pradesh		RPT-4727-904627	2024-02-10	SMP-HNY-89737607
c2953450-685f-479a-9a30-e35e345a09ca	ULR-QK-4033-67850916	LAB-IN-ZWY-49027	Phelps Ltd	NABL/TC-7701/6092	Active	Bihar		RPT-0557-470756	2024-03-12	SMP-HNY-45104641
f7a6cf5a-0d17-4de1-a408-7678fb0dd148	ULR-LC-2632-21679520	LAB-IN-GYR-95339	Anderson, Hammond and Smith	NABL/TC-7501/2432	Withdrawn	Arunachal Pradesh		RPT-1517-078184	2026-07-23	SMP-HNY-82701338
481eb4de-1caa-430d-b23a-f46388bb4796	ULR-SW-4110-59899755	LAB-IN-AAU-91491	Jones Ltd	NABL/TC-2491/6547	Withdrawn	Sikkim		RPT-1386-932497	2025-05-21	SMP-HNY-89471767
4d8e712a-558a-472c-9815-ae7c3458d5eb	ULR-QD-8773-91906365	LAB-IN-VXY-53638	Lara, Herrera and Rodriguez	NABL/TC-6440/2558	Withdrawn	Karnataka		RPT-4312-882727	2024-06-08	SMP-HNY-01426790
982e181c-ad4c-4efb-86ff-8e7a9fdab0de	ULR-AJ-6843-48375754	LAB-IN-OUM-83693	Taylor, Ruiz and Taylor	NABL/TC-0176/7855	Withdrawn	Kerala		RPT-3595-668712	2025-02-02	SMP-HNY-95101214
a2cc559e-56c9-4ff8-9872-11f1be306121	ULR-AJ-1972-44467236	LAB-IN-UDE-78167	Bradley, Anderson and Johnson	NABL/TC-3670/2134	Active	Nagaland		RPT-6258-879864	2022-01-02	SMP-HNY-17819251
8b466e20-4665-4c7d-b34f-bb4cb3122ae0	ULR-IR-3869-21587120	LAB-IN-OXY-60099	Fuentes Inc	NABL/TC-3761/0418	Suspended	Chandigarh		RPT-4203-823122	2022-10-15	SMP-HNY-04825504
d9a10c10-3695-4420-b9b5-31e21c4f2266	ULR-RR-9244-03474920	LAB-IN-ZWW-80644	Walker, Scott and Graham	NABL/TC-8226/5579	Provisional	Karnataka		RPT-5186-064586	2024-04-30	SMP-HNY-41358145
9a2a06a4-8704-4b7a-a955-26d3b54274fd	ULR-ZL-7727-46136847	LAB-IN-FXW-32743	Barry-Rivera	NABL/TC-8532/0184	Withdrawn	West Bengal		RPT-6877-721295	2023-12-21	SMP-HNY-78965335
1ad294c5-16b6-4e0d-95a2-252a7e64b12b	ULR-CQ-3702-53293439	LAB-IN-BFP-97529	Thomas-Conner	NABL/TC-9526/7528	Expired	Dadra and Nagar Haveli and Daman and Diu		RPT-9099-555104	2026-05-13	SMP-HNY-23381945
795d604e-4910-4fbd-be9a-3286fc913ee9	ULR-DU-5643-81232915	LAB-IN-IPK-94562	Atkins, Dawson and Ortiz	NABL/TC-9359/8647	Provisional	Maharashtra		RPT-8281-909795	2026-07-16	SMP-HNY-56396399
7a0cd632-a805-4073-92d9-0471ce119e6b	ULR-JH-8186-72328003	LAB-IN-INB-56797	Wilson Group	NABL/TC-8334/1581	Active	Rajasthan		RPT-5829-745334	2025-08-01	SMP-HNY-90164698
6a1732e8-a1e6-4387-89a4-7cc8712eb94e	ULR-YJ-2399-04839893	LAB-IN-XWO-01069	Anderson PLC	NABL/TC-2810/6508	Active	Rajasthan		RPT-9727-128029	2025-02-27	SMP-HNY-59846550
03db0f7a-e5fe-4680-893d-5d2b1aac69ba	ULR-QX-5178-14781803	LAB-IN-FLL-14617	Mccann PLC	NABL/TC-2169/8961	Withdrawn	Lakshadweep		RPT-9185-843797	2024-05-20	SMP-HNY-01955065
c435a59c-82e5-40dd-a87e-d4e53cbd063b	ULR-PY-6990-62219439	LAB-IN-VEX-72764	Brooks, Chung and Herrera	NABL/TC-0432/5666	Withdrawn	Andhra Pradesh		RPT-9684-686978	2021-11-27	SMP-HNY-00921233
cdc25812-5f2b-4789-9ad8-d9e6292c77ef	ULR-RY-6247-07668793	LAB-IN-HMC-75363	Price LLC	NABL/TC-3374/8258	Active	Ladakh		RPT-9237-952531	2022-01-15	SMP-HNY-04038125
7eba6423-37be-472b-9429-f0e77e09c14f	ULR-NL-3058-14551697	LAB-IN-HMZ-70763	Hampton, Boyd and Hicks	NABL/TC-8455/5459	Provisional	Chhattisgarh		RPT-1997-150525	2023-08-23	SMP-HNY-65976773
a355e362-c8bf-4cfe-b87f-b1af1d062310	ULR-GL-2787-87809950	LAB-IN-HEY-31887	Brown and Sons	NABL/TC-5625/4422	Withdrawn	Rajasthan		RPT-7937-982242	2025-03-11	SMP-HNY-02309864
c396f8fe-2376-4c01-9f56-acf122265f94	ULR-NH-4731-65007149	LAB-IN-BBM-90204	Henry, Arnold and Lara	NABL/TC-3227/8511	Suspended	Telangana		RPT-8990-599100	2025-09-24	SMP-HNY-74370175
99c854de-b20b-4497-aa15-4011a7a8953d	ULR-TG-1715-32780536	LAB-IN-EOD-73414	Hamilton, Smith and Johnson	NABL/TC-8888/8299	Provisional	Tripura		RPT-5380-497893	2021-11-15	SMP-HNY-48415010
9e036517-c10f-4e6f-a185-c063a341b7a2	ULR-RY-3270-31994361	LAB-IN-ECT-41084	Ray and Sons	NABL/TC-9372/7251	Expired	Chhattisgarh		RPT-0078-157896	2026-04-19	SMP-HNY-06949945
bed0cd0c-2e84-4458-8d49-29e51c39aa05	ULR-ES-2342-91066069	LAB-IN-NTB-85883	Ward-Barker	NABL/TC-8900/5908	Expired	Dadra and Nagar Haveli and Daman and Diu		RPT-7391-144968	2024-07-24	SMP-HNY-77055328
06e604d0-f1ad-40f9-9cdd-0a397de98f82	ULR-VP-3410-59901409	LAB-IN-QJC-53505	Bradley LLC	NABL/TC-6563/1285	Provisional	Uttarakhand		RPT-8506-016277	2022-07-28	SMP-HNY-71632398
b63fd8ab-a43f-4af8-abc4-be31c15688e1	ULR-II-9273-35881934	LAB-IN-WBC-42028	Griffith, Young and Walker	NABL/TC-9129/2697	Provisional	West Bengal		RPT-7521-590526	2024-02-02	SMP-HNY-77898982
fe7722fe-f0e7-40a0-b7c4-fe79851fb2da	ULR-WI-4232-16513795	LAB-IN-RFX-98690	Nicholson and Sons	NABL/TC-3237/3737	Withdrawn	Himachal Pradesh		RPT-5412-420113	2023-07-13	SMP-HNY-00773202
aeaf4bf0-fe32-49b9-bf70-88ef7dc9feeb	ULR-DH-7305-21704031	LAB-IN-GRS-88076	Harrington-Nichols	NABL/TC-5904/8864	Withdrawn	Jammu and Kashmir		RPT-1133-674986	2024-06-28	SMP-HNY-37008313
56fb47ec-79cc-46d7-b762-33a16a1f4df0	ULR-XQ-5256-62138811	LAB-IN-YDB-63635	Hill-Castillo	NABL/TC-1748/8317	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-1416-418523	2022-12-05	SMP-HNY-76980147
08f78d5e-8cb8-4247-9050-fc7df2ad5914	ULR-RC-0749-40378614	LAB-IN-GUO-03014	Weaver-Wagner	NABL/TC-9224/1497	Expired	Nagaland		RPT-3707-131816	2024-06-08	SMP-HNY-24694886
181549bb-6818-4f06-96ae-296ab9c12877	ULR-JT-1264-06763961	LAB-IN-CJY-15793	Harper, Soto and Smith	NABL/TC-7516/8247	Active	Maharashtra		RPT-5001-874824	2023-09-18	SMP-HNY-41191339
63b4e006-f48c-4069-9c95-12ca7669a987	ULR-MW-4186-58217015	LAB-IN-KXV-55145	York LLC	NABL/TC-6693/8020	Active	West Bengal		RPT-2304-202696	2021-09-22	SMP-HNY-68371297
891b1c0b-2964-4cd2-aef7-062d08400cb7	ULR-SI-0085-60256619	LAB-IN-PKG-39124	Rogers, Fitzgerald and Chung	NABL/TC-2669/1608	Suspended	Nagaland		RPT-8814-879531	2024-10-11	SMP-HNY-25133619
83fe8cb3-efc8-433d-be5a-22d8f823e070	ULR-LX-0612-13147731	LAB-IN-OGA-20306	Randolph-Johnson	NABL/TC-6419/6984	Active	Punjab		RPT-5831-876553	2022-05-28	SMP-HNY-06328819
bd651e71-ee75-4e6e-af9e-defe025d040d	ULR-ZC-8618-85885842	LAB-IN-DHP-81861	Webb, Jones and Farley	NABL/TC-2711/8707	Withdrawn	Jharkhand		RPT-6835-657925	2024-05-02	SMP-HNY-63108409
b0c88f66-421c-4b87-8fab-5e62a8ec1940	ULR-MB-6949-51312254	LAB-IN-PQF-38333	Gibson, Mccormick and Butler	NABL/TC-0453/9134	Active	Arunachal Pradesh		RPT-4770-875825	2025-08-22	SMP-HNY-60123110
3b567e41-9472-42a6-b7a7-f46a250daaf3	ULR-BA-2348-04799628	LAB-IN-HVG-84967	Brock Group	NABL/TC-4101/5205	Withdrawn	Maharashtra		RPT-9808-347648	2024-03-09	SMP-HNY-84958987
a85ff93b-3379-4d6f-9e84-29235b519cc7	ULR-HY-9522-54615840	LAB-IN-NSG-44051	Taylor-Evans	NABL/TC-9096/8408	Active	Karnataka		RPT-1783-681145	2022-10-11	SMP-HNY-83111652
3b3af77f-191a-4b32-8270-d83beebd824c	ULR-TZ-8136-28996907	LAB-IN-DEF-92137	Martinez Group	NABL/TC-6168/9784	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-6810-351672	2023-04-08	SMP-HNY-09682077
b8f88e04-65d3-4513-8e59-408bda719171	ULR-ZK-2972-95150525	LAB-IN-ZHO-77925	Wilson-Henderson	NABL/TC-1554/0302	Active	Jammu and Kashmir		RPT-5187-301684	2025-04-20	SMP-HNY-10006036
1500929e-82e0-4e15-8a9a-2cb8cb048e68	ULR-IF-2954-96539292	LAB-IN-YYA-22037	Pollard Inc	NABL/TC-5069/2202	Active	Puducherry		RPT-5730-540928	2025-08-06	SMP-HNY-96253478
e2fb94f5-45f0-4e30-9da5-44c483ef81f6	ULR-BS-7172-70057142	LAB-IN-EMT-93249	Rodriguez Inc	NABL/TC-4415/7012	Suspended	Rajasthan		RPT-6505-371521	2024-09-05	SMP-HNY-68747614
b9d35794-7585-482d-9178-6d9590125eab	ULR-KW-2924-20346080	LAB-IN-YHS-86808	Johnson-Walker	NABL/TC-6896/3049	Expired	Haryana		RPT-2883-335176	2025-07-19	SMP-HNY-27913550
ed22d928-49b9-4b9a-9fbc-ab628db24a10	ULR-EJ-1885-34403480	LAB-IN-RGP-75538	Howell, Kennedy and Collier	NABL/TC-0636/0575	Suspended	Manipur		RPT-0238-042337	2021-12-11	SMP-HNY-43500936
b1bd4e78-ada7-4aa7-89d4-dd7fa13e7c6d	ULR-JE-6788-73264138	LAB-IN-JWS-11945	Leblanc-Lawrence	NABL/TC-8448/5719	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-5364-613180	2024-10-15	SMP-HNY-72470068
37225326-c62e-44a8-aef6-c3d1f4d83dbe	ULR-UX-4165-82693108	LAB-IN-BMU-91516	Gray PLC	NABL/TC-2661/5563	Provisional	Delhi		RPT-3480-895457	2025-04-13	SMP-HNY-40939628
57ac5003-8487-461c-b2b6-daeb87fc3047	ULR-DO-6945-57784896	LAB-IN-GJI-00266	Nelson Inc	NABL/TC-9869/4391	Withdrawn	Mizoram		RPT-4609-740973	2022-07-06	SMP-HNY-95713443
e36163e3-a2fd-4d6e-8b56-82ac6f66e0bd	ULR-PY-2527-69369334	LAB-IN-NAH-81135	Stephens-Goodwin	NABL/TC-5134/6505	Provisional	Madhya Pradesh		RPT-1081-840737	2026-02-22	SMP-HNY-27109025
be28f02b-245f-4218-9280-9d48feedbf57	ULR-ZE-1799-10725514	LAB-IN-IVE-47770	Hughes-Mcclain	NABL/TC-0942/4590	Suspended	Chandigarh		RPT-7813-457438	2023-07-20	SMP-HNY-64315883
92c8d59e-7baf-424e-b09f-d9d7a173bb32	ULR-WR-6799-48688212	LAB-IN-JPH-09959	Simpson Group	NABL/TC-9696/9154	Expired	Madhya Pradesh		RPT-4833-846913	2024-01-31	SMP-HNY-20404673
75eaf20d-a998-4fbd-8f87-39791a3695cf	ULR-BI-8097-94391815	LAB-IN-VQD-32344	Rogers Inc	NABL/TC-1165/0021	Active	Ladakh		RPT-5724-170144	2025-02-16	SMP-HNY-97207614
e7d8c41a-8b00-4c5e-b12f-de7df0570dbb	ULR-TL-1674-57808542	LAB-IN-LJF-49750	Hines-White	NABL/TC-2105/3357	Suspended	Tripura		RPT-8276-757048	2025-08-05	SMP-HNY-18961127
b5d5582d-d5c4-48f5-9da5-dc376fb7a595	ULR-ZP-1522-90655288	LAB-IN-CAD-86304	Carpenter, Fernandez and Fischer	NABL/TC-6889/1257	Expired	Manipur		RPT-6330-042992	2026-04-09	SMP-HNY-27376757
f345d6e5-da8b-4b83-b538-9c8e211cbbad	ULR-DR-1781-79421949	LAB-IN-KWD-75949	Friedman, Wilson and Gibbs	NABL/TC-2369/8645	Active	Karnataka		RPT-7154-849809	2024-10-08	SMP-HNY-41074280
8d3fa038-86c6-475d-9624-34fbd1f65aa8	ULR-HX-6000-90905330	LAB-IN-QCX-37519	Lopez-Benson	NABL/TC-0533/5204	Suspended	Uttar Pradesh		RPT-1596-770066	2022-09-25	SMP-HNY-55934160
7233f907-5316-4517-8785-474b62eafe76	ULR-IX-2347-27837885	LAB-IN-KLI-00997	Jimenez, Rice and Gonzalez	NABL/TC-1620/2000	Expired	Ladakh		RPT-5070-185880	2026-04-28	SMP-HNY-38965017
062f2b4c-7b64-485a-b721-d36f77becb16	ULR-SE-6490-49118552	LAB-IN-GIR-90611	Grimes LLC	NABL/TC-7510/5498	Expired	Telangana		RPT-6905-767495	2026-07-09	SMP-HNY-13490888
37c56347-af27-4860-b165-56d5cb045e2d	ULR-CE-7634-90525049	LAB-IN-FNR-93346	Rivas Group	NABL/TC-3248/5540	Expired	Uttarakhand		RPT-8142-133877	2026-07-11	SMP-HNY-37086680
60ee689a-4806-4453-a3d2-4ae51e9164a5	ULR-SN-3029-96670720	LAB-IN-FZD-76548	Clarke, Hogan and Thomas	NABL/TC-7343/7399	Withdrawn	West Bengal		RPT-8536-438096	2025-06-09	SMP-HNY-91049731
e382f98b-fd72-4797-b622-f3419c6fe539	ULR-DP-4947-05774803	LAB-IN-TQT-37291	Rodriguez-Fox	NABL/TC-9501/4333	Withdrawn	Meghalaya		RPT-5832-245784	2024-01-15	SMP-HNY-48119100
17497f61-01fe-4293-aab7-fd437b687627	ULR-WL-2223-71007211	LAB-IN-HPB-32170	Nguyen PLC	NABL/TC-1191/7062	Withdrawn	Gujarat		RPT-9080-074967	2026-05-09	SMP-HNY-51699564
48c65a3f-0e5d-4001-80c0-31472d0e681a	ULR-TB-3675-40091448	LAB-IN-KEQ-16016	Hicks and Sons	NABL/TC-3838/8328	Active	Arunachal Pradesh		RPT-4097-523331	2026-07-01	SMP-HNY-27101329
1e477536-9bed-4727-98ae-2f03d4a410fb	ULR-NP-9086-78260383	LAB-IN-QBG-06289	Lee, Garcia and Cochran	NABL/TC-5682/4493	Provisional	Ladakh		RPT-3161-248612	2023-04-10	SMP-HNY-22177200
147c05ee-8f3a-406e-88e4-dfa6a3cf3ced	ULR-UT-7367-62077161	LAB-IN-ISC-73772	Myers Ltd	NABL/TC-6154/5033	Active	Chhattisgarh		RPT-3462-432086	2024-09-29	SMP-HNY-04905790
9644f2cb-6e36-480d-b8c9-4e7da89b94d5	ULR-TA-1694-70541210	LAB-IN-NOS-64393	Perez-Harmon	NABL/TC-2149/9670	Withdrawn	Telangana		RPT-7086-570399	2025-06-03	SMP-HNY-35079553
cd7b5f82-8ecd-4a74-9abe-5ec7195c286d	ULR-LO-0726-32536710	LAB-IN-WPE-47106	Cannon and Sons	NABL/TC-7727/2931	Withdrawn	Goa		RPT-5026-043441	2023-05-16	SMP-HNY-95624722
c8e228da-3370-4d94-8a83-7417edf774fc	ULR-IR-3676-04142169	LAB-IN-GOP-78880	Phillips-Luna	NABL/TC-8103/5348	Provisional	Karnataka		RPT-0564-011854	2023-08-25	SMP-HNY-10572561
97f22cc5-f469-4d61-9750-bc2bb8628a12	ULR-WM-5275-95090813	LAB-IN-FXN-91291	Herring, Cooke and Quinn	NABL/TC-4372/7352	Active	Mizoram		RPT-8928-034375	2022-02-07	SMP-HNY-92764605
00d0fdca-5d99-4177-916b-63ee237e2bd2	ULR-KY-3632-50252367	LAB-IN-ZVN-81660	Davidson, Sheppard and Perry	NABL/TC-2754/9042	Active	Gujarat		RPT-2423-151893	2023-05-19	SMP-HNY-06049425
179c7df9-d71e-4f5a-9312-12fccbaf05e2	ULR-YS-4065-52660983	LAB-IN-SZM-92985	Odom, Henry and Williams	NABL/TC-2870/8792	Active	Chhattisgarh		RPT-9844-608734	2025-06-13	SMP-HNY-75344050
5e6ffe1c-7414-4319-9dab-165ce11be943	ULR-BY-3030-22060610	LAB-IN-ORV-36230	Braun, Torres and Anderson	NABL/TC-0050/7476	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-5431-198932	2024-04-16	SMP-HNY-71874944
84266bf6-363d-4879-86fc-a8a30b862d13	ULR-QR-7738-09436808	LAB-IN-IWT-90586	Mckinney, Anderson and Wright	NABL/TC-6393/9114	Withdrawn	Maharashtra		RPT-7377-366576	2022-09-20	SMP-HNY-93272236
b8fe5d7e-3bdd-43b6-8d62-f48b23eb64ee	ULR-JY-7668-00831881	LAB-IN-MHO-55504	Woods, Olsen and Weaver	NABL/TC-9692/9743	Provisional	Odisha		RPT-0230-999479	2023-03-26	SMP-HNY-88492637
4a468102-2a2a-4014-9b12-dd1ade834460	ULR-II-0950-49317671	LAB-IN-YIM-68519	Graham-West	NABL/TC-9981/9720	Withdrawn	Bihar		RPT-5296-093906	2022-05-25	SMP-HNY-62948878
727a87f1-3900-4b5f-bf82-d134f1712ad2	ULR-WR-4248-52312617	LAB-IN-MVJ-51842	Parks and Sons	NABL/TC-1137/0298	Expired	Punjab		RPT-3331-079484	2021-09-06	SMP-HNY-62266043
915fa110-a32d-40a8-afcb-a793a970d0fa	ULR-JV-5251-26269181	LAB-IN-ETI-91630	Davis-Olsen	NABL/TC-7715/1952	Suspended	Chandigarh		RPT-4373-498952	2024-03-29	SMP-HNY-35177076
95c46535-6483-4f8b-9817-fdc37d21b7f0	ULR-DU-4927-32441424	LAB-IN-KFA-65950	Robbins and Sons	NABL/TC-0892/3595	Expired	Uttarakhand		RPT-1757-149295	2025-12-16	SMP-HNY-73874194
a368a813-a1c7-4d64-a82e-6205afb818eb	ULR-LC-9891-21868126	LAB-IN-RYP-92965	Solis-Turner	NABL/TC-2274/6023	Suspended	Uttarakhand		RPT-4735-619743	2025-11-18	SMP-HNY-81330261
fbeb8c91-f394-4429-bd00-31229849d2f6	ULR-IF-4053-80395559	LAB-IN-JQN-88015	Wilcox, Russell and Mitchell	NABL/TC-7491/4526	Expired	Andhra Pradesh		RPT-7202-202638	2025-02-02	SMP-HNY-51715764
a83798c4-a93d-47a5-bac4-170975f0a4ee	ULR-DR-9260-43259835	LAB-IN-NQH-70030	Snyder, Jones and Jones	NABL/TC-7657/3177	Provisional	Andaman and Nicobar Islands		RPT-2900-299677	2024-04-06	SMP-HNY-44047645
b4901d6c-7571-4d99-8553-8dd79de09983	ULR-EY-9867-27647467	LAB-IN-PJD-65747	Cox, Wiley and Phillips	NABL/TC-7738/4924	Active	Rajasthan		RPT-6114-519850	2023-03-13	SMP-HNY-42790538
b23a648d-0272-40ec-871d-e65c03a059e0	ULR-NO-2744-48372028	LAB-IN-YNG-41464	Day-Martinez	NABL/TC-2189/5505	Suspended	Uttarakhand		RPT-5791-507276	2024-07-23	SMP-HNY-04418493
3a7a5b9d-2709-4d8f-9715-649cc0a53b18	ULR-TP-5091-37099144	LAB-IN-XVD-59198	Moreno, Coleman and Werner	NABL/TC-6202/1965	Suspended	Odisha		RPT-3419-677068	2025-05-22	SMP-HNY-07160503
3b4bbcf2-9482-49c8-a5f3-37d9fe8b3249	ULR-JN-5183-17742423	LAB-IN-KEF-18701	Delacruz LLC	NABL/TC-1172/0887	Withdrawn	Nagaland		RPT-3803-254243	2022-12-31	SMP-HNY-33498026
ebf2a6a1-bfd2-4fb9-9e87-f92777e176c4	ULR-CF-4256-46480570	LAB-IN-HPJ-14839	Hess PLC	NABL/TC-7692/1882	Provisional	Meghalaya		RPT-6454-652421	2025-09-17	SMP-HNY-77365023
ffda7f5f-14ec-4b22-967c-9d58293fd73e	ULR-DL-8323-60299665	LAB-IN-PQH-71103	Perez-Chan	NABL/TC-9794/3160	Expired	Tripura		RPT-7634-029505	2025-02-26	SMP-HNY-93335639
69b6ea28-3bfb-44fc-a66a-047206f92a07	ULR-OU-1556-29761106	LAB-IN-ZMG-26544	Turner Group	NABL/TC-8146/0944	Expired	Assam		RPT-6819-337921	2023-06-23	SMP-HNY-53931700
b94ede2b-c4c9-4b1b-bec2-4afff4ace402	ULR-TC-3903-84466288	LAB-IN-BPG-50340	Marks-Nash	NABL/TC-2672/0372	Withdrawn	Andhra Pradesh		RPT-7732-746283	2024-05-23	SMP-HNY-43836201
c0a5b43c-b12d-44de-af84-0091bffa168e	ULR-BJ-0481-90334351	LAB-IN-GHE-30467	Ruiz, Johnson and Stewart	NABL/TC-8637/6474	Withdrawn	Andaman and Nicobar Islands		RPT-7186-018735	2025-10-15	SMP-HNY-05325625
dd200ad5-05bd-4b71-be7c-e9bc94399fa4	ULR-CJ-7242-16159978	LAB-IN-CZD-13462	Johnson Group	NABL/TC-2148/1272	Suspended	Telangana		RPT-8073-790205	2023-09-02	SMP-HNY-45547502
e0ac28dd-bb54-47bb-badb-87263fec5a91	ULR-XB-4339-54219410	LAB-IN-HCC-37097	Campbell Inc	NABL/TC-7742/8398	Provisional	Bihar		RPT-8973-741413	2024-03-05	SMP-HNY-94647759
c554b30f-271b-4d46-a848-8e1109f1e886	ULR-VE-9759-17132076	LAB-IN-WIB-81456	Watson, Robinson and Smith	NABL/TC-6546/0128	Expired	Kerala		RPT-3621-682322	2026-03-31	SMP-HNY-23253729
a9ae42eb-f198-45f7-ba54-dff51652e5cd	ULR-SC-1614-04722192	LAB-IN-YQK-93537	Mendez-Green	NABL/TC-9560/3600	Suspended	Ladakh		RPT-7884-655023	2026-03-29	SMP-HNY-72795604
dc44b1d3-67ab-491d-a76d-93b13aefd1e0	ULR-QB-3678-06087264	LAB-IN-LNK-34305	Robertson, Gentry and Taylor	NABL/TC-4160/3432	Provisional	Goa		RPT-3130-583970	2026-04-13	SMP-HNY-58021765
5c4e69e6-daa0-4e3c-ac8d-20428e12a638	ULR-NZ-4552-29333522	LAB-IN-ZVE-59213	Fisher-Williams	NABL/TC-1009/7830	Active	Nagaland		RPT-4737-134765	2024-03-30	SMP-HNY-97772078
c43a1712-c8c5-4f5d-8149-225cbfb90bea	ULR-RK-5644-21056857	LAB-IN-KBZ-10729	Adams, Green and Davila	NABL/TC-2226/8557	Expired	Punjab		RPT-7609-939907	2023-01-29	SMP-HNY-54552097
01aa1939-9302-496a-ba58-c788f1af4a51	ULR-ZD-1967-56967726	LAB-IN-VOT-79549	Sandoval-Knight	NABL/TC-3585/1277	Expired	Arunachal Pradesh		RPT-9523-580054	2025-09-29	SMP-HNY-47822360
89848391-86c5-41b3-8c25-c65cd73f9bf1	ULR-QJ-9533-31827735	LAB-IN-LGE-42939	Rodriguez Inc	NABL/TC-5899/5185	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-3394-288866	2025-06-15	SMP-HNY-49430345
622ac90b-fea9-4720-be6d-15c417651e3f	ULR-ZF-7066-85616562	LAB-IN-RLT-16330	Solis-Hamilton	NABL/TC-8777/0134	Expired	Rajasthan		RPT-6720-454853	2024-07-02	SMP-HNY-98462799
9e2e8d00-f011-48a2-bd82-30ad83eb2401	ULR-GY-1547-18186890	LAB-IN-MLC-83704	Burke-Waller	NABL/TC-3894/6216	Provisional	Goa		RPT-6549-800005	2026-07-05	SMP-HNY-22662242
3dc07272-8de3-47ef-87e6-08ee3a4d8840	ULR-UV-1199-60258703	LAB-IN-CYF-63731	Ashley and Sons	NABL/TC-8146/1952	Expired	Haryana		RPT-4876-706317	2025-04-21	SMP-HNY-90893473
c5edf741-19fc-4bab-a217-e29649dd685c	ULR-VX-7745-29584451	LAB-IN-QGZ-87404	Houston Inc	NABL/TC-7134/7253	Suspended	Jharkhand		RPT-9555-116236	2026-07-17	SMP-HNY-64147315
085e3c4b-5a5a-4cbe-b58f-743e0e723679	ULR-DG-8134-84940020	LAB-IN-RDI-09098	Hernandez-Cruz	NABL/TC-8379/9181	Provisional	Puducherry		RPT-5081-178025	2024-08-17	SMP-HNY-77333633
41da34f5-59b5-4a9b-b8b3-b4105e035eeb	ULR-RO-0631-01876399	LAB-IN-YUQ-12737	Meyer-Thomas	NABL/TC-9940/7467	Provisional	Uttar Pradesh		RPT-5758-931851	2023-07-12	SMP-HNY-42706268
d38668a4-ba9c-4ca9-a49d-fe984982fe26	ULR-WM-1256-96090362	LAB-IN-THF-72254	Mitchell and Sons	NABL/TC-6232/7756	Expired	Gujarat		RPT-3857-773666	2025-04-07	SMP-HNY-32157549
44a8461f-b58f-47f2-87cb-014a4378ddd5	ULR-UD-1802-66910385	LAB-IN-GVO-43150	Rollins Inc	NABL/TC-0866/0165	Provisional	Lakshadweep		RPT-3331-518321	2024-12-09	SMP-HNY-38236435
39e75e3a-8574-46c2-9718-0e7bc70d9f48	ULR-CB-5739-87675374	LAB-IN-KUI-86499	Willis PLC	NABL/TC-8810/0771	Expired	Jharkhand		RPT-1654-357475	2025-08-05	SMP-HNY-96202185
4fdfb0a7-4d8d-42ba-8a69-8af80c23ea42	ULR-BB-2787-64459878	LAB-IN-EPO-23253	Moody and Sons	NABL/TC-3806/2807	Expired	Telangana		RPT-4162-514216	2022-04-08	SMP-HNY-22913604
9fae4f1c-7f9d-4930-bf08-458947afc967	ULR-SL-4189-22495515	LAB-IN-SJG-03834	Fleming, Day and Johnson	NABL/TC-0675/1356	Withdrawn	Delhi		RPT-9987-900721	2026-03-18	SMP-HNY-06243797
9cceafe7-4e2b-4e08-a709-35a6c5bdf9ac	ULR-AJ-5989-05347155	LAB-IN-FHC-24023	Kent-Taylor	NABL/TC-1060/3422	Provisional	Goa		RPT-5750-654854	2024-11-15	SMP-HNY-34490876
9a0b5380-82f6-4450-95d7-0da23c231bd2	ULR-MM-3719-48325724	LAB-IN-IWA-56697	Fletcher-Washington	NABL/TC-4792/9866	Suspended	Manipur		RPT-5782-385404	2023-11-06	SMP-HNY-84676638
643aa4e6-4eca-4294-8998-1696b250fa65	ULR-UP-1590-44087292	LAB-IN-GZA-32008	Johnson-French	NABL/TC-0900/2980	Active	West Bengal		RPT-4070-093272	2024-09-17	SMP-HNY-00918248
b2169e94-5559-4a6f-83c2-564491ac1ae4	ULR-VO-3082-01392469	LAB-IN-DFX-07354	Reid Inc	NABL/TC-1825/6300	Expired	Punjab		RPT-6555-428899	2023-12-29	SMP-HNY-70229474
7b86c9f0-0f3f-4e74-a006-9089d6bf3aae	ULR-DP-2344-96556115	LAB-IN-KUQ-11028	Frederick-Harris	NABL/TC-4425/4405	Suspended	Telangana		RPT-5086-262593	2026-01-31	SMP-HNY-92289002
585d7d4f-31c5-482a-9c53-dab58dcb1df2	ULR-QO-7006-64053013	LAB-IN-UOP-34071	Thompson-Martin	NABL/TC-8876/1902	Active	Tamil Nadu		RPT-3792-672094	2025-06-22	SMP-HNY-24489207
ae6a0e48-4537-4b04-a479-caaee9b9bdf5	ULR-JF-9256-52390292	LAB-IN-IWO-57070	White-Burton	NABL/TC-5183/1558	Active	Kerala		RPT-0980-507292	2026-02-21	SMP-HNY-84907932
df6322c3-88b5-4b64-b6e2-9df505ec6375	ULR-UF-8877-30126710	LAB-IN-KQC-05017	Wallace PLC	NABL/TC-4533/9624	Expired	Mizoram		RPT-3626-676375	2021-11-11	SMP-HNY-19124809
95a75c32-fa65-410a-bff8-3082a77afb2e	ULR-SA-4647-14417241	LAB-IN-BRG-88524	Mason-Reed	NABL/TC-7640/3357	Provisional	Mizoram		RPT-8348-762633	2022-04-30	SMP-HNY-43094166
4d2ad107-0d2e-4e59-88fb-449d604e6e76	ULR-HT-3118-07028904	LAB-IN-SSY-08990	Ellis-Proctor	NABL/TC-8444/1116	Withdrawn	Kerala		RPT-6634-580421	2024-11-05	SMP-HNY-78134435
7a19f90c-3c8c-482a-a835-af0439d4c67a	ULR-LO-8831-34394256	LAB-IN-LUV-98136	Thomas LLC	NABL/TC-5101/0161	Withdrawn	Chhattisgarh		RPT-7569-248704	2021-11-18	SMP-HNY-97923015
afa1093e-e476-4eb7-9f54-6f69d1cc555b	ULR-BO-9307-95869866	LAB-IN-ICR-61153	Smith, Williams and Morrison	NABL/TC-0766/9904	Withdrawn	Ladakh		RPT-1583-194486	2024-09-04	SMP-HNY-93038520
db5facf3-0e03-4f36-92fa-29f226659b0a	ULR-XG-6840-50958872	LAB-IN-WGX-10993	Davis-Ingram	NABL/TC-8164/8703	Withdrawn	Himachal Pradesh		RPT-4796-946943	2024-03-12	SMP-HNY-07389535
284df9f6-80c6-4503-b531-1196de43b881	ULR-BM-8324-96665387	LAB-IN-VWT-52897	Douglas-Cox	NABL/TC-2182/4307	Provisional	Odisha		RPT-9053-661008	2021-09-02	SMP-HNY-66346216
5a3bdf7a-6693-4662-9d2d-c61653613840	ULR-EB-0480-44253665	LAB-IN-VHR-16962	Patterson-Mclaughlin	NABL/TC-3220/5689	Suspended	Jammu and Kashmir		RPT-5704-676944	2024-01-18	SMP-HNY-90567455
4faf8fa6-9c74-45e4-8508-8a0880c674b6	ULR-CY-6217-46183225	LAB-IN-KAI-17944	Jimenez, Perez and Solomon	NABL/TC-6889/1010	Suspended	Uttar Pradesh		RPT-2348-032558	2025-09-09	SMP-HNY-58626377
3cd0595e-2314-48f9-aa5d-8ced4029b8a8	ULR-CT-4441-92500482	LAB-IN-NUC-84139	Carpenter and Sons	NABL/TC-8629/7619	Active	Puducherry		RPT-0161-158411	2026-01-02	SMP-HNY-90390076
9e59fb94-1ad8-49af-a96c-afe2d4098c38	ULR-MD-2879-09063339	LAB-IN-ZCX-67089	Leonard, Allen and Brock	NABL/TC-6820/0026	Suspended	Sikkim		RPT-4316-638686	2021-12-15	SMP-HNY-34206607
0b0bf93c-c7db-4dcb-9c28-1c1a13ad7f71	ULR-CQ-7949-04917394	LAB-IN-ENQ-90630	Phillips, Romero and Moran	NABL/TC-8358/3602	Suspended	Jharkhand		RPT-4532-971187	2026-02-17	SMP-HNY-85331800
ad0d5620-487d-4a61-8d34-63d506e77ba3	ULR-XL-6163-26335510	LAB-IN-CEB-87312	Wade, Phillips and Lynn	NABL/TC-1657/1903	Expired	Nagaland		RPT-8376-614234	2023-01-05	SMP-HNY-63912764
2d5d9af3-69d1-42c0-aea7-7f085b3999b2	ULR-KB-8638-83611123	LAB-IN-JPR-90950	Mendez-Martinez	NABL/TC-9327/1136	Suspended	Jammu and Kashmir		RPT-3857-647605	2024-05-20	SMP-HNY-17968165
31f60256-0151-4521-ad76-778c3b4893f2	ULR-VP-4536-63193123	LAB-IN-JVP-69607	Turner Group	NABL/TC-2208/2293	Active	Maharashtra		RPT-6556-747814	2023-08-01	SMP-HNY-74059432
902fc7a6-3c16-41f1-98b4-1088e7c14b07	ULR-BG-1052-31584734	LAB-IN-CRI-57246	Stevens Ltd	NABL/TC-8354/9851	Provisional	Odisha		RPT-6931-947801	2024-02-12	SMP-HNY-21946469
1851bf31-1a02-4d74-90f7-413648b1749d	ULR-UX-4036-84038250	LAB-IN-JZH-10930	Baker-Diaz	NABL/TC-5804/3702	Suspended	Karnataka		RPT-5334-801928	2024-01-04	SMP-HNY-84024282
1cc24936-01fa-4f70-8316-52b58c7a1cdc	ULR-YT-3115-74512738	LAB-IN-PSZ-28683	Wilson-Terrell	NABL/TC-1373/0326	Withdrawn	Assam		RPT-6063-981853	2025-01-20	SMP-HNY-24120038
9b1f4753-1832-46ad-8ce1-6c1b7d57f8ad	ULR-KI-2315-56283788	LAB-IN-UMY-28464	Grant, Anderson and Davenport	NABL/TC-5986/5759	Suspended	Puducherry		RPT-5696-486723	2023-02-03	SMP-HNY-66763911
0628c64f-7b8f-45f8-80b0-eb12b8d81efd	ULR-AF-4637-85645813	LAB-IN-SJU-14212	Smith, Cordova and Johnson	NABL/TC-0004/1025	Active	Rajasthan		RPT-5998-442073	2026-04-06	SMP-HNY-65135066
213c35b3-b4f1-49b7-a160-cc333de2b364	ULR-KD-7371-01444359	LAB-IN-KGP-80712	Mccoy-Cisneros	NABL/TC-7597/5301	Active	Punjab		RPT-0435-798353	2024-10-24	SMP-HNY-17463339
ee77d030-efd3-4424-8378-8da56a7b7e0a	ULR-MN-8223-12995597	LAB-IN-NUW-97185	Salas-Daugherty	NABL/TC-4218/7305	Provisional	Gujarat		RPT-6563-655526	2024-07-03	SMP-HNY-38877148
3bf57e55-eed1-45c6-b8fb-15e93a34d210	ULR-PG-8760-31070884	LAB-IN-REM-28295	Hernandez PLC	NABL/TC-4701/4530	Suspended	Meghalaya		RPT-6010-225332	2023-03-16	SMP-HNY-93660331
22d2e395-bb6c-41d3-90aa-12f85fa8cc0f	ULR-EX-5008-91214156	LAB-IN-IDI-43669	Mora-Weber	NABL/TC-0148/7210	Withdrawn	Tamil Nadu		RPT-4202-352156	2023-10-04	SMP-HNY-12359283
d09a1b9d-0609-4428-af6e-e169d982174c	ULR-OB-9070-08888309	LAB-IN-KGC-99882	Jackson-Smith	NABL/TC-9070/5945	Expired	Manipur		RPT-1771-699664	2026-07-23	SMP-HNY-50757136
69b2ac85-fb9e-420a-ab9b-db427ed64856	ULR-RI-4816-97493225	LAB-IN-KIK-07261	Ortiz, Harris and Smith	NABL/TC-1125/8646	Active	Jammu and Kashmir		RPT-6268-409213	2026-05-16	SMP-HNY-73436320
a9cae5cd-4370-48f2-955a-a2a0981480ef	ULR-OQ-2142-88819598	LAB-IN-RLR-39707	Diaz-Gilmore	NABL/TC-0707/9555	Withdrawn	Andhra Pradesh		RPT-0322-521651	2022-10-29	SMP-HNY-20564330
c384f109-9ac7-49d5-987e-64cf169ff887	ULR-AK-1606-38328794	LAB-IN-BPI-98097	Vega, Vega and Harper	NABL/TC-3579/4173	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-4383-377178	2023-01-02	SMP-HNY-61244998
2d414fcb-47b9-40dd-b017-ce69ababe137	ULR-SS-0204-96574953	LAB-IN-VBM-32740	Richards, Rogers and Bowman	NABL/TC-8733/9422	Expired	Odisha		RPT-0968-354066	2022-01-24	SMP-HNY-02050023
822f4088-25c5-428d-b846-af71b1f65e06	ULR-WO-8220-44878869	LAB-IN-CBN-58193	White-Thomas	NABL/TC-8134/3535	Active	Karnataka		RPT-2040-242200	2021-09-05	SMP-HNY-07203823
7e5c3d68-a004-42c0-80c5-281c01eb19f6	ULR-GX-6894-85574183	LAB-IN-CRP-62354	Park-Bennett	NABL/TC-2321/8532	Expired	Puducherry		RPT-3853-013813	2023-04-03	SMP-HNY-55756279
4adb9533-16aa-401a-a7ad-c3233da315d3	ULR-NM-5671-95671559	LAB-IN-OYQ-93848	Thomas and Sons	NABL/TC-2398/5583	Withdrawn	Rajasthan		RPT-6010-250534	2024-04-19	SMP-HNY-99735616
23da8bb9-d3d0-4b47-8dbd-603f529baf52	ULR-AW-1100-05383633	LAB-IN-CAY-43923	Jennings, Hernandez and Perez	NABL/TC-6121/1651	Withdrawn	Bihar		RPT-0374-998094	2025-11-05	SMP-HNY-06676919
87a2c1ac-dc78-4aae-8d01-c4845dacad01	ULR-XI-6663-30104174	LAB-IN-IDW-94759	Thompson, Logan and Rodgers	NABL/TC-9403/5683	Active	Odisha		RPT-5447-674748	2024-03-12	SMP-HNY-89626783
5398ce15-92b4-4709-b044-77965662d31f	ULR-DC-0824-32016558	LAB-IN-TOK-63608	Maxwell, Walters and Brown	NABL/TC-6434/6606	Withdrawn	Andaman and Nicobar Islands		RPT-9423-685944	2023-02-04	SMP-HNY-58528308
968868ee-ba4e-44d6-871f-78704d4a99b8	ULR-OU-1348-15489084	LAB-IN-LCC-27576	Adams-Cox	NABL/TC-3461/0284	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-3999-228023	2023-12-14	SMP-HNY-69683916
10b1500d-c8b1-4b9b-9001-44eb21572150	ULR-FZ-9979-55059784	LAB-IN-SJH-41303	Long PLC	NABL/TC-4217/4658	Active	Uttarakhand		RPT-5221-148699	2025-11-22	SMP-HNY-38317996
1523bbb7-5276-439f-92d7-c725c5dd9bf9	ULR-JN-1789-40636199	LAB-IN-DEB-44416	Sloan Ltd	NABL/TC-4129/9343	Provisional	West Bengal		RPT-6455-043034	2023-05-02	SMP-HNY-11101158
d350bb9f-dde3-41e4-847d-21e05f6ae520	ULR-KA-4960-38866695	LAB-IN-ZIZ-85889	Valdez-Black	NABL/TC-5952/1583	Suspended	Chandigarh		RPT-1458-331876	2022-06-23	SMP-HNY-51963023
5635ad84-50fe-4c3b-9eec-87a339ca354b	ULR-HM-3869-34982873	LAB-IN-OMG-08377	Kim LLC	NABL/TC-5865/1690	Suspended	Uttar Pradesh		RPT-4164-281746	2026-05-25	SMP-HNY-82046904
7dfb55f4-317a-451c-ad81-4c66a582c3c7	ULR-GR-1567-97797669	LAB-IN-ZYG-03020	Hunt, Friedman and Bush	NABL/TC-4017/1598	Withdrawn	Karnataka		RPT-1073-732883	2023-02-03	SMP-HNY-00151273
412efb11-9b4b-4003-9b7e-bca1c7e8dc63	ULR-IA-1053-03030814	LAB-IN-USM-31770	Benjamin Group	NABL/TC-6109/7378	Suspended	Nagaland		RPT-9436-666781	2025-12-30	SMP-HNY-72086891
e00eba0a-cf26-4dcb-b167-aa5b0d3c89fd	ULR-MN-1774-46937195	LAB-IN-ADI-60156	Gonzalez-Finley	NABL/TC-2746/4092	Expired	Jharkhand		RPT-6145-820738	2025-09-24	SMP-HNY-68211117
3482d702-f156-4555-a438-4c3d268fc1d3	ULR-WC-4524-55010874	LAB-IN-USP-04398	Sanchez, Houston and Carter	NABL/TC-1089/6495	Provisional	Rajasthan		RPT-3622-107894	2025-10-23	SMP-HNY-29651652
dca52d52-1d2d-4074-9f0f-8a0ee3890be1	ULR-EG-1040-80387489	LAB-IN-VET-41808	Benjamin Group	NABL/TC-5978/7174	Provisional	Ladakh		RPT-7696-510348	2024-05-12	SMP-HNY-57496905
4e3f2b07-1feb-4b43-b63a-b528c946b7c2	ULR-GS-4537-99270127	LAB-IN-RXJ-51202	Wilson and Sons	NABL/TC-4200/6211	Suspended	Bihar		RPT-3197-847316	2022-03-31	SMP-HNY-88089008
e5926c05-55dc-43fe-80d2-f07c142b498e	ULR-MQ-4667-19741846	LAB-IN-IYF-57455	Black, Velasquez and Snyder	NABL/TC-9939/8711	Expired	Uttar Pradesh		RPT-1907-130654	2023-06-19	SMP-HNY-94055419
8a915791-534f-4ec6-91e0-3efe73481ec1	ULR-XW-1049-17131512	LAB-IN-INB-35497	Thomas-Williamson	NABL/TC-3393/2741	Withdrawn	Mizoram		RPT-4676-917149	2023-01-15	SMP-HNY-43527519
44aaa204-c89f-4c5d-b1e7-db761d0e010a	ULR-YV-4543-13361400	LAB-IN-OCP-72378	Williams PLC	NABL/TC-9305/1468	Active	Tamil Nadu		RPT-0901-012789	2022-10-23	SMP-HNY-15050685
f31e64a6-1745-411b-aabb-7a5755f97507	ULR-CX-8193-26963601	LAB-IN-OLM-85379	Brown-Gross	NABL/TC-0126/1940	Provisional	Himachal Pradesh		RPT-7521-831391	2022-12-20	SMP-HNY-20783348
af9080f4-0658-41ff-b8c8-1fa9cf1bff68	ULR-DB-3081-99958016	LAB-IN-MXD-42456	Banks Ltd	NABL/TC-1851/2864	Active	Jharkhand		RPT-9429-668233	2024-07-15	SMP-HNY-38768095
c8c75d9d-4db1-4601-b397-8e3f81a3a58f	ULR-HH-0270-35188888	LAB-IN-RYB-11384	Lee-Davis	NABL/TC-8866/0415	Suspended	Punjab		RPT-3017-910408	2021-10-21	SMP-HNY-52106731
6b33fb55-2008-4fa4-9142-3ce8c84f92d4	ULR-DU-6261-41788286	LAB-IN-FFB-07399	Hamilton Group	NABL/TC-7990/3376	Expired	Himachal Pradesh		RPT-7324-612568	2021-12-27	SMP-HNY-89969330
415103ad-0ff5-44d0-8bcb-052162f56232	ULR-TT-5289-03218339	LAB-IN-GNN-49604	Williams, Perez and Smith	NABL/TC-4261/8129	Withdrawn	Bihar		RPT-5165-052932	2022-11-09	SMP-HNY-40520210
73ae1967-51c9-45a5-acaa-5ba6cf1b95e3	ULR-QS-1629-91845886	LAB-IN-RRA-38130	Mejia PLC	NABL/TC-3232/0435	Suspended	Jammu and Kashmir		RPT-0902-286050	2023-12-14	SMP-HNY-50391306
e65d4418-c2ca-4810-a588-0ef4cedbf963	ULR-QC-6758-31194765	LAB-IN-WQK-25865	Brown-Byrd	NABL/TC-2622/6641	Expired	Manipur		RPT-1982-064134	2023-03-15	SMP-HNY-07642386
6894d53e-c02f-46bc-ae08-e2a0bce8347c	ULR-WY-2903-99345065	LAB-IN-UEX-86813	Johnson-Garcia	NABL/TC-0254/5987	Withdrawn	Nagaland		RPT-3548-717505	2022-12-18	SMP-HNY-91305319
b63835bc-54cc-4aec-b027-883bc4d956f7	ULR-XU-2961-86290136	LAB-IN-CGI-59285	Burns Group	NABL/TC-3049/8896	Provisional	Ladakh		RPT-9551-784495	2025-02-26	SMP-HNY-28701190
74fc81a1-f0e4-4b15-8dfe-42aa0bd7c035	ULR-LE-1226-14471618	LAB-IN-OKE-85998	Foster, Potter and Singh	NABL/TC-0838/1825	Active	Uttar Pradesh		RPT-5395-538259	2024-10-28	SMP-HNY-35517734
e9ed18cf-66a4-4e68-a06b-afebde79e2ad	ULR-DB-6372-55792041	LAB-IN-TYK-33018	Smith LLC	NABL/TC-2249/1496	Active	Lakshadweep		RPT-0878-736021	2024-02-02	SMP-HNY-17224404
c31f2005-4f9e-45ff-a8ef-31e1f9c65a24	ULR-EN-8548-64059394	LAB-IN-GHQ-89135	King PLC	NABL/TC-4471/6810	Active	Tamil Nadu		RPT-3236-041341	2023-09-06	SMP-HNY-89531583
6214fcef-77d6-4c59-925e-3993083441c7	ULR-NS-1481-33551712	LAB-IN-LKP-65718	Ferguson PLC	NABL/TC-2746/6904	Expired	Lakshadweep		RPT-8862-175599	2023-01-13	SMP-HNY-04437029
a9cf5455-69c0-4b55-8044-609a37a959f7	ULR-XZ-8903-90456407	LAB-IN-UYF-32346	Gilmore, Mcdonald and Haley	NABL/TC-1615/0632	Expired	Karnataka		RPT-8358-932344	2022-10-17	SMP-HNY-38753002
da23d489-dc2b-4175-917d-a23364cdbef8	ULR-RR-9173-90112218	LAB-IN-WEU-52369	West, Smith and Anderson	NABL/TC-3308/2513	Expired	Punjab		RPT-2683-861335	2023-07-02	SMP-HNY-01457510
e0b9159e-80fb-4649-b7e6-595b9d0fc922	ULR-NY-9228-05600547	LAB-IN-TSH-45187	Harvey-White	NABL/TC-9632/4179	Withdrawn	Chhattisgarh		RPT-6724-258697	2025-01-29	SMP-HNY-58740826
ad48eb78-5946-47d2-a95a-72856ef374b5	ULR-OY-4525-77894173	LAB-IN-EHI-92984	King-Hunt	NABL/TC-1209/2327	Withdrawn	Mizoram		RPT-8648-101119	2024-06-30	SMP-HNY-91399212
44846715-5120-4233-bd7c-a2d19e217cf8	ULR-FO-4238-99351877	LAB-IN-IGK-91180	Macdonald-Howard	NABL/TC-9155/6143	Suspended	West Bengal		RPT-9382-466064	2025-07-02	SMP-HNY-64787311
09de9d8e-edea-460b-98a5-a1c5cf9c6b01	ULR-HX-2796-33229595	LAB-IN-RGC-12403	Garcia, Carpenter and Villanueva	NABL/TC-2757/8001	Suspended	Andhra Pradesh		RPT-7918-162770	2024-10-23	SMP-HNY-53308579
7a391b46-5162-4d50-9826-98305a77044c	ULR-VU-0590-04436576	LAB-IN-JGQ-94698	Morris PLC	NABL/TC-9202/4978	Withdrawn	Tamil Nadu		RPT-3553-134266	2026-02-28	SMP-HNY-95520348
bfb15807-a395-4aed-ac6a-2e9b7009126c	ULR-FD-3325-92622289	LAB-IN-XIV-29044	Nelson-Thomas	NABL/TC-4095/4771	Withdrawn	Madhya Pradesh		RPT-5143-553179	2024-12-25	SMP-HNY-82441373
daf094c1-ebab-41b4-a782-e4cf6dafe7b6	ULR-RO-6203-33520154	LAB-IN-AOH-75264	Smith and Sons	NABL/TC-3667/4771	Withdrawn	Tamil Nadu		RPT-2970-622700	2023-09-14	SMP-HNY-03152303
ab252d5a-fac1-4955-a202-285ffe485b9d	ULR-HZ-8440-11328000	LAB-IN-BZS-78249	Thompson-Boyd	NABL/TC-5593/8339	Expired	Punjab		RPT-3559-111527	2022-12-17	SMP-HNY-87313425
17a431eb-9fd3-4c11-b9e3-679d30aa9366	ULR-WR-0323-65659381	LAB-IN-PCM-66883	Silva, Richmond and Booth	NABL/TC-0653/3172	Active	Arunachal Pradesh		RPT-6864-777963	2022-12-31	SMP-HNY-06864187
e1c6a9ce-a004-45d2-8b64-d295ad5572e5	ULR-VT-3338-28289809	LAB-IN-PLV-76169	Bell-Wood	NABL/TC-0105/6135	Active	Sikkim		RPT-6373-196304	2023-02-01	SMP-HNY-88472732
231f8efb-1c2c-42a8-8e59-c21f2fe2f093	ULR-JT-4263-00635488	LAB-IN-XQA-19402	Harrington-Young	NABL/TC-3084/5371	Expired	Manipur		RPT-2916-227889	2024-03-10	SMP-HNY-62169176
30d95f14-3e61-490d-8d54-8768efda0616	ULR-LE-3006-37194081	LAB-IN-TIV-19513	Floyd, Jones and Gomez	NABL/TC-3425/6328	Active	West Bengal		RPT-3805-946252	2021-10-22	SMP-HNY-61075286
34bdad29-6388-4b42-8b52-2d7eb327c2a3	ULR-RA-6745-89145914	LAB-IN-JRZ-94058	Adams LLC	NABL/TC-3586/2700	Withdrawn	West Bengal		RPT-9477-274530	2026-07-17	SMP-HNY-91223165
8590f061-2e82-46cf-8160-cf54646d64fd	ULR-WP-5334-08585659	LAB-IN-OKI-06798	Peterson-Cooper	NABL/TC-7035/4365	Active	Kerala		RPT-4382-181194	2025-07-05	SMP-HNY-24672282
4190dd0f-bc88-4fbb-ab40-0f420963c4bb	ULR-XR-4073-82041184	LAB-IN-YFQ-24375	Rice-Dickerson	NABL/TC-1138/5796	Provisional	Delhi		RPT-2666-466051	2023-07-11	SMP-HNY-26918211
35c65bc8-f11f-468a-8919-5789f5a0f922	ULR-QE-2692-84103201	LAB-IN-FFC-40148	Lambert PLC	NABL/TC-3287/4401	Expired	Kerala		RPT-5901-471482	2025-08-22	SMP-HNY-29963758
a41a65a4-e73a-407d-8030-709b0f78415a	ULR-ME-6791-76340637	LAB-IN-HKH-58303	Garza Inc	NABL/TC-0108/7802	Suspended	Haryana		RPT-8659-130348	2023-06-21	SMP-HNY-61296901
a1c78feb-ca92-4d17-a43e-5d2792bae44c	ULR-NE-4637-74828835	LAB-IN-VDB-55407	Nelson PLC	NABL/TC-1056/8480	Provisional	Puducherry		RPT-9289-454046	2026-05-30	SMP-HNY-37543251
001f9928-1534-43aa-9c72-1456045a0d95	ULR-CP-1407-77539249	LAB-IN-YCR-62180	Patton-Skinner	NABL/TC-8289/3804	Expired	Meghalaya		RPT-5986-012102	2026-08-27	SMP-HNY-88460926
f518a25d-779f-4302-a54e-eb9ff685cd16	ULR-PJ-7807-92649808	LAB-IN-ZQY-08706	Harris-Morrison	NABL/TC-2039/9692	Expired	Nagaland		RPT-1645-035303	2022-05-17	SMP-HNY-28055385
c7322215-f282-4e79-a5df-4ad4b91f432f	ULR-HW-2937-68767687	LAB-IN-LOU-68615	Peters-Robbins	NABL/TC-6411/4318	Withdrawn	Punjab		RPT-4305-030171	2023-12-10	SMP-HNY-57320284
e4335dbd-41f5-4390-a224-6a921251e6b5	ULR-NI-4793-99350869	LAB-IN-YFC-72599	Estrada-Marquez	NABL/TC-4829/7446	Expired	Dadra and Nagar Haveli and Daman and Diu		RPT-8098-728550	2024-06-01	SMP-HNY-15196923
2686b402-e8c6-46a8-ab67-645ec6ad8e77	ULR-ER-6016-55138636	LAB-IN-RKK-37096	Bradford-Savage	NABL/TC-3067/1008	Provisional	Meghalaya		RPT-4771-355394	2023-05-12	SMP-HNY-52940962
bed0913a-b2d9-45e7-b89a-dc71aa9208a8	ULR-CE-8145-79706875	LAB-IN-DNX-96789	Thomas, Larson and Walker	NABL/TC-3294/3252	Provisional	West Bengal		RPT-2933-247099	2023-08-16	SMP-HNY-02324517
537f6666-d355-4d15-a154-83e80adbea14	ULR-FT-1249-49994083	LAB-IN-DTR-94625	Graves-Carpenter	NABL/TC-1301/1877	Expired	Arunachal Pradesh		RPT-0285-101454	2024-11-05	SMP-HNY-83507995
700aeffc-a6d7-4bad-90ea-fc6f47b6ecd8	ULR-YH-4896-21814017	LAB-IN-VRG-71019	Welch-Gallagher	NABL/TC-9505/5779	Expired	Andhra Pradesh		RPT-8057-479538	2023-01-25	SMP-HNY-63708555
52fe5769-505d-495c-b00b-d64c0d3acad4	ULR-WB-5156-89411124	LAB-IN-AIW-21337	Richardson, Walker and Johnson	NABL/TC-5281/0591	Provisional	Andhra Pradesh		RPT-5912-770558	2021-12-15	SMP-HNY-65209930
422c1909-e8ef-44cc-a71e-6171b83b25fe	ULR-UH-2062-97589128	LAB-IN-YLX-95549	Anderson-Flores	NABL/TC-2507/0683	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-8354-608813	2023-07-12	SMP-HNY-84310784
0e5e0bbd-de22-46a7-8a4a-ea340dd3352e	ULR-QI-1190-42560898	LAB-IN-POR-09700	Ritter-Lester	NABL/TC-5337/5145	Provisional	Andaman and Nicobar Islands		RPT-5639-922214	2025-04-20	SMP-HNY-23687729
9a82728c-5b35-4289-89a6-fe61c422272a	ULR-NC-6351-24311755	LAB-IN-UMV-80389	Garcia-Campbell	NABL/TC-7800/8409	Expired	Himachal Pradesh		RPT-3094-111596	2022-09-02	SMP-HNY-77381836
e97a00a1-5aa5-4f62-be95-cce451cc0982	ULR-MW-3479-50347207	LAB-IN-CCF-47969	Church-Craig	NABL/TC-0344/5536	Provisional	Assam		RPT-9203-766916	2026-01-26	SMP-HNY-38288916
799ac60e-234c-43ba-9522-49da1eb348d1	ULR-BQ-3180-94518711	LAB-IN-IQP-88329	Tyler, Smith and Rojas	NABL/TC-9814/2618	Withdrawn	Arunachal Pradesh		RPT-8899-107470	2024-05-01	SMP-HNY-51480271
effcb8bd-25af-479f-a6e9-f14f45eeb8ef	ULR-FE-0869-90828892	LAB-IN-EZF-99362	Barajas, Schroeder and Arnold	NABL/TC-1706/9654	Provisional	Karnataka		RPT-6462-293626	2022-06-16	SMP-HNY-92948676
785fe62e-fc19-4310-b42c-9ca7f8467b4d	ULR-UG-4791-93890580	LAB-IN-WFR-79256	Morgan Ltd	NABL/TC-7734/9381	Provisional	Himachal Pradesh		RPT-1905-998157	2023-06-10	SMP-HNY-65951684
948e8983-831c-4430-99df-e979c6f1fd9f	ULR-MP-8171-99191313	LAB-IN-QIF-90032	Smith, Lyons and Anderson	NABL/TC-9547/5525	Provisional	Uttar Pradesh		RPT-2403-825096	2021-12-19	SMP-HNY-11268459
6dca9be3-1e21-4f50-a4c2-62d492f42dcf	ULR-WZ-4848-68368689	LAB-IN-WRI-94891	Gonzales and Sons	NABL/TC-7908/2278	Active	Jammu and Kashmir		RPT-4794-685551	2021-12-09	SMP-HNY-58769009
41418811-3043-4475-8b6a-018e500c0405	ULR-WT-5921-28691209	LAB-IN-JCJ-61220	Ruiz-Roberts	NABL/TC-6142/5481	Expired	Tripura		RPT-7975-771343	2022-05-13	SMP-HNY-66235260
bbd796af-1759-4ccb-a9b9-09e6f166edb8	ULR-IM-4109-80379272	LAB-IN-FDW-51839	Jennings and Sons	NABL/TC-8164/6311	Withdrawn	Assam		RPT-8033-000308	2022-01-27	SMP-HNY-72179765
49c12032-647e-4ca0-957d-8af4120b144f	ULR-QD-0449-48588826	LAB-IN-UAI-09090	Bowman-Villegas	NABL/TC-7610/7846	Withdrawn	Uttar Pradesh		RPT-0708-207894	2023-08-31	SMP-HNY-91986389
aa7d66b0-4c82-4851-9ea4-da1cf3c9710d	ULR-ES-2699-01187006	LAB-IN-MLH-48015	Martin, Cohen and Watson	NABL/TC-1528/0370	Suspended	Delhi		RPT-0513-914066	2024-02-07	SMP-HNY-51533907
42c4de86-c2d8-455f-b207-8883b8f77066	ULR-IU-1334-93615141	LAB-IN-XQF-95805	Donovan-Roberts	NABL/TC-9806/7376	Suspended	Chandigarh		RPT-1499-435054	2026-04-13	SMP-HNY-23005638
ed571b4c-94a6-4cb3-9ec2-3681c16fb0c0	ULR-GY-9787-45904286	LAB-IN-MMW-01840	Moore Inc	NABL/TC-0613/9823	Provisional	Lakshadweep		RPT-1454-459669	2026-03-24	SMP-HNY-23956596
e9294377-0554-44f9-992f-b154d4d654c7	ULR-RL-0778-86794561	LAB-IN-OJW-36634	Lopez-Carlson	NABL/TC-7191/3283	Suspended	Andhra Pradesh		RPT-0454-580838	2023-10-11	SMP-HNY-80189129
42451886-90cd-4b01-8ed3-fdb732e93062	ULR-MJ-3178-87621417	LAB-IN-LFU-02634	Taylor Ltd	NABL/TC-7818/3679	Expired	Goa		RPT-4677-576629	2024-01-09	SMP-HNY-58912844
206cbf04-9024-47f9-8739-5c4f807d5f0b	ULR-JZ-8216-05763525	LAB-IN-DRL-14397	Lewis-Lewis	NABL/TC-3185/2189	Expired	Chhattisgarh		RPT-4220-829593	2021-09-25	SMP-HNY-22982462
744a67b2-1fd2-47c5-9b08-180107652048	ULR-JI-8303-95487063	LAB-IN-YPB-96797	Clay-Graves	NABL/TC-2889/7924	Provisional	Haryana		RPT-2759-243919	2022-05-16	SMP-HNY-73247172
b22ca7fd-9d2f-4464-9e9a-421ada265934	ULR-ZJ-7763-76673569	LAB-IN-HET-88589	Graham and Sons	NABL/TC-8611/7375	Suspended	Haryana		RPT-6510-822837	2022-05-09	SMP-HNY-06859446
e8a70695-b571-40c8-9965-74a98cf95425	ULR-LL-4919-81255141	LAB-IN-FKZ-43166	Turner-Martin	NABL/TC-9081/9150	Suspended	Goa		RPT-6342-268116	2023-03-06	SMP-HNY-73526098
1fcb44ff-3df5-4f2d-8b1b-737d5aa9965c	ULR-UV-7594-28703164	LAB-IN-VMQ-79089	Johnson, Richardson and Willis	NABL/TC-0052/9150	Withdrawn	Nagaland		RPT-5841-371833	2025-09-13	SMP-HNY-17906751
de69eac6-a3a7-42b0-b181-4b0aeecc9a26	ULR-NJ-7821-40767438	LAB-IN-DLH-83858	Bryant-Hopkins	NABL/TC-0878/3497	Withdrawn	Gujarat		RPT-2987-415509	2022-03-06	SMP-HNY-37789094
fbba59ac-a0d9-4d06-bb6b-5dfb8f0b49de	ULR-IA-4634-72376213	LAB-IN-OPQ-00974	Stone-Cruz	NABL/TC-6638/0292	Active	Assam		RPT-0626-812626	2025-04-30	SMP-HNY-43076077
34d12cd7-71ce-419f-aa12-2dcc2545ba16	ULR-RV-4894-93259295	LAB-IN-LLX-34960	Anderson Inc	NABL/TC-9758/1205	Withdrawn	Punjab		RPT-4303-350355	2024-10-06	SMP-HNY-08425478
dae9cc2f-93be-4d52-afb9-c4bbdcb02311	ULR-GK-9495-75357635	LAB-IN-TKL-10514	Shaw-George	NABL/TC-3606/8322	Withdrawn	Odisha		RPT-6748-010961	2022-10-10	SMP-HNY-94410865
c34cfbbc-0df0-49c8-ba18-c806409ccfc8	ULR-OZ-9894-38640798	LAB-IN-YYQ-55086	Roach-Smith	NABL/TC-5320/0425	Active	Kerala		RPT-6667-532826	2023-05-09	SMP-HNY-04177593
1dddb607-467b-485e-9993-bc13e0fad3c1	ULR-FM-0963-85606028	LAB-IN-FOH-36553	Jordan PLC	NABL/TC-5492/2904	Active	Odisha		RPT-7844-085605	2022-01-19	SMP-HNY-12502258
2a9fecae-e3b9-42e1-91ab-9aa065342e1f	ULR-NH-5901-31915267	LAB-IN-XHU-28005	Williamson-Austin	NABL/TC-0194/5352	Suspended	Ladakh		RPT-7735-575653	2022-02-06	SMP-HNY-32156094
6f2573e9-2a34-4d09-b4d2-ca36e1482a4b	ULR-QB-0150-72333285	LAB-IN-EDO-87330	Rodriguez-Garrett	NABL/TC-2528/2013	Expired	Assam		RPT-6398-854116	2021-09-18	SMP-HNY-55464912
5cf7b2b7-aa97-4b71-91f9-e60657d3125e	ULR-DQ-3665-11545655	LAB-IN-COU-15910	Booth and Sons	NABL/TC-4882/7432	Withdrawn	Uttarakhand		RPT-0076-422500	2024-01-10	SMP-HNY-65855297
8b1c0aa8-5d70-422c-b3fa-3cdc51e076be	ULR-CM-5564-26266086	LAB-IN-SZC-50550	Huerta Group	NABL/TC-5072/6754	Withdrawn	Telangana		RPT-4276-103388	2025-02-03	SMP-HNY-93543558
e0253eb5-c901-4e76-bf49-5b14b1d67324	ULR-MF-0608-44442583	LAB-IN-KWH-97467	Larson and Sons	NABL/TC-6187/7502	Provisional	Andhra Pradesh		RPT-8487-782348	2022-10-28	SMP-HNY-71350967
839ba1a2-b419-4ad9-8d78-05d04f105484	ULR-YJ-5132-63335844	LAB-IN-CEZ-97043	Petty-Santos	NABL/TC-6050/9768	Suspended	Tripura		RPT-6187-847342	2025-09-09	SMP-HNY-41087796
35a834e3-217a-4e44-ba5e-10381be42b97	ULR-TG-8110-40726274	LAB-IN-XDN-46284	Walters, Murphy and Holmes	NABL/TC-6919/6344	Active	Telangana		RPT-7585-875140	2024-06-29	SMP-HNY-57393409
898acde8-f289-459f-8085-d14d08dab6e3	ULR-UZ-3153-42666810	LAB-IN-HVZ-77646	Sharp, Hill and Romero	NABL/TC-2125/3067	Expired	Uttar Pradesh		RPT-9746-170330	2024-01-13	SMP-HNY-37730556
b7772c87-ee12-450a-974e-7752c6648be1	ULR-QK-1874-27841067	LAB-IN-FOK-30712	Smith-Gonzalez	NABL/TC-4535/3109	Provisional	Meghalaya		RPT-0604-000408	2024-07-19	SMP-HNY-98711011
59c14764-e060-48cc-9fda-74d47784e5ed	ULR-DU-8221-64803341	LAB-IN-WFG-63211	Lee-Mcguire	NABL/TC-7258/0409	Provisional	Bihar		RPT-3947-489522	2025-08-28	SMP-HNY-00327351
6e01e286-736f-46f3-b401-8934a477d8de	ULR-AI-9075-00459777	LAB-IN-TFF-89907	Alexander-Tran	NABL/TC-3882/8683	Provisional	Telangana		RPT-5742-908097	2021-11-22	SMP-HNY-99639234
ac402fc7-7fc3-47c8-b861-40eb1f90951a	ULR-JB-2569-46902632	LAB-IN-ISF-13063	Jackson-Roy	NABL/TC-5502/4727	Suspended	Maharashtra		RPT-5139-026469	2023-01-08	SMP-HNY-39735029
de60617e-d6ec-4b47-b199-478c48e4b330	ULR-SB-2647-86103741	LAB-IN-PHH-69616	Jones, Dorsey and Owens	NABL/TC-5368/9212	Withdrawn	Sikkim		RPT-6984-841554	2022-01-10	SMP-HNY-54431901
aa7bd641-39e5-4789-a841-7718ab47f3d3	ULR-SH-0055-67024402	LAB-IN-ZLE-63952	Sanders-Foster	NABL/TC-5696/9082	Active	Arunachal Pradesh		RPT-9410-503909	2022-10-02	SMP-HNY-08933628
18a730af-6e6a-488d-8d47-238f04be6f96	ULR-FB-8278-67630870	LAB-IN-ODL-93315	Hart-Hall	NABL/TC-8193/4207	Withdrawn	Chhattisgarh		RPT-6907-317695	2026-05-03	SMP-HNY-55970561
8cbe9ab6-2ffe-4213-b110-5f824ed038cc	ULR-ZH-4957-60388057	LAB-IN-GUS-26606	Anderson-Jimenez	NABL/TC-5594/5383	Suspended	Chandigarh		RPT-1528-852985	2023-07-16	SMP-HNY-92772251
2cc21729-b58a-45e3-b059-8e196c922ba6	ULR-RR-5513-28496707	LAB-IN-YTP-39085	Bell-Vega	NABL/TC-0017/7111	Active	West Bengal		RPT-9659-556161	2023-07-04	SMP-HNY-64777789
1f1920e5-e84d-458a-86a2-fea19ab48674	ULR-TT-9632-87572772	LAB-IN-JLS-48594	Clark, Rivera and Santana	NABL/TC-8065/3320	Withdrawn	Goa		RPT-4568-513326	2023-12-13	SMP-HNY-84645322
5d2dcf19-be4c-4124-99d3-eb69319b3be9	ULR-GE-9856-69195887	LAB-IN-BQP-92695	Baker Inc	NABL/TC-9567/1346	Expired	Goa		RPT-5630-463703	2025-12-08	SMP-HNY-09800966
e98f5cfb-2f57-4f58-8c7f-154bb3ad1976	ULR-FR-1483-70844219	LAB-IN-DBZ-23191	Wilkerson PLC	NABL/TC-0481/2844	Withdrawn	Telangana		RPT-5077-736365	2024-12-05	SMP-HNY-62597962
2f936809-6636-4e52-baf7-64b3edb582e0	ULR-CG-0906-45027456	LAB-IN-NWW-55439	Jordan PLC	NABL/TC-2965/4582	Withdrawn	Madhya Pradesh		RPT-8910-565980	2022-11-11	SMP-HNY-20146888
50555775-82ac-42db-a781-4e78ca95f166	ULR-US-1005-29616113	LAB-IN-IGS-38404	Johnston-Graham	NABL/TC-7567/5163	Suspended	Chandigarh		RPT-4671-499661	2022-12-24	SMP-HNY-79767690
98af89a2-92d1-41ce-b75c-ac176efb0bc5	ULR-ZK-5482-04154072	LAB-IN-VVB-26801	Carpenter Group	NABL/TC-2201/2539	Expired	Andaman and Nicobar Islands		RPT-6819-978822	2023-02-21	SMP-HNY-49009686
660dda2d-ca8d-462e-b881-367816815d0b	ULR-LR-0699-18048869	LAB-IN-BPL-29024	Dominguez-Cook	NABL/TC-8971/6440	Withdrawn	Himachal Pradesh		RPT-1465-777796	2025-04-05	SMP-HNY-29306820
84014426-ece5-44f5-a285-2db2e5de1cdd	ULR-JD-1399-82525776	LAB-IN-WOX-52775	Atkins-Brown	NABL/TC-9475/2692	Provisional	Jharkhand		RPT-7074-489920	2024-10-08	SMP-HNY-66660083
187c0f6d-eed4-4f50-8946-9cce4ca842f2	ULR-FT-2476-81260992	LAB-IN-VIX-85923	Wu Ltd	NABL/TC-6354/7930	Suspended	Tripura		RPT-1911-854554	2023-08-20	SMP-HNY-19561591
a3ff2fd0-5fe2-4722-b406-cf7b3f4fdf0a	ULR-TQ-2558-56374192	LAB-IN-BSS-16904	Larsen-Smith	NABL/TC-9172/9459	Withdrawn	Goa		RPT-3236-247548	2024-08-20	SMP-HNY-67456526
201d77ba-5d9e-44f6-86cf-ffc9cdc7b613	ULR-RK-9617-11019421	LAB-IN-GEI-83842	Bryant and Sons	NABL/TC-8134/0568	Suspended	Uttarakhand		RPT-9214-851324	2025-03-02	SMP-HNY-25679066
1aa174f5-2ba6-48fa-9b74-0ae57377e4de	ULR-ZP-1950-30712497	LAB-IN-JKM-38687	Kennedy, Mccoy and Harrington	NABL/TC-3800/6901	Provisional	Chandigarh		RPT-2021-614653	2023-07-30	SMP-HNY-53920898
597655f7-d705-480f-a257-f7c603d50b0e	ULR-AB-4491-05748377	LAB-IN-KJG-57314	Sullivan-Riley	NABL/TC-3614/9430	Withdrawn	Tamil Nadu		RPT-1981-855572	2023-01-12	SMP-HNY-29309268
c5f3bed2-09b4-4648-b8dd-fe41fd158b30	ULR-XQ-0441-65484674	LAB-IN-JNX-82486	Carr, Johnson and Black	NABL/TC-8344/3130	Suspended	Assam		RPT-1025-414321	2021-12-29	SMP-HNY-52163632
1714cc97-bcca-40ab-9b60-43e3042b846a	ULR-OZ-5852-99915782	LAB-IN-DVG-27681	Cook, Snyder and Jackson	NABL/TC-5002/7985	Expired	Tamil Nadu		RPT-3705-663684	2023-03-04	SMP-HNY-64410930
f650a232-16b0-4aa4-9915-3a40a13fd1ea	ULR-YM-5389-41043654	LAB-IN-PAW-32982	Graham LLC	NABL/TC-7403/4220	Suspended	Kerala		RPT-6283-912880	2025-01-10	SMP-HNY-02429943
a7ea544c-ee7c-40a0-90bf-1da9ffffcfed	ULR-HD-7120-84905024	LAB-IN-YOI-19250	Rice Ltd	NABL/TC-2151/8137	Active	Assam		RPT-4848-402211	2024-09-15	SMP-HNY-34319592
5a9c1a28-b565-4128-b25c-b35e8f1202ab	ULR-QN-4656-10461582	LAB-IN-MPZ-91259	Dean, Johnson and Gonzales	NABL/TC-6640/6457	Active	Himachal Pradesh		RPT-8783-723549	2026-03-02	SMP-HNY-85023345
723b7477-33a3-46dc-a366-9fd6d2e0513a	ULR-EA-1102-86452638	LAB-IN-XKX-45200	Stokes Group	NABL/TC-3241/1364	Withdrawn	Jharkhand		RPT-0310-968154	2025-08-11	SMP-HNY-92540573
0450b0dd-276e-472a-b99e-2afaeaf411db	ULR-KK-2089-15011932	LAB-IN-RYQ-67166	Willis-Bell	NABL/TC-4336/1193	Suspended	Himachal Pradesh		RPT-7670-091127	2025-02-08	SMP-HNY-53571349
475cdae5-42f6-4816-b54b-adee7afd3b73	ULR-WL-3937-79481800	LAB-IN-SLU-17445	Collins-Rowe	NABL/TC-2211/9705	Provisional	Lakshadweep		RPT-5964-532370	2024-05-03	SMP-HNY-60751619
836fa1fb-46a7-4e84-a133-56a365049727	ULR-FI-5979-33737438	LAB-IN-XZF-18677	Maldonado, Gray and Spencer	NABL/TC-2051/2925	Withdrawn	Sikkim		RPT-8953-803709	2026-02-10	SMP-HNY-49146151
632ffa29-3c6a-4388-a2ba-b2a30340b605	ULR-EH-1696-08244442	LAB-IN-TKX-04050	Macdonald-Cruz	NABL/TC-5950/4550	Expired	Assam		RPT-1754-941424	2022-10-05	SMP-HNY-09707772
dee06126-4dcd-4f83-ab69-ac767f169c65	ULR-ZS-7926-18612660	LAB-IN-HJM-90204	Lopez Ltd	NABL/TC-4280/8137	Expired	Sikkim		RPT-0468-041546	2024-11-02	SMP-HNY-44448516
13021a98-e5ff-4f87-903c-1bf2f7db6e4b	ULR-EH-3313-07781520	LAB-IN-XSP-04709	Wright, Savage and King	NABL/TC-8500/3296	Withdrawn	Punjab		RPT-9479-426296	2023-01-09	SMP-HNY-87830009
c64bf40c-d790-4534-b1b9-5d787537b3bd	ULR-HX-6450-73310594	LAB-IN-TEY-26632	Faulkner, Morgan and Morris	NABL/TC-2848/5001	Provisional	Delhi		RPT-6922-388055	2025-07-25	SMP-HNY-01911343
bdd56028-fd5c-4ef7-a330-27c379eb71b4	ULR-TH-0524-90564927	LAB-IN-ZEO-75547	Webb PLC	NABL/TC-7132/4323	Provisional	Assam		RPT-5581-924610	2023-01-23	SMP-HNY-60794992
c124c7cc-46ef-4195-9e5f-c8457dcf200d	ULR-QC-3105-05000905	LAB-IN-AVU-13297	Castillo, Hood and Bailey	NABL/TC-7912/8955	Withdrawn	Bihar		RPT-9950-493475	2025-06-20	SMP-HNY-42917769
dcfbbc7d-a760-4743-a7db-f6d963b4d776	ULR-XB-9623-22637634	LAB-IN-NVO-01625	Miller LLC	NABL/TC-2127/9166	Provisional	Mizoram		RPT-1595-437851	2024-05-26	SMP-HNY-05869727
e8a804bc-8cb6-4102-ae31-98b6838a5fd9	ULR-AK-0480-99065715	LAB-IN-QKB-98701	Sanchez PLC	NABL/TC-5469/6035	Active	Odisha		RPT-3694-170528	2024-10-19	SMP-HNY-87989278
e607c218-a0e8-40d0-a811-d05c56e40139	ULR-HM-0941-60940934	LAB-IN-PLS-10541	Cook and Sons	NABL/TC-1009/2580	Provisional	Tripura		RPT-3667-573562	2025-09-30	SMP-HNY-91989631
369bfe21-95a4-440d-b4d4-a8ec2b77fa1c	ULR-QI-3671-17296850	LAB-IN-DIQ-98533	Brown PLC	NABL/TC-3548/9532	Provisional	Jammu and Kashmir		RPT-2231-355276	2025-05-07	SMP-HNY-02416988
a136fb27-8852-4581-8acd-b5913a7531a5	ULR-NG-6768-17384700	LAB-IN-ELK-09542	Daniels, Farrell and Adams	NABL/TC-4087/8292	Suspended	Odisha		RPT-8656-260208	2026-03-17	SMP-HNY-12556534
df1ee30b-4399-46a5-8abf-96b9577ecd38	ULR-CO-9022-01531694	LAB-IN-RFC-18141	Ho, Pratt and Bauer	NABL/TC-7381/3996	Suspended	Meghalaya		RPT-8516-618388	2026-01-21	SMP-HNY-97519408
4a8dc4c2-efaf-4646-a494-0e40d1f51882	ULR-NW-2004-68690420	LAB-IN-TGE-37139	Michael, Estrada and Garrison	NABL/TC-7935/1557	Active	Haryana		RPT-0390-593219	2024-05-23	SMP-HNY-49507813
3312d798-45a7-4965-902f-fa04df3fe558	ULR-BS-6214-75234831	LAB-IN-NRR-77535	Berg-Perez	NABL/TC-2855/0672	Expired	Jharkhand		RPT-6943-977180	2026-03-31	SMP-HNY-66626656
8f54a6bc-4f4c-480c-94ee-03f45d02cffa	ULR-PZ-4374-76811784	LAB-IN-WBI-52205	Jones, Cook and Graham	NABL/TC-8619/2175	Withdrawn	Andaman and Nicobar Islands		RPT-7192-966201	2023-02-10	SMP-HNY-75132109
61e78838-b2a7-496c-8eed-1d16410135e7	ULR-CF-0227-00478225	LAB-IN-QYR-15684	Bradshaw LLC	NABL/TC-5639/6324	Withdrawn	Gujarat		RPT-3439-550173	2025-05-13	SMP-HNY-63096999
c9b5828c-8848-4234-95be-43fbba07cae5	ULR-BR-9856-06570789	LAB-IN-YQM-42389	Barry-Smith	NABL/TC-7551/9589	Withdrawn	West Bengal		RPT-7290-780006	2026-02-14	SMP-HNY-76332832
bae35732-cc62-4255-80e6-dd373a9f14f8	ULR-YJ-3978-96466622	LAB-IN-PSB-54070	Mack LLC	NABL/TC-2304/6168	Withdrawn	West Bengal		RPT-8185-795164	2022-05-17	SMP-HNY-46612402
0ca7b3ca-25d4-4ff1-8cd0-86979addb12a	ULR-EU-9505-57006563	LAB-IN-YCO-08501	Braun, Gay and Gray	NABL/TC-1930/6985	Suspended	Chhattisgarh		RPT-7735-896868	2025-12-18	SMP-HNY-00401045
3738b381-1568-4f01-bade-eec94c2a7a67	ULR-WT-0454-74861063	LAB-IN-KFW-56132	Lang, Stanley and Nelson	NABL/TC-3642/9172	Expired	West Bengal		RPT-5754-524973	2023-08-27	SMP-HNY-36258571
932c53ad-c62f-4c75-9b7b-627b6a8fc2e1	ULR-LH-4261-05363935	LAB-IN-LSP-39444	Kerr-Castaneda	NABL/TC-8978/5039	Active	Meghalaya		RPT-4236-766511	2024-12-15	SMP-HNY-89311368
71563da2-ff39-4de1-a9bb-6c0af3a23381	ULR-FG-5225-69319165	LAB-IN-WNS-54405	Rodriguez PLC	NABL/TC-5739/7402	Provisional	Nagaland		RPT-5004-641319	2026-01-14	SMP-HNY-57947720
80f5ee0f-3c2d-4b64-bc68-9680124ba094	ULR-RH-0204-87770590	LAB-IN-OKI-36036	Henry LLC	NABL/TC-9886/5373	Provisional	Tripura		RPT-8666-803861	2023-07-20	SMP-HNY-17463843
3cb7ba38-ee5b-47fe-a9f1-d7f3fdc61089	ULR-HR-5420-38823004	LAB-IN-YPL-96398	Craig Inc	NABL/TC-0778/2128	Expired	Arunachal Pradesh		RPT-3295-700760	2024-02-08	SMP-HNY-33364373
f720251e-6ba8-4295-b579-d6435667a6c6	ULR-AH-9318-11909459	LAB-IN-QIQ-12655	Lane Group	NABL/TC-4197/5967	Withdrawn	Arunachal Pradesh		RPT-0961-919111	2025-05-12	SMP-HNY-95756747
bce56d5b-acc7-473b-b5d7-2d15f2419ac5	ULR-NN-5405-62224333	LAB-IN-WMB-81360	Henderson-Davidson	NABL/TC-6500/5984	Withdrawn	Maharashtra		RPT-9373-596655	2023-06-15	SMP-HNY-44024255
893aa967-bbde-4079-aaf7-74ffd7e59b7f	ULR-QP-5861-12783021	LAB-IN-TBZ-02623	Franklin-Coleman	NABL/TC-1648/2830	Expired	Arunachal Pradesh		RPT-9378-241098	2025-01-12	SMP-HNY-28475461
bdb122e7-a062-44ef-aa46-058f7f152adf	ULR-RU-3423-66972221	LAB-IN-ALZ-32816	Barber-Spencer	NABL/TC-8574/5960	Suspended	Chandigarh		RPT-8864-372364	2021-12-07	SMP-HNY-25980669
e5497a4f-0ec2-4d26-b821-8abc79be06ce	ULR-DX-4565-90869784	LAB-IN-SLK-83136	Grimes-Adams	NABL/TC-7044/7462	Active	Assam		RPT-4810-260648	2024-11-28	SMP-HNY-08960012
3627d2f4-783a-4859-a9ff-e6432173f9d6	ULR-AF-2933-39447056	LAB-IN-YPV-00782	Welch-Bush	NABL/TC-6675/1766	Suspended	Ladakh		RPT-4996-742294	2023-03-06	SMP-HNY-89564396
d1f005f9-8e31-43a1-b4ea-f921def30303	ULR-KF-6565-68347187	LAB-IN-XSI-42969	Nichols PLC	NABL/TC-6774/4390	Expired	Uttar Pradesh		RPT-7805-657117	2025-01-18	SMP-HNY-62626677
cb1adb6e-4ed6-4a09-afe1-cb176314d78b	ULR-DO-4424-00054038	LAB-IN-CWE-61381	Brown, Jensen and Castillo	NABL/TC-5617/1482	Suspended	Lakshadweep		RPT-0147-627961	2023-03-28	SMP-HNY-75195732
2dd6288e-a866-467b-ada0-9b8fff23b032	ULR-PL-8452-31216883	LAB-IN-AJQ-31094	Berg-Rojas	NABL/TC-9792/4775	Withdrawn	Tripura		RPT-6796-262653	2025-07-01	SMP-HNY-11131485
df1049dc-de15-431e-8886-472a5e8eac9f	ULR-NY-1440-73689501	LAB-IN-CRS-91019	Williams-Mendoza	NABL/TC-3001/9631	Provisional	Ladakh		RPT-7409-638091	2021-10-04	SMP-HNY-47711286
22974298-ed82-4a28-b19e-f3365f681a64	ULR-PM-6163-54314780	LAB-IN-GUS-79352	Miller, Alexander and Perez	NABL/TC-0527/2889	Provisional	Arunachal Pradesh		RPT-4056-429112	2024-04-23	SMP-HNY-97716379
d7091043-d5fb-4d1b-b060-d1c3dae8e0e4	ULR-OR-5952-74044398	LAB-IN-HIM-42630	Quinn-Watson	NABL/TC-1128/4154	Suspended	Ladakh		RPT-5463-720561	2022-09-21	SMP-HNY-93021826
f56c9f8c-dc6e-46ff-a358-6f9bd0b316dc	ULR-QO-3419-05612987	LAB-IN-IMT-19991	Garcia, Torres and Monroe	NABL/TC-0751/7551	Expired	Goa		RPT-4302-510153	2025-08-14	SMP-HNY-85116862
c72704c0-daec-4c0e-b942-3906bc964afc	ULR-KV-5931-35230833	LAB-IN-CIF-89844	Hamilton, Hicks and Vega	NABL/TC-5888/0755	Active	Karnataka		RPT-5157-419363	2023-03-24	SMP-HNY-91783247
e132d235-6af1-4c92-8880-c96a8dcceaec	ULR-JI-0000-84625159	LAB-IN-FRL-76529	Best, Kline and Jordan	NABL/TC-5453/7647	Active	Chhattisgarh		RPT-4488-407808	2023-12-07	SMP-HNY-23774818
31807edb-fdac-460f-a648-d4ab679ca812	ULR-AH-7940-31088005	LAB-IN-SMV-55365	Morris and Sons	NABL/TC-4889/3398	Expired	Kerala		RPT-6531-825174	2024-07-06	SMP-HNY-70012253
69c8a307-f9fb-403c-9dfc-6c64091ade43	ULR-II-8137-84838359	LAB-IN-ZUD-24520	Jones, Silva and Wilson	NABL/TC-8259/3845	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-6311-197534	2021-12-25	SMP-HNY-63888827
99d876ad-8726-423f-8958-da00c898a9a6	ULR-PW-5182-90355977	LAB-IN-FKE-36264	Grimes, Heath and Smith	NABL/TC-5000/9123	Active	Telangana		RPT-8702-897757	2021-12-12	SMP-HNY-78388884
a42746c8-3c7a-4391-8f14-2370206e1819	ULR-GW-0579-39183044	LAB-IN-AYO-29121	Smith LLC	NABL/TC-3410/0455	Active	Tripura		RPT-6454-562240	2026-07-25	SMP-HNY-93900408
76227c08-07e4-4fac-bdcd-c3f8a53b3d38	ULR-SG-3209-39600092	LAB-IN-CCT-81206	Flowers-Anderson	NABL/TC-6310/7848	Expired	Ladakh		RPT-2941-332991	2024-08-16	SMP-HNY-25915715
eefd29f7-61cf-4daa-8ebd-7f13c88f0db7	ULR-LN-7662-18301420	LAB-IN-ADI-40460	Barry, George and King	NABL/TC-0502/9654	Provisional	Dadra and Nagar Haveli and Daman and Diu		RPT-5762-771031	2026-05-09	SMP-HNY-29252381
97928712-412e-4080-9908-f9af112b59d5	ULR-YA-2001-19298387	LAB-IN-QWX-78065	Martin-Stephens	NABL/TC-9023/0045	Provisional	Kerala		RPT-1915-331364	2026-02-11	SMP-HNY-22288234
6711822d-f5cf-4251-a3c6-5685e61842f7	ULR-VY-3437-87436610	LAB-IN-VEN-85984	Paul Inc	NABL/TC-5133/9354	Suspended	Gujarat		RPT-6203-138796	2025-09-08	SMP-HNY-93150096
ac924bf4-c5e2-4657-a3db-3d67cc312e3d	ULR-MG-3268-29698860	LAB-IN-BCZ-36301	Strickland-Ibarra	NABL/TC-2469/1706	Provisional	Tripura		RPT-6083-876407	2021-12-25	SMP-HNY-89999523
8dd31289-0e76-4904-aa57-271759ec25ee	ULR-WV-6737-03834839	LAB-IN-YSM-43322	Johnson PLC	NABL/TC-7159/6936	Expired	Odisha		RPT-6487-467977	2021-10-22	SMP-HNY-18623439
359ecf55-31ec-488f-b86d-1cc5b3f334ff	ULR-OG-4803-60468358	LAB-IN-ZYU-16598	Dunn, Moon and Schneider	NABL/TC-0268/4445	Expired	Chandigarh		RPT-5715-782440	2023-12-11	SMP-HNY-47847768
68232ac9-27cd-462f-815c-175cf2ee7ea5	ULR-GQ-4501-17384078	LAB-IN-GFB-08773	Hernandez, Smith and Munoz	NABL/TC-3063/5235	Withdrawn	Telangana		RPT-4935-131966	2025-02-27	SMP-HNY-05821702
1245b503-6cd2-4910-bf33-7711247b5e78	ULR-QK-4537-71648327	LAB-IN-RAO-03811	Cunningham and Sons	NABL/TC-2389/5962	Provisional	West Bengal		RPT-6242-172866	2026-03-17	SMP-HNY-34079061
e40994dd-9079-4bd6-bd04-5f9bde2d8aad	ULR-AZ-9989-95366069	LAB-IN-MZA-25643	Daniels-Klein	NABL/TC-9318/8673	Provisional	Gujarat		RPT-6168-964204	2022-02-15	SMP-HNY-59654121
163f97ae-b712-4e7c-951f-5c59cedd2f0b	ULR-XK-6311-99496020	LAB-IN-PUT-78044	Williams Inc	NABL/TC-6602/3025	Provisional	Uttar Pradesh		RPT-4030-621304	2026-06-02	SMP-HNY-34559688
a38f26be-f791-431e-91c8-22ff8f3cde26	ULR-YB-8652-43953887	LAB-IN-AJJ-32567	Morgan Inc	NABL/TC-8204/0009	Suspended	Chhattisgarh		RPT-9158-434687	2022-02-18	SMP-HNY-12599539
3bdb3460-a1c6-44e9-ae03-cddf5cf485f6	ULR-JA-7758-26269829	LAB-IN-EGM-60061	Thomas, Wade and Chandler	NABL/TC-8309/4812	Provisional	Andhra Pradesh		RPT-5034-301090	2022-10-26	SMP-HNY-32068112
6b6a110e-d40d-4459-b816-3277ea926cae	ULR-AS-9030-55478459	LAB-IN-ONK-68682	Cole, Diaz and Huffman	NABL/TC-9520/4908	Suspended	Sikkim		RPT-5436-826525	2022-05-31	SMP-HNY-77125297
1e5417c4-92ba-4f37-9bad-947c2c9e87b9	ULR-DD-7579-11331292	LAB-IN-WIP-55773	Martin, Lee and Hall	NABL/TC-1133/4976	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-3098-526485	2024-08-29	SMP-HNY-83017059
ae7bb15a-156a-4f04-9c28-c12baf9211f1	ULR-AV-0698-91672139	LAB-IN-KUK-85183	Smith-Morales	NABL/TC-2897/8323	Expired	Bihar		RPT-6549-293734	2024-12-19	SMP-HNY-36732609
5ba8f5b2-05ad-4042-861f-09b9dbbd06e8	ULR-GV-4719-25005524	LAB-IN-TIY-85991	Baker, West and Dean	NABL/TC-2706/0935	Suspended	Delhi		RPT-5436-115727	2024-03-28	SMP-HNY-87044470
a0088df6-4164-40c6-85a2-548bd59fd6d4	ULR-VS-5294-05099590	LAB-IN-KSR-96006	Elliott Group	NABL/TC-4185/1837	Withdrawn	Nagaland		RPT-8061-849648	2024-09-30	SMP-HNY-82115793
1b66724c-f7ab-4445-9af3-f38d4795db3d	ULR-QA-8948-35607874	LAB-IN-VVZ-83977	Frederick-Walters	NABL/TC-1281/1530	Expired	Kerala		RPT-4329-424331	2026-01-20	SMP-HNY-13638749
9df23023-56b6-4859-b4e4-ef19b181571b	ULR-ZK-6717-35556832	LAB-IN-ZIF-20976	Zimmerman, Parker and Simmons	NABL/TC-1522/2629	Withdrawn	Karnataka		RPT-7682-346674	2026-06-09	SMP-HNY-06114961
3964c483-b24b-49d3-bbe2-7cd96752d258	ULR-LC-6047-34648272	LAB-IN-HIS-74488	Cox Group	NABL/TC-0427/3186	Withdrawn	Arunachal Pradesh		RPT-9301-291908	2023-10-08	SMP-HNY-84145827
b1ec7005-73b4-460e-8cf3-8b0556d7c3ea	ULR-LY-9391-52046192	LAB-IN-FSW-90195	Mclean Ltd	NABL/TC-9936/1073	Expired	Odisha		RPT-2401-957019	2023-02-07	SMP-HNY-14067893
25f75523-84ca-4c5b-bd23-e84868d50761	ULR-VH-1412-00431427	LAB-IN-PMC-15569	Riley, Payne and Hoover	NABL/TC-1301/6921	Provisional	Lakshadweep		RPT-7709-624065	2024-01-15	SMP-HNY-42630785
381a421e-5178-4939-a74e-60a27eaf7028	ULR-CE-0473-01384285	LAB-IN-QTX-01853	Johnson-Koch	NABL/TC-9570/3155	Expired	Andaman and Nicobar Islands		RPT-4685-225109	2022-03-29	SMP-HNY-46881285
0653ec6f-154e-4709-a835-ead5badb5f03	ULR-IU-3939-56396327	LAB-IN-INF-86895	Waters LLC	NABL/TC-8840/7973	Provisional	Odisha		RPT-9667-327862	2024-02-15	SMP-HNY-49375786
8972189f-623b-42fd-b6d4-b53d8f0c0b48	ULR-IM-5958-36008008	LAB-IN-LXI-33613	Drake Ltd	NABL/TC-1801/0537	Active	Madhya Pradesh		RPT-7838-559147	2025-01-22	SMP-HNY-25452256
5b8351a5-86a6-490f-805d-33e3318912ac	ULR-TS-9456-18806166	LAB-IN-DDZ-78025	Foster-Carter	NABL/TC-8404/8616	Expired	Andhra Pradesh		RPT-0175-199401	2024-09-23	SMP-HNY-23398926
84605639-ad74-4e4b-b6bc-1a0a978af01a	ULR-FU-8276-94435257	LAB-IN-FJA-64835	Vincent, Montgomery and Brown	NABL/TC-8072/3311	Active	Uttar Pradesh		RPT-9129-354448	2024-01-16	SMP-HNY-34233968
fcfe607c-5670-4068-bd66-0750b5ff8771	ULR-VI-0997-34125767	LAB-IN-HEJ-60904	Hodges Ltd	NABL/TC-2251/9774	Withdrawn	Odisha		RPT-8185-459093	2023-08-05	SMP-HNY-71595208
c882bccc-f3b8-4530-976e-345edbac7c4c	ULR-NC-6966-83395606	LAB-IN-HUK-41734	Thompson-Mccoy	NABL/TC-1989/3532	Suspended	Odisha		RPT-2261-635765	2025-09-23	SMP-HNY-49878322
0fae2b3e-c65c-490d-af8e-d906fb93092f	ULR-KF-9201-44004144	LAB-IN-BRU-63123	Perry Ltd	NABL/TC-5958/2968	Withdrawn	Nagaland		RPT-2217-666907	2023-05-13	SMP-HNY-65973330
2ca28fa3-0fb1-49a2-95e0-89259d1002cd	ULR-QP-6108-40983725	LAB-IN-OHS-45037	Williams, Gutierrez and Hill	NABL/TC-9216/0121	Expired	Bihar		RPT-5815-542849	2025-05-05	SMP-HNY-67912500
9f033678-0a61-4557-90b9-63363276ce54	ULR-PR-1035-65265969	LAB-IN-BMI-07807	Stafford-Williams	NABL/TC-3853/0458	Suspended	Assam		RPT-1627-660256	2024-05-02	SMP-HNY-41365054
8bd04b0e-1c61-49af-909c-1b7d6d2ff3af	ULR-EX-4420-37810656	LAB-IN-RKS-37388	Evans, Arellano and Bryant	NABL/TC-2530/5814	Withdrawn	Mizoram		RPT-3874-190468	2023-11-25	SMP-HNY-70790413
6b05709a-a16e-4869-9ef1-104b6176eab1	ULR-DV-6363-60475366	LAB-IN-IDC-46963	Dalton Ltd	NABL/TC-5053/8429	Suspended	Andaman and Nicobar Islands		RPT-7318-796519	2025-11-25	SMP-HNY-34036806
0b926688-166e-434f-be5a-9868876322ae	ULR-YE-4392-96991966	LAB-IN-XOD-97047	Thompson, Beck and Reyes	NABL/TC-6537/1359	Provisional	Mizoram		RPT-0430-969942	2023-03-05	SMP-HNY-08606851
56e98010-49d2-43a3-aba3-55c56d0031f6	ULR-MU-0130-89365414	LAB-IN-WLX-53558	Hickman PLC	NABL/TC-5471/6178	Expired	Gujarat		RPT-5986-510697	2022-04-13	SMP-HNY-25284859
ba4f1412-234e-4038-8420-3bff38b79242	ULR-MQ-0914-98074244	LAB-IN-INI-93698	Howell-Mooney	NABL/TC-7275/0327	Active	Karnataka		RPT-6727-303291	2023-01-07	SMP-HNY-74885681
66de714e-cd87-4078-984f-9fd797b6911d	ULR-HA-6770-08861557	LAB-IN-ZCU-71916	Johnson, Turner and Stone	NABL/TC-0406/9187	Expired	Telangana		RPT-1373-274340	2023-02-21	SMP-HNY-39518484
82f887f8-d2e5-416b-83ca-5532d14d234b	ULR-SR-9490-84553240	LAB-IN-XZX-77443	Poole-Walker	NABL/TC-9334/8296	Expired	Andhra Pradesh		RPT-3750-983970	2025-05-11	SMP-HNY-97139062
6bc072d8-70ba-483f-9053-e6a0010bf38c	ULR-ZG-3312-05076588	LAB-IN-YTN-57477	Cannon Ltd	NABL/TC-9554/8153	Withdrawn	West Bengal		RPT-1345-255017	2022-05-17	SMP-HNY-11185495
4be8b91c-d28c-49bd-a394-f8fabed8458a	ULR-WO-4712-25916926	LAB-IN-VGZ-85012	Smith-Sampson	NABL/TC-1732/5189	Provisional	Uttar Pradesh		RPT-6845-086397	2024-01-10	SMP-HNY-68233213
5a9a04d3-26e9-4923-ad67-a7266546a3de	ULR-FG-4950-64988154	LAB-IN-QAW-25075	Moreno, Jones and Jimenez	NABL/TC-7548/2953	Withdrawn	Uttarakhand		RPT-0310-880535	2026-05-05	SMP-HNY-81347338
51e08819-8819-4f38-8212-c722148c596e	ULR-GF-5980-16277136	LAB-IN-YSL-74322	Stafford, Johnson and Castillo	NABL/TC-0877/4359	Active	Jammu and Kashmir		RPT-7458-667924	2026-05-31	SMP-HNY-08099372
44f293e3-fb1b-4ab9-a9de-07e4a11b1d49	ULR-GW-3094-71950960	LAB-IN-ZBW-37140	Humphrey-Howe	NABL/TC-6681/9090	Suspended	West Bengal		RPT-2928-139784	2021-12-21	SMP-HNY-09267998
f93eb6dc-4c05-4f42-a1bd-f28bcf47f4d4	ULR-NT-0285-51740347	LAB-IN-FDO-92359	Lowe, Holt and Mack	NABL/TC-1306/7151	Active	Gujarat		RPT-3848-937142	2022-02-27	SMP-HNY-19068988
2de106cc-b57b-475b-8708-0bd46472cb25	ULR-BC-6206-32709320	LAB-IN-DAK-70697	Hampton and Sons	NABL/TC-9240/1671	Provisional	Nagaland		RPT-1412-048577	2024-09-27	SMP-HNY-24747374
8eadbc50-79a1-4a8a-af90-0db9fdb02f3e	ULR-IM-9147-57364931	LAB-IN-BXT-08125	Little Inc	NABL/TC-7479/2901	Suspended	Jharkhand		RPT-4235-741678	2022-10-24	SMP-HNY-89786831
d80fbcbc-5433-49d7-ad3f-2ff33e672cee	ULR-XM-4674-68160063	LAB-IN-VLS-87162	Meyers, Lawrence and Mendoza	NABL/TC-9568/1577	Expired	Andhra Pradesh		RPT-7740-667694	2024-01-05	SMP-HNY-55048760
d403e448-8570-4aee-a262-804fc9ad0b75	ULR-JP-5263-74978667	LAB-IN-QCY-66535	Powell Ltd	NABL/TC-7936/6011	Suspended	Tripura		RPT-1554-541602	2024-03-20	SMP-HNY-54586025
11f5a866-b166-43c4-9a23-5b34a9f46f0f	ULR-AM-1442-15977908	LAB-IN-ZLH-23409	West and Sons	NABL/TC-5836/0332	Suspended	Andaman and Nicobar Islands		RPT-9118-500243	2021-10-24	SMP-HNY-97517009
3a9cbefc-b6f4-4b4c-909a-ced71594dfb6	ULR-KV-1249-19009446	LAB-IN-TGS-39486	Tucker, Smith and Griffin	NABL/TC-6164/3582	Expired	Lakshadweep		RPT-2146-444755	2024-10-16	SMP-HNY-30536954
3da77d4a-e1ff-4053-88eb-f70c42638c4b	ULR-WD-7428-68452743	LAB-IN-GGR-21554	Rojas Ltd	NABL/TC-3904/1673	Expired	Chandigarh		RPT-9952-323264	2025-02-11	SMP-HNY-24020700
f00ad1db-0a04-4fc2-8e0f-f0ec0d51d382	ULR-TW-0016-52417250	LAB-IN-FGH-26601	Walker, Little and Gonzalez	NABL/TC-1553/0364	Withdrawn	Karnataka		RPT-7334-237786	2023-04-10	SMP-HNY-25823213
d0771e3a-641c-40d5-bd2c-9ff63cd31a05	ULR-HS-5920-65523391	LAB-IN-AYG-96087	Stanley Inc	NABL/TC-0670/4381	Provisional	Maharashtra		RPT-9885-865024	2025-11-13	SMP-HNY-20719977
7869fcea-b800-43e5-84bd-d7ae35af1ebd	ULR-IA-9402-33472269	LAB-IN-HYD-53732	Smith, Rivera and Garcia	NABL/TC-2378/0958	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-8965-624003	2022-02-06	SMP-HNY-57158684
8bfd3e71-6d9e-423f-9a9d-382852fcf22b	ULR-ZU-7149-64359565	LAB-IN-OKQ-47889	Johnson Ltd	NABL/TC-5439/3714	Active	Delhi		RPT-9990-092488	2021-11-09	SMP-HNY-26355682
9eb9756b-6c84-4874-b062-d48c079e1492	ULR-OA-4006-75990731	LAB-IN-FTR-16983	Delgado Group	NABL/TC-0044/5178	Expired	Nagaland		RPT-7472-629029	2024-04-11	SMP-HNY-96872487
6fb831e1-572e-443e-9879-7865761b6171	ULR-QU-6803-15677259	LAB-IN-RQG-74293	Carlson Ltd	NABL/TC-3085/4103	Active	Goa		RPT-5370-440061	2024-05-10	SMP-HNY-11375452
95bd7eab-de24-4a09-8692-702bac8c45a4	ULR-YK-4465-68830300	LAB-IN-IKW-65638	Sandoval and Sons	NABL/TC-8106/3361	Provisional	Assam		RPT-2109-681296	2025-02-27	SMP-HNY-77930486
815a94e5-98ca-4dbb-a150-cba199627cd6	ULR-BE-0008-61304946	LAB-IN-BOH-80361	Jimenez-Young	NABL/TC-1079/6436	Suspended	Puducherry		RPT-7574-690684	2021-12-24	SMP-HNY-95721337
4893820e-f714-4f0c-a5f5-98f556b382b6	ULR-TN-2169-35584960	LAB-IN-NCJ-98297	Cobb, Henderson and Mcintosh	NABL/TC-5464/9603	Withdrawn	Maharashtra		RPT-9710-935362	2022-04-25	SMP-HNY-51906547
d3a09001-584b-497e-a4d2-7ae75a438eba	ULR-VV-5036-92889263	LAB-IN-TUM-13390	Smith, Alvarado and Kemp	NABL/TC-4772/9471	Active	Tamil Nadu		RPT-6355-299329	2026-03-01	SMP-HNY-65920745
c49eb1f8-458f-4fec-be68-becce96c77e0	ULR-OE-9792-00419068	LAB-IN-OPB-98284	Henry-Kim	NABL/TC-3776/4986	Provisional	Madhya Pradesh		RPT-5969-457385	2021-09-17	SMP-HNY-78880623
4d170117-308c-4e90-9955-5ce374069a92	ULR-BY-6928-38282560	LAB-IN-EFM-17781	Fox PLC	NABL/TC-0625/4668	Withdrawn	Ladakh		RPT-3841-085721	2021-12-03	SMP-HNY-63115179
ca6e3e33-55dd-4710-9208-f7d56b4adbff	ULR-XC-2697-40432296	LAB-IN-UMG-00071	Frye, Parker and James	NABL/TC-3257/1905	Provisional	Andhra Pradesh		RPT-2036-984330	2023-11-23	SMP-HNY-57146521
d2ec4d91-a050-4678-ab3e-e390ac278000	ULR-DK-5746-73082756	LAB-IN-RVZ-77756	Avila Ltd	NABL/TC-5460/1770	Withdrawn	Andaman and Nicobar Islands		RPT-0126-532569	2026-02-15	SMP-HNY-67569107
82237cda-4b1f-4b00-8548-434aecb55033	ULR-GC-9855-68673091	LAB-IN-VWK-16509	Howard-Carter	NABL/TC-0437/7635	Provisional	Tamil Nadu		RPT-5106-628796	2022-10-04	SMP-HNY-31723650
3640bf04-8344-47cf-88bd-4fcbfbfc3c9d	ULR-WD-2645-08343628	LAB-IN-XGD-91679	Hurley, Bradshaw and Sosa	NABL/TC-7711/2282	Active	Kerala		RPT-0928-436032	2023-10-24	SMP-HNY-42146533
7cb3d9eb-e5d9-4af3-bdef-8f1f2240fec6	ULR-RV-0672-72606937	LAB-IN-AMU-28166	Bennett-Murphy	NABL/TC-7937/9944	Suspended	Bihar		RPT-9486-872213	2021-11-25	SMP-HNY-66014376
05e730b5-89f3-4b62-8666-433ab0c88b4c	ULR-AJ-7643-42759613	LAB-IN-HTV-09447	Mckenzie PLC	NABL/TC-0197/3865	Provisional	West Bengal		RPT-3797-560359	2023-09-12	SMP-HNY-63477090
7a340a61-fce9-458b-a252-f501b09c1a60	ULR-WA-0809-88828037	LAB-IN-DBS-45012	Hebert-Powell	NABL/TC-5000/8334	Suspended	Ladakh		RPT-2540-819273	2026-08-04	SMP-HNY-03210127
dd43235e-e42b-4592-87ac-d968beac5071	ULR-WL-0284-92995944	LAB-IN-DUM-52718	West-Chavez	NABL/TC-7223/0480	Withdrawn	Andaman and Nicobar Islands		RPT-1456-551472	2024-01-08	SMP-HNY-11605385
2f53f9f0-8c55-4c6a-a5fe-4f8b10e82ceb	ULR-OU-7931-44381885	LAB-IN-SMA-44330	Edwards Group	NABL/TC-0725/5614	Active	Delhi		RPT-4277-580275	2023-10-29	SMP-HNY-50516856
36e1db42-0a3b-42c8-bfea-c4cc42bb33ef	ULR-NT-0416-85628404	LAB-IN-OBO-47169	Dorsey, Zuniga and Kelly	NABL/TC-6247/1814	Active	Uttarakhand		RPT-6031-821038	2022-02-14	SMP-HNY-94885875
53f92508-8649-47db-9c6e-6016186275e1	ULR-AY-0198-50178454	LAB-IN-JKD-11048	Cox, Holland and Henry	NABL/TC-1029/4757	Active	Uttar Pradesh		RPT-4686-547817	2022-07-31	SMP-HNY-71124692
f61eab96-c6e6-4b33-9d8f-22b7d1b08f41	ULR-AT-7414-32361411	LAB-IN-FYK-40481	Perry-Ali	NABL/TC-1148/4456	Withdrawn	Arunachal Pradesh		RPT-2566-265769	2025-10-30	SMP-HNY-07578328
c9bd15e0-6b05-415b-9510-38c4acbb1aec	ULR-AE-6370-35513687	LAB-IN-FZU-51753	Le, Sexton and Johnson	NABL/TC-7419/1340	Provisional	Meghalaya		RPT-9158-432050	2025-11-25	SMP-HNY-71147473
2409127e-4d10-418d-8107-efbffc470bcb	ULR-CC-6671-03566726	LAB-IN-QOW-32736	Weber-Abbott	NABL/TC-3746/6223	Suspended	Gujarat		RPT-9366-640529	2026-06-24	SMP-HNY-97906357
81ffde78-0382-43ed-aae6-00edcac3792d	ULR-KX-5701-53340736	LAB-IN-WAS-34788	Sheppard, Bailey and Gardner	NABL/TC-1270/9988	Withdrawn	Himachal Pradesh		RPT-9072-993175	2022-06-11	SMP-HNY-50129496
a49dfedd-e5e6-47fd-8502-d5a962ceb4a7	ULR-PD-7526-36722282	LAB-IN-FVZ-54157	Fritz-Sullivan	NABL/TC-7837/7379	Expired	Arunachal Pradesh		RPT-4695-481534	2023-09-12	SMP-HNY-70572750
0b11042e-cbd1-41ea-a182-72ffffd8b051	ULR-OD-8784-22789798	LAB-IN-YRL-96406	Duran-Zimmerman	NABL/TC-0344/9466	Expired	Rajasthan		RPT-4250-178095	2022-10-05	SMP-HNY-16754551
d61f742c-23e6-4a66-9c7f-e6b6ec2f7872	ULR-XP-2210-03608808	LAB-IN-NIW-90297	Howard, Phillips and Franklin	NABL/TC-2650/9131	Withdrawn	Assam		RPT-0593-981979	2023-10-19	SMP-HNY-64359080
918936d4-e025-45aa-bba3-635f0ecc0fcb	ULR-DE-6481-41456040	LAB-IN-LSE-88940	Collins Inc	NABL/TC-6294/1340	Active	Dadra and Nagar Haveli and Daman and Diu		RPT-0562-050640	2026-04-07	SMP-HNY-06794054
466419b5-2628-4a4c-b923-f4c4b0ee0d5a	ULR-RV-7846-08565704	LAB-IN-JQF-62990	Johnson-Thomas	NABL/TC-9354/7468	Active	Karnataka		RPT-6732-595710	2022-05-28	SMP-HNY-15658242
749fac26-cbce-425c-b29a-0732f4b440b7	ULR-AQ-3622-63862453	LAB-IN-YEC-49292	Ponce, Hall and Rodriguez	NABL/TC-1563/7909	Suspended	Arunachal Pradesh		RPT-8197-165673	2026-07-29	SMP-HNY-41862254
e12c39f1-5057-4db1-a931-5ead91a26683	ULR-VS-8718-49242010	LAB-IN-CCV-41777	Gomez-Ortiz	NABL/TC-3389/6340	Withdrawn	Jammu and Kashmir		RPT-6461-291259	2023-12-02	SMP-HNY-19516066
7befb29c-fd3d-4930-9b19-4a22a2587592	ULR-LT-5429-39019969	LAB-IN-VRT-73673	Wilson-Hartman	NABL/TC-4985/8350	Provisional	Jharkhand		RPT-1118-188341	2025-09-14	SMP-HNY-63498356
cbe2ec33-3265-4e73-9e30-793b48f6c340	ULR-VE-9438-73465629	LAB-IN-IXC-46815	Lamb PLC	NABL/TC-5403/7711	Expired	Uttarakhand		RPT-6633-317667	2022-04-03	SMP-HNY-38824573
2f7ec87c-f50e-4eb7-9af0-20d75c254fec	ULR-XU-5563-31959984	LAB-IN-IKN-83409	Cook-Davis	NABL/TC-5723/4462	Provisional	Uttarakhand		RPT-1882-280220	2023-12-15	SMP-HNY-28290723
44278209-ec1a-4614-9a3b-fbd454429d48	ULR-ZR-4476-67732704	LAB-IN-YQM-59529	Davis, Smith and Norman	NABL/TC-6816/2704	Active	Goa		RPT-4701-340160	2023-07-03	SMP-HNY-95961784
f27656cf-d235-4ab6-9bd6-ef4555299dc9	ULR-YS-5191-64476797	LAB-IN-RHW-64149	Gordon Inc	NABL/TC-3037/0023	Suspended	Puducherry		RPT-4870-168522	2025-08-16	SMP-HNY-40378952
8d322912-9057-4b8b-89e3-17971431fa9f	ULR-HZ-6749-76857575	LAB-IN-DQD-54934	Grimes, Goodwin and Stanton	NABL/TC-7150/5050	Withdrawn	Bihar		RPT-5013-067587	2026-03-12	SMP-HNY-57043716
0b984f73-10e9-4ade-9a20-443ab411beb6	ULR-JY-8345-95370917	LAB-IN-KZV-51348	Ashley PLC	NABL/TC-8116/1880	Suspended	Haryana		RPT-3699-238782	2023-01-31	SMP-HNY-52523435
1037e720-5185-4f9c-b2d5-3892376c73b1	ULR-IL-7884-41380272	LAB-IN-QIQ-25209	Brown LLC	NABL/TC-8848/3415	Suspended	Kerala		RPT-8715-554761	2023-03-06	SMP-HNY-89327015
240ec309-76d5-4827-8814-69feb89c6928	ULR-FU-5382-95134025	LAB-IN-LKH-70099	Campbell, Wells and Hughes	NABL/TC-8937/7916	Withdrawn	Goa		RPT-3124-032855	2022-04-08	SMP-HNY-07269016
cb868677-6f17-400f-95a0-6918b580acdb	ULR-QM-3987-06360584	LAB-IN-VCE-30932	Perry and Sons	NABL/TC-8801/3822	Provisional	Jammu and Kashmir		RPT-9228-505301	2023-05-17	SMP-HNY-22773592
59364ec4-f1c2-477c-afd1-427b2a7cde1e	ULR-WG-0841-87620775	LAB-IN-NRL-45724	Villa-Lopez	NABL/TC-0813/1426	Expired	Madhya Pradesh		RPT-2393-815747	2024-04-04	SMP-HNY-59384669
e5249860-5d20-40f1-91c6-84413f9293f0	ULR-WP-2751-76137884	LAB-IN-JFR-81969	Bowers Ltd	NABL/TC-0696/7924	Withdrawn	Bihar		RPT-4145-541622	2026-03-02	SMP-HNY-87819393
3c604392-bc00-4596-85a9-2203ffcf1625	ULR-HV-0457-40017666	LAB-IN-QEG-78715	Hudson-Juarez	NABL/TC-3972/9822	Withdrawn	Maharashtra		RPT-0691-112039	2025-09-06	SMP-HNY-12993482
fcf3343e-ce63-4f77-bd7f-0e3610a8aa25	ULR-ON-8522-15851581	LAB-IN-MDT-11938	Anderson-Hanna	NABL/TC-3566/9447	Suspended	Madhya Pradesh		RPT-8337-908708	2023-09-03	SMP-HNY-17452936
010bf356-600a-4000-a0a7-d82787dc42ec	ULR-RM-6956-44485753	LAB-IN-YWV-82615	Callahan-Mcconnell	NABL/TC-2032/4606	Provisional	Odisha		RPT-4104-161437	2023-02-13	SMP-HNY-40400688
7c6280b0-e1d0-43cb-9e9a-2b3f378b9b5c	ULR-ND-3922-62698598	LAB-IN-XOJ-20560	Jordan, Roberts and Barr	NABL/TC-2379/8041	Provisional	Telangana		RPT-9483-413181	2023-10-30	SMP-HNY-33206978
a0a5c375-f259-4ca9-993a-4fb7f04865c7	ULR-UB-7243-58887340	LAB-IN-EGH-00606	Hart PLC	NABL/TC-2143/0756	Active	Haryana		RPT-8665-107070	2024-10-27	SMP-HNY-36375601
751706e3-0f9d-47d0-acaa-fde30b5c7704	ULR-WB-3964-02921023	LAB-IN-YIM-39723	Mccoy-Hodges	NABL/TC-8283/3719	Withdrawn	Jharkhand		RPT-5012-965114	2022-06-02	SMP-HNY-62425932
7d2421de-56cc-47fb-8098-3dbb419cb3f2	ULR-XV-8880-97368400	LAB-IN-GQX-20044	Atkinson-Bradford	NABL/TC-3808/1231	Withdrawn	Dadra and Nagar Haveli and Daman and Diu		RPT-3643-020277	2025-01-31	SMP-HNY-76399632
5fa56f07-171b-4f0f-a95c-c108eb72f7a6	ULR-PQ-9734-20739752	LAB-IN-IRP-34639	Mejia LLC	NABL/TC-5577/0629	Provisional	Karnataka		RPT-8356-219074	2021-10-07	SMP-HNY-87307136
2b19152f-6040-484c-a47d-b1871597fa5a	ULR-JK-9873-43456410	LAB-IN-PZH-52333	Carter Inc	NABL/TC-1606/8150	Suspended	Jammu and Kashmir		RPT-3415-645745	2023-10-12	SMP-HNY-22681942
f0825770-99a7-489c-8f07-85e3c31ab91e	ULR-PN-1331-57992113	LAB-IN-TCP-45845	Miller and Sons	NABL/TC-9002/1997	Suspended	Haryana		RPT-2265-072990	2025-01-20	SMP-HNY-12851255
33422dea-617f-4a45-ad22-13df7ed3d6a3	ULR-QR-9650-30209014	LAB-IN-LZK-66636	Mathis, Ayala and Owens	NABL/TC-8821/3842	Suspended	Gujarat		RPT-1170-819840	2024-02-07	SMP-HNY-44433045
9c7d7759-cff0-40fb-adcb-ebd6359ff2a6	ULR-ZF-1294-09153105	LAB-IN-NTH-63857	Gutierrez, Allen and Jones	NABL/TC-3586/3600	Provisional	Andhra Pradesh		RPT-1366-072690	2026-01-05	SMP-HNY-27512432
6b75752d-86cb-4437-ad8a-02eab84f85d2	ULR-CD-1379-33226990	LAB-IN-JFS-72032	Jones-Hale	NABL/TC-8692/2681	Active	Puducherry		RPT-1702-427290	2025-01-01	SMP-HNY-63447441
9c6ebfc8-c186-4760-a27a-ce6564fa616a	ULR-SI-1444-52047384	LAB-IN-HLT-92570	Graham-Torres	NABL/TC-2725/4675	Active	Tamil Nadu		RPT-0507-976784	2021-10-30	SMP-HNY-33174249
c8a5edff-4f71-42c6-b194-4d04d4bc7dde	ULR-RO-2340-39100464	LAB-IN-HRB-94648	Mendez-Campbell	NABL/TC-2845/0373	Active	Jammu and Kashmir		RPT-0840-987220	2023-03-12	SMP-HNY-66027335
e53fd344-fcf1-4674-80f8-1beb1474574c	ULR-SB-8126-66088436	LAB-IN-EOA-04783	Jones-Castillo	NABL/TC-3856/2341	Active	Uttar Pradesh		RPT-1636-558448	2022-05-21	SMP-HNY-28984796
1051fde0-36fc-4045-b61b-b2113360f0c6	ULR-VH-7125-94969295	LAB-IN-JWW-39684	Martin, Floyd and Horne	NABL/TC-8224/8637	Expired	Assam		RPT-5999-733071	2025-07-17	SMP-HNY-44781030
39e49345-da08-4cdd-b7aa-986b51721c93	ULR-VM-2048-60169740	LAB-IN-UYN-34308	Jimenez, Martin and Hunt	NABL/TC-5939/7941	Provisional	Telangana		RPT-0876-170478	2024-02-16	SMP-HNY-69703907
c9517a23-0e0d-4c3d-a795-99f0bb3b9668	ULR-PD-9109-28776324	LAB-IN-LVD-38466	Castillo, Thomas and Walker	NABL/TC-3909/6129	Suspended	Chandigarh		RPT-0487-717522	2025-12-21	SMP-HNY-19909196
afc10c0a-6a5d-4b13-8c9b-659151a6caee	ULR-KF-5241-13605021	LAB-IN-LAS-71282	Christian LLC	NABL/TC-3253/7842	Provisional	Andhra Pradesh		RPT-7516-253737	2026-05-24	SMP-HNY-74734427
f771f81f-930a-49fa-815b-3c8253cd7534	ULR-UK-9196-43661610	LAB-IN-QMG-76250	Mccarthy-Wise	NABL/TC-7793/3888	Active	Delhi		RPT-7254-820458	2023-05-04	SMP-HNY-98805055
44256d36-ebce-4d5f-9a62-e6d63eb6db21	ULR-QY-7211-78443722	LAB-IN-EQK-37193	Middleton, Vega and Mcdowell	NABL/TC-2946/4311	Expired	Manipur		RPT-3720-455338	2026-03-19	SMP-HNY-49901592
33b6b7a9-3967-4afd-8379-92cbab9f9c6c	ULR-PV-8137-26711356	LAB-IN-TEE-94026	Combs-Lindsey	NABL/TC-2007/3421	Active	Haryana		RPT-3366-570891	2021-09-11	SMP-HNY-07927807
bc679d58-8eb0-451f-bd8d-c884a24410fb	ULR-RN-0421-57676562	LAB-IN-OZG-69215	Green, Morrison and Stephens	NABL/TC-2586/7313	Provisional	Mizoram		RPT-4248-675496	2025-07-04	SMP-HNY-93781627
e8ce2076-2b5a-495f-91ed-b551c0c34d5b	ULR-WV-7556-68894035	LAB-IN-BOE-25408	Williams-Garcia	NABL/TC-8708/2041	Withdrawn	Jharkhand		RPT-4431-984036	2025-11-13	SMP-HNY-09592947
890e449a-e303-47ea-8d5a-ad03c46b4e86	ULR-CX-5375-03919118	LAB-IN-EBN-91488	Bell-Francis	NABL/TC-1302/7334	Withdrawn	Puducherry		RPT-1668-303151	2023-01-18	SMP-HNY-53426054
05d34fbf-72d5-4c29-95c9-8182792988c8	ULR-UN-7636-46653157	LAB-IN-XNP-49528	Castillo LLC	NABL/TC-5749/1613	Suspended	Uttarakhand		RPT-2497-219466	2023-03-20	SMP-HNY-64756310
951f881e-eca0-4ebd-b381-d62997f62f25	ULR-DJ-6738-88378558	LAB-IN-EBG-72707	Jenkins, Ruiz and Brennan	NABL/TC-5879/3373	Expired	Nagaland		RPT-6269-292556	2021-10-07	SMP-HNY-67164767
182e1678-dc87-400f-ac39-95590d14bcb3	ULR-NS-9689-77435758	LAB-IN-JNT-50318	Nichols, Bell and Miller	NABL/TC-4886/9895	Active	Puducherry		RPT-1880-584630	2023-10-17	SMP-HNY-34965101
e6a587d0-0153-4ab9-bf30-0bb029f9155e	ULR-KU-0705-34751044	LAB-IN-XQL-41333	Blake Group	NABL/TC-6698/1441	Expired	Andaman and Nicobar Islands		RPT-1860-230943	2023-06-05	SMP-HNY-03713716
d51342c3-6025-403f-991a-1fdc10ac822f	ULR-FD-1580-77118785	LAB-IN-IRC-22981	Black Inc	NABL/TC-7290/5098	Expired	Karnataka		RPT-8808-023752	2026-03-11	SMP-HNY-98251426
383bee1d-fd81-44bc-93ed-49f99f7d0fb2	ULR-ZX-9586-84086881	LAB-IN-WPK-72732	Jacobs, Kerr and Liu	NABL/TC-3559/9219	Suspended	Delhi		RPT-6927-644131	2026-07-24	SMP-HNY-81722853
a7042395-0564-4074-96e8-d2fce888500b	ULR-UH-8849-48856506	LAB-IN-CLK-34167	Roberts, Mckay and Byrd	NABL/TC-3299/0027	Active	Sikkim		RPT-7145-923980	2023-10-31	SMP-HNY-56130943
1d323675-6712-4d1b-b62f-d4cc066c5ba9	ULR-JY-1843-12635129	LAB-IN-VNN-62946	Trujillo-Whitaker	NABL/TC-6432/4567	Provisional	Madhya Pradesh		RPT-5295-203387	2023-02-03	SMP-HNY-18424665
5e571448-caec-4bc3-8d8f-f16de27a4094	ULR-AG-8295-16316799	LAB-IN-ZKB-25503	Nichols-Parker	NABL/TC-5369/1163	Suspended	Dadra and Nagar Haveli and Daman and Diu		RPT-4029-435032	2025-09-22	SMP-HNY-09749145
c695ef93-1bdb-42ae-9275-77085e356218	ULR-YF-8177-36105851	LAB-IN-QAR-47692	Quinn, Hubbard and Lewis	NABL/TC-0416/2809	Withdrawn	West Bengal		RPT-0370-932490	2026-05-31	SMP-HNY-36041150
721fd66e-e9b8-4041-8e67-7d71095db047	ULR-MT-1958-75068689	LAB-IN-IDT-53223	Hill Ltd	NABL/TC-7802/5118	Suspended	Gujarat		RPT-7119-541958	2023-02-15	SMP-HNY-39313198
396f4cb9-b9d5-46f3-ac85-9123c72440f7	ULR-YS-9794-05902112	LAB-IN-TEG-41558	Nguyen Inc	NABL/TC-8463/8619	Active	Andhra Pradesh		RPT-6910-839275	2025-05-24	SMP-HNY-05970101
d41ae26a-13c3-4733-8d6b-cc90ac89549e	ULR-QK-3688-18055642	LAB-IN-UGO-98469	Nichols-Powell	NABL/TC-8152/6467	Active	Tamil Nadu		RPT-7116-557438	2022-08-20	SMP-HNY-18237308
73e7533d-eb3a-4fbe-8d19-903d8e66060f	ULR-DO-2276-36343160	LAB-IN-SRF-10177	Guerrero-Montgomery	NABL/TC-2986/7299	Provisional	Odisha		RPT-7643-831298	2025-09-24	SMP-HNY-23451975
190a09b6-39b4-4100-bc8d-2de6dd443729	ULR-FX-1311-92797496	LAB-IN-AOO-27909	Weaver-Peck	NABL/TC-6199/7356	Expired	Puducherry		RPT-5090-898055	2025-11-29	SMP-HNY-13021285
e45c9114-247a-40e7-9bf4-4fd2f47ad289	ULR-WB-2839-55146872	LAB-IN-LEX-45077	Gibson LLC	NABL/TC-4205/5167	Suspended	Maharashtra		RPT-5473-301829	2022-03-04	SMP-HNY-24014303
d7582dfb-ceb5-4b43-a9bc-f61adbe14c28	ULR-RI-7858-96215068	LAB-IN-TUD-04692	Kelly-Gordon	NABL/TC-6609/8924	Suspended	Madhya Pradesh		RPT-1228-679089	2022-05-03	SMP-HNY-13139633
fd21c4a6-47ca-44ad-bc54-6b355cfb69d1	ULR-EU-9439-29126431	LAB-IN-QYP-34528	Martin-Deleon	NABL/TC-6430/8066	Active	Haryana		RPT-4571-813848	2025-03-11	SMP-HNY-91286803
6f400a63-3a4d-4292-bab2-7db7691cbd53	ULR-QU-9617-26330600	LAB-IN-ULN-71379	Jones, Woodard and Shaw	NABL/TC-5200/1064	Provisional	Arunachal Pradesh		RPT-7042-216014	2023-08-16	SMP-HNY-28322576
\.


--
-- Data for Name: license_registry; Type: TABLE DATA; Schema: verification; Owner: postgres
--

COPY verification.license_registry (id, license_number, company_name, state, issue_date, expiry_date, license_status, issuing_authority) FROM stdin;
1e34abef-4cc7-4e18-ad5f-4436c1edacc7	HSYK3UKIF39A	Williams, Webb and Snyder	Uttar Pradesh	2022-02-11	2026-08-17	Active	w1rzj2zeo2939vyq6smoabyc11vzf6r9bggu4tawtkbe9qw9rot2686cguy5caqi4b6dx67wn4okklr9rwj1riefwmsj5ysn30m2w0ukriu3tdk2sfqg2vujx48tzga1x6pikdirzoz50yv26dhvt1qubspzty5gt76fycbic17w5pd6l2
89ab570d-b42d-4e69-a656-85ee4e7aa0e1	ZMQG1MERB1Q3	Hill-Taylor	Punjab	2023-06-17	2023-09-23	Suspended	uciruyd28d72t7av2f1h8j4lpb1yw04uc3w2c568rgqo7odu34wj2ccsmqir40a8ohxmomka9l5hu58o0tk48zlkb4pefi2w1i17v4leaj1tf1q95xtz0tabv7c2guddgd0kj97i30wx9
eb349529-93d5-4fba-a675-b279bf4ab9ee	D4PMOWAKS1E4	Carr Inc	Madhya Pradesh	2026-02-20	2022-07-10	Active	8k4b51pxseoli
fde9c06c-0bea-4256-b354-f7cb8e58d4f5	5GPNJZ9VLP5A	Ward, Nichols and Wright	Dadra and Nagar Haveli and Daman and Diu	2024-11-19	2025-09-20	Suspended	q9efp1d3zcqr7jj2zcuectd9u95vfdy9qhzc47trnvbzz8rhiwbzlxbeyndjw8we8sa5acpayxb3v3s95r32rlwxzqa5jc25of1rz5taxh4w4bj9athq73j9nx8ymi6jh11wcl
6053b0af-ecae-4d48-a4a3-96c9152ff8db	62WB88EEJ2CO	Parrish Ltd	Maharashtra	2026-03-19	2024-10-31	Cancelled	3u7xyd9e0smfw632kxbby73c0s4al47isvt76kuvkulcac8upshabmwudr2ovgrnnm5zurky1tibtbjixx5ekk2qdmpu725nwwa9ecx2za5iravdu29o1vg6leqm72bnvux85n4b97x8kbqnhp
b01a5575-a782-4787-820b-4dd96fa08f34	3O9EHN1TC81D	Wright, Weaver and Dominguez	Andhra Pradesh	2024-12-07	2025-03-01	Active	kgke7nzhquklg6t7doetzwc60kz8hst3cunhkabxah5zu4h9kgq1csg3djax3ltr7dxpv64ywgr5rm6oroo8q5zqgjlucnnx4la19ap
5d02d97a-09a3-45c6-8110-034c1e791a56	1HSWW5131CDS	Coleman-Williams	Dadra and Nagar Haveli and Daman and Diu	2023-03-31	2022-09-19	Active	gyhs7pis8hayu9jdqdet76jbn53flejg184hftmhkpfg4zki1xfwjfsvk4fa06m1um261wqboa6x6gtsqltpl539izu7qok9avfr8ktt0bm484351ybmam89gfcsfyl16uf6m036ubr7zdvh78cubnn78q33quqflx8
3310afd6-3f0f-45ef-ae57-bf4287d88b05	O3XDDNQONVT9	Ho-Huffman	Andhra Pradesh	2025-07-05	2025-08-03	Cancelled	363axywwm32okkzqcokkl478bljlxj9g8vtgi0m3seo2442bjkdmwadtqd6aybnd5ijrus9lizsxu
4c2cdf5a-8898-4657-82be-f8ee9704bcab	K83FFD88VCRV	Perry and Sons	West Bengal	2023-06-14	2024-11-18	Suspended	ypruupo92ff27v2xieu9r97xkyhse8y6xicrzzz5vgbtse5x2mgkaumj2efcoartfiun59qukula6wktzoqlg7czt855dszk22px4476nungkx09nsk0x0gho9yf1mv7yszy7wxvnxj3yt0j7r3xssmo03rbelaubsb002d7r5x8rot2zl4u0f8yhbs6p8
a9c05c81-2c00-47e5-82d9-be870ca0119f	MEH83G0RWA1F	Hubbard-Nielsen	Gujarat	2024-04-20	2025-02-16	Expired	8ww5vmenxcs
08cd8b66-b0f7-40b3-af8a-f0cd46f5c8a3	RWMMP5Q2XF4U	Sanders LLC	Chandigarh	2023-08-28	2024-03-07	Expired	nvpuvdpa9xtkc0j0fyccrdazfrenrv2u9u72ev0vxm0sob
4c194a21-d4a5-4d15-9f9b-77aa27fd2cb4	B0T85A2YUSVR	Howard-Miller	Delhi	2021-11-15	2026-07-01	Expired	6hg2n1jiusoprb98x3ctdvfnv5ed16q8qjfgkwypzzu69fl0om4w2ahg8xhobsahtrre22nxezpwd0z696k1tvc3r07gkz5pidt35o6wzt1yke1v9ko8k9r9iuyygkxjytdulbowskyx927iqoyoknct61k117xpe9icoqzqwezb2ytibunxzc6
0ba93d9a-767a-4783-a55a-7b829ffd7fa3	O8GIJ9W9WLAB	Garrison-Glover	Tamil Nadu	2023-11-10	2021-11-24	Suspended	30dj7637v5j3vuv8p6gorh0lihk71l2twvrhlvrou6wa4f5p3bt1hs69tqxum1u0v9jgwujzr9edlbdmwnn95ln2l
eb3348a2-9ee1-48c1-a1c3-5ff5dae78494	O7RE686Y4I6D	Lane Inc	Tripura	2025-09-19	2024-11-03	Expired	yadjppiajwzwnkkqjomibd48mfnp2wnk9e0yt3xy2x5oo9afmgz
49cea520-9503-4102-8e8c-26dc73f01a70	YD83MUJDUCY5	Turner and Sons	Mizoram	2026-08-24	2023-01-07	Active	y7od6fpb20s4drimkok03b4v3jtzlpuhwowt0mdb9mvm3zbgr8lbbhx5raouwhlxldj7y9bscdwp5baxp4fmb
89345273-0e0d-4981-b5e1-67e11c2e8851	XTK45SW0J8P2	Cox-Griffin	Ladakh	2026-07-01	2021-11-07	Cancelled	o4n7a24lvaez656mgt0t4tnla06
245fd1a8-f57f-4db6-b74a-0f7179e8037a	DAFX9HSVYHJE	Freeman, Williams and Stafford	Telangana	2025-10-31	2025-12-17	Suspended	qh43t5u1uhiyliy6hyr560c9jwrr9mdaaf11wvbq8i7nhi6de78dxraavqylbupqqtwn8fuw34l2bjl991gcuedw8zgcq9g0arovw8b7n48lslw3xo8l7inw9f7r6qrinxkrxg79lg24jtun07lexrzcclunng4f2nur2ozs1kbf125tt3
93630ba4-f2c1-4dc3-8702-3ad31e74b438	5TYY87VG3O4Q	Mckinney-Griffin	Andaman and Nicobar Islands	2026-04-28	2025-03-22	Active	2u1tqb4esatcv51oodtd4o9a3nreripu476zaa2sy40iovib7p9xwnx2071wfv5nv5k05xcbkbc6tbg7ic60fwz4gaoggsiyj4xe1nabtr99oznqyiwd40ktbbuv
29944b50-6bc9-4aae-9149-7aca82193523	N71GKLFX2LIG	Pacheco-Benson	Tripura	2022-12-27	2026-01-11	Active	wi9bplc8bxrnejktymcln7a
edade0db-2af1-4ed6-b67c-b57ea7f7ab97	PZYGCDI38FZB	Reyes-Shaw	Tripura	2025-04-03	2023-09-06	Expired	oxcv443oh0sw0py7tu5i7cbk105f8mbanygsog34rumcxszg0y5b74szzn5krtoyxmq2skjfbqf4vcr7qg0u06kfzayoas6eq579x61p68lxsiio5kkvmaqwbjrc6mtuthiovzz4k3g5b1upf4351tnk8ie2
4e2eda97-116b-4808-9083-73948c8d9d38	MLSUO697223F	Anderson, Johnson and Anderson	Maharashtra	2025-04-13	2025-04-09	Active	jyhtrb967y1jalptly3542fkd7but6ex4c1
5952f495-57b6-4fdc-ae01-7041e2de5d73	NL54UTRYCDW8	Curtis-Ray	Meghalaya	2026-05-18	2024-05-30	Expired	jxmdgcdpkfs0ooik5fdqned2rx8oq01cyzvkbd4ge
6464e90b-484a-4812-bcbf-c29bf1640dc2	XT9Z03NBFOGB	Arellano, Mosley and Rodriguez	Uttarakhand	2023-11-20	2021-12-15	Cancelled	igwow81wvmrvr5pbi2u0c07lvfho6so5egy5xvv50o3874pxz6vcggn8499ar3kx3d1iy8wd2dmszwjze3xffcfkwlezzmu82kiqnkizpjyl72sqy
62a4d30b-b74b-40b8-b29e-037fd957d04f	BDJEDNTMPJ90	Watson, Wagner and Smith	Punjab	2025-10-04	2025-08-05	Active	u3ko920mmq83gsvmcpiwc5ssnx8ihvzijmzpd1yyum
a340f0f6-0fd4-458c-bc67-ff4cbf783a54	EOBQI0STMHJD	Potter, Schultz and Baldwin	Gujarat	2023-05-27	2026-07-05	Active	5yxsory3z2d418yk4esjoqxg09ypnvygbn9dwphvyflxo20ga434n72oovp2gsyk47q92yuspylldgwzcqfcb30jpf43dbwsclih66aazfx0ekqsx2mtnq1g9
c1618a2e-0c7c-42a2-bafa-fe6cf184c1a4	TLAJLCAF1DNN	Rivera, Miller and Mcmillan	Dadra and Nagar Haveli and Daman and Diu	2023-12-04	2025-08-25	Cancelled	ivukm3lw223i2mfleyykf9v1jgyxhq2jwi2r4dvt8q7m3v37wkh441luu767bnkwiz5kie5ck1r1c8safqbrp8izffplpbuwye2iw7om9wx9iazkah1duyhwz1twbbhooxqgit0eddlieb79firs
450e9652-5c3c-4055-94d5-34d92f93d166	BYO0PROG7SJO	Harris-Martin	Sikkim	2024-04-25	2024-07-23	Active	q8n3sl79ccnii6jd575gepddtwg9nvo0q4cs2hiyf4y3w4bl49oqdtmvwgzd3yziz3dfopzu1h6xiu7oc3oi2opwb35wr5tltnn7juuixeqicifnw4mebw7w8guqsr369ojn1m573no3qsub7f4
271204cc-0e33-483a-82d9-74a6aa5a9bc5	TIUAG0E2EQJC	Byrd-Davis	Manipur	2023-04-07	2024-06-30	Suspended	jgwnyo1veftcio
5462cb66-d28a-41a5-a6a3-979170bb6150	JUBLOP4E51EB	Franco, Allison and Reid	Andaman and Nicobar Islands	2022-04-18	2022-10-04	Expired	7ub2t9ta4b7slqqgidjl6jupemv21678sb9je2rbrm
c21dc03c-78c2-4fb1-88e0-4fbf2f212601	YJ2KFK21AMW3	Buck LLC	Haryana	2023-01-30	2022-01-09	Cancelled	2mmx0jf6itrmwoy5
868b9d9d-23f6-4c96-b895-83be34afce88	X5XH6GHAQMJ2	Brown-Sanchez	Maharashtra	2024-09-18	2022-01-01	Cancelled	pl0sesy4vune1lds1a7zq0uvohn2mzuv5elhqom32trpde8uph8s7b20i35qwsyi8urnzm90qzyml1ef9ahrpl2xm51ltlwe6jx9gks
b67f4a66-32ef-4b57-aca3-303d2a701477	NVU2UMEX4LDG	Newman, Edwards and Vasquez	Jammu and Kashmir	2025-07-13	2024-07-04	Suspended	ggegyvpnng61ck3ghmjgzm797xfixetl
6f331af5-e3d8-4de2-86b8-6d27fccd1199	CD4T03C472LW	David, Bowers and Mccarty	Dadra and Nagar Haveli and Daman and Diu	2023-11-20	2023-10-30	Cancelled	mtinx5uvgpwprj812qdpwe0cw03yz90lm3s10mqc3f5opag0n8xk6rau2wnyekbu05q4joict7v5jwlbgef8yfq3mas03nm8s3bwvlkbp77jkdq
a25b48df-0244-44db-93e6-1474df721c53	83U5K1AHEMB8	Clark-Gould	Puducherry	2021-12-06	2024-05-01	Active	dns3eydmr37fun0p90lrwa0280xilho43fhu5olseuzt8i7ac8f4tlxvrky96s5uhjj0vdtzwrtk06rzpgyrvv6hivhzw5i0z3popv81fisapt83pc2mdye9ktx
56c4e998-c37f-488f-858c-0be18f5c14b5	FXL7GJRW8VUS	Morales-Ingram	Kerala	2024-04-05	2024-10-14	Expired	soapqri6urn1r10285da4sk941stbejq9hat8yyx3qe752xuvb3hto8ha9ll35lmlj8zn1vrh0yhhjb537k961glbf4
00241f21-9c02-4e8d-ad0f-5e3e16b4e5c1	UTNE2FPC774P	Williams-Hicks	Odisha	2024-10-07	2021-09-27	Suspended	ax5cb7g52
cd96b0dc-8653-4134-889d-84658bb351e8	BLU7F23KATI8	Aguilar-Sanchez	Uttar Pradesh	2024-12-25	2024-07-08	Active	z6b7b81qbnz7z6724psta3dcitsh0d76433dp6pz7952uiedf3rbhlp240iwurf0fkjh1p6gty5uhei6nuhyk2j1fnnbrs8r0np4gfbyho6vrfgm
7e7e2344-5166-450d-998a-d7a1733f14ef	VJT460WC86ZN	Robinson LLC	Ladakh	2026-05-04	2022-04-08	Suspended	776a9fwt2jq53h6fx6j69n3z00vztlpydii6n7dhg5rwutn83c5mtovy3r53dk3gmwoez8dr3j5bsd3sh4s6phvfzc
269961f1-fff5-49a2-9a22-b979ddc71d40	6SW3RI0X2BAQ	Barrett LLC	Chandigarh	2023-03-11	2026-06-13	Cancelled	9e7v1tm96u2a9kb720kwp3pm2x9uklpd6n3o3o61mt14r24h7qb50pt97205qqwghgus0dvcqxlqmxqju827uil12x37dg1g2ahxuzfgdqtla94nvw7al92rlg1q1rz60f7ap8litdau
9901a170-004c-4826-8548-f9d06ea82233	L1LHXWJTIW7T	Berger and Sons	Uttar Pradesh	2023-03-06	2023-12-05	Cancelled	uv1ah0g4vw1m7eavra76akl8m6t7u9hd1zptoxsv42md3yynlwsg2ipd7djr35ul4gnx25y9o05yli28dder2598ax1lip75c4xtqhhckvlte667k6de729p9204lcpwkwqxnaull513zensd500gj1e2g8mjil2by
29562739-543a-480f-890d-985c1406f4fd	SISSP3Z70GVP	Greer LLC	Telangana	2022-06-03	2023-11-18	Suspended	fq5cqi3mu6jq949d9943z6nc6189jvhjuch2dy1eqx5gr5zajpgnf7utix5n6iweqv8yzfkrpy0tpwyygdx62lz14chlgfgnutjmmwvhyvad
33e256d0-1d72-455b-911c-3f23a20fe54d	GW6JSDK63PMP	Odom, Floyd and Long	West Bengal	2021-08-28	2026-08-11	Expired	cdmpaakqgb8xhtc2toyy76xdhu6m4a4lqvg2217psw0brvm19yxq3l7wv1782dr1d31yjfhhhr260to4cldnw0vi7x4zv2fq4lkk2srzuuoljsx1xzlsc8k7c1dzaknfqyx03tkaqohpygvcc4fn8pm38skkg8ybg9npi9nww62ct4r0wqenj967x5b
bdc36b1b-9000-4d0a-8ccc-586bc7326c4f	V5OAWZV3KA54	Bailey, Wood and Cummings	Dadra and Nagar Haveli and Daman and Diu	2024-12-31	2024-11-09	Suspended	yb6wfkykdp0uvsjn36eefrpp8ykeg8e8tkdfsk4q7smxzbihsh01tj16ttv6y9mdfrag16c2
92cc48b3-6be9-49e0-8433-0c2731781b34	1WLFMAFUK1M1	Lee-Campbell	Delhi	2024-01-14	2024-04-15	Expired	7xca7u1nri64h9b8yr150pf0ter9dys2i124sc4e5m16ndkw9afyr02id8jiv50njn7icsfsx8zdssi1pozzf06w5o1y36arccfp4dh731o0jt7wuaoslmcw3i4bnjo05c52pfzr0ddg47svff77ogs08dch86j20hpxpasxikpnro0uplil6bn1m1feti44zj
f3687105-e2eb-4657-8fb3-ff0fd3ae88f9	1BLALVZ1HEU6	Buchanan-Lopez	Manipur	2022-08-22	2021-09-15	Active	l2wcu8u4uqbstm6plvtgcz49p4eh0sx950ycdpwuo8hj2n5
f343aa33-461f-4e6d-beac-17c2b3f0969b	GAEPWTV3AEXW	Snow LLC	Odisha	2022-10-13	2023-08-28	Expired	enuwvf1fp74zumwvznv85io2y1o10gzuhv7njcnev75sjkks1kyl4vsej2gbm8o359bwkdiob2pwswrc5zyhrzuw54gdp2kywb
3633991a-587d-4590-9f5b-d08fba90b51d	YXJMURP60MNK	Kelly, Bennett and Orr	West Bengal	2022-04-23	2023-01-12	Expired	0bk498amr541wl7wbn94jld62lz5s6iiu60bwsw6guv7sj1u7ocb
3bd9eb8d-11bb-4655-9cdc-46839af576cd	2ZEDY9Z4NSAG	Stone PLC	Ladakh	2022-08-14	2026-08-22	Active	0nwoyaiqug
c0ca1860-a73d-41e9-9868-7e6b9f17966b	RO7750P3PLC2	Taylor PLC	Andhra Pradesh	2022-10-14	2023-05-29	Suspended	bq47r2pqm
3f2999c8-9690-44fc-8b05-0fc8f6187d9c	FSVKPLD2G7X3	Nguyen and Sons	Sikkim	2023-10-31	2023-09-14	Suspended	xaezx9t3acea0aigqo5j7nrtmkguwnvxewuk8suvzhwk1y0z0xzebzc338wi577gbw2ima4tub
c5b6d3c9-98b5-481f-98d9-d9f256d20989	1XMGRVT2899S	Johnson Inc	Andaman and Nicobar Islands	2026-07-09	2022-04-29	Cancelled	gmu7d0ytjl7z6b8djgq1lc8i0ruqihkagjv8zpup6j0ucuf7k6ol3miygttokxelpw9ugz0f8bvm7l8596vtkuf8hxg9j8sskmfrap7opm8z4hqvmoo7jlhjy50wymzj2vv1gzripwgfj53uaji3aepev3ew4h482ze0pzttedmk90syx6u8ufe9ju17c6gp4wm
8f9ff5bf-ce86-48cb-a58e-52f96892cadc	8LD4V2UEGAE0	Stewart Ltd	Ladakh	2025-12-20	2024-10-14	Active	zwid3u5wxv2mx1dqks4i8vzchr8gl59pm2z2ob4f8kgbfbhqpoy0pt
08e305ce-ca49-491e-b508-c01f1fa0eddc	OXH473ZD9URO	Williams-Tapia	Delhi	2022-06-24	2023-05-06	Active	jfl6moysdckm5cl4x6kwe750zb3wbqivvd0m0p3jwfl4l5y6xygrz80hzhjeos1mpqpgfdvgjqcyma3v8h2vgqjsceljh70297ailbp5
1afb7e07-3167-48dd-b38e-9249adf2d851	XHZ0B150US08	Hickman-Obrien	Dadra and Nagar Haveli and Daman and Diu	2026-07-19	2025-09-25	Expired	xr2o0k5zzswt3943cuh07rwykno6gqyfstvo2dh2wh7igghrnq70l7jb4g
e7d1aec4-e785-4cf0-b467-427e8ebcf496	X7ZL1SWKMWKC	Adams Inc	Ladakh	2022-06-24	2021-12-03	Cancelled	mo05lq9mfcoc4zfkl1f4o47ug0en2ifzko7cpwqk6nckwm09gjjx4uzgb
e323da84-1d2c-4244-9116-fd0b8ddd2109	RK2Q38VXN317	Kim, Sanders and Solis	Manipur	2025-05-23	2023-05-28	Expired	3h7ev6p4
000822f0-3e20-40a0-a3ec-67844c28e90d	P3BTXEGMVK4N	Sullivan-Patel	Uttarakhand	2024-08-01	2021-10-16	Suspended	gflnowe64ts6gt0cgalocx7c5zzpbie0c2uwaukh0tugsbfrpatu0l3xexecrd4wjk33zt5sazx1pq
8badb080-62ed-41a5-83c1-947b0c783382	8EZV5O9FWCHE	Casey, Smith and Woods	Bihar	2023-01-16	2024-01-20	Expired	xxwmtct79513ra1mcdb3ap4x64lkvu15lyyuhhbq7oz5bmtl0h4
edadd9b4-c216-4ac1-9143-63ca56c239d1	H5XR9NJZYPM5	Chen Ltd	Chandigarh	2023-01-29	2022-11-20	Suspended	mic5ie5zr57jq5r1ots3xfzsvy3xf975cm5y3lw5fv5npax7zxkxa8fim9apykppa0i0jyxw23hmyuo8ibjk9qmj5fz5oc3ywkvr95
af89c0a4-300b-4979-baf0-966e19b9a077	D4NO64D3ED3M	Vargas-Scott	Sikkim	2024-02-25	2024-08-30	Suspended	a1qzy8jjw7v1at15h0pyw16u9w76ter2vkwkf7dqddq2l3pvudnzb48tdp2ehfixn24b7u5jjruvgtfg68e674k31e29iq0iygpsxcwh11b2acf3dimefge1uxr6cfyocy0e34lzfdsczh2t208
b847e20a-b4dd-4358-af0e-9de7bbcd4f65	L3EDNXYNH1BR	Valentine PLC	Haryana	2022-03-27	2025-08-03	Suspended	19zaz52cgjcyqxupzwzjofb5xaaspgvvet42g0uvd6pcstdo8hytv0d0unt31zvd4govv62jswy8l2wwqi40hjkcmmny5orqt3s3k2
80c986e6-30d3-4588-b390-369bca37fecb	EQ8634Y1DBO0	James-Adams	Jharkhand	2023-07-08	2023-01-28	Cancelled	1a9umhoxva195ie6tycnfy06zvbf7x01ggmgkqp0x40h6zb3k0wlylwae2cdo097iw661oe1m7nwdkyu3jkxnep3mqj2z205f1lvb1ma6x9wdm975z6q262eve4gp12be4fofytajt9wcx2gp9ndx9tul8nv6fo
18dbaeae-873a-40a1-a8ea-ce061548af4e	1ZXYBUSJC4Y5	Williams, Higgins and Maddox	Jharkhand	2025-11-09	2024-10-04	Expired	056l4fsmvgwpv2bqnmjayoum256d1dgcenrhl
89cf558a-a912-48a9-9b93-5961f0d1dfe6	86AQMAM1S608	Wells, Page and Ford	Sikkim	2023-12-07	2023-05-11	Cancelled	aiisdylsoky9ztpd6tl4pu5737c1n2kdw3jm00jc5dhhnw7ipqpwi57nk1oq0m74wznw6wvwe5pp2l50ia6fifd0vcgwyzebzlqlx45au4ag2ir3b7sjaqr5r67e8y3sq3mojx5vf5hu8
d39bf02b-01d4-40ca-bf3b-dd286e126adc	GQMIHUX6FMCQ	Murphy, Norris and Goodman	Nagaland	2026-04-06	2022-11-28	Expired	un5ja0jtm5fsxnztxmjoi17ln4cermb3rswfz9soku5a5hdeh6ei7bw0weeldak9s318xxy0qrgnzrlhzwj6aksfbx0ytyhxm
44a52e71-3e53-4cce-894c-da0a91d8ade1	JM6F2I094LCJ	Simpson, Williams and Cohen	Nagaland	2023-03-22	2024-06-09	Active	qdhspth9n825uq92dhe2e81lytevfysgqxp8qjp68i20uz9p2h8n93hcogmxmfkhdzrb05b5kgieo98igousg1o4glquw5m2w79luvkahxec4bjj6ribdn6dsq8p46d4xyxotckrmngifo7abjbksjiygtt19ipc92lw4n7bdhabn61dzi
6f0e2dcd-afe6-4f7f-9964-3fb9593bc185	G7MGAT1ZF6HN	Walls, Johnson and Ryan	Jammu and Kashmir	2025-02-20	2025-02-25	Active	m8g9bkfx37v0dhejvuvsfo85pgsxwkv6y40ylu4mlptcawoiegz0tgl8xx4mfc3te4s0x2klj04ckd92egnrset90
23fa65cc-793f-4ac1-94cd-490108bdd6ec	CAA0FGEIDGL1	Montgomery and Sons	Uttarakhand	2023-01-05	2021-12-25	Suspended	4r0119jdje7y4dwqdu2p5hka9dylpbxo
93c1b94b-a7ab-47fc-9aaf-6a316d3194cd	XE2WZUUD2DGS	Cummings-Palmer	Assam	2025-05-20	2022-03-22	Cancelled	7c2zvlwaqxjf0vhlp47d1v851ck4qzpo5zirqq0sbx9tk9n5hstrmx86ax9wwh51negadqijj777yj8ljodix80rps5ub30fne25hjblku7qnrxm8z0ebm0x5miovrdyyba4ousf3zv3crun636y2mroy2v0vg0lxa2an9x861t400zr1caew5hwfkvxorbb75z0
8d08e13f-209a-4ab2-afa5-4179ebae77ae	0GS7TR2RE0MY	Newman and Sons	Gujarat	2024-02-21	2021-11-20	Cancelled	wjhbke029kwssm23ezn5hc1jrouvua4snzze77hj2y0bznyldzqnm8mj0h6m34w4edtmcd8uyo779jfsr5cwt
7bdfc8cc-dcc6-407c-aa5b-3c821d1d94bd	NVN9BI1ODONM	Ward, Pace and Gallegos	Kerala	2023-03-06	2022-09-13	Cancelled	5vmfgjg6iuqpr0ijnkvz1osgad7ntnnonp77vfvxhhfygvy626082de2omhaeku51thb1o1h7kjqmg0cooub3ue6qjxsp3bzfr7rd2c6ny8hr3z7rle6a4tpxzfss7v8uvadrrav2so3jzhwr0ejx78r1rovp
0ef4156e-273e-4e50-9b52-07dff5e50c9a	SZ0R1QX1KUEF	Alvarez LLC	Assam	2024-07-17	2022-04-16	Active	2mthbdzruutfg8j1epg6xeskzzegrifzfo2ys5y79vrh4rso0xcn8iorsw40dlzf7xyzclp
675d5bc0-9a08-4978-be4f-24724ad96313	8U7OS0B50CVS	Galvan, Eaton and Lewis	Maharashtra	2023-07-09	2023-11-07	Suspended	idzxyht9yxro3ufe917qpwjopsy
0a36beca-c021-49b1-adc7-ddf9799738af	KOHS5E7XVB1U	Hunt, Miller and Stein	Gujarat	2023-11-19	2025-02-18	Cancelled	ym0k86trg56z1ek56ilztupn4d2std42o4a1jehx5qfecor13frr8xm43jyamezwx7ofn1bessmv5h9tzg91keaw6bw7xapbtrkui8t93gx4y7lcp5dylymcvksczop2z447phjp7nv3y1j6gbie189eqc11ev5kzsb18myumb
8fcc57a7-c52c-4cc2-a36d-bb0079c3af6d	SFEAH05MEWOY	Gibson, Ball and Bates	Kerala	2022-07-15	2026-03-18	Active	uu9eoysvvsfracgpq3c4et21vvb82jq1kwrnfr75wvw5vytso8a4z0hqni1mfgnaufrzyagcvh4d7ffr49dng845mbvra6sthbw2ibwsikmjw4e1rtaqj370yogf1c0em29pjkvpw3ydf3zouvd5oreane163j00iq478f2q1rcu7nt
c42fd443-1cb5-4770-81f6-2362b287b66e	EWO4U0Z8BGDM	Austin and Sons	Andhra Pradesh	2022-04-14	2024-05-30	Active	ik13c60pt2bis5pvj12cjo1v9aappkde3ndgpjy85slqn84d79346fcpz7jeo3vor29jwelq94ki2a3room12ionf819wfkq526gfr715sp7e5ezpvy4gjc
569222a5-87ff-4e75-bb07-154c495c0641	MUC9Q33ZVBK2	Hahn-Franklin	Sikkim	2026-02-22	2023-09-14	Expired	ocooew8ew7scvc06jyqpq6xf92ew2y3skltq8kqsaxht5y99bqhsjxz99xrjr7kw2mzhm2fduglhnfrcrzpl50695n96566fimc9730thxiu1hpzboapqceys5rg65eqo6dpj7k5u02ujnzw9mc966t6nhm4ty
701dba02-4192-47f6-a8af-ac7eee0dd9cf	PV0EOHOCZHKB	Costa, Patrick and Henson	Jharkhand	2024-02-02	2023-01-23	Active	bsgc1zg66uzprtmp11j6upxg5gr95gbvgcw2o00lp3cfbc82cahgayxljpqylb86g0gllkyjxsopqak6vyvlv69f6mptckawtuy1qp8apb4ofo2gwhs9
8a662ec1-c4a3-42ea-9022-5bb4b36aa8b9	H9CMYQ79S1Y8	Davis, Garrett and Rivera	Lakshadweep	2022-10-02	2024-03-05	Active	ozjxgup51w8xcizidghwt1wgoqq7irlmrz7ephm8jqeh8w0f6dko6ox39bij0tcipaoh3940urrg2kfezf7mgjshg98ihlleul5a27ngwj9iz33abvajlnh3obi8ukz6nps5rttq9m9kmu1gsbtr28yp9lmfzoc
67165400-3def-4af8-9ba4-018746eb7c84	PD6OUYU5UAZ9	Raymond-Davis	Andaman and Nicobar Islands	2024-05-20	2025-01-14	Cancelled	eui4tqz5wk8rnt7rt1e1je2rvif3q735ls424biksx07amjjiotetz1zvtkk0f7qd6b9t3mes4d6kd9tof6tdwthnu3vunju8er9g8impahil2d3f7ygfb7ywbssfse6up4rxnhrlkddzxd7q438touzjvfwrlklx1iaahhdv
ccbd0797-2fa8-4f46-82e9-9a103d71d431	SQTBPTKFBLL8	Montoya, Davis and Mack	West Bengal	2024-09-02	2022-09-28	Expired	omf5f4crex6dz2v4m8l57i20qcjveaj881wtuh8kzfgclj53c5e5fya6aqaib
29b9590e-7eea-4204-8db5-014444836462	W8UHBO55FWA3	Cruz, Allen and Young	Kerala	2023-06-25	2022-03-23	Expired	s1v7aid1d2shap7or9k4osfc6mjuasisrnn75lw8x53js9kp3tp6qpg9q1lczbrx2avws2k5ohk4ykvbja0e71optrxxfoucbcmnkruutqlg7
169b25cf-3331-4019-9f95-8f627ecf360c	ZWQEA5OKGTZE	Foster-Harper	Puducherry	2025-09-21	2023-11-02	Expired	9ixje7w1lpu7b4rp2wyrx2kl617fvo9r2yve0pso1t8tu0q2xqfqzot4jjkxbhi71d21dmq8syie9fxm5qlk0zy18jl91mil1koj2e0hnu5iox9xsugrmkezddsv42hx6olp6f7bht6iol1su11vx2oc0r4gcgol969eoxewdbruza763x5th1jo3guhdzoymtm
0f15988f-ed9a-4d4d-803c-f388f6074cac	NABB4TQ09JRR	Nelson-Weaver	Bihar	2025-01-19	2023-02-13	Suspended	nk4uma2snm378kpkyoo7ylh10l4dasm68fyd8x6k6qi20wpfoiv7tdlm4jcwduytuvacr8rkq0gg3owbxrfwyg99kmpmkwfn7si2b57kdjn0ms2dpnogyftqkppli8hcy5upumlzldfmh7s7e8bgxjiu1s6jwsmj36q7yhtk8ubva1p7
ae78c255-b296-4579-8c99-6876453467bf	J5CU41CWEQT2	Grant, Esparza and Robinson	Arunachal Pradesh	2025-04-19	2026-03-11	Suspended	2qkrneqc2wemm71xhi5hcj9p9q7q2aluanyhhtbx0lqib6ta8a4exk30wz1ianbns3m3t
cb4d2414-37a1-49a6-bacd-824f34a64b18	TWDOFEELSTIV	Andrade, Joyce and Ramirez	Karnataka	2022-11-01	2024-05-07	Suspended	lqzw9yrzqv6hsn16r85
b141b7ee-3772-4f8c-acc6-cd522a1722b4	CCXVWDDDGIL4	Adams PLC	Uttarakhand	2026-03-05	2026-06-07	Active	rjqys381aljl4arvgpcxwmsffopc7b0pb5fe21tlkd990gst539a9xt4hgy1h0kdq17r0bsehmhg54fbdgr56nu7neikgkbpqzx877s7g6c60kmed9fayc7j4lkt9rhdi4fu0vk31yp5lvytge9f2uport
59021d39-bddb-49a6-a67d-1531f018cda2	ZVR4GVMJC4NV	Spencer PLC	Puducherry	2023-12-15	2022-03-13	Cancelled	w37zxdotbgdwgcz889ty0j3q1acwjcowjb6pin
06a08921-b10a-44f0-87d1-c58332329728	GIQ5KTYH93Y3	Neal, Odom and Brady	Tripura	2024-03-24	2024-08-26	Cancelled	ryngq548ulawj7aokf4jevs1okl5lfil5xcspl1qiiwa88gqhsqfsi4yufd2cr5tdgqeu190j591n1cl3rpzcvx8u1ai9yryxyrz3vbr7x0767br9mpovajpgiy0syy73zgtvrq
9cf9c324-41c8-40a5-a946-c07907103596	VR1YYR8B701U	Todd-George	Bihar	2023-04-07	2024-07-13	Suspended	kx3j5hl9mxqgkibl5962avb3zlyml4s9673dkyvxt3b1mu2ygmag
84d7d040-a9ec-499b-a1bc-4e48ba5856d1	SFTXWIKCMYSA	Moore, Adams and Gonzalez	Nagaland	2024-04-14	2022-10-28	Expired	5ig0uerlvokdrpdsjp6kf39dcf3uryhdazizqnnjkha5l4iw7jzdn4mnenm5kdf566cp71zdrbvjrf8whexstx6tmvgm0wxchxps5g9i5u
24773095-2c20-4fe8-aa96-1c9eb8f99f68	OD5DBE7SSMPR	Pope, Reese and Webb	Telangana	2024-12-04	2025-11-21	Expired	1h46fd240idm4eoft3p42ll1221yau74yjcyxbh34ocemximelfp5w0mnna0bv3dqrudapn2oc1h35qw3x0363vxbzx1nmhl16qe1c2nphdpgno9zs4wx3wokbhmyvpiaw16ykvpf00756yk6zlgnu6cjbuad3u4jg0nmg4qs3w9ywwfx9sl5hsftxwq7rvp
e26d9fe1-1019-4702-bc5a-3a413c6014d2	PL2LMY5E5B9T	Mills Group	Gujarat	2021-09-21	2022-08-25	Expired	5pej4foope8ptamk8wdytpis59c0xbjl9bs2hacgx540gzf76s3zx8bz172g3cwwcfe67twc1ejn13097cmpc417qo5xdpfmz1rycyk2ydyhidbieyzfwltm4nu1b8r4ektwgucnefquuhybgfqeitr284ps5mxepcq5sp3699v0i2dbnh34
d031b3e1-79d4-4c3b-87c9-27269d9d1314	T3J3W1LNTAL7	Carter Group	Madhya Pradesh	2022-05-20	2023-05-04	Suspended	7o1jteju7b32lsp2tjgmzrwqskbbaq8jal16pwls083f801iioc2rkwb8u9tq46fh3ajqmvpcb200nq2noou3h1t91pyughxzpe79o3pkylev5wa12lxzgxvho7u
bdcede6f-2a48-4f28-b646-964ba9064c43	HQY6FAWTY1GQ	Cole LLC	Punjab	2023-10-06	2023-09-07	Suspended	djfmrg2321a6nesuu79lnotgwbnkyve2u21ly6ie6003q3k5mcl3tcorkzeaud7de2op1qv3wesmobe75d99l3e2b7wfi9os4luis0i3qzznkcud3jdfg1eaqzlnz7dlm2osr4t8osf64gho8bmt6m0bqyfaib587ku0a06r5v6fl66qh2fphn2xwzd4t
c4f17e59-31f6-4531-b734-ab7143d5652d	0DS6PRAZBBZ5	Meadows Group	Lakshadweep	2022-04-27	2026-01-01	Expired	g853tfzv9lm17qjykdomwc9vnwsbye
3b067b73-ba98-4f2b-b10e-c39692585e9b	IIW2WA7LQVST	Johnson Ltd	Lakshadweep	2021-09-24	2026-01-10	Suspended	lzuyideh5tkverxqmevxnxb5lkhq56xhm4y3vgeyh06v8mx5jaf1rvcjv11b09ikuq9eq
1210530e-20d8-44aa-8988-c0fdfa0579fe	NZJ3DFLWVLFR	Jones LLC	Delhi	2023-10-06	2024-04-10	Cancelled	rzimg384gtm739uc4ihu91latrrujgr4qlvu49p0ayyk2f9lcrk0h1b6lpilvsu9n891b87s6h2okwb7v8hmirbm1ft1j3d0eat9f7cnd4uwrg98hsnesjf
c60c84a9-e7df-4e6f-9ac0-0bac7173135b	BMGGCW5VM9DQ	Berry, Monroe and Anderson	Tripura	2023-06-20	2021-12-01	Active	uun4mzj9oa7kowe0sxdd2aygmtmqfccpo73sylcpguqu1z8bji12q4885hf3zid939bn
a9f46cec-131a-4f22-84bf-3a8c1e3f5842	81M1Z8XQR0R0	Jenkins LLC	Odisha	2025-04-15	2023-12-03	Cancelled	vriuej0cu68rodud7svf67woilvhht7nx7o4sdjbovm4v9wm9cjojf2x027fr1mnu1wel57hpldr99
b403b7cf-4cda-4e50-b731-4c9e4f36da20	XWPZ3FX9ZUR4	Bennett PLC	Himachal Pradesh	2021-12-21	2023-09-02	Active	igxw8xgyq0kpy8wyx7jhlrz
8d5d9ce9-8e1a-49b2-a602-ca49fd2b78d0	FYBUV5Q6OLEU	Barnes, Gibson and Holt	Ladakh	2024-09-02	2022-12-18	Cancelled	of0e8zbmbowp37olvkc7ejlg
635ae668-3016-4ac4-a0b2-94a5425921e9	6DM1983C8BK2	Brown, Nguyen and Watkins	Tamil Nadu	2026-08-22	2025-01-20	Expired	gie4cm2i1jquao8td7cgif0c8o87scsze81kfuu38g3ywrsatmjam0sxui4em9awl9p5bm5wh3m7cte5g70vtk8vll9aws210y1821obnwzqwbjemidud7of097j6oait2colf6ejf5ycin5nd1
9a2a6ad6-2800-437f-8e71-f4983dc91803	1BAL9ZDT2IX5	Brown-Santos	Mizoram	2026-04-06	2022-12-25	Suspended	miy7usuga42tvkm7a21zdnpc2creg9y8gqckt2t67fk2telc4xtu2v5u6zdgo5yg8vabxml99epeemhygx7vwq1eapy0oyei6pmaxtss5g3okubo3padzjq3x6pc60vih9qz84oqy
dd34f93e-0b01-4a1d-80c7-2ff9d7e1d6fe	210YT51CVWV0	Monroe LLC	Andaman and Nicobar Islands	2024-11-16	2022-09-15	Suspended	57j3eh92ljmxa38qis0lgk60sk7pkenzkurp1m1n3iq4yzpb
4ae7a449-f922-4369-abdc-ceab9c88abe4	1HS1BVLQZ8OV	Jackson, Myers and Tyler	Sikkim	2024-10-31	2025-03-13	Suspended	xh6mtxu3rmkajuyn3llu3430t21gjabnjkejday4mk27b6payuzpc007ra3479jiczj5fjvrswyetx60lxrctzjek1np5o9tdi1yqnz89nxxjgchlgomwi16t14n7ti5n5a7khxo70uo91arr94d06ob5rufjbew4nfa29s1t4z8qp5ngu7sjrmw58r
c5ec7809-a124-4df6-9a60-25db46f7d006	KSI2QM0LSQ7E	Collins-Santos	Arunachal Pradesh	2023-10-31	2021-09-09	Suspended	cuatzv0upot1oneyvm2wb2rikfovtcf98ocdcx95bbfbg4z9upu48i36hswn916po1t
9fafac34-bc8a-4564-9104-3a3922126c8b	PO5M7UM1BJYX	Ross PLC	Kerala	2021-09-20	2022-04-15	Suspended	h6388umw5ywkncftm3nnkzmsyxkat4cnx39elcb7xt6lp0hvsmpiobo4odx9l3qcjz9psixctzk0xzubj01bt18q0etx6gug22j4vbyx7efdsk17ye6xhbbsncqn73u1e5jgnrftn0gfydv3xhdcmhedvqh8
be935d14-e814-4d96-8965-6747cbfcad08	A33X9NXY1HYQ	Hicks, Davenport and Hernandez	Rajasthan	2025-05-01	2022-10-12	Cancelled	5plojmfzl3j5fmz66bi59ctz9dsbqa25wpib59y303ss6q4e9mfj9drlvfwomn5cojgnsg774hjjk6qnlge2za8134sgk3mnrv73q
e626e691-f144-4e04-ac02-0d19343b25d6	12UU28NE8EG0	Little Ltd	Kerala	2024-12-06	2025-05-16	Suspended	ezroqe3whtlmt1igjontfh14hidex8y7xjyjrjfkk8oowfkcl21czkil4ruovlu63lv6ptrbbmgasyj0jh28ah4vs44e88cnrqj7jfz2hebtdwk8689iuv8fzhgjjsy
63d73531-bad0-4a27-b980-2f940f4e7e54	9SBR08KZ5TO2	Morgan-Wilson	Odisha	2023-09-25	2024-11-15	Active	cnb5ylailbx9mmlagkfpsji4mvvfssrumww96h9zijuvhx5fjdna2x9gxmybytdls9jybvs05rw7fvlhd9gbp57
441148fb-43bd-4be9-b731-a16a9f98d3ac	GE79C9LYAAO6	Rios-Rivera	Jharkhand	2024-02-03	2025-08-09	Suspended	0bxf9akbewa8brl4xr6nleojjv9vj0x7o3g1c0fv115rlkcfwweb19wz6dedyxulma702ksw32nyusj7krmrj0r17kd5aj3mfpi23bd7wjney38w3p2gjko
143542cb-fc85-4131-95cc-5a8b0ea30de9	V9TCWH50C1VO	Kline and Sons	Jammu and Kashmir	2024-12-15	2021-10-10	Suspended	skh067mq6img61n3mshxisma8jwso868026tdb7tqxeda4
61bcbf44-a7d0-449a-80cd-459f49f2ebc8	J5LR10SWYGU1	Lopez-Flores	Jharkhand	2025-03-23	2021-11-01	Suspended	jasr67c5q0m3sir3dqiyk1dbp3zusuqsmr1pus77ex3oc8s5sqikcfqzwu1jgx2s1a1v41pppomb8uhfr310xdc7do7v36x62gjgpfo9s9buwhu88i4sexhv8me5ztcb4yadtnp74ejtw2mjuxvmyzrnroh2p4tzk2byi2hj6wr34inxklcj8be
2868683b-3292-457d-b8b5-d23799350600	V4GTSFUDSIB7	Bradley, Riddle and Smith	Punjab	2021-12-04	2023-08-09	Active	plazxpye6wka5i7eoj8zrfod8v0tfz8jtguvfnq
e5105550-a84f-4e4b-8bfe-bec565496a86	SRYEZNENBCM7	Oliver Group	Odisha	2024-07-25	2022-08-14	Active	rftuuigkwti54dfm3g1sxf3dna3i
1f88c7e3-c296-4e66-91f2-fdb66f4768d8	G4W3S76GLM77	Mata, Stokes and Sharp	Tripura	2021-09-22	2025-12-14	Suspended	jwvl5kaw7s390kqqd8cuhwlk8ca13aaxip4r9j4rno4hw5ubg6rklj5urgtua85byckb
c059094f-36a8-453e-b8a6-60268a01e70f	7YAQYBNG0V65	Day, Hale and Phillips	Kerala	2022-07-31	2026-03-05	Cancelled	98cy6hbbvadtsspjdb6sxt
e07e6292-69a2-4657-932c-4aee7b60fc04	W9RQ9BSFUHTQ	Peters, James and Phillips	Odisha	2026-01-31	2024-03-12	Expired	c18dha8bw3hjiokwfod5jpwdpmazpwau580nmuuaul03y5zbtvhle39unjy16wkokuczdr2szzh2cbvrmr5lg7vysh3csp0te9hzskd8ip403bj0zjxdqnf2h9yd8n9uhj7iwkt7hh3ys108uphohy
8867f87a-648f-478c-96e9-454f7d6af6cd	88ZDSCF9YT5R	Rodriguez, Williams and Aguirre	Jharkhand	2024-05-15	2021-11-19	Expired	8pd36nw2rvfeb3jr6pqu3gn1x90upqd0hnkw5llxw1zxr9txzbav7b7rq88jj9wa1cdbuwyt92kydi83y5i0r6ubgmbc926nlfuskttg1v5v2m9qhypu3b8gfl6bqubv5w3gg57hz59kg575x0lxdtky05j2x0zc4lf36st94ljf3ely2jz
5b6b4021-f5cd-47f6-9674-4132d61dc7a6	SFE2B0ALXBAV	Martinez Ltd	Uttarakhand	2024-10-17	2022-01-12	Cancelled	rogj74p10uf8h1k826kv9zfqov9f1433ygdqzjv7bn6mm2efawjef0dd3hsnk18sq5qd9xmew8f6c16vj2dzjl5mll2jqe53q0vu5ka2zkbyefat3s9kxuffxlu2fg9v107w91dr1ps0cvawnyouezzcydga2n6xt1rafk2pio23xzvg95ied1kzgsrwa9ux22b59w
990111e2-d3be-4a9c-b245-d732f14a9bd3	UC4QLUOV1N3C	Montgomery Inc	Dadra and Nagar Haveli and Daman and Diu	2025-02-16	2023-09-08	Expired	t0wo6801o7rkcjmowl
9705826d-0e3a-4cba-ae39-40165e8d4e19	FNOD5LVS4AD0	Matthews, Carter and Simpson	Punjab	2025-11-20	2023-03-18	Cancelled	v1fplmkmf16yn70nky3h6zbmu9vhjanvmf7dktsnf5ednqa1pxznfinpz5
ab62d7f1-f4db-48fa-aaeb-ad7fdb28028d	C6G4CMR24JIJ	Brandt, Johnson and Anderson	Haryana	2026-02-16	2024-05-12	Cancelled	g9awne8r29s5awmtosziq4ov8fvpamamo4suwrznpy5pqmar3hddemw7y1r0cyukopp00ohq4zdjfxucialqea56iio7ghmjkmocte7wa
be3b4cde-4d22-4cf1-a9f6-fe658b3c8d7a	1OAJSJA5H6T6	Perez-Berg	Chhattisgarh	2022-06-16	2025-02-07	Cancelled	alhfotvh0is3xylw2q2dkbrckjwpgegy1jpz9n2rvihqijdd0p5n99kxdmtyydqjedtnfropqkovrj7awoz7ifitw
dffef69e-d748-4f25-a928-ce93fb7b133e	T4BSNOLTSF2C	Hudson, Gray and Flores	Odisha	2024-12-15	2023-05-28	Cancelled	5f9yc12r9jm2rd3o583v9nndcizjbg9lep2dru4e27cewc1lc0y8uliib7gvwmh28dtqz9owo2anog2jxl0gkdxc20e9srkd436p0znmep19rk4rc6srx8z4odf2iqh14xmzq6lqdil5y2oo19ggiwrtdpgyo4vamn
81cb121d-df2b-46ac-9a2a-d3a9c4aaf983	RD4IZLERL4NH	White-Martinez	Chandigarh	2023-12-12	2023-05-27	Cancelled	7zhqij3wk2tqg8ubdqsbgkjwn4qbxh0l943r4hsu50tlj4tku3cer4uz9obcwqjlf2niirrj5pxcjpjl8mt6f3e6kxoprh54gf5j9thandai1rnwyid41pihzoj7b8u3unfu34nswg
dc116af5-a57a-43d4-aad1-bae97d4018dc	WYWF9FP1FRBB	White-Hodges	Meghalaya	2026-02-11	2023-06-09	Active	wphrrurgajy1bc1xsrwyaee9y2okbm2jb6fkj5qx44tk3h0616zamltbyclavf7cfpio2nd1zn2z34nb9pgcq7gerqqzb89x0ujwjvtyqitsb4qkx23wqaa2zgnz8
4eb2da07-888d-4615-82a7-2aadec9bb6a3	METX95FMS0R2	Mckinney, Fields and Caldwell	Tamil Nadu	2025-01-07	2023-03-07	Expired	3ds1ew8lsldklsalkr5vtka5w4cwe5n9dhn7rn8e4vf3i5vg7zg6jkvekjrg3x87jqquco7zozu3
663f98f2-3b33-4d28-a9ba-8af8c42b69fe	BINL9ODNSMWZ	Cobb, Little and Garcia	Rajasthan	2026-01-24	2023-10-29	Suspended	fzk0z46n4gajkdj0xliub0t0j8aegup28fucrkixu16y11pfeenk75h7ims0538j
b35692ce-6e50-4649-99af-70bd927d2739	NWSOI4CD0IZU	Gomez, Lopez and Mitchell	Chhattisgarh	2022-01-01	2024-02-16	Cancelled	ua1wzv49favkjgdenp7zgt51h7i4hiw7d76enzy5n48zleeg7jdp9vbw96f1buzfianvphbzdnebvjh038g3e1xug0wj9ks8riy3upvamywa1guc8u71of5qz8hjzrlp79tww6yo9b8k1wcpdx10cauuqnq6dlflktq7jf4k17650ait93qvd5hdx
19222549-da9a-4cdc-a11e-5c6abfcf7651	BPTPJ1A48I4D	Ingram-Williams	Chandigarh	2025-09-05	2023-05-05	Cancelled	jzygg6hy9zi7zn1947qami7cislncs6uusqi0pix36h3pd0yjs2fwxa5snntqzp7knb26oxp3nyi813icyxp96qwmdrjs
0ec63995-9b39-4e41-acd7-50ec68208f50	ZNSZURA39FC4	Taylor-Ochoa	Uttar Pradesh	2021-11-21	2024-02-15	Active	dfd47lxv09v0xv3523qqujpjcuxqn8ygmel2rwansdhr1v26tsd78heqj40z2a0xecnvjfv3r2jod5085vhoiqf3ebm2adfi60rbz047rxqx488zffrsvv8xxgeiggzbuubpw84ha
330df436-468f-46b9-bcdb-ed019c47918c	1P13IU3X9U9T	Decker PLC	Mizoram	2024-01-12	2024-02-29	Suspended	1x9c5isrv1ccqdhpftyv1q6lmsvcino4s7vok46igvtpe8dmbct8aj6l9pxi3krbe1t71o9nfrsa1a1byogn7goeo43q7ei5qb6xqovtsmeei8l1jlg2q2tjq2lz77jpd7pu1breimztn1nr7i8a77isw6
32c7936f-6e9a-459e-be2c-61256fe9ca03	409V0DNJJ33A	Trujillo-Jennings	Uttarakhand	2022-03-20	2021-12-12	Active	uv86k7bknlnn73jo19kxm7p45k80xsruux6y4m7qh2co9j16h4cphbnc5n4454015emxjc1wu
32f04caa-5594-43cd-aa0b-583c47e7b47f	6TOZRDKONZ9Y	Garcia and Sons	Lakshadweep	2023-04-03	2023-12-10	Suspended	5ze17r6q2dg5cna8jwr7vg6iliiutxua4r973dqz03vi901xo5njgjt5stbtseuqjkcecl4a4y9r1313ezo4a7q4p0mtwhtr79twe3v4ts8agq6uq3wv28c10bpitcw19l2j91b9ic9efkdxmxnsaq88qwirhc60b35sc12
f987f414-4acb-4fd7-befe-3c26439a26b4	QX5B3DDS85NL	Ross and Sons	Tripura	2023-05-25	2023-11-14	Cancelled	49hsr5ksa5cgl130imddht1a26jhwcoukbm1x8392v
451bfb1b-f1f6-4987-879c-5d895d051444	GWV6QI01FS4Z	Wood Inc	Telangana	2026-02-22	2025-11-03	Expired	nd70s2i6fieiybe392ffcu4t3d2vbouqy8y8ss3jfpze3ukuzfatgsufgxcyyb6uxdo3lgp3tb6x3pyyju74g5pn3cxjuv7a86suyph1u9gletpv59x7ypoeg05opq4x7fdqzn61pfndx
2c37ebba-2cdd-404d-9e0e-73d3078ae2ff	Y3H7SC5XVB0N	Massey, Brooks and Johnson	Kerala	2026-07-21	2023-01-31	Suspended	frim1a8yiqcal6xgrokmfvjy5cfqje0yw9y3tzcpr3z1w5azidak13g5db19fihjw6z7jjhra3n5jz88u4zowhf5clltjrsd3x
90d5bfe9-2c3c-436a-b741-dcd81763f9f8	EL0LV969A9LI	Fleming-Roy	Ladakh	2023-05-19	2023-10-25	Expired	puwi21zaozckpyuv4esz5tnwfohbu8blxlzndbb2e2rpatkxrdbnrt3zmymuq0wq3xgfv326jq8nmin6lupjxlu5h4on02184o6cvwn00x2g0bj3hgx5gnadiy3qtaioeg7nh5k25ntyawksircwc8emrsp3m3kz31buh94k5urrjc1r7em37acgtoa0y9a
0ea43cb9-b642-41ce-9984-deaee6a4339b	9NWIVYV15WXE	Rodgers PLC	Arunachal Pradesh	2022-08-18	2026-02-18	Cancelled	w0k2lfa8cdodybu7d9mqreemvrngk81hndlddndjebkas2drcv8iejal6qwyty9t8znlfxxr9rdr4rxbsihumvqzr52qpnjx0phnxc3ktt6weogz3sds16vxod5pivg51kfyb5f
de024421-b03a-4032-b556-d3a5a8736585	VW7SF4HR1I87	Martin Group	Delhi	2023-08-25	2025-08-10	Cancelled	5132d5crkdqkhn
98e2d925-d6ba-456f-83b8-d0719ecac1f2	ZKTNRKNG85C1	Jones Inc	Ladakh	2025-10-02	2025-05-18	Expired	p88rdiy5gir6r5ohhh39i42hbghlm6ei7sxu1p2zuf4ln1ab2
ee7d122d-42bc-4184-b743-31519ac8e14b	M2D6ZYPNT6CG	Davis-Allen	Ladakh	2026-04-30	2023-09-15	Expired	9k3jjtz3sq710r
afc99676-bcd4-471c-ba99-2b4d15f3165d	KTF8YWZWDUGN	Cook, Coleman and Powell	Kerala	2025-04-08	2022-09-14	Active	7btwpifvkpcz71crg9my0ffcntvkli4u1tualxjvc1klfth2v0i2rtkszw5u6el7un6hvz7f14s0aldbzcoynb2pgu4d089iwk64wspghtpd4ufre61lgb2ir6blaosdz3nsb0evxooc6mj7gitldjz9te0ag167fmgtozkzlrs
93e86b14-899a-4944-9328-696e0810d530	5QCLGMRNH92S	Smith PLC	Himachal Pradesh	2026-06-06	2025-05-04	Active	nafjcymku8hag14sv24x7bsmne8s6cu64rmweh1ay0o0fuo5ob1uf78s2g1fo6cj4gstuh
163f6ec7-c999-47f3-8464-ba664f26a1c2	T42EXK50K0R0	Villa-Soto	Maharashtra	2022-12-14	2025-09-18	Cancelled	00ia4nmj3b55iiiwpzor2iib4okoxh8uyq477tbwwbfr70uku4fh50fav81o77x2tt3slicdiqljyklyvogipl9eat67klgni2pxn058g2agqakn0tyjzre9wlnyj2sq1qx4jen8voimdqwihskgbn1mvzpj
fe929125-9144-4770-9cbf-c5df155d6fcd	SLESIG30AAV6	Williams-Williams	West Bengal	2022-08-15	2023-10-14	Suspended	q8j44nwfhgqv72ydxkcwaogp3m2wjz5fpabmdt0d0njhk24e33js7gtcz1thi43d6ph6lwshke
ed9eacee-b45e-4fa2-bd27-0b186ebf902f	LE78LJLU1WYG	Bailey, Rivera and Barnes	Uttarakhand	2023-07-22	2024-07-11	Suspended	6bsd8r9rzu4aqj8v96jd59oz7ky6w2g10fh3o7tx921hy7otfs0pv4xqo6ak925e0dv6u3zzhcbf5l3m5gh3niwcfd7cfl39rnsrb6sis9yo4apc45445tupuc67
1fc38f73-66a0-48a6-94c2-0d678e23fdc6	BIS930RQBQYA	Harvey-Sanders	Uttar Pradesh	2023-09-09	2022-05-26	Cancelled	v7ktc5nvt3xd7uai1zuyobxbq9y7q7sczr0clhkai78owspuaxocu0a3iot5pq677nj8tr5bjs3t0hwcoe8nszl3up9
afeae988-c7c8-4a8b-a27c-2ad0f0ef7ace	OW994PBJ9GD4	Little Group	Puducherry	2026-07-28	2023-09-24	Active	qssn48kta7zy6kdw2ffww
61d7c056-3a61-40b4-90fe-ce509d14fe99	5FP3D5L2W6FJ	Wells, Porter and Gillespie	Haryana	2022-11-06	2022-11-09	Suspended	o0xffsf1gmcoscnd4f1xmwcsri5xh47pv1asrv2mmco7x5822zmvd5itm
9e5e300d-e2e6-47dc-aafa-600919a8a03c	9C0PL0T9LFPX	Bender PLC	Jharkhand	2026-03-12	2022-07-31	Active	jxav8lde94ur7a7m3lbch4b3hfiec5stm4gsdk9f36qklpv3hqwz4
7308d3cc-2403-4299-82bf-b012157b6b9a	DGNN9R67KWND	Davis-Smith	Manipur	2023-05-17	2024-02-29	Suspended	z67153a2t6o9s699jzbsoytcemln0porro667x0sllr47ij7w81e3v6vno68xc3b7dxwp472b8itc6gihm
bcc1f6fa-b9cc-486f-8801-3adadc2dd717	W9THG2L47IJH	Roberson, Smith and Baird	Nagaland	2022-04-04	2021-12-23	Cancelled	fpjy9ebkkesaqji45fu7vdg0e48ab
0af020fa-dc15-4a70-b240-7577a2313260	K3HP2Y0GH63J	Allison, Snow and Soto	Jharkhand	2022-10-18	2025-11-07	Suspended	ranue0yiu2burs1jeq263jcil88rgyv0f80zpwt6z8igef36cg3cgcbqclbjt1bd65azxwluaquwktr6i92zrx3nma95zkblzo7q0akptg972znht2zm7shfvv1deygkd9znn9tq5t2m3hh9t2i9w29ema0kj3t0zts5mhu5it1hmik7stjzi4sq04i75amsgy
b18c3e66-bed9-4ae5-9a50-3255e77c14dc	7ZONMHST3JXI	Ross PLC	Chhattisgarh	2021-11-21	2023-07-01	Active	rcowcubx3lq4cui5ndpnebqai92y7lg3vbwcw8jwsvwl3b314roa4z0vp0yjmx4tk23santwspi3rb537uhqtcqxfxex1m5k2eecdffy2byitptwycp4ahlm7k69k88xwgqu4hgkyxtfixhf7wv9xbo
4af6f41a-2f6f-4e27-a4ee-7b9b9be738e6	Z2SGWHCV9IHJ	Smith Ltd	Puducherry	2024-08-28	2024-11-26	Cancelled	9wk6r74x2afzmfo7rq7kswhhm0pkc22mcod2al47cmjd60bmb9h39sr2ni4nlezm5nxacod6gapx1sxwx110olxuuvcd23c70408d2raoupk6htwofozguv7obuyrw419dkvvj5pwi2p1bekp9pgiqes5tmnqnrm9jaz2zmugouah4oym
5a0cc5b4-e951-4732-a7f0-a76a84a78f87	7WIOS10VFZDC	Watkins-Lloyd	Delhi	2024-02-02	2022-12-16	Active	850e95ks4zu9hrqwljtxo8f55kuscggg6j3tyuwqicm6h99hsfcu7foey3dvecbn70h9hfnyzkaazgj4czliem78acpk0g91fj6cmh5t7bugvj8szfvloztku7g0pthivzp52y
271b7717-c668-44af-9f23-4df7e0608172	UHATY8NCNNER	Navarro Group	Andaman and Nicobar Islands	2026-08-10	2024-05-23	Expired	yapd01b1fjf44j8a0cqx1kl15ofpg7zv6ulvt8xiiywmho1k6uuvayhf
dd6bb13c-9a12-49be-b9c4-f483220c7be0	JYH1ZXRR2XDC	Johnson, Robbins and Webb	Andaman and Nicobar Islands	2021-10-05	2025-04-10	Expired	2ufax5vb5kgdwjv5vm4hv70on8gz19e3fqmo7ze57lfhvbyi7ariu2eylpmndzix9e3gabbavwth40x8s3xmczgr3ec9dtskgoy1ja9m0v5p2knykxr2h9amfx894v07vburhea8i3zal8iajbz9c65dabq5mwsxsxts70qsvp6ryhth1
7ec460d1-04b2-4bc9-9b03-4160eaaa5a35	RT76JK01NGI4	Cannon-Duke	Lakshadweep	2022-11-20	2023-07-30	Active	nbn7brv8ewx16wzlmf7rs4t8q70
b240bdeb-6c27-4c33-981d-32ed5ef0d9f9	H7FB38EFYKUA	Vega, Heath and Barrett	Tripura	2024-12-09	2023-12-16	Cancelled	fcdfiiokjbr2q6jgmt3ghi4m2f4hfwaeu41w9ln8i1d7h8batrervk3ofs826h4oo4461zt9iiz4yd1vpgwfxra7ett24dre9vxrwgqozam9bn59sh6li3b9r5p4xtufu9n24wravqjmsd0dk9af37sk8w5l1isrh5bjb4f0u6u05qh8j9cs5zvlvlxcfj7
bf3ef699-db19-4947-a9b6-c916470d69a2	M17WCVBAQV8B	Tucker Ltd	Punjab	2023-09-25	2025-02-17	Suspended	ckyzc7rv2fvm4wh5p1e1
9003c2dd-3efc-4395-8154-5c1983838282	CBMSDGK51UV9	Anderson-Johnston	Punjab	2024-07-21	2026-06-15	Expired	1fl7k5ereiiq8eve43d22g9qqn3yudkf0v6qq562x96mynppc73phif69bbvpmnrc2ukr67jsk9ulm
382dbacc-65e6-4c80-9ba6-02fadbb7c0c8	9QFIYW76YG2A	Quinn and Sons	Sikkim	2023-12-13	2026-05-22	Cancelled	l8o2a4wbma3phezyyqu450aijify6wpygyzxger91wt3v75zy68pbgnjhfcb1i3mfaitcb7yy88sq6o5gjr6nvs4x12l0k35gywge67ofexvzv6ksortbynqqjf00ucbypdbd4qqk7hldccqkadqm480c6646mpvh5t2j9i17rph8fgt0t5tihcene7g124mfd2fpr
238068c2-0937-4018-a2b0-7d7a8a7d0ce1	ZSN5HVR3C46H	George and Sons	Manipur	2024-10-19	2023-03-16	Suspended	qqytey63fsqaspm1gx3h5bev318rnwatahx1ynmgiuf6j15pno17wv7srtube6ufg667glqfeqmnt2ym4p5a6q8xh6rbdd3e82j9326qjv4yf8q93zi8rijccri4dteqmsg0ed39gbyf42q36yewdbl7oq89exzzvq4qssxuog6ohq4qco5y4z3qxrpfhtwq4jv
b9f72a52-d340-4253-a1a7-d723c96bdc11	WYQIREC48YQH	Rivera, Garcia and Gallegos	Karnataka	2023-07-11	2021-09-05	Expired	rsjofexv31lad
360bcb15-2d58-465b-a28f-836178958f26	LQ0BJ3IXU938	Smith, Bond and Bell	Lakshadweep	2026-08-19	2022-04-09	Suspended	fmjbv8q3jbnkf43ku1el4djxv01w64s0g2e
d29df956-0644-4581-815a-12b1db9f7ad3	LC3WBAUXXUMZ	Stewart PLC	Chandigarh	2025-05-29	2024-05-23	Active	qz3rya2xaelp3wzdynoz1thboo4hg6bg9w6ty3xzmvnddev18nyjbl9aqqznjj6tjxl9uvesxxmvy8bmrd3n74psxms08w6f8em4ktj6gz79mc4apgbd14wb5ugizf4eck2uhteq1kwpysmmsvru2
eb0498f3-17ec-473e-8ac3-8cace4d49e02	5P81UFYHBKMB	Thompson, Villanueva and Patterson	Maharashtra	2024-01-22	2023-05-05	Suspended	euth1q3jcta1sz6pije1hk5yrl1777w61fouhm5nc
3690dff9-2db7-46a1-987d-a4c80ebfc0e5	4S4VVDXCNFJ2	Wilson, Silva and Stone	Telangana	2023-08-28	2025-09-08	Suspended	l3fo4y8zg8hg0d6gapbrjmf4r9ntoclx09v6gswld9z7phj80xycwizb8sef5i0mg6makokpnaiorfok80kt2ttsyi9wctvmf98u6n6cufno3rv97v2iak1wylgapo4kzko8n70hq8syd5lxxls5266xm1r4tcixcdzso
9a249969-cca6-4f5e-aa31-17b638550958	ON9LS5PC1GPE	Rivas, Thomas and Walker	Delhi	2026-05-19	2022-05-04	Cancelled	qihqxssqn4ixjjn9w1ut6o3l2q6w95iq8y090dtvziteslrdycorc1zsvpvo7tpyec1lfxilj825bvqi2nq314mrtaa8c40317dkta0hkwuc9lohmz7cwa3zl5bxywjigq5qbydy8hwxdskh293zifhzpxo5y5wv2
c9ba5b5c-1a4c-4207-a997-f4919160f411	VQD5PQ0GRBAG	Brown, Parks and Fox	Goa	2025-12-25	2026-05-26	Expired	ashw2o2rs372opiejog9jzc0yjab22589i39dshavag3186hjh2je7swkpptx7vmeth6yte1417lpr2vchfdg2ow9y9z6kjjw9k313v2ji8dp5cpgk8f9vs4z84s3f4vh8da2f5rtrs29yt1zp7w
d3b9db6c-2f31-4888-8454-0f6ce3f429b5	A34O8G527DDQ	Wright, Boyd and Shepard	Himachal Pradesh	2021-09-14	2024-12-30	Active	wpwore23d0csgwz8bw7yiex0p7gqo01nded25wn6io6qlhnijuhb1n71hsby7nylxr8xcnlsumcun7vhfo1dzaf33yzglbzg7k867wti6rlohkcmzwor0et79ynlq1x2r1eauv7xx9pv8i2k
df48bcbd-392d-43c7-95ce-3cc0b1b4786b	5B0L0WMV0KQ1	Rodriguez-Daniels	Haryana	2023-02-20	2024-04-30	Suspended	4y0poqbf5hfnshz3ua8qj49n2hho08wjrabklnq7z9j83sl9ad6h6ycepr2df6qrm35sagjwycruxf620h32kbbu5uhesz1fwjsjkbfj21khjv2oh1fzbi05xw8ybaj4yd3ben7h9j
2473926c-0ab1-4fbc-a20d-7e9fd13a2e36	G21MWAW6DDWD	Nguyen, Richards and Sandoval	Jammu and Kashmir	2024-01-31	2025-10-14	Active	zlavjwxjvjtfek4ct214idqgf0bv2cxb4e607tmbudbplg2dbwj8movlh1epd5z2xqp9u3uciac257krszux8j7kqcsmfp01g34jrsdlcn90h8i4q371bcot0rdy84vb3mp
1f1f1fb6-42e5-4d6e-ab77-676dcaa91d7f	BYEHZW94VKMN	Sanchez-Perry	Ladakh	2023-09-11	2025-06-23	Expired	qylz3g15rz0rs0o7k4ophoej
05c9200e-8832-4856-a104-7fd0575ca476	2YW34AGX7HYJ	Adkins Ltd	Manipur	2024-12-29	2026-07-07	Cancelled	llz2tzf6hakxh4cf02iqy4h7jwlzur93ctsq8chadh1l10cgwdqhxbqat3fbshumfxrerkftigt5qb2cg2jsus6ul2suo3mwn2cocxqf760ztoy3h21hwak7lh37a52s72dex4s9qyng9xe7vydj92aj
59b83a67-2be7-4de8-a34b-b60b28602bed	DVHURN14T8QA	Medina-Hawkins	Delhi	2026-03-11	2026-03-09	Active	g6x22b2x2w4kj4mw3a27ku2jsso9dtd8xm1ac4jgrw1pmzygnxrilmufixigyyh5jz5272odm752i8p
874265f5-3b75-48b8-beeb-8b59c1e6d66a	KXSJXND9SOHM	Wilcox Ltd	Kerala	2023-12-14	2022-12-26	Suspended	hckjq2dwmjok4vp9kw7pe32f5caikvx3gdr93zmthqd0k6fsf2d2k5tlbgl6fpebnht6eodw4x0e13ahahzttlu44wd9ubkyscst4c3whpc8adiao4fjnwkt2nu9lkedid2tnri
064f98bf-88b6-407b-81f5-ad4716310151	EA0CMRC6UILL	Ramos and Sons	Delhi	2021-10-31	2023-08-18	Expired	nymbk7al8rqteuq16c7li4futgwk9038dc1bd40xf9f95jhez7f6mlglyohvtpz8to0oe6g79yahflogk1v6sba9uia4t8kxs5rqmr5qekri6o8521ao4931km851gbx0o2gfrcfj26kja1kuqqfswdla8qcfch3sj3cke4ykzm
f46c24b2-4fd3-47d9-a9e6-0f9e5ab12374	F0SMOI77J22K	Williams Ltd	Rajasthan	2022-09-30	2024-01-26	Suspended	es4f72j2admr89xouo8efds9xkv1s4lm8322kptlrl3h6291gy1ptoy9tmg6a
b39b94be-9fc6-4b3b-a332-d21fe6e3934f	76JBIUE72OTX	Porter, Taylor and Roberts	Karnataka	2025-04-09	2026-02-17	Active	4jwl3ztw3vsu1nfuv9j7nlomt77gp0adniyfewg5aznez7rrwu8e1n9qw0ki8jodex1rwl9q5ji6
42d28a02-d8ca-400b-8e17-b969cba96bd7	YB2DS6YT73PC	Mack, Alexander and Holt	Chhattisgarh	2025-06-05	2025-11-21	Cancelled	4jj57x90uaxcp
b5db9b9f-026c-4e37-9eee-277efefbfa8a	ZD82WU3PKYMR	Turner, Skinner and Bryant	Chandigarh	2022-02-22	2024-10-27	Expired	37f27uikc6ibl6hpb800ju47tbdhytdpaajez9n8pd89p1juan08jrse4zwbx7awbmxr0aoivhkcjgtbm8lm9jtrudrfwpxpv8piurqiibho2idqjju5dq8mo2as337ujmfhvv7ejp1m20eil24plbwgec8yi9cylw68h6uemjr6dajvsmp
7e5678b0-76b7-4d52-9145-a0e1719bafe8	BF2IN1C1IJYR	Payne PLC	Puducherry	2022-08-12	2021-11-08	Active	5cr4zc2xrs87etwveb9af1u2qcfwq7ioepecb4nn7tzi1byxod2o4l4vbg65mpu2h4qo71e1ykinlkn60w187xqvzyrjybu
75a88e52-6be9-47f2-86fe-d134795b7bc3	9TMKM9PF8SR1	Monroe PLC	Haryana	2026-08-11	2023-06-17	Suspended	3yi63dxn4wd0thdjmm2kgeuxyj9j421x9bsd81t1p3o2nf0wy504
4f37c988-619c-4946-ad23-f72c7d2ef010	EQHZ04KX579Z	Brooks, Solis and Carson	Mizoram	2025-06-25	2023-03-09	Active	9a45dk70kgjofaobkugacng40wyp7008nbvod4taiv0tgcbz9965q7xpxh7vmjw7crglkznxv0azwi7u8123aydk8m350t8t8bhthdvl04235r7jizmktkm7an97xfghv1plb0agqnh7avjjhh9dmnpdjvtj2x16ozr6zuco706w6z1
45ea2115-9049-44ed-9518-eded203d3bcb	7C3JNUVNSJW4	Grimes, Long and Moreno	Chandigarh	2026-07-30	2025-02-17	Expired	kdcq4eo8sa722iqxl0y57am3hodp4e54vhp3tq6gf05178fqk7y2ygv240n54s1mhe3gbtl6kyn7p3q6uropoa7k3oc016n8ncnfeaczu8ogpanp7qtp6kndm260uv
740a9403-8bcc-4a47-bbf8-a8a0262f225b	PZOXU7T4V4BQ	Hughes, Dominguez and Holmes	Ladakh	2022-01-11	2024-04-11	Cancelled	48h2kp642wu4cvnjcjrg4lcwo1ip21bk7e34qdaq7dbigbv9sx23ixrs7curj0anvdnu0pqnr85i4z1f3g4faw1e1jt9pypmu2zmbz7wr98icl96swwy4fnceu2o3uzxzgvo2p1hntngjibfaicsubhnn3l2zwt
cd5e3d82-b810-4d80-b930-ae9c198fe9a2	T078DY295XHM	Nichols, Gonzalez and Fuentes	Chandigarh	2025-10-10	2026-02-08	Active	d9tzcilk7e5crubz3osin11r
b3b3f73b-f6ae-434d-9e61-96555c33cdb1	TK4P1SA89GQY	Harris, Sampson and Lawrence	Madhya Pradesh	2026-08-11	2026-08-27	Suspended	444njapu4nxz1mw66nhiej5zx3w49m08dbq8zp9fbhzcvfm7buk2fi119wxb0wodj1qz182dcadhz5t4vieze6zg7l4nfz8fwyb7df5fims5rkme49n5jocy93g0z1embu8mc1f547navcv3by4hh7m3mmskss2vvkwny0f5n6pngpakmtqdbkti11i6ls2s4lbxq0
5c5d0949-057f-4cb3-afd1-3c5b34c2f9dc	XDAO6BKNY61X	Cortez-Smith	Lakshadweep	2026-02-02	2025-04-01	Suspended	1jkl4v87ujuin3y8mjb23ckop8ngsoxvxgtz6gpeyjjuij56t5z98cyyy3nrd55m97c
9dc1a9b9-b59e-4ff0-b4c8-5c960e58f4a4	JEH1NJLUJOZX	Alvarado-Lawson	Puducherry	2025-12-04	2024-01-17	Suspended	5t2numnk1ix7t30av
e7904098-18d6-4a44-aa5b-6e70cf9c7bcd	5K4M51O82PEH	Jones-Summers	Puducherry	2023-12-30	2021-12-14	Cancelled	wqcr8sbofz41vklalxtxzdaett63trvqqyt4eey2mb1lkm4dbmpqws0nakckyky44pnfgjcomb2j5q84o3efi1rvukb0236cx7cj8sikiv25us9k40lwlc3vogn0292xmows096irah5ghypkqikwrwwazb6jl86z4gn55w6mgtkjv0x9zf5gl7ydy8f
b18a3879-6b68-442e-a895-dbe2b274d557	KCJ16TDR5X52	Bailey-Webster	Telangana	2022-06-11	2023-04-28	Expired	bg9l36o2vzkeyoj1c3ssc2oa7ugg2kljkjk2iy3xd1wxfi5ng6itorzqjfhb4d6sh9sdyovw23u5h1cbifwnj3gszaal91h5uwc6q296zn79zse5e38xr2j9x7899snz9
efcfa7c0-cbc2-4feb-8ba4-0b5c86c12e13	73J3OPHHJPXH	Woods and Sons	Chhattisgarh	2022-05-10	2023-06-21	Suspended	lfyi0xp5rd8q1fbrx0phbdhrtpj7vm5i7xbo1heg0fzbxjree7xkds9kawfnk3uq0ud5wqi1iamsw4pqyb2w7fyveob3s32ontjjqkz9m5ob419ykgmlxvx6jpkzak9zagps7yu619nsj50p39ff2ejj0yznvcnmf89e3n1jrpxhndeki2k63djgqt10
13a38f81-8562-4cd2-a16e-89ec33793ef0	5MVNXENZY42U	Flores Ltd	Dadra and Nagar Haveli and Daman and Diu	2024-10-19	2022-05-09	Suspended	dadc99g8013fr3hsg7reyog7kwozkdp4j5h89iv5041j7140hnopi415z0t4khic5mnrlqes9cdzwpntalofugpvvd1fcofppmhnjejam67y9eq6bh2rdpt78yau2jt5cl8c8wi7gp4x5i9jqioeeb8xowjakjiogcs5z7bwine5dilwipvp287g7
453fed1e-44e2-4407-95d3-94e9e164c2c6	VNPMVLV3SV89	Berg, Gregory and Sanchez	Karnataka	2024-11-16	2023-03-01	Suspended	0llbyn91cj0u2glyxbs4b48814jnnnx5lhfxbo1vpbsi18agoiquvvkotoju7sc0hvniziceeu4eqo7njfup5a0ix
85d62100-d7b8-4316-a415-f8d1fb0dd3a4	HZTAODNV2UYF	Richards, Sexton and Roberts	Arunachal Pradesh	2025-07-16	2025-10-10	Active	cor8l2izouisjorl6u53707aa0ml90ioxne8axth8p32
4fe1e704-be38-4029-bcff-87fbe52e74b4	0UK7XTX8W9K9	Smith, Moyer and Diaz	Jammu and Kashmir	2023-12-22	2023-04-17	Expired	w5zdsdfoagct21a74exjhykpkcaqkkdsyvncn380e1r02ogetnf34degzmqp8v3qdqutm4kha07hk4d7lrvjl3jwbiimv2y0ap41z3i8a0w72f2qtuoihj
69839fc5-f6c5-42b0-a84c-bc665d003137	6UW3GPLPA7NC	Robles-Watson	Rajasthan	2026-04-25	2025-01-25	Suspended	kivp49my9xk31nalvhw39vtdwn1vhpcygt0gl5fhk9i0hzs
baf13744-b7ce-4850-85c6-1f728b88649c	M6J87ZNDU9FC	Sanchez LLC	Mizoram	2024-01-21	2022-07-13	Cancelled	jvbhbv63wfbj2aszcmo178k9ybyrncyd3ymiuzjz24v1hsdkojtsqkk45zf43
6c93d8df-6fcf-4e43-b479-cb4d1a3211df	9TFXPSOVGCOV	Walter-Woodward	Tripura	2023-01-25	2023-08-24	Cancelled	09fwpb547pd32hi8vid89pi
31e7b033-45db-4edf-a642-555f8bdf8cca	GCES9GVSN5EW	Holloway-Graham	Maharashtra	2026-04-07	2022-04-15	Suspended	q93nf1wltq8b2st5ilex4rnedapd5iofcj1noq5r33l4ksmqaqioledzqa0o6ov8px2d9xmbora9i6zsiso
6cfe55a6-8914-4afe-bb2d-8b22b3d012c3	HP61S2X9RXZT	Pratt Group	Jammu and Kashmir	2025-10-05	2024-06-30	Cancelled	o4vddrkzb1nsotfnzpfwx86a3ywks5w55t6n5toej1s3k28d63ytshm70o8gdnf5l6ygr9mu083ruxin3goyj5yo1hvbs11h26ht7asjdq7ox9t38kgh25na1035yta0
84d8e233-f557-4a31-9ebc-aaecdddfacf5	8MJIMZQ4SQIW	Marquez-Estes	Maharashtra	2025-03-12	2025-04-01	Cancelled	yb4ku53b237uycxxle7xumod9nnu9lgrz36z2pktfrg8yvtxx4y6jlxhq1hh2vgouf6x6b2qnty4ueo28n0x1rqmt9mw7tboamjdxjbqeu
580d00de-fcd0-4f88-8a73-a5d10b5bb268	1DHK6TFCBDY8	Odom Ltd	Uttar Pradesh	2021-11-26	2025-11-25	Expired	r6gitck3fkyhk24x7xmhie9m3m1yytqx64wod8836wl9hg733nj43vxixf3col5dsghlj3bzjwbx98yqe4v5fo3nz9u9
b798007a-6db6-4342-b800-74734a577027	GH6J4S7B8AGE	Floyd Group	Mizoram	2024-02-07	2022-12-18	Cancelled	fmbsrd9wbgh18p2gdv0qwmgjuxvzz1jhx1n8p1dwg3zdovmpf7a5acgv4vbbji8imkf5h5yqxxynsv6f5ttz7jvvmxj1so46b4s2iui42hzoxhubsj3vxcl136c8w1967hubaqf36fj2u9tev44lbnwlc5j6f9xbc06n04ezjtetc5egmxgkyz60500
94abd3e6-7b3e-41cd-946c-d149c7df90de	FU5EET88EO2H	Griffin Ltd	Rajasthan	2024-04-01	2024-06-23	Cancelled	nb83444jyh0an9148k0qo4w632m8pdhb5jbpauvsdkirn72u435x1yiubibuq6go3qqi2o11d4p05sp4gdz86f94js0tuu2guwnw81pox87rwjfoug1dicr75eg2
3c4f75dc-57eb-405b-b6ed-812c0bfba9de	EA65F12X1O5W	Bright-Gutierrez	Uttarakhand	2022-12-07	2024-07-07	Cancelled	iq50z67ufkvdpu2xr8bz7xhq9n0dxi3dkzph
7589dbc3-2a0f-43c7-90b6-8ccc5ed3fac0	DCV14EF8IY7M	Miller-Smith	Ladakh	2021-12-17	2023-03-24	Active	m9yeclxnm3n7g7epz4aiaotxx5htm39faof7haj9mqb22h1rz52cicew5xegqxdels6k77ef2tvfwqwox3swhyjl33o4svn3nyzjix49ffa1g5rxb9z5hx0k5fbba6tsddqmrsfxjbs0qrxbo5s1za
df8476f8-0b9c-45b7-95f6-ac760ad06da0	RLNRDCH42N6C	Williams, Rose and Morris	Ladakh	2022-10-06	2023-04-16	Expired	66i4og1gsedoy60ft7pgpx71t8ej4t0alvdyze6mfkrzg8igyzzbb9f4ck3fxw8f4f1oy8e6g31chw026pnq9ak2ndc427eu5ohp8wd4jamrwp4jfnl72uo4w2y8h2wf0xnumw5vwzc07ytniabno6r7cggogp5ncxhwqxoue77ktlxvea
3455d7de-5dce-4b4f-a9b8-a19c3219631b	U1R488L3I9I9	Glass-Rodriguez	Madhya Pradesh	2022-09-29	2024-01-18	Expired	y7jhip3x6auknvipr97zn8ue9ozbcfll5mv2lef9r05fl9ms6r19
512f1a66-4e9b-4d97-8378-745fe83f5c1f	5KL1A4OXKXVL	Pratt Ltd	Andhra Pradesh	2025-07-02	2026-04-13	Expired	4npkrcb4
4f7ce824-1c77-4b9b-a9f4-1c86d3c6900f	YJ36DUN06MBH	Rodriguez-Russell	Mizoram	2024-11-29	2022-02-26	Expired	fbbuxk449xlmpkew97xmzj0pmbzwxnvn4u67t26xac8c1c08011qr66xjykmlthwn11oq9hs88c3m81jv121nhecofy8tou7h40rv04400wksgte34t21yq3k1tow7fcxonv2gj
1f44e121-c378-4511-99dd-188abfde6a03	U2MRSIIPZKJ7	Odonnell-Jones	Telangana	2022-03-30	2024-04-19	Active	0hf8cm6asret0tjn2dv0dfhw8dkey10b16923k5acy5ob37m1d95rtprk3r4r6o7dzcwmjs5ian9bf924iqvvgg5rktx6pws133shm9ec9sxwaw7wo535z4rz6w6sfqzftq4wtrynuk0egz51zbz4nlegjy1b1mkybjdjylmslb6u00l2hvhxlnov
296ecb3c-99ff-4f1c-b3f5-c404eb705f1c	VNSD458QU4NA	Andersen-Wolfe	Punjab	2024-12-17	2023-04-07	Expired	vbdtzx40kudl3bh29yqh6dk8sjdlofa
014bb59e-e5b4-4c15-9ec3-02f2a1850193	5A6JZTWTAHQS	Jones-Patel	Bihar	2021-10-28	2023-06-14	Cancelled	xq5sxqp6bbs3pv1rkqlsar5ewizjh96ec3d2cbaizvy5ob82vh0wby6gyb6rr2hgdlrrv2tmizewaauxj3maortcyj2k9qs7r9m45drqg
db27a63d-3e45-4e1b-b0a5-0837e6ca5bb6	5A1ICQKR7UXU	Pierce, Green and Fuentes	Tripura	2023-09-09	2021-09-23	Active	oil8prry59dhuimilmr42rtm24ynk3yy319o55dynngdgrrtiktpxz1h75dt0f9ljvh08zmspaaqkxfleo9gnu8qwj10ky9f71r
29f8ea3a-6b42-498b-899d-55ef74e9cfc4	N2NBOSJWVBSO	Beard-Gray	Tamil Nadu	2023-05-10	2023-02-20	Active	62m4tfkrsztazc7s1gr44pk
71f77654-9b96-4853-94ee-3bfb777b7356	W5PHWOIWTNX7	Vega, Hall and Osborn	Karnataka	2026-08-10	2025-04-26	Active	a6zgcjnywxgxr2cgp4gjuj06hr72mqddlnm6mat1rxstajko9zb0g
518f192e-68d9-4193-863c-f0e1ac0184cc	8GXK3PJRE135	Campbell Group	Madhya Pradesh	2025-10-26	2025-10-04	Cancelled	9rb26avgo4mu37hw32bzmwcpi153acmsb03aou8o9m32n2hcmsjlnfmcdj024cm7tmr2wlfwkay1zvjxvywts0j1diauqer2mjcewzqd46p1n3z2ghsp1rsjsnm9kv0i8g7rqdd9n6ntazdy1pz0mcidncya28tuj9452z4cakl2fgv3lsze
f6207ae3-fd73-4ec0-820f-47fb65434ab8	RSGMY9D3VFSH	Gonzales, Levy and Bridges	Meghalaya	2021-11-09	2025-01-24	Suspended	vbfefe3ids1rqqqe8tavu2rkxz38e1xyghs8uc1ixqbrbz36qmtr3z3clc5fcm51d2pbtd3zkk5hjblf
965160a0-d0c6-482e-b582-261b87283197	6A9NX2UXOTOT	Bishop Group	Mizoram	2023-11-18	2021-12-17	Cancelled	h2osiptj6uv54bkcsl7awfsrs7ablzuzu47euq9pz3i8ej2k97ewtuaz78mpcpfvrvm65yv61zzphy8zwc9v4pzox99ur7
386e965b-ff23-4672-9948-4a1e808d5449	8EBI6FK0MSD1	Petersen PLC	Punjab	2024-08-20	2024-12-11	Cancelled	rnnmrfn6db0p1387ds8ab26u5n81whfhhnhpf9s36wylro8enwiqq24xuce6t
be4ea5a8-b56f-4b92-a0dd-091a4c4d60bb	Z0M6H4GREBZ3	Allen and Sons	Rajasthan	2025-03-03	2025-03-08	Active	hcg59j4lqqqnhiukeerrxc8dg
de87435a-93f8-4ff5-9856-52cbb9c1c4cf	RH9UU0RVU7GU	Mccoy, Watts and Chavez	Assam	2023-01-01	2024-07-27	Suspended	lbwwsxb50q5tmbhklkwo6jf464iq42p0dcxum7s65li48vtnw6mdknqq4f0ibzhrq9ao18ebqzxknbm84l5b2qq9okonhbdku9cott1nirhbti5x6eloflqrqm0vsw8varvj7r9b81gyjl9onxx7nl0mgf00fw2f5j97usn5pnlt
212ac805-070e-4369-90aa-5b73e514d2b6	G9AVWBK369JR	Rivera-Calderon	Karnataka	2021-10-21	2023-02-10	Cancelled	z59tzsz6kirid2cn51ode45pci6ojoiz488eh3b8qnfq2n6qiga3g8wr3ictn6bglt3kesvjmx34ko3zgpk2n8nc5tkyayuyz23bu2bamdyyfji4a5hfvhqbnf1sogtw6u2kxh6q1vlvlyz5txd8ww6e0drlum9etb7sugpkpjmacgfbvhxmpeviky3vqmu2et6
d769bb6c-16c9-4fe0-a68f-307dc406895d	MKMDZZLNKUHQ	Hayes-Mitchell	Rajasthan	2025-04-03	2023-12-02	Expired	h0ksoelu7qv9yd7lm0rppe2w0f7zpk76vx1js03pkn9ev96fd1jttiafbzoz0onfsumf62wqw5laxscs6vko76qe6pq4rrt13dfks91qybdrs4fq
256ec069-ca51-4010-b842-a91902a72ab7	N8RV1FW7HQCR	Spencer, Winters and Butler	Ladakh	2024-03-03	2024-06-17	Suspended	asxzt7db0su3tc2rvmnqpuaf348uam8ym7no5paykofiddgp6emlhhhluu5aeaexjj7dattdzsdj42e2cupr6h8aj0aaotl9q04abqtxe3mpye
f06d3d89-4a7d-492b-9310-e5530733ba8d	QQN0BNEADC3M	Perry, Berry and Cortez	Haryana	2024-08-17	2026-04-30	Cancelled	kuwxxpptnapkg8r2c99qeowi5lzm3xi10rgsi4bniiyg54kvx77ekniafq91y7sc6rg9dj8cao47e7orr0hkwgkzi3qz4e8if6
b873f6fe-e174-4a7d-b860-da3e80951d9f	YJ9XIRQIVHOL	Garner Group	Sikkim	2026-01-08	2022-10-01	Cancelled	cuoiabzcfdgxbouc7nonqvypfxjpshe6b1d1umheq7vtvxfopxxs9l687c95p76iyqzrspx9ppvv3ce6b
94ca6ad5-f377-46c6-a79b-b7f132ce7bd1	RYKFMKHO6TMN	Sullivan, Dominguez and Johnston	Odisha	2021-10-22	2024-01-06	Expired	2w75wyz0lu
ae794c0b-1a60-4764-a2af-ed592839d6ea	JW0CA7QT1UCP	Wright-Morris	Haryana	2024-12-12	2021-09-15	Cancelled	bbua6oi832wm2gcb
be5d562c-876b-45a0-8943-978fb847f10d	LM0SGASZ8DA2	Campos-Rodriguez	Karnataka	2023-05-01	2025-09-18	Cancelled	6oreg16qx907i1yqm3rn9pkv1c2mbcsujfczfh41180yyx1evpi6702z6htcz7trgipa9stwy3xdz3wn534i3ye1x1b123e8zawisjvhf1oitk8skuqqfjrjnfyq1vzj2
deddf377-f3f0-4b15-adc5-16c522feb9f3	SO4QEJT6J313	Hall-Garcia	Lakshadweep	2024-02-10	2022-12-15	Active	xqjg1voshewvjqqwgcxih5e4symvko26b8eyil5wmdg8q9utc1mfzjq1safv8hn1kckaurlxg6azim6xkafsk8k9btnbw15hrjkl6ynr9sfowef2aty1iet52kk6qbtxari1xmomfyqn7xbd8fbjoh34gsf0y3s3lmg3cd1ym
3111b09b-875b-4a3c-905a-814dbb47ef30	J70Z3IQ13OWV	Johnson-Norton	Gujarat	2024-07-15	2022-04-25	Cancelled	0tovm3avkidjtt9agok256mpvtxxk2pwwlqzxmis6d9ydomumvpa5fdzoi4rzup8797h1kdi74
465a6886-217b-4909-90d4-2bc12dbb5b9a	EC6MPNKB8QE1	Miller Group	Chandigarh	2025-09-15	2023-01-05	Cancelled	ozcs5k1ec93c23c1wgsgche12z15v3j5nndev31rz1d33ob6wtk0nvis2kk1ogdusjl67r03rmjhpbodjfdh2lt2az4sb29ucdacaxv0tzvhat6zuy1jrucd7lrketl5czpa5atemskvgxmcktbm44ejp3e9akpbz4pspyiv2ytx3tt8r0cvml5n0ix2rkcqzaepg
629ad638-a635-4530-8502-bcb0586450e6	RWJ78DABSLUB	Smith and Sons	Nagaland	2026-02-24	2022-06-05	Cancelled	ler7eq2ywmijyspils77vbbaxl4ip4r537y5uph320931itfpdbrtlj1izj9mwqe3qqa5hw6ghgpbpzbbrthtbciadfa06eiobtv3fuz2nasx22ddjcabvvq4sbb9yakjjysrkgv7w7v42jl7iqzzuc8y50t46xrmqr7c5s3lov88f5bi1vt
700e194d-bf86-4d2d-b759-4c3730ad21de	0U2SA1QPC2LV	Cunningham, Daniels and Johnson	Telangana	2024-11-02	2025-04-28	Expired	21xztf11h0y4bezul1
7efca989-aee0-43fa-8cd3-747721b01f77	Y8UE86URXNQ8	Johnson, Howard and Sanchez	Delhi	2023-06-12	2025-02-24	Active	16x9oxrgb2cwl91hajihbw2t2rnj4nhuwe8rj1f1yw1sted90s4tuezw415lydpt0a0nzj63xc146vpq2s434bi4y9ngame1wgxjpkv02wl0cokxdgty15ymj49zei7ggaa
89fad0ad-09f1-4798-8477-1b98aae48dc0	RVOZNLKCOVDZ	Brooks-Ruiz	Manipur	2026-06-03	2021-11-25	Cancelled	95iidiocezpd8g4ye02npbfdyuhb9q7
53c79f50-5379-478f-a143-a7031b19788f	PAAP31GE4QK4	Mcdonald-Bautista	Manipur	2025-03-04	2022-02-25	Active	yxark8nfh7h2gcviinjkhb4lkbq0j1xfd6gc0q25nnsr4y3u1yas7bja5o6dcxdgosyxvvxtjosgolrgnmcmj3i1ff6ugetoi0tsixh3qbir61b0s52ht0d4txp5c2vhfvk0g0x73wpz7zf4us0yiu6bw2s8sm7zalpcziep98sezjv5blax
b865df98-b82d-49e9-adb8-4fa9152e9dca	UPI4WZ0FDIAD	Hunter, Bird and Jordan	Haryana	2025-08-17	2024-11-16	Active	euph5pdc46mx0qsqeysph82670mty38adcn3htbjparh09zps3hpuy5184akfpbh6zi3k7x0akf7hxd4hwkw3ublf0muz0r1efjz5o0spzv060s6x9kn24i359ln33p4bx60x4g7tp
f37c2539-cfc1-424a-aedc-952c930514ef	XTVFEY3AKX2G	Gonzalez Inc	Nagaland	2022-01-11	2023-08-02	Active	miu2r86dc5otqobiqs0xvjmm72cz8xugyzof2fdprwd6ldv8v1tv1wtgnohd3t149gyfw018ztmwmg7u7515nir4aa
1a5e15c8-2769-4838-ac77-f2b5bebf5829	G4P1LXFOXCGA	Hall Inc	Tamil Nadu	2025-02-04	2021-09-19	Cancelled	p8v4wudt2qq9tk1nxc2shbpzxo8wygctyj7rxegle7tbqdw9jthhm21zi4tyu9moh0l9h7z1hxmw8axo15cw4llwq9a3epppdvvtyn2gofmtmtmimokrmu
c80b72d6-c07e-42ac-a2e6-b6c38d930325	8WCMHEW2NFID	White-Randolph	Assam	2022-11-27	2025-05-24	Expired	q5n51v1nur8xxheye91krrggsvzo0pjuvlxianvgma431v77h6x
405ba16a-a43d-4a01-b36a-994496e5aae1	DXQHYUG1503A	Suarez PLC	Himachal Pradesh	2025-03-02	2022-03-17	Active	9a03fjugfgx3c9jmowr6ccw619xqgm9sy0hc2koq8r4c67rgxvjzjvyn2b7kq2sxih371fvtumztwk78
f170ae4e-fc8d-4fa2-a840-c11276336485	YNOYZHP15ILI	Barber-Smith	Tripura	2024-11-15	2025-08-04	Suspended	v8thdh8dvtppm
57797c8f-85ea-4169-bccc-2cb40c2c96c9	NSRI7GYZ2RQF	Esparza-Simpson	Puducherry	2025-08-06	2025-02-02	Suspended	m2a7tvglopjd5uo1frdxgi4xpjhhfe5lkwq0zn
7af7b211-81c4-4cc4-9d58-02246eff4945	929R2H9FC68I	Powell-Lawson	Andhra Pradesh	2023-08-31	2023-08-11	Expired	nf7f8vpkeiuyr2kmz27oy0kt5rqj9k7yvpvb014dusmdngpy5h92uerl27r9y8c0t3hxlcx8yb11jt4gwyxj
7df78958-3eac-431b-aa44-e1e3f9df7ac3	HIQDNPRD02UN	Hansen and Sons	Kerala	2024-12-21	2022-03-28	Cancelled	tt9vjxdfetydw6xk2ekqua5ggpit1vmm4v84cdpxsheu157
12877da2-f98b-4104-a7e4-043b2ba17c2b	JF023NWXEPU0	Bell Inc	Uttarakhand	2021-10-06	2022-10-25	Cancelled	v1fce7jngigsbo4fxsg6gwhlcq8ky6ohgl723qta54ajlad5e7uybai70hl9n8xwfvb6ftty46mjo4ia2u4fl7yhq2mqcqmspcb1favw6hleciosyjlp4057833pk27lj9swcw91cp6hx2nrf43vb9z8m7pmkh6lumeacsaq54kxdfh0swbskb
5700f7ae-b819-4d4a-80a8-e160d20b4504	AVM1B6GDJWE4	Wells LLC	Karnataka	2022-02-27	2025-07-27	Active	el5q6xfnarnky6mefe8hip5g4466ir2ljqy9061dt26ia4ahrqxuf85w0e352nhb35b6ignys2irn7pjim3ky120sx408zsm5addxcp5nar1kzu7md7m84jzsake
d9efeccf-681b-44a0-87f6-c83dce8520df	DVH03325EE3Y	Skinner Ltd	Chhattisgarh	2022-05-31	2026-04-24	Expired	26d82dulybjqqdzinfb8cxkewtuynicl441rjddf500vmsbj7hv2qepawbm15zxkixff5
2f8b2fa0-a64c-4c10-947a-8b7843a0bbb8	VQC80BVSX82H	Stevenson-Lewis	Nagaland	2024-07-26	2023-04-16	Cancelled	2ciz61svm904zo1gpphg7z9m6lqpcirna9qqrcemuda2k1fjb4o4n4xgc2rpm0sbfmx8h8sojd73wmsh8fvs4z6sqvhmrnauak3
37699b23-1ed1-4447-aefb-3ba709248f58	PH6E27U9C04K	Martinez-Adams	Andhra Pradesh	2025-02-28	2022-08-11	Cancelled	tjetjh6wk3qs70uv4bsia0e6ljgoruiy9lkzzuc08g0cdq8lxpx095u24c29nl94zo16stryn0c7xsgpl2pk8i226s
fde1bdd4-e017-49a6-9c2e-f99706ff1224	9BRAL9SWMB1M	Butler PLC	Lakshadweep	2026-01-06	2025-09-08	Active	pea16k4wnzsr0tbamqby93vx59h1jfp13ytqf3yvoelndasuq3qigxq795i6ewtp2utz6xpnep7rgkuna7cl7s7pkidn5lcu5e31ifotofjky2xr13xj542
197d76cc-cb18-4ace-a81a-67c549841efd	QNAURMBSUEYP	Savage, Dawson and Gonzalez	Telangana	2026-02-20	2025-02-21	Active	gmzod15r1uq89o7zd1a4gptztwk9q7950inzi23ijhj4kv64jzy2fz6nbardwf6q02l
7a6255ed-8f5c-4e9d-994a-1e3efe36be28	TDZSN4FZPD92	Griffith, Harris and Weber	Uttar Pradesh	2023-10-18	2024-07-25	Cancelled	dpbsfjw05juagmra0gd6xtkw4tg7u671tsfn77uewrkenzmv5lb1ofweiqsr47byak57w967bx3bi3eq2rpgqhqsmzvynnjv9q6fl4idq6ld5efoys3t9o
c9a147ec-a056-4f6d-b0bf-67fc7cb0493e	WWMIF0B3YLSV	Harris, Robertson and Brown	Rajasthan	2025-05-16	2022-06-16	Suspended	qnywlkjfdntmdfughj1wa9axgyicumr9pzoflai2u0ryjqbfams10pekowhn9yfsn7ymenrpsnva4t42091hpjvumf3n1otfgvxvtm79rapim8o4ik6twdd0cwdbloswq7uopifxfza
47f02648-b60f-4b12-8b0a-305940e41c26	XA6TUFHUVAIX	Hines, Haas and Vargas	Haryana	2025-04-13	2023-03-07	Active	r4q86wytesagn21bdv0t2c00j5ufpr6l21kpr6jzquah3xawejndtn7rndrf9ig38ww7f7s0r74iusoamspyzjplinu2qoak8fnxs1a67n28adcx0lg0vk4jvy8844ysthdmuojs1us03pry4
27c44543-9389-41a9-9084-026d87b56f65	J7ABVDBRMJPR	Taylor, Fuentes and Ortega	Sikkim	2023-10-18	2023-04-21	Cancelled	ngiyivwftqgecwmw3w0vwcs6yjwop2f3o68l58kugoiic5a9i8w0a6p58z68shfv5cr3d3xjgbuugeb6lauhi3ue603wyjfwvw3gwdwf0pdkj468ozibnuxbc4cqwn5
38c0ec89-0221-4a36-acf9-bd89a22f0785	V4RKJCNGHSW0	Baker and Sons	Gujarat	2025-03-18	2023-07-26	Cancelled	2awcaf042plyi4a137fo6g6885wq0n9uyvs1pl0qzqxal4l6f68i
a0242e40-6bea-452b-aa99-1047e7a1b534	1SKCMZ9YETGB	Tucker-Kent	Goa	2025-02-26	2022-05-19	Cancelled	vd8hc4efgyd2pzv7oy1kibmtvrus8umu8mo8tpia9t9110g1lfy34nfvp02puajgf9ydigysbf4mb0yk8oyolhgp4gqos4opih0tfl4mk7vnu6m1is0safef0o59bo9qods0jd2rlg1gzuh47lezy8
67c98644-4154-480a-bc6f-1820e3082181	YO6TVEKK9APA	Tapia, Evans and Dodson	Lakshadweep	2024-09-07	2024-05-25	Suspended	iqydk7mag18y6mc04nj3e1k32ky58ihv6tiu66ih3vmsre74itirzh4ps81vzjw3qhalp80hf31wyji73cwpg1yxn443fv1pp0y7a
898d94a6-dc1b-4daa-9d21-e8eb90e4294f	XI2ZQ702L9V2	Rodriguez, Hamilton and Dickerson	Uttar Pradesh	2022-09-03	2026-03-17	Cancelled	doxnwvfx
96df1256-d25c-447d-9773-17cb034fed77	7Q7FC1TCH3BW	Mejia PLC	Bihar	2025-01-12	2023-01-31	Expired	pwzqku8nx3rxwg1nrqqx5zbl0cfvug1egu57fz9saaq6nxwc80mjznsv6s3qmxga66s097bg3gxtiy3si8wu2q9s82pazqeizx5tovmb4jlm1a3stqpgqnoc11rfudsp3ck4kzrfzteprhbfxasbbr8t73iy65i
e0b4f497-05ac-4a30-9cc4-25fdb7d495ea	VIXFD4PYEMGE	Martin Group	Gujarat	2024-07-24	2025-11-29	Suspended	z5u8souvd
0fbcf253-5fc2-429b-8be9-23300fd6068b	ZUARJLI2WD6P	Jones-Vaughn	Ladakh	2024-07-17	2026-08-01	Active	kavoqi596snsp2s5l4
8bc75dd1-b942-4736-9e2c-5e1e95d1da29	Y4UZN1DW4IK9	Sanchez-West	Mizoram	2024-11-14	2023-06-25	Cancelled	vkuwez8q26ml9gvyi44k32o3prh345nyngc8iw1ww05ju48y6bzpsstsse12hr4a9cjnmgzla3f1i3e0ru3ao
c4c4d354-19ff-4ebd-af3b-16995847ee6e	PLEO8FHFJS4I	Jones and Sons	Uttar Pradesh	2026-04-20	2022-02-04	Active	kzenflqghwqy5dfoy666mstsycpbu8q09edvf05m1eog3a0hjiyiu55lhrooqv5cesa66fej562m99unin4d0gsytpaoomsg4twwbm8a2jidhk6hbsv1l56pzhf83kpc9t5b685
160dbbb0-be0f-46f9-9f27-a1eb03c17951	FA6ZRF04M7M7	Odom-Hughes	Telangana	2022-01-16	2022-05-09	Active	vjaizpvbw
7d255f2b-0079-43a1-a0e8-36c3b1b65205	NL78M3DFNCBX	Marquez-Adams	Uttar Pradesh	2025-05-03	2022-11-15	Suspended	pf94c8yauhm7llcqzr2yxxz96ltavduovrobq58hqy78kx2jjfye87b63w8702weuu59xjz8yq2cuy7jasaut2cw81dtbnc9q7eokbthgfrd7guew2rt2p604euncbo54ye59vq2p8vshw0si8n1q78jt81gzvsyuk56eqsyv5ouzl4sn06pavvb4ey7jxguua28v
6b21188a-41c4-4bf2-8f6b-eeb33a7e17f6	YOEXKKIIEULW	Brown Ltd	Assam	2023-10-19	2024-09-04	Active	e6pygk2e8g8dxv2vpssrg1jki1enz4k2h64a6zqgu0988kaxx1dldn6jrq2k6qzyxaz6moul9wj1dwq499qdbn5g26jwnagv3801
c4dbaf23-9504-457f-965f-a8bdc8fec5ef	YW9UHEKWU1XL	Ramos Group	Manipur	2021-09-27	2025-09-24	Suspended	7i7oouly5ixg6ovi8ceugsz5m62p53186s0by
bf814007-3735-4f8f-a82d-aa1e17a99487	Y8ENIKDHFTFF	Harrington-Gonzalez	Sikkim	2022-04-10	2023-11-02	Active	uvsz1f5ptyz2qan2617ws3s0li2wwx7waeino8vgdxhvn4pd1n8pmf63pg2a7vfv4pw7434czbgq5u1re7p2slo67ooed0nxkmi545e
0aacdd4a-8252-4ee3-9d23-68f67aa4728e	2DPVF6XGMRK0	Peterson, Bradley and Taylor	Puducherry	2021-09-10	2024-07-18	Suspended	mqaxmm4axf0yzpucxmz411ewmwt5wcxohxrrhf6ikrqnc5yxt6mlaj4zstx3wtjwwimt345ec3qzgz2gwlz9z5fgtm1njrakyvh2l6g4yssc4shdzobcmh
a77026d0-e3c8-498a-a7d1-a9474b2b2429	V9VTRNFGH0WE	Coleman and Sons	Madhya Pradesh	2026-06-01	2024-10-21	Cancelled	mdqobf4lw5wm5
8777527c-a4e4-43f1-9879-a1354f8e7a6d	EWIN9A3MAW18	Bowers LLC	Gujarat	2024-08-24	2024-09-14	Suspended	812cj06ivf2t25dw6q34w1p73mq2c6fyu198beavcd637p18szkzxi3cdz0wvfxk3dei7x2gbgwh413wisotmfhkxxgd3abfim1bbz5egk0sk00cwccvyazywn5j4yja1lxpw4acjz2qgqxf2uackhvsfwikc6t6x5am9
f174cbd9-fa52-4517-9883-8c5837fac282	4MP9YU0GL9K5	Stevens, Bowman and Lane	Dadra and Nagar Haveli and Daman and Diu	2022-02-22	2022-02-17	Expired	ih2klj5b3tu9rnbzqsx4a3rws4h3gqt9hmms2qs7q
6ae53149-3a0a-48e8-8c0f-d924eac8e819	97VBYKJ8ZJAZ	Daniel, Marsh and Torres	Odisha	2025-12-22	2024-12-28	Expired	ct2s7uk9kq25n
8e266a81-2607-4d87-937f-36289a635fd5	NIE5MDQSJTHS	Levine, Cross and Miller	Himachal Pradesh	2021-12-28	2026-02-01	Active	j17rdpd61zhys5tdcu0u7iz946wb8bedt780guk6kwzj1evm116me745uanckx1eeiyof2lpxp7hdypn9kf67mfofxefrakq7ei3kk5
3520f1a6-0e02-448f-b882-b8dce41f50eb	I3S152Z955OR	Sanders, Taylor and Palmer	Goa	2025-10-30	2021-09-01	Expired	nfvs9dwpcvhiynqie6o4kn8941rpu7u3nc0jx9mjift9h5hl66s627m
82b2a745-97e2-4a85-8339-16f612ec1690	YMO7EWJS1JA3	Potts-Frank	Chhattisgarh	2024-03-12	2023-11-22	Cancelled	5o46arr05qbenibqr9xd63cyz0v8akqzwncj3ja9i88levmnc1z5hly26iycmirc83px1skpbul4ylpk0skaejhcxblhoaofrtzo66bjzoy2dtllb0qa7859p14oukrojf8cepyly5l6mojcpnmd3srgg71f4lsairxvaiholw8n5ncb2px9
6ee38d6c-949d-4055-9388-702f7bac2042	J8QAITS4E3KW	Robertson, Norris and Johnston	Sikkim	2024-11-04	2024-04-02	Expired	a7srejnf33jd036qm70ic46
63d5ac39-4e8a-4de0-89ff-8295b4597209	HJJCYCBIAY3L	Casey, Carson and Bush	Manipur	2024-04-20	2021-12-05	Suspended	bhddt2mcs2t1eakiiu716n44r6eqr2hqvwtwtv2p0b851iv6s62xtahtgp8qhfpaq9d7r2p9cpcm5stuemhf9b3d4gjmqti6u0b2od8wj8olc0n3borukjvbq30w8aj42m6ccw2o06ns57mv5gxnfa6gm8hffu7e8lgqag0
6de9b012-778f-427f-a29d-ac8a92fd93e7	JXZR9RPL5X67	Johnson-Gonzalez	Jammu and Kashmir	2025-12-29	2022-06-30	Expired	nzuqa3ixnjo9xa7gwmmfnuiiysaikydw3iq8ynw8f7zyzptelvcfrp928ld4xroeylyh22f54limnymmgqv1qm8u56a67tx9j3pk71z4m0db4svopfvdx
5ccff785-2a73-4741-a103-075dbd0ae50f	UNHTTDSFFQ27	Clark, Johnson and Hess	Maharashtra	2024-03-15	2023-01-10	Expired	h6v991bkd8tvsgfa0wxm43imvymci8lyfrm70rqxc55zzisehm2a07
43fdc92b-b60a-4c65-b920-49bddf5dbbe6	TXBZPSDFK0PC	Bush-Lee	Dadra and Nagar Haveli and Daman and Diu	2025-12-08	2025-07-17	Expired	um19scfzrogkuxsbnmkwn2i31rg08nvq3ox0aenag3chbdo38vf36ib27oohd963axdyxnnnwwb5mykygpufdk92vtr5bncboo379kse6506xmf0wd4dlv02h2en1svd
862ed8f1-9231-49ec-bc3a-adea62ddff06	JZTVH6QUGZ1S	Ramirez-Boyer	Himachal Pradesh	2022-11-15	2023-02-22	Active	9gupsx1uvvbzf1fvj0jug6ivwvp70s6na4qm7koim3qk3cvybfvl0esb8boi0gra8lsnbdlxyne83lgt97dok62
d086e086-fc69-4012-bef4-3cc204583a9f	5SO3VOM2ZLMW	Jensen-Clark	Uttar Pradesh	2026-01-05	2022-02-01	Expired	1bx2y6ri76pquqqit58md1v1ygblconlk22hpinms83icupndya42pptwx27gwl9p45bt7gnmdlh1ienlguzf5d1uguavbgx6f6j0gtbu7xytj9d3vmhghjywy4wbahyq7gj48ry243rpfqe3qjo19282lyb99h8qo25g1sitx7usmuxglgm4l
c7eccebb-cc10-4152-af16-1455c63fee94	8PI6ALDTQ015	Smith, Anderson and Moon	Uttar Pradesh	2024-11-26	2022-11-01	Suspended	o1jypkvdtnxcm9c0agkvrr52b1ycfsaeokh9q
95ae6867-0e52-4f63-864f-c65097a3b27e	KR5GRU9H518S	Obrien-Floyd	Chandigarh	2024-07-20	2025-02-15	Suspended	2fjhvkogw7rfgfy6vo89zd4zuqa8tyr8bg03f40fvwcuy6txmsczxp3mm3
c6e0ec45-a9ca-447f-a8e7-b1612c4d696c	GON3KYP0OHXY	Lewis-Nelson	Delhi	2022-08-31	2024-10-28	Cancelled	fi9tu1kgsmpgur06jr5b14n652g0vmla7m4kdw1dr0yywm8fy3o17y9juovn0cel60xd
26f9a35c-6fb6-41b1-88df-ec725af98d5c	RU6SLWBKM036	Peterson, Williams and Walters	Sikkim	2024-10-31	2023-07-16	Suspended	1z20w365o3vo0acneelu0duyh18h9n6aei0cu4a1t5sohs4m4bcmpjr08fw4poleoe4g2sz0ag3to0d90ce8i0jwyp92ne4kxtgf1pp8emhkpmfwfcfc038ztm8v26861vtmt6uwatvl7us09egnw9oszaqvxzpix9rz3lb5q
8d61645d-6e07-4213-bf38-2e1e3fe22f9f	SW2RC0QMYQVB	Acosta Group	Lakshadweep	2023-06-02	2023-03-26	Active	6ulg1vwnxz0ye7r2s2jg
b76c092a-b15d-4513-9ad7-008428cb2de4	Y47UIVZYCQXA	Anderson and Sons	Jharkhand	2025-08-14	2023-10-19	Expired	iq5c4lxlav5021bbl9er8eve
58f65d55-4b54-437a-8d1f-bc4993a2c43f	PK6X987Z3XBB	Tran Group	Punjab	2023-10-01	2022-12-07	Suspended	7oghnw2flphnkys1q5fuvu1wlnbocfpczuc43ntyk0kc59p4c3y7tzc7hjfo1iouy66ck1prt4bsn32kuzr48xemhyg5hrod3s1sbx4n5tkm11w40q6hrvpfxi0v7m1r6uucli0u7azkldndns8lzxh181nj1ibymlksg3e06v62t46n0
9283a9f2-f165-4e17-8e35-6e3b6f851521	AY3Q1Z4XBDB4	Downs Inc	Jammu and Kashmir	2021-10-10	2024-01-04	Active	mmbluk453saa0lknaokrwyfippjj4qejktaknll88fmroqz000w9jqtka0s9z9hbwc411js9hxgcylm58p3citkpdg4sit77avxl28uunbqoilh3ekb1uz65u91n0wjx
43122eae-e05e-4256-8f24-cc22f54d864b	8LANDKCP4V5M	Jones-Martin	Rajasthan	2024-11-10	2026-03-08	Suspended	4p40mipbhsw6uop8699u686xvk156h2nc6zxmxa4
3742710c-e8ac-49a4-9122-f67cad28e7e2	WXRWFHGA6L1F	Scott, Clark and Trujillo	Arunachal Pradesh	2022-03-03	2024-03-18	Cancelled	6tleg8a2rv9sbn3bi1v0d2grwom5s2mrf5hbtac7ebfozbmqwpsn77wta
30dbbf52-653d-4eac-ab4a-045ee9ba6d02	ZA86K8D24Z0P	Taylor, Rios and Page	Gujarat	2024-11-20	2023-07-31	Active	zxrydvgscpsulc533t7j9qsnmyzig8zsp0ruv1c6z909hz3vb19hewxcsguoad3c11tjkj5qzpad4w99qe8b06q1vhyo8xsmmfcy8346pcf6imgfn4blz0ht01fhc8lrp1ilkq0kzv3
3aed8ccb-95e2-44d1-8b9b-6e1ec43e6de9	UUEPOY7RI5WD	Watkins Ltd	Gujarat	2026-02-06	2026-07-09	Active	hl2pzf11hcfjjryl2jqvz1ucu8gor8kfrkmja2f8c1d9q3ssjui3qykjfqgix3e
c4768780-dd99-427f-bd6f-90a30a029298	ZXO857AGJPIP	Owen-Conner	Andaman and Nicobar Islands	2025-07-29	2024-04-23	Expired	1mmpdm9fyx79zggzi8j1a0xfdo4hq3njtf79xzgfnbcpib5qrugdgpuu0za4p8ov10oukv6jzv1dfli4p3xnsbeqixoh9e8jc92myk1tnf38y3rrocq0nhtjqe0c5mllxniqd5cmy
0f545733-bc1b-4160-a1d0-77f353a25435	CFGBG6UAHXKT	Ward, Robinson and Hodges	Lakshadweep	2025-12-11	2022-07-01	Expired	ma6vvqsec4li6ggzxyl2isvqrgkz4zmt3gjpbe4doer0nvoervfyhlwt2j3eld49fotboq8rf0077wkqzpw49xuh6cacisc5gsytyc0tsw42f33aixiz7fnx8197n2jc52jqljparnekremtstq7ipwzje36
ead43040-7cef-46fd-b6d5-dca9be4ced37	FM8MTZTYK1S2	Oconnor-Smith	Tamil Nadu	2025-11-24	2023-10-03	Suspended	vseroiygb8gbjyk8ml8qgey4jgn0f5co70e088k6ndo1ibrd42dc10i4d7orwbd8naoi3b9bszdnhlnaawtxe0
c53f5d6a-6817-4ca2-bb4e-44548e61a9fa	9SS80MGUT262	Fields Ltd	Uttarakhand	2024-05-06	2021-12-05	Active	7zvjonuy2pp668n7ftm7gqwh22paz1xjuxvynb4g2kuhldnrdrrainisqn3uxgzrna4hbb4hjeohruhugto96zgc7qzj60w6c5jpdld874obaa18lyuh0munblxg9wpkoonaadcbjipe95nu4tyhzkk1s78
b02348f2-bc74-4859-85e5-fca57cff2c91	092AMV20QQ6A	Kirby, Ryan and Dillon	Dadra and Nagar Haveli and Daman and Diu	2026-02-09	2023-08-03	Active	4w5ea1k5bbwgxpa7kv1e07n48mszfnb9a7lrkkuqw6l0lk5dhhqgixrr7b1gdt2too72wewr6dqg0d
f52f0a70-4ab9-4a75-9634-8fdcb7c535d2	EEDX8DWIDJXD	Kelly PLC	Haryana	2022-05-12	2024-10-16	Cancelled	6jyklpf142b64w235e1734t2n8xttsje3i7y7qytd2ii3dca4ksbhx57rtz6ceivh265k0iukofuqna5e2oprhzoqhqxqt2aotaplupixvy7mz3z1mwiord7qlfe6ztwzdjyhpk7bapdy4bry12w99t1oks7zbm7r6g
0518a1df-835f-4af4-a951-eeff0d549abe	JH2SIPOH9BVR	Thompson LLC	Telangana	2024-08-29	2026-07-26	Suspended	oclqjywatt1fqzoarunylaev5k6cqyx8s9l3h9r17y0fzrp907kir
e32fb557-25c9-4835-ba61-b342482f0962	JXESF0MT5X2U	Norton, Miller and Garrison	Mizoram	2023-06-24	2023-12-24	Active	eyx7kwg9ta9943v5aulw5a2g88kp0jiiy4q907yp0exb7e0gbjk20ifhrjjxubll9s4fiq0lkur03a4qshbe4300wm2unj62pik2zov2i0gkabn
d46672ca-70a3-424c-b709-93ebfe15c5d8	FIJDS5KFXYFC	Goodwin, Anderson and Smith	Chhattisgarh	2025-03-06	2022-11-08	Cancelled	pfhxivhil1z74y51isiq5t24s5e7g22chimnxirq1323oe7wh7msvsbaj4e1ev81x9hhbl3381q8ppcnpm05w7usoxxw574kfivqyvfdg4gg636deforravdvr1jzzgn4ccx57y
d491a212-2ddc-4d4c-96cf-78d636f75934	N0CD8YKAK8U2	Spencer-Butler	Manipur	2025-12-16	2022-06-17	Active	sb8qsvflxsj3ntu9frma7srs4qdvuk39i563qcnykel1pfsubsqec8utpz8r8x4mxjifc07btpg472xc0ts7z2569zolm6chrsmtjdtbceu40x3plxgcy19xo9x4noed6pf7qzqdiftybis4utsm5bx818m082n7qarebcw28fjs0ulb2h8gltwbh
51dcc5db-edfa-4422-8eaf-a09e48034582	WRODF4S8R0NV	Carter, Perry and Hill	Uttar Pradesh	2023-12-31	2026-03-01	Suspended	r17ebkry7x4kr8wepzlwuck7bq7su4dv041vq78657erbr0di54czq4dgtumir7pkppxazq6hv10zcmpr3b8wads5pcutxiodw9iqy3mdykb
21758e8a-4dad-45e1-b28c-1d42156d442f	T8YAYSDDKFB6	Cobb, Smith and Vargas	Chandigarh	2022-01-26	2026-06-11	Suspended	jdw43buah95y7nwitzm1renz
2ff6e1f0-e6ee-4a83-aa27-e3990343e4ad	3ME062SX0RS5	Rosales, Guerrero and Taylor	Dadra and Nagar Haveli and Daman and Diu	2022-08-20	2024-04-29	Suspended	9xdr20qsb78gufxbdtrxhcuokpjovocgnvk3mmj89b00vljcw00nmzzpp7ob4ziqimwoe0ks5y6ssqk6p60
a1a2b569-75ed-4f4c-a117-e725a647cc0f	NT9PDX0T659L	Thomas Group	Rajasthan	2023-04-14	2023-12-30	Suspended	ei2mcq3gchax9up83cud3l0j5yc86qdy03v1c9vcyfc6utzch8s4n39hu862rvjrky5rmta8ycdufeegfwfyc59e0sx869wwoyu0jndwjlhzdcxzqur3e94alae9fskevacmnepfujmfs4legnru51vkllw4zs79vf5byp5xox2k86bvpr20d
b192c27f-f5d2-43ca-9214-4681ce90f8db	QHDK7AB01ULO	Owens, Christian and Warren	Arunachal Pradesh	2025-05-26	2026-07-19	Suspended	w75lvt3saxz1rzxjwcnpx96vmulxx8ay8sia13hksl6ejp0atfvkzseel
124c9963-e34d-4237-87a2-29ba261a1881	9LE76H5JRYW7	Rodriguez Inc	Rajasthan	2021-12-22	2026-01-22	Cancelled	62mvmbb1p07fo4ouunsxb2zg0i9gtj1zmjiebneoxpvndbdh39psuomgpoy5vmuveea65snn5f6e3h360itf1mbh5pgppgl6
0efa4675-8c07-40df-a683-d8991a2457c0	4HSRAXLWG5VF	Figueroa Ltd	Gujarat	2024-04-02	2025-07-02	Suspended	hkmwfhjyskdcbv39rkwzg2i932h2o70l2oomzhpj5p7yint8ve4wuonxcc59uxyyu3pc5jo0iqnh565t6nuv5yo9lec4yhnmn3llcwqo3666s6otkelz1cph8msgvlsym259kdhlvia8pq2
ba7a7e10-cbfd-4642-abd0-1d580f5090b5	IVUJYCZ9RGMX	Martinez, Garcia and Turner	Chandigarh	2024-03-17	2023-04-30	Active	45j76lpq7qxr64acm2yp2mp7qp78cjqls962474tx3fhu69024p2ga6oprh2qwsa24ye3gyv
2922489b-1f26-46ae-b338-ad636b8d877b	R1M0MP8WGJRZ	Williams-Reed	Meghalaya	2024-12-03	2022-02-13	Suspended	q01r4iqj8swkylrxx5pa9xrwjnpg9bx1rijntqmwdgqqnj3vwna61wa0x9kjf7x5xcs
8a83b18a-c028-4171-b628-c42e819c34c9	EUPJHYDIK466	Monroe-Taylor	Dadra and Nagar Haveli and Daman and Diu	2025-01-11	2025-06-26	Suspended	98e693yx75rv4m5z4ml45ecajb5nytxzjcxqc2szhjgqulelk
7e6a4dbe-12e4-4acb-a55e-a5ff9565c0b0	16QVJSC3TWKQ	Smith Ltd	Uttarakhand	2022-09-25	2024-01-20	Expired	xh8u7ume3lgxuwlpdd1a0189xcai0bwyjjwic5ldakqd5fpahf6cmev4lzc37n8d8j9q9f4vopc8kbqpkxf85jw8en71q22uwo247
65b7d29b-ab79-472d-a915-4ff61e84c238	WNEP7YZZ59HL	Schultz, Keith and Hunt	Kerala	2021-10-26	2026-08-13	Cancelled	wdtq8ddbl1wvxyiubhiyl89ndhutv2692rrg163b580xn1nr7lsy4dgmyd57177ek31es9obe198q
2a3f1f5b-3443-421c-929a-50e00d25ce5e	8TEROTUL2SJC	Hancock-Davis	Uttarakhand	2025-05-06	2025-07-18	Suspended	p0oe7giqabcl0dsg1tg8ilpuvxb50sda2eyofj2at0gofp7vrnqydhg03codhzemtz0ba1elw43koz8rchwdrx95l6le5uutx79lohbw2gyb2yt36zraaxfz8j24fuj1gs26u2xcoy
bfbea112-ccca-40f0-9459-142ec3ef2fab	Y990MA33YUEG	Campbell Group	Himachal Pradesh	2021-10-23	2023-08-06	Cancelled	7u7k5s4kf6up2x31qvxxt4jfv278wsmylnb9f6dupse6ouawxebf0t77x6aiprmsdzcth0hfvl0pdgfz0z012e2e5nuyrjg
01c54ecf-53b4-4ac9-a0c8-ee46471094f3	LMHXP5UXIBNV	Cummings-Fitzgerald	Jammu and Kashmir	2024-04-15	2024-06-26	Expired	okf8fq07m01c2d18ldbbkaqnpal7xj4wxwuwxr9t8e53j3dq7129oatz5s30vs4sbuj1h03iegp0r6khr04ulsmepe09p35yszp2keezr6j3lxfq70ek1t3u0pypdmokkvykv9m8ucqkur9l2nawpmvc4sas4uuql6s1xbymtesq9t96132s59yrzoq5y6a3n713egw
9140960d-046c-441c-a7da-33dd77182195	55SIGIV57GHM	Navarro-Kelley	Mizoram	2024-08-17	2026-03-11	Cancelled	2lj2m5b2f1c0xmabhgceym6bhzys4f2hltkhux823zfdp1vmspqlwg5j601qet3wsvprtxud5oekexilremx7ah9880op5fxtfy93ef61j1ilmmqv3anwjhd3
6be46cfa-85e6-494b-93ac-9e6fa36c5ccd	69YN3ER3WSWN	Allison, Shaw and Smith	Uttarakhand	2023-06-18	2026-08-18	Active	dwod924gxz5w5kmfsy3t5gqkbdcktu27f150iyd0ald98nksqs907l4b5jcrrs6jxnl6agsomqgoewfu5ae
cdcc9596-c3c3-459b-b834-7f8d9274b262	5NUWD475FXES	Pittman Inc	Nagaland	2025-04-26	2023-06-01	Cancelled	nurem9q2rhkos2qiiya17168tq5txh1y0eeokn96cuapa1c9xhnowmsxpaak6p26iyamgmrv1sc3llzxu2tai2g02mbmtdmqcqvvnk9payi38i93b9f21qbe4jq3
1afb774a-a72f-4ee1-a834-8355e067e561	A1V8IMG5NA6M	Fischer-Hamilton	Uttarakhand	2026-06-25	2025-07-05	Expired	78mqpmacon4v0ttqvp3144ofay3g47kr8mk8occqk20kpfubgmvb8fd6ukj7jr8v91yfxvf2mdidcdamspghtfxizn1b1prwtm48ot9s9qd
33ed4507-2f4c-4c6a-a592-ff1a72436e31	MB4SPEZIGUY1	Jones, Lamb and Alexander	Mizoram	2024-01-16	2024-11-07	Cancelled	lqwwkcchjcwybcpfklbpitz1iq001kohjksghizwhqca2xzq0q9sq77ri21z102noh5uhavwhsgz1a0qoqz9zh2rrvh4d
973a82fb-479f-400c-af94-b17e07604793	2589CUVWYRXP	Gibson, Beasley and Foster	Uttar Pradesh	2025-12-14	2023-05-04	Active	3lswwsya9inydct7knw2d3oz
91bbc7dd-1139-4866-ad25-7c4b3b057bdc	H5F3R2ZRUW01	Marshall-Roberson	West Bengal	2023-01-27	2023-08-27	Suspended	wzcpgxof4iwdxqfp43b9c7g2wl9nc4py7r8xikkpd1exx4p425gittjaq3p1geet2ka9u66zsmgq8sk7rws8690eq35hjbttxg9037joq0vdinzx6gywjbkjzywgijfkr36m0ra49mvdo50pfk0we6wsixdmcj6k8hsz0ltkq6ekfuv0bqibea8g14vg38x98dv3
6ad639c4-5470-4690-b0ba-77c1e68e2050	KGCRBPT0VJND	Russo-Alexander	Assam	2026-02-17	2026-03-26	Active	smbadrwi2k82jk0a2j75l3e5ufsgqvo3qy6parjweb2m0hbrapt3wcq50ysdz6002v3d9e9vkj8qb5z46frxlh67ak32g16cv0kok9ye6fxh5octqwm9ikn85dbw7rcjd3fcwb9p6a
56e4b79a-04c4-45c1-895d-add3faae4bfc	J0UW04F8Y7Q3	King Group	Chandigarh	2023-03-13	2021-11-09	Suspended	8c4u6n61v
65ce001b-c7dc-4ff3-b496-bab85ba4d48d	G4GP44NHVBNB	Summers and Sons	Chandigarh	2025-09-13	2024-08-10	Suspended	5s8yzfquzuooh8grv9ghxsx93305kv0hpj98bj3svnwcapg5pki9cnr7henp1zvb2emymezpzqc00xhq9cgunu6cx
b0c84093-a4fa-486f-a3f6-6b4c62f50a9b	R3BBEI9UVN36	Morales, Griffin and Chang	Punjab	2023-02-03	2023-03-19	Active	5zypx49njy8wntw96kejsmerpne6ccvesd001qwbatvlgd55ynoz8gbkz9kbkkm3uljlgw7s3fp87o80yfkrc5oyvhkisnhds0808ouhwhyd3x1rtoq8inaotgeqngeo7kj1hnct8t89bhdcasg5vbtbgje6i3315v3gweioy7eub46ciy7jfgajj0x
9b7b2bb0-fdb1-49a1-bbc9-c5017a59df6d	LR4PG0RZOSC0	Moore Group	Odisha	2026-08-20	2023-09-28	Suspended	554qdst4ac1ar334ymhnx2z5q8qoezht9x6s8395hkankw8nybjyj54s8obvy2imodabp9lj34
2780802e-90ac-4c55-9064-1a1591a38529	NXYIX8SCPSFY	Higgins-Todd	Gujarat	2024-03-10	2025-07-26	Cancelled	1bv1z21ak97mjsb811qdgofejvfsy7npwmw67p8da8d04ao2j5kd8uv02pay2lpbbifb2i9msdjwr6o6cwbdg6jsbdt7hkpee3yeo06a47bke967gm7cqt8fwexgersbmj73fh0mlbng7ciero9j7wmsscbifvnqkd26owp
02d22a59-9c1b-4c93-a348-03fcdd9d2e5d	UYWG8S6EHJ5X	Ford, Carlson and Kennedy	Himachal Pradesh	2022-02-21	2025-11-22	Expired	nfh4dp1uc6ndm0pd2e649ky3w95ogthuo6b55hnsqzd7o7b8xgeji214tmdkxs9s30p2k85ee9gxi7w5ach51orub2180cpqyhl4ilv0yt02dz0ggol0jib5quinart421ff83a5m8354btn1xr6kc25uur1uuqsk0unixwjtunw9bon
ce252340-f826-4c20-8ab6-78a145644a51	5LV0HI6HNMED	Barker, Turner and Brown	Meghalaya	2024-10-10	2024-01-18	Expired	heaal1ob2sy2tbgohjrxlrx47e0itf7muzlr2nb7p4iz7yni6u6yxx9df8g5iu6r4wovgb63b1ky9uosexapp4qw7hb9omas8nvxx3y8p6hq7tepr7ih
933a097d-f7c4-4d09-b72a-ea216eeee73d	1Q6I8P03IJ2J	Day Ltd	Goa	2026-05-24	2023-03-11	Cancelled	l55gtf85xxxp4f6pme3i4gygcqqidnsz1j3xa689kovpyfi0iw0xzarje4jl12remnxiu
dbc5bfbe-a417-4a68-9dce-08fa79604782	T6FFC8KMWXRY	Garza-Bennett	Mizoram	2022-06-06	2021-08-29	Cancelled	eg4le02cw8bj6a6kemh7kw2hgfmofhvra547msdf95yhvq7ep5swzfef0dz9hjrumdao0arfmcw4l64giw3pyjqyrqnghnnwyvfagmfr0x2c3k99s4mx6u6nhjjonn7rbyem8eksisw7fs1e0
67156ede-cc7d-4d9a-ab77-9e1d93f41932	XU3CCTO5XEV2	Gutierrez-Bryan	Punjab	2025-03-21	2025-01-21	Suspended	9ezod0l32op84lhvfx2ugekg3ovh
aa78ae22-d82e-48ed-916a-5b5633e9debf	FDNHBQTV0ML6	Johnson, Sullivan and Lee	Odisha	2021-08-28	2025-01-09	Suspended	aic0y7bs17qauum28n1mk1w3ut5peqo2uin16i99fp5llwg2
fb9b362d-8538-4820-817e-eb4c563826f9	2NCND087TG8P	Jenkins Ltd	West Bengal	2021-10-20	2024-06-27	Active	1idzx6pq
fd5163c8-93fb-4747-873e-4873700bec74	S8XAVKRMZ1QZ	Barber-Ross	Jammu and Kashmir	2022-06-22	2023-08-19	Active	an5tqzrmjxp0ui7kamjolu6c6mzwbhka7tthli2q6hxivys8p2h6yitec1g3760k22biosib9ydlj400f4e6y7mrmkh9yzzia755xldzm5r4k7p9glw5brokczo1krevudnuw7eod6db7vt5myvej94d9dss
01403b3e-91ef-4e87-86ff-94be715a6e66	R56P5YFPBOFN	James, Berry and Davis	Nagaland	2025-11-05	2021-11-15	Expired	w4vwnjw8y1zylfxljp3gwf8dz8axxb73nsnjp7mm7i84nt7o2exeh55jfeqrfg4qtw2uz8
d9882653-ee2f-4b33-9572-23ffbef23995	0HQYJM16R0IV	Payne-Nelson	Jammu and Kashmir	2023-11-10	2025-05-07	Expired	rocu9i1qpd3h57c3vq7cn73d19h7pyrsxtbthtr0giyyh3q9au6l33ov0wz2um9uelteyt5fntslo0u3gjey5d1hfkkw1behdac36mwtwbt4vdqvx4hpx0th1litl1fd
942d1553-aca7-487e-975f-093692d5177f	KD73N5XX0CM5	Cherry, Walker and Mathis	Kerala	2022-07-18	2021-12-18	Active	x3tws45zd3qj1tkk5gura0dslbk6cp5gwwiozgt0yl5ai7f4enjrw22spc6vvnuavpqtdl442njih2p58d0eun5g8np0dr6g2mgo1k9kuimpi10usgir8lc2534dg93n8s5zm45u52dry6i8z6yt8tceosnlne4137kvba80
98c0c1e5-c982-47d9-a2d9-f7ad544f8bb9	3LNLPPPD5KKY	Hale-Henson	Tamil Nadu	2022-07-27	2024-06-16	Active	nt8fakgfncj52ytqzau092j74dmufv7f5pg7fh2yf5tdbzkiqycvlvtwoehrdbkxruz2ingphddxdpt00wbg6o7e5jjlwqayjmyvakmq0hoc6l6gtz0l87n6uyzuwhiywlq9ulx1n44jzmhowlbq4uuc9iij8bvssim4jju3daup88410ldvzqrjl42l7rkm
f5a1cbb2-d9c2-4d96-bc8c-e58ecce18f4b	R7O23UQ5QS9E	Lester, Brown and Cruz	Tripura	2023-01-29	2023-11-27	Suspended	accqwja0o7dpfdoznvx7cehvbt02bn144sfybjtgvx2ypcp
daa96aa2-bc25-4112-936d-f66d67b4ccff	MJJB8HMSAN3G	Perkins Inc	Chhattisgarh	2024-10-21	2024-01-17	Suspended	xakbqlk1140uryg2n3k72o5cj8fo4a06bxs6m7pa7vtgaf7dkelq4w9izayk38lqau784ibpjs0gqoluiotj1tulkbruhuornr
d91a2c77-e83c-4675-a6bd-8f0590366000	7KPR8VQOJ5XT	Dillon-Reed	Delhi	2025-11-09	2024-04-25	Active	dy9kywmqrh2n97dddmxlhkh48yvwrru7hcerjdsbmmx6jamhnfh74dtzce5sr1ceibuaqkxp34s9kl34hyd46k61ofabwh2eer2q9xultd01mj34d4hg3
07c99763-fbb4-4292-9fdb-6807f9c048df	5YA4L6IBM5HJ	Richardson, Smith and Pittman	Chandigarh	2024-04-20	2021-12-12	Expired	86tasvrfhifvinblfuq3kltt0n7i0rt41s18uqxgulf0tud8w1xc8yl6ru6xu3goi4qju7xmwlu48rcl96uslll
259b4b29-1e77-4d39-83c7-0fed5923ca39	7059AK1C04RE	Whitehead, Wells and Cole	Delhi	2023-05-12	2023-03-21	Expired	3gg3ubkzxa08idoa1izmv9js70t3ng6yvpmk05n0pcun0wpq7ts3eqww5dhhn4y9sr3slnxdom7lt4kh81qsghsr8wm9ox90gd1u5h7fzbxgd1lui84zluj313nqxjmliutsqberxxdhrbg5gv8rweqtgpe7dfj
7e01f1cd-bf88-46c6-8ed2-7dde9562cfdf	Q2TFIZIY0MJL	Taylor, Maldonado and Smith	Himachal Pradesh	2022-01-16	2025-12-14	Expired	c4kpdipmp944dzcv3uzx5xws1nwxdb3xqh3w2p6u4q0r3x501totc81ykkxjuc5bbgczvv9sj5nswwuq6d0fvzedu372di0iryacv1u6inmcxb6lg9umtsxttgkzpc3e4jlgcwn
46a6bb77-4069-444a-bb1b-b77e849cfd9a	WY76OUAT6Z29	Vargas-Gardner	Goa	2024-09-05	2023-10-13	Suspended	ptkiy7qspxaau4yc4gr7khad1mxquhtnaxmnysis09jigvmafureic2721l1a9xal1h9g84ylfj3czbf5tuxr17d0p9
35011d01-b9ba-44be-be8c-1fe06af452d8	8ZRG7DSZ5JD6	Warren-Taylor	Karnataka	2024-04-20	2022-09-01	Expired	vduzaumgjgkw8s029zyfgkw37xcc2mpqxqfl6yn5f11cpzzr0skm0cfa53ndeuktlb0ryzirqmnv1cwzg5k2773zfi9n8rp5kz616sfx6cr3ne5m219fqt4ce38wth88cyo8yxupi713obj
f46063c3-6fa2-45f1-bdb1-b5b21b8fd083	0U6HBN16135Q	Rangel Group	Bihar	2024-03-11	2021-10-18	Active	8em3ielzz0
1c69bed1-9616-4b9e-adb1-84f53fa503cc	POSXZ351C01R	Miller LLC	West Bengal	2024-11-12	2022-11-16	Suspended	k0mdzvjs64au31iq0cbuqqlkikdoxmnk2t5th570yltna9lpgqd3x8f8oq56amfohti4rybv8l491smfokw0pldw6u8by46ihzoc56zka3o9bo9829jb5havby3gb9zged9zitc2yacmf
033d01f4-4284-4edb-aeed-7aa2d2ce876e	6Y77KQYZ39A4	Goodman PLC	Sikkim	2024-10-06	2024-01-21	Expired	rx6x5g97cahe14gjmnjcheuc67c7moev2xqtik3tupqepktzjtws5xmu3eo4f7fkb83cqtikrrwssxjmst6wqv7dunt6cr9aj50xjzagaiibe9ij7vke1y8wdt39pqzlmmt8prxj59pnpqpw83tqgpfqzppxkltmd1drn42ncg5o4jzfjn5yiiubqozj0
9320e7e4-9e46-432a-b3cb-e8d056f73598	587GOYKN465P	Reed, Stewart and Mendoza	Bihar	2022-01-11	2024-01-14	Active	2c47hilmj2j2p4ficzv0guxj7kd39tl9rl12ra2sah3sxopx1kejzik0j89eocak6ba2xriej07g8mwyngvotokfsa3v9tl0xbqnjod5
b5440113-b974-4ec9-a5d3-2309d763689d	ZOH6B0HM0OYB	Bauer Inc	Jammu and Kashmir	2022-05-19	2024-09-12	Suspended	nt2l8on0t8gai1n15sr7iq9z2te3hq26r3sna6evobcad9ti4el1pk
958d8300-070f-4f9c-b85b-882ae868a611	7R0NQ519KVYB	Howard, Miller and Howard	Andhra Pradesh	2022-01-17	2021-12-16	Cancelled	ubc3miwz83b9kox6cyxsx7t6da02duf8r714jlybeucz8qay3ubov2
999c1a07-e3ae-4c07-af0c-f34df956e46d	MDX76CD78R06	Lloyd-Walter	Goa	2025-02-04	2022-04-30	Cancelled	nmg9kz80ixr9hwbhr0t6ke0qfi4ol3fyjerpjzbhaes2lliqqsvnd65
4bdb581f-9d6f-4c6f-b34e-2ddbcfcc0f3c	EGRK77UJBAQG	Cowan, Robinson and Ewing	Tamil Nadu	2026-05-31	2026-05-05	Suspended	94ohgfgq3oh51bjd5lgr3bivjp5dzqf24k3hy1knv097z1m2vx553o86nlrr9m0njaluopmkjhea6mfbqe7yz8g0y568
64fb2b3e-4fa9-4118-bafb-45b46422152c	LIICO7IR3G3Q	Rogers-Harvey	Rajasthan	2026-04-08	2022-12-15	Expired	xbwibbfnow5sol7uwg0y3s84iavjdqesfm6as56vkvlakiyj8cgh01q4qk8ipau7pcb7ynv2cy1yqk82glfymurqez6doc3au47p5c1ue6tu3c9pp2dwrw3gx5a5vw623qw5bbzcnorc7p2v0e8kpmgnmw267w1qt4cyocbt7wkkna629a4zjjotgcdmzma3yui8o5m
b98ed08d-6867-4a09-b21f-7c11d9be8a77	UZH2FH21UYYE	Aguilar, Williams and Anderson	Bihar	2024-01-17	2022-09-04	Expired	m524e29efmo3muvac1fdqto1bal2q8pzpj8ynlvakkxsmo1rplkqcmkkuf5758era7sesz193xsca4tbf9nm7yh7s3aem7szrt327dv8vfvdffty9cfyjhk5d4a1lct0g1phluhmctiqk
81200dbb-6561-42b7-8186-067deaf100a0	LF405N9PLPK3	Barnett, Blackwell and Jordan	Himachal Pradesh	2024-03-15	2025-03-26	Active	jbd8knvy795bssknoim
37ef9df3-a6ad-4f8d-97d6-8f15921965f3	N0FWWHORLG8U	Gonzales Inc	Dadra and Nagar Haveli and Daman and Diu	2026-07-04	2025-10-10	Expired	qq0kdaotngg9fm7qya5tmppoahxoh7nuznh930auh0bbvpd28r5dp6ie40g4ppx
b8332a06-a865-4208-9028-972b1ab3df84	62DLIPVXXRGJ	Richardson-Reed	Jammu and Kashmir	2022-04-05	2025-08-04	Expired	2r0ry8tvxybt5rx6p1gd9fhhei8rhuhe4y8osscwrj64h6vuhgpu6oanzgvkigc30kwn6j79emanj2
f126b3f2-430d-42a0-bafb-9ae5f60873f2	3LZEWNIHC092	Colon PLC	Puducherry	2022-09-15	2023-01-27	Cancelled	agfyqjt19dsd49ysauh6issr608lwjowxs43eliawh7h7
553f362b-217d-47b7-82db-d5aadcded773	G213UB2QSTUR	Strickland-Romero	Tripura	2023-12-16	2025-09-16	Expired	contu3qpoe6q0rg1s0mynyjx4rlboy7u9128ldc6wdzl91qgv5wneauc3u8dg5kzhhnm58xhebheia8cjj5m2kxvewxav42igo8yx85e0k
04498d14-613b-4295-87f7-598ac2522bc8	AU3UJ1EFRWG3	Clark-Allen	Punjab	2026-01-31	2023-11-10	Expired	3wbtu51t87f9br36q09r1jont4hk3vj9ulsvnylwfsxb618gkq
c049d7f7-d9e1-4cc8-bfef-803562167f78	CIAI7AUHDCNG	Ortiz-Murphy	Sikkim	2022-03-18	2024-09-09	Cancelled	g65pk0gai4z9v0z2qlq5by2q3q2u854w90c6c178zxu395cp0anuz7s219kb82p8nj4ia5iv26eq3geid2dnshabvuy0tjbdrmzm1rf29b6sekczkz7zc1yhik2awpfafmtqe
19403e1a-77eb-480f-be61-88cccc79b2d0	9XEBD5XCT2KF	Phillips, Martin and Crawford	Dadra and Nagar Haveli and Daman and Diu	2022-02-01	2025-08-25	Cancelled	trd2lvj5drchl0on2w30omgmzif2is86q74
70d012a9-464d-458e-b6eb-d102c64a326e	B1IH9485O31O	Wilkins Inc	Gujarat	2025-02-28	2026-08-12	Expired	f42p6zdkufappjbxswsbogmgpdmiy58xqaoz0hryeh5jodidkxewgoyu5ekkvf3e1giy7ps0u4m4mvge7l7ip2x0zy44e6rqhax6honrznuvvvz24uol2fizx12riy3367a2yv9p1li3s5c7sqokgjeb5h8argnfanajaku6logt8ye639547zn4hgp
27ad6b4d-63ff-411b-965f-1ce52a9e5db9	T4G8QHM7KV00	Rodriguez and Sons	Punjab	2023-07-31	2024-05-12	Suspended	k7xg0mrstryrss7yv9bcxz2nyraomqpwtbzgadg9qn2mdbty1h7knsg57ctd3m9neb2jtxc09psfew94810br2n4i6obhudmb22vqpnu5m01d6pym26wz2os1slr6k2prsv2umto3
5e6d1daf-6ff7-496e-bb4d-8ed0f14fb157	WMLYOAJDTWUH	Brown Group	Andhra Pradesh	2025-07-24	2023-10-13	Active	wlnm89lr
f61eab58-1bdc-4fd9-a941-33d3b33b9ba6	MPN2ERODN5LQ	Bailey-Fox	Nagaland	2026-04-25	2021-12-23	Active	k7delhah7t2es3babdnds3gkqcd1arp762j0x7iph8rztic0yfxfyin08zbkrywypfpksor5cel63tpp52bl8jk5ap642i4dkobml7bij2tu2ayytpumxw4quabjg1neo6r4cl8301fsqoclat1jtz9j2nvyrr3z0n6qe9u0ziwxzhc1jhqxdleccygc
f090169d-6221-417d-b9eb-895c258ae3e7	RUCEDPXD00C9	Edwards-Cochran	Lakshadweep	2024-05-18	2023-12-29	Suspended	cfvxlm517hdb3fn73fpbbaythfgs2j26i0xo94i8ww7qbhjwwtzczty3ozfy6g17ov8o4f2sv3efrcdqg58spbmlwcpvnu5sveuf4uw3wzsph5fvvo14dubftrje4r3kgnwalk67dd5lfpmccxq1ox9esb
6c308b14-fa60-4b3c-a902-7356da3cf18a	OY0FP3FOC715	Brown LLC	Telangana	2026-01-03	2026-04-29	Expired	b0q9ai3u0jyznc9pwq2y5eyk5ndsyb75z5o339u0kbr6j0j79lkf5ardwk609xiugf21np0dz91sceffzoeev8
e19b244d-c110-45de-ae58-68db13be64a2	06EJDPI91LJA	Henderson-Olsen	Uttar Pradesh	2024-11-28	2024-11-16	Active	h2ukfacu5d57uw8zq329bxff1m689r6swk4y6exm4e0o0f5eh4f3jaizzpdcbg4slubx43033otdlzuk0f3h4wykoblyaqve3a75et0o8my8sxnkvxwya5ushi761yjto6zfa0zlhxnshtjd1xhw7yjerus3hm89rik08z957jq7nv40c6l
d91ac34d-ecc5-44ad-91d6-eab9fae51e21	4RSD6BFANB85	Ramirez, Avila and Wood	West Bengal	2024-05-12	2024-12-04	Expired	zivecigot70qtbelq7e88yiebyzhqsg4iwuhryxcbwns6ry93niaqgt47410kla8cd51
cf1ffcac-3d09-4312-aeb4-823dcea68566	UD5ZO8S7V0IA	Smith PLC	Chhattisgarh	2024-07-29	2023-01-14	Expired	ygwghkt1mm9ls1i71bcyo7k4suxvnhenzsb53oxmbg5a0vgk6mx21aihtnijgq8aor53ph
f9d7c2c9-8a34-404c-b8b0-94f02f1ba5b4	4DAZ67NMDSAN	Smith-Lee	Sikkim	2026-04-30	2023-04-13	Suspended	grizlbqledx89o8rzrbettuk4fcuwuk5y07plfqfa9j02zrft7aor4
eb9877a0-4686-4d42-b041-53f64d46b450	29P68YE86P3J	Wilson, Perkins and Ross	Manipur	2023-02-09	2022-09-27	Suspended	unxa59wld7fftrx5t96g0ch2x8d8ye5xdlffxj17ymovegq1raazmkxu0f7l8cmk9u3lsd7q7maafyh33r38wkfwqyz9n338pknvoy8kqfw4qwlcip4yl75f8zxvbawfulgiykh7sxxwjqd1zsbtq6lv4faxt22oy7
4dcc67f8-1c18-4a8b-beb3-2a447c5bfab3	B3J6CAEBBV3Q	Jones, Bush and Allen	Manipur	2022-12-11	2025-05-23	Suspended	7p92myy67f4gqa0q5nonjzv1hfr6mqm2778m4t9p0mv1t36
9677f4a9-a8bb-4882-b74b-82ff6e405177	3V27RNKCUHCE	Mccall, Mcdaniel and Gonzales	Goa	2023-02-19	2023-03-09	Suspended	46wou1sruus7s3sz5tckennmfs57v2ob27tuezfr8pq5we30wmyhzonxef266hhyftorjw0w4os6o9vnqhezlv2homfujkagqsbo6v4kzk8gvtchhrhhsdrrc4zh68fk1c2c
1bb628c8-5467-4c69-a393-1e2eb59132b8	I8T7LOFTE4AR	Perez Inc	Sikkim	2022-03-11	2022-04-14	Cancelled	n0rz9nx6rd2lxuxhmkjjmty4rcq9tg
bae2cd70-df4f-410d-9ee4-e4c4ae373318	PKO0TPELU6XJ	Walter, Sandoval and Evans	Meghalaya	2022-10-26	2023-01-16	Suspended	0sgirdvvvc0tt34s0t5y74396vzn20ejrmdbpy3ds9v2kwhkbd2lc03c7xftfwdl3lofd75ucvmgqqw8ux4ikjslas0r32oz5j9xq1d5n2dns28a
22ff9df2-782b-4cca-8a1c-fd8a513ec95c	L1PUNZUFNKR1	Martinez-Anderson	Bihar	2025-10-24	2022-02-17	Active	z49bu6tkc4ug93co3lnq2e3oj6yaiddng10kmklfmkrdb5ib4e4qv1p85i723u9dc073jb8hfssh49ea4800tybzvvn8j4
d853af30-8ee7-4741-ab6b-7ef7e9624eef	IDN9D2KP7R8X	Arnold, Hart and Boyer	Haryana	2023-01-12	2022-08-20	Suspended	q30vfi5xjes5hz7kc3j6d1xcaphjy6ezcgli2djjykyzoyembkwef7uv7n8lfrtuu0pym9rs9228tkj
42ab9c06-9ec1-4c6c-aa14-8b709a73c8d2	2XVK6KXEW64Z	Gomez, Martin and Davis	Meghalaya	2022-08-10	2021-12-11	Suspended	6shjnof116q4kmei89d8jxxv7oqxf5z7cmlloa801thybo4s9b50ztsjiicrz7n3wzrebjmpqbpavdsvyo4lu885ynew3x8fai5usmdl7zk7flwke0qr
7c7e0ce0-71c3-4ac8-9ec8-8182643bafa3	88YU7QEF2RUC	Watkins LLC	Manipur	2025-08-22	2025-03-12	Suspended	hn17xgbno27zgbhqjzznkmtwzclxa6q11wf21zp555dfaug8xbar0zwse6vca5iudkr
287e0809-78cc-4b11-88c0-caadf3009196	MO7V0FG9TWTV	Roberts, Burton and Brown	Dadra and Nagar Haveli and Daman and Diu	2021-10-30	2022-08-16	Suspended	oulm0e8jou5rpx6cza6k4gievrnvft0jybx2mmuduzcflp4o8uksm8sko1ntzg2n831gzrk8av42fgeohpmbgntm9sxwm928ttw2lbip6shb535p9tu24t58bz8w0t6r759fxh4jkxmb6r3dcrwzxbeiu5itnqhccpahpg1ros1zezd6ptwcbc8xennurb2o
416eb70f-5c3a-400d-baf3-8087f295b6bf	E7IMOJF3XVF7	Walters, Moon and Simon	Goa	2021-12-29	2026-01-03	Active	xyvvwp99qf7untw0pzouoa6z1sebtb4xqijimfd3unighzjm7856b26ylx7b0xs6ysvn20fuir2l7d
59ed0480-df7c-451d-b7b6-7e15abcef29f	1IA2JVKGE1G6	Donovan-Brown	Karnataka	2026-03-19	2022-09-13	Expired	wk51zz3k93hzk85ztn9uws5sy478dwauyn0lkqxug9ng7v2e5wntgv34zl0oaqyfiba9cy8v1ekormzmhxdd0bufek84gknnepijyygfyb4hq1
65e57b5a-fce7-4d8c-87c6-8a736103466d	IB9PUNN35RYZ	Griffith Ltd	Nagaland	2024-01-18	2023-10-09	Active	wzdiyxbcacy964gg9wc1nt202239ouyuqtyj8u1bh0ecmkp9n1pu47ch7cfx9qij2akba0o0wc2n6ekk0jvtmx1
bf137d66-5ad1-4baa-acca-cc4d3630daf5	44BUQJYRLLMH	Wood Inc	Chhattisgarh	2026-03-26	2022-11-19	Expired	094uzk1e44e0luc9lzkuuxskudwyhcjd3cuwepgde2apt
63a0b797-2701-4850-8b28-1c344bcc66ea	0GV6893OVVE0	Moreno Ltd	Uttar Pradesh	2023-08-31	2023-07-04	Active	uqyr45borsm7acztrh4ox5drftvahssalt3m01wrq9269nwdyi5zj711n8ynkdhn2hxrk3seshhmch7to32ubirrhxnqnrzp0fi01gyi1sxanq2zqofzdmtqjgagtmprpninqviekcv42p
a2052b32-74e0-4896-8865-f5fc24e47c10	5XASB2VB00S3	Foster, Hickman and Love	Tripura	2024-05-25	2023-08-20	Cancelled	545gh06l2nm7qsmsjdx3sq2r55bo7kmsxwj9iq4p23eqojal372kcipktkedezulb8c9zid9n1ei870ollfpajej28hhw86so6kr9fvgo9nw2y3ti6bzf5fmku09
86a84af5-2e1b-451c-8d74-c028b2d6bab7	IQR0D6BI06VP	Wagner, Chavez and Cooper	Maharashtra	2024-07-19	2023-08-01	Suspended	5tzzpvj80p0g7psm8od25r4h5idm8a87bvj0g2krggpkwrt7inbnr146ff32v5u8abneqb0p9jneelhe9yfq7dbslenolvy5169fkg59r1tf7q6o0
b9c3da4a-d0f9-414f-98f6-27c9f5509b6e	8OBD3206WWUJ	Barton, Stephens and Torres	Andhra Pradesh	2021-10-14	2026-08-16	Suspended	jty390dn1o4aqd0vq4rpphje4zmfb93wdoeidf5b390i42zwmqmhqf908leli7hfq1rz0st7znzgaw8wn5tl4iw5bo1hajr1pa2oqb7ju2qlitkhyy3o7
979806b9-ac05-4217-88b0-37d7e896955b	9UHXHJR2E17V	Jackson Ltd	Andaman and Nicobar Islands	2023-12-23	2026-08-08	Suspended	vdl7tpmgwrfr61pdra08bow4fdph53udubmd87zhvayvf3cyq3g2w8t41zalq0c6xussosy3t2qiuwypp93whoawp8pkleca6gbgqbyaljt8r2rkuqhhfu3gsv35pdobq1qjaan9qo3uidckdv70yb39mykx
e32cc496-2b91-413e-a409-089e719c2a64	QYGWCGYBSAAC	Mcdonald and Sons	Telangana	2023-01-16	2025-10-07	Suspended	ycqgk74v4qeepmezp8qyx6dbnktqgjvm6meqrrvhw8n95b9xgnr61m1vv22neketdl7u1iltmaizfbbg7yaquygfp54fg2xfh
cf4e7e42-b4d0-4672-a5bf-8b087b3182fa	4HAYMNEF7UWB	Ballard-Fuller	Odisha	2025-11-17	2024-07-18	Suspended	qvt0z71x4vigrj45iko6d5afjnvxacovzigndbx13f8qop58xvme24n5clyihiv252sqdaa79yh6liykig
c48efd20-6e0d-4bc3-92d1-67ef212c328e	0XBUUABNMNAS	Montgomery, Phillips and Obrien	Chhattisgarh	2024-04-02	2026-06-24	Active	nv2to8oib7pcywvhbq52t0evd1omaj7u8xsvd4s68t8j3jxepnb9rredf9llv98x0v7w7phxuoz6h2813b0r2n7fuzuvd2vltnn4qb6j5bh0t32r03ptull1sz
afcaee8b-c5eb-4d88-8980-23e3f2ace26c	HPRU4JHZ2QH8	Hinton, Green and Flores	Rajasthan	2025-06-04	2022-04-30	Active	e32wtlfvije27crphhn1hxip9hk98ajlahpqetlpoew5p9lwsxce8f8ddk8u44r93b2ku5hv4t7qylj6sq2m2klb3qdv7cerad9joc30
c1505a98-04bd-468e-ae32-181904c6138d	JEBU7637E0QS	Kim, Walker and Parker	Ladakh	2026-05-23	2024-11-02	Expired	40qsdyk76usekki7821btmnlckoffe1twgtp6jrvi2wy6refrbl4adkniwb8alymrqv7iw3ymexa2q2nfwk9qprxo96omaio4u7lpi4sxcnm8etd5ug797l7lqqd5kvkmaemv21nyr1o4
63ec6aa5-49df-42c4-bd67-f27dab5a846e	U2P0H7V7QF9G	White, Short and Davenport	Punjab	2021-12-19	2024-07-30	Active	188od8omwpn9kxl3ity1j6ctn0qduby232mmlk7g67ud2jjzdxp6x04wmldu9ua5
c6dac6d3-50a9-4002-b21a-1e7d779fb2f4	JTT7UDKGL4QO	Ramirez-Klein	Karnataka	2025-03-05	2021-09-27	Active	jqd47oy4pbh1uhki7auw33som4ew6065nshayfufa8if71s9lk97tdjzhwyb9u2fycdzgo8b4j9kruysqiwd3b8vnb1ivjzs26sx21f1fts5ehuxb9dorp58j2ahsnbt4nn8971fw7mu161wzzqcr6qahne19tgtebgqddbzfus34axfo1zw6
0d7a4601-a8ef-47c8-8c4d-a170442d3f44	U3FG5WAPUWD6	Elliott and Sons	Odisha	2024-11-23	2022-03-01	Cancelled	lugg9ng7oxm5ijijp5y6g4bj8ny6aydbplkj8vjf75942ti3cpltlu9ed9eer14vbvyejoqg74e4blkt
36fcb752-b70d-40d3-9f56-42f7812b788d	5FBBFNRW5M2X	Peterson-Perez	Chandigarh	2025-11-01	2023-08-07	Suspended	ntnqv6now4hnhup9uyjg4jo75h5n0hz30rcqrd8iw4hsyluodkm8cqmb9phfwlt842au3hmqtt85pw5e8hfbrv20ka2b7eu1m5hyaxnj5kl6q3a2joi0cmi06dg78kbst62hkw0d94t51y820c91mds4o3y521alm2ydecmr3c51lcqzi5s4cngjjkl1
303a187d-79af-4a01-b704-c637c445f685	Q7PIVMFZIQBK	Miller, Conway and White	Andaman and Nicobar Islands	2025-06-10	2023-02-06	Expired	rug5k0jjhir5efcvvntgqywwpm4l6sey3oayx4e0r6hf2g8pyyye6e1ttsx0opmwd1g7ut4yj
a9817c32-b068-47ff-b4ff-2cc8ede2d959	TSSDEL7GTQLF	Murphy and Sons	Delhi	2022-06-04	2026-07-23	Suspended	aj5m9dba2887y097kdfjkc9vr9sf9kgatax3dg8atbbayo9l420eapi0ak8xir9fudcpm61e8oemzce3d9jre44j1n7bl5vv73m8juhe1v784yxdbnkbjqyhs11svqvihl7ymnltt0hdm9k54n2roqsmpqi07ccrmh80wq
74245377-38ec-417c-9da1-aa979d177f5f	M6YE1A9BYETX	Spencer, King and Hawkins	Sikkim	2023-03-24	2026-01-18	Cancelled	f7xi3lmgkgzi1230ukdub46dqkkqxt6vorkffj1
c668729d-1442-4033-bc18-47767f0c9be9	7ZRTPIHHJH8A	Walker, Harris and Gibbs	Telangana	2025-04-15	2026-05-30	Active	xkihb3iw6wjk3wj
63af384d-d92b-4322-b09d-2686ef674a63	VG8RQ3IBEHON	Buchanan, Perry and Smith	Arunachal Pradesh	2026-08-19	2022-10-31	Suspended	r9feu9jdv9uyej2qim0vp7thvl0q5su3mzgrrfm7xifh9nvs4q05qq4xcvtnwmc6ncmvqk7x517zpr0vtpqjcdjonavzj827zfp4xhj5qxeflyzm1wwgefrsy5qox3k02kuohth49qfd0bwmt864m0iakn5rd6y463hla2axokd72w7smp8
d45595e6-29db-46f0-b6f0-cffbd8c860d1	XZU9IMDN68HC	Koch Ltd	Lakshadweep	2024-02-16	2021-10-13	Active	s6weljku3psetns0shcj90c63cmqa2l0tiroiqsln126asssthipynw7ftp98aolis3ourhykwdu0uvsj124ltpmh24rllgnin9r5ydsc7haok9hh30equdezlsndaj0wyucva1g61xv7nrgh4n16ejq273eg
e66c08ce-2cfb-407c-9512-56779c048ff0	BNJ0VDXWNC22	Brooks-Williams	Arunachal Pradesh	2026-01-22	2022-09-22	Expired	3k8a9vvshwkh2uvlg76nmn8vkyikewc4o7zocnabaou8umt1cydg8aacnmxfy20q6q3r3wh3twb91ykoeah1lccno4wb7s6oqf72fuu8n74be0s9b3gpqo172txpobx7enbnr9heljm2i99kf3qm16f7iaf4iybhv6yqahv7b9ixebjjbuqq9vnh8a4n0roq8dum
f3b58532-d103-48f2-a35b-6810e9865077	6BOZ5URUJ0P1	Arellano, Wood and Jones	Nagaland	2022-03-27	2022-07-14	Suspended	6hj1yu7ajvi3znj3bmq2ocjh1vwgglak98vzos6nuhre
6bdd9d3e-5ed4-46b1-be73-7c6f28dfda99	8THLVDMQWQ1U	Silva and Sons	Dadra and Nagar Haveli and Daman and Diu	2026-01-28	2023-12-02	Cancelled	e0u9nkua95a9tj0ieajzpyzyroavex2m9h35eojf1srnb6g491e6ganted8696z5z2k0fpl6yv1htait6j
50d04de1-4745-44b8-b0e8-d36d306b25c3	02ZCS9UMH6YO	Sutton Group	Tripura	2026-01-06	2022-01-08	Expired	f2ha7b3vftmthc696bhgchwhfbq1jjgjxgpaesild3mxmbp09qaopam2f2ad44r798qskfgrwk7qnot7vcenlu3u67jh6nqtgid228j3do4uaq27psj46huql8j3uvdy3zveqwdyyyz98387z2otnwhe14i0u
1d3b6ce6-c64e-47aa-a080-a6f206db904b	35V9BW6HS92R	Wright Ltd	Uttarakhand	2024-07-26	2022-11-11	Cancelled	sxk876nshyc9u2zpa8l0cdadmp8bozt1xhp7xmaca7gg
d85aba76-26d2-4c61-accd-4b6445ab131e	3UUFR0J3HJJ5	Morton Inc	Madhya Pradesh	2021-11-15	2025-03-07	Expired	8fl39av2nce0jii7lvfdyyqa8fm6dogw5tbp7wqrhrb8hwq6th3wbmnu8rinh9fcepq3ohn766ficfj6ua0060hjeqrahrbor9k6f3fz4z27a1259h4yg8eg6j7wja0a6xupj8n5253uxgaja1lgqbxrwmcy1pj7acvfwuipvg4klcc42s
195da123-8228-4177-b5d4-52216f4e46d0	WFQBW63V5HHE	Cox, Murray and Fisher	Maharashtra	2026-08-27	2021-12-09	Expired	a8jfcuffqv0cvdz0subazjdxrhf8dx15ob1ycfup3hfky5wa0isvmrob4pdpi61igg2nk3st2isstvynp1lopwq21n9kaucn4htvg0t
3d67cc83-e24b-4f04-beb1-81a6caae9570	GQQ3AAZCSI0N	Garrett PLC	Manipur	2021-12-26	2023-06-26	Cancelled	utu3bxaacqc5z6do6zaaxrkzha7ahsut5xksvhi3ze406d33nkgd2wtv6109zqkck2upl7qf3gjogqyscmnb3af55ej0qx2vlqgjf7fwvlwj7zqqmno029ce43gotfvhu1s4toqw1qh2c5l
98363659-4a18-41d3-a64a-97bf11c3d050	2HPT9NL62AYT	Jackson, Bush and Harper	Odisha	2023-04-09	2022-04-05	Expired	cr4998iq68c9hou1k56k6x2c95z7ps3cwco1g3xtc71ilmahybiq3ir3npjb84f41jb236yc4jxewvsduf6r7f2k1h3em
e0acce8e-6b4e-43eb-8bde-979152767b54	NJ3KUG7HA3FG	Nguyen, Smith and Lopez	Gujarat	2025-12-25	2021-09-22	Expired	omupqlvius5usedrjlyapyjyd7hx8yka1a91pwrw88v6l4ex5iyjg779xr6mi7ux4x3m6k925vyw7d793c7d8x1rj9fmeixgmh7uoqrsot
df548289-bece-4882-955b-deba3e3a820f	QUZYJHK1OMX9	Phillips Inc	Mizoram	2023-03-03	2023-02-03	Active	7df2lkjaxf6y02yaf98v6jxx87no7efvd58a98l5vdul7kg6dlkmy1cvmx6wmgf0s2ht9wpp6o7o50lzrwu6isfg3wrmizkojm8lx
92ff849f-e8ee-4467-9066-02a9a0267994	WGNLBK3YQR0V	Brown, Cox and Harris	Delhi	2024-01-31	2024-12-31	Expired	xzagym0c5v6fr213olp5otrjuyiicupfuewrbqfe3s9crbyu4ictmot4qht8jf5rcibniwslb7fkldd0fmvmwr9mtjlyk4ayfl4wmud2k2
de421978-2098-4e2e-899d-30aa04eba966	MQWY2QG3BJGU	Williams-Mills	Jharkhand	2023-04-18	2025-06-02	Expired	liimchbw8jj96mx7ud99ceg7lxgfhb0amgo6qm7w52x4oikfcdlnbqz7sq9w66nof0sgg701
559f5d8e-6061-4de6-87e6-a6dec827fc31	WRQC42MGEBDO	Sullivan Group	Andhra Pradesh	2024-02-02	2024-09-06	Suspended	rg2l9iyymmt09tew9q4q7f41kfv158wjqyknct94ugxqve7vljavmpqkepw6chmdrwvgiylppbl6ddz32a8fklauth517dgj85lcwtqjlau6g3nrazyie9gqgdoqz0zch97lyziy75k24o2a1o96b3zuu1fjyl5zl667fp7ac6ge58vnpk73d1wet989rtf
95d2cdba-ff6b-4dae-a2c7-e10268fb3521	RCUGZSENL785	Miles and Sons	Andaman and Nicobar Islands	2022-01-03	2024-06-30	Suspended	ctof4v7toxk7wsr3je94irv0k0hkob31ouflkayx8l0zgefvkqlnz6apr366x4cz052mpb56fny6virj7l
13961426-89e2-4d3f-b134-82a7aabcd7a7	BZBPDQACP1DN	Santiago and Sons	Gujarat	2022-12-19	2022-03-11	Active	opvm0487r1nkskvg1qzz4hw2wg45q2tj3c6a36qbuclrwykgdy982tbouzwxvm6xf2pjswq45p3x89wkyybvpp3xvdld78bvm4me2fpgxwcv3av7yzla6wqoo34pwpyfw0bkljdpx9cx5v5j5uvhukrldqwp6bunmdv8dd7ha0dnzgm77f7yv3c0sa3
61737616-95de-4018-a9a6-a4f5c921f850	5N7856V8JTKJ	Hodge-Wiley	Karnataka	2023-12-30	2024-07-28	Expired	o87uw5js3excsd34bimgrdl4vd3rowi62f46zixbu0v4q96wbkdy6nocrqswxnurbjt952csycpnnxj151bdd
34705527-6335-430c-8212-a6273ea23a52	75HNCRG7HJM1	Jordan-Taylor	Lakshadweep	2024-09-06	2023-06-08	Expired	ci3x41mz8bqgnqkcfs5nb5d0r6kz
c4933cd6-a9fe-4a64-bb90-5116a01359cb	L5A7ZOWRR5VR	Kane Inc	Himachal Pradesh	2023-05-04	2026-02-06	Active	ef5luhi7wcq0yswjej81cy5e1ug3u9fead9qp0oiddesosqyouft1xvyv1q6afi6abfi3isravkfmig4oefw7unvr79f87zhg845q0yvriue7w76w0p8ihyg
23ac7e60-8cd8-4ee7-9a18-938adca80e3a	5OLX3J9BHAGU	Brooks, James and Gonzalez	Delhi	2023-09-30	2026-07-09	Cancelled	l9uhbqrz4jrzcar0um6duwbznp8shmuk48gagizfzwzy9lb3zar0umysttj9r4z1d3absxyig23kw369qnzxiyr9uednf
fe08b9ad-b4f2-4866-a5cb-63c826532cec	5PEASV23LXBK	Daugherty, Smith and Mccall	Tripura	2025-05-25	2025-03-12	Suspended	jacovq4sljucp0xswk5jiykkdqnm7u4r6lz14cjoeklltrooizmqnyge0xdv4uyj1xkw
58bd35f0-b2b2-442f-b37e-b670a4ba5208	78WL9F9UD2XZ	Morgan and Sons	Uttarakhand	2024-04-18	2022-08-23	Active	9cm9nc8bxvlvgg5520qynekcou0si7jmga6xoc1klmswwj2vazqnt67faspe344dedylnxxmje1gnv
c756b5ec-f0cf-4f2d-bd0f-7567ff1c23a1	P7OT4AFCO41T	Garza Group	West Bengal	2021-09-02	2024-05-30	Expired	p0cktjdyqi2d39bvwmnocy8vjvj5wwqdoo7sxbt5q2menq4xgydwgu47u0gc50s9i75od25v7qh30m9r0t6
88b11f92-0668-4ab8-bb1a-bbf1e9f43cd6	FDHO3WVEK8TQ	Riggs, Morton and Carlson	Punjab	2022-12-16	2025-10-13	Suspended	uz8c0v7ccc2zejhc7lriuphjmpwplz7nghzl40ul
f4bf487c-253c-4319-94ff-3f6de3cb5e53	UW65BTIDVQX6	Todd, Miller and Henderson	Dadra and Nagar Haveli and Daman and Diu	2025-09-28	2023-05-05	Suspended	517k4qdi6d9s7oe9mlkugy1eb72bmwiwy71wplu9ik8ozi5zquxm022f2hti
f9888095-6f61-4e3a-93b5-44c972493c80	90XMN63KQNXA	Hernandez, Burnett and Brewer	Punjab	2024-06-02	2023-05-28	Cancelled	mbiowi5e7sbqky3dkwd1hfgktmf6y8grdy3jhwj2o4t452i260wentru8k98l105sjo7nsj1sy7kd7zl7k0ewjmpg12uxo7zh1iabo3dz6gvxf5otox11trrc64i9rc5xdpqbbvz3qxg8jwit1nn8b6e77mzxgksg
3df6e93a-f145-4216-b45a-6c70e3d9eb00	GM85JRTKUKN5	Moore-Randall	Dadra and Nagar Haveli and Daman and Diu	2022-08-05	2021-09-09	Active	865ermaujx07dib77rni26rpymtl25odp82au8thdgtqvtqoybkb32c8mhenfsxp0ee6lt27erh4r3yo9erg1tepkzxel81c3laaqemitg9px71x6ms4ubsf
d566923d-001a-4d78-8b78-d227531cba16	FE049HXLTX55	Brown, Robles and Mitchell	Chandigarh	2021-09-24	2022-11-23	Cancelled	cmhadep49oxawkpa7hqh9hnv7oykoqda5c3qyo996ylqjdmeq76lojfnxbm23bj2wotsbewuc45kt1u5xsbter2z272zdxvkdywie4zpxov9u3q8ot645sdnjkrcjptlv6p
4eb01c6c-7586-46f9-b21d-9f9f959ac68d	AMK0139ZUAAR	George-Stevens	Manipur	2023-02-20	2025-11-20	Cancelled	600c7cybpc5dev1zrx9v4q7ngjqhtzrs66h1idajcvynxyqe2xm7snlaalfo4doilo0r0rvykfujstu3izn5iro7h3al479mr8wtxi4do7wjyd9
0e1d30ea-0669-458f-9a5c-e1c3f6ce0439	8G5MB12AHWMA	Turner Group	Dadra and Nagar Haveli and Daman and Diu	2022-07-07	2023-01-19	Cancelled	c36d62bxtyt5jys62eqpdu5zy5senjd122foaijjt0qqf
42b763b2-3719-46a0-9c7f-a60ffc17fc29	6SOTIUXI5ES9	Solis-Graham	Ladakh	2022-03-23	2022-09-06	Active	643cryzo9i6bxeqelx0om5gxjl17yb2n8yqk6ym1mbjgmqduqj0ek6ph3x3itoux8ylp4ojs29wtqdua4svw37c37q5f526o61725kwra4fvxohn5kfnttxgq7bdp6
753f2bc6-fb78-487b-b678-9f37bd4a5f7a	EV3MK9Q7MUG6	Martinez-Bowman	Jharkhand	2022-06-06	2023-11-26	Suspended	jcxrb9yvwpt9bprjtd0y4i1ifbr51gj9ri07kqnsxa84wzbbl70g74sjkkpm11i89mn6t5iy88n02m4cf4ykcyk1c1fgfsy6n7bpe0dcusedg
d8607df6-7e2e-4df8-a3a1-30b598e1075c	Q3RIVVRLMTDX	Lucas, Kent and Brown	Odisha	2022-04-10	2023-12-20	Active	7uefwzena7vkcvu18zu4azovjuker69mkiz7pnbz1jtlb2q3fioc5yb9j2mvxmb73fwk7j4n8ajd48b2wxlhydbuvoe77s79xd46i6t9bkh55f9cfkpkvc9s4iepvevhwnneqrffjy
4cf512d0-8c60-46d8-b2e0-ee20b4bec289	Z3A8KPKRPEI0	Gonzalez-Wilcox	Delhi	2023-01-08	2025-12-28	Suspended	zd7soqjipl5eit022nqk3ubb6kgayalyji8vnww0vr3jhob8povgukz5v0i6lsjomhi0tuu2v9zd5onv0avyxz9zf6ogpnyr7cpmbhngv
5d9fc806-4847-4eab-abbd-3ebcd1ca90cb	RONI92OJJLQV	Moses-Martinez	Uttarakhand	2023-01-15	2025-01-04	Suspended	jyajfm7s8r38tonez0jl8v0168q30en3k0vekz44ucprca9mhdhmk2hc94xla91q
2b862391-4720-4415-84b8-096429d773fa	0A7E9SEVFAPP	Stein PLC	Puducherry	2023-11-17	2025-05-21	Expired	wjhf2ay586u6s9a27zhhnp8xexovuqnwoonrwla54cajcc7tsf11og7b3xsjj09juzocfp3yz53ng6rte5slznoqyhxy5nqszg142dp132s2e66b7l35vbqh2t3egdtkv34r8kqua254ee56ud6ftrzh8yvu1
b8159cc5-9cb3-4396-8b32-6706531f85c1	2SHH6PT5PW5G	Lawrence, Vega and Martinez	Delhi	2023-03-07	2022-07-25	Expired	wh2aci58weq1ht1rvnlhsxtubdxbfimhbu6j8603v6z29w559rapy0k
caaacee7-d8d1-4d0e-a834-ad632dd15ddc	5Y74M8A9OW95	Vega-White	Jammu and Kashmir	2025-06-13	2023-03-29	Suspended	ny4dlm5rf3t4dl32p7fgszuibk2saaj73af9blarsw9gkda5pq9l1rop7klk65r7rlngk1vzz9qsadle8393kmha8yoele2oh0vnwtju1oe8xw2uk
9abdd5e0-6701-4ba7-9d33-8da5f4ddadba	V6EU8HPNDAG1	Green-Ortiz	Lakshadweep	2022-07-19	2025-07-29	Suspended	xdadvhvvl22c65lngwl91k9ihb3097x07dadaqu4u8k74m9httu67mv3m42ye5zgkvssoh9vs1u53j90pux7jsmzlvgfut24a4u0c5aoac1jro6ey8cxcm4aisop739etf3ca8q657txx5zumlruh6bdhtystb0i4cnrnzgrjsy2u
3a6c2d5d-d3f2-4ea2-8f92-d7f76f8721e3	V7O47YH40P2H	Lowe Ltd	Tripura	2026-07-27	2024-06-05	Suspended	httc64c39f8hryu4ne636zy0uzoy7vcyt6kikb4rtoai6veszvd11c6r9amjl8mdkdz83uomesg3ep6zcily7jcyx7q1rh1ns50bhfayde5d9lw3cul5wu
128d8bf0-9549-4b92-933a-5ed37bbef179	J4FCQYG63FW0	Stanton, Johnson and Gray	Odisha	2023-02-27	2025-07-18	Expired	bh438hkeq1gp7dghmsxkdzj8au49bxibqdoj5pbi5exhivieyme0op65rhse4tf0bbiq9djszyizvra0k3jdnvdm9vza1ylwavw60vtqsh1uht6ig5qn4mztducsr5m6jt3268y6je0vu
b7c71aa5-5617-487c-bc2c-98efb7a36a18	WEL9VN6UGAKH	Whitaker, Pope and Cross	Ladakh	2022-08-03	2022-05-23	Active	pccjgubspmv42txmkd2jaltgvseibq1uyhmqd09qfxha99yjsv2muztwr01l666afj13n5tpldx4unrq5a4oqwvxvz0ow1j34op02tfy20jgnkbf42ws7jm7lpihv3pw57cfwdr7una5qjcuf36c3h6fps4p2o24bpagcug6akxyltu4h0mpnuqc4ehi60e34v8i6
d2b1217e-2639-41f4-80c4-053a6a916f73	CL0PTR2ID0JF	Gould and Sons	West Bengal	2026-02-06	2023-10-23	Cancelled	h55rk6mw2ik8fbxsilfem9c8gecnuk5tqxvgwrsdxfggwrdp0azq79xa39a5rh7tm7t7r4un7acf29x927u631klma2lec13brrzpzdj2clpzsuzhee2lcw9x0nfzyc0vxzsojjukumytinfsrwul4ddrmrvcqrpn7kz67fa4ixexai5nnyf45
37b5c4db-d84b-46b2-b4a6-3ea6a9d28a2e	W9CWQ3TAJ0FC	Bass-Brown	Jammu and Kashmir	2022-02-06	2023-08-18	Active	dsg39cche8sz4z5j
cbfd6b0b-bf8b-4ae9-8888-7db4c9725a20	MXJZ19XP5KY8	Flores, Peters and Scott	Sikkim	2025-09-15	2025-09-26	Suspended	37o6xqc8ucnrktdskzpir7sq0hbxajs7vculzywril6fh35dkjrhui6v69i1s30eeacpdth64tjjst1dbcbo
1ac596f4-d65c-4cfa-9808-ed93a2a2fc4c	FI8MNW4I0WCT	Gonzalez LLC	Meghalaya	2026-06-03	2025-07-07	Suspended	oooju1h5w8
29a1b30e-6e50-4471-81a6-aa69cd9ea71b	028JAD4Q83IW	Smith PLC	Tamil Nadu	2025-02-03	2021-09-03	Active	9xwjlto4xybq623rw2wdiv03ylq03zur0wsqzayudm41kk5aqgm9jl5gihwcb8i6ziyhu
1e2fa53c-31da-44b8-be6f-14666765c24a	WF1C0G9AGYN8	Thompson, Wright and Williams	Ladakh	2022-02-23	2024-02-28	Suspended	ng6n01b49qwa2xbkgi03vrvaitz6b20u0n9lvwzu0767ixioq7bclanojq9lu98i253n4b1
4dc50c26-7ba6-44cd-a84a-7cb7400daa06	MENZFDWW0IBH	Morales, Hernandez and Randall	Uttarakhand	2024-10-08	2022-09-22	Expired	xxs6zke0
5ca11a9e-3674-4865-a7ef-0522a122ef92	71G54MNZWF6A	Kelley, Collier and Todd	Jammu and Kashmir	2022-05-12	2024-10-29	Expired	m13zig7imlu8nscp4f4iljb3
41c83ae9-ec77-4b93-872b-ff45bab5bf3f	U316JB94GG3V	Patel, Baxter and Warren	Telangana	2023-01-01	2026-01-20	Expired	9wb084dqjjg5g7ei306jtd602jlkq7nuz2z8gq1zteor
4ed2f8e3-83fa-4f66-adf7-bb3976cc52dd	1NNF9VPGZY0S	Wheeler, Allen and Hall	Mizoram	2021-12-14	2025-03-03	Cancelled	xdcu28nztdy45iebvbtx3ov8lu25q7amb26j87fuwwvlchic9p52r7d0kfitho3oqxds357i57zak509y1uih1lks9o3tl19nrb7cu3nckxqpetmrjk3ovq18ly3l5
0ad54251-18bb-41a9-82ea-f8b2917ac4e3	TRTD789MFDOJ	Nelson, Novak and Johnson	Ladakh	2026-04-20	2026-06-10	Suspended	ul9qstshiqg5fw1jpe4pt7fju5p0s7xyw2dmhsbnrdq9nlfcd3d638p9sm43ullscjnz2nep58o2prc9b6rlboc8x8tf4kjtygftsym7lyry9r6vq05q3z91byvjeemj5c5991eu7kcnqqjer4g53uxy9qknqsb8g34
257560b9-1cb8-413d-b155-1ee6448e695f	4PCB8J472UCE	Doyle PLC	Lakshadweep	2025-02-09	2022-10-11	Cancelled	13xw8bf8y32l34eghecxud2q597z14id5xrhtbhyn0abybj2kld7nm271w5unjo2qllufzljs0l36osasg5nk6vqxtffjrku74onlmxo5qsjll22pxh05oxgnqn1r1x5zolfmm9t4gnlmzvhgj
1666f7bc-6641-4b69-898e-4bff464e3720	VQ077YCR3B0L	May, Kemp and Walsh	Rajasthan	2022-06-13	2022-01-21	Expired	y36kkqm7bhjhzuulidkbcxep5wrgd0zvkzwcszros7hre62l19j2denp0gjfghslhhrc1y39bryj6olscat29oktzpvhzk5dt0p1ipjh9ptngir5yq
da62324d-9e4a-4192-8888-202e9a8217ab	JTSMGDY3GS28	Johnston Group	Chhattisgarh	2023-05-14	2025-09-09	Expired	w6ysw9cghfg3cbcgmk0kr0ciqst4j0yy0w7sic4on4vd2k6wn84npuj6etq1lc6z0nn13s6oveaajgf97qd2w24ug91lbp8dg70hx8l559sv9kgr70oqaqayzkgx8jldif90pg8tbb16tpdsbic37xobemiv1qlo4jizu3b7eaov6huddg6bzqb4m0nmanlg28ouqm
f2f56d66-8400-47e3-a708-9666c6ca233e	FCJ4HTH3QRZU	Smith, Young and Bird	Chandigarh	2023-03-15	2026-08-24	Cancelled	29pe5l89elb1sha0qysgqoc9t902cb9cjzwj384318qjoqrdke42jpu7i2pheqc99kmghsj5n26lmtf9f7vbho9a446cca7nng
61b5b74b-598c-4f08-8c24-ce28ea93f79d	MZJHYDJZGQY8	West-Wood	Karnataka	2026-08-20	2024-01-18	Cancelled	gctc1r6uwvwm53a9iv627c7wrhemuidqaea66x57t45okt45qy8coyzf0b2u3uw9hxt55bcpcm1soy7bs0yjr5fse7irmfc79rakfhjnawlv3n
8b9e1fe0-1611-4932-b23e-2016bd6767b2	E3ZIN9F3DCRE	Crawford, Williams and Reed	Lakshadweep	2025-06-14	2024-01-30	Active	1rplf3a7qy96pgegqolrbfmtt86fzu2zlc8f480cew6ehg7w2wb6zu24vbz6j18zunmobqvf9kksfh8rzw264zkftyn3ww7xsfeahtlgxxwcge2sh9n2oq8hyy7z41bqra12jn5fb38kz9pqj1oq6wzuato9u6l0y98y7wf26t9syl10gjmm7aggirgfvuj
58104255-e259-4ec1-9c5b-f76a3b5d1121	ID271SJZ7O9L	Bennett, Hill and King	Rajasthan	2024-10-06	2022-06-23	Suspended	t42a6kar049k570mwxil53yo0m1
debd360f-ce79-4f4b-afa6-3d5fec12da9b	FONCL3M2475E	Alvarez-Moses	Bihar	2023-07-21	2022-09-06	Expired	ail0a1z8sv6heip62uydxvrbq1ts1qg4agrw64ub3llbvn2pi1rfxd6vk8shzaq9zi9htxiprflizkmt4kwrmmwyy2w
9652a524-9fab-44cf-b091-3f122aca0f48	D25F29J0HSFU	Hickman-Kennedy	Sikkim	2026-07-25	2023-07-22	Expired	v8cl5glfmtknc2uatskzbjlzdx0j0ialw2
19003feb-da72-4da4-9052-66d90ead4b12	FSP0JGFOGI9Z	Thomas, Miller and Pugh	Uttar Pradesh	2022-08-22	2022-03-09	Suspended	29q32rls3a6kuc0bsp5zqhdvlr1ix8
c95ac9cc-efb6-4f4a-ae69-5b252d1ccf07	VTA2QL3JF4K9	Roy-Edwards	Kerala	2025-01-03	2024-02-28	Cancelled	ki8tdwqlb0nnf47irdbcelroxl5jp
57b2c4fe-04eb-4431-81fd-6067305dd539	Y4FQVOQ8VP7Y	Williams and Sons	Karnataka	2025-02-10	2024-12-15	Expired	zzxcgetq8zmqterqr0jrgrv70zxc4o5wrn1oy4u6cez35r6k2bolv7e8yum53wbue2fvrrvjvjoiv1ivh2tzb16a5rtia2j61k006ujga086sne66wxibyfut5pzghidhzww7tj7iab58krituwup9tiiaptms76qlvzimqm41afnt54h4p
7a5a2b4b-24a1-4594-9611-8618dad4c5b8	DG8I0K5E73RY	Crane-Powers	Odisha	2025-03-14	2023-10-27	Suspended	tzs7yrrvdfw4p1djel12o579an3ewdyxusq0hqfh78k05zmamdv92wcfvqfpq4ggm3lh8yw53b3rdarxz3tn0nlr7bgttw1c9anl823w1tldluuehjggvd13v6exvvld84ac7ha3awmdq5zl2cm0duuwkjtf6m9e7ku75kbee4mm1hs52j6sy
dbcffac2-a64f-4342-b021-bc6361c72926	RWLVUWXVV4TG	Simmons, Francis and Alexander	Punjab	2024-06-15	2023-07-26	Cancelled	ql1paonixarli3d2hukbdr1ocla42p
4d6aa64b-4c09-4720-a928-2e4ec71cc425	LE7NQM4UW1RL	Bailey-Wright	Andaman and Nicobar Islands	2025-03-17	2022-03-02	Suspended	h4p4w2gmecefjtg5d55rxjn05gdqp9c59yuzm1nq5w3yw0s0whlk7wbno46rlgeodjqtrn9o41tien5zwo79o2ed6cr5tkk7bzl36odb9vhyzo7nbqgamvx93w2148jcfmsl7porq0lkxhe551an6ytww32f55a2zghgg7mvjvob6npbfsvw4fucv
0d492884-8ff8-4dbd-b762-630f528b5b42	091MLD8TBEGW	Gutierrez-Travis	Tamil Nadu	2025-11-09	2024-07-02	Cancelled	617l54n4abfybvvl5
f9281445-6e7e-4830-894a-4413b2d27366	363CKKQ7ADLG	Beasley-Caldwell	Punjab	2024-12-02	2025-01-16	Active	e6op8tfov4ry3rupap6sn4fot2bgs3l4e6506wvaixt0uafjwd8f3ezyjt33sprnya8a58uwb8ckdowynmkenkbqeo6kwf
00131abe-aec5-439a-bdac-bee56da77c64	YW0LVUTWW9C5	Garrison-Bradley	Jharkhand	2024-04-24	2026-06-06	Active	861ok2tvn9xj50o1z5mjyhkt8uhkif807pvzdijhydtfodvlav6vq0q0zrgup5zbu5rhq1gbndvlbz5wpj2uoxax889hw1rsyhbtm1v54s75fktwq3npp2yk77jrmmhff
cf1f4cf8-8c35-4cee-975d-ae8c6345c77c	KFL05TR3KH0B	Heath LLC	Arunachal Pradesh	2022-07-31	2024-09-04	Cancelled	ibw66ve7ulj9wkpa8jdqj3uvbo9cvbfuvh72nzsx5wik15nw7va2xgbbqazwicdbclr6kvcxw3tmmacbgnn98cup72ic1yx8vrzfyf60tyy
c340a31d-ad8b-4a4f-8107-a38bf9406a06	CT4A5O1V7MK4	Sullivan, Lewis and Hardy	Meghalaya	2025-05-12	2022-12-29	Expired	jfxe5wa0x1imu58di5drjql97mmesqlzsrh64q9e2ppl52npxzba9
047952e3-3159-4bb2-b5b0-8e2461054703	NL6TBV3JP3YU	Burns, Miller and Wiley	Karnataka	2022-02-18	2024-04-11	Suspended	mekhfuooddfie8xrrgknpdiceqr1nt4dlzls0xpa0n1dhayxedvw72mo15fa
09c4ae89-eb6c-4542-ab22-fee116e05ed4	JAJER2TOO5BL	Bowers, Lewis and Snyder	Andhra Pradesh	2022-07-24	2024-02-07	Cancelled	0q7tukj5sq9id9njnj9gjbxkqp2q7nybvg4wyzy5rtkk78vxr4x8iz0fb9tfmci5cvfwiq5xehlyislja37h54tp7r1fg2x8h7zmtedsee64n30to5tb
c6febff0-f741-4f86-b295-d71324ae9aeb	L2MFRC6M2KT7	Harrison-Lin	Karnataka	2024-02-19	2021-09-20	Active	aej1qj54kch9q6trlh0cafsw6ohanx2fc48cl1a8psdx59ww4ohcay8t1wghvm1v88fyexydznyarz8g30sb9vx56qpwohpxc68rn8w00lwnl47sfat6uzpwe6orttcpiynvwr5tazg3gqzvri8wo
99ed1a40-e169-4d82-8916-c1928932252d	Y4MU125IYIWS	Miller, Mccarthy and Martinez	Karnataka	2024-08-11	2022-07-04	Active	8r3xi7fy9iq1mz0mv8g6qzryw381a826x3auq9hdxne8udwoy0v0zzdqgwthgzeccxj9xdb9yz20hr9isg7o5x3mn6ayean0g2z57bfb22vj6yh6t9toj9kzfub7s6q4re4
255ddf31-a7da-4596-a6f4-947ddc796112	WJSQO71G7PSY	Greene-Adams	Odisha	2026-06-05	2022-06-30	Cancelled	n8mkx8z27k85wizc6l8egt4qeng0kvscd3jwy0n4w5anmbku164im16f6qfvqvo8c0bmqh1rjpccugz0s77la8kv38twmhw709425jjadelgurjlzqjuu9s8ekj8maqcuh7ha4igw5gagbgvn05rfp4t36a
b3af6fa2-513f-4db3-a0b2-252da4617d37	5IRVRKVUTNV5	Campbell-Salas	Arunachal Pradesh	2024-10-29	2022-03-26	Active	zc4hjq5ic4j8xk6b42ielja6it6cjticopzhor0ril31dyozob593yrdogzatx6z3rwctpbabnctwib6jly8r5syt12a
4caffc30-bb56-4424-bc70-b5767d0ea0f2	TUE3ZSLKQSG9	Hill, Lewis and Brown	Ladakh	2022-05-25	2022-09-16	Active	ahp6mtvej42xqprji0g5dqt8hk4tkivowq9adenv6jwvdras699ybc7sux4haebexwopyeuncfavrx55p1y9nob9iybqfsirc2y3lyqjb1u56gunv6c37e8pp2q23mirvzhdjs3x0e0rfl6j7kqevwxruj1l4loa
ef1bfbf5-994b-4947-af02-2087b23c78d4	QAWO68UTTIF6	Hayes, Butler and Johnson	Mizoram	2022-06-28	2023-12-14	Cancelled	dg7ytd7w93n3cx5t0en5jan9t8z0mfcx72dr2ljp77qwy3x
8d87a407-9a49-48db-b6a4-7db65e601037	OZYQ7IK53U05	Brown-Ferguson	Andaman and Nicobar Islands	2021-12-19	2023-09-14	Active	2rkmrelfe2gjiu1jd634mbv7dzc6cp1xgnpj755w072ivt6gbr3zekhpko9xu9fc4k3q67vaig
31a57ce8-10b8-4b1a-b545-5bd91c161d14	5BKH0VXCHTXG	Klein and Sons	Madhya Pradesh	2023-06-08	2025-03-17	Cancelled	xec1pcc2huir1pvdvtcn4wb104gqypx
7c3460d6-5870-45cd-bc02-a054c06c53b3	4EHCMF9KVU24	Martinez, Gilbert and Torres	Kerala	2021-12-09	2021-11-14	Cancelled	sc65s0yss
92d84f48-2b60-48c5-bf09-8484c27faebc	ZQMWKWYCSSBB	Parrish-Rodriguez	Nagaland	2021-09-28	2023-03-09	Expired	rzctkbofruamxnquj6fv9bwb66pxd3p
d5865be7-2689-43e5-b80f-4a6bc38612b5	75SFN39UL9KQ	Conner, Martinez and Smith	Dadra and Nagar Haveli and Daman and Diu	2025-08-08	2022-06-04	Active	26n1e4aihvg3ppr4fc1tptp9qsml1jkrkjwwiarfaz5epv9z7dg626tkren2e7vpy6ub0u6mnoxicrgox2lwqfv0q7orvhd53ftejwx458n9omy0jod16mvenkvqnl8nvy7ugq9r
0eda1dda-e02f-4ee2-b977-40f3d5f206e6	DP5AMUWMZS8T	Reed Group	Chhattisgarh	2025-01-26	2023-02-05	Expired	gk1jpwnaadw98ajlb1yybxztmibtp8fs04f5h0xqeqjij277jwqvoxtw9r1udpcxfu13xx5ra4e02sey21ysehtkgj8btpvp0uimkxnz17fqxdxhm4n01g551lpupz2vsb79flt8gpctnwlgwzc0wum
cf4af6b7-c09d-4e40-976d-dcaecdc9e1ca	B2PVZRMIWZ80	Valdez-Gutierrez	Himachal Pradesh	2024-03-22	2024-09-23	Active	z7p46roohz24wec2zhvoruairc8totk23dvrrbfmefvphe9edkazcidaqqzivln2j50iiclq2r4udgaibec52y048ynfwp0k
d2633eb4-c9c2-4980-b7c9-f530f11a227a	83PS7UXX6SMO	Smith, Powell and Valdez	Bihar	2026-02-26	2024-01-09	Expired	645t2i9uedyb9ef3m2
e2e328f6-48b1-41e6-972e-bd1168a9e948	SACZO4ROMKA5	Adams, Gray and Snyder	Sikkim	2022-09-08	2023-11-05	Cancelled	qgb641uo5exucygse66e2ywdil1
de31e0c2-d916-4c3e-bd4e-0aca0b36e69b	G5HS21YC1K3V	Kline-Crawford	Chhattisgarh	2025-01-10	2026-04-22	Suspended	97yd128ql7xnjnc3ibjj0ojizaonwdedehpadesvir8ldl5rdua1zh0u2a7o2sxvbmq4peuhmgusezbbhihae32nw0xok1203ptv7bpyv70yx0vaciv45tbuuckic0mvfef151
fa460f63-672d-4e36-9ee9-c2b8f9cfebc5	LHEZZIXT3JH2	Price-Rhodes	Punjab	2022-12-02	2025-11-25	Suspended	zg3oat1ykbxuvaus1tukkohga7qeqwffil3gb62nnpnut9db871pfak2kffmg8gtf1b3r
0308319a-d7a9-475b-9fba-0e54f1858ae0	UQOGLDJNNC6H	Fox and Sons	Delhi	2022-10-27	2024-05-01	Expired	fvymc45mlk9ciadfuybxhag85nyip79zhlztw9j1rtk0ithvmhhb9b6e4zjf305147auqg1otrje5b51fbzp5i3x1020lvvf5zq8dz5xh9v1vezhpi4kq2ygs45v2d
63a717b0-5cb0-4b05-bb81-584104457da3	700PWYIPFJL7	Conley-Thompson	Uttarakhand	2024-09-11	2024-11-12	Active	d5fp4668hm5dfrxaj08ub6qzw
88b3a13d-b2c7-46f1-ac6d-3a8e42861e79	CPMHRGVZL815	Duncan Inc	Goa	2023-12-30	2025-09-29	Active	6kaq7jwag31ryon0ggx71003aexmn771914oljj5a0truetrvbe2bc5wnnc1u07vhug7n2ru3y9nu7ovb0
7a1be91b-5164-4b06-8e6f-093af85d1fb4	2Z08GEMU9K2D	Thomas-Brown	Haryana	2022-02-01	2025-04-12	Expired	a2wllezm7ejvwj4py4c5lh5n81om08kgwp18uei8st6gfhvdewvjfusomqsrxvugntoje7ahx9luqkomuxi51cr5vkfkn0dwn3c0xtsq5r7h8miillrjnbampjojcf3lyntnopa125f7n07193wua15wuzw4v94a
3e217c51-4047-486a-8416-fd7c2ac9cf03	EF5HFQBMTN9J	Porter-Farley	Jharkhand	2024-04-27	2022-03-16	Expired	vtt70m919oly9kgh4
e100a070-7211-4c40-9440-fa72d2fb2490	WT8SGSBPIIHE	Lucero PLC	Tamil Nadu	2025-06-26	2025-01-21	Active	k88crusvxig4qbtql13tnyrgz1g35ni10azzjymx8qgpk2cr63swmnp8n3p0c4f3l5d7fqjqb80lk3188eszpkldv09zvpnzzee3s2ater5d3mpyuaka79h9zgx2h5ma753abkxp9tn
b9b32e53-e38d-490a-8d81-d3d4ab04b8e9	EO9BDWJ5HNAE	Jennings-Gonzalez	Odisha	2024-08-05	2022-02-02	Cancelled	t160x0e8iuefcxcrseam9h8dxjnfvv04gcb7n3era4u76r0ltes1ibn906hhy152lix25w00ec366h2d4ufachhcjbg0ke
644918d7-6ccd-4bbc-8c77-997d0481b1c7	O8YLZQ0HISXM	Wallace-Anderson	Nagaland	2025-06-09	2022-07-08	Cancelled	6pxy9ibe5wmwje8os7grbxidlh5kfgaj40yamgv4k2mklwl6k99w6tgqb68ow7mprz0zc4k4yxlgiwdtngkvnurwfrznftdrod90t0oj8tatgefu9k5ujfu47z5lyihrelemsgqyrs9nlrg3tdtsvmlokwknvyrkjy9pm4eger7k
c3437bee-ffbc-4dfc-a089-ae3db5295dfb	UJDJHHC3O2CO	Ellis, Smith and Phillips	Bihar	2024-04-25	2022-11-18	Suspended	9mbgrij2worwvrh75uzcnjl3gbwhy9gn2v5rl3pt90jy75usbclv61gob90
1376524c-1975-46a4-be06-ebe5ceeecf94	JFI4PIMQGVMM	Flynn, Holland and Orr	Chandigarh	2023-07-31	2022-02-16	Cancelled	xu5cda23gn93uqpgsdy60fm1cry87awvnpzheyhj1wiht7oqf88ghb3xo60sjz6qv8wb14koy91dxfwrh9g24rjzci5bj2z63i19fk884109bab9wlj3zp2if1wpy4zof4qnxwmjyd4nwj0qtj63y8vu8bqdnbloq
0c3595db-8476-40ca-8e88-d1c918451b2a	V7BWQ9TPYO2H	James and Sons	Ladakh	2025-01-05	2023-03-21	Cancelled	sis2jubmf
e57b94e5-9bd0-4413-87b8-34d554bc1f68	JF2IT74TY8CE	Flores-Beltran	Arunachal Pradesh	2026-04-09	2024-11-24	Suspended	gngzlqj1yu52ig5szlw5axyxwo7r05tao39rwrmdv93mm0enlathi5lx33hgs47aare9n0qse0fiu1ntv3vb0a68z0u6fbys0tq0rm23cav3bkpvm93a9dadi1cg7ohdx5djplusntoyv9dw47ny3tskmmxd1r
2a03fc74-de04-43ae-b148-78bfedf9670c	FLCR9OAMCVLN	Ponce-Carter	Ladakh	2022-03-07	2025-07-03	Cancelled	aber9fbahh78amosfje0q5z0gnhmkx8k3qymwt5y
a37dd03b-56b8-4b06-8879-55ed2d4e201a	S9EVDSHA85J1	Clay Inc	Nagaland	2023-01-16	2024-12-19	Active	8v9sz22p8e66tq3g8o70s0ai6n1g84nr6ez8ykee9wmwkjglkwtp4id6gyicajsurwyx7a26y9d
facae537-fc5f-4740-97f9-3ff4e8b40171	SS48ZWFWGD19	Jones Group	Chandigarh	2024-02-13	2024-02-23	Active	r8zrzjmype6fxnzirlwv5k3n3k4c2d8zqit2n5a0pf0f5wdyze1k1hfmvh9wiol00yg7ms38fnowa7nihpdeo7oq4fi4919yyhoy08
fe3e5936-a500-466c-af5d-590d79f7bcdd	5A81PXZPETTF	Richards, Mendoza and Ellis	Arunachal Pradesh	2024-02-12	2025-05-08	Active	qo5pklf6ixzi73zkcrolltuq65rl5yqyt0f2jyzunpmvi967mdk0hkx1121khcn8fj6jb6z7y9sfuyvuiko3v8uasc5qt2o57st12h7m752wa1m7703qgyasgx53riy3jc9yg7hna0rr2y491e3grpzsh8o0l4xnytjkstkbhq7n4r
13bfb234-6d8a-4edf-89c3-0fa40e50f3a8	PO45WBHEY8NN	Rosario, Mckinney and Escobar	Tripura	2024-08-22	2022-05-03	Cancelled	gefil0opri0am8jh4bva8j06dsn4ynaz8nwv0xjnpzgzkeiur4dx10pk787qfo7ps76au244jxg3h9ylzri36cz1dojruz046shn024wj86bvmw3h30veyucponvlic
0c311295-9a49-43de-aec1-6283c4a32dd3	R63QVUNC467Q	Flores, Tate and Ortega	Mizoram	2022-01-26	2026-07-24	Expired	xtbvfsrwvitgwc8ghoqis8vlbk6s6vj38m1h8qhi2c97gg74t9fqq
fccc3c84-b93a-4ebb-bde6-26d7156a0bce	TWFDRPEJKH8U	Hamilton-Cruz	Tripura	2024-07-20	2025-07-12	Active	95lxg7fkvxb3wmz10xwedhl13u0vdqdtu8zbd
1049f6cb-f54b-4282-9829-ca178ea1062f	6Y9DTVCVFM05	Hines PLC	Kerala	2024-11-01	2025-08-07	Expired	rz1z4x6h78ass1s
31cf7324-1b03-487f-adc7-cb49d250b1a4	M6K4AV0ZP5XI	Holland, Smith and Adams	Punjab	2021-10-30	2023-06-11	Expired	caghamo3go8adtyk1psejib9nnpygkbkpcvqqrqrjfwh2gcgjs8cd9caqnafj5u0jr8ejlogc2og12pf2l75eoys8gwq81ibb94le3io233ubvysgrph0t5iqd6eqartdarx3hn73jplkyxtgsqtdkrhrb76j9o72ncfddt5azja1nrm
c82dbfb0-e802-4790-b291-86fc2f4219fb	NNGJHEM7QUAI	Schmidt-Schmitt	Goa	2023-04-25	2024-07-08	Active	9xoamdnk9f1s59ws0x7xg1tnhjyocn3asj833cgmd7z0nwfhpl
01d4e7d6-987b-49bb-8ff8-67a2b81380c3	CHRC8SBUEYWR	Hartman-Cole	Tamil Nadu	2021-11-14	2025-07-01	Expired	g1xm1dr8thar83dh1tixwbf231w2h1nhcepaxpwbufdy0ung1z88ear76wy9kjssc1oiofqccc0cwpxgm1acxz0yvd
add8557d-df02-4e78-b2e1-ad9b068aba51	X8E3HN7O2LFV	Crane-Perez	Manipur	2025-09-30	2023-03-07	Active	c2keqwp7t7e3k6m5hj6mxcn2g2us2m2vb6afq8soo35102efuzf1zid4xwj2elt2o1l76exl8z
5c9cf912-67fe-4004-b72c-f557521d322f	KNOBGLTLE3H0	Reyes-Potts	Himachal Pradesh	2024-11-28	2024-06-17	Cancelled	2ahtq2s904nsmz6qgbvdh974co0oyz32uijv9uy45r057v0y6evfwjl4
1efb2699-0b46-4c86-8f5f-509d76a43ec9	2VFYDZF4IE0A	Carlson-Miller	Bihar	2022-02-01	2023-11-17	Suspended	pufcehqz5zpjgw5dnamayf0cw5y8lm1sow92ipn5931qy5jda8p073m2q5wyinlh
21d841c9-77fb-4cf5-9837-c8d6d2e12251	MH19DK7NQ22Q	Payne, Kirk and Williams	Rajasthan	2024-01-30	2023-12-27	Cancelled	oz6wui2o75sw0nkn2h1b6jz175hy6xovrnlpw5ebrk3hfoiegp1n4zkoijtwofxe2q4z1lgvif58md00j
49a4c724-4471-4c31-a2da-514399f258db	EEBSIXGFKERT	Tate-Strickland	Tamil Nadu	2025-07-04	2023-10-18	Expired	7ut5w08tzf06vi
822a9251-59c2-4a61-b447-89369d86f7fd	XU4DO98YL7FU	Kline LLC	Arunachal Pradesh	2026-06-25	2026-07-31	Expired	zdsdcjvw8otxzzt9oui45mq93c9uyby0dzux4d89yum6nhesyvjmt74ygnjo82i3ks8q9nss7rg3rzgz75vgyvkacp5g8svi1fxwne9ehhi4hal3zoo5mggpphc86ei1pa6qn3f3lf4v0046tepu
883122bc-c804-4afc-bb13-0babb2030bb5	LIJBLOH9K6BD	Jones Group	Gujarat	2025-03-15	2024-02-03	Active	6cdsl5ft93astyqhc4l1se32uevlnx1w8ghqnel1tf7ohk7nuw5z8dcw8fbzc4e7cslehv
4777a84b-f222-4c71-be8c-e8994ef4a8a8	SZEBP7UG9PMY	Pham-Lewis	Chandigarh	2024-08-11	2025-04-22	Cancelled	esv0lfatx5xqcncq6cq9hffsnxsuvc8of6mkcy4
26b9151e-21e9-407a-a542-f69ccc0593af	H5XVXKY61IZI	Murphy and Sons	Lakshadweep	2024-06-07	2021-10-29	Suspended	xil3vqxzfbp9s9445qlfhz6aphc
4d8294df-26ac-44eb-b5d3-d557a381b4a4	GMFT7SUHKJG2	Guzman and Sons	Andaman and Nicobar Islands	2021-09-23	2023-05-24	Expired	dil936aivy51n48kg4hnjg11iffcn19uug0nuzs71dsb2mqi1nx5szi7vgfh8a7sl7l1h1yg4syll89s7hbpmqaljfyrb08m6f47csjuomxqyj1hw2p0
ac47d55c-0969-4b7e-9f2a-d473e73df28f	RFSJD37571B0	Fuentes PLC	Arunachal Pradesh	2026-01-17	2022-08-28	Suspended	npa0eknbnco5
f32262be-ff85-4d31-aabc-36809e08fe2f	4U8AFK6TB0Y0	Osborne Group	Karnataka	2025-09-03	2023-09-23	Expired	1z4betm71hcb0uedvbc4ts22xxh3hr87gtv7srndhg0t
948f34a2-1897-4445-a576-42a696f99fbf	J2P3GN1CQNNB	Delgado, Young and Williams	Nagaland	2025-01-09	2022-01-07	Active	621plnahudt7jiq5qnv4cotijfh9eljhqofm54u0wuvq8m0ovamjf9k27b847jf5flbavxhon8fs5m5b9g09vghw4mzwxahhodnp
02e62cbe-bf87-4c3e-9bc7-576569b7a3d8	E7VNM3S7Y50O	White, Best and Green	Delhi	2022-06-01	2026-02-17	Active	my744b85vta8i
b693bcd3-0c4c-436d-a353-369f1fb7ee61	GFP1ECP1HANI	Gray-Price	Jharkhand	2026-05-27	2022-10-28	Active	xrsdwx6msiku2ode02k5b68p3zevbt0uo7w4n0vbj9r458kznxoo8gvh7ov5a2bkg89jv1dijsmyzaskth7ad4d8ocrweqb63mjeiqq9dl1v70y
01bb35f8-ce74-4a8c-b492-0d3761c69ef4	FTKLS0JKD450	Parker Ltd	Ladakh	2024-01-15	2023-12-09	Suspended	dzswxigx3
d1247e63-8108-4a97-a86c-3f45b3f5641f	BV3J5RKEIC2X	Miller LLC	Nagaland	2022-08-30	2025-05-29	Suspended	kd0yke63eg0fld6stkhhvvxo0vs8l4tte6xzsygr92aehjg0lyd
ef3db957-1544-44eb-951e-159472dea10a	2UQGJK7CQ9ZD	Mays, Harrison and Freeman	Tripura	2026-01-05	2024-06-01	Expired	97hetvmn23kjjkngb57f5vi1v19kiotlcu7ac8rqm1uk33eok1hlhe3485nuqn5ez3nfaho046zxcp0nhb
51d8775a-e3fe-420b-ae0b-5f700455960e	QGB3Y7B4W3C1	Hunter Inc	Maharashtra	2022-03-29	2025-09-19	Expired	g3adw80mdixk84620hx55udcvbjqijjoahkkt5ce3qrvpxkrcnbx2riizjd4t1oy193mrab5h106971fyf1fu9cgvj7h1hqr3toprujy41ntyjdom8ieqgbyqq7itj61iny2efrwksycx4pq8mbbo29mjon467n0csafle1sojbf0yx
9f6654e9-3f16-41b1-884d-362ee030f0f9	SZBGN4LQUI9T	Pope-Ryan	Himachal Pradesh	2023-08-18	2026-06-27	Cancelled	y8v5kkmjqbkt28ayjaw797kc3tmlsd8zj6ksb2iwmunr0caew7cd34f9yj2ozc4w7ftwokw1nc5chzx7dn9ja4bvggom8h5e
f5f91cbd-89a9-4071-bee1-3a03a08ad05a	2SEVI33CN3AK	Vaughn, Smith and Ryan	Sikkim	2023-03-13	2022-10-28	Suspended	fvmzagfjk695ncm5iwnphuamfoutcxan57tigvvv59
9d360380-f211-4bf6-813d-555f3e7c3c74	8ACW5U43MRY3	Diaz, Patterson and White	Ladakh	2023-11-11	2022-06-26	Cancelled	hqpnog18u05u76qnuv5i4so6bcbnokkja130c40nixrej8s8eg1akdkomff70p6s886gm8om02bujrh6673gl1r1trl9b3ga998t7ph91ufudsqy66aoubhl6wpm16yycsk3woi5jnwo1bhtc9l1ge4vjfb
7424aa48-d0ce-42f6-b7d1-01e606450190	I9E7SOEWZIP2	Hurley-Stevens	Dadra and Nagar Haveli and Daman and Diu	2024-07-16	2022-05-07	Cancelled	v4w3xb2ax6nf01
10884e00-6948-4b91-b15b-b26762128d90	DBONPNJQ57UY	Parker, Miles and Miller	Maharashtra	2023-03-01	2022-10-20	Suspended	s0elf6elbbuz2rexgyfa9fipovoqskitl58rtbpsb6xc9sci4k1bswkghkzdby52fi0ynxvt7pitpmavufb93qgbgqx2z3rdx77875q5wayppygteboppcgt1wbovi1tyd4u3ptizglxs
c1c5e572-9945-4f1a-bd35-05b4607d3ceb	9T897N13ABX3	Bauer Ltd	Himachal Pradesh	2021-09-03	2025-09-25	Suspended	y34oe6qvqrlz2albih1yzhg2csevqibpz9dje2mqem4hk60486cl7xi7mdfq38l5dsb3plo6j
99b626f8-081b-48d0-983e-0c1e055532a3	YZJ1QPPYDOIK	Dorsey PLC	Puducherry	2023-02-21	2025-08-21	Cancelled	7o1r0mf0bnrd9t5f7klbw6kapxf4hx0wi0rbwjpfb5k1dz6b7teldeybg980ybuxlkkv5rif4yushzu376bpy478tl1bxdbrs6gxwgoi4lejcejdwyxcxdf271myz69dq2muln5uut9lwlb280tm5498qkpi67e3lw7fdqcomol6
efa5401e-fb12-46fc-8056-c45b5ac5407d	OLLO2N8OZVD9	Perry-Huffman	Ladakh	2024-09-21	2025-04-06	Cancelled	1km3isvdzmf8yk81sfb45vn2n6yx8jenm14v4gtoqei5hwfultumzygxf0qa8fzbwasmkzvwtw7l76mr5j057z8xc
72ffdc2a-3fe4-4f7d-9534-53efa5ba4cb7	F8QVMKBQDYVL	Bradshaw and Sons	Odisha	2022-12-26	2024-02-27	Active	tqz46xg7qatmi4wuvzuaqpmz4oms
e0ac7a55-2594-40fd-8a6c-d967e80ca844	YS12QMBPXWQX	Gonzalez-Flynn	Tamil Nadu	2023-12-19	2025-02-13	Cancelled	6mxkyciwepqdiphsf5mxmkbz3i2w0p1pv3arp0cpzd67ubdwedg60iaxe9ho7q4q1uo77kvwuo3vl8bwa8c9jp9zbwdedl3isf7v3el60i5is266hbxot3vh01q5fdfucmw9lys5qvvv6jltnj6jvgo2z52crzxxj19ypu9z9twt
0aeac711-e69e-44a3-a52a-449b5b41bed5	5LCXZ6YP0YWC	Hernandez LLC	Bihar	2024-03-29	2023-12-13	Expired	j26yjns62mjzakbabjuq389sfshzc3d6bvj5b9m39ievo8mi1me5mv6vzc57zp0zbftyn3x5zmkdk45rt70o2kog0oj804dgau9ygdflnxiulkyx34e0nm2ua0uqw44deui4su0yxe06lesr1necu391mvfj8j93ibgm9bwejugcxspnkpee4y4
c005a413-64fd-4840-993a-5a574a8ac399	3IKFBQRLE5LT	Price, Watson and Riley	Jharkhand	2023-09-16	2025-11-03	Cancelled	acz8x2dho49d8r6ao6vikwsolqc2bfyiu0kpdjjrlkskhmr5jgna0eccab2q
48509672-a2cd-4914-b668-c6229ad63d74	OX6V2YBYIOCC	Jackson, Wright and Mclean	Sikkim	2026-04-10	2024-07-05	Suspended	gy21sti6xrg29dem9o0xpg77st8gq6pbj0hijlgjbeezxpqfmjd6jplbl85joplikrro8pwxph7u81r7fakky1cpk6yfk0urb4bw4003zfj8yvmdq34uj6pb8u9pufdt3rb3j2m11v7eqsbfdb03u8rk6tjnartb1ue
ce3e1007-8fec-443c-b91a-e8f81768edb6	4THBKU81N9PC	Walker, Price and Hays	Odisha	2024-07-23	2023-09-20	Cancelled	rvu4wnd7xshotuws32madiu3654yw3ya8nmnp0yuu3lrb90kh7fdsh2n2dyo4bcrihx8g0hd2q6rbn4mn6n5n1vbodfn7mgmj79hzedjhbr9baopl99ya3dzpcink4xjg6k0x1hqox5qbxjctc1z5o4i7dhpjkivjpb1u8rvq1pfvqk2vrb2w808r5pka61addfc0po
daa69c64-4168-4f30-9004-a582631bdb63	9BBBKFQA7KH0	Fernandez Ltd	Lakshadweep	2024-09-21	2026-05-22	Suspended	o6fwjhbw7vd7hnu4a15mu14s9sumw1czktd0
5c218c35-f0b0-43f3-982f-34ee38246fb2	NM1VRTOVCS8D	Schmidt-Mcneil	West Bengal	2025-03-08	2023-12-21	Expired	tazx8dxqs7ibgi9vafk28r2p6q2tgwbj9ulv62s951j8msykui8im7cuvqvm7gd81lt2jzx1q13aj91mg1t0w9qk9ng53p0yxb56ply02ryw5peqg32bk2td37srv2thsthvidab4
f90e1450-744b-4b23-84d9-ccd8625ef446	5E87FH1C1KRK	Johnson-Barnes	Manipur	2025-10-24	2023-03-03	Expired	e4out0dx1r12dl6nfkjndt2ajxqc5suk3lg8w6b0ks08s2jg2330kzh2t3df5150
377148f1-227c-4f46-af18-a61ceb85150d	DVXBU63CN725	Ramos-Oconnor	Uttar Pradesh	2022-12-20	2023-01-13	Expired	snybci0iq2a1tcdl7pingdssb5c7tjudrd8dkgcbqgc3gcaaea8vqit51bhjkg34ylrvw8yxllwrpnrug7spdqjpqopsamlxfgl0i8ldhhhkv61dkgrjzpv
7bde47a4-21d4-47fb-98bc-84fd86fbca92	NM0N6WYO7BK0	Salinas-Brown	Manipur	2023-07-13	2023-01-02	Active	fzsy1gez33sew83bdmav4ly2n4yh7a1k0u0374a4
545022af-49a5-4c46-b2c9-d579f038d6cc	X5IYY3Q37HW0	Lee-Simmons	Ladakh	2023-01-01	2025-06-16	Active	feszwtnfc7lgwcdym6i86693rvq8v0b9bvdtl3qot88pdz3lfktihpcpe26je7acn96la
3ff7bf72-8238-4435-8c59-ba05b3250705	VSPXN1FOMUM9	Wells, Abbott and Rose	Punjab	2026-03-07	2024-11-14	Cancelled	1x29qob8gef80k2nr95f2tv9rgtnebror3rd479to6z672oddpfybiw56bbl6swgkezq1tpxi0nfihtdoc589p7e0mk
f7e2785f-4294-4049-8ec7-1079a8783ded	VD0ZKZ6Y8OEM	Montgomery, Johnson and Chase	Meghalaya	2024-04-12	2021-11-01	Cancelled	uida2eoqq29nmlszjfde0d87mpjko9iz31db3uf67sfht33v8nktqv04hehpkj7jtuet80jk638x3whtu1b24ah7my8bmgb3xag8rs99rp
362efc06-22ee-42b2-b42c-ed2a42757bc4	1USQ73RFHJHO	Walker, Stone and Cobb	Karnataka	2024-01-24	2023-12-14	Suspended	vyxwbtfo1ikd4g4btboay3j0gt3af97wuhhvqoyrml9kz
d5b9b04d-4d25-4c78-b702-78df3b13cbad	J3D72NF3CN1D	Baker-Page	Mizoram	2022-11-04	2023-12-24	Active	9xn83g9ko02aps7j6jdqnix0ha2wguh29innqspp23j9kjl0x6l3xlcc14ho7fszg5ch8rvr8rdzkygvq3oqfd4er2kvrfpzm77qsnxfe74pd0io92f9ho
f357895b-7675-49cc-8d69-ed67ff5809cd	OBM16WQRYXRQ	Wood, Ray and Beard	Uttar Pradesh	2023-09-06	2025-02-21	Active	f8u6qk34rjrw6bhq34ruzohcuqskdq7d865hkbrh2adktq0aqqqweqjbo15xm2t90a7yjltkd4b9e80uv84ltjde641wndusuenjv1mh5e6rlkyd8s9uz6p4pzqqxomibj9r0cv9u9uiyqglbtqxqcsdfr9jwp6wibrudla
c1d09758-be59-420e-ad27-2ddea3bfabaf	OLLH3P1A2A39	Parker, George and Patterson	Haryana	2025-12-17	2022-03-05	Expired	4hos0lev9rh9zcwgbke0buzo012cb41n589w7t0d1xih92t7vic2kijumw0nctfmst
f89388ee-265e-4860-9c37-7aa44d2e5e29	R64HEDGHSYQR	Garcia-Moore	Haryana	2026-06-16	2025-04-06	Expired	1qee6m32ani9fl275a0kyszjnj56rdysxh5n3gcjz1k3fwusb9x1xath5hr1lfkc5w0surkbx06ciydp5v9oht6ktzj51xk2u4zirq1ierijt3igvfg3twd1epmou
d0b286d0-4ed0-4986-ba29-ecbda91420cc	EX5UF7GI4DDQ	King LLC	Meghalaya	2022-06-24	2023-08-19	Expired	r6jvkr0e8nn15eb4lcazc49rg4vjmaxk36gwg9h8kgyggc4rtgbd061crwt5yy17zqleefikqx2fwcmr64evpbrky9mlzs3zex91u61rspoh9uoilbvc025m703dkow7g
f411440b-5fc3-4cc2-bf51-3316963e38ee	FQN6Y0S08CFK	Williams-Jones	Rajasthan	2022-07-20	2025-08-25	Expired	i1pbjoxa1grd0f7664ildixjsx9x0g2x49h00868bw4cxp0bcvdkkpu6i7che28gi1g0eb53otm52646sdnoeploltv716exxqd8r8uhvkph0
400c19a1-342f-46d4-8afd-af6b2e15a563	LXN2KEFWP81Z	Burton PLC	Nagaland	2024-01-18	2026-06-15	Suspended	n7gjmgm88y3km6dcyphqz1av18mvijq3qbd3abhe6pp03nq7m8290zobuourljninrr9vafffsns0z14ge13h7vd9n349i1os4uvq
fc23ad2e-ee02-4f11-9cd8-87e91aaae279	A0W2L1ZUUQMQ	Ramirez-Melton	Maharashtra	2026-03-14	2024-11-01	Expired	vraud12dqd50
794dfc06-39af-4b70-9476-3b340e70169b	PWTF94KVPBRY	Parker-Trevino	Mizoram	2024-07-17	2024-07-07	Suspended	0cysn9mmgyz94mt10si6xr2uqj115uy51c0q5jzocd801p0e4k3cde4lojg35q1akqmyofs8g36iqdmp3al9k4oo0
e67e55fc-bc91-40c4-b92b-b30ec5c3810c	X4S2VR9DQJVC	Bennett and Sons	Nagaland	2022-08-19	2021-11-25	Active	aq13m72cx65es95h738eekre617cgl3h8dmgz6j17dw1b92iu346kl47j52wnohe0hm0yaip85doo4xcdjn8zaw9335kpej5muya290npd2d1evc966jh6fol0tqvwzrlylm9zvdiutb8dv3dhyj95qkef44c4vmm1weh15vueapbcexo4aum10d43
8994c745-41e3-4a30-a85e-a13b644d7193	NP23WNRIVMPV	Fisher-Hernandez	Rajasthan	2026-01-18	2022-09-24	Cancelled	of2zfzojgqh4fjycfnl7xuj7khd2n5tckjwa7686nlh0c4621u854xiu1k3l09ncfy6t6tbt73jn4
939461ad-3db9-4595-a67f-e29c05ce083c	APMEFNWVPEIV	Smith and Sons	Himachal Pradesh	2021-10-15	2023-07-20	Suspended	qqsj8w6yn42hw9rhqtbzbkum012ks1mg4wvfzxcn9e2o5nlqy1bz5m7lcnfpy64h9cyg7s1bvr1z2z3ikvon0a40gzsm8tgh0xi5e1puzm39qubjlwfuss8
f4cb77ae-7c07-4226-b05a-c738119063c8	A5ED79GNHE7D	Bautista-Thompson	Tripura	2022-06-02	2024-02-10	Cancelled	kriyi3grr2unym23df1pajqm14mdh7178emooz6cwhogd3pbnml9zx22ib9v74twqfrumu38w0x3hqz6miavnunmd9zg5mxi04kbh430lhgdcrmvif5w0bszu4x75e0zk
4808581a-a4ee-4bb2-bda8-610fd8160a65	22VTPZK7WJCG	Russo LLC	Rajasthan	2022-06-06	2024-01-17	Cancelled	pxu91aayosf8qafj
5dbd9cc5-8a4e-4f44-91ce-810438ce6784	1T8GIFAY82T5	Bell-Osborne	West Bengal	2025-12-15	2024-02-09	Suspended	ztv3rngszymjdzr93jyuvyj1mbh0xjwy8fp1pocteaxp0wcwmnkgk34urgtryxpn7wx
a816a680-c89c-4b31-b8d8-1721f11f8e6e	DBP0XAKOX8TL	Wade-Johnson	Nagaland	2026-01-31	2023-10-08	Expired	tkw4hw0fuiozegwhm3segc3n2rt1f1276ad4gwje8hxrelcf921mv8cz3tx5osnke86tb70agpiybdnkz6di2iwaekdmuhupto6hnbl8qqwdhd9h
89780145-d33b-4cb5-b3ab-b8fd38f7811a	KO7K27IXH9H7	Lewis-Smith	Delhi	2023-01-15	2026-03-31	Cancelled	x2dgr5fhg3v4u3c638v7wvh
752c318b-b270-467f-9322-8af4095537c7	P7Z322VVAIYF	Dean Group	Madhya Pradesh	2022-04-16	2022-11-02	Active	gugijm4rx4v5lcdbpjzzj3hd2iidb1kx5ml1rqt1relqchz7s94rfv8v5j7h75vjdahrs99isivw
0d8c934c-22bc-4a7f-abf0-12c39bc73e2e	DEWNRNALNW2M	Kelley Ltd	Andhra Pradesh	2024-09-02	2024-08-15	Active	0rdftlsw4e14npa8j82vn8sjhypijrsj3xy4fnb1fjnfifoqu7v1r5zejnm48sgbexz8baa0hd22uxeccj3hmz98keygaakwg2x8xign4l5n3xxjbgj2yw4gcqrejj21nfs55fi5zpssnh3m4uwen7pcfzi7pkwh5bfj514mvwzyqpqhy4gii
079f1d89-cfe0-42b9-a94f-5d113fd56e58	IJIZU2F59WYI	Lane Ltd	Lakshadweep	2023-06-29	2022-02-01	Active	5s9sc1c0oo10qs6pkiv5b63nr5oekt9098oz9wuhh5beo
61e8d03a-f10a-4ad5-b604-c4a660804bc0	YIKI7XO6SUH5	Jackson LLC	Assam	2022-06-03	2022-10-17	Expired	lozkhdt3avgim
3aa77509-2000-492d-8223-a4cf2f4f0656	8K5V4HDQZJFY	Johns-Mcintosh	Kerala	2022-09-01	2022-04-29	Expired	aqajp4qy2qqiltoj823qxz6txpvpsaff6l3vdp6lz9whl2pixtgejqe9xc6vdcb4
7463fe81-58a3-43ba-bc85-0e90eb5aa1f2	V99KD270UF30	Liu-Chaney	Chandigarh	2024-08-20	2025-01-04	Active	yvdemeelq2bsj87vywqnre
c44da505-b1b9-417d-8e54-7553e7c0b53c	A9U1UWMIL78Z	Leonard-Jackson	Chhattisgarh	2026-01-30	2023-11-16	Active	fnir0xhtctb84jw
e6f3b91e-6b15-465b-adcf-243fcac093c5	QI74QEZE0H5C	Johnson, Rodgers and Cook	Telangana	2022-12-02	2025-04-28	Suspended	phhv5fobg7sunsr
d5113dc3-f282-49b5-bf7d-1d7133369026	XSHSMPRHUTH8	Mosley LLC	West Bengal	2025-05-02	2022-04-18	Expired	r2uzzwm1hbe6285kkhd9m03ca8kip99wjekbwih441h5ocwe7lsjbhdmxlj5wm8axo76bkbazinekz8jmo4y4tt762pdp481d1
f45682dc-44f9-48c5-ba17-e6b889abbcaf	TAY5PIQTEWLW	Flores PLC	West Bengal	2026-02-20	2022-09-17	Suspended	rftj8agnf1zl0catldyfh5g4yrmepitufhh4zsrdi6rgbn3fjmx3vot1v523gdr0gv2a3g9m6g39r8ovfyh906oermivsqzihum54b18aksjc96hkpufoh9270i2axbeljvfadpjs77pe7kuhj1swk45ja6kbf6vxzv5tdcs2xpstifs3jwvev9we9qc1bdc
8cfde5ce-d052-406d-a61f-f9da7278a98a	HX8ZIT1X76C9	Mathis-Stuart	Puducherry	2026-03-14	2023-02-22	Expired	ihqpqkrl09l1dluj0v00i7dcx5j55oqjh8ocltsytcjjha5kwg7ckbaiylgp85npxydmxi8xekosz94aoj
a0d37a0f-0e63-4f92-81f9-793bd3c6fc99	MMLSE4S2SSP0	Terry PLC	Gujarat	2023-11-08	2026-07-12	Active	47ed2xzt2hli94bgadxmyqxfgvsmvood4kh347hgj3nkqnne5a948wbb7j4d8vkmx91nv55l5qpvwqtvhrkefp766g4gvwcazzsn0oc9bjfc1zswdt
75516d54-f4b6-4209-968f-c6137426d21b	QYGYS5EJ3Y80	Simmons-Collins	Goa	2022-11-21	2021-09-09	Expired	u13sromnewga6yh5exrfhto05jsa1g1y50t03hakxgbnx23ewp3wolta13bslyvz0wlc5jk7b5juo1luj5se40bfcrf0d23axn5oeu9b1qlhyvtr6s611u
7d197d12-16b3-4c7c-9656-8de5b80b4186	ITNN4LL65XPA	Taylor, Ramirez and Branch	Mizoram	2022-02-15	2022-06-13	Expired	minyglsozrhlha5dnqwtjhh8sbn0381gl8agprxazak8ouquhk7ofi1n7ubrsg8pfbiaby306aeike7xn0hzh8mqvgbrqupdnxhzhc4keagf78qn2s6lbfoxi16ejpnbrng1c5d9eaphq8v
c9167b5b-8b29-4234-83b8-8a3d2116f17e	A1HRBAWJC87W	Hoover-Morris	Bihar	2023-09-25	2024-07-15	Suspended	r3tojmqielv1fmzcl
5f3dc802-05f7-4942-9f39-013e83906b38	OO1D431UJ15V	Turner-Hanson	Meghalaya	2022-09-04	2024-07-06	Cancelled	ct38kgwd5sox35r45c3e9xsnp9ryx2p8na1mtlanh9bqdkzm20mil7smuokrswwxfvc2j2f9p4vxm8ayapcvcxe9lhn6jxfn9dsinyu49twvfitwbh9dts7oao14q3zo925kt9521dq73gvl5xnf78ga1
b3e8c4ce-19d9-4024-9965-c720a66ed562	GEWJK30VJDPA	Bentley, Vincent and Koch	West Bengal	2024-08-22	2022-08-01	Active	jnvd75h1g55ajybwgill059pzq7smk2iix70bnc5oujj322sjr78rt9my709g5af9kg3mti025khtmv0fqhmz3ui7zrd389duw5b6nx4cm6z053q0luw4basr2w85vbiy55j9gmyp9x500zd5t82yub72dsvvwowhpi938yeti5abzksezmfzqu9axuqu8my2dr0e
6efa1d86-0249-4395-bb4c-680742eefb18	YDY85BRGH4AJ	Williams-Pearson	Tamil Nadu	2025-02-28	2023-08-11	Expired	bl4j2o82995m1j5bf702suqrwgt28j8tp2i4znxfclbh91029s5zz0omy6uj9oepfs53tzbllw4dhilfhvdfkoowufey2k5zp272hc3pyi75qixod9s1b8yftdtfa2ywerzqbhaija0k6g2bhaj9n1r
1eb14bb8-f861-4c99-8267-dcc1df1c6f16	YJWYC0VPMXBO	Ray PLC	Nagaland	2023-10-13	2026-04-03	Active	480e9by3ibadtr3pbtmjnhkc2q7gcveysiseu
f01f13bc-590a-4ebb-b940-97fcb7bd2b35	UJJT8PEHH61O	Reed-Thompson	Uttar Pradesh	2022-02-03	2025-07-04	Active	3bvfefnvz6njnxw07wky90s5sjq6ykg7x9046v23xxrddu6o13qazfyl2xdpg6la7xg6q0azct4wm2zpv4g0klj4z0c0d0fslydr7lsbsfbjztdhnvg3amyp3ud80qiz3iq4ce2lwlxewfmiezh82lzhc7al50to25gvhtp3m4y4pyrvfaq7pezogdokof
0be0a5f6-da92-42fc-8912-d60209d0ea16	G49X7W7RRILD	Craig-Smith	Uttar Pradesh	2026-01-31	2023-04-13	Suspended	v3ztjvdtax7tw0fzbr4nqxmyiz20qv8h9e0s3o3nvdgyst5watcr4hg5gajn0vxal4zbe8bnqxnb7qcph7mwxbe0zd5gl2sbr1qdr79wx3qrbsurq9gmkwhm64breawuh
77aa7d2b-359f-4760-987a-c3610d89de4d	C63S36VT86QJ	Hudson Group	Gujarat	2025-01-30	2024-12-05	Expired	g9ffg9w0g8904tiyv9f4usrik4ikg473cv9gt3c0krl0ieyiaj4ffvrx7cjc85yjo4p3jj5ggkebnwrr8fji8n0yhwmbpgh2gwh8wpaojiv2zj8ng7z46zypxcmjcz7uihmqzg8p9p28pvk3xiq
0b565195-14ca-43a3-a858-2c55604e4564	OI05NR2TIIWC	Parker, Cox and Huynh	Andaman and Nicobar Islands	2023-05-08	2022-10-08	Expired	n0ybjhab65vae55v5pmuwi4i1nescleisgekba0kd0yndk6jubmc2c7mgik349fzt9i1ejh2k4jyxnurg9cuyme5aw7tszvelahi5smd3tkylw8yxjjv5hsn09cpewkbb1jj0im65ayl8sqffasato8iej0qti7xt7zwd885p1x2ofytx0c5tt4tihrc
a8f4ee19-a2fe-4cb3-b911-c971f84524b7	JKG10VMN7S3C	Cannon-Jackson	Kerala	2026-02-08	2025-02-20	Suspended	9nxout6u06g24fl3nsr9udw2cxmdkst42lb6yldr5sr1itktq5xafjian09junsu28gu4ttd1e6asei1l6tsmeoyryp8epw0vx6n5bolynf91in8odv5ov8etdhqs4du79czhemt0gqtkpvfmpsqjtz4nxjy5bhk14pdwbl8hl62ej7iv3ui8w2be8rf8t6kcv76qx0v
f910294e-14fa-4aa8-842c-8f50d7069885	PP6UUQWAEPND	Price-Long	Haryana	2023-01-27	2024-05-16	Expired	k8f78az2j9jhwoplcxb9oqg1w4gkzdm26h
39e94048-83cd-4769-b88c-f32d7707cb1d	DKJOL1WRC86P	Floyd, Salas and Cole	Andhra Pradesh	2022-09-22	2023-09-26	Cancelled	1p4542bh82l
9bd06570-b55f-4a18-beff-66989db08109	T7PMR4IR1ZO4	Yang, Townsend and Ray	Punjab	2024-09-14	2024-09-17	Expired	0oo8okstgghgtt7spype3kyb8vslpedid2ojocne63z8x2jj6imh7dsnvvgo6sqaerljb3hha9pnqiydjjzgex
aa7bd9c8-8da1-4498-bfbe-aec228471a41	Z0EPKUA4KRD3	Baker Group	Gujarat	2025-09-23	2023-06-28	Active	73fjis42ukwh08bt2tkcia8a5zgrutxghnh3tutuzle40zyxsydkwpjl5nt8kw6ol8my65yenrqt68y2mtxd5cnpji7sr3gant4672cn
51855278-03c9-4421-81f8-1e7d0d29b756	YIO7M1K4UO2G	Lewis-Pierce	Goa	2026-04-23	2024-09-02	Cancelled	haa3qegf8xhvlf6hc56syjr5gaj7dezk4d7s4hc3iutx8s23fb66wvusu3spe95iqejsymzpi2epblffu3bd9m59q55obx7fk06g7kf41uy3o2drjnzycbas48addvkih7k73kla8bz8s
b043b71c-8356-48ff-a31b-6992de25438d	ZB7MJ92EVM3T	Kemp Ltd	West Bengal	2022-09-17	2021-10-22	Cancelled	db3osylzt7fu3gmlsndg6gp1r919tnaj7g6ak9ktcrv8zvf2ebuzqcjvi4uouoqi466lozc1owyq88
f155e2bb-9ba2-4e27-92ea-b3c197e3f0e2	AQC8O8QCJCIM	Rodgers-Riddle	Goa	2023-02-27	2024-12-09	Active	ado8linj79e36tnyptp689jvi14c8hpobkjv8w3d06oye9gzm91m451xlj8qtn53ox1y1qfpefypi1zbc5wjbqzrhttayympxq3
0f314b17-a8f5-4973-8582-8da3bac311c0	MJ5ZHE4F73Y9	Booker, Obrien and Nelson	Uttar Pradesh	2023-05-12	2024-03-17	Cancelled	txvcyk8f1edob3xszd74e9af1rgclvodi1wr9rqxtjtjo0cubnq6qhixxbfowf9wx7w6fcxl08ge9wt54wnxm7r6alg83orfa861es4rdkmw87iam103z7388vsyzdchw77rzngekcdgf65w3f5djr6tobmzphlxjbtrvhjfweqte4s03cuhrx9j30h
33dd0ef0-9380-4c81-8f5a-f55e25dcdecb	O355OT6AD9N3	Mccarthy LLC	Dadra and Nagar Haveli and Daman and Diu	2023-01-01	2022-05-26	Cancelled	ffjknj4er09mdasrv0sh5s6xwn739xo9cty9e7dzonyjsodr80spa0bj4yid9gu9rs8l22e1jnh24vqgkoyqku3sc1o2upprxr6yd1pa2h7k8ej08qxpp7ic2oxhx97hqpm0qdpgod65fyxbrz7p17u4z
0b8ac511-dfb4-43dd-b6ac-16d7607f506a	G3W20D15CE71	Bell-Hull	Delhi	2021-11-24	2024-11-15	Expired	ejmdk266vu1c3xuvvh1eij4ddemsf3dspgonikftwnhuj98m0ou1lkc8luvsql0cf9uswg2q8ttud4a5nyhch558mi4w2hfvnjazdo19y0iv0utz0etdyuu3dfyudrq8wv
1d493ec7-345e-483a-9cc9-12309d400192	73Y0OYMHTN3M	Jimenez-Rogers	Andaman and Nicobar Islands	2026-04-24	2023-06-20	Cancelled	pe1mng4p4hxlz40q92k7990w1oaxrogu37i8rcgf99r8q8m9ewwcnh92p2kcu78830eah60hma31fc55qea2s4w5zn8tbksx4rz61i0n7sy658afe9i0ktxbrk7synzoqbqc4qn96f1stbw0idnhim3vkfq6mdadh7g06bnky4yd9
c4a2e65d-27db-42f3-91cd-ae72f9fee1cf	PS6U3EFWU940	Hughes-Thompson	Haryana	2026-04-23	2024-02-29	Suspended	eliy99gi0l6coxv8g98qstd69mt7t5833sglw7vdmtih5jnwpxdrctjwzkl780juh29p8v6mz570b95o8t497xg5hdsxv14xthshx2e6xb0aeehwqqmj8r9u9qb
7927d61c-0bed-4f0e-b34e-8ab0d3a506a9	K2CVUG0O20AK	Williams, Ruiz and Conley	Nagaland	2022-11-28	2022-02-04	Expired	voneru8jwobgn5lh79sod13hyplve8adnehumwqnqrrtc9pw7oemh2hklhnr9qprryaf7d9a5c4ax9unkgrein9jbq1b5brzjyb4attc8f170khbe67e5wasrdfl6ucpqlw1xwsvd5250waqjmphznfxtkc8gv7wyc931gq8n0vrl61be
e3df094c-5fc4-4351-ab6c-fac379e4c4f3	SAH5L0YDF7FH	Martinez, Barber and Ward	Mizoram	2022-08-20	2023-07-13	Active	s76r227ijbd3nd3zehaoc1sybwromio991iqsdee84oewygeevn
03763ff6-3c57-4cf9-9f28-668f0f05a8ac	06P46HDY8GEJ	Martin LLC	Telangana	2021-09-05	2024-02-11	Active	5yjc72hkn3rzseo0igs9oswhvneeev53um3nvlyiskclj8crsuig2b1nrqfj888apiqnr43zhvifbfsvr8yo2bwkdb7j9ek
eca460ec-b79e-4903-94d7-96a44a2f2866	CCW1G94RWDKU	Brown PLC	Goa	2024-10-26	2026-04-15	Expired	t4nvl7ylnjay15q8lunky8ebme5ijac7hzj6krhhnhc5xv8tvefp5sv8d9pg7j5pqlzlzzxx3ypghoxuxbhc4cskjeh87q3i
36045be6-2e36-46ec-85fc-1caaa9a39171	EKFHIJVNHCYR	Li, Smith and Olson	Karnataka	2026-03-26	2022-03-27	Active	hs4r4d1w2d7uhelio026pu27azjgch134galj7pvh3ulvj6yqauv4auaks9en8epc93tzcoy836d9x4ttzfhmwqipf0jzrozbgnrygxirpa5kd1s5hs9dpgkymvz
c0e8008f-c50c-4984-8e27-6f2fd6d5487c	L5U7YMWQTW5Q	Douglas-Macdonald	Kerala	2024-02-25	2024-07-28	Cancelled	q57gigc7uoh8ssgv4v77syl359q5lt5fe8iwz8fo0v2ivbp4vafemaqk1jkipbzyq8pdv1d3ki8nxq9lrlvb849syb2szn8nvsst97lptyg0nrv6u3s9fw9n9cuasietgm99tbt0nqkbxldhr4tgufx5bbj7o0usa419a5svj
6973a2f8-14b6-4047-8204-bf46892c4f77	Z0X5YSH3FAF0	Anderson, Cole and Reynolds	Chandigarh	2023-05-02	2022-02-09	Expired	o1kfnnf2t8n6rf3re41z1mxhkao06n78xo1g078rk5o5hs7vcro78ds2tu61k0zed3a8hc0a0h8gpkbcurvn74wny6dv6j8wxqi95933ay9d7exute4ngqnk4subtxwkvyh92phejkjsa67x8hswclmfrgaqox8lz1w3gfoy4femjr1y4j7b5kxepenb0xz3orpf
fcceb412-77e9-4e02-bc61-ae02c293da02	FTVTWP6LELCG	White Group	Tamil Nadu	2026-03-25	2026-04-25	Cancelled	k40p4vwj3lm6g5ztd2as3lhsh9quk17uw6703556iy6juxnz2r02ufnfp15eu2m4c
204b67ec-1f4e-4e0b-939e-0453143cd259	M9IVSHT8NBQ7	Wilson, Reese and Vasquez	Odisha	2025-10-12	2024-04-12	Cancelled	rwr90y9k7fwa2rqjdr595kjybunes2bbq13z249bepmla4i89rkhmneorttf5mff3g5jqm7tlk048o88ar6q4qfb23eeqmen20cgy2d709zca20vpr8ixsaabcqqdd63cc0353n93ypwlqtbgqoj0ntnydvdzmcztuoticybjt
0e395420-906f-471a-93a1-8bf3fd1302fb	VIW39EF8E01P	Greer Inc	Dadra and Nagar Haveli and Daman and Diu	2025-02-06	2023-06-11	Suspended	mcm4m7qdoxsat3rspxo6mpn607wzaq356l7d22irnot4f05plunw5z870ni9z5n4w9k0cg4d3sbv4w9uo1cbmxptbmj1zc13l27gphkjfe26u2q5ln4fcavnwcmgf1qf27ihgu9d0wwkbs
6d90d669-6589-45fd-ad1e-377f15802b5c	DTQ12TXJP77B	White, Jimenez and Daniel	Maharashtra	2024-04-22	2025-01-11	Cancelled	ft2pdm7mati7b6hvmthuv2y1uzy6qgcbn9mserov8sgmlrcsyyria5qbg5vopwkktw82mborn7y31miaixjqaa29z9wgmvsd4ge5pcwkjou20weri
f0117502-8677-40fb-8e06-431da85f83b6	1VVDJ7YISOJ1	Buchanan, Blake and Cortez	Puducherry	2022-07-29	2025-05-16	Cancelled	ccrrperw8fx4zkpnher0kizti2lh3dmoqze6tip5ccu5240hxt7n7kuyokkmdm9gnw8s13h62sm41lhwkbiczz3clwmyhz4lsk65r5kurdtq6gk05zmsf3b3dfvddhghkn64x2scp3txps6ck0puf1zhmfqxz
243f5171-4a3f-4eb6-8c0c-7469cefe3554	YAVPHD15RTVF	Rodriguez-Tyler	Tripura	2025-05-16	2021-09-08	Expired	yswekp2lcay5zzvgqxnva0obihqt8o30vms7x
58125c73-6ddc-42ee-a42c-eb29e56f2543	KJX33DBLUP4R	Wheeler, Patel and Ball	Dadra and Nagar Haveli and Daman and Diu	2023-01-11	2022-09-09	Suspended	cpk1oms9ahkwv7bvtmr1p8j4cv4f2z94pi9jonxg270c1634jngz7saag9kbnf2w
c0811940-47f8-43ce-854b-e31e322bf43f	WXJUHQI08XHM	Fry Group	Odisha	2024-12-18	2022-10-07	Cancelled	xushjkipij8u9utc6kb5qlsmpkbe4audcepcyy1q1yat3yvd9evpkbvsnknl7447wlpi9ztefxa99begjga8f2tw5gpvlr75ln52y70uxvauop5urzzj6ir9ocq16rt6xxfeigv
b38a233a-428a-4998-8098-2d5c659566eb	FKI0VBB0FABY	Rivera-Miller	Madhya Pradesh	2026-08-05	2022-09-28	Active	k8nj85kx3mqxpmxqbd86mx03us9ty8gjx1or1kfzav0xuzyynwso0iuf40tzppk3gnu4m64lg2q6b5u3pugdx2mzq3
eab086e0-d40c-4dfe-8bc1-058f92970dcb	Z0D5DG6N9VW7	Johnson, Snyder and Smith	Jammu and Kashmir	2023-02-01	2022-09-04	Expired	np2tcmcua9m1uld80eawrhdzkrwxye876aemrc0hfde2e0i068kz987f66mkr2gc5a4zv13y5jfre2n5zgb04cl0y02g7mw7mwr
0b390f0e-b8c1-41ea-8ada-8b6ba51bf2bc	HWX1YAF11R5G	Rice Group	Telangana	2023-12-19	2022-09-25	Expired	iqmzgxsdzhz90z9i3pt8khef1evmwnn6lroj28sj16dlqnyadrbuveukni5jo12jhgeay9avez56nt7qyn1
4ea46368-2b7e-4e3a-b7db-7763cafe311c	TU3E2076QEJO	Leonard-Miller	Uttar Pradesh	2024-02-26	2021-09-25	Cancelled	yf8xj7gcp3bkrrvdtulpsuxtljbvc4plfoimytdce6jp30vsgyb37xlxbw2uf5orgbdtvrtnvbrg61i360gnsy2sw5gwjd7ksjq5s48cuzq1dfgs39eq8ddtoba8q26c
44abbb8e-9bcb-4e53-9b35-7a0f28e472ab	UQ9YLDM7FODT	Townsend-Young	Meghalaya	2023-11-25	2023-02-10	Active	dh9g9673aouwyl3f1bqfbsgfmkok75kdj592rh06w7ksda
f661cef9-8046-42bf-98b5-18e203efbe05	F1IOLZGZTH3H	Joseph, Torres and Santiago	Puducherry	2025-03-31	2022-07-24	Active	0qnc6viidh4jvz6ig95a2p3ju8qntq5r4fr9udjr93aphqxrkk47pqccqz22i64o2gpf0x7geud4o2br1l3eqqz11y4bdcp2ft0mz5c2sw7oi497r7m0htj1gzp5wre8rzi9r3u8yo5yp6eutmk68m954db3
835c6f60-34e1-43f0-be8d-38a75c664b16	F741Y5DY1FPA	Maxwell Inc	Ladakh	2022-09-15	2025-01-29	Cancelled	kcqylobsh36dweaspkjtjk6te3l330489ydg9uqwbd21j8jkn2a32o2kf6p0r8yizwvivkxlsy
41dd5d27-dd81-424f-9fb2-8f80540c2bb6	N1TYUTWJR56S	Dunn LLC	Goa	2023-07-23	2026-07-18	Active	ahs9w5533hfhth0a43gkaospjnetijaw6xy2gtqvxjvuigqe05bxyoj7p214l2lyi1fjyjpg9enpmbbjvq4ze1p6m9ycck4omje3g7dk5s6mwz7si0fnxpmnfnqiaz3dy7eaotvtimiqqa2ncmcdje50yo8oe6z2zpjorwuf271afkodkger8m78
6e45c82c-c775-4234-a673-d34a85a1f08c	5T2H5I63A8NA	Baker, Le and Johnson	Odisha	2026-08-24	2024-08-13	Active	e9895o9047sks6l1s6jn7cf0krt9dg3jd36eo423xh6xm2jw67aq4l0nltgdtagl94cpiiph0gezu5mucoee45au2zs1vunl3h23uhlbzcrri43zftwxr4uezscdywpmvoonnpj8n1x3tcj2f8957rtpfcv22kztlo
525a6dc7-8aa2-4ce9-b46b-3030b9a8dfc3	LEEYI6YMA67X	Huang-Garrett	Arunachal Pradesh	2023-08-20	2025-03-17	Cancelled	dqo57add1l847a772rawlvzbvwb80rnrvcn8222ybn939rg7o8wb59223b2r5gmp471diigxjhk1snce57mz729mh9e1xllkw875u6v7xwzev6bajsjyrn8zyw3iccjut5a06vps6ltffkfd3dhket5fwz0kok9u
c76f7a12-5490-44d5-8077-e1cc94ff3650	DHME350V0R11	Lewis-Bradley	Tripura	2024-08-07	2022-07-24	Cancelled	vk1nd3uw0eiqr0qyk3fx89ibzv8knoz56shfjnnuigf3aq5dxg52vxz9n4nenbf07iqkfw56zo7pu7n6pnjl9rb79axq4mznv8k92ij8jvmdfj2njv1ub3vl6avmdly91oh5m243jktleph9j7b2lgkjsv7o84hrmqgd3sv95cc90g4v23q1tmub2
7fe8ebf2-6faa-46e4-8c37-0f287432c07e	P85D5HAUBPSI	Moore, Reed and Hull	Kerala	2023-03-15	2023-11-24	Suspended	sjbx60z7d8gkq26tb0tkrwzeq71rh3r2ara1d8ztykg6g2vlcdv5ocktu5lvdmclvmuvat7k298qm5zplo1w08h5m9y00pkv4dnogkd6gymap3vgx2vx6jbaxs6b5xb29tadx5t15ak6lbql
08441862-25b0-4347-abdb-391ca14b73c1	OHZ20P93OCGR	Farrell-Parks	Dadra and Nagar Haveli and Daman and Diu	2023-04-14	2026-01-03	Active	shudcudy2fs3njq84cq2k5nij7egira75icvhebu25olr2o4y2r3vzmvon7bytqyiheruhqunbohbi05gdzifiy41lyg49cmb9ztias1trkqqujjs2lirrs80dzw99hfqback7vp72lvjekxqwmd4xd70qjzht5vu8fmnr2n5mbow6k6fqp6
e4bab910-6fdc-43be-b57b-abd2e1181649	O8MXJ8T4AFX5	Sanchez-Hernandez	Andaman and Nicobar Islands	2022-10-30	2024-02-29	Suspended	z7mou7ve789ty9hj3dgc7pbmew
0aba3882-caf4-45f0-933c-9d26716f7faf	OWVXT3NTVVZZ	Davis-Huang	Bihar	2024-02-07	2024-12-22	Cancelled	bnwt3ji9rezfc0cbnbnpvmlp78tsewj7dfqubowkwc94mj15z7ytysrgks8atwfvachv74prprusj1ewt
b7592eee-4783-428e-ac12-d1f6550fb5b5	ZI19OL07A0C6	Castro, Santiago and Mendoza	Odisha	2023-08-21	2026-04-02	Expired	mul0sxpf4rpmgunnlfy2fik7ltj0us3cyshrmphs0j9lde23cvl79peajamqrem6og2xjt8ct776xlabuyzqxazenag0590tu0aoxqy0hfupkgf0oj1t6by63
511fcbd0-340c-4319-86b2-48804a12aafe	HL6TLQ4UU9CB	Mcdonald, Sloan and Wilson	Lakshadweep	2026-03-20	2024-10-17	Suspended	ktgz23jl8eqaljpuq6w30wne1jlwghratpcz6dndgt6o6alg09uti2s0ilboad7eetojkqm31g7mz3rtzomysqvu0ztfj10pqtx6txjwie42n9hd2uy3nj0d14qyzl3pk07m
acfc4f40-088a-41ff-92c8-422c4147584e	WOV3BQQ9Y7NE	Owens PLC	Himachal Pradesh	2025-03-19	2021-12-01	Cancelled	dau1oob5ep68j63touor6li5vsvysbtuqsjliiftfmlwym38hpirjvzypw5c2adhx6w7tlbalz7b2ypcl6cb2wvt2kngi9y5mkpo3fkqfhmw4lw7ezberlw0wtu8sq0i9c5zmb3egc40cbbkxriiyswrdx9fziq
4c094473-cc0a-4fe4-ab19-697eb6055f7f	09MLO2JPUUSQ	Barrera Inc	Manipur	2023-02-21	2024-02-29	Active	xuuutombwskpusc0nepyctxjq81won1sqe90d4y3kup9dpqgce612yqzpi7j1g5c6m2dumxnjaq3uov7h1boyv8cglfgsdsfpav3y2l6rq6cx1iing3491uz7n3g5ot46a4c408qwlevztjxupn7e5frdscl3azinjw8l8suzuc5nxg35z
1fde0550-bf92-43ed-b6a7-59fa9534f2d7	9OGY5Z281YIL	Adams PLC	Punjab	2022-12-19	2023-03-26	Expired	vumjyraqgq36da4fgelmp98mjp15qxsdmnchmoo8y658vkrfm3bbuiipm0j4lrt640a4hg144mjnxyca3pwcig2y4f2or22gsniqsl561uuxzwal90jufbq6c8j88y55yoqgw2fcxpw1noda67qyxeo
f4ffe505-b48f-4b70-99a7-3ec0aa870274	WSD820G61KUI	Lee-Calderon	Lakshadweep	2025-03-04	2024-10-25	Expired	2ty61vw0z3ktgxkz4lsn536tms4qdwe12g8kgsh1nap2jlcqyxrkj25rl0jc3fncp9dv2yhpmw
28a2c7c2-06b1-4f90-82d6-b310cb417dd5	3XIFIVG02UQN	Morris and Sons	Karnataka	2022-08-19	2023-08-24	Expired	jkyb38a87vzeb7x4u9bi87gfcx6535tmskrgod1wvyv65ccs7ng
7cccb1db-0f9b-4421-8d01-38e2349b15ac	K6S8MYCDGH76	Diaz Inc	Assam	2023-01-09	2024-09-07	Suspended	t98xpqvxaylxq4gx3xjww1z4iyam8vz39vqkjt3m10bzb3kkirlgna3fngq5jemd9zpqih6rqixvlozftssdjnqh2xd96jwghu2rkxcapb3p88dq3pfac2dabsfyjp
21dcf6f5-99c7-44e8-9cec-d1032c3809c3	1ITI9TIYKDJW	Kaiser Group	Kerala	2025-06-19	2022-04-22	Cancelled	e99x1byl2tagxi0vhx9ldv08l5435d41f4ms062lvwxw9n
3b2159f8-e295-4eb6-bc9f-1f3f37fd5380	EBB20SZBV3OD	Riggs-Wilson	Sikkim	2025-10-23	2024-06-10	Active	uj4ry0vkwimbbcbr62xglmy51w7kcns83t4jkl1ttnoqfncwnf5fvv3je0h8d53a39xfvx9j6fafvj8u64edoc012z4694
95d5ec0b-7a8b-4d6b-a18b-7118a8a88902	IA85YUREQR25	Lindsey, Lewis and Bolton	Bihar	2021-12-25	2024-06-03	Expired	refx9rl3d2989semsfniykgyawhkv658t55cgl9f33u5cierxuxocl1jjbirizob0t
edaba936-b8a3-4539-917d-478e457efda1	5BNZRR04BOUF	Mullins PLC	Haryana	2023-02-12	2023-12-21	Expired	6maz4tczrfycshfw3zbiathyz9ejkl093b0vxb18bwbkpw4wjpxdgil7qxs5erkve42byits803g19jd61fsrs0c1g0vyk
aed2327a-9cdc-4af1-82a4-f6c12ac8fe8a	O51AVWUUKJGL	Cooper-Cole	Mizoram	2024-09-22	2023-06-09	Cancelled	3escwva2r0c8dp7mghy7oylh8mc0ntbkbloamkkykxt91z60sn1yto1hftaeiczkvo37ahzs01ckpsjb8juo6y6j9angyrw8ngxakmtrzt1y1jp5dj6qtik5n7pnsdf7wzkt39vgj7ekjmaw47aqe77ixsass
e7ef6200-6076-4302-a472-03e90b8de2a0	TJAHURXLK0OW	Pena, Whitehead and Miller	Andaman and Nicobar Islands	2026-06-11	2026-04-05	Expired	ca2ly1ghnnldg809xwz8m82py14bghi95ttshiiyyp6v6ykeehclo59v7vmk3mcxxsc58a5phhw5qcwubk0qp3c7b1jlfxyeccjtt85hxngscmiiauwiy23r6c67hf5ozcz4hqwf5igjk626sc2ww6zx121dgexdt0slgjj65rtee9ot0iot
aded8e34-7367-4335-b4d4-60c5aa344b5d	208XAC8D2MLA	Moore-Mills	Andaman and Nicobar Islands	2022-05-23	2022-12-30	Cancelled	w0nzly2gcedfqongxyhigd1cdwlj6jwm9d3s9wsaoqmsbv1w42ff4kl3m69sq8xds96e7o93brk2wcdibo2gmoalrhdh2wc20ks946lpt2yo1merty3m5p
3af5a82d-291e-49ba-814b-77af62726d09	YC00QF8QWK3E	Bartlett, Hale and Wong	Haryana	2024-01-01	2024-11-12	Active	vp96ni8l6ddh3qg550k5h717j58qyg7bycx6sn31rntur3nekm5vhhxua4hwurj1iwb3o0mbsxc7qd0wl5lanpdir2rw1k8srkibl1x8ledx2enmdohwt6rggm09f2cyvr3posizx2f06n7f4suknvpal4f30l2
64a24f49-cabd-491d-88df-75e1c51d1a7a	RWAVFC7K9I85	Payne-Thompson	Maharashtra	2025-03-26	2022-03-27	Cancelled	id5lk6vpvy6siu3i9oo9fzwhlnyqtr0enfsl6b6qa77j8gcjt4sqarxtxoien08o0wrciljna33icwv9
8c01a390-d0e0-4ff0-9305-1c9505eb0d29	527IX5SGP1SZ	Suarez-Sanchez	Maharashtra	2022-02-16	2023-06-19	Cancelled	6dl29rhdui
2e06a1f9-d2e8-4c7c-9e12-f5c029d5b503	ADXRPO1M2412	Burke Group	Delhi	2022-04-04	2022-04-21	Suspended	0iktkwjy818fgzc4sb1iqhvwvto75mlcbj4my7oe0t6y6pnspz3a7gtdd6cyrigwtswmmn4ciwermpgo
2421bac3-5e67-4afa-ba55-e333ba4369ea	W2Q8CBA1FBKX	Briggs LLC	Uttar Pradesh	2026-03-28	2022-01-28	Expired	d8j9cjuv140x45reow5pu81q0m3au0qwonrcu7ysnoaf9plx2m0rbaz8o65dcnx3mbu7mejr8lu66k4dyt3wngx6qlhyvcnm0cvb3omlfunh0hdv9wmzmsg76359a2slv3y1wqk03flkgx7m9dxq2pnnu48knt5h75g054dtlqxo4fce15awzhdiph3608zbhb
94c00920-c7ba-4189-a99b-8d3c9ea35a74	UOIYUX4PM0M3	Thompson and Sons	Rajasthan	2024-04-10	2025-02-11	Cancelled	sc6de360p4w28070p1hexmzd9d5fjvp1qojcp1yw07o20wpnra8ezsgujuv7bn45d33d148pq6k2vrb4x1a7wg2965qxmw90fsoi83w38a72ox2yyzqy8byazvejhoouhyd5jr0zcmys2mdkh5f0k8ppsiq3biunrxldgh65hfalig8
a8406889-c92d-452c-98dd-7ac20685dcb1	DH6N6KPWP1MB	Jordan, Martin and Clark	Karnataka	2026-03-16	2024-04-22	Expired	tge0xzdeqk653h0eakif59pvtfa0bnmo7p2em4s0lm1hf750o70kerp8yjcp9
45439564-6b36-4e25-abc4-63c647714c18	UUWJTBO8H711	Berger Ltd	Uttarakhand	2023-12-07	2022-02-18	Cancelled	g8ymd2i4qo91wgdkgxbevt181atsdfm3xy6xltlvhhwmmvn90q52xtdu93b660ntd7bxgj8a5d3u0qg3dmpq9iopvmg0kh43c42
aa6c5bfb-7bf8-4b78-9ecf-78187bd7c426	UYPHMKAX9CP5	Kim and Sons	Ladakh	2024-10-31	2025-11-20	Cancelled	4iviji6g3mhq1cmnmgih1ok2li80z19fu9kk4ws2rbmxm20gfndt1wt2fi7jar6ztyifvekcpch5dcqogjdwvhfizqcg3w4abkxdp4sd5jb0u8j82cdyxnucq3bkv60usfkgkjfl0dfkj3ug45
bbdbafdd-ccb9-45c2-bd5e-bc1a7d638831	U9PUSBGLM09P	Miller-Faulkner	Chhattisgarh	2026-04-12	2025-04-16	Cancelled	2v8ilzxs7cau2ifjn6f7bc55njehnxnky1lpfq7vnegevupveewqb01p435s53xrlv7rfiywz3geio
ba970c01-7620-4558-9c5e-e2e0313b959d	L4C485I8SPTQ	Wright-Durham	Nagaland	2022-04-25	2026-04-14	Active	4myla08yzncs55lhxq43ggbenqyooabzdr3zkwapzt1ilq9n2vzv73my996h7syx
9a82b2c4-a3af-426a-8bb0-0529549e5510	7MKIPG57E0SY	Valencia, Gomez and Orr	Nagaland	2023-06-19	2025-07-29	Cancelled	2iismog8
5ac55e34-eb2f-4be4-85a5-eb2f6fb96b24	0S9SVNP9FKRF	Stokes-Clark	Maharashtra	2024-08-06	2024-06-25	Active	hgoqyejzctn0vk4kt5hiuoh2m6xbdkxxm26y9lv5ge7v5jewga4l7l65kf3sp3v5wicztv369h6dba7ls4f6s3hb5cbyocjdte4yrzm8k3dnr4f5gd8aw9b0ur3nd6
b6a650c1-d845-40cc-92e6-5a92ec395ec9	BOHZ7IZLGKIJ	Moore, King and Henry	Lakshadweep	2025-11-13	2023-01-06	Active	j05lnvjcpb29mxm0hz76xyvdrkblqzl8xbijttpiqne8gpve65zznihdh5mbbz9191ztsduydb1mpsyjigaqow8uir269aufuyn62arkcocg7mii2l79fl2lnoj299pufhhl40frvk8b07
8b99d777-721e-4dc6-9e4d-6d19ee7b52ee	ZMZSONO6CIVD	Powell-Williams	Mizoram	2024-04-08	2023-05-03	Active	yw2xqt3ynph764pbbfho27vmw71ah0ewo99680pzcgqxe7umorx6k
5cea469e-de9d-468d-bdaf-9c6009bba4b8	K678A24FX3RY	Martin-Smith	Kerala	2025-07-25	2023-05-12	Expired	jv6k8qa3e5jq0gh8a3sm402tkhj8fix0xygqxktzm8ge4yh2eoe57fmdwt0t6n196v8ufc2iw8v1huzel19xxgo7z8rtkl0oopwn5sr1kbh919uvikdv97653
ce6f7465-6458-4533-9990-3de128b80778	FQ49OJQOWTBN	Wilson Inc	Assam	2022-04-07	2022-03-05	Suspended	sg3msvstiq428dwvawglm9dwiuwl2pnhzngf5c29dn41788x4zxjn7lkol2ngx33upkn96ki8y7ttip2lnldyn52wy1ao6317ddsaex26xiumg5hu5asi1fz5a2rl92f14hpz3zk5nmthwe421qpf6s0vk8q2ni13ofnqenb6h3
58f6ea50-bb4a-4f43-a6c4-393ec7f56e61	N2AGEWGUMB24	Knox-Barber	Lakshadweep	2024-01-27	2022-12-29	Cancelled	efak0z2ldhefmy6tfl36ow7sqwudu7n9sf397cy7em50qx8u6n3e2yhbjvgm2qkap5rv621oq8lm3e27e28n0ch6fpspyzuml98r38uzur0tvfotot3whcbyix2gj3fzrklsi8sc5ipnj1u8gefhwejtglfm0iiym1dirchdy9g3duc7m
68963a0e-b625-402a-b94d-4c66c7dfe68c	QRDHKS89WCMZ	Byrd-Burgess	Goa	2022-12-28	2023-02-11	Expired	29a5pl7b5tdozeki2bbj4gv9vdvfobp1mhjgveu1lylrjxzaa9yuitu7i58iy23wetyv0y2l3zlbb3jg1icspnry7dgi1iqr7i5n95jbm56c1mm8c22351ijp39lad81grli4q0pcj3km8jgqdu5mstr87asdh7dc7oa4fv82uwlqomnjgkub0wcydhvcya
c422628c-42a7-4cd7-b093-ff4054475a3c	Y8FGD7ESCWC9	Leon-Oneill	Odisha	2022-11-05	2024-03-07	Expired	kmh6ekf2nu9t9jydnjjtuc7mfa31njxyq2p94yg1phrf0anut3n58pc0rg3px8lzdvadup7a300yopaps9sxy7qqcadm0o1bq4jlstjks1c6ds5rccbkdfa1ao1g806q9kurtzfudiicl5vxk3v1zd91vhyfrej0cxjt0ilhluijvdwu7o2s9mx
dedcfaa9-43e7-49bc-a914-9c7ac369955d	9PN2EAGYIPU3	Burns Inc	Goa	2025-12-30	2023-02-11	Expired	6f1eohpu7t3j1bwoe2m1wamkxw3vs2qrrr2lv7mvvj96obce8jf54g06a1hz8jv2905vckozwljcthu4qoxdlclz0w4vz2aoswlq9nploayfqu4yf6i4nk6lsxaocunh5c8y1mu8y1lism65n9mp14zyazp3dbooed6djkhfhz8a09430a1vcai98he
86e850d1-8511-431c-8604-0d6db4af4a09	5WIYAAAVAUHI	Lewis, Hernandez and Nicholson	Andhra Pradesh	2022-10-01	2025-10-24	Cancelled	a683axhhp8ywp0hsoylcqwqkhsvfir6tmjwp8es1k7y7wl1md4bcpev3bk6ervz69ocokq87thjfis662ggmz5c5g5c
cd17f6d2-d512-4d2a-b585-aeccc173f1eb	UNOVBPJ156YW	Dominguez-Johnson	Telangana	2023-12-09	2025-07-23	Suspended	apacy7a9t0xoc0c068s7p3cox2k8edu8eyez4zx1kzi4mzllml1dzqsom2ok55cu6bd0bmpj567uh84t1i623figr0u1gt3td8ujbmbb13zgr5vbxjtjmzpcmpwmikhtq
cd9bf74e-675b-437a-ad1f-d9d2b50b8316	EF3POSUJCIJL	Baxter-Mason	Dadra and Nagar Haveli and Daman and Diu	2022-10-19	2026-07-16	Cancelled	798ac77x6w9fftsnr6ayp7hle6e123pnepo6bvwl7
9add0aea-d261-4468-9a4a-f601f7398e47	M3JQJIROAIOF	Myers, Cole and Garcia	Tamil Nadu	2024-11-27	2026-07-22	Expired	fcdt5yymlh63mlfrxcqgmho1ljrd9rapomkbgl27zmivf1o9n30hfwdk5e2mb13z8ilaamchk5hau7k2fw7lfc1pue2e33t7n6ofos3eutsr26dd4wv5o2cv92srjndqgc8lekb97kmos9041uzsmsc8g7j9se7i818pnh7wfox7iritdm3icbhrcg32uw5x
942b1a85-ce02-455f-a5df-a9e4e53ab4e9	AGN9RURDHG0C	Mcdaniel, Williams and Johnson	Punjab	2023-05-31	2023-01-01	Active	mp1ncno4y7zxe1yvqpp6oujunvn3l7cyktwyr06p0s9qorgeee6c944ers7xf419vi93lqrth7mppryn7hvzzypggjvvouo9c9c3k5nwjn8uklh79h3niuy3qxz6bwfgwz8d
daa67023-37b4-461d-b0ba-ae2a1b9fd7a2	RZBUEL6MFOEW	Mack, Williams and Davis	Arunachal Pradesh	2025-11-01	2021-09-04	Active	ass46tibcf65rujns2ozcacg2t4rzq8jvmaldpx02aqd54ywvmirv
d916924d-2735-41c8-893b-738b55f67b07	UFSUHDXXC2DQ	Dickson, Galvan and Smith	Uttar Pradesh	2022-03-08	2024-09-13	Active	ikijmb1g8v71c0gx0evogkc596w391upmgx2j5qbrf8y5rvzljlvstz8y0swec89p70igkvc5v9zlf0p8720altqndf8ppe251zpptwfinolhk5ehxil5l6aldxi1s1d1ywaiyplktc2
e2fe7d9a-5cd6-4fc3-a2f3-eb8659431255	QBCD3MZ3Y5MW	Harris-Jones	Uttarakhand	2025-05-14	2023-11-05	Cancelled	inum48vik0g03r7b2o9e34zf00nsjirefw1ck8zimhzcsn5ma4pjfylc6eufm7
e90ab994-7d28-46cb-8c2b-5eb3e9f97c05	F93OZVE57M10	Carrillo Ltd	Mizoram	2026-04-23	2026-06-11	Active	gg2x0rlj3fll0sndwkg56werz07r0y7hrndxypsu7dgifq6xbbswqsc3ghvo9hyh3wuvrm16an6spyenqckuo4rde6t7evitbp6848klqy2i9sfuicgq2ia1
a5b77e0c-49bc-4c05-b8c9-3a53210ae27f	FZYZ02EARM40	Marks Group	Bihar	2022-08-10	2023-06-01	Suspended	bc0y9uon3m0icj9kwol4y813dxxcn18yei22xfpg74h1i8pa4kw3ffbl77l9c9g05q1dv2rkitb52r0vafr98sjts65vwt6o51pc091ko1heqbdidzfsviwdlrn86bddkcmttqe2oc6ydkbx8cij73w57
2d1b42a3-3d1a-4663-8906-2e00937dc280	470BSHUAK44F	Boyd, Miller and Andrews	West Bengal	2025-12-06	2022-04-03	Cancelled	3wui9qz35hn9fimtiloy02ck7bn7ze5mhfq0scrgy8j97mhz4gooyytzka8i807r83i3vd3dgbn2vulsh1z7vv3oi84ud7sp62vcqhukrn11eban2oi9loev9vqos3bixg4owo74ya4e1jj174xj7a4mq8ej4
01e40868-7121-4230-9ff1-17a3e6f1c7e7	TC6AYCZEOVY7	White-Kelley	Karnataka	2023-09-25	2022-09-08	Suspended	e1puvalshq2
0fe49f2f-b737-4400-b400-0ec92b018509	A16VDQPL2M06	Morgan PLC	Chhattisgarh	2025-04-19	2021-10-07	Suspended	gph8ob73w49adp6b9q23z0o48p0wmzi2qf0c5retg4bo1w1ml8e6k0m1tke4x3iu74namra2m0szh98obu3le8en3dukruso4pgdqgrahlk6h4pyezsc3qjf2y8g75qg1bn2gal861sineq43a75ylrowzr2a37146y5efjfuorfs39a24cldkio37v9tgh
e4e146de-5dc3-4cd7-a41b-81053ec48ad2	SDK4E3JGPWDH	Holt, Jackson and Williams	Haryana	2021-11-23	2021-12-04	Active	qx5rp66v4eyagx11x0ap4vw3qh0wblmhgz28xnhzx1u2s046y60hu2q9gs983kl4c0rbpxwr668jev2l65zedu7dfbk07cl6ksvtc56h5bmzgh868lbeq48py27mkyjgxtv821sclgg
e775ce06-9a86-40db-989d-fbf1e8e4c11c	SLBOK8VT6RDO	Carpenter Group	Kerala	2024-03-19	2024-10-09	Suspended	mn9fyd1x8acyj3ly525nghzmuqh7o7zf3ikbnnroshbykq3nol8js7dilzyltjrrlafnqpvcbj0ta4n5hbrolfdnbt5549lekr3601rbe2r73go12dn28f28lv4umpq9snlhg3r6s3a2j7tymvftlsgefzh0sd9zsr9mrlma6mp2zwyfs
2971846d-4ac0-47ea-8089-df32938bffc5	QKXJYDRQER8O	Clayton-Arellano	Tripura	2024-09-28	2026-04-04	Cancelled	rufta96omah07tq8rbljvz6iiygudo91a58empbo
74908116-afed-4aab-a0aa-baf4f158b3fe	IAIEX8FK9V81	Miller and Sons	Chandigarh	2022-10-04	2025-08-03	Suspended	ar2rlv5xcwq7
ae833fa5-0351-4c6b-a1e1-d3e2e0041785	RP34CNGURBWH	Harris-Sloan	Uttar Pradesh	2023-06-02	2023-08-01	Active	859xkrsnc68htiwk0nlx712tef6kr8gsfbq18ceajsluroa7jbtbzifavg78mka0kbng5a2d1dtxa132xgskocrxsbwe4t4ap99dmlf0686c9ob8pyvwpl6erjo6v1frwe9j7zskzc34h2p0nhf8
f2a08690-de83-4fb1-ad5c-3d3d6f65359b	ZMOSL1O900KM	Holmes PLC	Himachal Pradesh	2023-01-01	2025-05-12	Expired	iw6cfxrw8j3m4fihe4pzrjy3zk94nggq3mmmwnxrqk0sb47lj6krgusoubf1iwlx7so0ry2b71snhl4553joqc3ar4cmtjwfbrzief5br8wa2tgie3iug94xc6vcrk7
d116c78b-0f2a-4ae2-b7b8-a79e2adf63dd	AMLROOSKPXPJ	Ayers Inc	Goa	2025-11-03	2024-06-30	Cancelled	7e5td5dmjkysgxbibugcj5bmu0le4skoec6h33dk4sducmvbcjv0okj725j3frpp2hfygj79kznw6snbuz2p9m6ej2xuvxx
732b6032-ad7d-4960-b770-3751b2700ae3	MBWZG3VZAD6L	Harmon-Bailey	Chandigarh	2023-07-22	2025-11-24	Expired	jbcaomdse9kbqwwdan2s976yz5hce335tpgpe7c40i725rrq9cxgsnq8e8ip3wv3eglbtid4cm9h2uat7356o0fbsquqr0hxgplqhjo
25c787db-4a3a-4358-ad20-cc8d3cea0720	RYAUXZSR2B6N	Mendez, Simmons and Bailey	Maharashtra	2021-11-13	2026-04-22	Suspended	hawd4rap11flqkgsxekjaiv0khzmcrg6l339fswt60arigny3ncvnfth5mhgm3rq6qwvjdtlzdoptwcixvpfw5mk4932u6qsyptf8b6drt4lt9mtx3l7g9uw2a45j5bue7e2ab67h0
99054d6a-1774-4e4f-8479-cb2d8191fa86	6VE997UJCBAP	James, Ballard and Jenkins	Mizoram	2021-09-04	2024-02-10	Cancelled	bh0w1ukfa88qjj9o2m9j9llbwjvgyhw4bli0lx8gst64j1cls96qc3mon7lfj32zifhybvoegg5h5mac6
0323aec8-6d15-466f-84a0-3e98b1d97d08	5WOAEY9MYTGY	Austin-Nelson	Chhattisgarh	2023-06-12	2022-10-16	Cancelled	hitf9c114jfq1efjdgy
b2c9b6f5-88af-4ef2-85d1-8b2a498b4320	3O62656HMY1H	Dennis-Blackwell	Ladakh	2022-09-14	2023-06-10	Expired	emz93c6jfmwk8v4kqlgydrqh1hfweesmphgvp1zr4x4cn5x1g1rvg98x6vrnuotnusj6vk9f3k8wojspjb5x2ko80urm0kboogx6lqibmcye9ezoahusdzx1qh5adsrmbqvrcf5j1uda
86ff5e03-77e9-489a-a66f-e24c0ed24022	BTWN457K2E11	Newton, Orozco and Dean	Odisha	2025-05-30	2024-05-28	Suspended	lv8u4712291bfup1dn9awafzkxccj1ksolemzky45m3ihi92sxhs2zo0lwyy36kzl2ey2ertjuii4t7m1kc3f79k7
69d1a806-daf0-41dc-b551-5309838fa431	YLPBX8MR68UD	Jones LLC	Tripura	2022-05-19	2024-04-25	Active	iw3zt16sv5gqernvm0afe2ocztkbnoj5u1pe5s1zmxa701wkrkfabux4eijv8t1z7sazg7rdefubhnlpss24bf1zc961hvopigamcfxr3hb79z9idovh5wnq42f
1da484d6-2d1a-427b-88ea-38342bb24989	4CHC4V22HONA	Jacobs LLC	Dadra and Nagar Haveli and Daman and Diu	2023-07-11	2024-03-10	Suspended	w5138kv0oha7vikj9txxp00e4y63ji57zqh3g3hmoga4mdju271vvz7ftzxgfw3iep1l6vqfzcte6wwygyj3jpc38kwdvodd73dx4o9vz4rl7lxe8fzu
1173c770-71dd-4be3-8c1a-0bbeba38b9e2	5DZULVCF0NA2	Simmons-Parrish	Jammu and Kashmir	2021-12-31	2022-11-06	Suspended	og5zk9gdxzn5d6nm4ommckttfvuty4tlzq40paxim840mqqo009bk5royp8bj0o0c8aigqckd88d49hnqfnk4l9w1gxhx98k48uasjta68n7eb6v24yts3tv3du4o1frsuibuoovg7lt8mgzo2nrbs4tvi6nv29d0zfboho1mhunp5io9nud2g3qwf6d1
0db9511e-a1ca-48c2-89ba-73d3b75695ed	2L2HWFCEAXL2	Morris, Martin and Frazier	Delhi	2024-01-11	2024-01-27	Active	xy08abkxsul7uuutpueo07gvcanzc7vo8bj8xl89b1hp69y2gicoga8srzw6mhtp8
fb8e31fd-953c-40f9-8fd4-bd520272adf6	ERHC5IJ7NFY4	Nelson PLC	Gujarat	2026-01-03	2023-11-25	Suspended	gqlccpr150riksf6mc2pgu9zdpwcgjpky8h684emio6oak8l1djbotvut4n15qn479u244ytbq0g3bb0i63ive4dlrp
9d764bdf-306f-4e4c-999b-fffb5e804421	VCXCRMPU783S	Bowen-Butler	Punjab	2025-08-30	2022-06-13	Cancelled	cisq9snnqlo9br62y0hgdzqu862wz6dfedvjl7fvqsho3s50ackhrnp87tbubb4e4laopy37tvx29gadqjsalzasc5bebbgp1dzo8pn02wo9di0kka
72bcccec-f079-4a93-b458-49d964363334	7E6IK8ODTU0J	Estrada PLC	Punjab	2025-06-30	2021-12-26	Cancelled	1a7exyfc6fdvlmojxaekbqb9wmdzv6xrzra56mok1eczz35vimwvmsksbhjpndsmcor7s8n4nepgqw2cam54drt7qlaxjzqh826pc92m2itfocz70zkq5166y52rvovavqboxyzhkbaebgvi24j2h8q7e7cywrpx73ru8vilryempe0h1i5fh0ify
dd573bde-41bd-4c5c-93e9-3b4af0503f5f	791GF1NUVJ6L	Murphy, Griffin and Blake	Nagaland	2025-12-08	2025-09-19	Cancelled	ysxx54u7t7f2hjnuppm5lfmbrgb15l5usrqyr37p8gbiqhliwhgsh3r3vdmlewu66o1iav0vxa3dduno3l3gsderja76j0p
da8e912b-4460-4712-b590-9ac7d709e2a6	Y9BULLL3RH1E	Allen, Mcgee and Luna	Uttar Pradesh	2025-01-10	2025-07-27	Cancelled	rl45n296bwwgj5fw77h9tjt6xt9
eb9a77b3-2c0c-484f-9624-28debec9b05b	JG5CDXKZ0C72	Snyder-Cordova	Manipur	2024-04-19	2026-07-30	Expired	195sg5epo0rz9nw372mx9tnhrinfptjgykugcxqful9xshr1uu
36c8661d-1fa4-490c-a2ed-7d1ff953ccc7	KF1UN3FSM1S6	Baker, Johnson and Roberts	Punjab	2022-02-16	2023-03-07	Suspended	cd65n4ctggn02n12x8zc7pfihlsvy0irrtcir6obx9e2ulmyb7oth9vg89z9nk4k4mtgwxk16j8vwi8x3tr1mj5nmcmq
63b53762-5599-456c-9ccd-744592c52266	1CAXEJUOX177	Rivera, Lucas and White	Nagaland	2025-10-31	2022-08-12	Cancelled	z62ltivivd3o9dskb48fy71syx2bd51rab5793kllzkakqf21vya9lxihvognw49m00oaosnziw22hrznbciaw1a8r6qlcgkvsq6muyhmv9w36a6ycfr1siempx8g64na1
39eb33c1-f31e-4a38-8a6a-4683992be9ad	U83VOIUWUW4L	Chavez, Rowe and Golden	Sikkim	2023-03-16	2025-05-03	Cancelled	a5rcqo8pjfbs6lbmfntv1b62atni18sbcfu7ww1dwhlcpl4hu3e3ev72t4ho0bii8p5x6usnzimwpm09kbli434j6pmdp0kmft5j15xl4ncw76vje826nbydrpeybb46twaq1jyxerx2igujn4caj2gqcqr318sgffb3k1u54d8a
3a5bc40e-f201-44ae-a929-78fc965ce880	0T8M6ELQLKM4	Morgan-Gallegos	Goa	2025-01-28	2022-02-01	Suspended	xq51r1zqha507zk7qq4mwzx7a5noyd0sahsjjhzfgeznv05u9n7h
d3cc0c4e-2dbf-4567-bb2a-d3c7df2f1e3c	TY3U3MXR0QIU	Powell Ltd	Rajasthan	2021-12-03	2025-01-13	Active	dcczjjo1oaivrhawdks4isekk81bulup9uezl5hedwjcf1hrr1bpb7lv8h2vdpovf0j75plumrq03cpbq2z1kdtq4w90harbguvrwlkx1ulpcpygfotpasbfjqnkgjqig6j6rv1j1kod46y5jn59pmbbdc2uz2kkmcoh1p0fzvavi5tie
9f78c882-4e8e-4f4d-9740-e5bcfae66aaf	G3NM8TG823S9	Barry, Snyder and Lee	Gujarat	2023-02-17	2023-11-26	Suspended	8zsbkcqvnsac5tl40e5c31t5qqkxb1h2
8222ad44-fe20-4a6c-befe-898972fd00ce	0EPG0XVH6XVQ	Phillips, Kelly and Delgado	Manipur	2022-12-04	2024-07-18	Expired	qkq42ej3egq3fft
0aa95c31-4e1c-4ea1-9ee2-d744c4f08a29	ZIG28EWWT0D2	Leach, Francis and Carroll	Gujarat	2023-12-21	2025-06-04	Cancelled	tqarf7tvk5cb2udjfz2aa7ouvjh8etww4ikkmbshbqqb4ur1d63e7g7y623q6jad
23639a1c-be65-4014-8a01-b388b2617d6c	ZNHEA8R64NDY	Randolph-Fields	Nagaland	2024-12-18	2024-11-21	Expired	pz58oj2vuev1nl2njj
b0b467c0-ae66-4bd5-876b-79ec7888ad4c	JTXUS2Y822OM	White, Ramos and Conley	Tamil Nadu	2022-01-05	2026-07-16	Cancelled	dqne7pj78ppv28j5pucr1qx7h766jmk1oq0qx6k78dfz6spucjjqjrlr7q2flhc1d4eporhm5k10voi3ex63vf1c1u751xp0tyqvqkhqu6guyj8k63dcneoy6ha1hhgsdyq3zale0fsx4kwlv0lue796c6n7ymvvybzt
f56623d2-c403-4c0f-9eac-960c342af498	FUNJ60VAG4XP	Yates-Mayer	Manipur	2022-03-08	2023-06-18	Cancelled	i4et4bph4usj7lk7bb598li9ux32jslfqqlpbw8uwfotvegb64av07jncyaw4lrjpttnajci7ewmaw11wxgvef3khh
b8f822d7-9d3d-41e4-b9be-56dc51660bee	LFH8JLAT3KYD	Mendoza-Powell	Punjab	2024-06-03	2021-09-06	Cancelled	38zjiaj32jekhkcdmzv6s5slla5il38dijlfrh
7453c601-1676-4ef4-ad8a-85f7e261918b	M1BB4E1QLXS5	Vasquez-Thomas	Puducherry	2023-04-12	2025-01-22	Active	gow8yuu6i6mix
f80df970-cfb9-4c0a-a57d-8bde3002a9c6	GJ6WPZUMFCDO	Townsend PLC	Bihar	2022-05-27	2024-12-20	Cancelled	6ktjfop258tgsmegsw7hopghizs127idbsb52m9idpohqfai4vcaxnmn1r3eqoaxrtugyfvrfnp2qwmpwe13ku7oxlm5b4vwl80p0uosuosgxzkp1s0m
7b66fa3d-986b-454b-aac6-34c61d11b9ef	TP58C6431FH1	Bowman-Woods	Madhya Pradesh	2025-10-05	2026-05-24	Suspended	o4t1viqqshayj2n74qj9g8c2xv5uryzp7fwqftjlbik9
85e340d8-0eb8-4f3d-86b4-85f9c9a98a2c	DBA830EDK5WT	Murray Ltd	Manipur	2024-03-27	2021-12-10	Cancelled	f2m2em0z87cimy0qep5hoo49spp8nux17boq6nodrfqs7dp282r103p0uxjkt0glkq6gf5k4a6uclbxx9upo9vo9c3h5a7d85gb9rwn84lqkk3i2ou3qd6xi
c2184d75-4fba-4c1f-b564-2232e9d6f2e2	1GHVH64EUNXH	Taylor LLC	Arunachal Pradesh	2025-08-15	2024-05-13	Suspended	17c9c3wk026iqxc4fq2u4b8rb0kofxhffxhao32fgssik7oyjuo4t3d0gemd3sm4a55x4fh8x10t2zzy45efr19uroj
43c04efd-be45-46bc-8c13-762a006c702a	SA55FUVDAZE0	Wright, Carter and Walker	West Bengal	2025-02-27	2026-04-22	Expired	jdxmonh2ou5u2shhjnfcuorpjsy3sy0tdog5pc0xgccwtuu1mnvgspi09vr1nnrbdwllefpsmuo53mypu70mqcc4l5smpf4oa005j0z998tun5eekv9cxtuxl1od8qj4qsgxqx048djrdcly
23fa1315-93ec-44cc-9798-ddc2553b978a	7H8I8WV3T6DQ	Gallagher-Wolf	Karnataka	2024-11-15	2023-04-11	Suspended	968axxxqj64dv77oceji3hl2kwvk5nsf834uuxmuqt2gok8hejvfksa8qpzc87otz1wlfl
b02b12dc-1022-47fb-be8b-df6a1cd5a73f	4LLA5FUNQNY1	Jones, Phillips and Berry	Mizoram	2021-09-24	2022-05-15	Active	dglf19qf67en2gw03g2gjzu481aftqtjapy3pclvndady5x5csd338u0lts48pygolj3p585p3ozyng6r
20ad338f-ecf2-446f-8e10-4db7f4abb559	IZHHL3UW4X90	Brown LLC	Sikkim	2023-06-16	2023-01-28	Cancelled	iy8qc3rzfnpdu9r9u8ozyrmukhdde13rmsa65c
e1a38023-f70a-4aa7-9513-fb6d15d58608	TX66OMOJH5SF	Flores, Bryant and Brown	Jharkhand	2026-04-09	2021-09-03	Expired	5embbvbnh8se0546ucxg4nfukpwjkq82u28svfx83
9c3ccc4c-201b-433a-89e3-481bf5fd8fee	P7LUJPSXAX8I	Weaver PLC	Maharashtra	2026-01-09	2024-12-19	Suspended	xiuohrw3kovhsy3ps74v5g9918lf4rdoagxakrfwbn59e6tn6622gjc1basi1sbwickpckadb9u9wald0outszhkawco9zuomgdhf8t63bwxvs1th9m4pnqecbbd495i9ny2inna05g7f0e625
36c5d0f8-8d41-4d51-af0a-b1d1c73922e6	VXD04XAGLCHH	Hicks PLC	Delhi	2025-06-21	2025-11-05	Expired	sgfli8l4pcnjel1l0wv2csmnbw8bz5ds6m3kwbf94bhb0m9b8cobxewtg0ieymejkrpg6pka4vuk1ck3d867z
5b160ee2-0edb-4930-a92d-bcfacd9551b1	OJQ5K5XND7LH	Russo, Lee and Davis	Haryana	2022-01-14	2025-08-07	Expired	ja379zz8c1z5mqj535zugew1l7p91q1bwrq7ui9ojmzow34apyqcw62usrbs1e4hqp1ivl5bkpu46clhy553zwow0mgjvaqndlk2tn562j7bi3939ag74ytl7thxre21wxdw8o21m5durvgoxpbj17x1glr2m3glaltt2flq9ofcbexq2cldjydlu9x4bokaa4o7gjft
0a05874f-8e69-4593-a372-d555f2fa17e7	YY16YN9QAYYX	Lopez, Mcfarland and Little	Mizoram	2026-07-31	2024-02-09	Cancelled	v69vrsuwr44r6pjvvhn6ynwzu4dbomxol6je3zo5h3brwzrirm44wp8gpllxrm8oxbr2aw0gw9cyze8oze5q4c8n0xho9hh9chm9nrbkifoaac0iigjfujmdi785sfa5e1f0pgkn2dsqdux2849g8vnb510v8kmug5ip7fdb4i881nqe1wu2a3qcsjx1zm8n2o5z
ab35b582-593d-4202-a897-413a7e2dc398	JY08WY6GB4PG	Lawson, Mahoney and Vang	Arunachal Pradesh	2024-12-08	2024-12-04	Suspended	wizmnwhn2h7attsskwy9awboffk648tq16
f30d8214-3d89-4145-acd7-24a5906dea5a	S81J5OZR64WT	Ellis, Schwartz and Burns	Tamil Nadu	2023-02-28	2025-06-18	Cancelled	m66co65hvhpqggfpr
b2c22403-8d5c-459e-8a21-8ebb888c62ca	DJ3U9F9TW8S3	Ball LLC	Bihar	2024-02-11	2022-03-20	Suspended	38i0kxsiq26n9wi5e3zh2dhzvc48c905y3d80ag70dqf01pkpnmyh6z08u19wzjwws3bgt702kjr6vdnamhqwuotpxgi0w9d479zow67zz4xrfmoazinuvkxpxqfepwkalxo5q8xyakaqyvqn
cbab5c6a-e0b4-4df2-8626-b8ef52ccb635	RQA7L348I1IZ	Green, Bowen and Hughes	Chandigarh	2021-10-01	2022-03-19	Active	beuceqzll9r2i6qw8kww7ocde8
3b3d49df-39c4-4035-876a-6936290d5d24	4PBVHFWYDDPI	Weeks-Brown	Bihar	2024-01-15	2022-10-08	Active	v1e9r79t9mimlbfzc0
cf9ce080-60bb-4a94-ac08-7444d53d19df	XNCPUK3LJTON	Adkins-Nguyen	Nagaland	2025-01-15	2025-11-09	Cancelled	wpebktb87vny5q2higy5pliz16pnzoookj2jvwdphnzk7zjf
bd0d9626-bdf1-4a04-99b2-2c17929c1f4c	RAEWOY0WNAKY	Flynn, Jones and Cooper	Mizoram	2024-06-03	2023-02-19	Suspended	3mpmnvug5n0kt1t0lab2jlihlqwm89jtv2s2pkc9fh9jyej75msxc8j7pwcthhccn6mo8z19yl7fmf8ufu7c6yce7odqd3228cudd0j3cvyaqw97ouqme6i9dmufyd2zale35
392c37fb-8d11-471d-abfc-26cb247d6859	F3DDHCYDNUTA	Wilcox and Sons	Andhra Pradesh	2024-11-02	2021-10-01	Active	rzhx78p5z1wl4kuiig8mjaersu2axdielapdrctqpzs41xyateaonn7twzx1w7znjvyk9nigm78xzb1jcae7fiqlia7j1fxjy7thlhgwgkyfemvmkeosulwhter9x7a1sy09pm3xyk2ezmce9irwff1j
3f32f101-c5ee-463d-bb8a-dc4dcfaa792f	17SMN866V49W	Reynolds, Smith and Henry	West Bengal	2022-04-23	2022-10-30	Active	86wetcrzsmocwwwjnz1q4env3g17zwmewdpfczozces3afmnxcjj9xlipod6mzggx6ltdvhktmyq2abdhglzhtl9dsjkpmso9z5maop34pocfd4wu
c211eab6-7ceb-4ea7-a75b-5f6eaf121152	IULD0TAKUJAO	Alvarez, Stanton and Kim	Meghalaya	2024-02-27	2024-05-11	Expired	gw1p2yn2xlxgh5m0tyuhtr2r5e7qxfdkcbhnzewkhxpk20u2ygrdmg0j0u4urixp
54320f12-9a9b-40ba-8493-ea3e42b0f7dd	33O5ZWPJ94F0	Koch-Wagner	Jharkhand	2023-06-20	2024-09-05	Expired	uu6tiz6k4je245jg
0ca24bba-6fcf-453b-ba60-3c50e52a08d5	SXW2WXQDZRUI	Wilson-Warren	Sikkim	2025-01-16	2025-06-04	Suspended	pavwi02he8w2hyh6o0qzjn2da0tjsxr6oa35eovgiw8i559kroz52sa1fzn09kc68pfxxlt5mxxpg3yb7hytfdopjvmr8293g4asm2ujupcebs1ipdh309cq5ez82dqslu1wun4am27xw21r065v05eu03jb6zo17fl843cz8pfoc62t6fjxy3ulq9ixy48mzkm0s5kc
c02302a3-7cfa-44c4-b15e-33685a8b54e5	SY4OQ6GBUJW9	Brown Group	Punjab	2025-08-20	2021-10-17	Expired	88ig4cuhcpetrihs2c4na0wut3c4246c09kzm6lk7l8vxd5hg47lggsn8u9bdbhyxq9g4e9stu89fh08i9rubie721v0xkbhmndyihn2w41qg
e5807a10-931e-41c0-93e9-9be010d49eb3	K2PDUZB3JYZ4	Smith, Marsh and Vaughn	Andaman and Nicobar Islands	2025-10-03	2023-04-23	Active	ga0bodl1m1k6vw17h3jp69mv4viinohoxs8y2jj0qboxicjg1hrhck4bodxmcfp29opqs
dc2e3123-43eb-443d-9a02-414999fa0c7d	E21DBTBBUOYL	Stanley-May	Delhi	2022-06-28	2025-04-05	Expired	d5wjgl6tdjf1du9gxc1zeexkbr5py8dh4xgvj4jju5ijgbksd3o5v6j47wjvoa1pi9vld5tc0536fcv97py5x0mh1kthul195duh9usa5bfx0ysjqmpj5lxkjxj7k2mvpg1xewoyw0vig0yphxtbyjlc3k3j0dy8v7qahvp0xe27vwwqpxn4y8z1qna8vla
fd9b0ee6-3ad4-4040-b80c-7d2460ddbc92	BEAG72H2SI8B	Dixon PLC	Himachal Pradesh	2023-01-05	2026-02-17	Expired	zflujmv2scvk8k0komlx8c3a9n2gb693nuow167nidtp2r3rubk92f6htffcghtl003jqta9kw9qfpk1uxt0ssc5wadtxeij27kwavqelmms8m17auqvmb4ht2wcvvymegrrj63vz2mxagfpxcnqke5l5sey68x8664ecilyhouzeyt1lyr3glmqang2iz10gmufbjn
0dcb8c34-fdb5-4825-8461-d48b0cabd1a0	3TXYNRRPZTWK	Horton, Wallace and Long	Andaman and Nicobar Islands	2021-09-20	2023-02-22	Active	b6p9dti2wboeuqtjhlgtb6
1d46a23b-6b58-4abb-83ef-78b6a970228b	MAPHX5PJMS5N	Wilcox and Sons	Mizoram	2025-10-10	2022-10-05	Cancelled	5etmon12uflqb2y5ix3zkbzq41nup01vfk3fj9fopma60r3w1gesvfhmuafcxlzwt6qh03ag0y2fv696v3poimzjnwo0o52zg8uxry6yozvt0jl4db5g
0f89b6ef-8495-4f26-85ce-194337be3760	FLR9V3AKHZUW	Moore-James	Andaman and Nicobar Islands	2026-01-30	2025-10-16	Active	4qmcfcizkqjhb1obmszkd2admn6yr2iw2lmqx24rexgyhn0ipj9eu94sii0j6bon4w8n5rlhlqa6fz6n7sqp2gja13ya0bod97lmsk54a0by1ec5i91vb12m0b0b7pl09z3brunwbswcl09ehmw0epc
c5b1de4b-584b-44d6-813f-915e7ac22994	VTZ6PZ89ENES	Carter, Huffman and Montgomery	Lakshadweep	2026-05-23	2024-11-30	Expired	bfu7z4hvfyeq9abyl4l7nvw8vmh2387joou791glynn8gkuy8dkjv0fesccwaf9e5fbwx73en8s55zuewp4beg
2ca08f64-c5b2-45a6-b4bc-08f96144e687	KYMK8FKA8I8K	Coleman Inc	Assam	2021-10-13	2021-12-29	Suspended	cc72afiyz5x38f9v1xandu7xa491vhwbpjpqbp0gb82yiluiiiq103hl7c77vuf8mho1fpmnlve1tb19zb7eu9extx3crw3ydg2wgq3sai88tz4h05xsr0347sdy0dxk
9a45b56f-8477-4ae2-978c-6f02f49692b9	JY8TKBIZVO7P	Howard, Meyer and Watson	Jammu and Kashmir	2024-12-05	2022-02-03	Cancelled	f6eb9yu5o6fi12th5ifmd0zlampbma7qk0ja8qnp0x6yp3yhkze851a9lhjgcr4dqoxvgwpez6x3
a36c7bbc-d7c2-4d83-a4db-34b81c481e91	TWGHVZWYTE2A	Reese Group	Mizoram	2024-04-26	2026-05-27	Suspended	mqtg3zgh4tsbqd32b5pqvszmm1fquhch5022v5zdkgzkj1kt2jt1br5uzl4e6vjm188m7zfrr3z0w8gq88ia9c185c4moojvou4zck57x0ry1q8vkiaisqjr7pu9nk87jk3sf4afjgqd4nymxh1c758fva9zovcxfpune
651ecccc-a1dc-4f34-83f6-44e5f602e48a	V6FR4UOMING6	Lopez-Wilson	Himachal Pradesh	2023-06-13	2025-01-12	Expired	5jv949ts07rhwwj6pjd1ppexl4gaxo6kea987wmi6pxnp4nwl9lfiigrrysxud9ogv7s18neur3dvy9b7qwthz7bs6ro9p50bdcam
2cf56f1d-354a-46f4-9aa3-006b1ee575b1	6MJDWEHM5KGY	Cruz-Gutierrez	Haryana	2025-07-01	2022-09-26	Suspended	98e2r45kt97cp5xnz9m6ovjabrdnwak792arylh2ynbt6vrkb933wd8klq6kadsj985nkd49xo02b1d0wae0r2njpvvh5hwujdqw22m03eyzm0s9nivxupwtiprgnrwa0vdajcs9eeqrsg4b0s3e4p7cqx6pcicaz
81bffe0e-80fd-4df0-b6a8-789a6eede2cb	FFX3J19FTQRE	Austin-Ramos	Gujarat	2024-08-03	2023-11-05	Suspended	06qjchmx5p4nlwn5
fa85772c-4842-4984-b786-45c5b95800a1	QDXILEW2WY1J	Mason-Gallegos	Delhi	2023-06-04	2023-08-21	Expired	wmpk12jgfjpqca3mkl16e08g1bpnvnlxydx3zbb23gcta6fz1vmmmlllu6r
12ec4eaf-085d-47ce-b4b9-7e4216c04986	H9DEQLSJ6ZS8	Mills Ltd	Assam	2024-03-16	2024-07-28	Suspended	iisb17s0e6l82gaycxp3kbopmh53wkhnxyec2g315hhtd45ms9e4z1ysrb9zdppoj3xs0k7uds8zcosmxyq0qn6f10kys88hi9jucy0eb7m7p79z1r0qn38n8bi9qn65fumwrom2e65hpli25c2ky6la0kmzghm
0dbb3f3a-234e-461d-96e0-9bd0ef545d9b	898BFPVGLYV7	Fernandez Inc	Tripura	2025-05-07	2023-03-15	Suspended	p8yjqyz1f
2f265031-b359-4639-af60-2baa778c5473	6QDI60Z2OPA1	Jackson LLC	Maharashtra	2025-07-22	2024-11-02	Cancelled	7qujkkvcaw3g6sa0t3cbe196apvo776ed08dv66sgyosixqlw0rf9mxcks1baxfx51cycwpalsw90rr7dcbuyrex9gmp3thz4uskonr
1104bc80-1c98-410a-a0da-21e26fb4348a	B9FM0VY2VRV3	Gray LLC	Assam	2022-06-24	2024-08-29	Expired	9q40balm7gt2phih5swp23pxvwa95mdlv39j3bvrq43pqyy23sa927mcfd6dw3szqt9q8xv08400skzy36nct5vk7xvli5bkk9o7z0pmme74u67k8tcbliar5kl17yb1ejfj7uyyg77ablxn43a6gu61hnh0wt6vb2466aw3l9ncnrhypzenvn6h
0c131e5b-f238-416a-a91b-ba7b5c27a26d	V1SHF67DJWDM	Mason, Smith and Mills	Jharkhand	2026-08-25	2025-10-19	Cancelled	1fdg01opoaueraj1ln7d08of1eqyd3wildhx16woesnp51kw9hgxquzsk43330awu7o8b8g6bsbndcfkcboqrxnta2ll4bywl3yd1zm5bkqob9pm8pjappb9ndur70lepxjnn3oseiihpsqe9rokzif08vbvgfzvkwtzater5rhz50jurnzj09
3637bda6-6628-487f-9b5f-1ffeaef08816	MPQU1O5LD4DY	Davis LLC	Delhi	2023-01-30	2023-01-06	Active	52jkvtp8gg9q8dreayesehe89vtz8t7bjrcfc6xh9zmv1ns0zzxkuc94cg1ls7mp4wdu33i9bidtvxwuztizs8okd21oem165nj0uyd2ryipq671fzn1rx1efr8bnhxe2821wgcikkuj00o341a9m4amfs10y698n7gtmzisiijubcpb
eefa9d4e-4c85-4577-a839-d51b93a37bda	XU07P5UWQ96U	Jones, Wood and Hebert	Sikkim	2026-02-01	2024-06-16	Suspended	696aexehfg0ayome1i2okvlyqpuogf9sgkqd0wsjpkt6u4qicuj6ir2o3k3pnyka6rtxd7qj
0a40cb33-9c5a-46a0-9253-f3ec5aea58f0	KNTB21G9PSAD	Gibson Inc	Jharkhand	2024-11-10	2024-01-25	Suspended	lsja20hvlrnz882vczoirgvkh593vtb9w81kejeydrio9jafq4pkkje04ffswtd521v2xndyrdreo6fqd4802gr01bv845nvl3iud6hdj6ech
a87c0092-3e22-420d-90a4-ab365e9cca34	X8K6VRVH067F	Gray-Woods	West Bengal	2025-07-15	2022-01-11	Active	iifvd0a87drk3rqj1nlwaz29t7yp5rk8pyq2r9iwozsnu2fth1y
02259985-af44-4a85-b427-0207f62de70d	Z7KLF12QEZ3R	Jackson-Zimmerman	Bihar	2021-12-13	2026-02-13	Suspended	ele1eqogxq09aqh0js8mk7pmwb81f99ou4v
15963193-1e2c-4d83-aac2-b839494b8b13	46O2TRXNEDUG	Jacobs, Daniels and Peterson	Andhra Pradesh	2025-08-10	2023-07-21	Suspended	8nhyqmj3jtlcp5ob8ttr7yhvhsjexde2tipt2sm0ylizv98t3r
328befc9-96aa-4f5b-badc-34560e4d7c44	XBHN5BHTFERN	Hawkins-Vang	Jharkhand	2022-06-07	2021-11-02	Expired	zfoibacvogkj734eh4ofkgmcm1p9vwckw2s9w4fxtk2uv71ca94yzzfyppp0kay8y3lsac5rnd11bk8xohevyrz1uuhon9u6ersi7jh6xw891pufsqqiopkw9s8tm4rhz6uh6plcol3kp1xogi
9fa5addd-e9cc-4078-81d6-8617c4debadd	BFXCGLA86L2X	Kennedy-Johnson	Nagaland	2024-03-02	2022-10-25	Suspended	7dbyet1mypf3mgbclh0w6ncson6wew3w8
2940c2ee-0342-4d6f-9225-3f5cf29d0d1f	7XU0S9NLEU0W	Jones-Fletcher	Gujarat	2025-01-03	2023-08-07	Expired	pieq5d7n2hek83u8os071ksbof03tdiwyccgc5fzrydbxw8evrigro8glwzmxk63x53pedoiuvy4z3ej244ly21t2nxwwid1mvl08wcaytjalhtkmq4uslvday0275eq
2f1eacd8-7cef-43db-85b2-a5e6e4c51774	4OSQNSZKBGX7	Johnson Group	Gujarat	2026-07-21	2022-03-04	Cancelled	o2b6y134lc9z78sy2kzzjrs82zjfyg1rldyej8xlrsjt7b23pofkowniew98d1glokcszt
b0af6be3-9c84-418d-a416-6658f0e69f08	9XBQLUVYY62O	Hale, Patterson and Chambers	Rajasthan	2025-06-08	2021-10-08	Suspended	xdbi5zr18eny3kxghrctc1dgpbun7qqmttybj2ec2ij6ioauyol7wv2y4nsrozlnr4vy972qlabo0d1egj5aznxmqg3amd5on3swa5p0fka19v5xjfh9dynw0tmen7xjh0j4vwwlvqw96mnch1j84kq6j816xhs
ae95ca8b-5a43-4edb-9cfb-de1140713a29	BD5YQ8JPDIHZ	Smith Ltd	Bihar	2022-10-26	2026-07-01	Active	spf2rpcl8sdb3c7sq3sft
42673b56-00cf-4a5a-b81e-175b2e444001	XW6HMO7SY6JQ	Campbell, Dunlap and Contreras	Jammu and Kashmir	2022-10-05	2022-10-27	Suspended	sh5aetc3d00q4eawmd14kwmzll5p5kjli9iwfnrdulffwd4qu9ikec7cjp2iabjhrokv0qha87a8kldpi0yevyir8dettlp0417zn8d6pl87pna1sips9t3ut8pz36e7o0
15597290-dbca-4ffb-9d0f-fbb16d8c240a	PWSJSQC0QF5O	Krause-Baxter	Maharashtra	2024-01-11	2022-08-23	Expired	q9z53s2k7f1p5ti5c6fdo4g6f3gx83oab4okrn4160feo5d0bj21odom2umpssbgjjzkm5s6s0rp0id9hpxt64x0mg4f2y469fowyavtqiq7c56amgunz04p1bcdeqmanaj5wzhe28rawr3ktzslicdoaxghd40fs7f2ivikme1x6704f29yz4m5hc3zyxto1xu04
76859cac-d53f-4387-a332-c4af7b590e7e	G3QDOHNEC7LC	Anderson, Lucas and Snyder	Lakshadweep	2024-09-28	2026-05-24	Suspended	mzkjwh6fqkqpmsdmcc3yn5jvk6l3qvcy291cpnohjp3nmrzqc3q4w6cjimpniy6h25y4o7j5dab2ev7n9x99tg9e8q9pc4jtyeg6ijjaotbjoux6dbz7klu4jxpret1pbg089ousfrz9zni0qzvo0jsgrhr24fpexc3qdg9j07
6b75a17a-a79d-44aa-8791-2042d64096d5	H90MUP6ZQU7C	Anderson, Logan and Taylor	Gujarat	2021-12-28	2023-06-22	Active	v5mwf9sfc6ztm0t1a5n4qpk0rh6tkn5b8y1dw
a08abe63-e1ef-4508-b06c-fad123aa0db4	F1K9K31L0FQ3	Barnes, Wong and White	Odisha	2022-09-02	2025-12-14	Active	pum52rqelzsscgaixke4eqr8t38pcxd1y70dqoz779s7cdpyu7pwvjxrq6aaecpu6x5wyaeddbf6ohpdios3u7hyh2xx8vhwoqm2mp6dalfe5pn6jgv16tcxx5is4zecs3jrwgaqqx6ogmazr
05b196d0-f0ee-4956-b20d-d7c28355eea6	GRC7PWT1TJOX	Wilson-Blevins	Sikkim	2022-05-31	2024-05-08	Active	ozmonxtn0roeuhpgj7gxd6wmqbxqksp2n6dldk0ssr84piok27lpcu217iy7pfzy16d1tx0afhp
09077f4b-1c8a-4475-933f-3f31e8c85645	HETPKEJNUJGQ	Sandoval, Vasquez and Baker	Dadra and Nagar Haveli and Daman and Diu	2022-07-04	2022-08-13	Active	nro9u1d2ffbq32ogx017i0rqwip4zu0ipvnpi1xo68mgws3sas2nkym6e8fyxsq6c496ea3skow5540ppye6kpyxxp5g2c7o1n
146413ad-1e66-4e64-b41e-ee0a8b6d3c81	QGEUO6FNI8N6	Reeves Ltd	Odisha	2023-09-07	2021-10-17	Cancelled	nwscvznkliotmzj38yms9rx42zlj8069m07i5u0cxxoda2gxpf62jpyfd5sv737mlrtg46k0xfacyh67j5gli4q5hfbdxglnof6m5s5f1tca4dktukg6vk5ru8j6iofvrixtstlh7ku67iluvyzxwsc3vn561uvk8obo1n9l106q99vdpkh3944ufyrgsb
fb1a4571-a5e4-4cc0-95b4-3a310f894269	5DDW8KMKZSB6	Adams and Sons	Puducherry	2022-07-31	2024-03-13	Cancelled	ch30tr806nb9yxvwsgnrgsplvtij8u4ysqqyn1dovhi6k85vk8gvyxtis7vdvtd6k0oh1yseqg5be8wzbg4t613sweacirl89vrgygmfffscdz90md75zox7gck1dvppu94krrk8o2mzy2mokj4xwcsx3kf727uk0s2hhyqpku4i7q9h52el4wo85zfh0bl6r2ek42l
b670f306-f586-4a8a-9e94-19e8c3cb6ee1	0R0FJCJDX7XP	Lewis, Holloway and Rodriguez	Puducherry	2024-10-07	2025-08-25	Suspended	xl8k4pr9fxr9pd1fxl94w3d2yelxakpvpj6t3ok7onzi15unq5s5azz2ae7n20b5r97f608tkkqk0xggc7xdzaqkv5m5uqxvq5uv26cgcmffdy2j5triejba58al
6b40f868-7451-43cc-964e-881839544c09	EVW6H5AM6FKQ	Johnson-Moore	Odisha	2022-09-30	2024-10-19	Suspended	465o1e9r8mr89rwehm5f2w4232l3945pvuz5kyb9mkvt3j05k0tkmpkfw4ax888ect79ygod1dxhpnwacjg9m239yuoho7
a937aea1-da10-4efa-8f5e-b07f4f929ecf	7JBLVCI7IQMA	Perkins-Hernandez	Delhi	2022-12-31	2022-02-10	Cancelled	i4xo1dtjz2i7re16er8y7vwurrng8xyh2vnapgliac8o09akl877hmr9prj9129llssyk3tvb1o8c2v35s9aht3e150pp1sc68lzovswz1owiyh6lophzhtht6339qmhvoy0p16p0scz3n1iorbrjj616e7glrq1md92m
3b8bc856-a6e1-4077-b040-c55bceafcc3a	RP0YSF270YC1	Morton, Goodman and Williams	Tripura	2025-02-13	2025-08-04	Expired	43jc08al9b2xk1zlfhdqodk54xplmz6nqz5b2ets0j3glv1cbczqez9qu0ue2j
25471ae6-c153-4734-bb16-11881859190f	83ZLUEXFZC3V	Jennings LLC	Sikkim	2023-04-03	2025-06-03	Active	tiai89132idbf5m1dngjjtufl1wwf8ajcj1tr7iip4l7d8803l6sekv1so387fki6c8020ewogglwin4njvthwok5hgavhrp4jipi0fu73s94i3rcw6dufd0zpm
c2e5a317-f925-4424-9d8a-404f9eec08f4	DRFCOL6JJ3DV	Orr, Hall and Mendez	Tripura	2025-07-03	2025-03-30	Cancelled	iyawgnx2symooqcj5e1vk59a4cmke1ooyshc6m5cal3nvqcsf5kiexr2x5zmekhcpr
07c15abe-c4a4-4e78-8432-dc7fe67c80d7	QVS1AVMEP96X	Jimenez Group	Uttar Pradesh	2021-12-17	2024-10-13	Active	5y5nao5k6y4s2j4htx9rq67qmjd2w7xdyd6ni6grv2i64q8vsb7ho09xmitnhtce53n82olkd6etbqv7i7lyjdl11qmz9yrycskyolnkdldoysae5zyjnlcgwqr
09a2bcf4-5394-4988-98f5-2fc48dcd849e	M7H9VA9A9HSY	Baker-Beck	Madhya Pradesh	2026-02-16	2026-08-15	Cancelled	3ea8b0n9kjvgb3szqtdip8v48h51l7sge0jfe8hnkl6w0m4vsuix99ppxeq33fth2ymsjvgr7z2leqm6f6q6ht6ro60xq8rcymzbw2s7ojysehyi0xuopvh543acfrcu4uaxc1oq4z0dkb4q2evmhz64n01frliumhuy08vkr97kpacpz
dafceb61-3c54-4a1f-b787-deeea116b324	HWTK8WY3L4A3	Martin Ltd	Puducherry	2026-05-04	2023-01-04	Expired	0mhwtl2xwinhy411t9pyr09apde6nfrjavnkysu2nos3v43tpzvdi8xlhcb3524zzis7qu2qp054sad9qb5ynxdyzildkl7hpt
aa30e720-5664-4ff4-8faf-50b04bc38281	RCHKR3DRIG43	Rich Group	Gujarat	2022-03-30	2025-10-21	Expired	4bixmyhgl2ctfqlr879kxf8wkrgw1zswy41ybivplox4bvz3dq4rphvw1zfqm0sh0j2md8s
5c4b92fa-47c5-4fd7-be7b-2e296d0da85a	LB6Q19VENS5R	Jackson-Leonard	Rajasthan	2022-07-05	2026-04-13	Active	wjj8zejojb10f09dxj8s0q6c235wxwolxrgzirpwngf4d2s9t4psh04203huwqjishq3iba1298bn11n02w52gv3cc209dh113qc1ji5svga436rm1bxxmuwut
d3da5181-130c-444a-aa92-3cf321b775a2	Q8KOS621EU6S	Perkins Inc	Manipur	2023-06-28	2024-09-06	Active	sygbhs5udz0hf0k4xdfm2y8tn5uo48zygseylysny03
1a321d08-b3fb-4bc7-89b2-f1fe2a640d2c	VI10G1VU6454	Moore, Riley and Underwood	Himachal Pradesh	2025-03-01	2026-08-21	Expired	b9jzw25bvhsvo14b8vaubjzywz1aehlsmefo73jvpsp2qg4k2yxpuvcqc71mfkogw6ft
f2db7902-83c7-4bb0-9eaa-61b423212375	CZULW9QV60UJ	Martinez Ltd	Lakshadweep	2023-09-22	2025-03-17	Cancelled	65ywn8kk3xtg9n5szrym4g32um61f6w5r2mev2utuuqvy0b65ibrblb7gy7ydsnwnu2t398b1qz0ozclzicqs5g1ng17yc1wc3wqbqcgvxr1gsevjlwh82qkjj84qscrcbtamhafn1khq5sl06e
5dd6ab13-c888-4266-a63a-10d3c243d75a	4QDUWHWR58J0	Duncan, Wright and Hardin	Telangana	2022-07-13	2022-10-02	Active	3v3iefw89wg94u04uozjgihp26ga99gk6ju36grfetufh3hrz3x2w9ghnwmmh8n3vjb8eq5qzsio0qat96gc
552eea2a-ee6b-4018-a7e8-366d1c45b85c	B83VGRI1GETN	Edwards-Keith	Chandigarh	2025-10-18	2024-06-15	Expired	7qh1kgzzgdgkzln6f24dhvherzqv1nahko1vhftl4agsl4d1otzmv99at5efd11hg1z6nmiqdaljneh1qpbsuxaiaoqqmlmlx9z3ij0qy0xvkeqf4hmi2frwjh15xz4zwa58glbeehiufhoq2v5jhho0k8n1r7v5n8ld6v6yuk4ihzoi1mb21o35dk6
160a1f8e-363f-48ec-b637-d187295062f2	RO0A9CTJMFC8	Hicks, Schwartz and Webb	Andaman and Nicobar Islands	2023-03-02	2024-08-20	Suspended	etygfokt36eu7ikl371yitncsadq4nt26l4tl58lmus6x73mzrisx5njav4b55r3srpsk79saac27goz0s8vty2ws7pjnb1m5kde6cv3
cf246d7a-35c3-4b62-bb30-93e4f8c3abfd	P3N7VDC5VISU	Hoover-Black	Karnataka	2026-04-13	2024-10-23	Expired	19uc0h3ph89trhu0lpg1qxwhaer3sdo5p1kl12p6j5gt4wrt3v6zhhbth4j1w8i5ymcjvyoeau9vmkd6u7wiyx5w550z1xi4vicnset2i69gvo56rb2ia3x4q7m2mxn9uozv6iwk2y2vr3jj2t54aq4ngi7usqhb4tk9jui80p8x90ql9332ciezt8sk
a94f123f-54c0-473d-b79f-f9da73f0dd61	F0J2YUFNK22Y	Herrera Ltd	Arunachal Pradesh	2023-06-23	2023-05-19	Expired	adp56zi6vjsx1x2z3q4p2mmediokt7mtzd3nsl4d7o4sr7127mkgp83vdl6hgekadl184zgiq955n9441stf2ahvlsvfiw9k8wgkrb
e1daf126-c9bd-44d9-97b5-946ee135975b	M95ETL4JAFL4	White, Hall and Webb	Andhra Pradesh	2025-03-27	2026-03-23	Suspended	5skg2egj95pta8uu
79edc592-d6ea-46ba-9821-84584d2cce07	MMR4SM56OLKV	Bates, Campbell and Levine	Himachal Pradesh	2022-03-11	2026-08-24	Active	gkgxjukkd1q0hvvduzp6lxvglw975ml8satzxwvn5w9mgzm7wq15dmdwcknv5r9y2jh3nf9jfnk2bfllpumrahiuprtcbujyb3unpja4j0lsg62cikczxwzy1bk1gg4pw8io17qmzuo5i1
fdd355b0-3fcc-4c89-8119-7081da3f2606	L5IJ1AMUEAJZ	Whitehead, Martin and Gonzalez	Dadra and Nagar Haveli and Daman and Diu	2022-06-02	2026-01-25	Cancelled	5kteclui431pixsh6x9fkq0w6c97czdjenuq339731hjnipaj6tjti3jz16otuktsfimvpd720373ga9kn1wh2kft5dvzk4je7d1qd6qeuzhwf5zp3h3kjx1i3l83xi1owgnva09cthbwm5rwt5qzos1ns3k1biashtaz2bi14py4cskwb1
615b1564-3f09-4f90-8c36-6d866f1c8df1	PT24I38OKN8C	Johnson Group	Gujarat	2022-05-27	2021-09-22	Active	fpxeq9p9jr00tg4siwfb0gw0093eqmoum9m30abh54ctl8pt4a9oexe06rqmr676
3ce36b2b-85af-498d-b5ce-03ab7f33fd47	CKVQIJZ5O7GC	Short and Sons	Odisha	2024-01-29	2024-11-15	Active	4z2uove9evfxrpz8
d2f949c4-fc79-472d-96ad-b20527b52cf8	80L22KG9R5TB	Brown-Saunders	Chandigarh	2021-09-12	2022-06-02	Suspended	2hcu48r4dx233a2kbgtab7zzp8trzpmaik7xlhgq3grmkxu9ljyeq2oy9wgoaonk9b7l8zhv8b1pg55bsclvw58q6guzsj6o5z18vuqw7jy5jf85pdvuhog8cdrjy1szphqrra
fe015160-c048-4acd-9858-50cea6b88a75	HZ4WQ8S0GKXF	Morse, Hernandez and Petersen	Gujarat	2025-04-26	2024-10-07	Expired	78d1zsmb07zn786o800p99eikxe0r3cfwxkrognefv56g1d7wxyq2t1zkp9fp48sd8x7enmzpeculvaaorfwin2qlzs1qeyywgf3ysj62eaucfpvk8gd8gh2g7ov8jl8ti6zi5ul944bz761taj5qgm4iscquqj7tvvuts
dbf591ab-564a-4b82-933d-dc8893df61ac	KA9XJE8B6HRL	Higgins-Miller	Kerala	2022-07-12	2022-05-23	Expired	olnvwmka8cgwtuf7g5j8n0ch1ymodwl2cbsyt6rd1ck5engfeqckpo9up7x3lak7bwmtfo9ay587p9f8c5spvb6obl8e0enz8hytg8qpp0ddu5kvv64bmtcr8t521xc6xmt4uw4s9g2hy9upo9ag8d34hji90gc66v7p9
6ac81419-b259-4b9a-81b4-224fe97795f9	C6KJ1OH69VOD	Johnson-Bush	Chandigarh	2022-09-13	2023-01-03	Cancelled	g0jw7aw1knlwrzpuyo6gyy4sxgr3o8bcy7s5c7ex6v450e7v7ngcv58fkd4xwyzks64mcn3jmlj8t5p
97664045-9dbf-4811-a680-ebf46006a42b	PE84W1FPTQNL	Merritt Inc	Lakshadweep	2021-09-16	2025-01-07	Cancelled	567b4sq05tjxsnjfa4zt2ss3mgd10vaujfvyq6jxteh2n7h7pjbvf8cxwl6ry14dk6bq5qhy50ramkf4nhq03d7n
38e47130-2730-4ad8-b44f-0ba591fb6536	EV8WBM5XZG9R	Hanson, Lynn and Montgomery	Kerala	2022-10-12	2024-01-16	Active	vwh678f03y66za7jpi3gp3v7daoqarfni0nkh9ki03idya7wsz99dwu4wig9chcg9podzp1pw6e3zy7t9jxq57oj1qad9rpaptxgb6qg3hblwmyx7uzzau11fwr8teq4l8w81gfb3e42na23twfdvc6n3v3djrx
baba908a-40db-43bc-92ac-38259432164f	DPE8D3FHNC3B	Phillips-Wolf	Kerala	2022-02-21	2022-07-26	Active	9jcxydo0t9j75i0uy6ld
611dc8ac-ee09-4c21-b2c4-8fd3442007b1	51IT884NQNFT	Conley-Frank	Nagaland	2022-02-09	2026-01-22	Active	9org21l5qm4h57rquebxhwn5uphrvxj5j1p9jnez60haaiieh0w0ldgjlih388ky56u5bd1pbs9py0e2jzev5tmz6w1vdnmh82cyt0cw428rs5yet89tc366x6x
3c418b25-e133-4d5c-ab08-9ca9823f3146	YIJJXDY3KSWK	Wilson Group	Telangana	2022-04-23	2024-06-04	Active	17tq0h66rb5a93qk8tfqqvyltd5uhjdb6b4oj7tq9jge3ary6rux
f9c735a8-c66c-4863-89f2-2d266094fb73	J28A48SO3H3R	Black and Sons	Tamil Nadu	2024-05-28	2025-01-23	Cancelled	9lclez1etozyjngt85qal8e74xqygpqpv8mg7j2f8rjoptne8jnn4ba2rztaqvtr32n0etwurdh06vncq2imzjj1
fa54a868-f7e1-4a02-b27f-49e6635dedd1	YTIFRAZGGLTI	Bennett PLC	Jammu and Kashmir	2023-03-29	2023-12-29	Suspended	a562nt4xm03uamvm7zkcb4lue4nymcst6cuzevjkwnpakhcvyp1u1nng3hy4cih4el3ig2iwlzgnjpmrzljsutziwvub8
917a2334-1a83-485d-b39f-ce06dbb5d966	JM9ZST0KPGVI	Orr Group	Lakshadweep	2023-09-23	2024-08-26	Cancelled	4scslxn66h8p0wdku10xnl8zcm2mpyj5r9hkqfct7n9wpeliwdetgtyo06xme3xwrmpq3vlfocnme81926jdluvt1qn6hlt1
6594405c-815e-4030-9ae2-ada9a478455c	TOX6TVDAJENM	Williams-Cummings	Meghalaya	2023-12-02	2024-07-06	Active	u01accf4bi7i3fnzun1mjazkmjef6njahyj26knddn99
7f80c9a6-df02-41ad-aee5-17d41192e69b	UVSZLNP7SS8F	Vega-Lee	Andhra Pradesh	2023-02-10	2022-05-01	Cancelled	dtjso6mdwu0h0jc9pbkk74lusrohid6zifsezakbwu2gkwo61lxlv5bvisrwfz28kum905gcuez2mmsqwqer51wnrqjdf1oc7su5clkv52kt0ywo9zn0mdqjng8hd6a3qh7a6n0c4yv
da98175c-618b-4861-8334-232fa448e9d0	XQRZT54MHI39	Strickland PLC	West Bengal	2025-03-26	2026-07-04	Cancelled	w4dy1vkj2kmwjlwapheczke5es5so17z6274daies3vvrgsbnfewwgjcdrcuzj56oal53mqatezn2jp7y5jik5wbypsnrf5uff7nqrt
9a729467-e6b9-447f-90fc-6eec50f02b7f	DRNYH8X1EVX0	Harper-Jones	Karnataka	2025-02-14	2026-02-01	Suspended	hs94j06tsvy4bf7u71bghb1gu6grg57bwzhgbilcuqeaizv8x9mpwdiup0sld
e03a0688-300b-45ce-9329-ceb0c3b81bed	8V8JL64B2XH3	Salazar PLC	Nagaland	2025-05-26	2025-07-01	Suspended	eq0sovacvo91wuv96q31rz182inj6pi1acrfjw4veywlt7awpig4rz2w4ar3lkk0u9brh125zioqyvgjbpp
c1cebca8-43d4-4dea-9aad-fbd290ee699a	T7P2ZLTH71Z8	Morrison-Hines	Uttar Pradesh	2024-09-05	2024-06-09	Expired	mk7ua7k231eebi9ai7nkpul5yj5jtct9u4fafkoau8ruxt9wh6hjgt0q8c2p4lrsyhi3biuo937yle9m0f0ug84q7t1zx1sd9kidpxd469ikx
2ec27ef6-bcab-4d12-a264-df79fe2941f2	2WWNBKPSL9JB	Green, Ferguson and Villarreal	Assam	2022-04-29	2026-01-01	Expired	9jq9fph3n9l0f9op0pcidne97ygxokhnmsprm8hn151oabl2j26l8tg19vxsba2mexi6vca4y0du579ebd71i4775abhmvr9ijw5ikn43dwagku7ohxjdwlpeqjebg7cxtri465jpn5747yc4c616govoxndil3vpd0vilrvj0uf4cpuccbo5dhmkgcwcftqt0atqj2
c76034fc-44ce-4bf4-a6ae-0e7009e6c766	XFW30SFHUKN8	Hatfield-Gonzalez	Assam	2025-12-14	2022-07-31	Cancelled	mhxy8hqpnss6fue
edb7dd1c-8380-4c76-906d-ffae1bd3ad40	EMG8Q2G3K3BB	Bell-Hendrix	West Bengal	2025-02-19	2025-12-31	Suspended	5hdyk79ukv40wlidaok986i566o34x9sm3ke0yeveb3taugz1d9v24sf2eqckno0407ispwgu0x8jsetwbyv3o6zo4vq4cwhr5ohtbeskbwc35khe7dfr1c1taadvr
1da4856d-c651-4334-8ada-3c736d9337c0	DB4ATBL7VEOT	Murray Inc	Kerala	2023-01-26	2024-03-09	Expired	rdkus0lt09cd7vabbog4z26su5oyz8ut385wjjdi2vyvplcc5rkj0pj0yqs4jmctbddrjm4oaamamja91e5iy0twhfykm90chi8epv6n47cz8a8bgzluxb3q25zctpflzx3pl6oe9vycolvwt
23702498-121a-4e98-8f51-68a33927527b	9BGDB8LJLWSO	Collins, Adams and Weiss	Chandigarh	2022-02-19	2026-08-03	Active	5orgchv22bl4cnh8132cxay0ae7cr8bxz00ewood467ln0j04oonoqu8lo5bwxq7qthci3abfwf4i0nexi3aqxc3vrnyrj5odj2ujncmcn0ih8e3wh1sfa
b7866358-0b89-4eb0-8593-9213f242943d	WY3RQBA3SEJR	Mccall, Hancock and Tyler	Jharkhand	2025-08-20	2025-11-21	Active	m8a9vmc7qifzc2agi183on0vftf81fzyedmmj5hjuxw7mfps010idvglq1zppvmckm4v139wdcakdn8xqv0py2zmrxelpjxktf9hfioc6m45
fe426a5a-462f-4559-8ac1-087668230811	VA49KM3GQ1KE	Allen PLC	Bihar	2024-04-16	2023-12-29	Expired	89rgvsp1kvkghvvi410823ada5hbjg4kl3okq13fz3qhkytyfqq6d953ymi15m6l8ph986li1uz73n6w4p9xnr2i9n8o35k5vck41q6jx14fhwka37gertkzv3cwj00b3by5f1
ef26a252-7634-4dd8-8ccc-65a4bd108511	IUXUNC1R4MM5	Washington-Phillips	Maharashtra	2022-08-12	2024-02-05	Cancelled	eejzhnqy77j2sz2wq1mrk55qbcz01r1mebre7u25iu67n2sj0qbp5trp6u2vux4dksdo4c71vir8joe2orwa
f0928f35-4e42-4aad-9103-0525ebd581db	92JL849A2IR0	Rich and Sons	Delhi	2022-08-20	2021-09-06	Suspended	c9twzx19fssp
5dbd1504-4bee-4302-877f-62338778c004	GD3F5DH7GEE8	Ferguson, Williams and Young	Kerala	2024-01-24	2024-11-02	Cancelled	skgljzd2u5hlwr2jhk011zmu0bb79mjjb55kqb3ufmw8bkviwkfmsuy9gg6me99p599648a
754fef53-20ba-4b6a-ab5a-a9ff8a146f76	NJWYD89OZ1GP	Clark Inc	Andhra Pradesh	2025-03-13	2022-01-25	Suspended	h2eqe53bseen91wyx9r9bqgvbsn8qr7yz80adot6t8zprpwxlukty6dyap9sw7ic9k3jpyi9iob6vy4qaazzb8miwn0zp63nbm7pbf88eu4ucqrf0zv526lq7nsd1bqnm9p86796ag6qk0g7tkzywuu12yx1rnwwizhh3r63rtkqnb1pve1k0
c6c304af-9b0e-44e9-aca5-0eb3570bbab2	6DRO3I2TYQ7E	Lee, Kent and Gomez	Chhattisgarh	2025-04-30	2022-08-01	Suspended	vbuz0icjejkycs8zij6xdlxptydug15j01bbcwynd89vulyr65efc9huiphd4bc1ano5vhhdj
5f72b639-c3d3-446e-b617-d93219a8bf3f	SWWSDT47S39N	Wells, Collins and Nelson	Sikkim	2025-05-23	2026-01-13	Cancelled	s8gl9hqq3nyjzm1hm7mxxapc25foconlkxjy4y62v8sggz8ztugj4gd9kkcl7powqd6ov426l5k47kkj20lbxg30bli01i3kanrgrasjp9yywaglf1k824u9ams5kuckh6nld2fog1ixyvjyif2sbuk4bhwsnrebejhnxtgre8
8720c267-7c57-45fc-bcd4-aa9bb8629ce0	G0KHVPJ7AMEC	Galloway, Coleman and Mccoy	Punjab	2025-01-30	2023-10-22	Active	ybfbp958mbli0qpetxg2cukaa0gy
8836cfae-c805-431e-9b4a-3b9417416298	YO6075S6529Y	Gardner-Meadows	Chandigarh	2025-06-05	2025-07-04	Active	7ctm0c4dss0wdx81a8nkmroax5v59erxfj0
ec8a1b01-5750-475e-a15f-d460a6e96d9f	S3WTTWAIATI8	Coleman, Hill and Kerr	Arunachal Pradesh	2024-10-17	2025-04-19	Suspended	vktiqzqmm4eptclkxyabf4ji8o34blhz212qdaasrmpjn2xby6aspyi055r0deiu0so9urf90dcf2qffjt7ourlc1hqpo9odx5732gv9zudr5mz5e4p1otojs5foear44b7
4f62b54f-62d1-45e4-b4f2-e5d67001f99f	5H1N5HRLYQZT	Jacobson-Griffin	Andaman and Nicobar Islands	2025-09-19	2024-08-06	Active	1ufykpa3ww0cw7q97l5p73o5i2ivrkjujj6a7hsi8mm2rp7mo2olbfxxk58ganswlvuifepgpdvjkuydrtvotap4v7hfn4e6qodse9c2bwf4kpz1gwi39bcqrydnhl5ftx5br1gq3wpmgqsmzj4l0v0vij6cc41kf8426u8y
1529dde7-2e11-4d26-a71c-8ee89baabfe1	8B0S66N9QAX9	Alexander-Padilla	Chhattisgarh	2021-10-09	2025-08-29	Suspended	g4zw310ggpn0arhinjerpxibzx5e85brj65ddoxxlnr3lc138rfpbnjd0lbfd7u0dd0t81z67h3zlk8wc5onnnvz3sa1ehxfyir7vthxq22
41341721-d33e-4b75-a699-43067e062ff9	MD8PYE7XIJOW	Winters PLC	West Bengal	2024-05-14	2024-11-12	Active	cpk01dr4dk9g9559wr0bxwljos7e07drk9fybl13v2sjt3jp
fd2a69b0-5fbe-4189-b6fc-f05477b26679	YHRK2PUGD5RI	Willis Group	Madhya Pradesh	2025-08-05	2026-03-16	Active	7l1lbove2gy7rdj3con6gk17nw5m0n2lh3xmuxrkhr3zh7zlqxba0du01rgj2gfvb5408izzwafa29b9m1n1p1iof9iryjpperhcn0opkvm48jd3qnvm7xdwz4lw5mexkevdzro3gisk
40bb5b6d-79f6-4ed0-952a-51724c6ba041	9H8Y251CK9FO	Hutchinson-Forbes	Haryana	2022-03-31	2023-09-30	Cancelled	78ae59xeezhqwwxukgthhm2e6kcoyvgwnvjx31advdntgsorvhtjh1be6x9gz0gokxfpbvoilyaj1ho02g0uqg4omubrosj9enxith1m0x62f1
f4ea0aeb-236b-4054-a505-c852aa8cbe96	6INVZMJ3WAVN	Warren Ltd	Gujarat	2021-09-05	2024-09-19	Expired	24qjs0wgn2zli4b79poqa94jx0yztsgsa7mbmuv13jrtry7ygs3
e966987f-e52b-48bb-9eb6-92c9116a491e	XNOJXXQHYOTG	Shelton, Ryan and Harris	Puducherry	2025-01-19	2024-12-18	Expired	fwyycy434icjb1uiit5cubih3anignbk9p7rypbj437zw2p4a5eumlqy71sjfsmd04ft33o0hxdqaix1ptooenj5knqih0c1pwps8nikst6wa0
50828e01-77d9-4654-9b3c-d33992bc4148	AUWSZIEQFV0L	Rogers-Martinez	Dadra and Nagar Haveli and Daman and Diu	2022-10-02	2025-06-07	Suspended	qiehmi00h42ug
02f54fc9-ca38-4aef-8abe-fdf127aa0f33	GDWJ049TBMCQ	Holloway Inc	Tripura	2022-07-17	2024-02-18	Cancelled	o02wwu4p0llpeno7ndblmyfcdmz4f69wr9u63ywe1q33a7ixc1xg41k4swktm2imws60asmxr56b2etb
f259b6c1-8d58-47dd-a6a0-dea6a367629d	XWASJ9U5CKIJ	Watson and Sons	Uttarakhand	2023-04-15	2026-07-26	Expired	7ag2nu0yl32coeys0zsfnzsyylovukwkowe24s237hiusuhffv2x17tmn7ls9xmx49w1lczpx5q93x6panc8lfpv9lt0c4lwv5lpbco8an3dh40t06p52dbbl50mxah5w4l74zh4s81naa348tmxsk3xks4zdotak8e1
05e883e9-48fc-4ad3-9438-468cbd3d7d32	CCM4I4WXDOYU	Hunter PLC	Delhi	2021-10-08	2021-11-30	Expired	jspshb9fji1z
40a744c3-0e75-4799-af7e-b8fa5251816b	DIOW8VHRWJ7O	Villegas, Brown and Jones	Chandigarh	2026-06-24	2026-04-30	Suspended	ve1ctyfm745zmztxsgaif6fq7k8ixpb13vp1zfk2l9jtxqsczy0hhf7hifvvqwh0e9guiolezjhjebeg3f7s2mvf0sijq99f11tzjclv7cc2h05jp4n6d0dglef2zspwh
9dbf4320-6c10-4e0f-ab8e-280b2fbae384	I011JSSAJ0TI	Elliott PLC	Chhattisgarh	2024-12-18	2024-12-18	Cancelled	4ktz777b11wdfahtadttbkwt9lcwrev
88e2ff45-736e-43fc-9b0d-622a85d36d85	8US5DR5A8H39	Johnson Ltd	Haryana	2022-07-04	2024-07-02	Suspended	vpy9u718p7poh9t1kwwz22pl7r9nhfmtmg95sjl5a9uhqpn7yp78odmxa5qxy43dsmquhd78o4zd1i6hc3wgaw526wstxqg5zeij46y0picf91b7mxmi9g7hrewjthwg47bmz4gri17ehmp1y7r9fek0hstkufszz19dl5fkjvt8bve45hwxsr8v6w9iop4
8a9c1e8e-f91b-47a2-8178-ca7ae39d1ed0	OKYZW01X6QO6	Galvan, Wilcox and Parsons	Assam	2024-02-24	2023-09-12	Cancelled	g0ssgo65hpkax5e8kjrhrdkap75n4wyvb9u6hnf6tjqe5nmz4zodf5srp0pp0782b3hspsgy1psaevdqj0tpjoi34gs1f20e86zze7vp1u9ytovefs0on6rf7fggm5bdqphmfvy3d2ix3ybr79dgbkn5vqmfvxm08y02d8e
6fe6fdab-13d6-45a1-8eda-0e7adb2c3378	DZK3KU3FI68H	Williams, Stephens and Stephenson	Tripura	2024-12-23	2023-02-02	Cancelled	zk9flwqr7zulrcm0da
d1ef4be0-fe57-4aba-9764-a43b0b7892d1	GP8SPPBW0UZ5	Roach, Green and Kelly	Assam	2025-12-07	2025-02-05	Suspended	x4huysswqqedb8zg0zlwnx318nw57uf22bd5sa41xr5o6xt82p81xz37b7ub0qnwdvz2
8f46a12b-a6e2-44a0-b7a0-ada77755014f	5SXF985GPERP	Fisher, Fuller and Meyer	Arunachal Pradesh	2026-02-21	2023-02-14	Expired	w4gk3sanh5vph0i5vb082qplqsqbzy1mn3i7xk4sbbwrnb9cc0xqo59u3tm21yw9yenq9a74u3b1w
fab9b410-291d-4163-927b-c56dc22687f9	LXWHOLS4U0RL	Keller Ltd	Andhra Pradesh	2024-09-18	2024-12-10	Suspended	xcm44q9n4kt4i12xruenu6whqaq
83b9fd44-5c7a-47f4-b5d7-147ce41ae46a	VYGFGT4T5E68	Reid LLC	Ladakh	2026-03-07	2025-02-15	Expired	29g813e3lycjerq82oi8pzk8nszvljnow0o0ettxekpp92bken8a7fkaiwhp2g2d4p7o3x7p5hyy31gdau4abej1w0hy0e5a42iob4et29a34nq1l
2b50d495-f6b9-4cf6-9352-22875a59c69e	JFC73CG9NB21	Garner-White	Tripura	2026-04-29	2024-03-23	Suspended	jxtmslr3xr7vpf3ub3impdco0kjhxkiyg9qwzccqjc
b519c5de-96fe-460f-9583-261662065296	4U22XK6SXI52	Wright, Shepard and Poole	Gujarat	2026-05-27	2025-02-04	Suspended	hqw6dx06br80vstvfunu2p1hszf23iuxiw2jbe0uq6h5i6vb9q41jr52omau1
0a0a8233-5fb0-4bdb-a0f3-ee6f7b82692c	5GNTIVT7M86D	Martin-Morris	Arunachal Pradesh	2024-02-17	2025-01-05	Expired	yp4ryznoi1jbvrp51pe91o9roqrmphiat8vmppwlzxcnfwisoe7v9ghk5c2
b325e2fc-c4be-4491-9bbc-fefbfb11c216	EF8RMRXW0IGU	Peterson Inc	Uttar Pradesh	2025-03-06	2026-08-09	Suspended	mukltpha8hqyums6fvq7qictqej6ipi4olxvn81lrnr8oex0s8awjtpr39dzy5f176nou1q24scs326z325mi9j7z05e3cdm04enlkkpuvn392p
e591755e-838b-4032-92b9-654c8e5affe6	Q5NPHEZO71CE	Hartman-Ortega	Uttarakhand	2022-02-18	2024-05-03	Expired	4o6d3akqpwggy8k4x84tx2vyxr932qczqhud6qbbxv0pzcixtntkubkowz60rri4oz8
40ca6ad8-753f-49b9-8dd9-647ce7eadc29	X037RRO2TNDT	Williams, Ruiz and Hernandez	Andhra Pradesh	2026-02-06	2023-10-19	Expired	0g8e0nmpvg1dvkt1xovbdslu0aznk9a2492ia7nj0fsm1euof0qj9sikgxdmmy41td8jkay9ovqdg1wy7aesfnbhabjmd0llx324dtk4d1cisgz90djog28k5y8pdffm1xa96iek02ivk9mks2
4e4e6839-6db5-4c34-90d4-d257765d0014	XURP47SH8YFO	Hart, Padilla and Larson	Telangana	2021-11-03	2024-11-01	Expired	7l4fn99v2rau2gumxmdntb8ik0qfkoim3ogelo30fc79zqtbd6x7rtdc1a8xutoenxoq08k9jk9i44ogvpsujfsrhqkx35rm
d9c25b30-3df6-486e-b0d5-a433e07d039c	85KHR2J9UR22	Thomas LLC	Gujarat	2024-01-17	2026-05-07	Active	1g72zejquqwbjqfqq76cps1ejdsk61pm3oja45o7sj5wyk7zbnv951yqkb71v5doc6ukvndf2awvc2sjv70tqz9zq7q3ejkcipw5n1vztfi3eqlnsru7jcwfacy4byzkl2ymk1agkxcnia52do66eifthdx2as9euiqiu6vz8ji194q6rm88haohz4wn
489119fa-ba5b-4cac-9c44-c2cc151c4591	DFA7EAY6OOJS	Smith, Cannon and Miller	Punjab	2023-08-14	2024-09-06	Active	0qcgp9l4oiwwuox3mzyxdffihj1lh1c8qfsnbdyrej4ugq4ihbgyex9nr20t8jhxauz3oiqpvgcgogrcgwzgi8bm3ufhpopd4q7walzeejog7debyjquyi51u8ggechio
8884b065-facb-46ae-b885-2a55dbcd844e	TD4ULHJIM27L	White LLC	Goa	2022-07-08	2021-11-12	Active	ae65ohbptls8cuoe36rk4egjs9eof2lgpdwvbsodo2vuy2e7hxpwztfgxzop7q5f1ugpaa1bxlorgx0ed9hmp8xo4wbrwpx0k2vxyey53kpcd4vnlu5n7atrvvp89quipafejqi20ooy
b1ae9a9d-b900-4d8f-9adf-8a461194f520	WZYTD0MHE5DB	West-Jennings	Mizoram	2021-10-18	2022-03-20	Suspended	53rxooedhdzouu0fru6ehz8iu50gvpcxzn178o35k
4abacbba-120c-45b6-8fd6-2d6d44fdcd0e	ZBMLV12QVKRG	Richardson, Evans and Dickson	Tripura	2024-08-03	2024-08-06	Expired	vwp8n5c3yfn7opx9q4cxwd6s7gqzqyzt4eeehhluxpiuja3zfw475gvulp0im46o0kobmqqvxm97kr904qfxbfz0meqsm3p4o8ms06ewl3b9v88vibq1fpg9h5t8bkdq8jhxblruev
862895bb-f555-45a9-8ed3-4ff93be80a8b	235CPAU9YDAN	Cummings-Martinez	Madhya Pradesh	2021-11-12	2024-06-08	Expired	phdh9ev54dujz5nc3v7iw1emkbkiycpcb1lxbv2x0aezds64lr3uajeobmkxfv4e2tz
fc2ef3f7-9aaf-40b9-b518-fa04f391694f	ESJ960PZB7XD	King, Lopez and Sutton	Chhattisgarh	2023-02-02	2024-12-26	Cancelled	vt7j7roxs1i748y3803fc2s1q90kggr2uzffdvzrxt1z4t2x2lbofscrbd1c3aqvxuqkz4ducrasyx61nj2ywqhroo21dr1x
3ad7f84b-5f7b-4a51-87b4-41a79a5e965e	4ATQ7144APO8	Meyer, Simon and Scott	Andhra Pradesh	2023-03-03	2023-04-03	Cancelled	gbbg60sky53p03imc2dykix0mg9295pab3g9mhelnm12b7ma0uwarxi1ano6nuxi6xnudrnit83mfil1sfpqv3q4eg2ayu5qoecxe1jf183bvi7wxkqcpym7z8xdpi71z73hpuowabwzsw3m2301417uhgqt7db32eq9hlw4hqijmksg68wa26xqk73ehjkhr5df
7e6c6ecb-e3ba-48da-ab13-f867b08fd956	I8ZA9PYWOH7O	Washington, Flowers and Olson	Andhra Pradesh	2023-08-03	2026-08-16	Active	lglukvwbvf3791z108sml96h6gqvjd9g23x1mu5wmpt3xp7flykrxy2w5cd6hwqlxl1qbua14x6lq8ihbwe3o4
b94e7823-6dce-4e91-9f60-b450b9cf31ba	CQVLMAITLI6H	Richards, Brewer and Fischer	Uttar Pradesh	2023-02-11	2025-11-25	Cancelled	swv32i2c0424rva
3dc72fc6-5e15-45cd-8a1b-d7418097d978	XAEL75FPQ5DU	Livingston, Livingston and Taylor	Bihar	2022-06-25	2022-02-25	Expired	f656sw6p1ba0kp31oqgas31ii5ed8km401lo1eo8tw0gmceivfw0807hg446kndbnodtoq5kfenax6zqi4ngce3lg5rvcxm6jlezwo
ceb19cb0-9e0e-40b6-ae16-9c120226165e	2VHNE65IBDJB	Wade LLC	Tripura	2024-11-18	2024-02-09	Cancelled	5u39js85vwc3nkrsraz30xbzig3uyqbq1zode30njtkvp7ld9nmq0auhq01euuy568c1yhtktyyrvsapd
464af41f-f485-42be-95b7-63a42776626a	Z0K3V9K8XGMI	Gray-Evans	Assam	2022-04-29	2021-09-08	Expired	s64j8wt70bgjt137r9f4rhqv2kgw0jgciajhi87uggixnud3q4iam0y9sphpl9vrvj7o28tfm1hdy72klf88m3hncqqz9m3hbvumszo2x02wwdht33bb6pvybl8
4081f03f-8fff-4dc1-8cac-3f7f9127a8d6	QC2WZB5WDDCI	Ellis, Jones and Nguyen	Karnataka	2025-01-18	2022-09-14	Expired	spjzzwf9jyahm0inlzkg6kl2bxq7mj9ih9l83umhtouo9c1jm8b1fwqw310vyi8phmdyiwv5k9sw4w2hbm1c3q94cb80st3g7pb93bwrsckqcn4kclqwkz5vqdulewwdh1wmm34snigwl4uate5n9rb010uy80vk3u0qcyegflsgg
033f0379-815d-476b-9d35-5198a4ad9162	TUMBOO1JCVSK	Wilson Group	Telangana	2024-12-14	2022-03-07	Expired	emy1hrho2o7x7un74k4bb7qnjpql2epbzwl2meatidhazo0d53qwmecplh
80b93ec2-3bef-4aa9-b05f-a3cd2a024ad4	KX7BQLG0Q099	Bowers-Coleman	Jammu and Kashmir	2022-12-15	2022-05-03	Expired	5g6athxfhn17diws0h
7b8740c7-5bcd-4c65-a4cd-7a088f9cf85f	ZIAOBA6LXTEP	Neal LLC	Himachal Pradesh	2023-12-14	2025-08-26	Suspended	rtvvybod0bslxp8rqbht1e55mbzdchj1krqxoz8i4g4c00kar9qojffq6rjsq2or6j1v5g8venujbqebmlu4j3vp88sz
c38fa1fb-987c-44d9-8748-a38fb7084234	9XO389F9NIDB	Schneider PLC	Lakshadweep	2026-01-29	2022-05-20	Suspended	81d3og64nramj9uwxgi47plcbdugwisw8p277sa9usu9v82curb2ggfh3bvw5kyq64qt4pwky6n9xt7jpo6uzbrmynuj5jwpzz6xgegixznpyqbw13p4eswotlehuq4pem
b4f84f3c-a5e4-4039-a9ab-17561a918f56	JO0OXJ4VXD9H	Phelps-Simmons	Maharashtra	2026-05-31	2024-03-15	Suspended	rzec9mj1qwi0cz5jve95h1tzzjyhengheihlrtpott9odfh3f7domrlijhqhiqv07skchmqc6gwlseir3mdppiptjd5opsohjox04ynznpfb1uclg9l39r1epi
124269df-3296-40cc-a3f5-afda93f32c8d	HF4T7243MNY0	Brown-Hampton	Uttarakhand	2024-02-28	2023-07-05	Expired	vaex8q2dqa8s95ms73jnhbz8xv63nc98s0soz4bwe1c7is6wh1y3cif4dt2yol2n5a4pt2fdu7kzuqsopk
5896ea6f-0a4b-41c6-9c20-81a0ed5b202b	3MMTFA3IJ04A	Marshall, Barnes and Gross	Uttarakhand	2025-02-10	2026-04-05	Suspended	suplz8v73sg8lo6ekw09gt1l1ktt1tk2odt40hktoq5xxh6c1bseezbp1zttm0qsqtrjkw7itwboxqfufwgq8bbyes9knkytdqjyooqbx260boregyj7y9vvig82jd5yflce2myozluyu4r
cfe44c4e-8e99-4742-9b2c-117b503201ba	O1AXMDA1HXZO	Norman-Brown	Tamil Nadu	2025-02-28	2021-11-25	Cancelled	kep4rq1yv4dcvqzxxpn76lz571u3vtyolh8y
7aa45cce-dbea-432f-85fa-be388b7eb046	OZPUJVISSLJ2	Lee and Sons	Rajasthan	2023-06-08	2023-05-31	Cancelled	o91id35auv1dz02bgqmr0d14zj7ca0c8hvdy5zmxnv60ffnnsjc2
252c2cb0-d1d0-47ec-934b-7ba5906653c5	HUNA422BRWR6	Baker-Carlson	Rajasthan	2022-05-25	2023-10-04	Suspended	6zuvgvrsgd8
0d20b07b-aacb-435f-bd41-0abfce3b064a	EV18WY472F9O	Brown Inc	Odisha	2026-04-22	2026-01-03	Expired	x3xvvpa4n1ghjrq
4a13e74e-9fe2-44d5-8682-97157e88abed	2NZQQCDWJSR5	Washington, Dean and Perez	Goa	2025-09-21	2024-01-31	Expired	56ohtitnbzzonpczpee1lfambea7qmzwhxqi3astx8r6gq1kqak2aiitnu
ea82ef78-80b7-4db3-866c-2a02c40c23d2	CWIDYGU4DZPV	Sandoval-Mclaughlin	Manipur	2025-03-27	2023-05-06	Cancelled	uq083k6ja33kox1zfc5vm90eex5mx4mh06oo1fv24qums670ahdtw0ugsv1kgic4k1qht7lb3k6ag2758g21x9ugrxx09hcetzw74sirvmzed0
56b1651f-2d30-47cc-862a-e113f201ca0d	BXFLUEF4K1E7	Welch PLC	Manipur	2024-03-24	2023-08-22	Active	x3tgdzo7sb9j4f7n0iuq0omno7l2790x05nr8dzkgpd6ky3q7gwdhoh
a215af51-6f91-49e1-af0e-144710a18406	Z4OPIGRFJG5N	Mitchell-Williams	Chandigarh	2024-05-26	2022-01-18	Active	ut65hdbs9w5ucj4zer5qcnm6vnzukhoze4amtrk67qn2cijsmjo1k70420omjjikyd01nof97mj02pc8jcgck8a4owjc437hk64zxijjzbzo5x7a5r1q4azj6od3naqn0b2nq2toq8fcioehcip6c7hk5adxoidv8lb2tsz0rk1kyhsa2u5mspof72ycoi2dlq9mq7md
f46ec54b-08ab-460e-b8a2-c18e824f9e58	7MQBSJ3JAOG0	Jimenez-Daniel	Kerala	2023-10-19	2026-08-10	Suspended	ca851l9pnis5yvw0pib9s8us6yonn3eu8k54c2hlv8jvt4h6bbwbqjihhyqgblxeqxlsk3
087665e6-ad9a-4d7a-b2bc-2a008a932116	TY7WQHB4HKSU	Howard-Miller	Tripura	2022-03-06	2026-08-10	Expired	mmigz6pis34e7079m4qytaailgevzdyttts9hnh3uact6aj22zx9diy382il2lqavcnrs4jgiy9kjo6u8r9l1lbthsohaltmyo5mqh2pfetmytyl20qgzyvn83hnget4un3ihmdk8bdbws13oi30zwzyjbn2pcbce840m819kkk
b4895e34-5730-4951-af5c-a9195d1b14ee	GEZ8CJPNYB8W	Clark PLC	Telangana	2023-06-28	2024-06-09	Suspended	rmmd29xysan140sk8w6xhb70j0bxc44oq03nzr6ukoik1uywlrijbyzrrilskmau2dopn0zvuybnkfii72uy6iuj40tz50k15va67rchnwdxm7ziibjk02x5pkw7awskihxorm09d58db8q0znouqksj5vhr2fwtw5x37iwdt05d312s248b
1359183e-a98f-4621-8a37-964ca0c9b3d0	Y0HJ9ZAC13UH	Johnson and Sons	Gujarat	2023-10-14	2025-12-05	Suspended	0y4a0idmlx7jom0zf572o0tx2twdjm5mim58ax7x0qnztgxdon30cvduc3rbh1tkqdph9tm2kqqh38lgsqolhbw0gtk3i4hw3629gtb4boi5bh1
f130708b-69c1-42a0-9822-984edec70dd0	7OVSKJYM9U7B	Jones Group	Gujarat	2025-09-20	2023-12-20	Active	jje72n72oyhos4gx8wo8cyc7rkszcb1yeir15jk3g8y93avw7aevd9nzu3fqu0anl7se4x462vtz6b93k74atkfpxow5fa8mw90ofxdylzakfh8q477ubkc6x85aoi0ljz56v6q1612j8cj4
17748913-828e-4286-b64a-d5183edd7283	N4YUJ6P2ZSDJ	Campbell-Warner	Gujarat	2022-05-31	2025-12-11	Suspended	dshl43m6lq33vlrhy843co60vng1m8qb6lkkeb37jz5o841tk076q3b37rzq0auhjjso9ktlwst3m62pxtu9k6by293rjm7xadfztr49n8zo6j4qit6a4mr0m72dk8ks8eafl1d7artxfyq4w8wr0j8np2hxbacn0mdbyqrk3dry0258bcwrxlyw1fk5lu
205d6dce-bd45-4516-b140-6c558ac98bab	03KJ4IK07KJ0	Gonzalez Ltd	Ladakh	2022-10-19	2026-03-03	Suspended	60e5d3oenwu3rkvkkwru2m10q2juvj1rwok49q4hx0m5y91q6hxs5hcdw02x390mijjcd3g5e072ia9qu07dahusjnwgiks0lsh16zez3cdq8wftsur350hl5clhzrv788z29hq8bfksq7ybnhyxwspuciallpdtg173ozwezsjqn53x
cf0ed0c8-9314-4151-bb8a-213f9ed49602	11E9CGKPPSFC	Holt, Clark and Ruiz	Ladakh	2022-12-01	2025-11-08	Suspended	p2wg3r5ee2l7cytx8k0oulq0g8rrqow9e1ddzl9agv4bk6oxuwuehldncc2t8n7n8m0hnslguri0xy9xad0cwrqmv6q
7f71f98c-9a24-4497-bf86-6d7a7dd6cefa	96DKVO4JOIJO	Vincent, Richardson and Pearson	Maharashtra	2024-07-28	2022-08-06	Expired	xtpw65vepmhfzfd6amjj0ge8ans32wafi2bn30xwpvhr8h86yinys
5c19abee-ae20-40fe-b1c0-321429237624	5APCGSQ9YPYP	Boone, Vazquez and Mendoza	Dadra and Nagar Haveli and Daman and Diu	2022-01-15	2025-03-27	Expired	av7ufjuqh3idg4dk7jx6xdflhw0e93ck1kzeew88cq093qgwvm4t9dywamwzpw3sa9mimensf38mz3hbovo29wdfgx0s8vtufbti5y61zkazeeqlgbx3z58l9iqhcwxi3hab6u4wnu5z5d13d69d5hexm41lrfyu1p39imm04l1bfl
3a0d86e6-6ff7-4da8-950b-7f83e64d0d3a	U18SR891CXPP	Baker-Riley	Nagaland	2022-05-14	2025-01-05	Cancelled	9uxi1v8rnq873ddkfgwn3qn47cx18bsmb4nr6sqj23qfr3nhxfj8mie54trfmihfmxre5byumz34k75h
4c9188ef-9c40-42cc-99a1-de32b6154e6a	OVYPVYDAH2E6	Burgess-Smith	Kerala	2024-06-05	2025-06-19	Active	j10jsnfxlanoxj1yu7otf3quptdzpbgp3z78lp9z0aslaowndh7gmqird5j2iq2o7ban5o59t7dn
899df50f-a5f3-425c-bdd2-558572572c53	NGI80BY7SC3I	Craig LLC	Assam	2021-09-24	2025-11-28	Active	ejkf6btdq9gjia0sarlzwgp42xw0h2k5kczsr1oomjf9q6l9t4dyqxrnip93ep2gdfybr00efzv9nwee0r8rwjktir1o896xbzckg70f1og2x581ofojqz2mwp687cyco09hm07qadbw3ktqbcrn4yuivjy2xc5eckpmovw7jakzri6tfrxb3cdax87ta8yyy
b3b110d8-f8f0-481c-89af-18d3837199e4	MFP1LY128UPS	Clements-Miller	West Bengal	2022-10-09	2022-06-04	Suspended	afpxgxrfiaq5kw75ra71g5dcuany17giwesbgy2kugwua9x70tklst7q95p2vda5mgx4a4u608tcquj23u9kkmll8z0
e4062463-2d4c-4ca1-a531-5fb028fbab2e	1SEKHQJ244T8	Walker and Sons	Dadra and Nagar Haveli and Daman and Diu	2024-10-05	2024-02-05	Cancelled	851tnd6un5oj9j1vex675nk7t1vqxusk945p7hkjdqrky266dr097yitwnak7pk5l0lr7tbwixw6w7o3ly1prdofw1en5cghwbplag1sknhe2fddn7ab83rakg96ois3ocs1t0vwzp7smv9jrqe5
f62a1e32-72d3-4ab8-921f-346f06e1bba4	MB5X7IS6D4B0	Smith, Campbell and Keith	Karnataka	2025-01-24	2025-01-21	Suspended	6wrfuvjzw1b1bgsh1jv41ery30k5wbo0if6sthgdigbzlbw9qdisw1l0bqlixy1etcylpm
14c84e29-5de6-4dba-9d51-a0c621b40c4e	SI3VT2NP2IKM	Cook Ltd	Bihar	2022-10-27	2025-03-22	Cancelled	6inkrr0bmtbglk8j5knmv9omzek4svp7npk84wg6vi8y4jfxzlru80hzrt4msawqhive38dgqw9cvbf5se6vqqtyegx9pvyhidofc8ygi5reqi4jcmz8ovsqyp83kyfoocqa6waruwuk1
4b9ec064-f36c-4ebf-a3c3-0d298db5f964	42NP4797T6DX	Hall LLC	Ladakh	2025-03-19	2023-02-21	Active	xkcup961mm3ruouu741050kusr3snx9cauea2x3fdqlg8yn059ku1g4qyt9wqsk0dvltkwxc1r4w48caa9b9uly57zz7rr8cl4mmce13yvn6130aqrxelykbu5m
4b771596-603e-4fac-b9a1-791c9926522a	GWT4ME0KAZMV	Silva Group	Karnataka	2026-05-28	2026-08-07	Cancelled	t502gd2r0freow4kf4imtr61ww47ikqqx8opsavcmhyfoeeqv8ihnckztmjnt
20a048d3-030e-4de5-869d-fc3189947ecf	NHK3W5R6QBZB	Meadows-Watkins	Odisha	2022-02-22	2021-11-07	Active	8cy4no13oxw6ntzrp232q4mj06ih0srbzibw6vrld04vjulh2ischgvja5nfiw2yrkgrtj1o4lkz79vymly6e54526g9anj3xzpy5tcii3u53x09zs2rt9fuom33hs7mswnug50g3pleq1wlni0
1e2ac52c-18c9-459c-b248-e29d664b735a	T4X7XVXEYY4L	Burke LLC	West Bengal	2022-03-09	2025-03-02	Suspended	0c85xbokfji1iu1jvmdi2wbsrcu3ktr7nu1msi1gs4s7h85o97aksxy5egjxur6vqozutxyhl
044d0eec-8fd6-4216-bac6-33b7c47b60ea	MY0Q128VQCZ6	Hill-Wilson	Ladakh	2026-07-01	2023-01-22	Suspended	2m9ljm11qldjgmb7ieksuh6d03os8jjhn92sv34uahyyzd70mvmsdyc1uvkhm2hoc7q20cyb0rz2khq06c0jaqv25gwykquew8lrr99t9dpnj6vcr63bgejp5ebeu2ugf29daomq0oe10enuy
61ef538e-9c78-434c-b22b-92c7da93950c	HVR518BFMRSH	Henry-White	Dadra and Nagar Haveli and Daman and Diu	2021-11-06	2025-01-26	Cancelled	eqs9k6z0fk8b0dg8rwbkgdqfeauquzm970q1zt4lte15myyul4fhicbsne561cvmgvdn31b32jfglzv0y8712t4ffl8bhnapwdprytpw3qhn2ry0
4f9b1cfc-e559-4a70-86e3-d9bbcb996290	NQ0G2JQ0Q19J	Baker-Wilson	Mizoram	2025-06-17	2025-06-20	Suspended	nld872312efc2n2f3gugq22thbz7535a8es451bd19r7hkeiar6uif28zksjg662gtez7oj14sln1faew58dcf3uwkq95elfcvw4rll7ud32oo9elfruwowcx1a13cfcsnzv2o72hnb5cwqc3zv87hxcqycnzdsuyr43rqrov3t9po6reoulj2i
bb092cd9-c1c8-4fa7-a5c7-4037a786740c	88OW3OXQLP1H	Petersen Ltd	Manipur	2021-09-30	2022-11-27	Active	9pv0u1e6x16yr5nxqf8i6myg61klc82bxem6sbg6i0qvef5em04dtmw05mfdi25co1thtquyu02iw5i80lf5d2xd2pq30hta176lwerjsp4qqkg962q
89e8208f-58bf-4830-ba13-3dc7c117898d	0JA8VDMMCAAM	Scott-Turner	Punjab	2021-12-16	2025-02-10	Active	wwd6upb03m2jox3m7nur8yx28mp4oofge7q5nb9j3nk3ubxk7vs8d6z6g9v4dsnumydgi73kt3og9y0ap9zd01jf3pnjw1gnb8ds0ua18c36otft87pd8ty6
4944f820-284b-4adb-a6e6-b27c247aef7e	BGZ8K0397EFY	Russell, Mclaughlin and Warren	Himachal Pradesh	2025-11-25	2023-11-22	Expired	vakyw5lh86bxetf68egnhfsxz2buow6c1szg3jsohhuzo8xag6rap49fqz
2fb2a34d-6640-4701-9c41-6226f4ba32be	TCP5GGVPQTQ9	Henry-Gay	Mizoram	2022-01-16	2022-12-27	Cancelled	flpubdf1chixlr1qfbdjsxomy6z16gsv5ajnh0dp7cjluw7rl15ismo95c4ey9e452440cc114zu9lw917ig65cmfab9v9hgshwiitlt5i0f5fwrz0wcix156y17cbl3co5sld2f0mro676i4in243890xgmgpvlqjwd
9ff38788-4c33-4b3d-a6f0-3f8a3c49742f	C1U6JAO3TBKK	Mcbride-Barrera	Andhra Pradesh	2024-07-03	2023-01-23	Active	c4fsx545buxit2sy5ixta97uzqi9dlsg5lubc4d5drbfwhodu88w83nbywa5ehgxfxdn0m38eriirbnieauvbz7kip2ziri6sdjekd8awi6cx6hu3eepf5awfht757x1dy0irlawfliujd2tqv2g5p4w7bnvgd
6ffc7e42-8220-48a7-b10e-cf8be57f2339	700LLOGCW43P	Torres-Wright	Puducherry	2023-02-28	2022-01-08	Expired	og7w5cl1clh018fefrk5s57zlladdn52fh8qh00mjhuah8zv43nstjxaaw89klflo28817wc4k
26bd5690-6d60-4d67-a9c0-643101cd414b	ZJKTUFD8IOPN	Herman, Taylor and Hurst	Sikkim	2022-12-21	2026-06-23	Cancelled	x3tzpgrvxxuukwmr2mz47u4cw7g49brf9vzike5dra7k2xcllq4bwz0se7nmu4mni6ca31u
f4cffed9-ae0d-4ce3-a732-1d6a747c8b59	312OSGUQAVOP	Wood Group	West Bengal	2022-05-02	2026-01-26	Cancelled	f8jujdm1xwfkmn259jjaqwyaiapwdrb97z7lwip93fapm2evn5oiq7nzrs3hbjl8kweq05mipnt1vgan17u
85eb1dcc-63b5-42f1-891a-db54bd0f1d21	PQDMHTLTS672	Holder Group	Uttar Pradesh	2023-10-24	2026-04-22	Cancelled	h7kdaezvlyyd0fivas79w22drf9s3gkfe1enmt284fdopa5po14ok0susv2944yx2iwqcg4bq24y2ds3o0rf85gn50fsth3c8b7ewzu3bk9rcznjajsn2egyk6lq5ivihy23ij6zyekscr2j93eequzn5dl08255pqzwq6fjm4c504b6e2jvkb0ytbspvkz
045b5de9-0439-48dd-ae06-21b4fb2fe0dc	RWBAISYN1W8D	Martin, Warren and Jones	Mizoram	2022-05-09	2024-02-03	Active	q6mg0llf7cgnpkp5ztcc5svit8cq4zctrpjyej289orgr86z9ajvxm7e8vu8in94psuyz8rkoocou4u0qnuvi90rkaf4si36zxumw1crniphznk306kya1piq7b415tc241vkoeg7x94zp8uzp17blj720psovuq5y9fsaha
4a64a194-0f16-418b-a6d0-b9555e009116	I4URVBGTO7WF	Woods, Griffin and Hogan	West Bengal	2025-12-28	2022-05-29	Active	elakj9yj0xkmoqad
65f4a7d4-fe09-48ca-bdd7-69683491e396	QUS5IYOPUALQ	Brock PLC	Jammu and Kashmir	2021-08-31	2024-09-01	Cancelled	3l8x9ccbfqj00pyxuxfqob3u7bfu6aee9ye02zdy7ujz5420bmn94holhtfqqu2hyubtbjk73i1z728xalw8pvy1c79i
3be195da-6195-4a0d-bb3e-73612c731fea	4GT7CY76WXLB	Cook, Cole and Brown	Delhi	2022-01-30	2024-06-23	Cancelled	2oodx2x77jfzpiirb60k9j6y8mpmjopkfq7ag5y4ouyb5vhiuoe88la6o0yi5vxlydr1s3uwpvi8qiev0c4y6ckwuhdv6tl0ksndte6ofg8t72d5vyl2ji1hn1v5z484hngakvjb5uv3cy8e6sqpu6i5bduy1tcyu9w489vpo0xry
69373811-753c-4be1-b3b1-a521887964ff	BCZ5CNONXPMK	Barker-Fisher	Tamil Nadu	2026-01-11	2022-02-08	Active	cu288u083wzdogkyzdafiy6t2rycstazbl2ezfm1k6ybm2yd8gu3fr93672erce71ciamfrjw8yht3bf4n4y6t
67e80eef-e894-4d4c-a20f-e61a9e0064a2	QQIHUI7PCHO8	Hill LLC	Chhattisgarh	2025-09-01	2026-08-09	Cancelled	ek28fttskpk521o4ltfcbtm1d1y07qeh6b1g44h99w62z780d352q62mifbtgp5mynz3moo5k959a80kssa99gwc27q6gd0hx2hr0846efbp1m775vzeo9jkwdk13xp1eqto6k1dd1ojd1i8cgndgm7329m8yq3nvi8
c50ebea0-e7e9-4eb1-9f39-64846fc6b3ba	A3YZAMOA874V	Young, Wilkins and Smith	Himachal Pradesh	2025-03-09	2025-10-05	Expired	nlefawjn8q5xo12wof50h9fz7k8sjb7y7tcf7m1u81gbhyr7hv3al6e8icc1r5tn46z2z2zzros828yofbvnqkaiv4zmontazrgh4jx7dbvinb8nhlwn060juvce9ap4vzjnsxym0cd6bzl6bxfje6
d9ed2e52-7b79-4434-8ee1-16b845beebfe	7A4664Z82XJ7	White-Nelson	Mizoram	2026-05-06	2022-09-28	Expired	u24rbpkonb7zhmcclg074rv1bl1p4x0sth0xjq7r4
7fcc6fd2-394f-4a49-9847-aad1fffdef2f	NUBASFPUACAW	Brooks and Sons	Dadra and Nagar Haveli and Daman and Diu	2024-04-25	2022-03-05	Active	2g9670doll9kkx2gvq51be6cwdd5gqs5ei
117bd706-85b7-4ceb-8860-5d8fef705792	1DS9FIAD4KUV	Scott, Hernandez and Hoover	Jharkhand	2022-01-24	2024-05-13	Expired	qszcdtjvoyderhnjojfdm6am7h1yah3n
0d0d730e-d80a-4d08-afb5-83e80bd37801	B6MKOO45RP2Y	Foster Inc	Bihar	2021-12-22	2025-10-11	Expired	4fuyj21kbxnk6gq38ueupy0kq0wrmw8fvvsygxnso9x0r524tvgcf9d3xl9pdiwr7qiaaonivy8tytpab2in54o1kh9yvez41m50sz21lypyeu1i5dbhpwnlb0ekp3d7ttv48vjhp2vv4y3ixiyd4j4hyxbun67vib09uz4hy6j902s0mqnlpcdx6by
cdc661f1-aab7-458a-ba9b-c44ee018185c	QHJ7NU7RWXB0	Reynolds-Arroyo	Rajasthan	2025-01-19	2026-05-03	Active	hqxlm5rlbme1ej8g3vwoq
1acc2b88-4448-44ad-b25c-9f52df91aa2b	LWP3JC80S4G5	Howard Ltd	Delhi	2022-12-25	2024-08-10	Expired	e17axzvo0urzhyqxupbe9icob88ynnrkyiengyhwdmt53mzv9135c1max0qcpl0qrc3s491ul2s5kw8ehky09lj9oyzhwjbz5dkoejoylp2tfk48ak7ap1fzktg7ri73pufs3wcgq34yu4nz9ukox8sgslgo1afra0o7xto77yb
d6485ab9-14f4-4847-80cc-39d09d793aa4	MU36TZ81SMXR	Mclaughlin, Heath and Allen	Telangana	2025-10-15	2023-03-17	Expired	wrriq2heopobypxslonr9nm6fydnfaav5qrb2mtrlalk8tduo6hw0mj0g143qfao
108c6210-5f0c-4152-8103-258bbb87c23a	3WXTC9X9WQKF	Anderson PLC	Goa	2022-03-14	2026-01-11	Expired	dzn6cvawnrt9jmrw4bitk6x02i9plh8fhgkhgaw3uou6iv5an2latliwh03wg7zb8taoqvil8y8bye1iazjecmqpk40u3ux9qcr0welgdcjti7pv8z11bfribzztmnsfclrfc7q20q2jrxzcghq706k2jn3c3ji3rc37u57ryfzwb4j9v0utlyp6b62oluyiqsj533
c34ec01e-3c61-49e9-a1c0-972d7c0ed89c	4RK4EGKSV2K4	Guzman Inc	Chhattisgarh	2025-09-26	2022-06-17	Expired	amsbcgfrxm66vbn5wfc24p04s7ubwj7k8oyglwyrvgn315ltx7my4n2fmxkdydsnkhqfio1icwmu4c5vqxjzp3kve2mlso38erkl699dou9jr7ln5kd0l175rbpudu70f2tl1xhbicv1936jhnnjo3xpm32rnr275q77dl80l7bkblaynlvvs6alcmzy9
29994810-0c08-4378-97f8-e749a1d133ee	6XI5QAND34H4	Collins, Lang and Hicks	Manipur	2024-02-20	2023-12-26	Active	vct16pcngshodxihgwg80ba04p8532wgjb3onhdgkdqkmgmgq38k8m1fk5uwv6pqqbq5l8bjsgy42o3pfhpwhrma22gv
5e5263f0-afff-417b-937d-1b79a25148b4	EXR9NF5IA30R	Hall, Perry and Baker	Dadra and Nagar Haveli and Daman and Diu	2026-04-02	2023-08-21	Suspended	iupgeargn2pfz95n9lcb94pl1cc3hf9qsh8e4oy6jwwrtznslnrdgpv3jwb9azt3uxllme6e9w6pt66tdl9lkhgnsviyjath5cj8rprcyntclaw9du022xdaqzxpw5vxu81qxhtb6ywon3qyia6vxpj5cknt97vebk245aravqbsy95hooww21wy2q3tso
1fcafe35-5f73-4fe5-b8d4-fc6a0c04e923	N1RA6B3SMPGT	Wilcox Ltd	Jharkhand	2025-09-03	2024-10-29	Expired	cb09fzjbge163p9u3vokbetk2xjn17v7btzlne18sukz
0326b0b0-9249-4b75-a01d-ff7ac9086ec1	V00U90IU9356	Harris-Keith	West Bengal	2024-06-19	2024-02-21	Active	vhtgvdzgikxmxp8m2jnbjekba8tqnh9y4ew4i4ziqnt2im36lm5y0aq1hrknig4gv6v2mdqxqzkd7rs71lq048hmqx145vl59zhxzvy5jli9m44n
67bc08bd-3b2d-47d0-b683-a9f3827ebf5f	GHE03REQFRIW	Parker-Brown	Meghalaya	2023-04-28	2025-04-05	Cancelled	06uvvskw
94315985-93f4-462a-9827-d640cbc9f70e	1E8XX49HIIXD	Horne-Cruz	Maharashtra	2022-08-07	2024-02-22	Suspended	86387lo9jbs8ea8wj4lqs8s6i59bjceio7woh9j0olw8d5idrjoyjlm
038be940-3803-4f4a-a745-75a28e14a2bf	YR21EL9HDKFF	Mcguire Inc	Uttar Pradesh	2022-04-06	2024-01-22	Cancelled	126i65573unkjpsp11adysda9yxtzipnkbrisnc66zo8evkrv31rvc4mavuzrz7namyyejzg3tr7cdcozbu5d0lpxni9u373fykl0u0rruppc05qfewxbf5v16gxngtnuzm7pkzkxbt9t1n28
21c9ab36-4a33-4b3d-8f1b-e4e03c8e8d13	9VI6LPS0QJOJ	Haynes Inc	Rajasthan	2024-11-13	2026-01-19	Suspended	wrmky9n9rgk4tbugdi8ub9934liy4y2c3z3svdjl6k0pc1phjnp99s4zi3p7kfq8lqb5ex2pz7x
35fd50ba-616f-40f7-a1ec-1f2bda6c2f99	1WMM6CV2GRN4	Miller Inc	Karnataka	2022-03-01	2025-11-07	Active	8s2xtm0bzbl1hirzaano1nwy3r9jccunzf9clhhdjswex7qgc8npiefzyiyzx8hqdx3ag0vbema1v8tixv452jtqhwu2heykawnhfnrqxq7xcpfih26nlgx3bc8wj4w56yfwll3gj818l309zfp6aeme99tw5vnnsd3qcbqimhd35neog06was8xq465j14leoqm
3c5a4baf-c8a3-4ad9-9d3f-51f902db16ec	7OLYHHMNY30F	Day, Brock and Johnson	Jammu and Kashmir	2021-09-20	2025-07-04	Expired	8yzo2l2cmzzjzzgcng4fwtxt8ck8qoi3eiot8pco21a3b79aeq9l1dcrjuontus3cjrutxtbuoo23a16b9a271x4ahirpabvcrfro0v2kxtxqic27ghdzvaibhso450vvsp60vykppkyhbssb84jhaark8xd3t2mninjxcnmkr38j4033i8gafexnexuw08vnh2gbz6
d4149d1e-44ba-4ce2-8c8a-3d1aec0ed5bb	27TP23LNMH5D	Hoffman, Fields and Ramos	Tamil Nadu	2024-09-24	2024-07-31	Cancelled	jw9rvzmss1povj5ugo9wex7r86uw212dizxi2xx93gx7fkuepgfoyijxw2uxq9vl3b64kuvp8xmqs444lbhh9hsl0zgp4c325o7l4fownb4osca4p4z8r5r2d3b
71a2b433-ed89-4e34-b655-697f90ef1907	YZ6KRGI13O9B	Martin-Moore	Punjab	2022-08-01	2023-06-23	Expired	aoh029ra6izd310ddi2nu7w5w43369x3mm5tc4qonx1tina525ei4d5m64d0fnxqytv62krfli4o831fzovs4obkms0gas7wku23t33fs02cmgj6d7jtcdmd87ipq0mzmcss8ctyox7jabe3uf1
e778f5ab-87b7-4256-91a2-1a6a8596a7d5	92MMSONQOB4C	Oconnor Inc	Ladakh	2022-08-27	2023-08-02	Cancelled	96voyip0exiuitm1z6vx3jav6yxxq6qhhrvwyi229cb4tn51pyf7u10im2t6nk0zwycp45jc1ieq8smwaa2o8pxc1txe6hqibjiw67kasw9c0yg3w9n266ppi6i47r62jakfldxc8p1nnikgc3t
af135f17-60bc-4e68-9630-05ab0775d748	FBNCB489WQIS	Gregory, Smith and Daniels	Assam	2024-12-29	2024-01-17	Expired	jenwxt0h3af0upmwhf2gzlyksv8oh6453ix6o8nckk1n2qk1ov2ozcm4su5ggswmreed5t
43bd2531-583b-4ee1-99b8-66ccd1f72bcc	4JLON8UYFDTW	Wright, Holloway and Galloway	Chandigarh	2026-03-26	2025-07-20	Cancelled	urft1t7yytz6qjfsexnfmsoe1nkav3lsbmczews5inp28pf07cb3mbxzndyoa4t43hbyqx86cqgpgprrde53oc
3fbd1cc4-7ed8-4bdc-8b75-61d9d7499450	9IB9P4TQC77V	Rose PLC	Meghalaya	2026-02-02	2026-05-07	Suspended	9f2h7wb51i66xrhzb8tdwrozwjwddj7ov0j0d8e93eermbzwbhhtvqns4qotlv2vo6pq1otp3y2bubiv71u6at11l60p33smsj57l8git436g9ea7apk05y5nym0tm31nwtot6l4310regc9546zeycyum1vore5y459217ss4112rsjr
44081ac3-0f39-461d-91e4-ccafe309775c	9K71IVQX4631	Mckinney-Montgomery	Chandigarh	2025-09-08	2022-08-28	Active	3m7y7h5ir1adfsdyowf1sq0omfu
9cf1231c-172a-4c00-9ac7-332dbf2acc8a	8GPOGUAR12HP	Pierce-Hamilton	Chhattisgarh	2025-07-11	2025-09-17	Cancelled	81fdse3kf9s4v58pzukrrzp3ux2tdxvj6whojv9djjwsk2q3oo7411fu02pzx1a
24ffb5e9-7db6-48f2-9578-2c39df4c7cca	AJ199C7YZE0U	Campbell, French and Shepherd	Dadra and Nagar Haveli and Daman and Diu	2022-08-12	2024-10-15	Cancelled	5hzubs7jdlxc67ovoe2cbe9j1nqcy154yg1zdvm4khti57e5v7480688iox5jrvp9jia6zi5grcdfijj8t6viwx565aln16a87wqdbjz3hfxm0ie0lu29i3msumfl719esu4tqdhzx23lzym1yr3z4pwtp8a47fw43z892
5d593bd1-613c-43b3-ad7b-4cc0fb231fc8	YLR66KKQWHVC	Brown, Powers and Austin	Goa	2026-05-15	2026-08-02	Suspended	cpmgxumjzorjs6ohdrso2ipopm6k4tbbtdi8bg2cmdaqmbs5ml9jyr2v0j32kyqaenboqe7x2liyl2ub4kvuktxvoivyfgxr2l41xhc1oypxwcyqyz2lapj56p3qoj8j5fqk0an3gtx633nda1heo60j42fwzarbtgwiemlgthjmrykkbxx4wixzz4
\.


--
-- Name: health_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_logs_log_id_seq', 10, true);


--
-- Name: apiary_locations apiary_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apiary_locations
    ADD CONSTRAINT apiary_locations_pkey PRIMARY KEY (location_id);


--
-- Name: batch_harvest_mapping batch_harvest_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_harvest_mapping
    ADD CONSTRAINT batch_harvest_mapping_pkey PRIMARY KEY (batch_id, harvest_id);


--
-- Name: batches batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (batch_id);


--
-- Name: harvests harvests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_pkey PRIMARY KEY (harvest_id);


--
-- Name: health_logs health_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_logs
    ADD CONSTRAINT health_logs_pkey PRIMARY KEY (log_id);


--
-- Name: beekeeper_registry beekeeper_registry_beekeeper_id_key; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.beekeeper_registry
    ADD CONSTRAINT beekeeper_registry_beekeeper_id_key UNIQUE (beekeeper_id);


--
-- Name: beekeeper_registry beekeeper_registry_pkey; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.beekeeper_registry
    ADD CONSTRAINT beekeeper_registry_pkey PRIMARY KEY (id);


--
-- Name: lab_report_registry lab_report_registry_pkey; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.lab_report_registry
    ADD CONSTRAINT lab_report_registry_pkey PRIMARY KEY (id);


--
-- Name: lab_report_registry lab_report_registry_ulr_number_key; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.lab_report_registry
    ADD CONSTRAINT lab_report_registry_ulr_number_key UNIQUE (ulr_number);


--
-- Name: license_registry license_registry_license_number_key; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.license_registry
    ADD CONSTRAINT license_registry_license_number_key UNIQUE (license_number);


--
-- Name: license_registry license_registry_pkey; Type: CONSTRAINT; Schema: verification; Owner: postgres
--

ALTER TABLE ONLY verification.license_registry
    ADD CONSTRAINT license_registry_pkey PRIMARY KEY (id);


--
-- Name: harvests harvests_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.apiary_locations(location_id) ON DELETE RESTRICT;


--
-- Name: health_logs health_logs_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_logs
    ADD CONSTRAINT health_logs_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.apiary_locations(location_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 6okUWr5eWI4BSyF8K0GAGrr9YYtBjgyOh4XlhkYdWWX32HVshHmmdYDIwQIdA6O

