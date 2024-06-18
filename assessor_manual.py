import geopandas as gpd
import pandas as pd
from data_loaders.osm_defaults import OSMCAT_STREET_KEYS

from data_loaders import hessen_dataset
sr_buffer = pd.read_csv(r'C:\Users\Porojkow\Documents\Projekte\VV03_DLR-Kreisverkehre\pythonProject\daten\kreisverkehre_vm_OSM.csv')

parse = []
for index, row in sr_buffer.iterrows():
    # Split the tag_string by commas to separate out each key-value pair
    pairs = row['tag_string'].split(',')
    # Split each pair by '=>' and form a dictionary of key-value pairs
    row_data = {kv.split('=>')[0]: kv.split('=>')[1] for kv in pairs if '=>' in kv}
    parse.append(row_data)

sr_buffer_tags = pd.DataFrame(parse)
dropcol = [col for col in OSMCAT_STREET_KEYS if col in sr_buffer_tags.columns]
sr_buffer_tags = sr_buffer_tags[dropcol]

labs = ["highway", "cycleway", "segregated", "bicycle",
        "foot", "sidewalk", "bicycle_road", "cyclestreet",
        "reversed", "indoor", "access", "tram", 'traffic_sign', 'traffic_sign:forward',
        'cycleway:left', 'cycleway:right', 'cycleway:both',
        'sidewalk:left', 'sidewalk:right', 'sidewalk:both']
nested_labs_prefix = ['cycleway:left', 'cycleway:right', 'cycleway:both',
                      'sidewalk:left', 'sidewalk:right', 'sidewalk:both']
nested_labs_suffix = ['bicycle', 'lane', 'segregated', 'oneway', 'foot', 'traffic_sign']
nested_labs = [prefix + ':' + suffix for prefix in nested_labs_prefix for suffix in nested_labs_suffix]
labs.extend(nested_labs)


def set_value(row):
    is_segregated = any(key == 'segregated' and value == 'yes' for key, value in row.items())
    is_footpath = row.get("highway") in ["footway", "pedestrian"]
    use_sidepath = any(key == 'bicycle' and value == 'use_sidepath' for key, value in row.items())
    is_indoor = row.get('indoor', 'no') == 'yes'
    is_accessible = row.get('access', '') == 'no'
    is_path = row.get("highway") == "path"
    is_track = row.get("highway") == "track"

    can_walk_right = (row.get("foot") in ["yes", "designated"]
                      or any(key == 'right:foot' and value in ['yes', 'designated'] for key, value in row.items())
                      or row.get("sidewalk") in ["yes", "separated", "both", "right", "left"]
                      or row.get("sidewalk:right") in ["yes", "separated", "both", "right"]
                      or row.get("sidewalk:both") in ["yes", "separated", "both"])
    can_walk_left = (row.get("foot") in ["yes", "designated"]
                     or any(key == 'left:foot' and value in ['yes', 'designated'] for key, value in row.items())
                     or row.get("sidewalk") in ["yes", "separated", "both", "right", "left"]
                     or row.get("sidewalk:left") in ["yes", "separated", "both", "left"]
                     or row.get("sidewalk:both") in ["yes", "separated", "both"])

    # maybe we have to explicitly distinguish between when bicycle is empty (null) or when bicycle is explicitly NO or DISMOUNT
    can_bike = (row.get("bicycle") in ["yes", "designated"]
                and row.get("highway") not in ['motorway', 'motorway_link'])  # should we add permissive?
    cannot_bike = (row.get("bicycle") in ["no", "dismount", 'use_sidepath'] or
                   row.get("highway") in ['corridor', 'motorway', 'motorway_link', 'trunk', 'trunk_link'] or
                   row.get("access") == ['customers'])

    can_cardrive = row.get("highway") in ["motorway", "trunk", "primary", "secondary", "tertiary", "unclassified", "road",
                                          "residential", "living_street",
                                          "primary_link", "secondary_link", "tertiary_link", 'motorway_link', 'trunk_link']

    is_not_forbidden = ((row.get("highway") in ["cycleway", "track", "path"])
                        and not cannot_bike)

    is_bikepath_right = (row.get("highway") == "cycleway"
                         or (any(key == 'right:bicycle' and value in ['designated'] for key, value in row.items())
                             and not any(key == 'cycleway:right:lane' for key, value in row.items()))
                         or row.get("cycleway") in ["track", "sidepath", "crossing"]
                         or row.get("cycleway:right") in ["track", "sidepath", "crossing"]
                         or row.get("cycleway:both") in ["track", "sidepath", "crossing"]
                         or any(key == 'right:traffic_sign' and value in ['237'] for key, value in row.items()))

    is_bikepath_left = (row.get("highway") == "cycleway"
                        or (any(key == 'left:bicycle' and value in ['designated'] for key, value in row.items())
                            and not any(key == 'cycleway:left:lane' for key, value in row.items()))
                        or row.get("cycleway") in ["track", "sidepath", "crossing"]
                        or row.get("cycleway:left") in ["track", "sidepath", "crossing"]
                        or row.get("cycleway:both") in ["track", "sidepath", "crossing"]
                        or any(key == 'left:traffic_sign' and value in ['237'] for key, value in row.items()))

    #### Begin categories
    ##infrastructure designated for pedestrians
    is_pedestrian_right = (is_footpath and not can_bike and not is_indoor or is_path and can_walk_right
                           and not can_bike and not is_indoor)  # alternatively: (is_path or is_track)?

    is_pedestrian_left = (is_footpath and not can_bike and not is_indoor or is_path and can_walk_left
                          and not can_bike and not is_indoor)  # alternatively: (is_path or is_track)?

    ##bicycle_road
    is_bikeroad = (row.get("bicycle_road") == "yes"
                   or row.get("cyclestreet") == "yes")

    ##Straßenbegleitender Radweg benutzungspflichtig
    is_bikelane_right = (row.get("cycleway") in ["lane", "shared_lane"]
                         or row.get("cycleway:right") in ["lane", "shared_lane"]
                         or row.get("cycleway:both") in ["lane", "shared_lane"]
                         or any(key == 'right:lane' and value in ['exclusive'] for key, value in row.items()))

    is_bikelane_left = (row.get("cycleway") in ["lane", "shared_lane"]
                        or row.get("cycleway:left") in ["lane", "shared_lane"]
                        or row.get("cycleway:both") in ["lane", "shared_lane"]
                        or any(key == 'left:lane' and value in ['exclusive'] for key, value in row.items()))

    ##schutzstreifen/radfahrstreifen
    ##bus
    is_buslane_right = (row.get("cycleway") == "share_busway"
                        or row.get("cycleway:right") == "share_busway"
                        or row.get("cycleway:both") == "share_busway")
    is_buslane_left = (row.get("cycleway") == "share_busway"
                       or row.get("cycleway:left") == "share_busway"
                       or row.get("cycleway:both") == "share_busway")

    ## bicycle_way
    # First option: "bicycle_way_right"
    conditions_b_way_right = [
        # is_bikeroad,
        is_bikepath_right and not can_walk_right,
        is_bikepath_right and is_segregated,
        can_bike and is_path and not can_walk_right,  # and not is_footpath,
        can_bike and is_track and not can_walk_right,  # and not is_footpath,
        can_bike and is_path and is_segregated,
        can_bike and (is_track or is_footpath) and is_segregated,
        (row.get("bicycle") == "designated" and row.get("foot") == "designated" and is_segregated),
        (row.get("cycleway:right:bicycle") == "designated" and row.get(
            "sidewalk:right:foot") == "designated" and is_segregated),
        (row.get("cycleway:bicycle") == "designated" and row.get("sidewalk:foot") == "designated")

    ]
    conditions_b_way_left = [
        # is_bikeroad,
        is_bikepath_left and not can_walk_left,
        is_bikepath_left and is_segregated,
        can_bike and is_path and not can_walk_left,  # and not is_footpath,
        can_bike and is_track and not can_walk_left,  # and not is_footpath,
        can_bike and is_path and is_segregated,
        can_bike and (is_track or is_footpath) and is_segregated,
        (row.get("bicycle") == "designated" and row.get("foot") == "designated" and is_segregated),
        (row.get("cycleway:left:bicycle") == "designated" and row.get(
            "sidewalk:left:foot") == "designated" and is_segregated),
        (row.get("cycleway:bicycle") == "designated" and row.get("sidewalk:foot") == "designated")
    ]

    # Second option: "mixed_way"
    ##mixed
    conditions_mixed_right = [
        is_bikepath_right and can_walk_right and not is_segregated,
        is_footpath and can_bike and not is_segregated,
        (is_path or is_track) and can_bike and can_walk_right and not is_segregated,
        # is_track and can_bike and can_walk_right and not is_segregated,
    ]
    conditions_mixed_left = [
        is_bikepath_left and can_walk_left and not is_segregated,
        is_footpath and can_bike and not is_segregated,
        (is_path or is_track) and can_bike and can_walk_left and not is_segregated,
        # is_track and can_bike and can_walk_left and not is_segregated,
    ]

    # Add. Option: mit_road
    ##mit
    conditions_mit_right = [
        can_cardrive and not is_bikepath_right and not is_bikeroad and not is_footpath and not is_bikelane_right and not is_buslane_right
        and not is_path and not is_track and not cannot_bike,
    ]
    conditions_mit_left = [
        can_cardrive and not is_bikepath_left and not is_bikeroad and not is_footpath and not is_bikelane_left and not is_buslane_left
        and not is_path and not is_track and not cannot_bike,
    ]

    # return {
    #     "is_segregated": is_segregated,
    #     "is_footpath": is_footpath,
    #     "use_sidepath": use_sidepath,
    #     "is_indoor": is_indoor,
    #     "is_accessible": is_accessible,
    #     "is_path": is_path,
    #     "is_track": is_track,
    #     "can_walk_right": can_walk_right,
    #     "can_walk_left": can_walk_left,
    #     "can_bike": can_bike,
    #     "cannot_bike": cannot_bike,
    #     "is_pedestrian_right": is_pedestrian_right,
    #     "is_pedestrian_left": is_pedestrian_left,
    #     "is_bikeroad": is_bikeroad,
    #     "is_bikelane_right": is_bikelane_right,
    #     "is_bikelane_left": is_bikelane_left,
    #     "is_buslane_right": is_buslane_right,
    #     "is_buslane_left": is_buslane_left,
    #     "can_cardrive": can_cardrive,
    #     "is_not_forbidden": is_not_forbidden,
    #     "is_bikepath_right": is_bikepath_right,
    #     "is_bikepath_left": is_bikepath_left,
    #     "b_way_right": conditions_b_way_right,
    #     "b_way_left": conditions_b_way_left,
    #     "mixed_right": conditions_mixed_right,
    #     "mixed_left": conditions_mixed_left,
    #     "mit_right": conditions_mit_right,
    #     "mit_left": conditions_mit_left
    # }


    #### 3 # new option: "bicycle_road"
    if is_bikeroad:
        return "bicycle_road"

    #### 1
    elif any(conditions_b_way_right):
        if any(conditions_b_way_left):
            return "bicycle_way_both"
        elif any(conditions_mixed_left):
            return "bicycle_way_right_mixed_left"
        elif is_bikelane_left:
            return "bicycle_way_right_lane_left"
        elif is_buslane_left:
            return "bicycle_way_right_bus_left"
        elif any(conditions_mit_left):
            return "bicycle_way_right_mit_left"
        elif is_pedestrian_left:
            return "bicycle_way_right_pedestrian_left"
        else:
            return "bicycle_way_right_no_left"

    elif any(conditions_b_way_left):
        if any(conditions_mixed_right):
            return "bicycle_way_left_mixed_right"
        elif is_bikelane_right:
            return "bicycle_way_left_lane_right"
        elif is_buslane_right:
            return "bicycle_way_left_bus_right"
        elif any(conditions_mit_right):
            return "bicycle_way_left_mit_right"
        elif is_pedestrian_right:
            return "bicycle_way_left_pedestrian_right"
        else:
            return "bicycle_way_left_no_right"

    #### 2
    elif any(conditions_mixed_right):
        if any(conditions_mixed_left):
            return "mixed_way_both"
        elif is_bikelane_left:
            return "mixed_way_right_lane_left"
        elif is_buslane_left:
            return "mixed_way_right_bus_left"
        elif any(conditions_mit_left):
            return "mixed_way_right_mit_left"
        elif is_pedestrian_left:
            return "mixed_way_right_pedestrian_left"
        else:
            return "mixed_way_right_no_left"

    elif any(conditions_mixed_left):
        if is_bikelane_right:
            return "mixed_way_left_lane_right"
        elif is_buslane_right:
            return "mixed_way_left_bus_right"
        elif any(conditions_mit_right):
            return "mixed_way_left_mit_right"
        elif is_pedestrian_right:
            return "mixed_way_left_pedestrian_right"
        else:
            return "mixed_way_left_no_right"

    #### 4 # Third option: "bicycle_lane"
    elif is_bikelane_right:
        if is_bikelane_left:
            return "bicycle_lane_both"
        elif is_buslane_left:
            return "bicycle_lane_right_bus_left"
        elif any(conditions_mit_left):
            return "bicycle_lane_right_mit_left"
        elif is_pedestrian_left:
            return "bicycle_lane_right_pedestrian_left"
        else:
            return "bicycle_lane_right_no_left"

    elif is_bikelane_left:
        if is_buslane_right:
            return "bicycle_lane_left_bus_right"
        elif any(conditions_mit_right):
            return "bicycle_lane_left_mit_right"
        elif is_pedestrian_right:
            return "bicycle_lane_left_pedestrian_right"
        else:
            return "bicycle_lane_left_no_right"

    #### 5 # Fourth option: "bus_lane"
    elif is_buslane_right:
        if is_buslane_left:
            return "bus_lane_both"
        elif any(conditions_mit_left):
            return "bus_lane_right_mit_left"
        elif is_pedestrian_left:
            return "bus_lane_right_pedestrian_left"
        else:
            return "bus_lane_right_no_left"

    elif is_buslane_left:
        if any(conditions_mit_right):
            return "bus_lane_left_mit_right"
        elif is_pedestrian_right:
            return "bus_lane_left_pedestrian_right"
        else:
            return "bus_lane_left_no_right"



    #### 6
    elif any(conditions_mit_right):
        if any(conditions_mit_left):
            return "mit_road_both"
        elif is_pedestrian_left:
            return "mit_road_right_pedestrian_left"
        else:
            return "mit_road_right_no_left"

    elif any(conditions_mit_left):
        if is_pedestrian_right:
            return "mit_road_left_pedestrian_right"
        else:
            return "mit_road_left_no_right"

    #### 8
    elif is_pedestrian_right and (not 'indoor' in row.values or (row['indoor'] != 'yes')):
        if is_pedestrian_left and (not 'indoor' in row.values or (row['indoor'] != 'yes')):
            if ('indoor' in row.values and row['indoor'] == 'yes') or ('access' in row.index and row['access'] == 'customers'):
                return "no"
            else:
                return "pedestrian_both"
        else:
            return "pedestrian_right_no_left"


    elif is_pedestrian_left and (not 'indoor' in row.values or (row['indoor'] != 'yes')):
        if ('indoor' in row.values and row['indoor'] == 'yes') or ('access' in row.index and row['access'] == 'customers'):
            return "no"
        else:
            return "pedestrian_left_no_right"

    elif is_not_forbidden:
        return "path_not_forbidden"

    elif row["highway"] == "service":
        if ('access' in row.index and row['access'] == 'no') or ('tram' in row.index and row['tram'] == 'yes'):
            return 'no'
        else:
            return "service_misc"

    #### Fallback option: "no"
    else:
        return "no"


results = sr_buffer_tags.apply(set_value, axis=1)

sr_buffer_cat = pd.concat([sr_buffer[['WKT', 'count', 'Typ', 'Furt eingefärbt', 'Zebrastr.',
                                      'Achtung Radfahrer', 'beide Richtungen', 'location', 'Fußgängerüberweg', 'Tempo 30']], pd.DataFrame(list(results))], axis=1)
sr_buffer_cat.to_csv(r"C:\Users\Porojkow\Documents\Projekte\VV03_DLR-Kreisverkehre\pythonProject\daten\kreisverkehre_vm_kategorisiert.csv")
# gpd.GeoDataFrame(sr_buffer_cat, geometry=sr_buffer_cat.geometry).rename(
#     columns={0: 'cycle_infra'}).to_file('../data/sr_buffer_2023_full_infra.gpkg')
# gpd.GeoDataFrame(sr_buffer_cat, geometry=sr_buffer_cat.geometry).rename(
#     columns={0: 'cycle_infra'}).to_file(r'C:\Users\Porojkow\Documents\Projekte\VV03_DLR-Kreisverkehre\pythonProject\daten\kreisverkehre_vm_OSM.gpkg')
#TODO: Rest der Kategorisierung
sr_buf = pd.concat([sr_buffer.drop(columns=['tag_string']), sr_buffer_tags], axis=1)


