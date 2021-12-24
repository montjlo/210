view: events {
  sql_table_name: demo_db.events ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html:  <p style= font-size: 50%>{{ rendered_value | date: "%b %Y" }}</p> ;;
  }

  parameter: string_test {
    type: string
    suggest_dimension: value
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
    drill_fields: [users.last_name, users.first_name]
  }

  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    html:{{ rendered_value }};;
    value_format_name: decimal_1
    drill_fields: [users.last_name, users.first_name]
  }
}
