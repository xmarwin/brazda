begin;

update post_types
set rank = rank + 1
where rank > 4;

insert into post_types
values ('SBN', 'Superbonus', 5);

commit;
