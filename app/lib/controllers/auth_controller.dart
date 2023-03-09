import 'dart:convert';
import 'dart:io';

import 'package:app/Session.dart';
import 'package:app/views/auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static final _client = http.Client();

  static var _registerUrl = Uri.parse("http://192.168.1.10:5000/sign-up");

  static var _logingUrl = Uri.parse("http://192.168.1.10:5000/sign-in");

  static var _logoutUrl = Uri.parse("http://192.168.1.10:5000/logout");

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
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        http.Response response = await _client.post(_logingUrl, body: {
          "email": email,
          "password": password,
        });

        if (response.statusCode == 200) {
          Get.snackbar("Loggin", "You Are log in");
          pref.setString("email", email);

          var rawCookie = response.headers['set-cookie'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (rawCookie != null) {
            int index = rawCookie.indexOf(';');
            String cookie =
                (index == -1) ? rawCookie : rawCookie.substring(0, index);
            prefs.setString("cookie", cookie);

          }
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

  static logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};

    Get.to(LoginScreen());
    headers["cookie"] = cookie!;

    http.Response response = await _client.get(_logoutUrl, headers: headers);

    print(response.body);

    final logout = await pref.remove("cookie");

  }
}
