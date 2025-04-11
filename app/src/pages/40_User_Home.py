import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome back, {st.session_state['first_name']}!")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Post A Review', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/41_Post_Recipe.py')

if st.button('Search For A Recipe', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/42_Search_Recipe.py')

if st.button('Update Your Meal Plans', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/43_Update_MealPlan.py')