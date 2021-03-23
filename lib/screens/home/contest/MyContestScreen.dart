import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContestScreen extends StatefulWidget {
  Map<String, String> argument;

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
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, right: 8, left: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: 'Prize',
                                  color: ColorUtils.darkerGrey,
                                  textSize: 14,
                                ),
                                Row(
                                  children: [
                                    TextWidget(
                                      textSize: 14,
                                      text: contestList[index]
                                          .entryFee
                                          .ceil()
                                          .toString(),
                                      color: ColorUtils.darkerGrey,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset(
                                      ImageUtils.coin,
                                      height: 15,
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  TextWidget(
                                    color: ColorUtils.black,
                                    textSize: 18,
                                    fontWeight: FontWeight.bold,
                                    text: '${contestList[index].prize.ceil()}',
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    ImageUtils.coin,
                                    height: 15,
                                    width: 15,
                                  ),
                                ]),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0)),
                                    color: ColorUtils.colorPrimary,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          RouteNames.questionnaire,
                                          arguments: {
                                            'contestId': contestList[index]
                                                .id
                                                .toString(),
                                            'contestTitle': contestList[index]
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
