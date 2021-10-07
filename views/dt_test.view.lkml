view: dt_test {
  derived_table: {
    sql: SELECT
          `age` AS `users.age`,
          COUNT(*) AS `users.count`
      FROM
          `demo_db`.`users` AS `users`
      GROUP BY
          1
      ORDER BY
          COUNT(*) DESC
      LIMIT 500
       ;;
      #persist_for: "2 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_age {
    type: number
    sql: ${TABLE}.`users.age` ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}.`users.count` ;;
  }

  set: detail {
    fields: [users_age, users_count]
  }
}
