from flask import Blueprint, redirect, url_for, request
from . import db
from .models.User import User
from flask_login import login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash


auth = Blueprint("auth", __name__)


@auth.route("/sign-up", methods=["POST"])
def sign_up():
   
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")
    password_confirmation = request.form.get("passwordConfirmation")

    if password != password_confirmation:
        return {"msg": "Passwords don't match"}, 400 


    try:
        new_user = User(email=email, username=username, password_plaintext=password)
        db.session.add(new_user)
        db.session.commit()
        login_user(new_user, remember=True)
        return {"msg": "User created"}, 200
    except AssertionError as message:
        return {"msg": "Error: {}".format(message)}, 400
