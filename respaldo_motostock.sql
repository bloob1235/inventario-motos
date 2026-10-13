--
-- PostgreSQL database dump
--

\restrict dMsrcDiL9O3N8W7ZlPEA6zTOWneB8ikOWBtYWH1utFOXZOSyJgkQfTlHLutyw9G

-- Dumped from database version 16.15 (Debian 16.15-1.pgdg13+2)
-- Dumped by pg_dump version 16.15 (Debian 16.15-1.pgdg13+2)

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
-- Name: compras; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.compras (
    id integer NOT NULL,
    refaccion_id integer,
    nombre character varying(100) NOT NULL,
    categoria character varying(50) NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT compras_cantidad_check CHECK ((cantidad > 0)),
    CONSTRAINT compras_precio_unitario_check CHECK ((precio_unitario >= (0)::numeric))
);


ALTER TABLE public.compras OWNER TO admin;

--
-- Name: compras_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.compras_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compras_id_seq OWNER TO admin;

--
-- Name: compras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.compras_id_seq OWNED BY public.compras.id;


--
-- Name: refacciones; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.refacciones (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    categoria character varying(50) NOT NULL,
    marca character varying(50) NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL
);


ALTER TABLE public.refacciones OWNER TO admin;

--
-- Name: refacciones_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.refacciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refacciones_id_seq OWNER TO admin;

--
-- Name: refacciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.refacciones_id_seq OWNED BY public.refacciones.id;


--
-- Name: compras id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras ALTER COLUMN id SET DEFAULT nextval('public.compras_id_seq'::regclass);


--
-- Name: refacciones id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.refacciones ALTER COLUMN id SET DEFAULT nextval('public.refacciones_id_seq'::regclass);


--
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.compras (id, refaccion_id, nombre, categoria, cantidad, precio_unitario, fecha) FROM stdin;
1	\N	Aceite para motor	Lubricantes	12	180.00	2026-10-02 10:30:00
2	\N	Bujía NGK	Encendido	15	95.00	2026-10-04 12:00:00
3	\N	Pastillas de freno	Frenos	8	240.00	2026-10-06 09:15:00
4	\N	Cadena para moto	Transmisión	5	420.00	2026-10-08 11:20:00
5	\N	Aceite para motor	Lubricantes	10	180.00	2026-10-10 13:10:00
6	\N	Filtro de aire	Filtros	7	150.00	2026-10-11 10:00:00
7	\N	Pastillas de freno	Frenos	6	240.00	2026-10-12 09:30:00
8	\N	Bujía NGK	Encendido	10	95.00	2026-10-12 14:00:00
\.


--
-- Data for Name: refacciones; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.refacciones (id, nombre, categoria, marca, precio, stock) FROM stdin;
1	Balatas delanteras	Frenos	Brembo	450.00	12
2	Balatas traseras	Frenos	Brembo	380.00	10
3	Disco de freno	Frenos	NG	950.00	5
4	Bomba de freno	Frenos	Nissin	780.00	4
5	Manguera de freno	Frenos	Genérica	220.00	8
6	Cadena de transmisión	Transmisión	DID	850.00	7
7	Piñón delantero	Transmisión	JT	250.00	9
8	Corona trasera	Transmisión	JT	420.00	6
9	Kit de arrastre	Transmisión	DID	1350.00	4
10	Tensor de cadena	Transmisión	Genérica	180.00	10
11	Bujía	Motor	NGK	120.00	20
12	Filtro de aceite	Motor	Hiflofiltro	160.00	15
13	Filtro de aire	Motor	K&N	520.00	6
14	Pistón	Motor	ProX	1100.00	3
15	Juego de anillos	Motor	ProX	480.00	5
16	Batería	Electricidad	Yuasa	1250.00	4
17	Foco delantero	Electricidad	Philips	180.00	12
18	Regulador de voltaje	Electricidad	Genérico	650.00	5
19	Bobina de encendido	Electricidad	NGK	390.00	7
20	Claxon	Electricidad	Genérico	150.00	10
21	Amortiguador trasero	Suspensión	YSS	1800.00	3
22	Horquilla delantera	Suspensión	Genérica	2200.00	2
23	Retén de horquilla	Suspensión	SKF	280.00	8
24	Resorte de suspensión	Suspensión	YSS	750.00	4
25	Aceite de horquilla	Suspensión	Motul	320.00	9
26	Manubrio	Accesorios	Renthal	900.00	4
27	Espejos	Accesorios	Genérico	250.00	10
28	Puños	Accesorios	ProGrip	190.00	12
29	Palanca de cambios	Accesorios	Genérica	300.00	6
30	Pedal de freno	Accesorios	Genérico	350.00	5
\.


--
-- Name: compras_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.compras_id_seq', 8, true);


--
-- Name: refacciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.refacciones_id_seq', 30, true);


--
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id);


--
-- Name: refacciones refacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.refacciones
    ADD CONSTRAINT refacciones_pkey PRIMARY KEY (id);


--
-- Name: compras compras_refaccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_refaccion_id_fkey FOREIGN KEY (refaccion_id) REFERENCES public.refacciones(id);


--
-- PostgreSQL database dump complete
--

\unrestrict dMsrcDiL9O3N8W7ZlPEA6zTOWneB8ikOWBtYWH1utFOXZOSyJgkQfTlHLutyw9G

