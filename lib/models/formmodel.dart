class FormDataModel {
  
  String _name;
  String _email;
  String _password;

  String get name => _name;
  String get email => _email;
  String get password => _password;

  set name(String newName) {
    _name = newName;
  }
  set email(String newEmail) {
    _email = newEmail;
  }
  set password(String newPassword) {
    _password = newPassword;
  }

  FormDataModel(this._name,this._email,this._password);
}