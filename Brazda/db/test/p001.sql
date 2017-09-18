begin;

alter table teams
add column is_active boolean not null default true;

alter table teams
add column security_token varchar(255);

commit;
