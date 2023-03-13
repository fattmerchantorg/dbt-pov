{{ config(materialized="table", 
    unique_key="id") }}

select
id as ticket_id,
property_midticket as merchant_id,
property_omid as account_id,
property_subject as subject,
property_createdate as created_date,
property_closed_date as ticket_closed_date,
timestamp 'epoch' + cast(property_deal_close_date AS bigint)/1000 * interval '1 second' as deal_closedwon_date,
case when property_hs_pipeline = '360813' then 'Risk / FBH' end as pipeline,
property_hs_ticket_category as ticket_category,
property_hubspot_owner_id as ticket_owner_id,
case 
    when property_hubspot_owner_id = '52205921' then 'Fattmerchant Risk Team'
    when property_hubspot_owner_id = '82452135' then 'Hecser Barros'
    when property_hubspot_owner_id = '43100123' then 'Matt Sochar'
    when property_hubspot_owner_id = '124910871' then 'Kimberley Leech'
    when property_hubspot_owner_id = '203619457' then 'Justin Smith'
    when property_hubspot_owner_id = '25858697' then 'Carlos Sanchez'
    else 'Other Analyst'
    end
    as ticket_owner,
case 
     when property_hs_pipeline_stage = '360815' then 'Analyst Working'   
     when property_hs_pipeline_stage = '360828' then 'Waiting on Merchant'   
     when property_hs_pipeline_stage = '439585' then 'Manager Escalation'   
     when property_hs_pipeline_stage = '439588' then 'Open Account Changes'   
     when property_hs_pipeline_stage = '439589' then 'Submitted to Processor'   
     when property_hs_pipeline_stage = '439590' then 'Pending Closure'   
     when property_hs_pipeline_stage = '594705' then 'Complete ACH'   
     when property_hs_pipeline_stage = '439591' then 'Request/Case Resolved (Funds Released)'   
     when property_hs_pipeline_stage = '439592' then 'Request/Case Resolved (No Funds Held)'
     when property_hs_pipeline_stage = '360830' then 'Closed/Shutdown'   
     when property_hs_pipeline_stage = '6369753' then 'Closed from Prior Conversion'   
     when property_hs_pipeline_stage = '360829' then 'ZZZZZReleased / Funded'
     when property_hs_pipeline_stage = '360814' then 'Unassigned'
     else ''
     end
     as ticket_status,
property_source_type as source,
property_subcategory_risk_ as risk_subcategory,
property_hs_lastmodifieddate as last_modified_date,
property_hs_updated_by_user_id as updated_by_userid,
property_last_reply_date as last_customer_reply_date,
property_hs_lastcontacted as last_contacted,
property_backend_processor as backend_processor,
property_uw_ticket_category as uw_ticket_category,
property_uw_high_ticket as uw_high_ticket,
datediff('hours', '1970/01/01', timestamp 'epoch' + cast(property_time_to_close AS bigint)/1000 * interval '1 second') as time_to_close
from hubspot_deals.ticket
where property_hs_pipeline  = '360813' -- Risk/FBH Pipeline
