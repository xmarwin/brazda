begin;

alter table posts
alter column shibboleth
drop not null;

alter table posts
add password_character character varying (2) not null default '_';

alter table posts
add password_position smallint not null default 0;

create or replace function bonusPassword(inColor character (3), inTeam integer) returns character varying (20)
as $$
  declare
    password character varying (20) := null;
    rec record;

  begin
raise notice 'inColor: %', inColor;
raise notice 'inTeam: %', inTeam;
    for rec in
      select
        x.password_position,
        (case when x.team is not null then x.password_character else '_' end) as password_character
      from (
        select distinct
          l.team,
          pv.password_position,
          pv.password_character
        from (
          select
            p.post,
            p.color,
            p.password_position,
            p.password_character
          from posts p
          where p.color like inColor
            and password_position > 0
          order by password_position
        ) pv
        left join (
          select
            post,
            team
          from logs
          where team = inTeam
            and log_type = 'OUT'
        ) l using (post)
        order by password_position
      ) x
    loop
raise notice 'passwordCharacter: %' rec.password_character;
      password := password || rec.password_character;
    end loop;
raise notice 'password: %', password;
    return password;
  end;
$$ language plpgsql;

commit;
