view: test {
  derived_table: {
    sql: select 'LHR' origin, 'DFW' destination, 300 seats, '123--67' as frequency
      union all
      select 'MAD' origin, 'DFW' destination, 250 seats, '1-3--67' as frequency
      union all
      select 'DFW' origin, 'SFO' destination, -220 seats, '------7' as frequency
      union all
      select 'LAX' origin, 'DFW' destination, 150 seats, '1234567' as frequency
      union all
      select 'DFW' origin, 'ORD' destination, -180 seats, '-23--67' as frequency
      ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: frequency {
    type: string
    sql: ${TABLE}.frequency ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: seats {
    type: number
    sql: ${TABLE}.seats ;;
  }

  measure: total_seats {
    type: sum
    sql: ${seats} ;;
  }

  measure: freq {
    type: max
    value_format: "#######"
    sql: ${frequency} ;;
    html:
    <ul>
    <li><b>{{ value }}</b></li>
    <li>{{ rendered_value }}</li>
    </ul>;;
  }

  measure: freq_min {
    type: min
    value_format: "#######"
    sql: ${frequency} ;;
    html:
    <ul>
    <li><b>{{ value }}</b></li>
    <li>{{ rendered_value }}</li>
    </ul>;;
  }
}
