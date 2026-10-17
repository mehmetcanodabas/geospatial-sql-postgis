
CREATE TABLE IF NOT EXISTS buildings (
    id TEXT PRIMARY KEY,
    height DOUBLE PRECISION,
    building_class TEXT,
    subtype TEXT,
    roof_shape TEXT,
    geom GEOMETRY(GEOMETRY, 4326)
);

-- Store road segments from Overture Maps
CREATE TABLE IF NOT EXISTS roads (
    id TEXT PRIMARY KEY,
    road_class TEXT,
    subtype TEXT,
    geom GEOMETRY(GEOMETRY, 4326)
);