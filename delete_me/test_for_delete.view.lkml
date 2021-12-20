view: test_for_delete {

  # https://commercedevncr.cloud.looker.com/looks/202?
  # f[fact_business_approver.BusinessDate]=30+days+ago+for+30+days%20%20%20%20%20%20&
  # f[dim_stores.store_name]=Megadeal%20%20%20%20%20%20&f[fact_business_approver.approvers]
  # =#%3CLooker::FieldDrop:0x788ff0c9%3E%20%20%20%20%20%20%20%20%20%20%20%20&
  # f[fact_business_approver.action_type]=ApprovalRequired&f[fact_business_approver.is_approved]=yes

  # https://commercedevncr.cloud.looker.com/looks/202?
  # f[fact_business_approver.BusinessDate]=30+days+ago+for+30+days%20%20%20%20%20%20&
  # f[dim_stores.store_name]=Megadeal%20%20%20%20%20%20&f[fact_business_approver.approvers]
  # =Lucia%20%20Es*****%20%20%20%20%20%20%20%20%20%20%20%20&
  # f[fact_business_approver.action_type]=ApprovalRequired&f[fact_business_approver.is_approved]=yes

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: test_for_delete {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
