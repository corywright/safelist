begin;
select drop_if_exists('ethnicities');
create table ethnicities (
    id serial primary key,
    name text not null default ''
);
create index ethnicities_name on ethnicities (name);

insert into ethnicities (name) values ('Unknown');
insert into ethnicities (name) values ('Asian');
insert into ethnicities (name) values ('Black / African');
insert into ethnicities (name) values ('East Indian');
insert into ethnicities (name) values ('Hispanic / Latino');
insert into ethnicities (name) values ('Middle Eastern');
insert into ethnicities (name) values ('Native American');
insert into ethnicities (name) values ('Pacific Islander');
insert into ethnicities (name) values ('White / Caucasion');
insert into ethnicities (name) values ('Other');

alter table people add column ethnicity_id integer references ethnicities (id);
alter table people alter column ethnicity_id set default 1;
update  people set ethnicity_id = '1';
alter table people alter column ethnicity_id set not null;

alter table people add column drivers_license_state text;
alter table people alter column drivers_license_state set default '';
update people set drivers_license_state = '';
alter table people alter column drivers_license_state set not null;

alter table people add column drivers_license_number text;
alter table people alter column drivers_license_number set default '';
update people set drivers_license_number = '';
alter table people alter column drivers_license_number set not null;

commit;
