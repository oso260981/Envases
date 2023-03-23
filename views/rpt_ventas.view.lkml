view: rpt_ventas {
  derived_table: {
    sql: SELECT v.*,CAST(c.DATE AS TIMESTAMP) Fecha,c.QUARTER,c.YEAR FROM envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas v
      LEFT JOIN envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on v.CALDAY=c.CALDAY  WHERE CATEGORY NOT IN ('TOTAL MXN')

   UNION ALL

   SELECT V.NET_WGT_DL
,V.UNIT_OF_WT
,V.STAT_CURR
,V.MATL_GROUP
,V.BILL_QTY
,V.znetval *UKURS  znetval
,V.ZPPTOQTY
,V.ZPPTO
,V.ZPRICEVAL
,V.LEN
,V.UNIT_DIM
,V.CURRENCY
,V.UNIT
,V.SOLD_TO
,V.CUST_GROUP
,V.MATL_TYPE
,V.PRODH1
,V.SIZE_DIM
,V.EXTMATLGRP
,V.COUNTRY
,V.SALES_GRP
,V.SALES_OFF
,V.PRODH2
,V.PRODH3
,V.PRODH4
,V.PROD_HIER
,V.ZIOSD00A
,V.VERSION
,V.PLANT
,V.MATERIAL
,V.DISTR_CHAN
,V.DIVISION
,V.SALESORG
,V.CALDAY
,V.LOC_CURRCY
,V.BASE_UOM
,'TOTAL MXN' CATEGORY
,V.SUBCATEGORY
,V.CLIENT
,CAST(c.DATE AS TIMESTAMP) Fecha,c.QUARTER,c.YEAR  FROM envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas v
LEFT JOIN envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on v.CALDAY=c.CALDAY
LEFT JOIN (

 SELECT CAST(99999999 - CAST(GDATU AS NUMERIC) AS STRING) AS CALDAY, TRIM(FCURR) FCURR, TRIM(TCURR) TCURR, UKURS,c.date FROM `envases-analytics-eon-poc.DATASET_RAW.ECC_PROD_TCURR`
 left join envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on c.CALDAY=CAST(99999999 - CAST(GDATU AS NUMERIC) AS STRING)
 WHERE TRIM(FCURR) IN ('USD', 'EUR', 'DKK', 'GTQ') AND TRIM(TCURR) = 'MXN' AND TRIM(KURST) = 'M'  AND    c.DATE= CAST({% date_start date_filter %} AS DATE)

) mo on   v.STAT_CURR=mo.FCURR
WHERE CATEGORY='TOTAL MONEDA ORIGEN'

union all

SELECT v.*,CAST(c.DATE AS TIMESTAMP) Fecha,c.QUARTER,c.YEAR FROM envases-analytics-eon-poc.ENVASES_REPORTING.rpt_ventas v
      LEFT JOIN envases-analytics-eon-poc.ENVASES_REPORTING.CALENDAR c on v.CALDAY=c.CALDAY  WHERE CATEGORY in ('TOTAL MXN') and SALESORG in ( "MXF1","MXFC")


       ;;
  }



  dimension_group: created {
    label: "Fecha"
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


  filter: date_filter {
    label: "Período"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
   # default_value: "6 weeks"

  }










  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: fechanumero {

    type: string
    sql:  replace(SUBSTR( CAST ({% date_start date_filter %} AS STRING), 1,10),"-","")    ;;
  }


  dimension:UltimafechaCarga {

    type: string
    sql:  MAX(CAST(${TABLE}.Fecha AS TIMESTAMP));;
  }



  dimension: Client {
    label: "Cliente"
    type: string
    sql: ${TABLE}.CLIENT ;;
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
    label: "Tipo moneda"
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
   # sql: case when ${TABLE}.CATEGORY is null then 'Otros' else ${TABLE}.CATEGORY  end ;;
    sql:  ${TABLE}.CATEGORY ;;

    html: {% if value == 'TOTAL MONEDA ORIGEN' or
                value == 'TOTAL MXN'

    %}
  <p style="color: white; background-color: #5e2129; font-size:100%; text-align:left">{{ rendered_value }}</p>
  {% else %}
  <p style="">{{ rendered_value }}</p>
  {% endif %} ;;




  }



  dimension: category_orden {
    label: "category_orden_mexico"
    type: string
    sql: case

when ${TABLE}.CATEGORY="CP 19L" then "A01"
when ${TABLE}.CATEGORY="CP 15L" then "A02"
when ${TABLE}.CATEGORY="CP 10L" then "A03"
when ${TABLE}.CATEGORY="CP 08L" then "A04"
when ${TABLE}.CATEGORY="CP 04L" then "A05"
when ${TABLE}.CATEGORY="Cubeta de Plastico" then "A06"
when ${TABLE}.CATEGORY="Porron de Plastico" then "A07"
when ${TABLE}.CATEGORY="Tambores de Plastico" then "A08"
when ${TABLE}.CATEGORY="Bote bocan" then "A09"
when ${TABLE}.CATEGORY="Tambores" then "A10"
when ${TABLE}.CATEGORY="Tambores Conicos" then "A11"
when ${TABLE}.CATEGORY="Cubeta de Lamina" then "A12"
when ${TABLE}.CATEGORY="Alcoholero" then "A13"
when ${TABLE}.CATEGORY="Bote de Pintura" then "A14"
when ${TABLE}.CATEGORY="Bote de Aerosol" then "A15"
when ${TABLE}.CATEGORY="Línea General" then "A16"
when ${TABLE}.CATEGORY="Bote Sanitario" then "A17"
when ${TABLE}.CATEGORY="Bote Atún" then "A18"
when ${TABLE}.CATEGORY="Bote Oval" then "A19"
when ${TABLE}.CATEGORY="Tapa Easy Open" then "A20"
when ${TABLE}.CATEGORY="Fondo Charola y Bafle" then "A21"
when ${TABLE}.CATEGORY="Tapa Twiss Off" then "A22"
when ${TABLE}.CATEGORY="Varios" then "A23"
when ${TABLE}.CATEGORY="Fish." then "A24"
when ${TABLE}.CATEGORY="PeelOff." then "A25"

when ${TABLE}.CATEGORY="Coating and Printing Services" then "A26"
when ${TABLE}.CATEGORY="Miscelaneous" then "A27"
when ${TABLE}.CATEGORY="Pails and lids for pails" then "A28"
when ${TABLE}.CATEGORY="Tinplate and lids for tinplate" then "A29"

when ${TABLE}.CATEGORY="Beverage Draught" then "A30"
when ${TABLE}.CATEGORY="Beverage Gravity" then "A31"
when ${TABLE}.CATEGORY="Industrial" then "A32"
when ${TABLE}.CATEGORY="SC Print" then "A33"

when ${TABLE}.CATEGORY="Bote de Aerosol GT" then "A34"
when ${TABLE}.CATEGORY="Bote de Pintura GT" then "A35"
when ${TABLE}.CATEGORY="Bote Sanitario GT" then "A36"
when ${TABLE}.CATEGORY="Bote Sanitario GT" then "A37"
when ${TABLE}.CATEGORY="Varios GT" then "A38"

when ${TABLE}.CATEGORY="Bote Pint. Envases Ohio" then "A39"
when ${TABLE}.CATEGORY="Cub.Lam. Envases Ohio" then "A40"




when ${TABLE}.CATEGORY="TOTAL MONEDA ORIGEN" then "Z1"
when ${TABLE}.CATEGORY="TOTAL MXN" then "Z2" else "z"  end ;;
  }


  dimension: category_orden_dinamarca {
    type: string
    sql: case

when ${TABLE}.CATEGORY="Mediapack" then "a01"
when ${TABLE}.CATEGORY="Catering" then "a02"
when ${TABLE}.CATEGORY="Fish" then "a03"
when ${TABLE}.CATEGORY="Ham" then "a04"
when ${TABLE}.CATEGORY="Luncheon" then "a05"
when ${TABLE}.CATEGORY="Pullman" then "a06"
when ${TABLE}.CATEGORY="Roundfood" then "a07"
when ${TABLE}.CATEGORY="Beverage" then "a08"
when ${TABLE}.CATEGORY="Dekopak" then "a09"
when ${TABLE}.CATEGORY="Feta" then "a10"
when ${TABLE}.CATEGORY="Milkpowder" then "a11"
when ${TABLE}.CATEGORY="PockIt" then "a12"
when ${TABLE}.CATEGORY="PeelOff" then "a13"
when ${TABLE}.CATEGORY="Super" then "a14"
when ${TABLE}.CATEGORY="Other" then "a15"



      when ${TABLE}.CATEGORY="TOTAL MONEDA ORIGEN" then "Z1"
      when ${TABLE}.CATEGORY="TOTAL MXN" then "Z2" else "b"  end ;;
  }











  dimension: subcategory {
    type: string
    sql:  ${TABLE}.SUBCATEGORY ;;
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
    sql: ${TABLE}.BILL_QTY/1000 ;;
    filters: [distr_chan: "10"]
    filters: [version: "000"]
    drill_fields: [detail*]
  }

######  Filtros Periodos actuales y anteriores mes ########################################################################################



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
    #sql: DATE_ADD(DATE ({% date_start created_date %}), INTERVAL -12 month);;

   # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }


  dimension: previous_end_date {
    hidden: yes
    type: string
    sql: DATE_ADD(DATE ${filter_end_date_raw}, INTERVAL -12 month);;

    #sql: DATE_ADD(DATE ({% date_end created_date %}), INTERVAL -12 month);;


    # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }


  dimension: previous_start_date_year {
    hidden: yes
    type: string
    sql: DATE_ADD(DATE ${filter_start_date_raw}, INTERVAL -1 year);;

    # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }

  dimension: previous_end_date_year {
    hidden: yes
    type: string
    sql: DATE_ADD(DATE ${filter_end_date_raw}, INTERVAL -1 year);;

    # sql: DATE_ADD(day, - ${interval}, ${filter_start_date_raw});;
  }

  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: CAST(${created_date} AS DATE) >= DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) AND CAST(${created_date} AS DATE) <= CAST({% date_start date_filter %} AS DATE) ;;
    #sql: ${created_date} >= ${filter_start_date_date} AND ${created_date} <= ${filter_end_date_date} ;;
   # sql: EXTRACT(YEAR FROM CAST(${created_date} AS DATE))  =  EXTRACT(YEAR FROM CAST({% date_start date_filter %} AS DATE)) and EXTRACT(MONTH FROM CAST(${created_date} AS DATE))=EXTRACT(MONTH FROM CAST({% date_start date_filter %} AS DATE))  ;;
# EXTRACT(YEAR FROM ${filter_start_date_date}) AND  EXTRACT(MONTH FROM ${filter_start_date_date})
   # sql: ${created_date} >= cast({% date_start created_date %} AS DATE) AND ${created_date} <= cast({% date_end created_date %} AS DATE) ;;
  }



  dimension: fecha {
    label: "fecha filtro"
    type: string
    sql: CAST({% date_start date_filter %} AS DATE) ;;
  }






  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: CAST(${created_date} AS DATE) >=  DATE_ADD(DATE (DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH)), INTERVAL -1 year)   AND CAST(${created_date} AS DATE) <= DATE_ADD(DATE (CAST({% date_start date_filter %} AS DATE)), INTERVAL -1 year)   ;;
    #sql: ${created_date} >= ${previous_start_date} AND ${created_date} <= ${previous_end_date} ;;
    #sql: EXTRACT(YEAR FROM CAST(${created_date} AS DATE))  =  EXTRACT(YEAR FROM CAST({% date_start date_filter %} AS DATE))-1 and EXTRACT(MONTH FROM CAST(${created_date} AS DATE))=EXTRACT(MONTH FROM CAST({% date_start date_filter %} AS DATE))   ;;
    #sql: ${created_date} >= cast(${previous_start_date} AS DATE) AND ${created_date} <= cast(${previous_end_date} AS DATE) ;;
  }


  dimension: is_previous_period_year {
    hidden: yes
    type: yesno
    # sql: ${created_date} >= ${previous_start_date} AND ${created_date} < ${filter_start_date_date} ;;
    #sql: ${created_date} >= ${previous_start_date_year} AND ${created_date} <= ${previous_end_date_year} ;;
    sql: ${created_year} = EXTRACT(YEAR FROM ${filter_end_date_date})-1  ;;
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

  dimension: Paises {
    case: {
      when: {
        sql: ${TABLE}.SALESORG = "DE00" ;;
        label: "Alemania"
      }
      when: {
        sql: ${TABLE}.SALESORG = "NLF1" ;;
        label: "Holanda"
      }
      when: {
        sql: ${TABLE}.SALESORG = "3100" ;;
        label: "Canadá"
      }
      when: {
        sql: ${TABLE}.SALESORG in ( "MXF1","MXFC") ;;
        label: "México"
      }
      when: {
        sql: ${TABLE}.SALESORG in ( "GTF1") ;;
        label: "Guatemala"
      }
      when: {
        sql: ${TABLE}.SALESORG in ( "DKF1","DKF3","SEF1","USF2") ;;
        label: "Dinamarca"
      }
      when: {
        sql: ${TABLE}.SALESORG in ( "USF1") ;;
        label: "USA"
      }

      else: "Otros"
    }
  }

  dimension: Agregacion_DIA {
   label: "Agregación DÍA"
    type: number
    sql:  EXTRACT(day FROM ${filter_end_date_date})  ;;
  }



  dimension: DIA_SELECCION {
    label: "DÍA_SELECCIÓN"
    type: number
    sql:  EXTRACT(day FROM CURRENT_DATE())  ;;
  }

  dimension: DIA_SELECCION_2 {
    label: "DÍA_SELECCIÓN_2"
    type: number
    sql:  EXTRACT(day FROM CURRENT_DATE())  ;;
  }

  ####################################################################################################################################


  ####################################Medias Calculadas###############################################################################

  measure: NATIONAL_QTY_MTD {
    label: "NATIONAL QTY MTD"
    type: sum
    sql: ${bill_qty}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "000"]

    drill_fields: [ Client,NATIONAL_QTY_MTD]

    value_format: "#,##0"
  }

  measure: NATIONAL_QTY_MTDY {
    label: "NATIONAL QTY_MTD AÑO ANT"
    type: sum
    sql: ${bill_qty}/1000 ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "000"]
     drill_fields: [ Client,NATIONAL_QTY_MTDY]
    value_format: "#,##0"
  }


  measure: VS_QTY {
    label: "% VS QTY"
    type: number
    sql: CASE WHEN ${NATIONAL_QTY_MTD} > 1 AND ${NATIONAL_QTY_MTDY} = 0 THEN 1
              WHEN ${NATIONAL_QTY_MTD} = 0 AND ${NATIONAL_QTY_MTDY} > 0 THEN -1
              WHEN (${NATIONAL_QTY_MTD}/NULLIF(${NATIONAL_QTY_MTDY},0))-1 = 0 THEN 0 ELSE (${NATIONAL_QTY_MTD}/NULLIF(${NATIONAL_QTY_MTDY},0))-1  END *100;;
    value_format: "0.00\%"
    drill_fields: [ Client,NATIONAL_QTY_MTD,NATIONAL_QTY_MTDY,VS_QTY]
  }


  measure: NATIONAL_BUD_QTY_MTD {
    label: "NATIONAL BUD QTY MTD"
    type: sum
    sql: ${bill_qty}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "000"]
     drill_fields: [ Client,NATIONAL_BUD_QTY_MTD]
 #   value_format: "#,##0.00"


  }

  measure: BUD_DIA_MES_NATIONAL_QTY {
    label: "BUD DÍA MES NATIONAL QTY"
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
    label: "BUD NATIONAL QTY MTD"


    type: sum
    sql: ${bill_qty}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "A00"]

    drill_fields: [ Client,BUD_NATIONAL_QTY_MTD]



   # sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${BUD_DIA_MES_NATIONAL_QTY}* ${DIA_SELECCION_2}
  #  else ${BUD_DIA_MES_NATIONAL_QTY}* ${DIA_SELECCION}  END;;
    value_format: "#,##0.00"

    }


  measure: VS_BUD_QTY {
    label: "% VS BUD QTY"
    type: number
    sql:  ((${NATIONAL_QTY_MTD}/NULLIF(${BUD_NATIONAL_QTY_MTD},0))-1)*100 ;;
  #  sql: CASE WHEN ${NATIONAL_QTY_MTD}>0 AND ${BUD_NATIONAL_QTY_MTD}=0 THEN 1
  #            WHEN ${NATIONAL_QTY_MTD}=0 AND ${BUD_NATIONAL_QTY_MTD}>0 THEN -1
  #            WHEN (${NATIONAL_QTY_MTD} / NULLIF(${BUD_NATIONAL_QTY_MTD},0)) -1=-1 THEN 0 ELSE (${NATIONAL_QTY_MTD} / NULLIF(${BUD_NATIONAL_QTY_MTD},0))-1
  #            END *100 ;;
    value_format: "0.00\%"


    drill_fields: [ Client,NATIONAL_QTY_MTD,BUD_NATIONAL_QTY_MTD,VS_BUD_QTY]

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
    filters: [version: "000"]
     drill_fields: [ category_orden,Client,NATIONAL_AMOUNT_MTD]
    value_format: "#,##0.00"
  }

  measure: NATIONAL_AMOUNT_MTD_YEAR_ANT {
    label: "NATIONAL AMOUNT MTD AÑO ANT"
    hidden: yes
    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "000"]
      drill_fields: [ Client,NATIONAL_AMOUNT_MTD_YEAR_ANT]
    value_format: "#,##0.00"
  }

  measure: VS_VAL {
    label: "% VS VAL"
    type: number
    sql: CASE WHEN ${NATIONAL_AMOUNT_MTD} > 1 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} = 0 THEN 1
              WHEN ${NATIONAL_AMOUNT_MTD} = 0 AND ${NATIONAL_AMOUNT_MTD_YEAR_ANT} > 0 THEN -1
              WHEN (${NATIONAL_AMOUNT_MTD}/NULLIF(${NATIONAL_AMOUNT_MTD_YEAR_ANT},0))-1 = 0 THEN 0 ELSE (${NATIONAL_AMOUNT_MTD}/NULLIF(${NATIONAL_AMOUNT_MTD_YEAR_ANT},0)) -1 END * 100;;
    value_format: "0.00\%"
    drill_fields: [ Client,NATIONAL_AMOUNT_MTD,NATIONAL_AMOUNT_MTD_YEAR_ANT,VS_VAL]
  }

  measure: NATIONAL_BUD_AMOUNT_MTD_MIL {
    label: "NATIONAL BUD AMOUNT MTD MIL"
    type: sum
    sql: ${znetval} ;;
    filters: [distr_chan: "10"]
    filters: [version: "000"]

    filters: {
      field: is_current_period
      value: "yes"
    }
    value_format: "#,##0.00"
  }


  measure: BUD_DIA_MES_NATIONAL_AMOUNT {
    label: "BUD DÍA MES NATIONAL AMOUNT"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 2 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/28
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 3 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 4 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 5 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 6 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 7 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 8 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 9 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 10 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 11 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 12 THEN ${NATIONAL_BUD_AMOUNT_MTD_MIL}/31
              ELSE ${NATIONAL_BUD_AMOUNT_MTD_MIL}
              END;;

  }



  measure: BUD_NATIONAL_AMOUNT_MTD {
    label: "BUD NATIONAL AMOUNT MTD"
    type: number


  #  sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${BUD_DIA_MES_NATIONAL_AMOUNT}* ${DIA_SELECCION_2}
  #    else ${BUD_DIA_MES_NATIONAL_AMOUNT} * ${DIA_SELECCION} END;;

    value_format: "#,##0.00"

    #  IF([#MES]=1,[#BUD_DÍA_MES_NATIONAL_AMOUNT]*[#DÍA_SELECCIÓN_2] , [#BUD_DÍA_MES_NATIONAL_AMOUNT]*[#DÍA_SELECCIÓN])
  }

  measure: Z_BUD_NATIONAL_AMOUNT {
    label: "Z BUD NATIONAL AMOUNT"
    type: sum

    sql: ${znetval}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "A00"]


    drill_fields: [ Client,z_BUD_NATIONAL_AMOUNT]
    value_format: "#,##0.00"


  }

  measure: VS_BUD_VAL {
    label: "% VS BUD VAL"
    type: number
    sql: ((${NATIONAL_AMOUNT_MTD}/NULLIF(${Z_BUD_NATIONAL_AMOUNT},0))-1)*100 ;;



  ##  sql: CASE WHEN ${NATIONAL_AMOUNT_MTD} > 0 AND ${Z_BUD_NATIONAL_AMOUNT} = 0 THEN 1
  ##            WHEN ${NATIONAL_AMOUNT_MTD} = 0 AND ${Z_BUD_NATIONAL_AMOUNT} > 0 THEN -1
  #            WHEN (${NATIONAL_AMOUNT_MTD} /  NULLIF (${Z_BUD_NATIONAL_AMOUNT},0))-1=-1 THEN 0 ELSE (${NATIONAL_AMOUNT_MTD} /  NULLIF (${Z_BUD_NATIONAL_AMOUNT},0))-1
  #           END *100;;
    value_format: "0.00\%"


    drill_fields: [ Client,NATIONAL_AMOUNT_MTD,Z_BUD_NATIONAL_AMOUNT,VS_BUD_VAL]

   # IF([#NATIONAL AMOUNT MTD] >0 and([#Z_BUD  NATIONAL AMOUNT]) = 0 ,1  ,
   # IF([#NATIONAL AMOUNT MTD] = 0and ([#Z_BUD  NATIONAL AMOUNT]) >0,-1 ,
  # IF(([#NATIONAL AMOUNT MTD]  /([#Z_BUD  NATIONAL AMOUNT]))-1 = -1 ,0 ,  ([#NATIONAL AMOUNT MTD] /([#Z_BUD  NATIONAL AMOUNT]))-1)))


  }



  measure: EXPORT_QTY_MTD {
    label: "EXPORT QTY MTD"
    type: sum
    sql: ${bill_qty}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
      field: is_current_period
      value: "yes"
    }

    drill_fields: [ Client,EXPORT_QTY_MTD]
    value_format: "#,##0"
  }

  measure: EXPORT_QTY_MTD_YEAR_ANT {
    label: "EXPORT QTY_MTD AÑO ANT"
    type: sum
    sql: ${bill_qty}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
      field: is_previous_period
      value: "yes"
    }

      drill_fields: [ Client,EXPORT_QTY_MTD_YEAR_ANT]
    value_format: "#,##0.00"
  }


  measure: VS_QTY_EXP {
    label: "% VS QTY EXP"
    type: number
    sql: CASE WHEN ${EXPORT_QTY_MTD} > 0 AND ${EXPORT_QTY_MTD_YEAR_ANT} = 0 THEN 1
              WHEN ${EXPORT_QTY_MTD} = 0 AND ${EXPORT_QTY_MTD_YEAR_ANT} > 0 THEN -1
              WHEN (${EXPORT_QTY_MTD}/NULLIF(${EXPORT_QTY_MTD_YEAR_ANT},0))-1 = 0 THEN 0 ELSE (${EXPORT_QTY_MTD}/NULLIF(${EXPORT_QTY_MTD_YEAR_ANT},0))-1  END *100;;
    value_format: "0.00\%"

    drill_fields: [ Client,EXPORT_QTY_MTD,EXPORT_QTY_MTD_YEAR_ANT,VS_QTY_EXP]

    #IF( [#EXPORT QTY_MTD] >0 and([#EXPORT QTY_MTD_AÑO ANT]) = 0 ,1  ,
    #IF([#EXPORT QTY_MTD] = 0and ([#EXPORT QTY_MTD_AÑO ANT]) >0,-1 ,
    #IF(([#EXPORT QTY_MTD]  /([#EXPORT QTY_MTD_AÑO ANT]))-1 = -1 ,0 ,    ([#EXPORT QTY_MTD] /([#EXPORT QTY_MTD_AÑO ANT]))-1)))

  }


  measure: EXPORT_BUD_QTY_MTD {
    label: "EXPORT BUD QTY MTD"
    type: sum
    sql: ${bill_qty}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
      field: is_current_period
      value: "yes"
    }

      drill_fields: [ Client,EXPORT_BUD_QTY_MTD]
    value_format: "#,##0.00"
  }


  measure: BUD_DIA_MES_EXPORT_QTY {
    label: "BUD DÍA MES EXPORT QTY"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 2 THEN ${EXPORT_BUD_QTY_MTD}/28
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 3 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 4 THEN ${EXPORT_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 5 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 6 THEN ${EXPORT_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 7 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 8 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 9 THEN ${EXPORT_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 10 THEN ${EXPORT_BUD_QTY_MTD}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 11 THEN ${EXPORT_BUD_QTY_MTD}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 12 THEN ${EXPORT_BUD_QTY_MTD}/31
              ELSE ${EXPORT_BUD_QTY_MTD}
              END;;

  }


  measure: BUD_EXPORT_QTY_MTD {
    label: "BUD EXPORT QTY MTD"

    type: sum
    sql: ${bill_qty}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "A00"]
    filters: {
      field: is_current_period
      value: "yes"
    }

    drill_fields: [ Client,EXPORT_BUD_QTY_MTD]
    value_format: "#,##0.00"


 #   sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${BUD_DIA_MES_EXPORT_QTY}* ${DIA_SELECCION_2}
#      else ${BUD_DIA_MES_EXPORT_QTY}* ${DIA_SELECCION}  END;;
#  value_format: "#,##0.00"
    # IF([#MES]=1,[#BUD_DÍA_MES_EXPORT_QTY]*[#DÍA_SELECCIÓN_2] , [#BUD_DÍA_MES_EXPORT_QTY]*[#DÍA_SELECCIÓN])

  }



  measure: VS_BUD_QTY_EXP {
    label: "% VS BUD QTY EXP"
    type: number
    sql: CASE WHEN ${EXPORT_QTY_MTD} > 0 AND ${BUD_EXPORT_QTY_MTD} = 0 THEN 1
              WHEN ${EXPORT_QTY_MTD} = 0 AND ${BUD_EXPORT_QTY_MTD} > 0 THEN -1
              WHEN (${EXPORT_QTY_MTD} /  NULLIF (${BUD_EXPORT_QTY_MTD},0))-1=-1 THEN 0 ELSE (${EXPORT_QTY_MTD} /  NULLIF (${BUD_EXPORT_QTY_MTD},0))-1
             END *100 ;;
    value_format: "0.00\%"

    drill_fields: [ Client,EXPORT_QTY_MTD,BUD_EXPORT_QTY_MTD,VS_BUD_QTY_EXP]

    # IF( [#EXPORT QTY_MTD] >0 and([#BUD EXPORT QTY_MTD]) = 0 ,1  ,
    #IF([#EXPORT QTY_MTD] = 0and ([#BUD EXPORT QTY_MTD]) >0,-1 ,
    #IF(([#EXPORT QTY_MTD]  /([#BUD EXPORT QTY_MTD]))-1 = -1 ,0 ,    ([#EXPORT QTY_MTD] /([#BUD EXPORT QTY_MTD]))-1)))
  }


  measure: EXPORT_AMOUNT_MTD {
    label: "EXPORT AMOUNT MTD"
    type: sum
    sql: ${znetval}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
      field: is_current_period
      value: "yes"
    }

     drill_fields: [ Client,EXPORT_AMOUNT_MTD]
    value_format: "#,##0.00"

   # [#EXPORT AMOUNT_MTD_MIL]/1000
   # [#EXPORT AMOUNT_MTD_MIL]/1000

  }

  measure: EXPORT_AMOUNT_MTDY {
    label: "EXPORT AMOUNT MTDY"
    type: sum
    sql: ${znetval}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
      field: is_previous_period
      value: "yes"
    }

     drill_fields: [ Client,EXPORT_AMOUNT_MTDY]
    value_format: "#,##0.00"
  }


  measure: VS_VAL_EXP {
    label: "% VS VAL EXP"
    type: number
    sql: CASE WHEN ${EXPORT_AMOUNT_MTD} > 1 AND ${EXPORT_AMOUNT_MTDY} = 0 THEN 1
              WHEN ${EXPORT_AMOUNT_MTD} = 0 AND ${EXPORT_AMOUNT_MTDY} > 0 THEN -1
              WHEN (${EXPORT_AMOUNT_MTD}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1= 0 THEN 0 ELSE (${EXPORT_AMOUNT_MTD}/NULLIF(${EXPORT_AMOUNT_MTDY},0)) -1 END *100;;
    value_format: "0.00\%"
    drill_fields: [ Client,EXPORT_AMOUNT_MTD,EXPORT_AMOUNT_MTDY,VS_VAL_EXP]
  }


  measure: EXPORT_BUD_AMOUNT_MTD_MIL {
    label: "EXPORT BUD AMOUNT MTD MIL"
    type: sum
    sql: ${znetval} ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]

    filters: {
      field: is_current_period
      value: "yes"
    }
    drill_fields: [ Client,EXPORT_BUD_AMOUNT_MTD_MIL]
    value_format: "#,##0.00"
  }


  measure: BUD_DIA_MES_EXPORT_AMOUNT {
    label: "BUD DÍA MES EXPORT AMOUNT"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 2 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/28
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 3 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 4 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 5 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 6 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 7 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 8 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 9 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 10 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 11 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/30
              WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 12 THEN ${EXPORT_BUD_AMOUNT_MTD_MIL}/31
              ELSE ${EXPORT_BUD_AMOUNT_MTD_MIL}
              END;;

  }



  measure: BUD_EXPORT_AMOUNT_MTD {
    label: "BUD EXPORT AMOUNT MTD"
    type: number
    sql: CASE WHEN EXTRACT(MONTH FROM ${filter_start_date_date}) = 1 THEN ${BUD_DIA_MES_EXPORT_AMOUNT}* ${DIA_SELECCION_2}
      else ${BUD_DIA_MES_EXPORT_AMOUNT}* ${DIA_SELECCION}  END;;

    value_format: "#,##0.00"
    drill_fields: [ Client,BUD_EXPORT_AMOUNT_MTD]

    # IF([#MES]=1,[#BUD_DÍA_MES_EXPORT_AMOUNT]*[#DÍA_SELECCIÓN_2] , [#BUD_DÍA_MES_EXPORT_AMOUNT]*[#DÍA_SELECCIÓN])
  }


  measure:  Z_BUD_EXPORT_AMOUNT {
    label: "Z BUD  EXPORT AMOUNT"

    type: sum
    sql: ${znetval} ;;
    filters: [distr_chan: "20"]
    filters: [version: "A00"]

    filters: {
      field: is_current_period
      value: "yes"
    }
    drill_fields: [ Client,EXPORT_BUD_AMOUNT_MTD_MIL]
    value_format: "#,##0.00"


    #   [#BUD EXPORT AMOUNT_MTD] /1000

  }





  measure: VS_BUD_VAL_EXP {
    label: "% VS BUD VAL EXP"
    type: number
    sql: ((${EXPORT_AMOUNT_MTD} /  NULLIF (${Z_BUD_EXPORT_AMOUNT},0))-1)*100 ;;
    #sql: CASE WHEN ${EXPORT_AMOUNT_MTD} > 0 AND ${Z_BUD_EXPORT_AMOUNT} = 0 THEN 1
    #          WHEN ${EXPORT_AMOUNT_MTD} = 0 AND ${Z_BUD_EXPORT_AMOUNT} > 0 THEN -1
    #          WHEN (${EXPORT_AMOUNT_MTD} /  NULLIF (${Z_BUD_EXPORT_AMOUNT},0))-1=-1 THEN 0 ELSE (${EXPORT_AMOUNT_MTD} /  NULLIF (${Z_BUD_EXPORT_AMOUNT},0))-1
    #         END *100 ;;
    value_format: "0.00\%"

    drill_fields: [ Client,EXPORT_AMOUNT_MTD,Z_BUD_EXPORT_AMOUNT,VS_BUD_VAL_EXP]

    #IF( [#EXPORT AMOUNT MTD] >0 and([#Z_BUD  EXPORT AMOUNT]) = 0 ,1  ,
    #IF([#EXPORT AMOUNT MTD] = 0and ([#Z_BUD  EXPORT AMOUNT]) >0,-1 ,
    #IF(([#EXPORT AMOUNT MTD]  /([#Z_BUD  EXPORT AMOUNT]))-1 = -1 ,0 ,  ([#EXPORT AMOUNT MTD] /([#Z_BUD  EXPORT AMOUNT]))-1)))

  }



  measure: TOTAL_QTY {
    label: "TOTAL QTY"
    type: number
    sql: ${NATIONAL_QTY_MTD} + ${EXPORT_QTY_MTD} ;;

      drill_fields: [ Client,NATIONAL_QTY_MTD,EXPORT_QTY_MTD,TOTAL_QTY]
    value_format: "#,##0"
  }



  measure: TOTAL_QTY_YEAR_ANT {
    label: "TOTAL QTY AÑO ANT"
    type: number
    sql: ${NATIONAL_QTY_MTDY} + ${EXPORT_QTY_MTD_YEAR_ANT} ;;

    drill_fields: [ Client,NATIONAL_QTY_MTDY,EXPORT_QTY_MTD_YEAR_ANT,TOTAL_QTY_YEAR_ANT]
    value_format: "#,##0.00"
  }

  measure: _VS_YEAR_ANT_QTY_T {
    label: "% VS AÑO ANT QTY T"
    type: number
    sql: CASE WHEN ${TOTAL_QTY} > 0 AND ${TOTAL_QTY_YEAR_ANT} = 0 THEN 1
              WHEN ${TOTAL_QTY} = 0 AND ${TOTAL_QTY_YEAR_ANT} > 0 THEN -1
              WHEN (${TOTAL_QTY}/NULLIF(${TOTAL_QTY_YEAR_ANT},0))  = 0 THEN 0 ELSE (${TOTAL_QTY}/NULLIF(${TOTAL_QTY_YEAR_ANT},0))   END *100;;
    value_format: "0.00\%"

    drill_fields: [ Client,TOTAL_QTY,TOTAL_QTY_YEAR_ANT,_VS_YEAR_ANT_QTY_T]

    #IF( [#TOTAL QTY] >0 and([#TOTAL QTY AÑO ANT]) = 0 ,1  ,
    #IF([#TOTAL QTY] = 0and ([#TOTAL QTY AÑO ANT]) >0,-1 ,
    #IF(([#TOTAL QTY] /([#TOTAL QTY AÑO ANT]))-1 = -1 ,0 ,    ([#TOTAL QTY] /([#TOTAL QTY AÑO ANT]))-1)))


  }


  measure: BUD_TOTAL_QTY {
    label: "BUD TOTAL QTY"
    type: number
    sql: ${NATIONAL_BUD_QTY_MTD} + ${EXPORT_BUD_QTY_MTD} ;;
    #[#NATIONAL BUD QTY MTD]+ [#EXPORT BUD QTY MTD]

   drill_fields: [ Client,NATIONAL_BUD_QTY_MTD,EXPORT_BUD_QTY_MTD,BUD_TOTAL_QTY]
    value_format: "#,##0"
  }


  measure: VS_BUD_QTY_T {
    label: "% VS BUD QTY T"
    type: number
    sql: CASE WHEN ${TOTAL_QTY} > 0 AND ${BUD_TOTAL_QTY} = 0 THEN 1
              WHEN ${TOTAL_QTY} = 0 AND ${BUD_TOTAL_QTY} > 0 THEN -1
              WHEN (${TOTAL_QTY} /  NULLIF (${BUD_TOTAL_QTY},0))-1=-1 THEN 0 ELSE (${TOTAL_QTY} /  NULLIF (${BUD_TOTAL_QTY},0))-1
             END *100 ;;
    value_format: "0.00\%"

    drill_fields: [ Client,TOTAL_QTY,BUD_TOTAL_QTY,VS_BUD_QTY_T]

    #IF( [#TOTAL QTY] >0 and([#BUD TOTAL QTY]) = 0 ,1  ,
    #IF([#TOTAL QTY] = 0and ([#BUD TOTAL QTY]) >0,-1 ,
    #IF(([#TOTAL QTY] /([#BUD TOTAL QTY]))-1 = -1 ,0 ,     ([#TOTAL QTY] /([#BUD TOTAL QTY]))-1)))


  }


  measure: TOTAL_AMOUNT {
    label: "TOTAL AMOUNT"
    type: number
    sql: ${NATIONAL_AMOUNT_MTD} + ${EXPORT_AMOUNT_MTD} ;;
    #[#NATIONAL AMOUNT MTD]+[#EXPORT AMOUNT MTD]

    drill_fields: [ Client,NATIONAL_AMOUNT_MTD,EXPORT_AMOUNT_MTD,TOTAL_AMOUNT]
    value_format: "#,##0.00"
  }


  measure: TOTAL_AMOUNT_YEAR_ANT {
    label: "TOTAL AMOUNT AÑO ANT"
    type: number
    sql: ${NATIONAL_AMOUNT_MTD_YEAR_ANT} + ${Z_BUD_EXPORT_AMOUNT} ;;
    #[#NATIONAL AMOUNT MTD AÑO ANT]+[#EXPORT AMOUNT MTD AÑO ANT]

     drill_fields: [ Client,NATIONAL_AMOUNT_MTD_YEAR_ANT,Z_BUD_EXPORT_AMOUNT,TOTAL_AMOUNT_YEAR_ANT]
    value_format: "#,##0.00"
  }

  measure: VS_YEAR_ANT_VAL_T {
    label: "% VS AÑO ANT VAL"
    type: number
    sql: CASE WHEN ${TOTAL_AMOUNT} > 1 AND ${TOTAL_AMOUNT_YEAR_ANT} = 0 THEN 1
              WHEN ${TOTAL_AMOUNT} = 0 AND ${TOTAL_AMOUNT_YEAR_ANT} > 0 THEN -1
              WHEN (${TOTAL_AMOUNT} /  NULLIF (${TOTAL_AMOUNT_YEAR_ANT},0))=-1 THEN 0 ELSE (${TOTAL_AMOUNT} /  NULLIF (${TOTAL_AMOUNT_YEAR_ANT},0))
             END *100;;
    value_format: "0.00\%"

    drill_fields: [ Client,TOTAL_AMOUNT,TOTAL_AMOUNT_YEAR_ANT,VS_YEAR_ANT_VAL_T]


    #IF( [#TOTAL AMOUNT] >0 and([#TOTAL AMOUNT AÑO ANT]) = 0 ,1  ,
    #IF([#TOTAL AMOUNT] = 0and ([#TOTAL AMOUNT AÑO ANT]) >0,-1 ,
    #IF(([#TOTAL AMOUNT] /([#TOTAL AMOUNT AÑO ANT]))-1 = -1 ,0 ,    ([#TOTAL AMOUNT] /([#TOTAL AMOUNT AÑO ANT]))-1)))



  }


  measure:  BUD_TOTAL_AMOUNT {
    label: "BUD TOTAL AMOUNT"
    type: number
    sql: ${Z_BUD_NATIONAL_AMOUNT} + ${Z_BUD_EXPORT_AMOUNT} ;;

    #[#Z_BUD  NATIONAL AMOUNT]+ [#Z_BUD  EXPORT AMOUNT]

      drill_fields: [ Client,BUD_TOTAL_AMOUNT]
    value_format: "#,##0.00"
  }


  measure: VS_BUD_T {
    label: "% VS BUD T"
    type: number
    sql: CASE WHEN ${TOTAL_AMOUNT} > 0 AND ${BUD_TOTAL_AMOUNT} = 0 THEN 1
              WHEN ${TOTAL_AMOUNT} = 0 AND ${BUD_TOTAL_AMOUNT} > 0 THEN -1
              WHEN (${TOTAL_AMOUNT} /  NULLIF (${BUD_TOTAL_AMOUNT},0))-1=-1 THEN 0 ELSE (${TOTAL_AMOUNT} /  NULLIF (${BUD_TOTAL_AMOUNT},0))-1
             END * 100;;
    value_format: "0.00\%"

    drill_fields: [ Client,TOTAL_AMOUNT,BUD_TOTAL_AMOUNT,VS_BUD_T]

    #IF( [#TOTAL AMOUNT] >0 and([#BUD TOTAL AMOUNT]) = 0 ,1  ,
    #IF([#TOTAL AMOUNT] = 0and ([#BUD TOTAL AMOUNT]) >0,-1 ,
    #IF(([#TOTAL AMOUNT] /([#BUD TOTAL AMOUNT]))-1 = -1 ,0 ,    ([#TOTAL AMOUNT] /([#BUD TOTAL AMOUNT]))-1)))




  }



  measure: NATIONAL_AMOUNT_MTD_YEAR_ANT_YEAR{
    label: "NATIONAL AMOUNT MTD AÑO ANT"

    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "000"]
       drill_fields: [ Client,NATIONAL_AMOUNT_MTD_YEAR_ANT_YEAR]
    value_format: "#,##0.00"
  }



  measure: EXPORT_AMOUNT_MTD_YEAR_ANT_YEAR {
    label: "EXPORT AMOUNT MTD AÑO ANT"

    type: sum
    sql: ${znetval}/1000 ;;
    filters: [distr_chan: "20"]
    filters: [version: "000"]
    filters: {
       field: is_previous_period
      value: "yes"
    }
     drill_fields: [ Client,EXPORT_AMOUNT_MTD_YEAR_ANT_YEAR]
    value_format: "#,##0.00"
  }



  measure:  TOTAL_AMOUNT_YEAR_ANT_YEAR {
    label: "TOTAL AMOUNT AÑO ANT"
    type: number
    sql: ${NATIONAL_AMOUNT_MTD_YEAR_ANT_YEAR} + ${EXPORT_AMOUNT_MTD_YEAR_ANT_YEAR} ;;

    #[#Z_BUD  NATIONAL AMOUNT]+ [#Z_BUD  EXPORT AMOUNT]

     drill_fields: [ Client,NATIONAL_AMOUNT_MTD_YEAR_ANT_YEAR,EXPORT_AMOUNT_MTD_YEAR_ANT_YEAR,TOTAL_AMOUNT_YEAR_ANT_YEAR]
    value_format: "#,##0.00"
  }



  measure: z_BUD_NATIONAL_AMOUNT{
    label: "z BUD NATIONAL AMOUNT"


    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "10"]
    filters: [version: "A00"]


    drill_fields: [ Client,z_BUD_NATIONAL_AMOUNT]
    value_format: "#,##0.00"
  }



  measure: z_BUD_EXPORT_AMOUNT {
    label: "z BUD EXPORT AMOUNT"



    type: sum
    sql: ${znetval}/1000 ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [distr_chan: "20"]
    filters: [version: "A00"]



     drill_fields: [ Client,z_BUD_EXPORT_AMOUNT]
    value_format: "#,##0.00"
  }



  measure:  BUD_TOTAL_AMOUNT_YEAR{
    label: "BUD TOTAL AMOUNT"
    type: number
    sql: ${z_BUD_NATIONAL_AMOUNT} + ${z_BUD_EXPORT_AMOUNT} ;;

    #[#Z_BUD  NATIONAL AMOUNT]+ [#Z_BUD  EXPORT AMOUNT]

   drill_fields: [ Client,BUD_TOTAL_AMOUNT_YEAR]
    value_format: "#,##0.00"
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
      Client,
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
