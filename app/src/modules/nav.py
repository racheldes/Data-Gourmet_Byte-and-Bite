# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")


#### ------------------------ Examples for Role of pol_strat_advisor ------------------------
def PolStratAdvHomeNav():
    st.sidebar.page_link(
        "pages/00_Pol_Strat_Home.py", label="Political Strategist Home", icon="👤"
    )


def WorldBankVizNav():
    st.sidebar.page_link(
        "pages/01_World_Bank_Viz.py", label="World Bank Visualization", icon="🏦"
    )


def MapDemoNav():
    st.sidebar.page_link("pages/02_Map_Demo.py", label="Map Demonstration", icon="🗺️")


## ------------------------ Examples for Role of nutritionist ------------------------
def viewIngredientsNav():
    st.sidebar.page_link("pages/12_View_Ingredients.py", label="View the ingredients", icon="🥑")


def ManageRecipesNav():
    st.sidebar.page_link(
        "pages/11_Manage_Recipes.py", label="Create, Delete, and edit recipes", icon="🥘"
    )


def WriteReviewNav():
    st.sidebar.page_link(
        "pages/13_Write_Review.py", label="Write a Review", icon="✏️"
    )


## ------------------------ Examples for Role of data_analyst ------------------------
def ViewTagsNav():
    st.sidebar.page_link("pages/31_View_All_Tags.py", label="View all tags", icon="🏷️")


def ViewUserInfo():
    st.sidebar.page_link(
        "pages/32_View_UserInfo.py", label="View User Info Reports", icon="📋"
    )


#### ------------------------ System Admin Role ------------------------
def AdminPageNav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")
    st.sidebar.page_link(
        "pages/21_ML_Model_Mgmt.py", label="ML Model Management", icon="🏢"
    )

## ------------------------ Pages for a User ------------------------

def UserPageNav():
    st.sidebar.page_link("pages/41_Post_Recipe.py", label="Post A Recipe", icon="🍝")


def UserSearchNav():
    st.sidebar.page_link(
        "pages/42_Search_Recipe.py", label="Search For Recipes", icon="🍽️"
    )


def UserMealPlanNav():
    st.sidebar.page_link(
        "pages/43_Update_MealPlan.py", label="Update Meal Plan", icon="📋"
    )

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/bytebitelogo.png", width=150)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state["role"] == "pol_strat_advisor":
            PolStratAdvHomeNav()
            WorldBankVizNav()
            MapDemoNav()

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state["role"] == "nutritionist":
            ManageRecipesNav()
            viewIngredientsNav()
            WriteReviewNav()

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "administrator":
            AdminPageNav()

        if st.session_state["role"] == "user":
            UserPageNav()
            UserSearchNav()
            UserMealPlanNav()


    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")