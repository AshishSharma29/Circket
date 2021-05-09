import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/screens/home/home/ContestListScreen.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:flutter/material.dart';
import 'package:toggle_bar/toggle_bar.dart';

import 'MyContestScreen.dart';

class ContestTabScreen extends StatefulWidget {
  Map<String, dynamic> argument;

  ContestTabScreen(this.argument);

  @override
  _ContestTabScreenState createState() => _ContestTabScreenState();
}

class _ContestTabScreenState extends State<ContestTabScreen> {
  int _pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.argument['isUpcoming'] != null
            ? Stack(
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
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
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
                              textSize: 16,
                              fontWeight: FontStyles.bold,
                              text: widget.argument['matchTitle'],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteNames.settings);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  ImageUtils.settings,
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ToggleBar(
                              labels: ["Contest", "My Contest"],
                              selectedTabColor: ColorUtils.vColor,
                              backgroundColor: ColorUtils.transparentPurple,
                              borderRadius: 5,
                              onSelectionUpdated: (index) =>
                                  {_onTap(index)} // Do something with index
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
                ],
              )
            : Stack(children: [
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
                    child: Column(children: [
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                        textSize: 16,
                        fontWeight: FontStyles.bold,
                        text: widget.argument['matchTitle'],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteNames.settings);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            ImageUtils.settings,
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: MyContestScreen(widget.argument))
                ])),
              ]));
  }

  void _onTap(int value) {
    setState(() {
      _pageNumber = value;
    });
  }
}
