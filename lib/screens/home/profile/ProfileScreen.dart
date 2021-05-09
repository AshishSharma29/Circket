import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cricquiz11/common_widget/font_style.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Container(
      child: Stack(
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
          loginResponse == null
              ? Util().getLoader()
              : Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
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
                            fontWeight: FontStyles.bold,
                            text: Strings.profile,
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32.0, horizontal: 8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageUtils.earnMore,
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextWidget(
                                  textAlign: TextAlign.center,
                                  textSize: 40,
                                  color: ColorUtils.white,
                                  fontWeight: FontStyles.bold,
                                  text: loginResponse == null
                                      ? ''
                                      : '${loginResponse.balance.ceil()}',
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Share.share(
                                            'download and install this app using ${loginResponse.referralCode} referral code and get 100 coins');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        alignment: Alignment.center,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                ImageUtils.playButton),
                                          ),
                                        ),
                                        child: TextWidget(
                                          textAlign: TextAlign.center,
                                          textSize: 16,
                                          text: 'Refer and earn',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextField(
                                    style: TextStyle(color: ColorUtils.white),
                                    cursorColor: ColorUtils.white,
                                    maxLength: 50,
                                    controller: TextEditingController()
                                      ..text = loginResponse.name,
                                    enabled: _isEditable,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: ColorUtils.white),
                                      hintStyle:
                                          TextStyle(color: ColorUtils.white),
                                      counterText: '',
                                      labelText: Strings.name,
                                      hintText: Strings.name,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      loginResponse.name = value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextField(
                                    style: TextStyle(color: ColorUtils.white),
                                    controller: TextEditingController()
                                      ..text = loginResponse.email,
                                    enabled: _isEditable,
                                    maxLength: 50,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: ColorUtils.white),
                                      hintStyle:
                                          TextStyle(color: ColorUtils.white),
                                      counterText: '',
                                      labelText: Strings.email,
                                      hintText: Strings.email,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      loginResponse.email = value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextField(
                                    style: TextStyle(color: ColorUtils.white),
                                    controller: TextEditingController()
                                      ..text = loginResponse.mobileNo,
                                    maxLength: 15,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: ColorUtils.white),
                                      hintStyle:
                                          TextStyle(color: ColorUtils.white),
                                      counterText: '',
                                      labelText: Strings.mobileNumber,
                                      hintText: Strings.mobileNumber,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorUtils.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                InkWell(
                                  onTap: () {
                                    _onTap();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(ImageUtils.playButton),
                                      ),
                                    ),
                                    child: TextWidget(
                                      color: ColorUtils.white,
                                      textSize: 16,
                                      text: _isEditable
                                          ? Strings.submit
                                          : Strings.edit,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
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
