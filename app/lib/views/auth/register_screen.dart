import 'package:app/constants.dart';
import 'package:app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tiktok Clone",
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.w900),
          ),
          Text(
            "Register",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _usernameController,
              labelText: "Username",
              icon: Icons.person,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _emailController,
              labelText: "Email",
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _passwordController,
              labelText: "Password",
              icon: Icons.lock,
              isObscure: true,
            ),
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
                onTap: () {},
                child: const Center(
                    child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ))),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account ? ",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
