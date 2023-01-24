{{ config(materialized="table", 
    unique_key="merchant_id") }}
    
select * from fatt.registrations