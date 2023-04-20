import 'package:app/api/movies_api.dart';
import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movies_list.dart';
import 'package:flutter/material.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late Future<List<Movie>> watchListMovies;

  @override
  void initState() {
    super.initState();
    watchListMovies = MoviesApi().fetchWatchList();
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
              future: watchListMovies,
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
