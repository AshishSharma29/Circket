class LoginResponseModel {
  String _id;
  String _name;
  String _mobileNo;
  String _email;
  String _dOB;
  String _referralCode;
  double _balance;

  LoginResponseModel(
      {String id,
      String name,
      String mobileNo,
      String email,
      String dOB,
      String referralCode,
      double balance}) {
    this._id = id;
    this._name = name;
    this._mobileNo = mobileNo;
    this._email = email;
    this._dOB = dOB;
    this._referralCode = referralCode;
    this._balance = balance;
  }

  String get id => _id;

  set id(String id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  String get mobileNo => _mobileNo;

  set mobileNo(String mobileNo) => _mobileNo = mobileNo;

  String get email => _email;

  set email(String email) => _email = email;

  String get dOB => _dOB;

  set dOB(String dOB) => _dOB = dOB;

  String get referralCode => _referralCode;

  set referralCode(String referralCode) => _referralCode = referralCode;

  double get balance => _balance;

  set balance(double balance) => _balance = balance;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'].toString();
    _name = json['Name'];
    _mobileNo = json['MobileNo'];
    _email = json['Email'];
    _dOB = json['DOB'];
    _referralCode = json['ReferralCode'];
    _balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id.toString();
    data['Name'] = this._name;
    data['MobileNo'] = this._mobileNo;
    data['Email'] = this._email;
    data['DOB'] = this._dOB == null ? '' : this._dOB;
    data['ReferralCode'] = this._referralCode;
    data['Balance'] = this._balance.toString();
    return data;
  }
}
