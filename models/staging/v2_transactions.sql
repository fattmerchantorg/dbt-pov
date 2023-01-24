{{ config(materialized="table", 
    unique_key="id") }}

    
select * from processor_v2.transactions