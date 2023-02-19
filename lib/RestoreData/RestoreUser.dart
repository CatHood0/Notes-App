class user {

  int _id;
  String _name;
  String _password;
  DateTime _firstRegister;
  bool? _payForTheBackupDB;

  user(this._id, this._name, this._password, this._firstRegister, [this._payForTheBackupDB]);

  String get Name{
    return _name;
  }

  int get ID{
    return _id;
  }

  String get Password{
    return _password;
  }

  DateTime get timeRegister{
      return _firstRegister;
  }

  bool get isUserPayBackup{
    return _payForTheBackupDB!;
  }

  void set newName(String nName){
      _name = nName;
  }

  void set newPassword(String pass){
      _password = pass;
  }

}