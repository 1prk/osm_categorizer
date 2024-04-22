from flask import Flask, request, render_template, jsonify
import osmnx as ox
import netapy

app = Flask(__name__)


@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')

@app.route('/get_network', methods=['POST'])
def get_network():
    dist = request.form.get('dist')
    location_point = request.form.get('location_point')
    location_point = tuple(map(float, location_point.split(',')))
    network = netapy.networks.NetascoreNetwork.from_point(point=location_point, dist=int(dist))
    # You'll probably want to return some data derived from the network instead.
    assessor = netapy.assessors.NetascoreAssessor(profile="bike")
    assessed = network.assess(assessor, inplace=False, ignore_nodata=True, compute_robustness=True)
    gdf_nodes, gdf_edges = ox.utils_graph.graph_to_gdfs(assessed)
    filename = request.form.get('filename', 'RadinfraOSM_test_infra09_reversed')

    # Ensure filename ends with '.gpkg'
    if not filename.endswith('.gpkg'):
        filename += '.gpkg'

    gdf_edges.to_file(f"./data/{filename}", driver="GPKG")

    return "done", 200

if __name__ == "__main__":
    app.run(debug=True)
