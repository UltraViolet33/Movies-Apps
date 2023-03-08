class User {
  String username;
  String email;
  String id;

  User({
    required this.username,
    required this.email,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "id": id,
      };
}
