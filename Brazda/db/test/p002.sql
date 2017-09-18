begin;

create table positions (
    position serial,
    team     integer not null,
    moment   timestamp with time zone not null default current_timestamp,
    location point not null,
    primary key (position),
    foreign key (team) references teams(team) on update cascade on delete restrict
);
create index moment_idx on positions using btree (moment);

commit;
