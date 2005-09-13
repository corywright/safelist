begin;
-- add and update volunteer checked_in
alter table volunteers add checked_in boolean;
alter table volunteers alter checked_in set default 'f';
update volunteers set checked_in = 'f';
update volunteers set checked_in = 't' where id in (
    select id from (
        select distinct on (v.id) v.id,e.event_time as "last_in"
	from volunteers v left join events e on (e.volunteer_id = v.id)
	where e.event_type_id = '3'
	order by v.id, e.event_time desc
    ) as "sub_in"
    left join (
	select distinct on (v.id) v.id,e.event_time as "last_out"
	from volunteers v left join events e on (e.volunteer_id = v.id)
	where e.event_type_id = '4'
	order by v.id, e.event_time desc
    ) as "sub_out"
    using (id) where last_in > last_out or last_out is null
);

-- add the org schema stuff
create table organization_types (
  id serial not null primary key,
  name text not null default ''
);
create index organization_types_name on organization_types (name);

create table organization_statuses (
  id serial not null primary key,
  name text not null default ''
);
create index organization_statuses_name on organization_statuses (name);

create table organizations (
  id serial not null primary key,
  name text not null default '',
  emergency_instructions text not null default '',
  address_id int4 NOT NULL,
  nonprofit boolean not null default 'f',
  organization_type_id integer not null references organization_types (id),
  organization_status_id integer not null references organization_statuses (id),
  radio_channel text not null default '',
  FOREIGN KEY("address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE 
);
create index organizations_name on organizations (name);
create index organizations_emergency_instructions on organizations (emergency_instructions);
create index organizations_address_id on organizations (address_id);
create index organizations_nonprofit on organizations (nonprofit);
create index organizations_organization_type_id on organizations (organization_type_id);
create index organizations_organization_status_id on organizations (organization_status_id);
create index organizations_radio_channel on organizations (radio_channel);

create table departments (
  id serial not null primary key,
  organization_id integer not null references organizations (id),
  name text not null default '',
  services text not null default '',
  operating_hours text not null default '',
  operating_requirements text not null default ''  
);
create index departments_organization_id on departments (organization_id);
create index departments_name on departments (name);
create index departments_services on departments (services);
create index departments_operating_hours on departments (operating_hours);
create index departments_operating_requirements on departments (operating_requirements);

create table organization_members (
  id serial not null primary key,
  department_id integer references departments (id),
  organization_id integer references organizations (id),
  first_name text not null default '',
  last_name text not null default '',
  phone text not null default '',
  email text not null default '',
  availability text not null default '',
  title text not null default '',
  checked_in boolean default 'f',
  role text not null default ''
);
create index organization_members_department_id on organization_members (department_id);
create index organization_members_organization_id on organization_members (organization_id);
create index organization_members_first_name on organization_members (first_name);
create index organization_members_last_name on organization_members (last_name);
create index organization_members_phone on organization_members (phone);
create index organization_members_email on organization_members (email);
create index organization_members_availability on organization_members (availability);
create index organization_members_title on organization_members (title);
create index organization_members_role on organization_members (role);

-- add the new event types
select setval('event_types_id_seq',10);
insert into event_types (name) values ('Organization Member Check In');
insert into event_types (name) values ('Organization Member Check Out');

-- add the new columns to the event table
alter table events add organization_member_id integer references organization_members (id);
alter table events add organization_id integer references organizations (id);

-- add the org types
insert into organization_types (name) values ('Volunteer');
insert into organization_types (name) values ('Contractor');
insert into organization_types (name) values ('Staff');

-- add the org statuses
insert into organization_statuses (name) values ('Pending');
insert into organization_statuses (name) values ('Approved');
insert into organization_statuses (name) values ('Rejected');
commit;
