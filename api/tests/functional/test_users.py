import json
from app import create_app


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


def test_login_success(test_client, init_database):
    test_client.post("/sign-up", data=dict(username="testtest2",
                                           email="test2@gmail.com", password="Test123!", password_confirmation="Test123!"))

    response = test_client.post(
        "sign-in", data=dict(email="test2@gmail.com", password="Test123!"))
    assert response.status_code == 200


def test_login_failed_wrongs_credentials(test_client, init_database):

    response = test_client.post(
        "sign-in", data=dict(email="bob@gmail.com", password="Test123!"))
    assert response.status_code == 401
