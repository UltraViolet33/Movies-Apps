from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import path
from flask_login import LoginManager
import os
import sqlalchemy as sa


db = SQLAlchemy()
login_manager = LoginManager()

# DB_NAME = "moviestest"
# DB_USERNAME = "root"
# DB_PASSWORD = ""
# DB_HOST = "localhost"
# DB_PORT = 3306


def create_app(config_filename=None):
    app = Flask(__name__)

    config_type = os.getenv('CONFIG_TYPE', default='config.DevelopmentConfig')
    print(config_type)
    app.config.from_object(config_type)

    initialize_extensions(app)
    register_blueprints(app)

    engine = sa.create_engine(app.config['SQLALCHEMY_DATABASE_URI'])
    inspector = sa.inspect(engine)
    if not inspector.has_table("users"):
        with app.app_context():
            db.drop_all()
            db.create_all()

    # app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'

    return app


def initialize_extensions(app):
    db.init_app(app)
    login_manager.init_app(app)

    from app.models.User import User

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.filter(User.id == int(user_id)).first()


def register_blueprints(app):

    from .auth import auth
    app.register_blueprint(auth, url_prefix="/")
