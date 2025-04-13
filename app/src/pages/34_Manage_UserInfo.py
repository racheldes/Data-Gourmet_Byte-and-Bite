import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

#st.set_page_config(layout = 'wide')
SideBarLinks()

st.write("""
# Manage user info reports with a variety of functions!
""")

if st.button('View all user info reports here!', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/32_View_UserInfo.py')
