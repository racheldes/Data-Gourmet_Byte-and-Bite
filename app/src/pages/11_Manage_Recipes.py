import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

#st.set_page_config(layout = 'wide')
SideBarLinks()

st.write("""
# Manage recipes with a variety of functions!
""")
st.write("""
## Create a recipe here!
""")
# post new recipe
with st.form("Create a New Recipe"):

    recipe_username = st.text_input("Enter you username")
    recipe_rating = st.number_input("Rate this recipe 1 out of 5")
    recipe_ingredients = st.text_area("List the ingredients")
    recipe_directions = st.text_area("Write out the directions")
    recipe_allergens = st.text_input("Write the allergen if the recipe contains any")
    recipe_recipeUserID = st.number_input("Enter your userID", step=1)

    submitted = st.form_submit_button("Submit")

    if submitted: 
        data = {}
        data['recipe_username'] = recipe_username
        data['recipe_rating'] = recipe_rating
        data['recipe_ingredients'] = recipe_ingredients
        data['recipe_directions'] = recipe_directions
        data['recipe_allergens'] = recipe_allergens
        data['recipe_recipeUserID'] = recipe_recipeUserID
        st.write(data)

        requests.post('http://api:4000/n/recipes', json=data)

# delete a recipe
st.write("""
## Delete a recipe here!
""")
with st.form("Delete an Unhealthy Recipe"):
    recipeID = st.number_input("Enter the ID number of the recipe you wish to delete", step=1)
    submitted = st.form_submit_button("Submit")

    if submitted: 
      if recipeID:
        response = requests.delete(f'http://api:4000/n/deleteRecipe/{recipeID}')

        if response.status_code == 200:
          st.success("Recipe deleted.")
        else:
          st.error('Recipe failed to delete')
        
      else:
        st.warning("Invalid Recipe ID for deletion")

st.write("""
## Edit the rating of a recipe to better reflect its true healthiness!
""")

# put/update the recipe's rating 
with st.form("Change a Recipe Rating"):
  recipeID = st.number_input("Enter the RecipeID to be updated", step=1)
  recipe_rating = st.number_input("Enter the new Rating")

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

