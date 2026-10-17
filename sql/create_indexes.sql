-- Spatial indexes for faster geospatial queries
CREATE INDEX IF NOT EXISTS idx_buildings_geom
ON buildings
USING GIST (geom);

CREATE INDEX IF NOT EXISTS idx_roads_geom
ON roads
USING GIST (geom);

-- Geography index for accurate distance queries in meters
CREATE INDEX IF NOT EXISTS idx_roads_geography
ON roads
USING GIST ((geom::geography));