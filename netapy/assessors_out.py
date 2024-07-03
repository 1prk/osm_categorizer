import pandas as pd
import geopandas as gpd
import pyrosm
import json

OSM_STREET_KEYS = [
  "name",
  "highway",
  "access",
  "oneway",
  "bridge",
  "tunnel",
  "junction",
  "service",
  "maxspeed",
  "lanes",
  "lanes:forward",
  "lanes:backward",
  "width",
  "surface",
  "tracktype",
  "smoothness",
  "bicycle",
  "cyclestreet",
  "bicycle_road",
  "cycleway",
  "cycleway:both",
  "cycleway:left",
  "cycleway:right",
  "foot",
  "footway",
  "sidewalk",
  "sidewalk:both",
  "sidewalk:left",
  "sidewalk:right",
  "sidewalk:foot",
  "segregated",
  "indoor",
  "tram",
  "traffic_sign",
  "traffic_sign:forward",
  "cycleway:bicycle",
  'cycleway:left:bicycle',
  'cycleway:left:lane',
  'cycleway:left:segregated',
  'cycleway:left:oneway',
  'cycleway:left:foot',
  'cycleway:left:traffic_sign',
  'cycleway:right:bicycle',
  'cycleway:right:lane'
  'cycleway:right:segregated',
  'cycleway:right:oneway',
  'cycleway:right:foot',
  'cycleway:right:traffic_sign',
  'cycleway:both:bicycle',
  'cycleway:both:lane',
  'cycleway:both:segregated',
  'cycleway:both:oneway',
  'cycleway:both:foot',
  'cycleway:both:traffic_sign',
  'sidewalk:left:bicycle',
  'sidewalk:left:segregated',
  'sidewalk:left:oneway',
  'sidewalk:left:foot',
  'sidewalk:left:traffic_sign',
  'sidewalk:right:bicycle',
  'sidewalk:right:segregated',
  'sidewalk:right:oneway',
  'sidewalk:right:foot',
  'sidewalk:right:traffic_sign',
  'sidewalk:both:bicycle',
  'sidewalk:both:segregated',
  'sidewalk:both:oneway',
  'sidewalk:both:foot',
  'sidewalk:both:traffic_sign'
]

def derive_bicycle_infrastructure(x):
    is_reversed = x["reversed"]

    is_segregated = any(key for key, value in x.items() if
                        'segregated' in key and value == 'yes')
    is_obligated_segregated = (
            ('traffic_sign' in x.keys() and isinstance(x['traffic_sign'], str) and '241' in x['traffic_sign'])
            or ('traffic_sign:forward' in x.keys() and isinstance(x['traffic_sign:forward'], str) and '241' in x[
        'traffic_sign:forward'])
    )
    is_designated = x["bicycle"] == "designated"
    use_sidepath = any(key for key, value in x.items() if 'bicycle' in key and value == 'use_sidepath')

    is_path = x["highway"] in ["path"]
    is_track = x["highway"] in ["track"]
    is_footpath = x["highway"] in ["footway", "pedestrian"]
    is_service_tag = x["highway"] in ["service"]

    is_indoor = x['indoor'] == 'yes'
    is_not_accessible = x["access"] == "no"
    is_accessible = pd.isnull(x["access"]) or not is_not_accessible
    is_agricultural = x.get("motor_vehicle") in ["agricultural", "forestry"]
    is_smooth = pd.isnull(x["tracktype"]) or x["tracktype"] in ["grade1", "grade2"]
    is_vehicle_allowed = pd.isnull(x.get("motor_vehicle")) or x.get("motor_vehicle") != "no"

    can_walk_right = (x["foot"] in ["yes", "designated"]
                      or any(key for key, value in x.items() if 'right:foot' in key and value in ['yes', 'designated'])
                      or x["sidewalk"] in ["yes", "separated", "both", "right", "left"]
                      or x["sidewalk:right"] in ["yes", "separated", "both", "right"]
                      or x["sidewalk:both"] in ["yes", "separated", "both"])
    can_walk_left = (x["foot"] in ["yes", "designated"]
                     or any(key for key, value in x.items() if 'left:foot' in key and value in ['yes', 'designated'])
                     or x["sidewalk"] in ["yes", "separated", "both", "right", "left"]
                     or x["sidewalk:left"] in ["yes", "separated", "both", "left"]
                     or x["sidewalk:both"] in ["yes", "separated", "both"])

    can_bike = (x["bicycle"] in ["yes", "designated"]
                and x["highway"] not in ['motorway', 'motorway_link'])  # should we add permissive?
    cannot_bike = (x["bicycle"] in ["no", "dismount", 'use_sidepath'] or
                   x["highway"] in ['corridor', 'motorway', 'motorway_link', 'trunk', 'trunk_link'] or
                   x["access"] in ['customers'])
    can_cardrive = x["highway"] in ["motorway", "trunk", "primary", "secondary", "tertiary", "unclassified", "road",
                                    "residential", "living_street",
                                    "primary_link", "secondary_link", "tertiary_link", 'motorway_link', 'trunk_link']

    is_bicycle_designated_left = ((is_designated or
                                   (x.get("cycleway:left:bicycle") == "designated")) or
                                  (x.get("cycleway:bicycle") == "designated"))
    is_bicycle_designated_right = (is_designated or
                                   (x.get("cycleway:right:bicycle") == "designated") or
                                   (x.get("cycleway:bicycle") == "designated"))

    is_pedestrian_designated_left = (x["foot"] == "designated" or
                                     x.get("sidewalk:left:foot") == "designated" or
                                     x.get("sidewalk:foot") == "designated")
    is_pedestrian_designated_right = (x["foot"] == "designated" or
                                      x.get("sidewalk:right:foot") == "designated" or
                                      x.get("sidewalk:foot") == "designated")

    is_bikepath_right = (x["highway"] == "cycleway"
                         or (any(key for key, value in x.items() if 'right:bicycle' in key and value in ['designated'])
                             and not any(key for key, value in x.items() if key == 'cycleway:right:lane'))
                         or x["cycleway"] in ["track", "sidepath", "crossing"]
                         or x["cycleway:right"] in ["track", "sidepath", "crossing"]
                         or x["cycleway:both"] in ["track", "sidepath", "crossing"]
                         or any(key for key, value in x.items() if 'right:traffic_sign' in key and value in ['237']))
    is_bikepath_left = (x["highway"] == "cycleway"
                        or (any(key for key, value in x.items() if 'left:bicycle' in key and value in ['designated'])
                            and not any(key for key, value in x.items() if key == 'cycleway:left:lane'))
                        or x["cycleway"] in ["track", "sidepath", "crossing"]
                        or x["cycleway:left"] in ["track", "sidepath", "crossing"]
                        or x["cycleway:both"] in ["track", "sidepath", "crossing"]
                        or any(key for key, value in x.items() if 'left:traffic_sign' in key and value in ['237']))

    #### Begin categories

    #service
    is_service = (is_service_tag or
                  (is_agricultural and is_accessible) or
                  (is_path and is_accessible) or
                  (is_track and is_accessible and is_smooth and is_vehicle_allowed)) and not is_designated

    #cycle highway
    is_cycle_highway = (x.get("cycle_highway") == "yes")

    #bicycle_road
    is_bikeroad = (x.get("bicycle_road") == "yes"
                   or x.get("cyclestreet") == "yes")

    #bicycle_way
    conditions_b_way_right = [
        is_bikepath_right and not can_walk_right,
        is_bikepath_right and is_segregated,
        can_bike and (is_path or is_track) and not can_walk_right,
        can_bike and (is_track or is_footpath or is_path) and is_segregated,
        can_bike and is_obligated_segregated,
        is_bicycle_designated_right and is_pedestrian_designated_right and is_segregated
    ]
    conditions_b_way_left = [
        is_bikepath_left and not can_walk_left,
        is_bikepath_left and is_segregated,
        can_bike and (is_path or is_track) and not can_walk_left,
        can_bike and (is_track or is_footpath or is_path) and is_segregated,
        can_bike and is_obligated_segregated,
        is_bicycle_designated_left and is_pedestrian_designated_left and is_segregated
    ]

    #bicycle_lane
    is_bikelane_right = (x["cycleway"] in ["lane", "shared_lane"]
                         or x["cycleway:right"] in ["lane", "shared_lane"]
                         or x["cycleway:both"] in ["lane", "shared_lane"]
                         or any(key for key, value in x.items() if 'right:lane' in key and value in ['exclusive']))
    is_bikelane_left = (x["cycleway"] in ["lane", "shared_lane"]
                        or x["cycleway:left"] in ["lane", "shared_lane"]
                        or x["cycleway:both"] in ["lane", "shared_lane"]
                        or any(key for key, value in x.items() if 'left:lane' in key and value in ['exclusive']))

    #bus_lane
    is_buslane_right = (x["cycleway"] == "share_busway"
                        or x["cycleway:right"] == "share_busway"
                        or x["cycleway:both"] == "share_busway")
    is_buslane_left = (x["cycleway"] == "share_busway"
                       or x["cycleway:left"] == "share_busway"
                       or x["cycleway:both"] == "share_busway")

    #mixed_way
    conditions_mixed_right = [
        is_bikepath_right and can_walk_right and not is_segregated,
        is_footpath and can_bike and not is_segregated,
        (is_path or is_track) and can_bike and can_walk_right and not is_segregated
    ]
    conditions_mixed_left = [
        is_bikepath_left and can_walk_left and not is_segregated,
        is_footpath and can_bike and not is_segregated,
        (is_path or is_track) and can_bike and can_walk_left and not is_segregated
    ]

    #mit_road
    conditions_mit_right = [
        can_cardrive and not is_bikepath_right and not is_bikeroad and not is_footpath and not is_bikelane_right and not is_buslane_right
        and not is_path and not is_track and not cannot_bike,
    ]
    conditions_mit_left = [
        can_cardrive and not is_bikepath_left and not is_bikeroad and not is_footpath and not is_bikelane_left and not is_buslane_left
        and not is_path and not is_track and not cannot_bike,
    ]

    #pedestrian
    is_pedestrian_right = (is_footpath and not can_bike and not is_indoor or
                           is_path and can_walk_right and not can_bike and not is_indoor)
    is_pedestrian_left = (is_footpath and not can_bike and not is_indoor or
                          is_path and can_walk_left and not can_bike and not is_indoor)

    #path not forbidden
    is_path_not_forbidden = ((x["highway"] in ["cycleway", "track", "path"])
                             and not cannot_bike)

    def get_infra(x):
        #### inaccessible roads
        if ('access' in x.values() and is_not_accessible(x)) or ('tram' in x.values() and x['tram'] == 'yes'):
            return 'no'  # unpacked from "service"

        #### service
        if is_service:
            return "service"

        #### cycle highway
        if is_cycle_highway:
            return "cycle_highway"

        #### bicycle_road
        if is_bikeroad:
            return "bicycle_road"

        #### bicycle way
        elif any(conditions_b_way_right):
            if any(conditions_b_way_left):
                return "bicycle_way_both"
            elif is_bikelane_left:
                return "bicycle_way_right_lane_left"
            elif is_buslane_left:
                return "bicycle_way_right_bus_left"
            elif any(conditions_mixed_left):
                return "bicycle_way_right_mixed_left"
            elif any(conditions_mit_left):
                return "bicycle_way_right_mit_left"
            elif is_pedestrian_left:
                return "bicycle_way_right_pedestrian_left"
            else:
                return "bicycle_way_right_no_left"

        elif any(conditions_b_way_left):
            if is_bikelane_right:
                return "bicycle_way_left_lane_right"
            elif is_buslane_right:
                return "bicycle_way_left_bus_right"
            elif any(conditions_mixed_right):
                return "bicycle_way_left_mixed_right"
            elif any(conditions_mit_right):
                return "bicycle_way_left_mit_right"
            elif is_pedestrian_right:
                return "bicycle_way_left_pedestrian_right"
            else:
                return "bicycle_way_left_no_right"

        #### bicycle lane
        elif is_bikelane_right:
            if is_bikelane_left:
                return "bicycle_lane_both"
            elif is_buslane_left:
                return "bicycle_lane_right_bus_left"
            elif any(conditions_mixed_left):
                return "bicycle_lane_right_mixed_left"
            elif any(conditions_mit_left):
                return "bicycle_lane_right_mit_left"
            elif is_pedestrian_left:
                return "bicycle_lane_right_pedestrian_left"
            else:
                return "bicycle_lane_right_no_left"

        elif is_bikelane_left:
            if is_buslane_right:
                return "bicycle_lane_left_bus_right"
            elif any(conditions_mixed_right):
                return "bicycle_lane_left_mixed_right"
            elif any(conditions_mit_right):
                return "bicycle_lane_left_mit_right"
            elif is_pedestrian_right:
                return "bicycle_lane_left_pedestrian_right"
            else:
                return "bicycle_lane_left_no_right"

        #### bus lane
        elif is_buslane_right:
            if is_buslane_left:
                return "bus_lane_both"
            elif any(conditions_mixed_left):
                return "bus_lane_right_mixed_left"
            elif any(conditions_mit_left):
                return "bus_lane_right_mit_left"
            elif is_pedestrian_left:
                return "bus_lane_right_pedestrian_left"
            else:
                return "bus_lane_right_no_left"

        elif is_buslane_left:
            if any(conditions_mixed_right):
                return "bus_lane_left_mixed_right"
            elif any(conditions_mit_right):
                return "bus_lane_left_mit_right"
            elif is_pedestrian_right:
                return "bus_lane_left_pedestrian_right"
            else:
                return "bus_lane_left_no_right"


        #### mixed way
        elif any(conditions_mixed_right):
            if any(conditions_mixed_left):
                return "mixed_way_both"
            elif any(conditions_mit_left):
                return "mixed_way_right_mit_left"
            elif is_pedestrian_left:
                return "mixed_way_right_pedestrian_left"
            else:
                return "mixed_way_right_no_left"

        elif any(conditions_mixed_left):
            if any(conditions_mit_right):
                return "mixed_way_left_mit_right"
            elif is_pedestrian_right:
                return "mixed_way_left_pedestrian_right"
            else:
                return "mixed_way_left_no_right"

        #### mit road
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

        #### pedestrian
        elif is_pedestrian_right and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
            if is_pedestrian_left and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
                if 'access' in x.values() and x['access'] == 'customers':
                    return "no"
                else:
                    return "pedestrian_both"
            else:
                return "pedestrian_right_no_left"


        elif is_pedestrian_left and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
            if 'access' in x.values() and x['access'] == 'customers':
                return "no"
            else:
                return "pedestrian_left_no_right"

        #### path not forbidden
        elif is_path_not_forbidden:
            return "path_not_forbidden"

        #### Fallback option: "no"
        else:
            return "no"

    cat = None
    cat = get_infra(x)
    # making sure that the variable cat has been filled
    assert (isinstance(cat, str))

    if ("_both" in cat) or (cat in ["no", "cycle_highway", "bicycle_road", "path_not_forbidden", "service"]):
        return cat
    else:
        # for categories with "right & left" - revert if needed
        if not is_reversed:
            return cat
        else:
            sides = ["left", "right"] if cat.split("_")[-1] == "right" else ["right", "left"]
            for side in sides:
                cat = " ".join(cat.split(side))

            res = cat.split()
            return res[0] + sides[1] + res[1] + sides[0]

if __name__ == "__main__":
    osm_file = pyrosm.OSM("../Bietigheim-Bissingen_osm.osm.pbf")
    osm = osm_file.get_network()
    osm['tags'] = osm['tags'].apply(json.loads)
    osm_normalized = pd.json_normalize(osm['tags'])
    osm_n = pd.concat([osm, osm_normalized])
    osm_prepared = osm_n[osm_n.columns.intersection(OSM_STREET_KEYS)]
    osm_prepared['reversed'] = 'no'
    osm_prepared['bicycle_infrastructure:forward'] = osm_prepared.apply(lambda x: derive_bicycle_infrastructure(x.to_dict()), axis=1)
