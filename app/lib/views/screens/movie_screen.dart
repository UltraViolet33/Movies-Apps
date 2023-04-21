import 'package:app/api/movies_api.dart';
import 'package:app/constants.dart';
import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  Movie movie;
  final Function(Movie newMovie) handleWatchList;

  MovieScreen({super.key, required this.movie, required this.handleWatchList});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late bool isInSeenList;

  @override
  void initState() {
    super.initState();
    isInSeenList = widget.movie.isInSeenList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                widget.movie.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),
              widget.movie.isInWatchList
                  ? Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          MoviesApi()
                              .removeMovieFromWatchList(widget.movie.id)
                              .then((value) {
                            setState(() {
                              widget.movie = value;
                            });
                            widget.handleWatchList(widget.movie);
                          });
                        },
                        child: const Center(
                          child: Text(
                            "Remove from watch list",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          MoviesApi()
                              .addMovieToWatchList(widget.movie.id)
                              .then((value) {
                            setState(() {
                              widget.movie = value;
                            });
                            widget.handleWatchList(widget.movie);
                          });
                        },
                        child: const Center(
                          child: Text("Add to watch list"),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 25,
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 425),
                child: Image.network(
                  widget.movie.posterUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Network error"),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    isInSeenList
                        ? MoviesApi().removeMovieFromSeenList(widget.movie.id)
                        : MoviesApi().addMovieToSeenList(widget.movie.id);
                    setState(() {
                      isInSeenList = !isInSeenList;
                    });
                  },
                  child: Center(
                    child: isInSeenList
                        ? const Text("Remove from seen list")
                        : const Text("Add to seen list"),
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
