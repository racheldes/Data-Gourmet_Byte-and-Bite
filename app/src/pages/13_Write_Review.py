import logging
logger = logging.getLogger(__name__)
import streamlit as st
import pandas as pd
import requests
from sklearn import datasets
from sklearn.ensemble import RandomForestClassifier
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks


SideBarLinks()

st.write("""
# This is to write a review!
""")

#st.sidebar.header('Write a review so users can see healthy dietician approved health tips!')

#st.write("## Create a new review")
# post a review
with st.form("Create a New Review"):
    review_reviewUserID = st.number_input("Input your userID", step=1)
    review_comment = st.text_area("Write your review comment")
    #review_rating = st.number_input("Give a rating number of this comment", step =1)
    review_rating = st.slider("Rate this review", 0, 10, 5, step=1)
    st.write("Rating:", review_rating)

    submitted = st.form_submit_button("Submit")

    if submitted: 
        data = {}
        data['review_userID'] = review_reviewUserID
        data['review_comment'] = review_comment
        data['review_rating'] = review_rating
        st.write(data)

        requests.post('http://api:4000/n/review', json=data)



