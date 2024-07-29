import netapy

assessor = netapy.assessor_free.Assessor()

test = assessor.test_osm_way('475826466')

assessed = assessor.set_value(test)

test_assessed = {'osm_infra': assessed}