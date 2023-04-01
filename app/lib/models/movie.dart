import 'dart:convert';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    required this.category,
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.isInWatchList,
  });

  int category;
  int id;
  String posterUrl;
  String title;
  bool isInWatchList;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        category: json["category"],
        id: json["id"],
        posterUrl: json["posterURL"],
        title: json["title"],
        isInWatchList: json["is_in_watch_list"]
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "posterURL": posterUrl,
        "title": title,
      };
}