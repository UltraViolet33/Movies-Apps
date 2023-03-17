from flask import Blueprint
from . import db
from .models.Movie import Movie
from flask_login import login_required

from sqlalchemy.sql.expression import func


movies = Blueprint("movies", __name__)


@movies.route("/get-random-movies", methods=["GET"])
@login_required
def get_random_movies():

    movies = Movie.query.order_by(func.rand()).limit(10).all()

    random_movies = []

    for movie in movies:
        random_movies.append(movie.to_dict())

    return random_movies
