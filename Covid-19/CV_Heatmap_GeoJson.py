import folium
import pandas as pd
import numpy as np
from folium.plugins import HeatMap
import branca.colormap as cm
a='3/24/20'
name=a
if len(a)>8:
    name=a[2:]
dict = pd.read_csv('selected_COVID.csv')
data = pd.Series(dict.loc[:,a])
state = pd.Series(dict.loc[:,'Province/State'])
dict1 = pd.concat([state, data], axis=1)
geo = 'us-states.json'
hmap = folium.Map(location=[38.5, -98], zoom_start=4.5)
file_path = "CV_heatmap.html"
dict1 = dict1.set_index('Province/State')[a]
from branca.colormap import linear
import branca.colormap as cm

linear = cm.LinearColormap(
    ['green', 'yellow', 'red'],
    vmin=0, vmax=2200
)
linear.caption = name
linear.add_to(hmap)
folium.GeoJson(
    geo,
    style_function=lambda feature: {
        'fillColor': linear(dict1[feature['id']]),
        'color': 'black',
        'weight': 2,
        'dashArray': '4, 4'
    }
).add_to(hmap)

'''
bins = [0, 50, 100, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
folium.Choropleth(
    geo_data=geo,
    name=name,
    data=dict,
    columns=['Province/State', a],
    key_on='feature.id',
    fill_color='BuPu',
    fill_opacity=0.5,
    line_opacity=0.4,
    legend_name=bins,
    bins=[float(x) for x in bins]
).add_to(hmap)
'''
hmap.save(file_path)  # 保存为html文件
