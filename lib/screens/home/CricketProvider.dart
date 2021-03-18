import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/model/contest_join_response.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';

class CricketProvider with ChangeNotifier {
  List<ContestModel> contestList;

  Future<List<MatchModel>> getAllMatchList(BuildContext context) async {
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.getAllMatch,
        requestBody: {"UserId": '0', "Status": '1', "Page": '1'});
    if (response['ResponsePacket'] != null) {
      print(response['ResponsePacket']);

      var matchListUpcomingMatch = response['ResponsePacket'] != null
          ? (response['ResponsePacket'] as List)
              .map<MatchModel>((json) => MatchModel.fromJson(json))
              .toList()
          : List();
      return matchListUpcomingMatch;
    } else
      return List();
  }

  Future<List<ContestModel>> getConstestList(
      BuildContext context, String matchId) async {
    var response = await NetworkUtil.callGetApi(
        context: context, apiName: ApiConstant.getAllContest + '/$matchId');
    if (response['ResponsePacket'] != null) {
      print(response['ResponsePacket']);
      contestList = (response['ResponsePacket'] as List)
          .map<ContestModel>((json) => ContestModel.fromJson(json))
          .toList();
      return contestList;
    } else
      return List();
  }

  Future<List<ContestModel>> getMyConstestList(
      BuildContext context, String matchId, String userId) async {
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.myContest,
        requestBody: {'MatchId': matchId, 'UserId': userId});
    if (response != null) {
      print(response['ResponsePacket']);
      if (response['ResponsePacket'] == null) {
        contestList = List();
        return contestList;
      }
      contestList = (response['ResponsePacket'] as List)
          .map<ContestModel>((json) => ContestModel.fromJson(json))
          .toList();
      return contestList;
    }
  }

  Future<ContestJoinResponseModel> joinContest(
      BuildContext context, String contestId) async {
    var userModel = await Util.read(Constant.LoginResponse);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.joinContest,
        requestBody: {
          'ContestId': contestId,
          'UserId': userModel['Id'].toString()
        });
    if (response != null) {
      return ContestJoinResponseModel.fromJson(response);
    }
  }

  Future<List<MatchModel>> getMyMatch(
      BuildContext context, String status, String pageNumber) async {
    var userModel = await Util.read(Constant.LoginResponse);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.getAllMatch,
        requestBody: {
          "UserId": userModel['Id'].toString(),
          "Status": status,
          "Page": pageNumber
        });

    List<MatchModel> matchListUpcomingMatch = response['ResponsePacket'] != null
        ? (response['ResponsePacket'] as List)
            .map<MatchModel>((json) => MatchModel.fromJson(json))
            .toList()
        : List();
    return matchListUpcomingMatch;
  }
}
