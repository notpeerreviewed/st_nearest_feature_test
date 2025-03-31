# Readme

This file is provided to demonstrate some unexpected behaviour with the st_nearest_feature function from the R sf package.

Initially, a collection of points was extracted from a database. These points were simple Lat Long coordinates with some other contextual information. The points were converted to an sf object using the code

outlets_wgs84 <- df %>% 
  distinct(OutletName, .keep_all = T) %>% 
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326) %>% 
  filter(Category == "Branch Corporate",
         !OutletName %in% c("Christchurch CBD Kiwibank",
                            "Manners Street Central Kiwibank",
                            "Papanui Kiwibank")) %>% 
  select(OutletName)

When attempting to use the st_nearest_feature function to identify the nearest point for a collecton of polygons, the function returns the northernmost point for every polygon. However, if the coordinates for both layers are converted to WGS84, and the longlat argument in the st_nearest_feature function is set to TRUE, the function returns the expected output.

When putting this MWE together, a geojson file was created for the point layer, and a further peculiarity was identified. If the geojson point layer is read in memory, the coordinates set to 2193 (NZTM), then the st_nearest_feature appears to behave as expected. All my comparisons of the outlets_wgs84 object with the points geojson object indicate they are identical, yet the st_nearest_feature function appears to prefer using WGS84 coords and longlat = TRUE for the former for some reason.
