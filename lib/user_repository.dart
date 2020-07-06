import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project/services/auth_service.dart';
import 'package:test_project/user.dart';

class UserRepository with ChangeNotifier {
  UserRepository({this.authService}) {
    /* _recipeSubscription = authService.recipeList.listen((Recipe recipe) {
      this.recipeList = recipe;
    });*/

    //print('test');
  }

  StreamSubscription<User> _userSubscription;

  /// Authentication service for login/register/logout
  final AuthService authService;

  User _user;

  User get user {
    _user = User(authService.userObj);
    return _user;
  }

  set(value) {
    _user = value;
    notifyListeners();
  }

  String get userName {
    return _user.userName;
  }

  String get title {
    return _user.title;
  }

  int get followers {
    return _user.followers;
  }

  int get points {
    return _user.points;
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
