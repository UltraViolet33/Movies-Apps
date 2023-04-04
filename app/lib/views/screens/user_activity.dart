import 'package:app/views/screens/seen_list_screen.dart';
import 'package:app/views/screens/watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(const WatchListScreen());
                },
                child: const Center(
                  child: Text(
                    "See my watch list",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(const SeenListScreen());
                },
                child: const Center(
                  child: Text(
                    "See my seen list",
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
