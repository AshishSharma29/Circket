import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                child: Image.asset(
              ImageUtils.appBg,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
            Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  ImageUtils.img,
                  height: 360,
                )),
            Container(
              /*decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageUtils.appBg,
                    ),
                    fit: BoxFit.cover),
              ),*/
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      ImageUtils.text,
                      height: 260,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageUtils.playButton),
                            ),
                          ),
                          child: TextWidget(
                            text: "Play Now",
                            textAlign: TextAlign.center,
                            textSize: 16,
                            color: ColorUtils.white,
                            fontWeight: FontStyles.bold,
                          ) // button text
                          ),
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteNames.login);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
