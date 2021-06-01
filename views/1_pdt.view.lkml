explore: 1_pdt {}

view: 1_pdt {
  derived_table: {
    sql:
    SELECT Clients_Countries, Clients_Site_Label, Clients_Client_Name,Measures_Conversion_Revenue FROM
(SELECT 'CAN' AS Clients_Countries,'Nespresso Canada (20978)' AS Clients_Site_Label,'Nespresso Canada' AS Clients_Client_Name,'54825.328026' AS Measures_Conversion_Revenue
UNION ALL
SELECT 'ESP','Nespresso Spain (20962)','Nespresso Spain','41517.97440419'
UNION ALL
SELECT 'ITA','Nespresso Italy (20998)','Nespresso Italy','40777.72183225'
UNION ALL
SELECT 'GBR','Nespresso UK (20969)','Nespresso UK','35994.09'
UNION ALL
SELECT 'CHE','Nespresso Switzerland (20968)','Nespresso Switzerland','14390.8831858'
UNION ALL
SELECT 'PRT','Nespresso Portugal (20963)','Nespresso Portugal','11267.483346500001'
UNION ALL
SELECT 'AUT','Nespresso Austria (20965)','Nespresso Austria','10279.7994919'
UNION ALL
SELECT 'BEL','Nespresso Belgium (20997)','Nespresso Belgium','9140.9417355'
UNION ALL
SELECT 'IRL','Nespresso Ireland (20979)','Nespresso Ireland','7611.0857791'
UNION ALL
SELECT 'HUN','Nespresso Hungary (20993)','Nespresso Hungary','5559.267252'
UNION ALL
SELECT 'JPN','Nespresso Japan (20984)','Nespresso Japan','2696.370487'
UNION ALL
SELECT 'KOR','Nespresso Korea (21022)','Nespresso Korea','2265.0126'
UNION ALL
SELECT 'ROU','Nespresso Romania (20983)','Nespresso Romania','1798.464954'
UNION ALL
SELECT 'LUX','Nespresso Luxembourg (20996)','Nespresso Luxembourg','1559.5829115400002'
UNION ALL
SELECT 'THA','Nespresso Thailand (21008)','Nespresso Thailand','1401.40194'
UNION ALL
SELECT 'SWE','Nespresso Sweden (21043)','Nespresso Sweden','1014.3391232'
UNION ALL
SELECT 'CHL','Nespresso Chile (21040)','Nespresso Chile','762.13479'
UNION ALL
SELECT 'HKG','Nespresso Hong Kong (20964)','Nespresso Hong Kong','660.180483'
UNION ALL
SELECT 'BRA','Nespresso Brazil (21007)','Nespresso Brazil','555.0529280000001'
UNION ALL
SELECT 'SGP','Nespresso Singapore (20980)','Nespresso Singapore','439.8578175'
UNION ALL
SELECT 'NOR','Nespresso Norway (21045)','Nespresso Norway','386.6820184'
UNION ALL
SELECT 'MYS','Nespresso Malaysia (20967)','Nespresso Malaysia','206.260897'
UNION ALL
SELECT 'FIN','Nespresso Finland (21042)','Nespresso Finland','25.767512099999998'
UNION ALL
SELECT 'DNK','Nespresso Denmark (21044)','Nespresso Denmark','24.4936035') AS myTable


    ;;
  }

  dimension: Clients_Countries {
    map_layer_name: countries
    html:
    {% if value == 'CAN' %}
    <div style="color: red; padding-bottom:0px, margin-bottom: 0px; font-size:100%; font-weight:bold; text-align:left">{{ rendered_value }}</div>
    {% elsif value == 'BEL' %}
    <p style="color: red; padding-top:5px; font-size:100%; font-weight:bold; text-align:left">{{ rendered_value }}</p>
    {% elsif value == 'ITA' %}
    <p style="color: BLACK; font-size:100%; border-top-style:solid; border-top-width:1.6px; font-weight:bold; text-align:left">{{ rendered_value }}</p>
    {% elsif value == 'PRT' %}
    <p style="color: purple; padding-top:4px; font-size:100%; border-top-style:solid; border-top-width:1.6px; font-weight:bold; text-align:left">{{ rendered_value }}</p>
    {% elsif value == 'AUT' %}
    <p style="color: BLACK;font-size:100%; border-top-style:solid; border-top-width:1.6px; font-weight:bold; text-align:left">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; margin:0px; padding-top:4px; font-size:100%; text-align:left">{{ rendered_value }}</p>
    {% endif %} ;;
  }

  dimension: test_topojson {
    map_layer_name: test
    sql: ${TABLE}.Clients_Countries ;;
  }


  dimension: Clients_Site_Label {}
  dimension: Clients_Client_Name {}

  measure: Revenue {
    type: number
    sql: ${TABLE}.Measures_Conversion_Revenue ;;
    value_format_name: usd_0
  }

  dimension: countries {
    sql: SUBSTRING(${Clients_Client_Name}, 11, 30) ;;
    map_layer_name: countries
  }
}
