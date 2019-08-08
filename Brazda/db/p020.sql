begin;

create table "attributes" (
	"attribute"  character(3) not null,
	name_on      text not null,
	name_off     text,
	icon         character varying(20) not null,
    status_count smallint not null,
	primary key ("attribute")
);

insert into "attributes" values
('DOG', 'Přístup se psy', 'Nepřístupné se psy', 'dogs', 3),
('FEE', 'Zpoplatněné vstupné nebo parkování', null, 'fee', 2),
('RAP', 'Nutná horolezecká výbava', null, 'rapelling', 2),
('BOT', 'Přístup lodí', null, 'boat', 2),
('SCB', 'Potápěčská výbava', null, 'scuba', 2),
('KID', 'Vhodné pro děti', 'Nevhoné pro děti', 'kids', 3),
('OHR', 'Zabere max. hodinu', 'Zabere více než hodinu', 'onehour', 3),
('SCN', 'Vyhlídka', 'Žádné vyhlídkové místo', 'scenic', 3),
('HIK', 'Dlouhý výšlap', 'Nenáročný výšlap', 'hiking', 3),
('CLI', 'Obtížný výstup', 'Nepotřebuješ horolezeckou výbavu', 'climbing', 3),
('WAD', 'Může vyžadovat brodění', null, 'wading', 2),
('SWM', 'Může vyžadovat plavání', null, 'swimming', 2),
('AVL', 'Dostupné nonstop (24/7)', 'Dostupné pouze v omezeném čase', 'available', 3),
('NGT', 'Doporučeno v noci', 'Nedoporučuje se lovit v noci', 'night', 3),
('WNT', 'Přístupné i v zimě', 'Nedostupné v zimě', 'winter', 3),
('PSF', 'Jedovaté rostliny', 'Žádné jedovaté rostliny v okolí', 'poisonak', 3),
('DGA', 'Nebezpečná zvířata', null, 'dangerousanimals', 2),
('TCK', 'Klíšťata', null, 'ticks', 2),
('MIN', 'Opuštěné doly', null, 'mines', 2),
('CLF', 'Útesy / padající kameny', null, 'cliff', 2),
('HNT', 'Oblast lovu',  null, 'hunting', 2),
('DNR', 'Nebezpečná oblast', null, 'danger', 2),
('WCH', 'Vhodné pro vozíčkáře', 'Není přístupné pro vozíčkáře', 'wheelchair', 3),
('PRK', 'Možnost parkování', 'žádné parkování poblíž', 'parking', 3),
('PBT', 'Přístupné veřejnou dopravou', null, 'public', 2),
('WTR', 'Blízký zdroj pitné vody', 'V okolí není pitná voda', 'watter', 3),
('NWC', 'Bblízké veřejné WC', 'V okolí nejsou veřejné toalety', 'restrooms', 3),
('PHN', 'Blízká telefonní budka', 'Žádná telefonní budka poblíž', 'phone', 3),
('PCN', 'Blízké piknikové místo', 'Piknikové stoly tady nenajdeš', 'picnic', 3),
('CMP', 'Možnost táboření', 'Táboření zde není povoleno', 'camping', 3),
('BCL', 'dostupné na kole', 'Nejezdi sem na kole', 'bicycles', 3),
('QAD', 'Přístup na čtyřkolce', 'Nejezdi sem na čtyřkolce', 'quad', 3),
('JEP', 'Přístup teréním autem', 'Nejezdi sem teréním
 autem', 'jeeps', 3),
('SNM', 'Přístup na sněžném skůtru', 'Nejezdi sem na sněžném skůtru', 'snowmobile', 3),
('HRS', 'Přístup na koni', 'Nejezdi sem na koni', 'horses', 3),
('CPF', 'Tábořiště', 'Táboření zde není povoleno', 'campfires', 3),
('TRN', 'Trní', null, 'thorn', 2),
('STH', 'Nenápadné chování', 'Není vyžadováno nenápadné chování', 'stealth', 3),
('STR', 'Přístupné s kočárkem', 'Nepřístupné s kočárkem', 'stroller', 3),
('COW', 'Pozor na zvěř', null, 'cow', 2),
('FLS', 'Nutná svítilna', null, 'flashlight', 2),
('RVA', 'Přístupné s přívěsem', 'Nejezdi sem s přívěsem', 'rv', 3),
('UVN', 'Nutné UV světlo', null, 'uv', 2),
('SHS', 'Sněžnice', null, 'snowshoes', 2),
('SKI', 'Přístupné na běžkách', null, 'skiis', 2),
('STL', 'Nutná speciální výbava', null, 's-tool', 2),
('NGC', 'Noční keš', 'Toto není noční keš', 'nightcache', 3),
('PNG', 'Zaparkuj a odlov', 'Není drive-in', 'parkngrab', 3),
('ABB', 'Opuštěné budovy',  'Není v opuštěném objektu', 'abandoned-building', 3),
('HKS', 'Krátka trasa (méně než 1 km)', 'Trasa delší než 1 km',  'hike-short', 3),
('HKM', 'Trasa 1-10 km', 'Toto není středně dlouhá trasa', 'hike-med', 3),
('HKL', 'Dlouhá trasa (více než 10 km)', 'Trasa méně než 10 km', 'hike-long', 3),
('FUL', 'Blízká čerpací stanice', 'Poblíž není žádná čerpací stanice', 'fuel', 3),
('WLB', 'Radiomaják', null, 'wirelessbeacon', 2),
('SSA', 'Sezóní přístup', 'Dostupné po celý rok', 'seasonal', 3),
('TOK', 'Turisticky atraktivní', 'Není ideální pro turisty', 'turist-ok', 3),
('TRC', 'Vyžaduje lezení po stromech', 'Není nutné lézt po stromech', 'treeclimbing', 3),
('FRY', 'Na soukromém pozemku', 'Není umístěno na soukromém pozemku', 'frontyard', 3),
('TMW', 'Vyžaduje týmovou spolupráci', 'Není vyžadována týmová spolupráce', 'teamwork', 3);

create table posts_has_attributes (
	post        integer not null,
	"attribute" character(3) not null,
	status      boolean not null default true,
	primary key (post, attribute, status),
	foreign key (post) references posts(post) on update cascade on delete cascade,
	foreign key ("attribute") references "attributes"("attribute") on update cascade on delete restrict
);

create view posts_has_attributes_view as
select
	pha.post,
	pha."attribute",
	a.name_on,
	a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-on.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-off.png' ELSE NULL END AS icon_off,
	a.status_count,
	pha.status
from posts_has_attributes pha
join "attributes" a using ("attribute");

create view posts_has_attributes_all_view as
select
    a."attribute",
    a.name_on,
    a.name_off,
	'/assets/images/attributes/' || a.icon || '.png' AS icon,
	'/assets/images/attributes/' || a.icon || '-on.png' AS icon_on,
	CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-off.png' ELSE NULL END AS icon_off,
    a.status_count,
    pha.post,
    pha.status
from "attributes" a
left join posts_has_attributes pha using ("attribute");

update "schema"
set "version" = 20;

commit;
