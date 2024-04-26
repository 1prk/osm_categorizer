import pandas as pd
import random
import itertools
import unittest
import pprint
import overpy
from unittest.mock import MagicMock

from netapy.assessors import NetascoreAssessor
from netapy.defaults import NETASCORE_STREET_KEYS


# Import your class here
# from your_module import NetascoreAssessor

class TestNetascoreAssessorSetValuesMethod(unittest.TestCase):
    def setUp(self):
        api = overpy.Overpass()
        
        #test erfolt mit mehreren edge-cases anhand der OSM-way-id
        # 1: muss bicycle_way_mit_
        # 2: muss bicycle_way_mit
        ways = [1169162410, 1251147753]
        ways_str = ','.join(str(x) for x in ways)
        query = f'way(id:{ways_str});out;'
        result = api.query(query)
        n_results = len(result.ways)


        # erzeuge mockup-index für testdatensatz
        keys = ['k' + str(i) for i in range(n_results)]
        node1 = [i for i in range(n_results)]
        node2 = [i+1 for i in range(n_results)]

        # generiere testdatensatz
        index = pd.MultiIndex.from_tuples(list(zip(node1, node2, keys)), names=['u', 'v', 'k'])
        self.data = pd.DataFrame((way.tags for way in result.ways), index=index)

        # mock-up-wert für reversed
        self.data['reversed'] = 'no'

        # ergänze fehlende spalten im testdatensatz
        for col in NETASCORE_STREET_KEYS:
            if col not in self.data.columns:
                self.data[col] = 'nan'
        self.assessor = NetascoreAssessor(profile = "bike")

        self.network = MagicMock()
        self.network._get_edge_attributes.return_value = self.data

    def test_assessor(self):
        # Create a dictionary of test values

        # hypothetical method that sets and returns conditions_p_way_left list
        result = self.assessor.derive_bicycle_infrastructure(self.network, debug=True)
        pprint.pprint(result, indent=4, width=1)

        expected_results = '' # what you expect the results to be

        # self.assertEqual(result, expected_results)


        # Repeat the process with different test data...
