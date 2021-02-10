import 'dart:convert';

import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;
  LoginResponseModel loginResponse;

  @override
  Widget build(BuildContext context) {
    if (loginResponse == null) getUserData();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16,
            ),
            TextWidget(
              textAlign: TextAlign.center,
              textSize: 24,
              text: loginResponse == null
                  ? ''
                  : 'Balance : ${loginResponse.balance}',
            ),
            SizedBox(
              height: 16,
            ),
            TextWidget(
              textAlign: TextAlign.center,
              textSize: 24,
              text: loginResponse == null
                  ? ''
                  : 'Referral code : ${loginResponse.referralCode}',
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              child: Icon(Icons.share),
              onTap: () {
                Share.share('check out my website https://example.com');
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              maxLength: 50,
              enabled: _isEditable,
              decoration: InputDecoration(
                labelText: loginResponse == null ? '' : loginResponse.name,
                hintText: Strings.name,
              ),
            ),
            TextField(
              enabled: _isEditable,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: loginResponse == null ? '' : loginResponse.email,
                hintText: Strings.email,
              ),
            ),
            TextField(
              maxLength: 15,
              enabled: _isEditable,
              decoration: InputDecoration(
                labelText: loginResponse == null ? '' : loginResponse.mobileNo,
                hintText: Strings.mobileNumber,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: _onTap,
              color: ColorUtils.colorPrimary,
              child: TextWidget(
                color: ColorUtils.white,
                text: _isEditable ? Strings.submit : Strings.edit,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  Future<void> getUserData() async {
    var user = await Util.read(Constant.LoginResponse);
    setState(() {});
  }
}
