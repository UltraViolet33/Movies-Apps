from flask import Blueprint, redirect, url_for, request
from . import db
from .models.User import User
from flask_login import login_user, logout_user, login_required, current_user



movies = Blueprint("movies", __name__)
