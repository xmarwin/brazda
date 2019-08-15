begin;

alter table "attributes"
add column "code" integer;

update "attributes"
set "code" = 1
where "attribute" LIKE 'DOG';


update "attributes"
set "code" = 2
where "attribute" LIKE 'FEE';

update "attributes"
set "code" = 3
where "attribute" LIKE 'RAP';

update "attributes"
set "code" = 4
where "attribute" LIKE 'BOT';

update "attributes"
set "code" = 5
where "attribute" LIKE 'SCB';

update "attributes"
set "code" = 6
where "attribute" LIKE 'KID';

update "attributes"
set "code" = 7
where "attribute" LIKE 'OHR';

update "attributes"
set "code" = 8
where "attribute" LIKE 'SCN';

update "attributes"
set "code" = 9
where "attribute" LIKE 'HIK';

update "attributes"
set "code" = 10
where "attribute" LIKE 'CLI';

update "attributes"
set "code" = 11
where "attribute" LIKE 'WAD';

update "attributes"
set "code" = 12
where "attribute" LIKE 'SWM';

update "attributes"
set "code" = 13
where "attribute" LIKE 'AVL';

update "attributes"
set "code" = 14
where "attribute" LIKE 'NGT';

update "attributes"
set "code" = 15
where "attribute" LIKE 'WNT';

update "attributes"
set "code" = 17
where "attribute" LIKE 'PSF';

update "attributes"
set "code" = 18
where "attribute" LIKE 'DGA';

update "attributes"
set "code" = 19
where "attribute" LIKE 'TCK';

update "attributes"
set "code" = 20
where "attribute" LIKE 'MIN';

update "attributes"
set "code" = 21
where "attribute" LIKE 'CLF';

update "attributes"
set "code" = 22
where "attribute" LIKE 'HNT';

update "attributes"
set "code" = 23
where "attribute" LIKE 'DNR';

update "attributes"
set "code" = 24
where "attribute" LIKE 'WCH';

update "attributes"
set "code" = 25
where "attribute" LIKE 'PRK';

update "attributes"
set "code" = 26
where "attribute" LIKE 'PBT';

update "attributes"
set "code" = 27
where "attribute" LIKE 'WTR';

update "attributes"
set "code" = 28
where "attribute" LIKE 'NWC';

update "attributes"
set "code" = 29
where "attribute" LIKE 'PHN';

update "attributes"
set "code" = 30
where "attribute" LIKE 'PCN';

update "attributes"
set "code" = 31
where "attribute" LIKE 'CMP';

update "attributes"
set "code" = 32, name_on = 'Dostupné na kole'
where "attribute" LIKE 'BCL';

insert into "attributes"
values ('MTC', 'Přístup na motorce', 'Nejezdi sem na motorce', 'motorcycles', 3, 33);

update "attributes"
set "code" = 34
where "attribute" LIKE 'QAD';

update "attributes"
set "code" = 35
where "attribute" LIKE 'JEP';

update "attributes"
set "code" = 36
where "attribute" LIKE 'SNM';

update "attributes"
set "code" = 37
where "attribute" LIKE 'HRS';

update "attributes"
set "code" = 38
where "attribute" LIKE 'CPF';

update "attributes"
set "code" = 39
where "attribute" LIKE 'TRN';

update "attributes"
set "code" = 40
where "attribute" LIKE 'STH';

update "attributes"
set "code" = 41
where "attribute" LIKE 'STR';

insert into "attributes"
values ('NMT', 'Nutná údržba', null, 'firstaid', 2, 42);

update "attributes"
set "code" = 43
where "attribute" LIKE 'COW';

update "attributes"
set "code" = 44
where "attribute" LIKE 'FLS';

insert into "attributes"
values ('LFT', 'Lost & Found Tour', 'Není Lost & Found Tour', 'landf', 3, 45);

update "attributes"
set "code" = 46
where "attribute" LIKE 'RVA';

insert into "attributes"
values ('FPZ', 'Potřebuje vyluštit', 'Nepotřebuje vyluštit', 'field_puzzle', 3, 47);

update "attributes"
set "code" = 48
where "attribute" LIKE 'UVN';

update "attributes"
set "code" = 49
where "attribute" LIKE 'SHS';

update "attributes"
set "code" = 50
where "attribute" LIKE 'SKI';

update "attributes"
set "code" = 51
where "attribute" LIKE 'STL';

update "attributes"
set "code" = 52
where "attribute" LIKE 'NGC';

update "attributes"
set "code" = 53
where "attribute" LIKE 'PNG';

update "attributes"
set "code" = 54
where "attribute" LIKE 'ABB';

update "attributes"
set "code" = 55
where "attribute" LIKE 'HKS';

update "attributes"
set "code" = 56
where "attribute" LIKE 'HKM';

update "attributes"
set "code" = 57
where "attribute" LIKE 'HKL';

update "attributes"
set "code" = 58
where "attribute" LIKE 'FUL';

insert into "attributes"
values ('FDN', 'Blízké občerstvení', 'Poblíž není občerstvení', 'food', 3, 59);

update "attributes"
set "code" = 60
where "attribute" LIKE 'WLB';

insert into "attributes"
values ('PSC', 'Partnerská keš', 'Nepartnerská keš', 'partnership', 3, 61);

update "attributes"
set "code" = 62
where "attribute" LIKE 'SSA';

update "attributes"
set "code" = 63
where "attribute" LIKE 'TOK';

update "attributes"
set "code" = 64
where "attribute" LIKE 'TRC';

update "attributes"
set "code" = 65
where "attribute" LIKE 'FRY';

update "attributes"
set "code" = 66
where "attribute" LIKE 'TMW';

insert into "attributes"
values ('GCT', 'Geotour', 'Není geotour', 'geotour', 3, 67);

drop view attributes_view;
create view attributes_view as
select
	a."attribute",
	a.code,
	a.name_on,
	a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-yes.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-no.png' ELSE NULL END AS icon_off,
	a.status_count
from attributes a;

drop view posts_has_attributes_view;
create view posts_has_attributes_view as
select
	pha.post,
	pha."attribute",
	a.code,
	a.name_on,
	a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-yes.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-no.png' ELSE NULL END AS icon_off,
	a.status_count,
	pha.status
from posts_has_attributes pha
join "attributes" a using ("attribute");

drop view posts_has_attributes_all_view;
create view posts_has_attributes_all_view as
select
    a."attribute",
	a.code,
    a.name_on,
    a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-yes.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-no.png' ELSE NULL END AS icon_off,
    a.status_count,
    pha.post,
    pha.status
from "attributes" a
left join posts_has_attributes pha using ("attribute");


update "schema"
set "version" = 23;

commit;
