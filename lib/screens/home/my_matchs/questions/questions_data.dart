import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/model/question_list_model.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionsData extends StatefulWidget {
  QuestionListModel questionListModel;

  QuestionsData(this.questionListModel);

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
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                widget.questionListModel.questions[_questionIndex].title,
                style: TextStyle(fontSize: 16),
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
                        color: i == 5 ? Colors.black38 : Colors.black),
                  ),
                  leading: Radio(
                    value: i,
                    groupValue: widget
                        .questionListModel
                        .questions[_questionIndex]
                        .questionAnswers[i - 1]
                        .selectedAnswer,
                    activeColor: ColorUtils.colorPrimary,
                    onChanged: widget.questionListModel.isEditable
                        ? i == 5
                            ? null
                            : (int value) {
                                setState(() {
                                  widget
                                      .questionListModel
                                      .questions[_questionIndex]
                                      .questionAnswers[i - 1]
                                      .selectedAnswer = value;
                                });
                              }
                        : null,
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
                    _questionIndex++;
                    setState(() {});
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
}
