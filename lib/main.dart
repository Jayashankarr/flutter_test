import 'package:flutter/material.dart';
import 'package:test_project/src/screens/RecipePage.dart';
import 'package:test_project/src/screens/SplashScreen.dart';
import 'package:test_project/src/screens/SubCategoryPage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 240, 93, 65),
      cursorColor: Colors.black,
      fontFamily: 'Rubik', //font style
    ),

    routes: <String, WidgetBuilder>{
      '/SubCategory': (BuildContext context) => SubCategoryPage(),
      '/RecipePage': (BuildContext context) => RecipePage()
    },
    title: 'RecipeHut',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    //initialRoute: '/',
    home: SplashScreens(),
  ));
}
