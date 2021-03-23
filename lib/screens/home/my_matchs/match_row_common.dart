import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:flutter/material.dart';

class MatchRowCommon extends StatelessWidget {
  const MatchRowCommon({
    Key key,
    @required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              textAlign: TextAlign.start,
              text: '${match.tournamentTitle}',
              color: ColorUtils.darkerGrey,
              textSize: 12,
              fontWeight: FontStyles.regular,
            ),
            Divider(
              color: ColorUtils.darkGrey,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextWidget(
                        textAlign: TextAlign.start,
                        text: '${match.team1Title}',
                        color: ColorUtils.black,
                        textSize: 12,
                        fontWeight: FontStyles.regular,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${Constant.IMAGE_URL}${match.team1Icon}'))),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(
                            text:
                                '${match.team1Title.substring(0, 3).toUpperCase()}',
                            color: ColorUtils.black,
                            fontWeight: FontStyles.bold,
                            textSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextWidget(
                        textAlign: TextAlign.center,
                        text: '${match.status}',
                        color: ColorUtils.colorAccent,
                        fontWeight: FontStyles.bold,
                        textSize: 12,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextWidget(
                        textAlign: TextAlign.end,
                        text: '${match.team2Title}',
                        color: ColorUtils.black,
                        textSize: 12,
                        fontWeight: FontStyles.regular,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextWidget(
                            text:
                                '${match.team2Title.substring(0, 3).toUpperCase()}',
                            color: ColorUtils.black,
                            fontWeight: FontStyles.bold,
                            textSize: 12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${Constant.IMAGE_URL}${match.team2Icon}'))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
