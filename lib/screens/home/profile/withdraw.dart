import 'dart:convert';

import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Withdraw coins',
          color: ColorUtils.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                border: Border.all(color: ColorUtils.colorAccent)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageUtils.coin,
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextWidget(
                      textAlign: TextAlign.center,
                      text: loginResponse == null
                          ? ''
                          : loginResponse.balance.ceil().toString(),
                      color: ColorUtils.colorPrimary,
                      textSize: 24,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  maxLength: 3,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(
                      ImageUtils.coin,
                      height: 12,
                      width: 12,
                    ),
                    counterText: '',
                    labelText: Strings.redeemCoins,
                    hintText: Strings.redeemCoins,
                  ),
                  onChanged: (value) {
                    this.amount = value;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorUtils.colorPrimary,
                  ),
                  onPressed: () {
                    withdrawAmount(context);
                  },
                  child: TextWidget(
                    color: ColorUtils.white,
                    textSize: 16,
                    text: Strings.withdraw,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> withdrawAmount(BuildContext context) async {
    var userModel = await Util.read(Constant.LoginResponse);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.withdrawRequest,
        requestBody: {
          "UserId": userModel['Id'].toString(),
          "Amount": amount,
        });
    Util.showValidationdialog(
        context, 'Redeem request submitted successfully.');
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
}
