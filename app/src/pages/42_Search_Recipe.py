## Lists all of the recipes that have been posted
## via chart of some sort

import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import matplotlib.pyplot as plt
import numpy as np
import requests
import plotly.express as px
from modules.nav import SideBarLinks

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

response = requests.get("http://api:4000/u/recipe")

if response.status_code == 200:
    data = response.json()

    recipes_df = pd.DataFrame(data)

    st.header("All Recipes")
    search_bar = st.text_input("Search for ingredients or directions")
    if search_bar:
        recipes_df = recipes_df[
            recipes_df["ingredients"].str.contains(search_bar, case=False, na=False) |
            recipes_df["directions"].str.contains(search_bar, case=False, na=False)
        ]
    st.dataframe(recipes_df)
else:
    st.error("Failed to load recipes from the server.")

