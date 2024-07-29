import json

import overpy
import pandas as pd
import geopandas as gpd
from netapy import defaults
from tqdm import tqdm

class Assessor():

    def __init__(self):
        self.STREET_KEYS = defaults.NETASCORE_STREET_KEYS.copy()
        self.STREET_KEYS.append("reversed")

        # Conditions as objects
        self.is_reversed = lambda x: x["reversed"] if "reversed" in x else False
        self.is_segregated = lambda x: any(key for key, value in x.items() if
                                      'segregated' in key and value == 'yes')  # and no "nos" in segregated, zB 4746913 hat cycleway:left:segregated = no !
        self.is_footpath = lambda x: x["highway"] in ["footway", "pedestrian"]
        self.is_not_accessible = lambda x: x.get("access") == "no"
        self.use_sidepath = lambda x: any(key for key, value in x.items() if 'bicycle' in key and value == 'use_sidepath')

        self.is_indoor = lambda x: x.get('indoor') == 'yes'
        self.is_path = lambda x: x["highway"] in ["path"]
        self.is_track = lambda x: x["highway"] in ["track"]

        self.can_walk_right = lambda x: (x.get("foot") in ["yes", "designated"]
                                    or any(
                    key for key, value in x.items() if 'right:foot' in key and value in ['yes', 'designated'])
                                    or x.get("sidewalk") in ["yes", "separated", "both", "right", "left"]
                                    or x.get("sidewalk:right") in ["yes", "separated", "both", "right"]
                                    or x.get("sidewalk:both") in ["yes", "separated", "both"])

        self.can_walk_left = lambda x: (x.get("foot") in ["yes", "designated"]
                                   or any(
                    key for key, value in x.items() if 'left:foot' in key and value in ['yes', 'designated'])
                                   or x.get("sidewalk") in ["yes", "separated", "both", "right", "left"]
                                   or x.get("sidewalk:left") in ["yes", "separated", "both", "left"]
                                   or x.get("sidewalk:both") in ["yes", "separated", "both"])

        self.can_bike = lambda x: (x.get("bicycle") in ["yes", "designated"]
                              and x.get("highway") not in ['motorway', 'motorway_link'])  # should we add permissive?

        self.cannot_bike = lambda x: (x.get("bicycle") in ["no", "dismount", 'use_sidepath'] or
                                 x.get("highway") in ['corridor', 'motorway', 'motorway_link', 'trunk', 'trunk_link'] or
                                 x.get("access") in ['customers'])

        self.is_obligated_segregated = lambda x: (
                ('traffic_sign' in x.keys() and isinstance(x['traffic_sign'], str) and '241' in x['traffic_sign'])
                or ('traffic_sign:forward' in x.keys() and isinstance(x['traffic_sign:forward'], str) and '241' in x[
            'traffic_sign:forward'])
        )

        self.is_designated = lambda x: x.get("bicycle") == "designated"

        self.is_bicycle_designated_left = lambda x: ((self.is_designated(x) or
                                                 (x.get("cycleway:left:bicycle") == "designated")) or
                                                (x.get("cycleway:bicycle") == "designated"))

        self.is_bicycle_designated_right = lambda x: (self.is_designated(x) or
                                                 (x.get("cycleway:right:bicycle") == "designated") or
                                                 (x.get("cycleway:bicycle") == "designated"))

        self.is_pedestrian_designated_left = lambda x: (x.get("foot") == "designated" or
                                                   x.get("sidewalk:left:foot") == "designated" or
                                                   x.get("sidewalk:foot") == "designated")

        self.is_pedestrian_designated_right = lambda x: (x.get("foot") == "designated" or
                                                    x.get("sidewalk:right:foot") == "designated" or
                                                    x.get("sidewalk:foot") == "designated")

        self.is_service_tag = lambda x: x["highway"] in ["service"]  # , "living_street"]
        self.is_agricultural = lambda x: x.get("motor_vehicle") in ["agricultural", "forestry"]
        self.is_accessible = lambda x: pd.isnull(x["access"]) or not self.is_not_accessible(x)
        self.is_smooth = lambda x: pd.isnull(x["tracktype"]) or x["tracktype"] in ["grade1", "grade2"]
        self.is_vehicle_allowed = lambda x: pd.isnull(x.get("motor_vehicle")) or x.get("motor_vehicle") != "no"

        self.is_service = lambda x: (self.is_service_tag(x) or
                                (self.is_agricultural(x) and self.is_accessible(x)) or
                                (self.is_path(x) and self.is_accessible(x)) or
                                (self.is_track(x) and self.is_accessible(x) and self.is_smooth(x) and self.is_vehicle_allowed(
                                    x))) and not self.is_designated(x)

        self.can_cardrive = lambda x: x["highway"] in ["motorway", "trunk", "primary", "secondary", "tertiary",
                                                  "unclassified", "road",
                                                  "residential", "living_street",
                                                  "primary_link", "secondary_link", "tertiary_link", 'motorway_link',
                                                  'trunk_link']

        self.is_path_not_forbidden = lambda x: ((x["highway"] in ["cycleway", "track", "path"])
                                           and not self.cannot_bike(x))

        self.is_bikepath_right = lambda x: (x["highway"] == "cycleway"
                                       or (any(
                    key for key, value in x.items() if 'right:bicycle' in key and value in ['designated'])
                                           and not any(key for key, value in x.items() if key == 'cycleway:right:lane'))
                                       or x.get("cycleway") in ["track", "sidepath", "crossing"]
                                       or x.get("cycleway:right") in ["track", "sidepath", "crossing"]
                                       or x.get("cycleway:both") in ["track", "sidepath", "crossing"]
                                       or any(
                    key for key, value in x.items() if 'right:traffic_sign' in key and value in ['237']))
        self.is_bikepath_left = lambda x: (x["highway"] == "cycleway"
                                      or (any(
                    key for key, value in x.items() if 'left:bicycle' in key and value in ['designated'])
                                          and not any(key for key, value in x.items() if key == 'cycleway:left:lane'))
                                      or x.get("cycleway") in ["track", "sidepath", "crossing"]
                                      or x.get("cycleway:left") in ["track", "sidepath", "crossing"]
                                      or x.get("cycleway:both") in ["track", "sidepath", "crossing"]
                                      or any(
                    key for key, value in x.items() if 'left:traffic_sign' in key and value in ['237']))

        ##infrastructure designated for pedestrians

        self.is_pedestrian_right = lambda x: ((self.is_footpath(x) and not self.can_bike(x) and not self.is_indoor(x))
                                          or (self.is_path(x) and self.can_walk_right(x) and not self.can_bike(x) and not self.is_indoor(x)))
        self.is_pedestrian_left = lambda x: ((self.is_footpath(x) and not self.can_bike(x) and not self.is_indoor(x))
                                        or (self.is_path(x) and self.can_walk_left(x) and not self.can_bike(x) and not self.is_indoor(x)))
        ### Begin categories


        self.is_cycle_highway = lambda x: (x.get("cycle_highway") == "yes")

        ##bicycle_road
        self.is_bikeroad = lambda x: (x.get("bicycle_road") == "yes" or x.get("cyclestreet") == "yes")

        ##Straßenbegleitender Radweg benutzungspflichtig
        self.is_bikelane_right = lambda x: (x.get("cycleway") in ["lane", "shared_lane"]
                                       or x.get("cycleway:right") in ["lane", "shared_lane"]
                                       or x.get("cycleway:both") in ["lane", "shared_lane"]
                                       or any(
                    key for key, value in x.items() if 'right:lane' in key and value in ['exclusive']))

        self.is_bikelane_left = lambda x: (x.get("cycleway") in ["lane", "shared_lane"]
                                      or x.get("cycleway:left") in ["lane", "shared_lane"]
                                      or x.get("cycleway:both") in ["lane", "shared_lane"]
                                      or any(
                    key for key, value in x.items() if 'left:lane' in key and value in ['exclusive']))

        ##schutzstreifen/radfahrstreifen
        ##bus
        self.is_buslane_right = lambda x: (x.get("cycleway") == "share_busway"
                                      or x.get("cycleway:right") == "share_busway"
                                      or x.get("cycleway:both") == "share_busway")
        self.is_buslane_left = lambda x: (x.get("cycleway") == "share_busway"
                                     or x.get("cycleway:left") == "share_busway"
                                     or x.get("cycleway:both") == "share_busway")

    def test_osm_way(self, osm_id):
        overpass_api = overpy.Overpass()
        overpass_query = f"way({osm_id});(._;>;);out body;"
        result = overpass_api.query(overpass_query)
        way = result.ways[0].tags
        return way

    #remove unneccesary street keys to speed up processing
    def _prepare_way(self, way_dict):
        if isinstance(way_dict, gpd.GeoDataFrame):
            if 'tags' in way_dict.columns:
                way_gdf = self._assess_directionality(way_dict) # explodes gdf and assesses whether linestrings are reversed or not
                way_gdf['tags'] = way_gdf['tags'].apply(json.loads)
                way_n = pd.concat([way_gdf, pd.json_normalize(way_gdf['tags'])], axis=1)
                way_n = way_n[way_n.columns.intersection(self.STREET_KEYS)]
                way_dictionary = way_n.to_dict('records')
                return way_dictionary

            elif 'tag_string' in way_dict.columns:
                parse = []
                for index, row in way_dict.iterrows():
                    pairs = row['tag_string'].split(',')
                    row_data = {kv.split('=>')[0]: kv.split('=>')[1] for kv in pairs if '=>' in kv}
                    parse.append(row_data)
                way_dataframe = pd.DataFrame(parse)
                dropcol = [col for col in self.STREET_KEYS if col in way_dataframe.columns]
                way_dataframe = way_dataframe[dropcol]
                way_dictionary = way_dataframe.to_dict('records')
                return way_dictionary

            else:
                raise ValueError("OSM dataframe must contain a tag column")

        elif isinstance(way_dict, dict):
            return {k: v for k, v in way_dict.items() if k in self.STREET_KEYS}

        else:
            raise TypeError("invalid format")

    def _assess_directionality(self, way_gdf):
        way_gdf_exp = way_gdf.explode().reset_index().drop(columns=['level_0', 'level_1'])
        way_gdf_exp['start_point'] = way_gdf_exp['geometry'].apply(lambda x: list(x.coords)[0])
        way_gdf_exp['end_point'] = way_gdf_exp['geometry'].apply(lambda x: list(x.coords)[1])
        way_gdf_exp['reversed'] = way_gdf_exp.apply(lambda x: x['end_point'] < x['start_point'], axis=1)
        return way_gdf_exp

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
        if not isinstance(x, dict):
            raise TypeError("rowwise OSM data should be a dict")

        # should be changed to (or at least sometimes alternatively used as) "not cannot_bike?". It can be used at least for x["highway"] == "cycleway", where adding bicycle tag seems redundant.
        # The condition could be than split: (x["highway"] == "cycleway" and not cannot_bike) OR (the_rest and can_bike)

        ## bicycle_way
        # First option: "bicycle_way_right"
        conditions_b_way_right = [
            self.is_bikepath_right(x) and not self.can_walk_right(x),  # 0 and 1
            self.is_bikepath_right(x) and self.is_segregated(x),  # 0 and 2
            self.can_bike(x) and (self.is_path(x) or self.is_track(x)) and not self.can_walk_right(x),  # and not is_footpath, #3, 4, 1
            self.can_bike(x) and (self.is_track(x) or self.is_footpath(x) or self.is_path(x)) and self.is_segregated(x),  # b_way_right_5 #3, 6, 2
            self.can_bike(x) and self.is_obligated_segregated(x),  # 3,7
            self.is_bicycle_designated_right and self.is_pedestrian_designated_right(x) and self.is_segregated(x)
        ]

        conditions_b_way_left = [
            self.is_bikepath_left(x) and not self.can_walk_left(x),  # 0 and 1
            self.is_bikepath_left(x) and self.is_segregated(x),  # 0 and 2
            self.can_bike(x) and (self.is_path(x) or self.is_track(x)) and not self.can_walk_left(x),  # and not is_footpath, #3, 4, 1
            self.can_bike(x) and (self.is_track(x) or self.is_footpath(x) or self.is_path(x)) and self.is_segregated(x),  # b_way_right_5 #3, 6, 2
            self.can_bike(x) and self.is_obligated_segregated(x),  # 3,7
            self.is_bicycle_designated_left and self.is_pedestrian_designated_left(x) and self.is_segregated(x)
        ]

        # Second option: "mixed_way"
        ##mixed
        conditions_mixed_right = [
            self.is_bikepath_right(x) and self.can_walk_right(x) and not self.is_segregated(x),  # 0 and 1 and 2
            self.is_footpath(x) and self.can_bike(x) and not self.is_segregated(x),  # 3 and 4 and 2
            (self.is_path(x) or self.is_track(x)) and self.can_bike(x) and self.can_walk_right(x) and not self.is_segregated(x)  # 5 and 4 and 1 and 2
        ]
        conditions_mixed_left = [
            self.is_bikepath_left(x) and self.can_walk_left(x) and not self.is_segregated(x),  # 0 and 1 and 2
            self.is_footpath(x) and self.can_bike(x) and not self.is_segregated(x),  # 3 and 4 and 2
            (self.is_path(x) or self.is_track(x)) and self.can_bike(x) and self.can_walk_left(x) and not self.is_segregated(x)  # 5 and 4 and 1 and 2
        ]

        # Add. Option: mit_road
        ##mit
        conditions_mit_right = [
            self.can_cardrive(x) and not self.is_bikepath_right(x) and not self.is_bikeroad(x) and not self.is_footpath(x) and not self.is_bikelane_right(x) and not self.is_buslane_right(x)
            and not self.is_path(x) and not self.is_track(x) and not self.cannot_bike(x),
        ]
        conditions_mit_left = [
            self.can_cardrive(x) and not self.is_bikepath_left(x) and not self.is_bikeroad(x) and not self.is_footpath(x) and not self.is_bikelane_left(x) and not self.is_buslane_left(x)
            and not self.is_path(x) and not self.is_track(x) and not self.cannot_bike(x),
        ]

        # ##infrastructure designated for pedestrians
        # is_pedestrian_right = lambda x: ((self.is_footpath(x) and not self.can_bike(x) and not self.is_indoor(x))
        #                                  or (self.is_path(x) and self.can_walk_right(x) and not self.can_bike(x) and not self.is_indoor(x)))  # alternatively: (is_path or is_track)?
        #
        # is_pedestrian_left = lambda x: ((self.is_footpath(x) and not self.can_bike(x) and not self.is_indoor(x))
        #                                 or (self.is_path(x) and self.can_walk_left(x) and not self.can_bike(x) and not self.is_indoor(x)))  # alternatively: (is_path or is_track)?

        if sides == "double":
            def get_infra(x):

                if ('access' in x.values() and self.is_not_accessible(x)) or ('tram' in x.values() and x['tram'] == 'yes'):
                    return 'no'  # unpacked from "service"
                # remove service right away

                if self.is_service(x):
                    return "service_misc"

                if self.is_cycle_highway(x):
                    return "cycle_highway"

                #### 3 # new option: "bicycle_road"
                if self.is_bikeroad(x):
                    return "bicycle_road"

                #### 1
                elif any(conditions_b_way_right):
                    if any(conditions_b_way_left):
                        return "bicycle_way_both"
                    elif self.is_bikelane_left(x):
                        return "bicycle_way_right_lane_left"
                    elif self.is_buslane_left(x):
                        return "bicycle_way_right_bus_left"
                    elif any(conditions_mixed_left):
                        return "bicycle_way_right_mixed_left"
                    elif any(conditions_mit_left):
                        return "bicycle_way_right_mit_left"
                    elif self.is_pedestrian_left(x):
                        return "bicycle_way_right_pedestrian_left"
                    else:
                        return "bicycle_way_right_no_left"

                elif any(conditions_b_way_left):
                    if self.is_bikelane_right(x):
                        return "bicycle_way_left_lane_right"
                    elif self.is_buslane_right(x):
                        return "bicycle_way_left_bus_right"
                    elif any(conditions_mixed_right):
                        return "bicycle_way_left_mixed_right"
                    elif any(conditions_mit_right):
                        return "bicycle_way_left_mit_right"
                    elif self.is_pedestrian_right(x):
                        return "bicycle_way_left_pedestrian_right"
                    else:
                        return "bicycle_way_left_no_right"

                #### 4 # Third option: "bicycle_lane"
                elif self.is_bikelane_right(x):
                    if self.is_bikelane_left(x):
                        return "bicycle_lane_both"
                    elif self.is_buslane_left(x):
                        return "bicycle_lane_right_bus_left"
                    elif any(conditions_mixed_left):
                        return "bicycle_lane_right_mixed_left"
                    elif any(conditions_mit_left):
                        return "bicycle_lane_right_mit_left"
                    elif self.is_pedestrian_left(x):
                        return "bicycle_lane_right_pedestrian_left"
                    else:
                        return "bicycle_lane_right_no_left"

                elif self.is_bikelane_left(x):
                    if self.is_buslane_right(x):
                        return "bicycle_lane_left_bus_right"
                    elif any(conditions_mixed_right):
                        return "bicycle_lane_left_mixed_right"
                    elif any(conditions_mit_right):
                        return "bicycle_lane_left_mit_right"
                    elif self.is_pedestrian_right(x):
                        return "bicycle_lane_left_pedestrian_right"
                    else:
                        return "bicycle_lane_left_no_right"

                #### 5 # Fourth option: "bus_lane"
                elif self.is_buslane_right(x):
                    if self.is_buslane_left(x):
                        return "bus_lane_both"
                    elif any(conditions_mixed_left):
                        return "bus_lane_right_mixed_left"
                    elif any(conditions_mit_left):
                        return "bus_lane_right_mit_left"
                    elif self.is_pedestrian_left(x):
                        return "bus_lane_right_pedestrian_left"
                    else:
                        return "bus_lane_right_no_left"

                elif self.is_buslane_left(x):
                    if any(conditions_mixed_right):
                        return "bus_lane_left_mixed_right"
                    elif any(conditions_mit_right):
                        return "bus_lane_left_mit_right"
                    elif self.is_pedestrian_right(x):
                        return "bus_lane_left_pedestrian_right"
                    else:
                        return "bus_lane_left_no_right"


                #### 2
                elif any(conditions_mixed_right):
                    if any(conditions_mixed_left):
                        return "mixed_way_both"
                    elif any(conditions_mit_left):
                        return "mixed_way_right_mit_left"
                    elif self.is_pedestrian_left(x):
                        return "mixed_way_right_pedestrian_left"
                    else:
                        return "mixed_way_right_no_left"

                elif any(conditions_mixed_left):
                    if any(conditions_mit_right):
                        return "mixed_way_left_mit_right"
                    elif self.is_pedestrian_right(x):
                        return "mixed_way_left_pedestrian_right"
                    else:
                        return "mixed_way_left_no_right"

                #### 6
                elif any(conditions_mit_right):
                    if any(conditions_mit_left):
                        return "mit_road_both"
                    elif self.is_pedestrian_left(x):
                        return "mit_road_right_pedestrian_left"
                    else:
                        return "mit_road_right_no_left"

                elif any(conditions_mit_left):
                    if self.is_pedestrian_right(x):
                        return "mit_road_left_pedestrian_right"
                    else:
                        return "mit_road_left_no_right"

                #### 8
                elif self.is_pedestrian_right(x) and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
                    if self.is_pedestrian_left(x) and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
                        if 'access' in x.values() and x['access'] == 'customers':
                            return "no"
                        else:
                            return "pedestrian_both"
                    else:
                        return "pedestrian_right_no_left"


                elif self.is_pedestrian_left(x) and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
                    if 'access' in x.values() and x['access'] == 'customers':
                        return "no"
                    else:
                        return "pedestrian_left_no_right"

                elif self.is_path_not_forbidden(x):
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
                if not self.is_reversed(x):
                    return cat
                else:
                    sides = ["left", "right"] if cat.split("_")[-1] == "right" else ["right", "left"]
                    for side in sides:
                        cat = " ".join(cat.split(side))

                    res = cat.split()
                    return res[0] + sides[1] + res[1] + sides[0]

        else:
            assert(sides == "single")


            def get_infra(x):
                if ('access' in x.values() and self.is_not_accessible(x)) or ('tram' in x.values() and x['tram'] == 'yes'):
                    return 'no'  # unpacked from "service"
                # remove service right away

                if self.is_service(x):
                    return "service_misc"

                if self.is_cycle_highway(x):
                    return "cycle_highway"

                #### 3 # new option: "bicycle_road"
                if self.is_bikeroad(x):
                    return "bicycle_road"

                #### 1
                elif any(conditions_b_way_left) or any(conditions_b_way_right):
                    return "bicycle_way"

                #### 4 # Third option: "bicycle_lane"
                elif self.is_bikelane_left(x) or self.is_bikelane_right(x):
                    return "bicycle_lane"

                #### 5 # Fourth option: "bus_lane"
                elif self.is_buslane_left(x) or self.is_buslane_right(x):
                    return "bus_lane"

                #### 2
                elif any(conditions_mixed_left) or any(conditions_mixed_right):
                    return "mixed_way"

                #### 6
                elif any(conditions_mit_left) or any(conditions_mit_right):
                    return "mit_road"

                elif (self.is_pedestrian_left(x) or self.is_pedestrian_right(x)) and (not 'indoor' in x.values() or (x['indoor'] != 'yes')):
                    if 'access' in x.values() and x['access'] == 'customers':
                        return "no"
                    else:
                        return "pedestrian"

                elif self.is_path_not_forbidden(x):
                    return "path_not_forbidden"

                #### Fallback option: "no"
                else:
                    return "no"

            cat = None
            cat = get_infra(x)
            # making sure that the variable cat has been filled
            assert (isinstance(cat, str))

            return cat

    def assess(self, osm_df):
        try:
            prepared_data = self._prepare_way(osm_df)

            osm_infra = []
            for kante in tqdm(prepared_data, total=len(prepared_data)):
                result = self.set_value(kante)
                osm_infra.append(result)
            osm_df = osm_df.explode()
            osm_df['bicycle_infrastructure:forward'] = osm_infra
            return osm_df

        except Exception as e:
            print(f"An error occurred during assessment: {str(e)}")
            return None