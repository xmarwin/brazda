begin;

alter table posts
add column time_estimate text;

update "schema"
set "version" = 19;

commit;
