--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: brazda; Type: DATABASE; Schema: -; Owner: brazda
--

CREATE DATABASE brazda WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE brazda OWNER TO brazda;

\connect brazda

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: ufngetteamsresultsforpost(integer); Type: FUNCTION; Schema: public; Owner: brazda
--

CREATE FUNCTION ufngetteamsresultsforpost(postid integer) RETURNS TABLE(teamid integer, moment timestamp without time zone, helpused boolean, score bigint)
    LANGUAGE sql
    AS $_$
		SELECT
			 T.team AS teamId
			,L.moment AS moment
			,(CASE WHEN LHlp.moment IS NULL THEN False ELSE True END) AS helpUsed
			--,P.max_score AS maxScore
			,P.max_score - (ROW_NUMBER() OVER (ORDER BY (CASE WHEN LHlp.moment IS NULL THEN 0 ELSE 1 END), L.moment) - 1) * 3 AS score
		  FROM teams AS T
			INNER JOIN logs AS L
				ON T.team = L.team AND L.log_type = 'OUT' AND L.post = $1							-- gets all OUT logs
			LEFT JOIN logs AS LHlp
				ON T.team = LHlp.team AND LHlp.log_type = 'HLP'	AND lHlp.post = $1					-- gets all HLP logs
			INNER JOIN posts AS P
				ON L.post = P.post AND P.post_type NOT IN ('BEG', 'FIN', 'ORG')						-- get post data

		  WHERE T.team_type = 'COM'

		  ORDER BY helpUsed, L.moment
		$_$;


ALTER FUNCTION public.ufngetteamsresultsforpost(postid integer) OWNER TO brazda;

--
-- Name: ufngetteamsresultsforpostbonus(integer); Type: FUNCTION; Schema: public; Owner: brazda
--

CREATE FUNCTION ufngetteamsresultsforpostbonus(postid integer) RETURNS TABLE(teamid integer, moment timestamp without time zone, helpused boolean, score bigint)
    LANGUAGE sql
    AS $_$
		SELECT
			 T.team AS teamId
			,L.moment AS moment
			,False AS helpUsed
			--,P.max_score AS maxScore
			,P.max_score - (ROW_NUMBER() OVER (ORDER BY L.moment) - 1) * 3 AS score
		  FROM teams AS T
			INNER JOIN logs AS L
				ON T.team = L.team AND L.log_type = 'BON' AND L.post = $1							-- gets all OUT logs
			INNER JOIN posts AS P
				ON L.post = P.post AND P.post_type = 'BON'											-- get post data

		  WHERE T.team_type = 'COM'

		  ORDER BY helpUsed, L.moment
		$_$;


ALTER FUNCTION public.ufngetteamsresultsforpostbonus(postid integer) OWNER TO brazda;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE audit_logs (
    audit_log integer NOT NULL,
    team integer NOT NULL,
    moment timestamp without time zone DEFAULT now() NOT NULL,
    message text,
    log_type character varying(10) DEFAULT 'info'::character varying NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO brazda;

--
-- Name: audit_logs_audit_log_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE audit_logs_audit_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_audit_log_seq OWNER TO brazda;

--
-- Name: audit_logs_audit_log_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE audit_logs_audit_log_seq OWNED BY audit_logs.audit_log;


--
-- Name: cache_types; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE cache_types (
    cache_type character(3) NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.cache_types OWNER TO brazda;

--
-- Name: log_types; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE log_types (
    log_type character(3) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.log_types OWNER TO brazda;

--
-- Name: logs; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE logs (
    log integer NOT NULL,
    log_type character(3) NOT NULL,
    team integer NOT NULL,
    post integer NOT NULL,
    moment timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.logs OWNER TO brazda;

--
-- Name: logs_log_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE logs_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_log_seq OWNER TO brazda;

--
-- Name: logs_log_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE logs_log_seq OWNED BY logs.log;


--
-- Name: players; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE players (
    player integer NOT NULL,
    team integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.players OWNER TO brazda;

--
-- Name: players_player_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE players_player_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_seq OWNER TO brazda;

--
-- Name: players_player_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE players_player_seq OWNED BY players.player;


--
-- Name: post_colors; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE post_colors (
    color character(3) NOT NULL,
    name character varying(10) NOT NULL,
    code character varying(20) NOT NULL
);


ALTER TABLE public.post_colors OWNER TO brazda;

--
-- Name: post_notes; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE post_notes (
    post_note integer NOT NULL,
    post integer NOT NULL,
    team integer NOT NULL,
    last_change timestamp without time zone DEFAULT now() NOT NULL,
    note text
);


ALTER TABLE public.post_notes OWNER TO brazda;

--
-- Name: post_notes_post_note_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE post_notes_post_note_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_notes_post_note_seq OWNER TO brazda;

--
-- Name: post_notes_post_note_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE post_notes_post_note_seq OWNED BY post_notes.post_note;


--
-- Name: post_sizes; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE post_sizes (
    size character(1) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.post_sizes OWNER TO brazda;

--
-- Name: post_types; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE post_types (
    post_type character(3) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.post_types OWNER TO brazda;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE posts (
    post integer NOT NULL,
    post_type character(3) NOT NULL,
    color character(3) NOT NULL,
    name character varying(255) NOT NULL,
    max_score integer DEFAULT 0 NOT NULL,
    difficulty double precision DEFAULT 1 NOT NULL,
    terrain double precision DEFAULT 1 NOT NULL,
    size character(1) DEFAULT 'O'::bpchar NOT NULL,
    cache_type character(3) DEFAULT 'TRA'::bpchar,
    shibboleth character varying(20) NOT NULL,
    with_staff boolean DEFAULT false NOT NULL,
    hint text,
    help text,
    description text,
    bonus_code character varying(20)
);


ALTER TABLE public.posts OWNER TO brazda;

--
-- Name: posts_post_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE posts_post_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_seq OWNER TO brazda;

--
-- Name: posts_post_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE posts_post_seq OWNED BY posts.post;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE teams (
    team integer NOT NULL,
    team_type character(3) DEFAULT 'COM'::bpchar NOT NULL,
    name character varying(100) NOT NULL,
    shibboleth character varying(20) NOT NULL,
    description text
);


ALTER TABLE public.teams OWNER TO brazda;

--
-- Name: results; Type: VIEW; Schema: public; Owner: brazda
--

CREATE VIEW results AS
    SELECT t.team AS teamid, t.name AS teamname, COALESCE(s2.score, (0)::bigint) AS s2, COALESCE(s3.score, (0)::bigint) AS s3, COALESCE(s4.score, (0)::bigint) AS s4, COALESCE(s5.score, (0)::bigint) AS s5, COALESCE(s6.score, (0)::bigint) AS s6, COALESCE(s7.score, (0)::bigint) AS s7, COALESCE(s8.score, (0)::bigint) AS s8, COALESCE(s9.score, (0)::bigint) AS s9, COALESCE(s10.score, (0)::bigint) AS s10, COALESCE(s11.score, (0)::bigint) AS s11, COALESCE(s12.score, (0)::bigint) AS s12, COALESCE(s13.score, (0)::bigint) AS s13, COALESCE(s14.score, (0)::bigint) AS s14, COALESCE(s15.score, (0)::bigint) AS s15, COALESCE(s16.score, (0)::bigint) AS s16, COALESCE(s17.score, (0)::bigint) AS s17, COALESCE(s18.score, (0)::bigint) AS s18, COALESCE(s19.score, (0)::bigint) AS s19, COALESCE(s20.score, (0)::bigint) AS s20, COALESCE(s21.score, (0)::bigint) AS s21, COALESCE(s22.score, (0)::bigint) AS s22, COALESCE(s23.score, (0)::bigint) AS s23, COALESCE(s24.score, (0)::bigint) AS s24, COALESCE(s25.score, (0)::bigint) AS s25, COALESCE(s26.score, (0)::bigint) AS s26, COALESCE(s27.score, (0)::bigint) AS s27, COALESCE(s28.score, (0)::bigint) AS s28, COALESCE(s29.score, (0)::bigint) AS s29, COALESCE(s30.score, (0)::bigint) AS s30, COALESCE(s31.score, (0)::bigint) AS s31, x.moment AS finishedat, CASE WHEN (x.moment > '2016-10-01 19:15:00'::timestamp without time zone) THEN ((date_part('hour'::text, (x.moment - ('19:15:00'::time without time zone)::interval)) * (60)::double precision) + date_part('minute'::text, (x.moment - ('19:15:00'::time without time zone)::interval))) ELSE (0)::double precision END AS delay, (((((((((((((((((((((((((((((((COALESCE(s2.score, (0)::bigint) + COALESCE(s3.score, (0)::bigint)) + COALESCE(s4.score, (0)::bigint)) + COALESCE(s5.score, (0)::bigint)) + COALESCE(s6.score, (0)::bigint)) + COALESCE(s7.score, (0)::bigint)) + COALESCE(s8.score, (0)::bigint)) + COALESCE(s9.score, (0)::bigint)) + COALESCE(s10.score, (0)::bigint)) + COALESCE(s11.score, (0)::bigint)) + COALESCE(s12.score, (0)::bigint)) + COALESCE(s13.score, (0)::bigint)) + COALESCE(s14.score, (0)::bigint)) + COALESCE(s15.score, (0)::bigint)) + COALESCE(s16.score, (0)::bigint)) + COALESCE(s17.score, (0)::bigint)) + COALESCE(s18.score, (0)::bigint)) + COALESCE(s19.score, (0)::bigint)) + COALESCE(s20.score, (0)::bigint)) + COALESCE(s21.score, (0)::bigint)) + COALESCE(s22.score, (0)::bigint)) + COALESCE(s23.score, (0)::bigint)) + COALESCE(s24.score, (0)::bigint)) + COALESCE(s25.score, (0)::bigint)) + COALESCE(s26.score, (0)::bigint)) + COALESCE(s27.score, (0)::bigint)) + COALESCE(s28.score, (0)::bigint)) + COALESCE(s29.score, (0)::bigint)) + COALESCE(s30.score, (0)::bigint)) + COALESCE(s31.score, (0)::bigint)))::double precision - (CASE WHEN (x.moment > '2016-10-01 19:00:00'::timestamp without time zone) THEN ((date_part('hour'::text, (x.moment - ('19:00:00'::time without time zone)::interval)) * (60)::double precision) + date_part('minute'::text, (x.moment - ('19:00:00'::time without time zone)::interval))) ELSE (0)::double precision END * (10)::double precision)) AS score FROM (((((((((((((((((((((((((((((((teams t LEFT JOIN (SELECT l.team, l.moment FROM (logs l LEFT JOIN posts p ON ((l.post = p.post))) WHERE (p.post_type = 'FIN'::bpchar)) x ON ((t.team = x.team))) LEFT JOIN ufngetteamsresultsforpost(2) s2(teamid, moment, helpused, score) ON ((t.team = s2.teamid))) LEFT JOIN ufngetteamsresultsforpost(3) s3(teamid, moment, helpused, score) ON ((t.team = s3.teamid))) LEFT JOIN ufngetteamsresultsforpost(4) s4(teamid, moment, helpused, score) ON ((t.team = s4.teamid))) LEFT JOIN ufngetteamsresultsforpost(5) s5(teamid, moment, helpused, score) ON ((t.team = s5.teamid))) LEFT JOIN ufngetteamsresultsforpost(6) s6(teamid, moment, helpused, score) ON ((t.team = s6.teamid))) LEFT JOIN ufngetteamsresultsforpost(7) s7(teamid, moment, helpused, score) ON ((t.team = s7.teamid))) LEFT JOIN ufngetteamsresultsforpost(8) s8(teamid, moment, helpused, score) ON ((t.team = s8.teamid))) LEFT JOIN ufngetteamsresultsforpost(9) s9(teamid, moment, helpused, score) ON ((t.team = s9.teamid))) LEFT JOIN ufngetteamsresultsforpost(10) s10(teamid, moment, helpused, score) ON ((t.team = s10.teamid))) LEFT JOIN ufngetteamsresultsforpost(11) s11(teamid, moment, helpused, score) ON ((t.team = s11.teamid))) LEFT JOIN ufngetteamsresultsforpost(12) s12(teamid, moment, helpused, score) ON ((t.team = s12.teamid))) LEFT JOIN ufngetteamsresultsforpost(13) s13(teamid, moment, helpused, score) ON ((t.team = s13.teamid))) LEFT JOIN ufngetteamsresultsforpost(14) s14(teamid, moment, helpused, score) ON ((t.team = s14.teamid))) LEFT JOIN ufngetteamsresultsforpost(15) s15(teamid, moment, helpused, score) ON ((t.team = s15.teamid))) LEFT JOIN ufngetteamsresultsforpost(16) s16(teamid, moment, helpused, score) ON ((t.team = s16.teamid))) LEFT JOIN ufngetteamsresultsforpost(17) s17(teamid, moment, helpused, score) ON ((t.team = s17.teamid))) LEFT JOIN ufngetteamsresultsforpost(18) s18(teamid, moment, helpused, score) ON ((t.team = s18.teamid))) LEFT JOIN ufngetteamsresultsforpost(19) s19(teamid, moment, helpused, score) ON ((t.team = s19.teamid))) LEFT JOIN ufngetteamsresultsforpost(20) s20(teamid, moment, helpused, score) ON ((t.team = s20.teamid))) LEFT JOIN ufngetteamsresultsforpost(21) s21(teamid, moment, helpused, score) ON ((t.team = s21.teamid))) LEFT JOIN ufngetteamsresultsforpost(22) s22(teamid, moment, helpused, score) ON ((t.team = s22.teamid))) LEFT JOIN ufngetteamsresultsforpost(23) s23(teamid, moment, helpused, score) ON ((t.team = s23.teamid))) LEFT JOIN ufngetteamsresultsforpost(24) s24(teamid, moment, helpused, score) ON ((t.team = s24.teamid))) LEFT JOIN ufngetteamsresultsforpost(25) s25(teamid, moment, helpused, score) ON ((t.team = s25.teamid))) LEFT JOIN ufngetteamsresultsforpost(26) s26(teamid, moment, helpused, score) ON ((t.team = s26.teamid))) LEFT JOIN ufngetteamsresultsforpost(27) s27(teamid, moment, helpused, score) ON ((t.team = s27.teamid))) LEFT JOIN ufngetteamsresultsforpostbonus(28) s28(teamid, moment, helpused, score) ON ((t.team = s28.teamid))) LEFT JOIN ufngetteamsresultsforpostbonus(29) s29(teamid, moment, helpused, score) ON ((t.team = s29.teamid))) LEFT JOIN ufngetteamsresultsforpostbonus(30) s30(teamid, moment, helpused, score) ON ((t.team = s30.teamid))) LEFT JOIN ufngetteamsresultsforpostbonus(31) s31(teamid, moment, helpused, score) ON ((t.team = s31.teamid))) WHERE (t.team_type = 'COM'::bpchar) ORDER BY t.team;


ALTER TABLE public.results OWNER TO brazda;

--
-- Name: team_types; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE team_types (
    team_type character(3) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.team_types OWNER TO brazda;

--
-- Name: teams_team_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE teams_team_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_seq OWNER TO brazda;

--
-- Name: teams_team_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE teams_team_seq OWNED BY teams.team;


--
-- Name: waypoint_types; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE waypoint_types (
    waypoint_type character(3) NOT NULL,
    rank integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.waypoint_types OWNER TO brazda;

--
-- Name: waypoint_types_rank_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE waypoint_types_rank_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waypoint_types_rank_seq OWNER TO brazda;

--
-- Name: waypoint_types_rank_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE waypoint_types_rank_seq OWNED BY waypoint_types.rank;


--
-- Name: waypoint_visibilities; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE waypoint_visibilities (
    waypoint_visibility character(2) NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.waypoint_visibilities OWNER TO brazda;

--
-- Name: waypoints; Type: TABLE; Schema: public; Owner: brazda; Tablespace: 
--

CREATE TABLE waypoints (
    waypoint integer NOT NULL,
    waypoint_type character(3) NOT NULL,
    waypoint_visibility character(2) DEFAULT 'VI'::bpchar NOT NULL,
    post integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE public.waypoints OWNER TO brazda;

--
-- Name: waypoints_waypoint_seq; Type: SEQUENCE; Schema: public; Owner: brazda
--

CREATE SEQUENCE waypoints_waypoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waypoints_waypoint_seq OWNER TO brazda;

--
-- Name: waypoints_waypoint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brazda
--

ALTER SEQUENCE waypoints_waypoint_seq OWNED BY waypoints.waypoint;


--
-- Name: audit_log; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY audit_logs ALTER COLUMN audit_log SET DEFAULT nextval('audit_logs_audit_log_seq'::regclass);


--
-- Name: log; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY logs ALTER COLUMN log SET DEFAULT nextval('logs_log_seq'::regclass);


--
-- Name: player; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY players ALTER COLUMN player SET DEFAULT nextval('players_player_seq'::regclass);


--
-- Name: post_note; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY post_notes ALTER COLUMN post_note SET DEFAULT nextval('post_notes_post_note_seq'::regclass);


--
-- Name: post; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY posts ALTER COLUMN post SET DEFAULT nextval('posts_post_seq'::regclass);


--
-- Name: team; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY teams ALTER COLUMN team SET DEFAULT nextval('teams_team_seq'::regclass);


--
-- Name: rank; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY waypoint_types ALTER COLUMN rank SET DEFAULT nextval('waypoint_types_rank_seq'::regclass);


--
-- Name: waypoint; Type: DEFAULT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY waypoints ALTER COLUMN waypoint SET DEFAULT nextval('waypoints_waypoint_seq'::regclass);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: brazda
--



--
-- Name: audit_logs_audit_log_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('audit_logs_audit_log_seq', 1, false);


--
-- Data for Name: cache_types; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO cache_types VALUES ('TRA', 'Tradiční keš');
INSERT INTO cache_types VALUES ('MLT', 'Multi keš');
INSERT INTO cache_types VALUES ('MYS', 'Mystery keš');
INSERT INTO cache_types VALUES ('ERT', 'Earth keš');
INSERT INTO cache_types VALUES ('WIG', 'Where I Go keš');


--
-- Data for Name: log_types; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO log_types VALUES ('STR', 'Start');
INSERT INTO log_types VALUES ('FIN', 'Cíl');
INSERT INTO log_types VALUES ('OUT', 'Splněno');
INSERT INTO log_types VALUES ('BON', 'Bonus');
INSERT INTO log_types VALUES ('ERR', 'Chyba');
INSERT INTO log_types VALUES ('HLP', 'Nápověda');


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO logs VALUES (1, 'STR', 8, 1, '2016-10-01 08:43:36.681454');
INSERT INTO logs VALUES (2, 'STR', 7, 1, '2016-10-01 08:43:39.335925');
INSERT INTO logs VALUES (3, 'STR', 13, 1, '2016-10-01 08:43:59.933764');
INSERT INTO logs VALUES (4, 'STR', 12, 1, '2016-10-01 08:44:24.199823');
INSERT INTO logs VALUES (6, 'STR', 4, 1, '2016-10-01 08:44:34.794859');
INSERT INTO logs VALUES (7, 'STR', 10, 1, '2016-10-01 08:44:52.163731');
INSERT INTO logs VALUES (9, 'STR', 11, 1, '2016-10-01 08:44:58.741479');
INSERT INTO logs VALUES (10, 'STR', 5, 1, '2016-10-01 08:45:13.326566');
INSERT INTO logs VALUES (11, 'STR', 6, 1, '2016-10-01 08:45:17.186295');
INSERT INTO logs VALUES (12, 'STR', 3, 1, '2016-10-01 08:46:00.073644');
INSERT INTO logs VALUES (13, 'STR', 9, 1, '2016-10-01 08:46:13.491135');
INSERT INTO logs VALUES (16, 'STR', 2, 1, '2016-10-01 08:47:27.101209');
INSERT INTO logs VALUES (18, 'OUT', 13, 26, '2016-10-01 08:56:28.006185');
INSERT INTO logs VALUES (19, 'OUT', 6, 26, '2016-10-01 09:01:00.483127');
INSERT INTO logs VALUES (20, 'OUT', 10, 26, '2016-10-01 09:01:23.587888');
INSERT INTO logs VALUES (21, 'OUT', 13, 21, '2016-10-01 09:01:44.858955');
INSERT INTO logs VALUES (22, 'ERR', 6, 28, '2016-10-01 09:07:37.204438');
INSERT INTO logs VALUES (23, 'ERR', 6, 28, '2016-10-01 09:07:53.153766');
INSERT INTO logs VALUES (24, 'OUT', 13, 7, '2016-10-01 09:08:12.848475');
INSERT INTO logs VALUES (25, 'ERR', 4, 14, '2016-10-01 09:12:05.535099');
INSERT INTO logs VALUES (26, 'ERR', 4, 14, '2016-10-01 09:12:47.398212');
INSERT INTO logs VALUES (27, 'OUT', 6, 21, '2016-10-01 09:14:30.751341');
INSERT INTO logs VALUES (28, 'OUT', 2, 8, '2016-10-01 09:14:31.368105');
INSERT INTO logs VALUES (29, 'OUT', 8, 18, '2016-10-01 09:15:02.797472');
INSERT INTO logs VALUES (30, 'OUT', 6, 7, '2016-10-01 09:22:54.537792');
INSERT INTO logs VALUES (31, 'OUT', 2, 21, '2016-10-01 09:26:33.568196');
INSERT INTO logs VALUES (32, 'OUT', 5, 8, '2016-10-01 09:26:50.562245');
INSERT INTO logs VALUES (33, 'OUT', 6, 30, '2016-10-01 09:27:27.433103');
INSERT INTO logs VALUES (34, 'OUT', 4, 14, '2016-10-01 09:28:25.5254');
INSERT INTO logs VALUES (35, 'STR', 1, 1, '2016-10-01 09:28:26.221044');
INSERT INTO logs VALUES (36, 'OUT', 13, 2, '2016-10-01 09:28:32.112209');
INSERT INTO logs VALUES (37, 'OUT', 1, 6, '2016-10-01 09:28:40.613647');
INSERT INTO logs VALUES (38, 'OUT', 3, 12, '2016-10-01 09:30:25.371287');
INSERT INTO logs VALUES (39, 'OUT', 2, 7, '2016-10-01 09:31:39.960999');
INSERT INTO logs VALUES (40, 'OUT', 2, 26, '2016-10-01 09:33:10.309322');
INSERT INTO logs VALUES (41, 'OUT', 9, 3, '2016-10-01 09:34:23.706877');
INSERT INTO logs VALUES (42, 'ERR', 3, 3, '2016-10-01 09:37:20.339934');
INSERT INTO logs VALUES (43, 'OUT', 3, 3, '2016-10-01 09:37:39.961337');
INSERT INTO logs VALUES (44, 'OUT', 10, 8, '2016-10-01 09:39:20.572582');
INSERT INTO logs VALUES (45, 'OUT', 5, 26, '2016-10-01 09:39:26.682112');
INSERT INTO logs VALUES (46, 'OUT', 8, 5, '2016-10-01 09:40:35.950756');
INSERT INTO logs VALUES (47, 'ERR', 6, 28, '2016-10-01 09:41:50.482397');
INSERT INTO logs VALUES (48, 'OUT', 4, 12, '2016-10-01 09:42:44.036664');
INSERT INTO logs VALUES (49, 'ERR', 13, 31, '2016-10-01 09:43:02.525683');
INSERT INTO logs VALUES (50, 'OUT', 5, 21, '2016-10-01 09:46:31.69659');
INSERT INTO logs VALUES (51, 'ERR', 3, 13, '2016-10-01 09:47:35.305078');
INSERT INTO logs VALUES (52, 'ERR', 6, 28, '2016-10-01 09:47:52.557312');
INSERT INTO logs VALUES (53, 'OUT', 5, 7, '2016-10-01 09:54:34.894566');
INSERT INTO logs VALUES (54, 'OUT', 2, 25, '2016-10-01 09:55:44.695111');
INSERT INTO logs VALUES (55, 'BON', 6, 30, '2016-10-01 09:55:44.914459');
INSERT INTO logs VALUES (56, 'OUT', 12, 17, '2016-10-01 09:56:48.473965');
INSERT INTO logs VALUES (58, 'ERR', 3, 13, '2016-10-01 09:57:28.50104');
INSERT INTO logs VALUES (59, 'OUT', 4, 3, '2016-10-01 09:58:56.578317');
INSERT INTO logs VALUES (60, 'OUT', 2, 24, '2016-10-01 10:00:45.372705');
INSERT INTO logs VALUES (61, 'OUT', 13, 27, '2016-10-01 10:03:56.807294');
INSERT INTO logs VALUES (62, 'OUT', 2, 23, '2016-10-01 10:04:39.163152');
INSERT INTO logs VALUES (63, 'ERR', 2, 28, '2016-10-01 10:05:48.90331');
INSERT INTO logs VALUES (64, 'OUT', 2, 28, '2016-10-01 10:06:07.240005');
INSERT INTO logs VALUES (65, 'ERR', 3, 13, '2016-10-01 10:06:21.181261');
INSERT INTO logs VALUES (66, 'OUT', 9, 16, '2016-10-01 10:12:41.115968');
INSERT INTO logs VALUES (67, 'OUT', 3, 16, '2016-10-01 10:13:55.410481');
INSERT INTO logs VALUES (68, 'OUT', 7, 18, '2016-10-01 10:14:57.789553');
INSERT INTO logs VALUES (69, 'ERR', 12, 21, '2016-10-01 10:17:56.157127');
INSERT INTO logs VALUES (70, 'OUT', 12, 26, '2016-10-01 10:18:24.421196');
INSERT INTO logs VALUES (71, 'ERR', 11, 14, '2016-10-01 10:18:47.863688');
INSERT INTO logs VALUES (72, 'ERR', 3, 13, '2016-10-01 10:20:50.630424');
INSERT INTO logs VALUES (73, 'OUT', 10, 2, '2016-10-01 10:21:26.676554');
INSERT INTO logs VALUES (74, 'OUT', 2, 22, '2016-10-01 10:24:06.289643');
INSERT INTO logs VALUES (75, 'OUT', 2, 30, '2016-10-01 10:24:34.882922');
INSERT INTO logs VALUES (76, 'ERR', 11, 14, '2016-10-01 10:30:46.834575');
INSERT INTO logs VALUES (77, 'OUT', 12, 21, '2016-10-01 10:32:51.422112');
INSERT INTO logs VALUES (78, 'OUT', 5, 2, '2016-10-01 10:33:29.203186');
INSERT INTO logs VALUES (79, 'OUT', 2, 11, '2016-10-01 10:33:40.705807');
INSERT INTO logs VALUES (80, 'ERR', 11, 14, '2016-10-01 10:34:03.313121');
INSERT INTO logs VALUES (81, 'HLP', 11, 14, '2016-10-01 10:34:16.313912');
INSERT INTO logs VALUES (82, 'OUT', 7, 12, '2016-10-01 10:34:31.845425');
INSERT INTO logs VALUES (83, 'ERR', 10, 31, '2016-10-01 10:34:58.186648');
INSERT INTO logs VALUES (84, 'ERR', 10, 7, '2016-10-01 10:39:31.306362');
INSERT INTO logs VALUES (85, 'OUT', 10, 7, '2016-10-01 10:40:08.987786');
INSERT INTO logs VALUES (86, 'OUT', 4, 16, '2016-10-01 10:41:01.834039');
INSERT INTO logs VALUES (87, 'ERR', 1, 7, '2016-10-01 10:41:44.110383');
INSERT INTO logs VALUES (88, 'OUT', 1, 7, '2016-10-01 10:41:56.883253');
INSERT INTO logs VALUES (90, 'OUT', 10, 21, '2016-10-01 10:44:14.200758');
INSERT INTO logs VALUES (91, 'ERR', 8, 6, '2016-10-01 10:44:43.231321');
INSERT INTO logs VALUES (92, 'OUT', 8, 6, '2016-10-01 10:44:58.318293');
INSERT INTO logs VALUES (93, 'ERR', 12, 7, '2016-10-01 10:45:15.891259');
INSERT INTO logs VALUES (94, 'OUT', 12, 7, '2016-10-01 10:45:53.650075');
INSERT INTO logs VALUES (95, 'ERR', 4, 13, '2016-10-01 10:49:29.360286');
INSERT INTO logs VALUES (96, 'ERR', 4, 13, '2016-10-01 10:53:58.123778');
INSERT INTO logs VALUES (97, 'OUT', 9, 5, '2016-10-01 10:56:55.163161');
INSERT INTO logs VALUES (98, 'ERR', 4, 13, '2016-10-01 10:57:40.417994');
INSERT INTO logs VALUES (99, 'OUT', 13, 22, '2016-10-01 11:00:35.642386');
INSERT INTO logs VALUES (100, 'OUT', 11, 12, '2016-10-01 11:01:33.860731');
INSERT INTO logs VALUES (101, 'OUT', 13, 30, '2016-10-01 11:01:42.917314');
INSERT INTO logs VALUES (102, 'ERR', 13, 30, '2016-10-01 11:04:11.006784');
INSERT INTO logs VALUES (103, 'OUT', 7, 5, '2016-10-01 11:04:21.882556');
INSERT INTO logs VALUES (104, 'ERR', 13, 30, '2016-10-01 11:04:30.648834');
INSERT INTO logs VALUES (105, 'ERR', 2, 27, '2016-10-01 11:05:12.610004');
INSERT INTO logs VALUES (106, 'OUT', 2, 27, '2016-10-01 11:05:56.982109');
INSERT INTO logs VALUES (107, 'ERR', 11, 14, '2016-10-01 11:06:22.433541');
INSERT INTO logs VALUES (108, 'ERR', 2, 31, '2016-10-01 11:06:56.240031');
INSERT INTO logs VALUES (109, 'OUT', 3, 13, '2016-10-01 09:47:35');
INSERT INTO logs VALUES (110, 'OUT', 2, 31, '2016-10-01 11:07:55.836958');
INSERT INTO logs VALUES (111, 'OUT', 13, 23, '2016-10-01 11:11:10.171426');
INSERT INTO logs VALUES (112, 'OUT', 12, 2, '2016-10-01 11:16:45.440113');
INSERT INTO logs VALUES (113, 'OUT', 5, 27, '2016-10-01 11:17:52.664909');
INSERT INTO logs VALUES (114, 'OUT', 7, 9, '2016-10-01 11:22:24.743672');
INSERT INTO logs VALUES (115, 'OUT', 6, 19, '2016-10-01 11:22:48.734418');
INSERT INTO logs VALUES (116, 'OUT', 13, 11, '2016-10-01 11:24:32.448443');
INSERT INTO logs VALUES (117, 'OUT', 7, 29, '2016-10-01 11:25:03.152403');
INSERT INTO logs VALUES (118, 'OUT', 8, 15, '2016-10-01 11:25:05.152094');
INSERT INTO logs VALUES (119, 'ERR', 13, 30, '2016-10-01 11:25:06.290017');
INSERT INTO logs VALUES (120, 'OUT', 2, 2, '2016-10-01 11:28:54.404887');
INSERT INTO logs VALUES (121, 'OUT', 3, 4, '2016-10-01 11:31:48.690092');
INSERT INTO logs VALUES (122, 'ERR', 12, 28, '2016-10-01 11:32:30.431072');
INSERT INTO logs VALUES (123, 'ERR', 12, 28, '2016-10-01 11:33:01.536418');
INSERT INTO logs VALUES (124, 'ERR', 12, 31, '2016-10-01 11:34:29.303247');
INSERT INTO logs VALUES (125, 'OUT', 13, 24, '2016-10-01 11:34:33.597741');
INSERT INTO logs VALUES (126, 'ERR', 13, 28, '2016-10-01 11:35:09.985384');
INSERT INTO logs VALUES (127, 'ERR', 13, 28, '2016-10-01 11:35:25.073631');
INSERT INTO logs VALUES (128, 'ERR', 2, 29, '2016-10-01 11:36:00.146426');
INSERT INTO logs VALUES (129, 'ERR', 2, 29, '2016-10-01 11:36:09.571214');
INSERT INTO logs VALUES (130, 'ERR', 10, 21, '2016-10-01 11:39:01.465901');
INSERT INTO logs VALUES (131, 'ERR', 4, 6, '2016-10-01 11:39:49.556734');
INSERT INTO logs VALUES (132, 'OUT', 4, 6, '2016-10-01 11:40:10.641857');
INSERT INTO logs VALUES (133, 'OUT', 13, 25, '2016-10-01 11:43:29.520682');
INSERT INTO logs VALUES (134, 'OUT', 13, 28, '2016-10-01 11:43:44.669301');
INSERT INTO logs VALUES (135, 'OUT', 3, 29, '2016-10-01 11:44:10.18672');
INSERT INTO logs VALUES (136, 'OUT', 3, 31, '2016-10-01 11:46:12.302905');
INSERT INTO logs VALUES (137, 'OUT', 5, 31, '2016-10-01 11:48:05.99581');
INSERT INTO logs VALUES (138, 'ERR', 5, 28, '2016-10-01 11:52:17.793244');
INSERT INTO logs VALUES (139, 'OUT', 6, 20, '2016-10-01 11:56:17.434066');
INSERT INTO logs VALUES (140, 'ERR', 2, 29, '2016-10-01 11:58:00.053052');
INSERT INTO logs VALUES (141, 'ERR', 5, 28, '2016-10-01 11:58:28.47671');
INSERT INTO logs VALUES (142, 'ERR', 3, 30, '2016-10-01 12:02:19.797826');
INSERT INTO logs VALUES (143, 'ERR', 2, 29, '2016-10-01 12:03:49.646465');
INSERT INTO logs VALUES (144, 'ERR', 5, 28, '2016-10-01 12:06:07.639724');
INSERT INTO logs VALUES (145, 'OUT', 1, 29, '2016-10-01 12:09:07.115809');
INSERT INTO logs VALUES (146, 'OUT', 12, 20, '2016-10-01 12:09:40.848838');
INSERT INTO logs VALUES (147, 'ERR', 5, 28, '2016-10-01 12:12:01.930716');
INSERT INTO logs VALUES (148, 'OUT', 2, 20, '2016-10-01 12:12:18.510895');
INSERT INTO logs VALUES (149, 'OUT', 3, 5, '2016-10-01 12:12:25.769923');
INSERT INTO logs VALUES (150, 'ERR', 2, 29, '2016-10-01 12:12:50.86635');
INSERT INTO logs VALUES (151, 'OUT', 5, 22, '2016-10-01 12:14:22.430985');
INSERT INTO logs VALUES (152, 'OUT', 4, 15, '2016-10-01 12:14:48.493511');
INSERT INTO logs VALUES (153, 'OUT', 7, 28, '2016-10-01 12:15:39.510191');
INSERT INTO logs VALUES (154, 'HLP', 1, 14, '2016-10-01 12:16:23.914415');
INSERT INTO logs VALUES (155, 'ERR', 7, 31, '2016-10-01 12:16:50.362144');
INSERT INTO logs VALUES (156, 'ERR', 2, 29, '2016-10-01 12:17:18.376605');
INSERT INTO logs VALUES (157, 'OUT', 10, 19, '2016-10-01 12:22:38.625191');
INSERT INTO logs VALUES (158, 'ERR', 12, 28, '2016-10-01 12:24:10.141834');
INSERT INTO logs VALUES (159, 'ERR', 12, 30, '2016-10-01 12:24:38.109042');
INSERT INTO logs VALUES (160, 'ERR', 12, 30, '2016-10-01 12:24:47.667394');
INSERT INTO logs VALUES (161, 'OUT', 7, 6, '2016-10-01 12:29:48.75892');
INSERT INTO logs VALUES (162, 'BON', 3, 29, '2016-10-01 12:30:09.105922');
INSERT INTO logs VALUES (163, 'OUT', 10, 31, '2016-10-01 12:30:11.822366');
INSERT INTO logs VALUES (164, 'HLP', 11, 10, '2016-10-01 12:32:07.793497');
INSERT INTO logs VALUES (165, 'OUT', 8, 4, '2016-10-01 12:34:59.990684');
INSERT INTO logs VALUES (166, 'OUT', 11, 10, '2016-10-01 12:38:40.279216');
INSERT INTO logs VALUES (167, 'ERR', 5, 28, '2016-10-01 12:39:21.278086');
INSERT INTO logs VALUES (168, 'HLP', 11, 13, '2016-10-01 12:39:32.360443');
INSERT INTO logs VALUES (169, 'OUT', 6, 2, '2016-10-01 12:54:09.221916');
INSERT INTO logs VALUES (170, 'ERR', 6, 31, '2016-10-01 12:54:42.168082');
INSERT INTO logs VALUES (171, 'ERR', 6, 31, '2016-10-01 12:54:51.469245');
INSERT INTO logs VALUES (172, 'ERR', 3, 9, '2016-10-01 12:58:16.774613');
INSERT INTO logs VALUES (173, 'OUT', 6, 31, '2016-10-01 12:58:29.694328');
INSERT INTO logs VALUES (174, 'OUT', 3, 9, '2016-10-01 12:59:01.681069');
INSERT INTO logs VALUES (175, 'OUT', 2, 19, '2016-10-01 12:59:51.453409');
INSERT INTO logs VALUES (176, 'OUT', 5, 23, '2016-10-01 13:01:08.570704');
INSERT INTO logs VALUES (177, 'OUT', 9, 4, '2016-10-01 13:02:35.164866');
INSERT INTO logs VALUES (178, 'ERR', 13, 31, '2016-10-01 13:03:25.281975');
INSERT INTO logs VALUES (179, 'HLP', 5, 11, '2016-10-01 13:05:07.630958');
INSERT INTO logs VALUES (180, 'ERR', 5, 11, '2016-10-01 13:05:26.065527');
INSERT INTO logs VALUES (181, 'OUT', 11, 14, '2016-10-01 13:05:45.701348');
INSERT INTO logs VALUES (182, 'OUT', 5, 30, '2016-10-01 13:07:56.23341');
INSERT INTO logs VALUES (183, 'ERR', 10, 14, '2016-10-01 13:09:43.030338');
INSERT INTO logs VALUES (184, 'ERR', 10, 14, '2016-10-01 13:09:54.27747');
INSERT INTO logs VALUES (185, 'OUT', 3, 18, '2016-10-01 13:10:36.257054');
INSERT INTO logs VALUES (186, 'ERR', 5, 28, '2016-10-01 13:12:45.188914');
INSERT INTO logs VALUES (187, 'ERR', 10, 14, '2016-10-01 13:13:24.244879');
INSERT INTO logs VALUES (188, 'OUT', 5, 24, '2016-10-01 13:13:33.660345');
INSERT INTO logs VALUES (189, 'OUT', 7, 15, '2016-10-01 13:14:16.27048');
INSERT INTO logs VALUES (190, 'ERR', 7, 30, '2016-10-01 13:15:17.900258');
INSERT INTO logs VALUES (191, 'ERR', 7, 31, '2016-10-01 13:15:59.18847');
INSERT INTO logs VALUES (192, 'ERR', 8, 31, '2016-10-01 13:16:34.505719');
INSERT INTO logs VALUES (193, 'BON', 6, 31, '2016-10-01 13:19:57.888383');
INSERT INTO logs VALUES (194, 'OUT', 5, 28, '2016-10-01 13:21:09.44173');
INSERT INTO logs VALUES (195, 'OUT', 4, 4, '2016-10-01 13:22:16.889298');
INSERT INTO logs VALUES (196, 'BON', 2, 30, '2016-10-01 13:22:31.04655');
INSERT INTO logs VALUES (197, 'OUT', 12, 8, '2016-10-01 13:26:41.821063');
INSERT INTO logs VALUES (198, 'ERR', 12, 31, '2016-10-01 13:27:45.323336');
INSERT INTO logs VALUES (199, 'OUT', 5, 25, '2016-10-01 13:32:16.691886');
INSERT INTO logs VALUES (200, 'ERR', 12, 31, '2016-10-01 13:32:47.088379');
INSERT INTO logs VALUES (201, 'OUT', 3, 10, '2016-10-01 13:34:06.515806');
INSERT INTO logs VALUES (202, 'OUT', 12, 31, '2016-10-01 13:35:58.230712');
INSERT INTO logs VALUES (203, 'ERR', 4, 31, '2016-10-01 13:38:16.405722');
INSERT INTO logs VALUES (204, 'ERR', 4, 31, '2016-10-01 13:39:15.92537');
INSERT INTO logs VALUES (205, 'ERR', 6, 27, '2016-10-01 13:40:47.234397');
INSERT INTO logs VALUES (206, 'ERR', 13, 31, '2016-10-01 13:41:22.523187');
INSERT INTO logs VALUES (207, 'ERR', 6, 27, '2016-10-01 13:41:22.782523');
INSERT INTO logs VALUES (208, 'ERR', 12, 28, '2016-10-01 13:42:55.260614');
INSERT INTO logs VALUES (209, 'OUT', 8, 3, '2016-10-01 13:43:44.097545');
INSERT INTO logs VALUES (216, 'OUT', 11, 18, '2016-10-01 13:45:28.501254');
INSERT INTO logs VALUES (217, 'ERR', 13, 31, '2016-10-01 13:45:33.443809');
INSERT INTO logs VALUES (218, 'OUT', 4, 13, '2016-10-01 10:49:29');
INSERT INTO logs VALUES (219, 'OUT', 12, 28, '2016-10-01 13:52:02.462739');
INSERT INTO logs VALUES (220, 'OUT', 6, 27, '2016-10-01 13:53:41.407232');
INSERT INTO logs VALUES (221, 'ERR', 5, 11, '2016-10-01 13:54:22.996005');
INSERT INTO logs VALUES (222, 'ERR', 6, 28, '2016-10-01 13:55:47.15616');
INSERT INTO logs VALUES (223, 'OUT', 10, 3, '2016-10-01 13:57:22.204136');
INSERT INTO logs VALUES (224, 'OUT', 4, 5, '2016-10-01 14:02:03.507646');
INSERT INTO logs VALUES (225, 'ERR', 4, 31, '2016-10-01 14:02:31.055158');
INSERT INTO logs VALUES (226, 'BON', 13, 30, '2016-10-01 14:02:38.70422');
INSERT INTO logs VALUES (227, 'OUT', 2, 17, '2016-10-01 14:02:42.294088');
INSERT INTO logs VALUES (228, 'ERR', 3, 14, '2016-10-01 14:09:55.09318');
INSERT INTO logs VALUES (229, 'ERR', 3, 14, '2016-10-01 14:10:26.622383');
INSERT INTO logs VALUES (230, 'HLP', 7, 14, '2016-10-01 14:12:48.392772');
INSERT INTO logs VALUES (231, 'ERR', 3, 14, '2016-10-01 14:14:06.504913');
INSERT INTO logs VALUES (232, 'OUT', 2, 12, '2016-10-01 14:15:25.377549');
INSERT INTO logs VALUES (233, 'OUT', 2, 29, '2016-10-01 14:15:41.881185');
INSERT INTO logs VALUES (234, 'ERR', 3, 14, '2016-10-01 14:18:04.486324');
INSERT INTO logs VALUES (235, 'OUT', 11, 26, '2016-10-01 14:18:34.980804');
INSERT INTO logs VALUES (236, 'ERR', 3, 14, '2016-10-01 14:22:45.726219');
INSERT INTO logs VALUES (237, 'ERR', 8, 14, '2016-10-01 14:27:51.310545');
INSERT INTO logs VALUES (238, 'ERR', 8, 14, '2016-10-01 14:28:07.732344');
INSERT INTO logs VALUES (239, 'ERR', 13, 31, '2016-10-01 14:28:19.815313');
INSERT INTO logs VALUES (240, 'BON', 5, 31, '2016-10-01 14:28:36.686572');
INSERT INTO logs VALUES (241, 'OUT', 7, 16, '2016-10-01 14:33:37.807542');
INSERT INTO logs VALUES (242, 'OUT', 10, 16, '2016-10-01 14:34:00.968348');
INSERT INTO logs VALUES (243, 'HLP', 12, 14, '2016-10-01 14:36:58.59714');
INSERT INTO logs VALUES (244, 'HLP', 12, 14, '2016-10-01 14:37:22.963489');
INSERT INTO logs VALUES (245, 'OUT', 3, 17, '2016-10-01 14:38:27.609249');
INSERT INTO logs VALUES (246, 'OUT', 10, 12, '2016-10-01 14:39:15.442912');
INSERT INTO logs VALUES (247, 'ERR', 3, 28, '2016-10-01 14:40:13.631186');
INSERT INTO logs VALUES (248, 'ERR', 12, 14, '2016-10-01 14:40:18.248684');
INSERT INTO logs VALUES (249, 'HLP', 12, 14, '2016-10-01 14:41:21.527848');
INSERT INTO logs VALUES (250, 'ERR', 12, 14, '2016-10-01 14:41:22.272319');
INSERT INTO logs VALUES (251, 'OUT', 6, 22, '2016-10-01 14:43:23.704903');
INSERT INTO logs VALUES (252, 'OUT', 2, 14, '2016-10-01 14:43:50.604342');
INSERT INTO logs VALUES (253, 'HLP', 8, 14, '2016-10-01 14:44:02.453997');
INSERT INTO logs VALUES (254, 'ERR', 8, 14, '2016-10-01 14:46:01.527429');
INSERT INTO logs VALUES (255, 'ERR', 10, 14, '2016-10-01 14:46:18.901076');
INSERT INTO logs VALUES (256, 'ERR', 3, 28, '2016-10-01 14:47:41.790962');
INSERT INTO logs VALUES (257, 'ERR', 12, 14, '2016-10-01 14:48:47.95054');
INSERT INTO logs VALUES (258, 'OUT', 11, 8, '2016-10-01 14:49:11.643446');
INSERT INTO logs VALUES (259, 'ERR', 3, 28, '2016-10-01 14:51:06.308215');
INSERT INTO logs VALUES (260, 'OUT', 13, 17, '2016-10-01 14:51:42.70005');
INSERT INTO logs VALUES (261, 'OUT', 3, 26, '2016-10-01 14:52:18.384593');
INSERT INTO logs VALUES (262, 'OUT', 4, 18, '2016-10-01 14:54:00.461369');
INSERT INTO logs VALUES (263, 'OUT', 7, 3, '2016-10-01 14:54:53.964529');
INSERT INTO logs VALUES (264, 'OUT', 3, 28, '2016-10-01 14:55:34.48001');
INSERT INTO logs VALUES (265, 'ERR', 7, 31, '2016-10-01 14:56:18.351145');
INSERT INTO logs VALUES (267, 'ERR', 12, 14, '2016-10-01 14:58:45.101926');
INSERT INTO logs VALUES (268, 'ERR', 7, 31, '2016-10-01 14:59:41.712938');
INSERT INTO logs VALUES (269, 'OUT', 9, 6, '2016-10-01 15:00:02.502156');
INSERT INTO logs VALUES (270, 'ERR', 7, 31, '2016-10-01 15:03:11.837536');
INSERT INTO logs VALUES (271, 'HLP', 7, 10, '2016-10-01 15:03:31.364113');
INSERT INTO logs VALUES (272, 'ERR', 2, 10, '2016-10-01 15:04:24.53623');
INSERT INTO logs VALUES (273, 'OUT', 2, 13, '2016-10-01 15:04:54.037212');
INSERT INTO logs VALUES (274, 'ERR', 9, 31, '2016-10-01 15:06:44.056217');
INSERT INTO logs VALUES (275, 'OUT', 6, 11, '2016-10-01 15:07:24.773194');
INSERT INTO logs VALUES (276, 'HLP', 4, 10, '2016-10-01 15:08:40.672201');
INSERT INTO logs VALUES (277, 'ERR', 6, 29, '2016-10-01 15:08:40.744456');
INSERT INTO logs VALUES (278, 'OUT', 8, 26, '2016-10-01 15:08:48.464124');
INSERT INTO logs VALUES (279, 'ERR', 6, 29, '2016-10-01 15:08:51.966469');
INSERT INTO logs VALUES (280, 'OUT', 11, 21, '2016-10-01 15:11:29.671497');
INSERT INTO logs VALUES (281, 'BON', 5, 30, '2016-10-01 15:11:39.659131');
INSERT INTO logs VALUES (282, 'ERR', 11, 13, '2016-10-01 15:14:03.658218');
INSERT INTO logs VALUES (283, 'OUT', 11, 13, '2016-10-01 15:14:16.814674');
INSERT INTO logs VALUES (284, 'OUT', 3, 8, '2016-10-01 15:14:25.893852');
INSERT INTO logs VALUES (285, 'OUT', 8, 7, '2016-10-01 15:16:28.619809');
INSERT INTO logs VALUES (286, 'HLP', 12, 13, '2016-10-01 15:16:54.886223');
INSERT INTO logs VALUES (287, 'OUT', 6, 23, '2016-10-01 15:17:04.137161');
INSERT INTO logs VALUES (288, 'OUT', 2, 3, '2016-10-01 15:17:06.310204');
INSERT INTO logs VALUES (289, 'OUT', 13, 12, '2016-10-01 15:21:14.199137');
INSERT INTO logs VALUES (290, 'BON', 2, 28, '2016-10-01 15:21:40.856704');
INSERT INTO logs VALUES (291, 'ERR', 13, 29, '2016-10-01 15:22:37.635177');
INSERT INTO logs VALUES (292, 'OUT', 13, 29, '2016-10-01 15:24:08.032894');
INSERT INTO logs VALUES (293, 'OUT', 4, 17, '2016-10-01 15:24:36.966411');
INSERT INTO logs VALUES (294, 'OUT', 3, 21, '2016-10-01 15:26:45.992723');
INSERT INTO logs VALUES (295, 'OUT', 11, 7, '2016-10-01 15:27:18.07929');
INSERT INTO logs VALUES (296, 'ERR', 10, 6, '2016-10-01 15:28:17.868658');
INSERT INTO logs VALUES (297, 'ERR', 10, 6, '2016-10-01 15:29:07.575811');
INSERT INTO logs VALUES (298, 'ERR', 3, 14, '2016-10-01 15:29:42.797456');
INSERT INTO logs VALUES (299, 'ERR', 12, 30, '2016-10-01 15:31:34.469899');
INSERT INTO logs VALUES (300, 'OUT', 6, 24, '2016-10-01 15:31:49.946388');
INSERT INTO logs VALUES (301, 'OUT', 6, 28, '2016-10-01 15:32:18.554075');
INSERT INTO logs VALUES (302, 'OUT', 10, 6, '2016-10-01 15:33:26.981591');
INSERT INTO logs VALUES (304, 'OUT', 4, 26, '2016-10-01 15:34:17.616275');
INSERT INTO logs VALUES (305, 'BON', 12, 28, '2016-10-01 15:34:56.146986');
INSERT INTO logs VALUES (306, 'OUT', 12, 30, '2016-10-01 15:36:08.883604');
INSERT INTO logs VALUES (307, 'OUT', 3, 7, '2016-10-01 15:37:21.901607');
INSERT INTO logs VALUES (308, 'OUT', 3, 30, '2016-10-01 15:37:57.262797');
INSERT INTO logs VALUES (309, 'OUT', 7, 13, '2016-10-01 15:38:45.89732');
INSERT INTO logs VALUES (310, 'ERR', 3, 14, '2016-10-01 15:39:15.769086');
INSERT INTO logs VALUES (311, 'OUT', 4, 21, '2016-10-01 15:42:16.162612');
INSERT INTO logs VALUES (312, 'ERR', 3, 14, '2016-10-01 15:44:04.212251');
INSERT INTO logs VALUES (313, 'OUT', 8, 2, '2016-10-01 15:46:57.741814');
INSERT INTO logs VALUES (314, 'OUT', 3, 14, '2016-10-01 15:47:38.505645');
INSERT INTO logs VALUES (315, 'OUT', 11, 29, '2016-10-01 15:47:40.855006');
INSERT INTO logs VALUES (316, 'ERR', 7, 31, '2016-10-01 15:48:32.844028');
INSERT INTO logs VALUES (317, 'OUT', 4, 7, '2016-10-01 15:49:23.59543');
INSERT INTO logs VALUES (318, 'OUT', 6, 25, '2016-10-01 15:50:10.770543');
INSERT INTO logs VALUES (319, 'OUT', 12, 3, '2016-10-01 15:50:18.0086');
INSERT INTO logs VALUES (320, 'OUT', 2, 16, '2016-10-01 15:50:39.747751');
INSERT INTO logs VALUES (321, 'ERR', 11, 31, '2016-10-01 15:52:14.332544');
INSERT INTO logs VALUES (322, 'ERR', 11, 31, '2016-10-01 15:52:57.395767');
INSERT INTO logs VALUES (323, 'ERR', 7, 31, '2016-10-01 15:53:49.945556');
INSERT INTO logs VALUES (324, 'ERR', 13, 14, '2016-10-01 15:56:16.989715');
INSERT INTO logs VALUES (325, 'HLP', 10, 14, '2016-10-01 15:56:32.211881');
INSERT INTO logs VALUES (326, 'ERR', 11, 31, '2016-10-01 15:57:05.875454');
INSERT INTO logs VALUES (327, 'OUT', 3, 2, '2016-10-01 16:01:35.872409');
INSERT INTO logs VALUES (328, 'OUT', 8, 21, '2016-10-01 16:02:16.899621');
INSERT INTO logs VALUES (329, 'HLP', 13, 14, '2016-10-01 16:06:43.526615');
INSERT INTO logs VALUES (330, 'OUT', 7, 17, '2016-10-01 16:14:33.348781');
INSERT INTO logs VALUES (331, 'OUT', 4, 2, '2016-10-01 16:16:09.317558');
INSERT INTO logs VALUES (332, 'ERR', 10, 14, '2016-10-01 16:23:04.569506');
INSERT INTO logs VALUES (333, 'ERR', 9, 15, '2016-10-01 16:23:37.646843');
INSERT INTO logs VALUES (334, 'OUT', 2, 4, '2016-10-01 16:23:55.587012');
INSERT INTO logs VALUES (335, 'BON', 3, 31, '2016-10-01 16:24:35.312603');
INSERT INTO logs VALUES (336, 'OUT', 11, 2, '2016-10-01 16:26:11.460768');
INSERT INTO logs VALUES (337, 'OUT', 9, 15, '2016-10-01 16:26:32.968946');
INSERT INTO logs VALUES (338, 'OUT', 11, 31, '2016-10-01 16:26:42.786356');
INSERT INTO logs VALUES (339, 'ERR', 10, 14, '2016-10-01 16:26:46.299968');
INSERT INTO logs VALUES (340, 'OUT', 8, 8, '2016-10-01 16:28:54.452903');
INSERT INTO logs VALUES (341, 'ERR', 10, 14, '2016-10-01 16:30:17.595989');
INSERT INTO logs VALUES (342, 'ERR', 13, 10, '2016-10-01 16:30:50.952089');
INSERT INTO logs VALUES (343, 'ERR', 13, 10, '2016-10-01 16:31:09.688737');
INSERT INTO logs VALUES (344, 'OUT', 13, 13, '2016-10-01 16:32:56.570272');
INSERT INTO logs VALUES (345, 'ERR', 10, 14, '2016-10-01 16:35:49.604847');
INSERT INTO logs VALUES (346, 'ERR', 7, 10, '2016-10-01 16:37:00.504529');
INSERT INTO logs VALUES (347, 'ERR', 3, 27, '2016-10-01 16:38:05.714042');
INSERT INTO logs VALUES (348, 'OUT', 8, 31, '2016-10-01 16:38:23.27636');
INSERT INTO logs VALUES (349, 'ERR', 3, 27, '2016-10-01 16:38:51.00699');
INSERT INTO logs VALUES (350, 'ERR', 7, 31, '2016-10-01 16:39:54.638054');
INSERT INTO logs VALUES (351, 'ERR', 10, 14, '2016-10-01 16:39:57.361956');
INSERT INTO logs VALUES (352, 'OUT', 8, 14, '2016-10-01 16:40:14.467608');
INSERT INTO logs VALUES (353, 'OUT', 12, 5, '2016-10-01 16:41:36.219856');
INSERT INTO logs VALUES (354, 'BON', 13, 28, '2016-10-01 16:42:36.633284');
INSERT INTO logs VALUES (355, 'ERR', 3, 27, '2016-10-01 16:43:02.08827');
INSERT INTO logs VALUES (356, 'OUT', 4, 27, '2016-10-01 16:45:04.522187');
INSERT INTO logs VALUES (357, 'ERR', 10, 14, '2016-10-01 16:46:50.842224');
INSERT INTO logs VALUES (358, 'OUT', 3, 27, '2016-10-01 16:48:19.155558');
INSERT INTO logs VALUES (359, 'ERR', 10, 10, '2016-10-01 16:52:14.45084');
INSERT INTO logs VALUES (360, 'OUT', 10, 13, '2016-10-01 16:52:44.248471');
INSERT INTO logs VALUES (361, 'OUT', 2, 5, '2016-10-01 16:53:33.938641');
INSERT INTO logs VALUES (362, 'OUT', 10, 30, '2016-10-01 16:55:04.36643');
INSERT INTO logs VALUES (363, 'OUT', 13, 3, '2016-10-01 16:57:17.145792');
INSERT INTO logs VALUES (364, 'OUT', 10, 29, '2016-10-01 16:59:05.106914');
INSERT INTO logs VALUES (365, 'OUT', 13, 31, '2016-10-01 17:02:09.931747');
INSERT INTO logs VALUES (366, 'OUT', 13, 31, '2016-10-01 17:02:11.793049');
INSERT INTO logs VALUES (367, 'BON', 10, 31, '2016-10-01 17:03:23.734042');
INSERT INTO logs VALUES (368, 'OUT', 6, 8, '2016-10-01 17:04:23.115914');
INSERT INTO logs VALUES (369, 'HLP', 5, 14, '2016-10-01 17:16:13.830506');
INSERT INTO logs VALUES (370, 'OUT', 7, 8, '2016-10-01 17:16:15.536271');
INSERT INTO logs VALUES (371, 'OUT', 7, 31, '2016-10-01 17:16:36.165366');
INSERT INTO logs VALUES (372, 'HLP', 10, 10, '2016-10-01 17:17:04.401185');
INSERT INTO logs VALUES (373, 'ERR', 10, 14, '2016-10-01 17:19:47.523183');
INSERT INTO logs VALUES (374, 'OUT', 7, 26, '2016-10-01 17:27:10.171352');
INSERT INTO logs VALUES (375, 'ERR', 7, 11, '2016-10-01 17:28:22.657035');
INSERT INTO logs VALUES (376, 'ERR', 10, 14, '2016-10-01 17:28:52.545608');
INSERT INTO logs VALUES (377, 'OUT', 8, 20, '2016-10-01 17:29:56.288683');
INSERT INTO logs VALUES (378, 'OUT', 7, 21, '2016-10-01 17:32:29.701945');
INSERT INTO logs VALUES (379, 'OUT', 8, 30, '2016-10-01 17:32:33.589029');
INSERT INTO logs VALUES (380, 'OUT', 3, 19, '2016-10-01 17:32:39.225754');
INSERT INTO logs VALUES (381, 'OUT', 2, 15, '2016-10-01 17:32:49.786781');
INSERT INTO logs VALUES (382, 'ERR', 10, 14, '2016-10-01 17:33:04.745216');
INSERT INTO logs VALUES (383, 'OUT', 4, 22, '2016-10-01 17:34:16.518087');
INSERT INTO logs VALUES (384, 'OUT', 4, 23, '2016-10-01 17:37:00.487318');
INSERT INTO logs VALUES (385, 'HLP', 4, 11, '2016-10-01 17:38:33.644104');
INSERT INTO logs VALUES (386, 'OUT', 7, 7, '2016-10-01 17:42:00.676565');
INSERT INTO logs VALUES (387, 'OUT', 7, 30, '2016-10-01 17:42:18.378993');
INSERT INTO logs VALUES (388, 'OUT', 4, 11, '2016-10-01 17:45:52.688816');
INSERT INTO logs VALUES (389, 'BON', 11, 31, '2016-10-01 17:45:59.550072');
INSERT INTO logs VALUES (390, 'OUT', 4, 24, '2016-10-01 17:47:24.6569');
INSERT INTO logs VALUES (391, 'HLP', 4, 9, '2016-10-01 17:48:25.282182');
INSERT INTO logs VALUES (392, 'OUT', 6, 17, '2016-10-01 17:49:50.463492');
INSERT INTO logs VALUES (393, 'BON', 5, 28, '2016-10-01 17:50:30.132014');
INSERT INTO logs VALUES (394, 'BON', 12, 30, '2016-10-01 17:53:16.459274');
INSERT INTO logs VALUES (395, 'ERR', 4, 28, '2016-10-01 17:53:40.165444');
INSERT INTO logs VALUES (396, 'ERR', 10, 14, '2016-10-01 17:54:43.723733');
INSERT INTO logs VALUES (397, 'ERR', 6, 29, '2016-10-01 17:54:45.99214');
INSERT INTO logs VALUES (398, 'BON', 3, 30, '2016-10-01 17:54:56.013062');
INSERT INTO logs VALUES (400, 'ERR', 10, 14, '2016-10-01 18:00:03.196574');
INSERT INTO logs VALUES (401, 'OUT', 5, 3, '2016-10-01 18:02:04.320649');
INSERT INTO logs VALUES (402, 'BON', 10, 29, '2016-10-01 18:05:06.071518');
INSERT INTO logs VALUES (403, 'OUT', 4, 25, '2016-10-01 18:06:20.928067');
INSERT INTO logs VALUES (404, 'BON', 11, 29, '2016-10-01 18:06:46.080195');
INSERT INTO logs VALUES (405, 'ERR', 10, 14, '2016-10-01 18:07:58.146297');
INSERT INTO logs VALUES (406, 'OUT', 7, 2, '2016-10-01 18:08:41.902968');
INSERT INTO logs VALUES (407, 'OUT', 10, 14, '2016-10-01 18:11:16.92293');
INSERT INTO logs VALUES (408, 'BON', 8, 31, '2016-10-01 18:12:18.579672');
INSERT INTO logs VALUES (409, 'OUT', 2, 6, '2016-10-01 18:13:18.704803');
INSERT INTO logs VALUES (410, 'ERR', 8, 28, '2016-10-01 18:13:40.524278');
INSERT INTO logs VALUES (411, 'OUT', 8, 27, '2016-10-01 18:14:34.539696');
INSERT INTO logs VALUES (412, 'ERR', 8, 28, '2016-10-01 18:15:15.272147');
INSERT INTO logs VALUES (413, 'OUT', 9, 7, '2016-10-01 18:15:33.272813');
INSERT INTO logs VALUES (415, 'BON', 13, 29, '2016-10-01 18:20:36.565542');
INSERT INTO logs VALUES (416, 'BON', 12, 31, '2016-10-01 18:22:16.930247');
INSERT INTO logs VALUES (417, 'OUT', 12, 13, '2016-10-01 18:23:26.785962');
INSERT INTO logs VALUES (418, 'OUT', 6, 12, '2016-10-01 18:25:07.506549');
INSERT INTO logs VALUES (419, 'ERR', 6, 31, '2016-10-01 18:25:34.463344');
INSERT INTO logs VALUES (420, 'BON', 6, 28, '2016-10-01 18:30:34.0826');
INSERT INTO logs VALUES (421, 'BON', 8, 30, '2016-10-01 18:32:41.709539');
INSERT INTO logs VALUES (422, 'ERR', 7, 14, '2016-10-01 18:33:22.197628');
INSERT INTO logs VALUES (423, 'ERR', 12, 14, '2016-10-01 18:37:10.570861');
INSERT INTO logs VALUES (424, 'ERR', 8, 28, '2016-10-01 18:39:34.678436');
INSERT INTO logs VALUES (425, 'OUT', 4, 31, '2016-10-01 18:40:00.755678');
INSERT INTO logs VALUES (426, 'ERR', 12, 14, '2016-10-01 18:40:17.683445');
INSERT INTO logs VALUES (427, 'STR', 11, 32, '2016-10-01 18:42:06.497467');
INSERT INTO logs VALUES (428, 'FIN', 11, 32, '2016-10-01 18:42:12.27619');
INSERT INTO logs VALUES (429, 'HLP', 8, 13, '2016-10-01 18:42:19.85497');
INSERT INTO logs VALUES (430, 'OUT', 4, 28, '2016-10-01 18:42:36.92183');
INSERT INTO logs VALUES (431, 'ERR', 12, 12, '2016-10-01 18:44:13.793501');
INSERT INTO logs VALUES (432, 'HLP', 8, 12, '2016-10-01 18:44:25.152351');
INSERT INTO logs VALUES (433, 'ERR', 8, 12, '2016-10-01 18:45:24.237682');
INSERT INTO logs VALUES (434, 'HLP', 10, 9, '2016-10-01 18:45:27.637474');
INSERT INTO logs VALUES (435, 'HLP', 12, 12, '2016-10-01 18:45:29.533955');
INSERT INTO logs VALUES (436, 'OUT', 3, 20, '2016-10-01 18:45:37.528371');
INSERT INTO logs VALUES (437, 'OUT', 6, 3, '2016-10-01 18:47:56.011357');
INSERT INTO logs VALUES (438, 'ERR', 12, 14, '2016-10-01 18:48:48.832448');
INSERT INTO logs VALUES (439, 'HLP', 5, 10, '2016-10-01 18:49:15.374779');
INSERT INTO logs VALUES (440, 'HLP', 5, 13, '2016-10-01 18:50:48.523249');
INSERT INTO logs VALUES (441, 'OUT', 4, 29, '2016-10-01 18:52:17.117639');
INSERT INTO logs VALUES (442, 'OUT', 4, 29, '2016-10-01 18:52:18.116773');
INSERT INTO logs VALUES (443, 'ERR', 12, 14, '2016-10-01 18:52:47.161585');
INSERT INTO logs VALUES (444, 'BON', 2, 29, '2016-10-01 18:53:00.059419');
INSERT INTO logs VALUES (445, 'ERR', 13, 9, '2016-10-01 18:53:10.290194');
INSERT INTO logs VALUES (446, 'ERR', 13, 9, '2016-10-01 18:53:19.391429');
INSERT INTO logs VALUES (447, 'HLP', 13, 9, '2016-10-01 18:53:40.493052');
INSERT INTO logs VALUES (448, 'OUT', 4, 9, '2016-10-01 18:55:06.025727');
INSERT INTO logs VALUES (449, 'ERR', 12, 14, '2016-10-01 18:55:59.343929');
INSERT INTO logs VALUES (450, 'ERR', 6, 10, '2016-10-01 18:57:46.831608');
INSERT INTO logs VALUES (451, 'OUT', 6, 29, '2016-10-01 18:57:59.669014');
INSERT INTO logs VALUES (452, 'ERR', 6, 10, '2016-10-01 18:59:06.857681');
INSERT INTO logs VALUES (453, 'ERR', 12, 14, '2016-10-01 18:59:45.344043');
INSERT INTO logs VALUES (454, 'BON', 4, 31, '2016-10-01 19:00:16.298473');
INSERT INTO logs VALUES (455, 'OUT', 10, 9, '2016-10-01 19:01:41.946721');
INSERT INTO logs VALUES (456, 'STR', 12, 32, '2016-10-01 19:01:51.28211');
INSERT INTO logs VALUES (457, 'HLP', 5, 12, '2016-10-01 19:02:39.243636');
INSERT INTO logs VALUES (458, 'ERR', 6, 10, '2016-10-01 19:02:49.022096');
INSERT INTO logs VALUES (459, 'FIN', 12, 32, '2016-10-01 19:03:26.600151');
INSERT INTO logs VALUES (460, 'STR', 9, 32, '2016-10-01 19:03:52.784762');
INSERT INTO logs VALUES (461, 'FIN', 9, 32, '2016-10-01 19:04:24.609303');
INSERT INTO logs VALUES (462, 'OUT', 6, 13, '2016-10-01 19:04:49.364164');
INSERT INTO logs VALUES (463, 'ERR', 5, 11, '2016-10-01 19:06:10.281371');
INSERT INTO logs VALUES (464, 'OUT', 13, 9, '2016-10-01 19:07:11.970216');
INSERT INTO logs VALUES (465, 'BON', 3, 28, '2016-10-01 19:07:17.10314');
INSERT INTO logs VALUES (466, 'STR', 13, 32, '2016-10-01 19:09:14.238634');
INSERT INTO logs VALUES (467, 'ERR', 5, 13, '2016-10-01 19:09:15.613354');
INSERT INTO logs VALUES (468, 'STR', 6, 32, '2016-10-01 19:09:42.212076');
INSERT INTO logs VALUES (469, 'ERR', 5, 11, '2016-10-01 19:09:55.345202');
INSERT INTO logs VALUES (470, 'STR', 5, 32, '2016-10-01 19:11:04.98006');
INSERT INTO logs VALUES (471, 'FIN', 6, 32, '2016-10-01 19:11:13.653508');
INSERT INTO logs VALUES (472, 'STR', 10, 32, '2016-10-01 19:11:30.845594');
INSERT INTO logs VALUES (473, 'STR', 7, 32, '2016-10-01 19:12:26.309018');
INSERT INTO logs VALUES (474, 'BON', 4, 28, '2016-10-01 19:13:38.845378');
INSERT INTO logs VALUES (475, 'STR', 2, 32, '2016-10-01 19:14:37.506317');
INSERT INTO logs VALUES (476, 'STR', 8, 32, '2016-10-01 19:14:46.306283');
INSERT INTO logs VALUES (477, 'FIN', 2, 32, '2016-10-01 19:15:09.083994');
INSERT INTO logs VALUES (478, 'STR', 3, 32, '2016-10-01 19:19:25.538608');
INSERT INTO logs VALUES (479, 'ERR', 3, 32, '2016-10-01 19:19:28.56949');
INSERT INTO logs VALUES (480, 'FIN', 3, 32, '2016-10-01 19:19:32.671933');
INSERT INTO logs VALUES (481, 'ERR', 7, 10, '2016-10-01 19:23:23.615676');
INSERT INTO logs VALUES (482, 'STR', 4, 32, '2016-10-01 19:25:58.735142');
INSERT INTO logs VALUES (483, 'FIN', 4, 32, '2016-10-01 19:26:10.477731');
INSERT INTO logs VALUES (484, 'FIN', 5, 32, '2016-10-01 19:33:45.802388');
INSERT INTO logs VALUES (485, 'FIN', 7, 32, '2016-10-01 19:34:45.242077');
INSERT INTO logs VALUES (486, 'FIN', 8, 32, '2016-10-01 19:36:01.307122');
INSERT INTO logs VALUES (487, 'FIN', 10, 32, '2016-10-01 19:10:00');
INSERT INTO logs VALUES (488, 'BON', 2, 31, '2016-10-01 11:40:00');
INSERT INTO logs VALUES (489, 'OUT', 1, 30, '2016-10-08 18:10:19.03601');
INSERT INTO logs VALUES (490, 'HLP', 2, 9, '2016-10-25 14:31:12.001448');


--
-- Name: logs_log_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('logs_log_seq', 490, true);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO players VALUES (1, 1, 'Hamstik');
INSERT INTO players VALUES (2, 1, 'Krky');
INSERT INTO players VALUES (3, 1, 'MonnieSPO');
INSERT INTO players VALUES (4, 1, 'theo1024');
INSERT INTO players VALUES (5, 1, 'xmarwin');
INSERT INTO players VALUES (6, 2, 'Benjo5');
INSERT INTO players VALUES (7, 2, 'Sinuhet');
INSERT INTO players VALUES (8, 2, 'WiKoCZ');
INSERT INTO players VALUES (9, 3, 'mara biker');
INSERT INTO players VALUES (10, 3, 'Ekharon');
INSERT INTO players VALUES (11, 3, 'h-Vipet');
INSERT INTO players VALUES (12, 4, '2pírko');
INSERT INTO players VALUES (13, 4, 'Consolador');
INSERT INTO players VALUES (14, 4, 'Wi-Li');
INSERT INTO players VALUES (15, 4, '?Perun?');
INSERT INTO players VALUES (16, 5, 'kenod');
INSERT INTO players VALUES (17, 5, 'markubz');
INSERT INTO players VALUES (18, 5, 'janule90');
INSERT INTO players VALUES (19, 5, 'patrick');
INSERT INTO players VALUES (20, 6, 'Frenkonix');
INSERT INTO players VALUES (21, 6, 'Stepan81');
INSERT INTO players VALUES (22, 7, 'Apsalar');
INSERT INTO players VALUES (23, 7, 'ZCh');
INSERT INTO players VALUES (24, 7, 'soukmenovci');
INSERT INTO players VALUES (25, 7, 'karlllik');
INSERT INTO players VALUES (26, 8, 'Chillie-M');
INSERT INTO players VALUES (27, 8, 'KaNaVo');
INSERT INTO players VALUES (28, 8, 'MalyPlch');
INSERT INTO players VALUES (29, 9, 'Kate.schumacher');
INSERT INTO players VALUES (30, 9, 'Brumbambulinka');
INSERT INTO players VALUES (31, 9, 'Asterix');
INSERT INTO players VALUES (32, 9, 'Obelix');
INSERT INTO players VALUES (33, 10, 'kačkafibi');
INSERT INTO players VALUES (34, 10, 'Cholísektom');
INSERT INTO players VALUES (35, 10, 'Yoki X');
INSERT INTO players VALUES (36, 10, 'Yoki XY');
INSERT INTO players VALUES (37, 10, 'xfibi');
INSERT INTO players VALUES (38, 11, 'Yoki5');
INSERT INTO players VALUES (39, 11, 'mamča');
INSERT INTO players VALUES (40, 11, 'Kačka fibi');
INSERT INTO players VALUES (41, 11, '1. yokiholka');
INSERT INTO players VALUES (42, 11, '2. yokiholka');
INSERT INTO players VALUES (43, 12, 'Robiczech');
INSERT INTO players VALUES (44, 12, 'Pekyesp');
INSERT INTO players VALUES (45, 12, 'Macistfman');
INSERT INTO players VALUES (46, 12, 'DuffKrabica');
INSERT INTO players VALUES (47, 13, 'morsky_konik');
INSERT INTO players VALUES (48, 13, 'sotlinka');
INSERT INTO players VALUES (49, 13, 'XiXao02');


--
-- Name: players_player_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('players_player_seq', 49, true);


--
-- Data for Name: post_colors; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO post_colors VALUES ('TRA', 'žádn', 'transparent');
INSERT INTO post_colors VALUES ('RED', 'červen', 'rgb(247, 150, 70)');
INSERT INTO post_colors VALUES ('YEL', 'žlut', 'rgb(255, 255, 153)');
INSERT INTO post_colors VALUES ('GRN', 'zelen', 'rgb(146, 208, 80)');
INSERT INTO post_colors VALUES ('BLU', 'modr', 'rgb(66, 133, 244)');
INSERT INTO post_colors VALUES ('WHT', 'bíl', 'rgb(255, 255, 255)');


--
-- Data for Name: post_notes; Type: TABLE DATA; Schema: public; Owner: brazda
--



--
-- Name: post_notes_post_note_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('post_notes_post_note_seq', 1, false);


--
-- Data for Name: post_sizes; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO post_sizes VALUES ('M', 'Mikro');
INSERT INTO post_sizes VALUES ('S', 'Malá');
INSERT INTO post_sizes VALUES ('R', 'Střední');
INSERT INTO post_sizes VALUES ('L', 'Velká');
INSERT INTO post_sizes VALUES ('O', 'Jiná');


--
-- Data for Name: post_types; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO post_types VALUES ('BEG', 'Start');
INSERT INTO post_types VALUES ('END', 'Cíl');
INSERT INTO post_types VALUES ('ORG', 'Organizace');
INSERT INTO post_types VALUES ('ACT', 'Aktivita');
INSERT INTO post_types VALUES ('CIP', 'Šifra');
INSERT INTO post_types VALUES ('CGC', 'Keš');
INSERT INTO post_types VALUES ('BON', 'Bonus');


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO posts VALUES (1, 'BEG', 'TRA', 'Start', 0, 1, 1, 'O', NULL, 'Hybaj', true, NULL, '', '<p><strong>Vítejte na startu závodu BRAZDA 2016</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', NULL);
INSERT INTO posts VALUES (2, 'ACT', 'RED', 'Transport', 150, 2.5, 2.5, 'O', NULL, 'Dánsko', true, '', '', '<p>Aktivita, která prověří vaši logiku, obratnost i vytrvalost. Může se hodit ručník a plavky.</p>', NULL);
INSERT INTO posts VALUES (3, 'ACT', 'RED', 'Klíčová pakárna', 100, 2, 3.5, 'O', NULL, 'král', true, '', '', '<p>Aktivita, která prověří vaši sílu a vytvalost. Hodí se dobré boty.</p>', NULL);
INSERT INTO posts VALUES (4, 'ACT', 'RED', 'Přepravky', 150, 2, 4, 'O', NULL, 'trn', true, '', '', '<p>Aktivita, která prověří vaši odvahu a obratnost na hranice mezí. Vlastní sedák může být výhoda.</p>', NULL);
INSERT INTO posts VALUES (5, 'ACT', 'RED', 'Titanic', 130, 3, 5, 'O', NULL, 'jelen', true, '', '', '<p>Aktivita, která prověří váš důvtip a vytrvalost. Ručník a plavky budou potřeba.</p>', NULL);
INSERT INTO posts VALUES (7, 'ACT', 'YEL', 'Váhy', 100, 4, 1, 'O', NULL, '3,14159', true, '', '', '<p>Aktivita, která prověří váši inteligenci a důvtip. Jak to uděláte je opravdu na vás.</p>', NULL);
INSERT INTO posts VALUES (8, 'ACT', 'RED', 'Mozaika', 90, 3, 1.5, 'O', NULL, 'zub', true, '', '', '<p>Aktivita, která prověří vaši inteligenci a představivost. Chce to jen čas.</p>', NULL);
INSERT INTO posts VALUES (9, 'CIP', 'BLU', 'Morseovka', 100, 5, 1, 'O', NULL, 'magnituda', false, 'Za památníkem', 'Záleží na úhlu pohledu', '<p>Co by to byl za závod, kdyby na něm nebyla aspoň jedna šifra v morseovce. Nebo ne?</p>', NULL);
INSERT INTO posts VALUES (11, 'CIP', 'BLU', 'Housenka', 80, 2.5, 2, 'O', NULL, 'gymnastika', false, 'Pod kamenem, cca 15m od cesty', 'Semafor', '<p>Ne až tak náročná šifra, jen na to přijít.</p>', NULL);
INSERT INTO posts VALUES (12, 'CIP', 'BLU', 'Trajektorie', 60, 3, 1.5, 'O', NULL, 'letohrádek', false, '', 'Mapa', '<p>Ne až tak složitá šifra, chce to jen trochu představivosti.</p>', NULL);
INSERT INTO posts VALUES (14, 'CIP', 'YEL', 'Tunel', 80, 2, 2.5, 'O', NULL, 'horor', false, '', 'Uwe Filter', '<p>Vcelku nenáročná šifra v tunelu, jen si na ni posvítit. Pokud je víc vody, hodí se gumáky. Šifra je v nejtemnější části.</p>', NULL);
INSERT INTO posts VALUES (15, 'CIP', 'YEL', 'Substituce', 90, 2, 2.5, 'O', NULL, 'tréning', false, 'Na čerstvém pařezu', '', '<p>Šifra jejíž luštění není až tak náročné mentálně jako spíš fyzicky. Během jejího luštění se tým může kvůli efektivitě rozdělit.</p>', NULL);
INSERT INTO posts VALUES (17, 'CGC', 'GRN', 'Plotny', 150, 2, 5, 'S', 'TRA', 'láska', false, 'Visí', '', '<p>"Co by to bylo za pořádný geozávod, kdyby na něm nebyla alespoň jedna T5ka!" řekli jsme si při přípravě. V tomto případě je jí skála, na kterou bude potřeba vylézt. Zcela jistě budete potřebovat lezeckou výbavu.</p>', NULL);
INSERT INTO posts VALUES (19, 'CGC', 'YEL', 'Pod Mísnú', 80, 2, 3.5, 'R', 'MLT', 'svatozář', false, 'Nahoře krytá před deštěm', '', '<h2>Pod Mísnú</h2>
                <p>Když se podíváte na mapu do místa známého jako Zákopčí (nebo Za Kopcem), jinak místní části Hutiska-Solanec, všimnete si pojmenování Pod Mísnou a to hned na několika různých místech. Ovšem žádný kopec s názvem Mísná na mapě neuvidíte. Hluboké údolí Zákopčí se kousek za památníkem Charlotte Garrigue-Masaryk u školy v přírodě (rekreačního střediska Hutisko-Solanec) dělí na dvě části, jedním protéká Hutiský potok a druhým potok Mísná. Podél Hutiského potoka vede zelená turistická značka, která končí na Vsacké Tanečnici (912 m n.m.). My se však vydáme proti proudu potoka Mísná do druhého, zapadlejšího údolí.</p>
                <h3>Výchozí souřadnice - Stage 1</h3>
                <p>Svá geovozidla prosím zanechte na doporučeném parkovišti, parkovat na točně autobusu u rekreačního střediska opravdu není dobrý nápad a pokračovat dále autem je nejen že dopravním značením zapovězené, ale mohli byste se se zlou potázat. Místní jsou všímaví a nekompromisní. Ale než se vydáme dále, povšimněte si památníku před rekreačním střediskem napravo. Památník byl postaven při příležitosti otevření školy, jsou na něm vyobrazeny dvě děti, ukazující na bustu T.G. Masaryka a z boku je vyvedený nápis. Nápis si dobře přečtěte a spočítejte počet slov (=<strong>A</strong>).</p>
                <h3>Výpočet pro Stage 2</h3>
                <p><strong>N 49°25,(A*25+5)<br>
                E 018°11,(A*29+3)</strong></p>
                <p>Máte spočítáno? Tak můžeme vyrazit na druhou zastávku procházky. Cestou si všimněte chalup a stavení roztroušených v údolí a po stráních. Některé jsou trvale obydlené, jiné slouží jako chaty pro sezonní bydlení. Pokud jste trefili správnou cestu a nepřepočítali se hned na začátku, došli jste ke studánce, kde se můžete občerstvit (ale neručím za pitnost vody). Naproti studánce, mezi dvěma lipami a kaštanem, stojí kříž s Kristem. Očividně již má něco za sebou, ale když si ho dobře prohlédnete, objevíte letopočet, který si zapište (=<strong>BCDE</strong>).</p>
                <h3>Výpočet pro Stage 3</h3>
                <p><strong>N 49°24,(C-B)(A-D)(D+E-C)<br>
                E 018°10,(D-B)(D-A)(E)</strong></p>
                <p>Jednoduchý výpočet jste jistě zvládli a můžeme tak pokračovat dále. Pokud jste se rozhodli absolvovat trasu na kole, teď se asi zapotíte, ale na Valašsku to ani jinak nejde. Ještě než dojdete k další zastávce, otevřou se výhledy do okolí a můžete se začít kochat panoramaty. Nejlepší výhledy jsou asi přímo od druhého kříže s vyobrazením Krista a mohutné lípy, která stojí hned vedle. Můžete si zde sednout na lavičku, odpočinout si a pokochat se rozhledy. Krásně je vidět hřeben Čertova Mlýna napravo a Radhoště nalevo. Až se pokocháte výhledem, všimněte si louky pod vámi, kde rostou jalovce a množství chráněných rostlin, možná i orchidejí (což nemám ověřeno, ale na okolních lokalitách se vyskytují). Pak se vraťe ke kříži a všimněte si plechového oblouku stříšky nad křížem. Určete jeho barvu a pořadí barvy v barvách duhy (červená=1 až fialová=6) je poslední indicie pro výpočet finálky (=<strong>F</strong>).</p>
                <h3>Výpočet pro Finále</h3>
                <p><strong>N 49°24,(D)(B)(A)<br>
                E 018°10,(F)(B)(D+B)</strong></p>
                <p>Ještě než se vydáte ke keši, tak jak je to teda s tou Mísnou? Když budete pokračovat po cestě dále, dostanete se až na hřeben mezi Hážovskými díly a Vsackou Tanečnicí a tam někde na modré turistické značce najdete rozcestí Mísná.</p>', NULL);
INSERT INTO posts VALUES (20, 'CGC', 'YEL', 'Kání', 70, 1.5, 4, 'R', 'TRA', 'olympiáda', false, '', '', '<h3>O místě</h3>
				<p>Kání je výrazný kopec, který se tyčí do výšky 666m nad mořem nad obcí Hutisko-Solanec. Po přerušení Solaneckým potokem jím pokračuje jižní hřeben údolí Rožnovské brázdy, který se táhne od kopce Brdo nad Valašským Meziříčím a končí kopcem Beskyd na Česko-Slovenském pomezí poblíž Bumbálky.</p>
				<p>Vede přes něj modrá turistická značka, která z Hutiska-Solance stoupá právě na tomto kopci na hřeben, po kterém přes Kýnačky a Hluboký vede až k rozcestí Na Západí, kde se k ní připojuje zelená turistická značka od Zavadilky. Přes Jezerné pod Kotlovu pak vede dále na Benešky, Polanu, Vysokou a přes Třeštík až na zmíněý Beskyd. Je to jedna z nejkrásnějších tras v této části Beskyd, ze které je řada krásných výhledů jak do údolí Rožnovské tak do údolí Vsetínské Bečvy. Tato trasa je velmi oblíbená nejen mezi pěšímí, ale cyklo turisty</p>
				<p>Kousek pod vrcholem kopce Kání stojí i retranslační a základová stanice s dobře viditelným vysílačem. Pod vrcholem je několik chalup, ke kterým se dostat ale není vůbec jednoduché. Ostatně při cestě ke keši to poznáte sami.</p>
				<h3>O Keši</h3>
				<p>Keš samotná je pověšena na stromě nedaleko vysílače, není to žádné supertěžké stromolezení, ale zadarmo to taky nebude. Místo však rozhodně stojí za návštěvu.</p>', NULL);
INSERT INTO posts VALUES (21, 'CGC', 'RED', 'Kostel sv. Zdislavy', 30, 2, 2, 'R', 'TRA', 'strom', false, 'Pod čepičkou', '', '<p>Obec Prostřední Bečva leží ve východní části Radhošťské hornatiny a Vsetínských vrchů v nadmořské výšce 430 m.n.m. Byla donedávna jedna z mála okolních obcí, která neměla svůj vlastní kostel.</p>
                <p>Dne  23.&thinsp;května 1998 vznikla Kostelní jednota sv. Zdislavy, jejíž členové začali usilovat o&nbsp;výstavbu nového kostela. V&nbsp;roce 1999 začali členové této jednoty vybírat finanční prostředky na jeho výstavbu. Dřevo na výstavbu bylo darováno, obec poskytla pozemek, věřící darovali potřebnou finanční částku a některé z vybavení kostela.</p>
                <p>Stavba byla zahájena dne 11. července roku 2000 a trvala jeden rok. Výsledkem stavby byl pěkný moderní kostel, ke kterému vás přivede tato keška. Při odlovu si počínejte opatrně v případě mudlů v okolí.</p>', NULL);
INSERT INTO posts VALUES (22, 'CGC', 'YEL', 'Nořičí trail 1', 60, 2, 2.5, 'R', 'TRA', 'záchrana', false, 'Pata stromu', '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', NULL);
INSERT INTO posts VALUES (23, 'CGC', 'YEL', 'Nořičí trail 2', 60, 2, 2.5, 'R', 'TRA', 'objezd', false, 'Za kamenem', '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', NULL);
INSERT INTO posts VALUES (6, 'ACT', 'BLU', 'Špionáž', 150, 3, 2, 'O', NULL, 'červená', false, 'Za dřevěnou nástěnkou', '', '<p>Aktivita, která prověří vaši všímavost a důvtip. Nutnost zařízení, které umí přečíst QR kódy.</p>', NULL);
INSERT INTO posts VALUES (16, 'CGC', 'BLU', 'Trigonometrická', 110, 4, 2, 'R', 'MYS', 'žid', false, 'Všechny stage: sloupy el. vedení, Final: visí', '', '<p>Trigonometrie (z řeckého <em>trigonón</em> - trojúhelník a <em>metrein</em> - měřit) je oblast goniometrie zabývající se použitím goniometrických funkcí při řešení úloh o trohúhelnících. Trigonometrie má základní význam při triangulaci, která se používá k měření vzdáleností mezi dvěma hvězdami, v geodézii k měření vzdálenosti dvou bodů a v satelitních navigačních systémech.</p>
				<p>První poznatky z trigonometrie lze prokázat již u Egypťanů. Podobné znalosti měli také Babyloňané a Chaldejci, od kterých převzali Řekové dnešní dělení plného úhlu na 360° a stupně na 60 minut. První práce o trigonometrii souvisely s problémem určení délky tětivy vzhledem k velikosti úhlu. První tabulky délek tětiv pocházejí od řeckého matematika Hipparcha z roku 140 př. n. l., další tabulky sepsal zhruba o 40 let později Melenaus, řecký matematik žijící v Římě. Práce starořeckých vědců vyvrcholila Ptolemaiovým dílem Megale syntaxis (Velká soustava), v níž Ptolemaios vypočítal tabulku délek tětiv kružnice, jež měla poloměr až 60 délkových jednotek a kde středový úhel, k němuž se délky vztahovaly, postupoval po 0,5°.</p>
				<p>Od 5. století začali pak trigonometrii budovat Indové, od kterých pochází dnešní název pro sinus, a po nich vědci Střední Asie a Arabové. Z Indů se trigonometrii nejvíce věnoval Brahmagupta (7. století), z vědců Střední Asie a Arábie je pak třeba vzpomenout syrského astronoma al-Battáního.</p>
				<p>Evropa se s trigonometrií seznámila díky západním Arabům. K rozvoji trigonometrie významně přispěl polský astronom Mikuláš Koperník, stejně tak i francouzský matematik François Viète, který představil kosinovou větu v trigonometrické podobě. Dnešní podobu trigonometrie jakožto vědu o goniometrických funkcích ve svém díle Introductio in analysin infinitorum (Úvod do analýzy) vytvořil Leonhard Euler. Poprvé zkoumal hodnoty sin x, cos x jako čísla, nikoli jako úsečky, a jako hodnoty proměnné připouštěl kladná i záporná čísla.</p>
				<p>Nejvýznamnější a technologicky nejvyspělejší aplikací trigonometrie v současnosti patří jednoznačně satelitní navigační systémy, které pracují právě na principech sférické trigonometrie s využitím znalosti efemerid družicového pole a přesného času, kdy z rozdílu mezi přijetím stejného času lze dopočítat vzdálenost k družici, která jej vyslala a díky znalostí poloh alespoň tří (v praxi však více) družic dopočítat vlastní pozici na kulové ploše.</p>
				<p>Po vás nic tak složitého chtít nebudeme, nicméně pro nález krabičky budete potřebovat nějakým způsobem trigonometrii ať již v algebraické, nebo geometrické podobě použít. Na jednotlivých stagích najdete vzdálenost od keše. Vše ostatní je na vás.<p>', NULL);
INSERT INTO posts VALUES (10, 'CIP', 'BLU', 'Šipky', 120, 4, 1, 'O', NULL, 'rudá', false, 'Mezi koulema', 'Tetris', '<p>Poměrně náročná a pracná šifra, ale ono to na konec vždycky nějak jde.</p>', NULL);
INSERT INTO posts VALUES (13, 'CIP', 'BLU', 'Křížovka', 60, 2.5, 2, 'O', NULL, 'mercedes', false, 'Za rezavou boudou', 'Do třetice všeho dobrého', '<p>Vcelku jednoduchá šifra na dobře známém základě.</p>', NULL);
INSERT INTO posts VALUES (24, 'CGC', 'GRN', 'Nořičí trail 3', 60, 2, 2.5, 'R', 'TRA', 'oběh', false, 'Zezadu cedule', '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', NULL);
INSERT INTO posts VALUES (25, 'CGC', 'GRN', 'Nořičí trail 4', 60, 2, 2.5, 'R', 'TRA', 'infarkt', false, 'Smrček', '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', NULL);
INSERT INTO posts VALUES (26, 'CGC', 'GRN', 'Kostel sv. Antonína Paduánského', 40, 2, 1.5, 'R', 'TRA', 'trumf', false, 'Zespodu, magnet', '', '<p>Kostel sv. Antonína Paduánského byl postaven 1906 stavitelem Ing. Aloisem Pallatem z Olomouce. Nachází se ve středu obce Dolní Bečva, v blízkosti lipové aleje Hynka Tošenovského. Základní kámen byl posvěcen  24.září 1905 Antonínem C. Stojanem.</p>
                <p>Patronem  kostela byl zvolen sv. Antonín Paduánský. Kostel byl požehnán v roce 1907. Jeho délka je 28 metrů, šířka 9,5 metrů a jeho věž je vysoká 37 metrů. Byl postaven v novorománském slohu.</p>
                <h3>Ke keši</h3>
                <p>Keš se nachází na poměrně frekventovaném místě, proto prosím s odlovem počkejte, dokud nebude oblast vylidněná. K odlovení keše není potřeba nic rozhrabávat, ani ničit. </p>', NULL);
INSERT INTO posts VALUES (27, 'CGC', 'GRN', 'Lom Kněhyně', 100, 3, 3, 'O', 'ERT', 'zlato707', false, 'Stage 2: 6m pod betonovým sloupkem, dvířka nad vodou', '', '<h2>Lom Kněhyně</h2>
				<p>Významnou geologickou lokalitu představuje opuštěný, částečně zasutěný stěnový kamenolom v katastru obce Prostřední Bečva na jihozápadním úpatí Kněhyně (1 257 m n.m.). Lom se nachází ve vzdálenosti asi 4,5 km od obce, vpravo od silnice z Prostřední Bečvy na Pustevny. Přístupová cesta odbočuje v první z ostrých zatáček na začátku stoupání této silnice ve směru na Pustevny. Lomovou stěnou jsou zastiženy křídové sedimenty středního a svrchního oddílu godulského souvrství (cenoman až senon), budujícího hlavní hřebeny Beskyd a představujícího současně nejmocnější člen (přes 3 000 m) slezské jednotky.<br>
				Slezská jednotka je příkrov flyšového pásma Západních Karpat a z větší části tvoří Moravskoslezské Beskydy a podbeskydskou pahorkatinu. Slezská jednotka zahrnuje juru až oligocén a dělí se na dílčí příkrov těšínský (nižší) a godulský (vyšší). A právě část souvrství godulských vrstev je možné pozorovat v lomu v Kněhyni.</p>
				<p>Horniny středního oddílu godulského souvrství jsou jen menším podílem zastoupeny v jihozápadní části lomu. Představují hrubě rytmický flyš s převahou světle zelenavě šedých, silně lavicovitých, hrubě až středně zrnitých glaukonitických pískovců, vytvářejících polohy o mocnosti až několika desítek metrů. Na bázi silnějších lavic s gradačním zvrstvením se lokálně vyskytují drobně zrnité slepence a slepencové, vzácněji i arkózové pískovce.<br>
				Horniny svrchního oddílu godulského souvrství jsou rozšířené v severovýchodní části odkryvu. Litologicky odpovídají výše popsaným sedimentům, pro něž je typické rychlé snižování prachovcovo-pískovcových poloh a jejich celkové ztenčování. Mnohem častější je současně rychlé proužkovité střídání šedých a zelených, někdy až tmavošedě skvrnitých jílovců.</p>
				<h3>Flyš</h3>
				<p>V sedimentologii se tak nazývá komplex vrstev mořského původu, nejméně 500m mocný, tvořený z rytmicky zvrstvených a střídajících se klastických sedimentů, jevících často pozitivní gradační zvrstvení (od větších zrn sedimentární horniny k jemnějším). Na spodních plochách pískovců se často objevuji velice hojné hieroglyfy (nerovnost vrstevních ploch). Svým složením se flyš blíží uloženinám některých hlubokomořských delt a byl ukládán při úpatí příkrých podmořských srázů (například na kontinentálním úpatí) a na jeho vzniku se významnou měrou podílely takzvané turbiditní proudy (gravitační toky). Pozice flyše v pánvi proto rozhoduje o jeho složení.<br>
				V tektonickém pojetí se jedná o sedimenty ukládané v období uzavírání geosynklinál za tektonicky nestabilních a silně seizmických podmínek.<br>
				Z horninového hlediska je flyš složený ze slepenců, pískovců a jílovců.</p>
				<h3>Kameny zblízka</h3>
				<p>Na plochách některých kamenů je možné spatřit nerovnosti, způsobené buď mechanicky, takzvané mechanoglyfy (proudy, vtisky, čeřiny nebo stopy vlečení) a nebo biologicky, takzvané bioglyfy (stopy po lezení a vrtání organismů). Tyto stopy vznikly v době usazování hornin na mořském dně.</p>
				<h3>Jak na keš?</h3>
				<p><strong>Pro uznání logu musíte absolvovat několik úkolů</strong></p>
				<ul>
					<li>Na výchozích souřadnicích stojíte před stěnou lomu a vedle vás leží na zemi několik velkých kamenů, z nichž jeden vypadá jako obrazovka televize (viz Úkol 1). Změřte průměrné rozměry kamene (měřte vždy uprostřed strany) a spočítejte, kolik kámen váží (v kg), když víte, že se jedná o pískovec (do závorky napište, jakou objemovou hmotnost jste uvažovali). </li>
					<li>Dále se podívejte na stěnu lomu před vámi a uvidíte dole uprostřed vykukovat ze sutě několik vrstev flyše (viz Úkol 2 a 3). Běžte ke skále a zaměřte se na nejsilnější vrstvu pískovce (asi ve výšce hlavy, když stojíte uprostřed). Změřte tloušťku vrstvy a zaokrouhlete na desítky centimetrů. A hned změřte i tmavou tenkou vrstvu pod ní a zaokrouhlete na celé centimetry. Jestli jste měřili správně, tak si hned všimnete, že tloušťka obou vrstev má zajímavou souvislost. Jako odpověď pošlete obě změřené tloušťky.</li>
					<li>U tenčí vrstvy se ještě zdržíme, určete o jakou horninu se jedná (pomůže listing) a napište, čím se hlavně liší od pískovce nad ní (kromě barvy).</li>
					<li>Nyní se otočte zády ke stěně lomu a přímo před vámi našikmo leží velký šedý kámen se stopami bioglyfů (viz. Úkol 3). Změřte průměrnou šířku těchto stop v centimetrech.</li>
					<li>Za posledním úkolem se vydejte na souřadnice Stage 2. Terén bude poněkud komplikovanější (tak T4) a najděte zajímavý objekt vytvořený člověkem (nachází se asi 6m po svahu pod betonovým sloupkem (viz. Fotohint stage 2). Napište, k čemu dle vašeho názoru objekt sloužil a jaký číslený údaj v kg jste na něm objevili.</li>
				</ul>
				<p>Jako dobrovolný úkol přidejte k logu fotografii z lomu, ať už stěny lomu s rytmickými vrstvami flyše a nebo kamenů, které vás zaujaly. Prosím nepřikládejte k logu fotografie ze Stage 2!</p>

				<h3>Splnění úkolu a zadání hesla pro závod BRAZDA 2016</h3>
				<p>Musíte <strong>splnit úkol č. 2</strong>. to je změřit tloušťku dvou vrstev v lomu.<br>
				Dostanete <strong>dvě čísla</strong> v centimetrech ve formátu <strong>X0</strong> a <strong>Y</strong>. Na <strong>stage 2 najdete indícii</strong>. Heslo <strong>pro splnění stanoviště</strong> zadáte do herní aplikace ve formátu "<strong>indicieX0Y</strong>".</p>
				<p>Příklad: V lomu změříte a zaokrouhlíte tloušťku větší vrstvy na 50cm a menší na 8cm. Na stage 2 objevíte indícii "potok". Heslo pro splnění stanoviště pak bude "potok508".</p>
				<p>Odpovědi posílejte pouze přes profil a logovat můžete hned po odeslání. Když budou odpovědi nedostatečné, budu vás kontaktovat. Bez zaslaných odpovědí logy mažu.</p>

				<h3>Zdroje</h3>
				<ul>
					<li>http://www.geology.cz</li>
					<li>http://pruvodce.geol.morava.sci.muni.cz/Prostredni_Becva/Knehyne_text.htm</li>
					<li>http://geologie.vsb.cz/reg_geol_cr/10_kapitola.htm</li>
				</ul>', NULL);
INSERT INTO posts VALUES (28, 'BON', 'GRN', 'Zelený bonus', 150, 2, 3, 'R', 'TRA', 'srdce', false, 'Kořeny', '', '<p>Tento bonus vás zavede na pěkné místo :)</p>', 'hypochondr');
INSERT INTO posts VALUES (29, 'BON', 'BLU', 'Modrý bonus', 150, 2.5, 2.5, 'R', 'TRA', 'hvězda', false, 'Visí 30cm nad zemí', '', '<p>Tento bonus vás zavede na pěkné místo, ale dostat se tam není zas tak jednoduché.</p>', 'mlhovina');
INSERT INTO posts VALUES (30, 'BON', 'YEL', 'Žlutý bonus', 150, 2, 3, 'R', 'TRA', 'kruh', false, 'Oběšená na menším z dvojstromu', '', '<h2>Díly</h2>
				<p>Na Valašsku a v okolí Rožnova jsou Díly poměrně častý název kopce. Obvykle je pozůstatkem po první pasekářské kolonizaci údolí Rožnovské Bečvy, kdy jednotlivé části krajiny byly přidělovány osadníkům a každý tak dostal svůj díl. Obvykle se země rozdělovala tak, že od cest vedených obvykle postředkem údolí v blízkosti vodních toků byly vyčleňovány úzké pruhy země směrem nahoru k hřebenům nad údolím. V některých (především jižních) částech obcí v Hutiském údolí je tato struktura patrná dodnes v rozmístění budov. Dnes však již hospodaříme s krajinou jinými způsoby a tak lze podobné rozdělení vysledovat stále řídčeji</p>
				<h3>O Keši</h3>
				<p>Kterých dílů se naše povídání týká, zda-li Zuberských, Tylovských, Hažovských Vingantských, nebo Hutiských vám však neprozradíme. Na to budete muset ze žlutých indicií zjistit správné heslo pro odemčení tohoto bonusu. Hodně štěstí při jejich získávání i při dedukci hesla.</p>', 'orbital');
INSERT INTO posts VALUES (31, 'BON', 'RED', 'Červený bonus', 150, 2, 2.5, 'R', 'TRA', 'koruna', false, 'Visí na malém smrčku na vyvráceném pařezu nad vodou', '', '<h2>Sklářství na Valašsku</h2>
                <p>Od poloviny devatenáctého století se datuje rozmach sklářského průmyslu na Valašsku a je spojován s firmou S.REICH. Firma si pronajala od panství Valašské Meziříčí - Rožnov sklárnu Františčina Huť ve Velkých Karlovicích, poté v roce 1855 zahájila provoz ve své největší sklárně v Krásně ve Valašském Meziříčí, dále od roku 1861 začala provozovat Mariánskou Huť ve Velkých Karlovicích, v roce 1862 otevřela sklárnu Karolinina Huť v Novém Hrozenkově. Dozvuky tohoto rozmachu jsou patrné i dnes, sklárny stále fungují v Karolince a tradice výroby skla dodnes přetrvává i ve Valašském Meziříčí.<br>
                Ovšem ještě před industrializací sklářské výroby a vzniku velkých skláren, existovaly na Valašsku malé hutě, jejichž vznik je datován do 15. až 16. století. Do dnešních dní se po nich nedochovalo více, než názvy obcí a místních částí. Jednou z obcí, jejíž historie je spojena se sklářskými hutěmi je Hutisko-Solanec. Sklárny byly na místě Hutiska založeny v první polovině 17. století, samotná osada vznikla později, po roce 1656 (roku 1666 byla prohlášena za obec). V první polovině 18. století byla huť z Hutiska přesunuta jinam.</p>
                <h3>Zdroje</h3>
                <ul>
                    <li>http://www.obeliskval.cz</li>
                    <li>http://www.sreich.cz</li>
                    <li>http://www.lesycr.cz/volny-cas-v-lese/naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>
                    <li>http://www.lesycr.cz/volny-cas-v-lese/:w
                    naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>
                </ul>
', 'bitcoin');
INSERT INTO posts VALUES (32, 'END', 'TRA', 'Cíl', 0, 1, 1, 'O', NULL, 'Finito', true, NULL, '', '<p><strong>Gratulejeme k dokončení závodu BRAZDA 2016</strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', NULL);
INSERT INTO posts VALUES (18, 'CGC', 'GRN', 'Můstek', 80, 1.5, 3, 'R', 'TRA', 'zvon', false, '', '', '<p>Vydejte se na malou procházku do udržovaného lesíku a objevte dávno zapomenutý poklad. Časy jeho slávy připomíná už jen torzo a těžko říct, kolik pamětníků je ještě mezi námi.</p><p>Můstky dříve rostly jako houby po dešti; dvaceti či třicetimetrové můstky měla každá třetí horská obec, i když se na nich konaly třeba jen dva závody. Před 2. světovou válkou bylo na území ČR více než 220 můstků, ve zlatém věku na přelomu 50. a 60. let autoři napočítali dokonce 270 můstků.</p><p>V blízkosti se nachází Ski areál. Ski areál Búřov leží v malebné vesnici Valašská Bystřice, v samotném srdci Beskyd, 7 km od Rožnova pod Radhoštěm.</p><p>Areál je vhodný pro začínající i pokročilé lyžaře, ideální pro lyžařské kurzy. Náš areál často navštěvují také snowboardisté, pro které máme zřízen snowpark.</p><p>Nadmořská výška vleků je 500 – 620 m.n.m.</p>', NULL);


--
-- Name: posts_post_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('posts_post_seq', 1, false);


--
-- Data for Name: team_types; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO team_types VALUES ('COM', 'Závodníci');
INSERT INTO team_types VALUES ('ORG', 'Organizátoři');


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO teams VALUES (1, 'ORG', 'BRAZDA', 'Mocn8Klika', 'Organizační tým');
INSERT INTO teams VALUES (2, 'COM', 'Přes mrtvoly', '8Omerta.', '');
INSERT INTO teams VALUES (3, 'COM', 'Tři chlapi', 'Bajkonur3!', '');
INSERT INTO teams VALUES (4, 'COM', 'Perun s náma', '5Hoříme?', '');
INSERT INTO teams VALUES (5, 'COM', 'Ušaté myši', 'Bééčka12!', '');
INSERT INTO teams VALUES (6, 'COM', 'BO!!!', '4Banýk!!!', '');
INSERT INTO teams VALUES (7, 'COM', 'Ptakopysk', '1Pterodaktyl.', '');
INSERT INTO teams VALUES (8, 'COM', 'KaNaVo', 'Wakata8!', '');
INSERT INTO teams VALUES (9, 'COM', 'Fantastické čtyřkY', 'Pentagon6.', '');
INSERT INTO teams VALUES (10, 'COM', 'Radegastova rota', '2Rychlost?', '');
INSERT INTO teams VALUES (11, 'COM', 'Geokvočny', '1Zeměřváč!', '');
INSERT INTO teams VALUES (12, 'COM', 'Hanáci', 'Montenegro4?', '');
INSERT INTO teams VALUES (13, 'COM', 'Čuňoši', 'Kolaloka?', '');


--
-- Name: teams_team_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('teams_team_seq', 1, false);


--
-- Data for Name: waypoint_types; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO waypoint_types VALUES ('FIN', 1, 'Finální umístění');
INSERT INTO waypoint_types VALUES ('STA', 2, 'Stage');
INSERT INTO waypoint_types VALUES ('REF', 3, 'Zajímavé místo');
INSERT INTO waypoint_types VALUES ('PAR', 4, 'Parkoviště');
INSERT INTO waypoint_types VALUES ('WAY', 5, 'Stezka');


--
-- Name: waypoint_types_rank_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('waypoint_types_rank_seq', 1, false);


--
-- Data for Name: waypoint_visibilities; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO waypoint_visibilities VALUES ('VW', 'Viditelná');
INSERT INTO waypoint_visibilities VALUES ('HC', 'Bez souřadnic');
INSERT INTO waypoint_visibilities VALUES ('HW', 'Skrytá');


--
-- Data for Name: waypoints; Type: TABLE DATA; Schema: public; Owner: brazda
--

INSERT INTO waypoints VALUES (1, 'REF', 'VW', 1, 'Start', 'Místo startu závodu BRAZDA 2016.', 49.4671493999999967, 18.1633682999999984);
INSERT INTO waypoints VALUES (2, 'REF', 'VW', 2, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4197561000000007, 18.3181772000000009);
INSERT INTO waypoints VALUES (3, 'PAR', 'VW', 2, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4204853000000028, 18.3190355999999994);
INSERT INTO waypoints VALUES (4, 'REF', 'VW', 3, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4840007999999969, 18.0407717000000005);
INSERT INTO waypoints VALUES (5, 'PAR', 'VW', 3, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4844000000000008, 18.0416835999999989);
INSERT INTO waypoints VALUES (6, 'REF', 'VW', 4, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4269000000000034, 17.9922000000000004);
INSERT INTO waypoints VALUES (7, 'PAR', 'VW', 4, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4357232999999994, 18.0174860999999993);
INSERT INTO waypoints VALUES (8, 'REF', 'VW', 5, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4243055999999967, 18.025694399999999);
INSERT INTO waypoints VALUES (9, 'PAR', 'VW', 5, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4248333000000031, 18.024944399999999);
INSERT INTO waypoints VALUES (10, 'REF', 'VW', 6, 'Aktivita', 'Místo, kde začíná aktivita.', 49.3910499999999999, 17.9634833);
INSERT INTO waypoints VALUES (11, 'PAR', 'VW', 6, 'Parkoviště', 'Zde můžete zaparkovat.', 49.3913166999999973, 17.9632666999999984);
INSERT INTO waypoints VALUES (12, 'FIN', 'HW', 6, 'Umístění řešení úkolu', 'Zde jste dokončili celou aktivitu.', 49.3911166999999978, 17.9633000000000003);
INSERT INTO waypoints VALUES (13, 'REF', 'VW', 7, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4348644000000021, 18.2533157999999993);
INSERT INTO waypoints VALUES (14, 'PAR', 'VW', 7, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4350894000000025, 18.2530488999999996);
INSERT INTO waypoints VALUES (15, 'REF', 'VW', 8, 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4486153000000002, 18.1931350000000016);
INSERT INTO waypoints VALUES (16, 'PAR', 'VW', 8, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4485394000000014, 18.1929955999999997);
INSERT INTO waypoints VALUES (17, 'REF', 'VW', 9, 'Šifra', 'Místo, kde najdete šifru.', 49.4064167000000012, 18.0727000000000011);
INSERT INTO waypoints VALUES (18, 'PAR', 'VW', 9, 'Parkoviště', 'Zde můžete zaparkovat.', 49.406089399999999, 18.0722805999999991);
INSERT INTO waypoints VALUES (19, 'REF', 'VW', 10, 'Šifra', 'Místo, kde najdete šifru.', 49.4356500000000025, 18.0958332999999989);
INSERT INTO waypoints VALUES (20, 'PAR', 'VW', 10, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4410256000000032, 18.0971328000000007);
INSERT INTO waypoints VALUES (21, 'REF', 'VW', 11, 'Šifra', 'Místo, kde najdete šifru.', 49.5033999999999992, 18.2776333000000015);
INSERT INTO waypoints VALUES (22, 'PAR', 'VW', 11, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847166999999999, 18.2644167000000017);
INSERT INTO waypoints VALUES (23, 'REF', 'VW', 12, 'Šifra', 'Místo, kde najdete šifru.', 49.4634332999999984, 18.1489167000000009);
INSERT INTO waypoints VALUES (24, 'PAR', 'VW', 12, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4640167000000019, 18.1489332999999995);
INSERT INTO waypoints VALUES (25, 'REF', 'VW', 13, 'Šifra', 'Místo, kde najdete šifru.', 49.4679167000000035, 18.0905333000000006);
INSERT INTO waypoints VALUES (26, 'PAR', 'VW', 13, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4676472000000018, 18.0906957999999989);
INSERT INTO waypoints VALUES (27, 'REF', 'VW', 14, 'Vstup do tunelu', 'Místo, kde najdete šifru. Hledejte v temné části mezi zatáčkama.', 49.4549378000000033, 18.1276106000000006);
INSERT INTO waypoints VALUES (28, 'PAR', 'VW', 14, 'Parkoviště 1', 'Zde můžete zaparkovat.', 49.4529568999999967, 18.1309833000000005);
INSERT INTO waypoints VALUES (29, 'PAR', 'VW', 14, 'Parkoviště 2', 'Zde můžete zaparkovat.', 49.4577918999999966, 18.1276575000000015);
INSERT INTO waypoints VALUES (30, 'REF', 'VW', 15, 'Šifra', 'Místo, kde najdete šifru.', 49.4018999999999977, 17.9757832999999998);
INSERT INTO waypoints VALUES (31, 'PAR', 'VW', 15, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4000167000000019, 17.965166700000001);
INSERT INTO waypoints VALUES (32, 'STA', 'VW', 16, '1. stage', 'Zde zjistíte část indicí.', 49.4647999999999968, 17.9966000000000008);
INSERT INTO waypoints VALUES (33, 'STA', 'VW', 16, '2. stage', 'Zde zjistíte další část indicií.', 49.4631167000000005, 18.0036500000000004);
INSERT INTO waypoints VALUES (34, 'STA', 'VW', 16, '3. stage', 'Zde zjistíte posleldní část indicií.', 49.4731667000000002, 17.9943999999999988);
INSERT INTO waypoints VALUES (35, 'PAR', 'VW', 16, 'Parkoviště u 1. stage', 'Zde můžete zaparkovat.', 49.4641019000000028, 17.9954071999999989);
INSERT INTO waypoints VALUES (36, 'PAR', 'VW', 16, 'Parkoviště u 2. stage', 'Zde můžete zaparkovat.', 49.4631064000000009, 18.0045214000000016);
INSERT INTO waypoints VALUES (37, 'PAR', 'VW', 16, 'Parkoviště u 3. stage', 'Zde můžete zaparkovat.', 49.4732878000000014, 17.9914455999999987);
INSERT INTO waypoints VALUES (38, 'FIN', 'HW', 16, 'Umístění finálky', 'Zde se nachází keš.', 49.4670332999999971, 17.9991832999999986);
INSERT INTO waypoints VALUES (39, 'FIN', 'VW', 17, 'Umístění finálky', 'Zde se nachází keš.', 49.4692885999999987, 18.1769135999999989);
INSERT INTO waypoints VALUES (40, 'PAR', 'VW', 17, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4687539000000029, 18.1777571999999985);
INSERT INTO waypoints VALUES (41, 'FIN', 'VW', 18, 'Umístění finálky', 'Zde se nachází keš.', 49.408533300000002, 18.1065666999999983);
INSERT INTO waypoints VALUES (42, 'PAR', 'VW', 18, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4042667000000009, 18.1047332999999995);
INSERT INTO waypoints VALUES (43, 'STA', 'VW', 19, 'Stage 1', 'Busta T.G. Masaryka s nápisem na boku. Počet slov na nápisu = A', 49.4187500000000028, 18.2014999999999993);
INSERT INTO waypoints VALUES (44, 'STA', 'HC', 19, 'Stage 2', 'Kříž a studánka. Letopočet na kříži = BCDE', 49.4196667000000005, 18.18675);
INSERT INTO waypoints VALUES (45, 'STA', 'HC', 19, 'Stage 3', 'Kříž pod lípou. Určete pořadí barvy stříšky nad křízem v pořadí barev duhy (červená = 1 až fialová = 6) = F', 49.4133332999999979, 18.1767000000000003);
INSERT INTO waypoints VALUES (46, 'FIN', 'HW', 19, 'Umístění finálky', 'Zde se nachází keš.', 49.4119499999999974, 18.1753);
INSERT INTO waypoints VALUES (47, 'PAR', 'VW', 19, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4191332999999986, 18.2021666999999994);
INSERT INTO waypoints VALUES (48, 'FIN', 'VW', 20, 'Umístění finálky', 'Zde se nachází keš.', 49.4201163999999977, 18.2359644000000003);
INSERT INTO waypoints VALUES (49, 'PAR', 'VW', 20, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4211236000000014, 18.2233143999999996);
INSERT INTO waypoints VALUES (50, 'FIN', 'VW', 21, 'Umístění finálky', 'Zde se nachází keš.', 49.4399500000000032, 18.2480499999999992);
INSERT INTO waypoints VALUES (51, 'PAR', 'VW', 21, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4396832999999987, 18.2476333000000004);
INSERT INTO waypoints VALUES (52, 'FIN', 'VW', 22, 'Umístění finálky', 'Zde se nachází keš.', 49.4969499999999982, 18.2790832999999999);
INSERT INTO waypoints VALUES (53, 'PAR', 'VW', 22, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847166999999999, 18.2644167000000017);
INSERT INTO waypoints VALUES (54, 'FIN', 'VW', 23, 'Umístění finálky', 'Zde se nachází keš.', 49.5114166999999981, 18.2777999999999992);
INSERT INTO waypoints VALUES (55, 'PAR', 'VW', 23, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847166999999999, 18.2644167000000017);
INSERT INTO waypoints VALUES (56, 'FIN', 'VW', 24, 'Umístění finálky', 'Zde se nachází keš.', 49.5083167000000017, 18.2635332999999989);
INSERT INTO waypoints VALUES (57, 'PAR', 'VW', 24, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847166999999999, 18.2644167000000017);
INSERT INTO waypoints VALUES (58, 'FIN', 'VW', 25, 'Umístění finálky', 'Zde se nachází keš.', 49.4991500000000002, 18.2725833000000009);
INSERT INTO waypoints VALUES (59, 'PAR', 'VW', 25, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847166999999999, 18.2644167000000017);
INSERT INTO waypoints VALUES (60, 'FIN', 'VW', 26, 'Umístění finálky', 'Zde se nachází keš.', 49.4561832999999993, 18.1923500000000011);
INSERT INTO waypoints VALUES (61, 'PAR', 'VW', 26, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4567499999999995, 18.1929167000000014);
INSERT INTO waypoints VALUES (62, 'STA', 'VW', 27, 'Stage 1 - Lom Kněhyně', 'Zde nadete odpovědi na otázky 1 - 4.', 49.4810500000000033, 18.2842500000000001);
INSERT INTO waypoints VALUES (63, 'STA', 'VW', 27, 'Stage 2 - Zajímavý objekt', 'Zajímavý objekt a odpověď na otázku č. 5.', 49.4803832999999997, 18.2856832999999988);
INSERT INTO waypoints VALUES (64, 'PAR', 'VW', 27, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4799999999999969, 18.2860000000000014);
INSERT INTO waypoints VALUES (65, 'REF', 'VW', 28, 'Reference', 'Zde nic není.', 49.467655299999997, 18.0427093999999997);
INSERT INTO waypoints VALUES (66, 'FIN', 'HW', 28, 'Umístění finálky', 'Zde se nachází keš.', 49.4825666999999996, 18.0472667000000015);
INSERT INTO waypoints VALUES (67, 'PAR', 'HW', 28, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4826649999999972, 18.0490355999999998);
INSERT INTO waypoints VALUES (68, 'REF', 'VW', 29, 'Reference', 'Zde nic není.', 49.4600547000000006, 18.137466400000001);
INSERT INTO waypoints VALUES (69, 'FIN', 'HW', 29, 'Umístění finálky', 'Zde se nachází keš.', 49.4324999999999974, 18.0672166999999995);
INSERT INTO waypoints VALUES (70, 'PAR', 'HW', 29, 'Parkoviště', 'Zde můžete zaparkovat.', 49.431750000000001, 18.0635903000000013);
INSERT INTO waypoints VALUES (71, 'REF', 'VW', 30, 'Reference', 'Zde nic není.', 49.4564841999999985, 18.1898769000000016);
INSERT INTO waypoints VALUES (72, 'FIN', 'HW', 30, 'Umístění finálky', 'Zde se nachází keš.', 49.4231333000000035, 18.1956333000000008);
INSERT INTO waypoints VALUES (73, 'PAR', 'HW', 30, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4242781000000022, 18.2113681000000014);
INSERT INTO waypoints VALUES (74, 'REF', 'VW', 31, 'Reference', 'Zde nic není.', 49.4381005999999985, 18.2659388999999983);
INSERT INTO waypoints VALUES (75, 'FIN', 'HW', 31, 'Umístění finálky', 'Zde se nachází keš.', 49.4703166999999979, 18.2773499999999984);
INSERT INTO waypoints VALUES (76, 'PAR', 'HW', 31, 'Parkoviště', 'Zde můžete zaparkovat.', 49.4699497000000008, 18.2777746999999984);
INSERT INTO waypoints VALUES (77, 'REF', 'VW', 32, 'Cíl', 'Místo cíle závodu BRAZDA 2016.', 49.4671493999999967, 18.1633682999999984);


--
-- Name: waypoints_waypoint_seq; Type: SEQUENCE SET; Schema: public; Owner: brazda
--

SELECT pg_catalog.setval('waypoints_waypoint_seq', 77, true);


--
-- Name: audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (audit_log);


--
-- Name: cache_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY cache_types
    ADD CONSTRAINT cache_types_name_key UNIQUE (name);


--
-- Name: cache_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY cache_types
    ADD CONSTRAINT cache_types_pkey PRIMARY KEY (cache_type);


--
-- Name: log_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY log_types
    ADD CONSTRAINT log_types_name_key UNIQUE (name);


--
-- Name: log_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY log_types
    ADD CONSTRAINT log_types_pkey PRIMARY KEY (log_type);


--
-- Name: logs_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player);


--
-- Name: post_colors_code_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_colors
    ADD CONSTRAINT post_colors_code_key UNIQUE (code);


--
-- Name: post_colors_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_colors
    ADD CONSTRAINT post_colors_name_key UNIQUE (name);


--
-- Name: post_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_colors
    ADD CONSTRAINT post_colors_pkey PRIMARY KEY (color);


--
-- Name: post_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_notes
    ADD CONSTRAINT post_notes_pkey PRIMARY KEY (post_note);


--
-- Name: post_sizes_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_sizes
    ADD CONSTRAINT post_sizes_name_key UNIQUE (name);


--
-- Name: post_sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_sizes
    ADD CONSTRAINT post_sizes_pkey PRIMARY KEY (size);


--
-- Name: post_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY post_types
    ADD CONSTRAINT post_types_pkey PRIMARY KEY (post_type);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post);


--
-- Name: team_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY team_types
    ADD CONSTRAINT team_types_name_key UNIQUE (name);


--
-- Name: team_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY team_types
    ADD CONSTRAINT team_types_pkey PRIMARY KEY (team_type);


--
-- Name: teams_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team);


--
-- Name: waypoint_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY waypoint_types
    ADD CONSTRAINT waypoint_types_name_key UNIQUE (name);


--
-- Name: waypoint_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY waypoint_types
    ADD CONSTRAINT waypoint_types_pkey PRIMARY KEY (waypoint_type);


--
-- Name: waypoint_visibilities_name_key; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY waypoint_visibilities
    ADD CONSTRAINT waypoint_visibilities_name_key UNIQUE (name);


--
-- Name: waypoint_visibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY waypoint_visibilities
    ADD CONSTRAINT waypoint_visibilities_pkey PRIMARY KEY (waypoint_visibility);


--
-- Name: waypoints_pkey; Type: CONSTRAINT; Schema: public; Owner: brazda; Tablespace: 
--

ALTER TABLE ONLY waypoints
    ADD CONSTRAINT waypoints_pkey PRIMARY KEY (waypoint);


--
-- Name: audit_logs_log_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY audit_logs
    ADD CONSTRAINT audit_logs_log_type_fkey FOREIGN KEY (log_type) REFERENCES log_types(log_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: audit_logs_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY audit_logs
    ADD CONSTRAINT audit_logs_team_fkey FOREIGN KEY (team) REFERENCES teams(team) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: logs_log_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_log_type_fkey FOREIGN KEY (log_type) REFERENCES log_types(log_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: logs_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_post_fkey FOREIGN KEY (post) REFERENCES posts(post) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: logs_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_team_fkey FOREIGN KEY (team) REFERENCES teams(team) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: players_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_team_fkey FOREIGN KEY (team) REFERENCES teams(team) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: post_notes_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY post_notes
    ADD CONSTRAINT post_notes_post_fkey FOREIGN KEY (post) REFERENCES posts(post) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post_notes_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY post_notes
    ADD CONSTRAINT post_notes_team_fkey FOREIGN KEY (team) REFERENCES teams(team) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posts_color_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_color_fkey FOREIGN KEY (color) REFERENCES post_colors(color) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: posts_post_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_post_type_fkey FOREIGN KEY (post_type) REFERENCES post_types(post_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: posts_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_size_fkey FOREIGN KEY (size) REFERENCES post_sizes(size) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: teams_team_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_team_type_fkey FOREIGN KEY (team_type) REFERENCES team_types(team_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: waypoints_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY waypoints
    ADD CONSTRAINT waypoints_post_fkey FOREIGN KEY (post) REFERENCES posts(post) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: waypoints_waypoint_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY waypoints
    ADD CONSTRAINT waypoints_waypoint_type_fkey FOREIGN KEY (waypoint_type) REFERENCES waypoint_types(waypoint_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: waypoints_waypoint_visibility_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brazda
--

ALTER TABLE ONLY waypoints
    ADD CONSTRAINT waypoints_waypoint_visibility_fkey FOREIGN KEY (waypoint_visibility) REFERENCES waypoint_visibilities(waypoint_visibility) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

