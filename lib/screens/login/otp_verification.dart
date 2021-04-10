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

import '../../util/util.dart';

class OtpVerification extends StatefulWidget {
  Map<String, String> arguments;

  OtpVerification(this.arguments);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController referralController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      sendOtp(widget.arguments[Constant.mobileNumber]);
    });
  }

  TextEditingController _pinEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var args = widget.arguments;
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset(
                ImageUtils.greenBg,
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
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Image.asset(
                                ImageUtils.APP_LOGO_BANNER,
                                height: 120,
                                width: 360,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                text: Strings.verification,
                                textSize: 24,
                                fontWeight: FontStyles.bold,
                                color: ColorUtils.colorPrimary,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                textAlign: TextAlign.center,
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                text:
                                    'code has been sent On ${args[Constant.mobileNumber]}',
                                textSize: 18,
                                fontWeight: FontStyles.regular,
                                color: ColorUtils.black,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              PinInputTextField(
                                pinLength: 6,
                                decoration: BoxLooseDecoration(
                                  strokeColorBuilder: PinListenColorBuilder(
                                      ColorUtils.colorPrimary,
                                      ColorUtils.colorAccent),
                                  /*bgColorBuilder: _solidEnable ? _solidColor : null,*/
                                  obscureStyle: ObscureStyle(
                                    isTextObscure: true,
                                    obscureText: '*',
                                  ),
                                  hintText: '000000',
                                ),
                                controller: _pinEditingController,
                                textInputAction: TextInputAction.go,
                                enabled: true,
                                keyboardType: TextInputType.text,
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
                                controller: referralController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'Referral code(Optional)',
                                ),
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
                                color: ColorUtils.colorAccent,
                              ),
                              InkWell(
                                onTap: () {
                                  sendOtp(
                                      widget.arguments[Constant.mobileNumber]);
                                },
                                child: TextWidget(
                                  textAlign: TextAlign.center,
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  text: Strings.requestAgain,
                                  textSize: 16,
                                  fontWeight: FontStyles.bold,
                                  color: ColorUtils.colorAccent,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    isLoading
                        ? Util().getLoader()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.all(12),
                                onPressed: () {
                                  verifyOtp(_pinEditingController.text, context,
                                      '+91' + args[Constant.mobileNumber]);
                                },
                                color: ColorUtils.colorAccent,
                                child: TextWidget(
                                  color: ColorUtils.white,
                                  text: 'Verify',
                                  textSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 16,
                    )
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
  bool isLoading = false;

  sendOtp(String number) async {
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
            this.verificationID = verificationId;
            this.resendToken = resendToken;
            isLoading = false;
            setState(() {});
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        )
        .then((value) => {});
  }

  verifyOtp(String otp, BuildContext context, String number) async {
    if (otp == null || otp.length < 6) {
      Util.showValidationdialog(context, 'Please enter OTP');
      return;
    }
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

  getColor() {
    setState(() {});
  }
}
