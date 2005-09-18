begin;

create table badge_status (
    id serial primary key,
    name text not null default ''
);
create index badge_status_name on badge_status (name);

insert into badge_status (id,name) values (1,'Not Started');
insert into badge_status (id,name) values (2,'Badge Printed');
insert into badge_status (id,name) values (3,'Badge Issued');
select setval('badge_status_id_seq',3);

alter table people add column badge_status_id references badge_status (id);
alter table people alter column badge_status_id set default 1;
update people set badge_status_id = 1;
alter table people alter column badge_status_id set not null;

rollback;
--commit;
