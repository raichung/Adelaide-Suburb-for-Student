# Project notes

## Findings

### Data coverage
- 988 different suburbs appear across 8 quarters. 987 (99.9%) matched to a location after fixing names. Only Willsden is unmatched

### Last year rankings (Jul 2025 to Jun 2026, suburbs with 20+ leases)
- Cheapest reliable Metro 1-bed flat: Prospect ($366, 63 leases). Tonsley is cheaper ($286) but only 21 leases
- Adelaide CBD 1-bed: $438 over the year (4,483 leases), cheaper than Bowden ($450). One quarter alone suggested the opposite
- Cheapest Metro 3-bed houses are all in the Elizabeth area ($462 to $510), about $154 per person if shared 3 ways
- Within 5 km of Flinders, the only 1-bed flat result is Tonsley, which is unreliable. No trustworthy 1-bed price close to Flinders
- 2-bed flats within 10 km of Adelaide Uni: Brooklyn Park is the most reliable pick ($461, 124 leases, $450 to $470). Collinswood is closest (3.4 km, $469)
- Henley Beach South looks cheapest for 2-bed ($383) but ranges $240 to $510. Unreliable
- Near Flinders (within 5 km), a room in a share house costs about $209 to $221 a week vs $390 for the cheapest reliable 1-bed flat (6.4 km away). About $170 a week, or $8,800 a year, cheaper
- Best share house picks near Flinders: Mitchell Park (1.7 km, $220/room, 123 leases), Sturt (1.6 km, $219), Marion (2.1 km, $209)
- Flagstaff Hill 4-bed is cheapest per room ($172), possibly less since 4br means 4 or more
- Per-room costs near Flinders are very consistent ($209 to $221). Housing type matters more than suburb

### Trends (8 quarters, Sep 2024 to Jun 2026)
- Adelaide CBD 1-bed flat leases peak in Sep and Mar quarters (1,500 to 2,400) and drop in Dec and Jun (540 to 815). Likely matches uni semester starts
- CBD 1-bed rent rose about 5 to 17% year on year, depending on quarter

### Single quarter (Apr-Jun 2026)
- 640 suburbs in total: 378 Metro, 262 Country
- 257 suburbs (40%) had 5 or fewer new leases
- Only 211 suburbs had any 1-bed flat leases (162 Metro, 49 Country)
- Of those 211, 187 were low sample. Only 24 suburbs had more than 5 one-bed flat leases, so one quarter alone is unreliable
- Adelaide CBD total median ($520) is lower than its 2-bed flat median ($650) because small flats dominate the mix. Total median can mislead when comparing suburbs

## Data quirks

### Rent data
- Each quarter is a separate Excel file with 4 sheets: Suburb, PC, Region, SLA. Only Suburb is used
- Rows above the header are titles and notes. Header is split across 3 rows (dwelling type, bedrooms, Count/Median)
- Header row moves between quarters: row 12 in older files, row 14 in 2026-06. The code finds it by searching for "Flats/Units"
- Excel creates hidden lock files (`~$...xlsx`) when a file is open. The code skips them
- `*` in a count column means 1 to 5 leases, hidden for privacy. The median is still shown
- Lease counts appear rounded to the nearest 5 (see note 3 in each file). Treat them as approximate
- "Metro" and "Country" section rows, plus "Metro Total", "Country Total" and "Grand Total" rows, are mixed in with suburbs
- Blank median (NaN) means no new leases of that type, not $0 rent
- Count columns have dtype `object` because they mix numbers and `*`

### Joining rent to suburb locations
- Suburb boundary names are in CAPITALS, rent names are Title Case. Joined with UPPER() on both sides
- Rent suburb names are cut at 30 characters in some cases (e.g. "Flaxman Valley (Mount Pleasan")
- Rent names drop apostrophes ("O Halloran Hill" vs official "O'Halloran Hill")
- "Wyne Vale" in the rent data is a typo for Wynn Vale
- "Brownlow Via Kingscote" matched to BROWNLOW KI (Kangaroo Island, 5223), not mainland BROWNLOW (5374)
- "Red Banks" matched to REDBANKS (5502). Judgement call, same name written as one word
- Willsden has no official match. Left unmatched
- If you rebuild the suburbs table, drop the `rent_geo` view first, since it depends on it

## Decisions

### Cleaning
- Named all 27 columns by hand instead of parsing the merged header. Added asserts so the script stops if the layout changes
- Find the header row by searching, not by fixed row number, so layout changes don't break the script
- Tagged each suburb as Metro or Country using forward fill
- Reshaped wide (27 columns) to long format: one row per suburb + dwelling + bedrooms
- Dropped "other" dwelling and "total" columns. Other is rare, and total median mixes property types
- Created `low_sample` flag before converting counts to numbers, so the `*` information is kept
- Wrapped cleaning in a function and ran it over all 8 quarters. Output saved to `data/clean/rent_long.csv`
- Leases stored as pandas `Int64` (whole numbers that allow blanks) so PostgreSQL accepts them as INTEGER

### Database
- Loaded clean CSV into PostgreSQL table `rent` (database `adelaide_rent`)
- `median_rent` stored as NUMERIC(7, 2) for exact money values
- Suburb locations from SA Gov suburb boundaries (GDA2020 version, newer official coordinates)
- Centre point of each suburb calculated on a flat SA map (EPSG 3107), then converted to lat/lon
- Raw boundary file not committed (too big). Only the small `data/clean/suburbs.csv` is
- Fixed unmatched suburb names with a hand-made lookup table (`data/manual/suburb_fixes.csv`). Kept in `data/manual/` to show it was typed by a person
- Saved the rent + location join as a view, `rent_geo`, so analysis queries stay short
- Distance to every campus saved as a view, `rent_distance` (rent rows × campuses). Pick a campus with WHERE
- If you rebuild `campuses` or `rent_geo`, drop `rent_distance` first

### Analysis
- Flag low-sample medians instead of deleting them
- Compare like with like (e.g. 2-bed flat vs 2-bed flat) rather than total median
- Rankings use the last 4 quarters (one full year) to avoid seasonal bias
- Only suburbs with 20+ known leases in that year are ranked
- Combined quarterly medians with a lease-weighted average. It's an estimate, not a true median, since we only have summary data
- Share house cost per room = house rent ÷ bedrooms. 4br means 4 or more, so per-room cost for 4br is a slight overestimate. Bills not included

## Open questions
- Is 8 quarters enough to make 1-bed flat prices reliable?
- Is 20 leases the right minimum for rankings?
- Why are CBD 1-bed medians lower in busy quarters?
- How does rent compare with distance to uni campuses? Cheap northern suburbs are far from the city
- Should rankings automatically hide suburbs where highest minus lowest is over $100?