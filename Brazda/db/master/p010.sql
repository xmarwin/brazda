begin;

alter table post_types
add column rank integer;

update post_types
set rank = 0
where post_type = 'BEG';

update post_types
set rank = 1
where post_type = 'ACT';

update post_types
set rank = 2
where post_type = 'CIP';

update post_types
set rank = 3
where post_type = 'CGC';

update post_types
set rank = 4
where post_type = 'BON';

update post_types
set rank = 5
where post_type = 'END';

update post_types
set rank = 6
where post_type = 'ORG';

alter table post_types
alter column rank set not null;

commit;
