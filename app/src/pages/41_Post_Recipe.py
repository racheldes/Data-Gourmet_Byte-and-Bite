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
# Want to spread your knowledge?
""")
st.write("""
## Post a recipe you love here!
""")
# post new recipe
with st.form("Post a Recipe!"):

    ## maybe should add a title for the recipe lowkey

    #recipe_id = st.text_input("Enter your recipeID")
    recipe_username = st.text_input("Enter your username")
    recipe_rating = st.slider("Rate this recipe", 0, 5, 5, step=1)
    recipe_ingredients = st.text_area("List the ingredients")
    recipe_directions = st.text_area("Write out the directions")
    recipe_allergens = st.text_input("Write the allergen if the recipe contains any")
    recipe_recipeUserID = st.number_input("Enter your userID", step=1)

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
        recipe_date = datetime.datetime.now().isoformat()
        data = {}
        data['recipe_username'] = recipe_username
        data['recipe_rating'] = recipe_rating
        data['recipe_date'] = recipe_date
        data['recipe_ingredients'] = recipe_ingredients
        data['recipe_directions'] = recipe_directions
        data['recipe_allergens'] = recipe_allergens
        data['recipe_recipeUserID'] = recipe_recipeUserID
        st.write(data)

        requests.post('http://api:4000/u/post-recipe', json=data)
