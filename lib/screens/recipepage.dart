import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/recipe.dart';
import 'package:test_project/recipe_repository.dart';
import 'package:test_project/screens/recipepagemodel.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Recipe _recipe;

  @override
  void initState() {
    _recipe = Provider.of<RecipeRepository>(context, listen: false)
        .getRecipeByIndex(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => RecipePageModel(
            Provider.of<RecipeRepository>(context, listen: false)),
        child: Consumer<RecipePageModel>(builder: (BuildContext context,
            RecipePageModel recipePageModel, Widget child) {
          return Scaffold(
              backgroundColor: Colors.blueGrey,
              body: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Align(
                          child: Text(
                            'Serves ' + _recipe.serveCount.toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          alignment: Alignment.centerLeft),
                      SizedBox(height: 10),
                      Align(
                          child: Text('INGREDIANTS',
                              style: Theme.of(context).textTheme.headline1),
                          alignment: Alignment.centerLeft),
                      ingrediantItem(context, 'Ingrediant 1'),
                      ingrediantItem(context, 'Ingrediant 2'),
                      ingrediantItem(context, 'Ingrediant 3'),
                      ingrediantItem(context, 'Ingrediant 4'),
                      SizedBox(height: 10),
                      Align(
                          child: Text('METHOD',
                              style: Theme.of(context).textTheme.headline1),
                          alignment: Alignment.centerLeft),
                      directionItem(context, 'Direction1', ''),
                      directionItem(context, 'Direction2', ''),
                      directionItem(context, 'Direction3', ''),
                      directionItem(context, 'Direction4', ''),
                      directionItem(context, 'Direction3', ''),
                      directionItem(context, 'Direction4', ''),
                      directionItem(context, 'Direction3', ''),
                      directionItem(context, 'Direction4', ''),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 250.0,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Container(
                              width: 75.0,
                              height: 75.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://i.imgur.com/BoN9kdC.png")))),
                          new Column(
                            children: <Widget>[
                              new Text("John Doe",
                                  style: Theme.of(context).textTheme.headline1),
                              new Text("This dish is a must try!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .merge(TextStyle(
                                          fontStyle: FontStyle.italic))),
                            ],
                          ),
                        ],
                      ),
                      Align(
                          child: Text('Tap on profile pic to view profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .merge(TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic))),
                          alignment: Alignment.centerLeft),
                      SizedBox(height: 30),
                      Align(
                          child: Text(
                              'Liked the dish? Give the Chef a Brownie!',
                              style: Theme.of(context).textTheme.headline2),
                          alignment: Alignment.center),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow)),
                        color: Colors.transparent,
                        textColor: Colors.yellow,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {},
                        child: Text("+1 Brownie Point".toUpperCase(),
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.yellow)),
                            color: Colors.transparent,
                            textColor: Colors.yellow,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {},
                            child: Text("Add To BookMark".toUpperCase(),
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.yellow)),
                            color: Colors.transparent,
                            textColor: Colors.yellow,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {},
                            child: Text("Share".toUpperCase(),
                                style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ));
        }));
    /*return */
  }
}

Widget ingrediantItem(BuildContext context, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 15),
      Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 15),
      Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      )
    ],
  );
}

Widget directionItem(
    BuildContext context, String description, String imageUrl) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 15),
      Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 15),
      Container(
          width: MediaQuery.of(context).size.width * 0.8,
          //height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              imageUrl == ''
                  ? Container()
                  : Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
              Text(description,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .merge(TextStyle(color: Colors.yellow)))
            ],
          ))
    ],
  );
}
