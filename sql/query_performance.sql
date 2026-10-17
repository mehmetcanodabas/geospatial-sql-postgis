-- Query Performance Analysis
-- PostgreSQL + PostGIS | Dresden Geospatial Dataset

-- Analyze spatial join performance using GiST geography index.
-- Find all building-road pairs within 50 meters.

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*)
FROM buildings b
JOIN roads r
    ON ST_DWithin(
        b.geom::geography,
        r.geom::geography,
        50
    );