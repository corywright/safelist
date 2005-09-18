--select count(*) from (
--    select distinct on (v.id) v.id,e.event_time as "last_in"
--    from volunteers v left join events e on (e.volunteer_id = v.id)
--    where e.event_type_id = '3'
--    order by v.id, e.event_time desc
--) as "sub_in"
--left join (
--    select distinct on (v.id) v.id,e.event_time as "last_out"
--    from volunteers v left join events e on (e.volunteer_id = v.id)
--    where e.event_type_id = '4'
--    order by v.id, e.event_time desc
--) as "sub_out"
--using (id) where last_in > last_out or last_out is null
--;

select count(*) from (
    select distinct on (p.id) p.id,e.event_time as "last_in"
    from people p left join events e on (e.person_id = p.id)
    where e.event_type_id = '1' and p.shelter_id = '2' -- windsor
    order by p.id, e.event_time desc
) as "sub_in"
left join (
    select distinct on (p.id) p.id,e.event_time as "last_out"
    from people p left join events e on (e.person_id = p.id)
    where e.event_type_id = '2' and p.shelter_id = '2' -- windsor
    order by p.id, e.event_time desc
) as "sub_out"
using (id) where last_in > last_out or last_out is null
;
