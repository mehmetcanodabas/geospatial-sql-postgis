import os
import json
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables from the project root
load_dotenv(Path(__file__).resolve().parent.parent / ".env")

import psycopg
from psycopg.types.json import Jsonb

# Load building features from GeoJSON
data_path = Path(__file__).resolve().parent.parent / "data" / "dresden_buildings.geojson"

with data_path.open(encoding="utf-8") as file:
    features = json.load(file)["features"]

# Connect to PostgreSQL
with psycopg.connect(
    host="localhost",
    port=5432,
    dbname="geospatial",
    user="geo_user",
    password=os.environ["POSTGRES_PASSWORD"],
) as conn:
    with conn.cursor() as cur:
        for feature in features:
            props = feature["properties"]

            cur.execute(
                """
                INSERT INTO buildings
                    (id, height, building_class, subtype, roof_shape, geom)
                VALUES
                    (%s, %s, %s, %s, %s, ST_SetSRID(ST_GeomFromGeoJSON(%s), 4326))
                ON CONFLICT (id) DO NOTHING
                """,
                (
                    feature["id"],
                    props.get("height"),
                    props.get("class"),
                    props.get("subtype"),
                    props.get("roof_shape"),
                    json.dumps(feature["geometry"]),
                ),
            )

print(f"Processed {len(features)} building features.")
