{{ config(materialized="table", unique_key="id") }}

select
    id,
    auth_id,
    avs_response,
    batch_id,
    batched_at,
    created_at,
    customer_id,
    interchange_code,
    invoice_id,
    is_captured,
    is_manual,
    is_merchant_present,
    is_reconciled,
    last_four,
    merchant_id,
    method,
    payment_method_id,
    pos_entry,
    pos_salesperson,
    pre_auth,
    recurring_transaction_id,
    reference_id,
    -- ,deal_source
    settled_at,
    success,
    type,
    updated_at,
    user_id,
    json_extract_path_text(meta, 'externalType', true) as reversal_status

from processor_v2.transactions -- {{ ref("v2_transactions") }}