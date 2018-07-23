begin;

create table messages (
	message serial not null,
	moment  timestamp not null default current_timestamp,
	content text not null,
	primary key (message)
);

create table teams_has_messages (
	team    integer not null,
	message integer not null,
	primary key (team, message),
	foreign key (team) references teams(team) on update cascade on delete cascade,
	foreign key (message) references messages(message) on update cascade on delete cascade
);

create table settings (
	setting character varying (20) not null,
	"value" text,
	primary key (setting)
);

create view settings_view as
	select setting, "value"
	from settings
	union
	select 'serverTime' as setting, current_timestamp::text as "value"
	union
	select 'raceFinish' as setting, (s1."value"::timestamp + s2."value"::interval)::text as "value"
	from settings s1, settings s2
	where s1.setting like 'raceStart'
	  and s2.setting like 'raceDuration';


insert into settings values
('raceDuration', '12 hour'),
('raceStart', null);

commit;
