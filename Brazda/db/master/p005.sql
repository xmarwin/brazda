begin;

alter table teams
drop column security_token;

create table logins (
    login                serial not null,
    team                 integer not null,
    device_id            character varying (32) not null,
    security_token       character varying (32) not null,
    moment               timestamp not null default current_timestamp,
    last_activity_moment timestamp not null default current_timestamp,
    primary key ("login"),
    foreign key (team) references teams(team) on update cascade on delete restrict,
    unique (security_token),
    unique (team, device_id)
);

commit;
