# -*- coding: utf-8 -*-
"""
Created on Fri Nov 15 09:27:11 2019

@author: anime
"""

from io import BytesIO
from zipfile import ZipFile
from urllib.request import urlopen
import pandas as pd
import numpy as np
import plotly.graph_objects as go
import plotly.figure_factory as ff

response = urlopen("https://cli.fusio.net/cli/climate_data/webdata/dly1375.zip")
zip_file = ZipFile(BytesIO(response.read()))
data_file = zip_file.open('dly1375.csv')
#print(data_file.readline)

data_cols = ['date','maxtp','mintp','rain','cbl','wdsp','hg']
df = pd.read_csv(data_file, skiprows = 24, usecols = data_cols)
df.replace(' ', np.nan, inplace=True)
#df.replace(' ', np.nan, inplace=True)

df.rename(columns={'maxtp': 'max_temperature',
                   'mintp': 'min_temperature',
                   'cbl': 'barometric_pressure',
                   'wdsp': 'wind_speed',
                   'hg': 'highest_wind_gust'}, inplace=True)
df.drop(df.index[0],inplace = True)

df['date'] = pd.to_datetime(df['date'],format='%d-%b-%Y')
df['min_temperature'] = pd.to_numeric(df['min_temperature'])
df['max_temperature'] = pd.to_numeric(df['max_temperature'])
df['rain'] = pd.to_numeric(df['rain'])
df['barometric_pressure'] = pd.to_numeric(df['barometric_pressure'])
df['wind_speed'] = pd.to_numeric(df['wind_speed']).apply(lambda x: x * 1.852)
df['highest_wind_gust'] = pd.to_numeric(df['highest_wind_gust']).apply(lambda x: x * 1.852)

df.set_index('date',inplace = True)

print(df)












































