include: "users_base.view.lkml"
include: "users_refine_2.view.lkml"
view: +users {

  dimension: age_plus_10 {
    type: number
    sql: ${TABLE}.age + 10 ;;
  }
  }
