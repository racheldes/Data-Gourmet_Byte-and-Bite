import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('App Administration Page')

st.write('\n\n')
st.write('## Maintenance')

if st.button("Report Management", 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/22_ReportManagement.py') 

if st.button('App Update',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/23_AppUpdate.py')

if st.button('Content Moderation', 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/24_ContentMod.py')
    
## if st.button('Report Management' , 
##            type = 'primary',
##             use_container_width=True):
## results = requests.get('http://api:4000/c/prediction/10/25').json()
## st.dataframe(results)
