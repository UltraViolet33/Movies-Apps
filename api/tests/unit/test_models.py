from app.models import User

def test_new_user():
    user = User(email="test@gmail.com", username="test", password_plaintext="testpwd")
    assert user.email == "test@gmail.com"
    assert user.username == "test"
    assert user.is_password_correct("testpwd") == True