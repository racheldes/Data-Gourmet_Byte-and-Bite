
#######################################################
# Sample nutritionist blueprint of endpoints

########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

nutritionist = Blueprint('nutritionist', __name__)

# get all nutritionists from the system
@nutritionist.route('/nutritionist', methods=['GET'])
def get_all_nutritionist():
    cursor = db.get_db().cursor()
    cursor.execute( '''SELECT userID, username, age, gender, location, email, password
                         FROM Users
                        WHERE role = 'Nutritionist'
    ''')

    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response
    