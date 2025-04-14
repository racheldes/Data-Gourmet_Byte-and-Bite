import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.write("""
## Delete a User Demographic Report here!
""")
with st.form("Delete an User Demographic Report"):
    demographicID = st.number_input("Enter the ID number of the report you wish to delete", step=1)
    submitted = st.form_submit_button("Submit")

    if submitted: 
      if demographicID:
        response = requests.delete(f'http://api:4000/d/userDemographics/{demographicID}'
        )

        if response.status_code == 200:
          st.success("Report deleted.")
        else:
          st.error('Report failed to delete')
        
      else:
        st.warning("Invalid Demographic ID for deletion")


