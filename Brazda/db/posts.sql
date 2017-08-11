BEGIN;

INSERT INTO teams (team, team_type, name, shibboleth, description) VALUES
	(1, 'ORG', 'BRAZDA', 'Mocn8Klika', 'Organizační tým'),
	(2, 'COM','Přes mrtvoly', '8Omerta.', ''),
	(3, 'COM','Tři chlapi', 'Bajkonur3!', ''),
	(4, 'COM','Perun s náma', '5Hoříme?', ''),
	(5, 'COM','Ušaté myši', 'Bééčka12!', ''),
	(6, 'COM','BO!!!', '4Banýk!!!', ''),
	(7, 'COM','Ptakopysk', '1Pterodaktyl.', ''),
	(8, 'COM','KaNaVo', 'Wakata8!', ''),
	(9, 'COM','Fantastické čtyřkY', 'Pentagon6.', ''),
	(10, 'COM','Radegastova rota', '2Rychlost?', ''),
	(11, 'COM','Geokvočny', '1Zeměřváč!', ''),
	(12, 'COM', 'Hanáci', 'Montenegro4?', ''),
	(13, 'COM','Čuňoši', 'Kolaloka?', '');
--	(14, 'COM','(ještě se poradíme)', 'nevímdál.', '');

SELECT setval('teams_team_seq', 13);

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


INSERT INTO posts (post, post_type,color,name,max_score,difficulty,terrain,cache_size,cache_type,shibboleth,with_staff,help,description,bonus_code,hint,latitude,longitude)
     VALUES
            (1, 'BEG', 'TRA', 'Start', 0, 1, 1, 'O', null, 'Hybaj', True, '', '<p><strong>Vítejte na startu závodu BRAZDA 2016</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', null, null, 49.4671494, 18.1633683),


			(2, 'ACT', 'RED', 'Transport', 150, 2.5, 2.5, 'O', null, 'Dánsko', True, '', '<p>Aktivita, která prověří vaši logiku, obratnost i vytrvalost. Může se hodit ručník a plavky.</p>', null, '', 49.4204853, 183181772),

			(3, 'ACT', 'RED', 'Klíčová pakárna', 100, 2, 3.5, 'O', null, 'král', True, '', '<p>Aktivita, která prověří vaši sílu a vytvalost. Hodí se dobré boty.</p>', null, '', 49.4840008, 18.0407717),

			(4, 'ACT', 'RED', 'Přepravky', 150, 2, 4, 'O', null, 'trn', True, '', '<p>Aktivita, která prověří vaši odvahu a obratnost na hranice mezí. Vlastní sedák může být výhoda.</p>', null, '', 49.4269000, 17.9922000),

			(5, 'ACT', 'RED', 'Titanic', 130, 3, 5, 'O', null, 'jelen', True, '', '<p>Aktivita, která prověří váš důvtip a vytrvalost. Ručník a plavky budou potřeba.</p>', null, '', 49.4243056, 18.0256944),

			(6, 'ACT', 'BLU', 'Špionáž', 150, 3, 2, 'O', null, 'červená', False, '', '<p>Aktivita, která prověří vaši všímavost a důvtip. Nutnost zařízení, které umí přečíst QR kódy.</p>', null, 'Za dřevěnou nástěnkou', 49.3910500, 17.9634833),

			(7, 'ACT', 'YEL', 'Váhy', 100, 4, 1, 'O', null, '3,14159', True, '', '<p>Aktivita, která prověří váši inteligenci a důvtip. Jak to uděláte je opravdu na vás.</p>', null, '', 49.4348644, 18.2533158),

			(8, 'ACT', 'RED', 'Mozaika', 90, 3, 1.5, 'O', null, 'zub', True, '', '<p>Aktivita, která prověří vaši inteligenci a představivost. Chce to jen čas.</p>', null, '', 49.4486153, 18.1931350),



			(9, 'CIP', 'BLU', 'Morseovka', 100, 5, 1, 'O', null, 'magnituda', False, 'Záleží na úhlu pohledu', '<p>Co by to byl za závod, kdyby na něm nebyla aspoň jedna šifra v morseovce. Nebo ne?</p>', null, 'Za památníkem', 49.4064167, 18.0722806),

			(10, 'CIP', 'BLU', 'Křížovka', 60, 2.5, 2, 'O', null, 'mercedes', False, 'Do třetice všeho dobrého', '<p>Vcelku jednoduchá šifra na dobře známém základě.</p>', null, 'Mezi koulema', 49.4356500, 18.0958333),

			(11, 'CIP', 'BLU', 'Housenka', 80, 2.5, 2, 'O', null, 'gymnastika', False, 'Semafor', '<p>Ne až tak náročná šifra, jen na to přijít.</p>', null, 'Pod kamenem, cca 15m od cesty', 49.5034000, 18.2776333),

			(12, 'CIP', 'BLU', 'Trajektorie', 60, 3, 1.5, 'O', null, 'letohrádek', False, 'Mapa', '<p>Ne až tak složitá šifra, chce to jen trochu představivosti.</p>', null, '', 49.4634333, 18.1489167),

			(13, 'CIP', 'BLU', 'Šipky', 120, 4, 1, 'O', null, 'rudá', False, 'Tetris', '<p>Poměrně náročná a pracná šifra, ale ono to na konec vždycky nějak jde.</p>', null, 'Za rezavou boudou', 49.4679167, 18.0905333),

			(14, 'CIP', 'YEL', 'Tunel', 80, 2, 2.5, 'O', null, 'horor', False, 'Uwe Filter', '<p>Vcelku nenáročná šifra v tunelu, jen si na ni posvítit. Pokud je víc vody, hodí se gumáky. Šifra je v nejtemnější části.</p>', null, '', 49.4549378, 18.1276106),

			(15, 'CIP', 'YEL', 'Substituce', 90, 2, 2.5, 'O', null, 'tréning', False, '', '<p>Šifra jejíž luštění není až tak náročné mentálně jako spíš fyzicky. Během jejího luštění se tým může kvůli efektivitě rozdělit.</p>', null, 'Na čerstvém pařezu', 49.4019000, 17.9757833),



			(16, 'CGC', 'BLU', 'Trigonometrická', 110, 4, 2, 'R', 'MYS', 'žid', False, '', '<p>Trigonometrie (z řeckého <em>trigonón</em> - trojúhelník a <em>metrein</em> - měřit) je oblast goniometrie zabývající se použitím goniometrických funkcí při řešení úloh o trohúhelnících. Trigonometrie má základní význam při triangulaci, která se používá k měření vzdáleností mezi dvěma hvězdami, v geodézii k měření vzdálenosti dvou bodů a v satelitních navigačních systémech.</p>
				<p>První poznatky z trigonometrie lze prokázat již u Egypťanů. Podobné znalosti měli také Babyloňané a Chaldejci, od kterých převzali Řekové dnešní dělení plného úhlu na 360° a stupně na 60 minut. První práce o trigonometrii souvisely s problémem určení délky tětivy vzhledem k velikosti úhlu. První tabulky délek tětiv pocházejí od řeckého matematika Hipparcha z roku 140 př. n. l., další tabulky sepsal zhruba o 40 let později Melenaus, řecký matematik žijící v Římě. Práce starořeckých vědců vyvrcholila Ptolemaiovým dílem Megale syntaxis (Velká soustava), v níž Ptolemaios vypočítal tabulku délek tětiv kružnice, jež měla poloměr až 60 délkových jednotek a kde středový úhel, k němuž se délky vztahovaly, postupoval po 0,5°.</p>
				<p>Od 5. století začali pak trigonometrii budovat Indové, od kterých pochází dnešní název pro sinus, a po nich vědci Střední Asie a Arabové. Z Indů se trigonometrii nejvíce věnoval Brahmagupta (7. století), z vědců Střední Asie a Arábie je pak třeba vzpomenout syrského astronoma al-Battáního.</p>
				<p>Evropa se s trigonometrií seznámila díky západním Arabům. K rozvoji trigonometrie významně přispěl polský astronom Mikuláš Koperník, stejně tak i francouzský matematik François Viète, který představil kosinovou větu v trigonometrické podobě. Dnešní podobu trigonometrie jakožto vědu o goniometrických funkcích ve svém díle Introductio in analysin infinitorum (Úvod do analýzy) vytvořil Leonhard Euler. Poprvé zkoumal hodnoty sin x, cos x jako čísla, nikoli jako úsečky, a jako hodnoty proměnné připouštěl kladná i záporná čísla.</p>
				<p>Nejvýznamnější a technologicky nejvyspělejší aplikací trigonometrie v současnosti patří jednoznačně satelitní navigační systémy, které pracují právě na principech sférické trigonometrie s využitím znalosti efemerid družicového pole a přesného času, kdy z rozdílu mezi přijetím stejného času lze dopočítat vzdálenost k družici, která jej vyslala a díky znalostí poloh alespoň tří (v praxi však více) družic dopočítat vlastní pozici na kulové ploše.</p>
				<p>Po vás nic tak složitého chtít nebudeme, nicméně pro nález krabičky budete potřebovat nějakým způsobem trigonometrii ať již v algebraické, nebo geometrické podobě použít. Na jednotlivých stagích najdete vzdálenost od keše. Vše ostatní je na vás.<p>', null, 'Všechny stage: sloupy el. vedení, Final: visí', 49.4648000, 17.9966000),

			(17, 'CGC', 'GRN', 'Plotny', 150, 2, 5, 'S', 'TRA', 'láska', False, '', '<p>"Co by to bylo za pořádný geozávod, kdyby na něm nebyla alespoň jedna T5ka!" řekli jsme si při přípravě. V tomto případě je jí skála, na kterou bude potřeba vylézt. Zcela jistě budete potřebovat lezeckou výbavu.</p>', null, 'Visí', 49.4692886, 18.1769136),

			(18, 'CGC', 'GRN', 'Můstek', 80, 1.5, 3, 'R', 'TRA', 'zvon', False, '', '<p>Vydejte se na malou procházku do udržovaného lesíku a objevte dávno zapomenutý poklad. Časy jeho slávy připomíná už jen torzo a těžko říct, kolik pamětníků je ještě mezi námi.</p>
				<p>Můstky dříve rostly jako houby po dešti; dvaceti či třicetimetrové můstky měla každá třetí horská obec, i když se na nich konaly třeba jen dva závody. Před 2. světovou válkou bylo na území ČR více než 220 můstků, ve zlatém věku na přelomu 50. a 60. let autoři napočítali dokonce 270 můstků.</p>
				<p>V blízkosti se nachází Ski areál. Ski areál Búřov leží v malebné vesnici Valašská Bystřice, v samotném srdci Beskyd, 7 km od Rožnova pod Radhoštěm.</p>
				<p>Areál je vhodný pro začínající i pokročilé lyžaře, ideální pro lyžařské kurzy. Náš areál často navštěvují také snowboardisté, pro které máme zřízen snowpark.</p>
				<p>Nadmořská výška vleků je 500 – 620 m.n.m.</p>', null, '', 49.4085333, 18.1065667),

			(19, 'CGC', 'YEL', 'Pod Mísnú', 80, 2, 3.5, 'R', 'MLT', 'svatozář', False, '', '<h2>Pod Mísnú</h2>
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
                <p>Ještě než se vydáte ke keši, tak jak je to teda s tou Mísnou? Když budete pokračovat po cestě dále, dostanete se až na hřeben mezi Hážovskými díly a Vsackou Tanečnicí a tam někde na modré turistické značce najdete rozcestí Mísná.</p>', null, 'Nahoře krytá před deštěm', 49.4187500, 18.2015000),

			(20, 'CGC', 'YEL', 'Kání', 70, 1.5, 4, 'R', 'TRA', 'olympiáda', False, '', '<h3>O místě</h3>
				<p>Kání je výrazný kopec, který se tyčí do výšky 666m nad mořem nad obcí Hutisko-Solanec. Po přerušení Solaneckým potokem jím pokračuje jižní hřeben údolí Rožnovské brázdy, který se táhne od kopce Brdo nad Valašským Meziříčím a končí kopcem Beskyd na Česko-Slovenském pomezí poblíž Bumbálky.</p>
				<p>Vede přes něj modrá turistická značka, která z Hutiska-Solance stoupá právě na tomto kopci na hřeben, po kterém přes Kýnačky a Hluboký vede až k rozcestí Na Západí, kde se k ní připojuje zelená turistická značka od Zavadilky. Přes Jezerné pod Kotlovu pak vede dále na Benešky, Polanu, Vysokou a přes Třeštík až na zmíněý Beskyd. Je to jedna z nejkrásnějších tras v této části Beskyd, ze které je řada krásných výhledů jak do údolí Rožnovské tak do údolí Vsetínské Bečvy. Tato trasa je velmi oblíbená nejen mezi pěšímí, ale cyklo turisty</p>
				<p>Kousek pod vrcholem kopce Kání stojí i retranslační a základová stanice s dobře viditelným vysílačem. Pod vrcholem je několik chalup, ke kterým se dostat ale není vůbec jednoduché. Ostatně při cestě ke keši to poznáte sami.</p>
				<h3>O Keši</h3>
				<p>Keš samotná je pověšena na stromě nedaleko vysílače, není to žádné supertěžké stromolezení, ale zadarmo to taky nebude. Místo však rozhodně stojí za návštěvu.</p>', null, '', 49.4201164, 18.2359644),

            (21, 'CGC', 'RED', 'Kostel sv. Zdislavy', 30, 2, 2, 'R', 'TRA', 'strom', False, '', '<p>Obec Prostřední Bečva leží ve východní části Radhošťské hornatiny a Vsetínských vrchů v nadmořské výšce 430 m.n.m. Byla donedávna jedna z mála okolních obcí, která neměla svůj vlastní kostel.</p>
                <p>Dne  23.&thinsp;května 1998 vznikla Kostelní jednota sv. Zdislavy, jejíž členové začali usilovat o&nbsp;výstavbu nového kostela. V&nbsp;roce 1999 začali členové této jednoty vybírat finanční prostředky na jeho výstavbu. Dřevo na výstavbu bylo darováno, obec poskytla pozemek, věřící darovali potřebnou finanční částku a některé z vybavení kostela.</p>
                <p>Stavba byla zahájena dne 11. července roku 2000 a trvala jeden rok. Výsledkem stavby byl pěkný moderní kostel, ke kterému vás přivede tato keška. Při odlovu si počínejte opatrně v případě mudlů v okolí.</p>', null, 'Pod čepičkou', 49.4399500, 18.2480500),

            (22, 'CGC', 'YEL', 'Nořičí trail 1', 60, 2, 2.5, 'R', 'TRA', 'záchrana', False, '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', null, 'Pata stromu', 49.4969500, 18.2790833),

			(23, 'CGC', 'YEL', 'Nořičí trail 2', 60, 2, 2.5, 'R', 'TRA', 'objezd', False, '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', null, 'Za kamenem', 49.5114167, 18.2778000),

			(24, 'CGC', 'GRN', 'Nořičí trail 3', 60, 2, 2.5, 'R', 'TRA', 'oběh', False, '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', null, 'Zezadu cedule', 49.5083167, 18.265333),

			(25, 'CGC', 'GRN', 'Nořičí trail 4', 60, 2, 2.5, 'R', 'TRA', 'infarkt', False, '', '<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>
                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>', null, 'Smrček', 49.4991500, 18.2725833),

			(26, 'CGC', 'GRN', 'Kostel sv. Antonína Paduánského', 40, 2, 1.5, 'R', 'TRA', 'trumf', False, '', '<p>Kostel sv. Antonína Paduánského byl postaven 1906 stavitelem Ing. Aloisem Pallatem z Olomouce. Nachází se ve středu obce Dolní Bečva, v blízkosti lipové aleje Hynka Tošenovského. Základní kámen byl posvěcen  24.září 1905 Antonínem C. Stojanem.</p>
                <p>Patronem  kostela byl zvolen sv. Antonín Paduánský. Kostel byl požehnán v roce 1907. Jeho délka je 28 metrů, šířka 9,5 metrů a jeho věž je vysoká 37 metrů. Byl postaven v novorománském slohu.</p>
                <h3>Ke keši</h3>
                <p>Keš se nachází na poměrně frekventovaném místě, proto prosím s odlovem počkejte, dokud nebude oblast vylidněná. K odlovení keše není potřeba nic rozhrabávat, ani ničit. </p>', null, 'Zespodu, magnet', 49.4561833, 18.1923500),

			(27, 'CGC', 'GRN', 'Lom Kněhyně', 100, 3, 3, 'O', 'ERT', 'zlato707', False, '', '<h2>Lom Kněhyně</h2>
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
				</ul>', null, 'Stage 2: 6m pod betonovým sloupkem, dvířka nad vodou', 49.48105500, 18.2842500),

			(28, 'BON', 'GRN', 'Zelený bonus', 150, 2, 3, 'R', 'TRA', 'hypochondr', False, '', '<p>Tento bonus vás zavede na pěkné místo :)</p>', 'srdce', 'Kořeny', 49.4676553, 18.0427094),

			(29, 'BON', 'BLU', 'Modrý bonus', 150, 2.5, 2.5, 'R', 'TRA', 'mlhovina', False, '', '<p>Tento bonus vás zavede na pěkné místo, ale dostat se tam není zas tak jednoduché.</p>', 'hvězda', 'Visí 30cm nad zemí', 49.4600547, 18.1374664),

			(30, 'BON', 'YEL', 'Žlutý bonus', 150, 2, 3, 'R', 'TRA', 'orbital', False, '', '<h2>Díly</h2>
				<p>Na Valašsku a v okolí Rožnova jsou Díly poměrně častý název kopce. Obvykle je pozůstatkem po první pasekářské kolonizaci údolí Rožnovské Bečvy, kdy jednotlivé části krajiny byly přidělovány osadníkům a každý tak dostal svůj díl. Obvykle se země rozdělovala tak, že od cest vedených obvykle postředkem údolí v blízkosti vodních toků byly vyčleňovány úzké pruhy země směrem nahoru k hřebenům nad údolím. V některých (především jižních) částech obcí v Hutiském údolí je tato struktura patrná dodnes v rozmístění budov. Dnes však již hospodaříme s krajinou jinými způsoby a tak lze podobné rozdělení vysledovat stále řídčeji</p>
				<h3>O Keši</h3>
				<p>Kterých dílů se naše povídání týká, zda-li Zuberských, Tylovských, Hažovských Vingantských, nebo Hutiských vám však neprozradíme. Na to budete muset ze žlutých indicií zjistit správné heslo pro odemčení tohoto bonusu. Hodně štěstí při jejich získávání i při dedukci hesla.</p>', 'kruh', 'Oběšená na menším z dvojstromu', 49.4564842, 18.1898769),

    		(31, 'BON', 'RED', 'Červený bonus', 150, 2, 2.5, 'R', 'TRA', 'bitcoin', False, '', '<h2>Sklářství na Valašsku</h2>
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
', 'koruna', 'Visí na malém smrčku na vyvráceném pařezu nad vodou', 49.4381006, 18.2659389),



            (32, 'END', 'TRA', 'Cíl', 0, 1, 1, 'O', null, 'Finito', True, '', '<p><strong>Gratulejeme k dokončení závodu BRAZDA 2016</strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>
                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>', null, null, 49.4671494, 18.1633683);

SELECT setval('posts_post_seq', 32);


-------------------------------------------


INSERT INTO waypoints (post, waypoint_type, waypoint_visibility, name, description, latitude, longitude) VALUES
            (1, 'REF', 'VW', 'Start', 'Místo startu závodu BRAZDA 2016.', 49.4671494, 18.1633683),


            (2, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4197561, 18.3181772),

            (2, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4204853, 18.3190356),


            (3, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4840008, 18.0407717),

            (3, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4844000, 18.0416836),


            (4, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4269000, 17.9922000),

            (4, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4357233, 18.0174861),


            (5, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4243056, 18.0256944),

            (5, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4248333, 18.0249444),


            (6, 'REF', 'VW', 'Aktivita', 'Místo, kde začíná aktivita.', 49.3910500, 17.9634833),

            (6, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.3913167, 17.9632667),

            (6, 'FIN', 'HW', 'Umístění řešení úkolu', 'Zde jste dokončili celou aktivitu.', 49.3911167, 17.9633000),


            (7, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4348644, 18.2533158),

            (7, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4350894, 18.2530489),


            (8, 'REF', 'VW', 'Aktivita', 'Místo, kde probíhá aktivita.', 49.4486153, 18.1931350),

            (8, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4485394, 18.1929956),



            (9, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4064167, 18.0727000),

            (9, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4060894, 18.0722806),


            (10, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4356500, 18.0958333),

            (10, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4410256, 18.0971328),


            (11, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.5034000, 18.2776333),

            (11, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847167, 18.2644167),


            (12, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4634333, 18.1489167),

            (12, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.',  49.4640167, 18.1489333),


            (13, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4679167, 18.0905333),

            (13, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4676472, 18.0906958),


            (14, 'REF', 'VW', 'Vstup do tunelu', 'Místo, kde najdete šifru. Hledejte v temné části mezi zatáčkama.', 49.4549378, 18.1276106),

            (14, 'PAR', 'VW', 'Parkoviště 1', 'Zde můžete zaparkovat.', 49.4529569, 18.1309833),

            (14, 'PAR', 'VW', 'Parkoviště 2', 'Zde můžete zaparkovat.', 49.4577919, 18.1276575),


            (15, 'REF', 'VW', 'Šifra', 'Místo, kde najdete šifru.', 49.4019000, 17.9757833),

            (15, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4000167, 17.9651667),



            (16, 'STA', 'VW', '1. stage', 'Zde zjistíte část indicí.', 49.4648000, 17.9966000),

            (16, 'STA', 'VW', '2. stage', 'Zde zjistíte další část indicií.', 49.4631167, 18.0036500),

            (16, 'STA', 'VW', '3. stage', 'Zde zjistíte posleldní část indicií.', 49.4731667, 17.9944000),

            (16, 'PAR', 'VW', 'Parkoviště u 1. stage', 'Zde můžete zaparkovat.', 49.4641019, 17.9954072),

            (16, 'PAR', 'VW', 'Parkoviště u 2. stage', 'Zde můžete zaparkovat.', 49.4631064, 18.0045214),

            (16, 'PAR', 'VW', 'Parkoviště u 3. stage', 'Zde můžete zaparkovat.', 49.4732878, 17.9914456),

            (16, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4670333, 17.9991833),


            (17, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4692886, 18.1769136),

            (17, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4687539, 18.1777572),


            (18, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4085333, 18.1065667),

            (18, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4042667, 18.1047333),


            (19, 'STA', 'VW', 'Stage 1', 'Busta T.G. Masaryka s nápisem na boku. Počet slov na nápisu = A', 49.4187500, 18.2015000),

            (19, 'STA', 'HC', 'Stage 2', 'Kříž a studánka. Letopočet na kříži = BCDE', 49.4196667, 18.1867500),

            (19, 'STA', 'HC', 'Stage 3', 'Kříž pod lípou. Určete pořadí barvy stříšky nad křízem v pořadí barev duhy (červená = 1 až fialová = 6) = F', 49.4133333, 18.1767000),

            (19, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4119500, 18.1753000),

            (19, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4191333, 18.2021667),


            (20, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4201164, 18.2359644),

            (20, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4211236, 18.2233144),


            (21, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4399500, 18.2480500),

            (21, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4396833, 18.2476333),


            (22, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4969500, 18.2790833),

            (22, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847167, 18.2644167),


            (23, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.5114167, 18.2778000),

            (23, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847167, 18.2644167),


            (24, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.5083167, 18.2635333),

            (24, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847167, 18.2644167),


            (25, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4991500, 18.2725833),

            (25, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4847167, 18.2644167),


            (26, 'FIN', 'VW', 'Umístění finálky', 'Zde se nachází keš.', 49.4561833, 18.1923500),

            (26, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4567500, 18.1929167),


            (27, 'STA', 'VW', 'Stage 1 - Lom Kněhyně', 'Zde nadete odpovědi na otázky 1 - 4.', 49.4810500, 18.2842500),

            (27, 'STA', 'VW', 'Stage 2 - Zajímavý objekt', 'Zajímavý objekt a odpověď na otázku č. 5.', 49.4803833, 18.2856833),

            (27, 'PAR', 'VW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4800000, 18.2860000),



            (28, 'REF', 'VW', 'Reference', 'Zde nic není.', 49.4676553, 18.0427094),

            (28, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4825667, 18.0472667),

            (28, 'PAR', 'HW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4826650, 18.0490356),


            (29, 'REF', 'VW', 'Reference', 'Zde nic není.', 49.4600547, 18.1374664),

            (29, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4325000, 18.0672167),

            (29, 'PAR', 'HW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4317500, 18.0635903),


            (30, 'REF', 'VW', 'Reference', 'Zde nic není.', 49.4564842, 18.1898769),

            (30, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4231333, 18.1956333),

            (30, 'PAR', 'HW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4242781, 18.2113681),


            (31, 'REF', 'VW', 'Reference', 'Zde nic není.', 49.4381006, 18.2659389),

            (31, 'FIN', 'HW', 'Umístění finálky', 'Zde se nachází keš.', 49.4703167, 18.2773500),

            (31, 'PAR', 'HW', 'Parkoviště', 'Zde můžete zaparkovat.', 49.4699497, 18.2777747),


            (32, 'REF', 'VW', 'Cíl', 'Místo cíle závodu BRAZDA 2016.', 49.4671494, 18.1633683);

COMMIT;
