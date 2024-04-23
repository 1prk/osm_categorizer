from flask import Flask, request, render_template, jsonify, send_from_directory, after_this_request
from flask_cors import CORS, cross_origin
import osmnx as ox
import os
import networkx as nx
import json
import netapy

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:5000"}})

@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')

@app.route('/data/<path:filename>', methods=['GET'])
def download(filename):
    path = os.path.join(app.static_folder, 'data', filename)
    handle = open(path, 'r')

    try:
        handle = open(path, 'rb')  # read mode for binary file
    except IOError:
        return "Can't open file", 500  # use proper error code

    def stream_and_remove_file():
        try:
            yield from handle
        finally:
            handle.close()
            os.remove(path)

    return app.response_class(
        stream_and_remove_file(),
        headers={'Content-Disposition': 'attachment', 'filename': filename}
    )
    #return send_from_directory(os.path.join(app.static_folder, 'data'), filename, as_attachment=True)
@app.route('/get_network', methods=['POST'])
@cross_origin()
def get_network():
    dist = request.form.get('dist')
    location_point = request.form.get('location_point')
    location_point = tuple(map(float, location_point.split(',')))
    network = netapy.networks.NetascoreNetwork.from_point(point=location_point, dist=int(dist))

    assessor = netapy.assessors.NetascoreAssessor(profile="bike")
    assessed = network.assess(assessor, inplace=False, ignore_nodata=True, compute_robustness=True)
    gdf_nodes, gdf_edges = ox.utils_graph.graph_to_gdfs(assessed)
    filename = request.form.get('filename', 'RadinfraOSM_test_infra09_reversed')

    # Ensure filename ends with '.gpkg'
    if not filename.endswith('.gpkg'):
        filename += '.gpkg'

    gdf_edges.to_file(f"./static/data/{filename}", driver="GPKG")

    return "done", 200


if __name__ == "__main__":
    app.run(debug=True)
