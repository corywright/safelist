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

psql safelist_test<create.sql
