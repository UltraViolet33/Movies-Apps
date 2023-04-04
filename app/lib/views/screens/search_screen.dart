import 'package:app/api/movies_api.dart';
import 'package:app/constants.dart';
import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movies_list.dart';
import 'package:app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchMovieController = TextEditingController();

  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = MoviesApi().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a movie"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextInputField(
                    controller: _searchMovieController,
                    labelText: "search a movie",
                    icon: Icons.search,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      movies =
                          MoviesApi().searchMovies(_searchMovieController.text);
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
          Expanded(
            child: Center(
              child: FutureBuilder<List<Movie>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? MoviesList(movies: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
