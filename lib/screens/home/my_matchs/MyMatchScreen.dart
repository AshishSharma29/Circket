import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/screens/home/my_matchs/UpcomingMatchList.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_bar/toggle_bar.dart';

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
    return Stack(
      children: [
        Container(
          child: Image.asset(
            ImageUtils.appBg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Util.closeApplication(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        ImageUtils.backArrow,
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  TextWidget(
                    padding: const EdgeInsets.all(24),
                    color: ColorUtils.white,
                    textSize: 18,
                    text: Strings.myMatch,
                    fontWeight: FontStyles.bold,
                  ),
                  SizedBox(
                    width: 48,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ToggleBar(
                    labels: ["Upcoming", "Running", 'Complete'],
                    selectedTabColor: ColorUtils.vColor,
                    backgroundColor: ColorUtils.transparentPurple,
                    borderRadius: 5,
                    onSelectionUpdated: (index) =>
                        {_onTap(index)} // Do something with index,
                    ),
              ),
              /*DefaultTabController(
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
              ),*/
              Expanded(
                child: _page[_pageNumber],
              )
            ],
          ),
        ),
      ],
    );
  }

  void _onTap(int value) {
    setState(() {
      _pageNumber = value;
    });
  }
}
