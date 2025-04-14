import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout='wide')

SideBarLinks()

st.title('App Update')

st.write('## Current App Version: 1.0.0')
st.write('This section allows users to see the available app updates.')

if st.button('Check for Updates', 
             type='primary', 
             use_container_width=True):
    
    st.write('Checking for new updates...')
    
    response = requests.get('https://example.com/check-for-updates')  
    if response.status_code == 200:
        st.success('App is up to date!')
    else:
        st.error('Failed to check for updates.')


if st.button('Update App Now', 
             type='primary', 
             use_container_width=True):
    st.write('Updating app...')
    st.success('App updated successfully!')

st.write('### Update Log')
st.text('Version 1.0.0 - Initial Release')
