
## geospatial-sql-postgis

Implementation of a PostgreSQL/PostGIS-Based Geospatial Data Pipeline for Spatial SQL Analysis of Building Footprints and Road Networks

The project integrates Overture Maps building and road datasets from Dresden, Germany into a PostgreSQL/PostGIS database using Python.

Spatial SQL queries are used to analyze building characteristics, road proximity, and query performance.

### Key Results

- 17,123 building footprints processed.
- 20,786 road segments processed.
- 99.84% of buildings located within 50 m of a road segment.
- Average nearest-road distance: 8.09 m.

### Result Snapshot

[Dresden Building and Road Network](docs/results/dresden_buildings_roads.png): Spatial distribution of building footprints and road segments in Dresden, Germany.

**Keywords:** Geospatial Data Engineering, Spatial SQL,
PostGIS, Spatial JOIN, GiST Indexing, ETL, QGIS.

**Data Source:** Overture Maps.
