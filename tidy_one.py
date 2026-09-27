import pandas as pd
from clean_one import df

pieces = []

# one small table per dwelling + bedroom combo
for dwelling in ["flat", "house"]:
    for beds in ["1br", "2br", "3br", "4br", "all"]:
        count_col = f"{dwelling}_{beds}_count"
        median_col = f"{dwelling}_{beds}_median"

        part = df[["suburb", "region", count_col, median_col]].copy()
        part.columns = ["suburb", "region", "leases", "median_rent"]
        part["dwelling"] = dwelling
        part["bedrooms"] = beds
        pieces.append(part)

tidy = pd.concat(pieces, ignore_index=True)

# flag before converting, or we lose the *
tidy["low_sample"] = tidy["leases"] == "*"
tidy["leases"] = pd.to_numeric(tidy["leases"], errors="coerce")
tidy["median_rent"] = pd.to_numeric(tidy["median_rent"], errors="coerce")

# no rent = nothing to analyse
tidy = tidy.dropna(subset=["median_rent"])

print("Rows:", len(tidy))
print(tidy.dtypes)
print(tidy.head(10))

# should match practice.py: 211 and 187
flat_1br = tidy[(tidy["dwelling"] == "flat") & (tidy["bedrooms"] == "1br")]
print("1br flats:", len(flat_1br))
print("Low sample:", flat_1br["low_sample"].sum())