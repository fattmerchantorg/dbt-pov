{{ config(materialized="table", 
    unique_key="ownerid") }}

select * from crmsales.owners