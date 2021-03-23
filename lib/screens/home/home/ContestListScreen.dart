import 'dart:convert';

import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/contest/JoinContest.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
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
          : contestList.length == 0
              ? Center(
                  child: TextWidget(
                    text: 'No match found',
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
                                if (loginResponse.balance != null &&
                                    contestList[index].entryFee <=
                                        loginResponse.balance)
                                  RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0)),
                                      color: ColorUtils.colorPrimary,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return JoinContest(
                                                  contestList[index]);
                                            });
                                      },
                                      child: TextWidget(
                                        textSize: 14,
                                        text: 'Join',
                                        color: ColorUtils.white,
                                      ))
                                else
                                  Column(
                                    children: [
                                      RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      8.0)),
                                          color: ColorUtils.redLogo,
                                          onPressed: () {},
                                          child: TextWidget(
                                            textSize: 14,
                                            text: contestList[index]
                                                .entryFee
                                                .ceil()
                                                .toString(),
                                            color: ColorUtils.white,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: TextWidget(
                                            textSize: 14,
                                            text: 'Earn more',
                                          ))
                                    ],
                                  )
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
