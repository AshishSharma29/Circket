import 'package:cricquiz11/screens/home/my_matchs/UpcomingMatchList.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:flutter/material.dart';

import 'CompletedMatchList.dart';
import 'RunningMatchList.dart';

class MyMatchScreen extends StatefulWidget {
  @override
  _MyMatchScreenState createState() => _MyMatchScreenState();
}

class _MyMatchScreenState extends State<MyMatchScreen> {
  int _pageNumber = 0;
  List<Widget> _page = [
    UpcomingMatchList(),
    RunningMatchList(),
    CompletedMatchList()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DefaultTabController(
            length: 3,
            child: TabBar(
              unselectedLabelColor: ColorUtils.black,
              labelColor: ColorUtils.colorPrimary,
              onTap: _onTap,
              tabs: [
                Tab(
                  text: 'Upcoming',
                ),
                Tab(
                  text: 'Running',
                ),
                Tab(
                  text: 'Completed',
                ),
              ],
            ),
          ),
          Expanded(
            child: _page[_pageNumber],
          )
        ],
      ),
    );
  }

  void _onTap(int value) {
    setState(() {
      _pageNumber = value;
    });
  }
}
