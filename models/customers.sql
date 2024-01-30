with customers as (

    select * from {{ ref('stg_customers')}}

),

orders as (

    select * from {{ ref('stg_orders')}}

),

order_metrics as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        order_metrics.first_order_date,
        order_metrics.most_recent_order_date,
        coalesce(order_metrics.number_of_orders, 0) as number_of_orders

    from customers

    left join order_metrics using (customer_id)

)

select * from final