from flask import Blueprint, request
from . import db
from .models.Movie import Movie
from flask_login import login_required, current_user
from sqlalchemy.sql.expression import func


movies = Blueprint("movies", __name__)


@movies.route("/get-random-movies", methods=["GET"])
@login_required
def get_random_movies():

    movies = Movie.query.order_by(func.rand()).limit(10).all()

    random_movies = []

    for movie in movies:
        random_movies.append(movie.to_dict(current_user))
        

    return random_movies


@movies.route("/movies/search/<movie>", methods=["GET"])
@login_required
def search_movie(movie):

    search = "%{}%".format(movie)
    movies = Movie.query.filter(Movie.title.like(search)).all()
    results = []

    for movie in movies:
        results.append(movie.to_dict(current_user))

    return results


@movies.route("/movies/watch-list/add", methods=["POST"])
@login_required
def add_movie_to_watch_list():

    movie_id = request.form.get("movie_id")
    movie = Movie.query.filter_by(id=movie_id).first()

    if not movie:
        return {"msg": "Error: movie not found"}, 400

    user = current_user
    user.watch_list.append(movie)
    db.session.commit()

    movie = movie.to_dict(current_user)

    return movie


@movies.route("/movies/watch-list/remove", methods=["POST"])
@login_required
def remove_movie_from_watch_list():

    movie_id = request.form.get("movie_id")
    movie = Movie.query.filter_by(id=movie_id).first()

    if not movie:
        return {"msg": "Error: movie not found"}, 400

    user = current_user
    user.watch_list.remove(movie)
    db.session.commit()

    movie = movie.to_dict(current_user)

    return movie


@movies.route("/movies/watch-list", methods=["GET"])
@login_required
def get_watch_list_user():

    watch_list_user = []

    for movie in current_user.watch_list:
        watch_list_user.append(movie.to_dict(current_user))

    return watch_list_user


@movies.route("/movies/seen-list/add", methods=["POST"])
@login_required
def add_movie_to_seen_list():

    movie_id = request.form.get("movie_id")
    movie = Movie.query.filter_by(id=movie_id).first()

    if not movie:
        return {"msg": "Error: movie not found"}, 400

    user = current_user
    user.seen_list.append(movie)
    db.session.commit()

    seen_list = []

    for movie in user.seen_list:
        seen_list.append(movie.to_dict())

    return seen_list



@movies.route("/movies/seen-list", methods=["GET"])
@login_required
def get_seen_list_user():

    seen_list_user = []

    for movie in current_user.seen_list:
        seen_list_user.append(movie.to_dict(current_user))

    return seen_list_user



@movies.route("/movies/seen-list/remove", methods=["POST"])
@login_required
def remove_movie_from_seen_list():

    movie_id = request.form.get("movie_id")
    movie = Movie.query.filter_by(id=movie_id).first()

    if not movie:
        return {"msg": "Error: movie not found"}, 400

    user = current_user
    user.seen_list.remove(movie)
    db.session.commit()

    movie = movie.to_dict(current_user)

    return movie
