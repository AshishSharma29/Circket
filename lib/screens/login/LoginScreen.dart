import 'dart:convert';

import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Image.asset(
                ImageUtils.appBg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        ImageUtils.backArrow,
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    ImageUtils.logo,
                    height: 120,
                    width: 360,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextWidget(
                    text: 'Enter mobile number \nand login',
                    textSize: 24,
                    textAlign: TextAlign.center,
                    color: ColorUtils.white,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(ImageUtils.textbox)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextWidget(
                              text: '+91',
                              textSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 15,
                                controller: mobileController,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  counterText: '',
                                  hintText: 'Mobile number',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(ImageUtils.playButton),
                              ),
                            ),
                            child: TextWidget(
                              text: "Login",
                              textAlign: TextAlign.center,
                              textSize: 16,
                              color: ColorUtils.white,
                              fontWeight: FontStyles.bold,
                            ) // button text
                            ),
                      ),
                      onTap: () {
                        if (mobileController.text.isEmpty) {
                          Util.showValidationdialog(
                              context, Strings.emptyPhoneNumberValidation);
                        } else if (mobileController.text.length < 7) {
                          Util.showValidationdialog(
                              context, Strings.validPhoneNumberValidation);
                        } else {
                          sendOtp(mobileController.text, true);
                        }
                      }),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController _pinEditingController = TextEditingController(text: '');
  ColorBuilder _solidColor =
      PinListenColorBuilder(Colors.grey, Colors.grey[400]);
  TextEditingController referralController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void showVerificationScreen() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
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
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                text: Strings.verification,
                                textSize: 24,
                                fontWeight: FontStyles.bold,
                                color: ColorUtils.white,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                textAlign: TextAlign.center,
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                text:
                                    'code has been sent On ${mobileController.text}',
                                textSize: 18,
                                fontWeight: FontStyles.regular,
                                color: ColorUtils.white,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              PinInputTextField(
                                pinLength: 6,
                                decoration: BoxLooseDecoration(
                                  strokeColorBuilder: PinListenColorBuilder(
                                      ColorUtils.white, ColorUtils.white),
                                  bgColorBuilder: _solidColor,
                                  obscureStyle: ObscureStyle(
                                    isTextObscure: true,
                                    obscureText: '*',
                                  ),
                                  hintText: '000000',
                                ),
                                controller: _pinEditingController,
                                textInputAction: TextInputAction.go,
                                enabled: true,
                                keyboardType: TextInputType.number,
                                textCapitalization:
                                    TextCapitalization.characters,
                                onSubmit: (pin) {
                                  debugPrint('submit pin:$pin');
                                },
                                onChanged: (pin) {
                                  debugPrint('onChanged execute. pin:$pin');
                                },
                                enableInteractiveSelection: false,
                                cursor: Cursor(
                                  width: 2,
                                  color: ColorUtils.colorAccent,
                                  radius: Radius.circular(1),
                                  enabled: true,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextField(
                                maxLength: 8,
                                textAlign: TextAlign.center,
                                controller: referralController,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Referral code(Optional)',
                                    hintStyle:
                                        TextStyle(color: ColorUtils.white)),
                                style: TextStyle(color: ColorUtils.white),
                                cursorColor: ColorUtils.white,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                textAlign: TextAlign.center,
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                text: Strings.didNotReceiveCode,
                                textSize: 12,
                                fontWeight: FontStyles.regular,
                                color: ColorUtils.white,
                              ),
                              InkWell(
                                onTap: () {
                                  sendOtp(mobileController.text, false);
                                },
                                child: TextWidget(
                                  textAlign: TextAlign.center,
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  text: Strings.requestAgain,
                                  textSize: 16,
                                  fontWeight: FontStyles.bold,
                                  color: ColorUtils.white,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80.0),
                                    child: Container(
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
                                          text: "Verify",
                                          textAlign: TextAlign.center,
                                          textSize: 16,
                                          color: ColorUtils.white,
                                          fontWeight: FontStyles.bold,
                                        ) // button text
                                        ),
                                  ),
                                  onTap: () {
                                    verifyOtp(_pinEditingController.text,
                                        context, '+91' + mobileController.text);
                                  }),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  String smsCode;
  String verificationID;
  int resendToken;

  sendOtp(String number, bool bool) async {
    Util.showProgress(context);

    isLoading = true;
    setState(() {});
    FirebaseAuth.instance
        .verifyPhoneNumber(
          phoneNumber: '+91' + number,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
            smsCode = credential.smsCode;
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: (String verificationId, int resendToken) {
            Navigator.of(context).pop();
            this.verificationID = verificationId;
            this.resendToken = resendToken;
            if (bool) {
              showVerificationScreen();
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            Navigator.of(context).pop();
            Util.showValidationdialog(context, 'Please try again');
          },
        )
        .then((value) => {});
  }

  SharedPreferences prefs;

  verifyOtp(String otp, BuildContext context, String number) async {
    if (otp == null || otp.length < 6) {
      Util.showValidationdialog(context, 'Please enter OTP');
      return;
    }
    Util.showProgress(context);
    isLoading = true;
    setState(() {});
    prefs = await SharedPreferences.getInstance();
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    // Sign the user in (or link) with the credential
    try {
      await auth
          .signInWithCredential(phoneAuthCredential)
          .then((value) async => {
                NetworkUtil.callPostApi(
                    context: context,
                    apiName: ApiConstant.authentication,
                    requestBody: {
                      'MobileNumber': number,
                      'ReferralCode': referralController.text.toString()
                    }).then((value) => {
                      isLoading = false,
                      setState(() {}),
                      prefs.setString(Constant.LoginResponse,
                          json.encode(value["ResponsePacket"])),
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.home, (route) => false)
                    })
              });
    } catch (ex) {
      print(ex.toString());
      Util.showValidationdialog(context, ex.message);
    }
  }
}
