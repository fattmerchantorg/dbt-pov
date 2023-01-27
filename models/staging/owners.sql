{{ config(materialized="table", 
    unique_key="ownerid") }}

select
    o.ownerid,
    o.firstname + ' ' + o.lastname as deal_owner,
    o.email as deal_owner_email
 from crmsales.owners as o