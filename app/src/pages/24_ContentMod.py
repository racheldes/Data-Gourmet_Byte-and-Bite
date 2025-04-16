import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import datetime

SideBarLinks()

st.write("""
# New Reports?
""")
st.write("""
## Report content here
""")

with st.form("Submit a Content Report"):
    report_user_id = st.number_input("Your User ID", step=1)

    report_action = st.text_input("Action (e.g., 'Reviewed and dismissed', 'User banned', 'User issued a warning')")
    report_status = st.text_input("Status (e.g., 'pending', 'active', 'cancelled', 'completed')")

    report_date = st.date_input("Date of Report", value=datetime.date.today())

    submitted = st.form_submit_button("Submit Report")

    if submitted:
        data = {
            "dateReported": str(report_date),
            "action": report_action,
            "status": report_status,
            "reportUserID": report_user_id
        }

        st.write(data)  # Optional preview

        try:
            response = requests.post('http://api:4000/p/reportManagement', json=data)
            if response.status_code == 201:
                st.success("Report submitted successfully!")
            else:
                st.error("Failed to submit report.")
        except:
            st.error("Could not connect to the server.")