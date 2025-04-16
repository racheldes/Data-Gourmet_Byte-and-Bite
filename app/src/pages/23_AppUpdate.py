import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("## View the latest app updates")

try:
    updates = requests.get('http://api:4000/p/appUpdates').json()
    st.dataframe(updates)
except:
    st.write("Could not connect to database to get app updates!")

if st.button('Make Update',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/27_MakeUpdate.py')