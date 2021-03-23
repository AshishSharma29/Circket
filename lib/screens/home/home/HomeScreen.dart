import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/home/my_matchs/match_row_common.dart';
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
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  bool isLoading = false;
  AdmobReward rewardAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    autherization();
  }

  void autherization() async {
    if (Platform.isIOS) await Admob.requestTrackingAuthorization();
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );

    rewardAd.load();
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rewardAd.dispose();
  }

  String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      // return 'ca-app-pub-3940256099942544/1712485313';
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-5307290955516221/9987431770';
    }
    return null;
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
                      child: MatchRowCommon(match: matchList[index]),
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
