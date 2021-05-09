import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/my_matchs/match_row_common.dart';
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
                  color: ColorUtils.white,
                  textSize: 18,
                  fontWeight: FontStyles.bold,
                  text: 'No running match',
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
                        'flag1': matchList[index].team1Icon.toString(),
                        'flag2': matchList[index].team2Icon.toString(),
                      });
                    },
                    child: MatchRowCommon(match: matchList[index]),
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
