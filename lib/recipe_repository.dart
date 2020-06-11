import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project/services/auth_service.dart';
import 'package:test_project/recipe.dart';

class RecipeRepository with ChangeNotifier {
  RecipeRepository({this.authService}) {
    /* _recipeSubscription = authService.recipeList.listen((Recipe recipe) {
      this.recipeList = recipe;
    });*/
  }

  StreamSubscription<Recipe> _recipeSubscription;

  /// Authentication service for login/register/logout
  final AuthService authService;

  List<Recipe> _recipes;

  set(value) {
    _recipes = value;
    notifyListeners();
  }

  List<Recipe> get recipeList => _recipes;

  List<Recipe> getMainCategoryList() {
    return authService.recipeList;
  }

  List<String> getRecipePrefs() {
    return authService.recipePrefs;
  }

  @override
  void dispose() {
    _recipeSubscription.cancel();
    super.dispose();
  }
}
