{{ config(materialized="table", unique_key="ticket_id", sort="created_at") }}

select 
t.ticket_id,
t.merchant_id,
t.account_id,
t.subject,
t.created_date,
t.ticket_closed_date,
t.deal_closed_date,
t.pipeline, 
t.ticket_category,
t.ticket_owner_id,
t.ticket_owner,
t.ticket_status,
t.source,
t.risk_subcategory,
t.last_customer_reply_date,
t.last_contacted,
t.backend_processor,
t.uw_ticket_category,
t.uw_high_ticket
from {{ ref('hubspot_tickets') }} as t
left join {{ ref('hubspot_ticket_property_history')}} tph on t.ticket_id = tph.ticket_id and t.ticket_owner_id = tph.value