import netapy
import osmnx as ox
import subprocess

file = r'C:\Users\Porojkow\Documents\Sonstiges\julius\VERA\osm_münster.osm.pbf' #das als Beispiel
region = 'münster'
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
    full_command = f"osmium cat {osm_file} -o {output_dir}/{region}.osm.bz2"
    process = subprocess.Popen(f'"{bat_path}" {full_command}', stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                               shell=True)

    stdout, stderr = process.communicate()

    if process.returncode == 0:
        print("Command executed successfully")
        print("Output:\n", stdout.decode())
    else:
        print(f"Command failed with return code {process.returncode}")
        print("Error output:\n", stderr.decode())

osm_xml = osmium_extract(file, r'C:\Users\Porojkow\Documents\Sonstiges\julius\VERA')

osm_xml_extracted = r'C:\Users\Porojkow\Documents\Sonstiges\julius\VERA\münster.osm'

# erstmal mit einer kleinen Datei testen, z.B. Dresden
network = netapy.networks.NetascoreNetwork.from_file(filepath=osm_xml_extracted)

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
