import geopandas as gpd
from pathlib import Path

path = Path("data/raw/suburbs/Suburbs_GDA2020.geojson")
gdf = gpd.read_file(path)

print(path.name)
print("Suburbs:", len(gdf))
print(gdf.columns.tolist())
print(gdf.crs)
print(gdf.drop(columns="geometry").head())