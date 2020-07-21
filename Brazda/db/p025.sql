begin;

update settings
set setting = 'raceStart_COM'
where setting = 'raceStart';

insert into settings (setting, value) values
('raceTitle', 'BRAZDA 2020'),
('raceStart_KID', ''),
('orderPenalization', '5'),
('helpPenalization', '24 hour'),
('timePenalization', '10'),
('disqualificationTime', '20 minutes'),
('hotlineTelephone', '+420 777 634 660');

update "schema"
set "version" = 25;

commit;

