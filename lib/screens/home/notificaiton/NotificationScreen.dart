import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          child: Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextWidget(
                    text: '22 Oct 2020',
                    color: ColorUtils.black,
                    textSize: 12,
                    textAlign: TextAlign.end,
                    fontWeight: FontStyles.bold,
                  ),
                  TextWidget(
                    text: 'Notification title',
                    color: ColorUtils.black,
                    textSize: 18,
                    fontWeight: FontStyles.bold,
                  ),
                  TextWidget(
                    text: 'Notification description',
                    color: ColorUtils.darkGrey,
                    textSize: 14,
                    fontWeight: FontStyles.regular,
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