class LoginResponseModel {
  int _id;
  String _name;
  String _mobileNo;
  String _email;
  Null _dOB;
  bool _isActive;
  bool _isDeleted;
  String _createdOn;

  LoginResponseModel(
      {int id,
      String name,
      String mobileNo,
      String email,
      Null dOB,
      bool isActive,
      bool isDeleted,
      String createdOn}) {
    this._id = id;
    this._name = name;
    this._mobileNo = mobileNo;
    this._email = email;
    this._dOB = dOB;
    this._isActive = isActive;
    this._isDeleted = isDeleted;
    this._createdOn = createdOn;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get mobileNo => _mobileNo;
  set mobileNo(String mobileNo) => _mobileNo = mobileNo;
  String get email => _email;
  set email(String email) => _email = email;
  Null get dOB => _dOB;
  set dOB(Null dOB) => _dOB = dOB;
  bool get isActive => _isActive;
  set isActive(bool isActive) => _isActive = isActive;
  bool get isDeleted => _isDeleted;
  set isDeleted(bool isDeleted) => _isDeleted = isDeleted;
  String get createdOn => _createdOn;
  set createdOn(String createdOn) => _createdOn = createdOn;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _mobileNo = json['MobileNo'];
    _email = json['Email'];
    _dOB = json['DOB'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _createdOn = json['CreatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['Name'] = this._name;
    data['MobileNo'] = this._mobileNo;
    data['Email'] = this._email;
    data['DOB'] = this._dOB;
    data['IsActive'] = this._isActive;
    data['IsDeleted'] = this._isDeleted;
    data['CreatedOn'] = this._createdOn;
    return data;
  }
}
