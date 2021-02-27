import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/LoginResponseModel.dart';
import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
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
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 8),
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
              Text(
                'Confirmation',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available coins',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  loginResponseModel == null
                      ? CircularProgressIndicator()
                      : Text(
                          loginResponseModel.balance.toString(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
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
                    'Required coins',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.contestModel.entryFee.toString(),
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
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
                    'Remaining',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  loginResponseModel == null
                      ? CircularProgressIndicator()
                      : Text(
                          (loginResponseModel.balance -
                                  widget.contestModel.entryFee)
                              .toString(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    color: ColorUtils.colorPrimary,
                    onPressed: () {
                      joinContest(context, widget.contestModel.id.toString());
                    },
                    child: Text(
                      'Start',
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

  Future<void> joinContest(BuildContext context, String contestId) async {
    Util.showProgress(context);
    var response = await cricketProvider.joinContest(context, contestId);
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
    setState(() {});
  }
}
