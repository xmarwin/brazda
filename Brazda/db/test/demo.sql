BEGIN;

INSERT INTO teams (team, team_type, name, shibboleth, description) VALUES
	(1, 'ORG', 'BRAZDA', 'Mocn8Klika', 'Organizační tým'),
	(2, 'COM','Přes mrtvoly', 'koruna', ''),
	(3, 'COM','Čtyři chlapi', 'provaz', ''),
	(4, 'COM','Perun s náma', '5Hoříme?', ''),
	(5, 'COM','Ušaté myši', 'Bééčka12!', ''),
	(6, 'COM','tree', 'jablko', ''),
	(7, 'COM','Ptakopysk', '1Pterodaktyl.', ''),
	(8, 'COM','KaNaVo', 'Wakata8!', ''),
	(9, 'COM','Fantastické čtyřkY', 'Pentagon6.', ''),
	(10, 'COM','Ušaté myši', 'kyvadlo', ''),
	(11, 'COM','Geokvočny', '1Zeměřváč!', ''),
	(12, 'COM', 'Hanácké Hóf', 'sekera', ''),
	(13, 'COM','Čuňoši', 'Kolaloka?', '');
--	(14, 'COM','(ještě se poradíme)', 'nevímdál.', '');


---------------------------------------------


INSERT INTO players (team, name)
     VALUES

     (1, 'Hamstik'),
     (1, 'Krky'),
     (1, 'MonnieSPO'),
     (1, 'theo1024'),
     (1, 'xmarwin'),

	 (2, 'Benjo5'),
	 (2, 'Sinuhet'),
	 (2, 'WiKoCZ'),

	 (3, 'mara biker'),
	 (3, 'Ekharon'),
	 (3, 'h-Vipet'),

	 (4, '2pírko'),
	 (4, 'Consolador'),
	 (4, 'Wi-Li'),
	 (4, '?Perun?'),

	 (5, 'kenod'),
	 (5, 'markubz'),
	 (5, 'janule90'),
	 (5, 'patrick'),

	 (6, 'Frenkonix'),
	 (6, 'Stepan81'),

	 (7, 'Apsalar'),
	 (7, 'ZCh'),
	 (7, 'soukmenovci'),
	 (7, 'karlllik'),

	 (8, 'Chillie-M'),
	 (8, 'KaNaVo'),
	 (8, 'MalyPlch'),

	 (9, 'Kate.schumacher'),
	 (9, 'Brumbambulinka'),
	 (9, 'Asterix'),
	 (9, 'Obelix'),

	 (10, 'kačkafibi'),
	 (10, 'Cholísektom'),
	 (10, 'Yoki X'),
	 (10, 'Yoki XY'),
	 (10, 'xfibi'),

	 (11, 'Yoki5'),
	 (11, 'mamča'),
	 (11, 'Kačka fibi'),
	 (11, '1. yokiholka'),
	 (11, '2. yokiholka'),

	 (12, 'Robiczech'),
	 (12, 'Pekyesp'),
	 (12, 'Macistfman'),
	 (12, 'DuffKrabica'),

	 (13, 'morsky_konik'),
	 (13, 'sotlinka'),
	 (13, 'XiXao02');

--	 (14, 'RaDim');


-------------------------------------------


INSERT INTO posts (post, post_type,color,name,max_score,difficulty,terrain,size,cache_type,shibboleth,with_staff,help,description,bonus_code,hint)
     VALUES
            (1, 'BEG', 'TRA', 'Start', 0, 1, 1, 'O', null, 'Go', True, '', '<p><strong>Vítejte na startu závodu BRAZDA 2016</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', null, null),


			(2, 'ACT', 'RED', 'Aktivita 1', 150, 2.5, 2.5, 'O', null, 'Hujer', True, '', '<p>Aktivita, která prověří vaši logiku, obratnost i vytrvalost. Může se hodit ručník a plavky.</p>', null, ''),




			(9, 'CIP', 'BLU', 'Šifra 1', 100, 5, 1, 'O', null, 'hiphaphop', False, 'Kdo neskáče není čech', '<p>Co by to byl za závod, kdyby na něm nebyla aspoň jedna šifra v morseovce. Nebo ne?</p>', null, 'Jinde než bys čekal'),



			(17, 'CGC', 'GRN', 'Sporák', 150, 2, 5, 'S', 'TRA', 'mlask', False, '', '<p>"Co by to bylo za pořádný geozávod, kdyby na něm nebyla alespoň jedna T5ka!" řekli jsme si při přípravě. V tomto případě je jí skála, na kterou bude potřeba vylézt. Zcela jistě budete potřebovat lezeckou výbavu.</p>', null, 'Leží'),

			(28, 'BON', 'GRN', 'Zelený bonus', 150, 2, 3, 'R', 'TRA', 'hrnec', False, '', 'TODO: Listing', 'vařecha', 'Kořeny'),

            (32, 'END', 'TRA', 'Cíl', 0, 1, 1, 'O', null, 'Finito', True, '', '<p><strong>Gratulejeme k dokončení závodu BRAZDA 2016</strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', null, null);


-------------------------------------------


INSERT INTO waypoints (post, waypoint_type, waypoint_visibility, name, description, latitude, longitude) VALUES
            (1, 'REF', 'VW', 'Start', 'Místo startu závodu BRAZDA 2016.', 49.4671494, 18.1633683),


            (2, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4197561, 18.3181772),

            (2, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4204853, 18.3190356),


            (9, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4064167, 18.0727000),

            (9, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4060894, 18.0722806),


            (17, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4692886, 18.1769136),

            (17, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4687539, 18.1777572),


            (28, 'REF', 'VW', 'Reference', 'Zde nic není.', 49.4676553, 18.0427094),

            (28, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4825667, 18.0472667),

            (28, 'PAR', 'HW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4826650, 18.0490356),


            (32, 'REF', 'VW', 'Cíl', 'Místo cíle závodu BRAZDA 2016.', 49.4671494, 18.1633683);

COMMIT;
