import 'package:app/views/screens/lists/seen_list_screen.dart';
import 'package:app/views/screens/lists/watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListsScreen extends StatelessWidget {
  const UserListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your lists"),
      ),
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
