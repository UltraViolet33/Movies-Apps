import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movie_item.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  final List<Movie>? movies;

  const MoviesList({Key? key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies!.length,
        itemBuilder: (context, index) {
          return MovieItem(movie: movies![index]);
        });
  }
}
