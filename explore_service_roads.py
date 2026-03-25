"""
Exploratory analysis of service roads and their cycling infrastructure.
Checks whether highway=service ways have cycling tags that would warrant
a different categorization than "no".
"""

import pyrosm
import pandas as pd
from assessor import assessor_free

# Load Freiburg data
print("Loading Freiburg OSM data...")
osm_file = pyrosm.OSM("Freiburg_segmented.osm.pbf")

# Load both cycling and driving networks to get complete picture
osm_bike = osm_file.get_network(network_type="cycling")
osm_drive = osm_file.get_network(network_type="driving")

# Merge as in main.py
osm_mask = ['id', 'osm_type', 'geometry', 'area']
osm = pd.merge(left=osm_bike, right=osm_drive, how='outer', on='id')
osm = osm.loc[:, ~osm.columns.str.endswith('_y')]
osm.columns = osm.columns.str.rstrip('_x')
mask = osm.drop(columns=osm_mask).notna().any(axis=1)
osm = osm[mask]

# Filter out rows with NaN in tags column (causes JSON parsing errors)
if 'tags' in osm.columns:
    osm = osm[osm['tags'].notna()].copy()

print(f"Total ways loaded: {len(osm)}")

# Initialize assessor to access classification logic
assessor = assessor_free.Assessor()

# First, run the full assessment to get categories and indicators
print("\nRunning assessment...")
result = assessor.assess(osm, single=True, aggregated=False, include_indicators=True)

# Filter for service roads using the is_service_tag indicator (highway=service only)
service_ways = result[result['is_service_tag'] == True].copy()

cycling_tags_columns = ['cycleway', 'bicycle', 'cycleway:left', 'cycleway:right',
                        'cycleway:both', 'bicycle_road', 'traffic_sign',
                        'cycleway:left:lane', 'cycleway:right:lane']

print(f"\n{'='*80}")
print(f"SERVICE ROADS ANALYSIS (highway=service ONLY)")
print(f"{'='*80}")
print(f"Total service roads found: {len(service_ways)}")
print(f"Percentage of network: {len(service_ways)/len(result)*100:.1f}%")

# Check which service roads have cycling tags
cycling_tag_stats = {}
for tag in cycling_tags_columns:
    if tag in service_ways.columns:
        count = service_ways[tag].notna().sum()
        cycling_tag_stats[tag] = count
    else:
        cycling_tag_stats[tag] = 0

# Count service roads with at least one cycling tag
existing_tags = [t for t in cycling_tags_columns if t in service_ways.columns]
if existing_tags:
    has_any_cycling_tag = service_ways[existing_tags].notna().any(axis=1)
    service_with_cycling = service_ways[has_any_cycling_tag].copy()
else:
    service_with_cycling = pd.DataFrame()

print(f"\nService roads WITH cycling tags: {len(service_with_cycling)}")
if len(service_ways) > 0:
    print(f"Percentage: {len(service_with_cycling)/len(service_ways)*100:.1f}%")
    print(f"\nService roads WITHOUT cycling tags: {len(service_ways) - len(service_with_cycling)}")
    print(f"Percentage: {(len(service_ways) - len(service_with_cycling))/len(service_ways)*100:.1f}%")

print(f"\n{'='*80}")
print(f"CYCLING TAG DISTRIBUTION ON SERVICE ROADS")
print(f"{'='*80}")
for tag, count in sorted(cycling_tag_stats.items(), key=lambda x: x[1], reverse=True):
    if count > 0:
        print(f"{tag:25} {count:5} ({count/len(service_ways)*100:5.1f}%)")

# Show current categorization of service roads
print(f"\n{'='*80}")
print(f"CURRENT CATEGORIZATION OF SERVICE ROADS")
print(f"{'='*80}")
print(service_ways['bicycle_infrastructure'].value_counts())

# Show detailed examples
if len(service_with_cycling) > 0:
    print(f"\n{'='*80}")
    print(f"EXAMPLES: Service roads WITH cycling tags")
    print(f"{'='*80}")

    # Get first 10 examples
    for i, (idx, row) in enumerate(service_with_cycling.head(10).iterrows(), 1):
        print(f"\n{i}. OSM ID: {row['id']}")
        print(f"   https://www.openstreetmap.org/way/{int(row['id'])}")
        print(f"   highway            = {row.get('highway', 'N/A')}")
        print(f"   bicycle_infrastructure = {row.get('bicycle_infrastructure', 'N/A')}")

        for tag in cycling_tags_columns:
            if tag in row and pd.notna(row[tag]):
                print(f"   {tag:20} = {row[tag]}")

# Show indicator analysis
print(f"\n{'='*80}")
print(f"INDICATORS: All service roads")
print(f"{'='*80}")

# Get indicator columns
indicator_cols = [c for c in service_ways.columns if c.startswith('is_') or c.startswith('can_') or c.startswith('use_')]

print(f"\nIndicator summary for {len(service_ways)} service roads:")
indicator_summary = []
for col in indicator_cols:
    true_count = service_ways[col].sum()
    if true_count > 0:
        indicator_summary.append({
            'indicator': col,
            'count': true_count,
            'percentage': true_count/len(service_ways)*100
        })

# Sort by count descending
indicator_summary.sort(key=lambda x: x['count'], reverse=True)

for item in indicator_summary:
    print(f"{item['indicator']:35} {item['count']:5} ({item['percentage']:5.1f}%)")

# Show indicator analysis for service roads WITH cycling tags
if len(service_with_cycling) > 0:
    print(f"\n{'='*80}")
    print(f"INDICATORS: Service roads WITH cycling tags only")
    print(f"{'='*80}")

    print(f"\nIndicator summary for {len(service_with_cycling)} service roads with cycling tags:")
    indicator_summary_cycling = []
    for col in indicator_cols:
        true_count = service_with_cycling[col].sum()
        if true_count > 0:
            indicator_summary_cycling.append({
                'indicator': col,
                'count': true_count,
                'percentage': true_count/len(service_with_cycling)*100
            })

    # Sort by count descending
    indicator_summary_cycling.sort(key=lambda x: x['count'], reverse=True)

    for item in indicator_summary_cycling:
        print(f"{item['indicator']:35} {item['count']:5} ({item['percentage']:5.1f}%)")

print(f"\n{'='*80}")
print(f"RECOMMENDATION")
print(f"{'='*80}")

if len(service_with_cycling) > 0:
    pct = len(service_with_cycling)/len(service_ways)*100
    print(f"\n{pct:.1f}% of service roads have cycling tags.")

    # Show what categories they're getting
    print(f"\nCategories for service roads WITH cycling tags:")
    print(service_with_cycling['bicycle_infrastructure'].value_counts())

    if pct > 5:
        print(f"\nThis is significant! Consider:")
        print(f"  1. Creating a separate category for service roads with cycling infrastructure")
        print(f"  2. Or: Only categorize as 'no' / 'service_misc' when service roads lack cycling tags")
        print(f"  3. Current approach groups ALL service roads as 'service_misc' (aggregated to 'no')")
    else:
        print(f"\nThis is relatively low. Current 'no' default may be acceptable.")
        print(f"But still worth investigating the {len(service_with_cycling)} cases.")
else:
    print(f"\nNo service roads with cycling tags found.")
    print(f"Current 'no' default appears appropriate.")
