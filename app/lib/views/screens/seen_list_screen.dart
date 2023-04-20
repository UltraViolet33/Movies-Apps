import 'package:app/api/movies_api.dart';
import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movies_list.dart';
import 'package:flutter/material.dart';

class SeenListScreen extends StatefulWidget {
  const SeenListScreen({Key? key}) : super(key: key);

  @override
  State<SeenListScreen> createState() => _SeenListScreenState();
}

class _SeenListScreenState extends State<SeenListScreen> {
  late Future<List<Movie>> seenListMovies;

  @override
  void initState() {
    super.initState();
    seenListMovies = MoviesApi().fetchSeenList();
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
              future: seenListMovies,
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
