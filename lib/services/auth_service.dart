import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_project/category.dart';
import 'package:test_project/recipe.dart';
import 'package:test_project/user.dart';

enum ErrorType {
  ERROR_VALIDATION,
  ERROR_SAVING,
  ERROR_NULL,
  ERROR_AUTH,
  ERROR_OTHER
}

class AuthService with ChangeNotifier {
  Object userObj = {
    'userName': 'Lijith',
    "userId": "user1",
    "title": "Chef",
    "followers": 1,
    "points": 123
  };

  User get currentUser {
    return User(userObj);
  }

  String errorString = '';

  List<Recipe> items = [];

  List<Recipe> get recipeList {
    List<Recipe> retArray = [];

    var item = {
      "categoryId": "category0",
      "category": "Chinese",
      'dishName': 'Chicken Fried Rice',
      "preparationTime": 45,
      "owner": "Lijith",
      "serveCount": 3,
      "ingrediants": ["ingrediant1", "ingrediant2"],
      "directions": [
        {"direction": "direction1"},
        {"direction": "direction2"},
        {"direction": "direction3"},
      ]
    };

    //retArray.add(new Recipe(item, 0));
    for (var i = 0; i < 8; i++) {
      retArray.add(new Recipe(item, i));
    }

    return retArray;
  }

  List<String> get recipePrefs {
    List<String> retArray = [];

    for (var i = 0; i < 8; i++) {
      retArray.add("Prefs" + i.toString());
    }

    return retArray;
  }

  // CATEORY -----------
  var catObj = {
    "categoryId": "category",
    "categoryName": "categoryName",
    "categoryPreferences": [
      'pref1',
      'pref2',
      'pref3',
      'pref4',
      'pref5',
      'pref6',
      'pref7'
    ]
  };

  List<RecipeCategory> get categories {
    List<RecipeCategory> retArray = [];

    for (var i = 0; i < 10; i++) {
      retArray.add(new RecipeCategory(catObj, i));
    }

    return retArray;
  }

  /*Stream<Recipe> get recipe => StreamTransformer<FirebaseUser, Recipe>.fromHandlers(
          handleData: (FirebaseUser firebaseUser, Sink<Shop> sink) {
        if (firebaseUser != null) {
          sink.add(Shop(firebaseUser.uid, firebaseUser.displayName));
        } else {
          sink.add(null);
        }
      }).bind(FirebaseAuth.instance.onAuthStateChanged);*/

}
