{{ config(materialized="table", 
    unique_key="id") }}

select
id,
portal_id,
object_type,
property_account_manager,
property_hs_ticket_priority,
property_createdate,
property_closed_date,
property_deal_source,
property_hs_ticket_category,
property_midticket,
property_original_subscription_amount,
property_annual_contract_term_length_in_months,
property_discounted_subscrption_amount,
property_omid,
property_subject,
property_sub_category_internal,
property_subcategory_risk_,
property_underwriter,
property_uw_ticket_category,
property_uw_credit_risk_analyst,
property_uw_high_ticket,
property_uw_delayed_funding,
property_support_subcategories
from hubspot_deals.ticket

