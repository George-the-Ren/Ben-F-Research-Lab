import numpy as np
import matplotlib.pyplot as plt


zip_code = ['90001', '90002', '90003', '90007', '90008', '90011', '90016',
            '90018', '90037', '90043', '90044', '90047', '90059', '90061',
            '90062', '90266', '90267', '90291', '90292', '90293', '90401',
            '90402', '90403', '90404', '90405']
zip_code = ['90266', '90267', '90291', '90292', '90293','90401','90402','90403','90404','90405']
places = ['smoke shops', 'liquor stores', 'marijuana dispenseries', 'schools']
#SouthEast
'''
population = (57110, 51223, 66266, 40920, 32327, 103892, 47596, 49310, 62276, 44789, 89779,
48606, 40952, 26872, 32821, 35135, 0, 28341, 21576, 12132, 6722, 12250, 24525, 21360, 27186)
smoke_shop = (20, 7, 5, 19, 16, 2, 8, 3, 7, 5, 2, 4, 4, 8, 0, 20, 4, 20, 3, 3, 4, 1, 0, 2, 0)
liquor_stores = (18, 12, 13, 20, 19, 14, 13, 6, 12, 12, 15, 6, 9, 5, 1, 17, 7, 20, 12, 8, 12, 4, 0, 2, 1)
marijuana = ( 1, 0, 0, 11, 1, 0, 0, 2, 0 ,4, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
schools = (19, 15, 19, 20, 17, 20, 12, 12, 16, 16, 19, 16, 19, 10, 13, 1, 18, 18, 16, 12, 1, 0, 0, 0, 0)
N = len(smoke_shop)
'''

population = (57110, 51223, 66266, 40920, 32327, 103892, 47596, 49310, 62276, 44789, 89779,
48606, 40952, 26872, 32821, 35135, 0, 28341, 21576, 12132, 6722, 12250, 24525, 21360, 27186)
population = (35135, 0, 28341, 21576, 12132, 6722, 12250, 24525, 21360, 27186)
smoke_shop = (20, 4, 20, 4, 7, 4, 1, 0, 2, 0)
liquor_stores = (17, 7, 20, 10, 9, 12, 4, 0, 2, 1)
marijuana = ( 2, 1, 0, 2, 0, 2, 0, 0, 0, 0)
schools = (1, 17, 17, 16, 12, 1, 0, 0, 0, 0)
N = len(smoke_shop)
ind = np.arange(N)
'''
plt.figure(figsize=(30, 5))
plt.title('West LA Population')
p1 = plt.bar(ind, population, 0.35)
plt.xticks(ind, ('90001', '90002', '90003', '90007', '90008', '90011', '90016',
                 '90018', '90037', '90043', '90044', '90047', '90059', '90061',
                 '90062', '90266', '90267', '90291', '90292', '90293', '90401',
                 '90402', '90403', '90404', '90405'))
plt.xticks(rotation=45)   # 设置横坐标显示的角度，角度是逆时针，自己看
plt.show()
'''
width = 0.35       # the width of the bars: can also be len(x) sequence
p1 = plt.bar(ind, smoke_shop, width)
p2 = plt.bar(ind, liquor_stores, width,
             bottom=smoke_shop)
a = tuple(np.array(liquor_stores) + np.array(smoke_shop))
p3 = plt.bar(ind, marijuana, width,
             bottom=a)
b = tuple(np.array(a)+np.array(marijuana))
p4 = plt.bar(ind, schools, width,
             bottom=b)

plt.ylabel('Zip Codes')
plt.title('Shops by zip codes')
plt.xticks(ind, ('90266', '90267', '90291', '90292', '90293','90401','90402','90403','90404','90405'))
plt.xticks(rotation=45)   # 设置横坐标显示的角度，角度是逆时针，自己看

plt.legend((p1[0], p2[0], p3[0], p4[0]), ('smoke shops', 'liquor stores', 'marijuana dispenseries', 'schools'))

plt.show()
