import re
from datetime import datetime
from flask_login import UserMixin
from sqlalchemy.sql import func
from werkzeug.security import check_password_hash, generate_password_hash
from sqlalchemy.orm import validates
from .. import db


class Movie(db.Model):
    __tablename__ = 'movies'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    title = db.Column(db.String(150), nullable=False)
    posterURL = db.Column(db.String(300), nullable=False)

    def __init__(self, title, posterURL):
        self.title = title
        self.posterURL = posterURL
