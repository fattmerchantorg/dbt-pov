{{ config(materialized="table") }}

select
name, ticket_id, value, timestamp_instant, next_timestamp, most_recent,
datediff('hours', timestamp_instant::date, next_timestamp::date) as time_diff
from (
select 
* ,
lead(timestamp_instant, 1) over (partition by ticket_id order by timestamp_instant) as next_timestamp,
row_number() over (partition by ticket_id order by timestamp_instant) as most_recent -- partition by ticket_id, name [if you want by what is modified]
from hubspot_deals.ticket_property_history
where name in ('hs_pipeline_stage') --('hs_all_owner_ids', 'hs_lastactivitydate', 'closed_date', 'hs_pipeline_stage', 'hs_lastmodifieddate', 'hubspot_owner_id')
and value in ('360815', '360828', '439591', '439592', '360829', '360830', '6369753', '439590', '439589', '439585') -- part of risk/fbh pipeline
)
-- 360828 is waiting on merchant
-- 360829 is ZZZZReleased / Funded
-- 360815 is Analyst Working
order by ticket_id, most_recent desc