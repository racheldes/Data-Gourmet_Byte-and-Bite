
#######################################################
# Sample nutritionist blueprint of endpoints

########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

nutritionist = Blueprint('nutritionist', __name__)

# this route is just to practice, not for actual use
### get all nutritionists from the system
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
    

### view the ingredients of recipes with a high rating (>7)
@nutritionist.route('/highRecipeIngredients', methods=['GET'])
def get_high_rated_ingredients():
    cursor = db.get_db().cursor()
    cursor.execute( '''SELECT r.ingredients
                        FROM Recipes r
                        WHERE r.rating > 3;
    ''')

    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


### post a new review on a recipe to give health tips about it
@nutritionist.route('/review', methods=['POST'])
def add_new_review():
    
    # In a POST request, there is a 
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    reviewUserID = the_data['review_userID']
    comment = the_data['review_comment']
    rating = the_data['review_rating']
    
    query = '''
        INSERT INTO Reviews (reviewUserID,
                             comment,
                              rating)
        VALUES (%s, %s, %s)
    '''

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (reviewUserID, comment, rating))
    db.get_db().commit()
    
    response = make_response("Review Posted!")
    response.status_code = 200
    return response


### update the rating of a recipe to better reflect its healthiness
@nutritionist.route('/editRecipe/<int:recipeID>/<float:rating>', methods = ['PUT'])
def update_recipe_rating(recipeID, rating): 

    query = '''UPDATE Recipes
	            SET rating = %s
	            WHERE recipeID = %s;'''

    cursor = db.get_db().cursor()
    cursor.execute(query, (rating, recipeID) )
    db.get_db().commit()

    return "Rating updated."


### delete a recipe that is unhealthy
@nutritionist.route('/deleteRecipe/<recipeID>', methods = ['DELETE'])
def delete_recipe(recipeID):
    query = ''' 
        DELETE FROM Recipes
        WHERE recipeID = %s
        '''
    cursor = db.get_db().cursor()
    cursor.execute(query,  (recipeID,) )
    db.get_db().commit()

    response = make_response('Recipe deleted.')
    response.status_code = 200
    return response

### create a recipe (nutritionist approved)
@nutritionist.route('/recipes', methods = ['POST'])
def make_recipe():
    the_data = request.json
    current_app.logger.info(the_data)

    username = the_data['recipe_username']
    rating = the_data['recipe_rating']
    ingredients = the_data['recipe_ingredients']
    directions = the_data['recipe_directions']
    allergens = the_data['recipe_allergens']
    recipeUserID = the_data['recipe_recipeUserID']

    query = '''
        INSERT INTO Recipes (username, rating, ingredients,directions,allergens,recipeUserID)
            VALUES (%s, %s, %s, %s, %s, %s)
            '''
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query, (username, rating, ingredients, directions, allergens, recipeUserID))
    db.get_db().commit()

    response = make_response("Successfully added recipe!")
    response.status_code = 200
    return response
