class AccountDetailModel {
  int _id;
  int _userId;
  String _accountHolderName;
  String _accountNumber;
  String _iFSCCode;
  String _bankName;
  String _bankBranch;
  String _state;
  bool _isVerified = false;

  AccountDetailModel(
      {int id,
      int userId,
      String accountHolderName,
      String accountNumber,
      String iFSCCode,
      String bankName,
      String bankBranch,
      String state,
      bool isVerified}) {
    this._id = id;
    this._userId = userId;
    this._accountHolderName = accountHolderName;
    this._accountNumber = accountNumber;
    this._iFSCCode = iFSCCode;
    this._bankName = bankName;
    this._bankBranch = bankBranch;
    this._state = state;
    this._isVerified = isVerified;
  }

  int get id => _id;

  set id(int id) => _id = id;

  int get userId => _userId;

  set userId(int userId) => _userId = userId;

  String get accountHolderName => _accountHolderName;

  set accountHolderName(String accountHolderName) =>
      _accountHolderName = accountHolderName;

  String get accountNumber => _accountNumber;

  set accountNumber(String accountNumber) => _accountNumber = accountNumber;

  String get iFSCCode => _iFSCCode;

  set iFSCCode(String iFSCCode) => _iFSCCode = iFSCCode;

  String get bankName => _bankName;

  set bankName(String bankName) => _bankName = bankName;

  String get bankBranch => _bankBranch;

  set bankBranch(String bankBranch) => _bankBranch = bankBranch;

  String get state => _state;

  set state(String state) => _state = state;

  bool get isVerified => _isVerified;

  set isVerified(bool isVerified) => _isVerified = isVerified;

  AccountDetailModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _userId = json['UserId'];
    _accountHolderName = json['AccountHolderName'];
    _accountNumber = json['AccountNumber'];
    _iFSCCode = json['IFSCCode'];
    _bankName = json['BankName'];
    _bankBranch = json['BankBranch'];
    _state = json['State'];
    _isVerified = json['IsVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['UserId'] = this._userId;
    data['AccountHolderName'] = this._accountHolderName;
    data['AccountNumber'] = this._accountNumber;
    data['IFSCCode'] = this._iFSCCode;
    data['BankName'] = this._bankName;
    data['BankBranch'] = this._bankBranch;
    data['State'] = this._state;
    data['IsVerified'] = this._isVerified;
    return data;
  }
}
