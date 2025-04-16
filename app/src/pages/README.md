# `pages` Folder

This folder contains all the pages that will be part of the application. Details on required numbers will be provided in the Phase 3 documentation.
These pages are meant to show you an example of some of the features of Streamlit and the way we will limit functionality access by role/persona. It is not meant to represent a complete application.

TODO: Describe the pages folder and include link to documentation. Don't forget about ordering of pages.
The pages are designed based on role based access to different parts of the application: User, Nutritionist, Data Analyst, App Manager

## Pages Descriptions

10_Nutritionist_Home.py    Landing Page of the nutritionist, allows access to the different pages of that user which have different features: ‘Manage Recipes’, ‘View the Ingredients of Highly Rated Recipes’, and ‘Write a review’
11_Manage_Recipes.py  Nutritionist accessed page where the current user can create a new nutritionist approved recipe, delete an unhealthy recipe, and change the rating of a recipe.
12_View_Ingredients.py  Nutritionist accessed page where the current user can view the ingredients of recipes with high ratings (over 3) to use for inspiration for more recipes. 
13_Write_Review.py Nutritionist accessed page where the current user can give a nutritionist approved health tip.


20_Admin_Home.py – This is the landing page for Bobbie, the App Manager. It provides access to key moderation and administrative tools through buttons that link to pages for managing bug reports, creating content moderation actions, viewing app update history, reinstating posts, and deleting posts.
22_ReportManagement.py – This page allows the App Manager to submit new content reports. Using a form, the manager can enter report details such as action taken, status, report date, and their user ID. Upon submission, the report is sent to the backend for database storage. It includes validation, feedback, and a preview of the submitted data.
23_AppUpdate.py – This page allows the App Manager to view a list of recent app updates retrieved from the database. It displays all previous updates in a table and provides a button to navigate to the update creation page, where a new app version can be added.
24_ContentMod.py – This page allows the App Manager to view all moderated posts. It displays moderation actions (like "Flagged", "Approved", or "Removed") in a searchable table, pulled from the content moderation database. The search bar helps filter posts by action or status for easier review.
25_Reinstate.py – This page allows the App Manager to reinstate a previously moderated post by entering its Post ID. Upon submission, the post is updated in the database to reflect that it has been restored. The app provides success or error feedback based on the server response.
26_DeletePost.py – This page allows the App Manager to delete inappropriate or flagged content by entering the Post ID. Upon clicking the delete button, the post is removed from the database. The page also includes a shortcut button to view current recipes for cross-referencing flagged content.
27_MakeUpdate.py – This page allows the App Manager or developer to submit a new app update by entering the version number and their user ID. The form sends the update information to the backend for storage, and the user receives success or error feedback depending on the server response.

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
