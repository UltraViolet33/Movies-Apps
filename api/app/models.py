from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func
from datetime import datetime
from werkzeug.security import check_password_hash, generate_password_hash
from sqlalchemy.orm import validates 


class User(db.Model, UserMixin):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(150), unique=True, nullable=False)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password_hashed = db.Column(db.String(150), nullable=False)
    registered_on = db.Column(db.DateTime(timezone=True), default=func.now(), nullable=False)

    def __init__(self, email, username, password_plaintext):
        self.email = email
        self.username = username
        self.password_hashed = self._generate_password_hash(password_plaintext)
        self.registered_on = datetime.now()


    @staticmethod
    def _generate_password_hash(password_plaintext):
        return generate_password_hash(password_plaintext)

    def is_password_correct(self, password_plaintext):
        return check_password_hash(self.password_hashed, password_plaintext)

    @validates("username")
    def validate_username(self, key, username):
        if not username:
            raise AssertionError("Missing username")
        
        if User.query.filter_by(username=username).first():
            raise AssertionError("Username already in use")
        
        if len(username) < 2 or len(username) > 50:
            raise AssertionError("Username must be between 2 and 50 characters")

        return username


    @validates("email")
    def validate_email(self, key, email):
        if not email:
            raise AssertionError("Email missing")
            
        if "@" not in email:
            raise AssertionError("Wrong email format")

        if len(email) < 2 or len(email) > 50:
            raise AssertionError("email must be between 2 and 50 characters")

        return email

