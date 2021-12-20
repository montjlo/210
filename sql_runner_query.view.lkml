view: sql_runner_query {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'order_items.returned_date'


      SELECT
          (DATE(CONVERT_TZ(`returned_at`,'US/Michigan','Asia/Calcutta'))) AS `order_items.returned_date`
      FROM
          `demo_db`.`order_items` AS `order_items`
      GROUP BY
          1
      ORDER BY
          (DATE(CONVERT_TZ(`returned_at`,'US/Michigan','Asia/Calcutta'))) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_returned_date {
    type: string
    sql: CAST(${TABLE}.`order_items.returned_date` AS CHAR ) ;;
  }
  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
  }

  dimension: date1 {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      DATE_SUB(${order_items_returned_date},INTERVAL 1 DAY)
     {% elsif date_granularity._parameter_value == 'day' %}
      DATE_SUB(${order_items_returned_date},INTERVAL 7 DAY)
    {% endif %};;
  }
  # dimension: date7 {
  #   sql:
  #   {% if date_granularity._parameter_value == 'day' %}
  #     DATE_SUB(${order_items_returned_date},INTERVAL 7 DAY)
  #   {% endif %};;
  #   }
  set: detail {
    fields: [order_items_returned_date]
  }
}
