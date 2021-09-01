include: "users_base.view.lkml"
include: "users_refine_3.view.lkml"
view: +users {

  dimension: age_plus_20 {
    type: number
    sql: ${TABLE}.age + 20 ;;
  }
}
