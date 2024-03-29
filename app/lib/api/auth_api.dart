import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/models/user.dart';
import 'package:app/views/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/views/screens/auth/login_screen.dart';

class AuthApi {
  static registerUser(String email, String username, String password,
      String passwordConfirmation) async {
    try {
      if (email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          passwordConfirmation.isNotEmpty) {
        if (passwordConfirmation != password) {
          Get.snackbar("Error creating Account", "Passwords don't match");
        } else {
          Map<String, String> data = {
            "email": email,
            "username": username,
            "password": password,
            "password_confirmation": passwordConfirmation
          };
          var url = Uri.parse('$apiEndpoint/sign-up');

          http.Response response = await http.post(url, body: data);

          if (response.statusCode == 200) {
            Get.snackbar("Account Created", "Welcome !");
            Get.to(LoginScreen());
          } else {
            Get.snackbar(
                "Error creating Account", jsonDecode(response.body)["msg"]);
          }
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
        var url = Uri.parse('$apiEndpoint/sign-in');

        http.Response response = await http.post(url, body: {
          "email": email,
          "password": password,
        });

        if (response.statusCode == 200) {
          Get.snackbar("Loggin", "You Are log in");
          Get.to(const HomeScreen());

          var data = jsonDecode(response.body);

          SharedPreferences prefs = await SharedPreferences.getInstance();

          User user = User(
              username: data["user"]["username"],
              email: data["user"]["email"],
              id: data["user"]["id"]);

          prefs.setString("user", jsonEncode(user.toJson()));

          var rawCookie = response.headers['set-cookie'];
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
    headers["cookie"] = cookie!;

    try {
      var url = Uri.parse('$apiEndpoint/logout');

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar("Log out", "You Are log out");
        Get.to(LoginScreen());
      }
    } catch (e) {
      Get.snackbar("Error Log out", e.toString());
    }

    await pref.remove("cookie");
    await pref.remove("user");
  }
}
