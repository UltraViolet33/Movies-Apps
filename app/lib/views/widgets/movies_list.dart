import 'package:app/models/movie.dart';
import 'package:app/views/widgets/movie_item.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatefulWidget {
  final List<Movie>? movies;

  const MoviesList({Key? key, required this.movies});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies!.length,
      itemBuilder: (context, index) {
        return MovieItem(
          movie: widget.movies![index],
          handleWatchList: (Movie newMovie) {
            setState(() {
              widget.movies![index] = newMovie;
            });
          },
        );
      },
    );
  }
}
