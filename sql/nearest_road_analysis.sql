
-- Nearest Road Analysis
-- Dataset: Dresden, Germany | PostgreSQL + PostGIS

-- Find the nearest road segment for 10 buildings
SELECT
    b.id AS building_id,
    nearest.id AS nearest_road_id,
    ROUND(
        ST_Distance(
            b.geom::geography,
            nearest.geom::geography
        )::numeric,
        2
    ) AS distance_m

FROM buildings AS b

CROSS JOIN LATERAL (
    SELECT
        r.id,
        r.geom
    FROM roads r
    ORDER BY
        r.geom::geography <-> b.geom::geography
    LIMIT 1
) AS nearest
ORDER BY distance_m DESC;
