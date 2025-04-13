import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import datetime
from io import StringIO

#st.set_page_config(layout = 'wide')
SideBarLinks()

st.write("""
## Create a User Info Report!
""")

with st.form("Insert the data for your report:"):

    userInfo_mealPlanCount = st.number_input("Enter the amount of meal plans this user has created")
    userInfo_lastLoggedOn = st.datetime_input("Insert the last time the user logged on")
    userInfo_commentCount = st.number_input("Enter the number of comments this user has made")
    userInfo_userID = st.number_input(
    "Enter the user's ID",
    min_value=1,
    max_value=40,
    step=1
)


    submitted = st.form_submit_button("Submit")

    uploaded_file = st.file_uploader("Choose a file")
    if uploaded_file is not None:
         # To read file as bytes:
        bytes_data = uploaded_file.getvalue()
        st.write(bytes_data)

        # To convert to a string based IO:
        stringio = StringIO(uploaded_file.getvalue().decode("utf-8"))
        st.write(stringio)

        # To read file as string:
        string_data = stringio.read()
        st.write(string_data)

        # Can be used wherever a "file-like" object is accepted:
        dataframe = pd.read_csv(uploaded_file)
        st.write(dataframe)

    if submitted: 
        data = {}
        data['userInfo_mealPlanCount'] = userInfo_mealPlanCount
        data['userInfo_lastLoggedOn'] = userInfo_lastLoggedOn
        data['userInfo_commentCount'] = userInfo_commentCount
        data['userInfo_userID'] = userInfo_userID
        data['recipe_directions'] = recipe_directions
        st.write(data)

        requests.post('http://api:4000/d/post-user-info', json=data)
