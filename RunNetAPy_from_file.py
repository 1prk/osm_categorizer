import netapy
import osmnx as ox
import subprocess

file = 'dresden_latest' #das als Beispiel
region = 'dresden'
# TODO: eine pipeline zum umwandeln der protobuf in eine OSM-datei ausdenken
# unter windows 10: subprocess über OsGeo4W
def osmium_extract(osm_file, output_dir):
    '''

    :param args - call a bbox for extracting OSM data:
    :osm_file: name der OSM-datei
    :output_dir: ordner in der die komprimierte XML-datei gespeichert werden soll
    :return:
    '''
    bat_path = "C:\Program Files\QGIS 3.24.2\\OSGeo4W.bat"
    full_command = f"osmium cat {osm_file}.osm.pbf -o {output_dir}/{osm_file}.osm.bz2"
    process = subprocess.Popen(f'"{bat_path}" {full_command}', stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                               shell=True)

    stdout, stderr = process.communicate()

    if process.returncode == 0:
        print("Command executed successfully")
        print("Output:\n", stdout.decode())
    else:
        print(f"Command failed with return code {process.returncode}")
        print("Error output:\n", stderr.decode())

osm_xml = osmium_extract(file, 'ein/ordner')

# erstmal mit einer kleinen Datei testen, z.B. Dresden
network = netapy.networks.NetascoreNetwork.from_file(osm_xml)

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
ox.io.save_graph_geopackage(G, filepath=f"./data/RadinfraOSM_{region}_infra09_reversed.gpkg")
