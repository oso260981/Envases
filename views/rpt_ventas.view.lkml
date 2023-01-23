view: rpt_ventas {
  derived_table: {
    sql: SELECT v.*,CAST(c.DATE AS TIMESTAMP) Fecha,c.QUARTER,c.YEAR FROM envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas v
      LEFT JOIN envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on v.CALDAY=c.CALDAY
       ;;
  }



  dimension_group: created {
    label: "Periodo"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      month_name,
      year
    ]
    sql: CAST(${TABLE}.Fecha AS TIMESTAMP) ;;

  }






  measure: count {
    type: count
    drill_fields: [detail*]
  }









  dimension: year {
    label: "año"
    type: number
    sql: ${TABLE}.YEAR ;;
  }

  dimension: net_wgt_dl {
    type: number
    sql: ${TABLE}.NET_WGT_DL ;;
  }

  dimension: unit_of_wt {
    type: string
    sql: ${TABLE}.UNIT_OF_WT ;;
  }

  dimension: stat_curr {
    type: string
    sql: ${TABLE}.STAT_CURR ;;
  }

  dimension: matl_group {
    type: string
    sql: ${TABLE}.MATL_GROUP ;;
  }

  dimension: bill_qty {
    type: number
    sql: ${TABLE}.BILL_QTY ;;
  }

  dimension: znetval {
    type: number
    sql: ${TABLE}.ZNETVAL ;;
  }

  dimension: zpptoqty {
    type: number
    sql: ${TABLE}.ZPPTOQTY ;;
  }

  dimension: zppto {
    type: number
    sql: ${TABLE}.ZPPTO ;;
  }

  dimension: zpriceval {
    type: number
    sql: ${TABLE}.ZPRICEVAL ;;
  }

  dimension: len {
    type: number
    sql: ${TABLE}.LEN ;;
  }

  dimension: unit_dim {
    type: string
    sql: ${TABLE}.UNIT_DIM ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.CURRENCY ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.UNIT ;;
  }

  dimension: sold_to {
    type: string
    sql: ${TABLE}.SOLD_TO ;;
  }

  dimension: cust_group {
    type: string
    sql: ${TABLE}.CUST_GROUP ;;
  }

  dimension: matl_type {
    type: string
    sql: ${TABLE}.MATL_TYPE ;;
  }

  dimension: prodh1 {
    type: string
    sql: ${TABLE}.PRODH1 ;;
  }

  dimension: size_dim {
    type: string
    sql: ${TABLE}.SIZE_DIM ;;
  }

  dimension: extmatlgrp {
    type: string
    sql: ${TABLE}.EXTMATLGRP ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: sales_grp {
    type: string
    sql: ${TABLE}.SALES_GRP ;;
  }

  dimension: sales_off {
    type: string
    sql: ${TABLE}.SALES_OFF ;;
  }

  dimension: prodh2 {
    type: string
    sql: ${TABLE}.PRODH2 ;;
  }

  dimension: prodh3 {
    type: string
    sql: ${TABLE}.PRODH3 ;;
  }

  dimension: prodh4 {
    type: string
    sql: ${TABLE}.PRODH4 ;;
  }

  dimension: prod_hier {
    type: string
    sql: ${TABLE}.PROD_HIER ;;
  }

  dimension: ziosd00_a {
    type: string
    sql: ${TABLE}.ZIOSD00A ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.VERSION ;;
  }

  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension: material {
    type: string
    sql: ${TABLE}.MATERIAL ;;
  }

  dimension: distr_chan {
    type: string
    sql: ${TABLE}.DISTR_CHAN ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.DIVISION ;;
  }

  dimension: salesorg {
    type: string
    sql: ${TABLE}.SALESORG ;;
  }

  dimension: calday {
    type: string
    sql: ${TABLE}.CALDAY ;;
  }

  dimension: loc_currcy {
    type: string
    sql: ${TABLE}.LOC_CURRCY ;;
  }

  dimension: base_uom {
    type: string
    sql: ${TABLE}.BASE_UOM ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.SUBCATEGORY ;;
  }

  dimension_group: fecha {
    type: time
    sql: ${TABLE}.Fecha ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.QUARTER ;;
  }

  measure: Total_bill_qty {
    type: sum
    sql: ${TABLE}.BILL_QTY ;;
    drill_fields: [detail*]
  }

######  Filtros Periodos actuales y anteriores mes ########################################################################################

  filter: date_filter {

    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
  }


  dimension_group: filter_start_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: CASE WHEN {% date_start date_filter %} IS NULL THEN '2013-01-01' ELSE CAST({% date_start date_filter %} AS DATE) END;;

  }

  dimension_group: filter_end_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
  }


  dimension: interval {
    hidden: yes
    type: number
    sql: date_diff(${filter_start_date_raw}, ${filter_end_date_raw},day);;
  }

  dimension: previous_start_date {
    hidden: yes
    type: string
    sql: DATE_ADD(DATE ${filter_start_date_raw}, INTERVAL -12 month);;

   # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }


  dimension: previous_end_date {
    hidden: yes
    type: string
    sql: DATE_ADD(DATE ${filter_end_date_raw}, INTERVAL -12 month);;

    # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }

  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: ${created_date} >= ${filter_start_date_date} AND ${created_date} <= ${filter_end_date_date} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
   # sql: ${created_date} >= ${previous_start_date} AND ${created_date} < ${filter_start_date_date} ;;
    sql: ${created_date} >= ${previous_start_date} AND ${created_date} <= ${previous_end_date} ;;
  }

  dimension: timeframes {
    description: "Use this field in combination with the date filter field for dynamic date filtering"
    suggestions: ["period","previous period"]
    type: string
    case: {
      when: {
        sql: ${is_current_period} = true;;
        label: "Selected Period"
       }

      when: {
        sql: ${is_previous_period} = true;;
        label: "Previous Period"
      }
      else: "Not in time period"
    }
  }

  dimension: Agregacion_DIA {
   label: "Agregación DÍA"
    type: number
    sql:  EXTRACT(day FROM ${filter_start_date_date})  ;;
  }

  ####################################################################################################################################


  ####################################Medias Calculadas###############################################################################

  measure: NATIONAL_QTY_MTD {
    label: "NATIONAL QTY_MTD"
    type: sum
    sql: ${bill_qty} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }

  measure: NATIONAL_QTY_MTDY {
    label: "NATIONAL QTY_MTD_AÑO ANT"
    type: sum
    sql: ${bill_qty} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
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


  measure: NATIONAL_BUD_QTY_MTD {
    label: "NATIONAL BUD QTY MTD"
    type: sum
    sql: ${bill_qty} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }

  measure: BUD_DIA_MES_NATIONAL_QTY {
    label: "BUD_DÍA_MES_NATIONAL_QTY"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 2 THEN ${NATIONAL_BUD_QTY_MTD}/28
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 3 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 4 THEN ${NATIONAL_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 5 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 6 THEN ${NATIONAL_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 7 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 8 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 9 THEN ${NATIONAL_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 10 THEN ${NATIONAL_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 11 THEN ${NATIONAL_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 12 THEN ${NATIONAL_BUD_QTY_MTD}/31
              ELSE ${NATIONAL_BUD_QTY_MTD}
              END;;

  }


  measure: BUD_NATIONAL_QTY_MTD {
    label: "BUD NATIONAL QTY_MTD"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${BUD_DIA_MES_NATIONAL_QTY}* ${Agregacion_DIA}
    else ${BUD_DIA_MES_NATIONAL_QTY}* ${Agregacion_DIA}  END;;

    }


  measure: VS_BUD_QTY {
    label: "% VS BUD QTY"
    type: number
    sql: CASE WHEN ${NATIONAL_QTY_MTD}>0 AND ${BUD_NATIONAL_QTY_MTD}=0 THEN 1
              WHEN ${NATIONAL_QTY_MTD}=0 AND ${BUD_NATIONAL_QTY_MTD}>0 THEN -1
              WHEN (${NATIONAL_QTY_MTD} / NULLIF(${BUD_NATIONAL_QTY_MTD},0)) -1=-1 THEN 0 ELSE (${NATIONAL_QTY_MTD} / NULLIF(${BUD_NATIONAL_QTY_MTD},0))-1
              END;;
    value_format: "0.00\%"
  }


  measure: NATIONAL_AMOUNT_MTD {
    label: "NATIONAL AMOUNT MTD"
    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    drill_fields: [detail*]
  }

  measure: NATIONAL_AMOUNT_MTD_YEAR_ANT {
    label: "NATIONAL AMOUNT MTD AÑO ANTD"
    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

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












  measure: selected_period_order_revenue {
    type: count
   # sql: ${TABLE}.BILL_QTY ;;

    filters: {
      field: is_current_period
      value: "yes"
    }
  #  value_format_name: decimal_1
  }



  measure: previous_period_order_revenue {
    label: "Peiodo Anterior"
    type: count

   # sql: ${TABLE}.BILL_QTY ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }
  #  value_format_name: decimal_1

  }

 ####################################################################################################################################


  set: detail {
    fields: [
      net_wgt_dl,
      unit_of_wt,
      stat_curr,
      matl_group,
      bill_qty,
      znetval,
      zpptoqty,
      zppto,
      zpriceval,
      len,
      unit_dim,
      currency,
      unit,
      sold_to,
      cust_group,
      matl_type,
      prodh1,
      size_dim,
      extmatlgrp,
      country,
      sales_grp,
      sales_off,
      prodh2,
      prodh3,
      prodh4,
      prod_hier,
      ziosd00_a,
      version,
      plant,
      material,
      distr_chan,
      division,
      salesorg,
      calday,
      loc_currcy,
      base_uom,
      category,
      subcategory,
      fecha_time,
      quarter
    ]
  }
}
