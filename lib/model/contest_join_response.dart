class ContestJoinResponseModel {
  int _statusCode;
  String _message;
  Null _responsePacket;
  Null _errors;

  ContestJoinResponseModel(
      {int statusCode, String message, Null responsePacket, Null errors}) {
    this._statusCode = statusCode;
    this._message = message;
    this._responsePacket = responsePacket;
    this._errors = errors;
  }

  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;
  String get message => _message;
  set message(String message) => _message = message;
  Null get responsePacket => _responsePacket;
  set responsePacket(Null responsePacket) => _responsePacket = responsePacket;
  Null get errors => _errors;
  set errors(Null errors) => _errors = errors;

  ContestJoinResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['StatusCode'];
    _message = json['Message'];
    _responsePacket = json['ResponsePacket'];
    _errors = json['Errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this._statusCode;
    data['Message'] = this._message;
    data['ResponsePacket'] = this._responsePacket;
    data['Errors'] = this._errors;
    return data;
  }
}
