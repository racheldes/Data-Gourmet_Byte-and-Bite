########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

users = Blueprint('users', __name__)

@users.route('/review', methods=['GET'])
def get_all_reviews():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT r.reviewID, r.comment, r.rating
                    FROM Reviews r JOIN Users u ON r.reviewUserID = u.userID
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response