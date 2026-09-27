import pandas as pd

FILE = "data/raw/private-rental-report-2026-06.xlsx"
raw = pd.read_excel(FILE, sheet_name="Suburb", header=None)

# Step 1: safety checks. If the layout changes, stop here
assert raw.iloc[14, 1] == "Flats/Units"
assert raw.iloc[14, 11] == "Houses"
assert raw.iloc[14, 25] == "Total Count"

# Step 2: give every column its own full name
COLUMNS = [
    "suburb",
    "flat_1br_count", "flat_1br_median",
    "flat_2br_count", "flat_2br_median",
    "flat_3br_count", "flat_3br_median",
    "flat_4br_count", "flat_4br_median",
    "flat_all_count", "flat_all_median",
    "house_1br_count", "house_1br_median",
    "house_2br_count", "house_2br_median",
    "house_3br_count", "house_3br_median",
    "house_4br_count", "house_4br_median",
    "house_all_count", "house_all_median",
    "other_count", "other_median",
    "other_all_count", "other_all_median",
    "total_count", "total_median",
]
df = raw.iloc[17:].copy()
df.columns = COLUMNS

# Step 3: tag each suburb as Metro or Country
# ffill = "fill down", like dragging a cell down in Excel until the next label
df["region"] = df["suburb"].where(df["suburb"].isin(["Metro", "Country"])).ffill()

# Step 4: drop junk rows (blanks, section labels, totals)
df = df.dropna(subset=["suburb"])
df = df[~df["suburb"].isin(["Metro", "Country"])]
df = df[~df["suburb"].astype(str).str.endswith("Total")]

print("Suburbs:", len(df))
print(df["region"].value_counts())
print(df[["suburb", "region", "flat_2br_median", "house_3br_median", "total_median"]].head(8))
print("\nSuburbs with '*' in total_count:", (df["total_count"] == "*").sum())