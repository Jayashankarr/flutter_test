import 'dart:ffi';

class Recipe {
  String category;
  String dishName;
  Float preparationTime;
  String owner;
  Float serveCount;
  List<String> ingrediants;
  List<Object> directions;
  Recipe(object) {
    this.category = object['category'];
    this.dishName = object['dishName'];
    this.preparationTime = object['preparationTime'];
    this.owner = object["owner"];
    this.serveCount = object["serveCount"];
    this.ingrediants = object["ingrediants"];
    this.directions = object["directions"];
  }
}
