begin;

create table "schema" (
	"version"	integer	not null default 15
);

insert into "schema"
values (15);

commit;
