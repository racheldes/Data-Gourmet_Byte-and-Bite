########################################################
# Sample investorReport blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
investorReport = Blueprint('investorReport', __name__)


#------------------------------------------------------------
# Get all investor reports from the system
@investorReport.route('/investorReport', methods=['GET'])
def get_reports():
    current_app.logger.info('GET /investorReport route')
    
    cursor = db.get_db().cursor()
    cursor.execute('''
        SELECT reportID, dateGenerated, growthRate, investUserID 
        FROM InvestorReport
    ''')
    
    theData = cursor.fetchall()
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


#------------------------------------------------------------
# POST: Create a report based on the app’s standing at a specific time
@investorReport.route('/InvestorReport', methods=['POST'])
def create_investor_report():
    current_app.logger.info('POST /InvestorReport route')
    report_info = request.json
    report_date = report_info['report_date']
    summary = report_info['summary']

    query = 'INSERT INTO investor_reports (report_date, summary) VALUES (%s, %s)'
    data = (report_date, summary)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Investor report created successfully!', 201

#------------------------------------------------------------
# PUT: Update an existing investor report
@investorReport.route('/investorReport/<report_id>', methods=['PUT'])
def update_investor_report(report_id):
    current_app.logger.info(f'PUT /investorReport/{report_id} route')
    report_info = request.json
    report_date = report_info['report_date']
    summary = report_info['summary']

    query = '''UPDATE investor_reports 
               SET report_date = %s, summary = %s 
               WHERE reportID = %s'''
    data = (report_date, summary, report_id)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Investor report updated successfully!'


#------------------------------------------------------------
# DELETE: Delete an investor report
@investorReport.route('/investorReport/<report_id>', methods=['DELETE'])
def delete_investor_report(report_id):
    current_app.logger.info(f'DELETE /investorReport/{report_id} route')
    cursor = db.get_db().cursor()
    query = 'DELETE FROM investor_reports WHERE reportID = %s'
    cursor.execute(query, (report_id,))
    db.get_db().commit()
    return 'Investor report deleted successfully!'


