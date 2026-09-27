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

## Data quirks
- Each quarter is a separate Excel file with 4 sheets: Suburb, PC, Region, SLA. Only Suburb is used
- Rows 0 to 13 are titles and notes. Header is split across rows 14 to 16 (dwelling type, bedrooms, Count/Median). Data starts at row 18
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

## Open questions
- Is 8 quarters enough to make 1-bed flat prices reliable?
- What minimum number of leases should a suburb need to appear in rankings?