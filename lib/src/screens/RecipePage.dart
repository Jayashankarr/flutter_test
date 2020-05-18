import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/src/widgets/AppWidgets.dart';

//https://stackoverflow.com/questions/52494346/how-to-create-a-hero-style-animation-on-the-same-screen-route-with-flutter

//https://api.flutter.dev/flutter/material/FlexibleSpaceBar-class.html
class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RecipePageState();
  }
}

class RecipePageState extends State<RecipePage> {
  ScrollController _controller = ScrollController();
  bool fullscreen = false;

  void snapScreen() {
    if (_controller.offset > MediaQuery.of(context).size.height * 0.6) return;

    if (_controller.offset < (MediaQuery.of(context).size.height * 0.6) / 2) {
      _controller.animateTo(0,
          duration: Duration(milliseconds: 50), curve: Curves.linear);
    } else {
      _controller.animateTo(MediaQuery.of(context).size.height * 0.6,
          duration: Duration(milliseconds: 50), curve: Curves.linear);
    }
  }

  void toggleFullScreen() {
    fullscreen = !fullscreen;
    if (fullscreen) {
      _controller.animateTo(0,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    } else {
      _controller.animateTo(MediaQuery.of(context).size.height * 0.6,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  void scrollTo(oSet) {
    _controller.jumpTo(_controller.offset - oSet);
  }

  @override
  void initState() {
    super.initState();

    /*_controller = ScrollController()
      ..addListener(() {
        /* print("offset = ${_controller.offset}" +
            " " +
            ((MediaQuery.of(context).size.height * 0.6) / 2).toString());*/
      });*/
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 100),
        () => _controller.jumpTo(MediaQuery.of(context).size.height * 0.6));

    return Scaffold(
        body: CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        //TransitionAppBar(),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _SliverAppBarDelegate(
              minHeight: MediaQuery.of(context).size.height * 0.2,
              maxHeight: MediaQuery.of(context).size.height,
              child: Container(),
              scrollTo: scrollTo,
              snapScreen: snapScreen,
              toggleFullScreen: toggleFullScreen),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, int) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                  alignment: Alignment.centerLeft,
                  child:
                      Text("Lijith", style: Theme.of(context).textTheme.title)),
              SizedBox(height: 10),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    SizedBox.fromSize(
                      size: Size(56, 56), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange, // button color
                          child: InkWell(
                            splashColor: Colors.green, // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.favorite), // icon
                                Text("Like"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(56, 56), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange, // button color
                          child: InkWell(
                            splashColor: Colors.green, // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.bookmark), // icon
                                Text("Save"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(56, 56), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange, // button color
                          child: InkWell(
                            splashColor: Colors.green, // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.share), // icon
                                Text("Share"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
              SizedBox(height: 15),
              new RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent

                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Total Time:',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .merge(TextStyle(color: Colors.black))),
                    new TextSpan(
                        text: ' 1 Hr 15 Min',
                        style: Theme.of(context).textTheme.subhead.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                  ],
                ),
              ),
              SizedBox(height: 15),
              new RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent

                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Servings:',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .merge(TextStyle(color: Colors.black))),
                    new TextSpan(
                        text: ' 2',
                        style: Theme.of(context).textTheme.subhead.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Ingrediants',
                  style: Theme.of(context).textTheme.subhead.merge(TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))),
              SizedBox(height: 10),
              ingrediantItem(context, 'Chicken mince'),
              SizedBox(height: 5),
              ingrediantItem(context, 'split gram pulse 50 gm soaked'),
              SizedBox(height: 5),
              ingrediantItem(context, 'whole garam masala 1 tspn'),
              SizedBox(height: 5),
              ingrediantItem(context, 'bay leaf 1'),
              SizedBox(height: 15),
              Text('Directions',
                  style: Theme.of(context).textTheme.subhead.merge(TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))),
              directionItem(
                  context,
                  'in a pressure cooker add mince spices pulse salt ginger garlic and onion',
                  ''),
              directionItem(
                  context, 'Directions', 'assets/images/main_icon.jpg')
            ],
          );
        }, childCount: 1)),
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    @required this.scrollTo,
    @required this.snapScreen,
    @required this.toggleFullScreen,
  });

  final Function scrollTo;
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Function snapScreen;
  final Function toggleFullScreen;

  double temp = 0;
  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    temp = shrinkOffset;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'assets/images/main_icon.jpg',
          fit: BoxFit.cover,
        ),
        GestureDetector(
          onTap: () {
            toggleFullScreen();
          },
          onVerticalDragEnd: (event) {
            snapScreen();
          },
          onVerticalDragUpdate: (event) {
            scrollTo(event.delta.dy);
          },
          //onVerticalDragStart: (event) {},
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    stops: [0.5, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated)),
          ),
        ),
        Positioned(
          left: 16.0,
          bottom: 45.0,
          child: Text('Biriyani',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.title.merge(
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        ),
        Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Row(
              children: <Widget>[
                new RichText(
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent

                    children: <TextSpan>[
                      new TextSpan(
                          text: '15',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .merge(TextStyle(color: Colors.white))),
                      new TextSpan(
                        text: ' Ingrediants',
                      ),
                    ],
                  ),
                )
              ],
            )),
        Positioned(
            right: 16.0,
            bottom: 16.0,
            child: Row(
              children: <Widget>[
                new RichText(
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent

                    children: <TextSpan>[
                      new TextSpan(
                          text: '15',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .merge(TextStyle(color: Colors.white))),
                      new TextSpan(
                        text: ' Minutes',
                      ),
                    ],
                  ),
                )
              ],
            )),
        Positioned(
          left: 0.0,
          //right: 16.0,
          top: 16.0,
          child: IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
    //);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    //print(temp.toString() +":" + oldDelegate.temp.toString());
    return true;
  }
}
