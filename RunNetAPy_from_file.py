import netapy
import osmnx as ox
import subprocess
import sys
import numpy as np

# fasse die osmium-funktionen in einer klasse zusammen
# da osmium unter windows 10 am besten über OsGeo4W funktionert (was mit QGIS kommt)
# rufe ich die batch-datei von OsGeo4W direkt in einem subprocess auf
# falls der pfad der batch-datei abweicht, muss self.bat_path angepasst werden.
class ProcessOsmData():
    def __init__(self):
        self.bat_path = "C:\Program Files\QGIS 3.24.2\\OSGeo4W.bat"

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
        full_command = f'"{self.bat_path}" osmium extract -b {bbox} {osm_file} --output={output_dir} --overwrite'
        print(full_command)
        process = subprocess.Popen(full_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        # Real-time output
        for line in iter(process.stdout.readline, b''):
            sys.stdout.write(line.decode(sys.stdout.encoding))

        process.stdout.close()
        return_code = process.wait()

        if return_code == 0:
            print("Command executed successfully")
        else:
            print(f"Command failed with return code {return_code}")
        return output_file #gibt den pfad und dateinamen aus

    # hier wird die extrahierte *.osm.pbf-datei aus der funkton osmium_extract() in eine osm-datei umgewandelt
    def osmium_pbf2xml(self, region, osm_file, output_dir):
        '''
        :param args - call a bbox for extracting OSM data:
        :osm_file: name der OSM-datei
        :output_dir: ordner in der die komprimierte XML-datei gespeichert werden soll
        :return:
        '''
        bat_path = "C:\Program Files\QGIS 3.24.2\\OSGeo4W.bat"
        output_file = f"{output_dir}/{region}.osm.bz2"
        full_command = f"osmium cat {osm_file} -o f{output_file}"
        process = subprocess.Popen(f'"{bat_path}" {full_command}', stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                   shell=True)

        stdout, stderr = process.communicate()

        if process.returncode == 0:
            print("Command executed successfully")
            print("Output:\n", stdout.decode())
        else:
            print(f"Command failed with return code {process.returncode}")
            print("Error output:\n", stderr.decode())
        return output_dir #gibt den pfad aus

oe = ProcessOsmData()
region = 'Dresden'
bbox_array = np.array([51.0343, 13.6549, 51.0914, 13.8136]) #beispiel-bbox für dresden
osmium_xtract = oe.osmium_extract(bbox_array, r'C:\path\to\germany_latest.osm.pbf')
osmium_xml = oe.osmium_pbf2xml(region, osmium_xtract, r'C:\path\to\osm_xml')

# erstmal mit einer kleinen Datei testen, z.B. Dresden
network = netapy.networks.NetascoreNetwork.from_file(filepath=osmium_xml)

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
G = ox.utils_graph.graph_from_gdfs(gdf_nodes, gdf_edges, graph_attrs=assessed.graph)
# save graph as a geopackage
# bei Aenderungen in Abfrage zu Radinfrastruktur habe ich jeweils die Nummer erhoeht.
# TODO: fiona-kompabilität
ox.io.save_graph_geopackage(G, filepath=f"./data/RadinfraOSM_{region}_infra09_reversed.gpkg")
