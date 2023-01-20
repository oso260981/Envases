view: calendar {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: calday {
    type: string
    sql: ${TABLE}.CALDAY ;;
  }

  dimension: date {
    type: date
    datatype: date
    sql: ${TABLE}.DATE ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.YEAR ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.MONTH ;;
  }

  dimension: day {
    type: number
    sql: ${TABLE}.DAY ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.QUARTER ;;
  }

  set: detail {
    fields: [
      calday,
      date,
      year,
      month,
      day,
      quarter
    ]
  }
}
