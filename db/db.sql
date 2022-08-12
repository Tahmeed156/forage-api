--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

-- Started on 2022-08-12 08:07:33 +06

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
-- TOC entry 202 (class 1259 OID 16385)
-- Name: api_paper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_paper (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    doi character varying(256),
    abstract text NOT NULL,
    authors character varying(1024) NOT NULL
);


ALTER TABLE public.api_paper OWNER TO "user";

--
-- TOC entry 203 (class 1259 OID 16391)
-- Name: api_paper_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_paper_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_paper_id_seq OWNER TO "user";

--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 203
-- Name: api_paper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_paper_id_seq OWNED BY public.api_paper.id;


--
-- TOC entry 204 (class 1259 OID 16393)
-- Name: api_project; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_project (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    url character varying(256),
    description text NOT NULL,
    is_default boolean NOT NULL
);


ALTER TABLE public.api_project OWNER TO "user";

--
-- TOC entry 205 (class 1259 OID 16399)
-- Name: api_project_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_id_seq OWNER TO "user";

--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 205
-- Name: api_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_project_id_seq OWNED BY public.api_project.id;


--
-- TOC entry 206 (class 1259 OID 16401)
-- Name: api_projectcollaborator; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_projectcollaborator (
    id bigint NOT NULL,
    role character varying(256),
    collaborator_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE public.api_projectcollaborator OWNER TO "user";

--
-- TOC entry 207 (class 1259 OID 16404)
-- Name: api_projectcollaborator_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_projectcollaborator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_projectcollaborator_id_seq OWNER TO "user";

--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 207
-- Name: api_projectcollaborator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectcollaborator_id_seq OWNED BY public.api_projectcollaborator.id;


--
-- TOC entry 208 (class 1259 OID 16406)
-- Name: api_projectlist; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_projectlist (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    is_archived boolean NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE public.api_projectlist OWNER TO "user";

--
-- TOC entry 209 (class 1259 OID 16409)
-- Name: api_projectlist_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_projectlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_projectlist_id_seq OWNER TO "user";

--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 209
-- Name: api_projectlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectlist_id_seq OWNED BY public.api_projectlist.id;


--
-- TOC entry 210 (class 1259 OID 16411)
-- Name: api_projectpaper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_projectpaper (
    id bigint NOT NULL,
    date_added timestamp with time zone NOT NULL,
    list_id bigint NOT NULL,
    paper_id bigint NOT NULL
);


ALTER TABLE public.api_projectpaper OWNER TO "user";

--
-- TOC entry 211 (class 1259 OID 16414)
-- Name: api_projectpaper_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_projectpaper_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_projectpaper_id_seq OWNER TO "user";

--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 211
-- Name: api_projectpaper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectpaper_id_seq OWNED BY public.api_projectpaper.id;


--
-- TOC entry 212 (class 1259 OID 16416)
-- Name: api_task; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_task (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    start_date timestamp with time zone,
    due_date timestamp with time zone,
    status character varying(128) NOT NULL,
    project_id bigint NOT NULL,
    project_paper_id bigint
);


ALTER TABLE public.api_task OWNER TO "user";

--
-- TOC entry 213 (class 1259 OID 16419)
-- Name: api_task_assignees; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_task_assignees (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    projectcollaborator_id bigint NOT NULL
);


ALTER TABLE public.api_task_assignees OWNER TO "user";

--
-- TOC entry 214 (class 1259 OID 16422)
-- Name: api_task_assignees_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_task_assignees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_task_assignees_id_seq OWNER TO "user";

--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 214
-- Name: api_task_assignees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_task_assignees_id_seq OWNED BY public.api_task_assignees.id;


--
-- TOC entry 215 (class 1259 OID 16424)
-- Name: api_task_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_task_id_seq OWNER TO "user";

--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 215
-- Name: api_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_task_id_seq OWNED BY public.api_task.id;


--
-- TOC entry 237 (class 1259 OID 16684)
-- Name: api_taskdependency; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_taskdependency (
    id bigint NOT NULL,
    after_id bigint NOT NULL,
    before_id bigint NOT NULL
);


ALTER TABLE public.api_taskdependency OWNER TO "user";

--
-- TOC entry 236 (class 1259 OID 16682)
-- Name: api_taskdependency_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_taskdependency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_taskdependency_id_seq OWNER TO "user";

--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 236
-- Name: api_taskdependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_taskdependency_id_seq OWNED BY public.api_taskdependency.id;


--
-- TOC entry 216 (class 1259 OID 16426)
-- Name: api_user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    date_of_birth timestamp with time zone,
    affiliation character varying(256),
    designation character varying(256)
);


ALTER TABLE public.api_user OWNER TO "user";

--
-- TOC entry 217 (class 1259 OID 16432)
-- Name: api_user_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.api_user_groups OWNER TO "user";

--
-- TOC entry 218 (class 1259 OID 16435)
-- Name: api_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_groups_id_seq OWNER TO "user";

--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 218
-- Name: api_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_groups_id_seq OWNED BY public.api_user_groups.id;


--
-- TOC entry 219 (class 1259 OID 16437)
-- Name: api_user_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_id_seq OWNER TO "user";

--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 219
-- Name: api_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_id_seq OWNED BY public.api_user.id;


--
-- TOC entry 220 (class 1259 OID 16439)
-- Name: api_user_user_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.api_user_user_permissions OWNER TO "user";

--
-- TOC entry 221 (class 1259 OID 16442)
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_user_permissions_id_seq OWNER TO "user";

--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 221
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_user_permissions_id_seq OWNED BY public.api_user_user_permissions.id;


--
-- TOC entry 222 (class 1259 OID 16444)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO "user";

--
-- TOC entry 223 (class 1259 OID 16447)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO "user";

--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 224 (class 1259 OID 16449)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO "user";

--
-- TOC entry 225 (class 1259 OID 16452)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO "user";

--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 225
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 226 (class 1259 OID 16454)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO "user";

--
-- TOC entry 227 (class 1259 OID 16457)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO "user";

--
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 227
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 228 (class 1259 OID 16459)
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO "user";

--
-- TOC entry 229 (class 1259 OID 16462)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO "user";

--
-- TOC entry 230 (class 1259 OID 16469)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO "user";

--
-- TOC entry 3238 (class 0 OID 0)
-- Dependencies: 230
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 231 (class 1259 OID 16471)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO "user";

--
-- TOC entry 232 (class 1259 OID 16474)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO "user";

--
-- TOC entry 3239 (class 0 OID 0)
-- Dependencies: 232
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 233 (class 1259 OID 16476)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO "user";

--
-- TOC entry 234 (class 1259 OID 16482)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO "user";

--
-- TOC entry 3240 (class 0 OID 0)
-- Dependencies: 234
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 235 (class 1259 OID 16484)
-- Name: django_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO "user";

--
-- TOC entry 2934 (class 2604 OID 16490)
-- Name: api_paper id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper ALTER COLUMN id SET DEFAULT nextval('public.api_paper_id_seq'::regclass);


--
-- TOC entry 2935 (class 2604 OID 16491)
-- Name: api_project id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project ALTER COLUMN id SET DEFAULT nextval('public.api_project_id_seq'::regclass);


--
-- TOC entry 2936 (class 2604 OID 16492)
-- Name: api_projectcollaborator id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator ALTER COLUMN id SET DEFAULT nextval('public.api_projectcollaborator_id_seq'::regclass);


--
-- TOC entry 2937 (class 2604 OID 16493)
-- Name: api_projectlist id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist ALTER COLUMN id SET DEFAULT nextval('public.api_projectlist_id_seq'::regclass);


--
-- TOC entry 2938 (class 2604 OID 16494)
-- Name: api_projectpaper id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper ALTER COLUMN id SET DEFAULT nextval('public.api_projectpaper_id_seq'::regclass);


--
-- TOC entry 2939 (class 2604 OID 16495)
-- Name: api_task id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task ALTER COLUMN id SET DEFAULT nextval('public.api_task_id_seq'::regclass);


--
-- TOC entry 2940 (class 2604 OID 16496)
-- Name: api_task_assignees id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees ALTER COLUMN id SET DEFAULT nextval('public.api_task_assignees_id_seq'::regclass);


--
-- TOC entry 2951 (class 2604 OID 16687)
-- Name: api_taskdependency id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency ALTER COLUMN id SET DEFAULT nextval('public.api_taskdependency_id_seq'::regclass);


--
-- TOC entry 2941 (class 2604 OID 16497)
-- Name: api_user id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user ALTER COLUMN id SET DEFAULT nextval('public.api_user_id_seq'::regclass);


--
-- TOC entry 2942 (class 2604 OID 16498)
-- Name: api_user_groups id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups ALTER COLUMN id SET DEFAULT nextval('public.api_user_groups_id_seq'::regclass);


--
-- TOC entry 2943 (class 2604 OID 16499)
-- Name: api_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.api_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 2944 (class 2604 OID 16500)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 2945 (class 2604 OID 16501)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 2946 (class 2604 OID 16502)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 2947 (class 2604 OID 16503)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 2949 (class 2604 OID 16504)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 2950 (class 2604 OID 16505)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3183 (class 0 OID 16385)
-- Dependencies: 202
-- Data for Name: api_paper; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_paper VALUES (1, 'Firecracker: Lightweight Virtualization for Serverless Applications', '10.5555/3388242.3388273', 'Serverless containers and functions are widely used for deploying and managing software in the cloud. Their popularity is due to reduced cost of operations, improved utilization of hardware, and faster scaling than traditional deployment methods. The economics and scale of serverless applications demand that workloads from multiple customers run on the same hardware with minimal overhead, while preserving strong security and performance isolation. The traditional view is that there is a choice between virtualization with strong security and high overhead, and container technologies with weaker security and minimal overhead. This tradeoff is unacceptable to public infrastructure providers, who need both strong security and minimal overhead. To meet this need, we developed Firecracker, a new open source Virtual Machine Monitor (VMM) specialized for serverless workloads, but generally useful for containers, functions and other compute workloads within a reasonable set of constraints. We have deployed Firecracker in two publically-available serverless compute services at Amazon Web Services (Lambda and Fargate), where it supports millions of production workloads, and trillions of requests per month. We describe how specializing for serverless informed the design of Firecracker, and what we learned from seamlessly migrating Lambda customers to Firecracker.', 'Alexandru Agache, Marc Brooker, Andreea Florescu, Alexandra Iordache, Anthony Liguori, Rolf Neugebauer, Phil Piwonka, and Diana-Maria Popa, Amazon Web Services');
INSERT INTO public.api_paper VALUES (2, 'Faasm: Lightweight Isolation for Efficient Stateful Serverless Computing', '10.5555/3489146.3489174', 'Serverless computing is an excellent fit for big data processing because it can scale quickly and cheaply to thousands of parallel functions. Existing serverless platforms isolate functions in ephemeral, stateless containers, preventing them from directly sharing memory. This forces users to duplicate and serialise data repeatedly, adding unnecessary performance and resource costs. We believe that a new lightweight isolation approach is needed, which supports sharing memory directly between functions and reduces resource overheads.

We introduce Faaslets, a new isolation abstraction for high-performance serverless computing. Faaslets isolate the memory of executed functions using software-fault isolation (SFI), as provided by WebAssembly, while allowing memory regions to be shared between functions in the same address space. Faaslets can thus avoid expensive data movement when functions are co-located on the same machine. Our runtime for Faaslets, FAASM, isolates other resources, e.g. CPU and network, using standard Linux cgroups, and provides a low-level POSIX host interface for networking, file system access and dynamic loading. To reduce initialisation times, FAASM restores Faaslets from already-initialised snapshots. We compare FAASM to a standard container-based platform and show that, when training a machine learning model, it achieves a 2× speed-up with 10× less memory; for serving machine learning inference, FAASM doubles the throughput and reduces tail latency by 90%.', 'Simon Shillaker,  Peter Pietzuch  - Imperial College London');
INSERT INTO public.api_paper VALUES (3, 'Sledge: a Serverless-first, Light-weight Wasm Runtime for the Edge', '10.1145/3423211.3425680', 'Emerging IoT applications with real-time latency constraints require new data processing systems operating at the Edge. Serverless computing offers a new compelling paradigm, where a user can execute a small application without handling the operational issues of server provisioning and resource management. Despite a variety of existing commercial and open source serverless platforms (utilizing VMs and containers), these solutions are too heavy-weight for a resource-constrained Edge systems (due to large memory footprint and high invocation time). Moreover, serverless workloads that focus on per-client, short-running computations are not an ideal fit for existing general purpose computing systems.

In this paper, we present the design and implementation of Sledge -- a novel and efficient WebAssembly-based serverless framework for the Edge. Sledge is optimized for supporting unique properties of serverless workloads: the need for high density multi-tenancy, low startup time, bursty client request rates, and short-lived computations. Sledge is designed for these constraints by offering (i) optimized scheduling policies and efficient work-distribution for short-lived computations, and (ii) a light-weight function isolation model implemented using our own WebAssembly-based software fault isolation infrastructure. These lightweight sandboxes are designed to support high-density computation: with fast startup and teardown times to handle high client request rates. An extensive evaluation of Sledge with varying workloads and real-world serverless applications demonstrates the effectiveness of the designed serverless-first runtime for the Edge. Sledge supports up to 4 times higher throughput and 4 times lower latencies compared to Nuclio, one of the fastest open-source serverless frameworks.', 'Phani Kishore Gadepalli,  Sean McBride,  Gregor Peach,  Ludmila Cherkasova,  Gabriel Parmer');
INSERT INTO public.api_paper VALUES (4, 'Gillis: Serving Large Neural Networks in Serverless Functions with Automatic Model Partitioning', '10.1109/ICDCS51616.2021.00022', 'The increased use of deep neural networks has stimulated the growing demand for cloud-based model serving platforms. Serverless computing offers a simplified solution: users deploy models as serverless functions and let the platform handle provisioning and scaling. However, serverless functions have constrained resources in CPU and memory, making them inefficient or infeasible to serve large neural networks-which have become increasingly popular. In this paper, we present Gillis, a serverless-based model serving system that automatically partitions a large model across multiple serverless functions for faster inference and reduced memory footprint per function. Gillis employs two novel model partitioning algorithms that respectively achieve latency-optimal serving and cost-optimal serving with SLO compliance. We have implemented Gillis on three serverless platforms-AWS Lambda, Google Cloud Functions, and KNIX-with MXNet as the serving backend. Experimental evaluations against popular models show that Gillis supports serving very large neural networks, reduces the inference latency substantially, and meets various SLOs with a low serving cost.', 'Minchen Yu; Zhifeng Jiang; Hok Chun Ng; Wei Wang; Ruichuan Chen; Bo Li');
INSERT INTO public.api_paper VALUES (9, 'Distributed Double Machine Learning with a Serverless Architecture', '10.1145/3447545.3451181', 'This paper explores serverless cloud computing for double machine learning. Being based on repeated cross-fitting, double machine learning is particularly well suited to exploit the high level of parallelism achievable with serverless computing. It allows to get fast on-demand estimations without additional cloud maintenance effort. We provide a prototype Python implementation DoubleML-Serverless for the estimation of double machine learning models with the serverless computing platform AWS Lambda and demonstrate its utility with a case study analyzing estimation times and costs.', '[''Malte S. Kurz'']');


--
-- TOC entry 3185 (class 0 OID 16393)
-- Dependencies: 204
-- Data for Name: api_project; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_project VALUES (1, 'Serverless Runtime', NULL, '', false);
INSERT INTO public.api_project VALUES (2, 'Unsorted', NULL, '', true);
INSERT INTO public.api_project VALUES (3, 'Serverless ML', NULL, '', false);
INSERT INTO public.api_project VALUES (4, 'Reinforcement Learning', NULL, '', false);


--
-- TOC entry 3187 (class 0 OID 16401)
-- Dependencies: 206
-- Data for Name: api_projectcollaborator; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectcollaborator VALUES (1, 'Creator', 1, 2);
INSERT INTO public.api_projectcollaborator VALUES (3, 'Supervisor', 1, 1);


--
-- TOC entry 3189 (class 0 OID 16406)
-- Dependencies: 208
-- Data for Name: api_projectlist; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectlist VALUES (2, 'Done', false, 1);
INSERT INTO public.api_projectlist VALUES (3, 'Next', false, 1);
INSERT INTO public.api_projectlist VALUES (1, 'Next', false, 3);
INSERT INTO public.api_projectlist VALUES (4, 'Done', false, 3);
INSERT INTO public.api_projectlist VALUES (5, 'Default', false, 2);


--
-- TOC entry 3191 (class 0 OID 16411)
-- Dependencies: 210
-- Data for Name: api_projectpaper; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectpaper VALUES (1, '2022-07-10 13:46:45.088714+06', 3, 1);
INSERT INTO public.api_projectpaper VALUES (3, '2022-07-15 09:20:40.879753+06', 5, 4);
INSERT INTO public.api_projectpaper VALUES (6, '2022-07-31 14:37:19.605433+06', 5, 9);
INSERT INTO public.api_projectpaper VALUES (7, '2022-07-31 14:37:32.020396+06', 5, 9);
INSERT INTO public.api_projectpaper VALUES (8, '2022-07-31 14:37:46.497664+06', 5, 9);
INSERT INTO public.api_projectpaper VALUES (9, '2022-07-31 14:37:53.949424+06', 5, 9);


--
-- TOC entry 3193 (class 0 OID 16416)
-- Dependencies: 212
-- Data for Name: api_task; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_task VALUES (1, 'Literature Review', NULL, NULL, 'Next', 2, NULL);
INSERT INTO public.api_task VALUES (6, 'Run Code', '2022-07-18 00:00:00+06', '2022-07-08 00:00:00+06', 'Later', 2, NULL);
INSERT INTO public.api_task VALUES (2, 'Read Gillis pap', NULL, NULL, 'Next', 2, 3);
INSERT INTO public.api_task VALUES (3, 'Read Firecracker paper', '2022-08-03 00:00:00+06', NULL, 'Progress', 2, 1);


--
-- TOC entry 3194 (class 0 OID 16419)
-- Dependencies: 213
-- Data for Name: api_task_assignees; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_task_assignees VALUES (1, 1, 3);
INSERT INTO public.api_task_assignees VALUES (2, 2, 1);
INSERT INTO public.api_task_assignees VALUES (3, 3, 1);
INSERT INTO public.api_task_assignees VALUES (5, 6, 1);


--
-- TOC entry 3218 (class 0 OID 16684)
-- Dependencies: 237
-- Data for Name: api_taskdependency; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_taskdependency VALUES (1, 2, 3);
INSERT INTO public.api_taskdependency VALUES (3, 1, 3);
INSERT INTO public.api_taskdependency VALUES (4, 6, 2);
INSERT INTO public.api_taskdependency VALUES (5, 1, 1);
INSERT INTO public.api_taskdependency VALUES (6, 1, 6);
INSERT INTO public.api_taskdependency VALUES (7, 3, 6);


--
-- TOC entry 3197 (class 0 OID 16426)
-- Dependencies: 216
-- Data for Name: api_user; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_user VALUES (2, 'pbkdf2_sha256$320000$cgUGPBFbiv4gduDYAtJuQp$JrqOqdLaq1G5JF0smh7ZAiPZrWvBDP2sgKFbs3c738w=', NULL, true, 'sadia', '', '', 'sadia@gmail.com', true, true, '2022-07-16 11:02:20.682435+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (3, 'pbkdf2_sha256$320000$74knswBHXKPD9WcyFVdaIo$FIoUJyBde9T1+bZSePEY+Gd83ylBOXrptg544mo6aL0=', NULL, true, 'najib', '', '', 'najib@gmail.com', true, true, '2022-07-16 11:02:42.395261+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (1, 'pbkdf2_sha256$320000$oSzNBKuqmcoQc29WO802LH$fa/450s706xCoT5KJewjXWNnQuxc+OvDMTHJ8d1GRVU=', '2022-07-31 07:01:13.271138+06', true, 'tahmeed', '', '', 't@g.com', true, true, '2022-07-09 18:52:25.634703+06', NULL, NULL, NULL);


--
-- TOC entry 3198 (class 0 OID 16432)
-- Dependencies: 217
-- Data for Name: api_user_groups; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3201 (class 0 OID 16439)
-- Dependencies: 220
-- Data for Name: api_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3203 (class 0 OID 16444)
-- Dependencies: 222
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3205 (class 0 OID 16449)
-- Dependencies: 224
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3207 (class 0 OID 16454)
-- Dependencies: 226
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.auth_permission VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO public.auth_permission VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO public.auth_permission VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO public.auth_permission VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO public.auth_permission VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO public.auth_permission VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO public.auth_permission VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO public.auth_permission VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO public.auth_permission VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO public.auth_permission VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO public.auth_permission VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO public.auth_permission VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO public.auth_permission VALUES (25, 'Can add paper', 7, 'add_paper');
INSERT INTO public.auth_permission VALUES (26, 'Can change paper', 7, 'change_paper');
INSERT INTO public.auth_permission VALUES (27, 'Can delete paper', 7, 'delete_paper');
INSERT INTO public.auth_permission VALUES (28, 'Can view paper', 7, 'view_paper');
INSERT INTO public.auth_permission VALUES (29, 'Can add project', 8, 'add_project');
INSERT INTO public.auth_permission VALUES (30, 'Can change project', 8, 'change_project');
INSERT INTO public.auth_permission VALUES (31, 'Can delete project', 8, 'delete_project');
INSERT INTO public.auth_permission VALUES (32, 'Can view project', 8, 'view_project');
INSERT INTO public.auth_permission VALUES (33, 'Can add project list', 9, 'add_projectlist');
INSERT INTO public.auth_permission VALUES (34, 'Can change project list', 9, 'change_projectlist');
INSERT INTO public.auth_permission VALUES (35, 'Can delete project list', 9, 'delete_projectlist');
INSERT INTO public.auth_permission VALUES (36, 'Can view project list', 9, 'view_projectlist');
INSERT INTO public.auth_permission VALUES (37, 'Can add project paper', 10, 'add_projectpaper');
INSERT INTO public.auth_permission VALUES (38, 'Can change project paper', 10, 'change_projectpaper');
INSERT INTO public.auth_permission VALUES (39, 'Can delete project paper', 10, 'delete_projectpaper');
INSERT INTO public.auth_permission VALUES (40, 'Can view project paper', 10, 'view_projectpaper');
INSERT INTO public.auth_permission VALUES (41, 'Can add project collaborator', 11, 'add_projectcollaborator');
INSERT INTO public.auth_permission VALUES (42, 'Can change project collaborator', 11, 'change_projectcollaborator');
INSERT INTO public.auth_permission VALUES (43, 'Can delete project collaborator', 11, 'delete_projectcollaborator');
INSERT INTO public.auth_permission VALUES (44, 'Can view project collaborator', 11, 'view_projectcollaborator');
INSERT INTO public.auth_permission VALUES (45, 'Can add Token', 12, 'add_token');
INSERT INTO public.auth_permission VALUES (46, 'Can change Token', 12, 'change_token');
INSERT INTO public.auth_permission VALUES (47, 'Can delete Token', 12, 'delete_token');
INSERT INTO public.auth_permission VALUES (48, 'Can view Token', 12, 'view_token');
INSERT INTO public.auth_permission VALUES (49, 'Can add token', 13, 'add_tokenproxy');
INSERT INTO public.auth_permission VALUES (50, 'Can change token', 13, 'change_tokenproxy');
INSERT INTO public.auth_permission VALUES (51, 'Can delete token', 13, 'delete_tokenproxy');
INSERT INTO public.auth_permission VALUES (52, 'Can view token', 13, 'view_tokenproxy');
INSERT INTO public.auth_permission VALUES (53, 'Can add task', 14, 'add_task');
INSERT INTO public.auth_permission VALUES (54, 'Can change task', 14, 'change_task');
INSERT INTO public.auth_permission VALUES (55, 'Can delete task', 14, 'delete_task');
INSERT INTO public.auth_permission VALUES (56, 'Can view task', 14, 'view_task');
INSERT INTO public.auth_permission VALUES (57, 'Can add task dependency', 15, 'add_taskdependency');
INSERT INTO public.auth_permission VALUES (58, 'Can change task dependency', 15, 'change_taskdependency');
INSERT INTO public.auth_permission VALUES (59, 'Can delete task dependency', 15, 'delete_taskdependency');
INSERT INTO public.auth_permission VALUES (60, 'Can view task dependency', 15, 'view_taskdependency');


--
-- TOC entry 3209 (class 0 OID 16459)
-- Dependencies: 228
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authtoken_token VALUES ('2a1f52e7dfab9ef3658b1263daa5dc3df5448eed', '2022-07-10 21:09:40.57258+06', 1);
INSERT INTO public.authtoken_token VALUES ('fcae8400680fca2a7dc3dd18244e2a873d6c06f3', '2022-07-16 11:02:21.094875+06', 2);
INSERT INTO public.authtoken_token VALUES ('8e51af3341b226c342d27167c44948af239f0d9d', '2022-07-16 11:02:42.702582+06', 3);


--
-- TOC entry 3210 (class 0 OID 16462)
-- Dependencies: 229
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.django_admin_log VALUES (1, '2022-07-09 18:55:42.682844+06', '1', 'Paper object (1)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (2, '2022-07-10 12:59:53.127271+06', '1', 'Paper object (1)', 2, '[{"changed": {"fields": ["Doi"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (3, '2022-07-10 13:01:57.624202+06', '2', 'Paper object (2)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (4, '2022-07-10 13:03:03.67845+06', '3', 'Paper object (3)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (5, '2022-07-10 13:40:47.117425+06', '1', 'Project object (1)', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (6, '2022-07-10 13:40:58.042362+06', '2', 'Project object (2)', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (7, '2022-07-10 13:41:05.986234+06', '3', 'Project object (3)', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (8, '2022-07-10 13:42:08.315813+06', '1', 'ProjectCollaborator object (1)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (9, '2022-07-10 13:42:31.424029+06', '2', 'ProjectCollaborator object (2)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (10, '2022-07-10 13:42:43.960937+06', '3', 'ProjectCollaborator object (3)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (11, '2022-07-10 13:43:55.787177+06', '4', '4-Gillis: Serving Larg', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (12, '2022-07-10 13:45:13.898679+06', '1', 'ProjectList object (1)', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (13, '2022-07-10 13:45:20.752758+06', '2', 'ProjectList object (2)', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (14, '2022-07-10 13:45:27.4209+06', '3', 'ProjectList object (3)', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (15, '2022-07-10 13:45:41.853126+06', '1', 'ProjectList object (1)', 2, '[{"changed": {"fields": ["Project"]}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (16, '2022-07-10 13:45:49.693954+06', '4', 'ProjectList object (4)', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (17, '2022-07-10 13:46:45.090439+06', '1', 'ProjectPaper object (1)', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (18, '2022-07-10 13:47:56.14259+06', '4', '4-Reinforcement Learning', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (19, '2022-07-10 18:12:25.689049+06', '5', 'Default-Unsorted', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (20, '2022-07-15 09:20:31.646667+06', '2', 'ProjectPaper object (2)', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (21, '2022-07-15 09:55:54.341596+06', '3', 'ProjectPaper object (3)', 2, '[{"changed": {"fields": ["List"]}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (22, '2022-07-15 09:56:36.716343+06', '2', 'ProjectCollaborator object (2)', 3, '', 11, 1);
INSERT INTO public.django_admin_log VALUES (23, '2022-07-16 10:28:49.851861+06', '1', 'Task object (1)', 1, '[{"added": {}}]', 14, 1);
INSERT INTO public.django_admin_log VALUES (24, '2022-07-28 08:33:01.316974+06', '3', 'Task object (3)', 2, '[{"changed": {"fields": ["Project paper"]}}]', 14, 1);
INSERT INTO public.django_admin_log VALUES (25, '2022-07-31 14:23:33.530607+06', '4', '4-Distributed Double M...-Done', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (26, '2022-07-31 14:23:44.573191+06', '8', '8-Distributed Double M...', 3, '', 7, 1);
INSERT INTO public.django_admin_log VALUES (27, '2022-07-31 14:31:14.1242+06', '5', '5-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (28, '2022-07-31 15:11:59.436236+06', '1', 'TaskDependency object (1)', 1, '[{"added": {}}]', 15, 1);
INSERT INTO public.django_admin_log VALUES (29, '2022-07-31 15:11:59.550283+06', '2', 'TaskDependency object (2)', 1, '[{"added": {}}]', 15, 1);
INSERT INTO public.django_admin_log VALUES (30, '2022-07-31 15:12:13.158998+06', '3', 'TaskDependency object (3)', 1, '[{"added": {}}]', 15, 1);
INSERT INTO public.django_admin_log VALUES (31, '2022-07-31 15:12:17.931844+06', '2', 'TaskDependency object (2)', 3, '', 15, 1);
INSERT INTO public.django_admin_log VALUES (32, '2022-07-31 15:16:09.766898+06', '4', 'TaskDependency object (4)', 1, '[{"added": {}}]', 15, 1);
INSERT INTO public.django_admin_log VALUES (33, '2022-07-31 16:02:04.846943+06', '1', 'Task object (1)', 2, '[{"changed": {"fields": ["Project"]}}]', 14, 1);
INSERT INTO public.django_admin_log VALUES (34, '2022-07-31 16:02:46.891339+06', '6', 'Task object (6)', 2, '[{"changed": {"fields": ["Assignees"]}}]', 14, 1);


--
-- TOC entry 3212 (class 0 OID 16471)
-- Dependencies: 231
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.django_content_type VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type VALUES (5, 'sessions', 'session');
INSERT INTO public.django_content_type VALUES (6, 'api', 'user');
INSERT INTO public.django_content_type VALUES (7, 'api', 'paper');
INSERT INTO public.django_content_type VALUES (8, 'api', 'project');
INSERT INTO public.django_content_type VALUES (9, 'api', 'projectlist');
INSERT INTO public.django_content_type VALUES (10, 'api', 'projectpaper');
INSERT INTO public.django_content_type VALUES (11, 'api', 'projectcollaborator');
INSERT INTO public.django_content_type VALUES (12, 'authtoken', 'token');
INSERT INTO public.django_content_type VALUES (13, 'authtoken', 'tokenproxy');
INSERT INTO public.django_content_type VALUES (14, 'api', 'task');
INSERT INTO public.django_content_type VALUES (15, 'api', 'taskdependency');


--
-- TOC entry 3214 (class 0 OID 16476)
-- Dependencies: 233
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.django_migrations VALUES (1, 'contenttypes', '0001_initial', '2022-07-09 18:50:48.323278+06');
INSERT INTO public.django_migrations VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2022-07-09 18:50:48.655122+06');
INSERT INTO public.django_migrations VALUES (3, 'auth', '0001_initial', '2022-07-09 18:50:50.128931+06');
INSERT INTO public.django_migrations VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2022-07-09 18:50:50.154992+06');
INSERT INTO public.django_migrations VALUES (5, 'auth', '0003_alter_user_email_max_length', '2022-07-09 18:50:50.182944+06');
INSERT INTO public.django_migrations VALUES (6, 'auth', '0004_alter_user_username_opts', '2022-07-09 18:50:50.270495+06');
INSERT INTO public.django_migrations VALUES (7, 'auth', '0005_alter_user_last_login_null', '2022-07-09 18:50:50.370567+06');
INSERT INTO public.django_migrations VALUES (8, 'auth', '0006_require_contenttypes_0002', '2022-07-09 18:50:50.377139+06');
INSERT INTO public.django_migrations VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2022-07-09 18:50:50.412666+06');
INSERT INTO public.django_migrations VALUES (10, 'auth', '0008_alter_user_username_max_length', '2022-07-09 18:50:50.435039+06');
INSERT INTO public.django_migrations VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2022-07-09 18:50:50.4604+06');
INSERT INTO public.django_migrations VALUES (12, 'auth', '0010_alter_group_name_max_length', '2022-07-09 18:50:50.481009+06');
INSERT INTO public.django_migrations VALUES (13, 'auth', '0011_update_proxy_permissions', '2022-07-09 18:50:50.510196+06');
INSERT INTO public.django_migrations VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2022-07-09 18:50:50.532668+06');
INSERT INTO public.django_migrations VALUES (15, 'api', '0001_initial', '2022-07-09 18:50:52.5575+06');
INSERT INTO public.django_migrations VALUES (16, 'admin', '0001_initial', '2022-07-09 18:50:52.836377+06');
INSERT INTO public.django_migrations VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2022-07-09 18:50:52.867263+06');
INSERT INTO public.django_migrations VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2022-07-09 18:50:52.899611+06');
INSERT INTO public.django_migrations VALUES (19, 'sessions', '0001_initial', '2022-07-09 18:50:53.176178+06');
INSERT INTO public.django_migrations VALUES (20, 'authtoken', '0001_initial', '2022-07-10 21:08:58.692323+06');
INSERT INTO public.django_migrations VALUES (21, 'authtoken', '0002_auto_20160226_1747', '2022-07-10 21:08:58.753815+06');
INSERT INTO public.django_migrations VALUES (22, 'authtoken', '0003_tokenproxy', '2022-07-10 21:08:58.760859+06');
INSERT INTO public.django_migrations VALUES (23, 'api', '0002_task', '2022-07-16 09:50:24.071885+06');
INSERT INTO public.django_migrations VALUES (24, 'api', '0003_alter_task_project_alter_task_project_paper', '2022-07-16 10:26:19.493513+06');
INSERT INTO public.django_migrations VALUES (25, 'api', '0004_taskdependency', '2022-07-31 15:08:07.563754+06');


--
-- TOC entry 3216 (class 0 OID 16484)
-- Dependencies: 235
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.django_session VALUES ('h2kcgfjqy1cg3pjrgkulicwsjrwe10s5', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oA9wp:HFkgxAjr2RptxgTwcnCdwMK-OaDn35WgP5Vj8JlVmvI', '2022-07-23 18:52:35.733767+06');
INSERT INTO public.django_session VALUES ('d5j9lax6erkmrpl621lk705lwjlicyw6', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oCZJr:GsYugvkRgOGZwTv-NEBUodBhPEOvL1Y-auoN55d_0ms', '2022-07-30 10:22:19.016834+06');
INSERT INTO public.django_session VALUES ('p0280unxtdtlamifarfclc7izgzzopj3', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oHxKT:324PHZlDrAiCQ_z_BODesm7BrPxyK0cGZoJrvdgRPPk', '2022-08-14 07:01:13.276673+06');


--
-- TOC entry 3241 (class 0 OID 0)
-- Dependencies: 203
-- Name: api_paper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_paper_id_seq', 9, true);


--
-- TOC entry 3242 (class 0 OID 0)
-- Dependencies: 205
-- Name: api_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_project_id_seq', 4, true);


--
-- TOC entry 3243 (class 0 OID 0)
-- Dependencies: 207
-- Name: api_projectcollaborator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectcollaborator_id_seq', 3, true);


--
-- TOC entry 3244 (class 0 OID 0)
-- Dependencies: 209
-- Name: api_projectlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectlist_id_seq', 5, true);


--
-- TOC entry 3245 (class 0 OID 0)
-- Dependencies: 211
-- Name: api_projectpaper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectpaper_id_seq', 9, true);


--
-- TOC entry 3246 (class 0 OID 0)
-- Dependencies: 214
-- Name: api_task_assignees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_task_assignees_id_seq', 5, true);


--
-- TOC entry 3247 (class 0 OID 0)
-- Dependencies: 215
-- Name: api_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_task_id_seq', 6, true);


--
-- TOC entry 3248 (class 0 OID 0)
-- Dependencies: 236
-- Name: api_taskdependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_taskdependency_id_seq', 7, true);


--
-- TOC entry 3249 (class 0 OID 0)
-- Dependencies: 218
-- Name: api_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_groups_id_seq', 1, false);


--
-- TOC entry 3250 (class 0 OID 0)
-- Dependencies: 219
-- Name: api_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_id_seq', 3, true);


--
-- TOC entry 3251 (class 0 OID 0)
-- Dependencies: 221
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3252 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3253 (class 0 OID 0)
-- Dependencies: 225
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3254 (class 0 OID 0)
-- Dependencies: 227
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 60, true);


--
-- TOC entry 3255 (class 0 OID 0)
-- Dependencies: 230
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 34, true);


--
-- TOC entry 3256 (class 0 OID 0)
-- Dependencies: 232
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 15, true);


--
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 234
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- TOC entry 2954 (class 2606 OID 16507)
-- Name: api_paper api_paper_doi_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper
    ADD CONSTRAINT api_paper_doi_key UNIQUE (doi);


--
-- TOC entry 2956 (class 2606 OID 16509)
-- Name: api_paper api_paper_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper
    ADD CONSTRAINT api_paper_pkey PRIMARY KEY (id);


--
-- TOC entry 2958 (class 2606 OID 16511)
-- Name: api_project api_project_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project
    ADD CONSTRAINT api_project_pkey PRIMARY KEY (id);


--
-- TOC entry 2961 (class 2606 OID 16513)
-- Name: api_projectcollaborator api_projectcollaborator_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_pkey PRIMARY KEY (id);


--
-- TOC entry 2964 (class 2606 OID 16515)
-- Name: api_projectlist api_projectlist_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist
    ADD CONSTRAINT api_projectlist_pkey PRIMARY KEY (id);


--
-- TOC entry 2969 (class 2606 OID 16517)
-- Name: api_projectpaper api_projectpaper_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_pkey PRIMARY KEY (id);


--
-- TOC entry 2975 (class 2606 OID 16519)
-- Name: api_task_assignees api_task_assignees_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_pkey PRIMARY KEY (id);


--
-- TOC entry 2979 (class 2606 OID 16521)
-- Name: api_task_assignees api_task_assignees_task_id_projectcollaborator_id_cd4b9818_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_task_id_projectcollaborator_id_cd4b9818_uniq UNIQUE (task_id, projectcollaborator_id);


--
-- TOC entry 2971 (class 2606 OID 16523)
-- Name: api_task api_task_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_pkey PRIMARY KEY (id);


--
-- TOC entry 3035 (class 2606 OID 16689)
-- Name: api_taskdependency api_taskdependency_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_pkey PRIMARY KEY (id);


--
-- TOC entry 2987 (class 2606 OID 16525)
-- Name: api_user_groups api_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2990 (class 2606 OID 16527)
-- Name: api_user_groups api_user_groups_user_id_group_id_9c7ddfb5_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_group_id_9c7ddfb5_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 2981 (class 2606 OID 16529)
-- Name: api_user api_user_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2993 (class 2606 OID 16531)
-- Name: api_user_user_permissions api_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2996 (class 2606 OID 16533)
-- Name: api_user_user_permissions api_user_user_permissions_user_id_permission_id_a06dd704_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_permission_id_a06dd704_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 2984 (class 2606 OID 16535)
-- Name: api_user api_user_username_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_username_key UNIQUE (username);


--
-- TOC entry 2999 (class 2606 OID 16537)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3004 (class 2606 OID 16539)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3007 (class 2606 OID 16541)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3001 (class 2606 OID 16543)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3010 (class 2606 OID 16545)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3012 (class 2606 OID 16547)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3015 (class 2606 OID 16549)
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- TOC entry 3017 (class 2606 OID 16551)
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- TOC entry 3020 (class 2606 OID 16553)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3023 (class 2606 OID 16555)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3025 (class 2606 OID 16557)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3027 (class 2606 OID 16559)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3030 (class 2606 OID 16561)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 2952 (class 1259 OID 16562)
-- Name: api_paper_doi_0cc7a2e7_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_paper_doi_0cc7a2e7_like ON public.api_paper USING btree (doi varchar_pattern_ops);


--
-- TOC entry 2959 (class 1259 OID 16563)
-- Name: api_projectcollaborator_collaborator_id_d1fb635f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectcollaborator_collaborator_id_d1fb635f ON public.api_projectcollaborator USING btree (collaborator_id);


--
-- TOC entry 2962 (class 1259 OID 16564)
-- Name: api_projectcollaborator_project_id_f4fb87e6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectcollaborator_project_id_f4fb87e6 ON public.api_projectcollaborator USING btree (project_id);


--
-- TOC entry 2965 (class 1259 OID 16565)
-- Name: api_projectlist_project_id_d9e8ea7d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectlist_project_id_d9e8ea7d ON public.api_projectlist USING btree (project_id);


--
-- TOC entry 2966 (class 1259 OID 16566)
-- Name: api_projectpaper_list_id_6b0c4e68; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectpaper_list_id_6b0c4e68 ON public.api_projectpaper USING btree (list_id);


--
-- TOC entry 2967 (class 1259 OID 16567)
-- Name: api_projectpaper_paper_id_83fe75a8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectpaper_paper_id_83fe75a8 ON public.api_projectpaper USING btree (paper_id);


--
-- TOC entry 2976 (class 1259 OID 16568)
-- Name: api_task_assignees_projectcollaborator_id_3464d049; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_assignees_projectcollaborator_id_3464d049 ON public.api_task_assignees USING btree (projectcollaborator_id);


--
-- TOC entry 2977 (class 1259 OID 16569)
-- Name: api_task_assignees_task_id_692b56f6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_assignees_task_id_692b56f6 ON public.api_task_assignees USING btree (task_id);


--
-- TOC entry 2972 (class 1259 OID 16570)
-- Name: api_task_project_id_8e1d0a15; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_project_id_8e1d0a15 ON public.api_task USING btree (project_id);


--
-- TOC entry 2973 (class 1259 OID 16571)
-- Name: api_task_project_paper_id_7c142334; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_project_paper_id_7c142334 ON public.api_task USING btree (project_paper_id);


--
-- TOC entry 3032 (class 1259 OID 16700)
-- Name: api_taskdependency_after_id_a99d92c9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_taskdependency_after_id_a99d92c9 ON public.api_taskdependency USING btree (after_id);


--
-- TOC entry 3033 (class 1259 OID 16701)
-- Name: api_taskdependency_before_id_e2735fe0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_taskdependency_before_id_e2735fe0 ON public.api_taskdependency USING btree (before_id);


--
-- TOC entry 2985 (class 1259 OID 16572)
-- Name: api_user_groups_group_id_3af85785; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_groups_group_id_3af85785 ON public.api_user_groups USING btree (group_id);


--
-- TOC entry 2988 (class 1259 OID 16573)
-- Name: api_user_groups_user_id_a5ff39fa; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_groups_user_id_a5ff39fa ON public.api_user_groups USING btree (user_id);


--
-- TOC entry 2991 (class 1259 OID 16574)
-- Name: api_user_user_permissions_permission_id_305b7fea; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_user_permissions_permission_id_305b7fea ON public.api_user_user_permissions USING btree (permission_id);


--
-- TOC entry 2994 (class 1259 OID 16575)
-- Name: api_user_user_permissions_user_id_f3945d65; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_user_permissions_user_id_f3945d65 ON public.api_user_user_permissions USING btree (user_id);


--
-- TOC entry 2982 (class 1259 OID 16576)
-- Name: api_user_username_cf4e88d2_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_username_cf4e88d2_like ON public.api_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 2997 (class 1259 OID 16577)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3002 (class 1259 OID 16578)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3005 (class 1259 OID 16579)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3008 (class 1259 OID 16580)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3013 (class 1259 OID 16581)
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- TOC entry 3018 (class 1259 OID 16582)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3021 (class 1259 OID 16583)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3028 (class 1259 OID 16584)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3031 (class 1259 OID 16585)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3036 (class 2606 OID 16586)
-- Name: api_projectcollaborator api_projectcollaborator_collaborator_id_d1fb635f_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_collaborator_id_d1fb635f_fk_api_user_id FOREIGN KEY (collaborator_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3037 (class 2606 OID 16591)
-- Name: api_projectcollaborator api_projectcollaborator_project_id_f4fb87e6_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_project_id_f4fb87e6_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3038 (class 2606 OID 16596)
-- Name: api_projectlist api_projectlist_project_id_d9e8ea7d_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist
    ADD CONSTRAINT api_projectlist_project_id_d9e8ea7d_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3039 (class 2606 OID 16601)
-- Name: api_projectpaper api_projectpaper_list_id_6b0c4e68_fk_api_projectlist_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_list_id_6b0c4e68_fk_api_projectlist_id FOREIGN KEY (list_id) REFERENCES public.api_projectlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3040 (class 2606 OID 16606)
-- Name: api_projectpaper api_projectpaper_paper_id_83fe75a8_fk_api_paper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_paper_id_83fe75a8_fk_api_paper_id FOREIGN KEY (paper_id) REFERENCES public.api_paper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3043 (class 2606 OID 16611)
-- Name: api_task_assignees api_task_assignees_projectcollaborator__3464d049_fk_api_proje; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_projectcollaborator__3464d049_fk_api_proje FOREIGN KEY (projectcollaborator_id) REFERENCES public.api_projectcollaborator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3044 (class 2606 OID 16616)
-- Name: api_task_assignees api_task_assignees_task_id_692b56f6_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_task_id_692b56f6_fk_api_task_id FOREIGN KEY (task_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3041 (class 2606 OID 16621)
-- Name: api_task api_task_project_id_8e1d0a15_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_project_id_8e1d0a15_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3042 (class 2606 OID 16626)
-- Name: api_task api_task_project_paper_id_7c142334_fk_api_projectpaper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_project_paper_id_7c142334_fk_api_projectpaper_id FOREIGN KEY (project_paper_id) REFERENCES public.api_projectpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3055 (class 2606 OID 16690)
-- Name: api_taskdependency api_taskdependency_after_id_a99d92c9_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_after_id_a99d92c9_fk_api_task_id FOREIGN KEY (after_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3056 (class 2606 OID 16695)
-- Name: api_taskdependency api_taskdependency_before_id_e2735fe0_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_before_id_e2735fe0_fk_api_task_id FOREIGN KEY (before_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3045 (class 2606 OID 16631)
-- Name: api_user_groups api_user_groups_group_id_3af85785_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_group_id_3af85785_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3046 (class 2606 OID 16636)
-- Name: api_user_groups api_user_groups_user_id_a5ff39fa_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_a5ff39fa_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3047 (class 2606 OID 16641)
-- Name: api_user_user_permissions api_user_user_permis_permission_id_305b7fea_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permis_permission_id_305b7fea_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3048 (class 2606 OID 16646)
-- Name: api_user_user_permissions api_user_user_permissions_user_id_f3945d65_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_f3945d65_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3049 (class 2606 OID 16651)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3050 (class 2606 OID 16656)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3051 (class 2606 OID 16661)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3052 (class 2606 OID 16666)
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3053 (class 2606 OID 16671)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3054 (class 2606 OID 16676)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2022-08-12 08:07:33 +06

--
-- PostgreSQL database dump complete
--

