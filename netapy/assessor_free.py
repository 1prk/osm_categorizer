import overpy
import pandas as pd
from defaults import NETASCORE_STREET_KEYS

class Assessor():

    def __init__(self, osm_df=None):
        self.labs = ["highway", "cycleway", "segregated", "bicycle",
              "foot", "sidewalk", "bicycle_road", "cyclestreet",
              "reversed", "indoor", "access", "tram", 'traffic_sign', 'traffic_sign:forward',
              'cycleway:left', 'cycleway:right', 'cycleway:both',
              'sidewalk:left', 'sidewalk:right', 'sidewalk:both',
              "motor_vehicle", "tracktype",
              "cycle_highway"]
        self.nested_labs_prefix = ['cycleway:left', 'cycleway:right', 'cycleway:both',
                            'sidewalk:left', 'sidewalk:right', 'sidewalk:both']
        self.nested_labs_suffix = ['bicycle', 'lane', 'segregated', 'oneway', 'foot', 'traffic_sign']
        self.nested_labs = [prefix + ':' + suffix for prefix in self.nested_labs_prefix for suffix in self.nested_labs_suffix]
        self.labs = self.labs.extend(self.nested_labs)

    def _test_osm_way(self, osm_id):
        overpass_api = overpy.Overpass()
        overpass_query = f"way({osm_id});(._;>;);out body;"
        result = overpass_api.query(overpass_query)
        way = result.ways[0].tags
        return way

    #optional:
    def col_parser(self, osm_df):
        # parse = []
        # for index, row in osm_df.iterrows():
        #     # Split the tag_string by commas to separate out each key-value pair
        #     pairs = row['tag_string'].split(',')
        #     # Split each pair by '=>' and form a dictionary of key-value pairs
        #     row_data = {kv.split('=>')[0]: kv.split('=>')[1] for kv in pairs if '=>' in kv}
        #     parse.append(row_data)
        # sr_buffer_tags = pd.DataFrame(parse)
        # dropcol = [col for col in NETASCORE_STREET_KEYS if col in sr_buffer_tags.columns]
        # sr_buffer_tags = sr_buffer_tags[dropcol]
        raise NotImplementedError

    def set_value(self, x, sides = "double"):
        is_reversed = x["reversed"]
        is_segregated = any(key for key, value in x.items() if 'segregated' in key and value == 'yes') #and no "nos" in segregated, zB 4746913 hat cycleway:left:segregated = no !
        is_footpath = x["highway"] in ["footway", "pedestrian"]
        is_not_accessible = x["access"] == "no"
        use_sidepath = any(key for key, value in x.items() if 'bicycle' in key and value == 'use_sidepath')

        is_indoor = x['indoor'] == 'yes'
        is_path = x["highway"] in ["path"]
        is_track = x["highway"] in ["track"]

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

        # maybe we have to explicitly distinguish between when bicycle is empty (null) or when bicycle is explicitly NO or DISMOUNT
        can_bike = (x["bicycle"] in ["yes", "designated"]
                    and x["highway"] not in ['motorway', 'motorway_link']) #should we add permissive?

        cannot_bike = (x["bicycle"] in ["no", "dismount", 'use_sidepath'] or
                       x["highway"] in ['corridor', 'motorway', 'motorway_link', 'trunk', 'trunk_link'] or
                       x["access"] in ['customers'])

        is_obligated_segregated = (
                ('traffic_sign' in x.keys() and isinstance(x['traffic_sign'], str) and '241' in x['traffic_sign'])
                or ('traffic_sign:forward' in x.keys() and isinstance(x['traffic_sign:forward'], str) and '241' in x[
          'traffic_sign:forward'])
        )

        is_designated = x["bicycle"] == "designated"

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

        is_service = x["highway"] in ["service"]  # , "living_street"]
        is_agricultural = x.get("motor_vehicle") in ["agricultural", "forestry"]
        is_accessible = pd.isnull(x["access"]) or not is_not_accessible
        is_smooth = pd.isnull(x["tracktype"]) or x["tracktype"] in ["grade1", "grade2"]
        is_vehicle_allowed = pd.isnull(x.get("motor_vehicle")) or x.get("motor_vehicle") != "no"

        is_service = (is_service or
                      (is_agricultural and is_accessible) or
                      (is_track and is_accessible and is_smooth and is_vehicle_allowed)) and not is_designated

        # should be changed to (or at least sometimes alternatively used as) "not cannot_bike?". It can be used at least for x["highway"] == "cycleway", where adding bicycle tag seems redundant.
        # The condition could be than split: (x["highway"] == "cycleway" and not cannot_bike) OR (the_rest and can_bike)
        can_cardrive = x["highway"] in ["motorway", "trunk", "primary", "secondary", "tertiary", "unclassified", "road",
                                        "residential", "living_street",
                                        "primary_link", "secondary_link", "tertiary_link", 'motorway_link',
                                        'trunk_link']

        is_path_not_forbidden = ((x["highway"] in ["cycleway", "track", "path"])
                                 and not cannot_bike)

        is_bikepath_right = (x["highway"] == "cycleway"
                             or (any(
                    key for key, value in x.items() if 'right:bicycle' in key and value in ['designated'])
                                 and not any(key for key, value in x.items() if key == 'cycleway:right:lane'))
                             or x["cycleway"] in ["track", "sidepath", "crossing"]
                             or x["cycleway:right"] in ["track", "sidepath", "crossing"]
                             or x["cycleway:both"] in ["track", "sidepath", "crossing"]
                             or any(
                    key for key, value in x.items() if 'right:traffic_sign' in key and value in ['237']))
        is_bikepath_left = (x["highway"] == "cycleway"
                            or (any(
                    key for key, value in x.items() if 'left:bicycle' in key and value in ['designated'])
                                and not any(key for key, value in x.items() if key == 'cycleway:left:lane'))
                            or x["cycleway"] in ["track", "sidepath", "crossing"]
                            or x["cycleway:left"] in ["track", "sidepath", "crossing"]
                            or x["cycleway:both"] in ["track", "sidepath", "crossing"]
                            or any(key for key, value in x.items() if 'left:traffic_sign' in key and value in ['237']))

        #### Begin categories
        ##infrastructure designated for pedestrians
        is_pedestrian_right = (is_footpath and not can_bike and not is_indoor or is_path and can_walk_right
                               and not can_bike and not is_indoor)  # alternatively: (is_path or is_track)?

        is_pedestrian_left = (is_footpath and not can_bike and not is_indoor or is_path and can_walk_left
                              and not can_bike and not is_indoor)  # alternatively: (is_path or is_track)?

        is_cycle_highway = (x.get("cycle_highway") == "yes")

        ##bicycle_road
        is_bikeroad = (x["bicycle_road"] == "yes"
                       or x["cyclestreet"] == "yes")

        ##Straßenbegleitender Radweg benutzungspflichtig
        is_bikelane_right = (x["cycleway"] in ["lane", "shared_lane"]
                             or x["cycleway:right"] in ["lane", "shared_lane"]
                             or x["cycleway:both"] in ["lane", "shared_lane"]
                             or any(key for key, value in x.items() if 'right:lane' in key and value in ['exclusive']))

        is_bikelane_left = (x["cycleway"] in ["lane", "shared_lane"]
                            or x["cycleway:left"] in ["lane", "shared_lane"]
                            or x["cycleway:both"] in ["lane", "shared_lane"]
                            or any(key for key, value in x.items() if 'left:lane' in key and value in ['exclusive']))


        ##schutzstreifen/radfahrstreifen
        ##bus
        is_buslane_right = (x["cycleway"] == "share_busway"
                            or x["cycleway:right"] == "share_busway"
                            or x["cycleway:both"] == "share_busway")
        is_buslane_left = (x["cycleway"] == "share_busway"
                           or x["cycleway:left"] == "share_busway"
                           or x["cycleway:both"] == "share_busway")


        ## bicycle_way
        # First option: "bicycle_way_right"
        conditions_b_way_right = [
            is_bikepath_right and not can_walk_right,  # 0 and 1
            is_bikepath_right and is_segregated,  # 0 and 2
            can_bike and (is_path or is_track) and not can_walk_right,  # and not is_footpath, #3, 4, 1
            can_bike and (is_track or is_footpath or is_path) and is_segregated,  # b_way_right_5 #3, 6, 2
            can_bike and is_obligated_segregated,  # 3,7
            is_bicycle_designated_right and is_pedestrian_designated_right and is_segregated
        ]

        conditions_b_way_left = [
            is_bikepath_left and not can_walk_left,  # b_way_left_0
            is_bikepath_left and is_segregated,  # b_way_left_1
            can_bike and (is_path or is_track) and not can_walk_left,  # and not is_footpath, #3, 4, 1
            can_bike and (is_track or is_footpath or is_path) and is_segregated,  # b_way_left_5
            can_bike and is_obligated_segregated,  # b_way_left_6
            is_bicycle_designated_left and is_pedestrian_designated_left and is_segregated
        ]

        # Second option: "mixed_way"
        ##mixed
        conditions_mixed_right = [
            is_bikepath_right and can_walk_right and not is_segregated,  # 0 and 1 and 2
            is_footpath and can_bike and not is_segregated,  # 3 and 4 and 2
            (is_path or is_track) and can_bike and can_walk_right and not is_segregated  # 5 and 4 and 1 and 2
        ]
        conditions_mixed_left = [
            is_bikepath_left and can_walk_left and not is_segregated,  # mixed_left_0
            is_footpath and can_bike and not is_segregated,  # mixed_left_1
            (is_path or is_track) and can_bike and can_walk_left and not is_segregated  # mixed_left_2
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

        if sides == "double":
            def get_infra(self, x):

                if ('access' in x.index and is_not_accessible) or ('tram' in x.index and x['tram'] == 'yes'):
                    return 'no'  # unpacked from "service"
                # remove service right away

                if is_service:
                    return "service_misc"

                if is_cycle_highway:
                    return "cycle_highway"

                #### 3 # new option: "bicycle_road"
                if is_bikeroad:
                    return "bicycle_road"

                #### 1
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

                #### 4 # Third option: "bicycle_lane"
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

                #### 5 # Fourth option: "bus_lane"
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


                #### 2
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
                elif is_pedestrian_right and (not 'indoor' in x.values or (x['indoor'] != 'yes')):
                    if is_pedestrian_left and (not 'indoor' in x.values or (x['indoor'] != 'yes')):
                        if 'access' in x.index and x['access'] == 'customers':
                            return "no"
                        else:
                            return "pedestrian_both"
                    else:
                        return "pedestrian_right_no_left"


                elif is_pedestrian_left and (not 'indoor' in x.values or (x['indoor'] != 'yes')):
                    if 'access' in x.index and x['access'] == 'customers':
                        return "no"
                    else:
                        return "pedestrian_left_no_right"

                elif is_path_not_forbidden:
                    return "path_not_forbidden"

                #### Fallback option: "no"
                else:
                    return "no"

            cat = None
            cat = get_infra(x)
            # making sure that the variable cat has been filled
            assert (isinstance(cat, str))

            if ("_both" in cat) or (
                    cat in ["no", "cycle_highway", "bicycle_road", "path_not_forbidden", "service_misc"]):
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

        else:
            assert(sides == "single")

            def get_infra(self, x):

                if ('access' in x.index and is_not_accessible) or ('tram' in x.index and x['tram'] == 'yes'):
                    return 'no'  # unpacked from "service"
                # remove service right away

                if is_service:
                    return "service_misc"

                if is_cycle_highway:
                    return "cycle_highway"

                #### 3 # new option: "bicycle_road"
                if is_bikeroad:
                    return "bicycle_road"

                #### 1
                elif any(conditions_b_way_left) or any(conditions_b_way_right):
                    return "bicycle_way"

                #### 4 # Third option: "bicycle_lane"
                elif is_bikelane_left or is_bikelane_right:
                    return "bicycle_lane"

                #### 5 # Fourth option: "bus_lane"
                elif is_buslane_left or is_buslane_right:
                    return "bus_lane"

                #### 2
                elif any(conditions_mixed_left) or any(conditions_mixed_right):
                    return "mixed_way"

                #### 6
                elif any(conditions_mit_left) or any(conditions_mit_right):
                    return "mit_road"

                elif is_pedestrian_left or is_pedestrian_right and (not 'indoor' in x.values or (x['indoor'] != 'yes')):
                    if 'access' in x.index and x['access'] == 'customers':
                        return "no"
                    else:
                        return "pedestrian"

                elif is_path_not_forbidden:
                    return "path_not_forbidden"

                #### Fallback option: "no"
                else:
                    return "no"

            cat = None
            cat = get_infra(x)
            # making sure that the variable cat has been filled
            assert (isinstance(cat, str))

            return cat