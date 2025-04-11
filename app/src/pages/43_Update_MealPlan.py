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
## Edit the rating of a recipe to better reflect its true healthiness!
""")
# put/update the recipe's rating 
with st.form("Change a Recipe Rating"):
  recipeID = st.number_input("Enter the RecipeID to be updated", step=1)
  recipe_rating = st.slider("Enter the new Rating", 0, 10, 5, step=1)

  submitted = st.form_submit_button("Submit")

  if recipeID and recipe_rating:
    data = {}
    data['recipeID'] = recipeID
    data['recipe_rating'] = recipe_rating

    response = requests.put(f'http://api:4000/n/editRecipe/{recipeID}/{recipe_rating}')


    if response.status_code == 200:
      st.success("Yay recipe updated!")
    else:
      st.error("Recipe failed to update")