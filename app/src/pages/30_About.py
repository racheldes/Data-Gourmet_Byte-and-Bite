import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About Our App")

st.markdown (
    """
This folder contains all the pages that will be part of the application. Details on required numbers will be provided in the Phase 3 documentation.
These pages are meant to show you an example of some of the features of Streamlit and the way we will limit functionality access by role/persona. It is not meant to represent a complete application.
TODO: Describe the pages folder and include link to documentation. Don't forget about ordering of pages.
The pages are designed based on role based access to different parts of the application: User, Nutritionist, Data Analyst, App Manager
## Pages Descriptions
10_Nutritionist_Home.py    Landing Page of the nutritionist, allows access to the different pages of that user which have different features: ‘Manage Recipes’, ‘View the Ingredients of Highly Rated Recipes’, and ‘Write a review’
11_Manage_Recipes.py  Nutritionist accessed page where the current user can create a new nutritionist approved recipe, delete an unhealthy recipe, and change the rating of a recipe.
12_View_Ingredients.py  Nutritionist accessed page where the current user can view the ingredients of recipes with high ratings (over 3) to use for inspiration for more recipes. 
13_Write_Review.py Nutritionist accessed page where the current user can give a nutritionist approved health tip.
31_View_All_Tags.py The data analyst accesses this page to view all the tags that have been attached to a recipe.
32_View_UserInfo.py The data analyst will access this page to review all of the user info reports that have been created.
33_Data_Analyst_Home.py This is the landing page for the data analyst and allows them to decide if they would like to be directed to the page where they could review all the tags that have been used on the platform, manage all the user info reports, or delete a demographic report.
34_Manage_UserInfo.py This page allows the data analyst to decide if they would like to be redirected to a page where they could view, create, or update a user info report.  Specifically they would be able to view all previous reports, create a new report, or update the meal plan count of an existing info report.
35_Create_UserInfo.py This page allows the data analyst to create a new user info report.
36_Update_MealPlanCount.py A data analyst can change the amount of meal plans a user is reflected to have in a user info report.
37_Delete_Dem.py The data analyst can choose to delete a demographic report of a specific demographic ID.
40_User_Home.py Landing page of the user, allows access to the different pages of that user which have different features: ‘Post A Review’, ‘Search For A Recipe’, and ‘Update Your Meal Plans’
41_Post_Recipe.py User accessed page where the current user can post a recipe they’ve tried, rate it, and add a picture if they’d like to.
42_Search_Recipe.py User accessed page where the user can search through all the recipes posted via a search bar to filter for ones containing keywords. Also the user can search through all the reviews posted to find a new meal to try using a search bar to help filter through. All the reviews are ordered in descending rating order.
43_Update_MealPlan.py User accessed page where the user can edit an existing meal by changing the allergies in the list and delete a meal plan that they already have.
  """
        )
