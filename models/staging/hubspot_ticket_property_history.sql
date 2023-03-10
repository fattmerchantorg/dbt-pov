{{ config(materialized="table") }}


select 
* ,
case when value = '360828' then timestamp_instant end as waiting_on_merchant_timestamp,
row_number() over (partition by ticket_id, name order by timestamp_instant desc) as most_recent
from hubspot_deals.ticket_property_history