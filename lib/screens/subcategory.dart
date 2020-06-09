import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'dart:async';

class MyHomePage extends StatelessWidget {
  List items = [];

  final digits = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    items = subCategoryList(context);

    return new Scaffold(
      body: new Center(
        child: FlipPanel.builder(
          itemBuilder: (context, index) => Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.005,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: items[index],
            /*child: Column(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.cyan,
                  ),
                ),
                Align(
                    child: Text('Show all recipes containing'),
                    alignment: Alignment.centerLeft),
                Flexible(
                  flex: 2,
                  child: Text("Description"),
                )
              ],
            ),*/ /*Text(
              '${digits[index]}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                  color: Colors.yellow),
            ),*/
          ),
          itemsCount: digits.length,
          period: Duration(milliseconds: 1000),
          loop: -1,
        ),
      ),
    );
  }
}

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
typedef Widget IndexedItemBuilder(BuildContext, int);

/// Signature for a function that creates a widget for a value emitted from a [Stream]
typedef Widget StreamItemBuilder<T>(BuildContext, T);

/// A widget for flip panel with built-in animation
/// Content of the panel is built from [IndexedItemBuilder] or [StreamItemBuilder]
///
/// Note: the content size should be equal

enum FlipDirection { up, down }

class FlipPanel<T> extends StatefulWidget {
  final IndexedItemBuilder indexedItemBuilder;
  final StreamItemBuilder<T> streamItemBuilder;
  final Stream<T> itemStream;
  final int itemsCount;
  final Duration period;
  final Duration duration;
  final int loop;
  final int startIndex;
  final T initValue;
  final double spacing;
  final FlipDirection direction;

  FlipPanel({
    Key key,
    this.indexedItemBuilder,
    this.streamItemBuilder,
    this.itemStream,
    this.itemsCount,
    this.period,
    this.duration,
    this.loop,
    this.startIndex,
    this.initValue,
    this.spacing,
    this.direction,
  }) : super(key: key);

  /// Create a flip panel from iterable source
  /// [itemBuilder] is called periodically in each time of [period]
  /// The animation is looped in [loop] times before finished.
  /// Setting [loop] to -1 makes flip animation run forever.
  /// The [period] should be two times greater than [duration] of flip animation,
  /// if not the animation becomes jerky/stuttery.
  FlipPanel.builder({
    Key key,
    @required IndexedItemBuilder itemBuilder,
    @required this.itemsCount,
    @required this.period,
    this.duration = const Duration(milliseconds: 500),
    this.loop = 1,
    this.startIndex = 0,
    this.spacing = 0.5,
    this.direction = FlipDirection.up,
  })  : assert(itemBuilder != null),
        assert(itemsCount != null),
        assert(startIndex < itemsCount),
        assert(period == null ||
            period.inMilliseconds >= 2 * duration.inMilliseconds),
        indexedItemBuilder = itemBuilder,
        streamItemBuilder = null,
        itemStream = null,
        initValue = null,
        super(key: key);

  /// Create a flip panel from stream source
  /// [itemBuilder] is called whenever a new value is emitted from [itemStream]
  /*FlipPanel.stream({
    Key key,
    @required this.itemStream,
    @required StreamItemBuilder<T> itemBuilder,
    this.initValue,
    this.duration = const Duration(milliseconds: 500),
    this.spacing = 0.5,
    this.direction = FlipDirection.up,
  })  : assert(itemStream != null),
        indexedItemBuilder = null,
        streamItemBuilder = itemBuilder,
        itemsCount = 0,
        period = null,
        loop = 0,
        startIndex = 0,
        super(key: key);*/

  @override
  _FlipPanelState<T> createState() => _FlipPanelState<T>();
}

class _FlipPanelState<T> extends State<FlipPanel>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int _currentIndex;
  bool _isReversePhase;
  bool _isStreamMode;
  bool _running;
  final _perspective = 0.001;
  final _zeroAngle =
      0.0001; // There's something wrong in the perspective transform, I use a very small value instead of zero to temporarily get it around.
  int _loop;
  T _currentValue, _nextValue;
  Timer _timer;
  StreamSubscription<T> _subscription;

  FlipDirection _direction;

  Widget _child1, _child2;
  Widget _upperChild1, _upperChild2;
  Widget _lowerChild1, _lowerChild2;

  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _isStreamMode = widget.itemStream != null;
    _isReversePhase = false;
    _running = false;
    _loop = 0;
    _direction = widget.direction;

    _controller =
        new AnimationController(duration: widget.duration, vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              print('Animation Complete');
              _isReversePhase = true;
              _controller.reverse();
            }
            if (status == AnimationStatus.dismissed) {
              _currentValue = _nextValue;
              _running = false;
            }
          })
          ..addListener(() {
            setState(() {
              _running = true;
            });
          });
    _animation =
        Tween(begin: _zeroAngle, end: math.pi / 2).animate(_controller);

    /*if (widget.period != null) {
      _timer = Timer.periodic(widget.period, (_) {
        if (widget.loop < 0 || _loop < widget.loop) {
          if (_currentIndex + 1 == widget.itemsCount - 2) {
            _loop++;
          }
          _currentIndex = (_currentIndex + 1) % widget.itemsCount;
          _child1 = null;
          _isReversePhase = false;
          _controller.forward();
        } else {
          _timer.cancel();
          _currentIndex = (_currentIndex + 1) % widget.itemsCount;
          setState(() {
            _running = false;
          });
        }
      });
    }*/

    /*if (_isStreamMode) {
      _currentValue = widget.initValue;
      _subscription = widget.itemStream.distinct().listen((value) {
        if (_currentValue == null) {
          _currentValue = value;
        } else if (value != _currentValue) {
          _nextValue = value;
          _child1 = null;
          _isReversePhase = false;
          _controller.forward();
        }
      });
    } else
    if (widget.loop < 0 || _loop < widget.loop) {
      _controller.forward();
    }*/
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_subscription != null) _subscription.cancel();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildChildWidgetsIfNeed(context);

    return _buildPanel();
  }

  void _buildChildWidgetsIfNeed(BuildContext context) {
    Widget makeUpperClip(Widget widget) {
      return GestureDetector(
          onVerticalDragStart: (dragDetails) {
            startVerticalDragDetails = dragDetails;
            updateVerticalDragDetails = null;
          },
          onVerticalDragUpdate: (dragDetails) {
            if (updateVerticalDragDetails == null) {
              updateVerticalDragDetails = dragDetails;
              double dx = updateVerticalDragDetails.globalPosition.dx -
                  startVerticalDragDetails.globalPosition.dx;
              double dy = updateVerticalDragDetails.globalPosition.dy -
                  startVerticalDragDetails.globalPosition.dy;
              //double velocity = endDetails.primaryVelocity;

              //Convert values to be positive
              //if (dx < 0) dx = -dx;
              //if (dy < 0) dy = -dy;

              if (dy < 0) {
                _direction = FlipDirection.up;
                _currentIndex = (_currentIndex + 1) % 10;
                _child1 = null;
                _isReversePhase = false;
                _controller.forward();
              } else {
                _direction = FlipDirection.down;
                _currentIndex = (_currentIndex - 1) % 10;
                _child1 = null;
                _isReversePhase = false;
                _controller.forward();
              }
            }
          },
          onVerticalDragEnd: (endDetails) {},
          /*onPanUpdate: (details) {
          onTap: () {
            print("Clicked!!!!!!");
            if (_currentIndex + 1 == 10 - 2) {
              _loop++;
            }
            _currentIndex = (_currentIndex + 1) % 10;
            _child1 = null;
            _isReversePhase = false;
            _controller.forward();
          },*/
          child: ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: widget,
            ),
          ));
    }

    Widget makeLowerClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.5,
          child: widget,
        ),
      );
    }

    if (_running) {
      if (_child1 == null) {
        _child1 = _child2 != null
            ? _child2
            : _isStreamMode
                ? widget.streamItemBuilder(context, _currentValue)
                : widget.indexedItemBuilder(
                    context, _currentIndex % widget.itemsCount);
        _child2 = null;
        _upperChild1 =
            _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1);
        _lowerChild1 =
            _lowerChild2 != null ? _lowerChild2 : makeLowerClip(_child1);
      }
      if (_child2 == null) {
        _child2 = _isStreamMode
            ? widget.streamItemBuilder(context, _nextValue)
            : widget.indexedItemBuilder(
                context, (_currentIndex + 1) % widget.itemsCount);
        _upperChild2 = makeUpperClip(_child2);
        _lowerChild2 = makeLowerClip(_child2);
      }
    } else {
      _child1 = _child2 != null
          ? _child2
          : _isStreamMode
              ? widget.streamItemBuilder(context, _currentValue)
              : widget.indexedItemBuilder(
                  context, _currentIndex % widget.itemsCount);
      _upperChild1 =
          _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1);
      _lowerChild1 =
          _lowerChild2 != null ? _lowerChild2 : makeLowerClip(_child1);
    }
  }

  Widget _buildUpperFlipPanel(direction) => direction == FlipDirection.up
      ? Stack(
          children: [
            Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateX(_zeroAngle),
                child: _upperChild1),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? _animation.value : math.pi / 2),
              child: _upperChild2,
            ),
          ],
        )
      : Stack(
          children: [
            Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateX(_zeroAngle),
                child: _upperChild2),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? math.pi / 2 : _animation.value),
              child: _upperChild1,
            ),
          ],
        );

  Widget _buildLowerFlipPanel(direction) => direction == FlipDirection.up
      ? Stack(
          children: [
            Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateX(_zeroAngle),
                child: _lowerChild2),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? math.pi / 2 : -_animation.value),
              child: _lowerChild1,
            )
          ],
        )
      : Stack(
          children: [
            Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateX(_zeroAngle),
                child: _lowerChild1),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? -_animation.value : math.pi / 2),
              child: _lowerChild2,
            )
          ],
        );

  Widget _buildPanel() {
    return _running
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUpperFlipPanel(_direction),
              Padding(
                padding: EdgeInsets.only(top: widget.spacing),
              ),
              _buildLowerFlipPanel(_direction),
            ],
          )
        : _isStreamMode && _currentValue == null
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateX(_zeroAngle),
                      child: _upperChild1),
                  Padding(
                    padding: EdgeInsets.only(top: widget.spacing),
                  ),
                  Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateX(_zeroAngle),
                      child: _lowerChild1)
                ],
              );
  }
}

List<Widget> subCategoryList(context) {
  List<Widget> retArr = [];

  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.cyan,
    Colors.white,
    Colors.black,
    Colors.deepOrange,
    Colors.lightBlueAccent,
    Colors.purple,
    Colors.orangeAccent
  ];

  for (var i = 0; i < 10; i++) {
    retArr.add(subCategoryItem(context, i));
    /*retArr.add(Column(children: <Widget>[
      Container(
        color: colors[i],
      ),
      Align(
          child: Text('Show all recipes containing:' + i.toString()),
          alignment: Alignment.centerLeft),
      Text('Description'),
    ]));*/

    /*retArr.add(Column(children: <Widget>[
      Flexible(
        flex: 2,
        child: Container(
          color: colors[i],
        ),
      ),
      Align(
          child: Text('Show all recipes containing:' + i.toString()),
          alignment: Alignment.centerLeft),
      Flexible(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new RichText(
              textAlign: TextAlign.start,
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
          ],
        ),
      )
    ]))*/

  }

  return retArr;
}

Widget subCategoryItem(BuildContext context, int index) {
  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.cyan,
    Colors.white,
    Colors.black,
    Colors.deepOrange,
    Colors.lightBlueAccent,
    Colors.purple,
    Colors.orangeAccent
  ];

  return Column(children: <Widget>[
    Flexible(
      flex: 2,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: colors[index],
        child: Image.asset("assets/images/biriyani.jpg"),
      ),
    ),
    Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
              child: Text('Chicken Fried Rice'),
              alignment: Alignment.centerLeft),
          new RichText(
            textAlign: TextAlign.start,
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent

              children: <TextSpan>[
                new TextSpan(
                    text: 'Preparation Time:',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .merge(TextStyle(color: Colors.black))),
                new TextSpan(
                    text: '45',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .merge(TextStyle(color: Colors.black))),
              ],
            ),
          ),
          Align(child: Text('Prepared By:'), alignment: Alignment.centerLeft),
          Align(child: Text('Donald Trump'), alignment: Alignment.centerLeft),
          Align(child: Text('Sous-Chef'), alignment: Alignment.centerLeft),
          Align(
              child: Text('890 Brownie Points'),
              alignment: Alignment.centerLeft),
          Align(
              child: RaisedButton(child: Text('VIEW RECIPE'), onPressed: null),
              alignment: Alignment.centerLeft),
          Align(
              child:
                  RaisedButton(child: Text('ADD TO BOOKMARK'), onPressed: null),
              alignment: Alignment.centerLeft),
        ],
      ),
    )
  ]);
}
