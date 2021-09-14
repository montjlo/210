connection: "the_look"

# include all the views
include: "/views/**/*.view"
# include: "/*.dashboard"
include: "/views/flights_explore_extend.explore.lkml"
include: "/users_extend.view.lkml"
include: "/move_lookml_dash.dashboard"

# datagroup: josh_look_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }


#persist_with: josh_look_default_datagroup

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
  sql_always_where:
  {% if users.name != null %}
2=2
{% else %}
1=1
{% endif %}
  ;;

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
  query: query_1 {
    dimensions: [orders.status]
  }
  query: query_2 {
    dimensions: [orders.status]
  }
  query: query_3 {
    dimensions: [orders.status]
  }
  query: query_4 {
    dimensions: [orders.status]
  }
  query: query_5 {
    dimensions: [orders.status]
  }
  query: query_6 {
    dimensions: [orders.status]
  }
  query: query_7 {
    dimensions: [orders.status]
  }
  query: query_8 {
    dimensions: [orders.status]
  }
  query: query_9 {
    dimensions: [orders.status]
  }
  query: query_10 {
    dimensions: [orders.status]
  }
  query: query_11 {
    dimensions: [orders.status]
  }
  query: query_12 {
    dimensions: [orders.status]
  }





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
  sql_always_where:
  {% if orders_two.liquid_test._parameter_value == 'one' %}
  1=1
  {% else %}
  ${users.age}>20
  {% endif %};;
  join: users {
    type: left_outer
    #sql_on: orders_two.user_id = users.id ;;
    sql:

  {% if orders_two.liquid_test._parameter_value == 'one' %}
   -- lol
  {% else %}
  ${orders_two.user_id} = ${users.id}
  {% endif %}
  ;;
    relationship: many_to_one
  }
}

explore: orders_three {
  from: orders
  sql_always_where:
  {% if orders_three.liquid_test._parameter_value == 'one' %}
  1=1
  {% else %}
  2=2
  {% endif %};;
  join: users {
    type: left_outer
    #sql_on: orders_two.user_id = users.id ;;
    sql_on: ${orders_three.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_four {
  from: orders
  sql_always_where:
 {% condition orders_four.status %} ${status} {% endcondition %}
AND {% condition orders_four.status %} ${status_image} {% endcondition %};;
}

#{% condition orders_four.one_one %} ${orders_four.liquid_test} {% endcondition %}
#{% parameter orders_four.liquid_test %} = {% condition orders_four.one_one %} one_one {% endcondition %}

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

explore: users {}


explore: users_from_sql_runner {}
