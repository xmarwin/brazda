BEGIN;

COPY teams (team, team_type, name, shibboleth, description, is_active, team_status, tracking_allowed, telephone, email) FROM stdin;
1	ORG	BRAZDA	Mocn8Klika	Organizační tým	t	STR	t	\N	\N
2	COM	Přes mrtvoly	8Omerta.		t	STR	t	\N	\N
3	COM	Tři chlapi	Bajkonur3!		t	STR	t	\N	\N
4	COM	Perun s náma	5Hoříme?		t	STR	t	\N	\N
5	COM	Ušaté myši	Bééčka12!		t	STR	t	\N	\N
6	COM	BO!!!	4Banýk!!!		t	STR	t	\N	\N
7	COM	Ptakopysk	1Pterodaktyl.		t	STR	t	\N	\N
8	COM	KaNaVo	Wakata8!		t	STR	t	\N	\N
9	COM	Fantastické čtyřkY	Pentagon6.		t	STR	t	\N	\N
10	COM	Radegastova rota	2Rychlost?		t	STR	t	\N	\N
11	COM	Geokvočny	1Zeměřváč!		t	STR	t	\N	\N
12	COM	Hanáci	Montenegro4?		t	STR	t	\N	\N
13	COM	Čuňoši	Kolaloka?		t	STR	t	\N	\N
\.

SELECT pg_catalog.setval('teams_team_seq', 13, true);

COPY players (player, team, name) FROM stdin;
1	1	Hamstik
2	1	Krky
3	1	MonnieSPO
4	1	theo1024
5	1	xmarwin
6	2	Benjo5
7	2	Sinuhet
8	2	WiKoCZ
9	3	mara biker
10	3	Ekharon
11	3	h-Vipet
12	4	2pírko
13	4	Consolador
14	4	Wi-Li
15	4	?Perun?
16	5	kenod
17	5	markubz
18	5	janule90
19	5	patrick
20	6	Frenkonix
21	6	Stepan81
22	7	Apsalar
23	7	ZCh
24	7	soukmenovci
25	7	karlllik
26	8	Chillie-M
27	8	KaNaVo
28	8	MalyPlch
29	9	Kate.schumacher
30	9	Brumbambulinka
31	9	Asterix
32	9	Obelix
33	10	kačkafibi
34	10	Cholísektom
35	10	Yoki X
36	10	Yoki XY
37	10	xfibi
38	11	Yoki5
39	11	mamča
40	11	Kačka fibi
41	11	1. yokiholka
42	11	2. yokiholka
43	12	Robiczech
44	12	Pekyesp
45	12	Macistfman
46	12	DuffKrabica
47	13	morsky_konik
48	13	sotlinka
49	13	XiXao02
\.

SELECT pg_catalog.setval('players_player_seq', 49, true);

COPY posts (post, post_type, color, name, max_score, difficulty, terrain, cache_size, cache_type, shibboleth, with_staff, hint, help, description, bonus_code, open_from, open_to, latitude, longitude) FROM stdin;
1	BEG	TRA	Start	0	1	1	O	\N	Hybaj	t	\N		<p><strong>Vítejte na startu závodu BRAZDA 2016</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>\n                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>	\N	\N	\N	49.4671493999999967	18.1633682999999984
2	ACT	RED	Transport	150	2.5	2.5	O	\N	Dánsko	t			<p>Aktivita, která prověří vaši logiku, obratnost i vytrvalost. Může se hodit ručník a plavky.</p>	\N	\N	\N	49.4204853000000028	183181772
3	ACT	RED	Klíčová pakárna	100	2	3.5	O	\N	král	t			<p>Aktivita, která prověří vaši sílu a vytvalost. Hodí se dobré boty.</p>	\N	\N	\N	49.4840007999999969	18.0407717000000005
4	ACT	RED	Přepravky	150	2	4	O	\N	trn	t			<p>Aktivita, která prověří vaši odvahu a obratnost na hranice mezí. Vlastní sedák může být výhoda.</p>	\N	\N	\N	49.4269000000000034	17.9922000000000004
5	ACT	RED	Titanic	130	3	5	O	\N	jelen	t			<p>Aktivita, která prověří váš důvtip a vytrvalost. Ručník a plavky budou potřeba.</p>	\N	\N	\N	49.4243055999999967	18.025694399999999
6	ACT	BLU	Špionáž	150	3	2	O	\N	červená	f	Za dřevěnou nástěnkou		<p>Aktivita, která prověří vaši všímavost a důvtip. Nutnost zařízení, které umí přečíst QR kódy.</p>	\N	\N	\N	49.3910499999999999	17.9634833
7	ACT	YEL	Váhy	100	4	1	O	\N	3,14159	t			<p>Aktivita, která prověří váši inteligenci a důvtip. Jak to uděláte je opravdu na vás.</p>	\N	\N	\N	49.4348644000000021	18.2533157999999993
8	ACT	RED	Mozaika	90	3	1.5	O	\N	zub	t			<p>Aktivita, která prověří vaši inteligenci a představivost. Chce to jen čas.</p>	\N	\N	\N	49.4486153000000002	18.1931350000000016
9	CIP	BLU	Morseovka	100	5	1	O	\N	magnituda	f	Za památníkem	Záleží na úhlu pohledu	<p>Co by to byl za závod, kdyby na něm nebyla aspoň jedna šifra v morseovce. Nebo ne?</p>	\N	\N	\N	49.4064167000000012	18.0722805999999991
10	CIP	BLU	Křížovka	60	2.5	2	O	\N	mercedes	f	Mezi koulema	Do třetice všeho dobrého	<p>Vcelku jednoduchá šifra na dobře známém základě.</p>	\N	\N	\N	49.4356500000000025	18.0958332999999989
11	CIP	BLU	Housenka	80	2.5	2	O	\N	gymnastika	f	Pod kamenem, cca 15m od cesty	Semafor	<p>Ne až tak náročná šifra, jen na to přijít.</p>	\N	\N	\N	49.5033999999999992	18.2776333000000015
12	CIP	BLU	Trajektorie	60	3	1.5	O	\N	letohrádek	f		Mapa	<p>Ne až tak složitá šifra, chce to jen trochu představivosti.</p>	\N	\N	\N	49.4634332999999984	18.1489167000000009
13	CIP	BLU	Šipky	120	4	1	O	\N	rudá	f	Za rezavou boudou	Tetris	<p>Poměrně náročná a pracná šifra, ale ono to na konec vždycky nějak jde.</p>	\N	\N	\N	49.4679167000000035	18.0905333000000006
14	CIP	YEL	Tunel	80	2	2.5	O	\N	horor	f		Uwe Filter	<p>Vcelku nenáročná šifra v tunelu, jen si na ni posvítit. Pokud je víc vody, hodí se gumáky. Šifra je v nejtemnější části.</p>	\N	\N	\N	49.4549378000000033	18.1276106000000006
15	CIP	YEL	Substituce	90	2	2.5	O	\N	tréning	f	Na čerstvém pařezu		<p>Šifra jejíž luštění není až tak náročné mentálně jako spíš fyzicky. Během jejího luštění se tým může kvůli efektivitě rozdělit.</p>	\N	\N	\N	49.4018999999999977	17.9757832999999998
16	CGC	BLU	Trigonometrická	110	4	2	R	MYS	žid	f	Všechny stage: sloupy el. vedení, Final: visí		<p>Trigonometrie (z řeckého <em>trigonón</em> - trojúhelník a <em>metrein</em> - měřit) je oblast goniometrie zabývající se použitím goniometrických funkcí při řešení úloh o trohúhelnících. Trigonometrie má základní význam při triangulaci, která se používá k měření vzdáleností mezi dvěma hvězdami, v geodézii k měření vzdálenosti dvou bodů a v satelitních navigačních systémech.</p>\n\t\t\t\t<p>První poznatky z trigonometrie lze prokázat již u Egypťanů. Podobné znalosti měli také Babyloňané a Chaldejci, od kterých převzali Řekové dnešní dělení plného úhlu na 360° a stupně na 60 minut. První práce o trigonometrii souvisely s problémem určení délky tětivy vzhledem k velikosti úhlu. První tabulky délek tětiv pocházejí od řeckého matematika Hipparcha z roku 140 př. n. l., další tabulky sepsal zhruba o 40 let později Melenaus, řecký matematik žijící v Římě. Práce starořeckých vědců vyvrcholila Ptolemaiovým dílem Megale syntaxis (Velká soustava), v níž Ptolemaios vypočítal tabulku délek tětiv kružnice, jež měla poloměr až 60 délkových jednotek a kde středový úhel, k němuž se délky vztahovaly, postupoval po 0,5°.</p>\n\t\t\t\t<p>Od 5. století začali pak trigonometrii budovat Indové, od kterých pochází dnešní název pro sinus, a po nich vědci Střední Asie a Arabové. Z Indů se trigonometrii nejvíce věnoval Brahmagupta (7. století), z vědců Střední Asie a Arábie je pak třeba vzpomenout syrského astronoma al-Battáního.</p>\n\t\t\t\t<p>Evropa se s trigonometrií seznámila díky západním Arabům. K rozvoji trigonometrie významně přispěl polský astronom Mikuláš Koperník, stejně tak i francouzský matematik François Viète, který představil kosinovou větu v trigonometrické podobě. Dnešní podobu trigonometrie jakožto vědu o goniometrických funkcích ve svém díle Introductio in analysin infinitorum (Úvod do analýzy) vytvořil Leonhard Euler. Poprvé zkoumal hodnoty sin x, cos x jako čísla, nikoli jako úsečky, a jako hodnoty proměnné připouštěl kladná i záporná čísla.</p>\n\t\t\t\t<p>Nejvýznamnější a technologicky nejvyspělejší aplikací trigonometrie v současnosti patří jednoznačně satelitní navigační systémy, které pracují právě na principech sférické trigonometrie s využitím znalosti efemerid družicového pole a přesného času, kdy z rozdílu mezi přijetím stejného času lze dopočítat vzdálenost k družici, která jej vyslala a díky znalostí poloh alespoň tří (v praxi však více) družic dopočítat vlastní pozici na kulové ploše.</p>\n\t\t\t\t<p>Po vás nic tak složitého chtít nebudeme, nicméně pro nález krabičky budete potřebovat nějakým způsobem trigonometrii ať již v algebraické, nebo geometrické podobě použít. Na jednotlivých stagích najdete vzdálenost od keše. Vše ostatní je na vás.<p>	\N	\N	\N	49.4647999999999968	17.9966000000000008
17	CGC	GRN	Plotny	150	2	5	S	TRA	láska	f	Visí		<p>"Co by to bylo za pořádný geozávod, kdyby na něm nebyla alespoň jedna T5ka!" řekli jsme si při přípravě. V tomto případě je jí skála, na kterou bude potřeba vylézt. Zcela jistě budete potřebovat lezeckou výbavu.</p>	\N	\N	\N	49.4692885999999987	18.1769135999999989
18	CGC	GRN	Můstek	80	1.5	3	R	TRA	zvon	f			<p>Vydejte se na malou procházku do udržovaného lesíku a objevte dávno zapomenutý poklad. Časy jeho slávy připomíná už jen torzo a těžko říct, kolik pamětníků je ještě mezi námi.</p>\n\t\t\t\t<p>Můstky dříve rostly jako houby po dešti; dvaceti či třicetimetrové můstky měla každá třetí horská obec, i když se na nich konaly třeba jen dva závody. Před 2. světovou válkou bylo na území ČR více než 220 můstků, ve zlatém věku na přelomu 50. a 60. let autoři napočítali dokonce 270 můstků.</p>\n\t\t\t\t<p>V blízkosti se nachází Ski areál. Ski areál Búřov leží v malebné vesnici Valašská Bystřice, v samotném srdci Beskyd, 7 km od Rožnova pod Radhoštěm.</p>\n\t\t\t\t<p>Areál je vhodný pro začínající i pokročilé lyžaře, ideální pro lyžařské kurzy. Náš areál často navštěvují také snowboardisté, pro které máme zřízen snowpark.</p>\n\t\t\t\t<p>Nadmořská výška vleků je 500 – 620 m.n.m.</p>	\N	\N	\N	49.408533300000002	18.1065666999999983
19	CGC	YEL	Pod Mísnú	80	2	3.5	R	MLT	svatozář	f	Nahoře krytá před deštěm		<h2>Pod Mísnú</h2>\n                <p>Když se podíváte na mapu do místa známého jako Zákopčí (nebo Za Kopcem), jinak místní části Hutiska-Solanec, všimnete si pojmenování Pod Mísnou a to hned na několika různých místech. Ovšem žádný kopec s názvem Mísná na mapě neuvidíte. Hluboké údolí Zákopčí se kousek za památníkem Charlotte Garrigue-Masaryk u školy v přírodě (rekreačního střediska Hutisko-Solanec) dělí na dvě části, jedním protéká Hutiský potok a druhým potok Mísná. Podél Hutiského potoka vede zelená turistická značka, která končí na Vsacké Tanečnici (912 m n.m.). My se však vydáme proti proudu potoka Mísná do druhého, zapadlejšího údolí.</p>\n                <h3>Výchozí souřadnice - Stage 1</h3>\n                <p>Svá geovozidla prosím zanechte na doporučeném parkovišti, parkovat na točně autobusu u rekreačního střediska opravdu není dobrý nápad a pokračovat dále autem je nejen že dopravním značením zapovězené, ale mohli byste se se zlou potázat. Místní jsou všímaví a nekompromisní. Ale než se vydáme dále, povšimněte si památníku před rekreačním střediskem napravo. Památník byl postaven při příležitosti otevření školy, jsou na něm vyobrazeny dvě děti, ukazující na bustu T.G. Masaryka a z boku je vyvedený nápis. Nápis si dobře přečtěte a spočítejte počet slov (=<strong>A</strong>).</p>\n                <h3>Výpočet pro Stage 2</h3>\n                <p><strong>N 49°25,(A*25+5)<br>\n                E 018°11,(A*29+3)</strong></p>\n                <p>Máte spočítáno? Tak můžeme vyrazit na druhou zastávku procházky. Cestou si všimněte chalup a stavení roztroušených v údolí a po stráních. Některé jsou trvale obydlené, jiné slouží jako chaty pro sezonní bydlení. Pokud jste trefili správnou cestu a nepřepočítali se hned na začátku, došli jste ke studánce, kde se můžete občerstvit (ale neručím za pitnost vody). Naproti studánce, mezi dvěma lipami a kaštanem, stojí kříž s Kristem. Očividně již má něco za sebou, ale když si ho dobře prohlédnete, objevíte letopočet, který si zapište (=<strong>BCDE</strong>).</p>\n                <h3>Výpočet pro Stage 3</h3>\n                <p><strong>N 49°24,(C-B)(A-D)(D+E-C)<br>\n                E 018°10,(D-B)(D-A)(E)</strong></p>\n                <p>Jednoduchý výpočet jste jistě zvládli a můžeme tak pokračovat dále. Pokud jste se rozhodli absolvovat trasu na kole, teď se asi zapotíte, ale na Valašsku to ani jinak nejde. Ještě než dojdete k další zastávce, otevřou se výhledy do okolí a můžete se začít kochat panoramaty. Nejlepší výhledy jsou asi přímo od druhého kříže s vyobrazením Krista a mohutné lípy, která stojí hned vedle. Můžete si zde sednout na lavičku, odpočinout si a pokochat se rozhledy. Krásně je vidět hřeben Čertova Mlýna napravo a Radhoště nalevo. Až se pokocháte výhledem, všimněte si louky pod vámi, kde rostou jalovce a množství chráněných rostlin, možná i orchidejí (což nemám ověřeno, ale na okolních lokalitách se vyskytují). Pak se vraťe ke kříži a všimněte si plechového oblouku stříšky nad křížem. Určete jeho barvu a pořadí barvy v barvách duhy (červená=1 až fialová=6) je poslední indicie pro výpočet finálky (=<strong>F</strong>).</p>\n                <h3>Výpočet pro Finále</h3>\n                <p><strong>N 49°24,(D)(B)(A)<br>\n                E 018°10,(F)(B)(D+B)</strong></p>\n                <p>Ještě než se vydáte ke keši, tak jak je to teda s tou Mísnou? Když budete pokračovat po cestě dále, dostanete se až na hřeben mezi Hážovskými díly a Vsackou Tanečnicí a tam někde na modré turistické značce najdete rozcestí Mísná.</p>	\N	\N	\N	49.4187500000000028	18.2014999999999993
20	CGC	YEL	Kání	70	1.5	4	R	TRA	olympiáda	f			<h3>O místě</h3>\n\t\t\t\t<p>Kání je výrazný kopec, který se tyčí do výšky 666m nad mořem nad obcí Hutisko-Solanec. Po přerušení Solaneckým potokem jím pokračuje jižní hřeben údolí Rožnovské brázdy, který se táhne od kopce Brdo nad Valašským Meziříčím a končí kopcem Beskyd na Česko-Slovenském pomezí poblíž Bumbálky.</p>\n\t\t\t\t<p>Vede přes něj modrá turistická značka, která z Hutiska-Solance stoupá právě na tomto kopci na hřeben, po kterém přes Kýnačky a Hluboký vede až k rozcestí Na Západí, kde se k ní připojuje zelená turistická značka od Zavadilky. Přes Jezerné pod Kotlovu pak vede dále na Benešky, Polanu, Vysokou a přes Třeštík až na zmíněý Beskyd. Je to jedna z nejkrásnějších tras v této části Beskyd, ze které je řada krásných výhledů jak do údolí Rožnovské tak do údolí Vsetínské Bečvy. Tato trasa je velmi oblíbená nejen mezi pěšímí, ale cyklo turisty</p>\n\t\t\t\t<p>Kousek pod vrcholem kopce Kání stojí i retranslační a základová stanice s dobře viditelným vysílačem. Pod vrcholem je několik chalup, ke kterým se dostat ale není vůbec jednoduché. Ostatně při cestě ke keši to poznáte sami.</p>\n\t\t\t\t<h3>O Keši</h3>\n\t\t\t\t<p>Keš samotná je pověšena na stromě nedaleko vysílače, není to žádné supertěžké stromolezení, ale zadarmo to taky nebude. Místo však rozhodně stojí za návštěvu.</p>	\N	\N	\N	49.4201163999999977	18.2359644000000003
21	CGC	RED	Kostel sv. Zdislavy	30	2	2	R	TRA	strom	f	Pod čepičkou		<p>Obec Prostřední Bečva leží ve východní části Radhošťské hornatiny a Vsetínských vrchů v nadmořské výšce 430 m.n.m. Byla donedávna jedna z mála okolních obcí, která neměla svůj vlastní kostel.</p>\n                <p>Dne  23.&thinsp;května 1998 vznikla Kostelní jednota sv. Zdislavy, jejíž členové začali usilovat o&nbsp;výstavbu nového kostela. V&nbsp;roce 1999 začali členové této jednoty vybírat finanční prostředky na jeho výstavbu. Dřevo na výstavbu bylo darováno, obec poskytla pozemek, věřící darovali potřebnou finanční částku a některé z vybavení kostela.</p>\n                <p>Stavba byla zahájena dne 11. července roku 2000 a trvala jeden rok. Výsledkem stavby byl pěkný moderní kostel, ke kterému vás přivede tato keška. Při odlovu si počínejte opatrně v případě mudlů v okolí.</p>	\N	\N	\N	49.4399500000000032	18.2480499999999992
22	CGC	YEL	Nořičí trail 1	60	2	2.5	R	TRA	záchrana	f	Pata stromu		<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>\n                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>	\N	\N	\N	49.4969499999999982	18.2790832999999999
23	CGC	YEL	Nořičí trail 2	60	2	2.5	R	TRA	objezd	f	Za kamenem		<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>\n                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>	\N	\N	\N	49.5114166999999981	18.2777999999999992
24	CGC	GRN	Nořičí trail 3	60	2	2.5	R	TRA	oběh	f	Zezadu cedule		<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>\n                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>	\N	\N	\N	49.5083167000000017	18.2653329999999983
25	CGC	GRN	Nořičí trail 4	60	2	2.5	R	TRA	infarkt	f	Smrček		<p><strong>Noříčí trail</strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>\n                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno</strong> (80 kč/den)!</p>	\N	\N	\N	49.4991500000000002	18.2725833000000009
26	CGC	GRN	Kostel sv. Antonína Paduánského	40	2	1.5	R	TRA	trumf	f	Zespodu, magnet		<p>Kostel sv. Antonína Paduánského byl postaven 1906 stavitelem Ing. Aloisem Pallatem z Olomouce. Nachází se ve středu obce Dolní Bečva, v blízkosti lipové aleje Hynka Tošenovského. Základní kámen byl posvěcen  24.září 1905 Antonínem C. Stojanem.</p>\n                <p>Patronem  kostela byl zvolen sv. Antonín Paduánský. Kostel byl požehnán v roce 1907. Jeho délka je 28 metrů, šířka 9,5 metrů a jeho věž je vysoká 37 metrů. Byl postaven v novorománském slohu.</p>\n                <h3>Ke keši</h3>\n                <p>Keš se nachází na poměrně frekventovaném místě, proto prosím s odlovem počkejte, dokud nebude oblast vylidněná. K odlovení keše není potřeba nic rozhrabávat, ani ničit. </p>	\N	\N	\N	49.4561832999999993	18.1923500000000011
27	CGC	GRN	Lom Kněhyně	100	3	3	O	ERT	zlato707	f	Stage 2: 6m pod betonovým sloupkem, dvířka nad vodou		<h2>Lom Kněhyně</h2>\n\t\t\t\t<p>Významnou geologickou lokalitu představuje opuštěný, částečně zasutěný stěnový kamenolom v katastru obce Prostřední Bečva na jihozápadním úpatí Kněhyně (1 257 m n.m.). Lom se nachází ve vzdálenosti asi 4,5 km od obce, vpravo od silnice z Prostřední Bečvy na Pustevny. Přístupová cesta odbočuje v první z ostrých zatáček na začátku stoupání této silnice ve směru na Pustevny. Lomovou stěnou jsou zastiženy křídové sedimenty středního a svrchního oddílu godulského souvrství (cenoman až senon), budujícího hlavní hřebeny Beskyd a představujícího současně nejmocnější člen (přes 3 000 m) slezské jednotky.<br>\n\t\t\t\tSlezská jednotka je příkrov flyšového pásma Západních Karpat a z větší části tvoří Moravskoslezské Beskydy a podbeskydskou pahorkatinu. Slezská jednotka zahrnuje juru až oligocén a dělí se na dílčí příkrov těšínský (nižší) a godulský (vyšší). A právě část souvrství godulských vrstev je možné pozorovat v lomu v Kněhyni.</p>\n\t\t\t\t<p>Horniny středního oddílu godulského souvrství jsou jen menším podílem zastoupeny v jihozápadní části lomu. Představují hrubě rytmický flyš s převahou světle zelenavě šedých, silně lavicovitých, hrubě až středně zrnitých glaukonitických pískovců, vytvářejících polohy o mocnosti až několika desítek metrů. Na bázi silnějších lavic s gradačním zvrstvením se lokálně vyskytují drobně zrnité slepence a slepencové, vzácněji i arkózové pískovce.<br>\n\t\t\t\tHorniny svrchního oddílu godulského souvrství jsou rozšířené v severovýchodní části odkryvu. Litologicky odpovídají výše popsaným sedimentům, pro něž je typické rychlé snižování prachovcovo-pískovcových poloh a jejich celkové ztenčování. Mnohem častější je současně rychlé proužkovité střídání šedých a zelených, někdy až tmavošedě skvrnitých jílovců.</p>\n\t\t\t\t<h3>Flyš</h3>\n\t\t\t\t<p>V sedimentologii se tak nazývá komplex vrstev mořského původu, nejméně 500m mocný, tvořený z rytmicky zvrstvených a střídajících se klastických sedimentů, jevících často pozitivní gradační zvrstvení (od větších zrn sedimentární horniny k jemnějším). Na spodních plochách pískovců se často objevuji velice hojné hieroglyfy (nerovnost vrstevních ploch). Svým složením se flyš blíží uloženinám některých hlubokomořských delt a byl ukládán při úpatí příkrých podmořských srázů (například na kontinentálním úpatí) a na jeho vzniku se významnou měrou podílely takzvané turbiditní proudy (gravitační toky). Pozice flyše v pánvi proto rozhoduje o jeho složení.<br>\n\t\t\t\tV tektonickém pojetí se jedná o sedimenty ukládané v období uzavírání geosynklinál za tektonicky nestabilních a silně seizmických podmínek.<br>\n\t\t\t\tZ horninového hlediska je flyš složený ze slepenců, pískovců a jílovců.</p>\n\t\t\t\t<h3>Kameny zblízka</h3>\n\t\t\t\t<p>Na plochách některých kamenů je možné spatřit nerovnosti, způsobené buď mechanicky, takzvané mechanoglyfy (proudy, vtisky, čeřiny nebo stopy vlečení) a nebo biologicky, takzvané bioglyfy (stopy po lezení a vrtání organismů). Tyto stopy vznikly v době usazování hornin na mořském dně.</p>\n\t\t\t\t<h3>Jak na keš?</h3>\n\t\t\t\t<p><strong>Pro uznání logu musíte absolvovat několik úkolů</strong></p>\n\t\t\t\t<ul>\n\t\t\t\t\t<li>Na výchozích souřadnicích stojíte před stěnou lomu a vedle vás leží na zemi několik velkých kamenů, z nichž jeden vypadá jako obrazovka televize (viz Úkol 1). Změřte průměrné rozměry kamene (měřte vždy uprostřed strany) a spočítejte, kolik kámen váží (v kg), když víte, že se jedná o pískovec (do závorky napište, jakou objemovou hmotnost jste uvažovali). </li>\n\t\t\t\t\t<li>Dále se podívejte na stěnu lomu před vámi a uvidíte dole uprostřed vykukovat ze sutě několik vrstev flyše (viz Úkol 2 a 3). Běžte ke skále a zaměřte se na nejsilnější vrstvu pískovce (asi ve výšce hlavy, když stojíte uprostřed). Změřte tloušťku vrstvy a zaokrouhlete na desítky centimetrů. A hned změřte i tmavou tenkou vrstvu pod ní a zaokrouhlete na celé centimetry. Jestli jste měřili správně, tak si hned všimnete, že tloušťka obou vrstev má zajímavou souvislost. Jako odpověď pošlete obě změřené tloušťky.</li>\n\t\t\t\t\t<li>U tenčí vrstvy se ještě zdržíme, určete o jakou horninu se jedná (pomůže listing) a napište, čím se hlavně liší od pískovce nad ní (kromě barvy).</li>\n\t\t\t\t\t<li>Nyní se otočte zády ke stěně lomu a přímo před vámi našikmo leží velký šedý kámen se stopami bioglyfů (viz. Úkol 3). Změřte průměrnou šířku těchto stop v centimetrech.</li>\n\t\t\t\t\t<li>Za posledním úkolem se vydejte na souřadnice Stage 2. Terén bude poněkud komplikovanější (tak T4) a najděte zajímavý objekt vytvořený člověkem (nachází se asi 6m po svahu pod betonovým sloupkem (viz. Fotohint stage 2). Napište, k čemu dle vašeho názoru objekt sloužil a jaký číslený údaj v kg jste na něm objevili.</li>\n\t\t\t\t</ul>\n\t\t\t\t<p>Jako dobrovolný úkol přidejte k logu fotografii z lomu, ať už stěny lomu s rytmickými vrstvami flyše a nebo kamenů, které vás zaujaly. Prosím nepřikládejte k logu fotografie ze Stage 2!</p>\n\n\t\t\t\t<h3>Splnění úkolu a zadání hesla pro závod BRAZDA 2016</h3>\n\t\t\t\t<p>Musíte <strong>splnit úkol č. 2</strong>. to je změřit tloušťku dvou vrstev v lomu.<br>\n\t\t\t\tDostanete <strong>dvě čísla</strong> v centimetrech ve formátu <strong>X0</strong> a <strong>Y</strong>. Na <strong>stage 2 najdete indícii</strong>. Heslo <strong>pro splnění stanoviště</strong> zadáte do herní aplikace ve formátu "<strong>indicieX0Y</strong>".</p>\n\t\t\t\t<p>Příklad: V lomu změříte a zaokrouhlíte tloušťku větší vrstvy na 50cm a menší na 8cm. Na stage 2 objevíte indícii "potok". Heslo pro splnění stanoviště pak bude "potok508".</p>\n\t\t\t\t<p>Odpovědi posílejte pouze přes profil a logovat můžete hned po odeslání. Když budou odpovědi nedostatečné, budu vás kontaktovat. Bez zaslaných odpovědí logy mažu.</p>\n\n\t\t\t\t<h3>Zdroje</h3>\n\t\t\t\t<ul>\n\t\t\t\t\t<li>http://www.geology.cz</li>\n\t\t\t\t\t<li>http://pruvodce.geol.morava.sci.muni.cz/Prostredni_Becva/Knehyne_text.htm</li>\n\t\t\t\t\t<li>http://geologie.vsb.cz/reg_geol_cr/10_kapitola.htm</li>\n\t\t\t\t</ul>	\N	\N	\N	49.4810549999999978	18.2842500000000001
28	BON	GRN	Zelený bonus	150	2	3	R	TRA	hypochondr	f	Kořeny		<p>Tento bonus vás zavede na pěkné místo :)</p>	srdce	\N	\N	49.467655299999997	18.0427093999999997
29	BON	BLU	Modrý bonus	150	2.5	2.5	R	TRA	mlhovina	f	Visí 30cm nad zemí		<p>Tento bonus vás zavede na pěkné místo, ale dostat se tam není zas tak jednoduché.</p>	hvězda	\N	\N	49.4600547000000006	18.137466400000001
30	BON	YEL	Žlutý bonus	150	2	3	R	TRA	orbital	f	Oběšená na menším z dvojstromu		<h2>Díly</h2>\n\t\t\t\t<p>Na Valašsku a v okolí Rožnova jsou Díly poměrně častý název kopce. Obvykle je pozůstatkem po první pasekářské kolonizaci údolí Rožnovské Bečvy, kdy jednotlivé části krajiny byly přidělovány osadníkům a každý tak dostal svůj díl. Obvykle se země rozdělovala tak, že od cest vedených obvykle postředkem údolí v blízkosti vodních toků byly vyčleňovány úzké pruhy země směrem nahoru k hřebenům nad údolím. V některých (především jižních) částech obcí v Hutiském údolí je tato struktura patrná dodnes v rozmístění budov. Dnes však již hospodaříme s krajinou jinými způsoby a tak lze podobné rozdělení vysledovat stále řídčeji</p>\n\t\t\t\t<h3>O Keši</h3>\n\t\t\t\t<p>Kterých dílů se naše povídání týká, zda-li Zuberských, Tylovských, Hažovských Vingantských, nebo Hutiských vám však neprozradíme. Na to budete muset ze žlutých indicií zjistit správné heslo pro odemčení tohoto bonusu. Hodně štěstí při jejich získávání i při dedukci hesla.</p>	kruh	\N	\N	49.4564841999999985	18.1898769000000016
31	BON	RED	Červený bonus	150	2	2.5	R	TRA	bitcoin	f	Visí na malém smrčku na vyvráceném pařezu nad vodou		<h2>Sklářství na Valašsku</h2>\n                <p>Od poloviny devatenáctého století se datuje rozmach sklářského průmyslu na Valašsku a je spojován s firmou S.REICH. Firma si pronajala od panství Valašské Meziříčí - Rožnov sklárnu Františčina Huť ve Velkých Karlovicích, poté v roce 1855 zahájila provoz ve své největší sklárně v Krásně ve Valašském Meziříčí, dále od roku 1861 začala provozovat Mariánskou Huť ve Velkých Karlovicích, v roce 1862 otevřela sklárnu Karolinina Huť v Novém Hrozenkově. Dozvuky tohoto rozmachu jsou patrné i dnes, sklárny stále fungují v Karolince a tradice výroby skla dodnes přetrvává i ve Valašském Meziříčí.<br>\n                Ovšem ještě před industrializací sklářské výroby a vzniku velkých skláren, existovaly na Valašsku malé hutě, jejichž vznik je datován do 15. až 16. století. Do dnešních dní se po nich nedochovalo více, než názvy obcí a místních částí. Jednou z obcí, jejíž historie je spojena se sklářskými hutěmi je Hutisko-Solanec. Sklárny byly na místě Hutiska založeny v první polovině 17. století, samotná osada vznikla později, po roce 1656 (roku 1666 byla prohlášena za obec). V první polovině 18. století byla huť z Hutiska přesunuta jinam.</p>\n                <h3>Zdroje</h3>\n                <ul>\n                    <li>http://www.obeliskval.cz</li>\n                    <li>http://www.sreich.cz</li>\n                    <li>http://www.lesycr.cz/volny-cas-v-lese/naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>\n                    <li>http://www.lesycr.cz/volny-cas-v-lese/:w\n                    naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>\n                </ul>\n	koruna	\N	\N	49.4381005999999985	18.2659388999999983
32	END	TRA	Cíl	0	1	1	O	\N	Finito	t	\N		<p><strong>Gratulejeme k dokončení závodu BRAZDA 2016</strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>\n                <p><strong>Uvidíme se zde</strong> opět <strong>v 18.30</strong>, kdy závod končí.</p>	\N	\N	\N	49.4671493999999967	18.1633682999999984
\.

SELECT pg_catalog.setval('posts_post_seq', 32, true);

COPY waypoints (waypoint, waypoint_type, waypoint_visibility, post, name, description, latitude, longitude) FROM stdin;
1	REF	VW	1	Start	Místo startu závodu BRAZDA 2016.	49.4671493999999967	18.1633682999999984
2	REF	VW	2	Aktivita	Místo, kde probíhá aktivita.	49.4197561000000007	18.3181772000000009
3	PAR	VW	2	Parkoviště	Zde můžete zaparkovat.	49.4204853000000028	18.3190355999999994
4	REF	VW	3	Aktivita	Místo, kde probíhá aktivita.	49.4840007999999969	18.0407717000000005
5	PAR	VW	3	Parkoviště	Zde můžete zaparkovat.	49.4844000000000008	18.0416835999999989
6	REF	VW	4	Aktivita	Místo, kde probíhá aktivita.	49.4269000000000034	17.9922000000000004
7	PAR	VW	4	Parkoviště	Zde můžete zaparkovat.	49.4357232999999994	18.0174860999999993
8	REF	VW	5	Aktivita	Místo, kde probíhá aktivita.	49.4243055999999967	18.025694399999999
9	PAR	VW	5	Parkoviště	Zde můžete zaparkovat.	49.4248333000000031	18.024944399999999
10	REF	VW	6	Aktivita	Místo, kde začíná aktivita.	49.3910499999999999	17.9634833
11	PAR	VW	6	Parkoviště	Zde můžete zaparkovat.	49.3913166999999973	17.9632666999999984
12	FIN	HW	6	Umístění řešení úkolu	Zde jste dokončili celou aktivitu.	49.3911166999999978	17.9633000000000003
13	REF	VW	7	Aktivita	Místo, kde probíhá aktivita.	49.4348644000000021	18.2533157999999993
14	PAR	VW	7	Parkoviště	Zde můžete zaparkovat.	49.4350894000000025	18.2530488999999996
15	REF	VW	8	Aktivita	Místo, kde probíhá aktivita.	49.4486153000000002	18.1931350000000016
16	PAR	VW	8	Parkoviště	Zde můžete zaparkovat.	49.4485394000000014	18.1929955999999997
17	REF	VW	9	Šifra	Místo, kde najdete šifru.	49.4064167000000012	18.0727000000000011
18	PAR	VW	9	Parkoviště	Zde můžete zaparkovat.	49.406089399999999	18.0722805999999991
19	REF	VW	10	Šifra	Místo, kde najdete šifru.	49.4356500000000025	18.0958332999999989
20	PAR	VW	10	Parkoviště	Zde můžete zaparkovat.	49.4410256000000032	18.0971328000000007
21	REF	VW	11	Šifra	Místo, kde najdete šifru.	49.5033999999999992	18.2776333000000015
22	PAR	VW	11	Parkoviště	Zde můžete zaparkovat.	49.4847166999999999	18.2644167000000017
23	REF	VW	12	Šifra	Místo, kde najdete šifru.	49.4634332999999984	18.1489167000000009
24	PAR	VW	12	Parkoviště	Zde můžete zaparkovat.	49.4640167000000019	18.1489332999999995
25	REF	VW	13	Šifra	Místo, kde najdete šifru.	49.4679167000000035	18.0905333000000006
26	PAR	VW	13	Parkoviště	Zde můžete zaparkovat.	49.4676472000000018	18.0906957999999989
27	REF	VW	14	Vstup do tunelu	Místo, kde najdete šifru. Hledejte v temné části mezi zatáčkama.	49.4549378000000033	18.1276106000000006
28	PAR	VW	14	Parkoviště 1	Zde můžete zaparkovat.	49.4529568999999967	18.1309833000000005
29	PAR	VW	14	Parkoviště 2	Zde můžete zaparkovat.	49.4577918999999966	18.1276575000000015
30	REF	VW	15	Šifra	Místo, kde najdete šifru.	49.4018999999999977	17.9757832999999998
31	PAR	VW	15	Parkoviště	Zde můžete zaparkovat.	49.4000167000000019	17.965166700000001
32	STA	VW	16	1. stage	Zde zjistíte část indicí.	49.4647999999999968	17.9966000000000008
33	STA	VW	16	2. stage	Zde zjistíte další část indicií.	49.4631167000000005	18.0036500000000004
34	STA	VW	16	3. stage	Zde zjistíte posleldní část indicií.	49.4731667000000002	17.9943999999999988
35	PAR	VW	16	Parkoviště u 1. stage	Zde můžete zaparkovat.	49.4641019000000028	17.9954071999999989
36	PAR	VW	16	Parkoviště u 2. stage	Zde můžete zaparkovat.	49.4631064000000009	18.0045214000000016
37	PAR	VW	16	Parkoviště u 3. stage	Zde můžete zaparkovat.	49.4732878000000014	17.9914455999999987
38	FIN	HW	16	Umístění finálky	Zde se nachází keš.	49.4670332999999971	17.9991832999999986
39	FIN	VW	17	Umístění finálky	Zde se nachází keš.	49.4692885999999987	18.1769135999999989
40	PAR	VW	17	Parkoviště	Zde můžete zaparkovat.	49.4687539000000029	18.1777571999999985
41	FIN	VW	18	Umístění finálky	Zde se nachází keš.	49.408533300000002	18.1065666999999983
42	PAR	VW	18	Parkoviště	Zde můžete zaparkovat.	49.4042667000000009	18.1047332999999995
43	STA	VW	19	Stage 1	Busta T.G. Masaryka s nápisem na boku. Počet slov na nápisu = A	49.4187500000000028	18.2014999999999993
44	STA	HC	19	Stage 2	Kříž a studánka. Letopočet na kříži = BCDE	49.4196667000000005	18.18675
45	STA	HC	19	Stage 3	Kříž pod lípou. Určete pořadí barvy stříšky nad křízem v pořadí barev duhy (červená = 1 až fialová = 6) = F	49.4133332999999979	18.1767000000000003
46	FIN	HW	19	Umístění finálky	Zde se nachází keš.	49.4119499999999974	18.1753
47	PAR	VW	19	Parkoviště	Zde můžete zaparkovat.	49.4191332999999986	18.2021666999999994
48	FIN	VW	20	Umístění finálky	Zde se nachází keš.	49.4201163999999977	18.2359644000000003
49	PAR	VW	20	Parkoviště	Zde můžete zaparkovat.	49.4211236000000014	18.2233143999999996
50	FIN	VW	21	Umístění finálky	Zde se nachází keš.	49.4399500000000032	18.2480499999999992
51	PAR	VW	21	Parkoviště	Zde můžete zaparkovat.	49.4396832999999987	18.2476333000000004
52	FIN	VW	22	Umístění finálky	Zde se nachází keš.	49.4969499999999982	18.2790832999999999
53	PAR	VW	22	Parkoviště	Zde můžete zaparkovat.	49.4847166999999999	18.2644167000000017
54	FIN	VW	23	Umístění finálky	Zde se nachází keš.	49.5114166999999981	18.2777999999999992
55	PAR	VW	23	Parkoviště	Zde můžete zaparkovat.	49.4847166999999999	18.2644167000000017
56	FIN	VW	24	Umístění finálky	Zde se nachází keš.	49.5083167000000017	18.2635332999999989
57	PAR	VW	24	Parkoviště	Zde můžete zaparkovat.	49.4847166999999999	18.2644167000000017
58	FIN	VW	25	Umístění finálky	Zde se nachází keš.	49.4991500000000002	18.2725833000000009
59	PAR	VW	25	Parkoviště	Zde můžete zaparkovat.	49.4847166999999999	18.2644167000000017
60	FIN	VW	26	Umístění finálky	Zde se nachází keš.	49.4561832999999993	18.1923500000000011
61	PAR	VW	26	Parkoviště	Zde můžete zaparkovat.	49.4567499999999995	18.1929167000000014
62	STA	VW	27	Stage 1 - Lom Kněhyně	Zde nadete odpovědi na otázky 1 - 4.	49.4810500000000033	18.2842500000000001
63	STA	VW	27	Stage 2 - Zajímavý objekt	Zajímavý objekt a odpověď na otázku č. 5.	49.4803832999999997	18.2856832999999988
64	PAR	VW	27	Parkoviště	Zde můžete zaparkovat.	49.4799999999999969	18.2860000000000014
65	REF	VW	28	Reference	Zde nic není.	49.467655299999997	18.0427093999999997
66	FIN	HW	28	Umístění finálky	Zde se nachází keš.	49.4825666999999996	18.0472667000000015
67	PAR	HW	28	Parkoviště	Zde můžete zaparkovat.	49.4826649999999972	18.0490355999999998
68	REF	VW	29	Reference	Zde nic není.	49.4600547000000006	18.137466400000001
69	FIN	HW	29	Umístění finálky	Zde se nachází keš.	49.4324999999999974	18.0672166999999995
70	PAR	HW	29	Parkoviště	Zde můžete zaparkovat.	49.431750000000001	18.0635903000000013
71	REF	VW	30	Reference	Zde nic není.	49.4564841999999985	18.1898769000000016
72	FIN	HW	30	Umístění finálky	Zde se nachází keš.	49.4231333000000035	18.1956333000000008
73	PAR	HW	30	Parkoviště	Zde můžete zaparkovat.	49.4242781000000022	18.2113681000000014
74	REF	VW	31	Reference	Zde nic není.	49.4381005999999985	18.2659388999999983
75	FIN	HW	31	Umístění finálky	Zde se nachází keš.	49.4703166999999979	18.2773499999999984
76	PAR	HW	31	Parkoviště	Zde můžete zaparkovat.	49.4699497000000008	18.2777746999999984
77	REF	VW	32	Cíl	Místo cíle závodu BRAZDA 2016.	49.4671493999999967	18.1633682999999984
\.

SELECT pg_catalog.setval('waypoints_waypoint_seq', 77, true);

COMMIT;
