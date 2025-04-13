import logging
import streamlit as st
from modules.nav import SideBarLinks
import requests
import datetime

# Set up logger
logger = logging.getLogger(__name__)

# Set up Streamlit sidebar
SideBarLinks()

st.write("""
## Create a User Info Report!
""")

# Form for user input
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
            "meal_plans": userInfo_mealPlanCount,  
            "lastLoggedOn": userInfo_lastLoggedOn,
            "commentCount": userInfo_commentCount,
            "userID": userInfo_userID
}


        # Format the URL with the actual user ID
        url = f'http://api:4000/d/userInfo/{userInfo_userID}'
        response = requests.post(url, json=user_data)

        # Check if userID is present in the response (after the API call)
        if response.status_code == 200:
            try:
                the_data = response.json() 
                if 'userID' not in the_data:
                    st.error("Error: userID is missing in the response data.")
                else:
                    st.success("User Info Report Created Successfully!")
            except Exception as e:
                st.error(f"Error parsing response: {str(e)}")
        else:
            st.error(f"Failed to submit user info. Status code: {response.status_code}")
