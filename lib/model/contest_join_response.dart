class ContestJoinResponseModel {
  int _statusCode;
  String _message;
  ResponsePacket _responsePacket;
  Null _errors;

  ContestJoinResponseModel(
      {int statusCode,
      String message,
      ResponsePacket responsePacket,
      Null errors}) {
    this._statusCode = statusCode;
    this._message = message;
    this._responsePacket = responsePacket;
    this._errors = errors;
  }

  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;
  String get message => _message;
  set message(String message) => _message = message;
  ResponsePacket get responsePacket => _responsePacket;
  set responsePacket(ResponsePacket responsePacket) =>
      _responsePacket = responsePacket;
  Null get errors => _errors;
  set errors(Null errors) => _errors = errors;

  ContestJoinResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['StatusCode'];
    _message = json['Message'];
    _responsePacket = json['ResponsePacket'] != null
        ? new ResponsePacket.fromJson(json['ResponsePacket'])
        : null;
    _errors = json['Errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this._statusCode;
    data['Message'] = this._message;
    if (this._responsePacket != null) {
      data['ResponsePacket'] = this._responsePacket.toJson();
    }
    data['Errors'] = this._errors;
    return data;
  }
}

class ResponsePacket {
  int _contestantId;

  ResponsePacket({int contestantId}) {
    this._contestantId = contestantId;
  }

  int get contestantId => _contestantId;
  set contestantId(int contestantId) => _contestantId = contestantId;

  ResponsePacket.fromJson(Map<String, dynamic> json) {
    _contestantId = json['ContestantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContestantId'] = this._contestantId;
    return data;
  }
}
