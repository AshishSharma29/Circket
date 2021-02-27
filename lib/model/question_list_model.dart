class QuestionListModel {
  List<QuestionList> _questionList;

  QuestionListModel({List<QuestionList> questionList}) {
    this._questionList = questionList;
  }

  List<QuestionList> get questionList => _questionList;
  set questionList(List<QuestionList> questionList) =>
      _questionList = questionList;

  QuestionListModel.fromJson(Map<String, dynamic> json) {
    if (json['QuestionList'] != null) {
      _questionList = new List<QuestionList>();
      json['QuestionList'].forEach((v) {
        _questionList.add(new QuestionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._questionList != null) {
      data['QuestionList'] = this._questionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionList {
  int _id;
  String _question;
  String _selectionType;
  List<String> _options;
  String _selectedOption;

  QuestionList(
      {int id,
        String question,
        String selectionType,
        List<String> options,
        String selectedOption}) {
    this._id = id;
    this._question = question;
    this._selectionType = selectionType;
    this._options = options;
    this._selectedOption = selectedOption;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get question => _question;
  set question(String question) => _question = question;
  String get selectionType => _selectionType;
  set selectionType(String selectionType) => _selectionType = selectionType;
  List<String> get options => _options;
  set options(List<String> options) => _options = options;
  String get selectedOption => _selectedOption;
  set selectedOption(String selectedOption) => _selectedOption = selectedOption;

  QuestionList.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _question = json['Question'];
    _selectionType = json['SelectionType'];
    _options = json['Options'].cast<String>();
    _selectedOption = json['SelectedOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['Question'] = this._question;
    data['SelectionType'] = this._selectionType;
    data['Options'] = this._options;
    data['SelectedOption'] = this._selectedOption;
    return data;
  }
}
