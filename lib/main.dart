import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/src/screens/HomePage.dart';
import 'package:test_project/src/screens/NotificationPage.dart';
import 'package:test_project/src/screens/UploadPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's Cook",
      theme: ThemeData(
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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  final _pageOptions = [HomePage(), UploadPage(), NotificationPage()];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Color.fromARGB(255, 255, 59, 48),
        /*leading: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0))),
        ),*/
        title: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(50, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(22.0))),
            /*child: Text('Search Recipes')*/
          ),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              alignment: Alignment.center,
              child: Text("Search Recipes",
                  style: TextStyle(color: Colors.white38))),
        ]),
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.settings), title: Text('Settings')),
          new ListTile(leading: new Icon(Icons.toys), title: Text('Version'))
        ],
      )),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload), title: Text('Upload')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text('Notification'))
          ]),
    );
  }
}
