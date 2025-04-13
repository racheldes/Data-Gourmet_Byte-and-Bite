import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import datetime
from io import StringIO

# st.set_page_config(layout='wide')
SideBarLinks()

st.write("""
## Create a User Info Report!
""")

with st.form("Insert the data for your report:"):
    userInfo_mealPlanCount = st.number_input(
        "Enter the amount of meal plans this user has created",
        min_value=0,
        step=1,
        format="%d"
    )
    userInfo_commentCount = st.number_input(
        "Enter the number of comments this user has made",
        min_value=0,
        step=1,
        format="%d"
    )
    userInfo_userID = st.number_input(
        "Enter the user's ID",
        min_value=1,
        max_value=40,
        step=1,
        format="%d"
    )

    submitted = st.form_submit_button("Submit")

    if submitted:
        userInfo_lastLoggedOn = datetime.datetime.now().isoformat()
        user_data = {
            "userInfo_mealPlanCount": userInfo_mealPlanCount,
            "userInfo_lastLoggedOn": userInfo_lastLoggedOn,
            "userInfo_commentCount": userInfo_commentCount,
            "userInfo_userID": userInfo_userID
        }

        # Format the URL with the actual user ID
        url = f'http://api:4000/d/userInfo/{userInfo_userID}'
        response = requests.post(url, json=user_data)

        if response.status_code == 200:
            st.success("User Info Report Created Successfully!")
        else:
            st.error(f"Failed to submit user info. Status code: {response.status_code}")
