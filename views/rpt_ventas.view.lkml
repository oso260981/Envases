view: rpt_ventas {
  derived_table: {
    sql: SELECT v.*,c.DATE Fecha,c.QUARTER FROM envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas v
      LEFT JOIN envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on v.CALDAY=c.CALDAY
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.Fecha ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.QUARTER ;;
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
      fecha,
      quarter
    ]
  }
}
