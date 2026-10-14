-- add distance to Flinders for every rent row
WITH near AS (
    SELECT
        g.*,
        SQRT(POWER((g.lat - c.lat) * 111, 2) + POWER((g.lon - c.lon) * 91, 2)) AS km
    FROM rent_geo g
    CROSS JOIN campuses c
    WHERE c.campus = 'Flinders Bedford Park'
)

-- cheapest 1-bed flats within 10 km, last year, 20+ leases
SELECT
    suburb,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent,
    MIN(median_rent) AS lowest,
    MAX(median_rent) AS highest
FROM near
WHERE dwelling = 'flat'
  AND bedrooms = '1br'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
  AND km <= 10
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;

-- why is Tonsley so cheap? check every quarter
SELECT quarter, leases, median_rent, low_sample
FROM rent
WHERE suburb = 'Tonsley'
  AND dwelling = 'flat'
  AND bedrooms = '1br'
ORDER BY quarter;

\echo 'Practice 1: cheapest 1-bed flats within 5 km of Flinders'

WITH near AS (
    SELECT
        g.*,
        SQRT(POWER((g.lat - c.lat) * 111, 2) + POWER((g.lon - c.lon) * 91, 2)) AS km
    FROM rent_geo g
    CROSS JOIN campuses c
    WHERE c.campus = 'Flinders Bedford Park'
)
SELECT
    suburb,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent,
    MIN(median_rent) AS lowest,
    MAX(median_rent) AS highest
FROM near
WHERE dwelling = 'flat'
  AND bedrooms = '1br'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
  AND km <= 5
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;

\echo 'Practice 2: cheapest 2-bed flats within 10 km of Adelaide Uni'

WITH near AS (
    SELECT
        g.*,
        SQRT(POWER((g.lat - c.lat) * 111, 2) + POWER((g.lon - c.lon) * 91, 2)) AS km
    FROM rent_geo g
    CROSS JOIN campuses c
    WHERE c.campus = 'Adelaide Uni North Terrace'
)
SELECT
    suburb,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent,
    MIN(median_rent) AS lowest,
    MAX(median_rent) AS highest
FROM near
WHERE dwelling = 'flat'
  AND bedrooms = '2br'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
  AND km <= 10
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;