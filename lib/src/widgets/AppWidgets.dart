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
                    style: TextStyle(color: Colors.black, fontSize: 20)))
          ])
        ])),
  );
}

/*Widget mainCategoryItem(BuildContext context, int index) {
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
            /*Image.asset(
              'assets/images/main_icon.jpg',
              fit: BoxFit.cover,
            ),*/
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 80.0),
                alignment: Alignment.center,
                child: Text("Biriyani",
                    style: TextStyle(color: Colors.black, fontSize: 20)))
          ])
        ])),
  );
}*/

Widget subCategoryItem(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/RecipePage');
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

Widget ingrediantItem(BuildContext context, String title) {
  return ListTile(
    leading: Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    ),
    title: Text(title),
    //subtitle: Text('TWICE'),
  );
}

Widget directionItem(
    BuildContext context, String description, String imageUrl) {
  return ListTile(
    leading: Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    ),
    title: Container(
        width: MediaQuery.of(context).size.width,
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
            Text(description)
          ],
        )),
    //subtitle: Text('TWICE'),
  );
}
