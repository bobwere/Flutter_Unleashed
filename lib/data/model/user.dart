import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.username,
    this.email,
    this.phonenumber,
    this.photoUrl,
  });

  final String username;
  final String email;
  final String phonenumber;
  final String photoUrl;

  User copyWith({
    String username,
    String email,
    String phonenumber,
    String photoUrl,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        phonenumber: phonenumber ?? this.phonenumber,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "photoUrl": photoUrl,
      };
}
