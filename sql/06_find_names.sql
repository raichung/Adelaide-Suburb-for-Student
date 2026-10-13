SELECT suburb, postcode
FROM suburbs
WHERE suburb ILIKE '%HALLORAN%'
   OR suburb ILIKE '%SULLIVAN%'
   OR suburb ILIKE '%KINGSTON%MURRAY%'
   OR suburb ILIKE '%FLAXMAN%'
   OR suburb ILIKE '%MUNNO%'
   OR suburb ILIKE '%BROWNLOW%'
   OR suburb ILIKE '%REDBANK%'
   OR suburb ILIKE '%RED BANK%'
   OR suburb ILIKE '%WILLSD%'
   OR suburb ILIKE '%WYN%'
ORDER BY suburb;