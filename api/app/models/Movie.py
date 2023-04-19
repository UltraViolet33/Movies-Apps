from .. import db


movies_categories_table = db.Table("movies_categories",
                                   db.Column("category_id", db.Integer,
                                             db.ForeignKey("categories.id")),
                                   db.Column("movie_id", db.Integer,
                                             db.ForeignKey("movies.id"))
                                   )


class Movie(db.Model):
    __tablename__ = 'movies'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(150), nullable=False)
    posterURL = db.Column(db.String(300), nullable=False)

    categories = db.relationship(
        "Category", secondary=movies_categories_table, backref="movies")

    def __init__(self, title, posterURL):
        self.title = title
        self.posterURL = posterURL

    def to_dict(self, current_user):
        movie_dict = {"id": self.id, "title": self.title,
                      "posterURL": self.posterURL}
        movie_dict["is_in_watch_list"] = False

        movie_dict["is_in_seen_list"] = False

        for user in self.users_watch_list:
            if current_user.id == user.id:
                movie_dict["is_in_watch_list"] = True

        for user in self.users_seen_list:
            if current_user.id == user.id:
                movie_dict["is_in_seen_list"] = True

        return movie_dict
