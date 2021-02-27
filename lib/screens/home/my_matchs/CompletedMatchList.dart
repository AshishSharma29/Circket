import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/MatchStatus.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedMatchList extends StatefulWidget {
  const CompletedMatchList({
    Key key,
  }) : super(key: key);

  @override
  _CompletedMatchListState createState() => _CompletedMatchListState();
}

class _CompletedMatchListState extends State<CompletedMatchList> {
  CricketProvider cricketProvider;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    if (isLoading) getCompletedMatchList(context);
    return isLoading
        ? Util().getLoader()
        : matchList.length == 0
            ? Center(
                child: TextWidget(
                  text: 'No match completed',
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: matchList.length,
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
                              text:
                                  '${matchList[index].team1Title} VS ${matchList[index].team2Title}',
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
                                          image: NetworkImage(
                                              '${Constant.IMAGE_URL}${matchList[index].team1Icon}'))),
                                ),
                                TextWidget(text: matchList[index].status),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${Constant.IMAGE_URL}${matchList[index].team2Icon}'))),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: Container(
                                color: ColorUtils.lightGrey,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextWidget(
                              text: '  You won 20 \$',
                              color: ColorUtils.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
  }

  List<MatchModel> matchList;

  Future<void> getCompletedMatchList(BuildContext context) async {
    isLoading = true;
    matchList = await cricketProvider.getMyMatch(
        context, MatchStatus.COMPLETED_MATCH, '1');
    print(matchList);
    isLoading = false;
    setState(() {});
  }
}
