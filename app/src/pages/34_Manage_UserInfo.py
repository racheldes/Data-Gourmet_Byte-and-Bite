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

if st.button('Create a user info report here!', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/35_Create_UserInfo.py')

if st.button('Update the meal plan count!', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/36_Update_MealPlanCount.py')
