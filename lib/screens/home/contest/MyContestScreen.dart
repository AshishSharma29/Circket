import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyContestScreen extends StatefulWidget {
  Map<String, String> argument;

  MyContestScreen(this.argument);

  @override
  _MyContestScreenState createState() => _MyContestScreenState();
}

class _MyContestScreenState extends State<MyContestScreen> {
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
    if (isLoading) getMyContestList(context, widget.argument['matchId']);
    return Container(
      child: contestList == null
          ? Util().getLoader()
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: contestList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
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
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  List<ContestModel> contestList;

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
