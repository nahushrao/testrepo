    select
        id as payment_id,
        orderid,
        paymentmethod,
        status,
        amount

    from {{ source('stripe','payment') }}