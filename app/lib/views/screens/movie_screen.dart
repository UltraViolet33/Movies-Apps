import 'package:app/constants.dart';
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
            movie.is_in_watch_list
                ? Container(
                  width: MediaQuery.of(context).size.width - 200,
                height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: InkWell(
                    
                      onTap: () {},
                      child: const Center(
                          child: Text(
                        "Remove from watch list",
                        style:
                            TextStyle(fontSize: 15),
                      ))),
                )
                : Container(
                  width: MediaQuery.of(context).size.width - 200,
                height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: InkWell(
                    
                      onTap: () {},
                      child: const Center(
                          child: Text(
                        "Add to watch list",
                        style:
                            TextStyle(fontSize: 15),
                      ))),
                ),
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
