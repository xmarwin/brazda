begin;

insert into team_types values
('COM', 'Závodníci'),
('ORG', 'Organizátoři');

insert into post_types values
('BEG', 'Start'),
('END', 'Cíl'),
('ORG', 'Organizace'),
('ACT', 'Aktivita'),
('CIP', 'Šifra'),
('CGC', 'Keš'),
('BON', 'Bonus');

insert into post_colors values
('TRA', 'žádn', 'transparent'),
('RED', 'červen', 'rgb(247, 150, 70)'),
('YEL', 'žlut', 'rgb(255, 255, 153)'),
('GRN', 'zelen', 'rgb(146, 208, 80)'),
('BLU', 'modr', 'rgb(66, 133, 244)'),
('WHT', 'bíl', 'rgb(255, 255, 255)');

insert into post_sizes values
('M', 'Mikro'),
('S', 'Malá'),
('R', 'Střední'),
('L', 'Velká'),
('O', 'Jiná');

insert into cache_types values
('TRA', 'Tradiční keš'),
('MLT', 'Multi keš'),
('MYS', 'Mystery keš'),
('ERT', 'Earth keš'),
('WIG', 'Where I Go keš');

insert into waypoint_types values
('FIN', 1, 'Finální umístění'),
('STA', 2, 'Stage'),
('REF', 3, 'Zajímavé místo'),
('PAR', 4, 'Parkoviště'),
('WAY', 5, 'Stezka');

insert into waypoint_visibilities values
('VW', 'Viditelná'),
('HC', 'Bez souřadnic'),
('HW', 'Skrytá');

insert into log_types values
('STR', 'Start'),
('FIN', 'Cíl'),
('OUT', 'Splněno'),
('BON', 'Bonus'),
('ERR', 'Chyba'),
('HLP', 'Nápověda');

commit;
