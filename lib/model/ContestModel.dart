class ContestModel {
  int _matchId;
  String _matchTitle;
  String _tournamentTitle;
  String _startTime;
  Null _endTime;
  String _status;
  String _team1Title;
  String _team1Icon;
  String _team2Title;
  String _team2Icon;

  ContestModel(
      {int matchId,
      String matchTitle,
      String tournamentTitle,
      String startTime,
      Null endTime,
      String status,
      String team1Title,
      String team1Icon,
      String team2Title,
      String team2Icon}) {
    this._matchId = matchId;
    this._matchTitle = matchTitle;
    this._tournamentTitle = tournamentTitle;
    this._startTime = startTime;
    this._endTime = endTime;
    this._status = status;
    this._team1Title = team1Title;
    this._team1Icon = team1Icon;
    this._team2Title = team2Title;
    this._team2Icon = team2Icon;
  }

  int get matchId => _matchId;

  set matchId(int matchId) => _matchId = matchId;

  String get matchTitle => _matchTitle;

  set matchTitle(String matchTitle) => _matchTitle = matchTitle;

  String get tournamentTitle => _tournamentTitle;

  set tournamentTitle(String tournamentTitle) =>
      _tournamentTitle = tournamentTitle;

  String get startTime => _startTime;

  set startTime(String startTime) => _startTime = startTime;

  Null get endTime => _endTime;

  set endTime(Null endTime) => _endTime = endTime;

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
    _matchId = json['MatchId'];
    _matchTitle = json['MatchTitle'];
    _tournamentTitle = json['TournamentTitle'];
    _startTime = json['StartTime'];
    _endTime = json['EndTime'];
    _status = json['Status'];
    _team1Title = json['Team1Title'];
    _team1Icon = json['Team1Icon'];
    _team2Title = json['Team2Title'];
    _team2Icon = json['Team2Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MatchId'] = this._matchId;
    data['MatchTitle'] = this._matchTitle;
    data['TournamentTitle'] = this._tournamentTitle;
    data['StartTime'] = this._startTime;
    data['EndTime'] = this._endTime;
    data['Status'] = this._status;
    data['Team1Title'] = this._team1Title;
    data['Team1Icon'] = this._team1Icon;
    data['Team2Title'] = this._team2Title;
    data['Team2Icon'] = this._team2Icon;
    return data;
  }
}
