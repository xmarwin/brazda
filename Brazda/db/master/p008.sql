begin;

alter table logins
drop constraint "logins_team_device_id_key";

commit;
