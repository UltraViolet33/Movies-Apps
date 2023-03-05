import 'package:http/http.dart' as http;

class AuthController {
  static final _client = http.Client();

  static var _registerUrl = Uri.parse("http://127.0.0.1:5000/sign-up");

  static registerUser(String email, String username, String password,
      String passwordConfirmation) async {
    // http.Response response = await _client.post(_registerUrl, body: {
    //   "email": email,
    //   "username": username,
    //   "password": password,
    //   "passwordConfirmation": passwordConfirmation
    // });

    print(email);
  }
}
