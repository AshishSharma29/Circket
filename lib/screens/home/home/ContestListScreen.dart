import 'dart:convert';

import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/contest/JoinContest.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContestListScreen extends StatefulWidget {
  Map<String, String> argument;

  ContestListScreen(this.argument);

  @override
  _ContestListScreenState createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  CricketProvider cricketProvider;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  LoginResponseModel loginResponse;

  @override
  Widget build(BuildContext context) {
    if (loginResponse == null) getUserData();
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    if (isLoading) getContestList(context, widget.argument['matchId']);
    return Container(
      child: contestList == null
          ? Util().getLoader()
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: contestList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextWidget(
                          text: '${contestList[index].matchTitle}',
                          color: ColorUtils.green,
                          textSize: 18,
                          fontWeight: FontStyles.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${Constant.IMAGE_URL}${contestList[index].team1Icon}'))),
                            ),
                            TextWidget(
                                text:
                                    '${contestList[index].startTime.replaceAll("T", ' ')}'),
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${Constant.IMAGE_URL}${contestList[index].team2Icon}'))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextWidget(
                              text: 'Entry ${contestList[index].entryFee}',
                            ),
                            TextWidget(
                              text: 'Prize ${contestList[index].prize}',
                            ),
                            TextWidget(
                              text:
                                  'Maximum Entry ${contestList[index].maxEntry}',
                            ),
                            TextWidget(
                              text: 'Winner ${contestList[index].maxWinner}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (loginResponse.balance != null &&
                            contestList[index].entryFee <=
                                loginResponse.balance)
                          RaisedButton(
                              color: ColorUtils.colorPrimary,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return JoinContest(contestList[index]);
                                    });
                              },
                              child: TextWidget(
                                text: 'Join now',
                                color: ColorUtils.white,
                              ))
                        else
                          TextWidget(
                            text: 'No enough coins',
                            color: Colors.redAccent,
                            fontWeight: FontStyles.bold,
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  List<ContestModel> contestList;

  Future<void> getContestList(BuildContext context, String matchId) async {
    isLoading = true;
    contestList = await cricketProvider.getConstestList(context, matchId);
    print(contestList);
    isLoading = false;
    setState(() {});
  }

  SharedPreferences prefs;

  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    loginResponse =
        LoginResponseModel.fromJson(await Util.read(Constant.LoginResponse));
    var response = await NetworkUtil.callGetApi(
      context: context,
      apiName: ApiConstant.getDetails + '?userId=${loginResponse.id}',
    );
    print(response);
    if (json.encode(response["ResponsePacket"]) != 'null') {
      prefs.setString(
          Constant.LoginResponse, json.encode(response["ResponsePacket"]));
      loginResponse = LoginResponseModel.fromJson(response["ResponsePacket"]);
      setState(() {});
    }
  }
}
