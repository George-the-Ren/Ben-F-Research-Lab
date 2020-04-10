import folium
import re
import pandas as pd
import numpy as np
from numpy import *
import csv
import folium.plugins as plugins

data_move = []

csv_data = pd.read_csv('C:/Users/ren/Desktop/Fitzpatrick/CV/time_series_19-covid-Confirmed_archived_0325.csv')
csv_df = pd.DataFrame(csv_data)
ind = len(csv_df.index)
time_length = len(csv_df.loc[1]['1/22/20':])
countries=['US', 'Korea, South', 'Italy', 'China']
for i in range(ind):
    if csv_df.loc[i][1] not in countries:
        csv_df = csv_df.drop(i)
for i in range(ind):
    state = csv_df.loc[:, ['Province/State']]
    countries = csv_df.loc[:, ['Country/Region']]
    lat_long = csv_df.loc[:, 'Lat':'Long']
    time_series = csv_df.loc[:, '1/22/20':]
columns = list(time_series)

time_series_list = np.array([])
for i in columns:
    time_series_list = np.append(np.array(time_series_list), time_series[i])
'''
for i in range(len(time_series_list)):
    time_series_list[i] = time_series_list[i]*10000
'''
where_are_NaNs = isnan(time_series_list)
time_series_list[where_are_NaNs] = 0
file_path = "CV_heatmap.html"
Exposure_DATA_move = pd.DataFrame({'mid_y': list(lat_long['Lat']) *time_length,
                                   'mid_x': list(lat_long['Long']) *time_length,
                                   'adt': list(time_series_list),
                                   'hour': np.repeat(list(range(1, time_length+1)),len(lat_long))})
#
#Exposure_DATA_move['adt'] = Exposure_DATA_move['adt'] + np.random.rand(len(Exposure_DATA_move)) * 1000
data_move = []
for jj in Exposure_DATA_move['hour'].sort_values().unique():
    data_move.append(Exposure_DATA_move[Exposure_DATA_move['hour'] == jj][['mid_y', 'mid_x', 'adt']].groupby(['mid_y', 'mid_x', 'adt']).sum().reset_index().values.tolist())
print(data_move[0])
def generateBaseMap(default_location=[40.693943, -73.985880], default_zoom_start=12):
    base_map = folium.Map(location=default_location, control_scale=True, zoom_start=default_zoom_start)
    return base_map
from folium.plugins import HeatMapWithTime
m = generateBaseMap(default_zoom_start=11)
HeatMapWithTime(data_move, radius=20, gradient={0.45: 'blue', 0.4: 'lime', 0.4: 'orange', 1: 'red'}, use_local_extrema=True).add_to(m)
m.save(file_path)
