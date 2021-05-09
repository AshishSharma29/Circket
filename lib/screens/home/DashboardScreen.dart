import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/HomeScreen.dart';
import 'my_matchs/MyMatchScreen.dart';
import 'notificaiton/NotificationScreen.dart';
import 'profile/ProfileScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    MyMatchScreen(),
    ProfileScreen(),
    NotificationScreen()
  ];
  String _pageTitle = Strings.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorUtils.colorPrimary,
        selectedItemColor: ColorUtils.colorAccent,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageUtils.homeUnselect,
              height: 35,
              width: 35,
            ),
            activeIcon: Image.asset(
              ImageUtils.homeSelect,
              height: 35,
              width: 35,
            ),
            title: Text(Strings.home),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageUtils.myMatchUnselect,
              height: 35,
              width: 35,
            ),
            activeIcon: Image.asset(
              ImageUtils.myMatchSelect,
              height: 35,
              width: 35,
            ),
            title: Text(Strings.myMatch),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageUtils.profileUnselect,
              height: 35,
              width: 35,
            ),
            activeIcon: Image.asset(
              ImageUtils.profileSelect,
              height: 35,
              width: 35,
            ),
            title: Text(Strings.profile),
          ),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text(Strings.notification))*/
        ],
      ),
    );
  }

  void _onTapped(int value) {
    String title;
    switch (value) {
      case 0:
        title = Strings.home;
        break;
      case 1:
        title = Strings.myMatch;
        break;
      case 2:
        title = Strings.profile;
        break;
      case 3:
        title = Strings.notification;
        break;
    }
    setState(() {
      _currentIndex = value;
      _pageTitle = title;
    });
  }

  SharedPreferences prefs;

  void _openQuestion(BuildContext context) {
    Navigator.of(context).pushNamed(RouteNames.questionnaire);
  }
}
