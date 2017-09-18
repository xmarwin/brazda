begin;

alter table teams
add column telephone character varying (20);

alter table positions
add column device_id character varying (32) not null;

commit;
