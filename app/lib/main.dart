import 'package:app/views/auth/login_screen.dart';
import 'package:app/views/auth/register_screen.dart';
import 'package:app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("cookie");
  print(email);

  runApp(
      GetMaterialApp(home: email == null ? LoginScreen() : HomeScreen()));
}

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "test",
//       theme: ThemeData.dark(),
//       home: LoginScreen(),
//     );
//   }
// }
