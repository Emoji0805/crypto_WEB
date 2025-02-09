--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: ajouter_crypto_portefeuille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajouter_crypto_portefeuille() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ins‚rer chaque crypto existant dans la table portefeuille avec une quantit‚ de 0
INSERT INTO portefeuille (quantite, idCrypto, idUtilisateur)
SELECT 0, c.idCrypto, NEW.idUtilisateur
FROM Crypto c;

RETURN NEW;
END;
$$;


ALTER FUNCTION public.ajouter_crypto_portefeuille() OWNER TO postgres;

--
-- Name: insert_into_validation_transaction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_into_validation_transaction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO validation_transaction (idhistoriquetransaction, idvalidation)
VALUES (NEW.idhistoriquetransaction, NULL);

RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_into_validation_transaction() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    idadmin integer NOT NULL,
    nomadmin character varying(50),
    mdp character varying(50)
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_idadmin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_idadmin_seq OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_idadmin_seq OWNED BY public.admin.idadmin;


--
-- Name: balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balance (
    idbalance integer NOT NULL,
    minprix double precision,
    maxprix double precision,
    idcrypto integer
);


ALTER TABLE public.balance OWNER TO postgres;

--
-- Name: balance_idbalance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.balance_idbalance_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.balance_idbalance_seq OWNER TO postgres;

--
-- Name: balance_idbalance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.balance_idbalance_seq OWNED BY public.balance.idbalance;


--
-- Name: commission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commission (
    idcommission integer NOT NULL,
    idtransaction integer,
    idcrypto integer,
    pourcentage double precision,
    daty timestamp without time zone
);


ALTER TABLE public.commission OWNER TO postgres;

--
-- Name: commission_idcommission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commission_idcommission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commission_idcommission_seq OWNER TO postgres;

--
-- Name: commission_idcommission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commission_idcommission_seq OWNED BY public.commission.idcommission;


--
-- Name: cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cours (
    idcours integer NOT NULL,
    valeur double precision,
    daty timestamp without time zone,
    idcrypto integer
);


ALTER TABLE public.cours OWNER TO postgres;

--
-- Name: cours_idcours_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cours_idcours_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cours_idcours_seq OWNER TO postgres;

--
-- Name: cours_idcours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cours_idcours_seq OWNED BY public.cours.idcours;


--
-- Name: crypto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crypto (
    idcrypto integer NOT NULL,
    nom character varying(50)
);


ALTER TABLE public.crypto OWNER TO postgres;

--
-- Name: crypto_idcrypto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crypto_idcrypto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crypto_idcrypto_seq OWNER TO postgres;

--
-- Name: crypto_idcrypto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crypto_idcrypto_seq OWNED BY public.crypto.idcrypto;


--
-- Name: historiqueechange; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historiqueechange (
    idhistoriqueechange integer NOT NULL,
    entree double precision,
    sortie double precision,
    daty timestamp without time zone,
    idtransaction integer,
    idutilisateur integer,
    valeur_portefeuille double precision,
    idcrypto integer
);


ALTER TABLE public.historiqueechange OWNER TO postgres;

--
-- Name: historiqueechange_idhistoriqueechange_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historiqueechange_idhistoriqueechange_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historiqueechange_idhistoriqueechange_seq OWNER TO postgres;

--
-- Name: historiqueechange_idhistoriqueechange_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historiqueechange_idhistoriqueechange_seq OWNED BY public.historiqueechange.idhistoriqueechange;


--
-- Name: historiquetransaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historiquetransaction (
    idhistoriquetransaction integer NOT NULL,
    daty timestamp without time zone,
    idtransaction integer,
    idutilisateur integer,
    valeurs double precision
);


ALTER TABLE public.historiquetransaction OWNER TO postgres;

--
-- Name: historiquetransaction_idhistoriquetransaction_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historiquetransaction_idhistoriquetransaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historiquetransaction_idhistoriquetransaction_seq OWNER TO postgres;

--
-- Name: historiquetransaction_idhistoriquetransaction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historiquetransaction_idhistoriquetransaction_seq OWNED BY public.historiquetransaction.idhistoriquetransaction;


--
-- Name: portefeuille; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portefeuille (
    quantite double precision,
    idcrypto integer,
    idutilisateur integer NOT NULL
);


ALTER TABLE public.portefeuille OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    idtransaction integer NOT NULL,
    nom character varying(50)
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: transaction_idtransaction_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_idtransaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_idtransaction_seq OWNER TO postgres;

--
-- Name: transaction_idtransaction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_idtransaction_seq OWNED BY public.transaction.idtransaction;


--
-- Name: typeanalyse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.typeanalyse (
    idtypeanalyse integer NOT NULL,
    nomanalyse character varying(50) NOT NULL
);


ALTER TABLE public.typeanalyse OWNER TO postgres;

--
-- Name: typeanalyse_idtypeanalyse_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.typeanalyse_idtypeanalyse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.typeanalyse_idtypeanalyse_seq OWNER TO postgres;

--
-- Name: typeanalyse_idtypeanalyse_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.typeanalyse_idtypeanalyse_seq OWNED BY public.typeanalyse.idtypeanalyse;


--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    idutilisateur integer NOT NULL,
    nom character varying(50),
    email character varying(150),
    mdp character varying(50),
    fond double precision DEFAULT 0
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- Name: utilisateurs_idutilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateurs_idutilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilisateurs_idutilisateur_seq OWNER TO postgres;

--
-- Name: utilisateurs_idutilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateurs_idutilisateur_seq OWNED BY public.utilisateurs.idutilisateur;


--
-- Name: v_commission; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_commission AS
 SELECT c.idcommission,
    t.idtransaction,
    t.nom AS nomtransaction,
    cr.idcrypto,
    cr.nom AS nomcrypto,
    c.pourcentage,
    c.daty
   FROM ((public.commission c
     JOIN public.transaction t ON ((t.idtransaction = c.idtransaction)))
     JOIN public.crypto cr ON ((cr.idcrypto = c.idcrypto)));


ALTER TABLE public.v_commission OWNER TO postgres;

--
-- Name: v_cours_crypto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_cours_crypto AS
 SELECT c.idcours,
    c.valeur,
    c.daty,
    c.idcrypto,
    cr.nom AS nom_crypto
   FROM (public.cours c
     JOIN public.crypto cr ON ((c.idcrypto = cr.idcrypto)));


ALTER TABLE public.v_cours_crypto OWNER TO postgres;

--
-- Name: v_historiqueretraitdepot_utilisateurs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_historiqueretraitdepot_utilisateurs AS
 SELECT ht.daty,
    ht.idtransaction,
    t.nom AS transaction_nom,
    u.idutilisateur,
    u.nom AS utilisateur_nom,
    u.email,
    ht.valeurs
   FROM ((public.historiquetransaction ht
     JOIN public.transaction t ON ((t.idtransaction = ht.idtransaction)))
     JOIN public.utilisateurs u ON ((u.idutilisateur = ht.idutilisateur)));


ALTER TABLE public.v_historiqueretraitdepot_utilisateurs OWNER TO postgres;

--
-- Name: v_historiqueventeachat_utilisateurs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_historiqueventeachat_utilisateurs AS
 SELECT he.idhistoriqueechange,
    he.entree,
    he.sortie,
    he.daty,
    he.idtransaction,
    he.idutilisateur,
    he.valeur_portefeuille,
    he.idcrypto,
    c.nom AS crypto_nom,
    t.nom AS transaction_nom,
    u.nom AS utilisateur_nom,
    u.email
   FROM (((public.historiqueechange he
     JOIN public.utilisateurs u ON ((he.idutilisateur = u.idutilisateur)))
     JOIN public.transaction t ON ((he.idtransaction = t.idtransaction)))
     JOIN public.crypto c ON ((he.idcrypto = c.idcrypto)));


ALTER TABLE public.v_historiqueventeachat_utilisateurs OWNER TO postgres;

--
-- Name: v_portefeuille_utilisateur; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_portefeuille_utilisateur AS
 SELECT c.idcrypto,
    c.nom AS crypto,
    p.quantite,
    u.idutilisateur,
    u.nom,
    u.fond
   FROM ((public.portefeuille p
     JOIN public.crypto c ON ((c.idcrypto = p.idcrypto)))
     JOIN public.utilisateurs u ON ((u.idutilisateur = p.idutilisateur)));


ALTER TABLE public.v_portefeuille_utilisateur OWNER TO postgres;

--
-- Name: validation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validation (
    idvalidation integer NOT NULL,
    description character varying(60)
);


ALTER TABLE public.validation OWNER TO postgres;

--
-- Name: validation_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validation_transaction (
    idvalidation_transaction integer NOT NULL,
    idhistoriquetransaction integer,
    idvalidation integer
);


ALTER TABLE public.validation_transaction OWNER TO postgres;

--
-- Name: v_validation_transaction; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_validation_transaction AS
 SELECT vt.idvalidation_transaction,
    ht.idhistoriquetransaction,
    u.idutilisateur,
    u.nom,
    ht.daty AS date_transaction,
    ht.valeurs,
    t.nom AS operation,
    t.idtransaction,
    v.description AS type_validation
   FROM ((((public.validation_transaction vt
     JOIN public.historiquetransaction ht ON ((vt.idhistoriquetransaction = ht.idhistoriquetransaction)))
     JOIN public.utilisateurs u ON ((u.idutilisateur = ht.idutilisateur)))
     JOIN public.transaction t ON ((ht.idtransaction = t.idtransaction)))
     LEFT JOIN public.validation v ON ((v.idvalidation = vt.idvalidation)));


ALTER TABLE public.v_validation_transaction OWNER TO postgres;

--
-- Name: validation_idvalidation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validation_idvalidation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validation_idvalidation_seq OWNER TO postgres;

--
-- Name: validation_idvalidation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validation_idvalidation_seq OWNED BY public.validation.idvalidation;


--
-- Name: validation_transaction_idvalidation_transaction_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validation_transaction_idvalidation_transaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validation_transaction_idvalidation_transaction_seq OWNER TO postgres;

--
-- Name: validation_transaction_idvalidation_transaction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validation_transaction_idvalidation_transaction_seq OWNED BY public.validation_transaction.idvalidation_transaction;


--
-- Name: admin idadmin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN idadmin SET DEFAULT nextval('public.admin_idadmin_seq'::regclass);


--
-- Name: balance idbalance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance ALTER COLUMN idbalance SET DEFAULT nextval('public.balance_idbalance_seq'::regclass);


--
-- Name: commission idcommission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission ALTER COLUMN idcommission SET DEFAULT nextval('public.commission_idcommission_seq'::regclass);


--
-- Name: cours idcours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours ALTER COLUMN idcours SET DEFAULT nextval('public.cours_idcours_seq'::regclass);


--
-- Name: crypto idcrypto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto ALTER COLUMN idcrypto SET DEFAULT nextval('public.crypto_idcrypto_seq'::regclass);


--
-- Name: historiqueechange idhistoriqueechange; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiqueechange ALTER COLUMN idhistoriqueechange SET DEFAULT nextval('public.historiqueechange_idhistoriqueechange_seq'::regclass);


--
-- Name: historiquetransaction idhistoriquetransaction; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiquetransaction ALTER COLUMN idhistoriquetransaction SET DEFAULT nextval('public.historiquetransaction_idhistoriquetransaction_seq'::regclass);


--
-- Name: transaction idtransaction; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction ALTER COLUMN idtransaction SET DEFAULT nextval('public.transaction_idtransaction_seq'::regclass);


--
-- Name: typeanalyse idtypeanalyse; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typeanalyse ALTER COLUMN idtypeanalyse SET DEFAULT nextval('public.typeanalyse_idtypeanalyse_seq'::regclass);


--
-- Name: utilisateurs idutilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN idutilisateur SET DEFAULT nextval('public.utilisateurs_idutilisateur_seq'::regclass);


--
-- Name: validation idvalidation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation ALTER COLUMN idvalidation SET DEFAULT nextval('public.validation_idvalidation_seq'::regclass);


--
-- Name: validation_transaction idvalidation_transaction; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation_transaction ALTER COLUMN idvalidation_transaction SET DEFAULT nextval('public.validation_transaction_idvalidation_transaction_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (idadmin, nomadmin, mdp) FROM stdin;
1	admin	admin
\.


--
-- Data for Name: balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.balance (idbalance, minprix, maxprix, idcrypto) FROM stdin;
1	35000	45000	1
2	1800	2200	2
3	0.4	0.6	3
4	90	110	4
5	0.8	1.2	5
\.


--
-- Data for Name: commission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commission (idcommission, idtransaction, idcrypto, pourcentage, daty) FROM stdin;
1	1	1	0.5	2024-02-01 10:30:00
2	2	1	0.7	2024-02-02 12:45:00
3	1	2	0.6	2024-02-03 14:20:00
4	2	2	0.8	2024-02-04 16:10:00
5	2	3	0.55	2024-02-05 09:00:00
6	1	3	0.75	2024-02-06 11:30:00
7	1	1	0.1	2025-02-06 20:23:41.034
\.


--
-- Data for Name: cours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cours (idcours, valeur, daty, idcrypto) FROM stdin;
\.


--
-- Data for Name: crypto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crypto (idcrypto, nom) FROM stdin;
1	Bitcoin
2	Ethereum
3	Ripple
4	Litecoin
5	Cardano
6	Solana
7	Polkadot
8	Dogecoin
9	Shiba Inu
10	Avalanche
\.


--
-- Data for Name: historiqueechange; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historiqueechange (idhistoriqueechange, entree, sortie, daty, idtransaction, idutilisateur, valeur_portefeuille, idcrypto) FROM stdin;
\.


--
-- Data for Name: historiquetransaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historiquetransaction (idhistoriquetransaction, daty, idtransaction, idutilisateur, valeurs) FROM stdin;
\.


--
-- Data for Name: portefeuille; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portefeuille (quantite, idcrypto, idutilisateur) FROM stdin;
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (idtransaction, nom) FROM stdin;
1	Achat
2	Vente
3	Depot
4	Retrait
\.


--
-- Data for Name: typeanalyse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.typeanalyse (idtypeanalyse, nomanalyse) FROM stdin;
1	1er quartile
2	Maximum
3	Minimum
4	Moyenne
5	Ecart-type
\.


--
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (idutilisateur, nom, email, mdp, fond) FROM stdin;
\.


--
-- Data for Name: validation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validation (idvalidation, description) FROM stdin;
1	Valider
2	Annuler
\.


--
-- Data for Name: validation_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validation_transaction (idvalidation_transaction, idhistoriquetransaction, idvalidation) FROM stdin;
8	11	1
9	12	2
10	13	2
11	14	1
\.


--
-- Name: admin_idadmin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_idadmin_seq', 1, true);


--
-- Name: balance_idbalance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.balance_idbalance_seq', 5, true);


--
-- Name: commission_idcommission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commission_idcommission_seq', 7, true);


--
-- Name: cours_idcours_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cours_idcours_seq', 1585, true);


--
-- Name: crypto_idcrypto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crypto_idcrypto_seq', 10, true);


--
-- Name: historiqueechange_idhistoriqueechange_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historiqueechange_idhistoriqueechange_seq', 10, true);


--
-- Name: historiquetransaction_idhistoriquetransaction_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historiquetransaction_idhistoriquetransaction_seq', 14, true);


--
-- Name: transaction_idtransaction_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_idtransaction_seq', 4, true);


--
-- Name: typeanalyse_idtypeanalyse_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.typeanalyse_idtypeanalyse_seq', 5, true);


--
-- Name: utilisateurs_idutilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateurs_idutilisateur_seq', 3, true);


--
-- Name: validation_idvalidation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validation_idvalidation_seq', 2, true);


--
-- Name: validation_transaction_idvalidation_transaction_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validation_transaction_idvalidation_transaction_seq', 11, true);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (idadmin);


--
-- Name: balance balance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_pkey PRIMARY KEY (idbalance);


--
-- Name: commission commission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission
    ADD CONSTRAINT commission_pkey PRIMARY KEY (idcommission);


--
-- Name: cours cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_pkey PRIMARY KEY (idcours);


--
-- Name: crypto crypto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto
    ADD CONSTRAINT crypto_pkey PRIMARY KEY (idcrypto);


--
-- Name: historiqueechange historiqueechange_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiqueechange
    ADD CONSTRAINT historiqueechange_pkey PRIMARY KEY (idhistoriqueechange);


--
-- Name: historiquetransaction historiquetransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiquetransaction
    ADD CONSTRAINT historiquetransaction_pkey PRIMARY KEY (idhistoriquetransaction);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (idtransaction);


--
-- Name: typeanalyse typeanalyse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typeanalyse
    ADD CONSTRAINT typeanalyse_pkey PRIMARY KEY (idtypeanalyse);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (idutilisateur);


--
-- Name: validation validation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation
    ADD CONSTRAINT validation_pkey PRIMARY KEY (idvalidation);


--
-- Name: validation_transaction validation_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation_transaction
    ADD CONSTRAINT validation_transaction_pkey PRIMARY KEY (idvalidation_transaction);


--
-- Name: historiquetransaction after_insert_historiquetransaction; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_insert_historiquetransaction AFTER INSERT ON public.historiquetransaction FOR EACH ROW EXECUTE FUNCTION public.insert_into_validation_transaction();


--
-- Name: utilisateurs trigger_ajout_portefeuille; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_ajout_portefeuille AFTER INSERT ON public.utilisateurs FOR EACH ROW EXECUTE FUNCTION public.ajouter_crypto_portefeuille();


--
-- Name: balance balance_idcrypto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_idcrypto_fkey FOREIGN KEY (idcrypto) REFERENCES public.crypto(idcrypto);


--
-- Name: commission commission_idcrypto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission
    ADD CONSTRAINT commission_idcrypto_fkey FOREIGN KEY (idcrypto) REFERENCES public.crypto(idcrypto);


--
-- Name: commission commission_idtransaction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commission
    ADD CONSTRAINT commission_idtransaction_fkey FOREIGN KEY (idtransaction) REFERENCES public.transaction(idtransaction);


--
-- Name: cours cours_idcrypto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_idcrypto_fkey FOREIGN KEY (idcrypto) REFERENCES public.crypto(idcrypto);


--
-- Name: historiqueechange historiqueechange_idcrypto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiqueechange
    ADD CONSTRAINT historiqueechange_idcrypto_fkey FOREIGN KEY (idcrypto) REFERENCES public.crypto(idcrypto);


--
-- Name: historiqueechange historiqueechange_idtransaction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiqueechange
    ADD CONSTRAINT historiqueechange_idtransaction_fkey FOREIGN KEY (idtransaction) REFERENCES public.transaction(idtransaction);


--
-- Name: historiquetransaction historiquetransaction_idtransaction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historiquetransaction
    ADD CONSTRAINT historiquetransaction_idtransaction_fkey FOREIGN KEY (idtransaction) REFERENCES public.transaction(idtransaction);


--
-- Name: portefeuille portefeuille_idcrypto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portefeuille
    ADD CONSTRAINT portefeuille_idcrypto_fkey FOREIGN KEY (idcrypto) REFERENCES public.crypto(idcrypto);


--
-- Name: validation_transaction validation_transaction_idvalidation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation_transaction
    ADD CONSTRAINT validation_transaction_idvalidation_fkey FOREIGN KEY (idvalidation) REFERENCES public.validation(idvalidation);


--
-- PostgreSQL database dump complete
--

