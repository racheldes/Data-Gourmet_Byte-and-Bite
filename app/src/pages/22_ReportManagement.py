import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout='wide')

SideBarLinks()

# Page title
st.title("App Administration Page")

# Button for "Make a Report"
if st.button("Make a Report", 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/22_ReportManagement.py') 

# Button for "View Reports"
if st.button("View Reports", 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/22_ReportManagement.py')
