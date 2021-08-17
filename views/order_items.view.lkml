view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format: "$#.00;($#.00)"
  }

  measure: sale_price_ua_test {
    type: sum
    sql: ${sale_price} ;;
    value_format: "$#.00;($#.00)"
    #value_format: "{{_user_attributes['currency_value_format']}}#.00;($#.00)"
  }

  measure: total_sale_price_format_test {
    type: sum
    sql: ${sale_price} ;;
    value_format: "[>=1000000000]\"R$\"0.00,,,\"B\";[>=1000000]\"R$\"0.00,,\"MM\";[>=1000]\"R$\"0.00,\"Mil\";\"R$\"0.00"
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
