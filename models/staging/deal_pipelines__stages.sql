{{ config(materialized="table", 
    unique_key="stage_id") }}

select * from crmsales.deal_pipelines__stages