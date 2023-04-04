import 'dart:convert';
import 'package:app/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesApi {
  Future<List<Movie>> fetchMovies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};
    headers["cookie"] = cookie!;

    var url = Uri.parse('$apiEndpoint/get-random-movies');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<Movie> movies = movieFromJson(response.body);
      print(response.body);
      return movies;
    } else {
      throw Exception("Failed to load resources");
    }
  }

  Future<List<Movie>> fetchWatchList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};
    headers["cookie"] = cookie!;

    var url = Uri.parse('$apiEndpoint/movies/watch-list');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<Movie> movies = movieFromJson(response.body);
      print(response.body);
      return movies;
    } else {
      throw Exception("Failed to load resources");
    }
  }

  Future<List<Movie>> searchMovies(String movie) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};
    headers["cookie"] = cookie!;

    var url = Uri.parse('$apiEndpoint/movies/search/$movie');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<Movie> movies = movieFromJson(response.body);
      return movies;
    } else {
      throw Exception("Failed to load resources");
    }
  }

  Future<Map<String, String>> getCookie() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};
    headers["cookie"] = cookie!;

    return headers;
  }

  Future<Movie> addMovieToWatchList(int movieId) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();

    // var cookie = pref.getString("cookie");

    // Map<String, String> headers = {};
    // headers["cookie"] = cookie!;

    Map<String, String> headers = await MoviesApi().getCookie();

    var url = Uri.parse('$apiEndpoint/movies/watch-list/add');

    Map<String, String> data = {
      "movie_id": movieId.toString(),
    };

    http.Response response = await http.post(url, headers: headers, body: data);

    if (response.statusCode == 200) {
      Get.snackbar("Watch list", "Movie added to your watch list !");
      Movie movie = Movie.fromJson(jsonDecode(response.body));
      return movie;
    } else {
      Get.snackbar("Error !", jsonDecode(response.body)["msg"]);
      // return null;
      throw Exception("Failed to load resources");
    }
  }

  Future<Movie> removeMovieFromWatchList(int movieId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookie = pref.getString("cookie");

    Map<String, String> headers = {};
    headers["cookie"] = cookie!;

    var url = Uri.parse('$apiEndpoint/movies/watch-list/remove');

    Map<String, String> data = {
      "movie_id": movieId.toString(),
    };

    http.Response response = await http.post(url, headers: headers, body: data);

    if (response.statusCode == 200) {
      Get.snackbar("Watch list", "Movie removed from your watch list !");
      Movie movie = Movie.fromJson(jsonDecode(response.body));
      return movie;
    } else {
      Get.snackbar("Error !", jsonDecode(response.body)["msg"]);
      // return null;
      throw Exception("Failed to load resources");
    }
  }
}
