view: flights {
  sql_table_name: demo_db.flights ;;

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
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
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    suggestable: yes
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension_group: dep {
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
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
    link: {
      label: "Link to new dashboard"
      url: "/embed/dashboards-next/85?_theme={\"show_filters_bar\":false}"
    }
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  measure: count {
    type: count
    drill_fields: []
    # html: <p style="color: blue; font-size:25%"><a href="https://www.google.com"</a><u>Take me to Google</u></p> ;;
  }

  measure: filtered_count {
    type: count
    filters: [arr_date: "-NULL", carrier: "NW"]
  }

  measure: sum {
    type: sum
    sql: ${dep_delay} ;;
  }

  measure: filtered_sum {
    type: sum
    sql: ${dep_delay} ;;
    filters: [arr_date: "-NULL"]
  }

  # dimension: material_type_filter {
  #   type: string
  #   sql: "FG";;
  #   label: "Material Type"
  # }

  # parameter: Material_Type_param {
  #   default_value: "FG"
  #   type: string
  #   allowed_value: {label:"Finished Goods Only (FG)" value:"FG"}
  #   allowed_value: {label:"Raw Materials Only (RM)" value:"RM"}
  #   allowed_value: {label:"Upstream" value:"Upstream"}
  # }

  # dimension: Material_Type_Value {
  #   sql: CASE WHEN {% parameter Material_Type_param %} = ${material_type_filter} THEN 'Show'
  #   ELSE 'Hide' END ;;
  # }

}
