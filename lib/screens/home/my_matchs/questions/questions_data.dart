import 'dart:convert';

import 'package:cricquiz11/common_widget/font_style.dart';
import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/question_list_model.dart';
import 'package:cricquiz11/model/update_answer_model.dart';
import 'package:cricquiz11/util/ApiConstant.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
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
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.questionListModel.questions[_questionIndex].title,
                  style: TextStyle(fontSize: 16, color: ColorUtils.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    for (int i = 1;
                        i <=
                            widget.questionListModel.questions[_questionIndex]
                                .questionAnswers.length;
                        i++)
                      ListTile(
                        title: InkWell(
                          onTap: () {
                            if (widget.questionListModel.isEditable) {
                              for (int j = 0;
                                  j <
                                      widget
                                          .questionListModel
                                          .questions[_questionIndex]
                                          .questionAnswers
                                          .length;
                                  j++)
                                widget
                                        .questionListModel
                                        .questions[_questionIndex]
                                        .questionAnswers[j]
                                        .selectedAnswer =
                                    widget
                                        .questionListModel
                                        .questions[_questionIndex]
                                        .questionAnswers[i - 1]
                                        .optionId;
                              setState(() {});
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: widget
                                            .questionListModel
                                            .questions[_questionIndex]
                                            .questionAnswers[i - 1]
                                            .selectedAnswer ==
                                        widget
                                            .questionListModel
                                            .questions[_questionIndex]
                                            .questionAnswers[i - 1]
                                            .optionId
                                    ? ColorUtils.vColor
                                    : Colors.white24,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Text(
                              '${widget.questionListModel.questions[_questionIndex].questionAnswers[i - 1].optionTitle}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
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
                                        : Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ), //Text
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (_questionIndex != 0)
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImageUtils.playButton),
                              ),
                            ),
                            child: TextWidget(
                              text: "Previous",
                              textAlign: TextAlign.center,
                              textSize: 16,
                              color: ColorUtils.white,
                              fontWeight: FontStyles.bold,
                            ) // button text
                            ),
                      ),
                      onTap: () {
                        _questionIndex--;
                        setState(() {});
                      }),
                ),
              SizedBox(
                height: 16,
              ),
              if (_questionIndex !=
                  widget.questionListModel.questions.length - 1)
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImageUtils.playButton),
                              ),
                            ),
                            child: TextWidget(
                              text: "Next",
                              textAlign: TextAlign.center,
                              textSize: 16,
                              color: ColorUtils.white,
                              fontWeight: FontStyles.bold,
                            ) // button text
                            ),
                      ),
                      onTap: () {
                        bool isSelected = false;
                        for (int j = 0;
                            j <
                                widget
                                    .questionListModel
                                    .questions[_questionIndex]
                                    .questionAnswers
                                    .length;
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
                      }),
                ),
              if (_questionIndex ==
                  widget.questionListModel.questions.length - 1)
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImageUtils.playButton),
                              ),
                            ),
                            child: TextWidget(
                              text: "Finish",
                              textAlign: TextAlign.center,
                              textSize: 16,
                              color: ColorUtils.white,
                              fontWeight: FontStyles.bold,
                            ) // button text
                            ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(Strings.appName),
                              content: Text(
                                  "Are you sure you want to submit the answers?"),
                              actions: [
                                FlatButton(
                                  child: Text(Strings.cancel),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(Strings.ok),
                                  onPressed: () {
                                    onQuestionSubmit(context);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }),
                ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> onQuestionSubmit(BuildContext context) async {
    if (!widget.questionListModel.isEditable) {
      Navigator.of(context).pop();
      return;
    }
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
