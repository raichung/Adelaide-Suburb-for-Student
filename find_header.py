import pandas as pd
from pathlib import Path

for f in sorted(Path("data/raw").glob("*.xlsx")):
    raw = pd.read_excel(f, sheet_name="Suburb", header=None)

    # every cell that says "Flats/Units"
    rows, cols = raw.isin(["Flats/Units"]).to_numpy().nonzero()

    print(f.name, "| size:", raw.shape, "| Flats/Units at:", list(zip(rows, cols)))