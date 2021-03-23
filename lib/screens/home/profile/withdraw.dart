import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String amount;

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
                      text: '1000',
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
  }
}
