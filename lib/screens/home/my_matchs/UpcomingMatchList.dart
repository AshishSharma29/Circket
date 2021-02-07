import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
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
  var cricketProvider;

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
      child: matchList == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: LinearProgressIndicator()))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: matchList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.contest,
                        arguments: {
                          'matchId': matchList[index].matchId.toString()
                        });
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextWidget(
                            text: '${matchList[index].matchTitle}',
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
                                            '${matchList[index].team1Icon}'))),
                              ),
                              TextWidget(text: '${matchList[index].startTime}'),
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${matchList[index].team2Icon}'))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  List<MatchModel> matchList;

  Future<void> getMatchList(BuildContext context) async {
    isLoading = true;
    matchList = await cricketProvider.getMatchList(context);
    print(matchList);
    isLoading = false;
    setState(() {});
  }
}
