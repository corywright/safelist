"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 template1 "delmendo" -c "DROP DATABASE safelist_development"
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 template1 "delmendo" -c "DROP DATABASE safelist_test"
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 template1 "delmendo" -c "CREATE DATABASE safelist_test"
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 template1 "delmendo" -c "CREATE DATABASE safelist_development"
pause

"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f create.sql

"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.person_types.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.addresses.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.shelters.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.event_types.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.organization_status.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.family0.sql

"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.families.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.ethnicities.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.badge_status.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.people.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.volunteers.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.injury_reports.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.organization_types.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.organization_status.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.organizations.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.departments.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.organization_members.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.events.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.notes.sql
"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_development "delmendo" -f data.users.sql

"C:\Program Files\PostgreSQL\8.0\bin\psql.exe"  -h localhost -p 5432 safelist_test "delmendo" -f create.sql

pause
