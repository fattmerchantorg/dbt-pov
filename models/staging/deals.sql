-- Manu rocks!

{{ config(materialized="table", unique_key="deal_id") }}

select
    d.dealid as deal_id,
    d.property_backend_processor__value as backend_processor,
    d.property_createdate__value as created_at,
    d.property_createdate__timestamp as created_at_timestamp,
    d.property_closedate__value as closed_at,
    d.property_closedate__timestamp as closed_at_timestamp,
    case
        when d.property_first_became_customer_applied_100___value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_first_became_customer_applied_100___value as float)
            / 1000
            * interval '1 second'
    end as first_became_customer_applied_100,
    d.property_first_became_customer_applied_100___timestamp
    as first_became_customer_applied_100_timestamp,
    d.property_hs_manual_forecast_category__value as manual_forecast_category,
    left(d.property_dealname__value, 200) as deal_name,
    d.property_amount__value__double as amount,
    d.property_annual_volume__value__double as approved_volume,
    d.property_omid__value as stax_merchant_id,
    d.property_mid__value as processor_merchant_id,
    d.property_hubspot_team_id__value as hubspot_team_id,
    case
        when d.property_pended_date__value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_pended_date__value as float) / 1000 * interval '1 second'
    end as pended_at,
    d.property_pended_date__timestamp as pended_at_timestamp,
    case
        when d.property_first_became_pended__value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_first_became_pended__value as float)
            / 1000
            * interval '1 second'
    end as first_became_pended,
    d.property_first_became_pended__timestamp as first_became_pended_timestamp,
    case
        when d.property_first_became_internal_pend__value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_first_became_internal_pend__value as float)
            / 1000
            * interval '1 second'
    end as first_became_internal_pended,
    d.property_first_became_internal_pend__timestamp
    as first_became_internal_pended_timestamp,
    d.property_underwriting_dropped_rejected_lost_reason__timestamp as rejected_at,
    d.property_underwriting_dropped_rejected_lost_reason__value as reject_reason,
    d.property_attrition_category__value as attrition_category,
    d.property_attrition_core__value as attrition_subcategory,
    case
        when d.property_first_became_submitted__value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_first_became_submitted__value as float)
            / 1000
            * interval '1 second'
    end as submitted_at,
    d.property_first_became_submitted__timestamp as submitted_at_timestamp,
    case
        when d.property_eligible_for_subscription_repricing__value = 'true'
        then true
        else false
    end as "is_repricing_eligible",
    left(d.property_company_name__value, 100) as company_name,
    d.property_source__value as deal_source,
    d.property_secondary_mid__value as secondary_mid,
    case
        when d.property_customer_attrition_date__value = ''
        then timestamp 'epoch' + cast(0 as float) / 1000 * interval '1 second'
        else
            timestamp 'epoch'
            + cast(d.property_customer_attrition_date__value as float)
            / 1000
            * interval '1 second'
    end as attrition_date,
    d.property_billable_days_active__value as billable_days_active,
    d.property_product_type__value as product_type,
    d.property_annual_exposure__value__double as underwriting_exposure,
    coalesce(cast(d.property_pf_risk_score__value__double as varchar), d.property_pf_risk_score__value__string) as risk_score,
    d.property_uw__delayed_delivery___cnp_ach__value,
    d.property_uw__delayed_delivery__value__double,
    d.property_credit_score__value as credit_score,
    d.property_dealstage__value,
    d.property_hubspot_owner_id__value,
    d.property_pipeline__value
from crmsales.deals as d


