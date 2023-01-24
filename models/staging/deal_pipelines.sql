{{ config(materialized="table", 
    unique_key="pipelineid") }}


select * from crmsales.deal_pipelines