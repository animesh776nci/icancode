# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 15:05:10 2020

@author: anime
"""

import plotly.graph_objects as go
fig =go.Figure(go.Sunburst(
    labels=[ "World", "China", "T.Case_Ch", "T.Death_Ch", "Italy", "T.Case_It", "T.Death_It", "USA", "T.Case_US", "T.Death_US", "Spain", "T.Case_Sp", "T.Death_Sp", "Germany", "T.Case_Ge", "T.Death_Ge", "Iran",  "T.Case_Ir", "T.Death_Ir", "India", "T.Case_In", "T.Death_In"],
    parents=["",      "World",    "China",   "T.Case_Ch", "World",     "Italy",  "T.Case_It", "World",     "USA",  "T.Case_US", "World",     "Spain",  "T.Case_Sp",   "World",   "Germany",  "T.Case_Ge", "World",      "Iran",  "T.Case_Ir", "World",     "India",  "T.Case_In"],
    values=[  7794798739, 1439323776, 81171, 3277, 60461826, 63927, 6077, 331002651, 46145, 582, 46754778, 35136, 2311, 83783942, 29056, 123, 83992949, 23049, 1812, 1380004385, 511, 10],
    branchvalues="total",
))
fig.update_layout(margin = dict(t=0, l=0, r=0, b=0))

fig.show()