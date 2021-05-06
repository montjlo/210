view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    #required_access_grants: [drill_test]
    type: number
    sql: ${TABLE}.id ;;
  }

  #### string measure subtotal test ####
  dimension: id_string {
    type: string
    sql: ${TABLE}.id ;;
  }

  measure: id_measure {
    type: string
    sql: ${id_string} ;;
  }


  dimension: test_dev {
    type: string
    sql: "test" ;;
  }

  #test for git actions


  dimension: age{
    type: number
    sql: ${TABLE}.age ;;
  }

      # sql: CASE WHEN {% parameter suggest_param %} = 1 THEN ${state}
    # WHEN {% parameter suggest_param %} = 2 THEN ${country}
    # ELSE NULL END;;

  measure: param_age {
    type: sum
    sql: CASE
    WHEN {% parameter suggest_param %} = "one" THEN ${age}
    WHEN {% parameter suggest_param %} = "two" THEN NULL
    ELSE 1 END;;
  }

  measure: param_age_two {
    type: number
    sql: CASE
          WHEN {% parameter suggest_param %} = "one" THEN ${age_sum}
          WHEN {% parameter suggest_param %} = "two" THEN NULL
          ELSE ${count} END;;
  }

  measure: param_age_liquid {
    type: number
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${age_sum}
    {% elsif suggest_param._parameter_value == 'two' %}
      NULL
    {% else %}
      ${count}
    {% endif %}
    ;;
  }

  measure: param_age_liquid_two {
    type: number
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${age_sum}
    {% elsif suggest_param._parameter_value == 'two' %}
      NULL
    {% else %}
      ${count}
    {% endif %}
    ;;
  }

################ START field definitions for dynamic filter suggestions bug #####################

  parameter: suggest_param {
    type: string
    allowed_value: {value: "one"}
    allowed_value: {value: "two"}
  }

  dimension: filter_parameter_suggest_else {
    suggest_persist_for: "2 seconds"
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${state}
    {% elsif suggest_param._parameter_value == 'two' %}
      ${country}
    {% else %}
      ${last_name}
    {% endif %}
    ;;
  }

  dimension: filter_parameter_suggest_end {
    suggest_persist_for: "2 seconds"
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${state}
    {% elsif suggest_param._parameter_value == 'two' %}
      ${country}
    {% endif %}
    ;;
  }

  dimension: filter_parameter_suggest_null {
    suggest_persist_for: "2 seconds"
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${state}
    {% elsif suggest_param._parameter_value == 'two' %}
      ${country}
    {% elsif suggest_param._parameter_value == null %}
      ${email}
    {% endif %}
    ;;
  }

  dimension: filter_parameter_suggest_null_notnull {
    suggest_persist_for: "2 seconds"
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${state}
    {% elsif suggest_param._parameter_value == 'two' %}
      ${country}
    {% elsif suggest_param._parameter_value == null %}
      ${email}
    {% elsif suggest_param._parameter_value != null %}
      ${gender}
    {% endif %}
    ;;
  }

  dimension: filter_parameter_suggest_null_notnull_else {
    suggest_persist_for: "2 seconds"
    sql:
    {% if suggest_param._parameter_value == 'one' %}
      ${state}
    {% elsif suggest_param._parameter_value == 'two' %}
      ${country}
    {% elsif suggest_param._parameter_value == null %}
      ${email}
    {% elsif suggest_param._parameter_value != null %}
      ${gender}
    {% else %}
      ${last_name}
    {% endif %}
    ;;
  }

  dimension: suggest_param_value {
    sql:
    "{{suggest_param._parameter_value}}"
    ;;
  }

  # dimension: name_filter_test_three {
  #   type: string
  #   sql: ${filter_parameter_suggest} ;;
  #   suggest_dimension: filter_parameter_suggest
  #   suggest_persist_for: "2 seconds"
  # }

  ################ END field definitions for dynamic filter suggestions bug #####################

  measure: age_sum {
    type: sum
    sql: ${age} ;;
  }
  measure: age_sum_2 {
    type: sum
    sql: ${TABLE}.age -- AND comment
    ;;
  }

  dimension: over_20 {
    type: yesno
    sql: ${age}>20 ;;
  }

  dimension: case_yesno_test {
    type: string
    sql: CASE WHEN ${over_20} = true THEN 'working'
    WHEN ${over_20} = no THEN 'weird' END;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    #group_label: "departure flight"
  }

  dimension_group: created {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: date_label_test {
    label: ""
    group_label: "departure flight"
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }



  dimension: min_date {
    type: yesno
    sql: ${created_week}=MIN(${created_week}) ;;
  }

  dimension_group: deleted {
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
    sql: DATE_ADD(${TABLE}.created_at, INTERVAL 4 MONTH) ;;
  }

  # measure: distinct_users {
  #   type: count_distinct
  #   sql: CASE WHEN ${deleted_raw}>${orders.created_raw} THEN ${id} ELSE NULL END ;;
  # }

  # measure: distinct_users_test {
  #   type: count_distinct
  #   sql: CASE WHEN ${deleted_raw}>${created_raw} THEN ${id} ELSE NULL END ;;
  # }

  dimension: today {
    type: date
    sql: CURDATE() ;;
  }

  dimension: valid_user{
    type: number
    sql:
    CASE WHEN ${deleted_date}>=CURDATE() THEN 1
    ELSE 0 END;;
  }

  measure: count_valid {
    type: sum
    sql: ${valid_user} ;;
  }

  measure: valid_user_m{
    type: sum
    sql:
    CASE WHEN ${deleted_date}>=CURDATE() THEN 1
    ELSE 0 END;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    #required_access_grants: [drill_test]
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
    #required_access_grants: [drill_test]
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

  dimension: over_30 {
    type: yesno
    sql: ${age}>30 ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_help {
    type: number
    sql: CASE WHEN ${count} IS NULL THEN 0
    ELSE ${count} END;;
  }

  measure: count_for_tooltip {
    type: count
    drill_fields: [detail*]
    html: {{ state._value }} {{ value }} ;;
  }

  measure: running_total_users {
    type: running_total
    sql: ${count} ;;
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

############## TESTING ################

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
  label: "{{users.state._value}}"
  allowed_value: {
    value: "label test dynamic value"
  }
  #suggest_dimension: first_name
}

dimension: label_dimension_test {
  label: "{% parameter label_test %}"
  sql: {% parameter label_test %} ;;
}

filter: created_test {
  type: date
  default_value: "after 2018/05/10 and before 2018/05/18"
}
filter: emmanuel_test{
  default_value: "0"
  type: number
}
dimension: multivalue_test {

  sql: {% parameter multivalue %} ;;
}

dimension: state_space {
  type: string
  sql: CONCAT(${state}," ") ;;
}

}
