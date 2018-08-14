begin;

insert into post_colors
values ('GLD', 'Zlatá', 'rgb(255,215,0)');

update "schema"
set version = 16;

commit;
