begin;

insert into cache_types values
('LTB', 'Letterbox/Hybrid keš'),
('CIT', 'CITO event');

update post_colors
set code = 'rgb(139, 0, 255)'
where color = 'VLT';

commit;
