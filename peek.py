import pandas as pd
from pathlib import Path

files = sorted(Path("data/raw").glob("*.xlsx"))
print(f"Found {len(files)} files")
for f in files:
    print(" -", f.name)

latest = files[-1]
sheets = pd.ExcelFile(latest).sheet_names
print(f"\nSheets in {latest.name}: {sheets}")

# header=None means: show me the raw rows, don't guess where the headers are
df = pd.read_excel(latest, sheet_name=sheets[0], header=None, nrows=15)
print(df)