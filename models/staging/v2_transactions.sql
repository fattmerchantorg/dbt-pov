{{ config(materialized="table", 
    unique_key="merchant_id") }}

    
select * from processor_v2.transactions