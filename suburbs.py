import geopandas as gpd
from pathlib import Path

path = Path("data/raw/suburbs/Suburbs_GDA2020.geojson")
gdf = gpd.read_file(path)

# centres must be measured on a flat map in metres, then turned back into lat/lon
#interesting: vectorized processing: does not require a for loop, and is much faster than iterating through rows
#data is stored as GeoPandas GeoSeries, each point is a shapely Point object, which has x and y attributes for longitude and latitude
centres = gdf.to_crs(epsg=3107).geometry.centroid.to_crs(epsg=4326)

out = gdf[["suburb", "postcode"]].copy()
out["lat"] = centres.y.round(5)
out["lon"] = centres.x.round(5)

out.to_csv("data/clean/suburbs.csv", index=False)

print("Rows:", len(out))
print("Duplicate names:", out["suburb"].duplicated().sum())
print(out.head())