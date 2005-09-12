#!/bin/bash

dropdb safelist_development
dropdb safelist_test
sleep 1;
createdb safelist_development
createdb safelist_test
psql safelist_development <create.sql
psql safelist_development < data.person_types.sql
psql safelist_development < data.addresses.sql
psql safelist_development < data.shelters.sql
psql safelist_development < data.event_types.sql
psql safelist_development < data.family0.sql

# test data
psql safelist_development < data.families.sql
psql safelist_development < data.people.sql
psql safelist_development < data.volunteers.sql
psql safelist_development < data.events.sql
psql safelist_development < data.injury_reports.sql
psql safelist_development < data.organization_types.sql

psql safelist_test < create.sql
