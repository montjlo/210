# view: payments_rds {
#   derived_table: {
#     sql:
#     select
#       customer_payment_id
#       , created_at
#       , "id"
#       , payment_method
#       , payment_provider
#       , txn_status
#       , txn_sub_status
#       , txn_type
#       , service_type
#       , payments.service_reference_id
#       , version
#       , case when date(created_at) = current_date then 'today'
#           when date(created_at) = date_sub(current_date, interval 7 day) then 'last week'
#           else 'other'
#           end as time_label
#       , case
#           when total_refund > 0 then 'refund'
#           when total_failed > 0 then 'failed'
#           when total_success > 0 then 'success'
#           else 'huh'
#           end as payment_status
#     from scrooge_payment.payments
#     left join
#       (select
#         service_reference_id
#         , count(case when txn_status not in ('settled', 'approved', 'processing', 'refund')
#             then service_reference_id
#             else null end) as total_failed
#         , count(case when txn_status = 'refund'
#             then service_reference_id
#             else null end) as total_refund
#         , count(case when txn_status in ('settled','approved','processing')
#             then service_reference_id
#             else null end) as total_success
#         from scrooge_payment.payments
#         where created_at BETWEEN date_sub(current_date, interval 8 day) AND date_add(current_date, interval 1 day)
#         group by 1
#       ) status_count on status_count.service_reference_id = payments.service_reference_id
#     where created_at BETWEEN date_sub(current_date, interval 8 day) AND date_add(current_date, interval 1 day)
#     ;;
#   }

# view: pd_funnel_drop_alert {
#   derived_table: {
#     sql: select *
#       from
#       (select 'cart to payment' as funnel , ((today_payment_initiated/today_cart_created) - (payment_initiated/cart_created)) * 100 as funnel_change
#       from
#       (
#       select last_week.hour
#             , last_week.cart_created
#             , last_week.payment_initiated
#             , last_week.payment_successful
#             , last_week.delivered
#             , last_week.users
#             , today.cart_created today_cart_created
#             , today.payment_initiated today_payment_initiated
#             , today.payment_successful today_payment_successful
#             , today.delivered today_delivered
#             , today.users today_users
#             from
#             (
#                   select hour, sum(id) cart_created,sum(payment_initiated) payment_initiated, sum(payment_successful) payment_successful, sum(delivered) delivered, sum(entity_id) users
#                 from
#                 (
#                   select date(created_at) dt, extract(hour from created_at) hour, count(distinct(a.id)) id, count(distinct(entity_id)) entity_id
#                   , count(case when total = 0 and status in ('shipped','delivered') then a.id else b.order_id end) payment_initiated
#                   , count(case when total = 0 and status in ('shipped','delivered') then a.id else c.order_id end) payment_successful
#                   , count(d.id) delivered
#                   from
#                   (
#                     select a.created_at, id, total, entity_id
#                     from orders a
#                     where created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1,2
#                   ) a
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) b
#                   on a.id=b.order_id
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and status='successful' and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) c
#                   on a.id=c.order_id
#                   left join
#                   (
#                     select id, status
#                     from orders a
#                     where status in ('shipped','delivered') and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) d
#                   on a.id=d.id
#                   group by 1,2
#                 ) a
#                 group by 1
#             ) last_week
#             join
#             (
#                 select hour, count(id) cart_created,count(payment_initiated) payment_initiated, count(payment_successful) payment_successful, count(delivered) delivered, count(distinct(entity_id)) users
#                 from
#                 (
#                   select date(created_at) dt, extract(hour from created_at) hour, a.id, entity_id
#                   , case when total = 0 and status in ('shipped','delivered') then a.id else b.order_id end as payment_initiated
#                   , case when total = 0 and status in ('shipped','delivered') then a.id else c.order_id end as payment_successful
#                   , d.id delivered
#                   from
#                   (
#                     select a.created_at, id, total, entity_id
#                     from orders a
#                     where created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1,2
#                   ) a
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and created_at > current_date and extract(hour from created_at) = extract(hour from now()) -1
#                     group by 1
#                   ) b
#                   on a.id=b.order_id
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and status='successful' and created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1
#                   ) c
#                   on a.id=c.order_id
#                   left join
#                   (
#                     select id, status
#                     from orders a
#                     where status in ('shipped','delivered') and created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1
#                   ) d
#                   on a.id=d.id
#                 ) a
#                 group by 1
#             ) today
#             ON last_week.hour = today.hour
#       ) a

#       UNION
#       select 'payment to delivered' as funnel , ((today_delivered/today_payment_successful) - (delivered/payment_successful)) * 100 as funnel_change
#       from
#       (
#       select last_week.hour
#             , last_week.cart_created
#             , last_week.payment_initiated
#             , last_week.payment_successful
#             , last_week.delivered
#             , last_week.users
#             , today.cart_created today_cart_created
#             , today.payment_initiated today_payment_initiated
#             , today.payment_successful today_payment_successful
#             , today.delivered today_delivered
#             , today.users today_users
#             from
#             (
#                   select hour, sum(id) cart_created,sum(payment_initiated) payment_initiated, sum(payment_successful) payment_successful, sum(delivered) delivered, sum(entity_id) users
#                 from
#                 (
#                   select date(created_at) dt, extract(hour from created_at) hour, count(distinct(a.id)) id, count(distinct(entity_id)) entity_id
#                   , count(case when total = 0 and status in ('shipped','delivered') then a.id else b.order_id end) payment_initiated
#                   , count(case when total = 0 and status in ('shipped','delivered') then a.id else c.order_id end) payment_successful
#                   , count(d.id) delivered
#                   from
#                   (
#                     select a.created_at, id, total, entity_id
#                     from orders a
#                     where created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1,2
#                   ) a
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) b
#                   on a.id=b.order_id
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and status='successful' and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) c
#                   on a.id=c.order_id
#                   left join
#                   (
#                     select id, status
#                     from orders a
#                     where status in ('shipped','delivered') and created_at BETWEEN date_sub(current_date, interval 7 day) AND current_date
#                     group by 1
#                   ) d
#                   on a.id=d.id
#                   group by 1,2
#                 ) a
#                 group by 1
#             ) last_week
#             join
#             (
#                 select hour, count(id) cart_created,count(payment_initiated) payment_initiated, count(payment_successful) payment_successful, count(delivered) delivered, count(distinct(entity_id)) users
#                 from
#                 (
#                   select date(created_at) dt, extract(hour from created_at) hour, a.id, entity_id
#                   , case when total = 0 and status in ('shipped','delivered') then a.id else b.order_id end as payment_initiated
#                   , case when total = 0 and status in ('shipped','delivered') then a.id else c.order_id end as payment_successful
#                   , d.id delivered
#                   from
#                   (
#                     select a.created_at, id, total, entity_id
#                     from orders a
#                     where created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1,2
#                   ) a
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and created_at > current_date and extract(hour from created_at) = extract(hour from now()) -1
#                     group by 1
#                   ) b
#                   on a.id=b.order_id
#                   left join
#                   (
#                     select order_id
#                     from order_payments a
#                     where type='payment' and status='successful' and created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1
#                   ) c
#                   on a.id=c.order_id
#                   left join
#                   (
#                     select id, status
#                     from orders a
#                     where status in ('shipped','delivered') and created_at  > current_date and extract(hour from created_at) = extract(hour from now())-1
#                     group by 1
#                   ) d
#                   on a.id=d.id
#                 ) a
#                 group by 1
#             ) today
#             ON last_week.hour = today.hour
#       ) c
#       ) d
#       where funnel_change <= -5
# ;;
#   }
