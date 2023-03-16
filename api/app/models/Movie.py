from sqlalchemy.orm import validates
from .. import db


class Movie(db.Model):
    __tablename__ = 'movies'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(150), nullable=False)
    posterURL = db.Column(db.String(300), nullable=False)
    category = db.Column(db.Integer, db.ForeignKey("categories.id", ondelete="CASCADE"), nullable=False)

    def __init__(self, title, posterURL):
        self.title = title
        self.posterURL = posterURL
