import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/src/screens/HomePage.dart';
import 'package:test_project/src/screens/MyProfilePage.dart';
import 'package:test_project/src/screens/NotificationPage.dart';
import 'package:test_project/src/screens/UploadPage.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedPage = 0;

  // List of pages
  final _pageOptions = [
    HomePage(),
    UploadPage(),
    NotificationPage(),
    MyProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
                icon: Icon(Icons.notifications), title: Text('Notifications')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text('My Profile'))
          ]),
    );
  }
}
