import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                            style: Theme.of(context).textTheme.title),
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
            itemCount: 10,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return mainCategoryItem(context, index);
            }));
  }
}

Widget mainCategoryItem(BuildContext context, int index) {
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
              child: Text("Biriyani",
                  style: TextStyle(color: Colors.black, fontSize: 20)))
        ])),
  );
}
