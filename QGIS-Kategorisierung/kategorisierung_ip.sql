-- Straßenbegleitender Radweg
CASE
    WHEN highway IN ('primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified', 'cycleway', 'trunk', 'trunk_link', 'path')
    AND (
        CASE 
			WHEN traffic_sign LIKE '%240%' THEN TRUE
			WHEN traffic_sign LIKE '%241%' THEN TRUE
			WHEN "cycleway" IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE
            WHEN "cycleway:right" IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE
            WHEN "cycleway:left" IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE
            WHEN "cycleway:both" IN ('track', 'opposite_track', 'sidepath', 'crossing') THEN TRUE
            WHEN bicycle IN ('use_sidepath') THEN FALSE
            WHEN 'bicycle_road' = 'yes' THEN FALSE
            WHEN traffic_sign LIKE '%244.1%' THEN FALSE
            WHEN segregated NOT IN ('yes') THEN FALSE
            WHEN (bicycle NOT IN ('designated') OR bicycle IS NULL) THEN FALSE

            ELSE FALSE
        END
    ) THEN 'sep'
    ELSE NULL
END

-- Schutzstreifen / Radfahrstreifen

CASE 
    WHEN highway IN ('primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified')
    AND (
        CASE 
            WHEN "cycleway" IN ('crossing', 'lane', 'opposite_lane') THEN TRUE
            WHEN "cycleway:right" IN ('crossing', 'lane', 'opposite_lane') THEN TRUE
            WHEN "cycleway:left" IN ('crossing', 'lane', 'opposite_lane') THEN TRUE
            WHEN "cycleway:both" IN ('crossing', 'lane', 'opposite_lane') THEN TRUE
			WHEN try("cycleway:buffer") IS NOT NULL THEN TRUE
			WHEN try("cycleway:left:buffer") IS NOT NULL THEN TRUE
			WHEN try("cycleway:right:buffer") IS NOT NULL THEN TRUE
			WHEN try("cycleway:both:buffer") IS NOT NULL THEN TRUE
            ELSE FALSE
        END
    ) THEN TRUE
    ELSE NULL
END

-- separater Radweg

CASE 
	WHEN highway IN ('cycleway') THEN 'rw'
	WHEN is_sidepath IN ('yes') THEN FALSE
    WHEN highway IN ('cycleway', 'path', 'track', 'footway', 'pedestrian') AND
    (CASE 

		WHEN bicycle IN ('no') THEN FALSE
		WHEN foot IN ('no') THEN 'rw'
		WHEN (bicycle IS NULL AND foot IS NULL) THEN FALSE
		WHEN (bicycle = 'yes' AND foot = 'yes') THEN FALSE
		WHEN (bicycle = 'yes' AND foot IS NULL) THEN FALSE
		WHEN oneway IN ('yes') THEN 'rw'
        WHEN (bicycle IN ('designated') AND foot IN ('designated') AND segregated IN ('yes')) THEN 'rw'
		WHEN (bicycle IN ('designated') AND foot IS NULL) THEN 'rw'
        WHEN (bicycle IN ('designated') AND foot IN ('designated')) THEN FALSE
		WHEN (bicycle IS NULL AND foot IN ('designated')) THEN FALSE
        WHEN (bicycle IN ('yes') AND foot IN ('designated')) THEN FALSE
		WHEN traffic_sign LIKE ('%1022%') THEN FALSE
        WHEN traffic_sign LIKE ('%241%') THEN 'rw'
        WHEN traffic_sign LIKE ('%237%') THEN 'rw'

        WHEN segregated IN ('yes') THEN 'rw'
        ELSE NULL
    END) = 'rw'
    OR highway IN ('service') AND
    (CASE
        WHEN (bicycle IS NULL AND foot IS NULL) THEN FALSE
        ELSE NULL
    END) = 'rw' 
    THEN 'rw'
ELSE NULL
END

-- Fahrradstraße

CASE 
WHEN try("cyclestreet") IN ('yes') OR
try("bicycle_road") IN ('yes')
OR traffic_sign LIKE ('%244.1%')
THEN TRUE
ELSE NULL
END

--  Mischverkehr (MIV)

CASE
    WHEN bicycle IN ('no', 'use_sidepath') THEN FALSE
	WHEN bicycle_road = 'yes' THEN FALSE
    WHEN bicycle IS NULL OR bicycle NOT IN ('no', 'use_sidepath') THEN
        CASE
            WHEN highway = 'living_street' THEN TRUE
            WHEN highway IN ('primary', 'secondary', 'tertiary', 'unclassified', 'residential') THEN
                CASE
                    WHEN 'bicycle_road' = 'yes' THEN TRUE
                    WHEN traffic_sign LIKE '%244.1%' THEN FALSE
					WHEN "cycleway" IN ('lane', 'crossing', 'separate') THEN FALSE
					WHEN "cycleway:left" IN ('lane', 'crossing', 'separate') THEN FALSE
                    WHEN "cycleway:right" IN ('lane', 'crossing', 'separate') THEN FALSE
                    WHEN "cycleway:both" IN ('lane', 'crossing', 'separate') THEN FALSE
					
					WHEN "cycleway" IS NOT NULL AND "cycleway" IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate') THEN TRUE
                    WHEN "cycleway:left" IS NOT NULL AND "cycleway:left" IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE
                    WHEN "cycleway:right" IS NOT NULL AND "cycleway:right" IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE
                    WHEN "cycleway:both" IS NOT NULL AND "cycleway:both" IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite') THEN TRUE
					WHEN "cycleway" IS NULL AND "cycleway:left" IS NULL AND "cycleway:right" IS NULL AND "cycleway:both" IS NULL THEN TRUE


					
                    ELSE NULL
                END
            ELSE NULL
        END
    ELSE NULL
END

-- Mischverkehr für highway = service

CASE
    WHEN highway IN ('service') THEN 'mv_miv'
    WHEN highway IN ('primary', 'secondary', 'tertiary', 'unclassified', 'residential') AND
    (
        CASE 
            WHEN traffic_sign LIKE ('%244.1%') THEN 'not_mv_miv'
            WHEN "cycleway" IS NOT NULL AND "cycleway" NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'
            WHEN "cycleway:left" IS NOT NULL AND "cycleway:left" NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'
            WHEN "cycleway:right" IS NOT NULL AND "cycleway:right" NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'
            WHEN "cycleway:both" IS NOT NULL AND "cycleway:both" NOT IN ('shared', 'shared_lane', 'share_busway', 'shared_busway', 'no', 'opposite', 'separate', 'use_sidepath') THEN 'not_mv_miv'
            ELSE 'mv_miv'
        END
    ) = 'not_mv_miv' THEN TRUE
    ELSE FALSE 
END

-- Mischverkehr Fuß/Rad

CASE
WHEN "highway" IN ('footway', 'path', 'pedestrian', 'track', 'steps') AND 
    ((bicycle IN ('designated', 'yes') OR foot IN ('designated', 'yes') OR segregated IN ('no')) OR
    (bicycle IS NULL OR foot IS NULL OR segregated IS NULL)) THEN TRUE
ELSE NULL
END


-- nicht befahrbar

ELSE
