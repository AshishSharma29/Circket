import 'package:cricquiz11/model/ContestModel.dart';
import 'package:cricquiz11/model/MatchModel.dart';
import 'package:cricquiz11/model/contest_join_response.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';

class CricketProvider with ChangeNotifier {
  List<MatchModel> matchList;
  List<ContestModel> contestList;

  Future<List<MatchModel>> getMatchList(BuildContext context) async {
    var response = await NetworkUtil.callGetApi(
        context: context, apiName: ApiConstant.getAllMatch);
    if (response != null) {
      print(response['ResponsePacket']);
      matchList = (response['ResponsePacket'] as List)
          .map<MatchModel>((json) => MatchModel.fromJson(json))
          .toList();

      var matchListUpcomingMatch = matchList
          .where((element) => element.status.contains('Upcoming'))
          .toList();

      return matchListUpcomingMatch;
    }
  }

  Future<List<ContestModel>> getConstestList(
      BuildContext context, String matchId) async {
    var response = await NetworkUtil.callGetApi(
        context: context, apiName: ApiConstant.getAllContest + '/$matchId');
    if (response != null) {
      print(response['ResponsePacket']);
      contestList = (response['ResponsePacket'] as List)
          .map<ContestModel>((json) => ContestModel.fromJson(json))
          .toList();
      return contestList;
    }
  }

  Future<List<ContestModel>> getMyConstestList(
      BuildContext context, String matchId, String userId) async {
    var response = await NetworkUtil.callGetApi(
        context: context,
        apiName: ApiConstant.myContest + '?matchId=$matchId&userId=$userId');
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
      BuildContext context, String matchId) async {
    var userModel = await Util.read(Constant.LoginResponse);
    var response = await NetworkUtil.callGetApi(
        context: context,
        apiName: ApiConstant.myContest +
            '?matchId=$matchId&userId=${userModel['Id']}');
    if (response != null) {
      return ContestJoinResponseModel.fromJson(response);
    }
  }

  List<MatchModel> getLiveMatch(BuildContext context) {
    var liveMatch =
        matchList.where((element) => element.status.contains('Live')).toList();
    return liveMatch;
  }

  List<MatchModel> getCompleteMatch(BuildContext context) {
    var completeMatch = matchList
        .where((element) => element.status.contains('Completed'))
        .toList();
    return completeMatch;
  }
}
