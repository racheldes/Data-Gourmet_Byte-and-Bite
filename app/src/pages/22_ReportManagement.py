
import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
SideBarLinks()

response = requests.get("http://api:4000/p/contentModeration")

if response.status_code == 200:
    data = response.json()
    mod_df = pd.DataFrame(data)

    st.header("Moderated Posts")

    search_bar = st.text_input("Search by action or status")

    if search_bar:
        mod_df = mod_df[
            mod_df["action"].str.contains(search_bar, case=False, na=False)
        ]

    st.dataframe(mod_df)

else:
    st.error("Failed to load moderation data from the server.")