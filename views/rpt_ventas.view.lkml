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

  measure: This_Month{
    type: sum
    sql: ${TABLE}.BILL_QTY;;
    filters: [fecha_date: "this month"]
  }


  measure: Previous_Month{
    type: sum
    sql: if(EXTRACT(DAY FROM ${fecha_date}) <= EXTRACT(DAY FROM CURRENT_TIMESTAMP()), ${TABLE}.BILL_QTY,0) ;;
    filters: [fecha_date:  "12 month ago"]
  }


  dimension: is_before_mtd {
    type: yesno
    sql: EXTRACT(Month from ${fecha_date}) < EXTRACT(Month from CURRENT_DATE);;
  }


  measure: LitrosYearAnterior {

    type: sum
    sql: case when ${created_year} =  EXTRACT(YEAR FROM ${fecha_date})-1 then ${bill_qty} end ;;
    value_format:"#,##0.00"

  }



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
