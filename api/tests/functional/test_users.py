import json
from app import create_app


def test_register_user_success():

    app = create_app()

    with app.test_client() as test_client:
        response = test_client.post("/sign-up", data=dict(username="testtest",
                                    email="testa@gmail.com", password="Testpwdaz1", password_confirmation="Testpwdaz1"))

        assert response.status_code == 200
        data = json.loads(response.data)

        assert data["msg"] == 'User created'


def test_register_user_fail_username_already_in_use():
    app = create_app()

    with app.test_client() as test_client:
        response = test_client.post("/sign-up", data=dict(username="testtest",
                                    email="testaa@gmail.com", password="Testpwdaz1", password_confirmation="Testpwdaz1"))

        assert response.status_code == 400
        data = json.loads(response.data)

        assert data["msg"] == 'Error: Username already in use'


def test_register_user_fail_email_already_in_use():
    app = create_app()

    with app.test_client() as test_client:
        response = test_client.post("/sign-up", data=dict(username="test",
                                    email="testa@gmail.com", password="Testpwdaz1", password_confirmation="Testpwdaz1"))

        assert response.status_code == 400
        data = json.loads(response.data)

        assert data["msg"] == 'Error: Email already in use'


def test_register_user_fail_password_dont_match():
    app = create_app()

    with app.test_client() as test_client:
        response = test_client.post("/sign-up", data=dict(username="testa",
                                    email="testaz@gmail.com", password="Testpwda1", password_confirmation="Testpwdaz1"))

        assert response.status_code == 400
        data = json.loads(response.data)

        assert data["msg"] == "Error: Passwords don't match"
