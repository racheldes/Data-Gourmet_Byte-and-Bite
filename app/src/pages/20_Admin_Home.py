import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')
SideBarLinks()

st.title(f"Welcome back, Bobbie!")
st.write('')
st.write('')
st.write('### What would you like to do today, App Manager?')


# Four action buttons based on Bobbie’s user stories
if st.button('View and Manage Bug Reports',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/22_ReportManagement.py')

if st.button('Create Content Report',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/24_ContentMod.py')

if st.button('View App Updates',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/23_AppUpdate.py')

if st.button('Reinstate Post',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/25_Reinstate.py')

if st.button('Delete Post',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/26_DeletePost.py')

