{{ config(materialized="table", unique_key="deal_id", sort="created_at") }}

select
    d.deal_id,
    d.backend_processor,
    o.deal_owner,
    o.deal_owner_email,
    d.created_at,
    d.created_at_timestamp,
    d.closed_at,
    d.closed_at_timestamp,
    d.first_became_customer_applied_100,
    d.first_became_customer_applied_100_timestamp,
    -- s.deal_stage,
    -- s.closed_won,
    d.manual_forecast_category,
    dp.label as pipeline,
    d.deal_name,
    d.amount,
    d.approved_volume,
    d.stax_merchant_id,
    d.processor_merchant_id,
    d.hubspot_team_id,
    d.pended_at,
    d.pended_at_timestamp,
    d.first_became_pended,
    d.first_became_pended_timestamp,
    d.first_became_internal_pended,
    d.first_became_internal_pended_timestamp,
    d.rejected_at,
    d.reject_reason,
    d.attrition_category,
    d.attrition_subcategory,
    d.submitted_at,
    d.submitted_at_timestamp,
    d.is_repricing_eligible,
    d.company_name,
    d.deal_source,
    d.secondary_mid,
    d.attrition_date,
    d.billable_days_active,
    d.product_type,
    d.underwriting_exposure,
    d.risk_score,
    d.property_uw__delayed_delivery___cnp_ach__value,
    d.property_uw__delayed_delivery__value__double,
    d.credit_score,
    d.property_hubspot_owner_id__value,
    d.property_pipeline__value,
    d.property_dealstage__value
from {{ ref('deals') }} as d
left outer join
    {{ ref('deal_pipelines__stages') }} as s on d.property_dealstage__value = s.stageid
left outer join  {{ ref('owners') }} as o on d.property_hubspot_owner_id__value = o.ownerid
left outer join {{ ref('deal_pipelines') }} as dp on d.property_pipeline__value = dp.pipelineid