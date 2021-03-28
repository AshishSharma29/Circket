import 'dart:convert';

import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/question_list_model.dart';
import 'package:cricquiz11/model/update_answer_model.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/network_util.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionsData extends StatefulWidget {
  QuestionListModel questionListModel;
  String contestantId;

  QuestionsData(this.questionListModel, this.contestantId);

  @override
  _QuestionsDataState createState() => _QuestionsDataState();
}

class _QuestionsDataState extends State<QuestionsData> {
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.question,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.questionListModel.questions[_questionIndex].title,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 8,
              ),
              for (int i = 1;
                  i <=
                      widget.questionListModel.questions[_questionIndex]
                          .questionAnswers.length;
                  i++)
                ListTile(
                  title: Text(
                    '${widget.questionListModel.questions[_questionIndex].questionAnswers[i - 1].optionTitle}',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: widget
                                    .questionListModel
                                    .questions[_questionIndex]
                                    .questionAnswers[i - 1]
                                    .optionId ==
                                widget
                                    .questionListModel
                                    .questions[_questionIndex]
                                    .questionAnswers[i - 1]
                                    .correctAnswer
                            ? ColorUtils.colorPrimary
                            : Colors.black),
                  ),
                  leading: Radio(
                    value: widget.questionListModel.questions[_questionIndex]
                        .questionAnswers[i - 1].optionId,
                    groupValue: widget
                        .questionListModel
                        .questions[_questionIndex]
                        .questionAnswers[i - 1]
                        .selectedAnswer,
                    activeColor: ColorUtils.colorPrimary,
                    onChanged: !widget.questionListModel.isEditable
                        ? null
                        : (int value) {
                            for (int j = 0;
                                j <
                                    widget
                                        .questionListModel
                                        .questions[_questionIndex]
                                        .questionAnswers
                                        .length;
                                j++)
                              widget.questionListModel.questions[_questionIndex]
                                      .questionAnswers[j].selectedAnswer =
                                  widget
                                      .questionListModel
                                      .questions[_questionIndex]
                                      .questionAnswers[i - 1]
                                      .optionId;
                            setState(() {});
                          },
                  ),
                ),
              SizedBox(
                height: 30,
              ),
            ],
          ), //Text
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_questionIndex != 0)
              RaisedButton(
                  color: ColorUtils.colorPrimary,
                  onPressed: () {
                    _questionIndex--;
                    setState(() {});
                  },
                  child: TextWidget(
                    color: ColorUtils.white,
                    text: 'Previous',
                  )),
            if (_questionIndex != widget.questionListModel.questions.length - 1)
              RaisedButton(
                  color: ColorUtils.colorPrimary,
                  onPressed: () {
                    bool isSelected = false;
                    for (int j = 0;
                        j <
                            widget.questionListModel.questions[_questionIndex]
                                .questionAnswers.length;
                        j++) {
                      if (widget.questionListModel.questions[_questionIndex]
                              .questionAnswers[j].selectedAnswer !=
                          0) {
                        isSelected = true;
                        break;
                      }
                    }
                    if (!isSelected) {
                      Util.showValidationdialog(
                          context, "Please select an option to continue");
                      return;
                    }
                    _questionIndex++;
                    setState(() {});
                  },
                  child: TextWidget(
                    color: ColorUtils.white,
                    text: 'Next',
                  )),
            if (_questionIndex == widget.questionListModel.questions.length - 1)
              RaisedButton(
                  color: ColorUtils.colorPrimary,
                  onPressed: () {
                    onQuestionSubmit(context);

                    Navigator.of(context).pop();
                  },
                  child: TextWidget(
                    color: ColorUtils.white,
                    text: 'Finish',
                  )),
          ],
        )
      ],
    ));
  }

  Future<void> onQuestionSubmit(BuildContext context) async {
    List<UpdateAnswerModel> updateAnswerModels = List();
    for (int questionNumber = 0;
        questionNumber < widget.questionListModel.questions.length;
        questionNumber++) {
      UpdateAnswerModel updateAnswerModel = UpdateAnswerModel();
      updateAnswerModel.contestantId = int.parse(widget.contestantId);
      updateAnswerModel.questionId =
          widget.questionListModel.questions[questionNumber].id;
      for (int option = 0;
          option <
              widget.questionListModel.questions[questionNumber].questionAnswers
                  .length;
          option++) {
        if (widget.questionListModel.questions[questionNumber]
                .questionAnswers[option].selectedAnswer !=
            0) {
          updateAnswerModel.optionId = widget.questionListModel
              .questions[questionNumber].questionAnswers[option].selectedAnswer;
          break;
        }
      }
      updateAnswerModels.add(updateAnswerModel);
    }

    var response = await NetworkUtil.callPostApi(
        context: context,
        apiName: ApiConstant.updateAnswer,
        requestBody: {
          'ContestAnswers': jsonDecode(jsonEncode(updateAnswerModels))
        });
    if (response != null) {
      Fluttertoast.showToast(
          msg: response['ResponsePacket']['Message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
    }
  }
}
