import os
import json
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables from the project root
load_dotenv(Path(__file__).resolve().parent.parent / ".env")

import psycopg

# Load transportation segments from GeoJSON
data_path = Path(__file__).resolve().parent.parent / "data" / "dresden_segments.geojson"

with data_path.open(encoding="utf-8") as file:
    features = json.load(file)["features"]

# Keep only road segments
roads = [
    feature
    for feature in features
    if feature["properties"].get("subtype") == "road"
]

# Connect to PostgreSQL and insert road geometries
with psycopg.connect(
    host="localhost",
    port=5432,
    dbname="geospatial",
    user="geo_user",
    password=os.environ["POSTGRES_PASSWORD"],
) as conn:
    with conn.cursor() as cur:
        for feature in roads:
            props = feature["properties"]

            cur.execute(
                """
                INSERT INTO roads (id, road_class, subtype, geom)
                VALUES (
                    %s, %s, %s,
                    ST_SetSRID(ST_GeomFromGeoJSON(%s), 4326)
                )
                ON CONFLICT (id) DO NOTHING
                """,
                (
                    feature["id"],
                    props.get("class"),
                    props.get("subtype"),
                    json.dumps(feature["geometry"]),
                ),
            )

print(f"Processed {len(roads)} road segments.")
