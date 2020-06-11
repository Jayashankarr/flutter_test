import 'package:flutter/material.dart';
import 'package:test_project/recipe.dart';

enum ErrorType {
  ERROR_VALIDATION,
  ERROR_SAVING,
  ERROR_NULL,
  ERROR_AUTH,
  ERROR_OTHER
}

class AuthService with ChangeNotifier {
  String errorString = '';

  List<Recipe> items = [];

  List<Recipe> get recipeList {
    List<Recipe> retArray = [];

    var item = {
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

    for (var i = 0; i < 8; i++) {
      retArray.add(new Recipe(item));
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

  /*Stream<Recipe> get recipe => StreamTransformer<FirebaseUser, Recipe>.fromHandlers(
          handleData: (FirebaseUser firebaseUser, Sink<Shop> sink) {
        if (firebaseUser != null) {
          sink.add(Shop(firebaseUser.uid, firebaseUser.displayName));
        } else {
          sink.add(null);
        }
      }).bind(FirebaseAuth.instance.onAuthStateChanged);*/

}
