import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;

  MovieScreen({Key? key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Container(
       
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              movie.title,
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
            height: 25,
          ),
            Text("Category : " + movie.category.toString()),
            const SizedBox(
            height: 25,
          ),
            Image.network(
              movie.posterUrl,
              errorBuilder: (context, error, stackTrace) =>
                  Text("Network error"),
            ),
          ],
        ),
      ),
    );
  }
}
