import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_project/category_repository.dart';
import 'package:test_project/screens/categorypage.dart';
import 'package:test_project/screens/homepage.dart';
import 'package:test_project/screens/recipepage.dart';
import 'package:test_project/screens/subcategory.dart';
import 'package:test_project/services/auth_service.dart';
import 'package:test_project/recipe_repository.dart';
import 'package:test_project/theme.dart';
import 'package:test_project/user_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final RecipeRepository authInfo =
        RecipeRepository(authService: authService);
    final UserRepository userInfo = UserRepository(authService: authService);
    final CategoryRepository catInfo =
        CategoryRepository(authService: authService);

    return MultiProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: basicTheme(),
            /*theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),*/
            home: HomePage(title: 'Flutter Demo Home Page'),
            routes: <String, WidgetBuilder>{
              '/Category': (BuildContext context) => CategoryPage(),
              '/SubCategory': (BuildContext context) => SubCategoryPage(),
              '/RecipePage': (BuildContext context) => RecipePage()
            }
            //home: RecipePage(),
            ),
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<RecipeRepository>.value(value: authInfo),
          ChangeNotifierProvider<UserRepository>.value(value: userInfo),
          ChangeNotifierProvider<CategoryRepository>.value(value: catInfo),
        ]);
  }
}
