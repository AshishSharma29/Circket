import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinContest extends StatefulWidget {
  ContestModel contestModel;

  JoinContest(this.contestModel);

  @override
  _JoinContestState createState() => _JoinContestState();
}

class _JoinContestState extends State<JoinContest> {
  LoginResponseModel loginResponseModel;
  SharedPreferences prefs;
  CricketProvider cricketProvider;

  @override
  Widget build(BuildContext context) {
    cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    getUserData();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.green,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.confirmation,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: ColorUtils.colorPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.balance,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorUtils.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  loginResponseModel == null
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            Text(
                              (loginResponseModel.balance).ceil().toString(),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              ImageUtils.coin,
                              height: 15,
                              width: 15,
                            )
                          ],
                        ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.entry,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.contestModel.entryFee.ceil().toString(),
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        ImageUtils.coin,
                        height: 15,
                        width: 15,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 2,
                color: ColorUtils.darkerGrey,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'By joining the contest you accept Cricquiz11 T&C.',
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0)),
                    color: ColorUtils.colorPrimary,
                    onPressed: () {
                      joinContest(context, widget.contestModel);
                    },
                    child: Text(
                      'Join now',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 16,
            child: ClipRRect(),
          ),
        )
      ],
    );
  }

  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    var user = await Util.read(Constant.LoginResponse);
    loginResponseModel = LoginResponseModel.fromJson(user);
    setState(() {});
  }

  Future<void> joinContest(
      BuildContext context, ContestModel contestModel) async {
    Util.showProgress(context);
    var response =
        await cricketProvider.joinContest(context, contestModel.id.toString());
    print(response);
    Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(RouteNames.questionnaire, arguments: {
      'contestId': response.responsePacket.contestantId.toString(),
      'contestTitle': contestModel.tournamentTitle.toString()
    });
    setState(() {});
  }
}
