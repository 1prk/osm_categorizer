"""
Investigate which service roads are classified as bicycle_road vs service_misc
"""
import pyrosm
import pandas as pd
from assessor import assessor_free

# Load Freiburg data
osm_file = pyrosm.OSM("Freiburg_segmented.osm.pbf")
osm_bike = osm_file.get_network(network_type="cycling")
osm_drive = osm_file.get_network(network_type="driving")

# Merge
osm_mask = ['id', 'osm_type', 'geometry', 'area']
osm = pd.merge(left=osm_bike, right=osm_drive, how='outer', on='id')
osm = osm.loc[:, ~osm.columns.str.endswith('_y')]
osm.columns = osm.columns.str.rstrip('_x')
mask = osm.drop(columns=osm_mask).notna().any(axis=1)
osm = osm[mask]

# Filter out NaN tags
if 'tags' in osm.columns:
    osm = osm[osm['tags'].notna()].copy()

# Run assessment
assessor = assessor_free.Assessor()
result = assessor.assess(osm, single=True, aggregated=False, include_indicators=True)

# Filter for highway=service only
service_roads = result[result['is_service_tag'] == True].copy()

# Get the ones classified as bicycle_road
bicycle_road_service = service_roads[service_roads['bicycle_infrastructure'] == 'bicycle_road']
service_misc_service = service_roads[service_roads['bicycle_infrastructure'] == 'service_misc']

print(f"Service roads classified as bicycle_road: {len(bicycle_road_service)}")
print(f"Service roads classified as service_misc: {len(service_misc_service)}")

# Check the is_service indicator (the broader definition)
print(f"\nOf bicycle_road service roads:")
print(f"  - is_service=True: {bicycle_road_service['is_service'].sum()}")
print(f"  - is_service=False: {(~bicycle_road_service['is_service']).sum()}")

print(f"\nOf service_misc service roads:")
print(f"  - is_service=True: {service_misc_service['is_service'].sum()}")
print(f"  - is_service=False: {(~service_misc_service['is_service']).sum()}")

# Show examples
print(f"\n{'='*80}")
print(f"BICYCLE_ROAD service roads (first 5):")
print(f"{'='*80}")
for idx, row in bicycle_road_service.head(5).iterrows():
    print(f"\nOSM ID: {int(row['id'])} - https://www.openstreetmap.org/way/{int(row['id'])}")
    print(f"  highway: {row.get('highway')}")
    print(f"  bicycle_road: {row.get('bicycle_road')}")
    print(f"  bicycle: {row.get('bicycle')}")
    print(f"  is_service: {row['is_service']}")
    print(f"  is_accessible: {row['is_accessible']}")
    print(f"  is_smooth: {row['is_smooth']}")
    print(f"  is_vehicle_allowed: {row['is_vehicle_allowed']}")
    print(f"  is_track: {row['is_track']}")
    print(f"  is_path: {row['is_path']}")
    print(f"  is_agricultural: {row['is_agricultural']}")

print(f"\n{'='*80}")
print(f"SERVICE_MISC with bicycle_road tag (first 5):")
print(f"{'='*80}")
# Find service_misc that have bicycle_road tag
service_misc_with_br = service_misc_service[service_misc_service['bicycle_road'].notna()]
print(f"Found {len(service_misc_with_br)} service_misc roads with bicycle_road tag")

for idx, row in service_misc_with_br.head(5).iterrows():
    print(f"\nOSM ID: {int(row['id'])} - https://www.openstreetmap.org/way/{int(row['id'])}")
    print(f"  highway: {row.get('highway')}")
    print(f"  bicycle_road: {row.get('bicycle_road')}")
    print(f"  bicycle: {row.get('bicycle')}")
    print(f"  is_service: {row['is_service']}")
    print(f"  is_accessible: {row['is_accessible']}")
    print(f"  is_smooth: {row['is_smooth']}")
    print(f"  is_vehicle_allowed: {row['is_vehicle_allowed']}")
