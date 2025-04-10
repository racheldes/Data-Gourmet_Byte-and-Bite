import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

if role == 'Nutritionist':
st.title(f"Welcome Nutritionist, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Manage Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/11_Manage_Recipes.py')

if st.button('View Ingredients from Highly Rated Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/12_View_Ingredients.py')

if st.button("Write a Review",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/13_Write_Review.py')

elif role == 'USAID Worker':
    st.title(f"Welcome USAID Worker, {st.session_state['first_name']}.")
    st.write('')
    st.write('')
    st.write('### What would you like to do today?')

    if st.button('Predict Value Based on Regression Model',
                 type='primary',
                 use_container_width=True):
        st.switch_page('pages/11_Prediction_page.py')

    if st.button('Show the Simple API Demo',
                 type='primary',
                 use_container_width=True):
        st.switch_page('pages/12_API_Test.py')

    if st.button("View Classification Demo",
                 type='primary',
                 use_container_width=True):
        st.switch_page('pages/13_Classification.py')
else:
    st.title(f"Welcome, {st.session_state['first_name']}.")
    st.warning("Unknown role. Please contact an administrator.")