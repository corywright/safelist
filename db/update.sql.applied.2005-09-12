-- This file is part of the SafeList shelter management software.
-- Copyright 2005, Rackspace Managed Hosting

-- create indexes for the addresses table
create index addresses_street on addresses (street);
create index addresses_city on addresses (city);
create index addresses_state on addresses (state);
create index addresses_zipcode on addresses (zipcode);
create index addresses_country on addresses (country);
create index addresses_phone on addresses (phone);
create index addresses_fax on addresses (fax);

-- create indexes for the person table
create index person_types_name on person_types (name);

-- create indexes for the shelters table
create index shelters_name on shelters (name);
create index shelters_address_id on shelters (address_id);
create index shelters_tag_id_prefix on shelters (tag_id_prefix);
create index shelters_domain on shelters (domain);

-- create indexes for the families table
create index families_disclosure_consent on families (disclosure_consent);
create index families_pre_disaster_address_id on families (pre_disaster_address_id);
create index families_post_disaster_address_id on families (post_disaster_address_id);

-- create indexes for the people table
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

-- create indexes for the volunteers table
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

-- create indexes for the event_types table
create index event_types_name on event_types (name);

-- create indexes for the events table
create index events_event_time on events (event_time);
create index events_event_type_id on events (event_type_id);
create index events_person_id on events (person_id);
create index events_volunteer_id on events (volunteer_id);
create index events_shelter_id on events (shelter_id);
create index events_notes on events (notes);

-- create indexes for the injury_reports table
create index injury_reports_person_id on injury_reports (person_id);
create index injury_reports_description on injury_reports (description);
create index injury_reports_report on injury_reports (report);
create index injury_reports_referred_to_nurse on injury_reports (referred_to_nurse);

-- create indexes for the organization_types table
create index organization_types_name on organization_types (name);

-- create indexes for the organizations table
create index organizations_name on organizations (name);
create index organizations_address_id on organizations (address_id);
create index organizations_nonprofit on organizations (nonprofit);
create index organizations_organization_type_id on organizations (organization_type_id);
create index organizations_radio_channel on organizations (radio_channel);

-- create indexes for the departments table
create index departments_organization_id on departments (organization_id);
create index departments_name on departments (name);
create index departments_services on departments (services);
create index departments_operating_hours on departments (operating_hours);
create index departments_operating_requirements on departments (operating_requirements);

-- create indexes for the organization_members table
create index organization_members_department_id on organization_members (department_id);
create index organization_members_organization_id on organization_members (organization_id);
create index organization_members_first_name on organization_members (first_name);
create index organization_members_last_name on organization_members (last_name);
create index organization_members_phone on organization_members (phone);
create index organization_members_email on organization_members (email);
create index organization_members_availability on organization_members (availability);
create index organization_members_title on organization_members (title);
create index organization_members_role on organization_members (role);
