import 'dart:convert';

import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'connectivity.dart';
import 'constant.dart';

class NetworkUtil {
  static Future<dynamic> callGetApi(
      {BuildContext context, String apiName}) async {
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    if (isNetActive) {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(Constant.TOKEN);
      final response = await http.get(
        Constant.BASE_URL + apiName,
        headers: {'apikey': '69d4c80b7301fbd05fce00c75f262cf4', 'token': token},
      );
      return jsonDecode(response.body);
    } else {
      Navigator.of(context).pop();
      Util.showValidationdialog(context, Strings.noInternet);
      return null;
    }
  }

  static String getMessage(dynamic response) {
    return response['Message'];
  }

  static bool isSuccess(dynamic response) {
    return response['StatusCode'] == 200;
  }

  static Future<dynamic> callPostApi(
      {BuildContext context, String apiName, dynamic requestBody}) async {
    print(requestBody);
    bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
    if (isNetActive) {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(Constant.TOKEN);
      final response = await http.post(Constant.BASE_URL + apiName,
          headers: {
            'apikey': '69d4c80b7301fbd05fce00c75f262cf4',
            'token': token
          },
          body: requestBody);
      print(response.body);
      return jsonDecode(response.body);
    } else {
      Navigator.of(context).pop();
      Util.showValidationdialog(context, Strings.noInternet);
      return null;
    }
  }
}