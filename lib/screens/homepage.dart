import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/screens/homepagemodel.dart';
import 'package:test_project/recipe.dart';
import 'package:test_project/recipe_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
        create: (BuildContext context) => HomePageModel(
            Provider.of<RecipeRepository>(context, listen: false)),
        child: Consumer<HomePageModel>(builder:
            (BuildContext context, HomePageModel homePageModel, Widget child) {
          return Scaffold(
              appBar: PreferredSize(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                      ),
                      Positioned(
                        top: 40,
                        left: 120,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Lijith',
                                  style: Theme.of(context).textTheme.headline6),
                              Text('Master Chef'),
                              Text('128 Followers'),
                              Text('128 Brownie Points')
                            ]),
                      ),
                      Positioned(
                          top: 40,
                          left: 20,
                          child: Icon(
                            Icons.account_circle,
                            size: 70,
                          ))
                    ],
                  ),
                  preferredSize: Size.fromHeight(100)),
              body: GridView.builder(
                  itemCount: homePageModel.getMainCategoryList().length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return mainCategoryItem(
                        context, homePageModel.getMainCategoryList()[index]);
                  }));
        }));
  }
}

Widget mainCategoryItem(BuildContext context, Recipe recipe) {
  return GestureDetector(
    onTap: () {
      //Navigator.pushNamed(context, '/SubCategory');
    },
    child: Card(
        color: Colors.blue,
        child: Stack(children: [
          Icon(Icons.account_circle),
          Container(
              //margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 80.0),
              alignment: Alignment.bottomLeft,
              child: Text(recipe.category,
                  style: TextStyle(color: Colors.black, fontSize: 20)))
        ])),
  );
}
