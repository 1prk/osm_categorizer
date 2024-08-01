## Was haben wir vor?

Wir vereinigen unsere Ansätze und Ideen zur einheitlichen, projektübergreifenden Kategorisierung der Radverkehrsinfrastruktur in OSM.

Genutzt wird u.a. Netapy. https://github.com/plus-mobilitylab/netapy

## Installation

Es wird Python mit der Version 3.10 oder höher erwartet.

Die Library wird durch [Poetry](https://python-poetry.org/) verwaltet.

Die Installation erfolgt über die Git-Repo:

```
git clone -b radsim https://github.com/1prk/osm_categorizer.git
cd osm-categorizer
poetry install
```

## Nutzung

Für ein konkretes Anwendungsbeispiel siehe `main.py`

Der Assessor erwartet ein OSM-Netz in Form einer (Geo-)DataFrame.
Dies lässt sich mittels PyrOSM erzeugen.

```
import pyrosm
osm_file = pyrosm.OSM("sachsen-latest.osm.pbf")
osm = osm_file.get_network() #erzeugt eine GeoDataFrame aus dem OSM-Netz
```

Im Anschluss wird der Assessor geladen. Das Ergebnis der Kategorisierung wird der GeoDataFrame angehängt.

```
assessor = assessor_free.Assessor()
result = assessor.assess(osm)
print(result.head())
```

## Unterstützte Kategorien

| Assessor-Kategorie | Radverkehrsinfrastruktur |
|--------------------|-------------------------|
| bicycle_road       | Fahrradstraße           |
| bicycle_way        | separater Radweg        |
| bicycle_lane       | Radfahr-/Schutzstreifen |
| bus_lane           | freigegebene Busspur    |
| mixed_way          | Mischverkehr ohne MIV   |
| mit_road           | Mischverkehr im MIV     |
| service_misc       | sonstige                |
