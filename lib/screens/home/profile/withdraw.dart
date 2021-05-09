import 'dart:convert';

import 'package:cricquiz11/common_widget/font_style.dart';
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
      body: Stack(
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
          Column(
            children: [
              SizedBox(
                height: 20,
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
                    textSize: 18,
                    fontWeight: FontStyles.bold,
                    text: Strings.withdraw,
                  ),
                  SizedBox(
                    width: 32,
                  )
                ],
              ),
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
                          fontWeight: FontStyles.bold,
                          text: loginResponse == null
                              ? ''
                              : loginResponse.balance.ceil().toString(),
                          color: ColorUtils.white,
                          textSize: 24,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      maxLength: 3,
                      style: TextStyle(color: ColorUtils.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          ImageUtils.coin,
                          height: 12,
                          width: 12,
                        ),
                        counterText: '',
                        labelText: Strings.redeemCoins,
                        hintStyle: TextStyle(color: ColorUtils.white),
                        labelStyle: TextStyle(color: ColorUtils.white),
                        hintText: Strings.redeemCoins,
                      ),
                      onChanged: (value) {
                        this.amount = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        if (amount == null || amount.isEmpty) {
                          Util.showValidationdialog(
                              context, 'Please enter coins');
                        } else if (int.parse(amount) % 50 != 0) {
                          Util.showValidationdialog(
                              context, 'Please enter count in multiple of 50.');
                        } else if (loginResponse != null &&
                            !loginResponse.paymentRequestPending &&
                            loginResponse.balance > int.parse(amount) &&
                            loginResponse.balance > 100)
                          withdrawAmount(context);
                        else if (loginResponse.paymentRequestPending) {
                          Util.showValidationdialog(
                              context, 'Payment request pending for approval.');
                        } else
                          Util.showValidationdialog(context,
                              '150 coins should be in your wallet to create withdraw request.');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageUtils.playButton),
                          ),
                        ),
                        child: TextWidget(
                          color: ColorUtils.white,
                          textSize: 16,
                          text: Strings.withdraw,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (loginResponse != null &&
                        loginResponse.paymentRequestPending)
                      TextWidget(
                        color: ColorUtils.colorAccent,
                        textSize: 12,
                        text: Strings.alreadyRedeemed,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
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
    getUserData(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.appName),
          content: Text("Redeem request submitted successfully."),
          actions: [
            FlatButton(
              child: Text(Strings.ok),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
}
