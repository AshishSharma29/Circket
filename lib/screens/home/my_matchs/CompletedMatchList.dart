import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/my_matchs/match_row_common.dart';
import 'package:cricquiz11/util/MatchStatus.dart';
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
                    child: MatchRowCommon(match: matchList[index]),
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
