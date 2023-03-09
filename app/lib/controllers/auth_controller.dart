import 'dart:convert';

import 'package:app/views/auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AuthController {
  static final _client = http.Client();

  static var _registerUrl = Uri.parse("http://192.168.1.10:5000/sign-up");

  static var _logingUrl = Uri.parse("http://192.168.1.10:5000/sign-in");

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

        http.Response response = await _client.post(_registerUrl, body: {
          "email": email,
          "username": username,
          "password": password,
          "password_confirmation": passwordConfirmation
        });

        if (response.statusCode == 200) {
          Get.snackbar("Account Created", "Welcome !");
          Get.to(LoginScreen());
        } else {
          Get.snackbar(
              "Error creating Account", jsonDecode(response.body)["msg"]);
        }
      } else {
        Get.snackbar("Error creating Account", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error creating Account", e.toString());
    }
  }

  static loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        http.Response response = await _client.post(_logingUrl, body: {
          "email": email,
          "password": password,
        });

        if (response.statusCode == 200) {
          print(response.headers);
          Get.snackbar("Loggin", "You Are log in");
        } else {
          Get.snackbar("Error loggin ", "Wrong credentials");
        }

        

      } else {
        Get.snackbar("Error loggin ", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Login", e.toString());
    }
  }
}
