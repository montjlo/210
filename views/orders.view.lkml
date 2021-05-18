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
}
