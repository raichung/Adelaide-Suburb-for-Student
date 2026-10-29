# Where should a student rent in Adelaide?

Analysis of SA Government rental bond data to find which Adelaide suburbs give students the best rental value, including distance to uni campuses.

**Status:** in progress (first Power BI chart done, full dashboard next)

## Key findings so far
- Near Flinders University, a room in a share house costs about $209 to $221 a week, vs $390 for the cheapest reliable 1-bed flat. That's about $8,800 a year cheaper
- Best share house picks near Flinders: Mitchell Park, Sturt and Marion, all within about 2 km
- Adelaide CBD 1-bed flats averaged $438 over the last year, based on 4,483 leases
- One quarter of data can mislead. Small suburbs swing wildly, so rankings use a full year, 20+ leases, and show the price range

See `NOTES.md` for all findings, data quirks and decisions.

## Tools
Python (pandas, geopandas), PostgreSQL, Power BI

## Project structure
```
Data
data/raw/                      original files, never edited
data/clean/rent_long.csv       all 8 quarters of rent data, cleaned
data/clean/suburbs.csv         centre point of each suburb
data/manual/suburb_fixes.csv   hand-made fixes for suburb names
data/manual/campuses.csv       campus locations from Google Maps
data/dashboard/summary.csv     one row per suburb, campus, dwelling, bedrooms (for Power BI)
data/dashboard/trends.csv      every quarter with location (for trend charts)
dashboard/adelaide_rent.pbix   Power BI dashboard (needs Windows to open)

Python pipeline
clean.py                       clean all quarters into one long table
suburbs.py                     find each suburb's centre point

Python exploration
peek.py                        first look at the raw files
peek2.py                       inspect the header layout
clean_one.py                   clean one quarter
practice.py                    1-bed flat availability
tidy_one.py                    reshape one quarter into long format
find_header.py                 find the header row in each quarter
peek_suburbs.py                inspect the suburb boundary file

SQL (run in order)
sql/01_create_table.sql        create the rent table
sql/02_first_queries.sql       first checks and queries
sql/03_rankings.sql            cheapest suburbs over the last year
sql/04_suburbs.sql             create the suburbs table
sql/05_join_check.sql          check which suburbs match
sql/06_find_names.sql          search for official suburb names
sql/07_suburb_fixes.sql        load the name fixes
sql/08_rent_geo_view.sql       rent joined with locations (view)
sql/09_campuses.sql            create the campuses table
sql/10_near_campus.sql         cheapest rent near a campus
sql/11_rent_distance_view.sql  distance to every campus (view)
sql/12_share_houses.sql        cost per room in share houses
sql/13_dashboard_view.sql      summary view for the dashboard

Docs
NOTES.md                       findings, data quirks and decisions
LEARNING.md                    my daily learning log
```

## Method notes
- Rankings use the last 4 quarters (Jul 2025 to Jun 2026) and only suburbs with 20+ known leases
- Quarterly medians are combined with a lease-weighted average. An estimate, not a true median
- Distance is straight-line, not travel time
- Share house cost per room = house rent ÷ bedrooms. Bills not included
- Only 54% of suburb + dwelling + bedroom combos have 20+ leases. The dashboard marks these as reliable instead of hiding the rest

## Data sources
- Private Rent Report, SA Government (Consumer and Business Services / SA Housing Authority), via data.sa.gov.au. Licensed under CC BY 4.0
- Suburb boundaries, SA Government (Department for Infrastructure and Transport), via data.sa.gov.au. Licensed under CC BY 3.0 AU
- Campus locations typed by hand from Google Maps