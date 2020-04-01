import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

zip_code_south = ['90001', '90002', '90003', '90007', '90008', '90011', '90016',
                  '90018', '90037', '90043', '90044', '90047', '90059', '90061',
                  '90062']
zip_code_west = ['90266', '90267', '90291', '90292', '90293', '90401',
                 '90402', '90403', '90404', '90405']
places = ['smoke shops', 'liquor stores', 'marijuana dispenseries', 'schools']
# south counts
smoke_shop_south = [20, 7, 5, 19, 16, 2, 8, 4, 7, 5, 2, 4, 4, 8, 0]
liquor_stores_south = [18, 12, 13, 20, 19, 14, 13, 6, 11, 13, 16, 6, 10, 4, 1]
marijuana_south = [10, 4, 1, 6, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
schools_south = [19, 16, 19, 18, 17, 20, 12, 13, 1, 17, 19, 16, 0, 14, 13]
# west counts
smoke_shop_west = [20, 3, 20, 6, 3, 2, 1, 0, 3, 0]
liquor_stores_west = [18, 7, 20, 11, 8, 13, 4, 0, 2, 1]
marijuana_west = [2, 1, 0, 2, 0, 2, 0, 0, 0, 0]
schools_west = [1, 18, 18, 15, 13, 1, 0, 0, 0, 0]

N_south = len(smoke_shop_south)
N_west = len(smoke_shop_west)
ind_south = np.arange(N_south)
ind_west = np.arange(N_west)
fig, ((ax1, ax2, ax3, ax4), (ax5, ax6, ax7, ax8)) = plt.subplots(2, 4, figsize=(100, 50))
axes_south = [ax1, ax2, ax3, ax4]
axes_west = [ax5, ax6, ax7, ax8]
# south
fig.suptitle('West and South LA Counts', fontsize = 16)
ax1.bar(ind_south, smoke_shop_south, color='blue')
ax2.bar(ind_south, liquor_stores_south, color='orange')
ax3.bar(ind_south, marijuana_south, color='green')
ax4.bar(ind_south, schools_south, color='red')
plt.setp(axes_south, xticks=np.arange(len(zip_code_south)),  xticklabels=zip_code_south)
plt.setp(axes_west, xticks=np.arange(len(zip_code_west)), xticklabels=zip_code_west)

# west
ax5.bar(ind_west, smoke_shop_west, color='blue')
ax6.bar(ind_west, liquor_stores_west, color='orange')
ax7.bar(ind_west, marijuana_west, color='green')
ax8.bar(ind_west, schools_west, color='red')
for i in range(len(axes_south)):
    axes_south[i].set_ylim(0, 22)
    axes_south[i].xaxis.set_tick_params(rotation=45)
for i in range(len(axes_west)):
    axes_west[i].set_ylim(0, 22)
    axes_west[i].xaxis.set_tick_params(rotation=45)

plt.subplots_adjust( left=0.03, bottom=None, right=0.985, top=0.9, wspace=0.22, hspace=None)
# ax1.set_xticks()
for a, b in zip(ind_south, smoke_shop_south):
    ax1.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_south, liquor_stores_south):
    ax2.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_south, marijuana_south):
    ax3.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_south, schools_south):
    ax4.text(a, b+1, '%.0f' % b, ha='center', va='top')

for a, b in zip(ind_west, smoke_shop_west):
    ax5.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_west, liquor_stores_west):
    ax6.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_west, marijuana_west):
    ax7.text(a, b+1, '%.0f' % b, ha='center', va='top')
for a, b in zip(ind_west, schools_west):
    ax8.text(a, b+1, '%.0f' % b, ha='center', va='top')
ax1.set_ylabel('South Smoke Shops')
ax2.set_ylabel('South Liquor Stores')
ax3.set_ylabel('South Marijuana Dispenseries')
ax4.set_ylabel('South Schools')
ax5.set_ylabel('West Smoke Shops')
ax6.set_ylabel('West Liquor Stores')
ax7.set_ylabel('West Marijuana Dispenseries')
ax8.set_ylabel('West Schools')
plt.show()
