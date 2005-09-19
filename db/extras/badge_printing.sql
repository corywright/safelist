begin;
--create user exporter with password 'safelist';
create or replace function concat_family_members (integer) returns text as '
declare
  my_id alias for $1;
  family_members text := '''';
  member record;
begin
  for member in select p.first_name || '' '' || p.last_name as full_name, case when p.tag_id = '''' then s.tag_id_prefix || p.id else p.tag_id end as id_number from people p join shelters s on (p.shelter_id = s.id) where p.family_id = my_id loop
    family_members := family_members || ''\n'' || member.full_name || '' / '' || member.id_number;
  end loop;
  return trim(both ''\n'' from family_members);
end;
' language plpgsql;

--drop view exporter_badge_info;
create view exporter_badge_info as select first_name || ' ' || last_name as full_name, p.id, case when p.tag_id ='' then s.tag_id_prefix || p.id else p.tag_id end, s.name as shelter, decode(pic.image,'base64') as image, concat_family_members(p.family_id) as family_members from people p join shelters s on (p.shelter_id = s.id) join pictures pic on (pic.person_id = p.id) where p.badge_status_id = '1' order by pic.id limit 20;
grant select on exporter_badge_info to exporter;
grant select on people to exporter;
grant select on pictures to exporter;
grant select on shelters to exporter;
commit;
