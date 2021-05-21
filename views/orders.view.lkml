view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: picture {
    type: string
    sql: ${id} ;;
    html: <img src="https://icons.iconarchive.com/icons/google/noto-emoji-travel-places/256/42652-sun-icon.png" width="10" height="10" /> ;;
  }

  dimension: picture2 {
    sql: ${id} ;;
    html: <img src = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/The_Sun_by_the_Atmospheric_Imaging_Assembly_of_NASA%27s_Solar_Dynamics_Observatory_-_20100819.jpg/800px-The_Sun_by_the_Atmospheric_Imaging_Assembly_of_NASA%27s_Solar_Dynamics_Observatory_-_20100819.jpg" width ="5" height = "5" />;;
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

  dimension: status_null {
    type: string
    sql: CASE WHEN ${status} = "pending" THEN ""
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
  }

  measure: count_2 {
    type: count
    value_format: "[>=1000000]#,##0.0,, \"M€\";[>=1000]#,##0.0, \"K€\";#,##0.0 \"€\""
  }
}
