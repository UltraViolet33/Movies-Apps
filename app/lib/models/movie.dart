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
  });

  int category;
  int id;
  String posterUrl;
  String title;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        category: json["category"],
        id: json["id"],
        posterUrl: json["posterURL"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "posterURL": posterUrl,
        "title": title,
      };
}
