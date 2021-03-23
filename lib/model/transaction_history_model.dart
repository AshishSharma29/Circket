class TransactionHistoryModel {
  int _transactionId;
  String _amount;
  double _balance;
  String _transactionDate;
  String _transactionType;
  String _contestName;
  String _refferedBy;

  TransactionHistoryModel(
      {int transactionId,
      String amount,
      double balance,
      String transactionDate,
      String transactionType,
      String contestName,
      String refferedBy}) {
    this._transactionId = transactionId;
    this._amount = amount;
    this._balance = balance;
    this._transactionDate = transactionDate;
    this._transactionType = transactionType;
    this._contestName = contestName;
    this._refferedBy = refferedBy;
  }

  int get transactionId => _transactionId;
  set transactionId(int transactionId) => _transactionId = transactionId;
  String get amount => _amount;
  set amount(String amount) => _amount = amount;
  double get balance => _balance;
  set balance(double balance) => _balance = balance;
  String get transactionDate => _transactionDate;
  set transactionDate(String transactionDate) =>
      _transactionDate = transactionDate;
  String get transactionType => _transactionType;
  set transactionType(String transactionType) =>
      _transactionType = transactionType;
  String get contestName => _contestName;
  set contestName(String contestName) => _contestName = contestName;
  String get refferedBy => _refferedBy;
  set refferedBy(String refferedBy) => _refferedBy = refferedBy;

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    _transactionId = json['TransactionId'];
    _amount = json['Amount'];
    _balance = json['Balance'];
    _transactionDate = json['TransactionDate'];
    _transactionType = json['TransactionType'];
    _contestName = json['ContestName'];
    _refferedBy = json['RefferedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransactionId'] = this._transactionId;
    data['Amount'] = this._amount;
    data['Balance'] = this._balance;
    data['TransactionDate'] = this._transactionDate;
    data['TransactionType'] = this._transactionType;
    data['ContestName'] = this._contestName;
    data['RefferedBy'] = this._refferedBy;
    return data;
  }
}
