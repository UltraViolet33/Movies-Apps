import json
from app import create_app
from app.models.User import User 
from flask_login import current_user


def test_register_user_success(test_client, init_database):

    response = test_client.post("/sign-up", data=dict(username="testtest",
                                email="test@gmail.com", password="Test123!", password_confirmation="Test123!"))

    assert response.status_code == 200
    data = json.loads(response.data)
    assert data["msg"] == 'User created'


def test_register_user_fail_username_already_in_use(test_client, init_database):

    response = test_client.post("/sign-up", data=dict(username="testtest",
                                email="testaa@gmail.com", password="Test123!", password_confirmation="Test123!"))

    assert response.status_code == 400
    data = json.loads(response.data)
    assert data["msg"] == 'Error: Username already in use'


def test_register_user_fail_email_already_in_use(test_client, init_database):
    response = test_client.post("/sign-up", data=dict(username="test",
                                email="test@gmail.com", password="Test123!", password_confirmation="Test123!"))

    assert response.status_code == 400
    data = json.loads(response.data)
    assert data["msg"] == 'Error: Email already in use'


def test_register_user_fail_password_dont_match(test_client, init_database):
    response = test_client.post("/sign-up", data=dict(username="testa",
                                email="testaz@gmail.com", password="Test123", password_confirmation="Test123!"))

    assert response.status_code == 400
    data = json.loads(response.data)
    assert data["msg"] == "Error: Passwords don't match"



def test_login_failed_wrongs_email(test_client, init_database):

    response = test_client.post(
        "sign-in", data=dict(email="user@gmail.com", password="User123!"))
    data = json.loads(response.data)
    assert response.status_code == 401
    assert data["msg"] == "Error: Wrong credentials"


def test_login_failed_wrong_password(test_client, init_database):

    response = test_client.post(
        "sign-in", data=dict(email="user2@gmail.com", password="User"))
    data = json.loads(response.data)
    assert response.status_code == 401
    assert data["msg"] == "Error: Wrong credentials"
    assert current_user.is_authenticated == False


def test_login_failed_wrong_password_and_email(test_client, init_database):

    response = test_client.post(
        "sign-in", data=dict(email="user@gmail.com", password="User"))
    data = json.loads(response.data)
    assert response.status_code == 401
    assert data["msg"] == "Error: Wrong credentials"


def test_login_failed_missing_field(test_client, init_database):

    response = test_client.post(
        "sign-in", data=dict(email="bob@gmail.com"))
    
    data = json.loads(response.data)
    assert response.status_code == 400
    assert data["msg"] == "Error: Missing fields"

    
    response = test_client.post(
        "sign-in", data=dict(password="azeerrty"))
    
    data = json.loads(response.data)
    assert response.status_code == 400
    assert data["msg"] == "Error: Missing fields"


def test_route_login_required_failed(test_client):
    response = test_client.get("/test-login-required")

    data = json.loads(response.data)
    assert response.status_code == 401
    assert data["msg"] == "Not authorized"


def test_login_success(test_client, init_database):

    test_client.post("/sign-up", data=dict(username="testtest2",
                                           email="test2@gmail.com", password="Test123!", password_confirmation="Test123!"))

    response = test_client.post(
        "sign-in", data=dict(email="test2@gmail.com", password="Test123!"))
    data = json.loads(response.data)
    assert response.status_code == 200
    assert data["msg"] == "You are logged in"
    assert current_user.is_authenticated == True



def test_route_login_required(test_client):
    response = test_client.get("/test-login-required")

    data = json.loads(response.data)
    assert response.status_code == 200
    assert data["msg"] == current_user.username
    


def test_logout_user(test_client, init_database):
    response = test_client.get("/logout")

    data = json.loads(response.data)
    assert response.status_code == 200
    assert data["msg"] == "You are logged out"
    assert current_user.is_authenticated == False
    

