import pandas as pd

pd.set_option("display.max_columns", None)
pd.set_option("display.width", 200)

df = pd.read_excel(
    "data/raw/private-rental-report-2026-06.xlsx",
    sheet_name="Suburb",
    header=None,
)

print("Total rows:", len(df))

# .T flips the table sideways, so 27 columns become 27 rows (easy to read)
print(df.iloc[14:19].T)

print("\nLast 5 rows (first 4 columns):")
print(df.tail(5).iloc[:, :4])