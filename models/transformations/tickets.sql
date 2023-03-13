{{ config(materialized="table", unique_key="ticket_id", sort="created_date") }}

select 
distinct t.ticket_id,
t.merchant_id,
t.account_id,
t.subject,
t.created_date,
t.ticket_closed_date,
t.deal_closedwon_date,
t.pipeline, 
t.ticket_category,
t.ticket_owner_id,
t.ticket_owner,
t.ticket_status,
t.source,
t.risk_subcategory,
t.last_modified_date,
t.updated_by_userid,
t.last_customer_reply_date,
t.last_contacted,
t.backend_processor,
t.uw_ticket_category,
t.uw_high_ticket,
t.time_to_close,
tph.time_diff as waiting_on_merchant_time
from {{ ref('hubspot_tickets') }} as t
left join (select distinct ticket_id, value, sum(time_diff) as time_diff  from {{ ref('hubspot_ticket_property_history')}} where value = '360828' group by ticket_id, value) as tph on t.ticket_id = tph.ticket_id