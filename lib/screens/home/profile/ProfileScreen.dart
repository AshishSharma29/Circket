import 'dart:convert';

import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
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
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        textAlign: TextAlign.center,
                        textSize: 24,
                        text: loginResponse == null
                            ? ''
                            : '${loginResponse.balance}',
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
                  )
                ],
              ),
            ),
          );
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
}
