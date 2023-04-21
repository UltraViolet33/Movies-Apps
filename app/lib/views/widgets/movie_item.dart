import 'package:app/models/movie.dart';
import 'package:app/views/screens/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieItem extends StatelessWidget {
  const MovieItem(
      {super.key, required this.movie, required this.handleWatchList});

  final Movie movie;
  final Function(Movie newMovie) handleWatchList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Get.to(MovieScreen(
          movie: movie,
          handleWatchList: handleWatchList,
        ));
      }),
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  movie.posterUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Network error"),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(movie.title),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
