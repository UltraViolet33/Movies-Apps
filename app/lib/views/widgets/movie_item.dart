import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  movie.posterUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      Text("Network error"),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Text(movie.title),
                  alignment: Alignment.center,
                ),
                flex: 2,
              )
            ],
          ),
        ));
  }
}
