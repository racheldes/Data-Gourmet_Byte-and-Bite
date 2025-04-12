import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks


SideBarLinks()

st.write("## Access all the tags used across the platform:")

tags = requests.get('http://api:4000/d/tags').json()


try:
  st.dataframe(tags)
except:
  st.write("Could not connect to database to get tags!")
