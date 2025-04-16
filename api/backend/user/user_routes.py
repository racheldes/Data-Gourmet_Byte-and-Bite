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
                FROM Reviews r
                ORDER BY r.rating DESC
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
                    FROM Recipes r
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# ------------------------------------------------------------
# Make a review on a recipe
@users.route('/post-recipe', methods=['POST'])
def add_recipe():
    the_data = request.json
    current_app.logger.info(the_data)

    # Extract variables from the request body
    recipe_id = the_data['recipeID']
    username = the_data['username']
    rating = the_data['rating']
    date = the_data['date']
    ingredients = the_data['ingredients']
    directions = the_data['directions']
    allergens = the_data['allergens']
    review_user_id = the_data['recipeUserID']

    # Construct the query
    query = f'''
        INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
        VALUES ({recipe_id}, '{username}', {rating}, '{date}', '{ingredients}', '{directions}', '{allergens}', {review_user_id})
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
    user_id = mealPlan_info['userID']
    allergens = mealPlan_info['allergens']

    query = '''
    UPDATE MealPlan 
    SET allergens = %s 
    WHERE userID = %s
    '''
    data = (allergens, user_id)
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