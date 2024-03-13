<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyDrawingTol="1" readOnly="0" maxScale="0" simplifyLocal="1" minScale="100000000" version="3.24.2-Tisler" hasScaleBasedVisibilityFlag="0" simplifyMaxScale="1" labelsEnabled="0" styleCategories="AllStyleCategories" simplifyDrawingHints="1" symbologyReferenceScale="-1" simplifyAlgorithm="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <temporal fixedDuration="0" endExpression="" mode="0" durationUnit="min" enabled="0" durationField="" limitMode="0" endField="" startField="" accumulate="0" startExpression="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="1" symbollevels="0" forceraster="0" type="RuleRenderer" referencescale="-1">
    <rules key="{0c6589bb-68e4-4121-bc58-6bc3b8955f33}">
      <rule symbol="0" label="Straßenbegleitender Radweg" filter="CASE&#xa;    WHEN highway IN ('primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified', 'cycleway', 'trunk', 'trunk_link', 'path')&#xa;    AND (&#xa;        CASE &#xd;&#xa;&#x9;&#x9;&#x9;WHEN segregated NOT IN ('yes') THEN FALSE&#xd;&#xa;&#x9;&#x9;&#x9;WHEN traffic_sign LIKE '%237%' THEN TRUE&#xd;&#xa;&#x9;&#x9;&#x9;--WHEN traffic_sign LIKE '%240%' THEN TRUE&#xd;&#xa;&#x9;&#x9;&#x9;WHEN (traffic_sign LIKE '%241%' AND segregated IN ('no')) THEN FALSE&#xd;&#xa;&#x9;&#x9;&#x9;WHEN traffic_sign LIKE '%241%' THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN &quot;cycleway&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:right&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:left&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:both&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xd;&#xa;&#x9;&#x9;&#x9;--WHEN traffic_sign LIKE '%240%' THEN TRUE&#xa;            WHEN bicycle IN ('use_sidepath') THEN FALSE&#xa;            WHEN 'bicycle_road' = 'yes' THEN FALSE&#xa;            WHEN traffic_sign LIKE '%244.1%' THEN FALSE&#xa;            WHEN (bicycle NOT IN ('designated') OR bicycle IS NULL) THEN FALSE&#xa;&#xa;            ELSE FALSE&#xa;        END&#xa;    ) THEN 'sep'&#xa;    ELSE NULL&#xa;END&#xa;" key="{bccf8c4e-c75a-4060-96d9-cc68ed992419}"/>
      <rule symbol="1" label="Schutzstreifen / Radfahrstreifen" filter="CASE &#xa;    WHEN highway IN ('primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified')&#xa;    AND (&#xa;        CASE &#xa;            WHEN &quot;cycleway&quot; IN ('crossing', 'lane', 'opposite_lane') THEN TRUE&#xa;            WHEN &quot;cycleway:right&quot; IN ('crossing', 'lane', 'opposite_lane') THEN TRUE&#xa;            WHEN &quot;cycleway:left&quot; IN ('crossing', 'lane', 'opposite_lane') THEN TRUE&#xa;            WHEN &quot;cycleway:both&quot; IN ('crossing', 'lane', 'opposite_lane') THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN try(&quot;cycleway:buffer&quot;) IS NOT NULL THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN try(&quot;cycleway:left:buffer&quot;) IS NOT NULL THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN try(&quot;cycleway:right:buffer&quot;) IS NOT NULL THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN try(&quot;cycleway:both:buffer&quot;) IS NOT NULL THEN TRUE&#xa;            ELSE FALSE&#xa;        END&#xa;    ) THEN TRUE&#xa;    ELSE NULL&#xa;END&#xa;" key="{d9272e2b-3dc2-4ae5-b6e4-d3e8c60c80b7}"/>
      <rule symbol="2" label="separater Radweg" filter="CASE &#xa;&#x9;WHEN highway IN ('cycleway') THEN 'rw'&#xa;&#x9;WHEN is_sidepath IN ('yes') THEN FALSE&#xa;    WHEN highway IN ('cycleway', 'path', 'track', 'footway', 'pedestrian') AND&#xa;    (CASE &#xa;&#xa;&#x9;&#x9;WHEN bicycle IN ('no') THEN FALSE&#xa;&#x9;&#x9;WHEN foot IN ('no') THEN 'rw'&#xa;&#x9;&#x9;WHEN (bicycle IS NULL AND foot IS NULL) THEN FALSE&#xa;&#x9;&#x9;WHEN (bicycle = 'yes' AND foot = 'yes') THEN FALSE&#xa;&#x9;&#x9;WHEN (bicycle = 'yes' AND foot IS NULL) THEN FALSE&#xa;&#x9;&#x9;WHEN oneway IN ('yes') THEN 'rw'&#xa;        WHEN (bicycle IN ('designated') AND foot IN ('designated') AND segregated IN ('yes')) THEN 'rw'&#xa;&#x9;&#x9;WHEN (bicycle IN ('designated') AND foot IS NULL) THEN 'rw'&#xa;        WHEN (bicycle IN ('designated') AND foot IN ('designated')) THEN FALSE&#xa;&#x9;&#x9;WHEN (bicycle IS NULL AND foot IN ('designated')) THEN FALSE&#xa;        WHEN (bicycle IN ('yes') AND foot IN ('designated')) THEN FALSE&#xa;&#x9;&#x9;WHEN traffic_sign LIKE ('%1022%') THEN FALSE&#xa;        WHEN traffic_sign LIKE ('%241%') THEN 'rw'&#xa;        WHEN traffic_sign LIKE ('%237%') THEN 'rw'&#xa;&#xa;        WHEN segregated IN ('yes') THEN 'rw'&#xa;        ELSE NULL&#xa;    END) = 'rw'&#xa;    OR highway IN ('service') AND&#xa;    (CASE&#xa;        WHEN (bicycle IS NULL AND foot IS NULL) THEN FALSE&#xa;        ELSE NULL&#xa;    END) = 'rw' &#xa;    THEN 'rw'&#xa;ELSE NULL&#xa;END&#xa;" key="{0630fb4a-8ad4-40f2-bb03-d814b11d6ee2}"/>
      <rule symbol="3" label="Fahrradstraße" filter="CASE &#xa;WHEN try(&quot;cyclestreet&quot;) IN ('yes') OR&#xa;try(&quot;bicycle_road&quot;) IN ('yes')&#xa;OR traffic_sign LIKE ('%244.1%')&#xa;THEN TRUE&#xa;ELSE NULL&#xa;END" key="{ce6deb56-fa9a-413c-b61e-116d191c5126}"/>
      <rule symbol="4" label="Mischverkehr (MIV)" filter="CASE&#xa;    WHEN bicycle IN ('no', 'use_sidepath') THEN FALSE&#xa;&#x9;WHEN bicycle_road = 'yes' THEN FALSE&#xa;    WHEN bicycle IS NULL OR bicycle NOT IN ('no', 'use_sidepath') THEN&#xa;        CASE&#xa;            WHEN highway = 'living_street' THEN TRUE&#xa;            WHEN highway IN ('primary', 'secondary', 'tertiary', 'unclassified', 'residential') THEN&#xa;                CASE&#xa;                    WHEN 'bicycle_road' = 'yes' THEN TRUE&#xa;                    WHEN traffic_sign LIKE '%244.1%' THEN FALSE&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;WHEN &quot;cycleway&quot; IN ('lane', 'crossing', 'separate') THEN FALSE&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;WHEN &quot;cycleway:left&quot; IN ('lane', 'crossing', 'separate') THEN FALSE&#xa;                    WHEN &quot;cycleway:right&quot; IN ('lane', 'crossing', 'separate') THEN FALSE&#xa;                    WHEN &quot;cycleway:both&quot; IN ('lane', 'crossing', 'separate') THEN FALSE&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;WHEN &quot;cycleway&quot; IS NOT NULL AND &quot;cycleway&quot; IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate') THEN TRUE&#xa;                    WHEN &quot;cycleway:left&quot; IS NOT NULL AND &quot;cycleway:left&quot; IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE&#xa;                    WHEN &quot;cycleway:right&quot; IS NOT NULL AND &quot;cycleway:right&quot; IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE&#xa;                    WHEN &quot;cycleway:both&quot; IS NOT NULL AND &quot;cycleway:both&quot; IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;WHEN &quot;cycleway&quot; IS NULL AND &quot;cycleway:left&quot; IS NULL AND &quot;cycleway:right&quot; IS NULL AND &quot;cycleway:both&quot; IS NULL THEN TRUE&#xa;&#xa;&#xa;&#x9;&#x9;&#x9;&#x9;&#x9;&#xa;                    ELSE NULL&#xa;                END&#xa;            ELSE NULL&#xa;        END&#xa;    ELSE NULL&#xa;END&#xa;" key="{41a7e226-5ec8-4bd0-a837-824a79b74c13}"/>
      <rule symbol="5" label="Mischverkehr (MIV) service" filter="CASE&#xa;    WHEN highway IN ('service') THEN 'mv_miv'&#xa;    WHEN highway IN ('primary', 'secondary', 'tertiary', 'unclassified', 'residential') AND&#xa;    (&#xa;        CASE &#xa;            WHEN traffic_sign LIKE ('%244.1%') THEN 'not_mv_miv'&#xa;            WHEN &quot;cycleway&quot; IS NOT NULL AND &quot;cycleway&quot; NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'&#xa;            WHEN &quot;cycleway:left&quot; IS NOT NULL AND &quot;cycleway:left&quot; NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'&#xa;            WHEN &quot;cycleway:right&quot; IS NOT NULL AND &quot;cycleway:right&quot; NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'&#xa;            WHEN &quot;cycleway:both&quot; IS NOT NULL AND &quot;cycleway:both&quot; NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'&#xa;            ELSE 'mv_miv'&#xa;        END&#xa;    ) = 'not_mv_miv' THEN TRUE&#xa;    ELSE FALSE &#xa;END&#xa;" key="{d63ac174-09e2-4ce7-81b9-f17c8d183b78}"/>
      <rule symbol="6" label="Mischverkehr (Fuß/Rad)" filter="CASE&#xa;WHEN &quot;highway&quot; IN ('footway', 'path', 'pedestrian', 'track', 'steps') AND &#xa;    ((bicycle IN ('designated', 'yes') OR foot IN ('designated', 'yes') OR segregated IN ('no')) OR&#xa;    (bicycle IS NULL OR foot IS NULL OR segregated IS NULL) OR&#xd;&#xa;&#x9;&quot;traffic_sign&quot; NOT LIKE '%237%') THEN TRUE&#xa;ELSE NULL&#xa;END" key="{7aff8748-bd5e-4a00-a5f5-6077de1a7baa}"/>
      <rule symbol="7" label="nicht befahrbar" filter="ELSE" key="{c05a94eb-72c6-44b1-9af8-b6acfb31fc8a}"/>
    </rules>
    <symbols>
      <symbol name="0" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="6">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="5;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="7,39,155,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.6"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="0"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="7,39,155,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.6"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="1" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="5">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="2;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="7,39,155,255"/>
            <Option name="line_style" type="QString" value="dash"/>
            <Option name="line_width" type="QString" value="0.6"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="1"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="2;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="7,39,155,255"/>
          <prop k="line_style" v="dash"/>
          <prop k="line_width" v="0.6"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="2" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="3">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="5;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="27,186,24,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.6"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="0"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="27,186,24,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.6"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="3" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="7">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="2;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="27,186,24,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.6"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="1"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="2;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="27,186,24,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.6"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="4" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="2">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="5;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="136,107,136,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.4"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="0"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="136,107,136,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.4"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="5" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="2">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="5;2"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="136,107,136,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.15"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="0"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="136,107,136,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="6" clip_to_extent="1" type="line" alpha="0.8" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="1">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="1"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="1;1"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="124,124,124,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.2"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="1"/>
            <Option name="use_custom_dash" type="QString" value="1"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="1"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="1;1"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="124,124,124,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.2"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="1"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="7" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"/>
            <Option name="capstyle" type="QString" value="square"/>
            <Option name="customdash" type="QString" value="2;1"/>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="customdash_unit" type="QString" value="MM"/>
            <Option name="dash_pattern_offset" type="QString" value="0"/>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
            <Option name="draw_inside_polygon" type="QString" value="0"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="line_color" type="QString" value="255,96,96,255"/>
            <Option name="line_style" type="QString" value="solid"/>
            <Option name="line_width" type="QString" value="0.35"/>
            <Option name="line_width_unit" type="QString" value="MM"/>
            <Option name="offset" type="QString" value="0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="ring_filter" type="QString" value="0"/>
            <Option name="trim_distance_end" type="QString" value="0"/>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_end_unit" type="QString" value="MM"/>
            <Option name="trim_distance_start" type="QString" value="0"/>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="trim_distance_start_unit" type="QString" value="MM"/>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
            <Option name="use_custom_dash" type="QString" value="1"/>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
          </Option>
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="2;1"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="255,96,96,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="trim_distance_end" v="0"/>
          <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_end_unit" v="MM"/>
          <prop k="trim_distance_start" v="0"/>
          <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="trim_distance_start_unit" v="MM"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontWordSpacing="0" fieldName="CASE&#xa;    WHEN highway IN ('primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified', 'cycleway', 'trunk', 'trunk_link', 'path')&#xa;    AND (&#xa;        CASE &#xa;&#x9;&#x9;&#x9;WHEN traffic_sign LIKE '%241%' THEN TRUE&#xa;&#x9;&#x9;&#x9;WHEN &quot;cycleway&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:right&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:left&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN &quot;cycleway:both&quot; IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE&#xa;            WHEN bicycle IN ('use_sidepath') THEN FALSE&#xa;            WHEN 'bicycle_road' = 'yes' THEN FALSE&#xa;            WHEN traffic_sign LIKE '%244.1%' THEN FALSE&#xa;            WHEN segregated NOT IN ('yes') THEN FALSE&#xa;            WHEN (bicycle NOT IN ('designated') OR bicycle IS NULL) THEN FALSE&#xa;&#xa;            ELSE FALSE&#xa;        END&#xa;    ) THEN 'sep'&#xa;    ELSE NULL&#xa;END&#xa;" previewBkgrdColor="255,255,255,255" blendMode="0" fontStrikeout="0" textColor="50,50,50,255" namedStyle="Regular" useSubstitutions="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontFamily="MS Shell Dlg 2" fontSize="10" isExpression="1" fontUnderline="0" legendString="Aa" fontWeight="50" textOpacity="1" fontKerning="1" allowHtml="0" capitalization="0" textOrientation="horizontal" fontItalic="0" multilineHeight="1" fontLetterSpacing="0" fontSizeUnit="Point">
        <families/>
        <text-buffer bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferBlendMode="0" bufferSizeUnits="MM" bufferJoinStyle="128" bufferColor="250,250,250,255" bufferDraw="0" bufferSize="1" bufferNoFill="1" bufferOpacity="1"/>
        <text-mask maskSizeUnits="MM" maskJoinStyle="128" maskType="0" maskedSymbolLayers="" maskEnabled="0" maskOpacity="1" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskSize="0"/>
        <background shapeOffsetUnit="Point" shapeFillColor="255,255,255,255" shapeOpacity="1" shapeBorderWidth="0" shapeRotation="0" shapeSizeX="0" shapeBorderColor="128,128,128,255" shapeType="0" shapeOffsetX="0" shapeSizeY="0" shapeRadiiY="0" shapeSizeUnit="Point" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetY="0" shapeBorderWidthUnit="Point" shapeSVGFile="" shapeJoinStyle="64" shapeSizeType="0" shapeRadiiUnit="Point" shapeRotationType="0" shapeBlendMode="0" shapeDraw="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiX="0">
          <symbol name="markerSymbol" clip_to_extent="1" type="marker" alpha="1" force_rhr="0">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" locked="0" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"/>
                <Option name="cap_style" type="QString" value="square"/>
                <Option name="color" type="QString" value="152,125,183,255"/>
                <Option name="horizontal_anchor_point" type="QString" value="1"/>
                <Option name="joinstyle" type="QString" value="bevel"/>
                <Option name="name" type="QString" value="circle"/>
                <Option name="offset" type="QString" value="0,0"/>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="offset_unit" type="QString" value="MM"/>
                <Option name="outline_color" type="QString" value="35,35,35,255"/>
                <Option name="outline_style" type="QString" value="solid"/>
                <Option name="outline_width" type="QString" value="0"/>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="outline_width_unit" type="QString" value="MM"/>
                <Option name="scale_method" type="QString" value="diameter"/>
                <Option name="size" type="QString" value="2"/>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="size_unit" type="QString" value="MM"/>
                <Option name="vertical_anchor_point" type="QString" value="1"/>
              </Option>
              <prop k="angle" v="0"/>
              <prop k="cap_style" v="square"/>
              <prop k="color" v="152,125,183,255"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="name" v="circle"/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="outline_color" v="35,35,35,255"/>
              <prop k="outline_style" v="solid"/>
              <prop k="outline_width" v="0"/>
              <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="outline_width_unit" v="MM"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="MM"/>
              <prop k="vertical_anchor_point" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties"/>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
          <symbol name="fillSymbol" clip_to_extent="1" type="fill" alpha="1" force_rhr="0">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
            <layer class="SimpleFill" enabled="1" locked="0" pass="0">
              <Option type="Map">
                <Option name="border_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="color" type="QString" value="255,255,255,255"/>
                <Option name="joinstyle" type="QString" value="bevel"/>
                <Option name="offset" type="QString" value="0,0"/>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="offset_unit" type="QString" value="MM"/>
                <Option name="outline_color" type="QString" value="128,128,128,255"/>
                <Option name="outline_style" type="QString" value="no"/>
                <Option name="outline_width" type="QString" value="0"/>
                <Option name="outline_width_unit" type="QString" value="Point"/>
                <Option name="style" type="QString" value="solid"/>
              </Option>
              <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="color" v="255,255,255,255"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="outline_color" v="128,128,128,255"/>
              <prop k="outline_style" v="no"/>
              <prop k="outline_width" v="0"/>
              <prop k="outline_width_unit" v="Point"/>
              <prop k="style" v="solid"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties"/>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOffsetAngle="135" shadowOffsetGlobal="1" shadowColor="0,0,0,255" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetDist="1" shadowScale="100" shadowDraw="0" shadowRadiusUnit="MM" shadowUnder="0" shadowRadius="1.5" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowBlendMode="6" shadowRadiusAlphaOnly="0" shadowOffsetUnit="MM" shadowOpacity="0.69999999999999996"/>
        <dd_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format wrapChar="" plussign="0" reverseDirectionSymbol="0" placeDirectionSymbol="0" addDirectionSymbol="0" multilineAlign="0" autoWrapLength="0" decimals="3" formatNumbers="0" useMaxLineLengthForAutoWrap="1" leftDirectionSymbol="&lt;" rightDirectionSymbol=">"/>
      <placement fitInPolygonOnly="0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" repeatDistance="0" centroidWhole="0" quadOffset="4" overrunDistance="0" lineAnchorType="0" yOffset="0" repeatDistanceUnits="MM" lineAnchorClipping="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" xOffset="0" rotationUnit="AngleDegrees" overrunDistanceUnit="MM" maxCurvedCharAngleOut="-25" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" distMapUnitScale="3x:0,0,0,0,0,0" layerType="LineGeometry" geometryGeneratorEnabled="0" placement="2" priority="5" centroidInside="0" offsetType="0" preserveRotation="1" placementFlags="10" offsetUnits="MM" geometryGenerator="" polygonPlacementFlags="2" distUnits="MM" lineAnchorPercent="0.5" rotationAngle="0" maxCurvedCharAngleIn="25" geometryGeneratorType="PointGeometry" dist="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR"/>
      <rendering unplacedVisibility="0" obstacleType="1" zIndex="0" drawLabels="1" fontMaxPixelSize="10000" fontLimitPixelSize="0" limitNumLabels="0" displayAll="0" obstacleFactor="1" minFeatureSize="0" labelPerPart="0" scaleMin="0" scaleVisibility="0" fontMinPixelSize="3" maxNumLabels="2000" scaleMax="0" mergeLines="0" obstacle="1" upsidedownLabels="0"/>
      <dd_properties>
        <Option type="Map">
          <Option name="name" type="QString" value=""/>
          <Option name="properties"/>
          <Option name="type" type="QString" value="collection"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option name="anchorPoint" type="QString" value="pole_of_inaccessibility"/>
          <Option name="blendMode" type="int" value="0"/>
          <Option name="ddProperties" type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
          <Option name="drawToAllParts" type="bool" value="false"/>
          <Option name="enabled" type="QString" value="0"/>
          <Option name="labelAnchorPoint" type="QString" value="point_on_exterior"/>
          <Option name="lineSymbol" type="QString" value="&lt;symbol name=&quot;symbol&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; alpha=&quot;1&quot; force_rhr=&quot;0&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; type=&quot;QString&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; type=&quot;QString&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer class=&quot;SimpleLine&quot; enabled=&quot;1&quot; locked=&quot;0&quot; pass=&quot;0&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;align_dash_pattern&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;capstyle&quot; type=&quot;QString&quot; value=&quot;square&quot;/>&lt;Option name=&quot;customdash&quot; type=&quot;QString&quot; value=&quot;5;2&quot;/>&lt;Option name=&quot;customdash_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;customdash_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;dash_pattern_offset&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;dash_pattern_offset_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;dash_pattern_offset_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;draw_inside_polygon&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;joinstyle&quot; type=&quot;QString&quot; value=&quot;bevel&quot;/>&lt;Option name=&quot;line_color&quot; type=&quot;QString&quot; value=&quot;60,60,60,255&quot;/>&lt;Option name=&quot;line_style&quot; type=&quot;QString&quot; value=&quot;solid&quot;/>&lt;Option name=&quot;line_width&quot; type=&quot;QString&quot; value=&quot;0.3&quot;/>&lt;Option name=&quot;line_width_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;offset&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;offset_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;offset_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;ring_filter&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_end&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_end_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;trim_distance_end_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;trim_distance_start&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_start_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;trim_distance_start_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;tweak_dash_pattern_on_corners&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;use_custom_dash&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;width_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;/Option>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;trim_distance_end&quot; v=&quot;0&quot;/>&lt;prop k=&quot;trim_distance_end_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;trim_distance_end_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;trim_distance_start&quot; v=&quot;0&quot;/>&lt;prop k=&quot;trim_distance_start_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;trim_distance_start_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; type=&quot;QString&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; type=&quot;QString&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
          <Option name="minLength" type="double" value="0"/>
          <Option name="minLengthMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
          <Option name="minLengthUnit" type="QString" value="MM"/>
          <Option name="offsetFromAnchor" type="double" value="0"/>
          <Option name="offsetFromAnchorMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
          <Option name="offsetFromAnchorUnit" type="QString" value="MM"/>
          <Option name="offsetFromLabel" type="double" value="0"/>
          <Option name="offsetFromLabelMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
          <Option name="offsetFromLabelUnit" type="QString" value="MM"/>
        </Option>
      </callout>
    </settings>
  </labeling>
  <customproperties>
    <Option type="Map">
      <Option name="dualview/previewExpressions" type="List">
        <Option type="QString" value="&quot;old_name&quot;"/>
      </Option>
      <Option name="embeddedWidgets/count" type="int" value="0"/>
      <Option name="variableNames"/>
      <Option name="variableValues"/>
    </Option>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory spacing="5" scaleDependency="Area" opacity="1" height="15" barWidth="5" spacingUnit="MM" backgroundAlpha="255" labelPlacementMethod="XHeight" scaleBasedVisibility="0" rotationOffset="270" maxScaleDenominator="1e+08" penColor="#000000" lineSizeScale="3x:0,0,0,0,0,0" enabled="0" direction="0" penAlpha="255" width="15" lineSizeType="MM" sizeType="MM" diagramOrientation="Up" minimumSize="0" minScaleDenominator="0" backgroundColor="#ffffff" showAxis="1" sizeScale="3x:0,0,0,0,0,0" spacingUnitScale="3x:0,0,0,0,0,0" penWidth="0">
      <fontProperties style="" description="Cantarell,11,-1,5,50,0,0,0,0,0"/>
      <attribute field="" color="#000000" label=""/>
      <axisSymbol>
        <symbol name="" clip_to_extent="1" type="line" alpha="1" force_rhr="0">
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <layer class="SimpleLine" enabled="1" locked="0" pass="0">
            <Option type="Map">
              <Option name="align_dash_pattern" type="QString" value="0"/>
              <Option name="capstyle" type="QString" value="square"/>
              <Option name="customdash" type="QString" value="5;2"/>
              <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="customdash_unit" type="QString" value="MM"/>
              <Option name="dash_pattern_offset" type="QString" value="0"/>
              <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
              <Option name="draw_inside_polygon" type="QString" value="0"/>
              <Option name="joinstyle" type="QString" value="bevel"/>
              <Option name="line_color" type="QString" value="35,35,35,255"/>
              <Option name="line_style" type="QString" value="solid"/>
              <Option name="line_width" type="QString" value="0.26"/>
              <Option name="line_width_unit" type="QString" value="MM"/>
              <Option name="offset" type="QString" value="0"/>
              <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="offset_unit" type="QString" value="MM"/>
              <Option name="ring_filter" type="QString" value="0"/>
              <Option name="trim_distance_end" type="QString" value="0"/>
              <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="trim_distance_end_unit" type="QString" value="MM"/>
              <Option name="trim_distance_start" type="QString" value="0"/>
              <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="trim_distance_start_unit" type="QString" value="MM"/>
              <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
              <Option name="use_custom_dash" type="QString" value="0"/>
              <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            </Option>
            <prop k="align_dash_pattern" v="0"/>
            <prop k="capstyle" v="square"/>
            <prop k="customdash" v="5;2"/>
            <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="customdash_unit" v="MM"/>
            <prop k="dash_pattern_offset" v="0"/>
            <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="dash_pattern_offset_unit" v="MM"/>
            <prop k="draw_inside_polygon" v="0"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="line_color" v="35,35,35,255"/>
            <prop k="line_style" v="solid"/>
            <prop k="line_width" v="0.26"/>
            <prop k="line_width_unit" v="MM"/>
            <prop k="offset" v="0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="ring_filter" v="0"/>
            <prop k="trim_distance_end" v="0"/>
            <prop k="trim_distance_end_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="trim_distance_end_unit" v="MM"/>
            <prop k="trim_distance_start" v="0"/>
            <prop k="trim_distance_start_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="trim_distance_start_unit" v="MM"/>
            <prop k="tweak_dash_pattern_on_corners" v="0"/>
            <prop k="use_custom_dash" v="0"/>
            <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings obstacle="0" placement="2" priority="0" linePlacementFlags="18" zIndex="0" dist="0" showAll="1">
    <properties>
      <Option type="Map">
        <Option name="name" type="QString" value=""/>
        <Option name="properties"/>
        <Option name="type" type="QString" value="collection"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
    <activeChecks/>
    <checkConfiguration/>
  </geometryOptions>
  <legend type="default-vector" showLabelLegend="0"/>
  <referencedLayers/>
  <fieldConfiguration>
    <field name="fid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="_uid_" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="osm_id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="highway" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="bicycle" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="foot" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="oneway" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="surface" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="smoothness" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="traffic_sign" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="cycleway" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="cycleway:right" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="cycleway:left" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="cycleway:both" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="segregated" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="cyclestreet" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="bicycle_road" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="is_sidepath" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="maxspeed" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="fid" index="0" name=""/>
    <alias field="_uid_" index="1" name=""/>
    <alias field="osm_id" index="2" name=""/>
    <alias field="highway" index="3" name=""/>
    <alias field="bicycle" index="4" name=""/>
    <alias field="foot" index="5" name=""/>
    <alias field="oneway" index="6" name=""/>
    <alias field="surface" index="7" name=""/>
    <alias field="smoothness" index="8" name=""/>
    <alias field="traffic_sign" index="9" name=""/>
    <alias field="cycleway" index="10" name=""/>
    <alias field="cycleway:right" index="11" name=""/>
    <alias field="cycleway:left" index="12" name=""/>
    <alias field="cycleway:both" index="13" name=""/>
    <alias field="segregated" index="14" name=""/>
    <alias field="cyclestreet" index="15" name=""/>
    <alias field="bicycle_road" index="16" name=""/>
    <alias field="is_sidepath" index="17" name=""/>
    <alias field="maxspeed" index="18" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="fid" applyOnUpdate="0"/>
    <default expression="" field="_uid_" applyOnUpdate="0"/>
    <default expression="" field="osm_id" applyOnUpdate="0"/>
    <default expression="" field="highway" applyOnUpdate="0"/>
    <default expression="" field="bicycle" applyOnUpdate="0"/>
    <default expression="" field="foot" applyOnUpdate="0"/>
    <default expression="" field="oneway" applyOnUpdate="0"/>
    <default expression="" field="surface" applyOnUpdate="0"/>
    <default expression="" field="smoothness" applyOnUpdate="0"/>
    <default expression="" field="traffic_sign" applyOnUpdate="0"/>
    <default expression="" field="cycleway" applyOnUpdate="0"/>
    <default expression="" field="cycleway:right" applyOnUpdate="0"/>
    <default expression="" field="cycleway:left" applyOnUpdate="0"/>
    <default expression="" field="cycleway:both" applyOnUpdate="0"/>
    <default expression="" field="segregated" applyOnUpdate="0"/>
    <default expression="" field="cyclestreet" applyOnUpdate="0"/>
    <default expression="" field="bicycle_road" applyOnUpdate="0"/>
    <default expression="" field="is_sidepath" applyOnUpdate="0"/>
    <default expression="" field="maxspeed" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="fid" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="_uid_" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="osm_id" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="highway" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="bicycle" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="foot" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="oneway" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="surface" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="smoothness" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="traffic_sign" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="cycleway" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="cycleway:right" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="cycleway:left" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="cycleway:both" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="segregated" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="cyclestreet" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="bicycle_road" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="is_sidepath" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="maxspeed" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="_uid_" exp=""/>
    <constraint desc="" field="osm_id" exp=""/>
    <constraint desc="" field="highway" exp=""/>
    <constraint desc="" field="bicycle" exp=""/>
    <constraint desc="" field="foot" exp=""/>
    <constraint desc="" field="oneway" exp=""/>
    <constraint desc="" field="surface" exp=""/>
    <constraint desc="" field="smoothness" exp=""/>
    <constraint desc="" field="traffic_sign" exp=""/>
    <constraint desc="" field="cycleway" exp=""/>
    <constraint desc="" field="cycleway:right" exp=""/>
    <constraint desc="" field="cycleway:left" exp=""/>
    <constraint desc="" field="cycleway:both" exp=""/>
    <constraint desc="" field="segregated" exp=""/>
    <constraint desc="" field="cyclestreet" exp=""/>
    <constraint desc="" field="bicycle_road" exp=""/>
    <constraint desc="" field="is_sidepath" exp=""/>
    <constraint desc="" field="maxspeed" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig sortOrder="1" actionWidgetStyle="dropDown" sortExpression="&quot;is_sidepath&quot;">
    <columns>
      <column hidden="0" name="osm_id" width="-1" type="field"/>
      <column hidden="0" name="highway" width="-1" type="field"/>
      <column hidden="0" name="cycleway" width="-1" type="field"/>
      <column hidden="0" name="traffic_sign" width="-1" type="field"/>
      <column hidden="0" name="cycleway:left" width="-1" type="field"/>
      <column hidden="0" name="bicycle" width="-1" type="field"/>
      <column hidden="0" name="cycleway:both" width="-1" type="field"/>
      <column hidden="0" name="smoothness" width="-1" type="field"/>
      <column hidden="0" name="foot" width="-1" type="field"/>
      <column hidden="0" name="cycleway:right" width="-1" type="field"/>
      <column hidden="0" name="surface" width="-1" type="field"/>
      <column hidden="0" name="oneway" width="-1" type="field"/>
      <column hidden="0" name="maxspeed" width="-1" type="field"/>
      <column hidden="0" name="_uid_" width="-1" type="field"/>
      <column hidden="0" name="cyclestreet" width="-1" type="field"/>
      <column hidden="0" name="bicycle_road" width="-1" type="field"/>
      <column hidden="0" name="is_sidepath" width="-1" type="field"/>
      <column hidden="0" name="segregated" width="-1" type="field"/>
      <column hidden="0" name="fid" width="-1" type="field"/>
      <column hidden="1" width="-1" type="actions"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
    geom = feature.geometry()
    control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="FIXME" editable="1"/>
    <field name="FIXME:de" editable="1"/>
    <field name="TMC:cid_58:tabcd_1:Class" editable="1"/>
    <field name="TMC:cid_58:tabcd_1:LCLversion" editable="1"/>
    <field name="TMC:cid_58:tabcd_1:LocationCode" editable="1"/>
    <field name="TMC:cid_58:tabcd_1:NextLocationCode" editable="1"/>
    <field name="TMC:cid_58:tabcd_1:PrevLocationCode" editable="1"/>
    <field name="TODO" editable="1"/>
    <field name="_uid_" editable="1"/>
    <field name="abandoned" editable="1"/>
    <field name="abandoned:railway" editable="1"/>
    <field name="access" editable="1"/>
    <field name="access:N3" editable="1"/>
    <field name="access:backward" editable="1"/>
    <field name="access:both_ways" editable="1"/>
    <field name="access:conditional" editable="1"/>
    <field name="access:lanes" editable="1"/>
    <field name="access:lanes:backward" editable="1"/>
    <field name="access:lanes:forward" editable="1"/>
    <field name="access:lanes:note" editable="1"/>
    <field name="access_ramp" editable="1"/>
    <field name="aerialway" editable="1"/>
    <field name="agricultural" editable="1"/>
    <field name="alt_name" editable="1"/>
    <field name="ambulance" editable="1"/>
    <field name="amenity" editable="1"/>
    <field name="arcade:left" editable="1"/>
    <field name="arcade:right" editable="1"/>
    <field name="area" editable="1"/>
    <field name="ascent" editable="1"/>
    <field name="barrier" editable="1"/>
    <field name="bdouble" editable="1"/>
    <field name="bench" editable="1"/>
    <field name="bicycle" editable="1"/>
    <field name="bicycle:backward" editable="1"/>
    <field name="bicycle:conditional" editable="1"/>
    <field name="bicycle:forward" editable="1"/>
    <field name="bicycle:lanes" editable="1"/>
    <field name="bicycle:lanes:backward" editable="1"/>
    <field name="bicycle:lanes:forward" editable="1"/>
    <field name="bicycle:left" editable="1"/>
    <field name="bicycle:note" editable="1"/>
    <field name="bicycle:oneway" editable="1"/>
    <field name="bicycle:right" editable="1"/>
    <field name="bicycle_parking" editable="1"/>
    <field name="bicycle_road" editable="1"/>
    <field name="bin" editable="1"/>
    <field name="brand" editable="1"/>
    <field name="bridge" editable="1"/>
    <field name="bridge:material" editable="1"/>
    <field name="bridge:name" editable="1"/>
    <field name="bridge:ref" editable="1"/>
    <field name="bridge:structure" editable="1"/>
    <field name="building:material" editable="1"/>
    <field name="bus" editable="1"/>
    <field name="bus:lanes" editable="1"/>
    <field name="bus:lanes:backward" editable="1"/>
    <field name="bus:lanes:forward" editable="1"/>
    <field name="bus_bay" editable="1"/>
    <field name="bus_bay:left" editable="1"/>
    <field name="busway" editable="1"/>
    <field name="busway:left" editable="1"/>
    <field name="busway:right" editable="1"/>
    <field name="button_operated" editable="1"/>
    <field name="capacity:police" editable="1"/>
    <field name="caravan" editable="1"/>
    <field name="carriage" editable="1"/>
    <field name="category" editable="1"/>
    <field name="change:backward" editable="1"/>
    <field name="change:both_ways" editable="1"/>
    <field name="change:forward" editable="1"/>
    <field name="change:lanes" editable="1"/>
    <field name="change:lanes:backward" editable="1"/>
    <field name="change:lanes:forward" editable="1"/>
    <field name="check_date" editable="1"/>
    <field name="check_date:bench" editable="1"/>
    <field name="check_date:bicycle" editable="1"/>
    <field name="check_date:cycleway" editable="1"/>
    <field name="check_date:cycleway:surface" editable="1"/>
    <field name="check_date:handrail" editable="1"/>
    <field name="check_date:lit" editable="1"/>
    <field name="check_date:ramp" editable="1"/>
    <field name="check_date:segregated" editable="1"/>
    <field name="check_date:shelter" editable="1"/>
    <field name="check_date:sidewalk" editable="1"/>
    <field name="check_date:sidewalk:surface" editable="1"/>
    <field name="check_date:smoothness" editable="1"/>
    <field name="check_date:surface" editable="1"/>
    <field name="check_date:tactile_paving" editable="1"/>
    <field name="check_date:tracktype" editable="1"/>
    <field name="checked_date" editable="1"/>
    <field name="class:bicycle" editable="1"/>
    <field name="class:bicycle:roadcycling" editable="1"/>
    <field name="colonnade:left" editable="1"/>
    <field name="colonnade:right" editable="1"/>
    <field name="comment" editable="1"/>
    <field name="comment:history" editable="1"/>
    <field name="construction" editable="1"/>
    <field name="construction:highway" editable="1"/>
    <field name="contrastive_stripes" editable="1"/>
    <field name="contrastive_stripes:all" editable="1"/>
    <field name="contrastive_stripes:end" editable="1"/>
    <field name="contrastive_stripes:start" editable="1"/>
    <field name="conveying" editable="1"/>
    <field name="count" editable="1"/>
    <field name="covered" editable="1"/>
    <field name="crossing" editable="1"/>
    <field name="crossing:island" editable="1"/>
    <field name="crossing:markings" editable="1"/>
    <field name="cutting" editable="1"/>
    <field name="cyclestreet" editable="1"/>
    <field name="cycleway" editable="1"/>
    <field name="cycleway:backward" editable="1"/>
    <field name="cycleway:bicycle" editable="1"/>
    <field name="cycleway:both" editable="1"/>
    <field name="cycleway:both:bicycle" editable="1"/>
    <field name="cycleway:both:lane" editable="1"/>
    <field name="cycleway:both:segregated" editable="1"/>
    <field name="cycleway:both:traffic_sign" editable="1"/>
    <field name="cycleway:both:width" editable="1"/>
    <field name="cycleway:foot" editable="1"/>
    <field name="cycleway:forward" editable="1"/>
    <field name="cycleway:lane" editable="1"/>
    <field name="cycleway:lanes" editable="1"/>
    <field name="cycleway:left" editable="1"/>
    <field name="cycleway:left:bicycle" editable="1"/>
    <field name="cycleway:left:foot" editable="1"/>
    <field name="cycleway:left:lane" editable="1"/>
    <field name="cycleway:left:oneway" editable="1"/>
    <field name="cycleway:left:oneway:bicycle" editable="1"/>
    <field name="cycleway:left:segregated" editable="1"/>
    <field name="cycleway:left:smoothness" editable="1"/>
    <field name="cycleway:left:surface" editable="1"/>
    <field name="cycleway:left:surface:colour" editable="1"/>
    <field name="cycleway:left:traffic_sign" editable="1"/>
    <field name="cycleway:oneway" editable="1"/>
    <field name="cycleway:right" editable="1"/>
    <field name="cycleway:right:bicycle" editable="1"/>
    <field name="cycleway:right:foot" editable="1"/>
    <field name="cycleway:right:lane" editable="1"/>
    <field name="cycleway:right:oneway" editable="1"/>
    <field name="cycleway:right:protection:left" editable="1"/>
    <field name="cycleway:right:segregated" editable="1"/>
    <field name="cycleway:right:smoothness" editable="1"/>
    <field name="cycleway:right:surface" editable="1"/>
    <field name="cycleway:right:surface:colour" editable="1"/>
    <field name="cycleway:right:traffic_sign" editable="1"/>
    <field name="cycleway:right:width" editable="1"/>
    <field name="cycleway:segregated" editable="1"/>
    <field name="cycleway:smoothness" editable="1"/>
    <field name="cycleway:surface" editable="1"/>
    <field name="cycleway:surface:colour" editable="1"/>
    <field name="cycleway:traffic_sign" editable="1"/>
    <field name="cycleway:width" editable="1"/>
    <field name="delivery" editable="1"/>
    <field name="demolished:highway" editable="1"/>
    <field name="departures_board" editable="1"/>
    <field name="description" editable="1"/>
    <field name="description:de" editable="1"/>
    <field name="description:en" editable="1"/>
    <field name="designated" editable="1"/>
    <field name="designation" editable="1"/>
    <field name="destination" editable="1"/>
    <field name="destination:arrow" editable="1"/>
    <field name="destination:arrow:backward" editable="1"/>
    <field name="destination:arrow:lanes" editable="1"/>
    <field name="destination:arrow:lanes:backward" editable="1"/>
    <field name="destination:arrow:lanes:forward" editable="1"/>
    <field name="destination:arrow:to:lanes" editable="1"/>
    <field name="destination:arrow:to:lanes:backward" editable="1"/>
    <field name="destination:arrow:to:lanes:forward" editable="1"/>
    <field name="destination:backward" editable="1"/>
    <field name="destination:bicycle" editable="1"/>
    <field name="destination:bicycle:backward" editable="1"/>
    <field name="destination:bicycle:forward" editable="1"/>
    <field name="destination:colour" editable="1"/>
    <field name="destination:colour:backward" editable="1"/>
    <field name="destination:colour:forward" editable="1"/>
    <field name="destination:colour:lanes" editable="1"/>
    <field name="destination:colour:lanes:backward" editable="1"/>
    <field name="destination:colour:lanes:forward" editable="1"/>
    <field name="destination:colour:to" editable="1"/>
    <field name="destination:colour:to:forward" editable="1"/>
    <field name="destination:country" editable="1"/>
    <field name="destination:country:lanes" editable="1"/>
    <field name="destination:distance:lanes:backward" editable="1"/>
    <field name="destination:forward" editable="1"/>
    <field name="destination:lanes" editable="1"/>
    <field name="destination:lanes:backward" editable="1"/>
    <field name="destination:lanes:forward" editable="1"/>
    <field name="destination:ref" editable="1"/>
    <field name="destination:ref:backward" editable="1"/>
    <field name="destination:ref:forward" editable="1"/>
    <field name="destination:ref:lanes" editable="1"/>
    <field name="destination:ref:lanes:backward" editable="1"/>
    <field name="destination:ref:lanes:forward" editable="1"/>
    <field name="destination:ref:to" editable="1"/>
    <field name="destination:ref:to:backward" editable="1"/>
    <field name="destination:ref:to:forward" editable="1"/>
    <field name="destination:ref:to:lanes" editable="1"/>
    <field name="destination:ref:to:lanes:backward" editable="1"/>
    <field name="destination:ref:to:lanes:forward" editable="1"/>
    <field name="destination:street" editable="1"/>
    <field name="destination:street:backward" editable="1"/>
    <field name="destination:street:forward" editable="1"/>
    <field name="destination:street:lanes" editable="1"/>
    <field name="destination:symbol" editable="1"/>
    <field name="destination:symbol:backward" editable="1"/>
    <field name="destination:symbol:forward" editable="1"/>
    <field name="destination:symbol:lanes" editable="1"/>
    <field name="destination:symbol:lanes:backward" editable="1"/>
    <field name="destination:symbol:lanes:forward" editable="1"/>
    <field name="destination:symbol:to" editable="1"/>
    <field name="destination:symbol:to:backward" editable="1"/>
    <field name="destination:symbol:to:forward" editable="1"/>
    <field name="destination:symbol:to:lanes" editable="1"/>
    <field name="destination:symbol:to:lanes:backward" editable="1"/>
    <field name="destination:symbol:to:lanes:forward" editable="1"/>
    <field name="destination:to" editable="1"/>
    <field name="destination:to:backward" editable="1"/>
    <field name="destination:to:forward" editable="1"/>
    <field name="destination:to:lanes" editable="1"/>
    <field name="destination:to:lanes:backward" editable="1"/>
    <field name="destination:to:lanes:forward" editable="1"/>
    <field name="direction" editable="1"/>
    <field name="direction:backward" editable="1"/>
    <field name="direction:forward" editable="1"/>
    <field name="dirtbike:scale" editable="1"/>
    <field name="disabled" editable="1"/>
    <field name="disused:highway" editable="1"/>
    <field name="disused:railway" editable="1"/>
    <field name="dog" editable="1"/>
    <field name="dual_carriageway" editable="1"/>
    <field name="ele" editable="1"/>
    <field name="electrified" editable="1"/>
    <field name="embankment" editable="1"/>
    <field name="embedded_rails" editable="1"/>
    <field name="embedded_rails:forward" editable="1"/>
    <field name="emergency" editable="1"/>
    <field name="end_date" editable="1"/>
    <field name="est_length" editable="1"/>
    <field name="est_width" editable="1"/>
    <field name="fake_gaslight" editable="1"/>
    <field name="fee" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="flat_steps" editable="1"/>
    <field name="floating" editable="1"/>
    <field name="flood_prone" editable="1"/>
    <field name="foot" editable="1"/>
    <field name="foot:backward" editable="1"/>
    <field name="foot:conditional" editable="1"/>
    <field name="foot:forward" editable="1"/>
    <field name="foot:left" editable="1"/>
    <field name="foot:right" editable="1"/>
    <field name="footway" editable="1"/>
    <field name="footway:right" editable="1"/>
    <field name="footway:right:smoothness" editable="1"/>
    <field name="footway:right:surface" editable="1"/>
    <field name="footway:surface" editable="1"/>
    <field name="footway:width" editable="1"/>
    <field name="ford" editable="1"/>
    <field name="forestry" editable="1"/>
    <field name="frequency" editable="1"/>
    <field name="full_id" editable="1"/>
    <field name="gate" editable="1"/>
    <field name="gauge" editable="1"/>
    <field name="golf" editable="1"/>
    <field name="golf_cart" editable="1"/>
    <field name="goods" editable="1"/>
    <field name="handrail" editable="1"/>
    <field name="handrail:both" editable="1"/>
    <field name="handrail:center" editable="1"/>
    <field name="handrail:colour" editable="1"/>
    <field name="handrail:left" editable="1"/>
    <field name="handrail:middle" editable="1"/>
    <field name="handrail:right" editable="1"/>
    <field name="hazard" editable="1"/>
    <field name="hazard:conditional" editable="1"/>
    <field name="hazmat" editable="1"/>
    <field name="hazmat:backward" editable="1"/>
    <field name="hazmat:forward" editable="1"/>
    <field name="hazmat:water" editable="1"/>
    <field name="height" editable="1"/>
    <field name="heritage" editable="1"/>
    <field name="heritage:operator" editable="1"/>
    <field name="hgv" editable="1"/>
    <field name="hgv:backward" editable="1"/>
    <field name="hgv:conditional" editable="1"/>
    <field name="hgv:forward" editable="1"/>
    <field name="hgv:lanes" editable="1"/>
    <field name="hgv:lanes:forward:conditional" editable="1"/>
    <field name="highway" editable="1"/>
    <field name="highway:note" editable="1"/>
    <field name="historic" editable="1"/>
    <field name="horse" editable="1"/>
    <field name="horse_scale" editable="1"/>
    <field name="image" editable="1"/>
    <field name="incline" editable="1"/>
    <field name="incline:across" editable="1"/>
    <field name="incline_1" editable="1"/>
    <field name="indoor" editable="1"/>
    <field name="indoor_seating" editable="1"/>
    <field name="informal" editable="1"/>
    <field name="inline_skates" editable="1"/>
    <field name="inofficial" editable="1"/>
    <field name="int_ref" editable="1"/>
    <field name="intermittent" editable="1"/>
    <field name="internet_access:fee" editable="1"/>
    <field name="irregular:parking:left" editable="1"/>
    <field name="irregular:parking:left:orientation" editable="1"/>
    <field name="is_in" editable="1"/>
    <field name="is_in:city" editable="1"/>
    <field name="is_in:country_code" editable="1"/>
    <field name="is_sidepath" editable="1"/>
    <field name="is_sidepath:of" editable="1"/>
    <field name="is_sidepath:of:name" editable="1"/>
    <field name="is_sidepath:of:ref" editable="1"/>
    <field name="junction" editable="1"/>
    <field name="kerb" editable="1"/>
    <field name="kerb:approach_aid" editable="1"/>
    <field name="kerb:left" editable="1"/>
    <field name="kerb:right" editable="1"/>
    <field name="ladder" editable="1"/>
    <field name="lane_markings" editable="1"/>
    <field name="lanes" editable="1"/>
    <field name="lanes:backward" editable="1"/>
    <field name="lanes:both_ways" editable="1"/>
    <field name="lanes:bus" editable="1"/>
    <field name="lanes:bus:backward" editable="1"/>
    <field name="lanes:bus:forward" editable="1"/>
    <field name="lanes:forward" editable="1"/>
    <field name="lanes:psv" editable="1"/>
    <field name="lanes:psv:backward" editable="1"/>
    <field name="lanes:psv:forward" editable="1"/>
    <field name="last_check" editable="1"/>
    <field name="last_checked" editable="1"/>
    <field name="layer" editable="1"/>
    <field name="lcn" editable="1"/>
    <field name="left" editable="1"/>
    <field name="length" editable="1"/>
    <field name="level" editable="1"/>
    <field name="lfd:criteria" editable="1"/>
    <field name="lighting" editable="1"/>
    <field name="lit" editable="1"/>
    <field name="lit:note" editable="1"/>
    <field name="lit_by_gaslight" editable="1"/>
    <field name="lit_by_gaslight:left" editable="1"/>
    <field name="lit_by_gaslight:right" editable="1"/>
    <field name="lit_by_led" editable="1"/>
    <field name="living_street" editable="1"/>
    <field name="loc_name" editable="1"/>
    <field name="loc_ref" editable="1"/>
    <field name="local_ref" editable="1"/>
    <field name="location" editable="1"/>
    <field name="long_name" editable="1"/>
    <field name="lwn" editable="1"/>
    <field name="man_made" editable="1"/>
    <field name="manufacturer" editable="1"/>
    <field name="mapillary" editable="1"/>
    <field name="material" editable="1"/>
    <field name="maxaxleload" editable="1"/>
    <field name="maxheight" editable="1"/>
    <field name="maxheight:lanes" editable="1"/>
    <field name="maxheight:physical" editable="1"/>
    <field name="maxheight:signed" editable="1"/>
    <field name="maxlength" editable="1"/>
    <field name="maxspeed" editable="1"/>
    <field name="maxspeed:advisory:variable" editable="1"/>
    <field name="maxspeed:backward" editable="1"/>
    <field name="maxspeed:backward:conditional" editable="1"/>
    <field name="maxspeed:bicycle" editable="1"/>
    <field name="maxspeed:conditional" editable="1"/>
    <field name="maxspeed:destination" editable="1"/>
    <field name="maxspeed:forward" editable="1"/>
    <field name="maxspeed:forward:conditional" editable="1"/>
    <field name="maxspeed:hgv" editable="1"/>
    <field name="maxspeed:hgv:backward" editable="1"/>
    <field name="maxspeed:hgv:conditional" editable="1"/>
    <field name="maxspeed:hgv:forward" editable="1"/>
    <field name="maxspeed:lanes:forward" editable="1"/>
    <field name="maxspeed:max" editable="1"/>
    <field name="maxspeed:note" editable="1"/>
    <field name="maxspeed:practical" editable="1"/>
    <field name="maxspeed:source" editable="1"/>
    <field name="maxspeed:type" editable="1"/>
    <field name="maxspeed:type:backward" editable="1"/>
    <field name="maxspeed:variable" editable="1"/>
    <field name="maxstay" editable="1"/>
    <field name="maxweight" editable="1"/>
    <field name="maxweight:agricultural" editable="1"/>
    <field name="maxweight:backward" editable="1"/>
    <field name="maxweight:conditional" editable="1"/>
    <field name="maxweight:delivery" editable="1"/>
    <field name="maxweight:destination" editable="1"/>
    <field name="maxweight:forward" editable="1"/>
    <field name="maxweight:hgv" editable="1"/>
    <field name="maxweight:lanes" editable="1"/>
    <field name="maxweight:psv" editable="1"/>
    <field name="maxweight:signed" editable="1"/>
    <field name="maxweightrating" editable="1"/>
    <field name="maxweightrating:hgv" editable="1"/>
    <field name="maxwidth" editable="1"/>
    <field name="maxwidth:lanes" editable="1"/>
    <field name="maxwidth:lanes:backward" editable="1"/>
    <field name="maxwidth:lanes:forward" editable="1"/>
    <field name="maxwidth:physical" editable="1"/>
    <field name="mlc" editable="1"/>
    <field name="mlc:oneway" editable="1"/>
    <field name="mlc:tracked" editable="1"/>
    <field name="mlc:tracked_oneway" editable="1"/>
    <field name="mlc:wheeled" editable="1"/>
    <field name="mlc:wheeled_oneway" editable="1"/>
    <field name="motor_vehicle" editable="1"/>
    <field name="motor_vehicle:backward" editable="1"/>
    <field name="motor_vehicle:conditional" editable="1"/>
    <field name="motor_vehicle:forward" editable="1"/>
    <field name="motor_vehicle:lanes:backward" editable="1"/>
    <field name="motor_vehicle:lanes:forward" editable="1"/>
    <field name="motorcar" editable="1"/>
    <field name="motorcycle" editable="1"/>
    <field name="motorcycle:forward" editable="1"/>
    <field name="motorhome" editable="1"/>
    <field name="motorhome:backward" editable="1"/>
    <field name="motorhome:forward" editable="1"/>
    <field name="motorroad" editable="1"/>
    <field name="mtb" editable="1"/>
    <field name="mtb:description" editable="1"/>
    <field name="mtb:name" editable="1"/>
    <field name="mtb:scale" editable="1"/>
    <field name="mtb:scale:imba" editable="1"/>
    <field name="mtb:scale:uphill" editable="1"/>
    <field name="mtb:type" editable="1"/>
    <field name="name" editable="1"/>
    <field name="name:ar" editable="1"/>
    <field name="name:be" editable="1"/>
    <field name="name:de" editable="1"/>
    <field name="name:es" editable="1"/>
    <field name="name:etymology" editable="1"/>
    <field name="name:etymology:wikidata" editable="1"/>
    <field name="name:etymology:wikipedia" editable="1"/>
    <field name="name:hsb" editable="1"/>
    <field name="name:left" editable="1"/>
    <field name="name:right" editable="1"/>
    <field name="narrow" editable="1"/>
    <field name="natural" editable="1"/>
    <field name="ncn_ref" editable="1"/>
    <field name="network" editable="1"/>
    <field name="network:short" editable="1"/>
    <field name="network:wikidata" editable="1"/>
    <field name="network:wikipedia" editable="1"/>
    <field name="noexit" editable="1"/>
    <field name="noise_barrier" editable="1"/>
    <field name="noname" editable="1"/>
    <field name="note:access" editable="1"/>
    <field name="note:bicycle" editable="1"/>
    <field name="note:de" editable="1"/>
    <field name="note:lanes" editable="1"/>
    <field name="note:lit" editable="1"/>
    <field name="note:maxheight" editable="1"/>
    <field name="note:maxspeed" editable="1"/>
    <field name="note:name" editable="1"/>
    <field name="note:surface" editable="1"/>
    <field name="note_2" editable="1"/>
    <field name="obstacle" editable="1"/>
    <field name="obstacle:wheelchair" editable="1"/>
    <field name="old_name" editable="1"/>
    <field name="old_name:1876-1937" editable="1"/>
    <field name="old_name:1897" editable="1"/>
    <field name="old_name:1926-1948" editable="1"/>
    <field name="old_name:1937-1945" editable="1"/>
    <field name="old_name:1948-1993" editable="1"/>
    <field name="old_name:196X-1993" editable="1"/>
    <field name="old_ref" editable="1"/>
    <field name="oneway" editable="1"/>
    <field name="oneway:agricultural" editable="1"/>
    <field name="oneway:bicycle" editable="1"/>
    <field name="oneway:bus" editable="1"/>
    <field name="oneway:conditional" editable="1"/>
    <field name="oneway:foot" editable="1"/>
    <field name="oneway:psv" editable="1"/>
    <field name="opening_date" editable="1"/>
    <field name="opening_hours" editable="1"/>
    <field name="operator" editable="1"/>
    <field name="operator:type" editable="1"/>
    <field name="osm_id" editable="1"/>
    <field name="osm_type" editable="1"/>
    <field name="osmc:symbol" editable="1"/>
    <field name="other_tags" editable="1"/>
    <field name="overtaking" editable="1"/>
    <field name="overtaking:backward" editable="1"/>
    <field name="overtaking:forward" editable="1"/>
    <field name="overtaking:hgv:backward" editable="1"/>
    <field name="overtaking:hgv:forward" editable="1"/>
    <field name="parking" editable="1"/>
    <field name="parking:both" editable="1"/>
    <field name="parking:both:fee" editable="1"/>
    <field name="parking:both:fee:conditional" editable="1"/>
    <field name="parking:both:markings" editable="1"/>
    <field name="parking:both:orientation" editable="1"/>
    <field name="parking:both:reason" editable="1"/>
    <field name="parking:both:restriction" editable="1"/>
    <field name="parking:both:staggered" editable="1"/>
    <field name="parking:condition" editable="1"/>
    <field name="parking:condition:both" editable="1"/>
    <field name="parking:condition:both:conditional" editable="1"/>
    <field name="parking:condition:both:customers" editable="1"/>
    <field name="parking:condition:both:default" editable="1"/>
    <field name="parking:condition:both:maxstay" editable="1"/>
    <field name="parking:condition:both:residents" editable="1"/>
    <field name="parking:condition:both:time_interval" editable="1"/>
    <field name="parking:condition:both:vehicles" editable="1"/>
    <field name="parking:condition:left" editable="1"/>
    <field name="parking:condition:left:capacity" editable="1"/>
    <field name="parking:condition:left:capacity:disabled" editable="1"/>
    <field name="parking:condition:left:conditional" editable="1"/>
    <field name="parking:condition:left:default" editable="1"/>
    <field name="parking:condition:left:maxstay" editable="1"/>
    <field name="parking:condition:left:residents" editable="1"/>
    <field name="parking:condition:left:time_interval" editable="1"/>
    <field name="parking:condition:left:vehicles" editable="1"/>
    <field name="parking:condition:maxstay" editable="1"/>
    <field name="parking:condition:right" editable="1"/>
    <field name="parking:condition:right:capacity" editable="1"/>
    <field name="parking:condition:right:capacity:disabled" editable="1"/>
    <field name="parking:condition:right:default" editable="1"/>
    <field name="parking:condition:right:disabled" editable="1"/>
    <field name="parking:condition:right:maxstay" editable="1"/>
    <field name="parking:condition:right:residents" editable="1"/>
    <field name="parking:condition:right:time_interval" editable="1"/>
    <field name="parking:condition:right:vehicles" editable="1"/>
    <field name="parking:lane" editable="1"/>
    <field name="parking:lane:both" editable="1"/>
    <field name="parking:lane:both:diagonal" editable="1"/>
    <field name="parking:lane:both:parallel" editable="1"/>
    <field name="parking:lane:both:perpendicular" editable="1"/>
    <field name="parking:lane:disabled" editable="1"/>
    <field name="parking:lane:forward" editable="1"/>
    <field name="parking:lane:left" editable="1"/>
    <field name="parking:lane:left:capacity" editable="1"/>
    <field name="parking:lane:left:diagonal" editable="1"/>
    <field name="parking:lane:left:maxstay" editable="1"/>
    <field name="parking:lane:left:parallel" editable="1"/>
    <field name="parking:lane:left:perpendicular" editable="1"/>
    <field name="parking:lane:left:surface" editable="1"/>
    <field name="parking:lane:right" editable="1"/>
    <field name="parking:lane:right:capacity" editable="1"/>
    <field name="parking:lane:right:diagonal" editable="1"/>
    <field name="parking:lane:right:parallel" editable="1"/>
    <field name="parking:lane:right:perpendicular" editable="1"/>
    <field name="parking:lane:right:surface" editable="1"/>
    <field name="parking:lanes:left" editable="1"/>
    <field name="parking:lanes:right" editable="1"/>
    <field name="parking:left" editable="1"/>
    <field name="parking:left:access" editable="1"/>
    <field name="parking:left:authentication:disc:conditional" editable="1"/>
    <field name="parking:left:fee" editable="1"/>
    <field name="parking:left:markings" editable="1"/>
    <field name="parking:left:maxstay:conditional" editable="1"/>
    <field name="parking:left:orientation" editable="1"/>
    <field name="parking:left:parallel" editable="1"/>
    <field name="parking:left:perpendicular" editable="1"/>
    <field name="parking:left:reason" editable="1"/>
    <field name="parking:left:restriction" editable="1"/>
    <field name="parking:left:restriction:conditional" editable="1"/>
    <field name="parking:left:restriction:reason" editable="1"/>
    <field name="parking:left:staggered" editable="1"/>
    <field name="parking:right" editable="1"/>
    <field name="parking:right:access" editable="1"/>
    <field name="parking:right:access:conditional" editable="1"/>
    <field name="parking:right:authentication:disc:conditional" editable="1"/>
    <field name="parking:right:authentication:ticket" editable="1"/>
    <field name="parking:right:fee" editable="1"/>
    <field name="parking:right:markings" editable="1"/>
    <field name="parking:right:maxstay:conditional" editable="1"/>
    <field name="parking:right:orientation" editable="1"/>
    <field name="parking:right:perpendicular" editable="1"/>
    <field name="parking:right:reason" editable="1"/>
    <field name="parking:right:restriction" editable="1"/>
    <field name="parking:right:restriction:conditional" editable="1"/>
    <field name="parking:right:restriction:reason" editable="1"/>
    <field name="parking:right:surface" editable="1"/>
    <field name="parking_lane:both" editable="1"/>
    <field name="passage_type" editable="1"/>
    <field name="passenger_information_display" editable="1"/>
    <field name="passenger_information_display:speech_output" editable="1"/>
    <field name="passing_places" editable="1"/>
    <field name="path" editable="1"/>
    <field name="pathtype" editable="1"/>
    <field name="paving_stones:size" editable="1"/>
    <field name="piste:difficulty" editable="1"/>
    <field name="piste:grooming" editable="1"/>
    <field name="piste:type" editable="1"/>
    <field name="placement" editable="1"/>
    <field name="placement:backward" editable="1"/>
    <field name="placement:forward" editable="1"/>
    <field name="planned" editable="1"/>
    <field name="platform_lift" editable="1"/>
    <field name="playground" editable="1"/>
    <field name="postal_code" editable="1"/>
    <field name="priority" editable="1"/>
    <field name="priority_road" editable="1"/>
    <field name="priority_road:backward" editable="1"/>
    <field name="priority_road:forward" editable="1"/>
    <field name="private" editable="1"/>
    <field name="proposed" editable="1"/>
    <field name="psv" editable="1"/>
    <field name="psv:backward" editable="1"/>
    <field name="psv:lanes" editable="1"/>
    <field name="psv:lanes:backward" editable="1"/>
    <field name="psv:lanes:forward" editable="1"/>
    <field name="public_transport" editable="1"/>
    <field name="qr_code" editable="1"/>
    <field name="railway" editable="1"/>
    <field name="railway:preferred_direction" editable="1"/>
    <field name="railway:traffic_mode" editable="1"/>
    <field name="ramp" editable="1"/>
    <field name="ramp:bicycle" editable="1"/>
    <field name="ramp:luggage" editable="1"/>
    <field name="ramp:stroller" editable="1"/>
    <field name="ramp:wheelchair" editable="1"/>
    <field name="razed:bridge" editable="1"/>
    <field name="razed:railway" editable="1"/>
    <field name="red_turn:left" editable="1"/>
    <field name="red_turn:right" editable="1"/>
    <field name="ref" editable="1"/>
    <field name="ref:IFOPT" editable="1"/>
    <field name="ref:IFOPT:description" editable="1"/>
    <field name="ref:VVO" editable="1"/>
    <field name="ref:lfd" editable="1"/>
    <field name="ref:manufacturer_inventory" editable="1"/>
    <field name="ref:operator_inventory" editable="1"/>
    <field name="ref_name" editable="1"/>
    <field name="reg_name" editable="1"/>
    <field name="render" editable="1"/>
    <field name="repeat_on" editable="1"/>
    <field name="roof" editable="1"/>
    <field name="roof:edge" editable="1"/>
    <field name="roof:levels" editable="1"/>
    <field name="roof:shape" editable="1"/>
    <field name="room" editable="1"/>
    <field name="route" editable="1"/>
    <field name="route_ref" editable="1"/>
    <field name="ruins" editable="1"/>
    <field name="sac_scale" editable="1"/>
    <field name="segregated" editable="1"/>
    <field name="service" editable="1"/>
    <field name="shelter" editable="1"/>
    <field name="short_name" editable="1"/>
    <field name="shoulder" editable="1"/>
    <field name="shoulder:right" editable="1"/>
    <field name="side" editable="1"/>
    <field name="sideincline" editable="1"/>
    <field name="sidewalk" editable="1"/>
    <field name="sidewalk:bicycle" editable="1"/>
    <field name="sidewalk:both" editable="1"/>
    <field name="sidewalk:both:bicycle" editable="1"/>
    <field name="sidewalk:both:foot" editable="1"/>
    <field name="sidewalk:both:smoothness" editable="1"/>
    <field name="sidewalk:both:surface" editable="1"/>
    <field name="sidewalk:both:traffic_sign" editable="1"/>
    <field name="sidewalk:foot" editable="1"/>
    <field name="sidewalk:left" editable="1"/>
    <field name="sidewalk:left:bicycle" editable="1"/>
    <field name="sidewalk:left:bicycle:backward" editable="1"/>
    <field name="sidewalk:left:bicycle:forward" editable="1"/>
    <field name="sidewalk:left:bicycle:maxspeed:backward" editable="1"/>
    <field name="sidewalk:left:description:de" editable="1"/>
    <field name="sidewalk:left:description:en" editable="1"/>
    <field name="sidewalk:left:est_width" editable="1"/>
    <field name="sidewalk:left:foot" editable="1"/>
    <field name="sidewalk:left:incline" editable="1"/>
    <field name="sidewalk:left:kerb" editable="1"/>
    <field name="sidewalk:left:oneway" editable="1"/>
    <field name="sidewalk:left:smoothness" editable="1"/>
    <field name="sidewalk:left:surface" editable="1"/>
    <field name="sidewalk:left:traffic_sign" editable="1"/>
    <field name="sidewalk:left:width" editable="1"/>
    <field name="sidewalk:oneway" editable="1"/>
    <field name="sidewalk:right" editable="1"/>
    <field name="sidewalk:right:bicycle" editable="1"/>
    <field name="sidewalk:right:bicycle:maxspeed" editable="1"/>
    <field name="sidewalk:right:bicycle:oneway" editable="1"/>
    <field name="sidewalk:right:description:de" editable="1"/>
    <field name="sidewalk:right:description:en" editable="1"/>
    <field name="sidewalk:right:est_width" editable="1"/>
    <field name="sidewalk:right:foot" editable="1"/>
    <field name="sidewalk:right:incline" editable="1"/>
    <field name="sidewalk:right:kerb" editable="1"/>
    <field name="sidewalk:right:oneway" editable="1"/>
    <field name="sidewalk:right:segregated" editable="1"/>
    <field name="sidewalk:right:smoothness" editable="1"/>
    <field name="sidewalk:right:surface" editable="1"/>
    <field name="sidewalk:right:surface:note" editable="1"/>
    <field name="sidewalk:right:traffic_sign" editable="1"/>
    <field name="sidewalk:right:width" editable="1"/>
    <field name="sidewalk:smoothness" editable="1"/>
    <field name="sidewalk:surface" editable="1"/>
    <field name="sidewalk:traffic_sign" editable="1"/>
    <field name="sideway" editable="1"/>
    <field name="ski" editable="1"/>
    <field name="sloped_curb" editable="1"/>
    <field name="smoking" editable="1"/>
    <field name="smoothness" editable="1"/>
    <field name="smoothness:backward" editable="1"/>
    <field name="smoothness:forward" editable="1"/>
    <field name="snowmobile" editable="1"/>
    <field name="source:access" editable="1"/>
    <field name="source:alt_name" editable="1"/>
    <field name="source:cycleway:width" editable="1"/>
    <field name="source:destination" editable="1"/>
    <field name="source:geometry" editable="1"/>
    <field name="source:incline" editable="1"/>
    <field name="source:lit" editable="1"/>
    <field name="source:maxheight" editable="1"/>
    <field name="source:maxspeed" editable="1"/>
    <field name="source:maxspeed:backward" editable="1"/>
    <field name="source:maxspeed:conditional" editable="1"/>
    <field name="source:maxspeed:forward" editable="1"/>
    <field name="source:maxspeed:hgv" editable="1"/>
    <field name="source:maxweight" editable="1"/>
    <field name="source:maxwidth" editable="1"/>
    <field name="source:name" editable="1"/>
    <field name="source:offset" editable="1"/>
    <field name="source:old_name" editable="1"/>
    <field name="source:oneway" editable="1"/>
    <field name="source:outline" editable="1"/>
    <field name="source:reg_name" editable="1"/>
    <field name="source:width" editable="1"/>
    <field name="speech_output" editable="1"/>
    <field name="speech_output:de" editable="1"/>
    <field name="sport" editable="1"/>
    <field name="stairs" editable="1"/>
    <field name="start_date" editable="1"/>
    <field name="step.condition" editable="1"/>
    <field name="step.height" editable="1"/>
    <field name="step.length" editable="1"/>
    <field name="step:height" editable="1"/>
    <field name="step:length" editable="1"/>
    <field name="step_count" editable="1"/>
    <field name="steps" editable="1"/>
    <field name="stone" editable="1"/>
    <field name="stroller" editable="1"/>
    <field name="subject:wikidata" editable="1"/>
    <field name="supervised" editable="1"/>
    <field name="support" editable="1"/>
    <field name="surface" editable="1"/>
    <field name="surface:backward" editable="1"/>
    <field name="surface:colour" editable="1"/>
    <field name="surface:comment" editable="1"/>
    <field name="surface:de" editable="1"/>
    <field name="surface:forward" editable="1"/>
    <field name="surface:lanes:backward" editable="1"/>
    <field name="surface:lanes:forward" editable="1"/>
    <field name="surface:left" editable="1"/>
    <field name="surface:middle" editable="1"/>
    <field name="surface:note" editable="1"/>
    <field name="surface:paved" editable="1"/>
    <field name="surface:right" editable="1"/>
    <field name="surface_material" editable="1"/>
    <field name="survey:date" editable="1"/>
    <field name="symbol" editable="1"/>
    <field name="tactile_paving" editable="1"/>
    <field name="tactile_paving:end" editable="1"/>
    <field name="tactile_paving:start" editable="1"/>
    <field name="tactile_writing" editable="1"/>
    <field name="tactile_writing:braille:de" editable="1"/>
    <field name="tactile_writing:engraved_printed_letters:de" editable="1"/>
    <field name="tags" editable="1"/>
    <field name="taxi" editable="1"/>
    <field name="taxi:lanes" editable="1"/>
    <field name="temporary:access" editable="1"/>
    <field name="temporary:date_off" editable="1"/>
    <field name="temporary:date_on" editable="1"/>
    <field name="toilets" editable="1"/>
    <field name="toll" editable="1"/>
    <field name="toll:N3" editable="1"/>
    <field name="tourism" editable="1"/>
    <field name="tourist_bus" editable="1"/>
    <field name="tracktype" editable="1"/>
    <field name="traffic_calming" editable="1"/>
    <field name="traffic_sign" editable="1"/>
    <field name="traffic_sign:backward" editable="1"/>
    <field name="traffic_sign:forward" editable="1"/>
    <field name="traffic_signals:direction" editable="1"/>
    <field name="trail_visibility" editable="1"/>
    <field name="tram" editable="1"/>
    <field name="tree_lined" editable="1"/>
    <field name="tree_lined:both:taxon" editable="1"/>
    <field name="trolley_wire" editable="1"/>
    <field name="truck" editable="1"/>
    <field name="tunnel" editable="1"/>
    <field name="tunnel:name" editable="1"/>
    <field name="turn" editable="1"/>
    <field name="turn:backward" editable="1"/>
    <field name="turn:bicycle:lanes:backward" editable="1"/>
    <field name="turn:forward" editable="1"/>
    <field name="turn:lanes" editable="1"/>
    <field name="turn:lanes:backward" editable="1"/>
    <field name="turn:lanes:both_ways" editable="1"/>
    <field name="turn:lanes:forward" editable="1"/>
    <field name="type" editable="1"/>
    <field name="uic_ref" editable="1"/>
    <field name="unsigned_ref" editable="1"/>
    <field name="url" editable="1"/>
    <field name="usability:skate" editable="1"/>
    <field name="usage" editable="1"/>
    <field name="vehicle" editable="1"/>
    <field name="vehicle:backward" editable="1"/>
    <field name="vehicle:conditional" editable="1"/>
    <field name="vehicle:disabled" editable="1"/>
    <field name="vehicle:forward" editable="1"/>
    <field name="vehicle:forward:conditional" editable="1"/>
    <field name="vehicle:lanes" editable="1"/>
    <field name="vehicle:lanes:backward" editable="1"/>
    <field name="vehicle:lanes:forward" editable="1"/>
    <field name="via_ferrata_scale" editable="1"/>
    <field name="virtual:highway" editable="1"/>
    <field name="visibility" editable="1"/>
    <field name="voltage" editable="1"/>
    <field name="vvo-id" editable="1"/>
    <field name="warning_light" editable="1"/>
    <field name="waste_basket" editable="1"/>
    <field name="waterway" editable="1"/>
    <field name="website" editable="1"/>
    <field name="wheelchair" editable="1"/>
    <field name="wheelchair:description" editable="1"/>
    <field name="wheelchair:description:de" editable="1"/>
    <field name="whitewater" editable="1"/>
    <field name="width" editable="1"/>
    <field name="width:bicycle" editable="1"/>
    <field name="width:comment" editable="1"/>
    <field name="width:lanes" editable="1"/>
    <field name="width:lanes:backward" editable="1"/>
    <field name="width:lanes:forward" editable="1"/>
    <field name="width_1" editable="1"/>
    <field name="wikidata" editable="1"/>
    <field name="wikidata:note" editable="1"/>
    <field name="wikimedia_commons" editable="1"/>
    <field name="wikipedia" editable="1"/>
    <field name="winter_service" editable="1"/>
    <field name="z_order" editable="1"/>
    <field name="zone:maxspeed" editable="1"/>
    <field name="zone:no_parking" editable="1"/>
    <field name="zone:parking" editable="1"/>
    <field name="zone:traffic" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="FIXME"/>
    <field labelOnTop="0" name="FIXME:de"/>
    <field labelOnTop="0" name="TMC:cid_58:tabcd_1:Class"/>
    <field labelOnTop="0" name="TMC:cid_58:tabcd_1:LCLversion"/>
    <field labelOnTop="0" name="TMC:cid_58:tabcd_1:LocationCode"/>
    <field labelOnTop="0" name="TMC:cid_58:tabcd_1:NextLocationCode"/>
    <field labelOnTop="0" name="TMC:cid_58:tabcd_1:PrevLocationCode"/>
    <field labelOnTop="0" name="TODO"/>
    <field labelOnTop="0" name="_uid_"/>
    <field labelOnTop="0" name="abandoned"/>
    <field labelOnTop="0" name="abandoned:railway"/>
    <field labelOnTop="0" name="access"/>
    <field labelOnTop="0" name="access:N3"/>
    <field labelOnTop="0" name="access:backward"/>
    <field labelOnTop="0" name="access:both_ways"/>
    <field labelOnTop="0" name="access:conditional"/>
    <field labelOnTop="0" name="access:lanes"/>
    <field labelOnTop="0" name="access:lanes:backward"/>
    <field labelOnTop="0" name="access:lanes:forward"/>
    <field labelOnTop="0" name="access:lanes:note"/>
    <field labelOnTop="0" name="access_ramp"/>
    <field labelOnTop="0" name="aerialway"/>
    <field labelOnTop="0" name="agricultural"/>
    <field labelOnTop="0" name="alt_name"/>
    <field labelOnTop="0" name="ambulance"/>
    <field labelOnTop="0" name="amenity"/>
    <field labelOnTop="0" name="arcade:left"/>
    <field labelOnTop="0" name="arcade:right"/>
    <field labelOnTop="0" name="area"/>
    <field labelOnTop="0" name="ascent"/>
    <field labelOnTop="0" name="barrier"/>
    <field labelOnTop="0" name="bdouble"/>
    <field labelOnTop="0" name="bench"/>
    <field labelOnTop="0" name="bicycle"/>
    <field labelOnTop="0" name="bicycle:backward"/>
    <field labelOnTop="0" name="bicycle:conditional"/>
    <field labelOnTop="0" name="bicycle:forward"/>
    <field labelOnTop="0" name="bicycle:lanes"/>
    <field labelOnTop="0" name="bicycle:lanes:backward"/>
    <field labelOnTop="0" name="bicycle:lanes:forward"/>
    <field labelOnTop="0" name="bicycle:left"/>
    <field labelOnTop="0" name="bicycle:note"/>
    <field labelOnTop="0" name="bicycle:oneway"/>
    <field labelOnTop="0" name="bicycle:right"/>
    <field labelOnTop="0" name="bicycle_parking"/>
    <field labelOnTop="0" name="bicycle_road"/>
    <field labelOnTop="0" name="bin"/>
    <field labelOnTop="0" name="brand"/>
    <field labelOnTop="0" name="bridge"/>
    <field labelOnTop="0" name="bridge:material"/>
    <field labelOnTop="0" name="bridge:name"/>
    <field labelOnTop="0" name="bridge:ref"/>
    <field labelOnTop="0" name="bridge:structure"/>
    <field labelOnTop="0" name="building:material"/>
    <field labelOnTop="0" name="bus"/>
    <field labelOnTop="0" name="bus:lanes"/>
    <field labelOnTop="0" name="bus:lanes:backward"/>
    <field labelOnTop="0" name="bus:lanes:forward"/>
    <field labelOnTop="0" name="bus_bay"/>
    <field labelOnTop="0" name="bus_bay:left"/>
    <field labelOnTop="0" name="busway"/>
    <field labelOnTop="0" name="busway:left"/>
    <field labelOnTop="0" name="busway:right"/>
    <field labelOnTop="0" name="button_operated"/>
    <field labelOnTop="0" name="capacity:police"/>
    <field labelOnTop="0" name="caravan"/>
    <field labelOnTop="0" name="carriage"/>
    <field labelOnTop="0" name="category"/>
    <field labelOnTop="0" name="change:backward"/>
    <field labelOnTop="0" name="change:both_ways"/>
    <field labelOnTop="0" name="change:forward"/>
    <field labelOnTop="0" name="change:lanes"/>
    <field labelOnTop="0" name="change:lanes:backward"/>
    <field labelOnTop="0" name="change:lanes:forward"/>
    <field labelOnTop="0" name="check_date"/>
    <field labelOnTop="0" name="check_date:bench"/>
    <field labelOnTop="0" name="check_date:bicycle"/>
    <field labelOnTop="0" name="check_date:cycleway"/>
    <field labelOnTop="0" name="check_date:cycleway:surface"/>
    <field labelOnTop="0" name="check_date:handrail"/>
    <field labelOnTop="0" name="check_date:lit"/>
    <field labelOnTop="0" name="check_date:ramp"/>
    <field labelOnTop="0" name="check_date:segregated"/>
    <field labelOnTop="0" name="check_date:shelter"/>
    <field labelOnTop="0" name="check_date:sidewalk"/>
    <field labelOnTop="0" name="check_date:sidewalk:surface"/>
    <field labelOnTop="0" name="check_date:smoothness"/>
    <field labelOnTop="0" name="check_date:surface"/>
    <field labelOnTop="0" name="check_date:tactile_paving"/>
    <field labelOnTop="0" name="check_date:tracktype"/>
    <field labelOnTop="0" name="checked_date"/>
    <field labelOnTop="0" name="class:bicycle"/>
    <field labelOnTop="0" name="class:bicycle:roadcycling"/>
    <field labelOnTop="0" name="colonnade:left"/>
    <field labelOnTop="0" name="colonnade:right"/>
    <field labelOnTop="0" name="comment"/>
    <field labelOnTop="0" name="comment:history"/>
    <field labelOnTop="0" name="construction"/>
    <field labelOnTop="0" name="construction:highway"/>
    <field labelOnTop="0" name="contrastive_stripes"/>
    <field labelOnTop="0" name="contrastive_stripes:all"/>
    <field labelOnTop="0" name="contrastive_stripes:end"/>
    <field labelOnTop="0" name="contrastive_stripes:start"/>
    <field labelOnTop="0" name="conveying"/>
    <field labelOnTop="0" name="count"/>
    <field labelOnTop="0" name="covered"/>
    <field labelOnTop="0" name="crossing"/>
    <field labelOnTop="0" name="crossing:island"/>
    <field labelOnTop="0" name="crossing:markings"/>
    <field labelOnTop="0" name="cutting"/>
    <field labelOnTop="0" name="cyclestreet"/>
    <field labelOnTop="0" name="cycleway"/>
    <field labelOnTop="0" name="cycleway:backward"/>
    <field labelOnTop="0" name="cycleway:bicycle"/>
    <field labelOnTop="0" name="cycleway:both"/>
    <field labelOnTop="0" name="cycleway:both:bicycle"/>
    <field labelOnTop="0" name="cycleway:both:lane"/>
    <field labelOnTop="0" name="cycleway:both:segregated"/>
    <field labelOnTop="0" name="cycleway:both:traffic_sign"/>
    <field labelOnTop="0" name="cycleway:both:width"/>
    <field labelOnTop="0" name="cycleway:foot"/>
    <field labelOnTop="0" name="cycleway:forward"/>
    <field labelOnTop="0" name="cycleway:lane"/>
    <field labelOnTop="0" name="cycleway:lanes"/>
    <field labelOnTop="0" name="cycleway:left"/>
    <field labelOnTop="0" name="cycleway:left:bicycle"/>
    <field labelOnTop="0" name="cycleway:left:foot"/>
    <field labelOnTop="0" name="cycleway:left:lane"/>
    <field labelOnTop="0" name="cycleway:left:oneway"/>
    <field labelOnTop="0" name="cycleway:left:oneway:bicycle"/>
    <field labelOnTop="0" name="cycleway:left:segregated"/>
    <field labelOnTop="0" name="cycleway:left:smoothness"/>
    <field labelOnTop="0" name="cycleway:left:surface"/>
    <field labelOnTop="0" name="cycleway:left:surface:colour"/>
    <field labelOnTop="0" name="cycleway:left:traffic_sign"/>
    <field labelOnTop="0" name="cycleway:oneway"/>
    <field labelOnTop="0" name="cycleway:right"/>
    <field labelOnTop="0" name="cycleway:right:bicycle"/>
    <field labelOnTop="0" name="cycleway:right:foot"/>
    <field labelOnTop="0" name="cycleway:right:lane"/>
    <field labelOnTop="0" name="cycleway:right:oneway"/>
    <field labelOnTop="0" name="cycleway:right:protection:left"/>
    <field labelOnTop="0" name="cycleway:right:segregated"/>
    <field labelOnTop="0" name="cycleway:right:smoothness"/>
    <field labelOnTop="0" name="cycleway:right:surface"/>
    <field labelOnTop="0" name="cycleway:right:surface:colour"/>
    <field labelOnTop="0" name="cycleway:right:traffic_sign"/>
    <field labelOnTop="0" name="cycleway:right:width"/>
    <field labelOnTop="0" name="cycleway:segregated"/>
    <field labelOnTop="0" name="cycleway:smoothness"/>
    <field labelOnTop="0" name="cycleway:surface"/>
    <field labelOnTop="0" name="cycleway:surface:colour"/>
    <field labelOnTop="0" name="cycleway:traffic_sign"/>
    <field labelOnTop="0" name="cycleway:width"/>
    <field labelOnTop="0" name="delivery"/>
    <field labelOnTop="0" name="demolished:highway"/>
    <field labelOnTop="0" name="departures_board"/>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="description:de"/>
    <field labelOnTop="0" name="description:en"/>
    <field labelOnTop="0" name="designated"/>
    <field labelOnTop="0" name="designation"/>
    <field labelOnTop="0" name="destination"/>
    <field labelOnTop="0" name="destination:arrow"/>
    <field labelOnTop="0" name="destination:arrow:backward"/>
    <field labelOnTop="0" name="destination:arrow:lanes"/>
    <field labelOnTop="0" name="destination:arrow:lanes:backward"/>
    <field labelOnTop="0" name="destination:arrow:lanes:forward"/>
    <field labelOnTop="0" name="destination:arrow:to:lanes"/>
    <field labelOnTop="0" name="destination:arrow:to:lanes:backward"/>
    <field labelOnTop="0" name="destination:arrow:to:lanes:forward"/>
    <field labelOnTop="0" name="destination:backward"/>
    <field labelOnTop="0" name="destination:bicycle"/>
    <field labelOnTop="0" name="destination:bicycle:backward"/>
    <field labelOnTop="0" name="destination:bicycle:forward"/>
    <field labelOnTop="0" name="destination:colour"/>
    <field labelOnTop="0" name="destination:colour:backward"/>
    <field labelOnTop="0" name="destination:colour:forward"/>
    <field labelOnTop="0" name="destination:colour:lanes"/>
    <field labelOnTop="0" name="destination:colour:lanes:backward"/>
    <field labelOnTop="0" name="destination:colour:lanes:forward"/>
    <field labelOnTop="0" name="destination:colour:to"/>
    <field labelOnTop="0" name="destination:colour:to:forward"/>
    <field labelOnTop="0" name="destination:country"/>
    <field labelOnTop="0" name="destination:country:lanes"/>
    <field labelOnTop="0" name="destination:distance:lanes:backward"/>
    <field labelOnTop="0" name="destination:forward"/>
    <field labelOnTop="0" name="destination:lanes"/>
    <field labelOnTop="0" name="destination:lanes:backward"/>
    <field labelOnTop="0" name="destination:lanes:forward"/>
    <field labelOnTop="0" name="destination:ref"/>
    <field labelOnTop="0" name="destination:ref:backward"/>
    <field labelOnTop="0" name="destination:ref:forward"/>
    <field labelOnTop="0" name="destination:ref:lanes"/>
    <field labelOnTop="0" name="destination:ref:lanes:backward"/>
    <field labelOnTop="0" name="destination:ref:lanes:forward"/>
    <field labelOnTop="0" name="destination:ref:to"/>
    <field labelOnTop="0" name="destination:ref:to:backward"/>
    <field labelOnTop="0" name="destination:ref:to:forward"/>
    <field labelOnTop="0" name="destination:ref:to:lanes"/>
    <field labelOnTop="0" name="destination:ref:to:lanes:backward"/>
    <field labelOnTop="0" name="destination:ref:to:lanes:forward"/>
    <field labelOnTop="0" name="destination:street"/>
    <field labelOnTop="0" name="destination:street:backward"/>
    <field labelOnTop="0" name="destination:street:forward"/>
    <field labelOnTop="0" name="destination:street:lanes"/>
    <field labelOnTop="0" name="destination:symbol"/>
    <field labelOnTop="0" name="destination:symbol:backward"/>
    <field labelOnTop="0" name="destination:symbol:forward"/>
    <field labelOnTop="0" name="destination:symbol:lanes"/>
    <field labelOnTop="0" name="destination:symbol:lanes:backward"/>
    <field labelOnTop="0" name="destination:symbol:lanes:forward"/>
    <field labelOnTop="0" name="destination:symbol:to"/>
    <field labelOnTop="0" name="destination:symbol:to:backward"/>
    <field labelOnTop="0" name="destination:symbol:to:forward"/>
    <field labelOnTop="0" name="destination:symbol:to:lanes"/>
    <field labelOnTop="0" name="destination:symbol:to:lanes:backward"/>
    <field labelOnTop="0" name="destination:symbol:to:lanes:forward"/>
    <field labelOnTop="0" name="destination:to"/>
    <field labelOnTop="0" name="destination:to:backward"/>
    <field labelOnTop="0" name="destination:to:forward"/>
    <field labelOnTop="0" name="destination:to:lanes"/>
    <field labelOnTop="0" name="destination:to:lanes:backward"/>
    <field labelOnTop="0" name="destination:to:lanes:forward"/>
    <field labelOnTop="0" name="direction"/>
    <field labelOnTop="0" name="direction:backward"/>
    <field labelOnTop="0" name="direction:forward"/>
    <field labelOnTop="0" name="dirtbike:scale"/>
    <field labelOnTop="0" name="disabled"/>
    <field labelOnTop="0" name="disused:highway"/>
    <field labelOnTop="0" name="disused:railway"/>
    <field labelOnTop="0" name="dog"/>
    <field labelOnTop="0" name="dual_carriageway"/>
    <field labelOnTop="0" name="ele"/>
    <field labelOnTop="0" name="electrified"/>
    <field labelOnTop="0" name="embankment"/>
    <field labelOnTop="0" name="embedded_rails"/>
    <field labelOnTop="0" name="embedded_rails:forward"/>
    <field labelOnTop="0" name="emergency"/>
    <field labelOnTop="0" name="end_date"/>
    <field labelOnTop="0" name="est_length"/>
    <field labelOnTop="0" name="est_width"/>
    <field labelOnTop="0" name="fake_gaslight"/>
    <field labelOnTop="0" name="fee"/>
    <field labelOnTop="0" name="fid"/>
    <field labelOnTop="0" name="flat_steps"/>
    <field labelOnTop="0" name="floating"/>
    <field labelOnTop="0" name="flood_prone"/>
    <field labelOnTop="0" name="foot"/>
    <field labelOnTop="0" name="foot:backward"/>
    <field labelOnTop="0" name="foot:conditional"/>
    <field labelOnTop="0" name="foot:forward"/>
    <field labelOnTop="0" name="foot:left"/>
    <field labelOnTop="0" name="foot:right"/>
    <field labelOnTop="0" name="footway"/>
    <field labelOnTop="0" name="footway:right"/>
    <field labelOnTop="0" name="footway:right:smoothness"/>
    <field labelOnTop="0" name="footway:right:surface"/>
    <field labelOnTop="0" name="footway:surface"/>
    <field labelOnTop="0" name="footway:width"/>
    <field labelOnTop="0" name="ford"/>
    <field labelOnTop="0" name="forestry"/>
    <field labelOnTop="0" name="frequency"/>
    <field labelOnTop="0" name="full_id"/>
    <field labelOnTop="0" name="gate"/>
    <field labelOnTop="0" name="gauge"/>
    <field labelOnTop="0" name="golf"/>
    <field labelOnTop="0" name="golf_cart"/>
    <field labelOnTop="0" name="goods"/>
    <field labelOnTop="0" name="handrail"/>
    <field labelOnTop="0" name="handrail:both"/>
    <field labelOnTop="0" name="handrail:center"/>
    <field labelOnTop="0" name="handrail:colour"/>
    <field labelOnTop="0" name="handrail:left"/>
    <field labelOnTop="0" name="handrail:middle"/>
    <field labelOnTop="0" name="handrail:right"/>
    <field labelOnTop="0" name="hazard"/>
    <field labelOnTop="0" name="hazard:conditional"/>
    <field labelOnTop="0" name="hazmat"/>
    <field labelOnTop="0" name="hazmat:backward"/>
    <field labelOnTop="0" name="hazmat:forward"/>
    <field labelOnTop="0" name="hazmat:water"/>
    <field labelOnTop="0" name="height"/>
    <field labelOnTop="0" name="heritage"/>
    <field labelOnTop="0" name="heritage:operator"/>
    <field labelOnTop="0" name="hgv"/>
    <field labelOnTop="0" name="hgv:backward"/>
    <field labelOnTop="0" name="hgv:conditional"/>
    <field labelOnTop="0" name="hgv:forward"/>
    <field labelOnTop="0" name="hgv:lanes"/>
    <field labelOnTop="0" name="hgv:lanes:forward:conditional"/>
    <field labelOnTop="0" name="highway"/>
    <field labelOnTop="0" name="highway:note"/>
    <field labelOnTop="0" name="historic"/>
    <field labelOnTop="0" name="horse"/>
    <field labelOnTop="0" name="horse_scale"/>
    <field labelOnTop="0" name="image"/>
    <field labelOnTop="0" name="incline"/>
    <field labelOnTop="0" name="incline:across"/>
    <field labelOnTop="0" name="incline_1"/>
    <field labelOnTop="0" name="indoor"/>
    <field labelOnTop="0" name="indoor_seating"/>
    <field labelOnTop="0" name="informal"/>
    <field labelOnTop="0" name="inline_skates"/>
    <field labelOnTop="0" name="inofficial"/>
    <field labelOnTop="0" name="int_ref"/>
    <field labelOnTop="0" name="intermittent"/>
    <field labelOnTop="0" name="internet_access:fee"/>
    <field labelOnTop="0" name="irregular:parking:left"/>
    <field labelOnTop="0" name="irregular:parking:left:orientation"/>
    <field labelOnTop="0" name="is_in"/>
    <field labelOnTop="0" name="is_in:city"/>
    <field labelOnTop="0" name="is_in:country_code"/>
    <field labelOnTop="0" name="is_sidepath"/>
    <field labelOnTop="0" name="is_sidepath:of"/>
    <field labelOnTop="0" name="is_sidepath:of:name"/>
    <field labelOnTop="0" name="is_sidepath:of:ref"/>
    <field labelOnTop="0" name="junction"/>
    <field labelOnTop="0" name="kerb"/>
    <field labelOnTop="0" name="kerb:approach_aid"/>
    <field labelOnTop="0" name="kerb:left"/>
    <field labelOnTop="0" name="kerb:right"/>
    <field labelOnTop="0" name="ladder"/>
    <field labelOnTop="0" name="lane_markings"/>
    <field labelOnTop="0" name="lanes"/>
    <field labelOnTop="0" name="lanes:backward"/>
    <field labelOnTop="0" name="lanes:both_ways"/>
    <field labelOnTop="0" name="lanes:bus"/>
    <field labelOnTop="0" name="lanes:bus:backward"/>
    <field labelOnTop="0" name="lanes:bus:forward"/>
    <field labelOnTop="0" name="lanes:forward"/>
    <field labelOnTop="0" name="lanes:psv"/>
    <field labelOnTop="0" name="lanes:psv:backward"/>
    <field labelOnTop="0" name="lanes:psv:forward"/>
    <field labelOnTop="0" name="last_check"/>
    <field labelOnTop="0" name="last_checked"/>
    <field labelOnTop="0" name="layer"/>
    <field labelOnTop="0" name="lcn"/>
    <field labelOnTop="0" name="left"/>
    <field labelOnTop="0" name="length"/>
    <field labelOnTop="0" name="level"/>
    <field labelOnTop="0" name="lfd:criteria"/>
    <field labelOnTop="0" name="lighting"/>
    <field labelOnTop="0" name="lit"/>
    <field labelOnTop="0" name="lit:note"/>
    <field labelOnTop="0" name="lit_by_gaslight"/>
    <field labelOnTop="0" name="lit_by_gaslight:left"/>
    <field labelOnTop="0" name="lit_by_gaslight:right"/>
    <field labelOnTop="0" name="lit_by_led"/>
    <field labelOnTop="0" name="living_street"/>
    <field labelOnTop="0" name="loc_name"/>
    <field labelOnTop="0" name="loc_ref"/>
    <field labelOnTop="0" name="local_ref"/>
    <field labelOnTop="0" name="location"/>
    <field labelOnTop="0" name="long_name"/>
    <field labelOnTop="0" name="lwn"/>
    <field labelOnTop="0" name="man_made"/>
    <field labelOnTop="0" name="manufacturer"/>
    <field labelOnTop="0" name="mapillary"/>
    <field labelOnTop="0" name="material"/>
    <field labelOnTop="0" name="maxaxleload"/>
    <field labelOnTop="0" name="maxheight"/>
    <field labelOnTop="0" name="maxheight:lanes"/>
    <field labelOnTop="0" name="maxheight:physical"/>
    <field labelOnTop="0" name="maxheight:signed"/>
    <field labelOnTop="0" name="maxlength"/>
    <field labelOnTop="0" name="maxspeed"/>
    <field labelOnTop="0" name="maxspeed:advisory:variable"/>
    <field labelOnTop="0" name="maxspeed:backward"/>
    <field labelOnTop="0" name="maxspeed:backward:conditional"/>
    <field labelOnTop="0" name="maxspeed:bicycle"/>
    <field labelOnTop="0" name="maxspeed:conditional"/>
    <field labelOnTop="0" name="maxspeed:destination"/>
    <field labelOnTop="0" name="maxspeed:forward"/>
    <field labelOnTop="0" name="maxspeed:forward:conditional"/>
    <field labelOnTop="0" name="maxspeed:hgv"/>
    <field labelOnTop="0" name="maxspeed:hgv:backward"/>
    <field labelOnTop="0" name="maxspeed:hgv:conditional"/>
    <field labelOnTop="0" name="maxspeed:hgv:forward"/>
    <field labelOnTop="0" name="maxspeed:lanes:forward"/>
    <field labelOnTop="0" name="maxspeed:max"/>
    <field labelOnTop="0" name="maxspeed:note"/>
    <field labelOnTop="0" name="maxspeed:practical"/>
    <field labelOnTop="0" name="maxspeed:source"/>
    <field labelOnTop="0" name="maxspeed:type"/>
    <field labelOnTop="0" name="maxspeed:type:backward"/>
    <field labelOnTop="0" name="maxspeed:variable"/>
    <field labelOnTop="0" name="maxstay"/>
    <field labelOnTop="0" name="maxweight"/>
    <field labelOnTop="0" name="maxweight:agricultural"/>
    <field labelOnTop="0" name="maxweight:backward"/>
    <field labelOnTop="0" name="maxweight:conditional"/>
    <field labelOnTop="0" name="maxweight:delivery"/>
    <field labelOnTop="0" name="maxweight:destination"/>
    <field labelOnTop="0" name="maxweight:forward"/>
    <field labelOnTop="0" name="maxweight:hgv"/>
    <field labelOnTop="0" name="maxweight:lanes"/>
    <field labelOnTop="0" name="maxweight:psv"/>
    <field labelOnTop="0" name="maxweight:signed"/>
    <field labelOnTop="0" name="maxweightrating"/>
    <field labelOnTop="0" name="maxweightrating:hgv"/>
    <field labelOnTop="0" name="maxwidth"/>
    <field labelOnTop="0" name="maxwidth:lanes"/>
    <field labelOnTop="0" name="maxwidth:lanes:backward"/>
    <field labelOnTop="0" name="maxwidth:lanes:forward"/>
    <field labelOnTop="0" name="maxwidth:physical"/>
    <field labelOnTop="0" name="mlc"/>
    <field labelOnTop="0" name="mlc:oneway"/>
    <field labelOnTop="0" name="mlc:tracked"/>
    <field labelOnTop="0" name="mlc:tracked_oneway"/>
    <field labelOnTop="0" name="mlc:wheeled"/>
    <field labelOnTop="0" name="mlc:wheeled_oneway"/>
    <field labelOnTop="0" name="motor_vehicle"/>
    <field labelOnTop="0" name="motor_vehicle:backward"/>
    <field labelOnTop="0" name="motor_vehicle:conditional"/>
    <field labelOnTop="0" name="motor_vehicle:forward"/>
    <field labelOnTop="0" name="motor_vehicle:lanes:backward"/>
    <field labelOnTop="0" name="motor_vehicle:lanes:forward"/>
    <field labelOnTop="0" name="motorcar"/>
    <field labelOnTop="0" name="motorcycle"/>
    <field labelOnTop="0" name="motorcycle:forward"/>
    <field labelOnTop="0" name="motorhome"/>
    <field labelOnTop="0" name="motorhome:backward"/>
    <field labelOnTop="0" name="motorhome:forward"/>
    <field labelOnTop="0" name="motorroad"/>
    <field labelOnTop="0" name="mtb"/>
    <field labelOnTop="0" name="mtb:description"/>
    <field labelOnTop="0" name="mtb:name"/>
    <field labelOnTop="0" name="mtb:scale"/>
    <field labelOnTop="0" name="mtb:scale:imba"/>
    <field labelOnTop="0" name="mtb:scale:uphill"/>
    <field labelOnTop="0" name="mtb:type"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="name:ar"/>
    <field labelOnTop="0" name="name:be"/>
    <field labelOnTop="0" name="name:de"/>
    <field labelOnTop="0" name="name:es"/>
    <field labelOnTop="0" name="name:etymology"/>
    <field labelOnTop="0" name="name:etymology:wikidata"/>
    <field labelOnTop="0" name="name:etymology:wikipedia"/>
    <field labelOnTop="0" name="name:hsb"/>
    <field labelOnTop="0" name="name:left"/>
    <field labelOnTop="0" name="name:right"/>
    <field labelOnTop="0" name="narrow"/>
    <field labelOnTop="0" name="natural"/>
    <field labelOnTop="0" name="ncn_ref"/>
    <field labelOnTop="0" name="network"/>
    <field labelOnTop="0" name="network:short"/>
    <field labelOnTop="0" name="network:wikidata"/>
    <field labelOnTop="0" name="network:wikipedia"/>
    <field labelOnTop="0" name="noexit"/>
    <field labelOnTop="0" name="noise_barrier"/>
    <field labelOnTop="0" name="noname"/>
    <field labelOnTop="0" name="note:access"/>
    <field labelOnTop="0" name="note:bicycle"/>
    <field labelOnTop="0" name="note:de"/>
    <field labelOnTop="0" name="note:lanes"/>
    <field labelOnTop="0" name="note:lit"/>
    <field labelOnTop="0" name="note:maxheight"/>
    <field labelOnTop="0" name="note:maxspeed"/>
    <field labelOnTop="0" name="note:name"/>
    <field labelOnTop="0" name="note:surface"/>
    <field labelOnTop="0" name="note_2"/>
    <field labelOnTop="0" name="obstacle"/>
    <field labelOnTop="0" name="obstacle:wheelchair"/>
    <field labelOnTop="0" name="old_name"/>
    <field labelOnTop="0" name="old_name:1876-1937"/>
    <field labelOnTop="0" name="old_name:1897"/>
    <field labelOnTop="0" name="old_name:1926-1948"/>
    <field labelOnTop="0" name="old_name:1937-1945"/>
    <field labelOnTop="0" name="old_name:1948-1993"/>
    <field labelOnTop="0" name="old_name:196X-1993"/>
    <field labelOnTop="0" name="old_ref"/>
    <field labelOnTop="0" name="oneway"/>
    <field labelOnTop="0" name="oneway:agricultural"/>
    <field labelOnTop="0" name="oneway:bicycle"/>
    <field labelOnTop="0" name="oneway:bus"/>
    <field labelOnTop="0" name="oneway:conditional"/>
    <field labelOnTop="0" name="oneway:foot"/>
    <field labelOnTop="0" name="oneway:psv"/>
    <field labelOnTop="0" name="opening_date"/>
    <field labelOnTop="0" name="opening_hours"/>
    <field labelOnTop="0" name="operator"/>
    <field labelOnTop="0" name="operator:type"/>
    <field labelOnTop="0" name="osm_id"/>
    <field labelOnTop="0" name="osm_type"/>
    <field labelOnTop="0" name="osmc:symbol"/>
    <field labelOnTop="0" name="other_tags"/>
    <field labelOnTop="0" name="overtaking"/>
    <field labelOnTop="0" name="overtaking:backward"/>
    <field labelOnTop="0" name="overtaking:forward"/>
    <field labelOnTop="0" name="overtaking:hgv:backward"/>
    <field labelOnTop="0" name="overtaking:hgv:forward"/>
    <field labelOnTop="0" name="parking"/>
    <field labelOnTop="0" name="parking:both"/>
    <field labelOnTop="0" name="parking:both:fee"/>
    <field labelOnTop="0" name="parking:both:fee:conditional"/>
    <field labelOnTop="0" name="parking:both:markings"/>
    <field labelOnTop="0" name="parking:both:orientation"/>
    <field labelOnTop="0" name="parking:both:reason"/>
    <field labelOnTop="0" name="parking:both:restriction"/>
    <field labelOnTop="0" name="parking:both:staggered"/>
    <field labelOnTop="0" name="parking:condition"/>
    <field labelOnTop="0" name="parking:condition:both"/>
    <field labelOnTop="0" name="parking:condition:both:conditional"/>
    <field labelOnTop="0" name="parking:condition:both:customers"/>
    <field labelOnTop="0" name="parking:condition:both:default"/>
    <field labelOnTop="0" name="parking:condition:both:maxstay"/>
    <field labelOnTop="0" name="parking:condition:both:residents"/>
    <field labelOnTop="0" name="parking:condition:both:time_interval"/>
    <field labelOnTop="0" name="parking:condition:both:vehicles"/>
    <field labelOnTop="0" name="parking:condition:left"/>
    <field labelOnTop="0" name="parking:condition:left:capacity"/>
    <field labelOnTop="0" name="parking:condition:left:capacity:disabled"/>
    <field labelOnTop="0" name="parking:condition:left:conditional"/>
    <field labelOnTop="0" name="parking:condition:left:default"/>
    <field labelOnTop="0" name="parking:condition:left:maxstay"/>
    <field labelOnTop="0" name="parking:condition:left:residents"/>
    <field labelOnTop="0" name="parking:condition:left:time_interval"/>
    <field labelOnTop="0" name="parking:condition:left:vehicles"/>
    <field labelOnTop="0" name="parking:condition:maxstay"/>
    <field labelOnTop="0" name="parking:condition:right"/>
    <field labelOnTop="0" name="parking:condition:right:capacity"/>
    <field labelOnTop="0" name="parking:condition:right:capacity:disabled"/>
    <field labelOnTop="0" name="parking:condition:right:default"/>
    <field labelOnTop="0" name="parking:condition:right:disabled"/>
    <field labelOnTop="0" name="parking:condition:right:maxstay"/>
    <field labelOnTop="0" name="parking:condition:right:residents"/>
    <field labelOnTop="0" name="parking:condition:right:time_interval"/>
    <field labelOnTop="0" name="parking:condition:right:vehicles"/>
    <field labelOnTop="0" name="parking:lane"/>
    <field labelOnTop="0" name="parking:lane:both"/>
    <field labelOnTop="0" name="parking:lane:both:diagonal"/>
    <field labelOnTop="0" name="parking:lane:both:parallel"/>
    <field labelOnTop="0" name="parking:lane:both:perpendicular"/>
    <field labelOnTop="0" name="parking:lane:disabled"/>
    <field labelOnTop="0" name="parking:lane:forward"/>
    <field labelOnTop="0" name="parking:lane:left"/>
    <field labelOnTop="0" name="parking:lane:left:capacity"/>
    <field labelOnTop="0" name="parking:lane:left:diagonal"/>
    <field labelOnTop="0" name="parking:lane:left:maxstay"/>
    <field labelOnTop="0" name="parking:lane:left:parallel"/>
    <field labelOnTop="0" name="parking:lane:left:perpendicular"/>
    <field labelOnTop="0" name="parking:lane:left:surface"/>
    <field labelOnTop="0" name="parking:lane:right"/>
    <field labelOnTop="0" name="parking:lane:right:capacity"/>
    <field labelOnTop="0" name="parking:lane:right:diagonal"/>
    <field labelOnTop="0" name="parking:lane:right:parallel"/>
    <field labelOnTop="0" name="parking:lane:right:perpendicular"/>
    <field labelOnTop="0" name="parking:lane:right:surface"/>
    <field labelOnTop="0" name="parking:lanes:left"/>
    <field labelOnTop="0" name="parking:lanes:right"/>
    <field labelOnTop="0" name="parking:left"/>
    <field labelOnTop="0" name="parking:left:access"/>
    <field labelOnTop="0" name="parking:left:authentication:disc:conditional"/>
    <field labelOnTop="0" name="parking:left:fee"/>
    <field labelOnTop="0" name="parking:left:markings"/>
    <field labelOnTop="0" name="parking:left:maxstay:conditional"/>
    <field labelOnTop="0" name="parking:left:orientation"/>
    <field labelOnTop="0" name="parking:left:parallel"/>
    <field labelOnTop="0" name="parking:left:perpendicular"/>
    <field labelOnTop="0" name="parking:left:reason"/>
    <field labelOnTop="0" name="parking:left:restriction"/>
    <field labelOnTop="0" name="parking:left:restriction:conditional"/>
    <field labelOnTop="0" name="parking:left:restriction:reason"/>
    <field labelOnTop="0" name="parking:left:staggered"/>
    <field labelOnTop="0" name="parking:right"/>
    <field labelOnTop="0" name="parking:right:access"/>
    <field labelOnTop="0" name="parking:right:access:conditional"/>
    <field labelOnTop="0" name="parking:right:authentication:disc:conditional"/>
    <field labelOnTop="0" name="parking:right:authentication:ticket"/>
    <field labelOnTop="0" name="parking:right:fee"/>
    <field labelOnTop="0" name="parking:right:markings"/>
    <field labelOnTop="0" name="parking:right:maxstay:conditional"/>
    <field labelOnTop="0" name="parking:right:orientation"/>
    <field labelOnTop="0" name="parking:right:perpendicular"/>
    <field labelOnTop="0" name="parking:right:reason"/>
    <field labelOnTop="0" name="parking:right:restriction"/>
    <field labelOnTop="0" name="parking:right:restriction:conditional"/>
    <field labelOnTop="0" name="parking:right:restriction:reason"/>
    <field labelOnTop="0" name="parking:right:surface"/>
    <field labelOnTop="0" name="parking_lane:both"/>
    <field labelOnTop="0" name="passage_type"/>
    <field labelOnTop="0" name="passenger_information_display"/>
    <field labelOnTop="0" name="passenger_information_display:speech_output"/>
    <field labelOnTop="0" name="passing_places"/>
    <field labelOnTop="0" name="path"/>
    <field labelOnTop="0" name="pathtype"/>
    <field labelOnTop="0" name="paving_stones:size"/>
    <field labelOnTop="0" name="piste:difficulty"/>
    <field labelOnTop="0" name="piste:grooming"/>
    <field labelOnTop="0" name="piste:type"/>
    <field labelOnTop="0" name="placement"/>
    <field labelOnTop="0" name="placement:backward"/>
    <field labelOnTop="0" name="placement:forward"/>
    <field labelOnTop="0" name="planned"/>
    <field labelOnTop="0" name="platform_lift"/>
    <field labelOnTop="0" name="playground"/>
    <field labelOnTop="0" name="postal_code"/>
    <field labelOnTop="0" name="priority"/>
    <field labelOnTop="0" name="priority_road"/>
    <field labelOnTop="0" name="priority_road:backward"/>
    <field labelOnTop="0" name="priority_road:forward"/>
    <field labelOnTop="0" name="private"/>
    <field labelOnTop="0" name="proposed"/>
    <field labelOnTop="0" name="psv"/>
    <field labelOnTop="0" name="psv:backward"/>
    <field labelOnTop="0" name="psv:lanes"/>
    <field labelOnTop="0" name="psv:lanes:backward"/>
    <field labelOnTop="0" name="psv:lanes:forward"/>
    <field labelOnTop="0" name="public_transport"/>
    <field labelOnTop="0" name="qr_code"/>
    <field labelOnTop="0" name="railway"/>
    <field labelOnTop="0" name="railway:preferred_direction"/>
    <field labelOnTop="0" name="railway:traffic_mode"/>
    <field labelOnTop="0" name="ramp"/>
    <field labelOnTop="0" name="ramp:bicycle"/>
    <field labelOnTop="0" name="ramp:luggage"/>
    <field labelOnTop="0" name="ramp:stroller"/>
    <field labelOnTop="0" name="ramp:wheelchair"/>
    <field labelOnTop="0" name="razed:bridge"/>
    <field labelOnTop="0" name="razed:railway"/>
    <field labelOnTop="0" name="red_turn:left"/>
    <field labelOnTop="0" name="red_turn:right"/>
    <field labelOnTop="0" name="ref"/>
    <field labelOnTop="0" name="ref:IFOPT"/>
    <field labelOnTop="0" name="ref:IFOPT:description"/>
    <field labelOnTop="0" name="ref:VVO"/>
    <field labelOnTop="0" name="ref:lfd"/>
    <field labelOnTop="0" name="ref:manufacturer_inventory"/>
    <field labelOnTop="0" name="ref:operator_inventory"/>
    <field labelOnTop="0" name="ref_name"/>
    <field labelOnTop="0" name="reg_name"/>
    <field labelOnTop="0" name="render"/>
    <field labelOnTop="0" name="repeat_on"/>
    <field labelOnTop="0" name="roof"/>
    <field labelOnTop="0" name="roof:edge"/>
    <field labelOnTop="0" name="roof:levels"/>
    <field labelOnTop="0" name="roof:shape"/>
    <field labelOnTop="0" name="room"/>
    <field labelOnTop="0" name="route"/>
    <field labelOnTop="0" name="route_ref"/>
    <field labelOnTop="0" name="ruins"/>
    <field labelOnTop="0" name="sac_scale"/>
    <field labelOnTop="0" name="segregated"/>
    <field labelOnTop="0" name="service"/>
    <field labelOnTop="0" name="shelter"/>
    <field labelOnTop="0" name="short_name"/>
    <field labelOnTop="0" name="shoulder"/>
    <field labelOnTop="0" name="shoulder:right"/>
    <field labelOnTop="0" name="side"/>
    <field labelOnTop="0" name="sideincline"/>
    <field labelOnTop="0" name="sidewalk"/>
    <field labelOnTop="0" name="sidewalk:bicycle"/>
    <field labelOnTop="0" name="sidewalk:both"/>
    <field labelOnTop="0" name="sidewalk:both:bicycle"/>
    <field labelOnTop="0" name="sidewalk:both:foot"/>
    <field labelOnTop="0" name="sidewalk:both:smoothness"/>
    <field labelOnTop="0" name="sidewalk:both:surface"/>
    <field labelOnTop="0" name="sidewalk:both:traffic_sign"/>
    <field labelOnTop="0" name="sidewalk:foot"/>
    <field labelOnTop="0" name="sidewalk:left"/>
    <field labelOnTop="0" name="sidewalk:left:bicycle"/>
    <field labelOnTop="0" name="sidewalk:left:bicycle:backward"/>
    <field labelOnTop="0" name="sidewalk:left:bicycle:forward"/>
    <field labelOnTop="0" name="sidewalk:left:bicycle:maxspeed:backward"/>
    <field labelOnTop="0" name="sidewalk:left:description:de"/>
    <field labelOnTop="0" name="sidewalk:left:description:en"/>
    <field labelOnTop="0" name="sidewalk:left:est_width"/>
    <field labelOnTop="0" name="sidewalk:left:foot"/>
    <field labelOnTop="0" name="sidewalk:left:incline"/>
    <field labelOnTop="0" name="sidewalk:left:kerb"/>
    <field labelOnTop="0" name="sidewalk:left:oneway"/>
    <field labelOnTop="0" name="sidewalk:left:smoothness"/>
    <field labelOnTop="0" name="sidewalk:left:surface"/>
    <field labelOnTop="0" name="sidewalk:left:traffic_sign"/>
    <field labelOnTop="0" name="sidewalk:left:width"/>
    <field labelOnTop="0" name="sidewalk:oneway"/>
    <field labelOnTop="0" name="sidewalk:right"/>
    <field labelOnTop="0" name="sidewalk:right:bicycle"/>
    <field labelOnTop="0" name="sidewalk:right:bicycle:maxspeed"/>
    <field labelOnTop="0" name="sidewalk:right:bicycle:oneway"/>
    <field labelOnTop="0" name="sidewalk:right:description:de"/>
    <field labelOnTop="0" name="sidewalk:right:description:en"/>
    <field labelOnTop="0" name="sidewalk:right:est_width"/>
    <field labelOnTop="0" name="sidewalk:right:foot"/>
    <field labelOnTop="0" name="sidewalk:right:incline"/>
    <field labelOnTop="0" name="sidewalk:right:kerb"/>
    <field labelOnTop="0" name="sidewalk:right:oneway"/>
    <field labelOnTop="0" name="sidewalk:right:segregated"/>
    <field labelOnTop="0" name="sidewalk:right:smoothness"/>
    <field labelOnTop="0" name="sidewalk:right:surface"/>
    <field labelOnTop="0" name="sidewalk:right:surface:note"/>
    <field labelOnTop="0" name="sidewalk:right:traffic_sign"/>
    <field labelOnTop="0" name="sidewalk:right:width"/>
    <field labelOnTop="0" name="sidewalk:smoothness"/>
    <field labelOnTop="0" name="sidewalk:surface"/>
    <field labelOnTop="0" name="sidewalk:traffic_sign"/>
    <field labelOnTop="0" name="sideway"/>
    <field labelOnTop="0" name="ski"/>
    <field labelOnTop="0" name="sloped_curb"/>
    <field labelOnTop="0" name="smoking"/>
    <field labelOnTop="0" name="smoothness"/>
    <field labelOnTop="0" name="smoothness:backward"/>
    <field labelOnTop="0" name="smoothness:forward"/>
    <field labelOnTop="0" name="snowmobile"/>
    <field labelOnTop="0" name="source:access"/>
    <field labelOnTop="0" name="source:alt_name"/>
    <field labelOnTop="0" name="source:cycleway:width"/>
    <field labelOnTop="0" name="source:destination"/>
    <field labelOnTop="0" name="source:geometry"/>
    <field labelOnTop="0" name="source:incline"/>
    <field labelOnTop="0" name="source:lit"/>
    <field labelOnTop="0" name="source:maxheight"/>
    <field labelOnTop="0" name="source:maxspeed"/>
    <field labelOnTop="0" name="source:maxspeed:backward"/>
    <field labelOnTop="0" name="source:maxspeed:conditional"/>
    <field labelOnTop="0" name="source:maxspeed:forward"/>
    <field labelOnTop="0" name="source:maxspeed:hgv"/>
    <field labelOnTop="0" name="source:maxweight"/>
    <field labelOnTop="0" name="source:maxwidth"/>
    <field labelOnTop="0" name="source:name"/>
    <field labelOnTop="0" name="source:offset"/>
    <field labelOnTop="0" name="source:old_name"/>
    <field labelOnTop="0" name="source:oneway"/>
    <field labelOnTop="0" name="source:outline"/>
    <field labelOnTop="0" name="source:reg_name"/>
    <field labelOnTop="0" name="source:width"/>
    <field labelOnTop="0" name="speech_output"/>
    <field labelOnTop="0" name="speech_output:de"/>
    <field labelOnTop="0" name="sport"/>
    <field labelOnTop="0" name="stairs"/>
    <field labelOnTop="0" name="start_date"/>
    <field labelOnTop="0" name="step.condition"/>
    <field labelOnTop="0" name="step.height"/>
    <field labelOnTop="0" name="step.length"/>
    <field labelOnTop="0" name="step:height"/>
    <field labelOnTop="0" name="step:length"/>
    <field labelOnTop="0" name="step_count"/>
    <field labelOnTop="0" name="steps"/>
    <field labelOnTop="0" name="stone"/>
    <field labelOnTop="0" name="stroller"/>
    <field labelOnTop="0" name="subject:wikidata"/>
    <field labelOnTop="0" name="supervised"/>
    <field labelOnTop="0" name="support"/>
    <field labelOnTop="0" name="surface"/>
    <field labelOnTop="0" name="surface:backward"/>
    <field labelOnTop="0" name="surface:colour"/>
    <field labelOnTop="0" name="surface:comment"/>
    <field labelOnTop="0" name="surface:de"/>
    <field labelOnTop="0" name="surface:forward"/>
    <field labelOnTop="0" name="surface:lanes:backward"/>
    <field labelOnTop="0" name="surface:lanes:forward"/>
    <field labelOnTop="0" name="surface:left"/>
    <field labelOnTop="0" name="surface:middle"/>
    <field labelOnTop="0" name="surface:note"/>
    <field labelOnTop="0" name="surface:paved"/>
    <field labelOnTop="0" name="surface:right"/>
    <field labelOnTop="0" name="surface_material"/>
    <field labelOnTop="0" name="survey:date"/>
    <field labelOnTop="0" name="symbol"/>
    <field labelOnTop="0" name="tactile_paving"/>
    <field labelOnTop="0" name="tactile_paving:end"/>
    <field labelOnTop="0" name="tactile_paving:start"/>
    <field labelOnTop="0" name="tactile_writing"/>
    <field labelOnTop="0" name="tactile_writing:braille:de"/>
    <field labelOnTop="0" name="tactile_writing:engraved_printed_letters:de"/>
    <field labelOnTop="0" name="tags"/>
    <field labelOnTop="0" name="taxi"/>
    <field labelOnTop="0" name="taxi:lanes"/>
    <field labelOnTop="0" name="temporary:access"/>
    <field labelOnTop="0" name="temporary:date_off"/>
    <field labelOnTop="0" name="temporary:date_on"/>
    <field labelOnTop="0" name="toilets"/>
    <field labelOnTop="0" name="toll"/>
    <field labelOnTop="0" name="toll:N3"/>
    <field labelOnTop="0" name="tourism"/>
    <field labelOnTop="0" name="tourist_bus"/>
    <field labelOnTop="0" name="tracktype"/>
    <field labelOnTop="0" name="traffic_calming"/>
    <field labelOnTop="0" name="traffic_sign"/>
    <field labelOnTop="0" name="traffic_sign:backward"/>
    <field labelOnTop="0" name="traffic_sign:forward"/>
    <field labelOnTop="0" name="traffic_signals:direction"/>
    <field labelOnTop="0" name="trail_visibility"/>
    <field labelOnTop="0" name="tram"/>
    <field labelOnTop="0" name="tree_lined"/>
    <field labelOnTop="0" name="tree_lined:both:taxon"/>
    <field labelOnTop="0" name="trolley_wire"/>
    <field labelOnTop="0" name="truck"/>
    <field labelOnTop="0" name="tunnel"/>
    <field labelOnTop="0" name="tunnel:name"/>
    <field labelOnTop="0" name="turn"/>
    <field labelOnTop="0" name="turn:backward"/>
    <field labelOnTop="0" name="turn:bicycle:lanes:backward"/>
    <field labelOnTop="0" name="turn:forward"/>
    <field labelOnTop="0" name="turn:lanes"/>
    <field labelOnTop="0" name="turn:lanes:backward"/>
    <field labelOnTop="0" name="turn:lanes:both_ways"/>
    <field labelOnTop="0" name="turn:lanes:forward"/>
    <field labelOnTop="0" name="type"/>
    <field labelOnTop="0" name="uic_ref"/>
    <field labelOnTop="0" name="unsigned_ref"/>
    <field labelOnTop="0" name="url"/>
    <field labelOnTop="0" name="usability:skate"/>
    <field labelOnTop="0" name="usage"/>
    <field labelOnTop="0" name="vehicle"/>
    <field labelOnTop="0" name="vehicle:backward"/>
    <field labelOnTop="0" name="vehicle:conditional"/>
    <field labelOnTop="0" name="vehicle:disabled"/>
    <field labelOnTop="0" name="vehicle:forward"/>
    <field labelOnTop="0" name="vehicle:forward:conditional"/>
    <field labelOnTop="0" name="vehicle:lanes"/>
    <field labelOnTop="0" name="vehicle:lanes:backward"/>
    <field labelOnTop="0" name="vehicle:lanes:forward"/>
    <field labelOnTop="0" name="via_ferrata_scale"/>
    <field labelOnTop="0" name="virtual:highway"/>
    <field labelOnTop="0" name="visibility"/>
    <field labelOnTop="0" name="voltage"/>
    <field labelOnTop="0" name="vvo-id"/>
    <field labelOnTop="0" name="warning_light"/>
    <field labelOnTop="0" name="waste_basket"/>
    <field labelOnTop="0" name="waterway"/>
    <field labelOnTop="0" name="website"/>
    <field labelOnTop="0" name="wheelchair"/>
    <field labelOnTop="0" name="wheelchair:description"/>
    <field labelOnTop="0" name="wheelchair:description:de"/>
    <field labelOnTop="0" name="whitewater"/>
    <field labelOnTop="0" name="width"/>
    <field labelOnTop="0" name="width:bicycle"/>
    <field labelOnTop="0" name="width:comment"/>
    <field labelOnTop="0" name="width:lanes"/>
    <field labelOnTop="0" name="width:lanes:backward"/>
    <field labelOnTop="0" name="width:lanes:forward"/>
    <field labelOnTop="0" name="width_1"/>
    <field labelOnTop="0" name="wikidata"/>
    <field labelOnTop="0" name="wikidata:note"/>
    <field labelOnTop="0" name="wikimedia_commons"/>
    <field labelOnTop="0" name="wikipedia"/>
    <field labelOnTop="0" name="winter_service"/>
    <field labelOnTop="0" name="z_order"/>
    <field labelOnTop="0" name="zone:maxspeed"/>
    <field labelOnTop="0" name="zone:no_parking"/>
    <field labelOnTop="0" name="zone:parking"/>
    <field labelOnTop="0" name="zone:traffic"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="FIXME" reuseLastValue="0"/>
    <field name="FIXME:de" reuseLastValue="0"/>
    <field name="TMC:cid_58:tabcd_1:Class" reuseLastValue="0"/>
    <field name="TMC:cid_58:tabcd_1:LCLversion" reuseLastValue="0"/>
    <field name="TMC:cid_58:tabcd_1:LocationCode" reuseLastValue="0"/>
    <field name="TMC:cid_58:tabcd_1:NextLocationCode" reuseLastValue="0"/>
    <field name="TMC:cid_58:tabcd_1:PrevLocationCode" reuseLastValue="0"/>
    <field name="TODO" reuseLastValue="0"/>
    <field name="_uid_" reuseLastValue="0"/>
    <field name="abandoned" reuseLastValue="0"/>
    <field name="abandoned:railway" reuseLastValue="0"/>
    <field name="access" reuseLastValue="0"/>
    <field name="access:N3" reuseLastValue="0"/>
    <field name="access:backward" reuseLastValue="0"/>
    <field name="access:both_ways" reuseLastValue="0"/>
    <field name="access:conditional" reuseLastValue="0"/>
    <field name="access:lanes" reuseLastValue="0"/>
    <field name="access:lanes:backward" reuseLastValue="0"/>
    <field name="access:lanes:forward" reuseLastValue="0"/>
    <field name="access:lanes:note" reuseLastValue="0"/>
    <field name="access_ramp" reuseLastValue="0"/>
    <field name="aerialway" reuseLastValue="0"/>
    <field name="agricultural" reuseLastValue="0"/>
    <field name="alt_name" reuseLastValue="0"/>
    <field name="ambulance" reuseLastValue="0"/>
    <field name="amenity" reuseLastValue="0"/>
    <field name="arcade:left" reuseLastValue="0"/>
    <field name="arcade:right" reuseLastValue="0"/>
    <field name="area" reuseLastValue="0"/>
    <field name="ascent" reuseLastValue="0"/>
    <field name="barrier" reuseLastValue="0"/>
    <field name="bdouble" reuseLastValue="0"/>
    <field name="bench" reuseLastValue="0"/>
    <field name="bicycle" reuseLastValue="0"/>
    <field name="bicycle:backward" reuseLastValue="0"/>
    <field name="bicycle:conditional" reuseLastValue="0"/>
    <field name="bicycle:forward" reuseLastValue="0"/>
    <field name="bicycle:lanes" reuseLastValue="0"/>
    <field name="bicycle:lanes:backward" reuseLastValue="0"/>
    <field name="bicycle:lanes:forward" reuseLastValue="0"/>
    <field name="bicycle:left" reuseLastValue="0"/>
    <field name="bicycle:note" reuseLastValue="0"/>
    <field name="bicycle:oneway" reuseLastValue="0"/>
    <field name="bicycle:right" reuseLastValue="0"/>
    <field name="bicycle_parking" reuseLastValue="0"/>
    <field name="bicycle_road" reuseLastValue="0"/>
    <field name="bin" reuseLastValue="0"/>
    <field name="brand" reuseLastValue="0"/>
    <field name="bridge" reuseLastValue="0"/>
    <field name="bridge:material" reuseLastValue="0"/>
    <field name="bridge:name" reuseLastValue="0"/>
    <field name="bridge:ref" reuseLastValue="0"/>
    <field name="bridge:structure" reuseLastValue="0"/>
    <field name="building:material" reuseLastValue="0"/>
    <field name="bus" reuseLastValue="0"/>
    <field name="bus:lanes" reuseLastValue="0"/>
    <field name="bus:lanes:backward" reuseLastValue="0"/>
    <field name="bus:lanes:forward" reuseLastValue="0"/>
    <field name="bus_bay" reuseLastValue="0"/>
    <field name="bus_bay:left" reuseLastValue="0"/>
    <field name="busway" reuseLastValue="0"/>
    <field name="busway:left" reuseLastValue="0"/>
    <field name="busway:right" reuseLastValue="0"/>
    <field name="button_operated" reuseLastValue="0"/>
    <field name="capacity:police" reuseLastValue="0"/>
    <field name="caravan" reuseLastValue="0"/>
    <field name="carriage" reuseLastValue="0"/>
    <field name="category" reuseLastValue="0"/>
    <field name="change:backward" reuseLastValue="0"/>
    <field name="change:both_ways" reuseLastValue="0"/>
    <field name="change:forward" reuseLastValue="0"/>
    <field name="change:lanes" reuseLastValue="0"/>
    <field name="change:lanes:backward" reuseLastValue="0"/>
    <field name="change:lanes:forward" reuseLastValue="0"/>
    <field name="check_date" reuseLastValue="0"/>
    <field name="check_date:bench" reuseLastValue="0"/>
    <field name="check_date:bicycle" reuseLastValue="0"/>
    <field name="check_date:cycleway" reuseLastValue="0"/>
    <field name="check_date:cycleway:surface" reuseLastValue="0"/>
    <field name="check_date:handrail" reuseLastValue="0"/>
    <field name="check_date:lit" reuseLastValue="0"/>
    <field name="check_date:ramp" reuseLastValue="0"/>
    <field name="check_date:segregated" reuseLastValue="0"/>
    <field name="check_date:shelter" reuseLastValue="0"/>
    <field name="check_date:sidewalk" reuseLastValue="0"/>
    <field name="check_date:sidewalk:surface" reuseLastValue="0"/>
    <field name="check_date:smoothness" reuseLastValue="0"/>
    <field name="check_date:surface" reuseLastValue="0"/>
    <field name="check_date:tactile_paving" reuseLastValue="0"/>
    <field name="check_date:tracktype" reuseLastValue="0"/>
    <field name="checked_date" reuseLastValue="0"/>
    <field name="class:bicycle" reuseLastValue="0"/>
    <field name="class:bicycle:roadcycling" reuseLastValue="0"/>
    <field name="colonnade:left" reuseLastValue="0"/>
    <field name="colonnade:right" reuseLastValue="0"/>
    <field name="comment" reuseLastValue="0"/>
    <field name="comment:history" reuseLastValue="0"/>
    <field name="construction" reuseLastValue="0"/>
    <field name="construction:highway" reuseLastValue="0"/>
    <field name="contrastive_stripes" reuseLastValue="0"/>
    <field name="contrastive_stripes:all" reuseLastValue="0"/>
    <field name="contrastive_stripes:end" reuseLastValue="0"/>
    <field name="contrastive_stripes:start" reuseLastValue="0"/>
    <field name="conveying" reuseLastValue="0"/>
    <field name="count" reuseLastValue="0"/>
    <field name="covered" reuseLastValue="0"/>
    <field name="crossing" reuseLastValue="0"/>
    <field name="crossing:island" reuseLastValue="0"/>
    <field name="crossing:markings" reuseLastValue="0"/>
    <field name="cutting" reuseLastValue="0"/>
    <field name="cyclestreet" reuseLastValue="0"/>
    <field name="cycleway" reuseLastValue="0"/>
    <field name="cycleway:backward" reuseLastValue="0"/>
    <field name="cycleway:bicycle" reuseLastValue="0"/>
    <field name="cycleway:both" reuseLastValue="0"/>
    <field name="cycleway:both:bicycle" reuseLastValue="0"/>
    <field name="cycleway:both:lane" reuseLastValue="0"/>
    <field name="cycleway:both:segregated" reuseLastValue="0"/>
    <field name="cycleway:both:traffic_sign" reuseLastValue="0"/>
    <field name="cycleway:both:width" reuseLastValue="0"/>
    <field name="cycleway:foot" reuseLastValue="0"/>
    <field name="cycleway:forward" reuseLastValue="0"/>
    <field name="cycleway:lane" reuseLastValue="0"/>
    <field name="cycleway:lanes" reuseLastValue="0"/>
    <field name="cycleway:left" reuseLastValue="0"/>
    <field name="cycleway:left:bicycle" reuseLastValue="0"/>
    <field name="cycleway:left:foot" reuseLastValue="0"/>
    <field name="cycleway:left:lane" reuseLastValue="0"/>
    <field name="cycleway:left:oneway" reuseLastValue="0"/>
    <field name="cycleway:left:oneway:bicycle" reuseLastValue="0"/>
    <field name="cycleway:left:segregated" reuseLastValue="0"/>
    <field name="cycleway:left:smoothness" reuseLastValue="0"/>
    <field name="cycleway:left:surface" reuseLastValue="0"/>
    <field name="cycleway:left:surface:colour" reuseLastValue="0"/>
    <field name="cycleway:left:traffic_sign" reuseLastValue="0"/>
    <field name="cycleway:oneway" reuseLastValue="0"/>
    <field name="cycleway:right" reuseLastValue="0"/>
    <field name="cycleway:right:bicycle" reuseLastValue="0"/>
    <field name="cycleway:right:foot" reuseLastValue="0"/>
    <field name="cycleway:right:lane" reuseLastValue="0"/>
    <field name="cycleway:right:oneway" reuseLastValue="0"/>
    <field name="cycleway:right:protection:left" reuseLastValue="0"/>
    <field name="cycleway:right:segregated" reuseLastValue="0"/>
    <field name="cycleway:right:smoothness" reuseLastValue="0"/>
    <field name="cycleway:right:surface" reuseLastValue="0"/>
    <field name="cycleway:right:surface:colour" reuseLastValue="0"/>
    <field name="cycleway:right:traffic_sign" reuseLastValue="0"/>
    <field name="cycleway:right:width" reuseLastValue="0"/>
    <field name="cycleway:segregated" reuseLastValue="0"/>
    <field name="cycleway:smoothness" reuseLastValue="0"/>
    <field name="cycleway:surface" reuseLastValue="0"/>
    <field name="cycleway:surface:colour" reuseLastValue="0"/>
    <field name="cycleway:traffic_sign" reuseLastValue="0"/>
    <field name="cycleway:width" reuseLastValue="0"/>
    <field name="delivery" reuseLastValue="0"/>
    <field name="demolished:highway" reuseLastValue="0"/>
    <field name="departures_board" reuseLastValue="0"/>
    <field name="description" reuseLastValue="0"/>
    <field name="description:de" reuseLastValue="0"/>
    <field name="description:en" reuseLastValue="0"/>
    <field name="designated" reuseLastValue="0"/>
    <field name="designation" reuseLastValue="0"/>
    <field name="destination" reuseLastValue="0"/>
    <field name="destination:arrow" reuseLastValue="0"/>
    <field name="destination:arrow:backward" reuseLastValue="0"/>
    <field name="destination:arrow:lanes" reuseLastValue="0"/>
    <field name="destination:arrow:lanes:backward" reuseLastValue="0"/>
    <field name="destination:arrow:lanes:forward" reuseLastValue="0"/>
    <field name="destination:arrow:to:lanes" reuseLastValue="0"/>
    <field name="destination:arrow:to:lanes:backward" reuseLastValue="0"/>
    <field name="destination:arrow:to:lanes:forward" reuseLastValue="0"/>
    <field name="destination:backward" reuseLastValue="0"/>
    <field name="destination:bicycle" reuseLastValue="0"/>
    <field name="destination:bicycle:backward" reuseLastValue="0"/>
    <field name="destination:bicycle:forward" reuseLastValue="0"/>
    <field name="destination:colour" reuseLastValue="0"/>
    <field name="destination:colour:backward" reuseLastValue="0"/>
    <field name="destination:colour:forward" reuseLastValue="0"/>
    <field name="destination:colour:lanes" reuseLastValue="0"/>
    <field name="destination:colour:lanes:backward" reuseLastValue="0"/>
    <field name="destination:colour:lanes:forward" reuseLastValue="0"/>
    <field name="destination:colour:to" reuseLastValue="0"/>
    <field name="destination:colour:to:forward" reuseLastValue="0"/>
    <field name="destination:country" reuseLastValue="0"/>
    <field name="destination:country:lanes" reuseLastValue="0"/>
    <field name="destination:distance:lanes:backward" reuseLastValue="0"/>
    <field name="destination:forward" reuseLastValue="0"/>
    <field name="destination:lanes" reuseLastValue="0"/>
    <field name="destination:lanes:backward" reuseLastValue="0"/>
    <field name="destination:lanes:forward" reuseLastValue="0"/>
    <field name="destination:ref" reuseLastValue="0"/>
    <field name="destination:ref:backward" reuseLastValue="0"/>
    <field name="destination:ref:forward" reuseLastValue="0"/>
    <field name="destination:ref:lanes" reuseLastValue="0"/>
    <field name="destination:ref:lanes:backward" reuseLastValue="0"/>
    <field name="destination:ref:lanes:forward" reuseLastValue="0"/>
    <field name="destination:ref:to" reuseLastValue="0"/>
    <field name="destination:ref:to:backward" reuseLastValue="0"/>
    <field name="destination:ref:to:forward" reuseLastValue="0"/>
    <field name="destination:ref:to:lanes" reuseLastValue="0"/>
    <field name="destination:ref:to:lanes:backward" reuseLastValue="0"/>
    <field name="destination:ref:to:lanes:forward" reuseLastValue="0"/>
    <field name="destination:street" reuseLastValue="0"/>
    <field name="destination:street:backward" reuseLastValue="0"/>
    <field name="destination:street:forward" reuseLastValue="0"/>
    <field name="destination:street:lanes" reuseLastValue="0"/>
    <field name="destination:symbol" reuseLastValue="0"/>
    <field name="destination:symbol:backward" reuseLastValue="0"/>
    <field name="destination:symbol:forward" reuseLastValue="0"/>
    <field name="destination:symbol:lanes" reuseLastValue="0"/>
    <field name="destination:symbol:lanes:backward" reuseLastValue="0"/>
    <field name="destination:symbol:lanes:forward" reuseLastValue="0"/>
    <field name="destination:symbol:to" reuseLastValue="0"/>
    <field name="destination:symbol:to:backward" reuseLastValue="0"/>
    <field name="destination:symbol:to:forward" reuseLastValue="0"/>
    <field name="destination:symbol:to:lanes" reuseLastValue="0"/>
    <field name="destination:symbol:to:lanes:backward" reuseLastValue="0"/>
    <field name="destination:symbol:to:lanes:forward" reuseLastValue="0"/>
    <field name="destination:to" reuseLastValue="0"/>
    <field name="destination:to:backward" reuseLastValue="0"/>
    <field name="destination:to:forward" reuseLastValue="0"/>
    <field name="destination:to:lanes" reuseLastValue="0"/>
    <field name="destination:to:lanes:backward" reuseLastValue="0"/>
    <field name="destination:to:lanes:forward" reuseLastValue="0"/>
    <field name="direction" reuseLastValue="0"/>
    <field name="direction:backward" reuseLastValue="0"/>
    <field name="direction:forward" reuseLastValue="0"/>
    <field name="dirtbike:scale" reuseLastValue="0"/>
    <field name="disabled" reuseLastValue="0"/>
    <field name="disused:highway" reuseLastValue="0"/>
    <field name="disused:railway" reuseLastValue="0"/>
    <field name="dog" reuseLastValue="0"/>
    <field name="dual_carriageway" reuseLastValue="0"/>
    <field name="ele" reuseLastValue="0"/>
    <field name="electrified" reuseLastValue="0"/>
    <field name="embankment" reuseLastValue="0"/>
    <field name="embedded_rails" reuseLastValue="0"/>
    <field name="embedded_rails:forward" reuseLastValue="0"/>
    <field name="emergency" reuseLastValue="0"/>
    <field name="end_date" reuseLastValue="0"/>
    <field name="est_length" reuseLastValue="0"/>
    <field name="est_width" reuseLastValue="0"/>
    <field name="fake_gaslight" reuseLastValue="0"/>
    <field name="fee" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="flat_steps" reuseLastValue="0"/>
    <field name="floating" reuseLastValue="0"/>
    <field name="flood_prone" reuseLastValue="0"/>
    <field name="foot" reuseLastValue="0"/>
    <field name="foot:backward" reuseLastValue="0"/>
    <field name="foot:conditional" reuseLastValue="0"/>
    <field name="foot:forward" reuseLastValue="0"/>
    <field name="foot:left" reuseLastValue="0"/>
    <field name="foot:right" reuseLastValue="0"/>
    <field name="footway" reuseLastValue="0"/>
    <field name="footway:right" reuseLastValue="0"/>
    <field name="footway:right:smoothness" reuseLastValue="0"/>
    <field name="footway:right:surface" reuseLastValue="0"/>
    <field name="footway:surface" reuseLastValue="0"/>
    <field name="footway:width" reuseLastValue="0"/>
    <field name="ford" reuseLastValue="0"/>
    <field name="forestry" reuseLastValue="0"/>
    <field name="frequency" reuseLastValue="0"/>
    <field name="full_id" reuseLastValue="0"/>
    <field name="gate" reuseLastValue="0"/>
    <field name="gauge" reuseLastValue="0"/>
    <field name="golf" reuseLastValue="0"/>
    <field name="golf_cart" reuseLastValue="0"/>
    <field name="goods" reuseLastValue="0"/>
    <field name="handrail" reuseLastValue="0"/>
    <field name="handrail:both" reuseLastValue="0"/>
    <field name="handrail:center" reuseLastValue="0"/>
    <field name="handrail:colour" reuseLastValue="0"/>
    <field name="handrail:left" reuseLastValue="0"/>
    <field name="handrail:middle" reuseLastValue="0"/>
    <field name="handrail:right" reuseLastValue="0"/>
    <field name="hazard" reuseLastValue="0"/>
    <field name="hazard:conditional" reuseLastValue="0"/>
    <field name="hazmat" reuseLastValue="0"/>
    <field name="hazmat:backward" reuseLastValue="0"/>
    <field name="hazmat:forward" reuseLastValue="0"/>
    <field name="hazmat:water" reuseLastValue="0"/>
    <field name="height" reuseLastValue="0"/>
    <field name="heritage" reuseLastValue="0"/>
    <field name="heritage:operator" reuseLastValue="0"/>
    <field name="hgv" reuseLastValue="0"/>
    <field name="hgv:backward" reuseLastValue="0"/>
    <field name="hgv:conditional" reuseLastValue="0"/>
    <field name="hgv:forward" reuseLastValue="0"/>
    <field name="hgv:lanes" reuseLastValue="0"/>
    <field name="hgv:lanes:forward:conditional" reuseLastValue="0"/>
    <field name="highway" reuseLastValue="0"/>
    <field name="highway:note" reuseLastValue="0"/>
    <field name="historic" reuseLastValue="0"/>
    <field name="horse" reuseLastValue="0"/>
    <field name="horse_scale" reuseLastValue="0"/>
    <field name="image" reuseLastValue="0"/>
    <field name="incline" reuseLastValue="0"/>
    <field name="incline:across" reuseLastValue="0"/>
    <field name="incline_1" reuseLastValue="0"/>
    <field name="indoor" reuseLastValue="0"/>
    <field name="indoor_seating" reuseLastValue="0"/>
    <field name="informal" reuseLastValue="0"/>
    <field name="inline_skates" reuseLastValue="0"/>
    <field name="inofficial" reuseLastValue="0"/>
    <field name="int_ref" reuseLastValue="0"/>
    <field name="intermittent" reuseLastValue="0"/>
    <field name="internet_access:fee" reuseLastValue="0"/>
    <field name="irregular:parking:left" reuseLastValue="0"/>
    <field name="irregular:parking:left:orientation" reuseLastValue="0"/>
    <field name="is_in" reuseLastValue="0"/>
    <field name="is_in:city" reuseLastValue="0"/>
    <field name="is_in:country_code" reuseLastValue="0"/>
    <field name="is_sidepath" reuseLastValue="0"/>
    <field name="is_sidepath:of" reuseLastValue="0"/>
    <field name="is_sidepath:of:name" reuseLastValue="0"/>
    <field name="is_sidepath:of:ref" reuseLastValue="0"/>
    <field name="junction" reuseLastValue="0"/>
    <field name="kerb" reuseLastValue="0"/>
    <field name="kerb:approach_aid" reuseLastValue="0"/>
    <field name="kerb:left" reuseLastValue="0"/>
    <field name="kerb:right" reuseLastValue="0"/>
    <field name="ladder" reuseLastValue="0"/>
    <field name="lane_markings" reuseLastValue="0"/>
    <field name="lanes" reuseLastValue="0"/>
    <field name="lanes:backward" reuseLastValue="0"/>
    <field name="lanes:both_ways" reuseLastValue="0"/>
    <field name="lanes:bus" reuseLastValue="0"/>
    <field name="lanes:bus:backward" reuseLastValue="0"/>
    <field name="lanes:bus:forward" reuseLastValue="0"/>
    <field name="lanes:forward" reuseLastValue="0"/>
    <field name="lanes:psv" reuseLastValue="0"/>
    <field name="lanes:psv:backward" reuseLastValue="0"/>
    <field name="lanes:psv:forward" reuseLastValue="0"/>
    <field name="last_check" reuseLastValue="0"/>
    <field name="last_checked" reuseLastValue="0"/>
    <field name="layer" reuseLastValue="0"/>
    <field name="lcn" reuseLastValue="0"/>
    <field name="left" reuseLastValue="0"/>
    <field name="length" reuseLastValue="0"/>
    <field name="level" reuseLastValue="0"/>
    <field name="lfd:criteria" reuseLastValue="0"/>
    <field name="lighting" reuseLastValue="0"/>
    <field name="lit" reuseLastValue="0"/>
    <field name="lit:note" reuseLastValue="0"/>
    <field name="lit_by_gaslight" reuseLastValue="0"/>
    <field name="lit_by_gaslight:left" reuseLastValue="0"/>
    <field name="lit_by_gaslight:right" reuseLastValue="0"/>
    <field name="lit_by_led" reuseLastValue="0"/>
    <field name="living_street" reuseLastValue="0"/>
    <field name="loc_name" reuseLastValue="0"/>
    <field name="loc_ref" reuseLastValue="0"/>
    <field name="local_ref" reuseLastValue="0"/>
    <field name="location" reuseLastValue="0"/>
    <field name="long_name" reuseLastValue="0"/>
    <field name="lwn" reuseLastValue="0"/>
    <field name="man_made" reuseLastValue="0"/>
    <field name="manufacturer" reuseLastValue="0"/>
    <field name="mapillary" reuseLastValue="0"/>
    <field name="material" reuseLastValue="0"/>
    <field name="maxaxleload" reuseLastValue="0"/>
    <field name="maxheight" reuseLastValue="0"/>
    <field name="maxheight:lanes" reuseLastValue="0"/>
    <field name="maxheight:physical" reuseLastValue="0"/>
    <field name="maxheight:signed" reuseLastValue="0"/>
    <field name="maxlength" reuseLastValue="0"/>
    <field name="maxspeed" reuseLastValue="0"/>
    <field name="maxspeed:advisory:variable" reuseLastValue="0"/>
    <field name="maxspeed:backward" reuseLastValue="0"/>
    <field name="maxspeed:backward:conditional" reuseLastValue="0"/>
    <field name="maxspeed:bicycle" reuseLastValue="0"/>
    <field name="maxspeed:conditional" reuseLastValue="0"/>
    <field name="maxspeed:destination" reuseLastValue="0"/>
    <field name="maxspeed:forward" reuseLastValue="0"/>
    <field name="maxspeed:forward:conditional" reuseLastValue="0"/>
    <field name="maxspeed:hgv" reuseLastValue="0"/>
    <field name="maxspeed:hgv:backward" reuseLastValue="0"/>
    <field name="maxspeed:hgv:conditional" reuseLastValue="0"/>
    <field name="maxspeed:hgv:forward" reuseLastValue="0"/>
    <field name="maxspeed:lanes:forward" reuseLastValue="0"/>
    <field name="maxspeed:max" reuseLastValue="0"/>
    <field name="maxspeed:note" reuseLastValue="0"/>
    <field name="maxspeed:practical" reuseLastValue="0"/>
    <field name="maxspeed:source" reuseLastValue="0"/>
    <field name="maxspeed:type" reuseLastValue="0"/>
    <field name="maxspeed:type:backward" reuseLastValue="0"/>
    <field name="maxspeed:variable" reuseLastValue="0"/>
    <field name="maxstay" reuseLastValue="0"/>
    <field name="maxweight" reuseLastValue="0"/>
    <field name="maxweight:agricultural" reuseLastValue="0"/>
    <field name="maxweight:backward" reuseLastValue="0"/>
    <field name="maxweight:conditional" reuseLastValue="0"/>
    <field name="maxweight:delivery" reuseLastValue="0"/>
    <field name="maxweight:destination" reuseLastValue="0"/>
    <field name="maxweight:forward" reuseLastValue="0"/>
    <field name="maxweight:hgv" reuseLastValue="0"/>
    <field name="maxweight:lanes" reuseLastValue="0"/>
    <field name="maxweight:psv" reuseLastValue="0"/>
    <field name="maxweight:signed" reuseLastValue="0"/>
    <field name="maxweightrating" reuseLastValue="0"/>
    <field name="maxweightrating:hgv" reuseLastValue="0"/>
    <field name="maxwidth" reuseLastValue="0"/>
    <field name="maxwidth:lanes" reuseLastValue="0"/>
    <field name="maxwidth:lanes:backward" reuseLastValue="0"/>
    <field name="maxwidth:lanes:forward" reuseLastValue="0"/>
    <field name="maxwidth:physical" reuseLastValue="0"/>
    <field name="mlc" reuseLastValue="0"/>
    <field name="mlc:oneway" reuseLastValue="0"/>
    <field name="mlc:tracked" reuseLastValue="0"/>
    <field name="mlc:tracked_oneway" reuseLastValue="0"/>
    <field name="mlc:wheeled" reuseLastValue="0"/>
    <field name="mlc:wheeled_oneway" reuseLastValue="0"/>
    <field name="motor_vehicle" reuseLastValue="0"/>
    <field name="motor_vehicle:backward" reuseLastValue="0"/>
    <field name="motor_vehicle:conditional" reuseLastValue="0"/>
    <field name="motor_vehicle:forward" reuseLastValue="0"/>
    <field name="motor_vehicle:lanes:backward" reuseLastValue="0"/>
    <field name="motor_vehicle:lanes:forward" reuseLastValue="0"/>
    <field name="motorcar" reuseLastValue="0"/>
    <field name="motorcycle" reuseLastValue="0"/>
    <field name="motorcycle:forward" reuseLastValue="0"/>
    <field name="motorhome" reuseLastValue="0"/>
    <field name="motorhome:backward" reuseLastValue="0"/>
    <field name="motorhome:forward" reuseLastValue="0"/>
    <field name="motorroad" reuseLastValue="0"/>
    <field name="mtb" reuseLastValue="0"/>
    <field name="mtb:description" reuseLastValue="0"/>
    <field name="mtb:name" reuseLastValue="0"/>
    <field name="mtb:scale" reuseLastValue="0"/>
    <field name="mtb:scale:imba" reuseLastValue="0"/>
    <field name="mtb:scale:uphill" reuseLastValue="0"/>
    <field name="mtb:type" reuseLastValue="0"/>
    <field name="name" reuseLastValue="0"/>
    <field name="name:ar" reuseLastValue="0"/>
    <field name="name:be" reuseLastValue="0"/>
    <field name="name:de" reuseLastValue="0"/>
    <field name="name:es" reuseLastValue="0"/>
    <field name="name:etymology" reuseLastValue="0"/>
    <field name="name:etymology:wikidata" reuseLastValue="0"/>
    <field name="name:etymology:wikipedia" reuseLastValue="0"/>
    <field name="name:hsb" reuseLastValue="0"/>
    <field name="name:left" reuseLastValue="0"/>
    <field name="name:right" reuseLastValue="0"/>
    <field name="narrow" reuseLastValue="0"/>
    <field name="natural" reuseLastValue="0"/>
    <field name="ncn_ref" reuseLastValue="0"/>
    <field name="network" reuseLastValue="0"/>
    <field name="network:short" reuseLastValue="0"/>
    <field name="network:wikidata" reuseLastValue="0"/>
    <field name="network:wikipedia" reuseLastValue="0"/>
    <field name="noexit" reuseLastValue="0"/>
    <field name="noise_barrier" reuseLastValue="0"/>
    <field name="noname" reuseLastValue="0"/>
    <field name="note:access" reuseLastValue="0"/>
    <field name="note:bicycle" reuseLastValue="0"/>
    <field name="note:de" reuseLastValue="0"/>
    <field name="note:lanes" reuseLastValue="0"/>
    <field name="note:lit" reuseLastValue="0"/>
    <field name="note:maxheight" reuseLastValue="0"/>
    <field name="note:maxspeed" reuseLastValue="0"/>
    <field name="note:name" reuseLastValue="0"/>
    <field name="note:surface" reuseLastValue="0"/>
    <field name="note_2" reuseLastValue="0"/>
    <field name="obstacle" reuseLastValue="0"/>
    <field name="obstacle:wheelchair" reuseLastValue="0"/>
    <field name="old_name" reuseLastValue="0"/>
    <field name="old_name:1876-1937" reuseLastValue="0"/>
    <field name="old_name:1897" reuseLastValue="0"/>
    <field name="old_name:1926-1948" reuseLastValue="0"/>
    <field name="old_name:1937-1945" reuseLastValue="0"/>
    <field name="old_name:1948-1993" reuseLastValue="0"/>
    <field name="old_name:196X-1993" reuseLastValue="0"/>
    <field name="old_ref" reuseLastValue="0"/>
    <field name="oneway" reuseLastValue="0"/>
    <field name="oneway:agricultural" reuseLastValue="0"/>
    <field name="oneway:bicycle" reuseLastValue="0"/>
    <field name="oneway:bus" reuseLastValue="0"/>
    <field name="oneway:conditional" reuseLastValue="0"/>
    <field name="oneway:foot" reuseLastValue="0"/>
    <field name="oneway:psv" reuseLastValue="0"/>
    <field name="opening_date" reuseLastValue="0"/>
    <field name="opening_hours" reuseLastValue="0"/>
    <field name="operator" reuseLastValue="0"/>
    <field name="operator:type" reuseLastValue="0"/>
    <field name="osm_id" reuseLastValue="0"/>
    <field name="osm_type" reuseLastValue="0"/>
    <field name="osmc:symbol" reuseLastValue="0"/>
    <field name="other_tags" reuseLastValue="0"/>
    <field name="overtaking" reuseLastValue="0"/>
    <field name="overtaking:backward" reuseLastValue="0"/>
    <field name="overtaking:forward" reuseLastValue="0"/>
    <field name="overtaking:hgv:backward" reuseLastValue="0"/>
    <field name="overtaking:hgv:forward" reuseLastValue="0"/>
    <field name="parking" reuseLastValue="0"/>
    <field name="parking:both" reuseLastValue="0"/>
    <field name="parking:both:fee" reuseLastValue="0"/>
    <field name="parking:both:fee:conditional" reuseLastValue="0"/>
    <field name="parking:both:markings" reuseLastValue="0"/>
    <field name="parking:both:orientation" reuseLastValue="0"/>
    <field name="parking:both:reason" reuseLastValue="0"/>
    <field name="parking:both:restriction" reuseLastValue="0"/>
    <field name="parking:both:staggered" reuseLastValue="0"/>
    <field name="parking:condition" reuseLastValue="0"/>
    <field name="parking:condition:both" reuseLastValue="0"/>
    <field name="parking:condition:both:conditional" reuseLastValue="0"/>
    <field name="parking:condition:both:customers" reuseLastValue="0"/>
    <field name="parking:condition:both:default" reuseLastValue="0"/>
    <field name="parking:condition:both:maxstay" reuseLastValue="0"/>
    <field name="parking:condition:both:residents" reuseLastValue="0"/>
    <field name="parking:condition:both:time_interval" reuseLastValue="0"/>
    <field name="parking:condition:both:vehicles" reuseLastValue="0"/>
    <field name="parking:condition:left" reuseLastValue="0"/>
    <field name="parking:condition:left:capacity" reuseLastValue="0"/>
    <field name="parking:condition:left:capacity:disabled" reuseLastValue="0"/>
    <field name="parking:condition:left:conditional" reuseLastValue="0"/>
    <field name="parking:condition:left:default" reuseLastValue="0"/>
    <field name="parking:condition:left:maxstay" reuseLastValue="0"/>
    <field name="parking:condition:left:residents" reuseLastValue="0"/>
    <field name="parking:condition:left:time_interval" reuseLastValue="0"/>
    <field name="parking:condition:left:vehicles" reuseLastValue="0"/>
    <field name="parking:condition:maxstay" reuseLastValue="0"/>
    <field name="parking:condition:right" reuseLastValue="0"/>
    <field name="parking:condition:right:capacity" reuseLastValue="0"/>
    <field name="parking:condition:right:capacity:disabled" reuseLastValue="0"/>
    <field name="parking:condition:right:default" reuseLastValue="0"/>
    <field name="parking:condition:right:disabled" reuseLastValue="0"/>
    <field name="parking:condition:right:maxstay" reuseLastValue="0"/>
    <field name="parking:condition:right:residents" reuseLastValue="0"/>
    <field name="parking:condition:right:time_interval" reuseLastValue="0"/>
    <field name="parking:condition:right:vehicles" reuseLastValue="0"/>
    <field name="parking:lane" reuseLastValue="0"/>
    <field name="parking:lane:both" reuseLastValue="0"/>
    <field name="parking:lane:both:diagonal" reuseLastValue="0"/>
    <field name="parking:lane:both:parallel" reuseLastValue="0"/>
    <field name="parking:lane:both:perpendicular" reuseLastValue="0"/>
    <field name="parking:lane:disabled" reuseLastValue="0"/>
    <field name="parking:lane:forward" reuseLastValue="0"/>
    <field name="parking:lane:left" reuseLastValue="0"/>
    <field name="parking:lane:left:capacity" reuseLastValue="0"/>
    <field name="parking:lane:left:diagonal" reuseLastValue="0"/>
    <field name="parking:lane:left:maxstay" reuseLastValue="0"/>
    <field name="parking:lane:left:parallel" reuseLastValue="0"/>
    <field name="parking:lane:left:perpendicular" reuseLastValue="0"/>
    <field name="parking:lane:left:surface" reuseLastValue="0"/>
    <field name="parking:lane:right" reuseLastValue="0"/>
    <field name="parking:lane:right:capacity" reuseLastValue="0"/>
    <field name="parking:lane:right:diagonal" reuseLastValue="0"/>
    <field name="parking:lane:right:parallel" reuseLastValue="0"/>
    <field name="parking:lane:right:perpendicular" reuseLastValue="0"/>
    <field name="parking:lane:right:surface" reuseLastValue="0"/>
    <field name="parking:lanes:left" reuseLastValue="0"/>
    <field name="parking:lanes:right" reuseLastValue="0"/>
    <field name="parking:left" reuseLastValue="0"/>
    <field name="parking:left:access" reuseLastValue="0"/>
    <field name="parking:left:authentication:disc:conditional" reuseLastValue="0"/>
    <field name="parking:left:fee" reuseLastValue="0"/>
    <field name="parking:left:markings" reuseLastValue="0"/>
    <field name="parking:left:maxstay:conditional" reuseLastValue="0"/>
    <field name="parking:left:orientation" reuseLastValue="0"/>
    <field name="parking:left:parallel" reuseLastValue="0"/>
    <field name="parking:left:perpendicular" reuseLastValue="0"/>
    <field name="parking:left:reason" reuseLastValue="0"/>
    <field name="parking:left:restriction" reuseLastValue="0"/>
    <field name="parking:left:restriction:conditional" reuseLastValue="0"/>
    <field name="parking:left:restriction:reason" reuseLastValue="0"/>
    <field name="parking:left:staggered" reuseLastValue="0"/>
    <field name="parking:right" reuseLastValue="0"/>
    <field name="parking:right:access" reuseLastValue="0"/>
    <field name="parking:right:access:conditional" reuseLastValue="0"/>
    <field name="parking:right:authentication:disc:conditional" reuseLastValue="0"/>
    <field name="parking:right:authentication:ticket" reuseLastValue="0"/>
    <field name="parking:right:fee" reuseLastValue="0"/>
    <field name="parking:right:markings" reuseLastValue="0"/>
    <field name="parking:right:maxstay:conditional" reuseLastValue="0"/>
    <field name="parking:right:orientation" reuseLastValue="0"/>
    <field name="parking:right:perpendicular" reuseLastValue="0"/>
    <field name="parking:right:reason" reuseLastValue="0"/>
    <field name="parking:right:restriction" reuseLastValue="0"/>
    <field name="parking:right:restriction:conditional" reuseLastValue="0"/>
    <field name="parking:right:restriction:reason" reuseLastValue="0"/>
    <field name="parking:right:surface" reuseLastValue="0"/>
    <field name="parking_lane:both" reuseLastValue="0"/>
    <field name="passage_type" reuseLastValue="0"/>
    <field name="passenger_information_display" reuseLastValue="0"/>
    <field name="passenger_information_display:speech_output" reuseLastValue="0"/>
    <field name="passing_places" reuseLastValue="0"/>
    <field name="path" reuseLastValue="0"/>
    <field name="pathtype" reuseLastValue="0"/>
    <field name="paving_stones:size" reuseLastValue="0"/>
    <field name="piste:difficulty" reuseLastValue="0"/>
    <field name="piste:grooming" reuseLastValue="0"/>
    <field name="piste:type" reuseLastValue="0"/>
    <field name="placement" reuseLastValue="0"/>
    <field name="placement:backward" reuseLastValue="0"/>
    <field name="placement:forward" reuseLastValue="0"/>
    <field name="planned" reuseLastValue="0"/>
    <field name="platform_lift" reuseLastValue="0"/>
    <field name="playground" reuseLastValue="0"/>
    <field name="postal_code" reuseLastValue="0"/>
    <field name="priority" reuseLastValue="0"/>
    <field name="priority_road" reuseLastValue="0"/>
    <field name="priority_road:backward" reuseLastValue="0"/>
    <field name="priority_road:forward" reuseLastValue="0"/>
    <field name="private" reuseLastValue="0"/>
    <field name="proposed" reuseLastValue="0"/>
    <field name="psv" reuseLastValue="0"/>
    <field name="psv:backward" reuseLastValue="0"/>
    <field name="psv:lanes" reuseLastValue="0"/>
    <field name="psv:lanes:backward" reuseLastValue="0"/>
    <field name="psv:lanes:forward" reuseLastValue="0"/>
    <field name="public_transport" reuseLastValue="0"/>
    <field name="qr_code" reuseLastValue="0"/>
    <field name="railway" reuseLastValue="0"/>
    <field name="railway:preferred_direction" reuseLastValue="0"/>
    <field name="railway:traffic_mode" reuseLastValue="0"/>
    <field name="ramp" reuseLastValue="0"/>
    <field name="ramp:bicycle" reuseLastValue="0"/>
    <field name="ramp:luggage" reuseLastValue="0"/>
    <field name="ramp:stroller" reuseLastValue="0"/>
    <field name="ramp:wheelchair" reuseLastValue="0"/>
    <field name="razed:bridge" reuseLastValue="0"/>
    <field name="razed:railway" reuseLastValue="0"/>
    <field name="red_turn:left" reuseLastValue="0"/>
    <field name="red_turn:right" reuseLastValue="0"/>
    <field name="ref" reuseLastValue="0"/>
    <field name="ref:IFOPT" reuseLastValue="0"/>
    <field name="ref:IFOPT:description" reuseLastValue="0"/>
    <field name="ref:VVO" reuseLastValue="0"/>
    <field name="ref:lfd" reuseLastValue="0"/>
    <field name="ref:manufacturer_inventory" reuseLastValue="0"/>
    <field name="ref:operator_inventory" reuseLastValue="0"/>
    <field name="ref_name" reuseLastValue="0"/>
    <field name="reg_name" reuseLastValue="0"/>
    <field name="render" reuseLastValue="0"/>
    <field name="repeat_on" reuseLastValue="0"/>
    <field name="roof" reuseLastValue="0"/>
    <field name="roof:edge" reuseLastValue="0"/>
    <field name="roof:levels" reuseLastValue="0"/>
    <field name="roof:shape" reuseLastValue="0"/>
    <field name="room" reuseLastValue="0"/>
    <field name="route" reuseLastValue="0"/>
    <field name="route_ref" reuseLastValue="0"/>
    <field name="ruins" reuseLastValue="0"/>
    <field name="sac_scale" reuseLastValue="0"/>
    <field name="segregated" reuseLastValue="0"/>
    <field name="service" reuseLastValue="0"/>
    <field name="shelter" reuseLastValue="0"/>
    <field name="short_name" reuseLastValue="0"/>
    <field name="shoulder" reuseLastValue="0"/>
    <field name="shoulder:right" reuseLastValue="0"/>
    <field name="side" reuseLastValue="0"/>
    <field name="sideincline" reuseLastValue="0"/>
    <field name="sidewalk" reuseLastValue="0"/>
    <field name="sidewalk:bicycle" reuseLastValue="0"/>
    <field name="sidewalk:both" reuseLastValue="0"/>
    <field name="sidewalk:both:bicycle" reuseLastValue="0"/>
    <field name="sidewalk:both:foot" reuseLastValue="0"/>
    <field name="sidewalk:both:smoothness" reuseLastValue="0"/>
    <field name="sidewalk:both:surface" reuseLastValue="0"/>
    <field name="sidewalk:both:traffic_sign" reuseLastValue="0"/>
    <field name="sidewalk:foot" reuseLastValue="0"/>
    <field name="sidewalk:left" reuseLastValue="0"/>
    <field name="sidewalk:left:bicycle" reuseLastValue="0"/>
    <field name="sidewalk:left:bicycle:backward" reuseLastValue="0"/>
    <field name="sidewalk:left:bicycle:forward" reuseLastValue="0"/>
    <field name="sidewalk:left:bicycle:maxspeed:backward" reuseLastValue="0"/>
    <field name="sidewalk:left:description:de" reuseLastValue="0"/>
    <field name="sidewalk:left:description:en" reuseLastValue="0"/>
    <field name="sidewalk:left:est_width" reuseLastValue="0"/>
    <field name="sidewalk:left:foot" reuseLastValue="0"/>
    <field name="sidewalk:left:incline" reuseLastValue="0"/>
    <field name="sidewalk:left:kerb" reuseLastValue="0"/>
    <field name="sidewalk:left:oneway" reuseLastValue="0"/>
    <field name="sidewalk:left:smoothness" reuseLastValue="0"/>
    <field name="sidewalk:left:surface" reuseLastValue="0"/>
    <field name="sidewalk:left:traffic_sign" reuseLastValue="0"/>
    <field name="sidewalk:left:width" reuseLastValue="0"/>
    <field name="sidewalk:oneway" reuseLastValue="0"/>
    <field name="sidewalk:right" reuseLastValue="0"/>
    <field name="sidewalk:right:bicycle" reuseLastValue="0"/>
    <field name="sidewalk:right:bicycle:maxspeed" reuseLastValue="0"/>
    <field name="sidewalk:right:bicycle:oneway" reuseLastValue="0"/>
    <field name="sidewalk:right:description:de" reuseLastValue="0"/>
    <field name="sidewalk:right:description:en" reuseLastValue="0"/>
    <field name="sidewalk:right:est_width" reuseLastValue="0"/>
    <field name="sidewalk:right:foot" reuseLastValue="0"/>
    <field name="sidewalk:right:incline" reuseLastValue="0"/>
    <field name="sidewalk:right:kerb" reuseLastValue="0"/>
    <field name="sidewalk:right:oneway" reuseLastValue="0"/>
    <field name="sidewalk:right:segregated" reuseLastValue="0"/>
    <field name="sidewalk:right:smoothness" reuseLastValue="0"/>
    <field name="sidewalk:right:surface" reuseLastValue="0"/>
    <field name="sidewalk:right:surface:note" reuseLastValue="0"/>
    <field name="sidewalk:right:traffic_sign" reuseLastValue="0"/>
    <field name="sidewalk:right:width" reuseLastValue="0"/>
    <field name="sidewalk:smoothness" reuseLastValue="0"/>
    <field name="sidewalk:surface" reuseLastValue="0"/>
    <field name="sidewalk:traffic_sign" reuseLastValue="0"/>
    <field name="sideway" reuseLastValue="0"/>
    <field name="ski" reuseLastValue="0"/>
    <field name="sloped_curb" reuseLastValue="0"/>
    <field name="smoking" reuseLastValue="0"/>
    <field name="smoothness" reuseLastValue="0"/>
    <field name="smoothness:backward" reuseLastValue="0"/>
    <field name="smoothness:forward" reuseLastValue="0"/>
    <field name="snowmobile" reuseLastValue="0"/>
    <field name="source:access" reuseLastValue="0"/>
    <field name="source:alt_name" reuseLastValue="0"/>
    <field name="source:cycleway:width" reuseLastValue="0"/>
    <field name="source:destination" reuseLastValue="0"/>
    <field name="source:geometry" reuseLastValue="0"/>
    <field name="source:incline" reuseLastValue="0"/>
    <field name="source:lit" reuseLastValue="0"/>
    <field name="source:maxheight" reuseLastValue="0"/>
    <field name="source:maxspeed" reuseLastValue="0"/>
    <field name="source:maxspeed:backward" reuseLastValue="0"/>
    <field name="source:maxspeed:conditional" reuseLastValue="0"/>
    <field name="source:maxspeed:forward" reuseLastValue="0"/>
    <field name="source:maxspeed:hgv" reuseLastValue="0"/>
    <field name="source:maxweight" reuseLastValue="0"/>
    <field name="source:maxwidth" reuseLastValue="0"/>
    <field name="source:name" reuseLastValue="0"/>
    <field name="source:offset" reuseLastValue="0"/>
    <field name="source:old_name" reuseLastValue="0"/>
    <field name="source:oneway" reuseLastValue="0"/>
    <field name="source:outline" reuseLastValue="0"/>
    <field name="source:reg_name" reuseLastValue="0"/>
    <field name="source:width" reuseLastValue="0"/>
    <field name="speech_output" reuseLastValue="0"/>
    <field name="speech_output:de" reuseLastValue="0"/>
    <field name="sport" reuseLastValue="0"/>
    <field name="stairs" reuseLastValue="0"/>
    <field name="start_date" reuseLastValue="0"/>
    <field name="step.condition" reuseLastValue="0"/>
    <field name="step.height" reuseLastValue="0"/>
    <field name="step.length" reuseLastValue="0"/>
    <field name="step:height" reuseLastValue="0"/>
    <field name="step:length" reuseLastValue="0"/>
    <field name="step_count" reuseLastValue="0"/>
    <field name="steps" reuseLastValue="0"/>
    <field name="stone" reuseLastValue="0"/>
    <field name="stroller" reuseLastValue="0"/>
    <field name="subject:wikidata" reuseLastValue="0"/>
    <field name="supervised" reuseLastValue="0"/>
    <field name="support" reuseLastValue="0"/>
    <field name="surface" reuseLastValue="0"/>
    <field name="surface:backward" reuseLastValue="0"/>
    <field name="surface:colour" reuseLastValue="0"/>
    <field name="surface:comment" reuseLastValue="0"/>
    <field name="surface:de" reuseLastValue="0"/>
    <field name="surface:forward" reuseLastValue="0"/>
    <field name="surface:lanes:backward" reuseLastValue="0"/>
    <field name="surface:lanes:forward" reuseLastValue="0"/>
    <field name="surface:left" reuseLastValue="0"/>
    <field name="surface:middle" reuseLastValue="0"/>
    <field name="surface:note" reuseLastValue="0"/>
    <field name="surface:paved" reuseLastValue="0"/>
    <field name="surface:right" reuseLastValue="0"/>
    <field name="surface_material" reuseLastValue="0"/>
    <field name="survey:date" reuseLastValue="0"/>
    <field name="symbol" reuseLastValue="0"/>
    <field name="tactile_paving" reuseLastValue="0"/>
    <field name="tactile_paving:end" reuseLastValue="0"/>
    <field name="tactile_paving:start" reuseLastValue="0"/>
    <field name="tactile_writing" reuseLastValue="0"/>
    <field name="tactile_writing:braille:de" reuseLastValue="0"/>
    <field name="tactile_writing:engraved_printed_letters:de" reuseLastValue="0"/>
    <field name="tags" reuseLastValue="0"/>
    <field name="taxi" reuseLastValue="0"/>
    <field name="taxi:lanes" reuseLastValue="0"/>
    <field name="temporary:access" reuseLastValue="0"/>
    <field name="temporary:date_off" reuseLastValue="0"/>
    <field name="temporary:date_on" reuseLastValue="0"/>
    <field name="toilets" reuseLastValue="0"/>
    <field name="toll" reuseLastValue="0"/>
    <field name="toll:N3" reuseLastValue="0"/>
    <field name="tourism" reuseLastValue="0"/>
    <field name="tourist_bus" reuseLastValue="0"/>
    <field name="tracktype" reuseLastValue="0"/>
    <field name="traffic_calming" reuseLastValue="0"/>
    <field name="traffic_sign" reuseLastValue="0"/>
    <field name="traffic_sign:backward" reuseLastValue="0"/>
    <field name="traffic_sign:forward" reuseLastValue="0"/>
    <field name="traffic_signals:direction" reuseLastValue="0"/>
    <field name="trail_visibility" reuseLastValue="0"/>
    <field name="tram" reuseLastValue="0"/>
    <field name="tree_lined" reuseLastValue="0"/>
    <field name="tree_lined:both:taxon" reuseLastValue="0"/>
    <field name="trolley_wire" reuseLastValue="0"/>
    <field name="truck" reuseLastValue="0"/>
    <field name="tunnel" reuseLastValue="0"/>
    <field name="tunnel:name" reuseLastValue="0"/>
    <field name="turn" reuseLastValue="0"/>
    <field name="turn:backward" reuseLastValue="0"/>
    <field name="turn:bicycle:lanes:backward" reuseLastValue="0"/>
    <field name="turn:forward" reuseLastValue="0"/>
    <field name="turn:lanes" reuseLastValue="0"/>
    <field name="turn:lanes:backward" reuseLastValue="0"/>
    <field name="turn:lanes:both_ways" reuseLastValue="0"/>
    <field name="turn:lanes:forward" reuseLastValue="0"/>
    <field name="type" reuseLastValue="0"/>
    <field name="uic_ref" reuseLastValue="0"/>
    <field name="unsigned_ref" reuseLastValue="0"/>
    <field name="url" reuseLastValue="0"/>
    <field name="usability:skate" reuseLastValue="0"/>
    <field name="usage" reuseLastValue="0"/>
    <field name="vehicle" reuseLastValue="0"/>
    <field name="vehicle:backward" reuseLastValue="0"/>
    <field name="vehicle:conditional" reuseLastValue="0"/>
    <field name="vehicle:disabled" reuseLastValue="0"/>
    <field name="vehicle:forward" reuseLastValue="0"/>
    <field name="vehicle:forward:conditional" reuseLastValue="0"/>
    <field name="vehicle:lanes" reuseLastValue="0"/>
    <field name="vehicle:lanes:backward" reuseLastValue="0"/>
    <field name="vehicle:lanes:forward" reuseLastValue="0"/>
    <field name="via_ferrata_scale" reuseLastValue="0"/>
    <field name="virtual:highway" reuseLastValue="0"/>
    <field name="visibility" reuseLastValue="0"/>
    <field name="voltage" reuseLastValue="0"/>
    <field name="vvo-id" reuseLastValue="0"/>
    <field name="warning_light" reuseLastValue="0"/>
    <field name="waste_basket" reuseLastValue="0"/>
    <field name="waterway" reuseLastValue="0"/>
    <field name="website" reuseLastValue="0"/>
    <field name="wheelchair" reuseLastValue="0"/>
    <field name="wheelchair:description" reuseLastValue="0"/>
    <field name="wheelchair:description:de" reuseLastValue="0"/>
    <field name="whitewater" reuseLastValue="0"/>
    <field name="width" reuseLastValue="0"/>
    <field name="width:bicycle" reuseLastValue="0"/>
    <field name="width:comment" reuseLastValue="0"/>
    <field name="width:lanes" reuseLastValue="0"/>
    <field name="width:lanes:backward" reuseLastValue="0"/>
    <field name="width:lanes:forward" reuseLastValue="0"/>
    <field name="width_1" reuseLastValue="0"/>
    <field name="wikidata" reuseLastValue="0"/>
    <field name="wikidata:note" reuseLastValue="0"/>
    <field name="wikimedia_commons" reuseLastValue="0"/>
    <field name="wikipedia" reuseLastValue="0"/>
    <field name="winter_service" reuseLastValue="0"/>
    <field name="z_order" reuseLastValue="0"/>
    <field name="zone:maxspeed" reuseLastValue="0"/>
    <field name="zone:no_parking" reuseLastValue="0"/>
    <field name="zone:parking" reuseLastValue="0"/>
    <field name="zone:traffic" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"old_name"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>
