########################################################
# Sample reviews blueprint of endpoints
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
reviews = Blueprint('reviews', __name__)

#------------------------------------------------------------
# GET: Retrieve all reviews
@reviews.route('/reviews', methods=['GET'])
def get_reviews():
    current_app.logger.info('GET /reviews route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM reviews')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response
#------------------------------------------------------------
# POST: Create a review and rating
@reviews.route('/reviews', methods=['POST'])
def create_review():
    current_app.logger.info('POST /reviews route')
    review_data = request.json
    user_id = review_data['user_id']
    recipe_id = review_data['recipe_id']
    rating = review_data['rating']
    review_text = review_data['review_text']

    query = '''INSERT INTO reviews (user_id, recipe_id, rating, review_text)
               VALUES (%s, %s, %s, %s)'''
    data = (user_id, recipe_id, rating, review_text)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Review created successfully!'

#------------------------------------------------------------
# PUT: Update an existing review
@reviews.route('/reviews', methods=['PUT'])
def update_review():
    current_app.logger.info('PUT /reviews route')
    data = request.json
    review_id = data['id']
    rating = data['rating']
    review_text = data['review_text']

    query = '''UPDATE reviews SET rating = %s, review_text = %s
               WHERE id = %s'''
    cursor = db.get_db().cursor()
    cursor.execute(query, (rating, review_text, review_id))
    db.get_db().commit()
    return 'Review updated successfully!'

#------------------------------------------------------------
# DELETE: Delete inappropriate reviews
@reviews.route('/reviews/<review_id>', methods=['DELETE'])
def delete_review(review_id):
    current_app.logger.info('DELETE /reviews/<review_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM reviews WHERE id = %s', (review_id,))
    db.get_db().commit()
    return 'Review deleted due to guideline violation.'