SELECT id,                                         
    ST_Centroid(geometry) AS centroid_geom, 
    ST_Area(geometry) AS area                        
FROM landuse;
