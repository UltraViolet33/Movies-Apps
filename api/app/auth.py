from flask import Blueprint, redirect, url_for, request
from . import db
from .models import User
from flask_login import login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash


auth = Blueprint("auth", __name__)


@auth.route("/sign-up", methods=["POST"])
def sign_up():
   
    email = request.form.get("email")
    username = request.form.get("username")
    password1 = request.form.get("password1")
    password2 = request.form.get("password2")

    email_exists = User.query.filter_by(email=email).first()
    username_exists = User.query.filter_by(username=username).first()

    if email_exists:
        return {"msg": "Email is already in use"}
    elif username_exists:
        return {"msg": "Username is already in use"}
    elif password1 != password2:
        return {"msg": "Password don't match"}

    else:
        new_user = User(email=email, username=username, password=generate_password_hash(
            password1, method="sha256"))
        db.session.add(new_user)
        db.session.commit()
        login_user(new_user, remember=True)
        return {"msg": "User created"}, 200

