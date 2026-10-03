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