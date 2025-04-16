import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("## Reinstate a post after review")

post_id = st.number_input("Enter Post ID to Reinstate", step=1)

if st.button("Reinstate Post"):
    try:
        response = requests.put(f'http://api:4000/p/contentModeration/{post_id}')
        if response.status_code == 200:
            st.success("Post reinstated successfully.")
        else:
            st.error("Could not reinstate the post.")
    except:
        st.write("Could not connect to database to reinstate the post.")