view: orders {
  sql_table_name: demo_db.orders ;;
 # drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [id, count]
    #html:  <p style="color: black; font-size:175%">{{ rendered_value }}</p> ;;

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
      year
    ]
    sql: ${TABLE}.created_at ;;
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
    drill_fields: [status,created_date, count]
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

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"stacking\" : \"\",
      \"show_value_labels\" : false,
      \"label_density\" : 25,
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : true,
      \"y_axis_gridlines\" : true,
      \"show_view_names\" : false,
      \"limit_displayed_rows\" : false,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\" : false,
      \"show_x_axis_ticks\" : true,
      \"x_axis_scale\" : \"auto\",
      \"y_axis_scale_mode\" : \"linear\",
      \"show_null_points\" : true,
      \"point_style\" : \"circle\",
      \"ordering\" : \"none\",
      \"show_null_labels\" : false,
      \"show_totals_labels\" : false,
      \"show_silhouette\" : false,
      \"totals_color\" : \"#808080\",
      \"type\" : \"looker_scatter\",
      \"interpolation\" : \"linear\",
      \"series_types\" : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\" : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\" : \"#000000\",
      \"label_position\" : \"left\",
      \"period\" : 30,
      \"regression_type\" : \"average\",
      \"series_index\" : 1,
      \"show_label\" : true,
      \"label_type\" : \"string\",
      \"label\" : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: percent_of_total {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: count_2 {
    type: count
    value_format: "[>=1000000]#,##0.0,, \"M€\";[>=1000]#,##0.0, \"K€\";#,##0.0 \"€\""
  }
}
