DROP VIEW IF EXISTS rent_geo;

CREATE VIEW rent_geo AS
SELECT
    r.*,
    s.lat,
    s.lon
FROM rent r
LEFT JOIN suburb_fixes f
    ON r.suburb = f.rent_name
LEFT JOIN suburbs s
    ON UPPER(COALESCE(f.official_name, r.suburb)) = UPPER(s.suburb);

-- joins can secretly duplicate rows. should still be 25818
SELECT COUNT(*) FROM rent_geo;

-- match rate after fixes
SELECT
    COUNT(DISTINCT suburb) AS rent_suburbs,
    COUNT(DISTINCT suburb) FILTER (WHERE lat IS NOT NULL) AS matched
FROM rent_geo;

-- what's still unmatched
SELECT DISTINCT suburb
FROM rent_geo
WHERE lat IS NULL
ORDER BY suburb;