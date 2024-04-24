import netapy
import osmnx as ox
import subprocess
import sys
import numpy as np
import geopandas as gpd
import glob

#multithreading!
from concurrent.futures import ThreadPoolExecutor
from tqdm import tqdm




# fasse die osmium-funktionen in einer klasse zusammen
# da osmium unter windows 10 am besten über OsGeo4W funktionert (was mit QGIS kommt)
# rufe ich die batch-datei von OsGeo4W direkt in einem subprocess auf
# falls der pfad der batch-datei abweicht, muss self.bat_path angepasst werden.
class ProcessOsmData():
    def __init__(self):
        self.bat_path = "C:\Program Files\QGIS 3.24.2\OSGeo4W.bat"

    # osmium extract extrahiert große *.osm.pbf-dateien aus einer vordefinierten bounding box
    # diese bounding box wird über ein array wiedergegeben - ursprünglich erzeugt aus gdf.geometry.total_bounds
    # ansonsten wird die bounding box über np.array([minx, miny, maxx, maxy]) erzeugt.
    # TODO: assertion für bbox_array
    def osmium_extract(self, bbox_array, osm_file, output_file):
        '''
        :param args - call a bbox for extracting OSM data:
        e.g. --bbox LEFT, BOTTOM, RIGHT, TOP, OSM_FILE
        :return:
        '''
        bbox = f"{bbox_array[0]},{bbox_array[1]},{bbox_array[2]},{bbox_array[3]}"
        command = [self.bat_path, "osmium", "extract", "-b", bbox, osm_file, "--output=" + output_file, "--overwrite"]
        print(command)
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        # Real-time output
        for line in iter(process.stdout.readline, b''):
            sys.stdout.write(line.decode(sys.stdout.encoding))

        process.stdout.close()
        return_code = process.wait()

        if return_code == 0:
            print("Command executed successfully")
        else:
            print(f"Command failed with return code {return_code}")
        return output_file  # gibt den pfad und dateinamen aus

    def osmium_tagsfilter(self, region, osm_file, output_dir):
        output_file = f"{output_dir}/{region}_highway.osm.pbf"
        command = ["osmium", "tags-filter", "-o", output_file, osm_file, "nw/highway"]  # created a list of all command arguments
        print(' '.join(command))
        process = subprocess.Popen([self.bat_path] + command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        stdout, stderr = process.communicate()

        if process.returncode == 0:
            print("Command executed successfully")
            print("Output:\n", stdout.decode())
        else:
            print(f"Command failed with return code {process.returncode}")
            print("Error output:\n", stderr.decode())
        return output_dir, output_file  # gibt den pfad und die datei aus

    # hier wird die extrahierte *.osm.pbf-datei aus der funkton osmium_extract() in eine osm-datei umgewandelt
    def osmium_pbf2xml(self, region, osm_file, output_dir):
        '''
        :param args - call a bbox for extracting OSM data:
        :osm_file: name der OSM-datei
        :output_dir: ordner in der die komprimierte XML-datei gespeichert werden soll
        :return:
        '''
        output_file = f"{output_dir}/{region}.osm.bz2"
        command = ["osmium", "cat", osm_file, "-o", output_file]  # created a list of all command arguments
        print(' '.join(command))
        process = subprocess.Popen([self.bat_path] + command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        stdout, stderr = process.communicate()

        if process.returncode == 0:
            print("Command executed successfully")
            print("Output:\n", stdout.decode())
        else:
            print(f"Command failed with return code {process.returncode}")
            print("Error output:\n", stderr.decode())
        return output_dir  # gibt den pfad aus

oe = ProcessOsmData()
bbox_gdf = gpd.read_file(r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen\bbox_pilotkommunen_osm.geojson',
                         geometry='geometry', driver='GeoJSON').set_crs('EPSG:3857',allow_override=True)
bbox_gdf = bbox_gdf.to_crs('EPSG:4326')
region = []
for g in bbox_gdf.GEN:
    region.append(g)

bbox_array = []
for geom in bbox_gdf.geometry:
    bbox_array.append(np.array(geom.bounds))

#bbox_array = np.array([51.0343, 13.6549, 51.0914, 13.8136]) #beispiel-bbox für dresden
for bbox, reg in zip(bbox_array, region):
    osmium_xtract = oe.osmium_extract(bbox, r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen\germany-latest.osm.pbf',
                                      r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen\{}_osm.osm.pbf'.format(reg))
    osmium_filter_path, osmium_filter_file = oe.osmium_tagsfilter(reg, osmium_xtract, r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen')
    osmium_xml = oe.osmium_pbf2xml(reg, osmium_filter_file, r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen')

files = glob.glob(r'C:\Users\Porojkow\Documents\Projekte\2023_RadSim\05_Arbeitsunterlagen\AP 3\Verkehrsnetz Darstellung\pilotkommunen\*.bz2')
# erstmal mit einer kleinen Datei testen, z.B. Dresden
for reg, f in zip(region, files):
    network = netapy.networks.NetascoreNetwork.from_file(filepath=f)

    akwargs = {
        'inplace': False,
        'ignore_nodata': True,
        'compute_robustness': True
    }
    assessor = netapy.assessors.NetascoreAssessor(profile = "bike")
    assessed = network.assess(assessor, **akwargs)

    #attr = f"index_{assessor.profile.name}:forward"
    #ec = ox.plot.get_edge_colors_by_attr(assessed, attr = attr, num_bins = 10)
    #ox.plot_graph(network, bgcolor = "white", node_size = 0, edge_color = ec)

    #assessed.assess(assessor, read_subs = True, read_attrs = True, ignore_nodata = True, compute_robustness = True)
    #list(assessed.edges(data = True))[0]


    # you can convert MultiDiGraph to/from GeoPandas GeoDataFrames
    # TODO: auf Dask ausweichen bei großen Gebieten (z.B. Bundesländer)
    gdf_nodes, gdf_edges = ox.utils_graph.graph_to_gdfs(assessed)
    filepath = f"./data/RadinfraOSM_hw_{reg}_infra09_reversed_edges.gpkg"
    gdf_edges.to_file(filepath, driver="GPKG")
    #G = ox.utils_graph.graph_from_gdfs(gdf_nodes, gdf_edges, graph_attrs=assessed.graph)
    # save graph as a geopackage
    # bei Aenderungen in Abfrage zu Radinfrastruktur habe ich jeweils die Nummer erhoeht.
    # TODO: fiona-kompabilität
    #ox.io.save_graph_geopackage(G, filepath=f"./data/RadinfraOSM_hw_{reg}_infra09_reversed.gpkg")

def process_file(region_file):
    reg, f = region_file
    print(f)
    network = netapy.networks.NetascoreNetwork.from_file(filepath=f)

    akwargs = {
        'inplace': False,
        'ignore_nodata': True,
        'compute_robustness': True
    }
    assessor = netapy.assessors.NetascoreAssessor(profile="bike")
    assessed = network.assess(assessor, **akwargs)

    gdf_nodes, gdf_edges = ox.utils_graph.graph_to_gdfs(assessed)
    filepath = f"./data/RadinfraOSM_hw_{reg}_infra09_reversed_edges.gpkg"
    gdf_edges.to_file(filepath, driver="GPKG")

with ThreadPoolExecutor(max_workers=4) as executor:
    # We need to pass tuples (file, region) to executor.map(), so we zip files and regions
    list(tqdm(executor.map(process_file, zip(region, files)), total=len(files)))