import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: TextWidget(
          text: _pageTitle,
          textSize: 16,
          color: ColorUtils.white,
        ),
        actions: [
          InkWell(
            onTap: () {
              _logoutOnClick(context);
            },
            child: Padding(
              child: Icon(Icons.signal_wifi_off),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorUtils.colorPrimary,
        selectedItemColor: ColorUtils.green,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(Strings.home),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.my_location),
            title: new Text(Strings.myMatch),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text(Strings.profile)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text(Strings.notification))
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

  void _logoutOnClick(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.appName),
          content: Text(Strings.logoutConfirmation),
          actions: [
            FlatButton(
              child: Text(Strings.yes),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteNames.login, (route) => false);
              },
            ),
            FlatButton(
              child: Text(Strings.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
