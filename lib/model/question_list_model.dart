class QuestionListModel {
  int _id;
  int _matchId;
  Null _title;
  int _optionId;
  Null _optionTitle;
  int _contestantId;
  bool _isEditable;
  int _correctAnswer;
  int _selectedAnswer;
  List<Questions> _questions;

  QuestionListModel(
      {int id,
        int matchId,
        Null title,
        int optionId,
        Null optionTitle,
        int contestantId,
        bool isEditable,
        int correctAnswer,
        int selectedAnswer,
        List<Questions> questions}) {
    this._id = id;
    this._matchId = matchId;
    this._title = title;
    this._optionId = optionId;
    this._optionTitle = optionTitle;
    this._contestantId = contestantId;
    this._isEditable = isEditable;
    this._correctAnswer = correctAnswer;
    this._selectedAnswer = selectedAnswer;
    this._questions = questions;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get matchId => _matchId;
  set matchId(int matchId) => _matchId = matchId;
  Null get title => _title;
  set title(Null title) => _title = title;
  int get optionId => _optionId;
  set optionId(int optionId) => _optionId = optionId;
  Null get optionTitle => _optionTitle;
  set optionTitle(Null optionTitle) => _optionTitle = optionTitle;
  int get contestantId => _contestantId;
  set contestantId(int contestantId) => _contestantId = contestantId;
  bool get isEditable => _isEditable;
  set isEditable(bool isEditable) => _isEditable = isEditable;
  int get correctAnswer => _correctAnswer;
  set correctAnswer(int correctAnswer) => _correctAnswer = correctAnswer;
  int get selectedAnswer => _selectedAnswer;
  set selectedAnswer(int selectedAnswer) => _selectedAnswer = selectedAnswer;
  List<Questions> get questions => _questions;
  set questions(List<Questions> questions) => _questions = questions;

  QuestionListModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _matchId = json['MatchId'];
    _title = json['Title'];
    _optionId = json['OptionId'];
    _optionTitle = json['OptionTitle'];
    _contestantId = json['ContestantId'];
    _isEditable = json['IsEditable'];
    _correctAnswer = json['CorrectAnswer'];
    _selectedAnswer = json['SelectedAnswer'];
    if (json['Questions'] != null) {
      _questions = new List<Questions>();
      json['Questions'].forEach((v) {
        _questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['MatchId'] = this._matchId;
    data['Title'] = this._title;
    data['OptionId'] = this._optionId;
    data['OptionTitle'] = this._optionTitle;
    data['ContestantId'] = this._contestantId;
    data['IsEditable'] = this._isEditable;
    data['CorrectAnswer'] = this._correctAnswer;
    data['SelectedAnswer'] = this._selectedAnswer;
    if (this._questions != null) {
      data['Questions'] = this._questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int _id;
  int _matchId;
  String _title;
  List<QuestionAnswers> _questionAnswers;

  Questions(
      {int id,
        int matchId,
        String title,
        List<QuestionAnswers> questionAnswers}) {
    this._id = id;
    this._matchId = matchId;
    this._title = title;
    this._questionAnswers = questionAnswers;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get matchId => _matchId;
  set matchId(int matchId) => _matchId = matchId;
  String get title => _title;
  set title(String title) => _title = title;
  List<QuestionAnswers> get questionAnswers => _questionAnswers;
  set questionAnswers(List<QuestionAnswers> questionAnswers) =>
      _questionAnswers = questionAnswers;

  Questions.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _matchId = json['MatchId'];
    _title = json['Title'];
    if (json['QuestionAnswers'] != null) {
      _questionAnswers = new List<QuestionAnswers>();
      json['QuestionAnswers'].forEach((v) {
        _questionAnswers.add(new QuestionAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['MatchId'] = this._matchId;
    data['Title'] = this._title;
    if (this._questionAnswers != null) {
      data['QuestionAnswers'] =
          this._questionAnswers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionAnswers {
  int _optionId;
  String _optionTitle;
  int _contestantId;
  int _correctAnswer;
  int _selectedAnswer;

  QuestionAnswers(
      {int optionId,
        String optionTitle,
        int contestantId,
        int correctAnswer,
        int selectedAnswer}) {
    this._optionId = optionId;
    this._optionTitle = optionTitle;
    this._contestantId = contestantId;
    this._correctAnswer = correctAnswer;
    this._selectedAnswer = selectedAnswer;
  }

  int get optionId => _optionId;
  set optionId(int optionId) => _optionId = optionId;
  String get optionTitle => _optionTitle;
  set optionTitle(String optionTitle) => _optionTitle = optionTitle;
  int get contestantId => _contestantId;
  set contestantId(int contestantId) => _contestantId = contestantId;
  int get correctAnswer => _correctAnswer;
  set correctAnswer(int correctAnswer) => _correctAnswer = correctAnswer;
  int get selectedAnswer => _selectedAnswer;
  set selectedAnswer(int selectedAnswer) => _selectedAnswer = selectedAnswer;

  QuestionAnswers.fromJson(Map<String, dynamic> json) {
    _optionId = json['OptionId'];
    _optionTitle = json['OptionTitle'];
    _contestantId = json['ContestantId'];
    _correctAnswer = json['CorrectAnswer'];
    _selectedAnswer = json['SelectedAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OptionId'] = this._optionId;
    data['OptionTitle'] = this._optionTitle;
    data['ContestantId'] = this._contestantId;
    data['CorrectAnswer'] = this._correctAnswer;
    data['SelectedAnswer'] = this._selectedAnswer;
    return data;
  }
}
