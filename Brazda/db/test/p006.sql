begin;

alter table posts
add column latitude  float not null;

alter table posts
add column longitude float not null;

commit;
