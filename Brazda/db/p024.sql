begin;

alter table posts
add column shibboleth_kid character varying (20);

alter table posts
add column support text;

alter table posts
add column instructions text;

update settings
set setting = 'raceDuration_COM'
where setting = 'raceDuration';

insert into settings (setting, value)
values ('raceDuration_KID', '10 hour');

drop view settings_view;

create view settings_view as
	select setting, "value"
	from settings
	union
	select 'serverTime' as setting, current_timestamp::text as "value"
	union
        select 'raceFinish_COM' as setting, (s1."value"::timestamp + s2."value"::interval)::text as "value"
        from settings s1, settings s2
        where s1.setting like 'raceStart'
          and s2.setting like 'raceDuration_COM'
	union
        select 'raceFinish_KID' as setting, (s1."value"::timestamp + s2."value"::interval)::text as "value"
        from settings s1, settings s2
        where s1.setting like 'raceStart'
          and s2.setting like 'raceDuration_KID';

update "schema"
set "version" = 24;

commit;

