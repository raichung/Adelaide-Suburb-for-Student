# Learning log

## 2026-09-26
- Set up project: folders, git, virtual environment (venv)
- venv only changes which Python and pip are used. Git works the same inside it
- Read Excel with `pd.read_excel(path, sheet_name=..., header=None)`
- `header=None` shows raw rows without guessing column names

## 2026-09-27
- `.T` flips a table sideways, useful for viewing many columns
- `pd.set_option("display.max_columns", None)` shows all columns
- `df.iloc[row, col]` gets a value by position
- Slicing: `df.iloc[17:]` means row 17 to the end
- `.copy()` makes an independent copy
- `assert` stops the script if something is not true
- `.isin([...])`, `.where(...)`, `.ffill()` to tag rows by section
- Filtering: `df[condition]`, `~` means NOT
- `.str.endswith()`, `.astype(str)`, `.dropna(subset=[...])`
- `df[[col1, col2]]` picks several columns

## 2026-09-28
- Median = middle value. With an even count, average the two middle values
- Median resists outliers, average does not
- Small samples make medians unreliable. One lease can swing the result
- `.notna()` returns True for non-blank values. `.sum()` counts the Trues
- Method chaining: `df["col"].notna().sum()`
- Series = one column with labels. DataFrame = full table
- dtype: `int64` whole numbers, `float64` decimals, `object` text or mixed, `bool` True/False
- `.value_counts()` returns a Series. `.reset_index()` turns it into a table
- Wide vs long format. Long = one row per observation, preferred by databases and Power BI
- `for` loops, including a loop inside a loop
- f-strings: `f"{name}_count"` puts variables inside text
- `list.append()` and `pd.concat()` to stack tables
- `pd.to_numeric(errors="coerce")` turns bad values into NaN instead of crashing
- `(cond1) & (cond2)` for two conditions, brackets required
- Importing a file runs all its code, including prints
- Functions: `def`, inputs, `return`
- `assert condition, "message"` shows which file failed
- `Path.stem`, `.name`, `.suffix`
- `if __name__ == "__main__":` stops code running on import
- `to_csv(path, index=False)`
- Read tracebacks bottom up: last line is what, lines above are where
- Find a row by value: `df.index[df[col] == value][0]`
- List comprehension: `[x for x in items if condition]`
- Never hardcode positions in messy data. Search for them
- Compare same quarter year on year to avoid seasonal bias

## 2026-10-03
- Installed Postgres.app, created a database with `createdb`
- `Int64` in pandas = whole numbers that allow blanks
- `CREATE TABLE` with types: TEXT, INTEGER, NUMERIC, BOOLEAN
- `DROP TABLE IF EXISTS` makes a script safe to re-run
- `\copy table FROM 'file.csv' WITH (FORMAT csv, HEADER true)` loads a CSV
- NULL is SQL's blank
- SELECT, FROM, WHERE, GROUP BY, ORDER BY, LIMIT
- `COUNT(*)` and `AS` to name results
- Text in SQL uses single quotes
- `cat file` prints a file in the terminal. Handy to check a file actually saved
- `\dt` in psql lists tables. "Relation" = table
- If a step prints nothing when it should, the next error is usually caused by it

## 2026-10-06
- Weighted average: bigger groups count more
- `IS NULL` / `IS NOT NULL`, never `= NULL`
- WHERE filters rows before grouping, HAVING filters groups after
- Clause order: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
- `ROUND(value, 0)`
- Text dates in YYYY-MM format sort correctly
- Check SQL results by hand against numbers you already have
- A query can run fine and still answer the wrong question. Reread WHERE against the question
- One quarter can mislead. A full year gives a more reliable picture

## 2026-10-12
- GeoJSON stores shapes. geopandas reads it like pandas, plus a geometry column
- CRS = coordinate system. Measure on a flat map (metres), then convert back to lat/lon
- `.centroid` finds a shape's centre
- Store postcodes as TEXT. If you wouldn't add it up, it's text. Leading zeros stay (0872)
- Table nicknames: `FROM rent r`
- JOIN keeps matches only. LEFT JOIN keeps everything from the left table
- `UPPER()` to compare text without caring about capitals
- `COUNT(DISTINCT col)` counts unique values
- LEFT JOIN + `WHERE right.col IS NULL` finds rows with no match
- Always check the match rate after a join. Silent drops give wrong answers with no error
- Unmatched names come from punctuation, cut-off text, and spelling differences

## 2026-10-13
- `ILIKE '%text%'` finds partial matches, ignoring capitals
- Lookup (crosswalk) table to translate messy names into official ones
- `COALESCE(a, b)` uses a, or b if a is blank
- You can chain several JOINs
- A view is a saved query. No data copied
- Always check row count after a join. Duplicate keys secretly multiply rows
- `COUNT(...) FILTER (WHERE ...)` counts only some rows
- Pick matches carefully. Two places can share a name (Brownlow vs Brownlow KI)

## 2026-10-14
- CSV rules: no comma after the last value, no spaces around commas
- Distance with Pythagoras: √(south² + east²)
- 1 degree lat ≈ 111 km. 1 degree lon ≈ 91 km in Adelaide
- `POWER(x, 2)` and `SQRT(x)`
- CTE: `WITH name AS (...)`, a temporary table inside one query
- A CTE only exists for the one query it's attached to
- CROSS JOIN pairs every row with every row
- Use a CTE when you need to filter on something you calculated
- `MIN()` to pick a value that's the same for every row in a group
- SQL has no `print`. In psql use `\echo 'text'`, no semicolon
- Check outliers quarter by quarter before trusting them
- An average of very different values can be meaningless
- Show MIN and MAX next to an average so readers can see stability
- Sorting by cheapest pulls the noisiest suburbs to the top. Always check the range
- Correct your own earlier guesses when new data disproves them
- Copying the same block many times is a sign it should be a view

## 2026-10-16
- Turned a copied CTE into a view, `rent_distance`, for all campuses
- Check a new shortcut against an answer you already have
- `IN ('a', 'b')` is short for several ORs
- `CASE col WHEN 'a' THEN 1 ... END` turns values into other values
- GROUP BY two columns keeps combinations separate
- ORDER BY can use a name created in SELECT
- Do heavy maths in the database, keep the dashboard simple
- `<>` means not equal
- A comparison like `SUM(x) >= 20` makes a True/False column
- `\copy (SELECT ...) TO 'file.csv'` exports a query result
- `mkdir -p` makes a folder, no error if it exists
- Label data instead of hiding it, let the user filter
- Row count should divide by the number of campuses. Quick structure check


## 2026-10-29
- Power BI: Get data → Text/CSV → Transform Data opens Power Query
- Power Query records every step (Applied Steps) and replays them on new data
- Column type icons: ABC text, 1.2 decimal, 123 whole number
- Replace Values to clean text, then change the type
- Table view shows data, Report view is where charts go
- Filters on this page apply to every chart on the page. Filters on this visual apply to one
- Sort a chart from the ... in its top-right corner (hidden until you hover)
- Power BI sums numbers by default. For rents and prices, switch to Minimum or Average
- Check a new tool's output against numbers you already trust
- `.DS_Store` is a hidden macOS file. Add it to `.gitignore`
- Slicers let users filter the report themselves
- Slicer styles: Dropdown, Tile, Less than or equal to. Set in Format → Slicer settings → Options
- Single select stops users picking more than one option
- Hold Ctrl to pick several options in a slicer
- Slicers filter each other. Options with no matching data disappear
- Tile slicers have no column setting. Resize the box to change how tiles wrap
- Table visual: set number columns to Don't summarize
- Clicking a bar filters the other visuals on the page (cross-filtering)
- Rename visual titles in Format → General → Title, and fields by double-clicking them in the field box