import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/DashedLine.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContestScreen extends StatefulWidget {
  Map<String, dynamic> argument;

  MyContestScreen(this.argument);

  @override
  _MyContestScreenState createState() => _MyContestScreenState();
}

class _MyContestScreenState extends State<MyContestScreen> {
  CricketProvider cricketProvider;
  List<ContestModel> contestList;
  SharedPreferences prefs;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    var loginResponse = Util.read(Constant.LoginResponse);
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    if (isLoading) getMyContestList(context, widget.argument['matchId']);

    return Container(
      child: contestList == null
          ? Util().getLoader()
          : contestList.length == 0
              ? Center(
                  child: TextWidget(
                    text: 'No data found',
                    color: ColorUtils.white,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(contestList[index].result);
                    return Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, right: 8, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 8, bottom: 8, right: 8, left: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorUtils.greyContest,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                text:
                                                    'Winner : ${contestList[index].prize.ceil().toString()}',
                                                color: ColorUtils.black,
                                                textSize: 14,
                                              ),
                                              Image.asset(
                                                ImageUtils.coin,
                                                height: 15,
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: ColorUtils.greyContest,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                text:
                                                    'Entry : ${contestList[index].entryFee.ceil().toString()}',
                                                color: ColorUtils.black,
                                                textSize: 14,
                                              ),
                                              Image.asset(
                                                ImageUtils.coin,
                                                height: 15,
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  DashedLine(
                                    height: 1,
                                    color: ColorUtils.darkerGrey,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${Constant.IMAGE_URL}${widget.argument['flag1']}'))),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${Constant.IMAGE_URL}${widget.argument['flag2']}'))),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 8,
                                      )),
                                      RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      8.0)),
                                          color: ColorUtils.colorPrimary,
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                RouteNames.questionnaire,
                                                arguments: {
                                                  'contestId':
                                                      contestList[index]
                                                          .id
                                                          .toString(),
                                                  'contestTitle':
                                                      contestList[index]
                                                          .matchTitle
                                                          .toString()
                                                });
                                          },
                                          child: TextWidget(
                                            textSize: 14,
                                            text: 'View',
                                            color: ColorUtils.white,
                                          ))
                                    ],
                                  ),
                                  if (contestList[index].result.isNotEmpty)
                                    SizedBox(
                                      height: 4,
                                    ),
                                  if (contestList[index].result.isNotEmpty)
                                    SizedBox(
                                      height: 4,
                                    ),
                                  if (contestList[index].result.isNotEmpty)
                                    TextWidget(
                                      textSize: 12,
                                      text: contestList[index].result +
                                          'the contest',
                                      color: contestList[index]
                                              .result
                                              .contains('won')
                                          ? ColorUtils.colorPrimary
                                          : ColorUtils.colorAccent,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> getMyContestList(BuildContext context, String matchId) async {
    isLoading = true;
    var userModel = await Util.read(Constant.LoginResponse);
    contestList = await cricketProvider.getMyConstestList(
        context, matchId, userModel['Id'].toString());
    print(contestList);
    isLoading = false;
    setState(() {});
  }
}
