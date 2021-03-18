class UpdateAnswerModel {
  int _contestantId;
  int _questionId;
  int _optionId;

  UpdateAnswerModel({int contestantId, int questionId, int optionId}) {
    this._contestantId = contestantId;
    this._questionId = questionId;
    this._optionId = optionId;
  }

  int get contestantId => _contestantId;
  set contestantId(int contestantId) => _contestantId = contestantId;
  int get questionId => _questionId;
  set questionId(int questionId) => _questionId = questionId;
  int get optionId => _optionId;
  set optionId(int optionId) => _optionId = optionId;

  UpdateAnswerModel.fromJson(Map<String, dynamic> json) {
    _contestantId = json['ContestantId'];
    _questionId = json['QuestionId'];
    _optionId = json['OptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContestantId'] = this._contestantId;
    data['QuestionId'] = this._questionId;
    data['OptionId'] = this._optionId;
    return data;
  }
}
