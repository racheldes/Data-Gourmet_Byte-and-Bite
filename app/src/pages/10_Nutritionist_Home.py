import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Nutritionist, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Manage Recipes', 
             type='primary',
             use_container_width=True):

  st.switch_page('pages/11_Manage_Recipes.py')

if st.button('View the Ingredients of Highly Rated Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/12_View_Ingredients.py')

if st.button("Write a Review",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/13_Write_Review.py')