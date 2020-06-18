import 'package:flutter/foundation.dart';

class SubCategoryPageModel with ChangeNotifier {
  SubCategoryPageModel();

  //final RecipeRepository recipeRepository;

  /// If true login process is in progress
  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  /*List<Recipe> getRecipeList() {
    return recipeRepository.getRecipeList();
  }*/
}
