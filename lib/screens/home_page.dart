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
  int bottomSelectedIndex = 0;
  bool clickedCentreFAB = false;
  AnimationController animationController;
  //TODO:
  //Zrobić animacje do FABa
 
 Widget bottomAppBarItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        bottomTapped(index);
      },
      iconSize: 27.0,
      icon: Icon(
        icon,
        color:
            bottomSelectedIndex == index ? primaryColor : Colors.grey.shade400,
      ),
    );
  }

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: _children,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'elcity',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.settings), onPressed: null)
        // ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            clickedCentreFAB = !clickedCentreFAB;
          });
        },
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: clickedCentreFAB ? Icon(Icons.close):Icon(Icons.add),
        ),
        elevation: clickedCentreFAB?0:4.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(child: buildPageView()),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                width: clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(clickedCentreFAB ? 0.0 : 300.0),
                    color: primaryColor),
              ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              bottomAppBarItem(Icons.home, 0),
              bottomAppBarItem(Icons.star, 1),
              SizedBox(
                width: 50.0,
              ),
              bottomAppBarItem(Icons.person, 2),
              bottomAppBarItem(Icons.settings, 3)
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
    ));
  }
}

final List<Widget> _children = [
  DashboardPage(),
  new Container(
    color: Colors.grey,
  ),
  ProfilePage(),
  new Container(
    color: Colors.blueGrey,
  )
];
