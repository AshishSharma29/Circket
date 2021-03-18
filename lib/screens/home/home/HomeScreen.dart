import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: matchList == null
          ? Util().getLoader()
          : matchList.length == 0
              ? Center(
                  child: TextWidget(
                    text: 'No match found',
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
                              matchList[index].tournamentTitle.toString()
                        });
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                textAlign: TextAlign.start,
                                text: '${matchList[index].tournamentTitle}',
                                color: ColorUtils.green,
                                textSize: 16,
                                fontWeight: FontStyles.bold,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
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
                                      SizedBox(
                                        width: 16,
                                      ),
                                      TextWidget(
                                        text: '${matchList[index].team1Title}',
                                        color: ColorUtils.black,
                                        textSize: 12,
                                        fontWeight: FontStyles.bold,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                    text: '${matchList[index].status}',
                                    color: ColorUtils.colorPrimary,
                                    fontWeight: FontStyles.bold,
                                  ),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: '${matchList[index].team2Title}',
                                        color: ColorUtils.black,
                                        textSize: 12,
                                        fontWeight: FontStyles.bold,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
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
    matchList = await cricketProvider.getAllMatchList(context);
    print(matchList);
    isLoading = false;
    setState(() {});
  }
}
