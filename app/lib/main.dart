import 'package:app/views/screens/auth/login_screen.dart';
import 'package:app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user");
  runApp(GetMaterialApp(home: user == null ? LoginScreen() : const HomeScreen()));
}
