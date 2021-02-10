import 'dart:convert';

import 'package:cricquiz11/common_widget/ColorLoader.dart';
import 'package:cricquiz11/common_widget/DotType.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static final Util _singleton = Util._internal();

  factory Util() {
    return _singleton;
  }

  Util._internal();
  static void showValidationdialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(Strings.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(Strings.appName),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget getLoader() {
    return ColorLoader(
      dotOneColor: Colors.pink,
      dotTwoColor: Colors.amber,
      dotThreeColor: Colors.deepOrange,
      dotType: DotType.square,
      duration: Duration(seconds: 2),
    );
  }

  static void showProgress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black26,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool alphaNumericValidator(String value, String message) {
    return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value);
  }

  static Future<DateTime> selectDate(
      BuildContext context, DateTime selectedDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null ? DateTime.now() : selectedDate,
        firstDate: DateTime.now().add(Duration(days: -365)),
        lastDate: DateTime.now());
    if (picked != null) return selectedDate;
  }

  static Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null)
      return null;
    else
      return json.decode(prefs.getString(key));
  }
}
