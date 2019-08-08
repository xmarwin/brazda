begin;

update team_types
set name = 'Dospělý tým'
where team_type LIKE 'COM';

insert into team_types
values ('KID', 'Dětský tým');

update "schema"
set "version" = 21;

commit;
