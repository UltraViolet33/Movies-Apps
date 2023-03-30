from .. import db


class Movie(db.Model):
    __tablename__ = 'movies'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(150), nullable=False)
    posterURL = db.Column(db.String(300), nullable=False)
    category = db.Column(db.Integer, db.ForeignKey(
        "categories.id", ondelete="CASCADE"), nullable=False)

    def __init__(self, title, posterURL):
        self.title = title
        self.posterURL = posterURL

    def to_dict(self, current_user):
        movie_dict = {"id": self.id, "title": self.title, "posterURL": self.posterURL, "category": self.category}
        movie_dict["is_in_watch_list"] = False

        for user in self.users_watch_list:
            if current_user.id == user.id:
                movie_dict["is_in_watch_list"] = True
            


        return movie_dict