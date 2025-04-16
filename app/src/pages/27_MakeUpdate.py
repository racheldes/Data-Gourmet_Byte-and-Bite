import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

SideBarLinks()

st.write("# Submit a New App Update")

with st.form("App Update Form"):
    version = st.text_input("Version (e.g., v1.2.3)", placeholder="v1.0.0")
    app_user_id = st.number_input("User ID of Developer", step=1)
    submitted = st.form_submit_button("Submit")

    if submitted:
        data = {
            "version": version,
            "appUserID": app_user_id
        }

        try:
            response = requests.post('http://api:4000/p/appUpdates', json=data)

            if response.status_code == 201:
                st.success("Update submitted successfully!")
            else:
                st.error("Failed to submit update.")
        except Exception as e:
            st.error("Could not connect to server.")
            logger.error(e)