
-- Road Distance Ranking
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
    ROW_NUMBER() OVER (
        ORDER BY distance_m DESC, building_id
    ) AS distance_rank,
    building_id,
    ROUND(distance_m::numeric, 2) AS distance_m
FROM nearest_roads
ORDER BY distance_rank
LIMIT 20;
