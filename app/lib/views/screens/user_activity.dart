import 'package:flutter/material.dart';

class UserActivity extends StatelessWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your activty")),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () {},
                child: const Center(
                  child: Text(
                    "See my watch list",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
