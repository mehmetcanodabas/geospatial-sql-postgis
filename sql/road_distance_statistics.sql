
-- Nearest Road Distance Statistics
-- Dataset: Dresden, Germany | PostgreSQL + PostGIS

WITH nearest_roads AS (
    SELECT
        b.id AS building_id,
        ST_Distance(
            b.geom::geography,
            nearest.geom::geography
        ) AS distance_m
    FROM buildings b
    CROSS JOIN LATERAL (
        SELECT r.geom
        FROM roads r
        ORDER BY r.geom::geography <-> b.geom::geography
        LIMIT 1
    ) AS nearest
)

SELECT
    COUNT(*) AS total_buildings,
    ROUND(AVG(distance_m)::numeric, 2) AS avg_distance_m,
    ROUND(MIN(distance_m)::numeric, 2) AS min_distance_m,
    ROUND(MAX(distance_m)::numeric, 2) AS max_distance_m
FROM nearest_roads;
