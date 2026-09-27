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