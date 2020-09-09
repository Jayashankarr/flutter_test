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

  //List<Recipe> get recipeList => _recipes;

  /*List<Recipe> getRecipeList() {
    _recipes = authService.recipeList;
    return authService.recipeList;
  }*/

  List<Recipe> getRecipeListByUserId(String userId) {
    return authService.getRecipeListByUserId(userId);
  }


  List<Recipe> getRecipeList() {
    _recipes = authService.recipeList;
    return authService.recipeList;
  }

  List<String> getRecipePrefs() {
    return authService.recipePrefs;
  }

  Recipe getRecipeByIndex(int index) {
    Recipe recipe = _recipes[index];
    return recipe;
  }

  @override
  void dispose() {
    _recipeSubscription.cancel();
    super.dispose();
  }
}
