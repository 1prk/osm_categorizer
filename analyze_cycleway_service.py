"""
Analyze cycleway tags on service roads to understand if they represent
legitimate bicycle infrastructure that should be categorized.
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

if 'tags' in osm.columns:
    osm = osm[osm['tags'].notna()].copy()

# Run assessment
assessor = assessor_free.Assessor()
result = assessor.assess(osm, single=True, aggregated=False, include_indicators=True)

# Filter for highway=service only
service_roads = result[result['is_service_tag'] == True].copy()

# Get service roads with cycleway tags
cycleway_cols = ['cycleway', 'cycleway:left', 'cycleway:right', 'cycleway:both']
# Filter to only columns that exist
existing_cycleway_cols = [col for col in cycleway_cols if col in service_roads.columns]
service_with_cycleway = service_roads[service_roads[existing_cycleway_cols].notna().any(axis=1)].copy()

print(f"{'='*80}")
print(f"SERVICE ROADS WITH CYCLEWAY TAGS")
print(f"{'='*80}")
print(f"Total service roads: {len(service_roads)}")
print(f"Service roads with cycleway tags: {len(service_with_cycleway)}")

# What cycleway values do they have?
print(f"\n{'='*80}")
print(f"CYCLEWAY TAG VALUES")
print(f"{'='*80}")

for col in cycleway_cols:
    if col in service_with_cycleway.columns:
        values = service_with_cycleway[col].dropna()
        if len(values) > 0:
            print(f"\n{col}:")
            print(values.value_counts())

# Current categorization
print(f"\n{'='*80}")
print(f"CURRENT CATEGORIZATION")
print(f"{'='*80}")
print(service_with_cycleway['bicycle_infrastructure'].value_counts())

# Check what indicators they have
print(f"\n{'='*80}")
print(f"INFRASTRUCTURE INDICATORS")
print(f"{'='*80}")

infra_indicators = [
    'is_bikepath_left', 'is_bikepath_right',
    'is_bikelane_left', 'is_bikelane_right',
    'is_shared_buslane_left', 'is_shared_buslane_right',
    'is_sign_shared_way', 'is_segregated'
]

for indicator in infra_indicators:
    if indicator in service_with_cycleway.columns:
        count = service_with_cycleway[indicator].sum()
        if count > 0:
            print(f"{indicator:30} {count}")

# Show examples
print(f"\n{'='*80}")
print(f"EXAMPLES: Service roads with legitimate cycleway infrastructure")
print(f"{'='*80}")

# Find ones with positive cycleway values (not "no")
legitimate_cycleways = service_with_cycleway[
    (service_with_cycleway['cycleway'].isin(['lane', 'track', 'shared_lane']) if 'cycleway' in service_with_cycleway.columns else False) |
    (service_with_cycleway['cycleway:left'].isin(['lane', 'track', 'shared_lane']) if 'cycleway:left' in service_with_cycleway.columns else False) |
    (service_with_cycleway['cycleway:right'].isin(['lane', 'track', 'shared_lane']) if 'cycleway:right' in service_with_cycleway.columns else False)
]

print(f"\nService roads with actual cycleway infrastructure (lane/track/shared_lane): {len(legitimate_cycleways)}")

for idx, row in legitimate_cycleways.head(10).iterrows():
    print(f"\nOSM ID: {int(row['id'])} - https://www.openstreetmap.org/way/{int(row['id'])}")
    print(f"  highway: {row.get('highway')}")
    print(f"  bicycle_infrastructure: {row.get('bicycle_infrastructure')}")
    print(f"  cycleway: {row.get('cycleway')}")
    print(f"  cycleway:left: {row.get('cycleway:left')}")
    print(f"  cycleway:right: {row.get('cycleway:right')}")
    print(f"  bicycle: {row.get('bicycle')}")
    print(f"  is_service: {row['is_service']}")
    print(f"  is_bikepath_left: {row.get('is_bikepath_left', False)}")
    print(f"  is_bikepath_right: {row.get('is_bikepath_right', False)}")
    print(f"  is_bikelane_left: {row.get('is_bikelane_left', False)}")
    print(f"  is_bikelane_right: {row.get('is_bikelane_right', False)}")

# Check ones with cycleway=no (explicitly no infrastructure)
cycleway_no = service_with_cycleway[
    (service_with_cycleway['cycleway'] == 'no') |
    (service_with_cycleway['cycleway:left'] == 'no') |
    (service_with_cycleway['cycleway:right'] == 'no')
]

print(f"\n{'='*80}")
print(f"Service roads with cycleway=no: {len(cycleway_no)}")
print(f"{'='*80}")
print("(These explicitly state there is NO cycleway infrastructure)")

print(f"\n{'='*80}")
print(f"SUMMARY FOR REVIEWER")
print(f"{'='*80}")
print(f"Total service roads with cycleway tags: {len(service_with_cycleway)}")
print(f"  - With explicit 'no' (no infrastructure): {len(cycleway_no)}")
print(f"  - With actual infrastructure (lane/track/shared_lane): {len(legitimate_cycleways)}")
print(f"  - Current categorization: ALL as 'service_misc' → 'no'")

if len(legitimate_cycleways) > 0:
    print(f"\nRECOMMENDATION:")
    print(f"  {len(legitimate_cycleways)} service roads have legitimate cycleway infrastructure")
    print(f"  that is currently being ignored. Consider respecting these tags.")
