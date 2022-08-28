--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

-- Started on 2022-08-28 07:21:39 +06

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
-- Name: api_conference; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_conference (
    venue_ptr_id bigint NOT NULL,
    isbn character varying(256)
);


ALTER TABLE public.api_conference OWNER TO "user";

--
-- TOC entry 203 (class 1259 OID 16388)
-- Name: api_domain; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_domain (
    id bigint NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.api_domain OWNER TO "user";

--
-- TOC entry 204 (class 1259 OID 16391)
-- Name: api_domain_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_domain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_domain_id_seq OWNER TO "user";

--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 204
-- Name: api_domain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_domain_id_seq OWNED BY public.api_domain.id;


--
-- TOC entry 205 (class 1259 OID 16393)
-- Name: api_fileupload; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_fileupload (
    id bigint NOT NULL,
    file character varying(100) NOT NULL,
    upload_date timestamp with time zone NOT NULL,
    content character varying(64) NOT NULL,
    status character varying(64) NOT NULL,
    name character varying(256) NOT NULL,
    project_id bigint NOT NULL,
    uploader_id bigint NOT NULL
);


ALTER TABLE public.api_fileupload OWNER TO "user";

--
-- TOC entry 206 (class 1259 OID 16396)
-- Name: api_fileupload_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_fileupload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_fileupload_id_seq OWNER TO "user";

--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 206
-- Name: api_fileupload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_fileupload_id_seq OWNED BY public.api_fileupload.id;


--
-- TOC entry 207 (class 1259 OID 16398)
-- Name: api_journal; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_journal (
    venue_ptr_id bigint NOT NULL,
    issn character varying(256)
);


ALTER TABLE public.api_journal OWNER TO "user";

--
-- TOC entry 208 (class 1259 OID 16401)
-- Name: api_keyword; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_keyword (
    id bigint NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.api_keyword OWNER TO "user";

--
-- TOC entry 209 (class 1259 OID 16404)
-- Name: api_keyword_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_keyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_keyword_id_seq OWNER TO "user";

--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 209
-- Name: api_keyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_keyword_id_seq OWNED BY public.api_keyword.id;


--
-- TOC entry 210 (class 1259 OID 16406)
-- Name: api_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_note (
    text text NOT NULL,
    visibility character varying(64) NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    creator_id bigint,
    id bigint NOT NULL
);


ALTER TABLE public.api_note OWNER TO "user";

--
-- TOC entry 211 (class 1259 OID 16412)
-- Name: api_paper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_paper (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    doi character varying(256),
    abstract text NOT NULL,
    authors character varying(1024) NOT NULL,
    venue_id bigint
);


ALTER TABLE public.api_paper OWNER TO "user";

--
-- TOC entry 212 (class 1259 OID 16418)
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
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 212
-- Name: api_paper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_paper_id_seq OWNED BY public.api_paper.id;


--
-- TOC entry 213 (class 1259 OID 16420)
-- Name: api_paper_keywords; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_paper_keywords (
    id bigint NOT NULL,
    paper_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.api_paper_keywords OWNER TO "user";

--
-- TOC entry 214 (class 1259 OID 16423)
-- Name: api_paper_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_paper_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_paper_keywords_id_seq OWNER TO "user";

--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 214
-- Name: api_paper_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_paper_keywords_id_seq OWNED BY public.api_paper_keywords.id;


--
-- TOC entry 215 (class 1259 OID 16425)
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
-- TOC entry 216 (class 1259 OID 16431)
-- Name: api_project_domains; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_project_domains (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    domain_id bigint NOT NULL
);


ALTER TABLE public.api_project_domains OWNER TO "user";

--
-- TOC entry 217 (class 1259 OID 16434)
-- Name: api_project_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_project_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_domains_id_seq OWNER TO "user";

--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 217
-- Name: api_project_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_project_domains_id_seq OWNED BY public.api_project_domains.id;


--
-- TOC entry 218 (class 1259 OID 16436)
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
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 218
-- Name: api_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_project_id_seq OWNED BY public.api_project.id;


--
-- TOC entry 219 (class 1259 OID 16438)
-- Name: api_project_keywords; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_project_keywords (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.api_project_keywords OWNER TO "user";

--
-- TOC entry 220 (class 1259 OID 16441)
-- Name: api_project_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_project_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_keywords_id_seq OWNER TO "user";

--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 220
-- Name: api_project_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_project_keywords_id_seq OWNED BY public.api_project_keywords.id;


--
-- TOC entry 221 (class 1259 OID 16443)
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
-- TOC entry 222 (class 1259 OID 16446)
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
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 222
-- Name: api_projectcollaborator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectcollaborator_id_seq OWNED BY public.api_projectcollaborator.id;


--
-- TOC entry 223 (class 1259 OID 16448)
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
-- TOC entry 224 (class 1259 OID 16451)
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
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 224
-- Name: api_projectlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectlist_id_seq OWNED BY public.api_projectlist.id;


--
-- TOC entry 225 (class 1259 OID 16453)
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
-- TOC entry 226 (class 1259 OID 16456)
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
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 226
-- Name: api_projectpaper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_projectpaper_id_seq OWNED BY public.api_projectpaper.id;


--
-- TOC entry 227 (class 1259 OID 16458)
-- Name: api_reviewer; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_reviewer (
    id bigint NOT NULL,
    review text,
    is_submitted boolean NOT NULL,
    submit_date timestamp with time zone,
    user_id bigint NOT NULL,
    submission_id bigint NOT NULL
);


ALTER TABLE public.api_reviewer OWNER TO "user";

--
-- TOC entry 228 (class 1259 OID 16464)
-- Name: api_reviewer_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_reviewer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_reviewer_id_seq OWNER TO "user";

--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 228
-- Name: api_reviewer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_reviewer_id_seq OWNED BY public.api_reviewer.id;


--
-- TOC entry 229 (class 1259 OID 16466)
-- Name: api_reviewerproposal; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_reviewerproposal (
    id bigint NOT NULL,
    sent timestamp with time zone NOT NULL,
    reviewer_id bigint NOT NULL,
    venue_id bigint NOT NULL,
    status character varying(64) NOT NULL
);


ALTER TABLE public.api_reviewerproposal OWNER TO "user";

--
-- TOC entry 230 (class 1259 OID 16469)
-- Name: api_reviewerproposal_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_reviewerproposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_reviewerproposal_id_seq OWNER TO "user";

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 230
-- Name: api_reviewerproposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_reviewerproposal_id_seq OWNED BY public.api_reviewerproposal.id;


--
-- TOC entry 231 (class 1259 OID 16471)
-- Name: api_submission; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_submission (
    id bigint NOT NULL,
    status character varying(128) NOT NULL,
    submitted timestamp with time zone,
    project_id bigint NOT NULL,
    venue_id bigint,
    name character varying(256) NOT NULL
);


ALTER TABLE public.api_submission OWNER TO "user";

--
-- TOC entry 232 (class 1259 OID 16474)
-- Name: api_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_submission_id_seq OWNER TO "user";

--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 232
-- Name: api_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_submission_id_seq OWNED BY public.api_submission.id;


--
-- TOC entry 233 (class 1259 OID 16476)
-- Name: api_submissioncomment; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_submissioncomment (
    id bigint NOT NULL,
    text text NOT NULL,
    user_id bigint NOT NULL,
    reviewer_thread_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    datetime timestamp with time zone NOT NULL,
    highlight_metadata jsonb,
    parent_id bigint
);


ALTER TABLE public.api_submissioncomment OWNER TO "user";

--
-- TOC entry 234 (class 1259 OID 16482)
-- Name: api_submissioncomment_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_submissioncomment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_submissioncomment_id_seq OWNER TO "user";

--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 234
-- Name: api_submissioncomment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_submissioncomment_id_seq OWNED BY public.api_submissioncomment.id;


--
-- TOC entry 235 (class 1259 OID 16484)
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
-- TOC entry 236 (class 1259 OID 16487)
-- Name: api_task_assignees; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_task_assignees (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    projectcollaborator_id bigint NOT NULL
);


ALTER TABLE public.api_task_assignees OWNER TO "user";

--
-- TOC entry 237 (class 1259 OID 16490)
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
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 237
-- Name: api_task_assignees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_task_assignees_id_seq OWNED BY public.api_task_assignees.id;


--
-- TOC entry 238 (class 1259 OID 16492)
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
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 238
-- Name: api_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_task_id_seq OWNED BY public.api_task.id;


--
-- TOC entry 239 (class 1259 OID 16494)
-- Name: api_taskdependency; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_taskdependency (
    id bigint NOT NULL,
    after_id bigint NOT NULL,
    before_id bigint NOT NULL
);


ALTER TABLE public.api_taskdependency OWNER TO "user";

--
-- TOC entry 240 (class 1259 OID 16497)
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
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 240
-- Name: api_taskdependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_taskdependency_id_seq OWNED BY public.api_taskdependency.id;


--
-- TOC entry 241 (class 1259 OID 16499)
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
-- TOC entry 242 (class 1259 OID 16505)
-- Name: api_user_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.api_user_groups OWNER TO "user";

--
-- TOC entry 243 (class 1259 OID 16508)
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
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 243
-- Name: api_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_groups_id_seq OWNED BY public.api_user_groups.id;


--
-- TOC entry 244 (class 1259 OID 16510)
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
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 244
-- Name: api_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_id_seq OWNED BY public.api_user.id;


--
-- TOC entry 245 (class 1259 OID 16512)
-- Name: api_user_user_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.api_user_user_permissions OWNER TO "user";

--
-- TOC entry 246 (class 1259 OID 16515)
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
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 246
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_user_user_permissions_id_seq OWNED BY public.api_user_user_permissions.id;


--
-- TOC entry 247 (class 1259 OID 16517)
-- Name: api_venue; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_venue (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    website character varying(256),
    "end" timestamp with time zone NOT NULL,
    start timestamp with time zone NOT NULL
);


ALTER TABLE public.api_venue OWNER TO "user";

--
-- TOC entry 248 (class 1259 OID 16523)
-- Name: api_venue_domains; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_venue_domains (
    id bigint NOT NULL,
    venue_id bigint NOT NULL,
    domain_id bigint NOT NULL
);


ALTER TABLE public.api_venue_domains OWNER TO "user";

--
-- TOC entry 249 (class 1259 OID 16526)
-- Name: api_venue_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_venue_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_venue_domains_id_seq OWNER TO "user";

--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 249
-- Name: api_venue_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_venue_domains_id_seq OWNED BY public.api_venue_domains.id;


--
-- TOC entry 250 (class 1259 OID 16528)
-- Name: api_venue_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_venue_id_seq OWNER TO "user";

--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 250
-- Name: api_venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_venue_id_seq OWNED BY public.api_venue.id;


--
-- TOC entry 251 (class 1259 OID 16530)
-- Name: api_venue_keywords; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_venue_keywords (
    id bigint NOT NULL,
    venue_id bigint NOT NULL,
    keyword_id bigint NOT NULL
);


ALTER TABLE public.api_venue_keywords OWNER TO "user";

--
-- TOC entry 252 (class 1259 OID 16533)
-- Name: api_venue_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_venue_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_venue_keywords_id_seq OWNER TO "user";

--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 252
-- Name: api_venue_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_venue_keywords_id_seq OWNED BY public.api_venue_keywords.id;


--
-- TOC entry 253 (class 1259 OID 16535)
-- Name: api_venue_reviewers; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_venue_reviewers (
    id bigint NOT NULL,
    venue_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.api_venue_reviewers OWNER TO "user";

--
-- TOC entry 254 (class 1259 OID 16538)
-- Name: api_venue_reviewers_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_venue_reviewers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_venue_reviewers_id_seq OWNER TO "user";

--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 254
-- Name: api_venue_reviewers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_venue_reviewers_id_seq OWNED BY public.api_venue_reviewers.id;


--
-- TOC entry 255 (class 1259 OID 16540)
-- Name: api_venueactivity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_venueactivity (
    id bigint NOT NULL,
    activity character varying(256) NOT NULL,
    start timestamp with time zone,
    "end" timestamp with time zone NOT NULL,
    venue_id bigint NOT NULL
);


ALTER TABLE public.api_venueactivity OWNER TO "user";

--
-- TOC entry 256 (class 1259 OID 16543)
-- Name: api_venueschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_venueschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_venueschedule_id_seq OWNER TO "user";

--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 256
-- Name: api_venueschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_venueschedule_id_seq OWNED BY public.api_venueactivity.id;


--
-- TOC entry 257 (class 1259 OID 16545)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO "user";

--
-- TOC entry 258 (class 1259 OID 16548)
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
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 258
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 259 (class 1259 OID 16550)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO "user";

--
-- TOC entry 260 (class 1259 OID 16553)
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
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 260
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 261 (class 1259 OID 16555)
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
-- TOC entry 262 (class 1259 OID 16558)
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
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 262
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 263 (class 1259 OID 16560)
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO "user";

--
-- TOC entry 264 (class 1259 OID 16563)
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
-- TOC entry 265 (class 1259 OID 16570)
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
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 265
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 266 (class 1259 OID 16572)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO "user";

--
-- TOC entry 267 (class 1259 OID 16575)
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
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 267
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 268 (class 1259 OID 16577)
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
-- TOC entry 269 (class 1259 OID 16583)
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
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 269
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 270 (class 1259 OID 16585)
-- Name: django_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO "user";

--
-- TOC entry 3040 (class 2604 OID 16591)
-- Name: api_domain id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_domain ALTER COLUMN id SET DEFAULT nextval('public.api_domain_id_seq'::regclass);


--
-- TOC entry 3041 (class 2604 OID 16592)
-- Name: api_fileupload id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_fileupload ALTER COLUMN id SET DEFAULT nextval('public.api_fileupload_id_seq'::regclass);


--
-- TOC entry 3042 (class 2604 OID 16593)
-- Name: api_keyword id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_keyword ALTER COLUMN id SET DEFAULT nextval('public.api_keyword_id_seq'::regclass);


--
-- TOC entry 3043 (class 2604 OID 16594)
-- Name: api_paper id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper ALTER COLUMN id SET DEFAULT nextval('public.api_paper_id_seq'::regclass);


--
-- TOC entry 3044 (class 2604 OID 16595)
-- Name: api_paper_keywords id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper_keywords ALTER COLUMN id SET DEFAULT nextval('public.api_paper_keywords_id_seq'::regclass);


--
-- TOC entry 3045 (class 2604 OID 16596)
-- Name: api_project id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project ALTER COLUMN id SET DEFAULT nextval('public.api_project_id_seq'::regclass);


--
-- TOC entry 3046 (class 2604 OID 16597)
-- Name: api_project_domains id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_domains ALTER COLUMN id SET DEFAULT nextval('public.api_project_domains_id_seq'::regclass);


--
-- TOC entry 3047 (class 2604 OID 16598)
-- Name: api_project_keywords id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_keywords ALTER COLUMN id SET DEFAULT nextval('public.api_project_keywords_id_seq'::regclass);


--
-- TOC entry 3048 (class 2604 OID 16599)
-- Name: api_projectcollaborator id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator ALTER COLUMN id SET DEFAULT nextval('public.api_projectcollaborator_id_seq'::regclass);


--
-- TOC entry 3049 (class 2604 OID 16600)
-- Name: api_projectlist id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist ALTER COLUMN id SET DEFAULT nextval('public.api_projectlist_id_seq'::regclass);


--
-- TOC entry 3050 (class 2604 OID 16601)
-- Name: api_projectpaper id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper ALTER COLUMN id SET DEFAULT nextval('public.api_projectpaper_id_seq'::regclass);


--
-- TOC entry 3051 (class 2604 OID 16602)
-- Name: api_reviewer id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewer ALTER COLUMN id SET DEFAULT nextval('public.api_reviewer_id_seq'::regclass);


--
-- TOC entry 3052 (class 2604 OID 16603)
-- Name: api_reviewerproposal id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewerproposal ALTER COLUMN id SET DEFAULT nextval('public.api_reviewerproposal_id_seq'::regclass);


--
-- TOC entry 3053 (class 2604 OID 16604)
-- Name: api_submission id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submission ALTER COLUMN id SET DEFAULT nextval('public.api_submission_id_seq'::regclass);


--
-- TOC entry 3054 (class 2604 OID 16605)
-- Name: api_submissioncomment id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment ALTER COLUMN id SET DEFAULT nextval('public.api_submissioncomment_id_seq'::regclass);


--
-- TOC entry 3055 (class 2604 OID 16606)
-- Name: api_task id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task ALTER COLUMN id SET DEFAULT nextval('public.api_task_id_seq'::regclass);


--
-- TOC entry 3056 (class 2604 OID 16607)
-- Name: api_task_assignees id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees ALTER COLUMN id SET DEFAULT nextval('public.api_task_assignees_id_seq'::regclass);


--
-- TOC entry 3057 (class 2604 OID 16608)
-- Name: api_taskdependency id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency ALTER COLUMN id SET DEFAULT nextval('public.api_taskdependency_id_seq'::regclass);


--
-- TOC entry 3058 (class 2604 OID 16609)
-- Name: api_user id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user ALTER COLUMN id SET DEFAULT nextval('public.api_user_id_seq'::regclass);


--
-- TOC entry 3059 (class 2604 OID 16610)
-- Name: api_user_groups id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups ALTER COLUMN id SET DEFAULT nextval('public.api_user_groups_id_seq'::regclass);


--
-- TOC entry 3060 (class 2604 OID 16611)
-- Name: api_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.api_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 3061 (class 2604 OID 16612)
-- Name: api_venue id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue ALTER COLUMN id SET DEFAULT nextval('public.api_venue_id_seq'::regclass);


--
-- TOC entry 3062 (class 2604 OID 16613)
-- Name: api_venue_domains id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_domains ALTER COLUMN id SET DEFAULT nextval('public.api_venue_domains_id_seq'::regclass);


--
-- TOC entry 3063 (class 2604 OID 16614)
-- Name: api_venue_keywords id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_keywords ALTER COLUMN id SET DEFAULT nextval('public.api_venue_keywords_id_seq'::regclass);


--
-- TOC entry 3064 (class 2604 OID 16615)
-- Name: api_venue_reviewers id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_reviewers ALTER COLUMN id SET DEFAULT nextval('public.api_venue_reviewers_id_seq'::regclass);


--
-- TOC entry 3065 (class 2604 OID 16616)
-- Name: api_venueactivity id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venueactivity ALTER COLUMN id SET DEFAULT nextval('public.api_venueschedule_id_seq'::regclass);


--
-- TOC entry 3066 (class 2604 OID 16617)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3067 (class 2604 OID 16618)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3068 (class 2604 OID 16619)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3069 (class 2604 OID 16620)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3071 (class 2604 OID 16621)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3072 (class 2604 OID 16622)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3415 (class 0 OID 16385)
-- Dependencies: 202
-- Data for Name: api_conference; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3416 (class 0 OID 16388)
-- Dependencies: 203
-- Data for Name: api_domain; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_domain VALUES (1, 'privacy & security');
INSERT INTO public.api_domain VALUES (3, 'testing & verification');
INSERT INTO public.api_domain VALUES (4, 'edge iot applications');
INSERT INTO public.api_domain VALUES (2, 'reliable distributed systems');
INSERT INTO public.api_domain VALUES (5, 'cloud resource management');
INSERT INTO public.api_domain VALUES (6, 'data center infrastructure');
INSERT INTO public.api_domain VALUES (7, 'storage management');
INSERT INTO public.api_domain VALUES (8, 'scheduling & optimization');
INSERT INTO public.api_domain VALUES (9, 'query processing');
INSERT INTO public.api_domain VALUES (10, 'distributed & parallel databases');
INSERT INTO public.api_domain VALUES (11, 'big data');
INSERT INTO public.api_domain VALUES (12, 'benchmarking & performance evaluation');
INSERT INTO public.api_domain VALUES (13, 'cellular & 5g networks');
INSERT INTO public.api_domain VALUES (15, 'machine learning');
INSERT INTO public.api_domain VALUES (16, 'natural language processing');


--
-- TOC entry 3418 (class 0 OID 16393)
-- Dependencies: 205
-- Data for Name: api_fileupload; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_fileupload VALUES (2, 'ray-tracing-file_C0AIW96.pdf', '2022-08-25 13:39:25.044458+06', 'ABSTRACT', 'DRAFT', 'Ray tracing', 1, 1);
INSERT INTO public.api_fileupload VALUES (5, 'ray-tracing-file_1p6TFuL.pdf', '2022-08-26 01:44:53.988967+06', 'ABSTRACT', 'DRAFT', 'v2', 1, 1);
INSERT INTO public.api_fileupload VALUES (6, 'ray-tracing-file_w4k0mQA.pdf', '2022-08-26 01:46:43.647437+06', 'MANUSCRIPT', 'DRAFT', 'v2', 1, 1);
INSERT INTO public.api_fileupload VALUES (3, 'ray-tracing-file.pdf', '2022-08-25 13:40:49.122302+06', 'ABSTRACT', 'DRAFT', 'Ray', 1, 1);
INSERT INTO public.api_fileupload VALUES (7, 'ray-tracing-file_CPyIh3E.pdf', '2022-08-26 01:48:54.295548+06', 'ABSTRACT', 'ACTIVE', 'v3', 1, 1);
INSERT INTO public.api_fileupload VALUES (4, 'ray-tracing-file_nGCcyU6.pdf', '2022-08-26 01:23:27.46435+06', 'MANUSCRIPT', 'ACTIVE', 'New one', 3, 1);
INSERT INTO public.api_fileupload VALUES (8, 'original-paper.pdf', '2022-08-27 17:35:55.298757+06', 'ABSTRACT', 'ACTIVE', 'ML_TREE', 1, 1);


--
-- TOC entry 3420 (class 0 OID 16398)
-- Dependencies: 207
-- Data for Name: api_journal; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3421 (class 0 OID 16401)
-- Dependencies: 208
-- Data for Name: api_keyword; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_keyword VALUES (1, 'serverless');
INSERT INTO public.api_keyword VALUES (2, 'cloud computing');
INSERT INTO public.api_keyword VALUES (3, 'distributed systems');
INSERT INTO public.api_keyword VALUES (4, 'virtualization');
INSERT INTO public.api_keyword VALUES (5, 'memory management');
INSERT INTO public.api_keyword VALUES (6, 'network security');
INSERT INTO public.api_keyword VALUES (7, 'cryptography');
INSERT INTO public.api_keyword VALUES (8, 'infrastructure');
INSERT INTO public.api_keyword VALUES (9, 'fault tolerance');
INSERT INTO public.api_keyword VALUES (10, 'privacy');
INSERT INTO public.api_keyword VALUES (11, 'embedded systems');
INSERT INTO public.api_keyword VALUES (12, 'big data');
INSERT INTO public.api_keyword VALUES (13, 'mobile computing');


--
-- TOC entry 3423 (class 0 OID 16406)
-- Dependencies: 210
-- Data for Name: api_note; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_note VALUES ('', 'Public', '2022-08-12 12:21:12.149364+06', NULL, 11);
INSERT INTO public.api_note VALUES ('Nice 2', 'Private', '2022-08-27 12:28:48.144303+06', NULL, 12);


--
-- TOC entry 3424 (class 0 OID 16412)
-- Dependencies: 211
-- Data for Name: api_paper; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_paper VALUES (3, 'Sledge: a Serverless-first, Light-weight Wasm Runtime for the Edge', '10.1145/3423211.3425680', 'Emerging IoT applications with real-time latency constraints require new data processing systems operating at the Edge. Serverless computing offers a new compelling paradigm, where a user can execute a small application without handling the operational issues of server provisioning and resource management. Despite a variety of existing commercial and open source serverless platforms (utilizing VMs and containers), these solutions are too heavy-weight for a resource-constrained Edge systems (due to large memory footprint and high invocation time). Moreover, serverless workloads that focus on per-client, short-running computations are not an ideal fit for existing general purpose computing systems.

In this paper, we present the design and implementation of Sledge -- a novel and efficient WebAssembly-based serverless framework for the Edge. Sledge is optimized for supporting unique properties of serverless workloads: the need for high density multi-tenancy, low startup time, bursty client request rates, and short-lived computations. Sledge is designed for these constraints by offering (i) optimized scheduling policies and efficient work-distribution for short-lived computations, and (ii) a light-weight function isolation model implemented using our own WebAssembly-based software fault isolation infrastructure. These lightweight sandboxes are designed to support high-density computation: with fast startup and teardown times to handle high client request rates. An extensive evaluation of Sledge with varying workloads and real-world serverless applications demonstrates the effectiveness of the designed serverless-first runtime for the Edge. Sledge supports up to 4 times higher throughput and 4 times lower latencies compared to Nuclio, one of the fastest open-source serverless frameworks.', 'Phani Kishore Gadepalli,  Sean McBride,  Gregor Peach,  Ludmila Cherkasova,  Gabriel Parmer', NULL);
INSERT INTO public.api_paper VALUES (2, 'Faasm: Lightweight Isolation for Efficient Stateful Serverless Computing', '10.5555/3489146.3489174', 'Serverless computing is an excellent fit for big data processing because it can scale quickly and cheaply to thousands of parallel functions. Existing serverless platforms isolate functions in ephemeral, stateless containers, preventing them from directly sharing memory. This forces users to duplicate and serialise data repeatedly, adding unnecessary performance and resource costs. We believe that a new lightweight isolation approach is needed, which supports sharing memory directly between functions and reduces resource overheads.

We introduce Faaslets, a new isolation abstraction for high-performance serverless computing. Faaslets isolate the memory of executed functions using software-fault isolation (SFI), as provided by WebAssembly, while allowing memory regions to be shared between functions in the same address space. Faaslets can thus avoid expensive data movement when functions are co-located on the same machine. Our runtime for Faaslets, FAASM, isolates other resources, e.g. CPU and network, using standard Linux cgroups, and provides a low-level POSIX host interface for networking, file system access and dynamic loading. To reduce initialisation times, FAASM restores Faaslets from already-initialised snapshots. We compare FAASM to a standard container-based platform and show that, when training a machine learning model, it achieves a 2× speed-up with 10× less memory; for serving machine learning inference, FAASM doubles the throughput and reduces tail latency by 90%.', 'Simon Shillaker,  Peter Pietzuch  - Imperial College London', 2);
INSERT INTO public.api_paper VALUES (9, 'Distributed Double Machine Learning with a Serverless Architecture', '10.1145/3447545.3451181', 'This paper explores serverless cloud computing for double machine learning. Being based on repeated cross-fitting, double machine learning is particularly well suited to exploit the high level of parallelism achievable with serverless computing. It allows to get fast on-demand estimations without additional cloud maintenance effort. We provide a prototype Python implementation DoubleML-Serverless for the estimation of double machine learning models with the serverless computing platform AWS Lambda and demonstrate its utility with a case study analyzing estimation times and costs.', '[''Malte S. Kurz'']', 1);
INSERT INTO public.api_paper VALUES (1, 'Firecracker: Lightweight Virtualization for Serverless Applications', '10.5555/3388242.3388273', 'Serverless containers and functions are widely used for deploying and managing software in the cloud. Their popularity is due to reduced cost of operations, improved utilization of hardware, and faster scaling than traditional deployment methods. The economics and scale of serverless applications demand that workloads from multiple customers run on the same hardware with minimal overhead, while preserving strong security and performance isolation. The traditional view is that there is a choice between virtualization with strong security and high overhead, and container technologies with weaker security and minimal overhead. This tradeoff is unacceptable to public infrastructure providers, who need both strong security and minimal overhead. To meet this need, we developed Firecracker, a new open source Virtual Machine Monitor (VMM) specialized for serverless workloads, but generally useful for containers, functions and other compute workloads within a reasonable set of constraints. We have deployed Firecracker in two publically-available serverless compute services at Amazon Web Services (Lambda and Fargate), where it supports millions of production workloads, and trillions of requests per month. We describe how specializing for serverless informed the design of Firecracker, and what we learned from seamlessly migrating Lambda customers to Firecracker.', 'Alexandru Agache, Marc Brooker, Andreea Florescu, Alexandra Iordache, Anthony Liguori, Rolf Neugebauer, Phil Piwonka, and Diana-Maria Popa, Amazon Web Services', 2);
INSERT INTO public.api_paper VALUES (4, 'Gillis: Serving Large Neural Networks in Serverless Functions with Automatic Model Partitioning', '10.1109/ICDCS51616.2021.00022', 'The increased use of deep neural networks has stimulated the growing demand for cloud-based model serving platforms. Serverless computing offers a simplified solution: users deploy models as serverless functions and let the platform handle provisioning and scaling. However, serverless functions have constrained resources in CPU and memory, making them inefficient or infeasible to serve large neural networks-which have become increasingly popular. In this paper, we present Gillis, a serverless-based model serving system that automatically partitions a large model across multiple serverless functions for faster inference and reduced memory footprint per function. Gillis employs two novel model partitioning algorithms that respectively achieve latency-optimal serving and cost-optimal serving with SLO compliance. We have implemented Gillis on three serverless platforms-AWS Lambda, Google Cloud Functions, and KNIX-with MXNet as the serving backend. Experimental evaluations against popular models show that Gillis supports serving very large neural networks, reduces the inference latency substantially, and meets various SLOs with a low serving cost.', 'Minchen Yu; Zhifeng Jiang; Hok Chun Ng; Wei Wang; Ruichuan Chen; Bo Li', 5);


--
-- TOC entry 3426 (class 0 OID 16420)
-- Dependencies: 213
-- Data for Name: api_paper_keywords; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_paper_keywords VALUES (2, 2, 1);
INSERT INTO public.api_paper_keywords VALUES (3, 2, 2);
INSERT INTO public.api_paper_keywords VALUES (4, 2, 4);
INSERT INTO public.api_paper_keywords VALUES (5, 4, 8);
INSERT INTO public.api_paper_keywords VALUES (7, 9, 8);
INSERT INTO public.api_paper_keywords VALUES (1, 1, 1);
INSERT INTO public.api_paper_keywords VALUES (6, 4, 1);


--
-- TOC entry 3428 (class 0 OID 16425)
-- Dependencies: 215
-- Data for Name: api_project; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_project VALUES (2, 'Unsorted', NULL, '', true);
INSERT INTO public.api_project VALUES (3, 'Serverless ML', NULL, '', false);
INSERT INTO public.api_project VALUES (4, 'Reinforcement Learning', NULL, '', false);
INSERT INTO public.api_project VALUES (1, 'Serverless Runtime', NULL, '', false);
INSERT INTO public.api_project VALUES (5, 'New project', NULL, 'Very information stuff', false);
INSERT INTO public.api_project VALUES (7, 'New project', NULL, 'Very information stuff', false);
INSERT INTO public.api_project VALUES (8, 'New project', NULL, 'Very information stuff', false);
INSERT INTO public.api_project VALUES (6, 'New project 1', '', 'Very information', true);


--
-- TOC entry 3429 (class 0 OID 16431)
-- Dependencies: 216
-- Data for Name: api_project_domains; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_project_domains VALUES (1, 1, 5);
INSERT INTO public.api_project_domains VALUES (2, 1, 6);
INSERT INTO public.api_project_domains VALUES (3, 7, 2);
INSERT INTO public.api_project_domains VALUES (4, 7, 3);
INSERT INTO public.api_project_domains VALUES (5, 8, 2);
INSERT INTO public.api_project_domains VALUES (6, 8, 3);


--
-- TOC entry 3432 (class 0 OID 16438)
-- Dependencies: 219
-- Data for Name: api_project_keywords; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_project_keywords VALUES (1, 1, 1);
INSERT INTO public.api_project_keywords VALUES (2, 1, 2);
INSERT INTO public.api_project_keywords VALUES (3, 1, 13);
INSERT INTO public.api_project_keywords VALUES (4, 8, 2);
INSERT INTO public.api_project_keywords VALUES (5, 8, 3);


--
-- TOC entry 3434 (class 0 OID 16443)
-- Dependencies: 221
-- Data for Name: api_projectcollaborator; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectcollaborator VALUES (1, 'Creator', 1, 2);
INSERT INTO public.api_projectcollaborator VALUES (3, 'Supervisor', 1, 1);
INSERT INTO public.api_projectcollaborator VALUES (4, 'Developer', 1, 3);
INSERT INTO public.api_projectcollaborator VALUES (5, 'Researcher', 1, 6);
INSERT INTO public.api_projectcollaborator VALUES (6, 'Researcher', 2, 6);
INSERT INTO public.api_projectcollaborator VALUES (7, 'Researcher', 1, 7);
INSERT INTO public.api_projectcollaborator VALUES (8, 'Researcher', 2, 7);
INSERT INTO public.api_projectcollaborator VALUES (9, 'Researcher', 1, 8);
INSERT INTO public.api_projectcollaborator VALUES (10, 'Researcher', 2, 8);


--
-- TOC entry 3436 (class 0 OID 16448)
-- Dependencies: 223
-- Data for Name: api_projectlist; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectlist VALUES (2, 'Done', false, 1);
INSERT INTO public.api_projectlist VALUES (3, 'Next', false, 1);
INSERT INTO public.api_projectlist VALUES (1, 'Next', false, 3);
INSERT INTO public.api_projectlist VALUES (4, 'Done', false, 3);
INSERT INTO public.api_projectlist VALUES (5, 'Default', false, 2);
INSERT INTO public.api_projectlist VALUES (6, 'Done', false, 7);
INSERT INTO public.api_projectlist VALUES (7, 'Next', false, 7);
INSERT INTO public.api_projectlist VALUES (8, 'Done', false, 8);
INSERT INTO public.api_projectlist VALUES (9, 'Next', false, 8);
INSERT INTO public.api_projectlist VALUES (12, 'Later', false, 1);


--
-- TOC entry 3438 (class 0 OID 16453)
-- Dependencies: 225
-- Data for Name: api_projectpaper; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_projectpaper VALUES (3, '2022-07-15 09:20:40.879753+06', 5, 4);
INSERT INTO public.api_projectpaper VALUES (11, '2022-08-12 11:52:53.76108+06', 4, 9);
INSERT INTO public.api_projectpaper VALUES (12, '2022-08-12 11:53:08.23548+06', 3, 9);
INSERT INTO public.api_projectpaper VALUES (1, '2022-07-10 13:46:45.088714+06', 3, 1);


--
-- TOC entry 3440 (class 0 OID 16458)
-- Dependencies: 227
-- Data for Name: api_reviewer; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_reviewer VALUES (9, '', false, NULL, 2, 2);
INSERT INTO public.api_reviewer VALUES (8, 'Very good paper', true, '2022-08-28 06:42:08.979776+06', 1, 1);


--
-- TOC entry 3442 (class 0 OID 16466)
-- Dependencies: 229
-- Data for Name: api_reviewerproposal; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_reviewerproposal VALUES (2, '2022-08-27 19:54:04.411682+06', 1, 6, 'RECEIVED');
INSERT INTO public.api_reviewerproposal VALUES (3, '2022-08-27 19:55:05.525322+06', 2, 6, 'RECEIVED');
INSERT INTO public.api_reviewerproposal VALUES (1, '2022-08-27 19:53:52.899528+06', 1, 1, 'ACCEPTED');
INSERT INTO public.api_reviewerproposal VALUES (4, '2022-08-28 06:06:24.162696+06', 1, 2, 'ACCEPTED');


--
-- TOC entry 3444 (class 0 OID 16471)
-- Dependencies: 231
-- Data for Name: api_submission; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_submission VALUES (3, 'Start', '2022-08-25 07:21:47.246267+06', 3, 3, 'Tributary: Online Machine Learning using Serverless Architecture for Real-time Data Analytics');
INSERT INTO public.api_submission VALUES (2, 'UPCOMING', '2022-08-14 14:20:33+06', 1, 3, 'SOCK: Rapid Task Provisioning with Serverless-Optimized Containers');
INSERT INTO public.api_submission VALUES (1, 'ONGOING', '2022-08-14 14:20:10+06', 1, 2, 'SOCK: Rapid Task Provisioning with Serverless-Optimized Containers');
INSERT INTO public.api_submission VALUES (4, 'UPCOMING', '2022-08-26 02:18:39.048372+06', 4, 2, 'Reinforce a new era');


--
-- TOC entry 3446 (class 0 OID 16476)
-- Dependencies: 233
-- Data for Name: api_submissioncomment; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_submissioncomment VALUES (9, 'New comment', 1, 1, 1, '2022-08-14 16:30:12.957994+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (1, 'Very informative', 1, 2, 1, '2022-08-14 16:21:22.3272+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (10, 'Very nice work done here', 1, 2, 2, '2022-08-26 02:27:26.452671+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (8, 'New thing', 1, 2, 1, '2022-08-14 16:29:22.3272+06', '{"comment": {"text": "hello", "emoji": ""}, "content": {"text": "Contact Number: +8801833182774 ,"}, "position": {"rects": [{"x1": 352.4206237792969, "x2": 599.5476989746094, "y1": 372.2308654785156, "y2": 394.157958984375, "width": 824, "height": 1165.5741285174297, "pageNumber": 1}], "pageNumber": 1, "boundingRect": {"x1": 352.4206237792969, "x2": 599.5476989746094, "y1": 372.2308654785156, "y2": 394.157958984375, "width": 824, "height": 1165.5741285174297, "pageNumber": 1}}}', 9);
INSERT INTO public.api_submissioncomment VALUES (11, 'Very nice work done here', 1, 2, 2, '2022-08-28 05:27:42.72487+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (12, 'Very nice work done here', 1, 2, 2, '2022-08-28 05:28:50.488415+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (13, 'Very nice work done here', 1, 2, 2, '2022-08-28 05:29:02.344726+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (14, 'Very nice work done here', 1, 2, 2, '2022-08-28 05:29:29.808628+06', NULL, 12);
INSERT INTO public.api_submissioncomment VALUES (15, 'Very nice work done here', 1, 2, 2, '2022-08-28 05:31:59.111328+06', NULL, NULL);
INSERT INTO public.api_submissioncomment VALUES (16, 'Very nice work done here', 1, 2, 2, '2022-08-28 06:24:22.203959+06', NULL, NULL);


--
-- TOC entry 3448 (class 0 OID 16484)
-- Dependencies: 235
-- Data for Name: api_task; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_task VALUES (1, 'Literature Review', NULL, NULL, 'Next', 2, NULL);
INSERT INTO public.api_task VALUES (6, 'Run Code', '2022-07-18 00:00:00+06', '2022-07-08 00:00:00+06', 'Later', 2, NULL);
INSERT INTO public.api_task VALUES (2, 'Read Gillis pap', NULL, NULL, 'Done', 2, 3);
INSERT INTO public.api_task VALUES (13, 'New task 2', '2022-07-18 00:00:00+06', '2022-07-08 00:00:00+06', 'Later', 2, 3);
INSERT INTO public.api_task VALUES (3, 'Read Firecracker paper', '2022-08-03 00:00:00+06', NULL, 'Progress', 2, 1);


--
-- TOC entry 3449 (class 0 OID 16487)
-- Dependencies: 236
-- Data for Name: api_task_assignees; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_task_assignees VALUES (1, 1, 3);
INSERT INTO public.api_task_assignees VALUES (2, 2, 1);
INSERT INTO public.api_task_assignees VALUES (5, 6, 1);


--
-- TOC entry 3452 (class 0 OID 16494)
-- Dependencies: 239
-- Data for Name: api_taskdependency; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_taskdependency VALUES (1, 2, 3);
INSERT INTO public.api_taskdependency VALUES (4, 6, 2);
INSERT INTO public.api_taskdependency VALUES (5, 1, 1);
INSERT INTO public.api_taskdependency VALUES (6, 1, 6);
INSERT INTO public.api_taskdependency VALUES (7, 3, 6);


--
-- TOC entry 3454 (class 0 OID 16499)
-- Dependencies: 241
-- Data for Name: api_user; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_user VALUES (2, 'pbkdf2_sha256$320000$cgUGPBFbiv4gduDYAtJuQp$JrqOqdLaq1G5JF0smh7ZAiPZrWvBDP2sgKFbs3c738w=', NULL, true, 'sadia', '', '', 'sadia@gmail.com', true, true, '2022-07-16 11:02:20.682435+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (3, 'pbkdf2_sha256$320000$74knswBHXKPD9WcyFVdaIo$FIoUJyBde9T1+bZSePEY+Gd83ylBOXrptg544mo6aL0=', NULL, true, 'najib', '', '', 'najib@gmail.com', true, true, '2022-07-16 11:02:42.395261+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (1, 'pbkdf2_sha256$320000$oSzNBKuqmcoQc29WO802LH$fa/450s706xCoT5KJewjXWNnQuxc+OvDMTHJ8d1GRVU=', '2022-08-24 11:40:06.925089+06', true, 'tahmeed', '', '', 't@g.com', true, true, '2022-07-09 18:52:25.634703+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (4, '', NULL, false, 'Michael', '', '', '', false, true, '2022-08-27 21:31:39.692852+06', NULL, NULL, NULL);
INSERT INTO public.api_user VALUES (5, '', NULL, false, 'Jony', '', '', 'Jony@gmail.com', false, true, '2022-08-27 21:32:26.970561+06', NULL, 'Computer University of Science', 'Distinguished Researcher');


--
-- TOC entry 3455 (class 0 OID 16505)
-- Dependencies: 242
-- Data for Name: api_user_groups; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3458 (class 0 OID 16512)
-- Dependencies: 245
-- Data for Name: api_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3460 (class 0 OID 16517)
-- Dependencies: 247
-- Data for Name: api_venue; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_venue VALUES (1, 'ICPE ''21', NULL, '2022-08-25 12:02:37.452345+06', '2022-08-25 12:02:37.501647+06');
INSERT INTO public.api_venue VALUES (3, 'ICLR ''21', NULL, '2023-06-08 12:02:37+06', '2023-06-06 12:02:37+06');
INSERT INTO public.api_venue VALUES (6, 'ACM SIGMOD ''23', 'https://2022.sigmod.org/', '2023-06-27 00:00:00+06', '2023-06-26 00:00:00+06');
INSERT INTO public.api_venue VALUES (7, 'ACM SIGCOMM ''23', 'https://conferences.sigcomm.org/sigcomm/2022/', '2022-10-21 00:00:00+06', '2022-10-19 00:00:00+06');
INSERT INTO public.api_venue VALUES (4, 'USENIX OSDI ''23', 'https://www.usenix.org/conference/osdi22', '2023-06-14 00:00:00+06', '2023-06-11 00:00:00+06');
INSERT INTO public.api_venue VALUES (5, 'IEEE CLOUD ''23', 'https://conferences.computer.org/cloud/2022/', '2023-03-02 00:00:00+06', '2023-03-01 00:00:00+06');
INSERT INTO public.api_venue VALUES (2, 'USENIX NSDI ''23', 'https://www.usenix.org/conference/nsdi22', '2023-04-08 12:02:37+06', '2023-04-06 12:02:37+06');


--
-- TOC entry 3461 (class 0 OID 16523)
-- Dependencies: 248
-- Data for Name: api_venue_domains; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_venue_domains VALUES (1, 2, 1);
INSERT INTO public.api_venue_domains VALUES (2, 2, 2);
INSERT INTO public.api_venue_domains VALUES (3, 2, 4);
INSERT INTO public.api_venue_domains VALUES (4, 2, 5);
INSERT INTO public.api_venue_domains VALUES (5, 4, 2);
INSERT INTO public.api_venue_domains VALUES (6, 4, 3);
INSERT INTO public.api_venue_domains VALUES (7, 4, 7);
INSERT INTO public.api_venue_domains VALUES (8, 4, 8);
INSERT INTO public.api_venue_domains VALUES (9, 4, 12);
INSERT INTO public.api_venue_domains VALUES (10, 5, 4);
INSERT INTO public.api_venue_domains VALUES (11, 5, 5);
INSERT INTO public.api_venue_domains VALUES (12, 5, 6);
INSERT INTO public.api_venue_domains VALUES (13, 5, 9);
INSERT INTO public.api_venue_domains VALUES (14, 5, 11);
INSERT INTO public.api_venue_domains VALUES (15, 5, 12);
INSERT INTO public.api_venue_domains VALUES (16, 6, 6);
INSERT INTO public.api_venue_domains VALUES (17, 6, 7);
INSERT INTO public.api_venue_domains VALUES (18, 6, 9);
INSERT INTO public.api_venue_domains VALUES (19, 6, 10);
INSERT INTO public.api_venue_domains VALUES (20, 6, 11);
INSERT INTO public.api_venue_domains VALUES (21, 7, 13);
INSERT INTO public.api_venue_domains VALUES (22, 7, 3);
INSERT INTO public.api_venue_domains VALUES (23, 7, 4);
INSERT INTO public.api_venue_domains VALUES (24, 7, 12);


--
-- TOC entry 3464 (class 0 OID 16530)
-- Dependencies: 251
-- Data for Name: api_venue_keywords; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_venue_keywords VALUES (1, 2, 2);
INSERT INTO public.api_venue_keywords VALUES (2, 2, 3);
INSERT INTO public.api_venue_keywords VALUES (3, 2, 6);
INSERT INTO public.api_venue_keywords VALUES (4, 2, 10);
INSERT INTO public.api_venue_keywords VALUES (5, 2, 13);
INSERT INTO public.api_venue_keywords VALUES (6, 4, 8);
INSERT INTO public.api_venue_keywords VALUES (7, 4, 11);
INSERT INTO public.api_venue_keywords VALUES (8, 4, 4);
INSERT INTO public.api_venue_keywords VALUES (9, 4, 5);
INSERT INTO public.api_venue_keywords VALUES (10, 5, 2);
INSERT INTO public.api_venue_keywords VALUES (11, 5, 4);
INSERT INTO public.api_venue_keywords VALUES (12, 5, 8);
INSERT INTO public.api_venue_keywords VALUES (13, 5, 12);
INSERT INTO public.api_venue_keywords VALUES (14, 5, 13);
INSERT INTO public.api_venue_keywords VALUES (15, 6, 8);
INSERT INTO public.api_venue_keywords VALUES (16, 6, 12);
INSERT INTO public.api_venue_keywords VALUES (17, 6, 4);
INSERT INTO public.api_venue_keywords VALUES (18, 6, 5);
INSERT INTO public.api_venue_keywords VALUES (19, 7, 10);
INSERT INTO public.api_venue_keywords VALUES (20, 7, 13);
INSERT INTO public.api_venue_keywords VALUES (21, 7, 6);
INSERT INTO public.api_venue_keywords VALUES (22, 7, 7);


--
-- TOC entry 3466 (class 0 OID 16535)
-- Dependencies: 253
-- Data for Name: api_venue_reviewers; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_venue_reviewers VALUES (1, 2, 3);
INSERT INTO public.api_venue_reviewers VALUES (2, 2, 4);


--
-- TOC entry 3468 (class 0 OID 16540)
-- Dependencies: 255
-- Data for Name: api_venueactivity; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.api_venueactivity VALUES (1, 'Abstract Submission', NULL, '2022-09-09 00:00:00+06', 2);
INSERT INTO public.api_venueactivity VALUES (2, 'Manuscript Submission', '2022-09-09 00:00:01+06', '2022-09-15 00:00:00+06', 2);
INSERT INTO public.api_venueactivity VALUES (3, 'Peer Review', '2022-09-15 00:00:01+06', '2022-12-15 00:00:00+06', 2);
INSERT INTO public.api_venueactivity VALUES (4, 'Final Decisions', '2022-12-15 00:00:01+06', '2023-03-01 00:00:00+06', 2);


--
-- TOC entry 3470 (class 0 OID 16545)
-- Dependencies: 257
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3472 (class 0 OID 16550)
-- Dependencies: 259
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- TOC entry 3474 (class 0 OID 16555)
-- Dependencies: 261
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
INSERT INTO public.auth_permission VALUES (61, 'Can add note', 16, 'add_note');
INSERT INTO public.auth_permission VALUES (62, 'Can change note', 16, 'change_note');
INSERT INTO public.auth_permission VALUES (63, 'Can delete note', 16, 'delete_note');
INSERT INTO public.auth_permission VALUES (64, 'Can view note', 16, 'view_note');
INSERT INTO public.auth_permission VALUES (65, 'Can add venue', 17, 'add_venue');
INSERT INTO public.auth_permission VALUES (66, 'Can change venue', 17, 'change_venue');
INSERT INTO public.auth_permission VALUES (67, 'Can delete venue', 17, 'delete_venue');
INSERT INTO public.auth_permission VALUES (68, 'Can view venue', 17, 'view_venue');
INSERT INTO public.auth_permission VALUES (69, 'Can add journal', 18, 'add_journal');
INSERT INTO public.auth_permission VALUES (70, 'Can change journal', 18, 'change_journal');
INSERT INTO public.auth_permission VALUES (71, 'Can delete journal', 18, 'delete_journal');
INSERT INTO public.auth_permission VALUES (72, 'Can view journal', 18, 'view_journal');
INSERT INTO public.auth_permission VALUES (73, 'Can add conference', 19, 'add_conference');
INSERT INTO public.auth_permission VALUES (74, 'Can change conference', 19, 'change_conference');
INSERT INTO public.auth_permission VALUES (75, 'Can delete conference', 19, 'delete_conference');
INSERT INTO public.auth_permission VALUES (76, 'Can view conference', 19, 'view_conference');
INSERT INTO public.auth_permission VALUES (77, 'Can add keyword', 20, 'add_keyword');
INSERT INTO public.auth_permission VALUES (78, 'Can change keyword', 20, 'change_keyword');
INSERT INTO public.auth_permission VALUES (79, 'Can delete keyword', 20, 'delete_keyword');
INSERT INTO public.auth_permission VALUES (80, 'Can view keyword', 20, 'view_keyword');
INSERT INTO public.auth_permission VALUES (81, 'Can add submission', 21, 'add_submission');
INSERT INTO public.auth_permission VALUES (82, 'Can change submission', 21, 'change_submission');
INSERT INTO public.auth_permission VALUES (83, 'Can delete submission', 21, 'delete_submission');
INSERT INTO public.auth_permission VALUES (84, 'Can view submission', 21, 'view_submission');
INSERT INTO public.auth_permission VALUES (85, 'Can add submission comment', 22, 'add_submissioncomment');
INSERT INTO public.auth_permission VALUES (86, 'Can change submission comment', 22, 'change_submissioncomment');
INSERT INTO public.auth_permission VALUES (87, 'Can delete submission comment', 22, 'delete_submissioncomment');
INSERT INTO public.auth_permission VALUES (88, 'Can view submission comment', 22, 'view_submissioncomment');
INSERT INTO public.auth_permission VALUES (89, 'Can add venue schedule', 23, 'add_venueschedule');
INSERT INTO public.auth_permission VALUES (90, 'Can change venue schedule', 23, 'change_venueschedule');
INSERT INTO public.auth_permission VALUES (91, 'Can delete venue schedule', 23, 'delete_venueschedule');
INSERT INTO public.auth_permission VALUES (92, 'Can view venue schedule', 23, 'view_venueschedule');
INSERT INTO public.auth_permission VALUES (93, 'Can add file upload', 24, 'add_fileupload');
INSERT INTO public.auth_permission VALUES (94, 'Can change file upload', 24, 'change_fileupload');
INSERT INTO public.auth_permission VALUES (95, 'Can delete file upload', 24, 'delete_fileupload');
INSERT INTO public.auth_permission VALUES (96, 'Can view file upload', 24, 'view_fileupload');
INSERT INTO public.auth_permission VALUES (97, 'Can add domain', 25, 'add_domain');
INSERT INTO public.auth_permission VALUES (98, 'Can change domain', 25, 'change_domain');
INSERT INTO public.auth_permission VALUES (99, 'Can delete domain', 25, 'delete_domain');
INSERT INTO public.auth_permission VALUES (100, 'Can view domain', 25, 'view_domain');
INSERT INTO public.auth_permission VALUES (101, 'Can add venue activity', 23, 'add_venueactivity');
INSERT INTO public.auth_permission VALUES (102, 'Can change venue activity', 23, 'change_venueactivity');
INSERT INTO public.auth_permission VALUES (103, 'Can delete venue activity', 23, 'delete_venueactivity');
INSERT INTO public.auth_permission VALUES (104, 'Can view venue activity', 23, 'view_venueactivity');
INSERT INTO public.auth_permission VALUES (105, 'Can add reviewer proposal', 26, 'add_reviewerproposal');
INSERT INTO public.auth_permission VALUES (106, 'Can change reviewer proposal', 26, 'change_reviewerproposal');
INSERT INTO public.auth_permission VALUES (107, 'Can delete reviewer proposal', 26, 'delete_reviewerproposal');
INSERT INTO public.auth_permission VALUES (108, 'Can view reviewer proposal', 26, 'view_reviewerproposal');
INSERT INTO public.auth_permission VALUES (109, 'Can add reviewer', 27, 'add_reviewer');
INSERT INTO public.auth_permission VALUES (110, 'Can change reviewer', 27, 'change_reviewer');
INSERT INTO public.auth_permission VALUES (111, 'Can delete reviewer', 27, 'delete_reviewer');
INSERT INTO public.auth_permission VALUES (112, 'Can view reviewer', 27, 'view_reviewer');


--
-- TOC entry 3476 (class 0 OID 16560)
-- Dependencies: 263
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authtoken_token VALUES ('2a1f52e7dfab9ef3658b1263daa5dc3df5448eed', '2022-07-10 21:09:40.57258+06', 1);
INSERT INTO public.authtoken_token VALUES ('fcae8400680fca2a7dc3dd18244e2a873d6c06f3', '2022-07-16 11:02:21.094875+06', 2);
INSERT INTO public.authtoken_token VALUES ('8e51af3341b226c342d27167c44948af239f0d9d', '2022-07-16 11:02:42.702582+06', 3);
INSERT INTO public.authtoken_token VALUES ('33837631700a09660f2207aa220041b998c4df77', '2022-08-27 21:31:39.698417+06', 4);
INSERT INTO public.authtoken_token VALUES ('50a77db2ed1e07465f38ec72f3a8885ecf87c5a0', '2022-08-27 21:32:26.974842+06', 5);


--
-- TOC entry 3477 (class 0 OID 16563)
-- Dependencies: 264
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
INSERT INTO public.django_admin_log VALUES (35, '2022-08-12 09:45:04.304576+06', '8', '8-New task 1-Later', 3, '', 14, 1);
INSERT INTO public.django_admin_log VALUES (36, '2022-08-12 09:45:09.358589+06', '9', '9-New task 1-Later', 3, '', 14, 1);
INSERT INTO public.django_admin_log VALUES (37, '2022-08-12 11:20:58.978837+06', '7', '7-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (38, '2022-08-12 11:21:12.100645+06', '10', '10-Distributed Double M...-Default', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (39, '2022-08-12 11:52:33.30207+06', '10', '10-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (40, '2022-08-12 11:52:36.464947+06', '9', '9-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (41, '2022-08-12 11:52:40.753032+06', '8', '8-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (42, '2022-08-12 11:52:44.289285+06', '6', '6-Distributed Double M...-Default', 3, '', 10, 1);
INSERT INTO public.django_admin_log VALUES (43, '2022-08-12 11:52:53.763439+06', '11', '11-Distributed Double M...-Done', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (44, '2022-08-12 11:53:08.237599+06', '12', '12-Distributed Double M...-Next', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (45, '2022-08-12 12:20:50.9749+06', '12', '12-Distributed Double M...-Next-Public', 2, '[{"changed": {"fields": ["Visibility"]}}]', 16, 1);
INSERT INTO public.django_admin_log VALUES (46, '2022-08-12 12:21:07.064887+06', '12', '12-Distributed Double M...-Next-Private', 2, '[{"changed": {"fields": ["Visibility"]}}]', 16, 1);
INSERT INTO public.django_admin_log VALUES (47, '2022-08-12 12:21:12.156398+06', '11', '11-Distributed Double M...-Done-Public', 2, '[{"changed": {"fields": ["Visibility"]}}]', 16, 1);
INSERT INTO public.django_admin_log VALUES (48, '2022-08-14 11:11:59.941416+06', '1', '1-ICPE ''21', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (49, '2022-08-14 11:12:02.958977+06', '9', '9-Distributed Double M...', 2, '[{"changed": {"fields": ["Venue"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (50, '2022-08-14 14:00:31.491765+06', '2', '2-NSDI ''21', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (51, '2022-08-14 14:00:40.738783+06', '3', '3-ICLR ''21', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (52, '2022-08-14 14:20:12.328895+06', '1', '1-Serverless Runtime-NSDI ''21', 1, '[{"added": {}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (53, '2022-08-14 14:20:34.757417+06', '2', '2-Serverless Runtime-ICLR ''21', 1, '[{"added": {}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (54, '2022-08-14 14:43:51.461609+06', '1', '1-sub1-Very informative', 1, '[{"added": {}}]', 22, 1);
INSERT INTO public.django_admin_log VALUES (55, '2022-08-24 12:05:14.779128+06', '2', '2-Serverless Runtime-ICLR ''21', 2, '[{"changed": {"fields": ["Reviewers"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (56, '2022-08-25 07:20:04.155096+06', '1', '1-Serverless Runtime-NSDI ''21', 2, '[{"changed": {"fields": ["Name"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (57, '2022-08-25 07:20:20.519909+06', '2', '2-Serverless Runtime-ICLR ''21', 2, '[{"changed": {"fields": ["Name"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (58, '2022-08-25 07:21:47.25281+06', '3', '3-Serverless ML-ICLR ''21', 1, '[{"added": {}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (59, '2022-08-25 07:25:04.21935+06', '3', '3-Serverless ML-ICLR ''21', 2, '[{"changed": {"fields": ["Status"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (60, '2022-08-25 07:27:13.931636+06', '4', '4-tahmeed...-Serverless ML', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (61, '2022-08-25 08:43:42.216934+06', '1', 'VenueSchedule object (1)', 1, '[{"added": {}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (62, '2022-08-25 08:48:00.709564+06', '2', '2-Full paper submissions-v(2-NSDI ''21)', 1, '[{"added": {}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (63, '2022-08-25 08:48:42.980148+06', '3', '3-Notification to authors-v(2-NSDI ''21)', 1, '[{"added": {}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (64, '2022-08-25 08:49:14.247027+06', '4', '4-Final paper files-v(2-NSDI ''21)', 1, '[{"added": {}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (65, '2022-08-25 10:04:02.157621+06', '2', '2-p(Serverless Runtime)-v(ICLR ''21)', 2, '[{"changed": {"fields": ["Status"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (66, '2022-08-25 10:04:04.964129+06', '1', '1-p(Serverless Runtime)-v(NSDI ''21)', 2, '[{"changed": {"fields": ["Status"]}}]', 21, 1);
INSERT INTO public.django_admin_log VALUES (67, '2022-08-25 10:28:02.732424+06', '1', '1-Paper titles and abstracts-v(2-NSDI ''21)', 2, '[{"changed": {"fields": ["Start"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (68, '2022-08-25 10:28:13.972784+06', '2', '2-Full paper submissions-v(2-NSDI ''21)', 2, '[{"changed": {"fields": ["Start"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (69, '2022-08-25 10:28:32.347916+06', '3', '3-Notification to authors-v(2-NSDI ''21)', 2, '[{"changed": {"fields": ["Start", "End"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (70, '2022-08-25 10:28:58.68281+06', '4', '4-Final paper files-v(2-NSDI ''21)', 2, '[{"changed": {"fields": ["Start", "End"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (71, '2022-08-25 10:29:36.067463+06', '1', '1-Paper titles and abstracts-v(2-NSDI ''21)', 2, '[{"changed": {"fields": ["Start"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (72, '2022-08-25 12:09:10.895049+06', '2', '2-NSDI ''21', 2, '[{"changed": {"fields": ["Start", "End"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (73, '2022-08-25 12:09:22.294334+06', '3', '3-ICLR ''21', 2, '[{"changed": {"fields": ["Start", "End"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (74, '2022-08-26 01:39:03.263078+06', '4', '4-New one-MANUSCRIPT-p(3-Serverless ML)', 2, '[{"changed": {"fields": ["Project"]}}]', 24, 1);
INSERT INTO public.django_admin_log VALUES (75, '2022-08-26 07:20:58.569837+06', '1', '1-serverless', 2, '[{"changed": {"fields": ["Name"]}}]', 20, 1);
INSERT INTO public.django_admin_log VALUES (76, '2022-08-26 08:13:49.114043+06', 'None', 'None-cloud computing', 1, '[{"added": {}}]', 20, 1);
INSERT INTO public.django_admin_log VALUES (77, '2022-08-26 08:14:20.54288+06', 'None', 'None-cloud computing', 1, '[{"added": {}}]', 20, 1);
INSERT INTO public.django_admin_log VALUES (78, '2022-08-26 08:45:38.792634+06', '2', '2-NSDI ''21', 2, '[{"changed": {"fields": ["Website", "Keywords", "Domains"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (79, '2022-08-26 08:45:50.511295+06', '2', '2-NSDI ''22', 2, '[{"changed": {"fields": ["Name"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (80, '2022-08-26 08:47:27.098962+06', '4', '4-OSDI ''22', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (81, '2022-08-26 08:56:09.183496+06', '5', '5-IEEE CLOUD ''22', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (82, '2022-08-26 08:57:35.523741+06', '6', '6-ACM SIGMOD ''23', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (83, '2022-08-26 08:59:00.694433+06', '7', '7-ACM SIGCOMM ''23', 1, '[{"added": {}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (84, '2022-08-26 08:59:21.819281+06', '4', '4-USENIX OSDI ''23', 2, '[{"changed": {"fields": ["Name"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (85, '2022-08-26 08:59:35.061157+06', '2', '2-USENIX NSDI ''23', 2, '[{"changed": {"fields": ["Name"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (86, '2022-08-26 08:59:46.108781+06', '5', '5-IEEE CLOUD ''23', 2, '[{"changed": {"fields": ["Name"]}}]', 17, 1);
INSERT INTO public.django_admin_log VALUES (87, '2022-08-26 09:41:30.275185+06', '1', '1-Serverless Runtime', 2, '[{"changed": {"fields": ["Keywords", "Domains"]}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (88, '2022-08-26 10:46:06.014673+06', '1', '1-Firecracker: Lightwe...', 2, '[{"changed": {"fields": ["Venue"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (89, '2022-08-26 10:47:02.579809+06', '2', '2-Faasm: Lightweight I...', 2, '[{"changed": {"fields": ["Keywords", "Venue"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (90, '2022-08-26 10:48:16.368698+06', '4', '4-Gillis: Serving Larg...', 2, '[{"changed": {"fields": ["Keywords", "Venue"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (91, '2022-08-26 10:48:22.252265+06', '9', '9-Distributed Double M...', 2, '[{"changed": {"fields": ["Keywords"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (92, '2022-08-27 19:53:52.901449+06', '1', '1-False-r(tahmeed)-v(1-ICPE ''21)', 1, '[{"added": {}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (93, '2022-08-27 19:54:04.412732+06', '2', '2-False-r(tahmeed)-v(6-ACM SIGMOD ''23)', 1, '[{"added": {}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (94, '2022-08-27 19:55:05.52781+06', '3', '3-False-r(sadia)-v(6-ACM SIGMOD ''23)', 1, '[{"added": {}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (95, '2022-08-27 21:03:56.851203+06', '2', '2-u(najib)-v(1-ICPE ''21)', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (96, '2022-08-27 21:04:05.595583+06', '3', '3-u(sadia)-v(1-ICPE ''21)', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (97, '2022-08-27 21:04:15.835498+06', '4', '4-u(najib)-v(3-ICLR ''21)', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (98, '2022-08-27 21:19:28.281982+06', '5', '5-u(tahmeed)-v(2-USENIX NSDI ''23)', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (99, '2022-08-27 21:40:44.462971+06', '1', '1-Abstract Submission-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Activity"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (100, '2022-08-27 21:40:50.363329+06', '2', '2-Manuscript Submission-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Activity"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (101, '2022-08-27 21:40:57.419185+06', '3', '3-Peer Review-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Activity"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (102, '2022-08-27 21:41:03.759269+06', '4', '4-Final Decisions-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Activity"]}}]', 23, 1);
INSERT INTO public.django_admin_log VALUES (103, '2022-08-28 06:05:55.132909+06', '5', '5-u(tahmeed)-v(2-USENIX NSDI ''23)', 3, '', 27, 1);
INSERT INTO public.django_admin_log VALUES (104, '2022-08-28 06:06:24.164717+06', '4', '4-RECEIVED-r(tahmeed)-v(2-USENIX NSDI ''23)', 1, '[{"added": {}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (105, '2022-08-28 06:09:22.461784+06', '4', '4-RECEIVED-r(tahmeed)-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Status"]}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (106, '2022-08-28 06:10:23.066719+06', '4', '4-RECEIVED-r(tahmeed)-v(2-USENIX NSDI ''23)', 2, '[{"changed": {"fields": ["Status"]}}]', 26, 1);
INSERT INTO public.django_admin_log VALUES (107, '2022-08-28 06:39:49.221444+06', '8', '8-u(tahmeed)-s(1-p(Serverless Runtime)-v(USENIX NSDI ''23))', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (108, '2022-08-28 06:39:58.483272+06', '9', '9-u(sadia)-s(2-p(Serverless Runtime)-v(ICLR ''21))', 1, '[{"added": {}}]', 27, 1);
INSERT INTO public.django_admin_log VALUES (109, '2022-08-28 06:48:07.882888+06', '2', '2-USENIX NSDI ''23', 2, '[{"changed": {"fields": ["Reviewers"]}}]', 17, 1);


--
-- TOC entry 3479 (class 0 OID 16572)
-- Dependencies: 266
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
INSERT INTO public.django_content_type VALUES (16, 'api', 'note');
INSERT INTO public.django_content_type VALUES (17, 'api', 'venue');
INSERT INTO public.django_content_type VALUES (18, 'api', 'journal');
INSERT INTO public.django_content_type VALUES (19, 'api', 'conference');
INSERT INTO public.django_content_type VALUES (20, 'api', 'keyword');
INSERT INTO public.django_content_type VALUES (21, 'api', 'submission');
INSERT INTO public.django_content_type VALUES (22, 'api', 'submissioncomment');
INSERT INTO public.django_content_type VALUES (24, 'api', 'fileupload');
INSERT INTO public.django_content_type VALUES (23, 'api', 'venueactivity');
INSERT INTO public.django_content_type VALUES (25, 'api', 'domain');
INSERT INTO public.django_content_type VALUES (26, 'api', 'reviewerproposal');
INSERT INTO public.django_content_type VALUES (27, 'api', 'reviewer');


--
-- TOC entry 3481 (class 0 OID 16577)
-- Dependencies: 268
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
INSERT INTO public.django_migrations VALUES (27, 'api', '0005_note', '2022-08-12 10:57:26.008773+06');
INSERT INTO public.django_migrations VALUES (29, 'api', '0006_rename_creator_id_note_creator_and_more', '2022-08-12 11:49:11.639296+06');
INSERT INTO public.django_migrations VALUES (30, 'api', '0007_venue_conference_journal_paper_venue', '2022-08-14 11:09:20.456209+06');
INSERT INTO public.django_migrations VALUES (32, 'api', '0008_keyword_paper_keywords', '2022-08-14 11:28:25.676163+06');
INSERT INTO public.django_migrations VALUES (33, 'api', '0009_venue_reviewers_submissioncomment_submission', '2022-08-14 13:40:34.066976+06');
INSERT INTO public.django_migrations VALUES (34, 'api', '0010_submissioncomment_reviewer_thread_and_more', '2022-08-14 14:42:47.297706+06');
INSERT INTO public.django_migrations VALUES (35, 'api', '0011_alter_submission_submitted', '2022-08-14 14:42:47.323282+06');
INSERT INTO public.django_migrations VALUES (36, 'api', '0012_submissioncomment_datetime_and_more', '2022-08-14 16:29:22.398239+06');
INSERT INTO public.django_migrations VALUES (37, 'api', '0013_submission_reviewers', '2022-08-24 12:01:27.067193+06');
INSERT INTO public.django_migrations VALUES (38, 'api', '0014_submission_name', '2022-08-24 12:37:06.438988+06');
INSERT INTO public.django_migrations VALUES (40, 'api', '0015_alter_submission_reviewers_venueschedule', '2022-08-25 08:38:38.102469+06');
INSERT INTO public.django_migrations VALUES (41, 'api', '0016_venue_end_venue_start_alter_submission_status', '2022-08-25 12:02:37.531778+06');
INSERT INTO public.django_migrations VALUES (42, 'api', '0017_fileupload', '2022-08-25 13:34:37.742253+06');
INSERT INTO public.django_migrations VALUES (43, 'api', '0018_domain_rename_venueschedule_venueactivity_and_more', '2022-08-26 08:34:21.438166+06');
INSERT INTO public.django_migrations VALUES (44, 'api', '0019_project_domains_project_keywords', '2022-08-26 09:40:09.647923+06');
INSERT INTO public.django_migrations VALUES (45, 'api', '0020_submissioncomment_hightlight_pos_and_more', '2022-08-27 14:52:02.163893+06');
INSERT INTO public.django_migrations VALUES (46, 'api', '0021_rename_hightlight_pos_submissioncomment_highlight_metadata', '2022-08-27 14:57:36.470503+06');
INSERT INTO public.django_migrations VALUES (47, 'api', '0022_submissioncomment_parent', '2022-08-27 16:44:33.620141+06');
INSERT INTO public.django_migrations VALUES (48, 'api', '0023_reviewerproposal', '2022-08-27 19:52:08.286236+06');
INSERT INTO public.django_migrations VALUES (49, 'api', '0024_remove_reviewerproposal_is_accepted_and_more', '2022-08-27 20:07:21.181642+06');
INSERT INTO public.django_migrations VALUES (50, 'api', '0025_remove_venue_reviewers', '2022-08-27 20:47:04.838402+06');
INSERT INTO public.django_migrations VALUES (51, 'api', '0026_reviewer_venue_reviewers_reviewer_venue', '2022-08-27 20:47:05.052904+06');
INSERT INTO public.django_migrations VALUES (52, 'api', '0027_remove_reviewer_venue_remove_submission_reviewers_and_more', '2022-08-28 06:34:08.984122+06');
INSERT INTO public.django_migrations VALUES (53, 'api', '0028_submission_reviewers_venue_reviewers', '2022-08-28 06:34:09.120192+06');


--
-- TOC entry 3483 (class 0 OID 16585)
-- Dependencies: 270
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.django_session VALUES ('h2kcgfjqy1cg3pjrgkulicwsjrwe10s5', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oA9wp:HFkgxAjr2RptxgTwcnCdwMK-OaDn35WgP5Vj8JlVmvI', '2022-07-23 18:52:35.733767+06');
INSERT INTO public.django_session VALUES ('d5j9lax6erkmrpl621lk705lwjlicyw6', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oCZJr:GsYugvkRgOGZwTv-NEBUodBhPEOvL1Y-auoN55d_0ms', '2022-07-30 10:22:19.016834+06');
INSERT INTO public.django_session VALUES ('p0280unxtdtlamifarfclc7izgzzopj3', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oHxKT:324PHZlDrAiCQ_z_BODesm7BrPxyK0cGZoJrvdgRPPk', '2022-08-14 07:01:13.276673+06');
INSERT INTO public.django_session VALUES ('0iglrvry52xgee3qwji72uv7hvhxuo72', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oN5tg:eobuJH25WBjF7AXW77TuEm6o5Chf13AAirLfc6x8cPk', '2022-08-28 11:10:48.806897+06');
INSERT INTO public.django_session VALUES ('r8pv1l8bbrrpxrkdqbtb39thbku5vt8m', '.eJxVjEEOwiAQRe_C2pDSGR1w6b5nIAMDUjU0Ke3KeHfbpAvdvvf-fyvP61L82tLsR1FXZdTplwWOz1R3IQ-u90nHqS7zGPSe6MM2PUySXrej_Tso3Mq2tmhN3xEmCh1bIiYLgEKmd7AhiJyTXHIGB8gRwLCTmM9okiMHgurzBb2rN1E:1oQj7W:pEmzXK0936pVv5beWlaZFPFbWlqb-IT5843zKwoZsME', '2022-09-07 11:40:06.930548+06');


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 204
-- Name: api_domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_domain_id_seq', 16, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 206
-- Name: api_fileupload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_fileupload_id_seq', 8, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 209
-- Name: api_keyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_keyword_id_seq', 2, true);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 212
-- Name: api_paper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_paper_id_seq', 9, true);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 214
-- Name: api_paper_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_paper_keywords_id_seq', 7, true);


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 217
-- Name: api_project_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_project_domains_id_seq', 6, true);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 218
-- Name: api_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_project_id_seq', 8, true);


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 220
-- Name: api_project_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_project_keywords_id_seq', 5, true);


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 222
-- Name: api_projectcollaborator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectcollaborator_id_seq', 10, true);


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 224
-- Name: api_projectlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectlist_id_seq', 13, true);


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 226
-- Name: api_projectpaper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_projectpaper_id_seq', 12, true);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 228
-- Name: api_reviewer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_reviewer_id_seq', 9, true);


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 230
-- Name: api_reviewerproposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_reviewerproposal_id_seq', 4, true);


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 232
-- Name: api_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_submission_id_seq', 4, true);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 234
-- Name: api_submissioncomment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_submissioncomment_id_seq', 16, true);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 237
-- Name: api_task_assignees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_task_assignees_id_seq', 7, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 238
-- Name: api_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_task_id_seq', 13, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 240
-- Name: api_taskdependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_taskdependency_id_seq', 14, true);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 243
-- Name: api_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_groups_id_seq', 1, false);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 244
-- Name: api_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_id_seq', 5, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 246
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 249
-- Name: api_venue_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_venue_domains_id_seq', 24, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 250
-- Name: api_venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_venue_id_seq', 7, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 252
-- Name: api_venue_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_venue_keywords_id_seq', 22, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 254
-- Name: api_venue_reviewers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_venue_reviewers_id_seq', 2, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 256
-- Name: api_venueschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_venueschedule_id_seq', 4, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 258
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 260
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 262
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 265
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 109, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 267
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 27, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 269
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 53, true);


--
-- TOC entry 3074 (class 2606 OID 16624)
-- Name: api_conference api_conference_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_conference
    ADD CONSTRAINT api_conference_pkey PRIMARY KEY (venue_ptr_id);


--
-- TOC entry 3077 (class 2606 OID 16626)
-- Name: api_domain api_domain_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_domain
    ADD CONSTRAINT api_domain_name_key UNIQUE (name);


--
-- TOC entry 3079 (class 2606 OID 16628)
-- Name: api_domain api_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_domain
    ADD CONSTRAINT api_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3081 (class 2606 OID 16630)
-- Name: api_fileupload api_fileupload_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_fileupload
    ADD CONSTRAINT api_fileupload_pkey PRIMARY KEY (id);


--
-- TOC entry 3085 (class 2606 OID 16632)
-- Name: api_journal api_journal_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_journal
    ADD CONSTRAINT api_journal_pkey PRIMARY KEY (venue_ptr_id);


--
-- TOC entry 3088 (class 2606 OID 16634)
-- Name: api_keyword api_keyword_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_keyword
    ADD CONSTRAINT api_keyword_name_key UNIQUE (name);


--
-- TOC entry 3090 (class 2606 OID 16636)
-- Name: api_keyword api_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_keyword
    ADD CONSTRAINT api_keyword_pkey PRIMARY KEY (id);


--
-- TOC entry 3093 (class 2606 OID 16638)
-- Name: api_note api_note_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_note
    ADD CONSTRAINT api_note_pkey PRIMARY KEY (id);


--
-- TOC entry 3096 (class 2606 OID 16640)
-- Name: api_paper api_paper_doi_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper
    ADD CONSTRAINT api_paper_doi_key UNIQUE (doi);


--
-- TOC entry 3103 (class 2606 OID 16642)
-- Name: api_paper_keywords api_paper_keywords_paper_id_keyword_id_a12fb2bb_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper_keywords
    ADD CONSTRAINT api_paper_keywords_paper_id_keyword_id_a12fb2bb_uniq UNIQUE (paper_id, keyword_id);


--
-- TOC entry 3105 (class 2606 OID 16644)
-- Name: api_paper_keywords api_paper_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper_keywords
    ADD CONSTRAINT api_paper_keywords_pkey PRIMARY KEY (id);


--
-- TOC entry 3098 (class 2606 OID 16646)
-- Name: api_paper api_paper_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper
    ADD CONSTRAINT api_paper_pkey PRIMARY KEY (id);


--
-- TOC entry 3110 (class 2606 OID 16648)
-- Name: api_project_domains api_project_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_domains
    ADD CONSTRAINT api_project_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3113 (class 2606 OID 16650)
-- Name: api_project_domains api_project_domains_project_id_domain_id_33bb98f5_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_domains
    ADD CONSTRAINT api_project_domains_project_id_domain_id_33bb98f5_uniq UNIQUE (project_id, domain_id);


--
-- TOC entry 3116 (class 2606 OID 16652)
-- Name: api_project_keywords api_project_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_keywords
    ADD CONSTRAINT api_project_keywords_pkey PRIMARY KEY (id);


--
-- TOC entry 3119 (class 2606 OID 16654)
-- Name: api_project_keywords api_project_keywords_project_id_keyword_id_d13d1c80_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_keywords
    ADD CONSTRAINT api_project_keywords_project_id_keyword_id_d13d1c80_uniq UNIQUE (project_id, keyword_id);


--
-- TOC entry 3107 (class 2606 OID 16656)
-- Name: api_project api_project_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project
    ADD CONSTRAINT api_project_pkey PRIMARY KEY (id);


--
-- TOC entry 3122 (class 2606 OID 16658)
-- Name: api_projectcollaborator api_projectcollaborator_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_pkey PRIMARY KEY (id);


--
-- TOC entry 3125 (class 2606 OID 16660)
-- Name: api_projectlist api_projectlist_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist
    ADD CONSTRAINT api_projectlist_pkey PRIMARY KEY (id);


--
-- TOC entry 3130 (class 2606 OID 16662)
-- Name: api_projectpaper api_projectpaper_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_pkey PRIMARY KEY (id);


--
-- TOC entry 3132 (class 2606 OID 16664)
-- Name: api_reviewer api_reviewer_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewer
    ADD CONSTRAINT api_reviewer_pkey PRIMARY KEY (id);


--
-- TOC entry 3136 (class 2606 OID 16666)
-- Name: api_reviewerproposal api_reviewerproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewerproposal
    ADD CONSTRAINT api_reviewerproposal_pkey PRIMARY KEY (id);


--
-- TOC entry 3140 (class 2606 OID 16668)
-- Name: api_submission api_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submission
    ADD CONSTRAINT api_submission_pkey PRIMARY KEY (id);


--
-- TOC entry 3145 (class 2606 OID 16670)
-- Name: api_submissioncomment api_submissioncomment_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment
    ADD CONSTRAINT api_submissioncomment_pkey PRIMARY KEY (id);


--
-- TOC entry 3154 (class 2606 OID 16672)
-- Name: api_task_assignees api_task_assignees_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_pkey PRIMARY KEY (id);


--
-- TOC entry 3158 (class 2606 OID 16674)
-- Name: api_task_assignees api_task_assignees_task_id_projectcollaborator_id_cd4b9818_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_task_id_projectcollaborator_id_cd4b9818_uniq UNIQUE (task_id, projectcollaborator_id);


--
-- TOC entry 3150 (class 2606 OID 16676)
-- Name: api_task api_task_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_pkey PRIMARY KEY (id);


--
-- TOC entry 3162 (class 2606 OID 16678)
-- Name: api_taskdependency api_taskdependency_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_pkey PRIMARY KEY (id);


--
-- TOC entry 3170 (class 2606 OID 16680)
-- Name: api_user_groups api_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3173 (class 2606 OID 16682)
-- Name: api_user_groups api_user_groups_user_id_group_id_9c7ddfb5_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_group_id_9c7ddfb5_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3164 (class 2606 OID 16684)
-- Name: api_user api_user_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3176 (class 2606 OID 16686)
-- Name: api_user_user_permissions api_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3179 (class 2606 OID 16688)
-- Name: api_user_user_permissions api_user_user_permissions_user_id_permission_id_a06dd704_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_permission_id_a06dd704_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3167 (class 2606 OID 16690)
-- Name: api_user api_user_username_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_username_key UNIQUE (username);


--
-- TOC entry 3184 (class 2606 OID 16692)
-- Name: api_venue_domains api_venue_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_domains
    ADD CONSTRAINT api_venue_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3186 (class 2606 OID 16694)
-- Name: api_venue_domains api_venue_domains_venue_id_domain_id_65218c0d_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_domains
    ADD CONSTRAINT api_venue_domains_venue_id_domain_id_65218c0d_uniq UNIQUE (venue_id, domain_id);


--
-- TOC entry 3190 (class 2606 OID 16696)
-- Name: api_venue_keywords api_venue_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_keywords
    ADD CONSTRAINT api_venue_keywords_pkey PRIMARY KEY (id);


--
-- TOC entry 3193 (class 2606 OID 16698)
-- Name: api_venue_keywords api_venue_keywords_venue_id_keyword_id_94285cca_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_keywords
    ADD CONSTRAINT api_venue_keywords_venue_id_keyword_id_94285cca_uniq UNIQUE (venue_id, keyword_id);


--
-- TOC entry 3181 (class 2606 OID 16700)
-- Name: api_venue api_venue_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue
    ADD CONSTRAINT api_venue_pkey PRIMARY KEY (id);


--
-- TOC entry 3195 (class 2606 OID 16702)
-- Name: api_venue_reviewers api_venue_reviewers_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_reviewers
    ADD CONSTRAINT api_venue_reviewers_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 16704)
-- Name: api_venue_reviewers api_venue_reviewers_venue_id_user_id_5eae8f9d_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_reviewers
    ADD CONSTRAINT api_venue_reviewers_venue_id_user_id_5eae8f9d_uniq UNIQUE (venue_id, user_id);


--
-- TOC entry 3201 (class 2606 OID 16706)
-- Name: api_venueactivity api_venueschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venueactivity
    ADD CONSTRAINT api_venueschedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3205 (class 2606 OID 16708)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3210 (class 2606 OID 16710)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3213 (class 2606 OID 16712)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3207 (class 2606 OID 16714)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16716)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3218 (class 2606 OID 16718)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 16720)
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- TOC entry 3223 (class 2606 OID 16722)
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- TOC entry 3226 (class 2606 OID 16724)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3229 (class 2606 OID 16726)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3231 (class 2606 OID 16728)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16730)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 16732)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3075 (class 1259 OID 16733)
-- Name: api_domain_name_618ec550_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_domain_name_618ec550_like ON public.api_domain USING btree (name varchar_pattern_ops);


--
-- TOC entry 3082 (class 1259 OID 16734)
-- Name: api_fileupload_project_id_11f2e84f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_fileupload_project_id_11f2e84f ON public.api_fileupload USING btree (project_id);


--
-- TOC entry 3083 (class 1259 OID 16735)
-- Name: api_fileupload_uploader_id_33bd947c; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_fileupload_uploader_id_33bd947c ON public.api_fileupload USING btree (uploader_id);


--
-- TOC entry 3086 (class 1259 OID 16736)
-- Name: api_keyword_name_c622d3b0_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_keyword_name_c622d3b0_like ON public.api_keyword USING btree (name varchar_pattern_ops);


--
-- TOC entry 3091 (class 1259 OID 16737)
-- Name: api_note_creator_id_id_394e6615; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_note_creator_id_id_394e6615 ON public.api_note USING btree (creator_id);


--
-- TOC entry 3094 (class 1259 OID 16738)
-- Name: api_paper_doi_0cc7a2e7_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_paper_doi_0cc7a2e7_like ON public.api_paper USING btree (doi varchar_pattern_ops);


--
-- TOC entry 3100 (class 1259 OID 16739)
-- Name: api_paper_keywords_keyword_id_6b0572b8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_paper_keywords_keyword_id_6b0572b8 ON public.api_paper_keywords USING btree (keyword_id);


--
-- TOC entry 3101 (class 1259 OID 16740)
-- Name: api_paper_keywords_paper_id_ae817003; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_paper_keywords_paper_id_ae817003 ON public.api_paper_keywords USING btree (paper_id);


--
-- TOC entry 3099 (class 1259 OID 16741)
-- Name: api_paper_venue_id_4dfdee4d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_paper_venue_id_4dfdee4d ON public.api_paper USING btree (venue_id);


--
-- TOC entry 3108 (class 1259 OID 16742)
-- Name: api_project_domains_domain_id_ff8f6c72; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_project_domains_domain_id_ff8f6c72 ON public.api_project_domains USING btree (domain_id);


--
-- TOC entry 3111 (class 1259 OID 16743)
-- Name: api_project_domains_project_id_44f915e6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_project_domains_project_id_44f915e6 ON public.api_project_domains USING btree (project_id);


--
-- TOC entry 3114 (class 1259 OID 16744)
-- Name: api_project_keywords_keyword_id_7692e59b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_project_keywords_keyword_id_7692e59b ON public.api_project_keywords USING btree (keyword_id);


--
-- TOC entry 3117 (class 1259 OID 16745)
-- Name: api_project_keywords_project_id_b6f2b2dc; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_project_keywords_project_id_b6f2b2dc ON public.api_project_keywords USING btree (project_id);


--
-- TOC entry 3120 (class 1259 OID 16746)
-- Name: api_projectcollaborator_collaborator_id_d1fb635f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectcollaborator_collaborator_id_d1fb635f ON public.api_projectcollaborator USING btree (collaborator_id);


--
-- TOC entry 3123 (class 1259 OID 16747)
-- Name: api_projectcollaborator_project_id_f4fb87e6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectcollaborator_project_id_f4fb87e6 ON public.api_projectcollaborator USING btree (project_id);


--
-- TOC entry 3126 (class 1259 OID 16748)
-- Name: api_projectlist_project_id_d9e8ea7d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectlist_project_id_d9e8ea7d ON public.api_projectlist USING btree (project_id);


--
-- TOC entry 3127 (class 1259 OID 16749)
-- Name: api_projectpaper_list_id_6b0c4e68; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectpaper_list_id_6b0c4e68 ON public.api_projectpaper USING btree (list_id);


--
-- TOC entry 3128 (class 1259 OID 16750)
-- Name: api_projectpaper_paper_id_83fe75a8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_projectpaper_paper_id_83fe75a8 ON public.api_projectpaper USING btree (paper_id);


--
-- TOC entry 3133 (class 1259 OID 16751)
-- Name: api_reviewer_submission_id_4704bdcf; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_reviewer_submission_id_4704bdcf ON public.api_reviewer USING btree (submission_id);


--
-- TOC entry 3134 (class 1259 OID 16752)
-- Name: api_reviewer_user_id_8990e565; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_reviewer_user_id_8990e565 ON public.api_reviewer USING btree (user_id);


--
-- TOC entry 3137 (class 1259 OID 16753)
-- Name: api_reviewerproposal_reviewer_id_75c15221; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_reviewerproposal_reviewer_id_75c15221 ON public.api_reviewerproposal USING btree (reviewer_id);


--
-- TOC entry 3138 (class 1259 OID 16754)
-- Name: api_reviewerproposal_venue_id_5a1eba83; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_reviewerproposal_venue_id_5a1eba83 ON public.api_reviewerproposal USING btree (venue_id);


--
-- TOC entry 3141 (class 1259 OID 16755)
-- Name: api_submission_project_id_d6d56981; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submission_project_id_d6d56981 ON public.api_submission USING btree (project_id);


--
-- TOC entry 3142 (class 1259 OID 16756)
-- Name: api_submission_venue_id_8bbf3f1b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submission_venue_id_8bbf3f1b ON public.api_submission USING btree (venue_id);


--
-- TOC entry 3143 (class 1259 OID 16757)
-- Name: api_submissioncomment_parent_id_a941fb2e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submissioncomment_parent_id_a941fb2e ON public.api_submissioncomment USING btree (parent_id);


--
-- TOC entry 3146 (class 1259 OID 16758)
-- Name: api_submissioncomment_reviewer_thread_id_1998e47f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submissioncomment_reviewer_thread_id_1998e47f ON public.api_submissioncomment USING btree (reviewer_thread_id);


--
-- TOC entry 3147 (class 1259 OID 16759)
-- Name: api_submissioncomment_submission_id_3a3ef2b6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submissioncomment_submission_id_3a3ef2b6 ON public.api_submissioncomment USING btree (submission_id);


--
-- TOC entry 3148 (class 1259 OID 16760)
-- Name: api_submissioncomment_user_id_8d8431f5; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_submissioncomment_user_id_8d8431f5 ON public.api_submissioncomment USING btree (user_id);


--
-- TOC entry 3155 (class 1259 OID 16761)
-- Name: api_task_assignees_projectcollaborator_id_3464d049; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_assignees_projectcollaborator_id_3464d049 ON public.api_task_assignees USING btree (projectcollaborator_id);


--
-- TOC entry 3156 (class 1259 OID 16762)
-- Name: api_task_assignees_task_id_692b56f6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_assignees_task_id_692b56f6 ON public.api_task_assignees USING btree (task_id);


--
-- TOC entry 3151 (class 1259 OID 16763)
-- Name: api_task_project_id_8e1d0a15; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_project_id_8e1d0a15 ON public.api_task USING btree (project_id);


--
-- TOC entry 3152 (class 1259 OID 16764)
-- Name: api_task_project_paper_id_7c142334; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_task_project_paper_id_7c142334 ON public.api_task USING btree (project_paper_id);


--
-- TOC entry 3159 (class 1259 OID 16765)
-- Name: api_taskdependency_after_id_a99d92c9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_taskdependency_after_id_a99d92c9 ON public.api_taskdependency USING btree (after_id);


--
-- TOC entry 3160 (class 1259 OID 16766)
-- Name: api_taskdependency_before_id_e2735fe0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_taskdependency_before_id_e2735fe0 ON public.api_taskdependency USING btree (before_id);


--
-- TOC entry 3168 (class 1259 OID 16767)
-- Name: api_user_groups_group_id_3af85785; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_groups_group_id_3af85785 ON public.api_user_groups USING btree (group_id);


--
-- TOC entry 3171 (class 1259 OID 16768)
-- Name: api_user_groups_user_id_a5ff39fa; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_groups_user_id_a5ff39fa ON public.api_user_groups USING btree (user_id);


--
-- TOC entry 3174 (class 1259 OID 16769)
-- Name: api_user_user_permissions_permission_id_305b7fea; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_user_permissions_permission_id_305b7fea ON public.api_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3177 (class 1259 OID 16770)
-- Name: api_user_user_permissions_user_id_f3945d65; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_user_permissions_user_id_f3945d65 ON public.api_user_user_permissions USING btree (user_id);


--
-- TOC entry 3165 (class 1259 OID 16771)
-- Name: api_user_username_cf4e88d2_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_user_username_cf4e88d2_like ON public.api_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3182 (class 1259 OID 16772)
-- Name: api_venue_domains_domain_id_0afe0360; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_domains_domain_id_0afe0360 ON public.api_venue_domains USING btree (domain_id);


--
-- TOC entry 3187 (class 1259 OID 16773)
-- Name: api_venue_domains_venue_id_e87690b5; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_domains_venue_id_e87690b5 ON public.api_venue_domains USING btree (venue_id);


--
-- TOC entry 3188 (class 1259 OID 16774)
-- Name: api_venue_keywords_keyword_id_9b4fc564; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_keywords_keyword_id_9b4fc564 ON public.api_venue_keywords USING btree (keyword_id);


--
-- TOC entry 3191 (class 1259 OID 16775)
-- Name: api_venue_keywords_venue_id_32e5065a; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_keywords_venue_id_32e5065a ON public.api_venue_keywords USING btree (venue_id);


--
-- TOC entry 3196 (class 1259 OID 16776)
-- Name: api_venue_reviewers_user_id_a4a117e4; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_reviewers_user_id_a4a117e4 ON public.api_venue_reviewers USING btree (user_id);


--
-- TOC entry 3197 (class 1259 OID 16777)
-- Name: api_venue_reviewers_venue_id_85799ae0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venue_reviewers_venue_id_85799ae0 ON public.api_venue_reviewers USING btree (venue_id);


--
-- TOC entry 3202 (class 1259 OID 16778)
-- Name: api_venueschedule_venue_id_a4da5392; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX api_venueschedule_venue_id_a4da5392 ON public.api_venueactivity USING btree (venue_id);


--
-- TOC entry 3203 (class 1259 OID 16779)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3208 (class 1259 OID 16780)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3211 (class 1259 OID 16781)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3214 (class 1259 OID 16782)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3219 (class 1259 OID 16783)
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- TOC entry 3224 (class 1259 OID 16784)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3227 (class 1259 OID 16785)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3234 (class 1259 OID 16786)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3237 (class 1259 OID 16787)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3238 (class 2606 OID 16788)
-- Name: api_conference api_conference_venue_ptr_id_5e56172b_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_conference
    ADD CONSTRAINT api_conference_venue_ptr_id_5e56172b_fk_api_venue_id FOREIGN KEY (venue_ptr_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3239 (class 2606 OID 16793)
-- Name: api_fileupload api_fileupload_project_id_11f2e84f_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_fileupload
    ADD CONSTRAINT api_fileupload_project_id_11f2e84f_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3240 (class 2606 OID 16798)
-- Name: api_fileupload api_fileupload_uploader_id_33bd947c_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_fileupload
    ADD CONSTRAINT api_fileupload_uploader_id_33bd947c_fk_api_user_id FOREIGN KEY (uploader_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3241 (class 2606 OID 16803)
-- Name: api_journal api_journal_venue_ptr_id_cf1ccad2_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_journal
    ADD CONSTRAINT api_journal_venue_ptr_id_cf1ccad2_fk_api_venue_id FOREIGN KEY (venue_ptr_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3242 (class 2606 OID 16808)
-- Name: api_note api_note_creator_id_ef904ef3_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_note
    ADD CONSTRAINT api_note_creator_id_ef904ef3_fk_api_user_id FOREIGN KEY (creator_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3243 (class 2606 OID 16813)
-- Name: api_note api_note_id_b72fdfc9_fk_api_projectpaper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_note
    ADD CONSTRAINT api_note_id_b72fdfc9_fk_api_projectpaper_id FOREIGN KEY (id) REFERENCES public.api_projectpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3245 (class 2606 OID 16818)
-- Name: api_paper_keywords api_paper_keywords_keyword_id_6b0572b8_fk_api_keyword_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper_keywords
    ADD CONSTRAINT api_paper_keywords_keyword_id_6b0572b8_fk_api_keyword_id FOREIGN KEY (keyword_id) REFERENCES public.api_keyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3246 (class 2606 OID 16823)
-- Name: api_paper_keywords api_paper_keywords_paper_id_ae817003_fk_api_paper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper_keywords
    ADD CONSTRAINT api_paper_keywords_paper_id_ae817003_fk_api_paper_id FOREIGN KEY (paper_id) REFERENCES public.api_paper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3244 (class 2606 OID 16828)
-- Name: api_paper api_paper_venue_id_4dfdee4d_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_paper
    ADD CONSTRAINT api_paper_venue_id_4dfdee4d_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3247 (class 2606 OID 16833)
-- Name: api_project_domains api_project_domains_domain_id_ff8f6c72_fk_api_domain_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_domains
    ADD CONSTRAINT api_project_domains_domain_id_ff8f6c72_fk_api_domain_id FOREIGN KEY (domain_id) REFERENCES public.api_domain(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3248 (class 2606 OID 16838)
-- Name: api_project_domains api_project_domains_project_id_44f915e6_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_domains
    ADD CONSTRAINT api_project_domains_project_id_44f915e6_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3249 (class 2606 OID 16843)
-- Name: api_project_keywords api_project_keywords_keyword_id_7692e59b_fk_api_keyword_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_keywords
    ADD CONSTRAINT api_project_keywords_keyword_id_7692e59b_fk_api_keyword_id FOREIGN KEY (keyword_id) REFERENCES public.api_keyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3250 (class 2606 OID 16848)
-- Name: api_project_keywords api_project_keywords_project_id_b6f2b2dc_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_project_keywords
    ADD CONSTRAINT api_project_keywords_project_id_b6f2b2dc_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3251 (class 2606 OID 16853)
-- Name: api_projectcollaborator api_projectcollaborator_collaborator_id_d1fb635f_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_collaborator_id_d1fb635f_fk_api_user_id FOREIGN KEY (collaborator_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3252 (class 2606 OID 16858)
-- Name: api_projectcollaborator api_projectcollaborator_project_id_f4fb87e6_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectcollaborator
    ADD CONSTRAINT api_projectcollaborator_project_id_f4fb87e6_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3253 (class 2606 OID 16863)
-- Name: api_projectlist api_projectlist_project_id_d9e8ea7d_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectlist
    ADD CONSTRAINT api_projectlist_project_id_d9e8ea7d_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3254 (class 2606 OID 16868)
-- Name: api_projectpaper api_projectpaper_list_id_6b0c4e68_fk_api_projectlist_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_list_id_6b0c4e68_fk_api_projectlist_id FOREIGN KEY (list_id) REFERENCES public.api_projectlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3255 (class 2606 OID 16873)
-- Name: api_projectpaper api_projectpaper_paper_id_83fe75a8_fk_api_paper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_projectpaper
    ADD CONSTRAINT api_projectpaper_paper_id_83fe75a8_fk_api_paper_id FOREIGN KEY (paper_id) REFERENCES public.api_paper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3256 (class 2606 OID 16878)
-- Name: api_reviewer api_reviewer_submission_id_4704bdcf_fk_api_submission_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewer
    ADD CONSTRAINT api_reviewer_submission_id_4704bdcf_fk_api_submission_id FOREIGN KEY (submission_id) REFERENCES public.api_submission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3257 (class 2606 OID 16883)
-- Name: api_reviewer api_reviewer_user_id_8990e565_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewer
    ADD CONSTRAINT api_reviewer_user_id_8990e565_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3258 (class 2606 OID 16888)
-- Name: api_reviewerproposal api_reviewerproposal_reviewer_id_75c15221_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewerproposal
    ADD CONSTRAINT api_reviewerproposal_reviewer_id_75c15221_fk_api_user_id FOREIGN KEY (reviewer_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3259 (class 2606 OID 16893)
-- Name: api_reviewerproposal api_reviewerproposal_venue_id_5a1eba83_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_reviewerproposal
    ADD CONSTRAINT api_reviewerproposal_venue_id_5a1eba83_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3260 (class 2606 OID 16898)
-- Name: api_submission api_submission_project_id_d6d56981_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submission
    ADD CONSTRAINT api_submission_project_id_d6d56981_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3261 (class 2606 OID 16903)
-- Name: api_submission api_submission_venue_id_8bbf3f1b_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submission
    ADD CONSTRAINT api_submission_venue_id_8bbf3f1b_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3262 (class 2606 OID 16908)
-- Name: api_submissioncomment api_submissioncommen_parent_id_a941fb2e_fk_api_submi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment
    ADD CONSTRAINT api_submissioncommen_parent_id_a941fb2e_fk_api_submi FOREIGN KEY (parent_id) REFERENCES public.api_submissioncomment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3263 (class 2606 OID 16913)
-- Name: api_submissioncomment api_submissioncommen_reviewer_thread_id_1998e47f_fk_api_user_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment
    ADD CONSTRAINT api_submissioncommen_reviewer_thread_id_1998e47f_fk_api_user_ FOREIGN KEY (reviewer_thread_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3264 (class 2606 OID 16918)
-- Name: api_submissioncomment api_submissioncommen_submission_id_3a3ef2b6_fk_api_submi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment
    ADD CONSTRAINT api_submissioncommen_submission_id_3a3ef2b6_fk_api_submi FOREIGN KEY (submission_id) REFERENCES public.api_submission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3265 (class 2606 OID 16923)
-- Name: api_submissioncomment api_submissioncomment_user_id_8d8431f5_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_submissioncomment
    ADD CONSTRAINT api_submissioncomment_user_id_8d8431f5_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3268 (class 2606 OID 16928)
-- Name: api_task_assignees api_task_assignees_projectcollaborator__3464d049_fk_api_proje; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_projectcollaborator__3464d049_fk_api_proje FOREIGN KEY (projectcollaborator_id) REFERENCES public.api_projectcollaborator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3269 (class 2606 OID 16933)
-- Name: api_task_assignees api_task_assignees_task_id_692b56f6_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task_assignees
    ADD CONSTRAINT api_task_assignees_task_id_692b56f6_fk_api_task_id FOREIGN KEY (task_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3266 (class 2606 OID 16938)
-- Name: api_task api_task_project_id_8e1d0a15_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_project_id_8e1d0a15_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3267 (class 2606 OID 16943)
-- Name: api_task api_task_project_paper_id_7c142334_fk_api_projectpaper_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_task
    ADD CONSTRAINT api_task_project_paper_id_7c142334_fk_api_projectpaper_id FOREIGN KEY (project_paper_id) REFERENCES public.api_projectpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3270 (class 2606 OID 16948)
-- Name: api_taskdependency api_taskdependency_after_id_a99d92c9_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_after_id_a99d92c9_fk_api_task_id FOREIGN KEY (after_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3271 (class 2606 OID 16953)
-- Name: api_taskdependency api_taskdependency_before_id_e2735fe0_fk_api_task_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_taskdependency
    ADD CONSTRAINT api_taskdependency_before_id_e2735fe0_fk_api_task_id FOREIGN KEY (before_id) REFERENCES public.api_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3272 (class 2606 OID 16958)
-- Name: api_user_groups api_user_groups_group_id_3af85785_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_group_id_3af85785_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3273 (class 2606 OID 16963)
-- Name: api_user_groups api_user_groups_user_id_a5ff39fa_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_a5ff39fa_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3274 (class 2606 OID 16968)
-- Name: api_user_user_permissions api_user_user_permis_permission_id_305b7fea_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permis_permission_id_305b7fea_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3275 (class 2606 OID 16973)
-- Name: api_user_user_permissions api_user_user_permissions_user_id_f3945d65_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_f3945d65_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3276 (class 2606 OID 16978)
-- Name: api_venue_domains api_venue_domains_domain_id_0afe0360_fk_api_domain_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_domains
    ADD CONSTRAINT api_venue_domains_domain_id_0afe0360_fk_api_domain_id FOREIGN KEY (domain_id) REFERENCES public.api_domain(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3277 (class 2606 OID 16983)
-- Name: api_venue_domains api_venue_domains_venue_id_e87690b5_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_domains
    ADD CONSTRAINT api_venue_domains_venue_id_e87690b5_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3278 (class 2606 OID 16988)
-- Name: api_venue_keywords api_venue_keywords_keyword_id_9b4fc564_fk_api_keyword_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_keywords
    ADD CONSTRAINT api_venue_keywords_keyword_id_9b4fc564_fk_api_keyword_id FOREIGN KEY (keyword_id) REFERENCES public.api_keyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3279 (class 2606 OID 16993)
-- Name: api_venue_keywords api_venue_keywords_venue_id_32e5065a_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_keywords
    ADD CONSTRAINT api_venue_keywords_venue_id_32e5065a_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3280 (class 2606 OID 16998)
-- Name: api_venue_reviewers api_venue_reviewers_user_id_a4a117e4_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_reviewers
    ADD CONSTRAINT api_venue_reviewers_user_id_a4a117e4_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3281 (class 2606 OID 17003)
-- Name: api_venue_reviewers api_venue_reviewers_venue_id_85799ae0_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venue_reviewers
    ADD CONSTRAINT api_venue_reviewers_venue_id_85799ae0_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3282 (class 2606 OID 17008)
-- Name: api_venueactivity api_venueschedule_venue_id_a4da5392_fk_api_venue_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_venueactivity
    ADD CONSTRAINT api_venueschedule_venue_id_a4da5392_fk_api_venue_id FOREIGN KEY (venue_id) REFERENCES public.api_venue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3283 (class 2606 OID 17013)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3284 (class 2606 OID 17018)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3285 (class 2606 OID 17023)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3286 (class 2606 OID 17028)
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3287 (class 2606 OID 17033)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3288 (class 2606 OID 17038)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2022-08-28 07:21:39 +06

--
-- PostgreSQL database dump complete
--

