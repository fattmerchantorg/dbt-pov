{{ config(materialized="table", 
    unique_key="deal_id") }}

select * from crmsales.deals