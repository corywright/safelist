-- This file is part of the SafeList shelter management software.
-- Copyright 2005, Rackspace Managed Hosting

CREATE OR REPLACE FUNCTION drop_if_exists (text) RETURNS INTEGER AS '
DECLARE
    tbl_name ALIAS FOR $1;
BEGIN
    IF (select count(*) from pg_tables where tablename=$1) THEN EXECUTE ''DROP TABLE '' || $1 || '' CASCADE'' ;
    RETURN 1;
    END IF;
    RETURN 0;
END;
'
language 'plpgsql';


select drop_if_exists('addresses');
CREATE TABLE addresses(
    id serial PRIMARY KEY,
    street text NOT NULL DEFAULT '' ,
    city text NOT NULL DEFAULT '',
    state text NOT NULL DEFAULT '' ,
    zipcode text NOT NULL DEFAULT '' ,
    country text NOT NULL DEFAULT '' ,
    phone text NOT NULL DEFAULT '', 
    fax text NOT NULL DEFAULT '' 
);
create index addresses_street on addresses (street);
create index addresses_city on addresses (city);
create index addresses_state on addresses (state);
create index addresses_zipcode on addresses (zipcode);
create index addresses_country on addresses (country);
create index addresses_phone on addresses (phone);
create index addresses_fax on addresses (fax);

select drop_if_exists('person_types');
CREATE TABLE person_types(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);
create index person_types_name on person_types (name);

select drop_if_exists('shelters');
CREATE TABLE shelters(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    address_id int4 NOT NULL,
    tag_id_prefix text not null unique,
    domain text not null unique,
    FOREIGN KEY("address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE 
);
create index shelters_name on shelters (name);
create index shelters_address_id on shelters (address_id);
create index shelters_tag_id_prefix on shelters (tag_id_prefix);
create index shelters_domain on shelters (domain);

select drop_if_exists('families');
CREATE TABLE families(
    id serial PRIMARY KEY,
    disclosure_consent boolean default 'f',
    pre_disaster_address_id int4 NOT NULL,
    post_disaster_address_id int4,
    FOREIGN KEY("pre_disaster_address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE ,
    FOREIGN KEY("post_disaster_address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE 
);
create index families_disclosure_consent on families (disclosure_consent);
create index families_pre_disaster_address_id on families (pre_disaster_address_id);
create index families_post_disaster_address_id on families (post_disaster_address_id);

select drop_if_exists('people');
CREATE TABLE people(
    id serial PRIMARY KEY,
    tag_id text NOT NULL default '',
    first_name text NOT NULL default '',
    last_name text NOT NULL default '',
    family_id int4,
    person_type_id int4 NOT NULL,
    medical_problems text NOT NULL default '',
    ssn text NOT NULL default '',
    dob date NOT NULL default now(),
    shelter_id int4,
    location_description text NOT NULL default '',
    resume text NOT NULL default '',
    fema_reg_id text default '',
    debit_id text default '',
    FOREIGN KEY("family_id") REFERENCES "families" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("person_type_id") REFERENCES "person_types" ("id") ON UPDATE CASCADE ,
    FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE 
);
create index people_tag_id on people (tag_id);
create index people_first_name on people (first_name);
create index people_last_name on people (last_name);
create index people_family_id on people (family_id);
create index people_person_type_id on people (person_type_id);
create index people_medical_problems on people (medical_problems);
create index people_ssn on people (ssn);
create index people_dob on people (dob);
create index people_shelter_id on people (shelter_id);
create index people_location_description on people (location_description);
create index people_resume on people (resume);
create index people_fema_reg_id on people (fema_reg_id);
create index people_debit_id on people (debit_id);

select drop_if_exists('volunteers');
CREATE TABLE volunteers(
    id serial PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    dob date NOT NULL default now(),
    trained_by_red_cross boolean NOT NULL default 'f',
    email text not null default '',
    home_phone text not null default '',
    mobile_phone text not null default '',
    affiliation text not null default '',
    location text not null default '',
    role text not null default '',
    shelter_id int4,
    badge_id text default '',
    dl_number text default '',
    checked_in boolean default 'f',
    FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE 
);
create index volunteers_first_name on volunteers (first_name);
create index volunteers_last_name on volunteers (last_name);
create index volunteers_dob on volunteers (dob);
create index volunteers_trained_by_red_cross on volunteers (trained_by_red_cross);
create index volunteers_email on volunteers (email);
create index volunteers_home_phone on volunteers (home_phone);
create index volunteers_mobile_phone on volunteers (mobile_phone);
create index volunteers_affiliation on volunteers (affiliation);
create index volunteers_location on volunteers (location);
create index volunteers_role on volunteers (role);
create index volunteers_shelter_id on volunteers (shelter_id);
create index volunteers_badge_id on volunteers (badge_id);
create index volunteers_dl_number on volunteers (dl_number);
create index volunteers_checked_in on volunteers (checked_in);

select drop_if_exists('injury_reports');
CREATE TABLE injury_reports(
    id serial PRIMARY KEY,
    person_id int4 not null,
    description text NOT NULL default '',
    report text NOT NULL default '',
    referred_to_nurse boolean not null default 'f',
    FOREIGN KEY("person_id") REFERENCES "people" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
create index injury_reports_person_id on injury_reports (person_id);
create index injury_reports_description on injury_reports (description);
create index injury_reports_report on injury_reports (report);
create index injury_reports_referred_to_nurse on injury_reports (referred_to_nurse);

select drop_if_exists('organization_types');
create table organization_types (
  id serial not null primary key,
  name text not null default ''
);
create index organization_types_name on organization_types (name);

create table organization_status (
  id serial not null primary key,
  name text not null default ''
);
create index organization_status_name on organization_status (name);

select drop_if_exists('organizations');
create table organizations (
  id serial not null primary key,
  name text not null default '',
  emergency_instructions text not null default '',
  address_id int4 NOT NULL,
  nonprofit boolean not null default 'f',
  organization_type_id integer not null references organization_types (id),
  organization_status_id integer not null references organization_status (id),
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

select drop_if_exists('departments');
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

select drop_if_exists('organization_members');
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

select drop_if_exists('event_types');
CREATE TABLE event_types(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);
create index event_types_name on event_types (name);

select drop_if_exists('events');
CREATE TABLE events(
    id serial PRIMARY KEY,
    event_time timestamp NOT NULL default now(),
    event_type_id int4 not null,
    person_id int4,
    volunteer_id int4,
    organization_member_id int4,
    organization_id int4,
    shelter_id int4,
    notes text not null default '',
    FOREIGN KEY("person_id") REFERENCES "people" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("volunteer_id") REFERENCES "volunteers" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("event_type_id") REFERENCES "event_types" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY("organization_member_id") REFERENCES "organization_members" ("id") ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY("organization_id") REFERENCES "organizations" ("id") ON UPDATE CASCADE ON DELETE CASCADE 
);
create index events_event_time on events (event_time);
create index events_event_type_id on events (event_type_id);
create index events_person_id on events (person_id);
create index events_volunteer_id on events (volunteer_id);
create index events_shelter_id on events (shelter_id);
create index events_notes on events (notes);
