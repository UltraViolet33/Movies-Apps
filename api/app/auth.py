from flask import Blueprint, request
from . import db
from .models.User import User
from flask_login import login_user, logout_user, login_required, current_user


auth = Blueprint("auth", __name__)


@auth.route("/sign-up", methods=["POST"])
def sign_up():
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")
    password_confirmation = request.form.get("password_confirmation")

    if password != password_confirmation:
        return {"msg": "Error: Passwords don't match"}, 400

    try:
        new_user = User(email=email, username=username,
                        password_plaintext=password)
        db.session.add(new_user)
        db.session.commit()
        # login_user(new_user, remember=True)
        return {"msg": "User created"}, 200
    except AssertionError as message:
        return {"msg": "Error: {}".format(message)}, 400


@auth.route("/sign-in", methods=["POST"])
def sign_in():
    email = request.form.get("email")
    password = request.form.get("password")

    if not email or not password:
        return {"msg": "Error: Missing fields"}, 400

    user = User.query.filter_by(email=email).first()

    if user:
        if user.is_password_correct(password):
            print(user.username)
            login_user(user)
            print(current_user.username)
            return {"msg": "You are logged in", "user": {"username": current_user.username, "email": current_user.email,  "id": current_user.get_id()}}, 200

        else:
            return {"msg": "Error: Wrong credentials"}, 401
    else:
        return {"msg": "Error: Wrong credentials"}, 401


@auth.route("/logout")
@login_required
def logout():
    logout_user()
    return {"msg": "You are logged out"}, 200


@auth.route("/test-login-required", methods=["GET"])
@login_required
def test():
    return {"msg": current_user.username}, 200
