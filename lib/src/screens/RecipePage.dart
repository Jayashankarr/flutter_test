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
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('15 Ingrediants',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subhead),
                  ),
                  Expanded(
                    child: Text('15 minutes',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.subhead),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Lijith",
                      style: Theme.of(context).textTheme.subtitle)),
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
              Row(
                children: <Widget>[
                  Text('Total Time:'),
                  Text('1 Hr 15 min'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Text('Servings:'),
                  Text('2'),
                ],
              ),
              SizedBox(height: 15),
              Text('Ingrediants'),
              ingrediantItem(context, '11111'),
              ingrediantItem(context, '11111'),
              ingrediantItem(context, '11111'),
              ingrediantItem(context, '11111'),
              SizedBox(height: 15),
              Text('Directions'),
              directionItem(context, 'asdadadasda', ''),
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
            print('test' + event.delta.dy.toString());
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
          right: 16.0,
          bottom: 16.0,
          child: Text('test'),
        ),
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
                print('test');
                //Navigator.pushNamed(context, '/RecipePage');
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

/*class TransitionAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TransitionAppBarState();
  }
}

class TransitionAppBarState extends State<TransitionAppBar> {
  double offset = 0;
  @override
  void initState() {
    super.initState();
  }

  void callback() {}

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(offset: offset),
    );
  }
}

/*class TransitionAppBar extends StatelessWidget {
  final double offset;

  const TransitionAppBar({this.offset});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(offset: offset),
    );
  }
}*/

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  double offset;
  double test;
  _TransitionAppBarDelegate({this.offset}) : assert(offset != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / 200.0;
    test = shrinkOffset;

    return GestureDetector(
        onTap: () {
          offset = 100;
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/main_icon.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      stops: [0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.repeated)),
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: Text('test'),
            ),
          ],
        ));
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    //return true;
    return offset != oldDelegate.offset;
  }
}
*/
