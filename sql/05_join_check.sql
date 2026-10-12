-- how many rent suburbs found a location?
SELECT
    COUNT(DISTINCT r.suburb) AS rent_suburbs,
    COUNT(DISTINCT s.suburb) AS matched
FROM rent r
LEFT JOIN suburbs s
    ON UPPER(r.suburb) = UPPER(s.suburb);

-- which ones didn't match?
SELECT DISTINCT r.suburb
FROM rent r
LEFT JOIN suburbs s
    ON UPPER(r.suburb) = UPPER(s.suburb)
WHERE s.suburb IS NULL
ORDER BY r.suburb;