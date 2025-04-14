## Change something in the meal plan, 
## see a success button
import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

#st.set_page_config(layout = 'wide')
SideBarLinks()

st.write("""
## Edit your Meal Plan to better reflect your goals
""")
# update the saved meal plan allergies (will further develop later)
with st.form("Change a Recipe Rating"):
  userID = st.number_input("Enter the userID of the meal plan to be updated", step=1)
  allergens = st.text_input("Update your list of allergies")

  submitted = st.form_submit_button("Submit")

  if userID and allergens:
    data = {}
    data['userID'] = userID
    data['allergens'] = allergens
    st.write(data)

    response = requests.put(f'http://api:4000/u/mealPlan', json = data)


    if response.status_code == 200:
      st.success("Allergies updated!")
      st.badge("Success", icon=":material/check:", color="green")
    else:
      st.error("Allergies failed to update")
      st.markdown(":orange-badge[⚠️ Needs review]")



# delete the meal plan
st.write("""
## Delete a Meal Plan here!
""")
with st.form("Delete A Meal Plan"):
    mealPlanID = st.number_input("Enter the ID number of the meal plan you wish to delete", step=1)
    submitted = st.form_submit_button("Submit")

    if submitted: 
      if mealPlanID:
        response = requests.delete(f'http://api:4000/u/mealPlan/{mealPlanID}')

        if response.status_code == 200:
          st.badge("Meal Plan deleted.", icon=":material/check:", color="green")
        else:
          st.error('Meal Plan failed to delete')
          st.markdown(":orange-badge[⚠️ Needs review]")
        
      else:
        st.warning("Invalid Recipe ID for deletion")
        st.markdown(":orange-badge[⚠️ Needs review]")

