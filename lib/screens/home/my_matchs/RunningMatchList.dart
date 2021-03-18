import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/util/MatchStatus.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CricketProvider.dart';

class RunningMatchList extends StatefulWidget {
  @override
  _RunningMatchListState createState() => _RunningMatchListState();
}

class _RunningMatchListState extends State<RunningMatchList> {
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
    var loginResponse = Util.read(Constant.LoginResponse);
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    if (isLoading) getRunningMatchList(context);
    return isLoading
        ? Util().getLoader()
        : matchList.length == 0
            ? Center(
                child: TextWidget(
                  text: 'No upcoming match',
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: matchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.contest_tab, arguments: {
                        'matchId': matchList[index].matchId.toString(),
                        'matchTitle':
                            matchList[index].tournamentTitle.toString(),
                      });
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
                                  text: matchList[index].team1Title,
                                  color: ColorUtils.green,
                                  textSize: 12,
                                  fontWeight: FontStyles.bold,
                                ),
                                Expanded(child: Container()),
                                TextWidget(
                                  text: matchList[index].team2Title,
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

  List<MatchModel> matchList;

  Future<void> getRunningMatchList(BuildContext context) async {
    isLoading = true;
    matchList =
        await cricketProvider.getMyMatch(context, MatchStatus.LIVE_MATCH, '1');
    print(matchList);
    isLoading = false;
    setState(() {});
  }
}
