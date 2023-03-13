--  Remove time in Increase Requests and Account Update numbers to get a true "investigation time"

select week, 
       --sum(case when ticket_closed_date is not null then 1 else 0 end) as num_closed_tickets,
       --sum(ticket_timetoclose) as timetoclose,
       round(cast(sum(ticket_timetoclose) as numeric(10,2))/sum(case when ticket_closed_date is not null then 1 else 0 end), 2) as avg_time_taken
from (
select 
date_trunc('week', created_date) as week,
case when waiting_on_merchant_time is not null then time_to_close - waiting_on_merchant_time
    else time_to_close end as ticket_timetoclose, *
from {{ ref('tickets') }} as t
where created_date >= '2022-10-01'
)
group by week
order by week desc
