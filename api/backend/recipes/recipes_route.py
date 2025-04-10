########################################################
# Recipes blueprint of endpoints
# Handles routes related to recipes
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

#------------------------------------------------------------
# Create a new Blueprint object for recipes
recipes = Blueprint('recipes', __name__)

#------------------------------------------------------------
# Get all recipes
@recipes.route('/recipes', methods=['GET'])
def get_recipes():
    current_app.logger.info('GET /recipes route')
    
    cursor = db.get_db().cursor()
    cursor.execute('''
        SELECT recipeID, username, rating, date, ingredients, directions, allergens
        FROM Recipes
    ''')
    
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response


#------------------------------------------------------------
# Add a new recipe
@recipes.route('/recipes', methods=['POST'])
def add_recipe():
    current_app.logger.info('POST /recipes route')
    
    recipe_info = request.json
    username = recipe_info['username']
    rating = recipe_info['rating']
    date = recipe_info['date']
    ingredients = recipe_info['ingredients']
    directions = recipe_info['directions']
    allergens = recipe_info['allergens']
    recipesUserID = recipe_info['recipesUserID']

    query = '''
        INSERT INTO Recipes (username, rating, date, ingredients, directions, allergens, recipesUserID)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''
    data = (username, rating, date, ingredients, directions, allergens, recipesUserID)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Recipe added successfully!'

#------------------------------------------------------------
# PUT: Edit a recipe
@recipes.route('/recipes', methods=['PUT'])
def update_recipe():
    current_app.logger.info('PUT /recipes route')
    data = request.json
    recipe_id = data['id']
    username = data['username']
    rating = data['rating']
    date = data['date']
    ingredients = data['ingredients']
    directions = data['directions']
    allergens = data['allergens']

    query = '''
        UPDATE Recipes SET username = %s, rating = %s, date = %s, 
        ingredients = %s, directions = %s, allergens = %s 
        WHERE id = %s
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, (username, rating, date, ingredients, directions, allergens, recipe_id))
    db.get_db().commit()
    return 'Recipe updated successfully!'

#------------------------------------------------------------
# DELETE: Delete a recipe
@recipes.route('/recipes/<recipe_id>', methods=['DELETE'])
def delete_recipe(recipe_id):
    current_app.logger.info('DELETE /recipes/<recipe_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Recipes WHERE id = %s', (recipe_id,))
    db.get_db().commit()
    return 'Recipe deleted successfully!'


