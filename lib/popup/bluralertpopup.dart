import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  String buttonText1;
  String buttonText2;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.buttonText1, this.buttonText2, this.content,
      this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: new Text(
            title,
            style: textStyle,
          ),
          content: new Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(this.buttonText1),
              onPressed: () {
                continueCallBack();
              },
            ),
            new FlatButton(
              child: Text(this.buttonText2),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
