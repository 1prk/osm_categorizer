import pyrosm
import pandas as pd
from netapy import assessor_free

osm_mask = ['id', 'osm_type', 'geometry', 'area']

if __name__ == "__main__":
    pbf_path = "Wedel_highway.osm.pbf"
    osm_file = pyrosm.OSM(pbf_path) #hier laden wir die protobuf

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

    # Option 1: Basic assessment without indicators
    # result = assessor.assess(osm, single=True, aggregated=True, include_indicators=False)

    # Option 2: Assessment WITH all 45 indicators including cycling relation membership
    result = assessor.assess(osm, single=True, aggregated=True, include_indicators=True, pbf_file=pbf_path)

    # Filter to relevant columns only
    indicator_cols = [c for c in result.columns if c.startswith('is_') or c.startswith('can_') or c.startswith('use_')]
    essential_cols = ['id', 'osm_type', 'geometry', 'highway', 'length', 'bicycle_infrastructure']

    result_filtered = result[essential_cols + indicator_cols]
    result_filtered.to_csv('Wedel_categories.csv')

    print(f"Saved {len(result_filtered)} ways with {len(indicator_cols)} indicators")