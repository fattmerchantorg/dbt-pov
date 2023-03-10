{{ config(materialized="table", 
    unique_key="ticket_id") }}

select
*
from hubspot_deals.ticket_engagement

