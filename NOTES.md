# Project notes

## Findings
Data: Apr-Jun 2026 quarter

- 640 suburbs in total: 378 Metro, 262 Country
- 257 suburbs (40%) had 5 or fewer new leases
- Only 211 suburbs had any 1-bed flat leases (162 Metro, 49 Country)
- Of those 211, 187 were low sample. Only 24 suburbs had more than 5 one-bed flat leases, so most 1-bed prices are unreliable from one quarter alone
- Adelaide CBD total median ($520) is lower than its 2-bed flat median ($650) because small flats dominate the mix. Total median can mislead when comparing suburbs
- Adelaide CBD: 815 one-bed flat leases, median $500. Explains why its total median is low
- Bowden: 25 one-bed flat leases, median $374.50. Reliable and much cheaper than the CBD nearby
- Adelaide CBD 1-bed flat leases peak in Sep and Mar quarters (1,500 to 2,400) and drop in Dec and Jun (540 to 815). Likely matches uni semester starts
- CBD 1-bed rent rose about 5 to 17% year on year, depending on quarter

## Data quirks
- Each quarter is a separate Excel file with 4 sheets: Suburb, PC, Region, SLA. Only Suburb is used
- Rows above the header are titles and notes. Header is split across 3 rows (dwelling type, bedrooms, Count/Median)
- Header row moves between quarters: row 12 in older files, row 14 in 2026-06. The code finds it by searching for "Flats/Units"
- Excel creates hidden lock files (`~$...xlsx`) when a file is open. The code skips them
- `*` in a count column means 1 to 5 leases, hidden for privacy. The median is still shown
- "Metro" and "Country" section rows, plus "Metro Total", "Country Total" and "Grand Total" rows, are mixed in with suburbs
- Blank median (NaN) means no new leases of that type, not $0 rent
- Count columns have dtype `object` because they mix numbers and `*`

## Decisions
- Named all 27 columns by hand instead of parsing the merged header. Added asserts so the script stops if the layout changes
- Tagged each suburb as Metro or Country using forward fill
- Flag low-sample medians instead of deleting them
- Compare like with like (e.g. 2-bed flat vs 2-bed flat) rather than total median
- Reshaped wide (27 columns) to long format: one row per suburb + dwelling + bedrooms
- Dropped "other" dwelling and "total" columns. Other is rare, and total median mixes property types
- Created `low_sample` flag before converting counts to numbers, so the `*` information is kept
- Wrapped cleaning in a function and ran it over all 8 quarters. Output saved to `data/clean/rent_long.csv`
- Find the header row by searching, not by fixed row number, so layout changes don't break the script
- Leases stored as pandas `Int64` (whole numbers that allow blanks) so PostgreSQL accepts them as INTEGER
- Loaded clean CSV into PostgreSQL table `rent` (database `adelaide_rent`)
- `median_rent` stored as NUMERIC(7, 2) for exact money values

## Open questions
- Is 8 quarters enough to make 1-bed flat prices reliable?
- What minimum number of leases should a suburb need to appear in rankings?
- Why are CBD 1-bed medians lower in busy quarters?