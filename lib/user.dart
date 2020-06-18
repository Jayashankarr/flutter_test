import 'dart:ffi';

class User {
  String userName;
  String userId;
  String title;
  // List<String> recipeId;

  int followers;
  int points;

  User(object) {
    this.userName = object["userName"];
    this.userId = object["userId"];
    this.title = object["title"];
    this.followers = object["followers"];

    this.points = object["points"];
  }
}
