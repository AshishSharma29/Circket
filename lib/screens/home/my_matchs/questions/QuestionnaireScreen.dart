import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/question_list_model.dart';
import 'package:cricquiz11/screens/home/my_matchs/questions/questions_data.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/image_strings.dart';
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
      body: Stack(
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
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
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
                    fontWeight: FontStyles.bold,
                    text: widget.argument['contestTitle'],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              FutureBuilder<QuestionListModel>(
                future: _getQuestionList(),
                builder: (context, snapshot) {
                  if (snapshot.data == null)
                    return Center(child: Util().getLoader());
                  return Expanded(
                    flex: 1,
                    child: QuestionsData(
                        snapshot.data, widget.argument['contestId']),
                  );
                },
              ),
            ],
          ),
        ],
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
