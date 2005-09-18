begin;

insert into event_types (name) values ('Organization Pending');
insert into event_types (name) values ('Organization Approval');
insert into event_types (name) values ('Organization Rejected');
insert into event_types (name) values ('Organization Activated');
insert into event_types (name) values ('Organization Deactivated');

create table badge_status (
    id serial primary key,
    name text not null default ''
);
create index badge_status_name on badge_status (name);

alter table people add column badge_status_id references badge_status (id);
alter table people alter column badge_status_id set default 1;
update people set badge_status_id = 1;
alter table people alter column badge_status_id set not null;

insert into badge_status (name) values ('Not Started');
insert into badge_status (name) values ('Badge Printed');
insert into badge_status (name) values ('Badge Issued');

rollback;
--commit;
