import logging
import streamlit as st
from modules.nav import SideBarLinks
import requests
import datetime

# Set up logger
logger = logging.getLogger(__name__)

SideBarLinks()

st.write("""## Create a User Info Report!""")

with st.form("Insert the data for your report:"):
    mealPlanCount = st.number_input(
        "Enter the amount of meal plans this user has created",
        min_value=0, step=1, format="%d"
    )
    commentCount = st.number_input(
        "Enter the number of comments this user has made",
        min_value=0, step=1, format="%d"
    )
    userID = st.number_input(
        "Enter the user's ID",
        min_value=1, max_value=40, step=1, format="%d"
    )

    submitted = st.form_submit_button("Submit")

if submitted:
    lastLoggedOn = datetime.datetime.now().isoformat()

    user_data = {
        "number_of_meal_plans": mealPlanCount,
        "last_logged_on": lastLoggedOn,
        "number_of_comments": commentCount,
        "userID": userID
    }

    st.write(user_data) 

    response = requests.post(f'http://api:4000/d/userInfo/{userID}', json = user_data)

 