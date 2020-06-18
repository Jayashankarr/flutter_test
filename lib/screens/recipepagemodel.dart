import 'package:flutter/foundation.dart';
import 'package:test_project/recipe.dart';
import 'package:test_project/recipe_repository.dart';

class RecipePageModel with ChangeNotifier {
  RecipePageModel(this.recipeRepository);

  final RecipeRepository recipeRepository;

  /// If true login process is in progress
  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  Recipe getRecipeByIndex(int index) {
    return recipeRepository.getRecipeByIndex(index);
  }
}
