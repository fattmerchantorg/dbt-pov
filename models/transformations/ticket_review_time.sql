--  Remove time in Increase Requests and Account Update numbers to get a true "investigation time"
-- of the tickets closed this month: how long did it take to resolve?

select timeline, 
      avg(cast(ticket_timetoclose as numeric(10,2))),
      count(*)
    from (
select 
date_trunc('week', ticket_closed_date) as timeline,
case when waiting_on_merchant_time is not null then time_to_close - waiting_on_merchant_time
    else time_to_close end as ticket_timetoclose, *
from {{ ref('tickets') }} as t
where ticket_closed_date >= '2022-10-01'
and ticket_owner not like 'Other Analyst'
)
group by timeline
order by timeline desc
