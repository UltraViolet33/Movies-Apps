import re
from datetime import datetime
from flask_login import UserMixin
from sqlalchemy.sql import func
from werkzeug.security import check_password_hash, generate_password_hash
from sqlalchemy.orm import validates
from .. import db


watch_list_table = db.Table("watch_list",
                            db.Column("user_id", db.Integer,
                                      db.ForeignKey("users.id")),
                            db.Column("movie_id", db.Integer,
                                      db.ForeignKey("movies.id"))
                            )


seen_list_table = db.Table("seen_list",
                           db.Column("user_id", db.Integer,
                                     db.ForeignKey("users.id")),
                           db.Column("movie_id", db.Integer,
                                     db.ForeignKey("movies.id"))
                           )


class User(db.Model, UserMixin):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(150), unique=True, nullable=False)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password_hashed = db.Column(db.String(150), nullable=False)
    registered_on = db.Column(db.DateTime(
        timezone=True), default=func.now(), nullable=False)

    watch_list = db.relationship(
        "Movie", secondary=watch_list_table, backref="users_watch_list")

    seen_list = db.relationship(
        "Movie", secondary=seen_list_table, backref="users_seen_list")

    def __init__(self, email, username, password_plaintext):
        self.email = email
        self.username = username
        self.set_password(password_plaintext)
        self.registered_on = datetime.now()

    def is_password_correct(self, password_plaintext):
        return check_password_hash(self.password_hashed, password_plaintext)

    def set_password(self, password_plaintext):
        if not password_plaintext:
            raise AssertionError("Password Missing")

        if len(password_plaintext) < 8 or len(password_plaintext) > 70:
            raise AssertionError(
                "Password length must be between 8 and 50 characters")

        password_pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"

        if not re.match(password_pattern, password_plaintext):
            raise AssertionError(
                'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character')

        self.password_hashed = generate_password_hash(password_plaintext)

    @validates("username")
    def validate_username(self, key, username):
        if not username:
            raise AssertionError("Missing username")

        if User.query.filter_by(username=username).first():
            raise AssertionError("Username already in use")

        if len(username) < 2 or len(username) > 50:
            raise AssertionError(
                "Username must be between 2 and 50 characters")

        return username

    @validates("email")
    def validate_email(self, key, email):
        if not email:
            raise AssertionError("Email missing")

        if User.query.filter_by(email=email).first():
            raise AssertionError("Email already in use")

        if "@" not in email:
            raise AssertionError("Wrong email format")

        if len(email) < 2 or len(email) > 50:
            raise AssertionError("email must be between 2 and 50 characters")

        if not re.match("[^@]+@[^@]+.[^@]+", email):
            raise AssertionError('Provided email is not an email address')

        return email
