########################################################
# Programmer Blueprint of endpoints
# Handles admin-level tasks for Bobbie the App Manager
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from backend.db_connection import db

# Create the programmer blueprint
programmer = Blueprint('programmer', __name__)


### GET all posts
@programmer.route('/contentModeration', methods=['GET'])
def get_moderated_posts():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM ContentModeration ')
    the_data = cursor.fetchall()

    response = make_response(jsonify(the_data))
    response.status_code = 200
    return response

### GET: Retrieve all app updates (excluding appUserID)
@programmer.route('/appUpdates', methods=['GET'])
def get_all_app_updates():
    cursor = db.get_db().cursor()
    cursor.execute('''
        SELECT updateID, dateImplemented, version
        FROM AppUpdate
    ''')
    
    the_data = cursor.fetchall()

    response = make_response(jsonify(the_data))
    response.status_code = 200
    return response



### POST a new content report
@programmer.route('/reportManagement', methods=['POST'])
def create_content_report():
    the_data = request.json

    reported_num = the_data['reportID']
    report_date = the_data['dateReported']
    action_info = the_data['action']
    status = the_data['status']
    report_by = the_data['reportUserID']
    

    query = '''
        INSERT INTO ReportManagement (reportID, dateReported, action, status, reportUserID)
        VALUES (%s, %s, %s, %s, %s)
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (report_id, report_date, action_info, status, reported_by))
    db.get_db().commit()

    response = make_response("Report created successfully.")
    response.status_code = 201
    return response

# POST: Add a new app update
@programmer.route('/appUpdates', methods=['POST'])
def create_app_update():
    data = request.json

    version = data['version']
    app_user_id = data['appUserID']

    query = '''
        INSERT INTO AppUpdate (version, appUserID)
        VALUES (%s, %s)
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (version, app_user_id))
    db.get_db().commit()

    response = make_response("App update created successfully.")
    response.status_code = 201
    return response


### PUT: Reinstate a post that was previously moderated
@programmer.route('/contentModeration/<int:moderation_id>', methods=['PUT'])
def reinstate_post(moderation_id):
    query = '''
        UPDATE ContentModeration
        SET action = "Approved"
        WHERE ModerationID = %s
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (moderation_id,))
    db.get_db().commit()

    response = make_response("Post reinstated.")
    response.status_code = 200
    return response


### DELETE: Remove a moderation record for a post/comment/review that violates guidelines
@programmer.route('/contentModeration/<int:moderation_id>', methods=['DELETE'])
def delete_inappropriate_content(moderation_id):
    query = 'DELETE FROM ContentModeration WHERE ModerationID = %s'

    cursor = db.get_db().cursor()
    cursor.execute(query, (moderation_id,))
    db.get_db().commit()

    response = make_response("Content moderation record deleted due to guideline violation.")
    response.status_code = 200
    return response
