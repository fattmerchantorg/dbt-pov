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
tph.timestamp_instant as last_touched_by
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
where tph.most_recent = 1
-- left outer join
--     {{ ref('deal_pipelines__stages') }} as s on d.property_dealstage__value = s.stageid
-- left outer join  {{ ref('owners') }} as o on d.property_hubspot_owner_id__value = o.ownerid
-- left outer join {{ ref('deal_pipelines') }} as dp on d.property_pipeline__value = dp.pipelineid