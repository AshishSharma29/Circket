import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContestScreen extends StatefulWidget {
  Map<String, String> argument;

  MyContestScreen(this.argument);

  @override
  _MyContestScreenState createState() => _MyContestScreenState();
}

class _MyContestScreenState extends State<MyContestScreen> {
  CricketProvider cricketProvider;
  List<ContestModel> contestList;
  SharedPreferences prefs;
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
    if (isLoading) getMyContestList(context, widget.argument['matchId']);
    return Container(
      child: contestList == null
          ? Util().getLoader()
          : contestList.length == 0
              ? Center(
                  child: TextWidget(
                    text: 'No data found',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteNames.questionnaire, arguments: {
                          'contestId': contestList[index].id.toString(),
                          'contestTitle':
                              contestList[index].tournamentTitle.toString()
                        });
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              TextWidget(
                                text: '${contestList[index].matchTitle}',
                                color: ColorUtils.green,
                                textSize: 18,
                                fontWeight: FontStyles.bold,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '${Constant.IMAGE_URL}${contestList[index].team1Icon}'))),
                                  ),
                                  TextWidget(
                                      text:
                                          '${contestList[index].startTime.replaceAll("T", ' ')}'),
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '${Constant.IMAGE_URL}${contestList[index].team2Icon}'))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextWidget(
                                    text:
                                        'Entry ${contestList[index].entryFee}',
                                  ),
                                  TextWidget(
                                    text: 'Prize ${contestList[index].prize}',
                                  ),
                                  TextWidget(
                                    text:
                                        'Maximum Entry ${contestList[index].maxEntry}',
                                  ),
                                  TextWidget(
                                    text:
                                        'Winner ${contestList[index].maxWinner}',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> getMyContestList(BuildContext context, String matchId) async {
    isLoading = true;
    var userModel = await Util.read(Constant.LoginResponse);
    contestList = await cricketProvider.getMyConstestList(
        context, matchId, userModel['Id'].toString());
    print(contestList);
    isLoading = false;
    setState(() {});
  }
}
