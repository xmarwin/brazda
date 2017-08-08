begin;

create table team_statuses (
    team_status character (3) not null,
    name        character varying (20) not null,
    primary key (team_status),
    unique (name)
);

insert into team_statuses (team_status, name) values
('STR', 'Před startem'),
('CMP', 'Závodí'),
('FIN', 'V cíli');

alter table teams
add column team_status character (3) not null default 'STR';

alter table teams
add foreign key (team_status) references team_statuses(team_status) on update cascade on delete restrict;

commit;
