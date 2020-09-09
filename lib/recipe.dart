import 'dart:math';

class Recipe {
  String categoryId;
  String category;
  String dishName;
  int preparationTime;
  String owner;
  int serveCount;
  List<String> ingrediants;
  List<Object> directions;
  Recipe(object, i) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random _rnd = Random();

    this.categoryId = object["categoryId"];
    this.category = object['category'] + i.toString();
    this.dishName = object['dishName'] +
        String.fromCharCodes(Iterable.generate(
            5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    this.preparationTime = object['preparationTime'];
    this.owner = object["owner"];
    this.serveCount = object["serveCount"];
    this.ingrediants = object["ingrediants"];
    this.directions = object["directions"];
  }
}
