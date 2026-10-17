-- Spatial Analysis: Buildings Near Roads
-- Dataset: Dresden, Germany | PostgreSQL + PostGIS

-- Step 1: Identify buildings within 50 meters of a road
WITH buildings_near_roads AS (
    SELECT DISTINCT b.id
    FROM buildings b
    JOIN roads r
        ON ST_DWithin(
            b.geom::geography,
            r.geom::geography,
            50
        )
)

-- Step 2: Calculate the number and percentage of nearby buildings
SELECT
    COUNT(*) AS buildings_within_50m,
    (SELECT COUNT(*) FROM buildings) AS total_buildings,
    ROUND(
        100.0 * COUNT(*) /
        NULLIF((SELECT COUNT(*) FROM buildings), 0),
        2
    ) AS percentage_within_50m
FROM buildings_near_roads;