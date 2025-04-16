import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("## Delete inappropriate content")

post_id = st.number_input("Enter Post ID to Delete", step=1)

if st.button("Delete Content"):
    try:
        response = requests.delete(f'http://api:4000/p/contentModeration/{post_id}')
        if response.status_code == 200:
            st.success("Content deleted successfully.")
        else:
            st.error("Failed to delete content.")
    except:
        st.write("Could not connect to database to delete content.")
if st.button('Current Recipes',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/42_Search_Recipe.py')