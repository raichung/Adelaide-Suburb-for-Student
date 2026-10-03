import pandas as pd
from pathlib import Path

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


def clean_quarter(path):
    raw = pd.read_excel(path, sheet_name="Suburb", header=None)

    # header moved between quarters, so find it instead of hardcoding
    h = raw.index[raw[1] == "Flats/Units"][0]

    assert raw.iloc[h, 11] == "Houses", path.name
    assert raw.iloc[h, 25] == "Total Count", path.name
    assert raw.iloc[h + 3, 0] == "Metro", path.name

    df = raw.iloc[h + 3:].copy()
    df.columns = COLUMNS
    df["region"] = df["suburb"].where(df["suburb"].isin(["Metro", "Country"])).ffill()
    df = df.dropna(subset=["suburb"])
    df = df[~df["suburb"].isin(["Metro", "Country"])]
    df = df[~df["suburb"].astype(str).str.endswith("Total")]

    pieces = []
    for dwelling in ["flat", "house"]:
        for beds in ["1br", "2br", "3br", "4br", "all"]:
            part = df[["suburb", "region", f"{dwelling}_{beds}_count", f"{dwelling}_{beds}_median"]].copy()
            part.columns = ["suburb", "region", "leases", "median_rent"]
            part["dwelling"] = dwelling
            part["bedrooms"] = beds
            pieces.append(part)

    tidy = pd.concat(pieces, ignore_index=True)

    # flag before converting, or we lose the *
    tidy["low_sample"] = tidy["leases"] == "*"
    # Int64 = whole numbers that allow blanks
    tidy["leases"] = pd.to_numeric(tidy["leases"], errors="coerce").astype("Int64")
    tidy["median_rent"] = pd.to_numeric(tidy["median_rent"], errors="coerce")
    tidy = tidy.dropna(subset=["median_rent"])

    # "private-rental-report-2026-06" -> "2026-06"
    tidy["quarter"] = path.stem.replace("private-rental-report-", "")
    return tidy


if __name__ == "__main__":
        # skip Excel lock files like ~$report.xlsx
    files = [f for f in sorted(Path("data/raw").glob("*.xlsx")) if not f.name.startswith(("~$", "."))]

    results = []
    for f in files:
        q = clean_quarter(f)
        print(f.name, len(q))
        results.append(q)

    all_q = pd.concat(results, ignore_index=True)
    all_q.to_csv("data/clean/rent_long.csv", index=False)
    print("Total rows:", len(all_q))

    check = all_q[
        (all_q["suburb"] == "Adelaide")
        & (all_q["dwelling"] == "flat")
        & (all_q["bedrooms"] == "1br")
    ]
    print(check[["quarter", "leases", "median_rent"]])