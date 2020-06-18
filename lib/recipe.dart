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
    this.categoryId = object["categoryId"];
    this.category = object['category'] + i.toString();
    this.dishName = object['dishName'] + i.toString();
    this.preparationTime = object['preparationTime'];
    this.owner = object["owner"];
    this.serveCount = object["serveCount"];
    this.ingrediants = object["ingrediants"];
    this.directions = object["directions"];
  }
}
