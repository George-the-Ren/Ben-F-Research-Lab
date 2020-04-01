import folium
import re
import pandas as pd
import numpy as np
import csv

with open('research_data.csv','r') as csvfile:
    reader = csv.DictReader(csvfile)
    column = [column['geometry'] for column in reader]
with open('research_data.csv','r') as csvfile:
    reader = csv.DictReader(csvfile)
    shops = [column['shops'] for column in reader]
with open('research_data.csv','r') as csvfile:
    reader = csv.DictReader(csvfile)
    address = [column['zip'] for column in reader]

zip_code =['90001', '90002', '90003', '90007', '90008', '90011', '90016',
                 '90018', '90037', '90043', '90044', '90047', '90059', '90061',
                 '90062', '90266', '90267', '90291', '90292', '90293', '90401',
                 '90402', '90403', '90404', '90405']


#lon = [33.973593, 33.949009, 33.964032, 34.02654, 34.006924, 34.009842, 34.029034, 34.027281, 34.00329, 33.985471, 33.953125, 33.953042, 33.92071, 33.920602, 34.003654, 33.889494, 33.8899, 33.994162, 33.977854, 33.945553, 34.01533, 34.035004, 34.030517, 34.02684, 34.011335]
#lat = [-118.247897, -118.245976, -118.273705, -118.282786, -118.345668, -118.258642, -118.357757, -118.317659, -118.28894, -118.337998, -118.291963, -118.309428, -118.245186, -118.273928, -118.309719, -118.400897, -118.4016, -118.46371
#, -118.445271, -118.441219, -118.493592, -118.502192, -118.490407, -118.471847, -118.468458]

lon_smoke=[]
lat_smoke=[]
lon_liquor=[]
lat_liquor=[]
lon_marijuana=[]
lat_marijuana=[]
lon_school=[]
lat_school=[]

for i in range(len(column)):
    add = re.findall(r"-?\d+\.*\d*", address[i])

    zip = add[-1]

    if zip in zip_code:
        if shops[i] == 'smoke shops':
            lon_smoke.append(re.findall(r"-?\d+\.*\d*",column[i])[0])
            lat_smoke.append(re.findall(r"-?\d+\.*\d*",column[i])[1])
        elif shops[i] == 'schools':
            lon_school.append(re.findall(r"-?\d+\.*\d*",column[i])[0])
            lat_school.append(re.findall(r"-?\d+\.*\d*",column[i])[1])
        elif shops[i] == 'marijuana dispenseries':
            lon_marijuana.append(re.findall(r"-?\d+\.*\d*",column[i])[0])
            lat_marijuana.append(re.findall(r"-?\d+\.*\d*",column[i])[1])
        elif shops[i] == 'liquor stores':
            lon_liquor.append(re.findall(r"-?\d+\.*\d*",column[i])[0])
            lat_liquor.append(re.findall(r"-?\d+\.*\d*",column[i])[1])

area = [3.502, 3.062, 3.551, 2.466, 3.673, 4.286, 3.627, 2.896, 2.838, 4,134, 5.137, 4,73, 3.313, 2.662, 1.934,
3.936, 0, 2.495, 2.039, 2.865, 0.849, 2.004, 1.428, 1.992, 2.647]
smoke_shop = [20, 7, 5, 19, 16, 2, 8, 4, 7, 5, 2, 4, 4, 8, 1, 20, 3, 20, 6, 3, 2, 1, 1, 3, 1]
liquor_stores = [18, 12, 13, 20, 19, 14, 13, 6, 11, 13, 16, 6, 10, 4, 1, 18, 7, 20, 11, 8, 13, 4, 1, 2, 1]
marijuana = [10, 4, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 1]
schools = [19, 16, 19, 18, 17, 20, 12, 13, 1, 17, 19, 16, 1, 14, 13, 1, 18, 18, 15, 13, 1, 1, 1, 1, 1]


smoke_shop_density = [80000]*len(lon_smoke)
liquor_shop_density = [80000]*len(lon_liquor)
schools_density = [80000]*len(lon_school)
marijuana_density = [80000]*len(lon_marijuana)



zip_code = pd.Series(int(x) for x in zip_code)
data_smoke = pd.DataFrame()
data_marijuana = pd.DataFrame()
data_school = pd.DataFrame()
data_liquor = pd.DataFrame()
data_smoke = pd.concat([pd.Series(lon_smoke), pd.Series(lat_smoke), pd.Series(smoke_shop_density)], keys=['long', 'lat', 'density'], axis=1)
data_marijuana = pd.concat([pd.Series(lon_marijuana), pd.Series(lat_marijuana), pd.Series(marijuana_density)], keys=['long', 'lat', 'density'], axis=1)
data_school = pd.concat([pd.Series(lon_school), pd.Series(lat_school), pd.Series(schools_density)], keys=['long', 'lat', 'density'], axis=1)
data_liquor = pd.concat([pd.Series(lon_liquor), pd.Series(lat_liquor), pd.Series(liquor_shop_density)], keys=['long', 'lat', 'density'], axis=1)

'''
la_map.choropleth(geo_data="la.geojson",
             data=dataframe, # my dataset
             columns=['zip', 'dense'], # zip code is here for matching the geojson zipcode, sales price is the column that changes the color of zipcode areas
              # this path contains zipcodes in str type, this zipcodes should match with our ZIP CODE column
             fill_color='BuPu', fill_opacity=0.7, line_opacity=0.2)

la_map.save('index.html')
'''
la_geo = 'la.geojson'
hmap = folium.Map(location=[data_smoke['long'].median(), data_smoke['lat'].median()])
file_path = "Los Angeles Four Locations Heapmap.html"




from folium.plugins import HeatMap
dat_smoke = data_smoke[['long', 'lat', 'density']].values.tolist()
dat_liquor = data_liquor[['long', 'lat', 'density']].values.tolist()
dat_school = data_school[['long', 'lat', 'density']].values.tolist()
dat_marijuana = data_marijuana[['long', 'lat', 'density']].values.tolist()
hmap.choropleth(geo_data = la_geo, fill_opacity = 0.5, line_opacity = 0.8, fill_color = 'white')
hmap.add_child(HeatMap(dat_smoke, radius=12, gradient={0.7: 'grey', 0.8: 'black'}))
hmap.add_child(HeatMap(dat_marijuana, radius=12, gradient={0.7: 'green', 0.8: 'lime'}))
hmap.add_child(HeatMap(dat_school, radius=12, gradient={0.7: 'blue'}))
hmap.add_child(HeatMap(dat_liquor, radius=12, gradient={0.7: 'red', 0.8: 'orange'}))
hmap.save(file_path)  # 保存为html文件
