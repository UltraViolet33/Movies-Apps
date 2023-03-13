import 'package:app/constants.dart';
import 'package:app/views/auth/register_screen.dart';
import 'package:app/views/widgets/password_input.dart';
import 'package:app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Movies",
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "Home",
              style: TextStyle(
                  fontSize: 25,
                  color: buttonColor,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                  onTap: () {
                    AuthController.logoutUser();
                  },
                  child: const Center(
                      child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
