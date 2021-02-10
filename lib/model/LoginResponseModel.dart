class LoginResponseModel {
  int _id;
  String _name;
  String _mobileNo;
  String _email;
  String _dOB;
  String _referralCode;
  int _balance;

  LoginResponseModel(
      {int id,
        String name,
        String mobileNo,
        String email,
        String dOB,
        String referralCode,
        int balance}) {
    this._id = id;
    this._name = name;
    this._mobileNo = mobileNo;
    this._email = email;
    this._dOB = dOB;
    this._referralCode = referralCode;
    this._balance = balance;
  }

  int get id => _id;
  set id(int id) => _id = id;
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
  int get balance => _balance;
  set balance(int balance) => _balance = balance;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _mobileNo = json['MobileNo'];
    _email = json['Email'];
    _dOB = json['DOB'];
    _referralCode = json['ReferralCode'];
    _balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['Name'] = this._name;
    data['MobileNo'] = this._mobileNo;
    data['Email'] = this._email;
    data['DOB'] = this._dOB;
    data['ReferralCode'] = this._referralCode;
    data['Balance'] = this._balance;
    return data;
  }
}
