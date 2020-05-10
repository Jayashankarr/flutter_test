import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyProfilePageState();
  }
}

class MyProfilePageState extends State<MyProfilePage> {
  int _counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('My Profile'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black12,
            ),
            Text('Lijith')
          ],
        ));
  }
}
