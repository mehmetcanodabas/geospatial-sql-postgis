
-- Geospatial Building Analysis
-- Dataset: Overture Maps Buildings, Dresden, Germany
-- Database: PostgreSQL + PostGIS

-- 1. Building height statistics
SELECT
    COUNT(*) AS total_buildings,
    ROUND(AVG(height)::numeric, 2) AS avg_height_m,
    MAX(height) AS max_height_m,
    MIN(height) AS min_height_m
FROM buildings;

-- 2. Data quality: missing building heights
SELECT
    COUNT(*) AS total_buildings,
    COUNT(height) AS buildings_with_height,
    COUNT(*) - COUNT(height) AS missing_height
FROM buildings;

-- 3. Building type distribution
SELECT
    building_class,
    COUNT(*) AS building_count
FROM buildings
GROUP BY building_class
ORDER BY building_count DESC
LIMIT 10;

-- 4. Standardize building categories without modifying source data
SELECT
    CASE
        WHEN building_class IN ('garage', 'garages') THEN 'garage'
        WHEN building_class IS NULL THEN 'unknown'
        ELSE building_class
    END AS cleaned_class,
    COUNT(*) AS building_count
FROM buildings
GROUP BY cleaned_class
ORDER BY building_count DESC
LIMIT 10;

-- 5. Top 10 buildings by footprint area
SELECT
    id,
    ROUND(ST_Area(geom::geography)::numeric, 2) AS area_m2,
    height
FROM buildings
ORDER BY area_m2 DESC
LIMIT 10;
