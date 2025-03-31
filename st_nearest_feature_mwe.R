

library(dplyr)
library(sf)
library(glue)
library(here)

# writing sa2 to geojson for Edzer example

##############################################################
# testing st_nearest_feature with NZTM projection (crs = 2193)
##############################################################

sa2 <- st_read(here("src/R/data/sa2_mwe/statistical-area-2-2025.shp")) %>% 
  st_transform(crs = 2193)

points <- st_read(here("src/R/data/sa2_mwe/points.shp")) %>% 
  st_transform(crs = 2193)

# return Kaitaia as the only OutletName
nearest_sa2_to_branch <- sa2 %>% 
  filter(!str_detect(SA22025__1, "Ocean")) %>% 
  st_join(points,
          join = st_nearest_feature
  ) 

##############################################################
# testing st_nearest_feature with WGS84 (crs = 4326)
##############################################################


sa2 <- st_read(here("src/R/data/sa2_mwe/statistical-area-2-2025.shp")) %>% 
  st_transform(crs = 4326)
points <- st_read(here("src/R/data/sa2_mwe/points.shp")) %>% 
  st_transform(crs = 4326)


# now testing using WGS84 and longlat argument in st_nearest_feature
# this still returns Kaitaia as the only OutletName
nearest_sa2_to_branch <- sa2 %>% 
  filter(!str_detect(SA22025__1, "Ocean")) %>% 
  st_join(points,
          join = st_nearest_feature,
          longlat = TRUE
  ) 


##############################################################
# testing st_nearest_feature with crs = 2193 but using geojson file for points
##############################################################

sa2 <- st_read(here("src/R/data/sa2_mwe/statistical-area-2-2025.shp")) %>% 
  st_transform(crs = 2193)

points <- st_read("https://raw.githubusercontent.com/notpeerreviewed/st_nearest_feature_test/refs/heads/main/outlets_wgs84.geojson") %>% 
  st_transform(crs = 2193)

# this actually works now and returns the range of OutletNames expected
nearest_sa2_to_branch <- sa2 %>% 
  filter(!str_detect(SA22025__1, "Ocean")) %>% 
  st_join(points,
          join = st_nearest_feature
  ) 



