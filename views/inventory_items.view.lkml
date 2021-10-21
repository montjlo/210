view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count]
  }

  dimension_group: created_2 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_3 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_4 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_5 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_6 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_7{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_8 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_9 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_10 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_11 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_12 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_13{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_14 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_15 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_16 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_17 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_18 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_19{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_20 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_21 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_22 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_23{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_24 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_25 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_26 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_27 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_28 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_29{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_30 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_31 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_32 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_33{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_34 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_35 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_36 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_37 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_38 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_39{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_40 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_41 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_42 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_43{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_44 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_45 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_46 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_47 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_48 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_49{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_50 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_51 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_52 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_53{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_54 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_55 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_56 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_57 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_58 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_59{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_60 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_61 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_62 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_63{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_64 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_65 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_66 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_67 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_68 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_69{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_70 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_71 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_72 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_73{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_74 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_75 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_76 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_77 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_78 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_79{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_80 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_81 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_82 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_83{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_84 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_85 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_86 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: created_87 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_88 {
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: created_89{
    type: time
    timeframes: [

    ]
    sql: ${TABLE}.created_at ;;
  }

}
