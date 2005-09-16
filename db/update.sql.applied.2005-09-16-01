begin;
create table notes (
    id serial not null primary key,
    created_at timestamp default now(),
    subject text default '',
    body text default ''
);
create index notes_created_time on notes (created_time);
create index notes_subject on notes (subject);

create table notes_volunteers (
    note_id integer not null references notes (id),
    volunteer_id integer not null references volunteers (id)
);
create index notes_volunteers_note_id on notes_volunteers (note_id);
create index notes_volunteers_volunteer_id on notes_volunteers (volunteer_id);

create table notes_people (
    note_id integer not null references notes (id),
    person_id integer not null references people (id)
);
create index notes_people_note_id on notes_people (note_id);
create index notes_people_person_id on notes_people (person_id);

create table notes_organization_members (
    note_id integer not null references notes (id),
    organization_member_id integer not null references organization_members (id)
);
create index notes_organization_members_note_id on notes_organization_members (note_id);
create index notes_organization_members_person_id on notes_organization_members (organization_member_id);

create table families_notes (
    note_id integer not null references notes (id),
    family_id integer not null references families (id)
);
create index families_notes_note_id on families_notes (note_id);
create index families_notes_family_id on families_notes (family_id);

create table notes_shelters (
    note_id integer not null references notes (id),
    shelter_id integer not null references shelters (id)
);
create index notes_shelters_note_id on notes_shelters (note_id);
create index notes_shelters_shelter_id on notes_shelters (shelter_id);

create table notes_organizations (
    note_id integer not null references notes (id),
    organization_id integer not null references organizations (id)
);
create index notes_organizations_note_id on notes_organizations (note_id);
create index notes_organizations_organization_id on notes_organizations (organization_id);

create table departments_notes (
    note_id integer not null references notes (id),
    department_id integer not null references departments (id)
);
create index departments_notes_note_id on departments_notes (note_id);
create index departments_notes_department_id on departments_notes (department_id);

create table injury_reports_notes (
    note_id integer not null references notes (id),
    injury_report_id integer not null references injury_reports (id)
);
create index injury_reports_notes_note_id on injury_reports_notes (note_id);
create index injury_reports_notes_injury_report_id on injury_reports_notes (injury_report_id);

CREATE TABLE "users" (
     "id" SERIAL NOT NULL UNIQUE primary key,
     "login" text,
     "password" text,
     shelter_id int4 not null default 1,
     FOREIGN KEY("shelter_id") REFERENCES "shelters" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
create index users_login on users (login);
create index users_password on users (password);
create index users_shelter_id on users (shelter_id);

INSERT INTO users (login, password, shelter_id) VALUES ('windsor', 'windsor', 2);
INSERT INTO users (login, password, shelter_id) VALUES ('levi', 'levi', 3);
INSERT INTO users (login, password, shelter_id) VALUES ('freeman', 'freeman', 5);
INSERT INTO users (login, password, shelter_id) VALUES ('rackspace', 'rackspace', 1);
INSERT INTO users (login, password, shelter_id) VALUES ('kelly171', 'kelly171', 4);
INSERT INTO users (login, password, shelter_id) VALUES ('kelly1536', 'kelly1536', 6);

CREATE TABLE "pictures" (
    "id" SERIAL NOT NULL UNIQUE primary key,
    "image" text,
    person_id integer,
    FOREIGN KEY("person_id") REFERENCES "person" ("id");
);
create index pictures_person_id on pictures (person_id);

rollback;
--commit;
