import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:flutter/material.dart';

class RunningMatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.questionnaire);
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: 'IND',
                        color: ColorUtils.green,
                        textSize: 12,
                        fontWeight: FontStyles.bold,
                      ),
                      Expanded(child: Container()),
                      TextWidget(
                        text: 'PAK',
                        color: ColorUtils.green,
                        textSize: 12,
                        fontWeight: FontStyles.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(ImageUtils.homeBg))),
                      ),
                      TextWidget(text: 'Live'),
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(ImageUtils.homeBg))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: ColorUtils.lightGrey,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextWidget(
                    text: '250 people',
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
