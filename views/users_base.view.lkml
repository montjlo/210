#include: "users_refine_*.view.lkml"

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

  dimension: pdt_def_test {
    type: string
    sql: "SELECT customer_id,MIN(DATE(time))"
    "AS first_order,SUM(amount) AS total_amount FROM orders GROUP BY customer_id" ;;
  }

  measure: id_measure {
    type: string
    sql: ANY_VALUE(${id_string}) ;;
  }

  dimension: label_me {
    type: string
    sql: "Hi" ;;
  }

  dimension: labled {
    label: "{{label_me._value}}"
    type: string
    sql: "Hello" ;;
  }


  dimension: suggest_dimension {
    type: string
    sql: "test" ;;
    suggest_dimension: first_name
    suggest_explore: users
  }

  #test for git actions


  dimension: age{
    type: number
    sql: ${TABLE}.age ;;
    drill_fields: [detail*]
  }

  dimension: price_rating_group {
    type: string
    case: {
      when: {
        label: "$"
        sql: ${age} < 20 ;;
      }
      when: {
        label: "$$"
        sql:  ${age} >= 20 AND ${age} <= 40 ;;
      }
      when: {
        label: "$$$"
        sql:${age} >= 41 AND ${age} <= 50 ;;
      }
      when: {
        label: "$$$$"
        sql:${age} >= 51 ;;
      }
    }

  }

  dimension: price_rating_group2 {
    type: string
    sql: CASE WHEN ${age} < 20 THEN "$"
    WHEN ${age} >= 20 AND ${age} <= 40 THEN "$$"
    WHEN ${age} >= 41 AND ${age} <= 50 THEN "$$$"
    ELSE "$$$$"
    END ;;

  }

  dimension: hiddenAge{
    hidden: yes
    type: number
    sql: ${TABLE}.age ;;
    drill_fields: [detail*]
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
    html: {{ rendered_value }} ;;

  }

  measure: user_cities {
    type: string
    sql: ${city} ;;
    order_by_field: count
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    #group_label: "departure flight"
  }

  dimension_group: created {
    type: time
    #group_label:  "True Label"
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    drill_fields: [detail*]
    order_by_field: city
  }

  dimension_group: html_table_pdf {
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
    html: {{ rendered_value | date: "%d-%b-%Y %H:%M" }} ;;
  }

  dimension_group: created_tz_converted {
    type: time
    timeframes: []
    sql: CONVERT_TZ(${TABLE}.created_at,'UTC','US/Pacific') ;;
    drill_fields: [detail_0*]
    convert_tz: no
  }

  # dimension: test_date_for_list {
  #   type: string
  #   sql: ${created_time} ;;
  #   order_by_field: created_year
  # }

  # measure: datelist {
  #   type: list
  #   sql: ${test_date_for_list} ;;
  # }

  dimension: date_diff {
    type:  number
    sql: DATEDIFF(${users.created_date},date("2021-02-15")) ;;
  }

  dimension: format_week {
    type: number
    sql: ${created_week_of_year} ;;
    html: Week {{ value }} ;;
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
    sql: DATE_ADD(${TABLE}.created_at, INTERVAL 3 YEAR) ;;
  }

  dimension_group: date_label_test {
    group_label: "{% if _model._name == 'josh_look' %}True Label{% else %}False Label{% endif %}"
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: min_date {
    type: yesno
    sql: ${created_week}=MIN(${created_week}) ;;
  }


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
    description: "idk"
  }

  dimension: state_drill {
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [city]
    link: {
      label: "drill test"
      url: "/explore/josh_look/users?fields=users.state,users.city&f[users.state]={{value}}"
    }
  }

  dimension: state_hidden {
    type: string
    hidden: yes
    sql: ${TABLE}.state ;;
  }

  parameter: map_layer {
    type: unquoted
    allowed_value: {
      label: "us zip"
      value: "zip"
    }
    allowed_value: {
      label: "countries"
      value: "countries"
    }
    allowed_value: {
      label: "states"
      value: "states"
    }
  }

  dimension: map_layer_selector {
    sql:
    {% if map_layer._parameter_value == 'zip' %}
    ${zip}
    {% elsif map_layer._parameter_value == 'states' %}
    ${state_map}
    {% else %}
    ${country_map}
    {% endif %}
    ;;
    map_layer_name: countries
    required_fields: [zip]
  }

  dimension: country_map {
    type: string
    sql: ${country} ;;
    map_layer_name: countries
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension: state_map {
    type: string
    sql: ${state} ;;
    map_layer_name: us_states
  }

  # dimension: over_30 {
  #   type: yesno
  #   sql: ${age}>30 ;;
  # }

  dimension: zero {
    type: number
    sql: null ;;
  }

  measure: sum_coalesce {
    type: sum
    sql: COALESCE(${zero},0) ;;
    value_format: "$[>=1000000]0.00,,\"M\";$[>=1000]0.00,\"K\";$00.00"
    html:
    {% if value != null %}
    {{rendered_value}}
    {% else %}
    $00.00
    {% endif %};;
  }

  measure: change1 {
    type: count
    html:{% if value >= 1000000 %}
      ${{value | divided_by: 1000000 | round:2 }}M
      {% else %}
      ${{ value }}
      {% endif %};;
  }

  # measure: change1 {
  #   type: number
  #   sql: ${current_week} - ${previous_week};;
  #     html:{% if value >= 1000000 %}
  #     ${{value | divided_by: 1000000 | round:2 }}M
  #     {% else %}
  #     {{
  #     {% endif %};;
  # }


  measure: count {
    type: count
    drill_fields: [detail_0*]
    description: "testing"

    link: {
      label: "Drill Test"
      url: "{{ link }}&sorts=users.max_age+desc"
  }
}

measure: count_texas {
  type: count
  filters: [state: "Texas"]
}

  # measure: count_row_liquid{
  #     type: count
  #     sql: case when ${country} = "test" THEN NULL
  #     ELSE ${id} END;;
  #     value_format_name: usd
  #   html:
  #   {% if row['users.age'] >= 40 %}
  #   <a href="#drillmenu" target="_self">{{ rendered_value }}
  #   {% else %}
  #   <a href="#drillmenu" target="_self">{{ rendered_value }}*
  #   {% endif %}
  #   ;;
  #   }

  measure: count_drill_fields_exclude {
    type: count
    drill_fields: [detail*,-first_name]
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

  measure: age_sum {
    type: sum
    sql: ${age} ;;
  }
  measure: age_sum_2 {
    type: sum
    sql: ${TABLE}.age -- AND comment
      ;;
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

  measure: max_age {
    type: max
    sql: ${age} ;;
  }

  dimension: age_sum_test_refine {
    type: number
    sql: ${age}+${users.age_plus_10} ;;
  }

  measure: distinct_last_names {
    type:count_distinct
    sql:  ${last_name};;
  }

  measure: distinct_first_names {
    type:count_distinct
    sql:  ${first_name};;
  }

  dimension: custom_error {
    type: string
    sql:
    {% if unit_select._in_query == false %}

    {% elsif unit_select._in_query %}
    "All is well"
    {% endif %}
    ;;
  }

  dimension: custom_error_2 {
    type: string
    sql:
    {% if unit_select._in_query == false %}
    "Requires Unit Select parameter value"
    {% elsif unit_select._in_query %}
    "All is well"
    {% endif %}
    ;;
  }

  parameter: unit_select {
    type: unquoted
    allowed_value: {
      label: "Units"
      value: "1s"
    }
    allowed_value: {
      label: "Tens"
      value: "10s"
    }
    allowed_value: {
      label: "Hundreds"
      value: "100s"
    }
    allowed_value: {
      label: "Thousands"
      value: "1000s"
    }
  }

  measure: error_message {
    sql:
    {% if unit_select._in_query == false %}
    custom_error_message("Error: Requires Unit Select parameter value")

    -- BQ: "Custom Error Message"."Error: Requires Unit Select parameter value"
    -- SNOWFLAKE: custom_error_message.Requires_Unit_Select_Parameter
    -- Redshift: ANY_VALUE("custom.error.message.Requires_Unit_Select_parameter_value")
    -- Redshift: custom_error_message_Requires_Unit_Select_Parameter()
    {% elsif unit_select._in_query %}
    1=1
    {% endif %}
    ;;
  }

  measure: dynamic_measure_one {
    type: number
    sql:
    {% if unit_select._parameter_value == "1s" %}
    ${count}
    {% elsif unit_select._parameter_value == "10s" %}
    ${count}/10
    {% elsif unit_select._parameter_value == "100s" %}
    ${count}/100
    {% elsif unit_select._parameter_value == "1000s" %}
    ${count}/1000
    {% endif %}
    ;;
    required_fields: [error_message]
  }


      # sql:
    # {% if unit_select._in_query == false %}
    # ${}"Requires Unit Select parameter value"
    # {% elsif unit_select._parameter_value == "1s" %}
    # ${count}
    # {% elsif unit_select._parameter_value == "10s" %}
    # ${count}/10
    # {% elsif unit_select._parameter_value == "100s" %}
    # ${count}/100
    # {% elsif unit_select._parameter_value == "1000s" %}
    # ${count}/1000
    # {% endif %}
    # ;;

  measure: dynamic_measure_one_unless {
    type: number
    sql:
    {% unless unit_select._in_query %}
    ${}"Requires Unit Select parameter value"
    {% elsif unit_select._parameter_value == "1s" %}
    ${count}
    {% elsif unit_select._parameter_value == "10s" %}
    ${count}/10
    {% elsif unit_select._parameter_value == "100s" %}
    ${count}/100
    {% elsif unit_select._parameter_value == "1000s" %}
    ${count}/1000
    {% endunless %}
    ;;
  }

  measure: dynamic_measure_two {
    type: number
    sql:
    {% if unit_select._parameter_value == "1s" %}
    ${age_sum}
    {% elsif unit_select._parameter_value == "10s" %}
    ${age_sum}/10
    {% elsif unit_select._parameter_value == "100s" %}
    ${age_sum}/100
    {% elsif unit_select._parameter_value == "1000s" %}
    ${age_sum}/1000
    {% else %}
    "Requires Unit Select parameter value"${}
    {% endif %}
    ;;
}

  measure: dynamic_measure_three {
    type:number
    sql:
    {% if unit_select._parameter_value == "1s" %}
    ${distinct_last_names}
    {% elsif unit_select._parameter_value == "10s" %}
    ${distinct_last_names}/10
    {% elsif unit_select._parameter_value == "100s" %}
    ${distinct_last_names}/100
    {% elsif unit_select._parameter_value == "1000s" %}
    ${distinct_last_names}/1000
    {% else %}
    "Requires Unit Select parameter value"${}
    {% endif %}
    ;;
}

  measure: dynamic_measure_four {
    type:number
    sql:
    {% if unit_select._parameter_value == "1s" %}
    ${distinct_first_names}
    {% elsif unit_select._parameter_value == "10s" %}
    ${distinct_first_names}/10
    {% elsif unit_select._parameter_value == "100s" %}
    ${distinct_first_names}/100
    {% elsif unit_select._parameter_value == "1000s" %}
    ${distinct_first_names}/1000
    {% else %}
    "Requires Unit Select parameter value"${}
    {% endif %}
    ;;
  }

    # measure: distinct_users {
  #   type: count_distinct
  #   sql: CASE WHEN ${deleted_raw}>${orders.created_raw} THEN ${id} ELSE NULL END ;;
  # }

  # measure: distinct_users_test {
  #   type: count_distinct
  #   sql: CASE WHEN ${deleted_raw}>${created_raw} THEN ${id} ELSE NULL END ;;
  # }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [

      created_month,
      count,
      max_age,
      events.count,
      orders.count,
      saralooker.count,
      user_data.count
    ]
  }

  set: detail_0 {
  fields: [
    created_tz_converted_hour,
    id,
    last_name,
    first_name,
    age,
    count,
    max_age,
    events.count,
    orders.count,
    saralooker.count,
    user_data.count
  ]
  }



  set: detail_two {
    fields: [
      events.count,
      orders.count,
      saralooker.count,
      user_data.count,
      users.age_plus_10
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
  label: "{{state._value}}"
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

parameter: condition_test {
  type: string
}

dimension: age_condition_param_test {
  sql: ${age} > {% parameter condition_test %} ;;
}

}
