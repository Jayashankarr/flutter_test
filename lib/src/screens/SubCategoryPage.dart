import 'package:flutter/material.dart';
import 'package:test_project/src/manager/AppManager.dart';
import 'package:test_project/src/widgets/AppWidgets.dart';

class MainListItems {
  final String title;
  final String description;

  MainListItems(this.title, this.description);
}

class SubCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SubCategoryPageState();
  }
}

class SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('My Profile'),
        ),
        body: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: <Widget>[
              subCategoryItem(context, 1),
              subCategoryItem(context, 1),
              subCategoryItem(context, 1),
              subCategoryItem(context, 1),
              subCategoryItem(context, 1),
              subCategoryItem(context, 1)
            ]));
  }
}
