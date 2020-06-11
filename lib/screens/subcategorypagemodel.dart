import 'package:flutter/foundation.dart';

import 'package:test_project/recipe_repository.dart';

class SubCategoryPageModel with ChangeNotifier {
  SubCategoryPageModel(this.recipeRepository);

  final RecipeRepository recipeRepository;

  /// If true login process is in progress
  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<String> getRecipePrefs() {
    return recipeRepository.getRecipePrefs();
  }
}
