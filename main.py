import pyrosm
import pandas as pd
from netapy import assessor_free

osm_mask = ['id', 'osm_type', 'geometry', 'area']

if __name__ == "__main__":
    osm_file = pyrosm.OSM("Wedel_highway.osm.pbf") #hier laden wir die protobuf
    osm_bike = osm_file.get_network(network_type="cycling") #hier wird die protobuf in eine dataframe umgewnandelt
    print(len(osm_bike))
    osm_drive = osm_file.get_network(network_type="driving")
    print(len(osm_drive))
    osm = pd.merge(left=osm_bike, right=osm_drive, how='outer', on='id')
    osm = osm.loc[:, ~osm.columns.str.endswith('_y')]
    osm.columns = osm.columns.str.rstrip('_x')
    mask = osm.drop(columns=osm_mask).notna().any(axis=1)
    osm = osm[mask]
    print(len(osm))
    assessor = assessor_free.Assessor()

    result = assessor.assess(osm, sides="double") #assessor.assess nimmt eine DATAFRAME
    print(result.head())
    print(result['bicycle_infrastructure:forward'].value_counts())
    result.to_csv('Wedel_categories.csv')