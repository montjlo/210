include: "/views/users.view"
view: users_extend {
  extends: [users]

  measure: count_help_2 {
    type: number
    sql: ${count_help}+10 ;;
  }

}
