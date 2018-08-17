BEGIN;

COPY teams (team, team_type, name, shibboleth, description, is_active, team_status, tracking_allowed, telephone, email) FROM stdin;
1	ORG	BRAZDA	Mocn8Klika	Organizační tým	t	STR	t	\N	\N
\.

SELECT pg_catalog.setval('teams_team_seq', 1, true);

COPY players (player, team, name) FROM stdin;
1	1	Hamstik
2	1	Krky
3	1	MonnieSPO
4	1	theo1024
5	1	xmarwin
\.

SELECT pg_catalog.setval('players_player_seq', 5, true);

COPY posts (post, post_type, color, name, max_score, difficulty, terrain, cache_size, cache_type, shibboleth, with_staff, hint, help, description, bonus_code, open_from, open_to, latitude, longitude, password_character, password_position) FROM stdin;
1	BEG	TRA	Start	0	1	1	O	\N	Hybaj	t	\N		<p><strong>Vítejte na startu závodu BRAZDA 2018</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>\n                <p><strong>Uvidíme se zde</strong> opět <strong>v 20.00</strong>, kdy závod končí.</p>	\N	\N	\N	49.4671493999999967	18.1633682999999984	_	0
2	END	TRA	Cíl	0	1	1	O	\N	Finito	t	\N		<p><strong>Gratulejeme k dokončení závodu BRAZDA 2018</strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>\n                <p><strong>Uvidíme se zde</strong> opět <strong>v 20.00</strong>, kdy závod končí.</p>	\N	\N	\N	49.4671493999999967	18.1633682999999984	_	0
\.

SELECT pg_catalog.setval('posts_post_seq', 2, true);

COPY waypoints (waypoint, waypoint_type, waypoint_visibility, post, name, description, latitude, longitude) FROM stdin;
1	REF	VW	1	Start	Místo startu závodu BRAZDA 2018.	49.4671493999999967	18.1633682999999984
2	REF	VW	2	Cíl	Místo cíle závodu BRAZDA 2018.	49.4671493999999967	18.1633682999999984
\.

SELECT pg_catalog.setval('waypoints_waypoint_seq', 2, true);

COMMIT;
