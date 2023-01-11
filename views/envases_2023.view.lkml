view: envases_2023 {
  derived_table: {
    sql:select sl.*,sy.BILL_QTY BILL_QTY2,sy.znetval znetval2 from (
      select 'CP 19L' Categoria
            ,parse_timestamp('%Y%m%d%H%M%S',cast( CONCAT(calday,'120101') as string)) created
            ,calday Fecha
            ,CONCAT(cast(cast(SUBSTR(calday,1,4)as int)-1 as STRING),SUBSTR(calday,5,4))fecha2
            ,distr_chan
            ,SALESORG
            ,SOLD_TO
            ,sum(BILL_QTY) BILL_QTY
            ,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      GROUP BY 1,2,3,4,5,6,7) sl
      left join (
                select calday ,distr_chan,sum(BILL_QTY) BILL_QTY,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`GROUP BY 1,2
               ) sy on sl.fecha2=sy.calday and sl.distr_chan=sy.distr_chan
      UNION ALL
      select sl.*,sy.BILL_QTY BILL_QTY2,sy.znetval znetval2 from (
      select 'CP 19L' Categoria
            ,parse_timestamp('%Y%m%d%H%M%S',cast( CONCAT(calday,'120101') as string)) created
            ,calday Fecha
            ,CONCAT(cast(cast(SUBSTR(calday,1,4)as int)-1 as STRING),SUBSTR(calday,5,4))fecha2
            ,distr_chan
            ,SALESORG
            ,SOLD_TO
            ,sum(BILL_QTY) BILL_QTY
            ,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      GROUP BY 1,2,3,4,5,6,7) sl
      left join (
                select calday ,distr_chan,sum(BILL_QTY) BILL_QTY,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`GROUP BY 1,2
               ) sy on sl.fecha2=sy.calday and sl.distr_chan=sy.distr_chan
                UNION ALL
      select sl.*,sy.BILL_QTY BILL_QTY2,sy.znetval znetval2 from (
      select 'CP 19L' Categoria
            ,parse_timestamp('%Y%m%d%H%M%S',cast( CONCAT(calday,'120101') as string)) created
            ,calday Fecha
            ,CONCAT(cast(cast(SUBSTR(calday,1,4)as int)-1 as STRING),SUBSTR(calday,5,4))fecha2
            ,distr_chan
            ,SALESORG
            ,SOLD_TO
            ,sum(BILL_QTY) BILL_QTY
            ,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      GROUP BY 1,2,3,4,5,6,7) sl
      left join (
                select calday ,distr_chan,sum(BILL_QTY) BILL_QTY,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`GROUP BY 1,2
               ) sy on sl.fecha2=sy.calday and sl.distr_chan=sy.distr_chan
                UNION ALL
      select sl.*,sy.BILL_QTY BILL_QTY2,sy.znetval znetval2 from (
      select 'CP 19L' Categoria
            ,parse_timestamp('%Y%m%d%H%M%S',cast( CONCAT(calday,'120101') as string)) created
            ,calday Fecha
            ,CONCAT(cast(cast(SUBSTR(calday,1,4)as int)-1 as STRING),SUBSTR(calday,5,4))fecha2
            ,distr_chan
            ,SALESORG
            ,SOLD_TO
            ,sum(BILL_QTY) BILL_QTY
            ,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      GROUP BY 1,2,3,4,5,6,7) sl
      left join (
                select calday ,distr_chan,sum(BILL_QTY) BILL_QTY,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`GROUP BY 1,2
               ) sy on sl.fecha2=sy.calday and sl.distr_chan=sy.distr_chan
                UNION ALL
      select sl.*,sy.BILL_QTY BILL_QTY2,sy.znetval znetval2 from (
      select 'CP 19L' Categoria
            ,parse_timestamp('%Y%m%d%H%M%S',cast( CONCAT(calday,'120101') as string)) created
            ,calday Fecha
            ,CONCAT(cast(cast(SUBSTR(calday,1,4)as int)-1 as STRING),SUBSTR(calday,5,4))fecha2
            ,distr_chan
            ,SALESORG
            ,SOLD_TO
            ,sum(BILL_QTY) BILL_QTY
            ,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      GROUP BY 1,2,3,4,5,6,7) sl
      left join (
                select calday ,distr_chan,sum(BILL_QTY) BILL_QTY,sum(znetval) znetval from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`GROUP BY 1,2
               ) sy on sl.fecha2=sy.calday and sl.distr_chan=sy.distr_chan
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: salesorg {
    type: string
    sql: ${TABLE}.SALESORG ;;
  }

  dimension: sold_to {
    type: string
    sql: ${TABLE}.SOLD_TO ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created ;;
  }

  dimension: fecha {
    type: string
    sql: ${TABLE}.Fecha ;;
  }

  dimension: Categoria {
    type: string
    sql: ${TABLE}.Categoria ;;
  }

  dimension: fecha2 {
    type: string
    sql: ${TABLE}.fecha2 ;;
  }

  dimension: distr_chan {
    type: string
    sql: ${TABLE}.distr_chan ;;
  }

  dimension: bill_qty {
    type: number
    sql: ${TABLE}.BILL_QTY ;;
  }

  dimension: znetval {
    type: number
    sql: ${TABLE}.znetval ;;
  }

  dimension: bill_qty2 {
    type: number
    sql: ${TABLE}.BILL_QTY2 ;;
  }

  dimension: znetval2 {
    type: number
    sql: ${TABLE}.znetval2 ;;
  }

  measure: NATIONAL_QTY_MTD {
    label: "NATIONAL QTY_MTD"
    type: sum
    sql: ${bill_qty} ;;
    filters: [distr_chan: "20"]
    drill_fields: [detail*]
  }

  measure: NATIONAL_QTY_MTDY {
    label: "NATIONAL QTY_MTD_AÑO ANT"
    type: sum
    sql: ${bill_qty2} ;;
    filters: [distr_chan: "20"]
    drill_fields: [detail*]
  }





  measure: VS_QTY {
    label: "% VS QTY"
    type: number
    sql: CASE WHEN ${NATIONAL_QTY_MTD} > 1 AND ${NATIONAL_QTY_MTDY} = 0 THEN 1
              WHEN ${NATIONAL_QTY_MTD} = 0 AND ${NATIONAL_QTY_MTDY} > 0 THEN -1
              WHEN (${NATIONAL_QTY_MTD}/NULLIF(${NATIONAL_QTY_MTDY},0)) -1= 0 THEN 0 ELSE (${NATIONAL_QTY_MTD}/NULLIF(${NATIONAL_QTY_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_QTY {
    label: "% VS BUD QTY"
    type: number
    sql: CASE WHEN ${NATIONAL_QTY_MTD} > 1 AND ${NATIONAL_QTY_MTDY} = 0 THEN 0
              WHEN ${NATIONAL_QTY_MTD} = 0 AND ${NATIONAL_QTY_MTDY} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${NATIONAL_QTY_MTD}/NULLIF(${NATIONAL_QTY_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: NATIONAL_AMOUNT_MTD {
    label: "NATIONAL AMOUNT MTD"
    type: sum
    sql: ${znetval}/1000 ;;
    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }

  measure: NATIONAL_AMOUNT_MTD_YEAR_ANT {
    label: "NATIONAL AMOUNT MTD AÑO ANT"
    type: sum
    sql: ${znetval2}/100 ;;
    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }


  measure: VS_VAL {
    label: "% VS VAL"
    type: number
    sql: CASE WHEN ${NATIONAL_AMOUNT_MTD} > 1 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} = 0 THEN 1
              WHEN ${NATIONAL_AMOUNT_MTD} = 0 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} > 0 THEN -1
              WHEN (${NATIONAL_AMOUNT_MTD}/NULLIF(${NATIONAL_AMOUNT_MTD_YEAR_ANT},0)) -1= 0 THEN 0 ELSE (${NATIONAL_AMOUNT_MTD}/NULLIF(${NATIONAL_AMOUNT_MTD_YEAR_ANT},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_VAL {
    label: "% VS BUD VAL"
    type: number
    sql: CASE WHEN ${NATIONAL_AMOUNT_MTD} > 1 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} = 0 THEN 0
              WHEN ${NATIONAL_AMOUNT_MTD} = 0 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${NATIONAL_AMOUNT_MTD}/NULLIF(${NATIONAL_AMOUNT_MTD_YEAR_ANT},0)) -1 END;;
    value_format: "0.00\%"

  }



  measure: EXPORT_QTY_MTD {
    label: "EXPORT QTY_MTD"
    type: sum
    sql: ${bill_qty} ;;
    filters: [distr_chan: "20"]
    drill_fields: [detail*]
  }

  measure: EXPORT_QTY_MTDY {
    label: "EXPORT QTY MTDY"
    type: sum
    sql: ${bill_qty} ;;
    filters: [distr_chan: "20"]
    drill_fields: [detail*]
  }


  measure: VS_QTY_EXP {
    label: "% VS QTY EXP"
    type: number
    sql: CASE WHEN ${EXPORT_QTY_MTD} > 1 AND ${EXPORT_QTY_MTDY} = 0 THEN 1
              WHEN ${EXPORT_QTY_MTD} = 0 AND ${EXPORT_QTY_MTDY} > 0 THEN -1
              WHEN (${EXPORT_QTY_MTD}/NULLIF(${EXPORT_QTY_MTDY},0)) -1= 0 THEN 0 ELSE (${EXPORT_QTY_MTD}/NULLIF(${EXPORT_QTY_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_QTY_EXP {
    label: "% VS BUD QTY EXP"
    type: number
    sql: CASE WHEN ${EXPORT_QTY_MTD} > 1 AND ${EXPORT_QTY_MTDY} = 0 THEN 0
              WHEN ${EXPORT_QTY_MTD} = 0 AND ${EXPORT_QTY_MTDY} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${EXPORT_QTY_MTD}/NULLIF(${EXPORT_QTY_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }




  measure: EXPORT_AMOUNT_MTD {
    label: "EXPORT AMOUNT MTD"
    type: sum
    sql: ${znetval}/1000 ;;
    filters: [distr_chan: "20"]
    drill_fields: [detail*]
  }

  measure: EXPORT_AMOUNT_MTDY {
    label: "EXPORT AMOUNT MTDY"
    type: sum
    sql: ${znetval2}/100 ;;
    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }


  measure: VS_VAL_EXP {
    label: "% VS VAL EXP"
    type: number
    sql: CASE WHEN ${EXPORT_AMOUNT_MTD} > 1 AND ${EXPORT_AMOUNT_MTDY} = 0 THEN 1
              WHEN ${EXPORT_AMOUNT_MTD} = 0 AND ${EXPORT_AMOUNT_MTDY} > 0 THEN -1
              WHEN (${EXPORT_AMOUNT_MTD}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1= 0 THEN 0 ELSE (${EXPORT_AMOUNT_MTD}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_VAL_EXP {
    label: "% VS BUD VAL EXP"
    type: number
    sql: CASE WHEN ${EXPORT_AMOUNT_MTD} > 1 AND ${EXPORT_AMOUNT_MTDY} = 0 THEN 0
              WHEN ${EXPORT_AMOUNT_MTD} = 0 AND ${EXPORT_AMOUNT_MTDY} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${EXPORT_AMOUNT_MTD}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }



  measure: TOTAL_QTY {
    label: "TOTAL QTY"
    type: number
    sql: ${NATIONAL_QTY_MTD} + ${EXPORT_QTY_MTD} ;;

    drill_fields: [detail*]
  }



  measure: TOTAL_QTYY {
    label: "TOTAL QTYY"
    type: number
    sql: ${NATIONAL_QTY_MTDY} + ${EXPORT_QTY_MTDY} ;;

    drill_fields: [detail*]
  }


  measure: _VS_YEAR_ANT_QTY_T {
    label: "% VS AÑO ANT QTY T"
    type: number
    sql: CASE WHEN ${TOTAL_QTY} > 1 AND ${TOTAL_QTYY} = 0 THEN 1
              WHEN ${TOTAL_QTY} = 0 AND ${TOTAL_QTYY} > 0 THEN -1
              WHEN (${TOTAL_QTY}/NULLIF(${TOTAL_QTYY},0)) -1= 0 THEN 0 ELSE (${TOTAL_QTY}/NULLIF(${TOTAL_QTYY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_QTY_T {
    label: "% VS BUD QTY T"
    type: number
    sql: CASE WHEN ${TOTAL_QTY} > 1 AND ${TOTAL_QTYY} = 0 THEN 0
              WHEN ${TOTAL_QTY} = 0 AND ${TOTAL_QTYY} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${TOTAL_QTY}/NULLIF(${TOTAL_QTYY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure:  TOTAL_AMOUNT {
    label: "TOTAL AMOUNT"
    type: number
    sql: ${NATIONAL_AMOUNT_MTD_YEAR_ANT} + ${EXPORT_AMOUNT_MTDY} ;;

    drill_fields: [detail*]
  }


  measure: _VS_YEAR_ANT_VAL_T {
    label: "% VS AÑO ANT VAL T"
    type: number
    sql: CASE WHEN ${NATIONAL_AMOUNT_MTD_YEAR_ANT} > 1 AND ${EXPORT_AMOUNT_MTDY} = 0 THEN 1
              WHEN ${NATIONAL_AMOUNT_MTD_YEAR_ANT} = 0 AND ${EXPORT_AMOUNT_MTDY} > 0 THEN -1
              WHEN (${NATIONAL_AMOUNT_MTD_YEAR_ANT}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1= 0 THEN 0 ELSE (${NATIONAL_AMOUNT_MTD_YEAR_ANT}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }


  measure: VS_BUD_T {
    label: "% VS BUD T"
    type: number
    sql: CASE WHEN ${NATIONAL_AMOUNT_MTD_YEAR_ANT} > 1 AND ${EXPORT_AMOUNT_MTDY} = 0 THEN 0
              WHEN ${NATIONAL_AMOUNT_MTD_YEAR_ANT} = 0 AND ${EXPORT_AMOUNT_MTDY} > 0 THEN 0
              WHEN 0= 0 THEN 100 ELSE (${NATIONAL_AMOUNT_MTD_YEAR_ANT}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1 END;;
    value_format: "0.00\%"

  }








  set: detail {
    fields: [
      created_time,
      fecha,
      fecha2,
      distr_chan,
      bill_qty,
      znetval,
      bill_qty2,
      znetval2
    ]
  }
}
