view: envases {
  derived_table: {
    sql: select 'CP 19L' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'CP 15L' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'CP 10L' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'CP 08L' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'CP 04L' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Cubeta de Plastico' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Porron de Plastico' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Tambores de Plastico' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Bote Bocan' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Tambores' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Tambores Conicos' categoria,* from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
      union all
      select 'Cubeta de Lamina' categoria,*  from `envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: NATIONAL_QTY_MTD {
    label: "NATIONAL QTY_MTD"
    type: sum
    sql: ${bill_qty} ;;
   filters: [distr_chan: "10",znetval: "0"]
    drill_fields: [detail*]
  }

  measure: _VS_QTY {
    label: "% VS QTY"
    type: count
    drill_fields: [detail*]
  }

  measure: _VS_BUD_QTY {
    label: "% VS BUD QTY"
    type: count
    drill_fields: [detail*]
  }

  measure: NATIONAL_AMOUNT_MTD {
    label: "NATIONAL AMOUNT MTD"
    type: count
    drill_fields: [detail*]
  }

  measure: VS_BUD_VAL {
    label: "%VS BUD VAL"
    type: count
    drill_fields: [detail*]
  }

  measure: EXPORT_QTY_MTD {
    label: "EXPORT QTY_MTD"
    type: count
    drill_fields: [detail*]
  }



  dimension: categoria {
    type: string
    sql: ${TABLE}.categoria ;;
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

  dimension: calendario {
    type: date
    sql: PARSE_DATE("%Y%m%d", CAST(calday AS TEXT)) ;;
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

  set: detail {
    fields: [
      categoria,
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
      subcategory
    ]
  }
}
