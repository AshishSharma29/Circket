import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/question_list_model.dart';
import 'package:cricquiz11/screens/home/my_matchs/questions/questions_data.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatefulWidget {
  Map<String, String> argument;

  QuestionnaireScreen(this.argument);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: widget.argument['contestTitle'],
          color: ColorUtils.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<QuestionListModel>(
            future: _getQuestionList(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(child: Util().getLoader());
              return QuestionsData(snapshot.data, widget.argument['contestId']);
            },
          ),
        ),
      ),
    );
  }

  Future<QuestionListModel> _getQuestionList() async {
    var userModel = await Util.read(Constant.LoginResponse);
    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.getAllQuestions,
        requestBody: {
          "ContestantId": widget.argument['contestId'],
          "UserId": userModel['Id'].toString()
        }
        /*{"ContestantId": "11", "UserId": "2"}*/);
    if (response['ResponsePacket'] != null) {
      print(response['ResponsePacket']);
      var questions = QuestionListModel.fromJson(response['ResponsePacket']);
      return questions;
    }
  }
}
