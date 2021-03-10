view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    hidden: yes
    required_access_grants: [test]
  }

  filter: city_test {
    type: string
  }

  dimension: test_many {
    type: string
    sql:CAST("{% condition city_test %}${city}{% endcondition%}" AS CHAR);;
  }

  parameter: multivalue {
    default_value: "{% condition city_test %}${city}{% endcondition%}"
  }

  parameter: list_values {
    type: string
  }

  dimension: list_values_di {
    type: string
    sql: {%parameter list_values%} ;;
  }

  parameter: label_test {
    allowed_value: {
      label: "{{multivalue._parameter_value}}"
      value: "1"
    }
  }

  filter: emmanuel_test{
    default_value: "0"
    type: number
  }
  dimension: multivalue_test {

    sql: {% parameter multivalue %} ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    link: {
      label: "{% if users.state._value == 'California' %} Link does not exist {% else %} Great Success {% endif %}"
      url: "{% if users.state._value == 'California' %} https://www.google.com {% else %} https://www.youtube.com/watch?v=feA64wXhbjo {% endif %}"
    }
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_sabre_test {
    value_format: "#######"
    type: string
    sql: max("-23--67") ;;
    html:
    <ul>
    <li><b>{{ value }}</b></li>
    <li>{{ rendered_value }}</li>
    </ul>;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      saralooker.count,
      user_data.count
    ]
  }
}
