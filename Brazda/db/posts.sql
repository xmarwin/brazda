BEGIN;

INSERT INTO teams (team, team_type, name, shibboleth, description) VALUES
	(1, 'ORG', 'BRAZDA', 'Mocn8Klika', 'Organizační tým');

SELECT setval('teams_team_seq', 1);

---------------------------------------------


INSERT INTO players (team, name)
     VALUES

     (1, 'Hamstik'),
     (1, 'Krky'),
     (1, 'MonnieSPO'),
     (1, 'theo1024'),
     (1, 'xmarwin');

-------------------------------------------


INSERT INTO posts (post, post_type,color,name,max_score,difficulty,terrain,cache_size,cache_type,shibboleth,with_staff,help,description,bonus_code,hint,latitude,longitude)
     VALUES
            (1, 'BEG', 'TRA', 'Start', 0, 1, 1, 'O', null, 'Hybaj', True, '', '<p><strong>Vítejte na startu závodu BRAZDA 2017</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 20.00</strong>, kdy závod končí.</p>', null, null, 49.4671494, 18.1633683),
            (2, 'END', 'TRA', 'Cíl', 0, 1, 1, 'O', null, 'Finito', True, '', '<p><strong>Gratulejeme k dokončení závodu BRAZDA 2017</strong>.<br> Těšíme se na Vás u vyhlášení výsledků <strong>ve 20.30</strong>.</p>', null, null, 49.4671494, 18.1633683);

SELECT setval('posts_post_seq', 2);


-------------------------------------------


INSERT INTO waypoints (post, waypoint_type, waypoint_visibility, name, description, latitude, longitude) VALUES
            (1, 'REF', 'VW', 'Start', 'Místo startu závodu BRAZDA 2017.', 49.4671494, 18.1633683),
            (2, 'REF', 'VW', 'Cíl', 'Místo cíle závodu BRAZDA 2017.', 49.4671494, 18.1633683);

COMMIT;
