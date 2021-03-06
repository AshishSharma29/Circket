import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/contest/JoinContest.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/DashedLine.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContestListScreen extends StatefulWidget {
  Map<String, dynamic> argument;

  ContestListScreen(this.argument);

  @override
  _ContestListScreenState createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  CricketProvider cricketProvider;
  AdmobReward rewardAd;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    Admob.initialize();
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );

    rewardAd.load();
  }

  String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }

/*    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3054283360025567/5143993158';
    }*/
    return null;
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                        'Thanks for watching the ad. We will credit 1 coin in your account'),
                  ],
                ),
              ),
              onWillPop: () async {
                insertGoogleAdCoin(context);
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }

  Future<void> showAd() async {
    if (Platform.isIOS) await Admob.requestTrackingAuthorization();
    if (await rewardAd.isLoaded) {
      rewardAd.show();
    } else {
      print('reward Ad is still loading...');
    }
  }

  @override
  void dispose() {
    super.dispose();
    rewardAd.dispose();
  }

  Future<void> insertGoogleAdCoin(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var user = await Util.read(Constant.LoginResponse);
    loginResponse = LoginResponseModel.fromJson(user);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.insertGoogleAdCoin,
        requestBody: {'userId': loginResponse.id.toString()});
    print(response);
    if (json.encode(response["ResponsePacket"]) != 'null') {
      getUserData();
    }
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
                    color: ColorUtils.white,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      child: Container(
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
                                          padding: const EdgeInsets.all(8),
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
                                          padding: const EdgeInsets.all(8),
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
                                      )),
                                if (!(loginResponse.balance != null &&
                                    contestList[index].entryFee <=
                                        loginResponse.balance))
                                  RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0)),
                                      color: ColorUtils.redLogo,
                                      onPressed: () {
                                        Util.showValidationdialog(context,
                                            'coin balance is not sufficient.');
                                      },
                                      child: TextWidget(
                                        textSize: 14,
                                        text: 'Join',
                                        color: ColorUtils.white,
                                      )),
                              ],
                            ),
                            /*if (!(loginResponse.balance != null &&
                                contestList[index].entryFee <=
                                    loginResponse.balance))
                              TextWidget(
                                textSize: 14,
                                text: 'Earn more',
                                color: ColorUtils.colorAccent,
                                textAlign: TextAlign.end,
                              ),*/
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
