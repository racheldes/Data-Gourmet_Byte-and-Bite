import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("## Access all the user info reports used")

userInfo = requests.get('http://api:4000/d/userInfo').json()

try:
    st.dataframe(userInfo)
except:
    st.write("Could not connect to database to get the User Info Reports!")
