class AppManager {
  static AppManager _instance = new AppManager._internal();
  static get instance =>
      _instance; // this is a get method that return _instance private class field
  // the name member is accessible directly like a public field
  String name;

  AppManager._internal() {
    name = " singleton name property";
  }

  // To get the sub category list of items
  List getSubCategoryList(String index) {
    List<SubCategoryItem> subCategoryList = [];

    subCategoryList = List.generate(
      20,
      (i) => SubCategoryItem('Biriyani', 'Sub Title', 200),
    );

    return subCategoryList;
  }

  // To get the main category list of items
  List getCategoryList() {
    List<MainListItems> categoryList = [];

    categoryList = List.generate(
      20,
      (i) => MainListItems(
        'Biriyani $i',
        'A description of what needs to be done for Todo $i',
      ),
    );

    return categoryList;
  }
}

class SubCategoryItem {
  final String title;
  final String subTitle;
  final int duration;

  SubCategoryItem(this.title, this.subTitle, this.duration);
}

class MainListItems {
  final String title;
  final String description;

  MainListItems(this.title, this.description);
}
