import 'package:app/api/movies_api.dart';
import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movies_list.dart';
import 'package:flutter/material.dart';

class RandomMovies extends StatefulWidget {
  const RandomMovies({Key? key}) : super(key: key);

  @override
  State<RandomMovies> createState() => _RandomMoviesState();
}

class _RandomMoviesState extends State<RandomMovies> {
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
        title: const Text("random movies"),
      ),
      body: Center(
        child: Expanded(
          child: Center(
            child: FutureBuilder<List<Movie>>(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? MoviesList(movies: snapshot.data)
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
