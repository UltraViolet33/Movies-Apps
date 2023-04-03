import 'package:app/api/movies_api.dart';
import 'package:app/constants.dart';
import 'package:app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchMovieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: TextInputField(
                  controller: _searchMovieController,
                  labelText: "search a movie",
                  icon: Icons.search),
            ),
            InkWell(
              onTap: () {
                // Get.to(RegisterScreen());
                setState(() {
                  // movies = MoviesApi()
                  //     .searchMovies(_searchMovieController.text);
                });
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 20, color: buttonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
