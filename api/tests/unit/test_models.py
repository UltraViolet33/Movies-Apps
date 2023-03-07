import pytest
from app.models import User
from app import create_app

def test_new_user():
    app = create_app()
    with app.app_context():
            
        user = User(email="test@gmail.com", username="test", password_plaintext="Testpwdaz1")
        assert user.email == "test@gmail.com"
        assert user.username == "test"
        assert user.is_password_correct("Testpwdaz1") == True


def test_raise_exception_for_username():
    app = create_app()
    with app.app_context():
        with pytest.raises(AssertionError):
            user = User(email="test@gmail.com", username = "", password_plaintext="testpwdaz")
        with pytest.raises(AssertionError):
            user = User(email="test@gmail.com", username = "d", password_plaintext="testpwdaz")
        
        username = "t" * 51
        with pytest.raises(AssertionError):
            user = User(email="test@gmail.com", username = username, password_plaintext="testpwdaz")



def test_raise_exception_for_email():
    app = create_app()
    with app.app_context():
        with pytest.raises(AssertionError):
            user = User(email="", username = "test", password_plaintext="testpwdaz")
        with pytest.raises(AssertionError):
            user = User(email="testgmail.com", username = "test", password_plaintext="testpwdaz")
        
        email = "@t" * 51
        with pytest.raises(AssertionError):
            user = User(email=email, username = "test", password_plaintext="testpwdaz")
        
