import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/screens/menupagemodel.dart';
import 'package:test_project/user.dart';
import 'package:test_project/user_repository.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  User user;

  List<String> menuItems = [
    'My Recipes',
    'Top Chefs of the Week',
    'Followers',
    'Following',
    'Bookmarked Recipes',
    'My Shopping List',
    'Edit Personalization',
    'Surprise Me!'
  ];

  @override
  void initState() {
    user = Provider.of<UserRepository>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuPageModel>(
        create: (BuildContext context) => MenuPageModel(),
        child: Consumer<MenuPageModel>(builder:
            (BuildContext context, MenuPageModel homePageModel, Widget child) {
          return Scaffold(
              backgroundColor: Colors.blueGrey,
              body: ListView(
                children: <Widget>[
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: addMenuItems(menuItems, context)))
                ],
              ));
        }));
  }
}

List<Widget> addMenuItems(List items, context) {
  var widgets = List<Widget>();

  widgets.add(ExpansionTile(
    title: Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 3.0, color: Colors.amber)),
      child: Center(
          child: Text(items[0], style: Theme.of(context).textTheme.subtitle1)),
    ),
    trailing: Text(""),
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, '/SubmitRecipe');
              },
              child: Text("Submit\nYour Recipes",
                  style: Theme.of(context).textTheme.subtitle1)),
          RaisedButton(
              color: Colors.red,
              onPressed: () {},
              child: Text("View \nSubmitted Recipes",
                  style: Theme.of(context).textTheme.subtitle1))
        ],
      )
    ],
  ));

  for (var i = 1; i < items.length; i++) {
    widgets.add(GestureDetector(
        onTap: () {
          //callBack(i);
        },
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(width: 3.0, color: Colors.amber)),
          child: Text(items[i], style: Theme.of(context).textTheme.subtitle1),
        )));
  }

  return widgets;
}
