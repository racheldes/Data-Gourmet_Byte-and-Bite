#######################################################
# Sample data_analyst blueprint of endpoints
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

data_analyst = Blueprint('data_analyst', __name__)

# Get all the tags that have been uploaded 
@data_analyst.route('/tags', methods = ['GET']) 
def get_all_tags():
    cursor = db.get_db().cursor()
    cursor.execute('''SELECT tagName
                      FROM Tags ''')

    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# Get all the of the user info reports 
@data_analyst.route('/userInfo', methods = ['GET']) 
def get_all_user_info():
    cursor = db.get_db().cursor()
    cursor.execute('''SELECT *
                      FROM UserInfo ''')

    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


# Create an overview of users data
@data_analyst.route('/userInfo/<userinfoID>', methods=['POST'])
def add_user_info():
    
    # In a POST request, there is a 
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    userID = the_data['userID']
    mealPlanCount = the_data['number_of_meal_plans']
    lastLoggedOn = the_data['last_logged_on']
    commentCount = the_data['number_of_comments']
    
    query = '''
        INSERT INTO UserInfo (userID,
                             mealPlanCount,
                            lastLoggedOn, 
                            commentCount)
        VALUES (%s, %s, %s, %s)
    '''

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (userID, mealPlanCount, lastLoggedOn, 
    commentCount))
    db.get_db().commit()
    
    response = make_response("User Overview Made!")
    response.status_code = 200
    return response


# delete a user demographic report
@data_analyst.route('/userDemographics/<demographicID>', methods = ['DELETE'])
def delete_demographic_report(demographicID):
    query = ''' 
        DELETE FROM UserDemographics
        WHERE demographicID = %s
        '''
    cursor = db.get_db().cursor()
    cursor.execute(query,  (demographicID,) )
    db.get_db().commit()

    response = make_response('Demographic report deleted.')
    response.status_code = 200
    return response

# update the UserInfo to reflect an accurate meal plan count
@data_analyst.route('/userInfo/<userinfoID>/<mealPlanCount>', methods = ['PUT'])
def update_meal_plan_count(userinfoID, mealPlanCount): 
    query = '''UPDATE UserInfo
	            SET mealPlanCount = %s
	            WHERE userinfoID = %s;'''

    cursor = db.get_db().cursor()
    cursor.execute(query, (mealPlanCount, userinfoID) )
    db.get_db().commit()

    return "Meal plan count updated."
