import 'dart:convert';

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
        http.Response response = await _client.post(_registerUrl, body: {
          "email": email,
          "username": username,
          "password": password,
          "passwordConfirmation": passwordConfirmation
        });
        print(response.body);

        if (response.statusCode == 200) {
        } else {
          print(jsonDecode(response.body));
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
}
