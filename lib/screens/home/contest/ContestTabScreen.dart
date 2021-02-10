import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/screens/home/home/ContestListScreen.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:flutter/material.dart';

import 'MyContestScreen.dart';

class ContestTabScreen extends StatefulWidget {
  Map<String, String> argument;

  ContestTabScreen(this.argument);

  @override
  _ContestTabScreenState createState() => _ContestTabScreenState();
}

class _ContestTabScreenState extends State<ContestTabScreen> {
  int _pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: widget.argument['matchTitle'],
          textSize: 16,
          color: ColorUtils.white,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: TabBar(
                unselectedLabelColor: ColorUtils.black,
                labelColor: ColorUtils.colorPrimary,
                onTap: _onTap,
                tabs: [
                  Tab(
                    text: 'Contest',
                  ),
                  Tab(
                    text: 'My Contest',
                  ),
                ],
              ),
            ),
            Expanded(
              child: [
                ContestListScreen(widget.argument),
                MyContestScreen(widget.argument),
              ][_pageNumber],
            )
          ],
        ),
      ),
    );
  }

  void _onTap(int value) {
    setState(() {
      _pageNumber = value;
    });
  }
}
