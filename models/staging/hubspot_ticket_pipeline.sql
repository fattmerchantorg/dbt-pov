{{ config(materialized="table") }}

select
*
from hubspot_deals.ticket_pipeline

