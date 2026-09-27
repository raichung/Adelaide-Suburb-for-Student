# Where should a student rent in Adelaide?

Analysis of SA Government rental bond data to find which Adelaide suburbs give students the best rental value.

**Status:** in progress (data cleaning stage)

## Tools
Python (pandas), PostgreSQL, Power BI

## Project structure
```
data/raw/        quarterly Excel files from SA Government
data/clean/      cleaned data (coming soon)
peek.py          first look at the raw files
peek2.py         inspect the header layout
clean_one.py     clean one quarter
practice.py      exploration of 1-bed flat availability
NOTES.md         findings, data quirks and decisions
tidy_one.py      reshape one quarter into long format
```

## Data source
Private Rent Report, SA Government (Consumer and Business Services / SA Housing Authority), via data.sa.gov.au. Licensed under CC BY 4.0.