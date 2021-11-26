view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: my_pam {
    type: unquoted
    allowed_value: {
      value: "lower"
    }
    allowed_value: {
      value: "other"
    }
  }

  dimension: my_pam_test {
    type: number
    sql:
    {% if my_pam._parameter_value == 'lower' %}
    1
    {% elsif my_pam._parameter_value == 'other' %}
    2
    {% else %}
    NULL
    {% endif %};;
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
    link: {
      label: "Drill Dashboard"
      url: "/dashboards/130?&OrderID={{ _filters['orders.id'] | url_encode }}"
    }
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
      hour_of_day,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }
  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by hour"
      value: "hour"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'hour' %}
      ${returned_hour_of_day}
    {% else %}
      ${returned_month}
    {% endif %};;
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
