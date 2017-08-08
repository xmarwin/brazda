begin;

create table team_types (
    team_type   character (3) not null,
    name        character varying (20) not null,
    primary key (team_type),
    unique (name)
);

create table teams (
    team        serial not null,
    team_type   character (3) not null default 'COM',
    name        character varying (100) not null,
    shibboleth  character varying (20) not null,
    description text,
    primary key (team),
    foreign key (team_type) references team_types(team_type) on update cascade on delete restrict,
    unique (name)
);

create table players (
    player      serial not null,
    team        integer not null,
    name        character varying (100) not null,
    primary key (player),
    foreign key (team) references teams(team) on update cascade on delete restrict
);



create table post_types (
    post_type   character (3) not null,
    name        character varying (20) not null,
    primary key (post_type)
);

create table post_colors (
    color       character (3) not null,
    name        character varying (10) not null,
    code        character varying (20) not null,
    primary key (color),
    unique (name),
    unique (code)
);

create table post_sizes (
    "size"      character (1) not null,
    name        character varying (20) not null,
    primary key ("size"),
    unique (name)
);

create table cache_types (
    cache_type  character (3) not null,
    name        character varying (32) not null,
    primary key ("cache_type"),
    unique (name)
);

create table posts (
    post            serial not null,
    post_type       character (3) not null,
    color           character (3) not null,
    name            character varying (255) not null,
    max_score       integer not null default 0,
    difficulty      float not null default 1,
    terrain         float not null default 1,
    "size"          character (1) not null default 'O',
    cache_type      character (3) default 'TRA',
    shibboleth      character varying (20) not null,
    with_staff      boolean not null default false,
    hint            text,
    help            text,
    description     text,
    bonus_code      character varying (20),
    open_from       time,
    open_to         time,
    primary key (post),
    foreign key (post_type) references post_types(post_type) on update cascade on delete restrict,
    foreign key (cache_type) references cache_types(cache_type) on update cascade on delete restrict,
    foreign key (color) references post_colors(color) on update cascade on delete restrict,
    foreign key ("size") references post_sizes("size") on update cascade on delete restrict
);

create table post_notes (
    post_note   serial not null,
    post        integer not null,
    team        integer not null,
    last_change timestamp not null default current_timestamp,
    note        text,
    primary key (post_note),
    foreign key (post) references posts(post) on update cascade on delete cascade,
    foreign key (team) references teams(team) on update cascade on delete cascade
);



create table waypoint_types (
    waypoint_type   character (3) not null,
    rank            serial,
    name            character varying (32) not null,
    primary key (waypoint_type),
    unique (name)
);

create table waypoint_visibilities (
    waypoint_visibility character (2) not null,
    name                character varying (32) not null,
    primary key (waypoint_visibility),
    unique (name)
);

create table waypoints (
    waypoint            serial not null,
    waypoint_type       character (3) not null,
    waypoint_visibility character (2) not null default 'VW',
    post                integer not null,
    name                character varying (255) not null,
    description         text,
    latitude            float not null,
    longitude           float not null,
    primary key (waypoint),
    foreign key (waypoint_type) references waypoint_types(waypoint_type) on update cascade on delete restrict,
    foreign key (waypoint_visibility) references waypoint_visibilities(waypoint_visibility) on update cascade on delete restrict,
    foreign key (post) references posts(post) on update cascade on delete cascade
);



create table log_types (
    log_type    character (3) not null,
    name        character varying (20) not null,
    primary key (log_type),
    unique (name)
);

create table logs (
    log         serial not null,
    log_type    character (3) not null,
    team        integer not null,
    post        integer not null,
    moment      timestamp not null default current_timestamp,
    primary key (log),
    foreign key (log_type) references log_types(log_type) on update cascade on delete restrict,
    foreign key (team) references teams(team) on update cascade on delete restrict,
    foreign key (post) references posts(post) on update cascade on delete cascade
);

create table audit_logs (
    audit_log   serial not null,
    team        integer not null,
    moment      timestamp not null default current_timestamp,
    message     text,
    log_type    character varying (10) not null default 'info',
    primary key (audit_log),
    foreign key (team) references teams(team) on update cascade on delete cascade,
    foreign key (log_type) references log_types(log_type) on update cascade on delete restrict
);

commit;
