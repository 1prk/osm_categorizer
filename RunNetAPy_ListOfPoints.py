

import netapy
import osmnx as ox
import networkx as nx

# Eingabe place name
#network = netapy.networks.NetascoreNetwork.from_place("Dresden")
# Eingabe bounding box
#network = netapy.networks.NetascoreNetwork.from_bbox((5.23822733,51.33068278,14.86905163,55.43618192))
# Eingabe OSM-IDs - funktioniert leider nicht
#network = netapy.networks.NetascoreNetwork.from_place(query="Dresden", custom_filter='["::type"="way"]["::id"~"1058293583|213731284"]')
#Eingabe Punkt
#location_point = (51.05817, 13.753634)
#location_points = [(51.05817, 13.753634), (51.062605, 13.773431)]
location_points = [(47.5372318460192,9.73178386688233),(47.5466688274815,9.7208833694458),(47.5510065168435,9.69429731369019),(47.55478,9.68048),(47.5603613791882,9.6593052148819),(47.66938,9.17468),(47.99054,7.8623013),(47.995213,7.8407526),(47.998592,7.8220816),(47.999683,7.83709),(48.12032,11.53599),(48.12194,11.62417),(48.13192,11.58469),(48.14205,11.55534),(48.14438,11.51794),(48.16887,11.55005),(48.3044927115721,10.8938026428223),(48.3377808596721,10.885667684704),(48.3538000926673,10.9020495925903),(48.3551047763628,10.9376340607374),(48.3600286153053,10.8896257989502),(48.36075,10.88864),(48.3613605848565,10.8740252793438),(48.3642082486043,10.895556807518),(48.36483,10.90473),(48.3760119703383,10.9132373688336),(48.3855766655468,10.8861252374284),(48.40082,9.95769),(48.41357,10.88982),(48.486245613238,9.20869410037995),(48.487699806335,9.21351671218872),(48.4900463380685,9.20093178749085),(48.4906578406242,9.21517968177796),(48.4908498224636,9.20907497406006),(48.492179454513,9.20020759105683),(48.492948,9.222482),(48.4943338110367,9.22031879425049),(48.49532,9.20736),(48.64511,9.45154),(48.7115716823212,9.08142038478856),(48.716494,9.08652),(48.739821,9.152228),(48.740003,9.226692),(48.7466109115322,9.13566226791684),(48.7697612239563,9.17227511969105),(48.779637,9.248607),(48.78027,9.17741),(48.78424,9.147031),(48.7991260929923,9.2103721619827),(48.8049096843441,9.22694627279157),(48.8051353551738,9.2259876274458),(48.8066868106697,9.10434544086456),(48.80811,9.18551),(48.8115094776975,9.16749723956591),(48.826,9.21488),(48.8831394125002,9.21056628227234),(48.8835627257141,9.18272495269776),(48.8848361713629,9.20665562152863),(48.8872947821604,9.2007064819336),(48.8895134247259,9.1905677318573),(48.8902752888141,9.21991109848023),(48.8930334218936,9.20643031597138),(48.893188538891,9.19294323883694),(48.8937670173507,9.1643089056015),(48.8961722884826,9.17989253997803),(48.8990394179674,9.18130874633789),(48.9002243090629,9.19417262077332),(48.9017723833783,9.17190492153168),(48.9024917455577,9.19581413269043),(48.9034826147431,9.19820666313172),(48.9073260139394,9.2190957069397),(48.9093286956359,9.24098253250122),(49.3886384101731,8.67669265277856),(49.3963274040639,8.68809847223353),(49.3976823990632,8.68953472255641),(49.397708811771,8.67267894973753),(49.4047076261159,8.64976028739517),(49.4064875434975,8.68846627824381),(49.406723,8.69424),(49.40913,8.698543),(49.409534026017,8.6767111543656),(49.4117917045885,8.69271700724856),(49.4118,8.65914),(49.4147048464748,8.71839594333201),(49.4192588715679,8.72596429206184),(49.4444004925686,11.0755011039822),(49.448765,11.082456),(49.4733000861,8.48295573360397),(49.4799213023414,8.46539838729274),(49.4815900089383,8.45751553529948),(49.481632440197,8.46035466079088),(49.48193,8.43024),(49.49027,8.481114),(49.4916711394921,8.45572282539566),(49.4940991138233,8.47216251294866),(49.497220384961,8.45931945094248),(49.50239,8.41675),(49.5024996753956,8.41767525653268),(49.615944,8.992066),(49.648463,8.505124),(49.651834,8.588048),(49.661562,8.576529),(49.714285,8.615094),(49.744477929549,8.99666011333466),(49.768993,9.939413),(49.769577,9.939424),(49.780459,8.648295),(49.8004244227834,9.93309348974435),(49.8004915063841,9.96103227138519),(49.8005122811979,9.96138095855713),(49.8006369298935,9.96131122112274),(49.806852,8.948973),(49.814585,8.622561),(49.8207669445928,8.75055134296417),(49.84743,8.64602),(49.867808,8.487299),(49.8678561642216,8.64139833043737),(49.869377,8.623713),(49.872126,8.646659),(49.874005,8.672037),(49.8919284811951,8.66160929203034),(49.8950573,8.6654254),(49.90125858055,8.67266535758972),(49.904475,8.536846),(49.9306849468279,8.62157464027405),(49.932738,8.659898),(49.9381478564409,8.64920822175918),(49.9412841943315,8.44480296298571),(49.9413370554554,8.44487745911465),(49.9475886056609,11.5754163265228),(49.968707,8.441448),(49.968777,8.441926),(49.9788208812166,9.16032306920824),(50.0054083627179,8.68567943572998),(50.0055552575633,8.68574076703226),(50.007881,8.280194),(50.008147,8.674836),(50.012307,8.064773),(50.020005,8.927682),(50.0270452909445,8.72119724750519),(50.040216,7.811698),(50.052994,8.277912),(50.0713117,8.7351038),(50.0751307278251,8.47725570201874),(50.0779709453976,8.48062992095947),(50.088241,8.513669),(50.093464,8.473581),(50.10407,8.50174),(50.1044440045287,8.50418508052826),(50.112920247359,8.75178334164736),(50.120881765296,8.87823193985241),(50.124062,8.417656),(50.124074,8.417782),(50.13081,8.11911),(50.131972,8.820444),(50.1448373326819,8.95983029535273),(50.148984,8.709719),(50.149228,8.709188),(50.1737098925121,8.29468309879303),(50.1738129636034,8.29479038715363),(50.1770217990308,8.29838454723358),(50.177069895567,8.29848110675812),(50.185525,8.558612),(50.2414095,9.1197638),(50.279968,8.612589),(50.281251,8.614871),(50.287158,8.269894),(50.3040103,9.4263054),(50.3160076368386,8.70880405753269),(50.333868,9.038855),(50.363008,8.64232),(50.383807,8.406892),(50.3853577,9.0281281),(50.3884141764531,8.08208584785462),(50.3899737822885,8.08198928833008),(50.397502,8.460949),(50.4038814189231,8.16053509712219),(50.425279,8.677521),(50.43989,8.925089),(50.449481,9.048017),(50.45092,9.04229),(50.45188,9.043449),(50.506557,8.271959),(50.509734,8.654937),(50.519292,9.09324),(50.54305,8.14732),(50.549419,8.427021),(50.550363,8.46732),(50.559557,9.910363),(50.564968,8.7405),(50.567416,9.255976),(50.575041,8.562544),(50.577082,9.248127),(50.583187,9.551504),(50.592154,8.436444),(50.59437,8.43609),(50.595277,8.854319),(50.6278578199623,6.98836003432725),(50.641062,8.696359),(50.644672,9.130076),(50.644775,9.363825),(50.64481,7.099431),(50.670911,7.188015),(50.67356,7.1916995),(50.700828,7.166869),(50.703938,9.306125),(50.711822,7.139977),(50.713592,8.499111),(50.715294,7.117488),(50.715843,7.116407),(50.71995,7.144594),(50.722259,7.133642),(50.72817,7.11206),(50.728205,8.662766),(50.729255,8.292364),(50.733428,7.115064),(50.7376321974817,7.10662675446168),(50.73901,7.1153),(50.74042,7.06959),(50.740632,8.239213),(50.742508,7.113626),(50.757205,9.241374),(50.758585,7.104135),(50.759098,7.103872),(50.76238,6.972411),(50.7681,7.06876),(50.773903,7.3775787),(50.7742249564695,8.75800146794063),(50.79667,7.1651273),(50.799595,7.0360007),(50.8034223969227,7.20524071633832),(50.80748,7.59644),(50.808167,8.970818),(50.820718,9.727752),(50.821562,9.73528),(50.8245442,8.7161966),(50.8284579079376,7.20530313814918),(50.847818,9.291475),(50.850847,7.994401),(50.852587,9.434167),(50.857235,9.805901),(50.858373,9.977205),(50.85888,6.901196),(50.863937,9.192529),(50.867733,8.558567),(50.874657,7.331745),(50.880333,8.010402),(50.88687,6.84666),(50.8876591225622,6.87939530972825),(50.887861,6.896855),(50.888827,8.024446),(50.89377,6.91349),(50.89553,6.9044),(50.895875,9.160975),(50.900846,6.903282),(50.9029550223165,6.99348449707031),(50.9075893,9.515396),(50.913017,6.948681),(50.914497,6.9818854),(50.9182,6.960489),(50.918268,8.708246),(50.9189428,8.7050098),(50.9205490788521,6.94476961008295),(50.9271949307839,6.93332993368567),(50.930084,6.930417),(50.9307109759119,6.96752071380615),(50.933098,6.8929157),(50.9331197607464,6.92502124610515),(50.9337571362235,6.95629298686981),(50.9363725713497,6.94783675677338),(50.93649,6.96658),(50.939551,9.274604),(50.94118,6.9701),(50.945816,6.9266076),(50.9578343313361,6.95542936434032),(50.962322,6.986403),(50.979054,9.206268),(51.00969,7.62874),(51.01643,7.33235),(51.028371,13.786793),(51.029632,13.700802),(51.032988,8.72721),(51.035235,9.250291),(51.035538,6.996523),(51.042039,13.750873),(51.043818,8.766338),(51.047544,13.744222),(51.047724,13.743127),(51.047757,13.743534),(51.05817,13.753634),(51.05818,6.920157),(51.060671,13.777038),(51.062605,13.773431),(51.064514,9.619295),(51.065796,13.778404),(51.065941,13.776767),(51.07182,7.02676),(51.089396,8.950159),(51.103591,9.960599),(51.1048,7.1633344),(51.1213754725748,7.38360413820442),(51.12138,7.3836),(51.124106,9.235686),(51.12416,9.23535),(51.1304471472522,8.87779426568159),(51.131306,8.874157),(51.145373,9.920657),(51.14898,6.88668),(51.164951,9.318208),(51.17673,6.80955),(51.186396,9.393864),(51.18775,6.77722),(51.18834,6.77571),(51.19593,6.79665),(51.21074,6.771311),(51.21216,6.77071),(51.21577,6.77688),(51.2172271460466,6.77541596694951),(51.2201367291365,6.76712214946747),(51.22331,6.77929),(51.2316462911513,6.77584052122256),(51.23166,6.7632),(51.260135,9.421791),(51.27686,6.71403),(51.2786086,8.6380424),(51.32066,12.38659),(51.3210971,8.9448834),(51.326411,9.774644),(51.3268,12.3735),(51.33459,12.39916),(51.33588,12.367455),(51.3391812675514,12.3456047655054),(51.3392786397904,12.3455107212067),(51.33937,12.34549),(51.3463223039936,12.376720905304),(51.34635,12.37645),(51.34652,12.37755),(51.358935,9.12251),(51.413788,9.440625),(51.42661,7.03875),(51.435057,8.958232),(51.4412556991375,7.00273275375366),(51.4431214631245,6.97936534881592),(51.4441492725668,9.12087964985403),(51.444184,9.121025),(51.4464867505289,7.00980785699051),(51.4792918088449,7.2251914408063),(51.4910388007765,6.87438683945242),(51.4966778203402,6.82409763336182),(51.49925,7.42673),(51.5055805167451,6.86947524547577),(51.5335695971316,6.80827260017395),(51.55918,9.411189),(51.559219,9.415306),(51.5914917,9.5753041),(51.5975583,9.5836931),(51.91085,10.43207),(51.91204,10.44066),(51.91363,7.65129),(51.92014,10.43062),(51.950031,7.617214),(51.954389,7.630058),(51.954967,7.626263),(51.959222,7.636466),(51.96127,7.609079),(51.961509,7.634473),(51.961778,7.63751),(51.966948,7.615833),(51.971566,7.635724),(51.9896042972782,8.50646495819092),(52.0120032326961,8.54580974591954),(52.0154970396724,8.52236187536619),(52.020194649584,8.55611310993747),(52.0225860014524,8.53217124938965),(52.02326880768,8.52482199668884),(52.0289027524731,8.52921883435064),(52.40154,13.057803),(52.4385229677961,13.3878290681009),(52.4577578804735,13.5193596012857),(52.46676,13.30916),(52.48812,13.36979),(52.49058,13.33308),(52.49199,13.37412),(52.4925,13.55849),(52.4931181591588,13.4291492486679),(52.50025,13.47438),(52.5017288,13.4457312441397),(52.5129301793652,13.3267647027969),(52.513738679772,13.4743671592387),(52.5140658632566,13.4177510207081),(52.521734166926,13.4177559614182),(52.52718,13.37202),(52.5315871869076,13.4124398231506),(52.533665,13.198963),(52.54884,13.40037),(52.55819,13.36494),(52.56681,13.41217),(53.0612,8.8528),(53.066,8.8073),(53.0693,8.8198),(53.0722,8.804),(53.0726,8.804),(53.0764,8.7974),(53.0765,8.7969),(53.0778,8.833),(53.0781,8.8328),(53.0845,8.8263),(53.0847,8.8264),(53.0891,8.8409),(53.456448,9.985719),(53.457004,9.987104),(53.457016,9.984583),(53.489563,10.186409),(53.490731,10.019164),(53.491389,10.207636),(53.491655,10.018671),(53.492022,10.0146667),(53.537603,10.108453),(53.537659,10.107673),(53.540829,9.966497),(53.550202,9.936786),(53.550256,9.934011),(53.557378,9.966939),(53.557445,9.967575),(53.557726,9.997926),(53.558194,9.993342),(53.559375,9.995765),(53.559573,9.989954),(53.563549,9.812432),(53.563894,10.044557),(53.566185,10.019947),(53.56716,9.971194),(53.571095,10.064093),(53.571251,9.868894),(53.571629,10.065335),(53.574525,10.036199),(53.575705,9.953765),(53.575722,10.036556),(53.575747,9.970165),(53.575855,10.034132),(53.576023,9.970437),(53.577028,10.010338),(53.579928,9.999098),(53.580518,9.999531),(53.581429,9.972625),(53.581491,9.970861),(53.594891,10.146629),(53.595264,10.146695),(53.597822,10.042419),(53.59874,10.042867),(53.59969,10.041213),(53.601924,9.890147),(53.605705,10.119304),(53.6145,11.41208),(53.616985,9.950679),(53.6214,11.4213),(53.628615,9.931821),(53.63673,11.41092),(53.6487464640241,10.0178494182572),(53.6493982521776,10.0185545032651),(53.6493997642996,10.0169670760405),(53.6501663805001,10.0180209746646),(53.6501790987596,10.0176871079454),(53.655758,10.093586),(53.656418,10.09482),(53.656706,10.09405),(53.6793951060888,9.96827596589361),(53.6815190211836,9.99000431715609),(53.689799,9.98537),(53.70021,10.01415),(53.71485,10.00001),(54.00581,11.04333),(54.07839,12.10193),(54.0792069041561,12.0943593978882),(54.081974,12.114006),(54.083782,12.153115),(54.089867988164,12.1360248327255),(54.089951050869,12.1360934962286),(54.0900315962122,12.1358799934387),(54.0915228259465,12.1494215480696),(54.0916770797444,13.4004020690918),(54.0922748491882,12.0984363555908),(54.0925202467819,12.0983022451401),(54.0938691210985,13.3897751569748),(54.0971227557894,12.1709418296814),(54.102818,12.0749855),(54.10295,12.07408),(54.1417214295518,12.1871745586395),(54.17664,12.05835),(54.1908834113582,12.1821901140213),(54.1910343394493,12.1809456385772),(54.1910466208228,12.1817400393486),(54.40105,13.02003)]
print(len(location_points))
i = 0
for point_i in location_points:
    i = i+1
    print(i)
    network = netapy.networks.NetascoreNetwork.from_point(point=point_i, dist=1000)

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

    if i == 1:
        full_graph = G
    else:
        # combine graphs
        graphs = [full_graph, G]
        full_graph = nx.compose_all(graphs)

# save graph as a geopackage
# bei Aenderungen in Abfrage zu Radinfrastruktur habe ich jeweils die Nummer erhoeht.
ox.io.save_graph_geopackage(full_graph, filepath="./data/RadinfraOSM_DZS-Points_infra09_reversed.gpkg")
