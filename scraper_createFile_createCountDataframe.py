
import json
import pandas as pd
import requests

api_key = 'AIzaSyA8B7mdgNoxAfhttaCP697pkCE7ACihK8k'
url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'


def dataframe_from_area_code(query):
    r = requests.get(url + 'query=' + query + '&key=' + api_key)
    x = r.json()
    y = x['results']
    df = pd.DataFrame(y)
    return df


global final_dataset
'''
zip_code =['90001', '90002', '90003', '90007', '90008', '90011', '90016',
                 '90018', '90037', '90043', '90044', '90047', '90059', '90061',
                 '90062', '90266', '90267', '90291', '90292', '90293', '90401',
                 '90402', '90403', '90404', '90405']
'''
zip_code = ['90266', '90267', '90291', '90292', '90293','90401','90402','90403','90404','90405']

places = ['smoke shops', 'liquor stores', 'marijuana dispenseries', 'schools']

final_dataset = pd.DataFrame()

for i in range(len(places)):
    for j in range(len(zip_code)):
        a = pd.DataFrame(dataframe_from_area_code
                         (places[i] + ' near ' + zip_code[j]))
        a['shops'] = places[i]
        a['zip'] = zip_code[j]
        final_dataset = pd.concat([final_dataset, a], axis=0, sort=True)


# clean up and create final dataframe
final_dataset.drop(['id', 'icon', 'place_id', 'opening_hours',
                    'plus_code', 'reference', 'photos', 'user_ratings_total'], axis=1, inplace=True)
final_dataset.drop_duplicates(subset='formatted_address', keep='first', inplace=True)
final_dataset.reset_index(drop=True, inplace=True)


count = pd.DataFrame(columns=places, index=zip_code)
count[count != 0] = 0
for i in range(len(final_dataset['zip'])):
    for j in range(len(zip_code)):

        if final_dataset['zip'][i] == zip_code[j]:
            b = zip_code[j]
            for z in range(len(places)):
                if final_dataset['shops'][i] == places[z]:
                    a = count.loc[b][places[z]]
                    count.loc[b][places[z]] = a+1
print(list(count['smoke shops']))
print(list(count['liquor stores']))
print(list(count['marijuana dispenseries']))
print(list(count['schools']))
# create csv file and save file to desktop
file_name = '/Users/ren/Desktop/research_data.csv'
final_dataset.to_csv(file_name, columns=['formatted_address', 'geometry',
                                         'name', 'zip', 'shops'])




'''
1. stacked bar
2. west side shops
3. check duplicates

90001
39


'''
