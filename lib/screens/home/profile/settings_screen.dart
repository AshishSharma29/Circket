import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AdmobReward rewardAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Admob.initialize();
    // RequestConfiguration.Builder().setTestDeviceIds(Arrays.asList("E8FDF12CB0D3B1AB7D6D6E2BF1B5502C"))
    // Admob.initialize(testDeviceIds: ['E8FDF12CB0D3B1AB7D6D6E2BF1B5502C']);
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );

    rewardAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
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

  Future<void> insertGoogleAdCoin(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var user = await Util.read(Constant.LoginResponse);
    loginResponse = LoginResponseModel.fromJson(user);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.insertGoogleAdCoin,
        requestBody: {'userId': loginResponse.id.toString()});
    print(response);
    getUserData(context);
  }

  @override
  void dispose() {
    super.dispose();
    rewardAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loginResponse == null) getUserData(context);

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Settings',
          color: ColorUtils.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              ImageUtils.greenBg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5),
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.coin_history);
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.coinHistory,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: Strings.coinHistory,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteNames.instruction_to_play);
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.coinHistory,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: Strings.instructionToEarn,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteNames.accountVerification);
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.userIcon,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: 'KYC',
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showAd();
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.earnMore,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: Strings.earnMore,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (loginResponse.balance > 150)
                      Navigator.of(context)
                          .pushNamed(RouteNames.withdraw)
                          .then((value) => {getUserData(context)});
                    else
                      Util.showValidationdialog(context,
                          'At least 150 coins are required to withdraw the coins.');
                  },
                  child: Card(
                    /*color: loginResponse.balance > 100
                        ? ColorUtils.colorPrimary
                        : ColorUtils.lightGrey,*/
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.withdraw,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: Strings.withdraw,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _logoutOnClick(context);
                  },
                  child: Card(
                    /*color: loginResponse.balance > 100
                        ? ColorUtils.colorPrimary
                        : ColorUtils.lightGrey,*/
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtils.exit,
                            height: 35,
                            width: 35,
                          ),
                          TextWidget(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            text: Strings.logout,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SharedPreferences prefs;
  LoginResponseModel loginResponse;

  Future<void> getUserData(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var user = await Util.read(Constant.LoginResponse);
    loginResponse = LoginResponseModel.fromJson(user);
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

  Future<void> _logoutOnClick(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
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
                prefs.setString(Constant.LoginResponse, '');
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

  Future<void> showAd() async {
    if (Platform.isIOS) await Admob.requestTrackingAuthorization();
    if (await rewardAd.isLoaded) {
      rewardAd.show();
    } else {
      showSnackBar('reward Ad is still loading...');
    }
  }

  void showSnackBar(String content) {
    print(content);
  }

  String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
  }
}
