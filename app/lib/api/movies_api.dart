import 'package:app/constants.dart';
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
}
