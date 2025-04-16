# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="💡")


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


def ManageUserInfoNav():
    st.sidebar.page_link(
        "pages/34_Manage_UserInfo.py", label="Manage the User Info Reports", icon="📋"
    )

def DemDeleterNav():
    st.sidebar.page_link(
        "pages/37_Delete_Dem.py", label="Delete a User Demographic Report", icon="👤"
    )


#### ------------------------ System programmer ------------------------
def ReportManagementNav():
    if st.sidebar.button("🐞 View Bug Reports", use_container_width=True):
        st.switch_page("pages/22_ReportManagement.py")


def ContentModerationNav():
    if st.sidebar.button("🛡️ Moderate Content", use_container_width=True):
        st.switch_page("pages/24_ContentMod.py")


def AppUpdateNav():
    if st.sidebar.button("🚀 View App Updates", use_container_width=True):
        st.switch_page("pages/23_AppUpdate.py")


def ReinstatePostNav():
    if st.sidebar.button("🔁 Reinstate Post", use_container_width=True):
        st.switch_page("pages/25_Reinstate.py")


def DeletePostNav():
    if st.sidebar.button("🗑️ Delete Post", use_container_width=True):
        st.switch_page("pages/26_DeletePost.py")


def ExploreRecipesNav():
    if st.sidebar.button("🍽️ Check Post", use_container_width=True):
        st.switch_page("pages/42_Search_Recipe.py")
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
            ReportManagementNav()
            ContentModerationNav()
            AppUpdateNav()
            ReinstatePostNav()
            DeletePostNav()
            ExploreRecipesNav()


        if st.session_state["role"] == "user":
            UserPageNav()
            UserSearchNav()
            UserMealPlanNav()

        if st.session_state["role"] == "data_analyst":
            ViewTagsNav()
            ManageUserInfoNav()
            DemDeleterNav()



    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")