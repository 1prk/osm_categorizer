import pyrosm
import pandas as pd
from netapy import assessor_free

osm_mask = ['id', 'osm_type', 'geometry', 'area']

if __name__ == "__main__":
    osm_file = pyrosm.OSM("Wedel_highway.osm.pbf") #hier laden wir die protobuf

    #da ich bisher nicht weiß wie das gesamte netz in eine geodataframe mittels pyrosm geladen werden kann gibts ein kleines workaround
    osm_bike = osm_file.get_network(network_type="cycling") #hier wird die protobuf in eine dataframe umgewnandelt für das profil fahrrad
    osm_drive = osm_file.get_network(network_type="driving") #hier wird die protobuf in eine dataframe umgewnandelt für das profil auto

    #preprocessing für beide dataframes, da beim mergen zwangsläufig spalten mit 'nan' entstehen
    osm = pd.merge(left=osm_bike, right=osm_drive, how='outer', on='id')
    osm = osm.loc[:, ~osm.columns.str.endswith('_y')]
    osm.columns = osm.columns.str.rstrip('_x')
    mask = osm.drop(columns=osm_mask).notna().any(axis=1)
    osm = osm[mask]


    assessor = assessor_free.Assessor()
    result = assessor.assess(osm, sides="double") #assessor.assess nimmt eine (geo)DATAFRAME
    print(result.head())
    print(result['bicycle_infrastructure:forward'].value_counts())
    result.to_csv('Wedel_categories.csv') #hier wird die komplette geodataframe in eine CSV gespeichert.