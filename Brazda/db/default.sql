begin;

insert into teams (team_type, name, shibboleth, description, is_active, team_status, tracking_allowed, telephone, email) values
('ORG', 'BRAZDA', 'Mocn8Klika', 'Organizační tým', true, 'STR', true, null, null);

insert into posts (post_type, color, name, max_score, difficulty, terrain, cache_size, cache_type, shibboleth, with_staff, hint, help, description, bonus_code, open_from, open_to, latitude, longitude, password_character, password_position) values
('BEG', 'TRA', 'Start', 0, 1, 1, 'O', null, 'Start', true, null, null, '<p><strong>Vítejte na startu závodu BRAZDA 2019</strong>.<br> Přejeme Vám hodně štěstí, výdrže a odhodlání jej dokončit :)</p>', null, null, null, 49.4671494, 18.1633683, '_', 0),
('END', 'TRA', 'Cíl', 0, 1, 1, 'O', null, 'Fine', true, null, null, '<p><strong>Gratulejeme k dokončení závodu BRAZDA 2019</strong>.</p><p>Těšíme se na Vás u vyhlášení výsledků.</p><p><strong>Uvidíme se zde</strong> opět <strong>v 20.00</strong>, kdy závod končí.</p>', null, null, null, 49.4671494, 18.1633683, '_', 0);

commit;
