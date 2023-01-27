{{ config(materialized="table", 
    unique_key="stage_id") }}

select
    s.stageid,
    s.label as deal_stage,
    s.closedwon as closed_won,
    s.active,
    s.label
from crmsales.deal_pipelines__stages as s