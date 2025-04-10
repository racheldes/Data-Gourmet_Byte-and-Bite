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

# ------------------------------------------------------------
# Get all the reviews for each user

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

# ------------------------------------------------------------
# Get all the recipes each user has posted

@users.route('/recipe', methods=['GET'])
def get_recipe():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT r.recipeID, r.rating, r.ingredients, r.directions, r.allergens
                    FROM Recipes r JOIN Users u ON r.recipeUserID = u.userID
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# ------------------------------------------------------------
# Make a review on a recipe
@users.route('/add-review', methods=['POST'])
def add_review():
    the_data = request.json
    current_app.logger.info(the_data)

    # Extract variables from the request body
    review_user_id = the_data['reviewUserID']
    comment = the_data['comment']
    rating = the_data['rating']

    # Construct the query
    query = f'''
        INSERT INTO Recipes (recipeID, rating, ingredients)
        VALUES ({review_user_id}, {comment}, '{rating}')
    '''

    current_app.logger.info(query)

    # Execute and commit the query
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    # Send success response
    response = make_response("Successfully added recipe")
    response.status_code = 200
    return response


# ------------------------------------------------------------
# Update the list of mealPlans
@users.route('/mealPlan', methods=['PUT'])
def update_mealPlan():
    current_app.logger.info('PUT /mealPLan route')
    mealPlan_info = request.json
    mealPlan_id = mealPlan_info['mealPlanId']
    allergens = mealPlan_info['allergens']

    query = '''
    UPDATE MealPlan 
    SET allergens = %s 
    WHERE mealPlanId = %s
    '''
    data = (allergens, mealPlan_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'meal plan updated!'

# ------------------------------------------------------------
# Delete a mealPlan by a specific id
@users.route('/mealPlan/<mealPlanId>', methods=['DELETE'])
def delete_mealPlan(mealPlanId):
    current_app.logger.info(f'DELETE /mealPlan/{mealPlanId} route')

    query = '''DELETE FROM MealPlan
            WHERE mealPlanId = %s'''
    data = (mealPlanId,)

    cursor = db.get_db().cursor()
    cursor.execute(query,data)
    db.get_db().commit()

    return 'meal plan deleted!'