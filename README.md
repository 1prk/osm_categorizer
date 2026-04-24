# OSM Categorizer - BikeNEAT

A framework for classifying bicycle infrastructure in OpenStreetMap.

## Overview

BikeNEAT provides a unified approach for categorizing bicycle infrastructure from OpenStreetMap data. The tool identifies and classifies different types of cycling infrastructure based on OSM tags, providing both categorical classifications and detailed Boolean indicators for flexible analysis.

Inspired by NetApy: https://github.com/plus-mobilitylab/netapy

## Installation

Requires Python 3.10 to 3.12.

This library is managed through [Poetry](https://python-poetry.org/).

Install from the Git repository:

```bash
git clone https://github.com/1prk/osm_categorizer/tree/radsim
cd osm-kategorisierung
poetry install
```

## Quick Start

Run the example file:

```bash
poetry run python main.py
```

This processes the sample file `Wedel_highway.osm.pbf` and generates `Wedel_categories.csv` with all categories and indicators.

## Usage

### Basic Categorization

The assessor expects an OSM network as a GeoDataFrame, which can be created using pyrosm:

```python
import pyrosm
from assessor import assessor_free

# Load OSM data
osm_file = pyrosm.OSM("sachsen-latest.osm.pbf")
osm = osm_file.get_network()

# Initialize assessor and categorize
assessor = assessor_free.Assessor()
result = assessor.assess(osm, single=True, aggregated=True)

print(result[['highway', 'bicycle_infrastructure']].head())
```

### With Indicators (Recommended)

The 41 Boolean indicators can be output as columns, enabling flexible analysis and custom categorization:

```python
result = assessor.assess(
    osm,
    single=True,
    aggregated=True,
    include_indicators=True,
    pbf_file="sachsen-latest.osm.pbf"
)

# Show all indicators (is_*, can_*, use_*)
indicator_cols = [c for c in result.columns if c.startswith('is_') or c.startswith('can_') or c.startswith('use_')]
print(f"Available indicators: {len(indicator_cols)}")
```

### With Relation Membership

When `pbf_file` is provided, an additional indicator `is_in_cycling_relation` is added. This shows whether a way is part of a cycling relation (route=bicycle, network=lcn/rcn/ncn/icn):

```python
result = assessor.assess(
    osm,
    single=True,
    aggregated=True,
    include_indicators=True,
    pbf_file="sachsen-latest.osm.pbf"
)

# Find ways in cycling relations
in_relation = result[result['is_in_cycling_relation'] == True]
print(f"{len(in_relation)} ways are part of cycling relations")
```

### PBF Export

The categorization can be exported as a PBF file. The tag `bicycle_infrastructure` is added to all categorized ways:

```python
result = assessor.assess(
    osm,
    single=True,
    aggregated=True,
    pbf_file="sachsen-latest.osm.pbf",
    export_pbf="sachsen_categorized.osm.pbf"
)
```

The exported PBF file can be used in JOSM, QGIS, or other OSM tools.

## Parameters

- **single** (bool): If `True`, categories are not distinguished by direction (recommended)
- **aggregated** (bool): If `True`, categories without cycling infrastructure are grouped as "no"
- **include_indicators** (bool): If `True`, all 41 Boolean indicators are output as columns
- **pbf_file** (str): Path to PBF file for relation membership detection (optional)
- **export_pbf** (str): Path for PBF export with bicycle_infrastructure tags (optional)

## Indicators

With `include_indicators=True`, 32 Boolean indicators are output:

**Basic infrastructure types**: is_footway, is_path, is_track

**Physical attributes**: is_segregated

**Access/permissions**: can_bike, can_walk_right/left

**Designation**: is_designated, is_bicycle_designated_right/left, is_pedestrian_designated_right/left

**Traffic signs**: is_obligated_segregated, is_obligated_shared, is_sign_shared_way, is_sign_shared_buslane

**Infrastructure presence**: is_bikepath_right/left, is_bikelane_right/lef, is_shared_buslane_right/left

**Special categories**: is_cycle_highway, is_bikeroad

**Relations**: is_in_cycling_relation (only when pbf_file is provided)

## Supported Categories

With `single=True` and `aggregated=True`:

| Category       | Description                      |
|----------------|----------------------------------|
| cycle_highway  | Cycle highway                    |
| bicycle_road   | Bicycle street (low-traffic)     |
| bicycle_way    | Separated bike path              |
| bicycle_lane   | Bike lane (marked on roadway)    |
| bus_lane       | Shared bus lane                  |
| shared_way     | Shared pedestrian/cycling path   |
| no             | No cycling infrastructure        |

## Publications

- **Łukawska, M., Richter, E., Porojkow, I., & Huber, S. (2025)**: *BikeNEAT: a framework for classifying bicycle infrastructure in OpenStreetMap.* Under Review in: Journal of Geovisualization and Spatial Analysis.

