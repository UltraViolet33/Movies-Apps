import 'package:app/views/auth/login_screen.dart';
import 'package:app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user");
  print(user);
  runApp(GetMaterialApp(home: user == null ? LoginScreen() : HomeScreen()));
}
