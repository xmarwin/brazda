begin;

alter table teams
add column tracking_allowed boolean not null default true;

update teams
set tracking_allowed = false
where team_type = 'ORG';

commit;
