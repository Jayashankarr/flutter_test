class RecipeCategory {
  String categoryId;
  String categoryName;
  List<String> categoryPreferences;
  RecipeCategory(object, i) {
    this.categoryId = object["categoryId"] + i.toString();
    this.categoryName = object['categoryName'] + i.toString();
    this.categoryPreferences = object["categoryPreferences"];
  }
}
