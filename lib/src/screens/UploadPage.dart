import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UploadPageState();
  }
}

class UploadPageState extends State<UploadPage> {
  int _counter = 0;

  void _increaseCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter = _counter - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('JavaSampleApproach'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: new Container(
        padding: const EdgeInsets.all(80.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Text(
                  '$_counter',
                  style: new TextStyle(
                    color: _counter > 9 ? Colors.deepOrange : Colors.green,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Center(
                      child: new FlatButton(
                    onPressed: _increaseCounter,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text(
                      'Increase',
                      style: new TextStyle(fontSize: 18.5),
                    ),
                  )),
                ),
                new Expanded(
                  child: new Center(
                      child: new FlatButton(
                    onPressed: _decreaseCounter,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text(
                      'Descrease',
                      style: new TextStyle(fontSize: 18.5),
                    ),
                  )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
