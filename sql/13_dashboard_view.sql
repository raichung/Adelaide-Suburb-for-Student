DROP VIEW IF EXISTS dashboard_summary;

CREATE VIEW dashboard_summary AS
SELECT
    suburb,
    region,
    campus,
    dwelling,
    bedrooms,
    MIN(lat) AS lat,
    MIN(lon) AS lon,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent,
    ROUND(SUM(leases * median_rent) / SUM(leases)
          / CASE bedrooms WHEN '1br' THEN 1 WHEN '2br' THEN 2 WHEN '3br' THEN 3 WHEN '4br' THEN 4 END, 0) AS per_room,
    MIN(median_rent) AS lowest,
    MAX(median_rent) AS highest,
    MAX(median_rent) - MIN(median_rent) AS price_range,
    SUM(leases) >= 20 AS reliable
FROM rent_distance
WHERE quarter >= '2025-09'
  AND leases IS NOT NULL
  AND bedrooms <> 'all'
  AND lat IS NOT NULL
GROUP BY suburb, region, campus, dwelling, bedrooms;

-- how many rows? should divide evenly by 3 (one per campus)
SELECT COUNT(*) FROM dashboard_summary;

-- rows per campus, and how many are reliable
SELECT
    campus,
    COUNT(*) AS rows,
    COUNT(*) FILTER (WHERE reliable) AS reliable_rows
FROM dashboard_summary
GROUP BY campus
ORDER BY campus;

-- summary for Mitchell Park, Flinders Bedford Park, 3-bedroom houses
SELECT *
FROM dashboard_summary
WHERE suburb = 'Mitchell Park'
  AND campus = 'Flinders Bedford Park'
  AND dwelling = 'house'
  AND bedrooms = '3br';