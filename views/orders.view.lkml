view: orders {
  sql_table_name: demo_db.orders ;;
 # drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  #Module 3 part 1 A#
  link: {
    label: "Drill Dashboard ID"
    url: "/dashboards-next/130?Orders ID={{ value }}&Age={{ users.age._value | url_encode }}"
  }
  #Module 3 part 1 B#
    link: {
      label: "Passing filters"
      url: "/dashboards-next/130?Created Date={{ _filters['created_date'] | url_encode}}"
    }
    link: {
      label: "Drill to explore"
      url: "https://lookerv2118.dev.looker.com/explore/josh_look/order_items?fields=orders.id,products.brand&f[orders.created_year]={{ _filters['created_year'] | url_encode }}"
    }
    link: {
      label: "Drill with special characters"
      url: "https://lookerv2118.dev.looker.com/explore/josh_look/orders?fields=orders.id,orders.user_id&f[orders.name]={{ _filters['name'] | url_encode }}"
    }
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      day_of_week,
      date,
      week,
      month,
      quarter,
      year,
      hour_of_day
    ]
    sql: ${TABLE}.created_at ;;
    drill_fields: [users.last_name, users.first_name]
  }

  dimension: Newhour {
    type: number
    sql: ${created_hour_of_day} ;;
  }
  dimension: Newhour1 {
    sql:
    CASE
    WHEN ${created_hour_of_day} = 6 THEN 1
    WHEN ${created_hour_of_day} = 7 THEN 2
    WHEN ${created_hour_of_day} = 8 THEN 3
    WHEN ${created_hour_of_day} = 9 THEN 4
    WHEN ${created_hour_of_day} = 10 THEN 5
    WHEN ${created_hour_of_day} = 11 THEN 6
    WHEN ${created_hour_of_day} = 12 THEN 7
    WHEN ${created_hour_of_day} = 13 THEN 8
    WHEN ${created_hour_of_day} = 14 THEN 9
    WHEN ${created_hour_of_day} = 15 THEN 10
    WHEN ${created_hour_of_day} = 16 THEN 11
    WHEN ${created_hour_of_day} = 17 THEN 12
    ELSE NULL
    END;;
  }
  dimension: Concat_values{
    type:string
    sql: CONCAT(${created_date}," ","Durga");;
  }
  dimension: name {
    type: string
    sql: 'Durga''s' 'look' ;;
  }
  parameter: liquid_test {
    type: string
    allowed_value: {
      label: "default"
      value: "complete"
    }
  }

  filter: one_one {
    type: string
  }

  dimension: picture {
    type: string
    sql: ${id} ;;
    html: <a href="/dashboards-next/264"><img src="https://icons.iconarchive.com/icons/google/noto-emoji-travel-places/256/42652-sun-icon.png" width="50" height="50" />Main Menu</a> ;;
  }

  dimension: picture_svg {
    type: string
    sql: ${id} ;;
    html: <a href="/dashboards-next/264"><img src = "https://openclipart.org/download/194282/mail-envelope-blue.svg" width ="50" height = "50" />Main Menu</a> ;;
  }

  dimension: picture2 {
    sql: ${id} ;;
    html: <img src = "https://openclipart.org/download/194282/mail-envelope-blue.svg" width ="5" height = "5" />;;
  }

  dimension: drill_status {
    #group_label: "dimension_店舗軸"
    label: "店舗館タイプ"
    type: string
    sql: ${TABLE}.status ;;
    drill_fields: [id, user_id]
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    drill_fields: [users.last_name, users.first_name]
  }

  dimension: status_case {
    type: string
    case: {
      when: {
        sql: ${status} = "complete";;
        label: "Complete - L"
      }
      when: {
        sql: ${status} = "cancelled";;
        label: "Cancelled - L"
      }
      else:" "
    }
  }

  dimension: status_image {
    sql: ${TABLE}.status ;;
    html: {% if value == 'complete' %}
         <p><img src="http://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20>{{rendered_value}}</p>
      {% elsif value == 'pending' %}
        <p><img src="http://findicons.com/files/icons/1681/siena/128/clock_blue.png" height=20 width=20>{{rendered_value}}</p>
      {% else %}
        <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20>{{rendered_value}}</p>
      {% endif %}
;;
  }

  dimension: status_null {
    type: string
    sql: CASE WHEN ${status} = "complete" THEN NULL
    ELSE ${status_case} END;;
    }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
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

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
    {% else %}
      ${created_date}
    {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [users.last_name, users.first_name]
    value_format_name: decimal_1
    html: {{rendered_value}} ;;
    # link: {
    #   label: "Show as scatter plot"
    #   url: "
    #   {% assign vis_config = '{
    #   \"type\" : \"single_value\"
    #   }' %}
    #   {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    # }
  }

  measure: percent_of_total {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: count_2 {
    type: count
    value_format: "[>=1000000]#,##0.0,, \"M€\";[>=1000]#,##0.0, \"K€\";#,##0.0 \"€\""
  }
  parameter: date_granular {
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

  dimension: date_granularity1 {
       html:
           {% if date_granular._parameter_value == 'day' %}
            <a href = "https://lookerv2118.dev.looker.com/explore/josh_look/order_items?fields=users.age,order_items.sale_price,orders.id&f[users.age]={{ value }}"</a>
           {% endif %};;
}
}
