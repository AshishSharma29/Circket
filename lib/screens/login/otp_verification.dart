import 'dart:convert';

import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerification extends StatefulWidget {
  Map<String, String> arguments;

  OtpVerification(this.arguments);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  FocusNode _focusNode1 = FocusNode(),
      _focusNode2 = FocusNode(),
      _focusNode3 = FocusNode(),
      _focusNode4 = FocusNode(),
      _focusNode5 = FocusNode(),
      _focusNode6 = FocusNode();
  TextEditingController one = TextEditingController(),
      two = TextEditingController(),
      three = TextEditingController(),
      four = TextEditingController(),
      five = TextEditingController(),
      six = TextEditingController();

  bool color1 = false,
      color2 = false,
      color3 = false,
      color4 = false,
      color5 = false,
      color6 = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color1 = true;
    color2 = true;
    color3 = true;
    color4 = true;
    color5 = true;
    color6 = true;
    Future.delayed(Duration.zero, () {
      sendOtp(widget.arguments[Constant.mobileNumber]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = widget.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
                // child: Image.asset(
                //   ImageUtils.forgotPasswordBg,
                //   fit: BoxFit.cover,
                // ),
                // width: double.infinity,
                ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextWidget(
                      text: Strings.verification,
                      textSize: 20,
                      fontWeight: FontStyles.light,
                      color: ColorUtils.green,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      text: 'On ${args[Constant.mobileNumber]}',
                      textSize: 18,
                      fontWeight: FontStyles.regular,
                      color: ColorUtils.white,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: one,
                            focusNode: _focusNode1,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color1
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) {
                              if (data.isNotEmpty) {
                                _focusNode1.unfocus();
                                _focusNode2.requestFocus();
                              }
                              setState(() {
                                color1 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: two,
                            focusNode: _focusNode2,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color2
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) {
                              if (data.isEmpty) {
                                _focusNode2.unfocus();
                                _focusNode1.requestFocus();
                              } else {
                                _focusNode3.requestFocus();
                              }
                              setState(() {
                                color2 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: three,
                            focusNode: _focusNode3,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color3
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) {
                              if (data.isEmpty) {
                                _focusNode3.unfocus();
                                _focusNode2.requestFocus();
                              } else {
                                _focusNode4.requestFocus();
                              }
                              setState(() {
                                color3 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: four,
                            focusNode: _focusNode4,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color4
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) {
                              if (data.isEmpty) {
                                _focusNode4.unfocus();
                                _focusNode3.requestFocus();
                              } else {
                                _focusNode5.requestFocus();
                              }
                              setState(() {
                                color4 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: five,
                            focusNode: _focusNode5,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color5
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) {
                              if (data.isEmpty) {
                                _focusNode5.unfocus();
                                _focusNode4.requestFocus();
                              } else {
                                _focusNode6.requestFocus();
                              }
                              setState(() {
                                color5 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: six,
                            focusNode: _focusNode6,
                            maxLength: 1,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: color6
                                  ? ColorUtils.lightGrey
                                  : ColorUtils.otpBg,
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15),
                                  fontSize: 40),
                              hintText: '0',
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (data) async {
                              if (data.isEmpty) {
                                _focusNode6.unfocus();
                                _focusNode5.requestFocus();
                              } else {
                                verifyOtp(
                                    one.text +
                                        two.text +
                                        three.text +
                                        four.text +
                                        five.text +
                                        six.text,
                                    context,
                                    args[Constant.mobileNumber]);
                              }
                              setState(() {
                                color6 = !data.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      text: Strings.didNotReceiveCode,
                      textSize: 18,
                      fontWeight: FontStyles.regular,
                      color: ColorUtils.white,
                    ),
                    InkWell(
                      onTap: () {
                        // resendOtp(args['email']);
                      },
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        text: Strings.requestAgain,
                        textSize: 18,
                        fontWeight: FontStyles.regular,
                        color: ColorUtils.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String smsCode;
  String verificationID;
  int resendToken;

  sendOtp(String number) async {
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
            this.verificationID = verificationId;
            this.resendToken = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        )
        .then((value) => {});
  }

  verifyOtp(String otp, BuildContext context, String number) async {
    prefs = await SharedPreferences.getInstance();
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    // Sign the user in (or link) with the credential
    try {
      await auth
          .signInWithCredential(phoneAuthCredential)
          .then((value) async => {
                NetworkUtil
                    .callPostApi(
                        context: context,
                        apiName: ApiConstant.authentication,
                        requestBody: {"MobileNumber": number}).then((value) => {
                      prefs.setString(Constant.LoginResponse,
                          json.encode(value["ResponsePacket"])),
                      Navigator.of(context).pushNamed(
                        RouteNames.home,
                      )
                    })
              });
    } catch (ex) {
      print(ex.toString());
      Util.showValidationdialog(context, ex.message);
    }
  }

  getColor() {
    setState(() {});
  }
}
