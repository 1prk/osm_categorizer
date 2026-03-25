import assessor

assessor_instance = assessor.assessor_free.Assessor()

test = assessor_instance.test_osm_way('475826466')

assessed = assessor_instance.set_value(test)

test_assessed = {'osm_infra': assessed}