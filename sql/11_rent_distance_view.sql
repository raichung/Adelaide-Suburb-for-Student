DROP VIEW IF EXISTS rent_distance;

CREATE VIEW rent_distance AS
SELECT
    g.*,
    c.campus,
    SQRT(POWER((g.lat - c.lat) * 111, 2) + POWER((g.lon - c.lon) * 91, 2)) AS km
FROM rent_geo g
CROSS JOIN campuses c;

-- 25818 rent rows x 3 campuses
SELECT COUNT(*) FROM rent_distance;

-- each campus should have 25818
SELECT campus, COUNT(*)
FROM rent_distance
GROUP BY campus;

-- same as last lesson, should give the same 4 suburbs
SELECT
    suburb,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent
FROM rent_distance
WHERE campus = 'Flinders Bedford Park'
  AND dwelling = 'flat'
  AND bedrooms = '1br'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
  AND km <= 10
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent;