#!/bin/bash

dropdb safelist_development
dropdb safelist_test
sleep 1;
createdb safelist_development
createdb safelist_test
psql -U cwright safelist_development <create.sql
psql -U cwright safelist_development < data.person_types.sql
psql -U cwright safelist_development < data.addresses.sql
psql -U cwright safelist_development < data.shelters.sql
psql -U cwright safelist_development < data.event_types.sql
psql -U cwright safelist_development < data.family0.sql

# test data
psql -U cwright safelist_development < data.families.sql
psql -U cwright safelist_development < data.people.sql
psql -U cwright safelist_development < data.volunteers.sql
psql -U cwright safelist_development < data.events.sql
psql -U cwright safelist_development < data.injury_reports.sql
psql -U cwright safelist_development < data.organization_types.sql
psql -U cwright safelist_development < data.organization_status.sql
psql -U cwright safelist_development < data.organizations.sql
psql -U cwright safelist_development < data.departments.sql
psql -U cwright safelist_development < data.organization_members.sql
psql -U cwright safelist_development < data.notes.sql
psql -U cwright safelist_development < data.users.sql

psql -U cwright safelist_test < create.sql
