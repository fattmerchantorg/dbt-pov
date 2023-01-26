select merchant_id, sum(total) as amount_reversed
from
    (
        select *, json_extract_path_text(meta, 'externalType', true) as transaction_type
        from "redhouse"."dbt_mkondapi"."v2_transactions"
        where
            is_valid_json(meta)
            and method = 'bank'
            and created_at between '2022-01-01' and '2022-12-31'
    )
where transaction_type like 'REVERSAL'
group by merchant_id