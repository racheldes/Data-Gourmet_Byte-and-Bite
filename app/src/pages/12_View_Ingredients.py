import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()
# select ingredients
st.write("# View Ingredients from Highly Rated Ingredients")

ingredients = requests.get('http://api:4000/n/highRecipeIngredients').json()

try:
  st.dataframe(ingredients)
  
except:
  st.write("Could not connect to database to retrieve ingredients :(")

