-- cost per room in houses near Flinders, last year, 20+ leases
SELECT
    suburb,
    bedrooms,
    ROUND(MIN(km), 1) AS km,
    SUM(leases) AS total_leases,
    ROUND(SUM(leases * median_rent) / SUM(leases), 0) AS house_rent,
    ROUND(SUM(leases * median_rent) / SUM(leases)
          / CASE bedrooms WHEN '3br' THEN 3 WHEN '4br' THEN 4 END, 0) AS per_room,
    MIN(median_rent) AS lowest,
    MAX(median_rent) AS highest
FROM rent_distance
WHERE campus = 'Flinders Bedford Park'
  AND dwelling = 'house'
  AND bedrooms IN ('3br', '4br')
  AND quarter >= '2025-09'
  AND leases IS NOT NULL
  AND km <= 5
GROUP BY suburb, bedrooms
HAVING SUM(leases) >= 20
ORDER BY per_room
LIMIT 10;