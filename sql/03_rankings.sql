-- cheapest Metro 2-bed flats over the last year
-- only suburbs with 20+ known leases
SELECT
    suburb,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent
FROM rent
WHERE dwelling = 'flat'
  AND bedrooms = '2br'
  AND region = 'Metro'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;

-- cheapest Metro 1-bed flats over the last year
-- only suburbs with 20+ known leases
SELECT
    suburb,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent
FROM rent
WHERE dwelling = 'flat'
  AND bedrooms = '1br'
  AND region = 'Metro'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;

-- cheapest Metro 3-bed houses over the last year
-- only suburbs with 20+ known leases
SELECT
    suburb,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS avg_rent
FROM rent
WHERE dwelling = 'house'
  AND bedrooms = '3br'
  AND region = 'Metro'
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
GROUP BY suburb
HAVING SUM(leases) >= 20
ORDER BY avg_rent
LIMIT 10;