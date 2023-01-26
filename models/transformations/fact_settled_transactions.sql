{{ config(materialized="table", unique_key="processor_mid") }}

select
    created_at as transacted_at,
    date_trunc('month', created_at) as month,
    mid as processor_mid,
    case
        when (pos_entry = 'Manual/ Key Entry')
        then 'CNP'
        when (pos_entry = 'Chip Card Read Eligible Terminal')
        then 'CP'
        when (pos_entry = 'Entry Mode Not Known')
        then 'CNP'
        when (pos_entry = 'Contactless Magnetic Stripe Read')
        then 'CP'
        when (pos_entry = 'E-Commerce Transaction')
        then 'CNP'
        when (pos_entry = 'Terminal Not Used/Other/Inactivity Fee Transaction')
        then 'CNP'
        when (pos_entry = 'Contactless Magnetic Chip (MICR Reader for POS Check)')
        then 'CP'
        when
            (
                pos_entry
                =
                'Complete Magnetic Stripe Read and Transmitted–PS2000 Code Full Magnetic Stripe Data Provided'
            )
        then 'CP'
        else 'CNP'
    end as presentment_type,
    staging.auth_amount * .01 as amount
from engine_emaf.staging
where header_type >= 300

-- *******
union all
-- *******
select
    cast("activity date" as date) as transacted_at,
    date_trunc('month', cast("activity date" as date)) as month,
    "merchant id" as processor_mid,
    case
        when "payment type" = 'Electronic Check' then 'ACH' else 'CNP'
    end as presentment_type,
    (cast("settlement amt" as decimal(10, 2))) as settled_amount
from public.litle_fees_netsettledsales
where
    "account suffix" != 'Account Suffix'
    and "merchant id" is not null
    and "settlement amt" > 0
