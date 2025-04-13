import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

#st.set_page_config(layout = 'wide')
SideBarLinks()

st.write("""
# Update a user's meal plan count!
""")

with st.form("Change a Meal Plan Count"):
  userInfoID = st.number_input("Enter the userInfoID to be updated", step=1)
  mealPlanCount = st.number_input(
    "Enter the Count", min_value=0, step=1, format="%d")

  submitted = st.form_submit_button("Submit")

  if userInfoID and mealPlanCount:
    data = {}
    data['userInfoID'] = userInfoID
    data['mealPlanCount'] = mealPlanCount

    response = requests.put(f'http://api:4000/d/userInfo/<userinfoID>/<mealPlanCount>')


    if response.status_code == 200:
      st.success("The count has been updated!")
    else:
      st.error("Meal plan count has failed to update! Sorry!")

