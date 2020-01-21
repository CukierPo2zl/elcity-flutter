import 'package:elcity/screens/screens.dart';

import 'dashboard_page.dart';
import 'package:elcity/global.dart';
import 'package:elcity/screens/dashboard_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    ChatPage(),
    new Container(
      color: Colors.orange,
    ),
    DashboardPage(),
    new Container(
      color: Colors.red,
    ),
    new Container(
      color: Colors.red,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'elcity',
            style: TextStyle(color: primaryColor),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              title: new Text(''),
              icon: _currentIndex == 0
                  ? Icon(Icons.chat_bubble, color: primaryColor)
                  : Icon(Icons.chat_bubble_outline, color: primaryColor),
            ),
            BottomNavigationBarItem(
              title: new Text(''),
              icon: _currentIndex == 1
                  ? Icon(Icons.add_circle, color: primaryColor)
                  : Icon(Icons.add_circle_outline, color: primaryColor),
            ),
            BottomNavigationBarItem(
              title: new Text(''),
              icon: _currentIndex == 2
                  ? Icon(Icons.blur_circular, color: primaryColor)
                  : Icon(Icons.blur_on, color: primaryColor),
            ),
            BottomNavigationBarItem(
              title: new Text(''),
              icon: _currentIndex == 3
                  ? Icon(Icons.star, color: primaryColor)
                  : Icon(Icons.star_border, color: primaryColor),
            ),
            BottomNavigationBarItem(
              title: new Text(''),
              icon: _currentIndex == 4
                  ? Icon(Icons.account_circle, color: primaryColor)
                  : Icon(Icons.perm_identity, color: primaryColor),
            ),
          ],
        ));
  }
}

