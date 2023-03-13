with deal_dates as (
    select deal_id, deal_stage, closed_at_timestamp, attrition_date from public.dim_deals
),
tickets as (
select ticket_id, merchant_id,
	case when (current_date - ticket_closed_date::date) <= 180 then 'Yes' else 'No' end as reviewed_180_days
	from (
	select ticket_id, merchant_id, ticket_closed_date, created_date,
	row_number() over (partition by ticket_id order by ticket_closed_date desc) as most_recent
	from dbt_mkondapi.tickets t
	where 
		risk_subcategory ilike '%Excessive Declines%' 
		or risk_subcategory ilike '%Fraud%'
	    or risk_subcategory ilike '%Annual/Monthly Volume%'
	    or risk_subcategory ilike '%Chargebacks%'
	    or risk_subcategory ilike '%ACH Rejects%'
	    or risk_subcategory ilike '%Failed Payments%'
	    or risk_subcategory ilike '%FBH%'
	    --or risk_subcategory ilike '%FBH (Stax Connect)%'
		or risk_subcategory ilike '%Forced Transaction%'
	    --or risk_subcategory ilike '%Fraud Refunds%'
	    or risk_subcategory ilike '%High/Average Ticket%'
	    or risk_subcategory ilike '%International Cards%'
	    or risk_subcategory ilike '%Laundering%'
	    or risk_subcategory ilike '%MATCH Report%' 
	    or risk_subcategory ilike '%New Account Review%'
	    or risk_subcategory ilike '%Other%'
	    or risk_subcategory ilike '%Refunds%'
	    or risk_subcategory ilike '%Regulatory Compliance%'
	    or risk_subcategory ilike '%Sanctions%'   
	    or risk_subcategory ilike '%Split Payments%'
	    or risk_subcategory ilike '%Sponsor Bank%'
	    or risk_subcategory ilike '%Watch List%'   
	    )
--where most_recent = 1
),
active_deals as (
select 
distinct deal_id, processor_merchant_id, closed_at
from public.dim_deals
where deal_stage in ('Closed Won'
,'Closed won'
,'Closed/Won'
,'Active'
,'Customer Active'
,'Customer Active - Green'
,'Customer Active - Yellow'
,'Active (Post 90 Days)'
,'Active (First 90 Days)'
,'Activation in Progress'
,'Activation In Progress'
, 'Ready Not Processing'
,'Up-sells - Closed'
, 'PC Handoff Complete')
and closed_at >= '2022-10-01' 
)
select 
date_trunc('week', ad.closed_at) as weekly, 
count(ad.processor_merchant_id) as num_active_deals,
sum(case when reviewed_180_days = 'Yes' then 1 else 0 end) as num_reviewed_tickets,
cast((num_active_deals - num_reviewed_tickets) as numeric(10,4))/num_active_deals * 100 as stale_portfolio_rate
from active_deals ad 
left join tickets t on ad.processor_merchant_id = t.merchant_id