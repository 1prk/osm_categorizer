

import netapy
import osmnx as ox

# Eingabe place name
network = netapy.networks.NetascoreNetwork.from_place("Dresden")
# Eingabe bounding box
#network = netapy.networks.NetascoreNetwork.from_bbox((5.23822733,51.33068278,14.86905163,55.43618192))
# Eingabe OSM-IDs - funktioniert leider nicht
#network = netapy.networks.NetascoreNetwork.from_place(query="Dresden", custom_filter='["::type"="way"]["::id"~"1058293583|213731284"]')

#ox.plot_graph(network, bgcolor = "white", edge_color = "orange", node_color = "grey", node_size = 2)

assessor = netapy.assessors.NetascoreAssessor(profile = "bike")
assessed = network.assess(assessor, inplace = False, ignore_nodata = True, compute_robustness = True)

#attr = f"index_{assessor.profile.name}:forward"
#ec = ox.plot.get_edge_colors_by_attr(assessed, attr = attr, num_bins = 10)
#ox.plot_graph(network, bgcolor = "white", node_size = 0, edge_color = ec)

#assessed.assess(assessor, read_subs = True, read_attrs = True, ignore_nodata = True, compute_robustness = True)
#list(assessed.edges(data = True))[0]


# you can convert MultiDiGraph to/from GeoPandas GeoDataFrames
gdf_nodes, gdf_edges = ox.utils_graph.graph_to_gdfs(assessed)
G = ox.utils_graph.graph_from_gdfs(gdf_nodes, gdf_edges, graph_attrs=assessed.graph)
# save graph as a geopackage
# bei Aenderungen in Abfrage zu Radinfrastruktur habe ich jeweils die Nummer erhoeht.
ox.io.save_graph_geopackage(G, filepath="./data/RadinfraOSM_Dresden_infra09_reversed.gpkg")
