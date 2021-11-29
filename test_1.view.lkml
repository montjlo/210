view: test_1 {
  derived_table: {
    sql: SELECT
          `users`.`gender` AS `users.gender`,
              (DATE(CONVERT_TZ(`users`.`created_at`,'UTC','America/Los_Angeles'))) AS `users.created_date`
      FROM
          `demo_db`.`order_items` AS `order_items`
          LEFT JOIN `demo_db`.`orders` AS `orders` ON `order_items`.`order_id` = `orders`.`id`
          LEFT JOIN `demo_db`.`users` AS `users` ON `orders`.`user_id` = `users`.`id`
          WHERE {% condition Date_filter %} users.created_at {% endcondition %} AND
                {% condition gender %} users.gender {% endcondition %}
      GROUP BY
          1,
          2
      ORDER BY
          `users`.`gender`
       ;;
  }

  filter: Date_filter {

    type: string

    suggest_dimension: users.userdate
    suggest_explore: users

}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_gender {
    type: string
    sql: ${TABLE}.`users.gender` ;;
  }

  dimension: users_created_date {
    type: date
    sql: ${TABLE}.`users.created_date` ;;
  }

  parameter: gender {
    type: unquoted
    allowed_value: {
      label: "Break down by male"
      value: "m"
    }
    allowed_value: {
      label: "Break down by female"
      value: "f"
    }
  }

  dimension: Dateformatted {
    sql:
    {% if gender._parameter_value == 'm' %}
      DATE_FORMAT(${users_created_date}, "%m-%d-%Y")
    {% else %}
      DATE_FORMAT(${users_created_date}, "%d-%m-%Y")
    {% endif %};;
  }
  dimension: date_formatted {

    label: "Date_formatted"

    sql: ${users_created_date} ;;

    html:

    {% if _user_attributes['gender'] == 'm' %}

    {{ rendered_value | date: "%d-%m-%y" }}

    {% endif %};;
  }
  set: detail {
    fields: [users_gender, users_created_date]
  }
}
