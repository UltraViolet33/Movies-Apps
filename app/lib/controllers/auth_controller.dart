import 'dart:convert';

import 'package:app/views/auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AuthController {
  static final _client = http.Client();

  static var _registerUrl = Uri.parse("http://192.168.1.10:5000/sign-up");

  static registerUser(String email, String username, String password,
      String passwordConfirmation) async {
    try {
      if (email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          passwordConfirmation.isNotEmpty) {
            
        if (passwordConfirmation != password) {
          Get.snackbar("Error creating Account", "Passwords don't match");
        }

        // http.Response response = await _client.post(_registerUrl, body: {
        //   "email": email,
        //   "username": username,
        //   "password": password,
        //   "password_confirmation": passwordConfirmation
        // });

        // print(response.body);

        // if (response.statusCode == 200) {
        //   Get.snackbar("Account Created", "Welcome !");
        //   Get.to(LoginScreen());
        // } else {
        //   Get.snackbar(
        //       "Error creating Account", jsonDecode(response.body)["msg"]);
        // }
      } else {
        Get.snackbar("Error creating Account", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error creating Account", e.toString());
    }
  }
}
