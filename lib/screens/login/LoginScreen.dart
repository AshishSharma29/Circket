import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.login,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  ImageUtils.logoLogin,
                  height: 150,
                  width: 150,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 15,
                  controller: mobileController,
                  decoration: InputDecoration(
                    hintText: 'Mobile number',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(12),
                  onPressed: () {
                    if (mobileController.text.isEmpty) {
                      Util.showValidationdialog(
                          context, Strings.emptyPhoneNumberValidation);
                    } else if (mobileController.text.length < 7) {
                      Util.showValidationdialog(
                          context, Strings.validPhoneNumberValidation);
                    } else
                      Navigator.of(context)
                          .pushNamed(RouteNames.otpVerification, arguments: {
                        Constant.mobileNumber: mobileController.text
                      });
                  },
                  color: ColorUtils.colorPrimary,
                  child: TextWidget(
                    color: ColorUtils.white,
                    text: 'Login',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
