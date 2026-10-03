-- should be 25818
SELECT COUNT(*) FROM rent;

-- should match the row counts from clean.py
SELECT quarter, COUNT(*) AS rows
FROM rent
GROUP BY quarter
ORDER BY quarter;

-- cheapest reliable 2-bed flats in Metro, latest quarter
SELECT suburb, leases, median_rent
FROM rent
WHERE dwelling = 'flat'
  AND bedrooms = '2br'
  AND region = 'Metro'
  AND quarter = '2026-06'
  AND low_sample = false
ORDER BY median_rent
LIMIT 10;