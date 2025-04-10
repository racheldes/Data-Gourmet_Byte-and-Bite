########################################################
# Content Moderation blueprint of endpoints
# Handles routes related to content moderation actions
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

#------------------------------------------------------------
# Create a new Blueprint object for content moderation
moderation = Blueprint('moderation', __name__)

#------------------------------------------------------------
# GET: Return all posts that have not received moderation
@content_moderation.route('/contentModeration', methods=['GET'])
def get_unmoderated_posts():
    current_app.logger.info('GET /contentModeration route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM content WHERE moderated = 0')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response

# POST: Submit new content for moderation
@content_moderation.route('/contentModeration', methods=['POST'])
def submit_content_for_moderation():
    current_app.logger.info('POST /contentModeration route')
    content_data = request.json
    user_id = content_data['user_id']
    content_type = content_data['content_type']
    content = content_data['content']
    report_reason = content_data['report_reason']

    query = '''INSERT INTO content (user_id, content_type, content, report_reason, moderated)
               VALUES (%s, %s, %s, %s, 0)'''  # 0 for unmoderated
    data = (user_id, content_type, content, report_reason)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Content submitted for moderation!'

#------------------------------------------------------------
# PUT: Reinstate a post after review
@content_moderation.route('/contentModeration/<post_id>', methods=['PUT'])
def reinstate_post(post_id):
    current_app.logger.info('PUT /contentModeration/<post_id> route')
    cursor = db.get_db().cursor()
    query = 'UPDATE content SET moderated = 1, status = "reinstated" WHERE id = %s'
    cursor.execute(query, (post_id,))
    db.get_db().commit()
    return 'Post reinstated successfully!'

#------------------------------------------------------------
# DELETE: Remove post/comment/review that does not meet guidelines
@content_moderation.route('/contentModeration/<post_id>', methods=['DELETE'])
def delete_inappropriate_content(post_id):
    current_app.logger.info('DELETE /contentModeration/<post_id> route')
    cursor = db.get_db().cursor()
    query = 'DELETE FROM content WHERE id = %s'
    cursor.execute(query, (post_id,))
    db.get_db().commit()
    return 'Content deleted due to guideline violation.'