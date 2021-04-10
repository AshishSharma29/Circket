import 'dart:async';
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
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;
  LoginResponseModel loginResponse;

  AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void dispose() {
    super.dispose();
    rewardAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loginResponse == null) getUserData(context);
    return loginResponse == null
        ? Util().getLoader()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            textAlign: TextAlign.center,
                            textSize: 24,
                            text: loginResponse == null
                                ? ''
                                : '${loginResponse.balance.ceil()}',
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            ImageUtils.coin,
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget(
                            textAlign: TextAlign.center,
                            textSize: 24,
                            text: loginResponse == null
                                ? ''
                                : '${loginResponse.referralCode}',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: Icon(Icons.share),
                            onTap: () {
                              Share.share(
                                  'download and install this app using ${loginResponse.referralCode} referral code and get 100 coins');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      border: Border.all(
                        color: ColorUtils.colorAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    maxLength: 50,
                    controller: TextEditingController()
                      ..text = loginResponse.name,
                    enabled: _isEditable,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: ColorUtils.colorPrimary,
                      ),
                      counterText: '',
                      labelText: Strings.name,
                      hintText: Strings.name,
                    ),
                    onChanged: (value) {
                      loginResponse.name = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: TextEditingController()
                      ..text = loginResponse.email,
                    enabled: _isEditable,
                    maxLength: 50,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: ColorUtils.colorPrimary,
                      ),
                      counterText: '',
                      labelText: Strings.email,
                      hintText: Strings.email,
                    ),
                    onChanged: (value) {
                      loginResponse.email = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: TextEditingController()
                      ..text = loginResponse.mobileNo,
                    maxLength: 15,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: ColorUtils.colorPrimary,
                      ),
                      counterText: '',
                      labelText: Strings.mobileNumber,
                      hintText: Strings.mobileNumber,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    onPressed: _onTap,
                    color: ColorUtils.colorPrimary,
                    child: TextWidget(
                      color: ColorUtils.white,
                      textSize: 16,
                      text: _isEditable ? Strings.submit : Strings.edit,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  /*                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteNames.coin_history);
                    },
                    child: Card(
                      child: TextWidget(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        text: Strings.coinHistory,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.instruction_to_play);
                    },
                    child: Card(
                      child: TextWidget(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        text: Strings.instructionToEarn,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.accountVerification);
                    },
                    child: Card(
                      child: TextWidget(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        text: Strings.addKycDocument,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showAd();
                    },
                    child: Card(
                      child: TextWidget(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        text: Strings.earnMore,
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
                      color: loginResponse.balance > 100
                          ? ColorUtils.colorPrimary
                          : ColorUtils.lightGrey,
                      child: TextWidget(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        text: Strings.withdraw,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    /*if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3054283360025567/6344807451';
    }*/
    return null;
  }

  Future<void> _onTap() async {
    if (!_isEditable) {
      _isEditable = !_isEditable;
      setState(() {});
      return;
    }
    Util.showProgress(context);
    await NetworkUtil.callPostApi(
            context: context,
            apiName: ApiConstant.updateProfile,
            requestBody: loginResponse.toJson())
        .then((value) => {
              Navigator.of(context).pop(),
              if (json.encode(value["ResponsePacket"]) != 'null')
                {
                  prefs.setString(Constant.LoginResponse,
                      json.encode(value["ResponsePacket"])),
                  Util.showValidationdialog(
                      context, 'Data updated successfully'),
                }
              else
                Util.showValidationdialog(context, value['Message']),
              _isEditable = !_isEditable,
              setState(() {})
            });
  }

  SharedPreferences prefs;

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

/*    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3054283360025567/5143993158';
    }*/
    return null;
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3054283360025567/4687292619';
    }
    return null;
  }
}
