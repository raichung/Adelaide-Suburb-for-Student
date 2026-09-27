from clean_one import df

country = df[df["region"] == "Country"]
print("-------- Country Suburbs --------")
print("Total Country Suburbs:", len(country))
print(country[["suburb", "total_median"]])

filled = df["flat_1br_median"].notna()
print("-------- 1BR Median Filled Count --------")
print(filled.sum())

has_1br = df[df["flat_1br_median"].notna()]

print("-------- Where are the 1BR flats? --------")
print(has_1br["region"].value_counts())

print("-------- How many are low sample (*)? --------")
print((has_1br["flat_1br_count"] == "*").sum())