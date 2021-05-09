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

import 'account_detail_model.dart';

class AccountVerification extends StatefulWidget {
  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  AccountDetailModel accountDetailModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountDetailModel = AccountDetailModel();
    accountDetailModel.id = 0;
    accountDetailModel.isVerified = false;
    Future.delayed(Duration.zero, () {
      getAccountDetails(context);
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
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        text: 'Account details',
                      ),
                      SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 20,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.accountNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.accountNumber,
                      hintText: Strings.accountNumber,
                    ),
                    onChanged: (value) {
                      accountDetailModel.accountNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 50,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.accountHolderName,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.accountHolderName,
                      hintText: Strings.accountHolderName,
                    ),
                    onChanged: (value) {
                      accountDetailModel.accountHolderName = value;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 11,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.iFSCCode,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.ifscCode,
                      hintText: Strings.ifscCode,
                    ),
                    onChanged: (value) {
                      accountDetailModel.iFSCCode = value;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 50,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.bankName,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.bankName,
                      hintText: Strings.bankName,
                    ),
                    onChanged: (value) {
                      accountDetailModel.bankName = value;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 50,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.bankBranch,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.branchName,
                      hintText: Strings.branchName,
                    ),
                    onChanged: (value) {
                      accountDetailModel.bankBranch = value;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: accountDetailModel.id == 0,
                    maxLength: 50,
                    style: TextStyle(color: ColorUtils.white),
                    controller: TextEditingController()
                      ..text = accountDetailModel.state,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ColorUtils.white),
                      hintStyle: TextStyle(color: ColorUtils.white),
                      counterText: '',
                      labelText: Strings.state,
                      hintText: Strings.state,
                    ),
                    onChanged: (value) {
                      accountDetailModel.state = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (accountDetailModel.id == 0)
                    RaisedButton(
                      onPressed: () {
                        submitDetails(context);
                      },
                      color: ColorUtils.colorPrimary,
                      child: TextWidget(
                        color: ColorUtils.white,
                        textSize: 14,
                        text: Strings.submit,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SharedPreferences prefs;
  LoginResponseModel loginResponse;

  Future<void> submitDetails(BuildContext context) async {
    if (isValidAccountDetails(accountDetailModel, context)) {
      prefs = await SharedPreferences.getInstance();
      var user = await Util.read(Constant.LoginResponse);
      loginResponse = LoginResponseModel.fromJson(user);
      accountDetailModel.userId = loginResponse.id;
      Util.showProgress(context);
      await NetworkUtil.callPostApi(
              context: context,
              apiName: ApiConstant.insertUpdateAccountDetail,
              requestBody: accountDetailModel.toJson())
          .then((value) => {
                Navigator.of(context).pop(),
                if (json.encode(value["ResponsePacket"]) != 'null')
                  {
                    accountDetailModel =
                        AccountDetailModel.fromJson(value["ResponsePacket"]),
                    Util.showValidationdialog(
                        context, 'Data updated successfully'),
                  }
                else
                  Util.showValidationdialog(context, value['Message']),
              });
    }
  }

  bool isValidAccountDetails(
      AccountDetailModel accountDetailModel, BuildContext context) {
    if (accountDetailModel.accountNumber == null ||
        accountDetailModel.accountNumber.isEmpty) {
      Util.showValidationdialog(context, 'Please enter account number');
      return false;
    }
    if (accountDetailModel.accountHolderName == null ||
        accountDetailModel.accountHolderName.isEmpty) {
      Util.showValidationdialog(context, 'Please enter account holder name');
      return false;
    }
    if (accountDetailModel.iFSCCode == null ||
        accountDetailModel.iFSCCode.isEmpty) {
      Util.showValidationdialog(context, 'Please enter IFSC code');
      return false;
    }
    if (accountDetailModel.bankName == null ||
        accountDetailModel.bankName.isEmpty) {
      Util.showValidationdialog(context, 'Please enter bank name');
      return false;
    }
    if (accountDetailModel.bankBranch == null ||
        accountDetailModel.bankBranch.isEmpty) {
      Util.showValidationdialog(context, 'Please enter branch name');
      return false;
    }
    if (accountDetailModel.state == null || accountDetailModel.state.isEmpty) {
      Util.showValidationdialog(context, 'Please enter state');
      return false;
    }
    return true;
  }

  Future<void> getAccountDetails(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var user = await Util.read(Constant.LoginResponse);
    loginResponse = LoginResponseModel.fromJson(user);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.getAccountDetail + '?userId=${loginResponse.id}',
        requestBody: {'userId': loginResponse.id});
    print(response);
    if (json.encode(response["ResponsePacket"]) != 'null') {
      accountDetailModel =
          AccountDetailModel.fromJson(response["ResponsePacket"]);
      setState(() {});
    }
  }
}
