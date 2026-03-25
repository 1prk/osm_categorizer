import pyrosm
import pandas as pd

# Load Freiburg data
print("Loading Freiburg OSM data...")
osm_file = pyrosm.OSM("Freiburg_segmented.osm.pbf")

osm_bike = osm_file.get_network(network_type="cycling")
osm_drive = osm_file.get_network(network_type="driving")

print(f"\nCycling network columns: {osm_bike.columns.tolist()}")
print(f"\nDriving network columns: {osm_drive.columns.tolist()}")

# Check if there's a 'tags' column
if 'tags' in osm_bike.columns:
    print(f"\n'tags' column exists in cycling network")
    print(f"Sample tags values:")
    print(osm_bike['tags'].head())
    print(f"\nData types in tags column: {osm_bike['tags'].dtype}")
    print(f"Number of NaN values: {osm_bike['tags'].isna().sum()}")

if 'tags' in osm_drive.columns:
    print(f"\n'tags' column exists in driving network")
    print(f"Sample tags values:")
    print(osm_drive['tags'].head())
    print(f"\nData types in tags column: {osm_drive['tags'].dtype}")
    print(f"Number of NaN values: {osm_drive['tags'].isna().sum()}")

# Merge
osm_mask = ['id', 'osm_type', 'geometry', 'area']
osm = pd.merge(left=osm_bike, right=osm_drive, how='outer', on='id')
osm = osm.loc[:, ~osm.columns.str.endswith('_y')]
osm.columns = osm.columns.str.rstrip('_x')
mask = osm.drop(columns=osm_mask).notna().any(axis=1)
osm = osm[mask]

print(f"\nMerged columns: {osm.columns.tolist()}")

if 'tags' in osm.columns:
    print(f"\n'tags' column in merged data")
    print(f"Sample values:")
    print(osm['tags'].head(10))
    print(f"\nData types: {osm['tags'].dtype}")
    print(f"Number of NaN values: {osm['tags'].isna().sum()}")
    print(f"Number of non-NaN values: {osm['tags'].notna().sum()}")
