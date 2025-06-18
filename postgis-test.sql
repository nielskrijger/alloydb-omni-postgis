\set QUIET 1
\pset pager off
\pset tuples_only on

-- Reset test case
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS locations;

-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Ensure it's installed
DO $$
BEGIN
	RAISE NOTICE 'PostGIS version: %', PostGIS_Full_Version();
END$$;

-- Create a simple polygon table
CREATE TABLE regions (
	id SERIAL PRIMARY KEY,
	name TEXT,
	geom GEOMETRY(POLYGON, 4326)
);

-- Insert one rectangular polygon (roughly around Utrecht)
INSERT INTO regions (name, geom)
VALUES (
	'Utrecht',
	ST_GeomFromText('POLYGON((5.0 52.0, 5.2 52.0, 5.2 52.2, 5.0 52.2, 5.0 52.0))', 4326)
);

-- Create a table for points
CREATE TABLE locations (
	id SERIAL PRIMARY KEY,
	name TEXT,
	geom GEOMETRY(POINT, 4326)
);

-- Insert some points
INSERT INTO locations (name, geom)
VALUES
	('Inside Point 1', ST_SetSRID(ST_MakePoint(5.1, 52.1), 4326)), -- inside
	('Inside Point 2', ST_SetSRID(ST_MakePoint(5.05, 52.05), 4326)), -- inside
	('Outside Point 1', ST_SetSRID(ST_MakePoint(5.3, 52.3), 4326)); -- outside

-- Query: Find points within the Utrecht region
SELECT l.id, l.name
FROM locations l
JOIN regions r ON ST_Within(l.geom, r.geom) -- unrecognized node type: 435
WHERE r.name = 'Utrecht';