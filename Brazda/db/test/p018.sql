begin;

create or replace function adminBonusPassword(inColor character (3)) returns character varying (20)
as $$
  declare
    password character varying (20) := null;
    rec record;

  begin
    for rec in
      select
        p.password_position,
        p.password_character
      from posts p
      where p.color like inColor
        and p.password_position > 0
      order by p.password_position
    loop
      password := concat(password, rec.password_character);
    end loop;

    return password;
  end;
$$ language plpgsql;

update "schema"
set "version" = 18;

commit;
