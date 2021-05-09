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

class UpcomingMatchList extends StatefulWidget {
  const UpcomingMatchList({
    Key key,
  }) : super(key: key);

  @override
  _UpcomingMatchListState createState() => _UpcomingMatchListState();
}

class _UpcomingMatchListState extends State<UpcomingMatchList> {
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
    if (isLoading) getMatchList(context);

    return Container(
      child: isLoading
          ? Util().getLoader()
          : matchList.length == 0
              ? Center(
                  child: TextWidget(
                    color: ColorUtils.white,
                    textSize: 18,
                    fontWeight: FontStyles.bold,
                    text: 'No upcoming match',
                  ),
                )
              : ListView.builder(
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
                          'isUpcoming': true,
                          'flag1': matchList[index].team1Icon.toString(),
                          'flag2': matchList[index].team2Icon.toString(),
                        });
                      },
                      child: MatchRowCommon(match: matchList[index]),
                    );
                  },
                ),
    );
  }

  List<MatchModel> matchList;

  Future<void> getMatchList(BuildContext context) async {
    isLoading = true;
    matchList = await cricketProvider.getMyMatch(
        context, MatchStatus.UP_COMING_MATCH, '1');
    print(matchList);
    isLoading = false;
    setState(() {});
  }
}
