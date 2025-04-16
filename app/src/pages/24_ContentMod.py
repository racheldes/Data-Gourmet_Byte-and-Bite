import logging
import streamlit as st
import requests
import datetime
from modules.nav import SideBarLinks

# Set up logger
logger = logging.getLogger(__name__)

# Load sidebar navigation
SideBarLinks()

# Page headers
st.write("# New Reports?")
st.write("## Report content here")

# Form for submitting a content report
with st.form("Submit a Content Report"):
    report_user_id = st.number_input("The User ID", step=1)
    report_action = st.text_input("Action (e.g., 'Reviewed and dismissed', 'User banned', 'User issued a warning')")
    report_status = st.text_input("Status (e.g., 'pending', 'active', 'cancelled', 'completed')")
    report_date = st.date_input("Date of Report (optional)", value=datetime.date.today())

    submitted = st.form_submit_button("Submit Report")

    if submitted:
        data = {
            "dateReported": str(report_date),
            "action": report_action,
            "status": report_status,
            "reportUserID": report_user_id
        }

        st.write(data) 

        try:
            response = requests.post('http://api:4000/p/reportManagement', json=data)
            if response.status_code == 201:
                st.success("Report submitted successfully!")
            else:
                st.error("Failed to submit report.")
        except Exception as e:
            logger.exception("Error submitting report")
            st.error("Could not connect to the server.")
