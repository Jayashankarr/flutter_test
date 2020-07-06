import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project/category.dart';
import 'package:test_project/services/auth_service.dart';

class CategoryRepository with ChangeNotifier {
  CategoryRepository({this.authService}) {
    /* _recipeSubscription = authService.recipeList.listen((Recipe recipe) {
      this.recipeList = recipe;
    });*/
  }

  StreamSubscription<RecipeCategory> _categorySubscription;

  /// Authentication service for login/register/logout
  final AuthService authService;

  List<RecipeCategory> _categories;

  set(value) {
    _categories = value;
    notifyListeners();
  }

  String _currentCategory;
  List<String> _selectedPrefs = [];

  void setCurrentCategory(String catId) {
    _currentCategory = catId;
  }

  String getcurrentCategory() {
    return _currentCategory;
  }

  List<RecipeCategory> getCategoryList() {
    _categories = authService.categories;
    return _categories;
  }

  RecipeCategory getCategoryListByIndex(catIndex) {
    for (var i = 0; i < _categories.length; i++) {
      if (_categories[i].categoryId == catIndex) {
        return _categories[i];
      }
    }

    return null;
  }

  void resetCategoryPrefs() {
    _selectedPrefs = [];
  }

  void updateCategoryPrefs(String pref) {
    _selectedPrefs.add(pref);
  }

  @override
  void dispose() {
    _categorySubscription.cancel();
    super.dispose();
  }
}
