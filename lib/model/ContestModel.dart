class ContestModel {
  int _id;
  int _matchId;
  double _entryFee;
  double _prize;
  int _maxEntry;
  int _maxWinner;
  String _matchTitle;
  String _result;
  String _totalPoint;
  String _tournamentTitle;
  String _startTime;
  String _endTime;
  String _status;
  String _team1Title;
  String _team1Icon;
  String _team2Title;
  String _team2Icon;

  ContestModel(
      {int id,
      int matchId,
      double entryFee,
      double prize,
      int maxEntry,
      int maxWinner,
      String matchTitle,
      String result,
      String tournamentTitle,
      String startTime,
      String endTime,
      String status,
      String team1Title,
      String team1Icon,
      String team2Title,
      String totalPoint,
      String team2Icon}) {
    this._id = id;
    this._matchId = matchId;
    this._entryFee = entryFee;
    this._prize = prize;
    this._maxEntry = maxEntry;
    this._result = result;
    this._maxWinner = maxWinner;
    this._matchTitle = matchTitle;
    this._tournamentTitle = tournamentTitle;
    this._startTime = startTime;
    this._endTime = endTime;
    this._status = status;
    this._totalPoint = totalPoint;
    this._team1Title = team1Title;
    this._team1Icon = team1Icon;
    this._team2Title = team2Title;
    this._team2Icon = team2Icon;
  }

  String get totalPoint => _totalPoint;

  set totalPoint(String value) {
    _totalPoint = value;
  }

  int get id => _id;

  set id(int id) => _id = id;

  int get matchId => _matchId;

  set matchId(int matchId) => _matchId = matchId;

  double get entryFee => _entryFee;

  set entryFee(double entryFee) => _entryFee = entryFee;

  double get prize => _prize;

  set prize(double prize) => _prize = prize;

  int get maxEntry => _maxEntry;

  set maxEntry(int maxEntry) => _maxEntry = maxEntry;

  int get maxWinner => _maxWinner;

  set maxWinner(int maxWinner) => _maxWinner = maxWinner;

  String get matchTitle => _matchTitle;

  set matchTitle(String matchTitle) => _matchTitle = matchTitle;

  String get result => _result;

  set result(String matchTitle) => _result = result;

  String get tournamentTitle => _tournamentTitle;

  set tournamentTitle(String tournamentTitle) =>
      _tournamentTitle = tournamentTitle;

  String get startTime => _startTime;

  set startTime(String startTime) => _startTime = startTime;

  String get endTime => _endTime;

  set endTime(String endTime) => _endTime = endTime;

  String get status => _status;

  set status(String status) => _status = status;

  String get team1Title => _team1Title;

  set team1Title(String team1Title) => _team1Title = team1Title;

  String get team1Icon => _team1Icon;

  set team1Icon(String team1Icon) => _team1Icon = team1Icon;

  String get team2Title => _team2Title;

  set team2Title(String team2Title) => _team2Title = team2Title;

  String get team2Icon => _team2Icon;

  set team2Icon(String team2Icon) => _team2Icon = team2Icon;

  ContestModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _matchId = json['MatchId'];
    _entryFee = json['EntryFee'];
    _prize = json['Prize'];
    _maxEntry = json['MaxEntry'];
    _maxWinner = json['MaxWinner'];
    _matchTitle = json['MatchTitle'];
    _tournamentTitle = json['TournamentTitle'];
    _startTime = json['StartTime'];
    _endTime = json['EndTime'];
    _status = json['Status'];
    _team1Title = json['Team1Title'];
    _team1Icon = json['Team1Icon'];
    _team2Title = json['Team2Title'];
    _team2Icon = json['Team2Icon'];
    _totalPoint = json['TotalPoint'].toString();
    _result = json['Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['MatchId'] = this._matchId;
    data['EntryFee'] = this._entryFee;
    data['Prize'] = this._prize;
    data['MaxEntry'] = this._maxEntry;
    data['MaxWinner'] = this._maxWinner;
    data['MatchTitle'] = this._matchTitle;
    data['Result'] = this._result;
    data['TournamentTitle'] = this._tournamentTitle;
    data['StartTime'] = this._startTime;
    data['EndTime'] = this._endTime;
    data['Status'] = this._status;
    data['TotalPoint'] = this._totalPoint;
    data['Team1Title'] = this._team1Title;
    data['Team1Icon'] = this._team1Icon;
    data['Team2Title'] = this._team2Title;
    data['Team2Icon'] = this._team2Icon;
    return data;
  }
}
