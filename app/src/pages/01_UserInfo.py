import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Accessing a REST API from Within Streamlit")
st.write("## Access all the user info reports used")

 user_info = requests.get('https://api:4000/d/userInfo').json()

try: 
  st.dataframe(user_info)
expect: 
  st.write("Could not connect to database to get the User Info Reports!")