begin;

alter table teams
add column is_disqualified boolean not null default false;

update "schema"
set "version" = 26;

commit;

