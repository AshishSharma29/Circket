import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/util/DashedLine.dart';
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
      shadowColor: ColorUtils.colorPrimary,
      elevation: 2,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 8,
            ),
            TextWidget(
              padding: const EdgeInsets.all(4.0),
              textAlign: TextAlign.center,
              text: '${match.tournamentTitle}',
              color: ColorUtils.black,
              textSize: 16,
              fontWeight: FontStyles.semiBold,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
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
                  ClipOval(
                    child: Container(
                      color: ColorUtils.vColor,
                      height: 40.0,
                      width: 40.0,
                      child: Center(
                          child: Text(
                        'V',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${Constant.IMAGE_URL}${match.team2Icon}'))),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            TextWidget(
                              text:
                                  '${match.team2Title.substring(0, 3).toUpperCase()}',
                              color: ColorUtils.black,
                              fontWeight: FontStyles.bold,
                              textSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            DashedLine(
              height: 1,
              color: ColorUtils.darkerGrey,
            ),
            SizedBox(
              height: 8,
            ),
            TextWidget(
              textAlign: TextAlign.center,
              text: '${match.status}',
              color: ColorUtils.black,
              fontWeight: FontStyles.bold,
              textSize: 16,
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 15.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
