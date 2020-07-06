import 'package:flutter/foundation.dart';

class HomePageModel with ChangeNotifier {
  HomePageModel();

  //final RecipeRepository recipeRepository;

  /// If true login process is in progress
  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  /* List<Recipe> getMainCategoryList() {
    return recipeRepository.getMainCategoryList();
  }*/
}
