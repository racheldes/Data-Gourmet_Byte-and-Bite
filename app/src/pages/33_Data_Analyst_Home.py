import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Data Analyst Home Page')
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View all the tags used on the platform', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/31_View_All_Tags.py')