begin;

create view attributes_view as
select
	a."attribute",
	a.name_on,
	a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-yes.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-no.png' ELSE NULL END AS icon_off,
	a.status_count
from attributes a;

update "schema"
set "version" = 22;

commit;
