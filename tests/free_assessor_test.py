import pyrosm
import json
import pandas as pd
import unittest
import warnings
from netapy import defaults, assessor_free

warnings.simplefilter(action='ignore', category=FutureWarning)


class LoadOSM(unittest.TestCase):

    def setUp(self):
        self.osm_file = pyrosm.OSM("../Wedel_highway.osm.pbf")
        self.osm = self.osm_file.get_network()
        self.assessor = assessor_free.Assessor()
        # self.kante = {'access': None, 'bicycle': None, 'bicycle_road': None, 'bridge': None, 'cycleway': None, 'foot': 'yes', 'footway': None, 'highway': 'footway', 'junction': None, 'lanes': None, 'maxspeed': None, 'name': None, 'oneway': None, 'service': None, 'segregated': None, 'sidewalk': None, 'smoothness': None, 'surface': None, 'tracktype': None, 'tunnel': None, 'width': None, 'reversed': True, 'lanes:backward': nan, 'lanes:forward': nan, 'sidewalk:both': nan, 'cycleway:both': nan, 'cycleway:left': nan, 'cycleway:right': nan, 'traffic_sign': nan, 'sidewalk:left': nan, 'sidewalk:right': nan, 'cycleway:left:bicycle': nan, 'cycleway:left:segregated': nan, 'cycleway:right:bicycle': nan, 'cycleway:right:oneway': nan, 'cycleway:right:traffic_sign': nan, 'sidewalk:both:bicycle': nan, 'cycleway:both:lane': nan, 'cycleway:left:lane': nan, 'cycleway:left:traffic_sign': nan, 'cycleway:left:oneway': nan, 'cycleway:both:segregated': nan, 'indoor': nan, 'sidewalk:right:bicycle': nan, 'cycleway:both:bicycle': nan, 'cycleway:both:oneway': nan, 'cycleway:both:traffic_sign': nan, 'traffic_sign:forward': nan, 'sidewalk:right:oneway': nan, 'sidewalk:left:bicycle': nan, 'cycleway:bicycle': nan, 'sidewalk:left:foot': nan, 'sidewalk:left:oneway': nan, 'cycleway:left:foot': nan, 'sidewalk:right:foot': nan, 'sidewalk:right:segregated': nan}
ef =

    def test_dataframe_load(self):
        """Test if loading a dataframe works"""
        self.osm.loc[:, 'tags'] = self.osm['tags'].apply(json.loads)
        osm_normalized = pd.json_normalize(self.osm['tags'])

        # Check if DataFrame has been created and not empty
        self.assertTrue(isinstance(osm_normalized, pd.DataFrame))
        self.assertFalse(osm_normalized.empty)

    def test_way_preparation(self):
        result = self.assessor._prepare_way(self.osm)

        self.assertTrue(isinstance(result, list))

    def test_assessor(self):
        result = self.assessor.assess(self.osm)
        print(result.head())
        self.assertTrue(isinstance(result, pd.DataFrame))





if __name__ == '__main__':
    unittest.main()
