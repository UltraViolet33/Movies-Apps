import 'package:app/models/movie.dart';
import 'package:app/views/screens/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        print("ok");
        print(movie.is_in_watch_list);
        Get.to(MovieScreen(
          movie: this.movie,
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
                    child: Row(
                      children: [
                        Text(movie.title),
                        movie.is_in_watch_list ? Text("To See") : Text("")
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                  flex: 2,
                ),
                // movie.is_in_watch_list ? Text("ok") : Text("okd")
                // Text("ok")
              ],
            ),
          )),
    );
  }
}
