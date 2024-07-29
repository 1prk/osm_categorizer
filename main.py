import pyrosm
from netapy import assessor_free

if __name__ == "__main__":
    osm_file = pyrosm.OSM("Wedel_highway.osm.pbf") #hier laden wir die protobuf
    osm = osm_file.get_network() #hier wird die protobuf in eine dataframe umgewnandelt
    assessor = assessor_free.Assessor()

    result = assessor.assess(osm, sides="single") #assessor.assess nimmt eine DATAFRAME
    print(result['bicycle_infrastructure:forward'].value_counts())