import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
          color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),
      headline2: base.headline2.copyWith(
          color: Colors.yellow, fontSize: 16, fontWeight: FontWeight.bold),
      subtitle1: base.subtitle1.copyWith(color: Colors.yellow, fontSize: 17),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme), primaryColor: Colors.white);
}
