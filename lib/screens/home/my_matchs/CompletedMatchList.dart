import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:flutter/material.dart';

class CompletedMatchList extends StatelessWidget {
  const CompletedMatchList({
    Key key,
  }) : super(key: key);

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
                    textAlign: TextAlign.center,
                    text: 'IND VS PAK',
                    color: ColorUtils.green,
                    textSize: 18,
                    fontWeight: FontStyles.bold,
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
                      TextWidget(text: 'Match status'),
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
                  SizedBox(height: 8,),
                  SizedBox(width: double.infinity,
                  height: 1,
                  child: Container(color: ColorUtils.lightGrey,),)
                  ,
                  SizedBox(height: 8,),
                  TextWidget(text: '  You won 20 \$',
                  color: ColorUtils.green,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
