import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About Our App")

st.markdown (
    """
    We're the team behind Byte & Bite, a smart meal-planning and recipe-sharing app designed to make cooking easier, healthier, and more personalized. Whether you're a college student learning to cook, a nanny managing dietary restrictions, or someone pursuing specific health or fitness goals, our app helps you find meals that fit your lifestyle.

    By collecting and analyzing recipe data, Byte & Bite allows users to filter meals by cook time, dietary needs, and nutritional tags like #lowSugar or #highProtein. Users can share and rate recipes, build custom meal plans, and receive feedback from certified nutritionists who ensure the quality and healthiness of each recipe.

    With the combined efforts of users, nutritionists, data analysts, and app managers, Byte & Bite delivers a supportive, data-driven food community made to help everyone eat better—one byte at a time
    """
        )
