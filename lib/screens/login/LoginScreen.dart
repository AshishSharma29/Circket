import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/cupertino.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(0.8, 0.0),
                // 10% of the width, so there are ten blinds.
                colors: [ColorUtils.green, ColorUtils.green, ColorUtils.green],
                // red to yellow
                tileMode:
                    TileMode.clamp, // repeats the gradient over the canvas
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    ImageUtils.APP_LOGO_BANNER,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    controller: mobileController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      counterText: '',
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
