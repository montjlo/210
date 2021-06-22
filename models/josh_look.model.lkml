connection: "the_look"

# include all the views
include: "/views/**/*.view"
# include: "/*.dashboard"
include: "/views/flights_explore_extend.explore.lkml"
include: "/users_extend.view.lkml"
#change from 21.0 for 21.4
#more changes tests

# datagroup: josh_look_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
## new commit test
##
# named_value_format: large_number_unit {
#   value_format:"[>=1000]\"\"0.00,\" GWh\";[<=-1000]\"\"-0.00,\" GWh\";\"\"0.00\" MWh\""
# }

#persist_with: josh_look_default_datagroup
# access_grant: drill_test {
#   allowed_values: ["drill"]
#   user_attribute: drill_test
# }

explore: connection_reg_r3 {}
#change 2
# access_grant: test {
#   allowed_values: ["tehe"]
#   user_attribute: locale
# }

explore: test {}

explore: events {
  hidden:  yes
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
#   sql_always_where:
#   {% if fct_opportunity.valid_start._is_filtered AND fct_opportunity.valid_end._is_filtered %}
#   ${subscription_start_date} >= {% parameter fct_opportunity.valid_start %}
# AND ${subscription_end_date}<={% parameter fct_opportunity.valid_end %}
# {% else %}
# 1=1
# {% endif %}
#   ;;

#   sql_always_where:
#   {% if fct_opportunity.valid_start._is_filtered AND fct_opportunity.valid_end._is_filtered %}
#   ${subscription_start_date} >= {% parameter fct_opportunity.valid_start %}
#   AND ${subscription_end_date}<={% parameter fct_opportunity.valid_end %}
#   {% elsif (fct_opportunity.valid_start._is_filtered AND fct_opportunity.valid_end._is_filtered==false) OR
#     (fct_opportunity.valid_start._is_filtered==false AND fct_opportunity.valid_end._is_filtered) %}
#   "You must include a filter value for both Valid Start and Valid End for the filter to work"
#   {% else %}
#   1=1
#   {% endif %}
#   ;;
}
explore: products {
  hidden: yes
}

explore: flights_two {
  extends: [flights]
}

explore: imgsrc1onerroralert2 {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  # aggregate_table: monthly_orders {
  #   materialization: {
  #     datagroup_trigger: orders_datagroup
  #   }
  #   query: {
  #     dimensions: [orders.created_month]
  #     measures: [users.detail_two*]
  #     filters: [orders.created_date: "1 year", orders.status: "fulfilled"]
  #   }
  # }
  # access_filter: {
  #   user_attribute: institution_id
  #   field: orders.user_id
  # }
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  always_filter: {
    filters: [orders.status: "cancelled"]
  }
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
    ###test for refine
  #   fields: [
  #     users.id,
  #     age,
  #     users.age_sum_test_refine,
  #     users.age_plus_10,
  #     users.age_plus_20]
   }
}

explore: orders_two {
  from: orders
  join: users {
    type: left_outer
    #sql_on: orders_two.user_id = users.id ;;
    sql_on: ${orders_two.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: saralooker {
  join: users {
    type: left_outer
    sql_on: ${saralooker.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
#changes 3
 explore: users {
  # conditionally_filter: {
  #   filters: [users.created_date: "yesterday to today"]
  # }
 }
explore: users_from_sql_runner {}

# explore: event {

# }
