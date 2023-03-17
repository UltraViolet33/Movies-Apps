import 'package:app/api/movies_api.dart';
import 'package:app/constants.dart';
import 'package:app/models/movie.dart';
import 'package:app/views/auth/register_screen.dart';
import 'package:app/views/widgets/movies_list.dart';
import 'package:app/views/widgets/password_input.dart';
import 'package:app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = MoviesApi().fetchMovies();
    print(movies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? MoviesList(movies: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    )));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       alignment: Alignment.center,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             "My Movies",
  //             style: TextStyle(
  //                 fontSize: 35,
  //                 color: buttonColor,
  //                 fontWeight: FontWeight.w900),
  //           ),
  //           Text(
  //             "Home",
  //             style: TextStyle(
  //                 fontSize: 25,
  //                 color: buttonColor,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //           const SizedBox(
  //             height: 25,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width - 40,
  //             height: 50,
  //             decoration: BoxDecoration(
  //                 color: buttonColor,
  //                 borderRadius: const BorderRadius.all(Radius.circular(5))),
  //             child: InkWell(
  //                 onTap: () {
  //                   AuthController.logoutUser();
  //                 },
  //                 child: const Center(
  //                     child: Text(
  //                   "Logout",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  //                 ))),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
