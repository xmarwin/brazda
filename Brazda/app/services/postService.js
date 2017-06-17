"use strict";

angular.module("myApp.postService", [])
    .service("PostService", PostService)

function PostService($filter) {
    var vm = this;

    vm.getPosts = function (teamId) {
        return [
            {
                "post": 1,
                "post_type": "BEG",
                "color": "TRA",
                "name": "Start",
                "max_score": 0,
                "difficulty": "1",
                "terrain": "1",
                "size": "O",
                "shibboleth": "Hybaj",
                "with_staff": true,
                "help": "",
                "description": "<p><strong>Vítejte na startu závodu BRAZDA 2016<\/strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>                <p><strong>Uvidíme se zde<\/strong> opět <strong>v 18.30<\/strong>, kdy závod končí.</p>",
                "waypoints": [{
                    "waypoint": 1,
                    "waypoint_type": "REF",
                    "waypoint_visibility": "VW",
                    "post": 1,
                    "name": "Start",
                    "description": "Místo startu závodu BRAZDA 2016.",
                    "latitude": 4.946714940000000,
                    "longitude": 1.816336830000000
                }]
            }, {
                "post": 2,
                "post_type": "ACT",
                "color": "RED",
                "name": "Transport",
                "max_score": 150,
                "difficulty": "2.5",
                "terrain": "2.5",
                "size": "O",
                "shibboleth": "Dánsko",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří vaši logiku, obratnost i vytrvalost. Může se hodit ručník a plavky.</p>",
                "waypoints": [{
                    "waypoint": 2,
                    "waypoint_type": "REF",
                    "waypoint_visibility": "VW",
                    "post": 2,
                    "name": "Aktivita",
                    "description": "Místo, kde probíhá aktivita.",
                    "latitude": 4.941975610000000,
                    "longitude": 1.831817720000000
                }, {
                    "waypoint": 3,
                    "waypoint_type": "PAR",
                    "waypoint_visibility": "VW",
                    "post": 2,
                    "name": "Parkoviště",
                    "description": "Zde můžete zaparkovat.",
                    "latitude": 4.942048530000000,
                    "longitude": 1.831903560000000
                }]
            }, {
                "post": 3,
                "post_type": "ACT",
                "color": "RED",
                "name": "Klíčová pakárna",
                "max_score": 100,
                "difficulty": "2",
                "terrain": "3.5",
                "size": "O",
                "shibboleth": "král",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří vaši sílu a vytvalost. Hodí se dobré boty.</p>",
                "waypoints": [{
                    "waypoint": 4,
                    "waypoint_type": "REF",
                    "waypoint_visibility": "VW",
                    "post": 3,
                    "name": "Aktivita",
                    "description": "Místo, kde probíhá aktivita.",
                    "latitude": 4.948400080000000,
                    "longitude": 1.804077170000000
                }, {
                    "waypoint": 5,
                    "waypoint_type": "PAR",
                    "waypoint_visibility": "VW",
                    "post": 3,
                    "name": "Parkoviště",
                    "description": "Zde můžete zaparkovat.",
                    "latitude": 4.948440000000000,
                    "longitude": 1.804168360000000
                }]
            }, {
                "post": 4,
                "post_type": "ACT",
                "color": "RED",
                "name": "Přepravky",
                "max_score": 150,
                "difficulty": "2",
                "terrain": "4",
                "size": "O",
                "shibboleth": "trn",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří vaši odvahu a obratnost na hranice mezí. Vlastní sedák může být výhoda.</p>",
                "waypoints": [{
                    "waypoint": 6,
                    "waypoint_type": "REF",
                    "waypoint_visibility": "VW",
                    "post": 4,
                    "name": "Aktivita",
                    "description": "Místo, kde probíhá aktivita.",
                    "latitude": 4.942690000000000,
                    "longitude": 1.799220000000000
                }, {
                    "waypoint": 7,
                    "waypoint_type": "PAR",
                    "waypoint_visibility": "VW",
                    "post": 4,
                    "name": "Parkoviště",
                    "description": "Zde můžete zaparkovat.",
                    "latitude": 4.943572330000000,
                    "longitude": 1.801748610000000
                }                ] 
            }, {
                "post": 5,
                "post_type": "ACT",
                "color": "RED",
                "name": "Titanic",
                "max_score": 130,
                "difficulty": "3",
                "terrain": "5",
                "size": "O",
                "shibboleth": "jelen",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří váš důvtip a vytrvalost. Ručník a plavky budou potřeba.</p>",
                "waypoints": [{ "waypoint": 8, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 5, "name": "Aktivita", "description": "Místo, kde probíhá aktivita.", "latitude": 4.942430560000000, "longitude": 1.802569440000000 }, { "waypoint": 9, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 5, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.942483330000000, "longitude": 1.802494440000000 }]
            }, {
                "post": 7,
                "post_type": "ACT",
                "color": "YEL",
                "name": "Váhy",
                "max_score": 100,
                "difficulty": "4",
                "terrain": "1",
                "size": "O",
                "shibboleth": "3,14159",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří váši inteligenci a důvtip. Jak to uděláte je opravdu na vás.</p>",
                "waypoints": [{ "waypoint": 13, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 7, "name": "Aktivita", "description": "Místo, kde probíhá aktivita.", "latitude": 4.943486440000000, "longitude": 1.825331580000000 }, { "waypoint": 14, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 7, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.943508940000000, "longitude": 1.825304890000000 }]
            }, {
                "post": 8,
                "post_type": "ACT",
                "color": "RED",
                "name": "Mozaika",
                "max_score": 90,
                "difficulty": "3",
                "terrain": "1.5",
                "size": "O",
                "shibboleth": "zub",
                "with_staff": true,
                "hint": "",
                "help": "",
                "description": "<p>Aktivita, která prověří vaši inteligenci a představivost. Chce to jen čas.</p>",
                "waypoints": [{ "waypoint": 15, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 8, "name": "Aktivita", "description": "Místo, kde probíhá aktivita.", "latitude": 4.944861530000000, "longitude": 1.819313500000000 }, { "waypoint": 16, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 8, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.944853940000000, "longitude": 1.819299560000000 }]
            }, {
                "post": 9,
                "post_type": "CIP",
                "color": "BLU",
                "name": "Morseovka",
                "max_score": 100,
                "difficulty": "5",
                "terrain": "1",
                "size": "O",
                "shibboleth": "magnituda",
                "with_staff": false,
                "hint": "Za památníkem",
                "help": "Záleží na úhlu pohledu",
                "description": "<p>Co by to byl za závod, kdyby na něm nebyla aspoň jedna šifra v morseovce. Nebo ne?</p>",
                "waypoints": [{ "waypoint": 17, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 9, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.940641670000000, "longitude": 1.807270000000000 }, { "waypoint": 18, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 9, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.940608940000000, "longitude": 1.807228060000000 }]
            }, {
                "post": 6,
                "post_type": "ACT",
                "color": "BLU",
                "name": "Špionáž",
                "max_score": 150,
                "difficulty": "3",
                "terrain": "2",
                "size": "O",
                "shibboleth": "červená",
                "with_staff": false,
                "hint": "Za dřevěnou nástěnkou",
                "help": "",
                "description": "<p>Aktivita, která prověří vaši všímavost a důvtip. Nutnost zařízení, které umí přečíst QR kódy.</p>",
                "waypoints": [{ "waypoint": 10, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 6, "name": "Aktivita", "description": "Místo, kde začíná aktivita.", "latitude": 4.939105000000000, "longitude": 1.796348330000000 }, { "waypoint": 11, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 6, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.939131670000000, "longitude": 1.796326670000000 }, { "waypoint": 12, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 6, "name": "Umístění řešení úkolu", "description": "Zde jste dokončili celou aktivitu.", "latitude": 4.939111670000000, "longitude": 1.796330000000000 }]
            }, {
                "post": 11,
                "post_type": "CIP",
                "color": "BLU",
                "name": "Housenka",
                "max_score": 80,
                "difficulty": "2.5",
                "terrain": "2",
                "size": "O",
                "shibboleth": "gymnastika",
                "with_staff": false,
                "hint": "Pod kamenem, cca 15m od cesty",
                "help": "Semafor",
                "description": "<p>Ne až tak náročná šifra, jen na to přijít.</p>",
                "waypoints": [{ "waypoint": 21, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 11, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.950340000000000, "longitude": 1.827763330000000 }, { "waypoint": 22, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 11, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948471670000000, "longitude": 1.826441670000000 }]
            }, {
                "post": 12,
                "post_type": "CIP",
                "color": "BLU",
                "name": "Trajektorie",
                "max_score": 60,
                "difficulty": "3",
                "terrain": "1.5",
                "size": "O",
                "shibboleth": "letohrádek",
                "with_staff": false,
                "hint": "",
                "help": "Mapa",
                "description": "<p>Ne až tak složitá šifra, chce to jen trochu představivosti.</p>",
                "waypoints": [{ "waypoint": 23, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 12, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.946343330000000, "longitude": 1.814891670000000 }, { "waypoint": 24, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 12, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.946401670000000, "longitude": 1.814893330000000 }]
            }, {
                "post": 14,
                "post_type": "CIP",
                "color": "YEL",
                "name": "Tunel",
                "max_score": 80,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "O",
                "shibboleth": "horor",
                "with_staff": false,
                "hint": "",
                "help": "Uwe Filter",
                "description": "<p>Vcelku nenáročná šifra v tunelu, jen si na ni posvítit. Pokud je víc vody, hodí se gumáky. Šifra je v nejtemnější části.</p>",
                "waypoints": [{ "waypoint": 27, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 14, "name": "Vstup do tunelu", "description": "Místo, kde najdete šifru. Hledejte v temné části mezi zatáčkama.", "latitude": 4.945493780000000, "longitude": 1.812761060000000 }, { "waypoint": 28, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 14, "name": "Parkoviště 1", "description": "Zde můžete zaparkovat.", "latitude": 4.945295690000000, "longitude": 1.813098330000000 }, { "waypoint": 29, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 14, "name": "Parkoviště 2", "description": "Zde můžete zaparkovat.", "latitude": 4.945779190000000, "longitude": 1.812765750000000 }]
            }, {
                "post": 10,
                "post_type": "CIP",
                "color": "BLU",
                "name": "Šipky",
                "max_score": 120,
                "difficulty": "4",
                "terrain": "1",
                "size": "O",
                "shibboleth": "rudá",
                "with_staff": false,
                "hint": "Mezi koulema",
                "help": "Tetris",
                "description": "<p>Poměrně náročná a pracná šifra, ale ono to na konec vždycky nějak jde.</p>",
                "waypoints": [{ "waypoint": 19, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 10, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.943565000000000, "longitude": 1.809583330000000 }, { "waypoint": 20, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 10, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.944102560000000, "longitude": 1.809713280000000 }]
            }, {
                "post": 13,
                "post_type": "CIP",
                "color": "BLU",
                "name": "Křížovka",
                "max_score": 60,
                "difficulty": "2.5",
                "terrain": "2",
                "size": "O",
                "shibboleth": "mercedes",
                "with_staff": false,
                "hint": "Za rezavou boudou",
                "help": "Do třetice všeho dobrého",
                "description": "<p>Vcelku jednoduchá šifra na dobře známém základě.</p>",
                "waypoints": [{ "waypoint": 25, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 13, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.946791670000000, "longitude": 1.809053330000000 }, { "waypoint": 26, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 13, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.946764720000000, "longitude": 1.809069580000000 }]
            }, {
                "post": 15,
                "post_type": "CIP",
                "color": "YEL",
                "name": "Substituce",
                "max_score": 90,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "O",
                "shibboleth": "tréning",
                "with_staff": false,
                "hint": "Na čerstvém pařezu",
                "help": "",
                "description": "<p>Šifra jejíž luštění není až tak náročné mentálně jako spíš fyzicky. Během jejího luštění se tým může kvůli efektivitě rozdělit.</p>",
                "waypoints": [{ "waypoint": 30, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 15, "name": "Šifra", "description": "Místo, kde najdete šifru.", "latitude": 4.940190000000000, "longitude": 1.797578330000000 }, { "waypoint": 31, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 15, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.940001670000000, "longitude": 1.796516670000000 }]
            }, {
                "post": 16,
                "post_type": "CGC",
                "color": "BLU",
                "name": "Trigonometrická",
                "max_score": 110,
                "difficulty": "4",
                "terrain": "2",
                "size": "R",
                "cache_type": "MYS",
                "shibboleth": "žid",
                "with_staff": false,
                "hint": "Všechny stage: sloupy el. vedení, Final: visí",
                "help": "",
                "description": "<p>Trigonometrie (z řeckého <em>trigonón</em> - trojúhelník a <em>metrein</em> - měřit) je oblast goniometrie zabývající se použitím goniometrických funkcí při řešení úloh o trohúhelnících. Trigonometrie má základní význam při triangulaci, která se používá k měření vzdáleností mezi dvěma hvězdami, v geodézii k měření vzdálenosti dvou bodů a v satelitních navigačních systémech.</p><p>První poznatky z trigonometrie lze prokázat již u Egypťanů. Podobné znalosti měli také Babyloňané a Chaldejci, od kterých převzali Řekové dnešní dělení plného úhlu na 360° a stupně na 60 minut. První práce o trigonometrii souvisely s problémem určení délky tětivy vzhledem k velikosti úhlu. První tabulky délek tětiv pocházejí od řeckého matematika Hipparcha z roku 140 př. n. l., další tabulky sepsal zhruba o 40 let později Melenaus, řecký matematik žijící v Římě. Práce starořeckých vědců vyvrcholila Ptolemaiovým dílem Megale syntaxis (Velká soustava), v níž Ptolemaios vypočítal tabulku délek tětiv kružnice, jež měla poloměr až 60 délkových jednotek a kde středový úhel, k němuž se délky vztahovaly, postupoval po 0,5°.</p><p>Od 5. století začali pak trigonometrii budovat Indové, od kterých pochází dnešní název pro sinus, a po nich vědci Střední Asie a Arabové. Z Indů se trigonometrii nejvíce věnoval Brahmagupta (7. století), z vědců Střední Asie a Arábie je pak třeba vzpomenout syrského astronoma al-Battáního.</p><p>Evropa se s trigonometrií seznámila díky západním Arabům. K rozvoji trigonometrie významně přispěl polský astronom Mikuláš Koperník, stejně tak i francouzský matematik François Viete, který představil kosinovou větu v trigonometrické podobě. Dnešní podobu trigonometrie jakožto vědu o goniometrických funkcích ve svém díle Introductio in analysin infinitorum (Úvod do analýzy) vytvořil Leonhard Euler. Poprvé zkoumal hodnoty sin x, cos x jako čísla, nikoli jako úsečky, a jako hodnoty proměnné připouštěl kladná i záporná čísla.</p><p>Nejvýznamnější a technologicky nejvyspělejší aplikací trigonometrie v současnosti patří jednoznačně satelitní navigační systémy, které pracují právě na principech sférické trigonometrie s využitím znalosti efemerid družicového pole a přesného času, kdy z rozdílu mezi přijetím stejného času lze dopočítat vzdálenost k družici, která jej vyslala a díky znalostí poloh alespoň tří (v praxi však více) družic dopočítat vlastní pozici na kulové ploše.</p><p>Po vás nic tak složitého chtít nebudeme, nicméně pro nález krabičky budete potřebovat nějakým způsobem trigonometrii ať již v algebraické, nebo geometrické podobě použít. Na jednotlivých stagích najdete vzdálenost od keše. Vše ostatní je na vás.<p>",
                "waypoints": [{ "waypoint": 32, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 16, "name": "1. stage", "description": "Zde zjistíte část indicí.", "latitude": 4.946480000000000, "longitude": 1.799660000000000 }, { "waypoint": 33, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 16, "name": "2. stage", "description": "Zde zjistíte další část indicií.", "latitude": 4.946311670000000, "longitude": 1.800365000000000 }, { "waypoint": 34, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 16, "name": "3. stage", "description": "Zde zjistíte posleldní část indicií.", "latitude": 4.947316670000000, "longitude": 1.799440000000000 }, { "waypoint": 35, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 16, "name": "Parkoviště u 1. stage", "description": "Zde můžete zaparkovat.", "latitude": 4.946410190000000, "longitude": 1.799540720000000 }, { "waypoint": 36, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 16, "name": "Parkoviště u 2. stage", "description": "Zde můžete zaparkovat.", "latitude": 4.946310640000000, "longitude": 1.800452140000000 }, { "waypoint": 37, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 16, "name": "Parkoviště u 3. stage", "description": "Zde můžete zaparkovat.", "latitude": 4.947328780000000, "longitude": 1.799144560000000 }, { "waypoint": 38, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 16, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.946703330000000, "longitude": 1.799918330000000 }]
            }, {
                "post": 17,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Plotny",
                "max_score": 150,
                "difficulty": "2",
                "terrain": "5",
                "size": "S",
                "cache_type": "TRA",
                "shibboleth": "láska",
                "with_staff": false,
                "hint": "Visí",
                "help": "",
                "description": "<p>\"Co by to bylo za pořádný geozávod, kdyby na něm nebyla alespoň jedna T5ka!\" řekli jsme si při přípravě. V tomto případě je jí skála, na kterou bude potřeba vylézt. Zcela jistě budete potřebovat lezeckou výbavu.</p>",
                "waypoints": [{ "waypoint": 39, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 17, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.946928860000000, "longitude": 1.817691360000000 }, { "waypoint": 40, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 17, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.946875390000000, "longitude": 1.817775720000000 }]
            }, {
                "post": 18,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Můstek",
                "max_score": 80,
                "difficulty": "1.5",
                "terrain": "3",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "zvon",
                "with_staff": false,
                "hint": "",
                "help": "",
                "description": "<p>Vydejte se na malou procházku do udržovaného lesíku a objevte dávno zapomenutý poklad. Časy jeho slávy připomíná už jen torzo a těžko říct, kolik pamětníků je ještě mezi námi.</p><p>Můstky dříve rostly jako houby po dešti; dvaceti či třicetimetrové můstky měla každá třetí horská obec, i když se na nich konaly třeba jen dva závody. Před 2. světovou válkou bylo na území ČR více než 220 můstků, ve zlatém věku na přelomu 50. a 60. let autoři napočítali dokonce 270 můstků.</p><p>V blízkosti se nachází Ski areál. Ski areál Búřov leží v malebné vesnici Valašská Bystřice, v samotném srdci Beskyd, 7 km od Rožnova pod Radhoštěm.</p><p>Areál je vhodný pro začínající i pokročilé lyžaře, ideální pro lyžařské kurzy. Náš areál často navštěvují také snowboardisté, pro které máme zřízen snowpark.</p><p>Nadmořská výška vleků je 500 – 620 m.n.m.</p>",
                "waypoints": [{ "waypoint": 41, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 18, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.940853330000000, "longitude": 1.810656670000000 }, { "waypoint": 42, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 18, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.940426670000000, "longitude": 1.810473330000000 }]
            }, {
                "post": 19,
                "post_type": "CGC",
                "color": "YEL",
                "name": "Pod Mísnú",
                "max_score": 80,
                "difficulty": "2",
                "terrain": "3.5",
                "size": "R",
                "cache_type": "MLT",
                "shibboleth": "svatozář",
                "with_staff": false,
                "hint": "Nahoře krytá před deštěm",
                "help": "",
                "description": "<h2>Pod Mísnú</h2>                <p>Když se podíváte na mapu do místa známého jako Zákopčí (nebo Za Kopcem), jinak místní části Hutiska-Solanec, všimnete si pojmenování Pod Mísnou a to hned na několika různých místech. Ovšem žádný kopec s názvem Mísná na mapě neuvidíte. Hluboké údolí Zákopčí se kousek za památníkem Charlotte Garrigue-Masaryk u školy v přírodě (rekreačního střediska Hutisko-Solanec) dělí na dvě části, jedním protéká Hutiský potok a druhým potok Mísná. Podél Hutiského potoka vede zelená turistická značka, která končí na Vsacké Tanečnici (912 m n.m.). My se však vydáme proti proudu potoka Mísná do druhého, zapadlejšího údolí.</p>                <h3>Výchozí souřadnice - Stage 1</h3>                <p>Svá geovozidla prosím zanechte na doporučeném parkovišti, parkovat na točně autobusu u rekreačního střediska opravdu není dobrý nápad a pokračovat dále autem je nejen že dopravním značením zapovězené, ale mohli byste se se zlou potázat. Místní jsou všímaví a nekompromisní. Ale než se vydáme dále, povšimněte si památníku před rekreačním střediskem napravo. Památník byl postaven při příležitosti otevření školy, jsou na něm vyobrazeny dvě děti, ukazující na bustu T.G. Masaryka a z boku je vyvedený nápis. Nápis si dobře přečtěte a spočítejte počet slov (=<strong>A</strong>).</p>                <h3>Výpočet pro Stage 2</h3>               <p><strong>N 49°25,(A*25+5)<br>                E 018°11,(A*29+3)</strong></p>                <p>Máte spočítáno? Tak můžeme vyrazit na druhou zastávku procházky. Cestou si všimněte chalup a stavení roztroušených v údolí a po stráních. Některé jsou trvale obydlené, jiné slouží jako chaty pro sezonní bydlení. Pokud jste trefili správnou cestu a nepřepočítali se hned na začátku, došli jste ke studánce, kde se můžete občerstvit (ale neručím za pitnost vody). Naproti studánce, mezi dvěma lipami a kaštanem, stojí kříž s Kristem. Očividně již má něco za sebou, ale když si ho dobře prohlédnete, objevíte letopočet, který si zapište (=<strong>BCDE</strong>).</p>                <h3>Výpočet pro Stage 3</h3>                <p><strong>N 49°24,(C-B)(A-D)(D+E-C)<br>                E 018°10,(D-B)(D-A)(E)</strong></p>                <p>Jednoduchý výpočet jste jistě zvládli a můžeme tak pokračovat dále. Pokud jste se rozhodli absolvovat trasu na kole, teď se asi zapotíte, ale na Valašsku to ani jinak nejde. Ještě než dojdete k další zastávce, otevřou se výhledy do okolí a můžete se začít kochat panoramaty. Nejlepší výhledy jsou asi přímo od druhého kříže s vyobrazením Krista a mohutné lípy, která stojí hned vedle. Můžete si zde sednout na lavičku, odpočinout si a pokochat se rozhledy. Krásně je vidět hřeben Čertova Mlýna napravo a Radhoště nalevo. Až se pokocháte výhledem, všimněte si louky pod vámi, kde rostou jalovce a množství chráněných rostlin, možná i orchidejí (což nemám ověřeno, ale na okolních lokalitách se vyskytují). Pak se vraťe ke kříži a všimněte si plechového oblouku stříšky nad křížem. Určete jeho barvu a pořadí barvy v barvách duhy (červená=1 až fialová=6) je poslední indicie pro výpočet finálky (=<strong>F</strong>).</p>                <h3>Výpočet pro Finále</h3>                <p><strong>N 49°24,(D)(B)(A)<br>                E 018°10,(F)(B)(D+B)</strong></p>                <p>Ještě než se vydáte ke keši, tak jak je to teda s tou Mísnou? Když budete pokračovat po cestě dále, dostanete se až na hřeben mezi Hážovskými díly a Vsackou Tanečnicí a tam někde na modré turistické značce najdete rozcestí Mísná.</p>",
                "waypoints": [{ "waypoint": 43, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 19, "name": "Stage 1", "description": "Busta T.G. Masaryka s nápisem na boku. Počet slov na nápisu = A", "latitude": 4.941875000000000, "longitude": 1.820150000000000 }, { "waypoint": 44, "waypoint_type": "STA", "waypoint_visibility": "HC", "post": 19, "name": "Stage 2", "description": "Kříž a studánka. Letopočet na kříži = BCDE", "latitude": 4.941966670000000, "longitude": 1.818675000000000 }, { "waypoint": 45, "waypoint_type": "STA", "waypoint_visibility": "HC", "post": 19, "name": "Stage 3", "description": "Kříž pod lípou. Určete pořadí barvy stříšky nad křízem v pořadí barev duhy (červená = 1 až fialová = 6) = F", "latitude": 4.941333330000000, "longitude": 1.817670000000000 }, { "waypoint": 46, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 19, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.941195000000000, "longitude": 1.817530000000000 }, { "waypoint": 47, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 19, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.941913330000000, "longitude": 1.820216670000000 }]
            }, {
                "post": 20,
                "post_type": "CGC",
                "color": "YEL",
                "name": "Kání",
                "max_score": 70,
                "difficulty": "1.5",
                "terrain": "4",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "olympiáda",
                "with_staff": false,
                "hint": "",
                "help": "",
                "description": "<h3>O místě</h3>\t\t\t\t<p>Kání je výrazný kopec, který se tyčí do výšky 666m nad mořem nad obcí Hutisko-Solanec. Po přerušení Solaneckým potokem jím pokračuje jižní hřeben údolí Rožnovské brázdy, který se táhne od kopce Brdo nad Valašským Meziříčím a končí kopcem Beskyd na Česko-Slovenském pomezí poblíž Bumbálky.</p>\t\t\t\t<p>Vede přes něj modrá turistická značka, která z Hutiska-Solance stoupá právě na tomto kopci na hřeben, po kterém přes Kýnačky a Hluboký vede až k rozcestí Na Západí, kde se k ní připojuje zelená turistická značka od Zavadilky. Přes Jezerné pod Kotlovu pak vede dále na Benešky, Polanu, Vysokou a přes Třeštík až na zmíněý Beskyd. Je to jedna z nejkrásnějších tras v této části Beskyd, ze které je řada krásných výhledů jak do údolí Rožnovské tak do údolí Vsetínské Bečvy. Tato trasa je velmi oblíbená nejen mezi pěšímí, ale cyklo turisty</p>\t\t\t\t<p>Kousek pod vrcholem kopce Kání stojí i retranslační a základová stanice s dobře viditelným vysílačem. Pod vrcholem je několik chalup, ke kterým se dostat ale není vůbec jednoduché. Ostatně při cestě ke keši to poznáte sami.</p>\t\t\t\t<h3>O Keši</h3>\t\t\t\t<p>Keš samotná je pověšena na stromě nedaleko vysílače, není to žádné supertěžké stromolezení, ale zadarmo to taky nebude. Místo však rozhodně stojí za návštěvu.</p>",
                "waypoints": [{ "waypoint": 48, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 20, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.942011640000000, "longitude": 1.823596440000000 }, { "waypoint": 49, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 20, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.942112360000000, "longitude": 1.822331440000000 }]
            }, {
                "post": 21,
                "post_type": "CGC",
                "color": "RED",
                "name": "Kostel sv. Zdislavy",
                "max_score": 30,
                "difficulty": "2",
                "terrain": "2",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "strom",
                "with_staff": false,
                "hint": "Pod čepičkou",
                "help": "",
                "description": "<p>Obec Prostřední Bečva leží ve východní části Radhošťské hornatiny a Vsetínských vrchů v nadmořské výšce 430 m.n.m. Byla donedávna jedna z mála okolních obcí, která neměla svůj vlastní kostel.</p>                <p>Dne  23.&thinsp;května 1998 vznikla Kostelní jednota sv. Zdislavy, jejíž členové začali usilovat o&nbsp;výstavbu nového kostela. V&nbsp;roce 1999 začali členové této jednoty vybírat finanční prostředky na jeho výstavbu. Dřevo na výstavbu bylo darováno, obec poskytla pozemek, věřící darovali potřebnou finanční částku a některé z vybavení kostela.</p>                <p>Stavba byla zahájena dne 11. července roku 2000 a trvala jeden rok. Výsledkem stavby byl pěkný moderní kostel, ke kterému vás přivede tato keška. Při odlovu si počínejte opatrně v případě mudlů v okolí.</p>",
                "waypoints": [{ "waypoint": 50, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 21, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.943995000000000, "longitude": 1.824805000000000 }, { "waypoint": 51, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 21, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.943968330000000, "longitude": 1.824763330000000 }]
            }, {
                "post": 22,
                "post_type": "CGC",
                "color": "YEL",
                "name": "Nořičí trail 1",
                "max_score": 60,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "záchrana",
                "with_staff": false,
                "hint": "Pata stromu",
                "help": "",
                "description": "<p><strong>Noříčí trail<\/strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno<\/strong> (80 kč\/den)!</p>",
                "waypoints": [{ "waypoint": 52, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 22, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.949695000000000, "longitude": 1.827908330000000 }, { "waypoint": 53, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 22, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948471670000000, "longitude": 1.826441670000000 }]
            }, {
                "post": 23,
                "post_type": "CGC",
                "color": "YEL",
                "name": "Nořičí trail 2",
                "max_score": 60,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "objezd",
                "with_staff": false,
                "hint": "Za kamenem",
                "help": "",
                "description": "<p><strong>Noříčí trail<\/strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno<\/strong> (80 kč\/den)!</p>",
                "waypoints": [{ "waypoint": 54, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 23, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.951141670000000, "longitude": 1.827780000000000 }, { "waypoint": 55, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 23, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948471670000000, "longitude": 1.826441670000000 }]
            }, {
                "post": 24,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Nořičí trail 3",
                "max_score": 60,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "oběh",
                "with_staff": false,
                "hint": "Zezadu cedule",
                "help": "",
                "description": "<p><strong>Noříčí trail<\/strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno<\/strong> (80 kč\/den)!</p>",
                "waypoints": [{ "waypoint": 56, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 24, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.950831670000000, "longitude": 1.826353330000000 }, { "waypoint": 57, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 24, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948471670000000, "longitude": 1.826441670000000 }]
            }, {
                "post": 25,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Nořičí trail 4",
                "max_score": 60,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "infarkt",
                "with_staff": false,
                "hint": "Smrček",
                "help": "",
                "description": "<p><strong>Noříčí trail<\/strong> je okruh 4 kešek, nacházející se v blízkosti Pusteven. Pokud se chcete vyhnout davům lidí proudící směrem k Radhošti, určitě za to stojí vyrazit po turistické značce na cca 8 kilometrů dlouhý okruh a navštívit místa, která nejsou příliš známá, ale přesto krásná.</p>                <p><strong>Pozor! Parkoviště na Pustevnách je zpoplatněno<\/strong> (80 kč\/den)!</p>",
                "waypoints": [{ "waypoint": 58, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 25, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.949915000000000, "longitude": 1.827258330000000 }, { "waypoint": 59, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 25, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948471670000000, "longitude": 1.826441670000000 }]
            }, {
                "post": 26,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Kostel sv. Antonína Paduánského",
                "max_score": 40,
                "difficulty": "2",
                "terrain": "1.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "trumf",
                "with_staff": false,
                "hint": "Zespodu, magnet",
                "help": "",
                "description": "<p>Kostel sv. Antonína Paduánského byl postaven 1906 stavitelem Ing. Aloisem Pallatem z Olomouce. Nachází se ve středu obce Dolní Bečva, v blízkosti lipové aleje Hynka Tošenovského. Základní kámen byl posvěcen  24.září 1905 Antonínem C. Stojanem.</p>                <p>Patronem  kostela byl zvolen sv. Antonín Paduánský. Kostel byl požehnán v roce 1907. Jeho délka je 28 metrů, šířka 9,5 metrů a jeho věž je vysoká 37 metrů. Byl postaven v novorománském slohu.</p>                <h3>Ke keši</h3>                <p>Keš se nachází na poměrně frekventovaném místě, proto prosím s odlovem počkejte, dokud nebude oblast vylidněná. K odlovení keše není potřeba nic rozhrabávat, ani ničit. </p>",
                "waypoints": [{ "waypoint": 60, "waypoint_type": "FIN", "waypoint_visibility": "VW", "post": 26, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.945618330000000, "longitude": 1.819235000000000 }, { "waypoint": 61, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 26, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.945675000000000, "longitude": 1.819291670000000 }]
            }, {
                "post": 27,
                "post_type": "CGC",
                "color": "GRN",
                "name": "Lom Kněhyně",
                "max_score": 100,
                "difficulty": "3",
                "terrain": "3",
                "size": "O",
                "cache_type": "ERT",
                "shibboleth": "zlato707",
                "with_staff": false,
                "hint": "Stage 2: 6m pod betonovým sloupkem, dvířka nad vodou",
                "help": "",
                "description": "<h2>Lom Kněhyně</h2>				<p>Významnou geologickou lokalitu představuje opuštěný, částečně zasutěný stěnový kamenolom v katastru obce Prostřední Bečva na jihozápadním úpatí Kněhyně (1 257 m n.m.). Lom se nachází ve vzdálenosti asi 4,5 km od obce, vpravo od silnice z Prostřední Bečvy na Pustevny. Přístupová cesta odbočuje v první z ostrých zatáček na začátku stoupání této silnice ve směru na Pustevny. Lomovou stěnou jsou zastiženy křídové sedimenty středního a svrchního oddílu godulského souvrství (cenoman až senon), budujícího hlavní hřebeny Beskyd a představujícího současně nejmocnější člen (přes 3 000 m) slezské jednotky.<br>			Slezská jednotka je příkrov flyšového pásma Západních Karpat a z větší části tvoří Moravskoslezské Beskydy a podbeskydskou pahorkatinu. Slezská jednotka zahrnuje juru až oligocén a dělí se na dílčí příkrov těšínský (nižší) a godulský (vyšší). A právě část souvrství godulských vrstev je možné pozorovat v lomu v Kněhyni.</p>				<p>Horniny středního oddílu godulského souvrství jsou jen menším podílem zastoupeny v jihozápadní části lomu. Představují hrubě rytmický flyš s převahou světle zelenavě šedých, silně lavicovitých, hrubě až středně zrnitých glaukonitických pískovců, vytvářejících polohy o mocnosti až několika desítek metrů. Na bázi silnějších lavic s gradačním zvrstvením se lokálně vyskytují drobně zrnité slepence a slepencové, vzácněji i arkózové pískovce.<br>				Horniny svrchního oddílu godulského souvrství jsou rozšířené v severovýchodní části odkryvu. Litologicky odpovídají výše popsaným sedimentům, pro něž je typické rychlé snižování prachovcovo-pískovcových poloh a jejich celkové ztenčování. Mnohem častější je současně rychlé proužkovité střídání šedých a zelených, někdy až tmavošedě skvrnitých jílovců.</p>				<h3>Flyš</h3>			<p>V sedimentologii se tak nazývá komplex vrstev mořského původu, nejméně 500m mocný, tvořený z rytmicky zvrstvených a střídajících se klastických sedimentů, jevících často pozitivní gradační zvrstvení (od větších zrn sedimentární horniny k jemnějším). Na spodních plochách pískovců se často objevuji velice hojné hieroglyfy (nerovnost vrstevních ploch). Svým složením se flyš blíží uloženinám některých hlubokomořských delt a byl ukládán při úpatí příkrých podmořských srázů (například na kontinentálním úpatí) a na jeho vzniku se významnou měrou podílely takzvané turbiditní proudy (gravitační toky). Pozice flyše v pánvi proto rozhoduje o jeho složení.<br>				V tektonickém pojetí se jedná o sedimenty ukládané v období uzavírání geosynklinál za tektonicky nestabilních a silně seizmických podmínek.<br>				Z horninového hlediska je flyš složený ze slepenců, pískovců a jílovců.</p>		<h3>Kameny zblízka</h3>				<p>Na plochách některých kamenů je možné spatřit nerovnosti, způsobené buď mechanicky, takzvané mechanoglyfy (proudy, vtisky, čeřiny nebo stopy vlečení) a nebo biologicky, takzvané bioglyfy (stopy po lezení a vrtání organismů). Tyto stopy vznikly v době usazování hornin na mořském dně.</p>				<h3>Jak na keš?</h3>				<p><strong>Pro uznání logu musíte absolvovat několik úkolů</strong></p>				<ul>					<li>Na výchozích souřadnicích stojíte před stěnou lomu a vedle vás leží na zemi několik velkých kamenů, z nichž jeden vypadá jako obrazovka televize (viz Úkol 1). Změřte průměrné rozměry kamene (měřte vždy uprostřed strany) a spočítejte, kolik kámen váží (v kg), když víte, že se jedná o pískovec (do závorky napište, jakou objemovou hmotnost jste uvažovali). </li>					<li>Dále se podívejte na stěnu lomu před vámi a uvidíte dole uprostřed vykukovat ze sutě několik vrstev flyše (viz Úkol 2 a 3). Běžte ke skále a zaměřte se na nejsilnější vrstvu pískovce (asi ve výšce hlavy, když stojíte uprostřed). Změřte tloušťku vrstvy a zaokrouhlete na desítky centimetrů. A hned změřte i tmavou tenkou vrstvu pod ní a zaokrouhlete na celé centimetry. Jestli jste měřili správně, tak si hned všimnete, že tloušťka obou vrstev má zajímavou souvislost. Jako odpověď pošlete obě změřené tloušťky.</li>					<li>U tenčí vrstvy se ještě zdržíme, určete o jakou horninu se jedná (pomůže listing) a napište, čím se hlavně liší od pískovce nad ní (kromě barvy).</li>					<li>Nyní se otočte zády ke stěně lomu a přímo před vámi našikmo leží velký šedý kámen se stopami bioglyfů (viz. Úkol 3). Změřte průměrnou šířku těchto stop v centimetrech.</li>					<li>Za posledním úkolem se vydejte na souřadnice Stage 2. Terén bude poněkud komplikovanější (tak T4) a najděte zajímavý objekt vytvořený člověkem (nachází se asi 6m po svahu pod betonovým sloupkem (viz. Fotohint stage 2). Napište, k čemu dle vašeho názoru objekt sloužil a jaký číslený údaj v kg jste na něm objevili.</li>				</ul>				<p>Jako dobrovolný úkol přidejte k logu fotografii z lomu, ať už stěny lomu s rytmickými vrstvami flyše a nebo kamenů, které vás zaujaly. Prosím nepřikládejte k logu fotografie ze Stage 2!</p>				<h3>Splnění úkolu a zadání hesla pro závod BRAZDA 2016</h3>				<p>Musíte <strong>splnit úkol č. 2</strong>. to je změřit tloušťku dvou vrstev v lomu.<br>			Dostanete <strong>dvě čísla</strong> v centimetrech ve formátu <strong>X0</strong> a <strong>Y</strong>. Na <strong>stage 2 najdete indícii</strong>. Heslo <strong>pro splnění stanoviště</strong> zadáte do herní aplikace ve formátu \" <strong >indicieX0Y</strong>\".</p><p>Příklad: V lomu změříte a zaokrouhlíte tloušťku větší vrstvy na 50cm a menší na 8cm. Na stage 2 objevíte indícii \"potok\". Heslo pro splnění stanoviště pak bude \"potok508\".</p>				<p>Odpovědi posílejte pouze přes profil a logovat můžete hned po odeslání. Když budou odpovědi nedostatečné, budu vás kontaktovat. Bez zaslaných odpovědí logy mažu.</p>				<h3>Zdroje</h3>				<ul>					<li>http://www.geology.cz</li>					<li>http://pruvodce.geol.morava.sci.muni.cz/Prostredni_Becva/Knehyne_text.htm</li>					<li>http://geologie.vsb.cz/reg_geol_cr/10_kapitola.htm</li>				</ul>",
                "waypoints": [{ "waypoint": 62, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 27, "name": "Stage 1 - Lom Kněhyně", "description": "Zde nadete odpovědi na otázky 1 - 4.", "latitude": 4.948105000000000, "longitude": 1.828425000000000 }, { "waypoint": 63, "waypoint_type": "STA", "waypoint_visibility": "VW", "post": 27, "name": "Stage 2 - Zajímavý objekt", "description": "Zajímavý objekt a odpověď na otázku č. 5.", "latitude": 4.948038330000000, "longitude": 1.828568330000000 }, { "waypoint": 64, "waypoint_type": "PAR", "waypoint_visibility": "VW", "post": 27, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948000000000000, "longitude": 1.828600000000000 }]
            }, {
                "post": 28,
                "post_type": "BON",
                "color": "GRN",
                "name": "Zelený bonus",
                "max_score": 150,
                "difficulty": "2",
                "terrain": "3",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "srdce",
                "with_staff": false,
                "hint": "Kořeny",
                "help": "",
                "description": "<p>Tento bonus vás zavede na pěkné místo :)</p>",
                "bonus_code": "hypochondr",
                "waypoints": [{ "waypoint": 65, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 28, "name": "Reference", "description": "Zde nic není.", "latitude": 4.946765530000000, "longitude": 1.804270940000000 }, { "waypoint": 66, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 28, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.948256670000000, "longitude": 1.804726670000000 }, { "waypoint": 67, "waypoint_type": "PAR", "waypoint_visibility": "HW", "post": 28, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.948266500000000, "longitude": 1.804903560000000 }]
            }, {
                "post": 29,
                "post_type": "BON",
                "color": "BLU",
                "name": "Modrý bonus",
                "max_score": 150,
                "difficulty": "2.5",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "hvězda",
                "with_staff": false,
                "hint": "Visí 30cm nad zemí",
                "help": "",
                "description": "<p>Tento bonus vás zavede na pěkné místo, ale dostat se tam není zas tak jednoduché.</p>",
                "bonus_code": "mlhovina",
                "waypoints": [{ "waypoint": 68, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 29, "name": "Reference", "description": "Zde nic není.", "latitude": 4.946005470000000, "longitude": 1.813746640000000 }, { "waypoint": 69, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 29, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.943250000000000, "longitude": 1.806721670000000 }, { "waypoint": 70, "waypoint_type": "PAR", "waypoint_visibility": "HW", "post": 29, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.943175000000000, "longitude": 1.806359030000000 }]
            }, {
                "post": 30,
                "post_type": "BON",
                "color": "YEL",
                "name": "Žlutý bonus",
                "max_score": 150,
                "difficulty": "2",
                "terrain": "3",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "kruh",
                "with_staff": false,
                "hint": "Oběšená na menším z dvojstromu",
                "help": "",
                "description": "<h2>Díly</h2>\t\t\t\t<p>Na Valašsku a v okolí Rožnova jsou Díly poměrně častý název kopce. Obvykle je pozůstatkem po první pasekářské kolonizaci údolí Rožnovské Bečvy, kdy jednotlivé části krajiny byly přidělovány osadníkům a každý tak dostal svůj díl. Obvykle se země rozdělovala tak, že od cest vedených obvykle postředkem údolí v blízkosti vodních toků byly vyčleňovány úzké pruhy země směrem nahoru k hřebenům nad údolím. V některých (především jižních) částech obcí v Hutiském údolí je tato struktura patrná dodnes v rozmístění budov. Dnes však již hospodaříme s krajinou jinými způsoby a tak lze podobné rozdělení vysledovat stále řídčeji</p>\t\t\t\t<h3>O Keši</h3>\t\t\t\t<p>Kterých dílů se naše povídání týká, zda-li Zuberských, Tylovských, Hažovských Vingantských, nebo Hutiských vám však neprozradíme. Na to budete muset ze žlutých indicií zjistit správné heslo pro odemčení tohoto bonusu. Hodně štěstí při jejich získávání i při dedukci hesla.</p>",
                "bonus_code": "orbital",
                "waypoints": [{ "waypoint": 71, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 30, "name": "Reference", "description": "Zde nic není.", "latitude": 4.945648420000000, "longitude": 1.818987690000000 }, { "waypoint": 72, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 30, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.942313330000000, "longitude": 1.819563330000000 }, { "waypoint": 73, "waypoint_type": "PAR", "waypoint_visibility": "HW", "post": 30, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.942427810000000, "longitude": 1.821136810000000 }]
            }, {
                "post": 31,
                "post_type": "BON",
                "color": "RED",
                "name": "Červený bonus",
                "max_score": 150,
                "difficulty": "2",
                "terrain": "2.5",
                "size": "R",
                "cache_type": "TRA",
                "shibboleth": "koruna",
                "with_staff": false,
                "hint": "Visí na malém smrčku na vyvráceném pařezu nad vodou",
                "help": "",
                "description": "<h2>Sklářství na Valašsku</h2>                <p>Od poloviny devatenáctého století se datuje rozmach sklářského průmyslu na Valašsku a je spojován s firmou S.REICH. Firma si pronajala od panství Valašské Meziříčí - Rožnov sklárnu Františčina Huť ve Velkých Karlovicích, poté v roce 1855 zahájila provoz ve své největší sklárně v Krásně ve Valašském Meziříčí, dále od roku 1861 začala provozovat Mariánskou Huť ve Velkých Karlovicích, v roce 1862 otevřela sklárnu Karolinina Huť v Novém Hrozenkově. Dozvuky tohoto rozmachu jsou patrné i dnes, sklárny stále fungují v Karolince a tradice výroby skla dodnes přetrvává i ve Valašském Meziříčí.<br>                Ovšem ještě před industrializací sklářské výroby a vzniku velkých skláren, existovaly na Valašsku malé hutě, jejichž vznik je datován do 15. až 16. století. Do dnešních dní se po nich nedochovalo více, než názvy obcí a místních částí. Jednou z obcí, jejíž historie je spojena se sklářskými hutěmi je Hutisko-Solanec. Sklárny byly na místě Hutiska založeny v první polovině 17. století, samotná osada vznikla později, po roce 1656 (roku 1666 byla prohlášena za obec). V první polovině 18. století byla huť z Hutiska přesunuta jinam.</p>                <h3>Zdroje</h3>                <ul>                    <li>http://www.obeliskval.cz</li>                    <li>http://www.sreich.cz</li>                    <li>http://www.lesycr.cz/volny-cas-v-lese/naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>                    <li>http://www.lesycr.cz/volny-cas-v-lese/naucne-stezky/Documents/T3-lesy-vyuziti.pdf</li>                </ul>",
                "bonus_code": "bitcoin",
                "waypoints": [{ "waypoint": 74, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 31, "name": "Reference", "description": "Zde nic není.", "latitude": 4.943810060000000, "longitude": 1.826593890000000 }, { "waypoint": 75, "waypoint_type": "FIN", "waypoint_visibility": "HW", "post": 31, "name": "Umístění finálky", "description": "Zde se nachází keš.", "latitude": 4.947031670000000, "longitude": 1.827735000000000 }, { "waypoint": 76, "waypoint_type": "PAR", "waypoint_visibility": "HW", "post": 31, "name": "Parkoviště", "description": "Zde můžete zaparkovat.", "latitude": 4.946994970000000, "longitude": 1.827777470000000 }]
            }, {
                "post": 32,
                "post_type": "END",
                "color": "TRA",
                "name": "Cíl",
                "max_score": 0,
                "difficulty": "1",
                "terrain": "1",
                "size": "O",
                "shibboleth": "Finito",
                "with_staff": true,
                "help": "",
                "description": "<p><strong>Gratulejeme k dokončení závodu BRAZDA 2016<\/strong>.<br> Těšíme se na Vás u vyhlášení výsledků.</p>                <p><strong>Uvidíme se zde<\/strong> opět <strong>v 18.30<\/strong>, kdy závod končí.</p>",
                "waypoints": [{ "waypoint": 77, "waypoint_type": "REF", "waypoint_visibility": "VW", "post": 32, "name": "Cíl", "description": "Místo cíle závodu BRAZDA 2016.", "latitude": 4.946714940000000, "longitude": 1.816336830000000 }]
            }
        ]
    };

    vm.getPost = function (id) {
        return $filter("filter")(vm.getPosts(), { "post": id }, true)[0];
    }

    vm.getCacheTypes = function () {
        return [
            { "cache_type": "TRA", "name": "Tradiční keš" },
            { "cache_type": "MLT", "name": "Multi keš" },
            { "cache_type": "MYS", "name": "Mystery keš" },
            { "cache_type": "ERT", "name": "Earth keš" },
            { "cache_type": "WIG", "name": "Where I Go keš" }
        ];
    }

    vm.getLogTypes = function () {
        return [
            { "log_type": "STR", "name": "Start" },
            { "log_type": "FIN", "name": "Cíl" },
            { "log_type": "OUT", "name": "Splněno" },
            { "log_type": "BON", "name": "Bonus" },
            { "log_type": "ERR", "name": "Chyba" },
            { "log_type": "HLP", "name": "Nápověda" }
        ];
    }

    vm.getPostColors = function () {
        return [
            { "color": "TRA", "name": "Žádná", "code": "transparent" },
            { "color": "RED", "name": "Červená", "code": "rgb(247, 150, 70)" },
            { "color": "YEL", "name": "Žlutá", "code": "rgb(255, 255, 153)" },
            { "color": "GRN", "name": "Zelená", "code": "rgb(146, 208, 80)" },
            { "color": "BLU", "name": "Modrá", "code": "rgb(66, 133, 244)" },
            { "color": "WHT", "name": "Bílá", "code": "rgb(255, 255, 255)" }
        ];
    }

    vm.getTerrains = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1.5", "value": "1,5" },
            { "name": "2", "value": "2" },
            { "name": "2.5", "value": "2,5" },
            { "name": "3", "value": "3" },
            { "name": "3.5", "value": "3,5" },
            { "name": "4", "value": "4" },
            { "name": "4.5", "value": "4,5" },
            { "name": "5", "value": "5" },
        ];
    }

    vm.getDifficulties = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1.5", "value": "1,5" },
            { "name": "2", "value": "2" },
            { "name": "2.5", "value": "2,5" },
            { "name": "3", "value": "3" },
            { "name": "3.5", "value": "3,5" },
            { "name": "4", "value": "4" },
            { "name": "4.5", "value": "4,5" },
            { "name": "5", "value": "5" },
        ];
    }

    vm.getPostSizes = function () {
        return [
            { "size": "M", "name": "Mikro" },
            { "size": "S", "name": "Malá" },
            { "size": "R", "name": "Střední" },
            { "size": "L", "name": "Velká" },
            { "size": "O", "name": "Jiná" }
        ];
    }

    vm.getPostTypes = function () {
        return [
            { "post_type": "BEG", "name": "Start" },
            { "post_type": "END", "name": "Cíl" },
            { "post_type": "ORG", "name": "Organizace" },
            { "post_type": "ACT", "name": "Aktivita" },
            { "post_type": "CIP", "name": "Šifra" },
            { "post_type": "CGC", "name": "Keš" },
            { "post_type": "BON", "name": "Bonus" }
        ];
    }

    vm.getWaypointTypes = function () {
        return [
            { "waypoint_type": "FIN", "rank": "1", "name": "Finální umístění" },
            { "waypoint_type": "STA", "rank": "2", "name": "Stage" },
            { "waypoint_type": "REF", "rank": "3", "name": "Zajímavé místo" },
            { "waypoint_type": "PAR", "rank": "4", "name": "Parkoviště" },
            { "waypoint_type": "WAY", "rank": "5", "name": "Stezka" }
        ];
    }

    vm.getWaypointVisibilities = function () {
        return [
            { "waypoint_visibility": "VW", "name": "Viditelná" },
            { "waypoint_visibility": "HC", "name": "Bez souřadnic" },
            { "waypoint_visibility": "HW", "name": "Skrytá" }
        ];
    }
}