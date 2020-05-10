import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/src/manager/AppManager.dart';
import 'package:test_project/src/widgets/AppWidgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 255, 59, 48),
        title: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(50, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(22.0))),
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
      body: new ListView.builder(
          itemCount: AppManager.instance.getCategoryList().length,
          itemBuilder: (context, index) {
            return mainCategoryItem(context, index);
          }),
      /*body: new ListView(
        children: <Widget>[
          shop(context),
          shop(context),
          shop(context),
          shop(context),
          shop(context)
        ],
      ),*/

      /*body: new SingleChildScrollView(
          child: new Column(children: <Widget>[
        shop(context, 'Biriyani'),
        shop(context, 'Biriyani'),
        shop(context, 'Biriyani'),
        shop(context, 'Biriyani'),
        shop(context, 'Biriyani')
      ])),*/
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.settings), title: Text('Settings')),
          new ListTile(leading: new Icon(Icons.toys), title: Text('Version'))
        ],
      )),
      //body: _pageOptions[_selectedPage],
      /*bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              //_selectedPage = index;
              if (index == 0) Navigator.pushNamed(context, '/HomePage');
              if (index == 1) Navigator.pushNamed(context, '/UploadPage');
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload), title: Text('Upload')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text('Notification')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text('My Profile'))
          ]),*/
    );
  }
}
