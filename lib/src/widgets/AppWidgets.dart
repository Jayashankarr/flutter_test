import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainCategoryItem(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/SubCategory');
    },
    child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Stack(children: [
            Image.asset(
              'assets/images/main_icon.jpg',
              fit: BoxFit.cover,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 80.0),
                alignment: Alignment.center,
                child: Text("Biriyani",
                    style: TextStyle(color: Colors.white, fontSize: 20)))
          ])
        ])),
  );
}

Widget subCategoryItem(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      // Navigator.pushNamed(context, '/SubCategory');
    },
    child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Image.asset(
            'assets/images/main_icon.jpg',
            fit: BoxFit.cover,
          ),
          Text("Name",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(color: Colors.red))),
          Text("Author",
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: Colors.red))),
          Text("Duration",
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: Colors.red)))
        ])),
  );
}
