import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/my_matchs/match_row_common.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CricketProvider cricketProvider;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loginResponse = Util.read(Constant.LoginResponse);
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    if (isLoading) getMatchList(context);
    return Stack(
      children: [
        Container(
          child: Image.asset(
            ImageUtils.appBg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Util.closeApplication(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      ImageUtils.backArrow,
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                TextWidget(
                  padding: const EdgeInsets.all(24),
                  color: ColorUtils.white,
                  textSize: 18,
                  text: Strings.home,
                  fontWeight: FontStyles.bold,
                ),
                SizedBox(
                  width: 48,
                )
              ],
            ),
            Container(
              child: matchList == null
                  ? Util().getLoader()
                  : matchList.length == 0
                      ? Center(
                          child: TextWidget(
                            color: ColorUtils.white,
                            textSize: 24,
                            text: 'No match found',
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: matchList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RouteNames.contest_tab,
                                      arguments: {
                                        'matchId':
                                            matchList[index].matchId.toString(),
                                        'matchTitle': matchList[index]
                                            .tournamentTitle
                                            .toString(),
                                        'flag1': matchList[index]
                                            .team1Icon
                                            .toString(),
                                        'flag2': matchList[index]
                                            .team2Icon
                                            .toString(),
                                        'isUpcoming': true,
                                      });
                                },
                                child: MatchRowCommon(match: matchList[index]),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ],
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
