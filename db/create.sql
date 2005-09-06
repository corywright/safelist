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
    phone text NOT NULL DEFAULT '' 
);
select drop_if_exists('person_types');
CREATE TABLE person_types(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);



select drop_if_exists('shelters');
CREATE TABLE shelters(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    address_id int4 NOT NULL,
    FOREIGN KEY("address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE 
);
select drop_if_exists('families');
CREATE TABLE families(
    id serial PRIMARY KEY,
    disclosure_consent boolean default 'f',
    shelter_arrival_on date default now(),
    shelter_departure_at timestamptz default now(),
    pre_disaster_address_id int4 NOT NULL,
    post_disaster_address_id int4,
    FOREIGN KEY("pre_disaster_address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE ,
    FOREIGN KEY("post_disaster_address_id") REFERENCES "addresses" ("id") ON UPDATE CASCADE 
);
select drop_if_exists('people');
CREATE TABLE people(
    id serial PRIMARY KEY,
    tag_id text NOT NULL default '',
    first_name text NOT NULL default '',
    last_name text NOT NULL default '',
    family_id int4 NOT NULL,
    person_type_id int4 NOT NULL,
    age int4 default(0) NOT NULL,
    medical_problems text NOT NULL default '',
    ssn text NOT NULL default '',
    dob date NOT NULL default now(),
    shelter_id int4,
    location_description text NOT NULL default '',
    FOREIGN KEY("family_id") REFERENCES "families" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("person_type_id") REFERENCES "person_types" ("id") ON UPDATE CASCADE ,
    FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE 
);
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
    affiliation text not null default ''
);
select drop_if_exists('event_types');
CREATE TABLE event_types(
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);
select drop_if_exists('events');
CREATE TABLE events(
    id serial PRIMARY KEY,
    event_time timestamp NOT NULL default now(),
    event_type_id int4 not null,
    person_id int4,
    volunteer_id int4,
    shelter_id int4,
    notes text not null default '',
    FOREIGN KEY("person_id") REFERENCES "people" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("volunteer_id") REFERENCES "volunteers" ("id") ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY("event_type_id") REFERENCES "event_types" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE ON DELETE CASCADE 
);
select drop_if_exists('injury_reports');
CREATE TABLE injury_reports(
    id serial PRIMARY KEY,
    person_id int4 not null,
    report text NOT NULL default '',
    referred_to_nurse boolean not null default 'f',
    FOREIGN KEY("person_id") REFERENCES "people" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
